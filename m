Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C633BCD4851
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 09:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+8PS1072rtxP+55cbW3QWjWja3D69bBiks12osMLg2k=; b=iM9pxV2XaAxUhXS3GzM8PEOkXu
	cDzFzxMCZ3nm7zgT+f6woXZOPOIN8l/m4LVkpSgW9klXKHESWe2bvQe4Nr/SPwI48h8BrCgqE3Ry6
	1oY3epdv1Vjje1sHPwC5YpnaWFZLXMhVyzJl0CKFmw6DRNkLMcqx0U/tde8aY+eELen8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wN5iI-0002zu-EC;
	Wed, 13 May 2026 09:17:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wN5iI-0002zo-0Y
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:17:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nzijfR8SRcO4K/8wwjT2d7S5EYh3r8q+17ezT3xXKKo=; b=b5Niza6bU8sA2TADOWICM8TZmw
 GzDKOL82BlLPPx1o+HFKbYuTt0nC3xm0VJBwT58M3XFl1mm1UryhDiLv9lpu7CF/DZrVHS/VLOaFR
 bGsAHowzKfFgmrGvNDH31+wM9574jziGCRSpJxSKVDYDKQg/qXuEJULxEBwzKcf+b23I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nzijfR8SRcO4K/8wwjT2d7S5EYh3r8q+17ezT3xXKKo=; b=h
 P6feW7ATa2XffokE7VUtTwpm2VkJQjSxbkQyKpB7+uv1aQxqrIDkQJX4lCthStcct7cdxe0sBTSGL
 sPCuSwGXk6ZE3YSrZS5ZJFchUWx6k7WbFsX1eiZfhnn1vTJzGZFUXlVrNYhNr4oVXUo7Q1gYFiDBE
 BB95Yy6qSRm2wpc8=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wN5iG-0003nU-Qp for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:17:09 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so41254835e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 13 May 2026 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778663818; x=1779268618; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nzijfR8SRcO4K/8wwjT2d7S5EYh3r8q+17ezT3xXKKo=;
 b=TwIEnhETsYUmAuytV7bk9FDw/hM082z/kfr3QhV3PAGG4rFAkyC5l1NyW48TQWNr1M
 pletsn4AUhHJVGL3Pa1YzBgDwEYKYUpkkAu5vOWWLPLEIga4gXruMOHQezDs8nuZYF5m
 KEFBcDNyTGdtIypvE4JZI8sYovDWZ+dL+TkFxNt7EEeJ5wR5s8fmWHUMW/SLoj/LH4oG
 wiJOVtCdgRYAzKA60kIVq3J6gXGNItMB7lZN0O4FP+2p091Z9aFv2EhuBRxfhyVwsHNu
 6mfKA3s6n/+2vCOCWugJbvO95SLGWlgSlGR3aFkG3FJbnkBSMTnNVleInElf+wSajexD
 sB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778663818; x=1779268618;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nzijfR8SRcO4K/8wwjT2d7S5EYh3r8q+17ezT3xXKKo=;
 b=BZArV0p0Kx14bsPibrXLFSaiCIbJq88j7cejo+tXGCdBOVFfg98/zOsVDIl0tlL94h
 fG12Rvzg4Z0j7ydzcDecBN6EAbXBhmVRWn/7EHdmoAGNz8vlaTl9bzw+8cGCtCHmF2bT
 pnOLLSPpt7BPUHgFdutw62uh+SWDsvr9Kewcmszfdr7ClXEGpa9teJhyRbSAOYZDP5x1
 CTeFQ47KctcaPIJhDqi+ktRkTh/YlXjhYCKVuWDVekywL3ae6Fhe4aYgUoEHefzgyHxh
 PiKlK2jDNcejR3KLZWFDhJdVf+73kjKPsVMqHBJiuzxbVyCo/RY+yOfKI+VmCfr8nBvp
 Q2PQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7CuHF/EPWyZAloD3JCMPggjsmEpAHhkCz4c+ObU8Gc+rjKpYdmfxJsMGfIUnkCnreZosKakXnQyNbZHYW@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxogAJB8XfzjVIMEeUlg265L1Urpc6HLqCVecAMWUAfD0Xu/+cb
 C8XyKLYcmmFct8TLOQtXe2gKFWb+w9aScujruEVWhe6OTXT1wUHNkKQ575J8omOF4ZMDBoqbU90
 8mdG5IF5KkPFTipKJkHdo4zhOom+O2BVw6iKoeZwoViMtd54qkgmBm32JAdp4B/dTzjjP
