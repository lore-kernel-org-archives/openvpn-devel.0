Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFC6C982CF
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8DfI2J+LnnNv8koLFauaUz67Bsjnv16TQg3uuiaruPc=; b=i4mCXj98mjj2GRbtfZj9DhjBa4
	A61ax/vFrNHF4ANbZSs6RFEJM+M5SO9DDnPpTMKZief9bqqKp/h9PIZ7y/9wZqoEUqjCYq1ZgNaX1
	DI/zxJMXDbu+6Fl3kPvmqTsL+/a4kvOt7rTtBOvmNnnw6B8KfP5Gz9BkppuSue5jCFXY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7C0y-0006cr-DO;
	Thu, 17 Sep 2026 13:19:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7C0Y-0006cU-Ol
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:18:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YKc8feUVZstla9B2cLTsSilAEqEdoO8RXrnOfXhrtOo=; b=j2iWlHcflq8a8n+CQzpb3vVjf3
 9iQP4nsIz2kTrE7BXbdmhz2bGCE6P6kKjQ2jsbASkze2LgiJH+36pcT9v2VF9kIAgcNRjB1A+POBa
 Y0OV4kn5u39mRvIO1ISai14tslPVZDuhkY/tC5rVixkYrKCmEa9hmPkfBii8mWzczMnQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YKc8feUVZstla9B2cLTsSilAEqEdoO8RXrnOfXhrtOo=; b=M
 kz6egTe7Y5ejrVCQ5y1CtY6ekeEiGS0st+lxZ0l5INuAsMV4UFscg2qIpAngInX0IlYZfmTJnU93E
 nqa4InfBxLOMbBYqi8gNKChQQ8ezkcOALwIEb6ZAyVLE8kNqGMA8b9/x+8ipCqDILOLCYch2nQZQx
 2LbUB+UIeeIHZ0YA=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7C0X-0001YV-Cb for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:18:34 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso8161575e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789651107; x=1790255907; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YKc8feUVZstla9B2cLTsSilAEqEdoO8RXrnOfXhrtOo=;
 b=TFCcQuE0BWCtyM1n/kZo3/1uKiMo/+EO1ioHaK74eobNL3nIL7xM05b8QANe/RC4H4
 F7T11PJGaqgz+qqAL4m6xG1sUPlwzMkgGSyIoPBZeHirm63BbahZ0zAiL/TMvEQbvTLP
 QKVk+M7wsRRL7oAhuxGs3VsOVsY1XTfE9yLIRSZWG37auCLhZ2GCz3vGADWMQJ2pqFz3
 kPHYhEuXbYUcDlnzBOyE/I58lY9M3d5Hk3GUm32hnNq/gmyjdV8fF3Yvyo4qwZGz8U2D
 aFigHDXfd+W2O42xxu2uGNPatmQSaBTYp7e++Kl1rk2uKbIvWeu6sNT5+A82wjGobvOK
 5JHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789651107; x=1790255907;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YKc8feUVZstla9B2cLTsSilAEqEdoO8RXrnOfXhrtOo=;
 b=ccRH7SgCiqPD5TjaWIBSamxFOlZEvBtK/KxoGzGEmWqGrExo/WLFL61m6uCOSdBG7H
 pK0Vi3scoAHeQPCf0qwZR2phxCcxMLMMw2h29YJk7AOmPOQ6Db0MlXxeRqh7eCSU3871
 JXwbNuZe3axhAnl1H31igliq5bYgMQVKL/4hpo1tWx8LoY07+cEOs9nNBmctdEZNV7Cs
 o+7L+zllo3b14w11I9ftPCul8aFGmDNufymG/V+IHh1N/g0UycnjyaWm5G8ansD8RlgF
 PYMiKuuj/UGNN+d1HBbJr8+lE1oY8qB7gzyyp9I5EU8nBJ4l+HdnZn8rJELVE0E9GSUg
 RFkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhOF1MVnAL4QPczNC+zwLJ5FdBkSNbUxuiUWmkSvI45XXHawzVmE6Tw+OLv3rVp254QIywu8NE74XdRhPG@lists.sourceforge.net
X-Gm-Message-State: AFuF++mPe+gaU9i9UdInw34t71LWMOLo8jdypWv9f0aCHHW08vPl1H5Z
 gq4FfLyU2/4zOb1WYPusQPIx03EhG8pV7b7trb/Wgx5wV1KrwRwDKGjpfllxgw9n3m7JETSoC9k
 cF43Zpg4ILPLKniW5oiOvGLNhB1iblNZ9SK8U+S1psREox7jd4mZwF+Rd527joA+vF5DC
X-Gm-Gg: AYBFou2+F1i+NEriaf27NGvGnAgwNYzvG4SXGt9Qo8bjsL5kV+GmWFJJfkntvRyztPF
 gtX2X6BMUS2HOw4Wl7SrLQqg2gZPITi/wBveN+F9X1n9R7qmakIbj8k87OnQSW//phsy6SK2KOQ
 pYS5It/t2vivlVCJoCUwqJOSCwStHx898aMOawUcXNQO+3AZG8NTjacCbDfQZw8UdxuRCkEmgoB
 EPZLLwnyLxvWkOfh81nhDBuCMRw6zxTZ5x8i6Ph41NHOUpLDu+j0lHFQHm5Yj0eyFfT73oxu2aD
 Iyf5xsLqc+OcibPy1Z9Xq8YO3TFiVYB5EczGfob0SkiJwD8+bXbvnAieMCNlwgzu6QGNy/6EE9l
 01ozY7Zf2n+hFfJmP6dE/PTos1RheRpzbKBifLQ8vkJhx5x3sBzqxRGtGAX8MexilsXmeXfYHbY
 xcoRPz5Ryviz89nDhx/GqX372Vhfa/FM0VQ8O5bltdKOyE0T/lg35TvuTSKW1sYKdraK9KDRqIF
 zHs5uF3W3FI33j/7XjP8vFKrMeNn0WSUeLb608BqDLcoiJr+/OwXH6Z223Wr/hL73wCLjUiC0n3
 bcQewDkj7UZxjhjqznk3yifzDR1HJfms7B4BXt+r/czBvWQ98jTS0OnynVnW4A==
X-Received: by 2002:a05:600c:6592:b0:499:621a:2ec2 with SMTP id
 5b1f17b1804b1-49eac45b886mr89163975e9.3.1789651106731; 
 Thu, 17 Sep 2026 06:18:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd32c5e1sm107608285e9.5.2026.09.17.06.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 06:18:26 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 13:18:24 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: bcdd99a8207292c164e7da5ac224e248b382e7c0
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 13:18:24 +0000
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7c58776380dc7874e484b78989c04d91462ef30a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7C0X-0001YV-Cb
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Probe every
 resolved address of a remote
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5525060798031418400=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5525060798031418400==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j23CFuuikJw="; charset=UTF-8

--j23CFuuikJw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1751?usp=3Demail )

Change subject: oob: Probe every resolved add=
ress of a remote
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 28: Code-Review+1


-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1751?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
Gerrit-Change-Numbe=
r: 1751
Gerrit-PatchSet: 28
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_=
lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Th=
u, 17 Sep 2026 13:18:24 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes=


--j23CFuuikJw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 28:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">change 1751</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00208610=
e0ce4f3ed9a87233e68ece1b3b8a768a </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
8 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Thu, 17 Sep 2026 13:18:24 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--j23CFuuikJw=--


--===============5525060798031418400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5525060798031418400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5525060798031418400==--

