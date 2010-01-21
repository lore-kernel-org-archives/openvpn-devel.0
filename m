Message-ID: <4B581CB1.5000500@...1294...>
Date: Thu, 21 Jan 2010 10:21:53 +0100
From: Eike Lohmann <e.lohmann@...1294...>
MIME-Version: 1.0
References: <4B56CBFD.7080900@...1294...> <20100120130832.19514.qmail@...1287...>
In-Reply-To: <20100120130832.19514.qmail@...1287...>
Subject: Re: [Openvpn-devel] Crosscompile OpenVPN 2.1.1
Reply-To: e.lohmann@...1294...
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


Meanwhile I switched over to the prebuild package, but get the same
error here.
(configure: error: LZO headers were found but LZO library was not found)

In config.log I see

configure:11102: result: no
configure:11135: checking for lzo/lzo1x.h
configure:11142: result: no
configure:11166: checking lzo1x.h usability
configure:11183: i586-mingw32msvc-gcc -c -g -O2=20
-I../lzo-2.02/include/lzo -I. conftest.c >&5
configure:11189: $? =3D 0
configure:11203: result: yes
configure:11207: checking lzo1x.h presence
configure:11222: i586-mingw32msvc-gcc -E  -I../lzo-2.02/include/lzo -I.
conftest.c
configure:11228: $? =3D 0
configure:11242: result: yes
configure:11275: checking for lzo1x.h
configure:11282: result: yes
configure:11301: checking for lzo1x_1_15_compress in -llzo
configure:11336: i586-mingw32msvc-gcc -o conftest.exe -g -O2=20
-I../lzo-2.02/include/lzo -I.  -L../lzo-2.02 conftest.c -llzo  -lwinmm
-liphlpapi -lcrypt32 -lwininet -lws2_32 -lgdi32  >&5
/usr/lib/gcc/i586-mingw32msvc/4.2.1-sjlj/../../../../i586-mingw32msvc/bin/l=
d:
cannot find -llzo
collect2: ld returned 1 exit status
configure:11342: $? =3D 1
configure: failed program was:
| /* confdefs.h.  */

If I set the headerpath from "../lzo-2.03/usr/local/include/lzo" to
"../lzo-2.03/usr/local/include" the configure will find the headers and
libs, so it seems to be a wrong errormessage.

After seting the path to openssl and disable selinux
(./configure --host=3Di586-mingw32msvc
--with-lzo-headers=3D../lzo-2.02/include --with-lzo-lib=3D../lzo-2.02
--with-ssl-headers=3D../openssl-0.9.8l/include
--with-ssl-lib=3D../openssl-0.9.8l --disable-selinux)
I can go on with make and run into the next problem:

make  all-recursive
make[1]: Betrete Verzeichnis
'/home/eike/eikedev/openvpn_211/2.1_rc22-prebuilt/openvpn-2.1.1'
Making all in images
make[2]: Betrete Verzeichnis
'/home/eike/eikedev/openvpn_211/2.1_rc22-prebuilt/openvpn-2.1.1/images'
make[2]: F=FCr das Ziel =BBall=AB ist nichts zu tun.
make[2]: Verlasse Verzeichnis
'/home/eike/eikedev/openvpn_211/2.1_rc22-prebuilt/openvpn-2.1.1/images'
Making all in service-win32
make[2]: Betrete Verzeichnis
'/home/eike/eikedev/openvpn_211/2.1_rc22-prebuilt/openvpn-2.1.1/service-win=
32'
i586-mingw32msvc-gcc -DHAVE_CONFIG_H -I. -I..=20=20
-I../openssl-0.9.8l/include -I../lzo-2.02/include -I.  -g -O2 -MT
openvpnserv.o -MD -MP -MF .deps/openvpnserv.Tpo -c -o openvpnserv.o
openvpnserv.c
mv -f .deps/openvpnserv.Tpo .deps/openvpnserv.Po
i586-mingw32msvc-gcc -DHAVE_CONFIG_H -I. -I..=20=20
-I../openssl-0.9.8l/include -I../lzo-2.02/include -I.  -g -O2 -MT
service.o -MD -MP -MF .deps/service.Tpo -c -o service.o service.c
mv -f .deps/service.Tpo .deps/service.Po
i586-mingw32msvc-gcc  -g -O2  -L../openssl-0.9.8l -L../lzo-2.02 -o
openvpnserv.exe openvpnserv.o service.o  -lssl32 -leay32 -llzo2 -lwinmm
-liphlpapi -lcrypt32 -lwininet -lws2_32 -lgdi32
/usr/lib/gcc/i586-mingw32msvc/4.2.1-sjlj/../../../../i586-mingw32msvc/bin/l=
d:
cannot find -lssl32
collect2: ld gab 1 als Ende-Status zur=FCck
make[2]: *** [openvpnserv.exe] Fehler 1
make[2]: Verlasse Verzeichnis
'/home/eike/eikedev/openvpn_211/2.1_rc22-prebuilt/openvpn-2.1.1/service-win=
32'
make[1]: *** [all-recursive] Fehler 1
make[1]: Verlasse Verzeichnis
'/home/eike/eikedev/openvpn_211/2.1_rc22-prebuilt/openvpn-2.1.1'
make: *** [all] Fehler 2


p.s.: I made very good experience with visual c++ on windows. lzo,
pkcs-helper, openssl all could be compiled without big problems, but
since openvpn 2.1rc4 the script for visual c++ is missing.

Regrads, Eike




Peter Stuge schrieb:
> Eike Lohmann wrote:
>=20=20=20
>> checking for lzo1x_1_15_compress in -llzo... no
>> configure: error: LZO headers were found but LZO library was not found
>>=20=20=20=20=20
> ..
>=20=20=20
>> What exactly is missing and how to build it?
>>=20=20=20=20=20
>
> Look in config.log for the exact error from the configure test.
> It would help to also post it here.
>
>
> //Peter
>
> -------------------------------------------------------------------------=
-----
> Throughout its 18-year history, RSA Conference consistently attracts the
> world's best and brightest in the field, creating opportunities for Confe=
rence
> attendees to learn about information security's most important issues thr=
ough
> interactions with peers, luminaries and emerging and established companie=
s.
> http://p.sf.net/sfu/rsaconf-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=20=20

