Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C816C61DCB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oXXVJ5Y1JwaTPiZ2cfSYA8Ta0mLJGtv/IYmb/dW5Fkg=; b=aEjP/n9rXjqG9+HMq/9v+23bqW
	+yTNhaRedpIj1URIxZMTxunhdnOfCyrfbIXYtIC/P7xhrlz1mrWgc5QUYXQYtAgfp9j+D0Xfr0gOo
	hT+fLKUpck1u/ESRvb/X9dEC5JhpvI2kJLWJS4w/xfuzOM7MNEGpZgUy0zISvxdSpibU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzuP8-0003wx-AV;
	Fri, 28 Aug 2026 11:05:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzuOu-0003vd-Ep
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 11:05:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mRGbt9ZzZzo1etB5upUGt/K0OMIkTiayCAcLdEmyWbc=; b=FPguBWVP6kMtL11VBTh55FiNor
 jrvoGR3wRTxOyLrLe+tuq7hUGcuukupalAk7Osh1ImO5KKfTqofY2FU+r+nk8BoFF9hFGpwXtHXLE
 WnJib+HIEiSJ3HWfAPrw1P0pMCQDKUrsaZ6k9Z+hVLVQJlC0nGX26Bi1k2H1F12m9K/Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mRGbt9ZzZzo1etB5upUGt/K0OMIkTiayCAcLdEmyWbc=; b=g
 fDrmB0NOSgNwLgqxN+7129LtIwPj8DXJE7vOTtnBOE2013r1mWugAexQ5MNBUFliXSUYYYAVvOV1G
 bvmfkKBkRiRtqpLs6Narl4d+Ux/xvqA4dgF8XwOLGT1ae4M3ruvLg8PsgN2Zs5d3BQXltjny3pY7q
 +O70tCmBadEuQNdU=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzuOs-0002Ke-68 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 11:05:37 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so4427625e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 04:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787915127; x=1788519927; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mRGbt9ZzZzo1etB5upUGt/K0OMIkTiayCAcLdEmyWbc=;
 b=GA1I1T9VI2qyAmUzFkTBRiY4vQ8CjexURYoDuT5v3lPyniPkPUTeKelfDkDp9R6eQa
 XrXv2ncLrFR/vu3fO7q6fPa77BtKZAGOgTPFq6wTWQgIwEsVqSSCmbfr3TnOBEMj3O3T
 hiTKmWc1Ok1S+ni58r5jZwByGTSP4ZpRHcb++JERR3Isu5UoftRxLpRoxVWfqfHvIbSx
 eYK3f4iOBrmBUA1CXgqgyi5AFfj2Jy5oXAu28CaTWDXcEQi6GcwF+/2IoOoa49Mw7p5m
 FCAS4UmhbUBRDw9BOKjAy6bic2GsjBhCE8tu5Tr7D+s3ze6vMUpI0xloMWRMaH4pGYX2
 N9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787915127; x=1788519927;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mRGbt9ZzZzo1etB5upUGt/K0OMIkTiayCAcLdEmyWbc=;
 b=KG3fIM0XiD3lq3k0+zSLJh7/HM2FUxCPHhIFYAmZxhbpsyz8cYqVu3vQ+XSMsHWpUA
 An9d1Z9avccnqyr2UsBMMe1lkA0hIXAEa6G2rBo4hpYO8V7hdaJErTKTIDjKx7cUDc83
 D8RFrjEGmemq2Cv8pboHfhI5Bhr4YP1gjhi5QaQRb7AgTGuTBFQ0UmPytJd4maFpfjjd
 uksCfmKX0QE691cKstkOHl37oGRYRMaLTvsOKAJ8Tyfy6xWo9uPZI82GW5NqRbpNOXTW
 h1cLHVqbrG0y7Ld7gXvfFRMn9EY6ubgCrJsiioecM6MAw+F5Z1c9Z6DkfbxkvkGmqPp6
 uenA==
X-Gm-Message-State: AFuF++kkY9VhTroU7j1eQ2jwzDOs/i3dMyh27355HxlaaJEp9FPr2HBl
 qc/4trEeZgjDH0wMbEXvBzcNO/ECl9WkGuixr4icw7pbJxfXNCN1Il2z5BixH+C2mfo1pKlBh8I
 UExvo1eB0193Z0iMG+5NO/vUoySNv9Ni1V/RJfjSSy8RS7bCULsk0nKs7UyiCoQTzColB
X-Gm-Gg: AR+sD12x81LWOxDMHmzag/ytbjsnhFDrZ0+S8jza/e3+Y06QK1CMzdaS+npSbQeY3DN
 axTK3iiYCIiXoIdCWWu84/oVkpkrv4HkqUGdHFcXG4hITHFo+8QYPjtUEhAvJTu71PSJRr293iK
 coT2f2MBAv0F3Ex2IrOF/0Hc6tTf5EfXcYHeMJceT7rwSr9nCrNpxcIZa38ejOB9uex8PHr7vzR
 jOuhS+Nj8OyYEHf7AHouXoG41QQzacBJ+wocjiNgfJD/HZwdTfuDBROz37FAFEJa/L4js7IAQ4x
 mpa4hPt6KJxKd8lgt0R+HKpEYFUoq7FBkJTDmJ0WbLn08iG8/aFCY2N2g5zeFgmRhHFtKkowvcE
 Adz2cKrOLeDAvjEmRgoDB+NOuqNQu7QAMrGkAHt4+FiKzQd6bkQ0smI4HlvFr32E7gPIZqpc+Gp
 xnvXAPxAiIDLMY3TOmVxtjPPrT9jmZMfG0tHl5KxZJzgj2n+6++RGaKvKzQ7HK35JB0Pk6pzCdL
 ayR5zmsLlNusN36AdNoJmYBpImohDX2zkY1wP7IFRu8xPU5DQ7bRHRPicwNdse0I1pVde0XmUx4
 O5ic+Vq2xEi0j7KC4aRKCJAbeTNh86WwzI7/7owiItfNzlCXBxk=
