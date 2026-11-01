Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1B606A329
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mBnx7Qci;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gwXqst6o;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OfXUhTM6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GGsiLyil
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gZhllv633cQTm8+qXxr/HjjLCWJLbNlnP2zHTSLDVkI=; b=mBnx7QcivWai1yTu5uNYGoVA5A
	HJfa84H1yav/49W5EdFcReu7jKRviRVzqW/3sGCJ2KHzj+T+X0xzU19Qe6Sm0dohZ3tRWKGurDwE8
	Bp5N6zvJo91EKSUrA/ATcwxqn9k08OHaGNxFxxQX5qx9fGPQGgbkMGhu73YCEWbEYCkw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNbEF-000000007Yp-3Ry7;
	Sun, 01 Nov 2026 19:28:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNbDv-000000007Ws-3lKb
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 19:28:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Aq08cRgqajsTm+2BSwPCVV0kRvPDx4YVSnWw2mARV28=; b=gwXqst6oxisQ0ZuIkE+rfRWjuy
 j/GOVai5B0AT3RRzyfLcn12payvpt2xMlaIad1Y3wWTbRgdImt/XER68Bfb4WbuWE/WOvejjvLgki
 WOt3IxG5UEmSkkksGY8j5tCuogXEMhfaXIrSKhq0pwa4KIxlj7ZAZwAUcbLW4Zb/GF9U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Aq08cRgqajsTm+2BSwPCVV0kRvPDx4YVSnWw2mARV28=; b=OfXUhTM6yDCzJ21k0Y1vn3h4i9
 IUyPRN9ypj0ZV0+3CHvhZ+mTOlR+L6lSrp10NxKs4vwTmP25I973xuUuyl0IIPkbl8zryXg95lCwX
 er9++34bDqHaktEF+DVM98AKAeDi237z3UCx1q3N0pnJnb0YVqCv7i/yId7qebxWl05s=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNbDm-0000000006c-2jv1 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 19:28:03 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so21309015e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 11:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793561276; x=1794166076; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Aq08cRgqajsTm+2BSwPCVV0kRvPDx4YVSnWw2mARV28=;
 b=GGsiLyilRe/n8ReCz1SZEczUtsInPOs4EsBAf8DWUZrrcayZZk1WY56J5jI7YDoNOc
 fRGuu+FcK2Rn1CJ5e6b9vaUuXScaFWOn7uXXBllL5o3W+sWlrZSc/poVsl5VUHUw+TeN
 2eNJWziMeKQOWbWxC0MYcjnw8WCkGJeJ6t2Zb+778HNk6Gf1vLBVO9zB057aEbMwbF+p
 HJbHlKtakJxSzK0GtXY5lztAUTLeNrFkp+4b8vQmDlgDLez17EtXLBVGgyRxlrR8N+Om
 KrI93MlQkkw/9PyihXelnJ9o+4bVaUp08+JSqpSt6bKWbkUKL0aWSR8Rk1NBhrWlsySH
 vVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793561276; x=1794166076;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Aq08cRgqajsTm+2BSwPCVV0kRvPDx4YVSnWw2mARV28=;
 b=CYxD+HnTPNQQK8jArfuYXZ2KlO3bC8+6xuj1T63GUtkRrZVNDDM8k/p0t8mwkkmz2e
 spSEwJXA3xjJhUhsBNq0KMKmDodBbZTI7AuyKTChlYRIS7pLAV55mzLGzawtlc/ZKt/C
 IymPk52zuyIG04JBhVKmEfr5iI/VxMVqQg2w1fgQxpMGL4Wgzczb8rpdC9nyjz78hjG9
 0moOUStc3Zmc7LWE6f3U1p48ARnwFsu84g4sSyWcok37I1p9TxesI6T77bQv8OtKVZQz
 T4L1It8F+upZBAPSrYYQW310ozK0GPE68hcjGEhjrQDe56mfb5GvhSuWqfszTKhEacPL
 LivA==
X-Forwarded-Encrypted: i=1;
 AKwUvBww71EtG4OQkX7ECP1SRGaUDzhbT0RiARbBR1VQtKUsxbS1A398Ese331o1JolryP+kzBaSZBUPKPEim8o7@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI1I0p0pZDrPFXXFjVRlutwFM5ZjD9MkzcMYF0FupBAbLsuXbk1
 07/BuD+Q+V8kYpskVSZ+H1NSrk1C66PlUBKIcuCmK5Ko/TZ2PDDdRw/uNj8m0N1MW+kLihGRqvY
 NSFveHtD3gpdZk/8Rrx9f8z1mv/g8gkW+xh9z6pysgqgRFGWxJdfsUoXeZ8c2XzFTgvRP
