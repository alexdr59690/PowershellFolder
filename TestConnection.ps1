function TestConnection
{
    $TestConnection = Test-NetConnection -TraceRoute www.google.fr
    write-output $TestConnection.PingSucceeded
}
