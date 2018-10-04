MIME-Version: 1.0
References: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
 <CAFHpkQG10QOhGUb4R4VyPHwCNMfkVSQgCVgmypsBidsgNcsBaw@...278...>
 <CADkMwqQ+F-rLr3V5_BxjixbvnyOW6T+Y6tP---3PBaOcHkRBpA@...278...>
In-Reply-To: <CADkMwqQ+F-rLr3V5_BxjixbvnyOW6T+Y6tP---3PBaOcHkRBpA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 4 Oct 2018 14:09:51 +0500
Message-ID: <CAFHpkQExnJLdr1kNMkXoYxXjOdX4+M3KTcOfBp1ZQwmV3CkkXA@...278...>
Content-Type: multipart/alternative; boundary="00000000000026e4b505776385c4"
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

--00000000000026e4b505776385c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

thank you for your investigation.

congestion provider can be customized if you select "*Datacenter Custom"*

=D1=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 13:58, Rostyslav Ma=
ryliak <
rostyslav.maryliak@...2454...>:

> Dear Ilya,
>
> I've checked "Get-NetTCPConnection" command output on both win2012r2 and
> win2016 servers.
>
> win2012r2 server works as OpenVPN server. Internal IP address - 10.0.4.1.
> OpenVPN tunnel IP address - 172.16.144.1
> win2016 server works as OpenVPN client. Internal IP address - 10.0.44.1.
> OpenVPN tunnel IP address - 172.16.144.18
>
>
> *From win2012r2 server:*
>
> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress 10.0.44.1
> LocalAddress                        LocalPort          RemoteAddress
>            RemotePort             State                  AppliedSetting
> ------------                               ---------
>  -------------                           ----------
> -----                     --------------
> 172.16.144.1                         56437               10.0.44.1
>                     53005                      Established
> *Datacenter*
>
> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress
> 172.16.144.18
> LocalAddress                       LocalPort           RemoteAddress
>            RemotePort             State                  AppliedSetting
> ------------                               ---------
>  -------------                           ----------
> -----                     --------------
> 10.0.4.1                                11616
> 172.16.144.18                    56882                      Established
>     *Datacenter*
> 10.0.4.1                                11616
> 172.16.144.18                    56905                      Established
>     *Datacenter*
>
>
> *From win2016 server:*
>
> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress 10.0.4.1
> LocalAddress                       LocalPort           RemoteAddress
>            RemotePort             State                 AppliedSetting
>      OwningProcess
> ------------                               ---------
>  -------------                           ----------
>  -----                   --------------                 -------------
> 172.16.144.18                      56905                10.0.4.1
>                    11616                       Established       *
> Internet *                   13300
> 172.16.144.18                      56882                10.0.4.1
>                    11616                       Established       *
> Internet  *                  13300
>
>
> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress 172.16.144=
.1
> LocalAddress                       LocalPort           RemoteAddress
>            RemotePort             State                 AppliedSetting
>      OwningProcess
> ------------                               ---------
>  -------------                           ----------
> -----                    --------------                 -------------
> 10.0.44.1                              53005                172.16.144.1
>                     56437                      Established
> *Internet*                      13300
>
>
> I've changed the "AppliedSetting" value to Datacenter on win2016 server as
> well by running this commands and restarting the VPN:
> New-NetTransportFilter -SettingName Datacenter -DestinationPrefix
> 10.0.4.0/24
> New-NetTransportFilter -SettingName Datacenter -DestinationPrefix
> 172.16.144.0/24
>
> Now it shows Datacenter on both servers. But the network speed remains the
> same. My changes do not affect the issue.
> I've noticed that global TCP settings influence that, especially "Chimney
> Offload", "Congestion Control Provider" and "ECN Capability":
>
> C:\Users\Administrator> netsh int tcp show global
> Querying active state...
>
> TCP Global Parameters
> ----------------------------------------------
> Receive-Side Scaling State                   : enabled
> Chimney Offload State                          : disabled
> NetDMA State                                       : disabled
> Direct Cache Access (DCA)                  : disabled
> Receive Window Auto-Tuning Level     : normal
> Add-On Congestion Control Provider   : default
> ECN Capability                                      : enabled
> RFC 1323 Timestamps                         : disabled
> Initial RTO                                             : 3000
> Receive Segment Coalescing State     : enabled
> Non Sack Rtt Resiliency                       : disabled
> Max SYN Retransmissions                   : 2
> TCP Fast Open                                     : disabled
>
>
> That is why I believe that the root cause of the issue lies in "Congestion
> Control Provider" setting. But I am unable to change it
>
> On Thu, Oct 4, 2018 at 7:50 AM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
>
>> Hello,
>>
>> can you do some things and tell us your observation ?
>>
>> starting with win2012 so called network profiles were introduced
>> (Internet / Intranet / Datacenter)
>> those profiles are very different for tcp connection (if you observe
>> degradation in case of udp, most probably that is not related)
>>
>>
>> so, let's start
>>
>> start powershell (I assume you are familiar)
>> call
>>
>> Get-NetTCPConnection
>>
>> pay attention to "AppliedSetting" column.
>> what's there  ?
>>
>> we did observe strange things when win2012 classified some traffic as
>> "Internet" and appropriate tcp settings were applied.
>>
>> is there some correlation in your case ?
>>
>> =D1=81=D1=80, 3 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 20:45, Rostyslav=
 Maryliak <
