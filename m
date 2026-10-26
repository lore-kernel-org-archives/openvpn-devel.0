Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EDE606A31E
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OwEueyMq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PPjVU03a;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Cw6HQ7Lr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GIYhCqh/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=RflKW9ZAAiUWVCUQh17byhyWszk9cLqoG5otdt6KIzc=; b=OwEueyMqONxWQMvEAYJ1AgCd02
	LDN8qmJZ/B2L+zQhqOOROwXWL/ck8q+KDfyUxGjl6MByUWEwAEPFdksGb0AU0ZsR0oa8i3ATRrUd1
	HTEO2YWWxNZFwLLhx8GJDoRmHrTg1fPC2DcKhgr4lCXZYaq9evqsCk04b+O+1FkD3xFM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLNkM-0000000019S-1L8o;
	Mon, 26 Oct 2026 16:40:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLNkL-0000000019M-142L
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 16:40:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XPFv44Y0isXMrEO42q3j2O7wEIi5JlvhglG2roazlRQ=; b=PPjVU03aL+fJEPEsx8cZaTk0Fz
 OkBh0icdrqXBoRJYN0tUdfYpBYOf/egYApU8v7mNnX99FkjYoxp9G/J6mkLl6yswVsPriwyOvCRkx
 1G3xhGfvvD2qE9G3ApOsLV7ivgmXV1PvxPofr99Qo9IF0U9sXJIMwcdQvij3/YetqiAE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XPFv44Y0isXMrEO42q3j2O7wEIi5JlvhglG2roazlRQ=; b=Cw6HQ7LrHlaHuD7tQSF2JVCPC7
 86cWTy9kan9mnDsaGG9qRVJUOr2i5cojejHcfOyrmxMo2skG480sPAIOuhhZQTMbu7GXp7Daq2gYP
 z5D/HHBIjlNhJHjmLXL5lVujsWrVXSM/jfCPlRLaccb10EL0nPWz8ZLtZLbwg9zZNyDE=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLNkH-000000006x8-0tUt for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 16:40:29 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so15549755e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793032819; x=1793637619; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XPFv44Y0isXMrEO42q3j2O7wEIi5JlvhglG2roazlRQ=;
 b=GIYhCqh/yHeN8T4ww043O2iYO1Hz8wO6WX4OMF3csVm1dtoB0E+j12DqQ4H4gXllka
 wzLjeB5FDuDtizsUjgBMYe7yqYK3TbE259SEk6THm/kRncq9NJ5ZYtn8CoXSlnKwGx/j
 8MUocY/ErxVfdWYQnDhepQEFqeU8WxroKbSrGl9pwZC4POpTfqk14obwWRgGgS7M+S46
 aL4U+7kMoeEv44vc57jBLJxEh6PcPfz/nH1OgTv29JtpFHwz+Px4jRZHt2ndhGxqc7Iv
 ijWUFeX4Mqh6wVAakLBeSd/s23Wp6Q6LusaO49hnofEAaj+ZnZHwVnvkvydnaKvDtXtK
 2bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032819; x=1793637619;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XPFv44Y0isXMrEO42q3j2O7wEIi5JlvhglG2roazlRQ=;
 b=kAgk+I+yg4imKqmhQM75dxN2Zm6CVYvWqO9HuX8gxSw1iFZQiou/ic1ivoYNgOKBxJ
 bUTYwAdGDDz7X572VOrFlpbgma52AhZjW9oc1OvsBjjGMSVjtYik5XmOHCGZvjU+SY35
 b4/aywvHntelW7AieeUsqQDgWUiQalN5qr4vLTw+5RBNXcAJgxVdQSa+EgI07QSscjys
 JwrHSa/q4PhK0+5vlmArcpNgZwQXJbKt195OUeZFDdQMWjCbcxRcKZhTI68r3Sm4ff9j
 vRxXKqB4yyeNyGNRg1Ltn/qSkyFFn+82Lk0yLRbbOen8K+ii6aVN4WbdW0hbRrtcfVfN
 dk0Q==
X-Gm-Message-State: AFq9FYKOlYNZBjsz0tvMqYBrFcqnqGyS3lga0HO9ZWA9WAjRwO6mzJzj
 qW38ehTsXxZr+cRUSDJJ9GdsofJvzqFW4lw9sf5cBZVGWuzeXbi5sBuTqZsDlAKWvz/5pfwjKte
 0JA4qil97ap413byEjuMKIXKAH0zl0QZnRb3c0OrTPj1+V3ZAhxlfW0ZllZ6R5i9CFqyGIL1mj3
 eLXpCfQA==
X-Gm-Gg: AYBFou1+hjVnBnKl6h9OU3K5Pn91vbTIsu4+urCxlC5/bIDjwut/s4VUzfvh+OmPAMa
 Pestd/uBtO+lfXqDoxxFsh5ZlGB3vubJYydzBbQjYiTJBv6+bj85y37I9vaCJKsT33H76LtYLtj
 8/QlN00VrSAoF/2WuU1dmYI0SnFCP+A22XBRcikXf8JhpQo9/wCbdDLsFg5xsJ0E7/qcOAYrgfr
 N+KPDIPrILCSkbhR8SR0QRKYcECgsoaFFsSQ86moF1BiIbpNvUjK32FzT+RxBpE/Ul8+h9aITRB
 zEvU68akR2tIiXzLgMXZYL6KZborWloVbM5Xt6ZSsRF+s1tK4HfTlQCRG1RUnLG4HWLjcY9Q0PF
 TeX2mbQ8uK+MfqmCTO1Q6+FPHFkb8Ssi5il64zTKG3P1kla8bKi/NyZ+LajkW97htNAaTgY63Fg
 arb7oafpAbQGh+nPMbcx8wbXdW9GcgQlBfsemlG1OvEiUNP7QlNfX9fwgWaLYjlSqOorMOJ8QEa
 Lutxr3JCkXDG+79cHI/1RUG+SkhL8UGEoxilxbH4Muuvnx1Vtl5Oi0AXOk9i+wyUtawYO+v29bx
 lyYFJGbfajTo98Aq5YaYPHBBNYynSsTjvZ9yhoUJxpJGDJGoTfkq1J1J6dkHtz8ya9zdBI49UDF
 9uUzdyPnuYIBMyqt10RAeg9xcakiHyNZNSWdPgI29Wg==
X-Received: by 2002:a05:600c:19d4:b0:4a2:c2b:a91b with SMTP id
 5b1f17b1804b1-4a35ac9114dmr126553235e9.10.1793032817949; 
 Mon, 26 Oct 2026 09:40:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2d6f6fsm199383175e9.12.2026.10.26.09.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 09:40:17 -0700 (PDT)
X-Google-Original-From: "Laptops (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 16:40:16 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib57d973a2f8ef48c3710f7d034da1a91c64d4755
X-Gerrit-Change-Number: 2035
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2035?usp=email>
X-Gerrit-Commit: 45f87821413653b51161c188436baf2526db6acb
References: <gerrit.1793032811000.Ib57d973a2f8ef48c3710f7d034da1a91c64d4755@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDMyODExMDAwLkliNTdkOTczYTJmOGVmNDhjMzcxMGY3ZDAzNGRhMWE5MWM2NGQ0NzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c952a546057c1ee8786d4680aff6df60dcf8fd05-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLNkH-000000006x8-0tUt
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
Content-Type: multipart/mixed; boundary="===============1103563021603155555=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1103563021603155555==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HBKnv9PU4eg="; charset=UTF-8

--HBKnv9PU4eg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2035?usp=3Demail

to review the following change=2E
=


Change subject: buffer: add optional -fbounds-safety annotations
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: add optiona=
l -fbounds-safety annotations

Add Clang -fbounds-safety annotations to str=
uct buffer and the buffer
API, and allow building buffer=2Ec with -fbounds-=
safety via
--enable-fbounds-safety (autotools) or -DENABLE_FBOUNDS_SAFETY=
=3DON
(CMake)=2E The option is off by default=2E

Only buffer=2Ec is built =
with the flag for now, since most other files and
some system and library h=
eaders are not annotated yet=2E CMake sets it as
a source file property, so=
 it also applies to the unit tests that build
buffer=2Ec=2E Automake builds=
 buffer=2Ec as a small convenience library with
its own CFLAGS=2E

compat=
=2Eh uses <ptrcheck=2Eh> when it is available, since some system
headers in=
clude it unconditionally, and only defines no-op fallbacks
for annotations =
that are still undefined=2E

The annotations used on non-static declaration=
s (__sized_by,
__counted_by, __null_terminated, __unsafe_indexable) do not =
change the
representation of pointers, so buffer=2Eo is ABI compatible with=
 code
built without -fbounds-safety=2E The wide __bidi_indexable pointers a=
re
only used as return types of static inline helpers=2E

The free function=
 callback of gc_addspecial() takes a
void *__unsafe_indexable, which matche=
s how the macOS SDK declares
free(), so free() can be passed without a cast=
=2E

Change-Id: Ib57d973a2f8ef48c3710f7d034da1a91c64d4755
Signed-off-by: Je=
ff Bindel <jeff@incrediblybased=2Eco>
---
M =2Eclang-format
M CMakeLists=2E=
txt
M configure=2Eac
M src/compat/compat=2Eh
M src/openvpn/Makefile=2Eam
M =
src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
7 files changed, 163 insert=
ions(+), 77 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/35/2035/1

diff --git a/=2Eclang-format b/=2Eclang-form=
at
index 23d224b=2E=2E312b6d3 100644
--- a/=2Eclang-format
+++ b/=2Eclang-f=
ormat
@@ -17,6 +17,7 @@
 AllowShortFunctionsOnASingleLine: None
 AllowShort=
IfStatementsOnASingleLine: Never
 AllowShortLoopsOnASingleLine: false
+Attr=
ibuteMacros: [__counted_by, __counted_by_or_null, __sized_by, __sized_by_or=
_null]
 BinPackArguments: true
 BinPackParameters: true
 BreakAfterReturnTy=
