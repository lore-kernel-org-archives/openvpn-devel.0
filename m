Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C1DCA5FED
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lHIDTDd+h4SOk1a0zpjOWi1cYqJKwXSYSdIAOUkO7nc=; b=dXArDFHHurfJSreR+kucoLRkmz
	SffASI2BZxkajHmVvfXbDLZ9ePmgnQLxQui/TZUr9CjfzaOUfJGrhrMQyz3ooFuzqZv+zIZM2JofV
	1M1xpZ2tcVVfEa3MJ4/cbHjXlvtdudC3741N/U48hyRRKZfRJO8zTXe7EbuO87n0eApg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xD1ZY-0002ie-ET;
	Sat, 03 Oct 2026 15:22:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xD1ZV-0002iV-TA
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 15:22:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3vjwyT9MIqHnS6CIy9USztO0JcMc+eP2ESzPCeICguM=; b=gfTrYNO3hl4aSlENVc/Kxs5YKl
 AIltJgVXaz6/k3VcFwj5ELbkjbjB5LiD00i29rr3k5UuITGqHieE4AH2civB4sgpeXlNjz9WLyB1G
 gJ5x+yXpshdT6INei5pao+4NXudFLaO6mrcr0pLhMml1VbOCVljFJBaOJtyU2KH1VhGM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3vjwyT9MIqHnS6CIy9USztO0JcMc+eP2ESzPCeICguM=; b=X
 ERjoLSyh1y6LCVBsOrWfKIJB6xewQ2YP2oekohoQKCAn8fgmXTfi6/qWfX0SfvyOHDFZyEcc1nvlE
 6+5yOyEk69vojZ7GL7rn0Gsx6gEoy79Ub9wlwL5O9gAvKMyNxoUUPITpPkidyWOQdNpTG5YrgCv6M
 ey2qcv/x+n99dbgs=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xD1ZP-0000Vj-MQ for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 15:22:40 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a022e9cbebso5663315e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 03 Oct 2026 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791040953; x=1791645753; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3vjwyT9MIqHnS6CIy9USztO0JcMc+eP2ESzPCeICguM=;
 b=YmHh59LQC5/I+gTqw7J5Cx5k55CCJCE/YbUUvytVZaB4iC99C9R/6z7NC60812IImx
 6ZcRq+w9jJs5AUv/MN8bXpc5nFpWFdvIeTiOMSswCUNlhC5r0w7bzeiL0gF8w7bAY+E0
 MD1xxDVpAYCa6kka87TnK+8udslR1O5S8krT9G9jKuxi17NniiFInweFwFzLL6QeTeUx
 CxkeKV6V38NLqQYo0mHUjwmNHnY92InHZ2ZpDOtGviPtE6zP0VNldOOpO1qfLay5I0xZ
 a3oeuRfWcEGi74CtvkS8is6TI9Cpd4MavBieXeE48+8ntGJTsn3ATcxJWSRHSJA18yRy
 4AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791040953; x=1791645753;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3vjwyT9MIqHnS6CIy9USztO0JcMc+eP2ESzPCeICguM=;
 b=fWCfRFTtR0zBdt2cF3etJW1SoAVR29dVgMjunpRESy2lgMb3N9bxSVA29ca2T/oGDq
 ClvT9sy5nSCsTapDE4Xa8PyX0e5aqgKsT0KQmpW0X3B3bcNRMSgUmfBzqhLOlmlZps8D
 caSXV0H23iIVkUi6xzzM5dA9uQg45KCT1rMJC+YJHddd/8nwc3KVFVFcV1SfcooNG/5T
 r3ujbXIHbTXSuKhVHf97s7IHY83tKLeym13NLsX+8wo0zQd3lMw+E929C7bhGLvQveF+
 K96cR+igVWWI9tdYw+99WThDfARoKR+og5mbkHwhjvZq+oJq/CqYTAy3HO6g7/oiZ2wT
 Kipg==
X-Gm-Message-State: AFuF++nSfNRpYtgqm+dnn2aBzyUsNIvcYP9v1guZprl7xsTd3TCQr0zw
 CW14yCt+aifeIv+t2AU/uzi8713gHueEa2bIBMQrbY1/uEuNDEDk5PWQM1fJAa4h2d0F84UT6BY
 sLSr6b9l+nmzEOo83ojluCWjSjd6qnpf+3zKLX7BSlUXdRpew9rarcdrrAYFTxi68JlLg
