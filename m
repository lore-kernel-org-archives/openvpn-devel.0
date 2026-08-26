Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6CEC61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c4+JvJTtLBWnOyGvaYcGxOTL1RAyKUBlG19cA5sPTbw=; b=YZP7aX2X8Q0JvGZ6FidMcCr7GU
	5u99e7cpe6SzllF3WDb0oR3uW/gJHktMv8nq5ZWOFtUMcd946G9J1ckC93N5Sc/d/YBmgJfOD/t6G
	iOodx9Py8JVG1Yd2FpbBXJ2T//SVFgC2A/cS+1JU8mj0TIHjhVcuXg5i32I7xuZ/646o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz69I-0005V9-94;
	Wed, 26 Aug 2026 05:26:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz690-0005Uf-Qf
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 05:25:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sMXAHj0sKL9D+9r58h7zyV/otsFJIToUN92HmIr601k=; b=Usp05IfDN09IQgcknc6DDDF3F3
 BPoAvkj2vKtGcrOzgOj1crjO8FQDUG3n1lklOpDt/DgnmkrXfE9f+v/q1VXdfEBty5RlnCVDa52Fa
 N59f5O61kqy/xjt9bU5xzvgSRKK2pFC5PbzemEQpnABrWrkTrpd62FFfba2AsWs737M4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sMXAHj0sKL9D+9r58h7zyV/otsFJIToUN92HmIr601k=; b=T
 ehnn5TSwOPbWx1w69XM1KdAbaqUJfpJg6rrlfRuXhMIXi1DS2fZt88wdNQ9wVpMBsp3vYk9shi9cs
 C6ETKMKIEA2mU6TARz/tOFpGQRNfehoRLkvUkTTlju7JaYAkCBUPGHYO+ePoJc4AVEIof2BscZfAi
 H28JbGiPFtkRqvsk=;
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz68s-0005zU-Br for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 05:25:44 +0000
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c250a2bc3b3so60426066b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 22:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787721936; x=1788326736; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sMXAHj0sKL9D+9r58h7zyV/otsFJIToUN92HmIr601k=;
 b=CcP2wDzPtLi9AiQkktCb62aksusdZTFKrdWVOAgAps99xBzVHcjaKT2gAcoxH3XZ1L
 FAdXbvtnKDtltlIHcgrr3WSdjQicetHf6ydw81CAQiqhYKjpNfhbfZ35DW1NIQBU9DqD
 Ql5bQBt1ozSiDvZFJcM49hn3ebErXH+DruNOh0PYLM7Y8vu3uvoIuWPKB+7J1+ihQjOT
 Rd3de4UKVljJPel3etjhMKEq/yxVmg//G7u128b6FDwvQ4L8tCQA+j3ax0lQ9ITKbIUd
 Pqwl1QqYQnTRXabsgQGEtfd8NJ+PhTnORMJ99EOVDU9bV3RG2226D1DNcp3xLtn7derQ
 CPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787721936; x=1788326736;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sMXAHj0sKL9D+9r58h7zyV/otsFJIToUN92HmIr601k=;
 b=B0nbkR2pwxk1ioo8pg58IGEz9pXVM98loKlydNBeH/Cg+iXR2IcRy0lL5S9dGLdhDI
 VniYttppk9eLURLoT7Xo/IDu8rMdMbB7ZyKr8ogA0CebJEECLKJp/tfPfUX0D9rKJmMU
 aBP+6gzRd72K8WYrLGqAkkP2e0440DJVies1OcBtnvoW1nvFWjdLB3kv/bmN8xwUzVW7
 jUvUqDU3Rxpd/kuKYBO8qGd1dfakOSdpGKPsEwVKA8PEKOTzTH1xLkvMjIFuJO0mKZdf
 RTTurk4VNmm71N6+9RBm5wNqhtXyaGsTIlnsc6ZXUIrZv6vw98Q2a+sSiVzabBcOzfpJ
 NvaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCuui7TzeU5Cl2RY0QWeLk4G5Qtwqf+vaeY/dGdsZE2AuudsWO9x6uB3k+joTKb2/Cay78o0rG71JbuW1S@lists.sourceforge.net
