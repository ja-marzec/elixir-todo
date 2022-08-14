defmodule LiveViewTodosWeb.TodoLive do
  use LiveViewTodosWeb, :live_view
  alias LiveViewTodos.Todos


  def mount(_params, _session, socket) do
    {:ok, fetch(socket)}
  end


  def handle_event("add", %{"todo" => todo}, socket) do
    Todos.create_todo(todo)
    {:noreply, fetch(socket)}
  end

  def handle_event("remove", %{"id" => id},  socket) do
    todo = Todos.get_todo!(id)
    Todos.delete_todo(todo)
    {:noreply, fetch(socket)}
  end

  def handle_event("toggle_done", %{"id" => id},  socket) do
    todo = Todos.get_todo!(id)
    Todos.update_todo(todo, %{done: !todo.done})
    {:noreply, fetch(socket)}
  end
;
  defp fetch(socket) do
    done_tasks = Enum.filter(Todos.list_todos(), fn(x) -> x.done == true end)
    assign(socket, todos: Todos.list_todos(), great_job_visible: length(done_tasks) > 5)
  end

end
