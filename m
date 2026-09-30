Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9422CA5FCB
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EUNM+bZWyoMVmE6E/vwzu3ljqb0tMmVamFdhF8PoWwU=; b=Lky/jR4ZhtZ/ASRnGTnCX1tiM8
	E1RfynAZtdwdhLbrd6Wl1QArLGSL/NTtkN7gFv8DfcjOSwqx/gM4oQvIXwGMWCBACrNGU4bPpsUcZ
	OQJcJctsHK+T7LlM5COU/zGyFT7dUVFon4YIE8LbuvyVOniLy6FnSAxf8Ud6q1KizEP0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBvsF-0005Gk-1y;
	Wed, 30 Sep 2026 15:05:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBvrl-0005F7-Op
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 15:05:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=c9K5sG58Dpv/bedpd8aYqhWH2c5xvKctqzC0AzgpUUM=; b=iM5hTl0iAZdEVMvkC7aEUHVIGs
 tb1rbOIUfnPj4VJcY9e/MKU0EV8AFRTaL69G3v63gMxDKdhA2ueYQPuOHXXoWO82cQhqDmIgZlEak
 6+FQecZAlW1su/Ga+u0GgbADFycvUXA2W9laQlhzvV6tSUXKRbTB0fu97enw2t5RWpLY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=c9K5sG58Dpv/bedpd8aYqhWH2c5xvKctqzC0AzgpUUM=; b=Z
 nE8b0Oy8/q5qUakyWsZ/vNtzcgiJCg2Q4kDGJr9Gl+jy95h8EPifuml3WF+ZyyKWMoKSZFcRHyTu8
 w5K3tMBNswSw3Dzc9FjtZRJhziUooIBxXNh4Qv1lmBrfbokak3mhFgOzOR2bHTzWnKYAmoUqIJwNG
 wwJ07oA7YKUhkiKk=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBvrj-0007qE-3I for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 15:05:06 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so41072405e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790780696; x=1791385496; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c9K5sG58Dpv/bedpd8aYqhWH2c5xvKctqzC0AzgpUUM=;
 b=G4vDOJneZ7efJMpQjWNHaXhxbtjQtHv6nqtwNyM9DA/EcqpJPeeCFdyUKn3a56ghCB
 CQbHeQdJk4I6rnhdyOscii3HJdoE4iVGSd6sUkOBcTemFBg+/7myJSLvP5ju9k/C35R7
 tiCdoSd7d3pxTTabuzh2K10S1n5P1fYUn8u1U90KUcIKrKXAwKEhf+GAZzSD4D4Qmk4+
 IltYX9L6A8re4r9xdhpo3Oapx0JxcV9GfOKz7qkEBla8QoCSRcqDs9fA/3tYpY1nFTmc
 mIU67b+55/GuntKy+keKrvwoKEI7UfP1hpxRl5adB79k0vV1VvD70MfZ2uTowieRJC9m
 n8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790780696; x=1791385496;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=c9K5sG58Dpv/bedpd8aYqhWH2c5xvKctqzC0AzgpUUM=;
 b=tiNDvfff3p8cG4D3MRE1yIWXIxUd/BqDgUTPhRSeUVTJpFAs0jwKoasSlmsxMv0SBh
 Y7j+u2kuHDGaY4rjH8KYid0E2fAYIXbT9mMU60Zr2gMJvEVfwhPkVjej4Eitpe98Qrxy
 iCoYwYXkk2bsVjj8JwSTdDteggrJwN96FFPO8oV98zE4QTy655oMv621LqnUxCKbWkgv
 dthVEyC6O8My3yhVGBfQQOZVR6pCY6lNn5im6rogZw8OKfbNQpUnYXxMWjJiih9w97BF
 fYFPRhKPrdWTTd2m8A9U402AGIRACRIpFiGnnFpoOMKT2+rlX5zVZrJEgmN8XksSefOY
 dlJA==
X-Gm-Message-State: AFuF++nBrHhmyNUFXRmr2f3kmlifwIEixzTMecXz2KUuA9Hca0CRoLX1
 VPtNUBCTxUeWPtLQuqFLXuFXRnuzHW3Lv+BGHvMPGhnzO1vfkV88H5N4vmDEVVFTothar81Nbwy
 Kzzug9mr1o32i2+WiPZLhu/HmjoCtH87IhQNgLLX0YTdXLjZF8IjPbP5zYvgsYiCtqCh7
X-Gm-Gg: AYBFou356patY7nqTLqifczWJD6t3yvhxpQaA5SN0o1zhY3BFH/cNIwTHL3Ax+bRlV9
 lW1hi3A7mx2V/ZtIyxgC4AD+BeWajVzSS7ThfFisXREXoLk6lAZxUmnmRzGKFU6hK2L6O/hemd5
 TiYWv47oGdr63SP6+mopItizPunriE3Zbe9Xgkvf+ncKnqPIVdOQZy6zGzi3Ww4uCWSF+lCv7Pc
 zNdl1CiQR8BLTHVwAm229o3fuoPToNTMPb6o4OHQzXy3vgQlYnYtDRHxFFE4GR09VbYtkzmnQ4b
 bg35768kbTH7Ys7uRHowjoHO2djn/h8TgaALj+zP98Yv7z1HxVBxTx9NI2wimbsWB0SKBOe5QYL
 /Z4GWdMD0F9QCFS9smMOzvIFz1GU1Nq8y5sNm8JYnk0J2gwswfuA38L5lmYDB7raC+rThLM7NQf
 /qTJgZv/lpZ4WB8lDWiid9a1BxpVMZFYza3337XtkWIxgsL5DOqv4LXrqSdelfUzHZV+X1noE0d
 igetTc8QAgjL5CSQeDRW0I3noJ8QQfGSjaLntX9hdmqPlwaZrW8WsHXDPrTWvLyMN7bX86R0vUO
 JIkd6Ii+qRgmOmmVhAZKnw/wYE2OV3W7uwTtxP58BN3xLb8dolKo4L0R+Q7u
