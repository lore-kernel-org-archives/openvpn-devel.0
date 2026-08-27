Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE62C61DB9
	for <openvpn-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=oByJPKwKjXNhgbTRCzN+/oK9BVbvSvAXFz38ZxvRspg=; b=F2y/JEQC+9P1L7
	joKpYiOj3CC/y0lEhNIP6400soUG3AbjRJmYQopapZsNWefGiTG/Q8EDiOmq3+rKo2xAJwnGpLwzH
	OC4CdgZuH3U/mLvbvuCzJnwsC+m0/l4+QSRL0Wc+dTCzaXwwxtZDekA4g34LMA0xPlQ/uZTQkb8zN
	6H8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzdNO-0004Wq-11;
	Thu, 27 Aug 2026 16:54:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzdNL-0004Wc-O4
 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 16:54:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RPkziTj8Cwn65SzrAXQLXpO4ZWhbMhsAAHhDRPpdyhM=; b=RZW1sRSxC1ACFYhowErhBOXhNF
 d19fRdnhiJs7jOBO+gMCzb3+9HF+Y1rXyb+zYRnM/WFRPOC4EexvdWDeMIrZxiQr/jshhfu9dkBBv
 Eb7FYBrbITylw4EA3LMBX+tQ7O2jX/nMcfA7H6kAPfIrfeHuVlbISG4AkNtPiFOl7z3E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RPkziTj8Cwn65SzrAXQLXpO4ZWhbMhsAAHhDRPpdyhM=; b=Z
 4G1rkc14OLlieBtbw3q4IRtj9J8b7n8l1siV+YfIcUOLOWNEYVXAiPi2r/xOjRLyvTGsbe9KdovUP
 uMIeRp3tS4wpdJ90sbjrm9rE1mYNXP+jTQ4Zh6DdQxulnlNRK+fnOEiGcDiiT3371SbpWo8SmfLw6
 QBcv10bgH/LyuNNg=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzdNI-0004l1-8T for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 16:54:50 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so26984f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787849682; x=1788454482; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RPkziTj8Cwn65SzrAXQLXpO4ZWhbMhsAAHhDRPpdyhM=;
 b=JWFgaDDubXozBFHgP1NrV8i/LVUiH1B3e3hQSjFzj/KeYPKzM02Wh4nDc4lByOi4Hg
 bp1UrENADjFoJYfYAmAbfA8xoHaDHKJMvIckQ7QKYE4dNaO9OVSwBwl1CAMpfSnPW3zq
 jb9C6S1VkoHA35wcuQzTx/bZT0/rMq6ZUy2Sjn+f/kJFBXn929SntCudYe7TopXP6iqt
 dDGYf9LEgXQlGY/M0JlH19JDlkSWBXr9Ec7jKzfTO7rOXGcPxKpMeVpbcpWxjQ30tt7o
 d+ym1txppN4GqnfwgQf8JX4Dez4ZOB6cmur0dmuTJuUpNXfA5JgK88WtEoeGvB43pEjC
 GENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787849682; x=1788454482;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RPkziTj8Cwn65SzrAXQLXpO4ZWhbMhsAAHhDRPpdyhM=;
 b=FRYijevVGPMBXHb8jjeVKGCGSU+r8wmzJn9xmEu75oWGui8lZBCxL/bD9z2+V2dv+J
 q5kbW+pRYh6wJBZIuK+H5Ztrwy7pNcD0dSUvSmT9oHWtzLSKhFWMwEsX0ux8iQBgDe97
 7vRPt/oJTxF+ZvGIQiQVkiJH4giLEg7J58d7fCcbdLwwUmmJ9C7eiE5saeHO+uwra6gP
 dG9pVODAzFZ+VhAfe146y8ev/+KGSp44HLbQNxLMAhMZ6p90p0n+/GQVkdoiCBLMYgCQ
 ZDfjWpp1bbwM84HyEg5Y0E6JyzIObGwFb29STVUKnJGa+hCcREbiCZsFiMpoJYRT9y9j
 cZuw==
X-Gm-Message-State: AFuF++mDnkBrL/2EWvTpV/AcODPWEmNibgqEalscygDiars7Mn5dOs6/
 dcHNKytCD5hRn1DTDSHYfh82x3lS3qaMS/PLpAgKam1QJiTfsIT4I2M8EhvoHI46H6hIJi7XiLh
 8hd0unNLhI90/cODWAvGYEnRyDj7cqbZEJ+ug1o7gzWS7DhhcOe9sM4n+ezbQ7/uEWqTipoDdml
 Guav3L2w==
