Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BB1CC6B34
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uZdBpXQKxpGbA8YBps56OphJpSkxwP/aoLO1JruLqs8=; b=L24kPgmD0501VTl+Uot4F+qw2r
	mH2o/NDzSwRngCfjIsBBX8Q3IodZ6ac6LQRBCCWaFoMhTjPtmfx89ZCP3dfwyRwpgBXlgeVb9FrA1
	11KAF10h1g9eL9iNUJ802P/PAsHQi9F2ojrcAgXqpSWq0Iail0nhiBK6fEcTx6PvCX6U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHIhP-0006Bn-Mx;
	Thu, 15 Oct 2026 10:28:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHIhO-0006Bg-Ev
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 10:28:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GKCUpBgJFVJAq00rt7w3ABmhvzNQxYMNX0NB8DUjlSo=; b=DbXjVyxAqmnxvS2Rr0FLmYO4VJ
 d4TlcoLz843b0xES77IQQ3uSTKQQPcItRoqpAASsYNXm4gRt612opI0A9RVk8cCynm0vXCKNs21rf
 UrJlxcMytYXMJ+bR1GMvIiAnuZwsKlbKfJm1wJBb3Kb7MbXbfdt1HKa9k+kY7aK3ugIU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GKCUpBgJFVJAq00rt7w3ABmhvzNQxYMNX0NB8DUjlSo=; b=k
 NY7CmaWv78WJ0Fki8SHioSH1Po/eus35l43T0XITBS3EI0+NXPByf7GboKyibs/PAd1kb11i6soNn
 GhFQUwKFFQM+i0XK7WNfaGWhX3bM1ItJ2/8NwlukyvIafRSm8sGmOPE/yztqmrS3t6qZVnUBlNZww
 tDx0Ue+O5hE9Scsk=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHIhJ-0003Tj-Ho for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 10:28:31 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso3748497f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 03:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792060103; x=1792664903; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GKCUpBgJFVJAq00rt7w3ABmhvzNQxYMNX0NB8DUjlSo=;
 b=f2GOjppIpwi3n1Z66RCVhD0rzyjk+Q90QNsEV8SncwBcRh2eZZ7rQ4BO23WLMtztH4
 PbuZ+GuD0mDII5ZVPIR7RRCZco98iutPDXip2gHVPNj6ubRntqxTOrxxHmI1hvcvxaVy
 1knO0bGL2hdelwB85moj0OydvpxFkiOr4QwTFcJnTB6Kq8EBac3a4qt4cLjNGIL5DbMP
 gwMc0l610Cdnlk6C8G9tCUa1Bg7m6SrCSJNtmrbUw6H9olJb5Cit5QC2dijL4sOshg4W
 1wSAsBJOJFd8I1d4ZSgmj8YYoM9HX3XT2qAambaWOblRFlxZS1oOkIPn2wsQi4Y8I1U5
 Ti8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060103; x=1792664903;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GKCUpBgJFVJAq00rt7w3ABmhvzNQxYMNX0NB8DUjlSo=;
 b=hBAhjLDKGqdYDejKaO6ksMI2y1cXqklYKAMNiRoDWnFhp3bkA3bao+LlTy16m6SLE9
 WxNTk+QVBmbrCGSonw7ymRZWLPYElK0x1rmNssuzf0yy9Er8dL2xLooebLRbBu+2NGJ0
 wnaZ+kdCfPWXJ/JSjg19PkaTjK3ODALje9qEUuCvFuveUscQIthm0bY7ntvo/cA8p50O
 BXtOuERIhd0hnfW8HxC4caKe/2VDPWjPJp8odQdGppa8GbD3FkWRIB/5NvsU1aKqaWjt
 B5NlcOTmQ1Lljj1WfSj0PeqVMpE4zqoRxYSQfX3gf4rnt2kDyjIUWoeJjt5tpCIxuXGr
 W2ZQ==
