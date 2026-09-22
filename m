Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8ADC98304
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ON1AP/4xKhMaAFp/4YDCm82R/pzQ7si33Gg5fCbuMrU=; b=LwkWD/SGCLDAOMZfteJjXMelYw
	Ch3TFdHyP2rQSo+KL3Ie+jML4vSHLSm2v4bPNv1MACTfrit2HtgCTfzoBH2LEF9eV2YabODZ9eTe7
	okn/il94FxYNc3T7j7I3aXrmXdLJHjFnRL5AHx8H32lDSrZkkycyyCd89a7QHzN7CoaI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x90Jv-0001Hp-M1;
	Tue, 22 Sep 2026 13:14:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x90Jt-0001Hi-HF
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:14:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HtHEmJFsVVadgBkhOE7zzOHFin4SNzFvR9pxNQRtvtU=; b=GE8pis/xwfTgniJd85LhmLgOh6
 fIOXAm3MW2hERKEB+6RO0cbcpOGp77H0DHVQPys34IVeJxslqYuEt50Wm4A5sW9XiOpvgrrwXAhCd
 KhmxQJP8CVwDHC8S5cEx/x7eSgpg6ObWBzKo5/1ISrrAEMX59tq5/oWCZQKUGZaL8Tog=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HtHEmJFsVVadgBkhOE7zzOHFin4SNzFvR9pxNQRtvtU=; b=S
 C1DT/OjQtOZBat9IsbzxAi3lN7iNPHBdG104CXw6P0HFt0Geyr8OgKejEGbY0RoNzLhQuiOIYufzj
 CtUpXQ5dX9QG6DsPHrV9WYDx86gOtnNCEzshUFRGsieZPMo1m8VUiSv8KliewpcxRTwTupK+Q1HOv
 03r76eRagOV8ZZgw=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x90Jt-0000jC-Cl for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:14:02 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso36363795e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790082835; x=1790687635; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HtHEmJFsVVadgBkhOE7zzOHFin4SNzFvR9pxNQRtvtU=;
 b=I4pZ+2LjyChogyg3CeQcvB7FD1ChyoFv0sEAiFd76rKybb6ABOcJVd/7dkOmCcDFjw
 bcURVZIzceaegcCqpnLMjVqNEJhF+mL/0YdEw7/zqECZl1R9jHWLBAfQRxbaqL4Zq52M
 3Mo5i4D9NzUVqkQn3jxfFe+VVEMFue2dc56Wpv2MDohlPKjBFgOgx/b6z2M0m4uNtsoP
 ycxe1EUInxOlMjT0GiVm5FrO//XNFJAczdvPIMfUasX1jl1z5mwhChYoGEwYs2BhwclD
 LzxTZKlPD+xtWSR9Grpy6DXbRjQ6AEZ4/3TmAdxeldfFFdFvmUBz0C3sXql9HW8wB+vp
 VANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790082835; x=1790687635;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HtHEmJFsVVadgBkhOE7zzOHFin4SNzFvR9pxNQRtvtU=;
 b=S1FRoFIbTJksDWOrCEM1okG9JZWikEK3PdHRgUoHrvrgTT2gRlA5SafNL3bqBfZTgc
 ygEQhFC6JNyZKoGHSgyJQzuRD9k2zJtYHvP6m6yaj8dJIch/TMGawbTHN1J8buEToWeu
 V5a8NnMBTQwsVwpk6B6fUV3wIxw/+2O3C1Vtg/dhr4bMwkr8hTokok2CGQOvSyrnkWum
 K9RDdnJFn8lXM/PGqfVpZGya/tABdumqkHxc/rJ7bCxMkdX4ojuPybu1RHG4TRwQnfV6
 CUdHEu7mJ1TK+LJDqELG4QGX009USVoqVTs/1CUerkUU9Q8Yfy76GADCDKYKV6fugIBK
 GZUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBPe+LhL2S4fOKa213fbNnLa6uS+RKcN2Jw1NaQ+YEJecRN9YcbK/szG1LOk/lMWV81Zp1afVuki2/L/cx@lists.sourceforge.net
