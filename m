Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C76C43602
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5mCWIrIPaXhumynZf2Qvs1riQwl0iRB63HyYKHBXr38=; b=XGDLMt/kaoECN7yzgPkis5Zoby
	z5x31UT0x6doOAYb5YKxR6PWVM6Z9IMHOXN1UmnglzXMvxQuhDUkC+vqEJmkbdRfp23G7PDSNBq+1
	nPFDEJv9UUPwsvDEdnFnqLwEDk5/RCvIVQZTax58hBNWN1gkPH6+WR2+WdPmFizL+w2o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weBj3-00018c-Hx;
	Mon, 29 Jun 2026 13:08:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weBiv-00018R-1O
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:08:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RfVn8nJpVPvbzc26LWgBIgqZuhncPusd2qLFHfljrRI=; b=mJTCnvf9Mim+flmSnRO4JgFbDO
 Z2u1pkrDRfzhUtVhPOfBvPpuwI75xuszLuev1yugeb1/JiPGKGhaSf0qVNjZAy+PNpQjHNhqUhkFn
 +QGW5JAy4+wcLyltkuhNrXQT+ENewdPyT4MEh/Ju7gIFrpzT/56q0WKJdSUXZw1HDRDs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RfVn8nJpVPvbzc26LWgBIgqZuhncPusd2qLFHfljrRI=; b=S
 vcMP/u6YglxBIDR1vfF6//9Liy5lPjkU6l/kBHGANHuax3pYQBrf4uxk9AjLSyg1KAIDVgBR08TK9
 GRHq9ePqhZbtuwf4ff5BU4hcsj/SgXmaQLzlMs5idl6rVagaxY5y0KRjB6zwLAAqaA3oa5owmrTaF
 ClWCaCE1qjz4oYzY=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weBit-0005zW-Ie for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:08:29 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so27483645e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782738501; x=1783343301; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RfVn8nJpVPvbzc26LWgBIgqZuhncPusd2qLFHfljrRI=;
 b=Z8i98Y4ijlZgSOy9K0ZsNvnERtmkfiQZqvJr3cTNrFuDWS/rcdEJV8ghK7E0zqw61D
 UXi3vw/yKnVsDidSrozBPQhxVBK2qVqlsPe4Ll28SmJKGSndnbYm5kKY5GQPoVbrkj6n
 +l4m2sAiTSYsTWaCBlwoOCLIzWN6y8I3qH5mnRm9xP0msFHqhFLwwa6+RtMJjQAp/Nuo
 14s+a0gJ9CtMRcD7pnxHezXIXbxRerWv3m3dAZRaot4Ookua5l4wtNDu1+p+mrgXLWki
 0c3VlOvDmQQmhHczUU/HQCIBqF9vglN6DIi32yX4tbA7KT17Ng4J5pIwd5heV8mNhkvv
 7BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738501; x=1783343301;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RfVn8nJpVPvbzc26LWgBIgqZuhncPusd2qLFHfljrRI=;
 b=PT7aEVZJZyW3kjoSwZqWLU9bsOcaKsmP1D0B3XPToFTZvSWW2M2tHsUJHXJfF9Ny8S
 WPSxyC16PzQnJ81Zn7U6Q8hPNH0m8NMNOQ7sYEdCzUcrkUvLy4avj5xDfWAZD0Hqb1UC
 +j4Os9DOpTIHVgG1yVRQdpbref7FGrddZ6m0/2GSk5y4JqxtasFFjt/mlghagEPDtQd7
 /NdNAOqumHbfPz1Tc5lpd4YlvnujruGR+0Z7w7C3ytOgx881o8imdp8jYce1+gHaKEfd
 61W0VJXyCpg2D8MeYxztewQgsPxHInt6/JYznbhQpyF9dDakLGVnU0fv4KVI3P9/w0j6
 JmbA==
