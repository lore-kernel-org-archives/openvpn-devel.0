Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A636CD4851
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0D1TeVI2RR3DjqFEmZMeP7iLd2jmiER9H5iLPyqoUfQ=; b=d4YxZROB7B14zofX2n69CdbECt
	Lg8ZQuMxKNjkPvQoRgCjnE/eNlNbhR5UF6BQcQdbgtfodpiqt/bubAKeU+Nq+rKLR/RxToQJjOPlt
	MkWMZE3tvSxvxRIX+6pGc1/h/UasGEOqhFyP/bWhVbzyVtW3EcB2qy+Ln155FHy7OMbo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNUwc-0000wx-3E;
	Thu, 14 May 2026 12:13:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wNUwP-0000wc-BY
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 12:13:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=neZKayWSuikSdIv9hgPoSoB/WDEsoukZ6IOBaocOUAk=; b=TT/od44uSEkF602v6hH7RC1GOS
 6Uzq4HBWR6b3DKYNOKX+y0BicvmWe0g5kS7kPQlKYWr6lD5WTpXtPxXQe77zt0Db7xQ4YTuKkG7PM
 /b/HDULgadqO+wb/i+E3GRKIndLEkoM82XZAygQWmWTv89r506yeQcrYWUID7E+u4anM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=neZKayWSuikSdIv9hgPoSoB/WDEsoukZ6IOBaocOUAk=; b=LJkOCQvMsB27lAYG4PgSwsJ6wF
 fclIdQ3qV1HtkWbaOXYjpTWeseKKRQFgWeNiiekqu9h/OmNg7NXUo3myeNkTbjioPWaFdA/0tugzf
 /ZWRy6TF6ZSA4syEHH2XrFiTiIhxsgMyZKFM8FzD218Hb7vXk44Z/WwSbKXDCJNa2y9o=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNUwG-0003fJ-Uk for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 12:13:20 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gGTk83Qjyz9vBR;
 Thu, 14 May 2026 14:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1778760784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=neZKayWSuikSdIv9hgPoSoB/WDEsoukZ6IOBaocOUAk=;
 b=lQvPUxzgpXMOMqNLDaFfpFiotYgI8uJC4j/45XsRPNP/0KNpRAhvSzkHyKJFhbPzPOiG3I
 qAPRdlm3QZEe+SqMdfzehdlE5RAYb5NdQKoMMixVv+DVsWgYRitJt1sKmjfGRXe3QeoFqK
 vft+ZTLfgnx3l8luK1cISIHz1NdyABLfC240tieOZX8eJUv7jtUH6RWsUbjg+ijLyGfBua
 izUU2JiBOimalWCNIzDpmBcqDG8fMqN/xBsHcH/zJIpL+4Td0v+9bJmZ6oF0J1n3PBzelz
 OjPITpG4vlknleSlnSG9tw3s8q0mgsSc6yhnFnfYjcN66b5YqbSh9TgL3LrngA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
Date: Thu, 14 May 2026 14:13:03 +0200
MIME-Version: 1.0
To: Gert Doering <gert@greenie.muc.de>
References: <CAA6tFMtd39GY5m+EjRKMxG9gbGwt4ENUW+oD6Mp=ytV-RuZ48A@mail.gmail.com>
 <749b893d-bb99-45f2-9205-ad5f4383f96e@unstable.cc>
 <CAA6tFMtxUHFtcyDY6hLSHCyZRSvx-BckF3P7_CgY3Q=qkyY0jQ@mail.gmail.com>
 <d7bd1d3d-c9e3-4f4a-ba75-0fdccb5006f5@unstable.cc>
 <agWNa_czBd91yZ47@greenie.muc.de>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <agWNa_czBd91yZ47@greenie.muc.de>
X-Rspamd-Queue-Id: 4gGTk83Qjyz9vBR
X-Headers-End: 1wNUwG-0003fJ-Uk
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN tunnel stopped working
 (no traffic) after upgrade to OpenVPN 2.7 (Fedora 44)
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
Cc: Piotr Dobrogost <2026@p.dobrogost.net>, openvpn-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi Piotr,

On 14/05/2026 10:52, Gert Doering wrote:
> Hi,
> 
> On Thu, May 14, 2026 at 10:22:14AM +0200, Antonio Quartulli wrote:
>> Have you tried running tcpdump on on the other end to see if pings are
>> received or not? Just to understand where packets are getting stuck.
> 
> This (and also on the local LAN interface to see if they are actually
> getting out).
> 
> Might there be some new firewalling stuff involved that does not know
> how to deal with ovpn interfaces?  I do not know enough about Linux,
> except that every new version of certain distros breaks things that
> have worked nicely for 20+ years... be it SELinux, AppArmor, NFT, ...
> 

We have also tried to reproduce the issue locally on a Fedora 44 with no 
luck. It seems to be working fine here.

Therefore it may be something specific to your configuration or setup.

Among all other things, could you please provide your OpenVPN config 
file so that we can check if there is any option leading to this issue?

Thanks


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
