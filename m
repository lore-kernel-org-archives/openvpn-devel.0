Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B51606A338
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q0Xwzwbu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Lr7qcd6U;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JND5JJ7W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qw1QB70H1eEgfxrcDFwcZncCzjrX07aOY1A2uUNN/4k=; b=Q0XwzwbuUUgGRw
	REjGq9ky7Y9Ir9dO/q/4/0jUZM1T6ahmpgRfXd96yrDGd4hnFwRppzc/065Z4FMjz70nPo98piInn
	VmuFxhrZxz7tgbQzKFK1ZoqZK8Yep0NRndVWt0NlajguU3uwMH5U8EXEwDMjqA9yG/2aGRyrawRW5
	ZBs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSvoB-000000002BX-3hVU;
	Mon, 16 Nov 2026 12:27:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSvoA-000000002BQ-2C3I for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:27:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kxN2fpqzHfup67n79sIERIrtF7VMEcpU9/eT0I3nCa8=; b=L
 r7qcd6USwUv4oM/U5ZTGCn2+KR6CfwrXmyYfwvFQwpuomb2yC3l1XMlF+zKFO7DZhvpy6HmEJJLm5
 z2Q+2HuZbjOpEW0axg8tFW4t/i/TxctOzPBdMHDBtbeBaJblEs5nAzsbjX96J/ypZRsKjIUXno1l6
 +Bfl8sxlAByGgH1k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kxN2fpqzHfup67n79sIERIrtF7VMEcpU9/eT0I3nCa8=; b=JND5JJ7WHqOnCoytDO4UycgBuD
 nd/BwZzcHw7S46q4Bgi40G9/4j6CGFd0ZfPwqQuXpAoLBFOmxRzRoKX264/KQrnAzqwheQaQXtdno
 +5QzHfhtwNlvKPPXyoK1ecyc74vqqRyj/hZJ5nMAP1lCZhetZLxMrwXAEQTYJoaUAFMY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSvo8-000000003Rn-2sNu for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:27:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AGCRUxN072702;
 Mon, 16 Nov 2026 13:27:30 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGCRUup072701;
 Mon, 16 Nov 2026 13:27:30 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 13:27:30 +0100 (CET)
Message-Id: <202611161227.6AGCRUup072701@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261116095438.11288-1-gert@greenie.muc.de>
References: <20261116095438.11288-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSvo8-000000003Rn-2sNu
Subject: [Openvpn-devel] [PATCH applied] Re: contrib,
 sample: drop SysV-era init scripts
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
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The sheer horror... while I do have a liking for SysV init scripts,
*these* were just not very good, not even as an examples... out, out.

(And since it's really like "nobody should be using those", out of 2.7
as well).

Tested 2.7 with a "make distcheck" - Patches that add or remove files
have a tendency to break "make dist".  But these were not shipped in
the tarballs, so really really unimportant cruft.

Your patch has been applied to the master and release/2.7 branch.

commit b0668301ed71e90dfed96c4e5bfafdbe2000ed93 (master)
commit b884018db65ea823643678f66431eab552455b31 (HEAD -> release/2.7)
Author: Razvan Cojocaru
Date:   Mon Nov 16 10:54:32 2026 +0100

     contrib, sample: drop SysV-era init scripts

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2186
     Message-Id: <20261116095438.11288-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41407.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
