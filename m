Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BBC606A333
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z6yTAq/F;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=V4ZGsqNR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L+fNQCy+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Xhd5JlI6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tlczURlurYFxXl1uYlgnBbNRiUyFBrVqV5TKmJdVBXA=; b=Z6yTAq/FDXTBRLSQNqdJfz7L8Y
	/4sBPtTk1+/FmFtJwK1r3fj8JoaQLa+LfWkgQeBcxebK7iU+IKUFjJw9ysF5emud2FCWkZUDJR5sy
	uZ/U4+dQYbNf1pPyk3fEbimS8W7FF+l2V+vRDtWfqT/iL4IabaQgc0uSSx0PjiMLZ9lk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLgTK-0000000028V-3rbI;
	Tue, 27 Oct 2026 12:40:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLgTJ-0000000028O-1CO1
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:40:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hBjcKCEVskcirFN6SVH6MPY+0m+Y7cFQLbAm80fYGHw=; b=V4ZGsqNRqBAV8gil7L+LGElxZd
 EuoF8jep4u4SLPI5dRr5CBmKQgyctfL86oNm0pSo8v+mdX9MUYo6Ckj6kGUzxn42NjTNB89FA92MJ
 +pjfuzvGwNLdcHVPCjbhD5ISGPjnFxCrj8oT+ZmNouFxAAG/Ge7JB7jwJTHmhCRU0C/8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hBjcKCEVskcirFN6SVH6MPY+0m+Y7cFQLbAm80fYGHw=; b=L+fNQCy+dsfvMty5gkwoXqWDxz
 1xrPvvd6aYXoO7HW4bBnYWq0vtzSoN4RXPsa8ab379AhWViTAOZM3fHXHdJYlxrbtF+BhSRrqjFpF
 rJTWHvhSDHDCeNmeTi15aAzT0drHlTIqvy2+V6xU4e+8XfSBxES6EbqQnS9bFHPETdMI=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLgTH-000000005Z6-1Gya for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:40:09 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso26698005e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793104801; x=1793709601; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hBjcKCEVskcirFN6SVH6MPY+0m+Y7cFQLbAm80fYGHw=;
 b=Xhd5JlI6cIhDCp/H7SAGyYNF5PRERjBqEUY9SErdAHqwM/PBPLWp7yUjuUVtwmF4Ji
 JlKKW4FnE+g66oBjGFJhG3cavzgDw9eEnQnzlHgA5div05qiM4fkYayow7mVH+erdgfu
 EQjyJjsvpt7m/WbO7xkOmMa8MkEZeb6y+uiRlf3iB1Mqx4WuB0fIdE4a+24tDlNsyI/F
 ty7ETGtsaSXu+QOrOJhRkcMds0Gi4akWc/m3vqY2gizpOu4ix5+Ir/TFy2AbCMZ/abVw
 OOmq3tB4W6Y5TVTDr/I2IivRun7dDcWTQIZuIjL+W9+xFO384tMpa0N/stphoyCk62i1
 1uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104801; x=1793709601;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hBjcKCEVskcirFN6SVH6MPY+0m+Y7cFQLbAm80fYGHw=;
 b=salKEWsKJ6lkBqKNGV76GxWasAAJL40KePPpZXjol4g2Jgq3uBOw3an7kR1YDYeMfw
 9PGx3kgvdlubN66okyH/lRPxIo4H8BZ7bbcQq9gug8h8Tvs6Wq/DohSfWQLheyWKnidA
 92i6rz/AHm6Q//2cclsGC/SFzqzQ1KFoFzgs6VL5pi/F30Sxs5sCbuhBJdnvN9QL7/a/
 JNXloNKO1xfrupL24BRwn4Sju85uJzfujr3lGcUwzApi1TA4dtVn+GZY879DlfoMpWom
 w16Ca3YYriOwlskC19y5k6C87NUaMlcQnrzK84N3sArhgtlCP9iqKd8SYMA7LHrhPA/C
 1EeQ==
X-Gm-Message-State: AFq9FYLyOOanTGxg9LKRCCgAZNTLQl99REeapHtBz0nsJZz/nUXSdeX8
 ztEICbDvDB9pqVd2oV9JS+rC61PT9AxtaYBrUZx39yBvXjDc8c5j8YOi7nOJ8o/LSzpdsl9flmx
 2l9GVqrN0IzcmmpOT71pu4iXlyyepkGF8OgF6deBFs5dHE9L5X/6WbreQyEX3CmjK2hko
