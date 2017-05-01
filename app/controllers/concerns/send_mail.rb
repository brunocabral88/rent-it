module SendMail

  extend ActiveSupport::Concern

  def send_email_message_deposit_rentee(rental)
    require 'mailgun'
    # byebug
    # First, instantiate the Mailgun Client with your API key
    mg_client = Mailgun::Client.new (ENV['MAIL_GUN_KEY'])

    message = '<h1>Reciept</h1>
                <table>
                  <tr>
                    <th>Tool Name</th>'

    rental.tools.each do |tool|
      message += "<td>#{tool.name}</td>"
    end
    message += "</tr>
                <tr>
                <th>Rental Starting Date</th>"
    rental.tools.each do |tool|
      message += "<td>#{rental.start_date}</td>"
    end
    message += "</tr>
                <tr>
                <th>Rental End Date</th>"
    rental.tools.each do |tool|
      message += "<td>#{rental.end_date}</td>"
    end
    message += "</tr>
                <tr>
                <th>Deposit</th>"
    rental.tools.each do |tool|
      message += "<td>#{tool.deposit_cents/100.00}$</td>"
    end
    message += "</tr>
                <tr>
                <th>Daily Rate</th>"
    rental.tools.each do |tool|
      message += "<td>#{tool.daily_rate_cents/100.00}$</td>"
    end
    message += "</tr>
                <tr>
                <th>Rental Duration</th>"
    rental.tools.each do |tool|
      message += "<td>#{(rental.end_date - rental.start_date).to_i}</td>"
    end
    message += "</tr>
                <tr>
                <th>Total Payment</th>"
    rental.tools.each do |tool|
      message += "<td>#{tool.daily_rate_cents/100.00 * (rental.end_date - rental.start_date).to_i}$</td>"
    end
    message += "</tr>
                <tr>
                </table>"
    # Define your message parameters
    message_params =  { from: 'gh.sadooghi@sandbox938ba7294b8648d0bc2f4194d20b4efe.mailgun.org',
      to:   'gh.sadooghi@yahoo.com',
      subject: "the reservation number #{rental.id} was done successfully",
      html:  message
    }

    # Send your message through the client
    mg_client.send_message 'sandbox938ba7294b8648d0bc2f4194d20b4efe.mailgun.org', message_params
  end

  def send_email_message_refund_rentee(rental)
    require 'mailgun'
    # byebug
    # First, instantiate the Mailgun Client with your API key
    mg_client = Mailgun::Client.new (ENV['MAIL_GUN_KEY'])


    # Define your message parameters
    message_params =  { from: 'gh.sadooghi@sandbox938ba7294b8648d0bc2f4194d20b4efe.mailgun.org',
      to:   'gh.sadooghi@yahoo.com',
      subject: "Your return was successfully processed",
      html:  "your return was accepted buy the owner and you got #{refund_amount(rental)/100.00}$ back from your deposit money"
    }

    # Send your message through the client
    mg_client.send_message 'sandbox938ba7294b8648d0bc2f4194d20b4efe.mailgun.org', message_params
  end

  def send_email_message_rented_owner(rental)
    require 'mailgun'
    # byebug
    # First, instantiate the Mailgun Client with your API key
    mg_client = Mailgun::Client.new (ENV['MAIL_GUN_KEY'])
    tools_names = ""
    rental.tools.each do |tool|
      tools_names += "<td>#{tool.name}</td>,"
    end

    # Define your message parameters
    message_params =  { from: 'gh.sadooghi@sandbox938ba7294b8648d0bc2f4194d20b4efe.mailgun.org',
      to:   'gh.sadooghi@gmail.com',
      subject: "Your return was successfully processed",
      html:  "your #{tools_names} were booked for lending by #{rental.renter.name} from #{rental.start_date} to #{rental.end_date}."
    }

    # Send your message through the client
    mg_client.send_message 'sandbox938ba7294b8648d0bc2f4194d20b4efe.mailgun.org', message_params
  end

end