Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E391606A320
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Tw+PUrzY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZUXhx/C6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XkPJK8mD;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=sWtZZjqw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=D8/VcxK/emqD0ajxYonZQkqro+3Tm19wk10BOBk1SYQ=; b=Tw+PUrzYzPFeje
	yIhiVQ+89nvFpUdV4Z6NwsOwHhHgqMlLxdoLenGHwUWjkC7SRhvDKnM8Zi7dAo+GNa2LZMmLM2+YE
	eeO3xd37EUeB+m866817PEII+1mGup50GjYCiSsAtWT0vSea4tyxExgdKz8vxEHZPWlChlP9Jjxzm
	CEo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQpJ4-000000007gL-3yS2;
	Tue, 10 Nov 2026 17:06:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQpJ0-000000007g9-0mXe
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 17:06:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cXcyzr/XZayzcoifNZLbAB0Ma50LPnREs4z0RZ3grpY=; b=ZUXhx/C6SKI3KsLnqw5Dre7SRG
 haQAbz4rxh7nta8cOnHnBoeqdZuZbmY0rSF+DCVQrgYxQVDHUVPNXIcGtOq6ts/XG/VHcy6dV09Fx
 VqCFaVa8sDIY2YDfyJJlOzQgAhLddq4FJKtisKXrMSmCUyGcB+HCW9AmJGDGte5yEst0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cXcyzr/XZayzcoifNZLbAB0Ma50LPnREs4z0RZ3grpY=; b=XkPJK8mDt7Hb7OsSbMxcEZkfEg
 H5UrGWc1ZcLWFRysf5d5Xz01iSd60i6ojQT1JObs8z4tvI49uCJbxXxt2W7mkxdYB4w2Gufr5pI21
 +PRhmZJB7JROo87Is95301seDlTsZpUgX2A8+7Z2mIkERsQgDlugHPdAv04uSLZxxNn4=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQpIy-000000004PW-3Rea for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 17:06:46 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jPCjl5qZwzFqsV
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 18:06:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794330395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXcyzr/XZayzcoifNZLbAB0Ma50LPnREs4z0RZ3grpY=;
 b=sWtZZjqwaHK10hdxtKQlHFgXnw33NSbmxlapSFM4X6zqIzThjOevX2Te9dJr8NCIa1jTyV
 MAyfkH2Mojql8syBJsKrWuGnHKdGM9iUQgBcvSCTg29CfrpkngorDJe+KiYFF1sAaahx0V
 fmOSgiSIq6ZHnzuqSDUC8gHS013BWOxm32MLJ6aPzGEuEFHq2PnMcCxN1MoBIovMv0f/eK
 73bzwYAoMArQLDx4GaOhr+DnckYmjTs0GOZizagGpphWJfOyCXeypHPo5nESRnvAjC3/gD
 t2c2EHaTV1wmOwfweqZAL0Yj0j9iUj2mr9zKXIsGNDpHo2Jm2RxbPc88ihg4yQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 18:06:20 +0100
Message-ID: <26279b0076d6ad26368041341247897fc1e95f08.1794329430.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794329430.git.ralf@mandelbit.com>
References: <cover.1794329430.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jPCjl5qZwzFqsV
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQpIy-000000004PW-3Rea
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 4/6] udp: detach tunnel GRO
 before changing UDP encapsulation
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

A UDP socket may retain a detachable tunnel GRO callback while it
remains visible to userspace. If userspace subsequently changes
UDP_ENCAP, replacing the encapsulation callbacks without first retiring
GRO leaves the old callback lifetime and frag-list acceptance state
active.

Validate the requested encapsulation type, then detach such a GRO
callback before installing the new encapsulation implementation.
Existing sockets are unaffected because no current user enables
detachable GRO callbacks.

UDP_ENCAP already permits userspace to change the encapsulation type of
a live socket even when driver state remains attached to it. Resolving
that pre-existing ownership issue is outside the scope of this change.
This only keeps detachable GRO state and callback lifetimes consistent
when the existing transition occurs; it does not make cross-encapsulator
ownership handoff supported.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v1 https://lore.kernel.org/openvpn-devel/99b9cccf9845899bc36e92165d9443499fe8a284.1794314969.git.ralf@mandelbit.com/

 net/ipv4/udp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d62452c0f663..2d16a220c42d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3019,6 +3019,9 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		case 0:
 #ifdef CONFIG_XFRM
 		case UDP_ENCAP_ESPINUDP:
+			if (udp_test_bit(GRO_RCV_DETACHABLE, sk))
+				udp_tunnel_detach_gro(sk);
+
 			set_xfrm_gro_udp_encap_rcv(val, sk->sk_family, sk);
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == AF_INET6)
@@ -3031,6 +3034,9 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 #endif
 			fallthrough;
 		case UDP_ENCAP_L2TPINUDP:
+			if (udp_test_bit(GRO_RCV_DETACHABLE, sk))
+				udp_tunnel_detach_gro(sk);
+
 			WRITE_ONCE(up->encap_type, val);
 			udp_tunnel_encap_enable(sk);
 			break;
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