>> rostyslav.maryliak@...2454...>:
>>
>>> Dear OpenVPN developers,
>>>
>>> I've faced a very strange issue with slow outbound network speed from
>>> Windows Server 2016 Standard server via the OpenVPN tunnel.
>>> OpenVPN server is Windows Server 2012 R2, client is Windows Server 2016.
>>> The inbound network speed for Windows Server 2016 is great.
>>> But the outbound network speed is nearly 30-40 kbps. I've got the same
>>> results using several tests: iperf testings, file download via SMB,
>>> Web-based downloading (using HTTP) etc.
>>>
>>> The tunnels is getting up and it works greatly, but only in one
>>> direction - from Windows Server 2012 R2 to Windows Server 2016.
>>> I've been using such server-client configurations setup for several
>>> years with Windows Server 2012 R2 servers and I've never faced such iss=
ue
>>> before.
>>> At first I thought that our ISP has some network limitations, but it
>>> turned out that the same tests shows great network speed results using =
the
>>> public IP addresses in both directions.
>>> The issue only occurs inside the VPN tunnel. I've spent 3 days tryng to
>>> figure it out, but failed. I've installed all latest Windows updates,
>>> reinstalled OpenVPN, tried to switch from UDP to TCP,
>>> played with performance settings in configs (link-mtu, sndbuf, rcvbuf
>>> etc) but still no luck. I've tested the same setup between two Windows
>>> Server 2012 R2 servers and it works greatly in both directions.
>>> Then I've tested it with another Windows Server 2016 Standard server
>>> (different server and different ISP) and it showed the same awful resul=
ts
>>> in outbound direction.
>>> When I've set the same OpenVPN tunnel between two Windows Server 2016
>>> Standard servers I've got the same poor network speed in both direction=
s.
>>>
>>> I believe that the issue is somehow related only to the Windows Server
>>> 2016 version and I am more than confident that it depends on server's T=
CP
>>> stack settings.
>>> I've noticed that Windows Server 2016 has a congestion control provider
>>> setting set to "default", while previous versions of Windows has this
>>> setting set to "none".
>>>
>>> I've created a topic on OpenVPN Support Forum and it was suggested to
>>> post my issue to you and reference the thread.
>>>
>>> You can reference to the
>>> https://forums.openvpn.net/viewtopic.php?f=3D6&t=3D27173 for config fil=
es
>>> and additional information.
>>>
>>> Have you faced a similar issue before? Can you provide any hint how can
>>> I resolve the issue? What did I missed?
>>> I would be very grateful for any help. Thank you in advance.
>>>
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
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
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

