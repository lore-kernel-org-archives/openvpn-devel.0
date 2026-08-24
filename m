Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DD2C5DF81
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GWJHhfNgAQLGKi8rzN4pRK0WWqwM89tWxV5pQOvZxmA=; b=hMvaPyAyfAa9gDify724smmaLP
	+hheTjIUD7HIUhaDGSFiJsnNRAWIDiPBX0qlPiZFhIZl3uHRakCeS8yXmWS1c5+HQNtHGXXTOFDvB
	Op+hH9xA/S80zyMBpFfhGvSQInAfDA9yJOQW104NGOPe9zKvN98T+VEsRz/CI/wSFPqw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyVB3-0000Az-7X;
	Mon, 24 Aug 2026 13:57:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyVB1-0000As-CT
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:57:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rrNBVP6K3OnGQr/Am84XKXa0ju09DYvFa5oO6Ues4kw=; b=Q+SmiXBYZFnd5DNRGYzFVMGVsi
 YaYnql30c4nDiJsBguaWyXUpMuDEsGwEbITA5uGVMZfDHhUueyGrWx6oTVYoqTkJVdLyH6t2ut1dj
 uEe5uNCDlaEfmwu08r/WoF7nn9cP8O4825hV99F4OIj4y1Px+9li6hgRXba312qTTpN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rrNBVP6K3OnGQr/Am84XKXa0ju09DYvFa5oO6Ues4kw=; b=B
 6Et6cifzMUSTL5Hh8Mx7A5WSiAk3KnmsvMTkpCEOsOs3wuuMpyOFNobihwuRzp+T3nOyPReV6Qm+a
 Q/s1zMaSFqFRkoBWxdJsI2tWrZZrXdNqPbbDVj+tjJbfx0cmPpKytlGGCGKoFSekWUn9H4UDuEYMK
 JNQddTZ5Bb7TGz1c=;
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyVAz-00011d-HJ for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:57:27 +0000
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so624446166b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787579839; x=1788184639; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rrNBVP6K3OnGQr/Am84XKXa0ju09DYvFa5oO6Ues4kw=;
 b=LhE2Op+DaJwEPVcQI81f6Y3hTNPFt2Kf9/NCN2ECTXE4WodmuKJj+0Kit3d3cXXshC
 IaZIHbrO2eK3z7/MlY+BtgTgXPzS93HkT5LI+cccBE/n7qnVfv4EIullsQ2d5E/a2Fwi
 d1/kvqv5fEDAAXyhAwPTCITqZASZriCm7Hc713HLD2/3UjqV5qaMc9eRGPVQ/sfkL3dG
 pa3yXv9KlVL6qvIdBf+kuMxB31FwljJvTCA+Zv0TFtgz8zgAGQ++8IIfSq9Qu0CyarGv
 IMlEDJo51b3fRqTFy0+papa/OjfMc3twmqGyOPn2439XUXeI/H9oWJRpReUUDuQLGrWf
 hXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787579839; x=1788184639;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rrNBVP6K3OnGQr/Am84XKXa0ju09DYvFa5oO6Ues4kw=;
 b=PGeWSrYdKI89sLjLjNYMMXZnYRgufFVtNgPqAodmfS9YEIZoxGBu4md56lKXToT6hz
 kRmK/VKKDO4W+TF7mLdrB+HoQSE6jFLviklaWUQY+UEQ/S1t5ro5wWPCO2x9i8CU9Yl0
 5twDEx+aD27w9GQKuXcfhntcNBK0q+U0UM0lCwCDIzyFpjdBOgg6OaEsfS2PC0U/zV+w
 jhaEa82SpdvbfoAaBmJJmMs6sL0BRTc+Nib2sLg6CvzK+MtIv+CwliJqKxxWaXlnkge7
 Syr5DZpJwPxQZKaOeiLud/pNlD+XzZMu+arBtJ6LCpl4h3yFxYV69pEQ4TbRgLvoq/8t
 aqrQ==
X-Gm-Message-State: AFuF++mgFQIcMe2AIfdhDYYwR9qVTU0r13cTuQItmS3AvK46xQ4O9psc
 Lugdy6hV43ED2T814UPtySF58Y3PzcK1U8hwmtgJM69jthUKuf7Z+BRg/NrfNrVmyxhBx/WS+pK
 6lxTICoxQ0YryjO+fRMVEsrJy8BedaTVHX84N/0n4HmBsdompeU4t84iEhTgspICvD281Z1adVX
 sU00HDDg==
