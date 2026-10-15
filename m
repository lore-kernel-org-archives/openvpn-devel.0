Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F675CC6B3A
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IsP7FIU8svX2QqQANfMpUcyjXyyoYEAEmZYwQHbWwX0=; b=FcmeJVWUtZ9YHQ9/MeuYgOym+Q
	XgA5E+zGu4rhNm7xcIBo4wvbnUA/lRC9Ap599FoTTGPHRHB5LiW7ozdFZuduyiN9ZuMWQ2g5Xm06u
	E/fpHD5hA25exqp2ZtiPP3yadKEtwWuyRBYWdXSpg/+icIZyEm6Mq/9mOiD6lLRAEQo4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHNNE-0002UM-ED;
	Thu, 15 Oct 2026 15:28:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xHNNC-0002U6-Uz
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:28:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iTt+NXUH7alVYV0qG7d8acEFSV02bJ4cQ9gGCMoSS5g=; b=Zg38mWxNdifbHYW8blkKHBcYOD
 p+/naHdqxyA/TaDdwBdW0CBHI5GZkuhFSyvyHhCP4CZUXaEmGLrNt7ATgxt0ebAaVjFe9VP//1YUa
 LQhCdbOCLW4CE1hMzGWSlzmmE3Ap0elOXsnvVPHX1Nvh0nsPOJ1VFV3tre7lrwmFh1mw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iTt+NXUH7alVYV0qG7d8acEFSV02bJ4cQ9gGCMoSS5g=; b=efRi03un7e+zF3MUOnFGXEW/Zr
 U2qtyH+hb4NlSRmYK9rnKSa0tWqtr0k611LgPel8gCYga9HHk8nD3dbtDu9NkZYIKLeJyYCLVBs+3
 AY0cHMjSzAJstnTU5RAjLYEBaheRwhEcpVl7mlOec7//K+t65+8nYHLLGl96Ol8m7E4E=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHNN8-00021r-KA for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:28:00 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69FFRgGI000914;
 Thu, 15 Oct 2026 17:27:42 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69FFRgIJ000913
 for djpig-1663-cpp-constPP-v32.reply; Thu, 15 Oct 2026 17:27:42 +0200 (CEST)
 (envelope-from gert)
Date: Thu, 15 Oct 2026 17:27:42 +0200 (CEST)
Message-Id: <202610151527.69FFRgIJ000913@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261007170649.21520-1-gert@greenie.muc.de>
References: <20261007170649.21520-1-gert@greenie.muc.de>
X-Headers-End: 1xHNN8-00021r-KA
Subject: [Openvpn-devel] [PATCH applied] Re: Remove instances of
 constParameterPointer cppcheck warnings
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

This is quite a bit to digest... - but if cppcheck & buildbot & Razvan
agree on it... :-)

Your patch has been applied to the master branch.

commit bef948622442388b78d3f2fb952d63a010a0fe2c
Author: Frank Lichtenheld
Date:   Wed Oct 7 19:00:39 2026 +0200

     Remove instances of constParameterPointer cppcheck warnings

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1663
     Message-Id: <20261007170649.21520-1-gert@greenie.muc.de>
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