X-Gm-Message-State: AFq9FYJrYB7dACi5A+XknZbCtzYewHm7ljqJYNlkBhiYulaqiqegsmtw
 Q6sGYV9JCEgmuT2KAdXMgF/Icr3xRrc65vsDDDib9rfVQ0rermhrJEsFd/h47xLOVEHDK2Ihbjx
 4N4Vp447q5/a31zbQNoY2KPrdcPV+C99mmb/p402QuL6M8alG05QPL05w9okqDeieKGgBcHwDQ1
 CzT9r17w==
X-Gm-Gg: AYBFou2xg7C38Nr02Bzd/lqmknuaXVGsHxXAeT6NAHqCFmZyepTa/zMy2bDLCy3cFzn
 4OfvMBz28T1yGEn/RSiuduiAaphmF1IpMAYvuJzpfocj1gXY2vLAKgFDnzlAyqb7O3HvkD4nC3D
 WVf8J74z3e3P/ec8aQ9OTggS52BRnfeqDTKV/peRI/5J9D8skN/yF+E/dAGUypDLUGs1jO1GeGQ
 KVysjqzpKpgzPQG4USQH3V5WrTjXdV2hzNNoptbL99+EaFJ1axBVDspbyd+m7buWu0fwYrZM1bU
 8/T7S3kboz32OUE9+ho6IU6zSD/6NAoJ9RcbgXLPHlRfS+CzVA5c7hDWIciznDlxGPWrl1/t3sa
 B3aXs2eHfTEe8PHpGPcVf6AnMmOzBAuo1xYOu5YMSUdioC1kkhjazAwdB2nlQVYXCFg91m5GP8C
 NZ2ja8ZqZGQzOnqevRWHOROLQiNg9IkcRF/AYj/mW8eQJYVlBEOhvc4Hvo1M/DmRib6SSCqJddd
 c2CiyeWrJ3DpOm1a2fQPvWHRKtjvDR1uU34nUCuW9pcOv4f9/iGkinUTIC+A1I+lpEfyeKPv5CL
 Yo/wcM05+8zg0lxzhAl8StegoxNsIav80YWZEwMIdNFo77DYRRmENlfgeCibT5QQZiyziM0=
X-Received: by 2002:a05:6000:2991:10b0:488:8352:cbfd with SMTP id
 ffacd0b85a97d-48dbad3820bmr27895502f8f.46.1792060101033; 
 Thu, 15 Oct 2026 03:28:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaabc3sm18024462f8f.16.2026.10.15.03.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:28:20 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 10:28:13 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 4f52ddc639360c746103d4a704f0aeb81044f095
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <558e341a299882a0fbb9ba6d27feb94e5f620909-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHIhJ-0003Tj-Ho
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4473604145427433683=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4473604145427433683==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QpGYEnw5uD8="; charset=UTF-8

--QpGYEnw5uD8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1852?usp=3Demail

