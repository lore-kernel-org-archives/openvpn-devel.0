Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655DAC5DF81
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iL4dUd3bgc0bRsOPo2w7qAPVKWv2CidGdnVDLjvSc0o=; b=MYvBS3cjCtld7Axxo56/rYCbNM
	PueezqTV2udyteKKw/31Rzr0oJdSg5CcaXW6D9qhhK6w8iL9tn/ncXQPhQVFCQLMboxUvhSGkYUlX
	RGMiSq5FSeYADkxm6vZvRuG5Ef1h4iVflBMKHWTMiK+n6ySLSGJWXBSxsuAjAQnzApck=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyUWi-0007Y9-GE;
	Mon, 24 Aug 2026 13:15:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyUWh-0007Y3-UD
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:15:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Gwlr15vC+qpfbUYv8Sz3Un6/gHywL4FUdobcEBzd6uY=; b=MqopunKO/3ciIG3z7hPCCyDOr3
 4wNPE1qFC5ous4SedjaSCr1wPx1RuV0bc5rHYGCpO6qJ42uoNR1wCtORczLbfZ6+5R2xh4AM6u/Up
 XjRO8BhnCgMNZnWDbE3lUbwS25xUbumMiAckZrFpaZk8hXiDtQVE0qZH44g8ndvvUNgs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Gwlr15vC+qpfbUYv8Sz3Un6/gHywL4FUdobcEBzd6uY=; b=k
 wKMLNjYdYtYLnkqppsHZrE42f86RdSym/Bu4EpS+z4FwiqSferJsE99Yn8oCamSQsTPjNQMMYA8ve
 WMdDZTUAIOdiupk6T1RN4+/mJI7q+Shg43XPBv8Rm7xv1wD10ZeT4EXLZIRZ1toNNe61QeMNSg2kW
 Z6pBgE9gzf2pCL9o=;
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyUWg-0007uG-PJ for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:15:48 +0000
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c15cd3fd760so412155366b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787577340; x=1788182140; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Gwlr15vC+qpfbUYv8Sz3Un6/gHywL4FUdobcEBzd6uY=;
 b=QykO7U3rG284JHkSRjuheEOpn+1UqR6JBCMo9VGPbIk3/XpE8jmDVLmIs/5DAws5c6
 /ly6kBpKW/u8KfaXQJSKJ7cA46KOZ6M8ncUFYzSqasJHLzyqXC/sRER+IG/GJQ6HHknL
 v1SxEIi1oeEZGLwkeZqbhRvJYUAcIKD8+9+ZHmHOK6mpq1iy0MfPONKiIzzArVL9TBl/
 vHHh8CtkTP8YB7KOWrZP6U/KiZXfvWOtExTWlgZZssLzwW5JhujAUsFidHQIRroIBW3z
 zgKlDa8XA32lcekarHrLa3FuN76+4KVrLZVA7HBvqDtaAEMUTxiS2Z6HMlsB1svU/lSk
 BURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577340; x=1788182140;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Gwlr15vC+qpfbUYv8Sz3Un6/gHywL4FUdobcEBzd6uY=;
 b=sIOQ46ATeuuOhBWfodyXcej/Rg44VQL/a1YHMASzu5DlzDSnfPKLkTyk0DdLvScMM3
 QSUGTbTizdCFZlz9FvjMs591CfFdvilg1a6jK7FTpF/VqWcmmXcxS++0xscNul/AgTqW
 p/RRR3gV+Xr+jl9qXm060+c0bUG/nSspULOLoqAH/rR7stlKgSlN6p2Cz52HjjIlGn7/
 ist0BBwqdkCv/5fffkWq8bEQ87Kn8LAPgdakIkSSCof4fbWkugUpStVPCfvU+0wJRllE
 ++0OJJKounNKLcRGqi5kMKOYK5MEXs1MujVSRD2i+N01PG5VmgjSWKMVGdvuB+9Dt5dO
 OPEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+UelPHgvjUoUJtQ4/uzyNv3jU8bkfZML4qxyCfOMHRwBY7awf4EhREC3zGd5rREQGuImbXOmZA/Y/C5Jv@lists.sourceforge.net