X-Gm-Gg: AYBFou2WP5ty2A0bkqf/OmWLjlky9wJgvkSl3c5tI1SBHWCjy3jlyArTXnd+elJKh6F
 5KRLthE9jjlcXgu+fl0aly8J8/1Utv4q56YGIz04ykC2uoKeM2vT88ugMRZozltS4SOx9t1O1be
 tugNkT+iqKXx73W9CFL3Qa/CYaFAWwUftMRSOpyTSGAQr1COSJ4vlZXX9EpFGw6d6H0a68jr9S3
 zj0AfWM/URkZFjfCXnC8KFrtl044hiuS99E7mOiivEIYk7jUZI2pdQQWy2ypQF8mcXeiL1LUes5
 qZU0OLFLbMagKxOWcPVxkXYMdX1AzEUFCZswkjEo0L57AyhdjAmjJDfqZIb8b5OOimc3T0ID9FN
 k+fpN9Ck92BkGtLwasueAvHF0XnWosn0SmFimewJMOgpAlxXqT5fibqE0TM37eTCS/qfXH0ylb4
 Ou4226VTyd4cNgCGoUXDx0MP2Ylg+41l/h+1BlaX9Rm+Lr8nKl9BRSa3TGZmSciYCPw6SJe+u/g
 0JZLoy7NrW+GDChJLuDeFCBvOUBSd2KcgyNGMK+hrBbCkbxgomirCGW8mUEw7n/d4TQhKPfiRs/
 7IFG22CjShcAwlge/IjPLlJDqBRoa3SGGHaMtZHZ+XLn+AlRQhxpb2J9qzQCJdPI0EPRwxq8kYf
 clttktvwyZfA7j+iX81iXmYaXPpg5hyftAF/E95gq7w==
X-Received: by 2002:a05:600c:1c0b:b0:4a1:d10c:7170 with SMTP id
 5b1f17b1804b1-4a35acbf94amr248941795e9.31.1793104800265; 
 Tue, 27 Oct 2026 05:40:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a58a0e2sm329823985e9.13.2026.10.27.05.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:39:59 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 12:39:55 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 8599bbe2a80721125ceef7b527c44548eb2c53bf
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aee4fed3bfd5ecb036bba88a94c99b6e52bf11d3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLgTH-000000005Z6-1Gya
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
Content-Type: multipart/mixed; boundary="===============6531197427997117558=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6531197427997117558==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="evD64Db+uVc="; charset=UTF-8

--evD64Db+uVc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd l=
ike you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1852?usp=3Demail

