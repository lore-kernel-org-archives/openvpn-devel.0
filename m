Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E994ECCA490
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 11:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7CeQ8AiB390VpFIiOFTMCljVcDtCGSIMFT2kJcNaHng=; b=CKd+rB7GcvuOEpdin2KwjtazdG
	E8OZpauiIoHNeGIU4L985rYwL0ThkWZt+Kx6D+F7R9I+urD+AmJHChGV9pS7Tu29exIjMTrrs0IKd
	MshcqdQVolMt2Qp6SCJZWhaAg5DEP7yh1TaB5wtbleasM/OKszGcGipdPsEHxwUnHS2k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIP8W-0004me-Aw;
	Sun, 18 Oct 2026 11:33:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIP8V-0004mY-8E
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 11:33:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nNop8oWP2sld9yNaj4joIeUDfTEAN1KlFRC5AfkpFlE=; b=gtEWCAtn89NFrIsJQQWXdZOn3k
 8FbUNwrxIP70mp9108ub4dTipZjmRJ0lHWQ0gm245vpJuOh94T37zQO7vhCkdS3Hn3reIFvsQM4nT
 53FAw3JKEyd4XiJX1HCjoxEaY0hC5RmBtKXChgpab4ei8/70h5Enq9ztUh0MGxVGmQjw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nNop8oWP2sld9yNaj4joIeUDfTEAN1KlFRC5AfkpFlE=; b=m
 lJc69WGz9+RLD+dM5OICYnzOIAWvOZIcLUD7kAOTvhgksZXc+Mm0zg6Lu/oRt1iOFfAPGRp7d7ayi
 8fvxN+pHNcPXOLDeGxkpL2L8H76U0zYSOvbheRb/Ltdbc/xud7Wqrhd32kRgRJ81gzzEfJlJSt76h
 ByKvQQr885+DP394=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIP8S-0004hO-39 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 11:33:04 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48b0584ad71so729259f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792323177; x=1792927977; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nNop8oWP2sld9yNaj4joIeUDfTEAN1KlFRC5AfkpFlE=;
 b=MP5o4EV5P4oi1sCnX5XdXYjsJWaSBbPf48RepZw+0ZSHAKs0WjR+foxZYZR8Kabk6C
 nq/8zhmW0wq+k+F+A34na3JuQ4poxKsO7rmJX9lbn7e+LgrRIyjYJkm99UCd5n5jyAT2
 IVbKT6H8W80jfULkAY1VgWWMO1ccNDkkcvLVfGeVGqiAnOE/yLwz0rKf+opA6yN37iQb
 4do1F0hOa9sS7dHy/qBDooSqS4bfWXR3YKG1dxck4EKEChOiTatdn7De44v3dtQkVMAD
 JcLELSBU70JCLGzRL1yCMWzptVDwX7fTpIOiyO6hXkdHj3oiH6pZVoYmiGRwAgmho0sq
 6TlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792323177; x=1792927977;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nNop8oWP2sld9yNaj4joIeUDfTEAN1KlFRC5AfkpFlE=;
 b=fy1Qk3TIp0MsjBkTkcdssBOjnatIbuToXwEtxDbJ8hMK7q44b+ULM0DAu0J2HV79O4
 IyEJdZMC0s6M0FFKD/B600/WcYdnmCF5jdJGLIGcPmgE5GkadH1PSo2UQOpdarMGDamK
 0R4UKih/vrPHsAQe9WghBe94uuhSxw4Nwuie1v27UQqc1CXahW8Tvk7/R5UDW46ffNbU
 h3LkD/3A/cPi1sP1YDh96wltj+tVZWEtnbPTOUq8LvHWemcrslYKD3iO5vW8lbpMyKFj
 VlNkt5Jg0WFGHRBBGvdkY01+HRBaI4jUUmJl7sWVXKJj7Da1nukRbStwDQ1iOzwybCyH
 d+mQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBytXEm8hRFJjWQHjKylFcmVHOfNG7g5wgKW8yPlETsOdzrgiFJPq4aUKOe9nQvQMAk7a6iIHCavELpLuyTC@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJClpIzmK7F8g1Bvh/K848N+ajvClCQFZiSzyODt/VY41dt4Nwi
 NpxmPcUafR5+bKRNOhfcAJMbh70LBNfa3XHm3rewMkE3eIi4BinKzj30gfPXESCUJzv39XjaJ4p
 KOcbfEc8Vm2RItn7RF3a3Vw9TokTEb9O0wiTLHNE5kSQ4hzQM82hAgALrevpYXKwGa4Uk
