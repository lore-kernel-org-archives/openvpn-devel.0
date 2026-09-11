Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA85C88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=km7WSDpOh2Zzic9A6xUgeYHwgPVOBAJFerbeKnAcI9I=; b=a2DF2bzJASEDn+rOGP4RQvhJDF
	COq+z3ADYRjeKJP6zktP0THFmWAs+IbYMojPiqZbhjiRXJ8kdNZS0YIGw8r4Q7F8ycAnq0y2WdnBf
	4XWX1rycf6icc11/Fo4Iw4XQ22HjL6tnGUjGPc663rfjBxp/Orgj4WixPeDuwoT6f464=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x53Js-0000P2-6U;
	Fri, 11 Sep 2026 15:37:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x53Jr-0000Ow-DL
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:37:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2lpkQN+DCmfMfhvDltjDgIEQFVowXQK/QTqu1wY3Z/c=; b=i3O0XLwG4WvF8pZxqxFV1GE7MB
 Vw7etIEri8WW6QIfE1EsEJM6wN8zuKClrQtjL8zW1At5L0FRGsb9dCncPIHMRtlskeNDXyfHCkvTr
 4BL8beYhmsNm0lJ4tSPMwvEPHQMXes32TLXxKYviHGqkFWqb8G6+C7mgXjRnnQ0uFFEY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2lpkQN+DCmfMfhvDltjDgIEQFVowXQK/QTqu1wY3Z/c=; b=i
 SUEyFtTwyrYDp/0xdJtfTXnu3r+fmHArEUK3GbOyFIhtJpm99xrsQo1qsB9cJLdsnByw7ga0naoaN
 3y/d3aGO9Jn5t7CFKjn7MkxJ1pftPDoK/1sW2Ck6ygXnT00ZFn6t3UBRR3y5pr3WuMUHne9w8L9K5
 hC5xQUpb4E38NvgY=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x53Jq-0001mL-9T for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:37:40 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso9774155e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789141052; x=1789745852; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2lpkQN+DCmfMfhvDltjDgIEQFVowXQK/QTqu1wY3Z/c=;
 b=JKyNE9Clj5aJ/PV1ReuxlJaQ49TOOJvufbp+jK4SwAItr1KyI7+mVEwWbHu7o/jZ2g
 Sog1ye480j5dfUTFclykf5eAusoCPfTNOb2XToL2dTMWHpLG8Tm4rvYgic1YM8wZlDKO
 v3lH5CNoU0UzayMFsdVz43gohLfw2s59DV5J2fk4j0I87Y42AMFwuz37fudPVV8wQlUB
 ysZzQbjveVsGagxqtTYrE3tPU2qCvRk79vCx9UiJ2q8J+hvv+Lojzh7tHStg5FN8QNuU
 O6kIYh3adIgfIDrPrJTl7g5xZ/+1+W2lr64TjEb7ia2sIp0opt7xK/EwoFvtvMGbFNgX
 xUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141052; x=1789745852;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2lpkQN+DCmfMfhvDltjDgIEQFVowXQK/QTqu1wY3Z/c=;
 b=U+zXg+GFv0HccUlb7KN7UNRyPjLyo2eplEIlWFE+xJ7uwj+xwW89Fg+NNbJkowjE72
 4/Y0/YKEgZI/j8ufWtTnj5vrZ/ypWyCWwQD412OK3W0gEDhKQLzMV/4mlCXKgYGf0S2Q
 MTF2NzEb6yn0NddeT/jPRDhGeq2jNYAW1zlmHe0mqX8owN8hnoUn9aDskaUjCZvs/H3+
 2Hp9A2HQWryLtYOAZcLFP3HQC1y3XL+F8RAyOxEO1e8m3AqEN1x8JmaCaSJDXmHyPSR1
 Dl0so7oKZzEtPED1LqjlEzaxbKEVR15oD8uH3uTZZpkKuhmiuY9b/LTwge6DHnsPNNsg
 /nSA==
X-Forwarded-Encrypted: i=1;
 AKwUvByPiQb4aTBlXNtk2WywQM+DswR6aztSMi6cGoViv+ToO+ud35W7qg/wD/2hUgktsSFBsZV+qMbVcvhXGJ75@lists.sourceforge.net
X-Gm-Message-State: AFuF++ksz0iEpmbb+HO8V3HAxFpCZUGyAsRcswxSqBltwwTc93Ea7CZV
 StVY8l5i2S2N+9bG0xJVCQqSc5NyqadCmHroqsyeWFoJUmM70CW5P4pnODTFLFPw0hGkpUqyNEW
 KurKtwYJKPzhOmNO9JA1PVq3NNkXRDAQkl1KHwc+aOZE0Pe18Si3eG0nlznQ88jh3KkO8
