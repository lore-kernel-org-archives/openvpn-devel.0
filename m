Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5653C55160
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BD1U3xmZ3sufXDs9HYced8CldXaqehqSUoRA4GQAZKw=; b=XDIFlflZTeSg7RS1VCHIzBP3M6
	gEu+SxmL7TPzX08kiib+LNxUyXQL/wKuBlBYf+yyv47/f+0Dy8+ehBTSZvkoKCOgF4uriXMkqmW06
	mUgw4or9yOJ6L4BkvkrIxnT0WCqpf5/fIuyrYlOoFp/V5V4NRIOiPmEkqbmpkC3O+XqQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpP24-00071J-9S;
	Thu, 30 Jul 2026 11:34:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpP1p-0006zx-5m
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 11:34:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=I+NI0z4qLEyD2Y3fcI5MTayAoyfCnhajPtwZPz2gEPM=; b=VNSueay5pwMCo7eqZT5Nk1+Myu
 +KHokVgKRu0L3Qa7mm4ktRmlSEY0SgL+ytgIE3bbVckI37633HCqjjKd34CUKm4et9IGy/7JOMTkn
 umgeiWGvXxU+DjCmBRuwLkVAqcvrVboTwZXqZraSFZ1pSv+vdvmR+5Et8e9SEKfxriyc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=I+NI0z4qLEyD2Y3fcI5MTayAoyfCnhajPtwZPz2gEPM=; b=N
 Q91r+RgD9wrInfhKHHJE16dZo4Wf2CKxhPTQ/gWcfBiPjRTmI438kkX9k8nJsOCaNsimBWaf21V+D
 SxM/qDl0k4s2+AHK3JqVfzHEPAtIYzPWNXOe9ck8z/92vHkUbAoMmfDmBlJp+Mvy6xNxUVh18bPzz
 7mM9HHZZNS+AcdaI=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpP1l-0007oY-Qu for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 11:34:21 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso22072345e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 04:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785411251; x=1786016051; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I+NI0z4qLEyD2Y3fcI5MTayAoyfCnhajPtwZPz2gEPM=;
 b=DWDsOmieNq/sArZkJip5r0PaEgdWCmQS9Mvl7Gt0jrLOj28ZmDa0LplQdUy+/CBvfS
 Q4YmeoSpzlEX7LPJzaChPZLdlD8OIrwel7cNpbLPEJxHRQYtmid5HFBCmt0/K5XIaw25
 0LxpejqwikeVcvO69kiNtIcWuvMVo0RPQZ8mM0e/GtEy5vAZPDSlgZv51btiEiHEs+UJ
 ljAtO/K4e4msKyZjEowUWiKBotsreUM0GIsT3Ok6vEDk2ZLOVTCMJ6DK87KMd3dFNQgW
 I3Du+8JDG9sa5v9hS0CoAi/4UvGqbC8lZmjwjUIIBiCt6/wQUs/KDDIrBLs6xCseASPd
 62FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785411251; x=1786016051;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I+NI0z4qLEyD2Y3fcI5MTayAoyfCnhajPtwZPz2gEPM=;
 b=nnn2CLaYDJCgqDgpuiZ5CkTLPMP2UoqRBKtfztxDWmqRgEVPDFg/eDR1X49bMxpQnt
 TpZHnxVyo9gdePVusOZl6xLRik4TZO3oVy7algH9u4tBwWLjyjDxH7+kC6WUl0wUBAVB
 MmnbPirAri8EBYpHDPvQNuYlSsv2wIIx74RULdaxZDnIjawPuq/gQDC/7FKQaAUsCAWJ
 x9fdpcMCFr1XMw3sqAeN4AGD/71YY42RpA+kBchU9Li3cyu+uHUfCwt4cKRXR/T/6RtM
 wCdrZk4lz5BFW6D4S9t1UROMz1mpVc+JyO0j+s40bVfqzmCgUjwXCI9UKmi5v0kD6Xhj
 05+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzEsckPAaDYXjsbmlouIoZtZUJEfuokSv4daRWNnyVSZ6inpirlvEq9P11fX8I7K6qnfk4dvlvhJIqPTLu@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzsscilcB/7/4epI1/K1uJDl3XYaygsOrJshfhfqlP0hBePZyqK
 wq1nQpzC+Q69uy7uCmtzHVHKVzCnYwMHq3AkOrbMwvqnE7DK6X2PxoEe2+MbIqrhs/I9PZQ5THL
 lsClJbvIur0fMKZ6GZ19TLU7U1gyX7iZnBrESiiJ7oElybx3+a1sXfuH9OAbbevO134hN