X-Gm-Gg: Acq92OHo47WU+1HA9XBm6ia600L616CuuF0u1Ped3WvTnTuB9S3VxjwedcXr0YqENTE
 AVK/wChWjjr4SSGeckxQ5BRufU2i7I8w8AWxrL+eYq1ME/Tw+HXxzNOAeJ1XAom5KEtGL0ehl2F
 6KHlFCOCK07LtwtUCTc9k5l1S3HenpnAuG8W+IxmS74UPiYizMkfI2caTk6YrwA73fOryvuchD3
 mnoGSJMZzXRQcUi/g74gt2apCcvuwrFvCGqrHVqIDQYVx5UxDPn1SNcgzgjc6yUKs7WZfHCe1EO
 kp/DGgxd4G9eQutcK6c/9vWeeODrazG6/tLqv/bsZHkOKjHYanBx6EGKP/hG/LZT6pkyIVYHmgZ
 RB8xNL6UrlE+oF/z5TOr8bqZcXW/8ns9otziSxdcu9E68It3c7WZoWXshPKFs6+/1Zykrh9f8uh
 OsuHgQt2xe2SPuzAHh3xnQj2E8sonPNQwgx6nefHFQixr7BgSkWuFSkxVoc8TiHfhsh7gm6TSRg
 nSBMZuAZHgQW1Vi8FQszbE3TaT43twpaVsS38XEMknAFSCvKW0XSa6vVNCeh5n8aaKvNk61Qz/R
 J36IlAAzcsAHgA==
X-Received: by 2002:a05:600c:3e16:b0:48e:8741:fd4d with SMTP id
 5b1f17b1804b1-48fc9a3bac6mr32207045e9.18.1778663817598; 
 Wed, 13 May 2026 02:16:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d68b14sm60620745e9.12.2026.05.13.02.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 02:16:57 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 13 May 2026 09:16:55 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: If58bb807842b7b95aeffe6849e7a7344e4925762
X-Gerrit-Change-Number: 1667
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1667?usp=email>
X-Gerrit-Commit: 872679a9c1e00a165d07a41d6f90092ab74f89f6
X-Gerrit-Comment-Date: Wed, 13 May 2026 09:16:55 +0000
In-Reply-To: <gerrit.1778102459000.If58bb807842b7b95aeffe6849e7a7344e4925762@gerrit.openvpn.net>
References: <gerrit.1778102459000.If58bb807842b7b95aeffe6849e7a7344e4925762@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MTAyNDU5MDAwLklmNThiYjgwNzg0MmI3Yjk1YWVmZmU2ODQ5ZTdhNzM0NGU0OTI1NzYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c4ed40d07999b694a97c968ed51b81714840fafc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wN5iG-0003nU-Qp
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: multi: Remove
 useless checks
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
Content-Type: multipart/mixed; boundary="===============1471849851290086497=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1471849851290086497==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sOdC+WhGQng="; charset=UTF-8

--sOdC+WhGQng=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1667?usp=3Demail )

Change subject: multi: Remove usele=
ss checks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1667?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: If58bb807842b7b95aeffe6849e7a7344e4925762
Gerrit-Change-Number: 1667=

Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment=
-Date: Wed, 13 May 2026 09:16:55 +0000
Gerrit-HasComments: No
Gerrit-Has-La=
bels: Yes

--sOdC+WhGQng=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1667?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1667?usp=3Demail">change 1667=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1667?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If58b=
b807842b7b95aeffe6849e7a7344e4925762 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1667 </div>
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
16:55 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--sOdC+WhGQng=--


--===============1471849851290086497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1471849851290086497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1471849851290086497==--

