Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5AECCA462
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dAqKz9e1y/B8Gm8GIgU8Rp2Kc8KhP7J1DzfOmihlMVU=; b=nHqEZ8x+cUwkYe1A4O0nMsRK6y
	hMvgtKmB0ZTQ/0wOhzyMYMlYv1FHv8qNRbQoFZ5o4DfcQtuPKFTa165s9LfJUIq5ROZAe4BAJrkdk
	6UvpwMamwfm1koSNVDJYVRUINGujWAzTndJ99ggzJaYZIfhsD24op8w/x03adjDfC1rY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI04K-0000ER-8W;
	Sat, 17 Oct 2026 08:47:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI040-0000Dy-Ru
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 08:46:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=amK4Y7pKd36AkX5hrsHPJl4kHsEKhEZS5jmvUSsspDo=; b=HqU6F40ufx/X36j6CxzXWlw+Jn
 sQthsZC76Nk4U0TePqrRJjURV3E6Q4TxrbTZpVirUp40vXg3sw488LK1TWRXx85eLfjn827TQUsEz
 qdI556L5zvnoATWlpMuCm+i9+ALM8h1SJ9P/gJP7NcCIo3wmk1sAEtlpMz5wzxe1CS3g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=amK4Y7pKd36AkX5hrsHPJl4kHsEKhEZS5jmvUSsspDo=; b=Y
 NUK/vZtxJfCZtgdMy/gw/iy9pT9y/+Ugjn/8ghxQIp5NIUIFKX7cOoclC2YZ5MORJjxYQTaMFoJds
 gp5+Diw91+wUizvNIw/n0IANhKIvOtYrGyAZsrPQxEYZL7uZscnqabt7TyFcc9WRVsfdWJcZnCUiv
 c/P/du2LXKBrwIqc=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI03z-0004mn-MW for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 08:46:48 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so5087325e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 01:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792226801; x=1792831601; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=amK4Y7pKd36AkX5hrsHPJl4kHsEKhEZS5jmvUSsspDo=;
 b=P/UBjFHjM3yEEcXFZKdG0oraGBr/bDaLKcaDWHJLiYFJb9Vod+nJO+ugAXbX4IVqqC
 OamSbp6TQ4aAUfNoExFG23bYCDx9ZAokIHd+aZiosPUTnalojdVh30eTYOsbJfKO4fRO
 T5SGf8CInvV459pbz7TaM2rqFebxJNkEHyK3nbgUM9BZ7PxmE04Iyjo8PhA8FB2dF01L
 A9/xP8r2D5dpCc8ZvPkYNkaCt/ojghODyMUBChFNTpgFrsd5WiAzr1gHbprCCoOVJptd
 MZHv2dOqJwPVt27L5gls7AbZAQMv3Zxfr+N9zs4lnOF0xGAxWKeIbFLDvl69xbW+EoXA
 nBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792226801; x=1792831601;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=amK4Y7pKd36AkX5hrsHPJl4kHsEKhEZS5jmvUSsspDo=;
 b=y/RC1Z31Sa72zFvd5i56LV4CiXkx7PU7jbWL6k+p87M+XKT+eEa7yo7lGS/gJq+hBD
 I8eeoblQZ2J0wtB2fGUhEs6A3HCihc0bGt5rJfZC3Eyw4Q+Eld72Z4i5/czh0R4yWq5r
 oaDrJaOJERWMG/mJvGqV12p7WgcvopQOpqAcVfFagojTDhk/ozZzAvj+/apV53HUNZ5D
 WkgT2XrMbnzUGkzlCVVwPPvV8tgZsznx34ewkz0SXNwI4Ee0ya7RU8KaRhruTi2x/0qj
 6Neek5f6PHm2W33GI98cnNjt1nbyCP42KUgDXHkxmPYXVKkjIR8/wAoNOZiVuqwMhKsd
 dxTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYxPsKqfxglASqp9poY6Cg06CskOEF/OmqUrWeElt4KFcUXJYEWJQ9ok8q3xIvSfbjQzaEN3ChGji2sOHV@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJuBbr07cVd3tWFvg1znLsINYSUYSoA64mYp14gko26jokZInnL
 eukMNREiH4V1JtcMmkyn9Sjiz7SLclSdCM4aSbRtDMTevLIQui4N9DwbaxOdZiFeW95iXx0byU1
 vAGXMjiYBOAgc1hwv1AcaVCdDk3SEQEDBdtXFO33tPDMgf1J/7wBgFPvymYYPLglVBCc3
