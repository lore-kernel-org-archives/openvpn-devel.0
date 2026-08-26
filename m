Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC77C5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j7rk2DjZH56IJWtjd5ZuNtGO75ev45sKwRVj785wnew=; b=b5cnilzwIUlY/WBIu5u64+32kN
	neboM5HwBKrpKCjdlzPrIcr/0LTTPxKqeePuyVX8RsNqGE47/3w1rTlY6UlEFuBW56mQY5t1bOQ1J
	Vv4qB2m6raqlp+luHq6TuT97ekaqASpL6PCkRN8njfPSu5VsrOMQ4PNJcHyIDvRPBcvE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzGht-0006mW-HS;
	Wed, 26 Aug 2026 16:42:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzGhq-0006m6-0C
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:42:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FT6unCjWthZqrmsN+WTmlC7lk814QoigfJdIH1zh5BU=; b=BaDxVoXLgDXRWcgUksR9EwiBVn
 Sxp0yEDWI2I476B+SfN+SFbBK0nfukCIoV/VP5ZU01nujSDvSl5BzBoUFUJUR6qZ0EQvTrmsk3q7m
 QZ0HgLY4zyPiHJT5xt6eLlrirHVdPDxLAR/PxjDqAByDgt5Vrj/SoNpTI36SfhUA13H0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FT6unCjWthZqrmsN+WTmlC7lk814QoigfJdIH1zh5BU=; b=j
 wj2Ajndmn51Ku30ZglJ+0B6OJqMzX6z5/4q3n5lY8Vp1AKDEdsIsHS2nPu4Nb+VoR/k7gYdYfAFgn
 KF4HXtVgqO0eSBbPgPWpV2Sb/u38D143Gra/T4LKvCVR64UnY/jQkkIB09jnsodiecwN3gQjBUNNr
 TQ7O2ofXI1lLcA48=;
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzGho-0001H8-O1 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:42:30 +0000
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so17651066b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787762542; x=1788367342; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FT6unCjWthZqrmsN+WTmlC7lk814QoigfJdIH1zh5BU=;
 b=I2Rwb+QrrxZ58/NrM65gXvC27zRG9NqmOoRs3XnPelrTruqP1xgzfR7hB+xQ/sMaZm
 68yfjIpTCaa+dR8Ezw8ecGQwTPc5fKHmJyo24awPhOWVjGY9xOKkXHchqe/aaKAgQU1S
 R9B1kb9Q/QaFcaf79e1XEYZCVpf6NxBs0IACsvyUSDlEPhTQ69jJQj+EdVE/dOw6CSuQ
 KfPmhVS1Uw3xY2fMDUQd78nWWjaBj3AkS5Iq8eTHkZRz7CNDuld+pj+b+RhEACjNgmmJ
 /vdWPFqmk4WGyRLcUq/ebNFcpyr8p08CtPmsua3ZP0FQzkX7JubGdUBf3Y6ZbcOgVSWw
 GVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762542; x=1788367342;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FT6unCjWthZqrmsN+WTmlC7lk814QoigfJdIH1zh5BU=;
 b=EGT5jQYh+XkBCj3iGPIJLxO/IGqjELtFz1wKMZOwULJ3ld8iFrhH+g+ZeWJvE1bI13
 CI6gOuozE3NuiUrp1D5h7k972OFu49w9v83Jypb7nQTDqNZfU0ooN4/jWFI0HJ0H5Q9o
 MDrasZpYGrVLTb6Knb2y5vwhPMGq6WgD8c/E2AwTL1avDZEzsnLxooJaG5VauDBADuNt
 BbF2RJWU4C+q/uvbmjSHAbede2I7Zq5CztxUcZP3KRVOERQV4R7ChAygBkgtoprAf1er
 fwSIqLxHvoAaCzloTMOrVN1qiPn0UDiZ20ADJqgEPI/amzcZQ0E1Sd6fZ2bX447FlEIH
 h8AA==
X-Gm-Message-State: AFuF++nR0fwQfspuuWd71piI/MnZtFvSYdJfzDkb3Ukx1MSEtSTjgko7
 mrjQSr22O4CDB7EmVrqvrOZad0I3IyHVjxhfsI/6I9W0jfui6L47x23ZKYDDDfikA+XfFm3a+SJ
 HkY42NApSgG0g2tocZAANVxDnZG9JDY2kt1233NBltIjn2J8KF3LTRs38F8MwXbVgM0GJ8fwwt+
 KYnZT5tg==
