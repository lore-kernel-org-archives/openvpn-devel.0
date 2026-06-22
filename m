Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0966CCDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b7mNC9bTvJt9TphFZUpQks2Jzv/uSAtDvDKsXSzHhgs=; b=GtawJ2VpH8HKIKBbDPMkKwWWea
	ZRVJw1htHCyVCd5Px08hW2vlivAf2plupxc2R+AA0UNL0EM49hfF2v+vM6H+SX/YgfcQbxLJmfjCd
	CdH5bbjo+jFML5KTz9JMX6BKpTMgrdAnaLjI+cSG2DII+kviQ4caP6b/+CGRvGF0YFq0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbfKB-0004ay-KP;
	Mon, 22 Jun 2026 14:08:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbfKA-0004aj-7d
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:08:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2K2us+pDrbOQVrvZnVUw5nrH4g/jW4Br4zU/0I5gVyc=; b=g4EIEBiiyHQNFk/BNKxwbKfa9h
 rgGz8VEGcd3Z519SBdRhwJt38CoVuK9Eg1J4oEAXr+f2grevLaJaZL9vIEvHTuU9+8uS+m0A9L9OM
 09ATMA/gZVZzUC+KtyhXM6kQaJM0hSWjmRV2sA/sk3bNhaZRutxZonc4jXYHcBTwFXWo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2K2us+pDrbOQVrvZnVUw5nrH4g/jW4Br4zU/0I5gVyc=; b=a
 PrxqTU70lOflcb+O86pIBYOyQy5p6Nyq5l48abl3h8Z95f8JYzdoSZiWLazpsnD3EcBuHzFt2cYUP
 ZL0q0ztY24T1MTC9mjgHqum4kEcjlOEJGZTHPrNRiD7UIGg5BDxKRUIw9CSCciUlSWhHzbKtM/Oxe
 CIGx0Jab7oqD+gnw=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbfK8-00034q-VB for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:08:30 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-491609cdd8fso27336335e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782137303; x=1782742103; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2K2us+pDrbOQVrvZnVUw5nrH4g/jW4Br4zU/0I5gVyc=;
 b=ZUUVy1bJmWz+sb7soF9J9vP3BfjVJf4Q2vUHW8ng9XQ1+BIrEezR9dV6QOaQ5zXOTc
 MzmwekUi0On6QAnr6xJO8ABtbXz9Nsd2PaL05Xzb7BiLvi0/pf6D95Ml0APyXz5+Eope
 RxGtq8Q41hDXob6oz9IC4uuMPoNY/Sex6oHo5CcHyo82ROLtuKk8MtYNoioi8SOZqpBP
 DjaUV2TT1AYytGtXMwhb2siZvWpMtysmvHi6gWppZjaYinM8cKK/+xJKuypqdzDB2jRO
 PRy6BM/N7Ob8HtbVNik3uHoHsdnNTvQjV14GsUxDWIgbApzXPZm2YWpAG+iK4wsHURfe
 zteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782137303; x=1782742103;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2K2us+pDrbOQVrvZnVUw5nrH4g/jW4Br4zU/0I5gVyc=;
 b=n6kMCY7frE1gjmjKNFUlZtwebJbL4693fIb+pXoUbRkNjPPKzSVZqdTXjRg0nv2R8e
 39/hiw58cDNoqVuuFGMk7r3UP2mC1YKppoJMnXmxKojY4imm0vnx/KcR5u6xyIHqy8G3
 oPMa5Ex7T9jKqIi6YX2gr/6iMWnJL44Co7XFYXjp8fYmEK3P1ko10Gj0X9xcG5Unyp07
 l3mLdvYDpF3uBrG92DfcgUZo8IZcGrA6SXmyzGc00MvMcTIneWMhEMuNMuYbJ3oMiQ+H
 n7XW8ZzwUjUvdngq9uTpnF0wUuhkwxudb3vrJMiLyFDsXps1P2s1RCiWUU5tD08OQl82
 ILqQ==
X-Gm-Message-State: AOJu0YyZkSOht0hNm+pxHGwIoPPcQSrs33RcKyAqr8BfcjNxRp/tc7ax
 euWThX08lQkmHTSdY9Pg/Kw+gwa7P+hrryPszoG96xwCEhOQZOrE8GSQeP5E3MKYm8WfL38wHUa
 C3IZi1f343fRiBOTqM3a7VoDjIkkLOKMH/EWxn37f6cu98dNKGCdrn0RjlXEDMQSSkfZJcXXesu
 P+9WsJEQ==
X-Gm-Gg: AfdE7cl12fO3wfmR/aJUprbWQQnSlFCAN29T5cfTQOMNDO1kmKrjtEQHsA0dOfqIBOC
 4SRUPiiGAniyr+Otkiy1WkNi2aNu00IApIBEStZpyPmuzDD29ufVRUCW2Er60HePRHCALQcPBsw
 RKYRiKH32z/deyD9J059BQCvzaH7TGqIX0McCk2ToSRxvMGYLI7Th5xJ0q/2d513LezmRmw0Vv8
 7OCoGDWCRSGHF8jc31Yqsec+x9xU32vYncbIeg9faIYKLzqErDjUUquT4v/R7VWmVYp/Q8nUEp9
 lhfm8vN0E/AsXOLy6xoO/a8JVQ/cOjM53/Bm04ZyZl0VjpQ7pTx91WB0xBHLBOBUifimwCRQ5yJ
 meY+xtkosHbtYsEFINqoA8An1QsD4yibmyWSBC+TA3Gn8Eo4msbQv/ZQpWZNE6y7cGwc2GZH8dg
 B310bx79RK0K4xaJzodlylMasd1AfnW1MOuuMZeZ24ZqtB2ZVKVCtcrdOr66Xb2HdB9rljAjjPx
 38zzffIf8f0psCPbGtCSBB+4Cdc6+kQGo2F927KDBlzPPd4P14zrOTr1/J71FjSvJfVcgPNxn+N
 5lM=
