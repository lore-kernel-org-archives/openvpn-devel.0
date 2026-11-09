Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143A606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GoA+TRkQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GM4A/36B;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B/yPNsQ0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=T7p6OkEk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o/II6pdl0Bt7JpFp34nMBAE/KIm9qhBjEsS5FIfiUgU=; b=GoA+TRkQKFgETJRuUDxjLAeq5A
	wbnMeahGc0iS2EtfRoUNLQP6hGTzPj3BUiU4fqhkOG8jLQUsUQjbRV2UsMm5p35mTA3Z1wifC3ZEU
	gNFYpBRi5hTUpJ8XYEcpx1vj6AH4G4xznqjpSHgQoXJMKADTSYyauDloekR90qBIMVKQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRCr-0000000089m-2o7r;
	Mon, 09 Nov 2026 15:22:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQRCp-0000000089f-41Hk
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xEXKWfMFxPGbZTQcxZASvEJEZjCliznbfZk5+9h1IEo=; b=GM4A/36BzL0Y1Kufp0yqZljLqR
 U9wHMaxoW1mOPhC9nOOMMJguLhAFdCIfoOesbBVNYmv6Q+CrpDOy1M4U0YntGLT3ws4DtLgPWy8wc
 MV9vrbQXcLSFYeVF30wzfxNVs0Y4IRGvljzfN+WNUEx3DJwjJFxo747f9u65+VbIoObE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xEXKWfMFxPGbZTQcxZASvEJEZjCliznbfZk5+9h1IEo=; b=B/yPNsQ0582DaHcZ9gf565i4oK
 PnRiSuKYETfoA/hJrNMdxISWU4DuXwM+P9Q9ug5Jm3Mrkv+YI61dQ5DUmqoMIq+NI8eHA3rphFq8K
 haFXzpM4RHW1YUDc8XcXP0cBFs+mUTC/z0xDGZnXakeIwPiSMSff05F+4ti4FvmI9PFw=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQRCo-000000000rN-2Hzv for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:22:47 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4b4571ff080so12265155e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 07:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794237760; x=1794842560; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xEXKWfMFxPGbZTQcxZASvEJEZjCliznbfZk5+9h1IEo=;
 b=T7p6OkEkf1qnqKlP5D6koaZJhR9CWwKfFcOpq3IsKi18ZlZPj007EThHw085d/tOPb
 65W6s4C6+SdyGllPrBntes0lrtYsyo16MSL2dpAUwaTzYTMksxZnC4ro8XCyJNXdZNMl
 sQOx9PI1VdBD1ck/Zw1O1h7jNXU0oM65wMkmenypKdta8XActnr2S1Bs5NOt1dXHJAov
 EMcKgPsSjd14dslD5Wur49C9b/eY0mnQqF9rHp4BIicTMNa4IDa7DlZwNTBTM9+Jg8sR
 bNk+rTlObOXWK/SwtuTbCfyJ3tiJJ+VdPcATdMsfo1vRRA05Er3lx6EOmovpqfYAcAh2
 EIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794237760; x=1794842560;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xEXKWfMFxPGbZTQcxZASvEJEZjCliznbfZk5+9h1IEo=;
 b=cxt4pKBhK9sg3qPhRKsf5gjWOEwjJpt2pemJNdhkNr8XOCxKjLbCoCvyy+n/3Cpa2r
 RAUvke87GW7OEi/EdLs2z61KUMrANj8J9I9XOL01FGB+a74VtVDwoQaP2EN1OGmdGOZ6
 Fyvwy8GB3FVe/0RaWezyjijuB0aCEaZFcSJ+Cir9nb00Hm7RVffol3BDIEE+LkAScROO
 r4wEU2UcgbpS6thp9v4iwD4/r68CpoWwsY3Gw/bmuJrMfqr4sHZQyeiRqzUrwU+CN9ku
 4rdHoE+ATuIHR/nJ3k/2+iUhP3szjchungPo/xq4mq0WQEIfT8w5TMNjruRKNa0NFe/R
 6m1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFx7CHt3ZzQYpaVc+26wxzUUCfHlzRwA1O5vJrKubCa51cL3lUdcSWo+/5ZJ35YTz0+bS/8k1hgLAlDyZu+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8X7z2I2ZVGlLzhJAO0fL1tTVUZRw1CbLGVKjbBRxK83ES0Eh4K
 /1kRZoqshJhc5/Yo4JnEsKmGwuEZt6B+ewULIBN/zAySAAq82VwWGPeLiXMu6wIy2NHiNDm4Cay
 Io1ASI5zAfU58ZDtMArRkeWs3dbvtwM4qvWQUJlQYv7K1kva/lg1buFfRIi2+/V3R74yYr64Mlo
 /VqT0m+g==
