MIME-Version: 1.0
References: <20230315013516.1256700-1-selva.nair@...277...>
 <ZBGCLjjaSwodDPce@...1296...>
In-Reply-To: <ZBGCLjjaSwodDPce@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 15 Mar 2023 09:18:34 -0400
Message-ID: <CAKuzo_gQyjF_uF=bo9ntkgs1hgCJC1Um5xzMXxZ6+R6mxYfQrQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000055718c05f6f02f62"
Subject: Re: [Openvpn-devel] [PATCH 0/4] Add some tests for cryptoapi.c
 functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000055718c05f6f02f62
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2023 at 4:30=E2=80=AFAM Gert Doering <gert@...1296...> wrot=
e:

> Hi,
>
> On Tue, Mar 14, 2023 at 09:35:12PM -0400, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> >   Import some sample certificates into Windows store for testing
> >     - 4 test certificates&keys imported to user store
> >       and removed at the end.
> [..]
>
> This is extremely valuable.  Thanks.
>
> If I apply these 4 patches on top of "master", will the test then succeed,
> or will it show failure due to the not-yet-merged padding patch?
>

As cryptoapi works correctly without the padding patch (only PKCS11 was
affected), and this tests only exercises those bits should work without the
padding patch. Though I tested it only with both included.

Selva

--00000000000055718c05f6f02f62
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 15, 2023 at 4:30=E2=80=AF=
AM Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<b=
r>
<br>
On Tue, Mar 14, 2023 at 09:35:12PM -0400, <a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Import some sample certificates into Windows store for tes=
ting<br>
&gt;=C2=A0 =C2=A0 =C2=A0- 4 test certificates&amp;keys imported to user sto=
re<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0and removed at the end.<br>
[..]<br>
<br>
This is extremely valuable.=C2=A0 Thanks.<br>
<br>
If I apply these 4 patches on top of &quot;master&quot;, will the test then=
 succeed,<br>
or will it show failure due to the not-yet-merged padding patch?<br></block=
quote><div><br></div><div>As cryptoapi works correctly without the padding =
patch (only PKCS11 was affected), and this tests only exercises those bits =
should work without the padding patch. Though I tested it only with both in=
cluded.<br></div><div><br></div><div>Selva</div></div></div>

--00000000000055718c05f6f02f62--