X-Gm-Gg: AR+sD12KfOrqSIUNkX3JA0zDZlzEshTgwHZev+Z/3EHy9l6dXl6xKTr7vn5zqUtcuMa
 s8ZYjBvxM09UXHpx7kNI0bft2xa/FiMPC+nuVokL3DdBr6F2HDNUKaO53ThvRXihJ3vC1DiYgJ8
 9LDMTuYXnJtbG1IvA0wMLvCyrO5QCoN4Wm1qIC4TGcfrOKpRiR3Qn5nsARlYCANQlg8N0xjsTKo
 V/I+vohuz9at1TLhA3sL9c0WKyW7aXnP3GdZ9dweD6uh9hPnh1mfwIAcuSZ169uwxsGFPm9l4Q4
 w5spJ1UYf46D9O18XrtXx4DxkWeMAv0O8sfCmdmcfqMcjPEBFR6ptNHNL/M+vSjPf18AjZzYExb
 g7vqG7kVSKUKU2NpVKqm7GPbk8QwEGanCDg/QunRtVOIzDSXiR/T3BT2nb4nTSAoHQ1BtSEBMIx
 eGk0z2MHxMrYTfm7cAN2sBMDKXC9HRYdkXWB5ZengNVOqImQnZ/8kjZX0UPU5UXisJZK4rOkskG
 /KMR+sastXAA/zAyoWQ10AvlOEuieOh8S4Se7d5LiSUNG8DfmR9rsE/aP5vmEgHyZtyIfc8ngIQ
 P7v+eDpkTeBMev93U7bDWi2BHzsRUyqnFyyIoZ2hR3ReJXVZ5rw=
X-Received: by 2002:a17:907:8992:b0:c21:8c6a:c680 with SMTP id
 a640c23a62f3a-c24926673cfmr2190907866b.22.1787579838609; 
 Mon, 24 Aug 2026 06:57:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24962a3c13sm1352393666b.26.2026.08.24.06.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:57:18 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 13:57:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 28d43b4d414dced9140b52467930260cd6b2332c
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4d4a3e9006a67a4e3aaaaab906b1a83ff0a0e05d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyVAz-00011d-HJ
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
Content-Type: multipart/mixed; boundary="===============9006564607320155863=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9006564607320155863==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QXki/N564l4="; charset=UTF-8

--QXki/N564l4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#6)=2E ( http://gerrit=2Eopenvpn=2E=
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
, 100 insertions(+), 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/52/1852/6

diff --git a/doc/man-sections/mana=
gement-options=2Erst b/doc/man-sections/management-options=2Erst
index 8dad=
52b=2E=2Ed7ece8b 100644
--- a/doc/man-sections/management-options=2Erst
+++=
 b/doc/man-sections/management-options=2Erst
@@ -14,6 +14,7 @@
     managem=
ent socket-name unix pw-file  # (recommended)
     management IP port      =
             # (INSECURE)
     management IP port pw-file           #
+    =
management script unix-script
 
   ``pw-file``, if specified, is a password=
 file where the password must
   be on first line=2E Instead of a filename =
it can use the keyword stdin
@@ -25,6 +26,14 @@
   ``--management-client-us=
er`` and ``--management-client-group``
   directives to restrict access=2E
=
 
+  When the variant :code:`unix-script` is used, OpenVPN will start the
+=
  specified script on startup and enable ``--management-hold``=2E
+  OpenVP=
N will generate a random path for the unix socket
+  and also management us=
er and password=2E These are passed as environment
+  variables :code:`MANA=
GEMENT_SOCKET`, :code:`MANAGEMENT_PASSWORD`
+  to the script when being sta=
rted=2E When OpenVPN terminates it sends
+  a :code:`SIGINT` signal to the =
running script=2E
+
   The management interface provides a special mode whe=
re the TCP
   management link can operate over the tunnel itself=2E To enab=
le this mode,
   set IP to ``tunnel``=2E Tunnel mode will cause the managem=
ent interface to
@@ -129,8 +138,9 @@
 --management-signal
   Send SIGUSR1 s=
ignal to OpenVPN if management session disconnects=2E This
   is useful whe=
n you wish to disconnect an OpenVPN session on user logoff=2E
-  For ``--ma=
nagement-client`` this option is not needed since a disconnect
-  will alwa=
ys generate a :code:`SIGTERM`=2E
+  For ``--management-client`` or  ``--man=
agement`` with :code:`unixscript`
+  this option is not needed since a disc=
onnect  will always generate a
+  :code:`SIGTERM`=2E
 
 --management-up-dow=
