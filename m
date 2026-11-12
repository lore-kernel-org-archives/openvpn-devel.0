Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A78606A327
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jJybWDqS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HsttxMaV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FIsRsjtW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CubXvN/9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=5H7wsSBNnfG74K63jXnvBfSCAruVRXsA0Ij5E6J7iqU=; b=jJybWDqSJq9At3yDFGQcCjjMO5
	Z2wHPcyC7u6ea5UO8adAB8NW6gGpkSxtGkvI8URaLu39Sk+Wl3YnGBVHct/f0T+ke67ZC5AzhqRv4
	92ODd48SilR0rvfY491U7YTorcHj6z7apHBtOFTLEDr1lqPW5Hlx27BdpKaGAU2UZ+Gc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRUoH-0000000042f-07bV;
	Thu, 12 Nov 2026 13:25:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRUoF-0000000042X-37Zr
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 13:25:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jxhBGbMT1Qz1U/A6X+GSYOnEX72PQsRHd7oxjOBiHdQ=; b=HsttxMaVfY73hhTDkNvU2fB3bq
 Ft92LfZyAW0Ka0vl8TGu8jx4RVYbLsz1ofMKb8bQj1qy51CxCE1ntlyNaquJzBbgZaqROSqU1fTgt
 FyrYlMm4RpwoMzqP6hOO1ztyz8LC9+vt+pxMthD3d0WtZKIQODrQQLARl3uzs2xbLBDg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jxhBGbMT1Qz1U/A6X+GSYOnEX72PQsRHd7oxjOBiHdQ=; b=FIsRsjtWPb2XCiHfScVy39THOR
 s5vxSLogBgoqZ4MSbCyZukK/chVX0JyQ3aJNMcRCbAjfDlw+4jJxJxkesIwmZywtDzHzz+99HnDSb
 duPp+gIS3rQhJ2PJGz6PBiAp9fHcdFzyQAwFgZHBOg3LHt18EdQRMDBpZbc18sldwrbQ=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRUoF-000000005yg-0Q2K for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 13:25:47 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so3587357f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 05:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794489940; x=1795094740; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jxhBGbMT1Qz1U/A6X+GSYOnEX72PQsRHd7oxjOBiHdQ=;
 b=CubXvN/9GCvhBAmKelsZXGxSK2QwLeakO4YbZ6cm8MB6MrouNzzTlQYH9WnUoOjgmB
 UeUq02mJqn+nlmvczJJVWKvFpdF+vikJ9ouVe7Im9QDRexu4Gxo9xa5Ec+dMkrulyKP/
 TVZGUImYGT1wK1977CdY8718HL26NAaXmMQ1hVg6py0Qs3vrNnoVb8RO4iFNn9GzjUA+
 4dx2r1TXyk1uYFLlbe573mVfnfu65rob4HKM9C/DB+6td+6w7M8rvLdyfUcb9kIUQS44
 7Oi4C+5nGfMtkRSJ5OgxCgROF9ZcKPkp2ncMqH+RqPq78pra5JQRpWE/CSp65F0u3Tn9
 SdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794489940; x=1795094740;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jxhBGbMT1Qz1U/A6X+GSYOnEX72PQsRHd7oxjOBiHdQ=;
 b=v6Cy73fkF5JsWQiTDpnxzntmLWHmd0miZGkd2cBGPb84n8HLA1N/LdCpu7LPbDcTN2
 kulXpzI++HtUSFQ/Caj/anUMp5JuB5she2AYFGNcpfOlOUocjzIVVlLKkXvRettY7feD
 bvg8MEeftyVUZ4MhkDP9AcO8DyuKz2hEyMdVUukJsjNprpQcQX4yvMqkHIjEYT8UEL4m
 JEVqde8sM5t9YKGFzxgAp33J7adxzhy1oFSyojQk0Q9Yg77a4qYeaEceY24sDrtZ+MQR
 xJfFbyrsAJyzubeT0iiRHLIqs4jZi2urAJLdaoYYXApPaJmGJVkFEhnP/XDHonbMQ+FS
 7nSw==
X-Gm-Message-State: APuU4Z+cAP1MnUsnCxloQd+OV76NwF7J1vvTlcf3Rga42uHy3rw96+12
 XQPLjFe2WyP4LXPSeVWgYRqhoMDps8p/fpDe/y/acbVZVnojyLOApYVL29QPz6WtRZNVo7jQ0gA
 Fa1LfbUFFtW0iDzxmQRBOTFiCVJFNoawWrUdWD2yOo7cDnV+ooFY5Km1mtd3YqsFjpBsNnLRCVY
 ycFe17hQ==
