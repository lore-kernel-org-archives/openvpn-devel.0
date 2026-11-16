Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF4606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OSFjAxa3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HGoki97K;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ICLe4z3B;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NpxQib3v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tWpbBYVioZ6eA00iJJbi+akNLuSqBVsy4N8y4zdRLYo=; b=OSFjAxa3CsxwBSFDmEYBA0nJOA
	5EFOwPg7t9Js4rjIgj0LzUp7hG3V+an/+ZoA7EO0H3cVxzfSuYHtlEYvInok7uoFtMz1J2tK1BGjo
	zTlRCZehwuYFahDwG2ZpLlB/kFpxlAh+9gSeAkWkWQe3FNQglUnKjC2gcc15U43KiMVY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSw6x-000000005Pn-0Mt2;
	Mon, 16 Nov 2026 12:47:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSw6v-000000005Oc-45Ve
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:47:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NPFrRrRct/lY1/N21ubQqCsVEukFZpPRU0k6hvr0WJA=; b=HGoki97KsxsGIoQFxWGOwtygpS
 N6ys8P1r6ygrrDZ+9qkwQNlupPT7ol+bbtyPJaiJYbdwSEz2H0k/rw1BUmONY9pLwl5xLFW/5OFKs
 2Yqz/jThniNrjHJqYbdhTAXfKmn244LDUzSAnf59bAkygnBB3aFvIPDX936GA2bin6pc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NPFrRrRct/lY1/N21ubQqCsVEukFZpPRU0k6hvr0WJA=; b=ICLe4z3B4s0fJk99r+4ogV2OHm
 DJFn9A0l1ctrbnKQP9tJvbB7KwFNMWGdlaOnz/PFAiJpBtqMp6KIxIOZF9uCyQDyuPof09jM0SjGW
 0bxx3kvegKQbjy5tEq3M5MIwdpeM7hejlJMn+e88Pgu7xrfOW+AAEpX2BBocBrK8+H9s=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSw6i-000000006St-3w7c for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:46:50 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso2440877f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 04:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794833202; x=1795438002; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NPFrRrRct/lY1/N21ubQqCsVEukFZpPRU0k6hvr0WJA=;
 b=NpxQib3vOtjqgegrLVc0A7UCQsk58/RjcLz3NTHm4cXcPZy/lKtTqjC8elA67mXVdj
 03ys158I0EX7kf4sowDd7IYbJNIue0tZNQdebutrhEptM/2bDYKjf19GgFRwYK2NNnRQ
 glWko3IH6NxZ+AcyuhvVOMY3DgH2X+JEKvgSjtut95zR/lF0+IxCTEeS8kMl0DDF+d9J
 JibDzJJwNUDADpJKI8AcLVwEy0hpldcneoqgppRC1gjyYW62a6DgtO/Idw9HhewmCCoq
 UbFpJed1XKoloNko7LzO9bZNVHkwbU/WnfAODQGeBQJ2K8X0LposOIVf4zVUGiJ3dXWM
 EhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794833202; x=1795438002;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NPFrRrRct/lY1/N21ubQqCsVEukFZpPRU0k6hvr0WJA=;
 b=yKb696icf9V+/Qed1vjTttkp+ClqkK29T992jSObEqFyMXY2BR+am9oWxdZYxUIH9U
 NURSGlkPwd27XWgEGgIldiro6id7VXbX/S9E1msugyIgw2LFojSIrG8jD3Ahewo0xemD
 muNYbshgMqEilbQFCSLvPqEzaHXLKghzSHR15dbfmBMGdIZoIMDdovniXXFbInfVxMCX
 NK4jgHHxcZjuQnIYnjAa9oSzv/NyHnNQ7cqmNasi8t8fSmJZGcib34jU4L5QQHbM77O8
 HN/+kM4VUx7erqcgSj3rcuD6xXibyFY0789RE5BLaNF3WntiSUSp6rPoB2b1zvES6ITC
 hgJw==
X-Forwarded-Encrypted: i=1;
 AL+hErHwaAGZyg/kIFO7vH7MZgQ2cN4DcSR1lSE15UEpNHPSru5HsQS4tLLQLZEPSpnj+bcHkK6zfUBTE6iY2cWy@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8IyEnwgvYP4ux5+HZ1e3aZIZtbAhfXPPQGPWTYPyXb2XVT9I5e
 Nm7NJhrydYl3XRtvX/cio9MnPzdTJybOXV6rKYD4UuUemSoRFT0yQXv6TeWWGogF1GJD6HHUFsy
 KbbsAnRLsi4sp/lcfenNyJmeDGbWWev3mvqkCkzNUAAYzSuhB6LhtGdivO1jkMVol4yu1eBJGC0
 R2aQB+TQ==
