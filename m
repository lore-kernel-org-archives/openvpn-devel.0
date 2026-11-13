Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122D606A33A
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MXc2G4Q7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=abMnQwHM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=b7EdUswT;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ZeqjcpCE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JgZErJnpRdqIlrcUOLBSyAe0Tqhwpk7LcLRP0o117L8=; b=MXc2G4Q7MG5o87
	YMLkMkDZEzFi/nTJQ4TBgAEwlNTq5fJJTcbSP83VjzXhjClT4FqsshwrgufhCAVewflPsHyqEqArS
	TrBNmHQXJNwSXe1nPHekl9jepaMoRoiHYTReYYHG53G0T6qxEaBx1IqGbvLh8rsLixh34MYYKM1kD
	6kc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRtZP-000000001cn-2CdN;
	Fri, 13 Nov 2026 15:52:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xRtZ3-000000001bt-1LEd
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:51:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PnishJYZCdOosstd08Ph7cb7j/Qs7x0wTJFNKRd92y0=; b=abMnQwHMwHznijIAaf7dB19ssR
 VTYtVi0vSpfaSWsY5volT98JUTpMhwvcMsTieHX9+5lFPe5PJCjBDWDXte2eqfvk0V1lZRnp/uCBa
 5EOkXp2wFOA4vvMfEwxqcv5BR+9r8XnfI7ImaEnNtvk+WkoWCQ6GN6VQYnH48m2TLSNI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PnishJYZCdOosstd08Ph7cb7j/Qs7x0wTJFNKRd92y0=; b=b7EdUswT9UwMw9/ZaGW9LuvHzD
 tILQr5Xzp4POAARexoLd01YoUyLFTM074qXw1SWrqBOQFhAidH5u/Y2LX2+dop0/KhTxdkFQmqbOQ
 ndQVAy2Pyd7SDeuPJhKjmE9qqPR/wzWBk2wc+hnBOT3Bvjo0f2G2QUlE21j+VgsWrK4g=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRtYp-0000000082e-0YDt for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:51:35 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jR1vZ5Fh6z3xwJ
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 16:51:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794585082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PnishJYZCdOosstd08Ph7cb7j/Qs7x0wTJFNKRd92y0=;
 b=ZeqjcpCEUaSHs8fOcVMzuZ6KCgJGmQb/0qvZ/dzo4/eobotu5ksaPF1AgaCCVhJQ2bBx2p
 FWwUM3kWgdzqvzQbKyuXEMzUX17GeMulshjev9mpNhMUGecQd1ZfxhdydRs2XBDwO0E5TF
 eLWzKTD/nRsfDuql7boz4OsQFlarMSXFdu+Gnc/50ot/4PtU4Bliodo/SfcKiasd1bkTTf
 /zolt+HecoR7saOTDlvFSx++ouL7ff2w85L/UsvlMV2cp4EI5mBUAreAoi7sOS3oop7ku7
 GJCKRcVovVRuPT8SUOtCvzn3NOFrQ8lxyViwWg0uKxogkt/mzhe01L6m7YK71A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 13 Nov 2026 16:51:06 +0100
Message-ID: <eda873613a62eedfcab20c948e603ae6f2801a72.1794584066.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794584066.git.ralf@mandelbit.com>
References: <cover.1794584066.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jR1vZ5Fh6z3xwJ
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRtYp-0000000082e-0YDt
Subject: [Openvpn-devel] [PATCH ovpn net-next 1/5] net: tso: advance header
 state independently of the data cursor
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

tso_build_data advances both the TCP sequence number used by the next
tso_build_hdr call and a cursor over the payload's virtual addresses.
Callers which walk the payload in some other way, such as
bnxt_sw_udp_gso_xmit through tso_dma_map, can skip tso_build_data only
because UDP headers carry no sequence number, so a TCP user of the same
pattern has no way to advance the header state.

Add tso_advance_hdr for that and use it in tso_build_data.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 include/net/tso.h | 15 +++++++++++++++
 net/core/tso.c    |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/net/tso.h b/include/net/tso.h
index da82aabd1d48..0a8020274882 100644
--- a/include/net/tso.h
+++ b/include/net/tso.h
@@ -18,6 +18,21 @@ struct tso_t {
 	u32	tcp_seq;
 };
 
+/**
+ * tso_advance_hdr - advance the header state past a segment's payload
+ * @tso: TSO state initialized by tso_start
+ * @size: payload length of the segment just built
+ *
+ * tso_build_data does this while also moving its cursor over the payload's
+ * virtual addresses. Callers which walk the payload in some other way, for
+ * example through tso_dma_map, use this to keep the TCP sequence number of
+ * the following headers correct.
+ */
+static inline void tso_advance_hdr(struct tso_t *tso, int size)
+{
+	tso->tcp_seq += size; /* not worth avoiding this operation for UDP */
+}
+
 /* Calculate the worst case buffer count */
 static inline int tso_count_descs(const struct sk_buff *skb)
 {
diff --git a/net/core/tso.c b/net/core/tso.c
index d2934bcfa795..c091bee795a7 100644
--- a/net/core/tso.c
+++ b/net/core/tso.c
@@ -47,7 +47,7 @@ EXPORT_SYMBOL(tso_build_hdr);
 
 void tso_build_data(const struct sk_buff *skb, struct tso_t *tso, int size)
 {
-	tso->tcp_seq += size; /* not worth avoiding this operation for UDP */
+	tso_advance_hdr(tso, size);
 	tso->size -= size;
 	tso->data += size;
 
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
