Message-ID: <4F44F7F8.4090604@...1114...>
Date: Wed, 22 Feb 2012 15:13:12 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F438CF2.1060305@...515...>
	<CAEsd45Rw5nYYuMMq_Qy_5tQYagZh+EMHM+2Nugod1_1s-BHthA@...278...>
In-Reply-To: <CAEsd45Rw5nYYuMMq_Qy_5tQYagZh+EMHM+2Nugod1_1s-BHthA@...278...>
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
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/02/12 14:47, Jonathan K. Bullard wrote:
> 2012/2/21 Samuli Sepp=E4nen <samuli@...515...>
>> A preview of OpenVPN 2.3-alpha1 installer for Windows is now
>> available here:
>>=20
>> <http://build.openvpn.net/downloads/snapshots/openvpn-2.3-alpha1-preview=
1-install.exe>
>
>>=20
> I realize that this post was aimed at Windows, but building on OS X=20
> 10.6.8 (for Tunnelblick) fails with the following:
>=20
> gcc-4.0 -DHAVE_CONFIG_H -I. -I../.. -I../../include  -no-cpp-precomp=20
> -isysroot /Developer/SDKs/MacOSX10.4u.sdk -Os=20
> -mmacosx-version-min=3D10.4 -arch i386 -c socket.c In file included from
> buffer.h:29, from socket.h:28, from socket.c:33: error.h:172:5:
> warning: #warning this compiler appears to lack vararg macros which
> will cause a significant degradation in efficiency (you can ignore
> this warning if you are using LCLINT)

This I don't understand, as this isn't exactly new code.  The warning in
error.h:172 has been in the source tree since September 2005.  I suspect
this to be somehow compiler related.

I'm compiling OpenVPN regularly on Fedora 14, which uses:

  $ gcc --version
  gcc (GCC) 4.5.1 20100924 (Red Hat 4.5.1-4)

> socket.c: In function 'create_socket_udp6': socket.c:902: error:
> 'IPV6_RECVPKTINFO' undeclared (first use in this function)=20
> socket.c:902: error: (Each undeclared identifier is reported only
> once socket.c:902: error: for each function it appears in.) make[4]:
> *** [socket.o] Error 1

This seems to be the main reason why it chokes.  I've Cc'ed Juan Jo, who
introduced this change.  It's related to the new IPv6 transport feature.

JJO: Can you please see if you can figure out this?

> The error is the main problem, of course, but I'm not sure what to=20
> make of the warning, which appears in the compilation of (almost?)
> all modules  -- it's hard to believe that gcc 4.0 doesn't have vararg=20
> macros, since they are a feature of GNU C!

Agreed, there is something odd going on here.  But I don't have any OSX
boxes available and lack some knowledge about the OSX build environment,
so it's really hard to figure out immediately.  I hope others with OSX
can have a look at what's causing this.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9E9/YACgkQDC186MBRfrrUdgCbB3IL4kKjMgryggfqSwhjcKap
wF4AoKR6WXY9dp/SEBFZS8wow/tPv49L
=3Dw4Eu
-----END PGP SIGNATURE-----

