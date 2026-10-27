Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE79606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gjLcqqUe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CC+cnVzQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Grb4sKWf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=U7ajn3Zr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=etx8MAFTH2Sss0NhsrlAQO9YDuq8f12NM+NWodYYscg=; b=gjLcqqUelXf2YYA7b92/DNdqVj
	L3oyWRVGphb4eJ3NxM+ejJKgY1VkqV2I+ZhfBoLuqOMPpLogyo+qfIy3DYZrTnNhQ66VJqI3t3JtH
	rLv21X6bORMQ3sTebzaHI5HESOkb1MlX8k2HX883/f7yLRjQR3LFbrKmZSNpLBK+IAqI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLf4w-000000006Kz-1a6m;
	Tue, 27 Oct 2026 11:10:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLf4u-000000006Kj-2APU
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GXK0XIkRq3r1qPxA1z71ixtX2Um/a+xZXHQLYdaZdno=; b=CC+cnVzQYuu8lAh+VfEjxy7WvP
 0xwrdalvZfVHTiGmr7sx2OchLRDnvZFSgmO0UyRs2Q0EcZxUZb6YYRWKp9Jh1qNViFoV3Z2d5EkAO
 mI6O8/kMW7Jt9ydiswP0jL/s25tKf65vwvgztSrVtkgwitJTFIG0ksuVU1psuL/xUysE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GXK0XIkRq3r1qPxA1z71ixtX2Um/a+xZXHQLYdaZdno=; b=Grb4sKWf5cgKkhR7EHZMf8fWTr
 qERtp9fjBiVo+ds0Qlrnqw/goqRIy6bwRMNn+dWEW028rJFn1gEc0x3oLyiAuBPTR4OMkv9SCgiEl
 iZr2wbct5lpXxwiWi1Q9Hub77+oGJgom/2FoLVgtscxkl5nkfYU72unTJZ86KSmr5HIc=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLf4r-000000003Pr-33K8 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:10:52 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so2681214f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793099443; x=1793704243; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GXK0XIkRq3r1qPxA1z71ixtX2Um/a+xZXHQLYdaZdno=;
 b=U7ajn3ZrWMyKLh28/HDJRSCzTu+ebakhZyIVnCofHOyCmY20wgeyyde1/MyyM9gBTx
 eKUr00Me28ZXB904hy+5SocGgC3lccC6jvWwotXZYyMYuC1Heyjzqvlg+swaUfldwxN0
 7f+hUXKPZwaho3ntpoDfpZDRSiQvRmZKDDqHfTTig8aCohW4MDXoZi09EXKW17S5KTaE
 gQwcf8ayLO/3XZnNtnpYQMeaaAPk1u5nnF/iH24bDMXSVglVL4kVtkprqZTPRGhPrNlV
 luEiBOhThrxH3qzMfe/V+b9u07hoXQOVoMd9Lia3QLqgXTTgZmR2IvKRBtgr9058uYoa
 8Rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099443; x=1793704243;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GXK0XIkRq3r1qPxA1z71ixtX2Um/a+xZXHQLYdaZdno=;
 b=ABnPY0+KPISkrtW0D65gNTNYksybq8UTri98O4XS7g9Wiw/nUqCLl0tdwVcML6lf1q
 qdyyclTBiQAWj4UTUPMA4mUZs+mHtsSwKwsXZjDQX6OugHC5xfRZMk282/ux+vY03WhB
 O/EapczSdqeylPa4NoCbTwL96dLg9b6puVq9nlgJ9X7rWeyvQ72aIqIDm1mkrnUvicGh
 XL2lj7CmtR8CaAXzxK1DZUlxCQXISUqriB+3dV8O9nTNX968lPnz6athaUlrEQnuGPkb
 H7bV59Yzen6UBdRkvoRfvm9MtxMSWCceXyvefTeFvi+P2wrylnWvO8AbiQHcU42E58dd
 bIBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzl72OD8+152ru33YTaBdy7MailrEVFbNSbYMP2Szao0pDZuvnAx/I1b9exEDy4qbDj9+l7afBsZlUYxj60@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLp2iIByR+MaEGE6LiMvZ7rjmWJBGcOeb7+uakcUcx70M1B+YfH
 J1rXtb6Z3g98Oh57E6uwaTi6qsHvF7LORzN9akjDb6Wnth/EfexJ2/uxzVuPeixdpNyXxjpeYoo
 GsctVJDQaiIEO4N7Cr013BQcTS1RILDm7bAzrtzxvj7BqFhXGArNS/f//a7stBX2qIT6E
