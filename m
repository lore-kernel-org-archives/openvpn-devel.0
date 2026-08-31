Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FD3C61DD3
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pxUF655pUnPdPYDCjJfgvab9WFA+qZ3jN6gvytlnf1k=; b=ZsqdwbfRgI5GIwJVfVDDX8gEmj
	SxGxZx+PsBbVOecycyzljvHEj0oTfqbUQfbHeWzPOW90o+htkrzackpsXOtxApE9Z2l54erS30ezp
	TnHVSo/CqeNB5gYHY2W4h1rYqSNoncoqG1ThDS3E6GoQ6/cQA3t54+f4nGKiCUwNS+XQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x172U-0003tr-5M;
	Mon, 31 Aug 2026 18:47:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x172S-0003tj-MF
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 18:47:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1I+V9dlUvTt2iZ3poEpxGDjxUGuiL7/8jpJSf6t/ls4=; b=dvwzPZz+IstOgN58rlSj3+a5bB
 GXRiNYtAnMaa7+5z+DtAGddK2cHHy6j3FaGfAtS2UgxLVQK57eQ/gEH/pUh2VnlTdVRE5Ouda+D1c
 pnIs8bUu542hA5l1nU+7LhveDbAKSKINPR0SMsKycmePVUYbFL2HWSk0bHdpk4+UOYNw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1I+V9dlUvTt2iZ3poEpxGDjxUGuiL7/8jpJSf6t/ls4=; b=TU7bJVBYbCyl8P86jiSR4ioy/H
 bv5yWfQliWnACV6w69yLyh6XIcnKTkbRD9k93vk+xOdTQAi/Wc5zRhxAuZzPdksmaUSRSaH3sTCVr
 ivHgk+HjytyxDovZCpP1K8+fWzdxfKHwmhsYaNsLVZl/cQVdiLL1bup0DqboAe6DqBf0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x172K-0004BM-V7 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 18:47:19 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67VIlAdK003380
 for <openvpn-devel@lists.sourceforge.net>; Mon, 31 Aug 2026 20:47:10 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67VIlAYg003379
 for openvpn-devel@lists.sourceforge.net; Mon, 31 Aug 2026 20:47:10 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 31 Aug 2026 20:47:04 +0200
Message-ID: <20260831184709.3359-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788192180000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
References: <gerrit.1788192180000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x172K-0004BM-V7
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: harden CheckConfigPath() a
 bit more
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

If the config_path retrieved from the Registry doesn't end with a path
sepatator, the prefix check could be satisfied by a sibling directory
that starts with the same substring, e.g. "config" vs. "configx". While
code in common.c ensures this, that code could disappear in the future
leaving the check vulnerable. Instead spend the few CPU cycles to be
absolutely sure, we're doing the right thing here.

Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2.
Contributing Researcher: Vivek Parikh.

Reported-by: Vivek Parikh <vivek.parikh@breachx.ai>
CVE: 2026-78043
Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1886
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1886
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index e3ef8b6..8e529b9 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -62,7 +62,13 @@
 {
     HRESULT res;
     WCHAR config_path[MAX_PATH];
+    const size_t config_dir_len = wcslen(s->config_dir);
 
+    /* config_dir must end with a '\' or the prefix check below could be satisfied by a sibling directory */
+    if (config_dir_len == 0 || s->config_dir[config_dir_len - 1] != L'\\')
+    {
+        return FALSE;
+    }
     /* fname = stdin is special: do not treat it as a relative path */
     if (wcscmp(fname, L"stdin") == 0)
     {
@@ -83,7 +89,7 @@
         res = PathCchCanonicalize(config_path, _countof(config_path), fname);
     }
 
-    return res == S_OK && wcsnicmp(config_path, s->config_dir, wcslen(s->config_dir)) == 0;
+    return res == S_OK && wcsnicmp(config_path, s->config_dir, config_dir_len) == 0;
 }
 
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
