Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A586606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W9nqeAE/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Rru/caot;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WtFIyNNi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=alnAVjSc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=GyxJqQ76z8sDNXYdGjKwFSPKDMuZ97zaKiobtXjnsCs=; b=W9nqeAE/FFJpg+ZvyYjAbSgA4i
	n8T4FsSz8ad2ARnq/TBp9OBWpiEe1go78wEk6YBzqkyJi11X8chkelAX0lDdm28U+7efQG0nL+fBr
	NaxNvzUvzr4H+wXkcxTlLxDR8CRDBReALUV88rtIBZQ3fpLBY+4gbV5cbXazOU5FXBA8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO9Yi-0000000058I-3daI;
	Tue, 03 Nov 2026 08:07:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO9Yh-00000000582-2j8S
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:07:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y5GL97YN0eyzZ2vhEi4Y6kbT/9cqQNZ+LqtKdpNQNSU=; b=Rru/caotYISgi6XZP8mXv97w5x
 x3KeTj6G6wm64CB2MDXNVUyDnBv7Va0BFa1e6HYuSG29l+ke3z5XYe2hPb6/kBFr7qc+TuwUMcVXk
 iem6n4Rb26zpXdx6oNnGLLetnkHWMljBe1MkWWyjIRZoz/AlQXtjJHjsG3lnBbfElRLY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y5GL97YN0eyzZ2vhEi4Y6kbT/9cqQNZ+LqtKdpNQNSU=; b=WtFIyNNi6HDIBufQjy265eX68u
 8KPVM6B8JvqN47eErRaxnW2yhYDW3kMtHOmVLV/fokgS8HX71zVn+NS0SRZUTHjF++1Lx74P9L68g
 q9cPrwRuQMUAR+YS4hefhdpN5357d0wDhbt5tF7ughBEjGMsTqdV2qKdvU/FLM8a2pBM=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO9Yg-000000003GJ-1XOi for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:07:55 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1762104f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 00:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793693268; x=1794298068; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y5GL97YN0eyzZ2vhEi4Y6kbT/9cqQNZ+LqtKdpNQNSU=;
 b=alnAVjScNmxRIgvH+d8Xnmx+3Xj0Ks45bn7Yu5RFpHD787k54wOtYjT08UVX66E7tT
 JiUMzmtfQr06p8fe2UF8mf0YdU/a7WwCVJYcLcB6AV1Pi4iMqPZsU1Di4g+fUKWaheob
 HBqZbZOg8wmkcweKoDMABklvZsld4nqP3OGw7ANFTT17DHgabugHcDDvRTzFRnkrAjYv
 CZee8j+W5j5F/g+eOci8jaT3+kDziP0oNLfLjZXxtBjhd6Su85ecWFNbmWPVyIXlkpbY
 xTRsTqy0dRxeppUj7XCti2YvdVLvrQeKjpzGInvNda9HVUxoD07THNbDClLXH9RzQpXU
 xhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793693268; x=1794298068;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y5GL97YN0eyzZ2vhEi4Y6kbT/9cqQNZ+LqtKdpNQNSU=;
 b=f7Wq0ldDe5ctuNDXn73uO0ZEXZJt3rm44vDpg1M5OVO9wXRI0fs+c2Uj7Z7C15HWdS
 c6yjdJ8wMHZbYt27XhfkTfrApVGaAKrPZT6xig/wiMvQj5OX/HzNj2sjPai881yUM4/Q
 WNANyd8m7pNZAPiO+ATYOa58W/g5mbmflpv4B6J7K9MHf84Vho0KhYKI2a6sAM+nk2OJ
 FQ2ZIVLRCIvzc4yBx3llBj1tqUaVsouN9e72Z4Crk3gzEYnM9rZrTPsKrYrloFVIzNh/
 TaIULcxbRmakly4uRV8rQ9q5akFZ4Vuzb1aMu8kvubNwZOW5Yf37UfET+Gk8MUMz0yOJ
 BmWw==
X-Gm-Message-State: APuU4Z/5BYeAH4Jf/ha2+W7ApHQIjCVYikRpMHM7sRX8N5COQCCiERDu
 q4yIWtToD9iqc5AMOwBa3t4GxMlC2qnQyRoYL3sMr3c1LL0uFI4cIojoe76qaaxfpPrAJZBDJtX
 1t5HlgGoRlfJ/2Dtjrt0E6B8tY7w7i9ByglIYtHMGnaw6aQvlV4IN1KlGBryRsJTtsGah