X-Gm-Gg: AYBFou0dbxn+WKj/6eoERZDmhGyPW0G3Ibb6AW0aFEikMNMN0yu5yP4PZ9LnpqQxjPl
 REbf9hGHHNx6pUCMxBkyuYkCOoUYNDqdS//DBMFk4x+jQBEYpXBhaQ4MyzHX6JPDbC7mp1msG7S
 Cv6sLjTcnW2l3p8iQaY3UMCLmbC258cVEUevZrUtlsh+ayTkH6HvDHY1bX4cI5KIqqwWjRL6xD3
 spjXtvWbY43g+2P9qoQ4Yp23d9XVWTvFiSbn50zpl9HOHjyx2mr5jVtPy9t295q+22zmDXyvMwP
 3Xy/EPKdeBnVPJ6ztF7kzeyXEx/8MouwvE1xJmg7zRV8jUUjpHm66oZaatYfBIKDzLpaowxgJDp
 BpNBKXb+3SVdJFiYHc13YZcBx6Fxd6nCXs8TzNGoFLYuZ89IeqOocbIF8jneV+YrnN59h9uoNGj
 tlCTdpAo1M9TOVPTrohftB0b+soUbcqLrp+FKL/4gUo74EcSbBlVjLRro36qkHmTKkXwZ74Bq8+
 iuhfjbSLvaJ9ZkzOFmvYHOp2XcV/Cv4gg0fzhu14l/yb0ML/2KGRY2sQTuwR914BA7B+4LsEJdI
 /7oVgE8Qg2ePsGOQdgiez6tuWq6HbGt3bVDZTu1ME+0RqD7y+KqGOzfyB84R
X-Received: by 2002:a05:600c:4e94:b0:4a1:7703:e537 with SMTP id
 5b1f17b1804b1-4a1d75e6d88mr43894725e9.10.1792226800755; 
 Sat, 17 Oct 2026 01:46:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d756ce69sm53134415e9.4.2026.10.17.01.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 01:46:40 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 08:46:35 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
X-Gerrit-Change-Number: 2001
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2001?usp=email>
X-Gerrit-Commit: 1421419c2d3731d8d840acd085375c77d0c3914a
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 08:46:35 +0000
In-Reply-To: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
References: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMTI4Mzg3MDAwLkkwODllNWI3OTYwMGM1MzVlM2MwYzVkMWJiMTQzMTlhYzAzZjQxNDRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4cdb921073b406b21f4b4e4374ff8cbca74070a1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI03z-0004mn-MW
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: openvpnserv: add
 automatic service again
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
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0422161112784431271=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0422161112784431271==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/EutG5BvJXE="; charset=UTF-8

--/EutG5BvJXE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
eiko Hund has posted comments on this change by Heiko Hund=2E ( https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail )

Change subject: openvpn=
serv: add automatic service again
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(4 comments)

File src/openvpnserv/au=
tomatic=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/comment/e2087=
2ad_42be61e2?usp=3Demail :
PS2, Line 24:  * The automatic service starts on=
e OpenVPN process for each configuration
> Could be marked as a `@file` dox=
ygen comment?
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/commen=
t/e5bf5628_e5773663?usp=3Demail :
PS2, Line 39: /* Time we give the interac=
tive service to accept our connection */
> Make these doxygen comments as w=
ell?
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/comment/ee2b70d=
1_628230b1?usp=3Demail :
PS2, Line 107:  * @param pos   in/out position in =
the buffer in wide characters
> - use `[in,out]` instead of staging in/out =
in the text [=E2=80=A6]
Done


File tests/unit_tests/openvpnserv/test_openv=
pnserv_automatic=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/comm=
ent/146ddf2b_3285495b?usp=3Demail :
PS2, Line 215:         name[i] =3D L'a'=
;
> Why are you not using wmemset here?
Done



-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
Gerri=
t-Change-Number: 2001
Gerrit-PatchSet: 2
Gerrit-Owner: Heiko Hund <heiko@op=
envpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Comment-Date: Sat, 17 Oct 2026 08:46:35 +0000
Gerrit=
-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>

--/EutG5BvJXE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Heiko Hund=
 has posted comments on this change by Heiko Hund=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail">View Change</a></p>=
<p>4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpnserv/automatic=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2001/comment/e20872ad_42be61e2?usp=3Demail">Patch Set #2=
, Line 24:</a> <code style=3D"font-family:monospace,monospace"> * The autom=
atic service starts one OpenVPN process for each configuration</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">Could be marked as a `@file` doxygen comment?</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/c=
omment/e5bf5628_e5773663?usp=3Demail">Patch Set #2, Line 39:</a> <code styl=
e=3D"font-family:monospace,monospace">/* Time we give the interactive servi=
ce to accept our connection */</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Make these doxygen com=
ments as well?</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2001/comment/ee2b70d1_628230b1?usp=3Demail">Pa=
tch Set #2, Line 107:</a> <code style=3D"font-family:monospace,monospace"> =
* @param pos   in/out position in the buffer in wide characters</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">- use `[in,out]` instead of staging in/out in the text [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File tests/unit_tests/openvpnserv/test_openvpnserv_automatic=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2001/comment/146ddf2b_3285495b?usp=3Demail">=
Patch Set #2, Line 215:</a> <code style=3D"font-family:monospace,monospace"=
>        name[i] =3D L&#39;a&#39;;</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why are you not us=
ing wmemset here?</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demai=
l">change 2001</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2001?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2001 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Heik=
o Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-D=
ate: Sat, 17 Oct 2026 08:46:35 +0000 </div>
<div style=3D"display:none"> Ge=
rrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels=
: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--/EutG5BvJXE=--


--===============0422161112784431271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0422161112784431271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0422161112784431271==--

