Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974C606A6C8
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WxNQv7oy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UP2Bqo9j;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KFqIg4GV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=M+H7mAgnJ56i3JN8iSjH32iKalOx6Gwsda22mtagRlg=; b=WxNQv7oyYW3hNV
	CI/BknzHaLKosCKMP7GUadX/Es6hTeneKN7wsbjmEkiWdGFUHFGI/NxotENJGTOH42C1Dhg7vBfpz
	QXH283O2iJTwlDxUqK7A+EDIPOZodVIWAtu59n82FORQS6guYtvXGo8604zXSw3hbA9FfAXAeyxrQ
	7ys=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP3PT-0000000025c-1JSS;
	Thu, 05 Nov 2026 19:46:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xP3PR-0000000025V-0Tu2 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 19:46:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KjE6ub5JK3K9mlVYQO0H6zRMe28PuVBki44qLsAbbRQ=; b=U
 P2Bqo9jgaiUg+ps+vpaiUcuADz/+UlplFgKGbHQHkaUVb14eNhyVOjrkbaQE9rs7GbQdYrsvDR8oD
 FIk28B8LzCmGGot4HwGtvdJv2t0ZoRmqAIrHtD4o8MyKJVZ47GCr0cYM9BhNXkLUlIqGxCe+cKnZB
 QnAu8731PLkEUgys=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KjE6ub5JK3K9mlVYQO0H6zRMe28PuVBki44qLsAbbRQ=; b=KFqIg4GV2R7AexnlwAu/i47rRO
 0cE2x6skDO0RLBBC7Uydrf2OFZ0TCCWqtkHnPIPLwN6ZYqoxuyNmoK9+HdgFfJrkBLAf+ublNN+Wj
 56pwfK+MP9obQr8tyzk250lUqrqAHxjEwFILzv3gZWYn1p8TvU3MFCn06ahCsf5tXpto=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xP3PP-0000000049W-12xH for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 19:46:05 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A5JjujG053807;
 Thu, 5 Nov 2026 20:45:56 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A5JjuU4053806;
 Thu, 5 Nov 2026 20:45:56 +0100 (CET) (envelope-from gert)
Date: Thu, 5 Nov 2026 20:45:56 +0100 (CET)
Message-Id: <202611051945.6A5JjuU4053806@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261103141439.14041-1-gert@greenie.muc.de>
References: <20261103141439.14041-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xP3PP-0000000049W-12xH
Subject: [Openvpn-devel] [PATCH applied] Re: Provide minimal netlink defines
 for cppcheck on FreeBSD and macOS
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

A simple one for a change - "nothing for me to test here", and nothing
that affects actual OpenVPN code.  So if Frank says it's good, here we go :-)

(I'm not sure why this is only needed "if Darvin or FreeBSD", given 
that it's actually "only Linux" that is using this, but whatever...)

Your patch has been applied to the master branch.

commit adf5ecfd8f09da1935a00b039cc0b92bc800c87d
Author: Arne Schwabe
Date:   Tue Nov 3 15:14:33 2026 +0100

     Provide minimal netlink defines for cppcheck on FreeBSD and macOS

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2107
     Message-Id: <20261103141439.14041-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40579.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