pe: AllDefinitions
diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 1=
84a95a=2E=2Ebd22587 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@=
 -43,6 +43,8 @@
 option(ENABLE_DEBUG "Enable building with debug" OFF)
 
 o=
ption(ENABLE_DNS_UPDOWN_BY_DEFAULT "Run --dns-updown hook by default" ON)
+=

+option(ENABLE_FBOUNDS_SAFETY "Enable experimental Clang -fbounds-safety a=
nnotations (OFF by default)" OFF)
 set(DNS_UPDOWN_PATH "${CMAKE_INSTALL_PRE=
FIX}/libexec/openvpn/dns-updown" CACHE STRING "Default location for the DNS=
 up/down script")
 
 set(PLUGIN_DIR "${CMAKE_INSTALL_PREFIX}/lib/openvpn/pl=
ugins" CACHE FILEPATH "Location of the plugin directory")
@@ -646,6 +648,15=
 @@
     src/openvpn/xkey_provider=2Ec
     )
 
+if (ENABLE_FBOUNDS_SAFETY)=

+    # Only buffer=2Ec is built with -fbounds-safety for now=2E This appli=
es to
+    # every target in this directory that compiles it, including uni=
t tests=2E
+    set_source_files_properties(src/openvpn/buffer=2Ec PROPERTI=
ES
+        COMPILE_OPTIONS -fbounds-safety
+        COMPILE_DEFINITIONS OV=
PN_SUPPORT_FBOUNDS_SAFETY
+        )
+endif ()
+
 add_executable(openvpn ${=
SOURCE_FILES})
 
 add_library_deps(openvpn)
diff --git a/configure=2Eac b/c=
onfigure=2Eac
index 0ac61b4=2E=2E46b28f5 100644
--- a/configure=2Eac
+++ b/=
configure=2Eac
@@ -1329,6 +1329,15 @@
 AC_SUBST([tmpfilesdir])
 
 AC_ARG_EN=
ABLE(
+	[fbounds-safety],
+	[AS_HELP_STRING([--enable-fbounds-safety],
+	  =
              [enable experimental Clang -fbounds-safety annotations @<:@de=
fault=3Dno@:>@])],
+	[enable_fbounds_safety=3D"$enableval"],
+	[enable_fbou=
nds_safety=3D"no"]
+)
+AM_CONDITIONAL([ENABLE_FBOUNDS_SAFETY], [test "${ena=
ble_fbounds_safety}" =3D "yes"])
+
+AC_ARG_ENABLE(
      [unit-tests],
    =
  [AS_HELP_STRING([--disable-unit-tests],
                      [Disables b=
uilding and running the unit tests suite])],
diff --git a/src/compat/compat=
=2Eh b/src/compat/compat=2Eh
index 4ee9141=2E=2E20abf19 100644
--- a/src/co=
mpat/compat=2Eh
+++ b/src/compat/compat=2Eh
@@ -75,4 +75,53 @@
 strtok_r(ch=
ar *s, const char *delim, char **last);
 #endif
 
+/*
+ * Optional Clang -f=
bounds-safety annotations=2E <ptrcheck=2Eh> turns them into
+ * no-ops when=
 -fbounds-safety is not enabled, and some system headers include
+ * it unc=
onditionally, so prefer it when available and only fall back to our
+ * own=
 no-op definitions for annotations that are still undefined=2E
+ */
+#if de=
fined(OVPN_SUPPORT_FBOUNDS_SAFETY)
+#include <ptrcheck=2Eh>
+#elif defined(=
__has_include)
+#if __has_include(<ptrcheck=2Eh>)
+#include <ptrcheck=2Eh>
=
+#endif
+#endif
+
+#ifndef __sized_by
+#define __sized_by(n)
+#endif
+#ifnd=
ef __sized_by_or_null
+#define __sized_by_or_null(n)
+#endif
+#ifndef __cou=
nted_by
+#define __counted_by(n)
+#endif
+#ifndef __counted_by_or_null
+#de=
fine __counted_by_or_null(n)
+#endif
+#ifndef __null_terminated
+#define __=
null_terminated
+#endif
+#ifndef __unsafe_indexable
+#define __unsafe_index=
able
+#endif
+#ifndef __unsafe_forge_single
+#define __unsafe_forge_single(=
T, P) ((T)(P))
+#endif
+#ifndef __null_terminated_to_indexable
+#define __n=
ull_terminated_to_indexable(P) (P)
+#endif
+#ifndef __unsafe_null_terminate=
d_to_indexable
+#define __unsafe_null_terminated_to_indexable(P) (P)
+#endi=
f
+#ifndef __unsafe_null_terminated_from_indexable
+#define __unsafe_null_t=
erminated_from_indexable(P) (P)
+#endif
+/* not defined by <ptrcheck=2Eh> w=
ithout -fbounds-safety as it changes the ABI */
+#ifndef __bidi_indexable
+=
#define __bidi_indexable
+#endif
+
 #endif /* COMPAT_H */
diff --git a/src/=
openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 8a60a94=2E=2E9a4e8b=
7 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@=
 -49,7 +49,7 @@
 	auth_token=2Ec auth_token=2Eh \
 	base64=2Ec base64=2Eh \=

 	basic=2Eh \
-	buffer=2Ec buffer=2Eh \
+	buffer=2Eh \
 	check_file_access=
=2Ec check_file_access=2Eh \
 	circ_list=2Eh \
 	clinat=2Ec clinat=2Eh \
@@=
 -162,7 +162,17 @@
 	win32=2Eh win32=2Ec \
 	win32-util=2Eh win32-util=2Ec =
\
 	cryptoapi=2Eh cryptoapi=2Ec
-openvpn_LDADD =3D \
+if ENABLE_FBOUNDS_SAF=
ETY
+# Only buffer=2Ec is built with -fbounds-safety for now
+noinst_LTLIBR=
ARIES =3D libbuffer=2Ela
+libbuffer_la_SOURCES =3D buffer=2Ec
+libbuffer_la=
_CFLAGS =3D $(AM_CFLAGS) -fbounds-safety -DOVPN_SUPPORT_FBOUNDS_SAFETY
+ope=
nvpn_LDADD =3D libbuffer=2Ela
+else
+openvpn_SOURCES +=3D buffer=2Ec
+openv=
pn_LDADD =3D
+endif
+openvpn_LDADD +=3D \
 	$(top_builddir)/src/compat/libc=
ompat=2Ela \
 	$(SOCKETS_LIBS) \
 	$(OPTIONAL_LIBCAPNG_LIBS) \
diff --git a=
/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 8813fa5=2E=2E1515ed7=
 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -272,7=
 +272,7 @@
         size_t len =3D strlen(str) + 1;
         if (buf_size_v=
alid(len) && (int)len < buf_forward_capacity_total(buf))
         {
-      =
      memcpy(buf->data + buf->capacity - len, str, len);
+            memcp=
y(buf->data + buf->capacity - len, __unsafe_null_terminated_to_indexable(st=
r), len);
         }
     }
 }
@@ -309,7 +309,7 @@
  * Garbage collection
 =
 */
 
-void *
+void *__sized_by(size)
 gc_malloc(size_t size, bool clear, s=
truct gc_arena *a)
 {
     void *ret;
@@ -403,7 +403,7 @@
 }
 
 void
