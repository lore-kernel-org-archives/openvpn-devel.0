Message-Id: <1506794899.87173.1123548520.4DA7A99E@...2307...>
From: logcabin@...2306...
MIME-Version: 1.0
Date: Sat, 30 Sep 2017 14:08:19 -0400
In-Reply-To: <20170930161910.GX70062@...1296...>
References: <1506735276.3927298.1123095944.62A302FF@...2307...>
 <20170930074629.GT70062@...1296...>
 <20170930161910.GX70062@...1296...>
Subject: Re: [Openvpn-devel] Unreferenced function in 2.4.4 Linux build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Yes, I saw the prototype for LZ4_compress_default(), but I was unable to
find the function itself. Here's the error output from the make command:

gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../include
-I../../src/compat      
-DPLUGIN_LIBDIR=\"/usr/local0/lib/openvpn/plugins\"  -g -O2 -std=c99 -MT
comp-lz4.o -MD -MP -MF .deps/comp-lz4.Tpo -c -o comp-lz4.o comp-lz4.c
mv -f .deps/comp-lz4.Tpo .deps/comp-lz4.Po
/bin/bash ../../libtool  --tag=CC   --mode=link gcc     
-DPLUGIN_LIBDIR=\"/usr/local0/lib/openvpn/plugins\"  -g -O2 -std=c99  
-o openvpn argv.o base64.o buffer.o clinat.o comp.o compstub.o
comp-lz4.o crypto.o crypto_openssl.o crypto_mbedtls.o dhcp.o error.o
event.o fdmisc.o forward.o fragment.o gremlin.o helper.o httpdigest.o
lladdr.o init.o interval.o list.o lzo.o manage.o mbuf.o misc.o
platform.o console.o console_builtin.o console_systemd.o mroute.o mss.o
mstats.o mtcp.o mtu.o mudp.o multi.o ntlm.o occ.o pkcs11.o
pkcs11_openssl.o pkcs11_mbedtls.o openvpn.o options.o otime.o
packet_id.o perf.o pf.o ping.o plugin.o pool.o proto.o proxy.o ps.o
push.o reliable.o route.o schedule.o session_id.o shaper.o sig.o
socket.o socks.o ssl.o ssl_openssl.o ssl_mbedtls.o ssl_verify.o
ssl_verify_openssl.o ssl_verify_mbedtls.o status.o tls_crypt.o tun.o
win32.o cryptoapi.o  ../../src/compat/libcompat.la -lnsl -lresolv -llzo2
-llz4  -lssl -lcrypto   -ldl  
libtool: link: gcc -DPLUGIN_LIBDIR=\"/usr/local0/lib/openvpn/plugins\"
-g -O2 -std=c99 -o openvpn argv.o base64.o buffer.o clinat.o comp.o
compstub.o comp-lz4.o crypto.o crypto_openssl.o crypto_mbedtls.o dhcp.o
error.o event.o fdmisc.o forward.o fragment.o gremlin.o helper.o
httpdigest.o lladdr.o init.o interval.o list.o lzo.o manage.o mbuf.o
misc.o platform.o console.o console_builtin.o console_systemd.o mroute.o
mss.o mstats.o mtcp.o mtu.o mudp.o multi.o ntlm.o occ.o pkcs11.o
pkcs11_openssl.o pkcs11_mbedtls.o openvpn.o options.o otime.o
packet_id.o perf.o pf.o ping.o plugin.o pool.o proto.o proxy.o ps.o
push.o reliable.o route.o schedule.o session_id.o shaper.o sig.o
socket.o socks.o ssl.o ssl_openssl.o ssl_mbedtls.o ssl_verify.o
ssl_verify_openssl.o ssl_verify_mbedtls.o status.o tls_crypt.o tun.o
win32.o cryptoapi.o  ../../src/compat/.libs/libcompat.a -lnsl -lresolv
-llzo2 -llz4 -lssl -lcrypto -ldl
comp-lz4.o: In function `do_lz4_compress':
/root/openvpn-2.4.4/src/openvpn/comp-lz4.c:90: undefined reference to
`LZ4_compress_default'
collect2: error: ld returned 1 exit status

Here's the output from the locate command:

/usr/lib/arm-linux-gnueabihf/liblz4.a
/usr/lib/arm-linux-gnueabihf/liblz4.so
/usr/lib/arm-linux-gnueabihf/liblz4.so.1
/usr/lib/arm-linux-gnueabihf/liblz4.so.1.3.0
/usr/lib/arm-linux-gnueabihf/pkgconfig/liblz4.pc
/usr/local/lib/liblz4.a
/usr/local/lib/liblz4.so
/usr/local/lib/liblz4.so.1
/usr/local/lib/liblz4.so.1.8.0
/usr/local/lib/pkgconfig/liblz4.pc

Since I could not locate LZ4_compress_default() in the openvpn source, I
pulled lz4.c from the lz4 source tree, snipped out that function from
the file, and then inserted it into comp_lz4.c. This does not work
because there are many dependencies in this function.

So I made a horrible hack and simply included lz4.c in comp_lz4.c. This
solved the dependencies, but is most likely the wrong way to solve this
problem :-)

On Sat, Sep 30, 2017, at 12:19 PM, Gert Doering wrote:
> Hi,
> 
> (copying back in the list)
> 
> On Sat, Sep 30, 2017 at 09:46:29AM +0200, Gert Doering wrote:
> > Which linux distribution is this, in which version?  Can you upload
> > config.log and your system's "lz4.h" somewhere so we can see what it 
> > tried to do, and why it is failing?
> 
> I received the files in the meantime, and I'm not fully understanding
> the issue yet.  
> 
> lz4.h says it's 1.8.0, so is passing the "newer than 1.7.1" check just 
> fine.  The lz4.h also has a prototype for LZ4_compress_default(), so it
> really should work fine...
> 
> 
> What I noticed in config.log is that we test for "is it working?" by
> checking LZ4_compress()
> 
>     # if LZ4_LIBS is set, we assume it will work, otherwise test
>     if test -z "${LZ4_LIBS}"; then
>         AC_CHECK_LIB([lz4],
>                      [LZ4_compress],
>                      [LZ4_LIBS="-llz4"],
>                      [have_lz4="no"])
>     fi
> 
> ... which we might want to change to LZ4_compress_default().
> 
> But it should still work.
> 
> 
> @logcabin: can you show me the failing compiler call as well?  Like,
> the last 30 lines from a failing "make" run?
> 
> You said you found a workaround for it - what did you do to fix it?
> 
> Could it be that there are multiple liblz4.a or liblz4.so.* on your
> system?  What does "locate liblz4." print out?
> 
> (So maybe there's a lz4.h for 1.8.0, but the liblz4.* that the linker
> picks up is from an older version that did not have
> LZ4_compress_default()
> yet...)
> 
> 
> Slightly puzzling :-)
> 
> gert
> 
> -- 
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~gert/
> Gert Doering - Munich, Germany                            
> gert@...1296...
> fax: +49-89-35655025                       
> gert@...1297...
> Email had 1 attachment:
> + signature.asc
>   1k (application/pgp-signature)

