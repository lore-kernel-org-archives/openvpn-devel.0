MIME-Version: 1.0
References: <CAFHpkQFauuHVbkLAVCz2b1s2m4dwUjxQPyBn9Laa0BmwyYQmGQ@...278...>
 <CAFHpkQFwOTOrqucoFs+mcLr7bCvVzYnUhK7hEM084suOFjm85Q@...278...>
 <CAA1AbxLG8Ab+zU-V8N_5u8mnLRGXWXy5a9FYgVEM6NVHr8_2HA@...278...>
In-Reply-To: <CAA1AbxLG8Ab+zU-V8N_5u8mnLRGXWXy5a9FYgVEM6NVHr8_2HA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 17 Apr 2019 15:06:41 +0500
Message-ID: <CAFHpkQHBURmteQi1eXqp=W9opx4H7oM-EmdbSVry-JJN6pMvdw@...278...>
Content-Type: multipart/alternative; boundary="0000000000007d60f40586b70b4b"
Subject: Re: [Openvpn-devel] cirrus-ci: freebsd builds ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000007d60f40586b70b4b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 17 =D0=B0=D0=BF=D1=80. 2019 =D0=B3. =D0=B2 14:45, Steffan Kar=
ger <steffan@...1856...>:

> On Thu, 11 Apr 2019 at 00:54, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
> > 1) error when built with mbedtls-2.16.0 (surprizingly, build does not
> fail)
> >
> > [       OK ] tls_crypt_v2_wrap_unwrap_no_metadata
> > [ RUN      ] tls_crypt_v2_wrap_unwrap_max_metadata
> > [       OK ] tls_crypt_v2_wrap_unwrap_max_metadata
> > [ RUN      ] tls_crypt_v2_wrap_too_long_metadata
> > ERROR: could not crypt: insufficient space in dst
>
> This is not a test error, but an error message printed by the code
> that is tested. See the test name, it feeds the code too much
> metadata, and checks that the code errors out as expected.
>
> > 2) base64 is missing --> build is ok (we have similar "failures" on
> travis-ci osx builds)
> >
> > Testing tls-crypt-v2 key generation (max length
> metadata)..../t_lpback.sh: base64: not found
> > OK
> > PASS: t_lpback.sh
>
> This is an error in t_lpback.sh, will check it out.
>

that bug also appears on osx

https://travis-ci.org/OpenVPN/openvpn/jobs/518916670#L1477-L1485


>
> -Steffan
>

--0000000000007d60f40586b70b4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 17 =D0=
=B0=D0=BF=D1=80. 2019 =D0=B3. =D0=B2 14:45, Steffan Karger &lt;<a href=3D"m=
ailto:steffan@...1856...">steffan@...1856...</a>&gt;:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Thu, 11 Apr 2019 at 00:54, =D0=98=
=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=
=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsine@...277...</a>=
&gt; wrote:<br>
&gt; 1) error when built with mbedtls-2.16.0 (surprizingly, build does not =
fail)<br>
&gt;<br>
&gt; [=C2=A0 =C2=A0 =C2=A0 =C2=A0OK ] tls_crypt_v2_wrap_unwrap_no_metadata<=
br>
&gt; [ RUN=C2=A0 =C2=A0 =C2=A0 ] tls_crypt_v2_wrap_unwrap_max_metadata<br>
&gt; [=C2=A0 =C2=A0 =C2=A0 =C2=A0OK ] tls_crypt_v2_wrap_unwrap_max_metadata=
<br>
&gt; [ RUN=C2=A0 =C2=A0 =C2=A0 ] tls_crypt_v2_wrap_too_long_metadata<br>
&gt; ERROR: could not crypt: insufficient space in dst<br>
<br>
This is not a test error, but an error message printed by the code<br>
that is tested. See the test name, it feeds the code too much<br>
metadata, and checks that the code errors out as expected.<br>
<br>
&gt; 2) base64 is missing --&gt; build is ok (we have similar &quot;failure=
s&quot; on travis-ci osx builds)<br>
&gt;<br>
&gt; Testing tls-crypt-v2 key generation (max length metadata)..../t_lpback=
.sh: base64: not found<br>
&gt; OK<br>
&gt; PASS: t_lpback.sh<br>
<br>
This is an error in t_lpback.sh, will check it out.<br></blockquote><div><b=
r></div><div>that bug also appears on osx</div><div><br></div><div><a href=
=3D"https://travis-ci.org/OpenVPN/openvpn/jobs/518916670#L1477-L1485">https=
://travis-ci.org/OpenVPN/openvpn/jobs/518916670#L1477-L1485</a><br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-Steffan<br>
</blockquote></div></div></div>

--0000000000007d60f40586b70b4b--

