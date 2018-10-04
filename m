MIME-Version: 1.0
References: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
 <CAFHpkQG10QOhGUb4R4VyPHwCNMfkVSQgCVgmypsBidsgNcsBaw@...278...>
 <CADkMwqQ+F-rLr3V5_BxjixbvnyOW6T+Y6tP---3PBaOcHkRBpA@...278...>
 <CAFHpkQExnJLdr1kNMkXoYxXjOdX4+M3KTcOfBp1ZQwmV3CkkXA@...278...>
In-Reply-To: <CAFHpkQExnJLdr1kNMkXoYxXjOdX4+M3KTcOfBp1ZQwmV3CkkXA@...278...>
From: Rostyslav Maryliak <rostyslav.maryliak@...2454...>
Date: Thu, 4 Oct 2018 13:49:54 +0300
Message-ID: <CADkMwqS7AUDVz_tj0_6ewhJ7YgfJmph71dK-hCVhgOY=5+z3oA@...278...>
Content-Type: multipart/alternative; boundary="00000000000075c5bd057764ecac"
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

--00000000000075c5bd057764ecac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Illya,

Sorry for misleading you. I want to set this parameter to "none" globally.
I CAN change "Congestion Control Provider" setting for different templates
(i.e. Internet. Datacenter etc) in Powershell, but not to a "None" value.

In Powershell there is simply no option for this value:
PS C:\Users\Administrator> Set-NetTCPSetting -SettingName Datacenter
-CongestionProvider [ CTCP | CUBIC | DCTCP | Default | LEDBAT | NewReno ]

I've tried different values, but still no luck.

In CMD there is such option, but it does not apply any changes for it:
C:\Users\Administrator> netsh int tcp set supplemental template=3Ddatacenter
congestionprovider=3D*none*
Ok.

C:\Users\Administrator> netsh int tcp show supplemental template=3Ddatacent=
er
TCP Supplemental Parameters
----------------------------------------------
Minimum RTO (msec)                       : 20
Initial Congestion Window (MSS)     : 10
Congestion Control Provider             : *dctcp*
Enable Congestion Window Restart  : enabled
Delayed ACK timeout (msec)            : 10
Delayed ACK frequency                    : 2
Enable RACK                                    : disabled
Enable Tail Loss Probe                     : disabled

Also, as I've mentioned in referred thread, such issue occurs on all our
win2016 servers, except one.
This exception server has "Congestion Control Provider" setting set to
"none" somehow.
But still it is very strange for me that I have such slow network speed via
the tunnel for all win2016 servers "out of the box".

Can you please check this from your side as well and confirm or disprove
the issue?


