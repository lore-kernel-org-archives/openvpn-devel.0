Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AC1CCF2DA
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lPk0fJkUmrWGo9cfeEb9U62KqpdQ7nP9KXy6p35T0ik=; b=HemWu/hdnHnImCQVBJNQ/tVfhY
	nL7RpEIkCcdM3deqWuaow7YsKSrY1RMoGk0nor2ZZUVLNWFWXhkhI0oRo/RNK6Tbh72nSeQGv/Drs
	kw7wu36eiiHRoWDyAbPtqaluI9qomajbUyZEAEOr5JFLRnQ5n28U3foh/iYL6h0E6xFo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI5kX-0000kv-Dv;
	Sat, 17 Oct 2026 14:51:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI5kV-0000kg-S6
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 14:51:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=No4ygPnKracnZ4V6eVPSUiEsA4jVYeRY3WUfb+I49d8=; b=WUfQJ8OilkqsPbJCwKasU2Os7g
 o8BnOqpcSv8yHQh+PM2m/n4yGRSg0yaraB2c4ZvveFeTqQOyHWNnSB8kwamwZsx3Qw4x7zZdkvBxj
 Y+h7BXzLUw6OZInDhVjlNMAsv6JY5SJ1kERTyF65iqPsmhPcfaIFrYqrHtWHOF8tgZV0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=No4ygPnKracnZ4V6eVPSUiEsA4jVYeRY3WUfb+I49d8=; b=D
 hMOX8Vb5cdflE471NrBjEGUJSjay94ygmzLq3ErXs9VdWa4EGPvMhcnTX1jCK9dphkmFeKxzf2hCn
 bxw44N7VPqKqJmLfn6Un2K44dKiK6z3eUEUt/KaHXGYt8wPlvU1CWhgPyrsK4Dg5xav8ASLiAH51b
 Tz52Q0nphETGgAr4=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI5kU-0004Ak-TC for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 14:51:04 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so8182245e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792248656; x=1792853456; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=No4ygPnKracnZ4V6eVPSUiEsA4jVYeRY3WUfb+I49d8=;
 b=HlwuRCyrLS16yqlh/8taVnRAUH7cus9rVsolENsJzc01LHb2rl8zQ0M/srjKItaBOV
 56d9xRXBw7PcPTEVeKw+4HM1IxoZNG3fKz+tCIDokr0YQ/nwdt1Dvq/boJ4CCYHhaVxF
 TcIsJoKVLhxOg3GniQ3GvK/h0jEFIZfIzLZNbNwYjtcYAmzpE7eJ4Vxi441gbHTRzJ7I
 63nwtFy9hgYRh8lQa/YbymzpMAewuR7ClNp0f0eUxNGYBVsVpZCXsX8hNYgSMvQg9Rdx
 AHmuAIqR0+Q7JDum9WiyFvnMLi42PC6wBGjmW25YKCsB/0/wDCLjF0qthYb6Vdc1Nwnb
 YSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792248656; x=1792853456;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=No4ygPnKracnZ4V6eVPSUiEsA4jVYeRY3WUfb+I49d8=;
 b=OUvUo0/nGLj3DJnfQ7VcgUWelbejlQt5+V3nN4J94rVLp2GkEt7AKI3XiJaaRzomi5
 NPLonOu8oesNOfxO/oF0i6hiwXebgZOzLD531FbL4p6f8hxX3CbeT9pkzbtDHPUtXJlp
 /B2405S3A+mLr/k7bkNEVmLAOjYz8p5wMyTY2BDetRKDNhW+AAd2lnpC3kFSZDpiPxm6
 6KWLhwzK8ENzyWR37PsfCe7sJaprTEMpDPQ8oGUIbvpRk9XQJcEvTZ0tvwiLSn9arfvO
 xYHDNbWNR8c8UZ3eI/KWSEtB07WhezxF6sGGRUJm6b9nVJMr3fOGS9N3CGtfgB9INkU9
 ALdQ==
