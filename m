From: mts.spb.suxx@...450...
Reply-To: mts.spb.suxx@...450...
Message-ID: <774138843.20050908023211@...450...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Bridging the really weird networks (NetBEUI only configuration)
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
Date: Wed Sep  7 15:34:11 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello List,

  Is TAP-win32 designed to handle totally non-IP environment?

  I have a LAN (all-winXP-SP2) where all the file-sharing is done with
  NetBEUI. IP family is used only to access the external hosts through
  POP3, SMTP and HTTP[S]. "NetBIOS over TCP/IP" is disabled on all
  instances of TCP/IP on all adapters, all 135~139 and 445 ports are
  closed. There is no domain, no WINS, only a good old workgroup.

  When I bridge TAP-win32 with NIC and unbind the file-sharing off
  the TCP/IP - the remote connection works with some anomalities.

  Namely those anomalities are:
  - the remote (winXP-SP2) machine can access the sharings of the
    OpenVPN server only;
  - all other machines (except the OpenVPN server) see only the remote
    machine's sharings, but if they search the neibourhood manually -
    they can discover and access the workgroup on one-by-one basis
    (i.e. it takes to search for the particular machine to discover it,
    all others stay invisible, the neibourhood stays unpopulated);
  - the OpenVPN server looses all the file-sharing ability when the
    remote client connects, any attempt to browse the neibourhood ends
    with the "You have no access rights..." failure. It takes some time
    after the client disconnection to regain the file-sharing on the
    server machine. The IP-connectivity to the outer world works no
    matter what;

  OpenVPN v2.0.2, runs as the service.

  Please comment.

-- 
Best regards,
 Anthony


