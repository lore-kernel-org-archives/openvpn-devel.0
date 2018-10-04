MIME-Version: 1.0
References: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
 <CAFHpkQG10QOhGUb4R4VyPHwCNMfkVSQgCVgmypsBidsgNcsBaw@...278...>
In-Reply-To: <CAFHpkQG10QOhGUb4R4VyPHwCNMfkVSQgCVgmypsBidsgNcsBaw@...278...>
From: Rostyslav Maryliak <rostyslav.maryliak@...2454...>
Date: Thu, 4 Oct 2018 11:57:26 +0300
Message-ID: <CADkMwqQ+F-rLr3V5_BxjixbvnyOW6T+Y6tP---3PBaOcHkRBpA@...278...>
Content-Type: multipart/alternative; boundary="000000000000338b530577635a18"
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

--000000000000338b530577635a18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Ilya,

I've checked "Get-NetTCPConnection" command output on both win2012r2 and
win2016 servers.

win2012r2 server works as OpenVPN server. Internal IP address - 10.0.4.1.
OpenVPN tunnel IP address - 172.16.144.1
win2016 server works as OpenVPN client. Internal IP address - 10.0.44.1.
OpenVPN tunnel IP address - 172.16.144.18


*From win2012r2 server:*

PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress 10.0.44.1
LocalAddress                        LocalPort          RemoteAddress
         RemotePort             State                  AppliedSetting
------------                               ---------
 -------------                           ----------
-----                     --------------
172.16.144.1                         56437               10.0.44.1
                  53005                      Established        *Datacenter*

PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress 172.16.144.18
LocalAddress                       LocalPort           RemoteAddress
         RemotePort             State                  AppliedSetting
------------                               ---------
 -------------                           ----------
-----                     --------------
10.0.4.1                                11616                172.16.144.18
                  56882                      Established        *Datacenter*
10.0.4.1                                11616                172.16.144.18
                  56905                      Established        *Datacenter*



*From win2016 server:*

PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress 10.0.4.1
LocalAddress                       LocalPort           RemoteAddress
         RemotePort             State                 AppliedSetting
   OwningProcess
------------                               ---------
 -------------                           ----------
 -----                   --------------                 -------------
172.16.144.18                      56905                10.0.4.1
                 11616                       Established       * Internet *
                 13300
172.16.144.18                      56882                10.0.4.1
                 11616                       Established       * Internet  *
                13300


PS C:\Users\Administrator> Get-NetTCPConnection -RemoteAddress 172.16.144.1
LocalAddress                       LocalPort           RemoteAddress
         RemotePort             State                 AppliedSetting
   OwningProcess
------------                               ---------
 -------------                           ----------
-----                    --------------                 -------------
10.0.44.1                              53005                172.16.144.1
                  56437                      Established       *Internet*
                    13300


I've changed the "AppliedSetting" value to Datacenter on win2016 server as
well by running this commands and restarting the VPN:
New-NetTransportFilter -SettingName Datacenter -DestinationPrefix
10.0.4.0/24
New-NetTransportFilter -SettingName Datacenter -DestinationPrefix
172.16.144.0/24

Now it shows Datacenter on both servers. But the network speed remains the
same. My changes do not affect the issue.
I've noticed that global TCP settings influence that, especially "Chimney
Offload", "Congestion Control Provider" and "ECN Capability":

C:\Users\Administrator> netsh int tcp show global
Querying active state...

TCP Global Parameters
----------------------------------------------
Receive-Side Scaling State                   : enabled
Chimney Offload State                          : disabled
NetDMA State                                       : disabled
Direct Cache Access (DCA)                  : disabled
Receive Window Auto-Tuning Level     : normal
Add-On Congestion Control Provider   : default
ECN Capability                                      : enabled
RFC 1323 Timestamps                         : disabled
Initial RTO                                             : 3000
Receive Segment Coalescing State     : enabled
Non Sack Rtt Resiliency                       : disabled
Max SYN Retransmissions                   : 2
TCP Fast Open                                     : disabled


That is why I believe that the root cause of the issue lies in "Congestion
Control Provider" setting. But I am unable to change it