X-Received: by 2002:a05:600c:1f82:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-49b91c19d37mr93775465e9.2.1787915127230; 
 Fri, 28 Aug 2026 04:05:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9266be71sm110315795e9.2.2026.08.28.04.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:05:26 -0700 (PDT)
X-Google-Original-From: "srkyn (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 11:05:25 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: af724b68aea7ad161492da8aad1cd8a5ff456bd5
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bb0fda2926cd3af7d1f15f9be5ae93f62551509a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzuOs-0002Ke-68
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
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
From: "srkyn \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: david@srkyn.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "srkyn \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0460555997535309873=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0460555997535309873==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QLHfMF5VMKU="; charset=UTF-8

--QLHfMF5VMKU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc, srkyn=2E

Hello p=
laisthos, razvanc, 

I'd like you to reexamine a change=2E Please visit

  =
  http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail

to look at th=
e new patch set (#2)=2E

The following approvals got outdated and were remo=
ved:
Code-Review-1 by razvanc


Change subject: compat: close all unrelated=
 fds in forked helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

compat: close all unrelated fds in forked helpers

The forked au=
th-pam, down-root, and port-share helpers only closed
descriptor numbers 3 =
through 100=2E Descriptors above that range could
remain open in long-lived=
 helper processes, including helpers that
intentionally retain privilege=2E=


Add a shared compatibility helper that uses close_range() when available
=
and falls back to the process descriptor limit=2E Preserve the helper
comma=
nd socket and add coverage for both low and high preserved
descriptors=2E

=
Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
Signed-off-by: David S=
arkisyan <david@srkyn=2Ecom>
---
M CMakeLists=2Etxt
M configure=2Eac
M src/=
compat/Makefile=2Eam
A src/compat/close-fds=2Ec
A src/compat/close-fds=2Eh
=
M src/openvpn/ps=2Ec
M src/plugins/auth-pam/Makefile=2Eam
M src/plugins/aut=
h-pam/auth-pam=2Ec
M src/plugins/down-root/Makefile=2Eam
M src/plugins/down=
-root/down-root=2Ec
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_t=
ests/openvpn/test_close_fds=2Ec
12 files changed, 305 insertions(+), 74 del=
etions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/81/1881/2

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 2c332=
4d=2E=2Eb17cbdb 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -42=
4,6 +424,8 @@
     src/compat/compat-gettimeofday=2Ec
     src/compat/compa=
t-strsep=2Ec
     src/compat/compat-strtok_r=2Ec
+    src/compat/close-fds=
=2Ec
+    src/compat/close-fds=2Eh
     src/openvpn/argv=2Ec
     src/openv=
pn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -691,6 +693,10 @@
         list(=
APPEND unit_tests
             "test_cryptoapi"
             )
+    else ()=

+        list(APPEND unit_tests
+            "test_close_fds"
+           =
 )
     endif ()
 
     # MSVC and Apple's LLVM ld do not support --wrap
@@=
 -841,6 +847,13 @@
         src/openvpn/mbuf=2Ec
         )
 
+    if (TARG=
ET test_close_fds)
+        target_sources(test_close_fds PRIVATE
+        =
    tests/unit_tests/openvpn/mock_get_random=2Ec
+            src/compat/cl=
ose-fds=2Ec
+            )
+    endif ()
+
     target_sources(test_misc PR=
IVATE
         tests/unit_tests/openvpn/mock_get_random=2Ec
         tests/=
unit_tests/openvpn/test_schedule=2Ec
diff --git a/configure=2Eac b/configur=
e=2Eac
index 469a475=2E=2Ebaa185a 100644
--- a/configure=2Eac
+++ b/configu=
re=2Eac
@@ -567,7 +567,7 @@
 	syslog openlog mlockall getrlimit getgrnam se=
tgid \
 	setgroups flock gettimeofday \
 	setsid chdir \
-	chsize ftruncate=
 execve getpeereid basename dirname \
+	chsize ftruncate execve getpeereid =
basename dirname close_range \
 	epoll_create strsep strtok_r \
 ])
 
diff =
--git a/src/compat/Makefile=2Eam b/src/compat/Makefile=2Eam
index 22867b3=
=2E=2E12c3f95 100644
--- a/src/compat/Makefile=2Eam
+++ b/src/compat/Makefi=
le=2Eam
@@ -16,9 +16,10 @@
 
 libcompat_la_SOURCES =3D \
 	compat=2Eh \
+	c=
lose-fds=2Ec close-fds=2Eh \
 	compat-dirname=2Ec \
 	compat-basename=2Ec \=

 	compat-gettimeofday=2Ec \
 	compat-daemon=2Ec \
 	compat-strsep=2Ec \
