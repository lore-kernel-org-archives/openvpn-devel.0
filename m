Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A64C61DBE
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eYP9YAuZQhFAwjI2rOPo6fl2e1F/hzR7H//v4+QifNM=; b=BKiiOTse/z6ctsZwNDEGDybBb9
	SIUcdbGZul6BwncxYK+EiEQvCiv4Bl8ZvETiDke4KD2cHxQQ/+612sxP1AB/jWxcSbX7yP+3WhfHw
	U4uOS6ux9forq+3hG02yAgJSuJ6T8qS3hjmvu9viqfJw30rc22MmsEClzVOuV5Nz5pyA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzL65-0001Yc-Mz;
	Wed, 26 Aug 2026 21:23:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzL64-0001YV-Kq
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 21:23:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GDEp7bYa9W0EuPu8l5rN0LFIugvjqbe3WNi5pLT23Hg=; b=NAEKU/sh7WHyIYmmEJWX9A4/Tv
 hWkxgVZcyTRJSr13i5jTfQIDk/+RIsMrBF+sDyKgbsnPZntksgKnE7HB/86tcfNghA6CfTC/DKoc1
 cCNUM6IZue5uQc/Of1jsT5DXMMs66JN7qglBlxy3CkRVjfxltkMkkNucMUxPDKsDL/b4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GDEp7bYa9W0EuPu8l5rN0LFIugvjqbe3WNi5pLT23Hg=; b=g
 /24tEhIIK4PtAYqR2cpgfs0ME/QczPUM8Lv2tgKeSjalGAVvP774+PK1q88JvCm0IgnRYTAwMDXev
 pQAs3XO/M5DuLRTxzxVQIM3sbn5poQ6/hsqC9w4qvlIEE5qGqo/zhGE+BuMpvI9KU0Ip0A9BXc3ZC
 Y+lSuhDwlKgPDa2A=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzL62-0002Sg-KG for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 21:23:48 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so11776505e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 14:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787779420; x=1788384220; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GDEp7bYa9W0EuPu8l5rN0LFIugvjqbe3WNi5pLT23Hg=;
 b=PJzne6VrG3SZ45Ei9kdl+X2R6SZICfLMrAczP1AhkzGaWc+06L6ol22ICn4IRgQd7b
 fvshhf+FpWc+4T5S6Liz+XLy+L6gSmHL/UhChNwG98zxyPG3Hwaqh0ET6+i0qinUPuAQ
 DiXvhjfkTdkOhQY8kneNMfVsbfyGQLQLLvnOMTksD3jL5YcY5B1Jpf9BslISxHyZECmV
 al3ruX9NquJoZ8A46wwWDT5SZaNAAOL8DBVzIK1wgvHNpp/5xjZLrkpwgJSvvafF1rr+
 cGGLGtWdkWMdrSv+SUUlAcxvK4X5s5vP+uaIRvl/jQuLgL7LrVkyww+iZYIxVojhMzhD
 Kg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787779420; x=1788384220;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GDEp7bYa9W0EuPu8l5rN0LFIugvjqbe3WNi5pLT23Hg=;
 b=Tdo3GuoeYxiZh+1oIIDlBox6tIE2ozt5cakEzKT+xmX/7fE6uiUC3KlwXX9tufvSz1
 TuoU4y3m82xdpdih2NzsZjSKtB00CWjM8+cDXDKjmPyMuv+DeSkNACKr10YSUXcw3G9A
 UrPo9ytkqhnI9UiU097l+cmkrTFa1n/RnjTzt4yqJczEAuI13tACussaTXRSxOoN5VyE
 /u86wplIUr2oSRMAQ9vG7jlfMZLzWNWIiITIUPypDhCtkpb10xSs3peEbefDfc08h64m
 DIg018BjqHeI+GgyFEwVL97woM5X0IOH1SRv2M9Ir3M6rOGu/y3m7EDn47TrNQOpb9Zx
 yPDA==
