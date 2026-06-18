Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F06CD98F8
	for <openvpn-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nIVPx+Mv2rv9kPCPNu1/Stk51J9e4/iZqTrlGfGHnKk=; b=bDrWY9VKbkMpc2BvFYGn7EY0lO
	eSgMN8XBWxKxd3yPONN0tj3cKNQrVGQbCc2sanAjr7cT/XocU2oICkqtVYRCA/VfD8POuxv4sHbjg
	2wp/66Z/5tpgGyBlufEPHCliR9H1bIce1ELomjovPmu7ctepwdcsrMUZU21NqMQOrJbY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1waEoU-0007xu-6W;
	Thu, 18 Jun 2026 15:37:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <luancamara@gmail.com>) id 1waEoT-0007xm-Fd
 for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 15:37:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zdgiyz8PA/tsUELSohjsnVhKNHkRVt2k3RriAI7MeM0=; b=kHHc7DEOcBATebTJLxGmTwmZpv
 /urotU2075L4k9Z735Jx0r+1yn1O+JW2ogl2LPHEi3LRq5ia0njv6kz6n5wSa0DlbDZIxOmTf3+MS
 KWOi7AT2EBGhX55UdEJ74StipyccORq96hDtHKaz/dPvSvomabmuB0hYIyRx1OmfVtdM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zdgiyz8PA/tsUELSohjsnVhKNHkRVt2k3RriAI7MeM0=; b=J
 bsBvHYXYviDF1ZhTeYctobdHXRAtQHARRqYbCdV4aic/JiysZ6Wb3HbbqIecZvxWaCRNgnEioqQnw
 OZF2OUJYvIjq6C2ezZUDcfvML86kU0W93hGsn9nyLpgvzW9FOf5CaYMRaWD1uxR46ei7FQ7Oo4JBi
 sA8ZhmyEslHUSliQ=;
