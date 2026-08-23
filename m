Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A7EC5DF81
	for <openvpn-devel@archiver.kernel.org>; Sun, 23 Aug 2026 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oI+Cb/H60R5GrSS4NCib9W/zlx5/ZIACKp9oXQUKems=; b=NajMBLdQb8tnzhcT4s+tZBwt+v
	fVrLe1ScCwxOsDDHHkxM+MNLImqZCk9VJGFOPoSAo2rEkHJjisKYGHaNMbeCZSOfUGFLwrz6FHVq0
	8/B6Fix838IWqi2XcNHwb1Fb6rgbAojVZ5Vf9BFG+EsutFLnuyQi6l5eKEvM75Kegp9I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyAlH-0000Qs-M4;
	Sun, 23 Aug 2026 16:09:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyAlF-0000Qk-Ou
 for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 16:09:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=t9Br1fpc4P2W2NNqzXnA1L6Q+tMCyrAHLUjxpkQCNjE=; b=S23zo7GAnMQzO0RDAu7rgYUeLz
 c1GXjOL+A6ahuSur3qutrt3DfBCj/Ucy5h7XrPzwp8dNkfbkfd/KiQQN/cZ3DV5LPEUciQFL5PKvu
 lVyFpU//FtpPTgg3r3ijqpup82dBQPs7z5cWwTAWbQPoaTOEdmKSAIxNaiE3pq46ogSQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=t9Br1fpc4P2W2NNqzXnA1L6Q+tMCyrAHLUjxpkQCNjE=; b=M
 fKbEAMTMMEnj+JUzmTAHa4VNAHFW0KouoxZYFmXT7Mxv+gbyA/uq0suxcm+rnaOy+dGB5R+hMO2Fn
 I/Fcql7krR0wGnXRL0flmn1Gy3vhMLMW3C+2/Ma5cbuOjqATMKQTJldTQJHGM+IAcJQCmcipKDpIc
 tN8u7ZXLoa/bW1/M=;
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyAlE-00009c-KM for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 16:09:30 +0000
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so5014250a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787501362; x=1788106162; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t9Br1fpc4P2W2NNqzXnA1L6Q+tMCyrAHLUjxpkQCNjE=;
 b=HO/mRA4BdHkEhIkVHaPabN3syp9onvxMSIN6veuJBzbZoE9PSwl2i6DM7Br9VUAxfh
 YC8979SaMCpi7d6R8Tn2WzSUPOfu15ijDL6QXrJwVQbTG+FQYaM3XEjOSK4DnODjvUXn
 xQAwXxF9qw8AkZ27iE65AI5rnaeM+xpjaJ9Zk9ZLA67Ue/thOHhRdw6LFxrg0g8YMxHR
 8+8bmStCQKourmJMNpWwm4pgO3MQ184BzfahOKPkuqXwRwB7gEWVyviuPvfJ0VFSG4is
 tzw6wiU1XjBkTqO/aeqsG8ybR4tIxkpap8VHqi2cJ7OYnmtwmP8EBSrpLdelPoRl4rgc
 H8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787501362; x=1788106162;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t9Br1fpc4P2W2NNqzXnA1L6Q+tMCyrAHLUjxpkQCNjE=;
 b=LI5PMF994tMLm6yID8TLDwlWLvo9MfOiQtumCU50WexoUL5ktM+9zjE0QHnW0/5O1B
 5Y3PsIv0lxJMgAwUZVMyt7sVtCGmdVUNntrrUD/p+ppYrf7cClRTHypW2/AfKtS4uhVo
 l9wJpynOEsTiKpMqKt8OSUnpwz7cICD4xGUThfgUJf6mUjiW/IuuTaVN39Ckp3/CxRZK
 AwQhswk9H8PtGvHLmGXRB+FIm5vIkqhvbuaPWYb/gX9ugcdIsCw2ETxjkOJ3NSQVK6fP
 SGxXyi/KvFAH1dLEwkGC3vcN6Vat7g2p2Sl40mRUHplS+Z43VzERs7btGNYliJfkmpDn
 KqPQ==