X-Gm-Gg: AR+sD12mMjpgAM//hRfnR4zEpA2WBaHmzs92JfV1w7zZgf+rEGFD1ht0kwC+LqDCfSK
 xm7oywK6EgGvHPbC0fOrrwNCSulfzYMVvSADKGDzZWotoDDyf8izaJI6QxGgSxmEMVk1fKFC2Wn
 7cZGJ7C/hE6HCHpoejmyON+X9b6vw0XSz8EsBQ+HrvA2+eBW1HppM69Wv80qL6/Khs5dpbyrvYD
 iURqkgzD9eG1RHghU7tZgN+h9I05zcN0jhJgXVfaEAHWFJHwLF5iBVOdDtW2rVQ2rO8SB77PV9c
 QVp7/upRc4tyyw1BVHIjkYCuqKeuZqA1n8qsEXtHaDYoPCOP7WvL+mTBVitnh0mjJF83RVcqe9G
 MT0bRq3dGiD3Px8yTQ7e2FGsjbOquRKhFWYZVOvTgqCMz8FiBm6F/hZclVdyX5pO77byZUhJlqM
 5lFjk6RnygR7vKtuZAml9XDcu2K7LXVAlTOfGTCvKgE4TTTlmlV8IT1PsnQMlk1bB/7nKRUhw4E
 BHfxHSSXNRqLZo70us5hk6B5s31/hMXXhSGKhbx5I1YwhhKJmpiCiOHi+4y+TTXAQoxuSWoGNHW
 PVIS7wu4YlK73rcs6r80vI75w9s7b/tE6yBfsH36ungKhyr7YvI=
X-Received: by 2002:a5d:5f0a:0:b0:481:5b58:c589 with SMTP id
 ffacd0b85a97d-482f79bf555mr169454f8f.10.1787849681301; 
 Thu, 27 Aug 2026 09:54:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28e899dsm10473768f8f.28.2026.08.27.09.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 09:54:40 -0700 (PDT)
X-Google-Original-From: "srkyn (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 27 Aug 2026 16:54:40 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: af300510350e2496a17f0e3e07ae22107bb42d5a
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c0c5e40d030b5705d337e3bb9c47e5a3f5dbd165-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzdNI-0004l1-8T
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
Reply-To: david@srkyn.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "srkyn \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6108025484260319117=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6108025484260319117==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wa9EZ9spfLA="; charset=UTF-8

--wa9EZ9spfLA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1881?usp=3Demail

to review the following change=2E


Chang=
e subject: compat: close all unrelated fds in forked helpers
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

compat: close all unrelat=
ed fds in forked helpers

The forked auth-pam, down-root, and port-share he=
lpers only closed
descriptor numbers 3 through 100=2E Descriptors above tha=
t range could
remain open in long-lived helper processes, including helpers=
 that
intentionally retain privilege=2E

Add a shared compatibility helper =
that uses close_range() when available
and falls back to the process descri=
ptor limit=2E Preserve the helper
command socket and add coverage for both =
low and high preserved
descriptors=2E

Change-Id: Iacd56d245e9ab30cfb25b2b3=
64ca661fa289dc55
Signed-off-by: David Sarkisyan <david@srkyn=2Ecom>
---
M c=
onfigure=2Eac
M src/compat/Makefile=2Eam
A src/compat/close-fds=2Ec
A src/c=
ompat/close-fds=2Eh
M src/openvpn/ps=2Ec
M src/plugins/auth-pam/Makefile=2E=
am
M src/plugins/auth-pam/auth-pam=2Ec
M src/plugins/down-root/Makefile=2Ea=
m
M src/plugins/down-root/down-root=2Ec
M tests/unit_tests/openvpn/Makefile=
=2Eam
A tests/unit_tests/openvpn/test_close_fds=2Ec
11 files changed, 214 i=
nsertions(+), 74 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/81/1881/1

diff --git a/configure=2Eac b/configure=
=2Eac
index 469a475=2E=2Ebaa185a 100644
--- a/configure=2Eac
+++ b/configur=
e=2Eac
@@ -567,7 +567,7 @@
 	syslog openlog mlockall getrlimit getgrnam set=
gid \
 	setgroups flock gettimeofday \
 	setsid chdir \
-	chsize ftruncate =
execve getpeereid basename dirname \
+	chsize ftruncate execve getpeereid b=
asename dirname close_range \
 	epoll_create strsep strtok_r \
 ])
 
diff -=
-git a/src/compat/Makefile=2Eam b/src/compat/Makefile=2Eam
index 22867b3=2E=
=2E12c3f95 100644
--- a/src/compat/Makefile=2Eam
+++ b/src/compat/Makefile=
=2Eam
@@ -16,9 +16,10 @@
 
 libcompat_la_SOURCES =3D \
 	compat=2Eh \
+	clo=
se-fds=2Ec close-fds=2Eh \
 	compat-dirname=2Ec \
 	compat-basename=2Ec \
 =
	compat-gettimeofday=2Ec \
 	compat-daemon=2Ec \
 	compat-strsep=2Ec \
-	co=
mpat-strtok_r=2Ec
\ No newline at end of file
+	compat-strtok_r=2Ec
diff --=
git a/src/compat/close-fds=2Ec b/src/compat/close-fds=2Ec
new file mode 100=
644
index 0000000=2E=2Eadb6180
--- /dev/null
+++ b/src/compat/close-fds=2Ec=

