Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C7606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bKDHumn4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YmD72QBJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KB92iia7;
	dkim=neutral header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=CzOK6NOy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=uGIssNzs1leiCQYF9h/XnaejQg2F9Qh/Hvxsr1hgR40=; b=bKDHumn4NzrtYynp/yDAJnt7o5
	sBWUAV8zsPWOiYw7VgyTsR8VLAORQ741t1dB1jKl+1b5z3pB8tUTRO1KN+M/I00tOep7YNAp0Q4kU
	vWu8kKmS1I5O83yiOvgX7pSt0TprpU5p2PS+x/OeJQQRQ7EQW8k/A4duNJK4WnAtaHb4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMkd9-000000004jG-445V;
	Fri, 30 Oct 2026 11:18:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <simon.schippers@tu-dortmund.de>)
 id 1xMkcr-000000004hb-2D2i for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 11:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=obFUYgXfcDeXGLdre7ly94CO2C8GymjfYXsRIZh/JBE=; b=YmD72QBJESX2Efh6ZW+JTNqhv8
 mRkeVFbH6yKlAnWeVvT2CZG7DWVnnzUMAeAe9VvAD2hfUnyUusptYxtgHXtK92jnrvsBtg3pcDQFH
 McgKqVUXcsSWAogCZ0FXlVxRUjnlHVTT4h6f232sS7ngX9+1fdjVU7t9HRbTMffPlYRU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=obFUYgXfcDeXGLdre7ly94CO2C8GymjfYXsRIZh/JBE=; b=KB92iia7BxSx7znxB2ECnJzhwE
 AoK9XZo2sJl7NXB98IbfVU6aXDOgm/R5YFQ66CMI0NimaJwmqkMtq+I13h5ft74SaSzHweMqy1Jwq
 ylNL1Gx+hv2TgPaDcVAlJ4GjhwUNpR6/5+WTDiu+bAJKm7Up3UZ9d4ytEHt/PY1ZmVIE=;
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]
 helo=unimail.uni-dortmund.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMkcm-000000007Hb-0GQB for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 11:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
 s=unimail; t=1793359093;
 bh=obFUYgXfcDeXGLdre7ly94CO2C8GymjfYXsRIZh/JBE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CzOK6NOyDW4Cpa3MbiWP1cVAdRrWMkxeqOBCUytUz/ippgiSI9zf+kvcTY3GG6Tqz
 5T2y2H/pvjPQojrHVwXOhL3Hs72w2TUNEA4KpvrLAxMnec+iyOreV8j6g88EBbh1dT
 LQVu8Q2X+iPfgqmuv+BrVp3hJxgVK/HJYG2DjWrk=
Received: from simon-Latitude-5450.tu-dortmund.de ([129.217.186.53])
 (authenticated bits=0)
 by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 69UBICoi016986
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 12:18:13 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 30 Oct 2026 12:18:06 +0100
Message-ID: <20261030111806.92252-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028144643.647448-1-simon.schippers@tu-dortmund.de>
References: <20261028144643.647448-1-simon.schippers@tu-dortmund.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMkcm-000000007Hb-0GQB
Subject: [Openvpn-devel] [PATCH v2] tun: set IFF_BACKPRESSURE on Linux
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: a@unstable.cc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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

Stopping and waking the queue costs CPU time, which reduced throughput
in a synthetic test with eight iperf3 senders into a QEMU VM on a
Ryzen 9 9950X [3]. With OpenVPN, the encryption is the bottleneck
instead. A benchmark on the same CPU with eight iperf3 streams through
OpenVPN between two network namespaces [4] gives these means over 40
runs of 30 s, with the flag off and on (drops: TX drops of the client
TUN device, retr: TCP retransmits):

  txqueuelen   off Mbit/s    on Mbit/s   change  off drops   on drops   off retr    on retr
         500         3971         3952    -0.5%      40226          0      36624        531
        5000         4005         3923    -2.1%       1358          0        658          0

The throughput difference is within the run-to-run standard deviation of
340 to 380 Mbit/s (about 9%), while the TUN drops are gone and the
retransmits nearly so. The flag is therefore always set.

The flag is only set when the headers define IFF_BACKPRESSURE, and older
kernels ignore it. The DCO path uses no TUN device and is unaffected.

[1] https://lore.kernel.org/netdev/20260803183641.96882-1-simon.schippers@tu-dortmund.de/T/#u
[2] https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
[3] https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/
[4] https://github.com/simoschip2000/openvpn-bench

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
v2:
- Always set the flag instead of adding a --tun-backpressure option, as
  discussed with Antonio.
- Add OpenVPN benchmark results.

 src/openvpn/tun.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index fdd13ae7e..85daefd10 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2100,6 +2100,10 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         ifr.ifr_flags |= IFF_ONE_QUEUE;
 #endif
 
+#ifdef IFF_BACKPRESSURE
+        ifr.ifr_flags |= IFF_BACKPRESSURE;
+#endif
+
         /*
          * Figure out if tun or tap device
          */
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
