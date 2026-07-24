Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2CDC531FA
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=enXz3bZfhkB99/jcTVR1CG0/GF4+T9pMO9Sv0DRPHqM=; b=MprM1uXuGSgTd/9lFxtcOqZtfY
	w6C+IP7HMzlAXyYpEkKa0QkCXvjVtI5729xc/fH6XO+UPgBG3ZG8QXBex18UmooEPwASG/GToef7F
	2ykGrwj335PGjfrziE0+OcAPJZykRwkzmvt5eiG+M6XiUENo9Uoake87u0bFkQN4F0Vc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnDVh-0004kr-Fy;
	Fri, 24 Jul 2026 10:52:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnDVf-0004kQ-1p
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 10:52:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=n/7MW/QBhrO7Q8Ef+TWDVjjLQIgIVhmoKBe3+ydGUlU=; b=NnDaWbyZ4bcQRh3dGSPzidcq8Y
 F8cKqcpNyFOoyZU8+jIXpO6nCjekFpdv1ZVG8uF4j2llE8+53axwOWP5phRG6tsE+2LpBSChG8lJ/
 Xd7yuqboLVbYoPZyidGjX6p7SkQuPNSvzcSBs2PeImCaJfvxQ6h7nfnspRgxUTRWmGqk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=n/7MW/QBhrO7Q8Ef+TWDVjjLQIgIVhmoKBe3+ydGUlU=; b=e
 cZ34VYmkEx8+AN1TGkHuMXsLyHea18XUiPNOXfkAkvFkEdayU171efJwvlWkL5glOZZ0Wt0BnD8gm
 22w0CTXQL64QdloSFWZc1nEHQ4p3OBIcSPbUinuB7HB6CWUMJSKjBRlYN2psCdoj7KRQ3Gai+YAgf
 PkV3JCulcbocWUrs=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnDVQ-0004wc-H3 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 10:51:53 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4956869750eso2585305e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 03:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784890306; x=1785495106; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n/7MW/QBhrO7Q8Ef+TWDVjjLQIgIVhmoKBe3+ydGUlU=;
 b=EUhnNweIFEJlzGQbA0HeyIjluH2OzXtkSmE3ckl0He39uiRbOTZPRbywIPWCKc2Bsm
 CdwG+/mAvbKQ+sl/rNaQtp9EVTpmv7WOO2nDIodHOOOL410Gh3gIuSAw/PLpJCkWyLsd
 tIoKkDbEwKPgQRKrwWygPz/I8wHwjRgu0idPA1Z0bWqUrD6RD1F9BfujE+CUF6LYVAhg
 biSUTJEdcInxx6DZuWVNsEjjLsfwMVemnNpV9HkNo4IxNKuS+xnsMcH6e2ghxSVrf/g/
 FFJPjx3SnVKSBpeCiLEXWzgEvo0YLoFBbl0XBsNil7FSJwsZa8+KMgVHB5jIKCr7DUPE
 UCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784890306; x=1785495106;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=n/7MW/QBhrO7Q8Ef+TWDVjjLQIgIVhmoKBe3+ydGUlU=;
 b=YAqnr0sHRTxcqq5hEilHx/ko6lhowwIWpHB1iLQ9re8xgDECzEpEuSZOyeYb7zYq5Q
 DSBNa9NYBCyensUAvSq6s38Y/BS1bzQqqjfhq3wNncdcHLzdycdRBWFuEN4p1bk8n5xQ
 ozNExK58HWyIHszCpIAzLk+F6CPfVW16zU12sDeWLmlQ1/qVc/mtaAOXhnC5ajFNio8v
 oxyE5uTQwFyobaFMrfflos65H+dZbClkuKSJhwjwYHHJJplapaWNRdZ2rAMf+hybZwS3
 gWlEVRTbjC9NUVwN/IMpZrEiIXx2N9iPaPh32C/48MlZCcmfK52RgYhCjRI+xwlPh6SZ
 +Vww==
X-Gm-Message-State: AOJu0Yza7rwoDLeON6+/Tcq6wOTxyhvWVt4MyaOzJ5Gp0jb6exDA1Mv9
 RZk5JEHwyV2ma3YUeXsp8ZUqUF3L04Aap2YOIUXkTsoUhNweHorOKN40fN8RZFLIzA/u5YKWS8d
 V/3DacB0M08vgCQhofwwTA2XyoOsvAb4asoO45nsHrluiU9THWtOa+ylucvL6uPzpU/4N
X-Gm-Gg: AR+sD13WzuT8o84Ap0rkVuCMLvnxLQ9xWiq3kLGYk+KfOpOXI9OS/70Gik3cLYEj5h8
 lzmoPEKcBqMJ1I4bVLIdxzX5MdHYzGnnsBENlSl2ILL4b0KrM25upqzpgHrQQ5BBggFzPkcWYwI
 7w4j3Qdh1dc7MupaD53hAeJbbMgOqyls+U6x8DKc4yefNUgvJjE9oOt4X7RKxTXQadztdkorKUn
 BnfYiPv0Qu47PHdKMUgUkZ5J5hkSxngSUYFSyqcYENBL/lv0tNL9yudCGO/MNLXL11my2RN7MTO
 yfj2+nfFNFbDNPwxctxJ49FXM5fLjETrT4thyr/GXoNKRz0ywMJZXHW5Cfl4jdM2ro+S3lOZpe0
 PaoqOv5YKmOazh+N+jfbHw+Mr2uo+oMvV3IRLgVFr+r7n6XMJ2iv1RaeTplPVYmFHQ2GyJcItN+
 rvQDWRdZNJARKYE2GeM1SZeEHYLv0ot9wkT84z/YQeQKoIGTP37aryi0BbQoQE9ehmRPHlOKAnk
 B8XMS4SZ2Y+kJ3tsSl7bZlOkiIhEBh6gepvASrbpyh7JcktjFxAOuLO4gcO5ZzPP/X2marhmRUp
 HjA=
X-Received: by 2002:a05:600c:5490:b0:493:eccb:8cb2 with SMTP id
 5b1f17b1804b1-49573d2017dmr77950005e9.30.1784890305775; 
 Fri, 24 Jul 2026 03:51:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af78639sm61562965e9.7.2026.07.24.03.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:51:45 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 10:51:44 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
X-Gerrit-Change-Number: 1572
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1572?usp=email>
X-Gerrit-Commit: fef9e5ad8264e006527952f300f709209565136b
X-Gerrit-Comment-Date: Fri, 24 Jul 2026 10:51:44 +0000
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkkwNWUyMGY4YzgyNDk0ZTRhYmY5NmZlMWUzYTczZTFjN2I5MTAxYWY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c24307f0ac01ac34a7943eccd94d2c6b8939f9f5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnDVQ-0004wc-H3
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add aws-lc siphash
 implementation
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5004148192565745293=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5004148192565745293==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cS4P3IVSsmA="; charset=UTF-8

--cS4P3IVSsmA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1572?usp=3Demail )

Change subject: Add aws-lc siphash implementa=
tion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 12: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1572?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Gerrit-Change-Number: 1572
Gerr=
it-PatchSet: 12
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 24 Jul 2026 10:51:44 +000=
0
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--cS4P3IVSsmA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 12:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1572?usp=3Demail">View Change</a></p><ul style=3D=
"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail">change 1572</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I05e20f8c82494e4ab=
f96fe1e3a73e1c7b9101af6 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1572 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Fri, 24 Jul 2026 10:51:44 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--cS4P3IVSsmA=--


--===============5004148192565745293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5004148192565745293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5004148192565745293==--

