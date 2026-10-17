Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA75CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sxtdvroG93/C1Psgfbg4IMBecuBNDxb9BVyoAaGGymY=; b=kWnJ5Ml/wwEHdDisVfqNNGFBs0
	UkwCW+N7aSmbuLi6Jf7LyyoPoCkPNMHJ0EShP9HLLdPFhNLbm4CH0WJMnUJNkUXmXo4kJCvhDIjSV
	BCTStyfzC/bPtGwsVxoH+JbCaxt5KDNO47z6oZ/rwFALt9+dAJb+OQ/CHVh34RSpW+8U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIAGU-0004vY-6t;
	Sat, 17 Oct 2026 19:40:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIAGN-0004vO-PG
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OjmjdJKpMA0BFMCchg4m9Lkjija84XFCL6hrO6AOw4U=; b=DlTiAlrwoRru8mTx1nwjxAHbhA
 lhn8rg/FfKe9iH6rfT2IUpKOr32l1ICrmGfyORGWWwFDZAz0pV6YHnoIccVvgt7A3W/d5qVcQgtFN
 SR+3XUE+cXdumvbvsbwY+x6giAp0Hq4qq6jpwUrjE8LCpc2aFtgS3nC7nAvwNN2YKCws=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OjmjdJKpMA0BFMCchg4m9Lkjija84XFCL6hrO6AOw4U=; b=Z
 kcFvr6OydVReZapJ6e9ydxmWS761XwR6CzOP7KzYJ2nYZ6xWqw1s6LNo960PXf8Zc4uFBLj5NBs4S
 +OM9/MKhMiZOcFOXzT/sCT5RpymD9KcCCGNu21E2zl2d54tBKAXJ7A/XTvi+BfK7B6xf1XgYOsMdB
 bzQY30BwPx33NsOE=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIAGN-0001Db-QX for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:40:16 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so361256f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792266009; x=1792870809; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OjmjdJKpMA0BFMCchg4m9Lkjija84XFCL6hrO6AOw4U=;
 b=T4VLZouInJLDSEG3cvx+rnDHx5FdD95ouZbC3uUHooQgECtJRfMUyyIklwTI3xpM9f
 ndx+F8RgKRd3v0FLBDgWnU8r4fHTY9ZJ+QgbbVXdrjba5C5cWP38FSsNKd4UqhlYz8IR
 ry+zg2PdC9uPRRToy0fo3X3f0HBG/6O8qyj0xb34EfycsVoDtGLiVv7hqW5nAXoRWqJy
 6N4nvYlg09c09xRz9AleucEDFmQxuq//T8PdA14BhB79yJvn8LqgVP9GB39VAO1C2TVa
 HLZAmK1QeQUpdgI/49USQmzpTYEftY5cO3nGE7sSVfc/1plblxmspL5YkN/MLrYEprxs
 NqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792266009; x=1792870809;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OjmjdJKpMA0BFMCchg4m9Lkjija84XFCL6hrO6AOw4U=;
 b=ohvQoEuKvrpFhInpwkMUVhQdv0XCURB8K4gSm718mi7i1Vyw6/hIZ86oa6Z68KKrwr
 em/wltWFmZ0riGd+k3PpzXQ1geCzzInN5J5QMmoeD5f4mLpijex4uegq8YvNF61n2SYz
 AP4JP+fj8EMK5Y6m1pRHybAk8P/SmPfHyXE0qjxcx9X+BbV72QwHDWgwksaDacJJCvKr
 TgYfLzOA0vgnfHGNcPzfaVAe931x6XXRtVs78TuuPektEvTcMczREsbPVzgVqaNxBiqa
 IVU74Eic3an91fWNfXdv/vUUdUbwQEEqxcaGFP9lnjG0Zro7BsH2/5MauYXR2znLxhnE
 TW7A==
