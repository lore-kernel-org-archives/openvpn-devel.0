From: Aaron Sethman <androsyn@...45...>
Message-ID: <Pine.LNX.4.60.0501142344040.28306@...48...>
MIME-Version: 1.0
Subject: [Openvpn-devel] using openvpn on the link layer only?
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
Date: Fri Jan 14 20:46:28 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I was considering writing a patch for openvpn that would apply to work 
using raw ethernet frames as for my current network situation the overhead 
of using udp/ip is mostly pointless.  Are there any gotchas I should 
consider before coding this up?

Regards,

Aaron

