Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223EFC55ABA
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TrcFAhTy/U8be1lK+Fg/gPGoRbIly0NPQlicF2wP008=; b=C4VrOAOv9GwKl1acWHVORnRPcs
	32MyD7TIWN5IwLR6y779lGoAwoIlJgu9LuNP4ZDu5LzRmt9YlQj7GMcJN4oF44qlR9cUrGuuGupWN
	fF8ZvI2hQLn2c0UrVGTPTX5r9BKk/5QWdSz3b6dRZRFnNYLi6ItJpEfOKPpbScHdVFOA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrcHC-0003Qf-S5;
	Wed, 05 Aug 2026 14:07:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrcHB-0003QW-7x
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 14:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/QnFHMGOEGIB83E/3TqZ2Arhz48nHgGbeTUJ2YZhmqg=; b=Fcwzl37Rc82aN8NFV5ZuvnTk9U
 2Rnw5nSYkcGdfVMC5OFiBd8iNOayTXi9R6t9dJOih3El1Dkf+OIJ5F+cePSW+1SpiOOhVTg/NyrK/
 I/VekNBuiVxR7OjwHU+cAUyS34IMCIKoOfo2XDSsdaCKq3NTMywWtIhWk+0k9zgw+41s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/QnFHMGOEGIB83E/3TqZ2Arhz48nHgGbeTUJ2YZhmqg=; b=G
 2/JyywZEVoUkdtKT6qIrXCMZgwsdTEXVa4xlrD3Kbx3Mz6nwwX434I2DOZhjGJg3oAfe15xAJFryg
 +gfvMNbHdvCIF6AfGvHM9dmYZkb53BTyCjuqqZHv9AGsDpbNGMrqVRhMiqhN1wqIiwO3CIHKRzxyT
 amvE+Jthb6xwY7GQ=;
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrcHB-0000Ea-E2 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 14:07:18 +0000
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso174325066b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785938831; x=1786543631; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/QnFHMGOEGIB83E/3TqZ2Arhz48nHgGbeTUJ2YZhmqg=;
 b=OZZLR7jbr+jxbkAYm5AQk0TMFjn+v7/DBDwOlEpZXE2Wt5N/oeMV+0FZMdWel1EB4O
 0/gqOQ7L+m6Oz4hcfSapbguYBmL2Jo5tWsxJjId3+6GRnOQ45nrk1ZaeTJDlk+S9yBrt
 qAmVCqCrB1Krek3Xkbpr7PGeYE3bl19v4NN4Dp9z9JWoUEQOMHVdZhhuTxo3JygibgRe
 XwPMbaaL/7r9lQ2UydihnsJnA2gfdt+V8/lG1M14MpMLEi6bxCAVw+mT2uhjw5WoCr7i
 ifRaZ89inhrxLKsK9tQ7n09nTur2v6LGcmDN7L8gY5hEaWZzfMc/V7TTrWtAixFt9DgI
 QK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785938831; x=1786543631;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/QnFHMGOEGIB83E/3TqZ2Arhz48nHgGbeTUJ2YZhmqg=;
 b=oUQkMYX7iiBtCl0vzrhwIjBCZnGoT/4xJE3xcuQfTlRHZr5q9Zo2x6b8NdeiwSG1DY
 FzC0FfRBKHjMqw2+CIJeZ6ZbQtR4002lXVNdWdDvuannuDrzp3F27MEx9XE4oKidseKx
 pl1kLU6UElihd2/HaF/LUJZ33RiXzY6xopMDvip8y6ve02HJsS2cCJQXxUd6nVYreqTl
 CHXnnOHeWtmS5fYlD00ShR1HFGK+ij1fH3KC0F+hUkcxVIR5k919Lf3lZAOcoF/WByv3
 A1z6d2Gsk+hCD6uMdPRAK/O5IDhFIAx8lsjYPO9m8bJHydnt0FES1x0iA4tw1kKDOnyz
 Rm7g==
X-Gm-Message-State: AOJu0Yxx3xh8JlMuqwrciDe+pYPpEkqLcLKG1eG1KSQAcmluTk0Yuksq
 R50Ln1GhALwHNDPnsemHNVPInlVTgPNZ9HSTrGFPA6HBnHDz9+a1XoBVhhbHwDqLdFwXg6E7dms
 3v0bkGCGE8RHuzXfqpGLqXuy9FkKSYGk1ydbEv1cFS5vORBfxOjZNMflBQXU79IEdBdQL7ImST5
 +LlBwusA==
