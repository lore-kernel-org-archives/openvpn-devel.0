Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D5606A31D
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Br3bgNmj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kGKi4Nz8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kKDYKZL5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WNZr/oGw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RbXHJWSQuoS0PCCUBnlOOqUkcsX/VAtGCUBq0IbgmBA=; b=Br3bgNmjLPQQmeje+1hXsTgWNP
	AoNB+y6t3gIkwoY7ROBIHrFYDYUiGIXKWW/nrhlA7EojFyZn+vtl3XkR5eUC3ts+tA0fkEsgUnNWZ
	pfvybY776ua0KWLYxeISraZCmqPRQEdeEhw8v4X7A8z6ousjiaTU8UHFPJke7WaHEUJ4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLQah-000000005IS-1nEe;
	Mon, 26 Oct 2026 19:42:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLQaf-000000005IL-3UbL
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 19:42:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aRxqha2dzCo1entk6ZjuiL0iEKc9yt7nZ0yYSMRtJdA=; b=kGKi4Nz8TgnJmIRAcEeAgbksk1
 UGcyu9/M7BdnAD+FcKWzqZEJT6lxnyO/7IImRf4OUFszieUY9Ijh1v5oYlzvqk9VNubMYgLd3Ah2d
 z1MRhbAxUBpPLAmODL5egcAUrVzMwv3Pb9aECvMX1CaIE5rOOXBsbyeZueE2gg5VK7og=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aRxqha2dzCo1entk6ZjuiL0iEKc9yt7nZ0yYSMRtJdA=; b=kKDYKZL5izSNyRvfeuofH7njm/
 ITH0Tli7u2CGiTsdVh/jP1iN9g1H4E4TXKmIqsantvDPjcnGGeAGZVfwAyAaWCbp7ymGRJGwLV22W
 SWyiVILZhH9qdp18bcINibmuXcx29/mG+tPJqxzhVE9ZEGBiCH1y8yTB41DryLWXFYW0=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLQad-000000002Ev-2KRi for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 19:42:41 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso22455655e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793043753; x=1793648553; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aRxqha2dzCo1entk6ZjuiL0iEKc9yt7nZ0yYSMRtJdA=;
 b=WNZr/oGwSTvPq6ekUCBhLW+7LB68ktrDe8wpItUsAc4lzhFqfq6AaVDWwtC3qEA77n
 5VdZ+Eg5K5OhBA1nFWPh/VxDrX1qxXxxwJZuUUKc3yfJwRvfNYPrKb0hITXWZPWUSlbw
 TRwmg3fLwmCXIsWOiQlG9wL51XGzWrWmHu1nbQ1G5RrPrgK0mbQbsCmE8SxFIDQvVwk4
 b04x2TI5wA1DdHNITBL7ElxKPmiHdjyBhM5KpMTnSoNs/8dP3Q03RRN6258t9qnkkd8W
 xJelfzM2t0RjcZilkJQrQRBjdX7r0DPELfVUbm/HCApmkbf0f0tioU2t7tjtbVAD79Sp
 tGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793043753; x=1793648553;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aRxqha2dzCo1entk6ZjuiL0iEKc9yt7nZ0yYSMRtJdA=;
 b=oshubIdQzm0KI94lLywv01wInjNTjgFzTjBbtZLvw5xUp9WLhSGI2mg9icMNJVasEZ
 tmEzfwu6g1m0OidYKE/d7JbpW5IV+SO8OXjNPYpAUnNB6O2naMF0RW6maFZu0fBFeWjH
 qE9+BH5zk6CFEpd/VBKjoXE9SuBqX/+1c+qU61xCGLLDS7Xhow0qaaar8EGosh3bLfMn
 mklKFFPPK5Z7kCu7WQrQO88J0oXW51UKOdZF4NYOGaZo2C/TIQMGNn5m3IW2qth/XAEQ
 cgxWL/o7FKl0tJBDfw1ApPMDWO4y/LkamuYWzhX8a8qAMsIFO1XUXSgS7d5+gwXIPXmg
 LBZw==
