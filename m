Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544A5606BD2F
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZOC/W4lN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=axxbCO7o;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Z/8OtRvr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bO6tVG9P0dG6a6wV7VozoQ6GE8qjEnX2YyvJ0dmigdU=; b=ZOC/W4lNuYQ20c
	SSrew3/BIY0xhDNcm+zEAWF3M1kKURkGHhTC3kEg9/PykmMuCna5sPnenwXGJx70o5XqbAxqUAaKr
	P0tZgZjUVwuERFpZtKEUotEh0R1AwhKcamMRvqisQKq3VVdd2dHJIE55X28vr2g0rodoQaQEk1jfz
	+4I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRvKP-000000000L9-0xzJ;
	Fri, 13 Nov 2026 17:44:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRvKN-000000000L3-1kuR for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 17:44:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=R7D5TlDUkLDo/Z2Z+1Zzzwb88d9wm8L3WcLEZq1LcdI=; b=a
 xxbCO7ongtUHCDggr7s81BOhNUMkqA0Q3i7EHSLwqRvtnRrT2S/BROlD0aqJI1o92qY0EGtr/x9V/
 Pzw32y6TrS77Zb0vAcQhuZfghPYjDWBUsYK838hqKvolWaASYhOk9tG3CrR9CBD0tMkNpO9Pi1Myy
 mN74LGqIvDBlcPHA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R7D5TlDUkLDo/Z2Z+1Zzzwb88d9wm8L3WcLEZq1LcdI=; b=Z/8OtRvrctMpYkGv0guq2vOTJr
 /7geXfY7sSeCyshd7CckvK0WfQxFajfSfx6r3JpRRjbaJ39sRkI/LW6UuT0AX4l1gZu9Bxfd4Luog
 UtyKn3yxbinu6VuyzQZgGQRp+vfivcWLgHBxrmP5LprjKTkk1vUhuPY9XngqUWn5IB3w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRvKL-000000002Sm-0zjq for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 17:44:43 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ADHiYSX022940;
 Fri, 13 Nov 2026 18:44:34 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADHiYR5022939;
 Fri, 13 Nov 2026 18:44:34 +0100 (CET) (envelope-from gert)
Date: Fri, 13 Nov 2026 18:44:34 +0100 (CET)
Message-Id: <202611131744.6ADHiYR5022939@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261113104930.25197-1-gert@greenie.muc.de>
References: <20261113104930.25197-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRvKL-000000002Sm-0zjq
Subject: [Openvpn-devel] [PATCH applied] Re: Extract
 tls_pre_decrypt_extract_session_id and pre_decrypt_find_session
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

Now this is clearly "master only" ;-) - and staring at "--color-moved=zebra"
confirms that this is again just moving out stuff from a too-long function
(hopefully we won't have future bugs somewhere in that area...).

Also, passed a t_client/t_server run just fine.

Your patch has been applied to the master branch.

commit 2a6784b2e2ae52b53379945fc5a88fb33a30142d
Author: Arne Schwabe
Date:   Fri Nov 13 11:49:24 2026 +0100

     Extract tls_pre_decrypt_extract_session_id and pre_decrypt_find_session

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2175
     Message-Id: <20261113104930.25197-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41246.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
