From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Setting source address for UDP replies on multihomed server
References: <16622.28948.53644.813410@...253...>
In-Reply-To: <16622.28948.53644.813410@...253...>
MIME-Version: 1.0
Message-Id: <200407130207.31723.jim@...41...>
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
Date: Tue Jul 13 00:07:07 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: Neil Brown <neilb@...253...>

On Friday 09 July 2004 05:19, Neil Brown wrote:
> My server that I hope to use as an OPENVPN server is multi-homed.
> i.e. it has multiple network interfaces and multiple addresses on
> multiple subnets.
>
> When my openvpn client (on my notebook) tries to talk to it, it
> sometimes gets a reply from a different IP address than it sent the
> request to, and it doesn't like that.
> This can be alleviated by using the --float option.  However that
> isn't a complete solution.
>
> When I try using openvpn from home, behind a NAT (masquerading) firewall,
> the reply from a different IP address doesn't get back to me, as the
> firewall doesn't know where to route those UDP packets.
>
> The "correct" solution would be to have openvpn get the destination
> address that was used for each incoming packet, record that, and set
> is as the source address when sending a reply.
>
> This is relatively easy to do (at least in Linux, possibly other POSIX
> os's).  The code link_socket_read_udp_posix in the patch below
> successfully gets the destination address, and the code added to
> link_socket_write_udp_posix sets the source address properly.
> I have checked this by removing the "if (0)" in the latter function,
> so the address is passed around in a global variable.
>
> Where I am having trouble is in tracing the path that an address takes
> when it is extract from an incoming packets, and then used to direct
> an outgoing reply.  As you can see from the patch below, I have tried
> to carry the extra address around various places, but I still haven't
> got it to work.
>
> I admit that the code as it is (apart from not working) is rather
> ugly.  It would probably be best to define a new structure that
> contains both the Local and Remote addresses, and pass that around as
> necessary.  But first I would like to get it to work.
>
> So my request is:
>   What am I missing?  Where else to I need to pass around the
>   local-endpoint address?

I think you have the right idea.

You want to make a new sockaddr_in in struct link_socket_info to hold the 
destination address of received datagrams which will then be used as the 
source address of sent datagrams.

link_socket_get_outgoing_addr is called to save the destination address for 
future outgoing datagrams, based on the source address of a recently received 
datagram which has successfully authenticated.  Here you also want to save 
the destination address of the received datagram in your new link_socket_info 
member.

link_socket_set_outgoing_addr is called to get the previously saved 
destination address for a pending outgoing packet.  Here you can get your 
previously saved source address for the outgoing packet as well.

James

