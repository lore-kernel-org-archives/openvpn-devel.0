Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DC606A31C
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hsSG7WEH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BW56n2KJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AVHkBeOU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=clnIQ3D34vepsGRp8EJE0P8mdepW1hzyS84/w2lY8Fk=; b=hsSG7WEHd8mUoP
	Ee7lHhMoZDphzLBnMbCiqZcOusFV2sNwAjUvNy5QP5a6odEcN0ZUTjCmrK4a0OfuEU9QNsQBOogxF
	eNkPH8wkhfnnJDRse0Q4jBPt6tL3355L8aAwOa1SqsniEHOMvzzneu9vqTYAJ3GgiR6kPNv7jzeoi
	tNo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ2mE-000000001un-26MY;
	Sun, 08 Nov 2026 13:17:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xQ2mD-000000001ug-09jB for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 13:17:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yOsvUUM3g/IS/4iZYMQTfeXBnq07WXNMo1sUlpxflXI=; b=B
 W56n2KJmb9D1wxyz7GAm+8jIGZUZaUIz368+MdcJ7ubWyHq1bnvKbKkrsB4fXOZ8Mz/kSrIlCg47S
 01tmGM2e1URnkC3o0G4Z3xSdBPff0ZjvawZVhjh9v1fEO6kaVYQUKqcoA53JLqksZcskK9zZCIyZU
 JRM8LfHnRpHbacmk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yOsvUUM3g/IS/4iZYMQTfeXBnq07WXNMo1sUlpxflXI=; b=AVHkBeOUvoWV9iCEObnfs1a6wH
 yzXlllnu+ADEfEXQZ9o2Mrjw/jj820iW/FMl0yQ+zH9GE845doEdcAhTEFE63XWpIIFHwjD0kdDmM
 eO83RMiicfg2OsoejLDtzWuzRg1gL2cgVkhsDnFzheePHHK51kDIXB7yXnavtQcZtPJM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQ2mB-000000008F8-0ilH for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 13:17:40 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A8DHVjV081820;
 Sun, 8 Nov 2026 14:17:31 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A8DHUdv081819;
 Sun, 8 Nov 2026 14:17:30 +0100 (CET) (envelope-from gert)
Date: Sun, 8 Nov 2026 14:17:30 +0100 (CET)
Message-Id: <202611081317.6A8DHUdv081819@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261106125757.14721-1-gert@greenie.muc.de>
References: <20261106125757.14721-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xQ2mB-000000008F8-0ilH
Subject: [Openvpn-devel] [PATCH applied] Re: comp: use the wire byte when
 escaping v2 uncompressed packets
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

Interesting that this did not lead to more complaints - for the fun of
it, I asked Gemini for "vendors with MACs that start with 0x50", and
lo and behold... Apple has a few blocks even... but anyway, good catch!

A look in the code (compstub.c) confirms that everything which is
not "...UNCOMPRESSED_BYTE" will lead to an error message + drop.

Haven't actively tested... but should be easy enough with --lladdr
and comp-stub-v2.

Your patch has been applied to the master and release/2.7 branch (BUG!).

commit ebc370a5a232aff244c9d2d1f8497c665e6bd853 (master)
commit 26e482379d3ec22fa0e69d3f0a329a2aa3d87e8d (release/2.7)
Author: Razvan Cojocaru
Date:   Fri Nov 6 13:57:50 2026 +0100

     comp: use the wire byte when escaping v2 uncompressed packets

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2142
     Message-Id: <20261106125757.14721-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40883.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
