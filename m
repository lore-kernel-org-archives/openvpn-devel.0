MIME-Version: 1.0
References: <20191213191634.250-1-lstipakov@...277...>
 <20191213191901.300-1-lstipakov@...277...>
 <CAKuzo_jNn9NG-chJHx62H2CTiB64dCrq3S3_oW7oR8Tngf4F9w@...278...>
In-Reply-To: <CAKuzo_jNn9NG-chJHx62H2CTiB64dCrq3S3_oW7oR8Tngf4F9w@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 16 Dec 2019 22:00:48 +0200
Message-ID: <CAGyAFMVReSwJsYAKo5S4pV4POV31g0roxz4P2Ajvr+8hoEYbeA@...278...>
Content-Type: multipart/alternative; boundary="00000000000097f0a90599d7abb4"
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--00000000000097f0a90599d7abb4
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for looking into this. See my comments below.

TLDR:
> (i) stealing SYSTEM access from winlogon.exe is not a good thing to do
>

This doesn't happen for the majority of use cases - only when iservice is
not used. We also
elevate only for the single DeviceIOControl call.

Below you mentioned psexec as a one of workarounds, but I think those will
make user experience worse.
Also consider the case when OpenVPN GUI is running as Administrator.

(ii) with a small change we can support multiple tunnels and  provide better
> diagnostics when there are no free wintun adapters -- but this could also
> be a follow up patch.
>

This is already implemented by Simon on top of my patches - see
https://github.com/rozmansi/openvpn/commits/wintun

> -    /* for wintun kernel doesn't send DHCP requests, so use ipapi to set
> IP address and netmask */

