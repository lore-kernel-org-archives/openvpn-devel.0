Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23436CA5FF1
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NO4ekoNXv7ZJpmAbGFT37Z3NzR4U9tw3cCWgqIQTuUY=; b=gnof/Vc9NHM3wWHr8pXcLCK6BM
	Rg2zoztJZQpifhlAlRelO2zYd3MKGLgJ31ikUFVp2Z9cblK+i3DnkT1lwlrgpxNjP7bGl2ZcpArV0
	vb1rakLTUvUVaNctaNTz93O9gHScBJKWhr6+14ix9PT1uhcRIhhNU8xfljyUh9VOxbBU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDI1a-0006kh-Cp;
	Sun, 04 Oct 2026 08:56:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDI1X-0006kM-O8
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oyA5SyGJkN2t5jqeoDahevCH4qR34T5Nm10BRkWwdd0=; b=YmvYNGG4soBvKA2Za5rj87rEIN
 hWC/NNxzqPfLOSYvezAx6VLizfrf3PUeOIkz0/4OQMTGT0unpdAKaKFXi2aMHco3yDStLBUMsN4y3
 l+4rnvjud4nDIULJiB5XO8P0OBtrxtW1jGN9hRsjwNscmh2jDpVm9RdvEmNiSEp9RxlU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oyA5SyGJkN2t5jqeoDahevCH4qR34T5Nm10BRkWwdd0=; b=H
 aMARx/u1hOjZF/K8YKHeEuk6np2YwemRNzWoyQhkmJr/cHTEANDUA8IYF1RgLw02YggI0GHuXYlhA
 T6RrlKRIRu7wBXOtsqwFYQUja+J1Y0rCM7g6jJhFjTIGSfZ+mdeLpDreyOflCF/6mP18x19gMYtZK
 7Qa2l1WtyWlNPwTs=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDI1W-000541-H8 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:56:48 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso8989925e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 01:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791104200; x=1791709000; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oyA5SyGJkN2t5jqeoDahevCH4qR34T5Nm10BRkWwdd0=;
 b=PKvIHhPBKLm30duhmIYU576OusUUDAHp8GIei/KGbfNFtLKU9XsMRpuPC4kF2Vi22f
 Vf2oCiZIThSW+GHi8eqJryguxV47cl4KUqKNH+RxRCHBPkxUzB47d22aH0MyXgR+PbeF
 YTmKQ/ele+dUE/vzw8Iv6c3qVdIWj0/zyVLcV1FwJcLcuJoy82I5mSL/AZOuLjzvwbMh
 VxpmpOIodI7RJB3EgHarV+4gmQVnmKIFNSEzZIS86zcg7LL0P8EMh+PBn9b9wKF8T7Ea
 aQ2TlncsCsYLn88G6/iaKuNYg2i2SpMI7rhHMt10J5Kor449di6n7wgHxqBA16rzDFSN
 PeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791104200; x=1791709000;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oyA5SyGJkN2t5jqeoDahevCH4qR34T5Nm10BRkWwdd0=;
 b=RNZqW8Zwqiyhcp6cOTl+77Bt5a1paP9j4tY5Ow+x16wFgbRYmEe8FmSnAJQRuQoKtz
 FUACBLfCaoDki+8ZDkcisSTNtisBLP5VFCzqBbLbg4KOE5mRHO4A+Ef0YCpD4hccIwLO
 zdr2+RVlxQjMEyH5aKCVz2+ecnj6C1CNVSCjMZx5P5rl91BkzM+vHWMZN/hOP0anwe7j
 pR18hMk/IoT3XWy+zmE27nMD2aAnh1A3sBLtjLDX8xjbwpO/jZcO6VHWHke+M/8TDvHQ
 7m1amhq2VtysGFq6cHnix0g/mAivpPdayQnU80g4JVH/LR+8H/o0zmbWWELWopuCsC17
 PTpA==
X-Gm-Message-State: AFuF++mTa0rKeRdwyviRLR60rgc42zTtS1eyXS4IuZ/J+iZOU1Qh91lr
 T6QrDpjShtjwarBSKogr6wHUdXR9AZFsq622vCdfflm3SGzV+asKtAAFR8i4n0nFo73BzH5sHjh
 oNSX4k61di1yjolzSXw/U570HnO1zQo12DDPTdC363LkNDY0s2HQqdm+fh2DCp6cThytMDyZ7Q/
 DKwmB2zQ==
X-Gm-Gg: AYBFou1PwdiZl0NbkKmeVTuLPjD6av4ZoDmtbr+5QOXxcScE7fZ2PyrLxO2i9cPyGel
 haEvr9GHvwTfSXc7ZWwFH3M0pTCXklp6uArJddf/UbRmceKR6Blx74RixSSc2PndfDERXdQWd5n
 WKdj1m/LvlKJn7d4MrqK7TABz00ZqOkZkByVXoIM2LhGgm8KQzinNAX7EZEd0ewWdL1YeaWngBk
 DdkonLfrSN4AF6Nttl4tZR34w206XGaULdhUutqrHq0u3iP0f29TyHPiqKi4m64B8qb/mAnhLEv
 czV87hXwZpxj6mzZTQYH4B208j9bkhEyGc6BwTSh4w3lQpabl2z4HJtdqxsX6R807acC7PmFOiz
 +5/xoj+AQnKZB2sDzJMNJll67CRgBxaIwGgBErzyjIw93h/EiZEgCpResj90D4LI/kMCY1Lf9Hx
 bkRAbm3q1qY4zlnmLxaNiip9gciIqYzOpPzu7YJM52FRhHy8uR4Zj6oiibIYZoh3vhau+l5nD/l
 zXwWhJek4ULrISl3mAJrxOUvZl5rFKG5ZU/4mXC6LFgsmizIhcflFvEChx1fSiTYW99UirzMZWK
 EB2ev/1+9L9ffxDM47b6zN2VkhcydN04ysSKXk7SYfbjSCnzt/c/G5p7psWu
