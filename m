MIME-Version: 1.0
In-Reply-To: <CABMULtLadEa8O6OoPoO1183Z2=-A-GV8sxbUUFKDLQzkuDb0CA@...278...>
References: <CABMULtLadEa8O6OoPoO1183Z2=-A-GV8sxbUUFKDLQzkuDb0CA@...278...>
From: Alex K <rightkicktech@...277...>
Date: Fri, 15 Sep 2017 19:29:30 +0300
Message-ID: <CABMULtJqn_dsA1ywpH14cB3VYuGg_0R6D5tEziKjcE2Df-KK+A@...278...>
Content-Type: multipart/alternative; boundary="94eb2c088af0c80c9305593ce52c"
Subject: Re: [Openvpn-devel] Per client cipher
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--94eb2c088af0c80c9305593ce52c
Content-Type: text/plain; charset="UTF-8"

Sory, just found out from man openvpn and the option is --ncp-disable.

Thanx,
Alex


On Fri, Sep 15, 2017 at 7:23 PM, Alex K <rightkicktech@...277...> wrote:

> Hi All,
>
> I am testing per client cipher with 2.4.3-1 and patch from
> https://community.openvpn.net/openvpn/ticket/845.
>
> As per Gert feedback, seems that when the client has same openvpn version 2.4.3-1,
> I have to disable ncp (using --disable-ncp).
>
> Do I need to apply additional patch to support --disable-ncp? When trying
> with current build the client complains that it does not recognize the
> option.
>
> Options error: Unrecognized option or missing or extra parameter(s) in
> /etc/openvpn/client.conf:42: disable-ncp (2.4.3)
>
>
> Thanx,
> Alex
>

--94eb2c088af0c80c9305593ce52c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Sory, just found out from man openvpn and the op=
tion is --ncp-disable. <br><br></div>Thanx, <br></div>Alex<br><div><div><br=
></div></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">On Fri, Sep 15, 2017 at 7:23 PM, Alex K <span dir=3D"ltr">&lt;<a href=3D"=
mailto:rightkicktech@...277..." target=3D"_blank">rightkicktech@...277...</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><di=
v><div><div><div><div><div><div>Hi All, <br><br></div>I am testing per clie=
nt cipher with 2.4.3-1 and patch from <span class=3D"m_6028449339131131364g=
mail-im"><a href=3D"https://community.openvpn.net/openvpn/ticket/845" rel=
=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/<wbr>openvp=
n/ticket/845</a>.<br><br></span></div><span class=3D"m_6028449339131131364g=
mail-im">As per Gert feedback, seems that when the client has same openvpn =
version </span>2.4.3-1, I have to disable ncp (using --disable-ncp). <br><b=
r></div>Do I need to apply additional patch to support --disable-ncp? When =
trying with current build the client complains that it does not recognize t=
he option. <br><br><span style=3D"font-family:monospace,monospace">Options =
error: Unrecognized option or missing or extra parameter(s) in /etc/openvpn=
/client.conf:42: disable-ncp (2.4.3)</span><br><br></div></div><br></div>Th=
anx, <br></div>Alex<br></div>
</blockquote></div><br></div>

--94eb2c088af0c80c9305593ce52c--

