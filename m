Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205D606A323
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PsgzorNC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NPPPsXi+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D+BqUGvX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=diFz3glu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=j9vsovbsoe7Njj8N4YfN74wbhY0i6xPSMgM88J3xl/w=; b=PsgzorNCbuNmGD2zw3aAswBKt1
	gU6wJ+BN6aLonQEqF/kCbvso4CyhagcXBFIKeILzyIlyhSUOCXo2SmO/3HG6d0/INxMqnD1YQLIgD
	0jKGkPOsFOfWSVWcb6/Vp+B/GUdXPQHHAd1NvD7IW+U9/fBn4h1Wz4jsS2L8kowDpyjs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWvZZ-000000000bb-3OkH;
	Fri, 27 Nov 2026 13:01:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWvZZ-000000000bS-0ELR
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:01:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7z1fxVKE04eQsQhRkiiJpXmQZ22SNBmTAm61V5Y9nnw=; b=NPPPsXi+v2K5FINtSJanPYvDWO
 AnMLMwVzF+QWXgZFCFegLETJv5WB1QU4V1C6QEtshHJidGi9bPGJ0zpJdO6NXoJkzfAsPfPMLkM/r
 Zh9mpn1tKmhi+bIfyx9zYtQlj6HsLTkyTaxfKXyYLth2y4dje3HK2lPHl4Fg+v90WVWw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7z1fxVKE04eQsQhRkiiJpXmQZ22SNBmTAm61V5Y9nnw=; b=D+BqUGvX1o0AJRCTblWMBJRVyw
 9ZM8vwRjQTwAczCoYSE5BhJZimPbjQCABhxxZ9omhm4v2XAM50QEAuofWNMRcf6ab3JeG8NEVDxhH
 I7ZgyJT15GI84tibrRWehaZfQHS6AX7AwIqWeKgAFsdTyRWBd7wuOgyriAhcRnZ+lSKM=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWvZW-0000000045e-1RHE for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:01:04 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-491971ac844so7141343f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 05:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795784456; x=1796389256; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7z1fxVKE04eQsQhRkiiJpXmQZ22SNBmTAm61V5Y9nnw=;
 b=diFz3gluWHUrOWFc5rhBUdrb3dc/2BP+N4D98A2pudOALdyMmaaGSrTiL+kl+ErJ/1
 FlDEac6seMVz+Uu4Jo3jwpWMdUdx7yF34w3lRceajkNsJwcUUlop/Bk0H4rn9sbhP+Tk
 4Bnb52XaUxBRD3kYbE/675c/YtZ6MfRsBKKnyOwyoyT2dF+C8ZXSrY27w6f9LJPCI6x9
 3FpLbpBB9iy7vYrBH8LRznrryo//Q9Rc9XjXdznH4LkmbAHYSIz83tpsvE4XAicn3NAU
 K8aI5EePS3qypLivVtRhyLYJz1gVyHnUp2e2o5AI690x1SunxmdkxnTm3ZG37CYsPEzw
 Wtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795784456; x=1796389256;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7z1fxVKE04eQsQhRkiiJpXmQZ22SNBmTAm61V5Y9nnw=;
 b=tbfQ+6s8zdAeAm6DXyauGfIpOdeS/DgWzrJNkSTm0fe53+aecHYTJdnqkOzjyi5cf9
 TcVlM1BKx8FM1sxFiTYHw+GhR+q5CX7WZXMi5lTtH5xiOOLf14R16NYD9YTjhsMXOaBe
 AOAxs7rlC4Q6U0GqL+EztCpMygg0+aBKltcT67lPhvvtqF2fzRIaW+PWZfNiwTXqj3lY
 PuzYJSTuJj6cc+p+ELcPWPUR7iObZE55QYxZtzSPrau6t+ZIoS7DcKMGQtYzBRqwfNVt
 1ZmLFp/gYlvm/LezIpt+aaIWLnNxYRUzXPqxUb7OqIsyGQHRK3hI+05PvceVOdr4lz5O
 v3rg==
X-Forwarded-Encrypted: i=1;
 AL+hErGpVP/Kjaa09ZucxWIuGNMgBTdDe3A7l31vSfgkb96p0zJll68dCDJLsYQsVVCpXA/N1qHhCNMqF9veaa4u@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8ZqVFiVxvebEVOK6OQOKjxeNiX2sM15go6KCiLeCYUt6N0OXyx
 jwmApaBA49Wsz5GSJRWbepu5eKbF1fNm3HOcLeRNmRZmfJmijlVDdHfVB2Agv0yc9yJ08AL5WBG
 /GXYaZAzq27eZnH/Im6iqghrUf0k75bEeiVsCzh+jr4GXo6rYJ6SFH4RXU5gxUX3c7FFA
