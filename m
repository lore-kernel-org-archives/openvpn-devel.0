Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC4BCD37B6
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4GUIzApwwgDaanQLxAcjVL5qR5LrpdQ/PhgNT17tlMw=; b=MKfnTLLVnE/w4QEQ0d7rDec9yx
	/R2RNBI3uT522k7kmZXXt5adFv/taW4r+22iopGErixJMticu1NHaG3NZJ02vFh7UHkdTg0sm0gy6
	pbj7lRvdlddbMl+x6fiTxYP0gcZmewQmR8JKHrHeXOGXCENkhFBbmcS64WbpWTjXjwcg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wN5mT-00036a-9d;
	Wed, 13 May 2026 09:21:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wN5mC-00036I-5v
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:21:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=U00mgKixFYC3rjNMGQ6pOs271ue1w0F91w5VLiX1IjY=; b=dswin4e8kaMyaqYX5h+lWzdmcR
 yRlp+AQ94MwvznJnXkYNLTOqwvWV/yUgn8BbqiMi7xwUrsWtXR5ynjsR5u4zra2Vgembuz9NT3hb9
 cMa4vAPoMN4nh9pUFPdlnilLfPnYQVkLChF7+dE/AgHj/vcTYKNOgUvfv0PL78eLy8Hg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U00mgKixFYC3rjNMGQ6pOs271ue1w0F91w5VLiX1IjY=; b=d
 2KYsRUYHKvDWB6z5m69L3ulAx2dS6rjmObeS0sjw3PegkiX3LtT9acsY02h8IUzVw4toWbr56+DIP
 /sDRpNao0AnEkvvKJ8wH4jzVw2PlwkVruq4z2ZunHzx4FnCQ8zkqnuK7j8RhTuKHWzlMjOWt6mdNF
 hDK+qddxQP9v80K4=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wN5mA-00040V-0y for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:21:12 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so4856836f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 13 May 2026 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778664059; x=1779268859; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U00mgKixFYC3rjNMGQ6pOs271ue1w0F91w5VLiX1IjY=;
 b=IskQV8UykZAF6lYjJKCDgTtt+J1gny4De0QK9O7C2jjs5kmz01zvpjRYd/RWK0BBYY
 dbMPyusI0JUFCc/AqgRUgFFuEuMtQ/PZbbal2nR9Qpai5CIcLny/HL2pLzQM9+bWBCBI
 1LWWp9upkIgg0PcI/E5gO6Wafn6WlB1ELbXlflVbuA/7PDdfFtVXP3ttFKt2bwbMkVpM
 GaIbHrGWUzSYm0Du4D0b2BfbeV+/7DjRinEMlyf5hF4RFiiDi3I+TUZQgaU9YNKBvIM/
 JfeLMHM/joY6GkJnu0x1V23Rx0ptASoPAedic6VhtUyfjb+h/rQIWN5kQpYub0rmqVf2
 i9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778664059; x=1779268859;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U00mgKixFYC3rjNMGQ6pOs271ue1w0F91w5VLiX1IjY=;
 b=CyDZ8yd3QF2C5aFZNz1atGiyqbRQkoGyaoeZ7uNxl/JK4vR2f0FP0UeK1v+Ze+IOU8
 XoqCuP3vTrv+bJSdom8gVtryxjnhirTAZhnXfct/TOmdx6J9n8twO6Zi/X0bDMJX4RY7
 g5VvhJVyfw4wUTDVXkvJd7BbNWGfB4N+noVSjVKbedBgCkYp6mOH32Kjv4BYmQCZs8vR
 B4Oum1b1dA27+YUGp3ko5WtrDEwCsEQ6QJ/NBIW+5ChHcZfzb4wlaDUc2OKArnfDynI9
 D9B9Sf243+cxCuS4QMqvKvHXq3REkoS9GbaL58Z3DCMVJqgjav7r0mqkkFW0E2vHlueM
 6ktg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GEid4teZnDtCcc9qkea68Qd2THdGaMHayHrgpZdJSnBazZTS8qYUcvWGRrlT2qYaVc0tPtUfiY4Z1NYsY@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyoOsCaRESTzg0oA0zfuiTM3XrYU/e/n/kwbQXLONtRm1nv1wuS
 /E3no5BcvtnVg/o4/3uIcLlW0qIzcCWrNaE/LvoT1xJZqZrRYXIVdOkgkwWYRWpsFUmiJu5H9md
 YyqUQz2/CyE2rnyt0Mlwic5G/nkCZriwmLhSt9vJjONuJMVzP4Era0p5RRt/EnXzSpVe3LrO/2c
 5z8scx5Q==
