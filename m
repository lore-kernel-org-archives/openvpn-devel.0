Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917F3C5DF81
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cO/PlBlN1rh3HOHJo29ZDM+8ty+0ZiGkjcJIabTD6Gk=; b=EbhlX7kTwH1D5O9tteY5JMyvTy
	aaSYFlGseARIFe/Ps9ZnqNY8yxOdRL7urj4ewz+y2J1m7wcaYkjIPrV3YSvgMNhuzMj8MOMccfnCn
	UgrFRaogq9gDlatjU4wtlrs6XNSssUKI2pWe85Hn6XfK6apRoutYOWQbhAwKLTkRTF6A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyVoV-00011z-RH;
	Mon, 24 Aug 2026 14:38:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyVoU-00011s-Be
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 14:38:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=P0YQzBH72jwnBEq9P+Z3pbCenLaV9wQufcz2g5aIQ+Y=; b=e2ROrMDvym7SF0Kc5SVosnl1R/
 3TFM1srRwXSPkuxa1I0PVYc3KjLb5ovmApzMw2fW5TWcLvYVPAZgBEoiIdZMrK4VlastFT1ptR1tE
 7AMZnz5j2SZkoctoDPioZDUNB1HWlIMtshzm+yzi25nPP/8Hl0Rmx5iPOsmrad7XREYM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=P0YQzBH72jwnBEq9P+Z3pbCenLaV9wQufcz2g5aIQ+Y=; b=m
 BzQ9n0YNWBM+bVNvloEArawSMTjDWQwg7sWoNibFyDyNGZY1G4th3FphHPataQ9Tzu7/BwPPsC03J
 04H3SJJPNs/A+ECWD9aYljhos3T6g7b+csUljFOFKJD8t4m8N2FlTPnT/PBGLgSrHgSnTprjVhfwj
 Qrw0qc0BOB+eZ2y0=;
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyVoR-0005h6-MZ for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 14:38:15 +0000
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso6164456a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787582285; x=1788187085; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P0YQzBH72jwnBEq9P+Z3pbCenLaV9wQufcz2g5aIQ+Y=;
 b=NN7X2Mt6jpBK5FXonM+HlVwYYk30g8FvBexkcZKsOAgZaEBluhkkbqGGV/Z8MjBnTx
 K23E2ADqx2GKmzbvQErd4DYz0iSg0M27k/0ogXk28MHsdIStFh3D5V0MhnfcX5G27EvU
 +DHgQ4cHlTlqbltoNd3jyYenFE2xAwcFurn+u0CjRZZKr31O/C6l0xe9WdGiz/aU+Y4d
 IYcV50H4wssbKHWcZjPoro7DjWHPtrGu5rTBHObAPwNDtI+J4oYlAaHhTHY2Ryrsmftu
 MVONbEZ6XmTJ6zuQSk4iy4xmqcHKXKlF2SbH59+WGd0Jyn/jMxcWlEm8vpIhHJoEGtfs
 iZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787582285; x=1788187085;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=P0YQzBH72jwnBEq9P+Z3pbCenLaV9wQufcz2g5aIQ+Y=;
 b=Kd7X1qLR18cDnHTBcRP+r+J5fCA5c9b/tnEZjLkWmg3toSoFU2cjUhy2hbdORuxIf6
 n/Z9uUXEw5ItZOg2Vegmf8zynJaLHr1V8wHSCXsA4od880OcsogC9bQSmxPhpmU0UvvP
 jEr/EFaVVvNQhI4Y5d59kEBAjHIFNUKgMKQjfjMdWMAWgN4fEUgV6acNu85GrCJJwzSt
 OFm2NqKAEZx0orL01GHl1n3sNxdtviypw/YfDQJpxwO0VqWDdKQVwSgb0HoYu4q+riLU
 EgTtC8HqXu3G/OydG6PBCbgZbgp6IWseA0D0gFYuPhYAiMbaTgKnkA8PeYoKtBizFAs3
 h8jw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQzxoaAfxiDO6c1KzziBu1eGua0gnba6EszgMElo0FlF8vA1iDywQUSY6jw3dZTc/Y+wdYr2bk6TosmQ7i@lists.sourceforge.net
X-Gm-Message-State: AFuF++mFV1KDRTRuzl50bUgP163RXHHREo8JGVL+anu2LorCVQ8KZ2Ar
 HT8hZbnWrDzv6KiL5ZxgybAwDQYKjOGnqew7kunIG15fTmwT3AUbMTlvQg3PQIKkxkTqtY+R716
 7joH2MbDydwhM+vqS18LP+K/e2uzu7M+EYi8no3ZvDNQUVDxskJi21KHMOLceT0H21kDQ
X-Gm-Gg: AR+sD12eAlX2aMjUuBIlv4qdUh2okFMPkys4b5Neh+TDHryWo+nvnEnohs4DGHQlS8y
 kzM8/91kTpyhb01fPAWRW4BWbAjCOspKhGb+pIS7ZCaDdLGMfpqrbnCaJ87pSrqy3QS+FqaWjbg
 7TKQqk/Wy9MXMZZwbyzfVeBVwAMRTaYPFzwtWWtsGk0it1+cLEgc8rjCXizUwBQCYSE0vvsyaE3
 TazCErglI2fFGRwRItxO/LBTF03oSeQCeau+9g0U+ySrGhd1WC4DUzh0scIvk8bmK/Fejj34I+G
 2tF6z30ZqpugjQzvd95xV1jARvHgwN8v2HEsyITj39hg3aNjfDW2eeiZEgm12QFyJIvnewsDWOG
 mc3TwHwKgzsQ2kwJtcEpnaVrwCuBeqvbg+y1XWM3GL6pGDhEZlrq0zRVrUSLtjV4XGawGiwRgoS
 lpQIq1msiPh/XIXeUKj3x8P9cNCzHtU7UmXMQxwrGULhQfsJo+Mx1yhDmMLugnboCQduZZfam4T
 X6U77tbDqTOUveeExUeOiYVw3raBBz+rHu6vnEwQS8znCwH8HQ6hB9DDh+xBBHkPGLEYY1csB34
 ThT7VR8NXznQ9g5VxyMLIHYeqJeCxGsHGR+VMOU5AHr3mf5mq4KL6xvIlESkb3o=
