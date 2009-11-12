From: Davide Brini <dave_br@...1278...>
Date: Thu, 12 Nov 2009 20:28:07 +0000
References: <1256844344.7529.43.camel@...1272...>
	<1258050832.4308.3.camel@...1272...>
	<4AFC56CC.8080307@...1114...>
In-Reply-To: <4AFC56CC.8080307@...1114...>
MIME-Version: 1.0
Message-Id: <200911122028.07536.dave_br@...1278...>
Subject: Re: [Openvpn-devel] 2.1 rc20 and multiple interfaces problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Thursday 12 November 2009, David Sommerseth wrote:

> On 12/11/09 19:33, Olaf Fraczyk wrote:
> > Hello,
> >
> > No, I wasn't using --multihome - I didn't know that this option exists
> > and that is necessary. I haven't found it in man page and in
> > documentation on the web page. The only place where I found it (after
> > you let me know about it) was with openvpn --help.
> >
> > Thank you, I'll try it.
> > BTW, why is it not by default?
> >
> > Regards,
> >
> > Olaf
> >
> > On Thu, 2009-11-12 at 04:15 -0700, James Yonan wrote:
> >> Are you using the --multihome option?

Sorry to jump in here, but I've run into a weird behavior when using multihome 
in all versions, up to rc15 (I haven't tried later versions, but I guess that 
it would be the same thing since I don't see anything related to this in the 
changelog). I'm using Gentoo on both the client and the server.

In short, it seems that, despite having "multihome" enabled, the server still 
sends replies back to the client out the "wrong" interface, but only under 
certain (not clearly defined) conditions and only after some time(?).