On Thu, Oct 4, 2018 at 12:10 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> thank you for your investigation.
>
> congestion provider can be customized if you select "*Datacenter Custom"*
>
> =D1=87=D1=82, 4 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 13:58, Rostyslav =
Maryliak <
> rostyslav.maryliak@...2454...>:
>
>> Dear Ilya,
>>
>> I've checked "Get-NetTCPConnection" command output on both win2012r2 and
>> win2016 servers.
>>
>> win2012r2 server works as OpenVPN server. Internal IP address - 10.0.4.1.
>> OpenVPN tunnel IP address - 172.16.144.1
>> win2016 server works as OpenVPN client. Internal IP address - 10.0.44.1.
>> OpenVPN tunnel IP address - 172.16.144.18
>>
>>
>> *From win2012r2 server:*
>>
>> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress 10.0.44.1
>> LocalAddress                        LocalPort          RemoteAddress
>>            RemotePort             State                  AppliedSetting
>> ------------                               ---------
>>  -------------                           ----------
>> -----                     --------------
>> 172.16.144.1                         56437               10.0.44.1
>>                     53005                      Established
>> *Datacenter*
>>
>> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress
>> 172.16.144.18
>> LocalAddress                       LocalPort           RemoteAddress
>>            RemotePort             State                  AppliedSetting
>> ------------                               ---------
>>  -------------                           ----------
>> -----                     --------------
>> 10.0.4.1                                11616
>> 172.16.144.18                    56882                      Established
>>     *Datacenter*
>> 10.0.4.1                                11616
>> 172.16.144.18                    56905                      Established
>>     *Datacenter*
>>
>>
>> *From win2016 server:*
>>
>> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress 10.0.4.1
>> LocalAddress                       LocalPort           RemoteAddress
>>            RemotePort             State                 AppliedSetting
>>      OwningProcess
>> ------------                               ---------
>>  -------------                           ----------
>>  -----                   --------------                 -------------
>> 172.16.144.18                      56905                10.0.4.1
>>                    11616                       Established       *
>> Internet *                   13300
>> 172.16.144.18                      56882                10.0.4.1
>>                    11616                       Established       *
>> Internet  *                  13300
>>
>>
>> PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress
>> 172.16.144.1
>> LocalAddress                       LocalPort           RemoteAddress
>>            RemotePort             State                 AppliedSetting
>>      OwningProcess
>> ------------                               ---------
>>  -------------                           ----------
>> -----                    --------------                 -------------
>> 10.0.44.1                              53005                172.16.144.1
>>                     56437                      Established
>> *Internet*                      13300
>>
>>
>> I've changed the "AppliedSetting" value to Datacenter on win2016 server
>> as well by running this commands and restarting the VPN:
>> New-NetTransportFilter -SettingName Datacenter -DestinationPrefix
>> 10.0.4.0/24
>> New-NetTransportFilter -SettingName Datacenter -DestinationPrefix
>> 172.16.144.0/24
>>
>> Now it shows Datacenter on both servers. But the network speed remains
>> the same. My changes do not affect the issue.
>> I've noticed that global TCP settings influence that, especially "Chimney
>> Offload", "Congestion Control Provider" and "ECN Capability":
>>
>> C:\Users\Administrator> netsh int tcp show global
>> Querying active state...
>>
>> TCP Global Parameters
>> ----------------------------------------------
>> Receive-Side Scaling State                   : enabled
>> Chimney Offload State                          : disabled
>> NetDMA State                                       : disabled
>> Direct Cache Access (DCA)                  : disabled
>> Receive Window Auto-Tuning Level     : normal
>> Add-On Congestion Control Provider   : default
>> ECN Capability                                      : enabled
>> RFC 1323 Timestamps                         : disabled
>> Initial RTO                                             : 3000
>> Receive Segment Coalescing State     : enabled
>> Non Sack Rtt Resiliency                       : disabled
>> Max SYN Retransmissions                   : 2
>> TCP Fast Open                                     : disabled
>>
>>
>> That is why I believe that the root cause of the issue lies in
>> "Congestion Control Provider" setting. But I am unable to change it
>>
>> On Thu, Oct 4, 2018 at 7:50 AM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
>>
>>> Hello,
>>>
>>> can you do some things and tell us your observation ?
>>>
>>> starting with win2012 so called network profiles were introduced
>>> (Internet / Intranet / Datacenter)
>>> those profiles are very different for tcp connection (if you observe
>>> degradation in case of udp, most probably that is not related)
>>>
>>>
>>> so, let's start
>>>
>>> start powershell (I assume you are familiar)
>>> call
>>>
>>> Get-NetTCPConnection
>>>
>>> pay attention to "AppliedSetting" column.
>>> what's there  ?
>>>
>>> we did observe strange things when win2012 classified some traffic as
>>> "Internet" and appropriate tcp settings were applied.
>>>
>>> is there some correlation in your case ?
>>>
>>> =D1=81=D1=80, 3 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 20:45, Rostysla=
v Maryliak <
>>> rostyslav.maryliak@...2454...>:
>>>
>>>> Dear OpenVPN developers,
>>>>
>>>> I've faced a very strange issue with slow outbound network speed from
>>>> Windows Server 2016 Standard server via the OpenVPN tunnel.
>>>> OpenVPN server is Windows Server 2012 R2, client is Windows Server
>>>> 2016. The inbound network speed for Windows Server 2016 is great.
>>>> But the outbound network speed is nearly 30-40 kbps. I've got the same
>>>> results using several tests: iperf testings, file download via SMB,
>>>> Web-based downloading (using HTTP) etc.
>>>>
>>>> The tunnels is getting up and it works greatly, but only in one
>>>> direction - from Windows Server 2012 R2 to Windows Server 2016.
>>>> I've been using such server-client configurations setup for several
>>>> years with Windows Server 2012 R2 servers and I've never faced such is=
sue
>>>> before.
>>>> At first I thought that our ISP has some network limitations, but it
>>>> turned out that the same tests shows great network speed results using=
 the
