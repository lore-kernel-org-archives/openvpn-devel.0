From: Mathias Sundman <mathias@...209...>
Subject: RE: [Openvpn-devel] Same IP subnet on both sides (was: Pass log and
 passphrase between OpenVPN...)
In-Reply-To: <20686C579479DC438276A726FE80CDAA01BC18D3@...281...>
Message-ID: <Pine.LNX.4.60.0410060740240.28549@...210...>
References: <20686C579479DC438276A726FE80CDAA01BC18D3@...281...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Oct  5 22:59:12 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: satinders@...280...
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 6 Oct 2004 satinders@...280... wrote:

Hi Satinder,

Please don't "hijack" a thread like that. Start a new topic if your post 
is un-related to the other current threads.

> Hi,
> 	Currently openvpn demands that in client-server scenario, private
> IPs should not clash with other machines. What if a client with IP 10.19.0.5
> sitting in an ISP network (e.g. internet cafe) is there and server tries to
> assign 10.19.0.5 to this machine. Also there are other machines on 10.19.0.0
> network on ISP side which client wants to access. In this scenario client
> will not be able to access other 10.19.0.0. machines if openvpn is started.

True. This is one of the problems with using private IP addresses 
(RFC1918) that is becomming bigger and bigger while VPNs are becomming 
more and more popular.

When setting up a VPN you MUST take into consideration that the IP subnets 
you use on and behind the server must not be used as the local network by 
any of the clients connecting to your server.


> Do we have any mechanism through which client can find out which 10.19.0.0
> IP is free and then can send request to server to assign this specific IP to
> me? And also it can set the routing itself.

No.


> If this is not the right group to post this type of query then kindly
> suggest me the right one.

I think openvpn-users would have been more appropriate, if you are not 
considering developing any new features...

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail

