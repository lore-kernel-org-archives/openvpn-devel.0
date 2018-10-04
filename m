MIME-Version: 1.0
References: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
 <CAFHpkQG10QOhGUb4R4VyPHwCNMfkVSQgCVgmypsBidsgNcsBaw@...278...>
 <CADkMwqQ+F-rLr3V5_BxjixbvnyOW6T+Y6tP---3PBaOcHkRBpA@...278...>
 <CAFHpkQExnJLdr1kNMkXoYxXjOdX4+M3KTcOfBp1ZQwmV3CkkXA@...278...>
 <CADkMwqS7AUDVz_tj0_6ewhJ7YgfJmph71dK-hCVhgOY=5+z3oA@...278...>
 <CAFHpkQHhy_w=0vSag_cqwQ=BiPStuVBzK0GOheMpjvpFFY_wAQ@...278...>
 <CADkMwqQCC_5=tWyX5HPQpPBVqwm8eoisYY=GtjLYcwx7KpN2Hg@...278...>
 <CAFHpkQHpaLNwfWvm3C6YsWE1wTRndXMJPa4QkBqcvMGTwk7=dw@...278...>
 <CADkMwqRaW_7VrDg+k0ok6ZNqaZo=FheJFz+ZW958E5HD4xX_cQ@...278...>
 <CAFHpkQGOV+g7-Fe+ANHCPAE4_Ew8fgWo3DOoeYhExyVzdr5Dfg@...278...>
 <CADkMwqTZ9F8wbYrJjmoQQ56yf+e2DwRc3MQ7y6R0E3gSL4Zf2g@...278...>
In-Reply-To: <CADkMwqTZ9F8wbYrJjmoQQ56yf+e2DwRc3MQ7y6R0E3gSL4Zf2g@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 4 Oct 2018 12:15:34 -0400
Message-ID: <CAKuzo_iVf7zOFV7b-5d0gR=6Ea9RR3o0420jhNtmSAuAq1MegA@...278...>
Content-Type: multipart/alternative; boundary="00000000000026bf9e057769786c"
Subject: Re: [Openvpn-devel] Slow outbound network speed for Windows Server
 2016 only via the OpenVPN tunnel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: rostyslav.maryliak@...2454...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000026bf9e057769786c
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, Oct 4, 2018 at 10:42 AM Rostyslav Maryliak <
rostyslav.maryliak@...2454...> wrote:

> Dear Ilya,
>
> As far as I understood you are talking about Windows Server Feature. If
> yes than it is NOT installed.
>
> "are you using intel drivers instead of windows drivers ?"
> I've installed them when I was trying to figure it out by myself. That is
> why I've installed all latest OS updates, network card drivers, reinstalled
> latest OpenVPN version etc.
> But it doesn't work anyway nor with intel drivers or without them.
>
> "is version the same accross servers ? firmware ? "
> No, one servers have Intel network card, another Broadcom card, another
> one HP card. They are not equal at all.
>
>
If the bandwidth in clear is "great" but through the tunnel is 30-40 kbps,
I suppose there is a problem related to openvpn tunnel or how it interacts
with the netwrok stack on server 2016. You do not say how much the  "great"
speed in clear is, but I guess there is an order of magnitude degradation.

FWIW, I fired up a 2016 server on google compute and measured bandwidth
using iperf3 and a Linux openvpn server  -- I don't have a Windows server
handy to test against. In clear I got about 50 mbps,  through tunnel about
25mbps --- in both directions.  Although the CPU is not loaded (hovers
around 10-15%) that's the kind of speed I usually get with stock options so
looks like client on server-2016 VM to Linux server works fine.

