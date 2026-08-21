Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CDCC5DF7D
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q0V+XPi/H70aqZsjrPk5cRvY7NzWh7rYjJID2nWasl0=; b=AB3BSredPZxfNwICv+LaT96vp5
	0o6AMiSkvt+rv3JaHotI3TdjacgcdAo9m1TetPiZdHnKxKHQsPRqVXix9tAjTyIcQ/kJ4dXMMJisJ
	BDhAvE4fClbWnA3JiZL17RMZBU6ZgG8H1SLqOHbfpEpCG3Ex9RClqM+DS7mT0ovTfeq0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxWCY-0001F2-3k;
	Fri, 21 Aug 2026 20:50:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxWCE-0001D1-8i
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 20:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=onkQ3FoI1iffra5pVNtjTUuRevdLE6kkirmy+XrY8xE=; b=fJlHKrffH7ZuPebRMpdIQf8gpd
 qg8hNgr34ZQyeBJvtZWS4+eDl38UIFeWy4v1PglwJNZaRkKriZcKcAekiNO75n6A9bm1SGYloPhIE
 6SH/BQUJMp+Tn1EJvL3IaLqhzhAzmHwN9HHHBSAGspZXi6yWxq/Ul2KqxjZ3Kz/+T2HI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=onkQ3FoI1iffra5pVNtjTUuRevdLE6kkirmy+XrY8xE=; b=A
 yU0CrXkfnICMnNPZWAT8hTBsZgHQnAbTCJBHu9PSGN5ccffqxhiZu+Y6HNYBy692LeBLmCPkmkqW2
 2SeUlDq2FKh6dZkxSP3hsqLJwlfIeRQVWteBkR0063m0k62kqjq00Xj9Es10Bd5MKbvQVAJpBjkQY
 GeXDYgT4YNmGSZ7Y=;
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxWCB-00052m-CP for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 20:50:37 +0000
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so514361866b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 13:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787345429; x=1787950229; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=onkQ3FoI1iffra5pVNtjTUuRevdLE6kkirmy+XrY8xE=;
 b=egrlW9Ql8/cmZ4dklhjJVUDWecpzaf03TXvMT2Lkjnn0VNmZ5CQ35+/tuEW2EB2+lB
 vbndwa15cnPHTAyZ//dMmBq1QyokFCPvZ9eHVP1s0nvAnDtAyaILgKfB/vel782gmeD0
 SkSNv/zb7Fgbz9wFBBCU0ii6MKn91k2fTatP40HQj9E8vmP/nUOGoNoiwZ7YIOD4MyZ6
 Oi1QnSJMnUcoCVWUZYIj3Z5J8mvm3XEy4GyKsC/yYEI3k9FyFxcVdCR10tN8T9gk6hPE
 tL8pswrTHHhJ6VPW5CAIWRYyIgihYJDATpYCda/yCLoyfRXUqvYJGim4lMyPhxaYyBXe
 bUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787345429; x=1787950229;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=onkQ3FoI1iffra5pVNtjTUuRevdLE6kkirmy+XrY8xE=;
 b=fFCbkCI4ANRUoRF0gP/5zSo7nCXIXit12cWbjysAYSS/rsRNsucqLga9EC6nlmkK/v
 DsiB0xAd3P9G+0Ap7uhJIOzI1JgGBuW2DFjp3SWcIInIgnWvhfcyIi2cvCT51s1l13Zn
 cJjc+RHI4PTKg/UC6ZsXW1MUfoo+u37L1Zt+6dQtbrr3w2VUzvKkLXBeiy0czF6LqoEw
 hsxLzPUSkz9D8+jnkwFoS6LrQNjPkepgvfvyXq1PTddZZyY7V+smnnvVcBakynWBUnph
 oUUb13hBX2Z0LYY+YcTgjmPv1Ow9DaMDKrXB2E1+Oz2w+zvnpZ0D498O5SJyAhaZTKpF
 rKkQ==
X-Gm-Message-State: AFuF++k4UooH9TF165vdVjE+0+epdkqkdPBV3/VLPqtNqTnL54C1H1Id
 KrVsGuEF0zD/NaF+nJbGgwIGJowbiBdM6FuGlb38M+bH47m+5ZdWLhMioJ/qf+hSBwu9Ed911jj
 N8ii+8BA+TqkMMGZh/xRsa5arbmClgdcXHjz81hkpzmXiL9bhXwMTXzc6gKsMnMtjU3ZYfiTfBI
 1BSdn4RQ==