Received: from mail-yw1-f177.google.com ([209.85.128.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1waEoP-00049K-JA for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 15:37:54 +0000
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-7ff05e5d009so13530767b3.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 18 Jun 2026 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781797059; x=1782401859; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zdgiyz8PA/tsUELSohjsnVhKNHkRVt2k3RriAI7MeM0=;
 b=QjT3TO9Nxd2I3w81yWVeCrbEaqWU8rGjET6eW1ByrRDg7guB5wCWREhel5jOGBNtt8
 soCNho3vlwhf7bPDxqbth8f3PnkcOcsCzvalAAAdCGFMtjnTV8/Lw7Nh4xxRp7YC5+bN
 VIxBKnqLgOC9sxMG5/lACjrV+yWxjeY5LYVG5T4CwNh+wSWeYUMYj4l0D2qLnpAr05DS
 nj4Kav1BEu471GIBpOu6Xuko1HKkm1Z+kHWP/T8ONE6aGbHMaWPcU4ts3HsWxfqYeWeQ
 M86DULsnJoIpmUnSmWLLrriP3G7VLdRcf2G/g5LGxrMeHbIje+mIGHiKG19p4v6CEAZH
 0YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797059; x=1782401859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdgiyz8PA/tsUELSohjsnVhKNHkRVt2k3RriAI7MeM0=;
 b=AYxylrZxwnXeN/igrja5CAf0RZbaBT+ZGla3WQNVaae5X00hjAh70XdEcVeH8m6t47
 F24oPwruhAdwi2ZcWbrY22WFJ0BBpvj1J94vJ8TkRIMdrLmjEA5pVXeAzbe1zVjYicq3
 7AJOmwCXBZp/9a0UH+8DyGVBOor6h+dcjzIPfXl9dLWYNu/Thu8s3ANZi0mWIJJrsGLR
 tWDiAqn3Uoken+J9TvnccA1rSj48y1D63kBEV78ei49wPRJElhfrYdHCrzevOyDOCWhW
 4S77OmdVzwm9kxcLT9XWSMmqlEXXcPzio85Flubi0ajC4f4lXrekCYuy/tlduBzFx544
 5uew==
X-Gm-Message-State: AOJu0YzdpmS/wI03S0g5xJTq3rpYBJ1dad80ONL2aS/5+6mkc6lzCkfx
 1piPmGpwtU+dc0ioFN/0qYteTDpxyTdz0B9ce9W+CjFRT/upie7Y8erpYp/LPZi6pxTIfw==
X-Gm-Gg: AfdE7ckZsluTgrXKuBI81GUrvPPClaQavE2YNv5BCVIN3JVnYp8Xu5MJ8kWw+Pwz8VP
 saFDlhN5OebN+gdzxzuIGpu60tgL1rxqQOB4InMp8XG0qw0JtnF6pJ4cHZg25Wuq1v94LK1VOCM
 PIWLIRBvl+jf1N4WeAcwcwjoHT7Ub36y/HObI3JARuikvWpvukqKdLS9EklVnTWrtyGP3TsxHHK
 RQ33Fyb6DzCtW5znhKtoWWqcaKWfWzrhZscfQbO29PaeK/y/fKm95nlchizv12VB0Uw9r5Pk5dP
 UmDoKr+nxy+1oRPUEO1J2ZzNJuXcMdQJsyE7+Ayy1ocIA+Bgh/psjGeho/662d/4dIYuXOjIgSY
 dH9AWUClw2fH9jG/P1P/FOxNsq/gG3JBEphjLRdVCcu5AdoS3R4qIDRjZIqPRVhM+QxnKnUsHtd
 ZHXrdBWQjdfl463J4pw+yoYcMsQSKAdgkkK8yp2A==
X-Received: by 2002:a05:690c:4512:b0:800:3647:10af with SMTP id
 00721157ae682-800364710d5mr27392197b3.15.1781797059013; 
 Thu, 18 Jun 2026 08:37:39 -0700 (PDT)
Received: from localhost.localdomain ([177.70.14.5])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7fcd00d9db6sm75095287b3.6.2026.06.18.08.37.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 08:37:38 -0700 (PDT)
From: Luan Camara <luancamara@gmail.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 18 Jun 2026 12:37:28 -0300
Message-ID: <20260618153730.58864-1-luancamara@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Headers-End: 1waEoP-00049K-JA
Subject: [Openvpn-devel] [PATCH OpenVPN3] tun/mac: make server bypass route
 idempotent to avoid orphaned route
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

On macOS the server bypass host route (remote /32 via the physical default
gateway, installed when redirect-gateway is active) is added with a plain
"route add". If a previous session terminated uncleanly (sleep, network
change or process crash) the teardown ActionList never runs and a stale copy
of this route survives in the routing table.

On the next connection the "route add" fails because the route already
exists. Command::execute() detects "File exists" and throws; ActionList::
execute() records the route's mark as failed and remove_marked() then drops
the *paired delete* from the teardown list (tunsetup.hpp: "since we should
not undo failed actions, remove them"). The route is therefore never cleaned
up, and because the stale entry still points at the previous network's
gateway, once that gateway is no longer on-link every datagram to the server
fails with EADDRNOTAVAIL:

    UDP send exception: send: Can't assign requested address

The client then loops RECONNECTING/RESOLVE until it times out, while the
server and all other users are unaffected.

Make the bypass route installation idempotent by issuing a best-effort
"route delete" immediately before the "route add". Deleting a non-existent
route is harmless ("not in table", non-fatal), while a stale orphan is
removed so the add always installs a fresh route bound to the current
gateway and stays managed for teardown. This mirrors the REPLACE semantics
already used by the Linux sitnl backend on EEXIST.

Signed-off-by: Luan Camara <luancamara@gmail.com>
---
 openvpn/tun/mac/client/tunsetup.hpp | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/openvpn/tun/mac/client/tunsetup.hpp b/openvpn/tun/mac/client/tunsetup.hpp
index dfe34d6..b14e6e3 100644
--- a/openvpn/tun/mac/client/tunsetup.hpp
+++ b/openvpn/tun/mac/client/tunsetup.hpp
@@ -414,6 +414,19 @@ class Setup : public TunBuilderSetup::Base
                     {
                         Action::Ptr c, d;
                         add_del_route(pull.remote_address.address, 32, gw4.gateway_addr_str(), gw4.iface(), 0, c, d);
+                        // Make the server bypass route idempotent. This host route must
+                        // point at the *current* physical default gateway. If a previous
+                        // session ended uncleanly (sleep, network change or crash) a stale
+                        // copy of this route can survive with an outdated gateway. A plain
+                        // "route add" then fails with "File exists"; execute() flags the add
+                        // as failed and remove_marked() drops the paired delete from the
+                        // teardown list, so the stale route is never cleaned up. Once the old
+                        // gateway is no longer on-link it produces a permanent
+                        // "UDP send: Can't assign requested address" and the client can only
+                        // time out. Issue a best-effort delete first (a no-op "not in table"
+                        // when absent, non-fatal) so the add always installs a fresh route
+                        // bound to the current gateway and stays managed for teardown.
+                        create.add(d); // pre-delete any stale/orphaned copy, then add
                         create.add(c);
                         destroy.add(d);
                     }
-- 
2.50.1 (Apple Git-155)



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
