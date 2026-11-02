Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCEA606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XJQdtpzB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VOjpYCtL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=moSsiRch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=b1/DCjbK7Z3dFdn/Rk7x0QyHR76Wt0IZqJ+fis5QOEE=; b=XJQdtpzBBvWnGu
	fk1sQ+JnXILYKBkURHXQ40z0L5UFo77WzbPdq3aAYNpn1bkriiO2e5GoBV8Kqk2A8pwxe5C3i1le6
	EKTQ/3i2/bKltFU/cJXNmnKrmLMadl17xRkXldRFMXRAXWf+gbEhARVfZ1FAXfSgTcRS4DQHjI54F
	LUM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNwZ8-000000004zU-18eh;
	Mon, 02 Nov 2026 18:15:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNwZ7-000000004zM-045m for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 18:15:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AmUCmHxcPQv7qR0rFsxhTt0QVPxb9wzaucMRLYmYtRQ=; b=V
 OjpYCtLHJFYODp0/UbOIPBTxP72JWlXbNnDenqVug3+q9kTB9WErPkIMUo8toIbfHjnmHA9U6lSpW
 y6zPzI3ZyDqS1HeV33opwUERgpdGS3h55jBBCq1zPz7SDepnNB+jjRAxWYOB/mv7BYI8Ro4Vb0VT7
 iSMBXW0iKWQvI3tc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AmUCmHxcPQv7qR0rFsxhTt0QVPxb9wzaucMRLYmYtRQ=; b=moSsiRchK0GTlXV7ILJRSTTh2g
 f4PF4uUOUT787e4Z69oRLz7poUT/uXHFszdPXzxpB43nyZSl1zUR7Vj8jPqDYP05e95CHt03+Sa0F
 KkXJ1V8NyGSsngdmr2Si9LmwpCS/XOUhcVYg43s+NtaudCTdw5cwUlq0ujV83UI60OJc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNwZ3-000000008RH-3ck3 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 18:15:28 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A2IFJrM068846;
 Mon, 2 Nov 2026 19:15:19 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2IFJ4c068845;
 Mon, 2 Nov 2026 19:15:19 +0100 (CET) (envelope-from gert)
Date: Mon, 2 Nov 2026 19:15:19 +0100 (CET)
Message-Id: <202611021815.6A2IFJ4c068845@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102144844.910-1-gert@greenie.muc.de>
References: <20261102144844.910-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNwZ3-000000008RH-3ck3
Subject: [Openvpn-devel] [PATCH applied] Re: tun: free gc arena in
 windows_set_mtu()
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

Minor leak, but still not what we want :-) - and now it's even faster,
and more efficient!!

mail-archive.org seems to suggest I have used up my daily quota of
patches to send, so linking to Lore.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 97933ad9161fac59e4b738b226ad317ff23a3659 (master)
commit 55df1450adaa45321fc88e245df0fac6884eced0 (release/2.7)
Author: Razvan Cojocaru
Date:   Mon Nov 2 15:48:38 2026 +0100

     tun: free gc arena in windows_set_mtu()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2092
     Message-Id: <20261102144844.910-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261102144844.910-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