@@ -0,0 +1,60 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP =
networks
+ *             over a single UDP port, with support for SSL/TLS-b=
ased
+ *             session authentication and key exchange,
+ *          =
   packet encryption, packet authentication, and
+ *             packet com=
pression=2E
+ *
+ *  Copyright (C) 2026 David Sarkisyan
+ *
+ *  This progr=
am is free software; you can redistribute it and/or modify
+ *  it under th=
e terms of the GNU General Public License version 2
+ *  as published by th=
e Free Software Foundation=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "confi=
g=2Eh"
+#endif
+
+#ifndef _WIN32
+
+#include "close-fds=2Eh"
+
+#include <u=
nistd=2Eh>
+#include <syslog=2Eh>
+
+void
+close_fds_except(int keep)
+{
+ =
   closelog();
+
+#ifdef HAVE_CLOSE_RANGE
+    if (keep >=3D 3)
+    {
+   =
     const int lower_closed =3D keep =3D=3D 3 || close_range(3, (unsigned i=
nt)keep - 1, 0) =3D=3D 0;
+        if (lower_closed && close_range((unsigne=
d int)keep + 1, ~0U, 0) =3D=3D 0)
+        {
+            return;
+        =
}
+    }
+    else if (close_range(3, ~0U, 0) =3D=3D 0)
+    {
+        ret=
urn;
+    }
+#endif
+
+    long max_fd =3D sysconf(_SC_OPEN_MAX);
+    if (=
max_fd < 0)
+    {
+        max_fd =3D 1024;
+    }
+    for (long i =3D 3;=
 i < max_fd; ++i)
+    {
+        if (i !=3D keep)
+        {
+            =
close((int)i);
+        }
+    }
+}
+
+#endif /* !_WIN32 */
diff --git a/sr=
c/compat/close-fds=2Eh b/src/compat/close-fds=2Eh
new file mode 100644
inde=
x 0000000=2E=2E5b1c667
--- /dev/null
+++ b/src/compat/close-fds=2Eh
@@ -0,0=
 +1,22 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks=

+ *             over a single UDP port, with support for SSL/TLS-based
+ *=
             session authentication and key exchange,
+ *             packe=
t encryption, packet authentication, and
+ *             packet compression=
=2E
+ *
+ *  Copyright (C) 2026 David Sarkisyan
+ *
+ *  This program is fr=
ee software; you can redistribute it and/or modify
+ *  it under the terms =
of the GNU General Public License version 2
+ *  as published by the Free S=
oftware Foundation=2E
+ */
+
+#ifndef CLOSE_FDS_H
+#define CLOSE_FDS_H
+
+#=
ifndef _WIN32
+void close_fds_except(int keep);
+#endif
+
+#endif /* CLOSE_=
FDS_H */
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index be91a99=
=2E=2Edbe5a1e 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -=
33,6 +33,7 @@
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
 #include "ps=
=2Eh"
+#include "close-fds=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -96,30 +97,6 =
@@
 }
 
 /*
- * Close most of parent's fds=2E
- * Keep stdin/stdout/stderr,=
 plus one
- * other fd which is presumed to be
- * our pipe back to parent=
=2E
- * Admittedly, a bit of a kludge,
- * but posix doesn't give us a kind=

- * of FD_CLOEXEC which will stop
- * fds from crossing a fork()=2E
- */
-=
static void
-close_fds_except(int keep)
-{
-    socket_descriptor_t i;
-   =
 closelog();
-    for (i =3D 3; i <=3D 100; ++i)
-    {
-        if (i !=3D=
 keep)
-        {
-            openvpn_close_socket(i);
-        }
-    }
-=
}
-
-/*
  * Usually we ignore signals, because our parent will
  * deal wit=
h them=2E
  */
diff --git a/src/plugins/auth-pam/Makefile=2Eam b/src/plugin=
s/auth-pam/Makefile=2Eam
index e6dc27e=2E=2Efb7fd30 100644
--- a/src/plugin=
s/auth-pam/Makefile=2Eam
+++ b/src/plugins/auth-pam/Makefile=2Eam
@@ -9,6 +=
9,7 @@
 
 AM_CFLAGS =3D \
 	-I$(top_srcdir)/include \
+	-I$(top_srcdir)/src=
/compat \
 	$(PLUGIN_AUTH_PAM_CFLAGS) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 
@@ -2=
3,6 +24,7 @@
 	pamdl=2Ec  pamdl=2Eh \
 	auth-pam=2Eexports
 openvpn_plugin_=
auth_pam_la_LIBADD =3D \
+	$(top_builddir)/src/compat/libcompat=2Ela \
 	$(=
PLUGIN_AUTH_PAM_LIBS)
 openvpn_plugin_auth_pam_la_LDFLAGS =3D $(AM_LDFLAGS)=
 \
 	-export-symbols "$(srcdir)/auth-pam=2Eexports" \
diff --git a/src/plug=
ins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec
index 948b6af=
=2E=2E04bb7d8 100644
--- a/src/plugins/auth-pam/auth-pam=2Ec
+++ b/src/plug=
ins/auth-pam/auth-pam=2Ec
@@ -51,6 +51,8 @@
 #include <arpa/inet=2Eh>
 #inc=
