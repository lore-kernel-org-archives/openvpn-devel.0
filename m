Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92788C9833F
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=5XAwei+9yoNbA19jNzy7iO7eG5ex9Qm8RpWuRJ7vTgo=; b=Ev2xdWdmc6QU8k
	05xH+th0Oxm+RMGfEL7rx3osI1uMulqYLbbkVQBg+vlQIeinw+nOuBH/8sGzZNObfkBn9KDtkahMp
	yPcy+45iR1p+j4B/ZI58PRICvytIUJdIZ4d0tfgmCELCBYdANUniKJkvFC8ZPeob12nZ9rMFjnSmw
	gb4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBAm4-0004Z0-Fe;
	Mon, 28 Sep 2026 12:48:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBAm3-0004Yo-1t
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 12:48:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k612RN6VtdFu5de/9bmuTRfP+jPO/OApad3Uo9lK21E=; b=DTO/hankvUvtlFMeN4a2r/8kEa
 3/BR5v1/e6mYWE2yfj1FRv7xuTYR9ZuWlaffu9liWTAMK9604kNyaiLljshmg27gS2NHclKyuZZOo
 BNbKCoJe1iawsk+lK17eTYcK+NRRg+RegH3B0wxBo/gREM5teUPvfgO34XDIo5AtigdI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k612RN6VtdFu5de/9bmuTRfP+jPO/OApad3Uo9lK21E=; b=Z
 4j2zmgpbbKv7ge4lN6JZJeTZDYijEYEmJaWrkE/ej5PjqVN6XUlMk2NkPr1d8uGUHwHb7mHN1mZ6Q
 rY+AMWL5CYkobahGaYofHNQuf3K2tlr34tBqQ2d0OJrei/hIRo5BBDhErdd4iHxQ6m9P2PIJJL75c
 8M5M4upgr34oIb+o=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBAm0-0001r0-9w for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 12:48:03 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49fff72474fso8510055e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790599674; x=1791204474; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k612RN6VtdFu5de/9bmuTRfP+jPO/OApad3Uo9lK21E=;
 b=TB+/nDPo9g+zyuv6ADBiRUkUUIXQ9E4TzksiTGBBygcOsVECQeCrfqVj8oIUZEM67N
 zqF5e//noC9RR4qlQyKIfQnG0mkYw9qlJZGFw41Y1MpotRmnF6X+akt3uVzJIfiR6lGA
 Roo4/5OC08YUGNKiFMqsGwL5uB4J29ZejALtW7xVJvf0YDYnx4kqlYERjogMtKXKtHEi
 dSZ15I4YlOIqss5gIz7AM7Nb94xCgnvRLhFhrS8lamtDGnMkYs+scQA1FcqvGSxfDwil
 kY/5VlAndGfSJpv3wepGDpPzZDtddSLdw7rUU36LMO/UjuVW8jQ4oJFo3D8Xy1L0tTFv
 w51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790599674; x=1791204474;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k612RN6VtdFu5de/9bmuTRfP+jPO/OApad3Uo9lK21E=;
 b=iJtdofbsSOCmCI7O8mB3mHS1k2c2KivhLll6mkwEGXi+VLymWMoEAqg259l/88n5X0
 vr9LB+cIdlMQiOfb0COxVbZN5WgfZn+z6YKPa/hKdCC5QV/lt4GvzPUNpKQfghcIQY7+
 5ztVdcm/uFfQHo8gQDrzhgHMqLfLg5N4kMSptJ2HX+SlvNcMAVW7Cxc0FOdChj0SJcrO
 iRjpVnJ6lugrqeZrEHXS5v+VNToaYwPXlOyKNjhkFXCIdWZpbrBYYwOC132cu6vsoa+j
 tnuiBTecuDvyOxI9ek2qcA9JsxffqfX4BYfevWtQcWf4mrlxy8+ceEzY16Tq8vflH5iP
 JSUw==
X-Gm-Message-State: AFuF++m5EV8FkHndxQQY+94Kg+TP2NeAAb/hLoGXezbrp8E0pUGZDn9S
 K4fN7LCfWd2HjEVyyHRlRhhLQHpf0w/dxnioR7PEIWNqLrlX14R0D3JETUqrGF3FoO8t1BwjUSn
 1/7WZ5Qlb/T8s7eSDgSbIVrIjOXVNz04Mn/G/gx6Kpp7rzRagenILEXj8+pGODhYDlgf7WahAt3
 HEeKyesw==
