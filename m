Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A752AC982EE
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 19:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oTMzdUJAVuAPNsx6R1TtqMcRPJWNdsFGPmFxgOVJrVk=; b=ZyEqbsTsEyoe7ZXsT0HOFxnCm2
	bVpTw9dcvoN78LO/pRKx4UHa7K8WNKq3vTD40VOjqeWZqbudH6Hzndkv4sMvVYoiZJY35ce2C8iiO
	mTeICZl6fYoRuhtZQLrrrwxIO5HRuXcLhYdecuvw//b3CKqInMVgfFjbelSRTuzlcn/A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8jS1-0001n9-0o;
	Mon, 21 Sep 2026 19:13:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8jRz-0001n1-NI
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 19:13:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LA1HAqDEe/T96HlSRj8L5mWgZu8U7zRRA8NquLo+PBE=; b=BJSMolz27AqL7pV4R2E6ZIGyaK
 BFwF3+9PPVKNflxDzrubIHNc+sAnE88crKOg7k5Y0UeIQ7pR+sQ/6D3gPAd3uPtcr+pKV6Tv6+BMN
 JgMG549ztMnXBkxQEKS29USXjl5/mManVthSmd/N4Xe0q7D2G0ey4LZT8XBLlZQw/XgE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LA1HAqDEe/T96HlSRj8L5mWgZu8U7zRRA8NquLo+PBE=; b=d
 YAgZQXAmyJ/llwPGVHvQhwZqcHiaWX2MxFnYGY8tXTuHglgCM384deRgeMGwKyT1tjJ0cRVH+DOVP
 6plnIoAgquKOLD6i/hVsd2OFk25hMuyNck8MASSoFObcfdnp2YL2uT1K2DtDvpp6+Y3Kr3GrXoAAG
 ig2f7JqYeMGKQ9gQ=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8jRw-0002u7-0v for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 19:13:13 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so25410975e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 12:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790017985; x=1790622785; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LA1HAqDEe/T96HlSRj8L5mWgZu8U7zRRA8NquLo+PBE=;
 b=NH3/DtK1UlNYL7xJ50N+VI/VGE3XFAJzckK8fsze1TUHKkviApnby3TF06MrenGTKW
 Iv+hIGYNvtPCNnbPIKyd+8yIFNBeaQvhRHL8T0vjTtRH1j0G0aC2J1+vvWEkndfLdJ5u
 7ZzHn+6Rgy+V7EeVEVD5dKDIbo7f1ZVYNBvR6jnuz8WRsJ/tBacbwyz3qU8FMEoGbgOL
 bCgL1Pc27UYu2HVHcw7QA11KbTydATHMoIizR7ai4/4mXlmxS6jNnsuaHEL20D/Buhy6
 irztA99nPW+sqaSi9v1DgBifxzq2MfXzLIqCNpTPylGT1iQrMx/GWtXbu5IY7iu3sNbc
 X8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790017985; x=1790622785;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LA1HAqDEe/T96HlSRj8L5mWgZu8U7zRRA8NquLo+PBE=;
 b=Xy2V/5LNoYVKMX1Dt2hS5w6K/qdJRy0vUQ+drfmfovi1BZDsSQu6oo1AO275fsVpao
 gGWTqOD4UykS7Rx7SeXrr4hoeFVx5JYcU7o9nMNwkMeaMA1nQodA/cQT0Nbg/4UXJnDt
 tvUFtx6toBpwAbfljjptLgcO/NNZ0/YAMGDYODN6iAwXoG1LIT+oqHEkWx+rppL2HU8m
 qlWY05v6lLGA5iVbj7boVIXokw9Jy8HvQ9ef33rPF5t7CDXmEyH4dLUs4IIAO3LsQRZB
 hz1unZK/RHWzuYLDJKAcbC7Tp7V6JQcv4FFGhTgZaXbTAZY7Tqyy0nqi69nAcoLAB1IB
 vSuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJfQU7T0ww1VTjmh57BavGLRf32e2eDKn8jnKmkGs1ixz+lsDHSZ0KUnlrnGyW7eG2Xwrrgb7LCENOmgpZ@lists.sourceforge.net
X-Gm-Message-State: AFuF++nHxN8SIdI9gBzdg72MYv04kME2Kgaga2ZWN7fGtixRHOVKaUCd
 UZ2ViDbE+PcDxpl6hxzt40FolmWHn/5+vVytV4JZJVoysJA/WwVn12FuJQrgT8WAwpsX2oorL+x
 sW1pYKbE6wWA0yy3x8E0m1y9bUHY37TDf6+AvzjTzrg/9MD8XM9AbfGh3W0CDKZkEwmIKYTMoKR
 LG8s6cyg==
