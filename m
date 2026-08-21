Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921B7C5DF94
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=1b8HcanD3i9it+GuLhcOnlsqt+23CZBGsUT6nMYBc+o=; b=mPZsQ5DpIXrnRA
	SMrpmJI250lrckPBvinZKgsIKtGQp5C2rSIPhEYRodAk0QFNE6wrRJI/cfm+FfSafuOW3BPTXrHn+
	dqF4BghBf/MKGBANnaCgQaWPKAvpAqmiym5csayl+xDDIOGtPDyAziOeaqm2kWhmfSo9L9FMGc1ut
	P3c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxRUh-0002ZV-LX;
	Fri, 21 Aug 2026 15:49:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxRUf-0002ZO-Sx
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YOXgcGJK9N1WQaakfWFABKMtl8aENk5fGUqVyMouuG8=; b=i4/QeJeXQot7KjdJEw1FKRND3G
 dBYN8rDf/uYbCoFH3/xX6NCVvZyvAkHE8QziSy5vH4TJGIUmReMxtOthHgnKQtA/wyAIEWFeYJBmc
 LDiQ4Fip34mDL179yVz4Z2MwN8q7diDbKiK6Hye+VofWPoE9CdakvusEJIGZJ1Jkd/Z8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YOXgcGJK9N1WQaakfWFABKMtl8aENk5fGUqVyMouuG8=; b=U
 c3fisiglhFxIsO8iq2A1XSw6DaKMExiVkuuDoVeDWWe6uMYsxORej7kvfqNQeNZvTqEXYaiRyWZOw
 dp4394LtXZwDaNxrRV7Zk/rFkZseRDlwWOao4hyG+IMn067fQNT8PzSdtpL7PJwKvcj85GOmWTpTD
 5hWq4jdDfK6wuHJo=;
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxRUe-0005bl-BH for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:21 +0000
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c1f758014b8so125542466b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 08:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787327354; x=1787932154; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YOXgcGJK9N1WQaakfWFABKMtl8aENk5fGUqVyMouuG8=;
 b=LaAmJVM6szQIoamB6IWpS+Y+Izh0y/Su8Awl1fzOThne126r6M9a40rL/mj30Z6W8c
 KUxTgbIOIHBz3hd8lhKi6ci/5aQgze/bmLXhKAdfv+Yk/lwtudOTsIz1DLXSonjPTQ+8
 5RMLJbQ4gAUq4Eu5xO/9VikRN/C8yP49YYtVUJQK89dJJ3j3yYsGaj6+9dywq4RffylU
 aMBVE6x2k89LRdhezIy5fpMCFnFLgQZRCGYbwXSoVTAYMU4HTlSiauS4hFDnF7syfOQT
 0uOw4hPbZf1Xr8ZCGK/3uegZZFH4ipwpExwzMeoj2cg1c8y/h1C/FBmi1B/+B3AKc0yX
 xzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787327354; x=1787932154;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YOXgcGJK9N1WQaakfWFABKMtl8aENk5fGUqVyMouuG8=;
 b=OU8B/unM/o0BlMUGp6pPNwW9xV7a7auAaxDdCe8w6G6TX1Cp+3n29Om9XzJRhNd+d3
 5FrGXMaDbMvO9v7UkCObhfadjD8JjESUVuF/VGJjO8cAOUugX8u5NEi+xdKxDREswGOP
 zSyRXKUDoy4VEoPeKwlYd0wqOhknVMBmiAGIksw/I+VZYjlIKrjrlU/P9DLLDYjF/KzL
 BFrOFHKScZhK+IaHq8C91CWIoldY1SDQOQsnXzhK5JoxY9sUFi+DsldFIQ6IweNKyzqC
 ZBP0Q8eZTH0eIWIOWfFFAwl3bXi3vpRSR5Gq2I91PrcR5o4c1b5dXs9LpIcjLJzToLRX
 PZCw==
