Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81695606A327
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eh/lWTKU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E2aj6bwy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WAzoQpne
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VcV8QnUfQ8a0Z+0/MXIBfz6gXr4QSwkmap4n9W3I+0I=; b=eh/lWTKUWs8qt0
	L+UrsFD9zxiIr5ZG0HfQ5qGSkUxJcaVuw6++nnTmcIN+EMvsAjgjKTJqCsc+2kihIvjEIRqvxcknX
	wt0yWPWls//7n8PVFZUGBLMFFAnfNE1Xsh/2ufW+prZSMa0DWGCZlWih1FXtrEEHwMYA8ULbE0vsR
	Uzk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVpbA-000000001Cs-0GWj;
	Tue, 24 Nov 2026 12:26:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVpb8-000000001Cj-4Abv for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:26:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bhTT/Yi7UmigReTC6KW+gDQT1Am58NpanJ9vj2kULTA=; b=E2aj6bwy6Gh39YT+hVOAkOTHFP
 vPNkCiufKoEttW00AGxCvNLJb0blQL4ktRzlS7BOhJs2eNcCID7WcjWAeyddnppGrDJh7/tMh6tYE
 J0fa565IROz9xe19hvNl2TF6HFmVwL1DhNPjVOXkeGpgTWNpJzFmeBzBObxMoU5hPdnU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bhTT/Yi7UmigReTC6KW+gDQT1Am58NpanJ9vj2kULTA=; b=WAzoQpne8iYn74k/ehnOp4XkdD
 Tth6p9USj7DC1iXkTZ8JekVjmX/2KrG51kaoABjff8PFZCZxwN0bVpqLO1ZqFUg65eFINEtrvktUD
 JEYEzzfZdIp1SVvJWMzUPfIkfW716x55t/0PU6qDgQmf84gN7JDTlsfDadlzVMKb2PDk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVpb4-000000000tC-005x for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:26:07 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AOCPxXM008565
 for <openvpn-devel@lists.sourceforge.net>; Tue, 24 Nov 2026 13:25:59 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOCPxVJ008562
 for openvpn-devel@lists.sourceforge.net; Tue, 24 Nov 2026 13:25:59 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 24 Nov 2026 13:25:53 +0100
Message-ID: <20261124122559.8549-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795515857000.Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1@gerrit.openvpn.net>
References: <gerrit.1795515857000.Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVpb4-000000000tC-005x
Subject: [Openvpn-devel] [PATCH v2] options: make the options mode an enum
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

Turn the MODE_* defines into enum options_mode and use it for the mode
fields and parameters. With both modes being distinct enum types,
-Wenum-compare catches comparing a context mode against an options
mode.

Change-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2334
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2334
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index fdee465..3c85c11 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -255,7 +255,7 @@
 }
 
 static bool
-dco_check_option_ce(const struct connection_entry *ce, msglvl_t msglevel, int mode)
+dco_check_option_ce(const struct connection_entry *ce, msglvl_t msglevel, enum options_mode mode)
 {
     if (ce->fragment)
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2068393..f9ff0c4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2309,7 +2309,7 @@
 }
 
 static void
-options_postprocess_mutate_le(const struct connection_entry *ce, struct local_entry *le, int mode)
+options_postprocess_mutate_le(const struct connection_entry *ce, struct local_entry *le, enum options_mode mode)
 {
     /* use the global port if none is specified */
     if (!le->port)
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b390ebc..0112c5f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -252,6 +252,13 @@
     struct verify_hash_list *next;
 };
 
+/** Major mode */
+enum options_mode
+{
+    MODE_POINT_TO_POINT,
+    MODE_SERVER,
+};
+
 /* Command line options */
 struct options
 {
@@ -260,10 +267,7 @@
     /* first config file */
     const char *config;
 
-    /* major mode */
-#define MODE_POINT_TO_POINT 0
-#define MODE_SERVER         1
-    int mode;
+    enum options_mode mode;
 
     /* enable forward compatibility for post-2.1 features */
     bool forward_compatible;
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index cfe3fea..fe333a3 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -324,7 +324,7 @@
 
     /* from command line */
     bool single_session;
-    int mode;
+    enum options_mode mode;
     bool pull;
     /**
      * The detail of info we push in peer info


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
