Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33148606A33E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Tp5FhCN6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DdBAjgFc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DA1yPv9a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=R4MLpYA4cU81P/IfwrOw910/7tsG8ZiHxKRpOlyl9Y0=; b=Tp5FhCN6W0C5RW
	wLUbs7wi6EFZY0XWMERMmBbGLLRYiO0IQSiDiW6LENELUafYR0qiHe/62phi69JuhuMeb9dr+orj3
	pHHw9JE5G38xByOq+7kpUclrpZ5Yi7F9+UQlJPUN6abd4/K29MCzEjWSgGop9L7DUkiaI6VeZJmX5
	WYM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWW5i-000000000DR-0f76;
	Thu, 26 Nov 2026 09:48:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWW5d-000000000DI-08xa for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:48:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SVRRGNCRsfFwW1XYDWmNwjvOL0Afu0ieybNbFe5qN8U=; b=D
 dBAjgFcFsajEMtuiF68mHyeEsWOqyEkkaImt4PxhusUyXtb4TkKUxWxw7+T7+NLzEjoR9Q54MrQlm
 Vmpp4BAPwZUhZeY/2fmyf7ZUui8N1PWv0TD4lgesrSmqKuGPcZgizswPsNvEYDBcAxErbPUE8hALl
 TUqoHVL/5FJ/yOg4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SVRRGNCRsfFwW1XYDWmNwjvOL0Afu0ieybNbFe5qN8U=; b=DA1yPv9aqSjS5x87P/h7x/DWET
 I8txpYmlz/OvGzEwrGQY0BhH7fuJCmOhRP3/SoDXj1kqtbT6GFj9RHP/0gQ+eeINd3INGvFuM3+et
 Qwy9sGq2oJRq/cyuQALxC6T43DOh4TaPXmcaKLsyyBk+7v4XsUQ1IBTGe1cOJKKZTEkw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWW5Z-000000002hp-2obe for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:48:28 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AQ9mJuU009627;
 Thu, 26 Nov 2026 10:48:19 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQ9mJ5I009626;
 Thu, 26 Nov 2026 10:48:19 +0100 (CET) (envelope-from gert)
Date: Thu, 26 Nov 2026 10:48:19 +0100 (CET)
Message-Id: <202611260948.6AQ9mJ5I009626@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261123143201.4058-1-gert@greenie.muc.de>
References: <20261123143201.4058-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWW5Z-000000002hp-2obe
Subject: [Openvpn-devel] [PATCH applied] Re: comp: drop compression on send
 leftovers
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

Nice find... :-) - BB seems happy enough with the autoconf changes, and
the actual code change passed one of my remaining "use (receive) compression
on the t_client tests" just fine.

Your patch has been applied to the master branch.

commit cd485998d2357c8ce48f7a2302f82176f336510e
Author: Razvan Cojocaru
Date:   Mon Nov 23 15:31:56 2026 +0100

     comp: drop compression on send leftovers

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2328
     Message-Id: <20261123143201.4058-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41831.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
