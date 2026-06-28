Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4BDC43458
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=caayM97G7KipApfzCfrxaLeE63C+mX7qRz+/Oq9SahE=; b=WfyyCmMiwNqurexCkFWlxtlhI3
	PEMEjQIIjh6ekzJkOX3yQswk6PpPpYrv0hCbSAAB9E7AAwZPhNkLyyjAadzU/BDF1E78o8GchEXaB
	9tucSy2jrl2SYlQSAKv5fFp5gzkijMYDycyccApu7rM/uXjOETAjN6qPeJOedTHhR3Wk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdwCF-0008Gj-Sv;
	Sun, 28 Jun 2026 20:33:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdwCE-0008GW-Ue
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 20:33:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CQzjl/2wQIvdMJWU2D4s97pwwyWHC3lYoj6+D74cKrQ=; b=dr+ChhHms8abV06/Jx3Y1hxcdl
 CvKrqSIuJQmENFMK2E5t+dNFsYwYD4wvBrZNkcvzTUKO5ApBFw25eAEzGNjyDxsrgppd9LuUeqmpw
 mSWAh1oFBGcF5zPHuyqXhP3AU9xmEzUjeir3LBfjDLHev+4sekKW4peyAT1FYlrot9QI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CQzjl/2wQIvdMJWU2D4s97pwwyWHC3lYoj6+D74cKrQ=; b=U
 fhKfKAbSQHtnu6n0sXv5MCx6f9JqN4Q6Db9XyCCgVtU8cpWysoGt7Aq9DZ50bQ+JoLe/2eks+Ly7C
 y0E99c+2UXEId7/Pa2a1Ow7ddI6NkANhoIz56+bb8EKtsvXVdUqZvLgBUv8gKioikO8nHStxvwcEt
 ckpFLJVptkn32fRM=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdwCE-0003Q3-CG for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 20:33:43 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so7700825e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 28 Jun 2026 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782678816; x=1783283616; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CQzjl/2wQIvdMJWU2D4s97pwwyWHC3lYoj6+D74cKrQ=;
 b=ErIrmywoXLEuSdijmEYOLVR8baF10ZmO/rpnli15mTVRw8nUSoJCSQpHv79Gf1iA1E
 hcLnBq5eSGcTjrO6YdxDVjABEXrZkhlJmECv+ls04/hCV0ohuWtWjXd4BvqMoaztDP/H
 X2huFFh+KB18yzDRnOSeaYhpCihw/0Zxtgy8gbNNHLSrU24zkhMFZQOZP43F0eQnQGLI
 N41WyXN2LRFRvi5HEPJhw3xh9Fk4WXJ4YVo0qXxbR8dWhASO97EaUwB7zpk6t+5AZT2W
 HdxMWPunY+biFVMydfegVhrN+M54rzj0CYulI7Ic1upDON3E4lwZA138Wa4PwQ1wflQI
 UxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782678816; x=1783283616;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CQzjl/2wQIvdMJWU2D4s97pwwyWHC3lYoj6+D74cKrQ=;
 b=TL2cn7p+nevPi+d8nJpZv6u7IVPZAOMB7cEFBunGdReBnZmqdZpUnGkqzsMIjl3yL0
 KJK8JRrILzohYHFXkkT7xRWvMiBURWkATfJT0gYe1L9UfocanfiKpS/30Qj3jnkXhYnu
 3NSvYKoTvmRpK9mMJska01fwi9KOxdjZUnpV31/6/Hg17HxXQxDDLvOgN5hKWN/rXOgy
 D7MRvjemZx2Ghu/5n3iAbPinI4vSleP+F7b78l3HObLLLYZBvAMoZiKr/x6ZqvN/FYWc
 +Trcj7GVD6Aycpt+6Kiaxv/NN43NDCYyECAULQwk24d/g5GWzdTpYnJt6Yjl6EFoK9wM
 5E7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ReyBaZxFgKtILQ4T+eJ2XeYx/ZQQjBR6nT/3AWkfT/XZ8LCLLCX584io1LVY6g4LzLUh1WQHP2YgDXXIg@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxXC61tdiCalxjc2HiHcRZZ2J4szh9Dhtzgfi1nJOt+tTwXmlq9
 nV2RO3cmj5Fvx9Z258AGLyWLV05/8fdtpauXWXWcNAJQHwrN7hQJhYWDXzfrwWo2XV9BvdiiiOq
 zWNYDaROjgJd5QhP+8NDnYBPaPrL2jfkCieq7S/emqkEBYKdn0C32hb+udKTC31TUWCil
X-Gm-Gg: AfdE7cnXpjmhggdFch2N08x5Gfvm9o+Zw8jCUiKGxRHpB5p39dbwJFyBQBIah3disX1
 8SMG8cGVOUGz3FKsGpjtrLH0AhxMlTgqvCQMuu6f+59dH6hg6DgByMBiU+oQTeOJnK0t1YGY1+B
 sGpIy7WeOqNcHeQ0yfKZkI9Gq12EtL8Q/g4KaqNUKVYf1klJ2a8f1OS/gjtR+Rz1zjOEVYRQcD9
 jEeQlOOpDc1mdNKCYbqTPV4xOoPYP/j/Q1VYtvjBUM2ILnO0rC/h2dXI10r35IpLCcm9zTUBArq
 Eaaz/B3LVloFmb58C9u4CRXeq++FZi1nzbL4U6QAOx6lgxu3Y7T3nxr7b0JZ5X8WOrRwJRLhhJE
 ZIVZvhGr+dGGhjNsP76i2x8rUc6UNzvySpNmh4iKV5A9cp7exdt1zacgGnvNyCne1y1WaNjmhCU
 XOT6mpp3VZ8Wa0sbmpy56EGBLUjkhHAcrNLogCzrY6E6dz5Oxhix0OkbjeNZ9TPN1TfuiDf/qrb
 1827l+FOY9AtzoPDzqUVilAfJTG/tRB4vXziWlsypqEPrZZPAbK+tgyQ9nN4izqhGdQOV8Ba459
 HR0=
