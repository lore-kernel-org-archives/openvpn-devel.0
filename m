From: Noam Rathaus <noamr@...117...>
Date: Sun, 17 Aug 2008 10:00:09 +0300
MIME-Version: 1.0
Message-Id: <200808171000.09879.noamr@...117...>
Subject: [Openvpn-devel] OpenVPN bandwidth restrictions (wishlist)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

Is there a plan or someone that knows how to make OpenVPN limit the mount of 
traffic it sends per user?

I know of 'shaper' functionality but I can't use it, as apparently I cannot do 
this on the server only on the clients?
  Options error: --shaper cannot be used with --mode server

I don't want my clients to have the ability to control how much outgoing 
traffic my server sends, rather I want to control it in the server.

-- 
Noam Rathaus
CTO
noamr@...117...
http://www.beyondsecurity.com

"Know that you are safe."

Beyond Security Finalist for the "Red Herring 100 Global" Awards 2007