X-Received: by 2002:a05:6402:5194:b0:6a0:8885:e6f0 with SMTP id
 4fb4d7f45d1cf-6a582b05208mr20570118a12.3.1787582284924; 
 Mon, 24 Aug 2026 07:38:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1ccf69sm9615750a12.25.2026.08.24.07.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 07:38:04 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 14:38:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
X-Gerrit-Change-Number: 1592
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1592?usp=email>
X-Gerrit-Commit: 22af3b07e55f081a8fcced4045acf7fc908f1bd3
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 14:38:02 +0000
In-Reply-To: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
References: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDUxMzgwMDAwLkk3OWIyZGM0YTU1MGIxYzUwNjhhNDU0MDc5NzZiMGRmYzJmNzY1YjMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c253f5c0aafb393a25fe85609e60657ee28beb7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyVoR-0005h6-MZ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: Add
 --enable-code-coverage
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
Content-Type: multipart/mixed; boundary="===============9132677527248233031=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9132677527248233031==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BwTWUGO/0Nw="; charset=UTF-8

--BwTWUGO/0Nw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1592?usp=3Demail )

Change subject: configure: Add --=
enable-code-coverage
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 4:

(4 comments)

Patchset:

PS4: 
Is src/compat not ins=
trumented intentionally? I _think_ it would need `AM_CFLAGS =3D $(CODE_COVE=
RAGE_CFLAGS)` in its Makefile=2Eam as well if we want to cover it=2E


File=
 =2Egitignore:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592/comment/affa=
e7e7_184d6289?usp=3Demail :
PS4, Line 4: *=2Egcno
Should we also include `*=
=2Egcov`, `*-coverage=2Einfo` and `*-coverage/`?


File configure=2Eac:

ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592/comment/902ed96b_05a168d1?usp=
=3Demail :
PS4, Line 1243:    [CFLAGS=3D"`echo $CFLAGS | $SED -e 's/-O[s0-9=
]\\?//g'`"]
This actually only matches numerical optimization levels (like =
`O3`, etc=2E), but GCC accepts other things, like `-Og` or `-Ofast`, which =
would mangle `CFLAGS` after this: https://gcc=2Egnu=2Eorg/onlinedocs/gcc/Op=
timize-Options=2Ehtml


File src/openvpn/Makefile=2Eam:

http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1592/comment/eb78210f_10a68008?usp=3Demail :
PS4, L=
ine 38: AM_LIBS =3D $(CODE_COVERAGE_LIBS)
Is `AM_LIBS` a thing? I can't fin=
d it in the Automake docs and it doesn't seem to be referenced anywhere in =
our code=2E Are you after something like `openvpn_LDADD`?



-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f7=
65b33
Gerrit-Change-Number: 1592
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Comment-Date: Mon, 24 Aug 2026 14:38:02 +0000
Gerrit=
-HasComments: Yes
Gerrit-Has-Labels: No

--BwTWUGO/0Nw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail">View Change</a></p><p>=
4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?tab=3Dc=
omments&amp;usp=3Demail">Patch Set #4:</a> </p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Is src/compat not instrumen=
ted intentionally? I _think_ it would need `AM_CFLAGS =3D $(CODE_COVERAGE_C=
FLAGS)` in its Makefile=2Eam as well if we want to cover it=2E</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File =2Egitignore:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1592/comment/affae7e7_184d6289?usp=3Demail">Patch Set #4=
, Line 4:</a> <code style=3D"font-family:monospace,monospace">*=2Egcno</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Should we also include `*=2Egcov`, `*-coverage=2Einfo` and `*-covera=
ge/`?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File config=
ure=2Eac:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592/comment/902ed96b_05a168d1?usp=
=3Demail">Patch Set #4, Line 1243:</a> <code style=3D"font-family:monospace=
,monospace">   [CFLAGS=3D&quot;`echo $CFLAGS | $SED -e &#39;s/-O[s0-9]\\?//=
g&#39;`&quot;]</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">This actually only matches numerical optimization=
 levels (like `O3`, etc=2E), but GCC accepts other things, like `-Og` or `-=
Ofast`, which would mangle `CFLAGS` after this: https://gcc=2Egnu=2Eorg/onl=
inedocs/gcc/Optimize-Options=2Ehtml</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/Makefile=2Eam:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1592/comment/eb78210f_10a68008?usp=3Demail">Patch Set #4, Line 38:</a>=
 <code style=3D"font-family:monospace,monospace">AM_LIBS =3D $(CODE_COVERAG=
E_LIBS)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Is `AM_LIBS` a thing? I can&#39;t find it in the Automak=
e docs and it doesn&#39;t seem to be referenced anywhere in our code=2E Are=
 you after something like `openvpn_LDADD`?</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Dem=
ail">change 1592</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1592?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1592 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 2=
4 Aug 2026 14:38:02 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=


</body></html>
--BwTWUGO/0Nw=--


--===============9132677527248233031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9132677527248233031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9132677527248233031==--

