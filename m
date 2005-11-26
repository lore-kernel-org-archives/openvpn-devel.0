From: Florian Weimer <fw@...315...>
Subject: Re: [Openvpn-devel] [HACK/PATCH] Prioritize TCP ACKs
References: <20051125060059.3AA4570DD18@...506...>
In-Reply-To: <20051125060059.3AA4570DD18@...506...>
	(nielsen@...505...'s message of "Fri, 25 Nov 2005 06:01:00 +0000
	(GMT)")
Message-ID: <87br07brws.fsf@...508...>
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
Date: Sat Nov 26 02:59:03 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: Nielsen <nielsen@...505...>
Cc: openvpn-devel@lists.sourceforge.net

> Here's a hack of a patch which puts nice TOS bits on TCP ACK packets.
> This allows you to use pf or another firewall to prioritize the
> resulting openvpn traffic in the way you normally do over asynchronous
> connections.

I think you have to make those TOS values configurable because their
meaning is no longer standardized (or, more precisely, there are
several standards to choose from).