X-Gm-Gg: AYBFou2oNVgaX9Vwz8NdAa0ksQle9W2Mim12CldnAxk5Vz7R4gw5H7lTVrDR+R4ViqW
 e9XQujWfyI7uWUt9yInhBVo822RZWa98T1Aj1W323q4ar+9riAUeFTdDTL0/WYrwu+UcOEW7mJf
 XUUoFaxI3R+Qi5st2lyb4HB5N4Qe6T06Kz2a0kZUKzvoBEcnAa4z21X7tv1sgyAMdKgE/7lQX1A
 zbb8n+kShWHRQRjpcStw+Ztl0tcL3KBre3YEMmk+gJrVeJj0dvOrwFcxP++STAvJnyWrc5xnQYQ
 txFybYnRuRsDhWYtvyZXzpRNDRzzM0WHNnogO2gkbVXX0qwD5lvmarjCmRg906c2kIgaE5GIYHs
 8vIZBvILKUYgtEEozpvpjDpKhhV6V0okxWCaMu/wYP91fV0rMfKALjgzLuN/7wyc5sYSdScf28l
 Y7UMwnDqxU2J0va3UUi46Vt2b2rumHf807fYF/lfD5P2FhKNkZJexAWqR7CtjSxsz17lqkmYWsu
 YVzOXdL5EHkRrTWjU4BarbNZYjyW2aXBppt0hp9f68Tc3sfwltwotR2+Xra5uyyfgZiBpLp0bV3
 YlnCr9+Wa+DZ1tXQi6ZGCDILHTRerfKhTN2ooocEKgeeD9N/Qnn0Crtio78A
X-Received: by 2002:a05:600c:4e13:b0:49e:7a10:1b71 with SMTP id
 5b1f17b1804b1-4a02754304fmr107117485e9.11.1791040952970; 
 Sat, 03 Oct 2026 08:22:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a16d6295f9sm22193525e9.14.2026.10.03.08.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 08:22:32 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 3 Oct 2026 15:22:30 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I09b055f15e35614eab112ff69166c6985f8770da
X-Gerrit-Change-Number: 1967
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1967?usp=email>
X-Gerrit-Commit: 2484e658c46d56910c9a7b6ce22ffa2144b12293
In-Reply-To: <gerrit.1790780162000.I09b055f15e35614eab112ff69166c6985f8770da@gerrit.openvpn.net>
References: <gerrit.1790780162000.I09b055f15e35614eab112ff69166c6985f8770da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzgwMTYyMDAwLkkwOWIwNTVmMTVlMzU2MTRlYWIxMTJmZjY5MTY2YzY5ODVmODc3MGRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <faec64c7b58bd9252b4596ed0a58eaa66cf21d77-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xD1ZP-0000Vj-MQ
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
Content-Type: multipart/mixed; boundary="===============9073429081668605725=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9073429081668605725==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qFjW6sK8RmE="; charset=UTF-8

--qFjW6sK8RmE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by plaisthos=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Frank Lichtenheld, Code-Review+2 by Gert Doering


Change subject:=
 Assume termios=2Eh is available on all non Windows platforms
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Assume termios=2Eh is ava=
ilable on all non Windows platforms

Checking for something that is availab=
le on all (non Windows) platforms
is not very useful=2E So just always use =
termios=2Eh

Change-Id: I09b055f15e35614eab112ff69166c6985f8770da
Signed-of=
f-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Gert Doering <gert@greeni=
e=2Emuc=2Ede>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit =
URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967
Message-Id: <202610031=
32620=2E12292-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg39661=2Ehtml
Signed-off-by: =
Gert Doering <gert@greenie=2Emuc=2Ede>
---
M configure=2Eac
M src/openvpn/c=
onsole_builtin=2Ec
2 files changed, 6 insertions(+), 11 deletions(-)


  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/67/1967/3

d=
iff --git a/configure=2Eac b/configure=2Eac
index 1fa0e63=2E=2E195116f 1006=
44
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -459,7 +459,7 @@
 	sys/time=
=2Eh sys/ioctl=2Eh sys/stat=2Eh \
 	sys/mman=2Eh sys/file=2Eh sys/wait=2Eh =
\
 	libgen=2Eh stropts=2Eh \
-	syslog=2Eh pwd=2Eh grp=2Eh termios=2Eh \
+	s=
yslog=2Eh pwd=2Eh grp=2Eh \
 	sys/sockio=2Eh sys/uio=2Eh \
 	poll=2Eh sys/e=
poll=2Eh err=2Eh \
 ])
diff --git a/src/openvpn/console_builtin=2Ec b/src/o=
penvpn/console_builtin=2Ec
index cf6cc37=2E=2E4737677 100644
--- a/src/open=
vpn/console_builtin=2Ec
+++ b/src/openvpn/console_builtin=2Ec
@@ -37,7 +37,=
7 @@
 #include "buffer=2Eh"
 #include "misc=2Eh"
 
-#ifdef HAVE_TERMIOS_H
+=
#ifndef _WIN32
 #include <termios=2Eh>
 #endif
 
@@ -133,10 +133,7 @@
     =
return false;
 }
 
