Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84508606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 25 Oct 2026 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NWEkEVmN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HlgEkoRe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UVYcqNwS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YjzbtWCy6X7km+gYjbE6I/u6lGi7smy5Z0VIdYPrfRk=; b=NWEkEVmNkW8+9d
	lAFqA54aDLD6fmpORSTW25flTClWX8R1kYaoZ3uRcwA4DLG/6hUSPykYYQUzIS65b8uqWtI1hVTDL
	xsKyJT/i0Js+kOi/75jY+6jsXhLAHuF9jO7tF+4H6S01AZEKqlQYF4kwSunuxYQSWytwptk6UGgQo
	s6E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xL3Dr-000000005p8-34FQ;
	Sun, 25 Oct 2026 18:45:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xL3Dq-000000005p2-2Gmg for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:45:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Kl65kpcKNGHRdg1lp5e8GbJfpfHTvv5rvzDqI4jXbno=; b=H
 lgEkoReEMWWvb/nWnj8gTLYtdCHu5j5xP0e+I9o4vk3BXpdWJZa3zZchN/8P+TYuIgGtzQgS2bWzD
 aAWcf6V/+cZynmwJ8HQfvxNGmrOcSGiA9MYIx+2Ruww/h9bQ4idXh2ekJFvU9tOAPt/uZSj51bOtx
 zFdk+pQnjZ5sviGk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kl65kpcKNGHRdg1lp5e8GbJfpfHTvv5rvzDqI4jXbno=; b=UVYcqNwSIrmVIAOzj1jpeA+gLR
 dS7HEVvZpaiTZkcvj0nyQGHpkfKEiXTCCB/PU9GAVA3LMady/VHfCm7vcH8RUwIItUy6DKYmGkB0i
 PzqL56bwJYod8eOTo/Y/OKQC+vFiFQS4MO0u6frD9iHFP5bNss9NfSFPwNXauSGyDZF0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xL3Dp-000000000Db-1uNo for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:45:34 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69PIjQ3M042255;
 Sun, 25 Oct 2026 19:45:26 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69PIjQu5042254;
 Sun, 25 Oct 2026 19:45:26 +0100 (CET) (envelope-from gert)
Date: Sun, 25 Oct 2026 19:45:26 +0100 (CET)
Message-Id: <202610251845.69PIjQu5042254@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261022170411.20830-1-gert@greenie.muc.de>
References: <20261022170411.20830-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xL3Dp-000000000Db-1uNo
Subject: [Openvpn-devel] [PATCH applied] Re: Make run-cppcheck.sh run on
 FreeBSD and macOS
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I would prefer to not rely on bashisms, but the script being what it is,
it makes sense to make it at least work wherever developers might need it.

Have not tested it (but since it is not affecting OpenVPN directly, the
need isn't as strong)

Your patch has been applied to the master branch.

commit ccd058e75be6af15c8a2427acb76be3a7a641213
Author: Arne Schwabe
Date:   Thu Oct 22 19:04:05 2026 +0200

     Make run-cppcheck.sh run on FreeBSD and macOS

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2018
     Message-Id: <20261022170411.20830-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40103.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