lude <openvpn-plugin=2Eh>
 
+#include "close-fds=2Eh"
+
 #define DEBUG(verb=
) ((verb) >=3D 4)
 
 /* Command codes for foreground -> background communic=
ation */
@@ -240,30 +242,6 @@
 #endif /* ifdef DO_DAEMONIZE */
 
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
diff --git a/src/plugins/down-root/=
Makefile=2Eam b/src/plugins/down-root/Makefile=2Eam
index 7ca5a4e=2E=2E83bc=
04f 100644
--- a/src/plugins/down-root/Makefile=2Eam
+++ b/src/plugins/down=
-root/Makefile=2Eam
@@ -9,6 +9,7 @@
 
 AM_CFLAGS =3D \
 	-I$(top_srcdir)/in=
clude \
+	-I$(top_srcdir)/src/compat \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 
 if EN=
ABLE_PLUGIN_DOWN_ROOT
@@ -19,6 +20,8 @@
 openvpn_plugin_down_root_la_SOURCE=
S =3D \
 	down-root=2Ec \
 	down-root=2Eexports
+openvpn_plugin_down_root_l=
a_LIBADD =3D \
+	$(top_builddir)/src/compat/libcompat=2Ela
 openvpn_plugin_=
down_root_la_LDFLAGS =3D $(AM_LDFLAGS) \
 	-export-symbols "$(srcdir)/down-=
root=2Eexports" \
 	-module -shared -avoid-version -no-undefined
diff --git=
 a/src/plugins/down-root/down-root=2Ec b/src/plugins/down-root/down-root=2E=
c
index cd57189=2E=2Ef0ee7ea 100644
--- a/src/plugins/down-root/down-root=
=2Ec
+++ b/src/plugins/down-root/down-root=2Ec
@@ -44,6 +44,8 @@
 
 #includ=
e <openvpn-plugin=2Eh>
 
+#include "close-fds=2Eh"
+
 #define DEBUG(verb) (=
(verb) >=3D 7)
 
 /* Command codes for foreground -> background communicati=
on */
@@ -191,30 +193,6 @@
 }
 
 /*
- * Close most of parent's fds=2E
- * K=
eep stdin/stdout/stderr, plus one
- * other fd which is presumed to be
- * =
our pipe back to parent=2E
- * Admittedly, a bit of a kludge,
- * but posix=
 doesn't give us a kind
- * of FD_CLOEXEC which will stop
- * fds from cros=
sing a fork()=2E
- */
-static void
-close_fds_except(int keep)
-{
-    int =
i;
-    closelog();
-    for (i =3D 3; i <=3D 100; ++i)
-    {
-        if =
(i !=3D keep)
-        {
-            close(i);
-        }
-    }
-}
-
-/*
=
  * Usually we ignore signals, because our parent will
  * deal with them=
=2E
  */
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_t=
ests/openvpn/Makefile=2Eam
index 6db611e=2E=2E68e224f 100644
--- a/tests/un=
it_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam=

@@ -23,6 +23,10 @@
 	ssl_testdriver \
 	user_pass_testdriver
 
+if !WIN32
=
+test_binaries +=3D close_fds_testdriver
+endif
+
 if HAVE_LD_WRAP_SUPPORT
=
 if !WIN32
 test_binaries +=3D tls_crypt_testdriver
@@ -45,6 +49,11 @@
 end=
if
 check_PROGRAMS =3D $(test_binaries)
 
+close_fds_testdriver_CFLAGS =3D =
-I$(top_srcdir)/src/compat @TEST_CFLAGS@
+close_fds_testdriver_LDFLAGS =3D =
@TEST_LDFLAGS@
+close_fds_testdriver_SOURCES =3D test_close_fds=2Ec
+close_=
fds_testdriver_LDADD =3D $(top_builddir)/src/compat/libcompat=2Ela
+
 if HA=
VE_SITNL
 check_PROGRAMS +=3D networking_testdriver
 endif
