Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C15DC5AC67
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 12:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XCSkI4r1W0DmnXw/wDFYWFEwGF2w4TFRlWc4Wz2McsU=; b=PAmyxsUvs6FrI8HdgsRFxlY35z
	ZxkPdXp5CSurB74yr8pHhsw2cgkcVM+v3TNsUfB3avRQF4Z/QaRo2rM+YNoja7DFdzm/QtUAvZNnE
	5HWxt/Gn+Dt0V0iulHbDMOr92HpS6X9hNH3TZgBmbct6mgxPInRkzArGmMOKz8fA6jBk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsgeS-0003cR-JF;
	Sat, 08 Aug 2026 12:59:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsgeQ-0003c5-Q5
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 12:59:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bDiDNsOobXYj/RXw1IXICy2RLT/oN6QPGETmWiOp7fw=; b=UVAi+yzL2e0vQTAVOnE7DORTc/
 2G0bK9lBNQA8Mh4pyXDuQJ5ToZtpnRwzGhSYnM6yaoZy8GumjZ69Mh9cmiwi+3StZxx5AZiTKnQ0N
 mWSYFBRcbs9X/WCim8dSxh0tS10IDQTki8mrLkGDmlV800t51kHz91pGc54qAoUFkzDQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bDiDNsOobXYj/RXw1IXICy2RLT/oN6QPGETmWiOp7fw=; b=T
 TgTeMwvlBrPkl4MukQShYdXV/6ax01DEoZ3aZ7EbXTXwcZYQG/TQ7mjn60eOa7BeywXRUdbgE14if
 Uso5/9n8EPl26B1cEguigqv06RYkfiPn/GFrEByJs7o1AVLmOkbFZIs6NO9+RVpJkeBr/RieQjUYv
 TgHjhlUhdFeyHp4g=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsge4-0001Ho-Ee for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 12:59:21 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49557167508so3308475e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786193954; x=1786798754; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bDiDNsOobXYj/RXw1IXICy2RLT/oN6QPGETmWiOp7fw=;
 b=GUFf8hKPYp6U/rcF6b0sN+3FQNoIMTod/8dEHjcNv4CkR5xckpcOI3BbH4BqR04yjS
 CTADlbqrH7syxAOZygrrLSF6c4fE/OWQBUn+BZtT5sd4EpLdRXJLPmjyRgLtgCnvpCBz
 DliS5DiTE4lw/8zI6hji4tMOdS1g7umk5tSfeAn2hLoY7WsbztEVqkY55lm0RJfF36Fx
 nfjZXm09nIWZDYBiUJ9imOtgaHK7n4/N7MbPuAhk0/7RQ54LDtMWkgstSwM1yK64NsLt
 9TN+HmyAY6NmkV0cWJd2ElEpO7WDlfSwrmNbLLuxJamj+BRmnpHLLSx5RohoIHWzh5Md
 flkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786193954; x=1786798754;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bDiDNsOobXYj/RXw1IXICy2RLT/oN6QPGETmWiOp7fw=;
 b=AWm9DmiAkhTSYiFL4IBJbpHXbyVLqJMkUxbH1nHnXmgCifuxYPA4eCMgvZpMiBF3t7
 eYhfEf4rLcPIwPHWX8UpvUddlvA6CJzaOACcc/GR5gsjtis97b0T+KmD5e+SgVZ2Z1qF
 IXJdeGnUD0woEjCvPxNaNqnZOhO1BPTNnobXdG/NBdgPmdW3KCaVOLHwXvONwDbT4m6S
 ZTIp6Ul+siy1YMrzq/QH8diWQUa6dvW/pg+pkCi0EUFUTVHzHI+CEMqv3MQnwRQ8JgEj
 g4KRA3vwScFi5zHrmQRd/B/Oq4fzB63wlfi85/BXFQmiG2PIwHv7HjTYMdLLV+ksdZdq
 yEkg==
X-Forwarded-Encrypted: i=1;
 AHgh+Roovax1YSc2aGm/wPY2ZzqEJgHH/wEVr6+G1wJ2OqE0yMUsg8Tuk3x8FSTogCzCk78bMy7ceB3n40gJZC91@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzdrJ6n7wprPXOkwnxpdYM0k5so5GdqQZux6h//58sKJXhKrkoW
 X7CyXkCeyXST2QsL6E4S00NN92AOQNtQzjJrvglm9GUm3Kw6PPOcI5Ti1y35mTyYTEczTb91E9s
 UgafAK7TvBqbLDmAkgY/liayyAe7v8QZSYSL7QtAjt7n3DwJt/4zoG5bZPV24WlpTuKp+6ZEek6
 bPzhQDfQ==
