Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC43606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l7ukPG5n;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=f2hRHhh5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e5/yY2I7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JzWcr5w1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XNKhSUHCYeEnugHK2z//BOHz+4xSxnHrPk+zK5+1Arc=; b=l7ukPG5n0aRsgntHr0O4P0BWoQ
	zukomu9CujlqV7Q9r9pLQKmzeMN+pHEoHKaEe6zmy8zKcBFo+3W/RDnTM/n07PEoCurbsuJbv05nb
	wJtW/5APvDEc9Bw+d4CfCevTbJ3RuwAjMyh+ZWai3LEIbvFNaKScZMbTWvoXfxBIKcIk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTdVx-000000000r9-34CY;
	Wed, 18 Nov 2026 11:07:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTdVv-000000000r2-1ygY
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:07:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UECMvIwyQVzawm5LqBni+CYAtLbXQf4kmGpbDazGTxc=; b=f2hRHhh57S4852a3Xy3uNI3ql5
 kE9EJ9kLQzYwD1X8T6XOgS9OrV6oTQbhAsnnaAflOz050PLvtpN3+1BzknNkdu3faRg6pFBcHe7Xj
 mW3RpYDhIQWLld6q16wg0DYmP1NSC/7EcUHbTNP2vuR7N7MPtNkR4S2wCqH6aoDEd9sA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UECMvIwyQVzawm5LqBni+CYAtLbXQf4kmGpbDazGTxc=; b=e5/yY2I7/tl8nIBe3BQHIkIFmj
 r4ElKSLd2cUcknM2MbWoPR9IYNnIu9ygt2X1M9YLOe7Q3rr9tlwo8w9t7/KgezAqD1H/j3fJ0UAfR
 4Gk5LvSNYAmXE06gKleZikIIKls+6Tu/LYpZSueaVbRXx+F9SPXxUjKbXBovlb8F9578=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTdVt-0000000078y-3NHz for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:07:43 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so11352005e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 03:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795000055; x=1795604855; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UECMvIwyQVzawm5LqBni+CYAtLbXQf4kmGpbDazGTxc=;
 b=JzWcr5w1ket724L2oluTj9ttI537AZfGNyqg1GsaAV5IgKrpXZmsAR9tl/I5vUhVDA
 V7fQOgzVJwU+NEFiWwaz5x3MS4PXWGf2QtETY5+yikuCGkthJXszswPDEOb9K8Ys6VYu
 wamJmfKrYTD1DYKbcshiLV4ONimGwNo8aMILLOCLZoBUgl4Dmevhf4vWPFbdN8vuaeNH
 wO7aCOzzlxwmClgi0Fm/xL3mKa56rLhlKKwAFh2FmAKhaLjP8XmGuOZf4Xo8bB0jtyPj
 p9hduwPbySrgx8aeL8tuZcfQ5aZqdrl1nAYM2VR69401J9NLHJXUADZYCfrhyZfCMIOe
 RmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795000055; x=1795604855;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UECMvIwyQVzawm5LqBni+CYAtLbXQf4kmGpbDazGTxc=;
 b=oPXUTxGSMsMbpT0QmWeYtuBKh3aArArfBl2Tb8eyvBjzbpjfZLIKdJUpXhasWvWopY
 Q1gpXz0MhcP0hISuMXBXKToNRSmKYzhICdwkh+MDXHJbTJvk96g3eg/ngFvy1Svlmh86
 gtt/33M/Uaf6g6TKRAuDFHasSoBvEIOa0eL/eBNkhIeD0vpiubeEW59HFAmUjrRPn7iP
 IZk3tHBmI43Uv9Mne6yFzQuXIYqmANUNjBfs7fh1cVmvyhKSkIWciF5ytsGIW8UuAOTf
 nTnhcSl1G3P1qDd4VKQ6A8ipsqMZ1tJkpsW52sbiNBon0Cc7HOlcQqFEsAOedJOp/Ds3
 ntGw==
X-Forwarded-Encrypted: i=1;
 AL+hErHrmtA1SMtq+0mAAsYqrCuy5qx0A1zEve2/xfc1RfZ2pFh/dbA8UKsJsSYcVnqMSwqFf755LgkF0SVB6pV6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9A8z7WXXPwbs10Zp3xIlm95YOgIU7JczzL6ueQvG9VMccsMO4C
 +KSEz5kMjQmrTSEL5f5uyUd3GQIHwFv2VTBSZ4I/57zzyuBlMBuULiS6CasHUwpFFmKNgzf7OwN
 Oy2MbksKtwS+DREpcKvsoVB50GV5Ux1GLo9dtstavb9s4NrzVj4cWTxKKlUTTp/CEqx3lffrFHX
 wjgZ5b5g==
