MIME-Version: 1.0
In-Reply-To: <ea5aa07f-ca42-aae9-c14b-d78d3cdb85b3@...2080...>
References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f73269d2-ba02-5360-9498-378f1e221a56@...277...>
	<CAKuzo_jkyATwPyQkg4mZRAYbUFqc198+yKE-4kyK_--KbRtU=g@...278...>
	<d9c2e940-e72b-cb12-193d-a164bc4ac270@...277...>
	<CAFHpkQF2fF_69jsquGJ=eamkSMVWPRbO7bFOLixP=27QgEEs5g@...278...>
	<CAKuzo_gL-D8mSbOvEzN6N1MZ816=f1xNP_ZUzyiucb4-K0t0hg@...278...>
	<CAFHpkQH3kE62G-EtavknAAZWOdS=0wkERy9FfYyDpbCKZuuHNw@...278...>
	<79b0624d-53fe-8e17-c58a-221434caad32@...1227...>
	<CAKuzo_gwi_T0MFygSN=tCMCMtuaeS2TGwxm7Kin=bhv0H+u4pw@...278...>
	<CAFHpkQG30rhrg5+coYSN-aevYNxSZ8Ucbd=1ncmkMru1rtSz-Q@...278...>
	<CAKuzo_g9RYo7zq79Tw2MaO87bSBTdWaWfbQ4Rdnah4duBCwXHQ@...278...>
	<ea5aa07f-ca42-aae9-c14b-d78d3cdb85b3@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 15 Jun 2017 11:06:05 -0400
Message-ID: <CAKuzo_gYwcw3DuY1cGe17WidEZsb5vpKSwEzE8Gd6448ZYhhCg@...278...>
Content-Type: multipart/alternative; boundary="001a113ac7243f91c8055201034b"
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113ac7243f91c8055201034b
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 15, 2017 at 8:32 AM, David Sommerseth <
openvpn@...2080...> wrote:

> On 13/06/17 22:51, Selva Nair wrote:
> > It takes only a few line sof code to exploit this on XP -- I have not
> > been able to exploit this on Vista but not 100% sure it has been
> > fixed for good on Vista+.
>
> But do we really care much for anything older than Win7 these days?  For
> v2.3, perhaps yes - but v2.4 is the one introducing the interactive
> service.


Even so, I think its still prudent to err on the side of caution and not
allow a client running as admin hand out impersonation rights to a server
it connects to, unless some authentication could be put in place.

Note: Here client is the GUI and server is anything that listens on the
service named pipe --- which is normally the service, but could be a rogue
program. I'm being paranoid, and impersonation via named pipe is probably
secure in recent versions of Windows.

If the GUI is running as admin, so will openvpn and it then doesn't need
the service for any tasks.  So no functionality is lost by not using the
service. However, running the GUI as admin is not a good idea, so a better
way would be to check whether iservice is available and if so drop
privileges and proceed. That way openvpn will also run with limited
privileges.

Indeed it would ease code maintenance if we can drop the numerous ways of
setting routes etc. and exclusively use the service. Until that becomes
acceptable, the use of iservice while admin brings in little benefit, if
any.

Selva

--001a113ac7243f91c8055201034b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Jun 15, 2017 at 8:32 AM, David Sommerseth <span dir=3D"ltr">&lt;<a =
href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2156...<wbr=
>.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204=
,204);border-left-style:solid;padding-left:1ex"><span>On 13/06/17 22:51, Se=
lva Nair wrote:<br>
&gt; It takes only a few line sof code to exploit this on XP -- I have not<=
br>
&gt; been able to exploit this on Vista but not 100% sure it has been<br>
&gt; fixed for good on Vista+.<br>
<br>
</span>But do we really care much for anything older than Win7 these days?=
=C2=A0 For<br>
v2.3, perhaps yes - but v2.4 is the one introducing the interactive service=
.</blockquote></div><div class=3D"gmail_extra"><br></div>Even so, I think i=
ts still prudent to err on the side of caution and not allow a client runni=
ng as admin hand out impersonation rights to a server it connects to, unles=
s some authentication could be put in place.</div><div class=3D"gmail_extra=
"><br></div><div class=3D"gmail_extra">Note: Here client is the GUI and ser=
ver is anything that listens on the service named pipe --- which is normall=
y the service, but could be a rogue program. I&#39;m being paranoid, and im=
personation via named pipe is probably secure in recent versions of Windows=
.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">If t=
he GUI is running as admin, so will openvpn and it then doesn&#39;t need th=
e service for any tasks.=C2=A0 So no functionality is lost by not using the=
 service. However, running the GUI as admin is not a good idea, so a better=
 way would be to check whether iservice is available and if so drop privile=
ges and proceed. That way openvpn will also run with limited privileges.</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Indeed i=
t would ease code maintenance if we can drop the numerous ways of setting r=
outes etc. and exclusively use the service. Until that becomes acceptable, =
the use of iservice while admin brings in little benefit, if any.</div><div=
 class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div><div=
 class=3D"gmail_extra"><br></div></div>

--001a113ac7243f91c8055201034b--

