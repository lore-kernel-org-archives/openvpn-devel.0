Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD01C79F82
	for <openvpn-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/JT4g6JY6UwQy8Bkrybvq6dKHN9pWuJj0QWyIcf5kKQ=; b=aTCRzaHvbNSyniOfhgrOXAmmch
	WmF1yCMrumgug3SrYeiVcrXv+i4M3PbamFyabaBC7YCg2YvO/lvW/E/e8ng2GWfLs3EBsN5n1pMiC
	mEU3MWSPZQGAUNaKF6+yi9HHZO0dUBZrhJa7pEUMiGMpbiVynFVJ1mzhf/PMXSqSLBRw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3qwB-0001xu-Cq;
	Tue, 08 Sep 2026 08:12:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3qwA-0001xo-C4
 for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 08:12:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=26H4R/7mQYU0HbZRJvUDgYkSyzzK+SATJJL5zTSGi7M=; b=j1JXt0eZYtDQNcuNGJ64UkWghA
 +yV+moRV5UNrRybTSMNQKexAKZVE1yBerhynNeRhxwO05DSFh+shoItZB+to1QQ4JmkQGx1rxxsDt
 1SGqzOJn0xAl5aTcb6PPu4FVqxk5ArMJDbIyybTXA5nlZu+ch8cJSKIgwbia27TKvNwU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=26H4R/7mQYU0HbZRJvUDgYkSyzzK+SATJJL5zTSGi7M=; b=B
 ZKSh4WWv+/gztDbfUmEOEjGMTr3wdCpzRo5DN7+wIQ/e7nzB0uILgRwnhKr6hcMCs8ZO24gfW8QO5
 XdlNmsB4Jl6hQnHX+CFHKSjjsVwF934rIW6IU8LJS+yn6aYcKr1/NmU/yx9RNmJfZGox/Wc/OjpXf
 ZBww6u0ZPtrN0Zy4=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3qw9-0001Pt-3r for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 08:12:15 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-482e257a23aso3001372f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 08 Sep 2026 01:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788855126; x=1789459926; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=26H4R/7mQYU0HbZRJvUDgYkSyzzK+SATJJL5zTSGi7M=;
 b=PZdMU6wLze27DSi6C27bC3b4nWI7CyZQlZVIsH/i7D/ETIW6E7gYvx0JsOpcpReHj8
 oSATbROX8nabpxUn73WXcCW+jiO+MapIgPEvncvWq48TfW8wecS4BIOyJi3cdy376QUe
 0TqxIlkv7NA6SI0JnB/IPBfFmIxl0x++ToUUhqgo4WP9SKtvPmV62dXUkmyRaLFhOv2X
 H4DkY110qsibGh6zV/s6tL9yb9k4GYV7DhQsHzZnY+q4xqagi4iqqk1LYpbp+fbkidl3
 RQ1NUdjJHbiZiQJli55hGWMvu0twgdfqAcfY/LZN+6bUuyskajLZX3dxXkmcTR2geaaq
 KwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788855126; x=1789459926;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=26H4R/7mQYU0HbZRJvUDgYkSyzzK+SATJJL5zTSGi7M=;
 b=LlwFfrHWgCfT5BbRtsXOCTW4R3I6uveZK1ohOkiuteC9at5FDzYDzZYQ7yl9UHsKri
 nNavSRhJ4oeZXYq9QvTUaDjxRocA72Wv4G0fWrZR9Jqti1XbvJXyhv12CvBQUPtuA4D3
 B5UL5bEKV+36NTpunBjfUMfrAQqagqfRUdJPsFyvAvYwIVNUPrLZFzlMZM5hc6Why2la
 Plx//VyC8L7T6R5dw2WKQtQA2pCNxt2T8n3JhLPe5idzc20FtTKLkRP/ojQJT2+mb3gN
 LHsW08wGeErz/PsZ/o9KwEYPJ8l9LgvQt2y4rkZZQtxqSZl9C/178Pcr+9NtCQ4yrQyl
 eu6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyPQl97wOH2njtpvZN4jEs2IMLYmIAwrynlyPyFN6DNIRLiMKHIFInXSULJSmwfWqxaVYqcmpS3Pb0B38T@lists.sourceforge.net
X-Gm-Message-State: AFuF++luNWPYvEK3t9ft0wpN+ddvnlPMsx64Ff1X6cCz0BeIrqUCOYFD
 uVXmN87g0TGsY5ASmKWSerug4q8hb+2PtfmBEFKcmUQze7cBc59ARJcynMnrflcjfXR9gKRyfD0
 iiuSgBAnZ30ewOYcVwfTK1lYvLpGjHL908AU77dYC9blv+uBQRr4PqS8i28BP6QieoAlA
X-Gm-Gg: AYBFou2ZkUtLOb3PLRv+l6417sUm8fl0opLJRb7tC60wlVQXjVywjxS76ZaRrIGIYsk
 4a5zHKQsxiLH2IETElI52s6s8OnIGM+bFuj9lj7jfE9xGL9Vlmb7dTMBTfjfaBpCb2ZGHfE/FOT
 HtRFVokPqi9krMJgR94wpcVG7fNgQd/0D/1MsRwZKH23uceehYDGlb6l+myYS+9qSZZKtosyLii
 Qv5UKFOBF4dFdXXy0z4TSdmEstmpo0za2oJlFsa5MF6E3lbg1MgHql8f5WGvYIRXg9H/kyo0Eh+
 o7/AXrRbJWBg7KSzWQSqxxH9dluskL/Qpj7pXhj2RWiRNYNkA+4UIOb03N+/8RFbv0MB10nYIzJ
 o6GFWps1UhRa17/g6PYS+6qCUEdgHTOQ40lok0AO2AeOmU2ZTmRJicxo4U+IwfX4ZXWqIBzawON
 B0e7sl2FEWRYzNUF7zrlBLbTct3NSB3wdzuml213zp85uiaxm5gp3U0Zl4l9ZZ5OXB+QDL2/uEI
 5drO4cA8JgWzrccmhae8uZCqLltvl3q4alNom2YHPDA3OlnW2LmyycHd6zTT/4dN/xp5Ejrqkxy
 7WnetsrGdt910kB0+ptnsD2cMAXWZk8XYBaCBhfUfqFPRzRwEiM=
