Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB20606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CAppX7Mj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=L4458vSV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a3xJbsPa;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SG9kyvjS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iC01p8rvEevYPpReKMtP+yilZNpQBbmuARCkWMliCas=; b=CAppX7MjNacFuj0BE86M01V0c8
	RU/RM0fptUu/Qdx4M4s6bohZ0Nd1IwqkC2ySf3n7vQskl4MsB06peHArV4/y/23RIRUVkL0cqUKri
	B9Zj3BlJVos6Afs6L29lpJh97aoxOaLyk4tUDFw20Xt+eXrp0p2SJF32tc5GQrUYVHJo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT38D-000000006Me-2Eza;
	Mon, 16 Nov 2026 20:16:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT37u-000000006Ke-3qMM
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 20:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lo7sUW4dOj62hVwf0GpCA9kAtnX8ekh9mEdzFVlXLbY=; b=L4458vSVQdqI2SrnMmGxD4M8e2
 Is35s/uoL3u27xMjbQCbIvB7xQUIaBu7FWvi7BKTtrq7w7id8TpiheYBsKc3ePMgOfPi5OO4EJZLV
 sqdgVytU0Semj7Fr9HHmg+Vnox0DlS98gW1YkC58jlrfWUX+UG7MUbpVNmU1SZxtmlVM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lo7sUW4dOj62hVwf0GpCA9kAtnX8ekh9mEdzFVlXLbY=; b=a3xJbsPaP1RbYwb+6aiMxvTQPY
 oUWcFQzgTydhk3DiyjqU9+izPC7a+/r8mgQUhpisFG+YMTTg/FsXSWLSDHkHWYDsG1ffw2+pDlu2J
 SuBXLPsiNjcXzPq1IZsxpIm/t4HP49bO3k5NvJBtpW7mc8QNvin9JmDj7t+J+npxuM+c=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT37q-000000005dF-1kBS for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 20:16:29 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4919a880834so2005084f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 12:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794860180; x=1795464980; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Lo7sUW4dOj62hVwf0GpCA9kAtnX8ekh9mEdzFVlXLbY=;
 b=SG9kyvjSkaO4k4Oo3+phN6BWwHykFExEqEHKCy0U+fUKHNbQV/DZHZCA++JY8iUT5z
 tlLuPjJJA1y4XVIGn1ltPJs7Hml0E13+KlM78Bqv65cTTKFv8/EqeKQE6GPJ+I4J7va2
 O/g814b90DHhdRzwzvCzcjA0+VsEhiQmSpQ7eeKK6s1ftBYkLMPGronyvee8OcSai57/
 WFTX3BevBBatXFRIea5cg8GNlzGLnFcNb7ljQJ0PW+rToPLz53T/dYUaRaBmuEXAgPen
 n/CZ9xiLGHUe+FNtzYqkjPmb4C8cZMsjvdyDD6iJ9PtNM2WXhDVmdVJYXhkSEGyD24tC
 PJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794860180; x=1795464980;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Lo7sUW4dOj62hVwf0GpCA9kAtnX8ekh9mEdzFVlXLbY=;
 b=p5qdk/iPROIFdzsAYLhNmfYU6pEVS33YCuLauVmrWuzvNpsX0wPTzYjvn+0zrm/sZQ
 NFtHL+vCSskUN8m+uumcLLPLELaDNE4bLtQ+Y9vzmyt/Ys1RWLRDQpxeT7zQ38+1ndgO
 mYUzPANxGA+yFWQAPKpUnsBQr4JAkQOeSossfaqMbeYOT2nsFVgudJXiuBcff3AlwLBF
 t8errro2SzbmOFWLbKCfSlZUHMdgnJZ8yV+au22yhKRc+MkqNKFsx9h3n1DdvvYKVwnp
 rkPapG4CbrL79MTThlUkI+NAsX0pmewdya71kzDtR3CRWypzuLDHt9s4hTwkzSSLUKPd
 0emw==
X-Forwarded-Encrypted: i=1;
 AL+hErGG3jI/ZUo5zzFuWA1D8552TCibpIhnApciTFvYWnmLdsSqLtvn84l9RZV3ahy0bypgEn4D1opor18thCda@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9758j8+jYGezmLJtCUg84zCevx8dGWup0B3B3qdtP9VJ6qJo7K
 gydNYjl1LgI8pHxxqNCEUvpgmaFg/fwhlZ4bYwNy80NXXnXGK2dfLccrejTIbIfZVAoxCYFmCkq
 LmhZSRdhzb/GXEg6CuiP6fS5TucVAwe/oQ12M63G6ZzFLtx1+ZiSbcJrjsz+Me+is6BdM