X-Gm-Gg: AYBFou2UkGb1mweC9y2pkt2ALovRiXQ+7RrPbV3bY3lZ1SQw4AoUvYIdAlyRzRmRD67
 hKcDpZRt9X4fDGM2GpgS27kEC1+kyCpMYLxId+plg0c3Nwcp565icjiBHJ2KcEb6F/nEEd5xsMD
 hWCn4eFSkVaNV8F3kVyS+vmTVCYAAWYN3jG9dbO5JVc/L4ySFab8yE8WVQnSWIVSM81xagvmsBu
 sNApqpvLsD1KLFE16R8HTBjuSpF9z1eVRVu5rkpmSr0SVX59N3gXgPMkSbf5+Fvs63ugQ2ESCzW
 tDq+jkS8ne4q0gPQkUhyZ/H3UHFksPWxNaFZrIptOGMmDRGfjiw8snI4o+/n/cPThVWD82c5t3T
 /4GOsB1Z041xvxA19mZQxOvSI/xFuN26gfrZxgLgb+gLG2VxjEakNUeihDfNOluN3XagVzk/d7+
 2E1buSUndKJl9/XRURC6yINa8gkFbSX5vy4NcVYsvkPehOpK4Mpuu9z5JlEO+LPvs9egjwVLhp+
 Ite5pvKqRvtLFeAQcpB3BWY/xgHAFT1uEhzVH0M8I5jmBWDYT43f+gdCaOCgzGY5E881DAakCl5
 SdakcUd/XoorKnzt7+iqnw6Hza2Xn5Rmo3IaFOVP/iY1YzlrHdyPbm2xi0Rr6Q==
X-Received: by 2002:a05:600c:540e:b0:4a0:1d:3ac4 with SMTP id
 5b1f17b1804b1-4a0001d3ba8mr85546275e9.6.1790599673581; 
 Mon, 28 Sep 2026 05:47:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00c130538sm885415e9.4.2026.09.28.05.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:47:53 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 12:47:52 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
X-Gerrit-Change-Number: 1955
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1955?usp=email>
X-Gerrit-Commit: 5021b5a573c2cf4d791c625689bd920c94916de3
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNTk5NjY4MDAwLkk0NGQ3MTcxYzdlNGY4NDk3YmY4YjkwMjM4MGRmOTJhNThiZjhhNzlhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <99d1b1ba0478464025713405dc49e553b1905a17-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBAm0-0001r0-9w
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Build against
 Windows 10 API and remove some backwards compatility code
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3565625692389499978=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3565625692389499978==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2gA6U5cOWgE="; charset=UTF-8

--2gA6U5cOWgE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1955?usp=3Demail

to review the following change=2E


Chang=
e subject: Build against Windows 10 API and remove some backwards compatili=
ty code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Buil=
d against Windows 10 API and remove some backwards compatility code

Origin=
ally prompted by some cppcheck complaint about
win32_get_arch()=2E Looking =
at the code I decided to
propose removing the various work-arounds from pre=
-Win10
times=2E Microsoft certainly doesn't support these
versions anymore,=
 so let's also remove that=2E

Note that this does not remove all instances=
 of GetProcAddress:
- One is required due to a issue in MinGW toolchain (Di=
InstallDevice)
- One is used to avoid a dependency on WDK headers (RtlGetVe=
rsion)
- One is required due to using an undocumented function that is
  no=
t available in MinGW (RtlPublishWnfStateData)

Change-Id: I44d7171c7e4f8497=
bf8b902380df92a58bf8a79a
Signed-off-by: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
---
M CMakeLists=2Etxt
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
=
M src/openvpn/dco_win=2Ec
M src/openvpn/win32=2Ec
M src/openvpnmsica/CMakeL=
ists=2Etxt
M src/openvpnmsica/Makefile=2Eam
M src/openvpnserv/CMakeLists=2E=
txt
M src/openvpnserv/Makefile=2Eam
M src/tapctl/CMakeLists=2Etxt
M src/tap=
ctl/Makefile=2Eam
11 files changed, 40 insertions(+), 74 deletions(-)



  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1955/1
=

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index d553697=2E=2E0b34e5=
2 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -251,6 +251,12 @@=

 check_symbol_exists(strsep string=2Eh HAVE_STRSEP)
 check_symbol_exists(s=
trtok_r string=2Eh HAVE_STRTOK_R)
 
+if (WIN32)
+    # Required due to a bu=
g in MinGW where the =2Eh file is correct
+    # but the symbol is missing =
from newdev=2Edll
+    check_symbol_exists(DiInstallDevice newdev=2Eh HAVE_=
DIINSTALLDEVICE)
+endif ()
+
 # Some OS (e=2Eg=2E FreeBSD) need some basic =
headers to allow
 # including network headers
 set(NETEXTRA sys/types=2Eh)
=
@@ -344,7 +350,7 @@
     if (MINGW)
         target_compile_definitions(${t=
arget} PRIVATE
                 WIN32_LEAN_AND_MEAN
-                NTDDI_=
VERSION=3DNTDDI_VISTA _WIN32_WINNT=3D_WIN32_WINNT_VISTA
+                NT=
DDI_VERSION=3DNTDDI_WIN10 _WIN32_WINNT=3D_WIN32_WINNT_WIN10
         )
    =
 endif()
 
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
i=
ndex c6c0a96=2E=2E6c8660c 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=
=2Eh=2Ecmake=2Ein
@@ -330,6 +330,9 @@
 /* Define to 1 if you have the <valg=
rind/memcheck=2Eh> header file=2E */
 #undef HAVE_VALGRIND_MEMCHECK_H
 
