Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403E7C88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4MfaHtuFocsjHezJo+RYWfkQVHcOJoKRuz1np/TmecE=; b=FVGIqCwGwgKuWg+SJEmcyi5orT
	/robRGWNWbDSq84qhbB2+acpPhjJAbCo/FSDxG66q/n1suEhMVM8/tmL9cfgpcsOiMJ9d7yLgNDTN
	y2oxI/ohMLXzOC1kFTNg49JRLh0W1+MpbZmaofXtIsv2x7/7WbmBxbMWxZrJ+Jg1ugSM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7BRE-0006Bu-Ic;
	Thu, 17 Sep 2026 12:42:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7BRC-0006Bg-T3
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:42:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mA6ejV+dYlLZDtjGTpFDQe51wISjtp7xXg4QWFoSGac=; b=UKMCYLP4MXIaBxN7CH9UtlRcI6
 g4UqBfng7cqN4HZgLSmzB78q0JdtJtNZ8x1wH9IEgm1EdKzT2GuR9nHYyGDpROcWnhiYNtwL64+gI
 +l9FBDvO0nFfCMuER2j7hhzJu8mUjfhV2gCiHlyI6e/M3XyfyZOBzGLCNOnEpsf+/PPM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mA6ejV+dYlLZDtjGTpFDQe51wISjtp7xXg4QWFoSGac=; b=d
 9IRjqksaYtVkHlaCg2rJ9U0IwB/0VYo+/oeW6pBv0md0RWn6UYN1iJqfgW7LW3qpKr/9dytay7Fyh
 X6hjEeVHUYj0lO/tLhYn5CxTGu4I65visuk7uW8QLaz9cMGU4jqOrkG3QF2IC5gI7wiE7ag6idP1u
 bHbOn3QCNQksu+gU=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7BRB-0006P2-TS for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:42:03 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485b1d2874aso628404f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789648915; x=1790253715; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mA6ejV+dYlLZDtjGTpFDQe51wISjtp7xXg4QWFoSGac=;
 b=do9XCljC2lzdHrbZ3zYPpKbexVWgA0+ZQT6gAlxMxYrhBLRKyDD7n/eghBOv5iZToV
 JPBBjgnGPgJvFd0UzwgRgffAgi7oTkvQnmZRvW8PGh1bZZnYaT8ZtbQ7QdJRIfsDeaNJ
 cAJni4b53aeA2nPidfWahBY7l10Vro3ubbXYTEm7BHfPr8Gg+YOQsDfUTrFrB/72XYM1
 VeykUk6ayDBBSobSHkXoCxFIDULDmYZvNzlA6q91uxolQrHJmG5WgCJmYaDLi+4T98eN
 VXwm7Is4u1gLLTaCliIRE8u2Bk/cXymOU5lTnqubzywtOsd63yvhkTcn7gI7FpVqnBHl
 z/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789648915; x=1790253715;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mA6ejV+dYlLZDtjGTpFDQe51wISjtp7xXg4QWFoSGac=;
 b=ywfpIocWpiTgoN4+OkxVe/n9k5pKsP3mYC+PTpeehNwnWZaJBJbShcehV7PNdnCIdr
 L0IRirNQTRsZLEGtXhE3bgnqQkr/j22exTvYcX5xFgo++HLl4nedZYPnbn4vkO6RiNV2
 /RjJPuPTTRnzlryOElQ03pC8bUfT1kJ1eiuyZ4Ou2S4D4SdCtEPaiCAdX6oIXTiDwTdA
 Zyac1rAc9MQnS45l6eDM16mfAYleN19Af1fuKIFshq1SANmd1Llhe/4H4ZiXDGD6/tJv
 qwjr02HI3X/FYSeFfIY8/hBgX8I+6rdxu5X5IiiTTA3ARqe1Fsj8kMrIl9ecDWg1Wx1z
 mTtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNVylR6STznD38ICq6seB1lnyEnDw9fmq7HxAf3w7pt+yn7sVfRWIv+dhewJIcPQWzcgJuFksNm1rcaA7U@lists.sourceforge.net
X-Gm-Message-State: AFuF++mKv/c4YbpOWnRpWAbtaMDZ4ecJf8CtjKUoVx0CU7JQg+Z7F1ih
 Nw00t0NiquxUGLihwiMaevW/sBB1ZlH6NSs4qSORp/J2ee8P4NLFdQph5GnFawb3zh/EG+Oheym
 Me5kXhkKT8tQojzwbWTor2zmTSJ9n2vafUOfeJm9W5jm0UFH6mu3h7yXUInCzzCqMQICt+y6ES+
 EjcSGqMw==