X-Received: by 2002:a05:600c:3b03:b0:4a1:6994:69d8 with SMTP id
 5b1f17b1804b1-4a169946aa3mr55007275e9.35.1791104199691; 
 Sun, 04 Oct 2026 01:56:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280c8bb0sm264304165e9.11.2026.10.04.01.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 01:56:39 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 4 Oct 2026 08:56:37 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
X-Gerrit-Change-Number: 1955
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1955?usp=email>
X-Gerrit-Commit: 624f08b120a119ac730ce6e09c2abc59495c069d
In-Reply-To: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNTk5NjY4MDAwLkk0NGQ3MTcxYzdlNGY4NDk3YmY4YjkwMjM4MGRmOTJhNThiZjhhNzlhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a52bbb61c9b7786a00904765676122c108aa9e78-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDI1W-000541-H8
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6175977793418847895=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6175977793418847895==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZZp5/6ucULk="; charset=UTF-8

--ZZp5/6ucULk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#5) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
955?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by Gert Doering


Change subject: Build against Windows 10 API=
 and remove some backwards compatility code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Build against Windows 10 API and remove som=
e backwards compatility code

Originally prompted by some cppcheck complain=
t about
win32_get_arch()=2E Looking at the code I decided to
propose removi=
ng the various work-arounds from pre-Win10
times=2E Microsoft certainly doe=
sn't support these
versions anymore, so let's also remove that=2E

Note tha=
t this does not remove all instances of GetProcAddress:
- One is required d=
ue to a issue in MinGW toolchain (DiInstallDevice)
- One is used to avoid a=
 dependency on WDK headers (RtlGetVersion)
- One is required due to using a=
n undocumented function that is
  not available in MinGW (RtlPublishWnfStat=
eData)

Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
Signed-off-by:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
955
Message-Id: <20261003175718=2E6544-1-gert@greenie=2Emuc=2Ede>
URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg396=
73=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMake=
Lists=2Etxt
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
M src/openvpn/dco_wi=
n=2Ec
M src/openvpn/win32=2Ec
M src/openvpnmsica/CMakeLists=2Etxt
M src/ope=
nvpnmsica/Makefile=2Eam
M src/openvpnserv/CMakeLists=2Etxt
M src/openvpnser=
v/Makefile=2Eam
M src/tapctl/CMakeLists=2Etxt
M src/tapctl/Makefile=2Eam
M =
src/tapctl/tap=2Ec
12 files changed, 56 insertions(+), 75 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1955/5
=

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index d553697=2E=2E2d9b54=
6 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -251,6 +251,14 @@=

 check_symbol_exists(strsep string=2Eh HAVE_STRSEP)
 check_symbol_exists(s=
trtok_r string=2Eh HAVE_STRTOK_R)
 
+if (WIN32)
+    # Required due to a bu=
g in MinGW where the =2Eh file is correct
+    # but the symbol is missing =
from newdev=2Edll
+    set(CMAKE_REQUIRED_LIBRARIES newdev=2Elib)
+    chec=
k_symbol_exists(DiInstallDevice "windows=2Eh;newdev=2Eh" HAVE_DIINSTALLDEVI=
CE)
+    unset(CMAKE_REQUIRED_LIBRARIES)
+endif ()
+
 # Some OS (e=2Eg=2E F=
reeBSD) need some basic headers to allow
 # including network headers
 set(=
NETEXTRA sys/types=2Eh)
@@ -344,7 +352,7 @@
     if (MINGW)
         target=
_compile_definitions(${target} PRIVATE
                 WIN32_LEAN_AND_MEAN=

-                NTDDI_VERSION=3DNTDDI_VISTA _WIN32_WINNT=3D_WIN32_WINNT_V=
ISTA
+                NTDDI_VERSION=3DNTDDI_WIN10 _WIN32_WINNT=3D_WIN32_WIN=
NT_WIN10
         )
     endif()
 
diff --git a/config=2Eh=2Ecmake=2Ein b/c=
onfig=2Eh=2Ecmake=2Ein
index c6c0a96=2E=2E6c8660c 100644
--- a/config=2Eh=
=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -330,6 +330,9 @@
 /* Define =
to 1 if you have the <valgrind/memcheck=2Eh> header file=2E */
 #undef HAVE=
_VALGRIND_MEMCHECK_H
 