to look at the new patch set (#12)=2E


Change subje=
ct: Add unix-script functionality to the --management feature
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add unix-script functiona=
lity to the --management feature

This allows a script that handles managem=
ent input/output to
be started alongside OpenVPN simpler in small deploymen=
ts=2E

Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
Signed-off-by: =
Arne Schwabe <arne@rfc2549=2Eorg>
---
M doc/man-sections/management-options=
=2Erst
M doc/management-notes=2Etxt
M src/openvpn/init=2Ec
M src/openvpn/ma=
nage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/options=2Ec
M src/openvpn/o=
ptions=2Eh
7 files changed, 126 insertions(+), 11 deletions(-)


  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1852/12

diff -=
-git a/doc/man-sections/management-options=2Erst b/doc/man-sections/managem=
ent-options=2Erst
index 8dad52b=2E=2Ee2e0773 100644
--- a/doc/man-sections/=
management-options=2Erst
+++ b/doc/man-sections/management-options=2Erst
@@=
 -14,6 +14,7 @@
     management socket-name unix pw-file  # (recommended)
 =
    management IP port                   # (INSECURE)
     management IP po=
rt pw-file           #
+    management script unix-script
 
   ``pw-file``,=
 if specified, is a password file where the password must
   be on first li=
ne=2E Instead of a filename it can use the keyword stdin
@@ -25,6 +26,14 @@=

   ``--management-client-user`` and ``--management-client-group``
   direc=
tives to restrict access=2E
 
+  When the variant :code:`unix-script` is us=
ed, OpenVPN will start the
+  specified script on startup and enable ``--ma=
nagement-hold``=2E
+  OpenVPN will generate a random path for the unix sock=
et
+  and management password=2E These are passed as environment
+  variabl=
es :code:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_PASSWORD`
+  to the script =
when being started=2E When OpenVPN terminates it sends
+  a :code:`SIGINT` =
signal to the running script=2E
+
   The management interface provides a sp=
ecial mode where the TCP
   management link can operate over the tunnel its=
elf=2E To enable this mode,
   set IP to ``tunnel``=2E Tunnel mode will cau=
se the management interface to
@@ -127,10 +136,11 @@
   (client-only)=2E
 
=
 --management-signal
-  Send SIGUSR1 signal to OpenVPN if management sessio=
n disconnects=2E This
-  is useful when you wish to disconnect an OpenVPN s=
ession on user logoff=2E
-  For ``--management-client`` this option is not =
needed since a disconnect
-  will always generate a :code:`SIGTERM`=2E
+  S=
end :code:`SIGUSR1` signal to OpenVPN if management session disconnects=2E
=
+  This is useful when you wish to disconnect an OpenVPN session on user
+ =
 logoff=2E For ``--management-client`` or ``--management`` with
+  :code:`u=
nixscript` this option has no effect since a disconnect will
+  always trig=
ger sending a :code:`SIGTERM`=2E
 
 --management-up-down
   Report tunnel u=
p/down events to management interface=2E
diff --git a/doc/management-notes=
=2Etxt b/doc/management-notes=2Etxt
index 412b79b=2E=2E325f8bd 100644
--- a=
/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -35,6 +35,1=
0 @@
 you can telnet to the management port (make sure to use
 a telnet cli=
ent which understands "raw" mode)=2E
 
+When password authentication is ena=
bled, the management interface
+will require sending the password on its ow=
n line after establishing
+the connection=2E
+
 Once connected to the manag=
ement port, you can use
 the "help" command to list all commands=2E
 
diff =
--git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 9306a96=2E=2Eac86=
f97 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -4341,1=
9 +4341,62 @@
     }
 }
 
+void
+run_management_script(struct context *c)
+=
{
+#if UNIX_SOCK_SUPPORT
+    struct gc_arena gc =3D gc_new();
+    struct =
argv argv =3D argv_new();
+    struct env_set *env =3D env_set_create(&gc);=

+
+    setenv_str(env, "MANAGEMENT_USER", management->settings=2Eup=2Euser=
name);
+    setenv_str(env, "MANAGEMENT_PASSWORD", management->settings=2Eu=
p=2Epassword);
+    setenv_str(env, "MANAGEMENT_SOCKET", c->options=2Emanag=
ement_addr);
+
+    argv_printf(&argv, "%s", c->options=2Emanagement_script=
);
+
+    int flags =3D S_NOWAITPID | S_SCRIPT | S_FATAL;
+    int *pid =3D=
 &management->connection=2Eunix_script_pid;
+    const char *msg_prefix =3D=
 "WARNING: Failed running management unix-script";
+    *pid =3D openvpn_ex=
ecve_check(&argv, env, flags, msg_prefix);
+
+    if (!openvpn_waitpid_chec=
k(*pid, msg_prefix, M_FATAL))
+    {
+        *pid =3D 0;
+    }
+
+    arg=
v_free(&argv);
+    gc_free(&gc);
+#else
+    msg(M_FATAL, "ERROR: Manageme=
nt unix-socket support is not available on this platform");
+#endif
+}
+
 b=
ool
 open_management(struct context *c)
 {
     /* initialize management la=
yer */
     if (management)
     {
+        unsigned int flags =3D c->optio=
ns=2Emanagement_flags;
+        if (flags & MF_UNIX_SOCK_SCRIPT)
+        {=

+            /* This creates a filename that should be unguessable */
+   =
         char sockname[64] =3D { 0 };
+            snprintf(sockname, sizeo=
f(sockname),
+                     PACKAGE_NAME "_omi_%08" PRIx64 "%08" PRI=
x64 "=2Esock",
+                     get_random(), get_random());
+
+      =
      c->options=2Emanagement_addr =3D platform_gen_path(platform_get_tmp_d=
ir(), sockname, &c->gc);
+        }
+
         if (c->options=2Emanagement_=
addr)
         {
-            unsigned int flags =3D c->options=2Emanagemen=
t_flags;
             if (c->options=2Emode =3D=3D MODE_SERVER)
           =
  {
                 flags |=3D MF_SERVER;
             }
+
             if=
 (management_open(
                     management, c->options=2Emanagement=
_addr, c->options=2Emanagement_port,
                     c->options=2Emana=
gement_user_pass, c->options=2Emanagement_client_user,
@@ -4365,6 +4408,11 =
@@
                                      NULL);
             }
 
+         =
   if (flags & MF_UNIX_SOCK_SCRIPT)
+            {
+                run_man=
agement_script(c);
+            }
+
             /* initial management hold=
, called early, before first context initialization */
             do_hold=
(0);
             if (IS_SIG(c))
diff --git a/src/openvpn/manage=2Ec b/src/=
openvpn/manage=2Ec
index 0aef2d4=2E=2E1fa3738 100644
--- a/src/openvpn/mana=
ge=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -46,6 +46,7 @@
 #include "multi=2Eh"=

 
 #include "memdbg=2Eh"
+#include "run_command=2Eh"
 
 #ifdef ENABLE_PKCS=
11
 #include "pkcs11=2Eh"
@@ -333,10 +334,12 @@
 man_delete_unix_socket(str=
uct management *man)
 {
 #if UNIX_SOCK_SUPPORT
-    if ((man->settings=2Efl=
ags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
+    if (=
(man->settings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_U=
NIX_SOCK
+        || man->settings=2Eflags & MF_UNIX_SOCK_SCRIPT)
     {
  =
       socket_delete_unix(&man->settings=2Elocal_unix);
     }
+
 #endif
 }=

 
@@ -2195,10 +2198,18 @@
             }
         }
 
+        if (man->se=
ttings=2Eflags & MF_UNIX_SOCK_SCRIPT && !man_password_needed(man))
+       =
 {
+            msg(D_MANAGEMENT, "MANAGEMENT: Triggering exit on unix-scri=
pt disconnect");
+            throw_signal_soft(SIGTERM, "management-exit")=
;
+        }
+
         if (man->settings=2Eflags & MF_CONNECT_AS_CLIENT)
 =
        {
-            msg(D_MANAGEMENT, "MANAGEMENT: Triggering management=
 exit");
-            throw_signal_soft(SIGTERM, "management-exit");
+     =
       {
+                msg(D_MANAGEMENT, "MANAGEMENT: Triggering managem=
ent exit");
+                throw_signal_soft(SIGTERM, "management-exit");=

+            }
         }
         else
         {
@@ -2643,6 +2654,15 @@
=
         {
             get_user_pass(&ms->up, pass_file, "Management", GET=
_USER_PASS_PASSWORD_ONLY);
         }
+        else if (ms->flags & MF_UNIX=
_SOCK_SCRIPT)
+        {
+            /* Set random password=2E The passwor=
d is only
+             * alphanumerical [0-9a-f] but still has 128 bit of =
randomness,
+             * which is more than enough */
+            snpri=
ntf(ms->up=2Epassword, sizeof(ms->up=2Epassword),
+                     "%"=
 PRIx64 "%" PRIx64, get_random(), get_random());
+            ms->up=2Edefi=
ned =3D true;
+        }
 
 #if UNIX_SOCK_SUPPORT
         /*
@@ -2788,6 +2=
808,13 @@
         man_close_socket(man, mc->sd_cli);
     }
 
+#if UNIX_SO=
CK_SUPPORT
+    if (mc->unix_script_pid)
+    {
+        kill(mc->unix_scri=
pt_pid, SIGINT);
+    }
+#endif
+
     command_line_free(mc->in);
     buff=
er_list_free(mc->out);
 
@@ -3447,6 +3474,17 @@
                 break;
   =
          }
 
+            /* if unix-script is in use, the script might ha=
ve exited
+             * while we are waiting for it to connect */
+      =
      const char *msg_prefix =3D "WARNING: Failed running management unix-s=
cript";
+
+            if (man->connection=2Eunix_script_pid
+             =
   && !openvpn_waitpid_check(man->connection=2Eunix_script_pid, msg_prefix,=
 M_FATAL))
+            {
+                status =3D -1;
+                =
break;
+            }
+
             if (status > 0)
             {
       =
          break;
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=
=2Eh
index 1e7855d=2E=2E31577e4 100644
--- a/src/openvpn/manage=2Eh
+++ b/s=
rc/openvpn/manage=2Eh
@@ -42,6 +42,7 @@
 #define MF_EXTERNAL_CERT          =
(1u << 15)
 #define MF_EXTERNAL_KEY_PSSPAD    (1u << 16)
 #define MF_EXTERN=
AL_KEY_DIGEST    (1u << 17)
+#define MF_UNIX_SOCK_SCRIPT       (1u << 18)
 =

 #ifdef ENABLE_MANAGEMENT
 
@@ -327,6 +328,9 @@
     int fdtosend;
     in=
t lastfdreceived;
 #endif
+#if UNIX_SOCK_SUPPORT
+    pid_t unix_script_pid=
;
+#endif
     int client_version;
 };
 
diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec
index 6664c73=2E=2Ed839b59 100644
--- a/src/=
openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1726,7 +1726,7 @@
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
@@ -4311,7 +4311,7 @=
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
@@ -4321,7 +4321,16 @@
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
index d34=
7830=2E=2E4cd9ef5 100644
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
Gerrit-PatchSet: 12
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
tion: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--QpGYEnw5uD8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #12</strong> to this change=2E</p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">Vie=
w Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add unix-script functionality to the --manage=
ment feature<br><br>This allows a script that handles management input/outp=
ut to<br>be started alongside OpenVPN simpler in small deployments=2E<br><b=
r>Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M doc/man-sections/manageme=
nt-options=2Erst<br>M doc/management-notes=2Etxt<br>M src/openvpn/init=2Ec<=
br>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/op=
tions=2Ec<br>M src/openvpn/options=2Eh<br>7 files changed, 126 insertions(+=
), 11 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/52/1852/12</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man=
-sections/management-options=2Erst b/doc/man-sections/management-options=2E=
rst</span><br><span>index 8dad52b=2E=2Ee2e0773 100644</span><br><span>--- a=
/doc/man-sections/management-options=2Erst</span><br><span>+++ b/doc/man-se=
ctions/management-options=2Erst</span><br><span>@@ -14,6 +14,7 @@</span><br=
><span>     management socket-name unix pw-file  # (recommended)</span><br>=
<span>     management IP port                   # (INSECURE)</span><br><spa=
n>     management IP port pw-file           #</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    management script unix-script</span><br><span=
> </span><br><span>   ``pw-file``, if specified, is a password file where t=
he password must</span><br><span>   be on first line=2E Instead of a filena=
me it can use the keyword stdin</span><br><span>@@ -25,6 +26,14 @@</span><b=
r><span>   ``--management-client-user`` and ``--management-client-group``</=
span><br><span>   directives to restrict access=2E</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  When the variant :code:`=
unix-script` is used, OpenVPN will start the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  specified script on startup and enable ``--manag=
ement-hold``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Op=
enVPN will generate a random path for the unix socket</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  and management password=2E These are pa=
ssed as environment</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  variables :code:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_PASSWORD`</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  to the script when being s=
tarted=2E When OpenVPN terminates it sends</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  a :code:`SIGINT` signal to the running script=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   T=
he management interface provides a special mode where the TCP</span><br><sp=
an>   management link can operate over the tunnel itself=2E To enable this =
mode,</span><br><span>   set IP to ``tunnel``=2E Tunnel mode will cause the=
 management interface to</span><br><span>@@ -127,10 +136,11 @@</span><br><s=
pan>   (client-only)=2E</span><br><span> </span><br><span> --management-sig=
nal</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Send SIGUSR1 sig=
nal to OpenVPN if management session disconnects=2E This</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  is useful when you wish to disconnect =
an OpenVPN session on user logoff=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  For ``--management-client`` this option is not needed sinc=
e a disconnect</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  will =
always generate a :code:`SIGTERM`=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  Send :code:`SIGUSR1` signal to OpenVPN if management ses=
sion disconnects=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  This is useful when you wish to disconnect an OpenVPN session on user</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  logoff=2E For ``--man=
agement-client`` or ``--management`` with</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  :code:`unixscript` this option has no effect since =
a disconnect will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
always trigger sending a :code:`SIGTERM`=2E</span><br><span> </span><br><sp=
an> --management-up-down</span><br><span>   Report tunnel up/down events to=
 management interface=2E</span><br><span>diff --git a/doc/management-notes=
=2Etxt b/doc/management-notes=2Etxt</span><br><span>index 412b79b=2E=2E325f=
8bd 100644</span><br><span>--- a/doc/management-notes=2Etxt</span><br><span=
>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -35,6 +35,10 @@</span>=
<br><span> you can telnet to the management port (make sure to use</span><b=
r><span> a telnet client which understands &quot;raw&quot; mode)=2E</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+When pass=
word authentication is enabled, the management interface</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+will require sending the password on i=
ts own line after establishing</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+the connection=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> Once connected to the management port, you can u=
se</span><br><span> the &quot;help&quot; command to list all commands=2E</s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/init=2Ec b/src/ope=
nvpn/init=2Ec</span><br><span>index 9306a96=2E=2Eac86f97 100644</span><br><=
span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec<=
/span><br><span>@@ -4341,19 +4341,62 @@</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+run_manage=
ment_script(struct context *c)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if UNI=
X_SOCK_SUPPORT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct argv argv =3D argv_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct env_set *env =3D env_set_create(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(env, &quot;MANAGE=
MENT_USER&quot;, management-&gt;settings=2Eup=2Eusername);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(env, &quot;MANAGEMENT=
_PASSWORD&quot;, management-&gt;settings=2Eup=2Epassword);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(env, &quot;MANAGEMENT=
_SOCKET&quot;, c-&gt;options=2Emanagement_addr);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    argv_printf(&amp;argv, &quot;%s&quot;, c-&gt;options=2Emanage=
ment_script);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int flags =3D S_NOWAI=
TPID | S_SCRIPT | S_FATAL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int *pid =3D &amp;management-&gt;connection=2Eunix_script_pid;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *msg_p=
refix =3D &quot;WARNING: Failed running management unix-script&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    *pid =3D openvpn_exec=
ve_check(&amp;argv, env, flags, msg_prefix);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!openvpn_waitpid_check(*pid, msg_prefix, M_FATAL))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        *pid =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  argv_free(&amp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
M_FATAL, &quot;ERROR: Management unix-socket support is not available on th=
is platform&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><b=
r><span> open_management(struct context *c)</span><br><span> {</span><br><s=
pan>     /* initialize management layer */</span><br><span>     if (managem=
ent)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        unsigned int flags =3D c-&gt;options=2Emanagement_flags;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp=
; MF_UNIX_SOCK_SCRIPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     /* This creates a filename that should be unguessable */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            char sockname[64] =3D=
 { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
snprintf(sockname, sizeof(sockname),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                     PACKAGE_NAME &quot;_omi_%08&quot; PRI=
x64 &quot;%08&quot; PRIx64 &quot;=2Esock&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                     get_random(), get_random()=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;options=2Emanageme=
nt_addr =3D platform_gen_path(platform_get_tmp_dir(), sockname, &amp;c-&gt;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>        =
 if (c-&gt;options=2Emanagement_addr)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            unsigned int flags =
=3D c-&gt;options=2Emanagement_flags;</span><br><span>             if (c-&g=
t;options=2Emode =3D=3D MODE_SERVER)</span><br><span>             {</span><=
br><span>                 flags |=3D MF_SERVER;</span><br><span>           =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>             if (management_open(</span><br><span>                     man=
agement, c-&gt;options=2Emanagement_addr, c-&gt;options=2Emanagement_port,<=
/span><br><span>                     c-&gt;options=2Emanagement_user_pass, =
c-&gt;options=2Emanagement_client_user,</span><br><span>@@ -4365,6 +4408,11=
 @@</span><br><span>                                      NULL);</span><br>=
<span>             }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (flags &amp; MF_UNIX_SOCK_SCRIPT)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                run_management_sc=
ript(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
             /* initial management hold, called early, before first context=
 initialization */</span><br><span>             do_hold(0);</span><br><span=
>             if (IS_SIG(c))</span><br><span>diff --git a/src/openvpn/manag=
e=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 0aef2d4=2E=2E1fa3738 1=
00644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/sr=
c/openvpn/manage=2Ec</span><br><span>@@ -46,6 +46,7 @@</span><br><span> #in=
clude &quot;multi=2Eh&quot;</span><br><span> </span><br><span> #include &qu=
ot;memdbg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;run_command=2Eh&quot;</span><br><span> </span><br><span> #if=
def ENABLE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&quot;</span><b=
r><span>@@ -333,10 +334,12 @@</span><br><span> man_delete_unix_socket(struc=
t management *man)</span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPOR=
T</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((man-&gt;set=
tings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_S=
OCK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((man-&g=
t;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_U=
NIX_SOCK</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || =
man-&gt;settings=2Eflags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>     {<=
/span><br><span>         socket_delete_unix(&amp;man-&gt;settings=2Elocal_u=
nix);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> #endif</span><br><span> }</span><br><span> </spa=
n><br><span>@@ -2195,10 +2198,18 @@</span><br><span>             }</span><b=
r><span>         }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (man-&gt;settings=2Eflags &amp; MF_UNIX_SOCK_SC=
RIPT &amp;&amp; !man_password_needed(man))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(D_MANAGEMENT, &quot;MANAGEMENT: Triggering exi=
t on unix-script disconnect&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            throw_signal_soft(SIGTERM, &quot;management-exi=
t&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
      if (man-&gt;settings=2Eflags &amp; MF_CONNECT_AS_CLIENT)</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     msg(D_MANAGEMENT, &quot;MANAGEMENT: Triggering management exit&quot;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            throw_sig=
nal_soft(SIGTERM, &quot;management-exit&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                msg(D_MANAGEMENT, &quot;MANAGEMENT: T=
riggering management exit&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                throw_signal_soft(SIGTERM, &quot;management-e=
xit&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span>         }</span><br><span>         else</span><br><s=
pan>         {</span><br><span>@@ -2643,6 +2654,15 @@</span><br><span>     =
    {</span><br><span>             get_user_pass(&amp;ms-&gt;up, pass_file,=
 &quot;Management&quot;, GET_USER_PASS_PASSWORD_ONLY);</span><br><span>    =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else =
if (ms-&gt;flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            /* Set random password=2E The password is only</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+             * alphanu=
merical [0-9a-f] but still has 128 bit of randomness,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             * which is more than enough =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            snpri=
ntf(ms-&gt;up=2Epassword, sizeof(ms-&gt;up=2Epassword),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                     &quot;%&quot; PRIx=
64 &quot;%&quot; PRIx64, get_random(), get_random());</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ms-&gt;up=2Edefined =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span> </span><br><span> #if UNIX_SOCK_SUPPORT</span><br><span>         /*=
</span><br><span>@@ -2788,6 +2808,13 @@</span><br><span>         man_close_=
socket(man, mc-&gt;sd_cli);</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mc-&gt;unix_scri=
pt_pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        kill(mc-&gt;unix_s=
cript_pid, SIGINT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     comma=
nd_line_free(mc-&gt;in);</span><br><span>     buffer_list_free(mc-&gt;out);=
</span><br><span> </span><br><span>@@ -3447,6 +3474,17 @@</span><br><span> =
                break;</span><br><span>             }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* if unix-=
script is in use, the script might have exited</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+             * while we are waiting for it to co=
nnect */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 const char *msg_prefix =3D &quot;WARNING: Failed running management unix-s=
cript&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;co=
nnection=2Eunix_script_pid</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                &amp;&amp; !openvpn_waitpid_check(man-&gt;connection=
=2Eunix_script_pid, msg_prefix, M_FATAL))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                status =3D -1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                break;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>             if (status &gt; 0)</s=
pan><br><span>             {</span><br><span>                 break;</span>=
<br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</spa=
n><br><span>index 1e7855d=2E=2E31577e4 100644</span><br><span>--- a/src/ope=
nvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><spa=
n>@@ -42,6 +42,7 @@</span><br><span> #define MF_EXTERNAL_CERT          (1u =
&lt;&lt; 15)</span><br><span> #define MF_EXTERNAL_KEY_PSSPAD    (1u &lt;&lt=
; 16)</span><br><span> #define MF_EXTERNAL_KEY_DIGEST    (1u &lt;&lt; 17)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MF_UNIX_SOCK_=
SCRIPT       (1u &lt;&lt; 18)</span><br><span> </span><br><span> #ifdef ENA=
BLE_MANAGEMENT</span><br><span> </span><br><span>@@ -327,6 +328,9 @@</span>=
<br><span>     int fdtosend;</span><br><span>     int lastfdreceived;</span=
><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    pid_t unix_script_pid;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span>     int client_version;</span><br><span> };=
</span><br><span> </span><br><span>diff --git a/src/openvpn/options=2Ec b/s=
rc/openvpn/options=2Ec</span><br><span>index 6664c73=2E=2Ed839b59 100644</s=
pan><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openv=
pn/options=2Ec</span><br><span>@@ -1726,7 +1726,7 @@</span><br><span>      =
* Check for consistency of management options</span><br><span>      */</spa=
n><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (!options-&gt;management_addr</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!options-&gt;management_addr &amp=
;&amp; !(options-&gt;management_flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br>=
<span>         &amp;&amp; (options-&gt;management_flags</span><br><span>   =
          || options-&gt;management_log_history_cache !=3D defaults=2Emanag=
ement_log_history_cache))</span><br><span>     {</span><br><span>@@ -4311,7=
 +4311,7 @@</span><br><span>     else if (streq(p[0], &quot;management&quot=
;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><span>     {=
</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (streq(p[2], &quot;unix&qu=
ot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (st=
req(p[2], &quot;unix&quot;) || streq(p[2], &quot;unix-script&quot;))</span>=
<br><span>         {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><span=
>             options-&gt;management_flags |=3D MF_UNIX_SOCK;</span><br><sp=
an>@@ -4321,7 +4321,16 @@</span><br><span> #endif</span><br><span>         =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      options-&gt;management_addr =3D p[1];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (streq(p[2], &quot;unix-script&quot;))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;managem=
ent_flags |=3D MF_UNIX_SOCK_SCRIPT | MF_HOLD;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            set_user_script(options, &amp;options=
-&gt;management_script, p[1],</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                            &quot;management unix-script&quot;, f=
alse);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            options-&gt;management_addr =
=3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span>         options-&gt;management_port =3D p[2];</span><br><s=
pan>         if (p[3])</span><br><span>         {</span><br><span>diff --gi=
t a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index=
 d347830=2E=2E4cd9ef5 100644</span><br><span>--- a/src/openvpn/options=2Eh<=
/span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -446,6 +44=
6,8 @@</span><br><span>     const char *management_addr;</span><br><span>  =
   const char *management_port;</span><br><span>     const char *management=
_user_pass;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** =
Script executed to talk to the management interface */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *management_script;</span=
><br><span>     int management_log_history_cache;</span><br><span>     int =
management_echo_buffer_size;</span><br><span>     int management_state_buff=
er_size;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1852?usp=3Demail">change 1852</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I307e64079f436aa782f7e2=
4bfff665a545ad2fa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1852 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>

</body></html>
--QpGYEnw5uD8=--


--===============4473604145427433683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4473604145427433683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4473604145427433683==--

