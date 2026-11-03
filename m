Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD247606EEB4
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kj6si2n/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fH6E0RRj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FhBP+EqT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dAslzzFc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aAp2sLx5npA8K2QjRoWMPU7/HWnDi8f9FfvbsjvSsKU=; b=kj6si2n/Xt/kzCKrAT2yp+JevC
	98n2koSmEs0K3oN2JFqwpbHd83idBdyCWBTRLUjetWNq9h04XjJYVBIs3X7jsOwId3BjGGrM/k9lm
	ZrF3sRTRGQMDbu8UxQnWbsPjTtLBHQx/gusYDT1xfip+A0c1Vg9KQYtqKfXBTeYCUcdk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOEft-000000003B5-21zD;
	Tue, 03 Nov 2026 13:35:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOEfs-000000003Az-2azU
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:35:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AxG+AjlNdSz0TEMta0L2jq/x3Wj4E20Ct+SKIqpw3T0=; b=fH6E0RRjtuTv1DZ11gsxE0PkHk
 HP6MN6P/3ix14NunYFXmOyLU5BDLkG5uwdpvJfmykPkmcp4B/Nw2lS1C2lXqiZL2FGeeW6iq/aGIh
 OumP5s3gHDnjayTH8sIAB3hy0YIam+4FouUbhy4yCtI4DTB/nFBPVwcy3FqLedfiGdiw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AxG+AjlNdSz0TEMta0L2jq/x3Wj4E20Ct+SKIqpw3T0=; b=FhBP+EqTM2rOdbTx6Yv2xDnBww
 Yzv69PdhuKHgQKEUDgmr6dVKoCsJxKH2NvmVIpsQaR1emRSJ6Z+1bl07Sv09qSAPmMsgwYhuaFFze
 GNk8ksZZ3LLUoTb+Kw9jHsXFSjfRNusl1JSr7XH+6KoW2+sqgd2g/4iVKGctIS/kBjxk=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOEfq-000000003gL-2fzd for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:35:40 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so37644655e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 05:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793712932; x=1794317732; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AxG+AjlNdSz0TEMta0L2jq/x3Wj4E20Ct+SKIqpw3T0=;
 b=dAslzzFctBOSJaUEcof5yRq8khDDPiZZtSw3Q2kOh7a3UMSPb88/n3Im6CyQ6dRdb6
 sWK5ESI2ZRCBtSptp65m/trtzPEBbyEVpiluPyGnRgZYyPfGuN28UDyTt2kRKvYv8dEb
 DTkeDa8UwY6wdYIUXqMG4kgkFZhd8qWwkjK5XTLgX5U7VctI+p/DI2z86zU6NMDjqcYw
 hY7NaogA3RLIAQi3HemvpP6RO1S45cLSHNyYQXHYu8dBI3FFIgBuCLpfkpiYSfWTE5W0
 F05L6PiG2sd3lX0yGoNQ+3H/NTrG9+/giDteElJ4cDK2I3+Qg9qQn5Tb7XdCrSaS3Ztg
 VdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712932; x=1794317732;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AxG+AjlNdSz0TEMta0L2jq/x3Wj4E20Ct+SKIqpw3T0=;
 b=tFxNfEhO30UqXva0zCN7fFoesYXuCoUvesXqF2pXFezcTKbXLuE4OMewlk5jOKeZEX
 BszgEALtXRmO69pIwm3BLLiUUPM2dnixtouw/C/93pGms8K0eMjE35L/4whMImgnO/ej
 DC89NWZVA2xsCWIlxPlSCouutHO3m4la9t3kulkD2dm1usWyUslvnN60lYwXtPgU4Muy
 vCMW65koue6Fu9EIjRBK8AmeuKe/RbALxx1qC77IxhiR/1j2AgfoJn5rdOO4IRtpPvDq
 Pk7qdtmZHbWPBTYOqSXlfBm2dRkOu/fCMmqx1uZmHKpoLHImFbcXLVrMh4TvQiFGhb7P
 VpcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLEiW8skN5JMmThpTwW+lkTqdZsv19ZOHpmyMTUd90/jt0czkTCiDZGlUK7tsnofG2/TDvhdSD1sSH/9pj@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8RS2xM5qp/0t6aOp36zlX7HCIxgAQG5Lvk+zl27oVhg/HjGrf2
 mToMIp8cpYVLVFbuFFOc0DYHrFakZcwsVcXLue8bw2uu4qYzY+s1ydf6NnAA73GMr0jI7koFnwK
 gS5kAdPYE0oI1RjHY+JyzTyvX5ErEBAlkPYvvPJjh9GBv+6uelhJFJYykd7HL0Ig5+uiv
