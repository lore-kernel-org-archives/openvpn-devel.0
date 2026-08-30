Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C17C61DE2
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t/xk8RfJqAKoRHIteztoszF7JCxp7rTDBRg67+n0LLA=; b=IDQuO0V7PusYPoXaihhz3umadN
	2BfONjePflaKZoWKvE82dIjvhwubhFIz7ZqOcEnwJm8Le/Mcl1zCCbbQ1yQUH9bEJQ1WqQB0GqJB3
	sKZW6Z42pcrD1kJldEXxVE1OK3xDPw38xtCZnkK5vk29XsXqA+RM3lyHzdVjli8xyh+c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0kA4-0006Ox-Ja;
	Sun, 30 Aug 2026 18:21:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x0kA2-0006Oq-TB
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 18:21:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AJVkQbYirw5Bz2LYrRLVUcNjDlivlFTkwAskazo1ezk=; b=SpxxjiTpHYEJFlsvLk7EYZhWX9
 nIGivLIMPVbszWWy3xgTViQfdKYXJcK3Rp97/R7RwUetNqVAO7XwKc/fYb+2tmvLHrsa3XsBWq8Xe
 zcRXR67Cq3ZK9PD9f+CV8WQbnciLgso2i0oY3hKJtc4X3U/8i/daDso7vhMjlIv8ZGu4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AJVkQbYirw5Bz2LYrRLVUcNjDlivlFTkwAskazo1ezk=; b=l7qyEwno8SkC2biHT29WW1aulC
 8WSWTDdwS2yfF68yJFdIIER3QojvttwWZNJJVqTw7pgWsMHz8gjlL7b3NYRvwFIsUsvMOjjizQ7rQ
 7Qhy5v3iWc1z89CH4Ga+T2KyniJdafKpEOGDCbyeqh81odN7M+8MWdNpiwGu/570li+w=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0kA1-0002lH-QJ for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 18:21:42 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67UILYHG032284
 for <openvpn-devel@lists.sourceforge.net>; Sun, 30 Aug 2026 20:21:34 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67UILYen032283
 for openvpn-devel@lists.sourceforge.net; Sun, 30 Aug 2026 20:21:34 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 30 Aug 2026 20:21:27 +0200
Message-ID: <20260830182134.32251-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788113537000.Ica5d43989b441d4377a3908f811a2953b7a9d45a@gerrit.openvpn.net>
References: <gerrit.1788113537000.Ica5d43989b441d4377a3908f811a2953b7a9d45a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x0kA1-0002lH-QJ
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: detect sibling dirs in
 CheckConfigPath
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

From: Heiko Hund <heiko@ist.eigentlich.net>

If the config_dir value in the registry has no trailing backslash the
check doesn't actually guarantee that a file is located within
config_dir, because a sibling dir with the same prefix, e.g. 'config'
and 'config-evil' will match and produce a positive verdict.

By also checking that there is a path separator after config_dir
prevents this attack.

Reported-By: Harshit Varu <harshitvaru666@gmail.com>
Tested-By: Harshit Varu <harshitvaru666@gmail.com>
CVE: 2026-81830
Github: OpenVPN/openvpn-private-issues#166
Change-Id: Ica5d43989b441d4377a3908f811a2953b7a9d45a
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1883
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1883
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 770a7a0..b0fb6b85 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -56,7 +56,9 @@
 
 /*
  * Check workdir\fname is inside config_dir
- * The logic here is simple: we may reject some valid paths if ..\ is in any of the strings
+ * The logic here is simple:
+ *      we may reject some valid paths if ".." is in the filename
+ *      or if there's no "\" after the config directory
  */
 static BOOL
 CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, const settings_t *s)
@@ -82,9 +84,18 @@
     }
 
     config_dir = s->config_dir;
+    size_t config_dir_len = wcslen(config_dir);
 
-    if (wcsncmp(config_dir, config_file, wcslen(config_dir)) == 0
-        && wcsstr(config_file + wcslen(config_dir), L"..") == NULL)
+    /* check for a path separator after config_dir */
+    if (config_dir_len && config_dir_len < wcslen(config_file)
+        && config_dir[config_dir_len - 1] != L'\\'
+        && config_file[config_dir_len] != L'\\')
+    {
+        return FALSE;
+    }
+
+    if (wcsncmp(config_dir, config_file, config_dir_len) == 0
+        && wcsstr(config_file + config_dir_len, L"..") == NULL)
     {
         return TRUE;
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
