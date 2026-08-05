Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9970FC56201
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3TbGQLFsS/5TOW/sXnWG6rX7QvxYx20yhlPmPYk7kS0=; b=CHPJtYtMRyMWpLmnpi6lbmpfh/
	nJqLKrIBMs2ywV2rwu/UO7SkaqYpB/o7Qy6wREiMXo2JTfNMjpJFhBMmFSNtEWSwj31x+hqAw42Jx
	PHyj0+KO/hKQ0LiZvypYs3JF1OV2leQNWM0FVzElVcexxHnNwNJbWTmHH/eRNuK45wZU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrZ0V-0005Ck-Ee;
	Wed, 05 Aug 2026 10:37:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pouria@FreeBSD.org>) id 1wrZ0U-0005Cb-3s
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 10:37:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7WfGS8kTPDt1nzJfHe/VUYyv49YDCR5ZemBWVl9NdNE=; b=dZesdyx7e7nj5Z/Yb/A2yOnwKJ
 dM5AvjPakL4/Qf4BBtR5mGtxCJDeHooaV6k5BzSVK0zNHh5IZdXbOxToTPWArmJW4PKirXZ5C9x6g
 XBSUJEq96obwObPZ4Zsrpw3byZMH1uRiF5CujkMx67Z2OhMR1ynJquCwOYjweqmepbZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7WfGS8kTPDt1nzJfHe/VUYyv49YDCR5ZemBWVl9NdNE=; b=m
 FrN0caere+ZLP4Jdhbs7iBEK1LzOeqGpV2b3Kd8HXtOvs3F5jVsXfFnL4c6VGNVtaljrQUHLyPFvB
 OGHBuzmN9c75XpzsiV8gGDd9jSvppcm3QPLaYZdf07Nsw3FDmzQ9APgmzHvVEdYcrbGo5StxHajFR
 V0vCOgZUXKMYVWAk=;
Received: from mx2.freebsd.org ([96.47.72.81])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrZ0X-0003Yn-M3 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 10:37:54 +0000
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "YR1" (not verified))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4hFRgw3ylyz3v3g;
 Wed, 05 Aug 2026 10:37:48 +0000 (UTC)
 (envelope-from pouria@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "YR1" (not verified))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4hFRgw2Zwrz3Fm4;
 Wed, 05 Aug 2026 10:37:48 +0000 (UTC)
 (envelope-from pouria@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1785926268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7WfGS8kTPDt1nzJfHe/VUYyv49YDCR5ZemBWVl9NdNE=;
 b=QwKPHUgw+MGeMyvteqYrnkCmmUE0Me/6AoNaRe0pE8SNvaqdcz6ia+jq0xRMV5750LUroZ
 EXdSbLm3PVvxe8tx/5bA5vnGODNO3+/+8AQM99YORSrDdJjb1MylZ40vRJZIhLknpulFdS
 igB7/TgvPArtQrty2efQMGqmwsbEqpnghbE0SNt6/UjohqAdEHJ+u+7aOrt9Btwwc3iYbc
 +4GJVWBL3DhIMu5EU9c1dfWsjt7FuV/ophgzPEo1+b4/+0+sROXisfyiktQrcV9m1HOe3c
 3fgB5TSEjBEM1lOJS4vEExuHfMsIlwdp1YjABU0pCgjtZqDF8MHFEyJZD1Hfiw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1785926268; a=rsa-sha256; cv=none;
 b=LJLi9ls7e46TZLiSXo52Yc2mzAOGO6b3AsI/sxqSOnlKwRjAGmYNSgRmC7WIv2ycaxuqdh
 5SQSk7B0tXmz+BcBFBYoYTu32eTeJE793hSDIwgKg1pDGrWwWK3zJipCXvHnjWCJMUk7eK
 B02Akb89baq9ADcuVKq9oV/jrzb3jqh5EPoagk+S+dQIV38Sw7XIOvaQXx5CEn5XQAwqi5
 WXCrGl1q0ptu8HSTJ4C0iGBSw8lSmysyIftK+3VpR+W429Z+ZXW1PFlmZpjUJQe7ruMEtS
 UtYVtJUb6hVrvS1vUi14R9+htqBVl/oEe6MHTb3Z8zM7cqftxJ9sa5G+iXelJA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1785926268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7WfGS8kTPDt1nzJfHe/VUYyv49YDCR5ZemBWVl9NdNE=;
 b=v0K+moamy8hYSIIEzNqkMtoDNKVCbwS62Tafz4RoUlcM3RXaWfA0IYB3hHy6hFAeiLCf03
 g409mt+t1GVwdV7ieqh25HSm6zAPATS2f7+xNCjhWgjp+DQ1DUQtmQ+N014iiFEWe9PQ9Y
 mEye3AM6x+sV4oahgkKgyFkyFbgA3L/YrhIIK4nmnilyceR2fOwoLuAtM/xPZilG+Ogky3
 iAgMjIKEbpmJuJ8FRxYx3j8RQIrNn7S/JKWJhzAviJca+sdUUN/JvXVXVL1IN42u3IymFr
 /gFfX0PYylsN6emU6CeLZ5C8nD5MK7bSnfhImTI/nhvpa87jIBq6k46C/V9X4g==
Received: from nl.mail.spmzt.net (unknown [IPv6:2a01:e140:12:1::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: pouria)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4hFRgv5k0XzCD5;
 Wed, 05 Aug 2026 10:37:47 +0000 (UTC)
 (envelope-from pouria@FreeBSD.org)
Received: by nl.mail.spmzt.net (OpenSMTPD) with ESMTPSA id 5a72bc63
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 5 Aug 2026 15:07:36 +0430 (+0430)
From: Pouria Mousavizadeh Tehrani <pouria@FreeBSD.org>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  5 Aug 2026 14:06:33 +0330
Message-ID: <20260805103633.91569-1-pouria@FreeBSD.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Headers-End: 1wrZ0X-0003Yn-M3
Subject: [Openvpn-devel] [PATCH] metric: Enable support for route metric on
 FreeBSD
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
Cc: info@spmzt.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

The route metric has been available since FreeBSD version 1600019.

Signed-off-by: Pouria Mousavizadeh Tehrani <pouria@FreeBSD.org>
---
 src/openvpn/route.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8ea745d1..7b9e106b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1640,10 +1640,10 @@ add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,
 
     argv_printf(&argv, "%s add", ROUTE_PATH);
 
-#if 0
+#if __FreeBSD_version >= 1600019
     if (r->flags & RT_METRIC_DEFINED)
     {
-        argv_printf_cat(&argv, "-rtt %d", r->metric);
+        argv_printf_cat(&argv, "-metric %d", r->metric);
     }
 #endif
 
@@ -1946,6 +1946,13 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
         argv_printf_cat(&argv, "-iface %s", device);
     }
 
+#if defined(TARGET_FREEBSD) && __FreeBSD_version >= 1600019
+    if (r6->flags & RT_METRIC_DEFINED)
+    {
+        argv_printf_cat(&argv, "-metric %d", r6->metric);
+    }
+#endif
+
     argv_msg(D_ROUTE, &argv);
     bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: *BSD route add -inet6 command failed");
     status = ret ? RTA_SUCCESS : RTA_ERROR;
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