X-Gm-Message-State: AFq9FYLZMaOeGAjhIIlGiMssismy1nUUOsPD6ifAlah4crT7m9YEVq+b
 6qbvG1qwIaAJLBfEetIftI+e+keafBZ0DT4n3iCFl5HGmW+bCsgKUhrJ2K6cdb7DfjUtYXzH1tb
 PcI39dfXxhs/gqpWkV+7GCuEErwqVb/OiweX5rNQ9zNwYlhw85h2xMs4QOExSbkV76F9bh+C3QT
 dGuYg/wg==
X-Gm-Gg: AYBFou0phldeEw3VndB+uJZCUtkPF/uo1AJqCXhQXNl93yEbQ2dAxI318BR+rt0Xmig
 q3A46AtIEsbA6HNg24egdQlu4km0ddxZZywrk0mAs2zkM+V/ymNMJ4/SMelMMi9YH/B6ATMqnNk
 nc7yznaIIp73j7/k5DKb3zqhCgc78o/gJ5ti2WMegXGghaUTIWv1wL1Ti00xpOvz9BRu1Rn8Ile
 A1FUqVRpNQHxlTRdHxFeuOUvZA309KSEvDZQw/Hd764kx63e+6N/FX+wHT/Y2AmcKCLKDVPgv5t
 bhhaFU2vWOcF1+9cKO13PsWrcSU78v6STBlK55WM584mejT/Eehh9xR0gCRiSyVfKaPAv+hHpdp
 zSpnH0tjD2iz4yskCZgM9VukToUKOQ1ggCo9GP88Na3Ex4OpneYTuN7S90DYhuyA1pbhzkoYGnq
 YqHaE/9gPrAnOHYz0THsNx8VBnFFgtvYXxnnxvleF7hA2xhquXPdyvyrd8uQZTiayj8b573hrDz
 LfQFLQM+SCnbs4srUJn0gawvIKuassYhSF9ZwuOoFPfOvndnKu50ajBMpLwcQM3K2ZShCKB6x/Z
 B65AQUvZ65AgbOLse63HqmjXIz9WWiu79V3oF1yU/0XSIwH2dyOyLNAPDD6kTfCWxPhBaxAZ
X-Received: by 2002:a05:600c:8709:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-4a1d75e4081mr55120605e9.10.1792248656086; 
 Sat, 17 Oct 2026 07:50:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfdc4eecasm11434252f8f.13.2026.10.17.07.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 07:50:55 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 14:50:53 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iecffd01567376960c9393770ffe05665073b067a
X-Gerrit-Change-Number: 1941
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1941?usp=email>
X-Gerrit-Commit: b56c4fe2bae49eeac19fd31523ab8a607461172d
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 14:50:53 +0000
In-Reply-To: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
References: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDcyMzk4MDAwLkllY2ZmZDAxNTY3Mzc2OTYwYzkzOTM3NzBmZmUwNTY2NTA3M2IwNjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c6637e1b7f26066ec50e8c876a7afb5e8f1f8e7c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI5kU-0004Ak-TC
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add
 --debug-aead-usage-limit-override option
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
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1537695332743522189=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1537695332743522189==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B6UoS8WxC0s="; charset=UTF-8

--B6UoS8WxC0s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Antonio Quartulli ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1941?usp=3Demail )

Change subject: Add --debug-aead-=
usage-limit-override option
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2


-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Iecffd01567376960c9393770ffe05665073b067a
Gerrit=
-Change-Number: 1941
Gerrit-PatchSet: 5
Gerrit-Owner: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-=
Date: Sat, 17 Oct 2026 14:50:53 +0000
Gerrit-HasComments: No
Gerrit-Has-Lab=
els: Yes

--B6UoS8WxC0s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 5:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Demail">View Change</a></p><ul st=
yle=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Demail">change 1941</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iecffd=
01567376960c9393770ffe05665073b067a </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1941 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Sat, 17 Oct 2026 14:50:53 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>

</body></html>
--B6UoS8WxC0s=--


--===============1537695332743522189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1537695332743522189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1537695332743522189==--