On Thu, Oct 4, 2018 at 7:50 AM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> Hello,
>
> can you do some things and tell us your observation ?
>
> starting with win2012 so called network profiles were introduced (Internet
> / Intranet / Datacenter)
> those profiles are very different for tcp connection (if you observe
> degradation in case of udp, most probably that is not related)
>
>
> so, let's start
>
> start powershell (I assume you are familiar)
> call
>
> Get-NetTCPConnection
>
> pay attention to "AppliedSetting" column.
> what's there  ?
>
> we did observe strange things when win2012 classified some traffic as
> "Internet" and appropriate tcp settings were applied.
>
> is there some correlation in your case ?
>
> =D1=81=D1=80, 3 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 20:45, Rostyslav =
Maryliak <
> rostyslav.maryliak@...2454...>:
>
>> Dear OpenVPN developers,
>>
>> I've faced a very strange issue with slow outbound network speed from
>> Windows Server 2016 Standard server via the OpenVPN tunnel.
>> OpenVPN server is Windows Server 2012 R2, client is Windows Server 2016.
>> The inbound network speed for Windows Server 2016 is great.
>> But the outbound network speed is nearly 30-40 kbps. I've got the same
>> results using several tests: iperf testings, file download via SMB,
>> Web-based downloading (using HTTP) etc.
>>
>> The tunnels is getting up and it works greatly, but only in one direction
>> - from Windows Server 2012 R2 to Windows Server 2016.
>> I've been using such server-client configurations setup for several years
>> with Windows Server 2012 R2 servers and I've never faced such issue befo=
re.
>> At first I thought that our ISP has some network limitations, but it
>> turned out that the same tests shows great network speed results using t=
he
>> public IP addresses in both directions.
>> The issue only occurs inside the VPN tunnel. I've spent 3 days tryng to
>> figure it out, but failed. I've installed all latest Windows updates,
>> reinstalled OpenVPN, tried to switch from UDP to TCP,
>> played with performance settings in configs (link-mtu, sndbuf, rcvbuf
>> etc) but still no luck. I've tested the same setup between two Windows
>> Server 2012 R2 servers and it works greatly in both directions.
>> Then I've tested it with another Windows Server 2016 Standard server
>> (different server and different ISP) and it showed the same awful results
>> in outbound direction.
>> When I've set the same OpenVPN tunnel between two Windows Server 2016
>> Standard servers I've got the same poor network speed in both directions.
>>
>> I believe that the issue is somehow related only to the Windows Server
>> 2016 version and I am more than confident that it depends on server's TCP
>> stack settings.
>> I've noticed that Windows Server 2016 has a congestion control provider
>> setting set to "default", while previous versions of Windows has this
>> setting set to "none".
>>
>> I've created a topic on OpenVPN Support Forum and it was suggested to
>> post my issue to you and reference the thread.
>>
>> You can reference to the
>> https://forums.openvpn.net/viewtopic.php?f=3D6&t=3D27173 for config files
>> and additional information.
>>
>> Have you faced a similar issue before? Can you provide any hint how can I
>> resolve the issue? What did I missed?
>> I would be very grateful for any help. Thank you in advance.
>>
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
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
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

--000000000000338b530577635a18
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,helvetica=
,sans-serif">Dear Ilya,</div><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" styl=
e=3D"font-family:arial,helvetica,sans-serif">I&#39;ve checked &quot;<span s=
tyle=3D"font-family:Arial,Helvetica,sans-serif">Get-NetTCPConnection</span>=
&quot; command output on both win2012r2 and win2016 servers.</div><div clas=
s=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></=
div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-=
serif">win2012r2 server works as OpenVPN server. Internal IP address - 10.0=
.4.1. OpenVPN tunnel IP address - 172.16.144.1</div><div class=3D"gmail_def=
ault" style=3D"font-family:arial,helvetica,sans-serif">win2016 server works=
 as OpenVPN client. Internal IP address - 10.0.44.1. OpenVPN tunnel IP addr=