X-Gm-Message-State: AFuF++nM8V4xWteCJlKMRPOnpMFV1+qvyGzWBtZ+JU+5S0KICkpIhXgU
 n5K00XAARuBiSC1MwAIDU36XI6ijpAgRPy4hLDzvvVpkC1iZWBMJTxOyxj8Nd7TRBnEHOGr38a0
 U415Jkx3Pr/GPuCSQyMLTGKtKN/EokE61L1aE3gSfEHvQLTob6iFhKa2O+h/Z4aJ1EmdJVHhO7t
 wZfSIH+w==
X-Gm-Gg: AYBFou0LGZAHwnsfzlWas0MGo9IG93os6WYWTadlu9G61OGWwSBmI5WcByYZqx6chxJ
 2fqXSpTYDP8bIDNAX6vZjkKLeFYxSHvNVGrHyk5BwSO6qjFkeYj2R7zXRzpqUv3JIDQyp8B+oE5
 xWEFhgCq7/pAHXmE1YNHEsQSuPCEFmGFHZBi88/POvjNIbq/lJwZKI8D2hz53g2V4HKH5a83KN8
 IgxQmzoaGsn2xayrBimjX84OLKBrDvKoRwj5XpAHWpOwAIM5DfW30XxVhAFkWlyokJcd8bWW6CZ
 rgJnd6Os0+lnRddaGIqPEhtYVjHuRyo24RDM4pclLggQfYEjNbfpIeWCOBm+lze9St0RP3vtf0U
 Md1KinVAyaUb3QNSUr9TDJrBSfPkuB2/tuYSFkS8LxjJ7Aqlzu+xVDw5vhm6dV0uP2TmF+I4yc+
 4RHjVE4cxBf0/9/hFOA/xNrxSbyhLu5McI984aAJNjw/HkQbBpYJ4ASNmywfuEVyoY57wY3WBQB
 1N25xcTjB5k/QeHROx94VZycxkpF4mWP96moj6yXt97g+08W09Mn7vXHirPwr04j6+RUWedAvn9
 Nc9zE+ELfCCcScL4SVG2VDtbRynjkWEiE0hE0S+UiBQGkahNQqytIWLrHeNFQsv/n4ruy4U=
X-Received: by 2002:a05:600c:19cb:b0:49e:8184:f619 with SMTP id
 5b1f17b1804b1-49fc57410f2mr196405915e9.22.1790082834764; 
 Tue, 22 Sep 2026 06:13:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf8a0bsm38339895e9.3.2026.09.22.06.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:13:54 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 13:13:52 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: f2f3c8f0f1f7612b34b4499ae43b77677faeda8a
X-Gerrit-Comment-Date: Tue, 22 Sep 2026 13:13:52 +0000
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <952f447365a5c17b66b4eca7a4508aa7a1d2f799-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x90Jt-0000jC-Cl
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change most
 ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL
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
Content-Type: multipart/mixed; boundary="===============8222827233249102176=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8222827233249102176==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VgAZ7xl9ee0="; charset=UTF-8

--VgAZ7xl9ee0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1942?usp=3Demail )

Change subject: Change most ENABLE_DEBUG ifde=
fs to ifndef ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/options=2Ec:

ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/9ac3ba5e_646c8e2e?usp=
=3Demail :
PS1, Line 4232: !
> For consistency we probably should change th=
is and other occurrences to `#ifndef ENABLE_SMALL`
Done



-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214=
d27
Gerrit-Change-Number: 1942
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Da=
te: Tue, 22 Sep 2026 13:13:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--VgAZ7xl9ee0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos has posted comments=
 on this change by plaisthos=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1942?usp=3Demail">View Change</a></p><p>1 comment:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment=
/9ac3ba5e_646c8e2e?usp=3Demail">Patch Set #1, Line 4232:</a> <code style=3D=
"font-family:monospace,monospace">!</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">For consistency w=
e probably should change this and other occurrences to `#ifndef ENABLE_SMAL=
L`</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">change 1942=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f96=
cd1c3488b558b8a597594d99edcba1214d27 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1942 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Tue, 22 Sep 2026 13:13:52 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--VgAZ7xl9ee0=--


--===============8222827233249102176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8222827233249102176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8222827233249102176==--

