MIME-Version: 1.0
References: <20201220105430.GP976@...1296...>
In-Reply-To: <20201220105430.GP976@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 20 Dec 2020 11:39:27 -0500
Message-ID: <CAKuzo_iRbwMLPze-C-e5q-ZRkHijQX6rSNcSBH8iVA4hFuYHhw@...278...>
Content-Type: multipart/alternative; boundary="000000000000264d2b05b6e7fdd3"
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
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

--000000000000264d2b05b6e7fdd3
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Dec 20, 2020 at 5:55 AM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> I find myself looking for a mechanism by which I could send informational
> messages ("your cert expires in two weeks, go refresh!" - "your openvpn
> client needs an upgrade") from the openvpn server to incoming clients.
>
> Of course this should work with all connecting clients, that is, "text
> clients", windows GUI, Tunnelblick, iOS Connect, Android.
>
> As far as I am aware, there is no such mechanism today.
>

We once had extensive discussions on using echo for this. As echo
commands are up to the UI to interpret, adding new one's does
not require any changes in the core.

I had posted a draft implementation for OpenVPN-GUI (not sure it still
works, though) along with some details of the message syntax:
https://github.com/selvanair/openvpn-gui/releases/tag/v11-echo-msg

IIRC, Jonathan had written up documentation for the proposed syntax.
I don't have links to the relevant mails at hand, but should be in the
archives.

It may be best to resurrect that effort.

Selva

--000000000000264d2b05b6e7fdd3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 20, 2020 at 5:55 AM Gert D=
oering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1826...=
6...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Hi,<br>
<br>
I find myself looking for a mechanism by which I could send informational<b=
r>
messages (&quot;your cert expires in two weeks, go refresh!&quot; - &quot;y=
our openvpn<br>
client needs an upgrade&quot;) from the openvpn server to incoming clients.=
<br>
<br>
Of course this should work with all connecting clients, that is, &quot;text=
<br>
clients&quot;, windows GUI, Tunnelblick, iOS Connect, Android.<br>
<br>
As far as I am aware, there is no such mechanism today.<br></blockquote><di=
v><br></div><div>We once had extensive discussions on using echo for this. =
As echo=C2=A0</div><div>commands are up to the UI to interpret, adding new =
one&#39;s does</div><div>not require any changes in the core.</div><div><br=
></div><div>I had posted a draft implementation for OpenVPN-GUI (not sure i=
t still=C2=A0</div><div>works, though) along with some details of the messa=
ge syntax:=C2=A0</div><div><a href=3D"https://github.com/selvanair/openvpn-=
gui/releases/tag/v11-echo-msg" target=3D"_blank">https://github.com/selvana=
ir/openvpn-gui/releases/tag/v11-echo-msg</a></div><div><br></div><div>IIRC,=
 Jonathan had written up documentation for the proposed syntax.</div><div>I=
 don&#39;t have links to the relevant mails at hand, but should be in the=
=C2=A0</div><div>archives.=C2=A0=C2=A0<br></div><div><br></div><div>It may =
be best to resurrect that effort.</div><div><br></div><div>Selva</div></div=
></div>

--000000000000264d2b05b6e7fdd3--

