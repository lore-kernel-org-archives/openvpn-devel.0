Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25C2606A32C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XzVSKNJG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ung15+jG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V0TDt/6A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=sjHZXaOsIF4Nh+9ruaLG6sXtK/ehvPTvUnbRDoMu2cU=; b=XzVSKNJG5bRyd+
	RVrbrAp+beMI7u0GP9bOxx2JpDIuS3qgVx47b1m62AXSxB0xzZsX6K/1LLc2d4ocMPFJIJ9eeUjub
	UyVIxUSCLrKbRjXj29tm5E6rAUF33Ft5Q09E7RHAMQqZaMBf9PTOrrL/uPrhpDSPVuu0VVtwbE/3V
	nSU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWf2I-000000002xr-11Vf;
	Thu, 26 Nov 2026 19:21:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWf2G-000000002xk-3JPP for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 19:21:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D28bNwFRxlFV2bOyJlWxOWBI010dSsuJ/H+RLpwKCvI=; b=Ung15+jGWOddqY/9V8bNELkZPK
 ChhKaAocPoqEpjBECs6HbheHor/VVK047HhaAnSzzGz1SleKbQF2R79EB3gAnT/gDHOaX9B57cZJ2
 h61WdK+avQsoNQ9enIcpTDxPXfWXw0qIrZh/RrpOSge7d4rtfUmG48/xZLzJjpuk/tW8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D28bNwFRxlFV2bOyJlWxOWBI010dSsuJ/H+RLpwKCvI=; b=V0TDt/6Aqz8/H/ISxlywPOOd9P
 M2zUsZwuJ84uxlqLrUUlHo46tSJAzgcjSGE3E4PWXXgplsOBhA/XLD1vg8QzEMd7a7CaZ2ZLISIw0
 mx7XnVnNVOD4FgLE0C2b3zBcv04WdhMqlJpnKr65A+pEaQ0nIsACWWrLmRefJZeFyk9U=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWf2F-0000000089u-0WGL for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 19:21:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AQJLSCn018891
 for <openvpn-devel@lists.sourceforge.net>; Thu, 26 Nov 2026 20:21:28 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQJLSHn018890
 for openvpn-devel@lists.sourceforge.net; Thu, 26 Nov 2026 20:21:28 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 20:21:22 +0100
Message-ID: <20261126192127.18879-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795714582000.I32f1edf8b289ea2f7fda35e32260909c6409344e@gerrit.openvpn.net>
References: <gerrit.1795714582000.I32f1edf8b289ea2f7fda35e32260909c6409344e@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWf2F-0000000089u-0WGL
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: Avoid sign conversion
 warnings related to string conversion
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

MultiByteToWideChar and similar functions take int and
return int. Nothing we can do about that except cast.

Change-Id: I32f1edf8b289ea2f7fda35e32260909c6409344e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2357
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2357
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index de7847e..6c1250b 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -30,11 +30,6 @@
 LPCWSTR service_instance = L"";
 static wchar_t win_sys_path[MAX_PATH];
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static DWORD
 GetRegString(HKEY key, LPCWSTR value, LPWSTR data, DWORD size, LPCWSTR default_value)
 {
@@ -300,11 +295,11 @@
 utf8to16_size(const char *utf8, int size)
 {
     int n = MultiByteToWideChar(CP_UTF8, 0, utf8, size, NULL, 0);
-    if (n == 0)
+    if (n <= 0)
     {
         return NULL;
     }
-    wchar_t *utf16 = malloc(n * sizeof(wchar_t));
+    wchar_t *utf16 = malloc((size_t)n * sizeof(wchar_t));
     if (!utf16)
     {
         return NULL;
@@ -313,10 +308,6 @@
     return utf16;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 const wchar_t *
 get_win_sys_path(void)
 {
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 0792a51..e99f8b5 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2760,7 +2760,7 @@
         size_t domains_len = strlen(domains);
         dom_size = (DWORD)domains_len + 2; /* len + the trailing NULs */
 
-        wide_domains = utf8to16_size(domains, dom_size);
+        wide_domains = utf8to16_size(domains, (int)dom_size);
         if (!wide_domains)
         {
             return ERROR_OUTOFMEMORY;
@@ -3917,9 +3917,9 @@
     CloseHandleEx(&stdin_read);
     CloseHandleEx(&svc_pipe);
 
-    DWORD input_size = WideCharToMultiByte(CP_UTF8, 0, sud.std_input, -1, NULL, 0, NULL, NULL);
+    int input_size = WideCharToMultiByte(CP_UTF8, 0, sud.std_input, -1, NULL, 0, NULL, NULL);
     LPSTR input = NULL;
-    if (input_size && (input = malloc(input_size)))
+    if (input_size > 0 && (input = malloc((size_t)input_size)))
     {
         DWORD written;
         WideCharToMultiByte(CP_UTF8, 0, sud.std_input, -1, input, input_size, NULL, NULL);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