X-Gm-Gg: AR+sD12qQiVBoxJP2dS117MZyR+rojK5EhAv/1ULAEiNbXFKOlDawCdZjm48NUF2myb
 fz6lKPj1sFSgfXJXtaCat9jCk/y+jVJJRpMwt7op0NFbyBvHcB8552FHEEdpDa87DXluAQ1kZAG
 H/cHcJYBUTUdZllvFpJetBJgocCEKvo4RpBT8m27ozTdVbOr/GbUEOq64OOHYCCqWPQTd/YtNsN
 a/328El2ivQ0S/UbZ7QmXAnuMLLBpkSQmgzB+UWYRgHaFCDayU0xZnc9I+oPRgmw8TZ9ogLRlZm
 OvhtFUe7zNdy/oqv5RJLXZfhy8J4KiKjpENNq+NoUaHLuRFLNMypkAx0GYvb0iI5PY/49bw+v0c
 GsNHHN205z600xeubKm7Cn7Z4Zk1BqGyO21J7pe6nVzU/NydQCK10vmcfwxEEw0y9Ot2awqJBU9
 FlKxzXtRodOgDO6iMU72Fy0jCMZ9hoqoDQULoEIy2PVCbi/YBRnThH5Hn9J+M9Kcsi+7CUiNecL
 mPbC8frQafQaQTBkSrP4gKkNZVQ+eqV5P5Fln7sykodUxj9UEH6HG9zqkaqX741qCNupn4c5w0A
 Ogck5jGnPEORxyI0qlgB/9EzPRHY1fJxFKPE4A7FsYIRRkPOHXmY
X-Received: by 2002:a05:600c:4687:b0:495:4749:16a7 with SMTP id
 5b1f17b1804b1-49800e7afb3mr30043305e9.14.1785411251168; 
 Thu, 30 Jul 2026 04:34:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980120b42csm54044375e9.10.2026.07.30.04.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:34:10 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 11:34:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
X-Gerrit-Change-Number: 1790
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1790?usp=email>
X-Gerrit-Commit: 17d00ffc7d8c5851bc10f3b1c03e5c3c2badabef
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 11:34:09 +0000
In-Reply-To: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
References: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTUwMzkwMDAwLkkwYmZmOGQwYTU0OWE2NWI3ZGEwMWVhMGU3ODViN2VjOGJlYTE3ZjA1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3cab97603703e0a35e545a30dc4d7a24d07781b5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpP1l-0007oY-Qu
Subject: [Openvpn-devel] [L] Change in openvpn[master]: pool,
 multi: persist subnet pools via --ifconfig-pool-persist
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3381491308850883662=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3381491308850883662==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MOjrb12lPNc="; charset=UTF-8

--MOjrb12lPNc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

flichtenheld has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1790?usp=3Demail )

Change subject: pool, multi: persist subne=
t pools via --ifconfig-pool-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: -Code-Review

(1 comment)

File src/op=
envpn/pool=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790/comment/cad=
3d353_35e3cace?usp=3Demail :
PS2, Line 95: /* Read a persist file into a se=
t of pools, routing each entry to the pool
Mark as doxygen comment=2E Bette=
r than nothing ;)



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1790?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
Gerrit-Change-Number: 1790
Gerrit-=
PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Thu, 30 Ju=
l 2026 11:34:09 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--MOjrb12lPNc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ddd;">-Code-Review</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/pool=2Eh:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
90/comment/cad3d353_35e3cace?usp=3Demail">Patch Set #2, Line 95:</a> <code =
style=3D"font-family:monospace,monospace">/* Read a persist file into a set=
 of pools, routing each entry to the pool</code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Mark as doxygen commen=
t=2E Better than nothing ;)</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">change 179=
0</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0bf=
f8d0a549a65b7da01ea0e785b7ec8bea17f05 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1790 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@m=
andelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Thu, 30 Jul 2026 11:34:09 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--MOjrb12lPNc=--


--===============3381491308850883662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3381491308850883662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3381491308850883662==--

