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
 <CAKuzo_j3z2qSsxw1G_EYFtZCqch+nNd-9=gu9MKRXX+eP2LhYQ@...278...>
In-Reply-To: <CAKuzo_j3z2qSsxw1G_EYFtZCqch+nNd-9=gu9MKRXX+eP2LhYQ@...278...>
From: Rostyslav Maryliak <rostyslav.maryliak@...2454...>
Date: Fri, 5 Oct 2018 17:46:46 +0300
Message-ID: <CADkMwqRUBQQp=Ybb2xQ9-FLW3AsyBM9Mj1G2LYUpbJOg_RXzKQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000063db3105777c59e7"
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

--00000000000063db3105777c59e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Selva,

Longer test time shows the same results:
*win2012r2 (iperf -c -R -t 30) + win2016 (iperf -s)*
[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-30.00  sec  1.75 MBytes   *489 Kbits/sec *
sender
[  4]   0.00-30.00  sec  1.58 MBytes   *442 Kbits/sec *
receiver

I am not sure if my UDP testing results are correct, but they are equal in
both directions and depend on -R option:
*1. iperf -c -u:*
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total
Datag
rams
[  5]   0.00-1.00   sec  0.00 Bytes  *0.00 bits/sec*  0.000 ms  0/0 (0%)
[  5]   1.00-2.00   sec  0.00 Bytes * 0.00 bits/sec*  0.000 ms  0/0 (0%)
[  5]   2.00-3.00   sec  0.00 Bytes  *0.00 bits/sec*  0.000 ms  0/0 (0%)
[  5]   3.00-4.00   sec  0.00 Bytes  *0.00 bits/sec*  0.000 ms  0/0 (0%)
[  5]   4.00-5.00   sec  0.00 Bytes  *0.00 bits/sec * 0.000 ms  0/0 (0%)
[  5]   5.00-6.00   sec  0.00 Bytes  *0.00 bits/sec*  0.000 ms  0/0 (0%)
[  5]   6.00-7.00   sec  0.00 Bytes  *0.00 bits/sec*  0.000 ms  0/0 (0%)
[  5]   7.00-8.00   sec  0.00 Bytes  *0.00 bits/sec*  0.000 ms  0/0 (0%)
[  5]   8.00-9.00   sec  0.00 Bytes  *0.00 bits/sec*  0.000 ms  0/0 (0%)
[  5]   8.00-9.00   sec  0.00 Bytes  *0.00 bits/sec * 0.000 ms  0/0 (0%)
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total
Datag
rams
[  5]   0.00-9.00   sec  0.00 Bytes  *0.00 bits/sec*  0.000 ms  0/0 (0%)
iperf3: the client has terminated

*2. iperf -c -u -R:*
[ ID] Interval           Transfer     Bandwidth       Total Datagrams
[  5]   0.00-1.00   sec   120 KBytes   *982 Kbits/sec*  15
[  5]   1.00-2.00   sec   128 KBytes  *1.05 Mbits/sec*  16
[  5]   2.00-3.00   sec   128 KBytes  *1.05 Mbits/sec*  16
[  5]   3.00-4.00   sec   128 KBytes  *1.05 Mbits/sec*  16
[  5]   4.00-5.00   sec   128 KBytes  *1.05 Mbits/sec*  16
[  5]   5.00-6.00   sec   128 KBytes  *1.05 Mbits/sec*  16
[  5]   6.00-7.00   sec   128 KBytes  *1.05 Mbits/sec  *16
[  5]   7.00-8.00   sec   128 KBytes  *1.05 Mbits/sec*  16
[  5]   8.00-9.00   sec   128 KBytes  *1.05 Mbits/sec * 16
[  5]   9.00-10.00  sec   128 KBytes  *1.05 Mbits/sec*  16
[  5]  10.00-11.00  sec   128 KBytes  *1.05 Mbits/sec*  16
[  5]  11.00-12.00  sec   128 KBytes  *1.05 Mbits/sec*  16
[  5]  12.00-13.00  sec   128 KBytes  *1.05 Mbits/sec*  16
[  5]  13.00-14.00  sec   128 KBytes  *1.05 Mbits/sec*  16
[  5]  14.00-14.89  sec   112 KBytes  *1.03 Mbits/sec*  14
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total
Datag
rams
[  5]   0.00-14.89  sec  1.85 MBytes  *1.04 Mbits/sec*  0.000 ms  0/237 (0%)
iperf3: interrupt - the server has terminated



On Fri, Oct 5, 2018 at 5:25 PM Selva Nair <selva.nair@...277...> wrote:

> Hi,
>
> On Fri, Oct 5, 2018 at 4:02 AM Rostyslav Maryliak <
> rostyslav.maryliak@...2454...> wrote:
>
>> Dear Selva,
>>
>> I've got a similar results. Except the outbound network speed for win2016
>> server.
>> The bandwidth in clear is about 700 Mbits/sec in both directions and
>> different measures (with -R option and without it):
>>
>> [ ID] Interval           Transfer     Bandwidth
>> [  4]   0.00-10.00  sec   880 MBytes   *739 Mbits/sec   *
>> sender
>> [  4]   0.00-10.00  sec   880 MBytes   *738 Mbits/sec*
>> receiver
>>
>>
>> Here are the same measures through the VPN tunnel:
>>
>> *1. win2012r2 (iperf -s) + win2016 (iperf -c)*
>> [ ID] Interval           Transfer     Bandwidth
>> [  4]   0.00-10.00  sec   103 MBytes * 86.2 Mbits/sec*
>> sender
>> [  4]   0.00-10.00  sec   103 MBytes  *86.1 Mbits/sec *
>> receiver
>>
>> *2. win2012r2 (iperf -s) + win2016 (iperf -c -R)*
>> The same as you in this mode I can see 0 bits/s for about 3-7 seconds
>> and then the transfer starts and picks the normal transfer rate.
>> [ ID] Interval           Transfer     Bandwidth
>> [  4]   0.00-10.00  sec   130 MBytes   *109 Mbits/sec *
>> sender
>> [  4]   0.00-10.00  sec   130 MBytes   *109 Mbits/sec *
>> receiver
>>
>> *3. win2012r2 (iperf -c) + win2016 (iperf -s)*
>> [ ID] Interval           Transfer     Bandwidth
>> [  4]   0.00-10.00  sec   140 MBytes   *117 Mbits/sec*
>> sender
>> [  4]   0.00-10.00  sec   140 MBytes   *117 Mbits/sec*
>> receiver
>>
>> *4. win2012r2 (iperf -c -R) + win2016 (iperf -s)*
>> [ ID] Interval           Transfer     Bandwidth
>> [  4]   0.00-10.00  sec   640 KBytes   *524 Kbits/sec*
>> sender
>> [  4]   0.00-10.00  sec   512 KBytes   *419 Kbits/sec  *
>> receiver
>>
>
> #1 and #3 shows the speed is good in both directions, so looks like the
> problem surfaces only when -R is used. Not saying this is an iperf issue =
as
> you see low bandwidth in general use as well. I don't know what causes th=
is
> (the TAP driver?) but hopefully others may chime in with some clue.
>
> Could you please re-do the -R tests with a longer test time (say iperf3 -t
> 30 ...). Also test udp speeds (ie. iperf3 -u ...) keeping the tunnel udp.
>
> Thanks,
>
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

--00000000000063db3105777c59e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div cl=
ass=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Dear=
 Selva,</div><div class=3D"gmail_default" style=3D"font-family:arial,helvet=
ica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family=
:arial,helvetica,sans-serif">Longer test time shows the same results:</div>=
<div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-seri=
f"><b>win2012r2 (iperf -c -R -t 30)=C2=A0+ win2016 (iperf -s)</b>=C2=A0=C2=
=A0=C2=A0<br></div><div class=3D"gmail_default" style=3D"font-family:arial,=
helvetica,sans-serif"><div class=3D"gmail_default">[ ID] Interval=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwidth</div><=
div class=3D"gmail_default">[=C2=A0 4]=C2=A0 =C2=A00.00-30.00=C2=A0 sec=C2=
=A0 1.75 MBytes=C2=A0 =C2=A0<b>489 Kbits/sec=C2=A0</b> =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sender</div><div class=3D"gmail_default=
">[=C2=A0 4]=C2=A0 =C2=A00.00-30.00=C2=A0 sec=C2=A0 1.58 MBytes=C2=A0 =C2=
=A0<b>442 Kbits/sec=C2=A0</b> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 receiver</div><div class=3D"gmail_default"><br></div><div class=
=3D"gmail_default">I am not sure if my UDP testing results are correct, but=
 they are equal in both directions and depend on -R option:</div><div class=
=3D"gmail_default"><b>1. iperf -c -u:</b></div><div class=3D"gmail_default"=
><div class=3D"gmail_default">[ ID] Interval=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwidth=C2=A0 =C2=A0 =C2=A0 =C2=A0J=
itter=C2=A0 =C2=A0 Lost/Total Datag</div><div class=3D"gmail_default">rams<=
/div><div class=3D"gmail_default">[=C2=A0 5]=C2=A0 =C2=A00.00-1.00=C2=A0 =
=C2=A0sec=C2=A0 0.00 Bytes=C2=A0 <b>0.00 bits/sec</b>=C2=A0 0.000 ms=C2=A0 =
0/0 (0%)</div><div class=3D"gmail_default">[=C2=A0 5]=C2=A0 =C2=A01.00-2.00=
=C2=A0 =C2=A0sec=C2=A0 0.00 Bytes=C2=A0<b> 0.00 bits/sec</b>=C2=A0 0.000 ms=
=C2=A0 0/0 (0%)</div><div class=3D"gmail_default">[=C2=A0 5]=C2=A0 =C2=A02.=
00-3.00=C2=A0 =C2=A0sec=C2=A0 0.00 Bytes=C2=A0 <b>0.00 bits/sec</b>=C2=A0 0=
.000 ms=C2=A0 0/0 (0%)</div><div class=3D"gmail_default">[=C2=A0 5]=C2=A0 =
=C2=A03.00-4.00=C2=A0 =C2=A0sec=C2=A0 0.00 Bytes=C2=A0 <b>0.00 bits/sec</b>=
=C2=A0 0.000 ms=C2=A0 0/0 (0%)</div><div class=3D"gmail_default">[=C2=A0 5]=
=C2=A0 =C2=A04.00-5.00=C2=A0 =C2=A0sec=C2=A0 0.00 Bytes=C2=A0 <b>0.00 bits/=
sec=C2=A0</b> 0.000 ms=C2=A0 0/0 (0%)</div><div class=3D"gmail_default">[=
=C2=A0 5]=C2=A0 =C2=A05.00-6.00=C2=A0 =C2=A0sec=C2=A0 0.00 Bytes=C2=A0 <b>0=
.00 bits/sec</b>=C2=A0 0.000 ms=C2=A0 0/0 (0%)</div><div class=3D"gmail_def=
ault">[=C2=A0 5]=C2=A0 =C2=A06.00-7.00=C2=A0 =C2=A0sec=C2=A0 0.00 Bytes=C2=
=A0 <b>0.00 bits/sec</b>=C2=A0 0.000 ms=C2=A0 0/0 (0%)</div><div class=3D"g=
mail_default">[=C2=A0 5]=C2=A0 =C2=A07.00-8.00=C2=A0 =C2=A0sec=C2=A0 0.00 B=
ytes=C2=A0 <b>0.00 bits/sec</b>=C2=A0 0.000 ms=C2=A0 0/0 (0%)</div><div cla=
ss=3D"gmail_default">[=C2=A0 5]=C2=A0 =C2=A08.00-9.00=C2=A0 =C2=A0sec=C2=A0=
 0.00 Bytes=C2=A0 <b>0.00 bits/sec</b>=C2=A0 0.000 ms=C2=A0 0/0 (0%)</div><=
div class=3D"gmail_default">[=C2=A0 5]=C2=A0 =C2=A08.00-9.00=C2=A0 =C2=A0se=
c=C2=A0 0.00 Bytes=C2=A0 <b>0.00 bits/sec=C2=A0</b> 0.000 ms=C2=A0 0/0 (0%)=
</div><div class=3D"gmail_default">- - - - - - - - - - - - - - - - - - - - =
- - - - -</div><div class=3D"gmail_default">[ ID] Interval=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwidth=C2=A0 =C2=A0 =
=C2=A0 =C2=A0Jitter=C2=A0 =C2=A0 Lost/Total Datag<div class=3D"gmail_defaul=
t" style=3D"display:inline">rams</div></div><div class=3D"gmail_default">[=
=C2=A0 5]=C2=A0 =C2=A00.00-9.00=C2=A0 =C2=A0sec=C2=A0 0.00 Bytes=C2=A0 <b>0=
.00 bits/sec</b>=C2=A0 0.000 ms=C2=A0 0/0 (0%)</div><div class=3D"gmail_def=
ault">iperf3: the client has terminated</div><div class=3D"gmail_default" s=
tyle=3D"font-weight:bold"><br></div></div><div class=3D"gmail_default"><b>2=
. iperf -c -u -R:</b>=C2=A0=C2=A0<b><br></b></div><div class=3D"gmail_defau=
lt"><div class=3D"gmail_default">[ ID] Interval=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwidth=C2=A0 =C2=A0 =C2=A0 =C2=
=A0Total Datagrams</div><div class=3D"gmail_default">[=C2=A0 5]=C2=A0 =C2=
=A00.00-1.00=C2=A0 =C2=A0sec=C2=A0 =C2=A0120 KBytes=C2=A0 =C2=A0<b>982 Kbit=
s/sec</b>=C2=A0 15</div><div class=3D"gmail_default">[=C2=A0 5]=C2=A0 =C2=
=A01.00-2.00=C2=A0 =C2=A0sec=C2=A0 =C2=A0128 KBytes=C2=A0 <b>1.05 Mbits/sec=
</b>=C2=A0 16</div><div class=3D"gmail_default">[=C2=A0 5]=C2=A0 =C2=A02.00=
-3.00=C2=A0 =C2=A0sec=C2=A0 =C2=A0128 KBytes=C2=A0 <b>1.05 Mbits/sec</b>=C2=
=A0 16</div><div class=3D"gmail_default">[=C2=A0 5]=C2=A0 =C2=A03.00-4.00=
=C2=A0 =C2=A0sec=C2=A0 =C2=A0128 KBytes=C2=A0 <b>1.05 Mbits/sec</b>=C2=A0 1=
6</div><div class=3D"gmail_default">[=C2=A0 5]=C2=A0 =C2=A04.00-5.00=C2=A0 =
=C2=A0sec=C2=A0 =C2=A0128 KBytes=C2=A0 <b>1.05 Mbits/sec</b>=C2=A0 16</div>=
<div class=3D"gmail_default">[=C2=A0 5]=C2=A0 =C2=A05.00-6.00=C2=A0 =C2=A0s=
ec=C2=A0 =C2=A0128 KBytes=C2=A0 <b>1.05 Mbits/sec</b>=C2=A0 16</div><div cl=
ass=3D"gmail_default">[=C2=A0 5]=C2=A0 =C2=A06.00-7.00=C2=A0 =C2=A0sec=C2=
=A0 =C2=A0128 KBytes=C2=A0 <b>1.05 Mbits/sec=C2=A0 </b>16</div><div class=
=3D"gmail_default">[=C2=A0 5]=C2=A0 =C2=A07.00-8.00=C2=A0 =C2=A0sec=C2=A0 =
=C2=A0128 KBytes=C2=A0 <b>1.05 Mbits/sec</b>=C2=A0 16</div><div class=3D"gm=
ail_default">[=C2=A0 5]=C2=A0 =C2=A08.00-9.00=C2=A0 =C2=A0sec=C2=A0 =C2=A01=
28 KBytes=C2=A0 <b>1.05 Mbits/sec=C2=A0</b> 16</div><div class=3D"gmail_def=
ault">[=C2=A0 5]=C2=A0 =C2=A09.00-10.00=C2=A0 sec=C2=A0 =C2=A0128 KBytes=C2=
=A0 <b>1.05 Mbits/sec</b>=C2=A0 16</div><div class=3D"gmail_default">[=C2=
=A0 5]=C2=A0 10.00-11.00=C2=A0 sec=C2=A0 =C2=A0128 KBytes=C2=A0 <b>1.05 Mbi=
ts/sec</b>=C2=A0 16</div><div class=3D"gmail_default">[=C2=A0 5]=C2=A0 11.0=
0-12.00=C2=A0 sec=C2=A0 =C2=A0128 KBytes=C2=A0 <b>1.05 Mbits/sec</b>=C2=A0 =
16</div><div class=3D"gmail_default">[=C2=A0 5]=C2=A0 12.00-13.00=C2=A0 sec=
=C2=A0 =C2=A0128 KBytes=C2=A0 <b>1.05 Mbits/sec</b>=C2=A0 16</div><div clas=
s=3D"gmail_default">[=C2=A0 5]=C2=A0 13.00-14.00=C2=A0 sec=C2=A0 =C2=A0128 =
KBytes=C2=A0 <b>1.05 Mbits/sec</b>=C2=A0 16</div><div class=3D"gmail_defaul=
t">[=C2=A0 5]=C2=A0 14.00-14.89=C2=A0 sec=C2=A0 =C2=A0112 KBytes=C2=A0 <b>1=
.03 Mbits/sec</b>=C2=A0 14</div><div class=3D"gmail_default">- - - - - - - =
- - - - - - - - - - - - - - - - - -</div><div class=3D"gmail_default">[ ID]=
 Interval=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=
