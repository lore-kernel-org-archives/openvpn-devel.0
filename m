Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D98CA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tlFKnkZhh8CHh16qsqUo1VtwxpkbhMK0J/jYJ8P3yVY=; b=hE4PvgtMe+kRJJsIes2Pso1e1L
	e5NOKqy/E6pYuTTKJMmkMssnQXj6HWih3VmT7V0BsssptubI6y2r+UhMiMzflQNA3wXXUNDph4wZY
	V2pLeUrnzUfQ3YpjRscOafZxAV1QnQG8jct0Ohk3tGabsbvucqXAjE+ONjh6mt3n+1mU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xD1ZU-0006cA-JX;
	Sat, 03 Oct 2026 15:22:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xD1ZS-0006by-N5
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 15:22:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=c4h3Zg2YfTgfFs7FJ0+2bFZc8GXKI0l1YxZtQjxbY40=; b=g+KxGDnk9wgi1H3pd4oYcu33qs
 a54jZG8zt6x2eVMgacR8Rih/Dle4yQaPmK1d+jSsrs68k7xpaipDc19S0hV7m4WnxFYQrQvNhm6Gg
 hSZbZLEXC6TDTPBy4r7BSO7YIiTL+vjE5ikPcdq1Dcddboh1FZQI4DH1XHi9rlXu1lKc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=c4h3Zg2YfTgfFs7FJ0+2bFZc8GXKI0l1YxZtQjxbY40=; b=P
 TZarHGqZdVMjF2NnYyMGpDxxzTgmn+8O5XUnYp54oIEiYw+HmZUsRxSdPZAS7MFdag62yfq1YI5nH
 0iOgyXs30e3bUxTDisGhVC0YhzhVqx6pkkZSQZzUvAdT3RptaupUGFu37GSEHpR5dOO3Ow2NSePG7
 nNHJZNdSglvWgZhg=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xD1ZQ-0000Vk-U2 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 15:22:41 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso1925805e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 03 Oct 2026 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791040954; x=1791645754; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c4h3Zg2YfTgfFs7FJ0+2bFZc8GXKI0l1YxZtQjxbY40=;
 b=DeZcS98qVS0sxaxl/icSQFoSPVoWL18FLTUH+5Fu+vDasAfyUO/K88Ibo1kNJO7A5z
 UltKwevWc99aOmRfj9MXMZ3mXgdEJwA631kViHDFbo+KOhR/D7rCvkZGbk3HmAFG86iO
 csitJHgrnOVtk76JllTfde727/aRNmG2LDOKGIUEATrL8sgGdDePtF7bvltq8Yb2Trt/
 o6ylOQFLtY6C++B7vxIJCgwWwV11JyVpzHERVZm1pev8qbXDwhxN9dHKdWSwEuOw/mpZ
 IJ9QakD5EQiA1WW/mGXuPsFLWuTjeRGc5CzaOdV9d8VW6HDjKM/LY0g8UsyZQ3Xzjge2
 uoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791040954; x=1791645754;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=c4h3Zg2YfTgfFs7FJ0+2bFZc8GXKI0l1YxZtQjxbY40=;
 b=0qcP764OFskZtqcDrG7gmFKszPU/9d73ospMuAyG21kozhL7KUdwdarssz+yYbucXX
 sH9C00mD5LjlU0dDQLiz2grfS+bjrjy93OUKLs7W4cN3/TK9P+hnHGGxozIK9rZT6Mja
 kMUIv9Y3j+p1VLTBASXLnRwoc33TXYPatea7Pkvdv0iUxf3jSPWZDgmKBSt7rm2MJGoU
 r1BVx6+Ik2izBDMixaS3AqFff6gXLbzN6WGrbGCBJMCUo2Q6yQXj5djB2A5Ksvngs3wX
 138RQaSHmGPx5YnDT5XQPTgZrRZd6kVt+rnzJW58+unUpghNNC4jx4mwi0anv+t3xnEj
 5Yaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzty7ba30ridQJMkas0DrrAspjwQt2ztOhOQYE15F0QKJkJB79t9zr9ePsnRe5DRaIPosNKQMJb7zyrsh/z@lists.sourceforge.net
X-Gm-Message-State: AFuF++kpvxkmmhop+ipI+oXMF1Q0HBHvtEYO3IR5hq7/OF3TC8akRFTd
 vZBiiG0b/zH6IezDf224cSsnfNHt/YM/Zwgr1ROL9iSaLWJ7e7kJ9beA1yXU4jXjgPaDm5DESL1
 ilz2REERmBHwyApL3AVqTAHOO01u2uI3g2ewUe2wNPJncVn2dyS9FNzdvEZYgThEhwOCI
