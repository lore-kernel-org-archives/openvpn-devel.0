Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345D7C43458
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hKmNpexKHR86vTQcfxZyrGo8CgR54tK74NJ26oeW8tI=; b=JkAc8gywfKpKjrN3NKLw8b35rU
	7zkSzBt8Kc0bLGJOEwOlut0praCSx4K+KVx+9gubxMl59riNmxOl1WIJjQ4h35oCvhI0jI34oIXfY
	cPj6ADJyrsZzfNg3ktfIM/qPjjm91A9AEXJTxKokkW91RDDBbWuMp8pnDqOKyBoXVn/E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgiMA-00086G-7I;
	Mon, 06 Jul 2026 12:23:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgiM9-000867-DW
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:23:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Ec5TVAgjZZnyaqpyqqGzw019Bpylal7JoOYfVr/k0/M=; b=YKEyb4gsh4gaiQvBDKn3oA4Xfx
 DkMFwBJKj85oekuDQ1yIDVUKJQHFVaWaOXUWpYl+ncjKZ67hmeFvLZ4TxM9LcdHQsIS1rVpbe7foX
 T4xvOTjtt2asb/+VJPu1osjwaz5kvEwO7/q7HlBnp+/38HJSMyXfdjyLd/w95SeTQjlY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ec5TVAgjZZnyaqpyqqGzw019Bpylal7JoOYfVr/k0/M=; b=Z
 IWP3153mAiF0oWUToxyh4aY6uVCxy7tqZt8z1sJXy+IWIhmjunCNL79n6PeO5UA0WgxlDOfFb7JOS
 bSfQl/a2K/a1gpCbVcyz4BMdY3p48ltm7IpvOi72L1JLPrS5L8rOfrJNLYmcXuEzHmQFLvH3N50nv
 SL6QC0O+vpK0Ve3c=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgiM8-00052T-7J for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:23:26 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-493b1710405so18123165e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 06 Jul 2026 05:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783340593; x=1783945393; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ec5TVAgjZZnyaqpyqqGzw019Bpylal7JoOYfVr/k0/M=;
 b=Ysr2+CGWyjDuX/BvwMGcIKXk75Fd4u96sJFe1i0b1NSexlG3gH3p1Bk0wtfLojfv6y
 syKELMVb4X2pla3htQgcY3hkv1NS6YltXn6DRUIe7jxfQ7kx2xo3NyTaRFNIDXUA8IgZ
 BynivbM/nOcLf82V2opdpLNSyyKc9Azkl32kZ91bhRrhlpUITYofwujd2TX7OumJSj2o
 aN3J9VAEeIGu8Zv7n1Q8GNVBr4ANi/CbnqMr12KWU1/b0G+5sufN2MLpvxpnV3lFRqUO
 ZZha2pvTNbQX/JhKwDAXwUZnQ6mXAJ2e37l15hP2rj77pEvXPr5H9jpyZl8pH6OYU8hQ
 7FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783340593; x=1783945393;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ec5TVAgjZZnyaqpyqqGzw019Bpylal7JoOYfVr/k0/M=;
 b=QAnNwpZfGKRuDP0Ne+MNwP9HJuRZZkF1bYC5ZbIqAwIqKe/zjUz1pRtSk5Su6b1+/S
 Vu2TRQVC46xo92XplLddBaFBEKWlk9OJS2pg2WlsjBfW00xDcRYdDYwuLohVSyt3fhrO
 2BIG9vuA2SupmMlpi48HE9fQSkDTfdFgOhCKkY9UJFzWCm+7KUCsruqw89OVRTXfa/kT
 fTxoYPAvwu5bB5OKKYNzkHrJEbRyUYTiF6Ig7ZPFgjDfTDTZglBYxa55PHOkhKfW/y4a
 A5kCfroEBVrUH5xOlLqWlHaaafob9tK7IGWaq2zNVSR374j0OMJxYA9GO8PVF33ph94L
 eMFA==
