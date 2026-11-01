Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422BA606A324
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KPrwt89O;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S7vyk7cp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VEFfdpRK;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fp0Oi/pI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EOTNAn8JojQdHID9wn0/uxE2K6w/rWUy+Vc7/W5mID4=; b=KPrwt89OFWBhN1NcqiD2zh8Pw/
	9o5hXNqe04pMPjSlMN/Cjm6LvJTW4d7zrubPGOSoxQOk2uJDMsUggUgFGy4x31KGStI7NJ10dJZZj
	3kLFBKp3JYZYlvnGLpRf1KqMtoz0JanIDBAG8H96/qMAuCmxJ1Y/QudbGFAumu/rzwNs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNbAe-000000007CG-1CD2;
	Sun, 01 Nov 2026 19:24:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNbAc-000000007C0-2yiY
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 19:24:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ACcxwvPtwMxzDAKDrJ9y6R08I1mMBAJ1CrzjbzzwyTU=; b=S7vyk7cps9KLPTcA7KpnpV7e9P
 KS24Lv/kv1WjW+6QmZuXpiHimJm/hzNm1Ic+aZ8xB2ghDi9yjiK5tqTmYRWVmRgcejXzlgqGO/Igi
 qKudpWHpqLOyUHfQFqBJ/wQoU2eVpYhGsJzHWPUb9e7bYiIE8YmspWnG5CG9v1CuzekI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ACcxwvPtwMxzDAKDrJ9y6R08I1mMBAJ1CrzjbzzwyTU=; b=VEFfdpRKaH1/9LqUZ9i26GxM2e
 7AnYQE/C9U8q0WXo+km0uBOtyNJBEn9q7uK8qCMvvSLFaYJlSlYLFn7GvP5RgSaMfxBtk7BmdSAfX
 0nYcD8PLk0cKNNQR9L8KkLFXDscjKaOOAC41lyZ5tHkfmIWu6J9zpl9U5coGKUQ6b3yI=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNbAb-000000008UL-3VIx for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 19:24:46 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so29785305e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793561079; x=1794165879; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ACcxwvPtwMxzDAKDrJ9y6R08I1mMBAJ1CrzjbzzwyTU=;
 b=fp0Oi/pIPzBkEHtFpHmoiIPqYU58EffOAJF5KwSHQqycsnK053umX3afkxfwWEKC4F
 xWg/JqFYNrRmdyclnYlvMmlLXrVYQb4iZYudj5X/4LqQ4iFsdknmmg787oCo3EejciuX
 My6hrwDZc4HpSNlq9fIm0MW06IILbwU9dl8YwtCR4IP/y160P6EXN5ArLgNbd7RrFWN4
 OAYM2Udlgy+6iM+gCS9CeolpJdo9yHlJOgOkF/rNI4ztqJ+v7XJwFgxbN/Xmhoub/ro6
 qxhTqtWX03Vm9ODzSAt565VUlAYZpJlVR7d3GZxEbgW4/WfOJWx1gOrDpe9SI1A6QHfr
 1gAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793561079; x=1794165879;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ACcxwvPtwMxzDAKDrJ9y6R08I1mMBAJ1CrzjbzzwyTU=;
 b=Hpvu3eIZg2/Cq+ioxwR0aqWoiy7txmD/kgGNJ/lFnO0zjVijUQ1QtXAVBNpKRdfKLO
 E0Rt/Z6A97N5MvzT9gaBZYaR2q45pWKJnHAW2k9mhbAlnQlRYAHRFAr+sXhzF2orAPKJ
 g842PREHexJtG+wpd85c0tJ9RvXDQ4bE+Sf7YSy5E784dL8yJfR4r+LSMsbHAEtvpHl1
 lUNV6Rg5DZfTzphWOeIvPhEzpyMl2XbA+wrn7js5Ly1MH4N1dayMeWc+HWRep+5SagMq
 cHd1DE/wuVEuY5KOYzHBeR4IwCxlicNLhRY0MM3V9z/9YYv/sSeEX1I4an6+EIynTf5g
 fZ2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnDCy3JWOWXeyXjgZB3oKA6x6uJ4Pluz3XQKxOXDppcTMSS55bao6oi1N0cS2MyRVrZdBGy/eq0t4jRM/y@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI7HdjkLldRNlRK8fToikN6U+asb5NzmV4CNgv/yXQ7APYUZuFX
 FTdvek0qpR64460h20yfEc9o/TJHUbePpt9ZAU8qC59jxXS/pLUJeVR8uDglys9UZbwgi3t0Luu
 wNdxevneVyZuo4MGcEpY/P6QxRLDcI7gXkR6w+Edw2MkjYKm2/a3JHoGh1dnuClV2rz3GI+JPCm
 efcirwUA==