>>>> public IP addresses in both directions.
>>>> The issue only occurs inside the VPN tunnel. I've spent 3 days tryng to
>>>> figure it out, but failed. I've installed all latest Windows updates,
>>>> reinstalled OpenVPN, tried to switch from UDP to TCP,
>>>> played with performance settings in configs (link-mtu, sndbuf, rcvbuf
>>>> etc) but still no luck. I've tested the same setup between two Windows
>>>> Server 2012 R2 servers and it works greatly in both directions.
>>>> Then I've tested it with another Windows Server 2016 Standard server
>>>> (different server and different ISP) and it showed the same awful resu=
lts
>>>> in outbound direction.
>>>> When I've set the same OpenVPN tunnel between two Windows Server 2016
>>>> Standard servers I've got the same poor network speed in both directio=
ns.
>>>>
>>>> I believe that the issue is somehow related only to the Windows Server
>>>> 2016 version and I am more than confident that it depends on server's =
TCP
>>>> stack settings.
>>>> I've noticed that Windows Server 2016 has a congestion control provider
>>>> setting set to "default", while previous versions of Windows has this
>>>> setting set to "none".
>>>>
>>>> I've created a topic on OpenVPN Support Forum and it was suggested to
>>>> post my issue to you and reference the thread.
>>>>
>>>> You can reference to the
>>>> https://forums.openvpn.net/viewtopic.php?f=3D6&t=3D27173 for config fi=
les
>>>> and additional information.
>>>>
>>>> Have you faced a similar issue before? Can you provide any hint how can
>>>> I resolve the issue? What did I missed?
>>>> I would be very grateful for any help. Thank you in advance.
>>>>
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
>>>> _______________________________________________
>>>> Openvpn-devel mailing list
>>>> Openvpn-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>
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

--00000000000075c5bd057764ecac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,helvetica=
,sans-serif">Dear Illya,</div><div class=3D"gmail_default" style=3D"font-fa=
mily:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" sty=
le=3D"font-family:arial,helvetica,sans-serif">Sorry for misleading you. I w=
ant to set this parameter to &quot;none&quot; globally.</div><div class=3D"=
gmail_default" style=3D"font-family:arial,helvetica,sans-serif">I CAN chang=
e=C2=A0<span style=3D"font-family:Arial,Helvetica,sans-serif">&quot;Congest=
ion Control Provider&quot; setting for different templates (i.e. Internet. =
Datacenter etc) in Powershell, but not to a &quot;None&quot; value.</span><=
/div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans=
-serif"><span style=3D"font-family:Arial,Helvetica,sans-serif"><br></span><=
/div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans=
-serif"><span style=3D"font-family:Arial,Helvetica,sans-serif">In Powershel=
l there is simply no option for this value:</span></div><div class=3D"gmail=
_default" style=3D"font-family:arial,helvetica,sans-serif"><span style=3D"f=
ont-family:Arial,Helvetica,sans-serif">PS C:\Users\Administrator&gt; Set-Ne=
tTCPSetting -SettingName Datacenter -CongestionProvider [ CTCP | CUBIC | DC=
TCP | Default | LEDBAT | NewReno ]</span><br></div><div class=3D"gmail_defa=
ult"><br></div><div class=3D"gmail_default">I&#39;ve tried different values=
, but still no luck.</div><div class=3D"gmail_default"><br></div><div class=
=3D"gmail_default">In CMD there is such option, but it does not apply any c=
hanges for it:</div><div class=3D"gmail_default">C:\Users\Administrator&gt;=
 netsh int tcp set supplemental template=3Ddatacenter congestionprovider=3D=
