MIME-Version: 1.0
References: <20191213191634.250-1-lstipakov@...277...>
 <20191213191901.300-1-lstipakov@...277...>
 <CAKuzo_jNn9NG-chJHx62H2CTiB64dCrq3S3_oW7oR8Tngf4F9w@...278...>
 <CAGyAFMVReSwJsYAKo5S4pV4POV31g0roxz4P2Ajvr+8hoEYbeA@...278...>
 <CAKuzo_hMws66xJsN69qa6WmgXNdrSKioHQrpE9VZ89-J2O7+KA@...278...>
 <162696E1-8F58-4B9A-A591-2622E3ADE746@...2293...>
 <CAKuzo_jFzECCsOk=OvrN0+S0dx4WmGOm7qL8L2sGYUTRd+qxXw@...278...>
In-Reply-To: <CAKuzo_jFzECCsOk=OvrN0+S0dx4WmGOm7qL8L2sGYUTRd+qxXw@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 17 Dec 2019 11:34:42 +0200
Message-ID: <CAGyAFMUgY+dj0TD75dsKL1pQqPP4CRcEObijyCHB7wUbehpEtw@...278...>
Content-Type: multipart/alternative; boundary="0000000000007553ed0599e30a6c"
Subject: Re: [Openvpn-devel] [PATCH v6 4/7] wintun: ring buffers based I/O
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Simon Rozman <simon@...2293...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000007553ed0599e30a6c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How about compromise - let's add  "--enable-system-elevation" windows
specific option.

 - When it is set, we print warning and elevate to SYSTEM for the single
DeviceIOControl call

 - When it is not set and wintun is used, we run openvpn from command line
via iservice

 - If service is missing, we print error "either use iservice or
--enable-system-elevation (experts only)"

The ones who want to run openvpn from command line with wintun still could
do it via psexec and it is
assumed that they know what they are doing. So why not make it simpler and
add a option
"yes I know what I am doing and I am willing to take risks"? Also, it is
safer to use system privilege
just for single call rather than run whole process with it.

This also will make debugging / development easier.


ti 17. jouluk. 2019 klo 0.38 Selva Nair (selva.nair@...277...) kirjoitti:

> Hi,
>
> On Mon, Dec 16, 2019 at 5:18 PM Simon Rozman <simon@...2293...> wrote:
> >
> > Hi,
> >
> > TLDR:
> > (i) stealing SYSTEM access from winlogon.exe is not a good thing to do
> >
> >
> >
> > This doesn't happen for the majority of use cases - only when iservice
> is not used. We also
> > elevate only for the single DeviceIOControl call.
> >
> >
> > I understand. But stealing access token from winlogon.exe is a hack and
> not
> > something I would expect to see in a trustworthy executable. Diagnostic
> > and forensic tools may be justified in doing such things.
> >
> >
> > Wintun has a hardcoded check to allow ring registration from the SYSTEM
> user only.
> >
> > To be honest: I am using a Windows 10 VPC in test mode with a modified
> Wintun driver installed that also allows ring registration for the members
> of Administrators group. This allows me to quickly test ideas while
> reviewing/upgrading Lev's work. I can run Visual Studio to compile
> openvpn.exe on my computer as an unprivileged user. Then have an elevated
> Remote Debugger running on the VPC and Visual Studio to remotely run
> openvpn.exe with debugger attached with a single F5 click.
> >
> > Having to use OpenVPN GUI and iservice, or running openvpn.exe as
> service would require a lot more clicks to replace the binary, attach
> debugger etc.
> >
> > As far as I am concerned, this elevation hack may be removed from the
> OpenVPN source code in the final release. However, mind that this would
> prevent people from running openvpn.exe+Wintun from the command line.
> >
> > +bool
> >
> > +impersonate_as_system()
> > +{
> >
> >
> > This is implemented by stealing the access token from
> > winlogon.exe. I don't think such tricks belong to OpenVPN.
> > It may also trip some anti-virus software.
> >
> > That said, probably there are no "legitimate" ways of getting
> > LOCAL SYSTEM rights on Windows without running a service.
> >
> > Why does wintun require SYSTEM for using it? If there is a
> > good reason for that, we should not let every admin
> > user bypass it.
> >
> >
> >
> > I'll defer it to Simon.
> >
> >
> > Unfortunately, I don't do security decisions in Wintun.
> >
> > Wintun was originally designed for WireGuard. WireGuard is architectured
> to run all its tunnels as Windows services running as the SYSTEM user.
> Wintun's security is as tight as possible so the WireGuard can barely use
> it. I know a guy who is tempted to introduce a userspace binary code
> signature check to the Wintun. :)
> >
> > Given the relative ease to get SYSTEM token just by being an elevated
> process =E2=80=94 mind there's also a hack to get from non-elevated to el=
evated
> completely bypassing the UAC prompt as long as you are a member of
> Administrators =E2=80=94 this SYSTEM restriction really doesn't provide
> considerable additional security compared to being a member of
> Administrators group.
>
> That's the point. It probably provides no extra security because we
> are forced to take the blame for using hacks to cross security
> boundaries. And, bypassing UAC is quite different from acquiring
> rights you were not supposed to have. Does openvpn wants to be doing
> that?
>
> >
> > Those who really need to test OpenVPN with wintun from
> > command prompt can use diagnostic tools available to get
> > a cmd prompt as system (e.g., psexec). That also  makes
> > it explicit that SYSTEM privilege is required.
> >
> > In the longer run, we could provide a script to launch
> > openvpn.exe using the interactive service. Modifying the
> > automatic service to use interactive service for launching
> > looks easy to do as well. Then, all privileged operations could
> > be removed from openvpn core.
> >
> >
> >
> > I think it is good not to break user experience and allow run openvpn as
> > an administrator without iservice using wintun at the expense on
> elevation
> > to system for single API call.
> >
> >
> > I have already said what I think of it. As an admin I wouldn't like to
> see
> > users running processes that elevate to SYSTEM like this.
> >
> >
> > Selva, Windows is full of such hacks internally. :( This is no excuse
> for us doing the same of course. Just saying Windows is far from ideal
> world.
>
> In this particular case this has nothing to do with Windows -- its
> just a stupid decision by wintun that requires the use of undocumented
> hacks to elevate to SYSTEM.
>
> >
> > I am running OpenVPN on Windows using NSSM wrapper for years. I had a
> brief discussion on the Hackathon with Samuli about integrating SCM suppo=
rt
> directly into openvpn.exe (imagine --daemon for Windows):
> >
> > sc create OpenVPN$MyTunnel binpath=3D "C:\Program
> Files\OpenVPN\bin\openvpn" --daemon --config "C:\Program
> Files\OpenVPN\config\MyTunnel.ovpn" --log "C:\Program
> Files\OpenVPN\log\MyTunnel.log" start=3D auto depend=3D dhcp
> > sc start OpenVPN$MyTunnel
> >
> > This would install openvpn.exe as a Windows service and run it as the
> SYSTEM user =E2=80=94 no need for iservice, no need for SYSTEM token hack=
. Other
> than me, perhaps it could cover at least some of the users now running
> openvpn.exe directly.
>
> This is not the direction I want to see us moving towards. Instead I
> want to see us daemonizing OpenVPN.exe as LOCAL SERVICE or a custom
> service user and delegate privileged operations to a separate service
> running as SYSTEM. And we already have the latter: interactive
> service. So, not even admin rights is needed in openvpn.exe, let alone
> SYSTEM.
>
> IMO, the right approach on Windows is to run a bare minimal code as a
> service to get SYSTEM rights and the rest with limited privileges.
>
> Selva
>


--=20
-Lev

--0000000000007553ed0599e30a6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">How about compromise - let&#39;s add=C2=A0 &quot;--enable-=
system-elevation&quot; windows specific option.<div><br></div><div>=C2=A0- =
When it is set, we print warning and elevate to SYSTEM for the single Devic=
eIOControl call</div><div><br></div><div>=C2=A0- When it is not set and win=
tun is used, we run openvpn from command line via iservice</div><div><br></=
div><div>=C2=A0- If service is missing, we print error &quot;either use ise=
rvice or --enable-system-elevation (experts only)&quot;</div><div><br></div=
><div>The ones who want to run openvpn from command line with wintun still =
could do it via psexec and it is</div><div>assumed that they know what they=
 are doing. So why not make it simpler and add a option</div><div>&quot;yes=
 I know what I am doing and I am willing to take risks&quot;? Also, it is s=
afer to use system privilege</div><div>just for single call rather than run=
 whole process with it.</div><div><br></div><div>This also will make debugg=
ing / development easier.<br><div><br></div></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">ti 17. jouluk. 2019 klo 0=
.38 Selva Nair (<a href=3D"mailto:selva.nair@...277...">selva.nair@...1663...=
.</a>) kirjoitti:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Hi,<br>
<br>
On Mon, Dec 16, 2019 at 5:18 PM Simon Rozman &lt;<a href=3D"mailto:simon@...1186...=
.2293..." target=3D"_blank">simon@...2293...</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; TLDR:<br>
&gt; (i) stealing SYSTEM access from winlogon.exe is not a good thing to do=
<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; This doesn&#39;t happen for the majority of use cases - only when iser=
vice is not used. We also<br>
&gt; elevate only for the single DeviceIOControl call.<br>
&gt;<br>
&gt;<br>
&gt; I understand. But stealing access token from winlogon.exe is a hack an=
d not<br>
&gt; something I would expect to see in a trustworthy executable. Diagnosti=
c<br>
&gt; and forensic tools may be justified in doing such things.<br>
&gt;<br>
&gt;<br>
&gt; Wintun has a hardcoded check to allow ring registration from the SYSTE=
M user only.<br>
&gt;<br>
&gt; To be honest: I am using a Windows 10 VPC in test mode with a modified=
 Wintun driver installed that also allows ring registration for the members=
 of Administrators group. This allows me to quickly test ideas while review=
ing/upgrading Lev&#39;s work. I can run Visual Studio to compile openvpn.ex=
e on my computer as an unprivileged user. Then have an elevated Remote Debu=
gger running on the VPC and Visual Studio to remotely run openvpn.exe with =
debugger attached with a single F5 click.<br>
&gt;<br>
&gt; Having to use OpenVPN GUI and iservice, or running openvpn.exe as serv=
ice would require a lot more clicks to replace the binary, attach debugger =
etc.<br>
&gt;<br>
&gt; As far as I am concerned, this elevation hack may be removed from the =
OpenVPN source code in the final release. However, mind that this would pre=
vent people from running openvpn.exe+Wintun from the command line.<br>
&gt;<br>
&gt; +bool<br>
&gt;<br>
&gt; +impersonate_as_system()<br>
&gt; +{<br>
&gt;<br>
&gt;<br>
&gt; This is implemented by stealing the access token from<br>
&gt; winlogon.exe. I don&#39;t think such tricks belong to OpenVPN.<br>
&gt; It may also trip some anti-virus software.<br>
&gt;<br>
&gt; That said, probably there are no &quot;legitimate&quot; ways of gettin=
g<br>
&gt; LOCAL SYSTEM rights on Windows without running a service.<br>
&gt;<br>
&gt; Why does wintun require SYSTEM for using it? If there is a<br>
&gt; good reason for that, we should not let every admin<br>
&gt; user bypass it.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I&#39;ll defer it to Simon.<br>
&gt;<br>
&gt;<br>
&gt; Unfortunately, I don&#39;t do security decisions in Wintun.<br>
&gt;<br>
&gt; Wintun was originally designed for WireGuard. WireGuard is architectur=
ed to run all its tunnels as Windows services running as the SYSTEM user. W=
intun&#39;s security is as tight as possible so the WireGuard can barely us=
e it. I know a guy who is tempted to introduce a userspace binary code sign=
ature check to the Wintun. :)<br>
&gt;<br>
&gt; Given the relative ease to get SYSTEM token just by being an elevated =
process =E2=80=94 mind there&#39;s also a hack to get from non-elevated to =
elevated completely bypassing the UAC prompt as long as you are a member of=
 Administrators =E2=80=94 this SYSTEM restriction really doesn&#39;t provid=
e considerable additional security compared to being a member of Administra=
tors group.<br>
<br>
That&#39;s the point. It probably provides no extra security because we<br>
are forced to take the blame for using hacks to cross security<br>
boundaries. And, bypassing UAC is quite different from acquiring<br>
rights you were not supposed to have. Does openvpn wants to be doing<br>
that?<br>
<br>
&gt;<br>
&gt; Those who really need to test OpenVPN with wintun from<br>
&gt; command prompt can use diagnostic tools available to get<br>
&gt; a cmd prompt as system (e.g., psexec). That also=C2=A0 makes<br>
&gt; it explicit that SYSTEM privilege is required.<br>
&gt;<br>
&gt; In the longer run, we could provide a script to launch<br>
&gt; openvpn.exe using the interactive service. Modifying the<br>
&gt; automatic service to use interactive service for launching<br>
&gt; looks easy to do as well. Then, all privileged operations could<br>
&gt; be removed from openvpn core.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I think it is good not to break user experience and allow run openvpn =
as<br>
&gt; an administrator without iservice using wintun at the expense on eleva=
tion<br>
&gt; to system for single API call.<br>
&gt;<br>
&gt;<br>
&gt; I have already said what I think of it. As an admin I wouldn&#39;t lik=
e to see<br>
&gt; users running processes that elevate to SYSTEM like this.<br>
&gt;<br>
&gt;<br>
&gt; Selva, Windows is full of such hacks internally. :( This is no excuse =
for us doing the same of course. Just saying Windows is far from ideal worl=
d.<br>
<br>
In this particular case this has nothing to do with Windows -- its<br>
just a stupid decision by wintun that requires the use of undocumented<br>
hacks to elevate to SYSTEM.<br>
<br>
&gt;<br>
&gt; I am running OpenVPN on Windows using NSSM wrapper for years. I had a =
brief discussion on the Hackathon with Samuli about integrating SCM support=
 directly into openvpn.exe (imagine --daemon for Windows):<br>
&gt;<br>
&gt; sc create OpenVPN$MyTunnel binpath=3D &quot;C:\Program Files\OpenVPN\b=
in\openvpn&quot; --daemon --config &quot;C:\Program Files\OpenVPN\config\My=
Tunnel.ovpn&quot; --log &quot;C:\Program Files\OpenVPN\log\MyTunnel.log&quo=
t; start=3D auto depend=3D dhcp<br>
&gt; sc start OpenVPN$MyTunnel<br>
&gt;<br>
&gt; This would install openvpn.exe as a Windows service and run it as the =
SYSTEM user =E2=80=94 no need for iservice, no need for SYSTEM token hack. =
Other than me, perhaps it could cover at least some of the users now runnin=
g openvpn.exe directly.<br>
<br>
This is not the direction I want to see us moving towards. Instead I<br>
want to see us daemonizing OpenVPN.exe as LOCAL SERVICE or a custom<br>
service user and delegate privileged operations to a separate service<br>
running as SYSTEM. And we already have the latter: interactive<br>
service. So, not even admin rights is needed in openvpn.exe, let alone<br>
SYSTEM.<br>
<br>
IMO, the right approach on Windows is to run a bare minimal code as a<br>
service to get SYSTEM rights and the rest with limited privileges.<br>
<br>
Selva<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--0000000000007553ed0599e30a6c--