-#endif /* _WIN32 */
-
-
-#ifdef HAVE_TERMIOS_H
+#else
 =

 /**
  * Open the current console TTY for read/write operations
@@ -175,7 =
+172,7 @@
     }
 }
 
-#endif /* HAVE_TERMIOS_H */
+#endif
 
 
 /**
@@ -196=
,10 +193,8 @@
     ASSERT(capacity > 0);
     input[0] =3D '\0';
 
-#if def=
ined(_WIN32)
+#ifdef _WIN32
     return get_console_input_win32(prompt, ech=
o, input, capacity);
-#elif !defined(HAVE_TERMIOS_H)
-    msg(M_FATAL, "Sor=
ry, but I can't get console input on this OS (%s)", prompt);
 #else
     bo=
ol restore_tty =3D false;
     bool ret =3D false;
@@ -260,7 +255,7 @@
 
  =
   close_tty(fp);
     return ret;
-#endif /* if defined(_WIN32) */
+#endif=

 }
 
 /**

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
967?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09b=
055f15e35614eab112ff69166c6985f8770da
Gerrit-Change-Number: 1967
Gerrit-Pat=
chSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--qFjW6sK8RmE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by plai=
sthos=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967?u=
sp=3Demail">View Change</a></p><p>The following approvals got outdated and =
were removed:
Code-Review+2 by Frank Lichtenheld, Code-Review+2 by Gert Doe=
ring</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">Assume termios=2Eh is available on all non Windows pl=
atforms<br><br>Checking for something that is available on all (non Windows=
) platforms<br>is not very useful=2E So just always use termios=2Eh<br><br>=
Change-Id: I09b055f15e35614eab112ff69166c6985f8770da<br>Signed-off-by: Arne=
 Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967<br>Me=
ssage-Id: &lt;20261003132620=2E12292-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g39661=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M configure=2Eac<br>M src/openvpn/console_builtin=2Ec<br>2 file=
s changed, 6 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/67/1967/3</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 1fa0=
e63=2E=2E195116f 100644</span><br><span>--- a/configure=2Eac</span><br><spa=
n>+++ b/configure=2Eac</span><br><span>@@ -459,7 +459,7 @@</span><br><span>=
 	sys/time=2Eh sys/ioctl=2Eh sys/stat=2Eh \</span><br><span> 	sys/mman=2Eh =
sys/file=2Eh sys/wait=2Eh \</span><br><span> 	libgen=2Eh stropts=2Eh \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	syslog=2Eh pwd=2Eh grp=2E=
h termios=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	sys=
log=2Eh pwd=2Eh grp=2Eh \</span><br><span> 	sys/sockio=2Eh sys/uio=2Eh \</s=
pan><br><span> 	poll=2Eh sys/epoll=2Eh err=2Eh \</span><br><span> ])</span>=
<br><span>diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/consol=
e_builtin=2Ec</span><br><span>index cf6cc37=2E=2E4737677 100644</span><br><=
span>--- a/src/openvpn/console_builtin=2Ec</span><br><span>+++ b/src/openvp=
n/console_builtin=2Ec</span><br><span>@@ -37,7 +37,7 @@</span><br><span> #i=
nclude &quot;buffer=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&quot=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fdef HAVE_TERMIOS_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifndef _WIN32</span><br><span> #include &lt;termios=2Eh&gt;</span><br><spa=
n> #endif</span><br><span> </span><br><span>@@ -133,10 +133,7 @@</span><br>=
<span>     return false;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif /* _WIN32 */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef HAVE_TERMIOS_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
lse</span><br><span> </span><br><span> /**</span><br><span>  * Open the cur=
rent console TTY for read/write operations</span><br><span>@@ -175,7 +172,7=
 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_TERMIOS_H */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> <=
/span><br><span> </span><br><span> /**</span><br><span>@@ -196,10 +193,8 @@=
</span><br><span>     ASSERT(capacity &gt; 0);</span><br><span>     input[0=
] =3D &#39;\0&#39;;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(_WIN32)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifdef _WIN32</span><br><span>     return get_console_input=
_win32(prompt, echo, input, capacity);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#elif !defined(HAVE_TERMIOS_H)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    msg(M_FATAL, &quot;Sorry, but I can&#39;t get=
 console input on this OS (%s)&quot;, prompt);</span><br><span> #else</span=
><br><span>     bool restore_tty =3D false;</span><br><span>     bool ret =
=3D false;</span><br><span>@@ -260,7 +255,7 @@</span><br><span> </span><br>=
<span>     close_tty(fp);</span><br><span>     return ret;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(_WIN32) */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> }<=
/span><br><span> </span><br><span> /**</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail">chang=
e 1967</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I09b055f15e35614eab112ff69166c6985f8770da </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1967 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--qFjW6sK8RmE=--


--===============9073429081668605725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9073429081668605725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9073429081668605725==--