-	=
compat-strtok_r=2Ec
\ No newline at end of file
+	compat-strtok_r=2Ec
diff =
--git a/src/compat/close-fds=2Ec b/src/compat/close-fds=2Ec
new file mode 1=
00644
index 0000000=2E=2E1c157af
--- /dev/null
+++ b/src/compat/close-fds=
=2Ec
@@ -0,0 +1,68 @@
+/*
+ *  OpenVPN -- An application to securely tunnel=
 IP networks
+ *             over a single UDP port, with support for SSL/T=
LS-based
+ *             session authentication and key exchange,
+ *      =
       packet encryption, packet authentication, and
+ *             packet=
 compression=2E
+ *
+ *  Copyright (C) 2026 David Sarkisyan
+ *
+ *  This p=
rogram is free software; you can redistribute it and/or modify
+ *  it unde=
r the terms of the GNU General Public License version 2
+ *  as published b=
y the Free Software Foundation=2E
+ *
+ *  This program is distributed in t=
he hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even=
 the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR P=
URPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
=
+ *  You should have received a copy of the GNU General Public License alon=
g
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#ifndef =
_WIN32
+
+#include "close-fds=2Eh"
+
+#include <unistd=2Eh>
+#include <sysl=
og=2Eh>
+
+void
+close_fds_except(int keep)
+{
+    closelog();
+
+#ifdef H=
AVE_CLOSE_RANGE
+    if (keep >=3D 3)
+    {
+        const int lower_close=
d =3D keep =3D=3D 3 || close_range(3, (unsigned int)keep - 1, 0) =3D=3D 0;
=
+        if (lower_closed && close_range((unsigned int)keep + 1, ~0U, 0) =
=3D=3D 0)
+        {
+            return;
+        }
+    }
+    else if (c=
lose_range(3, ~0U, 0) =3D=3D 0)
+    {
+        return;
+    }
+#endif
+
+ =
   long max_fd =3D sysconf(_SC_OPEN_MAX);
+    if (max_fd < 0)
+    {
+    =
    max_fd =3D 1024;
+    }
+    for (long i =3D 3; i < max_fd; ++i)
+    {=

+        if (i !=3D keep)
+        {
+            close((int)i);
+        =
}
+    }
+}
+
+#endif /* !_WIN32 */
diff --git a/src/compat/close-fds=2Eh b=
/src/compat/close-fds=2Eh
new file mode 100644
index 0000000=2E=2E35fe7de
-=
-- /dev/null
+++ b/src/compat/close-fds=2Eh
@@ -0,0 +1,38 @@
+/*
+ *  OpenV=
PN -- An application to securely tunnel IP networks
+ *             over a =
single UDP port, with support for SSL/TLS-based
+ *             session aut=
hentication and key exchange,
+ *             packet encryption, packet aut=
hentication, and
+ *             packet compression=2E
+ *
+ *  Copyright (=
C) 2026 David Sarkisyan
+ *
+ *  This program is free software; you can red=
istribute it and/or modify
+ *  it under the terms of the GNU General Publi=
c License version 2
+ *  as published by the Free Software Foundation=2E
+ =
*
+ *  This program is distributed in the hope that it will be useful,
+ * =
 but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHA=
NTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General =
Public License for more details=2E
+ *
+ *  You should have received a copy=
 of the GNU General Public License along
+ *  with this program; if not, se=
e <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef CLOSE_FDS_H
+#defi=
ne CLOSE_FDS_H
+
+#ifndef _WIN32
+/**
+ * Close descriptors inherited acros=
s fork that are unrelated to a helper=2E
+ *
+ * Standard input, standard o=
utput, standard error, and @p keep remain open=2E
+ * All other file descri=
ptors starting at 3 are closed=2E
+ *
+ * @param keep file descriptor used =
for communication with the parent process
+ */
+void close_fds_except(int k=
eep);
+#endif
+
+#endif /* CLOSE_FDS_H */
diff --git a/src/openvpn/ps=2Ec b=
/src/openvpn/ps=2Ec
index be91a99=2E=2Edbe5a1e 100644
--- a/src/openvpn/ps=
=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -33,6 +33,7 @@
 #include "fdmisc=2Eh"
 #in=
clude "crypto=2Eh"
 #include "ps=2Eh"
+#include "close-fds=2Eh"
 
 #include=
 "memdbg=2Eh"
 
@@ -96,30 +97,6 @@
 }
 
 /*
- * Close most of parent's fds=
=2E
- * Keep stdin/stdout/stderr, plus one
- * other fd which is presumed t=
o be
- * our pipe back to parent=2E
- * Admittedly, a bit of a kludge,
- * =
but posix doesn't give us a kind
- * of FD_CLOEXEC which will stop
- * fds =
from crossing a fork()=2E
- */
-static void
-close_fds_except(int keep)
-{
=
-    socket_descriptor_t i;
-    closelog();
-    for (i =3D 3; i <=3D 100;=
 ++i)
-    {
-        if (i !=3D keep)
-        {
-            openvpn_clos=
e_socket(i);
-        }
-    }
-}
-
-/*
  * Usually we ignore signals, beca=
use our parent will
  * deal with them=2E
  */
diff --git a/src/plugins/aut=
h-pam/Makefile=2Eam b/src/plugins/auth-pam/Makefile=2Eam
index e6dc27e=2E=
=2Efb7fd30 100644
--- a/src/plugins/auth-pam/Makefile=2Eam
+++ b/src/plugin=
s/auth-pam/Makefile=2Eam
@@ -9,6 +9,7 @@
 
 AM_CFLAGS =3D \
 	-I$(top_srcdi=
r)/include \
+	-I$(top_srcdir)/src/compat \
 	$(PLUGIN_AUTH_PAM_CFLAGS) \
 =
	$(OPTIONAL_CRYPTO_CFLAGS)
 
@@ -23,6 +24,7 @@
 	pamdl=2Ec  pamdl=2Eh \
 	a=
uth-pam=2Eexports
 openvpn_plugin_auth_pam_la_LIBADD =3D \
+	$(top_builddir=
)/src/compat/libcompat=2Ela \
 	$(PLUGIN_AUTH_PAM_LIBS)
 openvpn_plugin_aut=
h_pam_la_LDFLAGS =3D $(AM_LDFLAGS) \
 	-export-symbols "$(srcdir)/auth-pam=
=2Eexports" \
diff --git a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/=
auth-pam/auth-pam=2Ec
index 948b6af=2E=2E04bb7d8 100644
--- a/src/plugins/a=
uth-pam/auth-pam=2Ec
+++ b/src/plugins/auth-pam/auth-pam=2Ec
@@ -51,6 +51,8=
 @@
 #include <arpa/inet=2Eh>
 #include <openvpn-plugin=2Eh>
 
