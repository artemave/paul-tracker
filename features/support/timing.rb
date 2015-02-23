module Timing
  include Anticipate

  def soon
    sleeping(0.1).seconds.between_tries.failing_after(20).tries do
      yield
    end
  end
end

World Timing
