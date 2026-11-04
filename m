Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D07606C902
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y1MLtSm5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BwMW64yF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mP+RjZNq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Zl9GRC/X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RtXV1V6xmcUtQnTSFaUkM90E8STmL2FzCfSU7rKEAv0=; b=Y1MLtSm5Ce8RdFvfl4Q3+XT207
	uMcxsMeB0OPTM+nc30w/gAfmn4Gr72ODAYLN5Fwpq0udYNgsO0UIZqgvHz2jKDZ05rN+dmPvpgFCi
	pJfyh6WTzc0o/TIHoNTYzrcdK1fo6cXZvp8mqw8qa4Ivy/FXPslGf6GLuBBVsRW67OIE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOibO-000000004Jl-19uj;
	Wed, 04 Nov 2026 21:33:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOibM-000000004JX-1O7B
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 21:33:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vihsXxZ+GCOQTnSbGyRI3+54n7U7TK221P6z/aXvAZ0=; b=BwMW64yF++gSwh8y9XPtTiTrjB
 Fb+hw0UMC5NXFq8QXxK766dPJoQIODAErK9NYQiAJC8k6UYgpldMfSkbOR4RjeA/fnuJ74N1yemrG
 D/+3QPr1wxGDJxqk6dMGm0VytLnj1lZIKROcxoiw4Ba/R5+u0hyV0bjF/heR1b6p3j1k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vihsXxZ+GCOQTnSbGyRI3+54n7U7TK221P6z/aXvAZ0=; b=mP+RjZNqbqKE7NPt6XWdbqYjat
 DgePmM9bDLgMjCjN34IvapOzYMSap99UbEu+3dt4Elhk3vLJOa7dJgYQnjoasNJiv6BCPu6XCT15D
 5LUOR2jpz3eVuh8HxyjQCV7R2sUOsyNh6LX/jd9hhQNA66rXbcZYDhZCT/kCGXp0+lAU=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOibK-000000001N0-3ufv for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 21:33:00 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so1056858f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 13:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793827972; x=1794432772; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vihsXxZ+GCOQTnSbGyRI3+54n7U7TK221P6z/aXvAZ0=;
 b=Zl9GRC/XQT4Ylz/7g61qAm+mYkSaVgRJUHhIFCEPEvFY26Ki9Ano5YgaMNFbYIcpw1
 SS8Y98VVvP5Al6h1kAlhiIYQEGast0zX2agZMMYa0a5rgixUSsCV7ctudW8+L+SElH/w
 ELMNmXsw+dYuMeXtHByto06F6Sk0K9A5+qL3xBM48aRTZo23fvke4doNywzgx9EWdUYY
 jK2EtsCg5fWyMNfzNsGHsn995STSxp+vPJkRZCO66WdUN4ru8jEoFpRJruvDyK6PuL3P
 Zvr34eDFWO089wujYWjGCyk/h1qOCFLVLM/mpxiuWrH2ie9FwSt65p20FpB5Qui/rFkT
 qDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793827972; x=1794432772;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vihsXxZ+GCOQTnSbGyRI3+54n7U7TK221P6z/aXvAZ0=;
 b=MmJ0mSr3foqtaSz7x1Oobs8ahIfB7gJ3zinMtCgyD9q6gau7pl4Byd3Kec068D1b6j
 HQhrgHHmOe/O05YWAhUzgXYrrkcvHyaW15bxzP1d4gC//oNbxMlxJkOsAOgPNVNYXp/1
 3q0+QlFaBBPtx1uUd+qu1Cd7fAWbga+MgcAIY7k2GPC6VI2vODq3si6gI3aI3sUsn1gy
 agZlJBhhWnI2SKx99Fj8XjeJCLEPhU60vX+Ic02y2s2YbLpeQM+qThuPZCeaofqstsoq
 WUg2NFMTfbH7CxKsbQH9ZXY4jCeDus4LSmbc6YMIQIZ770GQumjBYIQc6J76FhU3Pkzm
 3VgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByqS8SJyjQOiNVPcoNHOOQEljXgv0XxmsBoSop+2DfUCo9Q+YgxZKNIHWQ0a4nZksk77hksxiBLxMQh049E@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+IvgAhEAAnnqXrS5MisM+NowUahYa8ZfezokJr63HJIjogv8zg
 8fhQvYQUI0F4ugPmRAPaJnnSeTzxK8m0aREp5FheQlPlZfkBj7TlrAtaWcLQyo/ke8mAH++RU7o
 liYrv7gsodaG3tPrznxf6c+7xowTFdH7Rjwg2uUbpP5VRnm6/e94mq29eTdhMzBXacO2Vkln8Uf
 Q7Q+tPhg==