<b>none</b><br></div><div class=3D"gmail_default">Ok.<br></div><div class=
=3D"gmail_default"><br></div><div class=3D"gmail_default"><div class=3D"gma=
il_default">C:\Users\Administrator&gt; netsh int tcp show supplemental temp=
late=3Ddatacenter</div><div class=3D"gmail_default">TCP Supplemental Parame=
ters</div><div class=3D"gmail_default">------------------------------------=
----------</div><div class=3D"gmail_default">Minimum RTO (msec)=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: =
20</div><div class=3D"gmail_default">Initial Congestion Window (MSS)=C2=A0 =
=C2=A0 =C2=A0: 10</div><div class=3D"gmail_default">Congestion Control Prov=
ider=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:=C2=A0<b>dctcp</b></di=
v><div class=3D"gmail_default">Enable Congestion Window Restart=C2=A0 : ena=
bled</div><div class=3D"gmail_default">Delayed ACK timeout (msec)=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 10</div><div class=3D"gmail_default">Dela=
yed ACK frequency=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 : 2</div><div class=3D"gmail_default">Enable RACK=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : disabled</div><div class=3D"gma=
il_default">Enable Tail Loss Probe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: disabled</div><div class=3D"gmail_defa=
ult"><br></div><div class=3D"gmail_default">Also, as I&#39;ve mentioned in =
referred thread, such issue occurs on all our win2016 servers, except one.<=
/div><div class=3D"gmail_default">This exception server has &quot;Congestio=
n Control Provider&quot; setting set to &quot;none&quot; somehow.</div><div=
 class=3D"gmail_default">But still it is very strange for me that I have su=
ch slow network speed via the tunnel for all win2016 servers &quot;out of t=
he box&quot;.</div><div class=3D"gmail_default"><br></div><div class=3D"gma=
il_default">Can you please check this from your side as well and confirm or=
 disprove the issue?</div></div><div class=3D"gmail_default"><br></div></di=
v></div></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">O=
n Thu, Oct 4, 2018 at 12:10 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277...">chipit=
sine@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div =
dir=3D"ltr"><div>thank you for your investigation.</div><div><br></div><div=
>congestion provider can be customized if you select &quot;<span class=3D"m=
_-5061142619719305404gmail-st"><em>Datacenter Custom&quot;</em></span></div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">=D1=87=D1=82, 4 =D0=
=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 13:58, Rostyslav Maryliak &lt;<a href=
=3D"mailto:rostyslav.maryliak@...2454..." target=3D"_blank">rostyslav.maryl=
iak@...2454...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D=
"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><=
div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif=
">Dear Ilya,</div><div class=3D"gmail_default" style=3D"font-family:arial,h=
elvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-f=
amily:arial,helvetica,sans-serif">I&#39;ve checked &quot;<span style=3D"fon=
t-family:Arial,Helvetica,sans-serif">Get-NetTCPConnection</span>&quot; comm=
and output on both win2012r2 and win2016 servers.</div><div class=3D"gmail_=
default" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div cl=
ass=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">win2=
012r2 server works as OpenVPN server. Internal IP address - 10.0.4.1. OpenV=
PN tunnel IP address - 172.16.144.1</div><div class=3D"gmail_default" style=
=3D"font-family:arial,helvetica,sans-serif">win2016 server works as OpenVPN=
 client. Internal IP address - 10.0.44.1. OpenVPN tunnel IP address - 172.1=