X-Gm-Gg: AYBFou33k18nZwgLCw9PykNpJKIICE/ruhUhPKsD7baLzypGVrI/9bc1s8ZUIbMFqrZ
 gEi2/kfApLXD0N0RkCzov1Gk9XhTqkmnJt9DuALf2kGUob3Qd4NBe5KVuMbkTFrW3c9O5WxAFoh
 a42iFDWUQ6kEzPIVyUaT5YnJkOpzfT3ZfKbQMYIWcNEshDGN/wnjde4Njqd3NlWltvAE7xRDjA+
 uX/DhRh9HnMyoL92PSWfxG8jVPqDdA/4zsbfkqmiS0tWXEujHzBpcKx3/uFaW/Y8hcyK182Ured
 ul5HXvp+4t2V/nrkI1TLDI93YS/t5dDYR8JRrhrMtTWRYwp6nx5UHdo4JfqYqcmvu23+thX1GXD
 faLnNqO3GY+sKNELuw7SdB3ryNOITJRt1FDdIJRQ1mE2c6QiMDgZbxJ71KAtQvP4yFDGWYOUccu
 g8ve+ynjxfJyVf8wjoyYGVgoAyLLtqaD/PdC4EeUdUMK8QGZqj3q355YPRDeIuyn/ZoDAWMX5lG
 cxaCmQQKZmGAZpNPduEEXb3L6hriVd6xOeAseboMUzMR3FCV3xTBycNH8qZ/8A2lovuqgQ3l3Ee
 LDM6yLdMlVHYqPoL0KqEHawuVoAzeW11bbP6nMaEZabwXhcl5eEeDwOfxXwx6jZfSARhZT/AttK
 i7Sw2+lLrME9nSu79/K7vgjTp1l5Du5Xrcs32rx/PwniPt+zwlbuZU0yAzR6a2a/fKQ+4afTlHK
 MVQkFjVyV7LtSyyQ==
X-Received: by 2002:a05:6000:402c:b0:48d:f39b:83de with SMTP id
 ffacd0b85a97d-48e6e2bdf87mr31296848f8f.3.1793693267617; 
 Tue, 03 Nov 2026 00:07:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b789ecsm22735157f8f.29.2026.11.03.00.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 00:07:47 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 08:07:46 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b
X-Gerrit-Change-Number: 2102
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2102?usp=email>
X-Gerrit-Commit: e1713e6b61e7d7798e4ee41eace30b8946640317
References: <gerrit.1793693265000.I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjkzMjY1MDAwLkk1OTUzZGQ0ZTU4Y2JjZjhiMmM5YjM4YWRjYmU3NDcyMjNiYzRlYjZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f5c6b9874a644c22bd5337f9d66ac757d29880ea-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO9Yg-000000003GJ-1XOi
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: fix AIX IPv6
 route delete error message
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
Content-Type: multipart/mixed; boundary="===============6711300920820075404=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6711300920820075404==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EB0mOab0exg="; charset=UTF-8

--EB0mOab0exg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2102?usp=3Demail

to review the following change=2E
=


Change subject: route: fix AIX IPv6 route delete error message
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: fix AIX IPv6 ro=
ute delete error message

delete_route_ipv6() reported a failed delete as "=
route add command
failed"=2E

Broken since b4b92ae5 ("implement adding/dele=
ting routes on AIX, for
IPv4 and IPv6")=2E

Change-Id: I5953dd4e58cbcf8b2c9=
b38adcbe747223bc4eb6b
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg=
>
---
M src/openvpn/route=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)=




  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02/2=
102/1

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index e8d=
e2d5=2E=2E152d0d2 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/rout=
e=2Ec
@@ -2309,7 +2309,7 @@
 
     argv_printf(&argv, "%s delete -inet6 %s/=
%d %s", ROUTE_PATH, network, r6->netbits, gateway);
     argv_msg(D_ROUTE, =
&argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: AIX route add comma=
nd failed");
+    openvpn_execve_check(&argv, es, 0, "ERROR: AIX route dele=
te command failed");
 
 #elif defined(TARGET_ANDROID)
     msg(D_ROUTE_DEBU=
G, "Deleting routes on Android is not possible/not "

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2102?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb=
6b
Gerrit-Change-Number: 2102
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--EB0mOab0exg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2102?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">route: fix AIX IPv6 route delete error message<br><br>d=
elete_route_ipv6() reported a failed delete as &quot;route add command<br>f=
ailed&quot;=2E<br><br>Broken since b4b92ae5 (&quot;implement adding/deletin=
g routes on AIX, for<br>IPv4 and IPv6&quot;)=2E<br><br>Change-Id: I5953dd4e=
58cbcf8b2c9b38adcbe747223bc4eb6b<br>Signed-off-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file changed, =
1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02/2102/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index e8de=
2d5=2E=2E152d0d2 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><=
br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -2309,7 +2309,7 @@<=
/span><br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s dele=
te -inet6 %s/%d %s&quot;, ROUTE_PATH, network, r6-&gt;netbits, gateway);</s=
pan><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, es, 0, &quot=
;ERROR: AIX route add command failed&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    openvpn_execve_check(&amp;argv, es, 0, &quot;E=
RROR: AIX route delete command failed&quot;);</span><br><span> </span><br><=
span> #elif defined(TARGET_ANDROID)</span><br><span>     msg(D_ROUTE_DEBUG,=
 &quot;Deleting routes on Android is not possible/not &quot;</span><br></pr=
e><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
102?usp=3Demail">change 2102</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2102?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newch=
ange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I5953dd4e58cbcf8b2c9b38adcbe747223bc4eb6b </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 2102 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>

</body></html>
--EB0mOab0exg=--


--===============6711300920820075404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6711300920820075404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6711300920820075404==--

