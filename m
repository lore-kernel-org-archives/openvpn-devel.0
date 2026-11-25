Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C15F606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=md8vLogF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TwPI3NkG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=majvnKO9;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=L5GEU7RM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nyUCLVCRHJgCbWasf1+8JDgL3a1IIMHwSOjqokjGLy0=; b=md8vLogFWI8hqE
	m4rf6WdGEdZ2YVbaRt5+5FdDzaY5RQTmYz/jiDURhZS+dhAFfmbF2nCldEpmdGQE0qRo0HAs/LAcr
	ijI0NX3syszjJuylf0Jt5XpmBWserpMOETKJMyU8QCT+j3Pp5SoaInVVnG1ZtLlt3TsuiRp+rxrbx
	Rbk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWDWA-000000004Mg-3Fx6;
	Wed, 25 Nov 2026 13:58:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xWDW7-000000004MW-086s
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 13:58:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wr8NL+daBwRS/m4+iry70HHTQwhQBY+YCKUPfH3HE98=; b=TwPI3NkG+Mie1VE1MDtXJMkaYw
 5NpB43dBZU0+e0serXb5AMv3xK1/cXvYa0zguxbuW44dyDT/5ykfgVZG2mzaq/a1u1JBZJzPsFxAq
 XI18AIL4a1aNUQsBp5AN010+qNZ+wJ+5IIFRZzDIn95WNxVHS8n1HZ/xk6TOvUh45YGc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wr8NL+daBwRS/m4+iry70HHTQwhQBY+YCKUPfH3HE98=; b=majvnKO9DiImwuJISqKnMTlfH8
 rhoCWP+6f/S0y4GGE4wR9fgs1S2uq7YLXuqGj5a+UlRjOT2eyGRpr08ziOxH7dWOeFFpmavRoetvs
 la4sw/oSDpvEHACSq518m0Ri+MHxANttVHEg2+y5A8DIrxWNBRKVlureLNG50RIOeE3s=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWDW2-000000000tg-3Td3 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 13:58:32 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jZLqf0MXxzKmBL;
 Wed, 25 Nov 2026 14:58:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1795615102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wr8NL+daBwRS/m4+iry70HHTQwhQBY+YCKUPfH3HE98=;
 b=L5GEU7RMoSWCJKxcsdvUdiU6WS0XZD8Br+6jBmgJtlZU6ydAn1siARVgXpli3JEe+onM3R
 BwQgDAaZHCyFUmUi1AQ6BK38IgDKGSfPUfRmmt35AGYj939qxO8vikjkcBcbiC50wNKr5O
 haYaORiZTaJh2Mz+VOnr31rR100AeeZqwrFciHjEvweRAiRerXROpPh8nb52VEK8wEZPUp
 j4fsAK9oDufg/mbvg1FTr3ErNC4WwE69R+7TYDp2CdPc26r6DBtz+KY4ZgpfXBaj7Qdv88
 yzJSyhopIsE37oI/ccCIjvRxxpfUoIDcdva55NsMy4u6uonpLii68XdMUxGPWw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 25 Nov 2026 14:58:21 +0100
Message-ID: <20261125135821.1808454-1-a@unstable.cc>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125015243.238861-1-a@unstable.cc>
References: <cover.1794388607.git.ralf@mandelbit.com>
 <874ca8e9efb787fd37a942817239c8ba1a4fa4b3.1794388607.git.ralf@mandelbit.com>
 <20261125015243.238861-1-a@unstable.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jZLqf0MXxzKmBL
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWDW2-000000000tg-3Td3
Subject: Re: [Openvpn-devel] [PATCH ovpn net-next v3 6/6] ovpn: prefetch
 encrypted records before GRO batch decryption
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
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/11/2026 02:52, Antonio Quartulli wrote:
> On our perf branch (your v3 plus some RX changes of ours), single stream
> over UDP transport, ConnectX-5 back to back, mlx5 with RX look-ahead
> prefetch, NIC MTU 1500, 3 rounds, Gbit/s:
[...]

A follow-up, now measured on your series alone: your GSO v5 + GRO v3,
same setup (on a 7.4-rc4 based kernel), AES-GCM, 3 rounds, Gbit/s:

                 window   join
  TCP             30.57  31.04   +1.5%
  UDP GSO         32.26  32.18   -0.2%

So on your series as it stands the change makes no measurable throughput
difference: the TCP delta is within the run-to-run spread. The cache
behaviour does improve as expected (about 20% fewer demand fills from
DRAM on the receiving CPU, 6-7% fewer stalled loads), but there the
sender is as busy as the receiver and memory latency is only a small
share of the receive cost, so it doesn't turn into throughput. The gain
I reported only shows once the rest of the path is cheaper, as on our
perf branch.

Given that, I think it fits better as a follow-up than folded into
patch 6: no need to respin v3 for it.

Cheers,

--
Antonio Quartulli


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
