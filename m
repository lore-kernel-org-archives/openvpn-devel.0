Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26379CA5FF4
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVXG1i043LO6ne1Np+UpC9CkqEo8d8K/wEbqHffggn8=; b=IxlV8t1EMbRD+rICFVWGgVpUgT
	cxUkTfEYcOtEBv0l0MQpFiWvT2bcBgKIVGS/PSe+oi8k9waSuv8NjDIETvLDoAAzuHOYAfE/dGkJk
	eOpfH4EEoQ6Sn77SgXu0zL653rese/DLRIY1QhEicBxbP9xB8g88GNXXMbS+b9jGpigs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDI1a-0001uj-HJ;
	Sun, 04 Oct 2026 08:56:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDI1Y-0001uc-Ic
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UVe6sAy7HwUAztahZlVoj/2IdlkqSkiSNu2etL0ivNg=; b=Bh2ig8cJtIyI9jOHRZsMEIl/Ut
 idb2Rwq3/ywcra1rNob4cFptnT/TjAYs154/vkQOHCtF2tK/nH3ILZrkit/R+3oQCd3+uUeFxOYy+
 3Vn4dKQoI+WDiFHMSH0bDTOi/5s/FYgCYgdVUp/eT9vZcsRFwdh0UZyDXHU9WsAvSN4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UVe6sAy7HwUAztahZlVoj/2IdlkqSkiSNu2etL0ivNg=; b=M
 3f4AaOxskfwmBSZuoAgiCbcq5o9jvB+6I7VGYSpwq9KXNrEhdUyknuWe8EVZCRaerLqP8yN5QqdLi
 7jnkebIISMPfhDz2DCP9NcaPKg1R2evdFsZBdKuD5xXd67ZXvXRY0Tnn0yh9XKejCOauwtUC9K1Od
 9Xq31XIC/t96MxyI=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDI1X-000546-By for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:56:49 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so9016805e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 01:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791104201; x=1791709001; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UVe6sAy7HwUAztahZlVoj/2IdlkqSkiSNu2etL0ivNg=;
 b=G4SdqKTLejVnICvhhUWzSmW8gul8goOgr4O5YI9MicO27KycMmtW60hGtx9eB3mJog
 5krN4653LAMdWwoN2selRLBXVFm0XJgggElN9FwqSfJrJ3mn/j3h54A6Swa7bcKBsI6V
 98JL23g3TMyNby3pcE6g0RGeYRZ0gT8S3TYZGB8R10Sv74VX5qfiVyK68DHeNC9bxBcV
 r3b4UBN4r+OjpUrMA7kKc33ZvGue1+VE7tunApNu36bO3WoBNz/aTocBQlZ2VAq5TFJN
 4eI0nyLvMF4GegPiJLPaydjLfuf/71dXJXZtNPeli6bJTX5SlHvw3O+5yuocraAHhGlp
 BIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791104201; x=1791709001;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UVe6sAy7HwUAztahZlVoj/2IdlkqSkiSNu2etL0ivNg=;
 b=lKNfumaA+jwho1XB+2MfxonsgCcyQXUigs8wpBwK6l38eRkNlUaxV5piBZXjpcsJ3L
 qrgbzr7cTzdHAjTUz3lGm/rlzk8/yiOYAfvCUS6zYjiGwEY5HVOEaiSLGtwKXvx39e6D
 8G8jCF9JAHkvuyqmFPqmZumOvVnvZyy5qXLdjLaaCLpzTOfL/xBwwKF8l8CmG4Wd3tHN
 e/taO+IUfLQYtkiLRZ8zgWtka1LgCLnP89omyyKktMJX9jZEifXvnsOGSACK1kiIx4rd
 2kYerDDbiwMaGQtIuQXdBTV33IgzQdMulLhq0+WCKrJZYV9hFutfW9ET62RfeXAS/7nm
 tcJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrY3oNqOzTscpmX3phry5qE18Wo9iymufI6JDP52bkc0Uu2od+fcUf68GQ27ybcK9ZfFsX1EtjFaU57Z7e@lists.sourceforge.net
X-Gm-Message-State: AFuF++mRl0at6ELnLrb2PDQ1VcTlD4CsD6qGB4WvQqO+pTmLgqA+xaVW
 hKaCa6hPPjqF7D2qtG9f1ZlTtGDLmG9shbSWrxPw/ixr0SVebhJT5o4LoILAw8Kd0DgiL8lyMMo
 Lx7d+L4HNymi9mGCiLcz4Qd0TK8og/HZaFZoSg7PplwD6vi8f+zQI417baOJy7Dt13CGtXKesIi
 3YiEUDnA==
