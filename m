Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3595EC54FD2
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2hhkfKQho/uJhAqOmEQ2fbLQskz6UXIrhvfl8hLHrns=; b=SRbDfaKy+gsyGp0sBwDmPjfq+u
	WJLSkE3BaetrkAUycqRzp2w2aphLqTTQ2NAAAVFyMyQSe3PlFJietJpx+HTAazVBoDoaTTu6ku+1z
	6PUTy5OtPMXehckLAIExTW8ZkFcWTntwi7XCahQYjwNA50ytOeGogaxtOOk4ZJcYIVe0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpNzF-0003tD-IY;
	Thu, 30 Jul 2026 10:27:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpNyv-0003so-91
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:27:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=q3va5L1FZcfZ/S9eQwWqi2vUiERS9KyEgeYERXVOgl4=; b=Iqejd9h6gjR4J4vo5ohE/MdnQA
 D1XGyCpbLH0C8bVFAC50XmbTYgL4gRgg+oF9wUAvgIwjTWjCgS5/PReOzif0LgGxxjja+Y+g2a8Ia
 5ESC2FpQD/FTDaBYjkFcE4QQ2V9eNqyLwzokaI446zvOh56WTqzUFRNh0K2cEf6ytZUM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q3va5L1FZcfZ/S9eQwWqi2vUiERS9KyEgeYERXVOgl4=; b=Z
 8H1ArwnfMLw3+TK+K+6RSBvKVTkPvVWHHsPolBuoD5VMT+nhzG4HJ6/lPGBgeupK7URaONDePNGPy
 vSnpLIcn0hRhUv7jmJuwwJB7jbSoDpbd9Y2QxuNMmPlOM/MvcRwE1iMYmRGsurd5HJWM04NMtbw/i
 LDiaGqFGs7ALZXQY=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpNyg-0005qb-4r for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:27:04 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso1655940f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 03:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785407215; x=1786012015; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q3va5L1FZcfZ/S9eQwWqi2vUiERS9KyEgeYERXVOgl4=;
 b=WjNH/w6dWKkULIOrcRM1F0csjCuA8kGuCiJEFngNuXP0nKIShIhIPSby9xGqHapI4e
 gypL2kFL4yXLIH0ZFR5b8HT14hJr9CXxrUFatUd37Uu8ff831tsjlT9+KdSbUFwrUFYe
 /96Ky+CPMO3atgJ1GUI1w+k8qOp7zRvK3b8pCFyJ0xreWwAPt5gr3o7JBIRImWZxwn6D
 9eoaMxWaLbfTPaWXLyE2TSLyuWd372q753uCD+Z0KUULt7yFr6zVumEnNNeFZTqDInuc
 7C8JkCROJ7gQ46XS1enibsynSVtNTOZA0GcBJN9ieMVpt+HdfJ3LDgXQ9+/r3sqalFvV
 BYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785407215; x=1786012015;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=q3va5L1FZcfZ/S9eQwWqi2vUiERS9KyEgeYERXVOgl4=;
 b=rqGMzCtSXitDDo0C6qATPIgDco8K5vKhtPTLhcqigtemjGswi2kVyV6l9x7CM2olos
 1Zbe3toR65KiGQ2TmzjC0wh37X1FY2tnyOsmfdCNdDhmBrDSlMgPuHnRIyQ7NZ7p8O8+
 B3dwnveOl4VnyVZckbM6hOHufKaKOUFO3UTaqFBte2UKaI+qqzjWkz0wt50KjVtdpQUI
 d1/yAz1+MWbZ2FMvR5bKCDtHXumfO8BDxjhm7tVEDTEr1RxaG3WNQgPBlTrTiF2p1G5Q
 kBYE9A7STEeh+bowe6zIxm5pkgQ4Zu4jybjANZqqaaSE1sEuxd0lU4iij28SuxdJ7OhI
 63tw==
X-Gm-Message-State: AOJu0YxAYUrId3IMYFokI0X2j2tsDW+oHCe8htZJ8krmI3HZQWLjLKyv
 9+jyNVEB6xUXlDeuFVbFwPJd+Gu4gpUQO8yzbpnMKxaOaqvSy1UZmTeJOsh4HS5OK4QRs/y7kaD
 COTZRn9dZknYSygME5hThtKGcis0s1UUMuFSputXGC+t1/3VtkprMPQMEo4sigyZDO3dd