diff --git a/tes=
ts/unit_tests/openvpn/test_close_fds=2Ec b/tests/unit_tests/openvpn/test_cl=
ose_fds=2Ec
new file mode 100644
index 0000000=2E=2E177e054
--- /dev/null
+=
++ b/tests/unit_tests/openvpn/test_close_fds=2Ec
@@ -0,0 +1,110 @@
+/*
+ * =
 OpenVPN -- An application to securely tunnel IP networks
+ *             o=
ver a single UDP port, with support for SSL/TLS-based
+ *             sessi=
on authentication and key exchange,
+ *             packet encryption, pack=
et authentication, and
+ *             packet compression=2E
+ *
+ *  Copyr=
ight (C) 2026 David Sarkisyan
+ *
+ *  This program is free software; you c=
an redistribute it and/or modify
+ *  it under the terms of the GNU General=
 Public License version 2
+ *  as published by the Free Software Foundation=
=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include=
 "close-fds=2Eh"
+
+#include <errno=2Eh>
+#include <fcntl=2Eh>
+#include <s=
tdlib=2Eh>
+#include <sys/socket=2Eh>
+#include <sys/wait=2Eh>
+#include <u=
nistd=2Eh>
+
+static int
+fd_is_closed(int fd)
+{
+    errno =3D 0;
+    re=
turn fcntl(fd, F_GETFD) =3D=3D -1 && errno =3D=3D EBADF;
+}
+
+static int
+=
run_case(int keep_target)
+{
+    int control[2];
+    if (socketpair(AF_UN=
IX, SOCK_STREAM, 0, control) < 0)
+    {
+        return EXIT_FAILURE;
+   =
 }
+
+    const pid_t pid =3D fork();
+    if (pid < 0)
+    {
+        ret=
urn EXIT_FAILURE;
+    }
+
+    if (pid =3D=3D 0)
+    {
+        close(con=
trol[0]);
+
+        int keep =3D control[1];
+        if (keep_target >=3D=
 3 && keep_target !=3D keep)
+        {
+            if (dup2(keep, keep_ta=
rget) < 0)
+            {
+                _exit(EXIT_FAILURE);
+          =
  }
+            close(keep);
+            keep =3D keep_target;
+        }=

+
+        const int source =3D open("/dev/null", O_RDONLY);
+        if (=
source < 0 || dup2(source, 100) < 0 || dup2(source, 200) < 0)
+        {
+ =
           _exit(EXIT_FAILURE);
+        }
+        if (source !=3D keep)
+=
        {
+            close(source);
+        }
+
+        close_fds_excep=
t(keep);
+
+        const char result =3D fd_is_closed(100) && fd_is_closed=
(200) ? '1' : '0';
+        if (write(keep, &result, sizeof(result)) !=3D s=
izeof(result))
+        {
+            _exit(EXIT_FAILURE);
+        }
+   =
     close(keep);
+        _exit(result =3D=3D '1' ? EXIT_SUCCESS : EXIT_FA=
ILURE);
+    }
+
+    close(control[1]);
+    char result =3D '0';
+    con=
st ssize_t size =3D read(control[0], &result, sizeof(result));
+    close(c=
ontrol[0]);
+
+    int status =3D 0;
+    if (waitpid(pid, &status, 0) !=3D=
 pid)
+    {
+        return EXIT_FAILURE;
+    }
+
+    return size =3D=3D=
 sizeof(result) && result =3D=3D '1' && WIFEXITED(status)
+                =
   && WEXITSTATUS(status) =3D=3D EXIT_SUCCESS
+               ? EXIT_SUCCES=
S
+               : EXIT_FAILURE;
+}
+
+int
+main(void)
+{
+    return run_=
case(-1) =3D=3D EXIT_SUCCESS && run_case(3) =3D=3D EXIT_SUCCESS
+          =
         && run_case(150) =3D=3D EXIT_SUCCESS
+               ? EXIT_SUCCES=
S
+               : EXIT_FAILURE;
+}

-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1881?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
Gerrit-Change-N=
umber: 1881
Gerrit-PatchSet: 1
Gerrit-Owner: srkyn <david@srkyn=2Ecom>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>

--wa9EZ9spfLA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>srkyn would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1881?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">co=
mpat: close all unrelated fds in forked helpers<br><br>The forked auth-pam,=
 down-root, and port-share helpers only closed<br>descriptor numbers 3 thro=
ugh 100=2E Descriptors above that range could<br>remain open in long-lived =
helper processes, including helpers that<br>intentionally retain privilege=
=2E<br><br>Add a shared compatibility helper that uses close_range() when a=
vailable<br>and falls back to the process descriptor limit=2E Preserve the =
helper<br>command socket and add coverage for both low and high preserved<b=
r>descriptors=2E<br><br>Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc5=
5<br>Signed-off-by: David Sarkisyan &lt;david@srkyn=2Ecom&gt;<br>---<br>M c=
onfigure=2Eac<br>M src/compat/Makefile=2Eam<br>A src/compat/close-fds=2Ec<b=
r>A src/compat/close-fds=2Eh<br>M src/openvpn/ps=2Ec<br>M src/plugins/auth-=
pam/Makefile=2Eam<br>M src/plugins/auth-pam/auth-pam=2Ec<br>M src/plugins/d=
own-root/Makefile=2Eam<br>M src/plugins/down-root/down-root=2Ec<br>M tests/=
unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/test_close_f=
ds=2Ec<br>11 files changed, 214 insertions(+), 74 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/81/1881/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/configure=2Eac b/configure=2Eac</span><=
br><span>index 469a475=2E=2Ebaa185a 100644</span><br><span>--- a/configure=
=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -567,7 +567,7=
 @@</span><br><span> 	syslog openlog mlockall getrlimit getgrnam setgid \</=
span><br><span> 	setgroups flock gettimeofday \</span><br><span> 	setsid ch=
dir \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	chsize ftruncat=
e execve getpeereid basename dirname \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	chsize ftruncate execve getpeereid basename dirname clo=
se_range \</span><br><span> 	epoll_create strsep strtok_r \</span><br><span=
> ])</span><br><span> </span><br><span>diff --git a/src/compat/Makefile=2Ea=
m b/src/compat/Makefile=2Eam</span><br><span>index 22867b3=2E=2E12c3f95 100=
644</span><br><span>--- a/src/compat/Makefile=2Eam</span><br><span>+++ b/sr=
c/compat/Makefile=2Eam</span><br><span>@@ -16,9 +16,10 @@</span><br><span> =
</span><br><span> libcompat_la_SOURCES =3D \</span><br><span> 	compat=2Eh \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	close-fds=2Ec clos=
e-fds=2Eh \</span><br><span> 	compat-dirname=2Ec \</span><br><span> 	compat=
-basename=2Ec \</span><br><span> 	compat-gettimeofday=2Ec \</span><br><span=
> 	compat-daemon=2Ec \</span><br><span> 	compat-strsep=2Ec \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	compat-strtok_r=2Ec</span><br><span=
>\ No newline at end of file</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	compat-strtok_r=2Ec</span><br><span>diff --git a/src/compat/close=
-fds=2Ec b/src/compat/close-fds=2Ec</span><br><span>new file mode 100644</s=
pan><br><span>index 0000000=2E=2Eadb6180</span><br><span>--- /dev/null</spa=
n><br><span>+++ b/src/compat/close-fds=2Ec</span><br><span>@@ -0,0 +1,60 @@=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to sec=
urely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             over a single UDP port, with support for SSL/TLS-based<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessi=
on authentication and key exchange,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet encryption, packet authentication, an=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pac=
ket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) =
2026 David Sarkisyan</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program=
 is free software; you can redistribute it and/or modify</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Gene=
ral Public License version 2</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  as published by the Free Software Foundation=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN3=
2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;close-fds=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;unistd=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;syslog=2Eh&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+close_fds_except(int keep)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    closelog();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CLOSE_=
RANGE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (keep &=
gt;=3D 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        const int lower_=
closed =3D keep =3D=3D 3 || close_range(3, (unsigned int)keep - 1, 0) =3D=
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (l=
ower_closed &amp;&amp; close_range((unsigned int)keep + 1, ~0U, 0) =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else if (close_range(3, ~0U, 0) =3D=3D 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    long max_fd=
 =3D sysconf(_SC_OPEN_MAX);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (max_fd &lt; 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     max_fd =3D 1024;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (lon=
g i =3D 3; i &lt; max_fd; ++i)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (i !=3D keep)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    close((int)i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif /* !_WIN32 */</span><br><span>diff --git a/src/compat=
/close-fds=2Eh b/src/compat/close-fds=2Eh</span><br><span>new file mode 100=
644</span><br><span>index 0000000=2E=2E5b1c667</span><br><span>--- /dev/nul=
l</span><br><span>+++ b/src/compat/close-fds=2Eh</span><br><span>@@ -0,0 +1=
,22 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application =
to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             over a single UDP port, with support for SSL/TLS-=
based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 session authentication and key exchange,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             packet encryption, packet authenticati=
on, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrigh=
t (C) 2026 David Sarkisyan</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This p=
rogram is free software; you can redistribute it and/or modify</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GN=
U General Public License version 2</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifndef CLOSE_FDS_H</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define CLOSE_FDS_H</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef=
 _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void close_f=
