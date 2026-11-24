Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F9606A32E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RwAk4exA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VwoPOlKF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JgYYyJIO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=R6FOoaEp3G1MoqzzMPA/G8gAdh1wWVfF+cuIePZtTl8=; b=RwAk4exAYaUnB3
	7LIsz3JmgfAG42tlPGrNHVh1s7ilTnOaTDXRFvVyCzKi6JPYDMY1YUVSeMaNviqoMaTiVFEJ0SKAa
	316aLn2828GUKuWO2ekAiNUgY2oqcLJH6/hxAEwxQRsinS85jEtfdIuHcw07DQu5uDSe45GFCu3wu
	DO8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVvrU-000000001Sg-3rmW;
	Tue, 24 Nov 2026 19:07:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVvrC-000000001QZ-3ltO for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:07:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pUQ732BhG95VU+CixRmPyZh07G0dCY5CwkOtwWiD9wI=; b=VwoPOlKFWBTF05tBAy5p0zt8Ri
 QlSHIFQ+bXdD1uN1/nJbyoLLzksJhzjC8XMvtQCClCMK7C8eLY3uEsdSCpxCTy7Tj8eM938XMUIxB
 fNCQ+bEjtyTtT+q4HEGS9aawd2eaa5SBPl0oPkLoxEB6zW70Ldy58Q7gv++A+jfb1piA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pUQ732BhG95VU+CixRmPyZh07G0dCY5CwkOtwWiD9wI=; b=JgYYyJIOCJVeZNTW37A3QDQV9p
 Gnn1s7m9iq7T5cEuZIsvO2fetkJC3/CnxrVTfLEb6mOQ7gI2rigu4oemienG4zHeaCW3iCX65xqbv
 7B5K1UPk9bld0vLWnzNuwkKhKQDPo8JDkyxq5jKGFCbDFlGfDp31cGTC1HnU4vhIBl7I=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVvqx-00000000249-1epB for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:06:56 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AOJ6mC5016768
 for <openvpn-devel@lists.sourceforge.net>; Tue, 24 Nov 2026 20:06:48 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOJ6mGO016767
 for openvpn-devel@lists.sourceforge.net; Tue, 24 Nov 2026 20:06:48 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 24 Nov 2026 20:06:43 +0100
Message-ID: <20261124190648.16745-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
References: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVvqx-00000000249-1epB
Subject: [Openvpn-devel] [PATCH v2] manage: Fix conversion warnings in
 man_write
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

From: Frank Lichtenheld <frank@lichtenheld.com>

Use openvpn_send to avoid warnings due to
Windows/Unix differences.

Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2339
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2339
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index addd6f2..e917b35 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2448,11 +2448,6 @@
 
 #endif /* ifdef TARGET_ANDROID */
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static ssize_t
 man_read(struct management *man)
 {
@@ -2550,14 +2545,14 @@
 static ssize_t
 man_write(struct management *man)
 {
-    const int size_hint = 1024;
+    const size_t size_hint = 1024;
     ssize_t sent = 0;
 
     buffer_list_aggregate(man->connection.out, size_hint);
     const struct buffer *buf = buffer_list_peek(man->connection.out);
-    if (buf && BLEN(buf))
+    if (buf && BLEN(buf) > 0)
     {
-        const int len = min_int(size_hint, BLEN(buf));
+        const size_t len = min_size(size_hint, BLENZ(buf));
 #ifdef TARGET_ANDROID
         if (man->connection.fdtosend > 0)
         {
@@ -2568,7 +2563,7 @@
         else
 #endif
         {
-            sent = send(man->connection.sd_cli, CBSTR(buf), len, MSG_NOSIGNAL);
+            sent = openvpn_send(man->connection.sd_cli, CBSTR(buf), len, MSG_NOSIGNAL);
         }
         if (sent >= 0)
         {
@@ -2591,10 +2586,6 @@
     return sent;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 man_connection_clear(struct man_connection *mc)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