--00000000000026e4b505776385c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>thank you for your investigation.</div><div><br></div=
><div>congestion provider can be customized if you select &quot;<span class=
=3D"gmail-st"><em>Datacenter Custom&quot;</em></span></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr">=D1=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 2=
018 =D0=B3. =D0=B2 13:58, Rostyslav Maryliak &lt;<a href=3D"mailto:rostysla=
v.maryliak@...2454...">rostyslav.maryliak@...2454...</a>&gt;:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"=
font-family:arial,helvetica,sans-serif">Dear Ilya,</div><div class=3D"gmail=
_default" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div c=
lass=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">I&#=
39;ve checked &quot;<span style=3D"font-family:Arial,Helvetica,sans-serif">=
Get-NetTCPConnection</span>&quot; command output on both win2012r2 and win2=
016 servers.</div><div class=3D"gmail_default" style=3D"font-family:arial,h=
elvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-f=
amily:arial,helvetica,sans-serif">win2012r2 server works as OpenVPN server.=
 Internal IP address - 10.0.4.1. OpenVPN tunnel IP address - 172.16.144.1</=
div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-=
serif">win2016 server works as OpenVPN client. Internal IP address - 10.0.4=
4.1. OpenVPN tunnel IP address - 172.16.144.18</div><div class=3D"gmail_def=
ault" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></d=
iv><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-s=
erif"><b>From win2012r2 server:</b></div><div class=3D"gmail_default" style=
=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_d=
efault"><font face=3D"arial, helvetica, sans-serif">PS C:\Users\Administrat=
or&gt; Get-NetTCPConnection -RemoteAddress 10.0.44.1</font></div><div class=
=3D"gmail_default"><span style=3D"font-family:arial,helvetica,sans-serif">L=
ocalAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 LocalPort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RemoteAddr=
ess=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AppliedSetting</span><br></div><d=
iv class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">----=
--------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---------=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0------=
----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -=
----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0--------------</font></div><div class=3D"gmail_default"><font face=3D=
"arial, helvetica, sans-serif">172.16.144.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A056437=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A010.0.44.1=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 53005=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Established=C2=A0 =C2=A0 =C2=A0 =C2=A0 <b>Datacenter</b></font><=
/div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-seri=
f"><br></font></div><div class=3D"gmail_default"><span style=3D"font-family=
:arial,helvetica,sans-serif">PS C:\Users\Administrator&gt; Get-NetTCPConnec=
tion -RemoteAddress 172.16.144.18</span><br></div><div class=3D"gmail_defau=
lt"><span style=3D"font-family:arial,helvetica,sans-serif">LocalAddress=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0LocalPort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemoteAddress=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AppliedSetting</span><br></div><div clas=
s=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">-----------=
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0-------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0----------=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -----=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--=
------------</font></div><div class=3D"gmail_default"><font face=3D"arial, =
helvetica, sans-serif">10.0.4.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11616=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 172.16.144.18=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 56882=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Esta=
blished=C2=A0 =C2=A0 =C2=A0 =C2=A0 <b>Datacenter</b></font></div><div class=
=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">10.0.4.1=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11616=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 172.16.144.18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 56905=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Established=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
<b>Datacenter</b></font><span style=3D"font-family:arial,helvetica,sans-ser=
if">=C2=A0=C2=A0<br></span></div><div class=3D"gmail_default"><span style=
=3D"font-family:arial,helvetica,sans-serif"><br></span></div><div class=3D"=
gmail_default"><span style=3D"font-family:arial,helvetica,sans-serif"><br><=
/span></div><div class=3D"gmail_default"><b style=3D"font-family:arial,helv=
etica,sans-serif">From win2016 server:</b>=C2=A0=C2=A0<span style=3D"font-f=
amily:arial,helvetica,sans-serif"><br></span></div><div class=3D"gmail_defa=
ult"><br></div><div class=3D"gmail_default"><div class=3D"gmail_default"><f=
ont face=3D"arial, helvetica, sans-serif">PS C:\Users\Administrator&gt; Get=
-NetTCPConnection -RemoteAddress 10.0.4.1</font></div><div class=3D"gmail_d=
efault"><span style=3D"font-family:arial,helvetica,sans-serif">LocalAddress=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0LocalPort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemoteAddress=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AppliedSetting=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0OwningProcess</span><br></div><div class=3D"gmail_defau=
lt"><font face=3D"arial, helvetica, sans-serif">------------=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0---------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0-------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0----------=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--------------=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------=
</font></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, s=
ans-serif">172.16.144.18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 56905=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 10.0.4.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A011616=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Establish=
ed=C2=A0 =C2=A0 =C2=A0 =C2=A0<b> Internet=C2=A0</b>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A013300</font></div><div class=
=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">172.16.144.1=
8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 56882=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10.0.4.1=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A011616=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Established=C2=A0 =C2=A0 =C2=
=A0 =C2=A0<b> Internet=C2=A0 </b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 13300</font></div><div class=3D"gmail_default"><font f=
ace=3D"arial, helvetica, sans-serif"><br></font></div><div class=3D"gmail_d=
efault"><font face=3D"arial, helvetica, sans-serif"><br></font></div><div c=
lass=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">PS C:\Us=
ers\Administrator&gt; Get-NetTCPConnection -RemoteAddress 172.16.144.1</fon=
t></div><div class=3D"gmail_default"><span style=3D"font-family:arial,helve=
tica,sans-serif">LocalAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LocalPort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0RemoteAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Stat=
e=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AppliedSetti=
ng=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OwningProcess</span><br></div><d=
iv class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">----=
--------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---------=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0------=
----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -=
----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -=
-------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
-------------</font></div><div class=3D"gmail_default"><font face=3D"arial,=
 helvetica, sans-serif">10.0.44.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 53005=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 172.16.144.1=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 56437=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Estab=
