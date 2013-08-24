Content-Type: multipart/alternative;
	boundary="Apple-Mail=_44B17B3F-F7C7-44FA-BE04-2EC1AA5E57E4"
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
From: Abdullah Alshalan <aalshala@...1837...>
In-Reply-To: <52173B95.6030401@...1227...>
Date: Sat, 24 Aug 2013 12:42:19 -0700
Message-Id: <761CF777-989D-4F3C-9F10-11C77DF1A73E@...1837...>
References: <CAMRyNXJVwnk5D8ZK_tN6NQ8BX1+zbn9jWfEWTUDa90g-RNVVDw@...278...>
	<52173B95.6030401@...1227...>
Subject: Re: [Openvpn-devel] Implementing a Mobile OpenVPN - questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel-request@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--Apple-Mail=_44B17B3F-F7C7-44FA-BE04-2EC1AA5E57E4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Arne and everyone,
Thank you for your reply.=20
Ok so first of all I didn't know about this --float option so thank you for=
 pointing that out.=20

Let me explain the problem I'm trying to solve with an example:

User A wants to access an FTP server in his company's private network which=
 is sitting behind an OpenVPN server.
User A uses a mobile device with an OpenVPN client and and FTP client.=20
User A uses OpenVPN client to establish a VPN tunnel with the company's VPN=
 server. User A get's a private IP from the VPN server.
User A uses the FTP client to connect to the FTP server establishing an app=
-to-app channel (socket).
User A starts download a very large file.
User A is driving his car and going on a road trip. He loses internet conne=
ction.
Here is two scenarios:
 - User A gets a new internet connection getting new public IP, you're sayi=
ng with the float option OpenVPN can resume the VPN connection even with th=
e user A's public IP changed?
 - What if user A doesn't get his internet connection until after say 2 hou=
rs,  Normally the VPN connection will timeout and will terminate, hence the=
 FTP connection will terminate. Right?
 What I'm trying to do is to find a way to help the FTP client and the FTP =
server to maintain their app-to-app connection while the VPN tunnel is brok=
en. When user A (after getting the new internet connection hence new public=
 IP) establishes a new VPN connection, getting a new private IP from the VP=
N server, I want the previous VPN session to be resumed taking in considera=
tion the new public and private IPs of the client.

So what I'm thinking of doing is to make some changes to OpenVPN behavior b=
y doing the following:
* when the ftp client wants to establish a socket with the ftp server. inst=
ead of having a direct connection between the ftp client and the ftp server=
 I wanna do the following:
* we split that TCP connection (FTP) into three ways:
* when the OpenVPN clients see the TCP connection request. It forwards to t=
he Open VPN server asking it to establish an FTP connection between the Ope=
nVPN server and the FTP server.
* once the OpenVPN server does that, it tells the OpenVPN client that the c=
onnection is established.
* notice now the FTP server thinks he's connected to the VPN server so even=
 if the VPN tunnel breaks that FTP channel between the VPN server and the F=
TP server is intact.
* Also the FTP client can always send it's data which OpenVPN client pick f=
rom the tun module. So this also will remain intact if the VPN tunnel is br=
oken.
* Now once the VPN tunnel is broken, both the VPN client and the VPN server=
 will have a caching module to cache the FTP client's and the FTP server's =
packets, once the VPN tunnel is recovered the cached packet will be sent to=
 their destination.
* The VPN server will have to account for the changes in the client's IPs f=
or sure.


Can you tell me if the current OpenVPN implementation account for that scen=
ario? and How much changes do I have to make to accomplish such a thing? It=
 doesn't have to be perfectly functional this is more of a research and I w=
ant to publish my work to the public in case anyone wants to do further dev=
elopment.


If my explanation wasn't clear enough please don't hesitate to ask me to cl=
arify any point. I would really appreciate to hear what you think about thi=
s problem.

Thank you Arne,
- Ab
On Aug 23, 2013, at 3:38 AM, Arne Schwabe <arne@...1227...>
 wrote:

> Am 23.08.13 02:48, schrieb Abdullah Alshalan:
>> Hi all,
>> I'm not sure if I'm sending this email to the right development group
>> so I apologize if it's not.
>>=20
>> I'm trying to reach the open vpn development team or anyone who has
>> experience with OpenVPN development.
>> I started working on a project to implement an open-source, true
>> Mobile SSL VPN and I'm finsihed with a detailed framework design. I
>> know OpenVPN has released OpenVPN connect for smart phones but what I
>> want to add is mobility features. Meaning the VPN session survives any
>> network interruptions due tp switching from one network to another,
>> thus getting new IP addresses or during lack of network coverage for
>> some time.
>>=20
>> My question is how big of a project is this going to be? I mean is it
>> something one person can handle or needs a team of experience network
>> programmers?=20
>> Are there any books or any sort of  documentation that helps
>> understand and modify the OpenVPN source code?
>>=20
> I am not quite what you aiming at. OpenVPN does support changing IP
> addresses when both sides use --float.
>=20
> Arne


