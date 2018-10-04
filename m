MIME-Version: 1.0
References: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
 <CAFHpkQG10QOhGUb4R4VyPHwCNMfkVSQgCVgmypsBidsgNcsBaw@...278...>
 <CADkMwqQ+F-rLr3V5_BxjixbvnyOW6T+Y6tP---3PBaOcHkRBpA@...278...>
 <CAFHpkQExnJLdr1kNMkXoYxXjOdX4+M3KTcOfBp1ZQwmV3CkkXA@...278...>
 <CADkMwqS7AUDVz_tj0_6ewhJ7YgfJmph71dK-hCVhgOY=5+z3oA@...278...>
 <CAFHpkQHhy_w=0vSag_cqwQ=BiPStuVBzK0GOheMpjvpFFY_wAQ@...278...>
 <CADkMwqQCC_5=tWyX5HPQpPBVqwm8eoisYY=GtjLYcwx7KpN2Hg@...278...>
 <CAFHpkQHpaLNwfWvm3C6YsWE1wTRndXMJPa4QkBqcvMGTwk7=dw@...278...>
In-Reply-To: <CAFHpkQHpaLNwfWvm3C6YsWE1wTRndXMJPa4QkBqcvMGTwk7=dw@...278...>
From: Rostyslav Maryliak <rostyslav.maryliak@...2454...>
Date: Thu, 4 Oct 2018 15:57:31 +0300
Message-ID: <CADkMwqRaW_7VrDg+k0ok6ZNqaZo=FheJFz+ZW958E5HD4xX_cQ@...278...>
Content-Type: multipart/related; boundary="000000000000d1c103057766b432"
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
To: chipitsine@...277...
Cc: openvpn-devel@lists.sourceforge.net

--000000000000d1c103057766b432
Content-Type: multipart/alternative; boundary="000000000000d1c100057766b431"

--000000000000d1c100057766b431
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Ilya,

No, it is disabled.

[image: image.png]


On Thu, Oct 4, 2018 at 3:14 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> congestion can be setup using datacenter bridging
>
>
> https://docs.microsoft.com/en-us/windows-server/networking/technologies/d=
cb/dcb-manage
>
> actually, I thought it works in another direction (i.e. you specify it in
> windows and distribute to network switches).
> is DCB in use ?
>
> =D1=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 17:02, Rostyslav =
Maryliak <
> rostyslav.maryliak@...2454...>:
>
>> Dear Ilya,
>>
>> Sure, the results are the same for all our win2016 servers:
>>
>> PS C:\Users\Administrator> [environment]::OSVersion.Version
>>
>> Major     Minor     Build        Revision
>> -----        -----        -----          --------
>> 10          0            14393      0
>>
>> On Thu, Oct 4, 2018 at 2:45 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
>>
>>>
>>>
>>> =D1=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 15:50, Rostysla=
v Maryliak <
>>> rostyslav.maryliak@...2454...>:
>>>
>>>> Dear Illya,
>>>>
>>>> Sorry for misleading you. I want to set this parameter to "none"
>>>> globally.
>>>> I CAN change "Congestion Control Provider" setting for different
>>>> templates (i.e. Internet. Datacenter etc) in Powershell, but not to a
>>>> "None" value.
>>>>
>>>> In Powershell there is simply no option for this value:
>>>> PS C:\Users\Administrator> Set-NetTCPSetting -SettingName Datacenter
>>>> -CongestionProvider [ CTCP | CUBIC | DCTCP | Default | LEDBAT | NewRen=
o ]
>>>>
>>>> I've tried different values, but still no luck.
>>>>
>>>> In CMD there is such option, but it does not apply any changes for it:
>>>> C:\Users\Administrator> netsh int tcp set supplemental
>>>> template=3Ddatacenter congestionprovider=3D*none*
>>>> Ok.
>>>>
>>>> C:\Users\Administrator> netsh int tcp show supplemental
>>>> template=3Ddatacenter
>>>> TCP Supplemental Parameters
>>>> ----------------------------------------------
>>>> Minimum RTO (msec)                       : 20
>>>> Initial Congestion Window (MSS)     : 10
>>>> Congestion Control Provider             : *dctcp*
>>>> Enable Congestion Window Restart  : enabled
>>>> Delayed ACK timeout (msec)            : 10
>>>> Delayed ACK frequency                    : 2
>>>> Enable RACK                                    : disabled
>>>> Enable Tail Loss Probe                     : disabled
>>>>
>>>> Also, as I've mentioned in referred thread, such issue occurs on all
>>>> our win2016 servers, except one.
>>>>
>>>
>>> can you provide the output of
>>>
>>>
>>> [environment]::OSVersion.Version
>>>
>>> for that 2016 server ? (and for other servers)
>>>
>>>
>>>
>>>> This exception server has "Congestion Control Provider" setting set to
>>>> "none" somehow.
>>>> But still it is very strange for me that I have such slow network speed
>>>> via the tunnel for all win2016 servers "out of the box".
>>>>
>>>> Can you please check this from your side as well and confirm or
>>>> disprove the issue?
>>>>
>>>>
>>>> On Thu, Oct 4, 2018 at 12:10 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
>>>> wrote:
>>>>
>>>>> thank you for your investigation.
>>>>>
>>>>> congestion provider can be customized if you select "*Datacenter
>>>>> Custom"*
>>>>>
>>>>> =D1=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 13:58, Rostys=
lav Maryliak <
>>>>> rostyslav.maryliak@...2454...>:
>>>>>
>>>>>> Dear Ilya,
>>>>>>
>>>>>> I've checked "Get-NetTCPConnection" command output on both win2012r2
>>>>>> and win2016 servers.
>>>>>>
>>>>>> win2012r2 server works as OpenVPN server. Internal IP address -
>>>>>> 10.0.4.1. OpenVPN tunnel IP address - 172.16.144.1
>>>>>> win2016 server works as OpenVPN client. Internal IP address -
>>>>>> 10.0.44.1. OpenVPN tunnel IP address - 172.16.144.18
>>>>>>
>>>>>>
>>>>>> *From win2012r2 server:*
>>>>>>
>>>>>> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress
>>>>>> 10.0.44.1
>>>>>> LocalAddress                        LocalPort          RemoteAddress
>>>>>>                RemotePort             State                  Applied=
Setting
>>>>>> ------------                               ---------
>>>>>>  -------------                           ----------
>>>>>> -----                     --------------
>>>>>> 172.16.144.1                         56437               10.0.44.1
>>>>>>                         53005                      Established
>>>>>> *Datacenter*
>>>>>>
>>>>>> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress
>>>>>> 172.16.144.18
>>>>>> LocalAddress                       LocalPort           RemoteAddress
>>>>>>                RemotePort             State                  Applied=
Setting
>>>>>> ------------                               ---------
>>>>>>  -------------                           ----------
>>>>>> -----                     --------------
>>>>>> 10.0.4.1                                11616
>>>>>> 172.16.144.18                    56882                      Establis=
hed
>>>>>>     *Datacenter*
>>>>>> 10.0.4.1                                11616
>>>>>> 172.16.144.18                    56905                      Establis=
hed
>>>>>>     *Datacenter*
>>>>>>
>>>>>>
>>>>>> *From win2016 server:*
>>>>>>
>>>>>> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress
>>>>>> 10.0.4.1
>>>>>> LocalAddress                       LocalPort           RemoteAddress
>>>>>>                RemotePort             State                 AppliedS=
etting
>>>>>>          OwningProcess
>>>>>> ------------                               ---------
>>>>>>  -------------                           ----------
>>>>>>  -----                   --------------                 -------------
>>>>>> 172.16.144.18                      56905                10.0.4.1
>>>>>>                        11616                       Established      =
 *