6.144.18</div><div class=3D"gmail_default" style=3D"font-family:arial,helve=
tica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-famil=
y:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" style=
=3D"font-family:arial,helvetica,sans-serif"><b>From win2012r2 server:</b></=
div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-=
serif"><br></div><div class=3D"gmail_default"><font face=3D"arial, helvetic=
a, sans-serif">PS C:\Users\Administrator&gt; Get-NetTCPConnection -RemoteAd=
dress 10.0.44.1</font></div><div class=3D"gmail_default"><span style=3D"fon=
t-family:arial,helvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LocalPort=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RemoteAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 AppliedSetting</span><br></div><div class=3D"gmail_default"><font fa=
ce=3D"arial, helvetica, sans-serif">------------=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0---------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-=
------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0----------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--------------</font></div><di=
v class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">172.1=
6.144.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A056437=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A010.0.44.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 53005=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Established=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <b>Datacenter</b></font></div><div class=3D"gmail_default"><f=
ont face=3D"arial, helvetica, sans-serif"><br></font></div><div class=3D"gm=
ail_default"><span style=3D"font-family:arial,helvetica,sans-serif">PS C:\U=
sers\Administrator&gt; Get-NetTCPConnection -RemoteAddress 172.16.144.18</s=
pan><br></div><div class=3D"gmail_default"><span style=3D"font-family:arial=
,helvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LocalPort=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0RemoteAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Appl=
iedSetting</span><br></div><div class=3D"gmail_default"><font face=3D"arial=
, helvetica, sans-serif">------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--=
-------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0----------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--------------</font></div><div class=3D=
"gmail_default"><font face=3D"arial, helvetica, sans-serif">10.0.4.1=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11616=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 172.16.144.18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 56882=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Established=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
b>Datacenter</b></font></div><div class=3D"gmail_default"><font face=3D"ari=
al, helvetica, sans-serif">10.0.4.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1=
1616=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 172.16.144.18=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 56905=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Established=C2=A0 =C2=A0 =C2=A0 =C2=A0 <b>Datacenter</b></font><span st=
yle=3D"font-family:arial,helvetica,sans-serif">=C2=A0=C2=A0<br></span></div=
><div class=3D"gmail_default"><span style=3D"font-family:arial,helvetica,sa=
ns-serif"><br></span></div><div class=3D"gmail_default"><span style=3D"font=
-family:arial,helvetica,sans-serif"><br></span></div><div class=3D"gmail_de=
fault"><b style=3D"font-family:arial,helvetica,sans-serif">From win2016 ser=
ver:</b>=C2=A0=C2=A0<span style=3D"font-family:arial,helvetica,sans-serif">=
<br></span></div><div class=3D"gmail_default"><br></div><div class=3D"gmail=
_default"><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans=
-serif">PS C:\Users\Administrator&gt; Get-NetTCPConnection -RemoteAddress 1=
0.0.4.1</font></div><div class=3D"gmail_default"><span style=3D"font-family=
:arial,helvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LocalPort=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0RemoteAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A=
ppliedSetting=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OwningProcess</span><=
br></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-=
serif">------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---------=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0----------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0--------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0-------------</font></div><div class=3D"gmail_default">=
<font face=3D"arial, helvetica, sans-serif">172.16.144.18=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 56905=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10.0.4.1=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A011616=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Established=C2=A0 =C2=A0 =C2=A0 =C2=A0<b> Internet=
=C2=A0</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A013300</font></div><div class=3D"gmail_default"><font face=3D"arial, h=
elvetica, sans-serif">172.16.144.18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 56882=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 10.0.4.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A011616=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Established=C2=A0 =C2=A0 =C2=A0 =C2=A0<b> Internet=C2=A0 </b>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 13300</font></div><div=
 class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif"><br></=