X-Gm-Gg: AZFdTZcUxLw0GFQrJC8B0Y6wQ2/03Qtm1T2DdQqNZ/6cI5bEM8xg0afIqmMYK33ixkM
 VSbltGQXEmkvVLQ1G2f1cIQBbDajbT+/edZhjOjsvmpnrc8XMBP4JBR9HR71iXkfneNlnevy/aG
 sEQCa9ziVKkIgcB2vStJvGHJ0dRHBHT3fOoJtdfhf3KJLml9VaoKzU+z7w4rO9ejBf1Ud9cOQDW
 E61qJcHQJQXKsDOOqJmCg7b9jXeIdeEyH42SdcOvrIV7ZbqpyQE/iZK4q5MndAn8n4ah3+tprXI
 Mw/NoRQBzfz3fF52RJTJle5hE54f/S8implqa3moIYvwgz0oh/8ndlT4xGCOFeAvBy7nIbTGZqm
 GjnZtehvSrS65A2JTcPPT3vHg1nx9mTHkp23f8tRf5677YqboALC2TeVi6Aqo3/CxQ2hUbsf8FQ
 PaW0bAibRceNU/iEKJQJCmmN0FLdf/PSb1iHA+hSzM6WZY7wsdiuNn73LpdaJn8P/89pbRVSPc5
 V5Fi/yWL6eXNh3kHjIl2yPIPDtl/6QqHTai07IuGvqWfISoq6SNaEp88ixbtvBoF1RxgRvndG8C
 pY0zb43RF4QFSDfHAXj8aYcrw4biENsXS21GTR1zpWzMV1p8vxprhWB/wm6HKJEbdI6IKOcJ5Ln
 pXGfxlIiOrSUMzh5P1fY6docKC3ZDhTw6EQmDTkva0EDwIPRWWDfn54uflbmaRS3CzXCe2J1BrX
 6VostM83qzzfwOHvU=
X-Received: by 2002:a5d:5f88:0:b0:48e:4e26:146e with SMTP id
 ffacd0b85a97d-49c73164936mr21787772f8f.55.1794833202104; 
 Mon, 16 Nov 2026 04:46:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60f8e794sm21304047f8f.59.2026.11.16.04.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:46:41 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 12:46:40 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: cda7012200ee819ccb2245cd59e858b5b32ea867
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 12:46:40 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <67a5859114bb525c0c90080a6cd7d2c57f9aa398-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSw6i-000000006St-3w7c
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add
 P_CONTROL_V2 and the probe request and reply TLVs
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com, frank@lichtenheld.com, charlie.vigue@openvpn.com,
 lstipakov@gmail.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1150519558099636257=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1150519558099636257==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+Bp/tE4rksw="; charset=UTF-8

--+Bp/tE4rksw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Lev Stipakov, Ralf=
 Lici=2E

Arne Schwabe has posted comments on this change by Lev Stipakov=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change=
 subject: control_msg: Add P_CONTROL_V2 and the probe request and reply TLV=
s
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 24:

(2 comments)

File src/openvpn/probe=2Eh:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741/comment/dd5a9fbc_5ccb32d4?usp=3Demail :
PS23, Line =
53:  * connect_lifetime and flags (u16 each) */
WIthout having the size of =
priority, weight and max_leatency here in the header, the 5 is basically a =
magic constant that comes out of nowhere=2E


https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1741/comment/acc1c783_332f9a48?usp=3Demail :
PS23, Line 69: /=
* the other addresses of this remote are distinct servers, so probe them to=
o */
Maybe use doxygen style here?



-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-N=
umber: 1741
Gerrit-PatchSet: 24
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ralf =
Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: chugly <charlie=2Evigue@openvpn=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev Stipako=
v <lstipakov@gmail=2Ecom>
Gerrit-Attention: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Comment-Date: Mon, 16 Nov 2026 12:46:40 +0000
Gerrit-Ha=
sComments: Yes
Gerrit-Has-Labels: No

--+Bp/tE4rksw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Lev Stipakov, Ralf Lici=2E </p>
<p=
>Arne Schwabe has posted comments on this change by Lev Stipakov=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View=
 Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/probe=2Eh:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1741/comment/dd5a9fbc_5ccb32d4?usp=3Demail">Patch =
Set #23, Line 53:</a> <code style=3D"font-family:monospace,monospace"> * co=
nnect_lifetime and flags (u16 each) */</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">WIthout having the size =
of priority, weight and max_leatency here in the header, the 5 is basically=
 a magic constant that comes out of nowhere=2E</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/acc1c783_332f9a48?usp=3D=
email">Patch Set #23, Line 69:</a> <code style=3D"font-family:monospace,mon=
ospace">/* the other addresses of this remote are distinct servers, so prob=
e them too */</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Maybe use doxygen style here?</p></li></ul></li></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 24 </div>
<div style=3D"display:none"> =
Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Mon, 16 Nov 2026 12:46:40 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: No </div>

</body></html>
--+Bp/tE4rksw=--


--===============1150519558099636257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1150519558099636257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1150519558099636257==--

