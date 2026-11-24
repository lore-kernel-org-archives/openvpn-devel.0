Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C1606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cqgYSKVG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Xl/+n5I3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D8B2q4SC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LluO6+Z+Fbp+Oj9wm/ijJNJQ57eZF2yclyf9hsBAb2c=; b=cqgYSKVGlnttii
	RLJ37FyAXBLhATNOFlVn2oICfDKZAfVK2+/7AIM1PNl/X6BpD2apbqWA0y0XhA3FBTmmFzo8ke3UE
	rliLu1Y8CXhffbxjv1QJxpvs2CvkmkV9eenYdOC+NDlEfbbcMWLd/8/RFhLVfDlY3ySoGkIB3ZXJR
	qoI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVpaR-000000002A1-2C5i;
	Tue, 24 Nov 2026 12:25:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVpa6-0000000028r-3jUB for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:25:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e2y3iTZMj+on3EFRHgYodGyPp8Z7iyqykvXOgjrSFgg=; b=Xl/+n5I30t8JHUB58hqE+x7rzF
 pzI343Cz0Hw4Ju5/IK1UZtncPx33mJpqlwFJjElFMKs1iCI56yJN0C5lVPOqlszf35uNWrouHGP9U
 XXK52y6ld8sO6cbv0flqMTDy64RlaAy4HPE5CKUQfwI6bD5rTCVlBss2So99e+RJWXOg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e2y3iTZMj+on3EFRHgYodGyPp8Z7iyqykvXOgjrSFgg=; b=D8B2q4SCZuAp3kLlezq/yZ5buP
 Pm2L6aU8Ng5ZcF0LLVULbcAr6KCD3jx/C7fWTrFsrP4RLNTKBmZeUpA7Vn1wUJzz8TrbXzu2pDvxn
 fJIN6wxOA/DSThQyEI/IGYxGv9jLZ1eSmmipy5GtscXsUfoggk2s6c2Z3ro935PVlaOM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVpZv-000000000rN-39OT for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:24:58 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AOCOm7F008423
 for <openvpn-devel@lists.sourceforge.net>; Tue, 24 Nov 2026 13:24:48 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOCOmQh008422
 for openvpn-devel@lists.sourceforge.net; Tue, 24 Nov 2026 13:24:48 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 24 Nov 2026 13:24:43 +0100
Message-ID: <20261124122448.8407-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795515857000.Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396@gerrit.openvpn.net>
References: <gerrit.1795515857000.Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVpZv-000000000rN-39OT
Subject: [Openvpn-devel] [PATCH v2] openvpn: make the context mode an enum
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

Turn the CM_* defines into enum context_mode and use it for
struct context.mode, so -Wswitch covers switches over it.

Drop the stale CM_THREAD mention from the comments.

Change-Id: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2333
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2333
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 8b64944..10a232c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2768,6 +2768,9 @@
         case CM_CHILD_TCP:
             sec = c->options.ce.connect_retry_seconds;
             break;
+
+        default:
+            break;
     }
 
 #ifdef ENABLE_DEBUG
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index ad6be88..cbda2e3 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -430,6 +430,16 @@
 };
 
 
+/** Role of a context within the OpenVPN process */
+enum context_mode
+{
+    CM_P2P,       /**< standalone point-to-point session or client */
+    CM_TOP,       /**< top level of a multi-client or point-to-multipoint server */
+    CM_TOP_CLONE, /**< clone of a CM_TOP context for one thread */
+    CM_CHILD_UDP, /**< child context of a CM_TOP */
+    CM_CHILD_TCP, /**< child context of a CM_TOP */
+};
+
 /**
  * Contains all state information for one tunnel.
  *
@@ -443,22 +453,14 @@
  */
 struct context
 {
-    struct options options; /**< Options loaded from command line or
-                             *   configuration file. */
+    struct options options;      /**< Options loaded from command line or
+                                  *   configuration file. */
 
-    bool first_time;        /**< True on the first iteration of
-                             *   OpenVPN's main loop. */
+    bool first_time;             /**< True on the first iteration of
+                                  *   OpenVPN's main loop. */
 
-    /* context modes */
-#define CM_P2P       0           /* standalone point-to-point session or client */
-#define CM_TOP       1           /* top level of a multi-client or point-to-multipoint server */
-#define CM_TOP_CLONE 2           /* clone of a CM_TOP context for one thread */
-#define CM_CHILD_UDP 3           /* child context of a CM_TOP or CM_THREAD */
-#define CM_CHILD_TCP 4           /* child context of a CM_TOP or CM_THREAD */
-    int mode;                    /**< Role of this context within the
-                                  *   OpenVPN process.  Valid values are \c
-                                  *   CM_P2P, \c CM_TOP, \c CM_TOP_CLONE,
-                                  *   \c CM_CHILD_UDP, and \c CM_CHILD_TCP. */
+    enum context_mode mode;      /**< Role of this context within the
+                                  *   OpenVPN process. */
 
     struct multi_context *multi; /**< Pointer to the main P2MP context.
                                   *   Non-NULL only when mode == CM_TOP. */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
