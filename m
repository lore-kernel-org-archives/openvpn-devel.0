Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ABE606A31D
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cCalpUHw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=J3GIrwb9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IMntrtzz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9CC22zYzbIlMVASw2lG0IzQel/aQhlo8LTa40UPh4mw=; b=cCalpUHw6hdAPX
	0DLEPKtoV6wZMngfer9TQqwb4fhs+UPxSPlSRK2DvLVInpzVob7QCDgsgm7CF6cyeGlGXo4SYup06
	f0K+uHoQv8UivJLvP8WGkwEZ0snKyruUw4AG3iENmukSVsKV5HaxCfSRBQqYqXjO1ROg8cYbSuGyS
	yts=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrSt-000000006s2-1o8L;
	Fri, 30 Oct 2026 18:36:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xMrSq-000000006rv-2pvA for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:36:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=amwxCVD9Qvsuh/5l2LgBmVgXYvqJLQx4uKEtTG53Po4=; b=J
 3GIrwb9tsSSs5MWPBHQWfzVmOtn09t7AEC/368XoBkfc5areqPssFNhUFQQQ2XI0RKncNVXhA8PZk
 HeNJdDCpMpwuVw1KNvIdK9Ic3fHS7CPFkI0Dr2dd7fZpsJnKLzf+VCI9wgv4Zns4h7azj4fJk/liv
 3qEaIBKooCIxJ8MM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=amwxCVD9Qvsuh/5l2LgBmVgXYvqJLQx4uKEtTG53Po4=; b=IMntrtzzdHRJxh+P9IQTfqSLRf
 4Ra43re8WAsniMwateEQwL9rDjrqikEk/7X9lISgP/Vi4gpcl7WrMYtDyLDPvDt6dYmgc0OEPAXw6
 M0C47lewHRqhjxX7D/cFCALat24lv/bPw1mQNAK7w3NlRA4x6N7w3QR/OMvFbNoCfF6Q=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMrSp-000000001F0-2LgI for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:36:32 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69UIaOK6050485;
 Fri, 30 Oct 2026 19:36:24 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69UIaOjj050484;
 Fri, 30 Oct 2026 19:36:24 +0100 (CET) (envelope-from gert)
Date: Fri, 30 Oct 2026 19:36:24 +0100 (CET)
Message-Id: <202610301836.69UIaOjj050484@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261027124408.526-1-gert@greenie.muc.de>
References: <20261027124408.526-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xMrSp-000000001F0-2LgI
Subject: [Openvpn-devel] [PATCH applied] Re: multi_io: drop the read cases
 from multi_io_wait_lite()
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

This is actually a real change, not just moving stuff around - but then,
it's not real real change, it just removes code that is never reached...

Stared at this for a bit (and tried to follow reverse code paths...),
and BB is all green...

Your patch has been applied to the master branch.

commit 2f76edfe75953313a1af503ae85c68409ec840e5
Author: Gianmarco De Gregori
Date:   Tue Oct 27 13:44:02 2026 +0100

     multi_io: drop the read cases from multi_io_wait_lite()

     Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2044
     Message-Id: <20261027124408.526-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40196.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