X-Gm-Message-State: AFuF++mNjTFavWnAUzjJG5oilM4j4Ky+FffScFIgxxTIRZW82BZbEsfn
 CYchacrUcpfId6oCoqQKRCxoWF/ToxwqgydSjOxkKjRoRJpPcIdW/sDmcePxIKzSyDp1xb1hPFD
 RFQRQK+TFJvHCA1LZjJBxrOdl5WtKgrk2yvsxJSlYAJ9Z5cJhkUE9rsLdCr/RLqEBoFAJI0E6Gt
 xcovLsAw==
X-Gm-Gg: AR+sD12laX2Mw/aM8N9VN1OGuo9lvf0WL9v2SklCysGuHFC8ueOuGP8OEcA+8tXewaK
 ozdFgwh6SnyDYBbFzKonCB/zYTfqLcb64HHfYgWUqtK34bpfvkA/DsHfD37Upkns4gMoANt/j4y
 rszsgFrkJS9QBJ7k/H/7chzhDM2qByeZixPahHI5WXcrs6DJmb7dbZGcdCPy1Dm1iJV4OR9uL7L
 P60SY/qz8LKvVt6l1UkBZ6ZDMeGvg6d24VnpwoagODNV1dga3Yrfedw5fc1Va9wj9KoIm+rvmrX
 ZCH13X4shYXVAm3gHhPvOGMTwXeejK4WAYouVJ8c9ZgY4vmiRpuGmlLtdwGty7n1PdjB8tz3lAt
 DNN+TNu7tny/yegpc3c0ckfI2gX3Kz/mZfJQPf0LKNxhilDJ3EmAoO74RvO3oZkehX1SBT8Vq2W
 L7r2/+Dffm03VI2cOsejfYOOu1kyiKUlHWQaz0a2lU+rGwFlD6IbD2h+dIiwwFY//ASm9gpDcp3
 XgXvUDUbbJ9rk94iJRBINyjUpY5bl6+IG+68HJ5SPvJ+6zfOi525TX0WNWHIMTRxStkLZcpFeey
 eAHVwdGj5XhG/CCn+/ytpKNweP3ZPvhKNFHjC3A3ZhLOEzoN8n7ktIwla9+D0w==
X-Received: by 2002:a05:6402:3807:b0:6a3:849b:aa48 with SMTP id
 4fb4d7f45d1cf-6a582b39dc9mr15115922a12.7.1787501361654; 
 Sun, 23 Aug 2026 09:09:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e2ddad2sm3763970a12.30.2026.08.23.09.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 09:09:20 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 23 Aug 2026 16:09:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 111eee1fc3d033c3a67cb9552d1ef9d126cca6e6
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ae7baf9ffface7bafe29517bc10a255f1ef493e0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyAlE-00009c-KM
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7341414790179699613=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7341414790179699613==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aZezp+rFqPA="; charset=UTF-8

--aZezp+rFqPA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#4)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1852?usp=3Demail )


Change subject: Add unix-script functi=
onality to the --management feature
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Add unix-script functionality to the --management fe=
ature

This allows a script that handles management input/output to
be star=
ted alongside OpenVPN simpler in small deployments=2E

Change-Id: I307e6407=
9f436aa782f7e24bfff665a545ad2fa0
Signed-off-by: Arne Schwabe <arne@rfc2549=
=2Eorg>
---
M doc/man-sections/management-options=2Erst
M doc/management-no=
tes=2Etxt
M src/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/man=
age=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
7 files changed=
, 99 insertions(+), 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/52/1852/4

diff --git a/doc/man-sections/manag=
ement-options=2Erst b/doc/man-sections/management-options=2Erst
index 8dad5=
2b=2E=2Ed7ece8b 100644
--- a/doc/man-sections/management-options=2Erst
+++ =
b/doc/man-sections/management-options=2Erst
@@ -14,6 +14,7 @@
     manageme=