X-Gm-Gg: AZFdTZcn9bIyCE0KICw9IZjYg+i6a2fP5VLLgm/Pgreqz+gWhQrWy1sJkqhMUo95+wr
 u8JGNMEDJPQh+acaKlypkCyRnJmq+mwafk1nSIp/pd6vHzNk5pMkW6HUi2+MmfInCMmcrPdWMk2
 lhoKgxybOZVCabn/33n9NJC+BylP2ilA4pWziMS9C/pLMFDHRyagK1bO8fOYUYS8zR3uwJCBzY5
 UbSnJbbkXxhTSDN/5cr1t9AtnFwtn7fYxu46AdYZxx3fMBIZP1Fx7518Tfn/q9u5EIAnSHdMC+M
 0p8dsu+ALjBthEiVB2iThONfcw+j+aWOk3pEJhQHm62UZZaczWCIMIoSAhJrK0QG/7linpr4+I7
 m5gf7agH2Iqp/qpx8WZx6hg4jbnseJOkCbkWqv7/RiruxUBbEWMYHRloRanzBPDjkThite33ti2
 MLr9PxFXjsYuk16QWopJTK9ItVynUCrKummtNVSnFQ3qD00KoiPYSWWhhpE/xUcEm/qufYYrvuJ
 YVRHw3fkJjOpQFOg5nUoxeuciW6V0Qyp+F20CfIkTV6AbUsEzw22UW7gdEKesd201G28X+xsshd
 R6JfE+y/nkWx+2N2qUMOE/01xUy+mfrwsJD2x/NKAR2aTG3MrQCWy2V3BPSNH6UQjAwJkeRbbvf
 td0eqgmC+YzhYTAiEGCJrTHNdsFyvg80iwF3Huo+LEXwWF/TtKFZGwfDBXyFMLL5DKqhB8o0Rff
 Gw5y97LzjyDw/J04w=
X-Received: by 2002:a05:6000:18aa:b0:4a5:33ad:8721 with SMTP id
 ffacd0b85a97d-4aba532017dmr45064296f8f.0.1795784453350; 
 Fri, 27 Nov 2026 05:00:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b8e564e39asm14992332f8f.57.2026.11.27.05.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 05:00:52 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 13:00:50 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408
X-Gerrit-Change-Number: 2360
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2360?usp=email>
X-Gerrit-Commit: ecf8d7a55b8642e75d9c8ec381df503fde1ecde9
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 13:00:50 +0000
In-Reply-To: <gerrit.1795779011000.Ib20f4965f25472f47b98981d54eaf4e2269d7408@gerrit.openvpn.net>
References: <gerrit.1795779011000.Ib20f4965f25472f47b98981d54eaf4e2269d7408@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Nzc5MDExMDAwLkliMjBmNDk2NWYyNTQ3MmY0N2I5ODk4MWQ1NGVhZjRlMjI2OWQ3NDA4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <18c26ae828b100db060bb0fe77bbd27d25cf3b43-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWvZW-0000000045e-1RHE
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: preserve
 --dns-updown across PUSH_UPDATE
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3460265585843441865=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3460265585843441865==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HEdvLP3D/aA="; charset=UTF-8

--HEdvLP3D/aA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Marco Baffo has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail )

Change subject: op=
tions: preserve --dns-updown across PUSH_UPDATE
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/ope=
nvpn/options=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360/comment/=
ac0edaaf_7b184226?usp=3Demail :
PS1, Line 3629:     dns->servers =3D NULL;
=
> Looks good, but would it be good to "save and restore" here, so that peop=
le who add new fields to `s [=E2=80=A6]
you are right thanks!



-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib20f4965f25472f47b98981d54ea=
f4e2269d7408
Gerrit-Change-Number: 2360
Gerrit-PatchSet: 1
Gerrit-Owner: Ma=
rco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attentio=
n: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 27 N=
ov 2026 13:00:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Commen=
t-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--HEdvLP3D/aA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Marco B=
affo has posted comments on this change by Marco Baffo=2E</p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail">View Change</a=
></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2360/comment/ac0edaaf_7b184226?usp=3Demail">Patch Set #1=
, Line 3629:</a> <code style=3D"font-family:monospace,monospace">    dns-&g=
t;servers =3D NULL;</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">Looks good, but would it be good =
to &quot;save and restore&quot; here, so that people who add new fields to =
`s [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">you are right thanks!</p></li></ul></li></u=
l><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
360?usp=3Demail">change 2360</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2360?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comme=
nt </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2360 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerr=
it-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 13:00:50 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display=
:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-I=
n-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</bo=
dy></html>
--HEdvLP3D/aA=--


--===============3460265585843441865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3460265585843441865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3460265585843441865==--

