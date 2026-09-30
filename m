Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E70CA5FCB
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=+G8k+ay5X5xVUHQGpTEzDp718DrE26Mxpg5Fdx18BQU=; b=AEUYz/Gh3ckina
	hziOJWzfVBwP2H+FNC4uXcjQe76bd2ZmljX4jT+GgLFd2tjvvfJDyd3+z5CmeEO6TY0U8ry3kOcXb
	Ut9K73dCTvpeDHeRzN1pyqLjw4NhDeHiddVY1kV0eJUUHDWIUoXM5ki6tBMEyqzVizCe+FGwBy0Fk
	wOQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBvjD-0001rz-Gz;
	Wed, 30 Sep 2026 14:56:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBvjC-0001rt-6f
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 14:56:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pGSB1iZGQtV+M1dIb9qr4lzRMjZ/HeubSKF9JvWtgCU=; b=dH71fRha0j0dmC3xiY3inu9bsK
 7/UApzlRVFCre7e+PktVeDJ4ntcH32QUdyBIaXJu5Z4lhKNyfaNETQ6jHSY6m22t9ou0wFjR+BA/H
 dVh7rxEBlbMiZcuHnLEmcVgbPu5EhkQIN8tWcJ/5htEeQXKqpnMM+YsROGZ84ni0+D1g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pGSB1iZGQtV+M1dIb9qr4lzRMjZ/HeubSKF9JvWtgCU=; b=e
 UZ6tzsPJ7/bd1LakMimicB2l6N/UGEQ51nifnKuN5+JdtdQKU8Y6sCAOZqkYQ0JtNkvbdSlGlIQ+q
 r77fNrB9W6wXynE/hF8uDnZA7x1X199Pxc4fkT6X2nX40C+CrD1QWpSi1/k/m6KiK0Ps6HnVq40bT
 Y+5ke6/ROFetZf40=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBvjA-0007da-Ki for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 14:56:14 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ffe817151so23593195e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790780166; x=1791384966; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pGSB1iZGQtV+M1dIb9qr4lzRMjZ/HeubSKF9JvWtgCU=;
 b=BUqNEBnz9x3r4HQqm7m6s2mfF6Im3Mc/BSQjbmw230ashhzp2Bl4hhbcFcM8c4Fzxo
 P/8XKkm3f090I5F6SjRy88T0ze5OeqoD9MovfKFDKfoOoAkYsqOPvIiNpJVSsQC06V9/
 d+eApV3qojyq/HGuxh2tTZ+OBGSLBqlfAQpJap1jRQqyWTKetHsHYDvNjyDrBJRztcc1
 tvV5vyHrMZzwemRHmIVwOENKAAxW9Z60+dYUxcJZfZoAnSzxs5L/qMOSZOGeIK7A0/sV
 vHtsa3QeaR4PmfqMAEcaEZzLljukGiiF3HWuM1Fjj3iWZsMMQRwHR+3S6fLsAFBjtHs+
 QZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790780166; x=1791384966;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pGSB1iZGQtV+M1dIb9qr4lzRMjZ/HeubSKF9JvWtgCU=;
 b=p7KwzB35Gl+IjLpGnbyWfwVCrSSEJ8DbjVIOyP65qAQVt+9ce6mRqev5xtbJgXA0+N
 B55PXGxvdTHb2/aSNdjkT8IjeEVxtdQi0nOgctBewErVKObEvXSl7kuW4cKQaU82qyla
 lyKsCLM702TwbEEegxaQRNc9nzgmIPp0gbe6Ah+jw8sIj6xLx2QWENikx4qbgMGCLt7J
 XWsahRlZH5h9/T79WEq5OgNHYfqobOOIUOax2SdqFOw6btIoRyPnzTXfwmxmK9i5yV/7
 VKoNwQQ59foGNWvWWFU1cp0xKSmtDmAYJLzsvw6DnRwzIf4f/6u03UJa/+Vpl13HhXa+
 u1bw==
