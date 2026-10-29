Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3A1606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OLHqef1n;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g0MN75QE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=I67fxf/p;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bHwASgRs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GSL62SMI7LpH27FKXOjYzTRUcsrpS7Y1l+kXXSV7B0U=; b=OLHqef1nj0zx6q9EkUobBrLAXb
	xpiKeFxWQV4+1ilRYJzo2T0bLfDEGowhi2exWnAiWkkgNC+PeJKswh9kAcsCz+y2r3ULyrw6I8afE
	wyWen5PXAVquPeBvid0dRN65nFfG/wEbd7rYiTxrfhCLdTtJzA6wXIU+iMTuL7dNeTEs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMPtL-000000002u0-3WB8;
	Thu, 29 Oct 2026 13:10:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMPtJ-000000002ts-3ZNS
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 13:10:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oL47C0Axo6db8VI+bARQtZ0gqJ1+OIYNtz9bxA3C3MU=; b=g0MN75QE7gT1xmwv8v94TJwgMb
 MiRuwnY6V/rjx+w7rzBeSibspdcE+OcdrYAzTQztShmz5vpdZwlnEyrATdqgqn9K7v6tScPFkiaeo
 IOU4kSAhLQaA2WM2/e9lYXQd2mN3V5zYlhK2N8u+n+wWk69eZ+cyPWeKpaZFeosvi+hk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oL47C0Axo6db8VI+bARQtZ0gqJ1+OIYNtz9bxA3C3MU=; b=I67fxf/pjV0Nq5/U6ubB5BVtga
 +38T09HljzW1vCGQYOJpT/yoT2Kc+f3AWkCFqxnhcnIh5BYncUqqBjRLWtAOZjmYqN8oXMGOVMsn8
 MxhsCNDmQrxhXIDtiOQ7Hmy+84uOKtpLNBiVpwvnvclU+E9D+Wvdgs0w2rM7kE5eEPcY=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMPtH-000000002Yt-2fvr for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 13:10:01 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso1219276f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 06:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793279393; x=1793884193; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oL47C0Axo6db8VI+bARQtZ0gqJ1+OIYNtz9bxA3C3MU=;
 b=bHwASgRsDNys0VgiXVb1GGACO+st7jr5ldWkdU2C52uUxrNYCr+JUO9SV+PUDRVW1T
 V2LCNnprE1gw93DNtXh28AbmLdD8YJV1W19ScVdZ7yyIiG99/77nkvKDg8ygNTUzFYMq
 lmWWGqoGSUs/MmoUJkXTaHjpl4Y7EpmigJCRQ41H8ntXJfdIuxWryrOzAjgoDc+uwgKf
 7CAaiFBCAVQFwk4cWICahepXL6owVOt0UPbFQY8j1s1gRht+xLNrOnuzoo2nJIe8IZzs
 kGLAIwwyOu6blXv5zA1Gg68wNll4MTpAD2/+0eT69bPZY2SfiGuG/LwOfzfV0JGQGgG+
 hSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793279393; x=1793884193;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oL47C0Axo6db8VI+bARQtZ0gqJ1+OIYNtz9bxA3C3MU=;
 b=A34lVCkj1UYSwp/Lhb5fPPBufzgJceb3UiyX+fV/E1UHPbJwP4DNN5NHiiEGxOOdMx
 ZsmWu55rkcmQLzgrj+bE2vgKWaM+xpv+MxaY3C8BKNhfIgraohhdD1gIrnVj8uL93UD5
 Qrv7/jdLcTNggOI2T2aZzye/0i/02Y2T8XIxGoHXcFgKW0TCsRIKLnL5i7gq9O0Qu7+C
 CTSOgPxuE7hf+EXNXknGdumZsIc3QWl0Cdl9LyPohYVPv7Uf2KPsPi+noU+I14zv00F3
 gujOck3f+rqIQWZE0Vt2PsS77unI8KmwSoG3NpHOdG27N9/uvXW3SOn6tvDmB4GNbHXm
 vypA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoIMmExHe3xTf3cT+0gY8/gfYPtrSYHWozyYbbrBwSuiCsKaOeFFkaZ85C7H0mbJB1PKJzk8SzzxYcyMFa@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIxOBWEjp9e8svC7YZwQ3HOTeiFQFD/H2hC238mHuJtIm/4UVi2
 M+diToZCbRHFyWdX1at48fRGWKSjIeO/wzuEUVR+eRsN/BMKG7IWcVQN0m9XKTHr97Wq9qm4O2V
 VKEvuRHJIPy9W5d8/vd0/2CBJTXyM8AWOhUPd/tp9mT5YDaPki6GIW8Ta2MNfMmRHpgpa
