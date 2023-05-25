function TestConnection
{
    $Connection = Test-NetConnection -TraceRoute www.google.fr

    $rst = @{$True="True";$False="False"}[$Connection.PingSucceeded -eq "True"]
    
    return $rst
}