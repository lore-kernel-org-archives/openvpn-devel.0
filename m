Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF86CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fZa1aL3RoxUYyoH4RE5WSvuhx096e89RY21n7a6TX7U=; b=C7ZmMcTvrRXvPqo5lZygddSqs5
	Tc+J0tQLOB/5rEKC7q11R+wZTu/0XU1yZ286AmW14Txg4A0PAmpt/ZWgD7drKrLNpvB+TNOnckRYn
	eRK0R4x4ZDF2s0ZZgz6ynYSk0xPrJe/grB6fno6rDbzpRmCbwBNlrFpuMmgKTcGITXjA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIT1P-0007gF-Hd;
	Sun, 18 Oct 2026 15:42:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xIT1N-0007g5-Cr
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:41:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lj7Oxlj8vW+2FntnxIYCE4gIDqf2yOFPboiyubFKTds=; b=h2WnQ9vUg2j+fTuxcBS1dGdtGD
 XIquTgOGZsGtcT1lVufms4dTN3vESuLmXJiFfu7FKgvVX8vz8qAnis0lgTsDO9uaEF+UJ4ynv/8+8
 Vhm3/MeTV6QLz71R57RbhXnPPS5rAEdF3xH6yFjpMOZ09xrE2NeCvJQ9lKoRnJ0K9Bic=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Lj7Oxlj8vW+2FntnxIYCE4gIDqf2yOFPboiyubFKTds=; b=HiH7Z3oJSvrm8xzHR7FtDTdisF
 V3lDVB7UlJ8iSt2Rnqo4cxZYJPXDl5rfaMdl+2mmjAPiuim5sKLy8sPVgdfEpdt8Royf658PNjONV
 zH282jEj472QMAbMlV2MOdK3umPQnsQtAP/n3qn4gcZiStFYJayE+G2P7L59tUuUn9wc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIT1K-0007uP-1N for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:41:58 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69IFfp5J023603
 for <openvpn-devel@lists.sourceforge.net>; Sun, 18 Oct 2026 17:41:51 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69IFfpfE023602
 for openvpn-devel@lists.sourceforge.net; Sun, 18 Oct 2026 17:41:51 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 18 Oct 2026 17:41:45 +0200
Message-ID: <20261018154151.23586-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792255622000.I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c@gerrit.openvpn.net>
References: <gerrit.1792255622000.I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xIT1K-0007uP-1N
Subject: [Openvpn-devel] [PATCH v1] push: Avoid conversion warnings in
 send_push_options
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

From: Frank Lichtenheld <frank@lichtenheld.com>

Make sure we have a sane length and convert it to int.

Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2005
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2005
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 8dfe0d5..ad95a0f 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -733,11 +733,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static bool
 send_push_options(struct context *c, struct buffer *buf, struct push_list *push_list, int safe_cap,
                   bool *push_sent, bool *multi_push)
@@ -748,8 +743,13 @@
     {
         if (e->enable)
         {
-            const int l = strlen(e->option);
-            if (BLEN(buf) + l >= safe_cap)
+            const size_t l = strlen(e->option);
+            if (!buf_size_valid(l))
+            {
+                msg(M_WARN, "--push option is too long");
+                return false;
+            }
+            if (BLEN(buf) + (int)l >= safe_cap)
             {
                 buf_printf(buf, ",push-continuation 2");
                 {
@@ -764,7 +764,7 @@
                     buf_printf(buf, "%s", push_reply_cmd);
                 }
             }
-            if (BLEN(buf) + l >= safe_cap)
+            if (BLEN(buf) + (int)l >= safe_cap)
             {
                 msg(M_WARN, "--push option is too long");
                 return false;
@@ -776,10 +776,6 @@
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 send_push_reply_auth_token(struct tls_multi *multi)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
