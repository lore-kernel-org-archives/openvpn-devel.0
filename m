Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF88C982D8
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Co9b1XE9tozpLRslQ+HyZHY1f+1IASrXZJLvwzr6GgA=; b=NosrvLEQf3NFT3SNAFHlhigIEb
	LR5AF5tDfzkbuHGafphPnVAMx43E/wwaDQdXMIxrDtf3xuh20LyvJQlua+fGxsjNR546endWcTbgE
	wlZq7clpMuJ3cjVFjAH9VJd9Zb8Bq4UkhrAYsahkOJKutR9ZiRzF04kCjsQ+fWn2YVXk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7cxh-0002Wm-5x;
	Fri, 18 Sep 2026 18:05:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x7cxe-0002WV-OH
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 18:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rxTviZ8klLzRoeDwsZdSOz3qx7zUymfHZvjvcerhuig=; b=frLeHCmgELRQa+QJ5QKSN/GPs9
 K8kztGJ8EEYU5QD82ika0VIkz1GxA679PHJ6ewmSHPzq0al/9tuQ6ETTrbLJ+NBIqzaM+osWOqX5Q
 O7DYBql5bn+k8JFfRrfLmzM51ldGHckcUR2we2SEyWHGl4nXiUsvTre3AVFN6oEDowwM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rxTviZ8klLzRoeDwsZdSOz3qx7zUymfHZvjvcerhuig=; b=a5au7a4myd/qUFzWG0r/Nt5ES5
 CXK/a4yDSzt2mruVPLNiu46JPZUPljejCF3pXF2VrYRf4+REermpRRkAIdZwn92tAoZo+3N9fZBGS
 iJbeQzjmPyARFJBmj4MeZwWZHZt0eUrx00gmwJbcQZkeSS8/tNpCjpyaLeNaej5jzptk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7cxX-0000kG-4j for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 18:05:16 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68II57id026467
 for <openvpn-devel@lists.sourceforge.net>; Fri, 18 Sep 2026 20:05:07 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68II57WZ026452
 for openvpn-devel@lists.sourceforge.net; Fri, 18 Sep 2026 20:05:07 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 18 Sep 2026 20:05:01 +0200
Message-ID: <20260918180507.26425-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1789715744000.Ie46934c0a8f04908cc277114ae491c100d368cb2@gerrit.openvpn.net>
References: <gerrit.1789715744000.Ie46934c0a8f04908cc277114ae491c100d368cb2@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x7cxX-0000kG-4j
Subject: [Openvpn-devel] [PATCH v1] dco_win: report per-peer ioctl failures
 instead of exiting
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

From: Lev Stipakov <lev@openvpn.net>

Three per-peer operations end the process when their ioctl fails: MP_NEW_PEER,
NEW_KEY and SWAP_KEYS all report with M_ERR, which is M_FATAL. On a server that
means one client's failure disconnects every other client.

The shared code above them already recovers per instance: a failed MP_NEW_PEER
drops that client in multi.c, a failed SWAP_KEYS raises SIGUSR1 for that
instance in forward.c, and change 1835 restarts the instance on a failed
NEW_KEY. None of it runs on Windows, because the process is gone before the
error can be returned.

Report and return, which is what DEL_PEER, MP_SET_PEER and the iroute calls in
this same file already do. The remaining M_ERR uses here are interface-wide
setup, where failing hard is still right.

NEW_KEY failing is not hypothetical: the driver owns the keepalive timer and
expires peers itself, so a key install can arrive for a peer it has just
removed. Measured on a Windows DCO server under peer churn: 15 refused installs
across four runs, no process exit.

Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1920
Change-Id: Ie46934c0a8f04908cc277114ae491c100d368cb2
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1920
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index b3268bc..90cff8c 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -460,7 +460,8 @@
     if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_NEW_PEER, &newPeer, sizeof(newPeer), NULL, 0,
                          &bytesReturned, NULL))
     {
-        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_MP_NEW_PEER) failed");
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_NEW_PEER) failed");
+        return -1;
     }
 
     return 0;
@@ -575,7 +576,7 @@
 
     if (!DeviceIoControl(dco->tt->hand, ioctl, buf, bufSize, NULL, 0, &bytes_returned, NULL))
     {
-        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed");
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed");
         return -1;
     }
     return 0;
@@ -609,7 +610,7 @@
     DWORD bytes_returned = 0;
     if (!DeviceIoControl(dco->tt->hand, ioctl, buf, len, NULL, 0, &bytes_returned, NULL))
     {
-        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed");
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed");
         return -1;
     }
     return 0;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
