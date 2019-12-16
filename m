MIME-Version: 1.0
References: <20191213191634.250-1-lstipakov@...277...>
 <20191213191901.300-1-lstipakov@...277...>
 <CAKuzo_jNn9NG-chJHx62H2CTiB64dCrq3S3_oW7oR8Tngf4F9w@...278...>
 <CAGyAFMVReSwJsYAKo5S4pV4POV31g0roxz4P2Ajvr+8hoEYbeA@...278...>
 <CAKuzo_hMws66xJsN69qa6WmgXNdrSKioHQrpE9VZ89-J2O7+KA@...278...>
 <162696E1-8F58-4B9A-A591-2622E3ADE746@...2293...>
In-Reply-To: <162696E1-8F58-4B9A-A591-2622E3ADE746@...2293...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 16 Dec 2019 17:38:25 -0500
Message-ID: <CAKuzo_jFzECCsOk=OvrN0+S0dx4WmGOm7qL8L2sGYUTRd+qxXw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v6 4/7] wintun: ring buffers based I/O
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Simon Rozman <simon@...2293...>
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Dec 16, 2019 at 5:18 PM Simon Rozman <simon@...2293...> wrote:
>
> Hi,
>
> TLDR:
> (i) stealing SYSTEM access from winlogon.exe is not a good thing to do
>
>
>
> This doesn't happen for the majority of use cases - only when iservice is=
 not used. We also
> elevate only for the single DeviceIOControl call.
>
>
> I understand. But stealing access token from winlogon.exe is a hack and n=
ot
> something I would expect to see in a trustworthy executable. Diagnostic
> and forensic tools may be justified in doing such things.
>
>
> Wintun has a hardcoded check to allow ring registration from the SYSTEM u=
ser only.
>
> To be honest: I am using a Windows 10 VPC in test mode with a modified Wi=
ntun driver installed that also allows ring registration for the members of=
 Administrators group. This allows me to quickly test ideas while reviewing=
/upgrading Lev's work. I can run Visual Studio to compile openvpn.exe on my=
 computer as an unprivileged user. Then have an elevated Remote Debugger ru=
nning on the VPC and Visual Studio to remotely run openvpn.exe with debugge=
r attached with a single F5 click.
>
> Having to use OpenVPN GUI and iservice, or running openvpn.exe as service=
 would require a lot more clicks to replace the binary, attach debugger etc.
>
> As far as I am concerned, this elevation hack may be removed from the Ope=
nVPN source code in the final release. However, mind that this would preven=
t people from running openvpn.exe+Wintun from the command line.
>
> +bool
>
> +impersonate_as_system()
> +{
>
>
> This is implemented by stealing the access token from
> winlogon.exe. I don't think such tricks belong to OpenVPN.
> It may also trip some anti-virus software.
>
> That said, probably there are no "legitimate" ways of getting
> LOCAL SYSTEM rights on Windows without running a service.
>
> Why does wintun require SYSTEM for using it? If there is a
> good reason for that, we should not let every admin
> user bypass it.
>
>
>
> I'll defer it to Simon.
>
>
> Unfortunately, I don't do security decisions in Wintun.
>
> Wintun was originally designed for WireGuard. WireGuard is architectured =
to run all its tunnels as Windows services running as the SYSTEM user. Wint=
un's security is as tight as possible so the WireGuard can barely use it. I=
 know a guy who is tempted to introduce a userspace binary code signature c=
heck to the Wintun. :)
>
> Given the relative ease to get SYSTEM token just by being an elevated pro=
cess =E2=80=94 mind there's also a hack to get from non-elevated to elevate=
d completely bypassing the UAC prompt as long as you are a member of Admini=
strators =E2=80=94 this SYSTEM restriction really doesn't provide considera=
ble additional security compared to being a member of Administrators group.

That's the point. It probably provides no extra security because we
are forced to take the blame for using hacks to cross security
boundaries. And, bypassing UAC is quite different from acquiring
rights you were not supposed to have. Does openvpn wants to be doing
that?

>
> Those who really need to test OpenVPN with wintun from
> command prompt can use diagnostic tools available to get
> a cmd prompt as system (e.g., psexec). That also  makes
> it explicit that SYSTEM privilege is required.
>
> In the longer run, we could provide a script to launch
> openvpn.exe using the interactive service. Modifying the
> automatic service to use interactive service for launching
> looks easy to do as well. Then, all privileged operations could
> be removed from openvpn core.
>
>
>
> I think it is good not to break user experience and allow run openvpn as
> an administrator without iservice using wintun at the expense on elevation
> to system for single API call.
>
>
> I have already said what I think of it. As an admin I wouldn't like to see
> users running processes that elevate to SYSTEM like this.
>
>
> Selva, Windows is full of such hacks internally. :( This is no excuse for=
 us doing the same of course. Just saying Windows is far from ideal world.

In this particular case this has nothing to do with Windows -- its
just a stupid decision by wintun that requires the use of undocumented
hacks to elevate to SYSTEM.

>
> I am running OpenVPN on Windows using NSSM wrapper for years. I had a bri=
ef discussion on the Hackathon with Samuli about integrating SCM support di=
rectly into openvpn.exe (imagine --daemon for Windows):
>
> sc create OpenVPN$MyTunnel binpath=3D "C:\Program Files\OpenVPN\bin\openv=
pn" --daemon --config "C:\Program Files\OpenVPN\config\MyTunnel.ovpn" --log=
 "C:\Program Files\OpenVPN\log\MyTunnel.log" start=3D auto depend=3D dhcp
> sc start OpenVPN$MyTunnel
>
> This would install openvpn.exe as a Windows service and run it as the SYS=
TEM user =E2=80=94 no need for iservice, no need for SYSTEM token hack. Oth=
er than me, perhaps it could cover at least some of the users now running o=
penvpn.exe directly.

This is not the direction I want to see us moving towards. Instead I
want to see us daemonizing OpenVPN.exe as LOCAL SERVICE or a custom
service user and delegate privileged operations to a separate service
running as SYSTEM. And we already have the latter: interactive
service. So, not even admin rights is needed in openvpn.exe, let alone
SYSTEM.

IMO, the right approach on Windows is to run a bare minimal code as a
service to get SYSTEM rights and the rest with limited privileges.

Selva