lished=C2=A0 =C2=A0 =C2=A0 =C2=A0<b>Internet</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 13300</font></div><div cl=
ass=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif"><br></fon=
t></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-s=
erif"><br></font></div><div class=3D"gmail_default"><font face=3D"arial, he=
lvetica, sans-serif">I&#39;ve changed the &quot;AppliedSetting&quot; value =
to Datacenter on win2016 server as well by running this commands and restar=
ting the VPN:</font></div><div class=3D"gmail_default"><font face=3D"arial,=
 helvetica, sans-serif">New-</font><span style=3D"font-family:arial,helveti=
ca,sans-serif">NetTransportFilter -SettingName Datacenter -DestinationPrefi=
x <a href=3D"http://10.0.4.0/24" target=3D"_blank">10.0.4.0/24</a></span></=
div><div class=3D"gmail_default"><span style=3D"font-family:arial,helvetica=
,sans-serif">New-NetTransportFilter -SettingName Datacenter -DestinationPre=
fix <a href=3D"http://172.16.144.0/24" target=3D"_blank">172.16.144.0/24</a=
></span>=C2=A0=C2=A0<span style=3D"font-family:arial,helvetica,sans-serif">=
<br></span></div><div class=3D"gmail_default"><br></div><div class=3D"gmail=
_default">Now it shows Datacenter on both servers. But the network speed re=
mains the same. My changes do not affect the issue.</div><div class=3D"gmai=
l_default">I&#39;ve noticed that global TCP settings influence that, especi=
ally &quot;Chimney Offload&quot;, &quot;Congestion Control Provider&quot; a=
nd &quot;ECN Capability&quot;:</div><div class=3D"gmail_default"><br></div>=
<div class=3D"gmail_default"><div class=3D"gmail_default"><span style=3D"fo=
nt-family:arial,helvetica,sans-serif">C:\Users\Administrator&gt;=C2=A0</spa=
n>netsh int tcp show global</div><div class=3D"gmail_default">Querying acti=
ve state...</div><div class=3D"gmail_default"><br></div><div class=3D"gmail=
_default">TCP Global Parameters</div><div class=3D"gmail_default">---------=
-------------------------------------</div><div class=3D"gmail_default">Rec=
eive-Side Scaling State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0: enabled</div><div class=3D"gmail_default">Chimney Offloa=
d State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 : disabled</div><div class=3D"gmail_default">NetDM=
A State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: =
disabled</div><div class=3D"gmail_default">Direct Cache Access (DCA)=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : disabled</div><di=
v class=3D"gmail_default">Receive Window Auto-Tuning Level=C2=A0 =C2=A0 =C2=
=A0: normal</div><div class=3D"gmail_default">Add-On Congestion Control Pro=
vider=C2=A0 =C2=A0: default</div><div class=3D"gmail_default">ECN Capabilit=
y=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : enabled</div>=
<div class=3D"gmail_default">RFC 1323 Timestamps=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: disabled</=
div><div class=3D"gmail_default">Initial RTO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 3000</div><div cla=
ss=3D"gmail_default">Receive Segment Coalescing State=C2=A0 =C2=A0 =C2=A0: =
enabled</div><div class=3D"gmail_default">Non Sack Rtt Resiliency=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: =
disabled</div><div class=3D"gmail_default">Max SYN Retransmissions=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 2</div><div=
 class=3D"gmail_default">TCP Fast Open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0: disabled</div><div class=3D"gmail_default"><br></=
