Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562B606A336
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VOyG5c1r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QPpnIRQL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JAC4mF/G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/oh4KmX+kQ0W6w9cbp33TDcGpunrafQISEOlXL5EH3M=; b=VOyG5c1rzjFLHY
	fD8gFtBy0Mv+N8wP0kEG2bYs+pYpFSjb7JXHd4nlaK3mzTo3GHaEWeEGdVxhipS5uLZqUxli1DXrJ
	R4QNa0+XPPMkfGuY1GO69qQoD1TCO+5XWVO+wX/13p+br2ERESzbF0M025l4bwQjpYP1zKVPcBxIk
	lcQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRzWS-000000006vx-3aN6;
	Fri, 13 Nov 2026 22:13:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRzW6-000000006ve-2E1N for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:13:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aYm+Ldm0OeaxsxiYEB1OnWW83jYIQrSHj2KtECzR6G0=; b=Q
 PpnIRQLjO04J5w6KVDNqx1kfBsPQ6Yq1StwyaB8Y9Xz51Org/2uqIN0fYdMnj8oyOWsQe2yEQf8Py
 q/SUjgYg4Mc0+fIK9f81MxVZkLPLR4iEyPTQUL723bHo4z3reuU9j13z05rj22sDUxLhJq3/6DcuP
 Em7Hdphf4jxQN6Z8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aYm+Ldm0OeaxsxiYEB1OnWW83jYIQrSHj2KtECzR6G0=; b=JAC4mF/GicbEpkjzvbcIMjTunA
 TnXWHR3585VUVR6ZZFsERpRuLGGefBb2AxUGmx787KJAsZUCD8CO4yo/IUgaLD9uwMAhUTbBTn8u6
 /TGgNV1Z2Bl81ExqowOz8wpydzeto3ddbOnc7+wm6zEGG5DxuK5+n0HgxQFfK1T2pDB0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRzW5-000000008OS-2eJw for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:13:06 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ADMCpWJ040433;
 Fri, 13 Nov 2026 23:12:51 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADMCp5a040432;
 Fri, 13 Nov 2026 23:12:51 +0100 (CET) (envelope-from gert)
Date: Fri, 13 Nov 2026 23:12:51 +0100 (CET)
Message-Id: <202611132212.6ADMCp5a040432@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261110143722.15193-1-gert@greenie.muc.de>
References: <20261110143722.15193-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRzW5-000000008OS-2eJw
Subject: [Openvpn-devel] [PATCH applied] Re: Various trivial
 -Wsign-conversion fixes
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

And out go the first couple of #pragmas... (this could have been done
the other way round...).  New unit tests pass :-) - and BB is happy too.

Your patch has been applied to the master branch.

commit 30a8bf5eb8eb298b18c32807d39eeaae777c3066
Author: Frank Lichtenheld
Date:   Tue Nov 10 15:37:16 2026 +0100

     Various trivial -Wsign-conversion fixes

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2157
     Message-Id: <20261110143722.15193-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41094.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
