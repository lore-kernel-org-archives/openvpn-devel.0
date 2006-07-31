From: Charles Duffy <cduffy@...294...>
Date: Mon, 31 Jul 2006 09:18:41 -0500
Message-ID: <eal3g8$615$1@...165...>
References: <op.tdco72dcioehzu@...603...>
	<87fygjwpbn.fsf@...508...>
Mime-Version: 1.0
In-Reply-To: <87fygjwpbn.fsf@...508...>
Sender: news <news@...165...>
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
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Florian Weimer wrote:
> IPv6 is no real help because it's unlikely that we'll see that central
> ULA registry in the forseeable future.

IPv6 is plenty of help; see RFC 4193. Basically, every site that wants 
an unroutable IP range randomly selects a 41-bit global ID to use as a 
prefix for their range (after the initial prefix identifying it as a 
local IP). With 2,199,023,255,552 such IDs to choose from, I'd say that 
we're pretty darned safe from having overlap. Granted, it's not quite 
literally guaranteed to be globally unique, but the chance of a 
collision is so immensely low that it still can be safely discounted.


