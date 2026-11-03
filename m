Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E222606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=G86D4r9I;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fB57xnkw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hsayTtPS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XOoaq+sTl4ftQNKQzF/OsK9xTc8N/Fjm67qKRmmNaGo=; b=G86D4r9ImXyWZP
	UxAk4pUhqQJ24v01aDvqk2B8yD53M9+gIv8gN9319+HeWvqSd/h/Nf1J4hiEOj6N2z35tiKMjiWeC
	2GYVbrE5phPeI+l2Wh/q2n/fxEBHNA7DYgNd55QlgEOWyA167QnXVHTWI7piydZfpFEPeltNajL+j
	Hf0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOHYA-000000001LP-466n;
	Tue, 03 Nov 2026 16:39:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOHYA-000000001LF-0vYX for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:39:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dEoYn6XQS0reZbUMnaB0sIbKZsm9duGnPK7LrKf8Pjg=; b=f
 B57xnkwHfqYM7fiVbga6g5uRfO0aDbP2KCA2/exW5LWjaDQEUAk6rnIOP3JCUdwFxFRSd7aTGW1WB
 AS+7xKk2T7Hx0z4p+oaqZ1vrIKItG/sK/Qo7DomCiw9RmgegYpwH4YStBsB9gO1kTB4OEqwcAl5RS
 5Z0UJ/ubbuKvJepE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dEoYn6XQS0reZbUMnaB0sIbKZsm9duGnPK7LrKf8Pjg=; b=hsayTtPS0nlYQN4AQFtZqlm3Kd
 BiGO5XYWQqf45eqPBrnVNGZLwt5TgOLMKVZLhdBLB0vZcSXVYpEwew/yz8/Gm5cUtTX76i+gs0F/R
 tnbSUPMFP6kq8vmRAedqq3ThQJmjM5O7ZMg4suyowJBX0P2HJtF9sOTgGSJd2xA+Oip8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOHY9-000000008Re-1S3s for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:39:54 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3GdkHU049574;
 Tue, 3 Nov 2026 17:39:46 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3GdktI049573;
 Tue, 3 Nov 2026 17:39:46 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 17:39:46 +0100 (CET)
Message-Id: <202611031639.6A3GdktI049573@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102141709.30018-1-gert@greenie.muc.de>
References: <20261102141709.30018-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOHY9-000000008Re-1S3s
Subject: [Openvpn-devel] [PATCH applied] Re: Use ASN1_STRING_get_length
 instead of ASN1_STRING_length
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

The wonders of OpenSSL API improvements... (I guess there is really good
reasons, striving to make the API overall consistent and nice, but the
path there is full of thorns...)

I have no 4.1 test env right now, and if I'm not mistaken, none of our
buildbots or GHA tests has - but we'll notice if it breaks on 4.1 - on
the older versions, including LibreSSL, the compat define works nicely.

The "master" version was BB tested, the "release/2.7" backport via GHA.

Have amended the commit message a bit ("and add a compat macro").

Your patch has been applied to the master and release/2.7 branch
("long term SSL library support").

commit 238274cb2139615379fe8300462b38c8ce096d07 (master)
commit efe6bde595e8a3194fe5bf98f549609a672dc081 (release/2.7)
Author: Arne Schwabe
Date:   Mon Nov 2 15:17:04 2026 +0100

     Use ASN1_STRING_get_length instead of ASN1_STRING_length

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2087
     Message-Id: <20261102141709.30018-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40439.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