X-Gm-Message-State: AOJu0YzekbUg+k8Cjk402SbPVHj8Fy/9STOHfWNly7nIsRpCvOXN6VQE
 BzkEvLc1F4lw+afXjKDYuL8QCddAjGfwiCbApKLgAki1Man67LOzno9MSBfXGf7Ies5Y6LCeidD
 YmcruOD8V6uQIinlXaDlY7cW/TZGl25+2tYkFxm0qQsy+UqwV6tBASdvFO31GW9fTBn1q4xtsbf
 RiH4XlXQ==
X-Gm-Gg: AfdE7clm9RWL68WlhTmW9dQ15oNF2+NHRvWrVDwd53jRkRdI6wkCKmR+VhVjEsiWKGW
 u9Mcj41Sg3eoj9unwSc+6un5tbiVrOgAMtgHK5yxcn6AfCFturLF/stosAeR9yZ6RY9R0o3Zui4
 NL4H3f0B51SXooQaxXdjECj0At1kCUIaxi2LQrvkj6QNw4S2Nj9yIB2urExHVsv4M0FRD4Ldgyk
 OLhWpArJ87YYi4II06Scds7lYUZ0ElYErVk1iw5Q7RSwv1f/X04//m52JIWkt2VeJTGgD5fZMMh
 nRwxRbaQpNfGwH/TGXDr2LkBPyhQ6g+TCULBSSZPa0YZb4Wb0b1LPLSMrnqSciSDPb1fV/UcH4o
 W260SFQqBGquuX6RTid+iCGUABcWxLE5kX9QFxoZKGG/dDT+RMnH7tKs6g1zULzGfdPlBf6OmG6
 zZ8dMHo1GiUzSvWTjGj9pss2yzWQC1N0/O17zwvY1zHq7zTylA+JR/GDmbIibHHCvqxUma9y4Nr
 dOBDRCzgzzxDaF7kkhMWYPjqUFWl/t0MzxqyHuUKxQeHX2dsqV3ptcOJwewqtpVuA0UuLgo/Lbr
 um3bfpq/pxLVzg==
X-Received: by 2002:a05:600c:6309:b0:492:3445:ecf8 with SMTP id
 5b1f17b1804b1-493b7191faamr10528445e9.3.1782738501268; 
 Mon, 29 Jun 2026 06:08:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4728072188fsm16207768f8f.29.2026.06.29.06.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:08:20 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 13:08:19 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I746bd8c0fa3496d23569cde496438fc4189600fe
X-Gerrit-Change-Number: 1753
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1753?usp=email>
X-Gerrit-Commit: 2c4d0cd992d884f72b73ef16d7fe0bfdf776f490
X-Gerrit-Comment-Date: Mon, 29 Jun 2026 13:08:19 +0000
In-Reply-To: <gerrit.1782737981000.I746bd8c0fa3496d23569cde496438fc4189600fe@gerrit.openvpn.net>
References: <gerrit.1782737981000.I746bd8c0fa3496d23569cde496438fc4189600fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzM3OTgxMDAwLkk3NDZiZDhjMGZhMzQ5NmQyMzU2OWNkZTQ5NjQzOGZjNDE4OTYwMGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0f4da9a16843d086336d786a39d23546a92bddbe-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weBit-0005zW-Ie
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
 Improve output when echo -e writes "echo -e"
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0041761913845476955=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0041761913845476955==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gdz+n73p5yc="; charset=UTF-8

--gdz+n73p5yc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1753?usp=3Demail )

Change subject: t_client=2Esh=2Ein: Improv=
e output when echo -e writes "echo -e"
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I746bd8c0fa3496d23569cde496438fc4189600fe=

Gerrit-Change-Number: 1753
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Mon, 29 Jun 2026 13:08:19 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--gdz+n73p5yc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 1:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Demail">change 1753</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I746bd8c0fa3496=
d23569cde496438fc4189600fe </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1753 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Mon, 29 Jun 2026 13:08:19 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--gdz+n73p5yc=--


--===============0041761913845476955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0041761913845476955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0041761913845476955==--