X-Gm-Gg: AYBFou0Iy9EXn3pJAo/5JR0HMumsqXPYrWURBIQXDKII4fppsI7PEE3A6yVFobB17JE
 G9gj+NdV04bLrSf8FccLuFaUgrJDutOLvoCI5zGJT2Oyq/iUfCtY2MoyWtDZACT0kvN1A0VdVLZ
 BesYRdWpxw6IPs58PaiQf5hqThg5WtrN2PT0qca6WtdBMHNcwb1oYDJsLwnyiJ2GUf/C/wmB0at
 LqZtCtRROBv+TXA//bnkKDRtL/nsjwA1oOhztH/wsUETIl6A3sXertxAucbXC7hGj+f5Gho4j/b
 7uje5+Nn98qHwigvekRrLSGQCMu3/Qb09xFWSSde3s4pf3vy+T7UcitDeVpCeqPIBFHwiAmRyhs
 Mqxv1NQfTmlxkryQSSa1SD07xJ5MrEOHjkNgRRNs/DslJRsAlFpuJ6ddbDNmVGQEKPASTXQ/zkj
 g19CTgbaAwYb8o+LG04RR6aKoO904i/60mMhu+brJcECjr6csGihdrCmpQ/ZDAxHURXvQ2w46Uh
 iFlIXUkSH15wuWYfcuTcDJJxfPV9KSwLs8zMb83aixuGmU3zwi+7A9n3ZSfMi7kHE9orBQ9QIC6
 ghLbGmncUW7LCCECu+qPHQ1371YR3ZcYMGaU9QE0FbYlLGBf+OKv9teO4GpZ7LFFgcSHJuYdxTT
 AjrVIRPGgwSGVA/58cdb6TXVbYwTURcy2Rc/GIfibvg==
X-Received: by 2002:a5d:5f92:0:b0:48e:44fa:251b with SMTP id
 ffacd0b85a97d-48e56f6b2e4mr3433564f8f.47.1793099442960; 
 Tue, 27 Oct 2026 04:10:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3c5bsm22859383f8f.9.2026.10.27.04.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:10:42 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 11:10:41 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e7
X-Gerrit-Change-Number: 2039
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2039?usp=email>
X-Gerrit-Commit: 80382792dcd05cc4467d4cc287bf6fc8d8a00817
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 11:10:41 +0000
In-Reply-To: <gerrit.1793047006000.Ib40b439ad84a08fe6d5d4407da18ed78151327e7@gerrit.openvpn.net>
References: <gerrit.1793047006000.Ib40b439ad84a08fe6d5d4407da18ed78151327e7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQ3MDA2MDAwLkliNDBiNDM5YWQ4NGEwOGZlNmQ1ZDQ0MDdkYTE4ZWQ3ODE1MTMyN2U3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <91199b00aa45d7a6b45199a9391b0fc14f6296b8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLf4r-000000003Pr-33K8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: plugin: detect too
 long plugin paths on Windows
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5737425501018413596=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5737425501018413596==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c2FxMBw98FI="; charset=UTF-8

--c2FxMBw98FI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund, Lev Stipako=
v=2E

Frank Lichtenheld has posted comments on this change by Heiko Hund=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2039?usp=3Demail )

Change su=
bject: plugin: detect too long plugin paths on Windows
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2039?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib40b439ad84a08fe6d=
5d4407da18ed78151327e7
Gerrit-Change-Number: 2039
Gerrit-PatchSet: 1
Gerrit=
-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Heiko Hund <heiko@op=
envpn=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Tue, 27 Oct 2026 11:10:41 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--c2FxMBw98FI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund, Lev Stipakov=2E </p>
<p>Fra=
nk Lichtenheld has posted comments on this change by Heiko Hund=2E</p><p>Pa=
tch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin:=
 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2039?usp=3Demail">V=
iew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2039?usp=3D=
email">change 2039</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2039?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e7 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2039 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev=
 Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 11:10:41 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--c2FxMBw98FI=--


--===============5737425501018413596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5737425501018413596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5737425501018413596==--

