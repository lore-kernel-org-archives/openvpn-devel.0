MIME-Version: 1.0
References: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
 <CAFHpkQG10QOhGUb4R4VyPHwCNMfkVSQgCVgmypsBidsgNcsBaw@...278...>
 <CADkMwqQ+F-rLr3V5_BxjixbvnyOW6T+Y6tP---3PBaOcHkRBpA@...278...>
 <CAFHpkQExnJLdr1kNMkXoYxXjOdX4+M3KTcOfBp1ZQwmV3CkkXA@...278...>
 <CADkMwqS7AUDVz_tj0_6ewhJ7YgfJmph71dK-hCVhgOY=5+z3oA@...278...>
 <CAFHpkQHhy_w=0vSag_cqwQ=BiPStuVBzK0GOheMpjvpFFY_wAQ@...278...>
 <CADkMwqQCC_5=tWyX5HPQpPBVqwm8eoisYY=GtjLYcwx7KpN2Hg@...278...>
In-Reply-To: <CADkMwqQCC_5=tWyX5HPQpPBVqwm8eoisYY=GtjLYcwx7KpN2Hg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 4 Oct 2018 17:14:11 +0500
Message-ID: <CAFHpkQHpaLNwfWvm3C6YsWE1wTRndXMJPa4QkBqcvMGTwk7=dw@...278...>
Content-Type: multipart/alternative; boundary="0000000000006d287b057766187e"
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

--0000000000006d287b057766187e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

congestion can be setup using datacenter bridging

https://docs.microsoft.com/en-us/windows-server/networking/technologies/dcb=
/dcb-manage

actually, I thought it works in another direction (i.e. you specify it in
windows and distribute to network switches).
is DCB in use ?

=D1=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 17:02, Rostyslav Ma=
ryliak <
rostyslav.maryliak@...2454...>:

> Dear Ilya,
>
> Sure, the results are the same for all our win2016 servers:
>
> PS C:\Users\Administrator> [environment]::OSVersion.Version
>
> Major     Minor     Build        Revision
> -----        -----        -----          --------
> 10          0            14393      0
>
> On Thu, Oct 4, 2018 at 2:45 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
>
>>
>>
>> =D1=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 15:50, Rostyslav=
 Maryliak <
>> rostyslav.maryliak@...2454...>:
>>
>>> Dear Illya,
>>>
>>> Sorry for misleading you. I want to set this parameter to "none"
>>> globally.
>>> I CAN change "Congestion Control Provider" setting for different
>>> templates (i.e. Internet. Datacenter etc) in Powershell, but not to a
>>> "None" value.
>>>
>>> In Powershell there is simply no option for this value:
>>> PS C:\Users\Administrator> Set-NetTCPSetting -SettingName Datacenter
>>> -CongestionProvider [ CTCP | CUBIC | DCTCP | Default | LEDBAT | NewReno=
 ]
