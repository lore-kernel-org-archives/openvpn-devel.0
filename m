Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3265606A32F
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=e5J/mETF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NYuqcXFu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PjXLFd36
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bIJkY50QRBxltRbYZo/dzYr2vZGh/QJLfo7XzrD/C4M=; b=e5J/mETFMQo1K7
	UDNLLRnWexi0b23qagSyHHjmnFSnIxAo0Y82CnOZdct12GfRNjEv69CoXTFlCBpqMs4tTc4qMkAw/
	i58cdsqcXXNhSqAcXikFg5VdwDLSR2xhwaCkoQkRRaPeHDMFIQtOvfN6RC42oWen81DRfR+HMyCUZ
	2eY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTiXW-000000002oP-0Tmy;
	Wed, 18 Nov 2026 16:29:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTiXV-000000002oJ-1zLa for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:29:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5hvtEy1lceULP5sIzzHjL1HV8JxRdMefU9Pl9/sa+6M=; b=NYuqcXFugrEt/tewHvw9BQCDfd
 mOguuKpJwL/WykliRAQtddm8mmAIFRACs5R/avCm/IG2Hvi0+Ni0aOxgMp/9XYgCqCyCrfP7S3iuK
 96eUmzYqvZZNrqe9TD3skB2pvVp/T349OXMLG+YHydctI005DvDWiJ/uj6xHoxyuA0p4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5hvtEy1lceULP5sIzzHjL1HV8JxRdMefU9Pl9/sa+6M=; b=PjXLFd365WsdWFq3gwK/RyM5+P
 BlwwVeBxdpiq1ZT0Wngu1utTXBog2ACYPmUTuuwfH1/w/51qQyUcv3RrC+slEZ/KuW9z8X4DvzWad
 Uf7nxve+Iw/tHkqnZbysR64OClUeSU84t1X7Zb0w75Fls5QbTV1JI9Nhrkhp6JGlP3Zg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTiXT-000000005wU-3KRG for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:29:41 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AIGTWY8022675
 for <openvpn-devel@lists.sourceforge.net>; Wed, 18 Nov 2026 17:29:32 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AIGTWJY022674
 for openvpn-devel@lists.sourceforge.net; Wed, 18 Nov 2026 17:29:32 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 18 Nov 2026 17:29:27 +0100
Message-ID: <20261118162932.22639-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
References: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTiXT-000000005wU-3KRG
Subject: [Openvpn-devel] [PATCH v2] ssl_verify: use
 check_for_client_reason() in tls_authentication_status()
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

tls_authentication_status() open-coded check_for_client_reason() for
the plugin and script auth status. Call the helper instead.
key_state_check_auth_failed_message_file() had no other caller, so
fold it into the helper.

Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2217
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2217
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 8641d15..f33a59c 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1037,24 +1037,22 @@
 }
 
 /**
- * Checks if the auth failed reason file has any content and if yes it will
- * be returned as string allocated in gc to the caller.
- */
-static char *
-key_state_check_auth_failed_message_file(const struct auth_deferred_status *ads,
-                                         struct gc_arena *gc)
+ * Check if the script/plugin left a message in the auth failed message
+ * file and relay it to the user */
+static void
+check_for_client_reason(struct tls_multi *multi, const struct auth_deferred_status *ads)
 {
-    char *ret = NULL;
     if (ads->auth_failed_reason_file)
     {
-        struct buffer reason = buffer_read_from_file(ads->auth_failed_reason_file, gc);
+        struct gc_arena gc = gc_new();
+        struct buffer reason = buffer_read_from_file(ads->auth_failed_reason_file, &gc);
 
         if (BLEN(&reason))
         {
-            ret = BSTR(&reason);
+            auth_set_client_reason(multi, BSTR(&reason));
         }
+        gc_free(&gc);
     }
-    return ret;
 }
 
 
@@ -1221,21 +1219,9 @@
 #endif
     if (failed_auth)
     {
-        struct gc_arena gc = gc_new();
         const struct key_state *ks = get_primary_key(multi);
-        const char *plugin_message =
-            key_state_check_auth_failed_message_file(&ks->plugin_auth, &gc);
-        const char *script_message =
-            key_state_check_auth_failed_message_file(&ks->script_auth, &gc);
-
-        if (plugin_message)
-        {
-            auth_set_client_reason(multi, plugin_message);
-        }
-        if (script_message)
-        {
-            auth_set_client_reason(multi, script_message);
-        }
+        check_for_client_reason(multi, &ks->plugin_auth);
+        check_for_client_reason(multi, &ks->script_auth);
 
         /* We have at least one session that failed authentication. There
          * might be still another session with valid keys.
@@ -1243,7 +1229,6 @@
          * with the other session (and we actually did that in earlier
          * version, this behaviour is really strange from a user (admin)
          * experience */
-        gc_free(&gc);
         return TLS_AUTHENTICATION_FAILED;
     }
     else if (success)
@@ -1305,20 +1290,6 @@
  * this is the place to start.
  *************************************************************************** */
 
-/**
- * Check if the script/plugin left a message in the auth failed message
- * file and relay it to the user */
-static void
-check_for_client_reason(struct tls_multi *multi, const struct auth_deferred_status *status)
-{
-    struct gc_arena gc = gc_new();
-    const char *msg = key_state_check_auth_failed_message_file(status, &gc);
-    if (msg)
-    {
-        auth_set_client_reason(multi, msg);
-    }
-    gc_free(&gc);
-}
 /*
  * Verify the user name and password using a script
  */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
