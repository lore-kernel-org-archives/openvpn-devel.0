Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BE606A31F
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bNoB5UyS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FmofopOJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hYMJYHIJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LnHY0FAa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=j5eek/lUV11PoG8whPiLJpkAsWl+ar5/uUT3oFHzhUo=; b=bNoB5UyStpnGFSZJdo9KGEnjcI
	ewt7W8Kr4/m1I8K77Bfw3goCMiDdaxDyjgxfN8CwxKh3QjOY44RYUaKloQvsKo+bf2cetyiT9Dp8M
	h+d6V8E2J28lB9Anb6ot0D7LOB5KuAZVjvINOVwmzXL2HGiHw1HP2NV2XDcvMgw8vi8o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX2UB-0000000029V-1zDS;
	Fri, 27 Nov 2026 20:23:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX2U9-0000000029N-330I
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 20:23:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6h8P7fOH6dCA8f2i8KpgxCotJfVorDtjPq7Hp7la/wo=; b=FmofopOJQ+YLwPhrfBWToSC++F
 q2M5w20s5aONcPrVor0AiATg8DzjOSP5dM9JIjwQKwdJS1PbE3NE9IG6Yw6oQJWk8RAC24b+j8NRU
 OVMeQ2XV8fd9+gtQ2mpkU+9Zh7l5dg+SeKzk9fo2P0E5/w4JqhWVt+jDxO7h44G5DgJo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6h8P7fOH6dCA8f2i8KpgxCotJfVorDtjPq7Hp7la/wo=; b=hYMJYHIJkwqrB0yxPP3KTfTL8y
 dkG/JqnCnGWuYiqF55shSHkROFBO/BGx5Yl5RH8ISrXLtPYGp38VrXakhoeAIAfgkLsO123FYhNKh
 w4BTFgI6gbWcLqgeRgRPR69VwOUuvcDIFDJ5t7VHYO19mQ7wBQ8Dw6usP6lxg/yOq/YM=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX2U8-000000004zG-0TSd for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 20:23:57 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so76662965e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 12:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795811029; x=1796415829; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6h8P7fOH6dCA8f2i8KpgxCotJfVorDtjPq7Hp7la/wo=;
 b=LnHY0FAaGwnFzCwGGlLW23PZwG+HfBrAO3tdEa0cqW7pW9ciJAbETQLBSQgkJnxgQr
 fVcEyHtx1etZPJZCVz4sTzPobBdjjoWs2eoDNZKYNfmKccUFsmNW/LvLyEp+o2ja47Un
 Jn8rIIepJzznKIbmhzQ+vPYe2waj8zkELkWYzls5sANTUYVk+CSLtRazzi9zUkBzrAmI
 bztRVHR7INR0bT82AeiAL/85M3c3YUF86jdHLDXnzgiy55Qc1kI8ALTnlEz02YK7Oh62
 wZwpdjBEVJFO8B8iaKPJF9rb/Jjn7gnx/Tg3mzi9DyGQPESGwItePHyYLJo/r851mrKD
 6vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811029; x=1796415829;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6h8P7fOH6dCA8f2i8KpgxCotJfVorDtjPq7Hp7la/wo=;
 b=0J5IAGzzK9WPyAAV6jlEsTIaVzDuuNRIQXV74rgu9EiMxLpdoeh7ya3OAba1ccqcQ2
 gGWteZP6050OFb+IW/68jA2YqeNNVZk8XUCHbluJ8O4R7k2c3jEMmqIm84GGnqt3UAsF
 WgFx1xOh3XPCsMZVXmh6GHyLz/VBUhi4Dwh4JszVboYuM4e4/6MbAR86wHGEI01RnZ2j
 EIwgtItFTzEDB6cNjno5NXUtd2Yhv3gReKeO6Pl720erjmLjgFwHSO5/n80GxyfkYlZH
 wi7a9OY5wORR9NtJ4TyvIzMWnToWPP5nnVXbPgRP/rVJGqFCKYs88hsR+koanyTGkefR
 7ZLw==
X-Forwarded-Encrypted: i=1;
 AL+hErEkdfLLq7SwNkneiCZlZS2kfUMoCrRNEwBlueKhT9EL+rgfJUQZhfXPECY3GXiulVJ4o92KOcMnWWaI0uF0@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9GdsyF6E0Ed1jOn+oC4+ZexoKAjoySt+RX004Rm56FC6IykA0j
 lKzgVBn6BU6gWSoQ13/76Ub71JJvPaZ0RkiaFYy/eaGJ545MlKfeYaCHxlDZQjTQhR94QsE6RsA
 jkzwunnGXLwCiR2Kc+db8lkDjb3N0EiENddqWP6eas7f9858TPJ0iWoVtNhpdya05btmI