>>>
>>> I've tried different values, but still no luck.
>>>
>>> In CMD there is such option, but it does not apply any changes for it:
>>> C:\Users\Administrator> netsh int tcp set supplemental
>>> template=3Ddatacenter congestionprovider=3D*none*
>>> Ok.
>>>
>>> C:\Users\Administrator> netsh int tcp show supplemental
>>> template=3Ddatacenter
>>> TCP Supplemental Parameters
>>> ----------------------------------------------
>>> Minimum RTO (msec)                       : 20
>>> Initial Congestion Window (MSS)     : 10
>>> Congestion Control Provider             : *dctcp*
>>> Enable Congestion Window Restart  : enabled
>>> Delayed ACK timeout (msec)            : 10
>>> Delayed ACK frequency                    : 2
>>> Enable RACK                                    : disabled
>>> Enable Tail Loss Probe                     : disabled
>>>
>>> Also, as I've mentioned in referred thread, such issue occurs on all our
>>> win2016 servers, except one.
>>>
>>
>> can you provide the output of
>>
>>
>> [environment]::OSVersion.Version
>>
>> for that 2016 server ? (and for other servers)
>>
>>
>>
>>> This exception server has "Congestion Control Provider" setting set to
>>> "none" somehow.
>>> But still it is very strange for me that I have such slow network speed
>>> via the tunnel for all win2016 servers "out of the box".
>>>
>>> Can you please check this from your side as well and confirm or disprove
>>> the issue?
>>>
>>>
>>> On Thu, Oct 4, 2018 at 12:10 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
>>> wrote:
>>>
>>>> thank you for your investigation.
>>>>
>>>> congestion provider can be customized if you select "*Datacenter
>>>> Custom"*
>>>>
>>>> =D1=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 13:58, Rostysl=
av Maryliak <
>>>> rostyslav.maryliak@...2454...>:
>>>>
>>>>> Dear Ilya,
>>>>>
>>>>> I've checked "Get-NetTCPConnection" command output on both win2012r2
>>>>> and win2016 servers.
>>>>>
>>>>> win2012r2 server works as OpenVPN server. Internal IP address -
>>>>> 10.0.4.1. OpenVPN tunnel IP address - 172.16.144.1
>>>>> win2016 server works as OpenVPN client. Internal IP address -
>>>>> 10.0.44.1. OpenVPN tunnel IP address - 172.16.144.18
>>>>>
>>>>>
>>>>> *From win2012r2 server:*
>>>>>
>>>>> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress
>>>>> 10.0.44.1
>>>>> LocalAddress                        LocalPort          RemoteAddress
>>>>>                RemotePort             State                  AppliedS=
etting
>>>>> ------------                               ---------
>>>>>  -------------                           ----------
>>>>> -----                     --------------
>>>>> 172.16.144.1                         56437               10.0.44.1
>>>>>                         53005                      Established
>>>>> *Datacenter*
>>>>>
>>>>> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress
>>>>> 172.16.144.18
>>>>> LocalAddress                       LocalPort           RemoteAddress
>>>>>                RemotePort             State                  AppliedS=
etting
>>>>> ------------                               ---------
>>>>>  -------------                           ----------
>>>>> -----                     --------------
>>>>> 10.0.4.1                                11616
>>>>> 172.16.144.18                    56882                      Establish=
ed
>>>>>     *Datacenter*
>>>>> 10.0.4.1                                11616
>>>>> 172.16.144.18                    56905                      Establish=
ed
>>>>>     *Datacenter*
>>>>>
>>>>>
>>>>> *From win2016 server:*
>>>>>
>>>>> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress 10.0.4=
.1
>>>>> LocalAddress                       LocalPort           RemoteAddress
>>>>>                RemotePort             State                 AppliedSe=
tting
>>>>>          OwningProcess
>>>>> ------------                               ---------
>>>>>  -------------                           ----------
>>>>>  -----                   --------------                 -------------
>>>>> 172.16.144.18                      56905                10.0.4.1
>>>>>                        11616                       Established       *
>>>>> Internet *                   13300
>>>>> 172.16.144.18                      56882                10.0.4.1
>>>>>                        11616                       Established       *
>>>>> Internet  *                  13300
>>>>>
>>>>>
>>>>> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress
>>>>> 172.16.144.1
>>>>> LocalAddress                       LocalPort           RemoteAddress
>>>>>                RemotePort             State                 AppliedSe=
tting
>>>>>          OwningProcess
>>>>> ------------                               ---------
>>>>>  -------------                           ----------
>>>>> -----                    --------------                 -------------
>>>>> 10.0.44.1                              53005
>>>>> 172.16.144.1                      56437                      Establis=
hed
>>>>>    *Internet*                      13300
>>>>>
>>>>>
>>>>> I've changed the "AppliedSetting" value to Datacenter on win2016
>>>>> server as well by running this commands and restarting the VPN:
>>>>> New-NetTransportFilter -SettingName Datacenter -DestinationPrefix
>>>>> 10.0.4.0/24
>>>>> New-NetTransportFilter -SettingName Datacenter -DestinationPrefix
>>>>> 172.16.144.0/24
>>>>>
>>>>> Now it shows Datacenter on both servers. But the network speed remains
>>>>> the same. My changes do not affect the issue.
>>>>> I've noticed that global TCP settings influence that, especially
>>>>> "Chimney Offload", "Congestion Control Provider" and "ECN Capability":
>>>>>
>>>>> C:\Users\Administrator> netsh int tcp show global
>>>>> Querying active state...
>>>>>
>>>>> TCP Global Parameters
>>>>> ----------------------------------------------
>>>>> Receive-Side Scaling State                   : enabled
>>>>> Chimney Offload State                          : disabled
>>>>> NetDMA State                                       : disabled
>>>>> Direct Cache Access (DCA)                  : disabled
>>>>> Receive Window Auto-Tuning Level     : normal
>>>>> Add-On Congestion Control Provider   : default
>>>>> ECN Capability                                      : enabled
>>>>> RFC 1323 Timestamps                         : disabled
>>>>> Initial RTO                                             : 3000
>>>>> Receive Segment Coalescing State     : enabled
>>>>> Non Sack Rtt Resiliency                       : disabled
>>>>> Max SYN Retransmissions                   : 2
>>>>> TCP Fast Open                                     : disabled
>>>>>
>>>>>
>>>>> That is why I believe that the root cause of the issue lies in
>>>>> "Congestion Control Provider" setting. But I am unable to change it
>>>>>
>>>>> On Thu, Oct 4, 2018 at 7:50 AM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
>>>>> wrote:
>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> can you do some things and tell us your observation ?
>>>>>>
>>>>>> starting with win2012 so called network profiles were introduced
>>>>>> (Internet / Intranet / Datacenter)
>>>>>> those profiles are very different for tcp connection (if you observe
>>>>>> degradation in case of udp, most probably that is not related)
>>>>>>
>>>>>>
>>>>>> so, let's start
>>>>>>
>>>>>> start powershell (I assume you are familiar)
>>>>>> call
>>>>>>
>>>>>> Get-NetTCPConnection
>>>>>>
>>>>>> pay attention to "AppliedSetting" column.
>>>>>> what's there  ?
>>>>>>
>>>>>> we did observe strange things when win2012 classified some traffic as
>>>>>> "Internet" and appropriate tcp settings were applied.
>>>>>>
>>>>>> is there some correlation in your case ?
>>>>>>
>>>>>> =D1=81=D1=80, 3 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 20:45, Rosty=
slav Maryliak <
>>>>>> rostyslav.maryliak@...2454...>:
>>>>>>
>>>>>>> Dear OpenVPN developers,
>>>>>>>
>>>>>>> I've faced a very strange issue with slow outbound network speed
>>>>>>> from Windows Server 2016 Standard server via the OpenVPN tunnel.
>>>>>>> OpenVPN server is Windows Server 2012 R2, client is Windows Server
>>>>>>> 2016. The inbound network speed for Windows Server 2016 is great.
>>>>>>> But the outbound network speed is nearly 30-40 kbps. I've got the
>>>>>>> same results using several tests: iperf testings, file download via=
 SMB,
>>>>>>> Web-based downloading (using HTTP) etc.
>>>>>>>
>>>>>>> The tunnels is getting up and it works greatly, but only in one
>>>>>>> direction - from Windows Server 2012 R2 to Windows Server 2016.
>>>>>>> I've been using such server-client configurations setup for several
>>>>>>> years with Windows Server 2012 R2 servers and I've never faced such=
 issue
