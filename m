MIME-Version: 1.0
References: <CAAUX2SUj97L-Omhg0o60dYFyjf1W0+GvmvQYFb3Hf43Ruhn5Kw@...278...>
 <950bc7b2-6cd7-d8c7-e6f1-0286742c3dc7@...1227...>
In-Reply-To: <950bc7b2-6cd7-d8c7-e6f1-0286742c3dc7@...1227...>
From: Tony He <huangya90@...277...>
Date: Tue, 2 Mar 2021 17:41:05 +0800
Message-ID: <CAAUX2SX=a853vJ=ozE7T0Q_7ohgkVxfit+myzebeoGV1QUMDsw@...278...>
Content-Type: multipart/alternative; boundary="0000000000002b1e2805bc8a898f"
Subject: Re: [Openvpn-devel] compiling issue in openvpn 2.6.0+ supporting
 ovpn-dco
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Antonio Quartulli <antonio@...515...>, Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002b1e2805bc8a898f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No, same error. This error happens on my Ubuntu 20.04 VM. Another Ubuntu
18.04 is fine. Checking.
What's your Linux distribution?

Tony

Arne Schwabe <arne@...1227...> =E4=BA=8E2021=E5=B9=B43=E6=9C=882=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:18=E5=86=99=E9=81=93=EF=BC=9A

> Am 02.03.21 um 05:12 schrieb Tony He:
> > Hi Arne,
> >
> > I'm trying your working branch dco that supports ovpn-dco. My openssl
> > lib version is:
> > tony-vm-2004% apt download libssl-dev
> > Get:1 http://mirrors.aliyun.com/ubuntu
> > <http://mirrors.aliyun.com/ubuntu> focal-updates/main amd64 libssl-dev
> > amd64 1.1.1f-1ubuntu2.2 [1582 kB]
> > Fetched 1582 kB in 0s (6161 kB/s)
> >
> >
> > If I use ./configure --enable-dco
> >  DCO_SOURCEDIR=3D/project/openvpn/ovpn-dco.git/ , I got below error when
> make
> >
> > gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../include
> > -I../../src/compat   -I/usr/local/include
> > -I/project/openvpn/ovpn-dco.git//include/uapi -I/usr/include/libnl3
> > -DPLUGIN_LIBDIR=3D\"/usr/local/lib/openvpn/plugins\"  -Wall
> > -Wno-unused-parameter -Wno-unused-function -Wno-stringop-truncation -g
> > -O2 -std=3Dc99 -MT crypto_openssl.o -MD -MP -MF .deps/crypto_openssl.Tpo
> > -c -o crypto_openssl.o crypto_openssl.c
> > In file included from crypto_openssl.c:44:
> > openssl_compat.h:228:1: error: static declaration of =E2=80=98X509_OBJE=
CT_free=E2=80=99
> > follows non-static declaration
> >   228 | X509_OBJECT_free(X509_OBJECT *obj)
> >       | ^~~~~~~~~~~~~~~~
> > In file included from /usr/include/openssl/x509.h:320,
> >                  from /usr/include/openssl/ssl.h:20,
> >                  from openssl_compat.h:46,
> >                  from crypto_openssl.c:44:
> > /usr/include/openssl/x509_vfy.h:261:6: note: previous declaration of
> > =E2=80=98X509_OBJECT_free=E2=80=99 was here
> >   261 | void X509_OBJECT_free(X509_OBJECT *a);
> >       |      ^~~~~~~~~~~~~~~~
> > In file included from crypto_openssl.c:44:
> > openssl_compat.h: In function =E2=80=98X509_OBJECT_free=E2=80=99:
> >
> > May I know which openssl lib version you use? Did you compile it by
> > youself or just install from Linux distubition?
> >
> > Tony
> >
>
> That sounds like autoconf/configure is broken in your setup. Does a
> normal master checkout work for you? The error you are getting is not
> specific to ovpn-dco at all. I use the standard OpenSSL included in the
> distrobution.
>
> Arne
>

