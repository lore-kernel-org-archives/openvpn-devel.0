From: Charles Duffy <cduffy@...294...>
Date: Thu, 27 Jul 2006 10:18:55 -0500
Message-ID: <eaalgv$i96$1@...165...>
References: <op.tdco72dcioehzu@...603...>
Mime-Version: 1.0
In-Reply-To: <op.tdco72dcioehzu@...603...>
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

Personally, I think that adding IPv6 support (with its massive space for 
private networks) is a better long-term fix for this issue. Getting yet 
another private allocation (1) is questionable in terms of its 
feasibility, and (2) doesn't do any good for folks who (for instance) 
need to be attached to more than one VPN at a time -- and, in fact, may 
cause *more* issues in such cases.


