MIME-Version: 1.0
In-Reply-To: <CAKuzo_g5CWUYt_uwZ_vpj35whYJoGggHPm10ya6bu-+PNn=_Qw@...278...>
References: <1480022363-24222-1-git-send-email-selva.nair@...277...>
	<1480051264-30193-1-git-send-email-selva.nair@...277...>
	<CAKuzo_g5CWUYt_uwZ_vpj35whYJoGggHPm10ya6bu-+PNn=_Qw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 30 Dec 2016 17:41:52 -0500
Message-ID: <CAKuzo_gDuAOsBD2Nx8anFJ+84W7jNY7Zxf7PxhsWDZpqPMBOpQ@...278...>
Content-Type: multipart/alternative; boundary=001a114349c2b32f230544e7e95c
Subject: Re: [Openvpn-devel] [PATCH v2] Delete the IPv6 route to the
 "connected" network on tun close
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114349c2b32f230544e7e95c
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri, Dec 30, 2016 at 10:58 AM, Selva Nair <selva.nair@...277...> wrote:

>
> Based on Trac #807, it seems removing ipv6 address on tun close is more
> than just good behaviour.


Hmm.. this patch was about deleting ipv6 routes not address, so not really
related to Trac 807, nor as important as I thought. Sorry for the confusion.

Selva

--001a114349c2b32f230544e7e95c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Fri, Dec 30, 2016 at 10:58 AM, S=
elva Nair <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." tar=
get=3D"_blank">selva.nair@...277...</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><div><br></div>Based on Trac #807, it seems removing ipv6 =
address on tun close is more than just good behaviour.</blockquote></div><b=
r></div><div class=3D"gmail_extra">Hmm.. this patch was about deleting ipv6=
 routes not address, so not really related to Trac 807, nor as important as=
 I thought. Sorry for the confusion.<br><br></div><div class=3D"gmail_extra=
">Selva<br></div><div class=3D"gmail_extra"><br></div></div>

--001a114349c2b32f230544e7e95c--