X-Gm-Gg: AYBFou2xGMoXKuzsHr1otmSEEHehll3+JO9fZA/RC45i6a80YQPaosXVv6rgNd/Lq4+
 Hv322SXSlS8bgTAIlvoi2SvuAZRca/v/bBr7Pjrx9L37v7cJXtYkndN+ARYVKUCXJvGsYbJXfXN
 Ba2SrQfMKMAhLF/6/WiZ7Wkykl2C0sVUQYwxv00CEc/q9WW4C+G1vv0kVd2LIC9pTiedXciOqdT
 7Y/pUGUQR14lVCGm180oQk/VFwobWxEAqGbLphAUJmoSsiWnc/4CiYBkYvbT8g+WLW61PGBxFdh
 QY10tgLoNcwRLmGUW3SFMmI4WJTjPSwT3cLgu2t4DQHktlJYm98wznVTP0vnsJNvDbIOZ4oFDHH
 cj46DsArfXOFJ4baysqAyit/Az/5URtHapmUwXIB8yXGAwttH9r/oPRZ24re9CjlSSGFdCbw3vE
 lDfC1GytV9pyGZNP5KEyu8cmkSgz+6ISclcZRl3jN/lF8KZsxELMDIV7lXZ+Nlp6kGx9qlajHOa
 hyJjzUOSnO5At2evmc12uFc3+lCuLIaLYoJt/q/NrsQzMvaFQkvouFKi10zwHlF738epbyY1pPo
 l6t2WMvnMpsHvRp/e4MAEVsfjoWdFURWj6N/umpsZmLOb5T1WdmKK8uT+6xl7MhILtVHF51tNQ2
 TGyYQmqnV8lQZfj0XC2tDspH1XlGPTkOVCXRZN3bm8Pfou6ZggLBPv2/BvKB3Lf9LiG4ilmuf2Y
 thUXr0R+TQ5ek4gA==
X-Received: by 2002:a05:600c:a45:b0:4a1:da58:1ee with SMTP id
 5b1f17b1804b1-4ac1932b43amr308427565e9.31.1793712931900; 
 Tue, 03 Nov 2026 05:35:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d5dfsm29326442f8f.3.2026.11.03.05.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:35:31 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 13:35:29 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
X-Gerrit-Change-Number: 2105
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2105?usp=email>
X-Gerrit-Commit: 8eb4af5adaff4a6f1f9a8801a45c00eac2a2df24
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 13:35:29 +0000
In-Reply-To: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
References: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk0OTRhNDI3OTI0ZWE1MDEzODIyNzVlYTk2ZWY4NWE2YWJjZDc4MGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cf2dddb11b9d17a9323e87f66a04127dc5586dad-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOEfq-000000003gL-2fzd
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Move gc from
 openvpn_net_ctx_t to local variables
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2436577367097127419=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2436577367097127419==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1chJ+mM+MLI="; charset=UTF-8

--1chJ+mM+MLI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Antonio Quartulli ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2105?usp=3Demail )

Change subject: Move gc from open=
vpn_net_ctx_t to local variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 comment)

Patchset:

PS=
1: 
I wonder if we ever need this gc complexity at all=2E=2E=2Ebut here we =
are



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I494a427924ea=
501382275ea96ef85a6abcd780e5
Gerrit-Change-Number: 2105
Gerrit-PatchSet: 1
=
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: An=
tonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Tue, 03 Nov 2026 13:35:29 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--1chJ+mM+MLI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?tab=3Dcomm=
ents&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">I wonder if we ever need this =
gc complexity at all=2E=2E=2Ebut here we are</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=
=3Demail">change 2105</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2105?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2105 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Tue, 03 Nov 2026 13:35:29 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
Yes </div>

</body></html>
--1chJ+mM+MLI=--


--===============2436577367097127419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2436577367097127419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2436577367097127419==--