>>>>>>> before.
>>>>>>> At first I thought that our ISP has some network limitations, but it
>>>>>>> turned out that the same tests shows great network speed results us=
ing the
>>>>>>> public IP addresses in both directions.
>>>>>>> The issue only occurs inside the VPN tunnel. I've spent 3 days tryng
>>>>>>> to figure it out, but failed. I've installed all latest Windows upd=
ates,
>>>>>>> reinstalled OpenVPN, tried to switch from UDP to TCP,
>>>>>>> played with performance settings in configs (link-mtu, sndbuf,
>>>>>>> rcvbuf etc) but still no luck. I've tested the same setup between t=
wo
>>>>>>> Windows Server 2012 R2 servers and it works greatly in both directi=
ons.
>>>>>>> Then I've tested it with another Windows Server 2016 Standard server
>>>>>>> (different server and different ISP) and it showed the same awful r=
esults
>>>>>>> in outbound direction.
>>>>>>> When I've set the same OpenVPN tunnel between two Windows Server
>>>>>>> 2016 Standard servers I've got the same poor network speed in both
>>>>>>> directions.
>>>>>>>
>>>>>>> I believe that the issue is somehow related only to the Windows
>>>>>>> Server 2016 version and I am more than confident that it depends on
>>>>>>> server's TCP stack settings.
>>>>>>> I've noticed that Windows Server 2016 has a congestion control
>>>>>>> provider setting set to "default", while previous versions of Windo=
ws has
>>>>>>> this setting set to "none".
>>>>>>>
>>>>>>> I've created a topic on OpenVPN Support Forum and it was suggested
>>>>>>> to post my issue to you and reference the thread.
>>>>>>>
>>>>>>> You can reference to the
>>>>>>> https://forums.openvpn.net/viewtopic.php?f=3D6&t=3D27173 for config
>>>>>>> files and additional information.
>>>>>>>
>>>>>>> Have you faced a similar issue before? Can you provide any hint how
>>>>>>> can I resolve the issue? What did I missed?
>>>>>>> I would be very grateful for any help. Thank you in advance.
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>>
>>>>>>> Best regards,
>>>>>>>
>>>>>>> *Rostyslav Maryliak*
>>>>>>>
>>>>>>> System Administrator
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> *iDeals=E2=84=A2 Solutions Group*| + 38(073)437-72-51
>>>>>>> <%2B%2038%28093%29575-35-16> | Skype: rostyslav.maryliak.ideals| *r=
ostyslav.maryliak@...2454...
>>>>>>> <dmitry.zaporozhchenko@...2454...>* | www.idealsvdr.com
>>>>>>> <http://www.idealscorp.com/>
>>>>>>>
>>>>>>> CONFIDENTIALITY NOTE: The information transmitted, including
>>>>>>> attachments, is intended only for the person(s) or entity to which =
it is
>>>>>>> addressed and may contain confidential and/or privileged material. =
Any
>>>>>>> review, retransmission, dissemination or other use of, or taking of=
 any
>>>>>>> action in reliance upon this information by persons or entities oth=
er than
>>>>>>> the intended recipient is prohibited. If you received this in error=
, please
>>>>>>> contact the sender and destroy any copies of this information.
>>>>>>> _______________________________________________
>>>>>>> Openvpn-devel mailing list
>>>>>>> Openvpn-devel@lists.sourceforge.net
>>>>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>>>>
>>>>>>
>>>>>
>>>>> --
>>>>>
>>>>> Best regards,
>>>>>
>>>>> *Rostyslav Maryliak*
>>>>>
>>>>> System Administrator
>>>>>
>>>>>
>>>>>
>>>>> *iDeals=E2=84=A2 Solutions Group*| + 38(073)437-72-51
>>>>> <%2B%2038%28093%29575-35-16> | Skype: rostyslav.maryliak.ideals| *ros=
tyslav.maryliak@...2454...
>>>>> <dmitry.zaporozhchenko@...2454...>* | www.idealsvdr.com
>>>>> <http://www.idealscorp.com/>
>>>>>
>>>>> CONFIDENTIALITY NOTE: The information transmitted, including
>>>>> attachments, is intended only for the person(s) or entity to which it=
 is
>>>>> addressed and may contain confidential and/or privileged material. Any
>>>>> review, retransmission, dissemination or other use of, or taking of a=
ny
>>>>> action in reliance upon this information by persons or entities other=
 than
>>>>> the intended recipient is prohibited. If you received this in error, =
please
>>>>> contact the sender and destroy any copies of this information.
>>>>
>>>>
>>>
>>> --
>>>
>>> Best regards,
>>>
>>> *Rostyslav Maryliak*
>>>
>>> System Administrator
>>>
>>>
>>>
>>> *iDeals=E2=84=A2 Solutions Group*| + 38(073)437-72-51
>>> <%2B%2038%28093%29575-35-16> | Skype: rostyslav.maryliak.ideals| *rosty=
slav.maryliak@...2454...
>>> <dmitry.zaporozhchenko@...2454...>* | www.idealsvdr.com
>>> <http://www.idealscorp.com/>
>>>
>>> CONFIDENTIALITY NOTE: The information transmitted, including
>>> attachments, is intended only for the person(s) or entity to which it is
>>> addressed and may contain confidential and/or privileged material. Any
>>> review, retransmission, dissemination or other use of, or taking of any
>>> action in reliance upon this information by persons or entities other t=
han
>>> the intended recipient is prohibited. If you received this in error, pl=
ease
>>> contact the sender and destroy any copies of this information.
>>
>>
>
> --
>
> Best regards,
>
> *Rostyslav Maryliak*
>
> System Administrator
>
>
>
> *iDeals=E2=84=A2 Solutions Group*| + 38(073)437-72-51 <%2B%2038%28093%295=
75-35-16> |
> Skype: rostyslav.maryliak.ideals| *rostyslav.maryliak@...2454...
> <dmitry.zaporozhchenko@...2454...>* | www.idealsvdr.com
> <http://www.idealscorp.com/>
>
> CONFIDENTIALITY NOTE: The information transmitted, including attachments,
> is intended only for the person(s) or entity to which it is addressed and
> may contain confidential and/or privileged material. Any review,
> retransmission, dissemination or other use of, or taking of any action in
> reliance upon this information by persons or entities other than the
> intended recipient is prohibited. If you received this in error, please
> contact the sender and destroy any copies of this information.

