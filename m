Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691DCC79FB6
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0z4hcAVKiNCUua9kanEhuDhHkpDe38l8n/BO/cb4bgY=; b=Umnr4Pr2c2FbT/1cBkR/TQmBes
	08hn55TOXWxngwsFCFWmj7RBQ9nOtqa0VlGZQddzLdWwMMXjKOjba7UE8+BsGzty0BIgGjbWJkkFs
	m10KFySATf2TpxneiSAB95Z6KGMOcSLmNWdrlkCI1fv6iv2lsTjYB4BtVIcBFDaoi+hk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5NSx-0000Ww-45;
	Sat, 12 Sep 2026 13:08:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x5NSw-0000Wo-1H
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 13:08:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d0a44Wtlh50o+WSKqWx3tn/A52L5uKcQebf1uhYF4dE=; b=KWiYyzPVg0FILwS6De5sfVMA+L
 qhzVkvVZPQpX4bkEo1MFNHaEcJr03rbbJ3/AZhyrwhJR4eXifaFel82+96kLnuWGFPY3NcjZjXtwV
 EEHBU3TwveNUVIqDYjmdfxFlLL7IC8x6i+JFcQ30DmIz5O/echsseUQX91+jlS3br7dw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d0a44Wtlh50o+WSKqWx3tn/A52L5uKcQebf1uhYF4dE=; b=c38uQOofLOAa8eKZ1Z+aiIvcXs
 pVEMw9Ubb1EwFa6u66neP5xtQs6mpz5LTyg9XljteztJ/RdyUW068hv5JaXUyD58Gbbxir4KNCImg
 GCFgj3FHiCWcGZq4HxD6JNj+0oj+yW9nwaHYZpNT/6XC26w0Cla9NgSncCn7x9VyiPtg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5NSt-0000lC-U7 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 13:08:21 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68CD84sg048636;
 Sat, 12 Sep 2026 15:08:04 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68CD83YX048635;
 Sat, 12 Sep 2026 15:08:03 +0200 (CEST) (envelope-from gert)
Date: Sat, 12 Sep 2026 15:08:03 +0200 (CEST)
Message-Id: <202609121308.68CD83YX048635@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260911204513.15692-1-gert@greenie.muc.de>
References: <20260911204513.15692-1-gert@greenie.muc.de>
X-Headers-End: 1x5NSt-0000lC-U7
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: When extracting
 pointers from buffer, retain const
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

Quite a massive patch, but all the individual changes are small and
easy to grok...  BB and the t_server test bed say everything still works
fine.

Your patch has been applied to the master branch.

commit e031978fd3e33b8f4b4e82d211c070b583e12b56
Author: Frank Lichtenheld
Date:   Fri Sep 11 22:45:07 2026 +0200

     buffer: When extracting pointers from buffer, retain const

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1904
     Message-Id: <20260911204513.15692-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39108.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