font></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, san=
s-serif"><br></font></div><div class=3D"gmail_default"><font face=3D"arial,=
 helvetica, sans-serif">PS C:\Users\Administrator&gt; Get-NetTCPConnection =
-RemoteAddress 172.16.144.1</font></div><div class=3D"gmail_default"><span =
style=3D"font-family:arial,helvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LocalP=
ort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemoteAddress=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AppliedSetting=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
OwningProcess</span><br></div><div class=3D"gmail_default"><font face=3D"ar=
ial, helvetica, sans-serif">------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0---------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--------=
-----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0----------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------</font></div><div class=3D"g=
mail_default"><font face=3D"arial, helvetica, sans-serif">10.0.44.1=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 53005=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 172.16.144.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 56437=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Established=C2=A0 =C2=A0 =C2=A0 =C2=A0<b>In=
ternet</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 13300</font></div><div class=3D"gmail_default"><font face=3D"=
arial, helvetica, sans-serif"><br></font></div><div class=3D"gmail_default"=
><font face=3D"arial, helvetica, sans-serif"><br></font></div><div class=3D=
"gmail_default"><font face=3D"arial, helvetica, sans-serif">I&#39;ve change=
d the &quot;AppliedSetting&quot; value to Datacenter on win2016 server as w=
ell by running this commands and restarting the VPN:</font></div><div class=
=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">New-</font><=
span style=3D"font-family:arial,helvetica,sans-serif">NetTransportFilter -S=
ettingName Datacenter -DestinationPrefix <a href=3D"http://10.0.4.0/24" tar=
get=3D"_blank">10.0.4.0/24</a></span></div><div class=3D"gmail_default"><sp=
an style=3D"font-family:arial,helvetica,sans-serif">New-NetTransportFilter =
-SettingName Datacenter -DestinationPrefix <a href=3D"http://172.16.144.0/2=
4" target=3D"_blank">172.16.144.0/24</a></span>=C2=A0=C2=A0<span style=3D"f=
ont-family:arial,helvetica,sans-serif"><br></span></div><div class=3D"gmail=
_default"><br></div><div class=3D"gmail_default">Now it shows Datacenter on=
 both servers. But the network speed remains the same. My changes do not af=
fect the issue.</div><div class=3D"gmail_default">I&#39;ve noticed that glo=
bal TCP settings influence that, especially &quot;Chimney Offload&quot;, &q=
uot;Congestion Control Provider&quot; and &quot;ECN Capability&quot;:</div>=
<div class=3D"gmail_default"><br></div><div class=3D"gmail_default"><div cl=
ass=3D"gmail_default"><span style=3D"font-family:arial,helvetica,sans-serif=
">C:\Users\Administrator&gt;=C2=A0</span>netsh int tcp show global</div><di=
v class=3D"gmail_default">Querying active state...</div><div class=3D"gmail=
_default"><br></div><div class=3D"gmail_default">TCP Global Parameters</div=
><div class=3D"gmail_default">---------------------------------------------=
-</div><div class=3D"gmail_default">Receive-Side Scaling State=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: enabled</div><div=
 class=3D"gmail_default">Chimney Offload State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : disabled</=
