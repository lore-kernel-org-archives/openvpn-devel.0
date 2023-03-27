MIME-Version: 1.0
References: <20230327114937.28246-1-selva.nair@...277...>
 <139d5059-25b8-e968-2996-5b3bc225ba3b@...68...>
In-Reply-To: <139d5059-25b8-e968-2996-5b3bc225ba3b@...68...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 27 Mar 2023 10:45:15 -0400
Message-ID: <CAKuzo_iMkMXqvHTSX5ZmcurBhx3GT8rd_dbowmtnjaZORyyH1Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000777f9505f7e2cb6e"
Subject: Re: [Openvpn-devel] [PATCH] Make cert_data.h and
 test_cryptoapi/pkcs11.c MSVC compliant
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000777f9505f7e2cb6e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 27, 2023 at 9:59=E2=80=AFAM Matthias Andree <matthias.andree@...1186...=
.68...>
wrote:

> Am 27.03.23 um 13:49 schrieb selva.nair@...277...:
> > From: Selva Nair <selva.nair@...277...>
> >
> > - Do not use non-literal initializers for static objects
> > - Replace empty initializer {} by {0}
>
> Should we go to a revision, I would suggest to not make something
> compliant to a compiler because that is assigning it way too much power
> and control. A terms such as "ready to be compiled with MSVC" or so
> would be in order, or making this code compliant with some wisely chosen
> version of the ISO 9899 standard, aka. standard C.
>

In this case "MSVC compliant" was arguably a poor choice of words as what
the change does is to avoid non-C99 constructs. However it made sense to
refer to MSVC in the context of what prompted this patch.

That said, in a cross-platform code base one often has to make changes to
please compilers just to get things to build.

> Signed-off-by: Selva Nair <selva.nair@...277...>
> > ---
> > To be applied after the test-pkcs11 patch set
> >
> >   tests/unit_tests/openvpn/cert_data.h      |  6 ++---
> >   tests/unit_tests/openvpn/test_cryptoapi.c | 24 ++++++++++++++------
> >   tests/unit_tests/openvpn/test_pkcs11.c    | 27 ++++++++++++++++-------
> >   3 files changed, 39 insertions(+), 18 deletions(-)
> >
> > diff --git a/tests/unit_tests/openvpn/cert_data.h
> b/tests/unit_tests/openvpn/cert_data.h
> > index 33de35ec..0886b071 100644
> > --- a/tests/unit_tests/openvpn/cert_data.h
> > +++ b/tests/unit_tests/openvpn/cert_data.h
> > @@ -79,7 +79,7 @@ static const char *const cert2 =3D
> >
>  "HeTsAlHjfFEReVDiNCI9vMQLKFKKWnAorT2+iyRueA3bt2gchf863BBhZvJddL7Q\n"
> >       "KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFAa+k07ptRkOeablmFdXE81nVlA=3D=3D=
\n"
> >       "-----END CERTIFICATE-----\n";
> > -static const char *const key2 =3D key1;
> > +#define key2 key1
>
> So we are not getting rid of #defines yet? Can't we make this data
> somehow local? Personally, I would probably - at least outside unit

tests - write (key1) instead of bare key, so that it's clear this is one

name and can't be somehow extended.


I was not getting rid of any defines -- just trying to avoid defines if it
can be done without jumping through too many hoops. Right, (key1) would be
better.

Instead of making key2 local, we can write it out fully without referring
to the fact that key1 =3D key2. The latter was anyway a lazy man's choice,
not relevant for the working of the tests.

If anyone feels strongly I can submit a v2 with key2, key4, and cname4
fully written out like:

static const char *const key2 =3D "-----BEGIN PRIVATE KEY-----\n" .......
etc..
static const char *cname4 =3D "ovpn-test-rsa1";

That may also make maintaining this data easier -- ie., any cert/key pair
could be replaced without affecting others.

Selva

