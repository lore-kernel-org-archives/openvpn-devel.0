From: Mike Auty <mike.auty@...277...>
Message-ID: <5701663A.9020501@...277...>
Date: Sun, 3 Apr 2016 19:51:38 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/7] vlan: Add various definitions and
	802.1Q structure
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

This patch provides all the #DEFINES necessary for the 802.1q.

sf.net tracker:
<https://sourceforge.net/tracker/?func=detail&aid=2829878&group_id=48978&atid=45
4721>

Discussed on the IRC meeting March 4, 2010 in #openvpn-discussions.
<http://thread.gmane.org/gmane.network.openvpn.devel/3242>

This includes an additional length check that was not in the original
patch:

Currently is_ipv4() only checks whether the frame is large enough for
struct openvpn_ethhdr. In case of an 802.1Q packet the function now
also checks whether the frame is large enough for struct openvpn_8021qhdr,
which is 4 bytes larger than struct openvpn_ethhdr.

Patch authored by David Sommerseth <dazo@...384...> and 
Fabian Knittel <fabian.knittel@...2126...>.

Co-authored-by: David Sommerseth <dazo@...384...>
Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/errlevel.h |  2 ++
 src/openvpn/options.h  | 15 +++++++++++++++
 src/openvpn/proto.c    | 19 ++++++++++++++++---
 src/openvpn/proto.h    | 26 ++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index da600ab..191c763 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -148,6 +148,8 @@
 #define D_PF_DROPPED_BCAST   LOGLEV(7, 71, M_DEBUG)  /* packet filter dropped a broadcast packet */
 #define D_PF_DEBUG           LOGLEV(7, 72, M_DEBUG)  /* packet filter debugging, must also define PF_DEBUG in pf.h */
 
+#define D_VLAN_DEBUG         LOGLEV(7, 72, M_DEBUG)  /* show VLAN tagging/untagging debug info */
+
 #define D_HANDSHAKE_VERBOSE  LOGLEV(8, 70, M_DEBUG)  /* show detailed description of each handshake */
 #define D_TLS_DEBUG_MED      LOGLEV(8, 70, M_DEBUG)  /* limited info from tls_session routines */
 #define D_INTERVAL           LOGLEV(8, 70, M_DEBUG)  /* show interval.h debugging info */
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 23d3992..72ee702 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -155,6 +155,15 @@ struct remote_list
   struct remote_entry *array[CONNECTION_LIST_SIZE];
 };
 
+#ifdef ENABLE_VLAN_TAGGING
+enum vlan_acceptable_frames
+{
+  VAF_ONLY_VLAN_TAGGED,
+  VAF_ONLY_UNTAGGED_OR_PRIORITY,
+  VAF_ALL,
+};
+#endif
+
 struct remote_host_store
 {
 # define RH_HOST_LEN 80
@@ -597,6 +606,12 @@ struct options
   const char *keying_material_exporter_label;
   int keying_material_exporter_length;
 #endif
+
+#ifdef ENABLE_VLAN_TAGGING
+  bool vlan_tagging;
+  enum vlan_acceptable_frames vlan_accept;
+  uint16_t vlan_pvid;
+#endif
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 7b58e6a..2921a6e 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -60,9 +60,22 @@ is_ipv_X ( int tunnel_type, struct buffer *buf, int ip_ver )
 	  + sizeof (struct openvpn_iphdr)))
 	return false;
       eh = (const struct openvpn_ethhdr *) BPTR (buf);
-      if (ntohs (eh->proto) != (ip_ver == 6 ? OPENVPN_ETH_P_IPV6 : OPENVPN_ETH_P_IPV4))
-	return false;
-      offset = sizeof (struct openvpn_ethhdr);
+      if (ntohs (eh->proto) == OPENVPN_ETH_P_8021Q) {
+        const struct openvpn_8021qhdr *evh;
+        if (BLEN (buf) < (int)(sizeof (struct openvpn_8021qhdr)
+	    + sizeof (struct openvpn_iphdr)))
+	  return false;
+        evh = (const struct openvpn_8021qhdr *) BPTR (buf);
+        if (ntohs (evh->proto) !=
+	    (ip_ver == 6 ? OPENVPN_ETH_P_IPV6 : OPENVPN_ETH_P_IPV4))
+          return false;
+        else
+          offset = sizeof (struct openvpn_8021qhdr);
+      } else if (ntohs (eh->proto) !=
+	  (ip_ver == 6 ? OPENVPN_ETH_P_IPV6 : OPENVPN_ETH_P_IPV4))
+        return false;
+      else
+        offset = sizeof (struct openvpn_ethhdr);
     }
   else
     return false;
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index f91e787..428d10f 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -61,9 +61,29 @@ struct openvpn_ethhdr
 # define OPENVPN_ETH_P_IPV4   0x0800  /* IPv4 protocol */
 # define OPENVPN_ETH_P_IPV6   0x86DD  /* IPv6 protocol */
 # define OPENVPN_ETH_P_ARP    0x0806  /* ARP protocol */
+# define OPENVPN_ETH_P_8021Q  0x8100  /* 802.1Q protocol */
   uint16_t proto;                     /* packet type ID field */
 };
 
+struct openvpn_8021qhdr
+{
+  uint8_t dest[OPENVPN_ETH_ALEN];     /* destination ethernet addr */
+  uint8_t source[OPENVPN_ETH_ALEN];   /* source ethernet addr	*/
+
+  uint16_t tpid;                      /* 802.1Q Tag Protocol Identifier */
+# define OPENVPN_8021Q_MASK_VID htons (0x0FFF) /* mask VID out of pcp_cfi_vid */
+# define OPENVPN_8021Q_MASK_PCP htons (0xE000) /* mask PCP out of pcp_cfi_vid */
+# define OPENVPN_8021Q_MASK_CFI htons (0x1000) /* mask CFI out of pcp_cfi_vid */
+  uint16_t pcp_cfi_vid;               /* bit fields, see IEEE 802.1Q */
+  uint16_t proto;                     /* contained packet type ID field */
+};
+
+/*
+ * Size difference between a regular Ethernet II header and an Ethernet II
+ * header with additional IEEE 802.1Q tagging.
+ */
+#define SIZE_ETH_TO_8021Q_HDR (sizeof (struct openvpn_8021qhdr) - sizeof (struct openvpn_ethhdr))
+
 struct openvpn_arp {
 # define ARP_MAC_ADDR_TYPE 0x0001
   uint16_t mac_addr_type;       /* 0x0001 */
@@ -234,4 +254,10 @@ void ipv4_packet_size_verify (const uint8_t *data,
 			      counter_type *errors);
 #endif
 
+#ifdef ENABLE_VLAN_TAGGING
+# define OPENVPN_8021Q_MIN_VID 1
+# define OPENVPN_8021Q_MAX_VID 4094
+
+#endif
+
 #endif
-- 
2.7.1