nt socket-name unix pw-file  # (recommended)
     management IP port       =
            # (INSECURE)
     management IP port pw-file           #
+    m=
anagement script unix-script
 
   ``pw-file``, if specified, is a password =
file where the password must
   be on first line=2E Instead of a filename i=
t can use the keyword stdin
@@ -25,6 +26,14 @@
   ``--management-client-use=
r`` and ``--management-client-group``
   directives to restrict access=2E
 =

+  When the variant :code:`unix-script` is used, OpenVPN will start the
+ =
 specified script on startup and enable ``--management-hold``=2E
+  OpenVPN=
 will generate a random path for the unix socket
+  and also management use=
r and password=2E These are passed as environment
+  variables :code:`MANAG=
EMENT_SOCKET`, :code:`MANAGEMENT_PASSWORD`
+  to the script when being star=
ted=2E When OpenVPN terminates it sends
+  a :code:`SIGINT` signal to the r=
unning script=2E
+
   The management interface provides a special mode wher=
e the TCP
   management link can operate over the tunnel itself=2E To enabl=
e this mode,
   set IP to ``tunnel``=2E Tunnel mode will cause the manageme=
nt interface to
@@ -129,8 +138,9 @@
 --management-signal
   Send SIGUSR1 si=
gnal to OpenVPN if management session disconnects=2E This
   is useful when=
 you wish to disconnect an OpenVPN session on user logoff=2E
-  For ``--man=
agement-client`` this option is not needed since a disconnect
-  will alway=
s generate a :code:`SIGTERM`=2E
+  For ``--management-client`` or  ``--mana=
gement`` with :code:`unixscript`
+  this option is not needed since a disco=
nnect  will always generate a
+  :code:`SIGTERM`=2E
 
 --management-up-down=

   Report tunnel up/down events to management interface=2E
diff --git a/do=
c/management-notes=2Etxt b/doc/management-notes=2Etxt
index 1126468=2E=2Ed6=
b3fbb 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2E=
txt
@@ -35,6 +35,10 @@
 you can telnet to the management port (make sure to=
 use
 a telnet client which understands "raw" mode)=2E
 
+When password aut=
hentication is enabled, the management interface
+will require sending the =
password on its own line after establishing
+the connection=2E
+
 Once conn=
ected to the management port, you can use
 the "help" command to list all c=
ommands=2E
 
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index=
 66bae34=2E=2E8ec30e6 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/i=
nit=2Ec
@@ -4337,19 +4337,60 @@
     }
 }
 
