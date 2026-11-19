Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0BC606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lPKXYYQH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nObJSFOB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l96+gJPt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=n5BJ3KsLf96Q/pPCnTP/YBRF7r0iULf6023Y5UXZ9uM=; b=lPKXYYQHrKJpX9
	XRqsbl1OEtO2an1fWIfwIiBjyZe3pylI+FMMlOmTQrbjN/CAA6btrOsefutkBk7D7V8uhpHLBBbDe
	mfa4zF9c6baiEK3MByLjZZPNB3qJRjWK6b74a9TzocVDPe3x/+6fMFhJw8fo8FdvVFDW5HXxEwChC
	FHs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU1sX-000000008Ea-3CDS;
	Thu, 19 Nov 2026 13:08:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xU1sW-000000008EO-0mYA for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:08:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EAWEvdj6hbUg3onAhqfICnjRQoLcp6ADZjZmY/64n4c=; b=nObJSFOBDm4dkynMNfCd6ba4Zl
 KIjblSp8B0h3ddd9LeMaLi4WjipLaKEjTZFCWsMp/inomMpqw4gc4trJRt7D25kTQlMIvAsYhgfkN
 JHQ5c+/MVXDh8WQG3Q/8vZ8wc0MR01L1AaNV25oZ9JuleTN88wwvBcvCiH/EEuUGwx8g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EAWEvdj6hbUg3onAhqfICnjRQoLcp6ADZjZmY/64n4c=; b=l96+gJPtCXuAULLQtquLg4KHnx
 Zb3DnaVF/elL94ZQ7azav0oCkOh7aC9HxZX41LrMkgd8e85qtAq/Nx0ZPu9fSKxQynsfqDMvk/k2J
 kWweEg/ddOGX6KJtNIZf4T8kNPpRKrhLRM8/eaGdFmd5L0KoF118JpPiEpY96fTcMVf8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xU1sV-0000000018n-1GKZ for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:08:40 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AJD8WDH020815
 for <openvpn-devel@lists.sourceforge.net>; Thu, 19 Nov 2026 14:08:32 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AJD8WhF020814
 for openvpn-devel@lists.sourceforge.net; Thu, 19 Nov 2026 14:08:32 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 19 Nov 2026 14:08:26 +0100
Message-ID: <20261119130832.20797-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794861212000.I2088345f10a630241fbddde68336ea7c1f7b449d@gerrit.openvpn.net>
References: <gerrit.1794861212000.I2088345f10a630241fbddde68336ea7c1f7b449d@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xU1sV-0000000018n-1GKZ
Subject: [Openvpn-devel] [PATCH v1] dco: don't access tls_multi in
 dco_get_peer_stats() during a restart
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

From: Antonio Quartulli <antonio@mandelbit.com>

On a restart init_instance() registers the management callbacks before
the restart pause, while c2.tls_multi is still NULL: close_instance()
freed it and do_init_crypto_tls() has not created the new one yet.
A management "status" command during the pause therefore calls
dco_get_peer_stats() without a tls_multi.

With --persist-tun the DCO interface survives the restart, so the Linux
and Windows implementations get past their interface checks and
dereference the NULL tls_multi; FreeBSD hits ASSERT(c->c2.tls_multi)
even without --persist-tun. Either way openvpn dies.

Return an error when there is no tls_multi, as when there is no DCO
interface.

Reproduced on Linux with a DCO client using --persist-tun:

  (echo 'signal SIGUSR1'; sleep 0.5; echo status; sleep 3) | nc 127.0.0.1 7505

segfaults in dco_get_peer_stats() during the restart pause.

Gerrit change 2201 makes print_status() answer even when
dco_get_peer_stats() fails; together with this change, "status" gets
a reply during a reconnect instead of hanging or crashing.

Related: https://gerrit.openvpn.net/c/openvpn/+/2201
Change-Id: I2088345f10a630241fbddde68336ea7c1f7b449d
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2204
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2204
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 11b8dff..6701d21 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -916,7 +916,11 @@
 int
 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
-    ASSERT(c->c2.tls_multi);
+    /* tls_multi is NULL during a restart */
+    if (!c->c2.tls_multi)
+    {
+        return -EINVAL;
+    }
     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, c->c2.tls_multi->dco_peer_id);
 
     if (c->c2.tls_multi->dco_peer_id < 0)
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 3a55b6e..befad61 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1280,7 +1280,8 @@
 int
 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
-    if (!c->c1.tuntap || c->c1.tuntap->dco.ifindex == 0)
+    /* tls_multi is NULL during a restart, while a persisted tun is still around */
+    if (!c->c1.tuntap || c->c1.tuntap->dco.ifindex == 0 || !c->c2.tls_multi)
     {
         return -1;
     }
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index a854045..eff4d33 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -898,7 +898,8 @@
 {
     const struct tuntap *tt = c->c1.tuntap;
 
-    if (!tuntap_defined(tt))
+    /* tls_multi is NULL during a restart, while a persisted tun is still around */
+    if (!tuntap_defined(tt) || !c->c2.tls_multi)
     {
         return -1;
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
