Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229B606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jvSDO5YA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EnFrTn5M;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jBwtNzEs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=h8YgHkU6CUfMGQpYZvR1xvZStdCyCVQMnbwDmZYeT+M=; b=jvSDO5YAu3zFec
	PkHfxJ1k6OUTKZvJYNoeUI2GanMiL9jAL2/CedJ7g0aPJxRnll127V7JKlRsbw5p0jV+mxxVJt4Wd
	txlEcXAPe+x/lNsm1RnKQqOw+OEsO8pslOEHVgcOlYlJ1BdGEEFOzF+fiRd/y/ON1n+Utk97mKZ8e
	3Ss=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRD7F-000000007WL-2tcJ;
	Wed, 11 Nov 2026 18:32:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRD7D-000000007WF-41uN for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 18:32:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dyAZ+6ZpM7m6v0Xe7UmijcgZfUVohJsjWoVHEXNBRCg=; b=EnFrTn5Mw6f/BRWCmJLdvuw9b3
 oKkIwniZ4oCFnvqQEVCGVQOEMK1m9kx1B4Gfs7Vu17uT5FTwzKsBZTwoC1xLCDuIkuaYr6Z3a1AUT
 gWdabu/D/ttOEbjpz86BT7EggS5UworrPeo3sF8mdhYfYTEStSiPIURd+LfBDw2zy4Jk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dyAZ+6ZpM7m6v0Xe7UmijcgZfUVohJsjWoVHEXNBRCg=; b=jBwtNzEswpN3KAKg2iLHlVHPzI
 hUkQrhI8JEliw19rOhjXovPqB6s7zNdXsh1KeP7E5zf7jePtwJeAYIODv5pYowo2WenDBNZ22r4EU
 EWNODpTR0kLF+o587jS2ltTSpcrShPJ+AiiMf24gGENnJ08KHUW2Hm0hpOAcgoKU90f8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRD7C-0000000080n-1vb7 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 18:32:11 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ABIW3BP018736
 for <openvpn-devel@lists.sourceforge.net>; Wed, 11 Nov 2026 19:32:03 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ABIW3Od018735
 for openvpn-devel@lists.sourceforge.net; Wed, 11 Nov 2026 19:32:03 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 11 Nov 2026 19:31:57 +0100
Message-ID: <20261111183203.18722-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794417322000.Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088@gerrit.openvpn.net>
References: <gerrit.1794417322000.Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRD7C-0000000080n-1vb7
Subject: [Openvpn-devel] [PATCH v1] tun: Make error_flags unsigned
 consistently
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

Previously both int and unsigned int was used.

Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2176
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2176
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0bb5390..a92967e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1835,7 +1835,7 @@
 
 
 static bool
-do_open_tun(struct context *c, int *error_flags)
+do_open_tun(struct context *c, unsigned int *error_flags)
 {
     struct gc_arena gc = gc_new();
     bool ret = false;
@@ -2337,7 +2337,7 @@
 bool
 do_up(struct context *c, bool pulled_options, uint64_t option_types_found)
 {
-    int error_flags = 0;
+    unsigned int error_flags = 0;
     if (!c->c2.do_up_ran)
     {
         reset_coarse_timers(c);
@@ -2496,7 +2496,7 @@
     do_close_tun(c, true);
 
     management_sleep(1);
-    int error_flags = 0;
+    unsigned int error_flags = 0;
     c->c2.did_open_tun = do_open_tun(c, &error_flags);
     update_time();
 
@@ -4663,7 +4663,7 @@
      * open tun/tap device, ifconfig, run up script, etc. */
     if (!(options->up_delay || PULL_DEFINED(options)) && (c->mode == CM_P2P || c->mode == CM_TOP))
     {
-        int error_flags = 0;
+        unsigned int error_flags = 0;
         c->c2.did_open_tun = do_open_tun(c, &error_flags);
     }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
