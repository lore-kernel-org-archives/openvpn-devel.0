Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6240C5321C
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oj8Z5EuLMRxrE2iZMLlUC+4BrcJM5h7LPIlkZgChsak=; b=cEGA4/KN2QM+drzV8fmc6reilm
	J49x/FyO9mCsXmvKzCY1jICG9Xks4uHnLGLekUErdy+jlxGDG9AcP8leuSeVkCWLGnE6yBIwkGRZM
	Ad5lKzb+j/DmmRbvwP/F/aCy/41XV2HwkUuLGmf/caPbm1iYyGulaICP+Ii5VCkWcxhM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woRbh-00063U-O3;
	Mon, 27 Jul 2026 20:07:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1woRbg-000638-6N
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 20:07:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ixElgIOpjex/L7zdwx7lUWOiWK5w4EbBc2Uvh57Z4fI=; b=Jl5Ek1ztTDc7FaZvJLO+L8nbS6
 cu8W3c/9a7W61y5dreEuY+Mh9LUkk7DIlL5gH1P2Y/25KNW4uyw6thdCL5nPShZNGmW2buAUZRZ50
 frm+jWI3Alno0CLvTO3Ra/HPGuobrR5ptgFFrfoxoSLWA5v5kj74wNcppdaGfSxTwPSQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ixElgIOpjex/L7zdwx7lUWOiWK5w4EbBc2Uvh57Z4fI=; b=X3xT1IzoUZKZKgxVuMq6dvt6Ri
 HPFhYbJhUydiUDb7lFyu0kzwy0PaSo+XJX89MYaW+b/DCIrvUex+yjSB4TkGTb2y9+tLiLhYGcmEE
 OXnNH/Eqa3HkPUhygQ6XuGJBxlkWOkT5t8qhXgqr20NX8sNrIAToAIET2gLXDVESfotk=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woRbi-0002cp-Nt for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 20:07:24 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h88l74C05zKw2N;
 Mon, 27 Jul 2026 22:07:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785182835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixElgIOpjex/L7zdwx7lUWOiWK5w4EbBc2Uvh57Z4fI=;
 b=LLfawQVSg+Y4jKWZP/gc/QI0SHIcuFoAZcvH5Uv/wMZw3M9GF1zqqZDPEkCSrvEkdDkAXH
 susfja5Q1P6qia15s8qy+qMe9u59ByYvi4ZXcgVY3bMTqULknsX/jV3c9wA8hrkz7CiT9x
 8T4dHmYV9y8GajFahxZ2XUdnf99FwM1Viy5CybQaHrRv5K8bunvR6Qn+gG6wsZ0jEUwIcO
 7/58gmmuucu6H24dxk0qRPHrbKxzrjLenA2LuqU4xx66vw0hOCa/hi51e2MqqBHXmxa25F
 KBp6yWMC83ibFUn0HwhrSIIoeP+QLHq+HCH0VfEFGU6paafbPPAFFDZnWlrKcg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 27 Jul 2026 22:07:00 +0200
Message-ID: <20260727200705.869169-5-a@unstable.cc>
In-Reply-To: <20260727200705.869169-1-a@unstable.cc>
References: <20260727200705.869169-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h88l74C05zKw2N
X-Headers-End: 1woRbi-0002cp-Nt
Subject: [Openvpn-devel] [PATCH ovpn net v3 4/9] ovpn: ensure socket is
 owned by ovpn before deref sk_user_data
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
Cc: Antonio Quartulli <antonio@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Antonio Quartulli <antonio@openvpn.net>

Some subsystems, like BPF SOCKMAP, set sk_user_data without
actually setting the encap_type.

For this reason, we must make sure that the type is the
one ovpn expects before dereferencing sk_user_data.

Failing to do so may lead to out-of-bounds reads.

Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/socket.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 517caa64a4fe..6cbeb2caaeec 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -162,6 +162,15 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 		rcu_read_lock();
 		ovpn_sock = rcu_dereference_sk_user_data(sk);
 		if (ovpn_sock) {
+			/* something else filled the sk_user_data without
+			 * setting the encap_type. Reject the socket.
+			 */
+			if (!type) {
+				ovpn_sock = ERR_PTR(-EBUSY);
+				rcu_read_unlock();
+				goto sock_release;
+			}
+
 			/* socket owned by another ovpn instance, we can't use it */
 			if (ovpn_sock->ovpn != peer->ovpn) {
 				ovpn_sock = ERR_PTR(-EBUSY);
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
