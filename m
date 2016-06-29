References: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
	<20160629081109.GU78279@...1296...>
	<CAFHpkQGD10-N=fX6osaMKE4SN+S55A8EN+8byw6aTM9Aosd1Mw@...278...>
	<20160629090025.GV78279@...1296...>
	<51c19384-4814-c63e-f515-ea0f3ce8791e@...515...>
	<CAFHpkQFMs3OsBoV8LP1BZnZpomMFwp6pvw_bx58UrLK20dyF0Q@...278...>
	<224018c8-c3a7-6a7e-0d46-2f44d87b2990@...515...>
	<CAFHpkQEsEj70wZxdXs9fd8W8j3QfuyWBjJAHXvzUGVTPt50_CQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <1920c5bf-c449-3a79-5331-c8df691705d8@...515...>
Date: Wed, 29 Jun 2016 13:17:10 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEsEj70wZxdXs9fd8W8j3QfuyWBjJAHXvzUGVTPt50_CQ@...278...>
Subject: Re: [Openvpn-devel] git master: no more WinXP ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

We can definitely add a checkbox for the interactive service. However, I=20
would make it opt-out to reduce the impact on support. Only a handful of=20
people know that in order to run OpenVPN-GUI without admin privileges=20
requires OpenVPNServiceInteractive to be running, and trying to educate=20
users is probably a lost cause :).

Samuli

> it is almost the same choice like whether to include "run as admin"
> manifest or leave it to user.
> from security point of view, it makes sense that running anything with
> admin privileges might be security issue and user should agree on that.
>
> but I vote for starting interactive service from installer with no
> question asked ))
>
> 2016-06-29 15:07 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
> <mailto:samuli@...515...>>:
>
>     "Enable and start interactive service during installation" is on my
>     todo. I think we can safely enable it, because it will not
>     automatically go out starting any VPNs.
>
>     Samuli
>
>         I had a look at installers (as we enroll our own installer).
>         I've got more questions regarding installers
>
>         for example, interactive service is installed, but not started.
>         So, user
>         without admin rights cannot just start it.
>         it would be better to either start it from installer or add check=
box
>         there "start service"
>
>         2016-06-29 14:11 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
>         <mailto:samuli@...515...>
>         <mailto:samuli@...515... <mailto:samuli@...515...>>>:
>
>
>                 Hi,
>
>                 On Wed, Jun 29, 2016 at 01:57:14PM +0500, ????????
>                 ?????????????? wrote:
>
>                     ok, if so, we need to modify installer to detect that.
>
>
>                 Right, "master" installers should refuse cooperation on X=
P.
>
>                 Samuli, you're listening? ;-)
>
>                 gert
>
>
>             Yes. Do we still want to bloat "master" installers with
>         tap-windows?
>
>             Afaics that would only be useful _if_ somebody is having
>         problems
>             with tap-windows6 and needs to revert to tap-windows.
>         However, in
>             that case we'd need checkbox, not automatic tap-driver select=
ion
>             based on the OS.
>
>             Samuli
>
>
>
>
>


--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

