From: Nate Nielsen <nielsen-list@...505...>
Reply-To: nielsen@...505...
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [HACK/PATCH] Prioritize TCP ACKs
References: <20051125060059.3AA4570DD18@...506...> <87br07brws.fsf@...508...>
Message-Id: <20051130060853.CAA6B70DD41@...506...>
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
Date: Tue Nov 29 21:55:01 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Florian Weimer <fw@...315...>
Cc: Nielsen <nielsen@...505...>, openvpn-devel@lists.sourceforge.net

Florian Weimer wrote:
>>Here's a hack of a patch which puts nice TOS bits on TCP ACK packets.
>>This allows you to use pf or another firewall to prioritize the
>>resulting openvpn traffic in the way you normally do over asynchronous
>>connections.
> 
> I think you have to make those TOS values configurable because their
> meaning is no longer standardized (or, more precisely, there are
> several standards to choose from).

It's a patch :) Completely customizeable. I doubt this code would (or
should) be included in openvpn as is.

Cheers,
Nate