X-Gm-Gg: AYBFou27sEGDtJIJueR2EHlWWhKzLvymQv2y1Ey43p6cNBA7GAoFUJF3E0mULT3ECeR
 steuBd+g+CUt2fGPF02pJpln0udeD03BAJMXuVy8XFgv4rI6Q0HVxqNGdLCz14YKrMdcK4lAC9q
 d5RqKWhDUK92WQfnou6ZlL6FRF6Xsx2t67t7wA8kCMmXWQDyfDrTQa8HJIYYiWM2e8Y1LvGSY+W
 UH+ECkRSkmzywR17Q860K1514wpKvkbmTueTFNKqsn7MheB9FfnrYfU7mfGQwjuh29h+SIPb4CX
 8Pbgp40hTT3EmA6McpVpvTAX83NVG5H8whmiAmYczg+wuGNu2iPpsKI/Lf2ZlkpLstEKzO4mp3b
 4WBxjUeZgoGt8wmPa4dB3JGj7g09ZOK9b4tjNpCNixNkdKOipVg17XnArzmg2F2/nLXRVLq9u62
 fiDLxW3SArI/mvGHDcHN6IoeX5N0YFUjPhn1GmYk8ddGZMrLHImQ6P6Gof52sn7qKy4hHYoQCSZ
 0dHDPM7Q5dB8g9hmVnuAfcAA3PYwVChaQfL4268cn90gK6mMBmQ4IpSiQp5TKf8VjR8SuZqrzsw
 PDoAcfU5rHcV3Q2gC/XmEPdkBDus7KUh+4V0FS005hzgHe4Wrbs5N/6vOfPvIN1z5JZIhK+d+54
 INAFsQ6+49e3Ap5AYcmDlM0cQ310I4d9J0KcIVMOaSU2TKf+dUsG4zlSJEaE47rjIeBC/9pkRVo
 ZTb3xMATprJkQUeA==
X-Received: by 2002:a05:600c:8b01:b0:49f:c5aa:9ef4 with SMTP id
 5b1f17b1804b1-4ac16fa4f73mr200363925e9.8.1793561079148; 
 Sun, 01 Nov 2026 11:24:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf60f1114sm237102545e9.7.2026.11.01.11.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 11:24:38 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 19:24:37 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
X-Gerrit-Change-Number: 2077
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2077?usp=email>
X-Gerrit-Commit: b12b34a656ea278e4b660274caacae14fdcfcd85
X-Gerrit-Comment-Date: Sun, 1 Nov 2026 19:24:37 +0000
In-Reply-To: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
References: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzgyMDAwLkk2YjQyNzg1ZGU5OWVlMWU2YjU1NWQ4YzVlNjFlYmUyYWU3ODQ1MTBlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7da1ed405ca6f26ccfd2b14e49be6ecf8f410c01-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNbAb-000000008UL-3VIx
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto_openssl:
 Clear PEM decoded key data before freeing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, hansaemw@gmail.com
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3001867677274150526=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3001867677274150526==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dSwl76pg8Us="; charset=UTF-8

--dSwl76pg8Us=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Hansaem Wi=2E

Steffan =
Karger has posted comments on this change by Hansaem Wi=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail )

Change subject: crypto_ope=
nssl: Clear PEM decoded key data before freeing it
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 comme=
nt)

Patchset:

PS1: 
LGTM=2E

OPENSSL_clear_free() should be available sin=
ce OpenSSL 1=2E1, which is the oldest version we support=2E



-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2=
ae784510e
Gerrit-Change-Number: 2077
Gerrit-PatchSet: 1
Gerrit-Owner: Hansa=
em Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 01 Nov 2026 19:24:37 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: Yes

--dSwl76pg8Us=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Hansaem Wi=2E </p>
<p>Steffan Karger ha=
s posted comments on this change by Hansaem Wi=2E</p><p>Patch set 1:<span s=
tyle=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: =
4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">LGTM=2E</p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">OPENSSL_cle=
ar_free() should be available since OpenSSL 1=2E1, which is the oldest vers=
ion we support=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail">change 2077</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b42785d=
e99ee1e6b555d8c5e61ebe2ae784510e </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 2077 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: Hansaem Wi &lt;hansaemw@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 01 Nov 2026 19:24:37=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--dSwl76pg8Us=--


--===============3001867677274150526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3001867677274150526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3001867677274150526==--

