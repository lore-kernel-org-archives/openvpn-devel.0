Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0782DCD6E55
	for <openvpn-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cb98jpSiVKLKDUGOiFRbF+ghL5Lu3Baeml06eLk+C6A=; b=BP4PTAyn0GfLRP603MwmnoS1iv
	hK5ba7vemVbBPF6mYqVkKUpfbAA9Huq+eC+12zzNKd+asLSgoZrcb71Gx2yMqACRCQJ5iIjwRC0oY
	Rpb6/i3Kro+Cv+OsmSxw9DuZkWPWLzXI3oW9Pc5UXb4lWd+SI/QVF4ePMfceLMFA7GIA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wUmFT-0003Oj-Rc;
	Wed, 03 Jun 2026 14:07:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wUmF9-0003O9-In
 for openvpn-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 14:06:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FAZqkxyOrXWtHTNKhewnY57nZoMhUAI/EabytCCzfFo=; b=YfhRGjxvbFhMCCAeCoKx8kMtZq
 E21BrCaxHDAzfRyA8LvXusynPkhZ50wqDPR7151KzLsBd5Y8s0vRgXBdL220taqbBdCp83gUyTU5f
 l1DDl1tlyqR6KRaVlOG79arKIF+pq6HpKH/qaW6hhRi6fhT1vXp3y8Gc31Jwufc+WHW0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FAZqkxyOrXWtHTNKhewnY57nZoMhUAI/EabytCCzfFo=; b=O
 fDeFdMZyah9TXzOZSxUOgQhUKDNtU+71b2ohFnfZANt4DKbkiTJdIi2hqJjBQ4F4t+rp+7fFaMSOH
 rMe9hIDy9T7thLlpYe4eIX3Du4tjF40qDwp1Z54cZjuoVhZwn1vHCh6riN6CvEkoh5SMe2pgz2WDs
 vzMIfpACwvUkYdUQ=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wUmF5-0004RO-PB for openvpn-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 14:06:49 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4905529b933so102231795e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 03 Jun 2026 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780495602; x=1781100402; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FAZqkxyOrXWtHTNKhewnY57nZoMhUAI/EabytCCzfFo=;
 b=Zy4+2SsWftMwYesM5gH1fTwPDNWd7BR4aHqGXGoVr/xyhuifojFaTHkPTQQvVIan1E
 kx1dcJQZieYHTMJ+VTpVmmjqgao0TjxWeSQl3F/fb9E2qvpcoUZVrjv4HaTxm29k1PPa
 dCutUMuPdfjnH+JUL5OQjP80+zNRLraPVOZNJ1+ig8v22pHR9qhc1IDWwR8KeoTfqiBu
 /TQEx9EWAxN+gb1G1WYOXFCpDWR4bBvsM4jn3VhwsJuNyl+FXDQ2ZMB2CO0SHBMWx521
 1oPXTrms1jNi8yE2VLzIDqZbTN7z2f8tSRDovqCg/AazUXJ8BA1JJwDtZjS6/bGmp6Ik
 Yy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780495602; x=1781100402;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FAZqkxyOrXWtHTNKhewnY57nZoMhUAI/EabytCCzfFo=;
 b=aaTv2mgbGPc5l82DA9ep7ZMNsGvxGMhPGrImpUJUMJID78pig2bc1xn1qow41zCdNO
 NBZtzqtS2Z2UgzBlbA5nSwQST6Il29b9MxTKf2OghEP68oTzHjyVc336oZDqWWda89ys
 ssfsae6dCq2S6cW4PHYCaESNMV5avuw0zAxBQbm5zHIxnb/4Mi3WaeQmoXiS6QT201SJ
 BM7KHoNk42gNpy+iqKJZRDpheR72f8VQWLYpi/2mBHhejIyO7CaJhm5w53FihVNgPivv
 HSr3udonjD8Y9SxrADFYDis8Kfb6CvuH59joqKt5wJiFxcD1tLIQAYvdCoqa4gcj6ZJo
 D4fA==