+void
+run_management_script(st=
ruct context *c)
+{
+#if UNIX_SOCK_SUPPORT
+    struct gc_arena gc =3D gc_n=
ew();
+    struct argv argv =3D argv_new();
+    struct env_set *env =3D en=
v_set_create(&gc);
+
+    setenv_str(env, "MANAGEMENT_USER", management->se=
ttings=2Eup=2Eusername);
+    setenv_str(env, "MANAGEMENT_PASSWORD", manage=
ment->settings=2Eup=2Epassword);
+    setenv_str(env, "MANAGEMENT_SOCKET", =
c->options=2Emanagement_addr);
+
+    argv_printf(&argv, "%s", c->options=
=2Emanagement_script);
+
+    int flags =3D S_NOWAITPID | S_SCRIPT | S_FATA=
L;
+    int *pid =3D &management->connection=2Eunix_script_pid;
+    const =
char *msg_prefix =3D "WARNING: Failed running management unix-script";
+   =
 *pid =3D openvpn_execve_check(&argv, env, flags, msg_prefix);
+
+    if (!=
openvpn_waitpid_check(*pid, msg_prefix, M_FATAL))
+    {
+        *pid =3D =
0;
+    }
+
+    argv_free(&argv);
+    gc_free(&gc);
+#else
+#error should=
 be UNIX_SOCK_SUPPORT
+    msg(M_FATAL, "ERROR: Management unix-socket supp=
ort is not available on this platform");
+#endif
+}
+
 bool
 open_managemen=
t(struct context *c)
 {
     /* initialize management layer */
     if (man=
agement)
     {
+        unsigned int flags =3D c->options=2Emanagement_fla=
gs;
+        if (flags & MF_UNIX_SOCK_SCRIPT)
+        {
+            /* Th=
is creates a file but our management codes deletes the
+             * file=
 before opening a socket with the name */
+            c->options=2Emanagem=
ent_addr =3D platform_create_temp_file(
+                platform_get_tmp_d=
ir(), "omi", &c->gc);
+        }
+
         if (c->options=2Emanagement_add=
r)
         {
-            unsigned int flags =3D c->options=2Emanagement_f=
lags;
             if (c->options=2Emode =3D=3D MODE_SERVER)
             {=

                 flags |=3D MF_SERVER;
             }
+
             if (m=
anagement_open(
                     management, c->options=2Emanagement_ad=
dr, c->options=2Emanagement_port,
                     c->options=2Emanagem=
ent_user_pass, c->options=2Emanagement_client_user,
@@ -4361,6 +4402,11 @@
=
                                      NULL);
             }
 
+            =
if (flags & MF_UNIX_SOCK_SCRIPT)
+            {
+                run_manage=
ment_script(c);
+            }
+
             /* initial management hold, c=
alled early, before first context initialization */
             do_hold(0)=
;
             if (IS_SIG(c))
diff --git a/src/openvpn/manage=2Ec b/src/ope=
nvpn/manage=2Ec
index 95ff246=2E=2Ebfc2aa2 100644
--- a/src/openvpn/manage=
=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -333,10 +333,12 @@
 man_delete_unix_so=
cket(struct management *man)
 {
 #if UNIX_SOCK_SUPPORT
-    if ((man->setti=
ngs=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
+=
    if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=
=3D MF_UNIX_SOCK
+        || man->settings=2Eflags & MF_UNIX_SOCK_SCRIPT)
 =
    {
         socket_delete_unix(&man->settings=2Elocal_unix);
     }
+
 #=
endif
 }
 
@@ -2197,7 +2199,7 @@
             }
         }
 
-        if (m=
an->settings=2Eflags & MF_CONNECT_AS_CLIENT)
+        if (man->settings=2Ef=
lags & (MF_CONNECT_AS_CLIENT | MF_UNIX_SOCK_SCRIPT))
         {
           =
  msg(D_MANAGEMENT, "MANAGEMENT: Triggering management exit");
            =
 throw_signal_soft(SIGTERM, "management-exit");
@@ -2644,6 +2646,15 @@
    =
     {
             get_user_pass(&ms->up, pass_file, "Management", GET_USE=
R_PASS_PASSWORD_ONLY);
         }
+        else if (ms->flags & MF_UNIX_SOC=
K_SCRIPT)
+        {
+            /* Set random password=2E The password is=
 only
+             * alphanumerical [0-9a-f] but still has 128 bit of rand=
omness,
+             * which is more than enough */
+            snprintf(=
ms->up=2Epassword, sizeof(ms->up=2Epassword),
+                     "%" PRI=
x64 "%" PRIx64, get_random(), get_random());
+            ms->up=2Edefined =
=3D true;
+        }
 
 #if UNIX_SOCK_SUPPORT
         /*
@@ -2789,6 +2800,=
11 @@
         man_close_socket(man, mc->sd_cli);
     }
 
+    if (mc->uni=
x_script_pid)
+    {
+        kill(mc->unix_script_pid, SIGINT);
+    }
+
 =
    command_line_free(mc->in);
     buffer_list_free(mc->out);
 
diff --git=
 a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 27d3b60=2E=2E71e88=
d0 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -42,=
6 +42,7 @@
 #define MF_EXTERNAL_CERT          (1u << 15)
 #define MF_EXTERN=
AL_KEY_PSSPAD    (1u << 16)
 #define MF_EXTERNAL_KEY_DIGEST    (1u << 17)
+=
#define MF_UNIX_SOCK_SCRIPT       (1u << 18)
 
 #ifdef ENABLE_MANAGEMENT
 
=
@@ -327,6 +328,9 @@
     int fdtosend;
     int lastfdreceived;
 #endif
+#i=
fdef UNIX_SOCK_SUPPORT
+    pid_t unix_script_pid;
+#endif
     int client_=
version;
 };
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec
index 107b3fa9=2E=2E588d75d 100644
--- a/src/openvpn/options=2Ec
+++ b=
/src/openvpn/options=2Ec
@@ -1720,7 +1720,7 @@
      * Check for consistenc=
y of management options
      */
 #ifdef ENABLE_MANAGEMENT
-    if (!option=
s->management_addr
+    if (!options->management_addr && !(options->managem=
ent_flags & MF_UNIX_SOCK_SCRIPT)
         && (options->management_flags
   =
          || options->management_log_history_cache !=3D defaults=2Emanageme=
nt_log_history_cache))
     {
@@ -4301,7 +4301,7 @@
     else if (streq(p[0=
], "management") && p[1] && p[2] && !p[4])
     {
         VERIFY_PERMISSIO=
N(OPT_P_GENERAL);
-        if (streq(p[2], "unix"))
+        if (streq(p[2]=
, "unix") || streq(p[2], "unix-script"))
         {
 #if UNIX_SOCK_SUPPORT
=
             options->management_flags |=3D MF_UNIX_SOCK;
@@ -4311,7 +4311,=
16 @@
 #endif
         }
 
-        options->management_addr =3D p[1];
+   =
     if (streq(p[2], "unix-script"))
+        {
+            options->manag=
ement_flags |=3D MF_UNIX_SOCK_SCRIPT | MF_HOLD;
+            set_user_scrip=
t(options, &options->management_script, p[1],
+                            =
"management unix-script", false);
+        }
+        else
+        {
+    =
        options->management_addr =3D p[1];
+        }
         options->man=
agement_port =3D p[2];
         if (p[3])
         {
diff --git a/src/openv=
pn/options=2Eh b/src/openvpn/options=2Eh
index f472676=2E=2E131513e 100644
=
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -446,6 +446,=
8 @@
     const char *management_addr;
     const char *management_port;
  =
   const char *management_user_pass;
+    /** Script executed to talk to th=
e management interface */
+    const char *management_script;
     int mana=
gement_log_history_cache;
     int management_echo_buffer_size;
     int ma=
nagement_state_buffer_size;

-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1852?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Number: =
1852
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--aZezp+rFqPA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Add unix-script functionality to the --management feature<br><br>=
This allows a script that handles management input/output to<br>be started =
alongside OpenVPN simpler in small deployments=2E<br><br>Change-Id: I307e64=
079f436aa782f7e24bfff665a545ad2fa0<br>Signed-off-by: Arne Schwabe &lt;arne@=
rfc2549=2Eorg&gt;<br>---<br>M doc/man-sections/management-options=2Erst<br>=
M doc/management-notes=2Etxt<br>M src/openvpn/init=2Ec<br>M src/openvpn/man=
age=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/options=2Ec<br>M src/o=
penvpn/options=2Eh<br>7 files changed, 99 insertions(+), 8 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/52/1852/4</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/management-op=
tions=2Erst b/doc/man-sections/management-options=2Erst</span><br><span>ind=
ex 8dad52b=2E=2Ed7ece8b 100644</span><br><span>--- a/doc/man-sections/manag=
ement-options=2Erst</span><br><span>+++ b/doc/man-sections/management-optio=
ns=2Erst</span><br><span>@@ -14,6 +14,7 @@</span><br><span>     management =
socket-name unix pw-file  # (recommended)</span><br><span>     management I=
P port                   # (INSECURE)</span><br><span>     management IP po=
rt pw-file           #</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    management script unix-script</span><br><span> </span><br><span>   `=
`pw-file``, if specified, is a password file where the password must</span>=
<br><span>   be on first line=2E Instead of a filename it can use the keywo=
rd stdin</span><br><span>@@ -25,6 +26,14 @@</span><br><span>   ``--manageme=
nt-client-user`` and ``--management-client-group``</span><br><span>   direc=
tives to restrict access=2E</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  When the variant :code:`unix-script` is used, O=
penVPN will start the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  specified script on startup and enable ``--management-hold``=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN will generate a r=
andom path for the unix socket</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  and also management user and password=2E These are passed as e=
nvironment</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  variabl=
es :code:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_PASSWORD`</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  to the script when being started=2E=
 When OpenVPN terminates it sends</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  a :code:`SIGINT` signal to the running script=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   The manage=
ment interface provides a special mode where the TCP</span><br><span>   man=
agement link can operate over the tunnel itself=2E To enable this mode,</sp=
an><br><span>   set IP to ``tunnel``=2E Tunnel mode will cause the manageme=
nt interface to</span><br><span>@@ -129,8 +138,9 @@</span><br><span> --mana=
gement-signal</span><br><span>   Send SIGUSR1 signal to OpenVPN if manageme=
nt session disconnects=2E This</span><br><span>   is useful when you wish t=
o disconnect an OpenVPN session on user logoff=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  For ``--management-client`` this option is no=
t needed since a disconnect</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  will always generate a :code:`SIGTERM`=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  For ``--management-client`` or  ``--managem=
ent`` with :code:`unixscript`</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  this option is not needed since a disconnect  will always gener=
ate a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`SIGTE=
RM`=2E</span><br><span> </span><br><span> --management-up-down</span><br><s=
pan>   Report tunnel up/down events to management interface=2E</span><br><s=
pan>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</s=
pan><br><span>index 1126468=2E=2Ed6b3fbb 100644</span><br><span>--- a/doc/m=
anagement-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</spa=
n><br><span>@@ -35,6 +35,10 @@</span><br><span> you can telnet to the manag=
ement port (make sure to use</span><br><span> a telnet client which underst=
ands &quot;raw&quot; mode)=2E</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+When password authentication is enabled, the ma=
nagement interface</span><br><span style=3D"color: hsl(120, 100%, 40%);">+w=
ill require sending the password on its own line after establishing</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+the connection=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Once connec=
ted to the management port, you can use</span><br><span> the &quot;help&quo=
t; command to list all commands=2E</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 66=
bae34=2E=2E8ec30e6 100644</span><br><span>--- a/src/openvpn/init=2Ec</span>=
<br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -4337,19 +4337,60 @=
@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+run_management_script(struct context *c)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct argv argv =3D=
 argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct env_set *env =3D env_set_create(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    setenv_str(env, &quot;MANAGEMENT_USER&quot;, management-&gt;sett=
ings=2Eup=2Eusername);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    setenv_str(env, &quot;MANAGEMENT_PASSWORD&quot;, management-&gt;sett=
ings=2Eup=2Epassword);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    setenv_str(env, &quot;MANAGEMENT_SOCKET&quot;, c-&gt;options=2Emanag=
ement_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv,=
 &quot;%s&quot;, c-&gt;options=2Emanagement_script);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int flags =3D S_NOWAITPID | S_SCRIPT | S_FATAL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int *pid =3D &amp;manage=
ment-&gt;connection=2Eunix_script_pid;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *msg_prefix =3D &quot;WARNING: Failed run=
ning management unix-script&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    *pid =3D openvpn_execve_check(&amp;argv, env, flags, msg=
_prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!openvpn_waitpid_chec=
k(*pid, msg_prefix, M_FATAL))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    *pid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    argv_free(&amp;argv);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#error should be UNIX_SOCK_SUPPORT</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL, &quot;ERR=
OR: Management unix-socket support is not available on this platform&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> open_mana=
gement(struct context *c)</span><br><span> {</span><br><span>     /* initia=
lize management layer */</span><br><span>     if (management)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        un=
signed int flags =3D c-&gt;options=2Emanagement_flags;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp; MF_UNIX_SOCK_SCR=
IPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* This creat=
es a file but our management codes deletes the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+             * file before opening a socket with=
 the name */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     c-&gt;options=2Emanagement_addr =3D platform_create_temp_file(</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                platform_ge=
t_tmp_dir(), &quot;omi&quot;, &amp;c-&gt;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>         if (c-&gt;options=2Emanagement_ad=
dr)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            unsigned int flags =3D c-&gt;options=2Emanagement_flag=
s;</span><br><span>             if (c-&gt;options=2Emode =3D=3D MODE_SERVER=
)</span><br><span>             {</span><br><span>                 flags |=
=3D MF_SERVER;</span><br><span>             }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>             if (management_open=
(</span><br><span>                     management, c-&gt;options=2Emanageme=
nt_addr, c-&gt;options=2Emanagement_port,</span><br><span>                 =
    c-&gt;options=2Emanagement_user_pass, c-&gt;options=2Emanagement_client=
_user,</span><br><span>@@ -4361,6 +4402,11 @@</span><br><span>             =
                         NULL);</span><br><span>             }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                run_management_script(c);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>             /* initial managemen=
t hold, called early, before first context initialization */</span><br><spa=
n>             do_hold(0);</span><br><span>             if (IS_SIG(c))</spa=
n><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</s=
pan><br><span>index 95ff246=2E=2Ebfc2aa2 100644</span><br><span>--- a/src/o=
penvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><s=
pan>@@ -333,10 +333,12 @@</span><br><span> man_delete_unix_socket(struct ma=
nagement *man)</span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPORT</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((man-&gt;setting=
s=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((man-&gt;se=
ttings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_=
SOCK</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || man-=
&gt;settings=2Eflags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>     {</spa=
n><br><span>         socket_delete_unix(&amp;man-&gt;settings=2Elocal_unix)=
;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> #endif</span><br><span> }</span><br><span> </span><b=
r><span>@@ -2197,7 +2199,7 @@</span><br><span>             }</span><br><spa=
n>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (man-&gt;settings=2Eflags &amp; MF_CONNECT_AS_CLIENT)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;s=
ettings=2Eflags &amp; (MF_CONNECT_AS_CLIENT | MF_UNIX_SOCK_SCRIPT))</span><=
br><span>         {</span><br><span>             msg(D_MANAGEMENT, &quot;MA=
NAGEMENT: Triggering management exit&quot;);</span><br><span>             t=
hrow_signal_soft(SIGTERM, &quot;management-exit&quot;);</span><br><span>@@ =
-2644,6 +2646,15 @@</span><br><span>         {</span><br><span>            =
 get_user_pass(&amp;ms-&gt;up, pass_file, &quot;Management&quot;, GET_USER_=
PASS_PASSWORD_ONLY);</span><br><span>         }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        else if (ms-&gt;flags &amp; MF_UNIX_SOC=
K_SCRIPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Set r=
andom password=2E The password is only</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             * alphanumerical [0-9a-f] but still has 128=
 bit of randomness,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
             * which is more than enough */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            snprintf(ms-&gt;up=2Epassword, sizeof(m=
s-&gt;up=2Epassword),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                     &quot;%&quot; PRIx64 &quot;%&quot; PRIx64, get_rando=
m(), get_random());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            ms-&gt;up=2Edefined =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span> </span><br><span> #if UNIX=
_SOCK_SUPPORT</span><br><span>         /*</span><br><span>@@ -2789,6 +2800,=
11 @@</span><br><span>         man_close_socket(man, mc-&gt;sd_cli);</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (mc-&gt;unix_script_pid)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        kill(mc-&gt;unix_script_pid, SIGINT);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     command_line_free(mc-&gt;in)=
;</span><br><span>     buffer_list_free(mc-&gt;out);</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</s=
pan><br><span>index 27d3b60=2E=2E71e88d0 100644</span><br><span>--- a/src/o=
penvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><s=
pan>@@ -42,6 +42,7 @@</span><br><span> #define MF_EXTERNAL_CERT          (1=
u &lt;&lt; 15)</span><br><span> #define MF_EXTERNAL_KEY_PSSPAD    (1u &lt;&=
lt; 16)</span><br><span> #define MF_EXTERNAL_KEY_DIGEST    (1u &lt;&lt; 17)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MF_UNIX_SOC=
K_SCRIPT       (1u &lt;&lt; 18)</span><br><span> </span><br><span> #ifdef E=
NABLE_MANAGEMENT</span><br><span> </span><br><span>@@ -327,6 +328,9 @@</spa=
n><br><span>     int fdtosend;</span><br><span>     int lastfdreceived;</sp=
an><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifdef UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    pid_t unix_script_pid;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span>     int client_version;</span><br><spa=
n> };</span><br><span> </span><br><span>diff --git a/src/openvpn/options=2E=
c b/src/openvpn/options=2Ec</span><br><span>index 107b3fa9=2E=2E588d75d 100=
644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src=
/openvpn/options=2Ec</span><br><span>@@ -1720,7 +1720,7 @@</span><br><span>=
      * Check for consistency of management options</span><br><span>      *=
/</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!options-&gt;management_addr</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!options-&gt;management_addr=
 &amp;&amp; !(options-&gt;management_flags &amp; MF_UNIX_SOCK_SCRIPT)</span=
><br><span>         &amp;&amp; (options-&gt;management_flags</span><br><spa=
n>             || options-&gt;management_log_history_cache !=3D defaults=2E=
management_log_history_cache))</span><br><span>     {</span><br><span>@@ -4=
301,7 +4301,7 @@</span><br><span>     else if (streq(p[0], &quot;management=
&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><span> =
    {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (streq(p[2], &quot;un=
ix&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (streq(p[2], &quot;unix&quot;) || streq(p[2], &quot;unix-script&quot;))</=
span><br><span>         {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br>=
<span>             options-&gt;management_flags |=3D MF_UNIX_SOCK;</span><b=
r><span>@@ -4311,7 +4311,16 @@</span><br><span> #endif</span><br><span>    =
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        options-&gt;management_addr =3D p[1];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (streq(p[2], &quot;unix-script&quot=
;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;ma=
nagement_flags |=3D MF_UNIX_SOCK_SCRIPT | MF_HOLD;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            set_user_script(options, &amp;op=
tions-&gt;management_script, p[1],</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                            &quot;management unix-script&quo=
t;, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;management_=
addr =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span>         options-&gt;management_port =3D p[2];</span><=
br><span>         if (p[3])</span><br><span>         {</span><br><span>diff=
 --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>=
index f472676=2E=2E131513e 100644</span><br><span>--- a/src/openvpn/options=
=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -446,=
6 +446,8 @@</span><br><span>     const char *management_addr;</span><br><sp=
an>     const char *management_port;</span><br><span>     const char *manag=
ement_user_pass;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /** Script executed to talk to the management interface */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const char *management_script;<=
/span><br><span>     int management_log_history_cache;</span><br><span>    =
 int management_echo_buffer_size;</span><br><span>     int management_state=
_buffer_size;</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">change 1852</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3=
07e64079f436aa782f7e24bfff665a545ad2fa0 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1852 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bod=
y></html>
--aZezp+rFqPA=--


--===============7341414790179699613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7341414790179699613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7341414790179699613==--

