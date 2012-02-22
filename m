MIME-Version: 1.0
In-Reply-To: <4F438CF2.1060305@...515...>
References: <4F438CF2.1060305@...515...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 22 Feb 2012 08:47:17 -0500
Message-ID: <CAEsd45Rw5nYYuMMq_Qy_5tQYagZh+EMHM+2Nugod1_1s-BHthA@...278...>
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
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

2012/2/21 Samuli Sepp=E4nen <samuli@...515...>
> A preview of OpenVPN 2.3-alpha1 installer for Windows is now available
> here:
>
> <http://build.openvpn.net/downloads/snapshots/openvpn-2.3-alpha1-preview1=
-install.exe>

I realize that this post was aimed at Windows, but building on OS X
10.6.8 (for Tunnelblick) fails with the following:

gcc-4.0 -DHAVE_CONFIG_H -I. -I../.. -I../../include  -no-cpp-precomp
 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -Os
-mmacosx-version-min=3D10.4 -arch i386 -c socket.c
In file included from buffer.h:29,
                 from socket.h:28,
                 from socket.c:33:
error.h:172:5: warning: #warning this compiler appears to lack vararg
macros which will cause a significant degradation in efficiency (you
can ignore this warning if you are using LCLINT)
socket.c: In function 'create_socket_udp6':
socket.c:902: error: 'IPV6_RECVPKTINFO' undeclared (first use in this funct=
ion)
socket.c:902: error: (Each undeclared identifier is reported only once
socket.c:902: error: for each function it appears in.)
make[4]: *** [socket.o] Error 1

The error is the main problem, of course, but I'm not sure what to
make of the warning, which appears in the compilation of (almost?) all
modules  -- it's hard to believe that gcc 4.0 doesn't have vararg
macros, since they are a feature of GNU C!

The full compilation log is available at http://pastebin.com/DaPnQZCH

