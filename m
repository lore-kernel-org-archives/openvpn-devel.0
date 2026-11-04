Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99621606A329
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SAnw/co+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Fz9sgWCI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nVf88C4N;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HGJQnDOc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Mx+l4Ow/v1R+7Mw4ub1ykBBQU6ukgUe4k3mYa3fOim8=; b=SAnw/co+yMfyFYgfj6C76OHxnx
	u7v60p3nfCutGzaOqUVk+cnEQB7IC3UjihESu+bjRGOpIuRvYDTCPBffqz6N/5hqQ39qc2u6Po7Kc
	WDvLqvRXsugpDbsISFuh+un0qt3AyUdoTs+dazbrKhNevJbEj4h8i4PfaR0niX6nqDc8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOVH9-000000006xn-3XZv;
	Wed, 04 Nov 2026 07:19:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOVH8-000000006xa-2vgd
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:19:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=33sLKm7Q3NxXlC1h6/YuC5pctf71SowLHEPCaNKw/6Q=; b=Fz9sgWCIYjcb/7+cYSyNNNVnxt
 axO95w/GO7nJs6lFxyrR/WW9xzY+YaMMegNLE17lqg83R11Vrniv3Yu+wj3D5jGd8eJC8jEWg9/F0
 GvTF0DO/9ko8SWt0/nUHg7uDyLtq9uUiRjeGxbbO0QF2XtJYDXHk+FzQMyAOqn3bQPxE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=33sLKm7Q3NxXlC1h6/YuC5pctf71SowLHEPCaNKw/6Q=; b=nVf88C4NFGiRdDQRLQ+59RzN6z
 /YsRQotELX96fOd79C/xTZELpjO/XI5Jak2w6neYeBog1OAt+aL1tvbJ5McsuHWWnw/mo1rbzfVuD
 13N5KoBZ1FUpoykVvKnkM+PieZx/gGfDrkVBSVhR+GzZ2s+BrhQo7G3H49npjqF0t6Ow=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOVH8-000000005sR-0EnX for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:19:14 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so3274995e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 23:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793776747; x=1794381547; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=33sLKm7Q3NxXlC1h6/YuC5pctf71SowLHEPCaNKw/6Q=;
 b=HGJQnDOc3QaGO2+iUdAqq7l3zJMPfvpAsP/kXjocGsG1sizTQzb9zWgpG2oXyFLat3
 UQUtu500Fhdeh6zlpdO82MlYI+/isfM7ZgYlCS/4oPhktcoZ1XWSwb5HFGY8OS9JpQHE
 udp6vglA0NDopFepWZZBJzzBrvaqw62LIZwmCB5jkqWvTbxrzkzBz+zZJyfklnXfDhw/
 /jwVbe8KcOGj2FB73IP3J4Kx+M/pFPlN/+xxRrJZQZhBg7qUqeiQQZce7sTsHgXeG8/+
 lsrrMG7cPBZL7sgR2f9xKNqejQFuOJpEsKtDcR6EUnYiYtCr2LQapXRJpeBg/ON9Jc8g
 nZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776747; x=1794381547;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=33sLKm7Q3NxXlC1h6/YuC5pctf71SowLHEPCaNKw/6Q=;
 b=NqHfT8VEXiYC/Gh7Q96UhP+YBK04pmbMnALunRXXDdjVgPWkdCebj1WItjCSjPLgwM
 mILyb1+gdlvQsNEVg1RrGn/Zi1kQCYCgldUGQTcQc9e2bhww2bm0QMs98PpfIjtqreHY
 o5R9e58I4DNuHHf/U/KdDJDfn8tveXofRtSxZHQULoQNIkaDhMCV8vyIrTZr99IsAXYN
 474EqX7fctGyMrWbr1iwf5FItP7a3wMEzoqIPN3T+s8F3hJ58Qr6H2KMe7PW4SCDBM6m
 LcPWwFMq34Ezq9wV2QAkXKj1pn9T1TBgmWFbpYXXEZb0v0pxZ9h/PpocLdPDK7yy5Zqn
 7qdg==
X-Gm-Message-State: APuU4Z/D5STmKebMIxJ4ToAEQ0x5DYypMXN5ckY5GWFPRgREqIJJXf4c
 mBXvxvbFtCRk+ls+iEQMeDXn+3znR8x4wT8jpLuYGyByHcmCef6NPgPcsZRw/sAejNRwGFIJXTa
 dEumsJhFoJhopPjZlCKBd87JakxKkkd+XcBFwX2jPC6XyriSrl5b5oIRlkmt0d6X4+kxYWHd+5p
 9JfSuliw==