--Apple-Mail=_44B17B3F-F7C7-44FA-BE04-2EC1AA5E57E4
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html charset=
=3Diso-8859-1"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mo=
de: space; -webkit-line-break: after-white-space; "><span style=3D"color: r=
gb(34, 34, 34); font-family: arial, sans-serif; font-size: 13px; background=
-color: rgb(255, 255, 255); ">Hi Arne and everyone,</span><div style=3D"col=
or: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 13px; backg=
round-color: rgb(255, 255, 255); ">Thank you for your reply.&nbsp;</div><di=
v style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-siz=
e: 13px; background-color: rgb(255, 255, 255); ">Ok so first of all I didn'=
t know about this --float option so thank you for pointing that out.&nbsp;<=
/div><div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; =
font-size: 13px; background-color: rgb(255, 255, 255); "><br></div><div sty=
le=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 13=
px; background-color: rgb(255, 255, 255); ">Let me explain the problem I'm =
trying to solve with an example:</div><div style=3D"color: rgb(34, 34, 34);=
 font-family: arial, sans-serif; font-size: 13px; background-color: rgb(255=
, 255, 255); "><br></div><div style=3D"color: rgb(34, 34, 34); font-family:=
 arial, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255); =
">User A wants to access an FTP server in his company's private network whi=
ch is sitting behind an OpenVPN server.</div><div style=3D"color: rgb(34, 3=
4, 34); font-family: arial, sans-serif; font-size: 13px; background-color: =
rgb(255, 255, 255); ">User A uses a mobile device with an OpenVPN client an=
d and FTP client.&nbsp;</div><div style=3D"color: rgb(34, 34, 34); font-fam=
ily: arial, sans-serif; font-size: 13px; background-color: rgb(255, 255, 25=
5); ">User A uses OpenVPN client to establish a VPN tunnel with the company=
's VPN server. User A get's a private IP from the VPN server.</div><div sty=
le=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 13=
px; background-color: rgb(255, 255, 255); ">User A uses the FTP client to c=
onnect to the FTP server establishing an app-to-app channel (socket).</div>=
<div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-=
size: 13px; background-color: rgb(255, 255, 255); ">User A starts download =
a very large file.</div><div style=3D"color: rgb(34, 34, 34); font-family: =
arial, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255); "=
>User A is driving his car and going on a road trip. He loses internet conn=
ection.</div><div style=3D"color: rgb(34, 34, 34); font-family: arial, sans=
-serif; font-size: 13px; background-color: rgb(255, 255, 255); ">Here is tw=
o scenarios:</div><div style=3D"color: rgb(34, 34, 34); font-family: arial,=
 sans-serif; font-size: 13px; background-color: rgb(255, 255, 255); ">&nbsp=
;- User A gets a new internet connection getting new public IP, you're sayi=
ng with the float option OpenVPN can resume the VPN connection even with th=
e user A's public IP changed?</div><div style=3D"color: rgb(34, 34, 34); fo=
nt-family: arial, sans-serif; font-size: 13px; background-color: rgb(255, 2=
55, 255); ">&nbsp;- What if user A doesn't get his internet connection unti=
l after say 2 hours,&nbsp;&nbsp;Normally the VPN connection will timeout an=
d will terminate, hence the FTP connection will terminate. Right?</div><div=
 style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size=
: 13px; background-color: rgb(255, 255, 255); ">&nbsp;What I'm trying to do=
 is to find a way to help the FTP client and the FTP server to maintain the=
ir app-to-app connection while the VPN tunnel is broken. When user A (after=
 getting the new internet connection hence new public IP) establishes a new=
 VPN connection, getting a new private IP from the VPN server, I want the p=
revious VPN session to be resumed taking in consideration the new public an=
d private IPs of the client.</div><div style=3D"color: rgb(34, 34, 34); fon=
t-family: arial, sans-serif; font-size: 13px; background-color: rgb(255, 25=
5, 255); "><br></div><div style=3D"color: rgb(34, 34, 34); font-family: ari=
al, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255); ">So=
 what I'm thinking of doing is to make some changes to OpenVPN behavior by =
doing the following:</div><div style=3D"color: rgb(34, 34, 34); font-family=
: arial, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);=
 ">* when the ftp client wants to establish a socket with the ftp server. i=
nstead of having a direct connection between the ftp client and the ftp ser=
ver I wanna do the following:</div><div style=3D"color: rgb(34, 34, 34); fo=
nt-family: arial, sans-serif; font-size: 13px; background-color: rgb(255, 2=
55, 255); ">* we split that TCP connection (FTP) into three ways:</div><div=
 style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size=