>>>>>> Internet *                   13300
>>>>>> 172.16.144.18                      56882                10.0.4.1
>>>>>>                        11616                       Established      =
 *
>>>>>> Internet  *                  13300
>>>>>>
>>>>>>
>>>>>> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress
>>>>>> 172.16.144.1
>>>>>> LocalAddress                       LocalPort           RemoteAddress
>>>>>>                RemotePort             State                 AppliedS=
etting
>>>>>>          OwningProcess
>>>>>> ------------                               ---------
>>>>>>  -------------                           ----------
>>>>>> -----                    --------------                 -------------
>>>>>> 10.0.44.1                              53005
>>>>>> 172.16.144.1                      56437                      Establi=
shed
>>>>>>    *Internet*                      13300
>>>>>>
>>>>>>
>>>>>> I've changed the "AppliedSetting" value to Datacenter on win2016
>>>>>> server as well by running this commands and restarting the VPN:
>>>>>> New-NetTransportFilter -SettingName Datacenter -DestinationPrefix
>>>>>> 10.0.4.0/24
>>>>>> New-NetTransportFilter -SettingName Datacenter -DestinationPrefix
>>>>>> 172.16.144.0/24
>>>>>>
>>>>>> Now it shows Datacenter on both servers. But the network speed
>>>>>> remains the same. My changes do not affect the issue.
>>>>>> I've noticed that global TCP settings influence that, especially
>>>>>> "Chimney Offload", "Congestion Control Provider" and "ECN Capability=
":
>>>>>>
>>>>>> C:\Users\Administrator> netsh int tcp show global
>>>>>> Querying active state...
>>>>>>
>>>>>> TCP Global Parameters
>>>>>> ----------------------------------------------
>>>>>> Receive-Side Scaling State                   : enabled
>>>>>> Chimney Offload State                          : disabled
>>>>>> NetDMA State                                       : disabled
>>>>>> Direct Cache Access (DCA)                  : disabled
>>>>>> Receive Window Auto-Tuning Level     : normal
>>>>>> Add-On Congestion Control Provider   : default
>>>>>> ECN Capability                                      : enabled
>>>>>> RFC 1323 Timestamps                         : disabled
>>>>>> Initial RTO                                             : 3000
>>>>>> Receive Segment Coalescing State     : enabled
>>>>>> Non Sack Rtt Resiliency                       : disabled
>>>>>> Max SYN Retransmissions                   : 2
>>>>>> TCP Fast Open                                     : disabled
>>>>>>
>>>>>>
>>>>>> That is why I believe that the root cause of the issue lies in
>>>>>> "Congestion Control Provider" setting. But I am unable to change it
>>>>>>
>>>>>> On Thu, Oct 4, 2018 at 7:50 AM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
>>>>>> wrote:
>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> can you do some things and tell us your observation ?
>>>>>>>
>>>>>>> starting with win2012 so called network profiles were introduced
>>>>>>> (Internet / Intranet / Datacenter)
>>>>>>> those profiles are very different for tcp connection (if you observe
>>>>>>> degradation in case of udp, most probably that is not related)
>>>>>>>
>>>>>>>
>>>>>>> so, let's start
>>>>>>>
>>>>>>> start powershell (I assume you are familiar)
>>>>>>> call
>>>>>>>
>>>>>>> Get-NetTCPConnection
>>>>>>>
>>>>>>> pay attention to "AppliedSetting" column.
>>>>>>> what's there  ?
>>>>>>>
>>>>>>> we did observe strange things when win2012 classified some traffic
>>>>>>> as "Internet" and appropriate tcp settings were applied.
>>>>>>>
>>>>>>> is there some correlation in your case ?
>>>>>>>
>>>>>>> =D1=81=D1=80, 3 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 20:45, Rost=
yslav Maryliak <
>>>>>>> rostyslav.maryliak@...2454...>:
>>>>>>>
>>>>>>>> Dear OpenVPN developers,
>>>>>>>>
>>>>>>>> I've faced a very strange issue with slow outbound network speed
>>>>>>>> from Windows Server 2016 Standard server via the OpenVPN tunnel.
>>>>>>>> OpenVPN server is Windows Server 2012 R2, client is Windows Server
>>>>>>>> 2016. The inbound network speed for Windows Server 2016 is great.
>>>>>>>> But the outbound network speed is nearly 30-40 kbps. I've got the
>>>>>>>> same results using several tests: iperf testings, file download vi=
a SMB,
>>>>>>>> Web-based downloading (using HTTP) etc.
>>>>>>>>
>>>>>>>> The tunnels is getting up and it works greatly, but only in one
>>>>>>>> direction - from Windows Server 2012 R2 to Windows Server 2016.
>>>>>>>> I've been using such server-client configurations setup for several
>>>>>>>> years with Windows Server 2012 R2 servers and I've never faced suc=
h issue
>>>>>>>> before.
>>>>>>>> At first I thought that our ISP has some network limitations, but
>>>>>>>> it turned out that the same tests shows great network speed result=
s using
>>>>>>>> the public IP addresses in both directions.
>>>>>>>> The issue only occurs inside the VPN tunnel. I've spent 3 days
>>>>>>>> tryng to figure it out, but failed. I've installed all latest Wind=
ows
>>>>>>>> updates, reinstalled OpenVPN, tried to switch from UDP to TCP,
>>>>>>>> played with performance settings in configs (link-mtu, sndbuf,
>>>>>>>> rcvbuf etc) but still no luck. I've tested the same setup between =
two
>>>>>>>> Windows Server 2012 R2 servers and it works greatly in both direct=
ions.
>>>>>>>> Then I've tested it with another Windows Server 2016 Standard
>>>>>>>> server (different server and different ISP) and it showed the same=
 awful
