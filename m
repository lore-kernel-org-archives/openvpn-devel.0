Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB89606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jQTX2Fds;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=I0jswK4Q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BVRS7zog;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=wKo1NOFQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fXWMuBi9MSl7WDwrkjUanYT6KMtweOrLxoGDWL1LMbY=; b=jQTX2FdsGGWB00
	Xd9wDRfXu25qeb+058x+D1rhlm/qgP24hBPyPnCW9QWNBBYqSj4dXvk/ayFgWHa00fT5MIJ7kjhL+
	Ah+Hl74/Bqo87PhGuVZxNmEyoxfuS5i8GIbKyxuOTkAQyRTaSk/ddmravBAiCAYb9AruNkjQ/zlES
	8VA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWbCQ-0000000046B-2X1s;
	Thu, 26 Nov 2026 15:15:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xWbCN-00000000461-49T8
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:15:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h5R7fYLRHqAat7Q5w961I3HDrA+addnrf/fD5FTcrLU=; b=I0jswK4QFWJJlRWusl3FhSbA5d
 TTKNv0+H4rk7EOasL24V0L1bQ+NBRslZhKsYoDkno/s1lm6L+HsQ4yN8cAj2/9jyMjWtnGnNr0Ufd
 6pZmj3TWO6BuEc3B60ZcG8rHDH2xugz7+nbE7ymlalSJ5+NUbX2EOXwiVn5FGPSxlk4c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h5R7fYLRHqAat7Q5w961I3HDrA+addnrf/fD5FTcrLU=; b=BVRS7zoglnq1y9yPXRDOpKw9Js
 wzOs+/r7Zbrm2hsZ9AGxaz2leGOqoMRedyGVMLmeANH+eQC8U3woT/Isx77cq8WcHA2HRjCpHU3xD
 inEUVOBe75N6XFn8WyaHjF5sab4hgS7hYSHXqhntgrNm3ljgnNu76NgU530XiO/NwyyE=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWbCM-000000006YP-0rKV for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:15:47 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jb0VL24fsz5wn2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 16:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795706138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5R7fYLRHqAat7Q5w961I3HDrA+addnrf/fD5FTcrLU=;
 b=wKo1NOFQN5yTigUAmq8mKzrDTs02MKjXW88463HluKFKH8l7ATq5SsYlT2PGWuc1if3yc6
 X0HJfVh0jMjxNh51Wz+y7YY4AW1ieZvLq2F6xO8xXA6x4Z/EjIWydY1Pvp36vnePqnu8//
 FFN0gpXC91ZsrH+Y/P8UCCPjVFXcaomifEvAQ/fGu+xET+Qh3CLlbKmHrvS9N8Uznu0PT7
 7T5Jl8OcGu92tj+T8kv7u2hEWfWPgS9nmjgxKU/Y0mU7g6hJ3vDgPkZ4cB2V3aDDaYNpq0
 AQRLLM6E/VMO1JtuA5KbGFWVmAqwK3C0Kcq48ZSSenKKPEUOIDfRLr+3xfAPkw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 16:15:25 +0100
Message-ID: <66abb498beb30d5d51d64a7cd3e7d91a13171c27.1795704654.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795704654.git.ralf@mandelbit.com>
References: <cover.1795704654.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jb0VL24fsz5wn2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWbCM-000000006YP-0rKV
Subject: [Openvpn-devel] [PATCH ovpn net-next 3/3] ovpn: drop redundant
 workqueue_struct forward declaration
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

ovpnpriv.h includes linux/workqueue.h, which already defines struct
workqueue_struct, and needs it for the delayed work in struct ovpn_priv.
Remove the redundant forward declaration added with ovpn_wq.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/ovpnpriv.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 84499140e4bd..0f56da4eb65c 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -15,8 +15,6 @@
 #include <uapi/linux/if_link.h>
 #include <uapi/linux/ovpn.h>
 
-struct workqueue_struct;
-
 extern struct workqueue_struct *ovpn_wq;
 
 /**
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