X-Gm-Message-State: AFuF++n403nouaYxcFandN5w6dZyrIYSWPHhN10wJmLmuNShjLsROFwO
 3K/2F3B/uJvG6bIM2aOwBOD7s+Weo91d/Km4xwMJQYczlpG6MQjJMYhSK8P1vbPOyQOohp9w5PY
 1lWTegsKe0ru0pmJQ9UD2Bm1XyE3mNnXJf3hvWt8UwVrWVHxRpNzv2uUtUCtK9pLA01OdEIWANZ
 zeOjCLHg==
X-Gm-Gg: AR+sD12f2hK0qksXK4lnQn5cQWFhxaNY50ZXJz1opxsN8DsM6+qSsOCE786SjLyZard
 Nss+chbV60v1kN6W6W2ml2YkufFqGIPxQExRjpzBmoda5bWzXfZeulEtbz6yNONs6ZtbG7cHOJC
 5wsWIRcHI/LR7JNYFJJzQ56iJ5Fs5KVSzXTagQvLIvFQh6SBotDuLDW2WxI/RVjjgelj3MAIzZI
 MtCm7uU/USw7716ZYiHZ1QZ62dRsTMWFVfMPvOJPHg+JEJtPeymnzEcI/gPx8w4AEMk3Xlz5oYJ
 YTG0wd4aFaNfx+n3woBC+jwFDCT1MjKOb1JbLjUkmd/HV2p91SjDo2rBXEv53MGgevsUtukZ+8l
 b6czeynTwDGIU2d9CCE4c2h8inVmbOO6vHyHqYo7xWzoKQFAA8N+rVi/Dihrg/bTwxsgGEIWpLc
 LkaOS5V8AYx8/RdZujCY5qeqkyC0E/zvaxFl4Jc80IsWbn94WoehjkpQd8mjlRghCbSJf/1k9kL
 GyVqk2n0ffuKMiGb1bVR3sFJaBYvswgDYzhEYbdYZkc3TeUgtEaUjGuMvEn8u/zZBSleEPo1TMb
 B7Hmx5CggbFuRa2Zy5GZY5cTxGcSp286zd8mEnPpZyHfgs6CX9Q=
X-Received: by 2002:a05:600c:198b:b0:499:900c:9c68 with SMTP id
 5b1f17b1804b1-499dc6faea2mr97628405e9.6.1787779419874; 
 Wed, 26 Aug 2026 14:23:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28dbe29sm4262276f8f.17.2026.08.26.14.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 14:23:39 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 21:23:37 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 178afa9fc7b5a7b499297aa6361beb423d4e845b
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5a3e08ac5b94876463dc5b41c055b2e6f277f0c6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzL62-0002Sg-KG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5905687130479743082=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5905687130479743082==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7RGnOmXhomY="; charset=UTF-8

--7RGnOmXhomY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1852?usp=3Demail

to look at the new patch set (#1=
0)=2E


Change subject: Add unix-script functionality to the --management f=
eature
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add =
unix-script functionality to the --management feature

This allows a script=
 that handles management input/output to
be started alongside OpenVPN simpl=
er in small deployments=2E

Change-Id: I307e64079f436aa782f7e24bfff665a545a=
d2fa0
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M doc/man-sectio=
ns/management-options=2Erst
M doc/management-notes=2Etxt
M src/openvpn/init=
=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/option=
s=2Ec
M src/openvpn/options=2Eh
7 files changed, 117 insertions(+), 11 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/52/1852/10

diff --git a/doc/man-sections/management-options=2Erst b/doc=
/man-sections/management-options=2Erst
index 8dad52b=2E=2Ee2e0773 100644
--=
- a/doc/man-sections/management-options=2Erst
+++ b/doc/man-sections/manage=
ment-options=2Erst
@@ -14,6 +14,7 @@
     management socket-name unix pw-fi=
le  # (recommended)
     management IP port                   # (INSECURE)
=
     management IP port pw-file           #
+    management script unix-scr=
ipt
 
   ``pw-file``, if specified, is a password file where the password m=
ust
   be on first line=2E Instead of a filename it can use the keyword std=
in
@@ -25,6 +26,14 @@
   ``--management-client-user`` and ``--management-cl=
ient-group``
   directives to restrict access=2E
 