X-Gm-Gg: AYBFou2vzVTieeJd4hduJAVVe/Vz/HzbWLErSks/SNekF4qs+VYWIEDFlrlsHeJx14q
 +QKEKFiBHXrIhKuH8c8+WOC3wT24NrkvK/VzWJT7wxRqupl1dxlX1D3kHOvn4/OWPn+/dmJuXUY
 sNouPbdMKLObaLKauUSl/OYN38cctBqI83VRwLlw+m31+kQHGgKJ6odqziPopkspUdhcC9kfcQB
 UheTUV5XhiAiF+3mE7KV8g7qMcrccGgkeQsbQVjXC7EioewcB5VuSBIdMsJkk64K3Rfe4a1GRpv
 aX+kpqX0Db/v9PNfmw4OaKqv4ZKGctVewGU4VAAPLe8Bd76GZ/5iAph36HHnEsMkzocsTAhAck7
 LSRz3ZdzlAaUZwT5mVhZOFar7V7jK6X9JWLiNuus5j3gYD8B+FSDYAXMBBdmTOBnt0Tb1xDX8hC
 APr1YL3swPJiekS+mt/yOtKic0NVBgkwJTzZ0nDfLVCcXxdnbrb0jCDDXV+sq02/5/oiAXMqpjS
 p7/vo2eoth4Q/q9imXDEC0eRGf8mk96rosLYM0QQIKmQjYeyZ/tWGSnYgi8heNRJfCeQNaxytOI
 2TjT+honATQdL2/ovBHEexAv7+sbHS/kOfa350QW23npPByvj77J/TK8W+HuWcmhBEYHm5G8GuV
 Adge073QE8A61j9QrhTWvZ7pAjffgEhm7OSQzDNM8GJrIJFPPwF/JWceFa1NDGIdBuVv83F6vrw
 qt4hIz9FDkvKoX4A==
X-Received: by 2002:a05:600c:4f09:b0:4a3:5aee:2c25 with SMTP id
 5b1f17b1804b1-4b963c87beamr85278505e9.31.1794237759659; 
 Mon, 09 Nov 2026 07:22:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cbd082dsm142418315e9.1.2026.11.09.07.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 07:22:38 -0800 (PST)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 15:22:35 +0000
To: opidopiopi@gmail.com
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
X-Gerrit-Change-Number: 2148
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2148?usp=email>
X-Gerrit-Commit: 56b444718cd97a0d87129e8ff57a96f8bf1ad97a
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 15:22:35 +0000
In-Reply-To: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDU5NDM3MDAwLkkwOWU1NTA4NWNkZTZkYmMwMDQwZTExMWE0MjEyODUyN2Q1OTgzMmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ce379cd638afe6d4509fd0ec13101fcda6822e4c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQRCo-000000000rN-2Hzv
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement multiline
 responses for pkcs11-id commands
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org, opidopiopi@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 yura.uddr@gmail.com, gert@greenie.muc.de
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 Yuriy Darnobyt <yura.uddr@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3054536413140815933=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3054536413140815933==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mckrCgEkyAc="; charset=UTF-8

--mckrCgEkyAc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering, Yuriy Darnobyt, opidopiopi@gmail=2Ecom=2E

Selva Nair has posted =
comments on this change by opidopiopi@gmail=2Ecom=2E ( https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2148?usp=3Demail )

Change subject: Implement multil=
ine responses for pkcs11-id commands
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(1 comment)

Patchset:

PS2: 
> @s=
elva=2Enair@gmail=2Ecom I did some permission changes when migrating to Git=
Hub OAuth=2E [=E2=80=A6]
Done



-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2148?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
Gerrit-Change-Number=
: 2148
Gerrit-PatchSet: 5
Gerrit-Owner: opidopiopi@gmail=2Ecom
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Selva Nair =
<selva=2Enair@gmail=2Ecom>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: Yuriy =
Darnobyt <yura=2Euddr@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: opidopiopi@gmail=2Ecom
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Attention: Yuriy Darnobyt <yura=2Euddr@gmail=
=2Ecom>
Gerrit-Comment-Date: Mon, 09 Nov 2026 15:22:35 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Selva Nair <selva=2Ena=
ir@gmail=2Ecom>
Comment-In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede>=

Comment-In-Reply-To: Yuriy Darnobyt <yura=2Euddr@gmail=2Ecom>

--mckrCgEkyAc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering, Yuriy =
Darnobyt, opidopiopi@gmail=2Ecom=2E </p>
<p>Selva Nair has posted comments =
on this change by opidopiopi@gmail=2Ecom=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?tab=3Dcomment=
s&amp;usp=3Demail">Patch Set #2:</a> </p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">@selva=2Enair@gmail=2E=
com I did some permission changes when migrating to GitHub OAuth=2E [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail">change 214=
8</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0=
9e55085cde6dbc0040e111a42128527d59832b8 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2148 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: opidopiopi@gmail=
=2Ecom </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Yuriy Dar=
nobyt &lt;yura=2Euddr@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: opidopiopi@gmail=2Ecom <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Yuriy Darnobyt &l=
t;yura=2Euddr@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Co=
mment-Date: Mon, 09 Nov 2026 15:22:35 +0000 </div>
<div style=3D"display:no=
ne"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has=
-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Selva =
Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> C=
omment-In-Reply-To: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<di=
v style=3D"display:none"> Comment-In-Reply-To: Yuriy Darnobyt &lt;yura=2Eud=
dr@gmail=2Ecom&gt; </div>

</body></html>
--mckrCgEkyAc=--


--===============3054536413140815933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3054536413140815933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3054536413140815933==--