--000000000000777f9505f7e2cb6e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Mar 27, 2023 at 9:59=E2=80=AFAM Matthias A=
ndree &lt;<a href=3D"mailto:matthias.andree@...68..." target=3D"_blank">mat=
thias.andree@...68...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Am 27.03.23 um 13:49 schrieb <a href=3D"mailto:selva.n=
air@...277..." target=3D"_blank">selva.nair@...277...</a>:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt;<br>
&gt; - Do not use non-literal initializers for static objects<br>
&gt; - Replace empty initializer {} by {0}<br>
<br>
Should we go to a revision, I would suggest to not make something<br>
compliant to a compiler because that is assigning it way too much power<br>
and control. A terms such as &quot;ready to be compiled with MSVC&quot; or =
so<br>
would be in order, or making this code compliant with some wisely chosen<br>
version of the ISO 9899 standard, aka. standard C.<br></blockquote><div><br=
></div><div>In this case &quot;MSVC compliant&quot; was arguably a poor cho=
ice of words as what the change=C2=A0does is to avoid non-C99 constructs. H=
owever it made sense to refer to MSVC in the context of what prompted this =
patch.</div><div><br></div><div>That said, in a cross-platform code base on=
e often has to make changes to please compilers just to get things to build=
.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;<br>
&gt; ---<br>
&gt; To be applied after the test-pkcs11 patch set<br>
&gt;<br>
&gt;=C2=A0 =C2=A0tests/unit_tests/openvpn/cert_data.h=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 6 ++---<br>
&gt;=C2=A0 =C2=A0tests/unit_tests/openvpn/test_cryptoapi.c | 24 +++++++++++=
+++------<br>
&gt;=C2=A0 =C2=A0tests/unit_tests/openvpn/test_pkcs11.c=C2=A0 =C2=A0 | 27 +=
+++++++++++++++-------<br>
&gt;=C2=A0 =C2=A03 files changed, 39 insertions(+), 18 deletions(-)<br>
&gt;<br>
&gt; diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/o=
penvpn/cert_data.h<br>
&gt; index 33de35ec..0886b071 100644<br>
&gt; --- a/tests/unit_tests/openvpn/cert_data.h<br>
&gt; +++ b/tests/unit_tests/openvpn/cert_data.h<br>
&gt; @@ -79,7 +79,7 @@ static const char *const cert2 =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;HeTsAlHjfFEReVDiNCI9vMQLKFKKWnAorT2+iy=
RueA3bt2gchf863BBhZvJddL7Q\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFAa+k07=
ptRkOeablmFdXE81nVlA=3D=3D\n&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;-----END CERTIFICATE-----\n&quot;;<br>
&gt; -static const char *const key2 =3D key1;<br>
&gt; +#define key2 key1<br>
<br>
So we are not getting rid of #defines yet? Can&#39;t we make this data<br>
somehow local? Personally, I would probably - at least outside unit=C2=A0</=
blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">tests - write =
(key1) instead of bare key, so that it&#39;s clear this is one=C2=A0</block=
quote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">name and can&#39;t =
be somehow extended.</blockquote><div><br></div><div>I was not getting rid =
of any defines -- just trying to avoid defines if it can be done without ju=
mping through too many hoops. Right, (key1) would be better.<br></div><div>=
<br></div><div>Instead of making key2 local, we can write it out fully with=
out referring to the fact that key1 =3D key2. The latter was anyway a lazy =
man&#39;s choice, not relevant for the working of the tests.</div><div><br>=
</div><div>If anyone feels strongly I can submit a v2 with key2, key4, and =
cname4 fully written out like:</div><div><br></div><div>static const char *=
const key2 =3D=C2=A0&quot;-----BEGIN PRIVATE KEY-----\n&quot; ....... etc..=
</div><div>static const char *cname4 =3D &quot;ovpn-test-rsa1&quot;;</div><=
div><br></div><div>That may also make maintaining this data easier -- ie., =
any cert/key pair could be replaced without affecting others.</div><div>=C2=
=A0</div><div>Selva</div></div></div>

--000000000000777f9505f7e2cb6e--

