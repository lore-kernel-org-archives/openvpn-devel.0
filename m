MIME-Version: 1.0
In-Reply-To: <562B67B2.30808@...1490...>
References: <56211F0D.2010806@...515...> <2421664.qQJpUDo69u@...1526...>
	<56261F0D.9020208@...515...> <1921973.yRGlOPzy2x@...2001...>
	<20151022075000.GD22054@...1296...> <562B67B2.30808@...1490...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 24 Oct 2015 11:44:18 -0400
Message-ID: <CAKuzo_juuyCA_aN27YogrB2JB1kEVcfVnt7cD6wZrBwGWeew+A@...278...>
Content-Type: multipart/alternative; boundary=047d7bb04a621001d50522db9b96
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jason Haar <Jason_Haar@...1490...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7bb04a621001d50522db9b96
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat, Oct 24, 2015 at 7:12 AM, Jason Haar <Jason_Haar@...1490...> wrote:

> On 22/10/15 20:50, Gert Doering wrote:
> > I've heard people ask for "we need the VPN to be up before user login so
> > windows domain login works!" - so the GUI won't be around yet.
> >
> > Now, not being a windows person and not running this domain stuff I'm
> > not sure if there are other ways to achieve that - but this is what has
> > been told to me...
> I can confirm that is precisely the way we use openvpn. We use it as an
> "always on vpn" and so it needs to be running via a service at boot
> time. nssm works well for us in that regard
>

Sure, this is easily achieved if no user passwords are involved.