ds_except(int keep);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif /* CLOSE_FDS_H */</span>=
<br><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><s=
pan>index be91a99=2E=2Edbe5a1e 100644</span><br><span>--- a/src/openvpn/ps=
=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -33,6 +33,=
7 @@</span><br><span> #include &quot;fdmisc=2Eh&quot;</span><br><span> #inc=
lude &quot;crypto=2Eh&quot;</span><br><span> #include &quot;ps=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;close-f=
ds=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&q=
uot;</span><br><span> </span><br><span>@@ -96,30 +97,6 @@</span><br><span> =
}</span><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * Close most of parent&#39;s fds=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * Keep stdin/stdout/stderr, plus one</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * other fd which is presu=
med to be</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * our pipe =
back to parent=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * A=
dmittedly, a bit of a kludge,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * but posix doesn&#39;t give us a kind</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * of FD_CLOEXEC which will stop</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * fds from crossing a fork()=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-close_fds_except(int keep)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    socket_descriptor_t i;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    closelog();</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    for (i =3D 3; i &lt;=3D 100; ++i)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (i !=3D keep)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         openvpn_close_socket(i);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/*</span><br><span>  * Usually we ignore signals, because=
 our parent will</span><br><span>  * deal with them=2E</span><br><span>  */=
</span><br><span>diff --git a/src/plugins/auth-pam/Makefile=2Eam b/src/plug=
ins/auth-pam/Makefile=2Eam</span><br><span>index e6dc27e=2E=2Efb7fd30 10064=
4</span><br><span>--- a/src/plugins/auth-pam/Makefile=2Eam</span><br><span>=
+++ b/src/plugins/auth-pam/Makefile=2Eam</span><br><span>@@ -9,6 +9,7 @@</s=
pan><br><span> </span><br><span> AM_CFLAGS =3D \</span><br><span> 	-I$(top_=
srcdir)/include \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-=
I$(top_srcdir)/src/compat \</span><br><span> 	$(PLUGIN_AUTH_PAM_CFLAGS) \</=
span><br><span> 	$(OPTIONAL_CRYPTO_CFLAGS)</span><br><span> </span><br><spa=
n>@@ -23,6 +24,7 @@</span><br><span> 	pamdl=2Ec  pamdl=2Eh \</span><br><spa=
n> 	auth-pam=2Eexports</span><br><span> openvpn_plugin_auth_pam_la_LIBADD =
=3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_builddi=
r)/src/compat/libcompat=2Ela \</span><br><span> 	$(PLUGIN_AUTH_PAM_LIBS)</s=
pan><br><span> openvpn_plugin_auth_pam_la_LDFLAGS =3D $(AM_LDFLAGS) \</span=
><br><span> 	-export-symbols &quot;$(srcdir)/auth-pam=2Eexports&quot; \</sp=
an><br><span>diff --git a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/a=
uth-pam/auth-pam=2Ec</span><br><span>index 948b6af=2E=2E04bb7d8 100644</spa=
n><br><span>--- a/src/plugins/auth-pam/auth-pam=2Ec</span><br><span>+++ b/s=
rc/plugins/auth-pam/auth-pam=2Ec</span><br><span>@@ -51,6 +51,8 @@</span><b=
r><span> #include &lt;arpa/inet=2Eh&gt;</span><br><span> #include &lt;openv=
pn-plugin=2Eh&gt;</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;close-fds=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> #define DEBUG(verb) ((verb=
) &gt;=3D 4)</span><br><span> </span><br><span> /* Command codes for foregr=
ound -&gt; background communication */</span><br><span>@@ -240,30 +242,6 @@=
</span><br><span> #endif /* ifdef DO_DAEMONIZE */</span><br><span> </span><=
br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Close =
most of parent&#39;s fds=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * Keep stdin/stdout/stderr, plus one</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * other fd which is presumed to be</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * our pipe back to parent=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * Admittedly, a bit of a kludg=
e,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * but posix doesn&=
#39;t give us a kind</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* of FD_CLOEXEC which will stop</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * fds from crossing a fork()=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-close_f=
ds_except(int keep)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    closelog();</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 3; i &lt;=3D 100; ++i)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (i !=3D keep)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            close(i);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Usually we ignore s=
ignals, because our parent will</span><br><span>  * deal with them=2E</span=
><br><span>  */</span><br><span>diff --git a/src/plugins/down-root/Makefile=
=2Eam b/src/plugins/down-root/Makefile=2Eam</span><br><span>index 7ca5a4e=
=2E=2E83bc04f 100644</span><br><span>--- a/src/plugins/down-root/Makefile=
=2Eam</span><br><span>+++ b/src/plugins/down-root/Makefile=2Eam</span><br><=
span>@@ -9,6 +9,7 @@</span><br><span> </span><br><span> AM_CFLAGS =3D \</sp=
an><br><span> 	-I$(top_srcdir)/include \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	-I$(top_srcdir)/src/compat \</span><br><span> 	$(OPTI=
ONAL_CRYPTO_CFLAGS)</span><br><span> </span><br><span> if ENABLE_PLUGIN_DOW=
N_ROOT</span><br><span>@@ -19,6 +20,8 @@</span><br><span> openvpn_plugin_do=
wn_root_la_SOURCES =3D \</span><br><span> 	down-root=2Ec \</span><br><span>=
 	down-root=2Eexports</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+openvpn_plugin_down_root_la_LIBADD =3D \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	$(top_builddir)/src/compat/libcompat=2Ela</span><br=