+  When the variant :cod=
e:`unix-script` is used, OpenVPN will start the
+  specified script on star=
tup and enable ``--management-hold``=2E
+  OpenVPN will generate a random p=
ath for the unix socket
+  and management password=2E These are passed as e=
nvironment
+  variables :code:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_PASSWO=
RD`
+  to the script when being started=2E When OpenVPN terminates it sends=

+  a :code:`SIGINT` signal to the running script=2E
+
   The management in=
terface provides a special mode where the TCP
   management link can operat=
e over the tunnel itself=2E To enable this mode,
   set IP to ``tunnel``=2E=
 Tunnel mode will cause the management interface to
@@ -127,10 +136,11 @@
 =
  (client-only)=2E
 
 --management-signal
-  Send SIGUSR1 signal to OpenVPN=
 if management session disconnects=2E This
-  is useful when you wish to di=
sconnect an OpenVPN session on user logoff=2E
-  For ``--management-client`=
` this option is not needed since a disconnect
-  will always generate a :c=
ode:`SIGTERM`=2E
+  Send :code:`SIGUSR1` signal to OpenVPN if management se=
ssion disconnects=2E
+  This is useful when you wish to disconnect an OpenV=
PN session on user
+  logoff=2E For ``--management-client`` or ``--manageme=
nt`` with
+  :code:`unixscript` this option has no effect since a disconnec=
t will
+  always trigger sending a :code:`SIGTERM`=2E
 
 --management-up-do=
wn
   Report tunnel up/down events to management interface=2E
diff --git a/=
doc/management-notes=2Etxt b/doc/management-notes=2Etxt
index 1126468=2E=2E=
d6b3fbb 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=
=2Etxt
@@ -35,6 +35,10 @@
 you can telnet to the management port (make sure=
 to use
 a telnet client which understands "raw" mode)=2E
 
+When password =
authentication is enabled, the management interface
+will require sending t=
he password on its own line after establishing
+the connection=2E
+
 Once c=
onnected to the management port, you can use
 the "help" command to list al=
l commands=2E
 
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
in=
dex 1109a13=2E=2E3b1f673 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvp=
n/init=2Ec
@@ -4329,19 +4329,65 @@
     }
 }
 
+void
+run_management_script=
(struct context *c)
+{
+#if UNIX_SOCK_SUPPORT
+    struct gc_arena gc =3D g=
c_new();
+    struct argv argv =3D argv_new();
+    struct env_set *env =3D=
 env_set_create(&gc);
+
+    setenv_str(env, "MANAGEMENT_USER", management-=
>settings=2Eup=2Eusername);
+    setenv_str(env, "MANAGEMENT_PASSWORD", man=
agement->settings=2Eup=2Epassword);
+    setenv_str(env, "MANAGEMENT_SOCKET=
", c->options=2Emanagement_addr);
+
+    argv_printf(&argv, "%s", c->option=
s=2Emanagement_script);
+
+    int flags =3D S_NOWAITPID | S_SCRIPT | S_FAT=
AL;
+    int *pid =3D &management->connection=2Eunix_script_pid;
+    const=
 char *msg_prefix =3D "WARNING: Failed running management unix-script";
+  =
  *pid =3D openvpn_execve_check(&argv, env, flags, msg_prefix);
+
+    if (=
!openvpn_waitpid_check(*pid, msg_prefix, M_FATAL))
+    {
+        *pid =3D=
 0;
+    }
+
+    argv_free(&argv);
+    gc_free(&gc);
+#else
+    msg(M_FA=
TAL, "ERROR: Management unix-socket support is not available on this platfo=
rm");
+#endif
+}
+
 bool
 open_management(struct context *c)
 {
     /* ini=
tialize management layer */
     if (management)
     {
+        unsigned i=
nt flags =3D c->options=2Emanagement_flags;
+        if (flags & MF_UNIX_SO=
CK_SCRIPT)
+        {
+            /* This creates a filename that should b=
e ungessuable */
+            char sockname[64] =3D { 0 };
+            snp=
rintf(sockname, sizeof(sockname),
+                     PACKAGE_NAME "_omi_=
%08" PRIx64 "%08" PRIx64 "=2Esock",
+                     get_random(), get=
_random());
+
+            c->options=2Emanagement_addr =3D platform_gen_pa=
th(platform_get_tmp_dir(), sockname, &c->gc);
+
+            c->options=2Em=
anagement_addr =3D platform_create_temp_file(
+                platform_get=
_tmp_dir(), "omi", &c->gc);
+        }
+
         if (c->options=2Emanageme=
nt_addr)
         {
-            unsigned int flags =3D c->options=2Emanage=
ment_flags;
             if (c->options=2Emode =3D=3D MODE_SERVER)
        =
     {
                 flags |=3D MF_SERVER;
             }
+
            =
 if (management_open(
                     management, c->options=2Emanagem=
ent_addr, c->options=2Emanagement_port,
                     c->options=2Em=
anagement_user_pass, c->options=2Emanagement_client_user,
@@ -4353,6 +4399,=
11 @@
                                      NULL);
             }
 
+      =
      if (flags & MF_UNIX_SOCK_SCRIPT)
+            {
+                run_=
management_script(c);
+            }
+
             /* initial management h=
old, called early, before first context initialization */
             do_h=
old(0);
             if (IS_SIG(c))
diff --git a/src/openvpn/manage=2Ec b/s=
rc/openvpn/manage=2Ec
index 2b0a661=2E=2E29fdffc 100644
--- a/src/openvpn/m=
anage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -333,10 +333,12 @@
 man_delete_un=
ix_socket(struct management *man)
 {
 #if UNIX_SOCK_SUPPORT
-    if ((man->=
settings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SO=
CK)
+    if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)=
) =3D=3D MF_UNIX_SOCK
+        || man->settings=2Eflags & MF_UNIX_SOCK_SCRI=
PT)
     {
         socket_delete_unix(&man->settings=2Elocal_unix);
     }=

+
 #endif
 }
 
@@ -2197,10 +2199,18 @@
             }
         }
 
+      =
  if (man->settings=2Eflags & MF_UNIX_SOCK_SCRIPT && !man_password_needed(m=
an))
+        {
+            msg(D_MANAGEMENT, "MANAGEMENT: Triggering exit=
 on unix-script disconnect");
+            throw_signal_soft(SIGTERM, "mana=
gement-exit");
+        }
+
         if (man->settings=2Eflags & MF_CONNECT=
_AS_CLIENT)
         {
-            msg(D_MANAGEMENT, "MANAGEMENT: Triggeri=
ng management exit");
-            throw_signal_soft(SIGTERM, "management-e=
xit");
+            {
+                msg(D_MANAGEMENT, "MANAGEMENT: Trigg=
ering management exit");
+                throw_signal_soft(SIGTERM, "manag=
ement-exit");
+            }
         }
         else
         {
@@ -2644,6=
 +2654,15 @@
         {
             get_user_pass(&ms->up, pass_file, "Man=
agement", GET_USER_PASS_PASSWORD_ONLY);
         }
+        else if (ms->fl=
ags & MF_UNIX_SOCK_SCRIPT)
+        {
+            /* Set random password=
=2E The password is only
+             * alphanumerical [0-9a-f] but still =
has 128 bit of randomness,
+             * which is more than enough */
+  =
          snprintf(ms->up=2Epassword, sizeof(ms->up=2Epassword),
+         =
            "%" PRIx64 "%" PRIx64, get_random(), get_random());
+          =
  ms->up=2Edefined =3D true;
+        }
 
 #if UNIX_SOCK_SUPPORT
         /=
*
@@ -2789,6 +2808,13 @@
         man_close_socket(man, mc->sd_cli);
     }=

 
+#if UNIX_SOCK_SUPPORT
+    if (mc->unix_script_pid)
+    {
+        kil=
l(mc->unix_script_pid, SIGINT);
+    }
+#endif
+
     command_line_free(mc-=
>in);
     buffer_list_free(mc->out);
 
diff --git a/src/openvpn/manage=2Eh=
 b/src/openvpn/manage=2Eh
index 27d3b60=2E=2Ef752fec 100644
--- a/src/openv=
pn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -42,6 +42,7 @@
 #define MF_EX=
TERNAL_CERT          (1u << 15)
 #define MF_EXTERNAL_KEY_PSSPAD    (1u << 1=
6)
 #define MF_EXTERNAL_KEY_DIGEST    (1u << 17)
+#define MF_UNIX_SOCK_SCRI=
PT       (1u << 18)
 
 #ifdef ENABLE_MANAGEMENT
 
@@ -327,6 +328,9 @@
     =
int fdtosend;
     int lastfdreceived;
 #endif
+#if UNIX_SOCK_SUPPORT
+    =
pid_t unix_script_pid;
+#endif
     int client_version;
 };
 
diff --git a/=
src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 5f3f4e9=2E=2E1939c6=
9 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -17=
20,7 +1720,7 @@
      * Check for consistency of management options
      *=
/
 #ifdef ENABLE_MANAGEMENT
-    if (!options->management_addr
+    if (!op=
tions->management_addr && !(options->management_flags & MF_UNIX_SOCK_SCRIPT=
)
         && (options->management_flags
             || options->managemen=
t_log_history_cache !=3D defaults=2Emanagement_log_history_cache))
     {
@=
@ -4301,7 +4301,7 @@
     else if (streq(p[0], "management") && p[1] && p[2=
] && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (=
streq(p[2], "unix"))
+        if (streq(p[2], "unix") || streq(p[2], "unix-=
script"))
         {
 #if UNIX_SOCK_SUPPORT
             options->managemen=
t_flags |=3D MF_UNIX_SOCK;
@@ -4311,7 +4311,16 @@
 #endif
         }
 
-   =
     options->management_addr =3D p[1];
+        if (streq(p[2], "unix-scri=
pt"))
+        {
+            options->management_flags |=3D MF_UNIX_SOCK_S=
CRIPT | MF_HOLD;
+            set_user_script(options, &options->management=
_script, p[1],
+                            "management unix-script", false=
);
+        }
+        else
+        {
+            options->management_add=
r =3D p[1];
+        }
         options->management_port =3D p[2];
        =
 if (p[3])
         {
diff --git a/src/openvpn/options=2Eh b/src/openvpn/op=
tions=2Eh
index f472676=2E=2E131513e 100644
--- a/src/openvpn/options=2Eh
+=
++ b/src/openvpn/options=2Eh
@@ -446,6 +446,8 @@
     const char *managemen=
t_addr;
     const char *management_port;
     const char *management_user_=
pass;
+    /** Script executed to talk to the management interface */
+    =
const char *management_script;
     int management_log_history_cache;
     =
int management_echo_buffer_size;
     int management_state_buffer_size;

--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I307e64079f436aa782f=
7e24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
Gerrit-PatchSet: 10
Gerrit=
-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>

--7RGnOmXhomY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #10</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">A=
dd unix-script functionality to the --management feature<br><br>This allows=
 a script that handles management input/output to<br>be started alongside O=
penVPN simpler in small deployments=2E<br><br>Change-Id: I307e64079f436aa78=
2f7e24bfff665a545ad2fa0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;<br>---<br>M doc/man-sections/management-options=2Erst<br>M doc/manag=
ement-notes=2Etxt<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>=
M src/openvpn/manage=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/opti=
ons=2Eh<br>7 files changed, 117 insertions(+), 11 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/52/1852/10</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/doc/man-sections/management-options=2E=
rst b/doc/man-sections/management-options=2Erst</span><br><span>index 8dad5=
2b=2E=2Ee2e0773 100644</span><br><span>--- a/doc/man-sections/management-op=
tions=2Erst</span><br><span>+++ b/doc/man-sections/management-options=2Erst=
</span><br><span>@@ -14,6 +14,7 @@</span><br><span>     management socket-n=
ame unix pw-file  # (recommended)</span><br><span>     management IP port  =
                 # (INSECURE)</span><br><span>     management IP port pw-fi=
le           #</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
anagement script unix-script</span><br><span> </span><br><span>   ``pw-file=
``, if specified, is a password file where the password must</span><br><spa=
n>   be on first line=2E Instead of a filename it can use the keyword stdin=
</span><br><span>@@ -25,6 +26,14 @@</span><br><span>   ``--management-clien=
t-user`` and ``--management-client-group``</span><br><span>   directives to=
 restrict access=2E</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  When the variant :code:`unix-script` is used, OpenVPN w=
ill start the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  spec=
ified script on startup and enable ``--management-hold``=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN will generate a random pa=
th for the unix socket</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  and management password=2E These are passed as environment</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  variables :code:`MANAGEMENT_S=
OCKET`, :code:`MANAGEMENT_PASSWORD`</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  to the script when being started=2E When OpenVPN terminat=
es it sends</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a :cod=
e:`SIGINT` signal to the running script=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>   The management interface provide=
s a special mode where the TCP</span><br><span>   management link can opera=
te over the tunnel itself=2E To enable this mode,</span><br><span>   set IP=
 to ``tunnel``=2E Tunnel mode will cause the management interface to</span>=
<br><span>@@ -127,10 +136,11 @@</span><br><span>   (client-only)=2E</span><=
br><span> </span><br><span> --management-signal</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  Send SIGUSR1 signal to OpenVPN if management se=
ssion disconnects=2E This</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  is useful when you wish to disconnect an OpenVPN session on user logo=
ff=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  For ``--manage=
ment-client`` this option is not needed since a disconnect</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  will always generate a :code:`SIGTER=
M`=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Send :code:`=
SIGUSR1` signal to OpenVPN if management session disconnects=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  This is useful when you wish =
to disconnect an OpenVPN session on user</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  logoff=2E For ``--management-client`` or ``--managem=
ent`` with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`=
unixscript` this option has no effect since a disconnect will</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  always trigger sending a :code:=
`SIGTERM`=2E</span><br><span> </span><br><span> --management-up-down</span>=
<br><span>   Report tunnel up/down events to management interface=2E</span>=
<br><span>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2E=
txt</span><br><span>index 1126468=2E=2Ed6b3fbb 100644</span><br><span>--- a=
/doc/management-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etx=
t</span><br><span>@@ -35,6 +35,10 @@</span><br><span> you can telnet to the=
 management port (make sure to use</span><br><span> a telnet client which u=
nderstands &quot;raw&quot; mode)=2E</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+When password authentication is enabled, =
the management interface</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+will require sending the password on its own line after establishing</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+the connection=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Once =
connected to the management port, you can use</span><br><span> the &quot;he=
lp&quot; command to list all commands=2E</span><br><span> </span><br><span>=
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>in=
dex 1109a13=2E=2E3b1f673 100644</span><br><span>--- a/src/openvpn/init=2Ec<=
/span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -4329,19 +432=
9,65 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+run_management_script(struct context *c)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct argv arg=
v =3D argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct env_set *env =3D env_set_create(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    setenv_str(env, &quot;MANAGEMENT_USER&quot;, management-&gt=
;settings=2Eup=2Eusername);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    setenv_str(env, &quot;MANAGEMENT_PASSWORD&quot;, management-&gt=
;settings=2Eup=2Epassword);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    setenv_str(env, &quot;MANAGEMENT_SOCKET&quot;, c-&gt;options=2E=
management_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;=
argv, &quot;%s&quot;, c-&gt;options=2Emanagement_script);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int flags =3D S_NOWAITPID | S_SCRIPT | S_FATAL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int *pid =3D &amp;ma=
nagement-&gt;connection=2Eunix_script_pid;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *msg_prefix =3D &quot;WARNING: Failed=
 running management unix-script&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    *pid =3D openvpn_execve_check(&amp;argv, env, flags,=
 msg_prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!openvpn_waitpid_=
check(*pid, msg_prefix, M_FATAL))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        *pid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    argv_free(&amp;argv);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL, &quot;ERROR: Managemen=
t unix-socket support is not available on this platform&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> bool</span><br><span> open_management(struct=
 context *c)</span><br><span> {</span><br><span>     /* initialize manageme=
nt layer */</span><br><span>     if (management)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int fl=
ags =3D c-&gt;options=2Emanagement_flags;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (flags &amp; MF_UNIX_SOCK_SCRIPT)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /* This creates a filename=
 that should be ungessuable */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            char sockname[64] =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            snprintf(sockname, sizeof(soc=
kname),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
         PACKAGE_NAME &quot;_omi_%08&quot; PRIx64 &quot;%08&quot; PRIx64 &q=
uot;=2Esock&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                    get_random(), get_random());</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            c-&gt;options=2Emanagement_addr =3D platform_gen_path=
(platform_get_tmp_dir(), sockname, &amp;c-&gt;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            c-&gt;options=2Emanagement_addr =3D platform_create=
_temp_file(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        platform_get_tmp_dir(), &quot;omi&quot;, &amp;c-&gt;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (c-&gt;opti=
ons=2Emanagement_addr)</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            unsigned int flags =3D c-&gt;option=
s=2Emanagement_flags;</span><br><span>             if (c-&gt;options=2Emode=
 =3D=3D MODE_SERVER)</span><br><span>             {</span><br><span>       =
          flags |=3D MF_SERVER;</span><br><span>             }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             if=
 (management_open(</span><br><span>                     management, c-&gt;o=
ptions=2Emanagement_addr, c-&gt;options=2Emanagement_port,</span><br><span>=
                     c-&gt;options=2Emanagement_user_pass, c-&gt;options=2E=
management_client_user,</span><br><span>@@ -4353,6 +4399,11 @@</span><br><s=
pan>                                      NULL);</span><br><span>          =
   }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                run_management_script(c);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             /=
* initial management hold, called early, before first context initializatio=
n */</span><br><span>             do_hold(0);</span><br><span>             =
if (IS_SIG(c))</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/op=
envpn/manage=2Ec</span><br><span>index 2b0a661=2E=2E29fdffc 100644</span><b=
r><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/mana=
ge=2Ec</span><br><span>@@ -333,10 +333,12 @@</span><br><span> man_delete_un=
ix_socket(struct management *man)</span><br><span> {</span><br><span> #if U=
NIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =
=3D=3D MF_UNIX_SOCK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIE=
NT)) =3D=3D MF_UNIX_SOCK</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        || man-&gt;settings=2Eflags &amp; MF_UNIX_SOCK_SCRIPT)</span><=
br><span>     {</span><br><span>         socket_delete_unix(&amp;man-&gt;se=
ttings=2Elocal_unix);</span><br><span>     }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> #endif</span><br><span> }</span>=
<br><span> </span><br><span>@@ -2197,10 +2199,18 @@</span><br><span>       =
      }</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;settings=2Eflags &amp=
; MF_UNIX_SOCK_SCRIPT &amp;&amp; !man_password_needed(man))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(D_MANAGEMENT, &quot;MANAGEMEN=
T: Triggering exit on unix-script disconnect&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            throw_signal_soft(SIGTERM, &q=
uot;management-exit&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>         if (man-&gt;settings=2Eflags &amp; MF_CONNECT_AS_CL=
IENT)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            msg(D_MANAGEMENT, &quot;MANAGEMENT: Triggering manag=
ement exit&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         throw_signal_soft(SIGTERM, &quot;management-exit&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                msg(D_MANAGEMENT, &=
quot;MANAGEMENT: Triggering management exit&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                throw_signal_soft(SIGTERM=
, &quot;management-exit&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span>         }</span><br><span>      =
   else</span><br><span>         {</span><br><span>@@ -2644,6 +2654,15 @@</=
span><br><span>         {</span><br><span>             get_user_pass(&amp;m=
s-&gt;up, pass_file, &quot;Management&quot;, GET_USER_PASS_PASSWORD_ONLY);<=
/span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        else if (ms-&gt;flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* Set random password=2E The=
 password is only</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
           * alphanumerical [0-9a-f] but still has 128 bit of randomness,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * which =
is more than enough */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            snprintf(ms-&gt;up=2Epassword, sizeof(ms-&gt;up=2Epassword),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
  &quot;%&quot; PRIx64 &quot;%&quot; PRIx64, get_random(), get_random());</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms-&gt;up=
=2Edefined =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span> </span><br><span> #if UNIX_SOCK_SUPPORT</span><=
br><span>         /*</span><br><span>@@ -2789,6 +2808,13 @@</span><br><span=
>         man_close_socket(man, mc-&gt;sd_cli);</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if UN=
IX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (mc-&gt;unix_script_pid)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  kill(mc-&gt;unix_script_pid, SIGINT);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     command_line_free(mc-&gt;in);</span><br><span>     buffer_li=
st_free(mc-&gt;out);</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 27d3b60=2E=
=2Ef752fec 100644</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><s=
pan>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -42,6 +42,7 @@</span><b=
r><span> #define MF_EXTERNAL_CERT          (1u &lt;&lt; 15)</span><br><span=
> #define MF_EXTERNAL_KEY_PSSPAD    (1u &lt;&lt; 16)</span><br><span> #defi=
ne MF_EXTERNAL_KEY_DIGEST    (1u &lt;&lt; 17)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define MF_UNIX_SOCK_SCRIPT       (1u &lt;&lt; 18=
)</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><sp=
an> </span><br><span>@@ -327,6 +328,9 @@</span><br><span>     int fdtosend;=
</span><br><span>     int lastfdreceived;</span><br><span> #endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    pid_t unix_script_pid;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an>     int client_version;</span><br><span> };</span><br><span> </span><br=
><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span=
><br><span>index 5f3f4e9=2E=2E1939c69 100644</span><br><span>--- a/src/open=
vpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><sp=
an>@@ -1720,7 +1720,7 @@</span><br><span>      * Check for consistency of m=
anagement options</span><br><span>      */</span><br><span> #ifdef ENABLE_M=
ANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!opt=
ions-&gt;management_addr</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!options-&gt;management_addr &amp;&amp; !(options-&gt;manageme=
nt_flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>         &amp;&amp; (op=
tions-&gt;management_flags</span><br><span>             || options-&gt;mana=
gement_log_history_cache !=3D defaults=2Emanagement_log_history_cache))</sp=
an><br><span>     {</span><br><span>@@ -4301,7 +4301,7 @@</span><br><span> =
    else if (streq(p[0], &quot;management&quot;) &amp;&amp; p[1] &amp;&amp;=
 p[2] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>         VER=
IFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (streq(p[2], &quot;unix&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (streq(p[2], &quot;unix&quot;)=
 || streq(p[2], &quot;unix-script&quot;))</span><br><span>         {</span>=
<br><span> #if UNIX_SOCK_SUPPORT</span><br><span>             options-&gt;m=
anagement_flags |=3D MF_UNIX_SOCK;</span><br><span>@@ -4311,7 +4311,16 @@</=
span><br><span> #endif</span><br><span>         }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;managemen=
t_addr =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (streq(p[2], &quot;unix-script&quot;))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            options-&gt;management_flags |=3D MF_UNIX_SOCK=
_SCRIPT | MF_HOLD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           set_user_script(options, &amp;options-&gt;management_script, p[1=
],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
           &quot;management unix-script&quot;, false);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            options-&gt;management_addr =3D p[1];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         op=
tions-&gt;management_port =3D p[2];</span><br><span>         if (p[3])</spa=
n><br><span>         {</span><br><span>diff --git a/src/openvpn/options=2Eh=
 b/src/openvpn/options=2Eh</span><br><span>index f472676=2E=2E131513e 10064=
4</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/o=
penvpn/options=2Eh</span><br><span>@@ -446,6 +446,8 @@</span><br><span>    =
 const char *management_addr;</span><br><span>     const char *management_p=
ort;</span><br><span>     const char *management_user_pass;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /** Script executed to talk to =
the management interface */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *management_script;</span><br><span>     int managem=
ent_log_history_cache;</span><br><span>     int management_echo_buffer_size=
;</span><br><span>     int management_state_buffer_size;</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1852?usp=3Demail">change 1852</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1852?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545=
ad2fa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1852 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>

</body></html>
--7RGnOmXhomY=--


--===============5905687130479743082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5905687130479743082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5905687130479743082==--