X-Gm-Gg: AZFdTZefDEw3tlf1YmwFrgFjSovXZMOKuq/LgX3g3g8mfxrC90biP29r2ub70ZvPZC8
 3NXW8CujPPsrBP0E1yEUkvLTSm4hh1WO5mwS+rKEsLnX2HGZpFlW4ujNlnINPGFQz31XDgHN+QW
 90wcDcIHBnzFfUZwL+FYL+U+t6Znp6bia0AhwmoE75cmIB5XwNviYHjLusWQiMWQ2po2IegIBQE
 1mJqqolpRIMV+Z0JWO1uFlg+ONe0FFOtNuFyOGcYOLx+jRH19XTrS+wUagtN6Zh9x5JgXYkrV0q
 bo/OduY6z/i8rkhxdy0+nAEPBmqxA0dFLT5SJwhVttiDoUnsRZE3VOTQN5hHq7wkXfE8nCQHBWY
 RbWXd5FziumxaIMm2Sh9JPMTUDsBQ+8V8AuFqxMZu12uUCCcXVNMSfOtspwEOMAjt+GZxFi07My
 QHTagiCUFgzKMAGLQ8FMS3V5d3yC6ed1HCXubD85vYOnu2FnFhyCFKiiSFSNE2vnrjgEeSdM6IT
 zItNOvaq3nFNZGne2kWkteKS9Tuzu4jAv/TdFxsS2FrNF9uTekmKZPlfi1myMcqzPzdQjknUh7J
 ZyWMXfqjAkOZpR/E74hFd89HinSvJ+f9+MPNUl4W2JWe0BCfnxeXsQ3w/73P4dUYBy1s3bPr0MK
 v/3ygqm5/NidVbFCyP4zIRztAvBPgUU3qsqpOCDIlEIXsPkftxJRatmJ8QpTHj1soJ5RtsRrlgc
 SQoIseAA34CtzyfUU=
X-Received: by 2002:a05:6000:1ac5:b0:490:71a7:6f3c with SMTP id
 ffacd0b85a97d-49c7325b963mr27913564f8f.55.1794860179602; 
 Mon, 16 Nov 2026 12:16:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm24309191f8f.49.2026.11.16.12.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:16:19 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 20:16:18 +0000
To: Tommaso Bailetti <bailetti.tommaso@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I831224f06e2f35bfcc9d0fec7d8edfc344c59406
X-Gerrit-Change-Number: 2201
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2201?usp=email>
X-Gerrit-Commit: 4943e7483a235cc2253817d1e4a607fdd9c421fa
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 20:16:18 +0000
In-Reply-To: <gerrit.1794843268000.I831224f06e2f35bfcc9d0fec7d8edfc344c59406@gerrit.openvpn.net>
References: <gerrit.1794843268000.I831224f06e2f35bfcc9d0fec7d8edfc344c59406@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODQzMjY4MDAwLkk4MzEyMjRmMDZlMmYzNWJmY2M5ZDBmZWM3ZDhlZGZjMzQ0YzU5NDA2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8e6f2ddbd8bb0dfc8b37182c16f32cff75d0192e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT37q-000000005dF-1kBS
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco: always print
 the status block
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, bailetti.tommaso@gmail.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5625063007124288484=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5625063007124288484==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mPEnBO1tST0="; charset=UTF-8

--mPEnBO1tST0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Tommaso Bailetti=2E

An=
tonio Quartulli has posted comments on this change by Tommaso Bailetti=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2201?usp=3Demail )

Change subj=
ect: dco: always print the status block
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 comment)

Patc=
hset:

PS1: 
This path looks good=2E Aborting when no device/client exists =
is not helpful and makes the behaviour different compared to when DCO is no=
t enabled=2E

With this patch we simply abort the stats update, but the mgm=
t interface will still produce its reply with the data that was known befor=
e (most likely 0 in case of reconnect)=2E



-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2201?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I831224f06e2f35bfcc9d0fec7d8edfc344c59406
Gerrit=
-Change-Number: 2201
Gerrit-PatchSet: 1
Gerrit-Owner: Tommaso Bailetti <bai=
letti=2Etommaso@gmail=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@ma=
ndelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: Tommaso Bailetti <bailetti=2Etommaso@gmail=2Ecom>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 16 No=
v 2026 20:16:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--mPEnBO1tST0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Tommaso Bailetti=2E </p>
<p>Antonio Qua=
rtulli has posted comments on this change by Tommaso Bailetti=2E</p><p>Patc=
h set 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2201?usp=3Demail">Vie=
w Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2201?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This pa=
th looks good=2E Aborting when no device/client exists is not helpful and m=
akes the behaviour different compared to when DCO is not enabled=2E</p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Wit=
h this patch we simply abort the stats update, but the mgmt interface will =
still produce its reply with the data that was known before (most likely 0 =
in case of reconnect)=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2201?usp=3Demail">change 220=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2201?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8=
31224f06e2f35bfcc9d0fec7d8edfc344c59406 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2201 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Tommaso Bailetti =
&lt;bailetti=2Etommaso@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Tommaso Bailetti &lt;bailetti=2Etommaso@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Comment-Date: Mon, 16 Nov 2026 20:16:18 +0000 </div>
<div style=3D"d=
isplay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> G=
errit-Has-Labels: Yes </div>

</body></html>
--mPEnBO1tST0=--


--===============5625063007124288484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5625063007124288484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5625063007124288484==--

