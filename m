Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3ABCA9ED2
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KRS+MzphB6cUWBAlor+RAje4hhtl2biqtRGeRYTOtto=; b=DZlGie/DhHjvnnCssAKeHJL+1w
	IIBvooZlhWWEskaadAldYWlFAkNBwC94US4Y81HZUAoDEtUkNjfw8dygJD56J67YQbiQ6Rv6EAWhE
	ZG3FFXbF20adyH3gDIDD0224qNU0eWk9Orsypfr226E1LTz5RsMWb3j99C+IYq8dr/To=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGbO8-0004RJ-Fv;
	Tue, 13 Oct 2026 12:13:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xGbO6-0004RC-Mg
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 12:13:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YcLJFZq/N+9wNoRyXohzLqHFMPucdoq3Y/CiWCHR1fk=; b=NJApG5gmfyMlpD1qN1/+HYbYhn
 ZG5z0FusEpk3JPfjsZvq7Xd/mx6qm5ZrDvsuefKcHrXqrv/Kmn2POe4eOEL/m0VKSzbVZV/8M6XGI
 Fs1w2JC1ltJJg6Pbub8o72p2c3xBM1iXZFe16/d0LreYlUmViOQkKlnfup5UI1SGsfPE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YcLJFZq/N+9wNoRyXohzLqHFMPucdoq3Y/CiWCHR1fk=; b=K1dZUY+sG6GDVHbpcto4J3xG7q
 mC0nx/nxe4+B/bUKulDX9FfI7AJxYkHyKZimQq1ysK0G7QFEOJ+GwN+W/AoUXN/sERcGlZVg5rAJV
 FOnwlJAXr+zCKxyRm5MqjKzXk0b6DdgpJ+zaFN9Ot2hb2dndxN/xXkXpxF107nuQ0ERQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGbO5-00062r-HQ for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 12:13:47 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69DCDcFB027966
 for <openvpn-devel@lists.sourceforge.net>; Tue, 13 Oct 2026 14:13:38 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69DCDcBH027965
 for openvpn-devel@lists.sourceforge.net; Tue, 13 Oct 2026 14:13:38 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 13 Oct 2026 14:13:31 +0200
Message-ID: <20261013121338.27882-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1791892996000.Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae@gerrit.openvpn.net>
References: <gerrit.1791892996000.Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xGbO5-00062r-HQ
Subject: [Openvpn-devel] [PATCH v1] PUSH_UPDATE server: free temporary
 options after sending message
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

From: Marco Baffo <marco@mandelbit.com>

Clean up options on success and send failure to avoid leaking
memory allocated while parsing outgoing updates.

Change-Id: Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae
Signed-off-by: Marco Baffo <marco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1992
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1992
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 0213041..f867a8c 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -163,6 +163,7 @@
     {
         if (!send_control_channel_string(c, BSTR(&e->buf), D_PUSH))
         {
+            uninit_options(&o);
             return false;
         }
 
@@ -217,6 +218,7 @@
         update_vhash(m, mi, o.ifconfig_local, o.ifconfig_ipv6_local);
     }
 
+    uninit_options(&o);
     return true;
 }
 
diff --git a/tests/unit_tests/openvpn/mock_push_dependencies.c b/tests/unit_tests/openvpn/mock_push_dependencies.c
index 112bcfd..bf2ccf3 100644
--- a/tests/unit_tests/openvpn/mock_push_dependencies.c
+++ b/tests/unit_tests/openvpn/mock_push_dependencies.c
@@ -62,6 +62,13 @@
 {
 }
 
+void
+uninit_options(struct options *options)
+{
+    gc_free(&options->gc);
+    gc_free(&options->dns_options.gc);
+}
+
 bool
 options_postprocess_pull(struct options *options, struct env_set *es)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
