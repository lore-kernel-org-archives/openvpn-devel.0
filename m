Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4314CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KBa0T9c0PIxogvZ5X7F+TKzRtImv5sF/MFpkUinHyA4=; b=HOJY3XAtFI+UQ4OGmpDWMpsnB/
	Rf3nDykoMMjGchb44MPdny6yOwIcXwlFcAYDSLVb8iHqiDvbHLsdhXRDvBGaOjWGw5AIZ/PynYTcU
	zWBEt669fchO/WdU9toFDR48EPl3XqGRPpgFP1WNvmfwODJDUwSuHeegeT2sA7skyiBo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDmaC-0006O3-Sr;
	Mon, 05 Oct 2026 17:34:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDmaB-0006Nw-5t
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 17:34:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6qm+aF3shbsqLjyRhRazu0Nr8pLOCncipmKBikuhp3Y=; b=PyxA700kjgRlyztrDpA3gSwCR1
 q27ONmRa9IEqKh4EqMbDDu9kavrDBsTf6NffUnnICuhoHXPfnb5qKE0C9k9xGZr1/3H/hKfOuYeCW
 wSFy/snXMAHJ4J1VybY6Y5/qEtfqfN6yCCJLg2o23MIdOiGPXpKmr4N2nn5un5GIuDHc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6qm+aF3shbsqLjyRhRazu0Nr8pLOCncipmKBikuhp3Y=; b=E
 tGJjFRiUZCRz172prTKq0sG/nR0qF+ASgBd5/bCj+5ZaBcH7l1NlW9s+sZ0jW9DNqE5D+AXTG/6y3
 jkrG6rdnHOhVEauRuPOPcMKT79NYvHSFvomYknVI3PKUsZdw5APJf0KcIGzpovujUDhUl17WVC6S7
 6gzpXFjFg4IjSbm4=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDma9-0005WE-Pp for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 17:34:35 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so979768f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791221667; x=1791826467; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6qm+aF3shbsqLjyRhRazu0Nr8pLOCncipmKBikuhp3Y=;
 b=bOrIWwCPa48ht2WMbsAHE9Tcon3p5zWEPSNMOHSPipwUkiM//7GJaT7677w8J6Ww5R
 lCX05gr2T2Y+QJwKe5mvaBaVwzhUJK5cQsTrxA5OLko/XxAkEFH+0B2NezaxRhae1TiL
 na2l7x+2LyamZRwFf2RfIRNWptDM88zjqjeHKTSrVBHYN0bYRvW7TBNRw1lI/pmdnGSZ
 z7cmESVex3atv5yC/gvb984NavBToMeMGD6sZC1Oa6M6vjVt5HRNvp1ZhRE83kZNB6Hh
 Ch381P9Gf57b2fykfMjwv+CYr4zr2NQ09zUtj1fnPYawjWks3T50QUK7mKioRZzUT4Uq
 UA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791221667; x=1791826467;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6qm+aF3shbsqLjyRhRazu0Nr8pLOCncipmKBikuhp3Y=;
 b=e5AOIXoCOt9ttr/4qDn5K9a7ANp4icu1RTBhPs1vtfkqoIu/8ov6j8EVtp/ytQvCn9
 XE+NSpiW8MV2I0D6MTdqM0es9YPsHSMpEX5N9A6TWfGvpV+HQp97AX7ENXe2TxzfoQSx
 9ABJPJy/wygExvE7Vpzp98Ojt4/KVVX12yHhauI6Sm0NAXWR0T/wn82IGVxou9cGKY/R
 DUVWozM6jHZ7mC+m1UZBwz0yzlRTQ5DZfYvuhzd2nKzyclBybSx4TydeS54b4JR8xg1l
 zXxuah8ARg646w7/YKtmLS6EuVzuDPtmiaNNmNXuF6SIdAzgB51krj97TaZ8K4lunVzf
 DTbw==