X-Gm-Gg: AYBFou0Pf+IcHjFTN0SxtDWrh0J8BHP3QZRg4RnD5h6fOR5m46h5u2rFMYVT40bUmjh
 EzVmMi6p/z0zRu/FLEBuMJDr4hfuHLGoI0IjpixsQIjXOKbmTi1tgJNmxsVKc1SIiXYKLDpRwzN
 WtWTluxQFzTkaGSMSBoF93BUpeHFGJME2+AlN9hDTMu4bt6zRhjeXy1gplzA1JtCglvKqqUCGGQ
 KpVYzxNzgcXnMcFW61kHpDo/Jo+oxBz7yZRU8o/lZKltz5JYSS9F+GodfTYb9c3GZGtT08Hz9x0
 I1h+YkHb2/1pxWQsr1DI3eVAQ2q44e7I0aM8oj3a4iGNyciTq4wlN0893eKbZDQ2dESqgagUA6y
 SP9R/kYRymsihZzYF4usat+Rpe8OIDgwecyQg52at6dAGyOYJmdR9vY/XcuLSrqUCBfGC6KVADM
 mjLy5D1fpOHkEEzFnM9VWo0QsCijdiaz9HKcomtNHx+avgKOZZS8r9X5lGx6nZbZ4w5a6Gtz0sz
 Ru73NgCjGCf1Yp/MKA628irfyVtsBXZABn2IHi2yTq7bROPQIHJvKu1kL9mPsrH/JAH5jOY2lDd
 XPjAHU7ylUaUZpisaVhrF4AtrGe6pTb1cgXZEHve+B8Ldu1bAPN9SGZM6vp7LYU6n5/oj3c=
X-Received: by 2002:a05:600c:870f:b0:49f:fc4f:9efb with SMTP id
 5b1f17b1804b1-4a02753fd01mr103577795e9.7.1791040954007; 
 Sat, 03 Oct 2026 08:22:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280bfafasm188934075e9.8.2026.10.03.08.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 08:22:33 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 3 Oct 2026 15:22:33 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I09b055f15e35614eab112ff69166c6985f8770da
X-Gerrit-Change-Number: 1967
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1967?usp=email>
X-Gerrit-Commit: 2484e658c46d56910c9a7b6ce22ffa2144b12293
In-Reply-To: <gerrit.1790780162000.I09b055f15e35614eab112ff69166c6985f8770da@gerrit.openvpn.net>
References: <gerrit.1790780162000.I09b055f15e35614eab112ff69166c6985f8770da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzgwMTYyMDAwLkkwOWIwNTVmMTVlMzU2MTRlYWIxMTJmZjY5MTY2YzY5ODVmODc3MGRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <faec64c7b58bd9252b4596ed0a58eaa66cf21d77-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xD1ZQ-0000Vk-U2
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3801665801648024626=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3801665801648024626==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9BiEc23gN94="; charset=UTF-8

--9BiEc23gN94=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1967?usp=3Demail )

Change subject: Assume termios=2Eh is avail=
able on all non Windows platforms
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Assume termios=2Eh is available on all non Windows p=
latforms

Checking for something that is available on all (non Windows) pla=
tforms
is not very useful=2E So just always use termios=2Eh

Change-Id: I09=
b055f15e35614eab112ff69166c6985f8770da
Signed-off-by: Arne Schwabe <arne@rf=
c2549=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Acked-by: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1967
Message-Id: <20261003132620=2E12292-1-gert@greeni=
e=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg39661=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M configure=2Eac
M src/openvpn/console_builtin=2Ec
2 files=
 changed, 6 insertions(+), 11 deletions(-)




diff --git a/configure=2Eac =
b/configure=2Eac
index 1fa0e63=2E=2E195116f 100644
--- a/configure=2Eac
+++=
 b/configure=2Eac
@@ -459,7 +459,7 @@
 	sys/time=2Eh sys/ioctl=2Eh sys/stat=
=2Eh \
 	sys/mman=2Eh sys/file=2Eh sys/wait=2Eh \
 	libgen=2Eh stropts=2Eh =
\
-	syslog=2Eh pwd=2Eh grp=2Eh termios=2Eh \
+	syslog=2Eh pwd=2Eh grp=2Eh \=

 	sys/sockio=2Eh sys/uio=2Eh \
 	poll=2Eh sys/epoll=2Eh err=2Eh \
 ])
diff=
 --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec
=
index cf6cc37=2E=2E4737677 100644
--- a/src/openvpn/console_builtin=2Ec
+++=
 b/src/openvpn/console_builtin=2Ec
@@ -37,7 +37,7 @@
 #include "buffer=2Eh"=

 #include "misc=2Eh"
 
-#ifdef HAVE_TERMIOS_H
+#ifndef _WIN32
 #include <t=
ermios=2Eh>
 #endif
 