X-Gm-Message-State: AFuF++k50bvh2vCkEWABCDvkzxpGkcTovuWg0G1T53hWifrYlGOzNMax
 a/RZhOgWJ5dXA6lO8K0YCjJRUXteoCgnRYUS8ZgoEL3J04ACNdCymZeEj+yaL5vcb3GURBsq0sr
 1UOPmsikEQ3ptloCoEDk9pkPcKGFDK2zc8sBhA9jqdFFOS9rHAntKrCi0X1dRwXM/Jvzdl/1/lk
 JVT+43tA==
X-Gm-Gg: AYBFou2wWVHsOikglQcmw1fn3XZcLCKPFNObOrqChZ0RaagMe5hcOrloj4pULfGoGr/
 OTYwXeisYPLrKfhItgKd7u2VSDgJNlB6gSTlNL60LJ6zRNmmQnncO7OueX+2hYCmiWNFQ21VCjk
 PtWWKu6/ScgFauoeqMx54QZEyJvbUwzOpYe+wg1ZoKR+oI6lsB9Jvf2gr9guuWFDhPOTtPc9xZf
 zgKRhH0HgjQMlaoKHJxSfchdqUHiY7m6KTCZMaKSy0uENL23Kb78k+xk3ZfYijp71bYBjhIllgS
 2KAmHA/ME+xsGwPzqXMdblP2+VK3PzsWumNjOGBUqO3Xh4HdVzwI1H5OpyT9mUenlOsX+8+9niP
 29bmhDZGJou+sTLIOCf0srI3zNH6Qczch+uoyVPmbU3Bx7GTy423BbONZBOMVaym3LRDvxukxan
 QctCFYnLgqosGpMBgS/KU5H98xXT8a8Y9ciwTS3oRPb39arX+13fIE1Pl5j3+HqW14dzOecHgtj
 /5tMVBs05ogNmbgukD0uZhDZMuK1ZpQtU51EmonVizUwsKRSNqW6jHn7jojPrMm9z2zPxOsh54b
 rpQJSncm2SBwz3GanYQDAPdMKDE+5rO0UB3Ab9fdY75apClnfrrFESB+2aHw5Q==
X-Received: by 2002:a05:600c:c162:b0:49e:6778:c2bd with SMTP id
 5b1f17b1804b1-4a01afe1e88mr30096195e9.6.1790780165842; 
 Wed, 30 Sep 2026 07:56:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029bfbcdsm4426863f8f.6.2026.09.30.07.56.05
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 07:56:05 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 14:56:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I09b055f15e35614eab112ff69166c6985f8770da
X-Gerrit-Change-Number: 1967
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1967?usp=email>
X-Gerrit-Commit: 2200ecdd82574f574d292f360f2cc27405b92608
References: <gerrit.1790780162000.I09b055f15e35614eab112ff69166c6985f8770da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzgwMTYyMDAwLkkwOWIwNTVmMTVlMzU2MTRlYWIxMTJmZjY5MTY2YzY5ODVmODc3MGRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ba6965ad69e029786cb60c4b1acb98e062673c06-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBvjA-0007da-Ki
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Assume termios.h is
 available on all non Windows platforms
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3339570403336776156=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3339570403336776156==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K8n/PqRcX3A="; charset=UTF-8

--K8n/PqRcX3A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1967?usp=3Demail )


Change subject: Assume termios=2Eh =
is available on all non Windows platforms
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Assume termios=2Eh is available on all non Win=
dows platforms

Checking for something that is available on all (non Window=
s) platforms
is not very useful=2E So just always use termios=2Eh

Change-I=
d: I09b055f15e35614eab112ff69166c6985f8770da
Signed-off-by: Arne Schwabe <a=
rne@rfc2549=2Eorg>
---
M configure=2Eac
M src/openvpn/console_builtin=2Ec
M=
 src/openvpn/options=2Ec
3 files changed, 8 insertions(+), 13 deletions(-)
=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/67/19=
67/1

