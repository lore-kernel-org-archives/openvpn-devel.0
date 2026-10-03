Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0215CA5FED
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TnCjNZtb0LnT7Q3LQ5wHNTNOqaMV0CJBRNwyhEK1jeQ=; b=FtQeKdpd/vJu9TK8hNLBehMbFo
	RPmbjK+TL1HaJ7sgCmvqWfTrWQJYv8PLtVP0ywDmKdvLq7/iy8xx6KAWbEfBCfts6SSAkv2QzIedm
	w+zDhy+eQT44eEkMmH3aZ/4MUtBUWnE46CVY+f6KeWsl/r3B7WvSgz4NoodSLDorrJUY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xD3zC-0001IW-SS;
	Sat, 03 Oct 2026 17:57:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xD3zB-0001IP-SL
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 17:57:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dwjJwHvOAqC3mKL1e8cymtN9fPR0MIbKf2kqZw7HQnA=; b=QCeIXsGauho/dPV1j0kx+M/ao8
 IRApLnGXEhjzWtuoBtpFxmYUfb7/tjD8FdfGqnWyhPrUjnkksm4/eKcqhdSJQZ0U99TLohR0+Dyao
 T9yXZNfEs1Kph3yNCy9VqqaU/FjU1XcmEhIhX5R+T4jfr8T7uHFH8UjDk+b1/1D+aAjA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dwjJwHvOAqC3mKL1e8cymtN9fPR0MIbKf2kqZw7HQnA=; b=Gng+KLP0IAJdqlOsD55ToazU41
 she63FBl8VIJVD9F7+m/gP5+1+431YYkHrS4z8OWQYOIvPT44WxHVrdXqAabR6k+4RStVAaITD0Xd
 Rw1E8k1ZwsmRk9jdPHfoxNGNMO+w9xGMya5ntZFq4npR4jRAZEANcoRsp5fy1Cv8EGbA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xD3zB-0003WC-3v for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 17:57:26 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 693HvI6e006559
 for <openvpn-devel@lists.sourceforge.net>; Sat, 3 Oct 2026 19:57:18 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 693HvIIb006558
 for openvpn-devel@lists.sourceforge.net; Sat, 3 Oct 2026 19:57:18 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat,  3 Oct 2026 19:57:12 +0200
Message-ID: <20261003175718.6544-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xD3zB-0003WC-3v
Subject: [Openvpn-devel] [PATCH v4] Build against Windows 10 API and remove
 some backwards compatility code
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

Originally prompted by some cppcheck complaint about
win32_get_arch(). Looking at the code I decided to
propose removing the various work-arounds from pre-Win10
times. Microsoft certainly doesn't support these
versions anymore, so let's also remove that.

Note that this does not remove all instances of GetProcAddress:
- One is required due to a issue in MinGW toolchain (DiInstallDevice)
- One is used to avoid a dependency on WDK headers (RtlGetVersion)
- One is required due to using an undocumented function that is
  not available in MinGW (RtlPublishWnfStateData)

Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1955
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1955
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index d553697..2d9b546 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -251,6 +251,14 @@
 check_symbol_exists(strsep string.h HAVE_STRSEP)
 check_symbol_exists(strtok_r string.h HAVE_STRTOK_R)
 
+if (WIN32)
+    # Required due to a bug in MinGW where the .h file is correct
+    # but the symbol is missing from newdev.dll
+    set(CMAKE_REQUIRED_LIBRARIES newdev.lib)
+    check_symbol_exists(DiInstallDevice "windows.h;newdev.h" HAVE_DIINSTALLDEVICE)
+    unset(CMAKE_REQUIRED_LIBRARIES)
+endif ()
+
 # Some OS (e.g. FreeBSD) need some basic headers to allow
 # including network headers
 set(NETEXTRA sys/types.h)
@@ -344,7 +352,7 @@
     if (MINGW)
         target_compile_definitions(${target} PRIVATE
                 WIN32_LEAN_AND_MEAN
-                NTDDI_VERSION=NTDDI_VISTA _WIN32_WINNT=_WIN32_WINNT_VISTA
+                NTDDI_VERSION=NTDDI_WIN10 _WIN32_WINNT=_WIN32_WINNT_WIN10
         )
     endif()
 
diff --git a/config.h.cmake.in b/config.h.cmake.in
index c6c0a96..6c8660c 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -330,6 +330,9 @@
 /* Define to 1 if you have the <valgrind/memcheck.h> header file. */
 #undef HAVE_VALGRIND_MEMCHECK_H
 
+/* Define to 1 if you have the `DiInstallDevice' function. */
+#cmakedefine HAVE_DIINSTALLDEVICE
+
 /* Availability of different mbed TLS features and APIs */
 #cmakedefine HAVE_PSA_CRYPTO_H
 
diff --git a/configure.ac b/configure.ac
index 1fa0e63..a06c4c9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -346,7 +346,7 @@
 		AM_CONDITIONAL([ENABLE_DNS_UPDOWN], [false])
 		AC_SUBST([DNS_UPDOWN_TYPE], ["windows"])
 		CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
