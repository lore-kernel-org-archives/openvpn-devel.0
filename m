Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB48CC6B33
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CBLrtzh8P0/p5b/dAzqRuAe7oD95fe+SAN7MoZIoZVw=; b=REUIw3MtcRIraQcdUQXBM6zshi
	+tG6hoVFpZOecEXsNF6A8tt54kyyJchq4AEaif04kZZ6QGJpnpYG5hQKIrd0toZJGj39O95ScMqQD
	P+y2ETy6QrJteiaMUWeAxJR6tV56BFNbycnsQIUYGgINXkZG6W2YKrHobWFx+vOTJK2c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHJCl-0003ko-UO;
	Thu, 15 Oct 2026 11:01:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHJCk-0003ki-8i
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:00:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kG9NwLrUkVm/c7qYqwO5QtidCBTgHKqRnGwv/IFI5/8=; b=RGb3+eu8k7UmwYLopf6DvTFgkp
 j4ZUr+t0lKiPtYZMbW1sOSS8p8A0eZJgpKASsIc5WI/waix04jizwfdZH2+CG2SmaQ4OpXEeH6eCc
 Lcjx6HIpmFC1nxe60UUFK90UpuLvTaLXAxTYCJezAK0wKgptM+T/MDeZlpshenbbD10Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kG9NwLrUkVm/c7qYqwO5QtidCBTgHKqRnGwv/IFI5/8=; b=S
 y9HySJXFHfiBgmWw4nHU2WFPJ4TFFtpwuVQH30gxYvmfGy6gj6xMyl3yLAOFHlknMj10YxtRliX1T
 y9IejVF/mxf2E6tAkz14jTFJ1DvKetrr0cQWwnrN6d+t2ci8OAnvHid+ZP7lO1I67ZRjbCs70YDBQ
 OzYTust44mnTLfQo=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHJCi-0006DN-Tt for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:00:58 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so44581965e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 04:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792062050; x=1792666850; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kG9NwLrUkVm/c7qYqwO5QtidCBTgHKqRnGwv/IFI5/8=;
 b=Jd/5kkpZSrYpGMmDnwO/bjTgcLJjJI49K7K1pDpUVmGxn9t6BBHSq3G1uUln97LgWF
 mSm4nbRu1Y6RtdHAIAfhywEIXYI5aLkXIrGa7F1y02ifhQsluFPcls7vnJxe6iMgkWcW
 cwVlBJjma8S4+Nft6WJ513w1x+rO/FSPRbCYTlWXlZtMCgStD17pbLMvg4jX/iLDpLz0
 aQGZ8AkoquTyEsON9kbc1RU8DekMofV39uhNACbn18b1oBYw9THNyQLfW9zBpG0Hk16W
 EWGNe57Xb55KITplIp+TDoBlCQJVUOTvjjpp+UvYAqlembH/pu+wjrt/+U2A/TGGYSj9
 qm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792062050; x=1792666850;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kG9NwLrUkVm/c7qYqwO5QtidCBTgHKqRnGwv/IFI5/8=;
 b=aQjmjLF8aLgCyHFAFXnmfrrcUWS317qr6b/pY63rmbpgWHdfia+JZoDCtm8/aSfaR1
 PdS4e16WsjFiabW7fDwo6m10P9eXDIIOHi+OjF71GvktLkXanbU9KM1E+7i6SUBZBx8k
 XAx1FJRTZUw5rsbzqolCnUw9Xaz1nky2Y02mIxB6umztxLacytZpTEHL+Dzhe64suOk3
 Ija1jzHiyEo77sBlcmJIkGnTsB4ApuNvaY27sXZh9kdchqngHvEAGPOp3nq3TB//tQnN
 SFVqq5Slze3rfe3eCg61206Vo3nrVteIKsGCs4ihNqIRp/RyT0MpFzkwnQ1AzCHg97Rs
 XRyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfHaPx2PpIgL7tyt8UdHir17rbMfkhLjKrHxXE4GR6qDswvFNFVuphMnBwXZuLZUzZxHM0+g9CZPSoKFZq@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJbgAW7soz5oAEb+mhryajCQQW5lEaUipiLfwwqvRhjctVlJYkf
 RQjyfwKX5rSz48tcc2+VU89q+4PKzQMbLroRetZ/Eq7P1wyPn+zXbruyxMdFpAfm4mNsLvxEflI
 YIJYub/OFUQQiuCpBXE9gIbzYTVjg8C2xumWfY+hdeapWh5IKuFnWVYAn73BrqQdAKlGe
