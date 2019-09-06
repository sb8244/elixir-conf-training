defmodule Example1Web do
  def controller do
    quote do
      use Phoenix.Controller, namespace: Example1Web

      import Plug.Conn
      import Example1Web.Gettext
      import Phoenix.LiveView.Controller, only: [live_render: 3]
      alias Example1Web.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/example_1_web/templates",
        namespace: Example1Web

      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      use Phoenix.HTML

      import Example1Web.ErrorHelpers
      import Example1Web.Gettext
      import Phoenix.LiveView, only: [live_render: 2, live_render: 3, live_link: 1, live_link: 2]
      alias Example1Web.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import Example1Web.Gettext
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