X-Gm-Gg: AR+sD10WPE2wQ2iJH4Rv2+rd1XBrN5xkKQOsIgGyQsAHAwL0z0kV2Indco0vDizA/e3
 kje9mRbTzhhiEJ7WODmVEEw9TNSg+h+dbcrtiyEaQcnJKv0X2ZWT1KgknvP3Lr8mGj9lw2Xp3+X
 Bss531dEUMGMIki7zLyjMDkU1IQLtDOj/NORNptwNVa6GVIlqMOu1VlGii9nA1wnIMWsGX/XRaZ
 06IFy12I/698WNN2Du+aZE7RwY5lS4XxnMfhRBhSntkVtTgdT3aVwSlRZnT0kGbyoQQ0uwKE20B
 CMF6gq6Fs6TcH5dVs8mWuHthW6oRK9QrG2WoyJpmI/IdOQHL/pL8nxwVEJCec0aJx9w4ZTXmX+M
 dzCUPPtRoY0Ahp1aLAtjB6c1Tj/F2kUxpH6GQL7yME5s3Vjl1SsRV8iCZ9DAjcN/QHBSUeWALPO
 yiNSFg8vJfQooSWKkuBd2s6vBZWeUhBIbFPHXB3vWCWsK/oAuzz/QAvO2cPSI/LRid6geB9bWDy
 bDvxdGW+GIF43YH5Tq5e71VSuY/GKZr0RS5S+lZLUpAlev09hL+Y6pZLENyR5CmGbygXFwylIv1
 x+TRA0QFPs7/rB08bYLhO2a37SY1WRmub2GwtcRZj8ndktbARGCNPrvrPzq9mQ==
X-Received: by 2002:a17:907:97d3:b0:c15:e33b:8c4d with SMTP id
 a640c23a62f3a-c2039ad16a9mr360202766b.4.1785938831036; 
 Wed, 05 Aug 2026 07:07:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec24a279sm8827859f8f.35.2026.08.05.07.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 07:07:10 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 14:07:09 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: 0b8d09de0d5aafe99201f1ad7c26fe95d102f519
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 14:07:09 +0000
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9df9af89d883656a59ce250f97d7fb37f1034040-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrcHB-0000Ea-E2
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace SHA256 with
 SIPHASH24 in HMAC cookie approach
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4297277434333246501=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4297277434333246501==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2wTosfjmLtY="; charset=UTF-8

--2wTosfjmLtY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1827?usp=3Demail )

Change subject: Replace SHA256 with SIPHASH24=
 in HMAC cookie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 4: Code-Review-1

(2 comments)

File tests/unit_te=
sts/openvpn/test_pkt=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827/c=
omment/d54aaf7d_43adde42?usp=3Demail :
PS4, Line 440:     rand_bytes(key, s=
izeof(key));
should also use siphash_key_init?


http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1827/comment/4ffabac7_da54e325?usp=3Demail :
PS4, Line 522:=
     rand_bytes(key, sizeof(key));
should also use siphash_key_init?



-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23e=
abf04fe8e06d6fc3
Gerrit-Change-Number: 1827
Gerrit-PatchSet: 4
Gerrit-Owner=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Comment-Date: Wed, 05 Aug 2026 14:07:09 +0000
Gerrit-HasComments: Yes
Ge=
rrit-Has-Labels: Yes

--2wTosfjmLtY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 4:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1827?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File tests/unit_tests/openvpn/test_pkt=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1827/comment/d54aaf7d_43adde42?usp=3Demail">Patch Set #4, Line =
440:</a> <code style=3D"font-family:monospace,monospace">    rand_bytes(key=
, sizeof(key));</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">should also use siphash_key_init?</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827/comment/4ffabac7_da=
54e325?usp=3Demail">Patch Set #4, Line 522:</a> <code style=3D"font-family:=
monospace,monospace">    rand_bytes(key, sizeof(key));</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">should =
also use siphash_key_init?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail">change 1827=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3b6b=
b178ffb2bb49981bc23eabf04fe8e06d6fc3 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1827 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Wed, 05 Aug 2026 14:07:09 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: Yes </div>

</body></html>
--2wTosfjmLtY=--


--===============4297277434333246501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4297277434333246501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4297277434333246501==--

