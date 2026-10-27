Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E3606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XVpqdFo1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CAXfAU64;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=I/JfmST2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gLcuNpPe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AhwGLpwup/ticismxxeCmLQmU/P50obXNaZMpQ8SyWQ=; b=XVpqdFo1qiiUxCdFtBDE6CPzmg
	jRIw6iYXPGC2CZHl1OSNkQMiHP/skUa8h2M/xF0Y3E/KQI7GsQvpYbzgl/hGyyyaDOQca03++qTnF
	UZvKPGdYRXZ6RazCt+5RCI3ZBylpH0NrChzrc4vtbzKQzVNzm/K72Epph4UbzzGeM7fM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLhAY-000000003Rt-0MtN;
	Tue, 27 Oct 2026 13:24:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLhAF-000000003RU-2Xzy
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:24:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ii5F54ytg0UGAXaGHaVJAgFuMZbYwHDcmHmkvQAGzrs=; b=CAXfAU64PwDZrxNODTkwxYoM3e
 QM8HIIBBfbAhOEPoYPWVfiDe5tqN49favr5clRv6ZTl5G6aTei4pmedWC9O4akUmnjYrDke1Ko4j0
 JR5Hf+HAuvggoWFvdIwNdW7XqWCTa/fD4fJUQolRl5CpHqmxoZT2uNtKBV5dKPY9Y9G4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ii5F54ytg0UGAXaGHaVJAgFuMZbYwHDcmHmkvQAGzrs=; b=I/JfmST2chG6hYVBijJ6rVximj
 bCYjwmirqb2+A9WSMA2A6wDNpkiG8Ghvjht7GzoioOntdTC08Jyv2tAbNbSnRUoInvE5rFDkHZyPv
 TLUT9aOkCcY70NfQa5ZfLJDhaAgVn5avNKsDo13pctZRfaaDEhk4jmQ2m+aqTRnxe09U=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLhA2-0000000075Y-2akF for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:24:20 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so36326055e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793107452; x=1793712252; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ii5F54ytg0UGAXaGHaVJAgFuMZbYwHDcmHmkvQAGzrs=;
 b=gLcuNpPe35pussjbnjhsMgYm5oSCe/rvSShKaRqn8zZSi0sX2q2AwdJTuKpnxb9uMO
 gTrvInJtQOcfUFAZq9aeuoO2VbgIIfVbO8h90dUUN6l+sdCpxVJ7uGolNYolRZXUdDkq
 ayfHOh6huQffMd7K3Kq9vup9iAV/HvnY4zTYuFiT2A/BjBAnXwLKAORcEnN9TjS52y2+
 Nq0n7Ll2V8rpgEPREUY8j9RSkTYd9BKGnDexfP/nDHRELyi7yUS/m6cAtACEmqgM9L5e
 VzkM3euhZUutoiGqhEi99E23h2F5ALaaQTlM/HfeM80wBp4Tl1E0wA8TRbhCCRSPZhQj
 S1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793107452; x=1793712252;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ii5F54ytg0UGAXaGHaVJAgFuMZbYwHDcmHmkvQAGzrs=;
 b=M6UA8fgqWwOVB1S+x4n0jtZgXtxfECgTRAmH8SCqpCdAHHXG2XPjS6NSVIRUdq5IbY
 Q7VIz5mMW5IqL9GryYzGpLJJcOdOPVVDrCobrTaX4QBb8pwQeNkq5sZFX88R57DmG8E6
 QVTiRe9nRSghAtX3dzx6uHv3fx1DVltL1wHt3y9iBztWvP39RyhbywerJpB+vl75ryhA
 LS80uJ3KFYsJ+nzkPmHXz1r/P4pU5Gol06GM4J6ZK54orFdgnuIUvR0yKGA88dMEEbm3
 ncTg6/xLJ0NuEQ8B3tM5lnpWP4hY4kCWMKxZVtLp7NxIY1dezzFaaTy9K8B2tJU4T3y0
 knJQ==