X-Gm-Message-State: AFq9FYIrDe1pn+YhP++7K83f4KFGr74TyaYdqNt8vTcF9nGc7L6/UAuV
 iDsACae+cN7wqfy6j8SlA+11xh/dFx+mwwoLb5SbNdHdI8P4N9hMaoYp1eqI0e3K70xWh+KYC3e
 OCoGw/BbRc72VFm0DTYXkB4IH7SihxgwXJ+O1pvF6rkfCADQejOtNXyh+Mx7tVDcVbhrh
X-Gm-Gg: AYBFou0gMVA/VOYzof8TYaGnA668ds5JmulI4HPPeT3yVMlcE087x5dQEWMx6/0md5x
 VCle0nCoeuO65C3lvvwEBDDT8mtsKgPk3bT7CcN6UHWZ7zD38mEj5AKmrkL/Xig0UiZxHj8UxwV
 a6MBJ9IZuExZbHpqcpDP6cew5A270Pi/wEfgyOToG5GcjphcLT4Symowk7al0PTgKzkFc5OZO9a
 p6PI0C9e2DulQl4tF8wjGpUD08k4YBvhY7bAtP0IKAX3YsLHfzBNF99pXoSi67Xo5GsOvh/EjlD
 860rNh0xtf+7ikmaIpLSCMzUmAW4FlzXypMB+UH3RJfu/PI4jthKQvuEKvDDAce11s0BJqRq3en
 6k6ARpghM0E31M6OpX4FQzRQq8fDqVl9UH8QdJ41po0ZdT40mMcSYfmljVP3vXDl700Qdv1hf1E
 wZLXEiLU6utm9DAKKiWAV1TG6Ps1LinMMMA4pg1tO3uwg9Y4DggWJgsX0VrN1t1OEbbcve+2IPJ
 zzRxSb50fMMaxnITqco/2hRWraDPduHxkP2XeNBdMJdflJaAUYoqGZbzCll3BkaO8+/z6lVxCRz
 /ur6xCp4icX7AaY9kbYPZDtS42JO0q+bJZ8fCGlbkY4oe8ZD+bEbKnBq6gnKHzInMHtrMJwOr3u
 Jlb9/1ebqsmcY7MYVzJ9MX690MNQAAi0nDapAdJkqnA==
X-Received: by 2002:a05:600c:4ece:b0:4a1:6517:ccf1 with SMTP id
 5b1f17b1804b1-4a35ac9d116mr149357615e9.9.1793043752798; 
 Mon, 26 Oct 2026 12:42:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a55e9aasm219524695e9.5.2026.10.26.12.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:42:32 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 19:42:27 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: df84479e5f7f3b06ab7bdf476664fa61c7c881ab
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a0610495f299e06ef63056b851ef3c58ed1da1e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLQad-000000002Ev-2KRi
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0027018854388837591=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0027018854388837591==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X/rthqkPeHo="; charset=UTF-8

--X/rthqkPeHo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd l=
ike you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1852?usp=3Demail

