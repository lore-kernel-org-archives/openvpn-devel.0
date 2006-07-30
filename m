From: Florian Weimer <fw@...315...>
References: <op.tdco72dcioehzu@...603...>
Date: Sun, 30 Jul 2006 08:59:24 +0200
In-Reply-To: <op.tdco72dcioehzu@...603...> (Tony's message of
	"Thu, 27 Jul 2006 18:01:04 +0400")
Message-ID: <87fygjwpbn.fsf@...508...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] A special IP address range for exclusive VPN
	usage?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: Tony <kb2wjw@...277...>
Cc: openvpn-devel@lists.sourceforge.net

* Tony:

> As far as I can see - the main obstacle of building the robust and  
> allaround VPN is to guess the IP-range so that it *NEVER*  
> collides|overlaps with *ANY* of the IPs used on real networks where a  
> server and a client may happen to be.

You need globally unique addresses for that.  Ask your LIR/RIR, and
you'll get them.

IPv6 is no real help because it's unlikely that we'll see that central
ULA registry in the forseeable future.

