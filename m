From: Mike Auty <mike.auty@...277...>
Message-ID: <5701665D.2010208@...277...>
Date: Sun, 3 Apr 2016 19:52:13 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 7/7] vlan: document the --vlan-* flags in
	openvpn.8 man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Documents the --vlan-tagging, --vlan-accept and --vlan-pvid tags
in the openvpn man page.

Patch authored by Fabian Knittel <fabian.knittel@...2126...>.

Co-authored-by: Mike Auty <mike.auty@...277...>
Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 doc/openvpn.8 | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 628d877..a5ac3a8 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3290,6 +3290,7 @@ without needing to restart the server.
 The following
 options are legal in a client-specific context:
 .B \-\-push, \-\-push\-reset, \-\-iroute, \-\-ifconfig\-push,
+.B \-\-vlan\-pvid
 and
 .B \-\-config.
 .\"*********************************************************
@@ -3753,6 +3754,109 @@ connection is torn down.
 
 Not implemented on Windows.
 .\"*********************************************************
+.TP
+.B \-\-vlan\-tagging
+Turns the OpenVPN server instance into a switch that understands VLAN-tagging,
+based on IEEE 802.1Q.
+
+The tap device and each of the connecting clients is seen as a port of the
+switch. All client ports are in untagged mode and the tap device is
+VLAN-tagged, untagged or accepts both, depending on the
+.B \-\-vlan\-accept
+setting.
+
+Ethernet frames with a prepended 802.1Q tag are called "tagged". If the VLAN
+Identifier (VID) field in such a tag is non-zero, the frame is called
+"VLAN-tagged". If the VID is zero, but the Priority Control Point (PCP) field
+is non-zero, the frame is called "prio-tagged". If there is no 802.1Q tag, the
+frame is "untagged".
+
+Using the
+.B \-\-vlan\-pvid v
+option once per client, each port can be associated with a certain VID. Packets
+can only be distributed between ports with a matching VID. Therefore, clients
+with differing VIDs are completely separated from one-another, even if
+.B \-\-client-to-client
+is activated.
+
+The filtering of packets takes place in the OpenVPN server. Clients do not
+need support for VLAN tagging.
+
+The
+.B \-\-vlan\-tagging
+option is off by default. While turned off, OpenVPN
+does no parsing and accepts any Ethernet frames.
+
+The option can only be activated in
+.B \-\-dev tap
+mode.
+
+.\"*********************************************************
+.TP
+.B \-\-vlan\-accept all | tagged | untagged
+Allows the tap device's VLAN tagging policy to be configured. You can choose
+between the following modes:
+
+.B all
+(default) -- Admit all frames.
+.br
+.B tagged
+-- Admit only VLAN-tagged frames.
+.br
+.B untagged
+-- Admit only untagged and priority-tagged frames.
+
+(Note: Some vendors refer to switch ports running in
+.B tagged
+mode as "trunk ports" and switch ports running in
+.B untagged
+mode as "access ports".)
+
+Incoming untagged or priority-tagged packets from clients are assigned with the
+client's Port VLAN Identifier (PVID) as their VID. In
+.B untagged
+mode, incoming untagged or priority-tagged packets on the tap device are
+associated with the global
+.B \-\-vlan\-pvid
+setting. In
+.B tagged
+mode, any incoming untagged or priority-tagged packets are dropped. For
+VLAN-tagged packets, any priority information is lost as soon as the
+VLAN-tagging is removed.
+
+In
+.B tagged
+mode, packets going out through the tap device are VLAN-tagged with the
+originating client's VID.
+
+In
+.B all
+mode, incoming tagged packets are handled the same way as in
+.B tagged
+mode. Incoming untagged packets are handled as in
+.B untagged
+mode. Outgoing packets are tagged, unless the VID matches the global PVID, in
+which case the packets go out untagged.
+.\"*********************************************************
+.TP
+.B \-\-vlan\-pvid v
+Specifies which VLAN identifier a "port" is associated with. Not valid without
+\fB\-\-vlan\-tagging\fR.
+
+In client context, the setting specifies which VLAN identifier a client is
+associated with. In global context, the tap device's VLAN identifier is set.
+The latter only makes sense in
+.B \-\-vlan\-accept untagged
+and
+.B \-\-vlan\-accept all
+mode.
+
+Valid values for
+.B v
+go from 1 through to 4094. Defaults to 1.
+
+In some switch implementations, the PVID is also referred to as "Native VLAN".
+.\"*********************************************************
 .SS Client Mode
 Use client mode when connecting to an OpenVPN server
 which has
-- 
2.7.1

