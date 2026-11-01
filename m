Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EFA606A325
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=H0vzzky8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g+eYUYu/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=X3F16KBV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PLNHsxWA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1hGvBE/sxXVvsmHbvGz6iNp1ReNQa2HmdLTGM29mUKY=; b=H0vzzky8r8YRMT7InXs7iNYcKI
	bn2CVhbC125xDHB4PnxHnSHNgKoi69w+5Fz3dsb3k6sTBCeqpU3pNye4K4C7nVZSlM1B1BBdAncpU
	sN5ieQ7oQc+c5tBqYGgroe797Rj3pexwfn9D/QETiLZ1kGzv9G1WlX60wDmgxTVQ0RBQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNakq-0000000089B-2PW2;
	Sun, 01 Nov 2026 18:58:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNakp-00000000893-1lc6
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 18:58:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+TcO4XEfUkvS+e9xDHBOeO5OKdIFn/ANFky0Kas1YAQ=; b=g+eYUYu/2spwLJlk9m5i1PUGCD
 2loWssNoLuW6otXM3OoiVAp7FQaFbENQ5UOG4J63gdrhLahM6USlD8F//vNmrcOR8qMis10uATFlJ
 8fOrwW2wMJvXMno8FZMuGoYLhm/u3AKQ/fQlu6tuOvRVL6i2bBc/oVKT7ADPm5k3PAko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+TcO4XEfUkvS+e9xDHBOeO5OKdIFn/ANFky0Kas1YAQ=; b=X3F16KBVSuKtGwGohqEEU9OTV8
 V6q8dAc2N8IAtjzE7J3wB9GWJue02wrYgk2AH8Owqk7aMqiQS9GrQmRIkWbs/5IE1FS7YAI3WUsFz
 eDG+jI4lwxfrXjggV0OGduTnPyF9DGL7CMLsUi2+6oTOQmlh9WnA5VxqQRF78Aw+pR+U=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNako-000000000hg-0IfM for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 18:58:07 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso14387375e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 10:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793559479; x=1794164279; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+TcO4XEfUkvS+e9xDHBOeO5OKdIFn/ANFky0Kas1YAQ=;
 b=PLNHsxWAFjFS4Yl+el1Jbh7vGSIS31Ek2r/3mQM+Ex5CD6lrP/TgqwkKrM04oH1eQC
 m3Fy+jJxdDuiJAn9j3/l3dsNGyrl+U/AC86olobEn6Psp+ksXJV5P0LW0GE25FJkaYB/
 Cx0FL4KctMlZ9H447ej3zRya2u2gD852PO7VBezr4cNdbfWqC72ZQGv9SPO01fVjkjBk
 rJQb8NIrGdsRaJGLZPYqE7296bNdU+0roXhWWG23VPyxpFousdeGdP0cBLJIXUhHzgrm
 i/XFNvC6nazI6ibW8+txjE+xx21rB57Zl60JrwUuIOV0LM8SNjn1eCdyVGBXNxGAWfwD
 /n9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793559479; x=1794164279;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+TcO4XEfUkvS+e9xDHBOeO5OKdIFn/ANFky0Kas1YAQ=;
 b=iXDPexVpAd+/ytIKy8+RDJ1jbfa7OYTWiy2U2BHVLks60O2clbYT63Haa0G+EW9YSb
 atj+SCyhnqjWpw4HVwceHITSZPvA4pRaX2XMIOAm/uJWYFknzgKDlvTG2hw7cG4J+sac
 1o+0rQcZWx46/FXaXTCFab04e57xkujlUvlBgLsDNHY4J4YzteQykPwqFqdH82dyVdBH
 glELCqzeY4bwDrp52glx7ebaU9OV01b64Q49FrGt/E48AaXsggTfMl9yU3w4mVkM5ckK
 hgKzK4x66vQsoLQ2rVz8zOsgDEGpdpK/vPp55K+XexjxNzRQNuv5N4UPLzuy8n9WyOD1
 T9Yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFBWhEotYfKRCxTaGLOv81GdVJ0YP9FUp46zf5461DFP+fbRL+oJSFwdQCql8oZiYXXr2XW/lRydEIDc9W@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIoSn3E8PUcwZpTeQMerlmZXVKPOqC5dgsKCZjtlKM+THNTvKPK
 de/tQ/yaDO+sKszMZNUmv88G2xGdQVCoU4id66u/cCSYCMDn/qhZnnK9qeDl4F2KggMJxtTOztk
 zsVUtiYAKH2etOYQ8PZwsYyTAia3S1/WV30h9aoQrIpXh4g4fqjd55oyisxztmFtwQOjJ