X-Gm-Gg: AYBFou1wHmwMGWwZMPV30ToARdFBolU1yV/7d89aAaA9JPOpKtI6FN/3XjXe7t/bchD
 FdKUI1YKIW9fbCpS4ME+PGVSa4JScDlzIC71VlojWwQg64a3PRmCvKPlExb63GS0dRvjBBAE8Lw
 rOqOz34OPDbN4JbkIUetYHgCHTsgW7DQaiSNb2icFpphsBXxqVMFOVa4SsQsappjWIC48hasEuR
 mMore23gmoZYKzZvaXx7o0vzFjH2rFcZnVtrsEZFrU8A2uXgBWqCKMkGSS41I1rVFL661ynG8p+
 iUyqrxOevuYO48Pegd8/eV4mWXMGBNOYkvkfRAM4qYCQl+MthYpIiEsRpYSMbVcD9ShJ/rZoz9i
 1WDXIkzWdRZEjyTabvZeYJ2h6jXQtP4LFtXU9jhAUANsxQDrIhqe0zbShdJaxsErC8K8cK3YfhO
 +g9YNM5kLF1tqAcd3qWEK8cn17aGr1IMNu9RVDeDQgEb8z3AURkubgatsYhBida5ox50Af8O/2u
 RSujeUuWzoBDuQesaOJFKqP5G1yF0oYmiY5mc5m+sVyCOht7Mp/tTvySXiy2TgezrQGHaRMbVyg
 wyGPZcM9Bx2fWwPt8BwVGWVFD5jsN9n4qaq7VOQLGK23v4ycC5c3IUfokgVg
X-Received: by 2002:a05:600c:3110:b0:4a0:b6:4619 with SMTP id
 5b1f17b1804b1-4a168069b91mr75316975e9.0.1791104200540; 
 Sun, 04 Oct 2026 01:56:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a162e867e8sm209404095e9.15.2026.10.04.01.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 01:56:40 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 4 Oct 2026 08:56:39 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
X-Gerrit-Change-Number: 1955
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1955?usp=email>
X-Gerrit-Commit: 624f08b120a119ac730ce6e09c2abc59495c069d
In-Reply-To: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNTk5NjY4MDAwLkk0NGQ3MTcxYzdlNGY4NDk3YmY4YjkwMjM4MGRmOTJhNThiZjhhNzlhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a52bbb61c9b7786a00904765676122c108aa9e78-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDI1X-000546-By
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1574991747033127290=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1574991747033127290==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fItHzaA4UFE="; charset=UTF-8

--fItHzaA4UFE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1955?usp=3Demail )

Change subject: Build against Windows 10 AP=
I and remove some backwards compatility code
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
diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index d553697=2E=2E2d9b546=
 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -251,6 +251,14 @@
=
 check_symbol_exists(strsep string=2Eh HAVE_STRSEP)
 check_symbol_exists(st=
rtok_r string=2Eh HAVE_STRTOK_R)
 
+if (WIN32)
+    # Required due to a bug=
 in MinGW where the =2Eh file is correct
+    # but the symbol is missing f=
rom newdev=2Edll
+    set(CMAKE_REQUIRED_LIBRARIES newdev=2Elib)
+    check=
_symbol_exists(DiInstallDevice "windows=2Eh;newdev=2Eh" HAVE_DIINSTALLDEVIC=
E)
+    unset(CMAKE_REQUIRED_LIBRARIES)
+endif ()
+
 # Some OS (e=2Eg=2E Fr=
eeBSD) need some basic headers to allow
 # including network headers
 set(N=
ETEXTRA sys/types=2Eh)
@@ -344,7 +352,7 @@
     if (MINGW)
         target_=
compile_definitions(${target} PRIVATE
                 WIN32_LEAN_AND_MEAN
=
-                NTDDI_VERSION=3DNTDDI_VISTA _WIN32_WINNT=3D_WIN32_WINNT_VI=
STA
+                NTDDI_VERSION=3DNTDDI_WIN10 _WIN32_WINNT=3D_WIN32_WINN=
T_WIN10
         )
     endif()
 