X-Gm-Gg: AZFdTZfD7IcgTZeD2lcS3JYWu9TktbLpvrUZwO6WFy/8hOUJSYPnbXfDLi5YBJm8b8F
 SEWbJj/ufMTMo2GWvWZzRX2mAa5FRsNPMlhqXmI6zYGKd1CAC3EUW6BedE10o+Cyix4XQz7+0T5
 gWK5KjNaS1/6n0/oNAxGDMMInIkHKG7jrSzQ/dvIoO6TAbtTpHwvoCwWRH5kANNAdKUjk4FMY4l
 pHT7SOQ+a2ggXB2V7lmuYmsXb7PP/rZQDwwboHJOYq4NhtcY1b6KfynvL2IuEwrylIgSy9R6lwM
 4+hoaRxoC21Di6wNpf2/X1kswAn0kRCXF5BTFMZsA9Lcr6Bb/AqpQVyj+nKgyY+Om9NiGvD/ZQu
 HxYOCXVWFlHmGaYEsZIzC/fKdCdJX90vfHRPlH0/sYMk+kaENVCAQAXU6q7RbTQDXXNgRMLZqXh
 hh68MUKMfQr1Ku+l5mp4kpORyRu+EGQIUqiomhQOSNgpBQKEgnIu7ucb4V23nIACDJdA3ynHjbx
 rB9uR6fzN/BQLXulyyZXZdxbCTIUTULv6Rh7BWTBYCQL4Pu/ziEZsygmZ28Qpiu1du1XwohKWNY
 lfDfA+PKJDrOwsytmud69sN2DX2re+09u6xnAXYcWpwc/IzH43pI0CbvOLs3/BoVk6l2JV4aPj2
 OgU5niBI3WgCVDHl7+WVrkofCEHnZo6AA+gjla09d/XGMRT91aUDiVFVF155InBXNFulGlIVTWK
 Cp6ccfV7S05jfDRQoGm3a9hb67Xz+KQQl17xaC
X-Received: by 2002:a05:600c:3b94:b0:4bb:6f41:39be with SMTP id
 5b1f17b1804b1-4bb8880ca3cmr638972165e9.15.1795811029405; 
 Fri, 27 Nov 2026 12:23:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm756571685e9.2.2026.11.27.12.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:23:49 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 20:23:48 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7
X-Gerrit-Change-Number: 2181
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2181?usp=email>
X-Gerrit-Commit: 537906c2ff7caa7ba20483dc4a59adfb5f9ab27c
In-Reply-To: <gerrit.1794489937000.Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7@gerrit.openvpn.net>
References: <gerrit.1794489937000.Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDg5OTM3MDAwLklhZTY1NjkzZjQ5ZjQzYTY2YmY2ZjU4YmJlZmE3YzMzNjE4ZWJjNGE3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1c91ca3d53b13c1fd8a86d35aa00f59b868a0afc-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX2U8-000000004zG-0TSd
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2866130112837198135=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2866130112837198135==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GI6ulTucXkg="; charset=UTF-8

--GI6ulTucXkg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2181?usp=3Demail )

Change subject: resolve: store the address =
family in --preresolve cache entries
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

resolve: store the address family in --preresolve=
 cache entries

get_cached_dns_entry() matches on ai_family, which do_prere=
solve_host()
never set=2E Any lookup with an explicit family missed the cac=
he, so each
restart resolved again and appended duplicate cache entries=2E
=

Configs with an explicit address family now reuse the preresolved
addresse=
s across reconnects, as documented, instead of resolving again
each time=2E=


Change-Id: Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7
Signed-off-by: Razva=
n Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Lev Stipakov <lstipakov@gmail=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2181
Message=
-Id: <20261126115908=2E7374-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg42012=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/reso=
lve=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)




diff --git a/src=
/openvpn/resolve=2Ec b/src/openvpn/resolve=2Ec
index 544e5ea=2E=2E77918e3 1=
00644
--- a/src/openvpn/resolve=2Ec
+++ b/src/openvpn/resolve=2Ec
@@ -548,6=
 +548,7 @@
         ph->ai =3D ai;
         ph->hostname =3D hostname;
    =
     ph->servname =3D servname;
+        ph->ai_family =3D af;
         ph-=
>flags =3D flags & GETADDR_CACHE_MASK;
 
         if (!c->c1=2Edns_cache)

=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2181?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae65693f49f43a66bf6=
f58bbefa7c33618ebc4a7
Gerrit-Change-Number: 2181
Gerrit-PatchSet: 3
Gerrit-=
Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipako=
v@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--GI6ulTucXkg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2181?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">resolve: store the address family =
in --preresolve cache entries<br><br>get_cached_dns_entry() matches on ai_f=
amily, which do_preresolve_host()<br>never set=2E Any lookup with an explic=
it family missed the cache, so each<br>restart resolved again and appended =
duplicate cache entries=2E<br><br>Configs with an explicit address family n=
ow reuse the preresolved<br>addresses across reconnects, as documented, ins=
tead of resolving again<br>each time=2E<br><br>Change-Id: Iae65693f49f43a66=
bf6f58bbefa7c33618ebc4a7<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2181<br>Message-Id: &l=
t;20261126115908=2E7374-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg42012=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/resolve=2Ec<br>1 file changed, 1 insertion(+), 0 deletions(-=
)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/resolve=2Ec b/src/openvpn/resol=
ve=2Ec</span><br><span>index 544e5ea=2E=2E77918e3 100644</span><br><span>--=
- a/src/openvpn/resolve=2Ec</span><br><span>+++ b/src/openvpn/resolve=2Ec</=
span><br><span>@@ -548,6 +548,7 @@</span><br><span>         ph-&gt;ai =3D a=
i;</span><br><span>         ph-&gt;hostname =3D hostname;</span><br><span> =
        ph-&gt;servname =3D servname;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        ph-&gt;ai_family =3D af;</span><br><span>        =
 ph-&gt;flags =3D flags &amp; GETADDR_CACHE_MASK;</span><br><span> </span><=
br><span>         if (!c-&gt;c1=2Edns_cache)</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2181?usp=3Demail"=
>change 2181</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
81?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 2181 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--GI6ulTucXkg=--


--===============2866130112837198135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2866130112837198135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2866130112837198135==--

