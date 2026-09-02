Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3336C61DD6
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4HIvmlRBNmS1rgdWLqAsvhytqit4bSqxkyRNc4i+Ilc=; b=W3r2uP1jRQLEyKS9ZKK9inQRrp
	scl/gHKxpgWmVNih9G7Jq0CkPyj9haTZ+UqG9VMZToGmZj74/SayiqAezv+vBgRFyoVW8/Dxl+Hcr
	rQRQwSxhtDDWRsytmkFqizMlNJGH+tC8jqQ4mBa0YzrQeeEMiS28ehk5uvHdCOp6cqaw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1jrH-0001vh-Ff;
	Wed, 02 Sep 2026 12:14:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x1jrF-0001va-No
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 12:14:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AtRgBiSWWZZZa5dW6vqtW2fyShZr4mSrFXog83NOaKM=; b=W5gZlJNuvwj8q237f5Mgw3/1qC
 FnMJXu2raUmTfNn0xOqBEjblxTDnfdTGpkqFB1SxVl2xEVPj9Y3kuyqNPEk+CDobmSK0aSOi0Q0Hx
 UvTsbqEKLJttY9viX7N8/AbnXs5FuSsZOk6O3CqydStc5AbU7LVwBVtLqmroiwi+CjRc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AtRgBiSWWZZZa5dW6vqtW2fyShZr4mSrFXog83NOaKM=; b=Vh5e4MWHBhi1aKZZ7w8bCXEr8m
 aESzo+N7eoO35Fq6fcNYt+ebkNHVo1ygz+W1FKAg6TxcTWSoKweITLJSqt+cJpBIhW8hbwcZDw97l
 TYayPP1HyK4A7OW5hmg4y3FIo1o6RhN+1fXQsWFhTysKITx10ognpIvmdU/0uFXySfSk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1jrD-0003Fm-VR for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 12:14:25 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 682CEHGj007069
 for <openvpn-devel@lists.sourceforge.net>; Wed, 2 Sep 2026 14:14:17 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 682CEHVB007068
 for openvpn-devel@lists.sourceforge.net; Wed, 2 Sep 2026 14:14:17 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  2 Sep 2026 14:14:09 +0200
Message-ID: <20260902121416.7047-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788295708000.I68429deb39c0bae335d46a4170973a14c644ccf9@gerrit.openvpn.net>
References: <gerrit.1788295708000.I68429deb39c0bae335d46a4170973a14c644ccf9@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x1jrD-0003Fm-VR
Subject: [Openvpn-devel] [PATCH v1] win32: quote arguments that cmd.exe
 would reinterpret
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

From: Lev Stipakov <lev@openvpn.net>

wide_cmd_line() only quoted arguments containing a space, so & | < > ^ %
( ) and ! were passed unquoted. CreateProcess() runs .bat and .cmd files
through cmd.exe, which parses the command line again, so a certificate
subject passed to --tls-verify could start a second command (CERT/CC
VU#123335).

Quote on those characters too. Double quotes are already replaced with
'_', so nothing else needs escaping. The delimiters , ; and = are left
out: cmd.exe uses them to separate %1..%9 but cannot run anything with
them, and quoting them would change what existing scripts receive.

GitHub: OpenVPN/openvpn-private-issues#159
Reported-By: Clouditera Security; Z.ai Security; NSFOCUS <security@clouditera.com>
CVE: 2026-84256
Change-Id: I68429deb39c0bae335d46a4170973a14c644ccf9
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Heiko Hund <heiko@openvpn.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1891
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1891
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@openvpn.net>

        
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 44b010d..d527160 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -936,6 +936,22 @@
     }
 }
 
+/* special to cmd.exe, which CreateProcess() uses to run .bat/.cmd (VU#123335) */
+#define CMD_QUOTE_TRIGGERS " &|<>^%()!"
+
+static bool
+argv_element_needs_quotes(const char *str)
+{
+    for (const char *c = str; *c != '\0'; ++c)
+    {
+        if (strchr(CMD_QUOTE_TRIGGERS, *c) != NULL)
+        {
+            return true;
+        }
+    }
+    return false;
+}
+
 static WCHAR *
 wide_cmd_line(const struct argv *a, struct gc_arena *gc)
 {
@@ -974,13 +990,13 @@
         {
             buf_printf(&buf, " ");
         }
-        if (string_class(work, CC_ANY, CC_SPACE))
+        if (argv_element_needs_quotes(work))
         {
-            buf_printf(&buf, "%s", work);
+            buf_printf(&buf, "\"%s\"", work);
         }
         else
         {
-            buf_printf(&buf, "\"%s\"", work);
+            buf_printf(&buf, "%s", work);
         }
     }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
