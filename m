Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC76A606A32A
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jlUBWF08;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DGD8Qwx7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U9/0NMWA;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=amyUZYfa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=L+TffYmZg4AuJHexKDF5algLKAZC1wz2RwmtAn9fWos=; b=jlUBWF08p4UEdSO3wv06oyhdJs
	hxaLdhlynp8Pdz5dpvDiGb6Q2fz9ZzlF+M1HAsOnrlcc/0mHsd6kROIen3CKCDkIRVuOW4QG580rr
	jkLNLdDJtPMfcyKrUd68A5bMi0v9S9tRM2smgwuVoIfleTt+nHFCnr/013Xfop92JfTg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSyAr-000000004vj-0FuP;
	Mon, 16 Nov 2026 14:59:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSyAp-000000004vJ-1uqW
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:59:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kfrA+x7Ege6a0RQggObuUSoUn69fdWrzfsk+4AOF9rE=; b=DGD8Qwx7AG4C38tSL9mj8aiD2U
 mPHNcb4zSXidjs41WRQQ4sbjMyMiTNQkSlkPG2bSl+3qiREW9XvOew5Wxp+1FptUxF1cgQyfjogu2
 sCAuRTzf3PtC38LLwgc28zZPrBOo49bP2tY5pp8ELYegRgoGoiCdP8hjUkUeRxjNZKk4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kfrA+x7Ege6a0RQggObuUSoUn69fdWrzfsk+4AOF9rE=; b=U9/0NMWAPsn6bI3yZqE0skmv/5
 S4tBBqEe72etikxM7R2ZLykTSTZAmJhdNeniJsrsprEw5z9bXFi4eUH6Zn+XdFgPIwNem1jn5WkDx
 IKJ9ifagB4LXwMDUdM/B2A8NrFocE3c96O1vU8a7chrzTqw8msFncsBNgx/D4djnuJa4=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSyAY-000000001BW-3skp for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:58:55 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso24289805e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794841128; x=1795445928; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kfrA+x7Ege6a0RQggObuUSoUn69fdWrzfsk+4AOF9rE=;
 b=amyUZYfaDomG8MM8eAxbb2kF29+wgNBRCeDrAN97mQoGoNPwYt+9iUHAe6RbNkXweI
 IO3ur8xxcA7da2NybJBwMopLU5CEKbAZ69/u84+izKOFYNsh6og1ONOo9iYsDzkcrvq1
 fbXsYKKA4eQqw64puTPcN0ncEHm+tLjxmze/dLuEc/MJkp1U3zO/CMPoVYR6vWvYbUeQ
 rhPvv+Vw8X0hjgStupwq7rWaHWki1rVX3iGzvNThm/yHfC7r43xZpsX203hc4tv9cl5+
 IZ79jmLN8ww3UREbyy6jY9+GIzD+jq8F1PyF1IqV7cI6M28higgkdD0I4BEaj9NSMtSe
 ByYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841128; x=1795445928;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kfrA+x7Ege6a0RQggObuUSoUn69fdWrzfsk+4AOF9rE=;
 b=vvyLVYe3/MuhGFBNOOAypKVbnjaatlWsL5m4rBk4+PSu9NNlgf67aH0UxjlB7fdseY
 UgcdhLZcLwYah3RCmbfJvMyjMyN+13Q+Jfbid9MD8hT+xILSXiirmGi32sRsGHyoZ8UO
 BtWS3/eJYjz2xhb1d3n5g47xpcMCH7p3Ze3jg+tjr6IGiQ09pJPysnrQz0r/ZTa1PWP5
 aj/1k5m+PD0lRQNBeykHwKjLl3KNGs1qRsoUhDTJHEgMZ/gr9FxdjT7Ki+C7QlJS3fdT
 d/3Wu4SYKSvu4Q4zBYwR4ABa4keWscbC6oiW1PWQk8qYjIYfyFEKf1xzU5dKkHrOfUcz
 9AUg==
X-Forwarded-Encrypted: i=1;
 AL+hErFVClgqwV3ueGWFw4azvvI/4Iwo5RmIh0bTO39WHTTFDVQI32ClUmcglYHYVPxHinNtHBzzwv6alwECLk22@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8iWaqXE+8t7Vad37N8vymY/SlEiak75enlEnG7NDyUULSsiUKq
 yzFOfhpd1tb7hMj5LKu9cnrNPeYmiZBOLJ7oVK4k5VvFZUPlbB/Y8vatbsR7+gB6shtA1R5ApuR
 kw99Egs6MEBLI7kcYRgK5LuYJhRV1ZPu/MCMcs19UgA0dO5HR88ecVYQ0GBzqgW//GL2M
