Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248BBCD6E7C
	for <openvpn-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GfgPX3hcg6/Fvx+4cQJnc53vgd+z9aabXI3Z6Wvzn5Y=; b=nIWLt2NAwgLR/7wrs5MrwI5lMw
	w9Ud3Aev5dVkCGkvYqlSwzv7nLMQesrFHH9dxZKA7FOultp/RlIUZf/oHQHXiRt5f6FFjOTcOAyHN
	G3nO3sV7VNrtN+xr9sBVMo0MMBGHRq01zkPA+OiPSIHUsuo58i+oyahTmE9JmduqVKEc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wVZ0P-0008DP-7L;
	Fri, 05 Jun 2026 18:10:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wVZ0N-0008DC-V3
 for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 18:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fm0gqBnFgdTPMnGMhPgJYhGJ8RhYeZnzVkfKpH2F/bI=; b=nD1hwNOEG0Y4p11b7EqaMuP8Bb
 RmPgg09stFsle1xQvwgl3dq/MtFmPULfhtCu42hspIP1aBttPDavFeXypkhJ+TAbf4K0yrHUvt3WM
 qhOumkmcr+jwmho8eTU3tUYA0QQaPteDytFV2QuqOgM37LpIvDnPeoh/V2Vr9yHrH/QA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fm0gqBnFgdTPMnGMhPgJYhGJ8RhYeZnzVkfKpH2F/bI=; b=Y
 wyly26XUssfUqermNcif+1s3tT9+GmrroCsNoFi0tGeL8yZxmfKJFM2GI0E811xPbomcgh26kiR4J
 Pct75k4ZAsli1VQL6qUfh8MkZ4RMELiCAVCjjqwgU2ZeJhgWlKYuUa+48oeineLZGXXYtOXQElfHa
 4K80/juQbBB8UADA=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wVZ0N-0002a0-DI for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 18:10:52 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490be29c1c5so27186845e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 05 Jun 2026 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780683040; x=1781287840; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fm0gqBnFgdTPMnGMhPgJYhGJ8RhYeZnzVkfKpH2F/bI=;
 b=EaZdvPRhD2UhVHK6pDFBHt86H8E8tU8Kny+Y4s/Gi4FDZwdf7d/lB3Jue7vq/KAXuL
 EPKtlHd2OwFH4vaXUJc8jMWCAPRjWHyvX4GQdUsdIzO3qbDFXpSMIkLOd7HjyI1F7NBc
 sO8iiGX0KhtYvAM7wG+egiOypEMre+HJRESfDMpD9wyk0WQJgrPAwyRUMDEoKE7kWQvm
 WPwAvU++CNzDPu4JF1bqUBAxQTBQutYUCfh29gUk3dAMZbo/K4kvpOibPHhI1HUDccEu
 RDJajfIH7E5tdHZClWW8NW2jLluV9SqF+wgp2cZObC3+jcU/sqEQzNNc4884sqoySx6I
 UjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780683040; x=1781287840;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fm0gqBnFgdTPMnGMhPgJYhGJ8RhYeZnzVkfKpH2F/bI=;
 b=OcLn483AtO41HwS+7y1icS4FhJidUOC2Fd2b67O1bVL407108W9sY56f7/JavZPSqo
 QsDbEK6wbzoulTmhwyjKwIc7mEfem8ICX7R/ibMfP4RzFE/Kd78VYUDtlAuQajeBTH0m
 BDZNCt3K6I3bcZq9EkZpArUQtEHZeb3Ov/uQwJTEzjNYFNLQOPnaq5FqwlDzjDcHpAfi
 4YPjDbw6hrZCoF4kjZ8jd3G0fX2RSSwug9ish5+rfLpp1a6IHf3p6ImdDzvIy1R2Rvg7
 1l+bKW2vaZiL5VFdQ0EVdDkK80hEXezOWFRno6SxV3ISsRfa/UEe6Qe/KnTag5ldLpUl
 fRyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ88OK0HKYwk5ctOKESCVeXHP2GBU4uGBeEdlYa08XluRixlDy9W+w+bUXyNeQ3//zp2dNfuOMiFV+idYu9N@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwjCIg3ih9Fn1HdiuQ5lPu3iAWBQKeaOxEKPRy5/14ZgZ9Si3fN
 9LmncGn3Bd+G8QSadJt38n0ArkAVM2AJ7vZgtsiGnFCL+A/LF7Dt9dvDa19aJHLMbkCmKBuDf4A
 NA84K3wc6gXPruSPoo17gF/Oxmdn6FAVfhjU1NXqOipnPCB8N3m3eYm1ccE8wWHzdjCrZ