X-Gm-Gg: AYBFou2Lv+aUlvguQLM09gy6dSv5II6dbo0IRQ05C+r0me0/x9yv7yUEGnK75Cr9vgs
 5vHfJM5sQNkhG0TzzNWzNkhPNObUhlGN0J/Cx3D5sQpEIOShkGoVEipwBkJ6iF6N8cmWfOlLjE9
 e+Tpu3aTfVT72Js8jOqTAbOIuViWTofInbNY7iplT6EYDIYgDTYppTkmlPGQv1ZeNxl6mPfFCgm
 aAiaxYdKlo6buMZPojM7xE+1lmUh04+e/jDZb0dfXC9mij1bhFEOS9D2D/LySwDKTUE8KbVQvyW
 iwwAEsuw7cNrOVISPEkbIDK4pPm1TQCqFlo93pRAK1WlDgW4FKQQTGKSOGA3HQKozIuGXsOdFSr
 hGnlij+AfPcVbThdbxKc0Ni/sTYnKhvHGUgI96h8W7nWvEtOfGE5Pcinl4RSHWtQnvWrKU6s2gI
 g0YYJOxMPzHOoN99YPvWGpnyBYf0DD39G/nWnt+7KH5UeypvTq/z3xgs615744g+yy76aIFnYJK
 0plMytMK6s6r5rrWE7/dr3KQp8QDyBIcNy2Zi2Mh03HOiBTFyUXtTFrH3AK1rZnPbwKyz8LcZ4l
 6HCfX2mJGYoPtMlu1nemNBSHlwPOJbR725/zmsJNz7CeIXRWuToSZ6qgAr5B0/kEE/pekVuqpr0
 zPOPOqxj4kCTo/uwl0FU7QwXpkHX9A3ktVCBUzRxElDq5cOIGXirzhp94fzN05fKuDHzEietFVv
 +hX/pKcECYKy1lQbk=
X-Received: by 2002:a05:6000:2411:b0:48e:824:f0b9 with SMTP id
 ffacd0b85a97d-499c7b1ac65mr9973718f8f.45.1794489940333; 
 Thu, 12 Nov 2026 05:25:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363df7a5sm17136147f8f.37.2026.11.12.05.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 05:25:39 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 13:25:39 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7
X-Gerrit-Change-Number: 2181
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2181?usp=email>
X-Gerrit-Commit: 83a04dd550400b17b8881a46a8a2c8f0f8038c84
References: <gerrit.1794489937000.Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDg5OTM3MDAwLklhZTY1NjkzZjQ5ZjQzYTY2YmY2ZjU4YmJlZmE3YzMzNjE4ZWJjNGE3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0665def91f3ebf1363ea93ea32d5cecfe8c36e5b-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRUoF-000000005yg-0Q2K
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: resolve: store the
 address family in --preresolve cache entries
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3973275704095594662=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3973275704095594662==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6fp+NhQ2giQ="; charset=UTF-8

--6fp+NhQ2giQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2181?usp=3Demail

to review the following change=2E
=


Change subject: resolve: store the address family in --preresolve cache e=
ntries
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

reso=
lve: store the address family in --preresolve cache entries

get_cached_dns=
_entry() matches on ai_family, which do_preresolve_host()
never set=2E Any =
lookup with an explicit family missed the cache, so each
restart resolved a=
gain and appended duplicate cache entries=2E

Configs with an explicit addr=
ess family now reuse the preresolved
addresses across reconnects, as docume=
nted, instead of resolving again
each time=2E

Change-Id: Iae65693f49f43a66=
bf6f58bbefa7c33618ebc4a7
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2E=
org>
---
M src/openvpn/resolve=2Ec
1 file changed, 1 insertion(+), 0 deleti=
ons(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/81/2181/1

diff --git a/src/openvpn/resolve=2Ec b/src/openvpn/resolve=2Ec=

index 46a7f7b=2E=2Ed1b132f 100644
--- a/src/openvpn/resolve=2Ec
+++ b/src/=
openvpn/resolve=2Ec
@@ -561,6 +561,7 @@
         ph->ai =3D ai;
         ph=
->hostname =3D hostname;
         ph->servname =3D servname;
+        ph->a=
i_family =3D af;
         ph->flags =3D flags & GETADDR_CACHE_MASK;
 
     =
    if (!c->c1=2Edns_cache)

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2181?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7
Gerrit-Change-Number: =
2181
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--6fp+NhQ2giQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2181?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">resolve: store the address family in --preresolve cache=
 entries<br><br>get_cached_dns_entry() matches on ai_family, which do_prere=
solve_host()<br>never set=2E Any lookup with an explicit family missed the =
cache, so each<br>restart resolved again and appended duplicate cache entri=
es=2E<br><br>Configs with an explicit address family now reuse the preresol=
ved<br>addresses across reconnects, as documented, instead of resolving aga=
in<br>each time=2E<br><br>Change-Id: Iae65693f49f43a66bf6f58bbefa7c33618ebc=
4a7<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<=
br>M src/openvpn/resolve=2Ec<br>1 file changed, 1 insertion(+), 0 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/81/2181/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/resolve=2Ec=
 b/src/openvpn/resolve=2Ec</span><br><span>index 46a7f7b=2E=2Ed1b132f 10064=
4</span><br><span>--- a/src/openvpn/resolve=2Ec</span><br><span>+++ b/src/o=
penvpn/resolve=2Ec</span><br><span>@@ -561,6 +561,7 @@</span><br><span>    =
     ph-&gt;ai =3D ai;</span><br><span>         ph-&gt;hostname =3D hostnam=
e;</span><br><span>         ph-&gt;servname =3D servname;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        ph-&gt;ai_family =3D af;</spa=
n><br><span>         ph-&gt;flags =3D flags &amp; GETADDR_CACHE_MASK;</span=
><br><span> </span><br><span>         if (!c-&gt;c1=2Edns_cache)</span><br>=
</pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2181?usp=3Demail">change 2181</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2181?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2181 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>

</body></html>
--6fp+NhQ2giQ=--


--===============3973275704095594662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3973275704095594662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3973275704095594662==--