X-Gm-Gg: AR+sD12Frbbyjb2oqhCwMzISOkBgybsT3C/PSAKP3spYHupmc3Vi7XlEo7gR2j+l5bq
 gKGNn1X0omZ/VIzVvaQzEqqxFN0QDR+7rM/pZr/25LtLcxjqqSysOAdVuItJJrnCHK7kDY9NsLd
 FApMScSCN2kWXHzs26clDDhVHKunDe1IVgQmZ9LRG1EEKAmwbweIPAUFChDWZ73jNowcRZ+Ob1H
 afhW2XDqmMfYr+R/i3CGmw96klmj3SW9P67ewWAevcqmMckGg6NnAMfi5tkjqgaI5KlQTx/XvDJ
 b0PyXXUMFi7FbhBsUyclNCTgudkuatKi14CpL11caHLZCjHLpfMWWIMO8hZF+2civyMKaRKQafm
 DU7fPYtJ+HUeUqhdfCrpsnyQKMw7WKfrOB/Bef1nLMkfazKCuVnQh99XxRY5fnmZKSHJ8Nlma3G
 XZ5d4Lf1pViQTpyX2waxKy8x1xIoOsLe1hQ+gHplrFzjB/09tS8JhwNnl0lIfMHDDzOJToI5Jmm
 7IIXTgaKRSA+L8fk4lkkw/N71DNMN0dqyUAFeOZ/Tu4DYRSHCGLptNUjmkUiaCvo4MhO+9xPrb9
 gh3FMy+P2WeD7x0ooFIEu2/6ulEYqXjVStAu8cBQpLBlJOQWZKo=
X-Received: by 2002:a17:907:9612:b0:c15:a7b9:2ae1 with SMTP id
 a640c23a62f3a-c2535fc61dfmr37956366b.6.1787762541948; 
 Wed, 26 Aug 2026 09:42:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9ef996sm680029766b.62.2026.08.26.09.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:42:21 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 16:42:17 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 386745bb1cfd44aa8fb4ea450399fa64f206ec0d
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ad02262d7cf2ec394b5dd45e4a2dd161ea46cd71-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzGho-0001H8-O1
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
Content-Type: multipart/mixed; boundary="===============5134571176490178966=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5134571176490178966==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eXvaFijy9n0="; charset=UTF-8

--eXvaFijy9n0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1852?usp=3Demail

to look at the new patch set (#9=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Add unix-script functionality to the --ma=
nagement feature
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Add unix-script functionality to the --management feature

This allows=
 a script that handles management input/output to
be started alongside Open=
VPN simpler in small deployments=2E

Change-Id: I307e64079f436aa782f7e24bff=
f665a545ad2fa0
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M doc/m=
an-sections/management-options=2Erst
M doc/management-notes=2Etxt
M src/ope=
nvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openv=
pn/options=2Ec
M src/openvpn/options=2Eh
7 files changed, 117 insertions(+)=
, 11 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/52/1852/9

diff --git a/doc/man-sections/management-options=2Er=
st b/doc/man-sections/management-options=2Erst
index 8dad52b=2E=2Ee2e0773 1=
00644
--- a/doc/man-sections/management-options=2Erst
+++ b/doc/man-section=
s/management-options=2Erst
@@ -14,6 +14,7 @@
     management socket-name un=
ix pw-file  # (recommended)
     management IP port                   # (IN=
SECURE)
     management IP port pw-file           #
+    management script =
unix-script
 
   ``pw-file``, if specified, is a password file where the pa=
ssword must
   be on first line=2E Instead of a filename it can use the key=
word stdin
@@ -25,6 +26,14 @@
   ``--management-client-user`` and ``--manag=
ement-client-group``
   directives to restrict access=2E
 
+  When the vari=
ant :code:`unix-script` is used, OpenVPN will start the
+  specified script=
 on startup and enable ``--management-hold``=2E
