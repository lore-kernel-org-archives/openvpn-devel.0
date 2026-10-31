Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7C606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=loLrp5vS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=e2FHvNmq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EOGfg4dR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aox6fxK4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=v9s6AVIjjlUJusbC/+rfzmQ7HfYSE0FHq9jfpux0MTk=; b=loLrp5vSMBp2YzE0KxzwkyRT8s
	L4Gjq+MmgOP9e3n26NWPYMPC0msI6wa2t5+hQi80TG6FvBKax2Y3uwks+3sk8ZEsB7p9wF+7eliHd
	RD/q+mDd0Clu3qD5+W2t4zWrZsEtPwd78QprWAKfr1UF8iWrRBt+Y9Y1vSSi1bDtEQws=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xN9hS-000000006zX-1JCm;
	Sat, 31 Oct 2026 14:04:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xN9hQ-000000006zQ-345P
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 14:04:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JJoUs8aRAAEB8P6KnwKbJYUBtUR4hDbp8/6d//Uvf2Q=; b=e2FHvNmqHRwfTvd2+hz3HBGRNV
 lWfhRHwmB3ipksC+XrbrKPuSxgwGRWv1R5DxRccH0Q6gRqcK2Mkx/31MNDRF5UNLa2NLd/A5C/Ev+
 jnI/tFcCW9JkoANktiuzDR3HyEQYvgxndEyRO6ytld9ap06mDMpVE9m4jzTutBhl21bo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JJoUs8aRAAEB8P6KnwKbJYUBtUR4hDbp8/6d//Uvf2Q=; b=EOGfg4dRj6kSUBntKk980EHGRM
 vC43fhkvi5h0iVFfDg/pziyrdEKePl2+WWY1zSNXGe7ls88BryNnVOXBxMJO4AAQTNIKsfzZZM6Cd
 30kEb569Zad7RwKzPyn86eB7ElXntsNkf7p5JpIBxmrpXkylImaFRYa9eu7oe6i8jqsA=;
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xN9hO-000000001U0-370s for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 14:04:48 +0000
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c34bff61551so290649666b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793455480; x=1794060280; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JJoUs8aRAAEB8P6KnwKbJYUBtUR4hDbp8/6d//Uvf2Q=;
 b=aox6fxK4TbuawwfNC1Vp04GwWPZaOufLLL/ZkzFyYfTyuarHL+kB1TUmfVc8Dl0HJf
 2jEEpf2bPGz7qrWMLtlvftppGc2n3vI7aAl328/mc5mDTVdZT0LPEVPravNzcBWJdJK7
 t1k2ybRlnTWz4n2E3JLxjotWvyK0m9uPacMOF6SQs86gLnH5u69jOFp8OZVwmPid4IGN
 yQZoH9qKeuQFUw22ZfmLgfOjsFdPAIZwJXdfpHPzficxtSL6sJn2Opw05Nag2YUw8qiD
 eaVvXLj3ACboeqVyOwOTadsw0JBwQ2tEyz/GFRKFftzb3jq3TBptiEO+Ts3PhxCE1+9w
 JKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455480; x=1794060280;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JJoUs8aRAAEB8P6KnwKbJYUBtUR4hDbp8/6d//Uvf2Q=;
 b=kfHBxdH5imC33ovlQQj7ZN/R69anm4Cpk8pjTMq9aB/dTW6iHUBw6WM+xubm7B2Mj/
 RuZqnmK2wCCKsbeHyjhx9nb74rYug8hGmqETqsC2sr/iqiJIp6lq5U1GkSMgyZu4t7e+
 Ub0FkAfubuIpKKCxv3b4I+6eIkIg2eGBVyH33J1ONyN+183Xk0CnplO2KGOn69p1xz8X
 dEnIYf00Hlvq+98g0uB1skEO/nlopZ2ejx02l2r0/m7bd1unQoMa/XQ3hFkzkkmgKr6v
 8J2lgvjlYAJBjWgoXajzt0dCMw1A6GI3soqJQIc3ABsQ3bg9U0sHhMVvGY6gMBrb0Ice
 qW7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrXL/eJw9ED+LGHUWVKdCVTAn3fjx9YXQmPO26mc0MBRZtkXrGZYCVjMhZSHtPMnlA01X7OXgGh+WPs7Np@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJFi1wSW5XzyVNm3NINg0DEfIBFgDW0Yx+1hrvylG9flFi1jgKj
 yRyOaGNVl64POgwzeqw2Lhx5fzFaGiJNDRUYYcxLJmJBerRBaeimnIYxSC5XD0UB9CH3t7VB5CK
 ASA1NWxEo8FZMjOAtmH6c/WRE1O8yRAVd5qX1PzWpyktIr7/aMenYeUDKVn+MiXA2v3eRfSNvqQ
 XCTndniw==