><span> openvpn_plugin_down_root_la_LDFLAGS =3D $(AM_LDFLAGS) \</span><br><=
span> 	-export-symbols &quot;$(srcdir)/down-root=2Eexports&quot; \</span><b=
r><span> 	-module -shared -avoid-version -no-undefined</span><br><span>diff=
 --git a/src/plugins/down-root/down-root=2Ec b/src/plugins/down-root/down-r=
oot=2Ec</span><br><span>index cd57189=2E=2Ef0ee7ea 100644</span><br><span>-=
-- a/src/plugins/down-root/down-root=2Ec</span><br><span>+++ b/src/plugins/=
down-root/down-root=2Ec</span><br><span>@@ -44,6 +44,8 @@</span><br><span> =
</span><br><span> #include &lt;openvpn-plugin=2Eh&gt;</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;close-fd=
s=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> #define DEBUG(verb) ((verb) &gt;=3D 7)</span><br><span> </span><b=
r><span> /* Command codes for foreground -&gt; background communication */<=
/span><br><span>@@ -191,30 +193,6 @@</span><br><span> }</span><br><span> </=
span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
Close most of parent&#39;s fds=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * Keep stdin/stdout/stderr, plus one</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * other fd which is presumed to be</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * our pipe back to parent=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * Admittedly, a bit of a=
 kludge,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * but posix =