+  OpenVPN will generate a =
random path for the unix socket
+  and management password=2E These are pas=
sed as environment
+  variables :code:`MANAGEMENT_SOCKET`, :code:`MANAGEMEN=
T_PASSWORD`
+  to the script when being started=2E When OpenVPN terminates =
it sends
+  a :code:`SIGINT` signal to the running script=2E
+
   The manag=
ement interface provides a special mode where the TCP
   management link ca=
n operate over the tunnel itself=2E To enable this mode,
   set IP to ``tun=
nel``=2E Tunnel mode will cause the management interface to
@@ -127,10 +136=
,11 @@
   (client-only)=2E
 
 --management-signal
-  Send SIGUSR1 signal to=
 OpenVPN if management session disconnects=2E This
-  is useful when you wi=
sh to disconnect an OpenVPN session on user logoff=2E
-  For ``--management=
-client`` this option is not needed since a disconnect
-  will always gener=
ate a :code:`SIGTERM`=2E
+  Send :code:`SIGUSR1` signal to OpenVPN if manag=
ement session disconnects=2E
+  This is useful when you wish to disconnect =
an OpenVPN session on user
+  logoff=2E For ``--management-client`` or ``--=
management`` with
+  :code:`unixscript` this option has no effect since a d=
isconnect will
+  always trigger sending a :code:`SIGTERM`=2E
 
 --manageme=
nt-up-down
   Report tunnel up/down events to management interface=2E
diff =
--git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt
index 11264=
68=2E=2Ed6b3fbb 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/managemen=
t-notes=2Etxt
@@ -35,6 +35,10 @@
 you can telnet to the management port (ma=
ke sure to use
 a telnet client which understands "raw" mode)=2E
 
+When pa=
ssword authentication is enabled, the management interface
+will require se=
nding the password on its own line after establishing
+the connection=2E
+
=
 Once connected to the management port, you can use
 the "help" command to =
list all commands=2E
 
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec
index a8e041d=2E=2E04220f4 100644
--- a/src/openvpn/init=2Ec
+++ b/src=
/openvpn/init=2Ec
@@ -4337,19 +4337,65 @@
     }
 }
 