@@ -133,10 +133,7 @@
     return false;
 }
 
-#endif =
/* _WIN32 */
-
-
-#ifdef HAVE_TERMIOS_H
+#else
 
 /**
  * Open the current =
console TTY for read/write operations
@@ -175,7 +172,7 @@
     }
 }
 
-#end=
if /* HAVE_TERMIOS_H */
+#endif
 
 
 /**
@@ -196,10 +193,8 @@
     ASSERT(c=
apacity > 0);
     input[0] =3D '\0';
 
-#if defined(_WIN32)
+#ifdef _WIN32=

     return get_console_input_win32(prompt, echo, input, capacity);
-#elif=
 !defined(HAVE_TERMIOS_H)
-    msg(M_FATAL, "Sorry, but I can't get console=
 input on this OS (%s)", prompt);
 #else
     bool restore_tty =3D false;
 =
    bool ret =3D false;
@@ -260,7 +255,7 @@
 
     close_tty(fp);
     retu=
rn ret;
-#endif /* if defined(_WIN32) */
+#endif
 }
 
 /**

-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I09b055f15e35614eab112ff69166c6985f8=
770da
Gerrit-Change-Number: 1967
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--9BiEc23gN94=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1967?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Assume termios=2Eh is available on=
 all non Windows platforms<br><br>Checking for something that is available =
on all (non Windows) platforms<br>is not very useful=2E So just always use =
termios=2Eh<br><br>Change-Id: I09b055f15e35614eab112ff69166c6985f8770da<br>=
Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1967<br>Message-Id: &lt;20261003132620=2E12292-1-gert@greenie=2Emu=
c=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg39661=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>---<br>M configure=2Eac<br>M src/openvpn/console_bu=
iltin=2Ec<br>2 files changed, 6 insertions(+), 11 deletions(-)<br><br></pre=
>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 1fa=
0e63=2E=2E195116f 100644</span><br><span>--- a/configure=2Eac</span><br><sp=
an>+++ b/configure=2Eac</span><br><span>@@ -459,7 +459,7 @@</span><br><span=
> 	sys/time=2Eh sys/ioctl=2Eh sys/stat=2Eh \</span><br><span> 	sys/mman=2Eh=
 sys/file=2Eh sys/wait=2Eh \</span><br><span> 	libgen=2Eh stropts=2Eh \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	syslog=2Eh pwd=2Eh grp=
=2Eh termios=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
syslog=2Eh pwd=2Eh grp=2Eh \</span><br><span> 	sys/sockio=2Eh sys/uio=2Eh \=
</span><br><span> 	poll=2Eh sys/epoll=2Eh err=2Eh \</span><br><span> ])</sp=
an><br><span>diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/con=
sole_builtin=2Ec</span><br><span>index cf6cc37=2E=2E4737677 100644</span><b=
r><span>--- a/src/openvpn/console_builtin=2Ec</span><br><span>+++ b/src/ope=
nvpn/console_builtin=2Ec</span><br><span>@@ -37,7 +37,7 @@</span><br><span>=
 #include &quot;buffer=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&q=
uot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#ifdef HAVE_TERMIOS_H</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef _WIN32</span><br><span> #include &lt;termios=2Eh&gt;</span><br><=
span> #endif</span><br><span> </span><br><span>@@ -133,10 +133,7 @@</span><=
br><span>     return false;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif /* _WIN32 */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
ifdef HAVE_TERMIOS_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#else</span><br><span> </span><br><span> /**</span><br><span>  * Open the =
current console TTY for read/write operations</span><br><span>@@ -175,7 +17=
2,7 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_TERMIOS_H */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
> </span><br><span> </span><br><span> /**</span><br><span>@@ -196,10 +193,8=
 @@</span><br><span>     ASSERT(capacity &gt; 0);</span><br><span>     inpu=
t[0] =3D &#39;\0&#39;;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(_WIN32)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#ifdef _WIN32</span><br><span>     return get_console_in=
put_win32(prompt, echo, input, capacity);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#elif !defined(HAVE_TERMIOS_H)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    msg(M_FATAL, &quot;Sorry, but I can&#39;t =
get console input on this OS (%s)&quot;, prompt);</span><br><span> #else</s=
pan><br><span>     bool restore_tty =3D false;</span><br><span>     bool re=
t =3D false;</span><br><span>@@ -260,7 +255,7 @@</span><br><span> </span><b=
r><span>     close_tty(fp);</span><br><span>     return ret;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(_WIN32) */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> =
}</span><br><span> </span><br><span> /**</span><br></pre><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail">cha=
nge 1967</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I09b055f15e35614eab112ff69166c6985f8770da </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1967 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--9BiEc23gN94=--


--===============3801665801648024626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3801665801648024626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3801665801648024626==--

