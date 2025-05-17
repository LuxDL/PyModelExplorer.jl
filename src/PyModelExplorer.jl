module PyModelExplorer

using PythonCall: PythonCall, Py, pyimport

const model_explorer = Ref{Py}()

function __init__()
    model_explorer[] = pyimport("model_explorer")
    return nothing
end

const DEFAULT_HOST = "localhost"
const DEFAULT_PORT = 8080
const DEFAULT_COLAB_HEIGHT = 850

const BACKGROUND_TASKS = Task[]

function vizualize(
    model_paths::Union{String,Vector{String}}=String[];
    host::String=DEFAULT_HOST,
    port::Int=DEFAULT_PORT,
    extensions::Vector{String}=String[],
    colab_height::Int=DEFAULT_COLAB_HEIGHT,
    reuse_server::Bool=false,
    reuse_server_host::String=DEFAULT_HOST,
    reuse_server_port::Union{Int,Nothing}=nothing,
    # node_data: Union[NodeDataInfo, list[NodeDataInfo]] = [],
)
    # XXX: we might need to launch the server on julia side, else hard to kill it &
    #      we crash python on retry
    return model_explorer[].visualize(;
        model_paths,
        host,
        port,
        extensions,
        colab_height,
        reuse_server,
        reuse_server_host,
        reuse_server_port,
    )
end

export vizualize

end
