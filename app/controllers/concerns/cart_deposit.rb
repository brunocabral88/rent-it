module CartDeposit
  extend ActiveSupport::Concern

  def cart_deposit(tools)
    total = 0
    tools.each do |tool_id|
      if t = Tool.find_by(id: tool_id)
        total += t.deposit_cents.to_i
      end
    end
    total
  end
end