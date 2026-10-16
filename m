Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C578DCCA462
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IKeNcSReIChKnNzyfAPcq2FKQ9QMzbCner2G5VtPHwc=; b=k8To6soZPXd8jXLJNk0gBbRHJV
	udBfBCxiGjwQX+dJoX9Llu9YfcdJ7kcMd6DVc3rFSQa2NVVvhUJnEYsLqKVb5yIruYN+dRmCjgWVZ
	z8ZQXZYNAW6jy0aX+UrwJ2M6Hf0cM6yIC3Q1gkAG5PVDihW9Hxo2AduhgwuaD4SQY91Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHb25-0008Mc-Gs;
	Fri, 16 Oct 2026 06:03:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xHb1s-0008MC-Dw
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 06:02:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D8AgxL6MaGHFTZ0zKakBDJxoFTa1wj8+qZ98HX5jf0c=; b=VFflAMtX5/bO6rmXASaptDbRLI
 0VaIFBogS2jOvnpXr8fHw1nSN5ugSk6bQ57F7BRaku9ZuON6GxZFMRIi8j3h3aVokbPc6DttPG9/Z
 +1sfTjylJJxAH3Mh/AUGCyugd9gvCIS73o9ob07eIu8+A2ZhOwiSX0OHoG4g4FAMYF+g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D8AgxL6MaGHFTZ0zKakBDJxoFTa1wj8+qZ98HX5jf0c=; b=V6unEQIW5wSe4sxFtAuRAkutwU
 lLMwdH757c3dh5VB4IKsjkTO+5b3PBICcw7uFV33nmvzsb2T8tYq2B3A/NkIJ+7C7aVPAuU0s6iLe
 /7bY1ZEPO9Q6bv0RISQX0u5vNWFC4uTf6MK0Y8jqvUaCRgoAkPZdTGNAaqvFCCh8Qyi0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHb1m-00032d-7z for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 06:02:52 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69G62hku032136;
 Fri, 16 Oct 2026 08:02:43 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69G62hIl032135;
 Fri, 16 Oct 2026 08:02:43 +0200 (CEST) (envelope-from gert)
Date: Fri, 16 Oct 2026 08:02:43 +0200 (CEST)
Message-Id: <202610160602.69G62hIl032135@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gert Doering <gert@greenie.muc.de>
X-Patchwork-State: Accepted
In-Reply-To: <20261015200214.32007-1-gert@greenie.muc.de>
References: <20261015200214.32007-1-gert@greenie.muc.de>
X-Headers-End: 1xHb1m-00032d-7z
Subject: [Openvpn-devel] [PATCH applied] Re: repair const mismatch in
 siphash_openssl_available() prototype
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

In retrospective, applying 1999 before 1666 and then not paying enough
attention to the "patch does not want to apply" hunks - one of them was
"just the EOL", and the other was "the EOL, and the code line just before
it"... *sigh*.  Anyway, trivial enough fix, and this one *does* pass a
local make check.

Patch has been applied to the master branch.

commit 50ac5998955c3931a2a241e75a0926bed5e2ebbb
Author: Gert Doering
Date:   Thu Oct 15 22:02:08 2026 +0200

     repair const mismatch in siphash_openssl_available() prototype

     Signed-off-by: Gert Doering <gert@greenie.muc.de>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2000
     Message-Id: <20261015200214.32007-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39907.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
