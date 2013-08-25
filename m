Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
From: Abdullah Alshalan <aalshala@...1837...>
In-Reply-To: <52192A0E.5090208@...1114...>
Date: Sun, 25 Aug 2013 11:44:47 -0700
Message-Id: <0766BCCF-2FE9-4EAC-82E4-1DF1FED2B9E7@...1837...>
References: <CAMRyNXJVwnk5D8ZK_tN6NQ8BX1+zbn9jWfEWTUDa90g-RNVVDw@...278...>
	<52173B95.6030401@...1227...>
	<761CF777-989D-4F3C-9F10-11C77DF1A73E@...1837...>
	<52192A0E.5090208@...1114...>
Subject: Re: [Openvpn-devel] Implementing a Mobile OpenVPN - questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel-request@lists.sourceforge.net

Thank you David for your informative answers.
When I mentioned FTP it was just an example. what I'm trying to accomplish =
is a mechanism to to allow the VPN to hide the fact that the VPN tunnel is =
broken from the application that uses the VPN tunnel. The VPN can achieve t=
hat by getting its hands dirty with the open sockets the applications on th=
e client side has with the application servers on the other side. When a VP=
N tunnel is broken the VPN client acts like this:
- When it receives a packet from a client application, it caches it if the =
cache isn't full.
- Then sends an ACK in behave of the Application server saying it was recei=
ved.  (not sure about this step)
- If the cache is full it sends TCP window =3D 0 to the client application =
so it stops sending packets.

- The VPN server does the same thing on the other side.
- Once the VPN tunnel is reestablished, the cached packets in both the VPN =
client and the VPN server are sent to the opposite side.
- Once the cache is emptied a TCP window !=3D0 is sent to the application t=
o resume the sending.

What do you think of this?

Also, you said=20
"Yes, I believe this is quite doable with --float.  OpenVPN can be configur=
ed to be quite persistent to reconnect if the timeout has been too long."
"OpenVPN can ensure the client gets the same VPN IP address when re-connect=
in."
Do you know where in the code can I find this done? I wanna have a look at =
it. if you could suggest names of files I look at that would be highly appr=
eciated.

Thank you very much
- Ab

On Aug 24, 2013, at 2:47 PM, David Sommerseth <openvpn.list@...1114...> wro=
te:

> On 24/08/13 21:42, Abdullah Alshalan wrote:
> [...snip...]
>> Let me explain the problem I'm trying to solve with an example:
>>=20
>> User A wants to access an FTP server in his company's private network wh=
ich is
>> sitting behind an OpenVPN server.
>> User A uses a mobile device with an OpenVPN client and and FTP client.
>> User A uses OpenVPN client to establish a VPN tunnel with the company's =
VPN
>> server. User A get's a private IP from the VPN server.
>> User A uses the FTP client to connect to the FTP server establishing an
>> app-to-app channel (socket).
>> User A starts download a very large file.
>> User A is driving his car and going on a road trip. He loses internet co=
nnection.
>> Here is two scenarios:
>>  - User A gets a new internet connection getting new public IP, you're s=
aying
>> with the float option OpenVPN can resume the VPN connection even with th=
e user
>> A's public IP changed?
>>  - What if user A doesn't get his internet connection until after say 2
>> hours,  Normally the VPN connection will timeout and will terminate, hen=
ce the
>> FTP connection will terminate. Right?
>=20
> Yes, I believe this is quite doable with --float.  OpenVPN can be configu=
red to be quite persistent to reconnect if the timeout has been too long.
>=20
> The FTP connection might die, but the OpenVPN client will be able to reco=
nnect (often also via a complete re-establishment of the tunnel).  The FTP =
connection might die due to normal TCP timeouts.  That's outside the scope =
of OpenVPN.  Try un-plugging a network cable for 2 hours and see how well a=
n on-going FTP connection tackles that.
>=20
>>  What I'm trying to do is to find a way to help the FTP client and the F=
TP
>> server to maintain their app-to-app connection while the VPN tunnel is b=
roken.
>=20
> FTP might not depend on a "always" connected mode.  But FTP is also a tri=
cky protocol to play with.  If you can make it work with a physical network=
 with long "down-time", it should work with OpenVPN as well.
>=20
>> When user A (after getting the new internet connection hence new public =
IP)
>> establishes a new VPN connection, getting a new private IP from the VPN
>> server, I want the previous VPN session to be resumed taking in consider=
ation
>> the new public and private IPs of the client.
>=20
> OpenVPN can ensure the client gets the same VPN IP address when re-connec=
ting.  One of my setups even retains the VPN IP address, despite explicit l=
ogin and logouts.  And that is independent of which public IP address the c=
lient has. With this settled, the FTP client won't care about public IPs, j=
ust the VPN IP address.
>=20
>> So what I'm thinking of doing is to make some changes to OpenVPN behavio=
r by
>> doing the following:
>> * when the ftp client wants to establish a socket with the ftp server. i=
nstead
>> of having a direct connection between the ftp client and the ftp server I
>> wanna do the following:
>> * we split that TCP connection (FTP) into three ways:
>> * when the OpenVPN clients see the TCP connection request. It forwards t=
o the
>> Open VPN server asking it to establish an FTP connection between the Ope=
nVPN
>> server and the FTP server.
>> * once the OpenVPN server does that, it tells the OpenVPN client that the
>> connection is established.
>> * notice now the FTP server thinks he's connected to the VPN server so e=
ven if
>> the VPN tunnel breaks that FTP channel between the VPN server and the FTP
>> server is intact.
>> * Also the FTP client can always send it's data which OpenVPN client pic=
k from
>> the tun module. So this also will remain intact if the VPN tunnel is bro=
ken.
>> * Now once the VPN tunnel is broken, both the VPN client and the VPN ser=
ver
>> will have a caching module to cache the FTP client's and the FTP server's
>> packets, once the VPN tunnel is recovered the cached packet will be sent=
 to
>> their destination.
>> * The VPN server will have to account for the changes in the client's IP=
s for
>> sure.
>=20
> This sounds way too complicated.  Seriously, are you sure FTP is the righ=
t protocol for you to use in this scenario?  What about other more stateles=
s protocols?  Or, I mean it might even be that SFTP (SSH based FTP, that is=
) can handle that far easier with some clever client side logic.  Such as:
>=20
>   1. Is file ready to be transfered && do I have access to the remote
>      server?  If no, sleep 60 seconds and goto 1.
>   2. Start file copy.   Did the connection fail during transfer? If yes ->
>      goto 2 (retransmit file)
>   3. Find next file, goto 1.
>=20
> It might even be rsync over OpenVPN will be even better, as that can copy=
 over just the data which the remote side is missing.
>=20
> Making OpenVPN a (FTP) connection proxy and manager (which it sounds like=
 you're looking into).  That sounds like something we do not really want in=
to OpenVPN.
>=20
> Keep it as simple as possible, then it's easier to understand what's goin=
g on when you need to debug failures in the future.
>=20
>> Can you tell me if the current OpenVPN implementation account for that
>> scenario? and How much changes do I have to make to accomplish such a th=
ing?
>> It doesn't have to be perfectly functional this is more of a research an=
d I
>> want to publish my work to the public in case anyone wants to do further
>> development.
>=20
> No, OpenVPN (and basically most VPNs) is basically just a "virtual networ=
k cable over the Internet".  It's really not much more complicated than tha=
t. What makes VPN difficult is encryption and proper routing.  But in pract=
ice, it's almost acting like a network cable.
>=20
>=20
> --=20
>=20
> kind regards,
>=20
> David Sommerseth