X-Gm-Message-State: AFuF++n5X15iymNs6o1BjJhq2zrbD94EM9P4sxjH9jzmm/5dydEn99Gf
 A3VB7G7KUgQMUNXSi685xL0qkBbbdcAdtGF9s3A68JpzIYrhrYf3FRTd4MTM5jg2HjvRSUJtFeX
 2ZDY1uJwbo8jpVD/3wCpqZqeOCdy6peEWtWdZ/OkdAHWB9YClQqNhgJdfXIfQ9jspgL6XdSPXqD
 0+9utd6g==
X-Gm-Gg: AR+sD13xg9/zRS1E2ZDLFlEAXWLIOmpj0qmp5ntTGXDNR+9XerPSl01w0bmgLBg1zky
 JdJuTwdUShuGqFOTLcxXzHpjOGbuZDB/OIt5pxbHMaOjqFzvHD6f7zEsWKfGsmiYHFTHjjIRXkp
 faDe61LklzjAn0M7uTsKFzoLouILL8epaskptZZv0Ifi583r4YtxjuyhQOIilOOwh9JQjJg3Yen
 Ag1laQZ+RUFfgjuTnd1uy5xvSPyEo4NsMVmZC7gFAKHBpFjyCvl4YogADsTENKF9JZEtLmqVZjT
 OCOwHheLt925CtawytQZp1CVZN7x6TYdpzwlYqq/nGUJQojcuu+yoHJLaNEX8oRRpgX0VdeeRrb
 mrnMznrGG0ZX1al3JdkmqF+DRnQ8hH3cbbaBWjO8DxlDxLqP/fXWNFxFdLbmvbOJc+6Bvzpjt5T
 KYrFtdMfa+HF8rVDwdPE5UNQF/shRdfoiFDLU3Da3HV0O6hmtx/v5tq8VYqW58Wy4b4jv3Ox2tT
 b5h2LD6BLecLxmhR3egGDgU0fNBOgBQwS3pljPBp6/vm+KILCLGZJpDukDPYSORxJzKHaShFsX/
 Pmlszr9HuWCUcDcoXKp+kXyLXz2nxqhkbV8b0mTP+OPmvt+Fm7QsA2PdUSVTQQ==
X-Received: by 2002:a17:906:a38c:b0:c15:e8c8:340 with SMTP id
 a640c23a62f3a-c246a731b85mr589016166b.23.1787327353221; 
 Fri, 21 Aug 2026 08:49:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b09599sm485979366b.21.2026.08.21.08.49.12
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:49:12 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 15:49:11 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: b6765fad7f1140ca9db5229e7198306fc21f081e
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c968ef62972f66b7a82d95f9737a12451ebabcc1-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxRUe-0005bl-BH
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
Content-Type: multipart/mixed; boundary="===============7499369187948925413=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7499369187948925413==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hP3lW32lGoY="; charset=UTF-8

--hP3lW32lGoY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1852?usp=3Demail )


Change subject: Add unix-script fun=
ctionality to the --management feature
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Add unix-script functionality to the --management=
 feature

This allows a script that handles management input/output to
be s=
tarted alongside OpenVPN simpler in small deployments=2E

Change-Id: I307e6=
4079f436aa782f7e24bfff665a545ad2fa0
Signed-off-by: Arne Schwabe <arne@rfc25=
49=2Eorg>
---
M doc/man-sections/management-options=2Erst
M doc/management-=
notes=2Etxt
M src/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/m=
anage=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
7 files chang=
ed, 99 insertions(+), 9 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/52/1852/1

diff --git a/doc/man-sections/=
management-options=2Erst b/doc/man-sections/management-options=2Erst
index =
8dad52b=2E=2E89d600d 100644
--- a/doc/man-sections/management-options=2Erst=

+++ b/doc/man-sections/management-options=2Erst
@@ -14,6 +14,7 @@
     man=
agement socket-name unix pw-file  # (recommended)
     management IP port  =
                 # (INSECURE)
     management IP port pw-file           #
+=
    management script unix-script
 
   ``pw-file``, if specified, is a pass=
word file where the password must
   be on first line=2E Instead of a filen=
