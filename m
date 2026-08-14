Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069A7C5B572
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bIx4r/d9ozwfBTTvjKHrURqzK5Hbz+Ljw8h/PZkR9rg=; b=d3pL3Z/OQD86pIMFSBFW9ZeBHE
	dKw1lg8Q0NZfSXpW1DqkjhA4HPpGYmpey/gKVyLb7MRg9Ju2yRmkx0HR6jTCrVSPwdcHrg0QGVIil
	o8lTFKNYbr1Wf14wbSwiDEw4XwXhDDxd7K7NW+YPFJMYJyBKmBvzsVvU3d9op6mWuedc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wupYZ-0003ty-Ci;
	Fri, 14 Aug 2026 10:54:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wupYW-0003tn-0S
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:54:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r44Bq54tNFtZ7gyjfHfnQ5V5I6Oa8aNiTnjWgO98nLM=; b=Pc7j6QBItgrd16QDFVvIbi5Qsv
 gyb/ItsSHysXE9rgjqwA8lwoC0aMuouAXKD2X9ex+sqCgBCcGRKivdiQILP0gE2hs/t+GpymYLGVx
 QWAcTyHBenNHMw3CoIjCpBtEdH2Fy7T22BhDa+ZfrG/tz5W6UraPLC8dmZzWOXTTSSU0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r44Bq54tNFtZ7gyjfHfnQ5V5I6Oa8aNiTnjWgO98nLM=; b=kPEspPTY8qnk3Z+7JCJDpWg3uL
 3uJbsQzkuS7UHTwYq6XgnXTM+VH+uT2/Kv1y39M+o+aEFCgcDTd5IYOe2RfJ2KliwibNsjnIwFk25
 /z9ra/D3XddlzJq24TzvKQt9Jc6/HLyf4vQIXGeOA12unXK0wSP71UTivaP5EwfoMGTI=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wupYV-0002Kl-2R for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:54:32 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hLzcw3ZpbzKry1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 12:54:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1786704864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r44Bq54tNFtZ7gyjfHfnQ5V5I6Oa8aNiTnjWgO98nLM=;
 b=1A0vJQowRgN6CawHZwT5A9a8+i/URH3n0LwSKsy9x72wkQXW95HXB4PREK7b+eqPvf2CDa
 4SKYEJhm/zDHLYvjl3aigC34bXezycEsR6O+N3FBSTWW5dq2FheCX6097Kx0OO4FoZ3KwW
 Uz+8fvAOw9RVQkBASHLaxzjwP+wGIAkcO4GlHAsJjbnWW5Rb34jzdi1gyShHi1cZq7zlGE
 +CF5LIeK1rCkoxAcnfcFC4Gl5qQy7TaSn3Jm7oNfHp5etHaEj/PKLUdJM5In/ttpVKdnyx
 wxlZlJUmRYFw7NCIvEGCV43XDkalb8/SlSHpixcw6j2UTedKDuaWMpd1NPhmFA==
Date: Fri, 14 Aug 2026 12:54:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1786704863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r44Bq54tNFtZ7gyjfHfnQ5V5I6Oa8aNiTnjWgO98nLM=;
 b=EmZR2HN19LUlWoBx9RApzQitOyrzPpo9v56bAJqOi/sUlt9e1WOy6LJt1wzz+i7ptEKFZh
 GjqBxr/EUud0ovcfGpiAYOtRSO2MhMHTAOeRqY6w59ADmxZkKXe0kUW9ZXxE9jv1rJty5z
 JN9mKcbo323ZO9IKWxtHKO5l9HDaZ6NJE/q2RHVY4qy77cMju+boHKyw4D91L3kIc9e0Vn
 vW0CAToO6SoKeT8k/ONkQJ1AyjeS0pF9eiPhTgewyN81e4J0DZSp8Lz0DzvbKM2gxbnlyB
 GCTSNXOV2VCRsCR6yyVeE00zJjIILJPNt7dChCh4R7sNjezUPNUV6T/C8YZcWA==
From: Frank Lichtenheld <frank@lichtenheld.com>
To: Razvan Cojocaru <razvanc@mailbox.org>
Message-ID: <an7z28A5nNFudWDR@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
References: <20260812140515.107442-1-razvanc@mailbox.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260812140515.107442-1-razvanc@mailbox.org>
X-Headers-End: 1wupYV-0002Kl-2R
Subject: Re: [Openvpn-devel] [PATCH] buffer.h: Fix buf_substring_len()
 documentation
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

On Wed, Aug 12, 2026 at 05:05:15PM +0300, Razvan Cojocaru via Openvpn-devel wrote:
> The documentation added in 21ef7fa8 described neither the return value
> nor the not-found case correctly: the count includes the delimiter, and
> a missing delimiter yields -1 rather than the buffer length.

Acked-by: Frank Lichtenheld <frank@lichtenheld.com>

Hrm, not sure how I ended up with this.

Thanks,
-- 
  Frank Lichtenheld


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