diff --git a/configure=2Eac b/configure=2Eac
index 1fa0e63=2E=2E19511=
6f 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -459,7 +459,7 @@
 	s=
ys/time=2Eh sys/ioctl=2Eh sys/stat=2Eh \
 	sys/mman=2Eh sys/file=2Eh sys/wa=
it=2Eh \
 	libgen=2Eh stropts=2Eh \
-	syslog=2Eh pwd=2Eh grp=2Eh termios=2E=
h \
+	syslog=2Eh pwd=2Eh grp=2Eh \
 	sys/sockio=2Eh sys/uio=2Eh \
 	poll=2E=
h sys/epoll=2Eh err=2Eh \
 ])
diff --git a/src/openvpn/console_builtin=2Ec =
b/src/openvpn/console_builtin=2Ec
index 9c8d72a=2E=2E10369283 100644
--- a/=
src/openvpn/console_builtin=2Ec
+++ b/src/openvpn/console_builtin=2Ec
@@ -3=
7,7 +37,7 @@
 #include "buffer=2Eh"
 #include "misc=2Eh"
 
-#ifdef HAVE_TER=
MIOS_H
+#ifndef _WIN32
 #include <termios=2Eh>
 #endif
 
@@ -134,10 +134,7 =
@@
     return false;
 }
 
-#endif /* _WIN32 */
-
-
-#ifdef HAVE_TERMIOS_H
=
+#else
 
 /**
  * Open the current console TTY for read/write operations
@@=
 -176,7 +173,7 @@
     }
 }
 
-#endif /* HAVE_TERMIOS_H */
+#endif
 
 
 /**=

@@ -197,10 +194,8 @@
     ASSERT(capacity > 0);
     input[0] =3D '\0';
 
=
-#if defined(_WIN32)
+#ifdef _WIN32
     return get_console_input_win32(pro=
mpt, echo, input, capacity);
-#elif !defined(HAVE_TERMIOS_H)
-    msg(M_FAT=
AL, "Sorry, but I can't get console input on this OS (%s)", prompt);
 #else=

     bool restore_tty =3D false;
     bool ret =3D false;
@@ -261,7 +256,7=
 @@
 
     close_tty(fp);
     return ret;
-#endif /* if defined(_WIN32) */=