X-Gm-Gg: Acq92OH4tXC8oSDn727KYxrBUO0mglSrnz9DU74r5ObZIL+mhcghEU0QouobS5ZNrSG
 Ux0kLpFgpMU6C9lPxxvXBqxIo5R5VrAyZpKt1jZK5nAiqJT71GNA9CMl55xBm1dcxWBrZcHt/M1
 p/QwL+s8r9yXA/xij6BgTlso19yeZIQySvjegsLxaqwIFzb87e72ZGvBYCNI9wRr8VpWZdReZVh
 JoQTfwWnOvRcRgpumynqPRssOxnvIfTQ0/ryQlrwYDaftalqpXgcyAXXXjBNyg1vSnVC9X6ZMNX
 DECWB5NV69hLnty+GAwcNLGAkzG9vIrZ9WZgTCZ4c5l+5fwDIzGZsXy2QtFUXX6d890iKOyBYrm
 xp7zoePH5s6lZYnoyYh6FgEwhtMbWQvIVfTWhlkSyqbq/GLBa1TrEh2YVCF/uYbARkf7+pFPOXt
 23KGoAdOc82phg9WhrqNvL5wbYwdgolwYflY866zkO9amkgKTFLGKJcF8w/CztC6IdbR/YG0v3J
 XjUPO3MzmFcNz6TkDHNZtG6BA8aBd/lrTI08bbzAJMKC/RyoChDam6MKyiTzBuGTWuaxetsGvmc
 Rgk91dA41Sy/rg==
X-Received: by 2002:a05:6000:2c12:b0:452:6aaf:76cb with SMTP id
 ffacd0b85a97d-45c790b294amr3216186f8f.1.1778664058862; 
 Wed, 13 May 2026 02:20:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491f8d4c3sm39161260f8f.34.2026.05.13.02.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 02:20:58 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 13 May 2026 09:20:55 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3ecb76d9022dcd7dae92eb5e9d62e5f018744883
X-Gerrit-Change-Number: 1666
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1666?usp=email>
X-Gerrit-Commit: 3b30a82bb5e82a8f6c893dd5b606c75a538e4ef1
X-Gerrit-Comment-Date: Wed, 13 May 2026 09:20:55 +0000
In-Reply-To: <gerrit.1778102459000.I3ecb76d9022dcd7dae92eb5e9d62e5f018744883@gerrit.openvpn.net>
References: <gerrit.1778102459000.I3ecb76d9022dcd7dae92eb5e9d62e5f018744883@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MTAyNDU5MDAwLkkzZWNiNzZkOTAyMmRjZDdkYWU5MmViNWU5ZDYyZTVmMDE4NzQ0ODgzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2d3d2a03d8b4bb46ee71d72051f90f5c1788f65e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wN5mA-00040V-0y
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Fix some
 issues with -DVERIFY_ALIGNMENT
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8159033688680913494=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8159033688680913494==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZYzpYB2s8zk="; charset=UTF-8

--ZYzpYB2s8zk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1666?usp=3Demail )

Change subject: buffer: Fix some is=
sues with -DVERIFY_ALIGNMENT
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1666?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I3ecb76d9022dcd7dae92eb5e9d62e5f018744883
Gerrit=
-Change-Number: 1666
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Wed, 13 May 2026 09:20:55 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--ZYzpYB2s8zk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1666?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1666?usp=3Demail">change 1666=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1666?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3ecb=
76d9022dcd7dae92eb5e9d62e5f018744883 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1666 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 13 May 2026 09:=
20:55 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--ZYzpYB2s8zk=--


--===============8159033688680913494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8159033688680913494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8159033688680913494==--

