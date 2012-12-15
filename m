Message-ID: <50CC4FB8.8040005@...1790...>
Date: Sat, 15 Dec 2012 11:23:52 +0100
From: Tore Anderson <tore@...1790...>
MIME-Version: 1.0
References: <1354303076-13606-1-git-send-email-arne@...1227...>
	<1354303076-13606-10-git-send-email-arne@...1227...>
In-Reply-To: <1354303076-13606-10-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 10/10] Implement dual stack client
	support for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

* Arne Schwabe

> This patch contains a number of changes. I did not further spit this
> since some changes make only sense being changed together.
> 
> Always use connection_list, simplifies the reconnection logic.
> 
> Change meaning of --connect-retry-max and --connect-retry to be used
> all connections. This now allows OpenVPN to quit after n unsuccessful
> udp connection attempts
> 
> Remove the tcp reconnection logic. Failing a TCP connection will now
> cause a USR1 like a UDP connection. Also extend sig->source from bool
> to int to specify signal source. This allows a finer grained
> reconnection logic if necessary in the future.
> 
> Dual-Stack support: if an address resolves to multiple records each
> address is tried in sequential order. Then proceed to next connection
> entry. Introduce the field current_remote to represent the current
> connecting remote. Also change some fields to struct addrinfo* form
> openvn_addr to store multiple addresses needed for the dual stack
> support.
> 
> Change meaning from udp and tcp to allow both IPv4 and IPv6.
> Introducue new udp4 and tcp4 to force IPv4.

ACK, I tested several different fail-over scenarios and all worked fine.
Also all my pre-existing VPNs (maintained by GNOME NetworkManager)
worked just fine.

-- 
Tore Anderson