>>>>>>>> results in outbound direction.
>>>>>>>> When I've set the same OpenVPN tunnel between two Windows Server
>>>>>>>> 2016 Standard servers I've got the same poor network speed in both
>>>>>>>> directions.
>>>>>>>>
>>>>>>>> I believe that the issue is somehow related only to the Windows
>>>>>>>> Server 2016 version and I am more than confident that it depends on
>>>>>>>> server's TCP stack settings.
>>>>>>>> I've noticed that Windows Server 2016 has a congestion control
>>>>>>>> provider setting set to "default", while previous versions of Wind=
ows has
>>>>>>>> this setting set to "none".
>>>>>>>>
>>>>>>>> I've created a topic on OpenVPN Support Forum and it was suggested
>>>>>>>> to post my issue to you and reference the thread.
>>>>>>>>
>>>>>>>> You can reference to the
>>>>>>>> https://forums.openvpn.net/viewtopic.php?f=3D6&t=3D27173 for config
>>>>>>>> files and additional information.
>>>>>>>>
>>>>>>>> Have you faced a similar issue before? Can you provide any hint how
>>>>>>>> can I resolve the issue? What did I missed?
>>>>>>>> I would be very grateful for any help. Thank you in advance.
>>>>>>>>
>>>>>>>>
>>>>>>>> --
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>>
>>>>>>>> *Rostyslav Maryliak*
>>>>>>>>
>>>>>>>> System Administrator
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> *iDeals=E2=84=A2 Solutions Group*| + 38(073)437-72-51
>>>>>>>> <%2B%2038%28093%29575-35-16> | Skype: rostyslav.maryliak.ideals| *=
rostyslav.maryliak@...2454...
>>>>>>>> <dmitry.zaporozhchenko@...2454...>* | www.idealsvdr.com
>>>>>>>> <http://www.idealscorp.com/>
>>>>>>>>
>>>>>>>> CONFIDENTIALITY NOTE: The information transmitted, including
>>>>>>>> attachments, is intended only for the person(s) or entity to which=
 it is
>>>>>>>> addressed and may contain confidential and/or privileged material.=
 Any