ame it can use the keyword stdin
@@ -25,6 +26,13 @@
   ``--management-clien=
t-user`` and ``--management-client-group``
   directives to restrict access=
=2E
 
+  When the variant :code:`unix-script` is used, OpenVPN will start t=
he
+  specified script on startup and enable ``--management-hold``=2E
+  Op=
enVPN will generate a random path for the unix socket
+  and also managemen=
t user and password=2E These are passed as environment
+  variables :code:`=
MANAGEMENT_SOCKET`, :code:`MANAGEMENT_USER` and
+  :code:`MANAGEMENT_PASSWO=
RD` to the script when being started=2E
+
   The management interface provi=
des a special mode where the TCP
   management link can operate over the tu=
nnel itself=2E To enable this mode,
   set IP to ``tunnel``=2E Tunnel mode =
will cause the management interface to
@@ -129,8 +137,9 @@
 --management-si=
gnal
   Send SIGUSR1 signal to OpenVPN if management session disconnects=2E=
 This
   is useful when you wish to disconnect an OpenVPN session on user l=
ogoff=2E
-  For ``--management-client`` this option is not needed since a d=
isconnect
-  will always generate a :code:`SIGTERM`=2E
+  For ``--managemen=
t-client`` or  ``--management`` with :code:`unixscript`
+  this option is n=
ot needed since a disconnect  will always generate a
+  :code:`SIGTERM`=2E
=
 
 --management-up-down
   Report tunnel up/down events to management inter=
face=2E
diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etx=
t
index 1126468=2E=2Ed6b3fbb 100644
--- a/doc/management-notes=2Etxt
+++ b/=
doc/management-notes=2Etxt
@@ -35,6 +35,10 @@
 you can telnet to the manage=
ment port (make sure to use
 a telnet client which understands "raw" mode)=
=2E
 
+When password authentication is enabled, the management interface
+w=
ill require sending the password on its own line after establishing
+the co=
nnection=2E
+
 Once connected to the management port, you can use
 the "hel=
p" command to list all commands=2E
 
diff --git a/src/openvpn/init=2Ec b/sr=
c/openvpn/init=2Ec
index 66bae34=2E=2E101fa64 100644
--- a/src/openvpn/init=
=2Ec
+++ b/src/openvpn/init=2Ec
@@ -4337,19 +4337,59 @@
     }
 }
 