X-Gm-Message-State: AFq9FYJ2IT1DBBQeSKCMdvExIpmir40iNWlqmqndA7SWs63JiJ0dfF9F
 hxE++2i+4GGDN6uuUNwlgHF5Hm8jOgdA1tTTD41IrPetKeUxAkLJMY+08jVGV/KQLjFjGcARXE/
 zUIylGNh2JIcD3Q9egc/eHd4nic+iDr0yMPBZ0dfaGMAnU8phErg+FFlp4IGRnhaSVWOy
X-Gm-Gg: AYBFou0cKq5A1nFm4Ain/l2idMdnDNSLefwb0/OT3YCYSfK7P1A8cxlVBgLXnp2yp+d
 ADgycMGC7xTg5I0XInVxhlFQsj4tTWlu9X4p3H+s8wWMS+ttWHFawA/z43oknH5Bub9+s6icjEO
 fECrbbCPYnofGTJleyzqWPME+J0CmhEJT2LHgKOu0++DPlrc8/+TlU1JR5U5NV7rukM3wVp3opw
 YH7u39fX0K/eT+J9hRF4BJNDKqriunDaKf07hoDQYJKngFjKXwaCrEuqw53le2rgvF5DDlMeqGs
 RTiGtY/9vSDidSQwFtP81imhAJIKMOMZGSeYvQziDW0cJ6jmZlEBoBgfX51SwuQZmrfCXPQGbMB
 F+dV/7G2GxI1vQxNPlORmHv3wLs/9EcAYW7V+z7F+HPQX6c4DfH243loojUOVp7EO6v7//TPcR+
 xu0+QTQ2VV3OlKdgnfp48RHazD4fB4INs445L4TnB9LFPrWqOinersY/5sJ7g7PoIDRuGpuwqeI
 zlLuCEop+NMoTQP/inr/AkLs2ebkxqc1PO4B8tuZKDK1GyLLs0HV54CkMnCkCJQ/xgYNXaauiBB
 iYlsr59aZmq1n4Ki9YTkyB8eAAbs9oA0d3BJNPA1kWyMqfQw9T7K1NiCuUP+p4NYtoYKT6w=
X-Received: by 2002:a05:6000:4211:b0:48a:f8fb:cd49 with SMTP id
 ffacd0b85a97d-48c47fd4540mr14236038f8f.22.1791221666792; 
 Mon, 05 Oct 2026 10:34:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c63550d1esm4740222f8f.18.2026.10.05.10.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 10:34:26 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 17:34:23 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 4dd2486176cb3cc33c805923debbe3776b501e2a
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7dc7deb049619988fe6ffaf9d40d8b051c41dde5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDma9-0005WE-Pp
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
Content-Type: multipart/mixed; boundary="===============5093566307746352010=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5093566307746352010==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hZF2ZpH/e70="; charset=UTF-8

--hZF2ZpH/e70=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1852?usp=3Demail

