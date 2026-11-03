Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B35608363D
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ud5I92YV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G4gzhYx8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gNNjRq2k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xXzTAEYHlYY4OtGRL6FfQOKCudWmdZDGKQw0AahQAmY=; b=Ud5I92YV0ATMF+
	I2YqY2smiv+0O075fxW9zXVRnhB6c22mGVMoTNo7TEKRascN6ri5WcsbjEVOgHuguUdyx+ioOaX/o
	/AF+RRzx6kTOQz0wurstZ/W9ea5Qj7d/1YCbvhiDxMIvVOIQtMeGnWr2Zvae7Tn0qLyMZaEnQtImJ
	7CI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOBSx-000000005iV-1BuR;
	Tue, 03 Nov 2026 10:10:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOBSu-000000005iO-3zJO for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:10:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MByE9S/eMrHhup+uSc9T+T+CQLJXSjnkO3VVIurWKhQ=; b=G4gzhYx8wEQ4e9UTz7z3W/Ysim
 ldU6mWHBCpYmIPtInSqDJDv6EUdYXT31T9+aRgqe15Kev/A2ixwcTiZpgV+juy8CVaCSI8pBlq4D/
 qEyzD9Sj7JjPlz3k9Ry0A3dOek3eedEAfJu/VEFKVTOIwKU8ie/F2vmjTq+YLLACiX+I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MByE9S/eMrHhup+uSc9T+T+CQLJXSjnkO3VVIurWKhQ=; b=gNNjRq2kqY8/enZMgCPU2oenSN
 bXHzC5ITHM6Rzxjkg7RD2Wke8ZNB1KyZJJqEB4Mkk9r1q38WGMWwSJJ9f2PM6wE+YK5dXRy+pL+R+
 TKUsVog8F6jjTWSVJhSQq1Xfq+/Bn+j1SBbR9WBKnQEZ3iSdNE3hhjJ1AJTnwk62cmJs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOBSs-000000007cu-3xoK for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:10:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A3A9tna020928
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 11:09:55 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3A9tUH020927
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 11:09:55 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 11:09:50 +0100
Message-ID: <20261103100955.20917-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOBSs-000000007cu-3xoK
Subject: [Openvpn-devel] [PATCH v14] Introduce get_key_by_management_key_id
 helper function
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

From: Arne Schwabe <arne@rfc2549.org>

This function allows us to map from a management key id to a key structure
and also allows this function to be reused.

Patch v2: add message when key is not found.
Patch v3: only consider valid keys

Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1856
Message-Id: <20261102134628.26248-1-gert@greenie.muc.de>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40434.html
Signed-off-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1856
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1856
This mail reflects revision 14 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 579f46c..9a55ead 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -764,4 +764,24 @@
     return &multi->session[TM_ACTIVE].key[KS_PRIMARY];
 }
 
+#ifdef ENABLE_MANAGEMENT
+/**
+ * Gets the \c key_state object that belongs to the management key id or
+ * return NULL if not found.
+ */
+static inline struct key_state *
+get_key_by_management_key_id(struct tls_multi *multi, unsigned int mda_key_id)
+{
+    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *ks = get_key_scan(multi, i);
+        if (ks->mda_key_id == mda_key_id && ks->state > S_UNDEF)
+        {
+            return ks;
+        }
+    }
+    return NULL;
+}
+#endif
+
 #endif /* SSL_COMMON_H_ */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 73e3696..7baa4fc 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1250,22 +1250,24 @@
 tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, const bool auth,
                      const char *client_reason)
 {
-    bool ret = false;
+    struct key_state *ks = NULL;
     if (multi)
     {
-        int i;
         auth_set_client_reason(multi, client_reason);
-        for (i = 0; i < KEY_SCAN_SIZE; ++i)
+        ks = get_key_by_management_key_id(multi, mda_key_id);
+
+        if (ks)
         {
-            struct key_state *ks = get_key_scan(multi, i);
-            if (ks->mda_key_id == mda_key_id)
-            {
-                ks->mda_status = auth ? ACF_SUCCEEDED : ACF_FAILED;
-                ret = true;
-            }
+            ks->mda_status = auth ? ACF_SUCCEEDED : ACF_FAILED;
+        }
+        else
+        {
+            msg(D_TLS_DEBUG_LOW,
+                "%s: no key state found for management key id %u",
+                __func__, mda_key_id);
         }
     }
-    return ret;
+    return (bool)ks;
 }
 #endif /* ifdef ENABLE_MANAGEMENT */
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
