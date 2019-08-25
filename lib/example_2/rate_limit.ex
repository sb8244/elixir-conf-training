defmodule Example2.RateLimit do
  alias Example2.RateLimit.Server

  defdelegate cas_rate_limit(), to: Server
  defdelegate cas_rate_limit(opts), to: Server
end
