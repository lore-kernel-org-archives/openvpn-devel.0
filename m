Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F4CCCA464
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MRPygsTEc9deMeRwuluyg5SfD11U9EqkEH6+iX/OYqs=; b=GBUxTrqtx15whetfyM09x57dz9
	mIeO4snwMNsKeypvCFJ6k77C+SxLTRzXfTK39tyIYucOEcdDkoYHVqFxKKLs7wT6plkIEg6yI0YOc
	qEP0s3R3wzwyUQ3XwsI90ROUtOZiMqSk+S5H2cL0vbUTAp/ficw3eaRmpbvp7l+oVlx0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHdYC-0003Rb-Ex;
	Fri, 16 Oct 2026 08:44:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHdXz-0003RO-QV
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 08:44:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mOZZe1Jz0B1odZBJYTELQdJ+yQ/5SxS2vYwIr7DsXRc=; b=mpa5FbKglt/Anva1JuqBWwyvs3
 UjJADhNBdzehq2to4byIeIa7T+fbATdLN+659LFsuBvCJxvB3jXg10x0r0EqzXX+xedAfSTPgfH6Z
 MDYZyleyI+U8O5yxxhlBDhbxkzKeeoJWZb4mL13qxM/cs/rAfuoBT4agK5y5JXbC8Lm4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mOZZe1Jz0B1odZBJYTELQdJ+yQ/5SxS2vYwIr7DsXRc=; b=h
 4tRiDtDHZ3DF1lRQjXunMj/hrGmes6wQwQL/cXCI33qF/vzTmthz//SJjKm2fxvNVkREkfn7sjjc2
 BSF1UxK2PM0Cn3i7CjzO0VuhuEEBGb4Rs+GcD2VMwbB+RhpvvAYNA6srqdn0KzQve/B6ICQNMyREg
 18uVKVj9egmSCBho=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHdXx-0001AI-Ui for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 08:44:15 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so28948775e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 16 Oct 2026 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792140247; x=1792745047; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mOZZe1Jz0B1odZBJYTELQdJ+yQ/5SxS2vYwIr7DsXRc=;
 b=EczKl4H2+w+NaaHPG1ux2qQis/bAouM91OQVRmqTCgXCndbf+fV2Hm+sy/wfcD2Q7U
 vmj39U221SeL1o068c14zvcszphE9D0Ade5FOwKIH+90TlBSb6xnPr/JiiER1HU2nkaM
 AFpoF+BdT+BHS/pUli3K1nqqDXkBUWpjQ6Y+rPXnYheUdfbjr9hLK0Giv2OkHEbeFMUe
 +Enkj1OtShBbSpGGaJce1XlbamIZ06I6WJ5TKW+hDTQyxt1J21fejLCfddb7saE7Zrqe
 Xu0ol9pRan3P+MpnQNN7kidBFVMTQLROg2/uU1qYw6bB/QlhFBgrWsBfmQEgzhKjOqiB
 UWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792140247; x=1792745047;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mOZZe1Jz0B1odZBJYTELQdJ+yQ/5SxS2vYwIr7DsXRc=;
 b=dp+R/CXXwQL4WXwFPrmh0PKTcP8/fepBS4CDXrmUao7yxQFwxaLrHXWQI1RW7Bpbnx
 2zBdEbsBAZV+xN1j3SnOHamG2vEulXDCwmDwIh6py1IO+tOQpf9M+kyVwBEy9ArPEXOE
 mZxH29bOXKfRNvOsUeRbid/NcnkfAvVEVuHDXyW8+pr5QZYNXL9xMlSPpxcSIHxe9kfI
 8e+c32EGc1YcMQ1xupiNsynT55GrJGUr1Rg02mO4Qa0tAQJ9IxYpkskQdVjGUqQBA2sB
 WmseGDnKiZQJbKT2cmi3gFCG+T4bfl4H5462rV586wL5JFLS/zqcfzOdyTdd4K/nFwJD
 jWug==
X-Forwarded-Encrypted: i=1;
 AKwUvByf1CXIAzRRP0AHK4EtJTwspORqA1HQBizD7yBcoTqiSTSyBAGrX6jENVlCQhfcbcELYLOjoK/+Ji6ZOc4V@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKpIqLJ+vzW4EiPCpynfmoa3u3o5qSzGeyhHLK+02ipy4np5BSU
 zkGYLXPkeeQHFfwh8lH51oqlFSbB9l78nTpo7ASkx4/JOS8v4hF/fh4nGuQ21SioHLFBsKppk8E
 CKjQpftlv9ioJrwYqmdgnrx6AK6FKHgpn5N+TpBRmHyh+xOyQ56nu3GoVaRyIjMFt5Tj7
