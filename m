Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039E2C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=rISUlgZq7+nzq/vfJdMiZkUFi0Ib6yE5Wjp4mzp47fU=; b=Ctavgye8KTI6pK
	kGGLxfgle85AwD3YJzLksutCdIUJnnQdXm+fMy3QARuuNbTd0yo0F/Ga1fenorkgSXJok8GhQcIVP
	k4dLS32JMsfWSbVzIijDDfDk4vU25PWCX0wsrexl6v9mBQwSYz6PcsCJD6+HbzvM+RboabPEWVt3n
	Trs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6tN-0001CK-Eq;
	Mon, 29 Jun 2026 07:58:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6tM-0001CB-M3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:58:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B8ioHKzTfABvlQQhxraGse8/lmwh8F4X2hE+2jhJr6Y=; b=PvtOqnsmIjhBK6dVG8JIvOtuaY
 VlCwgxjl1nd6R9gzO9co3jgnNP3clE2Sc2IDbJtSqNMrRk4jAOURYj96Z+lnS2kdUMAg/EGDilTq9
 ZGPfYKwIpFwGotkMl/dA75v7nkcY2jHSPBBy69SBXDDvrbYalP9pqwkNcNvvDpEM+igY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=B8ioHKzTfABvlQQhxraGse8/lmwh8F4X2hE+2jhJr6Y=; b=Q
 M7LY08ZuP/UvBNprmrtgeAZ8X0deQHa4IhXiDUtpmNphGCvoXTcFsXr3WIcEegY2wowfKlxADE2RI
 /9m68BSdYV07ceRdv5W6IYVxXKQoH+7Z/UTXADKCbbKgwlf1cqb4XeXliZMuvEmpU8xEEDeW1O1EW
 vMVTWT6CrjRtoxhI=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6tK-0008Mf-M9 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:58:56 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-46066e640easo1558768f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719923; x=1783324723; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8ioHKzTfABvlQQhxraGse8/lmwh8F4X2hE+2jhJr6Y=;
 b=XA5s3nVmeKxxgk21inw/RE+1D9c9ZiM8jpm77OXhnDpGU4NWbXhGyJRLjyPkJOafzy
 CV1qCNLAvf1Y3SWtW+3Ky4sxoCpPs9Y8PHZMFhyJdIDPqjP46hZXpzm4sKEDzqMtsgmC
 Sjw6/jf5j8N4zjAA/sfKQRqWdsYJeydInz7fnNRuAC/mDwSvHFq7WpoLDCKPfbaL0wTj
 4l26mszMbP6SgPe3ZZn+MGoiPSrjG8ix9iAMnxyLMOTMlf0J/VaDdCuTx2o//M0ba+4s
 kC3ze5KxFlknpeE8pI2d86Dta/xnlzaNnL3lsqnOUIkBLQ9ptIDcBTpB/Qgwwo926cRn
 w1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719923; x=1783324723;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8ioHKzTfABvlQQhxraGse8/lmwh8F4X2hE+2jhJr6Y=;
 b=swenef78JFhy/Lc4cF+9p/C28Fc3zm1M9zLaJV3p392K6E4Cx+GrqUH0FXZWolohI7
 aZS1qT6tuIhmUmgWd3AF/LvO1PA/jm9EztyCAyiygVCdOKR/7Lr7RVb6d6WPCwPhxBeK
 EbUrK5HGbnVFTDoILnJ66+IgUHQM4jkkrXW7UP2X586i2wxbeclFatO6DYByaNugUY7/
 OnwWcU1m7jC+acwmlpqy+HzrQHEniZECckbatX74ECrc71nzUG/S6Y+SrHgSUgaGbOIy
 veyL8LDDO3rOQh3WYKtQSpFnIRyNL1R1M5THTlMrmA3Bcv8jZ+PSC0dRluGoo2K+qMxs
 MZAg==
X-Gm-Message-State: AOJu0YxyNcQVj7vCfyk52Hvx6PvIZGjoUmgW/TRnI6UjW8c9Qt4nE3bb
 aNKrW/n8SGGRbAd8xx3P8kVaamMZ9pGdCc55ox1V7l5axqyxO15JksQzWUwPgYFWELbiMEnI3WA
 qubrJ+40pn1k3iAdsrunKQuC003fijuQ1spXOYu914bDFmaknZetaNSsEOgB/hf4OzXgDT4/ZkO
 AU6z2xFA==
