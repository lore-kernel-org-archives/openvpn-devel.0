Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C02F606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nxfu907P;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=doI+xtjI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=COSK5Adx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gZuF5WQXhQudCJwlAl8MbCckxu1ykrI6BjTsKVPxINc=; b=Nxfu907PIDGVaP
	DxAbvaTMo7Z+8HKBKniwKt9g179zyuUkJ8+9STfzPGlA6jpWYSbw3OWeWaRfqIOrZ+a1Kon1ZI3dX
	GEPyaPx50P+6Vi2Uqvebe5EwxicBt+tgYLjLptGhxlVNm39niNV+d28Eex74mMYIi+w3bpJXocQoU
	I6g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0ht-00000000119-2zlu;
	Mon, 16 Nov 2026 17:41:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xT0hs-0000000010y-3L03 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:41:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=G2NdYe8dX2Mf5o4IN7ofugNAs/Aa/a6qomb/9zaOf84=; b=d
 oI+xtjIJZvvWoUD2sdcDtNhcNutUxRhTdZTPlZzskFmBLC5xrMwhhF+svhO4xTCfGsbViw5yQXKoo
 wqK/OUL5N/IxFYzmj8ycbOg5n041hRZAdUj3z6m5KKCa2cVewGy817GOurglTmMpmbouO4gHdKjkz
 UI4zVuDoNuiEftno=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G2NdYe8dX2Mf5o4IN7ofugNAs/Aa/a6qomb/9zaOf84=; b=COSK5AdxNiyvht/qjYPSD8VLLi
 xUNGSj34vZ+iW1FsNefk4osju6sPBDL/vEenMoRgY9nMWRxjFkVB2/271HpKel37ypIpZIieK1HM/
 S8/Nz1W7x7jCFLirnxO7xdSWxt9Lm9nWDIA+VWhSQ3BOHZIAc+KxEL6FlT9+ksYYCCzg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xT0hp-000000002Iv-3ihn for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:41:28 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AGHfCWd082733;
 Mon, 16 Nov 2026 18:41:12 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGHfC7f082732;
 Mon, 16 Nov 2026 18:41:12 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 18:41:12 +0100 (CET)
Message-Id: <202611161741.6AGHfC7f082732@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261116120513.24130-1-gert@greenie.muc.de>
References: <20261116120513.24130-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xT0hp-000000002Iv-3ihn
Subject: [Openvpn-devel] [PATCH applied] Re: networking_sitnl: Reduce
 boilerplate code for parameter checks
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

Now even cppcheck is happy... :-) - I did a fairly thorough stare-at-code
for v2, and then couldn't merge... - v3 just fixes the "nested ret"
in sitnl_route_set() plus a rebase.  So, BB happy, code still good, in
it goes.

Your patch has been applied to the master branch.

commit a64c40032ade56ed7d6b1f650db7dd04f53ac2f1
Author: Frank Lichtenheld
Date:   Mon Nov 16 13:05:08 2026 +0100

     networking_sitnl: Reduce boilerplate code for parameter checks

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2177
     Message-Id: <20261116120513.24130-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41423.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
