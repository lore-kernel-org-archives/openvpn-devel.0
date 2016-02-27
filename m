MIME-Version: 1.0
In-Reply-To: <CABudjpFr_xBaCsHgeLvsATaBHR5_=R88QWQ+7OY=9fZKmVG1Mg@...278...>
References: <CABudjpFr_xBaCsHgeLvsATaBHR5_=R88QWQ+7OY=9fZKmVG1Mg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 27 Feb 2016 12:12:57 -0500
Message-ID: <CAKuzo_h1HdoTy=LGGxhEpzWsiD9ht86=Y+3yJir1f-t22VUvTQ@...278...>
Content-Type: multipart/alternative; boundary=001a11c2d5ce1be857052cc38818
Subject: Re: [Openvpn-devel] configuration check
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: pill man <the.pill.man.si@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11c2d5ce1be857052cc38818
Content-Type: text/plain; charset=UTF-8

On Fri, Feb 26, 2016 at 8:06 AM, pill man <the.pill.man.si@...277...> wrote:

> Hi!
> I posted this https://forums.openvpn.net/topic21088.html
> on forum but nobody answers. Please help


To find which route will be taken to a destination (say 172.16.56.1) try

ip route get to 172.16.56.1

Adding multiple routes to the same destination might have succeeded (check
using ip route show), but it will not provide any load balancing.

Selva

--001a11c2d5ce1be857052cc38818
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Feb 26, 2016 at 8:06 AM, pill man <span dir=3D"ltr">&lt;<a href=3D"=
mailto:the.pill.man.si@...277..." target=3D"_blank">the.pill.man.si@...1354...=
..</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>Hi!</div>
<div>I posted this <a title=3D"https://forums.openvpn.net/topic21088.html" =
href=3D"https://forums.openvpn.net/topic21088.html" target=3D"_blank">https=
://forums.openvpn.net/topic21088.html</a></div>
on forum but nobody answers. Please help</blockquote></div><br></div><div c=
lass=3D"gmail_extra">To find which route will be taken to a destination (sa=
y 172.16.56.1) try<br><br></div><div class=3D"gmail_extra">ip route get to =
172.16.56.1<br><br></div><div class=3D"gmail_extra">Adding multiple routes =
to the same destination might have succeeded (check using ip route show), b=
ut it will not provide any load balancing.<br><br></div><div class=3D"gmail=
_extra">Selva<br></div></div>

--001a11c2d5ce1be857052cc38818--