+/*=
 Define to 1 if you have the `DiInstallDevice' function=2E */
+#cmakedefine=
 HAVE_DIINSTALLDEVICE
+
 /* Availability of different mbed TLS features and=
 APIs */
 #cmakedefine HAVE_PSA_CRYPTO_H
 
diff --git a/configure=2Eac b/co=
nfigure=2Eac
index 1fa0e63=2E=2Ea06c4c9 100644
--- a/configure=2Eac
+++ b/c=
onfigure=2Eac
@@ -346,7 +346,7 @@
 		AM_CONDITIONAL([ENABLE_DNS_UPDOWN], [f=
alse])
 		AC_SUBST([DNS_UPDOWN_TYPE], ["windows"])
 		CPPFLAGS=3D"${CPPFLAG=
S} -DWIN32_LEAN_AND_MEAN"
-		CPPFLAGS=3D"${CPPFLAGS} -DNTDDI_VERSION=3DNTDD=
I_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA"
+		CPPFLAGS=3D"${CPPFLAGS} -DN=
TDDI_VERSION=3DNTDDI_WIN10 -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10"
 		WIN32=3D=
yes
 		;;
 	*-*-dragonfly*)
@@ -1397,4 +1397,4 @@
 # Put the warning at the=
 end, so it is better visible
 if test "${enable_debug}" =3D "yes"; then
  =
   AC_MSG_WARN([--enable-developer-debug is enabled=2E This should be only =
used for test/development builds and not for production usage])
-fi
\ No ne=
wline at end of file
+fi
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn=
/dco_win=2Ec
index 90cff8c=2E=2Ebd94c1a 100644
--- a/src/openvpn/dco_win=2E=
c
+++ b/src/openvpn/dco_win=2Ec
@@ -35,6 +35,7 @@
 #include "openvpn=2Eh"
 =

 #include <bcrypt=2Eh>
+#include <ioapiset=2Eh>
 #include <winsock2=2Eh>
 =
#include <ws2tcpip=2Eh>
 
