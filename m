Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E36B606A329
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jheaDbV8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VnPFBWJD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hhI8jVFM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IjbnS1iWJdXUKEf8lfUg3TbvBjqdx6fZjaEeF8V2+h4=; b=jheaDbV8zuB+Fv
	2hLvD2uIntywYnA7jn+z4naZGO+Rdq2oLQMzhHBXBTzPf26tmHCGA048g/pZ7/LHMk4QsCBBHhvV9
	jLymXkdIETPgqj2VI4nV7kridrYRyouwwFjynw1E+ol9qvS9FoZ0vqTVhhmz35BXAIrba3CO5tOtF
	RmY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODUF-000000003DA-3oxK;
	Tue, 03 Nov 2026 12:19:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xODTs-000000003Cs-3YqJ for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:19:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mw/W0opyZliHk9XKhgQXpeRqHhv9RzPiv8uITcsO/Rk=; b=VnPFBWJDqwXuIqb2LwsW+iMwff
 FM1FaKU3BWMYaW5xqtFE1BCkJSJmoERTzcerk7ANlT1YR00m8YM7Hz6165HZ2RVp2cSF22yxK6GFj
 p6lrbzkgOMHpORzoZgbRumz1JNpQUlX8C0rHKYwnJE6uI4+zfQ1OBy9QnxyDogNLB7bI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mw/W0opyZliHk9XKhgQXpeRqHhv9RzPiv8uITcsO/Rk=; b=hhI8jVFMtptNflSjFfb0Isx2fR
 m/5/DKkUlPZEJRJKf/MJkHILMHNn/OD0FXIBF8DpUw5OpWl6+N00/uGfTL4cm7Gd1VWWQKf3ByaqY
 qEM1OC0AJp9OVhWtrS+J+l/95AqxL3CEPgcfsoHMq1jcIvkFsRrl6kGXvenAPQnLwEsg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xODTr-000000003Dm-0mUH for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:19:12 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A3CJ4ZV002389
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 13:19:04 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3CJ4QT002386
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 13:19:04 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 13:18:58 +0100
Message-ID: <20261103121903.2369-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793686207000.Iad78e78cf51812c392f53cd58b33b54cb99cc6a8@gerrit.openvpn.net>
References: <gerrit.1793686207000.Iad78e78cf51812c392f53cd58b33b54cb99cc6a8@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xODTr-000000003Dm-0mUH
Subject: [Openvpn-devel] [PATCH v1] console_systemd: free argv when
 openvpn_popen() fails
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

get_console_input_systemd() returned without freeing argv on popen
failure. Free it right after openvpn_popen(), which no longer needs it.

Change-Id: Iad78e78cf51812c392f53cd58b33b54cb99cc6a8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2097
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2097
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index 9588b95..eaed24e 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -69,7 +69,9 @@
     argv_printf_cat(&argv, "--timeout=0");
     argv_printf_cat(&argv, "%s", prompt);
 
-    if ((std_out = openvpn_popen(&argv, NULL)) < 0)
+    std_out = openvpn_popen(&argv, NULL);
+    argv_free(&argv);
+    if (std_out < 0)
     {
         return false;
     }
@@ -81,8 +83,6 @@
     }
     close(std_out);
 
-    argv_free(&argv);
-
     return ret;
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