X-Gm-Message-State: AFq9FYJwNDVXont/MvLKy5DhP1heBhZO+MLjE7K58E4wCO4rSt1urNRq
 5kKYWGh/GFFD+2MvmSfDED4DwOF3PwdxXKn6z8ANw2KapdocEzbxnWoGde2BrA72ycUmoEADySi
 KhtHQ7JKcskX6ir761q26+LCMHhSrS6adMejyvEw3t36JgGZGvDu3qEDMkpueb9LRt1tt
X-Gm-Gg: AYBFou2eLP8D6VVkMmWrzXOjqHmjrDeU/k4gNmzv7ubdtei0ppdwtvrEp/PtIbacLmB
 eVT2mVS6BpcnTeCnu3xX2XhB/M5b/sqA8Cj+ETTREGgVTVBLyDbXT9G1ecUo8QrVaNrZrBxobSz
 /eD2JgMaNMm8LVNJDMQ997oQjQczucVoZoIV4ssmpe9k1OEcd0RgZemIG5U1+jxxbmAJh0/1GpQ
 v4L1Aexzf8pEI8ok7zARl77XSXC6ubdA0v+eRkj2O7k2CjQkt8AQQEY9Cu84WKQVHlN2QBJL7sr
 0IsmKAzZ/sXCZBF61YZLf5XaLzz99OyOJVJE2msy0/U97dTySwnNGKNazhRX1Ww3VcRc35REvRt
 UlahHHTO6d2Pq+V0xFHKaZvLJixBsQJbJK6Jy4BBC/usykzOv52iNBkzFjHVs/voRbPwdd6TQrS
 5X9cmq4935AS1cZDx2N1QH1kYBOXbHarkutTkoorOzNr7mf+usHx12SOZhofGgQY7EzU37wFXuL
 aFnbm9PSwLMJrg783kC+xDsnl9g2/quzyZX+dNLOcuawTlv80HsieF0oDktJeO8rm3NDidrsJ3E
 wAo87hgYxM4J0CYHBdh+wLlnUbXQr0H3CwtIHuIz4A2N9TRuPIeKVjvY4ENLSZeE/xR2xvODVbl
 y5juawShK/5inkExXR6efWrt3S+naOSCVE6g6m/Wr/Q==
X-Received: by 2002:a05:600c:4e87:b0:4a1:a2c0:7b73 with SMTP id
 5b1f17b1804b1-4a35acaa6c3mr195406285e9.30.1793107451679; 
 Tue, 27 Oct 2026 06:24:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f387sm22595756f8f.4.2026.10.27.06.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:24:11 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 13:24:06 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: fb08f2ed58217017e53f66a5bae20280bd48bf1d
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a6b79b157d8d447d12a09b137a4856e4a980e1e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLhA2-0000000075Y-2akF
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
Content-Type: multipart/mixed; boundary="===============3450466280248070889=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3450466280248070889==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l8RhuQFbGlI="; charset=UTF-8

--l8RhuQFbGlI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1852?usp=3Demail

