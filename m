From: Nate Nielsen <nielsen-list@...505...>
Reply-To: nielsen@...505...
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Allow dynamic choice of source port
References: <20051125055759.373AE70DD18@...506...> <Pine.LNX.4.58.0511272225250.24626@...41...>
Message-Id: <20051128161924.37F1270DCE3@...506...>
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
Date: Mon Nov 28 08:06:06 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

James Yonan wrote:
> On Fri, 25 Nov 2005, Nielsen wrote:
>>As it is openvpn has no way to allow the kernel to dynamically choose
>>a source port for it's connections. If you have two openvpn client
>>processes on the same machine both you have to configure lport to
>>different ports manually. This patch allows you to specify '--lport 0'
>>and get the behaviour of normal programs, where the source port is
>>dynamically chosen.
> 
> How is this different from simply using --nobind to allocate a dynamic 
> port #?

The issue I ran into was that I did want to bind to an address (in order
to make the packets come from a specific interface) but not to a
specific port (as in some cases I needed to run multiple openvpn
processes on a single interface).

Cheers,
Nate


