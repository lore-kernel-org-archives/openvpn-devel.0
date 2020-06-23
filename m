MIME-Version: 1.0
References: <20200622232319.8143-2-James.Bottomley@...2316...>
 <202006230628.05N6Sa3g001325@...2054...>
 <20200623072123.GA2034@...1296...>
 <1592917531.4768.4.camel@...2316...>
 <CAFHpkQF5tz91P_UJxMuNCRDUYodw8QPV8=h8mmkSTHOUH5AdfA@...278...>
 <CAFHpkQH-yGFBJ=-Eaz5XCSaUcD-=S00y=MvPs6Vmr5nE_PcTRg@...278...>
 <1592936237.4768.43.camel@...2316...>
In-Reply-To: <1592936237.4768.43.camel@...2316...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 23 Jun 2020 23:36:49 +0500
Message-ID: <CAFHpkQGQgQm2cEA1kw1JpRkf4Ldu4kT=y-YXF-6cLTXbEx_zDQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000001bff2705a8c4a5e8"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add unit tests for engine
 keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000001bff2705a8c4a5e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 23 =D0=B8=D1=8E=D0=BD. 2020 =D0=B3. =D0=B2 23:17, James Botto=
mley <
James.Bottomley@...2317...>:

> On Tue, 2020-06-23 at 21:43 +0500, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:
> > as far as I understand, openssl-1.0.2 does not support engines ?
>
> No, it does.  Engines were a pre 0.9.8 thing.  I support openssl in my
> builds for the TPM engine down to 1.0.1
>
> However, the failure:
>
> > Key mismatch not detected
> >
> > FAIL: check_engine_keys.sh
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >
> > 1 of 1 test failed
> >
> > Please report to openvpn-users@lists.sourceforge.net
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> Is because an expected message isn't found in the output.  I think it's
> this:
>
>    # first off check we died because of a key mismatch.  If this doesn't
>    # pass, suspect openssl of returning different messages and update the
>    # test accordingly
>    grep -q 'X509_check_private_key:key values mismatch' log.txt || { echo
> "Key mismatch not detected"; exit 1; }
>
>    If I could get hold of log.txt that would confirm that the test is
>    outputting something slightly different from what's expected.
>
>    I did run this test on openssl-1.0.2j (I keep a copy of
>    openSUSE_Leap_42.3 around precisely for this openssl testing) but it
>    ran just fine. so there's clearly something different about the 1.0.2u
>    you're using (might be a locale issue?).
>

I'll have a look. Also, I think we should out log.txt in case of failure.


>
>    James
>
>

--0000000000001bff2705a8c4a5e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=82, 23 =D0=B8=D1=8E=D0=BD. =
2020 =D0=B3. =D0=B2 23:17, James Bottomley &lt;<a href=3D"mailto:James.Bott=
omley@...2317...">James.Bottomley@...2317...</a>&gt;:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Tue, 2020-06-23 at 21:43 +0500, =
=D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<=
br>
&gt; as far as I understand, openssl-1.0.2 does not support engines ?<br>
<br>
No, it does.=C2=A0 Engines were a pre 0.9.8 thing.=C2=A0 I support openssl =
in my<br>
builds for the TPM engine down to 1.0.1<br>
<br>
However, the failure:<br>
<br>
&gt; Key mismatch not detected<br>
&gt; <br>
&gt; FAIL: check_engine_keys.sh<br>
&gt; <br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
&gt; <br>
&gt; 1 of 1 test failed<br>
&gt; <br>
&gt; Please report to <a href=3D"mailto:openvpn-users@lists.sourceforge.net=
" target=3D"_blank">openvpn-users@lists.sourceforge.net</a><br>
&gt; <br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
<br>
Is because an expected message isn&#39;t found in the output.=C2=A0 I think=
 it&#39;s<br>
this:<br>
<br>
=C2=A0 =C2=A0# first off check we died because of a key mismatch.=C2=A0 If =
this doesn&#39;t<br>
=C2=A0 =C2=A0# pass, suspect openssl of returning different messages and up=
date the<br>
=C2=A0 =C2=A0# test accordingly<br>
=C2=A0 =C2=A0grep -q &#39;X509_check_private_key:key values mismatch&#39; l=
og.txt || { echo &quot;Key mismatch not detected&quot;; exit 1; }<br>
<br>
=C2=A0 =C2=A0If I could get hold of log.txt that would confirm that the tes=
t is<br>
=C2=A0 =C2=A0outputting something slightly different from what&#39;s expect=
ed.<br>
<br>
=C2=A0 =C2=A0I did run this test on openssl-1.0.2j (I keep a copy of<br>
=C2=A0 =C2=A0openSUSE_Leap_42.3 around precisely for this openssl testing) =
but it<br>
=C2=A0 =C2=A0ran just fine. so there&#39;s clearly something different abou=
t the 1.0.2u<br>
=C2=A0 =C2=A0you&#39;re using (might be a locale issue?).<br></blockquote><=
div><br></div><div>I&#39;ll have a look. Also, I think we should out <span =
class=3D"gmail-im">log.txt in case of failure.<br></span></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0James<br>
<br>
</blockquote></div></div>

--0000000000001bff2705a8c4a5e8--