--0000000000006d287b057766187e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>congestion can be setup using datace=
nter bridging <br></div><div><br></div><div><a href=3D"https://docs.microso=
ft.com/en-us/windows-server/networking/technologies/dcb/dcb-manage">https:/=
/docs.microsoft.com/en-us/windows-server/networking/technologies/dcb/dcb-ma=
nage</a></div><div><br></div><div>actually, I thought it works in another d=
irection (i.e. you specify it in windows and distribute to network switches=
).</div><div>is DCB in use ?<br></div></div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr">=D1=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=
=B2 17:02, Rostyslav Maryliak &lt;<a href=3D"mailto:rostyslav.maryliak@...1665...=
454...">rostyslav.maryliak@...2454...</a>&gt;:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default=
" style=3D"font-family:arial,helvetica,sans-serif">Dear Ilya,</div><div cla=
ss=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br><=
/div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans=
-serif">Sure, the results are the same for all our win2016 servers:</div><d=
iv class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"=
><br></div><div class=3D"gmail_default"><div class=3D"gmail_default"><font =
face=3D"arial, helvetica, sans-serif">PS C:\Users\Administrator&gt; [enviro=
nment]::OSVersion.Version</font></div><div class=3D"gmail_default"><font fa=
ce=3D"arial, helvetica, sans-serif"><br></font></div><div class=3D"gmail_de=
fault"><font face=3D"arial, helvetica, sans-serif">Major=C2=A0 =C2=A0 =C2=
=A0Minor=C2=A0 =C2=A0 =C2=A0Build=C2=A0 =C2=A0 =C2=A0 =C2=A0 Revision</font=
></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-se=
rif">-----=C2=A0 =C2=A0 =C2=A0 =C2=A0 -----=C2=A0 =C2=A0 =C2=A0 =C2=A0 ----=
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --------</font></div><div class=3D"gmai=
l_default"><font face=3D"arial, helvetica, sans-serif">10=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 14393=C2=A0 =
=C2=A0 =C2=A0 0</font></div></div></div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr">On Thu, Oct 4, 2018 at 2:45 PM =D0=98=D0=BB=D1=8C=D1=8F =
=D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine=
@...277..." target=3D"_blank">chipitsine@...277...</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr">=D1=87=D1=82, 4 =D0=BE=D0=BA=D1=
=82. 2018 =D0=B3. =D0=B2 15:50, Rostyslav Maryliak &lt;<a href=3D"mailto:ro=
styslav.maryliak@...2454..." target=3D"_blank">rostyslav.maryliak@...2456...=
.</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"=
ltr"><div style=3D"font-family:arial,helvetica,sans-serif">Dear Illya,</div=
><div style=3D"font-family:arial,helvetica,sans-serif"><br></div><div style=
=3D"font-family:arial,helvetica,sans-serif">Sorry for misleading you. I wan=
t to set this parameter to &quot;none&quot; globally.</div><div style=3D"fo=
nt-family:arial,helvetica,sans-serif">I CAN change=C2=A0<span style=3D"font=
-family:Arial,Helvetica,sans-serif">&quot;Congestion Control Provider&quot;=
 setting for different templates (i.e. Internet. Datacenter etc) in Powersh=
ell, but not to a &quot;None&quot; value.</span></div><div style=3D"font-fa=
mily:arial,helvetica,sans-serif"><span style=3D"font-family:Arial,Helvetica=
,sans-serif"><br></span></div><div style=3D"font-family:arial,helvetica,san=
s-serif"><span style=3D"font-family:Arial,Helvetica,sans-serif">In Powershe=
ll there is simply no option for this value:</span></div><div style=3D"font=
-family:arial,helvetica,sans-serif"><span style=3D"font-family:Arial,Helvet=
ica,sans-serif">PS C:\Users\Administrator&gt; Set-NetTCPSetting -SettingNam=
e Datacenter -CongestionProvider [ CTCP | CUBIC | DCTCP | Default | LEDBAT =
| NewReno ]</span><br></div><div><br></div><div>I&#39;ve tried different va=
lues, but still no luck.</div><div><br></div><div>In CMD there is such opti=
on, but it does not apply any changes for it:</div><div>C:\Users\Administra=
tor&gt; netsh int tcp set supplemental template=3Ddatacenter congestionprov=
ider=3D<b>none</b><br></div><div>Ok.<br></div><div><br></div><div><div>C:\U=
sers\Administrator&gt; netsh int tcp show supplemental template=3Ddatacente=
r</div><div>TCP Supplemental Parameters</div><div>-------------------------=
---------------------</div><div>Minimum RTO (msec)=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 20</div><div>I=
nitial Congestion Window (MSS)=C2=A0 =C2=A0 =C2=A0: 10</div><div>Congestion=
 Control Provider=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:=C2=A0<b>=
dctcp</b></div><div>Enable Congestion Window Restart=C2=A0 : enabled</div><=
div>Delayed ACK timeout (msec)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 1=
0</div><div>Delayed ACK frequency=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 : 2</div><div>Enable RACK=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : disabled</div><div>Enable Tail Loss Probe=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0: disabled</div><div><br></div><div>Also, as I&#39;ve mentioned in refer=
red thread, such issue occurs on all our win2016 servers, except one.</div>=
</div></div></div></div></div></div></blockquote><div><br></div><div>can yo=
u provide the output of</div><div><br></div><div><br></div><div>[environmen=
t]::OSVersion.Version</div><div><br></div><div>for that 2016 server ? (and =
for other servers)<br></div><div><br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div d=
ir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><div>This exception serve=
r has &quot;Congestion Control Provider&quot; setting set to &quot;none&quo=
t; somehow.</div><div>But still it is very strange for me that I have such =
slow network speed via the tunnel for all win2016 servers &quot;out of the =
box&quot;.</div><div><br></div><div>Can you please check this from your sid=
e as well and confirm or disprove the issue?</div></div><div><br></div></di=
v></div></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">O=
n Thu, Oct 4, 2018 at 12:10 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277..." target=
=3D"_blank">chipitsine@...277...</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>thank you for your i=
nvestigation.</div><div><br></div><div>congestion provider can be customize=
d if you select &quot;<span class=3D"m_8769582382459335421m_-64538608428675=
51512gmail-m_3470655929018968434m_-5061142619719305404gmail-st"><i>Datacent=
er Custom&quot;</i></span></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr">=D1=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 13:58, R=
ostyslav Maryliak &lt;<a href=3D"mailto:rostyslav.maryliak@...2454..." targ=
et=3D"_blank">rostyslav.maryliak@...2454...</a>&gt;:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div=
 dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"font-family:ar=