to look at the new patch set (#14)=2E
=

The following approvals got outdated and were removed:
Code-Review-1 by R=
=C4=83zvan Cojocaru


Change subject: Add unix-script functionality to the =
--management feature
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Add unix-script functionality to the --management feature

This all=
ows a script that handles management input/output to
be started alongside O=
penVPN simpler in small deployments=2E

Change-Id: I307e64079f436aa782f7e24=
bfff665a545ad2fa0
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M do=
c/man-sections/management-options=2Erst
M doc/management-notes=2Etxt
M src/=
openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/op=
envpn/options=2Ec
M src/openvpn/options=2Eh
7 files changed, 127 insertions=
(+), 11 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/52/1852/14

diff --git a/doc/man-sections/management-options=
=2Erst b/doc/man-sections/management-options=2Erst
index 8dad52b=2E=2Ee2e07=
73 100644
--- a/doc/man-sections/management-options=2Erst
+++ b/doc/man-sec=
tions/management-options=2Erst
@@ -14,6 +14,7 @@
     management socket-nam=
e unix pw-file  # (recommended)
     management IP port                   #=
 (INSECURE)
     management IP port pw-file           #
+    management scr=
ipt unix-script
 
   ``pw-file``, if specified, is a password file where th=
e password must
   be on first line=2E Instead of a filename it can use the=
 keyword stdin
@@ -25,6 +26,14 @@
   ``--management-client-user`` and ``--m=
anagement-client-group``
   directives to restrict access=2E
 
+  When the =
variant :code:`unix-script` is used, OpenVPN will start the
+  specified sc=
ript on startup and enable ``--management-hold``=2E
+  OpenVPN will generat=
e a random path for the unix socket
+  and management password=2E These are=
 passed as environment
+  variables :code:`MANAGEMENT_SOCKET`, :code:`MANAG=
EMENT_PASSWORD`
+  to the script when being started=2E When OpenVPN termina=
tes it sends
+  a :code:`SIGINT` signal to the running script=2E
+
   The m=
anagement interface provides a special mode where the TCP
   management lin=
k can operate over the tunnel itself=2E To enable this mode,
   set IP to `=
`tunnel``=2E Tunnel mode will cause the management interface to
@@ -127,10 =
+136,11 @@
   (client-only)=2E
 
 --management-signal
-  Send SIGUSR1 signa=
l to OpenVPN if management session disconnects=2E This
-  is useful when yo=
u wish to disconnect an OpenVPN session on user logoff=2E
-  For ``--manage=
ment-client`` this option is not needed since a disconnect
-  will always g=
enerate a :code:`SIGTERM`=2E
+  Send :code:`SIGUSR1` signal to OpenVPN if m=
anagement session disconnects=2E
+  This is useful when you wish to disconn=
ect an OpenVPN session on user
+  logoff=2E For ``--management-client`` or =
``--management`` with
+  :code:`unixscript` this option has no effect since=
 a disconnect will
+  always trigger sending a :code:`SIGTERM`=2E
 
 --mana=
gement-up-down
   Report tunnel up/down events to management interface=2E
d=
iff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt
index a=
28a1a8=2E=2E4d726c4 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/manag=
ement-notes=2Etxt
@@ -35,6 +35,10 @@
 you can telnet to the management port=
 (make sure to use
 a telnet client which understands "raw" mode)=2E
 
+Whe=
n password authentication is enabled, the management interface
+will requir=
e sending the password on its own line after establishing
+the connection=
=2E
+
 Once connected to the management port, you can use
 the "help" comma=
nd to list all commands=2E
 
diff --git a/src/openvpn/init=2Ec b/src/openvp=
n/init=2Ec
index 24cf532=2E=2Ebd890e5 100644
--- a/src/openvpn/init=2Ec
+++=
 b/src/openvpn/init=2Ec
@@ -4343,19 +4343,61 @@
     }
 }
 