X-Forwarded-Encrypted: i=1;
 AKwUvByHpc/hrOHSGEtwYq3sFummUS93DuqVw2WnTzAQwjQqHifEKJ9Qn71+K9aEsBELobJ622y+WB3xPDiOkDtO@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIti+CaVCrZn9yLZSopBpptDcrL6b80lHW8Y4BW0FI/Cip4ke8F
 hyOKfsdvnYjBQVkjiYbpegoC06+4096/++TiWWm4Yc83M7+Twoaw/n+yzOQANgj658RpVD2347W
 rz8MdpGHtFmdQugFE/y7aJx/XvEVeu0m+rTvZiB7MZMqt2yVEUaWNrMDBHpNnz+efGcdz
X-Gm-Gg: AYBFou0FEbIUmOZ8wBwSRP90FlqvA3jPQS4TPP57mDzXSac3wPWfx8KMakfnVaIO9oy
 F0+OwM5UcfMvywLCaMEnA6/9xJ80hHkIivHX6qg8NI6BZxwxcEWKzMz8mrUtOIKbkrRx1ohBkFK
 9SXQObH2lexYOm4LojbZuNbMb1Z7+2FUVC6+GjuM/Y5hy2MLS6mDa8bHyYgiHC55pck+/x+vxcN
 TQV9iG1jKcuDyvYWg4EVwHpqs0yK7LpIxk8GSoyi2TSRwAwLF0aduYZhM0VZKGJzkpBK/kfI+Td
 jiWZKOM91DGRCIgPqNfj+BGXkW0bWZMF8hCcMLHj6wiF2jlhH3/TnGWpe3PLBloV6CN47l1jw9+
 LifYvNfPkudWNmj7T1JoVyJWd5PYV1ZnQspQFygHp1HsZ5GKaxufn2U248ES+MzIxw6AaGHQ/+P
 Al18cc9xZksCvMxAXGQQpLYp0OCHeVXeL783eAPEt9gKqKiM9B50IaAKdagQ3knD3ldSargIW/F
 Wyb9HJtxYeMeCklWrLvPY0ELIW2TVrTHa3FnK07fFNEPN5J5v6w0HSTsPj/3hR0YkIduXY5i1V9
 ppH76C9VG353JTI02/znjBK5sPmaUIU2idR4qnarcjOPaWEjjxCRk2+/kLjo
X-Received: by 2002:a05:6000:2910:b0:48e:82f:48ef with SMTP id
 ffacd0b85a97d-48e082f4c8dmr6604776f8f.13.1792266009157; 
 Sat, 17 Oct 2026 12:40:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503a0dsm13041859f8f.47.2026.10.17.12.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 12:40:08 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 19:40:06 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56
X-Gerrit-Change-Number: 1989
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1989?usp=email>
X-Gerrit-Commit: 1de32f2dd580991bd29b7d7312b19f244243e416
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 19:40:06 +0000
In-Reply-To: <gerrit.1791561117000.I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56@gerrit.openvpn.net>
References: <gerrit.1791561117000.I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNTYxMTE3MDAwLkkyZDVjZDQxYWQyZTQyNDUzMGM3M2E0NDYxYmRkNGE4ZjUyOWI4YjU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b8d2665f60630da477ad8be3584417653e433b89-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIAGN-0001Db-QX
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove support for
 pkcs11-helper < 1.28
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0648724056568439794=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0648724056568439794==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gfBQDXBV86g="; charset=UTF-8

--gfBQDXBV86g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1989?usp=3Demail )

Change=
 subject: Remove support for pkcs11-helper < 1=2E28
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1989?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2d5cd41ad2e424530c73a44=
61bdd4a8f529b8b56
Gerrit-Change-Number: 1989
Gerrit-PatchSet: 2
Gerrit-Owne=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Sat, 17 Oct 2026 19:40:06 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--gfBQDXBV86g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1989?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1989?usp=
=3Demail">change 1989</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1989?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1989 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Sat, 17 Oct 2026 19:40:06 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--gfBQDXBV86g=--


--===============0648724056568439794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0648724056568439794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0648724056568439794==--

