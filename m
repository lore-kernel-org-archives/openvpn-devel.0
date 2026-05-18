Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB11DCD4F52
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NW+r3cCMn7XK3Ap8PpwDlIghBEhMlE4abxi0gjq0RVE=; b=jIntPJ4lmCfuq8M71v2o040m8a
	MixNEI75krO5UcQtr5Hw5lyyWtID3OP8+MYgAp66LnvOQ+g8QWt1tfq/Ou2V9/CE8rWMhonEWdfsw
	jK7McyYXIHiEgPpZQNydBqfQLOQ6UlgdktOAn7BtAV8sNi6hoSQ+M4GBl2CeuV/CnGpY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wOtpC-000182-HD;
	Mon, 18 May 2026 08:59:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wOtp9-00017v-6p
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 08:59:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z9c0smFMDMaSNn9HS2Tz8dUVSGUNCC3HaQnawkWvZig=; b=XN4kB2XpxCViQt7JP0n/rA0V7k
 T369V7yzGIbUiIrm5kYOYpkbHtlIm+IyfHB5zpAqbipuJzXydRRU8OHIQWY7h4dr660oT11e5TO4C
 yYNd5xMJS5sYvk/MGN3WwNV4bONQ9Rg0+bXbnDRX66CUxlh/GoSp0LgGjEckhLOsJ1Jo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=z9c0smFMDMaSNn9HS2Tz8dUVSGUNCC3HaQnawkWvZig=; b=b
 k1us3/G7GGcRodRcyfJpT0XgC+my4QW6Nh9q5mwm2HHbRo2zmDt0ZLgCtVdu+5mG0cTuHhWJsjke7
 DMEqhNdmYyW4n/kX96SlWs2yciR3PGA1Rw+9i5efE6wTBWKkt4f4UQY1Px2Kgi+77WbRKjALDUu1k
 LQ9cLffbV66W2CXk=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOtp6-0001vV-NE for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 08:59:43 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gJsDv5Y2czDryZ;
 Mon, 18 May 2026 10:59:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779094767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=z9c0smFMDMaSNn9HS2Tz8dUVSGUNCC3HaQnawkWvZig=;
 b=SVGyy7E7yZo7GiHWDbprZW4g3nNODB4/r92cTfAebeCE6mkuPsUCt/itQKyPyxq8LxlxHc
 Int9QMgIcCYARq+uoc4vpqbV/82xUyy/z+CRSzCPKY1FS/2+PxHr4hqSFqvFpSdJ9C9ugW
 WvEt23VIUSnh0iazNmob7IG5nIDseqxcfBflFTbrTt7R7By9AUFyL7yNyPJFZwa6H4OyQv
 fPc5YZfHW+7vakEcRDkczK8k7c7rJBO2G3CQzK9jOIDAhIgFSiMPb2MURoY6wvF8ShMZcv
 WYDyn390aSOzDefWjgWlPthzswAw7cQpIc7Q6uFX0dbfH8wyQw7H41ku1ZspHQ==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 18 May 2026 10:58:39 +0200
Message-ID: <20260518085908.135570-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wOtp6-0001vV-NE
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 1/3] tcp: factor out TCP
 MSS option clamping
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

xt_TCPMSS has local logic for scanning TCP options and lowering an
existing MSS option without increasing it.

Move that scan-and-clamp logic into a TCP helper so other networking
code can reuse it without duplicating TCP option parsing. Keep xt_TCPMSS
responsible for the policy-specific behavior of adding a missing MSS
option.

The helper returns 0 when an existing MSS option was handled, whether or
not it had to be lowered. It returns -ENOENT when no MSS option is
present and -EINVAL when option parsing finds a malformed option block.
xt_TCPMSS treats both non-zero cases like the previous local scan
failing to find a clampable MSS option, so the target keeps its existing
fallback behavior for adding a missing MSS option or accepting the
packet unchanged.

The helper expects the caller to ensure that the TCP header and options
are linear and writable.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v1 (https://lore.kernel.org/openvpn-devel/20260515075941.102225-1-ralf@mandelbit.com/).

 include/net/tcp.h         |  2 ++
 net/ipv4/tcp.c            | 60 +++++++++++++++++++++++++++++++++++++++
 net/netfilter/xt_TCPMSS.c | 36 ++---------------------
 3 files changed, 64 insertions(+), 34 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3c4e6adb0dbd..e722c7d936bf 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -538,6 +538,8 @@ void tcp_parse_options(const struct net *net, const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx,
 		       int estab, struct tcp_fastopen_cookie *foc);
 
+int tcp_clamp_mss_option(struct sk_buff *skb, struct tcphdr *th, u16 maxmss);
+
 /*
  *	BPF SKB-less helpers
  */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 21ece4c71612..ef10e530a1ad 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -721,6 +721,66 @@ static inline void tcp_mark_urg(struct tcp_sock *tp, int flags)
 		tp->snd_up = tp->write_seq;
 }
 
