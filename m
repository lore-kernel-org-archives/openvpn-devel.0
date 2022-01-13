From: Antonio Quartulli <a@...2181...>
Date: Thu, 13 Jan 2022 21:00:30 +0100
Message-Id: <20220113200030.18656-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc: remove PF leftovers from documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

PF (Packet Filter) has been dropped from the OpenVPN code base, however
some bits and pieces are left in the documentation.

Erase them all.

Reported-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 doc/man-sections/management-options.rst |   5 --
 doc/management-notes.txt                | 112 ------------------------
 2 files changed, 117 deletions(-)

diff --git a/doc/man-sections/management-options.rst b/doc/man-sections/management-options.rst
index de0d47e7..884750a6 100644
--- a/doc/man-sections/management-options.rst
+++ b/doc/man-sections/management-options.rst
@@ -65,11 +65,6 @@ server and client mode operations.
   When the management interface is listening on a unix domain socket, only
   allow connections from group ``g``.
 
---management-client-pf
-  Management interface clients must specify a packet filter file for each
-  connecting client. See :code:`management-notes.txt` in OpenVPN
-  distribution for detailed notes.
-
 --management-client-user u
   When the management interface is listening on a unix domain socket, only
   allow connections from user ``u``.
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 84e3d04b..203d3d82 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -785,118 +785,6 @@ Immediately kill a client instance by CID.
 CID -- client ID.  See documentation for ">CLIENT:" notification for more
 info.
 
-COMMAND -- client-pf  (OpenVPN 2.1 or higher)
----------------------------------------------
-
-Push a packet filter file to a specific client.
-
-The OpenVPN server should have been started with the
---management-client-pf directive so that it will require that
-VPN tunnel packets sent or received by client instances must
-conform to that client's packet filter configuration.
-
-  client-pf {CID}
-  line_1
-  line_2
-  ...
-  line_n
-  END
-
-CID -- client ID.  See documentation for ">CLIENT:" notification for
-more info.
-
-line_1 to line_n -- the packet filter configuration file for this
-client.
-
-Packet filter file grammar:
-
- [CLIENTS DROP|ACCEPT]
- {+|-}common_name1
- {+|-}common_name2
- . . .
- [SUBNETS DROP|ACCEPT]
- {+|-}subnet1
- {+|-}subnet2
- . . .
- [END]
-
- Subnet: IP-ADDRESS | IP-ADDRESS/NUM_NETWORK_BITS | "unknown"
-
- CLIENTS refers to the set of clients (by their common-name) which
- this instance is allowed ('+') to connect to, or is excluded ('-')
- from connecting to.  Note that in the case of client-to-client
- connections, such communication must be allowed by the packet filter
- configuration files of both clients AND the --client-to-client
- directive must have been specified in the OpenVPN server config.
-
- SUBNETS refers to IP addresses or IP address subnets which this
- client instance may connect to ('+') or is excluded ('-') from
- connecting to, and applies to IPv4 and ARP packets.  The special
- "unknown" tag refers to packets of unknown type, i.e. a packet that
- is not IPv4 or ARP.
-
- DROP or ACCEPT defines default policy when there is no explicit match
- for a common-name or subnet.  The [END] tag must exist.
-
- Notes:
-
- * The SUBNETS section currently only supports IPv4 addresses and
-   subnets.
-
- * A given client or subnet rule applies to both incoming and
-   outgoing packets.
-
- * The CLIENTS list is order-invariant.  Because the list is stored
-   as a hash-table, the order of the list does not affect its function.
-
- * The SUBNETS table is scanned sequentially, and the first item to
-   match is chosen.  Therefore the SUBNETS table is NOT order-invariant.
-
- * No client-to-client communication is allowed unless the
-   --client-to-client configuration directive is enabled AND
-   the CLIENTS list of BOTH clients allows the communication.
-
-Example packet filter spec, as transmitted to the management interface:
-
- client-pf 42
- [CLIENTS ACCEPT]
- -accounting
- -enigma
- [SUBNETS DROP]
- -10.46.79.9
- +10.0.0.0/8
- [END]
- END
-
-The above example sets the packet filter policy for the client
-identified by CID=42.  This client may connect to all other clients
-except those having a common name of "accounting" or "enigma".
-The client may only interact with external IP addresses in the
-10.0.0.0/8 subnet, however access to 10.46.79.9 is specifically
-excluded.
-
-Another example packet filter spec, as transmitted to the
-management interface:
-
- client-pf 99
- [CLIENTS DENY]
- +public
- [SUBNETS ACCEPT]
- +10.10.0.1
- -10.0.0.0/8
- -unknown
- [END]
- END
-
-The above example sets the packet filter policy for the client
-identified by CID=99.  This client may not connect to any other
-clients except those having a common name of "public".  It may
-interact with any external IP address except those in the
-10.0.0.0/8 netblock.  However interaction with one address in
-the 10.0.0.0/8 netblock is allowed: 10.10.0.1.  Also, the client
-may not interact with external IP addresses using an "unknown"
-protocol (i.e. one that is not IPv4 or ARP).
-
 COMMAND -- remote  (OpenVPN AS 2.1.5/OpenVPN 2.3 or higher)
 --------------------------------------------
 
-- 
2.34.1


