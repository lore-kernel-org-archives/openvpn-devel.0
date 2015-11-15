MIME-Version: 1.0
In-Reply-To: <CAKuzo_hbgsRaRGSj7UKcsqA7a2hg+_XDy0zt99EPL8haX-rASA@...278...>
References: <CAKuzo_hbgsRaRGSj7UKcsqA7a2hg+_XDy0zt99EPL8haX-rASA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 14 Nov 2015 19:51:19 -0500
Message-ID: <CAKuzo_iKEDanw5c_P9Zuw8LhemAoQ+C8yVypeU=A-avV8tsfnw@...278...>
Content-Type: multipart/alternative; boundary=001a1147471c00c20c052489b24b
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

--001a1147471c00c20c052489b24b
Content-Type: text/plain; charset=UTF-8

On Sat, Nov 14, 2015 at 4:02 PM, Selva Nair <selva.nair@...277...> wrote:

>
> Could you please try with my windows 7 settings -- dhcp for wifi, fixed
> dns server ip on tap, no firewall


On more testing, the fixed dns address on the adapter appears to be the
issue. If dns is pushed from the server or specified in the client config,
I see only a small (few seconds) delay. However, any pushed dns address
appears to be ignored if the interface has a static dns address.

One way to avoid this issue is to require the option --register-dns with
static dns, although that's not what the man page says.

By the way, the added firewall rules can be seen using netsh wfp shell and
debugged by capturing from there. Not sure why it doesn't show up in the
wf.msc UI.

Will test on windows 10 if I can get hold of a machine.

Selva

--001a1147471c00c20c052489b24b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br></div><div class=3D"gmail_e=
xtra"><div class=3D"gmail_quote">On Sat, Nov 14, 2015 at 4:02 PM, Selva Nai=
r <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_=
blank">selva.nair@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><br>Could you please try with my windows 7 settings -- dhcp for wi=
fi, fixed dns server ip on tap, no firewall </blockquote></div><br></div><d=
iv class=3D"gmail_extra">On more testing, the fixed dns address on the adap=
ter appears to be the issue. If dns is pushed from the server or specified =
in the client config, I see only a small (few seconds) delay. However, any =
pushed dns address appears to be ignored if the interface has a static dns =
address. <br><br>One way to avoid this issue is to require the option --reg=
ister-dns with static dns, although that&#39;s not what the man page says. =
<br><br></div><div class=3D"gmail_extra">By the way, the added firewall rul=
es can be seen using netsh wfp shell and debugged by capturing from there. =
Not sure why it doesn&#39;t show up in the wf.msc UI.<br><br></div><div cla=
ss=3D"gmail_extra">Will test on windows 10 if I can get hold of a machine.<=
br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Se=
lva<br></div><div class=3D"gmail_extra"><br><br></div></div>

--001a1147471c00c20c052489b24b--

