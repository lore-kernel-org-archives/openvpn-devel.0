From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] SSL client / SSL server
In-Reply-To: <422C7C95.3080209@...361...>
Message-ID: <Pine.LNX.4.58.0503071440390.1122@...41...>
References: <422C7C95.3080209@...361...>
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
Date: Mon Mar  7 13:47:08 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Rolf Fokkens <r.fokkens@...361...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 7 Mar 2005, Rolf Fokkens wrote:

> Hi,
> 
> Not having too much programming knowledge about openSSL, I wonder why 
> each VPN config must specify TLS-client or TLS-server. If full-mesh 
> bridging/routing will be supported in the future, most nodes are just 
> peers, without a client-server relationship.

SSL/TLS is a client/server-based protocol.

To do full-mesh peer-to-peer in the future, we will probably use some sort 
of abstraction where all peers will be a server by default, but will 
simultaneously take on a client role when initiating a connection with 
another peer.

This would be an initiator/responder model, which maps fairly cleanly to
the client/server metaphor.

James