+/* Define to 1 if you have the `DiInstallDevice' fu=
nction=2E */
+#cmakedefine HAVE_DIINSTALLDEVICE
+
 /* Availability of diffe=
rent mbed TLS features and APIs */
 #cmakedefine HAVE_PSA_CRYPTO_H
 
diff -=
-git a/configure=2Eac b/configure=2Eac
index 195116f=2E=2E56109af 100644
--=
- a/configure=2Eac
+++ b/configure=2Eac
@@ -346,7 +346,7 @@
 		AM_CONDITION=
AL([ENABLE_DNS_UPDOWN], [false])
 		AC_SUBST([DNS_UPDOWN_TYPE], ["windows"]=
)
 		CPPFLAGS=3D"${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
-		CPPFLAGS=3D"${CPPFLA=
GS} -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA"
+		C=
PPFLAGS=3D"${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_WIN10 -D_WIN32_WINNT=3D_WIN3=
2_WINNT_WIN10"
 		WIN32=3Dyes
 		;;
 	*-*-dragonfly*)
@@ -1397,4 +1397,4 @@=

 # Put the warning at the end, so it is better visible
 if test "${enable_=
debug}" =3D "yes"; then
     AC_MSG_WARN([--enable-developer-debug is enabl=
ed=2E This should be only used for test/development builds and not for prod=
uction usage])
-fi
\ No newline at end of file
+fi
diff --git a/src/openvpn=
/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index 90cff8c=2E=2Ebd94c1a 100644
--=
- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -35,6 +35,7 @@=

 #include "openvpn=2Eh"
 
 #include <bcrypt=2Eh>
+#include <ioapiset=2Eh>
=
 #include <winsock2=2Eh>
 #include <ws2tcpip=2Eh>
 
@@ -222,17 +223,6 @@
 d=