X-Received: by 2002:a05:600c:8b84:b0:493:a761:227c with SMTP id
 5b1f17b1804b1-493a76127d0mr41042075e9.17.1782678816265; 
 Sun, 28 Jun 2026 13:33:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fc0f32sm261466385e9.3.2026.06.28.13.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 13:33:35 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 28 Jun 2026 20:33:35 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
X-Gerrit-Change-Number: 1604
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1604?usp=email>
X-Gerrit-Commit: 9e2f3843df1cdacffb20f7ca4e6aba6a784acb05
In-Reply-To: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
References: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MTMwMjM1MDAwLkkzNTU3NjBlNDNjM2UyZGEwZGRhMGNkZWM2ZTQyNTNjMDI4Y2VmZTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fc1458e998b0d81a618f8fabcc6e441cfd4e3d4e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdwCE-0003Q3-CG
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix building
 wolfSSL with CMake
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1944532882110578976=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1944532882110578976==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Mes6hvbCAPs="; charset=UTF-8

--Mes6hvbCAPs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1604?usp=3Demail )

Change subject: Fix building wolfSSL with CMake
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix building wol=
fSSL with CMake

Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
Signe=
d-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1604
Message-Id: <20260628150320=2E13244-1-gert@greenie=2Emuc=2Ede>
URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg37342=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =
CMakeLists=2Etxt
M config=2Eh=2Ecmake=2Ein
2 files changed, 3 insertions(+)=
, 0 deletions(-)




diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index=
 715d02c=2E=2E4779d69 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
=
@@ -327,6 +327,7 @@
     elseif (${WOLFSSL})
         pkg_search_module(wol=
fssl wolfssl REQUIRED)
         target_link_libraries(${target} PUBLIC ${wo=
lfssl_LINK_LIBRARIES})
+        target_include_directories(${target} PRIVAT=
E ${wolfssl_INCLUDE_DIRS})
         target_include_directories(${target} PR=
IVATE ${wolfssl_INCLUDE_DIRS}/wolfssl)
     else ()
         find_package(O=
penSSL REQUIRED)
@@ -367,6 +368,7 @@
 elseif (${WOLFSSL})
     set(ENABLE_C=
RYPTO_OPENSSL YES)
     set(ENABLE_CRYPTO_WOLFSSL YES)
+    set(EXTERNAL_OP=
TS_OPENVPN YES)
 else ()
     set(ENABLE_CRYPTO_OPENSSL YES)
 endif ()
diff=
 --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index ae1d264=2E=
=2E34f289d 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2E=
in
@@ -13,6 +13,7 @@
 
 /* Use wolfSSL crypto library */
 #cmakedefine ENAB=
LE_CRYPTO_WOLFSSL
+#cmakedefine EXTERNAL_OPTS_OPENVPN
 
 /* Enable shared d=
ata channel offload */
 #cmakedefine ENABLE_DCO

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
Gerrit-=
Change-Number: 1604
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Mes6hvbCAPs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1604?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Fix building wolfSSL with CMake<br><br>Cha=
nge-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38<br>Signed-off-by: Arne Sc=
hwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1604<br>Message-Id: &lt;20260628150320=2E13244-1-gert@greenie=2Emuc=2Ed=
e&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg37342=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M config=2Eh=2Ecmake=2Ein<b=
r>2 files changed, 3 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 715d02c=2E=
=2E4779d69 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>++=
+ b/CMakeLists=2Etxt</span><br><span>@@ -327,6 +327,7 @@</span><br><span>  =
   elseif (${WOLFSSL})</span><br><span>         pkg_search_module(wolfssl w=
olfssl REQUIRED)</span><br><span>         target_link_libraries(${target} P=
UBLIC ${wolfssl_LINK_LIBRARIES})</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        target_include_directories(${target} PRIVATE ${wolfssl=
_INCLUDE_DIRS})</span><br><span>         target_include_directories(${targe=
t} PRIVATE ${wolfssl_INCLUDE_DIRS}/wolfssl)</span><br><span>     else ()</s=
pan><br><span>         find_package(OpenSSL REQUIRED)</span><br><span>@@ -3=
67,6 +368,7 @@</span><br><span> elseif (${WOLFSSL})</span><br><span>     se=
t(ENABLE_CRYPTO_OPENSSL YES)</span><br><span>     set(ENABLE_CRYPTO_WOLFSSL=
 YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(EXTERN=
AL_OPTS_OPENVPN YES)</span><br><span> else ()</span><br><span>     set(ENAB=
LE_CRYPTO_OPENSSL YES)</span><br><span> endif ()</span><br><span>diff --git=
 a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index =
ae1d264=2E=2E34f289d 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</=
span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -13,6 +13,7=
 @@</span><br><span> </span><br><span> /* Use wolfSSL crypto library */</sp=
an><br><span> #cmakedefine ENABLE_CRYPTO_WOLFSSL</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#cmakedefine EXTERNAL_OPTS_OPENVPN</span><br><=
span> </span><br><span> /* Enable shared data channel offload */</span><br>=
<span> #cmakedefine ENABLE_DCO</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=3Demai=
l">change 1604</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/16=
04?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1604 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>

</body></html>
--Mes6hvbCAPs=--


--===============1944532882110578976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1944532882110578976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1944532882110578976==--

