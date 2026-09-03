Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDF9C624D4
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l+0t4b/H+jKIBVtLue09yCtxePL0NrKWIUHxCFjN60E=; b=NWlPJlCQaPBif9uo77Q9ZRod6j
	1imppVl9TCjXVj+RlN5cUOveubQmenI4nHy/GMI8PxnZZSVxnPFAkqS8J0cl6JY4OhJQNVXC1dZM/
	e+SRqxYekQyuNwLg4X2sFIOV04W4+J+w30SPHc1+WcPruA4WVgqUHEKv/gqSqTcmX3Po=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x21lf-0000Sc-Rp;
	Thu, 03 Sep 2026 07:21:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x21ld-0000SU-Pr
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 07:21:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hJ5BahuUQgaOuFf8ctFV2syo931+jwhEDn97jpCMHX0=; b=M50QoSmsbBEpmQ+hM97iMfRaF7
 22Og8ThyqLo5nHjyxXfGMytv1lo4omd4SgEYSMaJpkvaQKuHXnY9Z4i5l7ojT491D3hCnNB1OjuYw
 JPootqx+kriKHTdJHkPuwXw9W+ogmYIsS7rwXWKJKw8izjDneLjMlktvx8uBbexK/c00=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hJ5BahuUQgaOuFf8ctFV2syo931+jwhEDn97jpCMHX0=; b=WCvedim4XcI35Iy/pMyB/ZIAyB
 huQW5qjgPImVavnT/qN9K6+KgLPzoF0XGqxV/yDvEQJvfnV/7YWZMn99u+LyS9M3CB4unvp0I+Azn
 ZNJMxtJbUjCE2/2YHAHLskoKaojNx+4UgdbKvacHRb7hITi+U4YWnpe5M/xRDF2NYD0w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x21lY-0004bz-PK for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 07:21:47 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6837LcfK037965;
 Thu, 3 Sep 2026 09:21:38 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6837LcDu037964;
 Thu, 3 Sep 2026 09:21:38 +0200 (CEST) (envelope-from gert)
Date: Thu, 3 Sep 2026 09:21:38 +0200 (CEST)
Message-Id: <202609030721.6837LcDu037964@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260903061209.12599-1-gert@greenie.muc.de>
References: <20260903061209.12599-1-gert@greenie.muc.de>
X-Headers-End: 1x21lY-0004bz-PK
Subject: [Openvpn-devel] [PATCH applied] Re: Move check_session_buf_not_used
 method into the method that free the buffer
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

This was originally developed in the private GH repo, and got approval
from MaxF in there.  I have stared-at-this, and ran the t_server tests
on it, an can confirm that it does not break anything - and I have
confirmation from the last reporter (Andres Berbescu) that it fixes the
last remaining issue here.

Your patch has been applied to the master, release/2.7 and release/2.6
branches, the latter with some (trivial) conflicts due to whitespace and
"const" changes.  Theoretically this issue is also part of 2.5, but the
codebase is different enough that I did not want to go there today.

commit 2a881d737b2562ee28247148160cfb60f0ba4645 (master)
commit c52f940196444668284eb06ec0cf08a8bc3cd36b (release/2.7)
commit 7dae631514b331485505470bbb8bcc67fb881d8f (release/2.6)
Author: Arne Schwabe
Date:   Thu Sep 3 08:12:02 2026 +0200

     Move check_session_buf_not_used method into the method that free the buffer

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1893
     Acked-by: MaxF <max@max-fillinger.net>
     Message-Id: <20260903061209.12599-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38913.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
