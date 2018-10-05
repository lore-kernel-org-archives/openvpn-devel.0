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
 <CAKuzo_iVf7zOFV7b-5d0gR=6Ea9RR3o0420jhNtmSAuAq1MegA@...278...>
 <CADkMwqT8_Y8C4MSw7Jxjm+D+A9irBPVtouC9o+XE+EuzP0J6Fg@...278...>
In-Reply-To: <CADkMwqT8_Y8C4MSw7Jxjm+D+A9irBPVtouC9o+XE+EuzP0J6Fg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 5 Oct 2018 10:25:01 -0400
Message-ID: <CAKuzo_j3z2qSsxw1G_EYFtZCqch+nNd-9=gu9MKRXX+eP2LhYQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000009c27c605777c0a37"
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

--0000000000009c27c605777c0a37
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Oct 5, 2018 at 4:02 AM Rostyslav Maryliak <
rostyslav.maryliak@...2454...> wrote:

> Dear Selva,
>
> I've got a similar results. Except the outbound network speed for win2016
> server.
> The bandwidth in clear is about 700 Mbits/sec in both directions and
> different measures (with -R option and without it):
>
> [ ID] Interval           Transfer     Bandwidth
> [  4]   0.00-10.00  sec   880 MBytes   *739 Mbits/sec   *
> sender
> [  4]   0.00-10.00  sec   880 MBytes   *738 Mbits/sec*
> receiver
>
>
> Here are the same measures through the VPN tunnel:
>
> *1. win2012r2 (iperf -s) + win2016 (iperf -c)*
> [ ID] Interval           Transfer     Bandwidth
> [  4]   0.00-10.00  sec   103 MBytes * 86.2 Mbits/sec*
> sender
> [  4]   0.00-10.00  sec   103 MBytes  *86.1 Mbits/sec *
> receiver
>
> *2. win2012r2 (iperf -s) + win2016 (iperf -c -R)*
> The same as you in this mode I can see 0 bits/s for about 3-7 seconds and
> then the transfer starts and picks the normal transfer rate.
> [ ID] Interval           Transfer     Bandwidth
> [  4]   0.00-10.00  sec   130 MBytes   *109 Mbits/sec *
> sender
> [  4]   0.00-10.00  sec   130 MBytes   *109 Mbits/sec *
> receiver
>
> *3. win2012r2 (iperf -c) + win2016 (iperf -s)*
> [ ID] Interval           Transfer     Bandwidth
> [  4]   0.00-10.00  sec   140 MBytes   *117 Mbits/sec*
> sender
> [  4]   0.00-10.00  sec   140 MBytes   *117 Mbits/sec*
> receiver
>
> *4. win2012r2 (iperf -c -R) + win2016 (iperf -s)*
> [ ID] Interval           Transfer     Bandwidth
> [  4]   0.00-10.00  sec   640 KBytes   *524 Kbits/sec*
> sender
> [  4]   0.00-10.00  sec   512 KBytes   *419 Kbits/sec  *
> receiver
>

#1 and #3 shows the speed is good in both directions, so looks like the
problem surfaces only when -R is used. Not saying this is an iperf issue as
you see low bandwidth in general use as well. I don't know what causes this
(the TAP driver?) but hopefully others may chime in with some clue.

Could you please re-do the -R tests with a longer test time (say iperf3 -t
30 ...). Also test udp speeds (ie. iperf3 -u ...) keeping the tunnel udp.

Thanks,

Selva

--0000000000009c27c605777c0a37
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
">On Fri, Oct 5, 2018 at 4:02 AM Rostyslav Maryliak &lt;<a href=3D"mailto:r=
ostyslav.maryliak@...2454...">rostyslav.maryliak@...2454...</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><=
div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div sty=
le=3D"font-family:arial,helvetica,sans-serif">Dear Selva,</div><div style=
=3D"font-family:arial,helvetica,sans-serif"><br></div><div style=3D"font-fa=
mily:arial,helvetica,sans-serif">I&#39;ve got a similar results. Except the=
 outbound network speed for win2016 server.</div><div style=3D"font-family:=
