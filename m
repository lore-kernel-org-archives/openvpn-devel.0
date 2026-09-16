Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70050C982C9
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SzP4EK6BBMrdN7pwMoPT5QIvaLPuDqRtacXN51gHfS4=; b=I/bwgyfK6LnOKZVprpX3oWVW/7
	VT7Uxh6LkksBz8CMaIozYWNVhLljK8i+p8EmJqklkFFnVvCFbgYZQRU9jcnmghrTcMFkSJM98Kn6q
	dM9nFe3cxyMAdXbl6WnQVdtgNd9TE66uIjy4sb2/+bvKKPj/cAEOBZqpnSkn829Dow9Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6wL2-0000sX-GS;
	Wed, 16 Sep 2026 20:34:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x6wKx-0000sO-Hs
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 20:34:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dz5zre3qoD+aq1tG23h/KVZTvBuyCOD7qgFrTOzJofk=; b=MxDUhr0l6n5chd/LpKKmGPFmwv
 /40vaVbaHUAqmUydPjLCXtbSRQ62C8WI4DIn6q4o9Bd7o6iG8KRHd/UEAGgPX+popZovoEWeb6fL6
 A8xg7PlShf2PqUYMtSwIEToXgFmMhOIRlR/V54tmn9MupKm74L3Sv/oGKKC9s1tQyDIY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Dz5zre3qoD+aq1tG23h/KVZTvBuyCOD7qgFrTOzJofk=; b=I224P18PYVw7yv0bV0oAI5fjo3
 BTG2HzJJ3/nCZmIfxMM6ObrqaFU626bdsxbLlOyFE0E9AjIfhE18onzT+qmOb/yIRpxYFDq7t4IUF
 Ugaok3RLJ9vqC5bGgTU4jWUzD/2jtxjl7tqRiM82RN1YZferQN3Via0ToxMeJKXW2sEY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6wKu-0007yV-BI for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 20:34:33 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68GKYPHY021463
 for <openvpn-devel@lists.sourceforge.net>; Wed, 16 Sep 2026 22:34:25 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68GKYPAf021462
 for openvpn-devel@lists.sourceforge.net; Wed, 16 Sep 2026 22:34:25 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 22:34:19 +0200
Message-ID: <20260916203425.21448-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1789560307000.Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0@gerrit.openvpn.net>
References: <gerrit.1789560307000.Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x6wKu-0007yV-BI
Subject: [Openvpn-devel] [PATCH v1] Improve auth token related comments
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

Change-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1918
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1918
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index f928a41..b457b6f 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -22,7 +22,7 @@
 #define AUTH_TOKEN_SESSION_ID_BASE64_LEN (OPENVPN_BASE64_LENGTH(AUTH_TOKEN_SESSION_ID_LEN))
 
 /* We want our token to be a multiple of 3 bytes to avoid the base64 padding */
-static_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 == 0, "AUTH_TOKEN_SESSION_ID_LEN needs to be multiple a 3");
+static_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 == 0, "AUTH_TOKEN_SESSION_ID_LEN must be multiple of 3");
 
 #define AUTH_TOKEN_HMAC_LEN   SHA256_DIGEST_LENGTH
 /* Size of the data of the token (not b64 encoded and without prefix) */
@@ -34,7 +34,7 @@
 
 /* Ensure that TOKEN_DATA_LEN is a multiple of 3 so the we avoid the base64
  * padding */
-static_assert(TOKEN_DATA_LEN % 3 == 0, "TOKEN_DATA_BASE64_LEN is not a multiple of 3");
+static_assert(TOKEN_DATA_LEN % 3 == 0, "TOKEN_DATA_LEN is not a multiple of 3");
 
 bool
 is_auth_token(const char *password)
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index fd8317d..62ac012 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -109,16 +109,14 @@
 #define SESSION_ID_PREFIX "SESS_ID_AT_"
 
 /**
- * Return if the password string has the format of a password.
+ * Return if the password string has the format of an auth token.
  *
- * This function will always read as many bytes as SESSION_ID_PREFIX is longer
- * the caller needs ensure that password memory is at least that long (true for
- * calling with struct user_pass)
  * @param password
  * @return whether the password string starts with the session token prefix
  */
 bool
 is_auth_token(const char *password);
+
 /**
  * Checks if a client should be sent a new auth token to update its
  * current auth-token


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
