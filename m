Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C961C2A09B
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vt8k1cyOcTL+Krnj+RrTDl9WdXIWb72z+piTGWZJpV8=; b=kwODBL/cQJC7B/AwFo5YJRuuJc
	3nmI3ocrqB3cm9M77y9Ik0y3qD630yfW9kLnWxWQ7pXUbrtQ7MpU1Pe1fP01cVJ5ojwVmvNR/1XIB
	BXgDwyhdUWk531vrvq21duqgBbn6jXkYsOcNnxMb1zyzS4rMLOi6gMzYaKe3s3wsLgGY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsMnI-0002vc-K2;
	Fri, 07 Aug 2026 15:47:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsMnH-0002vV-RI
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:47:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=82R4VBVnrajiw/D5Gh7LTXQ8ZIEl3hGfiLUYh2AT3JU=; b=LgZtDbucXqVIx/Yyxq3ZXJA5VL
 gI41pcLnn/P/rhXhsgl3PFuDVRaX525xcTqN0n9Vx+5+soHaWvK6yKz9hAvMdzJ/yEkkK6cKnkzhK
 St6YSGQvfxnUZGyc5HHeFFixKzg4W0szuOpjyPoibRicF+cGrgBbWkfD7GtociahTq4A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=82R4VBVnrajiw/D5Gh7LTXQ8ZIEl3hGfiLUYh2AT3JU=; b=T
 rJoUOEay6ezzmPsTZAUke4z0dCEVg8FDhZTof9tEv8BZPwqdNNyPn5b9fiMGaQmsVYGjl/iKwYCX0
 1PjZHPSUil/0mmkjjvk4lL7Hzwi0lF+yEDyaPlUJ/CPG75Rq9LviqWvP8qu2bFt7SGmxVkREUsjLZ
 fLvIITmlzG8kMteE=;
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsMnE-0002Mf-Le for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:47:33 +0000
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c16794450aeso478071166b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786117646; x=1786722446; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=82R4VBVnrajiw/D5Gh7LTXQ8ZIEl3hGfiLUYh2AT3JU=;
 b=LqqTFBDlaRPwP3wDVjJU1k/rRTxGH0aF6ksTBlDU+waLIIyDhHerC+uYLvm39PJ5xw
 33LvGBlgmMkOi05pPUwcIAceZeCG1xqu12pxWgw+AGCwBJJbmcTObQ5m+4SJ+l254jZb
 hktjTvdvKYENMv1hAB6yY9kx5HFeuEO1H1GW+4Bf6FHBTvJmlnRCAlT3wAS6pOXB0cOY
 vdT0yRGeHB3/Oof1uSvtra4J/6BRitOlF7/j1iDUlGyrHn/F0VHTxDfV0raq/fjdz9Kf
 ln5qFFnTT1WKcVUpBst449XkgopIAzRl3/D/7VHJUCktR31H3ahm0jGGFvNTexcdZ2YM
 +BBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786117646; x=1786722446;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=82R4VBVnrajiw/D5Gh7LTXQ8ZIEl3hGfiLUYh2AT3JU=;
 b=gmjB2e4ndlsOrIjMb74DAwnZgjA7tT3kwAhWkZAwSG63EM830pj3TewQW4AT9E50jT
 0VKZ5NyECvYLtL6Y3YJhyKCfsajfbueSwbS5zOFusl/KIC4r1ZTFIJv7ldNcWgGB0kp4
 vZoJ9EAjGjAJrKnlnS9hq+UerKdpQCs9oesJGQAZuJl3V+zVZjCoHC53IkhaHKqFWkeH
 +subyTxebUB0l+y2zIUrHIiYuNruAS3mJPky/UV5aWrBzz9Pu9aXWi77bwvtR1C4KIKp
 9hyDmSKo2VO5hrWX3oUxB89u5WQQk2VPiDZp9RLbXeuIzN5MWeb67LtKwwiAkEtOv/bC
 ahdw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6wA55ElKU/sRVPnE7FI7j4pFou77GdpgJbTYFHah/2J0pcRJtPAN/sngqTtlCFOJ4yiDT4z9zdvaagEVn@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy/AezaEPPQn6tNiOgesdCnFGdHZItNFO+Tm07lvHg/pDpqmKCo
 ur4+TjmeFAcRHbiowh05kvqp8KoCq503SgY45wJbtLSe7z9ZUQlUZ7DYEkIHk0IK42c81d9b/3D
 I0SbegPZXYO15JpLl3/MKp7yvTsGTsnYgrqlUpf3o3340e3dMU9Tem2cs7ciizhBdhydRJCl7z3
 QuyDgWbQ==