Here is the server config (don't mind IP addresses, this is a lab network):

port 1194
multihome   
proto udp
dev tap0
ca ca.crt
cert server.crt
key server.key
script-security 2
up up.sh
down down.sh
dh dh1024.pem
server-bridge 10.0.1.251 255.255.255.0 10.0.1.10 10.0.1.20
ifconfig-pool-persist ipp.txt
client-to-client
keepalive 10 120
comp-lzo
persist-key
persist-tun
verb 6

And here is the client config:

client
remote 1.1.1.1 1194
remote 2.2.2.2 1194
remote-random
proto udp
dev tap0
ca ca.crt
cert client.crt
key client.key
keepalive 10 120
comp-lzo
persist-key
persist-tun
verb 3

What I've noticed is that the very first connection from a client, regardless 
of the interface it hits, works fine. But for example, if that same client 
disconnects and then reconnects to the other interface (because of the remote-
random option), then the problem happens. However, if another client connects 
second (rather than the first one disconnecting and reconnecting), the second 
client doesn't have problems, regardless of the interface it connects to.
Here is an excerpt of the server log taken during the very first client 
connection:

----------
Thu Nov 12 19:58:16 2009 us=7043 192.168.2.2:1194 TLS: Initial packet from 
192.168.2.2:1194 (via 2.2.2.2), sid=68a926bd 92b98d25
Thu Nov 12 19:58:16 2009 us=7235 192.168.2.2:1194 UDPv4 WRITE [26] to 
192.168.2.2:1194 (via 2.2.2.2): P_CONTROL_HARD_RESET_SERVER_V2 kid=0 [ 0 ] 
pid=0 DATA len=0
....
Thu Nov 12 19:58:16 2009 us=146570 192.168.2.2:1194 Data Channel Encrypt: 
Cipher 'BF-CBC' initialized with 128 bit key
Thu Nov 12 19:58:16 2009 us=146664 192.168.2.2:1194 Data Channel Encrypt: 
Using 160 bit message hash 'SHA1' for HMAC authentication
Thu Nov 12 19:58:16 2009 us=146802 192.168.2.2:1194 Data Channel Decrypt: 
Cipher 'BF-CBC' initialized with 128 bit key
Thu Nov 12 19:58:16 2009 us=146886 192.168.2.2:1194 Data Channel Decrypt: 
Using 160 bit message hash 'SHA1' for HMAC authentication
...
Thu Nov 12 19:58:16 2009 us=151489 192.168.2.2:1194 Control Channel: TLSv1, 
cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 1024 bit RSA
Thu Nov 12 19:58:16 2009 us=151588 192.168.2.2:1194 [Test-Client] Peer 
Connection Initiated with 192.168.2.2:1194 (via 2.2.2.2)
Thu Nov 12 19:58:17 2009 us=181119 Test-Client/192.168.2.2:1194 UDPv4 READ 
[104] from 192.168.2.2:1194 (via 2.2.2.2): P_CONTROL_V1 kid=0 [ ] pid=26 DATA 
len=90
Thu Nov 12 19:58:17 2009 us=181558 Test-Client/192.168.2.2:1194 PUSH: Received 
control message: 'PUSH_REQUEST'
Thu Nov 12 19:58:17 2009 us=181841 Test-Client/192.168.2.2:1194 SENT CONTROL 
[Test-Client]: 'PUSH_REPLY,route-gateway 10.0.1.251,ping 10,ping-restart 
120,ifconfig 10.0.1.10 255.255.255.0' (status=1)
...
Thu Nov 12 19:58:30 2009 us=170924 Test-Client/192.168.2.2:1194 UDPv4 WRITE 
[77] to 192.168.2.2:1194 (via 2.2.2.2): P_DATA_V1 kid=0 DATA len=76
Thu Nov 12 19:58:30 2009 us=172448 Test-Client/192.168.2.2:1194 UDPv4 READ 
[77] from 192.168.2.2:1194 (via 2.2.2.2): P_DATA_V1 kid=0 DATA len=76
Thu Nov 12 19:58:30 2009 us=172747 Test-Client/192.168.2.2:1194 TUN WRITE [42]
-----------

As you can see, the connection keeps using the 2.2.2.2 IP address. The 
connection works fine indeed. So far so good. But here's what happens if the 
client disconnects and reconnects to the other IP address (excerpts):

-----------
Thu Nov 12 19:58:47 2009 us=536468 Test-Client/192.168.2.2:1194 TLS: new 
session incoming connection from 192.168.2.2:1194 (via 1.1.1.1)
Thu Nov 12 19:58:47 2009 us=536712 Test-Client/192.168.2.2:1194 UDPv4 WRITE 
[26] to 192.168.2.2:1194 (via 1.1.1.1): P_CONTROL_HARD_RESET_SERVER_V2 kid=0 [ 
0 ] pid=0 DATA len=0
Thu Nov 12 19:58:47 2009 us=538918 Test-Client/192.168.2.2:1194 UDPv4 READ 
[22] from 192.168.2.2:1194 (via 1.1.1.1): P_ACK_V1 kid=0 [ 0 ]
Thu Nov 12 19:58:47 2009 us=539257 Test-Client/192.168.2.2:1194 UDPv4 READ 
[107] from 192.168.2.2:1194 (via 1.1.1.1): P_CONTROL_V1 kid=0 [ ] pid=1 DATA 
len=93
Thu Nov 12 19:58:47 2009 us=553071 Test-Client/192.168.2.2:1194 UDPv4 WRITE 
[126] to 192.168.2.2:1194 (via 1.1.1.1): P_CONTROL_V1 kid=0 [ 1 ] pid=1 DATA 
len=100
...
Thu Nov 12 19:58:47 2009 us=676688 Test-Client/192.168.2.2:1194 Control 
Channel: TLSv1, cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 1024 bit RSA
Thu Nov 12 19:58:48 2009 us=913316 Test-Client/192.168.2.2:1194 UDPv4 READ 
[104] from 192.168.2.2:1194 (via 1.1.1.1): P_CONTROL_V1 kid=0 [ ] pid=26 DATA 
len=90
Thu Nov 12 19:58:48 2009 us=913880 Test-Client/192.168.2.2:1194 PUSH: Received 
control message: 'PUSH_REQUEST'
Thu Nov 12 19:58:38 2009 us=914158 Test-Client/192.168.2.2:1194 SENT CONTROL 
[Test-Client]: 'PUSH_REPLY,route-gateway 10.0.1.251,ping 10,ping-restart 
120,ifconfig 10.0.1.10 255.255.255.0' (status=1)
Thu Nov 12 19:58:48 2009 us=914437 Test-Client/192.168.2.2:1194 UDPv4 WRITE 
[22] to 192.168.2.2:1194 (via 1.1.1.1): P_ACK_V1 kid=0 [ 26 ]
Thu Nov 12 19:58:48 2009 us=915625 Test-Client/192.168.2.2:1194 UDPv4 WRITE 
[114] to 192.168.2.2:1194 (via 1.1.1.1): P_CONTROL_V1 kid=0 [ ] pid=38 DATA 
len=100
Thu Nov 12 19:58:48 2009 us=916975 Test-Client/192.168.2.2:1194 UDPv4 WRITE 
[68] to 192.168.2.2:1194 (via 1.1.1.1): P_CONTROL_V1 kid=0 [ ] pid=39 DATA 
len=54
...
Thu Nov 12 19:58:55 2009 us=570541 Test-Client/192.168.2.2:1194 UDPv4 READ 
[77] from 192.168.2.2:1194 (via 1.1.1.1): P_DATA_V1 kid=0 DATA len=76
Thu Nov 12 19:58:55 2009 us=570881 Test-Client/192.168.2.2:1194 TUN WRITE [42]
Thu Nov 12 19:58:55 2009 us=571510 Test-Client/192.168.2.2:1194 TUN READ [42]
Thu Nov 12 19:58:55 2009 us=571790 Test-Client/192.168.2.2:1194 UDPv4 WRITE 
[77] to 192.168.2.2:1194 (via 2.2.2.2): P_DATA_V1 kid=0 DATA len=76
-----------

As you can see, the client connection comes in correctly from 1.1.1.1, and all 
the initial negotiation indeed happens using that IP address. The client gets 
to the point where "initialization sequence completed" is printed. 
So everything would look fine up to here.
However, as soon as the client starts sending or receiving actual data over 
the VPN, the server starts sending replies packets via the other interface (as 
you can see from the very last log line above), and of course the client log 
fills with the dreaded message

-----------
Thu Nov 12 19:58:59 2009 TCP/UDP: Incoming packet rejected from 
2.2.2.2:1194[2], expected peer address: 1.1.1.1:1194 (allow this incoming 
source address/port by removing --remote or adding --float)
-----------

Now of course I could use --float on the client, but I think that if multihome 
worked as expected, there would be no need for that.

Looking through the old mailing list posts, I've found this email

http://article.gmane.org/gmane.network.openvpn.user/18805/

that mentions a similar problem, but I'm not sure it's the same one I'm 
seeing. Furthermore, that email is quite old: is that bug still present?

Or, finally, am I doing something wrong (also likely)?

Thank you in advance.

-- 
D.