X-Gm-Gg: Acq92OFVvFwUQwpAhYC/P5JsCP4C/pTlqcvwwwMYIWwWx81WTED3zBxFL9XjlyPjfh8
 +Uas8VhnReCNX6Gm1eCiG0ID/xYAtVR5J+yw6ZztKlXggK6527rSWbyC4z88iR44+30w3jlGgYk
 IKSQt2Dwk4j4K905ElRAXTmYkhrVa3uPImfm/0WJykEwSQJnLkzyovgXtyqnK8Gv7F3Lh/rGlNp
 Pdfh1IPsS6VxjufzwCMbby9PJp2D0d9rjvu+TSNYmUV+sMQkQ3Jkzuu6h7VbyfyGxtkrq9Y/QJM
 yOKsUAMckYtTFFKdoXwYktyN6VY4KupZbGZ00EKAmy6OOF6Qgv5TJSIAoEbrC00YsdxvA3govNR
 SH1nLCEEAev043A3H5yldmZXMiX0yK4l/oAqRyII1KUyM6z9n7bAy3yks/G+Z7XtoFL88wXB5HL
 FcjNAKgrqfAO/T/qeAsfLGsd0uQERzhICvn77BikctKZNB0KVHsCjMCxSOHwpG+aBQhegZCizjY
 kzD0p4aj23Vdju2hLz8hKrasBGvXTOGvCZ9xYmJUCaRZWwh60cqjdXMvAeuMdAG7w+Xzx3yYCQb
 Vgog2uWMECOFcEucnn3JfEcT
X-Received: by 2002:a05:600c:674f:b0:490:b4bc:4f3d with SMTP id
 5b1f17b1804b1-490c25b06a1mr78132585e9.18.1780683040190; 
 Fri, 05 Jun 2026 11:10:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918fcsm194878655e9.3.2026.06.05.11.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 11:10:39 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 5 Jun 2026 18:10:37 +0000
To: mrbff <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5
X-Gerrit-Change-Number: 1705
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1705?usp=email>
X-Gerrit-Commit: 62a69f3f1b48950d3ae9c825946cb448c4206908
X-Gerrit-Comment-Date: Fri, 5 Jun 2026 18:10:37 +0000
In-Reply-To: <gerrit.1779896625000.Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5@gerrit.openvpn.net>
References: <gerrit.1779896625000.Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5ODk2NjI1MDAwLkliNTZmYjUzZWMxYzBjMzBjOWFlY2JkMGNhNDQwZGUyYWZmYWQwNGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5513cfe32523fb4eafc50e7148c0fd188445f04e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wVZ0N-0002a0-DI
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: allow
 passing KEEPALIVE_TIMEOUT without KEEPALIVE_INTERVAL
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5868198694002495576=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5868198694002495576==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FRn1JWNpySg="; charset=UTF-8

--FRn1JWNpySg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mrbff, plaisthos=2E

cron2 has posted=
 comments on this change by mrbff=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1705?usp=3Demail )

Change subject: dco_linux: allow passing KEEPALIV=
E_TIMEOUT without KEEPALIVE_INTERVAL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1705?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5=

Gerrit-Change-Number: 1705
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@m=
andelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: mrbff <marco@mandelbit=2Ecom>
Gerrit-=
Comment-Date: Fri, 05 Jun 2026 18:10:37 +0000
Gerrit-HasComments: No
Gerrit=
-Has-Labels: Yes

--FRn1JWNpySg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: mrbff, plaisthos=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1705?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1705?usp=3Demail">change 1705</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1705?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib56fb53e=
c1c0c30c9aecbd0ca440de2affad04b5 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1705 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: mrbff &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Fri, 05 Jun 2026 18:10:37 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--FRn1JWNpySg=--


--===============5868198694002495576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5868198694002495576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5868198694002495576==--

