Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11389606A32C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jypXKrrq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d1uVCWjl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ItW42JWR;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ws58Gpdl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=wgPgiwMHYYi6Y6Ek6BB4XYLadGK6hf3LvgnHJlfP9sI=; b=jypXKrrq3TORbbNidYDslaU90z
	pE8sn74K9/2ZqhXEqYxK3zW0bf2uL4uvpu+mhIXjJf2zqCP0cvMD12B3tbajns7ITUQit8EQv5RkC
	BO6qkN+ffmB9aL81s3s+ZBDklZsGtBuoMmoZW72IDd5aLlR39THFUM6aQBcxWtktWZss=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWUKp-000000007Ie-1MeU;
	Thu, 26 Nov 2026 07:56:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xWUKm-000000007ID-3LmH
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 07:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PG6amJbK+YEWao7Z33dhUoczErC1SP+i6uieuAe+Ei8=; b=d1uVCWjlvnH4jmLqpLpu/iH1lR
 iVKgM35omviVpMv3JO1MEAmfeLai8021jNaL4GeGvZ9foIsJLjQRfj1Bz4QaoIxFixDq4JxMU/rAy
 P7DgbcZLakAGaa1JgdfNpcxIlH5RsXT9TJukKjKeQ2BZ9TkJIH8hXjenn9erCdd0U4eo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PG6amJbK+YEWao7Z33dhUoczErC1SP+i6uieuAe+Ei8=; b=ItW42JWRfnDAJ5tPw0g+lmVpkZ
 bsJgiwsxQVb99GxluI6BVZmQhlMg3YkjnzOsNgsmhiZL9ZtFZOBZ4YrTK6vJ4yqQ9B31RBsWsI5ds
 hFpcOTtgMH8+Vb4ddXwV2rCiq9Qrze5s9wspa+aRHbdGd4LuPiQzeewrzv28/2ivgJf8=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWUKl-000000000KT-1LxY for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 07:56:00 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jZpkv2X7lzFqbx;
 Thu, 26 Nov 2026 08:55:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795679751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PG6amJbK+YEWao7Z33dhUoczErC1SP+i6uieuAe+Ei8=;
 b=ws58GpdlswqMVIeW31HlveaGJnjFibe5yv76SWfs3kXo8Ul0hCQOD8vHtFfWGiB3VjXtQq
 cTPAHAxjKNEWqiseum0QK8D99KvZc2R9YohcuFyhX5JJVsWea4mzVQ8N3bO4sYY9FJMGNa
 cHQmoMYXH0VqORuFN9+zPVSs63RF/VOqfmf0hVVF91UaljzDNl/UfiR5rQLYWpN5tJ079Z
 VdGIUd9f2Ayn0KEGYxhsDo3+/5lmsKr4bqqinuklewpgpp0/ZNW9z/gFUo0PbJtuVi8hMn
 9OmyEW4mgrc48z2iqZuLu6Io8bgUJov1hz0Yb2DSsCs9ioNUJAEAh3GRAjawYg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Antonio Quartulli <a@unstable.cc>
Date: Thu, 26 Nov 2026 08:55:44 +0100
Message-ID: <20261126075545.30501-1-ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126005459.3289071-1-a@unstable.cc>
References: <20261126005459.3289071-1-a@unstable.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jZpkv2X7lzFqbx
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWUKl-000000000KT-1LxY
Subject: Re: [Openvpn-devel] [PATCH ovpn net v2] ovpn: disable BHs in async
 encrypt completion callback
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026 01:54:59 +0100, Antonio Quartulli <a@unstable.cc> wrote:
> From: Antonio Quartulli <antonio@openvpn.net>
>
> ovpn_encrypt_post() may take the TCP transport socket lock with a plain
> spin_lock(), which requires BHs disabled as the lock is also taken in
> softirq context. Some async crypto drivers complete requests from a
> workqueue or kthread with BHs enabled (e.g. qce, starfive, keembay), and
> a completion can then deadlock against TCP softirq processing on the
> same CPU.
>
> Crypto drivers are expected to complete with BHs disabled (see
> crypto_engine's lockdep_assert_in_softirq()), but not all do: wrap the
> async encrypt completion in local_bh_disable()/enable().
>
> Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

Reviewed-by: Ralf Lici <ralf@mandelbit.com>

One optional nit: adding a lockdep_assert_in_softirq in
ovpn_tcp_send_skb would record the "BH must be off here" requirement
right at the lock but I wouldn't respin just for that.

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