X-Gm-Message-State: AOJu0YyIfhsNAzE4w0ECCgheKmU4tYV5+HG7RDznUHFaYHy7EN+e0pzH
 Vf9mrtojEKZeuur/P0bZQwsxszQ3zS7pujPPnPxhaSJ02dSO1jMHgLn9+cqkKnP+vIKXoOHce2z
 SKCZrH1zBFZfy7vEwl9Rz3N1BKY4ljHukuDJtZZeRvbPL0/p6bwpN4KZUm0adQEVK0DnH2ITUp0
 Wg2bYUmg==
X-Gm-Gg: AfdE7cl530ea75fafyYMFmF1dxih7VeGio/77lg69zgVM1NW1wGQbhNmR+GxH+0oKDt
 5fAHrJuaSXErfObApR+7YkfjfzLfKl4lmeDTqtyiZ7S2+sDf2tH4TZWsB2zWmTaj17myVIhEhxB
 Z0VXf8KmbryUeIJY3LIYt+t9QA23WwXWB+b40C7bgXYY78NWcPfAXBvJ++liyWZCUqV48FpacUp
 FLsj6IP5sbD6CfZeCwhjErfM3NEXyTq97Ph74k+7soX//RuZr+FGLuQxlZyPiVwzYsZkrosOhin
 bICoyXq8kF4TCEFAa9oO0G/gKyMPygAnjo1eLcv6ULeNVQ6QQkW5UJ0qmgS5uCeRlBhosAstJnO
 dNAnOMVEmWhIAyF4VmxCtA9af2JxM3VN7kMyqXGq0GMMhNb+t0Pl12zFnuIZYbVykxbwahli+Cu
 7KsAqPxAXJFVMVyGPVm66qjPnlfjaHRfJq/rITMARXzMUWWKsdTLRF0eo3nf1RKVadRi4/uvgkj
 DjeCYZZHqEMgNH93a6aSyAnOXdE2MBcpFRa5o4SiQuD2PS9FuCBkTQ7CIAO6MiROHNlF2EQwqaZ
 bFo=
X-Received: by 2002:a05:600c:4a21:b0:492:63c3:8eeb with SMTP id
 5b1f17b1804b1-493df09b53amr1492575e9.35.1783340593015; 
 Mon, 06 Jul 2026 05:23:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f8csm322147695e9.11.2026.07.06.05.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:23:12 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 12:23:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: 02696a6a2bd8999aa0d98b52d9eeaa314fc4843d
X-Gerrit-Comment-Date: Mon, 6 Jul 2026 12:23:11 +0000
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a7fdb7a993c13736a5ed0d860fbe865bc9cca250-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgiM8-00052T-7J
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 multi_get_instance_real_udp_real method
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8837543684525624591=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8837543684525624591==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9aEqcNbuHNg="; charset=UTF-8

--9aEqcNbuHNg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1725?usp=3Demail )

Change subject: Extract multi_get_instance_re=
al_udp_real method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/mudp=2Ec:

http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1725/comment/fb6cbba5_cdf65c57?usp=3Demail :=

PS2, Line 298:         const uint64_t hv =3D hash_value(hash, &real);
> do=
 you mean calculation of hash_value?
Yes, why do we recompute that in multi=
_get_instance_udp_real and handle_connection_attempt?



-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d3=
9
Gerrit-Change-Number: 1725
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Dat=
e: Mon, 06 Jul 2026 12:23:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-I=
n-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--9aEqcNbuHNg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1725?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725/comme=
nt/fb6cbba5_cdf65c57?usp=3Demail">Patch Set #2, Line 298:</a> <code style=
=3D"font-family:monospace,monospace">        const uint64_t hv =3D hash_val=
ue(hash, &amp;real);</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">do you mean calculation of hash_=
value?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Yes, why do we recompute that in multi_get_instance=
_udp_real and handle_connection_attempt?</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demai=
l">change 1725</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
25?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1725 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Mon, 06 Jul 2026 12:23:11 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>

</body></html>
--9aEqcNbuHNg=--


--===============8837543684525624591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8837543684525624591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8837543684525624591==--