X-Gm-Gg: AYBFou3Gv2mdsNJVMXkBUUX1XaOS2cvFrD0TqB13JUtxXNk34h8Oz1agcmc+HsaSsKP
 z2ROO1JaBxBEjMXOdrNqNWPi1w4xqin8Gyrs2vQRnj/2h76xn70WJV6E3se9VJLyeQY/vqnzQKj
 fc4c5RufhYoU5Y8e5A7VgLMdkDocVlNbfXg/qIOajCFaqysRw3gA1s4rdx9/kLDxqPyDh/uSOnI
 u5oKjFFOKwj6qVYCNi9HL1nsxzyfvFLDMiOXCVONWJvyjaxAAm3VhyQ7A7k4/RkVK89Aq775Mdi
 kvWrhb8gqjALU8x2b4c/g5kyOKjGVgWUnkOpfdxLBmjzwiOxC7waDn/tzGeTmQDs3TjBGyvUA2v
 gnGQug8MqE+IlYRMnrPI7eWr+OE9s25m7BFezUabT67jb+6iXIx/KFDUFlKeexx73vneqRSllEs
 sZ7VEQtMDnenBRq0qYa6LZ0W85yoEZI/IBf6cQmbl8z1LHeWrATnQMH53LKzp6YPnhGZazY8usr
 nuA8Uve0/YAO0fQqIshHPVEWzBLxXzorBWNiv2NMo9ZrvsoJbxAvIf4M1ayP9gnMCAZbidURfkc
 RIdkWeRuoYcxhg3fUeKubCTHuA5VJ3YRkFQ4S4/3XHz2UtdbYYrLS5j/oDmqZQeVncMC5HjDEob
 ahaiErG5ggPJlBHcAfslG/3cVXPoybLGmQ+Ae/hEZ1oLuHI2v0ftiyi2v6BwWnzcpuIbNeU7g7h
 fnZDSGKZYeDkOFDqE=
X-Received: by 2002:a05:6000:454a:b0:48e:e9e:129 with SMTP id
 ffacd0b85a97d-48e5d5bf8d2mr9088295f8f.29.1793279392289; 
 Thu, 29 Oct 2026 06:09:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece14a1sm35692789f8f.57.2026.10.29.06.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:09:51 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 13:09:49 +0000
To: Selva Nair <selva.nair@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
X-Gerrit-Change-Number: 2069
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2069?usp=email>
X-Gerrit-Commit: ad26ba310eb387d5558d527898bda4e17a0c2783
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 13:09:49 +0000
In-Reply-To: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
References: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLklhYzIzZDUxNDFhOGMyOWUyMzlkMGYyYWVlYTQ5N2QzYTAwMmU2MDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2e6c24c68c42b6b2a832628e3697cfc404ec74a6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMPtH-000000002Yt-2fvr
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Optionally indicate
 username in >PASSWORD 'Auth' prompt
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3975300279322265120=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3975300279322265120==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="n3gliALUGzI="; charset=UTF-8

--n3gliALUGzI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Selva Nair=2E

Frank Li=
chtenheld has posted comments on this change by Selva Nair=2E ( https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail )

Change subject: Optiona=
lly indicate username in >PASSWORD 'Auth' prompt
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(2 comme=
nts)

File doc/management-notes=2Etxt:

https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2069/comment/8d688de3_b5683a9d?usp=3Demail :
PS1, Line 403:   diffe=
rence=2E The prompt has an addiitonal word "UN:<user-base64>" where
Typo "a=
dditional"


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/53779a=
bb_03ffae33?usp=3Demail :
PS1, Line 404:   <user-base64> is the base64 enco=
ded form a pre-defined username=2E This
This sentence is weird=2E Maybe "of=
 a pre-defined username"?



-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2069?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
Gerrit-Change-Number: 20=
69
Gerrit-PatchSet: 1
Gerrit-Owner: Selva Nair <selva=2Enair@gmail=2Ecom>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Selva Nair <selva=2En=
air@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Comment-Date: Thu, 29 Oct 2026 13:09:49 +0000
Gerrit-HasComments: =
Yes
Gerrit-Has-Labels: Yes

--n3gliALUGzI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Selva Nair=2E </p>
<p>Frank Lichtenheld=
 has posted comments on this change by Selva Nair=2E</p><p>Patch set 1:<spa=
n style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddin=
g: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail">View Change</a>=
</p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File doc/management-notes=2Etxt:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2069/comment/8d688de3_b5683a9d?usp=3Demail">Patch Set #1=
, Line 403:</a> <code style=3D"font-family:monospace,monospace">  differenc=
e=2E The prompt has an addiitonal word &quot;UN:&lt;user-base64&gt;&quot; w=
here</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Typo &quot;additional&quot;</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/53779abb_03ffae33?usp=3Dema=
il">Patch Set #1, Line 404:</a> <code style=3D"font-family:monospace,monosp=
ace">  &lt;user-base64&gt; is the base64 encoded form a pre-defined usernam=
e=2E This</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">This sentence is weird=2E Maybe &quot;of a pre-defined=
 username&quot;?</p></li></ul></li></ul><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail">change 2069</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac23d5141a8=
c29e239d0f2aeea497d3a002e609b </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2069 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 29 Oct 2=
026 13:09:49 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: =
Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</bo=
dy></html>
--n3gliALUGzI=--


--===============3975300279322265120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3975300279322265120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3975300279322265120==--

