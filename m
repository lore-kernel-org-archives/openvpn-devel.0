MIME-Version: 1.0
In-Reply-To: <20160522165620.GC53051@...1296...>
References: <CAKuzo_g1jx2JkxP2BSVYPW4axnMUQgVe=WvBSzC+x8n6LR_A9g@...278...>
	<1463892387-4793-1-git-send-email-selva.nair@...277...>
	<20160522073101.GV53051@...1296...>
	<CAKuzo_gcP+YiNE9tHqkW1aVtsm=wy=wg9yPf0PpUwL1_vDXuYA@...278...>
	<20160522165620.GC53051@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 22 May 2016 13:14:06 -0400
Message-ID: <CAKuzo_jBA2PEv=Y8N1CHheeO9DFmHdCeLbNca-pnBQbHJmk8Mw@...278...>
Content-Type: multipart/alternative; boundary=001a11448a96b7624905337174a5
Subject: Re: [Openvpn-devel] [PATCH] Fix handling of out of memory error in
 interactive service
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

--001a11448a96b7624905337174a5
Content-Type: text/plain; charset=UTF-8

On Sun, May 22, 2016 at 12:56 PM, Gert Doering <gert@...1296...> wrote:

> Mmmh, anyway, I have two options now :-) - ask you for a v2 that is
> MSVC 2010 compatible, and has the initial value reverted to "10", or
> just apply...
>

Let's make life easy -- will do a v2 with both those changes:-) and just
hope if/when we touch that realloc loop in future we'll test it by
exercising it... I normally run 2 connections on my laptop (sometimes 3),
never 10.

As a general rule, which MSVC version to target is still useful to know as
there are a few places in the code requiring ugly scoping brackets as seen
in some pending patches for MSVC compliance.

Selva

--001a11448a96b7624905337174a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, May 22, 2016 at 12:56 PM, Gert Doering <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div id=3D":4qt" class=3D"a3s a=
XjCH m154d9656cd6bf6b4">Mmmh, anyway, I have two options now :-) - ask you =
for a v2 that is<br>
MSVC 2010 compatible, and has the initial value reverted to &quot;10&quot;,=
 or<br>
just apply...</div></blockquote></div><br></div><div class=3D"gmail_extra">=
Let&#39;s make life easy -- will do a v2 with both those changes:-) and jus=
t hope if/when we touch that realloc loop in future we&#39;ll test it by ex=
ercising it... I normally run 2 connections on my laptop (sometimes 3), nev=
er 10.<br><br></div><div class=3D"gmail_extra">As a general rule, which MSV=
C version to target is still useful to know as there are a few places in th=
e code requiring ugly scoping brackets as seen in some pending patches for =
MSVC compliance.<br><br></div><div class=3D"gmail_extra">Selva<br></div></d=
iv>

--001a11448a96b7624905337174a5--

