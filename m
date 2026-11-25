Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15E606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WklpeZr5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GUAsG6Rw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bL50KLzm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=iiE8mOFiD9Sf1VJAvuRrYkNwkCMdVj5SBNEl2iZTuOc=; b=WklpeZr5poIMjH
	vYVOsB4Jz6VVCM5ZVxJIOMP2cG1atsfxhM3YsGfLwLL2l7YpkSA5CRQS6Prny67z5oARZ9zHj3m5y
	CHPRTi4Y8jwmL+0pYNh6QIxGkmSLAjWrX4zKtzraAlO1uz+qksvkHFLYXfHZmocY6GWODKqTx0gvE
	mdk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWEmp-000000007xx-3mrh;
	Wed, 25 Nov 2026 15:19:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWEmg-000000007xm-1jdk for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 15:19:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ldEXhkxr8vojrbY5sKdtZm4cvqcgPHNOopjU5XYubkQ=; b=GUAsG6Rwbm/u8p7ysBIbLEDl6G
 q+uyWEfXFWngbDRa36qC+44XK93XwCK448pkdNuiKaHJWXyOUT0Fr0p/uWkS+GvltfI8yW6UO++H4
 Z8NbW+ZhNdaKLacpTPUQWs1JavRduywPRT6X2ibD9+YOWL28z6WDZf1fkslKABGpaux8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ldEXhkxr8vojrbY5sKdtZm4cvqcgPHNOopjU5XYubkQ=; b=bL50KLzmE8AZJws8gJk1heu9SS
 hVB6e5ockobf3uyEHJP+osIo6VhUx4zc8Yc7e4+R4smxpVv2SlfVSPFFnfJVTzudJBDuWWwPc/ljR
 H51QyD6Ylb4MneowzULegGdC+YJGfo5h3cvN98WLWbEjlxG3K8qvYa2GeK8WH+7XNoKk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWEme-000000005WE-2FYA for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 15:19:46 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6APFJbWm010309
 for <openvpn-devel@lists.sourceforge.net>; Wed, 25 Nov 2026 16:19:37 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6APFJbYn010299
 for openvpn-devel@lists.sourceforge.net; Wed, 25 Nov 2026 16:19:37 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 25 Nov 2026 16:19:31 +0100
Message-ID: <20261125151936.10270-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795613903000.I8d081c87af0d746a5e3a2382567f04332639622a@gerrit.openvpn.net>
References: <gerrit.1795613903000.I8d081c87af0d746a5e3a2382567f04332639622a@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWEme-000000005WE-2FYA
Subject: [Openvpn-devel] [PATCH v1] cppcheck: Add more printf-style functions
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

Also fix the two issues raised by this.

Change-Id: I8d081c87af0d746a5e3a2382567f04332639622a
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2343
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2343
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/openvpn-cppcheck-library.cfg b/dev-tools/openvpn-cppcheck-library.cfg
index 0537b39..37195d8 100644
--- a/dev-tools/openvpn-cppcheck-library.cfg
+++ b/dev-tools/openvpn-cppcheck-library.cfg
@@ -6,6 +6,12 @@
       <formatstr />
     </arg>
   </function>
+  <function name="argv_printf">
+    <formatstr type="printf"/>
+    <arg nr="2">
+      <formatstr />
+    </arg>
+  </function>
   <function name="buf_printf">
     <formatstr type="printf"/>
     <arg nr="2">
diff --git a/dev-tools/openvpn-cppcheck-windows.cfg b/dev-tools/openvpn-cppcheck-windows.cfg
index 932d586..dca2b07 100644
--- a/dev-tools/openvpn-cppcheck-windows.cfg
+++ b/dev-tools/openvpn-cppcheck-windows.cfg
@@ -2,6 +2,12 @@
 <!-- Only used for the Windows run. Can't be in openvpn-cppcheck-library.cfg
      because it conflicts with gnu.cfg. -->
 <def>
+  <function name="MsgToEventLog">
+    <formatstr type="printf"/>
+    <arg nr="2">
+      <formatstr />
+    </arg>
+  </function>
   <!-- MinGW uses GCC, so we need to handle GCC builtins. gnu.cfg has these,
        but we do not load it for Windows. Without this cppcheck does not
        understand our likely()/unlikely() macros. -->
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 6c4c8f4..b079757 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -112,7 +112,7 @@
 {
     struct argv argv = argv_new();
 
-    argv_printf(&argv, "%s link set dev %s up mtu %d", iproute_path, iface, mtu);
+    argv_printf(&argv, "%s link set dev %s up mtu %u", iproute_path, iface, mtu);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link set failed");
 
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index be57d43..ad0fda2 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -466,7 +466,7 @@
     size = bytes / sizeof(*data);
     if ((size == 0) || (size > 4096)) /* our startup data is 1024 wchars at the moment */
     {
-        MsgToEventLog(M_SYSERR, L"malformed startup data: %lu bytes received", size);
+        MsgToEventLog(M_SYSERR, L"malformed startup data: %zu bytes received", size);
         ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);
         goto err;
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
