Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A36C4452A
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wC0gb/XHAx8avp4bSsjEFHah/TWfspXDq6dEeb050Fk=; b=aJ7NjFtA/DkUG+P9g59rb/eAll
	iIE7Ta19va8l5iioanYPpUuqOSUOq/xftAtN1fHZwXdsQAt2GLqo19M99iCtL5yvvISjMXSzQ/gXd
	hU1RL4l3wyayvCMQVSKwcgJZ1icDYWIchatrA2iPSoM1uwAO3VG/Jz7ToGn6QTGUBxm8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wlnxs-0000zi-CW;
	Mon, 20 Jul 2026 13:23:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wlnxq-0000za-Qz
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 13:23:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cnm59uTtxjLHpckXtGAg4/VkF2B1TmDFw0+9GMWov4s=; b=CPm1pmSTqWZIU93Xg38QLG/vbW
 aDGM5OIGAi1d7gHL+St62SGhBHqjFcBlgMz7SY4b+56BrOeIrUQeBf3o4+xUlKtkPpUHqDSbCFw4d
 Ae5pIGWBo32L6E+ZJax+OwFocz2LypyqsjKzrKA0ChUHPVM3BSGtVm5k//kiGJCK9q2g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cnm59uTtxjLHpckXtGAg4/VkF2B1TmDFw0+9GMWov4s=; b=M
 LJgOKl8uoV7KkP9c4qMrbZXMqIlgAOa3ypMRFS6wsVB7BgFI93QG5XaWYdYmHEQ3cusBOL3/SJ/jP
 2youqCqMoadtjtPht3onRTyX/TEmHLHEkFv313O81+R2dJdZUTYw3UgbWBAIHSt8nhYx8UuX711hF
 Cv9titlImhyq+pks=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wlnxo-0002DD-WA for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 13:23:22 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f703a9e5dso430247f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784553794; x=1785158594; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cnm59uTtxjLHpckXtGAg4/VkF2B1TmDFw0+9GMWov4s=;
 b=PXVVzbYjUj2N9RRZnYBfZ01teUDXKefRyV/8bUp7zdcfvxlkEpCfXKVaTYbtUA0P7W
 n+BUO8BXskshN5Cb+bTkQ14N0xs+DMpxYN3+FJiv/7NAHClnlnSv+vWe5lijtD2XcdcZ
 mky5lctyG5o5l1XaffIhdODRsLFHabEJPlLTbiN1GDomwNyYzBmFhw0RmABZG9dn7s2a
 v1XOw4tZ52KZ4fY83035OEyat4o4VlAEu3IuKyQWY5HVH/1ivuec5w+wABm86OG13c0K
 m5H4RZNIjZr66caAuKNfECP4XyG/RlrWQsZx++bV/pJUC50tNk1PmFpc0FsgMQ9PeNL5
 VCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784553794; x=1785158594;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cnm59uTtxjLHpckXtGAg4/VkF2B1TmDFw0+9GMWov4s=;
 b=W9Zr9N3Se2yseLdNOqBgRr7HWT1XmKrxxOBMNauCDawmHiAsDeRLyM53WQVxS3sXjb
 dyBvsHhUKHE/vv40Tz9+zHhPe9qFNU/vRq4kZtbvhrG/1i4FSUCvLH3Q16UN8M4NSCpn
 WvTWdQQWQJu1Q/bta3mBMsc9cQuDpZ4Yz2uon/sRWbkrbbN34PsxlQZNxjKcK8h0HohY
 1+AYUqcx50g264BdYWBC++GZ+fb6KN4LLEWXZjVc6yhEg0hgxClyW+L1y4pMW31INvj0
 QPKRWxTZWdKjWLicMBGKnlG/BI2HcQIVWiQLpMFtKtB3Jwuyql0GYaTgtOrCU9QZnv5k
 CrBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqoEmLDK7ZkcUuOjVfethilLgxXBRpzn2eCrGb5roU3h3VRhNP6PQfrfSM3LRUBQxsBWKqNHcDtJk3onTdc@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwuCrm2dLoiUCkMqSpi697xUbmAaOgeTCwTinHlf7KrJkRadpl9
 /WPHkQ4bZ4OxWmJcNRzcDm7bsNw1sBK7EZ1dsyb+5TeB6eZotCfmHtzIB7qpxvwBKFRyEbgqIqL
 vcUJ1EkDcEvoV9B36+ERgyGemVugFRACePG7zBQoE70KykxvnMOgoTP+a7u1xLXpZp5dl