X-Gm-Gg: AYBFou07lRVChdE8zfya00qUgkAZ8dKH5PAJkpWEer70Y6MxDfnT0ESozz44CMXAS73
 Zh36BnhI3fI3JSY444S14VNSrAHY/RoawuXSgeU9xaPxphcV/KH17o/rWFB6NyVslRG0hA6CJ/e
 rcsbcpMr8jEHm3823ViDhLZTx0QbrSDkbRKNQYebUaAvJ3FJVpstDcSMKwd5qqtDr+4lQ3VKO6u
 3DfcrS/yguLY6IncSOjPJBBMlbEh811gCf/zU2IiXMIAWLdpv0WjQwsDRDYw/siZjiU9fHWFJIJ
 UW6q0BfFxxbz0BuBwz/+7TFjk2LsF544qpP3ri1GXNlaJ3Sc8fjqX5+U+ODINtZIDVCcK5rpOrc
 atlM25yWNKxotOkS2+Wew0dI/lkf/iK0hbs9PuaCLSiH/maC+DLLFOQ363h50MDenqly++9VomD
 UOFUKOntflWWHZCSawSkryrx8nKGpwAehr/1UtL3x8NsVTvV88qFjpWCpp9Jj0KPQg1/QC4j2ov
 bF7EIwmMVuU2A3hW1uoxF4jWwF0At+YB3JVu2MJhm7FjOkNu6d3lSxWq38McGnXWxvePudWByRW
 I0oYQxk3M7QwnKAG5ABlZMk5CJ9PN7C6EtRNPWM8YWcSa8B/kciufaia/SbXnFxbtK03yvxL/rY
 6HSozNOc6/2ftnsxQ0lpTHmpzr9vv71EiW3hFPt6UqLZongUSgRGa2yHnFV4xj4QzZGLHHGAdnA
 I6mWinGQ3ivza3dT9c7PdIciAJ54yNXX1HtVqh
X-Received: by 2002:a05:600c:3509:b0:4bb:68b9:f610 with SMTP id
 5b1f17b1804b1-4bb7da03954mr41569615e9.9.1795000055045; 
 Wed, 18 Nov 2026 03:07:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d28ec3asm62537775e9.0.2026.11.18.03.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 03:07:34 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 11:07:33 +0000
To: Aravind O R <aravindor@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
X-Gerrit-Change-Number: 2213
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2213?usp=email>
X-Gerrit-Commit: eace777a91aea4065622707b07668aaed6b3883b
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 11:07:33 +0000
In-Reply-To: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
References: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTMzNzI2MDAwLkk4ZmUyY2JlYWRkZTNiYWQyMTg1YzRjZWU4MjRlZDJmZTMwN2UyOWUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <199fc92d1198fe1fecb6ae504713418a671d815d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTdVt-0000000078y-3NHz
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: add
 compiler and linker hardening flags
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
Reply-To: frank@lichtenheld.com, aravindor@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3227457875856618960=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3227457875856618960==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OFojnUYzJoM="; charset=UTF-8

--OFojnUYzJoM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Aravind O R, Arne Schwabe=2E

Frank L=
ichtenheld has posted comments on this change by Aravind O R=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail )

Change subject: confi=
gure: add compiler and linker hardening flags
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File configu=
re=2Eac:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213/comment/7f57bc69_=
50eb3312?usp=3Demail :
PS1, Line 1273: # Hardening flags, a subset of the O=
penSSF "Compiler Options Hardening
How did you choose the subset? There see=
m to be quite a few missing=2E



-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2213?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
Gerrit-Change-Numbe=
r: 2213
Gerrit-PatchSet: 1
Gerrit-Owner: Aravind O R <aravindor@gmail=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Aravind O R <aravi=
ndor@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Comment-Date: Wed, 18 Nov 2026 11:07:33 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: No

--OFojnUYzJoM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Aravind O R, Arne Schwabe=2E </p>
<p>Frank Lichtenhel=
d has posted comments on this change by Aravind O R=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">View Change</a></=
p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0;"><p>File configure=2Eac:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2213/comment/7f57bc69_50eb3312?usp=3Demail">Patch Set #1, Line 1273:</a=
> <code style=3D"font-family:monospace,monospace"># Hardening flags, a subs=
et of the OpenSSF &quot;Compiler Options Hardening</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">How did you c=
hoose the subset? There seem to be quite a few missing=2E</p></li></ul></li=
></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2213?usp=3Demail">change 2213</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2213?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2213 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Aravind O R &lt;aravindor@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Aravind O R &lt;aravind=
or@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Wed, 18 Nov 2026 11:07:33 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: No </div>

</body></html>
--OFojnUYzJoM=--


--===============3227457875856618960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3227457875856618960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3227457875856618960==--