+void
+=
run_management_script(struct context *c)
+{
+#ifdef UNIX_SOCK_SUPPORT
+    =
struct gc_arena gc =3D gc_new();
+    struct argv argv =3D argv_new();
+   =
 struct env_set *env =3D env_set_create(&gc);
+
+    setenv_str(env, "MANAG=
EMENT_USER", management->settings=2Eup=2Eusername);
+    setenv_str(env, "M=
ANAGEMENT_PASSWORD", management->settings=2Eup=2Epassword);
+    setenv_str=
(env, "MANAGEMENT_SOCKET", c->options=2Emanagement_addr);
+
+    argv_print=
f(&argv, "%s", c->options=2Emanagement_script);
+
+    int flags =3D S_NOWA=
ITPID | S_SCRIPT | S_FATAL;
+    int *pid =3D &management->connection=2Euni=
x_script_pid;
+    const char *msg_prefix =3D "WARNING: Failed running mana=
gement unix-script";
+    *pid =3D openvpn_execve_check(&argv, env, flags, =
msg_prefix);
+
+    if (!openvpn_waitpid_check(*pid, msg_prefix, M_FATAL))
=
+    {
+        *pid =3D 0;
+    }
+
+    argv_free(&argv);
+    gc_free(&g=
c);
+#else
+    msg(M_FATAL, "ERROR: Management unix-socket support is not =
available on this platform );
+#endif
+}
+
 bool
 open_management(struct co=
ntext *c)
 {
     /* initialize management layer */
     if (management)
  =
   {
+        unsigned int flags =3D c->options=2Emanagement_flags;
+      =
  if (flags & MF_UNIX_SOCK_SCRIPT)
+        {
+            /* This creates =
a file but our management codes deletes the
+             * file before ope=
ning a socket with the name */
+            c->options=2Emanagement_addr =
=3D platform_create_temp_file(
+                platform_get_tmp_dir(), "om=
i", &c->gc);
+        }
+
         if (c->options=2Emanagement_addr)
      =
   {
-            unsigned int flags =3D c->options=2Emanagement_flags;
   =
          if (c->options=2Emode =3D=3D MODE_SERVER)
             {
        =
         flags |=3D MF_SERVER;
             }
+
             if (management=
_open(
                     management, c->options=2Emanagement_addr, c->op=
tions=2Emanagement_port,
                     c->options=2Emanagement_user_=
pass, c->options=2Emanagement_client_user,
@@ -4361,6 +4401,11 @@
         =
                             NULL);
             }
 
+            if (flags=
 & MF_UNIX_SOCK_SCRIPT)
+            {
+                run_management_scri=
pt(c);
+            }
+
             /* initial management hold, called ear=
ly, before first context initialization */
             do_hold(0);
       =
      if (IS_SIG(c))
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/mana=
ge=2Ec
index 95ff246=2E=2Ebfc2aa2 100644
--- a/src/openvpn/manage=2Ec
+++ b=
/src/openvpn/manage=2Ec
@@ -333,10 +333,12 @@
 man_delete_unix_socket(struc=
t management *man)
 {
 #if UNIX_SOCK_SUPPORT
-    if ((man->settings=2Eflag=
s & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
+    if ((m=
an->settings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNI=
X_SOCK
+        || man->settings=2Eflags & MF_UNIX_SOCK_SCRIPT)
     {
    =
     socket_delete_unix(&man->settings=2Elocal_unix);
     }
+
 #endif
 }
 =

@@ -2197,7 +2199,7 @@
             }
         }
 
-        if (man->settin=
gs=2Eflags & MF_CONNECT_AS_CLIENT)
+        if (man->settings=2Eflags & (MF=
_CONNECT_AS_CLIENT | MF_UNIX_SOCK_SCRIPT))
         {
             msg(D_MA=
NAGEMENT, "MANAGEMENT: Triggering management exit");
             throw_sig=
nal_soft(SIGTERM, "management-exit");
@@ -2644,6 +2646,15 @@
         {
   =
          get_user_pass(&ms->up, pass_file, "Management", GET_USER_PASS_PAS=
SWORD_ONLY);
         }
+        else if (ms->flags & MF_UNIX_SOCK_SCRIPT)
=
+        {
+            /* Set random password=2E The password is only
+   =
          * alphanumerical [0-9a-f] but still has 128 bit of randomness,
+ =
            * which is more than enough */
+            snprintf(ms->up=2Ep=
assword, sizeof(ms->up=2Epassword),
+                     "%" PRIx64 "%" PR=
Ix64, get_random(), get_random());
+            ms->up=2Edefined =3D true;
=
+        }
 
 #if UNIX_SOCK_SUPPORT
         /*
@@ -2789,6 +2800,11 @@
    =
     man_close_socket(man, mc->sd_cli);
     }
 
+    if (mc->unix_script_p=
id)
+    {
+        kill(mc->unix_script_pid, SIGINT);
+    }
+
     comman=
d_line_free(mc->in);
     buffer_list_free(mc->out);
 
diff --git a/src/ope=
nvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 27d3b60=2E=2E71e88d0 100644
=
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -42,6 +42,7 @@=

 #define MF_EXTERNAL_CERT          (1u << 15)
 #define MF_EXTERNAL_KEY_PSS=
PAD    (1u << 16)
 #define MF_EXTERNAL_KEY_DIGEST    (1u << 17)
+#define MF=
_UNIX_SOCK_SCRIPT       (1u << 18)
 
 #ifdef ENABLE_MANAGEMENT
 
@@ -327,6 =
+328,9 @@
     int fdtosend;
     int lastfdreceived;
 #endif
+#ifdef UNIX_=
SOCK_SUPPORT
+    pid_t unix_script_pid;
+#endif
     int client_version;
 =
};
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 9=
bd6f01=2E=2E4391434 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/=
options=2Ec
@@ -1739,7 +1739,7 @@
      * Check for consistency of manageme=
nt options
      */
 #ifdef ENABLE_MANAGEMENT
-    if (!options->management=
_addr
+    if (!options->management_addr && !(options->management_flags & M=
F_UNIX_SOCK_SCRIPT)
         && (options->management_flags
             || =
options->management_log_history_cache !=3D defaults=2Emanagement_log_histor=
y_cache))
     {
@@ -4333,7 +4333,7 @@
     else if (streq(p[0], "managemen=
t") && p[1] && p[2] && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENER=
AL);
-        if (streq(p[2], "unix"))
+        if (streq(p[2], "unix") || =
streq(p[2], "unix-script"))
         {
 #if UNIX_SOCK_SUPPORT
             =
options->management_flags |=3D MF_UNIX_SOCK;
@@ -4343,7 +4343,16 @@
 #endif=

         }
 
-        options->management_addr =3D p[1];
+        if (stre=
q(p[2], "unix-script"))
+        {
+            options->management_flags |=
=3D MF_UNIX_SOCK_SCRIPT | MF_HOLD;
+            set_user_script(options, &o=
ptions->management_script, p[1],
+                            "management u=
nix-script", false);
+        }
+        else
+        {
+            optio=
ns->management_addr =3D p[1];
+        }
         options->management_port =
=3D p[2];
         if (p[3])
         {
diff --git a/src/openvpn/options=2E=
h b/src/openvpn/options=2Eh
index 9fa44f0=2E=2Ede69c8e 100644
--- a/src/ope=
nvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -446,6 +446,8 @@
     con=
st char *management_addr;
     const char *management_port;
     const char=
 *management_user_pass;
+    /** Script executed to talk to the management =
interface */
+    const char *management_script;
     int management_log_hi=
story_cache;
     int management_echo_buffer_size;
     int management_stat=
e_buffer_size;
@@ -761,7 +763,8 @@
 #define OPT_P_PUSH_MTU        (1u << 30=
)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
 
-#define OPT_P_DEFAULT (~(OPT=
_P_INSTANCE | OPT_P_PULL_MODE | 0x0ull))
+/* Options allowed in the normal =
configuration file */
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL=
_MODE | OPT_P_ACC | OPT_P_PEER_ID))
 
 #define PULL_DEFINED(opt) ((opt)->pu=
ll)
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I307e64079f43=
6aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
Gerrit-PatchSet: 1
=
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--hP3lW32lGoY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Add unix-script functionality to the --management feature<br><br>T=
his allows a script that handles management input/output to<br>be started a=
longside OpenVPN simpler in small deployments=2E<br><br>Change-Id: I307e640=
79f436aa782f7e24bfff665a545ad2fa0<br>Signed-off-by: Arne Schwabe &lt;arne@r=
fc2549=2Eorg&gt;<br>---<br>M doc/man-sections/management-options=2Erst<br>M=
 doc/management-notes=2Etxt<br>M src/openvpn/init=2Ec<br>M src/openvpn/mana=
ge=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/options=2Ec<br>M src/op=
envpn/options=2Eh<br>7 files changed, 99 insertions(+), 9 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/52/1852/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/doc/man-sections/management-opt=
ions=2Erst b/doc/man-sections/management-options=2Erst</span><br><span>inde=
x 8dad52b=2E=2E89d600d 100644</span><br><span>--- a/doc/man-sections/manage=
ment-options=2Erst</span><br><span>+++ b/doc/man-sections/management-option=
s=2Erst</span><br><span>@@ -14,6 +14,7 @@</span><br><span>     management s=
ocket-name unix pw-file  # (recommended)</span><br><span>     management IP=
 port                   # (INSECURE)</span><br><span>     management IP por=
t pw-file           #</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    management script unix-script</span><br><span> </span><br><span>   ``=
pw-file``, if specified, is a password file where the password must</span><=
br><span>   be on first line=2E Instead of a filename it can use the keywor=
d stdin</span><br><span>@@ -25,6 +26,13 @@</span><br><span>   ``--managemen=
t-client-user`` and ``--management-client-group``</span><br><span>   direct=
ives to restrict access=2E</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  When the variant :code:`unix-script` is used, Op=
enVPN will start the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  specified script on startup and enable ``--management-hold``=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN will generate a ra=
ndom path for the unix socket</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  and also management user and password=2E These are passed as en=
vironment</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  variable=
s :code:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_USER` and</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  :code:`MANAGEMENT_PASSWORD` to the s=
cript when being started=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>   The management interface provides a special mod=
e where the TCP</span><br><span>   management link can operate over the tun=
nel itself=2E To enable this mode,</span><br><span>   set IP to ``tunnel``=
=2E Tunnel mode will cause the management interface to</span><br><span>@@ -=
129,8 +137,9 @@</span><br><span> --management-signal</span><br><span>   Sen=
d SIGUSR1 signal to OpenVPN if management session disconnects=2E This</span=
><br><span>   is useful when you wish to disconnect an OpenVPN session on u=
ser logoff=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  For ``=
--management-client`` this option is not needed since a disconnect</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  will always generate a :code=
:`SIGTERM`=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  For =
``--management-client`` or  ``--management`` with :code:`unixscript`</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  this option is not neede=
d since a disconnect  will always generate a</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  :code:`SIGTERM`=2E</span><br><span> </span><br><=
span> --management-up-down</span><br><span>   Report tunnel up/down events =
to management interface=2E</span><br><span>diff --git a/doc/management-note=
s=2Etxt b/doc/management-notes=2Etxt</span><br><span>index 1126468=2E=2Ed6b=
3fbb 100644</span><br><span>--- a/doc/management-notes=2Etxt</span><br><spa=
n>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -35,6 +35,10 @@</span=
><br><span> you can telnet to the management port (make sure to use</span><=
br><span> a telnet client which understands &quot;raw&quot; mode)=2E</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+When pas=
sword authentication is enabled, the management interface</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+will require sending the password on =
its own line after establishing</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+the connection=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> Once connected to the management port, you can =
use</span><br><span> the &quot;help&quot; command to list all commands=2E</=
span><br><span> </span><br><span>diff --git a/src/openvpn/init=2Ec b/src/op=
envpn/init=2Ec</span><br><span>index 66bae34=2E=2E101fa64 100644</span><br>=
<span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec=
</span><br><span>@@ -4337,19 +4337,59 @@</span><br><span>     }</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+run_manag=
ement_script(struct context *c)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef=
 UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct argv argv =3D argv_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct env_set *env =3D env_set_creat=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(env, &quot;M=
ANAGEMENT_USER&quot;, management-&gt;settings=2Eup=2Eusername);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(env, &quot;MANAG=
EMENT_PASSWORD&quot;, management-&gt;settings=2Eup=2Epassword);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(env, &quot;MANAG=
EMENT_SOCKET&quot;, c-&gt;options=2Emanagement_addr);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s&quot;, c-&gt;options=2Em=
anagement_script);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int flags =3D S_=
NOWAITPID | S_SCRIPT | S_FATAL;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int *pid =3D &amp;management-&gt;connection=2Eunix_script_p=
id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
msg_prefix =3D &quot;WARNING: Failed running management unix-script&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *pid =3D openvpn=
_execve_check(&amp;argv, env, flags, msg_prefix);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!openvpn_waitpid_check(*pid, msg_prefix, M_FATAL))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        *pid =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    argv_free(&amp;argv);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 msg(M_FATAL, &quot;ERROR: Management unix-socket support is not available =
on this platform );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><b=
r><span> open_management(struct context *c)</span><br><span> {</span><br><s=
pan>     /* initialize management layer */</span><br><span>     if (managem=
ent)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        unsigned int flags =3D c-&gt;options=2Emanagement_flags;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp=
; MF_UNIX_SOCK_SCRIPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     /* This creates a file but our management codes deletes the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+             * file before ope=
ning a socket with the name */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            c-&gt;options=2Emanagement_addr =3D platform_create_=
temp_file(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       platform_get_tmp_dir(), &quot;omi&quot;, &amp;c-&gt;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (c-&gt;optio=
ns=2Emanagement_addr)</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            unsigned int flags =3D c-&gt;options=
=2Emanagement_flags;</span><br><span>             if (c-&gt;options=2Emode =
=3D=3D MODE_SERVER)</span><br><span>             {</span><br><span>        =
         flags |=3D MF_SERVER;</span><br><span>             }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             if =
(management_open(</span><br><span>                     management, c-&gt;op=
tions=2Emanagement_addr, c-&gt;options=2Emanagement_port,</span><br><span> =
                    c-&gt;options=2Emanagement_user_pass, c-&gt;options=2Em=
anagement_client_user,</span><br><span>@@ -4361,6 +4401,11 @@</span><br><sp=
an>                                      NULL);</span><br><span>           =
  }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                run_management_script(c);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             /* i=
nitial management hold, called early, before first context initialization *=
/</span><br><span>             do_hold(0);</span><br><span>             if =
(IS_SIG(c))</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openv=
pn/manage=2Ec</span><br><span>index 95ff246=2E=2Ebfc2aa2 100644</span><br><=
span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=
=2Ec</span><br><span>@@ -333,10 +333,12 @@</span><br><span> man_delete_unix=
_socket(struct management *man)</span><br><span> {</span><br><span> #if UNI=
X_SOCK_SUPPORT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=
=3D MF_UNIX_SOCK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)=
) =3D=3D MF_UNIX_SOCK</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        || man-&gt;settings=2Eflags &amp; MF_UNIX_SOCK_SCRIPT)</span><br>=
<span>     {</span><br><span>         socket_delete_unix(&amp;man-&gt;setti=
ngs=2Elocal_unix);</span><br><span>     }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> #endif</span><br><span> }</span><br=
><span> </span><br><span>@@ -2197,7 +2199,7 @@</span><br><span>            =
 }</span><br><span>         }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (man-&gt;settings=2Eflags &amp; MF_CON=
NECT_AS_CLIENT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (man-&gt;settings=2Eflags &amp; (MF_CONNECT_AS_CLIENT | MF_UNIX_SOCK=
_SCRIPT))</span><br><span>         {</span><br><span>             msg(D_MAN=
AGEMENT, &quot;MANAGEMENT: Triggering management exit&quot;);</span><br><sp=
an>             throw_signal_soft(SIGTERM, &quot;management-exit&quot;);</s=
pan><br><span>@@ -2644,6 +2646,15 @@</span><br><span>         {</span><br><=
span>             get_user_pass(&amp;ms-&gt;up, pass_file, &quot;Management=
&quot;, GET_USER_PASS_PASSWORD_ONLY);</span><br><span>         }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        else if (ms-&gt;flags =
&amp; MF_UNIX_SOCK_SCRIPT)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         /* Set random password=2E The password is only</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+             * alphanumerical [0-9a-f] =
but still has 128 bit of randomness,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+             * which is more than enough */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            snprintf(ms-&gt;up=2Ep=
assword, sizeof(ms-&gt;up=2Epassword),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                     &quot;%&quot; PRIx64 &quot;%&quot; =
PRIx64, get_random(), get_random());</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            ms-&gt;up=2Edefined =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> </span><b=
r><span> #if UNIX_SOCK_SUPPORT</span><br><span>         /*</span><br><span>=
@@ -2789,6 +2800,11 @@</span><br><span>         man_close_socket(man, mc-&g=
t;sd_cli);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (mc-&gt;unix_script_pid)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        kill(mc-&gt;unix_script_pid, SIGI=
NT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     command=
_line_free(mc-&gt;in);</span><br><span>     buffer_list_free(mc-&gt;out);</=
span><br><span> </span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/=
openvpn/manage=2Eh</span><br><span>index 27d3b60=2E=2E71e88d0 100644</span>=
<br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/ma=
nage=2Eh</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #define MF_EXTE=
RNAL_CERT          (1u &lt;&lt; 15)</span><br><span> #define MF_EXTERNAL_KE=
Y_PSSPAD    (1u &lt;&lt; 16)</span><br><span> #define MF_EXTERNAL_KEY_DIGES=
T    (1u &lt;&lt; 17)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define MF_UNIX_SOCK_SCRIPT       (1u &lt;&lt; 18)</span><br><span> </spa=
n><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> </span><br><span>@@ =
-327,6 +328,9 @@</span><br><span>     int fdtosend;</span><br><span>     in=
t lastfdreceived;</span><br><span> #endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifdef UNIX_SOCK_SUPPORT</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    pid_t unix_script_pid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     int client_ve=
rsion;</span><br><span> };</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 9bd6=
f01=2E=2E4391434 100644</span><br><span>--- a/src/openvpn/options=2Ec</span=
><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -1739,7 +1739,7=
 @@</span><br><span>      * Check for consistency of management options</sp=
an><br><span>      */</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (!options-&gt;management_a=
ddr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!options=
-&gt;management_addr &amp;&amp; !(options-&gt;management_flags &amp; MF_UNI=
X_SOCK_SCRIPT)</span><br><span>         &amp;&amp; (options-&gt;management_=
flags</span><br><span>             || options-&gt;management_log_history_ca=
che !=3D defaults=2Emanagement_log_history_cache))</span><br><span>     {</=
span><br><span>@@ -4333,7 +4333,7 @@</span><br><span>     else if (streq(p[=
0], &quot;management&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4=
])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_=
GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
streq(p[2], &quot;unix&quot;))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (streq(p[2], &quot;unix&quot;) || streq(p[2], &quot;u=
nix-script&quot;))</span><br><span>         {</span><br><span> #if UNIX_SOC=
K_SUPPORT</span><br><span>             options-&gt;management_flags |=3D MF=
_UNIX_SOCK;</span><br><span>@@ -4343,7 +4343,16 @@</span><br><span> #endif<=
/span><br><span>         }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        options-&gt;management_addr =3D p[1];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (streq(p[2], &q=
uot;unix-script&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      options-&gt;management_flags |=3D MF_UNIX_SOCK_SCRIPT | MF_HOLD;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            set_user_scr=
ipt(options, &amp;options-&gt;management_script, p[1],</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                            &quot;manage=
ment unix-script&quot;, false);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            opt=
ions-&gt;management_addr =3D p[1];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span>         options-&gt;management_po=
rt =3D p[2];</span><br><span>         if (p[3])</span><br><span>         {<=
/span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh</span><br><span>index 9fa44f0=2E=2Ede69c8e 100644</span><br><span>--- =
a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</sp=
an><br><span>@@ -446,6 +446,8 @@</span><br><span>     const char *managemen=
t_addr;</span><br><span>     const char *management_port;</span><br><span> =
    const char *management_user_pass;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /** Script executed to talk to the management interfa=
ce */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *management_script;</span><br><span>     int management_log_history_cache;=
</span><br><span>     int management_echo_buffer_size;</span><br><span>    =
 int management_state_buffer_size;</span><br><span>@@ -761,7 +763,8 @@</spa=
n><br><span> #define OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</span><br><span=
> #define OPT_P_ROUTE_TABLE     (1u &lt;&lt; 31)</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_DEFAULT (~(OPT_P=
_INSTANCE | OPT_P_PULL_MODE | 0x0ull))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* Options allowed in the normal configuration file */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_DEFAULT=
 (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_ACC | OPT_P_PEER_ID))</span><b=
r><span> </span><br><span> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span=
><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">change 1852</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I307e64=
079f436aa782f7e24bfff665a545ad2fa0 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1852 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--hP3lW32lGoY=--


--===============7499369187948925413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7499369187948925413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7499369187948925413==--