--0000000000002b1e2805bc8a898f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">No, same error. This error happens on my Ubuntu 20.04 VM. =
Another Ubuntu 18.04 is fine. Checking.<div>What&#39;s your Linux=C2=A0dist=
ribution?</div><div><br></div><div>Tony</div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">Arne Schwabe &lt;<a href=3D"ma=
ilto:arne@...1227...">arne@...1227...</a>&gt; =E4=BA=8E2021=E5=B9=B43=E6=9C=
=882=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:18=E5=86=99=E9=81=93=EF=
=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 02.03.=
21 um 05:12 schrieb Tony He:<br>
&gt; Hi Arne,<br>
&gt; <br>
&gt; I&#39;m trying your working branch dco that supports ovpn-dco. My open=
ssl<br>
&gt; lib version is:<br>
&gt; tony-vm-2004% apt download libssl-dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; Get:1 <a href=3D"http://mirrors.aliyun.com/ubuntu" rel=3D"noreferrer" =
target=3D"_blank">http://mirrors.aliyun.com/ubuntu</a><br>
&gt; &lt;<a href=3D"http://mirrors.aliyun.com/ubuntu" rel=3D"noreferrer" ta=
rget=3D"_blank">http://mirrors.aliyun.com/ubuntu</a>&gt; focal-updates/main=
 amd64 libssl-dev<br>
&gt; amd64 1.1.1f-1ubuntu2.2 [1582 kB]<br>
&gt; Fetched 1582 kB in 0s (6161 kB/s)=C2=A0<br>
&gt; <br>
&gt; <br>
&gt; If I use ./configure --enable-dco<br>
&gt; =C2=A0DCO_SOURCEDIR=3D/project/openvpn/ovpn-dco.git/ , I got below err=
or when make<br>
&gt; <br>
&gt; gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include =C2=A0-I../../include<=
br>
&gt; -I../../src/compat =C2=A0 -I/usr/local/include =C2=A0 =C2=A0<br>
&gt; -I/project/openvpn/ovpn-dco.git//include/uapi -I/usr/include/libnl3<br>
&gt; -DPLUGIN_LIBDIR=3D\&quot;/usr/local/lib/openvpn/plugins\&quot; =C2=A0-=
Wall<br>
&gt; -Wno-unused-parameter -Wno-unused-function -Wno-stringop-truncation -g=
<br>
&gt; -O2 -std=3Dc99 -MT crypto_openssl.o -MD -MP -MF .deps/crypto_openssl.T=
po<br>
&gt; -c -o crypto_openssl.o crypto_openssl.c<br>
&gt; In file included from crypto_openssl.c:44:<br>
&gt; openssl_compat.h:228:1: error: static declaration of =E2=80=98X509_OBJ=
ECT_free=E2=80=99<br>
&gt; follows non-static declaration<br>
&gt; =C2=A0 228 | X509_OBJECT_free(X509_OBJECT *obj)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 | ^~~~~~~~~~~~~~~~<br>
&gt; In file included from /usr/include/openssl/x509.h:320,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /us=
r/include/openssl/ssl.h:20,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ope=
nssl_compat.h:46,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from cry=
pto_openssl.c:44:<br>
&gt; /usr/include/openssl/x509_vfy.h:261:6: note: previous declaration of<b=
r>
&gt; =E2=80=98X509_OBJECT_free=E2=80=99 was here<br>
&gt; =C2=A0 261 | void X509_OBJECT_free(X509_OBJECT *a);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~<br>
&gt; In file included from crypto_openssl.c:44:<br>
&gt; openssl_compat.h: In function =E2=80=98X509_OBJECT_free=E2=80=99:<br>
&gt; <br>
&gt; May I know which openssl lib version you use? Did you compile it by<br>
&gt; youself or just install from Linux distubition?<br>
&gt; <br>
&gt; Tony<br>
&gt; =C2=A0 =C2=A0<br>
<br>
That sounds like autoconf/configure is broken in your setup. Does a<br>
normal master checkout work for you? The error you are getting is not<br>
specific to ovpn-dco at all. I use the standard OpenSSL included in the<br>
distrobution.<br>
<br>
Arne<br>
</blockquote></div>

--0000000000002b1e2805bc8a898f--