ial,helvetica,sans-serif">Dear Ilya,</div><div style=3D"font-family:arial,h=
elvetica,sans-serif"><br></div><div style=3D"font-family:arial,helvetica,sa=
ns-serif">I&#39;ve checked &quot;<span style=3D"font-family:Arial,Helvetica=
,sans-serif">Get-NetTCPConnection</span>&quot; command output on both win20=
12r2 and win2016 servers.</div><div style=3D"font-family:arial,helvetica,sa=
ns-serif"><br></div><div style=3D"font-family:arial,helvetica,sans-serif">w=
in2012r2 server works as OpenVPN server. Internal IP address - 10.0.4.1. Op=
enVPN tunnel IP address - 172.16.144.1</div><div style=3D"font-family:arial=
,helvetica,sans-serif">win2016 server works as OpenVPN client. Internal IP =
address - 10.0.44.1. OpenVPN tunnel IP address - 172.16.144.18</div><div st=
yle=3D"font-family:arial,helvetica,sans-serif"><br></div><div style=3D"font=
-family:arial,helvetica,sans-serif"><br></div><div style=3D"font-family:ari=
al,helvetica,sans-serif"><b>From win2012r2 server:</b></div><div style=3D"f=
ont-family:arial,helvetica,sans-serif"><br></div><div><font face=3D"arial, =
helvetica, sans-serif">PS C:\Users\Administrator&gt; Get-NetTCPConnection -=
RemoteAddress 10.0.44.1</font></div><div><span style=3D"font-family:arial,h=
elvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LocalPort=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RemoteAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Stat=
e=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AppliedSett=
ing</span><br></div><div><font face=3D"arial, helvetica, sans-serif">------=
------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---------=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---------=
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ----=
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0--------------</font></div><div><font face=3D"arial, helvetica, sans-ser=
if">172.16.144.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A056437=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A010.0.44.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 53005=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Established=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 <b>Datacenter</b></font></div><div><font face=3D"arial=
, helvetica, sans-serif"><br></font></div><div><span style=3D"font-family:a=
rial,helvetica,sans-serif">PS C:\Users\Administrator&gt; Get-NetTCPConnecti=
on -RemoteAddress 172.16.144.18</span><br></div><div><span style=3D"font-fa=
mily:arial,helvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LocalPort=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemoteAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 AppliedSetting</span><br></div><div><font face=3D"arial, helvetica, =
sans-serif">------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---------=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0----------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 -----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0--------------</font></div><div><font face=3D"arial=
, helvetica, sans-serif">10.0.4.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11616=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 172.16.144.18=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 56882=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Esta=
blished=C2=A0 =C2=A0 =C2=A0 =C2=A0 <b>Datacenter</b></font></div><div><font=
 face=3D"arial, helvetica, sans-serif">10.0.4.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 11616=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 172=
.16.144.18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 56905=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Established=C2=A0 =C2=A0 =C2=A0 =C2=A0 <b>Datacenter</b></fon=
t><span style=3D"font-family:arial,helvetica,sans-serif">=C2=A0=C2=A0<br></=
span></div><div><span style=3D"font-family:arial,helvetica,sans-serif"><br>=
</span></div><div><span style=3D"font-family:arial,helvetica,sans-serif"><b=
r></span></div><div><b style=3D"font-family:arial,helvetica,sans-serif">Fro=
m win2016 server:</b>=C2=A0=C2=A0<span style=3D"font-family:arial,helvetica=
,sans-serif"><br></span></div><div><br></div><div><div><font face=3D"arial,=
 helvetica, sans-serif">PS C:\Users\Administrator&gt; Get-NetTCPConnection =
-RemoteAddress 10.0.4.1</font></div><div><span style=3D"font-family:arial,h=
elvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LocalPort=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0RemoteAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AppliedS=
etting=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OwningProcess</span><br></di=
v><div><font face=3D"arial, helvetica, sans-serif">------------=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0---------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0-------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0----------=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------=
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0------------=
-</font></div><div><font face=3D"arial, helvetica, sans-serif">172.16.144.1=
8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 56905=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10.0.4.1=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A011616=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Established=C2=A0 =C2=A0 =C2=
=A0 =C2=A0<b> Internet=C2=A0</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A013300</font></div><div><font face=3D"arial, helv=
etica, sans-serif">172.16.144.18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 56882=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 10.0.4.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A011616=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Es=
tablished=C2=A0 =C2=A0 =C2=A0 =C2=A0<b> Internet=C2=A0 </b>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 13300</font></div><div><fo=
nt face=3D"arial, helvetica, sans-serif"><br></font></div><div><font face=
=3D"arial, helvetica, sans-serif"><br></font></div><div><font face=3D"arial=
, helvetica, sans-serif">PS C:\Users\Administrator&gt; Get-NetTCPConnection=
 -RemoteAddress 172.16.144.1</font></div><div><span style=3D"font-family:ar=
ial,helvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LocalPort=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0RemoteAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A=
ppliedSetting=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OwningProcess</span><=
br></div><div><font face=3D"arial, helvetica, sans-serif">------------=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0-------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0----------=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -----=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -----------=
---=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0----------=
---</font></div><div><font face=3D"arial, helvetica, sans-serif">10.0.44.1=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 53005=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 172.16.144.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 56437=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Established=C2=A0 =C2=A0 =C2=A0 =C2=
=A0<b>Internet</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 13300</font></div><div><font face=3D"arial, helvetica,=
 sans-serif"><br></font></div><div><font face=3D"arial, helvetica, sans-ser=
