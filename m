Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F19FC54FDF
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UnW2SVEDrrpZk4TLW/yuHVmIYVDkNQoNVImIvnuSP+Q=; b=lab56cXUnnpoymQ6uts6H0WH4G
	mlLNxfX2Bu/nNsWiRWkgtEYUlY6j7vBmSVuYRqKshj+mAnCtu284dVXBV2MJ0MoRRZHOV0/srE1DM
	cJGqWXRvEGzRIcHazkeD3keLK4A59CFt8vS7lZCUpHi5+ApRSvVSsNnzWWO7Rl3b53dU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpNgz-0007Xy-4u;
	Thu, 30 Jul 2026 10:08:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpNgy-0007Xs-Id
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:08:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Km9wvNTRCvCs1/0XnWGOiQYtrOY2gP2VQ0O2Gp0Qcj8=; b=RuR4qUbTxFr9McGjTQSV31AXDo
 XIOAsv4W5wsqLpBVd2ED/hBhqusswhn22iJkzqBKR1Aneb9mwv49c2N9jFiUJarDTeCm0uJBa1Ffv
 fS3dPPJG0QrkbfMWRjA1pjSIdyqWFwX9MSLiuQCThDiRUZxwBZ3k0CITL2lxsmNZL8ho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Km9wvNTRCvCs1/0XnWGOiQYtrOY2gP2VQ0O2Gp0Qcj8=; b=M
 A5ktUSnbGLTnYE7JATGe5uZ4WbLX8EQlmcW8doY/+qKFv1IdazlNL5/fG2FpeCKFjzKxoBO96bDgl
 +2AubfdyKmc9Sid97vu2w0bO3fHoVtg4sCLTmyNu+Ldv6RYkCLJFjrlaem/zY7hJ/PMbAfYbbk0oN
 zEABQKnjTxXV3/qw=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpNgw-0005RH-Aw for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:08:44 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f64ca1c2dso640315f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 03:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785406116; x=1786010916; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Km9wvNTRCvCs1/0XnWGOiQYtrOY2gP2VQ0O2Gp0Qcj8=;
 b=Khi2XMAtoPH91gDJSIgSTxQAtKSVSwgqENkjG98G3RfAzyGc/f9pLHxdipG7S3m+IW
 2mxcC0l/OBRHrB0L6nVK2SoNq2KDtzUTJQyv7YEKyRKGLFcu70yc6lvcXdBShVqtCohH
 AJWubrVXfZMGPIVZMGgPYZVumXncE7GwF/Co5ma8+FIscVtMxIXc0GvoV4GD/4ynOSZl
 vX/LjXNhVPSkVB0hvzXpghCZB0q6ZNvfQ/Tr5LNCpGhjhyvq1FzNSOF72XpkYZdBooHw
 Ou3Ct0qQeY2FhuVUabtXBWV3aqObVZWE7S7VaD3lpAhvNVGjJK25lSgHSVnOMcA9ZNSv
 1scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785406116; x=1786010916;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Km9wvNTRCvCs1/0XnWGOiQYtrOY2gP2VQ0O2Gp0Qcj8=;
 b=js6nJEt8IKVSAjASCZMY5X6ehit6u1MHZZcgHnwc1YtI0sAP8WPOkYiunzgYMokhnj
 qPs+bNT6Sg8tRGSzlc35Uv4YyTgqxlmFbzsXE0HVSWQ+uzK8wIaPyikgOSsG/U8aRy3E
 wbcp9kKz61HpuciHQSrzyTPSgLzmkZ9MFajdA9+IQ0i0J/NGbXVFDKGmWdXbERYnXP32
 vrG60V5Za84ew58xF1a01PoH7fkJ1g/D2u9oPsOyJkVo2t+PQRVeZU7jye0CiJt2rE1P
 WgR4bZwHAxIgqTlbDVy3KcFzzw2aUT04p5KD23xpM2Brg8nnlFMK+l3PW4LvwdbqUJXh
 VYUg==
X-Gm-Message-State: AOJu0YxP0e5wZQK/T7KMwUacxDbtNdxKn6yk1nw7pjhnBdawdmb/NvkY
 ubQoVOkqV/BlCsq7Sw+fw5cx98ydrgiXDE4dmBJsZ2lS9kJeY3wM9AMRCjwIgRL/xaoLUbH8Ez6
 drBMDR4Tb+WxjJ18oXF7TFufQ2clkRHRbkclVNGG4lMb1BmxYbNLY+Bq5tLaShk9TlxUc
