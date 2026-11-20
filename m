Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DBA606A823
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HGKomQjg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aTzjn/Si;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HoSxC8dY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=f048XJIU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=W0qYW/eQ+riVpX7OXrQY7v8gIFbWwoKi2tSXbniIZU0=; b=HGKomQjgapQl+aCUHAYwl962GK
	nUCjZUNLrBzcSbv1XYI9NFNmmEiyJM+gzwwS7kOF5OQRG+YIuoJDKLv3n4yXrEtQy/kyMaguU28Cr
	3EeR8QzwVEkFzpNxhbzDs/kZJS9qsgivJ+LA2516OOHRmJoplXVlr3Un/f8sPq2v4kTg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUSpo-000000002aE-16qJ;
	Fri, 20 Nov 2026 17:55:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUSpm-000000002a5-26HQ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 17:55:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6zT80u7l+pxz5WtBaG7T6Ii/V1FIyipvhSIVZ8xjjJU=; b=aTzjn/SijbzHWoYuKqdgXwKDrb
 6XISD57SSkFh0izGTOQhcaQzaRjMynjOI5dPdjWsUx4uieyTb1oc58L8gtdxx7xG/ba5okc2kTiIc
 eMZ/Lwl6LnoffO9CxyI5E+RtBzjwT52X63ZKlE2nwiKxt0nr610N1hp+oQ/ii4fJhDkA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6zT80u7l+pxz5WtBaG7T6Ii/V1FIyipvhSIVZ8xjjJU=; b=HoSxC8dYKyzW0GlArGH85Ie0Rf
 ttD7jCE5iEe0nEmOggrReYaxns9/udEvdEMByGXC/gvVcH+uM6Kdz+RmODH8H+em62EzA6n1gghUL
 GOIB1Mth7aUxbh4iEWrsrT6An5J6+flk6owlvU7Srvtwz8QrnsRLNvcGhdyMjkuMx4sg=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUSpi-000000007Cd-14d6 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 17:55:38 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso9692985e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 09:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795197328; x=1795802128; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6zT80u7l+pxz5WtBaG7T6Ii/V1FIyipvhSIVZ8xjjJU=;
 b=f048XJIUEUxv8HHhahuSrZ7alHW1N5vzhVlDJR0AYhxq7sfeN+aD08/nrGjobNbDf/
 eFRFtPMG1Xgf+mKBh/k06zSHOvHJx27yZ5SomZP6z2sc0xo2V1NV/57U1+czLq34cSMz
 p/D3ALRV51QNqRoQNAkxZc3YmMcHMsvsY4hl8g2C3aF6XuBtT3ALacwjm278wl5lzbvR
 MSbdI1clEO3aWaK7hSblcnMUT1iISIah3UWIcWEGxLFtCI+WcpHtRhemyYbHo/+ApOBR
 uh7wKwUqfd7xGw2VQuDuewMj0xvCxqQP0ymLEMrzrrRzhL9LbX705iQBycaTvkALXe9B
 VnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795197328; x=1795802128;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6zT80u7l+pxz5WtBaG7T6Ii/V1FIyipvhSIVZ8xjjJU=;
 b=oyMz/9ciunbbj9A3WmxSuPFyHrr5YrIKtKTKF+rGD13pineIwbbLfil1XhbJ5ohWF7
 0qEb7GoRqpPDOor2/wTNHbdS//Bb+nnxauNqHcr1HzWfABZ48zeg9V6JogxEjI87KeoP
 lL1GDX+yAeof6i652Z8hM+3DBatMNlDu0H4VYJqWVphzeCijQ3zcJY0IaemxFsSjIrJU
 0CslqBZHOWwLPgREzqfFS/V9i/Bz3+11dXp2Y/Ee4C6ybNmiO7vFLksF18rZ1cbsUt0C
 jpkjxlgWwTgbzr2NQvRYdBbhNGyTx7nQyhgijs6V2NTKfdC0n5Y132nyzwX/5lgX2sJ4
 gB5A==
X-Gm-Message-State: APuU4Z9IfVbBjxGiuetrNifrok0ksFN1wocELvIToN0o7vpJx+mgMYo8
 2Bv0PWdqz2XmI/I3Ptfemo5dAHmgH48uQ7nKZ2tNkFzoJC0to3ggoplH2+hK979RRxEoNWhAqKC
 IpwEOqOOg7yVt4NrxDLhzUDbjzGoFpn6Y+3V1UjcyK4lV1AcY4WKN/7xMiF31PnEmQxgD
X-Gm-Gg: AYBFou1Kd+6Vx8zrJ2gBagGAnCzD99GBtSoe/LexRF7jWE1iH4lbDf2btV298ae0GO3
 KZDYPyPVmenAQ+im17JdXT1mKgnfgp3eKhYVDKg2hiN8Yzb238XeeiwzQivQgLMgpc4tC0/avNX
 ZunWeA0TdAA2LKntq9xbNfR32KL5tlgvtvPo75pOJt33oFC2inBTJwcrP7xTinpqykvLVClT7GM
 bLkRa1vPUhwm2Xjl+j+OxevyOFB4zB1Tfy3x3BBE/eSy6qpD7OKzCFTyrACe+OYFiCyeqJwghpD
 1p8bEtLxsWpRQxbiwPmJewjxmFdHM5pHTOZhxxJkBJ0RK1htrRWUA52JTTE7yLRAaFSP3gWwGRt
 OkmrctPjZ++zbOtJq4z0gv+E1FgknZTzRj+io9AfvRycBaUnkU65QIAnEIqxSSOwaxIRFLxBfp/
 rf+B5ndFMoXoKW9ZztBuP4eUB83lm5iVsNe5sufv2tMv4tswRctZN72HFmF1ryg5YlO+g/TCpLY
 z8VjR+Oo2oSq/B1arz/pea4wKehCMx34xktHNmJ33U2dchh0t6OLBCp8xTloOI0BuP50bdV33Xs
 hr60WDXHpP01NGAPusnUqnJXU/M1gSY/wt5st+OwJIHs7qIP49S3YP4WsDEVcVTrIPA63hutqLA
 cdzl1B6e3l3o17j3imSKu8o89cbz0s5tbepT3BcugVy1xmKlb0RtmCyIp69qzclND/f44fDYi4P
 d5v8EWsLgcual6QnQ=
X-Received: by 2002:a05:600c:5303:b0:4a2:fe11:9a8a with SMTP id
 5b1f17b1804b1-4bb88786cfamr82345705e9.0.1795197327270; 
 Fri, 20 Nov 2026 09:55:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c61f558sm6947041f8f.58.2026.11.20.09.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 09:55:26 -0800 (PST)
X-Google-Original-From: "Laptops (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 17:55:25 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib57d973a2f8ef48c3710f7d034da1a91c64d4755
X-Gerrit-Change-Number: 2035
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2035?usp=email>
X-Gerrit-Commit: 8c8f29f8e1a4275f073b2b9810032d53561f8071
In-Reply-To: <gerrit.1793032811000.Ib57d973a2f8ef48c3710f7d034da1a91c64d4755@gerrit.openvpn.net>
References: <gerrit.1793032811000.Ib57d973a2f8ef48c3710f7d034da1a91c64d4755@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDMyODExMDAwLkliNTdkOTczYTJmOGVmNDhjMzcxMGY3ZDAzNGRhMWE5MWM2NGQ0NzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7e3f448c8720100972ac0cd8da621682e69571ea-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUSpi-000000007Cd-14d6
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: add optional
 -fbounds-safety annotations
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Laptops \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: jeff@incrediblybased.co, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Laptops \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4635831024097456908=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4635831024097456908==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8XHXv2bZ/z4="; charset=UTF-8

--8XHXv2bZ/z4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2035?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: buffer: add optional -fbounds-safety annotations
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: add o=
ptional -fbounds-safety annotations

Add Clang -fbounds-safety annotations =
to struct buffer and the buffer
API, and allow building buffer=2Ec with -fb=
ounds-safety via
--enable-fbounds-safety (autotools) or -DENABLE_FBOUNDS_SA=
FETY=3DON
(CMake)=2E The option is off by default=2E

Only buffer=2Ec is bu=
ilt with the flag for now, since most other files and
some system and libra=
ry headers are not annotated yet=2E CMake sets it as
a source file property=
, so it also applies to the unit tests that build
buffer=2Ec=2E Automake bu=
ilds buffer=2Ec as a small convenience library with
its own CFLAGS=2E

comp=
at=2Eh uses <ptrcheck=2Eh> when it is available, since some system
headers =
include it unconditionally, and only defines no-op fallbacks
for annotation=
s that are still undefined=2E

The annotations used on non-static declarati=
ons (__sized_by,
__counted_by, __null_terminated, __unsafe_indexable) do no=
t change the
representation of pointers, so buffer=2Eo is ABI compatible wi=
th code
built without -fbounds-safety=2E The wide __bidi_indexable pointers=
 are
only used as return types of static inline helpers=2E

The free functi=
on callback of gc_addspecial() takes a
void *__unsafe_indexable, which matc=
hes how the macOS SDK declares
free(), so free() can be passed without a ca=
st=2E

glibc's string=2Eh is not annotated, so buf_extract_field() turns th=
e
result of memchr() into a checked pointer to the one matching byte with
_=
_unsafe_forge_bidi_indexable(); compat=2Eh gets a no-op fallback for it=2E
=
With that, --enable-fbounds-safety builds and passes the unit tests on
Linu=
x/glibc as well as on macOS=2E

Change-Id: Ib57d973a2f8ef48c3710f7d034da1a9=
1c64d4755
Signed-off-by: Jeff Bindel <jeff@incrediblybased=2Eco>
---
M =2Ec=
lang-format
M CMakeLists=2Etxt
M configure=2Eac
M src/compat/compat=2Eh
M s=
rc/openvpn/Makefile=2Eam
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
=
7 files changed, 169 insertions(+), 78 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/35/2035/2

diff --git a/=2Ecl=
ang-format b/=2Eclang-format
index 23d224b=2E=2E312b6d3 100644
--- a/=2Ecla=
ng-format
+++ b/=2Eclang-format
@@ -17,6 +17,7 @@
 AllowShortFunctionsOnASi=
ngleLine: None
 AllowShortIfStatementsOnASingleLine: Never
 AllowShortLoops=
