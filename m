Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710AFCA5FC7
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PGkaZlhtbqM0RYi/H5IF/oeqePWMkG4CuKdt9N+Fe3g=; b=jfaZzWEkX/5aTSz13z5tlhw4Y3
	CL/QLt1+BbZ+xrNo+6DOsEomiKsjuXsS6FvFcabjDgZgd376qQA0K4lCgQ5K51ul3ikRTct7H+VKp
	pOxg+eYc8dBrXu9LxFkWHTolvgMGPtsxPBPHL8Q1YXAC6APASdiQtOw0bN/sfvzYq6aE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBvlT-0004bO-U6;
	Wed, 30 Sep 2026 14:58:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBvlS-0004bB-1L
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 14:58:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tiOGbe6QwS+lK273Jv6wAWyqlgJxbqIAAEW+CpiRdWM=; b=YZZYq4L3BW5imlxyVg2an8L9Bd
 z1ilsbbfomXQTzhPDosO1LWLyeZeYDGL86/+n9+ZNbRxYhQ2Jc2D6w0s2kXn/D5EXfioS3x5ZqRhG
 pvH516IQMjQJ/UsxfcScIGrDM0SrdfkeEv11CoKtfNgNPesOwnjWLogbCeGfvFFxg9aI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tiOGbe6QwS+lK273Jv6wAWyqlgJxbqIAAEW+CpiRdWM=; b=a
 rI1xeZVvcIGsVQG7BWEVqM0AUT1YpICMJelu2IWvEkeUFSbMc29OcfOLp+91R3KS7To3pcD4c7Gf1
 nGwO9uH/AgRuTWgglvFYesWWwcdw+bRFNiY2XD1tiElWxbVn/VHi50FYHjyr2lSzBbzs+GsMyf2D3
 yykSs5GtX+MSXFVw=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBvlR-0007Fk-FG for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 14:58:34 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48af5ae31d8so1648219f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790780307; x=1791385107; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tiOGbe6QwS+lK273Jv6wAWyqlgJxbqIAAEW+CpiRdWM=;
 b=GKXb0kocbJyjUyDrFskHLOya8XdS0uKu1499Dw6hGr+N1xH0xzZKD+S97qNH/xaT/4
 iMkpsev0FRawXxD4ApbMBKij4ngfR0aFAGPoqscUixcyEcmd+dJ9AzNSKvjjgLDIqBwa
 mDg24C+l9INKAn2AEMkp7ZebRgRGNKaGcDGwgMognBHHraIGu0lyEe4FRXTQ4nSdqY43
 N8kNiQdgN3uZXadGTnTyHYwcyEK0EwHkTG5VCUREZjq4zzit3rVfFostSTqV5egXCaTQ
 FRe/dLvbCxk12Lr0+Unq0H2H742ZBIo+NH6cXWD0mWWqGm6CxzZb7OYfrZ7heyLDMgHI
 J6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790780307; x=1791385107;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tiOGbe6QwS+lK273Jv6wAWyqlgJxbqIAAEW+CpiRdWM=;
 b=rpyUvsP+FEuIsQOjNLv98G+52uHd+icnj8dN7uuD++IdhdTFwFH77WSaUJZdAMzEXZ
 5JoiPSbVywaduyPXU2Fv0DTsa1vdqllehi1khhG0uuGDoaBOnCxteEg237IuEHG2aJlB
 eMizXovy/H0yt7O2f3n9LpUntBu/0Mx/C1uojF31H71qVWz2rkWAQydYmWvDH2xKO5MF
 AqInt6jVPoPD/7+b3utgrd1JCyPSY0wnPE3F1e/yorcxDD1spHYbKR/5EzHjR+C4EGv+
 z8WTynirZJsb14xG6bOt1n35j1Ck9AKG2MkTWa8TiCAwutcE2carag2TJ2OffGcdgKQS
 yMfg==
X-Gm-Message-State: AFq9FYJJFH45kGsy+Y+A0ga3/25tSERad9WpDBx8OYdZsvcwx7f+UUjm
 g0y3I7W5S4TnUUBpk2Kb43RVWHMnM8Lgo9odIapXB6uEJKK7WFGWN/6k8VUJaT7FqIa7FpXI3fU
 KmKzv55QbWgxdKStG3qjlgPMcpkqDjlmDXSspc7D2FIDXDNqpy5eC1WWshLauKsNqEExuY1P485
 B8VSq4Hg==
