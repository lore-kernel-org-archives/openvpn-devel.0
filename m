Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA980606A32E
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=e8dUViC6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JiIrpe3D;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lB5DbmcL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D5yNp0hw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PUCsUDY3S6Jg3Ht8cTgtUgbmxC8G+YXHRE3EjjwFSj4=; b=e8dUViC6GnoZNMOBxdMkAhfP2W
	rGewxIz+7oDSRYIeLuQ4hOoSn/aDucSzI5CttisgGJI1vRvTY0AXtlQhu3iRIOsbSjgSecihmVj+M
	Iv2sp6gVgHUF6NiSBnRR78Q/LJSUmGTnzgr6eUZvPHjA/fXvp1wbyNlxLCIHSOWWW+BQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRqvS-000000005uk-1NOS;
	Fri, 13 Nov 2026 13:02:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRqvB-000000005uV-43Ik
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 13:02:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J8H5sWnUMgVUN6F10TKCOEnYfKDdKj37MRnqrSZpey4=; b=JiIrpe3D3hg9vk070GslpHGFWk
 t+Ylx19dhmy8/8i0aZEYj54StiQJ7nvIQ/AcpAazS+s+PErduvX1DiWmS3wGd3NQ/4C6/cPXdNHJP
 8c9B7o9/S51YL39//mcgJz04pmrEEjYDra6Hra0AzvyAANo2jQZWjpsQATUrP+WiPq28=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J8H5sWnUMgVUN6F10TKCOEnYfKDdKj37MRnqrSZpey4=; b=lB5DbmcL5Y6AnVEcUt373ZyPtV
 Jhyg8KEfuNmpt3xtDUGFQdJy/EYUqE1xnsyZvnT7wPk4XJKiu1w9drLtHEZNSfrs4eNlZddD8OA9J
 XfO3HoKKByBI2i/TCmpA4H/zhelKHELnhSGHk2tjZZD4qGO0+8k641XolMyvsBlpwUFc=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRqv9-000000004ZW-1HIf for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 13:02:25 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so5659095e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 05:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794574937; x=1795179737; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J8H5sWnUMgVUN6F10TKCOEnYfKDdKj37MRnqrSZpey4=;
 b=D5yNp0hwXQ7ukPFMDrBxQJfuA6g/3t7kiVY3M9cm78D1GxVQOPnpq1ddINZM4eaix1
 Ma45ZJ92FEo1QzOeuRl6AKGEWl5RKEe6UQn1QI0+KRSTTZ1gdGiZ1zSti6mbKiKcS3sL
 o5XGariCuzHnmfCQ/76Fc78Zz+TEABrwYzPunmIokCLgzkcy+9nC88etTYA1yhTvUeWi
 xDqWOak536BfBWJVkSgIT+T9v0GxzXIArfpigupsOd97wo6wG09V7CVWk1Sgnr1kix/b
 vt03L85V8c4BH5XE0DI8LZfWhEf5M/pBwCRrJePPcGGRk4I49+50O5Grvq59lSwXbb0M
 YAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794574937; x=1795179737;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=J8H5sWnUMgVUN6F10TKCOEnYfKDdKj37MRnqrSZpey4=;
 b=v4kPGf4Rbjg2ysIoKEdI5JdiTjJt58BK6U3ByJNawuXFudwO2l2Xs4bI9cuHBC+NFB
 OJwoVkFHVnY8zoKpkdphshcwltO3qELfpwqcse5pyOIdFTYDvVnoc/MwUpqjT4MAmEcp
 6HiDqxC+ogHlw9U00vUbI+UWjBAQgX2Rv6uy+zk3YqSHKYvaMalesCAlrHk5zOmas1DK
 rJf3iox3GWG3FtxPZE23tbC/dalv33xeLMEoaCMbFk8BdU/x8RlAm8aivNHKjjgNvCgL
 +c3HrR0xk7zKMPpzqYKTxSTIFC53Ttsy+ilCGTQwa1pETVroA26JIkYQfn/ln8Yw7stX
 ihAQ==
