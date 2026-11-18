Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88213606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Wi4Auc7X;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=R3P8e5kd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NTFXn4s9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fgZbfPFowuArDJKdw0GPdMFRlSc/fHvsN7siYENpye0=; b=Wi4Auc7XgdLRc6
	LYJsgOhQX2nTz4PhHKdmMWgyEULMLI2QwDuV9qNU3D6eIJbAbtD+/cv00R/iDXdk3W9jiGePUhv/Q
	VyPwy33BOhF/JxXiCxcGBz4JfdgeESkI2M9FCwra43peeqS6ISPDaQCkMLLIOfld0lKwoJ5LO8iw4
	l2M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTiMc-0000000052o-3rCs;
	Wed, 18 Nov 2026 16:18:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xTiMb-0000000052e-47sW for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SSdfVcucbB8DIdxDaU2wQVuu+y8C/LeQJG8XCzSeaHQ=; b=R
 3P8e5kdG3Q2Oc8YPG8QSMlplOALojkl4ra2bRnNWXy+Cn39zEnHY4Lvx3msvWcjaTaYDOyzUaxLYy
 mEhVsWVmkzK+cePbClFEIPVXlv8/kFNf58/YbaV0irscawv56U8m+lsJTdL4YbgUYUQjOWzPkl5Va
 HL3x1nrNF4wtjO3s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SSdfVcucbB8DIdxDaU2wQVuu+y8C/LeQJG8XCzSeaHQ=; b=NTFXn4s9GdttUUwdQVq1v0gvye
 tDFWgIBaOJER0biHIczpXlcj8z+32ZQZp30uXy8QWDMyfvgrDoK71tWV0HQT9TrtxJSokAWfOK5uN
 kSBY6J9bijlO88xHpFpb5OKpUG2E8iOvtKd46zVjH/DR7UzxQXlG/5NNMCFv80ZPSR40=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTiMa-000000005fB-0w4B for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:18:25 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AIGIHnl050631;
 Wed, 18 Nov 2026 17:18:17 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AIGIHBY050630;
 Wed, 18 Nov 2026 17:18:17 +0100 (CET) (envelope-from gert)
Date: Wed, 18 Nov 2026 17:18:17 +0100 (CET)
Message-Id: <202611181618.6AIGIHBY050630@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: chesain <cvanteddu1@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261118150332.13954-1-gert@greenie.muc.de>
References: <20261118150332.13954-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTiMa-000000005fB-0w4B
Subject: [Openvpn-devel] [PATCH applied] Re: CONTRIBUTING: add Gerrit option
 + links
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

Thanks.  Documentation updates are always welcome :-)

Your patch has been applied to the release/2.6 branch.

commit 34b4d05091c2a1bd7ad203a0c12e963c01dedddf
Author: chesain
Date:   Wed Nov 18 16:03:27 2026 +0100

     CONTRIBUTING: add Gerrit option + links

     Signed-off-by: chesain <cvanteddu1@gmail.com>
     Acked-by: Yuriy Darnobyt <yura.uddr@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1338
     Message-Id: <20261118150332.13954-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261118150332.13954-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