to look at the new patch set (#15)=2E
=


Change subject: Add unix-script functionality to the --management feature=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add unix-s=
cript functionality to the --management feature

This allows a script that =
handles management input/output to
be started alongside OpenVPN simpler in =
small deployments=2E

Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
=
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M doc/man-sections/man=
agement-options=2Erst
M doc/management-notes=2Etxt
M src/openvpn/init=2Ec
M=
 src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/options=2Ec
=
M src/openvpn/options=2Eh
7 files changed, 127 insertions(+), 11 deletions(=
-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/=
1852/15

diff --git a/doc/man-sections/management-options=2Erst b/doc/man-s=
ections/management-options=2Erst
index 8dad52b=2E=2Ee2e0773 100644
--- a/do=
c/man-sections/management-options=2Erst
+++ b/doc/man-sections/management-o=
ptions=2Erst
@@ -14,6 +14,7 @@
     management socket-name unix pw-file  # =
(recommended)
     management IP port                   # (INSECURE)
     m=
anagement IP port pw-file           #
+    management script unix-script
 
=
   ``pw-file``, if specified, is a password file where the password must
  =
 be on first line=2E Instead of a filename it can use the keyword stdin
@@ =
-25,6 +26,14 @@
   ``--management-client-user`` and ``--management-client-g=
roup``
   directives to restrict access=2E
 
+  When the variant :code:`uni=
x-script` is used, OpenVPN will start the
+  specified script on startup an=
d enable ``--management-hold``=2E
+  OpenVPN will generate a random path fo=
r the unix socket
+  and management password=2E These are passed as environ=
ment
+  variables :code:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_PASSWORD`
+ =
 to the script when being started=2E When OpenVPN terminates it sends
+  a =
:code:`SIGINT` signal to the running script=2E
+
   The management interfac=
e provides a special mode where the TCP
   management link can operate over=
 the tunnel itself=2E To enable this mode,
   set IP to ``tunnel``=2E Tunne=
l mode will cause the management interface to
@@ -127,10 +136,11 @@
   (cli=
ent-only)=2E
 
 --management-signal
-  Send SIGUSR1 signal to OpenVPN if ma=
nagement session disconnects=2E This
-  is useful when you wish to disconne=
ct an OpenVPN session on user logoff=2E
-  For ``--management-client`` this=
 option is not needed since a disconnect
-  will always generate a :code:`S=
IGTERM`=2E
+  Send :code:`SIGUSR1` signal to OpenVPN if management session =
disconnects=2E
+  This is useful when you wish to disconnect an OpenVPN ses=
sion on user
+  logoff=2E For ``--management-client`` or ``--management`` w=
ith
+  :code:`unixscript` this option has no effect since a disconnect will=

+  always trigger sending a :code:`SIGTERM`=2E
 
 --management-up-down
   =
Report tunnel up/down events to management interface=2E
diff --git a/doc/ma=
nagement-notes=2Etxt b/doc/management-notes=2Etxt
index a28a1a8=2E=2E4d726c=
4 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
=
@@ -35,6 +35,10 @@
 you can telnet to the management port (make sure to use=

 a telnet client which understands "raw" mode)=2E
 
+When password authent=
ication is enabled, the management interface
+will require sending the pass=
word on its own line after establishing
+the connection=2E
+
 Once connecte=
d to the management port, you can use
 the "help" command to list all comma=
nds=2E
 
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 24c=
f532=2E=2Efc100da 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=
=2Ec
@@ -4343,19 +4343,61 @@
     }
 }
 
+static void
+run_management_scrip=
t(const struct context *c)
+{
+#if UNIX_SOCK_SUPPORT
+    struct gc_arena g=
c =3D gc_new();
+    struct argv argv =3D argv_new();
+    struct env_set *=
env =3D env_set_create(&gc);
+
+    setenv_str(env, "MANAGEMENT_PASSWORD", =
management->settings=2Eup=2Epassword);
+    setenv_str(env, "MANAGEMENT_SOC=
KET", c->options=2Emanagement_addr);
+
+    argv_parse_cmd(&argv, c->option=
s=2Emanagement_script);
+
+    int flags =3D S_NOWAITPID | S_SCRIPT | S_FAT=
AL;
+    int *pid =3D &management->connection=2Eunix_script_pid;
+    const=
 char *msg_prefix =3D "ERROR: Failed running management unix-script";
+    =
*pid =3D openvpn_execve_check(&argv, env, flags, msg_prefix);
+
+    if (!o=
penvpn_waitpid_check(*pid, msg_prefix, M_FATAL))
+    {
+        *pid =3D 0=
;
+    }
+
+    argv_free(&argv);
+    gc_free(&gc);
+#else
+    msg(M_FATA=
L, "ERROR: Management unix-socket support is not available on this platform=
");
+#endif
+}
+
 bool
 open_management(struct context *c)
 {
     /* initi=
alize management layer */
     if (management)
     {
+        unsigned int=
 flags =3D c->options=2Emanagement_flags;
+        if (flags & MF_UNIX_SOCK=
_SCRIPT)
+        {
+            /* This creates a filename that should be =
unguessable */
+            char sockname[64] =3D { 0 };
+            snpri=
ntf(sockname, sizeof(sockname),
+                     PACKAGE_NAME "_omi_%0=
8" PRIx64 "%08" PRIx64 "=2Esock",
+                     get_random(), get_r=
andom());
+
+            c->options=2Emanagement_addr =3D platform_gen_path=
(c->options=2Etmp_dir, sockname, &c->gc);
+        }
+
         if (c->opti=
ons=2Emanagement_addr)
         {
-            unsigned int flags =3D c->op=
tions=2Emanagement_flags;
             if (c->options=2Emode =3D=3D MODE_SE=
RVER)
             {
                 flags |=3D MF_SERVER;
             }
=
+
             if (management_open(
                     management, c->opt=
ions=2Emanagement_addr, c->options=2Emanagement_port,
                     =
c->options=2Emanagement_user_pass, c->options=2Emanagement_client_user,
@@ =
-4367,6 +4409,11 @@
                                      NULL);
          =
   }
 
+            if (flags & MF_UNIX_SOCK_SCRIPT)
+            {
+      =
          run_management_script(c);
+            }
+
             /* initia=
l management hold, called early, before first context initialization */
   =
          do_hold(0);
             if (IS_SIG(c))
diff --git a/src/openvpn/=
manage=2Ec b/src/openvpn/manage=2Ec
index 0fc9ee2=2E=2Eccf66b43 100644
--- =
a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -47,6 +47,7 @@
 #i=
nclude "resolve=2Eh"
 
 #include "memdbg=2Eh"
+#include "run_command=2Eh"
 =

 #ifdef ENABLE_PKCS11
 #include "pkcs11=2Eh"
@@ -334,10 +335,12 @@
 man_de=
lete_unix_socket(const struct management *man)
 {
 #if UNIX_SOCK_SUPPORT
- =
   if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=
=3D MF_UNIX_SOCK)
+    if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_CONN=
ECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK
+        || man->settings=2Eflags & MF_=
UNIX_SOCK_SCRIPT)
     {
         socket_delete_unix(&man->settings=2Elocal=
_unix);
     }
+
 #endif
 }
 
@@ -2196,10 +2199,18 @@
             }
      =
   }
 
+        if (man->settings=2Eflags & MF_UNIX_SOCK_SCRIPT && !man_pas=
sword_needed(man))
+        {
+            msg(D_MANAGEMENT, "MANAGEMENT: T=
riggering exit on unix-script disconnect");
+            throw_signal_soft(=
SIGTERM, "management-exit");
+        }
+
         if (man->settings=2Eflag=
s & MF_CONNECT_AS_CLIENT)
         {
-            msg(D_MANAGEMENT, "MANAGE=
MENT: Triggering management exit");
-            throw_signal_soft(SIGTERM,=
 "management-exit");
+            {
+                msg(D_MANAGEMENT, "MAN=
AGEMENT: Triggering management exit");
+                throw_signal_soft(S=
IGTERM, "management-exit");
+            }
         }
         else
       =
  {
@@ -2644,6 +2655,15 @@
         {
             get_user_pass(&ms->up, p=
ass_file, "Management", GET_USER_PASS_PASSWORD_ONLY);
         }
+        e=
lse if (ms->flags & MF_UNIX_SOCK_SCRIPT)
+        {
+            /* Set ran=
dom password=2E The password is only
+             * alphanumerical [0-9a-f=
] but still has 128 bit of randomness,
+             * which is more than e=
nough */
+            snprintf(ms->up=2Epassword, sizeof(ms->up=2Epassword)=
,
+                     "%" PRIx64 "%" PRIx64, get_random(), get_random());=

+            ms->up=2Edefined =3D true;
+        }
 
 #if UNIX_SOCK_SUPPOR=
T
         /*
@@ -2789,6 +2809,13 @@
         man_close_socket(man, mc->sd_=
cli);
     }
 
+#if UNIX_SOCK_SUPPORT
+    if (mc->unix_script_pid)
+    {
=
+        kill(mc->unix_script_pid, SIGINT);
+    }
+#endif
+
     command_l=
ine_free(mc->in);
     buffer_list_free(mc->out);
 
@@ -3448,6 +3475,19 @@
=
                 break;
             }
 
+#if UNIX_SOCK_SUPPORT
+          =
  /* if unix-script is in use, the script might have exited
+             *=
 while we are waiting for it to connect */
+            const char *msg_pre=
fix =3D "ERROR: Failed running management unix-script";
+
+            if (=
man->connection=2Eunix_script_pid
+                && !openvpn_waitpid_chec=
k(man->connection=2Eunix_script_pid, msg_prefix, M_FATAL))
+            {
+=
                status =3D -1;
+                break;
+            }
+#end=
if
+
             if (status > 0)
             {
                 break;
di=
ff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index f2c6916=2E=
=2E157039d 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh=

@@ -42,6 +42,7 @@
 #define MF_EXTERNAL_CERT          (1u << 15)
 #define M=
F_EXTERNAL_KEY_PSSPAD    (1u << 16)
 #define MF_EXTERNAL_KEY_DIGEST    (1u =
<< 17)
+#define MF_UNIX_SOCK_SCRIPT       (1u << 18)
 
 #ifdef ENABLE_MANAG=
EMENT
 
@@ -327,6 +328,9 @@
     int fdtosend;
     int lastfdreceived;
 #e=
ndif
+#if UNIX_SOCK_SUPPORT
+    pid_t unix_script_pid;
+#endif
     int cl=
ient_version;
 };
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn/opti=
ons=2Ec
index 8e0c602=2E=2Efb319ae 100644
--- a/src/openvpn/options=2Ec
+++=
 b/src/openvpn/options=2Ec
@@ -1700,7 +1700,7 @@
      * Check for consiste=
ncy of management options
      */
 #ifdef ENABLE_MANAGEMENT
-    if (!opti=
ons->management_addr
+    if (!options->management_addr && !(options->manag=
ement_flags & MF_UNIX_SOCK_SCRIPT)
         && (options->management_flags
 =
            || options->management_log_history_cache !=3D defaults=2Emanage=
ment_log_history_cache))
     {
@@ -4285,7 +4285,7 @@
     else if (streq(p=
[0], "management") && p[1] && p[2] && !p[4])
     {
         VERIFY_PERMISS=
ION(OPT_P_GENERAL);
-        if (streq(p[2], "unix"))
+        if (streq(p[=
2], "unix") || streq(p[2], "unix-script"))
         {
 #if UNIX_SOCK_SUPPOR=
T
             options->management_flags |=3D MF_UNIX_SOCK;
@@ -4295,7 +429=
5,16 @@
 #endif
         }
 
-        options->management_addr =3D p[1];
+ =
       if (streq(p[2], "unix-script"))
+        {
+            options->man=
agement_flags |=3D MF_UNIX_SOCK_SCRIPT | MF_HOLD;
+            set_user_scr=
ipt(options, &options->management_script, p[1],
+                          =
  "management unix-script", false);
+        }
+        else
+        {
+  =
          options->management_addr =3D p[1];
+        }
         options->m=
anagement_port =3D p[2];
         if (p[3])
         {
diff --git a/src/ope=
nvpn/options=2Eh b/src/openvpn/options=2Eh
index c58530a=2E=2E6a3bf61 10064=
4
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -446,6 +44=
6,8 @@
     const char *management_addr;
     const char *management_port;
=
     const char *management_user_pass;
+    /** Script executed to talk to =
the management interface */
+    const char *management_script;
     int ma=
nagement_log_history_cache;
     int management_echo_buffer_size;
     int =
management_state_buffer_size;

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1852?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Num=
ber: 1852
Gerrit-PatchSet: 15
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>

--evD64Db+uVc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #15</strong> to this ch=
ange=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?us=
p=3Demail">View Change</a></p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Add unix-script functionality t=
o the --management feature<br><br>This allows a script that handles managem=
ent input/output to<br>be started alongside OpenVPN simpler in small deploy=
ments=2E<br><br>Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0<br>Sig=
ned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M doc/man-sec=
tions/management-options=2Erst<br>M doc/management-notes=2Etxt<br>M src/ope=
nvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M =
src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>7 files changed, 12=
7 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1852/15</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/doc/man-sections/management-options=2Erst b/doc/man-sections/manag=
ement-options=2Erst</span><br><span>index 8dad52b=2E=2Ee2e0773 100644</span=
><br><span>--- a/doc/man-sections/management-options=2Erst</span><br><span>=
+++ b/doc/man-sections/management-options=2Erst</span><br><span>@@ -14,6 +1=
4,7 @@</span><br><span>     management socket-name unix pw-file  # (recomme=
nded)</span><br><span>     management IP port                   # (INSECURE=
)</span><br><span>     management IP port pw-file           #</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    management script unix-script=
</span><br><span> </span><br><span>   ``pw-file``, if specified, is a passw=
ord file where the password must</span><br><span>   be on first line=2E Ins=
tead of a filename it can use the keyword stdin</span><br><span>@@ -25,6 +2=
6,14 @@</span><br><span>   ``--management-client-user`` and ``--management-=
client-group``</span><br><span>   directives to restrict access=2E</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  When the=
 variant :code:`unix-script` is used, OpenVPN will start the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  specified script on startup and =
enable ``--management-hold``=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  OpenVPN will generate a random path for the unix socket</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  and management password=
=2E These are passed as environment</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  variables :code:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_PA=
SSWORD`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  to the scr=
ipt when being started=2E When OpenVPN terminates it sends</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  a :code:`SIGINT` signal to the run=
ning script=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>   The management interface provides a special mode where the T=
CP</span><br><span>   management link can operate over the tunnel itself=2E=
 To enable this mode,</span><br><span>   set IP to ``tunnel``=2E Tunnel mod=
e will cause the management interface to</span><br><span>@@ -127,10 +136,11=
 @@</span><br><span>   (client-only)=2E</span><br><span> </span><br><span> =
--management-signal</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
Send SIGUSR1 signal to OpenVPN if management session disconnects=2E This</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  is useful when you wis=
h to disconnect an OpenVPN session on user logoff=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  For ``--management-client`` this option i=
s not needed since a disconnect</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  will always generate a :code:`SIGTERM`=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Send :code:`SIGUSR1` signal to OpenVPN =
if management session disconnects=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  This is useful when you wish to disconnect an OpenVPN se=
ssion on user</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  logo=
ff=2E For ``--management-client`` or ``--management`` with</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  :code:`unixscript` this option has=
 no effect since a disconnect will</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  always trigger sending a :code:`SIGTERM`=2E</span><br><spa=
n> </span><br><span> --management-up-down</span><br><span>   Report tunnel =
up/down events to management interface=2E</span><br><span>diff --git a/doc/=
management-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>index a=
28a1a8=2E=2E4d726c4 100644</span><br><span>--- a/doc/management-notes=2Etxt=
</span><br><span>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -35,6 =
+35,10 @@</span><br><span> you can telnet to the management port (make sure=
 to use</span><br><span> a telnet client which understands &quot;raw&quot; =
mode)=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+When password authentication is enabled, the management interface</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+will require sending t=
he password on its own line after establishing</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+the connection=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> Once connected to the management=
 port, you can use</span><br><span> the &quot;help&quot; command to list al=
l commands=2E</span><br><span> </span><br><span>diff --git a/src/openvpn/in=
it=2Ec b/src/openvpn/init=2Ec</span><br><span>index 24cf532=2E=2Efc100da 10=
0644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/o=
penvpn/init=2Ec</span><br><span>@@ -4343,19 +4343,61 @@</span><br><span>   =
  }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+run_management_script(const struct context *c)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct argv argv =3D argv_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct env_se=
t *env =3D env_set_create(&amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 setenv_str(env, &quot;MANAGEMENT_PASSWORD&quot;, management-&gt;settings=
=2Eup=2Epassword);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   setenv_str(env, &quot;MANAGEMENT_SOCKET&quot;, c-&gt;options=2Emanagemen=
t_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    argv_parse_cmd(&amp;argv, =
c-&gt;options=2Emanagement_script);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int flags =3D S_NOWAITPID | S_SCRIPT | S_FATAL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int *pid =3D &amp;management-&gt;connectio=
n=2Eunix_script_pid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char *msg_prefix =3D &quot;ERROR: Failed running management unix=
-script&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *=
pid =3D openvpn_execve_check(&amp;argv, env, flags, msg_prefix);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!openvpn_waitpid_check(*pid, msg_prefix, =
M_FATAL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        *pid =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    argv_free(&amp;argv);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    msg(M_FATAL, &quot;ERROR: Management unix-socket support is=
 not available on this platform&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> bool</span><br><span> open_management(struct context *c)</span><br><=
span> {</span><br><span>     /* initialize management layer */</span><br><s=
pan>     if (management)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        unsigned int flags =3D c-&gt;options=2E=
management_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            /* This creates a filename that should be unguessa=
ble */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c=
har sockname[64] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            snprintf(sockname, sizeof(sockname),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                     PACKAGE_NAME &quo=
t;_omi_%08&quot; PRIx64 &quot;%08&quot; PRIx64 &quot;=2Esock&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     get_ra=
ndom(), get_random());</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&g=
t;options=2Emanagement_addr =3D platform_gen_path(c-&gt;options=2Etmp_dir, =
sockname, &amp;c-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>         if (c-&gt;options=2Emanagement_addr)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 unsigned int flags =3D c-&gt;options=2Emanagement_flags;</span><br><span> =
            if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</span><br><span>  =
           {</span><br><span>                 flags |=3D MF_SERVER;</span><=
br><span>             }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>             if (management_open(</span><br><span>    =
                 management, c-&gt;options=2Emanagement_addr, c-&gt;options=
=2Emanagement_port,</span><br><span>                     c-&gt;options=2Ema=
nagement_user_pass, c-&gt;options=2Emanagement_client_user,</span><br><span=
>@@ -4367,6 +4409,11 @@</span><br><span>                                   =
   NULL);</span><br><span>             }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (flags &amp; MF_UNIX_=
SOCK_SCRIPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   run_management_script(c);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>             /* initial management hold, called early, =
before first context initialization */</span><br><span>             do_hold=
(0);</span><br><span>             if (IS_SIG(c))</span><br><span>diff --git=
 a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 0f=
c9ee2=2E=2Eccf66b43 100644</span><br><span>--- a/src/openvpn/manage=2Ec</sp=
an><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -47,6 +47,7 @@=
</span><br><span> #include &quot;resolve=2Eh&quot;</span><br><span> </span>=
<br><span> #include &quot;memdbg=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;run_command=2Eh&quot;</span><br><span=
> </span><br><span> #ifdef ENABLE_PKCS11</span><br><span> #include &quot;pk=
cs11=2Eh&quot;</span><br><span>@@ -334,10 +335,12 @@</span><br><span> man_d=
elete_unix_socket(const struct management *man)</span><br><span> {</span><b=
r><span> #if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT=
_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CO=
NNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        || man-&gt;settings=2Eflags &amp; MF_UNIX_SOCK_SC=
RIPT)</span><br><span>     {</span><br><span>         socket_delete_unix(&a=
mp;man-&gt;settings=2Elocal_unix);</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif</span><br><s=
pan> }</span><br><span> </span><br><span>@@ -2196,10 +2199,18 @@</span><br>=
<span>             }</span><br><span>         }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;settings=
=2Eflags &amp; MF_UNIX_SOCK_SCRIPT &amp;&amp; !man_password_needed(man))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MANAGEMENT, &q=
uot;MANAGEMENT: Triggering exit on unix-script disconnect&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            throw_signal_soft=
(SIGTERM, &quot;management-exit&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>         if (man-&gt;settings=2Eflags &amp; MF_C=
ONNECT_AS_CLIENT)</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            msg(D_MANAGEMENT, &quot;MANAGEMENT: Trig=
gering management exit&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            throw_signal_soft(SIGTERM, &quot;management-exit&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_M=
ANAGEMENT, &quot;MANAGEMENT: Triggering management exit&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                throw_signal_so=
ft(SIGTERM, &quot;management-exit&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span>         }</span><br><s=
pan>         else</span><br><span>         {</span><br><span>@@ -2644,6 +26=
55,15 @@</span><br><span>         {</span><br><span>             get_user_p=
ass(&amp;ms-&gt;up, pass_file, &quot;Management&quot;, GET_USER_PASS_PASSWO=
RD_ONLY);</span><br><span>         }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        else if (ms-&gt;flags &amp; MF_UNIX_SOCK_SCRIPT)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            /* Set random passw=
ord=2E The password is only</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+             * alphanumerical [0-9a-f] but still has 128 bit of ran=
domness,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
  * which is more than enough */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            snprintf(ms-&gt;up=2Epassword, sizeof(ms-&gt;up=2E=
password),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
            &quot;%&quot; PRIx64 &quot;%&quot; PRIx64, get_random(), get_ra=
ndom());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 ms-&gt;up=2Edefined =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span> </span><br><span> #if UNIX_SOCK_SUPPO=
RT</span><br><span>         /*</span><br><span>@@ -2789,6 +2809,13 @@</span=
><br><span>         man_close_socket(man, mc-&gt;sd_cli);</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (mc-&gt;unix_script_pid)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        kill(mc-&gt;unix_script_pid, SIGINT);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     command_line_free(mc-&gt;in);</span><br><span>    =
 buffer_list_free(mc-&gt;out);</span><br><span> </span><br><span>@@ -3448,6=
 +3475,19 @@</span><br><span>                 break;</span><br><span>      =
       }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            /* if unix-script is in use, the script might have exi=
ted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * w=
hile we are waiting for it to connect */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            const char *msg_prefix =3D &quot;ERROR: Fa=
iled running management unix-script&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (man-&gt;connection=2Eunix_script_pid</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; !openvpn_wa=
itpid_check(man-&gt;connection=2Eunix_script_pid, msg_prefix, M_FATAL))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                status =3D -1=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                br=
eak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             if (=
status &gt; 0)</span><br><span>             {</span><br><span>             =
    break;</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvp=
n/manage=2Eh</span><br><span>index f2c6916=2E=2E157039d 100644</span><br><s=
pan>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=
=2Eh</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #define MF_EXTERNAL=
_CERT          (1u &lt;&lt; 15)</span><br><span> #define MF_EXTERNAL_KEY_PS=
SPAD    (1u &lt;&lt; 16)</span><br><span> #define MF_EXTERNAL_KEY_DIGEST   =
 (1u &lt;&lt; 17)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine MF_UNIX_SOCK_SCRIPT       (1u &lt;&lt; 18)</span><br><span> </span><b=
r><span> #ifdef ENABLE_MANAGEMENT</span><br><span> </span><br><span>@@ -327=
,6 +328,9 @@</span><br><span>     int fdtosend;</span><br><span>     int la=
stfdreceived;</span><br><span> #endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    pid_t unix_script_pid;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span>     int client_version;<=
/span><br><span> };</span><br><span> </span><br><span>diff --git a/src/open=
vpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 8e0c602=2E=
=2Efb319ae 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><=
span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -1700,7 +1700,7 @@</s=
pan><br><span>      * Check for consistency of management options</span><br=
><span>      */</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!options-&gt;management_addr</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!options-&gt;m=
anagement_addr &amp;&amp; !(options-&gt;management_flags &amp; MF_UNIX_SOCK=
_SCRIPT)</span><br><span>         &amp;&amp; (options-&gt;management_flags<=
/span><br><span>             || options-&gt;management_log_history_cache !=
=3D defaults=2Emanagement_log_history_cache))</span><br><span>     {</span>=
<br><span>@@ -4285,7 +4285,7 @@</span><br><span>     else if (streq(p[0], &=
quot;management&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</s=
pan><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENER=
AL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (streq=
(p[2], &quot;unix&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (streq(p[2], &quot;unix&quot;) || streq(p[2], &quot;unix-s=
cript&quot;))</span><br><span>         {</span><br><span> #if UNIX_SOCK_SUP=
PORT</span><br><span>             options-&gt;management_flags |=3D MF_UNIX=
_SOCK;</span><br><span>@@ -4295,7 +4295,16 @@</span><br><span> #endif</span=
><br><span>         }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        options-&gt;management_addr =3D p[1];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (streq(p[2], &quot;u=
nix-script&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 options-&gt;management_flags |=3D MF_UNIX_SOCK_SCRIPT | MF_HOLD;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            set_user_script(o=
ptions, &amp;options-&gt;management_script, p[1],</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                            &quot;management =
unix-script&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-=
&gt;management_addr =3D p[1];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span>         options-&gt;management_port =
=3D p[2];</span><br><span>         if (p[3])</span><br><span>         {</sp=
an><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh=
</span><br><span>index c58530a=2E=2E6a3bf61 100644</span><br><span>--- a/sr=
c/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><=
br><span>@@ -446,6 +446,8 @@</span><br><span>     const char *management_ad=
dr;</span><br><span>     const char *management_port;</span><br><span>     =
const char *management_user_pass;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /** Script executed to talk to the management interface *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *ma=
nagement_script;</span><br><span>     int management_log_history_cache;</sp=
an><br><span>     int management_echo_buffer_size;</span><br><span>     int=
 management_state_buffer_size;</span><br></pre><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">change 1852</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I307e64079f436aa782f7e24bfff665a545ad2fa0 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1852 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body=
></html>
--evD64Db+uVc=--


--===============6531197427997117558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6531197427997117558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6531197427997117558==--

