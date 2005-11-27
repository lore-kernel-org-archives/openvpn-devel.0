From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] [PATCH] Allow dynamic choice of source port
In-Reply-To: <20051125055759.373AE70DD18@...506...>
Message-ID: <Pine.LNX.4.58.0511272225250.24626@...41...>
References: <20051125055759.373AE70DD18@...506...>
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
Date: Sun Nov 27 21:28:02 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Nielsen <nielsen@...505...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 25 Nov 2005, Nielsen wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> As it is openvpn has no way to allow the kernel to dynamically choose
> a source port for it's connections. If you have two openvpn client
> processes on the same machine both you have to configure lport to
> different ports manually. This patch allows you to specify '--lport 0'
> and get the behaviour of normal programs, where the source port is
> dynamically chosen.
> 
> Not sure if this is an issue for others, but here's the patch in
> case anyone has run into the same issue.

How is this different from simply using --nobind to allocate a dynamic 
port #?

James