+#include "c=
lose-fds=2Eh"
+
 #define DEBUG(verb) ((verb) >=3D 4)
 
 /* Command codes fo=
r foreground -> background communication */
@@ -240,30 +242,6 @@
 #endif /*=
 ifdef DO_DAEMONIZE */
 
 /*
- * Close most of parent's fds=2E
- * Keep std=
in/stdout/stderr, plus one
- * other fd which is presumed to be
- * our pip=
e back to parent=2E
- * Admittedly, a bit of a kludge,
- * but posix doesn'=
t give us a kind
- * of FD_CLOEXEC which will stop
- * fds from crossing a =
fork()=2E
- */
-static void
-close_fds_except(int keep)
-{
-    int i;
-   =
 closelog();
-    for (i =3D 3; i <=3D 100; ++i)
-    {
-        if (i !=3D=
 keep)
-        {
-            close(i);
-        }
-    }
-}
-
-/*
  * Usu=
ally we ignore signals, because our parent will
  * deal with them=2E
  */
=
diff --git a/src/plugins/down-root/Makefile=2Eam b/src/plugins/down-root/Ma=
kefile=2Eam
index 7ca5a4e=2E=2E83bc04f 100644
--- a/src/plugins/down-root/M=
akefile=2Eam
+++ b/src/plugins/down-root/Makefile=2Eam
@@ -9,6 +9,7 @@
 
 A=
M_CFLAGS =3D \
 	-I$(top_srcdir)/include \
+	-I$(top_srcdir)/src/compat \
 =
	$(OPTIONAL_CRYPTO_CFLAGS)
 
 if ENABLE_PLUGIN_DOWN_ROOT
@@ -19,6 +20,8 @@
=
 openvpn_plugin_down_root_la_SOURCES =3D \
 	down-root=2Ec \
 	down-root=2E=
exports
+openvpn_plugin_down_root_la_LIBADD =3D \
+	$(top_builddir)/src/com=
pat/libcompat=2Ela
 openvpn_plugin_down_root_la_LDFLAGS =3D $(AM_LDFLAGS) \=

 	-export-symbols "$(srcdir)/down-root=2Eexports" \
 	-module -shared -avo=
id-version -no-undefined
diff --git a/src/plugins/down-root/down-root=2Ec b=
/src/plugins/down-root/down-root=2Ec
index cd57189=2E=2Ef0ee7ea 100644
--- =
a/src/plugins/down-root/down-root=2Ec
+++ b/src/plugins/down-root/down-root=
=2Ec
@@ -44,6 +44,8 @@
 
 #include <openvpn-plugin=2Eh>
 
+#include "close-=
fds=2Eh"
+
 #define DEBUG(verb) ((verb) >=3D 7)
 
 /* Command codes for for=
eground -> background communication */
@@ -191,30 +193,6 @@
 }
 
 /*
- * Cl=
ose most of parent's fds=2E
- * Keep stdin/stdout/stderr, plus one
- * othe=
r fd which is presumed to be
- * our pipe back to parent=2E
- * Admittedly,=
 a bit of a kludge,
- * but posix doesn't give us a kind
- * of FD_CLOEXEC =
which will stop
- * fds from crossing a fork()=2E
- */
-static void
-close_=
fds_except(int keep)
-{
-    int i;
-    closelog();
-    for (i =3D 3; i <=
=3D 100; ++i)
-    {
-        if (i !=3D keep)
-        {
-            clos=
e(i);
-        }
-    }
-}
-
-/*
  * Usually we ignore signals, because our=
 parent will
  * deal with them=2E
  */
diff --git a/tests/unit_tests/openv=
pn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 6db611e=2E=
=2E68e224f 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/=
unit_tests/openvpn/Makefile=2Eam
@@ -23,6 +23,10 @@
 	ssl_testdriver \
 	us=
er_pass_testdriver
 
+if !WIN32
+test_binaries +=3D close_fds_testdriver
+e=
ndif
+
 if HAVE_LD_WRAP_SUPPORT
 if !WIN32
 test_binaries +=3D tls_crypt_te=
stdriver
@@ -45,6 +49,11 @@
 endif
 check_PROGRAMS =3D $(test_binaries)
 
+=
close_fds_testdriver_CFLAGS =3D -I$(top_srcdir)/src/compat @TEST_CFLAGS@
+c=
lose_fds_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+close_fds_testdriver_SOURCE=
S =3D test_close_fds=2Ec
+close_fds_testdriver_LDADD =3D $(top_builddir)/sr=
c/compat/libcompat=2Ela
+
 if HAVE_SITNL
 check_PROGRAMS +=3D networking_te=
stdriver
 endif