X-Gm-Gg: AR+sD13wphVdaxVTXNF21lqkyczkXr1vtkxu31NbL1K1roLZw2uXn7C9vNLnudXGsfj
 YERSOwqL/orUu4B/mlIq0uvAodfYZy2Pbbz2FoBA7NO0LO0fhoASEpAbmY6Af0Eo3fptf6li/mY
 e5ygqfNttszhPczOXfBFWfjv2ZZR5vhF4lBTcrmTNS+J1SNtRZCST4VblTP9tOttwaW2NPGjx2f
 GoExllPJgNxgcno1nyzJWRWrCMHdMtoQW2pduXRGVf9iIP5h5osiEEOzxT3heB5mmKT4uUVRTGG
 4lqW2PPRUTiFEKDrG3U/RBfHMVWgSCCkN8CKZNmZoXXMDxrGkcivx75Ael9xaX/E6wWulZL9Sdu
 pNP46ElhAj0z+z/dq/PVt63XOj5juZiMxJ8vgPDwT+b4rxUz/rbHnMx9ZcfLGZXUvilBtNc0bEJ
 Pz+9b/sqtRVAyoHFSkY4vb5KZanRym7xEY7N/lSUq+67vfhudIcsJwhbL0xWGFPVW160Sls9LZP
 TMG2LCtiroYf/vzspgvCHSZa26oYi8+YuQXheVO6ow4/VlCHSVLXou4/m75UWwRLhacrI+EmohG
 RjttYhFqYh0Mmgb9u/YNDR0NnvgqWVinYyDafNb7Qdz+SdauvpU=
X-Received: by 2002:a05:6000:2585:b0:47e:9f03:e542 with SMTP id
 ffacd0b85a97d-47fc81fe870mr2894899f8f.45.1785407215354; 
 Thu, 30 Jul 2026 03:26:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc892cc49sm4991628f8f.17.2026.07.30.03.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 03:26:55 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 10:26:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
X-Gerrit-Change-Number: 1572
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1572?usp=email>
X-Gerrit-Commit: f225b8088e3f1528e265249674dda2449e83ad3e
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 10:26:54 +0000
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkkwNWUyMGY4YzgyNDk0ZTRhYmY5NmZlMWUzYTczZTFjN2I5MTAxYWY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <48f20d3b831aff5a5e4aedc0b65aafdd6ed17761-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpNyg-0005qb-4r
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
Content-Type: multipart/mixed; boundary="===============1453988320679491769=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1453988320679491769==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZrnzTslKOhs="; charset=UTF-8

--ZrnzTslKOhs=
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
Set 21: Code-Review-1

(2 comments)

File src/openvpn/siphash=2Eh:

http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572/comment/50f1bd52_999eb12f?usp=3Dema=
il :
PS21, Line 43:  * @param   in: pointer to input data (read-only)
I don=
't think the ":" makes sense in doxygen


http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1572/comment/a725d900_e6ee51cd?usp=3Demail :
PS21, Line 57:     re=
turn 0;
Can we please have a documentation for the return value=2E Also abo=
ve in siphash_reference=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1572?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Gerrit-Change-Number: 157=
2
Gerrit-PatchSet: 21
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 30 Jul 2026 10:26:5=
4 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--ZrnzTslKOhs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 21:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1572?usp=3Demail">View Change</a></p><p>2 comment=
s:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/siphash=2Eh:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
572/comment/50f1bd52_999eb12f?usp=3Demail">Patch Set #21, Line 43:</a> <cod=
e style=3D"font-family:monospace,monospace"> * @param   in: pointer to inpu=
t data (read-only)</code></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">I don&#39;t think the &quot;:&quot; makes sen=
se in doxygen</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1572/comment/a725d900_e6ee51cd?usp=3Demail">Patch Set #21, Line 57:</a>=
 <code style=3D"font-family:monospace,monospace">    return 0;</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">C=
an we please have a documentation for the return value=2E Also above in sip=
hash_reference=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail">change 1572</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I05e20f8c82494=
e4abf96fe1e3a73e1c7b9101af6 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1572 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-D=
ate: Thu, 30 Jul 2026 10:26:54 +0000 </div>
<div style=3D"display:none"> Ge=
rrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels=
: Yes </div>

</body></html>
--ZrnzTslKOhs=--


--===============1453988320679491769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1453988320679491769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1453988320679491769==--