div><div class=3D"gmail_default">NetDMA State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: disabled</div><div class=3D"gmail_d=
efault">Direct Cache Access (DCA)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 : disabled</div><div class=3D"gmail_default">Receive W=
indow Auto-Tuning Level=C2=A0 =C2=A0 =C2=A0: normal</div><div class=3D"gmai=
l_default">Add-On Congestion Control Provider=C2=A0 =C2=A0: default</div><d=
iv class=3D"gmail_default">ECN Capability=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 : enabled</div><div class=3D"gmail_default">RFC 13=
23 Timestamps=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0: disabled</div><div class=3D"gmail_default">In=
itial RTO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0: 3000</div><div class=3D"gmail_default">Receive Segmen=
t Coalescing State=C2=A0 =C2=A0 =C2=A0: enabled</div><div class=3D"gmail_de=
fault">Non Sack Rtt Resiliency=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: disabled</div><div class=3D"gmail_d=
efault">Max SYN Retransmissions=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0: 2</div><div class=3D"gmail_default">TCP Fast O=
pen=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: disabled</d=
iv><div class=3D"gmail_default"><br></div><div class=3D"gmail_default"><br>=
</div><div class=3D"gmail_default">That is why I believe that the root caus=
e of the issue lies in &quot;Congestion Control Provider&quot; setting. But=
 I am unable to change it</div></div></div></div></div></div></div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Oct 4, 2018 at 7:50 A=
M =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<=
a href=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsine@...1354...=
..</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">=
<div>Hello,</div><div><br></div><div>can you do some things and tell us you=
r observation ?</div><div><br></div><div>starting with win2012 so called ne=
twork profiles were introduced (Internet / Intranet / Datacenter)</div><div=
>those profiles are very different for tcp connection (if you observe degra=
dation in case of udp, most probably that is not related)</div><div><br></d=
iv><div><br></div><div>so, let&#39;s start</div><div><br></div><div>start p=
owershell (I assume you are familiar)</div><div>call</div><div><br></div><d=
iv>Get-NetTCPConnection</div><div><br></div><div>pay attention to &quot;App=
liedSetting&quot; column.</div><div>what&#39;s there=C2=A0 ?</div><div><br>=
</div><div>we did observe strange things when win2012 classified some traff=
ic as &quot;Internet&quot; and appropriate tcp settings were applied.</div>=
<div><br></div><div>is there some correlation in your case ?<br></div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr">=D1=81=D1=80, 3 =D0=BE=D0=
=BA=D1=82. 2018 =D0=B3. =D0=B2 20:45, Rostyslav Maryliak &lt;<a href=3D"mai=
lto:rostyslav.maryliak@...2454..." target=3D"_blank">rostyslav.maryliak@...493...=
2454...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><=
div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-=
serif">Dear OpenVPN developers,</font></div><div class=3D"gmail_default"><f=
ont face=3D"arial, helvetica, sans-serif"><br></font></div><div class=3D"gm=
ail_default"><font face=3D"arial, helvetica, sans-serif"><div class=3D"gmai=
l_default">I&#39;ve faced a very strange issue with slow outbound network s=
peed from Windows Server 2016 Standard server via the OpenVPN tunnel.</div>=
<div class=3D"gmail_default">OpenVPN server is Windows Server 2012 R2, clie=
nt is Windows Server 2016. The inbound network speed for Windows Server 201=
6 is great.</div><div class=3D"gmail_default">But the outbound network spee=
d is nearly 30-40 kbps. I&#39;ve got the same results using several tests: =
iperf testings, file download via SMB, Web-based downloading (using HTTP) e=
tc.</div></font></div><div class=3D"gmail_default"><font face=3D"arial, hel=
vetica, sans-serif"><br></font></div><div class=3D"gmail_default"><font fac=
e=3D"arial, helvetica, sans-serif"><div class=3D"gmail_default">The tunnels=
 is getting up and it works greatly, but only in one direction - from Windo=
ws Server 2012 R2 to Windows Server 2016.</div><div class=3D"gmail_default"=
>I&#39;ve been using such server-client configurations setup for several ye=
ars with Windows Server 2012 R2 servers and I&#39;ve never faced such issue=
 before.</div><div class=3D"gmail_default">At first I thought that our ISP =