OnASingleLine: false
+AttributeMacros: [__counted_by, __counted_by_or_null,=
 __sized_by, __sized_by_or_null]
 BinPackArguments: true
 BinPackParameters=
: true
 BreakAfterReturnType: AllDefinitions
diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt
index 50b2d68=2E=2Ec045b62 100644
--- a/CMakeLists=2Etxt=

+++ b/CMakeLists=2Etxt
@@ -43,6 +43,8 @@
 option(ENABLE_DEBUG "Enable buil=
ding with debug" OFF)
 
 option(ENABLE_DNS_UPDOWN_BY_DEFAULT "Run --dns-upd=
own hook by default" ON)
+
+option(ENABLE_FBOUNDS_SAFETY "Enable experiment=
al Clang -fbounds-safety annotations (OFF by default)" OFF)
 set(DNS_UPDOWN=
_PATH "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" CACHE STRING "De=
fault location for the DNS up/down script")
 
 set(PLUGIN_DIR "${CMAKE_INST=
ALL_PREFIX}/lib/openvpn/plugins" CACHE FILEPATH "Location of the plugin dir=
ectory")
@@ -647,6 +649,15 @@
     src/openvpn/xkey_provider=2Ec
     )
 
+=
if (ENABLE_FBOUNDS_SAFETY)
+    # Only buffer=2Ec is built with -fbounds-sa=
fety for now=2E This applies to
+    # every target in this directory that =
compiles it, including unit tests=2E
+    set_source_files_properties(src/o=
penvpn/buffer=2Ec PROPERTIES
+        COMPILE_OPTIONS -fbounds-safety
+    =
    COMPILE_DEFINITIONS OVPN_SUPPORT_FBOUNDS_SAFETY
+        )
+endif ()
+
=
 add_executable(openvpn ${SOURCE_FILES})
 
 add_library_deps(openvpn)
diff =
--git a/configure=2Eac b/configure=2Eac
index 585c3bd=2E=2Ef6df994 100644
-=
-- a/configure=2Eac
+++ b/configure=2Eac
@@ -1355,6 +1355,15 @@
 AC_SUBST([=
tmpfilesdir])
 
 AC_ARG_ENABLE(
+	[fbounds-safety],
+	[AS_HELP_STRING([--en=
able-fbounds-safety],
+	                [enable experimental Clang -fbounds=
-safety annotations @<:@default=3Dno@:>@])],
+	[enable_fbounds_safety=3D"$e=
nableval"],
+	[enable_fbounds_safety=3D"no"]
+)
+AM_CONDITIONAL([ENABLE_FBO=
UNDS_SAFETY], [test "${enable_fbounds_safety}" =3D "yes"])
+
+AC_ARG_ENABLE=
(
      [unit-tests],
      [AS_HELP_STRING([--disable-unit-tests],
       =
               [Disables building and running the unit tests suite])],
diff=
 --git a/src/compat/compat=2Eh b/src/compat/compat=2Eh
index 4ee9141=2E=2E4=
b264f8 100644
--- a/src/compat/compat=2Eh
+++ b/src/compat/compat=2Eh
@@ -7=
5,4 +75,56 @@
 strtok_r(char *s, const char *delim, char **last);
 #endif
 =

+/*
+ * Optional Clang -fbounds-safety annotations=2E <ptrcheck=2Eh> turns=
 them into
+ * no-ops when -fbounds-safety is not enabled, and some system =
headers include
+ * it unconditionally, so prefer it when available and onl=
y fall back to our
+ * own no-op definitions for annotations that are still=
 undefined=2E
+ */
+#if defined(OVPN_SUPPORT_FBOUNDS_SAFETY)
+#include <ptr=
check=2Eh>
+#elif defined(__has_include)
+#if __has_include(<ptrcheck=2Eh>)=

+#include <ptrcheck=2Eh>
+#endif
+#endif
+
+#ifndef __sized_by
+#define __=
sized_by(n)
+#endif
+#ifndef __sized_by_or_null
+#define __sized_by_or_null=
(n)
+#endif
+#ifndef __counted_by
+#define __counted_by(n)
+#endif
+#ifndef=
 __counted_by_or_null
+#define __counted_by_or_null(n)
+#endif
+#ifndef __n=
ull_terminated
+#define __null_terminated
+#endif
+#ifndef __unsafe_indexab=
le
+#define __unsafe_indexable
+#endif
+#ifndef __unsafe_forge_single
+#def=
ine __unsafe_forge_single(T, P) ((T)(P))
+#endif
+#ifndef __unsafe_forge_bi=
di_indexable
+#define __unsafe_forge_bidi_indexable(T, P, S) ((T)(P))
+#end=
if
+#ifndef __null_terminated_to_indexable
+#define __null_terminated_to_in=
dexable(P) (P)
+#endif
+#ifndef __unsafe_null_terminated_to_indexable
+#def=
ine __unsafe_null_terminated_to_indexable(P) (P)
+#endif
+#ifndef __unsafe_=
null_terminated_from_indexable
+#define __unsafe_null_terminated_from_index=
able(P) (P)
+#endif
+/* not defined by <ptrcheck=2Eh> without -fbounds-safe=
ty as it changes the ABI */
+#ifndef __bidi_indexable
+#define __bidi_index=
able
+#endif
+
 #endif /* COMPAT_H */
diff --git a/src/openvpn/Makefile=2Ea=
m b/src/openvpn/Makefile=2Eam
index be1044d=2E=2E8c34580 100644
--- a/src/o=
penvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -50,7 +50,7 @@
 	au=
th_token=2Ec auth_token=2Eh \
 	base64=2Ec base64=2Eh \
 	basic=2Eh \
-	buf=
fer=2Ec buffer=2Eh \
+	buffer=2Eh \
 	check_file_access=2Ec check_file_acce=
ss=2Eh \
 	circ_list=2Eh \
 	clinat=2Ec clinat=2Eh \
@@ -163,7 +163,17 @@
 =
	win32=2Eh win32=2Ec \
 	win32-util=2Eh win32-util=2Ec \
 	cryptoapi=2Eh cr=
yptoapi=2Ec
-openvpn_LDADD =3D \
+if ENABLE_FBOUNDS_SAFETY
+# Only buffer=
=2Ec is built with -fbounds-safety for now
+noinst_LTLIBRARIES =3D libbuffe=
r=2Ela
+libbuffer_la_SOURCES =3D buffer=2Ec
+libbuffer_la_CFLAGS =3D $(AM_C=
FLAGS) -fbounds-safety -DOVPN_SUPPORT_FBOUNDS_SAFETY
+openvpn_LDADD =3D lib=
buffer=2Ela
+else
+openvpn_SOURCES +=3D buffer=2Ec
+openvpn_LDADD =3D
+endi=
f
+openvpn_LDADD +=3D \
 	$(top_builddir)/src/compat/libcompat=2Ela \
 	$(S=
OCKETS_LIBS) \
 	$(OPTIONAL_LIBCAPNG_LIBS) \
diff --git a/src/openvpn/buffe=
r=2Ec b/src/openvpn/buffer=2Ec
index c33a987=2E=2E62ce0fe 100644
--- a/src/=
openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -276,7 +276,7 @@
       =
  size_t len =3D strlen(str) + 1;
         if (buf_size_valid(len) && len <=
 buf_forward_capacity_total(buf))
         {
-            memcpy(buf->data =
+ buf->capacity - len, str, len);
+            memcpy(buf->data + buf->capa=
city - len, __unsafe_null_terminated_to_indexable(str), len);
         }
  =
   }
 }
@@ -317,7 +317,7 @@
  * Garbage collection
  */
 
-void *
+void *__=
sized_by(size)
 gc_malloc(size_t size, bool clear, struct gc_arena *a)
 {
 =
    void *ret;
@@ -411,7 +411,7 @@
 }
 
 void
-gc_addspecial(void *addr, vo=
id (*free_function)(void *), struct gc_arena *a)
+gc_addspecial(void *addr,=
 void (*free_function)(void *__unsafe_indexable), struct gc_arena *a)
 {
  =
   ASSERT(a);
     struct gc_entry_special *e;
@@ -457,7 +457,7 @@
  */
 
 =
char *
-format_hex_ex(const uint8_t *data, size_t size, size_t maxoutput, u=
nsigned int space_break_flags,
+format_hex_ex(const uint8_t *__counted_by(s=
ize) data, size_t size, size_t maxoutput, unsigned int space_break_flags,
 =
              const char *separator, struct gc_arena *gc)
 {
     const siz=
e_t bytes_per_hexblock =3D space_break_flags & FHE_SPACE_BREAK_MASK;
@@ -59=
3,7 +593,7 @@
  * Remove trailing \r and \n chars=2E
  */
 void
-chomp(char=
 *str)
+chomp(char *__null_terminated str)
 {
     rm_trailing_chars(str, "=
\r\n");
 }
@@ -602,19 +602,20 @@
  * Remove trailing chars
  */
 void
-rm_t=
railing_chars(char *str, const char *what_to_delete)
+rm_trailing_chars(cha=
r *__null_terminated str, const char *what_to_delete)
 {
+    char *cp =3D =
__null_terminated_to_indexable(str);
     size_t len =3D strlen(str);
-    =
while (len > 0 && strchr(what_to_delete, str[len - 1]) !=3D NULL)
+    whil=
e (len > 0 && strchr(what_to_delete, cp[len - 1]) !=3D NULL)
     {
-      =
  str[--len] =3D '\0';
+        cp[--len] =3D '\0';
     }
 }
 
 /*
  * All=
ocate a string
  */
-char *
+char *__null_terminated
 string_alloc(const ch=
ar *str, struct gc_arena *gc)
 {
     if (str)
@@ -635,8 +636,8 @@
        =
     ret =3D calloc(1, n);
             check_malloc_return(ret);
         =
}
-        memcpy(ret, str, n);
-        return ret;
+        memcpy(ret, _=
_unsafe_null_terminated_to_indexable(str), n);
+        return __unsafe_nul=
l_terminated_from_indexable(ret);
     }
     else
     {
@@ -648,11 +649,1=
1 @@
  * Erase all characters in a string
  */
 void
-string_clear(char *st=
r)
+string_clear(char *__null_terminated str)
 {
     if (str)
     {
-    =
    secure_memzero(str, strlen(str));
+        secure_memzero(__null_termin=
ated_to_indexable(str), strlen(str));
     }
 }
 
@@ -660,7 +661,7 @@
  * R=
eturn the length of a string array
  */
 int
-string_array_len(const char *=
*array)
+string_array_len(const char **__null_terminated array)
 {
     int=
 i =3D 0;
     if (array)
@@ -674,13 +675,13 @@
 }
 
 char *
-print_argv(co=
nst char **p, struct gc_arena *gc, const unsigned int flags)
+print_argv(co=
nst char **__null_terminated p, struct gc_arena *gc, const unsigned int fla=
gs)
 {
     struct buffer out =3D alloc_buf_gc(256, gc);
     int i =3D 0;
=
     for (; *p; ++p)
     {
-        const char *cp =3D *p;
+        const =
char *__null_terminated cp =3D *p;
         if (i)
         {
             =
buf_printf(&out, " ");
@@ -708,8 +709,8 @@
 
     ASSERT(str);
 
-    const=
 char *copy =3D string_alloc(str, gc);
-    buf_set_read(&buf, (const uint8=
_t *)copy, strlen(str) + 1);
+    const char *__null_terminated copy =3D st=
ring_alloc(str, gc);
+    buf_set_read(&buf, (const uint8_t *)__unsafe_null=
_terminated_to_indexable(copy), strlen(str) + 1);
 
     if (buf=2Elen > 0)=
 /* Don't count trailing '\0' as part of length */
     {
@@ -731,7 +732,7 =
@@
     {
         return false;
     }
-    return memcmp(CBPTR(src), matc=
h, size) =3D=3D 0;
+    return memcmp(CBPTR(src), __null_terminated_to_inde=
xable(match), size) =3D=3D 0;
 }
 
 #if defined(__GNUC__) || defined(__clan=
g__)
@@ -780,7 +781,7 @@
  */
 
 bool
-buf_parse(struct buffer *buf, const =
int delim, char *line, const int size)
+buf_parse(struct buffer *buf, const=
 int delim, char *__counted_by(size) line, const int size)
 {
     bool eol=
 =3D false;
     int n =3D 0;
@@ -1018,12 +1019,13 @@
  * Guaranteed to not=
 increase string length=2E
  */
 bool
-string_mod(char *str, const unsigned=
 int inclusive, const unsigned int exclusive,
+string_mod(char *__null_term=
inated str, const unsigned int inclusive, const unsigned int exclusive,
   =
         const char replace)
 {
     ASSERT(str);
 
-    char *out =3D str;=

+    /* the terminator is rewritten in place, so it needs to be within bou=
nds */
+    char *out =3D __unsafe_null_terminated_to_indexable(str);
     =
const char *in =3D out;
     bool ret =3D true;
 
@@ -1074,7 +1076,7 @@
 {
=
     if (str)
     {
-        char *buf =3D string_alloc(str, gc);
+       =
 char *__null_terminated buf =3D string_alloc(str, gc);
         string_mod=
(buf, inclusive, exclusive, replace);
         return buf;
     }
@@ -1085,=
7 +1087,7 @@
 }
 
 void
-string_replace_leading(char *str, const char match=
, const char replace)
+string_replace_leading(char *__null_terminated str, =
const char match, const char replace)
 {
     ASSERT(match !=3D '\0');
    =
 while (*str)
@@ -1147,7 +1149,7 @@
 }
 
 bool
-checked_snprintf(char *str,=
 size_t size, const char *format, =2E=2E=2E)
+checked_snprintf(char *__coun=
ted_by(size) str, size_t size, const char *format, =2E=2E=2E)
 {
     va_li=
st arglist;
     va_start(arglist, format);
@@ -1227,7 +1229,8 @@
     if (=
str)
     {
         const size_t len =3D strlen((const char *)str);
-     =
   struct buffer_entry *e =3D buffer_list_push_data(ol, str, len + 1);
+   =
     struct buffer_entry *e =3D
+            buffer_list_push_data(ol, __un=
safe_null_terminated_to_indexable(str), len + 1);
         if (e)
         =
{
             e->buf=2Elen--; /* Don't count trailing '\0' as part of leng=
th */
@@ -1236,7 +1239,7 @@
 }
 
 struct buffer_entry *
-buffer_list_push_d=
ata(struct buffer_list *ol, const void *data, size_t size)
+buffer_list_pus=
h_data(struct buffer_list *ol, const void *__sized_by(size) data, size_t si=
ze)
 {
     struct buffer_entry *e =3D NULL;
     if (data)
@@ -1311,7 +131=
4,7 @@
         {
             struct buffer_entry *next =3D e->next;
     =
        buf_copy(&f->buf, &e->buf);
-            buf_write(&f->buf, sep, se=
p_len);
+            buf_write(&f->buf, __null_terminated_to_indexable(sep)=
, sep_len);
             free_buf(&e->buf);
             free(e);
         =
    e =3D next;
@@ -1386,7 +1389,7 @@
             bl =3D buffer_list_new()=
;
             while (fgets(line, max_line_len, fp) !=3D NULL)
            =
 {
-                buffer_list_push(bl, line);
+                buffer_lis=
t_push(bl, __unsafe_null_terminated_from_indexable(line));
             }
 =
            free(line);
         }
@@ -1436,7 +1439,9 @@
         return NU=
LL;
     }
 
-    const uint8_t *seppos =3D memchr(CBPTR(buf), sep, buf_len=
(buf));
+    /* glibc does not annotate memchr(); the result points at one =
byte of buf */
+    const uint8_t *seppos =3D
+        __unsafe_forge_bidi_=
indexable(const uint8_t *, memchr(CBPTR(buf), sep, buf_len(buf)), 1);
     =
if (!seppos)
     {
         return NULL;
diff --git a/src/openvpn/buffer=
=2Eh b/src/openvpn/buffer=2Eh
index 32b49d3=2E=2E259380a 100644
--- a/src/o=
penvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -69,13 +69,14 @@
  */
 st=
ruct buffer
 {
-    int capacity;  /**< Size in bytes of memory allocated b=
y
-                    *   \c malloc()=2E */
-    int offset;    /**< Offse=
t in bytes of the actual content
-                    *   within the alloca=
ted memory=2E */
-    int len;       /**< Length in bytes of the actual con=
tent
-                    *   within the allocated memory=2E */
-    uint8_=
t *data; /**< Pointer to the allocated memory=2E */
+    int capacity; /**<=
 Size in bytes of memory allocated by
+                   *   \c malloc()=
=2E */
+    int offset;   /**< Offset in bytes of the actual content
+     =
              *   within the allocated memory=2E */
+    int len;      /**<=
 Length in bytes of the actual content
+                   *   within the a=
llocated memory=2E */
+    /** Pointer to the allocated memory=2E */
+    u=
int8_t *__sized_by_or_null(capacity) data;
 
 #ifdef BUF_INIT_TRACKING
    =
 const char *debug_file;
@@ -108,7 +109,7 @@
 struct gc_entry_special
 {
  =
   struct gc_entry_special *next;
-    void (*free_fnc)(void *);
+    void =
(*free_fnc)(void *__unsafe_indexable);
     void *addr;
 };
 
@@ -199,7 +20=
0,7 @@
  *
  * @param str   The string to clear=2E
  */
-void string_clear(=
char *str);
+void string_clear(char *__null_terminated str);
 
 /**
  * Ret=
urn the number of elements in a NULL-terminated array of strings=2E
@@ -208=
,7 +209,7 @@
  *
  * @return Number of non-NULL elements=2E
  */
-int strin=
g_array_len(const char **array);
+int string_array_len(const char **__null_=
terminated array);
 
 /**
  * Safely compute the product of two sizes plus =
an extra amount=2E
@@ -236,7 +237,7 @@
  *
  * @return Newly allocated stri=
ng representation of \c p=2E
  */
-char *print_argv(const char **p, struct =
gc_arena *gc, const unsigned int flags);
+char *print_argv(const char **__n=
ull_terminated p, struct gc_arena *gc, const unsigned int flags);
 
 /**
  =
* Report a buffer size error and abort=2E
@@ -299,7 +300,7 @@
  *
  * @retu=
rn Pointer to the newly allocated memory=2E
  */
-void *gc_malloc(size_t si=
ze, bool clear, struct gc_arena *a);
+void *__sized_by(size) gc_malloc(size=
_t size, bool clear, struct gc_arena *a);
 
 /**
  * Duplicate a string, al=
locating memory under garbage collection=2E
@@ -311,7 +312,7 @@
  *
  * @re=
turn A newly allocated copy of \c str, or NULL if \c str is NULL=2E
  */
-c=
har *string_alloc(const char *str, struct gc_arena *gc);
+char *__null_term=
inated string_alloc(const char *str, struct gc_arena *gc);
 
 /**
  * Alloc=
ate a buffer containing a copy of the given string=2E
@@ -337,10 +338,12 @@=

  * something other than plain \c free(), such as \c freeaddrinfo()=2E
  *=

  * @param addr          Pointer to the memory to register=2E
- * @param f=
ree_function Function to call to free \c addr=2E
+ * @param free_function F=
unction to call to free \c addr=2E  The parameter is
+ *                   =
   \c __unsafe_indexable so that \c free() can be passed
+ *               =
       with -fbounds-safety=2E
  * @param a             Garbage collection =
arena to register with=2E
  */
-void gc_addspecial(void *addr, void (*free_=
function)(void *), struct gc_arena *a);
+void gc_addspecial(void *addr, voi=
d (*free_function)(void *__unsafe_indexable), struct gc_arena *a);
 
 /**
 =
 * allows to realloc a pointer previously allocated by gc_malloc or gc_real=
loc
@@ -374,9 +377,9 @@
  * @param addr  Pointer to the \c struct \c addrin=
fo to free=2E
  */
 static inline void
-gc_freeaddrinfo_callback(void *addr=
)
+gc_freeaddrinfo_callback(void *__unsafe_indexable addr)
 {
-    freeaddr=
info((struct addrinfo *)addr);
+    freeaddrinfo(__unsafe_forge_single(stru=
ct addrinfo *, addr));
 }
 
 /** Return an empty, undefined \c struct \c bu=
ffer (all fields zero)=2E */
@@ -424,7 +427,7 @@
  * @return Pointer to \c =
buf->data + \c buf->offset, or NULL if \c buf is
  *         not valid=2E
 =
 */
-static inline const uint8_t *
+static inline const uint8_t *__bidi_ind=
exable
 buf_cbptr(const struct buffer *buf)
 {
     if (buf_valid(buf))
@@ =
-445,7 +448,7 @@
  * @return Pointer to \c buf->data + \c buf->offset, or N=
ULL if \c buf is
  *         not valid=2E
  */
-static inline uint8_t *
+st=
atic inline uint8_t *__bidi_indexable
 buf_bptr(struct buffer *buf)
 {
    =
 return (uint8_t *)buf_cbptr(buf);
@@ -478,7 +481,7 @@
  *
  * @return Poin=
ter to the byte immediately after the last content byte=2E
  */
-static inl=
ine uint8_t *
+static inline uint8_t *__bidi_indexable
 buf_bend(struct buf=
fer *buf)
 {
     return buf_bptr(buf) + buf_len(buf);
@@ -491,7 +494,7 @@
=
  *
  * @return Pointer to the byte immediately after the last content byte=
=2E
  */
-static inline const uint8_t *
+static inline const uint8_t *__bid=
i_indexable
 buf_cbend(const struct buffer *buf)
 {
     return buf_cbptr(b=
uf) + buf_len(buf);
@@ -505,7 +508,7 @@
  * @return Pointer to the last byt=
e, or NULL if the buffer is empty or
  *         invalid=2E
  */
-static in=
line const uint8_t *
+static inline const uint8_t *__bidi_indexable
 buf_cb=
last(const struct buffer *buf)
 {
     if (buf_len(buf) > 0)
@@ -526,7 +529=
,7 @@
  * @return Pointer to the last byte, or NULL if the buffer is empty =
or
  *         invalid=2E
  */
-static inline uint8_t *
+static inline uint=
8_t *__bidi_indexable
 buf_blast(struct buffer *buf)
 {
     return (uint8_=
t *)buf_cblast(buf);
@@ -568,7 +571,7 @@
  *
  * @return The content pointe=
r as a \c char *, or NULL if \c buf is invalid=2E
  */
-static inline char =
*
+static inline char *__bidi_indexable
 buf_str(struct buffer *buf)
 {
   =
  return (char *)buf_bptr(buf);
@@ -581,7 +584,7 @@
  *
  * @return The con=
tent pointer as a \c const char *, or NULL if \c buf is invalid=2E
  */
-st=
atic inline const char *
+static inline const char *__bidi_indexable
 buf_c=
str(const struct buffer *buf)
 {
     return (const char *)buf_cbptr(buf);
=
@@ -655,7 +658,7 @@
  * @param size  Size of the memory region in bytes=2E
=
  */
 static inline void
-buf_set_write(struct buffer *buf, uint8_t *data, =
size_t size)
+buf_set_write(struct buffer *buf, uint8_t *__sized_by_or_null=
(size) data, size_t size)
 {
     if (!buf_size_valid(size))
     {
@@ -684=
,7 +687,7 @@
  * @param size  Size of the memory region in bytes=2E
  */
 s=
tatic inline void
-buf_set_read(struct buffer *buf, const uint8_t *data, si=
ze_t size)
+buf_set_read(struct buffer *buf, const uint8_t *__sized_by_or_n=
ull(size) data, size_t size)
 {
     if (!buf_size_valid(size))
     {
@@ -=
745,13 +748,13 @@
  * @param len   Length of data, in bytes=2E
  */
 static=
 inline void
-secure_memzero(void *data, size_t len)
+secure_memzero(void *=
__sized_by(len) data, size_t len)
 {
 #if defined(_WIN32)
     SecureZeroMe=
mory(data, len);
 #elif defined(__GNUC__) || defined(__clang__)
     memset=
(data, 0, len);
-    __asm__ __volatile__("" : : "r"(data) : "memory");
+  =
  __asm__ __volatile__("" : : "r"(__unsafe_forge_single(void *, data)) : "m=
emory");
 #else
     volatile char *p =3D (volatile char *)data;
     while=
 (len--)
@@ -836,7 +839,7 @@
  *
  * @param str   The null-terminated strin=
g to chomp=2E
  */
-void chomp(char *str);
+void chomp(char *__null_termina=
ted str);
 
 /**
  * Remove all trailing characters that appear in a given =
set=2E
@@ -844,7 +847,7 @@
  * @param str             The null-terminated s=
tring to modify in place=2E
  * @param what_to_delete  Null-terminated set =
of characters to strip=2E
  */
-void rm_trailing_chars(char *str, const cha=
r *what_to_delete);
+void rm_trailing_chars(char *__null_terminated str, co=
nst char *what_to_delete);
 
 /**
  * Return a pointer past any leading whi=
tespace in a string=2E
@@ -913,7 +916,7 @@
  *         extracted; true othe=
rwise (including when a delimiter was found
  *         or \c line was trun=
cated)=2E
  */
-bool buf_parse(struct buffer *buf, const int delim, char *l=
ine, const int size);
+bool buf_parse(struct buffer *buf, const int delim, =
char *__counted_by(size) line, const int size);
 
 /** @name Hex Dump
  *  =
@brief Output a binary buffer to a hex string and return it=2E
@@ -941,7 +9=
44,7 @@
  *
  * @return Null-terminated hex string allocated from \c gc=2E
=
  */
-char *format_hex_ex(const uint8_t *data, size_t size, size_t maxoutpu=
t, unsigned int space_break_flags,
+char *format_hex_ex(const uint8_t *__co=
unted_by(size) data, size_t size, size_t maxoutput, unsigned int space_brea=
k_flags,
                     const char *separator, struct gc_arena *gc);
=
 
 /**
@@ -957,7 +960,7 @@
  * @return Null-terminated hex string allocated=
 from \c gc=2E
  */
 static inline char *
-format_hex(const uint8_t *data, =
size_t size, size_t maxoutput, struct gc_arena *gc)
+format_hex(const uint8=
_t *__counted_by(size) data, size_t size, size_t maxoutput, struct gc_arena=
 *gc)
 {
     return format_hex_ex(data, size, maxoutput, 4, " ", gc);
 }
@=
@ -1138,7 +1141,7 @@
  * @return Pointer to the newly reserved space (new c=
ontent start), or NULL
  *         if \c buf is invalid or there is insuffi=
cient prepend capacity=2E
  */
-static inline uint8_t *
+static inline uint=
8_t *__bidi_indexable
 buf_prepend(struct buffer *buf, ssize_t size)
 {
   =
  if (!buf_valid(buf) || size < 0 || size > buf->offset)
@@ -1185,7 +1188,7=
 @@
  * @return Pointer to the start of the reserved space, or NULL if ther=
e is
  *         insufficient capacity=2E
  */
-static inline uint8_t *
+st=
atic inline uint8_t *__bidi_indexable
 buf_write_alloc(struct buffer *buf, =
size_t size)
 {
     uint8_t *ret;
@@ -1210,7 +1213,7 @@
  * @return Pointe=
r to the start of the consumed region, or NULL if \c size
  *         is ne=
gative or exceeds the current length=2E
  */
-static inline uint8_t *
+stat=
ic inline uint8_t *__bidi_indexable
 buf_read_alloc(struct buffer *buf, int=
 size)
 {
     uint8_t *ret;
@@ -1236,7 +1239,7 @@
  * @return true on succ=
ess, false if there is insufficient capacity=2E
  */
 static inline bool
-b=
uf_write(struct buffer *dest, const void *src, size_t size)
+buf_write(stru=
ct buffer *dest, const void *__sized_by(size) src, size_t size)
 {
     uin=
t8_t *cp =3D buf_write_alloc(dest, size);
     if (!cp)
@@ -1265,7 +1268,7 =
@@
  * @return true on success, false if there is insufficient prepend capa=
city=2E
  */
 static inline bool
-buf_write_prepend(struct buffer *dest, co=
nst void *src, int size)
+buf_write_prepend(struct buffer *dest, const void=
 *__sized_by(size) src, int size)
 {
     uint8_t *cp =3D buf_prepend(dest,=
 size);
     if (!cp)
@@ -1453,7 +1456,7 @@
  * @return true on success, fa=
lse if \c src has fewer than \c size bytes=2E
  */
 static inline bool
-buf=
_read(struct buffer *src, void *dest, int size)
+buf_read(struct buffer *sr=
c, void *__sized_by(size) dest, int size)
 {
     const uint8_t *cp =3D buf=
_read_alloc(src, size);
     if (!cp)
@@ -1601,7 +1604,7 @@
  * *NOT* const=
ant time=2E Do not use when comparing HMACs=2E
  */
 static inline bool
-bu=
f_string_match(const struct buffer *src, const void *match, int size)
+buf_=
string_match(const struct buffer *src, const void *__sized_by(size) match, =
int size)
 {
     if (size !=3D src->len)
     {
@@ -1615,7 +1618,7 @@
  * =
*NOT* constant time=2E Do not use when comparing HMACs=2E
  */
 static inli=
ne bool
-buf_string_match_head(const struct buffer *src, const void *match,=
 int size)
+buf_string_match_head(const struct buffer *src, const void *__s=
ized_by(size) match, int size)
 {
     if (size < 0 || size > src->len)
   =
  {
@@ -1758,7 +1761,7 @@
  * @param replace The character to replace the s=
pecified character classes with=2E
  * @return True if the string was not m=
odified, false otherwise=2E
  */
-bool string_mod(char *str, const unsigned=
 int inclusive, const unsigned int exclusive,
+bool string_mod(char *__null=
_terminated str, const unsigned int inclusive, const unsigned int exclusive=
,
                 const char replace);
 
 
@@ -1802,7 +1805,7 @@
  * @para=
m match    The character to replace=2E
  * @param replace  The replacement =
character=2E
  */
-void string_replace_leading(char *str, const char match,=
 const char replace);
+void string_replace_leading(char *__null_terminated =
str, const char match, const char replace);
 
 /**
  * Return true iff \c s=
tr starts with \c prefix=2E
@@ -1845,7 +1848,7 @@
  *
  * @return true if s=
nprintf() was successful and not truncated=2E
  */
-bool checked_snprintf(c=
har *str, size_t size, const char *format, =2E=2E=2E)
+bool checked_snprint=
f(char *__counted_by(size) str, size_t size, const char *format, =2E=2E=2E)=

 #ifdef __GNUC__
 #if __USE_MINGW_ANSI_STDIO
     __attribute__((format(gn=
u_printf, 3, 4)))
@@ -2219,7 +2222,7 @@
  *
  * @return the new buffer
  */=

-struct buffer_entry *buffer_list_push_data(struct buffer_list *ol, const =
void *data, size_t size);
+struct buffer_entry *buffer_list_push_data(struc=
t buffer_list *ol, const void *__sized_by(size) data, size_t size);
 
 /**
=
  * Retrieve the head buffer

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2035?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ib57d973a2f8ef48c3710f7d034da1a91c64d4755
Gerrit-Change-Num=
ber: 2035
Gerrit-PatchSet: 2
Gerrit-Owner: Laptops <jeff@incrediblybased=2E=
co>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>

--8XHXv2bZ/z4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Laptops <strong>uploaded patc=
h set #2</strong> to this change=2E</p><p><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2035?usp=3Demail">View Change</a></p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">buf=
fer: add optional -fbounds-safety annotations<br><br>Add Clang -fbounds-saf=
ety annotations to struct buffer and the buffer<br>API, and allow building =
buffer=2Ec with -fbounds-safety via<br>--enable-fbounds-safety (autotools) =
or -DENABLE_FBOUNDS_SAFETY=3DON<br>(CMake)=2E The option is off by default=
=2E<br><br>Only buffer=2Ec is built with the flag for now, since most other=
 files and<br>some system and library headers are not annotated yet=2E CMak=
e sets it as<br>a source file property, so it also applies to the unit test=
s that build<br>buffer=2Ec=2E Automake builds buffer=2Ec as a small conveni=
ence library with<br>its own CFLAGS=2E<br><br>compat=2Eh uses &lt;ptrcheck=
=2Eh&gt; when it is available, since some system<br>headers include it unco=
nditionally, and only defines no-op fallbacks<br>for annotations that are s=
till undefined=2E<br><br>The annotations used on non-static declarations (_=
_sized_by,<br>__counted_by, __null_terminated, __unsafe_indexable) do not c=
hange the<br>representation of pointers, so buffer=2Eo is ABI compatible wi=
th code<br>built without -fbounds-safety=2E The wide __bidi_indexable point=
ers are<br>only used as return types of static inline helpers=2E<br><br>The=
 free function callback of gc_addspecial() takes a<br>void *__unsafe_indexa=
ble, which matches how the macOS SDK declares<br>free(), so free() can be p=
assed without a cast=2E<br><br>glibc&#39;s string=2Eh is not annotated, so =
buf_extract_field() turns the<br>result of memchr() into a checked pointer =
to the one matching byte with<br>__unsafe_forge_bidi_indexable(); compat=2E=
h gets a no-op fallback for it=2E<br>With that, --enable-fbounds-safety bui=
lds and passes the unit tests on<br>Linux/glibc as well as on macOS=2E<br><=
br>Change-Id: Ib57d973a2f8ef48c3710f7d034da1a91c64d4755<br>Signed-off-by: J=
eff Bindel &lt;jeff@incrediblybased=2Eco&gt;<br>---<br>M =2Eclang-format<br=
>M CMakeLists=2Etxt<br>M configure=2Eac<br>M src/compat/compat=2Eh<br>M src=
/openvpn/Makefile=2Eam<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=
=2Eh<br>7 files changed, 169 insertions(+), 78 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/35/2035/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/=2Eclang-format b/=2Eclang-format</span><b=
r><span>index 23d224b=2E=2E312b6d3 100644</span><br><span>--- a/=2Eclang-fo=
rmat</span><br><span>+++ b/=2Eclang-format</span><br><span>@@ -17,6 +17,7 @=
@</span><br><span> AllowShortFunctionsOnASingleLine: None</span><br><span> =
AllowShortIfStatementsOnASingleLine: Never</span><br><span> AllowShortLoops=
OnASingleLine: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+AttributeMacros: [__counted_by, __counted_by_or_null, __sized_by, __sized_=
by_or_null]</span><br><span> BinPackArguments: true</span><br><span> BinPac=
kParameters: true</span><br><span> BreakAfterReturnType: AllDefinitions</sp=
an><br><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><sp=
an>index 50b2d68=2E=2Ec045b62 100644</span><br><span>--- a/CMakeLists=2Etxt=
</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -43,6 +43,8 @@</=
span><br><span> option(ENABLE_DEBUG &quot;Enable building with debug&quot; =
OFF)</span><br><span> </span><br><span> option(ENABLE_DNS_UPDOWN_BY_DEFAULT=
 &quot;Run --dns-updown hook by default&quot; ON)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+option(ENABLE_FBOUNDS_SAFETY &quot;Enable experimental Clang -fb=
ounds-safety annotations (OFF by default)&quot; OFF)</span><br><span> set(D=
NS_UPDOWN_PATH &quot;${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown&quo=
t; CACHE STRING &quot;Default location for the DNS up/down script&quot;)</s=
pan><br><span> </span><br><span> set(PLUGIN_DIR &quot;${CMAKE_INSTALL_PREFI=
X}/lib/openvpn/plugins&quot; CACHE FILEPATH &quot;Location of the plugin di=
rectory&quot;)</span><br><span>@@ -647,6 +649,15 @@</span><br><span>     sr=
c/openvpn/xkey_provider=2Ec</span><br><span>     )</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+if (ENABLE_FBOUNDS_SAFETY)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Only buffer=
=2Ec is built with -fbounds-safety for now=2E This applies to</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    # every target in this direct=
ory that compiles it, including unit tests=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    set_source_files_properties(src/openvpn/buffe=
r=2Ec PROPERTIES</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     COMPILE_OPTIONS -fbounds-safety</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        COMPILE_DEFINITIONS OVPN_SUPPORT_FBOUNDS_SAFETY</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> add_executable(openvpn =
${SOURCE_FILES})</span><br><span> </span><br><span> add_library_deps(openvp=
n)</span><br><span>diff --git a/configure=2Eac b/configure=2Eac</span><br><=
span>index 585c3bd=2E=2Ef6df994 100644</span><br><span>--- a/configure=2Eac=
</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -1355,6 +1355,15 @=
@</span><br><span> AC_SUBST([tmpfilesdir])</span><br><span> </span><br><spa=
n> AC_ARG_ENABLE(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	[=
fbounds-safety],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	[A=
S_HELP_STRING([--enable-fbounds-safety],</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	                [enable experimental Clang -fbounds-s=
afety annotations @&lt;:@default=3Dno@:&gt;@])],</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	[enable_fbounds_safety=3D&quot;$enableval&quo=
t;],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	[enable_fbound=
s_safety=3D&quot;no&quot;]</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AM_CONDITIO=
NAL([ENABLE_FBOUNDS_SAFETY], [test &quot;${enable_fbounds_safety}&quot; =3D=
 &quot;yes&quot;])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_ARG_ENABLE(</span=
><br><span>      [unit-tests],</span><br><span>      [AS_HELP_STRING([--dis=
able-unit-tests],</span><br><span>                      [Disables building =
and running the unit tests suite])],</span><br><span>diff --git a/src/compa=
t/compat=2Eh b/src/compat/compat=2Eh</span><br><span>index 4ee9141=2E=2E4b2=
64f8 100644</span><br><span>--- a/src/compat/compat=2Eh</span><br><span>+++=
 b/src/compat/compat=2Eh</span><br><span>@@ -75,4 +75,56 @@</span><br><span=
> strtok_r(char *s, const char *delim, char **last);</span><br><span> #endi=
f</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Optional Clang=
 -fbounds-safety annotations=2E &lt;ptrcheck=2Eh&gt; turns them into</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * no-ops when -fbounds-sa=
fety is not enabled, and some system headers include</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * it unconditionally, so prefer it when =
available and only fall back to our</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * own no-op definitions for annotations that are still und=
efined=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(OVPN_SUPPORT_F=
BOUNDS_SAFETY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &lt;ptrcheck=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#elif defined(__has_include)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if __has_include(&lt;ptrcheck=2Eh&gt;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;ptrcheck=2Eh&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifndef __sized_by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine __sized_by(n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef __siz=
ed_by_or_null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e __sized_by_or_null(n)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _=
_counted_by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
__counted_by(n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef __counted=
_by_or_null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
__counted_by_or_null(n)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _=
_null_terminated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine __null_terminated</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef __=
unsafe_indexable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine __unsafe_indexable</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _=
_unsafe_forge_single</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define __unsafe_forge_single(T, P) ((T)(P))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifndef __unsafe_forge_bidi_indexable</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define __unsafe_forge_bidi_indexable(T, P, =
S) ((T)(P))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef __null_termin=
ated_to_indexable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine __null_terminated_to_indexable(P) (P)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifndef __unsafe_null_terminated_to_indexable</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define __unsafe_null_terminated_to_in=
dexable(P) (P)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef __unsafe_n=
ull_terminated_from_indexable</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define __unsafe_null_terminated_from_indexable(P) (P)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* not defined by &lt;ptrcheck=2Eh&gt; wi=
thout -fbounds-safety as it changes the ABI */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifndef __bidi_indexable</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define __bidi_indexable</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> #endif /* COMPAT_H */</span><br=
><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</=
span><br><span>index be1044d=2E=2E8c34580 100644</span><br><span>--- a/src/=
openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span=
><br><span>@@ -50,7 +50,7 @@</span><br><span> 	auth_token=2Ec auth_token=2E=
h \</span><br><span> 	base64=2Ec base64=2Eh \</span><br><span> 	basic=2Eh \=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	buffer=2Ec buffer=2E=
h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	buffer=2Eh \</s=
pan><br><span> 	check_file_access=2Ec check_file_access=2Eh \</span><br><sp=
an> 	circ_list=2Eh \</span><br><span> 	clinat=2Ec clinat=2Eh \</span><br><s=
pan>@@ -163,7 +163,17 @@</span><br><span> 	win32=2Eh win32=2Ec \</span><br>=
<span> 	win32-util=2Eh win32-util=2Ec \</span><br><span> 	cryptoapi=2Eh cry=
ptoapi=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn_LDA=
DD =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if ENABLE_F=
BOUNDS_SAFETY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Only=
 buffer=2Ec is built with -fbounds-safety for now</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+noinst_LTLIBRARIES =3D libbuffer=2Ela</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+libbuffer_la_SOURCES =3D bu=
ffer=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+libbuffer_l=
a_CFLAGS =3D $(AM_CFLAGS) -fbounds-safety -DOVPN_SUPPORT_FBOUNDS_SAFETY</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_LDADD =3D libbu=
ffer=2Ela</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_SOURCES +=3D buff=
er=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_LDADD=
 =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_LDADD +=3D \</span><b=
r><span> 	$(top_builddir)/src/compat/libcompat=2Ela \</span><br><span> 	$(S=
OCKETS_LIBS) \</span><br><span> 	$(OPTIONAL_LIBCAPNG_LIBS) \</span><br><spa=
n>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><s=
pan>index c33a987=2E=2E62ce0fe 100644</span><br><span>--- a/src/openvpn/buf=
fer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -27=
6,7 +276,7 @@</span><br><span>         size_t len =3D strlen(str) + 1;</spa=
n><br><span>         if (buf_size_valid(len) &amp;&amp; len &lt; buf_forwar=
d_capacity_total(buf))</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            memcpy(buf-&gt;data + buf-&gt;capac=
ity - len, str, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            memcpy(buf-&gt;data + buf-&gt;capacity - len, __unsafe_null_t=
erminated_to_indexable(str), len);</span><br><span>         }</span><br><sp=
an>     }</span><br><span> }</span><br><span>@@ -317,7 +317,7 @@</span><br>=
<span>  * Garbage collection</span><br><span>  */</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void *__sized_by(size)</span><br><span> g=
c_malloc(size_t size, bool clear, struct gc_arena *a)</span><br><span> {</s=
pan><br><span>     void *ret;</span><br><span>@@ -411,7 +411,7 @@</span><br=
><span> }</span><br><span> </span><br><span> void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-gc_addspecial(void *addr, void (*free_function)=
(void *), struct gc_arena *a)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+gc_addspecial(void *addr, void (*free_function)(void *__unsafe_in=
dexable), struct gc_arena *a)</span><br><span> {</span><br><span>     ASSER=
T(a);</span><br><span>     struct gc_entry_special *e;</span><br><span>@@ -=
457,7 +457,7 @@</span><br><span>  */</span><br><span> </span><br><span> cha=
r *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-format_hex_ex(cons=
t uint8_t *data, size_t size, size_t maxoutput, unsigned int space_break_fl=
ags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+format_hex_ex(c=
onst uint8_t *__counted_by(size) data, size_t size, size_t maxoutput, unsig=
ned int space_break_flags,</span><br><span>               const char *separ=
ator, struct gc_arena *gc)</span><br><span> {</span><br><span>     const si=
ze_t bytes_per_hexblock =3D space_break_flags &amp; FHE_SPACE_BREAK_MASK;</=
span><br><span>@@ -593,7 +593,7 @@</span><br><span>  * Remove trailing \r a=
nd \n chars=2E</span><br><span>  */</span><br><span> void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-chomp(char *str)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+chomp(char *__null_terminated str)</span>=
<br><span> {</span><br><span>     rm_trailing_chars(str, &quot;\r\n&quot;);=
</span><br><span> }</span><br><span>@@ -602,19 +602,20 @@</span><br><span> =
 * Remove trailing chars</span><br><span>  */</span><br><span> void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-rm_trailing_chars(char *str, =
const char *what_to_delete)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+rm_trailing_chars(char *__null_terminated str, const char *what_to_=
delete)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char *cp =3D __null_terminated_to_indexable(str);</span><br><spa=
n>     size_t len =3D strlen(str);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    while (len &gt; 0 &amp;&amp; strchr(what_to_delete, str[le=
n - 1]) !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   while (len &gt; 0 &amp;&amp; strchr(what_to_delete, cp[len - 1]) !=3D NU=
LL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        str[--len] =3D &#39;\0&#39;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cp[--len] =3D &#39;\0&#39;;</span><br><span> =
    }</span><br><span> }</span><br><span> </span><br><span> /*</span><br><s=
pan>  * Allocate a string</span><br><span>  */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-char *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+char *__null_terminated</span><br><span> string_alloc(const cha=
r *str, struct gc_arena *gc)</span><br><span> {</span><br><span>     if (st=
r)</span><br><span>@@ -635,8 +636,8 @@</span><br><span>             ret =3D=
 calloc(1, n);</span><br><span>             check_malloc_return(ret);</span=
><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        memcpy(ret, str, n);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return ret;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        memcpy(ret, __unsafe_null_terminated_to_indexable(str), n);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return __uns=
afe_null_terminated_from_indexable(ret);</span><br><span>     }</span><br><=
span>     else</span><br><span>     {</span><br><span>@@ -648,11 +649,11 @@=
</span><br><span>  * Erase all characters in a string</span><br><span>  */<=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
string_clear(char *str)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+string_clear(char *__null_terminated str)</span><br><span> {</span><br>=
<span>     if (str)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        secure_memzero(str, strlen(str));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        secure_memzero(__null_te=
rminated_to_indexable(str), strlen(str));</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span>@@ -660,7 +661,7 @@</span><br><s=
pan>  * Return the length of a string array</span><br><span>  */</span><br>=
<span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-string_arra=
y_len(const char **array)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+string_array_len(const char **__null_terminated array)</span><br><spa=
n> {</span><br><span>     int i =3D 0;</span><br><span>     if (array)</spa=
n><br><span>@@ -674,13 +675,13 @@</span><br><span> }</span><br><span> </spa=
n><br><span> char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pr=
int_argv(const char **p, struct gc_arena *gc, const unsigned int flags)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+print_argv(const char *=
*__null_terminated p, struct gc_arena *gc, const unsigned int flags)</span>=
<br><span> {</span><br><span>     struct buffer out =3D alloc_buf_gc(256, g=
c);</span><br><span>     int i =3D 0;</span><br><span>     for (; *p; ++p)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        const char *cp =3D *p;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const char *__null_terminated cp =3D *p;</span><br><spa=
n>         if (i)</span><br><span>         {</span><br><span>             b=
uf_printf(&amp;out, &quot; &quot;);</span><br><span>@@ -708,8 +709,8 @@</sp=
an><br><span> </span><br><span>     ASSERT(str);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    const char *copy =3D strin=
g_alloc(str, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
buf_set_read(&amp;buf, (const uint8_t *)copy, strlen(str) + 1);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char *__null_terminat=
ed copy =3D string_alloc(str, gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_set_read(&amp;buf, (const uint8_t *)__unsafe_null_te=
rminated_to_indexable(copy), strlen(str) + 1);</span><br><span> </span><br>=
<span>     if (buf=2Elen &gt; 0) /* Don&#39;t count trailing &#39;\0&#39; a=
s part of length */</span><br><span>     {</span><br><span>@@ -731,7 +732,7=
 @@</span><br><span>     {</span><br><span>         return false;</span><br=
><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn memcmp(CBPTR(src), match, size) =3D=3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return memcmp(CBPTR(src), __null_terminated_to=
_indexable(match), size) =3D=3D 0;</span><br><span> }</span><br><span> </sp=
an><br><span> #if defined(__GNUC__) || defined(__clang__)</span><br><span>@=
@ -780,7 +781,7 @@</span><br><span>  */</span><br><span> </span><br><span> =
bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_parse(struct =
buffer *buf, const int delim, char *line, const int size)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+buf_parse(struct buffer *buf, const i=
nt delim, char *__counted_by(size) line, const int size)</span><br><span> {=
</span><br><span>     bool eol =3D false;</span><br><span>     int n =3D 0;=
</span><br><span>@@ -1018,12 +1019,13 @@</span><br><span>  * Guaranteed to =
not increase string length=2E</span><br><span>  */</span><br><span> bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-string_mod(char *str, co=
nst unsigned int inclusive, const unsigned int exclusive,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+string_mod(char *__null_terminated st=
r, const unsigned int inclusive, const unsigned int exclusive,</span><br><s=
pan>            const char replace)</span><br><span> {</span><br><span>    =
 ASSERT(str);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    char *out =3D str;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* the terminator is rewritten in place, so it needs to be=
 within bounds */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  char *out =3D __unsafe_null_terminated_to_indexable(str);</span><br><span=
>     const char *in =3D out;</span><br><span>     bool ret =3D true;</span=
><br><span> </span><br><span>@@ -1074,7 +1076,7 @@</span><br><span> {</span=
><br><span>     if (str)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        char *buf =3D string_alloc(str, gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *__null_ter=
minated buf =3D string_alloc(str, gc);</span><br><span>         string_mod(=
buf, inclusive, exclusive, replace);</span><br><span>         return buf;</=
span><br><span>     }</span><br><span>@@ -1085,7 +1087,7 @@</span><br><span=
> }</span><br><span> </span><br><span> void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-string_replace_leading(char *str, const char match, c=
onst char replace)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tring_replace_leading(char *__null_terminated str, const char match, const =
char replace)</span><br><span> {</span><br><span>     ASSERT(match !=3D &#3=
9;\0&#39;);</span><br><span>     while (*str)</span><br><span>@@ -1147,7 +1=
149,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-checked_snprintf(char *str, s=
ize_t size, const char *format, =2E=2E=2E)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+checked_snprintf(char *__counted_by(size) str, size_=
t size, const char *format, =2E=2E=2E)</span><br><span> {</span><br><span> =
    va_list arglist;</span><br><span>     va_start(arglist, format);</span>=
<br><span>@@ -1227,7 +1229,8 @@</span><br><span>     if (str)</span><br><sp=
an>     {</span><br><span>         const size_t len =3D strlen((const char =
*)str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct=
 buffer_entry *e =3D buffer_list_push_data(ol, str, len + 1);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        struct buffer_entry *e =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buff=
er_list_push_data(ol, __unsafe_null_terminated_to_indexable(str), len + 1);=
</span><br><span>         if (e)</span><br><span>         {</span><br><span=
>             e-&gt;buf=2Elen--; /* Don&#39;t count trailing &#39;\0&#39; a=
s part of length */</span><br><span>@@ -1236,7 +1239,7 @@</span><br><span> =
}</span><br><span> </span><br><span> struct buffer_entry *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-buffer_list_push_data(struct buffer_li=
st *ol, const void *data, size_t size)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+buffer_list_push_data(struct buffer_list *ol, const void=
 *__sized_by(size) data, size_t size)</span><br><span> {</span><br><span>  =
   struct buffer_entry *e =3D NULL;</span><br><span>     if (data)</span><b=
r><span>@@ -1311,7 +1314,7 @@</span><br><span>         {</span><br><span>  =
           struct buffer_entry *next =3D e-&gt;next;</span><br><span>      =
       buf_copy(&amp;f-&gt;buf, &amp;e-&gt;buf);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            buf_write(&amp;f-&gt;buf, sep, sep_l=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf=
_write(&amp;f-&gt;buf, __null_terminated_to_indexable(sep), sep_len);</span=
><br><span>             free_buf(&amp;e-&gt;buf);</span><br><span>         =
    free(e);</span><br><span>             e =3D next;</span><br><span>@@ -1=
386,7 +1389,7 @@</span><br><span>             bl =3D buffer_list_new();</sp=
an><br><span>             while (fgets(line, max_line_len, fp) !=3D NULL)</=
span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                buffer_list_push(bl, line);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                buffer_list_push(bl, __un=
safe_null_terminated_from_indexable(line));</span><br><span>             }<=
/span><br><span>             free(line);</span><br><span>         }</span><=
br><span>@@ -1436,7 +1439,9 @@</span><br><span>         return NULL;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    const uint8_t *seppos =3D memchr(CBPTR(buf), sep, buf_len(=
buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* glibc =
does not annotate memchr(); the result points at one byte of buf */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *seppos =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        __unsafe=
_forge_bidi_indexable(const uint8_t *, memchr(CBPTR(buf), sep, buf_len(buf)=
), 1);</span><br><span>     if (!seppos)</span><br><span>     {</span><br><=
span>         return NULL;</span><br><span>diff --git a/src/openvpn/buffer=
=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 32b49d3=2E=2E259380a 10=
0644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src=
/openvpn/buffer=2Eh</span><br><span>@@ -69,13 +69,14 @@</span><br><span>  *=
/</span><br><span> struct buffer</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int capacity;  /**&lt; Size in bytes of=
 memory allocated by</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   *   \c malloc()=2E */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int offset;    /**&lt; Offset in bytes of the actual=
 content</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       *   within the allocated memory=2E */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    int len;       /**&lt; Length in bytes of the ac=
tual content</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           *   within the allocated memory=2E */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    uint8_t *data; /**&lt; Pointer to the alloca=
ted memory=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int capacity; /**&lt; Size in bytes of memory allocated by</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                   *   \c malloc()=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int offse=
t;   /**&lt; Offset in bytes of the actual content</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                   *   within the allocated =
memory=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 len;      /**&lt; Length in bytes of the actual content</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                   *   within the allo=
cated memory=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /** Pointer to the allocated memory=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    uint8_t *__sized_by_or_null(capacity) data;</s=
pan><br><span> </span><br><span> #ifdef BUF_INIT_TRACKING</span><br><span> =
    const char *debug_file;</span><br><span>@@ -108,7 +109,7 @@</span><br><=
span> struct gc_entry_special</span><br><span> {</span><br><span>     struc=
t gc_entry_special *next;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    void (*free_fnc)(void *);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    void (*free_fnc)(void *__unsafe_indexable);</span><br><sp=
an>     void *addr;</span><br><span> };</span><br><span> </span><br><span>@=
@ -199,7 +200,7 @@</span><br><span>  *</span><br><span>  * @param str   The=
 string to clear=2E</span><br><span>  */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void string_clear(char *str);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void string_clear(char *__null_terminated str)=
;</span><br><span> </span><br><span> /**</span><br><span>  * Return the num=
ber of elements in a NULL-terminated array of strings=2E</span><br><span>@@=
 -208,7 +209,7 @@</span><br><span>  *</span><br><span>  * @return Number of=
 non-NULL elements=2E</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-int string_array_len(const char **array);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+int string_array_len(const char =
**__null_terminated array);</span><br><span> </span><br><span> /**</span><b=
r><span>  * Safely compute the product of two sizes plus an extra amount=2E=
</span><br><span>@@ -236,7 +237,7 @@</span><br><span>  *</span><br><span>  =
* @return Newly allocated string representation of \c p=2E</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-char *print_argv(=
const char **p, struct gc_arena *gc, const unsigned int flags);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+char *print_argv(const char **_=
_null_terminated p, struct gc_arena *gc, const unsigned int flags);</span><=
br><span> </span><br><span> /**</span><br><span>  * Report a buffer size er=
ror and abort=2E</span><br><span>@@ -299,7 +300,7 @@</span><br><span>  *</s=
pan><br><span>  * @return Pointer to the newly allocated memory=2E</span><b=
r><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void *gc_=
malloc(size_t size, bool clear, struct gc_arena *a);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void *__sized_by(size) gc_malloc(size_t s=
ize, bool clear, struct gc_arena *a);</span><br><span> </span><br><span> /*=
*</span><br><span>  * Duplicate a string, allocating memory under garbage c=
ollection=2E</span><br><span>@@ -311,7 +312,7 @@</span><br><span>  *</span>=
<br><span>  * @return A newly allocated copy of \c str, or NULL if \c str i=
s NULL=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-char *string_alloc(const char *str, struct gc_arena *gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+char *__null_terminated stri=
ng_alloc(const char *str, struct gc_arena *gc);</span><br><span> </span><br=
><span> /**</span><br><span>  * Allocate a buffer containing a copy of the =
given string=2E</span><br><span>@@ -337,10 +338,12 @@</span><br><span>  * s=
omething other than plain \c free(), such as \c freeaddrinfo()=2E</span><br=
><span>  *</span><br><span>  * @param addr          Pointer to the memory t=
o register=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @para=
m free_function Function to call to free \c addr=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param free_function Function to call =
to free \c addr=2E  The parameter is</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *                      \c __unsafe_indexable so that \c f=
ree() can be passed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *                      with -fbounds-safety=2E</span><br><span>  * @param =
a             Garbage collection arena to register with=2E</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void gc_addspecia=
l(void *addr, void (*free_function)(void *), struct gc_arena *a);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void gc_addspecial(void *addr=
, void (*free_function)(void *__unsafe_indexable), struct gc_arena *a);</sp=
an><br><span> </span><br><span> /**</span><br><span>  * allows to realloc a=
 pointer previously allocated by gc_malloc or gc_realloc</span><br><span>@@=
 -374,9 +377,9 @@</span><br><span>  * @param addr  Pointer to the \c struct=
 \c addrinfo to free=2E</span><br><span>  */</span><br><span> static inline=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gc_freeaddrinfo_=
callback(void *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+gc_freeaddrinfo_callback(void *__unsafe_indexable addr)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    freeaddrinfo((str=
uct addrinfo *)addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    freeaddrinfo(__unsafe_forge_single(struct addrinfo *, addr));</span><=
br><span> }</span><br><span> </span><br><span> /** Return an empty, undefin=
ed \c struct \c buffer (all fields zero)=2E */</span><br><span>@@ -424,7 +4=
27,7 @@</span><br><span>  * @return Pointer to \c buf-&gt;data + \c buf-&gt=
;offset, or NULL if \c buf is</span><br><span>  *         not valid=2E</spa=
n><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c inline const uint8_t *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static inline const uint8_t *__bidi_indexable</span><br><span> buf_cbp=
tr(const struct buffer *buf)</span><br><span> {</span><br><span>     if (bu=
f_valid(buf))</span><br><span>@@ -445,7 +448,7 @@</span><br><span>  * @retu=
rn Pointer to \c buf-&gt;data + \c buf-&gt;offset, or NULL if \c buf is</sp=
an><br><span>  *         not valid=2E</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static inline uint8_t *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static inline uint8_t *__bidi_inde=
xable</span><br><span> buf_bptr(struct buffer *buf)</span><br><span> {</spa=
n><br><span>     return (uint8_t *)buf_cbptr(buf);</span><br><span>@@ -478,=
7 +481,7 @@</span><br><span>  *</span><br><span>  * @return Pointer to the =
byte immediately after the last content byte=2E</span><br><span>  */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static inline uint8_t *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline uint8_t *_=
_bidi_indexable</span><br><span> buf_bend(struct buffer *buf)</span><br><sp=
an> {</span><br><span>     return buf_bptr(buf) + buf_len(buf);</span><br><=
span>@@ -491,7 +494,7 @@</span><br><span>  *</span><br><span>  * @return Po=
inter to the byte immediately after the last content byte=2E</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline c=
onst uint8_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c inline const uint8_t *__bidi_indexable</span><br><span> buf_cbend(const s=
truct buffer *buf)</span><br><span> {</span><br><span>     return buf_cbptr=
(buf) + buf_len(buf);</span><br><span>@@ -505,7 +508,7 @@</span><br><span> =
 * @return Pointer to the last byte, or NULL if the buffer is empty or</spa=
n><br><span>  *         invalid=2E</span><br><span>  */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static inline const uint8_t *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static inline const uint8_t *__=
bidi_indexable</span><br><span> buf_cblast(const struct buffer *buf)</span>=
<br><span> {</span><br><span>     if (buf_len(buf) &gt; 0)</span><br><span>=
@@ -526,7 +529,7 @@</span><br><span>  * @return Pointer to the last byte, o=
r NULL if the buffer is empty or</span><br><span>  *         invalid=2E</sp=
an><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic inline uint8_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static inline uint8_t *__bidi_indexable</span><br><span> buf_blast(struct b=
uffer *buf)</span><br><span> {</span><br><span>     return (uint8_t *)buf_c=
blast(buf);</span><br><span>@@ -568,7 +571,7 @@</span><br><span>  *</span><=
br><span>  * @return The content pointer as a \c char *, or NULL if \c buf =
is invalid=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static inline char *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static inline char *__bidi_indexable</span><br><span> buf_str=
(struct buffer *buf)</span><br><span> {</span><br><span>     return (char *=
)buf_bptr(buf);</span><br><span>@@ -581,7 +584,7 @@</span><br><span>  *</sp=
an><br><span>  * @return The content pointer as a \c const char *, or NULL =
if \c buf is invalid=2E</span><br><span>  */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static inline const char *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static inline const char *__bidi_indexable</s=
pan><br><span> buf_cstr(const struct buffer *buf)</span><br><span> {</span>=
<br><span>     return (const char *)buf_cbptr(buf);</span><br><span>@@ -655=
,7 +658,7 @@</span><br><span>  * @param size  Size of the memory region in =
bytes=2E</span><br><span>  */</span><br><span> static inline void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-buf_set_write(struct buffer *bu=
f, uint8_t *data, size_t size)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+buf_set_write(struct buffer *buf, uint8_t *__sized_by_or_null(si=
ze) data, size_t size)</span><br><span> {</span><br><span>     if (!buf_siz=
e_valid(size))</span><br><span>     {</span><br><span>@@ -684,7 +687,7 @@</=
span><br><span>  * @param size  Size of the memory region in bytes=2E</span=
><br><span>  */</span><br><span> static inline void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-buf_set_read(struct buffer *buf, const uint=
8_t *data, size_t size)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+buf_set_read(struct buffer *buf, const uint8_t *__sized_by_or_null(size=
) data, size_t size)</span><br><span> {</span><br><span>     if (!buf_size_=
valid(size))</span><br><span>     {</span><br><span>@@ -745,13 +748,13 @@</=
span><br><span>  * @param len   Length of data, in bytes=2E</span><br><span=
>  */</span><br><span> static inline void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-secure_memzero(void *data, size_t len)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+secure_memzero(void *__sized_by(len)=
 data, size_t len)</span><br><span> {</span><br><span> #if defined(_WIN32)<=
/span><br><span>     SecureZeroMemory(data, len);</span><br><span> #elif de=
fined(__GNUC__) || defined(__clang__)</span><br><span>     memset(data, 0, =
len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    __asm__ __vo=
latile__(&quot;&quot; : : &quot;r&quot;(data) : &quot;memory&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    __asm__ __volatile__(&=
quot;&quot; : : &quot;r&quot;(__unsafe_forge_single(void *, data)) : &quot;=
memory&quot;);</span><br><span> #else</span><br><span>     volatile char *p=
 =3D (volatile char *)data;</span><br><span>     while (len--)</span><br><s=
pan>@@ -836,7 +839,7 @@</span><br><span>  *</span><br><span>  * @param str =
  The null-terminated string to chomp=2E</span><br><span>  */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void chomp(char *str);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void chomp(char *__null_terminat=
ed str);</span><br><span> </span><br><span> /**</span><br><span>  * Remove =
all trailing characters that appear in a given set=2E</span><br><span>@@ -8=
44,7 +847,7 @@</span><br><span>  * @param str             The null-terminat=
ed string to modify in place=2E</span><br><span>  * @param what_to_delete  =
Null-terminated set of characters to strip=2E</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void rm_trailing_chars(char *s=
tr, const char *what_to_delete);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void rm_trailing_chars(char *__null_terminated str, const char=
 *what_to_delete);</span><br><span> </span><br><span> /**</span><br><span> =
 * Return a pointer past any leading whitespace in a string=2E</span><br><s=
pan>@@ -913,7 +916,7 @@</span><br><span>  *         extracted; true otherwi=
se (including when a delimiter was found</span><br><span>  *         or \c =
line was truncated)=2E</span><br><span>  */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-bool buf_parse(struct buffer *buf, const int delim, c=
har *line, const int size);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool buf_parse(struct buffer *buf, const int delim, char *__counted=
_by(size) line, const int size);</span><br><span> </span><br><span> /** @na=
me Hex Dump</span><br><span>  *  @brief Output a binary buffer to a hex str=
ing and return it=2E</span><br><span>@@ -941,7 +944,7 @@</span><br><span>  =
*</span><br><span>  * @return Null-terminated hex string allocated from \c =
gc=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-char *format_hex_ex(const uint8_t *data, size_t size, size_t maxoutput=
, unsigned int space_break_flags,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+char *format_hex_ex(const uint8_t *__counted_by(size) data, s=
ize_t size, size_t maxoutput, unsigned int space_break_flags,</span><br><sp=
an>                     const char *separator, struct gc_arena *gc);</span>=
<br><span> </span><br><span> /**</span><br><span>@@ -957,7 +960,7 @@</span>=
<br><span>  * @return Null-terminated hex string allocated from \c gc=2E</s=
pan><br><span>  */</span><br><span> static inline char *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-format_hex(const uint8_t *data, size_t s=
ize, size_t maxoutput, struct gc_arena *gc)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+format_hex(const uint8_t *__counted_by(size) data, =
size_t size, size_t maxoutput, struct gc_arena *gc)</span><br><span> {</spa=
n><br><span>     return format_hex_ex(data, size, maxoutput, 4, &quot; &quo=
t;, gc);</span><br><span> }</span><br><span>@@ -1138,7 +1141,7 @@</span><br=
><span>  * @return Pointer to the newly reserved space (new content start),=
 or NULL</span><br><span>  *         if \c buf is invalid or there is insuf=
ficient prepend capacity=2E</span><br><span>  */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static inline uint8_t *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static inline uint8_t *__bidi_indexable</spa=
n><br><span> buf_prepend(struct buffer *buf, ssize_t size)</span><br><span>=
 {</span><br><span>     if (!buf_valid(buf) || size &lt; 0 || size &gt; buf=
-&gt;offset)</span><br><span>@@ -1185,7 +1188,7 @@</span><br><span>  * @ret=
urn Pointer to the start of the reserved space, or NULL if there is</span><=
br><span>  *         insufficient capacity=2E</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static inline uint8_t *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static inline uint8_t *__b=
idi_indexable</span><br><span> buf_write_alloc(struct buffer *buf, size_t s=
ize)</span><br><span> {</span><br><span>     uint8_t *ret;</span><br><span>=
@@ -1210,7 +1213,7 @@</span><br><span>  * @return Pointer to the start of t=
he consumed region, or NULL if \c size</span><br><span>  *         is negat=
ive or exceeds the current length=2E</span><br><span>  */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static inline uint8_t *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline uint8_t *__bidi_index=
able</span><br><span> buf_read_alloc(struct buffer *buf, int size)</span><b=
r><span> {</span><br><span>     uint8_t *ret;</span><br><span>@@ -1236,7 +1=
239,7 @@</span><br><span>  * @return true on success, false if there is ins=
ufficient capacity=2E</span><br><span>  */</span><br><span> static inline b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_write(struct b=
uffer *dest, const void *src, size_t size)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+buf_write(struct buffer *dest, const void *__sized_b=
y(size) src, size_t size)</span><br><span> {</span><br><span>     uint8_t *=
cp =3D buf_write_alloc(dest, size);</span><br><span>     if (!cp)</span><br=
><span>@@ -1265,7 +1268,7 @@</span><br><span>  * @return true on success, f=
alse if there is insufficient prepend capacity=2E</span><br><span>  */</spa=
n><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-buf_write_prepend(struct buffer *dest, const void *src, int size)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_write_prepend(s=
truct buffer *dest, const void *__sized_by(size) src, int size)</span><br><=
span> {</span><br><span>     uint8_t *cp =3D buf_prepend(dest, size);</span=
><br><span>     if (!cp)</span><br><span>@@ -1453,7 +1456,7 @@</span><br><s=
pan>  * @return true on success, false if \c src has fewer than \c size byt=
es=2E</span><br><span>  */</span><br><span> static inline bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-buf_read(struct buffer *src, void =
*dest, int size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf=
_read(struct buffer *src, void *__sized_by(size) dest, int size)</span><br>=
<span> {</span><br><span>     const uint8_t *cp =3D buf_read_alloc(src, siz=
e);</span><br><span>     if (!cp)</span><br><span>@@ -1601,7 +1604,7 @@</sp=
an><br><span>  * *NOT* constant time=2E Do not use when comparing HMACs=2E<=
/span><br><span>  */</span><br><span> static inline bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-buf_string_match(const struct buffer *sr=
c, const void *match, int size)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+buf_string_match(const struct buffer *src, const void *__sized_=
by(size) match, int size)</span><br><span> {</span><br><span>     if (size =
!=3D src-&gt;len)</span><br><span>     {</span><br><span>@@ -1615,7 +1618,7=
 @@</span><br><span>  * *NOT* constant time=2E Do not use when comparing HM=
ACs=2E</span><br><span>  */</span><br><span> static inline bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-buf_string_match_head(const struc=
t buffer *src, const void *match, int size)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+buf_string_match_head(const struct buffer *src, con=
st void *__sized_by(size) match, int size)</span><br><span> {</span><br><sp=
an>     if (size &lt; 0 || size &gt; src-&gt;len)</span><br><span>     {</s=
pan><br><span>@@ -1758,7 +1761,7 @@</span><br><span>  * @param replace The =
character to replace the specified character classes with=2E</span><br><spa=
n>  * @return True if the string was not modified, false otherwise=2E</span=
><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool s=
tring_mod(char *str, const unsigned int inclusive, const unsigned int exclu=
sive,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool string_mo=
d(char *__null_terminated str, const unsigned int inclusive, const unsigned=
 int exclusive,</span><br><span>                 const char replace);</span=
><br><span> </span><br><span> </span><br><span>@@ -1802,7 +1805,7 @@</span>=
<br><span>  * @param match    The character to replace=2E</span><br><span> =
 * @param replace  The replacement character=2E</span><br><span>  */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void string_replace_leading(=
char *str, const char match, const char replace);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void string_replace_leading(char *__null_term=
inated str, const char match, const char replace);</span><br><span> </span>=
<br><span> /**</span><br><span>  * Return true iff \c str starts with \c pr=
efix=2E</span><br><span>@@ -1845,7 +1848,7 @@</span><br><span>  *</span><br=
><span>  * @return true if snprintf() was successful and not truncated=2E</=
span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bo=
ol checked_snprintf(char *str, size_t size, const char *format, =2E=2E=2E)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool checked_snprint=
f(char *__counted_by(size) str, size_t size, const char *format, =2E=2E=2E)=
</span><br><span> #ifdef __GNUC__</span><br><span> #if __USE_MINGW_ANSI_STD=
IO</span><br><span>     __attribute__((format(gnu_printf, 3, 4)))</span><br=
><span>@@ -2219,7 +2222,7 @@</span><br><span>  *</span><br><span>  * @retur=
n the new buffer</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-struct buffer_entry *buffer_list_push_data(struct buffer_li=
st *ol, const void *data, size_t size);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+struct buffer_entry *buffer_list_push_data(struct buffe=
r_list *ol, const void *__sized_by(size) data, size_t size);</span><br><spa=
n> </span><br><span> /**</span><br><span>  * Retrieve the head buffer</span=
><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2035?usp=3Demail">change 2035</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2035?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ib57d973a2f8ef48c3710f7d034da1a91c6=
4d4755 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2035 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Laptops &lt;jeff@incrediblybased=2Eco&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>

</body></html>
--8XHXv2bZ/z4=--


--===============4635831024097456908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4635831024097456908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4635831024097456908==--