X-Gm-Message-State: APuU4Z9jUqeJkEvMrEBwHEnvI9ulCROSduNrVtjW/JJuJyzI2uBUJaaK
 E/zgv5+6EFEplX/6Gbf0HEe1ZNudyxEnr3MHO+kN8Fca/fP4bpegXVI8vy5TZfwexXojStwH0xf
 KoQJ0DQRWRkywASoFRf/ttr+WT0p5sQGzDvXoCbtXf78P1Je4dFwYAFEYBaxVYG7izXIu
X-Gm-Gg: AYBFou3CrpqdpwNToMepJt3Th6xVkivF8fyuglkhadFW/gOdF850wkexbFUZchif3Zx
 TcrbHmaQJbWXg0mPJQLszyncPPBWKH7+4OI44/cBEbLgiVEnhSDZdP13XmrOOoy7AqLOkyi/kyS
 6jcLTlPNgnzjgRKa2rj5xu9IJQUZaPRBKTToAcA8HrEFKRfFSVjtHPEfB4YT+3UgWeCWz+IidG/
 aCPXoQHsb03Cs2oBlL6K3aCuaCSsSAqa2D8qPJ5jNiubh5UViVEI7baNl6VHzrunBosLcNdR8Co
 YqY8MwiJ7uFwWjWXAELY+oTtWCAlVM5FTBKfNkDdJyaAIdV44m+eH/+ydIFbXgftk0CDTlgNWfZ
 MggnVcABcsfIBGNg14ETEjkauWa0CPRn3kURss3uSgxQE9hyTCfGanKWzDnapayRFhDZQUcLAYO
 2z29L8JSCT1z6UUA+V/XhljXqOD+REMuzcAvddn4FBqCslbGJDBZsDOhABBkLvEGTDXsCuhrqd/
 ndhXlIehZlYFW5ex7F2U7tmvF0+XAbyftY1Se54XOMncLnZ5l3Q6P1ZaTBdVQzMdO2Cd5EP18RK
 e5Z9vec0rHcIHfn9KOc5O0Aifc4ZQqJdEFJeioOxXfzkfwBU6EBCpTf6f+LABQvGDitnACJVCeD
 ePScOyTj9Deq9Yv2Kddk8lQnocLhuQxpH7FRN4duxwVgEOl89+lN6NdUVjSvQzHxieKd9Qu55/v
 gGCQcvauIWXVNlPHs=
X-Received: by 2002:a05:600c:34d6:b0:4a8:f2ad:a9e5 with SMTP id
 5b1f17b1804b1-4bb559f609cmr45238115e9.3.1794574936082; 
 Fri, 13 Nov 2026 05:02:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55a0ffcdsm59288025e9.0.2026.11.13.05.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 05:02:15 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 13:02:12 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: 07f90c6e21b0ce4415e71efa62cd73aaf69f73bd
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <25343a64718b7e406b6b607e519325f902120534-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRqv9-000000004ZW-1HIf
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
Content-Type: multipart/mixed; boundary="===============3555540690415971364=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3555540690415971364==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0Ni9fpSRULQ="; charset=UTF-8

--0Ni9fpSRULQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1852?usp=3Demail

