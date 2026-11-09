Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97A606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KAkW6nhh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Zo9iEg7b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mz/cAlwb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=iND91fArhO8mzDoFPgo0uODw6Ae+vxg8hKCyMqNUEkY=; b=KAkW6nhh9Djf/e
	cpFSd5MEFm5IebVsHX1gVKc5fYa4iKqtt3wDT33QY184mdj1wMy+adQktxIL678W03kuo+Mjw3hn+
	GdoTWNAz4uw8uCsvii3GkV9O//F2ByLOgbCIsdVJzJDRZou1ZpjCnq0Aha8Xnr4s/7vYEvREpE5M5
	yAE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRSO-000000007nm-3ZxV;
	Mon, 09 Nov 2026 15:38:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xQRS6-000000007nQ-434n for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:38:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Io+5hO0aqkOyz4ssnDBOSfEqk/qWIGARIumgqF/ytuA=; b=Z
 o9iEg7bWbQGhhsNrk/YODUyjYmDkSog7MELDXI97fk/9HS5o72sAGTNpwQj6kijT52h2qa5IljCl7
 B7e9W8ZQ/4tb4SWyJPJPXhrURN0Kpmu5fgyqRshyofd4/rQAD9ekXw6o+1RtUI5wL5kIHAQVkan2m
 pu3iJOi3K0/x6Mck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Io+5hO0aqkOyz4ssnDBOSfEqk/qWIGARIumgqF/ytuA=; b=mz/cAlwb+LgbqMz+8hjIhgPcHc
 ue8RsQVhblwsnArC3e9CVwnNtsib+yCmTJs1vjToNfa8g5zEQy8ate2wyVIfyKXoQWmhqxzJktATm
 BgVfOkYRAr7Rr3kX16AWg6oXLzMKrPY2qV2EiPZlv0Ey3tWF4GD0gl1XdEzphoVEPtuM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQRRs-000000001Fq-2NyK for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:38:22 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A9FcD4B023329;
 Mon, 9 Nov 2026 16:38:13 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A9FcDrL023328;
 Mon, 9 Nov 2026 16:38:13 +0100 (CET) (envelope-from gert)
Date: Mon, 9 Nov 2026 16:38:13 +0100 (CET)
Message-Id: <202611091538.6A9FcDrL023328@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261103074747.6269-1-gert@greenie.muc.de>
References: <20261103074747.6269-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xQRRs-000000001Fq-2NyK
Subject: [Openvpn-devel] [PATCH applied] Re: options: remove dangling
 pre_pull_default() declaration
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

An easy one to go "in between" ;-) - since this is really just an orphan
with no effect on code, not tested beyond "BB green" and also no need
to go to 2.7.

Your patch has been applied to the master branch.

commit fa8914210c31ea0dfcde20715cf40f7792412e52
Author: Razvan Cojocaru
Date:   Tue Nov 3 08:47:41 2026 +0100

     options: remove dangling pre_pull_default() declaration

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2100
     Message-Id: <20261103074747.6269-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40549.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