: 13px; background-color: rgb(255, 255, 255); ">* when the OpenVPN clients =
see the TCP connection request. It forwards to the Open VPN server asking i=
t to establish an FTP connection between the OpenVPN server and the FTP ser=
ver.</div><div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-se=
rif; font-size: 13px; background-color: rgb(255, 255, 255); ">* once the Op=
enVPN server does that, it tells the OpenVPN client that the connection is =
established.</div><div style=3D"color: rgb(34, 34, 34); font-family: arial,=
 sans-serif; font-size: 13px; background-color: rgb(255, 255, 255); ">* not=
ice now the FTP server thinks he's connected to the VPN server so even if t=
he VPN tunnel breaks that FTP channel between the VPN server and the FTP se=
rver is intact.</div><div style=3D"color: rgb(34, 34, 34); font-family: ari=
al, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255); ">* =
Also the FTP client can always send it's data which OpenVPN client pick fro=
m the tun module. So this also will remain intact if the VPN tunnel is brok=
en.</div><div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-ser=
if; font-size: 13px; background-color: rgb(255, 255, 255); ">* Now once the=
 VPN tunnel is broken, both the VPN client and the VPN server will have a c=
aching module to cache the FTP client's and the FTP server's packets, once =
the VPN tunnel is recovered the cached packet will be sent to their destina=
tion.</div><div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-s=
erif; font-size: 13px; background-color: rgb(255, 255, 255); ">* The VPN se=
rver will have to account for the changes in the client's IPs for sure.</di=
v><div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; fon=
t-size: 13px; background-color: rgb(255, 255, 255); "><br></div><div style=
=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 13px=
; background-color: rgb(255, 255, 255); "><br></div><div style=3D"color: rg=
b(34, 34, 34); font-family: arial, sans-serif; font-size: 13px; background-=
color: rgb(255, 255, 255); ">Can you tell me if the current OpenVPN impleme=
ntation account for that scenario? and How much changes do I have to make t=
o accomplish such a thing? It doesn't have to be perfectly functional this =
is more of a research and I want to publish my work to the public in case a=
nyone wants to do further development.</div><div style=3D"color: rgb(34, 34=
, 34); font-family: arial, sans-serif; font-size: 13px; background-color: r=
gb(255, 255, 255); "><br></div><div style=3D"color: rgb(34, 34, 34); font-f=
amily: arial, sans-serif; font-size: 13px; background-color: rgb(255, 255, =
255); "><br></div><div style=3D"color: rgb(34, 34, 34); font-family: arial,=
 sans-serif; font-size: 13px; background-color: rgb(255, 255, 255); ">If my=
 explanation wasn't clear enough please don't hesitate to ask me to clarify=
 any point. I would really appreciate to hear what you think about this pro=
blem.</div><div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-s=
erif; font-size: 13px; background-color: rgb(255, 255, 255); "><br></div><d=
iv style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-si=
ze: 13px; background-color: rgb(255, 255, 255); ">Thank you Arne,</div><div=
 style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size=
: 13px; background-color: rgb(255, 255, 255); ">- Ab</div><div><div>On Aug =
23, 2013, at 3:38 AM, Arne Schwabe &lt;<a href=3D"mailto:arne@...1227...">a=
rne@...1227...</a>&gt;</div><div>&nbsp;wrote:</div><br class=3D"Apple-inter=
change-newline"><blockquote type=3D"cite">Am 23.08.13 02:48, schrieb Abdull=
ah Alshalan:<br><blockquote type=3D"cite">Hi all,<br>I'm not sure if I'm se=
nding this email to the right development group<br>so I apologize if it's n=
ot.<br><br>I'm trying to reach the open vpn development team or anyone who =
has<br>experience with OpenVPN development.<br>I started working on a proje=
ct to implement an open-source, true<br>Mobile SSL VPN and I'm finsihed wit=
h a detailed framework design. I<br>know OpenVPN has released OpenVPN conne=
ct for smart phones but what I<br>want to add is mobility features. Meaning=
 the VPN session survives any<br>network interruptions due tp switching fro=
m one network to another,<br>thus getting new IP addresses or during lack o=
f network coverage for<br>some time.<br><br>My question is how big of a pro=
ject is this going to be? I mean is it<br>something one person can handle o=
r needs a team of experience network<br>programmers? <br>Are there any book=
s or any sort of &nbsp;documentation that helps<br>understand and modify th=
e OpenVPN source code?<br><br></blockquote>I am not quite what you aiming a=
t. OpenVPN does support changing IP<br>addresses when both sides use --floa=
t.<br><br>Arne<br></blockquote></div><br></body></html>=

--Apple-Mail=_44B17B3F-F7C7-44FA-BE04-2EC1AA5E57E4--