ess - 172.16.144.18</div><div class=3D"gmail_default" style=3D"font-family:=
arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D=
"font-family:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_defa=
ult" style=3D"font-family:arial,helvetica,sans-serif"><b>From win2012r2 ser=
ver:</b></div><div class=3D"gmail_default" style=3D"font-family:arial,helve=
tica,sans-serif"><br></div><div class=3D"gmail_default"><font face=3D"arial=
, helvetica, sans-serif">PS C:\Users\Administrator&gt; Get-NetTCPConnection=
 -RemoteAddress 10.0.44.1</font></div><div class=3D"gmail_default"><span st=
yle=3D"font-family:arial,helvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Local=
Port=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RemoteAddress=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 AppliedSetting</span><br></div><div class=3D"gmail_defaul=
t"><font face=3D"arial, helvetica, sans-serif">------------=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0---------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0-------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0----------=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -----=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--------------</=
font></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, san=
s-serif">172.16.144.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A056437=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A010.0.44.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 53005=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Established=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <b>Datacenter</b></font></div><div class=3D"gma=
il_default"><font face=3D"arial, helvetica, sans-serif"><br></font></div><d=
iv class=3D"gmail_default"><span style=3D"font-family:arial,helvetica,sans-=
serif">PS C:\Users\Administrator&gt; Get-NetTCPConnection -RemoteAddress 17=
2.16.144.18</span><br></div><div class=3D"gmail_default"><span style=3D"fon=
t-family:arial,helvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LocalPort=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemoteAddress=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AppliedSetting</span><br></div><div class=3D"gmail_default"><fon=
t face=3D"arial, helvetica, sans-serif">------------=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0---------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0-------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0----------=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -----=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--------------</font></=
div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif=
">10.0.4.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11616=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 172.16.144.18=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 56882=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Established=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <b>Datacenter</b></font></div><div class=3D"gmail_default"><f=
ont face=3D"arial, helvetica, sans-serif">10.0.4.1=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 11616=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
172.16.144.18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 56905=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 Established=C2=A0 =C2=A0 =C2=A0 =C2=A0 <b>Datacenter</b></fo=
nt><span style=3D"font-family:arial,helvetica,sans-serif">=C2=A0=C2=A0<br><=
/span></div><div class=3D"gmail_default"><span style=3D"font-family:arial,h=
elvetica,sans-serif"><br></span></div><div class=3D"gmail_default"><span st=
yle=3D"font-family:arial,helvetica,sans-serif"><br></span></div><div class=
=3D"gmail_default"><b style=3D"font-family:arial,helvetica,sans-serif">From=
 win2016 server:</b>=C2=A0=C2=A0<span style=3D"font-family:arial,helvetica,=
