Message-ID: <4F45126D.9090208@...515...>
Date: Wed, 22 Feb 2012 18:06:05 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4F438CF2.1060305@...515...>
	<CAEsd45Rw5nYYuMMq_Qy_5tQYagZh+EMHM+2Nugod1_1s-BHthA@...278...>
In-Reply-To: <CAEsd45Rw5nYYuMMq_Qy_5tQYagZh+EMHM+2Nugod1_1s-BHthA@...278...>
Content-Type: multipart/alternative;
	boundary="------------000305030209010500030105"
Subject: Re: [Openvpn-devel] OpenVPN 2.3-alpha1 preview 1 installer now
	available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000305030209010500030105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Jonathan,

This does not really address the issue you're having, but could you try
if using Alon's new buildsystem helps:

<https://github.com/alonbl/openvpn/downloads>

You need to copy the "generic" directory to OpenVPN source directory, cd
to it and do a ./build. There's some additional info in the README file.

I used it earlier today successfully to compile native + 32/64-bit
Windows binaries on Ubuntu 11.10. It should also work fine on MacOS X if
all dependencies are in place:

<http://thread.gmane.org/gmane.network.openvpn.devel/5527>

Samuli


>> A preview of OpenVPN 2.3-alpha1 installer for Windows is now available
>> here:
>>
>> <http://build.openvpn.net/downloads/snapshots/openvpn-2.3-alpha1-preview1-install.exe>
> I realize that this post was aimed at Windows, but building on OS X
> 10.6.8 (for Tunnelblick) fails with the following:
>
> gcc-4.0 -DHAVE_CONFIG_H -I. -I../.. -I../../include  -no-cpp-precomp
>  -isysroot /Developer/SDKs/MacOSX10.4u.sdk -Os
> -mmacosx-version-min=10.4 -arch i386 -c socket.c
> In file included from buffer.h:29,
>                  from socket.h:28,
>                  from socket.c:33:
> error.h:172:5: warning: #warning this compiler appears to lack vararg
> macros which will cause a significant degradation in efficiency (you
> can ignore this warning if you are using LCLINT)
> socket.c: In function 'create_socket_udp6':
> socket.c:902: error: 'IPV6_RECVPKTINFO' undeclared (first use in this function)
> socket.c:902: error: (Each undeclared identifier is reported only once
> socket.c:902: error: for each function it appears in.)
> make[4]: *** [socket.o] Error 1
>
> The error is the main problem, of course, but I'm not sure what to
> make of the warning, which appears in the compilation of (almost?) all
> modules  -- it's hard to believe that gcc 4.0 doesn't have vararg
> macros, since they are a feature of GNU C!
>
> The full compilation log is available at http://pastebin.com/DaPnQZCH



--------------000305030209010500030105
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Jonathan,<br>
    <br>
    This does not really address the issue you're having, but could you
    try if using Alon's new buildsystem helps:<br>
    <pre><a rel="nofollow" href="https://github.com/alonbl/openvpn/downloads" target="_top">&lt;https://github.com/alonbl/openvpn/downloads&gt;</a></pre>
    You need to copy the "generic" directory to OpenVPN source
    directory, cd to it and do a ./build. There's some additional info
    in the README file.<br>
    <br>
    I used it earlier today successfully to compile native + 32/64-bit
    Windows binaries on Ubuntu 11.10. It should also work fine on MacOS
    X if all dependencies are in place:<br>
    <br>
    <a class="moz-txt-link-rfc2396E" href="http://thread.gmane.org/gmane.network.openvpn.devel/5527">&lt;http://thread.gmane.org/gmane.network.openvpn.devel/5527&gt;</a><br>
    <br>
    Samuli<br>
    <br>
    <br>
    <blockquote
cite="mid:CAEsd45Rw5nYYuMMq_Qy_5tQYagZh+EMHM+2Nugod1_1s-BHthA@...278..."
      type="cite">
      <blockquote type="cite">
        <pre wrap="">A preview of OpenVPN 2.3-alpha1 installer for Windows is now available
here:

<a class="moz-txt-link-rfc2396E" href="http://build.openvpn.net/downloads/snapshots/openvpn-2.3-alpha1-preview1-install.exe">&lt;http://build.openvpn.net/downloads/snapshots/openvpn-2.3-alpha1-preview1-install.exe&gt;</a>
</pre>
      </blockquote>
      <pre wrap="">
I realize that this post was aimed at Windows, but building on OS X
10.6.8 (for Tunnelblick) fails with the following:

gcc-4.0 -DHAVE_CONFIG_H -I. -I../.. -I../../include  -no-cpp-precomp
 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -Os
-mmacosx-version-min=10.4 -arch i386 -c socket.c
In file included from buffer.h:29,
                 from socket.h:28,
                 from socket.c:33:
error.h:172:5: warning: #warning this compiler appears to lack vararg
macros which will cause a significant degradation in efficiency (you
can ignore this warning if you are using LCLINT)
socket.c: In function 'create_socket_udp6':
socket.c:902: error: 'IPV6_RECVPKTINFO' undeclared (first use in this function)
socket.c:902: error: (Each undeclared identifier is reported only once
socket.c:902: error: for each function it appears in.)
make[4]: *** [socket.o] Error 1

The error is the main problem, of course, but I'm not sure what to
make of the warning, which appears in the compilation of (almost?) all
modules  -- it's hard to believe that gcc 4.0 doesn't have vararg
macros, since they are a feature of GNU C!

The full compilation log is available at <a class="moz-txt-link-freetext" href="http://pastebin.com/DaPnQZCH">http://pastebin.com/DaPnQZCH</a>
</pre>
    </blockquote>
    <br>
    <br>
    <pre class="moz-signature" cols="72">
</pre>
  </body>
</html>

--------------000305030209010500030105--