to look at the new patch set (#17)=2E

The following=
 approvals got outdated and were removed:
Code-Review+1 by R=C4=83zvan Cojo=
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
7 files changed, 122 insertions(+), 9 deleti=
ons(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/52/1852/17

diff --git a/doc/man-sections/management-options=2Erst b/doc/m=
an-sections/management-options=2Erst
index ba0468b=2E=2E315e567 100644
--- =
a/doc/man-sections/management-options=2Erst
+++ b/doc/man-sections/manageme=
nt-options=2Erst
@@ -14,6 +14,7 @@
     management socket-name unix pw-file=
  # (recommended)
     management IP port                   # (INSECURE)
  =
   management IP port pw-file           #
+    management script unix-scrip=
t
 
   ``pw-file``, if specified, is a password file where the password mus=
t
   be on first line=2E Instead of a filename it can use the keyword stdin=

@@ -25,6 +26,14 @@
   ``--management-client-user`` and ``--management-clie=
nt-group``
   directives to restrict access=2E
 
+  When the variant :code:=
`unix-script` is used, OpenVPN will start the
+  specified script on startu=
p and enable ``--management-hold``=2E
+  OpenVPN will generate a random pat=
h for the unix socket
+  and management password=2E These are passed as env=
ironment
+  variables :code:`MANAGEMENT_SOCKET`, :code:`MANAGEMENT_PASSWORD=
`
+  to the script when being started=2E When OpenVPN terminates it sends
+=
  a :code:`SIGINT` signal to the running script=2E
+
   The management inte=
rface provides a special mode where the TCP
   management link can operate =
over the tunnel itself=2E To enable this mode,
   set IP to ``tunnel``=2E T=
unnel mode will cause the management interface to
@@ -127,10 +136,11 @@
   =
(client-only)=2E
 
 --management-signal
-  Send SIGUSR1 signal to OpenVPN i=
f management session disconnects=2E This
-  is useful when you wish to disc=
onnect an OpenVPN session on user logoff=2E
-  For ``--management-client`` =
this option is not needed since a disconnect
-  will always generate a :cod=
e:`SIGTERM`=2E
+  Send :code:`SIGUSR1` signal to OpenVPN if management sess=
ion disconnects=2E
+  This is useful when you wish to disconnect an OpenVPN=
 session on user
+  logoff=2E For ``--management-client`` or ``--management=
`` with
+  :code:`unix-script` this option has no effect since a disconnect=
 will
+  always trigger sending a :code:`SIGTERM`=2E
 
 --management-up-dow=
n
   Report tunnel up/down events to management interface=2E
diff --git a/d=
oc/management-notes=2Etxt b/doc/management-notes=2Etxt
index a98b45f=2E=2E4=
a5dac4 100644
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
dex 25521f3=2E=2E9ff4df7 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvp=
n/init=2Ec
@@ -4255,19 +4255,60 @@
     }
 }
 