X-Gm-Gg: AR+sD13LPAmVC2C9S+veAhfYezWdy7eFSd1FrmeqL70I2tMvOLWTH0L+BbM+eFB/2b8
 2e/FUshzfepL2wo37l36HtiVkoY5fBGPOb3ZGT+3hB2oHGvar7l+a4dUzTEiSesA0tBwr8KcSCg
 veGsGaoNgqpR9Q9X/82N25Sq/zfvo1OKknVxDwv/PflzRUZ2vML5WfIxIwnYFnL66rSOOYWQPyF
 oVzQfwgklTdswtCL9WpBFObabN5u3MQEKgwo+2WbJdN/2YZ+U8WNiU2e24LDv5rJA65pxD/34wv
 pt1xk4j3V3FqHGX1KFf+VEA20SK9pqUhWWfPrSg03J7z7NdRMNszKQVMEjZK3CtAlh0gUBdhioe
 xT6F3EW45xg2TcRSaCVdZwvKdRXJEg0ZeJfgJ/6ZNSUdDFF419WtnCTDwZtt6tElkgCPzJkvYcG
 ia4tg8FGXJHiiXdAErUo1VyVFNxTowOWT57CGHhbErmfSd6dRspPTrHoh37ekrN4xS81/xWANmL
 3XXCeyJowsT/w9K+Tril3fM41VJCknFA4LPvGfWvujuXfhQP3qwrfnumYhpbsjdIkzOw2ZV5xkA
 NRIse9e1kbgzSnawd/z6fxcZcokNgs83nmHPwulf2Y3pOTkz690=
X-Received: by 2002:a05:6000:381:b0:47f:77dc:b066 with SMTP id
 ffacd0b85a97d-47fc80c78b5mr2647838f8f.5.1785406115535; 
 Thu, 30 Jul 2026 03:08:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc893fe58sm8033555f8f.31.2026.07.30.03.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 03:08:34 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 10:08:33 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: bd364225ca43bff02e48a74bc08220ff250e1bc1
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 10:08:33 +0000
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e23aa45088b20d122e6b6703acdc1b68dae5e3d7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpNgw-0005RH-Aw
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Use OpenSSL's
 SIPHASH implementation to double check our implementation
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
Content-Type: multipart/mixed; boundary="===============5246065052565103283=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5246065052565103283==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="63ZmMWeVJOM="; charset=UTF-8

--63ZmMWeVJOM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/31?usp=3Demail )

Change subject: Use OpenSSL's SIPHASH implement=
ation to double check our implementation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 28: Code-Review-1

(5 comments)

Pa=
tchset:

PS20: 
> I changed the commit to only double our implement (or AWS=
 LC) and also removed the whole context stu [=E2=80=A6]
Acknowledged


File=
 CMakeLists=2Etxt:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/7c=
17fa3c_8c8925c9?usp=3Demail :
PS28, Line 801:     target_compile_definition=
s(test_crypto PRIVATE PREFER_OPENSSL_SIPHASH)
Does this still do anything?
=


File tests/unit_tests/openvpn/Makefile=2Eam:

http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/31/comment/e3e08277_ebd09952?usp=3Demail :
PS28, Line 102: 	=
-DPREFER_OPENSSL_SIPHASH \
Does this still do anything?


File tests/unit_t=
ests/openvpn/siphash_openssl=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/31/comment/3f47a563_e861ae7d?usp=3Demail :
PS28, Line 2:  * SipHash refer=
ence C implementation
Wrong copyright header


File tests/unit_tests/openvp=
n/siphash_openssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/commen=
t/54f0abd7_e9a26545?usp=3Demail :
PS28, Line 35:  * implementation, so we o=
nly use for unit testing that our impelmentation
"use it"
"implementation"
=



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09aa27caa1a3aab0d1=
be6118b26d54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-PatchSet: 28
Gerrit-=
Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Comment-Date: Thu, 30 Jul 2026 10:08:33 +0000
Gerrit-HasComments: Y=
es
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--63ZmMWeVJOM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 28:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><p>5 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?tab=3Dcomments&amp;u=
sp=3Demail">Patch Set #20:</a> </p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">I changed the commit to only=
 double our implement (or AWS LC) and also removed the whole context stu [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/31/comment/7c17fa3c_8c8925c9?usp=3Demail">Patch Set #28, Line 801:</a> <=
code style=3D"font-family:monospace,monospace">    target_compile_definitio=
ns(test_crypto PRIVATE PREFER_OPENSSL_SIPHASH)</code></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Does this still d=
o anything?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
tests/unit_tests/openvpn/Makefile=2Eam:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/com=
ment/e3e08277_ebd09952?usp=3Demail">Patch Set #28, Line 102:</a> <code styl=
e=3D"font-family:monospace,monospace">	-DPREFER_OPENSSL_SIPHASH \</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Does this still do anything?</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File tests/unit_tests/openvpn/siphash_openssl=2Eh:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/31/comment/3f47a563_e861ae7d?usp=3Demail">Patch Set #28,=
 Line 2:</a> <code style=3D"font-family:monospace,monospace"> * SipHash ref=
erence C implementation</code></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Wrong copyright header</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/siph=
ash_openssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/54f0abd7_e9a2654=
5?usp=3Demail">Patch Set #28, Line 35:</a> <code style=3D"font-family:monos=
pace,monospace"> * implementation, so we only use for unit testing that our=
 impelmentation</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">&quot;use it&quot;<br>&quot;implementation&quot;=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/31?usp=3Demail">change 31</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messa=
geType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf=
7aa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 31 </div>
<d=
iv style=3D"display:none"> Gerrit-PatchSet: 28 </div>
<div style=3D"display=
:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 30 Jul 2026 10:=
08:33 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--63ZmMWeVJOM=--


--===============5246065052565103283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5246065052565103283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5246065052565103283==--