@@ -222,17 +223,6 @@
 dco_connect_wait(HANDLE han=
dle, OVERLAPPED *ov, int timeout, struct signal_info *sig_info)
 {
     vol=
atile int *signal_received =3D &sig_info->signal_received;
-    /* GetOverl=
appedResultEx is available starting from Windows 8 */
-    typedef BOOL(WIN=
API * get_overlapped_result_ex_t)(HANDLE, LPOVERLAPPED, LPDWORD, DWORD, BOO=
L);
-    get_overlapped_result_ex_t get_overlapped_result_ex =3D
-        (=
get_overlapped_result_ex_t)GetProcAddress(GetModuleHandle("Kernel32=2Edll")=
,
-                                                   "GetOverlappedResultE=
x");
-
-    if (get_overlapped_result_ex =3D=3D NULL)
-    {
-        msg(M=
_ERR, "Failed to load GetOverlappedResult()");
-    }
-
     DWORD timeout_=
msec =3D timeout * 1000;
     const int poll_interval_ms =3D 50;
 
@@ -241,=
7 +231,7 @@
         timeout_msec -=3D poll_interval_ms;
 
         DWORD t=
ransferred;
-        if (get_overlapped_result_ex(handle, ov, &transferred,=
 poll_interval_ms, FALSE) !=3D 0)
+        if (GetOverlappedResultEx(handle=
, ov, &transferred, poll_interval_ms, FALSE) !=3D 0)
         {
           =
  /* TCP connection established by dco */
             return;
diff --git a=
/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index 618772d=2E=2E04b1634 1=
00644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -37,6 +37,=
7 @@
 #include <winsock2=2Eh>
 #include <accctrl=2Eh>
 #include <aclapi=2Eh=
>
+#include <wow64apiset=2Eh>
 
 #include "buffer=2Eh"
 #include "error=2Eh=
"
@@ -1333,67 +1334,36 @@
 static void
 win32_get_arch(arch_t *process_arch=
, arch_t *host_arch)
 {
-    *process_arch =3D ARCH_UNKNOWN;
-    *host_arc=
h =3D ARCH_NATIVE;
-
-    typedef BOOL(WINAPI * is_wow64_process2_t)(HANDLE=
, USHORT *, USHORT *);
-    is_wow64_process2_t is_wow64_process2 =3D
-    =
    (is_wow64_process2_t)GetProcAddress(GetModuleHandle("Kernel32=2Edll"), =
"IsWow64Process2");
-
 #ifdef _ARM64_
     *process_arch =3D ARCH_ARM64;
 #=
elif defined(_WIN64)
     *process_arch =3D ARCH_AMD64;
-    if (is_wow64_p=
rocess2)
-    {
-        /* this could be amd64 on arm64 */
-        USHORT=
 process_machine =3D 0;
-        USHORT native_machine =3D 0;
-        BOOL=
 is_wow64 =3D is_wow64_process2(GetCurrentProcess(), &process_machine, &nat=
ive_machine);
-        if (is_wow64 && native_machine =3D=3D IMAGE_FILE_MAC=
HINE_ARM64)
-        {
-            *host_arch =3D ARCH_ARM64;
-        }
-=
    }
-#elif defined(_WIN32)
+#else
     *process_arch =3D ARCH_X86;
+#endi=
f
 
-    if (is_wow64_process2)
+    *host_arch =3D ARCH_NATIVE;
+    /* De=
termine if we're running on a different host-arch */
+    USHORT process_ma=
chine =3D 0;
+    USHORT native_machine =3D 0;
+    BOOL is_wow64 =3D IsWow=
64Process2(GetCurrentProcess(), &process_machine, &native_machine);
+    if=
 (is_wow64)
     {
-        /* check if we're running on arm64 or amd64 mac=
hine */
-        USHORT process_machine =3D 0;
-        USHORT native_machi=
ne =3D 0;
-        BOOL is_wow64 =3D is_wow64_process2(GetCurrentProcess(),=
 &process_machine, &native_machine);
-        if (is_wow64)
+        switch=
 (native_machine)
         {
-            switch (native_machine)
-        =
    {
-                case IMAGE_FILE_MACHINE_ARM64:
-                    =
*host_arch =3D ARCH_ARM64;
-                    break;
+            case IM=
AGE_FILE_MACHINE_ARM64:
+                *host_arch =3D ARCH_ARM64;
+      =
          break;
 
-                case IMAGE_FILE_MACHINE_AMD64:
-       =
             *host_arch =3D ARCH_AMD64;
-                    break;
+      =
      case IMAGE_FILE_MACHINE_AMD64:
+                *host_arch =3D ARCH_A=
MD64;
+                break;
 
-                default:
-                =
    *host_arch =3D ARCH_UNKNOWN;
-                    break;
-            }=

+            default:
+                *host_arch =3D ARCH_UNKNOWN;
+     =
           break;
         }
     }
-    else
-    {
-        BOOL w64 =3D =
FALSE;
-        BOOL is_wow64 =3D IsWow64Process(GetCurrentProcess(), &w64)=
 && w64;
-        if (is_wow64)
-        {
-            /* we are unable to=
 differentiate between arm64 and amd64
-             * machines here, so as=
sume we are running on amd64 */
-            *host_arch =3D ARCH_AMD64;
-  =
      }
-    }
-#endif /* _ARM64_ */
 }
 
 static void
diff --git a/src/ope=
nvpnmsica/CMakeLists=2Etxt b/src/openvpnmsica/CMakeLists=2Etxt
index 9126b8=
0=2E=2E06889c8 100644
--- a/src/openvpnmsica/CMakeLists=2Etxt
+++ b/src/ope=
nvpnmsica/CMakeLists=2Etxt
@@ -24,7 +24,7 @@
 target_compile_options(openvp=
nmsica PRIVATE
     -D_UNICODE
     -UNTDDI_VERSION
-    -D_WIN32_WINNT=3D_=
WIN32_WINNT_VISTA
+    -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10
     )
 
 if (MS=
VC)
diff --git a/src/openvpnmsica/Makefile=2Eam b/src/openvpnmsica/Makefile=
=2Eam
index 87bf9a7=2E=2E5e7838f 100644
--- a/src/openvpnmsica/Makefile=2Ea=
m
+++ b/src/openvpnmsica/Makefile=2Eam
@@ -34,8 +34,7 @@
 lib_LTLIBRARIES =
=3D libopenvpnmsica=2Ela
 libopenvpnmsica_la_CFLAGS =3D \
 	-municode -D_UN=
ICODE \
-	-UNTDDI_VERSION -U_WIN32_WINNT \
-	-D_WIN32_WINNT=3D_WIN32_WINNT_=
VISTA \
+	-UNTDDI_VERSION -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10 \
 	-Wl,--kil=
l-at
 libopenvpnmsica_la_LDFLAGS =3D -ladvapi32 -lole32 -lmsi -lsetupapi -l=
iphlpapi -lshell32 -lshlwapi -lversion -lnewdev -no-undefined -avoid-versio=
n
 endif
diff --git a/src/openvpnserv/CMakeLists=2Etxt b/src/openvpnserv/CM=
akeLists=2Etxt
index fc15382=2E=2E2cc4a93 100644
--- a/src/openvpnserv/CMak=
eLists=2Etxt
+++ b/src/openvpnserv/CMakeLists=2Etxt
@@ -21,7 +21,7 @@
     =
target_compile_options(${target} PRIVATE
         -D_UNICODE
         -UNTD=
DI_VERSION
-        -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
+        -D_WIN32_W=
INNT=3D_WIN32_WINNT_WIN10
     )
     target_link_libraries(${target} PRIVA=
TE
         advapi32=2Elib userenv=2Elib iphlpapi=2Elib fwpuclnt=2Elib rpcr=
t4=2Elib
diff --git a/src/openvpnserv/Makefile=2Eam b/src/openvpnserv/Makef=
ile=2Eam
index ac97eb4=2E=2E447fb10 100644
--- a/src/openvpnserv/Makefile=
=2Eam
+++ b/src/openvpnserv/Makefile=2Eam
@@ -23,8 +23,7 @@
 sbin_PROGRAMS =
=3D openvpnserv
 openvpnserv_CFLAGS =3D \
 	-municode -D_UNICODE \
-	-UNTDD=
I_VERSION -U_WIN32_WINNT \
-	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
+	-UNTDDI_=
VERSION -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10
 openvpnserv_LDADD =3D \
 	-lad=
vapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \
 	-lshlwapi -lnetapi32 -l=
ws2_32 -lntdll -lole32 -lpathcch
diff --git a/src/tapctl/CMakeLists=2Etxt b=
/src/tapctl/CMakeLists=2Etxt
index 97702c0=2E=2E94453ed 100644
--- a/src/ta=
pctl/CMakeLists=2Etxt
+++ b/src/tapctl/CMakeLists=2Etxt
@@ -21,10 +21,10 @@=

 target_compile_options(tapctl PRIVATE
     -D_UNICODE
     -UNTDDI_VERSIO=
N
-    -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
+    -D_WIN32_WINNT=3D_WIN32_WIN=
NT_WIN10
     )
 target_link_libraries(tapctl
-    advapi32=2Elib ole32=2El=
ib setupapi=2Elib)
+    advapi32=2Elib newdev=2Elib ole32=2Elib setupapi=2E=
lib)
 if (MINGW)
     target_compile_options(tapctl PRIVATE -municode)
    =
 target_link_options(tapctl PRIVATE -municode)
diff --git a/src/tapctl/Make=
file=2Eam b/src/tapctl/Makefile=2Eam
index 58cd580=2E=2E5d1f851 100644
--- =
a/src/tapctl/Makefile=2Eam
+++ b/src/tapctl/Makefile=2Eam
@@ -35,8 +35,7 @@=

 sbin_PROGRAMS =3D tapctl
 tapctl_CFLAGS =3D \
 	-municode -D_UNICODE \
-	=
-UNTDDI_VERSION -U_WIN32_WINNT \
-	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
+	-U=
NTDDI_VERSION	-D_WIN32_WINNT=3D_WIN32_WINNT_WIN10
 tapctl_LDADD =3D -ladvap=
i32 -lole32 -lsetupapi
 endif
 

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1955?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
Gerrit-Change-Number=
: 1955
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>

--2gA6U5cOWgE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Build against Windows 10 API and remove some backwards compatility cod=
e<br><br>Originally prompted by some cppcheck complaint about<br>win32_get_=
arch()=2E Looking at the code I decided to<br>propose removing the various =
work-arounds from pre-Win10<br>times=2E Microsoft certainly doesn&#39;t sup=
port these<br>versions anymore, so let&#39;s also remove that=2E<br><br>Not=
e that this does not remove all instances of GetProcAddress:<br>- One is re=
quired due to a issue in MinGW toolchain (DiInstallDevice)<br>- One is used=
 to avoid a dependency on WDK headers (RtlGetVersion)<br>- One is required =
due to using an undocumented function that is<br>  not available in MinGW (=
RtlPublishWnfStateData)<br><br>Change-Id: I44d7171c7e4f8497bf8b902380df92a5=
8bf8a79a<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>---<br>M CMakeLists=2Etxt<br>M config=2Eh=2Ecmake=2Ein<br>M configure=
=2Eac<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/win32=2Ec<br>M src/open=
vpnmsica/CMakeLists=2Etxt<br>M src/openvpnmsica/Makefile=2Eam<br>M src/open=
vpnserv/CMakeLists=2Etxt<br>M src/openvpnserv/Makefile=2Eam<br>M src/tapctl=
/CMakeLists=2Etxt<br>M src/tapctl/Makefile=2Eam<br>11 files changed, 40 ins=
ertions(+), 74 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1955/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index d553697=2E=2E0b3=
4e52 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CM=
akeLists=2Etxt</span><br><span>@@ -251,6 +251,12 @@</span><br><span> check_=
symbol_exists(strsep string=2Eh HAVE_STRSEP)</span><br><span> check_symbol_=
exists(strtok_r string=2Eh HAVE_STRTOK_R)</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+if (WIN32)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    # Required due to a bug in MinGW where t=
he =2Eh file is correct</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    # but the symbol is missing from newdev=2Edll</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(DiInstallDevice n=
ewdev=2Eh HAVE_DIINSTALLDEVICE)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> # Some OS (e=2Eg=2E FreeBSD) need some basic headers to =
allow</span><br><span> # including network headers</span><br><span> set(NET=
EXTRA sys/types=2Eh)</span><br><span>@@ -344,7 +350,7 @@</span><br><span>  =
   if (MINGW)</span><br><span>         target_compile_definitions(${target}=
 PRIVATE</span><br><span>                 WIN32_LEAN_AND_MEAN</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                NTDDI_VERSION=3DNTD=
DI_VISTA _WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                NTDDI_VERSION=3DNTDDI_WIN10 _WIN32_W=
INNT=3D_WIN32_WINNT_WIN10</span><br><span>         )</span><br><span>     e=
ndif()</span><br><span> </span><br><span>diff --git a/config=2Eh=2Ecmake=2E=
in b/config=2Eh=2Ecmake=2Ein</span><br><span>index c6c0a96=2E=2E6c8660c 100=
644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/con=
fig=2Eh=2Ecmake=2Ein</span><br><span>@@ -330,6 +330,9 @@</span><br><span> /=
* Define to 1 if you have the &lt;valgrind/memcheck=2Eh&gt; header file=2E =
*/</span><br><span> #undef HAVE_VALGRIND_MEMCHECK_H</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you hav=
e the `DiInstallDevice&#39; function=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#cmakedefine HAVE_DIINSTALLDEVICE</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Availability of d=
ifferent mbed TLS features and APIs */</span><br><span> #cmakedefine HAVE_P=
SA_CRYPTO_H</span><br><span> </span><br><span>diff --git a/configure=2Eac b=
/configure=2Eac</span><br><span>index 1fa0e63=2E=2Ea06c4c9 100644</span><br=
><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br>=
<span>@@ -346,7 +346,7 @@</span><br><span> 		AM_CONDITIONAL([ENABLE_DNS_UPD=
OWN], [false])</span><br><span> 		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;window=
s&quot;])</span><br><span> 		CPPFLAGS=3D&quot;${CPPFLAGS} -DWIN32_LEAN_AND_=
MEAN&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		CPPFLAGS=
=3D&quot;${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_=
WINNT_VISTA&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		=
CPPFLAGS=3D&quot;${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_WIN10 -D_WIN32_WINNT=
=3D_WIN32_WINNT_WIN10&quot;</span><br><span> 		WIN32=3Dyes</span><br><span>=
 		;;</span><br><span> 	*-*-dragonfly*)</span><br><span>@@ -1397,4 +1397,4 =
@@</span><br><span> # Put the warning at the end, so it is better visible</=
span><br><span> if test &quot;${enable_debug}&quot; =3D &quot;yes&quot;; th=
en</span><br><span>     AC_MSG_WARN([--enable-developer-debug is enabled=2E=
 This should be only used for test/development builds and not for productio=
n usage])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br=
><span>\ No newline at end of file</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+fi</span><br><span>diff --git a/src/openvpn/dco_win=2Ec b/sr=
c/openvpn/dco_win=2Ec</span><br><span>index 90cff8c=2E=2Ebd94c1a 100644</sp=
an><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvp=
n/dco_win=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> #include &=
quot;openvpn=2Eh&quot;</span><br><span> </span><br><span> #include &lt;bcry=
pt=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&lt;ioapiset=2Eh&gt;</span><br><span> #include &lt;winsock2=2Eh&gt;</span><=
br><span> #include &lt;ws2tcpip=2Eh&gt;</span><br><span> </span><br><span>@=
@ -222,17 +223,6 @@</span><br><span> dco_connect_wait(HANDLE handle, OVERLA=
PPED *ov, int timeout, struct signal_info *sig_info)</span><br><span> {</sp=
an><br><span>     volatile int *signal_received =3D &amp;sig_info-&gt;signa=
l_received;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Get=
OverlappedResultEx is available starting from Windows 8 */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    typedef BOOL(WINAPI * get_overlapp=
ed_result_ex_t)(HANDLE, LPOVERLAPPED, LPDWORD, DWORD, BOOL);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    get_overlapped_result_ex_t get_o=
verlapped_result_ex =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        (get_overlapped_result_ex_t)GetProcAddress(GetModuleHandle(&quot;=
Kernel32=2Edll&quot;),</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                                   &quot;GetOverlappedResu=
ltEx&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (get_overlapped_result_=
ex =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR, &qu=
ot;Failed to load GetOverlappedResult()&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span>     DWORD timeout_msec =3D timeout * 1000;</spa=
n><br><span>     const int poll_interval_ms =3D 50;</span><br><span> </span=
><br><span>@@ -241,7 +231,7 @@</span><br><span>         timeout_msec -=3D p=
oll_interval_ms;</span><br><span> </span><br><span>         DWORD transferr=
ed;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (get_ov=
erlapped_result_ex(handle, ov, &amp;transferred, poll_interval_ms, FALSE) !=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (G=
etOverlappedResultEx(handle, ov, &amp;transferred, poll_interval_ms, FALSE)=
 !=3D 0)</span><br><span>         {</span><br><span>             /* TCP con=
nection established by dco */</span><br><span>             return;</span><b=
r><span>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><b=
r><span>index 618772d=2E=2E04b1634 100644</span><br><span>--- a/src/openvpn=
/win32=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -=
37,6 +37,7 @@</span><br><span> #include &lt;winsock2=2Eh&gt;</span><br><spa=
n> #include &lt;accctrl=2Eh&gt;</span><br><span> #include &lt;aclapi=2Eh&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;wow64=
apiset=2Eh&gt;</span><br><span> </span><br><span> #include &quot;buffer=2Eh=
&quot;</span><br><span> #include &quot;error=2Eh&quot;</span><br><span>@@ -=
1333,67 +1334,36 @@</span><br><span> static void</span><br><span> win32_get=
_arch(arch_t *process_arch, arch_t *host_arch)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    *process_arch =3D ARCH_UNKN=
OWN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *host_arch =
=3D ARCH_NATIVE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    typedef BOOL(WINAPI * =
is_wow64_process2_t)(HANDLE, USHORT *, USHORT *);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    is_wow64_process2_t is_wow64_process2 =3D</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (is_wow64_proce=
ss2_t)GetProcAddress(GetModuleHandle(&quot;Kernel32=2Edll&quot;), &quot;IsW=
ow64Process2&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> #ifdef _ARM64_</span><br><span>     *process_arch =3D ARCH=
_ARM64;</span><br><span> #elif defined(_WIN64)</span><br><span>     *proces=
s_arch =3D ARCH_AMD64;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (is_wow64_process2)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*=
 this could be amd64 on arm64 */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        USHORT process_machine =3D 0;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        USHORT native_machine =3D 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        BOOL is_wow64 =3D is_wow6=
4_process2(GetCurrentProcess(), &amp;process_machine, &amp;native_machine);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (is_wow64 =
&amp;&amp; native_machine =3D=3D IMAGE_FILE_MACHINE_ARM64)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            *host_arch =3D ARCH_ARM64;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#elif defined(_WIN32)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#else</span><br><span>     *process_arch =3D ARCH_X86;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (is_wow64_pr=
ocess2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *host_ar=
ch =3D ARCH_NATIVE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Determine if we&#39;re running on a different host-arch */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    USHORT process_machine =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    USHORT na=
tive_machine =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    BOOL is_wow64 =3D IsWow64Process2(GetCurrentProcess(), &amp;process_mac=
hine, &amp;native_machine);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (is_wow64)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /* check if we&#39;re running on arm64 o=
r amd64 machine */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     USHORT process_machine =3D 0;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        USHORT native_machine =3D 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        BOOL is_wow64 =3D is_wow64_process2(Get=
CurrentProcess(), &amp;process_machine, &amp;native_machine);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (is_wow64)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        switch (native_machine)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            switch (native_machine)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                case IMAGE_FILE_MACHINE_ARM64:</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    *host_arch =3D ARCH_=
ARM64;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    case IMAGE_FILE_MACHINE_ARM64:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                *host_arch =3D ARCH_ARM64;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ca=
se IMAGE_FILE_MACHINE_AMD64:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    *host_arch =3D ARCH_AMD64;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    break;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            case IMAGE_FILE_MACHINE_=
AMD64:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   *host_arch =3D ARCH_AMD64;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                break;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                default:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    *host_arch =3D ARCH_UNK=
NOWN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            defau=
lt:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
*host_arch =3D ARCH_UNKNOWN;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                break;</span><br><span>         }</span><br><span>=
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        BOOL w64 =3D FALSE;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        BOOL is_wow64 =3D IsWow64Proc=
ess(GetCurrentProcess(), &amp;w64) &amp;&amp; w64;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (is_wow64)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            /* we are unable to differentiate between arm6=
4 and amd64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
   * machines here, so assume we are running on amd64 */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            *host_arch =3D ARCH_AMD64;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif /* _ARM64_ */</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span>diff --git a/src/openvp=
nmsica/CMakeLists=2Etxt b/src/openvpnmsica/CMakeLists=2Etxt</span><br><span=
>index 9126b80=2E=2E06889c8 100644</span><br><span>--- a/src/openvpnmsica/C=
MakeLists=2Etxt</span><br><span>+++ b/src/openvpnmsica/CMakeLists=2Etxt</sp=
an><br><span>@@ -24,7 +24,7 @@</span><br><span> target_compile_options(open=
vpnmsica PRIVATE</span><br><span>     -D_UNICODE</span><br><span>     -UNTD=
DI_VERSION</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    -D_WIN3=
2_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10</span><br><span>     )</sp=
an><br><span> </span><br><span> if (MSVC)</span><br><span>diff --git a/src/=
openvpnmsica/Makefile=2Eam b/src/openvpnmsica/Makefile=2Eam</span><br><span=
>index 87bf9a7=2E=2E5e7838f 100644</span><br><span>--- a/src/openvpnmsica/M=
akefile=2Eam</span><br><span>+++ b/src/openvpnmsica/Makefile=2Eam</span><br=
><span>@@ -34,8 +34,7 @@</span><br><span> lib_LTLIBRARIES =3D libopenvpnmsi=
ca=2Ela</span><br><span> libopenvpnmsica_la_CFLAGS =3D \</span><br><span> 	=
-municode -D_UNICODE \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	-UNTDDI_VERSION -U_WIN32_WINNT \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	-UNTDDI_VERSION -D_WIN32_WINNT=3D_WIN32_=
WINNT_WIN10 \</span><br><span> 	-Wl,--kill-at</span><br><span> libopenvpnms=
ica_la_LDFLAGS =3D -ladvapi32 -lole32 -lmsi -lsetupapi -liphlpapi -lshell32=
 -lshlwapi -lversion -lnewdev -no-undefined -avoid-version</span><br><span>=
 endif</span><br><span>diff --git a/src/openvpnserv/CMakeLists=2Etxt b/src/=
openvpnserv/CMakeLists=2Etxt</span><br><span>index fc15382=2E=2E2cc4a93 100=
644</span><br><span>--- a/src/openvpnserv/CMakeLists=2Etxt</span><br><span>=
+++ b/src/openvpnserv/CMakeLists=2Etxt</span><br><span>@@ -21,7 +21,7 @@</s=
pan><br><span>     target_compile_options(${target} PRIVATE</span><br><span=
>         -D_UNICODE</span><br><span>         -UNTDDI_VERSION</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        -D_WIN32_WINNT=3D_WIN32_WIN=
NT_VISTA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        -D_=
WIN32_WINNT=3D_WIN32_WINNT_WIN10</span><br><span>     )</span><br><span>   =
  target_link_libraries(${target} PRIVATE</span><br><span>         advapi32=
=2Elib userenv=2Elib iphlpapi=2Elib fwpuclnt=2Elib rpcrt4=2Elib</span><br><=
span>diff --git a/src/openvpnserv/Makefile=2Eam b/src/openvpnserv/Makefile=
=2Eam</span><br><span>index ac97eb4=2E=2E447fb10 100644</span><br><span>---=
 a/src/openvpnserv/Makefile=2Eam</span><br><span>+++ b/src/openvpnserv/Make=
file=2Eam</span><br><span>@@ -23,8 +23,7 @@</span><br><span> sbin_PROGRAMS =
=3D openvpnserv</span><br><span> openvpnserv_CFLAGS =3D \</span><br><span> =
	-municode -D_UNICODE \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	-UNTDDI_VERSION -U_WIN32_WINNT \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	-UNTDDI_VERSION -D_WIN32_WINNT=3D_WIN32_WIN=
NT_WIN10</span><br><span> openvpnserv_LDADD =3D \</span><br><span> 	-ladvap=
i32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \</span><br><span> 	-lshlwapi =
-lnetapi32 -lws2_32 -lntdll -lole32 -lpathcch</span><br><span>diff --git a/=
src/tapctl/CMakeLists=2Etxt b/src/tapctl/CMakeLists=2Etxt</span><br><span>i=
ndex 97702c0=2E=2E94453ed 100644</span><br><span>--- a/src/tapctl/CMakeList=
s=2Etxt</span><br><span>+++ b/src/tapctl/CMakeLists=2Etxt</span><br><span>@=
@ -21,10 +21,10 @@</span><br><span> target_compile_options(tapctl PRIVATE</=
span><br><span>     -D_UNICODE</span><br><span>     -UNTDDI_VERSION</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    -D_WIN32_WINNT=3D_WIN32_W=
INNT_VISTA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    -D_WI=
N32_WINNT=3D_WIN32_WINNT_WIN10</span><br><span>     )</span><br><span> targ=
et_link_libraries(tapctl</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    advapi32=2Elib ole32=2Elib setupapi=2Elib)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    advapi32=2Elib newdev=2Elib ole32=2Elib s=
etupapi=2Elib)</span><br><span> if (MINGW)</span><br><span>     target_comp=
ile_options(tapctl PRIVATE -municode)</span><br><span>     target_link_opti=
ons(tapctl PRIVATE -municode)</span><br><span>diff --git a/src/tapctl/Makef=
ile=2Eam b/src/tapctl/Makefile=2Eam</span><br><span>index 58cd580=2E=2E5d1f=
851 100644</span><br><span>--- a/src/tapctl/Makefile=2Eam</span><br><span>+=
++ b/src/tapctl/Makefile=2Eam</span><br><span>@@ -35,8 +35,7 @@</span><br><=
span> sbin_PROGRAMS =3D tapctl</span><br><span> tapctl_CFLAGS =3D \</span><=
br><span> 	-municode -D_UNICODE \</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	-UNTDDI_VERSION -U_WIN32_WINNT \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	-UNTDDI_VERSION	-D_WIN32_WINNT=3D=
_WIN32_WINNT_WIN10</span><br><span> tapctl_LDADD =3D -ladvapi32 -lole32 -ls=
etupapi</span><br><span> endif</span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">change 1955</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I44d=
7171c7e4f8497bf8b902380df92a58bf8a79a </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1955 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--2gA6U5cOWgE=--


--===============3565625692389499978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3565625692389499978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3565625692389499978==--

