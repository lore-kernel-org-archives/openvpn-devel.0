Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725AD606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GWgn136E;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Blb51bnu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e7PXzfSO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FelrFSWI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=qzXvcqoIYypjUjhoWMUT8uB7NgzZsZQc3qxFkBRTgeQ=; b=GWgn136E5ozWTR+5UdiYCqh2Lu
	JEjugGn81AUsDQuDP+va+/QUeB0W6jHuduclufm2Q1mGvpNXrjYSQ6mEwIVuTsLHacxgCK+w2hgG6
	zn/shO/9qj6AFJj7bzyRyWsM2C2Ft19p+FhVn3xgZR4h7juH0ItCOwVcBskqUEm1MFaQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLeD6-000000003qu-0UuO;
	Tue, 27 Oct 2026 10:15:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLeD4-000000003jl-2SFE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:15:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oA5ToqMmU192L/5IqhcJGe1FC6hG1B+FGaGrtyAycYU=; b=Blb51bnuo9/bXDVIJyvIA26uDK
 5/Hd83AY3xEeGxboLAAXHlKqRVdkb0kqyAYADpDE+c79t6H2D3vch3LqOsGF0G2ao8zgrav3u3wFA
 2xXUsG85mgdPxa2B7MFCXjTU+uCB+WFpYXeYLU26DOB2QmemS6xTHDeHe01D2M58M4XI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oA5ToqMmU192L/5IqhcJGe1FC6hG1B+FGaGrtyAycYU=; b=e7PXzfSOAXn1ReYRsejf/6FQq9
 cKCFZVx2wFQjmlt+ZKuIVejGGjBpNN5US2Uc51NtOc1syZvrUCLXFcN+9Zd/KgWwe6spLM331mBAP
 +LHhZyPdVSr1nCQ1ByO9fWrY1pOYVEgMkwZpHMvlrzS6A56q7hwcO0otLyzdiMNoJtLQ=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLeCd-00000000206-0SI7 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:14:52 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso2466444f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793096080; x=1793700880; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oA5ToqMmU192L/5IqhcJGe1FC6hG1B+FGaGrtyAycYU=;
 b=FelrFSWIhKmS7I19ZFgKQGE6SDgsQfDCQibwNe/yTyOlWQ9P7/z+vO/Cuq3zGVSBN0
 WkbHYjRw0GPQgA7xoPSnLNWGkV43uw3C7bu9DbCztldvnaa6wLv3+bf4UG7I5Kp82VDD
 0+AWUKn0R2a6O7nh4hDGfoV2b6ExXb1bSen6rfQnwQFm8welYGqlW4jeE+urj5qLCrwL
 fV7XBZJEIPqohaO432Rcc+pMUeiCugxz95uwcmpJYxpaADMV51bCC3MSIABvHtL4EIHb
 Hz478KMUeW5ABJ3u3BTfgKH7NAoLaKb8qNsCaFFEKbnSc2+v0yD1gePMzkCdwufylJxx
 XyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793096080; x=1793700880;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oA5ToqMmU192L/5IqhcJGe1FC6hG1B+FGaGrtyAycYU=;
 b=Y8XknwZ+I8AWHWUac0ChgQ1V47wgtnRBrt4icB3JWD5JnVngtt+sCEpcKcArCyC2G8
 HPIC+SFZirl/1nnrmjlCVx+3EVlWW9RyHHLzVDtQnQCwQpcJc0byV5XWTg6fPfhATW9u
 KuKe+1pkZXtu4H8j6D0FX/iei2RklkPP3+GahXgNzKpd18ClamzbomH8mLQQl7HX9Wz9
 kFR+j8dxPKcYqqgmucPJm3uXWmxgXRd3GHmiZQH8HSzeqlqUU9h0W/whJKn5siaLqMfE
 BYBLwG2mW/OShe3/ra8lzQZD+2xQk9YvkFSYJGyTe89r9SovVdchAF/jYBLKZLnzAV3m
 OUEA==
X-Gm-Message-State: AFq9FYJ5j8JkPc8y0l7g0a/LU9jdzbzNT2tNPx6fT2PMM1hEY5b32hRY
 IYDL5LZH9PhcHvQTMlmuV0r9w4zIbERY2pnXhlMsOiBt/54M9aQBgnjG9WvYXl3cwYZm05lmJ8Y
 H/2fFdeI+4F56NY73AlyqbVPO864n0eTejIn7BzND16Jk53BwtLMl/MOeDAOIVvW6VuZ8Hhoqae
 VvyMBq/w==
X-Gm-Gg: AYBFou3/DAMpc77FhsGfMlymr2DQAXiibM/zs0f/LlOKSoT/a60uoMyFleEQ5EU3VxU
 P7KBH0cdglfxbKL0UvefTlk0tsWzic/sm2+EL1FCFT6dq73/9/NDxaRbcTFeDaPqrDglosRUeN/
 fXkzqfKqg1S32BwC0ZLVh2jQg1iXgoKPtSoEzMNUXfUYeZcIS81TZXaWukKrVoWqEcQ13Wy6l9h
 7SbMtmMHFIPrrIZA1rls+/yd7gPaW+GPhL1kq1tzo1b0K30HPtD+64ELfxsAM0PQjK5BrVN69Cc
 RQ0vTt2qTyUG85/UDbPLvw37ojNrOch/8V5fkdXgJ3xegcOtgcrRjrvp1S7RVEn6rhm6JsbghjR
 qoOkVyxKb81WcbwB8ljt1MNy1qpKuK5IJweEtO94KNycGrP3CjsLuo02NsMueYidhvoOkh/ntHN
 Iqo+fmpuj1KWQQGOyx7Xjk1Nv5MvFi5s2PyUl/THXkDzC0ts4m9SXTOZtfZ91J56xXUf2Sk+m8q
 6nhXGKXg02qB0v5ni6kD5+nx46VQJ40WHQeNYQj1X9uzIvdFJfi9XE6E2AestpKm2bEsCEuSP6d
 VnbqyM3Zr28Noz/mRWGRgBCYDt3g8t3PPXlGbqeElZY+jXqI/0X5T2WNheXdtEtTeF4tjlbAnwZ
 DiVoKiLnHyhAbRpZ/8eh/0mRznx9AH2xWFDwqswJB0g==
X-Received: by 2002:a5d:64c4:0:b0:48e:2406:57d0 with SMTP id
 ffacd0b85a97d-48e3eb75f9dmr18301744f8f.19.1793096077062; 
 Tue, 27 Oct 2026 03:14:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8ddasm23990219f8f.48.2026.10.27.03.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 03:14:36 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 10:14:35 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6a890e3661cc83021cf22ff6cd8752e7112c77cd
X-Gerrit-Change-Number: 2055
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2055?usp=email>
X-Gerrit-Commit: 95a1644fc5903f54725fb3ef608246ba673b63ab
References: <gerrit.1793096063000.I6a890e3661cc83021cf22ff6cd8752e7112c77cd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk2MDYzMDAwLkk2YTg5MGUzNjYxY2M4MzAyMWNmMjJmZjZjZDg3NTJlNzExMmM3N2NkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c98d5cbfc8df94f85391c460294ad8aa70638304-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLeCd-00000000206-0SI7
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: transport-plugin:
 add sample obfs-test plugin
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7234038160342578485=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7234038160342578485==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4VlfbvmtLvE="; charset=UTF-8

--4VlfbvmtLvE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2055?usp=3Demail

to review the following change=2E
=


Change subject: transport-plugin: add sample obfs-test plugin
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

transport-plugin: add =
sample obfs-test plugin

Add a sample plugin to explain how the new transpo=
rt API is expected to
be implemented and work=2E It can be used for testing=
=2E

Change-Id: I6a890e3661cc83021cf22ff6cd8752e7112c77cd
Signed-off-by: Ro=
bin Tarsiger <rtt@dasyatidae=2Ecom>
[antonio@openvpn=2Enet: refactored comm=
its, restyled code]
[gianmarco@mandelbit=2Ecom: rebased, adapted to multiso=
cket, added CMake build]
---
M CMakeLists=2Etxt
M configure=2Eac
M include/=
openvpn-transport=2Eh
M src/openvpn/multi_io=2Ec
M src/openvpn/socket=2Ec
M=
 src/openvpn/socket=2Eh
M src/openvpn/transport=2Ec
M src/openvpn/transport=
=2Eh
M src/plugins/Makefile=2Eam
A src/plugins/obfs-test/Makefile=2Eam
A sr=
c/plugins/obfs-test/README=2Eobfs-test
A src/plugins/obfs-test/obfs-test-ar=
gs=2Ec
A src/plugins/obfs-test/obfs-test-munging=2Ec
A src/plugins/obfs-tes=
t/obfs-test-posix=2Ec
A src/plugins/obfs-test/obfs-test-win32=2Ec
A src/plu=
gins/obfs-test/obfs-test=2Ec
A src/plugins/obfs-test/obfs-test=2Eexports
A =
src/plugins/obfs-test/obfs-test=2Eh
18 files changed, 1,300 insertions(+), =
9 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/55/2055/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index=
 417d9a1=2E=2E4fb715a 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