diff --git a/tests/unit_tests/openvpn/test_close_fds=2Ec b/=
tests/unit_tests/openvpn/test_close_fds=2Ec
new file mode 100644
index 0000=
000=2E=2E1ee4798
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_close_fd=
s=2Ec
@@ -0,0 +1,164 @@
+/*
+ *  OpenVPN -- An application to securely tunn=
el IP networks
+ *             over a single UDP port, with support for SSL=
/TLS-based
+ *             session authentication and key exchange,
+ *    =
         packet encryption, packet authentication, and
+ *             pack=
et compression=2E
+ *
+ *  Copyright (C) 2026 David Sarkisyan
+ *
+ *  This=
 program is free software; you can redistribute it and/or modify
+ *  it un=
der the terms of the GNU General Public License version 2
+ *  as published=
 by the Free Software Foundation=2E
+ *
+ *  This program is distributed in=
 the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without ev=
en the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ =
*
+ *  You should have received a copy of the GNU General Public License al=
ong
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include=
 "close-fds=2Eh"
+#include "test_common=2Eh"
+
+#include <errno=2Eh>
+#incl=
ude <fcntl=2Eh>
+#include <sys/socket=2Eh>
+#include <sys/wait=2Eh>
+#inclu=
de <unistd=2Eh>
+
+static int
+fd_is_closed(int fd)
+{
+    errno =3D 0;
+ =
   return fcntl(fd, F_GETFD) =3D=3D -1 && errno =3D=3D EBADF;
+}
+
+static =
int
+fd_is_open(int fd)
+{
+    return fcntl(fd, F_GETFD) !=3D -1;
+}
+
+st=
atic int
+run_case(int keep_target)
+{
+    int control[2];
+    if (socket=
pair(AF_UNIX, SOCK_STREAM, 0, control) < 0)
+    {
+        return EXIT_FAI=
LURE;
+    }
+
+    const pid_t pid =3D fork();
+    if (pid < 0)
+    {
+ =
       return EXIT_FAILURE;
+    }
+
+    if (pid =3D=3D 0)
+    {
+       =
 close(control[0]);
+
+        int keep =3D control[1];
+        if (keep_t=
arget >=3D 3 && keep_target !=3D keep)
+        {
+            if (dup2(kee=
p, keep_target) < 0)
+            {
+                _exit(EXIT_FAILURE);
+=
            }
+            close(keep);
+            keep =3D keep_target;
=
+        }
+
+        const int source =3D open("/dev/null", O_RDWR);
+    =
    if (source < 0)
+        {
+            _exit(EXIT_FAILURE);
+        }=

+        for (int fd =3D STDIN_FILENO; fd <=3D STDERR_FILENO; ++fd)
+     =
   {
+            if (dup2(source, fd) < 0)
+            {
+               =
 _exit(EXIT_FAILURE);
+            }
+        }
+        if (dup2(source, 1=
00) < 0 || dup2(source, 200) < 0)
+        {
+            _exit(EXIT_FAILUR=
E);
+        }
+        if (source > STDERR_FILENO && source !=3D keep)
+  =
      {
+            close(source);
+        }
+
+        close_fds_except(=
keep);
+
+        const char result =3D fd_is_open(STDIN_FILENO) && fd_is_o=
pen(STDOUT_FILENO)
+                                    && fd_is_open(STDER=
R_FILENO) && fd_is_closed(100)
+                                    && fd_i=
s_closed(200)
+                                ? '1'
+                     =
           : '0';
+        if (write(keep, &result, sizeof(result)) !=3D si=
zeof(result))
+        {
+            _exit(EXIT_FAILURE);
+        }
+    =
    close(keep);
+        _exit(result =3D=3D '1' ? EXIT_SUCCESS : EXIT_FAI=
LURE);
+    }
+
+    close(control[1]);
+    char result =3D '0';
+    cons=
t ssize_t size =3D read(control[0], &result, sizeof(result));
+    close(co=
ntrol[0]);
+
+    int status =3D 0;
+    if (waitpid(pid, &status, 0) !=3D =
pid)
+    {
+        return EXIT_FAILURE;
+    }
+
+    return size =3D=3D =
sizeof(result) && result =3D=3D '1' && WIFEXITED(status)
+                 =
  && WEXITSTATUS(status) =3D=3D EXIT_SUCCESS
+               ? EXIT_SUCCESS=

+               : EXIT_FAILURE;
+}
+
+static void
+test_close_fds_default_=
keep(void **state)
+{
+    (void)state;
+    assert_int_equal(run_case(-1),=
 EXIT_SUCCESS);
+}
+
+static void
+test_close_fds_keep_three(void **state)
=
+{
+    (void)state;
+    assert_int_equal(run_case(3), EXIT_SUCCESS);
+}
+=

+static void
+test_close_fds_keep_middle(void **state)
+{
+    (void)state=
;
+    assert_int_equal(run_case(150), EXIT_SUCCESS);
+}
+
+int
+main(void)=

+{
+    openvpn_unit_test_setup();
+    const struct CMUnitTest tests[] =
=3D {
+        cmocka_unit_test(test_close_fds_default_keep),
+        cmoc=
ka_unit_test(test_close_fds_keep_three),
+        cmocka_unit_test(test_clo=
se_fds_keep_middle),
+    };
+
+    return cmocka_run_group_tests_name("clo=
se_fds", tests, NULL, NULL);
+}

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1881?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
Gerrit-Change-Numb=
er: 1881
Gerrit-PatchSet: 2
Gerrit-Owner: srkyn <david@srkyn=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: srkyn <david@srkyn=2Ecom>
Gerrit-Attention: razvanc <razvanc=
@mailbox=2Eorg>

--QLHfMF5VMKU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc, srkyn=2E </p>
<p>srkyn <strong>up=
loaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">View Change</a></p><p>The =
following approvals got outdated and were removed:
Code-Review-1 by razvanc=
</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">compat: close all unrelated fds in forked helpers<br><br>=
The forked auth-pam, down-root, and port-share helpers only closed<br>descr=
iptor numbers 3 through 100=2E Descriptors above that range could<br>remain=
 open in long-lived helper processes, including helpers that<br>intentional=
ly retain privilege=2E<br><br>Add a shared compatibility helper that uses c=
lose_range() when available<br>and falls back to the process descriptor lim=
it=2E Preserve the helper<br>command socket and add coverage for both low a=
nd high preserved<br>descriptors=2E<br><br>Change-Id: Iacd56d245e9ab30cfb25=
b2b364ca661fa289dc55<br>Signed-off-by: David Sarkisyan &lt;david@srkyn=2Eco=
m&gt;<br>---<br>M CMakeLists=2Etxt<br>M configure=2Eac<br>M src/compat/Make=
file=2Eam<br>A src/compat/close-fds=2Ec<br>A src/compat/close-fds=2Eh<br>M =
src/openvpn/ps=2Ec<br>M src/plugins/auth-pam/Makefile=2Eam<br>M src/plugins=
/auth-pam/auth-pam=2Ec<br>M src/plugins/down-root/Makefile=2Eam<br>M src/pl=
ugins/down-root/down-root=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Eam<b=
r>A tests/unit_tests/openvpn/test_close_fds=2Ec<br>12 files changed, 305 in=
sertions(+), 74 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/1881/2</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 2c3324d=2E=2Eb1=
7cbdb 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/C=
MakeLists=2Etxt</span><br><span>@@ -424,6 +424,8 @@</span><br><span>     sr=
c/compat/compat-gettimeofday=2Ec</span><br><span>     src/compat/compat-str=
sep=2Ec</span><br><span>     src/compat/compat-strtok_r=2Ec</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    src/compat/close-fds=2Ec</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    src/compat/close-fds=
=2Eh</span><br><span>     src/openvpn/argv=2Ec</span><br><span>     src/ope=
nvpn/argv=2Eh</span><br><span>     src/openvpn/base64=2Ec</span><br><span>@=
@ -691,6 +693,10 @@</span><br><span>         list(APPEND unit_tests</span><=
br><span>             &quot;test_cryptoapi&quot;</span><br><span>          =
   )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else ()</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        list(APPEND uni=
t_tests</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&quot;test_close_fds&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            )</span><br><span>     endif ()</span><br><span> </span>=
<br><span>     # MSVC and Apple&#39;s LLVM ld do not support --wrap</span><=
br><span>@@ -841,6 +847,13 @@</span><br><span>         src/openvpn/mbuf=2Ec=
</span><br><span>         )</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (TARGET test_close_fds)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        target_sources(test_close_fds =
PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            src/compat/close-fds=2Ec</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            )</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    endif ()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     target_sources(test_misc=
 PRIVATE</span><br><span>         tests/unit_tests/openvpn/mock_get_random=
=2Ec</span><br><span>         tests/unit_tests/openvpn/test_schedule=2Ec</s=
pan><br><span>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>=
index 469a475=2E=2Ebaa185a 100644</span><br><span>--- a/configure=2Eac</spa=
n><br><span>+++ b/configure=2Eac</span><br><span>@@ -567,7 +567,7 @@</span>=
<br><span> 	syslog openlog mlockall getrlimit getgrnam setgid \</span><br><=
span> 	setgroups flock gettimeofday \</span><br><span> 	setsid chdir \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	chsize ftruncate execve g=
etpeereid basename dirname \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	chsize ftruncate execve getpeereid basename dirname close_range \=
</span><br><span> 	epoll_create strsep strtok_r \</span><br><span> ])</span=
><br><span> </span><br><span>diff --git a/src/compat/Makefile=2Eam b/src/co=
mpat/Makefile=2Eam</span><br><span>index 22867b3=2E=2E12c3f95 100644</span>=
<br><span>--- a/src/compat/Makefile=2Eam</span><br><span>+++ b/src/compat/M=
akefile=2Eam</span><br><span>@@ -16,9 +16,10 @@</span><br><span> </span><br=
><span> libcompat_la_SOURCES =3D \</span><br><span> 	compat=2Eh \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	close-fds=2Ec close-fds=2Eh =
\</span><br><span> 	compat-dirname=2Ec \</span><br><span> 	compat-basename=
=2Ec \</span><br><span> 	compat-gettimeofday=2Ec \</span><br><span> 	compat=
-daemon=2Ec \</span><br><span> 	compat-strsep=2Ec \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	compat-strtok_r=2Ec</span><br><span>\ No n=
ewline at end of file</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	compat-strtok_r=2Ec</span><br><span>diff --git a/src/compat/close-fds=2E=
c b/src/compat/close-fds=2Ec</span><br><span>new file mode 100644</span><br=
><span>index 0000000=2E=2E1c157af</span><br><span>--- /dev/null</span><br><=
span>+++ b/src/compat/close-fds=2Ec</span><br><span>@@ -0,0 +1,68 @@</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single UDP port, with support for SSL/TLS-based</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session au=
thentication and key exchange,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet encryption, packet authentication, and</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet c=
ompression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 =
David Sarkisyan</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is f=
ree software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lic=
enses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;close-fds=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;=
unistd=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &lt;syslog=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+close_fds_except(int keep)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    closelog();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifdef HAVE_CLOSE_RANGE</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (keep &gt;=3D 3)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        const int lower_closed =3D keep =3D=3D 3 || close_range(3, (un=
signed int)keep - 1, 0) =3D=3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (lower_closed &amp;&amp; close_range((unsigned int=
)keep + 1, ~0U, 0) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (close_range(=
3, ~0U, 0) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    long max_fd =3D sysconf(_SC_OPEN_MAX);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (max_fd &lt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        max_fd =3D 1024;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (long i =3D 3; i &lt; max_fd; ++i)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (i !=3D keep)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            close((int)i);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif /* !_WIN32 */</span><br><spa=
n>diff --git a/src/compat/close-fds=2Eh b/src/compat/close-fds=2Eh</span><b=
r><span>new file mode 100644</span><br><span>index 0000000=2E=2E35fe7de</sp=
an><br><span>--- /dev/null</span><br><span>+++ b/src/compat/close-fds=2Eh</=
span><br><span>@@ -0,0 +1,38 @@</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  O=
penVPN -- An application to securely tunnel IP networks</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, =
with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             session authentication and key exchange,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryp=
tion, packet authentication, and</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             packet compression=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  Copyright (C) 2026 David Sarkisyan</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is free software; you can redistribute it=
 and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  i=