X-Gm-Gg: AYBFou3pH4Mlwl/t8foDX05x7Mu1mJ+TZHiSMvli3b6mFo8XYoPDS8sepUkHOAa3/B5
 12H2mwY/QCCiK0mE/8ZFgk/xksDPwwD2dvrjtqgQj+gC8eNKBq1Y95Z4yjB6ptjQnjGqM7QNleZ
 7F4/Q3mqfMs6+X/eLTgLG55HrioMTgSpNh5K/u6ZJeNHpk5NIcyzFGKPiFDM9NU1BF+/chaSgN3
 ozwfPpnqPIQfaN0AbnvgnKlLFIYa51oLS0mY0cRUgZrj4lwSFZ3T8BNVUgF8vtTOE4tgPqPBJd5
 EHuWAjEgeK5E5dy37nJmAJkaGBIJ10FyYB49BGyLoQfDPRVGNuXjs9l8NNWEFyoNOuUQWlnhCsK
 REeeHlRBGMTVeTqLmGYWhNXN2vPh4kEbYe7M9VQ+ZgNBqkK+I7yPW3VEhwZrKUSJf+qN2YZGpkO
 tG2gSnsgvRx58KWmspJqe/Kvr5HQa66vB9R4XQXeczQwOL8WlX9KoEmTYdNFaxDbAX27ZLjqOAZ
 Gh2kiR3NuGTBieYLQT8ShlNYg5/1nDIHt/C7qrllCnvWAgXjJKz3ml/iyiViV5Yb2id/SlWv46J
 8tARuyIVyy6uSCKsycmtFLDY7e3rbigqq2pS9qjCjZsaDpxIkBpn53x63a73
X-Received: by 2002:a05:600c:4ecb:b0:49f:f099:6fb1 with SMTP id
 5b1f17b1804b1-4a18e4adcd0mr373223245e9.15.1792062049094; 
 Thu, 15 Oct 2026 04:00:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd993f34sm68018915e9.11.2026.10.15.04.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 04:00:48 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 11:00:46 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: e0ad2954187c30dbf99281a4172a3d6a14a5c231
X-Gerrit-Comment-Date: Thu, 15 Oct 2026 11:00:46 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0072bc73d780e4693a3894e0b783e86274fc1f24-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHJCi-0006DN-Tt
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0954352354641014409=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0954352354641014409==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uUr4xoth4cw="; charset=UTF-8

--uUr4xoth4cw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 11: C=
ode-Review-1

(10 comments)

Patchset:

PS11: 
Didn't get through it fully,=
 yet=2E But noted some nitpicks


File CMakeLists=2Etxt:

https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1858/comment/6e7bad6f_d9b4668d?usp=3Demail :
PS11=
, Line 576:         src/openvpn/pushlist=2Eh
Weird whitespace?


File doc/m=
an-sections/client-options=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1858/comment/370e5fb1_06efc579?usp=3Demail :
PS11, Line 23:   See manage=
ment-notes=2Etxt in the OpenVPN distribution  and the OpenVPN RFC
double sp=
ace before "and"


File src/openvpn/options=2Ec:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/8ad491b8_00cb2562?usp=3Demail :
PS11, Line =
7137:     else if (streq(p[0], "app-custom-control") && p[1] && !p[2])
Add =
to usage?


File src/openvpn/push=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1858/comment/bbbd2c0f_63345053?usp=3Demail :
PS11, Line 267:       =
  parse_server_pushed_info_acc(c, &m);
why use the string instead of the bu=
ffer here?


File src/openvpn/push_util=2Ec:

https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1858/comment/1f759213_e4501889?usp=3Demail :
PS11, Line 371: =
#endif /* ifdef ENABLE_MANAGEMENT */
Superfluous change


