MIME-Version: 1.0
In-Reply-To: <20161209074250.GQ78624@...1296...>
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<8000a47e-979c-3afc-1a7a-5f8afab85634@...1856...>
	<CAKuzo_ga48WDGd-g8Xp=L1NbXf0Naez1ZRN3FhcyL247bK72Rg@...278...>
	<20161209074250.GQ78624@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 9 Dec 2016 08:24:24 -0500
Message-ID: <CAKuzo_jH1YChyAjpH_rZDoU40fHS-U+hkr6kROoKV2HCigK2iA@...278...>
Content-Type: multipart/alternative; boundary=001a114d8ca46f5e0d054339adbb
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114d8ca46f5e0d054339adbb
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 9, 2016 at 2:42 AM, Gert Doering <gert@...1296...> wrote:

>   if (a>0)
>      { do_this(); }
>   else
>      { do_that(); }
>

In such cases I would normally skip all braces, in spite of all the
arguments against it... But that's just me.

That said the proposed re-formatting looks super good to me and uncrustify
is doing an amazing job. Kudos to all who narrowed down the options.

Selva

--001a114d8ca46f5e0d054339adbb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Dec 9, 2016 at 2:42 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div id=3D":3zi" class=3D"a3s aX=
jCH m158e288e4e33f404">=C2=A0 if (a&gt;0)<br>
=C2=A0 =C2=A0 =C2=A0{ do_this(); }<br>
=C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0{ do_that(); }</div></blockquote></div><br></div><div c=
lass=3D"gmail_extra">In such cases I would normally skip all braces, in spi=
te of all the arguments against it... But that&#39;s just me.<br><br></div>=
<div class=3D"gmail_extra">That said the proposed re-formatting looks super=
 good to me and uncrustify is doing an amazing job. Kudos to all who narrow=
ed down the options.<br><br></div><div class=3D"gmail_extra">Selva<br></div=
></div>

--001a114d8ca46f5e0d054339adbb--

