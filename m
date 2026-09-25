Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD44BC9830D
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mKR58Y35GPL/l5nHnqyIb7eM81kC72lDr9kv9zwBFHY=; b=Q6YsYlcecf4h7oRZ0Mcj0soF3Q
	X0ldLjP9/MillHZGbZQuP2b3Qmu6Ft0CojPbUUgbem6BG0IOmT2F2Bui4kFNXZaFiJnEuTwI5v9q0
	A1wOs7DzQK1dgybNI2tQijNHArLxLN/R0Vy+Mh1ye0Aae4HKROeV+BmXF2fzpnDEPRck=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA5e7-0007N1-SF;
	Fri, 25 Sep 2026 13:07:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xA5e7-0007Mu-5S
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:07:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RHOpY5C6ry8G32YVKyaWY4VuGYtbfZCDtySZF3ozS2g=; b=M3BjdA3ndVO37yhgfstvDX7SeE
 GmLVZG3IDPcCVW0XmpYBc//tzc1kAONvWXztKI0y027qwGf83kznlDTjf9w6bFYm1iGE66hhTYMht
 gC9Z/qNTLzEEKbz0jPQsRH8P9mEKzNsbt+uKLawZOPR9yQZhsqXK+EMXJM0FvUzd1lp4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RHOpY5C6ry8G32YVKyaWY4VuGYtbfZCDtySZF3ozS2g=; b=jDRu4A8DMsPB4VsXu3acy5N2jj
 S58YxFGehDN+Ixl4trNOwTguqMjoU1TqE9finU0KmMu57N84EWDpOXl4g35DMaeakC/xmFXSnl/qz
 hVUp9e+9jRMWkA1eLkT6HVehU0JmW2YxRzd5g2ZsxRCZeJg2KXUV9TnVMZIju8D79oUM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xA5e6-0007Hn-Oe for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:07:23 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68PD7FWf009864
 for <openvpn-devel@lists.sourceforge.net>; Fri, 25 Sep 2026 15:07:15 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68PD7FoN009863
 for openvpn-devel@lists.sourceforge.net; Fri, 25 Sep 2026 15:07:15 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 25 Sep 2026 15:07:10 +0200
Message-ID: <20260925130715.9850-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790339862000.Id999691f74d291f4b902b8ca224a12d9bc7e6046@gerrit.openvpn.net>
References: <gerrit.1790339862000.Id999691f74d291f4b902b8ca224a12d9bc7e6046@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xA5e6-0007Hn-Oe
Subject: [Openvpn-devel] [PATCH v1] multi: make multi_add_mbuf static
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

From: Antonio Quartulli <antonio@mandelbit.com>

This function is used only in multi.c and can therefore be
declared as static.

Change-Id: Id999691f74d291f4b902b8ca224a12d9bc7e6046
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1951
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1951
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3e72b92..c1ceb34 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2833,7 +2833,7 @@
  * Add a mbuf buffer to a particular
  * instance.
  */
-void
+static void
 multi_add_mbuf(struct multi_context *m, struct multi_instance *mi, struct mbuf_buffer *mb)
 {
     if (multi_output_queue_ready(m, mi))
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 6cb86c7..ac6cb78f 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -354,8 +354,6 @@
 
 struct multi_instance *multi_get_queue(struct mbuf_set *ms);
 
-void multi_add_mbuf(struct multi_context *m, struct multi_instance *mi, struct mbuf_buffer *mb);
-
 void multi_ifconfig_pool_persist(struct multi_context *m, bool force);
 
 bool multi_process_signal(struct multi_context *m);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