sans-serif"><br></span></div><div class=3D"gmail_default"><br></div><div cl=
ass=3D"gmail_default"><div class=3D"gmail_default"><font face=3D"arial, hel=
vetica, sans-serif">PS C:\Users\Administrator&gt; Get-NetTCPConnection -Rem=
oteAddress 10.0.4.1</font></div><div class=3D"gmail_default"><span style=3D=
"font-family:arial,helvetica,sans-serif">LocalAddress=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LocalPort=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemoteAddress=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RemotePort=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0AppliedSetting=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OwningP=
rocess</span><br></div><div class=3D"gmail_default"><font face=3D"arial, he=
lvetica, sans-serif">------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0------=
---=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0----------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------</font></div><div class=3D"g=
mail_default"><font face=3D"arial, helvetica, sans-serif">172.16.144.18=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5=
6905=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10.0.4.1=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A011616=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Established=C2=A0 =C2=A0 =C2=A0 =C2=
=A0<b> Internet=C2=A0</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A013300</font></div><div class=3D"gmail_default"><font fa=
ce=3D"arial, helvetica, sans-serif">172.16.144.18=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 56882=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10.0.4.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A011616=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Established=C2=A0 =C2=A0 =C2=A0 =C2=A0<b> Internet=C2=A0 <=
/b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 13300</fo=
nt></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-=
serif"><br></font></div><div class=3D"gmail_default"><font face=3D"arial, h=
elvetica, sans-serif"><br></font></div><div class=3D"gmail_default"><font f=
ace=3D"arial, helvetica, sans-serif">PS C:\Users\Administrator&gt; Get-NetT=
CPConnection -RemoteAddress 172.16.144.1</font></div><div class=3D"gmail_de=
fault"><span style=3D"font-family:arial,helvetica,sans-serif">LocalAddress=
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
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -----=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --------------=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------------</font>=
</div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-ser=
if">10.0.44.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 53005=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 172.16.144.1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 56437=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Established=C2=A0 =C2=A0 =
=C2=A0 =C2=A0<b>Internet</b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 13300</font></div><div class=3D"gmail_defau=
lt"><font face=3D"arial, helvetica, sans-serif"><br></font></div><div class=
=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif"><br></font><=
/div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-seri=
f">I&#39;ve changed the &quot;AppliedSetting&quot; value to Datacenter on w=
in2016 server as well by running this commands and restarting the VPN:</fon=
t></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-s=
erif">New-</font><span style=3D"font-family:arial,helvetica,sans-serif">Net=
TransportFilter -SettingName Datacenter -DestinationPrefix <a href=3D"http:=
//10.0.4.0/24">10.0.4.0/24</a></span></div><div class=3D"gmail_default"><sp=
an style=3D"font-family:arial,helvetica,sans-serif">New-NetTransportFilter =
-SettingName Datacenter -DestinationPrefix <a href=3D"http://172.16.144.0/2=
4">172.16.144.0/24</a></span>=C2=A0=C2=A0<span style=3D"font-family:arial,h=
elvetica,sans-serif"><br></span></div><div class=3D"gmail_default"><br></di=
v><div class=3D"gmail_default">Now it shows Datacenter on both servers. But=
 the network speed remains the same. My changes do not affect the issue.</d=
iv><div class=3D"gmail_default">I&#39;ve noticed that global TCP settings i=
nfluence that, especially &quot;Chimney Offload&quot;, &quot;Congestion Con=
trol Provider&quot; and &quot;ECN Capability&quot;:</div><div class=3D"gmai=
l_default"><br></div><div class=3D"gmail_default"><div class=3D"gmail_defau=
lt"><span style=3D"font-family:arial,helvetica,sans-serif">C:\Users\Adminis=
trator&gt;=C2=A0</span>netsh int tcp show global</div><div class=3D"gmail_d=
efault">Querying active state...</div><div class=3D"gmail_default"><br></di=
v><div class=3D"gmail_default">TCP Global Parameters</div><div class=3D"gma=
il_default">----------------------------------------------</div><div class=
=3D"gmail_default">Receive-Side Scaling State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: enabled</div><div class=3D"gmail=
_default">Chimney Offload State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : disabled</div><div class=
=3D"gmail_default">NetDMA State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0: disabled</div><div class=3D"gmail_default">Direct=
 Cache Access (DCA)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 : disabled</div><div class=3D"gmail_default">Receive Window Auto-Tun=
ing Level=C2=A0 =C2=A0 =C2=A0: normal</div><div class=3D"gmail_default">Add=
-On Congestion Control Provider=C2=A0 =C2=A0: default</div><div class=3D"gm=
ail_default">ECN Capability=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 : enabled</div><div class=3D"gmail_default">RFC 1323 Timestamps=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0: disabled</div><div class=3D"gmail_default">Initial RTO=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0: 3000</div><div class=3D"gmail_default">Receive Segment Coale=
scing State=C2=A0 =C2=A0 =C2=A0: enabled</div><div class=3D"gmail_default">=
Non Sack Rtt Resiliency=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: disabled</div><div class=3D"gmail_default"=
>Max SYN Retransmissions=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0: 2</div><div class=3D"gmail_default">TCP Fast Open=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: disabled</div><div=
 class=3D"gmail_default"><br></div><div class=3D"gmail_default"><br></div><=
