MIME-Version: 1.0
References: <CAFHpkQFzOBMUC+qX7vV8jeHxg2MdP6_DCwiUZ=seX7r3DE=cBg@...278...>
 <20210309124712.GJ976@...1296...>
In-Reply-To: <20210309124712.GJ976@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 9 Mar 2021 17:52:12 +0500
Message-ID: <CAFHpkQFqD4HqThaURqi1dCXhjsthDwWg81LdNP4BVWGfGgk_Lg@...278...>
Content-Type: multipart/alternative; boundary="00000000000099bdc305bd1a052e"
Subject: Re: [Openvpn-devel] using openssl feature wherever possible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000099bdc305bd1a052e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 9 =D0=BC=D0=B0=D1=80. 2021 =D0=B3. =D0=B2 17:47, Gert Doering=
 <gert@...1296...>:

> Hi,
>
> On Tue, Mar 09, 2021 at 04:54:13PM +0500, ???????? ?????????????? wrote:
> > if nobody minds, I can send several patches that eliminates comparison =
of
> > OPENSSL_VERSION, for example
>
> We do mind.  They are coded this way on purpose - so when we drop support
> for OpenSSL before 1.1.0, it is clear from the code which sections can
>

it is not much fun to catch things like
https://boringssl.googlesource.com/boringssl/+/49e9f67d8b7cbeb3953b5548ad10=
09d15947a523%5E%21/include/openssl/base.h

(BoringSSL claims itself as 1.1.0, accidentally decided "I'm 1.1.1 now")



> be removed completely.
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--00000000000099bdc305bd1a052e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=82, 9 =D0=BC=D0=B0=D1=80. 2=
021 =D0=B3. =D0=B2 17:47, Gert Doering &lt;<a href=3D"mailto:gert@...2132...=
.">gert@...1296...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Hi,<br>
<br>
On Tue, Mar 09, 2021 at 04:54:13PM +0500, ???????? ?????????????? wrote:<br>
&gt; if nobody minds, I can send several patches that eliminates comparison=
 of<br>
&gt; OPENSSL_VERSION, for example<br>
<br>
We do mind.=C2=A0 They are coded this way on purpose - so when we drop supp=
ort<br>
for OpenSSL before 1.1.0, it is clear from the code which sections can<br><=
/blockquote><div><br></div><div>it is not much fun to catch things like</di=
v><div><a href=3D"https://boringssl.googlesource.com/boringssl/+/49e9f67d8b=
7cbeb3953b5548ad1009d15947a523%5E%21/include/openssl/base.h">https://boring=
ssl.googlesource.com/boringssl/+/49e9f67d8b7cbeb3953b5548ad1009d15947a523%5=
E%21/include/openssl/base.h</a></div><div><br></div><div>(BoringSSL claims =
itself as 1.1.0, accidentally decided &quot;I&#39;m 1.1.1 now&quot;)<br></d=
iv><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
be removed completely.<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div></div>

--00000000000099bdc305bd1a052e--