X-Gm-Gg: AR+sD13Er+0ImZ+2FukbQWIU66+i619fFSBM/xKdsxg810GfYYLiU3ITvnGBjaaEpUf
 m4LO0ehIHUbtYeXUfPZkhU9inG7CZ9wocRqt43DSqmKII+NxBmykKUV+7Ktmh5DS4jstNdcYvP6
 OxqE17loHqI0/MwaQDRwK0A+/ZnpI2ALEHKjO0u2aX2X9lByeyJ0X7N+NZ6SfJhDCOXP9GivCNL
 JJsqhH2Xqt2aHEwrDlRsUxaKTxdzt7EEWTK3sz8+LiuvYp1YyQv+MPdCnW7ldE6h1YuevAAHCFy
 ivAm3XXAYXmspbfbql0Togx5ofY1/1Dcv90dyWk8/QvDDShIIGDoHchWnv49H0YELQGrrnEB1iU
 LZVDysueQVqtK+GbowgY+wGGjA4/Y4xnfL/prMc6yThpzerBy7+DzmgYdbGPhubAlmxj1WlY4Ti
 PTXxeZ6/svfFhkwcC8GWV8jzc08hzhgkdTQy+vsjFpuaxP2IGOPvcszhL37ZsH9wd1nCTuhbg0w
 fd/Ey/IubDeF/zYISnQ+Hv7UXGRj7TjRTG6JKakHlIx4rfSvasGmDgqLXnbT1HIE3bhy3PIkQlD
 J62UmyhO9cJgGwR8gGMtxOLogta2jhHACjJS0PShWTGnpxyLvn8U
X-Received: by 2002:a05:600c:19d2:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-4994e7c10c6mr386678795e9.12.1786193954199; 
 Sat, 08 Aug 2026 05:59:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002145966sm14025543f8f.5.2026.08.08.05.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 05:59:13 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 12:59:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 31
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: f129a7807408b1cb2975e47e99f594c587ba4576
X-Gerrit-Comment-Date: Sat, 8 Aug 2026 12:59:12 +0000
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <08b33eb0f99949dbee4e57cd39fc8d81bd755cd8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsge4-0001Ho-Ee
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2630641298408728194=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2630641298408728194==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cEcZWKX4j60="; charset=UTF-8

--cEcZWKX4j60=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has posted comments on this change by plaisthos=2E ( http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail )

Change subject: Use OpenSSL=
's SIPHASH implementation to double check our implementation
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 31:

(4 commen=
ts)

File CMakeLists=2Etxt:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/c=
omment/d73fbd06_86c1cfda?usp=3Demail :
PS28, Line 801:     target_compile_d=
efinitions(test_crypto PRIVATE PREFER_OPENSSL_SIPHASH)
> Does this still do=
 anything?
Done=2E Removed


File tests/unit_tests/openvpn/Makefile=2Eam:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/e41f1e6b_00a12cee?usp=
=3Demail :
PS28, Line 102: 	-DPREFER_OPENSSL_SIPHASH \
> Does this still do=
 anything?
Acknowledged=2E Removed=2E


File tests/unit_tests/openvpn/sipha=
sh_openssl=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/0c928=
09c_403132bd?usp=3Demail :
PS28, Line 2:  * SipHash reference C implementat=
ion
> Wrong copyright header
Done


File tests/unit_tests/openvpn/siphash_o=
penssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/ec1e29bf_=
2fa77d39?usp=3Demail :
PS28, Line 35:  * implementation, so we only use for=
 unit testing that our impelmentation
> "use it" [=E2=80=A6]
Done



-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d=
54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-PatchSet: 31
Gerrit-Owner: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Comment-Date: Sat, 08 Aug 2026 12:59:12 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@l=
ichtenheld=2Ecom>

--cEcZWKX4j60=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><p>4=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
31/comment/d73fbd06_86c1cfda?usp=3Demail">Patch Set #28, Line 801:</a> <cod=
e style=3D"font-family:monospace,monospace">    target_compile_definitions(=
test_crypto PRIVATE PREFER_OPENSSL_SIPHASH)</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Does thi=
s still do anything?</blockquote></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done=2E Removed</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/Makefile=
=2Eam:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/e41f1e6b_00a12cee?usp=3Demai=
l">Patch Set #28, Line 102:</a> <code style=3D"font-family:monospace,monosp=
ace">	-DPREFER_OPENSSL_SIPHASH \</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Does this still do a=
nything?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Acknowledged=2E Removed=2E</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/siphash_o=
penssl=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/0c92809c_403132bd?usp=
=3Demail">Patch Set #28, Line 2:</a> <code style=3D"font-family:monospace,m=
onospace"> * SipHash reference C implementation</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Wrong=
 copyright header</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File tests/unit_tests/openvpn/siphash_openssl=2Ec:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/31/comment/ec1e29bf_2fa77d39?usp=3Demail">Patc=
h Set #28, Line 35:</a> <code style=3D"font-family:monospace,monospace"> * =
implementation, so we only use for unit testing that our impelmentation</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">&quot;use it&quot; [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/31?usp=3Demail">change 31</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
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
iv style=3D"display:none"> Gerrit-PatchSet: 31 </div>
<div style=3D"display=
:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Sat, 08 Aug 2026 12:59:12 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-=
In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></=
html>
--cEcZWKX4j60=--


--===============2630641298408728194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2630641298408728194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2630641298408728194==--

