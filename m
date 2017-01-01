MIME-Version: 1.0
In-Reply-To: <20170101184754.GF78624@...1296...>
References: <024d01d26459$2589a3d0$709ceb70$@gmail.com>
	<20170101182035.GE78624@...1296...>
	<028801d2645d$6c491270$44db3750$@gmail.com>
	<20170101184754.GF78624@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 1 Jan 2017 15:01:40 -0500
Message-ID: <CAKuzo_ip-nUoBoBcxnuXL1Yw86qiSXmT5rV22xHkDmvgGN_cmQ@...278...>
Content-Type: multipart/alternative; boundary=001a114230967e24ad05450de8ab
Subject: Re: [Openvpn-devel] Visual Studio support?
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

--001a114230967e24ad05450de8ab
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Jan 1, 2017 at 1:47 PM, Gert Doering <gert@...1296...> wrote:

> On Sun, Jan 01, 2017 at 10:32:34AM -0800, Fish Wang wrote:
> > Thanks for your (and Steffan's) reply.
> >
> > I also noticed that 2.4 and 2.5 only supports Vista+, so it might make
> sense
> > to remove dynamic function loading for WPF in openvpnserv (see all those
> > LoadLibrary and GetProcAddress code in [1]).
>
> I leave that for Selva or Heiko to comment on.


As interactive service is only available in 2.4+ which does not support XP,
the run time lookup of those functions is not required and could be removed.

Selva

--001a114230967e24ad05450de8ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Jan 1, 2017 at 1:47 PM, Ger=
t Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><span class=3D"">On Sun, Jan 01, 2017 at 10:32:34AM -0800, Fish Wa=
ng wrote:<br>
&gt; Thanks for your (and Steffan&#39;s) reply.<br>
&gt;<br>
&gt; I also noticed that 2.4 and 2.5 only supports Vista+, so it might make=
 sense<br>
&gt; to remove dynamic function loading for WPF in openvpnserv (see all tho=
se<br>
&gt; LoadLibrary and GetProcAddress code in [1]).<br>
<br>
</span>I leave that for Selva or Heiko to comment on.</blockquote></div><br=
></div><div class=3D"gmail_extra">As interactive service is only available =
in 2.4+ which does not support XP, the run time lookup of those functions i=
s not required and could be removed.<br><br></div><div class=3D"gmail_extra=
">Selva<br><br></div></div>

--001a114230967e24ad05450de8ab--

