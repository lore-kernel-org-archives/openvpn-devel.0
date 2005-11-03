From: mts.spb.suxx@...450...
Reply-To: mts.spb.suxx@...450...
Message-ID: <1961154894.20051104014507@...450...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN v2.0.5 and my "weird networking"
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
Date: Thu Nov  3 14:52:42 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello List,

  OpenVPN v2.0.5 works much better that v2.0.2 in my totally non-IP
  environment.

  I have a LAN (all-winXP-SP2) where all the file-sharing is done with
  NetBEUI. IP family is used only to access the external hosts through
  POP3, SMTP and HTTP[S]. "NetBIOS over TCP/IP" is disabled on all
  instances of TCP/IP on all adapters, all 135~139 and 445 ports are
  closed. There is no domain, no WINS, only a good old workgroup.

  When I bridge TAP-win32 with NIC and unbind the file-sharing off the
  TCP/IP (on the sever) - the remote connection works with some
  anomalities.

  Namely those anomalities are (please compare to my 8 Sep 2005
  02:32:11 post) now:
  - the road warrior (winXP-SP2) machine now can access the sharings of the
    OpenVPN server and other's on the LAN;

  - any attempt made on all other LAN machines to browse (via the
    short-cut to the workgroup) the neibourhood ends with the "You have
    no access rights..." failure, but if they search the neibourhood
    manually - they can discover and access the workgroup (including the
    road warrior now) on one-by-one basis (i.e. it takes to search for
    the particular machine to discover it, all others stay invisible
    still, the neibourhood remains unpopulated);

  - the OpenVPN server does not loose all the file-sharing ability when the
    road warrior connects, it's neibourhood gets populated as it
    should;

  - the road warrior now can see and access the whole workgroup's
    sharings, the neibourhood stays unpopulated, it takes the manual
    searching to discover any machine there;

  OpenVPN v2.0.5, runs as the service in the bridged mode.

  Please comment.
  I'm not subscribed to the list, so, please CC to me.
  
-- 
Best regards,
 Anthony



