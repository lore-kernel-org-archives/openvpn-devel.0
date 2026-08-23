Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CAEC5DF81
	for <openvpn-devel@archiver.kernel.org>; Sun, 23 Aug 2026 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E1TcVlhMzPOUrh4v1pYBGZNm3vA42+E9FoErIAOxRX4=; b=OGhtCtkS2jsXpbqXU7BXxl8YXu
	OGj0ypUYUQpFAt5Q3NbN7hcjQ+5z3An1qNUYHvXGAXAQLSsu0ICctVCcbm0MzMzFdP0IzC8N7IGqB
	OttuGVe5dGuop63nJhO69ipxw1p1WBrzVlgKVoq5+wZZJ1wccQoJvzDxIOiNnJ7YDeC4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyAlm-00088H-EK;
	Sun, 23 Aug 2026 16:09:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyAll-00088A-4T
 for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 16:09:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TqtAr9QcKUQShr1qp9wFceDesghN16Z09/GsWYoco/M=; b=eUajaKOxHpz74VDSWOdPpfU6h/
 P1gRBKlqamM1wxpfVvfgvdircbab3sGMsqEpLgETaEVjNpgxaRodV4ijNERqtSm5N0rycIUFE9p5W
 +dM2tNwEHc7rqbIaDnB4lxyF3kdSLQhl0B3T3FPn3lcmUeB1PA7uRWjLebs0O9BRUQ9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TqtAr9QcKUQShr1qp9wFceDesghN16Z09/GsWYoco/M=; b=H
 xlFKCfHJzqRsGgwabwTC7J9hETIY2WxbaQsdRHAi1E14a5Snyf3MphGl2HqV8mfZi1Uw44wosMCjk
 TxkEIWXtlHhhMkm6QyrwtZeHw+BlaZgOy/6KzpSnWmscp4bW+swMPjNgOriDbEMtLbIajXrg828Iz
 AXgwvDU5n3GDzn+U=;
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyAlg-0000Ah-OT for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 16:09:58 +0000
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c1c52d920b8so376653666b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787501390; x=1788106190; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TqtAr9QcKUQShr1qp9wFceDesghN16Z09/GsWYoco/M=;
 b=A4UlH58lahYRLLBhopmjJCtwa/fqSJQw805ZS+EzUqTI2F5CRHzWg2BmBFQauPMQmb
 qCWuvR7y7lVzVJZqN2bOCm2yKUzZiou+TgIJZJRSZknTGHnsK/PmmjECdn2kUTaDQea1
 Isz9dhsbU/cVnfagaw1To5tw1fThPTAA1zUnU7BqKTr9c3HGz2XAu7/WqccJC3yoYWVe
 73xJMg170KRdlTLc62j6uI/t8KNK4gYRLo1VJNcd5Tihz9Xbb/xoVtybgGe7oU3dMSQz
 DybyTZ/vlKO/AbVWp/QtGLZhqzG/nIFDs0HXypOlbr+WZM14M330vgZbErlUx+IJ75aE
 yEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787501390; x=1788106190;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TqtAr9QcKUQShr1qp9wFceDesghN16Z09/GsWYoco/M=;
 b=o1Z21HrxFVRTbfYAUHtnP33PKhsBVqol8yoG2wOsZKDm1RvJ4hAHSrC13Tt+EUfWK1
 0mzHvX73RObv0miSUzobXIXv54o/drG9siitO6ZXQDnJgRkYe2X3JeNWEmDHkYKkrY0g
 zJa6S66FGy8Njb77APZIWmiiIxPbp55u9f5Zs0jQspsbJAfyhPFSwt/HLnD0XRb13rzc
 H1QWIjif9/9w4awE3VfR8Ihk2rbNsBp3l9R+8ENPZ42T5C8ZfHUkIHXMFfOUszyn7oFz
 X471iC5plejMwpflxc/L8hZ9fZBF09CiHn79YPTTX1hUZamu0XXBZ5J7SEEuCBo8jbpI
 kjJw==
X-Gm-Message-State: AFuF++kcG5aJ4xOz1FIV8//aLKAvUSnhfiv/tq0k39G+UZa8Slp/8R+T
 bP1HWCz6UZbB4EnHWsW+5RKJSEw85ccO3n8qYN3VY5FpowHWpK5LbpteM9cmZ0AncoTR56m1G8W
 TBXt8Gb0yBinRVTHD/8+BJkZ11KbcoF8X12OUmyg0hfOkeRiqqmBakdYBiDUN4hBvLtpVz9kF1K
 H5qN9jkQ==
