Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3E5CCF2C1
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w8stby5HNBfuoDWMeUIjUFB337KjDeICQ4ZBUTPeVwk=; b=Xka3GFkiqBBnm2QU4JgX39fjJR
	MDlCwNb+J/PWtSpI8iiLmHuLLfAtJhuVevwTbdkQGyRtHDzNWzVqe6XmdczgfTjXYTteWPNByHXjt
	iWzHJGuArh41yMdPkPCXgpNGjl/XZdurf7NpS4obnh9qOhCUC7JiKk9oTcdUnY5YXFt8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI7Rt-0001LT-C5;
	Sat, 17 Oct 2026 16:39:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1xI7Rr-0001LI-DO
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:39:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TqscyUY0/Sv0g+5Ny7w+IXfFZx3AHtX5OmSIBTKHbto=; b=DAp6NhPxrRWBT7dwI1g0TH9ESR
 n7DJnaO4buCrFKNNiz3Kuu2wdcKncFzBdUzR+6Qw3vEj/7iEohVdT+qlcsxmzhq+b0VARqpimYqaf
 0/OUpgQ17H/9OdF5FqB9vNBagG4RS3o5sKx4zubxSlcIs/6C8JEy1jSwRw45fOMSlwz0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TqscyUY0/Sv0g+5Ny7w+IXfFZx3AHtX5OmSIBTKHbto=; b=G6w5SfRhSIoYo8pLPnzY1R6fNQ
 b+MqC4xoQxncs4KCkI1Ta/ICFr4soIX/RfiFSMEow/PjzR6jNjkM8SoDmm+mZwpfFN89PwXLtWs4F
 TSTJGW9Mc9vEMD7gQjDdM1ionZnWbEp+0FPcq3J8zsRnV3Uw77rM6HUdP/Clb5L/VUg4=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xI7Rr-0005xi-DJ for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:39:56 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j6SFt48ywzKnTX;
 Sat, 17 Oct 2026 18:39:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1792255186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TqscyUY0/Sv0g+5Ny7w+IXfFZx3AHtX5OmSIBTKHbto=;
 b=YkcsNCkNidK2cA8dofb6rBHNHfhNNzdpYfY41DuhBIQG8N337EvLXK/+48TkgEf0FlRTLt
 iz7sNDo4WdsqwJNdK5UlQpEwFBQfpMFRXu32Prm0fh7lLhc2YmpQCIoVADmFp5IUpjZ8Vm
 hB7gdddFHvMnxmBHd5jVMzdx47a54w99wFTIFlGAg07/rwNffpnOPVlM/XhZUycG+nNBGy
 VWeCx4x8qFZdJb9Kt2f75cKNVeq/BD+D95sWCOi0vt710pWljALxP0ZkgIcDtzXeNLAE8U
 HN3Tj0j229lHV8Vr5tiolJFCQOYG1peTXfyefunj8ZMYMzhQuPKU1t3Hhbuq4A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <2189140d-92e1-4df2-a2fa-ab9053140fb1@unstable.cc>
Date: Sat, 17 Oct 2026 18:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alejandro Pacheco <alepacheco99@gmail.com>,
 openvpn-devel@lists.sourceforge.net
References: <CAB8Pm=y=qDzUMhAA0-FVL8gce-2can1tkXTU8GFozZXZD58mQQ@mail.gmail.com>
 <eba2bbbc-ac1a-453a-a46e-1fad8e664b35@unstable.cc>
 <CAB8Pm=xTnNDcex7s9X_fjKPc-6V2GBfjFWOO2qNJ8o3ZG99dDQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <CAB8Pm=xTnNDcex7s9X_fjKPc-6V2GBfjFWOO2qNJ8o3ZG99dDQ@mail.gmail.com>
X-Rspamd-Queue-Id: 4j6SFt48ywzKnTX
X-Headers-End: 1xI7Rr-0005xi-DJ
Subject: Re: [Openvpn-devel] [PATCH RESEND] Keep the outgoing control packet
 in a buffer owned by tls_multi
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

On 17/10/26 6:22 PM, Alejandro Pacheco wrote:
> Hi Antonio,
> 
> Thanks for the pointers.  I have pushed the same commit to Gerrit, so
> review can happen there:
> 
>    https://gerrit.openvpn.net/c/openvpn/+/2002

Thanks a lot!
It's in the pipe now :-) Bear with us while we get there..

Cheers!

> 
> Thanks,
> Alejandro
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
