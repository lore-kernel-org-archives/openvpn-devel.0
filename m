Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74902606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cd/3/P13;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=L4/6qXdz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=drpmaj2b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=I4B5Nw4Lfn/jb1Ko+BP+F5e3S/Rf+8IOq34mx0PhPak=; b=cd/3/P13u3R66B
	6I3T4xsKgX5kinAHGI87iQK/TSMtidZef00qDj09X8NNlM6MtxZoklvZFm4o5X5Zg3CLHopsbWn2j
	dTAmk7iWKGj2LjY0fJSD60pYtBYqke5VmhoiCFFaAdP6XP6PzsVxDVOuo0PbrosBG5GFI5A0wQLo5
	K4o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWY7u-000000007bE-3abU;
	Thu, 26 Nov 2026 11:58:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWY7t-000000007b6-0Xoo for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:58:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2+wXDH/2G9Vgc8X6qofNTcQvRBUll2GEfImC/nXJLFw=; b=L4/6qXdzO44pmOqXTfXyWetbNp
 l6ZBu6+ZMlEUCzLNdE0Eve/il8M6zFYMn9TEmdvw0BlEtbxv8FHX7s2kVdejK8/F9s5dCeKS4//ZO
 D8u58SX/hDo3NPZSwjTFrPrgRsreLCVx4mvmGCRWFePqMrLwFNsAE//mClddfx8S/Odg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2+wXDH/2G9Vgc8X6qofNTcQvRBUll2GEfImC/nXJLFw=; b=drpmaj2b2QWuQ7hQyHLjOzwzQ/
 Bh0h4Foz5fSiKrWoL2gfLIrFIWCewWhw5g+PIhz9q7pLzP/iRNGo5WCaLWMy0pwh8zAuOElhs40sS
 3/1YU8AhBYYce6/US0OMa43IA4CgCMxWJxWXK84nb73yjbSaduoaibobDSj0O6l7Q63Q=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWY7r-000000006CP-1x6E for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:58:57 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AQBwm0s007342
 for <openvpn-devel@lists.sourceforge.net>; Thu, 26 Nov 2026 12:58:48 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQBwmsx007341
 for openvpn-devel@lists.sourceforge.net; Thu, 26 Nov 2026 12:58:48 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 12:58:43 +0100
Message-ID: <20261126115848.7329-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
References: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWY7r-000000006CP-1x6E
Subject: [Openvpn-devel] [PATCH v2] dhcp: locate the UDP header via the IP
 header length
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

dhcp_extract_router_msg() assumed a 20-byte IP header, so DHCP replies
carrying IP options were not recognised. Use the IHL to find the UDP
header and skip fragments, whose UDP checksum covers data we don't
have. Drop struct dhcp_full, no longer used.

Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2209
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2209
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 525d567..8c9e520 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -152,27 +152,49 @@
 in_addr_t
 dhcp_extract_router_msg(struct buffer *ipbuf)
 {
-    struct dhcp_full *df = (struct dhcp_full *)BPTR(ipbuf);
-    const int optlen =
-        BLEN(ipbuf)
-        - (int)(sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr) + sizeof(struct dhcp));
-
-    if (optlen >= 0 && df->ip.protocol == OPENVPN_IPPROTO_UDP
-        && df->udp.source == htons(BOOTPS_PORT) && df->udp.dest == htons(BOOTPC_PORT)
-        && df->dhcp.op == BOOTREPLY)
+    if (BLENZ(ipbuf) < sizeof(struct openvpn_iphdr))
     {
-        const int message_type = get_dhcp_message_type(&df->dhcp, optlen);
+        return 0;
+    }
+
+    const struct openvpn_iphdr *ip = (const struct openvpn_iphdr *)BPTR(ipbuf);
+    const int hlen = OPENVPN_IPH_GET_LEN(ip->version_len);
+
+    /* Skip fragments: later ones carry no UDP header, and the checksum
+     * covers the whole datagram. */
+    if (ntohs(ip->frag_off) & (OPENVPN_IP_MF | OPENVPN_IP_OFFMASK))
+    {
+        return 0;
+    }
+
+    /* The UDP header follows any IP options. */
+    struct buffer udpbuf = *ipbuf;
+    if (hlen < (int)sizeof(struct openvpn_iphdr) || !buf_advance(&udpbuf, hlen))
+    {
+        return 0;
+    }
+
+    struct openvpn_udphdr *udp = (struct openvpn_udphdr *)BPTR(&udpbuf);
+    struct dhcp *dhcp = (struct dhcp *)(udp + 1);
+    const int optlen =
+        BLEN(&udpbuf) - (int)(sizeof(struct openvpn_udphdr) + sizeof(struct dhcp));
+
+    if (optlen >= 0 && ip->protocol == OPENVPN_IPPROTO_UDP
+        && udp->source == htons(BOOTPS_PORT) && udp->dest == htons(BOOTPC_PORT)
+        && dhcp->op == BOOTREPLY)
+    {
+        const int message_type = get_dhcp_message_type(dhcp, optlen);
         if (message_type == DHCPACK || message_type == DHCPOFFER)
         {
             /* get the router IP address while padding out all DHCP router options */
-            const in_addr_t ret = do_extract(&df->dhcp, optlen);
+            const in_addr_t ret = do_extract(dhcp, optlen);
 
             /* recompute the UDP checksum */
-            df->udp.check = 0;
-            df->udp.check = htons(ip_checksum(
-                AF_INET, (uint8_t *)&df->udp,
+            udp->check = 0;
+            udp->check = htons(ip_checksum(
+                AF_INET, (uint8_t *)udp,
                 sizeof(struct openvpn_udphdr) + sizeof(struct dhcp) + optlen,
-                (uint8_t *)&df->ip.saddr, (uint8_t *)&df->ip.daddr, OPENVPN_IPPROTO_UDP));
+                (const uint8_t *)&ip->saddr, (const uint8_t *)&ip->daddr, OPENVPN_IPPROTO_UDP));
 
             /* only return the extracted Router address if DHCPACK */
             if (message_type == DHCPACK)
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index 38ebf8d..8517b92 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -80,15 +80,6 @@
     uint32_t magic;     /* must be 0x63825363 (network order) */
 };
 
-struct dhcp_full
-{
-    struct openvpn_iphdr ip;
-    struct openvpn_udphdr udp;
-    struct dhcp dhcp;
-#define DHCP_OPTIONS_BUFFER_SIZE 256
-    uint8_t options[DHCP_OPTIONS_BUFFER_SIZE];
-};
-
 #pragma pack()
 
 in_addr_t dhcp_extract_router_msg(struct buffer *ipbuf);
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 14f9264..0841ad5 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -96,6 +96,7 @@
     uint16_t tot_len;
     uint16_t id;
 
+#define OPENVPN_IP_MF      0x2000
 #define OPENVPN_IP_OFFMASK 0x1fff
     uint16_t frag_off;
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