co_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, struct signal_i=
nfo *sig_info)
 {
     volatile int *signal_received =3D &sig_info->signal_=
received;
-    /* GetOverlappedResultEx is available starting from Windows =
8 */
-    typedef BOOL(WINAPI * get_overlapped_result_ex_t)(HANDLE, LPOVERL=
APPED, LPDWORD, DWORD, BOOL);
-    get_overlapped_result_ex_t get_overlappe=
d_result_ex =3D
-        (get_overlapped_result_ex_t)GetProcAddress(GetModu=
leHandle("Kernel32=2Edll"),
-                                              =
     "GetOverlappedResultEx");
-
-    if (get_overlapped_result_ex =3D=3D N=
ULL)
-    {
-        msg(M_ERR, "Failed to load GetOverlappedResult()");
- =
   }
-
     DWORD timeout_msec =3D timeout * 1000;
     const int poll_inte=
rval_ms =3D 50;
 
@@ -241,7 +231,7 @@
         timeout_msec -=3D poll_inter=
val_ms;
 
         DWORD transferred;
-        if (get_overlapped_result_ex=
(handle, ov, &transferred, poll_interval_ms, FALSE) !=3D 0)
+        if (Ge=
tOverlappedResultEx(handle, ov, &transferred, poll_interval_ms, FALSE) !=3D=
 0)
         {
             /* TCP connection established by dco */
       =
      return;
diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
in=
dex 82341f8=2E=2Efde6412 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openv=
pn/win32=2Ec
@@ -37,6 +37,7 @@
 #include <winsock2=2Eh>
 #include <accctrl=
=2Eh>
 #include <aclapi=2Eh>
+#include <wow64apiset=2Eh>
 
 #include "buffe=
r=2Eh"
 #include "error=2Eh"
@@ -1334,67 +1335,47 @@
 static void
 win32_ge=
t_arch(arch_t *process_arch, arch_t *host_arch)
 {
-    *process_arch =3D A=
RCH_UNKNOWN;
-    *host_arch =3D ARCH_NATIVE;
-
-    typedef BOOL(WINAPI * =
is_wow64_process2_t)(HANDLE, USHORT *, USHORT *);
-    is_wow64_process2_t =
is_wow64_process2 =3D
-        (is_wow64_process2_t)GetProcAddress(GetModul=
eHandle("Kernel32=2Edll"), "IsWow64Process2");
-
 #ifdef _ARM64_
     *proc=
ess_arch =3D ARCH_ARM64;
 #elif defined(_WIN64)
     *process_arch =3D ARCH=
_AMD64;
-    if (is_wow64_process2)
-    {
-        /* this could be amd64 =
on arm64 */
-        USHORT process_machine =3D 0;
-        USHORT native_m=
achine =3D 0;
-        BOOL is_wow64 =3D is_wow64_process2(GetCurrentProces=
s(), &process_machine, &native_machine);
-        if (is_wow64 && native_ma=
chine =3D=3D IMAGE_FILE_MACHINE_ARM64)
-        {
-            *host_arch =
=3D ARCH_ARM64;
-        }
-    }
-#elif defined(_WIN32)
+#else
     *proce=
ss_arch =3D ARCH_X86;
+#endif
 
-    if (is_wow64_process2)
+    *host_arch=
 =3D ARCH_NATIVE;
+    /* Determine if we're running on a different host-ar=
ch */
+    USHORT process_machine =3D 0;
+    USHORT native_machine =3D 0;
=
+
+    if (!IsWow64Process2(GetCurrentProcess(), &process_machine, &native_=
machine))
     {
-        /* check if we're running on arm64 or amd64 machi=
ne */
-        USHORT process_machine =3D 0;
-        USHORT native_machine=
 =3D 0;
-        BOOL is_wow64 =3D is_wow64_process2(GetCurrentProcess(), &=
process_machine, &native_machine);
-        if (is_wow64)
-        {
-     =
       switch (native_machine)
-            {
-                case IMAGE_F=
ILE_MACHINE_ARM64:
-                    *host_arch =3D ARCH_ARM64;
-       =
             break;
-
-                case IMAGE_FILE_MACHINE_AMD64:
-    =
                *host_arch =3D ARCH_AMD64;
-                    break;
-
- =
               default:
-                    *host_arch =3D ARCH_UNKNOWN;
-=
                    break;
-            }
-        }
+        return;
     =
}
-    else
+
+    switch (native_machine)
     {
-        BOOL w64 =3D FAL=
SE;
-        BOOL is_wow64 =3D IsWow64Process(GetCurrentProcess(), &w64) &&=
 w64;
-        if (is_wow64)
-        {
-            /* we are unable to di=
fferentiate between arm64 and amd64
-             * machines here, so assum=
e we are running on amd64 */
+        case IMAGE_FILE_MACHINE_ARM64:
+     =
       *host_arch =3D ARCH_ARM64;
+            break;
+
+        case IMAGE=
_FILE_MACHINE_AMD64:
             *host_arch =3D ARCH_AMD64;
-        }
+  =
          break;
+
+        case IMAGE_FILE_MACHINE_I386:
+            *hos=
t_arch =3D ARCH_X86;
+            break;
+
+        default:
+            *=
host_arch =3D ARCH_UNKNOWN;
+            break;
     }
-#endif /* _ARM64_ *=
/
+
+    if (*host_arch =3D=3D *process_arch)
+    {
+        *host_arch =
=3D ARCH_NATIVE;
+    }
 }
 
 static void
diff --git a/src/openvpnmsica/CMa=
keLists=2Etxt b/src/openvpnmsica/CMakeLists=2Etxt
index 9126b80=2E=2E06889c=
8 100644
--- a/src/openvpnmsica/CMakeLists=2Etxt
+++ b/src/openvpnmsica/CMa=
keLists=2Etxt
@@ -24,7 +24,7 @@
 target_compile_options(openvpnmsica PRIVAT=
E
     -D_UNICODE
     -UNTDDI_VERSION
-    -D_WIN32_WINNT=3D_WIN32_WINNT_V=
ISTA
+    -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10
     )
 
 if (MSVC)
diff --gi=
t a/src/openvpnmsica/Makefile=2Eam b/src/openvpnmsica/Makefile=2Eam
index 8=
7bf9a7=2E=2E5e7838f 100644
--- a/src/openvpnmsica/Makefile=2Eam
+++ b/src/o=
penvpnmsica/Makefile=2Eam
@@ -34,8 +34,7 @@
 lib_LTLIBRARIES =3D libopenvpn=
msica=2Ela
 libopenvpnmsica_la_CFLAGS =3D \
 	-municode -D_UNICODE \
-	-UNT=
DDI_VERSION -U_WIN32_WINNT \
-	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA \
+	-UNT=
DDI_VERSION -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10 \
 	-Wl,--kill-at
 libopenv=
pnmsica_la_LDFLAGS =3D -ladvapi32 -lole32 -lmsi -lsetupapi -liphlpapi -lshe=
ll32 -lshlwapi -lversion -lnewdev -no-undefined -avoid-version
 endif
diff =
--git a/src/openvpnserv/CMakeLists=2Etxt b/src/openvpnserv/CMakeLists=2Etxt=

index fc15382=2E=2E2cc4a93 100644
--- a/src/openvpnserv/CMakeLists=2Etxt
+=
++ b/src/openvpnserv/CMakeLists=2Etxt
@@ -21,7 +21,7 @@
     target_compile=
_options(${target} PRIVATE
         -D_UNICODE
         -UNTDDI_VERSION
-  =
      -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
+        -D_WIN32_WINNT=3D_WIN32_=
WINNT_WIN10
     )
     target_link_libraries(${target} PRIVATE
         ad=
vapi32=2Elib userenv=2Elib iphlpapi=2Elib fwpuclnt=2Elib rpcrt4=2Elib
diff =
--git a/src/openvpnserv/Makefile=2Eam b/src/openvpnserv/Makefile=2Eam
index=
 ac97eb4=2E=2E447fb10 100644
--- a/src/openvpnserv/Makefile=2Eam
+++ b/src/=
openvpnserv/Makefile=2Eam
@@ -23,8 +23,7 @@
 sbin_PROGRAMS =3D openvpnserv
=
 openvpnserv_CFLAGS =3D \
 	-municode -D_UNICODE \
-	-UNTDDI_VERSION -U_WIN=
32_WINNT \
-	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
+	-UNTDDI_VERSION -D_WIN32=
_WINNT=3D_WIN32_WINNT_WIN10
 openvpnserv_LDADD =3D \
 	-ladvapi32 -luserenv=
 -liphlpapi -lfwpuclnt -lrpcrt4 \
 	-lshlwapi -lnetapi32 -lws2_32 -lntdll -=
lole32 -lpathcch
diff --git a/src/tapctl/CMakeLists=2Etxt b/src/tapctl/CMak=
eLists=2Etxt
index 97702c0=2E=2E94453ed 100644
--- a/src/tapctl/CMakeLists=
=2Etxt
+++ b/src/tapctl/CMakeLists=2Etxt
@@ -21,10 +21,10 @@
 target_compil=
e_options(tapctl PRIVATE
     -D_UNICODE
     -UNTDDI_VERSION
-    -D_WIN32=
_WINNT=3D_WIN32_WINNT_VISTA
+    -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10
     )=

 target_link_libraries(tapctl
-    advapi32=2Elib ole32=2Elib setupapi=2El=
ib)
+    advapi32=2Elib newdev=2Elib ole32=2Elib setupapi=2Elib)
 if (MINGW=
)
     target_compile_options(tapctl PRIVATE -municode)
     target_link_op=
tions(tapctl PRIVATE -municode)
diff --git a/src/tapctl/Makefile=2Eam b/src=
/tapctl/Makefile=2Eam
index 58cd580=2E=2E5d1f851 100644
--- a/src/tapctl/Ma=
kefile=2Eam
+++ b/src/tapctl/Makefile=2Eam
@@ -35,8 +35,7 @@
 sbin_PROGRAMS=
 =3D tapctl
 tapctl_CFLAGS =3D \
 	-municode -D_UNICODE \
-	-UNTDDI_VERSION=
 -U_WIN32_WINNT \
-	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
+	-UNTDDI_VERSION	-=
D_WIN32_WINNT=3D_WIN32_WINNT_WIN10
 tapctl_LDADD =3D -ladvapi32 -lole32 -ls=
etupapi
 endif
 
diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec
index=
 dd22cc5=2E=2Eac1ecd2 100644
--- a/src/tapctl/tap=2Ec
+++ b/src/tapctl/tap=
=2Ec
@@ -50,6 +50,7 @@
     (_countof(L"SYSTEM\\CurrentControlSet\\Control\=
\Network\\") - 1 + 38 + _countof(L"\\") - 1 \
      + 38 + _countof(L"\\Con=
nection"))
 
+#ifndef HAVE_DIINSTALLDEVICE
 /**
  * Dynamically load a libr=
ary and find a function in it
  *
@@ -99,6 +100,7 @@
     }
     return fpt=
r;
 }
+#endif
 
 /**
  * Returns length of string of strings

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df=
92a58bf8a79a
Gerrit-Change-Number: 1955
Gerrit-PatchSet: 5
Gerrit-Owner: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ZZp5/6ucULk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #5</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1955?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Build =
against Windows 10 API and remove some backwards compatility code<br><br>Or=
iginally prompted by some cppcheck complaint about<br>win32_get_arch()=2E L=
ooking at the code I decided to<br>propose removing the various work-around=
s from pre-Win10<br>times=2E Microsoft certainly doesn&#39;t support these<=
br>versions anymore, so let&#39;s also remove that=2E<br><br>Note that this=
 does not remove all instances of GetProcAddress:<br>- One is required due =
to a issue in MinGW toolchain (DiInstallDevice)<br>- One is used to avoid a=
 dependency on WDK headers (RtlGetVersion)<br>- One is required due to usin=
g an undocumented function that is<br>  not available in MinGW (RtlPublishW=
nfStateData)<br><br>Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a<br=
>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-=
by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1955<br>Message-Id: &lt;20261003175718=2E65=
44-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg39673=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>=
M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M src/openvpn/dco_win=2Ec<=
br>M src/openvpn/win32=2Ec<br>M src/openvpnmsica/CMakeLists=2Etxt<br>M src/=
openvpnmsica/Makefile=2Eam<br>M src/openvpnserv/CMakeLists=2Etxt<br>M src/o=
penvpnserv/Makefile=2Eam<br>M src/tapctl/CMakeLists=2Etxt<br>M src/tapctl/M=
akefile=2Eam<br>M src/tapctl/tap=2Ec<br>12 files changed, 56 insertions(+),=
 75 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/55/1955/5</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt</span><br><span>index d553697=2E=2E2d9b546 100644=
</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2E=
txt</span><br><span>@@ -251,6 +251,14 @@</span><br><span> check_symbol_exis=
ts(strsep string=2Eh HAVE_STRSEP)</span><br><span> check_symbol_exists(strt=
ok_r string=2Eh HAVE_STRTOK_R)</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+if (WIN32)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    # Required due to a bug in MinGW where the =2Eh fil=
e is correct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # b=
ut the symbol is missing from newdev=2Edll</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    set(CMAKE_REQUIRED_LIBRARIES newdev=2Elib)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(D=
iInstallDevice &quot;windows=2Eh;newdev=2Eh&quot; HAVE_DIINSTALLDEVICE)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    unset(CMAKE_REQUIRE=
D_LIBRARIES)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif (=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
# Some OS (e=2Eg=2E FreeBSD) need some basic headers to allow</span><br><sp=
an> # including network headers</span><br><span> set(NETEXTRA sys/types=2Eh=
)</span><br><span>@@ -344,7 +352,7 @@</span><br><span>     if (MINGW)</span=
><br><span>         target_compile_definitions(${target} PRIVATE</span><br>=
<span>                 WIN32_LEAN_AND_MEAN</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                NTDDI_VERSION=3DNTDDI_VISTA _WIN32_WIN=
NT=3D_WIN32_WINNT_VISTA</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                NTDDI_VERSION=3DNTDDI_WIN10 _WIN32_WINNT=3D_WIN32_WINNT=
_WIN10</span><br><span>         )</span><br><span>     endif()</span><br><s=
pan> </span><br><span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ec=
make=2Ein</span><br><span>index c6c0a96=2E=2E6c8660c 100644</span><br><span=
>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ei=
n</span><br><span>@@ -330,6 +330,9 @@</span><br><span> /* Define to 1 if yo=
u have the &lt;valgrind/memcheck=2Eh&gt; header file=2E */</span><br><span>=
 #undef HAVE_VALGRIND_MEMCHECK_H</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `DiInstallDev=
ice&#39; function=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#cmakedefine HAVE_DIINSTALLDEVICE</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> /* Availability of different mbed TLS f=
eatures and APIs */</span><br><span> #cmakedefine HAVE_PSA_CRYPTO_H</span><=
br><span> </span><br><span>diff --git a/configure=2Eac b/configure=2Eac</sp=
an><br><span>index 195116f=2E=2E56109af 100644</span><br><span>--- a/config=
ure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -346,7 +34=
6,7 @@</span><br><span> 		AM_CONDITIONAL([ENABLE_DNS_UPDOWN], [false])</spa=
n><br><span> 		AC_SUBST([DNS_UPDOWN_TYPE], [&quot;windows&quot;])</span><br=
><span> 		CPPFLAGS=3D&quot;${CPPFLAGS} -DWIN32_LEAN_AND_MEAN&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-		CPPFLAGS=3D&quot;${CPPFLAGS}=
 -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+		CPPFLAGS=3D&quot;${C=
PPFLAGS} -DNTDDI_VERSION=3DNTDDI_WIN10 -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10&=
quot;</span><br><span> 		WIN32=3Dyes</span><br><span> 		;;</span><br><span>=
 	*-*-dragonfly*)</span><br><span>@@ -1397,4 +1397,4 @@</span><br><span> # =
Put the warning at the end, so it is better visible</span><br><span> if tes=
t &quot;${enable_debug}&quot; =3D &quot;yes&quot;; then</span><br><span>   =
  AC_MSG_WARN([--enable-developer-debug is enabled=2E This should be only u=
sed for test/development builds and not for production usage])</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span>\ No newline at=
 end of file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</spa=
n><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec<=
/span><br><span>index 90cff8c=2E=2Ebd94c1a 100644</span><br><span>--- a/src=
/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span><b=
r><span>@@ -35,6 +35,7 @@</span><br><span> #include &quot;openvpn=2Eh&quot;=
</span><br><span> </span><br><span> #include &lt;bcrypt=2Eh&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;ioapiset=2Eh&gt;</=
span><br><span> #include &lt;winsock2=2Eh&gt;</span><br><span> #include &lt=
;ws2tcpip=2Eh&gt;</span><br><span> </span><br><span>@@ -222,17 +223,6 @@</s=
pan><br><span> dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout,=
 struct signal_info *sig_info)</span><br><span> {</span><br><span>     vola=
tile int *signal_received =3D &amp;sig_info-&gt;signal_received;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* GetOverlappedResultEx is =
available starting from Windows 8 */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    typedef BOOL(WINAPI * get_overlapped_result_ex_t)(HANDLE=
, LPOVERLAPPED, LPDWORD, DWORD, BOOL);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    get_overlapped_result_ex_t get_overlapped_result_ex =
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (get_overl=
apped_result_ex_t)GetProcAddress(GetModuleHandle(&quot;Kernel32=2Edll&quot;=
),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                                &quot;GetOverlappedResultEx&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (get_overlapped_result_ex =3D=3D NULL)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;Failed to load Ge=
tOverlappedResult()&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span>     DWORD timeout_msec =3D timeout * 1000;</span><br><span>     con=
st int poll_interval_ms =3D 50;</span><br><span> </span><br><span>@@ -241,7=
 +231,7 @@</span><br><span>         timeout_msec -=3D poll_interval_ms;</sp=
an><br><span> </span><br><span>         DWORD transferred;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (get_overlapped_result_ex(h=
andle, ov, &amp;transferred, poll_interval_ms, FALSE) !=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (GetOverlappedResultEx=
(handle, ov, &amp;transferred, poll_interval_ms, FALSE) !=3D 0)</span><br><=
span>         {</span><br><span>             /* TCP connection established =
by dco */</span><br><span>             return;</span><br><span>diff --git a=
/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index 82341f=
8=2E=2Efde6412 100644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br=
><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -37,6 +37,7 @@</span>=
<br><span> #include &lt;winsock2=2Eh&gt;</span><br><span> #include &lt;accc=
trl=2Eh&gt;</span><br><span> #include &lt;aclapi=2Eh&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;wow64apiset=2Eh&gt;</span=
><br><span> </span><br><span> #include &quot;buffer=2Eh&quot;</span><br><sp=
an> #include &quot;error=2Eh&quot;</span><br><span>@@ -1334,67 +1335,47 @@<=
/span><br><span> static void</span><br><span> win32_get_arch(arch_t *proces=
s_arch, arch_t *host_arch)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    *process_arch =3D ARCH_UNKNOWN;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    *host_arch =3D ARCH_NATIVE;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    typedef BOOL(WINAPI * is_wow64_process2_t)(H=
ANDLE, USHORT *, USHORT *);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    is_wow64_process2_t is_wow64_process2 =3D</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        (is_wow64_process2_t)GetProcAddress=
(GetModuleHandle(&quot;Kernel32=2Edll&quot;), &quot;IsWow64Process2&quot;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #if=
def _ARM64_</span><br><span>     *process_arch =3D ARCH_ARM64;</span><br><s=
pan> #elif defined(_WIN64)</span><br><span>     *process_arch =3D ARCH_AMD6=
4;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (is_wow64_pr=
ocess2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        /* this could be amd64=
 on arm64 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        U=
SHORT process_machine =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        USHORT native_machine =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        BOOL is_wow64 =3D is_wow64_process2(GetCurren=
tProcess(), &amp;process_machine, &amp;native_machine);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (is_wow64 &amp;&amp; native_ma=
chine =3D=3D IMAGE_FILE_MACHINE_ARM64)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            *host_arch =3D ARCH_ARM64;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif =
defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#els=
e</span><br><span>     *process_arch =3D ARCH_X86;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (is_wow64_process2)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    *host_arch =3D ARCH_NATIVE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Determine if we=
&#39;re running on a different host-arch */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    USHORT process_machine =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    USHORT native_machine =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!IsWow64Process2(GetCurrentProces=
s(), &amp;process_machine, &amp;native_machine))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* check if we&#3=
9;re running on arm64 or amd64 machine */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        USHORT process_machine =3D 0;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        USHORT native_machine =3D 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        BOOL is_wow64 =
=3D is_wow64_process2(GetCurrentProcess(), &amp;process_machine, &amp;nativ=
e_machine);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (is_wow64)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            switch (na=
tive_machine)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
case IMAGE_FILE_MACHINE_ARM64:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    *host_arch =3D ARCH_ARM64;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    break;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                case IMAGE_FILE_MACHINE_AMD64:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    *host_arch =
=3D ARCH_AMD64;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                defaul=
t:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 *host_arch =3D ARCH_UNKNOWN;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    break;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (native=
_machine)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        BOOL w64 =3D FALSE;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        BOOL is_wow64 =3D IsWow64Process(GetCurrentProcess=
(), &amp;w64) &amp;&amp; w64;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (is_wow64)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        /* we are unable to differentiate between arm64 and amd64</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-             * machines here, s=
o assume we are running on amd64 */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        case IMAGE_FILE_MACHINE_ARM64:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            *host_arch =3D ARCH_ARM64;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case IMAGE_FILE_MACHINE_AMD64:</s=
pan><br><span>             *host_arch =3D ARCH_AMD64;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        case IMAGE_FILE_MACHINE_I386:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            *host_arch =3D ARCH_X86;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        default:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            *host_arch =3D ARCH_UNKNOWN;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* _ARM64_ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (*host_arch =3D=3D *process_arc=
h)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        *host_arch =3D ARCH_NAT=
IVE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span> }</span><br><span> </span><br><span> static void</span><br><span>di=
ff --git a/src/openvpnmsica/CMakeLists=2Etxt b/src/openvpnmsica/CMakeLists=
=2Etxt</span><br><span>index 9126b80=2E=2E06889c8 100644</span><br><span>--=
- a/src/openvpnmsica/CMakeLists=2Etxt</span><br><span>+++ b/src/openvpnmsic=
a/CMakeLists=2Etxt</span><br><span>@@ -24,7 +24,7 @@</span><br><span> targe=
t_compile_options(openvpnmsica PRIVATE</span><br><span>     -D_UNICODE</spa=
n><br><span>     -UNTDDI_VERSION</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10</spa=
n><br><span>     )</span><br><span> </span><br><span> if (MSVC)</span><br><=
span>diff --git a/src/openvpnmsica/Makefile=2Eam b/src/openvpnmsica/Makefil=
e=2Eam</span><br><span>index 87bf9a7=2E=2E5e7838f 100644</span><br><span>--=
- a/src/openvpnmsica/Makefile=2Eam</span><br><span>+++ b/src/openvpnmsica/M=
akefile=2Eam</span><br><span>@@ -34,8 +34,7 @@</span><br><span> lib_LTLIBRA=
RIES =3D libopenvpnmsica=2Ela</span><br><span> libopenvpnmsica_la_CFLAGS =
=3D \</span><br><span> 	-municode -D_UNICODE \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	-UNTDDI_VERSION -U_WIN32_WINNT \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-UNTDDI_VERSION -D=
_WIN32_WINNT=3D_WIN32_WINNT_WIN10 \</span><br><span> 	-Wl,--kill-at</span><=
br><span> libopenvpnmsica_la_LDFLAGS =3D -ladvapi32 -lole32 -lmsi -lsetupap=
i -liphlpapi -lshell32 -lshlwapi -lversion -lnewdev -no-undefined -avoid-ve=
rsion</span><br><span> endif</span><br><span>diff --git a/src/openvpnserv/C=
MakeLists=2Etxt b/src/openvpnserv/CMakeLists=2Etxt</span><br><span>index fc=
15382=2E=2E2cc4a93 100644</span><br><span>--- a/src/openvpnserv/CMakeLists=
=2Etxt</span><br><span>+++ b/src/openvpnserv/CMakeLists=2Etxt</span><br><sp=
an>@@ -21,7 +21,7 @@</span><br><span>     target_compile_options(${target} =
PRIVATE</span><br><span>         -D_UNICODE</span><br><span>         -UNTDD=
I_VERSION</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        -D_W=
IN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10</span><br><span>   =
  )</span><br><span>     target_link_libraries(${target} PRIVATE</span><br>=
<span>         advapi32=2Elib userenv=2Elib iphlpapi=2Elib fwpuclnt=2Elib r=
pcrt4=2Elib</span><br><span>diff --git a/src/openvpnserv/Makefile=2Eam b/sr=
c/openvpnserv/Makefile=2Eam</span><br><span>index ac97eb4=2E=2E447fb10 1006=
44</span><br><span>--- a/src/openvpnserv/Makefile=2Eam</span><br><span>+++ =
b/src/openvpnserv/Makefile=2Eam</span><br><span>@@ -23,8 +23,7 @@</span><br=
><span> sbin_PROGRAMS =3D openvpnserv</span><br><span> openvpnserv_CFLAGS =
=3D \</span><br><span> 	-municode -D_UNICODE \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	-UNTDDI_VERSION -U_WIN32_WINNT \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-UNTDDI_VERSION -D_W=
IN32_WINNT=3D_WIN32_WINNT_WIN10</span><br><span> openvpnserv_LDADD =3D \</s=
pan><br><span> 	-ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \</span=
><br><span> 	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32 -lpathcch</span>=
<br><span>diff --git a/src/tapctl/CMakeLists=2Etxt b/src/tapctl/CMakeLists=
=2Etxt</span><br><span>index 97702c0=2E=2E94453ed 100644</span><br><span>--=
- a/src/tapctl/CMakeLists=2Etxt</span><br><span>+++ b/src/tapctl/CMakeLists=
=2Etxt</span><br><span>@@ -21,10 +21,10 @@</span><br><span> target_compile_=
options(tapctl PRIVATE</span><br><span>     -D_UNICODE</span><br><span>    =
 -UNTDDI_VERSION</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    -=
D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10</span><br><span>    =
 )</span><br><span> target_link_libraries(tapctl</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    advapi32=2Elib ole32=2Elib setupapi=2Elib)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    advapi32=2Elib ne=
wdev=2Elib ole32=2Elib setupapi=2Elib)</span><br><span> if (MINGW)</span><b=
r><span>     target_compile_options(tapctl PRIVATE -municode)</span><br><sp=
an>     target_link_options(tapctl PRIVATE -municode)</span><br><span>diff =
--git a/src/tapctl/Makefile=2Eam b/src/tapctl/Makefile=2Eam</span><br><span=
>index 58cd580=2E=2E5d1f851 100644</span><br><span>--- a/src/tapctl/Makefil=
e=2Eam</span><br><span>+++ b/src/tapctl/Makefile=2Eam</span><br><span>@@ -3=
5,8 +35,7 @@</span><br><span> sbin_PROGRAMS =3D tapctl</span><br><span> tap=
ctl_CFLAGS =3D \</span><br><span> 	-municode -D_UNICODE \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	-UNTDDI_VERSION -U_WIN32_WINNT \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	-D_WIN32_WINNT=3D_WIN32_WI=
NNT_VISTA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-UNTDDI_V=
ERSION	-D_WIN32_WINNT=3D_WIN32_WINNT_WIN10</span><br><span> tapctl_LDADD =
=3D -ladvapi32 -lole32 -lsetupapi</span><br><span> endif</span><br><span> <=
/span><br><span>diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec</span>=
<br><span>index dd22cc5=2E=2Eac1ecd2 100644</span><br><span>--- a/src/tapct=
l/tap=2Ec</span><br><span>+++ b/src/tapctl/tap=2Ec</span><br><span>@@ -50,6=
 +50,7 @@</span><br><span>     (_countof(L&quot;SYSTEM\\CurrentControlSet\\=
Control\\Network\\&quot;) - 1 + 38 + _countof(L&quot;\\&quot;) - 1 \</span>=
<br><span>      + 38 + _countof(L&quot;\\Connection&quot;))</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef HAVE_DIIN=
STALLDEVICE</span><br><span> /**</span><br><span>  * Dynamically load a lib=
rary and find a function in it</span><br><span>  *</span><br><span>@@ -99,6=
 +100,7 @@</span><br><span>     }</span><br><span>     return fptr;</span><=
br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span> </span><br><span> /**</span><br><span>  * Returns length of=
 string of strings</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">change 1955</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I44d7171c7e4f=
8497bf8b902380df92a58bf8a79a </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1955 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--ZZp5/6ucULk=--


--===============6175977793418847895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6175977793418847895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6175977793418847895==--

