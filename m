From: Marcel =?iso-8859-1?q?Pennewi=DF?= <mailinglists@...1145...>
Date: Thu, 1 Oct 2009 08:14:38 +0200
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...>
	<20090930221942.GA28717@...1266...>
	<7bb795fd0909301526s535c0e9aidfad95b0228adb4e@...278...>
In-Reply-To: <7bb795fd0909301526s535c0e9aidfad95b0228adb4e@...278...>
MIME-Version: 1.0
Message-Id: <200910010814.38064.mailinglists@...1145...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thursday 01 October 2009 00:26:15 JuanJo Ciarlante wrote:
> Marcel,
> > Please apply this patch:
>
> also available as full patch at
> =A0=A0http://cloud.github.com/downloads/jjo/openvpn-ipv6/openvpn-2.1_rc19=
-2.1_r
>c19c-ipv6-0.4.7.patch.gz

compiling failed with:

x86_64-pc-linux-gnu-gcc -DHAVE_CONFIG_H -I.   -I.    -march=3Dathlon64 -O2 =
-pipe -msse3 -D_REENTRANT -pthread -MT=20
cryptoapi.o -MD -MP -MF .deps/cryptoapi.Tpo -c -o cryptoapi.o cryptoapi.c
mv -f .deps/cryptoapi.Tpo .deps/cryptoapi.Po

x86_64-pc-linux-gnu-gcc  -march=3Dathlon64 -O2 -pipe -msse3 -D_REENTRANT -p=
thread  -Wl,-O1 -o=20
openvpn base64.o buffer.o crypto.o dhcp.o error.o event.o fdmisc.o forward.=
o=20
fragment.o gremlin.o helper.o lladdr.o init.o interval.o list.o lzo.o=20
manage.o mbuf.o misc.o mroute.o mss.o mtcp.o mtu.o mudp.o multi.o ntlm.o=20
occ.o pkcs11.o openvpn.o options.o otime.o packet_id.o perf.o pf.o ping.o=20
plugin.o pool.o proto.o proxy.o ieproxy.o ps.o push.o reliable.o route.o=20
schedule.o session_id.o shaper.o sig.o socket.o socks.o ssl.o status.o=20
thread.o tun.o win32.o cryptoapi.o  -lssl -lcrypto -llzo2 -ldl

multi.o: In function `management_client_auth':
multi.c:(.text+0x22ee): undefined reference to `tls_authenticate_key'
collect2: ld returned 1 exit status

make[1]: *** [openvpn] Error 1
make[1]: Leaving directory=20
`/var/tmp/portage/net-misc/openvpn-2.1_rc19/work/openvpn-2.1_rc19'
make: *** [install-recursive] Error 1


using:
./configure --prefix=3D/usr --build=3Dx86_64-pc-linux-gnu --host=3Dx86_64-p=
c-linux-gnu --mandir=3D/usr/share/man --infodir=3D/usr/share/info --datadir=
=3D/usr/share --sysconfdir=3D/etc --localstatedir=3D/var/lib --libdir=3D/us=
r/lib64 --disable-pkcs11 --disable-password-save --enable-ssl --enable-cryp=
to --enable-pthread --disable-iproute2
and gcc version 4.3.2 (Gentoo 4.3.2-r3 p1.6, pie-10.1.5)

Regards,

Marcel