X-Gm-Gg: AYBFou0Ph4/ZBarfhdUJJQiOaI6yC6dSBbw3AdSCWFJouKM1xpFdbBa0uKSFJ8hAYpq
 PplobehU8mf8eQzQGPiMsmruoyUz/d2/sTV0p+OQVembnReJysJot8I/gtOvw4OiV3GCkpX26P9
 63Rv+BGnGGSNzrozNsmdtj6TIzaQIhHPRMaPim4GiyJgxqCYqvojF1Z1siIwhSttVofuAu6D5E+
 nLcrUnV6XlmZJMqr95cijY30LzqF7wCU3OqkFBctACVzAmBFT/QYnt+4cKL+KelwztwFiiz8WeG
 O0npJMxTUPqbSrJpPcSrZBXj/hASkmcsPsjAnHMxhwZq5tsaSRDtEECFRvaE07vHKogBDBDOdRz
 K/IpGMCohpQKE+THJbdldxQZG7pt7xfZA1HuuZROxbjZ0TtK3Gmdsdo7rSEq/0++VUhJiXDTONG
 d5zmzy6ALXpp0YyKPk1oz6nO64ZQej2DGRFBukN2tTWdzKt333BTQzH7c9T+DuazyttX2x1LNBB
 w1LQpvFsPFwHDxsXN8O1prMPKCXTK7cBDELxNFIsAztsGE2Nuny2a/nyQZUYgd1ZPsZR2+lVSdg
 D8JJD6xAiNPe4LeFViAt1w2rmNeIBeYLMmgsxSXpH2Uzbp0xiw0K+xtW1ku+
X-Received: by 2002:a05:600c:8106:b0:4a0:c02:938c with SMTP id
 5b1f17b1804b1-4a18e4d683dmr446510725e9.25.1792140247176; 
 Fri, 16 Oct 2026 01:44:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c1eb3907sm111299265e9.7.2026.10.16.01.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:44:06 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 16 Oct 2026 08:44:05 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2
X-Gerrit-Change-Number: 1993
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1993?usp=email>
X-Gerrit-Commit: 11b250dbd82023fa9a4f88d55d293046a961600a
X-Gerrit-Comment-Date: Fri, 16 Oct 2026 08:44:05 +0000
In-Reply-To: <gerrit.1791901394000.I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2@gerrit.openvpn.net>
References: <gerrit.1791901394000.I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk1ZWU1OTdmYjNiOWVmYjkzZGJlMTk0NThhZTZlNzU4MGQyN2FlM2QyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <55a8363aa84ba6ea2eb8aed8e765dc6eae868c31-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHdXx-0001AI-Ui
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Review usage of
 strncpy
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5995929212800301880=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5995929212800301880==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sHMcu8YF9+I="; charset=UTF-8

--sHMcu8YF9+I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993?usp=3Demail )

Change=
 subject: Review usage of strncpy
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(2 comments)

Commit Me=
ssage:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993/comment/446e80d8_bb=
fc0cc8?usp=3Demail :
PS2, Line 9: - Some users where re-creating strcpynt
"=
were"


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993/comment/fc7a2210_15=
92fdf5?usp=3Demail :
PS2, Line 12: - Some users where actually using it lik=
e memcpy
"were"



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1993?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2
Gerrit-Change-Number: 1993
Gerrit-=
PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Fri, 16 Oct 2026 08:44:05 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: Yes

--sHMcu8YF9+I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993?usp=3Demail=
">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1993/comment/446e80d8_bbfc0cc8?usp=3Demail">Patch Set #2=
, Line 9:</a> <code style=3D"font-family:monospace,monospace">- Some users =
where re-creating strcpynt</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">&quot;were&quot;</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993/comment/fc7a2210_1592fd=
f5?usp=3Demail">Patch Set #2, Line 12:</a> <code style=3D"font-family:monos=
pace,monospace">- Some users where actually using it like memcpy</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>&quot;were&quot;</p></li></ul></li></ul><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993?usp=3Demail">change 1993</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1993?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ee597fb=
3b9efb93dbe19458ae6e7580d27ae3d2 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1993 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Fri, 16 Oct 2026 08:44:05 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
Yes </div>

</body></html>
--sHMcu8YF9+I=--


--===============5995929212800301880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5995929212800301880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5995929212800301880==--