File tests/unit_t=
ests/openvpn/Makefile=2Eam:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
8/comment/98eafe14_3b65f58e?usp=3Demail :
PS11, Line 106:     test_acc=2Ec =
test_acc=2Eh \
whitespace


File tests/unit_tests/openvpn/mock_management=
=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/7db95ab2_14d=
d2db2?usp=3Demail :
PS11, Line 23:  *  51 Franklin Street, Fifth Floor, Bos=
ton, MA 02110-1301 USA=2E
old header


File tests/unit_tests/openvpn/mock_m=
anagement=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/d98=
eb7b8_09a3846e?usp=3Demail :
PS11, Line 64: }
Superfluous change


File tes=
ts/unit_tests/openvpn/test_acc=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1858/comment/416878a1_7c543c75?usp=3Demail :
PS11, Line 23:  *  51 Fra=
nklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
old header



-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795=
b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: 11
Gerrit-Owne=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Da=
te: Thu, 15 Oct 2026 11:00:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: Yes

--uUr4xoth4cw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 11:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vi=
ew Change</a></p><p>10 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1858?tab=3Dcomments&amp;usp=3Demail">Patch Set #11:</a> </p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Didn=
&#39;t get through it fully, yet=2E But noted some nitpicks</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File CMakeLists=2Etxt:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1858/comment/6e7bad6f_d9b4668d?usp=3Demail">Patch Set =
#11, Line 576:</a> <code style=3D"font-family:monospace,monospace">        =
src/openvpn/pushlist=2Eh</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Weird whitespace?</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/client-options=
=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/370e5fb1_06efc579?usp=3D=
email">Patch Set #11, Line 23:</a> <code style=3D"font-family:monospace,mon=
ospace">  See management-notes=2Etxt in the OpenVPN distribution  and the O=
penVPN RFC</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">double space before &quot;and&quot;</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1858/comment/8ad491b8_00cb2562?usp=3Demail">Patch=
 Set #11, Line 7137:</a> <code style=3D"font-family:monospace,monospace">  =
  else if (streq(p[0], &quot;app-custom-control&quot;) &amp;&amp; p[1] &amp=
;&amp; !p[2])</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Add to usage?</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/push=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858/comment/bbbd2c0f_63345053?usp=3Demail">Patch Set #11, Line 267:</a=
> <code style=3D"font-family:monospace,monospace">        parse_server_push=
ed_info_acc(c, &amp;m);</code></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">why use the string instead of the buffer=
 here?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/push_util=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/1f759213_e=
4501889?usp=3Demail">Patch Set #11, Line 371:</a> <code style=3D"font-famil=
y:monospace,monospace">#endif /* ifdef ENABLE_MANAGEMENT */</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Supe=
rfluous change</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le tests/unit_tests/openvpn/Makefile=2Eam:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
58/comment/98eafe14_3b65f58e?usp=3Demail">Patch Set #11, Line 106:</a> <cod=
e style=3D"font-family:monospace,monospace">    test_acc=2Ec test_acc=2Eh \=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">whitespace</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File tests/unit_tests/openvpn/mock_management=2Eh:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1858/comment/7db95ab2_14dd2db2?usp=3Demail">Patch Set #11, Line=
 23:</a> <code style=3D"font-family:monospace,monospace"> *  51 Franklin St=
reet, Fifth Floor, Boston, MA 02110-1301 USA=2E</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">old header</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/=
openvpn/mock_management=2Ec:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/d98=
eb7b8_09a3846e?usp=3Demail">Patch Set #11, Line 64:</a> <code style=3D"font=
-family:monospace,monospace">}</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Superfluous change</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/t=
est_acc=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/416878a1_7c543c75?u=
sp=3Demail">Patch Set #11, Line 23:</a> <code style=3D"font-family:monospac=
e,monospace"> *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=
=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">old header</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">change 185=
8</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4=
a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Co=
mment-Date: Thu, 15 Oct 2026 11:00:46 +0000 </div>
<div style=3D"display:no=
ne"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has=
-Labels: Yes </div>

</body></html>
--uUr4xoth4cw=--


--===============0954352354641014409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0954352354641014409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0954352354641014409==--