X-Gm-Gg: AfdE7clxbL4XN0YtKOjOq+pYzSv07bG1dZUtAsaH1KE/XoKvkAqj5kuVzIo4LYjSWlS
 YhfUvW9fWRhlUwvzmUo7u0/FKpSsZ8Rp1sqUe0zOGt3VkIKtvThTqroiFBk8MbiRtBfKS8Nwr+I
 tiElURWt7e+2uOoWd203HLxfjdzMmD8FJQlmBxPWvjcf0bRlTHkq7GzJh83aMQC8Cq06lehkse9
 Z/HKMvYKzpTRdgZa5k1ILyl4Uww4xBoT0A+QbBz5uZo31U3hERsho4j+nuk6uL3P5OyHNmkYy/y
 J0BqQwUdVE0KUcgUe1qGKhLWJb7KuelxriKo85sACUk8fhSomTFo1ypGfHaS6Xx32jnSNATCzem
 ATgj4cNoppjniYUfuHJ8B1sr+xEG1QgpatOgNeqmjS6MPHgppIJgeX/U1KMV0uj2fALk4OLdKds
 oN33CybtLGPMy0+mwTuHF6AF0us/PxyFAY8ULiXHPC5/lXxZF1Q6iZdq1moASqPhFKIO9uLKboO
 /K+C+PKSpsStlr+C/ItnhdOblHEVYy+iyicyMSY59vJCZDjab8/rgum80cbDislcEOZWwAj73qL
 63E6oMT3LTUSuA==
X-Received: by 2002:a05:600c:3513:b0:492:564f:5603 with SMTP id
 5b1f17b1804b1-49266850086mr235369145e9.14.1782719923368; 
 Mon, 29 Jun 2026 00:58:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473b98814fbsm7614982f8f.32.2026.06.29.00.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:58:42 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:58:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icc14b286f2409738c73873aa7550dcc005ee8cbb
X-Gerrit-Change-Number: 1739
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1739?usp=email>
X-Gerrit-Commit: db8e018e3ee3b6932911b2ca65d7eeffb6609e80
References: <gerrit.1782719911000.Icc14b286f2409738c73873aa7550dcc005ee8cbb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljYzE0YjI4NmYyNDA5NzM4YzczODczYWE3NTUwZGNjMDA1ZWU4Y2JiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <805f7be564eb1732cea5b9d05fc7c6e6e3b61907-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6tK-0008Mf-M9
Subject: [Openvpn-devel] [S] Change in openvpn[master]: CMake: detect
 cmocka_version.h via include path, not by linking
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2868694166395559577=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2868694166395559577==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G6oWoq0L288="; charset=UTF-8

--G6oWoq0L288=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1739?usp=3Demail

to review the following change=2E


Chang=
e subject: CMake: detect cmocka_version=2Eh via include path, not by linkin=
g
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

CMake: det=
ect cmocka_version=2Eh via include path, not by linking

check_include_file=
s() was invoked with cmocka in CMAKE_REQUIRED_LIBRARIES,
which makes the pr=
obe link the (shared, imported) cmocka library=2E On some
platforms that li=
nk step fails inside the minimal probe, so the header check
reports failure=
 and HAVE_CMOCKA_VERSION_H is left undefined even though
cmocka_version=2Eh=
 is present=2E

test_common=2Eh then selects its cmocka 1=2Ex compatibility=
 shims and redefines
macros (check_expected_uint, expect_uint_value, =2E=2E=
=2E) that cmocka 2=2Ex already
provides, which breaks the -Werror build of =
every unit test driver=2E

Detecting a header only needs the include search=
 path, so pass cmocka's
INTERFACE_INCLUDE_DIRECTORIES via CMAKE_REQUIRED_IN=
CLUDES and drop the library
link requirement from the probe=2E

Change-Id: =
Icc14b286f2409738c73873aa7550dcc005ee8cbb
Signed-off-by: Lev Stipakov <lev@=
openvpn=2Enet>
---
M CMakeLists=2Etxt
1 file changed, 9 insertions(+), 1 de=
letion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/39/1739/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 4779=
d69=2E=2E8de836a 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -3=
85,12 +385,20 @@
     find_package(cmocka CONFIG)
     if (TARGET cmocka::c=
mocka)
         set(CMOCKA_LIBRARIES cmocka::cmocka)
+        get_target_pr=
operty(CMOCKA_INCLUDE_DIRS cmocka::cmocka INTERFACE_INCLUDE_DIRECTORIES)
  =
   else ()
         pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGE=
T)
         set(CMOCKA_LIBRARIES PkgConfig::cmocka)
+        set(CMOCKA_INC=
LUDE_DIRS ${cmocka_INCLUDE_DIRS})
     endif ()
