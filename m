Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299CDC982C9
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FQxaBH0R44Jo+zhCdi3+s02DEDki5gANd5bsygAX3p8=; b=GogKigCqeKdo28a4xhyw8W/z41
	4gEj/TptPEfFxDcF2r5TMESp3wXDJ4xtjvorNVq5mwi75e/Xg9+PqoMUfX4oJSHYfQbRMOevGbh5g
	Lc6YK8xF1VwMpzOAfeWu3SD/chEs/pmKLwopf0bSGBAsu8FfJjfWqT9k4NiPoJ4LtvKE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6smk-0005fO-QI;
	Wed, 16 Sep 2026 16:47:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x6smi-0005f9-HL
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 16:47:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/qQEZtK9IqG5Eq74ubF6tv1aRugigVkJ8GRmWqMhGMM=; b=TSo8voVmCq7MuHneFSFoRiSIMI
 Z3x/NT3MnPgdDrHSC4noXbLazcB54g8UuF8arSLbDIweawqTAfrXIMhgVfeyWY35l0ZpM3jTid4q1
 cbtpzPfYUUyZZU0xC2Z5ygi/64Ogjeb9xwqkkY6HTI4smRVYSnxLoB0f+2CQ01o3RaNk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/qQEZtK9IqG5Eq74ubF6tv1aRugigVkJ8GRmWqMhGMM=; b=geHu3jy54/ot8+KJFmEHik8Fjt
 5lGmN00AJs+f8EOAQEjobmTALFFw4EMpLr+00VY79Co5Cko3zn3VkA/XksibejKGzC2vqxTRlZz+o
 gYcst3JhY7h2dqj/O1waRCep/BRHb+U/HUQm+jlld8f7MS/uX9keR0nH39gNKWstONrQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6sme-0005de-L6 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 16:47:01 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68GGkmwJ031310
 for <openvpn-devel@lists.sourceforge.net>; Wed, 16 Sep 2026 18:46:48 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68GGkmf7031309
 for openvpn-devel@lists.sourceforge.net; Wed, 16 Sep 2026 18:46:48 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 18:46:43 +0200
Message-ID: <20260916164648.31293-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
References: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x6sme-0005de-L6
Subject: [Openvpn-devel] [PATCH v3] Backport stricter check for valid tokens
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

From: Arne Schwabe <arne@rfc2549.org>

OpenVPN 2.5 does not have the logic to keep a session id for the auth
token. So it does not suffer the same problem that 2.6 and 2.7 did
(CVE 2026-13122).

However the improvement that we are a lot stricter to check what might
be an auth token is a good thing to backport as well to avoid any other
potential issues that might be there.

Partial cherry pick from ee119b24b3. This drops the parts that are not
present in 2.5 and also forgoes back porting the new unit tests.

Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1766
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.5.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1766
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 7c4d15d..5205ef3 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -21,12 +21,33 @@
 const char *auth_token_pem_name = "OpenVPN auth-token server key";
 
 #define AUTH_TOKEN_SESSION_ID_LEN 12
-#if AUTH_TOKEN_SESSION_ID_LEN % 3
-#error AUTH_TOKEN_SESSION_ID_LEN needs to be multiple a 3
-#endif
+#define AUTH_TOKEN_SESSION_ID_BASE64_LEN (OPENVPN_BASE64_LENGTH(AUTH_TOKEN_SESSION_ID_LEN))
 
+/* We want our token to be a multiple of 3 bytes to avoid the base64 padding */
+static_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 == 0, "AUTH_TOKEN_SESSION_ID_LEN needs to be multiple of 3");
+
+#define AUTH_TOKEN_HMAC_LEN   SHA256_DIGEST_LENGTH
 /* Size of the data of the token (not b64 encoded and without prefix) */
-#define TOKEN_DATA_LEN (2 * sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN + 32)
+#define TOKEN_DATA_LEN        (2 * sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN + AUTH_TOKEN_HMAC_LEN)
+#define TOKEN_DATA_BASE64_LEN (OPENVPN_BASE64_LENGTH(TOKEN_DATA_LEN))
+
+
+#define TOTAL_SESSION_TOKEN_LEN (strlen(SESSION_ID_PREFIX) + TOKEN_DATA_BASE64_LEN)
+
+/* Ensure that TOKEN_DATA_LEN is a multiple of 3 so the we avoid the base64
+ * padding */
+static_assert(TOKEN_DATA_LEN % 3 == 0, "TOKEN_DATA_LEN is not a multiple of 3");
+
+bool
+is_auth_token(const char *password)
+{
+    if (strlen(password) != TOTAL_SESSION_TOKEN_LEN)
+    {
+        return false;
+    }
+
+    return (memcmp_constant_time(SESSION_ID_PREFIX, password, strlen(SESSION_ID_PREFIX)) == 0);
+}
 
 static struct key_type
 auth_token_kt(void)
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index 0fa4dba..075b662 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -115,18 +115,11 @@
 #define SESSION_ID_PREFIX "SESS_ID_AT_"
 
 /**
- * Return if the password string has the format of a password.
+ * Return if the password string has the format of an auth token.
  *
- * This fuction will always read as many bytes as SESSION_ID_PREFIX is longer
- * the caller needs ensure that password memory is at least that long (true for
- * calling with struct user_pass)
  * @param password
  * @return whether the password string starts with the session token prefix
  */
-static inline bool
-is_auth_token(const char *password)
-{
-    return (memcmp_constant_time(SESSION_ID_PREFIX, password,
-                                 strlen(SESSION_ID_PREFIX)) == 0);
-}
+bool
+is_auth_token(const char *password);
 #endif /* AUTH_TOKEN_H */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