+void
+run_management=
_script(struct context *c)
+{
+#if UNIX_SOCK_SUPPORT
+    struct gc_arena g=
c =3D gc_new();
+    struct argv argv =3D argv_new();
+    struct env_set *=
env =3D env_set_create(&gc);
+
+    setenv_str(env, "MANAGEMENT_USER", mana=
gement->settings=2Eup=2Eusername);
+    setenv_str(env, "MANAGEMENT_PASSWOR=
D", management->settings=2Eup=2Epassword);
+    setenv_str(env, "MANAGEMENT=
_SOCKET", c->options=2Emanagement_addr);
+
+    argv_printf(&argv, "%s", c-=
>options=2Emanagement_script);
+
+    int flags =3D S_NOWAITPID | S_SCRIPT =
| S_FATAL;
+    int *pid =3D &management->connection=2Eunix_script_pid;
+  =
  const char *msg_prefix =3D "WARNING: Failed running management unix-scrip=
t";
+    *pid =3D openvpn_execve_check(&argv, env, flags, msg_prefix);
+
+ =
   if (!openvpn_waitpid_check(*pid, msg_prefix, M_FATAL))
+    {
+        *=
pid =3D 0;
+    }
+
+    argv_free(&argv);
+    gc_free(&gc);
+#else
+    m=
sg(M_FATAL, "ERROR: Management unix-socket support is not available on this=
 platform");
+#endif
+}
+
 bool
 open_management(struct context *c)
 {
    =
 /* initialize management layer */
     if (management)
     {
+        uns=
igned int flags =3D c->options=2Emanagement_flags;
+        if (flags & MF_=
UNIX_SOCK_SCRIPT)
+        {
+            /* This creates a filename that s=
hould be ungessuable */
+            char sockname[32] =3D { 0 };
+        =
    snprintf(sockname, sizeof(sockname),
+                PACKAGE_NAME "_om=
i_%08" PRIx64 "%08" PRIx64 "=2Esock",
+                get_random(), get_ra=
ndom());
+
+            c->options=2Emanagement_addr  =3D platform_gen_path=
(platform_get_tmp_dir(), sockname, &c->gc);
+
+            c->options=2Eman=
agement_addr =3D platform_create_temp_file(
+                platform_get_t=
mp_dir(), "omi", &c->gc);
+        }
+
         if (c->options=2Emanagement=
_addr)
         {
-            unsigned int flags =3D c->options=2Emanageme=
nt_flags;
             if (c->options=2Emode =3D=3D MODE_SERVER)
          =
   {
                 flags |=3D MF_SERVER;
             }
+
             i=
f (management_open(
                     management, c->options=2Emanagemen=
t_addr, c->options=2Emanagement_port,
                     c->options=2Eman=
agement_user_pass, c->options=2Emanagement_client_user,
@@ -4361,6 +4407,11=
 @@
                                      NULL);
             }
 
+        =
    if (flags & MF_UNIX_SOCK_SCRIPT)
+            {
+                run_ma=
nagement_script(c);
+            }
+
             /* initial management hol=
d, called early, before first context initialization */
             do_hol=
d(0);
             if (IS_SIG(c))
diff --git a/src/openvpn/manage=2Ec b/src=
/openvpn/manage=2Ec
index 2b0a661=2E=2E29fdffc 100644
--- a/src/openvpn/man=
age=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -333,10 +333,12 @@
 man_delete_unix=
_socket(struct management *man)
 {
 #if UNIX_SOCK_SUPPORT
-    if ((man->se=
ttings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK=
)
+    if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =
=3D=3D MF_UNIX_SOCK
+        || man->settings=2Eflags & MF_UNIX_SOCK_SCRIPT=
)
     {
         socket_delete_unix(&man->settings=2Elocal_unix);
     }
+=

 #endif
 }
 
@@ -2197,10 +2199,18 @@
             }
         }
 
+        =
if (man->settings=2Eflags & MF_UNIX_SOCK_SCRIPT && !man_password_needed(man=
))
+        {
+            msg(D_MANAGEMENT, "MANAGEMENT: Triggering exit o=
n unix-script disconnect");
+            throw_signal_soft(SIGTERM, "manage=
ment-exit");
+        }
+
         if (man->settings=2Eflags & MF_CONNECT_A=
S_CLIENT)
         {
-            msg(D_MANAGEMENT, "MANAGEMENT: Triggering=
 management exit");
-            throw_signal_soft(SIGTERM, "management-exi=
t");
+            {
+                msg(D_MANAGEMENT, "MANAGEMENT: Trigger=
ing management exit");
+                throw_signal_soft(SIGTERM, "managem=
ent-exit");
+            }
         }
         else
         {
@@ -2644,6 +=
2654,15 @@
         {
             get_user_pass(&ms->up, pass_file, "Manag=
ement", GET_USER_PASS_PASSWORD_ONLY);
         }
+        else if (ms->flag=
s & MF_UNIX_SOCK_SCRIPT)
+        {
+            /* Set random password=2E =
The password is only
+             * alphanumerical [0-9a-f] but still has =
128 bit of randomness,
+             * which is more than enough */
+      =
      snprintf(ms->up=2Epassword, sizeof(ms->up=2Epassword),
+             =
        "%" PRIx64 "%" PRIx64, get_random(), get_random());
+            ms=
->up=2Edefined =3D true;
+        }
 
 #if UNIX_SOCK_SUPPORT
         /*
@@=
 -2789,6 +2808,13 @@
         man_close_socket(man, mc->sd_cli);
     }
 
+=
#if UNIX_SOCK_SUPPORT
+    if (mc->unix_script_pid)
+    {
+        kill(mc=
->unix_script_pid, SIGINT);
+    }
+#endif
+
     command_line_free(mc->in)=
;
     buffer_list_free(mc->out);
 
diff --git a/src/openvpn/manage=2Eh b/s=
rc/openvpn/manage=2Eh
index 27d3b60=2E=2Ef752fec 100644
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
+#if UNIX_SOCK_SUPPORT
+    pid_=
t unix_script_pid;
+#endif
     int client_version;
 };
 
diff --git a/src/=
openvpn/options=2Ec b/src/openvpn/options=2Ec
index 5f3f4e9=2E=2E1939c69 10=
0644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1720,7=
 +1720,7 @@
      * Check for consistency of management options
      */
 #=
ifdef ENABLE_MANAGEMENT
-    if (!options->management_addr
+    if (!option=
s->management_addr && !(options->management_flags & MF_UNIX_SOCK_SCRIPT)
  =
       && (options->management_flags
             || options->management_lo=
g_history_cache !=3D defaults=2Emanagement_log_history_cache))
     {
@@ -4=
301,7 +4301,7 @@
     else if (streq(p[0], "management") && p[1] && p[2] &&=
 !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (stre=
q(p[2], "unix"))
+        if (streq(p[2], "unix") || streq(p[2], "unix-scri=
pt"))
         {
 #if UNIX_SOCK_SUPPORT
             options->management_fl=
ags |=3D MF_UNIX_SOCK;
@@ -4311,7 +4311,16 @@
 #endif
         }
 
-       =
 options->management_addr =3D p[1];
+        if (streq(p[2], "unix-script")=
)
+        {
+            options->management_flags |=3D MF_UNIX_SOCK_SCRIP=
T | MF_HOLD;
+            set_user_script(options, &options->management_scr=
ipt, p[1],
+                            "management unix-script", false);
+=
        }
+        else
+        {
+            options->management_addr =
=3D p[1];
+        }
         options->management_port =3D p[2];
         i=
f (p[3])
         {
diff --git a/src/openvpn/options=2Eh b/src/openvpn/opti=
ons=2Eh
index f472676=2E=2E131513e 100644
--- a/src/openvpn/options=2Eh
+++=
 b/src/openvpn/options=2Eh
@@ -446,6 +446,8 @@
     const char *management_=
addr;
     const char *management_port;
     const char *management_user_pa=
ss;
+    /** Script executed to talk to the management interface */
+    co=
nst char *management_script;
     int management_log_history_cache;
     in=
t management_echo_buffer_size;
     int management_state_buffer_size;

-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I307e64079f436aa782f7e=
24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
Gerrit-PatchSet: 9
Gerrit-Ow=
ner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--eXvaFijy9n0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #9</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add unix-script functionality to the --management feature<br>=
<br>This allows a script that handles management input/output to<br>be star=
ted alongside OpenVPN simpler in small deployments=2E<br><br>Change-Id: I30=
7e64079f436aa782f7e24bfff665a545ad2fa0<br>Signed-off-by: Arne Schwabe &lt;a=
rne@rfc2549=2Eorg&gt;<br>---<br>M doc/man-sections/management-options=2Erst=
<br>M doc/management-notes=2Etxt<br>M src/openvpn/init=2Ec<br>M src/openvpn=
/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/options=2Ec<br>M s=
rc/openvpn/options=2Eh<br>7 files changed, 117 insertions(+), 11 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/52/1852/9</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/managem=
ent-options=2Erst b/doc/man-sections/management-options=2Erst</span><br><sp=
an>index 8dad52b=2E=2Ee2e0773 100644</span><br><span>--- a/doc/man-sections=
/management-options=2Erst</span><br><span>+++ b/doc/man-sections/management=
-options=2Erst</span><br><span>@@ -14,6 +14,7 @@</span><br><span>     manag=
ement socket-name unix pw-file  # (recommended)</span><br><span>     manage=
ment IP port                   # (INSECURE)</span><br><span>     management=
 IP port pw-file           #</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    management script unix-script</span><br><span> </span><br><spa=
n>   ``pw-file``, if specified, is a password file where the password must<=
/span><br><span>   be on first line=2E Instead of a filename it can use the=
 keyword stdin</span><br><span>@@ -25,6 +26,14 @@</span><br><span>   ``--ma=
nagement-client-user`` and ``--management-client-group``</span><br><span>  =
 directives to restrict access=2E</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  When the variant :code:`unix-script` is=
 used, OpenVPN will start the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  specified script on startup and enable ``--management-hold``=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN will gene=
rate a random path for the unix socket</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  and management password=2E These are passed as environ=
ment</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  variables :co=
de:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_PASSWORD`</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  to the script when being started=2E Whe=
n OpenVPN terminates it sends</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  a :code:`SIGINT` signal to the running script=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   The management=
 interface provides a special mode where the TCP</span><br><span>   managem=
ent link can operate over the tunnel itself=2E To enable this mode,</span><=
br><span>   set IP to ``tunnel``=2E Tunnel mode will cause the management i=
nterface to</span><br><span>@@ -127,10 +136,11 @@</span><br><span>   (clien=
t-only)=2E</span><br><span> </span><br><span> --management-signal</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  Send SIGUSR1 signal to OpenVP=
N if management session disconnects=2E This</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  is useful when you wish to disconnect an OpenVPN se=
ssion on user logoff=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  For ``--management-client`` this option is not needed since a disconnec=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  will always genera=
te a :code:`SIGTERM`=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  Send :code:`SIGUSR1` signal to OpenVPN if management session disconne=
cts=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This is use=
ful when you wish to disconnect an OpenVPN session on user</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  logoff=2E For ``--management-clien=
t`` or ``--management`` with</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  :code:`unixscript` this option has no effect since a disconnect =
will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  always trigge=
r sending a :code:`SIGTERM`=2E</span><br><span> </span><br><span> --managem=
ent-up-down</span><br><span>   Report tunnel up/down events to management i=
nterface=2E</span><br><span>diff --git a/doc/management-notes=2Etxt b/doc/m=
anagement-notes=2Etxt</span><br><span>index 1126468=2E=2Ed6b3fbb 100644</sp=
an><br><span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/man=
agement-notes=2Etxt</span><br><span>@@ -35,6 +35,10 @@</span><br><span> you=
 can telnet to the management port (make sure to use</span><br><span> a tel=
net client which understands &quot;raw&quot; mode)=2E</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+When password authentic=
ation is enabled, the management interface</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+will require sending the password on its own line af=
ter establishing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the=
 connection=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> Once connected to the management port, you can use</span><br><=
span> the &quot;help&quot; command to list all commands=2E</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec<=
/span><br><span>index a8e041d=2E=2E04220f4 100644</span><br><span>--- a/src=
/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><spa=
n>@@ -4337,19 +4337,65 @@</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+run_management_script(st=
ruct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct argv argv =3D argv_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct env_set *env =3D env_set_create(&amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    setenv_str(env, &quot;MANAGEMENT_USER&quot=
;, management-&gt;settings=2Eup=2Eusername);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    setenv_str(env, &quot;MANAGEMENT_PASSWORD&quot=
;, management-&gt;settings=2Eup=2Epassword);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    setenv_str(env, &quot;MANAGEMENT_SOCKET&quot;,=
 c-&gt;options=2Emanagement_addr);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
argv_printf(&amp;argv, &quot;%s&quot;, c-&gt;options=2Emanagement_script);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int flags =3D S_NOWAITPID | S_SCRIP=
T | S_FATAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 *pid =3D &amp;management-&gt;connection=2Eunix_script_pid;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const char *msg_prefix =3D &quo=
t;WARNING: Failed running management unix-script&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    *pid =3D openvpn_execve_check(&amp;=
argv, env, flags, msg_prefix);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!openvpn_waitpid_check(*pid, msg_prefix, M_FATAL))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        *pid =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_free(&a=
mp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL, &quot=
;ERROR: Management unix-socket support is not available on this platform&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> open_=
management(struct context *c)</span><br><span> {</span><br><span>     /* in=
itialize management layer */</span><br><span>     if (management)</span><br=
><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  unsigned int flags =3D c-&gt;options=2Emanagement_flags;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp; MF_UNIX_SOCK=
_SCRIPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* This c=
reates a filename that should be ungessuable */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            char sockname[32] =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            snprintf(sockn=
ame, sizeof(sockname),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                PACKAGE_NAME &quot;_omi_%08&quot; PRIx64 &quot;%08&quot;=
 PRIx64 &quot;=2Esock&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                get_random(), get_random());</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            c-&gt;options=2Emanagement_addr  =3D platform_ge=
n_path(platform_get_tmp_dir(), sockname, &amp;c-&gt;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            c-&gt;options=2Emanagement_addr =3D platform_=
create_temp_file(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              platform_get_tmp_dir(), &quot;omi&quot;, &amp;c-&gt;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (c-&g=
t;options=2Emanagement_addr)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            unsigned int flags =3D c-&gt;=
options=2Emanagement_flags;</span><br><span>             if (c-&gt;options=
=2Emode =3D=3D MODE_SERVER)</span><br><span>             {</span><br><span>=
                 flags |=3D MF_SERVER;</span><br><span>             }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>        =
     if (management_open(</span><br><span>                     management, =
c-&gt;options=2Emanagement_addr, c-&gt;options=2Emanagement_port,</span><br=
><span>                     c-&gt;options=2Emanagement_user_pass, c-&gt;opt=
ions=2Emanagement_client_user,</span><br><span>@@ -4361,6 +4407,11 @@</span=
><br><span>                                      NULL);</span><br><span>   =
          }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                run_management_script(c);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>        =
     /* initial management hold, called early, before first context initial=
ization */</span><br><span>             do_hold(0);</span><br><span>       =
      if (IS_SIG(c))</span><br><span>diff --git a/src/openvpn/manage=2Ec b/=
src/openvpn/manage=2Ec</span><br><span>index 2b0a661=2E=2E29fdffc 100644</s=
pan><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvp=
n/manage=2Ec</span><br><span>@@ -333,10 +333,12 @@</span><br><span> man_del=
ete_unix_socket(struct management *man)</span><br><span> {</span><br><span>=
 #if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIE=
NT)) =3D=3D MF_UNIX_SOCK)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS=
_CLIENT)) =3D=3D MF_UNIX_SOCK</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        || man-&gt;settings=2Eflags &amp; MF_UNIX_SOCK_SCRIPT)</s=
pan><br><span>     {</span><br><span>         socket_delete_unix(&amp;man-&=
gt;settings=2Elocal_unix);</span><br><span>     }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> #endif</span><br><span> }</=
span><br><span> </span><br><span>@@ -2197,10 +2199,18 @@</span><br><span>  =
           }</span><br><span>         }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;settings=2Eflags =
&amp; MF_UNIX_SOCK_SCRIPT &amp;&amp; !man_password_needed(man))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_MANAGEMENT, &quot;MANAG=
EMENT: Triggering exit on unix-script disconnect&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            throw_signal_soft(SIGTERM,=
 &quot;management-exit&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>         if (man-&gt;settings=2Eflags &amp; MF_CONNECT_AS=
_CLIENT)</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            msg(D_MANAGEMENT, &quot;MANAGEMENT: Triggering ma=
nagement exit&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            throw_signal_soft(SIGTERM, &quot;management-exit&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                msg(D_MANAGEMENT=
, &quot;MANAGEMENT: Triggering management exit&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                throw_signal_soft(SIGTER=
M, &quot;management-exit&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            }</span><br><span>         }</span><br><span>     =
    else</span><br><span>         {</span><br><span>@@ -2644,6 +2654,15 @@<=
/span><br><span>         {</span><br><span>             get_user_pass(&amp;=
ms-&gt;up, pass_file, &quot;Management&quot;, GET_USER_PASS_PASSWORD_ONLY);=
</span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        else if (ms-&gt;flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            /* Set random password=2E Th=
e password is only</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
            * alphanumerical [0-9a-f] but still has 128 bit of randomness,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * which=
 is more than enough */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            snprintf(ms-&gt;up=2Epassword, sizeof(ms-&gt;up=2Epassword)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
   &quot;%&quot; PRIx64 &quot;%&quot; PRIx64, get_random(), get_random());<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms-&gt;u=
p=2Edefined =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span> </span><br><span> #if UNIX_SOCK_SUPPORT</span>=
<br><span>         /*</span><br><span>@@ -2789,6 +2808,13 @@</span><br><spa=
n>         man_close_socket(man, mc-&gt;sd_cli);</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if U=
NIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (mc-&gt;unix_script_pid)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   kill(mc-&gt;unix_script_pid, SIGINT);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     command_line_free(mc-&gt;in);</span><br><span>     buffer_l=
ist_free(mc-&gt;out);</span><br><span> </span><br><span>diff --git a/src/op=
envpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 27d3b60=2E=
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
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>

</body></html>
--eXvaFijy9n0=--


--===============5134571176490178966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5134571176490178966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5134571176490178966==--

