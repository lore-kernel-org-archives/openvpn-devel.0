MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Sat, 14 Nov 2015 16:02:33 -0500
Message-ID: <CAKuzo_hbgsRaRGSj7UKcsqA7a2hg+_XDy0zt99EPL8haX-rASA@...278...>
Content-Type: multipart/alternative; boundary=047d7bf10a9ed7850b0524867f98
Subject: Re: [Openvpn-devel] [PATCH v2] Add Windows DNS Leak fix using WFP
	('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, ValdikSS ValdikSS <iam@...2070...>

--047d7bf10a9ed7850b0524867f98
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat, Nov 14, 2015 at 3:20 PM, ValdikSS <iam@...2070...> wrote:

> Hi.
> It stops resolving DNS right after connection for me every time too, but
> that lasts 15 seconds at most, not the minutes.
>

Hmm.. one could live with 15 seconds but not 15 minutes. That's how long it
took when I tried it again watching the clock... Obviously this has to be
fixed before the code could be reviewed..


> I've no idea what could be wrong. Lev has a similar issue. I can't
> reproduce it in Windows 7, Windows 8.1 and Windows 10 on both VMs and real
> hardware.
>

Could you please try with my windows 7 settings -- dhcp for wifi, fixed dns
server ip on tap, no firewall enabled, DNS client service (dnscache)
enabled.

By the way, it works without any noticeable delay if I disable dnscache
(just stopping the service is not enough as it gets restarted when the vpn
reconnects).

Regards,

Selva

--047d7bf10a9ed7850b0524867f98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_quote"><div dir=3D"ltr"><div cl=
ass=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><div class=3D"gmai=
l_quote"><span class=3D"">On Sat, Nov 14, 2015 at 3:20 PM, ValdikSS <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:iam@...2070..." target=3D"_blank">iam@...1665...=
070...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div bgcolor=3D"#FFFFFF" text=3D"#000000">Hi.<br>
    It stops resolving DNS right after connection for me every time too,
    but that lasts 15 seconds at most, not the minutes.<br>
    </div></blockquote></span><div><br>Hmm.. one could live with 15 seconds=
 but not 15 minutes. That&#39;s how long
 it took when I tried it again watching the clock... Obviously this has to =
be=20
fixed before the code could be reviewed..<br>=C2=A0</div><span class=3D""><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"#FFFFFF" t=
ext=3D"#000000">I&#39;ve no idea what could be wrong. Lev has a similar iss=
ue. I can&#39;t
    reproduce it in Windows 7, Windows 8.1 and Windows 10 on both VMs
    and real hardware.<span></span></div></blockquote></span></div><br>Coul=
d you please try with my windows 7 settings -- dhcp for wifi, fixed dns ser=
ver ip on tap, no firewall enabled, DNS client service (dnscache) enabled.<=
br><br></div><div class=3D"gmail_extra">By the way, it works without any no=
ticeable delay if I disable dnscache (just stopping the service is not enou=
gh as it gets restarted when the vpn reconnects).<br></div><div class=3D"gm=
ail_extra"><br></div><div class=3D"gmail_extra">Regards,<br></div><div clas=
s=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva<br></div><div =
class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><br></div></div>
</div><br></div>

--047d7bf10a9ed7850b0524867f98--

