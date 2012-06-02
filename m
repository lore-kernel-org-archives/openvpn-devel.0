Message-ID: <4FCA1FD3.9020407@...1227...>
Date: Sat, 02 Jun 2012 16:14:43 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Build broken on Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: OpenVPN Devel <openvpn-devel@lists.sourceforge.net>

Hello,

while preparing my patches for OS X I also noticed that the build is
broken on OS X:

[...]
checking net/if_tun.h usability... no
checking net/if_tun.h presence... no
checking for net/if_tun.h... no
checking net/tun/if_tun.h usability... no
checking net/tun/if_tun.h presence... no
checking for net/tun/if_tun.h... no
checking linux/if_tun.h usability... no
checking linux/if_tun.h presence... no
checking for linux/if_tun.h... no
checking tap-windows.h usability... no
checking tap-windows.h presence... no
checking for tap-windows.h... no
configure: error: no tap header could be found


The bad commit is: 7cacdfd4b7f221139e0d2a0334f1f1cd8f2a1b75

    build: tap: search for tap header

It aborts build if no tap headers is found. If the check is disabled
configure works but the build still does not work.

In the INSTALL file  --with-lzo-headers and --with-lzo-lib is mentioned,
which do not work:


checking for aes_crypt_cbc in -lpolarssl... no
checking for lzo1x_1_15_compress in -llzo2... no
checking for lzo1x_1_15_compress in -llzo... no
checking for PKCS11_HELPER... no
configure: error: lzo enabled but missing

./configure --help mentions LZO_CFLAGS and LZO_LIBS which work a bit
better but still do not work.

LZO_CFLAGS="-I/opt/local/include" LZO_LIBS=-L/opt/local/lib ./configure
[...]
make
[...]
/bin/sh ../../libtool --tag=CC   --mode=link gcc  -I/opt/local/include
-I/opt/local/include   -I/opt/local/include  -g -O2   -o openvpn
base64.o buffer.o clinat.o crypto.o crypto_openssl.o crypto_polarssl.o
dhcp.o error.o event.o fdmisc.o forward.o fragment.o gremlin.o helper.o
httpdigest.o lladdr.o init.o interval.o list.o lzo.o manage.o mbuf.o
misc.o platform.o console.o mroute.o mss.o mstats.o mtcp.o mtu.o mudp.o
multi.o ntlm.o occ.o pkcs11.o pkcs11_openssl.o pkcs11_polarssl.o
openvpn.o options.o otime.o packet_id.o perf.o pf.o ping.o plugin.o
pool.o proto.o proxy.o ps.o push.o reliable.o route.o schedule.o
session_id.o shaper.o sig.o socket.o socks.o ssl.o ssl_openssl.o
ssl_polarssl.o ssl_verify.o ssl_verify_openssl.o ssl_verify_polarssl.o
status.o tun.o win32.o cryptoapi.o  ../../src/compat/libcompat.la
-lresolv -L/opt/local/lib  -L/opt/local/lib -lssl -lcrypto
-L/opt/local/lib -lcrypto    -ldl libtool: link: gcc
-I/opt/local/include -I/opt/local/include
-I/opt/local/include -g -O2 -o openvpn base64.o buffer.o clinat.o
crypto.o crypto_openssl.o crypto_polarssl.o dhcp.o error.o event.o
fdmisc.o forward.o fragment.o gremlin.o helper.o httpdigest.o lladdr.o
init.o interval.o list.o lzo.o manage.o mbuf.o misc.o platform.o
console.o mroute.o mss.o mstats.o mtcp.o mtu.o mudp.o multi.o ntlm.o
occ.o pkcs11.o pkcs11_openssl.o pkcs11_polarssl.o openvpn.o options.o
otime.o packet_id.o perf.o pf.o ping.o plugin.o pool.o proto.o proxy.o
ps.o push.o reliable.o route.o schedule.o session_id.o shaper.o sig.o
socket.o socks.o ssl.o ssl_openssl.o ssl_polarssl.o ssl_verify.o
ssl_verify_openssl.o ssl_verify_polarssl.o status.o tun.o win32.o
cryptoapi.o  ../../src/compat/.libs/libcompat.a -lresolv
-L/opt/local/lib -lssl -lcrypto -ldl
Undefined symbols for architecture x86_64:
  "_lzo1x_decompress_safe", referenced from:
      _lzo_decompress in lzo.o
  "_lzo1x_1_15_compress", referenced from:
      _lzo_compress in lzo.o
  "___lzo_init_v2", referenced from:
      _lzo_compress_init in lzo.o
ld: symbol(s) not found for architecture x86_64
collect2: ld returned 1 exit status
make[3]: *** [openvpn] Error 1
make[2]: *** [all-recursive] Error 1
make[1]: *** [all-recursive] Error 1
make: *** [all] Error 2

I have no idea about the configure, autotools  internal to fix this.

Arne