X-Gm-Gg: AYBFou39YMe4suBfBFcB9oWajSIPRVvkwJU75HkbTDxF92jrc6uQ6bDCOOUI3tCYb/O
 jMF/TKi1X+BN+ZYOuJffQNqUh48oLRAdi6HKUW8z1ImYVQddzyTInrODksIZjuRXzngCRPpF7NW
 X/ac19vEorGD3c55I3eUmn4FKbfhUBUnpQatB2ehs46/FIj98fy3nSuxSuHlByXJXZgSzUpXojc
 HMbTiw0Xy+2eA52ehs3f6ook3SbzvhCgAh+gla7iCo8KfjJoGXMAQiqMkDS91asJR9ChUu+tKIt
 KU4IGRSODzCDC2dCJCn8TxOggehJlyyeX4oRhSsOMX5K5WyWD/6ck+1+3r/YmJF0vN89mL8EPqC
 RGBke734VKTKGrwwKbeqIwJwWYUPKNginuq3M5UVplRzCzlhn/G0tPMQGnsWxe7z4L3YAOyfkF3
 DneJn8dBYbC/GBgjv5OIzc9UZbbZmxXq5ILnXj3eMl5l8cHLIPkOd8UI7FPsISpDPwNGpz46XaY
 zXS+2dFB37P2a5G4eoe+pijZcKtsgsYGJWC9bURFPz7qKk4U8dkXPtMBz9yRYxePQwrEOh1ihlw
 1fS7RG0zqH9YURFfp20dz9vTLe2HnHhC0LmG+ghTrQT/HKMNDwfzhqiqk0kDNAzp1LXHHeA=
X-Received: by 2002:a05:6000:40ca:b0:488:8232:d159 with SMTP id
 ffacd0b85a97d-48b024ea411mr3151824f8f.13.1790780306761; 
 Wed, 30 Sep 2026 07:58:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b02a0d237sm3760019f8f.37.2026.09.30.07.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 07:58:26 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 14:58:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I09b055f15e35614eab112ff69166c6985f8770da
X-Gerrit-Change-Number: 1967
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1967?usp=email>
X-Gerrit-Commit: ed4d1c9aad6bc56ee758f897f105292a3a4815b6
In-Reply-To: <gerrit.1790780162000.I09b055f15e35614eab112ff69166c6985f8770da@gerrit.openvpn.net>
References: <gerrit.1790780162000.I09b055f15e35614eab112ff69166c6985f8770da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzgwMTYyMDAwLkkwOWIwNTVmMTVlMzU2MTRlYWIxMTJmZjY5MTY2YzY5ODVmODc3MGRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a7e4f2a95e0ddcace5dafa3bdecff43186cc39b6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBvlR-0007Fk-FG
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
Content-Type: multipart/mixed; boundary="===============3562356052084469030=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3562356052084469030==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TsxBRUcYT00="; charset=UTF-8

--TsxBRUcYT00=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1967?usp=3Demail )


Change subject: Assume termios=2Eh is =
available on all non Windows platforms
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Assume termios=2Eh is available on all non Window=
s platforms

Checking for something that is available on all (non Windows) =
platforms
is not very useful=2E So just always use termios=2Eh

Change-Id: =
I09b055f15e35614eab112ff69166c6985f8770da
Signed-off-by: Arne Schwabe <arne=
@rfc2549=2Eorg>
---
M configure=2Eac
M src/openvpn/console_builtin=2Ec
2 fi=
les changed, 6 insertions(+), 11 deletions(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/67/1967/2

diff --git a/configure=
=2Eac b/configure=2Eac
index 1fa0e63=2E=2E195116f 100644
--- a/configure=2E=
ac
+++ b/configure=2Eac
@@ -459,7 +459,7 @@
 	sys/time=2Eh sys/ioctl=2Eh sy=
s/stat=2Eh \
 	sys/mman=2Eh sys/file=2Eh sys/wait=2Eh \
 	libgen=2Eh stropt=
s=2Eh \
-	syslog=2Eh pwd=2Eh grp=2Eh termios=2Eh \
+	syslog=2Eh pwd=2Eh grp=
=2Eh \
 	sys/sockio=2Eh sys/uio=2Eh \
 	poll=2Eh sys/epoll=2Eh err=2Eh \
 ]=
)
diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/console_builti=
n=2Ec
index 9c8d72a=2E=2E10369283 100644
--- a/src/openvpn/console_builtin=
=2Ec
+++ b/src/openvpn/console_builtin=2Ec
@@ -37,7 +37,7 @@
 #include "buf=
fer=2Eh"
 #include "misc=2Eh"
 
-#ifdef HAVE_TERMIOS_H
+#ifndef _WIN32
 #in=
clude <termios=2Eh>
 #endif
 
@@ -134,10 +134,7 @@
     return false;
 }
 