As Gert pointed out, some people need more than this. For example, they
want the ability to log on to a domain through the VPN while the latter
requires user credentials to start in the first place. Some commercial VPN
offerings have this feature (what Cisco used to call  (and may be still
calls) Start before logon. In recent versions of windows this could be
probably achieved by integrating with Single Sign On or PLAP, may be..

We have a setup where users logon to a domain and openvpn needs the same
domain user/password to authenticate through LDAP. But of course we don't
have any Start before logon...-- just the service and MI-GUI. It still
works ok because of cached credentials in windows. So the machine logs the
user in using cached credentials, although the domain controller is not
reachable yet. Then the GUI, set to autostart on logon, prompts for the vpn
password which is finally passed through to the waiting openvpn through the
MI. The repeated password entry is a minor pain, and possibly SSO could be
used spare the user of that. Not sure how much coding is needed to
integrate with SSO.

However our use of domain is pretty dumb: just for smb shares and mapped
drives which can wait until the vpn authenticates. User profiles are all
local, not transferred from a central server. Although we are religious
about not letting the domain controller take over us,  that's not how
domains are used in real windows world. So some people may really (really?)
need the so called "Start Before Logon", implementing which may be much
more work.

Selva

--047d7bb04a621001d50522db9b96
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sat, Oct 24, 2015 at 7:12 AM, Ja=
son <span tabindex=3D"-1" id=3D":4ex.1" style=3D"" class=3D"">Haar</span> <=
span dir=3D"ltr">&lt;<a href=3D"mailto:Jason_Haar@...1490..." target=3D"_bl=
ank">Jason_<span tabindex=3D"-1" id=3D":4ex.2" style=3D"" class=3D"">Haar</=
span>@<span tabindex=3D"-1" id=3D":4ex.3" style=3D"" class=3D"">trimble</sp=
an>.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>On 22=
/10/15 20:50, Gert Doering wrote:<br>
&gt; I&#39;ve heard people ask for &quot;we need the VPN to be up before us=
er login so<br>
&gt; windows domain login works!&quot; - so the GUI won&#39;t be around yet=
.<br>
&gt;<br>
&gt; Now, not being a windows person and not running this domain stuff I&#3=
9;m<br>
&gt; not sure if there are other ways to achieve that - but this is what ha=
s<br>
&gt; been told to me...<br>
</span>I can confirm that is precisely the way we use openvpn. We use it as=
 an<br>
&quot;always on vpn&quot; and so it needs to be running via a service at bo=
ot<br>
time. nssm works well for us in that regard<div><div></div></div></blockquo=
te></div><br>Sure, this is easily achieved if no user passwords are involve=
d.<br><br>As Gert pointed out, some people need more than this. For example=
, they want the ability to log on to a domain through the <span tabindex=3D=
"-1" id=3D":4ex.4" style=3D"" class=3D"">VPN</span> while the latter requir=
es user credentials to start in the first place. Some commercial <span tabi=
ndex=3D"-1" id=3D":4ex.5" style=3D"" class=3D"">VPN</span> offerings have t=
his feature (what <span tabindex=3D"-1" id=3D":4ex.6" style=3D"" class=3D""=
>Cisco</span> used to call=C2=A0 (and may be still calls) Start before <spa=
n tabindex=3D"-1" id=3D":4ex.7" style=3D"" class=3D"">logon</span>. In rece=
nt versions of windows this could be probably achieved by integrating with =
Single Sign On or <span tabindex=3D"-1" id=3D":4ex.8" style=3D"" class=3D""=
>PLAP</span>, may be..<br><br></div><div class=3D"gmail_extra">We have a se=
tup where users <span tabindex=3D"-1" id=3D":4ex.9" style=3D"" class=3D"">l=
ogon</span> to a domain and <span tabindex=3D"-1" id=3D":4ex.10" style=3D""=
 class=3D"">openvpn</span> needs the same domain user/password to authentic=
ate through <span tabindex=3D"-1" id=3D":4ex.11" style=3D"" class=3D"">LDAP=
</span>. But of course we don&#39;t have any Start before <span tabindex=3D=
"-1" id=3D":4ex.12" style=3D"" class=3D"">logon</span>...-- just the servic=
e and MI-GUI. It still works <span tabindex=3D"-1" id=3D":4ex.13" style=3D"=
" class=3D"">ok</span> because of cached credentials in windows. So the mac=
hine logs the user in using cached credentials, although the domain control=
ler is not reachable yet. Then the GUI, set to <span tabindex=3D"-1" id=3D"=
:4ex.14" style=3D"" class=3D"">autostart</span> on <span tabindex=3D"-1" id=
=3D":4ex.15" style=3D"" class=3D"">logon</span>, prompts for the <span tabi=
ndex=3D"-1" id=3D":4ex.16" style=3D"" class=3D"">vpn</span> password which =
is finally passed through to the waiting <span tabindex=3D"-1" id=3D":4ex.1=
7" style=3D"" class=3D"">openvpn</span> through the MI. The repeated passwo=
rd entry is a minor pain, and possibly <span tabindex=3D"-1" id=3D":4ex.18"=
 style=3D"" class=3D"">SSO</span> could be used spare the user of that. Not=
 sure how much coding is needed to integrate with <span tabindex=3D"-1" id=
=3D":4ex.19" style=3D"" class=3D"">SSO</span>.<br><br>However our use of do=
main is pretty dumb: just for <span tabindex=3D"-1" id=3D":4ex.20" style=3D=
"" class=3D"">smb</span> shares and mapped drives which can wait until the =
<span tabindex=3D"-1" id=3D":4ex.21" style=3D"" class=3D"">vpn</span> authe=
nticates. User profiles are all local, not transferred from a central serve=
r. Although we are religious about not letting the domain controller take o=
ver us,=C2=A0 that&#39;s not how domains are used in real windows world. So=
 some people may really (really?) need the so called &quot;Start Before <sp=
an tabindex=3D"-1" id=3D":4ex.22" style=3D"" class=3D"">Logon</span>&quot;,=
 implementing which may be much more work. <br><br></div><div class=3D"gmai=
l_extra"><span tabindex=3D"-1" id=3D":4ex.23" style=3D"" class=3D"">Selva</=
span><br></div></div>

--047d7bb04a621001d50522db9b96--

