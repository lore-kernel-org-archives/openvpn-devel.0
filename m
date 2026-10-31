Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6DF606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ov4pkxxO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=b0YNotKp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ewMwybuI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=c1KHEWjM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iwe48ylJPp2yj5GBaMN3EfenMFTVGXO/VvmKFORkP6o=; b=Ov4pkxxO3YYqV9JzKG0aInzGg9
	wQCmsIiJG1iNOuJXs+/WVdU1uE0JCuTrdiUWMPDcdeT89qMtGye5NBW8kI5XEqrR5zSf9s/afcW/m
	j/bkIoP4wZ/pOQ+4vrBL1ZXRNcztd3q1CJQgtSy68/7SIqaTOp2Vam/rnAAOSZ3vDejU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xN8a5-000000005Nz-3DwY;
	Sat, 31 Oct 2026 12:53:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xN8a1-000000005NV-2hpK
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:53:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a9Ae8fLML08kEyAVwrxGnk18Fr/KbftjqGegBhZsB34=; b=b0YNotKpbRsrHTVMLWJDAmMzLG
 OHR7hw027Owz5JedDoSVNaMBrxbzwto9HPKRPTavTuDidUMn/ND6AoDI6qkYZdVOtBTE/Ni9pHAY/
 N14Kqmv7iAsifAzuLDaq6Wni7QzWxDjb+Im5cnfa6FlCMBzkaDB2vQ6n5I2iqSe+eMtg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a9Ae8fLML08kEyAVwrxGnk18Fr/KbftjqGegBhZsB34=; b=ewMwybuIRy0unPNuHc0Cfwd7tS
 afuZNNSqh4EWtybK92l/LwNZcBG0MzBGbZkLOPKnxAECoy/fY+nWzMwg8TUoIlEJO5/iEsHvp3sWS
 fS0wP33rufomgaxK1wpSF9ioGlieq+SvMRVy0jmDbV7pFZx3XIGPBRju9b80h2iKnhRg=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xN8Zs-000000003a2-00GO for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:52:56 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so11867475e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 05:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793451169; x=1794055969; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a9Ae8fLML08kEyAVwrxGnk18Fr/KbftjqGegBhZsB34=;
 b=c1KHEWjM9h482jB2uWiqiN1aMRByd+QFpLj0jt8BT/NZI2FclplpfaNHDpvHOYdM0A
 lC39lxU4n2qdECCPZXSEQidZT35l8yhawhXVealtsPeahgCAk8mT0ShKbfJxm+ueu8Wj
 +Xic/0+jLVQ890itLrdXNZZELI7kaH5t2drEgO62kicPf8C5ToY1vjmzsRekOZ5X+LpO
 +4n44XuC04kTDG/QkgFw5LFD+elh7+C/puY8VNb2gqdqFfwHbV6SiGc77PRm/vqoB/RJ
 SojUebUsd3umrWzTusywmlEWXij7xIiCwzoaUfJGUXYBME7+SGwzVL6WYTvLee0M3pd/
 6IjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793451169; x=1794055969;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=a9Ae8fLML08kEyAVwrxGnk18Fr/KbftjqGegBhZsB34=;
 b=H2Lvw2NansuPbuB2MIgRzdqsUFZiIopjWcMnPfRVRoNlQ1up/tBfR7CL8g8W+e7qgj
 bmz6hBVImR9eE56zbV4Ov9LI38tFJofgfOYFujphyCDN99qaAIIKxDG18cEtxbzfJKej
 5Cz1fXUsIGNJg1X6xwNTkQ/2QC2dDSBZxDYjnGRaNvOYltGXUYRNqJxVxVESpJnLd97o
 Cb9K/6tvY7Exi0viSvODY1zaN3Zsl9FVOvfKfiw15bHMFavaDBAuWXcRKs7Ld5GqxNTo
 ilZhvU94+ETxOkumyF4xwcc7mfsnV1eyB1bI9rol/F5zkMjX1tIb7wdq5F0MXa8rcqmv
 iIUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVHUML7pJYIsk+6H0hhDxh1eUiTKNptVRMh0rULZFp3NCPyiohgpUFXNMr8Z4kikBsJCgLa3nTReqHTFZA@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKrWa32c8unM/xFObtDywxNeyyRsPI61GkondgIQY6hSUA5HX/Z
 pCDYpLi/Gkp2gUDo8SiOj4jfOw/a9pbwxetjY1QfN9s8qJSqjkyC/X4D0MGOOr+X5kGwUPi+sW/
 EVTyqZVmlkIeLE2vEdHcpytm3pGh0PbhNCwcLBseYmGSojRfcNrxTcz/jeRj3Crb/RLgLOn0WRa
 tH2JpFpQ==