>>>>>>>> review, retransmission, dissemination or other use of, or taking o=
f any
>>>>>>>> action in reliance upon this information by persons or entities ot=
her than
>>>>>>>> the intended recipient is prohibited. If you received this in erro=
r, please
>>>>>>>> contact the sender and destroy any copies of this information.
>>>>>>>> _______________________________________________
>>>>>>>> Openvpn-devel mailing list
>>>>>>>> Openvpn-devel@lists.sourceforge.net
>>>>>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>> --
>>>>>>
>>>>>> Best regards,
>>>>>>
>>>>>> *Rostyslav Maryliak*
>>>>>>
>>>>>> System Administrator
>>>>>>
>>>>>>
>>>>>>
>>>>>> *iDeals=E2=84=A2 Solutions Group*| + 38(073)437-72-51
>>>>>> <%2B%2038%28093%29575-35-16> | Skype: rostyslav.maryliak.ideals| *ro=
styslav.maryliak@...2454...
>>>>>> <dmitry.zaporozhchenko@...2454...>* | www.idealsvdr.com
>>>>>> <http://www.idealscorp.com/>
>>>>>>
>>>>>> CONFIDENTIALITY NOTE: The information transmitted, including
>>>>>> attachments, is intended only for the person(s) or entity to which i=
t is
>>>>>> addressed and may contain confidential and/or privileged material. A=
ny
>>>>>> review, retransmission, dissemination or other use of, or taking of =
any
>>>>>> action in reliance upon this information by persons or entities othe=
r than
>>>>>> the intended recipient is prohibited. If you received this in error,=
 please
>>>>>> contact the sender and destroy any copies of this information.
>>>>>
>>>>>
>>>>
>>>> --
>>>>
>>>> Best regards,
>>>>
>>>> *Rostyslav Maryliak*
>>>>
>>>> System Administrator
>>>>
>>>>
>>>>
>>>> *iDeals=E2=84=A2 Solutions Group*| + 38(073)437-72-51
>>>> <%2B%2038%28093%29575-35-16> | Skype: rostyslav.maryliak.ideals| *rost=
yslav.maryliak@...2454...
>>>> <dmitry.zaporozhchenko@...2454...>* | www.idealsvdr.com
>>>> <http://www.idealscorp.com/>
>>>>
>>>> CONFIDENTIALITY NOTE: The information transmitted, including
>>>> attachments, is intended only for the person(s) or entity to which it =
is
>>>> addressed and may contain confidential and/or privileged material. Any
>>>> review, retransmission, dissemination or other use of, or taking of any
>>>> action in reliance upon this information by persons or entities other =
than
>>>> the intended recipient is prohibited. If you received this in error, p=
lease
>>>> contact the sender and destroy any copies of this information.
>>>
>>>
>>
>> --
>>
>> Best regards,
>>
>> *Rostyslav Maryliak*
>>
>> System Administrator
>>
>>
>>
>> *iDeals=E2=84=A2 Solutions Group*| + 38(073)437-72-51
>> <%2B%2038%28093%29575-35-16> | Skype: rostyslav.maryliak.ideals| *rostys=
lav.maryliak@...2454...
>> <dmitry.zaporozhchenko@...2454...>* | www.idealsvdr.com
>> <http://www.idealscorp.com/>
>>
>> CONFIDENTIALITY NOTE: The information transmitted, including attachments,
>> is intended only for the person(s) or entity to which it is addressed and
>> may contain confidential and/or privileged material. Any review,
>> retransmission, dissemination or other use of, or taking of any action in
>> reliance upon this information by persons or entities other than the
>> intended recipient is prohibited. If you received this in error, please
>> contact the sender and destroy any copies of this information.
>
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

--000000000000d1c100057766b431
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Dear Ilya,</div><div class=3D"gmail_default" style=3D"f=
ont-family:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_defaul=
t" style=3D"font-family:arial,helvetica,sans-serif">No, it is disabled.</di=
v><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-se=
rif"><br></div><div class=3D"gmail_default" style=3D"font-family:arial,helv=
etica,sans-serif"><div><img src=3D"cid:ii_jmul2sh60" alt=3D"image.png" widt=
h=3D"400" height=3D"526"><br></div><div><br></div></div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr">On Thu, Oct 4, 2018 at 3:14 PM =D0=98=D0=
=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"m=
ailto:chipitsine@...277...">chipitsine@...277...</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div>congest=
ion can be setup using datacenter bridging <br></div><div><br></div><div><a=
 href=3D"https://docs.microsoft.com/en-us/windows-server/networking/technol=