X-Received: by 2002:a05:600c:4057:b0:490:9588:bdae with SMTP id
 5b1f17b1804b1-49240e5b677mr186072205e9.18.1782137301750; 
 Mon, 22 Jun 2026 07:08:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240084928sm311123085e9.15.2026.06.22.07.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 07:08:21 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 14:08:18 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
X-Gerrit-Change-Number: 1604
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1604?usp=email>
X-Gerrit-Commit: 70c1193f3ee2877cf39ecc947b7c2101a3a3cb41
In-Reply-To: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
References: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MTMwMjM1MDAwLkkzNTU3NjBlNDNjM2UyZGEwZGRhMGNkZWM2ZTQyNTNjMDI4Y2VmZTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0e28e76e27735afe9e1208c9289911bd8bc1f40a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbfK8-00034q-VB
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4485613515542159958=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4485613515542159958==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FKCCjhF4+OA="; charset=UTF-8

--FKCCjhF4+OA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=3Demail

to look at the new pa=
tch set (#3)=2E

The following approvals got outdated and were removed:
Cod=
e-Review-1 by flichtenheld


Change subject: Fix building wolfSSL with CMak=
e
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix buildi=
ng wolfSSL with CMake

Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38=

Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M =
config=2Eh=2Ecmake=2Ein
2 files changed, 3 insertions(+), 0 deletions(-)


=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/04/1604/=
3

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 715d02c=2E=2E4779=
d69 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -327,6 +327,7 @=
@
     elseif (${WOLFSSL})
         pkg_search_module(wolfssl wolfssl REQUI=
RED)
         target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARI=
ES})
+        target_include_directories(${target} PRIVATE ${wolfssl_INCLUD=
E_DIRS})
         target_include_directories(${target} PRIVATE ${wolfssl_IN=
CLUDE_DIRS}/wolfssl)
     else ()
         find_package(OpenSSL REQUIRED)
@=
@ -367,6 +368,7 @@
 elseif (${WOLFSSL})
     set(ENABLE_CRYPTO_OPENSSL YES)=

     set(ENABLE_CRYPTO_WOLFSSL YES)
+    set(EXTERNAL_OPTS_OPENVPN YES)
 e=
lse ()
     set(ENABLE_CRYPTO_OPENSSL YES)
 endif ()
diff --git a/config=2E=
h=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index ae1d264=2E=2E34f289d 100644
=
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -13,6 +13,7 =
@@
 
 /* Use wolfSSL crypto library */
 #cmakedefine ENABLE_CRYPTO_WOLFSSL
=
+#cmakedefine EXTERNAL_OPTS_OPENVPN
 
 /* Enable shared data channel offloa=
d */
 #cmakedefine ENABLE_DCO

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1604?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
Gerrit-Change-Numb=
er: 1604
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank=
@lichtenheld=2Ecom>

--FKCCjhF4+OA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review-1 by flich=
tenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">Fix building wolfSSL with CMake<br><br>Change-Id: =
I355760e43c3e2da0dda0cdec6e4253c028cefe38<br>Signed-off-by: Arne Schwabe &l=
t;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M config=2Eh=2Ecma=
ke=2Ein<br>2 files changed, 3 insertions(+), 0 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/04/1604/3</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span>=
<br><span>index 715d02c=2E=2E4779d69 100644</span><br><span>--- a/CMakeList=
s=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -327,6 +3=
27,7 @@</span><br><span>     elseif (${WOLFSSL})</span><br><span>         p=
kg_search_module(wolfssl wolfssl REQUIRED)</span><br><span>         target_=
link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        target_include_directories($=
{target} PRIVATE ${wolfssl_INCLUDE_DIRS})</span><br><span>         target_i=
nclude_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIRS}/wolfssl)</span=
><br><span>     else ()</span><br><span>         find_package(OpenSSL REQUI=
RED)</span><br><span>@@ -367,6 +368,7 @@</span><br><span> elseif (${WOLFSSL=
})</span><br><span>     set(ENABLE_CRYPTO_OPENSSL YES)</span><br><span>    =
 set(ENABLE_CRYPTO_WOLFSSL YES)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    set(EXTERNAL_OPTS_OPENVPN YES)</span><br><span> else ()</sp=
an><br><span>     set(ENABLE_CRYPTO_OPENSSL YES)</span><br><span> endif ()<=
/span><br><span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=
=2Ein</span><br><span>index ae1d264=2E=2E34f289d 100644</span><br><span>---=
 a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</s=
pan><br><span>@@ -13,6 +13,7 @@</span><br><span> </span><br><span> /* Use w=
olfSSL crypto library */</span><br><span> #cmakedefine ENABLE_CRYPTO_WOLFSS=
L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine EXTER=
NAL_OPTS_OPENVPN</span><br><span> </span><br><span> /* Enable shared data c=
hannel offload */</span><br><span> #cmakedefine ENABLE_DCO</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1604?usp=3Demail">change 1604</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1604?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c02=
8cefe38 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1604 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>

</body></html>
--FKCCjhF4+OA=--


--===============4485613515542159958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4485613515542159958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4485613515542159958==--

