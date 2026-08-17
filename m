Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B87C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CiQ6+/cNfQkkr16jk/9tba2eqJp+93oN/AzgneOZ++w=; b=bYTN2+WS1n+BgVXPQcUsZGHyTx
	iIKN3VgVYPOICMIuVIkCz2aPFiw9TUw/FUclMDebQIRVClnzeRLsD+3rlTVPyLLdNY+gAzVfej8Xc
	3UjrKLFdX/VDkcgEt4tWbZQC+mhNr9ei67yDyXTIixsMy02fp1WVqoqRS8ZMHAgGLVBU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ww2JQ-0001We-K5;
	Mon, 17 Aug 2026 18:43:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1ww2JP-0001WY-Gs
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 18:43:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hDprBKMNIbFQxYkv6WEQBpO+OCiu4P+bEGDxyP6MJEA=; b=ICOlljwjqYKgwBkvkOCuhAtzaA
 gqJ/GDrW86+DTZ7tJaDfM7hO8lSrJ0117MIEEolKXdwPnPsy4G6uvWH3PG1XYIxEAjZMQppNZDBY6
 /YsHvfiVkogxkWJz7+Z1cvAKS05BLNjn0xT2tQQ8LxzUrwRVK1E2kGkyEM+AyqOUb7+s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hDprBKMNIbFQxYkv6WEQBpO+OCiu4P+bEGDxyP6MJEA=; b=L
 W3CxhwdpSl/LlgJhowUNPqMeWBjrmxRTnvSqhAwCLKC7vJYkl/DoTuzIw1tPAvNxj+xwFBSIdYTKd
 4pTZbgvD73ZrgbScktZIb/5g2hqw1DYycGCwLEax5GbUhrjD3iGMnZvYL8vQ+uQX3GiGjvBXOaPE6
 u6QkkxqATPMcA/3Y=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ww2JN-0000Nx-SZ for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 18:43:55 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-480001972b8so1523663f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786992227; x=1787597027; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hDprBKMNIbFQxYkv6WEQBpO+OCiu4P+bEGDxyP6MJEA=;
 b=HR229OcioYFaSviNMT5slSxgSKHQ61YBqCUeYUzqcbhg0ytC5mncM/4j66S7nVh1yn
 cFFd0KKnPy7z1mit2hn1aYgusyUAwU3dn07j17n8ZiR8kfmBFCxCI+JRCgflPfIjB5k3
 y0jxBl6J3CyExESw3uGcjMwhJbqQiFYegmKR1r5XVfUpzurymKD/+d7f5hm0ZSBRHEEo
 C3MuIEtwxYvaeMunvK4/IxTkzvGzzilbr2TmV6qsJ8QpVpk+jqoDTmNDVZ/0MaQoc/co
 L5LYHPI/1cWedmwwIeiZiF8S1yeMBBpq2Z9vNulVimqgVMxD2Yvj0OIJ5ACzqCVO0zNk
 5v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786992227; x=1787597027;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hDprBKMNIbFQxYkv6WEQBpO+OCiu4P+bEGDxyP6MJEA=;
 b=TXJrBpK1yUH46gvWBSVhay9qeIP/UQwKKCfgRLivYTWtk8uT7brP3KG4j7wSEoGf/n
 67/o9QpWmZrDU56A/weR5IQtxBaaaazt0z9qM30aiu3m+7eBXF8sg1wBK0sT1HUXO4+K
 8fax4eQQOLnO/SYxQRZuXdT1vW/t4YjiTNFPooJG0ORLc+NY8rCPdhWJ32zQVvbgoxJi
 rB4BYOuGF6wWd8qauURh24VJsKsnSdA4cfMiKYPUuFW+Ru8omWPQnAujOEf4ihpM4iEu
 8c8sK291jD7h5z6wCjd7NIL5sJt8pK63vOe8WPVQceqauFZdBBds52jam7pqToIbVmh6
 bNWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUaDwQjUn9QQecwnCHrkSaZpI9GxyAhWfETektWmqClI1NbGHxEYqm8c0mGFro0nH9vVnb8O2V96s0vmsZ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxS5uLVi97cWz+eub2Y9bUWsOQRFakwIDz0dldH3K2hsuLeAKzo
 JIc3d4plvlaKy4um3AfKT3wFTrww/E7Jm73XCFBuaYOQtqZDbbwUqZPVqG3cLaWXDfX9VeRPZZk
 AQLEp3eXAC9GgSZ/r6MtpOsAx+v1UGGF0Mv/sv1x+69p7a3a2xwXjkuJ1oQpQvE8m33n2