X-Gm-Gg: AYBFou3WQrfE/+2RxesdhY+eFUngjfy8z7nOV/slydPHXTNWOefogcpMfCuaH6bCq51
 NUJnvw5Fg9Ops/DZyWB0eQDzX0cqNULAR9JbBYX2qJriz4hJsoaYF7Y+8Img6LLvnLRbvSTOoUP
 5Njlqy9jVMp6pCRIo4uTSKVFOJ03q49x8ujVtA2QGVhbsXW8dl1qiDU72V4CPdHw0RcqojIG+NE
 cB0nFY2eOtdZCJ7GEJ5YW58+XiL4tgdnz2/fKk+60KTSjZgiyaP71BOSMb4Zm5Yw9w3XdgJS/Oi
 mGoiLYASQbIaUhhKE5kOZ7v5TfxJcWkvdX5yzMU5d3XlgaPHKHE28hCoOR+eHBrc1YV78xGKbkr
 jkLK634JNj6Pv8QfJkdTMO4PPzvxCnwKJzBcSdE2ryD8nnR3yjwhLoEjyHQSy1X+3eZVjiu2ACn
 nPmpol0EC7nFhPYmoZnvZCvPtwW049jT4A4VwSQVguvZwpLIlN3Md09Wew0yoONeJveLeXFnyrI
 t5VGlB944a5v+gfrrgUjXPNVvSc6IORC7ipQ2Rg88IHvr62NbjEhOfX19zTUd5i0ivW8en2C9fq
 Or/RWkpDKc0eadpHD+vrwhJKE63NrRmf+Jt3YzHJ23vAPlFRPTolGqXNQQM6
X-Received: by 2002:a05:600c:35c9:b0:499:8704:242c with SMTP id
 5b1f17b1804b1-49fc55a7016mr197185005e9.0.1790017985250; 
 Mon, 21 Sep 2026 12:13:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc521f5d9sm120225325e9.2.2026.09.21.12.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 12:13:04 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 19:13:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
X-Gerrit-Change-Number: 1922
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1922?usp=email>
X-Gerrit-Commit: 078b58f0e0242b2d05125c12db4ed8592b14ae8e
X-Gerrit-Comment-Date: Mon, 21 Sep 2026 19:13:02 +0000
In-Reply-To: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
References: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDA2MzgxMDAwLkk5ODNkNjdlMWM5MGJlYTQ2MGY1MzFmMTFkNGM1OGQzM2EzNTFkODFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9e4c5462f1cc4c86bed2df7935ca41d9891d80b1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8jRw-0002u7-0v
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Maintenance
 update September 2026
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
Content-Type: multipart/mixed; boundary="===============8382770288622332172=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8382770288622332172==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kQPvtuOeS4Y="; charset=UTF-8

--kQPvtuOeS4Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1922?usp=3Demail )

Change subject: GHA: Maintenance =
update September 2026
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 1:

(2 comments)

File =2Egithub/workflows/build=2Eya=
ml:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922/comment/7a2c993f_eaf08e=
c0?usp=3Demail :
PS1, Line 50:       - uses: lukka/get-cmake@591817e96fcad4=
3505fb4eae36172462abb3a42e # v4=2E3=2E3
I'm definitely not an expert in thi=
s, but should this be bumped to 4=2E4=2E2 as elsewhere?


http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1922/comment/e231b7ea_163da766?usp=3Demail :
PS1, =
Line 293:       - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb=
3a42e # v4=2E3=2E3
4=2E4=2E2?



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1922?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
Gerrit-Change-Number: =
1922
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Mon, 21 Sep 2026 19:13:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: No

--kQPvtuOeS4Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File =2Egithub/workflows/build=2Eyaml:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1922/comment/7a2c993f_eaf08ec0?usp=3Demail">Patch Set #1=
, Line 50:</a> <code style=3D"font-family:monospace,monospace">      - uses=
: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">I&#39;m definitely not an expert in this, but should this be bumped=
 to 4=2E4=2E2 as elsewhere?</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1922/comment/e231b7ea_163da766?usp=3Demail">Patch Set #1=
, Line 293:</a> <code style=3D"font-family:monospace,monospace">      - use=
s: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">4=2E4=2E2?</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail">change 1922</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1922?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I983d67e1c=
90bea460f531f11d4c58d33a351d81b </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1922 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 =
</div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Mon, 21 Sep 2026 19:13:02 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--kQPvtuOeS4Y=--


--===============8382770288622332172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8382770288622332172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8382770288622332172==--

