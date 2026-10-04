Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28573CA5FCE
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=52nFKgcUH98+pMCi4fbF9MUc+/m8VlONrRdM4+pbK8A=; b=DKSKX9PJbUxkW8IGG8ygsheRvQ
	yox74ycBM3rPS0dVvFaFYuhFAjbwCSj+wVmlXnxyOGxDWDklBbNcLX8iu+0W4R2BDm/9+37y0mQML
	IMhS0robh42rnS/SwmuhtRnyg57IS5WmfgnsFoP9HqOTC5nHnUTKaxFSJvOxDQqYo4qM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDIC9-0007r7-1t;
	Sun, 04 Oct 2026 09:07:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xDIC7-0007qs-Ci
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 09:07:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TxflWTSqhAE49xSc7/rmVgWQgY4DYjxaxqCGBWRl1og=; b=NMJ++240RHI+/N1yQJ2Jm1mia4
 NW2ob1YiCeanblORAO+GZ0FUIrZpY6QWnUFkpvVS7IudaROCQnKbbGLK8n4lBPqlzYuzjoFQqUEoD
 s/+HYgYTPIkLUgMB8mmG5rI70oWjdEQhF3I+rbdLpMfaGX91P8D/rurZsS/vPe0jRzdE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TxflWTSqhAE49xSc7/rmVgWQgY4DYjxaxqCGBWRl1og=; b=F/loRABOu1A0Z7f5usSg2tYTJE
 Zmuowe36TiudX+PwkuE2QMoVm9A3cX8faghy5YynVFiLsAgx2ZMf2OYsVaqP74KT9CEemWEDFD+G2
 t/sf51FruPy5mffSNd7Wkm1jFhLcJeOZARnVnwDTwgc6e2eVulJ5eAmXjzskc+lmC17o=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDIC6-0002lM-Bd for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 09:07:44 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69497T5l086801;
 Sun, 4 Oct 2026 11:07:29 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69497TmV086800;
 Sun, 4 Oct 2026 11:07:29 +0200 (CEST) (envelope-from gert)
Date: Sun, 4 Oct 2026 11:07:29 +0200 (CEST)
Message-Id: <202610040907.69497TmV086800@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261003204342.19505-1-gert@greenie.muc.de>
References: <20261003204342.19505-1-gert@greenie.muc.de>
X-Headers-End: 1xDIC6-0002lM-Bd
Subject: [Openvpn-devel] [PATCH applied] Re: Fix all occurrences of cppcheck
 invalidPrintfArgType_sint
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
Cc: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Looks reasonable, got a +2 from Razvan, and builds all green...

(Applying the patches slightly out of order will lead to conflicts in
cppcheck-suppressions.cml for #1663, but I'll deal with it when that
one gets its +2 ;-))

Your patch has been applied to the master branch.

commit 02d1e01f93d1125646e2645795a5c60acbc68b47
Author: Frank Lichtenheld
Date:   Sat Oct 3 22:43:37 2026 +0200

     Fix all occurrences of cppcheck invalidPrintfArgType_sint

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1958
     Message-Id: <20261003204342.19505-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39678.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