However, the above is using iperf -s on Linux side for upload measurements
and iperf -s on Windows side for downloads. Using the -R switch of iperf
misbehaves through the tunnel in one direction: with iperf3 -s on Linux
side and iperf3 -R -c on Windows side, Linux reports 0 bits/s for about 10
seconds and then the transfer starts and picks up to ~25 mbps. The windows
side shows nothing for 10 seconds and then picks up. Also the final stats
report 100's of retries. This happens only through the tunnel, not in
clear. But in this case the data is flowing from Linux to Windows so not
the direction that you have problem with. Using -R switch in the opposite
direction works normally.

Selva
Selva

--00000000000026bf9e057769786c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
>On Thu, Oct 4, 2018 at 10:42 AM Rostyslav Maryliak &lt;<a href=3D"mailto:r=
ostyslav.maryliak@...2454...">rostyslav.maryliak@...2454...</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div style=3D"font=
-family:arial,helvetica,sans-serif">Dear Ilya,</div><div style=3D"font-fami=
ly:arial,helvetica,sans-serif"><br></div><div style=3D"font-family:arial,he=
lvetica,sans-serif">As far as I understood you are talking about Windows Se=
rver Feature. If yes than it is NOT installed.</div><div style=3D"font-fami=
ly:arial,helvetica,sans-serif"><br></div><div style=3D"font-family:arial,he=
lvetica,sans-serif">&quot;<span style=3D"font-family:Arial,Helvetica,sans-s=
erif">are you using intel drivers instead of windows drivers ?</span>&quot;=
</div><div style=3D"font-family:arial,helvetica,sans-serif">I&#39;ve instal=
led them when I was trying to figure it out by myself. That is why I&#39;ve=
 installed all latest OS updates, network card drivers, reinstalled latest =
OpenVPN version etc.</div><div style=3D"font-family:arial,helvetica,sans-se=
rif">But it doesn&#39;t work anyway nor with intel drivers or without them.=
</div><div style=3D"font-family:arial,helvetica,sans-serif"><br></div><div =
style=3D"font-family:arial,helvetica,sans-serif"><span style=3D"font-family=
:Arial,Helvetica,sans-serif">&quot;is version the same accross servers ? fi=
rmware ?</span>=C2=A0&quot;<br></div><div style=3D"font-family:arial,helvet=
ica,sans-serif">No, one servers have Intel network card, another Broadcom c=
ard, another one HP card. They are not equal at all.</div></div><br></block=
quote><div><br></div><div>If the bandwidth in clear is &quot;great&quot; bu=
t through the tunnel is 30-40 kbps, I suppose there is a problem related to=
 openvpn tunnel or how it interacts with the netwrok stack on server 2016. =
You do not say how much the=C2=A0 &quot;great&quot; speed in clear is, but =
I guess there is an order of magnitude degradation.<br><br></div><div>FWIW,=
 I fired up a 2016 server on google compute and measured bandwidth using ip=
erf3 and a Linux openvpn server=C2=A0 -- I don&#39;t have a Windows server =
handy to test against. In clear I got about 50 mbps,=C2=A0 through tunnel a=
bout 25mbps --- in both directions.=C2=A0 Although the CPU is not loaded (h=
overs around 10-15%) that&#39;s the kind of speed I usually get with stock =
options so looks like client on server-2016 VM to Linux server works fine. =
<br><br>However, the above is using iperf -s on Linux side for upload measu=
rements and iperf -s on Windows side for downloads. Using the -R switch of =
iperf misbehaves through the tunnel in one direction: with iperf3 -s on Lin=
ux side and iperf3 -R -c on Windows side, Linux reports 0 bits/s for about =
10 seconds and then the transfer starts and picks up to ~25 mbps. The windo=
ws side shows nothing for 10 seconds and then picks up. Also the final stat=
s report 100&#39;s of retries. This happens only through the tunnel, not in=
 clear. But in this case the data is flowing from Linux to Windows so not t=
he direction that you have problem with. Using -R switch in the opposite di=
rection works normally.<br><br></div><div>Selva<br></div><div>Selva<br></di=
v></div></div></div>

--00000000000026bf9e057769786c--

