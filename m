Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD294606A32E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TAokMwcW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PPy2doyZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=if0Bwexk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZgOT5rn7LF5xEcOlUSQHCVc1DvcvUa/sv6/yoFxEqlg=; b=TAokMwcWxJY2xc
	sZRqYMgKGqlsfjWV/TZiGwOlWz96klA/707RR1TwgmBIqvm9IZigirpH/0k3d1E08sFBHwH2h+bxn
	3O+zB38Zmp0yfGT73q0XXKW4eSNJoJ6NCAf+tLtcDysQ7/pz0LB/Jfzr0KXylc+TmitnseYV2zRJN
	KAw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVopq-000000003Uo-3Xd2;
	Tue, 24 Nov 2026 11:37:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVopp-000000003Uc-1vVG for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:37:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=blxjOrz10RGeTOkHVoXyAwRRj0OF4Xnw5u462+sNG6k=; b=P
 Py2doyZylEBIMouRqeFV0zGows5/QqWXg742h6naj0Mtyhd7htIen4iRdzLIDEwgj3r2V1MipMo+C
 ufzBLpLikLE/X3Flnx4M/BJgCuoNzNc7baRnBN/RGzmij8JFwDa+JtCxQlJW4tb2ALgt7k6oGFtV3
 M7jRt0V+IIrmWJow=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=blxjOrz10RGeTOkHVoXyAwRRj0OF4Xnw5u462+sNG6k=; b=if0BwexkgC1g6kea7j05gdP5p3
 yAaBtwysu+ck3OQPYpVmMjqFvdARV2lhMMfEg+O3zs6vL70yuLdjCmETljqXVdKh9VY2UjL8h2fw0
 n0mw23Jmn0UbB0t2e8JUO6UroJbh16MnI6KRbd693Tairrhup009NRt8ezn9QINmkS24=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVopn-000000008J2-1r26 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:37:17 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AOBb8iE021062;
 Tue, 24 Nov 2026 12:37:08 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOBb77l021061;
 Tue, 24 Nov 2026 12:37:07 +0100 (CET) (envelope-from gert)
Date: Tue, 24 Nov 2026 12:37:07 +0100 (CET)
Message-Id: <202611241137.6AOBb77l021061@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261123140843.1436-1-gert@greenie.muc.de>
References: <20261123140843.1436-1-gert@greenie.muc.de>
X-Spam-Score: 2.7 (++)
X-Headers-End: 1xVopn-000000008J2-1r26
Subject: [Openvpn-devel] [PATCH applied] Re: socket_util: check the address
 family in addr_match() and addr_port_match()
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

As discussed on IRC - we're not sure if this can actually be reached, and
how, but there is no risk of heap overread here because both sides are
openvpn_sockaddr, so big enough.  It's still not code that feels safe,
so the extra check is good.

Since it's not an actual bug, just "hardening and improving the code",
not applied to 2.7 (for now).

Your patch has been applied to the master branch.

commit d170885f8c278c142c1cd0cd47ee97c3e236bc36
Author: Razvan Cojocaru
Date:   Mon Nov 23 15:08:37 2026 +0100

     socket_util: check the address family in addr_match() and addr_port_match()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2327
     Message-Id: <20261123140843.1436-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41832.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