to look at the new patch set (#11)=2E

The following=
 approvals got outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojo=
caru


Change subject: Add unix-script functionality to the --management fe=
ature
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add uni=
x-script functionality to the --management feature

This allows a script th=
at handles management input/output to
be started alongside OpenVPN simpler =
in small deployments=2E

Change-Id: I307e64079f436aa782f7e24bfff665a545ad2f=
a0
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M doc/man-sections/=
management-options=2Erst
M doc/management-notes=2Etxt
M src/openvpn/init=2E=
c
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/options=
=2Ec
M src/openvpn/options=2Eh
7 files changed, 114 insertions(+), 11 delet=
ions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/52/1852/11

diff --git a/doc/man-sections/management-options=2Erst b/doc/=
man-sections/management-options=2Erst
index 8dad52b=2E=2Ee2e0773 100644
---=
 a/doc/man-sections/management-options=2Erst
+++ b/doc/man-sections/managem=
ent-options=2Erst
@@ -14,6 +14,7 @@
     management socket-name unix pw-fil=
e  # (recommended)
     management IP port                   # (INSECURE)
 =
    management IP port pw-file           #
+    management script unix-scri=
pt
 
   ``pw-file``, if specified, is a password file where the password mu=
st
   be on first line=2E Instead of a filename it can use the keyword stdi=
n
@@ -25,6 +26,14 @@
   ``--management-client-user`` and ``--management-cli=
ent-group``
   directives to restrict access=2E
 
+  When the variant :code=
:`unix-script` is used, OpenVPN will start the
+  specified script on start=
up and enable ``--management-hold``=2E
+  OpenVPN will generate a random pa=
th for the unix socket
+  and management password=2E These are passed as en=
vironment
+  variables :code:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_PASSWOR=
D`
+  to the script when being started=2E When OpenVPN terminates it sends
=
+  a :code:`SIGINT` signal to the running script=2E
+
   The management int=
erface provides a special mode where the TCP
   management link can operate=
 over the tunnel itself=2E To enable this mode,
   set IP to ``tunnel``=2E =
Tunnel mode will cause the management interface to
@@ -127,10 +136,11 @@
  =
 (client-only)=2E
 
 --management-signal
-  Send SIGUSR1 signal to OpenVPN =
if management session disconnects=2E This
-  is useful when you wish to dis=
connect an OpenVPN session on user logoff=2E
-  For ``--management-client``=
 this option is not needed since a disconnect
-  will always generate a :co=
de:`SIGTERM`=2E
+  Send :code:`SIGUSR1` signal to OpenVPN if management ses=
sion disconnects=2E
+  This is useful when you wish to disconnect an OpenVP=
N session on user
+  logoff=2E For ``--management-client`` or ``--managemen=
t`` with
+  :code:`unixscript` this option has no effect since a disconnect=
 will
+  always trigger sending a :code:`SIGTERM`=2E
 
 --management-up-dow=
n
   Report tunnel up/down events to management interface=2E
diff --git a/d=
oc/management-notes=2Etxt b/doc/management-notes=2Etxt
index 412b79b=2E=2E3=
25f8bd 100644
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
dex 9306a96=2E=2E5a5f393 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvp=
n/init=2Ec
@@ -4341,19 +4341,62 @@
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
+        }
+
         if (c->=
options=2Emanagement_addr)
         {
-            unsigned int flags =3D c=
->options=2Emanagement_flags;
             if (c->options=2Emode =3D=3D MOD=
E_SERVER)
             {
                 flags |=3D MF_SERVER;
           =
  }
+
             if (management_open(
                     management, c-=
>options=2Emanagement_addr, c->options=2Emanagement_port,
                 =
    c->options=2Emanagement_user_pass, c->options=2Emanagement_client_user,=

@@ -4365,6 +4408,11 @@
                                      NULL);
      =
       }
 
+            if (flags & MF_UNIX_SOCK_SCRIPT)
+            {
+  =
              run_management_script(c);
+            }
+
             /* in=
itial management hold, called early, before first context initialization */=

             do_hold(0);
             if (IS_SIG(c))
diff --git a/src/open=
vpn/manage=2Ec b/src/openvpn/manage=2Ec
index 0aef2d4=2E=2Ea5a7ae6 100644
-=
-- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -333,10 +333,12=
 @@
 man_delete_unix_socket(struct management *man)
 {
 #if UNIX_SOCK_SUPPO=
RT
-    if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT))=
 =3D=3D MF_UNIX_SOCK)
+    if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_=
CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK
+        || man->settings=2Eflags &=
 MF_UNIX_SOCK_SCRIPT)
     {
         socket_delete_unix(&man->settings=2El=
ocal_unix);
     }
+
 #endif
 }
 
@@ -2195,10 +2197,18 @@
             }
  =
       }
 
+        if (man->settings=2Eflags & MF_UNIX_SOCK_SCRIPT && !man=
_password_needed(man))
+        {
+            msg(D_MANAGEMENT, "MANAGEMEN=
T: Triggering exit on unix-script disconnect");
+            throw_signal_s=
oft(SIGTERM, "management-exit");
+        }
+
         if (man->settings=2E=
flags & MF_CONNECT_AS_CLIENT)
         {
-            msg(D_MANAGEMENT, "MA=
NAGEMENT: Triggering management exit");
-            throw_signal_soft(SIGT=
ERM, "management-exit");
+            {
+                msg(D_MANAGEMENT, =
"MANAGEMENT: Triggering management exit");
+                throw_signal_so=
ft(SIGTERM, "management-exit");
+            }
         }
         else
   =
      {
@@ -2643,6 +2653,15 @@
         {
             get_user_pass(&ms->u=
p, pass_file, "Management", GET_USER_PASS_PASSWORD_ONLY);
         }
+     =
   else if (ms->flags & MF_UNIX_SOCK_SCRIPT)
+        {
+            /* Set=
 random password=2E The password is only
+             * alphanumerical [0-=
9a-f] but still has 128 bit of randomness,
+             * which is more th=
an enough */
+            snprintf(ms->up=2Epassword, sizeof(ms->up=2Epassw=
ord),
+                     "%" PRIx64 "%" PRIx64, get_random(), get_random=
());
+            ms->up=2Edefined =3D true;
+        }
 
 #if UNIX_SOCK_SU=
PPORT
         /*
@@ -2788,6 +2807,13 @@
         man_close_socket(man, mc-=
>sd_cli);
     }
 
+#if UNIX_SOCK_SUPPORT
+    if (mc->unix_script_pid)
+  =
  {
+        kill(mc->unix_script_pid, SIGINT);
+    }
+#endif
+
     comma=
nd_line_free(mc->in);
     buffer_list_free(mc->out);
 
diff --git a/src/op=
envpn/manage=2Eh b/src/openvpn/manage=2Eh
index 1e7855d=2E=2E31577e4 100644=

--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -42,6 +42,7 @=
@
 #define MF_EXTERNAL_CERT          (1u << 15)
 #define MF_EXTERNAL_KEY_PS=
SPAD    (1u << 16)
 #define MF_EXTERNAL_KEY_DIGEST    (1u << 17)
+#define M=
F_UNIX_SOCK_SCRIPT       (1u << 18)
 
 #ifdef ENABLE_MANAGEMENT
 
@@ -327,6=
 +328,9 @@
     int fdtosend;
     int lastfdreceived;
 #endif
+#if UNIX_SO=
CK_SUPPORT
+    pid_t unix_script_pid;
+#endif
     int client_version;
 };=

 
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 60c=
2f5a=2E=2E231a835 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/op=
tions=2Ec
@@ -1726,7 +1726,7 @@
      * Check for consistency of management=
 options
      */
 #ifdef ENABLE_MANAGEMENT
-    if (!options->management_a=
ddr
+    if (!options->management_addr && !(options->management_flags & MF_=
UNIX_SOCK_SCRIPT)
         && (options->management_flags
             || op=
tions->management_log_history_cache !=3D defaults=2Emanagement_log_history_=
cache))
     {
@@ -4311,7 +4311,7 @@
     else if (streq(p[0], "management"=
) && p[1] && p[2] && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL=
);
-        if (streq(p[2], "unix"))
+        if (streq(p[2], "unix") || st=
req(p[2], "unix-script"))
         {
 #if UNIX_SOCK_SUPPORT
             op=
tions->management_flags |=3D MF_UNIX_SOCK;
@@ -4321,7 +4321,16 @@
 #endif
 =
        }
 
-        options->management_addr =3D p[1];
+        if (streq(=
p[2], "unix-script"))
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
index d347830=2E=2E4cd9ef5 100644
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

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1852?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I307e64079f436aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
Gerrit=
-PatchSet: 11
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>

--hZF2ZpH/e70=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #11</strong> to this change=2E</p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">Vie=
w Change</a></p><p>The following approvals got outdated and were removed:
C=
ode-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">Add unix-script funct=
ionality to the --management feature<br><br>This allows a script that handl=
es management input/output to<br>be started alongside OpenVPN simpler in sm=
all deployments=2E<br><br>Change-Id: I307e64079f436aa782f7e24bfff665a545ad2=
fa0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M d=
oc/man-sections/management-options=2Erst<br>M doc/management-notes=2Etxt<br=
>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=
=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>7 files c=
hanged, 114 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1852/11</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/doc/man-sections/management-options=2Erst b/doc/man-sectio=
ns/management-options=2Erst</span><br><span>index 8dad52b=2E=2Ee2e0773 1006=
44</span><br><span>--- a/doc/man-sections/management-options=2Erst</span><b=
r><span>+++ b/doc/man-sections/management-options=2Erst</span><br><span>@@ =
-14,6 +14,7 @@</span><br><span>     management socket-name unix pw-file  # =
(recommended)</span><br><span>     management IP port                   # (=
INSECURE)</span><br><span>     management IP port pw-file           #</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    management script uni=
x-script</span><br><span> </span><br><span>   ``pw-file``, if specified, is=
 a password file where the password must</span><br><span>   be on first lin=
e=2E Instead of a filename it can use the keyword stdin</span><br><span>@@ =
-25,6 +26,14 @@</span><br><span>   ``--management-client-user`` and ``--man=
agement-client-group``</span><br><span>   directives to restrict access=2E<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
When the variant :code:`unix-script` is used, OpenVPN will start the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  specified script on star=
tup and enable ``--management-hold``=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  OpenVPN will generate a random path for the unix sock=
et</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and management =
password=2E These are passed as environment</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  variables :code:`MANAGEMENT_SOCKET`, :code:`MANAG=
EMENT_PASSWORD`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  to=
 the script when being started=2E When OpenVPN terminates it sends</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  a :code:`SIGINT` signal to=
 the running script=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>   The management interface provides a special mode whe=
re the TCP</span><br><span>   management link can operate over the tunnel i=
tself=2E To enable this mode,</span><br><span>   set IP to ``tunnel``=2E Tu=
nnel mode will cause the management interface to</span><br><span>@@ -127,10=
 +136,11 @@</span><br><span>   (client-only)=2E</span><br><span> </span><br=
><span> --management-signal</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  Send SIGUSR1 signal to OpenVPN if management session disconnects=2E=
 This</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  is useful when=
 you wish to disconnect an OpenVPN session on user logoff=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  For ``--management-client`` this o=
ption is not needed since a disconnect</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  will always generate a :code:`SIGTERM`=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  Send :code:`SIGUSR1` signal to O=
penVPN if management session disconnects=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  This is useful when you wish to disconnect an Ope=
nVPN session on user</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  logoff=2E For ``--management-client`` or ``--management`` with</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`unixscript` this opt=
ion has no effect since a disconnect will</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  always trigger sending a :code:`SIGTERM`=2E</span><=
br><span> </span><br><span> --management-up-down</span><br><span>   Report =
tunnel up/down events to management interface=2E</span><br><span>diff --git=
 a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>=
index 412b79b=2E=2E325f8bd 100644</span><br><span>--- a/doc/management-note=
s=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</span><br><span>@@=
 -35,6 +35,10 @@</span><br><span> you can telnet to the management port (ma=
ke sure to use</span><br><span> a telnet client which understands &quot;raw=
&quot; mode)=2E</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+When password authentication is enabled, the management inter=
face</span><br><span style=3D"color: hsl(120, 100%, 40%);">+will require se=
nding the password on its own line after establishing</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+the connection=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Once connected to the m=
anagement port, you can use</span><br><span> the &quot;help&quot; command t=
o list all commands=2E</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 9306a96=2E=2E5=
a5f393 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>++=
+ b/src/openvpn/init=2Ec</span><br><span>@@ -4341,19 +4341,62 @@</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+run_management_script(struct context *c)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct argv argv =3D argv_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct env_set *e=
nv =3D env_set_create(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set=
env_str(env, &quot;MANAGEMENT_USER&quot;, management-&gt;settings=2Eup=2Eus=
ername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_=
str(env, &quot;MANAGEMENT_PASSWORD&quot;, management-&gt;settings=2Eup=2Epa=
ssword);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_=
str(env, &quot;MANAGEMENT_SOCKET&quot;, c-&gt;options=2Emanagement_addr);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s&quot=
;, c-&gt;options=2Emanagement_script);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int flags =3D S_NOWAITPID | S_SCRIPT | S_FATAL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int *pid =3D &amp;management-&gt;conn=
ection=2Eunix_script_pid;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *msg_prefix =3D &quot;WARNING: Failed running manageme=
nt unix-script&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    *pid =3D openvpn_execve_check(&amp;argv, env, flags, msg_prefix);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!openvpn_waitpid_check(*pid, msg_=
prefix, M_FATAL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *pid =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    argv_free(&amp;argv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(M_FATAL, &quot;ERROR: Management unix-socket =
support is not available on this platform&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> bool</span><br><span> open_management(struct context *c)</=
span><br><span> {</span><br><span>     /* initialize management layer */</s=
pan><br><span>     if (management)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        unsigned int flags =3D c-&gt;=
options=2Emanagement_flags;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* This creates a filename that should =
be ungessuable */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          char sockname[64] =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            snprintf(sockname, sizeof(sockname),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     PACKAG=
E_NAME &quot;_omi_%08&quot; PRIx64 &quot;%08&quot; PRIx64 &quot;=2Esock&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
     get_random(), get_random());</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       c-&gt;options=2Emanagement_addr =3D platform_gen_path(platform_get_t=
mp_dir(), sockname, &amp;c-&gt;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>         if (c-&gt;options=2Emanagement_addr)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           unsigned int flags =3D c-&gt;options=2Emanagement_flags;</span><=
br><span>             if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</span><b=
r><span>             {</span><br><span>                 flags |=3D MF_SERVE=
R;</span><br><span>             }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>             if (management_open(</span><br>=
<span>                     management, c-&gt;options=2Emanagement_addr, c-&=
gt;options=2Emanagement_port,</span><br><span>                     c-&gt;op=
tions=2Emanagement_user_pass, c-&gt;options=2Emanagement_client_user,</span=
><br><span>@@ -4365,6 +4408,11 @@</span><br><span>                         =
             NULL);</span><br><span>             }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (flags &amp=
; MF_UNIX_SOCK_SCRIPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             run_management_script(c);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>             /* initial management hold, call=
ed early, before first context initialization */</span><br><span>          =
   do_hold(0);</span><br><span>             if (IS_SIG(c))</span><br><span>=
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><spa=
n>index 0aef2d4=2E=2Ea5a7ae6 100644</span><br><span>--- a/src/openvpn/manag=
e=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -333,=
10 +333,12 @@</span><br><span> man_delete_unix_socket(struct management *ma=
n)</span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if ((man-&gt;settings=2Eflags &a=
mp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if ((man-&gt;settings=2Efla=
gs &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        || man-&gt;settings=
=2Eflags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>     {</span><br><span>=
         socket_delete_unix(&amp;man-&gt;settings=2Elocal_unix);</span><br>=
<span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> #endif</span><br><span> }</span><br><span> </span><br><span>@@ -=
2195,10 +2197,18 @@</span><br><span>             }</span><br><span>        =
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (man-&gt;settings=2Eflags &amp; MF_UNIX_SOCK_SCRIPT &amp;&amp; =
!man_password_needed(man))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(D_MANAGEMENT, &quot;MANAGEMENT: Triggering exit on unix-script=
 disconnect&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            throw_signal_soft(SIGTERM, &quot;management-exit&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (man-&g=
t;settings=2Eflags &amp; MF_CONNECT_AS_CLIENT)</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_MANAG=
EMENT, &quot;MANAGEMENT: Triggering management exit&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            throw_signal_soft(SIGTERM=
, &quot;management-exit&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                msg(D_MANAGEMENT, &quot;MANAGEMENT: Triggering manage=
ment exit&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              throw_signal_soft(SIGTERM, &quot;management-exit&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span>         }</span><br><span>         else</span><br><span>         {</=
span><br><span>@@ -2643,6 +2653,15 @@</span><br><span>         {</span><br>=
<span>             get_user_pass(&amp;ms-&gt;up, pass_file, &quot;Managemen=
t&quot;, GET_USER_PASS_PASSWORD_ONLY);</span><br><span>         }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        else if (ms-&gt;flags=
 &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          /* Set random password=2E The password is only</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+             * alphanumerical [0-9a-f]=
 but still has 128 bit of randomness,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             * which is more than enough */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            snprintf(ms-&gt;up=2E=
password, sizeof(ms-&gt;up=2Epassword),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                     &quot;%&quot; PRIx64 &quot;%&quot;=
 PRIx64, get_random(), get_random());</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            ms-&gt;up=2Edefined =3D true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> </span><=
br><span> #if UNIX_SOCK_SUPPORT</span><br><span>         /*</span><br><span=
>@@ -2788,6 +2807,13 @@</span><br><span>         man_close_socket(man, mc-&=
gt;sd_cli);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (mc-&gt;unix_script_pid)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        kill(mc-&gt;unix_script_pid, SIGI=
NT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     command_line_free(m=
c-&gt;in);</span><br><span>     buffer_list_free(mc-&gt;out);</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/mana=
ge=2Eh</span><br><span>index 1e7855d=2E=2E31577e4 100644</span><br><span>--=
- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</sp=
an><br><span>@@ -42,6 +42,7 @@</span><br><span> #define MF_EXTERNAL_CERT   =
       (1u &lt;&lt; 15)</span><br><span> #define MF_EXTERNAL_KEY_PSSPAD    =
(1u &lt;&lt; 16)</span><br><span> #define MF_EXTERNAL_KEY_DIGEST    (1u &lt=
;&lt; 17)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MF=
_UNIX_SOCK_SCRIPT       (1u &lt;&lt; 18)</span><br><span> </span><br><span>=
 #ifdef ENABLE_MANAGEMENT</span><br><span> </span><br><span>@@ -327,6 +328,=
9 @@</span><br><span>     int fdtosend;</span><br><span>     int lastfdrece=
ived;</span><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    pid_t unix_script_pid;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span>     int client_version;</span><b=
r><span> };</span><br><span> </span><br><span>diff --git a/src/openvpn/opti=
ons=2Ec b/src/openvpn/options=2Ec</span><br><span>index 60c2f5a=2E=2E231a83=
5 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ =
b/src/openvpn/options=2Ec</span><br><span>@@ -1726,7 +1726,7 @@</span><br><=
span>      * Check for consistency of management options</span><br><span>  =
    */</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (!options-&gt;management_addr</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!options-&gt;management=
_addr &amp;&amp; !(options-&gt;management_flags &amp; MF_UNIX_SOCK_SCRIPT)<=
/span><br><span>         &amp;&amp; (options-&gt;management_flags</span><br=
><span>             || options-&gt;management_log_history_cache !=3D defaul=
ts=2Emanagement_log_history_cache))</span><br><span>     {</span><br><span>=
@@ -4311,7 +4311,7 @@</span><br><span>     else if (streq(p[0], &quot;manag=
ement&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><s=
pan>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (streq(p[2], &qu=
ot;unix&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (streq(p[2], &quot;unix&quot;) || streq(p[2], &quot;unix-script&quot=
;))</span><br><span>         {</span><br><span> #if UNIX_SOCK_SUPPORT</span=
><br><span>             options-&gt;management_flags |=3D MF_UNIX_SOCK;</sp=
an><br><span>@@ -4321,7 +4321,16 @@</span><br><span> #endif</span><br><span=
>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        options-&gt;management_addr =3D p[1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (streq(p[2], &quot;unix-script=
&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&=
gt;management_flags |=3D MF_UNIX_SOCK_SCRIPT | MF_HOLD;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            set_user_script(options, &a=
mp;options-&gt;management_script, p[1],</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                            &quot;management unix-scrip=
t&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;manage=
ment_addr =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span>         options-&gt;management_port =3D p[2];</s=
pan><br><span>         if (p[3])</span><br><span>         {</span><br><span=
>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><=
span>index d347830=2E=2E4cd9ef5 100644</span><br><span>--- a/src/openvpn/op=
tions=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ =
-446,6 +446,8 @@</span><br><span>     const char *management_addr;</span><b=
r><span>     const char *management_port;</span><br><span>     const char *=
management_user_pass;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /** Script executed to talk to the management interface */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const char *management_scr=
ipt;</span><br><span>     int management_log_history_cache;</span><br><span=
>     int management_echo_buffer_size;</span><br><span>     int management_=
state_buffer_size;</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">change 1852</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I307e64079f43=
6aa782f7e24bfff665a545ad2fa0 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1852 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>

</body></html>
--hZF2ZpH/e70=--


--===============5093566307746352010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5093566307746352010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5093566307746352010==--

