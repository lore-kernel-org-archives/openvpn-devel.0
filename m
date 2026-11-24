Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF3606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UZ9LB2Gw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HZoimh07;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mvlqZb4d;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=O0zXSJQJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=XCunOP7EYyHjv+qxq564WCCiECiA9GDMYfd/52uo5VM=; b=UZ9LB2GwEndHXcCqH5We9WZYyO
	IeYKOU2jK6XOX6hv0aUNhYhli9bEY4L3/WAiIQaGddGHYI4Th1EVLnsLugD+GobPfNeT94GeYfPUR
	a/vdAjcuSo05D3jVyfj9FPf0YgnA3px9thsBFoTQRhbn2dWSVgvTdDq3U9DgIOZWUn3M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVnjA-000000007q4-3tgF;
	Tue, 24 Nov 2026 10:26:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVnj9-000000007pw-3cq9
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 10:26:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UH/7/Bl2u5fZ0hVjJPa4Ihghi/Go2sKtOdOW+Xsjrtw=; b=HZoimh074TrTNsXMWq0uurrMMa
 NEJRYL5i1H+J9xZ01pSNY/Ov0qZ35WnO+k6/z3cwZf8opsXoUWQQWDchwbR9hVxGNjpVOY1I8Mv2T
 WMcUYcSRKPTDtTf/4CIJm/JtQxomkOAsmveeOVhOMsdzvJUfhN175b6SWDV/j9thlvxo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UH/7/Bl2u5fZ0hVjJPa4Ihghi/Go2sKtOdOW+Xsjrtw=; b=mvlqZb4d9JZXjTQ6C+ODNb+dG2
 wGMae1rCxttCdpnz1sq+PMpf3ziR03LROyF+qyb8YiONNfeDSah3BJzFevEJ/MWMWA9CR0rJuUEj1
 0VxWVN4yKsIwWYFFFxkjozsVOToBrVIaCjyMKdu4sRavQpGjWudC2ZLgBjb7qAoGEGvs=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVnj7-000000007fU-19ZP for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 10:26:19 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so27633175e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 02:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795515971; x=1796120771; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UH/7/Bl2u5fZ0hVjJPa4Ihghi/Go2sKtOdOW+Xsjrtw=;
 b=O0zXSJQJAl4ntCGYrt4EwKbZZ09zIwkpuV4lCf+A9NSRLeTDdWU8Dso4TL/4lScJPQ
 fmGEFG5pomzqr8Fa37A1ME3hjai0wI+bOJy0KBwnxoAmvNouDj1ibBEzYZoiUsAikSb5
 LMMZ8WhhSjocjWWzSwETOlaM/i+b3LEDF3dBUvyqFHr9Gco8UAzC3VIXA8lc+B5QCS2n
 xDJwAviARKOKPRYK8S+dRYq6O9ZQuch9o1aji+T4yUTe90OGsb91Q0IRhT3t6cxdqfY4
 kh03CLjNGFiYs8j8QX0Y9Me2cyV7SyDChum+p1u2GlR262QH9JPKJl44uHDc3gVyCarn
 a6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515971; x=1796120771;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UH/7/Bl2u5fZ0hVjJPa4Ihghi/Go2sKtOdOW+Xsjrtw=;
 b=2H+49T3k4wGYSwzJYq+ZzZhNeyxB35z8YPDbROGTcxvFBvV/IbLa9w7Nz5i4KMjYgN
 M10fdhqzv+oql7PJpcHjV/nM/qD2aQEcgEPtLFj2ZcllJRZjFyicyKjA76H3ohp/xxSf
 njA3vFLK0Lk/K3FENTQFbYroGhe06Sdyyqupl3JByrKwXGnd6abVMSI/ooQCfJg7qP/S
 ibLdFew5ajKeiZOhkRWUg5uWDLH0PytcFuu4C7WolcR8rThQsRhWHj4jOcleWLIPQrWg
 zWXxXmeSa3FAiWv/XEyGaefwc6UOR1p9eos/7aR48hu6dm9jEdKvKeRUADK45+mZzvnG
 O+yw==
X-Gm-Message-State: APuU4Z/Qd+rodNkOMI3aKno92/Y+JdRSxyP/59ZMk38Q1lJDqZnoTvZd
 F2MLpxwu6Nalp59yhmOQ9NZuYzC9uUTBUIu0zDOZ/UxBxbRFqKbTshNfngbz02g5zt4rn/Kh13/
 u597vnYLmxvSjxN40dHgcn6RuWUjzOi6bs9oaCK3ndjuLaTq4lzmaN2dpQYIDcYDOuI7y