+/**
+ * tcp_clamp_mss_option - clamp an existing TCP MSS option
+ * @skb: skb containing the TCP segment
+ * @th: TCP header in @skb
+ * @maxmss: upper bound for the TCP MSS option value
+ *
+ * Parse the TCP option block and lower an existing MSS option to @maxmss.
+ * The MSS value is never increased. If the MSS value is changed, the TCP
+ * checksum in @th is updated.
+ *
+ * The caller must ensure that @th and the complete TCP option block are
+ * present in the linear data area and writable.
+ *
+ * Return: 0 on success or when no update is needed, -ENOENT when no MSS
+ * option is present, or -EINVAL when the TCP option block is malformed.
+ */
+int tcp_clamp_mss_option(struct sk_buff *skb, struct tcphdr *th, u16 maxmss)
+{
+	int length = th->doff * 4 - sizeof(*th);
+	u8 *ptr = (u8 *)(th + 1);
+	u16 oldmss;
+
+	while (length > 0) {
+		int opcode = *ptr++;
+		int opsize;
+
+		switch (opcode) {
+		case TCPOPT_EOL:
+			return -ENOENT;
+		case TCPOPT_NOP:
+			length--;
+			continue;
+		default:
+			if (length < 2)
+				return -EINVAL;
+
+			opsize = *ptr++;
+			if (opsize < 2 || opsize > length)
+				return -EINVAL;
+
+			if (opcode == TCPOPT_MSS && opsize == TCPOLEN_MSS) {
+				oldmss = get_unaligned_be16(ptr);
+				if (!oldmss || oldmss <= maxmss)
+					return 0;
+
+				put_unaligned_be16(maxmss, ptr);
+				inet_proto_csum_replace2(&th->check, skb,
+							 htons(oldmss),
+							 htons(maxmss), false);
+				return 0;
+			}
+
+			ptr += opsize - 2;
+			length -= opsize;
+		}
+	}
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(tcp_clamp_mss_option);
+
 /* If a not yet filled skb is pushed, do not send it if
  * we have data packets in Qdisc or NIC queues :
  * Because TX completion will happen shortly, it gives a chance
diff --git a/net/netfilter/xt_TCPMSS.c b/net/netfilter/xt_TCPMSS.c
index 80e1634bc51f..70983b757229 100644
--- a/net/netfilter/xt_TCPMSS.c
+++ b/net/netfilter/xt_TCPMSS.c
@@ -30,16 +30,6 @@ MODULE_DESCRIPTION("Xtables: TCP Maximum Segment Size (MSS) adjustment");
 MODULE_ALIAS("ipt_TCPMSS");
 MODULE_ALIAS("ip6t_TCPMSS");
 
-static inline unsigned int
-optlen(const u_int8_t *opt, unsigned int offset)
-{
-	/* Beware zero-length options: make finite progress */
-	if (opt[offset] <= TCPOPT_NOP || opt[offset+1] == 0)
-		return 1;
-	else
-		return opt[offset+1];
-}
-
 static u_int32_t tcpmss_reverse_mtu(struct net *net,
 				    const struct sk_buff *skb,
 				    unsigned int family)
@@ -77,7 +67,6 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 	const struct xt_tcpmss_info *info = par->targinfo;
 	struct tcphdr *tcph;
 	int len, tcp_hdrlen;
-	unsigned int i;
 	__be16 oldval;
 	u16 newmss;
 	u8 *opt;
@@ -113,29 +102,8 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 	} else
 		newmss = info->mss;
 
-	opt = (u_int8_t *)tcph;
-	for (i = sizeof(struct tcphdr); i <= tcp_hdrlen - TCPOLEN_MSS; i += optlen(opt, i)) {
-		if (opt[i] == TCPOPT_MSS && opt[i+1] == TCPOLEN_MSS) {
-			u_int16_t oldmss;
-
-			oldmss = (opt[i+2] << 8) | opt[i+3];
-
-			/* Never increase MSS, even when setting it, as
-			 * doing so results in problems for hosts that rely
-			 * on MSS being set correctly.
-			 */
-			if (oldmss <= newmss)
-				return 0;
-
-			opt[i+2] = (newmss & 0xff00) >> 8;
-			opt[i+3] = newmss & 0x00ff;
-
-			inet_proto_csum_replace2(&tcph->check, skb,
-						 htons(oldmss), htons(newmss),
-						 false);
-			return 0;
-		}
-	}
+	if (tcp_clamp_mss_option(skb, tcph, newmss) == 0)
+		return 0;
 
 	/* There is data after the header so the option can't be added
 	 * without moving it, and doing so may make the SYN packet
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
