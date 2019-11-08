From: Antonio Quartulli <a@...2181...>
Date: Fri,  8 Nov 2019 10:10:44 +0100
Message-Id: <20191108091044.11370-1-a@...2181...>
In-Reply-To: <20191009143422.9419-9-a@...2181...>
References: <20191009143422.9419-9-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 8/9] VLAN: add documentation to manpage
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
Cc: Antonio Quartulli <a@...2181...>, Fabian Knittel <fabian.knittel@...1547...>

This patch adds documentation for all the VLAN related knobs.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
- slight rewording of some sentences, as suggested by Arne

 doc/openvpn.8 | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 11daa92a..b6ab478b 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3440,7 +3440,8 @@ without needing to restart the server.
 
 The following
 options are legal in a client\-specific context:
-.B \-\-push, \-\-push\-reset, \-\-push\-remove, \-\-iroute, \-\-ifconfig\-push,
+.B \-\-push, \-\-push\-reset, \-\-push\-remove, \-\-iroute,
+.B \-\-ifconfig\-push, \-\-vlan\-pvid
 and
 .B \-\-config.
 .\"*********************************************************
@@ -3908,6 +3909,102 @@ connection is torn down.
 
 Not implemented on Windows.
 .\"*********************************************************
+.TP
+.B \-\-vlan\-tagging
+Server-only option. Turns the OpenVPN server instance into a switch that
+understands VLAN\-tagging, based on IEEE 802.1Q.
+
+The server TAP device and each of the connecting clients is seen as a port of the
+switch. All client ports are in untagged mode and the server TAP device is
+VLAN-tagged, untagged or accepts both, depending on the
+.B \-\-vlan\-accept setting.
+
+Ethernet frames with a prepended 802.1Q tag are called "tagged". If the VLAN
+Identifier (VID) field in such a tag is non-zero, the frame is called
+"VLAN\-tagged". If the VID is zero, but the Priority Control Point (PCP) field
+is non\-zero, the frame is called "prio\-tagged". If there is no 802.1Q tag, the
+frame is "untagged".
+
+Using the
+.B \-\-vlan\-pvid v
+option once per client (see \-\-client\-config\-dir), each port can be associated
+with a certain VID. Packets
+can only be forwarded between ports having the same VID. Therefore, clients
+with differing VIDs are completely separated from one\-another, even if
+.B \-\-client\-to\-client
+is activated.
+
+The packet filtering takes place in the OpenVPN server. Clients should not
+have any VLAN tagging configuration applied.
+
+The
+.B \-\-vlan\-tagging
+option is off by default. While turned off, OpenVPN
+accepts any Ethernet frame and does not perform any special processing
+for VLAN\-tagged packets.
+
+The option can only be activated in
+.B \-\-dev tap mode.
+
+.\"*********************************************************
+.TP
+.B \-\-vlan\-accept all | tagged | untagged
+Configure the VLAN tagging policy for the server TAP device. The following modes
+are available:
+
+.B tagged
+\-\- Admit only VLAN\-tagged frames.
+Only VLAN\-tagged packets are accepted, while untagged or priority\-tagged
+packets are dropped when entering the server TAP device.
+
+.br
+.B untagged
+\-\- Admit only untagged and prio\-tagged frames.
+.br
+VLAN\-tagged packets are not accepted, while untagged or priority\-tagged
+packets entering the server TAP device are tagged with the value configured
+for the global
+.B \-\-vlan\-pvid
+setting.
+.br
+.B all
+(default) \-\- Admit all frames.
+.br
+All packets are admitted and then treated like untagged or tagged mode
+respectively.
+
+(Note: Some vendors refer to switch ports running in
+.B tagged
+mode as "trunk ports" and switch ports running in
+.B untagged
+mode as "access ports".)
+
+Packets forwarded from clients to the server are VLAN\-tagged
+with the originating client's PVID, unless the VID matches the
+global \-\-vlan\-pvid, in which case the tag is removed.
+
+If no PVID is configured for a given client (see \-\-vlan\-pvid) packets
+are tagged with 1 by default.
+.\"*********************************************************
+.TP
+.B \-\-vlan\-pvid v
+Specifies which VLAN identifier a "port" is associated with. Only valid when
+\fB\-\-vlan\-tagging\fR is speficied.
+
+In the client context, the setting specifies which VLAN ID a client is
+associated with. In the global context, the VLAN ID of the server TAP device is set.
+The latter only makes sense for
+.B \-\-vlan\-accept untagged
+and
+.B \-\-vlan\-accept all
+modes.
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
2.24.0