X-Gm-Gg: AYBFou16/sO+TbGNb4HIKyrH7KafqIbQ0855quNwtjKjAtgRspKfEPXnhF3rQs8TE7N
 iUE+HaZQoWdXejL1VxGWchVqZzFVGb5Dt59V1zrLT71vgiJaNnUnafdmoJ5NCiaau62CTCrQofr
 PvTHzk4rdmwdmf8BXnTj2r/iUQns8+5C0DuRB7xQ3xj0fwACWGgFHS2sHJ4y3SfMVowOVMyrAbw
 c951vRA64wgh5vB4S89G1AEh/u4SCi8pjF5WKZ0aiFgeMFtRN0qgciFj3xE0IfG3zQdIKD++80n
 wtjpJ6eT76kcxrG3Ak00zKTI0INElCKAOBDZTKuA6O9O8RXLGsUBcon+WYegFGNvYf9BXS4MXaY
 oMpmCw42ei/MKL4tY33pmoJ8DhE2bJajQsLRbKFyyCIPJEppTq4p8ji7DgxXu23o894oKDLBJC9
 MCgySwnH7wZLu3FBryO9hWpRUDno0C+PFfLpcZME4W5W9x3Bm+yDVQbVkFoZPUFdETcKOxNxzCQ
 4xF364ko5qeoLFd78+mh1qPf722Obtur/9qtsNICLRBN4QzP1KtEgGZDPx5inaMscqikxa7FTp5
 QL/pbu2hzlKGgZBClX/iQq5fq0Ihk013Nnu/YXl5acH3E92x1cgidj6389kkHQJKFAQrOLV4b96
 uFeSSGIfS5hBhuQWHerpS8css+nAIW2HfN+C5TFBeAIgtc/asbNLdJ0a3xf1uLnVSrg03YVLawW
 DsFqFCkBL0IB3xsw==
X-Received: by 2002:a05:6000:22c4:b0:48f:bf3c:1631 with SMTP id
 ffacd0b85a97d-48fbf3c185bmr7390180f8f.21.1793827972320; 
 Wed, 04 Nov 2026 13:32:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed08343dsm6071765f8f.30.2026.11.04.13.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:32:51 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 21:32:50 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I24589d5158f67febd3c25af029944d3f1da32763
X-Gerrit-Change-Number: 2063
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2063?usp=email>
X-Gerrit-Commit: 3b2ce51dcb04b48f6d9e43af9318d73ed1cd7c09
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 21:32:50 +0000
In-Reply-To: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
References: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkkyNDU4OWQ1MTU4ZjY3ZmViZDNjMjVhZjAyOTk0NGQzZjFkYTMyNzYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d5e9e35e7f41476f08b20f1da173d43f5aaf9e6f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOibK-000000001N0-3ufv
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE: enable
 Linux DCO address and iroute updates
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
Content-Type: multipart/mixed; boundary="===============5583681028994746867=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5583681028994746867==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WkpjzcRh/rs="; charset=UTF-8

--WkpjzcRh/rs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Marco Baffo has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail )

Change subject: PU=
SH_UPDATE: enable Linux DCO address and iroute updates
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

Com=
mit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063/comment/97f5d=
1cb_8f75bdd6?usp=3Demail :
PS2, Line 13: scheduled-exit check to report the=
 push as failed=2E Skip clients already
> The `scheduled-exit` comment is s=
tale now=2E
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2063?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I24589d5158f67febd3c25af029944d3f1da32763
Gerrit-Change-Number: 2063
Gerrit=
-PatchSet: 3
Gerrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Comment-Date: Wed, 04 Nov 2026 21:32:50 +0000
Gerrit-HasComments: Yes=

Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>

--WkpjzcRh/rs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Marco B=
affo has posted comments on this change by Marco Baffo=2E</p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail">View Change</a=
></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2063/comment/97f5d1cb_8f75bdd6?usp=3Demail">Patch Set #2, Line 13:</a> =
<code style=3D"font-family:monospace,monospace">scheduled-exit check to rep=
ort the push as failed=2E Skip clients already</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The `s=
cheduled-exit` comment is stale now=2E</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2063?usp=3Demail">change 2063</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2063?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I24589d5158f67febd3c25af029944d3f1da32763 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2063 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 21:32:50 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>

</body></html>
--WkpjzcRh/rs=--


--===============5583681028994746867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5583681028994746867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5583681028994746867==--