=A0Bandwidth=C2=A0 =C2=A0 =C2=A0 =C2=A0Jitter=C2=A0 =C2=A0 Lost/Total Datag=
</div><div class=3D"gmail_default">rams</div><div class=3D"gmail_default">[=
=C2=A0 5]=C2=A0 =C2=A00.00-14.89=C2=A0 sec=C2=A0 1.85 MBytes=C2=A0 <b>1.04 =
Mbits/sec</b>=C2=A0 0.000 ms=C2=A0 0/237 (0%)</div><div class=3D"gmail_defa=
ult">iperf3: interrupt - the server has terminated</div></div><div class=3D=
"gmail_default"><br></div><div class=3D"gmail_default"><br></div></div></di=
v></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri,=
 Oct 5, 2018 at 5:25 PM Selva Nair &lt;<a href=3D"mailto:selva.nair@...1354...=
..">selva.nair@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"><div dir=3D"ltr">Hi,<br><div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Fri, Oct 5, 2018 at 4:02 AM Rostyslav Maryliak &lt;<a href=3D"m=
ailto:rostyslav.maryliak@...2454..." target=3D"_blank">rostyslav.maryliak@...220...=
..2454...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr=
"><div dir=3D"ltr"><div style=3D"font-family:arial,helvetica,sans-serif">De=
ar Selva,</div><div style=3D"font-family:arial,helvetica,sans-serif"><br></=
div><div style=3D"font-family:arial,helvetica,sans-serif">I&#39;ve got a si=
milar results. Except the outbound network speed for win2016 server.</div><=
div style=3D"font-family:arial,helvetica,sans-serif">The bandwidth in clear=
 is about 700 Mbits/sec in both directions and different measures (with -R =
option and without it):</div><div style=3D"font-family:arial,helvetica,sans=
-serif"><br></div><div style=3D"font-family:arial,helvetica,sans-serif"><di=
v>[ ID] Interval=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Transfer=C2=A0 =C2=
=A0 =C2=A0Bandwidth</div><div>[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=
=C2=A0 =C2=A0880 MBytes=C2=A0 =C2=A0<b>739 Mbits/sec=C2=A0 =C2=A0</b> =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sender</div><div>[=C2=A0 4]=
=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0880 MBytes=C2=A0 =C2=A0<b>738=
 Mbits/sec</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 receiver</div><div><br></div><div><br></div><div>Here are the same meas=
ures through the VPN tunnel:</div><div><br></div><div><b>1. win2012r2 (iper=
f -s)=C2=A0+ win2016 (iperf -c)</b></div><div><div>[ ID] Interval=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwidth</div><=
div>[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0103 MBytes=C2=
=A0<b> 86.2 Mbits/sec</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 sender</div><div>[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=
=C2=A0 =C2=A0103 MBytes=C2=A0 <b>86.1 Mbits/sec=C2=A0</b> =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 receiver</div></div><div><b><br></b>=
</div><div><b>2. win2012r2 (iperf -s)=C2=A0+ win2016 (iperf -c -R)</b>=C2=
=A0</div><div><div>The same as you in this mode I can see=C2=A0<span style=
=3D"font-family:Arial,Helvetica,sans-serif">0 bits/s for about 3-7 seconds =
and then the transfer starts and picks</span><span style=3D"font-family:Ari=
al,Helvetica,sans-serif">=C2=A0the normal transfer rate.</span></div><div>[=
 ID] Interval=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Transfer=C2=A0 =C2=A0=
 =C2=A0Bandwidth<br></div><div>[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=
=C2=A0 =C2=A0130 MBytes=C2=A0 =C2=A0<b>109 Mbits/sec=C2=A0</b> =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sender</div><div>[=C2=A0 4]=
=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0130 MBytes=C2=A0 =C2=A0<b>109=
 Mbits/sec=C2=A0</b> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 receiver</div></div><div><br></div><div><b>3. win2012r2 (iperf -c)=C2=
=A0+ win2016 (iperf -s)</b><br></div><div><div>[ ID] Interval=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwidth</div><div>=
[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0140 MBytes=C2=A0 =
=C2=A0<b>117 Mbits/sec</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 sender</div><div>[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=
=C2=A0 =C2=A0140 MBytes=C2=A0 =C2=A0<b>117 Mbits/sec</b>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 receiver</div></div><div><br>=
</div><div><b>4. win2012r2 (iperf -c -R)=C2=A0+ win2016 (iperf -s)</b>=C2=
=A0<b><br></b></div><div><div>[ ID] Interval=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Transfer=C2=A0 =C2=A0 =C2=A0Bandwidth</div><div>[=C2=A0 4]=C2=A0 =
=C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0640 KBytes=C2=A0 =C2=A0<b>524 Kbits/=
sec</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sende=
r</div><div>[=C2=A0 4]=C2=A0 =C2=A00.00-10.00=C2=A0 sec=C2=A0 =C2=A0512 KBy=
tes=C2=A0 =C2=A0<b>419 Kbits/sec=C2=A0 </b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 receiver</div></div></div></div></div></div></div>=
</div></div></blockquote><div><br></div><div>#1 and #3 shows the speed is g=
ood in both directions, so looks like the problem surfaces only when -R is =
used. Not saying this is an iperf issue as you see low bandwidth in general=
 use as well. I don&#39;t know what causes this (the TAP driver?) but hopef=
ully others may chime in with some clue.<br><br>Could you please re-do the =
-R tests with a longer test time (say iperf3 -t 30 ...). Also test udp spee=
ds (ie. iperf3 -u ...) keeping the tunnel udp.<br><br></div><div>Thanks,<br=
><br></div><div>Selva</div></div></div></div>
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

--00000000000063db3105777c59e7--