X-Gm-Gg: AR+sD12YkurXHhK2708s1Ji1yeOpJIj7+Kaseq82mzYAviQmIYfSyblLZbED1ZMQc+O
 uTZwmYXzv82aK6EzGmx2doBv7OlmxHzXL+ZniirNw/VjHFJK6bsiRBRSctzBHO70aIDnewMgzYx
 4mBM2OpUK6Out8Rogw9YyyAQzvIuJxDtk+xqCgOICyEUB276wM0N1aoSSmzLy6T5mLR754UGROz
 rRwJjF/nOqdmLDZAm1Hp26Scl5tT77BJEJQk09DSaPPK6ybBPuW7sELPthX2R4REmzl12deCUp0
 8/xf/uBJ8voAOUdAQ/vc15HQF6VZb039d1cPoczDP35YoeC9Kh5wAKdaT5xZNU7M5P0MxbMqL5/
 nbl7DvjNhs7SREUEKDM/ORBqTalL3F5dSJiYP1dC5FpmGbNbiTL9S9b0ReYY2BUIcqbOJIHuT8v
 nMkJYM10sGkFClnQsJlRexoA6qg7sx6dknKD4T9snhkulFi+WUYHQrBX3QrdPXh7qZ/Qiy2lrNG
 T0vvIm59HxwM4XbejjA80C22+i9vNr6AlBAnnsIjrYmnImYqJZx+0CPXFtj4mg31NKL8wi+GGnm
 zEDRFmkEOdsmJu3nJ+AWOqm3JLE44dkm/O7rvGc2ZyXfLVOD7E4=
X-Received: by 2002:a17:907:c243:b0:c24:47b8:ae5b with SMTP id
 a640c23a62f3a-c246a68418emr2478551366b.22.1787501389974; 
 Sun, 23 Aug 2026 09:09:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249686e37bsm763723266b.55.2026.08.23.09.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 09:09:49 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 23 Aug 2026 16:09:47 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 5497bc90d267118da700c955a761eb1155e98254
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fc41b8bf620c059fb935fe0f3c31a6bee802559a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyAlg-0000Ah-OT
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
Content-Type: multipart/mixed; boundary="===============3388069892201577476=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3388069892201577476==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="V10MiOmklgE="; charset=UTF-8

--V10MiOmklgE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#5)=2E ( http://gerrit=2Eopenvpn=2E=
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
, 98 insertions(+), 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/52/1852/5

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
 66bae34=2E=2E67aef8b 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/i=