X-Gm-Message-State: AOJu0Yx5hTo59q9iWVI2G9t9Q0AK8U7tqrhDGXOLn1TiTARtlF794VUb
 C47S3KY0xsmPxhHd9e107vWxy1WS9aI20cOAU9Uf3aLPov3Fo+F3i0HA5yR+YcpqBr6TIWD1JAg
 0KiNSNYUTMS38QtcpmtvvybI2a3SAUk0A4ShZgHCaLi8JvkQVu8CNAU5wqxElDG9HSnoP
X-Gm-Gg: Acq92OFtwGR0wdYnOU1F9fErOKKWm5rHqTNF1BzdrzRddLaN+Ozlas4HIm2v5CW9t1n
 5E1bq75VK/rW8F/N3fm/6iC4IFGJ+zpDzDLhSUmCAFGxQr1Zd5Q2v3JbM8xZsCR5AhoFyzC2rrm
 +flEsKrc1ERR0zseepQrjhESWb/Or0otkAUSQrBh6KZ51zRlcS16Q2U3j+8qhKkm8bgrnERF7pY
 vKx4clIPNC3ecOUBF5rIbz8iFuhm/0V4odWDY+c3v6hv0h0VB6L5I4QOkVx6qVYuWj/C+O4A5/E
 CZJQsiECFF0hCHHSyFdC+RIO/0WNi6Ikm4HbnoJ+7Cr7MakbF5SXm/wNRfoYOrP7lB/LkflRmr4
 nRgL9VH0IjZLno3egVuZ9ywHUZLIb1dKVkkHSCdJst9vfyOoR3U8x0AU2gPVSc2PR6VpU4OAkYM
 ul+aUe6odIsAkPvxWWEkFEjsBeblIUpRS/31xQGSe/yMvQhO07e2VqtPf601BWvmyAjSLwek0Su
 1xSoIQb+X3vtoZkzfMkpBwQa2RAkICL+FraU1I1gXbn133ngPiYi9V0u0pNkd9yJ/iC9AL9wBXt
 qj9Dpzcpt81Q6gTeRNGwC8Bs
X-Received: by 2002:a05:600c:5394:b0:490:b65f:8b1 with SMTP id
 5b1f17b1804b1-490b65f09c4mr62701155e9.5.1780495601497; 
 Wed, 03 Jun 2026 07:06:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b7c6b966sm45920495e9.2.2026.06.03.07.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 07:06:41 -0700 (PDT)
From: "MaxF (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 3 Jun 2026 14:06:38 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
X-Gerrit-Change-Number: 1707
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1707?usp=email>
X-Gerrit-Commit: 282b65e1563fd55637872dda9c18cb9a5bbfe6ac
X-Gerrit-Comment-Date: Wed, 3 Jun 2026 14:06:38 +0000
In-Reply-To: <gerrit.1780494160000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
References: <gerrit.1780494160000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgwNDk0MTYwMDAwLklmZjhiMzM2MTI2YTVkZmY5ODcxMjEzNjY0YjFlODU4NWZiNzBkMjFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a256205e31d6b1f5672927247c5284c8a744fc4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wUmF5-0004RO-PB
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Ensure pushed
 tun-mtu is no lower than TUN_MTU_MIN
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
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2595963055625701237=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2595963055625701237==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F/FUxBWerc8="; charset=UTF-8

--F/FUxBWerc8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

MaxF has posted comment=
s on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1707?usp=3Demail )

Change subject: Ensure pushed tun-mtu is no lower tha=
n TUN_MTU_MIN
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 1: Code-Review+2

(1 comment)

Patchset:

PS1: 
I already revi=
ewed it on the private issues Github repo=2E Looks good to me!



-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1707?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e=
8585fb70d21e
Gerrit-Change-Number: 1707
Gerrit-PatchSet: 1
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: MaxF <max@max-filling=
er=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-D=
ate: Wed, 03 Jun 2026 14:06:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Lab=
els: Yes

--F/FUxBWerc8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1707?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1707?tab=3Dcomments&amp=
;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">I already reviewed it on the private i=
ssues Github repo=2E Looks good to me!</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1707?usp=3Demail"=
>change 1707</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1707=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1707 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Wed, 03 Jun 2026 14:06:38 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--F/FUxBWerc8=--


--===============2595963055625701237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2595963055625701237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2595963055625701237==--