diff --git a/config=2Eh=2Ecmake=2Ein b/co=
nfig=2Eh=2Ecmake=2Ein
index c6c0a96=2E=2E6c8660c 100644
--- a/config=2Eh=2E=
cmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -330,6 +330,9 @@
 /* Define to =
1 if you have the <valgrind/memcheck=2Eh> header file=2E */
 #undef HAVE_VA=
LGRIND_MEMCHECK_H
 
+/* Define to 1 if you have the `DiInstallDevice' funct=
ion=2E */
+#cmakedefine HAVE_DIINSTALLDEVICE
+
 /* Availability of differen=
t mbed TLS features and APIs */
 #cmakedefine HAVE_PSA_CRYPTO_H
 
diff --gi=
t a/configure=2Eac b/configure=2Eac
index 195116f=2E=2E56109af 100644
--- a=
/configure=2Eac
+++ b/configure=2Eac
@@ -346,7 +346,7 @@
 		AM_CONDITIONAL(=
[ENABLE_DNS_UPDOWN], [false])
 		AC_SUBST([DNS_UPDOWN_TYPE], ["windows"])
 =
		CPPFLAGS=3D"${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
-		CPPFLAGS=3D"${CPPFLAGS}=
 -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA"
+		CPPF=
LAGS=3D"${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_WIN10 -D_WIN32_WINNT=3D_WIN32_W=
INNT_WIN10"
 		WIN32=3Dyes
 		;;
 	*-*-dragonfly*)
@@ -1397,4 +1397,4 @@
 #=
 Put the warning at the end, so it is better visible
 if test "${enable_deb=
ug}" =3D "yes"; then
     AC_MSG_WARN([--enable-developer-debug is enabled=
=2E This should be only used for test/development builds and not for produc=
tion usage])
-fi
\ No newline at end of file
+fi
diff --git a/src/openvpn/d=
co_win=2Ec b/src/openvpn/dco_win=2Ec
index 90cff8c=2E=2Ebd94c1a 100644
--- =
a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -35,6 +35,7 @@
 =
#include "openvpn=2Eh"
 
 #include <bcrypt=2Eh>
+#include <ioapiset=2Eh>
 #=
include <winsock2=2Eh>
 #include <ws2tcpip=2Eh>
 
@@ -222,17 +223,6 @@
 dco=
