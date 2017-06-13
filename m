MIME-Version: 1.0
In-Reply-To: <CAFHpkQF2fF_69jsquGJ=eamkSMVWPRbO7bFOLixP=27QgEEs5g@...278...>
References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f73269d2-ba02-5360-9498-378f1e221a56@...277...>
	<CAKuzo_jkyATwPyQkg4mZRAYbUFqc198+yKE-4kyK_--KbRtU=g@...278...>
	<d9c2e940-e72b-cb12-193d-a164bc4ac270@...277...>
	<CAFHpkQF2fF_69jsquGJ=eamkSMVWPRbO7bFOLixP=27QgEEs5g@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 13 Jun 2017 14:00:19 -0400
Message-ID: <CAKuzo_gL-D8mSbOvEzN6N1MZ816=f1xNP_ZUzyiucb4-K0t0hg@...278...>
Content-Type: multipart/alternative; boundary="94eb2c03d468a34c240551db362d"
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c03d468a34c240551db362d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 1:25 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> I decided to try some tests .. in fact I only did one test.
> I rebooted the PC and now the second IP address has gone.
> (Windows Fast shutdown/reboot disabled .. so full reboot)
>
> I also tried to recreate the problem but so far cannot ..
>
>
> It might happen if openvpn dies without a chance of deleting associated
> ipv6 routes.
>

Not if openvpn dies: interactive service will do the cleanup in that case.
If the service dies, yes, the address will not be removed but even in that
case address added to one interface cannot show up on another.

Selva

--94eb2c03d468a34c240551db362d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jun 13, 2017 at 1:25 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipits=
ine@...277..." target=3D"_blank">chipitsine@...277...</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div><div class=3D"gmail_extra"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"m_1401400619666117296quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I decide=
d to try some tests .. in fact I only did one test.<br>
I rebooted the PC and now the second IP address has gone.<br>
(Windows Fast shutdown/reboot disabled .. so full reboot)<br>
<br>
I also tried to recreate the problem but so far cannot ..<br></blockquote><=
/div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It might hap=
pen if openvpn dies without a chance of deleting associated ipv6 routes.</d=
iv></blockquote></div><br>Not if openvpn dies: interactive service will do =
the cleanup in that case. If the service dies, yes, the address will not be=
 removed but even in that case address added to one interface cannot show u=
p on another.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail=
_extra">Selva</div></div>

--94eb2c03d468a34c240551db362d--