ogies/dcb/dcb-manage" target=3D"_blank">https://docs.microsoft.com/en-us/wi=
ndows-server/networking/technologies/dcb/dcb-manage</a></div><div><br></div=
><div>actually, I thought it works in another direction (i.e. you specify i=
t in windows and distribute to network switches).</div><div>is DCB in use ?=
<br></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">=D1=
=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 17:02, Rostyslav Maryl=
iak &lt;<a href=3D"mailto:rostyslav.maryliak@...2454..." target=3D"_blank">=
rostyslav.maryliak@...2454...</a>&gt;:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D=
"font-family:arial,helvetica,sans-serif">Dear Ilya,</div><div class=3D"gmai=
l_default" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div =
class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Su=
re, the results are the same for all our win2016 servers:</div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></d=
iv><div class=3D"gmail_default"><div class=3D"gmail_default"><font face=3D"=
arial, helvetica, sans-serif">PS C:\Users\Administrator&gt; [environment]::=
OSVersion.Version</font></div><div class=3D"gmail_default"><font face=3D"ar=
ial, helvetica, sans-serif"><br></font></div><div class=3D"gmail_default"><=
font face=3D"arial, helvetica, sans-serif">Major=C2=A0 =C2=A0 =C2=A0Minor=
=C2=A0 =C2=A0 =C2=A0Build=C2=A0 =C2=A0 =C2=A0 =C2=A0 Revision</font></div><=
div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">---=
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 -----=C2=A0 =C2=A0 =C2=A0 =C2=A0 -----=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 --------</font></div><div class=3D"gmail_defaul=
t"><font face=3D"arial, helvetica, sans-serif">10=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 14393=C2=A0 =C2=A0 =
=C2=A0 0</font></div></div></div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr">On Thu, Oct 4, 2018 at 2:45 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=
=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...1664...=
7..." target=3D"_blank">chipitsine@...277...</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr">=D1=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 201=
8 =D0=B3. =D0=B2 15:50, Rostyslav Maryliak &lt;<a href=3D"mailto:rostyslav.=
maryliak@...2454..." target=3D"_blank">rostyslav.maryliak@...2454...</a>&gt=
;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><di=
v style=3D"font-family:arial,helvetica,sans-serif">Dear Illya,</div><div st=
yle=3D"font-family:arial,helvetica,sans-serif"><br></div><div style=3D"font=
-family:arial,helvetica,sans-serif">Sorry for misleading you. I want to set=
 this parameter to &quot;none&quot; globally.</div><div style=3D"font-famil=
y:arial,helvetica,sans-serif">I CAN change=C2=A0<span style=3D"font-family:=
Arial,Helvetica,sans-serif">&quot;Congestion Control Provider&quot; setting=
 for different templates (i.e. Internet. Datacenter etc) in Powershell, but=
 not to a &quot;None&quot; value.</span></div><div style=3D"font-family:ari=
al,helvetica,sans-serif"><span style=3D"font-family:Arial,Helvetica,sans-se=
rif"><br></span></div><div style=3D"font-family:arial,helvetica,sans-serif"=
><span style=3D"font-family:Arial,Helvetica,sans-serif">In Powershell there=
 is simply no option for this value:</span></div><div style=3D"font-family:=
arial,helvetica,sans-serif"><span style=3D"font-family:Arial,Helvetica,sans=
-serif">PS C:\Users\Administrator&gt; Set-NetTCPSetting -SettingName Datace=
nter -CongestionProvider [ CTCP | CUBIC | DCTCP | Default | LEDBAT | NewRen=
o ]</span><br></div><div><br></div><div>I&#39;ve tried different values, bu=
t still no luck.</div><div><br></div><div>In CMD there is such option, but =
it does not apply any changes for it:</div><div>C:\Users\Administrator&gt; =
netsh int tcp set supplemental template=3Ddatacenter congestionprovider=3D<=
b>none</b><br></div><div>Ok.<br></div><div><br></div><div><div>C:\Users\Adm=
inistrator&gt; netsh int tcp show supplemental template=3Ddatacenter</div><=
div>TCP Supplemental Parameters</div><div>---------------------------------=
-------------</div><div>Minimum RTO (msec)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 20</div><div>Initial =
Congestion Window (MSS)=C2=A0 =C2=A0 =C2=A0: 10</div><div>Congestion Contro=
l Provider=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:=C2=A0<b>dctcp</=
b></div><div>Enable Congestion Window Restart=C2=A0 : enabled</div><div>Del=
ayed ACK timeout (msec)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 10</div>=
<div>Delayed ACK frequency=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 : 2</div><div>Enable RACK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 : disabled</div><div>Enable Tail Loss Probe=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: disa=
bled</div><div><br></div><div>Also, as I&#39;ve mentioned in referred threa=
d, such issue occurs on all our win2016 servers, except one.</div></div></d=
iv></div></div></div></div></blockquote><div><br></div><div>can you provide=
 the output of</div><div><br></div><div><br></div><div>[environment]::OSVer=
sion.Version</div><div><br></div><div>for that 2016 server ? (and for other=
 servers)<br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr=
"><div dir=3D"ltr"><div dir=3D"ltr"><div><div>This exception server has &qu=
ot;Congestion Control Provider&quot; setting set to &quot;none&quot; someho=
w.</div><div>But still it is very strange for me that I have such slow netw=
ork speed via the tunnel for all win2016 servers &quot;out of the box&quot;=
.</div><div><br></div><div>Can you please check this from your side as well=
 and confirm or disprove the issue?</div></div><div><br></div></div></div><=