X-Gm-Message-State: AFuF++n+EEk1QGuy4tivF5AGhNMdBlki9z7m566xvwaH2qnP2yVeKYUG
 kYur9EWtS7MEtvtdBeqQkLQ3705HcACvwJru+guCd/4ANgdhM5ppQOhg8nWZ1uWiPrUA3KrThbU
 XhQdzCTN2N2S1RmZnoGVh6D2gO4gAhUDo1ze29PLGsv/KmC51vb/0FTdXJDySuWxm0pSN8miBb0
 Y0uGf00A==
X-Gm-Gg: AR+sD13h7JFO+AAuc4qBMtE7lQHSo5u0tL10ePgobE03rYr8IdyDWduA8w8FnoQ+3M/
 LivRrUNwjfc3NVx5xvHAA7eo/Llg6ge6G5vTsu3OQRMrOmR7u/qxLSQ1wj8g8vjRQLccGT6nOC1
 3qtzR7aU00yeZV9f345UMKVdkzVyQRfVwIPYbK15pDgZB0Yd5mAPuBhtMVSskcnVK1CJB5F4jMs
 BnNxXYZLRvxWwDiyt6v6qunuVgZvN8SN+e1FkZpqTnt+mN3WQegc5L3N7qt4aOqYjrMtOiclYW+
 55fOrq7R9DzpDGvgWkNYE71ixl1IgiP5D9gEr2ZNaQbAyKgfxq8qGBTxenjFM/Fto3Faed4E85/
 cI0ZEHaGAm9+dKLxXIGoC9P3AFZOGStheaJHs0NtPLEWZRA1OTMjy2w3r81MdpAAMA6gam64FaU
 9z+Ob0mGFDf0NxIeomqzd4RHmuMy2MlZw2+4It9JYeGlkG0/wuG3c3jFz9yWyyOlf56g+FFb3zP
 q3CYFwbyYehKj3wwriJTe5hmFqLD6Pn2Oi2WNwXM8g1yQO7WYygvMkfVH5vV08m06j5SUOSW9wj
 C2UCUN1LVrgt1wBn9fUQsTtfHxFiT8HIXkbSs+5jMiLKQ8w+7ep0WVndaSCQH5s=
X-Received: by 2002:a17:907:6088:b0:c1f:9cdb:9965 with SMTP id
 a640c23a62f3a-c250baf9b4fmr511242466b.2.1787721935574; 
 Tue, 25 Aug 2026 22:25:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d68desm432239966b.10.2026.08.25.22.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 22:25:34 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 05:25:31 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2b15
X-Gerrit-Change-Number: 1259
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1259?usp=email>
X-Gerrit-Commit: 27a30f12ef7b9a1d4b225c948d0444472aa5dd1c
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 05:25:31 +0000
In-Reply-To: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
References: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU5OTM5OTE3MDAwLkk0MWI5Zjc2ODYxODBmMjU0OWJkNDk4NGNiYmY2NjA1OWYwYmEyYjE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8624160d4895f30fb70169e65caad745eccebfa3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz68s-0005zU-Br
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: Fix conversion
 warnings
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1414149569536576368=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1414149569536576368==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3Vt45svcY70="; charset=UTF-8

--3Vt45svcY70=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos=2E

ra=
zvanc has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail )

Change subject: init: Fix =
conversion warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 19:

(5 comments)

Commit Message:

http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1259/comment/b634d84c_8d885174?usp=3Demail :
PS19, Li=
ne 10:  - Return type of get_random is long, but we ensure that value
In cr=
ypto=2Ec the return value of `get_random()` is `int64_t` (not `long`)=2E Am=
 I missing something?


