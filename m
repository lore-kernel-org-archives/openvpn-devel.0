MIME-Version: 1.0
References: <CAFHpkQFOUB6hq4rQjCGLvbXprjvUL0aD3y107oYj15t6CSMxTg@...278...>
 <20190626063502.GS1097@...1296...>
 <9f92ae0a-cae6-39bd-932b-fa977686f27a@...1227...>
In-Reply-To: <9f92ae0a-cae6-39bd-932b-fa977686f27a@...1227...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 26 Jun 2019 17:19:19 +0500
Message-ID: <CAFHpkQFn0Yn8dWya9H=EgC4MLugvrpHLkA=-eqyscQWZy_eDCw@...278...>
Content-Type: multipart/alternative; boundary="000000000000ba1458058c390e80"
Subject: Re: [Openvpn-devel] how to migrate users to "no compression" config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000ba1458058c390e80
Content-Type: text/plain; charset="UTF-8"

Should we add some high level documentation on compression?

On Wed, Jun 26, 2019, 5:05 PM Arne Schwabe <arne@...1227...> wrote:

> Am 26.06.19 um 08:35 schrieb Gert Doering:
> > Hi,
> >
> > On Wed, Jun 26, 2019 at 01:48:34AM +0500, ???????? ?????????????? wrote:
> >> 2) use push "compress empty" (if there's such an option) ?
> >
> > you can do
> >
> >   push "compress"
> >
> > with no arguments.  According to the docs, this will enable compression
> > framing format, but no actual compression.
> >
>
> Better use stub-v2 since that has no extra byte added and is also
> compatible with clients that do not have a compress/comp-lzo directive.
>
> (Unless you have packets that look like IPv5)
>
> There is also a IV_STUB_V2=1 (or similar to detect if the client can do
> this)
>
> Arne
>

--000000000000ba1458058c390e80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Should we add some high level documentation on compressio=
n?</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, Jun 26, 2019, 5:05 PM Arne Schwabe &lt;<a href=3D"mailto:arne@...493...=
1227...">arne@...1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">Am 26.06.19 um 08:35 schrieb Gert Doering:<br>
&gt; Hi,<br>
&gt; <br>
&gt; On Wed, Jun 26, 2019 at 01:48:34AM +0500, ???????? ?????????????? wrot=
e:<br>
&gt;&gt; 2) use push &quot;compress empty&quot; (if there&#39;s such an opt=
ion) ?<br>
&gt; <br>
&gt; you can do <br>
&gt; <br>
&gt;=C2=A0 =C2=A0push &quot;compress&quot;<br>
&gt; <br>
&gt; with no arguments.=C2=A0 According to the docs, this will enable compr=
ession<br>
&gt; framing format, but no actual compression.<br>
&gt; <br>
<br>
Better use stub-v2 since that has no extra byte added and is also<br>
compatible with clients that do not have a compress/comp-lzo directive.<br>
<br>
(Unless you have packets that look like IPv5)<br>
<br>
There is also a IV_STUB_V2=3D1 (or similar to detect if the client can do<b=
r>
this)<br>
<br>
Arne<br>
</blockquote></div>

--000000000000ba1458058c390e80--

