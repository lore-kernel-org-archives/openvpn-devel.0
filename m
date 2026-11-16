Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7EE606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VK1UxwTK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OF2/eSxc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LcpJ8amu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=dmMKfr2TUnCZCo0FEbCXUaQmwbLq7BG0xfKzta6fQJI=; b=VK1UxwTK5V2Cch
	XiRAvTm7xioAJmSXH8AsJ3pm2ce3l3UsHZ/yLblj9JrDQi3ymTcck+D4rGEH339/FEJyeuupcwdG0
	pai8wm5ke49qasoenYsdPcCvioAuqCHbiAzqd923cPqacv3paAFRRG6df/TwguCwDb3COe7sx+XfF
	llY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSrjJ-000000008RR-34LD;
	Mon, 16 Nov 2026 08:06:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSrjI-000000008RA-0sg5 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:06:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MZynpih1KuOUMYO0VSCTHo6PTx23ko4QvhBKFguDHTQ=; b=OF2/eSxczU6xq/6xYp2FtTk+IW
 F/Ffs7Kg16Oz1ZHxAB8H+clixlzO9qjupLnTjsq3uEDoi9oGIOBgac2uJYMbl88u9O+Fnl0AzAFyy
 YEtSvHVdyfaEHeSijRHpzAVks64I58In9kHEd9UFDJ6BuXblAzwF5Qfw/yIkxxlTw06A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MZynpih1KuOUMYO0VSCTHo6PTx23ko4QvhBKFguDHTQ=; b=LcpJ8amukjCymjDua6DWyV48F3
 yIyNyfUgLDY1vDGuay/53LnsCmGjJ9e8MtUDdP8fnYans7HLIcbNUKbdk8a2zd2OqjmRGACXbk4Jw
 J8xi7V4U+lsCcP4Pbq8XNE48i80Bl0g9FBLHc9O7tbZrH3MckqBGseH15Z5sUYLCTr2U=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSrjF-000000005IJ-03qu for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:06:20 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AG86A4R000504
 for <openvpn-devel@lists.sourceforge.net>; Mon, 16 Nov 2026 09:06:10 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AG86AvN000489
 for openvpn-devel@lists.sourceforge.net; Mon, 16 Nov 2026 09:06:10 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 16 Nov 2026 09:06:03 +0100
Message-ID: <20261116080609.440-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794756855000.I272f840b547dde968ceca2c24de5a922f0721149@gerrit.openvpn.net>
References: <gerrit.1794756855000.I272f840b547dde968ceca2c24de5a922f0721149@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSrjF-000000005IJ-03qu
Subject: [Openvpn-devel] [PATCH v1] tun: drop no-op IFF_ONE_QUEUE on Linux
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

The kernel ignores the flag since Linux 3.8, commit 5d097109257c ("tun:
only queue packets on device"). Also drop its guard around the
--txqueuelen code, since SIOCSIFTXQLEN is always available, and the
stale --tun-ipv6 comment.

Drop the outdated kernel version and init script note from INSTALL.

Change-Id: I272f840b547dde968ceca2c24de5a922f0721149
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2185
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2185
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/INSTALL b/INSTALL
index d0ffaf0..0484e98 100644
--- a/INSTALL
+++ b/INSTALL
@@ -226,13 +226,10 @@
 
 TUN/TAP Driver References:
 
-* Linux 2.6 or higher (with integrated TUN/TAP driver):
+* Linux (with integrated TUN/TAP driver):
 
-  (1) load driver:              modprobe tun
-  (2) enable routing:           echo 1 > /proc/sys/net/ipv4/ip_forward
-
-  Note that (1) needs to be done once per reboot.  If you install from RPM (see
-  above) and use the openvpn.init script, these steps are taken care of for you.
+  (1) load driver (only if /dev/net/tun is missing):  modprobe tun
+  (2) enable routing:  echo 1 > /proc/sys/net/ipv4/ip_forward
 
 * FreeBSD:
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 70fdd7e..0ba8a4a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2123,16 +2123,9 @@
             msg(M_ERR, "ERROR: Cannot open TUN/TAP dev %s", node);
         }
 
-        /*
-         * Process --tun-ipv6
-         */
         CLEAR(ifr);
         ifr.ifr_flags = IFF_NO_PI;
 
-#if defined(IFF_ONE_QUEUE) && defined(SIOCSIFTXQLEN)
-        ifr.ifr_flags |= IFF_ONE_QUEUE;
-#endif
-
 #ifdef IFF_BACKPRESSURE
         ifr.ifr_flags |= IFF_BACKPRESSURE;
 #endif
@@ -2175,7 +2168,6 @@
         /*
          * Try making the TX send queue bigger
          */
-#if defined(IFF_ONE_QUEUE) && defined(SIOCSIFTXQLEN)
         if (tt->options.txqueuelen)
         {
             struct ifreq netifr;
@@ -2201,7 +2193,6 @@
                 msg(M_WARN | M_ERRNO, "Note: Cannot open control socket on %s", ifr.ifr_name);
             }
         }
-#endif /* if defined(IFF_ONE_QUEUE) && defined(SIOCSIFTXQLEN) */
 
         set_nonblock(tt->fd);
         set_cloexec(tt->fd);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