if"><br></font></div><div><font face=3D"arial, helvetica, sans-serif">I&#39=
;ve changed the &quot;AppliedSetting&quot; value to Datacenter on win2016 s=
erver as well by running this commands and restarting the VPN:</font></div>=
<div><font face=3D"arial, helvetica, sans-serif">New-</font><span style=3D"=
font-family:arial,helvetica,sans-serif">NetTransportFilter -SettingName Dat=
acenter -DestinationPrefix <a href=3D"http://10.0.4.0/24" target=3D"_blank"=
>10.0.4.0/24</a></span></div><div><span style=3D"font-family:arial,helvetic=
a,sans-serif">New-NetTransportFilter -SettingName Datacenter -DestinationPr=
efix <a href=3D"http://172.16.144.0/24" target=3D"_blank">172.16.144.0/24</=
a></span>=C2=A0=C2=A0<span style=3D"font-family:arial,helvetica,sans-serif"=
><br></span></div><div><br></div><div>Now it shows Datacenter on both serve=
rs. But the network speed remains the same. My changes do not affect the is=
sue.</div><div>I&#39;ve noticed that global TCP settings influence that, es=
pecially &quot;Chimney Offload&quot;, &quot;Congestion Control Provider&quo=
t; and &quot;ECN Capability&quot;:</div><div><br></div><div><div><span styl=
e=3D"font-family:arial,helvetica,sans-serif">C:\Users\Administrator&gt;=C2=
=A0</span>netsh int tcp show global</div><div>Querying active state...</div=
><div><br></div><div>TCP Global Parameters</div><div>----------------------=
------------------------</div><div>Receive-Side Scaling State=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: enabled</div><div>=
Chimney Offload State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : disabled</div><div>NetDMA State=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: disabled</d=
iv><div>Direct Cache Access (DCA)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 : disabled</div><div>Receive Window Auto-Tuning Level=
=C2=A0 =C2=A0 =C2=A0: normal</div><div>Add-On Congestion Control Provider=
=C2=A0 =C2=A0: default</div><div>ECN Capability=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : enabled</div><div>RFC 1323 Timestamps=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0: disabled</div><div>Initial RTO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 3000</div><div=
>Receive Segment Coalescing State=C2=A0 =C2=A0 =C2=A0: enabled</div><div>No=
n Sack Rtt Resiliency=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: disabled</div><div>Max SYN Retransmissions=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 2</d=
iv><div>TCP Fast Open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0: disabled</div><div><br></div><div><br></div><div>That is why I beli=
eve that the root cause of the issue lies in &quot;Congestion Control Provi=
der&quot; setting. But I am unable to change it</div></div></div></div></di=
v></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu,=
 Oct 4, 2018 at 7:50 AM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_b=
lank">chipitsine@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr"><div>Hello,</div><div><br></div>=
<div>can you do some things and tell us your observation ?</div><div><br></=
div><div>starting with win2012 so called network profiles were introduced (=
Internet / Intranet / Datacenter)</div><div>those profiles are very differe=
nt for tcp connection (if you observe degradation in case of udp, most prob=
ably that is not related)</div><div><br></div><div><br></div><div>so, let&#=
39;s start</div><div><br></div><div>start powershell (I assume you are fami=
liar)</div><div>call</div><div><br></div><div>Get-NetTCPConnection</div><di=
v><br></div><div>pay attention to &quot;AppliedSetting&quot; column.</div><=
div>what&#39;s there=C2=A0 ?</div><div><br></div><div>we did observe strang=
e things when win2012 classified some traffic as &quot;Internet&quot; and a=
ppropriate tcp settings were applied.</div><div><br></div><div>is there som=
e correlation in your case ?<br></div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr">=D1=81=D1=80, 3 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 20=
:45, Rostyslav Maryliak &lt;<a href=3D"mailto:rostyslav.maryliak@...2454...=
" target=3D"_blank">rostyslav.maryliak@...2454...</a>&gt;:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr=
"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>=
<font face=3D"arial, helvetica, sans-serif">Dear OpenVPN developers,</font>=
</div><div><font face=3D"arial, helvetica, sans-serif"><br></font></div><di=
v><font face=3D"arial, helvetica, sans-serif"><div>I&#39;ve faced a very st=
range issue with slow outbound network speed from Windows Server 2016 Stand=
ard server via the OpenVPN tunnel.</div><div>OpenVPN server is Windows Serv=
er 2012 R2, client is Windows Server 2016. The inbound network speed for Wi=
ndows Server 2016 is great.</div><div>But the outbound network speed is nea=
rly 30-40 kbps. I&#39;ve got the same results using several tests: iperf te=
stings, file download via SMB, Web-based downloading (using HTTP) etc.</div=
></font></div><div><font face=3D"arial, helvetica, sans-serif"><br></font><=
/div><div><font face=3D"arial, helvetica, sans-serif"><div>The tunnels is g=
etting up and it works greatly, but only in one direction - from Windows Se=
rver 2012 R2 to Windows Server 2016.</div><div>I&#39;ve been using such ser=
ver-client configurations setup for several years with Windows Server 2012 =
R2 servers and I&#39;ve never faced such issue before.</div><div>At first I=
 thought that our ISP has some network limitations, but it turned out that =
the same tests shows great network speed results using the public IP addres=
ses in both directions.</div><div>The issue only occurs inside the VPN tunn=
el. I&#39;ve spent 3 days tryng to figure it out, but failed. I&#39;ve inst=
alled all latest Windows updates, reinstalled OpenVPN, tried to switch from=
 UDP to TCP,</div><div>played with performance settings in configs (link-mt=
u, sndbuf, rcvbuf etc) but still no luck. I&#39;ve tested the same setup be=
tween two Windows Server 2012 R2 servers and it works greatly in both direc=
tions.</div><div>Then I&#39;ve tested it with another Windows Server 2016 S=
tandard server (different server and different ISP) and it showed the same =
awful results in outbound direction.</div><div>When I&#39;ve set the same O=
penVPN tunnel between two Windows Server 2016 Standard servers I&#39;ve got=
 the same poor network speed in both directions.</div></font></div><div><fo=