X-Gm-Gg: AYBFou2Enu9u3yU0M1xxt/vqNgR+/TXcroLaa8R1Vb6aAUufR4UJak+8tnAXXCuXrU/
 ScqnmohnWKtvGoVPDY6SzqBZqwRJ03QHP8T9c8sRTJFsTydsXxDO4DkBll9PRsbncS4+4m3lJgI
 +vVet4D61rnF3f64s1IKOypRhvNSP+FleS68vzQUQ+dzS1KN+5/a2LDfkVIc81u4n0Xcn3ryoYP
 BEnpNN4OwDFpFw2eDRBmZad48FPXuXfWMIaomz+aIPTObV3nFSr0bqTAoPYHdowkJ3IVntbow4g
 LbIiIO2VlVZjwICHRGjm2quCSFWwya3X507ldU/5/k1spqApzfSn2P2m+DKzQCnYXDMozrTDVLg
 klmRatFuMBT3fHXGNi6cw7Ms4J2hISNfgmHn2mkvEiUwxCsLi8NhhHk/AWcUXomGruA7JmPzHP8
 I1PgS4w4GJ9BO0Cf3fjWfLIP3068/hBbLglvFyXbZtdGrXnLjzGFjNuqCx6uKNiT0nnbwh0HmSn
 PsHJVQ6YCEremCuoKwcYq6AFsjcFSq8NZxWeAAf8h2JqCelWk8vQuWt6yxihbV0eA6+Vka9g2LC
 G36XhL9vHwNxv1/gpJKbykjyqWzqgHW/MZPc9uj+2AESBdSIndfAE+XZq6j8Pl8olyPgFrcP3A8
 DSvUFKRTZ7qLmPVKDZTAPLoSBJtfpW0sdI9akiiub7dFo3KBC0aFEn+JTjlcPHafUmqVJUCjEZm
 /HJdubhDPMPWFbmzQ=
X-Received: by 2002:a05:600c:83c5:b0:4a2:fe11:9a8a with SMTP id
 5b1f17b1804b1-4bb5599af0fmr233264985e9.0.1794841128146; 
 Mon, 16 Nov 2026 06:58:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2adf53sm406440725e9.15.2026.11.16.06.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:58:47 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:58:44 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
X-Gerrit-Change-Number: 2198
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2198?usp=email>
X-Gerrit-Commit: f876009b2802561292d654c16f7fffa1616bbd1d
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 14:58:44 +0000
In-Reply-To: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
References: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkk5YzI0MDNjMjFlZjhmMjFhMGZiZDk5ODM0NmM4YWQ3MTliNGI5OTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6b60c7f61da58c3b1091108582e1cf33578b8093-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSyAY-000000001BW-3skp
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Switch
 buf_forward_capacity and buf_write_set to size_t
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7278342501293434511=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7278342501293434511==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kNL/COZwVQ8="; charset=UTF-8

--kNL/COZwVQ8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail )

Change=
 subject: buffer: Switch buf_forward_capacity and buf_write_set to size_t
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:=
 Code-Review-1

(2 comments)

Commit Message:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2198/comment/20db7c65_846f6381?usp=3Demail :
PS1, Line 7: bu=
ffer: Switch buf_forward_capacity and buf_write_set to size_t
The function =
name is buf_set_write()=2E


File src/openvpn/ssl_ncp=2Ec:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2198/comment/b9962930_56ddd144?usp=3Demail :
P=
S1, Line 566:     ASSERT(ncp_ciphers_len <=3D INT_MAX);
Do we still need th=
e `ASSERT()` if we are no longer casting to `int`?



-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972=

Gerrit-Change-Number: 2198
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 16 Nov 20=
26 14:58:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--kNL/COZwVQ8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail=
">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2198/comment/20db7c65_846f6381?usp=3Demail">Patch Set #1=
, Line 7:</a> <code style=3D"font-family:monospace,monospace">buffer: Switc=
h buf_forward_capacity and buf_write_set to size_t</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The function =
name is buf_set_write()=2E</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/ssl_ncp=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198/=
comment/b9962930_56ddd144?usp=3Demail">Patch Set #1, Line 566:</a> <code st=
yle=3D"font-family:monospace,monospace">    ASSERT(ncp_ciphers_len &lt;=3D =
INT_MAX);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Do we still need the `ASSERT()` if we are no longer ca=
sting to `int`?</p></li></ul></li></ul><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail">change 2198</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9c2403c21ef8=
f21a0fbd998346c8ad719b4b9972 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2198 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: M=
on, 16 Nov 2026 14:58:44 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--kNL/COZwVQ8=--


--===============7278342501293434511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7278342501293434511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7278342501293434511==--