X-Gm-Gg: AZFdTZeaFt/vulYC4dh897VBwI678E5UY5OLW2E9xruhOmWCgr5CliEzLjg8obgdFmf
 kNDcm8ZwSB5JXAIs3IHypRIIBq/jP2smXArKwofx+mO5n/4RhmXwRC2zPTw0Sczrke6WVALCoJQ
 wVenssRvUJzrCGxCdcfXysf+/YA/fYUrExwgLClv1xj3g6T0k5SIu37ZAevSPyw1hPAwQOruqv4
 TxG0gxoCD1xa5ipR+y3vRJxNv3GG5XNO4i6mz2sObOrJdWpcvvwZ0V77jglAeby3MbXJgIWO48u
 T0dO3NFPJXtCwozuMdnsS2JqAlsY8CL9cvlB8yHkSjDH5rqUI7RoHbv7eLNi4y41eVfnyb0Id/7
 7AthzBYqF3w+y18qmeJ/zjhe7oxQ9R9Ar+oZaVu82EKNVt1HUqW62Ew8o6TvOpxFh+tCW10zcdX
 /M+XafMus+qG6wtO/7aFsXettbAlrdQ/Njy+FYSx/2VKJfMxr/0hm00dr801pHqWpY6WRQueyfB
 DDD8C10h4y5NGZ9oKZd/htpYXlZsjmjMrRZFqmJd2qCIrRheVmIq3RFiBSeKBz/Uae4m+oLAZAi
 zMuGJfzNKB77EwXTdXpxs3jiJNc9tahHaofacTfi5a1ozjx/qInvwHIS5gg8ciZyIcuh6ilW3FO
 22rTmhhqD045oe57Hcoh8uXRQyVwWaoyra7xEN5MVz/MQJQ+hzufgvjPfBL7FOXZJSJ7QNIuGiI
 kWbdJ0NDrKT7WmxwAsvQtntHQPxS8atWjr2CWP
X-Received: by 2002:a05:600c:1c1f:b0:4bb:6847:7943 with SMTP id
 5b1f17b1804b1-4bb88814510mr350945665e9.26.1795515970483; 
 Tue, 24 Nov 2026 02:26:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2052c8sm27272569f8f.41.2026.11.24.02.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 02:26:10 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 10:26:09 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4
X-Gerrit-Change-Number: 2335
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2335?usp=email>
X-Gerrit-Commit: 7d9c20fb97390ea1397d58c125d176388dbf9035
References: <gerrit.1795515967000.I7b13d8b5e0babb697191e21adf2998a090c310f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1OTY3MDAwLkk3YjEzZDhiNWUwYmFiYjY5NzE5MWUyMWFkZjI5OThhMDkwYzMxMGY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <310fdce49d4398db16c825b47f20951b865bba48-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVnj7-000000007fU-19ZP
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_win: use CM_*
 case labels when switching on context mode
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
Content-Type: multipart/mixed; boundary="===============1894157826061248588=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1894157826061248588==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="p5ajLiIo0hw="; charset=UTF-8

--p5ajLiIo0hw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2335?usp=3Demail

to review the following change=2E
=


Change subject: dco_win: use CM_* case labels when switching on context m=
ode
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_win=
: use CM_* case labels when switching on context mode

ovpn_dco_init() swit=
ched on c->mode, a CM_* value, but used MODE_*
case labels, which are optio=
ns modes=2E This only worked because
CM_P2P/CM_TOP and MODE_POINT_TO_POINT/=
MODE_SERVER share values=2E

Change-Id: I7b13d8b5e0babb697191e21adf2998a090=
c310f4
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/ope=
nvpn/dco_win=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)



  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/35/2335/1

diff=
 --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index a854045=2E=
=2E6074552 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=
=2Ec
@@ -197,12 +197,12 @@
 
     switch (c->mode)
     {
-        case MOD=
E_POINT_TO_POINT:
+        case CM_P2P:
             dco->ifmode =3D DCO_MO=
DE_P2P;
             dco_p2p_start_vpn(dco->tt);
             break;
 
-   =
     case MODE_SERVER:
+        case CM_TOP:
             ovpn_dco_init_mp(=
dco, c->options=2Edev_node);
             break;
 

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4=

Gerrit-Change-Number: 2335
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--p5ajLiIo0hw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">dco_win: use CM_* case labels when switching on context=
 mode<br><br>ovpn_dco_init() switched on c-&gt;mode, a CM_* value, but used=
 MODE_*<br>case labels, which are options modes=2E This only worked because=
<br>CM_P2P/CM_TOP and MODE_POINT_TO_POINT/MODE_SERVER share values=2E<br><b=
r>Change-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4<br>Signed-off-by: Ra=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/dco_win=
=2Ec<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/35=
/2335/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=
=2Ec</span><br><span>index a854045=2E=2E6074552 100644</span><br><span>--- =
a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</sp=
an><br><span>@@ -197,12 +197,12 @@</span><br><span> </span><br><span>     s=
witch (c-&gt;mode)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        case MODE_POINT_TO_POINT:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case CM_P2P:</span><br><span>    =
         dco-&gt;ifmode =3D DCO_MODE_P2P;</span><br><span>             dco_=
p2p_start_vpn(dco-&gt;tt);</span><br><span>             break;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case MOD=
E_SERVER:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ca=
se CM_TOP:</span><br><span>             ovpn_dco_init_mp(dco, c-&gt;options=
=2Edev_node);</span><br><span>             break;</span><br></pre><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=3De=
mail">change 2335</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2335?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2335 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--p5ajLiIo0hw=--


--===============1894157826061248588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1894157826061248588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1894157826061248588==--