X-Gm-Gg: AYBFou0Qkp2xvMiGpXozTwM48D/C9Jsj2q7wvY0ltrMW6YlFUswO/YlLgDE+pcBLO4c
 eqOWK7FYDKSNbmtgLVF+IKWJmmqbAd2dVymIlOSNCn/KN03/9M/kiiYKpCa0UGHRmA9Wyn6JvMk
 gpGkxpx/35dDene10V9CatSTYGlmnCIYBe625+ZDOyJ8kDwgGzddmNEhcoyTpE4kRlKxhGnjJe1
 JhuZYIDTzhfvYFpsRLcsgRnsP1xld9BJbHauZMQdgQCZ+6Zm2Tk5m0IxX6ELWFrDaNaA6B7WDXR
 OKZmMvXPHOEKZa1KF1z8XYQkwm3Z3YyrJehWlvl3LE/PECdNM3UBVHVd0vw5X5Vwqdx1Lwl713X
 eQF5FkHFQuE/9W4jXrjwgXzSxxUBKKA/qS6BEz8QZJenRvxzUbvKXYdh4qOEWxQCrqWjUoLKEGs
 PnJbP2Z5QCpM5Xk8oehcxsgJZIYO2yf1xrw9Imc4IaTDNOA6RsSsmK3nvZOqGsHPCDC8g4fROQT
 bxx29bNBdR8SmiOkZBGbh0YS3dbq/V7xib0hdrJrfQZww19ITZuj4CntxeEO+nGa3mWp9N8yLdZ
 0HgkdC5l3sKpcIuXYtEW9Ew5Nn+P3aWXroFPpNIlOg7gRxnGa712lcXGwbo9PzS3KV6B+PTyRkI
 h6IoWFiCm/geXZAYTCSPxnybziPbfZzz5ooTXTPIyLx4NhMMZpOnRhGHbSaspk1biR2kgwsWjeQ
 E9BbTnv65E4sVHJw==
X-Received: by 2002:a05:600c:c088:b0:4ac:da92:2bd4 with SMTP id
 5b1f17b1804b1-4acda922e24mr245594205e9.1.1793776747311; 
 Tue, 03 Nov 2026 23:19:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43a48adddsm32977065e9.2.2026.11.03.23.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:19:06 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 07:19:06 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ieee93e625bd25f1f674ce1c3b6475fd73770c73f
X-Gerrit-Change-Number: 2119
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2119?usp=email>
X-Gerrit-Commit: 27d14fb203bb18c597ad988d7e1abdb68d9e7fa7
References: <gerrit.1793776745000.Ieee93e625bd25f1f674ce1c3b6475fd73770c73f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NzQ1MDAwLkllZWU5M2U2MjViZDI1ZjFmNjc0Y2UxYzNiNjQ3NWZkNzM3NzBjNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f53c675f660090c3df6e753fa0c4190a9ee7f5b5-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOVH8-000000005sR-0EnX
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: lladdr: pass S_*
 flags, not M_WARN, to openvpn_execve_check()
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
Content-Type: multipart/mixed; boundary="===============6770189056376724516=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6770189056376724516==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="znUUc1HwZPI="; charset=UTF-8

--znUUc1HwZPI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2119?usp=3Demail

to review the following change=2E
=


Change subject: lladdr: pass S_* flags, not M_WARN, to openvpn_execve_che=
ck()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

lladdr:=
 pass S_* flags, not M_WARN, to openvpn_execve_check()

The flags argument =
takes S_* values=2E M_WARN shares no bits with them,
so this is no function=
al change=2E

Change-Id: Ieee93e625bd25f1f674ce1c3b6475fd73770c73f
Signed-o=
ff-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/lladdr=2Ec=

1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/19/2119/1

diff --git a/src/ope=
nvpn/lladdr=2Ec b/src/openvpn/lladdr=2Ec
index 195245f=2E=2E554975c 100644
=
--- a/src/openvpn/lladdr=2Ec
+++ b/src/openvpn/lladdr=2Ec
@@ -36,7 +36,7 @@=

     struct argv argv =3D argv_new();
     argv_printf(&argv, IFCONFIG_LLA=
DDR_FMT, IFCONFIG_PATH, ifname, lladdr);
     argv_msg(M_INFO, &argv);
-   =
 int r =3D openvpn_execve_check(&argv, es, M_WARN, "ERROR: Unable to set li=
nk layer address=2E");
+    int r =3D openvpn_execve_check(&argv, es, 0, "E=
RROR: Unable to set link layer address=2E");
     argv_free(&argv);
     re=
turn r;
 #else

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2119?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie=
ee93e625bd25f1f674ce1c3b6475fd73770c73f
Gerrit-Change-Number: 2119
Gerrit-P=
atchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>

--znUUc1HwZPI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2119?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">lladdr: pass S_* flags, not M_WARN, to openvpn_execve_c=
heck()<br><br>The flags argument takes S_* values=2E M_WARN shares no bits =
with them,<br>so this is no functional change=2E<br><br>Change-Id: Ieee93e6=
25bd25f1f674ce1c3b6475fd73770c73f<br>Signed-off-by: Razvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/lladdr=2Ec<br>1 file changed=
, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/19/2119/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/lladdr=2Ec b/src/openvpn/lladdr=2Ec</span><br><span>index=
 195245f=2E=2E554975c 100644</span><br><span>--- a/src/openvpn/lladdr=2Ec</=
span><br><span>+++ b/src/openvpn/lladdr=2Ec</span><br><span>@@ -36,7 +36,7 =
@@</span><br><span>     struct argv argv =3D argv_new();</span><br><span>  =
   argv_printf(&amp;argv, IFCONFIG_LLADDR_FMT, IFCONFIG_PATH, ifname, lladd=
r);</span><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int r =3D openvpn_execve_check(&amp;arg=
v, es, M_WARN, &quot;ERROR: Unable to set link layer address=2E&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int r =3D openvpn_e=
xecve_check(&amp;argv, es, 0, &quot;ERROR: Unable to set link layer address=
=2E&quot;);</span><br><span>     argv_free(&amp;argv);</span><br><span>    =
 return r;</span><br><span> #else</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2119?usp=3Demail">change 211=
9</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2119?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Ieee93e625bd25f1f674ce1c3b6475fd73770c73f </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2119 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--znUUc1HwZPI=--


--===============6770189056376724516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6770189056376724516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6770189056376724516==--

