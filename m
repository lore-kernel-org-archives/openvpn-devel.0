Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9F60A260C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z06Dc6rE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W00m0oFE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bTpfC3qc;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=vOV8xGAh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pKDVzIbX63cIS0nOOvLB4mNlrnKCP7Og2agKcJomO60=; b=Z06Dc6rESRvIlB
	c1Bna/GDH/mLVe1OQw2dWVOO7RQiXppwpgrDHjJIjGIMDfCCS4N/PJIP8MHWOCYiWamt9rSBF0zKy
	XyRszcKQ0Ntvk16WYtgugYKRdErnIpC4veQZSNWek3/Jjy81RAxFBJZPQwyZ/QL0jqlKAsvdfGV5b
	qOI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQlN4-000000002Gl-3BbF;
	Tue, 10 Nov 2026 12:54:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQlN2-000000002GS-2B41
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:54:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8/3PaZn0SgeiLxN7L/OeSDL7Mc+IOLoQUhFbk+5cyVY=; b=W00m0oFEH08NfV97Wtz4A6JNDR
 5GeA2NJA9Ao8CkaNbiCkugPcclop1PV7lz9J6OW7xyvTOrNv4EdQiRwAdxGnBSCU8SZwW3EX0YUHK
 aM/Yon/oKURqojVXksx8V47YZAT3xCG6JLoTjyZULhUbO0VRqgpVu4GL55WHjiKOFd/4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8/3PaZn0SgeiLxN7L/OeSDL7Mc+IOLoQUhFbk+5cyVY=; b=bTpfC3qcD5Ja8l5N+m1DEAJKHo
 PXg/BJvfWLOq7jigPGe39aMZ9Of7YqQZ6E0a8b5NJhQ/vDXMnyZLvqkAav9Jp0sCGgaprmKEhTyJk
 IpVzA/OMhNpu6rhMwdEF3KZmuVp4VQq83pO5t0lGy5iV9dYlKWb2VWTs4e9OYo9tiVok=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQlN0-0000000069A-0x4o for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:54:40 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jP66t2rSMzFphR
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 13:54:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794315270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/3PaZn0SgeiLxN7L/OeSDL7Mc+IOLoQUhFbk+5cyVY=;
 b=vOV8xGAhVjA/R3MqiT5sG+Av69ztrGdf1VhJquhtOCLvNaMr7VFKaB2yj7e2wSJiQbVGBM
 +3A4E3fHrmZX26VqIM8zDKJc9LkwX6vLmqWx1JoysRWRE28WWYYCby4sqJtM4l0AKTP1Pg
 JVgi93i9UtZ1bD/yT7CDOkzWceYxcNcSdVPHHFfAc1cpLIdYGOmksS9Xm89RKRJaBecBqN
 4Ot+47iWnNTkIUYtZpREUI/aNdUBTgLdyeUc27HzOeZbpvQ5U5B20abx/voXQ4BH/8z67X
 l836hC/E9XTO6BpmGdFhKuBPXIogmZntjDa7WP4s5MaVzIzs+ap/mldo0MKORw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 13:54:20 +0100
Message-ID: <99b9cccf9845899bc36e92165d9443499fe8a284.1794314969.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794314969.git.ralf@mandelbit.com>
References: <cover.1794314969.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jP66t2rSMzFphR
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQlN0-0000000069A-0x4o
Subject: [Openvpn-devel] [PATCH ovpn net-next 3/5] udp: detach tunnel GRO
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
 net/ipv4/udp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 9b17ae823e56..db0b60ae6859 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2999,6 +2999,9 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		case 0:
 #ifdef CONFIG_XFRM
 		case UDP_ENCAP_ESPINUDP:
+			if (udp_test_bit(GRO_RCV_DETACHABLE, sk))
+				udp_tunnel_detach_gro(sk);
+
 			set_xfrm_gro_udp_encap_rcv(val, sk->sk_family, sk);
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == AF_INET6)
@@ -3011,6 +3014,9 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
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