X-Received: by 2002:a05:600c:83c3:b0:49c:edd8:ba35 with SMTP id
 5b1f17b1804b1-4a01aff3c4emr30916845e9.6.1790780696020; 
 Wed, 30 Sep 2026 08:04:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01e65a4c9sm5440695e9.9.2026.09.30.08.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:04:54 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 15:04:50 +0000
To: razvanc <razvanc@mailbox.org>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
X-Gerrit-Change-Number: 1955
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1955?usp=email>
X-Gerrit-Commit: 2bbb6f5c84bbb83c2bfb791879f7f6193638cd29
In-Reply-To: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNTk5NjY4MDAwLkk0NGQ3MTcxYzdlNGY4NDk3YmY4YjkwMjM4MGRmOTJhNThiZjhhNzlhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <49941578a49e7711dd93e330ff97591e228fc758-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBvrj-0007qE-3I
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4563391134962086952=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4563391134962086952==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3+SXWja1jmM="; charset=UTF-8

--3+SXWja1jmM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

Hello plaistho=
s, razvanc, 

I'd like you to reexamine a change=2E Please visit

    http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail

to look at the new p=
atch set (#4)=2E


Change subject: Build against Windows 10 API and remove =
some backwards compatility code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Build against Windows 10 API and remove some backwards =
compatility code

Originally prompted by some cppcheck complaint about
win3=
2_get_arch()=2E Looking at the code I decided to
propose removing the vario=
us work-arounds from pre-Win10
times=2E Microsoft certainly doesn't support=
 these
versions anymore, so let's also remove that=2E

Note that this does =
not remove all instances of GetProcAddress:
- One is required due to a issu=
e in MinGW toolchain (DiInstallDevice)
- One is used to avoid a dependency =
on WDK headers (RtlGetVersion)
- One is required due to using an undocument=
ed function that is
  not available in MinGW (RtlPublishWnfStateData)

Chan=
ge-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
Signed-off-by: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
---
M CMakeLists=2Etxt
M config=2Eh=2Ecmak=
e=2Ein
M configure=2Eac
M src/openvpn/dco_win=2Ec
M src/openvpn/win32=2Ec
M=
 src/openvpnmsica/CMakeLists=2Etxt
M src/openvpnmsica/Makefile=2Eam
M src/o=
penvpnserv/CMakeLists=2Etxt
M src/openvpnserv/Makefile=2Eam
M src/tapctl/CM=
akeLists=2Etxt
M src/tapctl/Makefile=2Eam
M src/tapctl/tap=2Ec
12 files cha=
nged, 56 insertions(+), 75 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/55/1955/4

diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt
index d553697=2E=2E2d9b546 100644
--- a/CMakeLists=2Etxt=

+++ b/CMakeLists=2Etxt
@@ -251,6 +251,14 @@
 check_symbol_exists(strsep st=
ring=2Eh HAVE_STRSEP)
 check_symbol_exists(strtok_r string=2Eh HAVE_STRTOK_=
R)
 
+if (WIN32)
+    # Required due to a bug in MinGW where the =2Eh file =
is correct
+    # but the symbol is missing from newdev=2Edll
+    set(CMAK=
E_REQUIRED_LIBRARIES newdev=2Elib)
+    check_symbol_exists(DiInstallDevice=
 "windows=2Eh;newdev=2Eh" HAVE_DIINSTALLDEVICE)
+    unset(CMAKE_REQUIRED_L=
IBRARIES)
+endif ()
+
 # Some OS (e=2Eg=2E FreeBSD) need some basic headers=
 to allow
 # including network headers
 set(NETEXTRA sys/types=2Eh)
@@ -344=
,7 +352,7 @@
     if (MINGW)
         target_compile_definitions(${target} =
PRIVATE
                 WIN32_LEAN_AND_MEAN
-                NTDDI_VERSION=
=3DNTDDI_VISTA _WIN32_WINNT=3D_WIN32_WINNT_VISTA
+                NTDDI_VER=
SION=3DNTDDI_WIN10 _WIN32_WINNT=3D_WIN32_WINNT_WIN10
         )
     endif(=
)
 
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index c6=
c0a96=2E=2E6c8660c 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2E=
cmake=2Ein
@@ -330,6 +330,9 @@
 /* Define to 1 if you have the <valgrind/me=
mcheck=2Eh> header file=2E */
 #undef HAVE_VALGRIND_MEMCHECK_H
 
+/* Define=
 to 1 if you have the `DiInstallDevice' function=2E */
+#cmakedefine HAVE_D=
IINSTALLDEVICE
+
 /* Availability of different mbed TLS features and APIs *=
/
 #cmakedefine HAVE_PSA_CRYPTO_H
 
diff --git a/configure=2Eac b/configure=
=2Eac
index 1fa0e63=2E=2Ea06c4c9 100644
--- a/configure=2Eac
+++ b/configur=
e=2Eac
@@ -346,7 +346,7 @@
 		AM_CONDITIONAL([ENABLE_DNS_UPDOWN], [false])
=
 		AC_SUBST([DNS_UPDOWN_TYPE], ["windows"])
 		CPPFLAGS=3D"${CPPFLAGS} -DWI=
N32_LEAN_AND_MEAN"
-		CPPFLAGS=3D"${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_VISTA=
 -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA"
+		CPPFLAGS=3D"${CPPFLAGS} -DNTDDI_VE=
RSION=3DNTDDI_WIN10 -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10"
 		WIN32=3Dyes
 		=
;;
 	*-*-dragonfly*)
@@ -1397,4 +1397,4 @@
 # Put the warning at the end, s=
o it is better visible
 if test "${enable_debug}" =3D "yes"; then
     AC_M=
SG_WARN([--enable-developer-debug is enabled=2E This should be only used fo=
r test/development builds and not for production usage])
-fi
\ No newline a=
t end of file
+fi
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_wi=
n=2Ec
index 90cff8c=2E=2Ebd94c1a 100644
--- a/src/openvpn/dco_win=2Ec
+++ b=
/src/openvpn/dco_win=2Ec
@@ -35,6 +35,7 @@
 #include "openvpn=2Eh"
 
 #incl=
ude <bcrypt=2Eh>
+#include <ioapiset=2Eh>
 #include <winsock2=2Eh>
 #includ=
e <ws2tcpip=2Eh>
 
@@ -222,17 +223,6 @@
 dco_connect_wait(HANDLE handle, OV=
ERLAPPED *ov, int timeout, struct signal_info *sig_info)
 {
     volatile i=
nt *signal_received =3D &sig_info->signal_received;
-    /* GetOverlappedRe=
sultEx is available starting from Windows 8 */
-    typedef BOOL(WINAPI * g=
et_overlapped_result_ex_t)(HANDLE, LPOVERLAPPED, LPDWORD, DWORD, BOOL);
-  =
  get_overlapped_result_ex_t get_overlapped_result_ex =3D
-        (get_ove=
rlapped_result_ex_t)GetProcAddress(GetModuleHandle("Kernel32=2Edll"),
-    =
                                               "GetOverlappedResultEx");
-
=
-    if (get_overlapped_result_ex =3D=3D NULL)
-    {
-        msg(M_ERR, "=
Failed to load GetOverlappedResult()");
-    }
-
     DWORD timeout_msec =
=3D timeout * 1000;
     const int poll_interval_ms =3D 50;
 
@@ -241,7 +23=
1,7 @@
         timeout_msec -=3D poll_interval_ms;
 
         DWORD transf=
erred;
-        if (get_overlapped_result_ex(handle, ov, &transferred, poll=
_interval_ms, FALSE) !=3D 0)
+        if (GetOverlappedResultEx(handle, ov,=
 &transferred, poll_interval_ms, FALSE) !=3D 0)
         {
             /* =
TCP connection established by dco */
             return;
diff --git a/src/=
openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index 618772d=2E=2E4c511a9 100644=

--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -37,6 +37,7 @@
=
 #include <winsock2=2Eh>
 #include <accctrl=2Eh>
 #include <aclapi=2Eh>
+#i=
nclude <wow64apiset=2Eh>
 
 #include "buffer=2Eh"
 #include "error=2Eh"
@@ =
-1333,67 +1334,47 @@
 static void
 win32_get_arch(arch_t *process_arch, arc=
h_t *host_arch)
 {
-    *process_arch =3D ARCH_UNKNOWN;
-    *host_arch =3D=
 ARCH_NATIVE;
-
-    typedef BOOL(WINAPI * is_wow64_process2_t)(HANDLE, USH=
ORT *, USHORT *);
-    is_wow64_process2_t is_wow64_process2 =3D
-        (=
is_wow64_process2_t)GetProcAddress(GetModuleHandle("Kernel32=2Edll"), "IsWo=
w64Process2");
-
 #ifdef _ARM64_
     *process_arch =3D ARCH_ARM64;
 #elif =
defined(_WIN64)
     *process_arch =3D ARCH_AMD64;
-    if (is_wow64_proces=
s2)
-    {
-        /* this could be amd64 on arm64 */
-        USHORT proc=
ess_machine =3D 0;
-        USHORT native_machine =3D 0;
-        BOOL is_w=
ow64 =3D is_wow64_process2(GetCurrentProcess(), &process_machine, &native_m=
achine);
-        if (is_wow64 && native_machine =3D=3D IMAGE_FILE_MACHINE_=
ARM64)
-        {
-            *host_arch =3D ARCH_ARM64;
-        }
-    }=

-#elif defined(_WIN32)
+#else
     *process_arch =3D ARCH_X86;
+#endif
 
-=
    if (is_wow64_process2)
+    *host_arch =3D ARCH_NATIVE;
+    /* Determi=
ne if we're running on a different host-arch */
+    USHORT process_machine=
 =3D 0;
+    USHORT native_machine =3D 0;
+
+    if (!IsWow64Process2(GetCu=
rrentProcess(), &process_machine, &native_machine))
     {
-        /* chec=
k if we're running on arm64 or amd64 machine */
-        USHORT process_mac=
hine =3D 0;
-        USHORT native_machine =3D 0;
-        BOOL is_wow64 =
=3D is_wow64_process2(GetCurrentProcess(), &process_machine, &native_machin=
e);
-        if (is_wow64)
-        {
-            switch (native_machine)
=
-            {
-                case IMAGE_FILE_MACHINE_ARM64:
-           =
         *host_arch =3D ARCH_ARM64;
-                    break;
-
-        =
        case IMAGE_FILE_MACHINE_AMD64:
-                    *host_arch =3D =
ARCH_AMD64;
-                    break;
-
-                default:
-      =
              *host_arch =3D ARCH_UNKNOWN;
-                    break;
-   =
         }
-        }
+        return;
     }
-    else
+
+    switch (nati=
ve_machine)
     {
-        BOOL w64 =3D FALSE;
-        BOOL is_wow64 =3D =
IsWow64Process(GetCurrentProcess(), &w64) && w64;
-        if (is_wow64)
- =
       {
-            /* we are unable to differentiate between arm64 and a=
md64
-             * machines here, so assume we are running on amd64 */
+ =
       case IMAGE_FILE_MACHINE_ARM64:
+            *host_arch =3D ARCH_ARM6=
4;
+            break;
+
+        case IMAGE_FILE_MACHINE_AMD64:
          =
   *host_arch =3D ARCH_AMD64;
-        }
+            break;
+
+        cas=
e IMAGE_FILE_MACHINE_I386:
+            *host_arch =3D ARCH_X86;
+         =
   break;
+
+        default:
+            *host_arch =3D ARCH_UNKNOWN;
+  =
          break;
     }
-#endif /* _ARM64_ */
+
+    if (*host_arch =3D=3D =
*process_arch)
+    {
+        *host_arch =3D ARCH_NATIVE;
+    }
 }
 
 sta=
tic void
diff --git a/src/openvpnmsica/CMakeLists=2Etxt b/src/openvpnmsica/=
CMakeLists=2Etxt
index 9126b80=2E=2E06889c8 100644
--- a/src/openvpnmsica/C=
MakeLists=2Etxt
+++ b/src/openvpnmsica/CMakeLists=2Etxt
@@ -24,7 +24,7 @@
 =
target_compile_options(openvpnmsica PRIVATE
     -D_UNICODE
     -UNTDDI_VE=
RSION
-    -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
+    -D_WIN32_WINNT=3D_WIN32=
_WINNT_WIN10
     )
 
 if (MSVC)
diff --git a/src/openvpnmsica/Makefile=2Ea=
m b/src/openvpnmsica/Makefile=2Eam
index 87bf9a7=2E=2E5e7838f 100644
--- a/=
src/openvpnmsica/Makefile=2Eam
+++ b/src/openvpnmsica/Makefile=2Eam
@@ -34,=
8 +34,7 @@
 lib_LTLIBRARIES =3D libopenvpnmsica=2Ela
 libopenvpnmsica_la_CF=
LAGS =3D \
 	-municode -D_UNICODE \
-	-UNTDDI_VERSION -U_WIN32_WINNT \
-	-D=
_WIN32_WINNT=3D_WIN32_WINNT_VISTA \
+	-UNTDDI_VERSION -D_WIN32_WINNT=3D_WIN=
32_WINNT_WIN10 \
 	-Wl,--kill-at
 libopenvpnmsica_la_LDFLAGS =3D -ladvapi32=
 -lole32 -lmsi -lsetupapi -liphlpapi -lshell32 -lshlwapi -lversion -lnewdev=
 -no-undefined -avoid-version
 endif
diff --git a/src/openvpnserv/CMakeList=
s=2Etxt b/src/openvpnserv/CMakeLists=2Etxt
index fc15382=2E=2E2cc4a93 10064=
4
--- a/src/openvpnserv/CMakeLists=2Etxt
+++ b/src/openvpnserv/CMakeLists=
=2Etxt
@@ -21,7 +21,7 @@
     target_compile_options(${target} PRIVATE
    =
     -D_UNICODE
         -UNTDDI_VERSION
-        -D_WIN32_WINNT=3D_WIN32_W=
INNT_VISTA
+        -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10
     )
     target_=
link_libraries(${target} PRIVATE
         advapi32=2Elib userenv=2Elib iphl=
papi=2Elib fwpuclnt=2Elib rpcrt4=2Elib
diff --git a/src/openvpnserv/Makefil=
e=2Eam b/src/openvpnserv/Makefile=2Eam
index ac97eb4=2E=2E447fb10 100644
--=
- a/src/openvpnserv/Makefile=2Eam
+++ b/src/openvpnserv/Makefile=2Eam
@@ -2=
3,8 +23,7 @@
 sbin_PROGRAMS =3D openvpnserv
 openvpnserv_CFLAGS =3D \
 	-mu=
nicode -D_UNICODE \
-	-UNTDDI_VERSION -U_WIN32_WINNT \
-	-D_WIN32_WINNT=3D_=
WIN32_WINNT_VISTA
+	-UNTDDI_VERSION -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10
 op=
envpnserv_LDADD =3D \
 	-ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4=
 \
 	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32 -lpathcch
diff --git a/s=
rc/tapctl/CMakeLists=2Etxt b/src/tapctl/CMakeLists=2Etxt
index 97702c0=2E=
=2E94453ed 100644
--- a/src/tapctl/CMakeLists=2Etxt
+++ b/src/tapctl/CMakeL=
ists=2Etxt
@@ -21,10 +21,10 @@
 target_compile_options(tapctl PRIVATE
     =
-D_UNICODE
     -UNTDDI_VERSION
-    -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
+ =
   -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10
     )
 target_link_libraries(tapctl=

-    advapi32=2Elib ole32=2Elib setupapi=2Elib)
+    advapi32=2Elib newdev=
=2Elib ole32=2Elib setupapi=2Elib)
 if (MINGW)
     target_compile_options(=
tapctl PRIVATE -municode)
     target_link_options(tapctl PRIVATE -municode=
)
diff --git a/src/tapctl/Makefile=2Eam b/src/tapctl/Makefile=2Eam
index 58=
cd580=2E=2E5d1f851 100644
--- a/src/tapctl/Makefile=2Eam
+++ b/src/tapctl/M=
akefile=2Eam
@@ -35,8 +35,7 @@
 sbin_PROGRAMS =3D tapctl
 tapctl_CFLAGS =3D=
 \
 	-municode -D_UNICODE \
-	-UNTDDI_VERSION -U_WIN32_WINNT \
-	-D_WIN32_W=
INNT=3D_WIN32_WINNT_VISTA
+	-UNTDDI_VERSION	-D_WIN32_WINNT=3D_WIN32_WINNT_W=
IN10
 tapctl_LDADD =3D -ladvapi32 -lole32 -lsetupapi
 endif
 
diff --git a/=
src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec
index dd22cc5=2E=2Eac1ecd2 100644
-=
-- a/src/tapctl/tap=2Ec
+++ b/src/tapctl/tap=2Ec
@@ -50,6 +50,7 @@
     (_c=
ountof(L"SYSTEM\\CurrentControlSet\\Control\\Network\\") - 1 + 38 + _counto=
f(L"\\") - 1 \
      + 38 + _countof(L"\\Connection"))
 
+#ifndef HAVE_DIIN=
STALLDEVICE
 /**
  * Dynamically load a library and find a function in it
 =
 *
@@ -99,6 +100,7 @@
     }
     return fptr;
 }
+#endif
 
 /**
  * Return=
s length of string of strings

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1955?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
Gerrit-Change-Numb=
er: 1955
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: razvanc <razvanc@mailbox=2E=
org>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--3+SXWja1jmM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>flichtenheld <strong>up=
loaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">Build against Windows 10 API and remove some backwards compatility c=
ode<br><br>Originally prompted by some cppcheck complaint about<br>win32_ge=
t_arch()=2E Looking at the code I decided to<br>propose removing the variou=
s work-arounds from pre-Win10<br>times=2E Microsoft certainly doesn&#39;t s=
upport these<br>versions anymore, so let&#39;s also remove that=2E<br><br>N=
ote that this does not remove all instances of GetProcAddress:<br>- One is =
required due to a issue in MinGW toolchain (DiInstallDevice)<br>- One is us=
ed to avoid a dependency on WDK headers (RtlGetVersion)<br>- One is require=
d due to using an undocumented function that is<br>  not available in MinGW=
 (RtlPublishWnfStateData)<br><br>Change-Id: I44d7171c7e4f8497bf8b902380df92=
a58bf8a79a<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&=
gt;<br>---<br>M CMakeLists=2Etxt<br>M config=2Eh=2Ecmake=2Ein<br>M configur=
e=2Eac<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/win32=2Ec<br>M src/ope=
nvpnmsica/CMakeLists=2Etxt<br>M src/openvpnmsica/Makefile=2Eam<br>M src/ope=
nvpnserv/CMakeLists=2Etxt<br>M src/openvpnserv/Makefile=2Eam<br>M src/tapct=
l/CMakeLists=2Etxt<br>M src/tapctl/Makefile=2Eam<br>M src/tapctl/tap=2Ec<br=
>12 files changed, 56 insertions(+), 75 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/19=
55/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><sp=
an>index d553697=2E=2E2d9b546 100644</span><br><span>--- a/CMakeLists=2Etxt=
</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -251,6 +251,14 @=
@</span><br><span> check_symbol_exists(strsep string=2Eh HAVE_STRSEP)</span=
><br><span> check_symbol_exists(strtok_r string=2Eh HAVE_STRTOK_R)</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (WIN32)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Required due =
to a bug in MinGW where the =2Eh file is correct</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    # but the symbol is missing from newdev=2E=
dll</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(CMAKE_RE=
QUIRED_LIBRARIES newdev=2Elib)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    check_symbol_exists(DiInstallDevice &quot;windows=2Eh;newdev=
=2Eh&quot; HAVE_DIINSTALLDEVICE)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    unset(CMAKE_REQUIRED_LIBRARIES)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> # Some OS (e=2Eg=2E FreeBSD) need some =
basic headers to allow</span><br><span> # including network headers</span><=
br><span> set(NETEXTRA sys/types=2Eh)</span><br><span>@@ -344,7 +352,7 @@</=
span><br><span>     if (MINGW)</span><br><span>         target_compile_defi=
nitions(${target} PRIVATE</span><br><span>                 WIN32_LEAN_AND_M=
EAN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                NT=
DDI_VERSION=3DNTDDI_VISTA _WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                NTDDI_VERSION=3DNTD=
DI_WIN10 _WIN32_WINNT=3D_WIN32_WINNT_WIN10</span><br><span>         )</span=
><br><span>     endif()</span><br><span> </span><br><span>diff --git a/conf=
ig=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index c6c0a96=
=2E=2E6c8660c 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><b=
r><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -330,6 +330,9 @@</=
span><br><span> /* Define to 1 if you have the &lt;valgrind/memcheck=2Eh&gt=
; header file=2E */</span><br><span> #undef HAVE_VALGRIND_MEMCHECK_H</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Defin=
e to 1 if you have the `DiInstallDevice&#39; function=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_DIINSTALLDEVICE</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* =
Availability of different mbed TLS features and APIs */</span><br><span> #c=
makedefine HAVE_PSA_CRYPTO_H</span><br><span> </span><br><span>diff --git a=
/configure=2Eac b/configure=2Eac</span><br><span>index 1fa0e63=2E=2Ea06c4c9=
 100644</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/configur=
e=2Eac</span><br><span>@@ -346,7 +346,7 @@</span><br><span> 		AM_CONDITIONA=
L([ENABLE_DNS_UPDOWN], [false])</span><br><span> 		AC_SUBST([DNS_UPDOWN_TYP=
E], [&quot;windows&quot;])</span><br><span> 		CPPFLAGS=3D&quot;${CPPFLAGS} =
-DWIN32_LEAN_AND_MEAN&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-		CPPFLAGS=3D&quot;${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32=
_WINNT=3D_WIN32_WINNT_VISTA&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+		CPPFLAGS=3D&quot;${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_WIN10 =
-D_WIN32_WINNT=3D_WIN32_WINNT_WIN10&quot;</span><br><span> 		WIN32=3Dyes</s=
pan><br><span> 		;;</span><br><span> 	*-*-dragonfly*)</span><br><span>@@ -1=
397,4 +1397,4 @@</span><br><span> # Put the warning at the end, so it is be=
tter visible</span><br><span> if test &quot;${enable_debug}&quot; =3D &quot=
;yes&quot;; then</span><br><span>     AC_MSG_WARN([--enable-developer-debug=
 is enabled=2E This should be only used for test/development builds and not=
 for production usage])</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-fi</span><br><span>\ No newline at end of file</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+fi</span><br><span>diff --git a/src/openvpn/dc=
o_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index 90cff8c=2E=2Ebd94=
c1a 100644</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span>++=
+ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><sp=
an> #include &quot;openvpn=2Eh&quot;</span><br><span> </span><br><span> #in=
clude &lt;bcrypt=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;ioapiset=2Eh&gt;</span><br><span> #include &lt;winsock2=
=2Eh&gt;</span><br><span> #include &lt;ws2tcpip=2Eh&gt;</span><br><span> </=
span><br><span>@@ -222,17 +223,6 @@</span><br><span> dco_connect_wait(HANDL=
E handle, OVERLAPPED *ov, int timeout, struct signal_info *sig_info)</span>=
<br><span> {</span><br><span>     volatile int *signal_received =3D &amp;si=
g_info-&gt;signal_received;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* GetOverlappedResultEx is available starting from Windows 8 */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    typedef BOOL(WINAP=
I * get_overlapped_result_ex_t)(HANDLE, LPOVERLAPPED, LPDWORD, DWORD, BOOL)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    get_overlapped_r=
esult_ex_t get_overlapped_result_ex =3D</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        (get_overlapped_result_ex_t)GetProcAddress(GetMod=
uleHandle(&quot;Kernel32=2Edll&quot;),</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                                   &quot;G=
etOverlappedResultEx&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (get_ov=
erlapped_result_ex =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  msg(M_ERR, &quot;Failed to load GetOverlappedResult()&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     DWORD timeout_msec =3D time=
out * 1000;</span><br><span>     const int poll_interval_ms =3D 50;</span><=
br><span> </span><br><span>@@ -241,7 +231,7 @@</span><br><span>         tim=
eout_msec -=3D poll_interval_ms;</span><br><span> </span><br><span>        =
 DWORD transferred;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (get_overlapped_result_ex(handle, ov, &amp;transferred, poll_inter=
val_ms, FALSE) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (GetOverlappedResultEx(handle, ov, &amp;transferred, poll_int=
erval_ms, FALSE) !=3D 0)</span><br><span>         {</span><br><span>       =
      /* TCP connection established by dco */</span><br><span>             =
return;</span><br><span>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/wi=
n32=2Ec</span><br><span>index 618772d=2E=2E4c511a9 100644</span><br><span>-=
-- a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</spa=
n><br><span>@@ -37,6 +37,7 @@</span><br><span> #include &lt;winsock2=2Eh&gt=
;</span><br><span> #include &lt;accctrl=2Eh&gt;</span><br><span> #include &=
lt;aclapi=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &lt;wow64apiset=2Eh&gt;</span><br><span> </span><br><span> #include =
&quot;buffer=2Eh&quot;</span><br><span> #include &quot;error=2Eh&quot;</spa=
n><br><span>@@ -1333,67 +1334,47 @@</span><br><span> static void</span><br>=
<span> win32_get_arch(arch_t *process_arch, arch_t *host_arch)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *process_ar=
ch =3D ARCH_UNKNOWN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   *host_arch =3D ARCH_NATIVE;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    typedef =
BOOL(WINAPI * is_wow64_process2_t)(HANDLE, USHORT *, USHORT *);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    is_wow64_process2_t is_wow64_=
process2 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (=
is_wow64_process2_t)GetProcAddress(GetModuleHandle(&quot;Kernel32=2Edll&quo=
t;), &quot;IsWow64Process2&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> #ifdef _ARM64_</span><br><span>     *process=
_arch =3D ARCH_ARM64;</span><br><span> #elif defined(_WIN64)</span><br><spa=
n>     *process_arch =3D ARCH_AMD64;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (is_wow64_process2)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        /* this could be amd64 on arm64 */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        USHORT process_machine =3D 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        USHORT native_machine =3D =
0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        BOOL is_wow=
64 =3D is_wow64_process2(GetCurrentProcess(), &amp;process_machine, &amp;na=
tive_machine);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (is_wow64 &amp;&amp; native_machine =3D=3D IMAGE_FILE_MACHINE_ARM64)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            *host_arch =3D ARCH_ARM6=
4;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#elif defined(_WIN32)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#else</span><br><span>     *process_arch =3D =
ARCH_X86;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(is_wow64_process2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    *host_arch =3D ARCH_NATIVE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* Determine if we&#39;re running on a different host-arch =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    USHORT proces=
s_machine =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 USHORT native_machine =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
IsWow64Process2(GetCurrentProcess(), &amp;process_machine, &amp;native_mach=
ine))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* check if we&#39;re running on arm64 or amd64 machine */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        USHORT process_=
machine =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 USHORT native_machine =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        BOOL is_wow64 =3D is_wow64_process2(GetCurrentProcess(), &a=
mp;process_machine, &amp;native_machine);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (is_wow64)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            switch (native_machine)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                case IMAGE_FILE_MACHINE_ARM64:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    *host_arch =3D A=
RCH_ARM64;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                case IMAGE_=
FILE_MACHINE_AMD64:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  *host_arch =3D ARCH_AMD64;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    break;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                default:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    *host_arch =3D ARCH_UNKNOWN;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    break;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return;</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    switch (native_machine)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        BOOL w64 =3D FALSE;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        BOOL is_wow64 =3D IsW=
ow64Process(GetCurrentProcess(), &amp;w64) &amp;&amp; w64;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (is_wow64)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            /* we are unable to differentiate betw=
een arm64 and amd64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
           * machines here, so assume we are running on amd64 */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        case IMAGE_FILE_MACHIN=
E_ARM64:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 *host_arch =3D ARCH_ARM64;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case=
 IMAGE_FILE_MACHINE_AMD64:</span><br><span>             *host_arch =3D ARCH=
_AMD64;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        case IMAGE_FILE_MACHINE_I386:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            *host_arch =3D=
 ARCH_X86;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            *host_arch =3D ARCH_=
UNKNOWN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 break;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif /* _ARM64_ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (*=
host_arch =3D=3D *process_arch)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      *host_arch =3D ARCH_NATIVE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><span> s=
tatic void</span><br><span>diff --git a/src/openvpnmsica/CMakeLists=2Etxt b=
/src/openvpnmsica/CMakeLists=2Etxt</span><br><span>index 9126b80=2E=2E06889=
c8 100644</span><br><span>--- a/src/openvpnmsica/CMakeLists=2Etxt</span><br=
><span>+++ b/src/openvpnmsica/CMakeLists=2Etxt</span><br><span>@@ -24,7 +24=
,7 @@</span><br><span> target_compile_options(openvpnmsica PRIVATE</span><b=
r><span>     -D_UNICODE</span><br><span>     -UNTDDI_VERSION</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    -D_WIN32_WINNT=3D_WIN32_WINNT_VI=
STA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    -D_WIN32_WIN=
NT=3D_WIN32_WINNT_WIN10</span><br><span>     )</span><br><span> </span><br>=
<span> if (MSVC)</span><br><span>diff --git a/src/openvpnmsica/Makefile=2Ea=
m b/src/openvpnmsica/Makefile=2Eam</span><br><span>index 87bf9a7=2E=2E5e783=
8f 100644</span><br><span>--- a/src/openvpnmsica/Makefile=2Eam</span><br><s=
pan>+++ b/src/openvpnmsica/Makefile=2Eam</span><br><span>@@ -34,8 +34,7 @@<=
/span><br><span> lib_LTLIBRARIES =3D libopenvpnmsica=2Ela</span><br><span> =
libopenvpnmsica_la_CFLAGS =3D \</span><br><span> 	-municode -D_UNICODE \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	-UNTDDI_VERSION -U_WIN3=
2_WINNT \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-D_WIN32_WI=
NNT=3D_WIN32_WINNT_VISTA \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	-UNTDDI_VERSION -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10 \</span><br><sp=
an> 	-Wl,--kill-at</span><br><span> libopenvpnmsica_la_LDFLAGS =3D -ladvapi=
32 -lole32 -lmsi -lsetupapi -liphlpapi -lshell32 -lshlwapi -lversion -lnewd=
ev -no-undefined -avoid-version</span><br><span> endif</span><br><span>diff=
 --git a/src/openvpnserv/CMakeLists=2Etxt b/src/openvpnserv/CMakeLists=2Etx=
t</span><br><span>index fc15382=2E=2E2cc4a93 100644</span><br><span>--- a/s=
rc/openvpnserv/CMakeLists=2Etxt</span><br><span>+++ b/src/openvpnserv/CMake=
Lists=2Etxt</span><br><span>@@ -21,7 +21,7 @@</span><br><span>     target_c=
ompile_options(${target} PRIVATE</span><br><span>         -D_UNICODE</span>=
<br><span>         -UNTDDI_VERSION</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        -D_WIN32_WINNT=3D_WIN32_WINNT_=
WIN10</span><br><span>     )</span><br><span>     target_link_libraries(${t=
arget} PRIVATE</span><br><span>         advapi32=2Elib userenv=2Elib iphlpa=
pi=2Elib fwpuclnt=2Elib rpcrt4=2Elib</span><br><span>diff --git a/src/openv=
pnserv/Makefile=2Eam b/src/openvpnserv/Makefile=2Eam</span><br><span>index =
ac97eb4=2E=2E447fb10 100644</span><br><span>--- a/src/openvpnserv/Makefile=
=2Eam</span><br><span>+++ b/src/openvpnserv/Makefile=2Eam</span><br><span>@=
@ -23,8 +23,7 @@</span><br><span> sbin_PROGRAMS =3D openvpnserv</span><br><=
span> openvpnserv_CFLAGS =3D \</span><br><span> 	-municode -D_UNICODE \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	-UNTDDI_VERSION -U_WIN32=
_WINNT \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-D_WIN32_WIN=
NT=3D_WIN32_WINNT_VISTA</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	-UNTDDI_VERSION -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10</span><br><span> o=
penvpnserv_LDADD =3D \</span><br><span> 	-ladvapi32 -luserenv -liphlpapi -l=
fwpuclnt -lrpcrt4 \</span><br><span> 	-lshlwapi -lnetapi32 -lws2_32 -lntdll=
 -lole32 -lpathcch</span><br><span>diff --git a/src/tapctl/CMakeLists=2Etxt=
 b/src/tapctl/CMakeLists=2Etxt</span><br><span>index 97702c0=2E=2E94453ed 1=
00644</span><br><span>--- a/src/tapctl/CMakeLists=2Etxt</span><br><span>+++=
 b/src/tapctl/CMakeLists=2Etxt</span><br><span>@@ -21,10 +21,10 @@</span><b=
r><span> target_compile_options(tapctl PRIVATE</span><br><span>     -D_UNIC=
ODE</span><br><span>     -UNTDDI_VERSION</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    -D_WIN32_WINNT=3D_WIN32_WINNT_WI=
N10</span><br><span>     )</span><br><span> target_link_libraries(tapctl</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    advapi32=2Elib ole32=
=2Elib setupapi=2Elib)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    advapi32=2Elib newdev=2Elib ole32=2Elib setupapi=2Elib)</span><br><s=
pan> if (MINGW)</span><br><span>     target_compile_options(tapctl PRIVATE =
-municode)</span><br><span>     target_link_options(tapctl PRIVATE -municod=
e)</span><br><span>diff --git a/src/tapctl/Makefile=2Eam b/src/tapctl/Makef=
ile=2Eam</span><br><span>index 58cd580=2E=2E5d1f851 100644</span><br><span>=
--- a/src/tapctl/Makefile=2Eam</span><br><span>+++ b/src/tapctl/Makefile=2E=
am</span><br><span>@@ -35,8 +35,7 @@</span><br><span> sbin_PROGRAMS =3D tap=
ctl</span><br><span> tapctl_CFLAGS =3D \</span><br><span> 	-municode -D_UNI=
CODE \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-UNTDDI_VERSIO=
N -U_WIN32_WINNT \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-D=
_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	-UNTDDI_VERSION	-D_WIN32_WINNT=3D_WIN32_WINNT_WIN10</span><b=
r><span> tapctl_LDADD =3D -ladvapi32 -lole32 -lsetupapi</span><br><span> en=
dif</span><br><span> </span><br><span>diff --git a/src/tapctl/tap=2Ec b/src=
/tapctl/tap=2Ec</span><br><span>index dd22cc5=2E=2Eac1ecd2 100644</span><br=
><span>--- a/src/tapctl/tap=2Ec</span><br><span>+++ b/src/tapctl/tap=2Ec</s=
pan><br><span>@@ -50,6 +50,7 @@</span><br><span>     (_countof(L&quot;SYSTE=
M\\CurrentControlSet\\Control\\Network\\&quot;) - 1 + 38 + _countof(L&quot;=
\\&quot;) - 1 \</span><br><span>      + 38 + _countof(L&quot;\\Connection&q=
uot;))</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifndef HAVE_DIINSTALLDEVICE</span><br><span> /**</span><br><span>  * =
Dynamically load a library and find a function in it</span><br><span>  *</s=
pan><br><span>@@ -99,6 +100,7 @@</span><br><span>     }</span><br><span>   =
  return fptr;</span><br><span> }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span> </span><br><span> /**</span><br><span=
>  * Returns length of string of strings</span><br></pre><p>To view, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">chan=
ge 1955</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1955 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>

</body></html>
--3+SXWja1jmM=--


--===============4563391134962086952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4563391134962086952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4563391134962086952==--