_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, struct signal_inf=
o *sig_info)
 {
     volatile int *signal_received =3D &sig_info->signal_re=
ceived;
-    /* GetOverlappedResultEx is available starting from Windows 8 =
*/
-    typedef BOOL(WINAPI * get_overlapped_result_ex_t)(HANDLE, LPOVERLAP=
PED, LPDWORD, DWORD, BOOL);
-    get_overlapped_result_ex_t get_overlapped_=
result_ex =3D
-        (get_overlapped_result_ex_t)GetProcAddress(GetModule=
Handle("Kernel32=2Edll"),
-                                                =
   "GetOverlappedResultEx");
-
-    if (get_overlapped_result_ex =3D=3D NUL=
L)
-    {
-        msg(M_ERR, "Failed to load GetOverlappedResult()");
-   =
 }
-
     DWORD timeout_msec =3D timeout * 1000;
     const int poll_interv=
al_ms =3D 50;
 
@@ -241,7 +231,7 @@
         timeout_msec -=3D poll_interva=
l_ms;
 
         DWORD transferred;
-        if (get_overlapped_result_ex(h=
andle, ov, &transferred, poll_interval_ms, FALSE) !=3D 0)
+        if (GetO=
verlappedResultEx(handle, ov, &transferred, poll_interval_ms, FALSE) !=3D 0=
)
         {
             /* TCP connection established by dco */
         =
    return;
diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
inde=
x 82341f8=2E=2Efde6412 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn=
/win32=2Ec
@@ -37,6 +37,7 @@
 #include <winsock2=2Eh>
 #include <accctrl=2E=
h>
 #include <aclapi=2Eh>
+#include <wow64apiset=2Eh>
 
 #include "buffer=
=2Eh"
 #include "error=2Eh"
@@ -1334,67 +1335,47 @@
 static void
 win32_get=
_arch(arch_t *process_arch, arch_t *host_arch)
 {
-    *process_arch =3D AR=
CH_UNKNOWN;
-    *host_arch =3D ARCH_NATIVE;
-
-    typedef BOOL(WINAPI * i=
s_wow64_process2_t)(HANDLE, USHORT *, USHORT *);
-    is_wow64_process2_t i=
s_wow64_process2 =3D
-        (is_wow64_process2_t)GetProcAddress(GetModule=
Handle("Kernel32=2Edll"), "IsWow64Process2");
-
 #ifdef _ARM64_
     *proce=
ss_arch =3D ARCH_ARM64;
 #elif defined(_WIN64)
     *process_arch =3D ARCH_=
AMD64;
-    if (is_wow64_process2)
-    {
-        /* this could be amd64 o=
n arm64 */
-        USHORT process_machine =3D 0;
-        USHORT native_ma=
chine =3D 0;
-        BOOL is_wow64 =3D is_wow64_process2(GetCurrentProcess=
(), &process_machine, &native_machine);
-        if (is_wow64 && native_mac=
hine =3D=3D IMAGE_FILE_MACHINE_ARM64)
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58=
bf8a79a
Gerrit-Change-Number: 1955
Gerrit-PatchSet: 5
Gerrit-Owner: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@gr=
eenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--fItHzaA4UFE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1955?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Build against Windows 10 API and r=
emove some backwards compatility code<br><br>Originally prompted by some cp=
pcheck complaint about<br>win32_get_arch()=2E Looking at the code I decided=
 to<br>propose removing the various work-arounds from pre-Win10<br>times=2E=
 Microsoft certainly doesn&#39;t support these<br>versions anymore, so let&=
#39;s also remove that=2E<br><br>Note that this does not remove all instanc=
es of GetProcAddress:<br>- One is required due to a issue in MinGW toolchai=
n (DiInstallDevice)<br>- One is used to avoid a dependency on WDK headers (=
RtlGetVersion)<br>- One is required due to using an undocumented function t=
hat is<br>  not available in MinGW (RtlPublishWnfStateData)<br><br>Change-I=
d: I44d7171c7e4f8497bf8b902380df92a58bf8a79a<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1955<br>Message-Id: &lt;20261003175718=2E6544-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg39673=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M config=2Eh=2Ecmake=2Ein<b=
r>M configure=2Eac<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/win32=2Ec<=
br>M src/openvpnmsica/CMakeLists=2Etxt<br>M src/openvpnmsica/Makefile=2Eam<=
br>M src/openvpnserv/CMakeLists=2Etxt<br>M src/openvpnserv/Makefile=2Eam<br=
>M src/tapctl/CMakeLists=2Etxt<br>M src/tapctl/Makefile=2Eam<br>M src/tapct=
l/tap=2Ec<br>12 files changed, 56 insertions(+), 75 deletions(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>ind=
ex d553697=2E=2E2d9b546 100644</span><br><span>--- a/CMakeLists=2Etxt</span=
><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -251,6 +251,14 @@</spa=
n><br><span> check_symbol_exists(strsep string=2Eh HAVE_STRSEP)</span><br><=
span> check_symbol_exists(strtok_r string=2Eh HAVE_STRTOK_R)</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (WIN32)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Required due to a b=
ug in MinGW where the =2Eh file is correct</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    # but the symbol is missing from newdev=2Edll</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(CMAKE_REQUIRED=
_LIBRARIES newdev=2Elib)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    check_symbol_exists(DiInstallDevice &quot;windows=2Eh;newdev=2Eh&q=
uot; HAVE_DIINSTALLDEVICE)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unset(CMAKE_REQUIRED_LIBRARIES)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> # Some OS (e=2Eg=2E FreeBSD) need some basic =
headers to allow</span><br><span> # including network headers</span><br><sp=
an> set(NETEXTRA sys/types=2Eh)</span><br><span>@@ -344,7 +352,7 @@</span><=
br><span>     if (MINGW)</span><br><span>         target_compile_definition=
s(${target} PRIVATE</span><br><span>                 WIN32_LEAN_AND_MEAN</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                NTDDI_VE=
RSION=3DNTDDI_VISTA _WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                NTDDI_VERSION=3DNTDDI_WIN=
10 _WIN32_WINNT=3D_WIN32_WINNT_WIN10</span><br><span>         )</span><br><=
span>     endif()</span><br><span> </span><br><span>diff --git a/config=2Eh=
=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index c6c0a96=2E=2E=
6c8660c 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><spa=
n>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -330,6 +330,9 @@</span><=
br><span> /* Define to 1 if you have the &lt;valgrind/memcheck=2Eh&gt; head=
er file=2E */</span><br><span> #undef HAVE_VALGRIND_MEMCHECK_H</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1=
 if you have the `DiInstallDevice&#39; function=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_DIINSTALLDEVICE</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Availa=
bility of different mbed TLS features and APIs */</span><br><span> #cmakede=
fine HAVE_PSA_CRYPTO_H</span><br><span> </span><br><span>diff --git a/confi=
gure=2Eac b/configure=2Eac</span><br><span>index 195116f=2E=2E56109af 10064=
4</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac=
</span><br><span>@@ -346,7 +346,7 @@</span><br><span> 		AM_CONDITIONAL([ENA=
BLE_DNS_UPDOWN], [false])</span><br><span> 		AC_SUBST([DNS_UPDOWN_TYPE], [&=
quot;windows&quot;])</span><br><span> 		CPPFLAGS=3D&quot;${CPPFLAGS} -DWIN3=
2_LEAN_AND_MEAN&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
		CPPFLAGS=3D&quot;${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=
=3D_WIN32_WINNT_VISTA&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+		CPPFLAGS=3D&quot;${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_WIN10 -D_WIN=
32_WINNT=3D_WIN32_WINNT_WIN10&quot;</span><br><span> 		WIN32=3Dyes</span><b=
r><span> 		;;</span><br><span> 	*-*-dragonfly*)</span><br><span>@@ -1397,4 =
+1397,4 @@</span><br><span> # Put the warning at the end, so it is better v=
isible</span><br><span> if test &quot;${enable_debug}&quot; =3D &quot;yes&q=
uot;; then</span><br><span>     AC_MSG_WARN([--enable-developer-debug is en=
abled=2E This should be only used for test/development builds and not for p=
roduction usage])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</=
span><br><span>\ No newline at end of file</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+fi</span><br><span>diff --git a/src/openvpn/dco_win=
=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index 90cff8c=2E=2Ebd94c1a 1=
00644</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/s=
rc/openvpn/dco_win=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> #=
include &quot;openvpn=2Eh&quot;</span><br><span> </span><br><span> #include=
 &lt;bcrypt=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &lt;ioapiset=2Eh&gt;</span><br><span> #include &lt;winsock2=2Eh&gt=
;</span><br><span> #include &lt;ws2tcpip=2Eh&gt;</span><br><span> </span><b=
r><span>@@ -222,17 +223,6 @@</span><br><span> dco_connect_wait(HANDLE handl=
e, OVERLAPPED *ov, int timeout, struct signal_info *sig_info)</span><br><sp=
an> {</span><br><span>     volatile int *signal_received =3D &amp;sig_info-=
&gt;signal_received;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* GetOverlappedResultEx is available starting from Windows 8 */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    typedef BOOL(WINAPI * get=
_overlapped_result_ex_t)(HANDLE, LPOVERLAPPED, LPDWORD, DWORD, BOOL);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    get_overlapped_result_e=
x_t get_overlapped_result_ex =3D</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        (get_overlapped_result_ex_t)GetProcAddress(GetModuleHand=
le(&quot;Kernel32=2Edll&quot;),</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                                   &quot;GetOverl=
appedResultEx&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (get_overlappe=
d_result_ex =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M=
_ERR, &quot;Failed to load GetOverlappedResult()&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span>     DWORD timeout_msec =3D timeout * 1=
000;</span><br><span>     const int poll_interval_ms =3D 50;</span><br><spa=
n> </span><br><span>@@ -241,7 +231,7 @@</span><br><span>         timeout_ms=
ec -=3D poll_interval_ms;</span><br><span> </span><br><span>         DWORD =
transferred;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (get_overlapped_result_ex(handle, ov, &amp;transferred, poll_interval_ms,=
 FALSE) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (GetOverlappedResultEx(handle, ov, &amp;transferred, poll_interval_m=
s, FALSE) !=3D 0)</span><br><span>         {</span><br><span>             /=
* TCP connection established by dco */</span><br><span>             return;=
</span><br><span>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec=
</span><br><span>index 82341f8=2E=2Efde6412 100644</span><br><span>--- a/sr=
c/openvpn/win32=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</span><br><=
span>@@ -37,6 +37,7 @@</span><br><span> #include &lt;winsock2=2Eh&gt;</span=
><br><span> #include &lt;accctrl=2Eh&gt;</span><br><span> #include &lt;acla=
pi=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&lt;wow64apiset=2Eh&gt;</span><br><span> </span><br><span> #include &quot;b=
uffer=2Eh&quot;</span><br><span> #include &quot;error=2Eh&quot;</span><br><=
span>@@ -1334,67 +1335,47 @@</span><br><span> static void</span><br><span> =
win32_get_arch(arch_t *process_arch, arch_t *host_arch)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *process_arch =3D =
ARCH_UNKNOWN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *hos=
t_arch =3D ARCH_NATIVE;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    typedef BOOL(WI=
NAPI * is_wow64_process2_t)(HANDLE, USHORT *, USHORT *);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    is_wow64_process2_t is_wow64_process=
2 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (is_wow6=
4_process2_t)GetProcAddress(GetModuleHandle(&quot;Kernel32=2Edll&quot;), &q=
uot;IsWow64Process2&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> #ifdef _ARM64_</span><br><span>     *process_arch =
=3D ARCH_ARM64;</span><br><span> #elif defined(_WIN64)</span><br><span>    =
 *process_arch =3D ARCH_AMD64;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (is_wow64_process2)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      /* this could be amd64 on arm64 */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        USHORT process_machine =3D 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        USHORT native_machine =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        BOOL is_wow64 =3D=
 is_wow64_process2(GetCurrentProcess(), &amp;process_machine, &amp;native_m=
achine);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (i=
s_wow64 &amp;&amp; native_machine =3D=3D IMAGE_FILE_MACHINE_ARM64)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            *host_arch =3D ARCH_ARM64;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#elif defined(_WIN32)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#else</span><br><span>     *process_arch =3D ARCH_X=
86;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (is_wo=
w64_process2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *h=
ost_arch =3D ARCH_NATIVE;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Determine if we&#39;re running on a different host-arch */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    USHORT process_mach=
ine =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    USHOR=
T native_machine =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!IsWow6=
4Process2(GetCurrentProcess(), &amp;process_machine, &amp;native_machine))<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        /* check if we&#39;re running on arm64 or amd64 machine */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        USHORT process_machin=
e =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        USHOR=
T native_machine =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        BOOL is_wow64 =3D is_wow64_process2(GetCurrentProcess(), &amp;pro=
cess_machine, &amp;native_machine);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (is_wow64)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            switch (native_machine)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                case IMAGE_FILE_MACHINE_ARM64:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    *host_arch =3D ARCH_AR=
M64;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                case IMAGE_FILE_M=
ACHINE_AMD64:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            *host_arch =3D ARCH_AMD64;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    break;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                default:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    *host_arch =3D ARCH_UNKNOWN;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    break;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        return;</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    switch (native_machine)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        BOOL w64 =3D FALSE;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        BOOL is_wow64 =3D IsWow64P=
rocess(GetCurrentProcess(), &amp;w64) &amp;&amp; w64;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (is_wow64)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            /* we are unable to differentiate between a=
rm64 and amd64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
      * machines here, so assume we are running on amd64 */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        case IMAGE_FILE_MACHINE_ARM=
64:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *hos=
t_arch =3D ARCH_ARM64;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case IMAG=
E_FILE_MACHINE_AMD64:</span><br><span>             *host_arch =3D ARCH_AMD6=
4;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        case IMAGE_FILE_MACHINE_I386:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            *host_arch =3D ARCH=
_X86;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            br=
eak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            *host_arch =3D ARCH_UNKNO=
WN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            brea=
k;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif /* _ARM64_ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (*host_=
arch =3D=3D *process_arch)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 *host_arch =3D ARCH_NATIVE;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span> }</span><br><span> </span><br><span> static=
 void</span><br><span>diff --git a/src/openvpnmsica/CMakeLists=2Etxt b/src/=
openvpnmsica/CMakeLists=2Etxt</span><br><span>index 9126b80=2E=2E06889c8 10=
0644</span><br><span>--- a/src/openvpnmsica/CMakeLists=2Etxt</span><br><spa=
n>+++ b/src/openvpnmsica/CMakeLists=2Etxt</span><br><span>@@ -24,7 +24,7 @@=
</span><br><span> target_compile_options(openvpnmsica PRIVATE</span><br><sp=
an>     -D_UNICODE</span><br><span>     -UNTDDI_VERSION</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    -D_WIN32_WINNT=3D=
_WIN32_WINNT_WIN10</span><br><span>     )</span><br><span> </span><br><span=
> if (MSVC)</span><br><span>diff --git a/src/openvpnmsica/Makefile=2Eam b/s=
rc/openvpnmsica/Makefile=2Eam</span><br><span>index 87bf9a7=2E=2E5e7838f 10=
0644</span><br><span>--- a/src/openvpnmsica/Makefile=2Eam</span><br><span>+=
++ b/src/openvpnmsica/Makefile=2Eam</span><br><span>@@ -34,8 +34,7 @@</span=
><br><span> lib_LTLIBRARIES =3D libopenvpnmsica=2Ela</span><br><span> libop=
envpnmsica_la_CFLAGS =3D \</span><br><span> 	-municode -D_UNICODE \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	-UNTDDI_VERSION -U_WIN32_WIN=
NT \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-D_WIN32_WINNT=
=3D_WIN32_WINNT_VISTA \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	-UNTDDI_VERSION -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10 \</span><br><span>=
 	-Wl,--kill-at</span><br><span> libopenvpnmsica_la_LDFLAGS =3D -ladvapi32 =
-lole32 -lmsi -lsetupapi -liphlpapi -lshell32 -lshlwapi -lversion -lnewdev =
-no-undefined -avoid-version</span><br><span> endif</span><br><span>diff --=
git a/src/openvpnserv/CMakeLists=2Etxt b/src/openvpnserv/CMakeLists=2Etxt</=
span><br><span>index fc15382=2E=2E2cc4a93 100644</span><br><span>--- a/src/=
openvpnserv/CMakeLists=2Etxt</span><br><span>+++ b/src/openvpnserv/CMakeLis=
ts=2Etxt</span><br><span>@@ -21,7 +21,7 @@</span><br><span>     target_comp=
ile_options(${target} PRIVATE</span><br><span>         -D_UNICODE</span><br=
><span>         -UNTDDI_VERSION</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        -D_WIN32_WINNT=3D_WIN32_WINNT_WIN=
10</span><br><span>     )</span><br><span>     target_link_libraries(${targ=
et} PRIVATE</span><br><span>         advapi32=2Elib userenv=2Elib iphlpapi=
=2Elib fwpuclnt=2Elib rpcrt4=2Elib</span><br><span>diff --git a/src/openvpn=
serv/Makefile=2Eam b/src/openvpnserv/Makefile=2Eam</span><br><span>index ac=
97eb4=2E=2E447fb10 100644</span><br><span>--- a/src/openvpnserv/Makefile=2E=
am</span><br><span>+++ b/src/openvpnserv/Makefile=2Eam</span><br><span>@@ -=
23,8 +23,7 @@</span><br><span> sbin_PROGRAMS =3D openvpnserv</span><br><spa=
n> openvpnserv_CFLAGS =3D \</span><br><span> 	-municode -D_UNICODE \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	-UNTDDI_VERSION -U_WIN32_WI=
NNT \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-D_WIN32_WINNT=
=3D_WIN32_WINNT_VISTA</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	-UNTDDI_VERSION -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10</span><br><span> ope=
nvpnserv_LDADD =3D \</span><br><span> 	-ladvapi32 -luserenv -liphlpapi -lfw=
puclnt -lrpcrt4 \</span><br><span> 	-lshlwapi -lnetapi32 -lws2_32 -lntdll -=
lole32 -lpathcch</span><br><span>diff --git a/src/tapctl/CMakeLists=2Etxt b=
/src/tapctl/CMakeLists=2Etxt</span><br><span>index 97702c0=2E=2E94453ed 100=
644</span><br><span>--- a/src/tapctl/CMakeLists=2Etxt</span><br><span>+++ b=
/src/tapctl/CMakeLists=2Etxt</span><br><span>@@ -21,10 +21,10 @@</span><br>=
<span> target_compile_options(tapctl PRIVATE</span><br><span>     -D_UNICOD=
E</span><br><span>     -UNTDDI_VERSION</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    -D_WIN32_WINNT=3D_WIN32_WINNT_WIN1=
0</span><br><span>     )</span><br><span> target_link_libraries(tapctl</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    advapi32=2Elib ole32=
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
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">cha=
nge 1955</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1955 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>

</body></html>
--fItHzaA4UFE=--


--===============1574991747033127290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1574991747033127290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1574991747033127290==--

