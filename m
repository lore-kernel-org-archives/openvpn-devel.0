Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934D9606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JIrwgVte;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=An4VP/Sv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QoglTbl7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1+Cl736hVRNohe6U0gZAc8+jfUvnkMDaS+VNqzQOurE=; b=JIrwgVteFPvVdd
	Neeliq0ltxW/UcVxLHJFvubGBgQWQE+iy72tihRIwBQ2QcyGKDsB5cPNfq3aoFjcQ6QjlaiC3IjbH
	7hMW6goSCJXomN+o+eBSjobMN1+a1Zf/HXnLCR2peTqIpk1qIuogngRcCp1V0VUwgxgdS8sP7LEaA
	Znc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV5tx-000000004Hu-1CPo;
	Sun, 22 Nov 2026 11:38:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xV5tv-000000004Ho-2HuR for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:38:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cYw5mMPiylWhi8c/a3QM4fNQuzYTMlv161qZ72KFOs8=; b=An4VP/SvfyBt7Gk0R/+cMRIYep
 HTLUYJ8QBXNhFppyg4ORmo3vAkdrHBR37rIgycpv1jJyqzAX8+R/VKL3nTp/XaE3YauHb8ZJQRXFQ
 p1C3E9I6czfCSNIsjjCkt0ge+z6OZ3xZwQwsCI8q7wmG4UN97SxYeX5v3G6+pajz4TMY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cYw5mMPiylWhi8c/a3QM4fNQuzYTMlv161qZ72KFOs8=; b=QoglTbl7s8YuPAXP3zo4DLTsAn
 ULoylDg1b5vYYpS9kuIIkKCopV6JQA+1eG2WiN0FDiOoEfww/CNTsp5dIxKNwRh38MZGUyblPATT2
 ARJGPbDP/XDqVQf9Q9BOgeuawVfcuF7/edJXXcsy3eOGngm3d4TuKqp4SCuLh8J1/J1o=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xV5tu-000000008HR-1Eue for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:38:31 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AMBcNN5000721
 for <openvpn-devel@lists.sourceforge.net>; Sun, 22 Nov 2026 12:38:23 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AMBcNsD000720
 for openvpn-devel@lists.sourceforge.net; Sun, 22 Nov 2026 12:38:23 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 22 Nov 2026 12:38:17 +0100
Message-ID: <20261122113822.710-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795190700000.Ied65202d269dedfa7ce69e62ef68d775ec0da36c@gerrit.openvpn.net>
References: <gerrit.1795190700000.Ied65202d269dedfa7ce69e62ef68d775ec0da36c@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xV5tu-000000008HR-1Eue
Subject: [Openvpn-devel] [PATCH v2] manage: use report_command_status() for
 client-deny, client-kill, push-update
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

These printed the same SUCCESS/ERROR lines by hand. Output is unchanged.

Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2231
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2231
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 86c498e..ab814d5 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1286,14 +1286,7 @@
         {
             const bool status = (*man->persist.callback.client_auth)(
                 man->persist.callback.arg, cid, kid, false, reason, client_reason, NULL);
-            if (status)
-            {
-                msg(M_CLIENT, "SUCCESS: client-deny command succeeded");
-            }
-            else
-            {
-                msg(M_CLIENT, "ERROR: client-deny command failed");
-            }
+            report_command_status(status, "client-deny");
         }
         else
         {
@@ -1312,14 +1305,7 @@
         {
             const bool status =
                 (*man->persist.callback.kill_by_cid)(man->persist.callback.arg, cid, kill_msg);
-            if (status)
-            {
-                msg(M_CLIENT, "SUCCESS: client-kill command succeeded");
-            }
-            else
-            {
-                msg(M_CLIENT, "ERROR: client-kill command failed");
-            }
+            report_command_status(status, "client-kill");
         }
         else
         {
@@ -1523,12 +1509,7 @@
         status = (*man->persist.callback.push_update_by_cid)(man->persist.callback.arg, cid, p[2]);
     }
 
-    if (status)
-    {
-        msg(M_CLIENT, "SUCCESS: push-update command succeeded");
-        return;
-    }
-    msg(M_CLIENT, "ERROR: push-update command failed");
+    report_command_status(status, "push-update");
 }
 
 static void


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