to look at the new patch set (#16)=2E

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
7 files changed, 121 insertions(+), 9 deleti=
ons(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/52/1852/16

diff --git a/doc/man-sections/management-options=2Erst b/doc/m=
an-sections/management-options=2Erst
index 8dad52b=2E=2E2c79d05 100644
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
index a28a1a8=2E=2E4=
d726c4 100644
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
dex 24cf532=2E=2E1b8b2a5 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvp=
n/init=2Ec
@@ -4343,19 +4343,60 @@
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
@@ -4367,6 +4408,11 @@
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
x 0fc9ee2=2E=2Eac3d4b7 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvp=
n/manage=2Ec
@@ -47,6 +47,7 @@
 #include "resolve=2Eh"
 
 #include "memdbg=
=2Eh"
+#include "run_command=2Eh"
 
 #ifdef ENABLE_PKCS11
 #include "pkcs11=
=2Eh"
@@ -334,7 +335,8 @@
 man_delete_unix_socket(const struct management *=
man)
 {
 #if UNIX_SOCK_SUPPORT
-    if ((man->settings=2Eflags & (MF_UNIX_S=
OCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
+    if ((man->settings=
=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK
+    =
    || man->settings=2Eflags & MF_UNIX_SOCK_SCRIPT)
     {
         socket_=
delete_unix(&man->settings=2Elocal_unix);
     }
@@ -2196,6 +2198,12 @@
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
@@ -2644,6 +2652,15 @=
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
@@ -2789,6 =
+2806,13 @@
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
 
@@ -3448,6 +3472,19 @@
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
index f2c6916=2E=2E157039d 100644
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
 
@@ -327,6 +328,=
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
index 8e0c602=
=2E=2Efb319ae 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -1700,7 +1700,7 @@
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
@@ -4285,7 +4285,7 @@
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
@@ -4295,7 +4295,16 @@
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
index c58530a=2E=2E6a3bf61 100644
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
Set: 16
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>

--l8RhuQFbGlI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #16</strong> to this change=2E</p><p>=
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
hanged, 121 insertions(+), 9 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1852/16</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/management-options=2Erst b/doc/man-section=
s/management-options=2Erst</span><br><span>index 8dad52b=2E=2E2c79d05 10064=
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
index a28a1a8=2E=2E4d726c4 100644</span><br><span>--- a/doc/management-note=
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
penvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 24cf532=2E=2E1=
b8b2a5 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>++=
+ b/src/openvpn/init=2Ec</span><br><span>@@ -4343,19 +4343,60 @@</span><br>=
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
;options=2Emanagement_client_user,</span><br><span>@@ -4367,6 +4408,11 @@</=
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
 b/src/openvpn/manage=2Ec</span><br><span>index 0fc9ee2=2E=2Eac3d4b7 100644=
</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/ope=
nvpn/manage=2Ec</span><br><span>@@ -47,6 +47,7 @@</span><br><span> #include=
 &quot;resolve=2Eh&quot;</span><br><span> </span><br><span> #include &quot;=
memdbg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;run_command=2Eh&quot;</span><br><span> </span><br><span> #ifdef=
 ENABLE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&quot;</span><br><=
span>@@ -334,7 +335,8 @@</span><br><span> man_delete_unix_socket(const stru=
ct management *man)</span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPO=
RT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((man-&gt;se=
ttings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_=
SOCK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((man-&=
gt;settings=2Eflags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_=
UNIX_SOCK</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ||=
 man-&gt;settings=2Eflags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>     {=
</span><br><span>         socket_delete_unix(&amp;man-&gt;settings=2Elocal_=
unix);</span><br><span>     }</span><br><span>@@ -2196,6 +2198,12 @@</span>=
<br><span>             }</span><br><span>         }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;setti=
ngs=2Eflags &amp; MF_UNIX_SOCK_SCRIPT &amp;&amp; !man_password_needed(man))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MANAGEMENT,=
 &quot;MANAGEMENT: Triggering exit on unix-script disconnect&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            throw_signal_s=
oft(SIGTERM, &quot;management-exit&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>         if (man-&gt;settings=2Eflags &amp; M=
F_CONNECT_AS_CLIENT)</span><br><span>         {</span><br><span>           =
  msg(D_MANAGEMENT, &quot;MANAGEMENT: Triggering management exit&quot;);</s=
pan><br><span>@@ -2644,6 +2652,15 @@</span><br><span>         {</span><br><=
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
@@ -2789,6 +2806,13 @@</span><br><span>         man_close_socket(man, mc-&g=
t;sd_cli);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (mc-&gt;unix_script_pid)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        kill(mc-&gt;unix_script_pid, SIGI=
NT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     command_line_free(m=
c-&gt;in);</span><br><span>     buffer_list_free(mc-&gt;out);</span><br><sp=
an> </span><br><span>@@ -3448,6 +3472,19 @@</span><br><span>               =
  break;</span><br><span>             }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            /* if unix-script is in=
 use, the script might have exited</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+             * while we are waiting for it to connect */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            const char =
*msg_prefix =3D &quot;ERROR: Failed running management unix-script: &quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;connection=2Eu=
nix_script_pid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           &amp;&amp; !openvpn_waitpid_check(man-&gt;connection=2Eunix_scri=
pt_pid, msg_prefix, M_FATAL))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                status =3D -1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                break;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>             if (status &gt; 0)</span><br><span>           =
  {</span><br><span>                 break;</span><br><span>diff --git a/sr=
c/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>index f2c6916=
=2E=2E157039d 100644</span><br><span>--- a/src/openvpn/manage=2Eh</span><br=
><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -42,6 +42,7 @@</span=
><br><span> #define MF_EXTERNAL_CERT          (1u &lt;&lt; 15)</span><br><s=
pan> #define MF_EXTERNAL_KEY_PSSPAD    (1u &lt;&lt; 16)</span><br><span> #d=
efine MF_EXTERNAL_KEY_DIGEST    (1u &lt;&lt; 17)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define MF_UNIX_SOCK_SCRIPT       (1u &lt;&lt;=
 18)</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br>=
<span> </span><br><span>@@ -327,6 +328,9 @@</span><br><span>     int fdtose=
nd;</span><br><span>     int lastfdreceived;</span><br><span> #endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    pid_t unix_script_pi=
d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span>     int client_version;</span><br><span> };</span><br><span> </span>=
<br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</s=
pan><br><span>index 8e0c602=2E=2Efb319ae 100644</span><br><span>--- a/src/o=
penvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br>=
<span>@@ -1700,7 +1700,7 @@</span><br><span>      * Check for consistency o=
f management options</span><br><span>      */</span><br><span> #ifdef ENABL=
E_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
options-&gt;management_addr</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!options-&gt;management_addr &amp;&amp; !(options-&gt;manag=
ement_flags &amp; MF_UNIX_SOCK_SCRIPT)</span><br><span>         &amp;&amp; =
(options-&gt;management_flags</span><br><span>             || options-&gt;m=
anagement_log_history_cache !=3D defaults=2Emanagement_log_history_cache))<=
/span><br><span>     {</span><br><span>@@ -4285,7 +4285,7 @@</span><br><spa=
n>     else if (streq(p[0], &quot;management&quot;) &amp;&amp; p[1] &amp;&a=
mp; p[2] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>         =
VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (streq(p[2], &quot;unix&quot;))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (streq(p[2], &quot;unix&quot;=
) || streq(p[2], &quot;unix-script&quot;))</span><br><span>         {</span=
><br><span> #if UNIX_SOCK_SUPPORT</span><br><span>             options-&gt;=
management_flags |=3D MF_UNIX_SOCK;</span><br><span>@@ -4295,7 +4295,16 @@<=
/span><br><span> #endif</span><br><span>         }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;manageme=
nt_addr =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (streq(p[2], &quot;unix-script&quot;))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            options-&gt;management_flags |=3D MF_UNIX_SOC=
K_SCRIPT | MF_HOLD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            set_user_script(options, &amp;options-&gt;management_script, p[=
1],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
            &quot;management unix-script&quot;, false);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            options-&gt;management_addr =3D p[1];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         o=
ptions-&gt;management_port =3D p[2];</span><br><span>         if (p[3])</sp=
an><br><span>         {</span><br><span>diff --git a/src/openvpn/options=2E=
h b/src/openvpn/options=2Eh</span><br><span>index c58530a=2E=2E6a3bf61 1006=
44</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/=
openvpn/options=2Eh</span><br><span>@@ -446,6 +446,8 @@</span><br><span>   =
  const char *management_addr;</span><br><span>     const char *management_=
port;</span><br><span>     const char *management_user_pass;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /** Script executed to talk to=
 the management interface */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *management_script;</span><br><span>     int manage=
ment_log_history_cache;</span><br><span>     int management_echo_buffer_siz=
e;</span><br><span>     int management_state_buffer_size;</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852=
?usp=3Demail">change 1852</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1852?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1852 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> =
Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</bod=
y></html>
--l8RhuQFbGlI=--


--===============3450466280248070889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3450466280248070889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3450466280248070889==--