X-Received: by 2002:a05:6000:2505:b0:485:8ad5:f965 with SMTP id
 ffacd0b85a97d-4858ad5ff97mr27044378f8f.2.1788855126305; 
 Tue, 08 Sep 2026 01:12:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858dd90e1fsm34954614f8f.28.2026.09.08.01.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 01:12:05 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 8 Sep 2026 08:12:04 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 8a45bcacebf903eea3c03773a73159560a6ea3ee
X-Gerrit-Comment-Date: Tue, 8 Sep 2026 08:12:04 +0000
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eb7be9d12d920c8882a4bdc299f0a798f7bffb82-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3qw9-0001Pt-3r
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 SERVER_PROBE parsing and the probe-reply decision
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3573189476199355455=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3573189476199355455==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sxU1afHOdRA="; charset=UTF-8

--sxU1afHOdRA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
lf_lici has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1742?usp=3Demail )

Change subject: oob: Add SERVER=
_PROBE parsing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 12: Code-Review-1

(3 comments)
=

File src/openvpn/oob=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/=
comment/bb56292d_ff09ac5a?usp=3Demail :
PS12, Line 118:  * for the probe_pa=
rameter TLV=2E TLV types other than probe_parameter are
nit: only unknown o=
ptional TLVs are skipped; unknown mandatory TLVs are rejected


File src/op=
envpn/oob=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/4470=
7784_9348a384?usp=3Demail :
PS12, Line 116: oob_build_probe_reply(struct bu=
ffer *probe_payload, uint64_t now, uint64_t window_secs,
I find this functi=
on a bit confusing=2E Despite being named `_build`, it does not actually bu=
ild the reply=2E It validates the request and fills exactly 1 member of a c=
aller-populated object=2E In the immediately following patch the caller dec=
lares `struct oob_probe_reply reply` and relies on this function, which ini=
tializes only `peer_session_id`; the other reply fields are consequently un=
initialized until a later patch changes the caller=2E

Personally, I'd name=
 this function something like `_valid` and avoid modifying `reply` here=2E =
In fact, `peer_session_id` can be pre-populated by the caller like the othe=
r `reply` fields=2E


File tests/unit_tests/openvpn/test_oob=2Ec:

http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/abe5bac3_ed86028f?usp=3Demai=
l :
PS12, Line 419:     struct oob_probe_reply reply =3D { 0 };
Zero-initia=
lizing the reply here is misleading because the subsequent asserts cannot p=
rove whether `oob_build_prove_reply` zeroes or preservers the remaining fie=
lds=2E

If the current API is retained (see my other observation), I'd init=
ialize those fields to distinct nonzero values and verify they remain uncha=
nged=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/174=
2?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafa9efc1c1=
56974ad9f5752e9de810a8c2f68c30
Gerrit-Change-Number: 1742
Gerrit-PatchSet: =
12
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comme=
nt-Date: Tue, 08 Sep 2026 08:12:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has=
-Labels: Yes

--sxU1afHOdRA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Chang=
e</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1742/comment/bb56292d_ff09ac5a?usp=3Demail">Patch Set #1=
2, Line 118:</a> <code style=3D"font-family:monospace,monospace"> * for the=
 probe_parameter TLV=2E TLV types other than probe_parameter are</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>nit: only unknown optional TLVs are skipped; unknown mandatory TLVs are re=
jected</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/oob=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/44707784_9348a38=
4?usp=3Demail">Patch Set #12, Line 116:</a> <code style=3D"font-family:mono=
space,monospace">oob_build_probe_reply(struct buffer *probe_payload, uint64=
_t now, uint64_t window_secs,</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">I find this function a bit confusi=
ng=2E Despite being named `_build`, it does not actually build the reply=2E=
 It validates the request and fills exactly 1 member of a caller-populated =
object=2E In the immediately following patch the caller declares `struct oo=
b_probe_reply reply` and relies on this function, which initializes only `p=
eer_session_id`; the other reply fields are consequently uninitialized unti=
l a later patch changes the caller=2E</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Personally, I&#39;d name this fun=
ction something like `_valid` and avoid modifying `reply` here=2E In fact, =
`peer_session_id` can be pre-populated by the caller like the other `reply`=
 fields=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File t=
ests/unit_tests/openvpn/test_oob=2Ec:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/com=
ment/abe5bac3_ed86028f?usp=3Demail">Patch Set #12, Line 419:</a> <code styl=
e=3D"font-family:monospace,monospace">    struct oob_probe_reply reply =3D =
{ 0 };</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Zero-initializing the reply here is misleading because th=
e subsequent asserts cannot prove whether `oob_build_prove_reply` zeroes or=
 preservers the remaining fields=2E</p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">If the current API is retained (see=
 my other observation), I&#39;d initialize those fields to distinct nonzero=
 values and verify they remain unchanged=2E</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3De=
mail">change 1742</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1742?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1742 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: st=
ipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ra=
lf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Tue, 08 Sep 2026 08:12:04 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: Yes </div>

</body></html>
--sxU1afHOdRA=--


--===============3573189476199355455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3573189476199355455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3573189476199355455==--