X-Gm-Gg: AR+sD11Z/BxsAt4N2KiRN43ibR3DDwug+dm8ri4KG/5rRxsXcsNFXiiVRKau4HewDY9
 s+92aqng9a7EHFIYhi/DwGkLxoTEWjpdZqioQpeWuHkHcmZC2dG5Vyc4JTGfe5moS2GnY7iUjo7
 gz8UvlhR9ahFMnj8Iullq2rH9X10aMz9/ndkEmPSrdjq/kxEskKUmZCxkWfsefqvHXizR5jh0W4
 y9MqeU5Kw4FaYCYQEdau4lSSU3h/yE6kDOONzLrKhy4icEhDVuCHGOMyzKuKbX3wEiZ5w4lLGON
 hx+a+Ei+0OBlmS783rM/JJw5k7MuytgI8bcwNoGim0qUjc2jW9m1kdLjZ2hleCGHggba7bpUhE6
 kjrcIAkluGcKQBwCT0hZtwdmV3Nd+jOsZzUW/PjEtYgS8eGhOlj9e3vkjwnenFDi1jJdk+8hSLR
 ej/YJ+EPHbkntenSVTuNcOS8vORDfpmVJB0NLnPmsaMEpRbFTS6dy0YAFcRbsSg7N7ZTjPFhFO/
 zPTJiyBjxKtvgZ2UKycdxb07+5oonwWBQnzYC7e5HKU96BOqfZyWC91ucnVhazXqv0Y4IbNGYQN
 nk4hU9lcFUJIGYYrNK2pS+pAcURhychT3WO3XNE5pMmHVXbd3iI=
X-Received: by 2002:a05:600c:8b35:b0:499:4d4b:be2b with SMTP id
 5b1f17b1804b1-4994e7d2bb5mr289088625e9.16.1786110581333; 
 Fri, 07 Aug 2026 06:49:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995bb8b668sm51004175e9.0.2026.08.07.06.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 06:49:41 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 13:49:37 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
X-Gerrit-Change-Number: 1728
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1728?usp=email>
X-Gerrit-Commit: 65f7bf08caa1a473bf6ca5c0f1464485908e7231
X-Gerrit-Comment-Date: Fri, 7 Aug 2026 13:49:37 +0000
In-Reply-To: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
References: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTQyMjY4MDAwLklhZjFmMzQ3NWU0ZjI3YTkyMGMwMjhjZDczYjFhMjQ5Nzk1MzU4M2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <db24f3ca39f7add76da6b1c765e924ed30b17700-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsMnE-0002Mf-Le
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Do not differentiate
 TLS server and client context initialisation
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4632011766361636220=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4632011766361636220==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b1n0OcOiLiM="; charset=UTF-8

--b1n0OcOiLiM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1728?usp=3Demail )

Change subject: Do not differentiate TLS serv=
er and client context initialisation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(4 comments)

Commit Message:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/3e003769_758190ff?usp=
=3Demail :
PS4, Line 26: Our mbed TLS code basically does give the SSL cont=
ext any personality
> "doesn't" ?
Done


http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1728/comment/0997e078_7e579fd7?usp=3Demail :
PS4, Line 28: code cal=
ls SSL_set_accept_state/SSL_set_connect_sate=2E
> "SSL_set_connect_state"
D=
one


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/e65d33a7_d6283=
7fb?usp=3Demail :
PS4, Line 30: This also modifies the mbedTLS to use the d=
ecision to pick client
> "the mbedTLS backend" maybe?
Done


http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/bb73947d_7fe0c48e?usp=3Demail :
P=
S4, Line 31: and server in that path as the OpenSSL code path=2E
> "in that=
 path as the OpenSSL code path" -> "in key_state_ssl_init, same as OpenSSL"=

Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaf1f3475e4f2=
7a920c028cd73b1a2497953583d0
Gerrit-Change-Number: 1728
Gerrit-PatchSet: 5
=
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Fri, 07 Aug 2026 13:49:37 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@li=
chtenheld=2Ecom>

--b1n0OcOiLiM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1728?usp=3Demail">View Change</a></p><p>4 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/3e00=
3769_758190ff?usp=3Demail">Patch Set #4, Line 26:</a> <code style=3D"font-f=
amily:monospace,monospace">Our mbed TLS code basically does give the SSL co=
ntext any personality</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">&quot;doesn&#39;t&quot; ?</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1728/comment/0997e078_7e579fd7?usp=3Demail">Patch Set #4, Line 28:</=
a> <code style=3D"font-family:monospace,monospace">code calls SSL_set_accep=
t_state/SSL_set_connect_sate=2E</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;SSL_set_connect=
_state&quot;</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1728/comment/e65d33a7_d62837fb?usp=3Demail">Patch =
Set #4, Line 30:</a> <code style=3D"font-family:monospace,monospace">This a=
lso modifies the mbedTLS to use the decision to pick client</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">&quot;the mbedTLS backend&quot; maybe?</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728/comment/bb73=
947d_7fe0c48e?usp=3Demail">Patch Set #4, Line 31:</a> <code style=3D"font-f=
amily:monospace,monospace">and server in that path as the OpenSSL code path=
=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">&quot;in that path as the OpenSSL code path&quot;=
 -&gt; &quot;in key_state_ssl_init, same as OpenSSL&quot;</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1728?usp=3Demail">change 1728</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b=
1a2497953583d0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 17=
28 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=
=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 07=
 Aug 2026 13:49:37 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>

</body></html>
--b1n0OcOiLiM=--


--===============4632011766361636220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4632011766361636220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4632011766361636220==--