X-Gm-Gg: AYBFou3WwZhyAQ7WVSAUGiqOPmwV55edNDAlr0xmOSjbcaJvT7elWUYGrQleUNbY10x
 UQ+MLPSFiisZcDqQWmfFTvmWEBqXJooWguMnNLjKS3EGK0oE5zpuhk4U502rB46+PjhMzNEFQ00
 Q0ZZwNAaWvlI1THaJQ3NXKDVxx5JHIV1j8Wrqnt/T/nEnGIDlL8xknfvIR6Pw9GPJBjQdaEAFvQ
 ah5HUV+XsrS1Ehz6Cb1XJ3z3hn2k+wxTkhqhSEbG4VJ1XTW5ApPS30tGMGovWfTSrCM3smHpQD7
 M8IQnPryGH9cCnZmYi4qJRM7+MmogRTxGLXX5DQCYnpeQx153KqjC2aAWjfnrjFilh03rbiJco9
 dCH/+rAro2Zn0wuUEwHPYGgj7AdHME9y0ABgLkTX7q+WD9t+IaryLXFEduBiJTUvr/8ijzQMu62
 0Ut2+Weipyaly6x1vgGljzRxS5uGWAoRAhWLqWH87R1WpOP3bd53QdxX3ePGo5kL5fffkMOZna8
 YMMB+ZcS1JbiJNz07Rdw1U7YrKejWZyHd/PFXdzV8YGdzVOjpDDxdeNuKK9QmWzgqZ6+w78PI4/
 6EGOiYWLhwACnd9Lkw2VrE9/m8zKaAV9uRrV2u2mCBlgM03w6U0ORl5W+ehBzQTBjMwypKH6
X-Received: by 2002:a05:6000:2502:b0:487:88b:4681 with SMTP id
 ffacd0b85a97d-4870cf037d3mr14923041f8f.10.1789648915155; 
 Thu, 17 Sep 2026 05:41:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fa70sm15162056f8f.9.2026.09.17.05.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:41:54 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 12:41:53 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 5b1e911f450ab09703cf02f50846d58bf66fbaeb
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 12:41:53 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5536f30e3e3d18737b8229d7f86e885c4936cb1a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7BRB-0006P2-TS
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com, frank@lichtenheld.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8817457109939876604=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8817457109939876604==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LjZv+0Y0wmA="; charset=UTF-8

--LjZv+0Y0wmA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ralf_lici, stipa=2E

pl=
aisthos has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add contro=
l message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 16: Code-Review-1

(10 comments)

C=
ommit Message:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/e49c=
d08f_c4d00e95?usp=3Demail :
PS16, Line 26: never legal on an established se=
ssion=2E
Commit message not updated=2E


http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1741/comment/02f6b113_8081e410?usp=3Demail :
PS16, Line 28: See the=
 OOB control message section of the wire protocol specification
Better to r=
eference a link in the spec and/or the header under which is this is define=
d rather than a PR that does get updated/receives documentation fixes=2E