/div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Oc=
t 4, 2018 at 12:10 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blan=
k">chipitsine@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div>thank you for your investigati=
on.</div><div><br></div><div>congestion provider can be customized if you s=
elect &quot;<span class=3D"m_-175218343308955284m_8769582382459335421m_-645=
3860842867551512gmail-m_3470655929018968434m_-5061142619719305404gmail-st">=
<i>Datacenter Custom&quot;</i></span></div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr">=D1=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=
=B2 13:58, Rostyslav Maryliak &lt;<a href=3D"mailto:rostyslav.maryliak@...1665...=
454..." target=3D"_blank">rostyslav.maryliak@...2454...</a>&gt;:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"f=
ont-family:arial,helvetica,sans-serif">Dear Ilya,</div><div style=3D"font-f=
amily:arial,helvetica,sans-serif"><br></div><div style=3D"font-family:arial=
,helvetica,sans-serif">I&#39;ve checked &quot;<span style=3D"font-family:Ar=
ial,Helvetica,sans-serif">Get-NetTCPConnection</span>&quot; command output =
on both win2012r2 and win2016 servers.</div><div style=3D"font-family:arial=
,helvetica,sans-serif"><br></div><div style=3D"font-family:arial,helvetica,=
sans-serif">win2012r2 server works as OpenVPN server. Internal IP address -=
 10.0.4.1. OpenVPN tunnel IP address - 172.16.144.1</div><div style=3D"font=
-family:arial,helvetica,sans-serif">win2016 server works as OpenVPN client.=
 Internal IP address - 10.0.44.1. OpenVPN tunnel IP address - 172.16.144.18=
</div><div style=3D"font-family:arial,helvetica,sans-serif"><br></div><div =
style=3D"font-family:arial,helvetica,sans-serif"><br></div><div style=3D"fo=
nt-family:arial,helvetica,sans-serif"><b>From win2012r2 server:</b></div><d=
iv style=3D"font-family:arial,helvetica,sans-serif"><br></div><div><font fa=
ce=3D"arial, helvetica, sans-serif">PS C:\Users\Administrator&gt; Get-NetTC=
PConnection -RemoteAddress 10.0.44.1</font></div><div><span style=3D"font-f=
amily:arial,helvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LocalPort=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 RemoteAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AppliedSetting</span><br></div><div><font face=3D"arial, helvetica, san=
s-serif">------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---------=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0----------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 -----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0--------------</font></div><div><font face=3D"arial, h=
elvetica, sans-serif">172.16.144.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A056437=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A010.0.44.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 53005=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 E=
stablished=C2=A0 =C2=A0 =C2=A0 =C2=A0 <b>Datacenter</b></font></div><div><f=
ont face=3D"arial, helvetica, sans-serif"><br></font></div><div><span style=
=3D"font-family:arial,helvetica,sans-serif">PS C:\Users\Administrator&gt; G=
et-NetTCPConnection -RemoteAddress 172.16.144.18</span><br></div><div><span=
 style=3D"font-family:arial,helvetica,sans-serif">LocalAddress=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Local=
Port=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemoteAddress=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 AppliedSetting</span><br></div><div><font face=3D"aria=
l, helvetica, sans-serif">------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0---------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--------=
-----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0----------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--------------</font></div><div><font=
 face=3D"arial, helvetica, sans-serif">10.0.4.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 11616=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 172=
.16.144.18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 56882=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Established=C2=A0 =C2=A0 =C2=A0 =C2=A0 <b>Datacenter</b></fon=
t></div><div><font face=3D"arial, helvetica, sans-serif">10.0.4.1=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 11616=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 172.16.144.18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 56905=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Established=C2=A0 =C2=A0 =C2=A0 =C2=A0 <b>Data=
center</b></font><span style=3D"font-family:arial,helvetica,sans-serif">=C2=
=A0=C2=A0<br></span></div><div><span style=3D"font-family:arial,helvetica,s=
ans-serif"><br></span></div><div><span style=3D"font-family:arial,helvetica=
,sans-serif"><br></span></div><div><b style=3D"font-family:arial,helvetica,=
sans-serif">From win2016 server:</b>=C2=A0=C2=A0<span style=3D"font-family:=
arial,helvetica,sans-serif"><br></span></div><div><br></div><div><div><font=
 face=3D"arial, helvetica, sans-serif">PS C:\Users\Administrator&gt; Get-Ne=
tTCPConnection -RemoteAddress 10.0.4.1</font></div><div><span style=3D"font=
-family:arial,helvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LocalPort=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemoteAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AppliedSetting=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OwningProcess<=
/span><br></div><div><font face=3D"arial, helvetica, sans-serif">----------=
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0-------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0----------=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--=
---=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---=
-----------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--=
-----------</font></div><div><font face=3D"arial, helvetica, sans-serif">17=
2.16.144.18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 56905=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
10.0.4.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A011616=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Established=C2=A0 =C2=
=A0 =C2=A0 =C2=A0<b> Internet=C2=A0</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A013300</font></div><div><font face=3D"aria=
l, helvetica, sans-serif">172.16.144.18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 56882=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 10.0.4.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A011616=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Established=C2=A0 =C2=A0 =C2=A0 =C2=A0<b> Internet=C2=A0 </b>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 13300</font></div><=
div><font face=3D"arial, helvetica, sans-serif"><br></font></div><div><font=
 face=3D"arial, helvetica, sans-serif"><br></font></div><div><font face=3D"=