=
@@ -39,6 +39,7 @@
 option(ENABLE_LZO "BUILD with lzo" ON)
 option(ENABLE_PK=
CS11 "BUILD with pkcs11-helper" ON)
 option(USE_WERROR "Treat compiler warn=
ings as errors (-Werror)" ON)
+option(ENABLE_PLUGIN_OBFS_TEST "Build the ob=
fs-test transport plugin" OFF)
 option(FAKE_ANDROID "Target Android but do =
not use actual cross compile/Android cmake to build for simple compile chec=
ks on Linux")
 option(ENABLE_DEBUG "Enable building with debug" OFF)
 
@@ -=
680,6 +681,36 @@
     endif ()
 endif ()
 
+if (ENABLE_PLUGIN_OBFS_TEST)
+ =
   set(OBFS_TEST_SOURCES
+        src/plugins/obfs-test/obfs-test=2Ec
+    =
    src/plugins/obfs-test/obfs-test-args=2Ec
+        src/plugins/obfs-test=
/obfs-test-munging=2Ec
+        )
+    if (WIN32)
+        list(APPEND OBFS=
_TEST_SOURCES src/plugins/obfs-test/obfs-test-win32=2Ec)
+    else ()
+    =
    list(APPEND OBFS_TEST_SOURCES src/plugins/obfs-test/obfs-test-posix=2Ec=
)
+    endif ()
+
+    add_library(openvpn-plugin-obfs-test MODULE ${OBFS_T=
EST_SOURCES})
+    set_target_properties(openvpn-plugin-obfs-test PROPERTIE=
S PREFIX "")
+    target_include_directories(openvpn-plugin-obfs-test PRIVA=
TE
+        ${CMAKE_CURRENT_SOURCE_DIR}/include
+        ${CMAKE_CURRENT_BI=
NARY_DIR}
+        )
+    if (${MBED})
+        target_include_directories(=
openvpn-plugin-obfs-test PRIVATE ${MBED_INCLUDE_PATH})
+    elseif (TARGET =
OpenSSL::Crypto)
+        target_include_directories(openvpn-plugin-obfs-te=
st PRIVATE
+            $<TARGET_PROPERTY:OpenSSL::Crypto,INTERFACE_INCLUDE=
_DIRECTORIES>)
+    endif ()
+    if (WIN32)
+        target_link_libraries=
(openvpn-plugin-obfs-test PRIVATE ws2_32)
+    endif ()
+    install(TARGET=
S openvpn-plugin-obfs-test DESTINATION ${PLUGIN_DIR})
+endif ()
+
 option(U=
T_ALLOW_BIG_ALLOC "Allow unit-tests to use > 1 GB of memory" ON)
 
 if (BUI=
LD_TESTING)
diff --git a/configure=2Eac b/configure=2Eac
index 0ac61b4=2E=
=2E6fec106 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -193,6 +193,=
13 @@
 )
 
 AC_ARG_ENABLE(
+	[plugin-obfs-test],
+	[AS_HELP_STRING([--enabl=
e-plugin-obfs-test], [enable obfs-test transport plugin @<:@default=3Dno@:>=
@])],
+	,
+	[enable_plugin_obfs_test=3D"no"]
+)
+
+AC_ARG_ENABLE(
 	[pam-dl=
open],
 	[AS_HELP_STRING([--enable-pam-dlopen], [dlopen libpam @<:@default=
=3Dno@:>@])],
 	,
@@ -1317,6 +1324,7 @@
 AM_CONDITIONAL([GIT_CHECKOUT], [te=
st "${GIT_CHECKOUT}" =3D "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], =
[test "${enable_plugin_auth_pam}" =3D "yes"])
 AM_CONDITIONAL([ENABLE_PLUGI=
N_DOWN_ROOT], [test "${enable_plugin_down_root}" =3D "yes"])
+AM_CONDITIONA=
L([ENABLE_PLUGIN_OBFS_TEST], [test "${enable_plugin_obfs_test}" =3D "yes"])=

 AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" =
=3D "yes"])
 AM_CONDITIONAL([OPENSSL_ENGINE], [test "${have_openssl_engine}=
" =3D "yes"])
 
@@ -1383,6 +1391,7 @@
 	src/plugins/auth-pam/Makefile
 	src=
/plugins/down-root/Makefile
 	src/tapctl/Makefile
+	src/plugins/obfs-test/M=
akefile
 	tests/Makefile
         tests/unit_tests/Makefile
         tests/=
unit_tests/example_test/Makefile
diff --git a/include/openvpn-transport=2Eh=
 b/include/openvpn-transport=2Eh
index 7f29696=2E=2E3dae65d 100644
--- a/in=
clude/openvpn-transport=2Eh
+++ b/include/openvpn-transport=2Eh
@@ -196,8 +=
196,12 @@
      * extended functions in the future=2E */
     unsigned feat=
ures;
 
+#ifdef _WIN32
+    openvpn_transport_native_event_t (*get_sock)(op=
envpn_transport_socket_t handle);
+#else
     /* Given a virtual indirect s=
ocket returns the descriptor associated */
     int (*get_sd)(openvpn_trans=
port_socket_t handle);
+#endif
 
     /* Given the bitmask rwflags, request=
 that event_set be provided with all
      * native events that should be w=
aited on such that whenever this virtual
diff --git a/src/openvpn/multi_io=
=2Ec b/src/openvpn/multi_io=2Ec
index bb5dde58=2E=2Ec289b10 100644
--- a/sr=
c/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -130,6 +130,11 @@
=
     }
 
     mi->socket_set_called =3D true;
+    if (proto_is_indirect(mi=
->context=2Ec2=2Elink_sockets[0]->info=2Eproto))
+    {
+        return;
+ =
   }
+
     if (proto_is_dgram(mi->context=2Ec2=2Elink_sockets[0]->info=2Ep=
roto))
     {
         socket_set(mi->context=2Ec2=2Elink_sockets[0], m->mu=
lti_io->es, EVENT_READ,
@@ -184,6 +189,30 @@
     return flags;
 }
 
+/*
+ =
* Hand the events registered by transport plugins back to them and replace
=
+ * them with a single EVENT_ARG_LINK_SOCKET event per indirect socket that=

+ * the plugin reports as ready=2E
+ */
+static int
+multi_io_pump_indirec=
t(struct multi_context *m, int status)
+{
+    for (int i =3D 0; i < m->top=
=2Ec1=2Elink_sockets_num; i++)
+    {
+        struct link_socket *sock =3D=
 m->top=2Ec2=2Elink_sockets[i];
+        unsigned int rwflags =3D socket_in=
direct_pump(sock, m->multi_io->esr, &status)
+                             =
  & (EVENT_READ | EVENT_WRITE);
+
+        if (rwflags)
+        {
+       =
     struct event_set_return *e =3D &m->multi_io->esr[status++];
+         =
   e->rwflags =3D rwflags;
+            e->arg =3D &sock->ev_arg;
+        =
}
+    }
+    return status;
+}
+
 int
 multi_io_wait(struct multi_context =
*m)
 {
@@ -232,8 +261,13 @@
     event_ctl(m->multi_io->es, m->top=2Ec2=2Ei=
notify_fd, EVENT_READ, MULTI_IO_FILE_CLOSE_WRITE);
 #endif
 
-    status =
=3D
-        event_wait(m->multi_io->es, &m->top=2Ec2=2Etimeval, m->multi_i=
o->esr, m->multi_io->maxevents);
+    /* keep one esr slot per link socket =
for multi_io_pump_indirect() */
+    status =3D event_wait(m->multi_io->es,=
 &m->top=2Ec2=2Etimeval, m->multi_io->esr,
+                        m->mult=
i_io->maxevents - m->top=2Ec1=2Elink_sockets_num);
+    if (status >=3D 0)
=
+    {
+        status =3D multi_io_pump_indirect(m, status);
+    }
     u=
pdate_time();
     m->multi_io->n_esr =3D 0;
     if (status > 0)
diff --gi=
t a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 07090f6=2E=2E224f=
86e 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -39=
,7 +39,6 @@
 #include "openvpn=2Eh"
 #include "forward=2Eh"
 #include "reso=
lve=2Eh"
-#include "transport=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -342,6 +34=
1,11 @@
                                     sock->info=2Etransport_plugin_=
argv,
                                     ai_family,
                     =
                bind_addresses);
+#ifdef _WIN32
+    openvpn_transport_nati=
ve_event_t ev =3D transport_get_sock(sock->indirect);
+    sock->rw_handle=
=2Eread =3D ev->read;
+    sock->rw_handle=2Ewrite =3D ev->write;
+#endif
 =
}
 
 unsigned
@@ -2737,6 +2741,7 @@
             {
                 event_c=
tl(es, socket_event_handle(s), rwflags, arg);
             }
+
            =
 if (persistent)
             {
                 *persistent =3D rwflags;
d=
iff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 4119330=
=2E=2E67f14a7 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=
=2Eh
@@ -843,6 +843,12 @@
 static inline event_t
 socket_event_handle(const=
 struct link_socket *sock)
 {
+#if defined(ENABLE_PLUGIN) && !defined(_WIN3=
2)
+    if (sock->indirect)
+    {
+        return transport_get_sock(sock-=
>indirect);
+    }
+#endif
 #ifdef _WIN32
     return &sock->rw_handle;
 #e=
lse
@@ -858,7 +864,11 @@
 static inline void
 socket_set_listen_persistent(=
struct link_socket *sock, struct event_set *es, void *arg)
 {
-    if (sock=
 && !sock->listen_persistent_queued && !sock->indirect)
+    if (sock && !s=
ock->listen_persistent_queued
+#ifdef ENABLE_PLUGIN
+        && !sock->indi=
rect
+#endif
+    )
     {
         event_ctl(es, socket_listen_event_handl=
e(sock), EVENT_READ, arg);
         sock->listen_persistent_queued =3D true=
;
diff --git a/src/openvpn/transport=2Ec b/src/openvpn/transport=2Ec
index =
8467916=2E=2E33434c0 100644
--- a/src/openvpn/transport=2Ec
+++ b/src/openv=
pn/transport=2Ec
@@ -289,10 +289,14 @@
     return translate_rwflags_in(ind=
irect->vtab->pump(indirect));
 }
 
-int
-transport_get_sd(openvpn_transport=
_socket_t indirect)
+openvpn_transport_native_event_t
+transport_get_sock(o=
penvpn_transport_socket_t indirect)
 {
+#ifdef _WIN32
+    return indirect-=
>vtab->get_sock(indirect);
+#else
     return indirect->vtab->get_sd(indire=
ct);
+#endif
 }
 
 void
diff --git a/src/openvpn/transport=2Eh b/src/openvp=
n/transport=2Eh
index 05422e6=2E=2E9292bca 100644
--- a/src/openvpn/transpo=
rt=2Eh
+++ b/src/openvpn/transport=2Eh
@@ -74,8 +74,7 @@
 void transport_re=
quest_events(openvpn_transport_socket_t indirect,
                         =
      struct event_set *es, unsigned rwflags);
 
-
-int transport_get_sd(op=
envpn_transport_socket_t indirect);
+openvpn_transport_native_event_t trans=
port_get_sock(openvpn_transport_socket_t indirect);
 
 /* NOTE: transport_w=
rite and transport_read implicitly downcast from a
  * ssize_t to an int on=
 return=2E Various link_socket_* functions
diff --git a/src/plugins/Makefil=
e=2Eam b/src/plugins/Makefile=2Eam
index 79cdcae=2E=2E3675538 100644
--- a/=
src/plugins/Makefile=2Eam
+++ b/src/plugins/Makefile=2Eam
@@ -12,4 +12,4 @@=

 MAINTAINERCLEANFILES =3D \
 	$(srcdir)/Makefile=2Ein
 
-SUBDIRS =3D auth-=
pam down-root
+SUBDIRS =3D auth-pam down-root obfs-test
diff --git a/src/pl=
ugins/obfs-test/Makefile=2Eam b/src/plugins/obfs-test/Makefile=2Eam
new fil=
e mode 100644
index 0000000=2E=2E9f0a7b2
--- /dev/null
+++ b/src/plugins/ob=
fs-test/Makefile=2Eam
@@ -0,0 +1,29 @@
+MAINTAINERCLEANFILES =3D \
+	$(srcd=
ir)/Makefile=2Ein
+
+AM_CFLAGS =3D \
+	-I$(top_srcdir)/include \
+	$(OPTION=
AL_CRYPTO_CFLAGS)
+
+if ENABLE_PLUGIN_OBFS_TEST
+plugin_LTLIBRARIES =3D ope=
nvpn-plugin-obfs-test=2Ela
+endif
+
+openvpn_plugin_obfs_test_la_SOURCES =
=3D \
+	obfs-test=2Ec \
+	obfs-test-munging=2Ec \
+	obfs-test-args=2Ec \
+	=
obfs-test=2Eexports
+
+if WIN32
+openvpn_plugin_obfs_test_la_SOURCES +=3D o=
bfs-test-win32=2Ec
+openvpn_plugin_obfs_test_la_LIBADD =3D -lws2_32
+else !=
WIN32
+openvpn_plugin_obfs_test_la_SOURCES +=3D obfs-test-posix=2Ec
+# No L=
IBADD necessary; we assume we can access the global symbol space,
+# and co=
re OpenVPN will already link with everything needed for sockets=2E
+endif
+=

+openvpn_plugin_obfs_test_la_LDFLAGS =3D $(AM_LDFLAGS) \
+	-export-symbols=
 "$(srcdir)/obfs-test=2Eexports" \
+	-module -shared -avoid-version -no-und=
efined
diff --git a/src/plugins/obfs-test/README=2Eobfs-test b/src/plugins/=
obfs-test/README=2Eobfs-test
new file mode 100644
index 0000000=2E=2Ebc52db=
d8
--- /dev/null
+++ b/src/plugins/obfs-test/README=2Eobfs-test
@@ -0,0 +1,=
33 @@
+obfs-test
+
+SYNOPSIS
+
+The obfs-test plugin is a proof of concept =
for supporting protocol
+obfuscation for OpenVPN via a socket intercept plu=
gin=2E
+
+BUILD
+
+You must specify --enable-plugin-obfs-test at configure =
time to
+trigger building this plugin=2E It should function on POSIX-y plat=
forms
+and Windows=2E
+
+USAGE
+
+To invoke this plugin, load it via an app=
ropriate plugin line in the
+configuration file, select it with a transport=
-plugin line and specify
+'proto indirect' rather than any other protocol:
=
+
+  plugin /path/to/openvpn-plugin-obfs-test=2Eso
+  transport-plugin /pat=
h/to/openvpn-plugin-obfs-test=2Eso [offset]
+  proto indirect
+
+The option=
al offset (0-42, default 0) must match on both ends=2E
+Packets will then b=
e passed via UDP, but they will
+also undergo a very basic content transfor=
mation, and the bind port
+will be altered (see obfs-test-munging=2Ec for d=
etails)=2E
+
+CAVEATS
+
+This has undergone basic functionality testing, bu=
t not any kind of
+full-on stress test=2E Extended socket or I/O handling o=
ptions are not
+supported at all=2E
diff --git a/src/plugins/obfs-test/obfs=
-test-args=2Ec b/src/plugins/obfs-test/obfs-test-args=2Ec
new file mode 100=
644
index 0000000=2E=2E20a0b65
--- /dev/null
+++ b/src/plugins/obfs-test/ob=
fs-test-args=2Ec
@@ -0,0 +1,60 @@
+#include "obfs-test=2Eh"
+
+openvpn_tran=
sport_args_t
+obfs_test_parseargs(void *plugin_handle,
+                   =
 const char *const *argv, int argc)
+{
+    struct obfs_test_args *args =3D=
 calloc(1, sizeof(struct obfs_test_args));
+    if (!args)
+    {
+        =
return NULL;
+    }
+
+    if (argc < 2)
+    {
+        args->offset =3D 0=
;
+    }
+    else if (argc =3D=3D 2)
+    {
+        char *end;
+        l=
ong offset =3D strtol(argv[1], &end, 10);
+        if (*end !=3D '\0')
+   =
     {
+            args->error =3D "offset must be a decimal number";
+   =
     }
+        else if (!(0 <=3D offset && offset <=3D 42))
+        {
+  =
          args->error =3D "offset must be between 0 and 42";
+        }
+  =
      else
+        {
+            args->offset =3D (int)offset;
+        }=

+    }
+    else
+    {
+        args->error =3D "too many arguments";
+  =
  }
+
+    return args;
+}
+
+const char *
+obfs_test_argerror(openvpn_tran=
sport_args_t args_)
+{
+    if (!args_)
+    {
+        return "cannot allo=
cate";
+    }
+    else
+    {
+        return ((struct obfs_test_args *)ar=
gs_)->error;
+    }
+}
+
+void
+obfs_test_freeargs(openvpn_transport_args_t=
 args_)
+{
+    struct obfs_test_args *args =3D (struct obfs_test_args *)ar=
gs_;
+    free(args);
+}
diff --git a/src/plugins/obfs-test/obfs-test-mungi=
ng=2Ec b/src/plugins/obfs-test/obfs-test-munging=2Ec
new file mode 100644
i=
ndex 0000000=2E=2E8d7bb21
--- /dev/null
+++ b/src/plugins/obfs-test/obfs-te=
st-munging=2Ec
@@ -0,0 +1,129 @@
+#include <string=2Eh>
+#include <errno=2E=
h>
+#include <stdbool=2Eh>
+#include "obfs-test=2Eh"
+#ifdef OPENVPN_TRANSP=
ORT_PLATFORM_POSIX
+#include <sys/socket=2Eh>
+#include <netinet/in=2Eh>
+t=
ypedef in_port_t obfs_test_in_port_t;
+#else
+#include <winsock2=2Eh>
+#inc=
lude <ws2tcpip=2Eh>
+typedef u_short obfs_test_in_port_t;
+#endif
+
+static=
 obfs_test_in_port_t
+munge_port(obfs_test_in_port_t port)
+{
+    return p=
ort ? port ^ 15 : 0;
+}
+
+/* Reversible=2E */
+void
+obfs_test_munge_addr(=
struct sockaddr *addr, openvpn_transport_socklen_t len)
+{
+    struct sock=
addr_in *inet;
+    struct sockaddr_in6 *inet6;
+
+    switch (addr->sa_fam=
ily)
+    {
+        case AF_INET:
+            inet =3D (struct sockaddr_i=
n *)addr;
+            inet->sin_port =3D munge_port(inet->sin_port);
+    =
        break;
+
+        case AF_INET6:
+            inet6 =3D (struct soc=
kaddr_in6 *)addr;
+            inet6->sin6_port =3D munge_port(inet6->sin6_=
port);
+            break;
+
+        default:
+            break;
+    }
+=
}
+
+/* Six fixed bytes, six repeated bytes=2E It's only a silly transforma=
tion=2E */
+#define MUNGE_OVERHEAD 12
+
+size_t
+obfs_test_max_munged_buf_s=
ize(size_t clear_size)
+{
+    return clear_size + MUNGE_OVERHEAD;
+}
+
+op=
envpn_transport_ssize_t
+obfs_test_unmunge_buf(struct obfs_test_args *how,
=
+                      char *buf, size_t len)
+{
+    size_t i;
+
+    if (=
len < 6)
+    {
+        goto bad;
+    }
+    for (i =3D 0; i < 6; i++)
+ =
   {
+        if (buf[i] !=3D (char)(i + how->offset))
+        {
+        =
    goto bad;
+        }
+    }
+
+    for (i =3D 0; i < 6 && (6 + 2 * i) <=
 len; i++)
+    {
+        if (len < (6 + 2 * i + 1) || buf[6 + 2 * i] !=3D=
 buf[6 + 2 * i + 1])
+        {
+            goto bad;
+        }
+        =
buf[i] =3D buf[6 + 2 * i];
+    }
+
+    if (len > 18)
+    {
+        memm=
ove(buf + 6, buf + 18, len - 18);
+        len -=3D 12;
+    }
+    else
+ =
   {
+        len -=3D 6;
+        len /=3D 2;
+    }
+
+    return len;
+
=
+bad:
+    /* TODO: this really isn't the best way to report this error */
=
+    errno =3D EIO;
+    return -1;
+}
+
+/* out must have space for len+MU=
NGE_OVERHEAD bytes=2E out and in must
+ * not overlap=2E */
+size_t
+obfs_t=
est_munge_buf(struct obfs_test_args *how,
+                    char *out, c=
onst char *in, size_t len)
+{
+    size_t i, n;
+    size_t out_len =3D 6;
=
+
+    for (i =3D 0; i < 6; i++)
+    {
+        out[i] =3D (char)(i + how-=
>offset);
+    }
+    n =3D len < 6 ? len : 6;
+    for (i =3D 0; i < n; i+=
+)
+    {
+        out[6 + 2 * i] =3D out[6 + 2 * i + 1] =3D in[i];
+    }
=
+    if (len > 6)
+    {
+        memmove(out + 18, in + 6, len - 6);
+    =
    out_len =3D len + 12;
+    }
+    else
+    {
+        out_len =3D 6 + =
2 * len;
+    }
+
+    return out_len;
+}
diff --git a/src/plugins/obfs-tes=
t/obfs-test-posix=2Ec b/src/plugins/obfs-test/obfs-test-posix=2Ec
new file =
mode 100644
index 0000000=2E=2Eea4ba20
--- /dev/null
+++ b/src/plugins/obfs=
-test/obfs-test-posix=2Ec
@@ -0,0 +1,216 @@
+#include "obfs-test=2Eh"
+#inc=
lude <stdbool=2Eh>
+#include <string=2Eh>
+#include <err=2Eh>
+#include <er=
rno=2Eh>
+#include <unistd=2Eh>
+#include <fcntl=2Eh>
+#include <sys/socket=
=2Eh>
+#include <netinet/in=2Eh>
+
+struct obfs_test_socket_posix
+{
+    s=
truct openvpn_transport_socket handle;
+    struct obfs_test_args args;
+  =
  struct obfs_test_context *ctx;
+    int fd;
+    unsigned last_rwflags;
+=
};
+
+static void
+free_socket(struct obfs_test_socket_posix *sock)
+{
+   =
 if (!sock)
+    {
+        return;
+    }
+    if (sock->fd !=3D -1)
+    =
{
+        close(sock->fd);
+    }
+    free(sock);
+}
+
+static openvpn_tr=
ansport_socket_t
+obfs_test_posix_bind(void *plugin_handle, openvpn_transpo=
rt_args_t args,
+                     const struct sockaddr *addr, socklen_=
t len)
+{
+    struct obfs_test_socket_posix *sock =3D NULL;
+    struct so=
ckaddr *addr_rev =3D NULL;
+
+    addr_rev =3D calloc(1, len);
+    if (!ad=
dr_rev)
+    {
+        goto error;
+    }
+    memcpy(addr_rev, addr, len)=
;
+    obfs_test_munge_addr(addr_rev, len);
+
+    sock =3D calloc(1, sizeo=
f(struct obfs_test_socket_posix));
+    if (!sock)
+    {
+        goto err=
or;
+    }
+    sock->handle=2Evtab =3D &obfs_test_socket_vtab;
+    sock->=
ctx =3D (struct obfs_test_context *)plugin_handle;
+    memcpy(&sock->args,=
 args, sizeof(sock->args));
+    /* Note that sock->fd isn't -1 yet=2E Set =
it explicitly if there are ever any
+     * error exits before the socket()=
 call=2E */
+
+    sock->fd =3D socket(addr->sa_family, SOCK_DGRAM, IPPROTO=
_UDP);
+    if (sock->fd =3D=3D -1)
+    {
+        goto error;
+    }
+   =
 if (fcntl(sock->fd, F_SETFL, fcntl(sock->fd, F_GETFL) | O_NONBLOCK))
+    =
{
+        goto error;
+    }
+
+    if (bind(sock->fd, addr_rev, len))
+  =
  {
+        goto error;
+    }
+    free(addr_rev);
+    return &sock->han=
dle;
+
+error:
+    free_socket(sock);
+    free(addr_rev);
+    return NUL=
L;
+}
+
+static int
+obfs_test_posix_get_sd(openvpn_transport_socket_t hand=
le)
+{
+    return ((struct obfs_test_socket_posix *)handle)->fd;
+}
+
+sta=
tic void
+obfs_test_posix_request_event(openvpn_transport_socket_t handle,
=
+                              openvpn_transport_event_set_handle_t event_s=
et, unsigned rwflags)
+{
+    obfs_test_log(((struct obfs_test_socket_posix=
 *)handle)->ctx,
+                  PLOG_DEBUG, "request-event: %d", rwflag=
s);
+    ((struct obfs_test_socket_posix *)handle)->last_rwflags =3D 0;
+  =
  if (rwflags)
+    {
+        event_set->vtab->set_event(event_set, ((stru=
ct obfs_test_socket_posix *)handle)->fd,
+                                 =
  rwflags, handle);
+    }
+}
+
+static bool
+obfs_test_posix_update_event(=
openvpn_transport_socket_t handle, void *arg, unsigned rwflags)
+{
+    obf=
s_test_log(((struct obfs_test_socket_posix *)handle)->ctx,
+               =
   PLOG_DEBUG, "update-event: %p, %p, %d", handle, arg, rwflags);
+    if (=
arg !=3D handle)
+    {
+        return false;
+    }
+    ((struct obfs_te=
st_socket_posix *)handle)->last_rwflags |=3D rwflags;
+    return true;
+}
=
+
+static unsigned
+obfs_test_posix_pump(openvpn_transport_socket_t handle)=

+{
+    obfs_test_log(((struct obfs_test_socket_posix *)handle)->ctx,
+   =
               PLOG_DEBUG, "pump -> %d", ((struct obfs_test_socket_posix *)=
handle)->last_rwflags);
+    return ((struct obfs_test_socket_posix *)handl=
e)->last_rwflags;
+}
+
+static ssize_t
+obfs_test_posix_recvfrom(openvpn_tr=
ansport_socket_t handle, void *buf, size_t len,
+                         s=
truct sockaddr *addr, socklen_t *addrlen)
+{
+    int fd =3D ((struct obfs_=
test_socket_posix *)handle)->fd;
+    socklen_t addrcap =3D *addrlen;
+    =
ssize_t result;
+
+again:
+    *addrlen =3D addrcap;
+    result =3D recvfr=
om(fd, buf, len, 0, addr, addrlen);
+    if (result < 0 && errno =3D=3D EAG=
AIN)
+    {
+        ((struct obfs_test_socket_posix *)handle)->last_rwflag=
s &=3D ~OPENVPN_TRANSPORT_EVENT_READ;
+    }
+    if (result >=3D 0 && *add=
rlen > 0)
+    {
+        obfs_test_munge_addr(addr, *addrlen);
+    }
+   =
 if (result > 0)
+    {
+        struct obfs_test_args *how =3D &((struct o=
bfs_test_socket_posix *)handle)->args;
+        result =3D obfs_test_unmung=
e_buf(how, buf, (size_t)result);
+        if (result < 0)
+        {
+     =
       /* Pretend that read never happened=2E */
+            goto again;
+=
        }
+    }
+
+    obfs_test_log(((struct obfs_test_socket_posix *)han=
dle)->ctx,
+                  PLOG_DEBUG, "recvfrom(%d) -> %d", (int)len, (=
int)result);
+    return result;
+}
+
+static ssize_t
+obfs_test_posix_send=
to(openvpn_transport_socket_t handle, const void *buf, size_t len,
+       =
                const struct sockaddr *addr, socklen_t addrlen)
+{
+    int=
 fd =3D ((struct obfs_test_socket_posix *)handle)->fd;
+    struct sockaddr=
 *addr_rev =3D calloc(1, addrlen);
+    void *buf_munged =3D malloc(obfs_te=
st_max_munged_buf_size(len));
+    size_t len_munged;
+    ssize_t result;
=
+    if (!addr_rev || !buf_munged)
+    {
+        goto error;
+    }
+
+  =
  memcpy(addr_rev, addr, addrlen);
+    obfs_test_munge_addr(addr_rev, addr=
len);
+    struct obfs_test_args *how =3D &((struct obfs_test_socket_posix =
*)handle)->args;
+    len_munged =3D obfs_test_munge_buf(how, buf_munged, b=
uf, len);
+    result =3D sendto(fd, buf_munged, len_munged, 0, addr_rev, a=
ddrlen);
+    if (result < 0 && errno =3D=3D EAGAIN)
+    {
+        ((stru=
ct obfs_test_socket_posix *)handle)->last_rwflags &=3D ~OPENVPN_TRANSPORT_E=
VENT_WRITE;
+    }
+    /* TODO: not clear what to do here for partial tran=
sfers=2E */
+    if (result > (ssize_t)len)
+    {
+        result =3D len;=

+    }
+    obfs_test_log(((struct obfs_test_socket_posix *)handle)->ctx,
=
+                  PLOG_DEBUG, "sendto(%d) -> %d", (int)len, (int)result);
=
+    free(addr_rev);
+    free(buf_munged);
+    return result;
+
+error:
+=
    free(addr_rev);
+    free(buf_munged);
+    return -1;
+}
+
+static voi=
d
+obfs_test_posix_close(openvpn_transport_socket_t handle)
+{
+    free_so=
cket((struct obfs_test_socket_posix *)handle);
+}
+
+void
+obfs_test_initia=
lize_vtabs_platform(void)
+{
+    obfs_test_bind_vtab=2Ebind =3D obfs_test_=
posix_bind;
+    obfs_test_socket_vtab=2Eget_sd =3D obfs_test_posix_get_sd;=

+    obfs_test_socket_vtab=2Erequest_event =3D obfs_test_posix_request_eve=
nt;
+    obfs_test_socket_vtab=2Eupdate_event =3D obfs_test_posix_update_ev=
ent;
+    obfs_test_socket_vtab=2Epump =3D obfs_test_posix_pump;
+    obfs_=
test_socket_vtab=2Erecvfrom =3D obfs_test_posix_recvfrom;
+    obfs_test_so=
cket_vtab=2Esendto =3D obfs_test_posix_sendto;
+    obfs_test_socket_vtab=
=2Eclose =3D obfs_test_posix_close;
+}
diff --git a/src/plugins/obfs-test/o=
bfs-test-win32=2Ec b/src/plugins/obfs-test/obfs-test-win32=2Ec
new file mod=
e 100644
index 0000000=2E=2Eecc9ec8
--- /dev/null
+++ b/src/plugins/obfs-te=
st/obfs-test-win32=2Ec
@@ -0,0 +1,588 @@
+#include "obfs-test=2Eh"
+#includ=
e <stdbool=2Eh>
+#include <string=2Eh>
+#include <stdio=2Eh>
+#include <std=
arg=2Eh>
+#include <windows=2Eh>
+#include <winsock2=2Eh>
+#include <assert=
=2Eh>
+
+static inline bool
+is_invalid_handle(HANDLE h)
+{
+    return h =
=3D=3D NULL || h =3D=3D INVALID_HANDLE_VALUE;
+}
+
+typedef enum
+{
+    IO=
_SLOT_DORMANT, /* must be 0 for calloc purposes */
+    IO_SLOT_PENDING,
+ =
   /* success/failure is determined by succeeded flag in COMPLETE state */
=
+    IO_SLOT_COMPLETE
+} io_slot_status_t;
+
+/* must be calloc'able */
+st=
ruct io_slot
+{
+    struct obfs_test_context *ctx;
+    io_slot_status_t s=
tatus;
+    OVERLAPPED overlapped;
+    SOCKET socket;
+    SOCKADDR_STORAG=
E addr;
+    int addr_len, addr_cap;
+    DWORD bytes, flags;
+    bool suc=
ceeded;
+    int wsa_error;
+
+    /* realloc'd as needed; always private c=
opy, never aliased */
+    char *buf;
+    size_t buf_len, buf_cap;
+};
+
+=
static bool
+setup_io_slot(struct io_slot *slot, struct obfs_test_context *=
ctx,
+              SOCKET socket, HANDLE event)
+{
+    slot->ctx =3D ctx;=

+    slot->status =3D IO_SLOT_DORMANT;
+    slot->addr_cap =3D sizeof(SOCK=
ADDR_STORAGE);
+    slot->socket =3D socket;
+    slot->overlapped=2EhEvent=
 =3D event;
+    return true;
+}
+
+/* Note that this assumes any I/O has a=
lready been implicitly canceled (via closesocket),
+ * but not waited for y=
et=2E */
+static bool
+destroy_io_slot(struct io_slot *slot)
+{
+    if (sl=
ot->status =3D=3D IO_SLOT_PENDING)
+    {
+        DWORD bytes, flags;
+   =
     BOOL ok =3D WSAGetOverlappedResult(slot->socket, &slot->overlapped, &b=
ytes,
+                                         TRUE /* wait */, &flags);
+=
        if (!ok && WSAGetLastError() =3D=3D WSA_IO_INCOMPLETE)
+        {
+=
            obfs_test_log(slot->ctx, PLOG_ERR,
+                          "=
destroying I/O slot: canceled operation is still incomplete after wait?!");=

+            return false;
+        }
+    }
+
+    slot->status =3D IO_SL=
OT_DORMANT;
+    return true;
+}
+
+/* FIXME: aborts on error=2E */
+static=
 void
+resize_io_buf(struct io_slot *slot, size_t cap)
+{
+    if (slot->bu=
f)
+    {
+        free(slot->buf);
+        slot->buf =3D NULL;
+    }
+
+=
    char *new_buf =3D malloc(cap);
+    if (!new_buf)
+    {
+        abort=
();
+    }
+    slot->buf =3D new_buf;
+    slot->buf_cap =3D cap;
+}
+
+st=
ruct obfs_test_socket_win32
+{
+    struct openvpn_transport_socket handle;=

+    struct obfs_test_args args;
+    struct obfs_test_context *ctx;
+    =
SOCKET socket;
+
+    /* Write is ready when idle; read is not-ready when i=
dle=2E Both level-triggered=2E */
+    struct openvpn_transport_win32_event=
_pair completion_events;
+    struct io_slot slot_read, slot_write;
+
+    =
int last_rwflags;
+};
+
+static void
+free_socket(struct obfs_test_socket_w=
in32 *sock)
+{
+    /* This only ever becomes false in strange situations w=
here we leak the entire structure for
+     * lack of anything else to do=
=2E */
+    bool can_free =3D true;
+
+    if (!sock)
+    {
+        retur=
n;
+    }
+    if (sock->socket !=3D INVALID_SOCKET)
+    {
+        closes=
ocket(sock->socket);
+    }
+
+    /* closesocket cancels any pending overl=
apped I/O, but we still have to potentially
+     * wait for it here before=
 we can free the buffers=2E This has to happen before closing
+     * the e=
vent handles=2E
+     *
+     * If we can't figure out when the canceled ov=
erlapped I/O is done, for any reason, we defensively
+     * leak the entir=
e structure; freeing it would be permitting the system to corrupt memory la=
ter=2E
+     * TODO: possibly abort() instead, but make sure we've handled =
all the possible "have to try again"
+     * cases above first
+     */
+  =
  if (!destroy_io_slot(&sock->slot_read))
+    {
+        can_free =3D fals=
e;
+    }
+    if (!destroy_io_slot(&sock->slot_write))
+    {
+        can=
_free =3D false;
+    }
+    if (!can_free)
+    {
+        /* Skip deiniti=
alization of everything else=2E Doomed=2E */
+        obfs_test_log(sock->c=
tx, PLOG_ERR, "doomed, leaking the entire socket structure");
+        retu=
rn;
+    }
+
+    if (!is_invalid_handle(sock->completion_events=2Eread))
+=
    {
+        CloseHandle(sock->completion_events=2Eread);
+    }
+    if =
(!is_invalid_handle(sock->completion_events=2Ewrite))
+    {
+        Close=
Handle(sock->completion_events=2Ewrite);
+    }
+
+    free(sock);
+}
+
+st=
atic openvpn_transport_socket_t
+obfs_test_win32_bind(void *plugin_handle, =
openvpn_transport_args_t args,
+                     const struct sockaddr =
*addr, openvpn_transport_socklen_t len)
+{
+    struct obfs_test_socket_win=
32 *sock =3D NULL;
+    struct sockaddr *addr_rev =3D NULL;
+
+    /* TODO:=
 would be nice to factor out some of these sequences */
+    addr_rev =3D c=
alloc(1, len);
+    if (!addr_rev)
+    {
+        goto error;
+    }
+    =
memcpy(addr_rev, addr, len);
+    obfs_test_munge_addr(addr_rev, len);
+
+ =
   sock =3D calloc(1, sizeof(struct obfs_test_socket_win32));
+    if (!soc=
k)
+    {
+        goto error;
+    }
+    sock->handle=2Evtab =3D &obfs_te=
st_socket_vtab;
+    sock->ctx =3D (struct obfs_test_context *)plugin_handl=
e;
+    memcpy(&sock->args, args, sizeof(sock->args));
+
+    /* Preemptive=
ly initialize the members of some Win32 types so error exits are okay later=
 on=2E
+     * HANDLEs of NULL are considered invalid per above=2E */
+    =
sock->socket =3D INVALID_SOCKET;
+
+    sock->socket =3D socket(addr_rev->s=
a_family, SOCK_DGRAM, IPPROTO_UDP);
+    if (sock->socket =3D=3D INVALID_SO=
CKET)
+    {
+        goto error;
+    }
+
+    /* See above: write is read=
y when idle, read is not-ready when idle=2E */
+    sock->completion_events=
=2Eread =3D CreateEvent(NULL, TRUE, FALSE, NULL);
+    sock->completion_eve=
nts=2Ewrite =3D CreateEvent(NULL, TRUE, TRUE, NULL);
+    if (is_invalid_ha=
ndle(sock->completion_events=2Eread) || is_invalid_handle(sock->completion_=
events=2Ewrite))
+    {
+        goto error;
+    }
+    if (!setup_io_slot=
(&sock->slot_read, sock->ctx,
+                       sock->socket, sock->c=
ompletion_events=2Eread))
+    {
+        goto error;
+    }
+    if (!setu=
p_io_slot(&sock->slot_write, sock->ctx,
+                       sock->socke=
t, sock->completion_events=2Ewrite))
+    {
+        goto error;
+    }
+
+=
    if (bind(sock->socket, addr_rev, len))
+    {
+        goto error;
+   =
 }
+    free(addr_rev);
+    return &sock->handle;
+
+error:
+    obfs_test=
_log((struct obfs_test_context *)plugin_handle, PLOG_ERR,
+                =
  "bind failure: WSA error =3D %d", WSAGetLastError());
+    free_socket(so=
ck);
+    free(addr_rev);
+    return NULL;
+}
+
+static void
+handle_sendr=
ecv_return(struct io_slot *slot, int status)
+{
+    if (status =3D=3D 0)
+=
    {
+        /* Immediately completed=2E Set the event so it stays consis=
tent=2E */
+        slot->status =3D IO_SLOT_COMPLETE;
+        slot->succe=
eded =3D true;
+        slot->buf_len =3D slot->bytes;
+        SetEvent(sl=
ot->overlapped=2EhEvent);
+    }
+    else if (WSAGetLastError() =3D=3D WSA=
_IO_PENDING)
+    {
+        /* Queued=2E */
+        slot->status =3D IO_S=
LOT_PENDING;
+    }
+    else
+    {
+        /* Error=2E */
+        slot-=
>status =3D IO_SLOT_COMPLETE;
+        slot->succeeded =3D false;
+        =
slot->wsa_error =3D WSAGetLastError();
+        slot->buf_len =3D 0;
+    }=

+}
+
+static void
+queue_new_read(struct io_slot *slot, size_t cap)
+{
+  =
  int status;
+    WSABUF sbuf;
+    assert(slot->status =3D=3D IO_SLOT_DOR=
MANT);
+
+    ResetEvent(slot->overlapped=2EhEvent);
+    resize_io_buf(slo=
t, cap);
+    sbuf=2Ebuf =3D slot->buf;
+    sbuf=2Elen =3D (ULONG)slot->bu=
f_cap;
+    slot->addr_len =3D slot->addr_cap;
+    slot->flags =3D 0;
+   =
 status =3D WSARecvFrom(slot->socket, &sbuf, 1, &slot->bytes, &slot->flags,=

+                         (struct sockaddr *)&slot->addr, &slot->addr_len,=

+                         &slot->overlapped, NULL);
+    handle_sendrecv_r=
eturn(slot, status);
+}
+
+/* write slot buffer must already be full=2E */
=
+static void
+queue_new_write(struct io_slot *slot)
+{
+    int status;
+  =
  WSABUF sbuf;
+    assert(slot->status =3D=3D IO_SLOT_COMPLETE || slot->st=
atus =3D=3D IO_SLOT_DORMANT);
+
+    ResetEvent(slot->overlapped=2EhEvent);=

+    sbuf=2Ebuf =3D slot->buf;
+    sbuf=2Elen =3D (ULONG)slot->buf_len;
+=
    slot->flags =3D 0;
+    status =3D WSASendTo(slot->socket, &sbuf, 1, &s=
lot->bytes, 0 /* flags */,
+                       (struct sockaddr *)&slot=
->addr, slot->addr_len,
+                       &slot->overlapped, NULL);
+=
    handle_sendrecv_return(slot, status);
+}
+
+static void
+ensure_pending=
_read(struct obfs_test_socket_win32 *sock)
+{
+    struct io_slot *slot =3D=
 &sock->slot_read;
+    switch (slot->status)
+    {
+        case IO_SLOT_=
PENDING:
+            return;
+
+        case IO_SLOT_COMPLETE:
+          =
  /* Set the event manually here just in case=2E */
+            SetEvent(s=
lot->overlapped=2EhEvent);
+            return;
+
+        case IO_SLOT_DOR=
MANT:
+            /* TODO: we don't propagate max read size here, so we ju=
st have to assume the maximum=2E */
+            queue_new_read(slot, 65536=
);
+            return;
+
+        default:
+            abort();
+    }
+}=

+
+static bool
+complete_pending_operation(struct io_slot *slot)
+{
+    D=
WORD bytes, flags;
+    BOOL ok;
+
+    switch (slot->status)
+    {
+     =
   case IO_SLOT_DORMANT:
+            /* TODO: shouldn't get here? */
+    =
        return false;
+
+        case IO_SLOT_COMPLETE:
+            return=
 true;
+
+        case IO_SLOT_PENDING:
+            ok =3D WSAGetOverlappe=
dResult(slot->socket, &slot->overlapped, &bytes,
+                         =
               FALSE /* don't wait */, &flags);
+            if (!ok && WSA=
GetLastError() =3D=3D WSA_IO_INCOMPLETE)
+            {
+                /*=
 Still waiting=2E */
+                return false;
+            }
+       =
     else if (ok)
+            {
+                /* Completed=2E slot->add=
r_len has already been updated=2E */
+                slot->buf_len =3D byt=
es;
+                slot->status =3D IO_SLOT_COMPLETE;
+                sl=
ot->succeeded =3D true;
+                return true;
+            }
+     =
       else
+            {
+                /* Error=2E */
+               =
 slot->buf_len =3D 0;
+                slot->status =3D IO_SLOT_COMPLETE;
+=
                slot->succeeded =3D false;
+                slot->wsa_error=
 =3D WSAGetLastError();
+                return true;
+            }
+
+   =
     default:
+            abort();
+    }
+}
+
+static bool
+complete_pend=
ing_read(struct obfs_test_socket_win32 *sock)
+{
+    bool done =3D complet=
e_pending_operation(&sock->slot_read);
+    if (done)
+    {
+        Reset=
Event(sock->completion_events=2Eread);
+    }
+    return done;
+}
+
+stati=
c void
+consumed_pending_read(struct obfs_test_socket_win32 *sock)
+{
+    =
struct io_slot *slot =3D &sock->slot_read;
+    assert(slot->status =3D=3D =
IO_SLOT_COMPLETE);
+    slot->status =3D IO_SLOT_DORMANT;
+    slot->succee=
ded =3D false;
+    ResetEvent(slot->overlapped=2EhEvent);
+}
+
+static inl=
ine bool
+complete_pending_write(struct obfs_test_socket_win32 *sock)
+{
+ =
   bool done =3D complete_pending_operation(&sock->slot_write);
+    if (do=
ne)
+    {
+        SetEvent(sock->completion_events=2Ewrite);
+    }
+    =
return done;
+}
+
+static void
+obfs_test_win32_request_event(openvpn_trans=
port_socket_t handle,
+                              openvpn_transport_even=
t_set_handle_t event_set, unsigned rwflags)
+{
+    struct obfs_test_socket=
_win32 *sock =3D (struct obfs_test_socket_win32 *)handle;
+    obfs_test_lo=
g(sock->ctx, PLOG_DEBUG, "request-event: %d", rwflags);
+    sock->last_rwf=
lags =3D 0;
+
+    if (rwflags & OPENVPN_TRANSPORT_EVENT_READ)
+    {
+    =
    ensure_pending_read(sock);
+    }
+    if (rwflags)
+    {
+        eve=
nt_set->vtab->set_event(event_set, &sock->completion_events, rwflags, handl=
e);
+    }
+}
+
+static bool
+obfs_test_win32_update_event(openvpn_transpor=
t_socket_t handle, void *arg, unsigned rwflags)
+{
+    obfs_test_log(((str=
uct obfs_test_socket_win32 *)handle)->ctx, PLOG_DEBUG,
+                  "=
update-event: %p, %p, %d", handle, arg, rwflags);
+    if (arg !=3D handle)=

+    {
+        return false;
+    }
+    ((struct obfs_test_socket_win32 =
*)handle)->last_rwflags |=3D rwflags;
+    return true;
+}
+
+static unsign=
ed
+obfs_test_win32_pump(openvpn_transport_socket_t handle)
+{
+    struct =
obfs_test_socket_win32 *sock =3D (struct obfs_test_socket_win32 *)handle;
+=
    unsigned result =3D 0;
+
+    if ((sock->last_rwflags & OPENVPN_TRANSPO=
RT_EVENT_READ) && complete_pending_read(sock))
+    {
+        result |=3D =
OPENVPN_TRANSPORT_EVENT_READ;
+    }
+    if ((sock->last_rwflags & OPENVPN=
_TRANSPORT_EVENT_WRITE)
+        && (sock->slot_write=2Estatus !=3D IO_SLOT=
_PENDING || complete_pending_write(sock)))
+    {
+        result |=3D OPEN=
VPN_TRANSPORT_EVENT_WRITE;
+    }
+
+    obfs_test_log(sock->ctx, PLOG_DEBU=
G, "pump -> %d", result);
+    return result;
+}
+
+static openvpn_transpor=
t_ssize_t
+obfs_test_win32_recvfrom(openvpn_transport_socket_t handle, void=
 *buf, size_t len,
+                         struct sockaddr *addr, openvpn=
_transport_socklen_t *addrlen)
+{
+    struct obfs_test_socket_win32 *sock =
=3D (struct obfs_test_socket_win32 *)handle;
+    if (!complete_pending_rea=
d(sock))
+    {
+        WSASetLastError(WSA_IO_INCOMPLETE);
+        retur=
n -1;
+    }
+
+    if (!sock->slot_read=2Esucceeded)
+    {
+        int w=
sa_error =3D sock->slot_read=2Ewsa_error;
+        consumed_pending_read(so=
ck);
+        WSASetLastError(wsa_error);
+        return -1;
+    }
+
+   =
 /* sock->slot_read now has valid data=2E */
+    char *working_buf =3D soc=
k->slot_read=2Ebuf;
+    openvpn_transport_ssize_t unmunged_len =3D
+      =
  obfs_test_unmunge_buf(&sock->args, working_buf,
+                        =
      sock->slot_read=2Ebuf_len);
+    if (unmunged_len < 0)
+    {
+      =
  /* Act as though this read never happened=2E Assume one was queued before=
, so it should
+         * still remain queued=2E */
+        consumed_pend=
ing_read(sock);
+        ensure_pending_read(sock);
+        WSASetLastErro=
r(WSA_IO_INCOMPLETE);
+        return -1;
+    }
+
+    size_t copy_len =3D=
 unmunged_len;
+    if (copy_len > len)
+    {
+        copy_len =3D len;
+=
    }
+    memcpy(buf, sock->slot_read=2Ebuf, copy_len);
+
+    /* TODO: sh=
ouldn't truncate, should signal error (but this shouldn't happen for any
+ =
    * supported address families anyway)=2E */
+    openvpn_transport_sockl=
en_t addr_copy_len =3D *addrlen;
+    if (sock->slot_read=2Eaddr_len < addr=
_copy_len)
+    {
+        addr_copy_len =3D sock->slot_read=2Eaddr_len;
+ =
   }
+    memcpy(addr, &sock->slot_read=2Eaddr, addr_copy_len);
+    *addrl=
en =3D addr_copy_len;
+    if (addr_copy_len > 0)
+    {
+        obfs_test=
_munge_addr(addr, addr_copy_len);
+    }
+
+    /* Reset the I/O slot befor=
e returning=2E */
+    consumed_pending_read(sock);
+    return copy_len;
+=
}
+
+static openvpn_transport_ssize_t
+obfs_test_win32_sendto(openvpn_trans=
port_socket_t handle, const void *buf, size_t len,
+                       =
const struct sockaddr *addr, openvpn_transport_socklen_t addrlen)
+{
+    s=
truct obfs_test_socket_win32 *sock =3D (struct obfs_test_socket_win32 *)han=
dle;
+    complete_pending_write(sock);
+
+    if (sock->slot_write=2Estatu=
s =3D=3D IO_SLOT_PENDING)
+    {
+        /* This shouldn't really happen, =
but=2E */
+        WSASetLastError(WSAEWOULDBLOCK);
+        return -1;
+  =
  }
+
+    if (addrlen > sock->slot_write=2Eaddr_cap)
+    {
+        /* Sh=
ouldn't happen=2E */
+        WSASetLastError(WSAEFAULT);
+        return -=
1;
+    }
+
+    /* TODO: propagate previous write errors---what does core =
expect here? */
+    memcpy(&sock->slot_write=2Eaddr, addr, addrlen);
+    =
sock->slot_write=2Eaddr_len =3D addrlen;
+    if (addrlen > 0)
+    {
+    =
    obfs_test_munge_addr((struct sockaddr *)&sock->slot_write=2Eaddr, addrl=
en);
+    }
+    resize_io_buf(&sock->slot_write, obfs_test_max_munged_buf_=
size(len));
+    sock->slot_write=2Ebuf_len =3D
+        obfs_test_munge_bu=
f(&sock->args, sock->slot_write=2Ebuf, buf, len);
+    queue_new_write(&soc=
k->slot_write);
+    switch (sock->slot_write=2Estatus)
+    {
+        cas=
e IO_SLOT_PENDING:
+            /* The network hasn't given us an error yet=
, but _we've_ consumed all the bytes=2E
+             * =2E=2E=2E sort of=
=2E */
+            return len;
+
+        case IO_SLOT_DORMANT:
+         =
   /* Huh?? But we just queued a write=2E */
+            abort();
+
+     =
   case IO_SLOT_COMPLETE:
+            if (sock->slot_write=2Esucceeded)
+ =
           {
+                /* TODO: more partial length handling */
+   =
             return len;
+            }
+            else
+            {
+ =
               return -1;
+            }
+
+        default:
+            a=
bort();
+    }
+}
+
+static openvpn_transport_native_event_t
+obfs_test_win=
32_get_sock(openvpn_transport_socket_t handle)
+{
+    struct obfs_test_soc=
ket_win32 *sock =3D (struct obfs_test_socket_win32 *)handle;
+    return &s=
ock->completion_events;
+}
+
+static void
+obfs_test_win32_close(openvpn_tr=
ansport_socket_t handle)
+{
+    free_socket((struct obfs_test_socket_win32=
 *)handle);
+}
+
+void
+obfs_test_initialize_vtabs_platform(void)
+{
+    o=
bfs_test_bind_vtab=2Ebind =3D obfs_test_win32_bind;
+    obfs_test_socket_v=
tab=2Eget_sock =3D obfs_test_win32_get_sock;
+    obfs_test_socket_vtab=2Er=
equest_event =3D obfs_test_win32_request_event;
+    obfs_test_socket_vtab=
=2Eupdate_event =3D obfs_test_win32_update_event;
+    obfs_test_socket_vta=
b=2Epump =3D obfs_test_win32_pump;
+    obfs_test_socket_vtab=2Erecvfrom =
=3D obfs_test_win32_recvfrom;
+    obfs_test_socket_vtab=2Esendto =3D obfs_=
test_win32_sendto;
+    obfs_test_socket_vtab=2Eclose =3D obfs_test_win32_c=
lose;
+}
diff --git a/src/plugins/obfs-test/obfs-test=2Ec b/src/plugins/obf=
s-test/obfs-test=2Ec
new file mode 100644
index 0000000=2E=2Ef041102
--- /d=
ev/null
+++ b/src/plugins/obfs-test/obfs-test=2Ec
@@ -0,0 +1,94 @@
+#includ=
e <stdlib=2Eh>
+#include <string=2Eh>
+#include <stdbool=2Eh>
+#include "op=
envpn-plugin=2Eh"
+#include "openvpn-transport=2Eh"
+#include "obfs-test=2E=
h"
+
+struct openvpn_transport_bind_vtab1 obfs_test_bind_vtab =3D { 0 };
+s=
truct openvpn_transport_socket_vtab1 obfs_test_socket_vtab =3D { 0 };
+
+st=
ruct obfs_test_context
+{
+    struct openvpn_plugin_callbacks *global_vtab=
;
+};
+
+static void
+free_context(struct obfs_test_context *context)
+{
+ =
   if (!context)
+    {
+        return;
+    }
+    free(context);
+}
+
+O=
PENVPN_EXPORT int
+openvpn_plugin_open_v3(int version, struct openvpn_plugi=
n_args_open_in const *args,
+                       struct openvpn_plugin_a=
rgs_open_return *out)
+{
+    struct obfs_test_context *context;
+
+    con=
text =3D (struct obfs_test_context *)calloc(1, sizeof(struct obfs_test_cont=
ext));
+    if (!context)
+    {
+        goto err;
+    }
+
+    context->=
global_vtab =3D args->callbacks;
+    obfs_test_initialize_vtabs_platform()=
;
+    obfs_test_bind_vtab=2Eparseargs =3D obfs_test_parseargs;
+    obfs_t=
est_bind_vtab=2Eargerror =3D obfs_test_argerror;
+    obfs_test_bind_vtab=
=2Efreeargs =3D obfs_test_freeargs;
+
+    out->type_mask =3D OPENVPN_PLUGI=
N_MASK(OPENVPN_PLUGIN_TRANSPORT);
+    out->handle =3D (openvpn_plugin_hand=
le_t *)context;
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+
+err:
+    free_=
context(context);
+    return OPENVPN_PLUGIN_FUNC_ERROR;
+}
+
+OPENVPN_EXPO=
RT void
+openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)
+{
+    fr=
ee_context((struct obfs_test_context *)handle);
+}
+
+OPENVPN_EXPORT int
+o=
penvpn_plugin_func_v3(int version,
+                       struct openvpn_p=
lugin_args_func_in const *arguments,
+                       struct openvpn=
_plugin_args_func_return *retptr)
+{
+    /* We don't ask for any bits that=
 use this interface=2E */
+    return OPENVPN_PLUGIN_FUNC_ERROR;
+}
+
+OPEN=
VPN_EXPORT void *
+openvpn_plugin_get_vtab_v1(int selector, size_t *size_ou=
t)
+{
+    switch (selector)
+    {
+        case OPENVPN_VTAB_TRANSPORT_BI=
ND_V1:
+            if (obfs_test_bind_vtab=2Ebind =3D=3D NULL)
+          =
  {
+                return NULL;
+            }
+            *size_out =3D=
 sizeof(struct openvpn_transport_bind_vtab1);
+            return &obfs_tes=
t_bind_vtab;
+
+        default:
+            return NULL;
+    }
+}
+
+voi=
d
+obfs_test_log(struct obfs_test_context *ctx,
+              openvpn_plug=
in_log_flags_t flags, const char *fmt, =2E=2E=2E)
+{
+    va_list va;
+    =
va_start(va, fmt);
+    ctx->global_vtab->plugin_vlog(flags, OBFS_TEST_PLUG=
IN_NAME, fmt, va);
+    va_end(va);
+}
diff --git a/src/plugins/obfs-test/o=
bfs-test=2Eexports b/src/plugins/obfs-test/obfs-test=2Eexports
new file mod=
e 100644
index 0000000=2E=2Ee7baada
--- /dev/null
+++ b/src/plugins/obfs-te=
st/obfs-test=2Eexports
@@ -0,0 +1,4 @@
+openvpn_plugin_open_v3
+openvpn_plu=
gin_close_v1
+openvpn_plugin_get_vtab_v1
+openvpn_plugin_func_v3
diff --git=
 a/src/plugins/obfs-test/obfs-test=2Eh b/src/plugins/obfs-test/obfs-test=2E=
h
new file mode 100644
index 0000000=2E=2E46309c5
--- /dev/null
+++ b/src/p=
lugins/obfs-test/obfs-test=2Eh
@@ -0,0 +1,42 @@
+#ifndef OPENVPN_PLUGIN_OBF=
S_TEST_H
+#define OPENVPN_PLUGIN_OBFS_TEST_H 1
+
+#include "openvpn-plugin=
=2Eh"
+#include "openvpn-transport=2Eh"
+
+#define OBFS_TEST_PLUGIN_NAME "o=
bfs-test"
+
+struct obfs_test_context;
+
+struct obfs_test_args
+{
+    con=
st char *error;
+    int offset;
+};
+
+extern struct openvpn_transport_bin=
d_vtab1 obfs_test_bind_vtab;
+extern struct openvpn_transport_socket_vtab1 =
obfs_test_socket_vtab;
+
+void obfs_test_initialize_vtabs_platform(void);
+=

+void obfs_test_munge_addr(struct sockaddr *addr, openvpn_transport_sockle=
n_t len);
+
+size_t obfs_test_max_munged_buf_size(size_t clear_size);
+
+si=
ze_t obfs_test_munge_buf(struct obfs_test_args *how,
+                     =
      char *out, const char *in, size_t len);
+
+openvpn_transport_ssize_t =
obfs_test_unmunge_buf(struct obfs_test_args *how,
+                        =
                        char *buf, size_t len);
+
+openvpn_transport_args_t=
 obfs_test_parseargs(void *plugin_handle,
+                                =
             const char *const *argv, int argc);
+
+const char *obfs_test_a=
rgerror(openvpn_transport_args_t args);
+
+void obfs_test_freeargs(openvpn_=
transport_args_t args);
+
+void obfs_test_log(struct obfs_test_context *ctx=
,
+                   openvpn_plugin_log_flags_t flags, const char *fmt, =
=2E=2E=2E);
+
+#endif /* !OPENVPN_PLUGIN_OBFS_TEST_H */

-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2055?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I6a890e3661cc83021cf22ff6cd8752e7112=
c77cd
Gerrit-Change-Number: 2055
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco=
 De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=


--4VlfbvmtLvE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2055?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">transport-plugin: add sample obfs-test plugin<br><br>Ad=
d a sample plugin to explain how the new transport API is expected to<br>be=
 implemented and work=2E It can be used for testing=2E<br><br>Change-Id: I6=
a890e3661cc83021cf22ff6cd8752e7112c77cd<br>Signed-off-by: Robin Tarsiger &l=
t;rtt@dasyatidae=2Ecom&gt;<br>[antonio@openvpn=2Enet: refactored commits, r=
estyled code]<br>[gianmarco@mandelbit=2Ecom: rebased, adapted to multisocke=
t, added CMake build]<br>---<br>M CMakeLists=2Etxt<br>M configure=2Eac<br>M=
 include/openvpn-transport=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src/openv=
pn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M src/openvpn/transport=2Ec<br=
>M src/openvpn/transport=2Eh<br>M src/plugins/Makefile=2Eam<br>A src/plugin=
s/obfs-test/Makefile=2Eam<br>A src/plugins/obfs-test/README=2Eobfs-test<br>=
A src/plugins/obfs-test/obfs-test-args=2Ec<br>A src/plugins/obfs-test/obfs-=
test-munging=2Ec<br>A src/plugins/obfs-test/obfs-test-posix=2Ec<br>A src/pl=
ugins/obfs-test/obfs-test-win32=2Ec<br>A src/plugins/obfs-test/obfs-test=2E=
c<br>A src/plugins/obfs-test/obfs-test=2Eexports<br>A src/plugins/obfs-test=
/obfs-test=2Eh<br>18 files changed, 1,300 insertions(+), 9 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/55/2055/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=
=2Etxt</span><br><span>index 417d9a1=2E=2E4fb715a 100644</span><br><span>--=
- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span=
>@@ -39,6 +39,7 @@</span><br><span> option(ENABLE_LZO &quot;BUILD with lzo&=
quot; ON)</span><br><span> option(ENABLE_PKCS11 &quot;BUILD with pkcs11-hel=
per&quot; ON)</span><br><span> option(USE_WERROR &quot;Treat compiler warni=
ngs as errors (-Werror)&quot; ON)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+option(ENABLE_PLUGIN_OBFS_TEST &quot;Build the obfs-test tran=
sport plugin&quot; OFF)</span><br><span> option(FAKE_ANDROID &quot;Target A=
ndroid but do not use actual cross compile/Android cmake to build for simpl=
e compile checks on Linux&quot;)</span><br><span> option(ENABLE_DEBUG &quot=
;Enable building with debug&quot; OFF)</span><br><span> </span><br><span>@@=
 -680,6 +681,36 @@</span><br><span>     endif ()</span><br><span> endif ()<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+if=
 (ENABLE_PLUGIN_OBFS_TEST)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    set(OBFS_TEST_SOURCES</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        src/plugins/obfs-test/obfs-test=2Ec</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        src/plugins/obfs-test/obfs-tes=
t-args=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
rc/plugins/obfs-test/obfs-test-munging=2Ec</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (WIN32)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        list(APPEND OBFS_TEST_SOURCES src/plugins/obfs-test/obfs-te=
st-win32=2Ec)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        list(A=
PPEND OBFS_TEST_SOURCES src/plugins/obfs-test/obfs-test-posix=2Ec)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    endif ()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    add_library(openvpn-plugin-obfs-test MODULE ${OBFS=
_TEST_SOURCES})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
set_target_properties(openvpn-plugin-obfs-test PROPERTIES PREFIX &quot;&quo=
t;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_inclu=
de_directories(openvpn-plugin-obfs-test PRIVATE</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        ${CMAKE_CURRENT_SOURCE_DIR}/include</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ${CMAKE_CURRENT=
_BINARY_DIR}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (${MBED})<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        target_inclu=
de_directories(openvpn-plugin-obfs-test PRIVATE ${MBED_INCLUDE_PATH})</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    elseif (TARGET OpenSS=
L::Crypto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t=
arget_include_directories(openvpn-plugin-obfs-test PRIVATE</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            $&lt;TARGET_PROPERTY:Ope=
nSSL::Crypto,INTERFACE_INCLUDE_DIRECTORIES&gt;)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    endif ()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (WIN32)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        target_link_libraries(openvpn-plugin-obfs-test PRIV=
ATE ws2_32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    endi=
f ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    install(TAR=
GETS openvpn-plugin-obfs-test DESTINATION ${PLUGIN_DIR})</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> option(UT_ALLOW_BIG_ALLOC &quot=
;Allow unit-tests to use &gt; 1 GB of memory&quot; ON)</span><br><span> </s=
pan><br><span> if (BUILD_TESTING)</span><br><span>diff --git a/configure=2E=
ac b/configure=2Eac</span><br><span>index 0ac61b4=2E=2E6fec106 100644</span=
><br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span>=
<br><span>@@ -193,6 +193,13 @@</span><br><span> )</span><br><span> </span><=
br><span> AC_ARG_ENABLE(</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	[plugin-obfs-test],</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	[AS_HELP_STRING([--enable-plugin-obfs-test], [enable obfs-test trans=
port plugin @&lt;:@default=3Dno@:&gt;@])],</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	[enable_plugin_obfs_test=3D&quot;no&quot;]</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_ARG_=
ENABLE(</span><br><span> 	[pam-dlopen],</span><br><span> 	[AS_HELP_STRING([=
--enable-pam-dlopen], [dlopen libpam @&lt;:@default=3Dno@:&gt;@])],</span><=
br><span> 	,</span><br><span>@@ -1317,6 +1324,7 @@</span><br><span> AM_COND=
ITIONAL([GIT_CHECKOUT], [test &quot;${GIT_CHECKOUT}&quot; =3D &quot;yes&quo=
t;])</span><br><span> AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test &quot;=
${enable_plugin_auth_pam}&quot; =3D &quot;yes&quot;])</span><br><span> AM_C=
ONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test &quot;${enable_plugin_down_root=
}&quot; =3D &quot;yes&quot;])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+AM_CONDITIONAL([ENABLE_PLUGIN_OBFS_TEST], [test &quot;${enable_pl=
ugin_obfs_test}&quot; =3D &quot;yes&quot;])</span><br><span> AM_CONDITIONAL=
([HAVE_LD_WRAP_SUPPORT], [test &quot;${have_ld_wrap_support}&quot; =3D &quo=
t;yes&quot;])</span><br><span> AM_CONDITIONAL([OPENSSL_ENGINE], [test &quot=
;${have_openssl_engine}&quot; =3D &quot;yes&quot;])</span><br><span> </span=
><br><span>@@ -1383,6 +1391,7 @@</span><br><span> 	src/plugins/auth-pam/Mak=
efile</span><br><span> 	src/plugins/down-root/Makefile</span><br><span> 	sr=
c/tapctl/Makefile</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	s=
rc/plugins/obfs-test/Makefile</span><br><span> 	tests/Makefile</span><br><s=
pan>         tests/unit_tests/Makefile</span><br><span>         tests/unit_=
tests/example_test/Makefile</span><br><span>diff --git a/include/openvpn-tr=
ansport=2Eh b/include/openvpn-transport=2Eh</span><br><span>index 7f29696=
=2E=2E3dae65d 100644</span><br><span>--- a/include/openvpn-transport=2Eh</s=
pan><br><span>+++ b/include/openvpn-transport=2Eh</span><br><span>@@ -196,8=
 +196,12 @@</span><br><span>      * extended functions in the future=2E */<=
/span><br><span>     unsigned features;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    openvpn_transport_native_event_t (*ge=
t_sock)(openvpn_transport_socket_t handle);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#else</span><br><span>     /* Given a virtual indir=
ect socket returns the descriptor associated */</span><br><span>     int (*=
get_sd)(openvpn_transport_socket_t handle);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>     /* Gi=
ven the bitmask rwflags, request that event_set be provided with all</span>=
<br><span>      * native events that should be waited on such that whenever=
 this virtual</span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/o=
penvpn/multi_io=2Ec</span><br><span>index bb5dde58=2E=2Ec289b10 100644</spa=
n><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvp=
n/multi_io=2Ec</span><br><span>@@ -130,6 +130,11 @@</span><br><span>     }<=
/span><br><span> </span><br><span>     mi-&gt;socket_set_called =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (proto_is_indi=
rect(mi-&gt;context=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     if (proto_is_dgram(mi-&gt;context=2Ec2=2Eli=
nk_sockets[0]-&gt;info=2Eproto))</span><br><span>     {</span><br><span>   =
      socket_set(mi-&gt;context=2Ec2=2Elink_sockets[0], m-&gt;multi_io-&gt;=
es, EVENT_READ,</span><br><span>@@ -184,6 +189,30 @@</span><br><span>     r=
eturn flags;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Hand the events registered by transport plugins back to the=
m and replace</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the=
m with a single EVENT_ARG_LINK_SOCKET event per indirect socket that</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * the plugin reports as r=
eady=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+multi_io_pump_indirect(struct multi_c=
ontext *m, int status)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_num; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct link_socket *sock =3D m-&gt;top=2Ec2=2El=
ink_sockets[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    unsigned int rwflags =3D socket_indirect_pump(sock, m-&gt;multi_io-&gt;=
esr, &amp;status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                             &amp; (EVENT_READ | EVENT_WRITE);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (rwflags)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            struct event_set_return *e =3D &amp;m-&gt;multi_=
io-&gt;esr[status++];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            e-&gt;rwflags =3D rwflags;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            e-&gt;arg =3D &amp;sock-&gt;ev_arg;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return status;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> int</span><br><span> multi_io_wait(struct multi_con=
text *m)</span><br><span> {</span><br><span>@@ -232,8 +261,13 @@</span><br>=
<span>     event_ctl(m-&gt;multi_io-&gt;es, m-&gt;top=2Ec2=2Einotify_fd, EV=
ENT_READ, MULTI_IO_FILE_CLOSE_WRITE);</span><br><span> #endif</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        event_wait(m-&gt=
;multi_io-&gt;es, &amp;m-&gt;top=2Ec2=2Etimeval, m-&gt;multi_io-&gt;esr, m-=
&gt;multi_io-&gt;maxevents);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* keep one esr slot per link socket for multi_io_pump_indirec=
t() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =
=3D event_wait(m-&gt;multi_io-&gt;es, &amp;m-&gt;top=2Ec2=2Etimeval, m-&gt;=
multi_io-&gt;esr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      m-&gt;multi_io-&gt;maxevents - m-&gt;top=2Ec1=2Elink_=
sockets_num);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (status &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status=
 =3D multi_io_pump_indirect(m, status);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span>     update_time();</span><br><sp=
an>     m-&gt;multi_io-&gt;n_esr =3D 0;</span><br><span>     if (status &gt=
; 0)</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/sock=
et=2Ec</span><br><span>index 07090f6=2E=2E224f86e 100644</span><br><span>--=
- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</sp=
an><br><span>@@ -39,7 +39,6 @@</span><br><span> #include &quot;openvpn=2Eh&=
quot;</span><br><span> #include &quot;forward=2Eh&quot;</span><br><span> #i=
nclude &quot;resolve=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#include &quot;transport=2Eh&quot;</span><br><span> </span><br><sp=
an> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>@@ -3=
42,6 +341,11 @@</span><br><span>                                     sock-&=
gt;info=2Etransport_plugin_argv,</span><br><span>                          =
           ai_family,</span><br><span>                                     =
bind_addresses);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
def _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openv=
pn_transport_native_event_t ev =3D transport_get_sock(sock-&gt;indirect);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;rw_handl=
e=2Eread =3D ev-&gt;read;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    sock-&gt;rw_handle=2Ewrite =3D ev-&gt;write;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> }</span><br><spa=
n> </span><br><span> unsigned</span><br><span>@@ -2737,6 +2741,7 @@</span><=
br><span>             {</span><br><span>                 event_ctl(es, sock=
et_event_handle(s), rwflags, arg);</span><br><span>             }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>            =
 if (persistent)</span><br><span>             {</span><br><span>           =
      *persistent =3D rwflags;</span><br><span>diff --git a/src/openvpn/soc=
ket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 4119330=2E=2E67f14a7=
 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/=
src/openvpn/socket=2Eh</span><br><span>@@ -843,6 +843,12 @@</span><br><span=
> static inline event_t</span><br><span> socket_event_handle(const struct l=
ink_socket *sock)</span><br><span> {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#if defined(ENABLE_PLUGIN) &amp;&amp; !defined(_WIN32)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;indire=
ct)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return transport_get_s=
ock(sock-&gt;indirect);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span> #ifdef _WIN32</span><br><span>     return &amp;sock-&gt;rw_ha=
ndle;</span><br><span> #else</span><br><span>@@ -858,7 +864,11 @@</span><br=
><span> static inline void</span><br><span> socket_set_listen_persistent(st=
ruct link_socket *sock, struct event_set *es, void *arg)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sock &amp;&am=
p; !sock-&gt;listen_persistent_queued &amp;&amp; !sock-&gt;indirect)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sock &amp;&amp; !s=
ock-&gt;listen_persistent_queued</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifdef ENABLE_PLUGIN</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &amp;&amp; !sock-&gt;indirect</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    )</span><br><span>     {</span><br><span>         =
event_ctl(es, socket_listen_event_handle(sock), EVENT_READ, arg);</span><br=
><span>         sock-&gt;listen_persistent_queued =3D true;</span><br><span=
>diff --git a/src/openvpn/transport=2Ec b/src/openvpn/transport=2Ec</span><=
br><span>index 8467916=2E=2E33434c0 100644</span><br><span>--- a/src/openvp=
n/transport=2Ec</span><br><span>+++ b/src/openvpn/transport=2Ec</span><br><=
span>@@ -289,10 +289,14 @@</span><br><span>     return translate_rwflags_in=
(indirect-&gt;vtab-&gt;pump(indirect));</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-transport_get_sd(openvpn_transport_soc=
ket_t indirect)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+open=
vpn_transport_native_event_t</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+transport_get_sock(openvpn_transport_socket_t indirect)</span><br>=
<span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN=
32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return indire=
ct-&gt;vtab-&gt;get_sock(indirect);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#else</span><br><span>     return indirect-&gt;vtab-&gt;get=
_sd(indirect);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n>diff --git a/src/openvpn/transport=2Eh b/src/openvpn/transport=2Eh</span>=
<br><span>index 05422e6=2E=2E9292bca 100644</span><br><span>--- a/src/openv=
pn/transport=2Eh</span><br><span>+++ b/src/openvpn/transport=2Eh</span><br>=
<span>@@ -74,8 +74,7 @@</span><br><span> void transport_request_events(open=
vpn_transport_socket_t indirect,</span><br><span>                          =
     struct event_set *es, unsigned rwflags);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-int transport_get_sd(openvpn_transport_socket_t indire=
ct);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_transpo=
rt_native_event_t transport_get_sock(openvpn_transport_socket_t indirect);<=
/span><br><span> </span><br><span> /* NOTE: transport_write and transport_r=
ead implicitly downcast from a</span><br><span>  * ssize_t to an int on ret=
urn=2E Various link_socket_* functions</span><br><span>diff --git a/src/plu=
gins/Makefile=2Eam b/src/plugins/Makefile=2Eam</span><br><span>index 79cdca=
e=2E=2E3675538 100644</span><br><span>--- a/src/plugins/Makefile=2Eam</span=
><br><span>+++ b/src/plugins/Makefile=2Eam</span><br><span>@@ -12,4 +12,4 @=
@</span><br><span> MAINTAINERCLEANFILES =3D \</span><br><span> 	$(srcdir)/M=
akefile=2Ein</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-SUBDIRS =3D auth-pam down-root</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+SUBDIRS =3D auth-pam down-root obfs-test</span><br><spa=
n>diff --git a/src/plugins/obfs-test/Makefile=2Eam b/src/plugins/obfs-test/=
Makefile=2Eam</span><br><span>new file mode 100644</span><br><span>index 00=
00000=2E=2E9f0a7b2</span><br><span>--- /dev/null</span><br><span>+++ b/src/=
plugins/obfs-test/Makefile=2Eam</span><br><span>@@ -0,0 +1,29 @@</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+MAINTAINERCLEANFILES =3D \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(srcdir)/Makefile=2Ei=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+AM_CFLAGS =3D \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/include \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	$(OPTIONAL_CRYPTO_CFLAGS)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+if ENABLE_PLUGIN_OBFS_TEST</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+plugin_LTLIBRARIES =3D openvpn-plugin-o=
bfs-test=2Ela</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+openvpn_plugin_obfs_test_la_SOURCES =3D=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	obfs-test=2Ec \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	obfs-test-munging=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	obfs-test-ar=
gs=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	obfs-test=
=2Eexports</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+if WIN32</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+openvpn_plugin_obfs_test_la_SOURCES +=
=3D obfs-test-win32=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+openvpn_plugin_obfs_test_la_LIBADD =3D -lws2_32</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+else !WIN32</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+openvpn_plugin_obfs_test_la_SOURCES +=3D obfs-tes=
t-posix=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# No LIB=
ADD necessary; we assume we can access the global symbol space,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# and core OpenVPN will already=
 link with everything needed for sockets=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_p=
lugin_obfs_test_la_LDFLAGS =3D $(AM_LDFLAGS) \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	-export-symbols &quot;$(srcdir)/obfs-test=2Eexp=
orts&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-modul=
e -shared -avoid-version -no-undefined</span><br><span>diff --git a/src/plu=
gins/obfs-test/README=2Eobfs-test b/src/plugins/obfs-test/README=2Eobfs-tes=
t</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Eb=
c52dbd8</span><br><span>--- /dev/null</span><br><span>+++ b/src/plugins/obf=
s-test/README=2Eobfs-test</span><br><span>@@ -0,0 +1,33 @@</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+obfs-test</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+SYNOPSIS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+The obfs-test plugin=
 is a proof of concept for supporting protocol</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+obfuscation for OpenVPN via a socket intercept p=
lugin=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+BUILD</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+You must specify --enable-plugin-obfs-test at configure time to=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+trigger building th=
is plugin=2E It should function on POSIX-y platforms</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+and Windows=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+USAGE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+To invoke this plugin, =
load it via an appropriate plugin line in the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+configuration file, select it with a transport-pl=
ugin line and specify</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+&#39;proto indirect&#39; rather than any other protocol:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  plugin /path/to/openvpn-plugin-obfs-test=2Eso</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  transport-plugin /path/to=
/openvpn-plugin-obfs-test=2Eso [offset]</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  proto indirect</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Th=
e optional offset (0-42, default 0) must match on both ends=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+Packets will then be passed via =
UDP, but they will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+a=
lso undergo a very basic content transformation, and the bind port</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+will be altered (see obfs-te=
st-munging=2Ec for details)=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CAVEATS<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+This has undergone basic functionality =
testing, but not any kind of</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+full-on stress test=2E Extended socket or I/O handling options are=
 not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+supported at al=
l=2E</span><br><span>diff --git a/src/plugins/obfs-test/obfs-test-args=2Ec =
b/src/plugins/obfs-test/obfs-test-args=2Ec</span><br><span>new file mode 10=
0644</span><br><span>index 0000000=2E=2E20a0b65</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/src/plugins/obfs-test/obfs-test-args=2Ec</span><br=
><span>@@ -0,0 +1,60 @@</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;obfs-test=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
openvpn_transport_args_t</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+obfs_test_parseargs(void *plugin_handle,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    const char *const *argv, int =
argc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct obfs_test_args *args =
=3D calloc(1, sizeof(struct obfs_test_args));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!args)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (argc &lt; 2)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        args-&gt;offset =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (argc =3D=3D 2)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        char *end;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        long offset =3D strtol(argv[1], &amp;end=
, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (*=
end !=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     args-&gt;error =3D &quot;offset must be a decimal number&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        else if (!(0 &lt;=3D offset =
&amp;&amp; offset &lt;=3D 42))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            args-&gt;error =3D &quot;offset must be between 0 and 42&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            args-&gt;offset =3D (int)offset;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        args-&gt;error =3D &quot;too many arguments&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return args;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+obfs_test_argerror(openvpn_transpor=
t_args_t args_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!args_)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return &quot;cannot allocate&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return ((struct obfs_test_args *)args_)-&gt;err=
or;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+obfs_te=
st_freeargs(openvpn_transport_args_t args_)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct obfs_test_args *args =3D (struct obfs_test_args *)args_;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(args);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --=
git a/src/plugins/obfs-test/obfs-test-munging=2Ec b/src/plugins/obfs-test/o=
bfs-test-munging=2Ec</span><br><span>new file mode 100644</span><br><span>i=
ndex 0000000=2E=2E8d7bb21</span><br><span>--- /dev/null</span><br><span>+++=
 b/src/plugins/obfs-test/obfs-test-munging=2Ec</span><br><span>@@ -0,0 +1,1=
29 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;s=
tring=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &lt;errno=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &lt;stdbool=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;obfs-test=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifdef OPENVPN_TRANSPORT_PLATFORM_POSIX</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;sys/socket=2Eh&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;netin=
et/in=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typede=
f in_port_t obfs_test_in_port_t;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;winsock2=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &lt;ws2tcpip=2Eh&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+typedef u_short obfs_test_in_port_t;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static obfs_test_in_port_t</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+munge_port(obfs_test_in_port_t port)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return port ? port ^ 15 : 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Reversible=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+obfs_test_munge_addr(struct =
sockaddr *addr, openvpn_transport_socklen_t len)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct sockaddr_in *inet;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct sockaddr_in6 *inet6;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    switch (addr-&gt;sa_family)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        case AF_INET:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            inet =3D (struct sockaddr_in *)addr;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            inet-&gt;sin_port =
=3D munge_port(inet-&gt;sin_port);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   case AF_INET6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          inet6 =3D (struct sockaddr_in6 *)addr;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            inet6-&gt;sin6_port =3D munge_port=
(inet6-&gt;sin6_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        default:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Six fixed bytes, six repeated bytes=2E It&#39;s only a silly transfor=
mation=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 MUNGE_OVERHEAD 12</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+size_t</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+obfs_test_max_munged_buf_size(siz=
e_t clear_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return clear_size =
+ MUNGE_OVERHEAD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+openvpn_transport_ssize_t</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+obfs_test_unmunge_buf(struct obfs=
_test_args *how,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                   char *buf, size_t len)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    size_t i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 6)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        goto bad;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; 6; i++)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (buf[i] !=3D (char)(i + how-&gt;offset))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            goto bad;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (i =3D 0; i &lt; 6 &amp;&amp; (6 + 2 * i) &lt; len; i++)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (len &lt; (6 + 2 * i + 1) || =
buf[6 + 2 * i] !=3D buf[6 + 2 * i + 1])</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            goto bad;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        buf[i] =3D buf[6 + 2 * i];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &gt;=
 18)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        memmove(buf + 6, buf =
+ 18, len - 18);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     len -=3D 12;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        len -=3D 6;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        len /=3D 2;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bad:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* TODO: this really isn&#39;t th=
e best way to report this error */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    errno =3D EIO;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return -1;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* out must have space for l=
en+MUNGE_OVERHEAD bytes=2E out and in must</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * not overlap=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+size_t</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+obfs_test_munge_buf(struct obfs_test_args *how,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    char *out, const=
 char *in, size_t len)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t i, n=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t out_len=
 =3D 6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; 6; i++=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        out[i] =3D (char)(i + ho=
w-&gt;offset);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    n =3D len &lt; =
6 ? len : 6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (i =3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
out[6 + 2 * i] =3D out[6 + 2 * i + 1] =3D in[i];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (len &gt; 6)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        memmove(out + 18, in + 6, len - 6);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        out_len =3D len + 12;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    out_len =3D 6 + 2 * len;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return out_len;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff -=
-git a/src/plugins/obfs-test/obfs-test-posix=2Ec b/src/plugins/obfs-test/ob=
fs-test-posix=2Ec</span><br><span>new file mode 100644</span><br><span>inde=
x 0000000=2E=2Eea4ba20</span><br><span>--- /dev/null</span><br><span>+++ b/=
src/plugins/obfs-test/obfs-test-posix=2Ec</span><br><span>@@ -0,0 +1,216 @@=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;obfs=
-test=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &lt;stdbool=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;err=2Eh&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;errno=2Eh&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;unistd=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;fcntl=2Eh&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &lt;sys/socket=2Eh&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;netinet/i=
n=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+struct obfs_test_socket_posix=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_transport_socket h=
andle;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ob=
fs_test_args args;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct obfs_test_context *ctx;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int fd;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    unsigned last_rwflags;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+free_socket(struct obfs_test_so=
cket_posix *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!sock)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (sock-&gt;fd !=3D -1)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        close(sock-&gt;fd);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    free(sock);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static openvpn_transport_socket_=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+obfs_test_posix_bi=
nd(void *plugin_handle, openvpn_transport_args_t args,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                     const struct sockad=
dr *addr, socklen_t len)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ob=
fs_test_socket_posix *sock =3D NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct sockaddr *addr_rev =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    addr_rev =3D calloc(1, len);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!addr_rev)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        goto error;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    memcpy(addr_rev, addr, len);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    obfs_test_munge_addr(addr_rev, len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    sock =3D calloc(1, sizeof(struct obfs_test_socket_posi=
x));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!sock)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    sock-&gt;handle=2Evtab =3D &amp;obfs_test_so=
cket_vtab;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-=
&gt;ctx =3D (struct obfs_test_context *)plugin_handle;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    memcpy(&amp;sock-&gt;args, args, siz=
eof(sock-&gt;args));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Note that sock-&gt;fd isn&#39;t -1 yet=2E Set it explicitly if ther=
e are ever any</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* error exits before the socket() call=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    sock-&gt;fd =3D socket(addr-&gt;sa_family, SOCK_DGRAM, IPPROTO_UD=
P);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt=
;fd =3D=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (fcntl(sock-&gt;fd, F_SETF=
L, fcntl(sock-&gt;fd, F_GETFL) | O_NONBLOCK))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        goto error;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bind(sock-&gt=
;fd, addr_rev, len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto =
error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    free(addr_rev);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return &amp;sock-&gt;ha=
ndle;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+error:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    free_socket(sock);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free(addr_rev);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+obfs_test_posix=
_get_sd(openvpn_transport_socket_t handle)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return ((struct obfs_test_socket_posix *)handle)-&gt;fd;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+obfs_test_posix_request_event(openvpn_transport_socket_t handle,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
 openvpn_transport_event_set_handle_t event_set, unsigned rwflags)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    obfs_test_log(((struct obfs_test_socket_po=
six *)handle)-&gt;ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                  PLOG_DEBUG, &quot;request-event: %d&quot;, rwflags);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ((struct obfs_tes=
t_socket_posix *)handle)-&gt;last_rwflags =3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (rwflags)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        event_set-&gt;vtab-&gt;set_event(event_set, ((struct ob=
fs_test_socket_posix *)handle)-&gt;fd,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                   rwflags, handle);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+obfs_te=
st_posix_update_event(openvpn_transport_socket_t handle, void *arg, unsigne=
d rwflags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    obfs_test_log(((struct =
obfs_test_socket_posix *)handle)-&gt;ctx,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                  PLOG_DEBUG, &quot;update-event: %p,=
 %p, %d&quot;, handle, arg, rwflags);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (arg !=3D handle)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ((struct obfs_test_socket_posix *)handle)-&gt;last_rwflags |=3D rwflags;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static unsigned</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+obfs_test_posix_pump(openvpn_transport_socket_t handle)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    obfs_test_log(((struct obfs_test_socket_po=
six *)handle)-&gt;ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                  PLOG_DEBUG, &quot;pump -&gt; %d&quot;, ((struct obfs_t=
est_socket_posix *)handle)-&gt;last_rwflags);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return ((struct obfs_test_socket_posix *)hand=
le)-&gt;last_rwflags;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static ssize_t</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+obfs_test_posix_recvfrom(openvpn_transpo=
rt_socket_t handle, void *buf, size_t len,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                         struct sockaddr *addr, sock=
len_t *addrlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int fd =3D ((struc=
t obfs_test_socket_posix *)handle)-&gt;fd;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    socklen_t addrcap =3D *addrlen;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ssize_t result;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+again:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    *addrlen =3D addrcap;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    result =3D recvfrom(fd, buf, len, 0, addr, addrlen);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (result &lt; 0 &am=
p;&amp; errno =3D=3D EAGAIN)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   ((struct obfs_test_socket_posix *)handle)-&gt;last_rwflags &amp;=3D ~OPE=
NVPN_TRANSPORT_EVENT_READ;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(result &gt;=3D 0 &amp;&amp; *addrlen &gt; 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        obfs_test_munge_addr(addr, *addrlen);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (result &gt; 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        struct obfs_test_args *how =3D &amp;((struct obfs_test=
_socket_posix *)handle)-&gt;args;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        result =3D obfs_test_unmunge_buf(how, buf, (size_t)re=
sult);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (r=
esult &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* P=
retend that read never happened=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            goto again;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    obfs_test_log(((s=
truct obfs_test_socket_posix *)handle)-&gt;ctx,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                  PLOG_DEBUG, &quot;recvfrom(%d=
) -&gt; %d&quot;, (int)len, (int)result);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return result;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static ssize_t</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+obfs_test_posix_sendt=
o(openvpn_transport_socket_t handle, const void *buf, size_t len,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                       const =
struct sockaddr *addr, socklen_t addrlen)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int fd =3D ((struct obfs_test_socket_posix *)handle)-&gt;fd;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr *addr_=
rev =3D calloc(1, addrlen);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    void *buf_munged =3D malloc(obfs_test_max_munged_buf_size(len))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t len_mun=
ged;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ssize_t res=
ult;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!addr_r=
ev || !buf_munged)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto er=
ror;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    memcpy(addr_rev, addr, addrlen);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    obfs_test_munge_addr(addr_r=
ev, addrlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct obfs_test_args *how =3D &amp;((struct obfs_test_socket_posix *)handle)=
-&gt;args;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    len_m=
unged =3D obfs_test_munge_buf(how, buf_munged, buf, len);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    result =3D sendto(fd, buf_munged,=
 len_munged, 0, addr_rev, addrlen);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (result &lt; 0 &amp;&amp; errno =3D=3D EAGAIN)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        ((struct obfs_test_socket_posix=
 *)handle)-&gt;last_rwflags &amp;=3D ~OPENVPN_TRANSPORT_EVENT_WRITE;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* TODO: not clear what to do here f=
or partial transfers=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (result &gt; (ssize_t)len)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        result =3D len;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 obfs_test_log(((struct obfs_test_socket_posix *)handle)-&gt;ctx,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                  PLOG_DEBUG,=
 &quot;sendto(%d) -&gt; %d&quot;, (int)len, (int)result);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    free(addr_rev);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    free(buf_munged);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return result;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+error:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    free(addr_rev);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    free(buf_munged);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+obfs_test_posix_close(openvpn_transport_s=
ocket_t handle)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_socket((struc=
t obfs_test_socket_posix *)handle);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+obfs_test_initialize_vtabs_platform(=
void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    obfs_test_bind_vtab=2Ebind =
=3D obfs_test_posix_bind;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    obfs_test_socket_vtab=2Eget_sd =3D obfs_test_posix_get_sd;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    obfs_test_socket_vtab=
=2Erequest_event =3D obfs_test_posix_request_event;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    obfs_test_socket_vtab=2Eupdate_event =
=3D obfs_test_posix_update_event;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    obfs_test_socket_vtab=2Epump =3D obfs_test_posix_pump;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    obfs_test_socket_v=
tab=2Erecvfrom =3D obfs_test_posix_recvfrom;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    obfs_test_socket_vtab=2Esendto =3D obfs_test_p=
osix_sendto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    obf=
s_test_socket_vtab=2Eclose =3D obfs_test_posix_close;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/plugin=
s/obfs-test/obfs-test-win32=2Ec b/src/plugins/obfs-test/obfs-test-win32=2Ec=
</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Eec=
c9ec8</span><br><span>--- /dev/null</span><br><span>+++ b/src/plugins/obfs-=
test/obfs-test-win32=2Ec</span><br><span>@@ -0,0 +1,588 @@</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;obfs-test=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbool=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &lt;windows=2Eh&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;winsock2=2Eh&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &lt;assert=2Eh&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+is_invalid_handle(HANDLE h)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return h =3D=3D NULL || h =3D=3D INVALID_HANDLE_VALUE;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+typedef enum</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    IO_SLOT_DO=
RMANT, /* must be 0 for calloc purposes */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    IO_SLOT_PENDING,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* success/failure is determined by succeeded f=
lag in COMPLETE state */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    IO_SLOT_COMPLETE</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+} io_slot_status_t;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* must be ca=
lloc&#39;able */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+str=
uct io_slot</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct obfs_test_conte=
xt *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    io_slot=
_status_t status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  OVERLAPPED overlapped;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    SOCKET socket;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    SOCKADDR_STORAGE addr;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int addr_len, addr_cap;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    DWORD bytes, flags;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bool succeeded;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int wsa_error;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* realloc&#39;d as needed; always private copy, never aliased */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *buf;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t buf_len, buf_cap=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+setup_io_slot(struct io_slot *slot, struct obfs_test_context *=
ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              S=
OCKET socket, HANDLE event)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    slot-&=
gt;ctx =3D ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
slot-&gt;status =3D IO_SLOT_DORMANT;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    slot-&gt;addr_cap =3D sizeof(SOCKADDR_STORAGE);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    slot-&gt;socket =3D so=
cket;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    slot-&gt;o=
verlapped=2EhEvent =3D event;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* Note that this assumes any =
I/O has already been implicitly canceled (via closesocket),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * but not waited for yet=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+destroy_io_slot(struct io_slot =
*slot)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (slot-&gt;status =3D=3D =
IO_SLOT_PENDING)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD byt=
es, flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        B=
OOL ok =3D WSAGetOverlappedResult(slot-&gt;socket, &amp;slot-&gt;overlapped=
, &amp;bytes,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                   TRUE /* wait */, &amp;flags);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (!ok &amp;&amp; WSA=
GetLastError() =3D=3D WSA_IO_INCOMPLETE)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            obfs_test_log(slot-&gt;ctx, PLOG_ERR,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                          &quot;de=
stroying I/O slot: canceled operation is still incomplete after wait?!&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    slot-&gt;status =3D IO_SLOT_DORMANT;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* FIXME: aborts on error=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+resize_io_buf(struct io_slot *slot, size_t cap)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (slot-&gt;buf)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        free(slot-&gt;buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        slot-&gt;buf =3D NULL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char =
*new_buf =3D malloc(cap);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!new_buf)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ab=
ort();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    slot-&gt;buf =3D new_bu=
f;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    slot-&gt;buf_=
cap =3D cap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+struct obfs_test_socket_win32</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct openvpn_transport_socket handle;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct obfs_test_args ar=
gs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct obfs_=
test_context *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   SOCKET socket;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Write is ready=
 when idle; read is not-ready when idle=2E Both level-triggered=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_transp=
ort_win32_event_pair completion_events;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct io_slot slot_read, slot_write;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int last_rwflags;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+free_socket(struct =
obfs_test_socket_win32 *sock)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* T=
his only ever becomes false in strange situations where we leak the entire =
structure for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 lack of anything else to do=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    bool can_free =3D true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;socket !=3D INVA=
LID_SOCKET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        closesocket(so=
ck-&gt;socket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* closesocket cancels any pendin=
g overlapped I/O, but we still have to potentially</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * wait for it here before we can free t=
he buffers=2E This has to happen before closing</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * the event handles=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * If we can&#39;t figure out when the canceled =
overlapped I/O is done, for any reason, we defensively</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * leak the entire structure; freein=
g it would be permitting the system to corrupt memory later=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * TODO: possibly abort() in=
stead, but make sure we&#39;ve handled all the possible &quot;have to try a=
gain&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ca=
ses above first</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!destroy=
_io_slot(&amp;sock-&gt;slot_read))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        can_free =3D false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!destroy_io_slot(&amp;sock-&gt;slot_write))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        can_free =3D false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!can_free)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* Skip deinitialization of everything else=2E Doomed=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        obfs_test_log(sock-&gt;ctx,=
 PLOG_ERR, &quot;doomed, leaking the entire socket structure&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!is_invalid_handle(sock-&gt;completion_events=2Eread))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        CloseHandle(sock-&gt;compl=
etion_events=2Eread);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!is_=
invalid_handle(sock-&gt;completion_events=2Ewrite))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        CloseHandle(sock-&gt;completion_events=2Ewrite)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    free(sock);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static openvpn_tr=
ansport_socket_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+obf=
s_test_win32_bind(void *plugin_handle, openvpn_transport_args_t args,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                     cons=
t struct sockaddr *addr, openvpn_transport_socklen_t len)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct obfs_test_socket_win32 *sock =3D NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr *addr=
_rev =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TODO: would be ni=
ce to factor out some of these sequences */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    addr_rev =3D calloc(1, len);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!addr_rev)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        goto error;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    memcpy(addr_rev, addr, len);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    obfs_test_munge_addr(addr_rev, len);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    sock =3D calloc(1, sizeof(struct obfs_test_socke=
t_win32));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;handle=2Evtab =3D &amp;obfs_=
test_socket_vtab;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  sock-&gt;ctx =3D (struct obfs_test_context *)plugin_handle;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    memcpy(&amp;sock-&gt;args, ar=
gs, sizeof(sock-&gt;args));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Pree=
mptively initialize the members of some Win32 types so error exits are okay=
 later on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
HANDLEs of NULL are considered invalid per above=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;socket =3D INVALID_SOCKET;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;socket =3D socket(addr_rev=
-&gt;sa_family, SOCK_DGRAM, IPPROTO_UDP);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (sock-&gt;socket =3D=3D INVALID_SOCKET)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* See above: write is ready when idle, read is not-ready when idle=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;=
completion_events=2Eread =3D CreateEvent(NULL, TRUE, FALSE, NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;completion_even=
ts=2Ewrite =3D CreateEvent(NULL, TRUE, TRUE, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (is_invalid_handle(sock-&gt;comple=
tion_events=2Eread) || is_invalid_handle(sock-&gt;completion_events=2Ewrite=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!setup_io_slot(&amp;sock-&gt;slot_rea=
d, sock-&gt;ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                    sock-&gt;socket, sock-&gt;completion_events=2Eread))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!setup_io_slot(&amp;sock-&gt;slot_write, s=
ock-&gt;ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                sock-&gt;socket, sock-&gt;completion_events=2Ewrite))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (bind(sock-&gt;socket, addr_rev, len))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        goto error;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    free(addr_rev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return &amp;sock-&gt;handle;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+error=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    obfs_test_log(=
(struct obfs_test_context *)plugin_handle, PLOG_ERR,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  &quot;bind failure: WSA=
 error =3D %d&quot;, WSAGetLastError());</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    free_socket(sock);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    free(addr_rev);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+handle_sendrecv_return(s=
truct io_slot *slot, int status)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (status =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Imm=
ediately completed=2E Set the event so it stays consistent=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        slot-&gt;status =3D IO=
_SLOT_COMPLETE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    slot-&gt;succeeded =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        slot-&gt;buf_len =3D slot-&gt;bytes;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        SetEvent(slot-&gt;overlapped=
=2EhEvent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (WSAGetLas=
tError() =3D=3D WSA_IO_PENDING)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* Queued=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        slot-&gt;status =3D IO_SLOT_PENDING;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* E=
rror=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
lot-&gt;status =3D IO_SLOT_COMPLETE;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        slot-&gt;succeeded =3D false;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        slot-&gt;wsa_error =3D WSAGetLas=
tError();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sl=
ot-&gt;buf_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+queue_new_read(struct io_slot *slot, size_t cap)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int status;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    WSABUF sbuf;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert(slot-&gt;status =3D=3D IO_SLOT_DORMANT);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ResetEvent(slot-&gt;overlapped=2EhEv=
ent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    resize_io_=
buf(slot, cap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
sbuf=2Ebuf =3D slot-&gt;buf;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    sbuf=2Elen =3D (ULONG)slot-&gt;buf_cap;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    slot-&gt;addr_len =3D slot-&gt;addr_c=
ap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    slot-&gt;fla=
gs =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status=
 =3D WSARecvFrom(slot-&gt;socket, &amp;sbuf, 1, &amp;slot-&gt;bytes, &amp;s=
lot-&gt;flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                    (struct sockaddr *)&amp;slot-&gt;addr, &amp;slot-&gt;ad=
dr_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
             &amp;slot-&gt;overlapped, NULL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    handle_sendrecv_return(slot, status);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* write slot buffer must already be full=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+queue_new_write(struct io_slot *slot)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int status;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    WSABUF sbuf;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert(slot-&gt;status =3D=3D IO_SLOT_COMPLETE =
|| slot-&gt;status =3D=3D IO_SLOT_DORMANT);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ResetEvent(slot-&gt;overlapped=2EhEvent);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    sbuf=2Ebuf =3D slot-&gt;buf;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    sbuf=2Elen =3D (ULONG)slot-=
&gt;buf_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    slo=
t-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   status =3D WSASendTo(slot-&gt;socket, &amp;sbuf, 1, &amp;slot-&gt;bytes,=
 0 /* flags */,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                   (struct sockaddr *)&amp;slot-&gt;addr, slot-&gt;addr_len=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
     &amp;slot-&gt;overlapped, NULL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    handle_sendrecv_return(slot, status);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ensur=
e_pending_read(struct obfs_test_socket_win32 *sock)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct io_slot *slot =3D &amp;sock-&gt;slot_read;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (slot-&gt;stat=
us)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        case IO_SLOT_PENDING:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        case IO_SLOT_COMPLETE:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            /* Set the event=
 manually here just in case=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            SetEvent(slot-&gt;overlapped=2EhEvent);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        case IO_SLOT_DORMANT:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /* TODO: we don&#39;t prop=
agate max read size here, so we just have to assume the maximum=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            queue_new_rea=
d(slot, 65536);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        default:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            abort();</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+complete_=
pending_operation(struct io_slot *slot)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    DWORD bytes, flags;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    BOOL ok;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (slot-&gt=
;status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        case IO_SLOT_DORM=
ANT:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* =
TODO: shouldn&#39;t get here? */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        case IO_SLOT_COMPLETE:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     case IO_SLOT_PENDING:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            ok =3D WSAGetOverlappedResult(slot-&gt;socket, &amp;slot=
-&gt;overlapped, &amp;bytes,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                        FALSE /* don&#39;t wait */=
, &amp;flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (!ok &amp;&amp; WSAGetLastError() =3D=3D WSA_IO_INCOMPLETE)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                /* Still waitin=
g=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    else if (ok)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       /* Completed=2E slot-&gt;addr_len has already been updated=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                slot-&g=
t;buf_len =3D bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                slot-&gt;status =3D IO_SLOT_COMPLETE;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                slot-&gt;succeeded =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* Er=
ror=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      slot-&gt;buf_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                slot-&gt;status =3D IO_SLOT_COMPLETE;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                slot-&gt;succee=
ded =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           slot-&gt;wsa_error =3D WSAGetLastError();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                return true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        default:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            abort();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+complete_pending_read(struct obfs_test_so=
cket_win32 *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool done =3D co=
mplete_pending_operation(&amp;sock-&gt;slot_read);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (done)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        ResetEvent(sock-&gt;completion_events=2Eread);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return done;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+consumed_pendi=
ng_read(struct obfs_test_socket_win32 *sock)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct io_slot *slot =3D &amp;sock-&gt;slot_read;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert(slot-&gt;status =3D=3D =
IO_SLOT_COMPLETE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   slot-&gt;status =3D IO_SLOT_DORMANT;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    slot-&gt;succeeded =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ResetEvent(slot-&gt;overlapped=2EhEve=
nt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+complete_pending_write(struct obfs_test_socket_win32 =
*sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bool done =3D complete_pend=
ing_operation(&amp;sock-&gt;slot_write);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (done)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        SetEvent(sock-&gt;completion_events=2Ewrite);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return done;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+obfs_test_win32_request_eve=
nt(openvpn_transport_socket_t handle,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                              openvpn_transport_event_set=
_handle_t event_set, unsigned rwflags)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct obfs_test_socket_win32 *sock =3D (struct obfs_test_socket_win32=
 *)handle;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    obfs_=
test_log(sock-&gt;ctx, PLOG_DEBUG, &quot;request-event: %d&quot;, rwflags);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;last_r=
wflags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rwflags &amp; OPE=
NVPN_TRANSPORT_EVENT_READ)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 ensure_pending_read(sock);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (rwflags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        event_set-&gt;v=
tab-&gt;set_event(event_set, &amp;sock-&gt;completion_events, rwflags, hand=
le);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+obfs_test_win32_update_event(openvpn_transport_socket_t handle, void *arg,=
 unsigned rwflags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    obfs_test_log((=
(struct obfs_test_socket_win32 *)handle)-&gt;ctx, PLOG_DEBUG,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                  &quot;update-ev=
ent: %p, %p, %d&quot;, handle, arg, rwflags);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (arg !=3D handle)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ((struct obfs_test_socket_win32 *)handle)-&gt;last_rwflags |=3D rw=
flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static unsigned</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+obfs_test_win32_pump(openvpn_transport_socket_t handle)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct obfs_test_socket_win32 *sock=
 =3D (struct obfs_test_socket_win32 *)handle;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    unsigned result =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if ((sock-&gt;last_rwflags &amp; OPENVPN_TRANSPORT_EVENT=
_READ) &amp;&amp; complete_pending_read(sock))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        result |=3D OPENVPN_TRANSPORT_EVENT_READ;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if ((sock-&gt;last_rwflags &amp; OPENVPN_T=
RANSPORT_EVENT_WRITE)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        &amp;&amp; (sock-&gt;slot_write=2Estatus !=3D IO_SLOT_PENDING || =
complete_pending_write(sock)))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     result |=3D OPENVPN_TRANSPORT_EVENT_WRITE;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=
bfs_test_log(sock-&gt;ctx, PLOG_DEBUG, &quot;pump -&gt; %d&quot;, result);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return result;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static openvpn_transport_ssize_t</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+obfs_test_win32_recvfrom(openvpn_transport_so=
cket_t handle, void *buf, size_t len,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                         struct sockaddr *addr, openvpn_t=
ransport_socklen_t *addrlen)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t obfs_test_socket_win32 *sock =3D (struct obfs_test_socket_win32 *)handle;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!complete_p=
ending_read(sock))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        WSASetL=
astError(WSA_IO_INCOMPLETE);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return -1;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!sock-&gt;slot_re=
ad=2Esucceeded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int wsa_er=
ror =3D sock-&gt;slot_read=2Ewsa_error;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        consumed_pending_read(sock);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        WSASetLastError(wsa_error);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* sock-&gt;slot_read now has valid data=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *working_buf =3D=
 sock-&gt;slot_read=2Ebuf;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    openvpn_transport_ssize_t unmunged_len =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        obfs_test_unmunge_buf(&amp;sock-&=
gt;args, working_buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                              sock-&gt;slot_read=2Ebuf_len);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (unmunged_len &lt; 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* Act as though this read ne=
ver happened=2E Assume one was queued before, so it should</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         * still remain queued=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        consumed_pe=
nding_read(sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      ensure_pending_read(sock);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        WSASetLastError(WSA_IO_INCOMPLETE);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    size_t copy_len =3D unmunged_len;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (copy_len &gt; len)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        copy_len =3D len;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    memcpy(buf, sock-&gt;slot_read=2Ebuf, copy_len);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* TODO: shouldn&#39;t truncate, should signal erro=
r (but this shouldn&#39;t happen for any</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * supported address families anyway)=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_transport_sock=
len_t addr_copy_len =3D *addrlen;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (sock-&gt;slot_read=2Eaddr_len &lt; addr_copy_len)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        addr_copy_len =3D sock-&gt;sl=
ot_read=2Eaddr_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(add=
r, &amp;sock-&gt;slot_read=2Eaddr, addr_copy_len);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    *addrlen =3D addr_copy_len;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (addr_copy_len &gt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        obfs_test_munge_addr(addr, a=
ddr_copy_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Reset the I/O slot before retur=
ning=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    consu=
med_pending_read(sock);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return copy_len;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static openvpn_transport_ssize_t=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+obfs_test_win32_sen=
dto(openvpn_transport_socket_t handle, const void *buf, size_t len,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                       cons=
t struct sockaddr *addr, openvpn_transport_socklen_t addrlen)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct obfs_test_socket_win32 *sock =3D (struct=
 obfs_test_socket_win32 *)handle;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    complete_pending_write(sock);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (sock-&gt;slot_write=2Estatus =3D=3D IO_SLOT_PENDING)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* This shouldn&#39;t really ha=
ppen, but=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    WSASetLastError(WSAEWOULDBLOCK);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return -1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (addrlen &=
gt; sock-&gt;slot_write=2Eaddr_cap)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* Shouldn&#39;t happen=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        WSASetLastError(WSAEFAULT);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* TODO: propagate previous write errors---what does core expect here=
? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(&amp=
;sock-&gt;slot_write=2Eaddr, addr, addrlen);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    sock-&gt;slot_write=2Eaddr_len =3D addrlen;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (addrlen &gt; 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        obfs_test_munge_addr((st=
ruct sockaddr *)&amp;sock-&gt;slot_write=2Eaddr, addrlen);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    resize_io_buf(&amp;sock-&gt;slot_write, obfs_t=
est_max_munged_buf_size(len));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    sock-&gt;slot_write=2Ebuf_len =3D</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        obfs_test_munge_buf(&amp;sock-&gt;args=
, sock-&gt;slot_write=2Ebuf, buf, len);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    queue_new_write(&amp;sock-&gt;slot_write);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    switch (sock-&gt;slot_wr=
ite=2Estatus)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case IO_SLOT=
_PENDING:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  /* The network hasn&#39;t given us an error yet, but _we&#39;ve_ consumed=
 all the bytes=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
           * =2E=2E=2E sort of=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            return len;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        case IO_SLOT_DORMANT:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            /* Huh?? But we just queued a write=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            abort();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        case IO_SLOT_COMPLETE:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (sock-&gt;slot_write=
=2Esucceeded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    /* TODO: more partial length handling */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                return len;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                return -1;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        default:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          abort();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static openvpn_transport_native_event_t</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+obfs_test_win32_get_sock(openvpn=
_transport_socket_t handle)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 obfs_test_socket_win32 *sock =3D (struct obfs_test_socket_win32 *)handle;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return &amp;sock=
-&gt;completion_events;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+obfs_test_win32_close(openvpn_transport_s=
ocket_t handle)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_socket((struc=
t obfs_test_socket_win32 *)handle);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+obfs_test_initialize_vtabs_platform(=
void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    obfs_test_bind_vtab=2Ebind =
=3D obfs_test_win32_bind;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    obfs_test_socket_vtab=2Eget_sock =3D obfs_test_win32_get_sock;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    obfs_test_socket_v=
tab=2Erequest_event =3D obfs_test_win32_request_event;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    obfs_test_socket_vtab=2Eupdate_event=
 =3D obfs_test_win32_update_event;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    obfs_test_socket_vtab=2Epump =3D obfs_test_win32_pump;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    obfs_test_socket_=
vtab=2Erecvfrom =3D obfs_test_win32_recvfrom;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    obfs_test_socket_vtab=2Esendto =3D obfs_test_=
win32_sendto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ob=
fs_test_socket_vtab=2Eclose =3D obfs_test_win32_close;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/plugi=
ns/obfs-test/obfs-test=2Ec b/src/plugins/obfs-test/obfs-test=2Ec</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2Ef041102</span=
><br><span>--- /dev/null</span><br><span>+++ b/src/plugins/obfs-test/obfs-t=
est=2Ec</span><br><span>@@ -0,0 +1,94 @@</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbool=2Eh&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn-plugin=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;openvpn-transport=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;obfs-test=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+struct openvpn_transport_bind_vtab1 obfs_test_bind_vtab =3D { 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct openvpn_tra=
nsport_socket_vtab1 obfs_test_socket_vtab =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+struct obfs_test_context</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct openvpn_plugin_callbacks *global_vtab;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+free_conte=
xt(struct obfs_test_context *context)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!context)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    free(context);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+OPENVPN_EXPORT int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+openvpn_plugin_open_v3(int version, struct openvpn_plugin_args_open_in co=
nst *args,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              struct openvpn_plugin_args_open_return *out)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct obfs_test_context *context;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    context =3D (struct obfs_test_context *)calloc(1, =
sizeof(struct obfs_test_context));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!context)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    context-&gt;global_vtab =3D args=
-&gt;callbacks;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
obfs_test_initialize_vtabs_platform();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    obfs_test_bind_vtab=2Eparseargs =3D obfs_test_parsea=
rgs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    obfs_test_b=
ind_vtab=2Eargerror =3D obfs_test_argerror;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    obfs_test_bind_vtab=2Efreeargs =3D obfs_test_fr=
eeargs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    out-&gt;type_mask =3D OPENV=
PN_PLUGIN_MASK(OPENVPN_PLUGIN_TRANSPORT);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    out-&gt;handle =3D (openvpn_plugin_handle_t *)con=
text;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return OPE=
NVPN_PLUGIN_FUNC_SUCCESS;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    free_context(context);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return OPENVPN_PL=
UGIN_FUNC_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+OPENVPN_EXPORT void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+openvpn_plugin_close_v1(openvpn_plugin_h=
andle_t handle)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_context((stru=
ct obfs_test_context *)handle);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+OPENVPN_EXPORT int</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_plugin_func_v3(int=
 version,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
             struct openvpn_plugin_args_func_in const *arguments,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                       struct=
 openvpn_plugin_args_func_return *retptr)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* We don&#39;t ask for any bits that use this interface=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return OPENVPN_PLUGI=
N_FUNC_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+OPENVPN_EXPORT void *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+openvpn_plugin_get_vtab_v1(int selector=
, size_t *size_out)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (select=
or)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        case OPENVPN_VTAB_TRAN=
SPORT_BIND_V1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (obfs_test_bind_vtab=2Ebind =3D=3D NULL)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                return NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            *size_out =3D sizeof(struct openvpn=
_transport_bind_vtab1);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            return &amp;obfs_test_bind_vtab;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        default:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return NULL;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+obfs_test_log(struct obfs_test_context *ctx,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+              openvpn_plugin_=
log_flags_t flags, const char *fmt, =2E=2E=2E)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    va_list va;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    va_start(va, fmt);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ctx-&gt;global_vtab-&gt;plugin_vlog(flags, OBFS_TEST_PLUGIN_NAM=
E, fmt, va);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    va_=
end(va);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span>diff --git a/src/plugins/obfs-test/obfs-test=2Eexports b/src/plugins=
/obfs-test/obfs-test=2Eexports</span><br><span>new file mode 100644</span><=
br><span>index 0000000=2E=2Ee7baada</span><br><span>--- /dev/null</span><br=
><span>+++ b/src/plugins/obfs-test/obfs-test=2Eexports</span><br><span>@@ -=
0,0 +1,4 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_=
plugin_open_v3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openv=
pn_plugin_close_v1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+o=
penvpn_plugin_get_vtab_v1</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+openvpn_plugin_func_v3</span><br><span>diff --git a/src/plugins/obfs-=
test/obfs-test=2Eh b/src/plugins/obfs-test/obfs-test=2Eh</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000=2E=2E46309c5</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/src/plugins/obfs-test/obfs-test=2Eh<=
/span><br><span>@@ -0,0 +1,42 @@</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifndef OPENVPN_PLUGIN_OBFS_TEST_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define OPENVPN_PLUGIN_OBFS_TEST_H 1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;openvpn-plugin=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn-transp=
ort=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OBFS_TEST_PLUGIN_=
NAME &quot;obfs-test&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct obfs_=
test_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+struct obfs_test_args</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *error;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int offset;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ex=
tern struct openvpn_transport_bind_vtab1 obfs_test_bind_vtab;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+extern struct openvpn_transport_s=
ocket_vtab1 obfs_test_socket_vtab;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 obfs_test_initialize_vtabs_platform(void);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void obfs_test_munge_addr(struct sockaddr *addr, openvpn_transport_soc=
klen_t len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+size_t obfs_test_max_munge=
d_buf_size(size_t clear_size);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+size_t o=
bfs_test_munge_buf(struct obfs_test_args *how,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                           char *out, const char=
 *in, size_t len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_transport_ss=
ize_t obfs_test_unmunge_buf(struct obfs_test_args *how,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
         char *buf, size_t len);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvp=
n_transport_args_t obfs_test_parseargs(void *plugin_handle,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
          const char *const *argv, int argc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+const char *obfs_test_argerror(openvpn_transport_args_t args);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void obfs_test_freeargs(openvpn_transport_ar=
gs_t args);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void obfs_test_log(struct o=
bfs_test_context *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                   openvpn_plugin_log_flags_t flags, const char *fmt, =
=2E=2E=2E);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* !OPENVPN_PLUGIN_O=
BFS_TEST_H */</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2055?usp=3Demail">change 2055</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2055?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6a890e3661cc83021=
cf22ff6cd8752e7112c77cd </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2055 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarc=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--4VlfbvmtLvE=--


--===============7234038160342578485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7234038160342578485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7234038160342578485==--