X-Gm-Message-State: AFuF++mHvKy9mD+2PtYDV6NN5p7La1HHCaHaYfbDeEACVfBwdQik/UyG
 XgXWPSPdEQEFemwBO/842uBEM+nlcGfpg1JWRR4EoH8ARw29pvhjyfaMehGCnzyUVkro2KlBclL
 2FCJ0PpS2J0QaTPgAJlHKKfGaA8nRQBzG9L/KLPYogjqdZYuO1z/22e15jfzpozIN0Rln
X-Gm-Gg: AR+sD10OJnyn46eJtUKgfQ5EyVzcWzboe7Qrk49jKs47hdi1vqte3BeC75zw9jQAtc6
 5My05stL5Tku48/OCS81X09cX6g3EFevKVILrVwS1Nfl+FrsopIW//n2adI+SanjUyYO1CkDSwF
 uOW3/VkYEs9JyQNqgvRzr4LnQG5S0bP4mIivmsp0F55VX/SgB0RTKhR7t+LGHiXuvKyHLitpK7i
 xcEmmSTdreSBgQkhiwPaHf6cS8fv/2QiwpQhPZN/CS9kZDI//Q7Y/Iwg6XmETCrKncjqIjxQNM1
 jl2GwYlg+0mm2olqcq01uau/bxnKlIvJnIp0d88/9Dat2NXuV4E0tM1cfq+Ngo5KVjl5MR2m8OD
 3lGssXJ2lZ5ScVCRj+DpjbX774NVsZsZfWussIoOpG4SCi+cVph47BLq8OC5KV49y+qZxphbUR3
 W7I+jWYBW1A6qqOPAvI5NL+F4lB4ytvPg3NdWQ3YqJXW82MzMNOsCMf95foiP0fkBTtMdF5PVOp
 P0knHtAya23EYFjjyAruRSfnsqJSN0YUC/9z3YOInTxBna1gVLzguChvuxnAeY9KJ+CookJv/Sb
 wJ2asYHYQlkklQSEKi3g8gr1Au3wD+2Fn+VSDP+L6nfBFWLH4fA=
X-Received: by 2002:a17:907:8e0e:b0:c1c:5aa1:de57 with SMTP id
 a640c23a62f3a-c24926a1baemr2069368366b.13.1787577339933; 
 Mon, 24 Aug 2026 06:15:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496296cafsm1304311566b.14.2026.08.24.06.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:15:39 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 13:15:37 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: deleteVote
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: 580974871f6664ce68e8f5e0034a27970063d7bf
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <46943eacd371ecca7d63c79456c2df87c5d0bb75-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyUWg-0007uG-PJ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 unused functions
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4327010530687991871=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4327010530687991871==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cxzVycD86dA="; charset=UTF-8

--cxzVycD86dA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
zvanc has removed a vote from this change=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1610?usp=3Demail )


Change subject: Remove various unused fu=
nctions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Rem=
oved Code-Review+2 by razvanc <razvanc@mailbox=2Eorg>
-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: deleteVote
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b=
5
Gerrit-Change-Number: 1610
Gerrit-PatchSet: 15
Gerrit-Owner: flichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: s=
tipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attenti=
on: stipa <lstipakov@gmail=2Ecom>

--cxzVycD86dA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>razvanc <st=
rong>removed a vote</strong> from this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">View Change</a></p><div =
style=3D"white-space:pre-wrap">Removed Code-Review+2 by razvanc &lt;razvanc=
@mailbox=2Eorg&gt;</div><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1610?usp=3Demail">change 1610</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: deleteVote </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I82a4e82ff876fab715e052de19=
03c65b835360b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 16=
10 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom=
&gt; </div>

</body></html>
--cxzVycD86dA=--


--===============4327010530687991871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4327010530687991871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4327010530687991871==--