X-Gm-Gg: AR+sD13Culb1UvuikF+uUohWGb5BfUFin2m2b64uSEa2ZFn63xNj/BEymTLb/W18wzF
 9cKKmkUdyQl2I4sv+pb1wC65zfQbZTq5vTrkndnEsxyn2kDELUNCo1gtYOX0tNJHi7vQXzXpSld
 qAroVYARv5SKncu6uR0UbXdHMeTxhMvJj2EnAqo3DkdWZZh2Cnq8aqlSPtvVPucr+2DHfglMZuS
 hR0g65J3Xf9QjPUJANLsTHLAPJOYmi17ERx/Fawc2+jbJL6eWmHhUYpoRSDZpA4luvj5Hb8DyZk
 swTQ83NmKY0vaPG+griOaZIwmCL5EY43UEE7VPL8GndqPNd1jQ+eKSJCo5+QwEItf2t/FJKNSW2
 UQc49Ee9CuBdFAkszRrvKJ1Vq7/Q+QXnh7ktfO/gocNxYhvzlXjNzH3vf9fsF6722E1m8o8d6ly
 VhfZyoFg0/cS38pyH7xpyMWSvQTn7O19GJnIutCPy/ECpOSzc1PPDRdgxaNyLT7eNaZv+NcMBSH
 Sz/AegqSubZfH6sHByO1Ix3ZPrItVImQaQhcq45rThdQeakdc4c+E/9KDwa4f6A7Lxw
X-Received: by 2002:a05:6000:29cb:b0:460:3233:beef with SMTP id
 ffacd0b85a97d-47f6232e61dmr12348622f8f.43.1784553794242; 
 Mon, 20 Jul 2026 06:23:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edda9bsm30865159f8f.31.2026.07.20.06.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:23:13 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 13:23:11 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 51378748df89363371f6b13cb0f78ea9fa38d5bc
X-Gerrit-Comment-Date: Mon, 20 Jul 2026 13:23:11 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <33752b140d06ce90c663b157cbfafe26e758c30c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wlnxo-0002DD-WA
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8877568755194920458=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8877568755194920458==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UUjSlTe37nU="; charset=UTF-8

--UUjSlTe37nU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add control message T=
LV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 7:

(4 comments)

File src/openvpn/oob=2Eh:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/8e8394ef_e1488568?u=
sp=3Demail :
PS3, Line 35:  * This slice implements the SERVER_PROBE / PROB=
E_REPLY pair used for server
> This is about series of patches=2E I agree i=
t might add confusion so I'll remote it=2E
Acknowledged


File src/openvpn/=
oob=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/65179444_a=
7cb9a36?usp=3Demail :
PS3, Line 31: /* Consume @p value_len bytes of TLV va=
lue, of which @p consumed have already
> Will change to real doxygen=2E
Don=
e


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/456532e6_83b2752=
9?usp=3Demail :
PS3, Line 105:     if (!ok)
> No, this is a bug=2E Will fix=
=2E
Done


File tests/unit_tests/openvpn/test_oob=2Ec:

http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1741/comment/5f264f3c_60e1f85c?usp=3Demail :
PS3, Li=
ne 153: /* Reading a header from a buffer that is too small must fail rathe=
r than read
> Will rephrase, thanks!
Done



-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Cha=
nge-Number: 1741
Gerrit-PatchSet: 7
Gerrit-Owner: stipa <lstipakov@gmail=2E=
com>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comm=
ent-Date: Mon, 20 Jul 2026 13:23:11 +0000
Gerrit-HasComments: Yes
Gerrit-Ha=
s-Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>
Co=
mment-In-Reply-To: stipa <lstipakov@gmail=2Ecom>

--UUjSlTe37nU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>4 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
41/comment/8e8394ef_e1488568?usp=3Demail">Patch Set #3, Line 35:</a> <code =
style=3D"font-family:monospace,monospace"> * This slice implements the SERV=
ER_PROBE / PROBE_REPLY pair used for server</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This is =
about series of patches=2E I agree it might add confusion so I&#39;ll remot=
e it=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1741/comment/65179444_a7cb9a36?usp=3Demail">Patch Set #3, Line 31:</a> <=
code style=3D"font-family:monospace,monospace">/* Consume @p value_len byte=
s of TLV value, of which @p consumed have already</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Wil=
l change to real doxygen=2E</blockquote></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/456532e6_83b27529?usp=
=3Demail">Patch Set #3, Line 105:</a> <code style=3D"font-family:monospace,=
monospace">    if (!ok)</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">No, this is a bug=2E Will fix=
=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File tests/unit_tests/openvpn/test_oob=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1741/comment/5f264f3c_60e1f85c?usp=3Demail">Patch Set #3, Line 153:<=
/a> <code style=3D"font-family:monospace,monospace">/* Reading a header fro=
m a buffer that is too small must fail rather than read</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">Will rephrase, thanks!</blockquote></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=
=3Demail">change 1741</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Jul =
2026 13:23:11 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments:=
 Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div =
style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--UUjSlTe37nU=--


--===============8877568755194920458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8877568755194920458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8877568755194920458==--