nt face=3D"arial, helvetica, sans-serif"><br></font></div><div><font face=
=3D"arial, helvetica, sans-serif"><div>I believe that the issue is somehow =
related only to the Windows Server 2016 version and I am more than confiden=
t that it depends on server&#39;s TCP stack settings.</div><div>I&#39;ve no=
ticed that Windows Server 2016 has a congestion control provider setting se=
t to &quot;default&quot;, while previous versions of Windows has this setti=
ng set to &quot;none&quot;.</div></font></div><div><font face=3D"arial, hel=
vetica, sans-serif"><br></font></div><div><font face=3D"arial, helvetica, s=
ans-serif">I&#39;ve created a topic on OpenVPN Support Forum and it was sug=
gested to post my issue to you and reference the thread.</font></div><div><=
font face=3D"arial, helvetica, sans-serif"><br></font></div><div><font face=
=3D"arial, helvetica, sans-serif">You can reference to the <a href=3D"https=
://forums.openvpn.net/viewtopic.php?f=3D6&amp;t=3D27173" target=3D"_blank">=
https://forums.openvpn.net/viewtopic.php?f=3D6&amp;t=3D27173</a>=C2=A0for c=
onfig files and additional information.</font><br clear=3D"all"></div><div>=
<br></div><div><div style=3D"font-family:arial,helvetica,sans-serif">Have y=
ou faced a similar issue before? Can you provide any hint how can I resolve=
 the issue? What did I missed?</div><div style=3D"font-family:arial,helveti=
ca,sans-serif">I would be very grateful for any help. Thank you in advance.=
</div><br></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"m_876958238=
2459335421m_-6453860842867551512gmail-m_3470655929018968434m_-5061142619719=
305404m_7016428550422907693m_-4766676076946984635m_-2729697033681776833gmai=
l_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><=
div><div dir=3D"ltr"><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;fon=
t-family:Calibri,sans-serif"><span style=3D"font-size:12pt;color:rgb(89,89,=
89)">Best regards,</span></p><p style=3D"margin:0in 0in 0.0001pt;font-famil=
y:Calibri,sans-serif"><font color=3D"#595959"><span style=3D"font-size:16px=
"><b>Rostyslav Maryliak</b></span></font></p><p style=3D"margin:0in 0in 0.0=
001pt;font-size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-si=
ze:12pt;color:rgb(89,89,89)">System Administrator</span></p><p style=3D"mar=
gin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><span s=
tyle=3D"font-size:12pt;color:rgb(89,89,89)">=C2=A0</span></p><p style=3D"ma=
rgin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><b><sp=
an style=3D"font-size:12pt;color:rgb(35,176,24)">iDeals=E2=84=A2 Solutions =
Group</span></b><span style=3D"font-size:12pt;color:rgb(89,89,89)">|=C2=A0<=
a href=3D"tel:%2B%2038%28093%29575-35-16" value=3D"+380935753516" style=3D"=
color:rgb(17,85,204)" target=3D"_blank">+ 38(073)437-72-51</a>=C2=A0| Skype=
: rostyslav.maryliak.ideals|</span><span style=3D"color:rgb(31,73,125)">=C2=
=A0</span><u><span style=3D"font-size:12pt;color:rgb(35,176,24)"><a href=3D=
"mailto:dmitry.zaporozhchenko@...2454..." style=3D"color:rgb(17,85,204)" ta=
rget=3D"_blank"><span style=3D"color:rgb(5,99,193)">rostyslav.maryliak@...1665...=
454...</span></a></span></u><u><span style=3D"color:rgb(35,176,24)">=C2=A0<=
/span></u><span style=3D"font-size:12pt;color:rgb(89,89,89)">|</span><span =
style=3D"font-size:12pt;color:rgb(35,176,24)">=C2=A0</span><span style=3D"f=
ont-size:12pt;color:rgb(35,176,24)" lang=3D"RU"><a href=3D"http://www.ideal=
scorp.com/" style=3D"color:rgb(17,85,204)" target=3D"_blank"><span style=3D=
"color:rgb(35,176,24)" lang=3D"EN-US">www.idealsvdr.com</span></a></span></=
p></div></div></div></div></div></div></div></div></div></div></div></div><=
/div></div>

<br>
<span style=3D"font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;fo=
nt-size:12pt"><font size=3D"2" face=3D"Trebuchet">CONFIDENTIALITY NOTE:
The information transmitted, including attachments,
is intended only for the person(s) or entity to which it is addressed and
may contain confidential and/or privileged material. Any review,
retransmission, dissemination or other use of, or taking of any action in
reliance upon this information by persons or entities other than the
intended recipient is prohibited. If you received this in error, please
contact the sender and destroy any copies of this information.</font></span=
>_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"m_8769582382459335421m_-6453860842867551512gmail-m_34706559290189=
68434m_-5061142619719305404m_7016428550422907693gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">=
<p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans=
-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89)">Best regards,</s=
pan></p><p style=3D"margin:0in 0in 0.0001pt;font-family:Calibri,sans-serif"=
><font color=3D"#595959"><span style=3D"font-size:16px"><b>Rostyslav Maryli=
ak</b></span></font></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;=
font-family:Calibri,sans-serif"><span style=3D"font-size:12pt;color:rgb(89,=
89,89)">System Administrator</span></p><p style=3D"margin:0in 0in 0.0001pt;=
font-size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:12p=
t;color:rgb(89,89,89)">=C2=A0</span></p><p style=3D"margin:0in 0in 0.0001pt=
;font-size:11pt;font-family:Calibri,sans-serif"><b><span style=3D"font-size=
:12pt;color:rgb(35,176,24)">iDeals=E2=84=A2 Solutions Group</span></b><span=
 style=3D"font-size:12pt;color:rgb(89,89,89)">|=C2=A0<a href=3D"tel:%2B%203=
8%28093%29575-35-16" value=3D"+380935753516" style=3D"color:rgb(17,85,204)"=
 target=3D"_blank">+ 38(073)437-72-51</a>=C2=A0| Skype: rostyslav.maryliak.=
ideals|</span><span style=3D"color:rgb(31,73,125)">=C2=A0</span><u><span st=
yle=3D"font-size:12pt;color:rgb(35,176,24)"><a href=3D"mailto:dmitry.zaporo=
zhchenko@...2454..." style=3D"color:rgb(17,85,204)" target=3D"_blank"><span=
 style=3D"color:rgb(5,99,193)">rostyslav.maryliak@...2454...</span></a></sp=
an></u><u><span style=3D"color:rgb(35,176,24)">=C2=A0</span></u><span style=
=3D"font-size:12pt;color:rgb(89,89,89)">|</span><span style=3D"font-size:12=
pt;color:rgb(35,176,24)">=C2=A0</span><span style=3D"font-size:12pt;color:r=
gb(35,176,24)" lang=3D"RU"><a href=3D"http://www.idealscorp.com/" style=3D"=
color:rgb(17,85,204)" target=3D"_blank"><span style=3D"color:rgb(35,176,24)=
" lang=3D"EN-US">www.idealsvdr.com</span></a></span></p></div></div></div><=
/div></div></div></div></div>