X-Gm-Gg: AYBFou2FSkX4ySxk++8aM2Ph4Qdsz78QqaHd3xAL6g0ZZYLmCwFuRQbNoOwaHqOWLYb
 fii3a0+dHr/uZQ4tBd/hAsWbcnjxd7GPO4FDQdLb/Y2AzdZUIyZSr2dX27RJXfG6ukAKs0g97wB
 cTBQxKe2UsyOn0vmsvyydnmCfMcX4L/K+lJYx9qBxtKu/eOId7XI9d58yDktDtVccJ8nGvFvM2a
 uMFaIfri5dVkhJjD7oaBMEMMGz2Muw3q0PaEWJXH+gm8rSkqw/BRB2dIMdSHLCUtKJN42tTAhWo
 6DMd2PIajMZWWQqOo7CCjPBeRh0HKJeZvNDExsWgDDEJt7GwiEQV/cA3z+0jOIxtRSpT+OKP1pA
 hQRfvbCsUjHpQHQDxzjSLYquF8NY/cTizcYBCGrFVNP7O2WY0ClYAYptCDruHJ3Xi/AZw8bTpig
 pZgnayCG95BjzyYNsCc5Btvex0KkrlBhzaMr4+9zL3SSQq35O/eR22JyKDtYr4uNKQC82JXavHH
 u5kG8z3nXmSlXTTJe7EcTVAq/rBynaNIvjWsFg79u3a+9SjdCEmN9Aukh+geCPQoYk0rSqhbtrf
 NXVMlg2szeenbcVaMrkk3+947AsySdQT8WDBuEKIFflY/7MlJ61k45A/1Ue7boUePkFaS6IdlBt
 WFhZU9liar+BboNqlW5Z/P2hciRCxnDtsrWzHVN0I4mDiuX7Nky2IPO8oUCmGyeVuElEAVZFc3c
 6N63uIxEYGB2IyUqs=
X-Received: by 2002:a17:907:60d3:b0:c31:fb29:a137 with SMTP id
 a640c23a62f3a-c4ca7a72d9dmr454931766b.21.1793455479907; 
 Sat, 31 Oct 2026 07:04:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80306sm9642504f8f.33.2026.10.31.07.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 07:04:39 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 14:04:38 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
X-Gerrit-Change-Number: 2074
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2074?usp=email>
X-Gerrit-Commit: c8572113a1bc19f64d5e09a9e1d362e87611c823
X-Gerrit-Comment-Date: Sat, 31 Oct 2026 14:04:38 +0000
In-Reply-To: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
References: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDUwNDcxMDAwLkk3MGViZGFkZDY2MGU0MWI0MGVkNTNmNDIzOGJlNjg4NWYwYTdiYjhiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8226e172ffabbb385367d3984816ccc107e71507-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xN9hO-000000001U0-370s
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: port-share: do not
 follow symlinks when writing journal file
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6039754972906952119=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6039754972906952119==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zEd0USlYaDM="; charset=UTF-8

--zEd0USlYaDM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gert Doering=2E

Arne Schwabe has pos=
ted comments on this change by Gert Doering=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2074?usp=3Demail )

Change subject: port-share: do not f=
ollow symlinks when writing journal file
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
>=
 Anyone who can create entries in the journal
directory can therefore plant=
 symlinks

This the main problem here=2E The journal dir has too wide open =
permissions=2E Please add to the man page that that this should be only wri=
table from the OpenVPN daemon=2E



-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2074?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
Gerrit-Change-Num=
ber: 2074
Gerrit-PatchSet: 1
Gerrit-Owner: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Gert Doering <gert=
@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Sat, 31 Oct 2026 14:04:38 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: No

--zEd0USlYaDM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gert Doering=2E </p>
<p>Arne Schwabe has posted comme=
nts on this change by Gert Doering=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2074?usp=3Demail">View Change</a></p><p>1 comment:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?tab=3Dcomments&amp;=
usp=3Demail">Patch Set #1:</a> </p><blockquote class=3D"blocks" style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Anyone who ca=
n create entries in the journal<br>directory can therefore plant symlinks</=
p></blockquote><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">This the main problem here=2E The journal dir has too wide =
open permissions=2E Please add to the man page that that this should be onl=
y writable from the OpenVPN daemon=2E</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail"=
>change 2074</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
74?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2074 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gert D=
oering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 31 Oct 2026 14:04=
:38 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--zEd0USlYaDM=--


--===============6039754972906952119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6039754972906952119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6039754972906952119==--