div><div class=3D"gmail_default"><br></div><div class=3D"gmail_default">Tha=
t is why I believe that the root cause of the issue lies in &quot;Congestio=
n Control Provider&quot; setting. But I am unable to change it</div></div><=
/div></div></div></div></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Thu, Oct 4, 2018 at 7:50 AM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=
=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...1663...=
." target=3D"_blank">chipitsine@...277...</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><div dir=3D"ltr"><div>Hello,</div><div><br></div><div=
>can you do some things and tell us your observation ?</div><div><br></div>=
<div>starting with win2012 so called network profiles were introduced (Inte=
rnet / Intranet / Datacenter)</div><div>those profiles are very different f=
or tcp connection (if you observe degradation in case of udp, most probably=
 that is not related)</div><div><br></div><div><br></div><div>so, let&#39;s=
 start</div><div><br></div><div>start powershell (I assume you are familiar=
)</div><div>call</div><div><br></div><div>Get-NetTCPConnection</div><div><b=
r></div><div>pay attention to &quot;AppliedSetting&quot; column.</div><div>=
what&#39;s there=C2=A0 ?</div><div><br></div><div>we did observe strange th=
ings when win2012 classified some traffic as &quot;Internet&quot; and appro=
priate tcp settings were applied.</div><div><br></div><div>is there some co=
rrelation in your case ?<br></div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr">=D1=81=D1=80, 3 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 20:45,=
 Rostyslav Maryliak &lt;<a href=3D"mailto:rostyslav.maryliak@...2454..." ta=
rget=3D"_blank">rostyslav.maryliak@...2454...</a>&gt;:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div=
 dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default"=
><font face=3D"arial, helvetica, sans-serif">Dear OpenVPN developers,</font=
></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-se=
rif"><br></font></div><div class=3D"gmail_default"><font face=3D"arial, hel=
vetica, sans-serif"><div class=3D"gmail_default">I&#39;ve faced a very stra=
nge issue with slow outbound network speed from Windows Server 2016 Standar=
d server via the OpenVPN tunnel.</div><div class=3D"gmail_default">OpenVPN =
server is Windows Server 2012 R2, client is Windows Server 2016. The inboun=
d network speed for Windows Server 2016 is great.</div><div class=3D"gmail_=
default">But the outbound network speed is nearly 30-40 kbps. I&#39;ve got =
the same results using several tests: iperf testings, file download via SMB=
, Web-based downloading (using HTTP) etc.</div></font></div><div class=3D"g=
mail_default"><font face=3D"arial, helvetica, sans-serif"><br></font></div>=
<div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif"><d=
iv class=3D"gmail_default">The tunnels is getting up and it works greatly, =
but only in one direction - from Windows Server 2012 R2 to Windows Server 2=
016.</div><div class=3D"gmail_default">I&#39;ve been using such server-clie=
nt configurations setup for several years with Windows Server 2012 R2 serve=
rs and I&#39;ve never faced such issue before.</div><div class=3D"gmail_def=
ault">At first I thought that our ISP has some network limitations, but it =
turned out that the same tests shows great network speed results using the =
public IP addresses in both directions.</div><div class=3D"gmail_default">T=
he issue only occurs inside the VPN tunnel. I&#39;ve spent 3 days tryng to =
figure it out, but failed. I&#39;ve installed all latest Windows updates, r=
einstalled OpenVPN, tried to switch from UDP to TCP,</div><div class=3D"gma=
il_default">played with performance settings in configs (link-mtu, sndbuf, =
rcvbuf etc) but still no luck. I&#39;ve tested the same setup between two W=
indows Server 2012 R2 servers and it works greatly in both directions.</div=
><div class=3D"gmail_default">Then I&#39;ve tested it with another Windows =
Server 2016 Standard server (different server and different ISP) and it sho=
wed the same awful results in outbound direction.</div><div class=3D"gmail_=
default">When I&#39;ve set the same OpenVPN tunnel between two Windows Serv=
er 2016 Standard servers I&#39;ve got the same poor network speed in both d=
irections.</div></font></div><div class=3D"gmail_default"><font face=3D"ari=
al, helvetica, sans-serif"><br></font></div><div class=3D"gmail_default"><f=
ont face=3D"arial, helvetica, sans-serif"><div class=3D"gmail_default">I be=
lieve that the issue is somehow related only to the Windows Server 2016 ver=
sion and I am more than confident that it depends on server&#39;s TCP stack=
 settings.</div><div class=3D"gmail_default">I&#39;ve noticed that Windows =