X-Gm-Gg: AR+sD12e2LGXEok723zUuJOSvwG2fnxBId3ob+yonfdwBIMZAFN6XP5ZGIxwya2tDry
 KFoeTO2VWURYD/4J6jSeU/eRFvEs0yuXY9sG+P0aKMojoxygDojTlPUIiXqxPicAqhKg5swwnjA
 NowsPlAXksGCjG7p++9r1h57sisklD5hNx+MPgIBuTOgjAudlYs/+PnYWTXwmZIqLxum0qfK0Nz
 B0VLvBFH2eXxMTMn2fu4nPTSWwGprzTha9ZwHqmMdbI6v8LGmq61gmeqDCGG7pzBHDbDPgTI3Ta
 X7zv336cTXG7fXpu72me7B++Wgl/Rth4wAcsMFbMWlCA2+F4cy6ZZx9n+cTO5QxrSkABXA5QfQp
 GbLAy73YdS32H4R9TSEPDnm9S4ju4ox7wiKZOgaQg2/xehIVNKxVMoLhU1UGwM6WsFUUt0snJjc
 Pz89Sang5DMaEkNJiejHkIaqdVM/scREe3Ujxpgr3LPuBLOeWBzPtlEmpkqnJAQVjZzmTiJXBpc
 2oZJ6Fp48pFYkclv2E1gvwDThaJnbv6y8aOHkeqvR+AzNdH/Sg2Vcdpu8doYrY7zxCqFmz2dVFT
 DLtKzLRqg55Wh2KEn1vZG6DmrqOO4XWefNSZ9s1mbNm7XeNjr1I=
X-Received: by 2002:a17:907:5ce:b0:c1f:2cb2:c448 with SMTP id
 a640c23a62f3a-c244d672d37mr1389398266b.7.1787345428532; 
 Fri, 21 Aug 2026 13:50:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b648f9sm616014266b.28.2026.08.21.13.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 13:50:28 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 20:50:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 3b7d368b9b41511803e55df1f2e988218f9baab4
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <107edf4906f17a00112a83549d303befef47fe16-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxWCB-00052m-CP
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
Content-Type: multipart/mixed; boundary="===============8196491710106717984=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8196491710106717984==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uD1/sa2uAtE="; charset=UTF-8

