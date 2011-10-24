Date: Mon, 24 Oct 2011 12:22:04 +0200
From: Davide Brini <dave_br@...1278...>
Message-ID: <20111024122204.5a520051@...1506...>
In-Reply-To: <4EA538F5.5060002@...1114...>
References: <1316452741-4080-1-git-send-email-dave_br@...1278...>
	<4EA538F5.5060002@...1114...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] When using multihome,
 create environment variables for target IP and interface on the
 server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Mon, 24 Oct 2011 12:07:49 +0200, David Sommerseth
<openvpn.list@...1114...> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 19/09/11 19:19, Davide Brini wrote:
> > Signed-off-by: Davide Brini <dave_br@...1278...>
> > 
> > This patch creates two new environment variables: "multihome_iface"
> > and "multihome_ip", which contain respectively the interface name and
> > IP address where the client connection came in, so scripts can use
> > them.
> > 
> > Tested on IPv4, "works for me". The patch is against the master
> > branch.
> 
> Which platforms have this been tested on?  Linux, *BSD? ... not a
> requirement, but would be good to know if there are more platforms this
> should be tested on explicitly.


Only Linux I'm afraid, although I tried to preserve the necessary
#ifdef's (read: copied them from other places) so it should use the
relevant structures (IP_RECVDSTADDR etc.) when running on *BSD.
But tested only on Linux. Of course, more testing is always welcome.


> > Besides the style issues or the errors that surely this patch
> > contains, I have some questions:
> > 
> > - Is this (ie, function link_socket_connection_initiated()) the right
> > place to do it?
> 
> At a cursory glance, this looks like a relevant place.  But I'm not that
> familiar with socket handling in OpenVPN.  And socket.c is a dreadful
> place to be.
> 
> > - Currently it uses the same variable names for IPv4 and IPv6; would
> > using multihome_ip and multihome_ip6 make more sense, for example? (I
> > don't think so, but asking for confirmation)
> 
> I think it makes sense to use the same variable for both.  However, I'm
> not convinced the 'multihome' prefix is appropriate.  Yes, it is
> multihome related, feature wise.  But a more generic prefix might be
> better.  F.ex. like 'client_conn_ip' and 'client_conn_iface' (or
> something like that) is more explicit in what the variable will contain.

Sure, I used multihome_* because this came up in that context, but of
course other names may be better (that's why I asked in the first place).


> > - For consistency, I think it would be nice to set the same variables
> > even when --multihome is not in effect. However, as it is now, OpenVPN
> > explicitly checks for --multihome and if it's not set, it doesn't set
> > the IP_PKTINFO/IP_RECVDSTADDR option in the socket, so that
> > information is not always available (hence the addr_defined_ipi()
> > check is needed). Any reason why this is so? What would be the problem
> > in always setting IP_PKTINFO/IP_RECVDSTADDR (if supported by the
> > platform, of course)?
> > 
> > - Again for consistency, the same variables could/should be set for
> > TCP connections, however I have no idea where to look for that (I
> > don't even know whether link_socket_connection_initiated() is called
> > at all when using TCP). Any suggestions?
> 
> Well, the challenge here is that --multihome is only suitable in UDP
> mode, iirc.  So most likely many of these multihome code paths are
> avoided when running in TCP mode.
> 
> Maybe in the areas around multo_process_* functions would be a better
> place to implement this then ... not sure, just thinking aloud.

When using TCP, you get multihome for free, so to speak, as TCP
automatically works the way UDP --multihome works (in fact, "switch to
using TCP" was the suggestion given to people before --multihome for UDP was
introduced).

What I'd like to have is a couple of variables that contain the target IP
address and interface a given client connection is using, regardless of
whether the connection is using TCP, UDP, or the server has multiple
interfaces or not. I understand these variables would be most useful when
the server can receive connections on multiple interfaces, but I think it
wouldn't hurt and would be more consistent to always set them regardless.

Thanks!

-- 
D.