Server 2016 has a congestion control provider setting set to &quot;default&=
quot;, while previous versions of Windows has this setting set to &quot;non=
e&quot;.</div></font></div><div class=3D"gmail_default"><font face=3D"arial=
, helvetica, sans-serif"><br></font></div><div class=3D"gmail_default"><fon=
t face=3D"arial, helvetica, sans-serif">I&#39;ve created a topic on OpenVPN=
 Support Forum and it was suggested to post my issue to you and reference t=
he thread.</font></div><div class=3D"gmail_default"><font face=3D"arial, he=
lvetica, sans-serif"><br></font></div><div class=3D"gmail_default"><font fa=
ce=3D"arial, helvetica, sans-serif">You can reference to the <a href=3D"htt=
ps://forums.openvpn.net/viewtopic.php?f=3D6&amp;t=3D27173" target=3D"_blank=
">https://forums.openvpn.net/viewtopic.php?f=3D6&amp;t=3D27173</a>=C2=A0for=
 config files and additional information.</font><br clear=3D"all"></div><di=
v><br></div><div><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Have you faced a similar issue before? Can you provide =
any hint how can I resolve the issue? What did I missed?</div><div class=3D=
"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">I would be=
 very grateful for any help. Thank you in advance.</div><br></div><div><br>=
</div>-- <br><div dir=3D"ltr" class=3D"m_7016428550422907693m_-476667607694=
6984635m_-2729697033681776833gmail_signature"><div dir=3D"ltr"><div><div di=
r=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><p style=3D"margin:0i=
n 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><span style=
=3D"font-size:12pt;color:rgb(89,89,89)">Best regards,</span></p><p style=3D=
"margin:0in 0in 0.0001pt;font-family:Calibri,sans-serif"><font color=3D"#59=
5959"><span style=3D"font-size:16px"><b>Rostyslav Maryliak</b></span></font=
></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri=
,sans-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89)">System Admi=
nistrator</span></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif"><span style=3D"font-size:12pt;color:rgb(89,89,8=
9)">=C2=A0</span></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;fon=
t-family:Calibri,sans-serif"><b><span style=3D"font-size:12pt;color:rgb(35,=
176,24)">iDeals=E2=84=A2 Solutions Group</span></b><span style=3D"font-size=
:12pt;color:rgb(89,89,89)">|=C2=A0<a href=3D"tel:%2B%2038%28093%29575-35-16=
" value=3D"+380935753516" style=3D"color:rgb(17,85,204)" target=3D"_blank">=
+ 38(073)437-72-51</a>=C2=A0| Skype: rostyslav.maryliak.ideals|</span><span=
 style=3D"color:rgb(31,73,125)">=C2=A0</span><u><span style=3D"font-size:12=
pt;color:rgb(35,176,24)"><a href=3D"mailto:dmitry.zaporozhchenko@...2454...=
" style=3D"color:rgb(17,85,204)" target=3D"_blank"><span style=3D"color:rgb=
(5,99,193)">rostyslav.maryliak@...2454...</span></a></span></u><u><span sty=
le=3D"color:rgb(35,176,24)">=C2=A0</span></u><span style=3D"font-size:12pt;=
color:rgb(89,89,89)">|</span><span style=3D"font-size:12pt;color:rgb(35,176=
,24)">=C2=A0</span><span lang=3D"RU" style=3D"font-size:12pt;color:rgb(35,1=
76,24)"><a href=3D"http://www.idealscorp.com/" style=3D"color:rgb(17,85,204=
)" target=3D"_blank"><span lang=3D"EN-US" style=3D"color:rgb(35,176,24)">ww=
w.idealsvdr.com</span></a></span></p></div></div></div></div></div></div></=
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
>_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"m_7016428550422907693gmail_signature" data-smartmail=3D"gmail_sig=
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

--00000000000026e4b505776385c4--