--uD1/sa2uAtE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2)=2E ( http://gerrit=2Eopenvpn=2E=
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
, 100 insertions(+), 9 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/52/1852/2

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
dex 66bae34=2E=2E101fa64 100644
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
+#ifdef UNIX_SOCK_SUPPORT
+    struct gc_arena gc =
=3D gc_new();
+    struct argv argv =3D argv_new();
+    struct env_set *en=
v =3D env_set_create(&gc);
+
+    setenv_str(env, "MANAGEMENT_USER", manage=
ment->settings=2Eup=2Eusername);
+    setenv_str(env, "MANAGEMENT_PASSWORD"=
, management->settings=2Eup=2Epassword);
+    setenv_str(env, "MANAGEMENT_S=
OCKET", c->options=2Emanagement_addr);
+
+    argv_printf(&argv, "%s", c->o=
ptions=2Emanagement_script);
+
+    int flags =3D S_NOWAITPID | S_SCRIPT | =
S_FATAL;
+    int *pid =3D &management->connection=2Eunix_script_pid;
+    =
const char *msg_prefix =3D "WARNING: Failed running management unix-script"=
;
+    *pid =3D openvpn_execve_check(&argv, env, flags, msg_prefix);
+
+   =
 if (!openvpn_waitpid_check(*pid, msg_prefix, M_FATAL))
+    {
+        *pi=
d =3D 0;
+    }
+
+    argv_free(&argv);
+    gc_free(&gc);
+#else
+    msg=
(M_FATAL, "ERROR: Management unix-socket support is not available on this p=
latform );
+#endif
+}
+
 bool
 open_management(struct context *c)
 {
     /=
* initialize management layer */
     if (management)
     {
+        unsig=
ned int flags =3D c->options=2Emanagement_flags;
+        if (flags & MF_UN=
IX_SOCK_SCRIPT)
+        {
+            /* This creates a file but our mana=
gement codes deletes the
+             * file before opening a socket with =
the name */
+            c->options=2Emanagement_addr =3D platform_create_t=
emp_file(
+                platform_get_tmp_dir(), "omi", &c->gc);
+       =
 }
+
         if (c->options=2Emanagement_addr)
         {
-            uns=
igned int flags =3D c->options=2Emanagement_flags;
             if (c->opti=
ons=2Emode =3D=3D MODE_SERVER)
             {
                 flags |=3D M=
F_SERVER;
             }
+
             if (management_open(
              =
       management, c->options=2Emanagement_addr, c->options=2Emanagement_po=
rt,
                     c->options=2Emanagement_user_pass, c->options=2Ema=
nagement_client_user,
@@ -4361,6 +4401,11 @@
                              =
        NULL);
             }
 
+            if (flags & MF_UNIX_SOCK_SCRIP=
T)
+            {
+                run_management_script(c);
+            }=

+
             /* initial management hold, called early, before first cont=
ext initialization */
             do_hold(0);
             if (IS_SIG(c))
=
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 95ff246=
=2E=2Ebfc2aa2 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=
=2Ec
@@ -333,10 +333,12 @@
 man_delete_unix_socket(struct management *man)
=
 {
 #if UNIX_SOCK_SUPPORT
-    if ((man->settings=2Eflags & (MF_UNIX_SOCK |=
 MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
+    if ((man->settings=2Eflag=
s & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK
+        || =
man->settings=2Eflags & MF_UNIX_SOCK_SCRIPT)
     {
         socket_delete_=
unix(&man->settings=2Elocal_unix);
     }
+
 #endif
 }
 
@@ -2197,7 +2199,7=
 @@
             }
         }
 
-        if (man->settings=2Eflags & MF_CON=
NECT_AS_CLIENT)
+        if (man->settings=2Eflags & (MF_CONNECT_AS_CLIENT =
| MF_UNIX_SOCK_SCRIPT))
         {
             msg(D_MANAGEMENT, "MANAGEME=
NT: Triggering management exit");
             throw_signal_soft(SIGTERM, "=
management-exit");
@@ -2644,6 +2646,15 @@
         {
             get_user_=
pass(&ms->up, pass_file, "Management", GET_USER_PASS_PASSWORD_ONLY);
      =
   }
+        else if (ms->flags & MF_UNIX_SOCK_SCRIPT)
+        {
+       =
     /* Set random password=2E The password is only
+             * alphanu=
merical [0-9a-f] but still has 128 bit of randomness,
+             * which=
 is more than enough */
+            snprintf(ms->up=2Epassword, sizeof(ms-=
>up=2Epassword),
+                     "%" PRIx64 "%" PRIx64, get_random(),=
 get_random());
+            ms->up=2Edefined =3D true;
+        }
 
 #if U=
NIX_SOCK_SUPPORT
         /*
@@ -2789,6 +2800,11 @@
         man_close_sock=
et(man, mc->sd_cli);
     }
 
+    if (mc->unix_script_pid)
+    {
+       =
 kill(mc->unix_script_pid, SIGINT);
+    }
+
     command_line_free(mc->in)=
;
     buffer_list_free(mc->out);
 
diff --git a/src/openvpn/manage=2Eh b/s=
rc/openvpn/manage=2Eh
index 27d3b60=2E=2E71e88d0 100644
--- a/src/openvpn/m=
anage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -42,6 +42,7 @@
 #define MF_EXTERN=
AL_CERT          (1u << 15)
 #define MF_EXTERNAL_KEY_PSSPAD    (1u << 16)
 =
#define MF_EXTERNAL_KEY_DIGEST    (1u << 17)
+#define MF_UNIX_SOCK_SCRIPT  =
     (1u << 18)
 
 #ifdef ENABLE_MANAGEMENT
 
@@ -327,6 +328,9 @@
     int =
fdtosend;
     int lastfdreceived;
 #endif
+#ifdef UNIX_SOCK_SUPPORT
+    p=
id_t unix_script_pid;
+#endif
     int client_version;
 };
 
diff --git a/s=
rc/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 9bd6f01=2E=2E4391434=
 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -173=
9,7 +1739,7 @@
      * Check for consistency of management options
      */=

 #ifdef ENABLE_MANAGEMENT
-    if (!options->management_addr
+    if (!opt=
ions->management_addr && !(options->management_flags & MF_UNIX_SOCK_SCRIPT)=

         && (options->management_flags
             || options->management=
_log_history_cache !=3D defaults=2Emanagement_log_history_cache))
     {
@@=
 -4333,7 +4333,7 @@
     else if (streq(p[0], "management") && p[1] && p[2]=
 && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (s=
treq(p[2], "unix"))
+        if (streq(p[2], "unix") || streq(p[2], "unix-s=
cript"))
         {
 #if UNIX_SOCK_SUPPORT
             options->management=
_flags |=3D MF_UNIX_SOCK;
@@ -4343,7 +4343,16 @@
 #endif
         }
 
-    =
    options->management_addr =3D p[1];
+        if (streq(p[2], "unix-scrip=
t"))
+        {
+            options->management_flags |=3D MF_UNIX_SOCK_SC=
RIPT | MF_HOLD;
+            set_user_script(options, &options->management_=
script, p[1],
+                            "management unix-script", false)=
;
+        }
+        else
+        {
+            options->management_addr=
 =3D p[1];
+        }
         options->management_port =3D p[2];
         =
if (p[3])
         {
diff --git a/src/openvpn/options=2Eh b/src/openvpn/opt=
ions=2Eh
index e93b05b=2E=2Ee92a5cd 100644
--- a/src/openvpn/options=2Eh
++=
+ b/src/openvpn/options=2Eh
@@ -446,6 +446,8 @@
     const char *management=
_addr;
     const char *management_port;
     const char *management_user_p=
ass;
+    /** Script executed to talk to the management interface */
+    c=
onst char *management_script;
     int management_log_history_cache;
     i=
nt management_echo_buffer_size;
     int management_state_buffer_size;
@@ -=
761,7 +763,8 @@
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_P_RO=
UTE_TABLE     (1u << 31)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P=
_PULL_MODE | OPT_P_PEER_ID | 0x0ull))
+/* Options allowed in the normal con=
figuration file */
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MO=
DE | OPT_P_PEER_ID | 0x0ull)))
 
 #define PULL_DEFINED(opt) ((opt)->pull)
 =


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I307e64079f436a=
a782f7e24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
Gerrit-PatchSet: 2
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>

--uD1/sa2uAtE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Add unix-script functionality to the --management feature<br><br>=
This allows a script that handles management input/output to<br>be started =
alongside OpenVPN simpler in small deployments=2E<br><br>Change-Id: I307e64=
079f436aa782f7e24bfff665a545ad2fa0<br>Signed-off-by: Arne Schwabe &lt;arne@=
rfc2549=2Eorg&gt;<br>---<br>M doc/man-sections/management-options=2Erst<br>=
M doc/management-notes=2Etxt<br>M src/openvpn/init=2Ec<br>M src/openvpn/man=
age=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/options=2Ec<br>M src/o=
penvpn/options=2Eh<br>7 files changed, 100 insertions(+), 9 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/52/1852/2</pre><pre style=3D"font-family: monospace,monospac=
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
dex 66bae34=2E=2E101fa64 100644</span><br><span>--- a/src/openvpn/init=2Ec<=
/span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -4337,19 +433=
7,59 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+run_management_script(struct context *c)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifdef UNIX_SOCK_SUPPORT</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct argv =
argv =3D argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct env_set *env =3D env_set_create(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    setenv_str(env, &quot;MANAGEMENT_USER&quot;, management-=
&gt;settings=2Eup=2Eusername);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    setenv_str(env, &quot;MANAGEMENT_PASSWORD&quot;, management-=
&gt;settings=2Eup=2Epassword);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    setenv_str(env, &quot;MANAGEMENT_SOCKET&quot;, c-&gt;options=
=2Emanagement_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&a=
mp;argv, &quot;%s&quot;, c-&gt;options=2Emanagement_script);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int flags =3D S_NOWAITPID | S_SCRIPT | S_FATAL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int *pid =3D &amp=
;management-&gt;connection=2Eunix_script_pid;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *msg_prefix =3D &quot;WARNING: Fai=
led running management unix-script&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    *pid =3D openvpn_execve_check(&amp;argv, env, fla=
gs, msg_prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!openvpn_waitp=
id_check(*pid, msg_prefix, M_FATAL))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        *pid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    argv_free(&amp;argv);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL, &quot;ERROR: Manage=
ment unix-socket support is not available on this platform );</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> bool</span><br><span> open_management(struct c=
ontext *c)</span><br><span> {</span><br><span>     /* initialize management=
 layer */</span><br><span>     if (management)</span><br><span>     {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int flag=
s =3D c-&gt;options=2Emanagement_flags;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            /* This creates a file but o=
ur management codes deletes the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+             * file before opening a socket with the name */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;opti=
ons=2Emanagement_addr =3D platform_create_temp_file(</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                platform_get_tmp_dir(), &=
quot;omi&quot;, &amp;c-&gt;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>         if (c-&gt;options=2Emanagement_addr)</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       unsigned int flags =3D c-&gt;options=2Emanagement_flags;</span><br><=
span>             if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</span><br><s=
pan>             {</span><br><span>                 flags |=3D MF_SERVER;</=
span><br><span>             }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>             if (management_open(</span><br><spa=
n>                     management, c-&gt;options=2Emanagement_addr, c-&gt;o=
ptions=2Emanagement_port,</span><br><span>                     c-&gt;option=
s=2Emanagement_user_pass, c-&gt;options=2Emanagement_client_user,</span><br=
><span>@@ -4361,6 +4401,11 @@</span><br><span>                             =
         NULL);</span><br><span>             }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (flags &amp; MF=
_UNIX_SOCK_SCRIPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         run_management_script(c);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>             /* initial management hold, called e=
arly, before first context initialization */</span><br><span>             d=
o_hold(0);</span><br><span>             if (IS_SIG(c))</span><br><span>diff=
 --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>in=
dex 95ff246=2E=2Ebfc2aa2 100644</span><br><span>--- a/src/openvpn/manage=2E=
c</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -333,10 +=
333,12 @@</span><br><span> man_delete_unix_socket(struct management *man)</=
span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if ((man-&gt;settings=2Eflags &amp; =
(MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if ((man-&gt;settings=2Eflags &=
amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        || man-&gt;settings=2Ef=
lags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>     {</span><br><span>    =
     socket_delete_unix(&amp;man-&gt;settings=2Elocal_unix);</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> #endif</span><br><span> }</span><br><span> </span><br><span>@@ -2197=
,7 +2199,7 @@</span><br><span>             }</span><br><span>         }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (man-&gt;settings=2Eflags &amp; MF_CONNECT_AS_CLIENT)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;settings=2Eflags =
&amp; (MF_CONNECT_AS_CLIENT | MF_UNIX_SOCK_SCRIPT))</span><br><span>       =
  {</span><br><span>             msg(D_MANAGEMENT, &quot;MANAGEMENT: Trigge=
ring management exit&quot;);</span><br><span>             throw_signal_soft=
(SIGTERM, &quot;management-exit&quot;);</span><br><span>@@ -2644,6 +2646,15=
 @@</span><br><span>         {</span><br><span>             get_user_pass(&=
amp;ms-&gt;up, pass_file, &quot;Management&quot;, GET_USER_PASS_PASSWORD_ON=
LY);</span><br><span>         }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else if (ms-&gt;flags &amp; MF_UNIX_SOCK_SCRIPT)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            /* Set random password=
=2E The password is only</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+             * alphanumerical [0-9a-f] but still has 128 bit of random=
ness,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             *=
 which is more than enough */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            snprintf(ms-&gt;up=2Epassword, sizeof(ms-&gt;up=2Epas=
sword),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
         &quot;%&quot; PRIx64 &quot;%&quot; PRIx64, get_random(), get_rando=
m());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
-&gt;up=2Edefined =3D true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span> </span><br><span> #if UNIX_SOCK_SUPPORT<=
/span><br><span>         /*</span><br><span>@@ -2789,6 +2800,11 @@</span><b=
r><span>         man_close_socket(man, mc-&gt;sd_cli);</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (mc-&gt;unix_script_pid)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       kill(mc-&gt;unix_script_pid, SIGINT);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     command_line_free(mc-&gt;in);</span><br><s=
pan>     buffer_list_free(mc-&gt;out);</span><br><span> </span><br><span>di=
ff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>=
index 27d3b60=2E=2E71e88d0 100644</span><br><span>--- a/src/openvpn/manage=
=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -42,6 =
+42,7 @@</span><br><span> #define MF_EXTERNAL_CERT          (1u &lt;&lt; 15=
)</span><br><span> #define MF_EXTERNAL_KEY_PSSPAD    (1u &lt;&lt; 16)</span=
><br><span> #define MF_EXTERNAL_KEY_DIGEST    (1u &lt;&lt; 17)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define MF_UNIX_SOCK_SCRIPT     =
  (1u &lt;&lt; 18)</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEM=
ENT</span><br><span> </span><br><span>@@ -327,6 +328,9 @@</span><br><span> =
    int fdtosend;</span><br><span>     int lastfdreceived;</span><br><span>=
 #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef UNIX_=
SOCK_SUPPORT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pid=
_t unix_script_pid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span>     int client_version;</span><br><span> };</span><=
br><span> </span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openv=
pn/options=2Ec</span><br><span>index 9bd6f01=2E=2E4391434 100644</span><br>=
<span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/optio=
ns=2Ec</span><br><span>@@ -1739,7 +1739,7 @@</span><br><span>      * Check =
for consistency of management options</span><br><span>      */</span><br><s=
pan> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (!options-&gt;management_addr</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!options-&gt;management_addr &amp;&amp; !(=
options-&gt;management_flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>   =
      &amp;&amp; (options-&gt;management_flags</span><br><span>            =
 || options-&gt;management_log_history_cache !=3D defaults=2Emanagement_log=
_history_cache))</span><br><span>     {</span><br><span>@@ -4333,7 +4333,7 =
@@</span><br><span>     else if (streq(p[0], &quot;management&quot;) &amp;&=
amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><span>     {</span><b=
r><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (streq(p[2], &quot;unix&quot;))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (streq(p[2],=
 &quot;unix&quot;) || streq(p[2], &quot;unix-script&quot;))</span><br><span=
>         {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><span>        =
     options-&gt;management_flags |=3D MF_UNIX_SOCK;</span><br><span>@@ -43=
43,7 +4343,16 @@</span><br><span> #endif</span><br><span>         }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        opt=
ions-&gt;management_addr =3D p[1];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (streq(p[2], &quot;unix-script&quot;))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            options-&gt;management_flags=
 |=3D MF_UNIX_SOCK_SCRIPT | MF_HOLD;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            set_user_script(options, &amp;options-&gt;mana=
gement_script, p[1],</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                            &quot;management unix-script&quot;, false);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            options-&gt;management_addr =3D p[1];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span>         options-&gt;management_port =3D p[2];</span><br><span>     =
    if (p[3])</span><br><span>         {</span><br><span>diff --git a/src/o=
penvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index e93b05b=
=2E=2Ee92a5cd 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><b=
r><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -446,6 +446,8 @@</=
span><br><span>     const char *management_addr;</span><br><span>     const=
 char *management_port;</span><br><span>     const char *management_user_pa=
ss;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Script e=
xecuted to talk to the management interface */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *management_script;</span><br><sp=
an>     int management_log_history_cache;</span><br><span>     int manageme=
nt_echo_buffer_size;</span><br><span>     int management_state_buffer_size;=
</span><br><span>@@ -761,7 +763,8 @@</span><br><span> #define OPT_P_PUSH_MT=
U        (1u &lt;&lt; 30)</span><br><span> #define OPT_P_ROUTE_TABLE     (1=
u &lt;&lt; 31)</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_=
P_PEER_ID | 0x0ull))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* Options allowed in the normal configuration file */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE=
 | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull)))</span><br><span> </span><br>=
<span> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><span> </span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1852?usp=3Demail">change 1852</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I307e64079f436aa782f7e24=
bfff665a545ad2fa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1852 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--uD1/sa2uAtE=--


--===============8196491710106717984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8196491710106717984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8196491710106717984==--