X-Gm-Gg: AYBFou3cZtGP222wPs40rag5/RmtEDtX2IKf0C9v5eXw4RcOfWvfSmkkQXYxLmW+Glm
 EsNMgjNEIdwZnrNWYqFXfKcqg4b5UWn8WdWLLdLrXtineiTST0CFMjUIbIHs3MAiZEqZfWTzIQw
 dG3QazTKPfQbOK3KWTzKJ0gtrNsISnAqGzEj9nzds462dOaiv8O5Uik7hyPKxsjXobNDBlkKwlw
 QQfHgBldrYrtDXlQwsoBxMha8jDB9CRMRLYSddBx2DnWQb18hHceQNr2c2SdFfcb37SUwD6cFqF
 NCsSCNWXT9X00uApIddBdR7jiWYi+6PXSUO8tSuoW8Zm7F4iWMXpP92OCPnSSxXiGWEfE3tF99P
 mlFRxI+zPbMhzuT8k56SLf3BbZ9QobE4wjDpMOtgyK3hus7PI4VIaxOWFsxghkYGNfZ1V5qPVJJ
 gVhTU13YuZGsDMfBNF5fH0DVoj0VroC2Gf0BEgyRWhMK6DBTgoop91AlnnxqUR9LfDUFtZbyvuT
 WvPz170XjkcyviIgVgDJmvpIEbgrJsMPlja/hi+GJUTuozIJHnot1VBw+KIIXKVTiQOdgjmrzN5
 82MAVYKp8ZqLsTu42jXApueO0WsNCmSCnFTyoCGeSPp2ToFi65qP8QKLofCd8qhCqnZ7cVkIxQl
 /3MhzBOLWfZeG17eCQHiiM3YdaK82kYtNvB12Ms5JW67MATJjosKYcIKs8jbZOFMVsxUxLQNews
 AbcKKU51hLff8zEQ==
X-Received: by 2002:a05:600c:c16a:b0:4a0:1c10:1372 with SMTP id
 5b1f17b1804b1-4ac18c74638mr190689415e9.27.1793561276005; 
 Sun, 01 Nov 2026 11:27:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf0b36853sm201489205e9.0.2026.11.01.11.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 11:27:55 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 19:27:54 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I88b17af9988aa640ca04c765b6e79dd1c8f822c7
X-Gerrit-Change-Number: 1998
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1998?usp=email>
X-Gerrit-Commit: ededb5b3b364d350fbe8fbe023eaf33d42ca4c29
X-Gerrit-Comment-Date: Sun, 1 Nov 2026 19:27:54 +0000
In-Reply-To: <gerrit.1792059610000.I88b17af9988aa640ca04c765b6e79dd1c8f822c7@gerrit.openvpn.net>
References: <gerrit.1792059610000.I88b17af9988aa640ca04c765b6e79dd1c8f822c7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDU5NjEwMDAwLkk4OGIxN2FmOTk4OGFhNjQwY2EwNGM3NjViNmU3OWRkMWM4ZjgyMmM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8ed725f8a62d1e8c5e38254220e386fd533d6b14-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNbDm-0000000006c-2jv1
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Check for
 null-bytes in certificate subjects
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8804953136485211113=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8804953136485211113==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oHlMWbsY3uE="; charset=UTF-8

--oHlMWbsY3uE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

Steffa=
n Karger has posted comments on this change by Steffan Karger=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail )

Change subject: Chec=
k for null-bytes in certificate subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Patchset:

PS2: 
>=
 From what I'm reading in the build failure logs, this fails macOS builds d=
ue to OpenSSL 4=2E0 [=E2=80=A6]
Those are in a file this patch doesn't touc=
h=2E If we want those fixed, we should do so in a separate patch, right?


=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: I88b17af9988=
aa640ca04c765b6e79dd1c8f822c7
Gerrit-Change-Number: 1998
Gerrit-PatchSet: 2=

Gerrit-Owner: Steffan Karger <steffan@karger=2Eme>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Sun=
, 01 Nov 2026 19:27:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
=
Comment-In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede>

--oHlMWbsY3uE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>Steffan Karger =
has posted comments on this change by Steffan Karger=2E</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail">View Change</a><=
/p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998=
?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">From wha=
t I&#39;m reading in the build failure logs, this fails macOS builds due to=
 OpenSSL 4=2E0 [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Those are in a file this patch =
doesn&#39;t touch=2E If we want those fixed, we should do so in a separate =
patch, right?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail">change 1998</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: r=
elease/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I88b17af=
9988aa640ca04c765b6e79dd1c8f822c7 </div>
<div style=3D"display:none"> Gerri=
t-Change-Number: 1998 </div>
<div style=3D"display:none"> Gerrit-PatchSet: =
2 </div>
<div style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;stef=
fan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&=
gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 01 Nov 20=
26 19:27:54 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Y=
es </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div st=
yle=3D"display:none"> Comment-In-Reply-To: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt; </div>

</body></html>
--oHlMWbsY3uE=--


--===============8804953136485211113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8804953136485211113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8804953136485211113==--

