MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Sun, 7 Feb 2016 15:25:51 -0500
Message-ID: <CAKuzo_gX4qwZg01UR2k=_g1yEY93z3wc1LiyqTXn=WBm3aZvwQ@...278...>
Content-Type: multipart/alternative; boundary=089e0139fd0c218307052b33e5b2
Subject: Re: [Openvpn-devel] GUI repo
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e0139fd0c218307052b33e5b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 7, 2016 at 11:00 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> if you mean interactive service, keep in mind that people sometimes start
> openvpn as a child of openvpn-gui, not as a service


Requiring HighestAvailable was an interim solution until interactive
service becomes available.  Users who do not want to use the interactive
service can use Run As Administrator.

So the idea is to keep the current manifest  in the GUI distributed with
2.3 and remove the HigestAvailable from that to be distributed with 2.4.
This change is also required to let admin users (with UAC) use interactive
service, as the plan is to make the GUI not connect to the service if run
with higher privileges (see my pending pull request).

Selva

--089e0139fd0c218307052b33e5b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_quote"><div dir=3D"ltr"><div cl=
ass=3D"gmail_extra"><br></div><span class=3D""><div class=3D"gmail_extra"><=
div class=3D"gmail_quote">On Sun, Feb 7, 2016 at 11:00 AM, =D0=98=D0=BB=D1=
=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;=
<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsine@...1482...=
...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">if you mean int=
eractive service, keep in mind that people sometimes start openvpn as a chi=
ld of openvpn-gui, not as a service</blockquote></div><br></div></span><div=
 class=3D"gmail_extra">Requiring HighestAvailable was an interim solution u=
ntil interactive service becomes available.=C2=A0 Users who do not want to =
use the interactive service can use Run As Administrator.<br><br></div><div=
 class=3D"gmail_extra">So the idea is to keep the current manifest=C2=A0 in=
 the GUI distributed with 2.3 and remove the HigestAvailable from that to b=
e distributed with 2.4. This change is also required to let admin users (wi=
th UAC) use interactive service, as the plan is to make the GUI not connect=
 to the service if run with higher privileges (see my pending pull request)=
.<span class=3D"HOEnZb"><font color=3D"#888888"><br><br></font></span></div=
><span class=3D"HOEnZb"><font color=3D"#888888"><div class=3D"gmail_extra">=
Selva<br></div></font></span></div>
</div><br></div>

--089e0139fd0c218307052b33e5b2--