X-Gm-Gg: AR+sD122ANcvHcBuPuDhvOu9Ev3cZl+0/N3ofg8LseX3/Eaf3myFiXNXJX5e+iXuDeQ
 E4cqtBhwK16w3MGvruErk8i6w1gfY/okuL/TXTNftFUTsbhmvbZ6W92IIkbsUo2tI1UvsRoXvW2
 qH5WEiq/l8rBJVIgvqO4XL9hu5ot1tyIaVcuZH4xrxBx5bQzcy7kzZs9T+Ku3LE9t6GtQCGxttz
 ANDwNNG1t4LRrwfU/z1Hc5dl12CJkoRVOUD7TF+QD/5EwXVP3DLYchSVOV81Ye5OEB4sHzwuJ79
 QHTGip0cMS2sKYhIOJ4PiGNCRqNwsGnJVUPzzRXh2UR1TOKDOCn5i6Xu/qfTE2/12SmZAmNssVy
 r3onqveA1W1yoWNY7uvV0nKSczY9vGah94/X2WoLcvHzJ2MFZhDHfojAlxDye+93mYuw8NwktQn
 9ljCInHtw4I/z2LMi8p2tuycnCA0j07xhHxa1ZlJwvRB8+o835HkXANbrc3SSYvObuGsjcCaxcS
 ES5bdMjum4PpIzfU6GDljX6GiLWJJ3nczKB0TyyPahWaBhtFG0UgtQQelqRyUxF8Gx+L5vXtCim
 geBrCFkUPwSZSTE+mra+6drSN24K1DgzJ/PdIWRJpJLvr5KM9BY=
X-Received: by 2002:adf:e94d:0:b0:47f:9d0e:f8f with SMTP id
 ffacd0b85a97d-482a90ff67amr3136167f8f.26.1786992227163; 
 Mon, 17 Aug 2026 11:43:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b2e9sm6154097f8f.9.2026.08.17.11.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:43:46 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 18:43:45 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
X-Gerrit-Change-Number: 1407
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1407?usp=email>
X-Gerrit-Commit: 8535abbeca3e048d7a90af0e14bd5d812649fe86
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 18:43:45 +0000
In-Reply-To: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
References: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY0MTY4MzQ3MDAwLkliMDU4NGU4NzI4NzAxY2NhMTBhYzU2NzVjOWNiMGU2ZjVlYjkwMWFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3f8c5ece87d62b1012065fbbc13c7abf6cb185f6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1ww2JN-0000Nx-SZ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: packet_id: Avoid
 conversion warnings
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4484971518644148171=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4484971518644148171==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SOWrv5GC2QQ="; charset=UTF-8

--SOWrv5GC2QQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1407?usp=3Demail )

Change subject: packet_id: Avoid =
conversion warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 8:

(2 comments)

File src/openvpn/circ_list=2Eh:

http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407/comment/bf558a9d_7044c752?usp=3De=
mail :
PS8, Line 63:         const size_t so =3D sizeof(list_type) + sizeof=
((dest)->x_list[0]) * (size); \
Strictly speaking, if `size` is `int` this =
still breaks `-Wsign-conversion`, but we're using `-Wno-sign-conversion` to=
day, so it should be fine for now=2E


File src/openvpn/packet_id=2Ec:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407/comment/01de02bf_b763fbda?usp=
=3Demail :
PS8, Line 658: 
Accidental newline insert?



-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901a=
c
Gerrit-Change-Number: 1407
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Mon, 17 Aug 2026 18:43:45 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No

--SOWrv5GC2QQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/circ_list=2Eh:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1407/comment/bf558a9d_7044c752?usp=3Demail">Patch Set #8, Line 63=
:</a> <code style=3D"font-family:monospace,monospace">        const size_t =
so =3D sizeof(list_type) + sizeof((dest)-&gt;x_list[0]) * (size); \</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Strictly speaking, if `size` is `int` this still breaks `-Wsign-convers=
ion`, but we&#39;re using `-Wno-sign-conversion` today, so it should be fin=
e for now=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/packet_id=2Ec:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407/comment/01de0=
2bf_b763fbda?usp=3Demail">Patch Set #8, Line 658:</a> <code style=3D"font-f=
amily:monospace,monospace"></code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Accidental newline insert?</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1407?usp=3Demail">change 1407</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1407?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb90=
1ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1407 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Mon, 17 Aug 2026 18:43:45 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: No </div>

</body></html>
--SOWrv5GC2QQ=--


--===============4484971518644148171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4484971518644148171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4484971518644148171==--