> +    /* for wintun kernel doesn't send DHCP requests, so use netsh to set
> IP address and netmask */
> >      if (options->wintun)
> >      {
> > -        options->tuntap_options.ip_win32_type = IPW32_SET_IPAPI;
> > +        options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
>
> This shouldn't be required. I would prefer to not use netsh
> for tasks where API calls are available. We know IPAPI works
> as we use it in the service.
>

I remember having some issues with IPAPI which got resolved when I switched
to netsh.

However, I did some testing and I cannot reproduce IPAPI specific issues
anymore. Too bad I didn't investigate
it further back then. The problem I see now can also be reproduced also
with netsh:

 - connect with tap adapter
 - kill openvpn process
 - connect with wintun adapter

IPAPI / netsh fails to set IP address, since it is already assigned to
another adapter.

If this is OK, I would prefer to submit a separate patch which switches
back to netsh. tun.c code
has changed in follow-up patches (mostly here
https://patchwork.openvpn.net/patch/918/), those patches
are based on an assumption that wintun uses netsh.


> > +                msg(M_FATAL, "ERROR:  Failed to register ring buffers:
> %lu", GetLastError());
>
> The correct error here is, very likely, the adapter is
> already in use. To trigger that, why not do register_ring_buffers
> soon after opening the device and on failure move on to the
> next device (if any).
>
> That will also allow running multiple tunnels with no further changes
> provided the user manually creates wintum adapters.
>

As mentioned before, this is already implemented by Simon:
https://github.com/rozmansi/openvpn/commit/5bc09580e8771d8422feae4504fe2a74b7412fd1


> > +bool

> +impersonate_as_system()
> > +{
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

I'll defer it to Simon.


>
> I would suggest to not elevate to system as the code will still
> work in two important cases
> (i) started by automatic service
> (ii) started using interactive service (e.g., through the GUI)
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

I think it is good not to break user experience and allow run openvpn as
an administrator without iservice using wintun at the expense on elevation
to system for single API call.

In case we keep this function, please log such
> errors. Here and several such cases below.
>

Sure.


-- 
-Lev

--00000000000097f0a90599d7abb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Thanks for looking=
 into this. See my comments=C2=A0below.</div><div><br></div></div><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
TLDR:<br>
(i) stealing SYSTEM access from winlogon.exe is not a good thing to do<br><=
/blockquote><div><br></div><div>This doesn&#39;t happen for the majority of=
 use cases - only when iservice is not used. We also</div><div>elevate only=
 for the single DeviceIOControl call.</div><div><br></div><div>Below you me=
ntioned psexec as a one of workarounds, but I think those will make user ex=
perience worse.</div><div>Also consider the case when OpenVPN GUI is runnin=
g as Administrator.</div><div><br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
(ii) with a small change we can support multiple tunnels and=C2=A0 provide =
better<br>
diagnostics when there are no free wintun adapters -- but this could also<b=
r>
be a follow up patch.<br></blockquote><div><br></div><div>This is already i=
mplemented by Simon on top of my patches - see=C2=A0<a href=3D"https://gith=
ub.com/rozmansi/openvpn/commits/wintun" target=3D"_blank">https://github.co=
m/rozmansi/openvpn/commits/wintun</a></div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">&gt; -=C2=A0 =C2=A0 /* for wintun kernel d=
oesn&#39;t send DHCP requests, so use ipapi to set IP address and netmask *=
/</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 /* for wintun kernel doesn&#39;t send DHCP requests, so=
 use netsh to set IP address and netmask */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (options-&gt;wintun)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;tuntap_options.ip_win32_type =
=3D IPW32_SET_IPAPI;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;tuntap_options.ip_win32_type =
=3D IPW32_SET_NETSH;<br>
<br>
This shouldn&#39;t be required. I would prefer to not use netsh<br>
for tasks where API calls are available. We know IPAPI works<br>
as we use it in the service.<br></blockquote><div><br></div><div>I remember=
 having some issues with IPAPI which got resolved when I switched to netsh.=
</div><div><br></div><div>However, I did some testing and I cannot reproduc=
e IPAPI specific issues anymore. Too bad I didn&#39;t investigate</div><div=
>it further back then.=C2=A0The problem I see now can also be reproduced al=
so with netsh:</div><div><br></div><div>=C2=A0- connect with tap adapter</d=
iv><div>=C2=A0- kill openvpn process</div><div>=C2=A0- connect with wintun =
adapter</div><div><br></div><div>IPAPI / netsh fails to set IP address, sin=
ce it is already assigned to another adapter.</div><div><br></div><div>If t=
his is OK, I would prefer to submit a separate patch which switches back to=
 netsh. tun.c code</div><div>has changed in follow-up patches (mostly here=
=C2=A0<a href=3D"https://patchwork.openvpn.net/patch/918/" target=3D"_blank=
">https://patchwork.openvpn.net/patch/918/</a>), those patches</div><div>ar=
e based on an assumption that wintun uses netsh.=C2=A0</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, =
&quot;ERROR:=C2=A0 Failed to register ring buffers: %lu&quot;, GetLastError=
());<br>
<br>
The correct error here is, very likely, the adapter is<br>
already in use. To trigger that, why not do register_ring_buffers<br>
soon after opening the device and on failure move on to the<br>
next device (if any).<br>
<br>
That will also allow running multiple tunnels with no further changes<br>
provided the user manually creates wintum adapters.<br></blockquote><div><b=
r></div><div>As mentioned before, this is already implemented by Simon:=C2=
=A0=C2=A0<a href=3D"https://github.com/rozmansi/openvpn/commit/5bc09580e877=
1d8422feae4504fe2a74b7412fd1" target=3D"_blank">https://github.com/rozmansi=
/openvpn/commit/5bc09580e8771d8422feae4504fe2a74b7412fd1</a></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; +bool</bloc=
kquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +impersonate_as_system()<br>
&gt; +{<br>
<br>
This is implemented by stealing the access token from<br>
winlogon.exe. I don&#39;t think such tricks belong to OpenVPN.<br>
It may also trip some anti-virus software.<br>
<br>
That said, probably there are no &quot;legitimate&quot; ways of getting<br>
LOCAL SYSTEM rights on Windows without running a service.<br>
<br>
Why does wintun require SYSTEM for using it? If there is a<br>
good reason for that, we should not let every admin<br>
user bypass it.<br></blockquote><div><br></div><div>I&#39;ll defer it to Si=
mon.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
I would suggest to not elevate to system as the code will still<br>
work in two important cases<br>
(i) started by automatic service<br>
(ii) started using interactive service (e.g., through the GUI)<br>
<br>
Those who really need to test OpenVPN with wintun from<br>
command prompt can use diagnostic tools available to get<br>
a cmd prompt as system (e.g., psexec). That also=C2=A0 makes<br>
it explicit that SYSTEM privilege is required.<br>
<br>
In the longer run, we could provide a script to launch<br>
openvpn.exe using the interactive service. Modifying the<br>
automatic service to use interactive service for launching<br>
looks easy to do as well. Then, all privileged operations could<br>
be removed from openvpn core.<br></blockquote><div><br></div><div>I think i=
t is good not to break user experience and allow run openvpn as</div><div>a=
n administrator without iservice using wintun at the expense on elevation</=
div><div>to system for single API call.</div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
In case we keep this function, please log such<br>
errors. Here and several such cases below.<br></blockquote><div><br></div><=
div>Sure.</div><div>=C2=A0</div></div><div><br></div>-- <br><div dir=3D"ltr=
">-Lev</div></div>

--00000000000097f0a90599d7abb4--