+static void
+r=
un_management_script(const struct context *c)
+{
+#if UNIX_SOCK_SUPPORT
+  =
  struct gc_arena gc =3D gc_new();
+    struct argv argv =3D argv_new();
+ =
   struct env_set *env =3D env_set_create(&gc);
+
+    setenv_str(env, "MAN=
AGEMENT_PASSWORD", management->settings=2Eup=2Epassword);
+    setenv_str(e=
nv, "MANAGEMENT_SOCKET", c->options=2Emanagement_addr);
+
+    argv_printf(=
&argv, "%s", c->options=2Emanagement_script);
+
+    int flags =3D S_NOWAIT=
PID | S_SCRIPT | S_FATAL;
+    int *pid =3D &management->connection=2Eunix_=
script_pid;
+    const char *msg_prefix =3D "ERROR: Failed running manageme=
nt unix-script";
+    *pid =3D openvpn_execve_check(&argv, env, flags, msg_=
prefix);
+
+    if (!openvpn_waitpid_check(*pid, msg_prefix, M_FATAL))
+   =
 {
+        *pid =3D 0;
+    }
+
+    argv_free(&argv);
+    gc_free(&gc);
=
+#else
+    msg(M_FATAL, "ERROR: Management unix-socket support is not avai=
lable on this platform");
+#endif
+}
+
 bool
 open_management(struct contex=
t *c)
 {
     /* initialize management layer */
     if (management)
     {=

+        unsigned int flags =3D c->options=2Emanagement_flags;
+        if=
 (flags & MF_UNIX_SOCK_SCRIPT)
+        {
+            /* This creates a fi=
lename that should be unguessable */
+            char sockname[64] =3D { 0=
 };
+            snprintf(sockname, sizeof(sockname),
+                    =
 PACKAGE_NAME "_omi_%08" PRIx64 "%08" PRIx64 "=2Esock",
+                  =
   get_random(), get_random());
+
+            c->options=2Emanagement_addr=
 =3D platform_gen_path(c->options=2Etmp_dir, sockname, &c->gc);
+        }
=
+
         if (c->options=2Emanagement_addr)
         {
-            unsign=
ed int flags =3D c->options=2Emanagement_flags;
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
@@ -4367,6 +4409,11 @@
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
index 0fc9ee2=2E=
=2Eccf66b43 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2E=
c
@@ -47,6 +47,7 @@
 #include "resolve=2Eh"
 
 #include "memdbg=2Eh"
+#incl=
ude "run_command=2Eh"
 
 #ifdef ENABLE_PKCS11
 #include "pkcs11=2Eh"
@@ -33=
4,10 +335,12 @@
 man_delete_unix_socket(const struct management *man)
 {
 #=
if UNIX_SOCK_SUPPORT
-    if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_C=
ONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
+    if ((man->settings=2Eflags & (=
MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK
+        || man->=
settings=2Eflags & MF_UNIX_SOCK_SCRIPT)
     {
         socket_delete_unix(=
&man->settings=2Elocal_unix);
     }
+
 #endif
 }
 
@@ -2196,10 +2199,18 @@=

             }
         }
 
+        if (man->settings=2Eflags & MF_UNIX_S=
OCK_SCRIPT && !man_password_needed(man))
+        {
+            msg(D_MANA=
GEMENT, "MANAGEMENT: Triggering exit on unix-script disconnect");
+        =
    throw_signal_soft(SIGTERM, "management-exit");
+        }
+
         if=
 (man->settings=2Eflags & MF_CONNECT_AS_CLIENT)
         {
-            msg=
(D_MANAGEMENT, "MANAGEMENT: Triggering management exit");
-            thro=
w_signal_soft(SIGTERM, "management-exit");
+            {
+                =
msg(D_MANAGEMENT, "MANAGEMENT: Triggering management exit");
+             =
   throw_signal_soft(SIGTERM, "management-exit");
+            }
         }=

         else
         {
@@ -2644,6 +2655,15 @@
         {
             ge=
t_user_pass(&ms->up, pass_file, "Management", GET_USER_PASS_PASSWORD_ONLY);=

         }
+        else if (ms->flags & MF_UNIX_SOCK_SCRIPT)
+        {
+=
            /* Set random password=2E The password is only
+             * =
alphanumerical [0-9a-f] but still has 128 bit of randomness,
+             =
* which is more than enough */
+            snprintf(ms->up=2Epassword, siz=
eof(ms->up=2Epassword),
+                     "%" PRIx64 "%" PRIx64, get_ra=
ndom(), get_random());
+            ms->up=2Edefined =3D true;
+        }
 =

 #if UNIX_SOCK_SUPPORT
         /*
@@ -2789,6 +2809,13 @@
         man_clo=
se_socket(man, mc->sd_cli);
     }
 
+#if UNIX_SOCK_SUPPORT
+    if (mc->un=
ix_script_pid)
+    {
+        kill(mc->unix_script_pid, SIGINT);
+    }
+#=
endif
+
     command_line_free(mc->in);
     buffer_list_free(mc->out);
 
@=
@ -3448,6 +3475,19 @@
                 break;
             }
 
+#if UNIX_SO=
CK_SUPPORT
+            /* if unix-script is in use, the script might have =
exited
+             * while we are waiting for it to connect */
+         =
   const char *msg_prefix =3D "ERROR: Failed running management unix-script=
";
+
+            if (man->connection=2Eunix_script_pid
+                &&=
 !openvpn_waitpid_check(man->connection=2Eunix_script_pid, msg_prefix, M_FA=
TAL))
+            {
+                status =3D -1;
+                break=
;
+            }
+#endif
+
             if (status > 0)
             {
    =
             break;
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manag=
e=2Eh
index f2c6916=2E=2E157039d 100644
--- a/src/openvpn/manage=2Eh
+++ b/=
src/openvpn/manage=2Eh
@@ -42,6 +42,7 @@
 #define MF_EXTERNAL_CERT         =
 (1u << 15)
 #define MF_EXTERNAL_KEY_PSSPAD    (1u << 16)
 #define MF_EXTER=
NAL_KEY_DIGEST    (1u << 17)
+#define MF_UNIX_SOCK_SCRIPT       (1u << 18)
=
 
 #ifdef ENABLE_MANAGEMENT
 
@@ -327,6 +328,9 @@
     int fdtosend;
     i=
nt lastfdreceived;
 #endif
+#if UNIX_SOCK_SUPPORT
+    pid_t unix_script_pi=
d;
+#endif
     int client_version;
 };
 
diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec
index 8e0c602=2E=2Efb319ae 100644
--- a/src/=
openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1700,7 +1700,7 @@
   =
   * Check for consistency of management options
      */
 #ifdef ENABLE_MA=
NAGEMENT
-    if (!options->management_addr
+    if (!options->management_a=
ddr && !(options->management_flags & MF_UNIX_SOCK_SCRIPT)
         && (opti=
ons->management_flags
             || options->management_log_history_cache=
 !=3D defaults=2Emanagement_log_history_cache))
     {
@@ -4285,7 +4285,7 @=
@
     else if (streq(p[0], "management") && p[1] && p[2] && !p[4])
     {
=
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (streq(p[2], "unix")=
)
+        if (streq(p[2], "unix") || streq(p[2], "unix-script"))
         =
{
 #if UNIX_SOCK_SUPPORT
             options->management_flags |=3D MF_UNI=
X_SOCK;
@@ -4295,7 +4295,16 @@
 #endif
         }
 
-        options->manag=
ement_addr =3D p[1];
+        if (streq(p[2], "unix-script"))
+        {
+ =
           options->management_flags |=3D MF_UNIX_SOCK_SCRIPT | MF_HOLD;
+ =
           set_user_script(options, &options->management_script, p[1],
+   =
                         "management unix-script", false);
+        }
+    =
    else
+        {
+            options->management_addr =3D p[1];
+      =
  }
         options->management_port =3D p[2];
         if (p[3])
        =
 {
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index c58=
530a=2E=2E6a3bf61 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/op=
tions=2Eh
@@ -446,6 +446,8 @@
     const char *management_addr;
     const =
char *management_port;
     const char *management_user_pass;
+    /** Scri=
pt executed to talk to the management interface */
+    const char *managem=
ent_script;
     int management_log_history_cache;
     int management_echo=
_buffer_size;
     int management_state_buffer_size;

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad=
2fa0
Gerrit-Change-Number: 1852
Gerrit-PatchSet: 14
Gerrit-Owner: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>

--X/rthqkPeHo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #14</strong> to this ch=
ange=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?us=
p=3Demail">View Change</a></p><p>The following approvals got outdated and w=
ere removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Add uni=
x-script functionality to the --management feature<br><br>This allows a scr=
ipt that handles management input/output to<br>be started alongside OpenVPN=
 simpler in small deployments=2E<br><br>Change-Id: I307e64079f436aa782f7e24=
bfff665a545ad2fa0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;=
<br>---<br>M doc/man-sections/management-options=2Erst<br>M doc/management-=
notes=2Etxt<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/=
openvpn/manage=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2E=
h<br>7 files changed, 127 insertions(+), 11 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/5=
2/1852/14</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/doc/man-sections/management-options=2Erst b/=
doc/man-sections/management-options=2Erst</span><br><span>index 8dad52b=2E=
=2Ee2e0773 100644</span><br><span>--- a/doc/man-sections/management-options=
=2Erst</span><br><span>+++ b/doc/man-sections/management-options=2Erst</spa=
n><br><span>@@ -14,6 +14,7 @@</span><br><span>     management socket-name u=
nix pw-file  # (recommended)</span><br><span>     management IP port       =
            # (INSECURE)</span><br><span>     management IP port pw-file   =
        #</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    manage=
ment script unix-script</span><br><span> </span><br><span>   ``pw-file``, i=
f specified, is a password file where the password must</span><br><span>   =
be on first line=2E Instead of a filename it can use the keyword stdin</spa=
n><br><span>@@ -25,6 +26,14 @@</span><br><span>   ``--management-client-use=
r`` and ``--management-client-group``</span><br><span>   directives to rest=
rict access=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  When the variant :code:`unix-script` is used, OpenVPN will s=
tart the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  specified=
 script on startup and enable ``--management-hold``=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  OpenVPN will generate a random path fo=
r the unix socket</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
and management password=2E These are passed as environment</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  variables :code:`MANAGEMENT_SOCKET=
`, :code:`MANAGEMENT_PASSWORD`</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  to the script when being started=2E When OpenVPN terminates it=
 sends</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a :code:`SI=
GINT` signal to the running script=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>   The management interface provides a s=
pecial mode where the TCP</span><br><span>   management link can operate ov=
er the tunnel itself=2E To enable this mode,</span><br><span>   set IP to `=
`tunnel``=2E Tunnel mode will cause the management interface to</span><br><=
span>@@ -127,10 +136,11 @@</span><br><span>   (client-only)=2E</span><br><s=
pan> </span><br><span> --management-signal</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  Send SIGUSR1 signal to OpenVPN if management session=
 disconnects=2E This</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 is useful when you wish to disconnect an OpenVPN session on user logoff=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  For ``--management-=
client`` this option is not needed since a disconnect</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  will always generate a :code:`SIGTERM`=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Send :code:`SIGUS=
R1` signal to OpenVPN if management session disconnects=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  This is useful when you wish to di=
sconnect an OpenVPN session on user</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  logoff=2E For ``--management-client`` or ``--management``=
 with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`unixs=
cript` this option has no effect since a disconnect will</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  always trigger sending a :code:`SIGT=
ERM`=2E</span><br><span> </span><br><span> --management-up-down</span><br><=
span>   Report tunnel up/down events to management interface=2E</span><br><=
span>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</=
span><br><span>index a28a1a8=2E=2E4d726c4 100644</span><br><span>--- a/doc/=
management-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</sp=
an><br><span>@@ -35,6 +35,10 @@</span><br><span> you can telnet to the mana=
gement port (make sure to use</span><br><span> a telnet client which unders=
tands &quot;raw&quot; mode)=2E</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+When password authentication is enabled, the m=
anagement interface</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
will require sending the password on its own line after establishing</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+the connection=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Once conne=
cted to the management port, you can use</span><br><span> the &quot;help&qu=
ot; command to list all commands=2E</span><br><span> </span><br><span>diff =
--git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 2=
4cf532=2E=2Ebd890e5 100644</span><br><span>--- a/src/openvpn/init=2Ec</span=
><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -4343,19 +4343,61 =
@@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+run_management_script(const struct conte=
xt *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct a=
rgv argv =3D argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct env_set *env =3D env_set_create(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    setenv_str(env, &quot;MANAGEMENT_PASSWORD&quot;, man=
agement-&gt;settings=2Eup=2Epassword);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    setenv_str(env, &quot;MANAGEMENT_SOCKET&quot;, c-&gt=
;options=2Emanagement_addr);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_p=
rintf(&amp;argv, &quot;%s&quot;, c-&gt;options=2Emanagement_script);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int flags =3D S_NOWAITPID | S_SCRIPT | S_=
FATAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int *pid =
=3D &amp;management-&gt;connection=2Eunix_script_pid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *msg_prefix =3D &quot;ERRO=
R: Failed running management unix-script&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    *pid =3D openvpn_execve_check(&amp;argv, en=
v, flags, msg_prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!openvpn=
_waitpid_check(*pid, msg_prefix, M_FATAL))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        *pid =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_free(&amp;argv)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL, &quot;ERROR: =
Management unix-socket support is not available on this platform&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> open_manageme=
nt(struct context *c)</span><br><span> {</span><br><span>     /* initialize=
 management layer */</span><br><span>     if (management)</span><br><span> =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsign=
ed int flags =3D c-&gt;options=2Emanagement_flags;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (flags &amp; MF_UNIX_SOCK_SCRIPT)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            /* This creates a=
 filename that should be unguessable */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            char sockname[64] =3D { 0 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            snprintf(sockname, siz=
eof(sockname),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                PACKAGE_NAME &quot;_omi_%08&quot; PRIx64 &quot;%08&quot; PR=
Ix64 &quot;=2Esock&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                     get_random(), get_random());</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            c-&gt;options=2Emanagement_addr =3D platform_g=
en_path(c-&gt;options=2Etmp_dir, sockname, &amp;c-&gt;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>         if (c-&gt;options=2E=
management_addr)</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            unsigned int flags =3D c-&gt;options=2Ema=
nagement_flags;</span><br><span>             if (c-&gt;options=2Emode =3D=
=3D MODE_SERVER)</span><br><span>             {</span><br><span>           =
      flags |=3D MF_SERVER;</span><br><span>             }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             if (ma=
nagement_open(</span><br><span>                     management, c-&gt;optio=
ns=2Emanagement_addr, c-&gt;options=2Emanagement_port,</span><br><span>    =
                 c-&gt;options=2Emanagement_user_pass, c-&gt;options=2Emana=
gement_client_user,</span><br><span>@@ -4367,6 +4409,11 @@</span><br><span>=
                                      NULL);</span><br><span>             }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                run_management_script(c);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             /* init=
ial management hold, called early, before first context initialization */</=
span><br><span>             do_hold(0);</span><br><span>             if (IS=
_SIG(c))</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/=
manage=2Ec</span><br><span>index 0fc9ee2=2E=2Eccf66b43 100644</span><br><sp=
an>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2E=
c</span><br><span>@@ -47,6 +47,7 @@</span><br><span> #include &quot;resolve=
=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ru=
n_command=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENABLE_PKCS11=
</span><br><span> #include &quot;pkcs11=2Eh&quot;</span><br><span>@@ -334,1=
0 +335,12 @@</span><br><span> man_delete_unix_socket(const struct managemen=
t *man)</span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if ((man-&gt;settings=2Efla=
gs &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((man-&gt;settings=
=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || man-&gt;se=
ttings=2Eflags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>     {</span><br>=
<span>         socket_delete_unix(&amp;man-&gt;settings=2Elocal_unix);</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> #endif</span><br><span> }</span><br><span> </span><br><spa=
n>@@ -2196,10 +2199,18 @@</span><br><span>             }</span><br><span>  =
       }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (man-&gt;settings=2Eflags &amp; MF_UNIX_SOCK_SCRIPT &amp;=
&amp; !man_password_needed(man))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(D_MANAGEMENT, &quot;MANAGEMENT: Triggering exit on unix-=
script disconnect&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            throw_signal_soft(SIGTERM, &quot;management-exit&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (=
man-&gt;settings=2Eflags &amp; MF_CONNECT_AS_CLIENT)</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D=
_MANAGEMENT, &quot;MANAGEMENT: Triggering management exit&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            throw_signal_soft(S=
IGTERM, &quot;management-exit&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                msg(D_MANAGEMENT, &quot;MANAGEMENT: Triggering =
management exit&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                throw_signal_soft(SIGTERM, &quot;management-exit&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span>         }</span><br><span>         else</span><br><span>      =
   {</span><br><span>@@ -2644,6 +2655,15 @@</span><br><span>         {</spa=
n><br><span>             get_user_pass(&amp;ms-&gt;up, pass_file, &quot;Man=
agement&quot;, GET_USER_PASS_PASSWORD_ONLY);</span><br><span>         }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (ms-&gt=
;flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            /* Set random password=2E The password is only</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+             * alphanumerical [0=
-9a-f] but still has 128 bit of randomness,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+             * which is more than enough */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            snprintf(ms-&gt=
;up=2Epassword, sizeof(ms-&gt;up=2Epassword),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     &quot;%&quot; PRIx64 &quot;%=
&quot; PRIx64, get_random(), get_random());</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            ms-&gt;up=2Edefined =3D true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> </=
span><br><span> #if UNIX_SOCK_SUPPORT</span><br><span>         /*</span><br=
><span>@@ -2789,6 +2809,13 @@</span><br><span>         man_close_socket(man=
, mc-&gt;sd_cli);</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (mc-&gt;unix_script_pid)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        kill(mc-&gt;unix_script_pid,=
 SIGINT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     command_line_fr=
ee(mc-&gt;in);</span><br><span>     buffer_list_free(mc-&gt;out);</span><br=
><span> </span><br><span>@@ -3448,6 +3475,19 @@</span><br><span>           =
      break;</span><br><span>             }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            /* if unix-script i=
s in use, the script might have exited</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             * while we are waiting for it to connect */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const c=
har *msg_prefix =3D &quot;ERROR: Failed running management unix-script&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;connection=
=2Eunix_script_pid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               &amp;&amp; !openvpn_waitpid_check(man-&gt;connection=2Eunix_=
script_pid, msg_prefix, M_FATAL))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                status =3D -1;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                break;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>             if (status &gt; 0)</span><br><span>       =
      {</span><br><span>                 break;</span><br><span>diff --git =
a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>index f2c=
6916=2E=2E157039d 100644</span><br><span>--- a/src/openvpn/manage=2Eh</span=
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
=2Ec</span><br><span>index 8e0c602=2E=2Efb319ae 100644</span><br><span>--- =
a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</sp=
an><br><span>@@ -1700,7 +1700,7 @@</span><br><span>      * Check for consis=
tency of management options</span><br><span>      */</span><br><span> #ifde=
f ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (!options-&gt;management_addr</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!options-&gt;management_addr &amp;&amp; !(options-&g=
t;management_flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>         &amp=
;&amp; (options-&gt;management_flags</span><br><span>             || option=
s-&gt;management_log_history_cache !=3D defaults=2Emanagement_log_history_c=
ache))</span><br><span>     {</span><br><span>@@ -4285,7 +4285,7 @@</span><=
br><span>     else if (streq(p[0], &quot;management&quot;) &amp;&amp; p[1] =
&amp;&amp; p[2] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>  =
       VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (streq(p[2], &quot;unix&quot;))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (streq(p[2], &quot;uni=
x&quot;) || streq(p[2], &quot;unix-script&quot;))</span><br><span>         =
{</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><span>             optio=
ns-&gt;management_flags |=3D MF_UNIX_SOCK;</span><br><span>@@ -4295,7 +4295=
,16 @@</span><br><span> #endif</span><br><span>         }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;m=
anagement_addr =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (streq(p[2], &quot;unix-script&quot;))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            options-&gt;management_flags |=3D MF_U=
NIX_SOCK_SCRIPT | MF_HOLD;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            set_user_script(options, &amp;options-&gt;management_scr=
ipt, p[1],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                   &quot;management unix-script&quot;, false);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            options-&gt;management_addr =3D p[1];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>  =
       options-&gt;management_port =3D p[2];</span><br><span>         if (p=
[3])</span><br><span>         {</span><br><span>diff --git a/src/openvpn/op=
tions=2Eh b/src/openvpn/options=2Eh</span><br><span>index c58530a=2E=2E6a3b=
f61 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>++=
+ b/src/openvpn/options=2Eh</span><br><span>@@ -446,6 +446,8 @@</span><br><=
span>     const char *management_addr;</span><br><span>     const char *man=
agement_port;</span><br><span>     const char *management_user_pass;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Script executed to=
 talk to the management interface */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const char *management_script;</span><br><span>     in=
t management_log_history_cache;</span><br><span>     int management_echo_bu=
ffer_size;</span><br><span>     int management_state_buffer_size;</span><br=
></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1852?usp=3Demail">change 1852</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1852?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1852 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>

</body></html>
--X/rthqkPeHo=--


--===============0027018854388837591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0027018854388837591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0027018854388837591==--

