Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3F606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KMKDBnOJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=O23qnMng;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XLY3azZj;
	dkim=neutral header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=kBmQuUa4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=kIIfmXCYXK3W4JAhZf5ND1WHxCxqnuAtAWho8gS61Sg=; b=KMKDBnOJUaMPe8RFptR9heR0Ky
	jkCEeu1YkjAE+AFp1n3lVrXQcrmFzNWEY/SjmDLekgi8JqiOpbDhXiDj6z0VPZWAtyIWJZ592m12Y
	gB3+Sg2K2T/BeGbG/dn8EQqjD7WzytG9QUeoWv7B9YwdDG0hQqXeN+pyzd8OHkXNlhBk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM60p-000000001Ih-2fJC;
	Wed, 28 Oct 2026 15:56:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <simon.schippers@tu-dortmund.de>)
 id 1xM60n-000000001IY-0fsF for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:56:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q4OPH8KQ+K6pMvRGArFhoDzGpxxpMxosJz+T9/1NiIE=; b=O23qnMngaOnaqiSTIu8G9DZyx3
 qjAYxHtwEzSN4BIPVM77MCo9+0lsj71uV4WYBC3BTwPOU39bWeu5IWpD77sqdTO5qHPGaZwYU+hqu
 qf41bNVxW7fH4temn/Gbbcj3L/2aja8glTEEOPlmS1sgqNSTHQ4M5kjXDqYpwlJDjNxU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q4OPH8KQ+K6pMvRGArFhoDzGpxxpMxosJz+T9/1NiIE=; b=XLY3azZjOLB1/r+i+rjX5QCzsy
 RH+b18Txu+ZXGgEPIGNubPi1jFHndwlN3tje8Qp2haV4vIBI1mydzqX6630Yau3WCtP36M31I+XPN
 OQQF/iotznnXQEpyd9Xy0QTbHcnnFtWMmr3R/Ig42bFgEB0fThtvl3pneeAgVoDVkvog=;
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]
 helo=unimail.uni-dortmund.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xM60j-000000002ju-249T for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:56:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
 s=unimail; t=1793198805;
 bh=Q4OPH8KQ+K6pMvRGArFhoDzGpxxpMxosJz+T9/1NiIE=;
 h=From:To:Cc:Subject:Date;
 b=kBmQuUa4aqctTqF6b9yBkdHU7kqJpvDgEknjyHcEa8RHA52lojjzismZyUoEPRzX0
 WVHk5HJDqX0ca4wwV+4rxFwqGvOvCZ66Ua+Gp4KgTEjiayjUJMZ5YUfYM4Ott7EbZZ
 RPs14iYM8NFUwIVqQfdxX8F/ze70UWeGXp3UDX4w=
Received: from simon-Latitude-5450.. (spider37.kn.e-technik.tu-dortmund.de
 [129.217.186.37]) (authenticated bits=0)
 by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 69SEkj5P012800
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 15:46:45 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 28 Oct 2026 15:46:43 +0100
Message-ID: <20261028144643.647448-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM60j-000000002ju-249T
Subject: [Openvpn-devel] [PATCH] tun: add --tun-backpressure option for Linux
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

When the internal ring of a TUN/TAP device is full, the kernel silently
drops packets, bypassing any qdisc. TCP then sees loss, retransmits and
shrinks its congestion window.

My series "tun/tap & vhost-net: apply qdisc backpressure on full
ptr_ring to reduce TX drops" [1] adds IFF_BACKPRESSURE in Linux 7.3
(commit d00c7369ef24 "tun/tap & vhost-net: stop tail-drop when
IFF_BACKPRESSURE is set"). It stops the TX queue instead, so the qdisc
holds the packets and applies its AQM and fairness.

Our paper [2] evaluated this with OpenVPN: over a 120 ms RTT link
between Germany and the USA, TCP throughput without the patch was up to
36% worse, and with it no retransmissions occurred. With higher
latencies, throughput without the patch can be even worse.

Unfortunately, stopping and waking the queue can reduce throughput with
many parallel senders: in a synthetic test with eight iperf3 senders,
throughput dropped from 13.5 to 9.13 Gbit/s [3]. The flag is therefore
disabled by default and can be enabled with the new --tun-backpressure
option.

The option is only available when the headers define IFF_BACKPRESSURE,
and older kernels ignore the flag. The DCO path uses no TUN device and
is unaffected.

Tested on Linux 7.3-rc3: with --tun-backpressure,
/sys/class/net/<dev>/tun_flags has IFF_BACKPRESSURE set, without it the
flag stays clear. Builds without warnings with and without
IFF_BACKPRESSURE in the headers, and make check passes.

[1] https://lore.kernel.org/netdev/20260803183641.96882-1-simon.schippers@tu-dortmund.de/T/#u
[2] https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
[3] https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 doc/man-sections/advanced-options.rst |  7 +++++++
 src/openvpn/options.c                 | 12 ++++++++++++
 src/openvpn/tun.c                     |  7 +++++++
 src/openvpn/tun.h                     |  1 +
 4 files changed, 27 insertions(+)

diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index 32008d58f..c578a5c2c 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -100,6 +100,13 @@ used when debugging or testing out special usage scenarios.
   *(Linux only)* Set the TX queue length on the TUN/TAP interface.
   Currently defaults to operating system default.
 
+--tun-backpressure
+  *(Linux only)* Set :code:`IFF_BACKPRESSURE` on the TUN/TAP interface.
+  When OpenVPN falls behind reading from the interface, the kernel then
+  stops the TX queue instead of dropping packets, so the attached qdisc
+  can apply its queue management. This can reduce throughput with many
+  parallel senders. Requires Linux 7.3 or later; older kernels ignore it.
+
 --disable-dco
   Disables the opportunistic use of data channel offloading if available.
   Without this option, OpenVPN will opportunistically use DCO mode if
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8e0c6029e..241f3891c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -333,6 +333,8 @@ static const char usage_message[] =
     "                  via a VRF present on the system.\n"
 #endif
     "--txqueuelen n  : Set the tun/tap TX queue length to n (Linux only).\n"
+    "--tun-backpressure : Apply qdisc backpressure instead of dropping packets\n"
+    "                  on the tun/tap device (Linux only).\n"
     "--mlock         : Disable Paging -- ensures key material and tunnel\n"
     "                  data will never be written to disk.\n"
     "--up cmd        : Run command cmd after successful tun device open.\n"
@@ -5129,6 +5131,16 @@ add_option(struct options *options, char *p[], bool is_inline, const char *file,
 #else
         msg(msglevel, "--txqueuelen not supported on this OS");
         goto err;
+#endif
+    }
+    else if (streq(p[0], "tun-backpressure") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+#if defined(TARGET_LINUX) && defined(IFF_BACKPRESSURE)
+        options->tuntap_options.backpressure = true;
+#else
+        msg(msglevel, "--tun-backpressure not supported on this platform");
+        goto err;
 #endif
     }
     else if (streq(p[0], "shaper") && p[1] && !p[2])
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index fdd13ae7e..5d6184e55 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2100,6 +2100,13 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         ifr.ifr_flags |= IFF_ONE_QUEUE;
 #endif
 
+#ifdef IFF_BACKPRESSURE
+        if (tt->options.backpressure)
+        {
+            ifr.ifr_flags |= IFF_BACKPRESSURE;
+        }
+#endif
+
         /*
          * Figure out if tun or tap device
          */
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 61fe943b0..bd2107a78 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -150,6 +150,7 @@ struct tuntap_options
 struct tuntap_options
 {
     int txqueuelen;
+    bool backpressure;
 };
 
 #else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