-gc_ad=
dspecial(void *addr, void (*free_function)(void *), struct gc_arena *a)
+gc=
_addspecial(void *addr, void (*free_function)(void *__unsafe_indexable), st=
ruct gc_arena *a)
 {
     ASSERT(a);
     struct gc_entry_special *e;
@@ -4=
44,7 +444,7 @@
  */
 
 char *
-format_hex_ex(const uint8_t *data, size_t si=
ze, size_t maxoutput, unsigned int space_break_flags,
+format_hex_ex(const =
uint8_t *__counted_by(size) data, size_t size, size_t maxoutput, unsigned i=
nt space_break_flags,
               const char *separator, struct gc_arena=
 *gc)
 {
     const size_t bytes_per_hexblock =3D space_break_flags & FHE_S=
PACE_BREAK_MASK;
@@ -576,7 +576,7 @@
  * Remove trailing \r and \n chars=2E=

  */
 void
-chomp(char *str)
+chomp(char *__null_terminated str)
 {
     r=
m_trailing_chars(str, "\r\n");
 }
@@ -585,19 +585,20 @@
  * Remove trailing=
 chars
  */
 void
-rm_trailing_chars(char *str, const char *what_to_delete)=

+rm_trailing_chars(char *__null_terminated str, const char *what_to_delete=
)
 {
+    char *cp =3D __null_terminated_to_indexable(str);
     size_t len=
 =3D strlen(str);
-    while (len > 0 && strchr(what_to_delete, str[len - 1=
]) !=3D NULL)
+    while (len > 0 && strchr(what_to_delete, cp[len - 1]) !=
=3D NULL)
     {
-        str[--len] =3D '\0';
+        cp[--len] =3D '\0';=

     }
 }
 
 /*
  * Allocate a string
  */
-char *
+char *__null_terminate=
d
 string_alloc(const char *str, struct gc_arena *gc)
 {
     if (str)
@@ -=
618,8 +619,8 @@
             ret =3D calloc(1, n);
             check_mallo=
c_return(ret);
         }
-        memcpy(ret, str, n);
-        return ret=
;
+        memcpy(ret, __unsafe_null_terminated_to_indexable(str), n);
+   =
     return __unsafe_null_terminated_from_indexable(ret);
     }
     else
=
     {
@@ -631,11 +632,11 @@
  * Erase all characters in a string
  */
 voi=
d
-string_clear(char *str)
+string_clear(char *__null_terminated str)
 {
  =
   if (str)
     {
-        secure_memzero(str, strlen(str));
+        secu=
re_memzero(__null_terminated_to_indexable(str), strlen(str));
     }
 }
 
@=
@ -643,7 +644,7 @@
  * Return the length of a string array
  */
 int
-strin=
g_array_len(const char **array)
+string_array_len(const char **__null_termi=
nated array)
 {
     int i =3D 0;
     if (array)
@@ -657,13 +658,13 @@
 }
=
 
 char *
-print_argv(const char **p, struct gc_arena *gc, const unsigned i=
nt flags)
+print_argv(const char **__null_terminated p, struct gc_arena *gc=
, const unsigned int flags)
 {
     struct buffer out =3D alloc_buf_gc(256,=
 gc);
     int i =3D 0;
     for (; *p; ++p)
     {
-        const char *cp=
 =3D *p;
+        const char *__null_terminated cp =3D *p;
         if (i)
=
         {
             buf_printf(&out, " ");
@@ -691,8 +692,8 @@
 
     A=
SSERT(str);
 
-    const char *copy =3D string_alloc(str, gc);
-    buf_set=
_read(&buf, (const uint8_t *)copy, strlen(str) + 1);
+    const char *__nul=
l_terminated copy =3D string_alloc(str, gc);
+    buf_set_read(&buf, (const=
 uint8_t *)__unsafe_null_terminated_to_indexable(copy), strlen(str) + 1);
 =

     if (buf=2Elen > 0) /* Don't count trailing '\0' as part of length */
=
     {
@@ -714,7 +715,7 @@
     {
         return false;
     }
-    return=
 memcmp(CBPTR(src), match, size) =3D=3D 0;
+    return memcmp(CBPTR(src), _=
_null_terminated_to_indexable(match), size) =3D=3D 0;
 }
 
 bool
@@ -754,7 =
+755,7 @@
  */
 
 bool
-buf_parse(struct buffer *buf, const int delim, char=
 *line, const int size)
+buf_parse(struct buffer *buf, const int delim, cha=
r *__counted_by(size) line, const int size)
 {
     bool eol =3D false;
   =
  int n =3D 0;
@@ -983,12 +984,13 @@
  * Guaranteed to not increase string =
length=2E
  */
 bool
-string_mod(char *str, const unsigned int inclusive, c=
onst unsigned int exclusive,
+string_mod(char *__null_terminated str, const=
 unsigned int inclusive, const unsigned int exclusive,
            const ch=
ar replace)
 {
     ASSERT(str);
 
-    char *out =3D str;
+    /* the term=
inator is rewritten in place, so it needs to be within bounds */
+    char =
*out =3D __unsafe_null_terminated_to_indexable(str);
     const char *in =
=3D out;
     bool ret =3D true;
 
@@ -1039,7 +1041,7 @@
 {
     if (str)
 =
    {
-        char *buf =3D string_alloc(str, gc);
+        char *__null_t=
erminated buf =3D string_alloc(str, gc);
         string_mod(buf, inclusive=
, exclusive, replace);
         return buf;
     }
@@ -1050,7 +1052,7 @@
 }=

 
 void
-string_replace_leading(char *str, const char match, const char re=
place)
+string_replace_leading(char *__null_terminated str, const char matc=
h, const char replace)
 {
     ASSERT(match !=3D '\0');
     while (*str)
@=
@ -1112,7 +1114,7 @@
 }
 
 bool
-checked_snprintf(char *str, size_t size, c=
onst char *format, =2E=2E=2E)
+checked_snprintf(char *__counted_by(size) st=
r, size_t size, const char *format, =2E=2E=2E)
 {
     va_list arglist;
   =
  va_start(arglist, format);
@@ -1192,7 +1194,8 @@
     if (str)
     {
   =
      const size_t len =3D strlen((const char *)str);
-        struct buffe=
r_entry *e =3D buffer_list_push_data(ol, str, len + 1);
+        struct buf=
fer_entry *e =3D
+            buffer_list_push_data(ol, __unsafe_null_termi=
nated_to_indexable(str), len + 1);
         if (e)
         {
             =
e->buf=2Elen--; /* Don't count trailing '\0' as part of length */
@@ -1201,=
7 +1204,7 @@
 }
 
 struct buffer_entry *
-buffer_list_push_data(struct buff=
er_list *ol, const void *data, size_t size)
+buffer_list_push_data(struct b=
uffer_list *ol, const void *__sized_by(size) data, size_t size)
 {
     str=
uct buffer_entry *e =3D NULL;
     if (data)
@@ -1271,7 +1274,7 @@
        =
 {
             struct buffer_entry *next =3D e->next;
             buf_cop=
y(&f->buf, &e->buf);
-            buf_write(&f->buf, sep, sep_len);
+      =
      buf_write(&f->buf, __null_terminated_to_indexable(sep), sep_len);
   =
          free_buf(&e->buf);
             free(e);
             e =3D next;=

@@ -1337,7 +1340,7 @@
             bl =3D buffer_list_new();
             =
while (fgets(line, max_line_len, fp) !=3D NULL)
             {
-           =
     buffer_list_push(bl, line);
+                buffer_list_push(bl, __un=
safe_null_terminated_from_indexable(line));
             }
             fre=
e(line);
         }
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffe=
r=2Eh
index 7af4444=2E=2Ebf8d02c 100644
--- a/src/openvpn/buffer=2Eh
+++ b/=
src/openvpn/buffer=2Eh
@@ -69,13 +69,14 @@
  */
 struct buffer
 {
-    int =
capacity;  /**< Size in bytes of memory allocated by
-                    *=
   \c malloc()=2E */
-    int offset;    /**< Offset in bytes of the actual=
 content
-                    *   within the allocated memory=2E */
-    in=
t len;       /**< Length in bytes of the actual content
-                  =
  *   within the allocated memory=2E */
-    uint8_t *data; /**< Pointer to=
 the allocated memory=2E */
+    int capacity; /**< Size in bytes of memory=
 allocated by
+                   *   \c malloc()=2E */
+    int offset;   =
/**< Offset in bytes of the actual content
+                   *   within t=
he allocated memory=2E */
+    int len;      /**< Length in bytes of the ac=
tual content
+                   *   within the allocated memory=2E */
+   =
 /** Pointer to the allocated memory=2E */
+    uint8_t *__sized_by_or_null=
(capacity) data;
 
 #ifdef BUF_INIT_TRACKING
     const char *debug_file;
@=
@ -108,7 +109,7 @@
 struct gc_entry_special
 {
     struct gc_entry_special=
 *next;
-    void (*free_fnc)(void *);
+    void (*free_fnc)(void *__unsafe=
_indexable);
     void *addr;
 };
 
@@ -199,7 +200,7 @@
  *
  * @param str =
  The string to clear=2E
  */
-void string_clear(char *str);
+void string_c=
lear(char *__null_terminated str);
 
 /**
  * Return the number of elements=
 in a NULL-terminated array of strings=2E
@@ -208,7 +209,7 @@
  *
  * @retu=
rn Number of non-NULL elements=2E
  */
-int string_array_len(const char **a=
rray);
+int string_array_len(const char **__null_terminated array);
 
 /**
=
  * Safely compute the product of two sizes plus an extra amount=2E
@@ -236=
,7 +237,7 @@
  *
  * @return Newly allocated string representation of \c p=
=2E
  */
-char *print_argv(const char **p, struct gc_arena *gc, const unsig=
ned int flags);
+char *print_argv(const char **__null_terminated p, struct =
gc_arena *gc, const unsigned int flags);
 
 /**
  * Report a buffer size er=
ror and abort=2E
@@ -299,7 +300,7 @@
  *
  * @return Pointer to the newly a=
llocated memory=2E
  */
-void *gc_malloc(size_t size, bool clear, struct gc=
_arena *a);
+void *__sized_by(size) gc_malloc(size_t size, bool clear, stru=
ct gc_arena *a);
 
 /**
  * Duplicate a string, allocating memory under gar=
bage collection=2E
@@ -311,7 +312,7 @@
  *
  * @return A newly allocated co=
py of \c str, or NULL if \c str is NULL=2E
  */
-char *string_alloc(const c=
har *str, struct gc_arena *gc);
+char *__null_terminated string_alloc(const=
 char *str, struct gc_arena *gc);
 
 /**
  * Allocate a buffer containing a=
 copy of the given string=2E
@@ -337,10 +338,12 @@
  * something other than=
 plain \c free(), such as \c freeaddrinfo()=2E
  *
  * @param addr         =
 Pointer to the memory to register=2E
- * @param free_function Function to =
call to free \c addr=2E
+ * @param free_function Function to call to free \=
c addr=2E  The parameter is
+ *                      \c __unsafe_indexable =
so that \c free() can be passed
+ *                      with -fbounds-safe=
ty=2E
  * @param a             Garbage collection arena to register with=2E=

  */
-void gc_addspecial(void *addr, void (*free_function)(void *), struct=
 gc_arena *a);
+void gc_addspecial(void *addr, void (*free_function)(void *=
__unsafe_indexable), struct gc_arena *a);
 
 /**
  * allows to realloc a po=
inter previously allocated by gc_malloc or gc_realloc
@@ -374,9 +377,9 @@
 =
 * @param addr  Pointer to the \c struct \c addrinfo to free=2E
  */
 stati=
c inline void
-gc_freeaddrinfo_callback(void *addr)
+gc_freeaddrinfo_callba=
ck(void *__unsafe_indexable addr)
 {
-    freeaddrinfo((struct addrinfo *)a=
ddr);
+    freeaddrinfo(__unsafe_forge_single(struct addrinfo *, addr));
 }=

 
 /** Return an empty, undefined \c struct \c buffer (all fields zero)=2E=
 */
@@ -424,7 +427,7 @@
  * @return Pointer to \c buf->data + \c buf->offse=
t, or NULL if \c buf is
  *         not valid=2E
  */
-static inline const =
uint8_t *
+static inline const uint8_t *__bidi_indexable
 buf_cbptr(const s=
truct buffer *buf)
 {
     if (buf_valid(buf))
@@ -445,7 +448,7 @@
  * @ret=
urn Pointer to \c buf->data + \c buf->offset, or NULL if \c buf is
  *     =
    not valid=2E
  */
-static inline uint8_t *
+static inline uint8_t *__bi=
di_indexable
 buf_bptr(struct buffer *buf)
 {
     return (uint8_t *)buf_cb=
ptr(buf);
@@ -478,7 +481,7 @@
  *
  * @return Pointer to the byte immediate=
ly after the last content byte=2E
  */
-static inline uint8_t *
+static inl=
ine uint8_t *__bidi_indexable
 buf_bend(struct buffer *buf)
 {
     return =
buf_bptr(buf) + buf_len(buf);
@@ -491,7 +494,7 @@
  *
  * @return Pointer t=
o the byte immediately after the last content byte=2E
  */
-static inline c=
onst uint8_t *
+static inline const uint8_t *__bidi_indexable
 buf_cbend(co=
nst struct buffer *buf)
 {
     return buf_cbptr(buf) + buf_len(buf);
@@ -5=
05,7 +508,7 @@
  * @return Pointer to the last byte, or NULL if the buffer =
is empty or
  *         invalid=2E
  */
-static inline const uint8_t *
+sta=
tic inline const uint8_t *__bidi_indexable
 buf_cblast(const struct buffer =
*buf)
 {
     if (buf_len(buf) > 0)
@@ -526,7 +529,7 @@
  * @return Pointer=
 to the last byte, or NULL if the buffer is empty or
  *         invalid=2E=

  */
-static inline uint8_t *
+static inline uint8_t *__bidi_indexable
 bu=
f_blast(struct buffer *buf)
 {
     return (uint8_t *)buf_cblast(buf);
@@ -=
568,7 +571,7 @@
  *
  * @return The content pointer as a \c char *, or NULL=
 if \c buf is invalid=2E
  */
-static inline char *
+static inline char *__=
bidi_indexable
 buf_str(struct buffer *buf)
 {
     return (char *)buf_bptr=
(buf);
@@ -581,7 +584,7 @@
  *
  * @return The content pointer as a \c cons=
t char *, or NULL if \c buf is invalid=2E
  */
-static inline const char *
=
+static inline const char *__bidi_indexable
 buf_cstr(const struct buffer *=
buf)
 {
     return (const char *)buf_cbptr(buf);
@@ -655,7 +658,7 @@
  * @=
param size  Size of the memory region in bytes=2E
  */
 static inline void
=
-buf_set_write(struct buffer *buf, uint8_t *data, int size)
+buf_set_write(=
struct buffer *buf, uint8_t *__sized_by_or_null(size) data, int size)
 {
  =
   if (!buf_size_valid(size))
     {
@@ -684,7 +687,7 @@
  * @param size  S=
ize of the memory region in bytes=2E
  */
 static inline void
-buf_set_read=
(struct buffer *buf, const uint8_t *data, size_t size)
+buf_set_read(struct=
 buffer *buf, const uint8_t *__sized_by_or_null(size) data, size_t size)
 {=

     if (!buf_size_valid(size))
     {
@@ -745,13 +748,13 @@
  * @param le=
n   Length of data, in bytes=2E
  */
 static inline void
-secure_memzero(vo=
id *data, size_t len)
+secure_memzero(void *__sized_by(len) data, size_t le=
n)
 {
 #if defined(_WIN32)
     SecureZeroMemory(data, len);
 #elif defined=
(__GNUC__) || defined(__clang__)
     memset(data, 0, len);
-    __asm__ __=
volatile__("" : : "r"(data) : "memory");
+    __asm__ __volatile__("" : : "=
r"(__unsafe_forge_single(void *, data)) : "memory");
 #else
     volatile c=
har *p =3D (volatile char *)data;
     while (len--)
@@ -836,7 +839,7 @@
  =
*
  * @param str   The null-terminated string to chomp=2E
  */
-void chomp(=
char *str);
+void chomp(char *__null_terminated str);
 
 /**
  * Remove all=
 trailing characters that appear in a given set=2E
@@ -844,7 +847,7 @@
  * =
@param str             The null-terminated string to modify in place=2E
  *=
 @param what_to_delete  Null-terminated set of characters to strip=2E
  */
=
-void rm_trailing_chars(char *str, const char *what_to_delete);
+void rm_tr=
ailing_chars(char *__null_terminated str, const char *what_to_delete);
 
 /=
**
  * Return a pointer past any leading whitespace in a string=2E
@@ -913,=
7 +916,7 @@
  *         extracted; true otherwise (including when a delimit=
er was found
  *         or \c line was truncated)=2E
  */
-bool buf_parse(=
struct buffer *buf, const int delim, char *line, const int size);
+bool buf=
_parse(struct buffer *buf, const int delim, char *__counted_by(size) line, =
const int size);
 
 /** @name Hex Dump
  *  @brief Output a binary buffer t=
o a hex string and return it=2E
@@ -941,7 +944,7 @@
  *
  * @return Null-te=
rminated hex string allocated from \c gc=2E
  */
-char *format_hex_ex(const=
 uint8_t *data, size_t size, size_t maxoutput, unsigned int space_break_fla=
gs,
+char *format_hex_ex(const uint8_t *__counted_by(size) data, size_t siz=
e, size_t maxoutput, unsigned int space_break_flags,
                     c=
onst char *separator, struct gc_arena *gc);
 
 /**
@@ -957,7 +960,7 @@
  * =
@return Null-terminated hex string allocated from \c gc=2E
  */
 static inl=
ine char *
-format_hex(const uint8_t *data, size_t size, size_t maxoutput, =
struct gc_arena *gc)
+format_hex(const uint8_t *__counted_by(size) data, si=
ze_t size, size_t maxoutput, struct gc_arena *gc)
 {
     return format_hex=
_ex(data, size, maxoutput, 4, " ", gc);
 }
@@ -1138,7 +1141,7 @@
  * @retur=
n Pointer to the newly reserved space (new content start), or NULL
  *     =
    if \c buf is invalid or there is insufficient prepend capacity=2E
  */
=
-static inline uint8_t *
+static inline uint8_t *__bidi_indexable
 buf_prep=
end(struct buffer *buf, ssize_t size)
 {
     if (!buf_valid(buf) || size <=
 0 || size > buf->offset)
@@ -1185,7 +1188,7 @@
  * @return Pointer to the =
start of the reserved space, or NULL if there is
  *         insufficient c=
apacity=2E
  */
-static inline uint8_t *
+static inline uint8_t *__bidi_ind=
exable
 buf_write_alloc(struct buffer *buf, size_t size)
 {
     uint8_t *r=
et;
@@ -1210,7 +1213,7 @@
  * @return Pointer to the start of the consumed =
region, or NULL if \c size
  *         is negative or exceeds the current l=
ength=2E
  */
-static inline uint8_t *
+static inline uint8_t *__bidi_index=
able
 buf_read_alloc(struct buffer *buf, int size)
 {
     uint8_t *ret;
@@=
 -1236,7 +1239,7 @@
  * @return true on success, false if there is insuffic=
ient capacity=2E
  */
 static inline bool
-buf_write(struct buffer *dest, c=
onst void *src, size_t size)
+buf_write(struct buffer *dest, const void *__=
sized_by(size) src, size_t size)
 {
     uint8_t *cp =3D buf_write_alloc(de=
st, size);
     if (!cp)
@@ -1260,7 +1263,7 @@
  * @return true on success,=
 false if there is insufficient prepend capacity=2E
  */
 static inline boo=
l
-buf_write_prepend(struct buffer *dest, const void *src, int size)
+buf_w=
rite_prepend(struct buffer *dest, const void *__sized_by(size) src, int siz=
e)
 {
     uint8_t *cp =3D buf_prepend(dest, size);
     if (!cp)
@@ -1448,=
7 +1451,7 @@
  * @return true on success, false if \c src has fewer than \c=
 size bytes=2E
  */
 static inline bool
-buf_read(struct buffer *src, void =
*dest, int size)
+buf_read(struct buffer *src, void *__sized_by(size) dest,=
 int size)
 {
     const uint8_t *cp =3D buf_read_alloc(src, size);
     if=
 (!cp)
@@ -1596,7 +1599,7 @@
  * *NOT* constant time=2E Do not use when com=
paring HMACs=2E
  */
 static inline bool
-buf_string_match(const struct buf=
fer *src, const void *match, int size)
+buf_string_match(const struct buffe=
r *src, const void *__sized_by(size) match, int size)
 {
     if (size !=3D=
 src->len)
     {
@@ -1610,7 +1613,7 @@
  * *NOT* constant time=2E Do not u=
se when comparing HMACs=2E
  */
 static inline bool
-buf_string_match_head(=
const struct buffer *src, const void *match, int size)
+buf_string_match_he=
ad(const struct buffer *src, const void *__sized_by(size) match, int size)
=
 {
     if (size < 0 || size > src->len)
     {
@@ -1749,7 +1752,7 @@
  * @=
param replace The character to replace the specified character classes with=
=2E
  * @return True if the string was not modified, false otherwise=2E
  *=
/
-bool string_mod(char *str, const unsigned int inclusive, const unsigned =
int exclusive,
+bool string_mod(char *__null_terminated str, const unsigned=
 int inclusive, const unsigned int exclusive,
                 const char r=
eplace);
 
 
@@ -1793,7 +1796,7 @@
  * @param match    The character to rep=
lace=2E
  * @param replace  The replacement character=2E
  */
-void string_=
replace_leading(char *str, const char match, const char replace);
+void str=
ing_replace_leading(char *__null_terminated str, const char match, const ch=
ar replace);
 
 /**
  * Return true iff \c str starts with \c prefix=2E
@@ =
-1836,7 +1839,7 @@
  *
  * @return true if snprintf() was successful and no=
t truncated=2E
  */
-bool checked_snprintf(char *str, size_t size, const ch=
ar *format, =2E=2E=2E)
+bool checked_snprintf(char *__counted_by(size) str,=
 size_t size, const char *format, =2E=2E=2E)
 #ifdef __GNUC__
 #if __USE_MI=
NGW_ANSI_STDIO
     __attribute__((format(gnu_printf, 3, 4)))
@@ -2210,7 +2=
213,7 @@
  *
  * @return the new buffer
  */
-struct buffer_entry *buffer_l=
ist_push_data(struct buffer_list *ol, const void *data, size_t size);
+stru=
ct buffer_entry *buffer_list_push_data(struct buffer_list *ol, const void *=
__sized_by(size) data, size_t size);
 
 /**
  * Retrieve the head buffer

-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2035?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib57d973a2f8ef48c=
3710f7d034da1a91c64d4755
Gerrit-Change-Number: 2035
Gerrit-PatchSet: 1
Gerr=
it-Owner: Laptops <jeff@incrediblybased=2Eco>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--HBKnv9PU4eg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Laptops would like Arne Schwa=
be to <strong>review</strong> this change=2E
</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2035?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">buffer: add optional -fbounds-safety annotations<br><br>Add Clang -f=
bounds-safety annotations to struct buffer and the buffer<br>API, and allow=
 building buffer=2Ec with -fbounds-safety via<br>--enable-fbounds-safety (a=
utotools) or -DENABLE_FBOUNDS_SAFETY=3DON<br>(CMake)=2E The option is off b=
y default=2E<br><br>Only buffer=2Ec is built with the flag for now, since m=
ost other files and<br>some system and library headers are not annotated ye=
t=2E CMake sets it as<br>a source file property, so it also applies to the =
unit tests that build<br>buffer=2Ec=2E Automake builds buffer=2Ec as a smal=
l convenience library with<br>its own CFLAGS=2E<br><br>compat=2Eh uses &lt;=
ptrcheck=2Eh&gt; when it is available, since some system<br>headers include=
 it unconditionally, and only defines no-op fallbacks<br>for annotations th=
at are still undefined=2E<br><br>The annotations used on non-static declara=
tions (__sized_by,<br>__counted_by, __null_terminated, __unsafe_indexable) =
do not change the<br>representation of pointers, so buffer=2Eo is ABI compa=
tible with code<br>built without -fbounds-safety=2E The wide __bidi_indexab=
le pointers are<br>only used as return types of static inline helpers=2E<br=
><br>The free function callback of gc_addspecial() takes a<br>void *__unsaf=
e_indexable, which matches how the macOS SDK declares<br>free(), so free() =
can be passed without a cast=2E<br><br>Change-Id: Ib57d973a2f8ef48c3710f7d0=
34da1a91c64d4755<br>Signed-off-by: Jeff Bindel &lt;jeff@incrediblybased=2Ec=
o&gt;<br>---<br>M =2Eclang-format<br>M CMakeLists=2Etxt<br>M configure=2Eac=
<br>M src/compat/compat=2Eh<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn=
/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>7 files changed, 163 insertions(=
+), 77 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/35/2035/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=2Eclan=
g-format b/=2Eclang-format</span><br><span>index 23d224b=2E=2E312b6d3 10064=
4</span><br><span>--- a/=2Eclang-format</span><br><span>+++ b/=2Eclang-form=
at</span><br><span>@@ -17,6 +17,7 @@</span><br><span> AllowShortFunctionsOn=
ASingleLine: None</span><br><span> AllowShortIfStatementsOnASingleLine: Nev=
er</span><br><span> AllowShortLoopsOnASingleLine: false</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+AttributeMacros: [__counted_by, __count=
ed_by_or_null, __sized_by, __sized_by_or_null]</span><br><span> BinPackArgu=
ments: true</span><br><span> BinPackParameters: true</span><br><span> Break=
AfterReturnType: AllDefinitions</span><br><span>diff --git a/CMakeLists=2Et=
xt b/CMakeLists=2Etxt</span><br><span>index 184a95a=2E=2Ebd22587 100644</sp=
an><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt<=
/span><br><span>@@ -43,6 +43,8 @@</span><br><span> option(ENABLE_DEBUG &quo=
t;Enable building with debug&quot; OFF)</span><br><span> </span><br><span> =
option(ENABLE_DNS_UPDOWN_BY_DEFAULT &quot;Run --dns-updown hook by default&=
quot; ON)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+option(ENABLE_FBOUNDS_SAFETY =
&quot;Enable experimental Clang -fbounds-safety annotations (OFF by default=
)&quot; OFF)</span><br><span> set(DNS_UPDOWN_PATH &quot;${CMAKE_INSTALL_PRE=
FIX}/libexec/openvpn/dns-updown&quot; CACHE STRING &quot;Default location f=
or the DNS up/down script&quot;)</span><br><span> </span><br><span> set(PLU=
GIN_DIR &quot;${CMAKE_INSTALL_PREFIX}/lib/openvpn/plugins&quot; CACHE FILEP=
ATH &quot;Location of the plugin directory&quot;)</span><br><span>@@ -646,6=
 +648,15 @@</span><br><span>     src/openvpn/xkey_provider=2Ec</span><br><s=
pan>     )</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+if (ENABLE_FBOUNDS_SAFETY)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    # Only buffer=2Ec is built with -fbounds-safety for now=
=2E This applies to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    # every target in this directory that compiles it, including unit tests=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_source_f=
iles_properties(src/openvpn/buffer=2Ec PROPERTIES</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        COMPILE_OPTIONS -fbounds-safety</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        COMPILE_DEFINITIO=
NS OVPN_SUPPORT_FBOUNDS_SAFETY</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> add_executable(openvpn ${SOURCE_FILES})</span><br><span> </span><br=
><span> add_library_deps(openvpn)</span><br><span>diff --git a/configure=2E=
ac b/configure=2Eac</span><br><span>index 0ac61b4=2E=2E46b28f5 100644</span=
><br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span>=
<br><span>@@ -1329,6 +1329,15 @@</span><br><span> AC_SUBST([tmpfilesdir])</=
span><br><span> </span><br><span> AC_ARG_ENABLE(</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	[fbounds-safety],</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	[AS_HELP_STRING([--enable-fbounds-safety],</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	                [enabl=
e experimental Clang -fbounds-safety annotations @&lt;:@default=3Dno@:&gt;@=
])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	[enable_fbound=
s_safety=3D&quot;$enableval&quot;],</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	[enable_fbounds_safety=3D&quot;no&quot;]</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+AM_CONDITIONAL([ENABLE_FBOUNDS_SAFETY], [test &quot;${e=
nable_fbounds_safety}&quot; =3D &quot;yes&quot;])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+AC_ARG_ENABLE(</span><br><span>      [unit-tests],</span><br><sp=
an>      [AS_HELP_STRING([--disable-unit-tests],</span><br><span>          =
            [Disables building and running the unit tests suite])],</span><=
br><span>diff --git a/src/compat/compat=2Eh b/src/compat/compat=2Eh</span><=
br><span>index 4ee9141=2E=2E20abf19 100644</span><br><span>--- a/src/compat=
/compat=2Eh</span><br><span>+++ b/src/compat/compat=2Eh</span><br><span>@@ =
-75,4 +75,53 @@</span><br><span> strtok_r(char *s, const char *delim, char =
**last);</span><br><span> #endif</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Optional Clang -fbounds-safety annotations=2E &lt;ptrcheck=
=2Eh&gt; turns them into</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * no-ops when -fbounds-safety is not enabled, and some system headers=
 include</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * it uncon=
ditionally, so prefer it when available and only fall back to our</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * own no-op definitions for =
annotations that are still undefined=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(OVPN_SUPPORT_FBOUNDS_SAFETY)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;ptrcheck=2Eh&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#elif defined(__has_include)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if __has_include(&lt;ptrcheck=
=2Eh&gt;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;ptrcheck=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifndef __sized_by</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define __sized_by(n)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef __sized_by_or_null</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define __sized_by_or_null(n)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef __counted_by</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define __counted_by(n)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#ifndef __counted_by_or_null</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define __counted_by_or_null(n)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef __null_terminated</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define __null_terminated</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifndef __unsafe_indexable</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define __unsafe_indexable</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef __unsafe_forge_single</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define __unsafe_forge_single(T, P) ((T)(=
P))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef __null_terminated_to_=
indexable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define __=
null_terminated_to_indexable(P) (P)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef __unsafe_null_terminated_to_indexable</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define __unsafe_null_terminated_to_indexable(=
P) (P)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef __unsafe_null_term=
inated_from_indexable</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define __unsafe_null_terminated_from_indexable(P) (P)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* not defined by &lt;ptrcheck=2Eh&gt; without -fbo=
unds-safety as it changes the ABI */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef __bidi_indexable</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define __bidi_indexable</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> #endif /* COMPAT_H */</span><br><span>diff =
--git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><sp=
an>index 8a60a94=2E=2E9a4e8b7 100644</span><br><span>--- a/src/openvpn/Make=
file=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@=
@ -49,7 +49,7 @@</span><br><span> 	auth_token=2Ec auth_token=2Eh \</span><b=
r><span> 	base64=2Ec base64=2Eh \</span><br><span> 	basic=2Eh \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	buffer=2Ec buffer=2Eh \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	buffer=2Eh \</span><br><spa=
n> 	check_file_access=2Ec check_file_access=2Eh \</span><br><span> 	circ_li=
st=2Eh \</span><br><span> 	clinat=2Ec clinat=2Eh \</span><br><span>@@ -162,=
7 +162,17 @@</span><br><span> 	win32=2Eh win32=2Ec \</span><br><span> 	win3=
2-util=2Eh win32-util=2Ec \</span><br><span> 	cryptoapi=2Eh cryptoapi=2Ec</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn_LDADD =3D \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+if ENABLE_FBOUNDS_SAFET=
Y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Only buffer=2Ec =
is built with -fbounds-safety for now</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+noinst_LTLIBRARIES =3D libbuffer=2Ela</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+libbuffer_la_SOURCES =3D buffer=2Ec</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+libbuffer_la_CFLAGS =3D=
 $(AM_CFLAGS) -fbounds-safety -DOVPN_SUPPORT_FBOUNDS_SAFETY</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+openvpn_LDADD =3D libbuffer=2Ela</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+openvpn_SOURCES +=3D buffer=2Ec</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_LDADD =3D</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+openvpn_LDADD +=3D \</span><br><span> 	$(=
top_builddir)/src/compat/libcompat=2Ela \</span><br><span> 	$(SOCKETS_LIBS)=
 \</span><br><span> 	$(OPTIONAL_LIBCAPNG_LIBS) \</span><br><span>diff --git=
 a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 88=
13fa5=2E=2E1515ed7 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</spa=
n><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -272,7 +272,7 @=
@</span><br><span>         size_t len =3D strlen(str) + 1;</span><br><span>=
         if (buf_size_valid(len) &amp;&amp; (int)len &lt; buf_forward_capac=
ity_total(buf))</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            memcpy(buf-&gt;data + buf-&gt;capacity - l=
en, str, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       memcpy(buf-&gt;data + buf-&gt;capacity - len, __unsafe_null_terminat=
ed_to_indexable(str), len);</span><br><span>         }</span><br><span>    =
 }</span><br><span> }</span><br><span>@@ -309,7 +309,7 @@</span><br><span> =
 * Garbage collection</span><br><span>  */</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void *__sized_by(size)</span><br><span> gc_malloc=
(size_t size, bool clear, struct gc_arena *a)</span><br><span> {</span><br>=
<span>     void *ret;</span><br><span>@@ -403,7 +403,7 @@</span><br><span> =
}</span><br><span> </span><br><span> void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-gc_addspecial(void *addr, void (*free_function)(void *)=
, struct gc_arena *a)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+gc_addspecial(void *addr, void (*free_function)(void *__unsafe_indexable)=
, struct gc_arena *a)</span><br><span> {</span><br><span>     ASSERT(a);</s=
pan><br><span>     struct gc_entry_special *e;</span><br><span>@@ -444,7 +4=
44,7 @@</span><br><span>  */</span><br><span> </span><br><span> char *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-format_hex_ex(const uint8_=
t *data, size_t size, size_t maxoutput, unsigned int space_break_flags,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+format_hex_ex(const uin=
t8_t *__counted_by(size) data, size_t size, size_t maxoutput, unsigned int =
space_break_flags,</span><br><span>               const char *separator, st=
ruct gc_arena *gc)</span><br><span> {</span><br><span>     const size_t byt=
es_per_hexblock =3D space_break_flags &amp; FHE_SPACE_BREAK_MASK;</span><br=
><span>@@ -576,7 +576,7 @@</span><br><span>  * Remove trailing \r and \n ch=
ars=2E</span><br><span>  */</span><br><span> void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-chomp(char *str)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+chomp(char *__null_terminated str)</span><br><span=
> {</span><br><span>     rm_trailing_chars(str, &quot;\r\n&quot;);</span><b=
r><span> }</span><br><span>@@ -585,19 +585,20 @@</span><br><span>  * Remove=
 trailing chars</span><br><span>  */</span><br><span> void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-rm_trailing_chars(char *str, const cha=
r *what_to_delete)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+r=
m_trailing_chars(char *__null_terminated str, const char *what_to_delete)</=
span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  char *cp =3D __null_terminated_to_indexable(str);</span><br><span>     si=
ze_t len =3D strlen(str);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    while (len &gt; 0 &amp;&amp; strchr(what_to_delete, str[len - 1]) !=
=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while =
(len &gt; 0 &amp;&amp; strchr(what_to_delete, cp[len - 1]) !=3D NULL)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    str[--len] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        cp[--len] =3D &#39;\0&#39;;</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span> /*</span><br><span>  * A=
llocate a string</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-char *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+char *__null_terminated</span><br><span> string_alloc(const char *str, s=
truct gc_arena *gc)</span><br><span> {</span><br><span>     if (str)</span>=
<br><span>@@ -618,8 +619,8 @@</span><br><span>             ret =3D calloc(1=
, n);</span><br><span>             check_malloc_return(ret);</span><br><spa=
n>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
emcpy(ret, str, n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      memcpy(ret, __unsafe_null_terminated_to_indexable(str), n);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return __unsafe_null_=
terminated_from_indexable(ret);</span><br><span>     }</span><br><span>    =
 else</span><br><span>     {</span><br><span>@@ -631,11 +632,11 @@</span><b=
r><span>  * Erase all characters in a string</span><br><span>  */</span><br=
><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-string_cl=
ear(char *str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+strin=
g_clear(char *__null_terminated str)</span><br><span> {</span><br><span>   =
  if (str)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        secure_memzero(str, strlen(str));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        secure_memzero(__null_terminated_=
to_indexable(str), strlen(str));</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span>@@ -643,7 +644,7 @@</span><br><span>  * R=
eturn the length of a string array</span><br><span>  */</span><br><span> in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-string_array_len(con=
st char **array)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+str=
ing_array_len(const char **__null_terminated array)</span><br><span> {</spa=
n><br><span>     int i =3D 0;</span><br><span>     if (array)</span><br><sp=
an>@@ -657,13 +658,13 @@</span><br><span> }</span><br><span> </span><br><sp=
an> char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-print_argv(=
const char **p, struct gc_arena *gc, const unsigned int flags)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+print_argv(const char **__null_t=
erminated p, struct gc_arena *gc, const unsigned int flags)</span><br><span=
> {</span><br><span>     struct buffer out =3D alloc_buf_gc(256, gc);</span=
><br><span>     int i =3D 0;</span><br><span>     for (; *p; ++p)</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
const char *cp =3D *p;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        const char *__null_terminated cp =3D *p;</span><br><span>       =
  if (i)</span><br><span>         {</span><br><span>             buf_printf=
(&amp;out, &quot; &quot;);</span><br><span>@@ -691,8 +692,8 @@</span><br><s=
pan> </span><br><span>     ASSERT(str);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const char *copy =3D string_alloc(s=
tr, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_set_r=
ead(&amp;buf, (const uint8_t *)copy, strlen(str) + 1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *__null_terminated copy =
=3D string_alloc(str, gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    buf_set_read(&amp;buf, (const uint8_t *)__unsafe_null_terminated=
_to_indexable(copy), strlen(str) + 1);</span><br><span> </span><br><span>  =
   if (buf=2Elen &gt; 0) /* Don&#39;t count trailing &#39;\0&#39; as part o=
f length */</span><br><span>     {</span><br><span>@@ -714,7 +715,7 @@</spa=
n><br><span>     {</span><br><span>         return false;</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return memcm=
p(CBPTR(src), match, size) =3D=3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return memcmp(CBPTR(src), __null_terminated_to_indexab=
le(match), size) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><=
span> bool</span><br><span>@@ -754,7 +755,7 @@</span><br><span>  */</span><=
br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-buf_parse(struct buffer *buf, const int delim, char *line, const=
 int size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_parse=
(struct buffer *buf, const int delim, char *__counted_by(size) line, const =
int size)</span><br><span> {</span><br><span>     bool eol =3D false;</span=
><br><span>     int n =3D 0;</span><br><span>@@ -983,12 +984,13 @@</span><b=
r><span>  * Guaranteed to not increase string length=2E</span><br><span>  *=
/</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-string_mod(char *str, const unsigned int inclusive, const unsigned int ex=
clusive,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+string_mod(=
char *__null_terminated str, const unsigned int inclusive, const unsigned i=
nt exclusive,</span><br><span>            const char replace)</span><br><sp=
an> {</span><br><span>     ASSERT(str);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    char *out =3D str;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* the terminator is rewritten i=
n place, so it needs to be within bounds */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    char *out =3D __unsafe_null_terminated_to_index=
able(str);</span><br><span>     const char *in =3D out;</span><br><span>   =
  bool ret =3D true;</span><br><span> </span><br><span>@@ -1039,7 +1041,7 @=
@</span><br><span> {</span><br><span>     if (str)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char *buf =3D s=
tring_alloc(str, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        char *__null_terminated buf =3D string_alloc(str, gc);</span><br>=
<span>         string_mod(buf, inclusive, exclusive, replace);</span><br><s=
pan>         return buf;</span><br><span>     }</span><br><span>@@ -1050,7 =
+1052,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-string_replace_leading(char=
 *str, const char match, const char replace)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+string_replace_leading(char *__null_terminated str=
, const char match, const char replace)</span><br><span> {</span><br><span>=
     ASSERT(match !=3D &#39;\0&#39;);</span><br><span>     while (*str)</sp=
an><br><span>@@ -1112,7 +1114,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-che=
cked_snprintf(char *str, size_t size, const char *format, =2E=2E=2E)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+checked_snprintf(char *__c=
ounted_by(size) str, size_t size, const char *format, =2E=2E=2E)</span><br>=
<span> {</span><br><span>     va_list arglist;</span><br><span>     va_star=
t(arglist, format);</span><br><span>@@ -1192,7 +1194,8 @@</span><br><span> =
    if (str)</span><br><span>     {</span><br><span>         const size_t l=
en =3D strlen((const char *)str);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        struct buffer_entry *e =3D buffer_list_push_data(ol, st=
r, len + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 struct buffer_entry *e =3D</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            buffer_list_push_data(ol, __unsafe_null_terminated_to_i=
ndexable(str), len + 1);</span><br><span>         if (e)</span><br><span>  =
       {</span><br><span>             e-&gt;buf=2Elen--; /* Don&#39;t count=
 trailing &#39;\0&#39; as part of length */</span><br><span>@@ -1201,7 +120=
4,7 @@</span><br><span> }</span><br><span> </span><br><span> struct buffer_=
entry *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buffer_list_pu=
sh_data(struct buffer_list *ol, const void *data, size_t size)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+buffer_list_push_data(struct buf=
fer_list *ol, const void *__sized_by(size) data, size_t size)</span><br><sp=
an> {</span><br><span>     struct buffer_entry *e =3D NULL;</span><br><span=
>     if (data)</span><br><span>@@ -1271,7 +1274,7 @@</span><br><span>     =
    {</span><br><span>             struct buffer_entry *next =3D e-&gt;next=
;</span><br><span>             buf_copy(&amp;f-&gt;buf, &amp;e-&gt;buf);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_write(&a=
mp;f-&gt;buf, sep, sep_len);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            buf_write(&amp;f-&gt;buf, __null_terminated_to_indexab=
le(sep), sep_len);</span><br><span>             free_buf(&amp;e-&gt;buf);</=
span><br><span>             free(e);</span><br><span>             e =3D nex=
t;</span><br><span>@@ -1337,7 +1340,7 @@</span><br><span>             bl =
=3D buffer_list_new();</span><br><span>             while (fgets(line, max_=
line_len, fp) !=3D NULL)</span><br><span>             {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                buffer_list_push(bl, line=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                b=
uffer_list_push(bl, __unsafe_null_terminated_from_indexable(line));</span><=
br><span>             }</span><br><span>             free(line);</span><br>=
<span>         }</span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/=
openvpn/buffer=2Eh</span><br><span>index 7af4444=2E=2Ebf8d02c 100644</span>=
<br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/bu=
ffer=2Eh</span><br><span>@@ -69,13 +69,14 @@</span><br><span>  */</span><br=
><span> struct buffer</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int capacity;  /**&lt; Size in bytes of memory alloc=
ated by</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      *   \c malloc()=2E */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    int offset;    /**&lt; Offset in bytes of the actual content</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    *   wi=
thin the allocated memory=2E */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int len;       /**&lt; Length in bytes of the actual content<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    * =
  within the allocated memory=2E */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    uint8_t *data; /**&lt; Pointer to the allocated memory=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int capacity=
; /**&lt; Size in bytes of memory allocated by</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                   *   \c malloc()=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int offset;   /**&lt; O=
ffset in bytes of the actual content</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                   *   within the allocated memory=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int len;      /**=
&lt; Length in bytes of the actual content</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                   *   within the allocated memory=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Point=
er to the allocated memory=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    uint8_t *__sized_by_or_null(capacity) data;</span><br><spa=
n> </span><br><span> #ifdef BUF_INIT_TRACKING</span><br><span>     const ch=
ar *debug_file;</span><br><span>@@ -108,7 +109,7 @@</span><br><span> struct=
 gc_entry_special</span><br><span> {</span><br><span>     struct gc_entry_s=
pecial *next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    void=
 (*free_fnc)(void *);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    void (*free_fnc)(void *__unsafe_indexable);</span><br><span>     void=
 *addr;</span><br><span> };</span><br><span> </span><br><span>@@ -199,7 +20=
0,7 @@</span><br><span>  *</span><br><span>  * @param str   The string to c=
lear=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void string_clear(char *str);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void string_clear(char *__null_terminated str);</span><br>=
<span> </span><br><span> /**</span><br><span>  * Return the number of eleme=
nts in a NULL-terminated array of strings=2E</span><br><span>@@ -208,7 +209=
,7 @@</span><br><span>  *</span><br><span>  * @return Number of non-NULL el=
ements=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-int string_array_len(const char **array);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+int string_array_len(const char **__null_ter=
minated array);</span><br><span> </span><br><span> /**</span><br><span>  * =
Safely compute the product of two sizes plus an extra amount=2E</span><br><=
span>@@ -236,7 +237,7 @@</span><br><span>  *</span><br><span>  * @return Ne=
wly allocated string representation of \c p=2E</span><br><span>  */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-char *print_argv(const char *=
*p, struct gc_arena *gc, const unsigned int flags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+char *print_argv(const char **__null_term=
inated p, struct gc_arena *gc, const unsigned int flags);</span><br><span> =
</span><br><span> /**</span><br><span>  * Report a buffer size error and ab=
ort=2E</span><br><span>@@ -299,7 +300,7 @@</span><br><span>  *</span><br><s=
pan>  * @return Pointer to the newly allocated memory=2E</span><br><span>  =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void *gc_malloc(siz=
e_t size, bool clear, struct gc_arena *a);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void *__sized_by(size) gc_malloc(size_t size, bool c=
lear, struct gc_arena *a);</span><br><span> </span><br><span> /**</span><br=
><span>  * Duplicate a string, allocating memory under garbage collection=
=2E</span><br><span>@@ -311,7 +312,7 @@</span><br><span>  *</span><br><span=
>  * @return A newly allocated copy of \c str, or NULL if \c str is NULL=2E=
</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
char *string_alloc(const char *str, struct gc_arena *gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+char *__null_terminated string_alloc(=
const char *str, struct gc_arena *gc);</span><br><span> </span><br><span> /=
**</span><br><span>  * Allocate a buffer containing a copy of the given str=
ing=2E</span><br><span>@@ -337,10 +338,12 @@</span><br><span>  * something =
other than plain \c free(), such as \c freeaddrinfo()=2E</span><br><span>  =
*</span><br><span>  * @param addr          Pointer to the memory to registe=
r=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param free_fu=
nction Function to call to free \c addr=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param free_function Function to call to free \c =
addr=2E  The parameter is</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *                      \c __unsafe_indexable so that \c free() can b=
e passed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
             with -fbounds-safety=2E</span><br><span>  * @param a          =
   Garbage collection arena to register with=2E</span><br><span>  */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void gc_addspecial(void *add=
r, void (*free_function)(void *), struct gc_arena *a);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void gc_addspecial(void *addr, void (*fr=
ee_function)(void *__unsafe_indexable), struct gc_arena *a);</span><br><spa=
n> </span><br><span> /**</span><br><span>  * allows to realloc a pointer pr=
eviously allocated by gc_malloc or gc_realloc</span><br><span>@@ -374,9 +37=
7,9 @@</span><br><span>  * @param addr  Pointer to the \c struct \c addrinf=
o to free=2E</span><br><span>  */</span><br><span> static inline void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-gc_freeaddrinfo_callback(vo=
id *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+gc_freeadd=
rinfo_callback(void *__unsafe_indexable addr)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    freeaddrinfo((struct addrinf=
o *)addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    freea=
ddrinfo(__unsafe_forge_single(struct addrinfo *, addr));</span><br><span> }=
</span><br><span> </span><br><span> /** Return an empty, undefined \c struc=
t \c buffer (all fields zero)=2E */</span><br><span>@@ -424,7 +427,7 @@</sp=
an><br><span>  * @return Pointer to \c buf-&gt;data + \c buf-&gt;offset, or=
 NULL if \c buf is</span><br><span>  *         not valid=2E</span><br><span=
>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline co=
nst uint8_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 inline const uint8_t *__bidi_indexable</span><br><span> buf_cbptr(const st=
ruct buffer *buf)</span><br><span> {</span><br><span>     if (buf_valid(buf=
))</span><br><span>@@ -445,7 +448,7 @@</span><br><span>  * @return Pointer =
to \c buf-&gt;data + \c buf-&gt;offset, or NULL if \c buf is</span><br><spa=
n>  *         not valid=2E</span><br><span>  */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static inline uint8_t *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static inline uint8_t *__bidi_indexable</span=
><br><span> buf_bptr(struct buffer *buf)</span><br><span> {</span><br><span=
>     return (uint8_t *)buf_cbptr(buf);</span><br><span>@@ -478,7 +481,7 @@=
</span><br><span>  *</span><br><span>  * @return Pointer to the byte immedi=
ately after the last content byte=2E</span><br><span>  */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static inline uint8_t *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline uint8_t *__bidi_index=
able</span><br><span> buf_bend(struct buffer *buf)</span><br><span> {</span=
><br><span>     return buf_bptr(buf) + buf_len(buf);</span><br><span>@@ -49=
1,7 +494,7 @@</span><br><span>  *</span><br><span>  * @return Pointer to th=
e byte immediately after the last content byte=2E</span><br><span>  */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline const uint8_=
t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline co=
nst uint8_t *__bidi_indexable</span><br><span> buf_cbend(const struct buffe=
r *buf)</span><br><span> {</span><br><span>     return buf_cbptr(buf) + buf=
_len(buf);</span><br><span>@@ -505,7 +508,7 @@</span><br><span>  * @return =
Pointer to the last byte, or NULL if the buffer is empty or</span><br><span=
>  *         invalid=2E</span><br><span>  */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static inline const uint8_t *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline const uint8_t *__bidi_index=
able</span><br><span> buf_cblast(const struct buffer *buf)</span><br><span>=
 {</span><br><span>     if (buf_len(buf) &gt; 0)</span><br><span>@@ -526,7 =
+529,7 @@</span><br><span>  * @return Pointer to the last byte, or NULL if =
the buffer is empty or</span><br><span>  *         invalid=2E</span><br><sp=
an>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline =
uint8_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inl=
ine uint8_t *__bidi_indexable</span><br><span> buf_blast(struct buffer *buf=
)</span><br><span> {</span><br><span>     return (uint8_t *)buf_cblast(buf)=
;</span><br><span>@@ -568,7 +571,7 @@</span><br><span>  *</span><br><span> =
 * @return The content pointer as a \c char *, or NULL if \c buf is invalid=
=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-static inline char *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static inline char *__bidi_indexable</span><br><span> buf_str(struct bu=
ffer *buf)</span><br><span> {</span><br><span>     return (char *)buf_bptr(=
buf);</span><br><span>@@ -581,7 +584,7 @@</span><br><span>  *</span><br><sp=
an>  * @return The content pointer as a \c const char *, or NULL if \c buf =
is invalid=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static inline const char *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static inline const char *__bidi_indexable</span><br><s=
pan> buf_cstr(const struct buffer *buf)</span><br><span> {</span><br><span>=
     return (const char *)buf_cbptr(buf);</span><br><span>@@ -655,7 +658,7 =
@@</span><br><span>  * @param size  Size of the memory region in bytes=2E</=
span><br><span>  */</span><br><span> static inline void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-buf_set_write(struct buffer *buf, uint8_t=
 *data, int size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bu=
f_set_write(struct buffer *buf, uint8_t *__sized_by_or_null(size) data, int=
 size)</span><br><span> {</span><br><span>     if (!buf_size_valid(size))</=
span><br><span>     {</span><br><span>@@ -684,7 +687,7 @@</span><br><span> =
 * @param size  Size of the memory region in bytes=2E</span><br><span>  */<=
/span><br><span> static inline void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-buf_set_read(struct buffer *buf, const uint8_t *data, size_t =
size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_set_read(s=
truct buffer *buf, const uint8_t *__sized_by_or_null(size) data, size_t siz=
e)</span><br><span> {</span><br><span>     if (!buf_size_valid(size))</span=
><br><span>     {</span><br><span>@@ -745,13 +748,13 @@</span><br><span>  *=
 @param len   Length of data, in bytes=2E</span><br><span>  */</span><br><s=
pan> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-secure_memzero(void *data, size_t len)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+secure_memzero(void *__sized_by(len) data, size_t len)=
</span><br><span> {</span><br><span> #if defined(_WIN32)</span><br><span>  =
   SecureZeroMemory(data, len);</span><br><span> #elif defined(__GNUC__) ||=
 defined(__clang__)</span><br><span>     memset(data, 0, len);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    __asm__ __volatile__(&quot;&qu=
ot; : : &quot;r&quot;(data) : &quot;memory&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    __asm__ __volatile__(&quot;&quot; : : &q=
uot;r&quot;(__unsafe_forge_single(void *, data)) : &quot;memory&quot;);</sp=
an><br><span> #else</span><br><span>     volatile char *p =3D (volatile cha=
r *)data;</span><br><span>     while (len--)</span><br><span>@@ -836,7 +839=
,7 @@</span><br><span>  *</span><br><span>  * @param str   The null-termina=
ted string to chomp=2E</span><br><span>  */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void chomp(char *str);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void chomp(char *__null_terminated str);</span><br=
><span> </span><br><span> /**</span><br><span>  * Remove all trailing chara=
cters that appear in a given set=2E</span><br><span>@@ -844,7 +847,7 @@</sp=
an><br><span>  * @param str             The null-terminated string to modif=
y in place=2E</span><br><span>  * @param what_to_delete  Null-terminated se=
t of characters to strip=2E</span><br><span>  */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void rm_trailing_chars(char *str, const char *wh=
at_to_delete);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
rm_trailing_chars(char *__null_terminated str, const char *what_to_delete);=
</span><br><span> </span><br><span> /**</span><br><span>  * Return a pointe=
r past any leading whitespace in a string=2E</span><br><span>@@ -913,7 +916=
,7 @@</span><br><span>  *         extracted; true otherwise (including when=
 a delimiter was found</span><br><span>  *         or \c line was truncated=
)=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-bool buf_parse(struct buffer *buf, const int delim, char *line, const i=
nt size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool buf_p=
arse(struct buffer *buf, const int delim, char *__counted_by(size) line, co=
nst int size);</span><br><span> </span><br><span> /** @name Hex Dump</span>=
<br><span>  *  @brief Output a binary buffer to a hex string and return it=
=2E</span><br><span>@@ -941,7 +944,7 @@</span><br><span>  *</span><br><span=
>  * @return Null-terminated hex string allocated from \c gc=2E</span><br><=
span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-char *format=
_hex_ex(const uint8_t *data, size_t size, size_t maxoutput, unsigned int sp=
ace_break_flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cha=
r *format_hex_ex(const uint8_t *__counted_by(size) data, size_t size, size_=
t maxoutput, unsigned int space_break_flags,</span><br><span>              =
       const char *separator, struct gc_arena *gc);</span><br><span> </span=
><br><span> /**</span><br><span>@@ -957,7 +960,7 @@</span><br><span>  * @re=
turn Null-terminated hex string allocated from \c gc=2E</span><br><span>  *=
/</span><br><span> static inline char *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-format_hex(const uint8_t *data, size_t size, size_t maxou=
tput, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+format_hex(const uint8_t *__counted_by(size) data, size_t size, size=
_t maxoutput, struct gc_arena *gc)</span><br><span> {</span><br><span>     =
return format_hex_ex(data, size, maxoutput, 4, &quot; &quot;, gc);</span><b=
r><span> }</span><br><span>@@ -1138,7 +1141,7 @@</span><br><span>  * @retur=
n Pointer to the newly reserved space (new content start), or NULL</span><b=
r><span>  *         if \c buf is invalid or there is insufficient prepend c=
apacity=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static inline uint8_t *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static inline uint8_t *__bidi_indexable</span><br><span> buf_=
prepend(struct buffer *buf, ssize_t size)</span><br><span> {</span><br><spa=
n>     if (!buf_valid(buf) || size &lt; 0 || size &gt; buf-&gt;offset)</spa=
n><br><span>@@ -1185,7 +1188,7 @@</span><br><span>  * @return Pointer to th=
e start of the reserved space, or NULL if there is</span><br><span>  *     =
    insufficient capacity=2E</span><br><span>  */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static inline uint8_t *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline uint8_t *__bidi_indexable</=
span><br><span> buf_write_alloc(struct buffer *buf, size_t size)</span><br>=
<span> {</span><br><span>     uint8_t *ret;</span><br><span>@@ -1210,7 +121=
3,7 @@</span><br><span>  * @return Pointer to the start of the consumed reg=
ion, or NULL if \c size</span><br><span>  *         is negative or exceeds =
the current length=2E</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static inline uint8_t *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static inline uint8_t *__bidi_indexable</span><br>=
<span> buf_read_alloc(struct buffer *buf, int size)</span><br><span> {</spa=
n><br><span>     uint8_t *ret;</span><br><span>@@ -1236,7 +1239,7 @@</span>=
<br><span>  * @return true on success, false if there is insufficient capac=
ity=2E</span><br><span>  */</span><br><span> static inline bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-buf_write(struct buffer *dest, co=
nst void *src, size_t size)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+buf_write(struct buffer *dest, const void *__sized_by(size) src, si=
ze_t size)</span><br><span> {</span><br><span>     uint8_t *cp =3D buf_writ=
e_alloc(dest, size);</span><br><span>     if (!cp)</span><br><span>@@ -1260=
,7 +1263,7 @@</span><br><span>  * @return true on success, false if there i=
s insufficient prepend capacity=2E</span><br><span>  */</span><br><span> st=
atic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_w=
rite_prepend(struct buffer *dest, const void *src, int size)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+buf_write_prepend(struct buffer *d=
est, const void *__sized_by(size) src, int size)</span><br><span> {</span><=
br><span>     uint8_t *cp =3D buf_prepend(dest, size);</span><br><span>    =
 if (!cp)</span><br><span>@@ -1448,7 +1451,7 @@</span><br><span>  * @return=
 true on success, false if \c src has fewer than \c size bytes=2E</span><br=
><span>  */</span><br><span> static inline bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-buf_read(struct buffer *src, void *dest, int size=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_read(struct bu=
ffer *src, void *__sized_by(size) dest, int size)</span><br><span> {</span>=
<br><span>     const uint8_t *cp =3D buf_read_alloc(src, size);</span><br><=
span>     if (!cp)</span><br><span>@@ -1596,7 +1599,7 @@</span><br><span>  =
* *NOT* constant time=2E Do not use when comparing HMACs=2E</span><br><span=
>  */</span><br><span> static inline bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-buf_string_match(const struct buffer *src, const void *=
match, int size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf=
_string_match(const struct buffer *src, const void *__sized_by(size) match,=
 int size)</span><br><span> {</span><br><span>     if (size !=3D src-&gt;le=
n)</span><br><span>     {</span><br><span>@@ -1610,7 +1613,7 @@</span><br><=
span>  * *NOT* constant time=2E Do not use when comparing HMACs=2E</span><b=
r><span>  */</span><br><span> static inline bool</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-buf_string_match_head(const struct buffer *src, =
const void *match, int size)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+buf_string_match_head(const struct buffer *src, const void *__size=
d_by(size) match, int size)</span><br><span> {</span><br><span>     if (siz=
e &lt; 0 || size &gt; src-&gt;len)</span><br><span>     {</span><br><span>@=
@ -1749,7 +1752,7 @@</span><br><span>  * @param replace The character to re=
place the specified character classes with=2E</span><br><span>  * @return T=
rue if the string was not modified, false otherwise=2E</span><br><span>  */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool string_mod(char =
*str, const unsigned int inclusive, const unsigned int exclusive,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool string_mod(char *__null_=
terminated str, const unsigned int inclusive, const unsigned int exclusive,=
</span><br><span>                 const char replace);</span><br><span> </s=
pan><br><span> </span><br><span>@@ -1793,7 +1796,7 @@</span><br><span>  * @=
param match    The character to replace=2E</span><br><span>  * @param repla=
ce  The replacement character=2E</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void string_replace_leading(char *str, cons=
t char match, const char replace);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void string_replace_leading(char *__null_terminated str, con=
st char match, const char replace);</span><br><span> </span><br><span> /**<=
/span><br><span>  * Return true iff \c str starts with \c prefix=2E</span><=
br><span>@@ -1836,7 +1839,7 @@</span><br><span>  *</span><br><span>  * @ret=
urn true if snprintf() was successful and not truncated=2E</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool checked_snpr=
intf(char *str, size_t size, const char *format, =2E=2E=2E)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool checked_snprintf(char *__count=
ed_by(size) str, size_t size, const char *format, =2E=2E=2E)</span><br><spa=
n> #ifdef __GNUC__</span><br><span> #if __USE_MINGW_ANSI_STDIO</span><br><s=
pan>     __attribute__((format(gnu_printf, 3, 4)))</span><br><span>@@ -2210=
,7 +2213,7 @@</span><br><span>  *</span><br><span>  * @return the new buffe=
r</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-struct buffer_entry *buffer_list_push_data(struct buffer_list *ol, const v=
oid *data, size_t size);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+struct buffer_entry *buffer_list_push_data(struct buffer_list *ol, con=
st void *__sized_by(size) data, size_t size);</span><br><span> </span><br><=
span> /**</span><br><span>  * Retrieve the head buffer</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2035?us=
p=3Demail">change 2035</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2035?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ib57d973a2f8ef48c3710f7d034da1a91c64d4755 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2035 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Laptops &lt;jeff@incrediblybased=2Eco&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body>=
</html>
--HBKnv9PU4eg=--


--===============1103563021603155555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1103563021603155555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1103563021603155555==--