has some network limitations, but it turned out that the same tests shows g=
reat network speed results using the public IP addresses in both directions=
.</div><div class=3D"gmail_default">The issue only occurs inside the VPN tu=
nnel. I&#39;ve spent 3 days tryng to figure it out, but failed. I&#39;ve in=
stalled all latest Windows updates, reinstalled OpenVPN, tried to switch fr=
om UDP to TCP,</div><div class=3D"gmail_default">played with performance se=
ttings in configs (link-mtu, sndbuf, rcvbuf etc) but still no luck. I&#39;v=
e tested the same setup between two Windows Server 2012 R2 servers and it w=
orks greatly in both directions.</div><div class=3D"gmail_default">Then I&#=
39;ve tested it with another Windows Server 2016 Standard server (different=
 server and different ISP) and it showed the same awful results in outbound=
 direction.</div><div class=3D"gmail_default">When I&#39;ve set the same Op=
enVPN tunnel between two Windows Server 2016 Standard servers I&#39;ve got =
the same poor network speed in both directions.</div></font></div><div clas=
s=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif"><br></font>=
</div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-ser=
if"><div class=3D"gmail_default">I believe that the issue is somehow relate=
d only to the Windows Server 2016 version and I am more than confident that=
 it depends on server&#39;s TCP stack settings.</div><div class=3D"gmail_de=
fault">I&#39;ve noticed that Windows Server 2016 has a congestion control p=
rovider setting set to &quot;default&quot;, while previous versions of Wind=
ows has this setting set to &quot;none&quot;.</div></font></div><div class=
=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif"><br></font><=
/div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-seri=
f">I&#39;ve created a topic on OpenVPN Support Forum and it was suggested t=
o post my issue to you and reference the thread.</font></div><div class=3D"=
gmail_default"><font face=3D"arial, helvetica, sans-serif"><br></font></div=
><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">Y=
ou can reference to the <a href=3D"https://forums.openvpn.net/viewtopic.php=
?f=3D6&amp;t=3D27173" target=3D"_blank">https://forums.openvpn.net/viewtopi=
c.php?f=3D6&amp;t=3D27173</a>=C2=A0for config files and additional informat=
ion.</font><br clear=3D"all"></div><div><br></div><div><div class=3D"gmail_=
default" style=3D"font-family:arial,helvetica,sans-serif">Have you faced a =
similar issue before? Can you provide any hint how can I resolve the issue?=
 What did I missed?</div><div class=3D"gmail_default" style=3D"font-family:=
arial,helvetica,sans-serif">I would be very grateful for any help. Thank yo=
u in advance.</div><br></div><div><br></div>-- <br><div dir=3D"ltr" class=
=3D"m_-5061142619719305404m_7016428550422907693m_-4766676076946984635m_-272=
9697033681776833gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><di=
v><div dir=3D"ltr"><div><div dir=3D"ltr"><p style=3D"margin:0in 0in 0.0001p=
t;font-size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:1=
2pt;color:rgb(89,89,89)">Best regards,</span></p><p style=3D"margin:0in 0in=
 0.0001pt;font-family:Calibri,sans-serif"><font color=3D"#595959"><span sty=
le=3D"font-size:16px"><b>Rostyslav Maryliak</b></span></font></p><p style=
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
/span><span lang=3D"RU" style=3D"font-size:12pt;color:rgb(35,176,24)"><a hr=
ef=3D"http://www.idealscorp.com/" style=3D"color:rgb(17,85,204)" target=3D"=
_blank"><span lang=3D"EN-US" style=3D"color:rgb(35,176,24)">www.idealsvdr.c=
om</span></a></span></p></div></div></div></div></div></div></div></div></d=
iv></div></div></div></div></div>

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
 class=3D"m_-5061142619719305404m_7016428550422907693gmail_signature" data-=
smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><=
div dir=3D"ltr"><div><div dir=3D"ltr"><p style=3D"margin:0in 0in 0.0001pt;f=
ont-size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:12pt=
;color:rgb(89,89,89)">Best regards,</span></p><p style=3D"margin:0in 0in 0.=
0001pt;font-family:Calibri,sans-serif"><font color=3D"#595959"><span style=
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

--00000000000075c5bd057764ecac--

