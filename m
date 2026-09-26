Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC40DC9832F
	for <openvpn-devel@archiver.kernel.org>; Sat, 26 Sep 2026 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XWGL1N3KJqt2Tbuc9J8oEFADhZw6DoVFuhsBIc+Bmrw=; b=jALnMtcXv0pVjKTQaWKa1rWoNR
	J/FqTklEVwjGCfnqI/aLPAR1bQc6ewfkLpNP/azE+8gsQoFxPrqN8/Rh90VcCLqL8xR1oEtXE2NNi
	MddzwzJRxuU+dPwc5VDykmjZN66ji4eFXhEk7vfGvPdJ0vV3mItiWbzHDltL9UBphZaI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xAYik-0004ez-JW;
	Sat, 26 Sep 2026 20:10:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xAYii-0004ej-Sz
 for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 20:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c0fEinkKwgxTDZrvt01hsjZR5fn5eT0B3rw9RIF3/RU=; b=UHiAv8CuHWf1o8pJOrywlCCKcY
 ewwJrmJK9U7i1KmBbMw8GXy9fdf8Xn0LBWOjl4K6XgLhcJ5wl1zmPc8fSjW6TxJx9JIEhRtTYNcox
 nLs+kpAL8VlXsaeRdkoy1c0p1egh33OoWzhDPG1pSMNBdkF758wNRB1Na0X5F1mVKmtQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c0fEinkKwgxTDZrvt01hsjZR5fn5eT0B3rw9RIF3/RU=; b=WMOGpYtJ5Ejn0z75yNVrnUUxce
 2ebFG70es6ag8bobzLKkRGM6f3oTFMAS08k0zN7G68RAjS4z+rGzrdBMGX8laQiWIFtrOZd0W8h4D
 LwBDY8L3X7C5McCTFXs8vVLa8vudWuHJJpmNQ+22z+itA/vBoGWQYblEG+5w2/LqQGNk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xAYii-0000x6-7b for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 20:10:05 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68QK9vVf024558
 for <openvpn-devel@lists.sourceforge.net>; Sat, 26 Sep 2026 22:09:57 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68QK9vg8024557
 for openvpn-devel@lists.sourceforge.net; Sat, 26 Sep 2026 22:09:57 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 26 Sep 2026 22:09:51 +0200
Message-ID: <20260926200956.24545-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
References: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xAYii-0000x6-7b
Subject: [Openvpn-devel] [PATCH v2] dco: stop fetching peer stats during
 client disconnect
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

From: Ralf Lici <ralf@mandelbit.com>

The disconnect path asks DCO for a fresh peer dump after the multi
instance has already been removed from the peer-id lookup table. For
kernel-initiated disconnects, the peer has also already been deleted by
the time its notification is processed. The reply therefore cannot
update the disconnecting instance.

Moreover, each disconnect dumps all surviving peers, causing avoidable
netlink traffic and repeated work when many clients disconnect at once.

During shutdown or restart, fetch a single final peer snapshot before
closing any instances, while all peers can still be mapped to their
userspace contexts.

For individual disconnects, use the cached counters directly. Kernels
that provide a final statistics snapshot in the deletion notification
can update them before the disconnect environment is prepared.

Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1952
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1952
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 299d7a3..38ca062 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -26,7 +26,7 @@
 # FP: posix.cfg claims suseconds_t is unsigned for some reason
 unsignedLessThanZero:src/openvpn/otime.h:148
 # IGN: multi code does weird things with pointers to local variables...
-autoVariables:src/openvpn/multi.c:4242
+autoVariables:src/openvpn/multi.c:4240
 autoVariables:src/openvpn/multi_io.c:324
 # IGN: the code header = 0 | (OPCODE << P_OPCODE_SHIFT) is used intentionally
 badBitmaskCheck:src/openvpn/mudp.c
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3e72b92..b7085dc 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -496,37 +496,29 @@
 }
 
 static void
-setenv_stats(struct multi_context *m, struct context *c)
+setenv_stats(struct context *c)
 {
-    if (dco_enabled(&m->top.options))
-    {
-        if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, false) < 0)
-        {
-            return;
-        }
-    }
-
     setenv_counter(c->c2.es, "bytes_received", c->c2.link_read_bytes + c->c2.dco_read_bytes);
     setenv_counter(c->c2.es, "bytes_sent", c->c2.link_write_bytes + c->c2.dco_write_bytes);
 }
 
 static void
-multi_client_disconnect_setenv(struct multi_context *m, struct multi_instance *mi)
+multi_client_disconnect_setenv(struct multi_instance *mi)
 {
     /* setenv client real IP address */
     setenv_trusted(mi->context.c2.es, get_link_socket_info(&mi->context));
 
     /* setenv stats */
-    setenv_stats(m, &mi->context);
+    setenv_stats(&mi->context);
 
     /* setenv connection duration */
     setenv_long_long(mi->context.c2.es, "time_duration", now - mi->created);
 }
 
 static void
-multi_client_disconnect_script(struct multi_context *m, struct multi_instance *mi)
+multi_client_disconnect_script(struct multi_instance *mi)
 {
-    multi_client_disconnect_setenv(m, mi);
+    multi_client_disconnect_setenv(mi);
 
     if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT))
     {
@@ -634,7 +626,7 @@
 
     if (mi->context.c2.tls_multi->multi_state >= CAS_CONNECT_DONE)
     {
-        multi_client_disconnect_script(m, mi);
+        multi_client_disconnect_script(mi);
     }
 
     close_context(&mi->context, SIGTERM, CC_GC_FREE);
@@ -659,6 +651,12 @@
 {
     if (m->hash)
     {
+        /* fetch final stats while all peers can still be mapped to their instances */
+        if (dco_enabled(&m->top.options))
+        {
+            dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, false);
+        }
+
         for (uint32_t i = 0; i <= m->max_peerid; i++)
         {
             struct multi_instance *mi = m->instances[i];
@@ -2750,7 +2748,7 @@
          * did not fail */
         if (mi->context.c2.tls_multi->multi_state == CAS_PENDING_DEFERRED_PARTIAL)
         {
-            multi_client_disconnect_script(m, mi);
+            multi_client_disconnect_script(mi);
         }
 
         mi->context.c2.tls_multi->multi_state = CAS_FAILED;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