div class=3D"gmail_default">That is why I believe that the root cause of th=
e issue lies in &quot;Congestion Control Provider&quot; setting. But I am u=
nable to change it</div></div></div></div></div></div></div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Oct 4, 2018 at 7:50 AM =D0=
=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a hre=
f=3D"mailto:chipitsine@...277...">chipitsine@...277...</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hello,</div><div><=
br></div><div>can you do some things and tell us your observation ?</div><d=
iv><br></div><div>starting with win2012 so called network profiles were int=
roduced (Internet / Intranet / Datacenter)</div><div>those profiles are ver=
y different for tcp connection (if you observe degradation in case of udp, =
most probably that is not related)</div><div><br></div><div><br></div><div>=
so, let&#39;s start</div><div><br></div><div>start powershell (I assume you=
 are familiar)</div><div>call</div><div><br></div><div>Get-NetTCPConnection=
</div><div><br></div><div>pay attention to &quot;AppliedSetting&quot; colum=
n.</div><div>what&#39;s there=C2=A0 ?</div><div><br></div><div>we did obser=
ve strange things when win2012 classified some traffic as &quot;Internet&qu=
ot; and appropriate tcp settings were applied.</div><div><br></div><div>is =
there some correlation in your case ?<br></div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr">=D1=81=D1=80, 3 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =
=D0=B2 20:45, Rostyslav Maryliak &lt;<a href=3D"mailto:rostyslav.maryliak@...220...=
..2454..." target=3D"_blank">rostyslav.maryliak@...2454...</a>&gt;:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"g=
mail_default"><font face=3D"arial, helvetica, sans-serif">Dear OpenVPN deve=
lopers,</font></div><div class=3D"gmail_default"><font face=3D"arial, helve=
tica, sans-serif"><br></font></div><div class=3D"gmail_default"><font face=
=3D"arial, helvetica, sans-serif"><div class=3D"gmail_default">I&#39;ve fac=
ed a very strange issue with slow outbound network speed from Windows Serve=
r 2016 Standard server via the OpenVPN tunnel.</div><div class=3D"gmail_def=
ault">OpenVPN server is Windows Server 2012 R2, client is Windows Server 20=
16. The inbound network speed for Windows Server 2016 is great.</div><div c=
lass=3D"gmail_default">But the outbound network speed is nearly 30-40 kbps.=
 I&#39;ve got the same results using several tests: iperf testings, file do=
wnload via SMB, Web-based downloading (using HTTP) etc.</div></font></div><=
div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif"><br=
></font></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, =
sans-serif"><div class=3D"gmail_default">The tunnels is getting up and it w=
orks greatly, but only in one direction - from Windows Server 2012 R2 to Wi=
ndows Server 2016.</div><div class=3D"gmail_default">I&#39;ve been using su=
ch server-client configurations setup for several years with Windows Server=
 2012 R2 servers and I&#39;ve never faced such issue before.</div><div clas=
s=3D"gmail_default">At first I thought that our ISP has some network limita=
tions, but it turned out that the same tests shows great network speed resu=
lts using the public IP addresses in both directions.</div><div class=3D"gm=
ail_default">The issue only occurs inside the VPN tunnel. I&#39;ve spent 3 =
days tryng to figure it out, but failed. I&#39;ve installed all latest Wind=
ows updates, reinstalled OpenVPN, tried to switch from UDP to TCP,</div><di=
v class=3D"gmail_default">played with performance settings in configs (link=
-mtu, sndbuf, rcvbuf etc) but still no luck. I&#39;ve tested the same setup=
 between two Windows Server 2012 R2 servers and it works greatly in both di=
rections.</div><div class=3D"gmail_default">Then I&#39;ve tested it with an=
other Windows Server 2016 Standard server (different server and different I=
SP) and it showed the same awful results in outbound direction.</div><div c=
lass=3D"gmail_default">When I&#39;ve set the same OpenVPN tunnel between tw=
o Windows Server 2016 Standard servers I&#39;ve got the same poor network s=
peed in both directions.</div></font></div><div class=3D"gmail_default"><fo=
nt face=3D"arial, helvetica, sans-serif"><br></font></div><div class=3D"gma=
il_default"><font face=3D"arial, helvetica, sans-serif"><div class=3D"gmail=
_default">I believe that the issue is somehow related only to the Windows S=
erver 2016 version and I am more than confident that it depends on server&#=
39;s TCP stack settings.</div><div class=3D"gmail_default">I&#39;ve noticed=
 that Windows Server 2016 has a congestion control provider setting set to =
