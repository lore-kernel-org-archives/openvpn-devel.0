Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7569C5DF7D
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R18rYg8gsyLfhE89LgwnekXpWRyx/tXjf/yONndIihw=; b=iTpB5JgiY3ZbSKbNercfXPgTR0
	hCLbLky8q4Z1p/oxAFnKXVwQEgcru4eyhy/3oUgA5PRH0ubCmYteuX9JDhROko6Cfz8flf0OPPVQH
	Ox9CFZgCTfv4bHe9opWC8y6vdguKKihsJl5aw8iyqVNnkl2S3yEw8vfGXFlBnoLfRZn8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwKi4-0001nb-Dw;
	Tue, 18 Aug 2026 14:22:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wwKi3-0001nV-OF
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:22:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LZL0OiIqL8FN+uPPC0s5RIsxoy82evPEYmNHvzI42Go=; b=bZbuTPt+ualhlOLWhAZjmFoeSc
 qrEB1Jh67mh27Bdidp2YlG5JUQ8lrE7DdSgNNGHp1SVEcBqhICZpwbBgr8AqmJTj9JJ7zMWsK2Orw
 OQZkjXJergcIsDhRac0T/9UwrtyFnc1l5PwaTAGfmQt+ljOvzwZ4M1mRD6O/fxy7HxlU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LZL0OiIqL8FN+uPPC0s5RIsxoy82evPEYmNHvzI42Go=; b=iIlWAzNFu6VgHfBxy0rHRRthlW
 J6DvidtYAK8lJf3gYSk4UqkNUAP7VesQzvxVpY3cBcgKLDk/HP8aKiLl5GfrgzWEmjybuBVPgu3Iu
 Y2MXmGK2wH2Z/PGZr4Yi+Ny3avp7meWxpBEe0vq5Et9CNpfEKCVi3JgRqAwjAXOfsjpk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwKi6-0001Q5-8c for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:22:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67IEMRHZ027191
 for <openvpn-devel@lists.sourceforge.net>; Tue, 18 Aug 2026 16:22:27 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67IEMRlX027190
 for openvpn-devel@lists.sourceforge.net; Tue, 18 Aug 2026 16:22:27 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 18 Aug 2026 16:22:21 +0200
Message-ID: <20260818142226.27172-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
References: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wwKi6-0001Q5-8c
Subject: [Openvpn-devel] [PATCH v8] packet_id: Avoid conversion warnings
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

Most of these already have checks that the
values are as expected, so we can just add
the required casts.

Only the circ list x_sizeof is changed to
size_t since that is its purpose (and it is
not actually used anyway).

Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1407
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1407
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
index c29b0bb8..76484ca 100644
--- a/src/openvpn/circ_list.h
+++ b/src/openvpn/circ_list.h
@@ -33,7 +33,7 @@
         int x_head;           \
         int x_size;           \
         int x_cap;            \
-        int x_sizeof;         \
+        size_t x_sizeof;      \
         type x_list[];        \
     }
 
@@ -58,14 +58,14 @@
         (obj)->x_size = 0;   \
     }
 
-#define CIRC_LIST_ALLOC(dest, list_type, size)                                 \
-    {                                                                          \
-        const int so = sizeof(list_type) + sizeof((dest)->x_list[0]) * (size); \
-        (dest) = (list_type *)malloc(so);                                      \
-        check_malloc_return(dest);                                             \
-        memset((dest), 0, so);                                                 \
-        (dest)->x_cap = size;                                                  \
-        (dest)->x_sizeof = so;                                                 \
+#define CIRC_LIST_ALLOC(dest, list_type, size)                                    \
+    {                                                                             \
+        const size_t so = sizeof(list_type) + sizeof((dest)->x_list[0]) * (size); \
+        (dest) = (list_type *)malloc(so);                                         \
+        check_malloc_return(dest);                                                \
+        memset((dest), 0, so);                                                    \
+        (dest)->x_cap = size;                                                     \
+        (dest)->x_sizeof = so;                                                    \
     }
 
 #define CIRC_LIST_FREE(dest) free(dest)
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index a4b627c..b0211d7 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -71,11 +71,6 @@
 #endif
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 packet_id_init_recv(struct packet_id_rec *rec, int seq_backtrack, int time_backtrack,
                     const char *name, int unit)
@@ -119,7 +114,7 @@
 
     /* Reinitalise the source */
     CLEAR(*src);
-    packet_id_init_recv(src, dest->seq_backtrack, dest->time_backtrack, dest->name, dest->unit);
+    packet_id_init_recv(src, (int)dest->seq_backtrack, dest->time_backtrack, dest->name, dest->unit);
 }
 
 void
