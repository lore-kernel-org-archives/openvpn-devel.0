Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CBD606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lI9Zx2tt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iyHiJ7CX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bOe6+WQk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0jeFP3Z1d32mMat8Fx5ghbvfljmaB6JIb4oRzmpINMU=; b=lI9Zx2ttd4RqiC
	cTomzoM/WQXG8eexpaotrJFxXl+O6iICQqdgDtNx5VoVxM7YsCVxdCq2mB40rvp8XLnq3wA+8AE/L
	EyczVtiDrhwOFzF8SVN6Goftl4pqjdHBPMekdiJKBHtUdZDLJSGVig7g36rYZBE3mehugp5xWhP4n
	q8A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaPY-000000003s6-0Vri;
	Wed, 04 Nov 2026 12:48:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOaPW-000000003rn-1BEC for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:48:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cHF0iWO/knf94mUBcLlI4OYX2YltYjrs+mjDAcbfzcQ=; b=iyHiJ7CXspyMkPqKp5PsROC5IU
 UrmK6dpsVCRr+NJDY0vviYIyT995yVDNxKg/N5DHnJGTZ6ZMjaN85TSg25unySOvc0nBOa5HXKatc
 Clc7XUpNydGG9Eca9euOffR83y3ayLCgWICu1VUaQthFpyouFIcoQ8saXpExG4roM1Kk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cHF0iWO/knf94mUBcLlI4OYX2YltYjrs+mjDAcbfzcQ=; b=bOe6+WQkXOJGAD/JplWbIsKokJ
 vlBx6s/7IjkOb9NkUPHyP4M+i6d02A3xAaqIQsk+CuWDiM4N14e36g2UJafqbbEhVCo9JSoilxV2t
 lQW2CIwmg+VpOte3KU2zinq/6ku1dRTMIKOUCyXMg2NzUUkp72me0N9he46w26fe8fsU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOaPF-000000000QR-0aO6 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:48:00 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A4CloTN018314
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 13:47:50 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4CloJm018313
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 13:47:50 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 13:47:45 +0100
Message-ID: <20261104124750.18302-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793795741000.If903dc58238580ec0680f2d4c908b1f949a27469@gerrit.openvpn.net>
References: <gerrit.1793795741000.If903dc58238580ec0680f2d4c908b1f949a27469@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOaPF-000000000QR-0aO6
Subject: [Openvpn-devel] [PATCH v1] route: use setenv_int_i()/setenv_str_i()
 for indexed route env variables
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

setenv_route() and setenv_route_ipv6() built the route_metric_N and
route_ipv6_*_N names by hand. Use the env_set helpers instead. The
resulting variable names are unchanged.

Change-Id: If903dc58238580ec0680f2d4c908b1f949a27469
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2131
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2131
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 53550c4..6386960 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1317,7 +1317,6 @@
 static void
 setenv_route(struct env_set *es, const struct route_ipv4 *r, int i)
 {
-    struct gc_arena gc = gc_new();
     if (r->flags & RT_DEFINED)
     {
         setenv_route_addr(es, "network", r->network, i);
@@ -1326,12 +1325,9 @@
 
         if (r->flags & RT_METRIC_DEFINED)
         {
-            struct buffer name = alloc_buf_gc(256, &gc);
-            buf_printf(&name, "route_metric_%d", i);
-            setenv_int(es, BSTR(&name), r->metric);
+            setenv_int_i(es, "route_metric", r->metric, i);
         }
     }
-    gc_free(&gc);
 }
 
 void
@@ -1351,22 +1347,15 @@
     struct gc_arena gc = gc_new();
     if (r6->flags & RT_DEFINED)
     {
-        struct buffer name1 = alloc_buf_gc(256, &gc);
         struct buffer val = alloc_buf_gc(256, &gc);
-        struct buffer name2 = alloc_buf_gc(256, &gc);
 
-        buf_printf(&name1, "route_ipv6_network_%d", i);
         buf_printf(&val, "%s/%u", print_in6_addr(r6->network, 0, &gc), r6->netbits);
-        setenv_str(es, BSTR(&name1), BSTR(&val));
-
-        buf_printf(&name2, "route_ipv6_gateway_%d", i);
-        setenv_str(es, BSTR(&name2), print_in6_addr(r6->gateway, 0, &gc));
+        setenv_str_i(es, "route_ipv6_network", BSTR(&val), i);
+        setenv_str_i(es, "route_ipv6_gateway", print_in6_addr(r6->gateway, 0, &gc), i);
 
         if (r6->flags & RT_METRIC_DEFINED)
         {
-            struct buffer name3 = alloc_buf_gc(256, &gc);
-            buf_printf(&name3, "route_ipv6_metric_%d", i);
-            setenv_int(es, BSTR(&name3), r6->metric);
+            setenv_int_i(es, "route_ipv6_metric", r6->metric, i);
         }
     }
     gc_free(&gc);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