arial, helvetica, sans-serif">PS C:\Users\Administrator&gt; Get-NetTCPConne=
ction -RemoteAddress 172.16.144.1</font></div><div><span style=3D"font-fami=
ly:arial,helvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LocalPort=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0RemoteAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0AppliedSetting=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OwningProcess</sp=
an><br></div><div><font face=3D"arial, helvetica, sans-serif">------------=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0-------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0----------=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -----=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --------=
------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------=
------</font></div><div><font face=3D"arial, helvetica, sans-serif">10.0.44=
.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
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
</div><br></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"m_-17521834=
3308955284m_8769582382459335421m_-6453860842867551512gmail-m_34706559290189=
68434m_-5061142619719305404m_7016428550422907693m_-4766676076946984635m_-27=
29697033681776833gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><d=
iv><div dir=3D"ltr"><div><div dir=3D"ltr"><p style=3D"margin:0in 0in 0.0001=
pt;font-size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:=
12pt;color:rgb(89,89,89)">Best regards,</span></p><p style=3D"margin:0in 0i=
n 0.0001pt;font-family:Calibri,sans-serif"><font color=3D"#595959"><span st=
yle=3D"font-size:16px"><b>Rostyslav Maryliak</b></span></font></p><p style=
=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">=
<span style=3D"font-size:12pt;color:rgb(89,89,89)">System Administrator</sp=
an></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calib=
ri,sans-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89)">=C2=A0</s=
pan></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif"><b><span style=3D"font-size:12pt;color:rgb(35,176,24)">iDea=
ls=E2=84=A2 Solutions Group</span></b><span style=3D"font-size:12pt;color:r=
gb(89,89,89)">|=C2=A0<a href=3D"tel:%2B%2038%28093%29575-35-16" value=3D"+3=
80935753516" style=3D"color:rgb(17,85,204)" target=3D"_blank">+ 38(073)437-=
72-51</a>=C2=A0| Skype: rostyslav.maryliak.ideals|</span><span style=3D"col=
or:rgb(31,73,125)">=C2=A0</span><u><span style=3D"font-size:12pt;color:rgb(=
35,176,24)"><a href=3D"mailto:dmitry.zaporozhchenko@...2454..." style=3D"co=
lor:rgb(17,85,204)" target=3D"_blank"><span style=3D"color:rgb(5,99,193)">r=
ostyslav.maryliak@...2454...</span></a></span></u><u><span style=3D"color:r=
gb(35,176,24)">=C2=A0</span></u><span style=3D"font-size:12pt;color:rgb(89,=
89,89)">|</span><span style=3D"font-size:12pt;color:rgb(35,176,24)">=C2=A0<=
/span><span style=3D"font-size:12pt;color:rgb(35,176,24)" lang=3D"RU"><a hr=
ef=3D"http://www.idealscorp.com/" style=3D"color:rgb(17,85,204)" target=3D"=
_blank"><span style=3D"color:rgb(35,176,24)" lang=3D"EN-US">www.idealsvdr.c=
om</span></a></span></p></div></div></div></div></div></div></div></div></d=
iv></div></div></div></div></div>

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
 class=3D"m_-175218343308955284m_8769582382459335421m_-6453860842867551512g=
mail-m_3470655929018968434m_-5061142619719305404m_7016428550422907693gmail_=
signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><di=
v><div dir=3D"ltr"><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-=
family:Calibri,sans-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89=
)">Best regards,</span></p><p style=3D"margin:0in 0in 0.0001pt;font-family:=
Calibri,sans-serif"><font color=3D"#595959"><span style=3D"font-size:16px">=
<b>Rostyslav Maryliak</b></span></font></p><p style=3D"margin:0in 0in 0.000=
1pt;font-size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size=
:12pt;color:rgb(89,89,89)">System Administrator</span></p><p style=3D"margi=
n:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><span sty=
le=3D"font-size:12pt;color:rgb(89,89,89)">=C2=A0</span></p><p style=3D"marg=
in:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><b><span=
 style=3D"font-size:12pt;color:rgb(35,176,24)">iDeals=E2=84=A2 Solutions Gr=
oup</span></b><span style=3D"font-size:12pt;color:rgb(89,89,89)">|=C2=A0<a =
href=3D"tel:%2B%2038%28093%29575-35-16" value=3D"+380935753516" style=3D"co=
lor:rgb(17,85,204)" target=3D"_blank">+ 38(073)437-72-51</a>=C2=A0| Skype: =
rostyslav.maryliak.ideals|</span><span style=3D"color:rgb(31,73,125)">=C2=
=A0</span><u><span style=3D"font-size:12pt;color:rgb(35,176,24)"><a href=3D=
"mailto:dmitry.zaporozhchenko@...2454..." style=3D"color:rgb(17,85,204)" ta=
rget=3D"_blank"><span style=3D"color:rgb(5,99,193)">rostyslav.maryliak@...1665...=
454...</span></a></span></u><u><span style=3D"color:rgb(35,176,24)">=C2=A0<=
/span></u><span style=3D"font-size:12pt;color:rgb(89,89,89)">|</span><span =
style=3D"font-size:12pt;color:rgb(35,176,24)">=C2=A0</span><span style=3D"f=
ont-size:12pt;color:rgb(35,176,24)" lang=3D"RU"><a href=3D"http://www.ideal=
scorp.com/" style=3D"color:rgb(17,85,204)" target=3D"_blank"><span style=3D=
"color:rgb(35,176,24)" lang=3D"EN-US">www.idealsvdr.com</span></a></span></=
p></div></div></div></div></div></div></div></div>

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
 class=3D"m_-175218343308955284m_8769582382459335421m_-6453860842867551512g=
