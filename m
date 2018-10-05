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
In-Reply-To: <CAKuzo_iVf7zOFV7b-5d0gR=6Ea9RR3o0420jhNtmSAuAq1MegA@...278...>
From: Rostyslav Maryliak <rostyslav.maryliak@...2454...>
Date: Fri, 5 Oct 2018 11:01:55 +0300
Message-ID: <CADkMwqT8_Y8C4MSw7Jxjm+D+A9irBPVtouC9o+XE+EuzP0J6Fg@...278...>
Content-Type: multipart/alternative; boundary="000000000000854ba7057776b1ea"
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--000000000000854ba7057776b1ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Selva,

I've got a similar results. Except the outbound network speed for win2016
server.
The bandwidth in clear is about 700 Mbits/sec in both directions and
different measures (with -R option and without it):

[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-10.00  sec   880 MBytes   *739 Mbits/sec   *
sender
[  4]   0.00-10.00  sec   880 MBytes   *738 Mbits/sec*
receiver


Here are the same measures through the VPN tunnel:

*1. win2012r2 (iperf -s) + win2016 (iperf -c)*
[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-10.00  sec   103 MBytes * 86.2 Mbits/sec*
sender
[  4]   0.00-10.00  sec   103 MBytes  *86.1 Mbits/sec *
receiver

*2. win2012r2 (iperf -s) + win2016 (iperf -c -R)*
The same as you in this mode I can see 0 bits/s for about 3-7 seconds and
then the transfer starts and picks the normal transfer rate.
[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-10.00  sec   130 MBytes   *109 Mbits/sec *
sender
[  4]   0.00-10.00  sec   130 MBytes   *109 Mbits/sec *
receiver

*3. win2012r2 (iperf -c) + win2016 (iperf -s)*
[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-10.00  sec   140 MBytes   *117 Mbits/sec*
sender
[  4]   0.00-10.00  sec   140 MBytes   *117 Mbits/sec*
receiver

*4. win2012r2 (iperf -c -R) + win2016 (iperf -s)*
[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-10.00  sec   640 KBytes   *524 Kbits/sec*
sender
[  4]   0.00-10.00  sec   512 KBytes   *419 Kbits/sec  *
receiver

As you can see the network speed slows down for outbound direction so
dramatically that I can't even compare them.
Do you have the possibility to launch the similar setup with both Windows
servers and perform the same tests?

What else can I check and analyze on my side to resolve the issue?

On Thu, Oct 4, 2018 at 7:15 PM Selva Nair <selva.nair@...277...> wrote:

> Hi
>
> On Thu, Oct 4, 2018 at 10:42 AM Rostyslav Maryliak <
> rostyslav.maryliak@...2454...> wrote:
>
>> Dear Ilya,
>>
>> As far as I understood you are talking about Windows Server Feature. If
>> yes than it is NOT installed.
>>
>> "are you using intel drivers instead of windows drivers ?"
>> I've installed them when I was trying to figure it out by myself. That is
>> why I've installed all latest OS updates, network card drivers, reinstal=
led
>> latest OpenVPN version etc.
>> But it doesn't work anyway nor with intel drivers or without them.
>>
>> "is version the same accross servers ? firmware ? "
>> No, one servers have Intel network card, another Broadcom card, another
>> one HP card. They are not equal at all.
>>
>>
> If the bandwidth in clear is "great" but through the tunnel is 30-40 kbps,
> I suppose there is a problem related to openvpn tunnel or how it interacts
> with the netwrok stack on server 2016. You do not say how much the  "grea=
t"
> speed in clear is, but I guess there is an order of magnitude degradation.
>
> FWIW, I fired up a 2016 server on google compute and measured bandwidth
> using iperf3 and a Linux openvpn server  -- I don't have a Windows server
> handy to test against. In clear I got about 50 mbps,  through tunnel about
> 25mbps --- in both directions.  Although the CPU is not loaded (hovers
> around 10-15%) that's the kind of speed I usually get with stock options =
so
> looks like client on server-2016 VM to Linux server works fine.
>
> However, the above is using iperf -s on Linux side for upload measurements
> and iperf -s on Windows side for downloads. Using the -R switch of iperf
> misbehaves through the tunnel in one direction: with iperf3 -s on Linux
> side and iperf3 -R -c on Windows side, Linux reports 0 bits/s for about 10
> seconds and then the transfer starts and picks up to ~25 mbps. The windows
> side shows nothing for 10 seconds and then picks up. Also the final stats
> report 100's of retries. This happens only through the tunnel, not in
> clear. But in this case the data is flowing from Linux to Windows so not
> the direction that you have problem with. Using -R switch in the opposite
> direction works normally.
>
> Selva
> Selva
>


--=20

Best regards,

*Rostyslav Maryliak*

System Administrator



*iDeals=E2=84=A2 Solutions Group*| + 38(073)437-72-51 <%2B%2038%28093%29575=
-35-16> |
Skype: rostyslav.maryliak.ideals| *rostyslav.maryliak@...2454...
<dmitry.zaporozhchenko@...2454...>* | www.idealsvdr.com
<http://www.idealscorp.com/>

--=20
CONFIDENTIALITY NOTE:
The information transmitted, including attachments,

is intended only for the person(s) or entity to which it is addressed and

may contain confidential and/or privileged material. Any review,

retransmission, dissemination or other use of, or taking of any action in

reliance upon this information by persons or entities other than the

intended recipient is prohibited. If you received this in error, please

contact the sender and destroy any copies of this information.

--000000000000854ba7057776b1ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-famil=
y:arial,helvetica,sans-serif">Dear Selva,</div><div class=3D"gmail_default"=
 style=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=3D"g=
mail_default" style=3D"font-family:arial,helvetica,sans-serif">I&#39;ve got=
 a similar results. Except the outbound network speed for win2016 server.</=
div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-=
serif">The bandwidth in clear is about 700 Mbits/sec in both directions and=
 different measures (with -R option and without it):</div><div class=3D"gma=
il_default" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div=
 class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><=
div class=3D"gmail_default">[ ID] Interval=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwidth</div><div class=3D"gmail_de=
fault">[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0880 MBytes=
=C2=A0 =C2=A0<b>739 Mbits/sec=C2=A0 =C2=A0</b> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 sender</div><div class=3D"gmail_default">[=C2=A0 4]=C2=
=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0880 MBytes=C2=A0 =C2=A0<b>738 Mb=
its/sec</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eceiver</div><div class=3D"gmail_default"><br></div><div class=3D"gmail_def=
ault"><br></div><div class=3D"gmail_default">Here are the same measures thr=
ough the VPN tunnel:</div><div class=3D"gmail_default"><br></div><div class=
=3D"gmail_default"><b>1. win2012r2 (iperf -s)=C2=A0+ win2016 (iperf -c)</b>=
</div><div class=3D"gmail_default"><div class=3D"gmail_default">[ ID] Inter=
val=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Ban=
dwidth</div><div class=3D"gmail_default">[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=
=C2=A0 sec=C2=A0 =C2=A0103 MBytes=C2=A0<b> 86.2 Mbits/sec</b>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sender</div><div class=3D"=
gmail_default">[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0103 =
MBytes=C2=A0 <b>86.1 Mbits/sec=C2=A0</b> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 receiver</div></div><div class=3D"gmail_default"><b><=
br></b></div><div class=3D"gmail_default"><b>2. win2012r2 (iperf -s)=C2=A0+=
 win2016 (iperf -c -R)</b>=C2=A0</div><div class=3D"gmail_default"><div cla=
ss=3D"gmail_default">The same as you in this mode I can see=C2=A0<span styl=
e=3D"font-family:Arial,Helvetica,sans-serif">0 bits/s for about 3-7 seconds=
 and then the transfer starts and picks</span><span style=3D"font-family:Ar=
ial,Helvetica,sans-serif">=C2=A0the normal transfer rate.</span></div><div =
class=3D"gmail_default">[ ID] Interval=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwidth<br></div><div class=3D"gmail_de=
fault">[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0130 MBytes=
=C2=A0 =C2=A0<b>109 Mbits/sec=C2=A0</b> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 sender</div><div class=3D"gmail_default">[=C2=A0 4]=C2=
=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0130 MBytes=C2=A0 =C2=A0<b>109 Mb=
its/sec=C2=A0</b> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eceiver</div></div><div class=3D"gmail_default"><br></div><div class=3D"gma=
il_default"><b>3. win2012r2 (iperf -c)=C2=A0+ win2016 (iperf -s)</b><br></d=
iv><div class=3D"gmail_default"><div class=3D"gmail_default">[ ID] Interval=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwi=
dth</div><div class=3D"gmail_default">[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=
=A0 sec=C2=A0 =C2=A0140 MBytes=C2=A0 =C2=A0<b>117 Mbits/sec</b>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sender</div><div class=
=3D"gmail_default">[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0=
140 MBytes=C2=A0 =C2=A0<b>117 Mbits/sec</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 receiver</div></div><div class=3D"gmail_def=
ault"><br></div><div class=3D"gmail_default"><b>4. win2012r2 (iperf -c -R)=
=C2=A0+ win2016 (iperf -s)</b>=C2=A0<b><br></b></div><div class=3D"gmail_de=
fault"><div class=3D"gmail_default">[ ID] Interval=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwidth</div><div class=3D"g=
mail_default">[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0640 K=
Bytes=C2=A0 =C2=A0<b>524 Kbits/sec</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sender</div><div class=3D"gmail_default">[=C2=
=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0512 KBytes=C2=A0 =C2=A0=
<b>419 Kbits/sec=C2=A0 </b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 receiver</div><div class=3D"gmail_default"><br></div><div class=3D"=
gmail_default">As you can see the network speed slows down for outbound dir=
ection so dramatically that I can&#39;t even compare them.</div><div class=
=3D"gmail_default">Do you have the possibility to launch the similar setup =
with both Windows servers and perform the same tests?</div><div class=3D"gm=
ail_default"><br></div><div class=3D"gmail_default">What else can I check a=
nd analyze on my side to resolve the issue?</div></div></div></div></div></=
div></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Th=
u, Oct 4, 2018 at 7:15 PM Selva Nair &lt;<a href=3D"mailto:selva.nair@...1664...=
7...">selva.nair@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div dir=3D"ltr">Hi<br><div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Thu, Oct 4, 2018 at 10:42 AM Rostyslav Maryliak &lt;<a href=3D"=
mailto:rostyslav.maryliak@...2454..." target=3D"_blank">rostyslav.maryliak@=
...2454...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=
=3D"ltr"><div style=3D"font-family:arial,helvetica,sans-serif">Dear Ilya,</=
div><div style=3D"font-family:arial,helvetica,sans-serif"><br></div><div st=
yle=3D"font-family:arial,helvetica,sans-serif">As far as I understood you a=
re talking about Windows Server Feature. If yes than it is NOT installed.</=
div><div style=3D"font-family:arial,helvetica,sans-serif"><br></div><div st=
yle=3D"font-family:arial,helvetica,sans-serif">&quot;<span style=3D"font-fa=
mily:Arial,Helvetica,sans-serif">are you using intel drivers instead of win=
dows drivers ?</span>&quot;</div><div style=3D"font-family:arial,helvetica,=
sans-serif">I&#39;ve installed them when I was trying to figure it out by m=
yself. That is why I&#39;ve installed all latest OS updates, network card d=
rivers, reinstalled latest OpenVPN version etc.</div><div style=3D"font-fam=
ily:arial,helvetica,sans-serif">But it doesn&#39;t work anyway nor with int=
el drivers or without them.</div><div style=3D"font-family:arial,helvetica,=
sans-serif"><br></div><div style=3D"font-family:arial,helvetica,sans-serif"=
><span style=3D"font-family:Arial,Helvetica,sans-serif">&quot;is version th=
e same accross servers ? firmware ?</span>=C2=A0&quot;<br></div><div style=
=3D"font-family:arial,helvetica,sans-serif">No, one servers have Intel netw=
ork card, another Broadcom card, another one HP card. They are not equal at=
 all.</div></div><br></blockquote><div><br></div><div>If the bandwidth in c=
lear is &quot;great&quot; but through the tunnel is 30-40 kbps, I suppose t=
here is a problem related to openvpn tunnel or how it interacts with the ne=
twrok stack on server 2016. You do not say how much the=C2=A0 &quot;great&q=
uot; speed in clear is, but I guess there is an order of magnitude degradat=
ion.<br><br></div><div>FWIW, I fired up a 2016 server on google compute and=
 measured bandwidth using iperf3 and a Linux openvpn server=C2=A0 -- I don&=
#39;t have a Windows server handy to test against. In clear I got about 50 =
mbps,=C2=A0 through tunnel about 25mbps --- in both directions.=C2=A0 Altho=
ugh the CPU is not loaded (hovers around 10-15%) that&#39;s the kind of spe=
ed I usually get with stock options so looks like client on server-2016 VM =
to Linux server works fine. <br><br>However, the above is using iperf -s on=
 Linux side for upload measurements and iperf -s on Windows side for downlo=
ads. Using the -R switch of iperf misbehaves through the tunnel in one dire=
ction: with iperf3 -s on Linux side and iperf3 -R -c on Windows side, Linux=
 reports 0 bits/s for about 10 seconds and then the transfer starts and pic=
ks up to ~25 mbps. The windows side shows nothing for 10 seconds and then p=
icks up. Also the final stats report 100&#39;s of retries. This happens onl=
y through the tunnel, not in clear. But in this case the data is flowing fr=
om Linux to Windows so not the direction that you have problem with. Using =
-R switch in the opposite direction works normally.<br><br></div><div>Selva=
<br></div><div>Selva<br></div></div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><p st=
yle=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-seri=
f"><span style=3D"font-size:12pt;color:rgb(89,89,89)">Best regards,</span><=
/p><p style=3D"margin:0in 0in 0.0001pt;font-family:Calibri,sans-serif"><fon=
t color=3D"#595959"><span style=3D"font-size:16px"><b>Rostyslav Maryliak</b=
></span></font></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-=
family:Calibri,sans-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89=
)">System Administrator</span></p><p style=3D"margin:0in 0in 0.0001pt;font-=
size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:12pt;col=
or:rgb(89,89,89)">=C2=A0</span></p><p style=3D"margin:0in 0in 0.0001pt;font=
-size:11pt;font-family:Calibri,sans-serif"><b><span style=3D"font-size:12pt=
;color:rgb(35,176,24)">iDeals=E2=84=A2 Solutions Group</span></b><span styl=
e=3D"font-size:12pt;color:rgb(89,89,89)">|=C2=A0<a href=3D"tel:%2B%2038%280=
93%29575-35-16" value=3D"+380935753516" style=3D"color:rgb(17,85,204)" targ=
et=3D"_blank">+ 38(073)437-72-51</a>=C2=A0| Skype: rostyslav.maryliak.ideal=
s|</span><span style=3D"color:rgb(31,73,125)">=C2=A0</span><u><span style=
=3D"font-size:12pt;color:rgb(35,176,24)"><a href=3D"mailto:dmitry.zaporozhc=
henko@...2454..." style=3D"color:rgb(17,85,204)" target=3D"_blank"><span st=
yle=3D"color:rgb(5,99,193)">rostyslav.maryliak@...2454...</span></a></span>=
</u><u><span style=3D"color:rgb(35,176,24)">=C2=A0</span></u><span style=3D=
"font-size:12pt;color:rgb(89,89,89)">|</span><span style=3D"font-size:12pt;=
color:rgb(35,176,24)">=C2=A0</span><span lang=3D"RU" style=3D"font-size:12p=
t;color:rgb(35,176,24)"><a href=3D"http://www.idealscorp.com/" style=3D"col=
or:rgb(17,85,204)" target=3D"_blank"><span lang=3D"EN-US" style=3D"color:rg=
b(35,176,24)">www.idealsvdr.com</span></a></span></p></div></div></div></di=
v></div></div></div></div>

<br>
<span style=3D"font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;fo=
nt-size:12pt"><font face=3D"Trebuchet" size=3D"2">CONFIDENTIALITY NOTE:
The information transmitted, including attachments,
is intended only for the person(s) or entity to which it is addressed and
may contain confidential and/or privileged material. Any review,
retransmission, dissemination or other use of, or taking of any action in
reliance upon this information by persons or entities other than the
intended recipient is prohibited. If you received this in error, please
contact the sender and destroy any copies of this information.</font></span=
>=

--000000000000854ba7057776b1ea--