<br>
<span style=3D"font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;fo=
nt-size:12pt"><font size=3D"2" face=3D"Trebuchet">CONFIDENTIALITY NOTE:
The information transmitted, including attachments,
is intended only for the person(s) or entity to which it is addressed and
may contain confidential and/or privileged material. Any review,
retransmission, dissemination or other use of, or taking of any action in
reliance upon this information by persons or entities other than the
intended recipient is prohibited. If you received this in error, please
contact the sender and destroy any copies of this information.</font></span=
></blockquote></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"m_8769582382459335421m_-6453860842867551512gmail-m_34706559290189=
68434gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><p style=3D"margin:0in 0in 0.0001pt;font-siz=
e:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:12pt;color:=
rgb(89,89,89)">Best regards,</span></p><p style=3D"margin:0in 0in 0.0001pt;=
font-family:Calibri,sans-serif"><font color=3D"#595959"><span style=3D"font=
-size:16px"><b>Rostyslav Maryliak</b></span></font></p><p style=3D"margin:0=
in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><span style=
=3D"font-size:12pt;color:rgb(89,89,89)">System Administrator</span></p><p s=
tyle=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-ser=
if"><span style=3D"font-size:12pt;color:rgb(89,89,89)">=C2=A0</span></p><p =
style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-se=
rif"><b><span style=3D"font-size:12pt;color:rgb(35,176,24)">iDeals=E2=84=A2=
 Solutions Group</span></b><span style=3D"font-size:12pt;color:rgb(89,89,89=
)">|=C2=A0<a href=3D"tel:%2B%2038%28093%29575-35-16" value=3D"+380935753516=
" style=3D"color:rgb(17,85,204)" target=3D"_blank">+ 38(073)437-72-51</a>=
=C2=A0| Skype: rostyslav.maryliak.ideals|</span><span style=3D"color:rgb(31=
,73,125)">=C2=A0</span><u><span style=3D"font-size:12pt;color:rgb(35,176,24=
)"><a href=3D"mailto:dmitry.zaporozhchenko@...2454..." style=3D"color:rgb(1=
7,85,204)" target=3D"_blank"><span style=3D"color:rgb(5,99,193)">rostyslav.=
maryliak@...2454...</span></a></span></u><u><span style=3D"color:rgb(35,176=
,24)">=C2=A0</span></u><span style=3D"font-size:12pt;color:rgb(89,89,89)">|=
</span><span style=3D"font-size:12pt;color:rgb(35,176,24)">=C2=A0</span><sp=
an style=3D"font-size:12pt;color:rgb(35,176,24)" lang=3D"RU"><a href=3D"htt=
p://www.idealscorp.com/" style=3D"color:rgb(17,85,204)" target=3D"_blank"><=
span style=3D"color:rgb(35,176,24)" lang=3D"EN-US">www.idealsvdr.com</span>=
</a></span></p></div></div></div></div></div></div></div></div>

<br>
<span style=3D"font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;fo=
nt-size:12pt"><font size=3D"2" face=3D"Trebuchet">CONFIDENTIALITY NOTE:
The information transmitted, including attachments,
is intended only for the person(s) or entity to which it is addressed and
may contain confidential and/or privileged material. Any review,
retransmission, dissemination or other use of, or taking of any action in
reliance upon this information by persons or entities other than the
intended recipient is prohibited. If you received this in error, please
contact the sender and destroy any copies of this information.</font></span=
></blockquote></div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"m_8769582382459335421gmail_signature" data-smartmail=3D"gmail_sig=
nature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><=
div dir=3D"ltr"><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-fam=
ily:Calibri,sans-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89)">=
Best regards,</span></p><p style=3D"margin:0in 0in 0.0001pt;font-family:Cal=
ibri,sans-serif"><font color=3D"#595959"><span style=3D"font-size:16px"><b>=
Rostyslav Maryliak</b></span></font></p><p style=3D"margin:0in 0in 0.0001pt=
;font-size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:12=
pt;color:rgb(89,89,89)">System Administrator</span></p><p style=3D"margin:0=
in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><span style=
=3D"font-size:12pt;color:rgb(89,89,89)">=C2=A0</span></p><p style=3D"margin=
:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><b><span s=
tyle=3D"font-size:12pt;color:rgb(35,176,24)">iDeals=E2=84=A2 Solutions Grou=
p</span></b><span style=3D"font-size:12pt;color:rgb(89,89,89)">|=C2=A0<a hr=
ef=3D"tel:%2B%2038%28093%29575-35-16" value=3D"+380935753516" style=3D"colo=
r:rgb(17,85,204)" target=3D"_blank">+ 38(073)437-72-51</a>=C2=A0| Skype: ro=
styslav.maryliak.ideals|</span><span style=3D"color:rgb(31,73,125)">=C2=A0<=
/span><u><span style=3D"font-size:12pt;color:rgb(35,176,24)"><a href=3D"mai=
lto:dmitry.zaporozhchenko@...2454..." style=3D"color:rgb(17,85,204)" target=
=3D"_blank"><span style=3D"color:rgb(5,99,193)">rostyslav.maryliak@...2455...=
..</span></a></span></u><u><span style=3D"color:rgb(35,176,24)">=C2=A0</spa=
n></u><span style=3D"font-size:12pt;color:rgb(89,89,89)">|</span><span styl=
e=3D"font-size:12pt;color:rgb(35,176,24)">=C2=A0</span><span lang=3D"RU" st=
yle=3D"font-size:12pt;color:rgb(35,176,24)"><a href=3D"http://www.idealscor=
p.com/" style=3D"color:rgb(17,85,204)" target=3D"_blank"><span lang=3D"EN-U=
S" style=3D"color:rgb(35,176,24)">www.idealsvdr.com</span></a></span></p></=
div></div></div></div></div></div></div></div>

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
></blockquote></div>

--0000000000006d287b057766187e--