nit=2Ec
@@ -4337,19 +4337,59 @@
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
+    msg(M_FAT=
AL, "ERROR: Management unix-socket support is not available on this platfor=
m");
+#endif
+}
+
 bool
 open_management(struct context *c)
 {
     /* init=
ialize management layer */
     if (management)
     {
+        unsigned in=
t flags =3D c->options=2Emanagement_flags;
+        if (flags & MF_UNIX_SOC=
K_SCRIPT)
+        {
+            /* This creates a file but our management=
 codes deletes the
+             * file before opening a socket with the na=
me */
+            c->options=2Emanagement_addr =3D platform_create_temp_fi=
le(
+                platform_get_tmp_dir(), "omi", &c->gc);
+        }
+
 =
        if (c->options=2Emanagement_addr)
         {
-            unsigned =
int flags =3D c->options=2Emanagement_flags;
             if (c->options=2E=
mode =3D=3D MODE_SERVER)
             {
                 flags |=3D MF_SERV=
ER;
             }
+
             if (management_open(
                    =
 management, c->options=2Emanagement_addr, c->options=2Emanagement_port,
  =
                   c->options=2Emanagement_user_pass, c->options=2Emanageme=
nt_client_user,
@@ -4361,6 +4401,11 @@
                                    =
  NULL);
             }
 
+            if (flags & MF_UNIX_SOCK_SCRIPT)
+  =
          {
+                run_management_script(c);
+            }
+
   =
          /* initial management hold, called early, before first context in=
itialization */
             do_hold(0);
             if (IS_SIG(c))
diff -=
-git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 95ff246=2E=2Eb=
fc2aa2 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ =
-333,10 +333,12 @@
 man_delete_unix_socket(struct management *man)
 {
 #if =
UNIX_SOCK_SUPPORT
-    if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_CONN=
ECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
+    if ((man->settings=2Eflags & (MF_=
UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK
+        || man->set=
tings=2Eflags & MF_UNIX_SOCK_SCRIPT)
     {
         socket_delete_unix(&ma=
n->settings=2Elocal_unix);
     }
+
 #endif
 }
 
@@ -2197,7 +2199,7 @@
    =
         }
         }
 
-        if (man->settings=2Eflags & MF_CONNECT_AS_=
CLIENT)
+        if (man->settings=2Eflags & (MF_CONNECT_AS_CLIENT | MF_UNI=
X_SOCK_SCRIPT))
         {
             msg(D_MANAGEMENT, "MANAGEMENT: Trig=
gering management exit");
             throw_signal_soft(SIGTERM, "manageme=
nt-exit");
@@ -2644,6 +2646,15 @@
         {
             get_user_pass(&ms=
->up, pass_file, "Management", GET_USER_PASS_PASSWORD_ONLY);
         }
+  =
      else if (ms->flags & MF_UNIX_SOCK_SCRIPT)
+        {
+            /* =
Set random password=2E The password is only
+             * alphanumerical =
[0-9a-f] but still has 128 bit of randomness,
+             * which is more=
 than enough */
+            snprintf(ms->up=2Epassword, sizeof(ms->up=2Epa=
ssword),
+                     "%" PRIx64 "%" PRIx64, get_random(), get_ran=
dom());
+            ms->up=2Edefined =3D true;
+        }
 
 #if UNIX_SOCK=
_SUPPORT
         /*
@@ -2789,6 +2800,11 @@
         man_close_socket(man, =
mc->sd_cli);
     }
 
+    if (mc->unix_script_pid)
+    {
+        kill(mc=
->unix_script_pid, SIGINT);
+    }
+
     command_line_free(mc->in);
     b=
uffer_list_free(mc->out);
 
diff --git a/src/openvpn/manage=2Eh b/src/openv=
pn/manage=2Eh
index 27d3b60=2E=2E71e88d0 100644
--- a/src/openvpn/manage=2E=
h
+++ b/src/openvpn/manage=2Eh
@@ -42,6 +42,7 @@
 #define MF_EXTERNAL_CERT =
         (1u << 15)
 #define MF_EXTERNAL_KEY_PSSPAD    (1u << 16)
 #define =
MF_EXTERNAL_KEY_DIGEST    (1u << 17)
+#define MF_UNIX_SOCK_SCRIPT       (1u=
 << 18)
 
 #ifdef ENABLE_MANAGEMENT
 
@@ -327,6 +328,9 @@
     int fdtosend=
;
     int lastfdreceived;
 #endif
+#ifdef UNIX_SOCK_SUPPORT
+    pid_t uni=
x_script_pid;
+#endif
     int client_version;
 };
 
diff --git a/src/openv=
pn/options=2Ec b/src/openvpn/options=2Ec
index 107b3fa9=2E=2E588d75d 100644=

--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1720,7 +17=
20,7 @@
      * Check for consistency of management options
      */
 #ifde=
f ENABLE_MANAGEMENT
-    if (!options->management_addr
+    if (!options->m=
anagement_addr && !(options->management_flags & MF_UNIX_SOCK_SCRIPT)
      =
   && (options->management_flags
             || options->management_log_hi=
story_cache !=3D defaults=2Emanagement_log_history_cache))
     {
@@ -4301,=
7 +4301,7 @@
     else if (streq(p[0], "management") && p[1] && p[2] && !p[=
4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (streq(p[=
2], "unix"))
+        if (streq(p[2], "unix") || streq(p[2], "unix-script")=
)
         {
 #if UNIX_SOCK_SUPPORT
             options->management_flags =
|=3D MF_UNIX_SOCK;
@@ -4311,7 +4311,16 @@
 #endif
         }
 
-        opt=
ions->management_addr =3D p[1];
+        if (streq(p[2], "unix-script"))
+ =
       {
+            options->management_flags |=3D MF_UNIX_SOCK_SCRIPT | =
MF_HOLD;
+            set_user_script(options, &options->management_script,=
 p[1],
+                            "management unix-script", false);
+    =
    }
+        else
+        {
+            options->management_addr =3D p[=
1];
+        }
         options->management_port =3D p[2];
         if (p[3=
])
         {
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2E=
h
index f472676=2E=2E131513e 100644
--- a/src/openvpn/options=2Eh
+++ b/src=
/openvpn/options=2Eh
@@ -446,6 +446,8 @@
     const char *management_addr;
=
     const char *management_port;
     const char *management_user_pass;
+ =
   /** Script executed to talk to the management interface */
+    const ch=
ar *management_script;
     int management_log_history_cache;
     int mana=
gement_echo_buffer_size;
     int management_state_buffer_size;

-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I307e64079f436aa782f7e24bfff=
665a545ad2fa0
Gerrit-Change-Number: 1852
Gerrit-PatchSet: 5
Gerrit-Owner: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>

--V10MiOmklgE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #5</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Add unix-script functionality to the --management feature<br><br>=
This allows a script that handles management input/output to<br>be started =
alongside OpenVPN simpler in small deployments=2E<br><br>Change-Id: I307e64=
079f436aa782f7e24bfff665a545ad2fa0<br>Signed-off-by: Arne Schwabe &lt;arne@=
rfc2549=2Eorg&gt;<br>---<br>M doc/man-sections/management-options=2Erst<br>=
M doc/management-notes=2Etxt<br>M src/openvpn/init=2Ec<br>M src/openvpn/man=
age=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/options=2Ec<br>M src/o=
penvpn/options=2Eh<br>7 files changed, 98 insertions(+), 8 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/52/1852/5</pre><pre style=3D"font-family: monospace,monospace=
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
bae34=2E=2E67aef8b 100644</span><br><span>--- a/src/openvpn/init=2Ec</span>=
<br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -4337,19 +4337,59 @=
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
=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL, &quot;ERROR: Management =
unix-socket support is not available on this platform&quot;);</span><br><sp=
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
pn/options=2Ec</span><br><span>index 107b3fa9=2E=2E588d75d 100644</span><br=
><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/opti=
ons=2Ec</span><br><span>@@ -1720,7 +1720,7 @@</span><br><span>      * Check=
 for consistency of management options</span><br><span>      */</span><br><=
span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (!options-&gt;management_addr</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!options-&gt;management_addr &amp;&amp; !=
(options-&gt;management_flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>  =
       &amp;&amp; (options-&gt;management_flags</span><br><span>           =
  || options-&gt;management_log_history_cache !=3D defaults=2Emanagement_lo=
g_history_cache))</span><br><span>     {</span><br><span>@@ -4301,7 +4301,7=
 @@</span><br><span>     else if (streq(p[0], &quot;management&quot;) &amp;=
&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><span>     {</span><=
br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (streq(p[2], &quot;unix&quot;))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (streq(p[=
2], &quot;unix&quot;) || streq(p[2], &quot;unix-script&quot;))</span><br><s=
pan>         {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><span>     =
        options-&gt;management_flags |=3D MF_UNIX_SOCK;</span><br><span>@@ =
-4311,7 +4311,16 @@</span><br><span> #endif</span><br><span>         }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
options-&gt;management_addr =3D p[1];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (streq(p[2], &quot;unix-script&quot;))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            options-&gt;management_fl=
ags |=3D MF_UNIX_SOCK_SCRIPT | MF_HOLD;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            set_user_script(options, &amp;options-&gt;m=
anagement_script, p[1],</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                            &quot;management unix-script&quot;, false);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            options-&gt;management_addr =3D p[=
1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span>         options-&gt;management_port =3D p[2];</span><br><span>  =
       if (p[3])</span><br><span>         {</span><br><span>diff --git a/sr=
c/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index f4726=
76=2E=2E131513e 100644</span><br><span>--- a/src/openvpn/options=2Eh</span>=
<br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -446,6 +446,8 @@=
</span><br><span>     const char *management_addr;</span><br><span>     con=
st char *management_port;</span><br><span>     const char *management_user_=
pass;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Script=
 executed to talk to the management interface */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *management_script;</span><br><=
span>     int management_log_history_cache;</span><br><span>     int manage=
ment_echo_buffer_size;</span><br><span>     int management_state_buffer_siz=
e;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">change 1852</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I307e64079f436=
aa782f7e24bfff665a545ad2fa0 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1852 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--V10MiOmklgE=--


--===============3388069892201577476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3388069892201577476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3388069892201577476==--