=
File CMakeLists=2Etxt:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comm=
ent/06bdba7f_c8c4e830?usp=3Demail :
PS16, Line 889:     target_sources(test=
_oob PRIVATE
Same comment as on the Automake file=2E


File src/openvpn/con=
trol_msg=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/9195d=
45f_4d95ac70?usp=3Demail :
PS16, Line 88:  * OOB message so far: any other =
TLV that is not marked optional invalidates
which matches the currently sup=
ported OOB messages=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/com=
ment/97e70ce2_3d0ef64a?usp=3Demail :
PS16, Line 89:  * the message wherever=
 it sits, so the whole sequence is walked=2E A message
sits? 

"it is prese=
nt" perhaps


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/a4d071=
d5_835ea037?usp=3Demail :
PS16, Line 100:  * @param value        set to a b=
uffer covering the found TLV's value
Point out that this buffer points at a=
 portain of payload and does not have its own storage=2E


File src/openvpn=
/control_msg=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/a=
f589fdc_2762f9ec?usp=3Demail :
PS16, Line 81:          * we are looking for=
 and the ones we skip are bounds-checked alike=2E */
This sounds quite comp=
licated=2E Is there anything more than trying to say "Adavanced to the end =
of TLV and see if the data is complete"?


File src/openvpn/ssl_pkt=2Eh:

h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/b734bc70_7c5c92c6?usp=
=3Demail :
PS16, Line 72: /* the out-of-band opcodes, which carry no reliab=
ility header */
Other part of the code call this ACK array=2E I would be a =
bit more verbose here: 

OOB opcodes are part of the reliable control chann=
el: ie no control message id and no ACK array=2E


File src/openvpn/ssl_pkt=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/48fd91f3_fae2=
7106?usp=3Demail :
PS16, Line 171:     ASSERT(!opcode_is_oob(opcode)); /* t=
hose are built by tls_wrap_oob_standalone() */
what does those reference he=
re? I have a rough idea what you are trying to say but I think this comment=
 is a bit cryptic=2E


File tests/unit_tests/openvpn/Makefile=2Eam:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/fc3a9237_5f6856aa?usp=3Dem=
ail :
PS16, Line 157: oob_testdriver_CFLAGS  =3D \
Can we just add test_oob=
=2Ec to pkt_testdriver_SOURCES and not add yet another test suite with a ve=
ry low number tests?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1741?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerr=
it-PatchSet: 16
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <=
ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerri=
t-Comment-Date: Thu, 17 Sep 2026 12:41:53 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: Yes

--LjZv+0Y0wmA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ralf_lici, stipa=2E </p>
<p>Patch set 1=
6:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Chang=
e</a></p><p>10 comments:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1741/comment/e49cd08f_c4d00e95?usp=3Demail">Patch Set #16, Line 26:<=
/a> <code style=3D"font-family:monospace,monospace">never legal on an estab=
lished session=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Commit message not updated=2E</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/02f6b113_8081=
e410?usp=3Demail">Patch Set #16, Line 28:</a> <code style=3D"font-family:mo=
nospace,monospace">See the OOB control message section of the wire protocol=
 specification</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Better to reference a link in the spec and/or the=
 header under which is this is defined rather than a PR that does get updat=
ed/receives documentation fixes=2E</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/=
comment/06bdba7f_c8c4e830?usp=3Demail">Patch Set #16, Line 889:</a> <code s=
tyle=3D"font-family:monospace,monospace">    target_sources(test_oob PRIVAT=
E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Same comment as on the Automake file=2E</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/control_msg=2Eh:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741/comment/9195d45f_4d95ac70?usp=3Demail">Patch S=
et #16, Line 88:</a> <code style=3D"font-family:monospace,monospace"> * OOB=
 message so far: any other TLV that is not marked optional invalidates</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">which matches the currently supported OOB messages=2E</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/97e70ce2_3d=
0ef64a?usp=3Demail">Patch Set #16, Line 89:</a> <code style=3D"font-family:=
monospace,monospace"> * the message wherever it sits, so the whole sequence=
 is walked=2E A message</code></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">sits? </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">&quot;it is present&quot; per=
haps</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/=
comment/a4d071d5_835ea037?usp=3Demail">Patch Set #16, Line 100:</a> <code s=
tyle=3D"font-family:monospace,monospace"> * @param value        set to a bu=
ffer covering the found TLV&#39;s value</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Point out that this buff=
er points at a portain of payload and does not have its own storage=2E</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/cont=
rol_msg=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/af589fdc_2762f9ec?us=
p=3Demail">Patch Set #16, Line 81:</a> <code style=3D"font-family:monospace=
,monospace">         * we are looking for and the ones we skip are bounds-c=
hecked alike=2E */</code></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">This sounds quite complicated=2E Is there any=
thing more than trying to say &quot;Adavanced to the end of TLV and see if =
the data is complete&quot;?</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/ssl_pkt=2Eh:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/=
comment/b734bc70_7c5c92c6?usp=3Demail">Patch Set #16, Line 72:</a> <code st=
yle=3D"font-family:monospace,monospace">/* the out-of-band opcodes, which c=
arry no reliability header */</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Other part of the code call this A=
CK array=2E I would be a bit more verbose here: </p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">OOB opcodes are part o=
f the reliable control channel: ie no control message id and no ACK array=
=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/ssl_pkt=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/48fd91f3_fae27=
106?usp=3Demail">Patch Set #16, Line 171:</a> <code style=3D"font-family:mo=
nospace,monospace">    ASSERT(!opcode_is_oob(opcode)); /* those are built b=
y tls_wrap_oob_standalone() */</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">what does those reference here? I=
 have a rough idea what you are trying to say but I think this comment is a=
 bit cryptic=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile tests/unit_tests/openvpn/Makefile=2Eam:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
41/comment/fc3a9237_5f6856aa?usp=3Demail">Patch Set #16, Line 157:</a> <cod=
e style=3D"font-family:monospace,monospace">oob_testdriver_CFLAGS  =3D \</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Can we just add test_oob=2Ec to pkt_testdriver_SOURCES and not add=
 yet another test suite with a very low number tests?</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
41?usp=3Demail">change 1741</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit=
-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_li=
ci &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_l=
ici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Thu, 17 Sep 2026 12:41:53 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display=
:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--LjZv+0Y0wmA=--


--===============8817457109939876604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8817457109939876604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8817457109939876604==--