@@ -170,7 +165,7 @@
         diff = p->id - pin->id;
         if (diff < CIRC_LIST_SIZE(p->seq_list) && local_now > SEQ_EXPIRED)
         {
-            CIRC_LIST_ITEM(p->seq_list, diff) = local_now;
+            CIRC_LIST_ITEM(p->seq_list, (int)diff) = local_now;
         }
     }
     else
@@ -263,18 +258,16 @@
                 return false;
             }
 
+            const time_t v = CIRC_LIST_ITEM(p->seq_list, (int)diff);
+            if (v == 0)
             {
-                const time_t v = CIRC_LIST_ITEM(p->seq_list, diff);
-                if (v == 0)
-                {
-                    return true;
-                }
-                else
-                {
-                    /* raised from D_PID_DEBUG_LOW to reduce verbosity */
-                    packet_id_debug(D_PID_DEBUG_MEDIUM, p, pin, "PID_ERR replay", diff);
-                    return false;
-                }
+                return true;
+            }
+            else
+            {
+                /* raised from D_PID_DEBUG_LOW to reduce verbosity */
+                packet_id_debug(D_PID_DEBUG_MEDIUM, p, pin, "PID_ERR replay", diff);
+                return false;
             }
         }
         else if (pin->time < p->time) /* if time goes back, reject */
@@ -386,7 +379,7 @@
         return false;
     }
 
-    const packet_id_type net_id = htonpid(p->id);
+    const packet_id_type net_id = htonpid((packet_id_type)p->id);
     const net_time_t net_time = htontime(p->time);
     if (prepend)
     {
@@ -640,7 +633,7 @@
                p->seq_backtrack, p->time_backtrack, p->max_backtrack_stat, (int)p->initialized);
     if (sl != NULL)
     {
-        buf_printf(&out, " sl=[%d,%d,%d,%d]", sl->x_head, sl->x_size, sl->x_cap, sl->x_sizeof);
+        buf_printf(&out, " sl=[%d,%d,%d,%zu]", sl->x_head, sl->x_size, sl->x_cap, sl->x_sizeof);
     }
 
 
@@ -655,7 +648,6 @@
 {
     uint64_t packet_id;
 
-
     if (!buf_read(buf, &packet_id, sizeof(packet_id)))
     {
         return 0;
@@ -663,16 +655,12 @@
 
     uint64_t id = ntohll(packet_id);
     /* top most 16 bits */
-    uint16_t epoch = id >> 48;
+    uint16_t epoch = (uint16_t)(id >> 48);
 
     pin->id = id & PACKET_ID_MASK;
     return epoch;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 packet_id_write_epoch(struct packet_id_send *p, uint16_t epoch, struct buffer *buf)
 {
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index ba59067..48752d3 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -280,26 +280,20 @@
     return p->fd >= 0;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-/* transfer packet_id -> packet_id_persist */
+/* transfer packet_id -> packet_id_persist
+   Note: Only supported for non-epoch format (i.e. 32bit ID, not 64bit format),
+   must be enforced at the caller.
+ */
 static inline void
 packet_id_persist_save_obj(struct packet_id_persist *p, const struct packet_id *pid)
 {
-    if (packet_id_persist_enabled(p) && pid->rec.time)
+    if (packet_id_persist_enabled(p) && pid->rec.time && pid->rec.id <= PACKET_ID_MAX)
     {
         p->time = pid->rec.time;
-        p->id = pid->rec.id;
+        p->id = (packet_id_type)pid->rec.id;
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  * Reset the current send packet id to its initial state.
  * Use very carefully (e.g. in the standalone reset packet context) to


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
