MIME-Version: 1.0
References: <1518302884.3072.1.camel@...2316...>
 <1518303011.3072.4.camel@...2316...>
 <778643d1-7f14-a31b-949a-8aab94473e64@...1227...>
 <1581683898.3296.4.camel@...2316...>
 <CAFHpkQHiu5ChvP+5vgmQLigSq5C-NJ=bzLCxAF+raZm6z6kdKw@...278...>
 <1581778776.3847.1.camel@...2316...>
In-Reply-To: <1581778776.3847.1.camel@...2316...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 15 Feb 2020 20:04:23 +0500
Message-ID: <CAFHpkQF63aSmQux97=8XDRp33r52MVk2Jh5tt95SSbCYYnGZZg@...278...>
Content-Type: multipart/alternative; boundary="000000000000dd5be7059e9ea35d"
Subject: Re: [Openvpn-devel] [PATCH v4 2/2] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000dd5be7059e9ea35d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 15 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =D0=B2 19:59, James=
 Bottomley <
James.Bottomley@...2317...>:

> On Fri, 2020-02-14 at 18:33 +0500, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:
> > =D0=BF=D1=82, 14 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =D0=B2 18:05, J=
ames Bottomley <
> > James.Bottomley@...2317...>:
> >
> > > On Thu, 2020-02-13 at 19:18 +0100, Arne Schwabe wrote:
> > > > Am 10.02.18 um 23:50 schrieb James Bottomley:
> > > > > Testing engines is problematic, so one of the prerequisites
> > > > > built
> > > > > for the tests is a simple openssl engine that reads a non-
> > > > > standard
> > > > > PEM guarded key.  The test is simply can we run a client/server
> > > > > configuration with the usual sample key replaced by an engine
> > > > > key.
> > > > > The trivial engine prints out some operations and we check for
> > > > > these in the log to make sure the engine was used to load the
> > > > > key
> > > > > and that it correctly got the password.
> > > >
> > > > This tests the openssl engine functionality in a sensible way.
> > > > But I
> > > > think it is not fully ready to be commited. To get it working I
> > > > needed to do following changes on my Mac:
> > >
> > > That could be ... I only have a linux box to try this out on.
> > >
> > > > commit afa697cec15b4e54e720efe9de39c9b20b13c5c8 (HEAD ->
> > > > review/enginekeys)
> > > > Author: Arne Schwabe <arne@...1227...>
> > > > Date:   Thu Feb 13 18:13:34 2020 +0100
> > > >
> > > >     foo
> > > >
> > > > diff --git a/tests/unit_tests/engine-key/Makefile.am
> > > > b/tests/unit_tests/engine-key/Makefile.am
> > > > index 73921965..6d7fc9c5 100644
> > > > --- a/tests/unit_tests/engine-key/Makefile.am
> > > > +++ b/tests/unit_tests/engine-key/Makefile.am
> > > > @@ -10,4 +10,6 @@ TESTS_ENVIRONMENT =3D srcdir=3D"$(abs_srcdir)"; \
> > > >  TESTS =3D check_engine_keys.sh
> > > >
> > > >  libtestengine_la_SOURCES =3D libtestengine.c
> > > > -libtestengine_la_LDFLAGS =3D -rpath /lib -avoid-version
> > > > +libtestengine_la_LDFLAGS =3D @TEST_LDFLAGS@  -rpath /lib
> > > > +libtestengine_la_CFLAGS  =3D @TEST_CFLAGS@ -I$(openvpn_srcdir)
> > > > -I$(compat_srcdir)
> > > > +
> > > > diff --git a/tests/unit_tests/engine-key/libtestengine.c
> > > > b/tests/unit_tests/engine-key/libtestengine.c
> > > > index fa7f5de1..46ec1e33 100644
> > > > --- a/tests/unit_tests/engine-key/libtestengine.c
> > > > +++ b/tests/unit_tests/engine-key/libtestengine.c
> > > > @@ -30,7 +30,6 @@ static EVP_PKEY *engine_load_key(ENGINE *e,
> > > > const
> > > > char
> > > > *key_id,
> > > >         PKCS8_PRIV_KEY_INFO *p8inf;
> > > >         UI *ui;
> > > >         char auth[256];
> > > > -       int len;
> > >
> > > the variable is certainly unused and can go.
> > >
> > > >         fprintf(stderr, "ENGINE: engine_load_key called\n");
> > > >
> > > > diff --git a/tests/unit_tests/engine-key/openssl.cnf
> > > > b/tests/unit_tests/engine-key/openssl.cnf
> > > > index 53200c46..e9513a92 100644
> > > > --- a/tests/unit_tests/engine-key/openssl.cnf
> > > > +++ b/tests/unit_tests/engine-key/openssl.cnf
> > > > @@ -9,4 +9,4 @@ engines         =3D engines_section
> > > >  testengine     =3D testengine_section
> > > >
> > > >  [testengine_section]
> > > > -dynamic_path   =3D $ENV::srcdir/.libs/libtestengine.so
> > > > +dynamic_path   =3D $ENV::srcdir/.libs/libtestengine.dylib
> >
> > we use gost-engine (https://github.com/engine/gost-engine)
> >
> > on both linux and osx.
> >
> > for some time there was a bug in openssl:
> >
> > https://github.com/openssl/openssl/issues/8950
> >
> >
> > however, for now "dylib" is used for osx. and
> > but we do not use "dynamic" path. we use config like that
> >
> > openssl_conf =3D openssl_def
> >
> > [openssl_def]
> > engines =3D engine_section
> >
> > [engine_section]
> > gost =3D gost_section
> >
> > [gost_section]
> > default_algorithms =3D ALL
> > engine_id =3D gost
> > CRYPT_PARAMS =3D id-Gost28147-89-CryptoPro-A-ParamSet
>
> Right, that works if the engine is in the correct directory.  The
> problem with this engine is that it's only built as a test
> demonstration for the openvpn engine code, so it's never installed in
> the openssl engines directory, so we have to tell openssl exactly where
> to find it in the openvpn tree ... and that seems to involve naming the
> whole file and location, including extension.
>
>
yes, I understand reasoning.
maybe we should add dynamic path to our tests as well.


> James
>
>

--000000000000dd5be7059e9ea35d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D0=B1, 15 =D1=84=D0=B5=D0=B2=
=D1=80. 2020 =D0=B3. =D0=B2 19:59, James Bottomley &lt;<a href=3D"mailto:Ja=
mes.Bottomley@...2317...">James.Bottomley@...2317...</a>&gt;:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 2020-02-14 at 18:33 +=
0500, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD w=
rote:<br>
&gt; =D0=BF=D1=82, 14 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =D0=B2 18:05, =
James Bottomley &lt;<br>
&gt; <a href=3D"mailto:James.Bottomley@...2317..." target=3D"_blank">James.=
Bottomley@...2317...</a>&gt;:<br>
&gt; <br>
&gt; &gt; On Thu, 2020-02-13 at 19:18 +0100, Arne Schwabe wrote:<br>
&gt; &gt; &gt; Am 10.02.18 um 23:50 schrieb James Bottomley:<br>
&gt; &gt; &gt; &gt; Testing engines is problematic, so one of the prerequis=
ites<br>
&gt; &gt; &gt; &gt; built<br>
&gt; &gt; &gt; &gt; for the tests is a simple openssl engine that reads a n=
on-<br>
&gt; &gt; &gt; &gt; standard<br>
&gt; &gt; &gt; &gt; PEM guarded key.=C2=A0 The test is simply can we run a =
client/server<br>
&gt; &gt; &gt; &gt; configuration with the usual sample key replaced by an =
engine<br>
&gt; &gt; &gt; &gt; key.<br>
&gt; &gt; &gt; &gt; The trivial engine prints out some operations and we ch=
eck for<br>
&gt; &gt; &gt; &gt; these in the log to make sure the engine was used to lo=
ad the<br>
&gt; &gt; &gt; &gt; key<br>
&gt; &gt; &gt; &gt; and that it correctly got the password.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; This tests the openssl engine functionality in a sensible wa=
y.<br>
&gt; &gt; &gt; But I<br>
&gt; &gt; &gt; think it is not fully ready to be commited. To get it workin=
g I<br>
&gt; &gt; &gt; needed to do following changes on my Mac:<br>
&gt; &gt; <br>
&gt; &gt; That could be ... I only have a linux box to try this out on.<br>
&gt; &gt; <br>
&gt; &gt; &gt; commit afa697cec15b4e54e720efe9de39c9b20b13c5c8 (HEAD -&gt;<=
br>
&gt; &gt; &gt; review/enginekeys)<br>
&gt; &gt; &gt; Author: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." =
target=3D"_blank">arne@...1227...</a>&gt;<br>
&gt; &gt; &gt; Date:=C2=A0 =C2=A0Thu Feb 13 18:13:34 2020 +0100<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0foo<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; diff --git a/tests/unit_tests/engine-key/Makefile.am<br>
&gt; &gt; &gt; b/tests/unit_tests/engine-key/Makefile.am<br>
&gt; &gt; &gt; index 73921965..6d7fc9c5 100644<br>
&gt; &gt; &gt; --- a/tests/unit_tests/engine-key/Makefile.am<br>
&gt; &gt; &gt; +++ b/tests/unit_tests/engine-key/Makefile.am<br>
&gt; &gt; &gt; @@ -10,4 +10,6 @@ TESTS_ENVIRONMENT =3D srcdir=3D&quot;$(abs=
_srcdir)&quot;; \<br>
&gt; &gt; &gt;=C2=A0 TESTS =3D check_engine_keys.sh<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 libtestengine_la_SOURCES =3D libtestengine.c<br>
&gt; &gt; &gt; -libtestengine_la_LDFLAGS =3D -rpath /lib -avoid-version<br>
&gt; &gt; &gt; +libtestengine_la_LDFLAGS =3D @TEST_LDFLAGS@=C2=A0 -rpath /l=
ib<br>
&gt; &gt; &gt; +libtestengine_la_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ -I$(openvpn=
_srcdir)<br>
&gt; &gt; &gt; -I$(compat_srcdir)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; diff --git a/tests/unit_tests/engine-key/libtestengine.c<br>
&gt; &gt; &gt; b/tests/unit_tests/engine-key/libtestengine.c<br>
&gt; &gt; &gt; index fa7f5de1..46ec1e33 100644<br>
&gt; &gt; &gt; --- a/tests/unit_tests/engine-key/libtestengine.c<br>
&gt; &gt; &gt; +++ b/tests/unit_tests/engine-key/libtestengine.c<br>
&gt; &gt; &gt; @@ -30,7 +30,6 @@ static EVP_PKEY *engine_load_key(ENGINE *e=
,<br>
&gt; &gt; &gt; const<br>
&gt; &gt; &gt; char<br>
&gt; &gt; &gt; *key_id,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PKCS8_PRIV_KEY_INFO *p8inf;=
<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UI *ui;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char auth[256];<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0int len;<br>
&gt; &gt; <br>
&gt; &gt; the variable is certainly unused and can go.<br>
&gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;ENGIN=
E: engine_load_key called\n&quot;);<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; diff --git a/tests/unit_tests/engine-key/openssl.cnf<br>
&gt; &gt; &gt; b/tests/unit_tests/engine-key/openssl.cnf<br>
&gt; &gt; &gt; index 53200c46..e9513a92 100644<br>
&gt; &gt; &gt; --- a/tests/unit_tests/engine-key/openssl.cnf<br>
&gt; &gt; &gt; +++ b/tests/unit_tests/engine-key/openssl.cnf<br>
&gt; &gt; &gt; @@ -9,4 +9,4 @@ engines=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 engines_section<br>
&gt; &gt; &gt;=C2=A0 testengine=C2=A0 =C2=A0 =C2=A0=3D testengine_section<b=
r>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 [testengine_section]<br>
&gt; &gt; &gt; -dynamic_path=C2=A0 =C2=A0=3D $ENV::srcdir/.libs/libtestengi=
ne.so<br>
&gt; &gt; &gt; +dynamic_path=C2=A0 =C2=A0=3D $ENV::srcdir/.libs/libtestengi=
ne.dylib<br>
&gt; <br>
&gt; we use gost-engine (<a href=3D"https://github.com/engine/gost-engine" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/engine/gost-engine<=
/a>)<br>
&gt; <br>
&gt; on both linux and osx.<br>
&gt; <br>
&gt; for some time there was a bug in openssl:<br>
&gt; <br>
&gt; <a href=3D"https://github.com/openssl/openssl/issues/8950" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/openssl/openssl/issues/8950</a=
><br>
&gt; <br>
&gt; <br>
&gt; however, for now &quot;dylib&quot; is used for osx. and<br>
&gt; but we do not use &quot;dynamic&quot; path. we use config like that<br>
&gt; <br>
&gt; openssl_conf =3D openssl_def<br>
&gt; <br>
&gt; [openssl_def]<br>
&gt; engines =3D engine_section<br>
&gt; <br>
&gt; [engine_section]<br>
&gt; gost =3D gost_section<br>
&gt; <br>
&gt; [gost_section]<br>
&gt; default_algorithms =3D ALL<br>
&gt; engine_id =3D gost<br>
&gt; CRYPT_PARAMS =3D id-Gost28147-89-CryptoPro-A-ParamSet<br>
<br>
Right, that works if the engine is in the correct directory.=C2=A0 The<br>
problem with this engine is that it&#39;s only built as a test<br>
demonstration for the openvpn engine code, so it&#39;s never installed in<b=
r>
the openssl engines directory, so we have to tell openssl exactly where<br>
to find it in the openvpn tree ... and that seems to involve naming the<br>
whole file and location, including extension.<br>
<br></blockquote><div><br></div><div>yes, I understand reasoning.</div><div=
>maybe we should add dynamic path to our tests as well.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
James<br>
<br>
</blockquote></div></div>

--000000000000dd5be7059e9ea35d--