doesn&#39;t give us a kind</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * of FD_CLOEXEC which will stop</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * fds from crossing a fork()=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-c=
lose_fds_except(int keep)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    closelog();</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 3; i &lt;=3D 100; =
++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (i !=3D keep)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            close(i);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Usually we ig=
nore signals, because our parent will</span><br><span>  * deal with them=2E=
</span><br><span>  */</span><br><span>diff --git a/tests/unit_tests/openvpn=
/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>ind=
ex 6db611e=2E=2E68e224f 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2E=
am</span><br><span>@@ -23,6 +23,10 @@</span><br><span> 	ssl_testdriver \</s=
pan><br><span> 	user_pass_testdriver</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+if !WIN32</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+test_binaries +=3D close_fds_testdriver</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> if HAVE_LD_WRAP_SUPPORT</s=
pan><br><span> if !WIN32</span><br><span> test_binaries +=3D tls_crypt_test=
driver</span><br><span>@@ -45,6 +49,11 @@</span><br><span> endif</span><br>=
<span> check_PROGRAMS =3D $(test_binaries)</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+close_fds_testdriver_CFLAGS =3D -I=
$(top_srcdir)/src/compat @TEST_CFLAGS@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+close_fds_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+close_fds_testdriver_SOURCES=
 =3D test_close_fds=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+close_fds_testdriver_LDADD =3D $(top_builddir)/src/compat/libcompat=2El=
a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
if HAVE_SITNL</span><br><span> check_PROGRAMS +=3D networking_testdriver</s=
pan><br><span> endif</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_close_fds=2Ec b/tests/unit_tests/openvpn/test_close_fds=2Ec</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2E177e054</span=
><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_close_fds=2Ec</span><br><span>@@ -0,0 +1,110 @@</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a=
 single UDP port, with support for SSL/TLS-based</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             session authentication and key =
exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     packet encryption, packet authentication, and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 David Sarkisyan</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;con=
fig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;close-fds=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;errno=2Eh&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &lt;fcntl=2Eh&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;sys/so=
cket=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &lt;sys/wait=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &lt;unistd=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fd_is_closed(int =
fd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    errno =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return fcntl(fd, F_GETFD) =3D=3D =
-1 &amp;&amp; errno =3D=3D EBADF;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+run_case(int keep_target)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int control[2];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, =
control) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return EX=
IT_FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const pid_t pid =3D fork();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (pid &lt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return EXIT_FAILURE;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (pid =3D=3D 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      close(control[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int ke=
ep =3D control[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (keep_target &gt;=3D 3 &amp;&amp; keep_target !=3D keep)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (dup2(keep, keep_target=
) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
_exit(EXIT_FAILURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       close(keep);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            keep =3D keep_target;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const i=
nt source =3D open(&quot;/dev/null&quot;, O_RDONLY);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (source &lt; 0 || dup2(source,=
 100) &lt; 0 || dup2(source, 200) &lt; 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            _exit(EXIT_FAILURE);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (source !=3D keep)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            close(source);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 close_fds_except(keep);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
char result =3D fd_is_closed(100) &amp;&amp; fd_is_closed(200) ? &#39;1&#39=
; : &#39;0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (write(keep, &amp;result, sizeof(result)) !=3D sizeof(result))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            _exit(EXIT_FAILURE);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        close(keep);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        _exit(result =3D=3D &#=
39;1&#39; ? EXIT_SUCCESS : EXIT_FAILURE);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    close(c=
ontrol[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char=
 result =3D &#39;0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const ssize_t size =3D read(control[0], &amp;result, sizeof(result=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    close(contro=
l[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int status =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (waitpid(pid, &amp;stat=
us, 0) !=3D pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return EX=
IT_FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return size =3D=3D sizeof(result) &am=
p;&amp; result =3D=3D &#39;1&#39; &amp;&amp; WIFEXITED(status)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                   &amp;&amp; WE=
XITSTATUS(status) =3D=3D EXIT_SUCCESS</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+               ? EXIT_SUCCESS</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+               : EXIT_FAILURE;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return run_case(-1) =3D=3D EXIT_SUCCE=
SS &amp;&amp; run_case(3) =3D=3D EXIT_SUCCESS</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                   &amp;&amp; run_case(150) =3D=
=3D EXIT_SUCCESS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
            ? EXIT_SUCCESS</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+               : EXIT_FAILURE;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">change 1=
881</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"=
display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> =
Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id:=
 Iacd56d245e9ab30cfb25b2b364ca661fa289dc55 </div>
<div style=3D"display:non=
e"> Gerrit-Change-Number: 1881 </div>
<div style=3D"display:none"> Gerrit-P=
atchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: srkyn &lt;davi=
d@srkyn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--wa9EZ9spfLA=--


--===============6108025484260319117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6108025484260319117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6108025484260319117==--