&quot;default&quot;, while previous versions of Windows has this setting se=
t to &quot;none&quot;.</div></font></div><div class=3D"gmail_default"><font=
 face=3D"arial, helvetica, sans-serif"><br></font></div><div class=3D"gmail=
_default"><font face=3D"arial, helvetica, sans-serif">I&#39;ve created a to=
pic on OpenVPN Support Forum and it was suggested to post my issue to you a=
nd reference the thread.</font></div><div class=3D"gmail_default"><font fac=
e=3D"arial, helvetica, sans-serif"><br></font></div><div class=3D"gmail_def=
ault"><font face=3D"arial, helvetica, sans-serif">You can reference to the =
<a href=3D"https://forums.openvpn.net/viewtopic.php?f=3D6&amp;t=3D27173" ta=
rget=3D"_blank">https://forums.openvpn.net/viewtopic.php?f=3D6&amp;t=3D2717=
3</a>=C2=A0for config files and additional information.</font><br clear=3D"=
all"></div><div><br></div><div><div class=3D"gmail_default" style=3D"font-f=
amily:arial,helvetica,sans-serif">Have you faced a similar issue before? Ca=
n you provide any hint how can I resolve the issue? What did I missed?</div=
><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-ser=
if">I would be very grateful for any help. Thank you in advance.</div><br><=
/div><div><br></div>-- <br><div dir=3D"ltr" class=3D"m_-4766676076946984635=
m_-2729697033681776833gmail_signature"><div dir=3D"ltr"><div><div dir=3D"lt=
r"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><p style=3D"margin:0in 0in 0=
.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-=
size:12pt;color:rgb(89,89,89)">Best regards,</span></p><p style=3D"margin:0=
in 0in 0.0001pt;font-family:Calibri,sans-serif"><font color=3D"#595959"><sp=
an style=3D"font-size:16px"><b>Rostyslav Maryliak</b></span></font></p><p s=
tyle=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-ser=
if"><span style=3D"font-size:12pt;color:rgb(89,89,89)">System Administrator=
</span></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:C=
alibri,sans-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89)">=C2=
=A0</span></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-famil=
y:Calibri,sans-serif"><b><span style=3D"font-size:12pt;color:rgb(35,176,24)=
">iDeals=E2=84=A2 Solutions Group</span></b><span style=3D"font-size:12pt;c=
olor:rgb(89,89,89)">|=C2=A0<a href=3D"tel:%2B%2038%28093%29575-35-16" value=
=3D"+380935753516" style=3D"color:rgb(17,85,204)" target=3D"_blank">+ 38(07=
3)437-72-51</a>=C2=A0| Skype: rostyslav.maryliak.ideals|</span><span style=
=3D"color:rgb(31,73,125)">=C2=A0</span><u><span style=3D"font-size:12pt;col=
or:rgb(35,176,24)"><a href=3D"mailto:dmitry.zaporozhchenko@...2454..." styl=
e=3D"color:rgb(17,85,204)" target=3D"_blank"><span style=3D"color:rgb(5,99,=
193)">rostyslav.maryliak@...2454...</span></a></span></u><u><span style=3D"=
color:rgb(35,176,24)">=C2=A0</span></u><span style=3D"font-size:12pt;color:=
rgb(89,89,89)">|</span><span style=3D"font-size:12pt;color:rgb(35,176,24)">=
=C2=A0</span><span lang=3D"RU" style=3D"font-size:12pt;color:rgb(35,176,24)=
"><a href=3D"http://www.idealscorp.com/" style=3D"color:rgb(17,85,204)" tar=
get=3D"_blank"><span lang=3D"EN-US" style=3D"color:rgb(35,176,24)">www.idea=
lsvdr.com</span></a></span></p></div></div></div></div></div></div></div></=
div></div></div></div></div></div></div>

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

--000000000000338b530577635a18--

