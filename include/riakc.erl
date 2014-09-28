%% Which client operation the default timeout is being requested
%% for. `timeout' is the global default timeout. Any of these defaults
%% can be overridden by setting the application environment variable
%% of the same name on the `riakc' application, for example:
%% `application:set_env(riakc, ping_timeout, 5000).'
-record(request, {ref :: reference(),
                  msg :: rpb_req(),
                  from,
                  ctx :: ctx(),
                  timeout :: timeout(),
                  tref :: reference() | undefined }).

%% The TCP port number of the Riak node's Protocol Buffers interface
-type portnum() :: non_neg_integer().
%% The TCP/IP host name or address of the Riak node
-type address() :: string() | atom() | inet:ip_address().
-record(state, {address :: address(),   % address to connect to
                port :: portnum(),      % port to connect to
                auto_reconnect = false :: boolean(), % if true, automatically
                                        % reconnects to server if false, exits
                                        % on connection failure/request timeout
                % if true, add requests to queue if disconnected
                queue_if_disconnected = false :: boolean(),
                sock :: port() | ssl:sslsocket(),       % gen_tcp socket
                % if true, enabled TCP keepalive for the socket
                keepalive = false :: boolean(),
                transport = gen_tcp :: 'gen_tcp' | 'ssl',
                active :: #request{} | undefined,     % active request
                queue :: queue() | undefined,      % queue of pending requests
                connects=0 :: non_neg_integer(), % number of scsfl connects
                failed=[] :: [connection_failure()], % breakdown of fail conns
                connect_timeout=infinity :: timeout(), % timeout of TCP conn
                credentials :: undefined | {string(), string()}, % user/pass
                cacertfile,    % Path to CA certificate file
                certfile,      % Path to client certificate file, when using
                               % certificate authentication
                keyfile,       % Path to certificate keyfile, when using
                               % certificate authentication
                ssl_opts = [], % Arbitrary SSL options, see the erlang SSL
                               % documentation.
                reconnect_interval=?FIRST_RECONNECT_INTERVAL :: non_neg_integer()}).