+#endif
 }
 
 /**
diff --git a/src/openvpn/options=2Ec b/src/openvpn/optio=
ns=2Ec
index 3c5a249=2E=2E8ce625b 100644
--- a/src/openvpn/options=2Ec
+++ =
b/src/openvpn/options=2Ec
@@ -4305,7 +4305,7 @@
         }
     }
 #ifdef E=
NABLE_MANAGEMENT
-    else if (streq(p[0], "management") && p[1] && p[2] &&=
 !p[4])
+    else if (streq(p[0], "management") && p[1] && p[2] && (!p[4] |=
| streq(p[2], "unix-script"))
     {
         VERIFY_PERMISSION(OPT_P_GENER=
AL);
         if (streq(p[2], "unix"))
@@ -4320,7 +4320,7 @@
 
         opt=
ions->management_addr =3D p[1];
         options->management_port =3D p[2];=

-        if (p[3])
+        if (p[3] && !(options->management_flags & MF_U=
NIX_SOCK_SCRIPT))
         {
             options->management_user_pass =3D=
 p[3];
         }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1967?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
09b055f15e35614eab112ff69166c6985f8770da
Gerrit-Change-Number: 1967
Gerrit-=
PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--K8n/PqRcX3A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Assume termios=2Eh is available on all non Windows platforms<br><b=
r>Checking for something that is available on all (non Windows) platforms<b=
r>is not very useful=2E So just always use termios=2Eh<br><br>Change-Id: I0=
9b055f15e35614eab112ff69166c6985f8770da<br>Signed-off-by: Arne Schwabe &lt;=
arne@rfc2549=2Eorg&gt;<br>---<br>M configure=2Eac<br>M src/openvpn/console_=
builtin=2Ec<br>M src/openvpn/options=2Ec<br>3 files changed, 8 insertions(+=
), 13 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/67/1967/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/configur=
e=2Eac b/configure=2Eac</span><br><span>index 1fa0e63=2E=2E195116f 100644</=
span><br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</s=
pan><br><span>@@ -459,7 +459,7 @@</span><br><span> 	sys/time=2Eh sys/ioctl=
=2Eh sys/stat=2Eh \</span><br><span> 	sys/mman=2Eh sys/file=2Eh sys/wait=2E=
h \</span><br><span> 	libgen=2Eh stropts=2Eh \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	syslog=2Eh pwd=2Eh grp=2Eh termios=2Eh \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	syslog=2Eh pwd=2Eh grp=2Eh =
\</span><br><span> 	sys/sockio=2Eh sys/uio=2Eh \</span><br><span> 	poll=2Eh=
 sys/epoll=2Eh err=2Eh \</span><br><span> ])</span><br><span>diff --git a/s=
rc/openvpn/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec</span><br>=
<span>index 9c8d72a=2E=2E10369283 100644</span><br><span>--- a/src/openvpn/=
console_builtin=2Ec</span><br><span>+++ b/src/openvpn/console_builtin=2Ec</=
span><br><span>@@ -37,7 +37,7 @@</span><br><span> #include &quot;buffer=2Eh=
&quot;</span><br><span> #include &quot;misc=2Eh&quot;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_TERMIOS_H</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><b=
r><span> #include &lt;termios=2Eh&gt;</span><br><span> #endif</span><br><sp=
an> </span><br><span>@@ -134,10 +134,7 @@</span><br><span>     return false=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif /* _WIN32 */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_TERMIOS_H</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span> </=
span><br><span> /**</span><br><span>  * Open the current console TTY for re=
ad/write operations</span><br><span>@@ -176,7 +173,7 @@</span><br><span>   =
  }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif /* HAVE_TERMIOS_H */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> </span=
><br><span> /**</span><br><span>@@ -197,10 +194,8 @@</span><br><span>     A=
SSERT(capacity &gt; 0);</span><br><span>     input[0] =3D &#39;\0&#39;;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
_WIN32</span><br><span>     return get_console_input_win32(prompt, echo, in=
put, capacity);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif =
!defined(HAVE_TERMIOS_H)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    msg(M_FATAL, &quot;Sorry, but I can&#39;t get console input on this =
OS (%s)&quot;, prompt);</span><br><span> #else</span><br><span>     bool re=
store_tty =3D false;</span><br><span>     bool ret =3D false;</span><br><sp=
an>@@ -261,7 +256,7 @@</span><br><span> </span><br><span>     close_tty(fp)=
;</span><br><span>     return ret;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif /* if defined(_WIN32) */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span> }</span><br><span> </span>=
<br><span> /**</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/o=
penvpn/options=2Ec</span><br><span>index 3c5a249=2E=2E8ce625b 100644</span>=
<br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/o=
ptions=2Ec</span><br><span>@@ -4305,7 +4305,7 @@</span><br><span>         }=
</span><br><span>     }</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;=
management&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &q=
uot;management&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; (!p[4] || =
streq(p[2], &quot;unix-script&quot;))</span><br><span>     {</span><br><spa=
n>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         if (s=
treq(p[2], &quot;unix&quot;))</span><br><span>@@ -4320,7 +4320,7 @@</span><=
br><span> </span><br><span>         options-&gt;management_addr =3D p[1];</=
span><br><span>         options-&gt;management_port =3D p[2];</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (p[3])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (p[3] &amp;&amp; !(options=
-&gt;management_flags &amp; MF_UNIX_SOCK_SCRIPT))</span><br><span>         =
{</span><br><span>             options-&gt;management_user_pass =3D p[3];</=
span><br><span>         }</span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail">change 1967</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09b055f15e=
35614eab112ff69166c6985f8770da </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1967 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--K8n/PqRcX3A=--


--===============3339570403336776156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3339570403336776156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3339570403336776156==--

