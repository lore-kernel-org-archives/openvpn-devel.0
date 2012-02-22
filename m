MIME-Version: 1.0
Date: Wed, 22 Feb 2012 11:49:15 -0800 (PST)
In-Reply-To: <4F44F7F8.4090604@...1114...>
References: <4F438CF2.1060305@...515...>
	<CAEsd45Rw5nYYuMMq_Qy_5tQYagZh+EMHM+2Nugod1_1s-BHthA@...278...>
	<4F44F7F8.4090604@...1114...>
Message-ID: <eb2837a3-ce55-4f52-b2fe-f822efc661f7@...1662...>
From: debrabander <debrabander@...277...>
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
To: openvpn-devel@lists.sourceforge.net

This is not the a problem when building using the latest Mac OS X SDK.
I've did a quick search and it seems to be a more common issue on some
(old) Darwin platforms. Please try building again after applying the
patch below.


Signed-off-by: Frank de Brabander <debrabander@...277...>
---
 socket.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/socket.c b/socket.c
index 1a772af..6337900 100644
--- a/socket.c
+++ b/socket.c
@@ -893,8 +893,13 @@ create_socket_udp6 (const unsigned int flags)
   else if (flags & SF_USE_IP_PKTINFO)
     {
       int pad =3D 1;
+#ifndef IPV6_RECVPKTINFO /* Some older Darwin platforms require this
*/
+      if (setsockopt (sd, IPPROTO_IPV6, IPV6_PKTINFO,
+		      (void*)&pad, sizeof(pad)) < 0)
+#else
       if (setsockopt (sd, IPPROTO_IPV6, IPV6_RECVPKTINFO,
 		      (void*)&pad, sizeof(pad)) < 0)
+#endif
 	msg(M_SOCKERR, "UDP: failed setsockopt for IPV6_RECVPKTINFO");
     }
 #endif
--
1.7.5.4


On 22 feb, 15:13, David Sommerseth <openvpn.l...@...1114...>
wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 22/02/12 14:47, Jonathan K. Bullard wrote:
>
>
>
>
>
>
>
>
>
> > 2012/2/21 Samuli Sepp=E4nen <sam...@...515...>
> >> ApreviewofOpenVPN2.3-alpha1installerfor Windows isnow
> >>availablehere:
>
> >> <http://build.openvpn.net/downloads/snapshots/openvpn-2.3-alpha1-previ=
...>
>
> > I realize that this post was aimed at Windows, but building on OS X
> > 10.6.8 (for Tunnelblick) fails with the following:
>
> > gcc-4.0 -DHAVE_CONFIG_H -I. -I../.. -I../../include =A0-no-cpp-precomp
> > -isysroot /Developer/SDKs/MacOSX10.4u.sdk -Os
> > -mmacosx-version-min=3D10.4 -arch i386 -c socket.c In file included from
> > buffer.h:29, from socket.h:28, from socket.c:33: error.h:172:5:
> > warning: #warning this compiler appears to lack vararg macros which
> > will cause a significant degradation in efficiency (you can ignore
> > this warning if you are using LCLINT)
>
> This I don't understand, as this isn't exactly new code. =A0The warning in
> error.h:172 has been in the source tree since September 2005. =A0I suspect
> this to be somehow compiler related.
>
> I'm compilingOpenVPNregularly on Fedora 14, which uses:
>
> =A0 $ gcc --version
> =A0 gcc (GCC) 4.5.120100924 (Red Hat 4.5.1-4)
>
> > socket.c: In function 'create_socket_udp6': socket.c:902: error:
> > 'IPV6_RECVPKTINFO' undeclared (first use in this function)
> > socket.c:902: error: (Each undeclared identifier is reported only
> > once socket.c:902: error: for each function it appears in.) make[4]:
> > *** [socket.o] Error1
>
> This seems to be the main reason why it chokes. =A0I've Cc'ed Juan Jo, who
> introduced this change. =A0It's related to the new IPv6 transport feature.
>
> JJO: Can you please see if you can figure out this?
>
> > The error is the main problem, of course, but I'm not sure what to
> > make of the warning, which appears in the compilation of (almost?)
> > all modules =A0-- it's hard to believe that gcc 4.0 doesn't have vararg
> > macros, since they are a feature of GNU C!
>
> Agreed, there is something odd going on here. =A0But I don't have any OSX
> boxesavailableand lack some knowledge about the OSX build environment,
> so it's really hard to figure out immediately. =A0I hope others with OSX
> can have a look at what's causing this.
>
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla -http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk9E9/YACgkQDC186MBRfrrUdgCbB3IL4kKjMgryggfqSwhjcKap
> wF4AoKR6WXY9dp/SEBFZS8wow/tPv49L
> =3Dw4Eu
> -----END PGP SIGNATURE-----
>
> -------------------------------------------------------------------------=
-- ---
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.http://ww=
w.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________Openvpn-devel mailing list=
Openvpn-de...@...1440...://lists.sourceforge.net/lists/listinfo/openvpn-dev=
el