X-Gm-Gg: AYBFou3wgBN1RgiuqBYH57lk9loro41dk5K3cwz7UwnZqo8t4Cj0FOCoYW8ZmxnUiu8
 9ECIUFk6PKnOPw2UkyBVUPqpmF4sFIdBFtzW8EQmPxMWDqEcJ/IEhyJJKq84qUupLBQhkSf7ZFd
 JDtF62CuCOum9p4Ra6B7j6kFyNaNUm4hBuDOV4aO1vw1xyg2E1rOseU/dyjv0XR9h/8OrzA285f
 emHOLDQArydcm+eeh+4laWQTIQCC8yShFo2/DgTQw4+3xZt6XPWgEu3PWzVKvy1Lztg5V0EEZSR
 73F6UddR+naQi4fSilDmod4uwv9zJ9IIceRx/qBE+zj+iIvxqeHhxu7C77q02T3reSQVvProK6S
 gweaBoK73ez/yIoTseb7yh5YnOT3rmnmMleOmePleXLKjF9ZC3M47oEy8/3ncpcTGcvU83y9w1P
 Oi6Bt15b/AeH8dDQz5loZxmhXxj+7wMqAEquDTRSnoIoYl+peEDtW3AlWdoCMXM0Ntx2D91P/PN
 b+cGJkhLBTDJYBsPEWq9n0R05WgUXvl6gNzKS8Fd/DJFhg26azEafQWBSptLxcRSHR2XkX4kBTP
 5FW5WN7FGhl+/bRh9nj4FbFlHMc30RY2XK4GhzzLhnrAOucoxRVXxgCXYB9uKy1jRBPanYao/H0
 rhNk8+UK5bvPmSTsZ6yZgrWP1vn7cBntny3PnsfbpYjReXVr/BHsCaDkgdd1xJS5oHXWQdStfXo
 ocjvohBMZ1Tillm8o=
X-Received: by 2002:a05:600c:638f:b0:4a2:1050:aff with SMTP id
 5b1f17b1804b1-4ac17d16a26mr117608525e9.6.1793451169316; 
 Sat, 31 Oct 2026 05:52:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf60f1114sm138246715e9.7.2026.10.31.05.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 05:52:49 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 12:52:47 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
X-Gerrit-Change-Number: 2074
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2074?usp=email>
X-Gerrit-Commit: c8572113a1bc19f64d5e09a9e1d362e87611c823
X-Gerrit-Comment-Date: Sat, 31 Oct 2026 12:52:47 +0000
In-Reply-To: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
References: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDUwNDcxMDAwLkk3MGViZGFkZDY2MGU0MWI0MGVkNTNmNDIzOGJlNjg4NWYwYTdiYjhiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b6d947f1ab4aecf97af446405241fcd16920a752-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xN8Zs-000000003a2-00GO
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1000822960804248187=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1000822960804248187==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rZSg61TYgtQ="; charset=UTF-8

--rZSg61TYgtQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Gert Doering=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail )

Change subject=
: port-share: do not follow symlinks when writing journal file
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment=
)

Patchset:

PS1: 
This will not protect against hard links at all=2E



-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70ebdadd660e41b40e=
d53f4238be6885f0a7bb8b
Gerrit-Change-Number: 2074
Gerrit-PatchSet: 1
Gerrit=
-Owner: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Atte=
ntion: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Sat, 31 =
Oct 2026 12:52:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--rZSg61TYgtQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by Gert Doering=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2074?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This will not p=
rotect against hard links at all=2E</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail">c=
hange 2074</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2074 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Sat, 31 Oct 2026 12:52:47 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
No </div>

</body></html>
--rZSg61TYgtQ=--


--===============1000822960804248187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1000822960804248187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1000822960804248187==--

