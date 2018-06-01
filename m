MIME-Version: 1.0
In-Reply-To: <1527819161.492538.1392521184.3CB7A30B@...2307...>
References: <1527819161.492538.1392521184.3CB7A30B@...2307...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 31 May 2018 23:59:42 -0400
Message-ID: <CAKuzo_iGmzY-D1Bn07fD89uWVuVDq-s622vtd21Tnn3oyuHF8A@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.5_git fails to build linked to
 OpenSSL v1.1.0 Works great linked to OpenSSL v1.0.2 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: aclion@...2404...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

It builds fine even with the openssl 1.1.1 dev branch:

$ openvpn --version:
OpenVPN 2.5_git [git:master/1394192b210cb3c6] x86_64-unknown-linux-gnu
[SSL (OpenSSL)] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on May 31 2018
library versions: OpenSSL 1.1.1-dev  xx XXX xxxx

>
>                 When I switch to the OpenSSL version 1.1.1 libs, changing=
 only the _FLAGS/_LIBS spec,
>
>         -       export OPENSSL_CFLAGS=3D"-I/usr/local/include -I/opt/ssl1=
1/include -I/usr/include"
>         -       export OPENSSL_LIBS=3D"-L/opt/ssl11/lib64 -Wl,-rpath,/opt=
/ssl11/lib64 -lssl -lcrypto"
>         +       export OPENSSL_CFLAGS=3D"-I/usr/local/include -I/opt/ssl1=
1/include -I/usr/include"
>         +       export OPENSSL_LIBS=3D"-L/opt/ssl11/lib64 -Wl,-rpath,/opt=
/ssl11/lib64 -lssl -lcrypto"


These two lines look identical to the two it replaces -- so what changed?

>
> if still configures OK, but `make` dies,
>
>         ...
>         /usr/bin/gcc-8 -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../=
../include -I../../src/compat -O3 -Wall -fstack-protector-strong -funwind-t=
ables -fasynchronous-unwind-tables -fmessage-length=3D0 -grecord-gcc-switch=
es -D_FORTIFY_SOURCE=3D2  -I/usr/local/include  -I/opt/ssl11/include -I/usr=
/include    -DPLUGIN_LIBDIR=3D\"/opt/openvpn/lib64/openvpn/plugins\"  -Wall=
 -Wno-unused-parameter -Wno-unused-function -O3 -Wall -fstack-protector-str=
ong -funwind-tables -fasynchronous-unwind-tables -fmessage-length=3D0 -grec=
ord-gcc-switches -fPIC -DPIC -D_GNU_SOURCE -fno-strict-aliasing -Wall -std=
=3Dc99 -MT ssl_openssl.o -MD -MP -MF .deps/ssl_openssl.Tpo -c -o ssl_openss=
l.o ssl_openssl.c
>         socket.c: In function =E2=80=98print_link_socket_actual_ex=E2=80=
=99:
>         socket.c:2772:14: warning: unused variable =E2=80=98ifname=E2=80=
=99 [-Wunused-variable]
>                  char ifname[IF_NAMESIZE] =3D "[undef]";
>                       ^~~~~~
>         ssl_openssl.c: In function =E2=80=98tls_init_lib=E2=80=99:
>         ssl_openssl.c:74:5: warning: implicit declaration of function =E2=
=80=98SSL_library_init=E2=80=99; did you mean =E2=80=98SSL_in_init=E2=80=99=
? [-Wimplicit-function-declaration]
>              SSL_library_init();
>              ^~~~~~~~~~~~~~~~
>
>              SSL_in_init
>         ssl_openssl.c:76:5: warning: implicit declaration of function =E2=
=80=98SSL_load_error_strings=E2=80=99; did you mean =E2=80=98ERR_lib_error_=
string=E2=80=99? [-Wimplicit-function-declaration]
>              SSL_load_error_strings();
>              ^~~~~~~~~~~~~~~~~~~~~~


Unable to find those functions in the headers and other similar errors
point to something wrong/unusual with the openssl build. As if
-DOPENSSL_API_COMPAT has been set to some large value (like
0x10100000L meaning 1.1). That should be left undefined (i.e., at its defau=
lt,
which I believe is 0).

Selva