n
   Report tunnel up/down events to management interface=2E
diff --git a/d=
oc/management-notes=2Etxt b/doc/management-notes=2Etxt
index 1126468=2E=2Ed=
6b3fbb 100644
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
dex 66bae34=2E=2E67aef8b 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvp=
n/init=2Ec
@@ -4337,19 +4337,59 @@
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
+            /* This creates a file but our managemen=
t codes deletes the
+             * file before opening a socket with the n=
ame */
+            c->options=2Emanagement_addr =3D platform_create_temp_f=
ile(
+                platform_get_tmp_dir(), "omi", &c->gc);
+        }
+
=
         if (c->options=2Emanagement_addr)
         {
-            unsigned=
 int flags =3D c->options=2Emanagement_flags;
             if (c->options=
=2Emode =3D=3D MODE_SERVER)
             {
                 flags |=3D MF_S=
ERVER;
             }
+
             if (management_open(
                 =
    management, c->options=2Emanagement_addr, c->options=2Emanagement_port,=

                     c->options=2Emanagement_user_pass, c->options=2Emanag=
ement_client_user,
@@ -4361,6 +4401,11 @@
                                 =
     NULL);
             }
 
+            if (flags & MF_UNIX_SOCK_SCRIPT)
=
+            {
+                run_management_script(c);
+            }
+
=
             /* initial management hold, called early, before first context=
 initialization */
             do_hold(0);
             if (IS_SIG(c))
dif=
f --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 95ff246=2E=
=2E7882910 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec=

@@ -333,10 +333,12 @@
 man_delete_unix_socket(struct management *man)
 {
 =
#if UNIX_SOCK_SUPPORT
-    if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_=
CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
+    if ((man->settings=2Eflags & =
(MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK
+        || man-=
>settings=2Eflags & MF_UNIX_SOCK_SCRIPT)
     {
         socket_delete_unix=
(&man->settings=2Elocal_unix);
     }
+
 #endif
 }
 
@@ -2197,7 +2199,7 @@
=
             }
         }
 
-        if (man->settings=2Eflags & MF_CONNECT=
_AS_CLIENT)
+        if (man->settings=2Eflags & (MF_CONNECT_AS_CLIENT | MF=
_UNIX_SOCK_SCRIPT))
         {
             msg(D_MANAGEMENT, "MANAGEMENT: =
Triggering management exit");
             throw_signal_soft(SIGTERM, "mana=
gement-exit");
@@ -2644,6 +2646,15 @@
         {
             get_user_pass=
(&ms->up, pass_file, "Management", GET_USER_PASS_PASSWORD_ONLY);
         }=

+        else if (ms->flags & MF_UNIX_SOCK_SCRIPT)
+        {
+           =
 /* Set random password=2E The password is only
+             * alphanumeri=
cal [0-9a-f] but still has 128 bit of randomness,
+             * which is =
more than enough */
+            snprintf(ms->up=2Epassword, sizeof(ms->up=
=2Epassword),
+                     "%" PRIx64 "%" PRIx64, get_random(), ge=
t_random());
+            ms->up=2Edefined =3D true;
+        }
 
 #if UNIX=
_SOCK_SUPPORT
         /*
@@ -2789,6 +2800,13 @@
         man_close_socket(=
man, mc->sd_cli);
     }
 
+#if UNIX_SOCK_SUPPORT
+    if (mc->unix_script_=
pid)
+    {
+        kill(mc->unix_script_pid, SIGINT);
+    }
+#endif
+
  =
   command_line_free(mc->in);
     buffer_list_free(mc->out);
 
diff --git =
a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 27d3b60=2E=2Ef752fe=
c 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -42,6=
 +42,7 @@
 #define MF_EXTERNAL_CERT          (1u << 15)
 #define MF_EXTERNA=
L_KEY_PSSPAD    (1u << 16)
 #define MF_EXTERNAL_KEY_DIGEST    (1u << 17)
+#=
define MF_UNIX_SOCK_SCRIPT       (1u << 18)
 
 #ifdef ENABLE_MANAGEMENT
 
@=
@ -327,6 +328,9 @@
     int fdtosend;
     int lastfdreceived;
 #endif
+#if=
 UNIX_SOCK_SUPPORT
+    pid_t unix_script_pid;
+#endif
     int client_vers=
ion;
 };
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
i=
ndex 107b3fa9=2E=2E588d75d 100644
--- a/src/openvpn/options=2Ec
+++ b/src/o=
penvpn/options=2Ec
@@ -1720,7 +1720,7 @@
      * Check for consistency of m=
anagement options
      */
 #ifdef ENABLE_MANAGEMENT
-    if (!options->man=
agement_addr
+    if (!options->management_addr && !(options->management_fl=
ags & MF_UNIX_SOCK_SCRIPT)
         && (options->management_flags
         =
    || options->management_log_history_cache !=3D defaults=2Emanagement_log=
_history_cache))
     {
@@ -4301,7 +4301,7 @@
     else if (streq(p[0], "ma=
nagement") && p[1] && p[2] && !p[4])
     {
         VERIFY_PERMISSION(OPT_=
P_GENERAL);
-        if (streq(p[2], "unix"))
+        if (streq(p[2], "uni=
x") || streq(p[2], "unix-script"))
         {
 #if UNIX_SOCK_SUPPORT
      =
       options->management_flags |=3D MF_UNIX_SOCK;
@@ -4311,7 +4311,16 @@
=
 #endif
         }
 
-        options->management_addr =3D p[1];
+        i=
f (streq(p[2], "unix-script"))
+        {
+            options->management_=
flags |=3D MF_UNIX_SOCK_SCRIPT | MF_HOLD;
+            set_user_script(opti=
ons, &options->management_script, p[1],
+                            "manag=
ement unix-script", false);
+        }
+        else
+        {
+          =
  options->management_addr =3D p[1];
+        }
         options->managemen=
t_port =3D p[2];
         if (p[3])
         {
diff --git a/src/openvpn/opt=
ions=2Eh b/src/openvpn/options=2Eh
index f472676=2E=2E131513e 100644
--- a/=
src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -446,6 +446,8 @@
 =
    const char *management_addr;
     const char *management_port;
     con=
st char *management_user_pass;
+    /** Script executed to talk to the mana=
gement interface */
+    const char *management_script;
     int management=
_log_history_cache;
     int management_echo_buffer_size;
     int manageme=
nt_state_buffer_size;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1852?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
G=
errit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--QXki/N564l4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #6</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Add unix-script functionality to the --management feature<br><br>=
This allows a script that handles management input/output to<br>be started =
alongside OpenVPN simpler in small deployments=2E<br><br>Change-Id: I307e64=
079f436aa782f7e24bfff665a545ad2fa0<br>Signed-off-by: Arne Schwabe &lt;arne@=
rfc2549=2Eorg&gt;<br>---<br>M doc/man-sections/management-options=2Erst<br>=
M doc/management-notes=2Etxt<br>M src/openvpn/init=2Ec<br>M src/openvpn/man=
age=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/options=2Ec<br>M src/o=
penvpn/options=2Eh<br>7 files changed, 100 insertions(+), 8 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/52/1852/6</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/management-o=
ptions=2Erst b/doc/man-sections/management-options=2Erst</span><br><span>in=
dex 8dad52b=2E=2Ed7ece8b 100644</span><br><span>--- a/doc/man-sections/mana=
gement-options=2Erst</span><br><span>+++ b/doc/man-sections/management-opti=
ons=2Erst</span><br><span>@@ -14,6 +14,7 @@</span><br><span>     management=
 socket-name unix pw-file  # (recommended)</span><br><span>     management =
IP port                   # (INSECURE)</span><br><span>     management IP p=
ort pw-file           #</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    management script unix-script</span><br><span> </span><br><span>   =
``pw-file``, if specified, is a password file where the password must</span=
><br><span>   be on first line=2E Instead of a filename it can use the keyw=
ord stdin</span><br><span>@@ -25,6 +26,14 @@</span><br><span>   ``--managem=
ent-client-user`` and ``--management-client-group``</span><br><span>   dire=
ctives to restrict access=2E</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  When the variant :code:`unix-script` is used, =
OpenVPN will start the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  specified script on startup and enable ``--management-hold``=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN will generate a =
random path for the unix socket</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  and also management user and password=2E These are passed as =
environment</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  variab=
les :code:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_PASSWORD`</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  to the script when being started=
=2E When OpenVPN terminates it sends</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  a :code:`SIGINT` signal to the running script=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   The man=
agement interface provides a special mode where the TCP</span><br><span>   =
management link can operate over the tunnel itself=2E To enable this mode,<=
/span><br><span>   set IP to ``tunnel``=2E Tunnel mode will cause the manag=
ement interface to</span><br><span>@@ -129,8 +138,9 @@</span><br><span> --m=
anagement-signal</span><br><span>   Send SIGUSR1 signal to OpenVPN if manag=
ement session disconnects=2E This</span><br><span>   is useful when you wis=
h to disconnect an OpenVPN session on user logoff=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  For ``--management-client`` this option i=
s not needed since a disconnect</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  will always generate a :code:`SIGTERM`=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  For ``--management-client`` or  ``--man=
agement`` with :code:`unixscript`</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  this option is not needed since a disconnect  will always g=
enerate a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`S=
IGTERM`=2E</span><br><span> </span><br><span> --management-up-down</span><b=
r><span>   Report tunnel up/down events to management interface=2E</span><b=
r><span>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etx=
t</span><br><span>index 1126468=2E=2Ed6b3fbb 100644</span><br><span>--- a/d=
oc/management-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt<=
/span><br><span>@@ -35,6 +35,10 @@</span><br><span> you can telnet to the m=
anagement port (make sure to use</span><br><span> a telnet client which und=
erstands &quot;raw&quot; mode)=2E</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+When password authentication is enabled, =
the management interface</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+will require sending the password on its own line after establishing</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+the connection=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Once =
connected to the management port, you can use</span><br><span> the &quot;he=
lp&quot; command to list all commands=2E</span><br><span> </span><br><span>=
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>in=
dex 66bae34=2E=2E67aef8b 100644</span><br><span>--- a/src/openvpn/init=2Ec<=
/span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -4337,19 +433=
7,59 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><=
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
yle=3D"color: hsl(120, 100%, 40%);">+            /* This creates a file but=
 our management codes deletes the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+             * file before opening a socket with the name */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;op=
tions=2Emanagement_addr =3D platform_create_temp_file(</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                platform_get_tmp_dir(), =
&quot;omi&quot;, &amp;c-&gt;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>         if (c-&gt;options=2Emanagement_addr)</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        unsigned int flags =3D c-&gt;options=2Emanagement_flags;</span><br>=
<span>             if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</span><br><=
span>             {</span><br><span>                 flags |=3D MF_SERVER;<=
/span><br><span>             }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>             if (management_open(</span><br><sp=
an>                     management, c-&gt;options=2Emanagement_addr, c-&gt;=
options=2Emanagement_port,</span><br><span>                     c-&gt;optio=
ns=2Emanagement_user_pass, c-&gt;options=2Emanagement_client_user,</span><b=
r><span>@@ -4361,6 +4401,11 @@</span><br><span>                            =
          NULL);</span><br><span>             }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (flags &amp; M=
F_UNIX_SOCK_SCRIPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          run_management_script(c);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>             /* initial management hold, called =
early, before first context initialization */</span><br><span>             =
do_hold(0);</span><br><span>             if (IS_SIG(c))</span><br><span>dif=
f --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>i=
ndex 95ff246=2E=2E7882910 100644</span><br><span>--- a/src/openvpn/manage=
=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -333,1=
0 +333,12 @@</span><br><span> man_delete_unix_socket(struct management *man=
)</span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if ((man-&gt;settings=2Eflags &am=
p; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if ((man-&gt;settings=2Eflag=
s &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        || man-&gt;settings=
=2Eflags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>     {</span><br><span>=
         socket_delete_unix(&amp;man-&gt;settings=2Elocal_unix);</span><br>=
<span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> #endif</span><br><span> }</span><br><span> </span><br><span>@@ -=
2197,7 +2199,7 @@</span><br><span>             }</span><br><span>         }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (man-&gt;settings=2Eflags &amp; MF_CONNECT_AS_CLIENT)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;settings=2Efl=
ags &amp; (MF_CONNECT_AS_CLIENT | MF_UNIX_SOCK_SCRIPT))</span><br><span>   =
      {</span><br><span>             msg(D_MANAGEMENT, &quot;MANAGEMENT: Tr=
iggering management exit&quot;);</span><br><span>             throw_signal_=
soft(SIGTERM, &quot;management-exit&quot;);</span><br><span>@@ -2644,6 +264=
6,15 @@</span><br><span>         {</span><br><span>             get_user_pa=
ss(&amp;ms-&gt;up, pass_file, &quot;Management&quot;, GET_USER_PASS_PASSWOR=
D_ONLY);</span><br><span>         }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        else if (ms-&gt;flags &amp; MF_UNIX_SOCK_SCRIPT)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            /* Set random passwo=
rd=2E The password is only</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+             * alphanumerical [0-9a-f] but still has 128 bit of rand=
omness,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
 * which is more than enough */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            snprintf(ms-&gt;up=2Epassword, sizeof(ms-&gt;up=2Ep=
assword),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
           &quot;%&quot; PRIx64 &quot;%&quot; PRIx64, get_random(), get_ran=
dom());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
ms-&gt;up=2Edefined =3D true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span> </span><br><span> #if UNIX_SOCK_SUPPOR=
T</span><br><span>         /*</span><br><span>@@ -2789,6 +2800,13 @@</span>=
<br><span>         man_close_socket(man, mc-&gt;sd_cli);</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (mc-&gt;unix_script_pid)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        kill(mc-&gt;unix_script_pid, SIGINT);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>     command_line_free(mc-&gt;in);</span><br><span>     =
buffer_list_free(mc-&gt;out);</span><br><span> </span><br><span>diff --git =
a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 27d=
3b60=2E=2Ef752fec 100644</span><br><span>--- a/src/openvpn/manage=2Eh</span=
><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -42,6 +42,7 @@</=
span><br><span> #define MF_EXTERNAL_CERT          (1u &lt;&lt; 15)</span><b=
r><span> #define MF_EXTERNAL_KEY_PSSPAD    (1u &lt;&lt; 16)</span><br><span=
> #define MF_EXTERNAL_KEY_DIGEST    (1u &lt;&lt; 17)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define MF_UNIX_SOCK_SCRIPT       (1u &lt=
;&lt; 18)</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span=
><br><span> </span><br><span>@@ -327,6 +328,9 @@</span><br><span>     int f=
dtosend;</span><br><span>     int lastfdreceived;</span><br><span> #endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pid_t unix_scri=
pt_pid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span>     int client_version;</span><br><span> };</span><br><span> </=
span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec</span><br><span>index 107b3fa9=2E=2E588d75d 100644</span><br><span>---=
 a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</s=
pan><br><span>@@ -1720,7 +1720,7 @@</span><br><span>      * Check for consi=
stency of management options</span><br><span>      */</span><br><span> #ifd=
ef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (!options-&gt;management_addr</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!options-&gt;management_addr &amp;&amp; !(options-&=
gt;management_flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>         &am=
p;&amp; (options-&gt;management_flags</span><br><span>             || optio=
ns-&gt;management_log_history_cache !=3D defaults=2Emanagement_log_history_=
cache))</span><br><span>     {</span><br><span>@@ -4301,7 +4301,7 @@</span>=
<br><span>     else if (streq(p[0], &quot;management&quot;) &amp;&amp; p[1]=
 &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><span>     {</span><br><span> =
        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (streq(p[2], &quot;unix&quot;))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (streq(p[2], &quot;un=
ix&quot;) || streq(p[2], &quot;unix-script&quot;))</span><br><span>        =
 {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><span>             opti=
ons-&gt;management_flags |=3D MF_UNIX_SOCK;</span><br><span>@@ -4311,7 +431=
1,16 @@</span><br><span> #endif</span><br><span>         }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;=
management_addr =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (streq(p[2], &quot;unix-script&quot;))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            options-&gt;management_flags |=3D MF_=
UNIX_SOCK_SCRIPT | MF_HOLD;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            set_user_script(options, &amp;options-&gt;management_sc=
ript, p[1],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                    &quot;management unix-script&quot;, false);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            options-&gt;management_addr =3D p[1];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>  =
       options-&gt;management_port =3D p[2];</span><br><span>         if (p=
[3])</span><br><span>         {</span><br><span>diff --git a/src/openvpn/op=
tions=2Eh b/src/openvpn/options=2Eh</span><br><span>index f472676=2E=2E1315=
13e 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>++=
+ b/src/openvpn/options=2Eh</span><br><span>@@ -446,6 +446,8 @@</span><br><=
span>     const char *management_addr;</span><br><span>     const char *man=
agement_port;</span><br><span>     const char *management_user_pass;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Script executed to=
 talk to the management interface */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const char *management_script;</span><br><span>     in=
t management_log_history_cache;</span><br><span>     int management_echo_bu=
ffer_size;</span><br><span>     int management_state_buffer_size;</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1852?usp=3Demail">change 1852</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I307e64079f436aa782f7e24bf=
ff665a545ad2fa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
852 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--QXki/N564l4=--


--===============9006564607320155863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9006564607320155863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9006564607320155863==--