-		CPPFLAGS="${CPPFLAGS} -DNTDDI_VERSION=NTDDI_VISTA -D_WIN32_WINNT=_WIN32_WINNT_VISTA"
+		CPPFLAGS="${CPPFLAGS} -DNTDDI_VERSION=NTDDI_WIN10 -D_WIN32_WINNT=_WIN32_WINNT_WIN10"
 		WIN32=yes
 		;;
 	*-*-dragonfly*)
@@ -1397,4 +1397,4 @@
 # Put the warning at the end, so it is better visible
 if test "${enable_debug}" = "yes"; then
     AC_MSG_WARN([--enable-developer-debug is enabled. This should be only used for test/development builds and not for production usage])
-fi
\ No newline at end of file
+fi
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 90cff8c..bd94c1a 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -35,6 +35,7 @@
 #include "openvpn.h"
 
 #include <bcrypt.h>
+#include <ioapiset.h>
 #include <winsock2.h>
 #include <ws2tcpip.h>
 
@@ -222,17 +223,6 @@
 dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, struct signal_info *sig_info)
 {
     volatile int *signal_received = &sig_info->signal_received;
-    /* GetOverlappedResultEx is available starting from Windows 8 */
-    typedef BOOL(WINAPI * get_overlapped_result_ex_t)(HANDLE, LPOVERLAPPED, LPDWORD, DWORD, BOOL);
-    get_overlapped_result_ex_t get_overlapped_result_ex =
-        (get_overlapped_result_ex_t)GetProcAddress(GetModuleHandle("Kernel32.dll"),
-                                                   "GetOverlappedResultEx");
-
-    if (get_overlapped_result_ex == NULL)
-    {
-        msg(M_ERR, "Failed to load GetOverlappedResult()");
-    }
-
     DWORD timeout_msec = timeout * 1000;
     const int poll_interval_ms = 50;
 
@@ -241,7 +231,7 @@
         timeout_msec -= poll_interval_ms;
 
         DWORD transferred;
-        if (get_overlapped_result_ex(handle, ov, &transferred, poll_interval_ms, FALSE) != 0)
+        if (GetOverlappedResultEx(handle, ov, &transferred, poll_interval_ms, FALSE) != 0)
         {
             /* TCP connection established by dco */
             return;
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 618772d..4c511a9 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -37,6 +37,7 @@
 #include <winsock2.h>
 #include <accctrl.h>
 #include <aclapi.h>
+#include <wow64apiset.h>
 
 #include "buffer.h"
 #include "error.h"
@@ -1333,67 +1334,47 @@
 static void
 win32_get_arch(arch_t *process_arch, arch_t *host_arch)
 {
-    *process_arch = ARCH_UNKNOWN;
-    *host_arch = ARCH_NATIVE;
-
-    typedef BOOL(WINAPI * is_wow64_process2_t)(HANDLE, USHORT *, USHORT *);
-    is_wow64_process2_t is_wow64_process2 =
-        (is_wow64_process2_t)GetProcAddress(GetModuleHandle("Kernel32.dll"), "IsWow64Process2");
-
 #ifdef _ARM64_
     *process_arch = ARCH_ARM64;
 #elif defined(_WIN64)
     *process_arch = ARCH_AMD64;
-    if (is_wow64_process2)
-    {
-        /* this could be amd64 on arm64 */
-        USHORT process_machine = 0;
-        USHORT native_machine = 0;
-        BOOL is_wow64 = is_wow64_process2(GetCurrentProcess(), &process_machine, &native_machine);
-        if (is_wow64 && native_machine == IMAGE_FILE_MACHINE_ARM64)
-        {
-            *host_arch = ARCH_ARM64;
-        }
-    }
-#elif defined(_WIN32)
+#else
     *process_arch = ARCH_X86;
+#endif
 
-    if (is_wow64_process2)
+    *host_arch = ARCH_NATIVE;
+    /* Determine if we're running on a different host-arch */
+    USHORT process_machine = 0;
+    USHORT native_machine = 0;
+
+    if (!IsWow64Process2(GetCurrentProcess(), &process_machine, &native_machine))
     {
-        /* check if we're running on arm64 or amd64 machine */
-        USHORT process_machine = 0;
-        USHORT native_machine = 0;
-        BOOL is_wow64 = is_wow64_process2(GetCurrentProcess(), &process_machine, &native_machine);
-        if (is_wow64)
-        {
-            switch (native_machine)
-            {
-                case IMAGE_FILE_MACHINE_ARM64:
-                    *host_arch = ARCH_ARM64;
-                    break;
-
-                case IMAGE_FILE_MACHINE_AMD64:
-                    *host_arch = ARCH_AMD64;
-                    break;
-
-                default:
-                    *host_arch = ARCH_UNKNOWN;
-                    break;
-            }
-        }
+        return;
     }
-    else
+
+    switch (native_machine)
     {
-        BOOL w64 = FALSE;
-        BOOL is_wow64 = IsWow64Process(GetCurrentProcess(), &w64) && w64;
-        if (is_wow64)
-        {
-            /* we are unable to differentiate between arm64 and amd64
-             * machines here, so assume we are running on amd64 */
+        case IMAGE_FILE_MACHINE_ARM64:
+            *host_arch = ARCH_ARM64;
+            break;
+
+        case IMAGE_FILE_MACHINE_AMD64:
             *host_arch = ARCH_AMD64;
-        }
+            break;
+
+        case IMAGE_FILE_MACHINE_I386:
+            *host_arch = ARCH_X86;
+            break;
+
+        default:
+            *host_arch = ARCH_UNKNOWN;
+            break;
     }
-#endif /* _ARM64_ */
+
+    if (*host_arch == *process_arch)
+    {
+        *host_arch = ARCH_NATIVE;
+    }
 }
 
 static void
diff --git a/src/openvpnmsica/CMakeLists.txt b/src/openvpnmsica/CMakeLists.txt
index 9126b80..06889c8 100644
--- a/src/openvpnmsica/CMakeLists.txt
+++ b/src/openvpnmsica/CMakeLists.txt
@@ -24,7 +24,7 @@
 target_compile_options(openvpnmsica PRIVATE
     -D_UNICODE
     -UNTDDI_VERSION
-    -D_WIN32_WINNT=_WIN32_WINNT_VISTA
+    -D_WIN32_WINNT=_WIN32_WINNT_WIN10
     )
 
 if (MSVC)
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index 87bf9a7..5e7838f 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -34,8 +34,7 @@
 lib_LTLIBRARIES = libopenvpnmsica.la
 libopenvpnmsica_la_CFLAGS = \
 	-municode -D_UNICODE \
-	-UNTDDI_VERSION -U_WIN32_WINNT \
-	-D_WIN32_WINNT=_WIN32_WINNT_VISTA \
+	-UNTDDI_VERSION -D_WIN32_WINNT=_WIN32_WINNT_WIN10 \
 	-Wl,--kill-at
 libopenvpnmsica_la_LDFLAGS = -ladvapi32 -lole32 -lmsi -lsetupapi -liphlpapi -lshell32 -lshlwapi -lversion -lnewdev -no-undefined -avoid-version
 endif
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index fc15382..2cc4a93 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -21,7 +21,7 @@
     target_compile_options(${target} PRIVATE
         -D_UNICODE
         -UNTDDI_VERSION
-        -D_WIN32_WINNT=_WIN32_WINNT_VISTA
+        -D_WIN32_WINNT=_WIN32_WINNT_WIN10
     )
     target_link_libraries(${target} PRIVATE
         advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index ac97eb4..447fb10 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -23,8 +23,7 @@
 sbin_PROGRAMS = openvpnserv
 openvpnserv_CFLAGS = \
 	-municode -D_UNICODE \
-	-UNTDDI_VERSION -U_WIN32_WINNT \
-	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
+	-UNTDDI_VERSION -D_WIN32_WINNT=_WIN32_WINNT_WIN10
 openvpnserv_LDADD = \
 	-ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \
 	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32 -lpathcch
diff --git a/src/tapctl/CMakeLists.txt b/src/tapctl/CMakeLists.txt
index 97702c0..94453ed 100644
--- a/src/tapctl/CMakeLists.txt
+++ b/src/tapctl/CMakeLists.txt
@@ -21,10 +21,10 @@
 target_compile_options(tapctl PRIVATE
     -D_UNICODE
     -UNTDDI_VERSION
-    -D_WIN32_WINNT=_WIN32_WINNT_VISTA
+    -D_WIN32_WINNT=_WIN32_WINNT_WIN10
     )
 target_link_libraries(tapctl
-    advapi32.lib ole32.lib setupapi.lib)
+    advapi32.lib newdev.lib ole32.lib setupapi.lib)
 if (MINGW)
     target_compile_options(tapctl PRIVATE -municode)
     target_link_options(tapctl PRIVATE -municode)
diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefile.am
index 58cd580..5d1f851 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -35,8 +35,7 @@
 sbin_PROGRAMS = tapctl
 tapctl_CFLAGS = \
 	-municode -D_UNICODE \
-	-UNTDDI_VERSION -U_WIN32_WINNT \
-	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
+	-UNTDDI_VERSION	-D_WIN32_WINNT=_WIN32_WINNT_WIN10
 tapctl_LDADD = -ladvapi32 -lole32 -lsetupapi
 endif
 
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index dd22cc5..ac1ecd2 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -50,6 +50,7 @@
     (_countof(L"SYSTEM\\CurrentControlSet\\Control\\Network\\") - 1 + 38 + _countof(L"\\") - 1 \
      + 38 + _countof(L"\\Connection"))
 
+#ifndef HAVE_DIINSTALLDEVICE
 /**
  * Dynamically load a library and find a function in it
  *
@@ -99,6 +100,7 @@
     }
     return fptr;
 }
+#endif
 
 /**
  * Returns length of string of strings


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
