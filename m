Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D962C61DD9
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qYzwudV+NzBLNRJEmob+rXxGadxGGgQK8RELb0n1irM=; b=GUgnJjKRLCF/1iFD7OidIlmeHT
	oWBalfpoWTViBoYUlv3pIYoAmX50dVXlvcLq/dzhWghnRgdm6e7QbTNza89AThhGZzvWqkepqKmEZ
	z5FyZ1FnbZf8vtMoIZGzyY0NxTn7BiQC3TnjM0bv4SjeIa2PIElsZeurB6cOtGYpQfak=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzxv0-00048C-P0;
	Fri, 28 Aug 2026 14:50:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wzxux-000484-Aq
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:50:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mGXWEtESJmpRf+hvG7ryt7oZfowt9ZJ+xoPXROLSSX0=; b=AUz7ic8FgU2QraKkRzD48lEznJ
 WTWO4H2Dc1JAlok+92GfwxKvIkcwkN43gR+OuCMutWaBF1hlTJxC9vrRxzb4dsZc5DxQX4b+iL9T+
 TVts33oMt6jabxAP7iPxiyNGpk504c1+nhUASlifB2EGEEEEdEr4DQY8Oudlnncf3HPs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mGXWEtESJmpRf+hvG7ryt7oZfowt9ZJ+xoPXROLSSX0=; b=K+0GPBGucahgmXfski1KEcZ9vA
 AQ2N2IHMH6NmhIWdEP74jDM5rJt69TOIB1GcTccM1ZMkYenlcTRfITvlQhyj1de3PD9phwT2+sPbt
 dEMmNbQn+eBbAbBUP2ZoqBr6IMzMWjXM9/ogArSMxBBJyZAJGL1jg8JAAmQaPJlHpbyA=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzxuq-0005qW-Mm for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:50:52 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4hWhC43lkzzNlfQ
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 16:50:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1787928640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGXWEtESJmpRf+hvG7ryt7oZfowt9ZJ+xoPXROLSSX0=;
 b=crTjqrp4dosbNRoMW125l7hCu+h5pPouZNYToUaWv74IJrwSZ0B/N9LocP6MeFnBDdjqXm
 Bx+prHmUKaw6IYR8O3x6T//BTX+4vSitxvlf6eqksaqU39zLdUsjnzQz1G5Prvu0qi/ZnK
 FIgYZnnhoJnPOHDW9tDiGSJBUmHuuOXsJZnehYZBpu4Y2jIZv1VnZ4Xdx15aPp4RLyAVNc
 quLKoAQVRz2B831ClUCDPAsiaJxLu6a1sBgaEc7nkzEzZI9iMIgvVQ046J8gNtNFtIsxCN
 LZ1ufB7MHa+kSM/ZPjQgKppdQP/tRC0gnODuj9tcJZ74F18M24UaH4N3JX1xxA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 16:50:23 +0200
Message-ID: <204af84e2b14079780e06d32ad24c88f1b2d1999.1787925761.git.ralf@mandelbit.com>
In-Reply-To: <cover.1787925761.git.ralf@mandelbit.com>
References: <cover.1787925761.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hWhC43lkzzNlfQ
X-Headers-End: 1wzxuq-0005qW-Mm
Subject: [Openvpn-devel] [PATCH ovpn net v3 2/6] ovpn: skip UDP source
 validation for unspecified addresses
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

ovpn validates the cached local UDP source address before reusing or
refreshing a peer dst cache. This is only meaningful when a concrete
source address is selected.

For IPv6, calling ipv6_chk_addr with :: checks whether the unspecified
address itself is configured on the host. A peer may legitimately have
bind->local.ipv6 set to :: when no local endpoint was configured or
after a stale learned address was cleared. In that case the source
should be left unspecified and selected by ip6_dst_lookup_flow().

For IPv4, inet_confirm_addr(..., local = 0, ...) asks for local address
autoselection rather than validating a chosen source. Skip the precheck
there as well and let ip_route_output_flow select or reject the source.

Only validate non-zero/non-any source addresses.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v2 https://lore.kernel.org/openvpn-devel/cb51001bfdaeba899b6ca9b22186ea2ebb49c23c.1785308184.git.ralf@mandelbit.com/

No changes since v1 https://lore.kernel.org/openvpn-devel/cb51001bfdaeba899b6ca9b22186ea2ebb49c23c.1785253480.git.ralf@mandelbit.com/

 drivers/net/ovpn/udp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 7f69e8890b5b..df4750dabd1e 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -161,8 +161,8 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	if (rt)
 		goto transmit;
 
-	if (unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0, fl.saddr,
-					RT_SCOPE_HOST))) {
+	if (fl.saddr && unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0,
+						    fl.saddr, RT_SCOPE_HOST))) {
 		/* we may end up here when the cached address is not usable
 		 * anymore. In this case we reset address/cache and perform a
 		 * new look up
@@ -238,7 +238,8 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	if (dst)
 		goto transmit;
 
-	if (unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
+	if (!ipv6_addr_any(&fl.saddr) &&
+	    unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
 		/* we may end up here when the cached address is not usable
 		 * anymore. In this case we reset address/cache and perform a
 		 * new look up
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