X-Gm-Gg: AYBFou3c4/QYnpTuptK9lhbygPtuInY5yQ+bVPuAhUgrlqoMT4QnDTEN9OyQORuOFdj
 QtM9bE48FS7GeSL3kd6RlHlUQH2jxC5rzxpYbRqfCHnFFPkf3YEZSywTGHTcsUho7CAvClyQ6x+
 ESPgqN3XykkE3IJUS1S476KtOL8rdjP3rGwxCs9TD6xqOqsxtWcQqYchUMK2ddOgYMigGzm9fhg
 I8Ycp0sMfGPod6ADFKVr2Cu9CCP62vv50lbH1fI/cDVNizBdCEmo+nVmc4d9Or/X+dcQ5dfTe+e
 gtuc3O5YvKKzzaK7IbonpHKYB4PLsitV2zYl99teOqAqDYC4Vh01RfOaiV9kv4pwxJA2IgQh+OC
 rOhcryPz43/wPaqgWommRLRl9uP3RB4V9L7I2SmDIf/vccu2/t4XOhZ+2rrZB9Z7fcQwSii2aZH
 cvKGauvqiQXLQDCXq5iVNFrj6fMjhW1ux5ScTxOaquQ5N+k2L+EGg/IN/Md/yKMlbVaMng3k3wX
 uX0fpxFHNKijvX70kOsI1hnCQ7Ta5JVjP0k+ZawLQdSUfKL/w9ASjluCeDg/Tn+0QSzlJmY4let
 u30P9JXgpy5Wzzcnx+CsuTHn0f/RD6KOGz2putvNTBeMhZEzZMf0pSwnzoPD1c2jZDKes7HOkmC
 qlJoKGdhv58rjVANp3DdQtMeoNMM+DktiTht7riZtadXwHMyRsoait1m0wlQU7TUfqd+W9KUHQn
 42rN//URj6gJPNOBM=
X-Received: by 2002:a05:600c:5306:b0:4a2:14af:1ead with SMTP id
 5b1f17b1804b1-4ac183d2093mr190490455e9.25.1793559478920; 
 Sun, 01 Nov 2026 10:57:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896fesm325317215e9.10.2026.11.01.10.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 10:57:58 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 18:57:56 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
X-Gerrit-Change-Number: 2076
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2076?usp=email>
X-Gerrit-Commit: b9f4c1f5236329ee63284a2b85ebba5baf2095e1
X-Gerrit-Comment-Date: Sun, 1 Nov 2026 18:57:56 +0000
In-Reply-To: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
References: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzU2MDAwLkliNWViMjRiMTU2YWNiNWE5OWM2MTQwNTBmYjFiZDY0ZmU0NmQ4YjUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0c566359c0dbb74c0d40cf5e8e169aeb308c0304-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNako-000000000hg-0IfM
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth_token: Wipe
 the server secret key after loading it
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
 openvpn-devel@lists.sourceforge.net, hansaemw@gmail.com, gert@greenie.muc.de
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3139175072364935922=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3139175072364935922==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M4nm1vdIm5A="; charset=UTF-8

--M4nm1vdIm5A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, Hansaem W=
i=2E

Steffan Karger has posted comments on this change by Hansaem Wi=2E ( =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail )

Change subje=
ct: auth_token: Wipe the server secret key after loading it
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1
=

(1 comment)

File src/openvpn/auth_token=2Ec:

https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2076/comment/54c89017_9e7d7158?usp=3Demail :
PS1, Line 176:=
     buf_clear(&server_secret_key);
> Thanks for the review=2E [=E2=80=A6]
=
Clearing key data we no longer use is a good practice we should do more con=
sistently=2E This function seems to be making a lot of copies of the key=2E=
 (Looks like we grew the struct key_parameters somewhat recently, which int=
roduces yet another copy=2E=2E=2E) Should we not also clear struct key_para=
ms ?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5eb24b156a=
cb5a99c614050fb1bd64fe46d8b52
Gerrit-Change-Number: 2076
Gerrit-PatchSet: 1=

Gerrit-Owner: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greeni=
e=2Emuc=2Ede>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2E=
de>
Gerrit-Comment-Date: Sun, 01 Nov 2026 18:57:56 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: Hansaem Wi <hansaemw@gmai=
l=2Ecom>
Comment-In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede>

--M4nm1vdIm5A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, Hansaem Wi=2E </p>
<p>Ste=
ffan Karger has posted comments on this change by Hansaem Wi=2E</p><p>Patch=
 set 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 =
2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail">View=
 Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/auth_token=2Ec:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2076/comment/54c89017_9e7d7158?usp=3Demail">Pa=
tch Set #1, Line 176:</a> <code style=3D"font-family:monospace,monospace"> =
   buf_clear(&amp;server_secret_key);</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Thanks for the =
review=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Clearing key data we no longer use i=
s a good practice we should do more consistently=2E This function seems to =
be making a lot of copies of the key=2E (Looks like we grew the struct key_=
parameters somewhat recently, which introduces yet another copy=2E=2E=2E) S=
hould we not also clear struct key_params ?</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3D=
email">change 2076</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2076?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2076 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffa=
n Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Hansaem Wi &lt;hansaemw@g=
mail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Sun, 01 Nov 2026 18:57:56 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"displ=
ay:none"> Comment-In-Reply-To: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Comment-In-Reply-To: Gert Doering &lt;gert@=
greenie=2Emuc=2Ede&gt; </div>

</body></html>
--M4nm1vdIm5A=--


--===============3139175072364935922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3139175072364935922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3139175072364935922==--

