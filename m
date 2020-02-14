MIME-Version: 1.0
References: <1518302884.3072.1.camel@...2316...>
 <1518303011.3072.4.camel@...2316...>
 <778643d1-7f14-a31b-949a-8aab94473e64@...1227...>
 <1581683898.3296.4.camel@...2316...>
In-Reply-To: <1581683898.3296.4.camel@...2316...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 14 Feb 2020 18:33:31 +0500
Message-ID: <CAFHpkQHiu5ChvP+5vgmQLigSq5C-NJ=bzLCxAF+raZm6z6kdKw@...278...>
Content-Type: multipart/alternative; boundary="00000000000014b597059e8941d9"
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

--00000000000014b597059e8941d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 14 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =D0=B2 18:05, James=
 Bottomley <
James.Bottomley@...2317...>:

> On Thu, 2020-02-13 at 19:18 +0100, Arne Schwabe wrote:
> > Am 10.02.18 um 23:50 schrieb James Bottomley:
> > > Testing engines is problematic, so one of the prerequisites built
> > > for the tests is a simple openssl engine that reads a non-standard
> > > PEM guarded key.  The test is simply can we run a client/server
> > > configuration with the usual sample key replaced by an engine key.
> > > The trivial engine prints out some operations and we check for
> > > these in the log to make sure the engine was used to load the key
> > > and that it correctly got the password.
> >
> > This tests the openssl engine functionality in a sensible way. But I
> > think it is not fully ready to be commited. To get it working I
> > needed to do following changes on my Mac:
>
> That could be ... I only have a linux box to try this out on.
>
> > commit afa697cec15b4e54e720efe9de39c9b20b13c5c8 (HEAD ->
> > review/enginekeys)
> > Author: Arne Schwabe <arne@...1227...>
> > Date:   Thu Feb 13 18:13:34 2020 +0100
> >
> >     foo
> >
> > diff --git a/tests/unit_tests/engine-key/Makefile.am
> > b/tests/unit_tests/engine-key/Makefile.am
> > index 73921965..6d7fc9c5 100644
> > --- a/tests/unit_tests/engine-key/Makefile.am
> > +++ b/tests/unit_tests/engine-key/Makefile.am
> > @@ -10,4 +10,6 @@ TESTS_ENVIRONMENT =3D srcdir=3D"$(abs_srcdir)"; \
> >  TESTS =3D check_engine_keys.sh
> >
> >  libtestengine_la_SOURCES =3D libtestengine.c
> > -libtestengine_la_LDFLAGS =3D -rpath /lib -avoid-version
> > +libtestengine_la_LDFLAGS =3D @TEST_LDFLAGS@  -rpath /lib
> > +libtestengine_la_CFLAGS  =3D @TEST_CFLAGS@ -I$(openvpn_srcdir)
> > -I$(compat_srcdir)
> > +
> > diff --git a/tests/unit_tests/engine-key/libtestengine.c
> > b/tests/unit_tests/engine-key/libtestengine.c
> > index fa7f5de1..46ec1e33 100644
> > --- a/tests/unit_tests/engine-key/libtestengine.c
> > +++ b/tests/unit_tests/engine-key/libtestengine.c
> > @@ -30,7 +30,6 @@ static EVP_PKEY *engine_load_key(ENGINE *e, const
> > char
> > *key_id,
> >         PKCS8_PRIV_KEY_INFO *p8inf;
> >         UI *ui;
> >         char auth[256];
> > -       int len;
>
> the variable is certainly unused and can go.
>
> >         fprintf(stderr, "ENGINE: engine_load_key called\n");
> >
> > diff --git a/tests/unit_tests/engine-key/openssl.cnf
> > b/tests/unit_tests/engine-key/openssl.cnf
> > index 53200c46..e9513a92 100644
> > --- a/tests/unit_tests/engine-key/openssl.cnf
> > +++ b/tests/unit_tests/engine-key/openssl.cnf
> > @@ -9,4 +9,4 @@ engines         =3D engines_section
> >  testengine     =3D testengine_section
> >
> >  [testengine_section]
> > -dynamic_path   =3D $ENV::srcdir/.libs/libtestengine.so
> > +dynamic_path   =3D $ENV::srcdir/.libs/libtestengine.dylib
>

we use gost-engine (https://github.com/engine/gost-engine)

on both linux and osx.

for some time there was a bug in openssl:

https://github.com/openssl/openssl/issues/8950


however, for now "dylib" is used for osx. and
but we do not use "dynamic" path. we use config like that

openssl_conf =3D openssl_def

[openssl_def]
engines =3D engine_section

[engine_section]
gost =3D gost_section

[gost_section]
default_algorithms =3D ALL
engine_id =3D gost
CRYPT_PARAMS =3D id-Gost28147-89-CryptoPro-A-ParamSet


>
> This can't really be done though: the .dylib extension won't work on
> Linux because shared objects are .so files.
>
> There is a way to generate and use .so files on a MAC as well,
> according to the openssl people (half the mac engines seem to have a
> .so extension and the other half a .dylib one), I'll see if I can
> figure out what it is.
>
> James
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--00000000000014b597059e8941d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D1=82, 14 =D1=84=D0=B5=D0=B2=
=D1=80. 2020 =D0=B3. =D0=B2 18:05, James Bottomley &lt;<a href=3D"mailto:Ja=
mes.Bottomley@...2317...">James.Bottomley@...2317...</a>&gt;:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">On Thu, 2020-02-13 at 19:18 +=
0100, Arne Schwabe wrote:<br>
&gt; Am 10.02.18 um 23:50 schrieb James Bottomley:<br>
&gt; &gt; Testing engines is problematic, so one of the prerequisites built=
<br>
&gt; &gt; for the tests is a simple openssl engine that reads a non-standar=
d<br>
&gt; &gt; PEM guarded key.=C2=A0 The test is simply can we run a client/ser=
ver<br>
&gt; &gt; configuration with the usual sample key replaced by an engine key=
.<br>
&gt; &gt; The trivial engine prints out some operations and we check for<br>
&gt; &gt; these in the log to make sure the engine was used to load the key=
<br>
&gt; &gt; and that it correctly got the password.<br>
&gt; <br>
&gt; This tests the openssl engine functionality in a sensible way. But I<b=
r>
&gt; think it is not fully ready to be commited. To get it working I<br>
&gt; needed to do following changes on my Mac:<br>
<br>
That could be ... I only have a linux box to try this out on.<br>
<br>
&gt; commit afa697cec15b4e54e720efe9de39c9b20b13c5c8 (HEAD -&gt;<br>
&gt; review/enginekeys)<br>
&gt; Author: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"=
_blank">arne@...1227...</a>&gt;<br>
&gt; Date:=C2=A0 =C2=A0Thu Feb 13 18:13:34 2020 +0100<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0foo<br>
&gt; <br>
&gt; diff --git a/tests/unit_tests/engine-key/Makefile.am<br>
&gt; b/tests/unit_tests/engine-key/Makefile.am<br>
&gt; index 73921965..6d7fc9c5 100644<br>
&gt; --- a/tests/unit_tests/engine-key/Makefile.am<br>
&gt; +++ b/tests/unit_tests/engine-key/Makefile.am<br>
&gt; @@ -10,4 +10,6 @@ TESTS_ENVIRONMENT =3D srcdir=3D&quot;$(abs_srcdir)&q=
uot;; \<br>
&gt;=C2=A0 TESTS =3D check_engine_keys.sh<br>
&gt; <br>
&gt;=C2=A0 libtestengine_la_SOURCES =3D libtestengine.c<br>
&gt; -libtestengine_la_LDFLAGS =3D -rpath /lib -avoid-version<br>
&gt; +libtestengine_la_LDFLAGS =3D @TEST_LDFLAGS@=C2=A0 -rpath /lib<br>
&gt; +libtestengine_la_CFLAGS=C2=A0 =3D @TEST_CFLAGS@ -I$(openvpn_srcdir)<b=
r>
&gt; -I$(compat_srcdir)<br>
&gt; +<br>
&gt; diff --git a/tests/unit_tests/engine-key/libtestengine.c<br>
&gt; b/tests/unit_tests/engine-key/libtestengine.c<br>
&gt; index fa7f5de1..46ec1e33 100644<br>
&gt; --- a/tests/unit_tests/engine-key/libtestengine.c<br>
&gt; +++ b/tests/unit_tests/engine-key/libtestengine.c<br>
&gt; @@ -30,7 +30,6 @@ static EVP_PKEY *engine_load_key(ENGINE *e, const<br>
&gt; char<br>
&gt; *key_id,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PKCS8_PRIV_KEY_INFO *p8inf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UI *ui;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char auth[256];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0int len;<br>
<br>
the variable is certainly unused and can go.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;ENGINE: engine_=
load_key called\n&quot;);<br>
&gt; <br>
&gt; diff --git a/tests/unit_tests/engine-key/openssl.cnf<br>
&gt; b/tests/unit_tests/engine-key/openssl.cnf<br>
&gt; index 53200c46..e9513a92 100644<br>
&gt; --- a/tests/unit_tests/engine-key/openssl.cnf<br>
&gt; +++ b/tests/unit_tests/engine-key/openssl.cnf<br>
&gt; @@ -9,4 +9,4 @@ engines=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D engines_s=
ection<br>
&gt;=C2=A0 testengine=C2=A0 =C2=A0 =C2=A0=3D testengine_section<br>
&gt; <br>
&gt;=C2=A0 [testengine_section]<br>
&gt; -dynamic_path=C2=A0 =C2=A0=3D $ENV::srcdir/.libs/libtestengine.so<br>
&gt; +dynamic_path=C2=A0 =C2=A0=3D $ENV::srcdir/.libs/libtestengine.dylib<b=
r></blockquote><div><br></div><div>we use gost-engine (<a href=3D"https://g=
ithub.com/engine/gost-engine">https://github.com/engine/gost-engine</a>)</d=
iv><div><br></div><div>on both linux and osx.</div><div><br></div><div>for =
some time there was a bug in openssl:<br></div><div><br></div><div><a href=
=3D"https://github.com/openssl/openssl/issues/8950">https://github.com/open=
ssl/openssl/issues/8950</a></div><div><br></div><div><br></div><div>however=
, for now &quot;dylib&quot; is used for osx. and <br></div><div>but we do n=
ot use &quot;dynamic&quot; path. we use config like that</div><div><br></di=
v><div>openssl_conf =3D openssl_def<br><br>[openssl_def]<br>engines =3D eng=
ine_section<br><br>[engine_section]<br>gost =3D gost_section<br><br>[gost_s=
ection]<br>default_algorithms =3D ALL<br>engine_id =3D gost<br>CRYPT_PARAMS=
 =3D id-Gost28147-89-CryptoPro-A-ParamSet<br></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
This can&#39;t really be done though: the .dylib extension won&#39;t work o=
n<br>
Linux because shared objects are .so files.<br>
<br>
There is a way to generate and use .so files on a MAC as well,<br>
according to the openssl people (half the mac engines seem to have a<br>
.so extension and the other half a .dylib one), I&#39;ll see if I can<br>
figure out what it is.<br>
<br>
James<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--00000000000014b597059e8941d9--