arial,helvetica,sans-serif">The bandwidth in clear is about 700 Mbits/sec i=
n both directions and different measures (with -R option and without it):</=
div><div style=3D"font-family:arial,helvetica,sans-serif"><br></div><div st=
yle=3D"font-family:arial,helvetica,sans-serif"><div>[ ID] Interval=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwidth</di=
v><div>[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0880 MBytes=
=C2=A0 =C2=A0<b>739 Mbits/sec=C2=A0 =C2=A0</b> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 sender</div><div>[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=
=A0 sec=C2=A0 =C2=A0880 MBytes=C2=A0 =C2=A0<b>738 Mbits/sec</b>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 receiver</div><div><br=
></div><div><br></div><div>Here are the same measures through the VPN tunne=
l:</div><div><br></div><div><b>1. win2012r2 (iperf -s)=C2=A0+ win2016 (iper=
f -c)</b></div><div><div>[ ID] Interval=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwidth</div><div>[=C2=A0 4]=C2=A0 =C2=
=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0103 MBytes=C2=A0<b> 86.2 Mbits/sec</b>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sender</div>=
<div>[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0103 MBytes=C2=
=A0 <b>86.1 Mbits/sec=C2=A0</b> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 receiver</div></div><div><b><br></b></div><div><b>2. win2012r=
2 (iperf -s)=C2=A0+ win2016 (iperf -c -R)</b>=C2=A0</div><div><div>The same=
 as you in this mode I can see=C2=A0<span style=3D"font-family:Arial,Helvet=
ica,sans-serif">0 bits/s for about 3-7 seconds and then the transfer starts=
 and picks</span><span style=3D"font-family:Arial,Helvetica,sans-serif">=C2=
=A0the normal transfer rate.</span></div><div>[ ID] Interval=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwidth<br></div><=
div>[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0130 MBytes=C2=
=A0 =C2=A0<b>109 Mbits/sec=C2=A0</b> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 sender</div><div>[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 =
sec=C2=A0 =C2=A0130 MBytes=C2=A0 =C2=A0<b>109 Mbits/sec=C2=A0</b> =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 receiver</div></div><div><=
br></div><div><b>3. win2012r2 (iperf -c)=C2=A0+ win2016 (iperf -s)</b><br><=
/div><div><div>[ ID] Interval=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Trans=
fer=C2=A0 =C2=A0 =C2=A0Bandwidth</div><div>[=C2=A0 4]=C2=A0 =C2=A00.00-10.0=
0=C2=A0 sec=C2=A0 =C2=A0140 MBytes=C2=A0 =C2=A0<b>117 Mbits/sec</b>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sender</div><div>[=
=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0140 MBytes=C2=A0 =C2=
=A0<b>117 Mbits/sec</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 receiver</div></div><div><br></div><div><b>4. win2012r2 (iperf -=
c -R)=C2=A0+ win2016 (iperf -s)</b>=C2=A0<b><br></b></div><div><div>[ ID] I=
nterval=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=
=A0Bandwidth</div><div>[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =
=C2=A0640 KBytes=C2=A0 =C2=A0<b>524 Kbits/sec</b>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sender</div><div>[=C2=A0 4]=C2=A0 =
=C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0512 KBytes=C2=A0 =C2=A0<b>419 Kbits/=
sec=C2=A0 </b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 recei=
ver</div></div></div></div></div></div></div></div></div></blockquote><div>=
<br></div><div>#1 and #3 shows the speed is good in both directions, so loo=
ks like the problem surfaces only when -R is used. Not saying this is an ip=
erf issue as you see low bandwidth in general use as well. I don&#39;t know=
 what causes this (the TAP driver?) but hopefully others may chime in with =
some clue.<br><br>Could you please re-do the -R tests with a longer test ti=
me (say iperf3 -t 30 ...). Also test udp speeds (ie. iperf3 -u ...) keeping=
 the tunnel udp.<br><br></div><div>Thanks,<br><br></div><div>Selva</div></d=
iv></div></div>

--0000000000009c27c605777c0a37--