X-Gm-Gg: AYBFou0eSGgzWloOYHALbb7TC+VO0NrOmmpzAAfNtjuBcQtbkDuJs+IHOEPDoPQDaYE
 dfPVSkFQ/+Q2VIwHFf5ildjGJiFSCfzsJTLPk/F/o9QRYoZqC7xouMbBIdKw8RQ88MMxv8Ejqp1
 xHMQlZXLPh3kPFqCNonrv8A9OPnjjroa0s2a+tWgMCGHIElOCUXsNwKiu4MlZEmmjcZSnrozz2R
 Oy2Kooo5gHwOe++cbEkFa2PMhHoYQ5uqM1ZaETlSAoRKDzm/5kayGq5BkTUXO07c02EANaszpRz
 IzrsvAwXWoqYRkj2hrnDqXtn/AnS+j+rWrQ1OF3xOP2PGj0Pzj8O/dLRgVF2RxO76AaMNNChSKY
 ztVCkx/emsoCK9RfhX+hiDLtVPBzplv0KZDKa6lMx66KmZICZejSKmmpVqXhI78NbbYvCvD3Tqg
 jzVyzSfs1PVOGUuXhRwlML56RfND+VT1YFNm96kppbUG6i8c7jaerZGkwvj9I89qgPZseumKKU2
 SrCbUXgnaaj59erRBuPBXcp1JjAkbK/KQTUBUYkyo9xSliTSNWwiFoSI6DCNagLt1A0EGkH8kjV
 AcIDdbwpq7ogVWVvkWJ0h6/NrEH7QNND4NCN1HPB1T+A6gYPe1C8BV6+t/ED
X-Received: by 2002:a05:6000:1847:b0:48d:e5c9:39a4 with SMTP id
 ffacd0b85a97d-48e07f9f0a1mr9267326f8f.33.1792323177446; 
 Sun, 18 Oct 2026 04:32:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4edea3sm17147348f8f.28.2026.10.18.04.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 04:32:56 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 11:32:55 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: 9cb5d3bc93878e351b5f822e8ff2ddd21dddf0f6
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 11:32:55 +0000
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ba33be23858b92828e78552b4acd984d7fee4d8b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIP8S-0004hO-39
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign
 clients from a named, tagged subnet-pool
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8634809303141896250=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8634809303141896250==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Cr6saOTMRf4="; charset=UTF-8

--Cr6saOTMRf4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

A=
ntonio Quartulli has posted comments on this change by Antonio Quartulli=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail )

Change su=
bject: multi: assign clients from a named, tagged subnet-pool
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 7:

PS7: cppch=
eck cleanup only, no functional change=2E

- test_subnet_pool=2Ec: the over=
lap test now uses a separate pair of pool definitions per scenario instead =
of rewriting the fields of one struct between checks (cppcheck reported red=
undantAssignment, as it does not see the second struct being read through t=
he first one's next pointer)=2E

With this, "make cppcheck CPPCHECK_CHECK_L=
EVEL=3Dnormal" reports no new findings for this patch compared to master=2E=



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1e7db95615d99=
ef9687de7c4e996dc8033e2631
Gerrit-Change-Number: 1783
Gerrit-PatchSet: 7
Ge=
rrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
G=
errit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sun, 18 =
Oct 2026 11:32:55 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: No

--Cr6saOTMRf4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli has posted comments on this change by Antonio Quartulli=2E</p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">PS7:=
 cppcheck cleanup only, no functional change=2E</p><ul class=3D"blocks"><li=
>test_subnet_pool=2Ec: the overlap test now uses a separate pair of pool de=
finitions per scenario instead of rewriting the fields of one struct betwee=
n checks (cppcheck reported redundantAssignment, as it does not see the sec=
ond struct being read through the first one&#39;s next pointer)=2E</li></ul=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">With this, &quot;make cppcheck CPPCHECK_CHECK_LEVEL=3Dnormal&quot; report=
s no new findings for this patch compared to master=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">View Change</a></=
p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">change 17=
83</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1783 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: Antonio Qu=
artulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Sun, 18 Oct 2026 11:32:55 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--Cr6saOTMRf4=--


--===============8634809303141896250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8634809303141896250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8634809303141896250==--

