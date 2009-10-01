MIME-Version: 1.0
In-Reply-To: <7bb795fd0909302333x42aa4869gaf70cf7dc07d611d@...278...>
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...> 
	<20090930221942.GA28717@...1266...>
	<7bb795fd0909301526s535c0e9aidfad95b0228adb4e@...278...> 
	<200910010814.38064.mailinglists@...1145...>
	<7bb795fd0909302333x42aa4869gaf70cf7dc07d611d@...278...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Thu, 1 Oct 2009 09:22:31 +0200
Message-ID: <7bb795fd0910010022i14565834vaa0d29b7fa48eb44@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
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
To: =?ISO-8859-1?Q?Marcel_Pennewi=DF?= <mailinglists@...1145...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Oct 1, 2009 at 8:33 AM, JuanJo Ciarlante <jjo+ml@...410...> wrote:
> On Thu, Oct 1, 2009 at 8:14 AM, Marcel Pennewi=DF
> <mailinglists@...1145...> wrote:
>> On Thursday 01 October 2009 00:26:15 JuanJo Ciarlante wrote:
>>> Marcel,
>>> > Please apply this patch:
>>>
>>> also available as full patch at
>>> =A0=A0http://cloud.github.com/downloads/jjo/openvpn-ipv6/openvpn-2.1_rc=
19-2.1_r
>>>c19c-ipv6-0.4.7.patch.gz
>>
>> compiling failed with:
>>
>> x86_64-pc-linux-gnu-gcc -DHAVE_CONFIG_H -I. =A0 -I. =A0 =A0-march=3Dathl=
on64 -O2 -pipe -msse3 -D_REENTRANT -pthread -MT
>> cryptoapi.o -MD -MP -MF .deps/cryptoapi.Tpo -c -o cryptoapi.o cryptoapi.c
>> mv -f .deps/cryptoapi.Tpo .deps/cryptoapi.Po
>>
>> x86_64-pc-linux-gnu-gcc =A0-march=3Dathlon64 -O2 -pipe -msse3 -D_REENTRA=
NT -pthread =A0-Wl,-O1 -o
>> openvpn base64.o buffer.o crypto.o dhcp.o error.o event.o fdmisc.o forwa=
rd.o
>> fragment.o gremlin.o helper.o lladdr.o init.o interval.o list.o lzo.o
>> manage.o mbuf.o misc.o mroute.o mss.o mtcp.o mtu.o mudp.o multi.o ntlm.o
>> occ.o pkcs11.o openvpn.o options.o otime.o packet_id.o perf.o pf.o ping.o
>> plugin.o pool.o proto.o proxy.o ieproxy.o ps.o push.o reliable.o route.o
>> schedule.o session_id.o shaper.o sig.o socket.o socks.o ssl.o status.o
>> thread.o tun.o win32.o cryptoapi.o =A0-lssl -lcrypto -llzo2 -ldl
>>
>> multi.o: In function `management_client_auth':
>> multi.c:(.text+0x22ee): undefined reference to `tls_authenticate_key'
>> collect2: ld returned 1 exit status
>
> Weird, cos I didn't touch anything related to crypto (?), anyway
> I'll test the build from patch in x86{,_64} to see if I can get that.

Compiled from
  http://cloud.github.com/downloads/jjo/openvpn-ipv6/openvpn-2.1_rc19c-ipv6=
-0.4.7.tar.gz
, it went find for both, as the symbol(s) are ok at the objects:

$ nm -p multi.o ssl.o | egrep 'o:|tls_auth'
multi.o:
                 U tls_authenticate_key
                 U tls_authentication_status
ssl.o:
0000000000000080 T tls_authenticate_key
0000000000000ba0 T tls_auth_standalone_init
0000000000000d80 T tls_auth_standalone_finalize
0000000000000ff0 T tls_authentication_status

, ie: tls_authenticate_key symbol present as code ("T "ext) in ssl.o
, could be there something fishy/unclean in your building env?


>
> Cheers,
>
>>
>> make[1]: *** [openvpn] Error 1
>> make[1]: Leaving directory
>> `/var/tmp/portage/net-misc/openvpn-2.1_rc19/work/openvpn-2.1_rc19'
>> make: *** [install-recursive] Error 1
>>
>>
>> using:
>> ./configure --prefix=3D/usr --build=3Dx86_64-pc-linux-gnu --host=3Dx86_6=
4-pc-linux-gnu --mandir=3D/usr/share/man --infodir=3D/usr/share/info --data=
dir=3D/usr/share --sysconfdir=3D/etc --localstatedir=3D/var/lib --libdir=3D=
/usr/lib64 --disable-pkcs11 --disable-password-save --enable-ssl --enable-c=
rypto --enable-pthread --disable-iproute2
>> and gcc version 4.3.2 (Gentoo 4.3.2-r3 p1.6, pie-10.1.5)
>>
>> Regards,
>>
>> Marcel
>>
>> ------------------------------------------------------------------------=
------
>> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
>> is the only developer event you need to attend this year. Jumpstart your
>> developing skills, take BlackBerry mobile applications to market and stay
>> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#=
33;
>> http://p.sf.net/sfu/devconf
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>
>
>
> --
> --JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'
>



--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