t under the terms of the GNU General Public License version 2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Soft=
ware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s distributed in the hope that it will be useful,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Li=
cense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not,=
 see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnd=
ef CLOSE_FDS_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne CLOSE_FDS_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Close descriptors inherited across fork th=
at are unrelated to a helper=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * St=
andard input, standard output, standard error, and @p keep remain open=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * All other file des=
criptors starting at 3 are closed=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param keep file descriptor used for communication with the parent proce=
ss</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void close_fds_except(int keep);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif /* CLOSE_FDS_H */</span><br><span>diff --git =
a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index be91a99=2E=
=2Edbe5a1e 100644</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>=
+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -33,6 +33,7 @@</span><br><span>=
 #include &quot;fdmisc=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh=
&quot;</span><br><span> #include &quot;ps=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;close-fds=2Eh&quot;</span>=
<br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><spa=
n> </span><br><span>@@ -96,30 +97,6 @@</span><br><span> }</span><br><span> =
</span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* Close most of parent&#39;s fds=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Keep stdin/stdout/stderr, plus one</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * other fd which is presumed to be</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * our pipe back to parent=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Admittedly, a bit =
of a kludge,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * but po=
six doesn&#39;t give us a kind</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * of FD_CLOEXEC which will stop</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * fds from crossing a fork()=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-close_fds_except(int keep)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    socket_=
descriptor_t i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cl=
oselog();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =
=3D 3; i &lt;=3D 100; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(i !=3D keep)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            openvpn_=
close_socket(i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/*</span><br><span>  * Usually we ignore signals, because our parent will<=
/span><br><span>  * deal with them=2E</span><br><span>  */</span><br><span>=
diff --git a/src/plugins/auth-pam/Makefile=2Eam b/src/plugins/auth-pam/Make=
file=2Eam</span><br><span>index e6dc27e=2E=2Efb7fd30 100644</span><br><span=
>--- a/src/plugins/auth-pam/Makefile=2Eam</span><br><span>+++ b/src/plugins=
/auth-pam/Makefile=2Eam</span><br><span>@@ -9,6 +9,7 @@</span><br><span> </=
span><br><span> AM_CFLAGS =3D \</span><br><span> 	-I$(top_srcdir)/include \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/sr=
c/compat \</span><br><span> 	$(PLUGIN_AUTH_PAM_CFLAGS) \</span><br><span> 	=
$(OPTIONAL_CRYPTO_CFLAGS)</span><br><span> </span><br><span>@@ -23,6 +24,7 =
@@</span><br><span> 	pamdl=2Ec  pamdl=2Eh \</span><br><span> 	auth-pam=2Eex=
ports</span><br><span> openvpn_plugin_auth_pam_la_LIBADD =3D \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	$(top_builddir)/src/compat/libc=
ompat=2Ela \</span><br><span> 	$(PLUGIN_AUTH_PAM_LIBS)</span><br><span> ope=
nvpn_plugin_auth_pam_la_LDFLAGS =3D $(AM_LDFLAGS) \</span><br><span> 	-expo=
rt-symbols &quot;$(srcdir)/auth-pam=2Eexports&quot; \</span><br><span>diff =
--git a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=
=2Ec</span><br><span>index 948b6af=2E=2E04bb7d8 100644</span><br><span>--- =
a/src/plugins/auth-pam/auth-pam=2Ec</span><br><span>+++ b/src/plugins/auth-=
pam/auth-pam=2Ec</span><br><span>@@ -51,6 +51,8 @@</span><br><span> #includ=
e &lt;arpa/inet=2Eh&gt;</span><br><span> #include &lt;openvpn-plugin=2Eh&gt=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;close-fds=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> #define DEBUG(verb) ((verb) &gt;=3D 4)</sp=
an><br><span> </span><br><span> /* Command codes for foreground -&gt; backg=
round communication */</span><br><span>@@ -240,30 +242,6 @@</span><br><span=
> #endif /* ifdef DO_DAEMONIZE */</span><br><span> </span><br><span> /*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * Close most of parent&#=
39;s fds=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Keep st=
din/stdout/stderr, plus one</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * other fd which is presumed to be</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * our pipe back to parent=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * Admittedly, a bit of a kludge,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * but posix doesn&#39;t give us a =
kind</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * of FD_CLOEXEC =
which will stop</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * fds=
 from crossing a fork()=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-close_fds_except(int ke=
ep)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    closelog();</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    for (i =3D 3; i &lt;=3D 100; ++i)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (i !=3D keep)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            close(i);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/*</span><br><span>  * Usually we ignore signals, because =
our parent will</span><br><span>  * deal with them=2E</span><br><span>  */<=
/span><br><span>diff --git a/src/plugins/down-root/Makefile=2Eam b/src/plug=
ins/down-root/Makefile=2Eam</span><br><span>index 7ca5a4e=2E=2E83bc04f 1006=
44</span><br><span>--- a/src/plugins/down-root/Makefile=2Eam</span><br><spa=
n>+++ b/src/plugins/down-root/Makefile=2Eam</span><br><span>@@ -9,6 +9,7 @@=
</span><br><span> </span><br><span> AM_CFLAGS =3D \</span><br><span> 	-I$(t=
op_srcdir)/include \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	-I$(top_srcdir)/src/compat \</span><br><span> 	$(OPTIONAL_CRYPTO_CFLAGS)<=
/span><br><span> </span><br><span> if ENABLE_PLUGIN_DOWN_ROOT</span><br><sp=
an>@@ -19,6 +20,8 @@</span><br><span> openvpn_plugin_down_root_la_SOURCES =
=3D \</span><br><span> 	down-root=2Ec \</span><br><span> 	down-root=2Eexpor=
ts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_plugin_do=
wn_root_la_LIBADD =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	$(top_builddir)/src/compat/libcompat=2Ela</span><br><span> openvpn_plu=
gin_down_root_la_LDFLAGS =3D $(AM_LDFLAGS) \</span><br><span> 	-export-symb=
ols &quot;$(srcdir)/down-root=2Eexports&quot; \</span><br><span> 	-module -=
shared -avoid-version -no-undefined</span><br><span>diff --git a/src/plugin=
s/down-root/down-root=2Ec b/src/plugins/down-root/down-root=2Ec</span><br><=
span>index cd57189=2E=2Ef0ee7ea 100644</span><br><span>--- a/src/plugins/do=
wn-root/down-root=2Ec</span><br><span>+++ b/src/plugins/down-root/down-root=
=2Ec</span><br><span>@@ -44,6 +44,8 @@</span><br><span> </span><br><span> #=
include &lt;openvpn-plugin=2Eh&gt;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;close-fds=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #define =
DEBUG(verb) ((verb) &gt;=3D 7)</span><br><span> </span><br><span> /* Comman=
d codes for foreground -&gt; background communication */</span><br><span>@@=
 -191,30 +193,6 @@</span><br><span> }</span><br><span> </span><br><span> /*=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Close most of pare=
nt&#39;s fds=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Kee=
p stdin/stdout/stderr, plus one</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * other fd which is presumed to be</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * our pipe back to parent=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Admittedly, a bit of a kludge,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * but posix doesn&#39;t give u=
s a kind</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * of FD_CLOE=
XEC which will stop</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 fds from crossing a fork()=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-close_fds_except(in=
t keep)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    closelog();</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    for (i =3D 3; i &lt;=3D 100; ++i)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (i !=3D keep)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            close(i);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/*</span><br><span>  * Usually we ignore signals, be=
cause our parent will</span><br><span>  * deal with them=2E</span><br><span=
>  */</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b=
/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 6db611e=2E=2E=
68e224f 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam=
</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><sp=
an>@@ -23,6 +23,10 @@</span><br><span> 	ssl_testdriver \</span><br><span> 	=
user_pass_testdriver</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+if !WIN32</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_binaries +=3D close_fds_testdriver</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> if HAVE_LD_WRAP_SUPPORT</span><br><span> i=
f !WIN32</span><br><span> test_binaries +=3D tls_crypt_testdriver</span><br=
><span>@@ -45,6 +49,11 @@</span><br><span> endif</span><br><span> check_PRO=
GRAMS =3D $(test_binaries)</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+close_fds_testdriver_CFLAGS =3D -I$(top_srcdir)/sr=
c/compat @TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+close_fds_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+close_fds_testdriver_SOURCES =3D test_close_=
fds=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+close_fds_te=
stdriver_LDADD =3D $(top_builddir)/src/compat/libcompat=2Ela</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if HAVE_SITNL</s=
pan><br><span> check_PROGRAMS +=3D networking_testdriver</span><br><span> e=
ndif</span><br><span>diff --git a/tests/unit_tests/openvpn/test_close_fds=
=2Ec b/tests/unit_tests/openvpn/test_close_fds=2Ec</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2E1ee4798</span><br><span>---=
 /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_close_fds=2E=