mail-m_3470655929018968434gmail_signature"><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><p style=3D"margin:0in=
 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><span style=3D=
"font-size:12pt;color:rgb(89,89,89)">Best regards,</span></p><p style=3D"ma=
rgin:0in 0in 0.0001pt;font-family:Calibri,sans-serif"><font color=3D"#59595=
9"><span style=3D"font-size:16px"><b>Rostyslav Maryliak</b></span></font></=
p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sa=
ns-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89)">System Adminis=
trator</span></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-fa=
mily:Calibri,sans-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89)"=
>=C2=A0</span></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif"><b><span style=3D"font-size:12pt;color:rgb(35,176=
,24)">iDeals=E2=84=A2 Solutions Group</span></b><span style=3D"font-size:12=
pt;color:rgb(89,89,89)">|=C2=A0<a href=3D"tel:%2B%2038%28093%29575-35-16" v=
alue=3D"+380935753516" style=3D"color:rgb(17,85,204)" target=3D"_blank">+ 3=
8(073)437-72-51</a>=C2=A0| Skype: rostyslav.maryliak.ideals|</span><span st=
yle=3D"color:rgb(31,73,125)">=C2=A0</span><u><span style=3D"font-size:12pt;=
color:rgb(35,176,24)"><a href=3D"mailto:dmitry.zaporozhchenko@...2454..." s=
tyle=3D"color:rgb(17,85,204)" target=3D"_blank"><span style=3D"color:rgb(5,=
99,193)">rostyslav.maryliak@...2454...</span></a></span></u><u><span style=
=3D"color:rgb(35,176,24)">=C2=A0</span></u><span style=3D"font-size:12pt;co=
lor:rgb(89,89,89)">|</span><span style=3D"font-size:12pt;color:rgb(35,176,2=
4)">=C2=A0</span><span style=3D"font-size:12pt;color:rgb(35,176,24)" lang=
=3D"RU"><a href=3D"http://www.idealscorp.com/" style=3D"color:rgb(17,85,204=
)" target=3D"_blank"><span style=3D"color:rgb(35,176,24)" lang=3D"EN-US">ww=
w.idealsvdr.com</span></a></span></p></div></div></div></div></div></div></=
div></div>

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
 class=3D"m_-175218343308955284m_8769582382459335421gmail_signature" data-s=
martmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><p style=3D"margin:0in 0in 0.0001pt;fo=
nt-size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:12pt;=
color:rgb(89,89,89)">Best regards,</span></p><p style=3D"margin:0in 0in 0.0=
001pt;font-family:Calibri,sans-serif"><font color=3D"#595959"><span style=
=3D"font-size:16px"><b>Rostyslav Maryliak</b></span></font></p><p style=3D"=
margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><spa=
n style=3D"font-size:12pt;color:rgb(89,89,89)">System Administrator</span><=
/p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,s=
ans-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89)">=C2=A0</span>=
</p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,=
sans-serif"><b><span style=3D"font-size:12pt;color:rgb(35,176,24)">iDeals=
=E2=84=A2 Solutions Group</span></b><span style=3D"font-size:12pt;color:rgb=
(89,89,89)">|=C2=A0<a href=3D"tel:%2B%2038%28093%29575-35-16" value=3D"+380=
935753516" style=3D"color:rgb(17,85,204)" target=3D"_blank">+ 38(073)437-72=
-51</a>=C2=A0| Skype: rostyslav.maryliak.ideals|</span><span style=3D"color=
:rgb(31,73,125)">=C2=A0</span><u><span style=3D"font-size:12pt;color:rgb(35=
,176,24)"><a href=3D"mailto:dmitry.zaporozhchenko@...2454..." style=3D"colo=
r:rgb(17,85,204)" target=3D"_blank"><span style=3D"color:rgb(5,99,193)">ros=
tyslav.maryliak@...2454...</span></a></span></u><u><span style=3D"color:rgb=
(35,176,24)">=C2=A0</span></u><span style=3D"font-size:12pt;color:rgb(89,89=
,89)">|</span><span style=3D"font-size:12pt;color:rgb(35,176,24)">=C2=A0</s=
pan><span lang=3D"RU" style=3D"font-size:12pt;color:rgb(35,176,24)"><a href=
=3D"http://www.idealscorp.com/" style=3D"color:rgb(17,85,204)" target=3D"_b=
lank"><span lang=3D"EN-US" style=3D"color:rgb(35,176,24)">www.idealsvdr.com=
</span></a></span></p></div></div></div></div></div></div></div></div>

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

--000000000000d1c100057766b431--

--000000000000d1c103057766b432
Content-Type: image/png; name="image.png"
Content-Disposition: inline; filename="image.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_jmul2sh60>
X-Attachment-Id: ii_jmul2sh60

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
--000000000000d1c103057766b432--