File src/openvpn/init=2Ec:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1259/comment/1b2e3467_cda3bcc1?usp=3Demail :
PS19, Line =
479:             const long j =3D get_random() % (i + 1);
On systems where =
`int64_t` (which is what `get_random()` really returns) is larger than `lon=
g` (which is theoretically possible), this would be a narrowing conversion=
=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259/comment/8709b5ec_0784e=
73f?usp=3Demail :
PS19, Line 2868:         msg(M_WARN, "TUN MTU value (%zu)=
 must be at least %u", mtu, TUN_MTU_MIN);
Didn't `TUN_MTU_MIN` stay `int`?
=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259/comment/5a083aa3_5ac86eec?=
usp=3Demail :
PS19, Line 2875:     return (unsigned int)mtu;
`frame_finaliz=
e_options()` calls `get_frame_mtu()` and puts the return value in a plain `=
int` (`frame->tun_mtu`)=2E

If the clamp above occurs, then I think that wi=
ll make `frame->tun_mtu` `-1`=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1259/comment/d9a9b82d_20f14b0a?usp=3Demail :
PS19, Line 2905:     payload=
_size =3D max_int(payload_size, o->ce=2Etls_mtu);
Should this be `max_uint(=
)` now?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/125=
9?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I41b9f76861=
80f2549bd4984cbbf66059f0ba2b15
Gerrit-Change-Number: 1259
Gerrit-PatchSet: =
19
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cr=
on2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ed=
e>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-=
Date: Wed, 26 Aug 2026 05:25:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-La=
bels: No

--3Vt45svcY70=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos=2E </p>
<p><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail">View Change</a>=
</p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1259/comment/b634d84c_8d885174?usp=3Demail">Patch Set #19, Line 10:</a> =
<code style=3D"font-family:monospace,monospace"> - Return type of get_rando=
m is long, but we ensure that value</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">In crypto=2Ec the return val=
ue of `get_random()` is `int64_t` (not `long`)=2E Am I missing something?</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/i=
nit=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259/comment/1b2e3467_cda3bcc1?usp=3D=
email">Patch Set #19, Line 479:</a> <code style=3D"font-family:monospace,mo=
nospace">            const long j =3D get_random() % (i + 1);</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">On=
 systems where `int64_t` (which is what `get_random()` really returns) is l=
arger than `long` (which is theoretically possible), this would be a narrow=
ing conversion=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1259/comment/8709b5ec_0784e73f?usp=3Demail">Patch Set #19, Line 286=
8:</a> <code style=3D"font-family:monospace,monospace">        msg(M_WARN, =
&quot;TUN MTU value (%zu) must be at least %u&quot;, mtu, TUN_MTU_MIN);</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Didn&#39;t `TUN_MTU_MIN` stay `int`?</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259/comment/5a083aa3_5ac86eec?usp=3Dema=
il">Patch Set #19, Line 2875:</a> <code style=3D"font-family:monospace,mono=
space">    return (unsigned int)mtu;</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">`frame_finalize_options()` =
calls `get_frame_mtu()` and puts the return value in a plain `int` (`frame-=
&gt;tun_mtu`)=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">If the clamp above occurs, then I think that will make=
 `frame-&gt;tun_mtu` `-1`=2E</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1259/comment/d9a9b82d_20f14b0a?usp=3Demail">Patch Set #1=
9, Line 2905:</a> <code style=3D"font-family:monospace,monospace">    paylo=
ad_size =3D max_int(payload_size, o-&gt;ce=2Etls_mtu);</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Should =
this be `max_uint()` now?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail">change 1259=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I41b9=
f7686180f2549bd4984cbbf66059f0ba2b15 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1259 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 19 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Wed, 26 Aug 2026 05:25:31 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>

</body></html>
--3Vt45svcY70=--


--===============1414149569536576368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1414149569536576368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1414149569536576368==--