c</span><br><span>@@ -0,0 +1,164 @@</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  OpenVPN -- An application to securely tunnel IP networks</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP po=
rt, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             session authentication and key exchange,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet en=
cryption, packet authentication, and</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2026 David Sarkisyan</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  This program is free software; you can redistribute =
it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 it under the terms of the GNU General Public License version 2</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free So=
ftware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program=
 is distributed in the hope that it will be useful,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publi=
c License for more details=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You=
 should have received a copy of the GNU General Public License along</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;close=
-fds=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &lt;errno=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &lt;fcntl=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &lt;sys/socket=2Eh&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &lt;sys/wait=2Eh&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;unistd=2Eh&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+fd_is_closed(int fd)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errn=
o =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
fcntl(fd, F_GETFD) =3D=3D -1 &amp;&amp; errno =3D=3D EBADF;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fd_is_=
open(int fd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return fcntl(fd, F_GE=
TFD) !=3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+run_case(int keep_target)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int control[2];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, control) &lt; 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return EXIT_FAILURE;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const pid_t pid =3D fork();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (pid &lt; 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return EXIT_FAILURE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pi=
d =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(control[=
0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        int keep =3D control[1];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (keep_targ=
et &gt;=3D 3 &amp;&amp; keep_target !=3D keep)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (dup2(keep, keep_target) &lt; 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                _exit(EXIT_FAILURE);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            close(keep);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            keep =3D=
 keep_target;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const int source =3D open(&=
quot;/dev/null&quot;, O_RDWR);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (source &lt; 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            _exit(EXIT_FAILURE);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        for (int fd =3D STDIN_FILENO; fd &lt;=3D STDERR_FILENO; =
++fd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (dup2(sou=
rce, fd) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       _exit(EXIT_FAILURE);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (dup2(source, 100) &lt; 0 || dup2(source, 200) &lt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            _exit(EXIT_FAILURE);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (source &gt; STDERR_FILENO &amp;&=
amp; source !=3D keep)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     close(source);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        close_fds_except(keep=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const char result =3D fd_is_=
open(STDIN_FILENO) &amp;&amp; fd_is_open(STDOUT_FILENO)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                    &am=
p;&amp; fd_is_open(STDERR_FILENO) &amp;&amp; fd_is_closed(100)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
    &amp;&amp; fd_is_closed(200)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                ? &#39;1&#39;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                : &#=
39;0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (write(keep, &amp;result, sizeof(result)) !=3D sizeof(result))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            _exit(EXIT_FAILURE);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        close(keep);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        _exit(result =3D=3D &#39;1&#=
39; ? EXIT_SUCCESS : EXIT_FAILURE);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    close(control=
[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char resul=
t =3D &#39;0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const ssize_t size =3D read(control[0], &amp;result, sizeof(result));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    close(control[0]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int status =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (waitpid(pid, &amp;status, 0)=
 !=3D pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return EXIT_FAI=
LURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return size =3D=3D sizeof(result) &amp;&amp=
; result =3D=3D &#39;1&#39; &amp;&amp; WIFEXITED(status)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                   &amp;&amp; WEXITSTA=
TUS(status) =3D=3D EXIT_SUCCESS</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+               ? EXIT_SUCCESS</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+               : EXIT_FAILURE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_close_=
fds_default_keep(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (vo=
id)state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(run_case(-1), EXIT_SUCCESS);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_close_fds_keep_three=
(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)state;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(run_c=
ase(3), EXIT_SUCCESS);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_close_fds_keep_middle(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    (void)state;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(run_case(150), EXIT_=
SUCCESS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+main(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_uni=
t_test_setup();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct CMUnitTest tests[] =3D {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_close_fds_default_keep),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_close_fds_keep_three),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_close_fds_keep_middle),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return cmocka_run_group_tests_name(&quot;close_fds&quot;=
, tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">change 1881</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iacd56d245e9ab=
30cfb25b2b364ca661fa289dc55 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1881 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: srkyn &lt;david@srkyn=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--QLHfMF5VMKU=--


--===============0460555997535309873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0460555997535309873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0460555997535309873==--