=
-#endif /* _WIN32 */
-
-
-#ifdef HAVE_TERMIOS_H
+#else
 
 /**
  * Open the =
current console TTY for read/write operations
@@ -176,7 +173,7 @@
     }
 }=

 
-#endif /* HAVE_TERMIOS_H */
+#endif
 
 
 /**
@@ -197,10 +194,8 @@
     =
ASSERT(capacity > 0);
     input[0] =3D '\0';
 
-#if defined(_WIN32)
+#ifde=
f _WIN32
     return get_console_input_win32(prompt, echo, input, capacity)=
;
-#elif !defined(HAVE_TERMIOS_H)
-    msg(M_FATAL, "Sorry, but I can't get=
 console input on this OS (%s)", prompt);
 #else
     bool restore_tty =3D =
false;
     bool ret =3D false;
@@ -261,7 +256,7 @@
 
     close_tty(fp);
 =
    return ret;
-#endif /* if defined(_WIN32) */
+#endif
 }
 
 /**

-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09b055f15e35614eab112ff6=
9166c6985f8770da
Gerrit-Change-Number: 1967
Gerrit-PatchSet: 2
Gerrit-Owner=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--TsxBRUcYT00=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Assume termios=2Eh is available on all non Windows platforms<br><=
br>Checking for something that is available on all (non Windows) platforms<=
br>is not very useful=2E So just always use termios=2Eh<br><br>Change-Id: I=
09b055f15e35614eab112ff69166c6985f8770da<br>Signed-off-by: Arne Schwabe &lt=
;arne@rfc2549=2Eorg&gt;<br>---<br>M configure=2Eac<br>M src/openvpn/console=
_builtin=2Ec<br>2 files changed, 6 insertions(+), 11 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/67/1967/2</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/configure=2Eac b/configure=2Eac</spa=
n><br><span>index 1fa0e63=2E=2E195116f 100644</span><br><span>--- a/configu=
re=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -459,7 +459=
,7 @@</span><br><span> 	sys/time=2Eh sys/ioctl=2Eh sys/stat=2Eh \</span><br=
><span> 	sys/mman=2Eh sys/file=2Eh sys/wait=2Eh \</span><br><span> 	libgen=
=2Eh stropts=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	sy=
slog=2Eh pwd=2Eh grp=2Eh termios=2Eh \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	syslog=2Eh pwd=2Eh grp=2Eh \</span><br><span> 	sys/sock=
io=2Eh sys/uio=2Eh \</span><br><span> 	poll=2Eh sys/epoll=2Eh err=2Eh \</sp=
an><br><span> ])</span><br><span>diff --git a/src/openvpn/console_builtin=
=2Ec b/src/openvpn/console_builtin=2Ec</span><br><span>index 9c8d72a=2E=2E1=
0369283 100644</span><br><span>--- a/src/openvpn/console_builtin=2Ec</span>=
<br><span>+++ b/src/openvpn/console_builtin=2Ec</span><br><span>@@ -37,7 +3=
7,7 @@</span><br><span> #include &quot;buffer=2Eh&quot;</span><br><span> #i=
nclude &quot;misc=2Eh&quot;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef HAVE_TERMIOS_H</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span> #include &lt;term=
ios=2Eh&gt;</span><br><span> #endif</span><br><span> </span><br><span>@@ -1=
34,10 +134,7 @@</span><br><span>     return false;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /*=
 _WIN32 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef HAVE_TERMIOS_H</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#else</span><br><span> </span><br><span> /**</span>=
<br><span>  * Open the current console TTY for read/write operations</span>=
<br><span>@@ -176,7 +173,7 @@</span><br><span>     }</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif =
/* HAVE_TERMIOS_H */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span> </span><br><span> </span><br><span> /**</span><br>=
<span>@@ -197,10 +194,8 @@</span><br><span>     ASSERT(capacity &gt; 0);</s=
pan><br><span>     input[0] =3D &#39;\0&#39;;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span>   =
  return get_console_input_win32(prompt, echo, input, capacity);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#elif !defined(HAVE_TERMIOS_H)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_FATAL, &quot;=
Sorry, but I can&#39;t get console input on this OS (%s)&quot;, prompt);</s=
pan><br><span> #else</span><br><span>     bool restore_tty =3D false;</span=
><br><span>     bool ret =3D false;</span><br><span>@@ -261,7 +256,7 @@</sp=
an><br><span> </span><br><span>     close_tty(fp);</span><br><span>     ret=
urn ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if =
defined(_WIN32) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span> }</span><br><span> </span><br><span> /**</span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1967?usp=3Demail">change 1967</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1967?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I09b055f15e35614eab112ff69166c6985f8770da </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1967 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>

</body></html>
--TsxBRUcYT00=--


--===============3562356052084469030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3562356052084469030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3562356052084469030==--