X-Gm-Gg: AYBFou1IjecZLwuAd+N3JA9SNiuvfexzNf8jAkS16/ZNCI/V77yfZIiFRw4ik4kSliq
 SXNC5TklPL5NW3q9iOrMBq22SwQWi85cOo9FoCHGcuZEyGBU9vBURs4VY2msIi/boQolF6qKM+Y
 RBUK2quloM9x8re+h50BWDNlafCNxcyqwueG2OVH3tw1Rm3QaPS+3YuK73WRYP5feDm9/iiJIUd
 3we7gePJls/L5Z3oA9pE7kOP628O9xXybRPmzbV35qk2Lh5tt41JynXp3BsAHdUhDUHXItNIqiN
 VSqvc+pg5rDck3t6N7PkfB0yVaFb7B2Jg9jHoCit/9SE3bN855co+Ce+UAN3kZ6p/7VCMvGzrfS
 VLHuct3Kk4H8TsxVsOSqxnL7xJWE4LVlb7TQKbbDF2nch6JFmFOODj898WU0pN31AixeW1QxRqg
 V3/uLCBEJG30wcgAh00JHjt2n7QOkif/A48VzKCTSGsYK4FlVtWXJD+6N2Bj/xEvtJLB8HAJEmD
 NEVdY0Ri/ajd+hiyk/lpxhpYnR+b6OzF79MIaswXPDD0+1gt7VNpmGjrgDtJhazG3kH6V+qGT29
 stIKTHGT3Qk4PyqhJIAzzzxGYd749IfVoPw1gxpPB7bzzdNkFZh+sgoseryF+g==
X-Received: by 2002:a05:600d:640e:20b0:49e:6777:da79 with SMTP id
 5b1f17b1804b1-49e6777dc38mr20357925e9.26.1789141051499; 
 Fri, 11 Sep 2026 08:37:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62227071sm49116475e9.3.2026.09.11.08.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:37:31 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:37:29 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: b2bb3e28da4209be92ea29027c6b089b2be63fb2
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 15:37:29 +0000
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5b3bab9a9733b3755437d8dfa489ee64265d2c2a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x53Jq-0001mL-9T
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Extract
 init_tls_wrap_ctx() control-channel wrap helper
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4607831233081137408=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4607831233081137408==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/cBXyPehK38="; charset=UTF-8

--/cBXyPehK38=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1749?usp=3Demail )

Change subject: oob: Extract init_tls_wrap_ct=
x() control-channel wrap helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 20: Code-Review+1

(1 comment)

File src/ope=
nvpn/init=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749/comment/15ae=
18f0_a3ba9d3c?usp=3Demail :
PS20, Line 3132: init_tls_wrap_ctx(struct tls_w=
rap_ctx *tls_wrap, const struct connection_entry *ce, bool tls_client,
nit:=
 This function assumes that `tls_wrap` is already zero-initialized: otherwi=
se the no-wrapping case does not necessarily leave it in `TLS_WRAP_NONE`, a=
nd `opt=2Eflags |=3D` preserves arbitrary bits=2E I'd either clear the stru=
cture itself here, or at least document this precondition explicitly=2E



=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7d8546da9ef06c2226ea7=
7e461f9550d24894c61
Gerrit-Change-Number: 1749
Gerrit-PatchSet: 20
Gerrit-O=
wner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov=
@gmail=2Ecom>
Gerrit-Comment-Date: Fri, 11 Sep 2026 15:37:29 +0000
Gerrit-H=
asComments: Yes
Gerrit-Has-Labels: Yes

--/cBXyPehK38=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 20:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1749/comment/15ae18f0_a3ba9d3c?usp=3Demail">Patch Set #20, Line 3132:</a=
> <code style=3D"font-family:monospace,monospace">init_tls_wrap_ctx(struct =
tls_wrap_ctx *tls_wrap, const struct connection_entry *ce, bool tls_client,=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">nit: This function assumes that `tls_wrap` is already zero-init=
ialized: otherwise the no-wrapping case does not necessarily leave it in `T=
LS_WRAP_NONE`, and `opt=2Eflags |=3D` preserves arbitrary bits=2E I&#39;d e=
ither clear the structure itself here, or at least document this preconditi=
on explicitly=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">change 1749</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7d8546da9ef06c=
2226ea77e461f9550d24894c61 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1749 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Fri, 11 Sep 2026 15:37:29 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: Yes </div>

</body></html>
--/cBXyPehK38=--


--===============4607831233081137408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4607831233081137408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4607831233081137408==--

