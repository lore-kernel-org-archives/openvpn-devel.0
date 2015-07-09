MIME-Version: 1.0
In-Reply-To: <559E5EC9.8010106@...1147...>
References: <55966BE0.5090400@...1147...> <55966F4A.7010008@...1114...>
	<559672D0.1030904@...1147...> <20150703115639.GC57772@...2041...>
	<20150703131545.GZ382@...1296...> <5596980F.6010600@...1147...>
	<559D4F39.5000603@...1147...> <20150708185945.GV382@...1296...>
	<559E5EC9.8010106@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 9 Jul 2015 10:24:43 -0400
Message-ID: <CAKuzo_ha8p90W7yXgxwfO-DS=LfefHR3S16O2pMfYRBkrNj8Tw@...278...>
Content-Type: multipart/alternative; boundary=089e0122aaee6fd5fd051a720563
Subject: Re: [Openvpn-devel] Adding routes on Windows using DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e0122aaee6fd5fd051a720563
Content-Type: text/plain; charset=UTF-8

On Thu, Jul 9, 2015 at 7:45 AM, Jan Just Keijser <janjust@...1147...> wrote:

> as usual, Gert is right :(
> I've added an explicit /32 route to the OpenVPN server via DHCP , which
> Windows picks up, including the right LAN GW address *BUT* it associates
> it with the VPN interface, not the regular LAN interface. Thus you end
> up with a "bite your own tail" route and the VPN collapses.
>
> So I guess the only thing this DHCP-trick is useful for is if you're not
> redirecting all traffic - in that case you can run openvpn in
> non-privileged mode and set a bunch of routes to go over the VPN, just
> not the default route.
>
> @Selva: my current patch contains hardcoded addresses and is just a
> proof-of-concept. I cannot share the executable with you.
>

No problem, the fact that the route would apply only to the particular
interface is a major disappointment. Kind of obvious once Gert pointed it
out, though :)

I suppose, going forward, replacing the service by nssm is the best option
for those of us using the mgmt-interface to control the process as
non-admin user.

Thanks,

Selva

--089e0122aaee6fd5fd051a720563
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Jul 9, 2015 at 7:45 AM, Jan Just Keijser <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...1147...</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div style=3D"overflow:=
hidden">as usual, Gert is right :(<br>
I&#39;ve added an explicit /32 route to the OpenVPN server via DHCP , which=
<br>
Windows picks up, including the right LAN GW address *BUT* it associates<br>
it with the VPN interface, not the regular LAN interface. Thus you end<br>
up with a &quot;bite your own tail&quot; route and the VPN collapses.<br>
<br>
So I guess the only thing this DHCP-trick is useful for is if you&#39;re no=
t<br>
redirecting all traffic - in that case you can run openvpn in<br>
non-privileged mode and set a bunch of routes to go over the VPN, just<br>
not the default route.<br>
<br>
@Selva: my current patch contains hardcoded addresses and is just a<br>
proof-of-concept. I cannot share the executable with you.<div><div></div></=
div></div></blockquote></div><br>No problem, the fact that the route would =
apply only to the particular interface is a major disappointment. Kind of o=
bvious once Gert pointed it out, though :)=C2=A0 <br><br>I suppose, going f=
orward, replacing the service by nssm is the best option for those of us us=
ing the mgmt-interface to control the process as non-admin user.<br></div><=
div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Thanks,<br><=
br></div><div class=3D"gmail_extra">Selva<br></div></div>

--089e0122aaee6fd5fd051a720563--