+static void
+run_management=
_script(const struct context *c)
+{
+#if UNIX_SOCK_SUPPORT
+    struct gc_a=
rena gc =3D gc_new();
+    struct argv argv =3D argv_new();
+    struct env=
_set *env =3D env_set_create(&gc);
+
+    setenv_str(env, "MANAGEMENT_PASSW=
ORD", management->settings=2Eup=2Epassword);
+    setenv_str(env, "MANAGEME=
NT_SOCKET", c->options=2Emanagement_addr);
+
+    argv_parse_cmd(&argv, c->=
options=2Emanagement_script);
+
+    int flags =3D S_NOWAITPID | S_SCRIPT |=
 S_FATAL;
+    int *pid =3D &management->connection=2Eunix_script_pid;
+   =
 const char *msg_prefix =3D "ERROR: Failed running management unix-script: =
";
+    *pid =3D openvpn_execve_check(&argv, env, flags, msg_prefix);
+
+  =
  if (!openvpn_waitpid_check(*pid, msg_prefix, M_FATAL))
+    {
+        *p=
id =3D 0;
+    }
+
+    argv_free(&argv);
+    gc_free(&gc);
+#else
+    ms=
g(M_FATAL, "ERROR: Management unix-socket support is not available on this =
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
+        unsi=
gned int flags =3D c->options=2Emanagement_flags;
+        if (flags & MF_U=
NIX_SOCK_SCRIPT)
+        {
+            /* This creates a filename that sh=
ould be unguessable */
+            char sockname[64] =3D { 0 };
+         =
   snprintf(sockname, sizeof(sockname),
+                     PACKAGE_NAME =
"_omi_%016" PRIx64 "=2Esock", get_random());
+
+            c->options=2Ema=
nagement_addr =3D platform_gen_path(c->options=2Etmp_dir, sockname, &c->gc)=
;
+        }
+
         if (c->options=2Emanagement_addr)
         {
-     =
       unsigned int flags =3D c->options=2Emanagement_flags;
             i=
f (c->options=2Emode =3D=3D MODE_SERVER)
             {
                 fl=
ags |=3D MF_SERVER;
             }
+
             if (management_open(
    =
                 management, c->options=2Emanagement_addr, c->options=2Eman=
agement_port,
                     c->options=2Emanagement_user_pass, c->op=
tions=2Emanagement_client_user,
@@ -4279,6 +4320,11 @@
                    =
                  NULL);
             }
 
+            if (flags & MF_UNIX_=
SOCK_SCRIPT)
+            {
+                run_management_script(c);
+   =
         }
+
             /* initial management hold, called early, before =
first context initialization */
             do_hold(0);
             if (I=
S_SIG(c))
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
inde=
x 581e7be=2E=2Ee99bec2 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvp=
n/manage=2Ec
@@ -49,6 +49,8 @@
 
 #include "memdbg=2Eh"
 #include "ssl_ncp=
=2Eh"
+#include "run_command=2Eh"
+
 
 #ifdef ENABLE_PKCS11
 #include "pkcs=
11=2Eh"
@@ -337,7 +339,8 @@
 man_delete_unix_socket(const struct management=
 *man)
 {
 #if UNIX_SOCK_SUPPORT
-    if ((man->settings=2Eflags & (MF_UNIX=
_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
+    if ((man->settings=
=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK
+    =
    || man->settings=2Eflags & MF_UNIX_SOCK_SCRIPT)
     {
         socket_=
delete_unix(&man->settings=2Elocal_unix);
     }
@@ -2255,6 +2258,12 @@
   =
          }
         }
 
+        if (man->settings=2Eflags & MF_UNIX_SOCK_=
SCRIPT && !man_password_needed(man))
+        {
+            msg(D_MANAGEME=
NT, "MANAGEMENT: Triggering exit on unix-script disconnect");
+            =
throw_signal_soft(SIGTERM, "management-exit");
+        }
+
         if (ma=
n->settings=2Eflags & MF_CONNECT_AS_CLIENT)
         {
             msg(D_M=
ANAGEMENT, "MANAGEMENT: Triggering management exit");
@@ -2701,6 +2710,15 @=
@
         {
             get_user_pass(&ms->up, pass_file, "Management", G=
ET_USER_PASS_PASSWORD_ONLY);
         }
+        else if (ms->flags & MF_UN=
IX_SOCK_SCRIPT)
+        {
+            /* Set random password=2E The passw=
ord is only
+             * alphanumerical [0-9a-f] but still has 128 bit o=
f randomness,
+             * which is more than enough */
+            snp=
rintf(ms->up=2Epassword, sizeof(ms->up=2Epassword),
+                     "=
%" PRIx64 "%" PRIx64, get_random(), get_random());
+            ms->up=2Ede=
fined =3D true;
+        }
 
 #if UNIX_SOCK_SUPPORT
         /*
@@ -2846,6 =
+2864,13 @@
         man_close_socket(man, mc->sd_cli);
     }
 
+#if UNIX_=
SOCK_SUPPORT
+    if (mc->unix_script_pid)
+    {
+        kill(mc->unix_sc=
ript_pid, SIGINT);
+    }
+#endif
+
     command_line_free(mc->in);
     bu=
ffer_list_free(mc->out);
 
@@ -3504,6 +3529,19 @@
                 break;
 =
            }
 
+#if UNIX_SOCK_SUPPORT
+            /* if unix-script is in=
 use, the script might have exited
+             * while we are waiting for=
 it to connect */
+            const char *msg_prefix =3D "ERROR: Failed ru=
nning management unix-script: ";
+
+            if (man->connection=2Eunix_=
script_pid
+                && !openvpn_waitpid_check(man->connection=2Euni=
x_script_pid, msg_prefix, M_FATAL))
+            {
+                status =
=3D -1;
+                break;
+            }
+#endif
+
             if (s=
tatus > 0)
             {
                 break;
diff --git a/src/openvpn/=
manage=2Eh b/src/openvpn/manage=2Eh
index 82c0caa=2E=2Ecc9c264 100644
--- a=
/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -42,6 +42,7 @@
 #de=
fine MF_EXTERNAL_CERT          (1u << 15)
 #define MF_EXTERNAL_KEY_PSSPAD  =
  (1u << 16)
 #define MF_EXTERNAL_KEY_DIGEST    (1u << 17)
+#define MF_UNIX=
_SOCK_SCRIPT       (1u << 18)
 
 #ifdef ENABLE_MANAGEMENT
 
@@ -336,6 +337,=
9 @@
     int fdtosend;
     int lastfdreceived;
 #endif
+#if UNIX_SOCK_SUP=
PORT
+    pid_t unix_script_pid;
+#endif
     int client_version;
 };
 
dif=
f --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 9ed3964=
=2E=2E4b0a57c 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -1697,7 +1697,7 @@
      * Check for consistency of management opt=
ions
      */
 #ifdef ENABLE_MANAGEMENT
-    if (!options->management_addr
=
+    if (!options->management_addr && !(options->management_flags & MF_UNIX=
_SOCK_SCRIPT)
         && (options->management_flags
             || option=
s->management_log_history_cache !=3D defaults=2Emanagement_log_history_cach=
e))
     {
@@ -4213,7 +4213,7 @@
     else if (streq(p[0], "management") &&=
 p[1] && p[2] && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-=
        if (streq(p[2], "unix"))
+        if (streq(p[2], "unix") || streq(=
p[2], "unix-script"))
         {
 #if UNIX_SOCK_SUPPORT
             option=
s->management_flags |=3D MF_UNIX_SOCK;
@@ -4223,7 +4223,16 @@
 #endif
     =
    }
 
-        options->management_addr =3D p[1];
+        if (streq(p[2]=
, "unix-script"))
+        {
+            options->management_flags |=3D MF=
_UNIX_SOCK_SCRIPT | MF_HOLD;
+            set_user_script(options, &options=
->management_script, p[1],
+                            "management unix-sc=
ript", false);
+        }
+        else
+        {
+            options->ma=
nagement_addr =3D p[1];
+        }
         options->management_port =3D p[=
2];
         if (p[3])
         {
diff --git a/src/openvpn/options=2Eh b/sr=
c/openvpn/options=2Eh
index b390ebc=2E=2E45a1591 100644
--- a/src/openvpn/o=
ptions=2Eh
+++ b/src/openvpn/options=2Eh
@@ -446,6 +446,8 @@
     const cha=
r *management_addr;
     const char *management_port;
     const char *mana=
gement_user_pass;
+    /** Script executed to talk to the management interf=
ace */
+    const char *management_script;
     int management_log_history_=
cache;
     int management_echo_buffer_size;
     int management_state_buff=
er_size;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
2?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I307e6=
4079f436aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
Gerrit-Patch=
Set: 17
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--0Ni9fpSRULQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #17</strong> to this change=2E</p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">Vie=
w Change</a></p><p>The following approvals got outdated and were removed:
C=
ode-Review+1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">Add unix-script funct=
ionality to the --management feature<br><br>This allows a script that handl=
es management input/output to<br>be started alongside OpenVPN simpler in sm=
all deployments=2E<br><br>Change-Id: I307e64079f436aa782f7e24bfff665a545ad2=
fa0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M d=
oc/man-sections/management-options=2Erst<br>M doc/management-notes=2Etxt<br=
>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=
=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>7 files c=
hanged, 122 insertions(+), 9 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1852/17</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/management-options=2Erst b/doc/man-section=
s/management-options=2Erst</span><br><span>index ba0468b=2E=2E315e567 10064=
4</span><br><span>--- a/doc/man-sections/management-options=2Erst</span><br=
><span>+++ b/doc/man-sections/management-options=2Erst</span><br><span>@@ -=
14,6 +14,7 @@</span><br><span>     management socket-name unix pw-file  # (=
recommended)</span><br><span>     management IP port                   # (I=
NSECURE)</span><br><span>     management IP port pw-file           #</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    management script unix=
-script</span><br><span> </span><br><span>   ``pw-file``, if specified, is =
a password file where the password must</span><br><span>   be on first line=
=2E Instead of a filename it can use the keyword stdin</span><br><span>@@ -=
25,6 +26,14 @@</span><br><span>   ``--management-client-user`` and ``--mana=
gement-client-group``</span><br><span>   directives to restrict access=2E</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  W=
hen the variant :code:`unix-script` is used, OpenVPN will start the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  specified script on start=
up and enable ``--management-hold``=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  OpenVPN will generate a random path for the unix socke=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and management p=
assword=2E These are passed as environment</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  variables :code:`MANAGEMENT_SOCKET`, :code:`MANAGE=
MENT_PASSWORD`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  to =
the script when being started=2E When OpenVPN terminates it sends</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  a :code:`SIGINT` signal to =
the running script=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>   The management interface provides a special mode wher=
e the TCP</span><br><span>   management link can operate over the tunnel it=
self=2E To enable this mode,</span><br><span>   set IP to ``tunnel``=2E Tun=
nel mode will cause the management interface to</span><br><span>@@ -127,10 =
+136,11 @@</span><br><span>   (client-only)=2E</span><br><span> </span><br>=
<span> --management-signal</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  Send SIGUSR1 signal to OpenVPN if management session disconnects=2E =
This</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  is useful when =
you wish to disconnect an OpenVPN session on user logoff=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  For ``--management-client`` this op=
tion is not needed since a disconnect</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  will always generate a :code:`SIGTERM`=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Send :code:`SIGUSR1` signal to Op=
enVPN if management session disconnects=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  This is useful when you wish to disconnect an Open=
VPN session on user</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  logoff=2E For ``--management-client`` or ``--management`` with</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  :code:`unix-script` this opt=
ion has no effect since a disconnect will</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  always trigger sending a :code:`SIGTERM`=2E</span><=
br><span> </span><br><span> --management-up-down</span><br><span>   Report =
tunnel up/down events to management interface=2E</span><br><span>diff --git=
 a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>=
index a98b45f=2E=2E4a5dac4 100644</span><br><span>--- a/doc/management-note=
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
penvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 25521f3=2E=2E9=
ff4df7 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>++=
+ b/src/openvpn/init=2Ec</span><br><span>@@ -4255,19 +4255,60 @@</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+run_management_script(const struct context *c)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct argv argv =3D=
 argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct env_set *env =3D env_set_create(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    setenv_str(env, &quot;MANAGEMENT_PASSWORD&quot;, management-&gt;=
settings=2Eup=2Epassword);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    setenv_str(env, &quot;MANAGEMENT_SOCKET&quot;, c-&gt;options=2Em=
anagement_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_parse_cmd(&am=
p;argv, c-&gt;options=2Emanagement_script);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int flags =3D S_NOWAITPID | S_SCRIPT | S_FATAL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int *pid =3D &amp;management-&gt;c=
onnection=2Eunix_script_pid;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *msg_prefix =3D &quot;ERROR: Failed running managem=
ent unix-script: &quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    *pid =3D openvpn_execve_check(&amp;argv, env, flags, msg_prefix);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!openvpn_waitpid_check(*pid, ms=
g_prefix, M_FATAL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *pid =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    argv_free(&amp;argv);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    msg(M_FATAL, &quot;ERROR: Management unix-socket=
 support is not available on this platform&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> bool</span><br><span> open_management(struct context *c)<=
/span><br><span> {</span><br><span>     /* initialize management layer */</=
span><br><span>     if (management)</span><br><span>     {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        unsigned int flags =3D c-&gt=
;options=2Emanagement_flags;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* This creates a filename that should =
be unguessable */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          char sockname[64] =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            snprintf(sockname, sizeof(sockname),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     PACKAG=
E_NAME &quot;_omi_%016&quot; PRIx64 &quot;=2Esock&quot;, get_random());</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            c-&gt;options=2Emanagement_ad=
dr =3D platform_gen_path(c-&gt;options=2Etmp_dir, sockname, &amp;c-&gt;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if =
(c-&gt;options=2Emanagement_addr)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            unsigned int flags =3D c=
-&gt;options=2Emanagement_flags;</span><br><span>             if (c-&gt;opt=
ions=2Emode =3D=3D MODE_SERVER)</span><br><span>             {</span><br><s=
pan>                 flags |=3D MF_SERVER;</span><br><span>             }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
         if (management_open(</span><br><span>                     manageme=
nt, c-&gt;options=2Emanagement_addr, c-&gt;options=2Emanagement_port,</span=
><br><span>                     c-&gt;options=2Emanagement_user_pass, c-&gt=
;options=2Emanagement_client_user,</span><br><span>@@ -4279,6 +4320,11 @@</=
span><br><span>                                      NULL);</span><br><span=
>             }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                run_management_script(=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     =
        /* initial management hold, called early, before first context init=
ialization */</span><br><span>             do_hold(0);</span><br><span>    =
         if (IS_SIG(c))</span><br><span>diff --git a/src/openvpn/manage=2Ec=
 b/src/openvpn/manage=2Ec</span><br><span>index 581e7be=2E=2Ee99bec2 100644=
</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/ope=
nvpn/manage=2Ec</span><br><span>@@ -49,6 +49,8 @@</span><br><span> </span><=
br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;s=
sl_ncp=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;run_command=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> </span><br><span> #ifdef ENABLE_PKCS11</spa=
n><br><span> #include &quot;pkcs11=2Eh&quot;</span><br><span>@@ -337,7 +339=
,8 @@</span><br><span> man_delete_unix_socket(const struct management *man)=
</span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPORT</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if ((man-&gt;settings=2Eflags &amp=
; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if ((man-&gt;settings=2Eflags=
 &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        || man-&gt;settings=
=2Eflags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>     {</span><br><span>=
         socket_delete_unix(&amp;man-&gt;settings=2Elocal_unix);</span><br>=
<span>     }</span><br><span>@@ -2255,6 +2258,12 @@</span><br><span>       =
      }</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;settings=2Eflags &amp=
; MF_UNIX_SOCK_SCRIPT &amp;&amp; !man_password_needed(man))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(D_MANAGEMENT, &quot;MANAGEMEN=
T: Triggering exit on unix-script disconnect&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            throw_signal_soft(SIGTERM, &q=
uot;management-exit&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>         if (man-&gt;settings=2Eflags &amp; MF_CONNECT_AS_CL=
IENT)</span><br><span>         {</span><br><span>             msg(D_MANAGEM=
ENT, &quot;MANAGEMENT: Triggering management exit&quot;);</span><br><span>@=
@ -2701,6 +2710,15 @@</span><br><span>         {</span><br><span>          =
   get_user_pass(&amp;ms-&gt;up, pass_file, &quot;Management&quot;, GET_USE=
R_PASS_PASSWORD_ONLY);</span><br><span>         }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        else if (ms-&gt;flags &amp; MF_UNIX_S=
OCK_SCRIPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Set=
 random password=2E The password is only</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+             * alphanumerical [0-9a-f] but still has 1=
28 bit of randomness,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+             * which is more than enough */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            snprintf(ms-&gt;up=2Epassword, sizeof=
(ms-&gt;up=2Epassword),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                     &quot;%&quot; PRIx64 &quot;%&quot; PRIx64, get_ran=
dom(), get_random());</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            ms-&gt;up=2Edefined =3D true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span> </span><br><span> #if UN=
IX_SOCK_SUPPORT</span><br><span>         /*</span><br><span>@@ -2846,6 +286=
4,13 @@</span><br><span>         man_close_socket(man, mc-&gt;sd_cli);</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (mc-&gt;unix_script_pid)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        kill(mc-&gt;unix_script_pid, SIGINT);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     command_line_free(mc-&gt;in);</span><=
br><span>     buffer_list_free(mc-&gt;out);</span><br><span> </span><br><sp=
an>@@ -3504,6 +3529,19 @@</span><br><span>                 break;</span><br=
><span>             }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            /* if unix-script is in use, the script m=
ight have exited</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          * while we are waiting for it to connect */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            const char *msg_prefix =3D &q=
uot;ERROR: Failed running management unix-script: &quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (man-&gt;connection=2Eunix_script_pid</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                &amp;&a=
mp; !openvpn_waitpid_check(man-&gt;connection=2Eunix_script_pid, msg_prefix=
, M_FATAL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  status =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
           if (status &gt; 0)</span><br><span>             {</span><br><spa=
n>                 break;</span><br><span>diff --git a/src/openvpn/manage=
=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 82c0caa=2E=2Ecc9c264 10=
0644</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src=
/openvpn/manage=2Eh</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #def=
ine MF_EXTERNAL_CERT          (1u &lt;&lt; 15)</span><br><span> #define MF_=
EXTERNAL_KEY_PSSPAD    (1u &lt;&lt; 16)</span><br><span> #define MF_EXTERNA=
L_KEY_DIGEST    (1u &lt;&lt; 17)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define MF_UNIX_SOCK_SCRIPT       (1u &lt;&lt; 18)</span><br><=
span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> </span><b=
r><span>@@ -336,6 +337,9 @@</span><br><span>     int fdtosend;</span><br><s=
pan>     int lastfdreceived;</span><br><span> #endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    pid_t unix_script_pid;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     int =
client_version;</span><br><span> };</span><br><span> </span><br><span>diff =
--git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>i=
ndex 9ed3964=2E=2E4b0a57c 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -1697=
,7 +1697,7 @@</span><br><span>      * Check for consistency of management o=
ptions</span><br><span>      */</span><br><span> #ifdef ENABLE_MANAGEMENT</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!options-&gt;ma=
nagement_addr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!options-&gt;management_addr &amp;&amp; !(options-&gt;management_flags &a=
mp; MF_UNIX_SOCK_SCRIPT)</span><br><span>         &amp;&amp; (options-&gt;m=
anagement_flags</span><br><span>             || options-&gt;management_log_=
history_cache !=3D defaults=2Emanagement_log_history_cache))</span><br><spa=
n>     {</span><br><span>@@ -4213,7 +4213,7 @@</span><br><span>     else if=
 (streq(p[0], &quot;management&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;=
&amp; !p[4])</span><br><span>     {</span><br><span>         VERIFY_PERMISS=
ION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (streq(p[2], &quot;unix&quot;))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (streq(p[2], &quot;unix&quot;) || streq(p[2=
], &quot;unix-script&quot;))</span><br><span>         {</span><br><span> #i=
f UNIX_SOCK_SUPPORT</span><br><span>             options-&gt;management_fla=
gs |=3D MF_UNIX_SOCK;</span><br><span>@@ -4223,7 +4223,16 @@</span><br><spa=
n> #endif</span><br><span>         }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        options-&gt;management_addr =3D p[=
1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (stre=
q(p[2], &quot;unix-script&quot;))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            options-&gt;management_flags |=3D MF_UNIX_SOCK_SCRIPT | MF_=
HOLD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            se=
t_user_script(options, &amp;options-&gt;management_script, p[1],</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                            &q=
uot;management unix-script&quot;, false);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       options-&gt;management_addr =3D p[1];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span>         options-&gt;man=
agement_port =3D p[2];</span><br><span>         if (p[3])</span><br><span> =
        {</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvp=
n/options=2Eh</span><br><span>index b390ebc=2E=2E45a1591 100644</span><br><=
span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/option=
s=2Eh</span><br><span>@@ -446,6 +446,8 @@</span><br><span>     const char *=
management_addr;</span><br><span>     const char *management_port;</span><b=
r><span>     const char *management_user_pass;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /** Script executed to talk to the managemen=
t interface */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *management_script;</span><br><span>     int management_log_histo=
ry_cache;</span><br><span>     int management_echo_buffer_size;</span><br><=
span>     int management_state_buffer_size;</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">=
change 1852</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
2?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1852 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>

</body></html>
--0Ni9fpSRULQ=--


--===============3555540690415971364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3555540690415971364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3555540690415971364==--