-    set(CMAKE_REQUIRED_LIB=
RARIES ${CMOCKA_LIBRARIES})
+    # cmocka_version=2Eh exists since cmocka 2=
=2E0; its absence selects the
+    # cmocka 1=2Ex compat shims in test_comm=
on=2Eh=2E Detecting a header only needs
+    # the include path - do NOT ad=
d cmocka to CMAKE_REQUIRED_LIBRARIES, as that
+    # makes check_include_fi=
les link the shared library, which can fail in the
+    # probe for unrelat=
ed reasons and wrongly mis-detect cmocka 2=2Ex as < 2=2E0=2E
+    set(CMAKE=
_REQUIRED_INCLUDES ${CMOCKA_INCLUDE_DIRS})
     check_include_files(cmocka_=
version=2Eh HAVE_CMOCKA_VERSION_H)
+    unset(CMAKE_REQUIRED_INCLUDES)
 end=
if ()
 
 configure_file(config=2Eh=2Ecmake=2Ein config=2Eh)

-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1739?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: Icc14b286f2409738c73873aa7550dcc00=
5ee8cbb
Gerrit-Change-Number: 1739
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <=
lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--G6oWoq0L288=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1739?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">CM=
ake: detect cmocka_version=2Eh via include path, not by linking<br><br>chec=
k_include_files() was invoked with cmocka in CMAKE_REQUIRED_LIBRARIES,<br>w=
hich makes the probe link the (shared, imported) cmocka library=2E On some<=
br>platforms that link step fails inside the minimal probe, so the header c=
heck<br>reports failure and HAVE_CMOCKA_VERSION_H is left undefined even th=
ough<br>cmocka_version=2Eh is present=2E<br><br>test_common=2Eh then select=
s its cmocka 1=2Ex compatibility shims and redefines<br>macros (check_expec=
ted_uint, expect_uint_value, =2E=2E=2E) that cmocka 2=2Ex already<br>provid=
es, which breaks the -Werror build of every unit test driver=2E<br><br>Dete=
cting a header only needs the include search path, so pass cmocka&#39;s<br>=
INTERFACE_INCLUDE_DIRECTORIES via CMAKE_REQUIRED_INCLUDES and drop the libr=
ary<br>link requirement from the probe=2E<br><br>Change-Id: Icc14b286f24097=
38c73873aa7550dcc005ee8cbb<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=
=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>1 file changed, 9 insertions(+),=
 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/39/1739/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt</span><br><span>index 4779d69=2E=2E8de836a 100644=
</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2E=
txt</span><br><span>@@ -385,12 +385,20 @@</span><br><span>     find_package=
(cmocka CONFIG)</span><br><span>     if (TARGET cmocka::cmocka)</span><br><=
span>         set(CMOCKA_LIBRARIES cmocka::cmocka)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        get_target_property(CMOCKA_INCLUDE_D=
IRS cmocka::cmocka INTERFACE_INCLUDE_DIRECTORIES)</span><br><span>     else=
 ()</span><br><span>         pkg_search_module(cmocka cmocka REQUIRED IMPOR=
TED_TARGET)</span><br><span>         set(CMOCKA_LIBRARIES PkgConfig::cmocka=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        set(CMOCKA=
_INCLUDE_DIRS ${cmocka_INCLUDE_DIRS})</span><br><span>     endif ()</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    set(CMAKE_REQUIRED_LIBRAR=
IES ${CMOCKA_LIBRARIES})</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    # cmocka_version=2Eh exists since cmocka 2=2E0; its absence select=
s the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # cmocka 1=
=2Ex compat shims in test_common=2Eh=2E Detecting a header only needs</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    # the include path - =
do NOT add cmocka to CMAKE_REQUIRED_LIBRARIES, as that</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    # makes check_include_files link the=
 shared library, which can fail in the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    # probe for unrelated reasons and wrongly mis-detect=
 cmocka 2=2Ex as &lt; 2=2E0=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    set(CMAKE_REQUIRED_INCLUDES ${CMOCKA_INCLUDE_DIRS})</span><b=
r><span>     check_include_files(cmocka_version=2Eh HAVE_CMOCKA_VERSION_H)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unset(CMAKE_REQU=
IRED_INCLUDES)</span><br><span> endif ()</span><br><span> </span><br><span>=
 configure_file(config=2Eh=2Ecmake=2Ein config=2Eh)</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1739?usp=3Demail">change 1739</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1739?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: Icc14b286f2409738c73873aa7550dcc005ee8cbb <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1739 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body><=
/html>
--G6oWoq0L288=--


--===============2868694166395559577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2868694166395559577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2868694166395559577==--

