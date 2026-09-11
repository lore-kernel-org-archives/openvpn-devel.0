Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BADC88E4D
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3GCkwMcBA9EaIuzWPwMCwbqDVywVHlFsnPqr/a1SVkQ=; b=Q3nD7VzXJagwW3bVvddnGRAW+S
	cP52Y1LuxvfXH+tGOUAXSiTPh4K+y6iTP7FyFpyN5VPPGkKlNfT/FLDyZwzShc9lt2W7LC3JMZZIm
	bQ/PQsj/xliOa8iWRUS8nclFTCAqIYgU9sq3JvybvrmAdov9Hc7kH5ET4+wxlL9HIMe0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4zlk-0002Zs-Bg;
	Fri, 11 Sep 2026 11:50:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4zlH-0002XH-Qn
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 11:49:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oQGhOgK/N4B2hUdkItmSXimSYwpHV/hP15eHRVnD7qU=; b=PytDNCmxcrhf/qdt2FvRx6ZUS1
 yGgV2yvFCTxNCW8d9wfUgFkM4pD2u8ZuDaZwRA0mSfr5Mwubr+Yc9Ouhr5YsAwqFYzYia1i+H6q1w
 slx3XAbmk6DLFIfmfyosZj8gOu/YQ5C86vnom2jdoAugXmDdGWFnQdwHwzGQ1OWU2AqU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oQGhOgK/N4B2hUdkItmSXimSYwpHV/hP15eHRVnD7qU=; b=E
 PtZsb9zdlel0uswTkm0rPoxKPnjG0nBheXmQQBMjFETNSso7P1Wkk+KSMMofRCr5cEimNFVawkKrw
 Jet3QjW1QbyLT3MumVd/FIOjIbw8y6qVm4GID7Z7JRZgcdvgLAsd6K9yQSFlruywMzY5XBReT6tfd
 M4H9YqnbA/hDN8kI=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4zlG-0001Nr-AQ for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 11:49:44 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so436438f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 04:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789127376; x=1789732176; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oQGhOgK/N4B2hUdkItmSXimSYwpHV/hP15eHRVnD7qU=;
 b=K4X+tYibd13x96sihCshc/m91TedmeneVmKxeZoNOt+aCnPGSpfi5fsTw6Qs61J1hl
 59BaCkJNiy6B/0tgttf3MD+5PhiXEJl+QBhxILmSgQiWNx8+HZJQAnJtIzaXOcRAWtI3
 e97mu2JzpR/C20fXeShIoILF3I9PZTm0NBesIr+9AIPez2u2u0z2t2wPsc56AqqBF2l1
 qH9NIpTK2MBv8vJ2smJyfyPaf3M4lPtlH1HYRN8Ys5PcPnCRwqWV5W92cUvS7QvyDgwZ
 7yXCjrUZoP0wM/45SoyXuTSyONin2caeKYirG0/vzNaAek29RnQsnv5pGn/+vO0UZbBQ
 Fp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789127376; x=1789732176;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oQGhOgK/N4B2hUdkItmSXimSYwpHV/hP15eHRVnD7qU=;
 b=Fz+pv84PGl0AvVgquVYaUspt/yZUI7+Qr8eo25BLoluesIGLXKHTcB3V/Tsh6+29EC
 sxjcEp8bS398bLjAtkUIiMOprPlQK227ecfIgwnYFbm/PUi3pDoR04BqpP2gbqnVnWJP
 Us3gumfy4ueGPrux3ttZYiCkUMJCjfN5g/+2im2u8iTm4zk1rLxh3VcDJ4xRzUiwwnH8
 HZI51vGbyfx8fpOmaU9G1ph2TM8TQF97MAPwoFJbJ5/AaP98x4atW3sf4Y+Wj1ncmzm4
 9zvyEBWWMZ/Ni0hkdEGp9YhrcoKIhQcR7PXFyqvYMKmLxZeXbG24lQwto7Bix+JxzWtV
 UzmA==
X-Gm-Message-State: AFuF++mj7G15BiB04wEyzhhAdybsFo1mqRoefuSRZvXGxdzrw6Dq07i+
 xIcnayBQmGO/udGoVk1E3hmrVWk1iyJKEkrzdt13mzx53gaYuqJkG+bfvKtRoIFlxkoNKCzdEIZ
 NV5UAWiit7gAoeBcxJTd9r9jA3BvE4YE1tvPm7XHPM/3X8wGUKhpkIz1XwsrxcmQVrmMA
X-Gm-Gg: AYBFou3rR40sTEk/VBD5fCiwzyHnHydqn97tZsCHV9fFiy3+U59/UXhFb5F2AdiBe1g
 CPSKKtPX+YZ8+/qyV5EnFo/51IweVqCv7+t2iaRRMQ4fAGpnmjx52LLLaa8x9OZXPA5b+oBeRCE
 Dfv2YI9tGQNNlnIGetfpzgZ6ScvCcrudCbONv/1Bih5/H0q7k/8VxzDfFDBhdUZDcHIuq3lz+ST
 alU8ZCNvEggC6b4NkKg1JRS208SRXXp4JfIc2vvmqRhTd6GU/8oxdcRpi6YBLEXxhQZ6WeWge7J
 2u6Iw0JDHD04k8H5BP9dvmTnnPVu0g06iV/j0GzkZlzyQXZYBYFb2D0XEK+tFPyPULX/s9XWymq
 T3UPmxzZXASGz4gQIYm5OeY4b0GyvDMWd+PnUKe4umXjmHRQwr78qoXXtKI8yChFY3T6rixc8wo
 IM7mcfdl6su7NBSQ206xWVeAk/ygAEk8nOHO+pnpea7ZvoSxZynFMCqVH5uUFimwFNhpT8FKh8V
 laCLb8nA5M72g/zMnmZu6b4vgp/QNKZgB97cUaRHZ7C74bg7s5u6yMBSQsarQEgF5g5m+im57JF
 j2OwSycJsUjfRmOYdmPu9E9sVaPx8LVkXzJ4h/NGPw5DhRihvg/Yjey3l6eq2k5WvVAq1G75
X-Received: by 2002:adf:e00b:0:10b0:484:3310:710c with SMTP id
 ffacd0b85a97d-486eb351000mr6405007f8f.24.1789127375431; 
 Fri, 11 Sep 2026 04:49:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb360409sm5043852f8f.36.2026.09.11.04.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 04:49:34 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 11:49:27 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: 8f98f0b457ea3e87bcf64a8b401fe81bb7d88a9c
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4b14887af6124b347108bb15324906bad869a6c4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4zlG-0001Nr-AQ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 useless assignments
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3186494424472656591=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3186494424472656591==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6vkQFKQ4Flg="; charset=UTF-8

--6vkQFKQ4Flg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello plaisthos,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1617?usp=3Demail

to look at the new patch set (#=
20)=2E


Change subject: Remove various useless assignments
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove various useless assig=
nments

The values assigned by these are never actually used
for something=
=2E

Identified by cppcheck=2E

Change-Id: Id0caa497c4ff1ad8743cb23f332f003=
b2d3393ed
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M =
dev-tools/cppcheck-suppression
M src/openvpn/console_builtin=2Ec
M src/open=
vpn/crypto=2Ec
M src/openvpn/error=2Eh
M src/openvpn/forward=2Ec
M src/open=
vpn/manage=2Ec
M src/openvpn/options=2Ec
M src/openvpn/pkcs11=2Ec
M src/ope=
nvpn/pkcs11_openssl=2Ec
M src/openvpn/push_util=2Ec
M src/openvpn/socket=2E=
c
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/win32=2Ec
M src/openvpnmsica/=
openvpnmsica=2Ec
M src/tapctl/tap=2Ec
M tests/unit_tests/openvpn/test_ssl=
=2Ec
16 files changed, 43 insertions(+), 63 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/17/1617/20

diff --git a=
/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index e1ff=
e37=2E=2E299d7a3 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tool=
s/cppcheck-suppression
@@ -5,9 +5,6 @@
 constParameterPointer
 invalidPrint=
fArgType_sint
 invalidPrintfArgType_uint
-redundantAssignment
-redundantIni=
tialization
-unreadVariable
 unusedFunction
 usleepCalled
 variableScope
@@=
 -74,7 +71,7 @@
 # IGN: strlen(NULL) is not nice code, but seems to work
 n=
ullPointerRedundantCheck:src/openvpn/init=2Ec:301
 # FP: cppcheck doesn't u=
nderstand ZeroMemory
-redundantAssignment:src/openvpnserv/interactive=2Ec:2=
03
+redundantAssignment:src/openvpnserv/interactive=2Ec:204
 # IGN: We reus=
e the same variable name due to macro usage
 shadowVariable:src/openvpn/opt=
ions=2Ec:1948
 shadowVariable:src/openvpn/options=2Ec:1966
diff --git a/src=
/openvpn/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec
index 2a9f3b=
6=2E=2E9c8d72a 100644
--- a/src/openvpn/console_builtin=2Ec
+++ b/src/openv=
pn/console_builtin=2Ec
@@ -192,7 +192,6 @@
 static bool
 get_console_input(=
const char *prompt, const bool echo, char *input, const int capacity)
 {
- =
   bool ret =3D false;
     ASSERT(prompt);
     ASSERT(input);
     ASSERT=
(capacity > 0);
@@ -200,8 +199,11 @@
 
 #if defined(_WIN32)
     return get=
_console_input_win32(prompt, echo, input, capacity);
-#elif defined(HAVE_TE=
RMIOS_H)
+#elif !defined(HAVE_TERMIOS_H)
+    msg(M_FATAL, "Sorry, but I ca=
n't get console input on this OS (%s)", prompt);
+#else
     bool restore_t=
ty =3D false;
+    bool ret =3D false;
     struct termios tty_tmp, tty_sav=
e;
 
     /* did we --daemon'ize before asking for passwords?
@@ -258,10 +2=
60,8 @@
     }
 
     close_tty(fp);
-#else  /* if defined(_WIN32) */
-    =
msg(M_FATAL, "Sorry, but I can't get console input on this OS (%s)", prompt=
);
-#endif /* if defined(_WIN32) */
     return ret;
+#endif /* if defined(=
_WIN32) */
 }
 
 /**
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/cryp=
to=2Ec
index 8bbc566=2E=2Ee5ad31a 100644
--- a/src/openvpn/crypto=2Ec
+++ b=
/src/openvpn/crypto=2Ec
@@ -1204,8 +1204,6 @@
     struct buffer work =3D a=
lloc_buf_gc(BUF_SIZE(frame), &gc);
     struct buffer encrypt_workspace =3D=
 alloc_buf_gc(BUF_SIZE(frame), &gc);
     struct buffer decrypt_workspace =
=3D alloc_buf_gc(BUF_SIZE(frame), &gc);
-    struct buffer buf =3D clear_bu=
f();
-    void *buf_p;
 
     /* init work */
     ASSERT(buf_init(&work, f=
rame->buf=2Eheadroom));
@@ -1242,8 +1240,8 @@
         prng_bytes(BPTR(&src=
), BLEN(&src));
 
         /* copy source to input buf */
-        buf =3D =
work;
-        buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
+        struc=
t buffer buf =3D work;
+        void *buf_p =3D buf_write_alloc(&buf, BLENZ=
(&src));
         ASSERT(buf_p);
         memcpy(buf_p, BPTR(&src), BLENZ(&=
src));
 
diff --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh
index 4=
5826a2=2E=2Ea887fc7 100644
--- a/src/openvpn/error=2Eh
+++ b/src/openvpn/er=
ror=2Eh
@@ -408,8 +408,8 @@
 openvpn_errno_maybe_crt(bool *crt_error)
 {
  =
   int err =3D 0;
-    *crt_error =3D false;
 #ifdef _WIN32
+    *crt_error=
 =3D false;
     err =3D GetLastError();
     if (err =3D=3D ERROR_SUCCESS)=

     {
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
inde=
x ad43d40=2E=2E83cd113 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openv=
pn/forward=2Ec
@@ -1746,7 +1746,6 @@
 process_outgoing_link(struct context =
*c, struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();
-   =
 int error_code =3D 0;
 
     if (c->c2=2Eto_link=2Elen > 0 && c->c2=2Eto_l=
ink=2Elen <=3D c->c2=2Eframe=2Ebuf=2Epayload_size)
     {
@@ -1821,7 +1820,=
7 @@
         }
 
         /* Check return status */
-        error_code =
=3D openvpn_errno();
+        int error_code =3D openvpn_errno();
         =
check_status(size, "write", sock, NULL);
 
         if (size > 0)
diff --gi=
t a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 7128196=2E=2E8e46=
470 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -91=
6,10 +916,9 @@
 static void
 man_remote_entry_count(struct management *man)=

 {
-    unsigned count =3D 0;
     if (man->persist=2Ecallback=2Eremote_en=
try_count)
     {
-        count =3D (*man->persist=2Ecallback=2Eremote_ent=
ry_count)(man->persist=2Ecallback=2Earg);
+        unsigned int count =3D (=
*man->persist=2Ecallback=2Eremote_entry_count)(man->persist=2Ecallback=2Ear=
g);
         msg(M_CLIENT, "%u", count);
         msg(M_CLIENT, "END");
   =
  }
@@ -3740,7 +3739,6 @@
     struct gc_arena gc =3D gc_new();
     int re=
t =3D 0;
     volatile int signal_received =3D 0;
-    struct buffer alert_=
msg =3D clear_buf();
     const bool standalone_disabled_save =3D man->pers=
ist=2Estandalone_disabled;
     struct man_connection *mc =3D &man->connect=
ion;
 
@@ -3752,6 +3750,7 @@
 
         *state =3D EKS_SOLICIT;
 
+        =
struct buffer alert_msg;
         if (b64_data)
         {
             ale=
rt_msg =3D alloc_buf_gc(strlen(b64_data) + strlen(prompt) + 3, &gc);
diff -=
-git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 25a3746=2E=
=2E15f2fcd 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -4157,8 +4157,7 @@
 bool
 key_is_external(const struct options *opt=
ions)
 {
-    bool ret =3D false;
-    ret =3D ret || (options->management_=
flags & MF_EXTERNAL_KEY);
+    bool ret =3D options->management_flags & MF_=
EXTERNAL_KEY;
 #ifdef ENABLE_PKCS11
     ret =3D ret || (options->pkcs11_pr=
oviders[0] !=3D NULL);
 #endif
@@ -5697,7 +5696,6 @@
             if (streq=
(p[1], "FORWARD_COMPATIBLE") && p[2] && streq(p[2], "1"))
             {
  =
               options->forward_compatible =3D true;
-                msgle=
vel_fc =3D msglevel_forward_compatible(options, msglevel);
             }
 =
            setenv_str(es, p[1], p[2] ? p[2] : "");
         }
diff --git a=
/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec
index 8b06fd0=2E=2Ed7dee97=
 100644
--- a/src/openvpn/pkcs11=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -80,6 =
+80,9 @@
 static msglvl_t
 _pkcs11_msg_pkcs112openvpn(const unsigned flags)=

 {
+#ifdef ENABLE_PKCS11_FORCE_DEBUG
+    return M_INFO;
+#else
     msglv=
l_t openvpn_flags;
 
     switch (flags)
@@ -109,16 +112,16 @@
            =
 break;
     }
 
-#if defined(ENABLE_PKCS11_FORCE_DEBUG)
-    openvpn_flags=
 =3D M_INFO;
-#endif
-
     return openvpn_flags;
+#endif
 }
 
 static unsi=
gned
 _pkcs11_msg_openvpn2pkcs11(const msglvl_t flags)
 {
+#ifdef ENABLE_PK=
CS11_FORCE_DEBUG
+    return PKCS11H_LOG_DEBUG2;
+#else
     unsigned pkcs1=
1_flags;
 
     if ((flags & D_PKCS11_DEBUG) !=3D 0)
@@ -146,11 +149,8 @@
 =
        pkcs11_flags =3D PKCS11H_LOG_ERROR;
     }
 
-#if defined(ENABLE_PK=
CS11_FORCE_DEBUG)
-    pkcs11_flags =3D PKCS11H_LOG_DEBUG2;
-#endif
-
     =
return pkcs11_flags;
+#endif
 }
 
 static void
diff --git a/src/openvpn/pkc=
s11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec
index b6c1624=2E=2E69c5a50=
 100644
--- a/src/openvpn/pkcs11_openssl=2Ec
+++ b/src/openvpn/pkcs11_opens=
sl=2Ec
@@ -384,7 +384,6 @@
     if (certificate !=3D NULL)
     {
         =
pkcs11h_certificate_freeCertificate(certificate);
-        certificate =3D =
NULL;
     }
 
     /*
@@ -400,7 +399,6 @@
     if (openssl_session !=3D NU=
LL)
     {
         pkcs11h_openssl_freeSession(openssl_session);
-        =
openssl_session =3D NULL;
     }
     return ret;
 #endif                  =
                                        /* ifdef HAVE_XKEY_PROVIDER */
diff=
 --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index fcc541=
1=2E=2E0213041 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/pus=
h_util=2Ec
@@ -99,7 +99,6 @@
     }
 
     char *str =3D gc_strdup(s, gc);
=
-    size_t i =3D 0;
 
     while (*str)
     {
@@ -112,11 +111,11 @@
     =
            /* if no commas were found go to fail, do not send any message =
*/
                 return false;
             }
+            /* copy from =
current position to (ci - 1) */
             str[ci] =3D '\0';
-           =
 /* copy from i to (ci -1) */
             struct buffer tmp =3D forge_msg(=
str, ",push-continuation 2", gc);
             buffer_list_push(msgs, BSTR(=
&tmp));
-            i =3D ci + 1;
+            str +=3D ci + 1;
         }=

         else
         {
@@ -130,9 +129,8 @@
                 struct buffe=
r tmp =3D forge_msg(str, NULL, gc);
                 buffer_list_push(msgs,=
 BSTR(&tmp));
             }
-            i =3D strlen(str);
+            b=
reak;
         }
-        str =3D &str[i];
     }
     return true;
 }
diff=
 --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 7f39268=2E=
=2E73871b2 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec=

@@ -753,7 +753,7 @@
      */
     socklen_t remote_len_af =3D af_addr_size=
(act->dest=2Eaddr=2Esa=2Esa_family);
     socklen_t remote_len =3D sizeof(a=
ct->dest=2Eaddr);
-    socket_descriptor_t new_sd =3D SOCKET_UNDEFINED;
+  =
  socket_descriptor_t new_sd;
 
     CLEAR(*act);
 
diff --git a/src/openvp=
n/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 0b01634=2E=2E7cfe9f4 =
100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
=
@@ -2283,13 +2283,13 @@
     }
 
     int typeid =3D EVP_PKEY_id(pkey);
+
+=
#ifndef OPENSSL_NO_EC
 #if OPENSSL_VERSION_NUMBER < 0x30000000L
     bool i=
s_ec =3D typeid =3D=3D EVP_PKEY_EC;
 #else
     bool is_ec =3D EVP_PKEY_is_=
a(pkey, "EC");
 #endif
-
-#ifndef OPENSSL_NO_EC
     char groupname[64];
  =
   if (is_ec)
     {
@@ -2593,15 +2593,13 @@
            "builtin EC curves=
=2E It does not list additional curves nor X448 or X25519\n");
 #ifndef OPE=
NSSL_NO_EC
     EC_builtin_curve *curves =3D NULL;
-    size_t crv_len =3D =
0;
-    size_t n =3D 0;
 
-    crv_len =3D EC_get_builtin_curves(NULL, 0);
=
+    size_t crv_len =3D EC_get_builtin_curves(NULL, 0);
     ALLOC_ARRAY(cu=
rves, EC_builtin_curve, crv_len);
     if (EC_get_builtin_curves(curves, cr=
v_len))
     {
         printf("\nAvailable Elliptic curves/groups:\n");
- =
       for (n =3D 0; n < crv_len; n++)
+        for (size_t n =3D 0; n < cr=
v_len; n++)
         {
             const char *sname;
             sname =
=3D OBJ_nid2sn(curves[n]=2Enid);
diff --git a/src/openvpn/win32=2Ec b/src/o=
penvpn/win32=2Ec
index 94e79d5e=2E=2E618772d 100644
--- a/src/openvpn/win32=
=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1340,9 +1340,6 @@
     is_wow64_proces=
s2_t is_wow64_process2 =3D
         (is_wow64_process2_t)GetProcAddress(Get=
ModuleHandle("Kernel32=2Edll"), "IsWow64Process2");
 
-    USHORT process_m=
achine =3D 0;
-    USHORT native_machine =3D 0;
-
 #ifdef _ARM64_
     *pro=
cess_arch =3D ARCH_ARM64;
 #elif defined(_WIN64)
@@ -1350,6 +1347,8 @@
    =
 if (is_wow64_process2)
     {
         /* this could be amd64 on arm64 */
=
+        USHORT process_machine =3D 0;
+        USHORT native_machine =3D 0=
;
         BOOL is_wow64 =3D is_wow64_process2(GetCurrentProcess(), &proces=
s_machine, &native_machine);
         if (is_wow64 && native_machine =3D=3D=
 IMAGE_FILE_MACHINE_ARM64)
         {
@@ -1362,6 +1361,8 @@
     if (is_wow=
64_process2)
     {
         /* check if we're running on arm64 or amd64 ma=
chine */
+        USHORT process_machine =3D 0;
+        USHORT native_mach=
ine =3D 0;
         BOOL is_wow64 =3D is_wow64_process2(GetCurrentProcess()=
, &process_machine, &native_machine);
         if (is_wow64)
         {
dif=
f --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=
=2Ec
index 3911006=2E=2Ea861e8a 100644
--- a/src/openvpnmsica/openvpnmsica=
=2Ec
+++ b/src/openvpnmsica/openvpnmsica=2Ec
@@ -711,7 +711,6 @@
         u=
iResult =3D MsiViewFetch(hViewST, &hRecord);
         if (uiResult =3D=3D E=
RROR_NO_MORE_ITEMS)
         {
-            uiResult =3D ERROR_SUCCESS;
   =
          break;
         }
         else if (uiResult !=3D ERROR_SUCCESS)
=
diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec
index 769df6c=2E=2Edd2=
2cc5 100644
--- a/src/tapctl/tap=2Ec
+++ b/src/tapctl/tap=2Ec
@@ -473,7 +47=
3,7 @@
                         return ERROR_OUTOFMEMORY;
                 =
    }
 
-                    dwCountExpResult =3D ExpandEnvironmentStrings(=
szValue, szValueExp, dwCountExp);
+                    ExpandEnvironmentStr=
ings(szValue, szValueExp, dwCountExp);
                     free(szValue);
=
                     *pszValue =3D szValueExp;
                     return =
ERROR_SUCCESS;
@@ -601,8 +601,6 @@
                         _In_ DWORD dwPr=
operty, _Out_opt_ LPDWORD pdwPropertyRegDataType,
                         =
_Out_ LPVOID *ppData)
 {
-    DWORD dwResult =3D ERROR_BAD_ARGUMENTS;
-
   =
  if (ppData =3D=3D NULL)
     {
         return ERROR_BAD_ARGUMENTS;
@@ -6=
28,7 +626,7 @@
     }
     else
     {
-        dwResult =3D GetLastError()=
;
+        DWORD dwResult =3D GetLastError();
         if (dwResult =3D=3D =
ERROR_INSUFFICIENT_BUFFER)
         {
             /* Allocate on heap and =
retry=2E */
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit=
_tests/openvpn/test_ssl=2Ec
index fcebcdb=2E=2E4baf8cc 100644
--- a/tests/u=
nit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
=
@@ -217,7 +217,7 @@
 
 #if !defined(HAVE_OPENSSL_STORE)
     skip();
-#else=
  /* HAVE_OPENSSL_STORE */
+#else /* HAVE_OPENSSL_STORE */
 
     struct tl=
s_root_ctx ctx =3D { 0 };
     const char *certfile =3D global_state=2Ecert=
file;
@@ -228,9 +228,10 @@
     struct buffer keyuri =3D alloc_buf_gc(6 + s=
trlen(keyfile) + 1, gc);   /* 6 bytes for "file:/" */
 
     /* Windows tem=
p file path starts with drive letter -- add a leading slash for URI */
-   =
 const char *lead =3D "";
 #ifdef _WIN32
-    lead =3D "/";
+    const char=
 *lead =3D "/";
+#else
+    const char *lead =3D "";
 #endif /* _WIN32 */
 =
    assert_true(buf_printf(&certuri, "file:%s%s", lead, certfile));
     as=
sert_true(buf_printf(&keyuri, "file:%s%s", lead, keyfile));
@@ -292,8 +293,=
6 @@
     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     =
struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
  =
   struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);=

-    struct buffer buf =3D clear_buf();
-    void *buf_p;
 
     /* init w=
ork */
     ASSERT(buf_init(&work, frame=2Ebuf=2Eheadroom));
@@ -314,8 +313=
,8 @@
         prng_bytes(BPTR(&src), BLEN(&src));
 
         /* copy sourc=
e to input buf */
-        buf =3D work;
-        buf_p =3D buf_write_alloc=
(&buf, BLENZ(&src));
+        struct buffer buf =3D work;
+        void *bu=
f_p =3D buf_write_alloc(&buf, BLENZ(&src));
         ASSERT(buf_p);
       =
  memcpy(buf_p, BPTR(&src), BLENZ(&src));
 
@@ -345,7 +344,6 @@
     struct=
 buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     str=
uct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     =
struct buffer work =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
-    struct buf=
fer buf =3D clear_buf();
     struct buffer src =3D alloc_buf_gc(frame=2Ebu=
f=2Epayload_size, &gc);
     void *buf_p;
 
@@ -360,7 +358,7 @@
     prng_b=
ytes(BPTR(&src), BLEN(&src));
 
     /* copy source to input buf */
-    bu=
f =3D work;
+    struct buffer buf =3D work;
     buf_p =3D buf_write_alloc=
(&buf, BLENZ(&src));
     ASSERT(buf_p);
     memcpy(buf_p, BPTR(&src), BLE=
NZ(&src));
@@ -641,7 +639,6 @@
     struct buffer work =3D alloc_buf_gc(BUF=
_SIZE(&frame), &gc);
     struct buffer encrypt_workspace =3D alloc_buf_gc(=
BUF_SIZE(&frame), &gc);
     struct buffer decrypt_workspace =3D alloc_buf_=
gc(BUF_SIZE(&frame), &gc);
-    struct buffer buf =3D clear_buf();
     voi=
d *buf_p;
 
     /* init work */
@@ -658,7 +655,7 @@
     ASSERT(buf_write(=
&src, plaintext, strlen(plaintext)));
 
     /* copy source to input buf */=

-    buf =3D work;
+    struct buffer buf =3D work;
     buf_p =3D buf_wri=
te_alloc(&buf, BLENZ(&src));
     ASSERT(buf_p);
     memcpy(buf_p, BPTR(&s=
rc), BLENZ(&src));

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1617?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
Gerrit-Change-Number: 1617
Gerr=
it-PatchSet: 20
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: stipa <lstipakov@gmail=2Ecom>

--6vkQFKQ4Flg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>flichtenheld <strong>uplo=
aded patch set #20</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Remove various useless assignments<br><br>The values assigned by thes=
e are never actually used<br>for something=2E<br><br>Identified by cppcheck=
=2E<br><br>Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-to=
ols/cppcheck-suppression<br>M src/openvpn/console_builtin=2Ec<br>M src/open=
vpn/crypto=2Ec<br>M src/openvpn/error=2Eh<br>M src/openvpn/forward=2Ec<br>M=
 src/openvpn/manage=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/pkcs1=
1=2Ec<br>M src/openvpn/pkcs11_openssl=2Ec<br>M src/openvpn/push_util=2Ec<br=
>M src/openvpn/socket=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn=
/win32=2Ec<br>M src/openvpnmsica/openvpnmsica=2Ec<br>M src/tapctl/tap=2Ec<b=
r>M tests/unit_tests/openvpn/test_ssl=2Ec<br>16 files changed, 43 insertion=
s(+), 63 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/17/1617/20</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-=
tools/cppcheck-suppression b/dev-tools/cppcheck-suppression</span><br><span=
>index e1ffe37=2E=2E299d7a3 100644</span><br><span>--- a/dev-tools/cppcheck=
-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppression</span><br=
><span>@@ -5,9 +5,6 @@</span><br><span> constParameterPointer</span><br><sp=
an> invalidPrintfArgType_sint</span><br><span> invalidPrintfArgType_uint</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-redundantAssignment</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-redundantInitialization</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-unreadVariable</span><br=
><span> unusedFunction</span><br><span> usleepCalled</span><br><span> varia=
bleScope</span><br><span>@@ -74,7 +71,7 @@</span><br><span> # IGN: strlen(N=
ULL) is not nice code, but seems to work</span><br><span> nullPointerRedund=
antCheck:src/openvpn/init=2Ec:301</span><br><span> # FP: cppcheck doesn&#39=
;t understand ZeroMemory</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-redundantAssignment:src/openvpnserv/interactive=2Ec:203</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+redundantAssignment:src/openvpnserv/=
interactive=2Ec:204</span><br><span> # IGN: We reuse the same variable name=
 due to macro usage</span><br><span> shadowVariable:src/openvpn/options=2Ec=
:1948</span><br><span> shadowVariable:src/openvpn/options=2Ec:1966</span><b=
r><span>diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/console_=
builtin=2Ec</span><br><span>index 2a9f3b6=2E=2E9c8d72a 100644</span><br><sp=
an>--- a/src/openvpn/console_builtin=2Ec</span><br><span>+++ b/src/openvpn/=
console_builtin=2Ec</span><br><span>@@ -192,7 +192,6 @@</span><br><span> st=
atic bool</span><br><span> get_console_input(const char *prompt, const bool=
 echo, char *input, const int capacity)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br><spa=
n>     ASSERT(prompt);</span><br><span>     ASSERT(input);</span><br><span>=
     ASSERT(capacity &gt; 0);</span><br><span>@@ -200,8 +199,11 @@</span><b=
r><span> </span><br><span> #if defined(_WIN32)</span><br><span>     return =
get_console_input_win32(prompt, echo, input, capacity);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#elif defined(HAVE_TERMIOS_H)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#elif !defined(HAVE_TERMIOS_H)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL, &qu=
ot;Sorry, but I can&#39;t get console input on this OS (%s)&quot;, prompt);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><sp=
an>     bool restore_tty =3D false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool ret =3D false;</span><br><span>     struct termios=
 tty_tmp, tty_save;</span><br><span> </span><br><span>     /* did we --daem=
on&#39;ize before asking for passwords?</span><br><span>@@ -258,10 +260,8 @=
@</span><br><span>     }</span><br><span> </span><br><span>     close_tty(f=
p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if defin=
ed(_WIN32) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(=
M_FATAL, &quot;Sorry, but I can&#39;t get console input on this OS (%s)&quo=
t;, prompt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /*=
 if defined(_WIN32) */</span><br><span>     return ret;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(_WIN32) */</span><=
br><span> }</span><br><span> </span><br><span> /**</span><br><span>diff --g=
it a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index =
8bbc566=2E=2Ee5ad31a 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</s=
pan><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1204,8 +1204=
,6 @@</span><br><span>     struct buffer work =3D alloc_buf_gc(BUF_SIZE(fra=
me), &amp;gc);</span><br><span>     struct buffer encrypt_workspace =3D all=
oc_buf_gc(BUF_SIZE(frame), &amp;gc);</span><br><span>     struct buffer dec=
rypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &amp;gc);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D clear_buf();=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    void *buf_p;</spa=
n><br><span> </span><br><span>     /* init work */</span><br><span>     ASS=
ERT(buf_init(&amp;work, frame-&gt;buf=2Eheadroom));</span><br><span>@@ -124=
2,8 +1240,8 @@</span><br><span>         prng_bytes(BPTR(&amp;src), BLEN(&am=
p;src));</span><br><span> </span><br><span>         /* copy source to input=
 buf */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf =
=3D work;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_=
p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct buffer buf =3D work;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        void *buf_p =3D buf_w=
rite_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>         ASSERT(buf_=
p);</span><br><span>         memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src))=
;</span><br><span> </span><br><span>diff --git a/src/openvpn/error=2Eh b/sr=
c/openvpn/error=2Eh</span><br><span>index 45826a2=2E=2Ea887fc7 100644</span=
><br><span>--- a/src/openvpn/error=2Eh</span><br><span>+++ b/src/openvpn/er=
ror=2Eh</span><br><span>@@ -408,8 +408,8 @@</span><br><span> openvpn_errno_=
maybe_crt(bool *crt_error)</span><br><span> {</span><br><span>     int err =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *crt_error =
=3D false;</span><br><span> #ifdef _WIN32</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    *crt_error =3D false;</span><br><span>     err =
=3D GetLastError();</span><br><span>     if (err =3D=3D ERROR_SUCCESS)</spa=
n><br><span>     {</span><br><span>diff --git a/src/openvpn/forward=2Ec b/s=
rc/openvpn/forward=2Ec</span><br><span>index ad43d40=2E=2E83cd113 100644</s=
pan><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openv=
pn/forward=2Ec</span><br><span>@@ -1746,7 +1746,6 @@</span><br><span> proce=
ss_outgoing_link(struct context *c, struct link_socket *sock)</span><br><sp=
an> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int error_code =3D 0;</span><br><=
span> </span><br><span>     if (c-&gt;c2=2Eto_link=2Elen &gt; 0 &amp;&amp; =
c-&gt;c2=2Eto_link=2Elen &lt;=3D c-&gt;c2=2Eframe=2Ebuf=2Epayload_size)</sp=
an><br><span>     {</span><br><span>@@ -1821,7 +1820,7 @@</span><br><span> =
        }</span><br><span> </span><br><span>         /* Check return status=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        error_code=
 =3D openvpn_errno();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        int error_code =3D openvpn_errno();</span><br><span>         chec=
k_status(size, &quot;write&quot;, sock, NULL);</span><br><span> </span><br>=
<span>         if (size &gt; 0)</span><br><span>diff --git a/src/openvpn/ma=
nage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 7128196=2E=2E8e4647=
0 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b=
/src/openvpn/manage=2Ec</span><br><span>@@ -916,10 +916,9 @@</span><br><spa=
n> static void</span><br><span> man_remote_entry_count(struct management *m=
an)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    unsigned count =3D 0;</span><br><span>     if (man-&gt;persist=2Ecallb=
ack=2Eremote_entry_count)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        count =3D (*man-&gt;persist=2Ecallback=
=2Eremote_entry_count)(man-&gt;persist=2Ecallback=2Earg);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        unsigned int count =3D (*man-=
&gt;persist=2Ecallback=2Eremote_entry_count)(man-&gt;persist=2Ecallback=2Ea=
rg);</span><br><span>         msg(M_CLIENT, &quot;%u&quot;, count);</span><=
br><span>         msg(M_CLIENT, &quot;END&quot;);</span><br><span>     }</s=
pan><br><span>@@ -3740,7 +3739,6 @@</span><br><span>     struct gc_arena gc=
 =3D gc_new();</span><br><span>     int ret =3D 0;</span><br><span>     vol=
atile int signal_received =3D 0;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct buffer alert_msg =3D clear_buf();</span><br><span>   =
  const bool standalone_disabled_save =3D man-&gt;persist=2Estandalone_disa=
bled;</span><br><span>     struct man_connection *mc =3D &amp;man-&gt;conne=
ction;</span><br><span> </span><br><span>@@ -3752,6 +3750,7 @@</span><br><s=
pan> </span><br><span>         *state =3D EKS_SOLICIT;</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer =
alert_msg;</span><br><span>         if (b64_data)</span><br><span>         =
{</span><br><span>             alert_msg =3D alloc_buf_gc(strlen(b64_data) =
+ strlen(prompt) + 3, &amp;gc);</span><br><span>diff --git a/src/openvpn/op=
tions=2Ec b/src/openvpn/options=2Ec</span><br><span>index 25a3746=2E=2E15f2=
fcd 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>++=
+ b/src/openvpn/options=2Ec</span><br><span>@@ -4157,8 +4157,7 @@</span><br=
><span> bool</span><br><span> key_is_external(const struct options *options=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   bool ret =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ret =3D ret || (options-&gt;management_flags &amp; MF_EXTERNAL_KEY);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D opti=
ons-&gt;management_flags &amp; MF_EXTERNAL_KEY;</span><br><span> #ifdef ENA=
BLE_PKCS11</span><br><span>     ret =3D ret || (options-&gt;pkcs11_provider=
s[0] !=3D NULL);</span><br><span> #endif</span><br><span>@@ -5697,7 +5696,6=
 @@</span><br><span>             if (streq(p[1], &quot;FORWARD_COMPATIBLE&q=
uot;) &amp;&amp; p[2] &amp;&amp; streq(p[2], &quot;1&quot;))</span><br><spa=
n>             {</span><br><span>                 options-&gt;forward_compa=
tible =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          msglevel_fc =3D msglevel_forward_compatible(options, msglevel);</=
span><br><span>             }</span><br><span>             setenv_str(es, p=
[1], p[2] ? p[2] : &quot;&quot;);</span><br><span>         }</span><br><spa=
n>diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec</span><br><s=
pan>index 8b06fd0=2E=2Ed7dee97 100644</span><br><span>--- a/src/openvpn/pkc=
s11=2Ec</span><br><span>+++ b/src/openvpn/pkcs11=2Ec</span><br><span>@@ -80=
,6 +80,9 @@</span><br><span> static msglvl_t</span><br><span> _pkcs11_msg_p=
kcs112openvpn(const unsigned flags)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PKCS11_FORCE_DEBUG</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return M_INFO;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span>     m=
sglvl_t openvpn_flags;</span><br><span> </span><br><span>     switch (flags=
)</span><br><span>@@ -109,16 +112,16 @@</span><br><span>             break;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(ENABLE_PKCS11_FORCE_DEBUG)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    openvpn_flags =3D M_INFO;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     return openvpn_flags;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan> }</span><br><span> </span><br><span> static unsigned</span><br><span> =
_pkcs11_msg_openvpn2pkcs11(const msglvl_t flags)</span><br><span> {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PKCS11_FORCE_=
DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return PKC=
S11H_LOG_DEBUG2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#el=
se</span><br><span>     unsigned pkcs11_flags;</span><br><span> </span><br>=
<span>     if ((flags &amp; D_PKCS11_DEBUG) !=3D 0)</span><br><span>@@ -146=
,11 +149,8 @@</span><br><span>         pkcs11_flags =3D PKCS11H_LOG_ERROR;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(ENABLE_PKCS11_FORCE_DEBUG)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    pkcs11_flags =3D PKCS11H_LOG_DEBUG2=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     return pkcs11=
_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span> }</span><br><span> </span><br><span> static void</span><br><spa=
n>diff --git a/src/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=
=2Ec</span><br><span>index b6c1624=2E=2E69c5a50 100644</span><br><span>--- =
a/src/openvpn/pkcs11_openssl=2Ec</span><br><span>+++ b/src/openvpn/pkcs11_o=
penssl=2Ec</span><br><span>@@ -384,7 +384,6 @@</span><br><span>     if (cer=
tificate !=3D NULL)</span><br><span>     {</span><br><span>         pkcs11h=
_certificate_freeCertificate(certificate);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        certificate =3D NULL;</span><br><span>     }</=
span><br><span> </span><br><span>     /*</span><br><span>@@ -400,7 +399,6 @=
@</span><br><span>     if (openssl_session !=3D NULL)</span><br><span>     =
{</span><br><span>         pkcs11h_openssl_freeSession(openssl_session);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        openssl_session =
=3D NULL;</span><br><span>     }</span><br><span>     return ret;</span><br=
><span> #endif                                                          /* =
ifdef HAVE_XKEY_PROVIDER */</span><br><span>diff --git a/src/openvpn/push_u=
til=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index fcc5411=2E=2E0213=
041 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</span><br><span>=
+++ b/src/openvpn/push_util=2Ec</span><br><span>@@ -99,7 +99,6 @@</span><br=
><span>     }</span><br><span> </span><br><span>     char *str =3D gc_strdu=
p(s, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t i=
 =3D 0;</span><br><span> </span><br><span>     while (*str)</span><br><span=
>     {</span><br><span>@@ -112,11 +111,11 @@</span><br><span>             =
    /* if no commas were found go to fail, do not send any message */</span=
><br><span>                 return false;</span><br><span>             }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* copy fr=
om current position to (ci - 1) */</span><br><span>             str[ci] =3D=
 &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     /* copy from i to (ci -1) */</span><br><span>             struct buffe=
r tmp =3D forge_msg(str, &quot;,push-continuation 2&quot;, gc);</span><br><=
span>             buffer_list_push(msgs, BSTR(&amp;tmp));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            i =3D ci + 1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            str +=3D ci + 1;</spa=
n><br><span>         }</span><br><span>         else</span><br><span>      =
   {</span><br><span>@@ -130,9 +129,8 @@</span><br><span>                 s=
truct buffer tmp =3D forge_msg(str, NULL, gc);</span><br><span>            =
     buffer_list_push(msgs, BSTR(&amp;tmp));</span><br><span>             }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i =3D str=
len(str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  break;</span><br><span>         }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        str =3D &amp;str[i];</span><br><span>     }</span><br=
><span>     return true;</span><br><span> }</span><br><span>diff --git a/sr=
c/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 7f39268=
=2E=2E73871b2 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br=
><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -753,7 +753,7 @@</sp=
an><br><span>      */</span><br><span>     socklen_t remote_len_af =3D af_a=
ddr_size(act-&gt;dest=2Eaddr=2Esa=2Esa_family);</span><br><span>     sockle=
n_t remote_len =3D sizeof(act-&gt;dest=2Eaddr);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    socket_descriptor_t new_sd =3D SOCKET_UNDEFIN=
ED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socket_descr=
iptor_t new_sd;</span><br><span> </span><br><span>     CLEAR(*act);</span><=
br><span> </span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/o=
penvpn/ssl_openssl=2Ec</span><br><span>index 0b01634=2E=2E7cfe9f4 100644</s=
pan><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/o=
penvpn/ssl_openssl=2Ec</span><br><span>@@ -2283,13 +2283,13 @@</span><br><s=
pan>     }</span><br><span> </span><br><span>     int typeid =3D EVP_PKEY_i=
d(pkey);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OPENSSL_NO_EC</span><b=
r><span> #if OPENSSL_VERSION_NUMBER &lt; 0x30000000L</span><br><span>     b=
ool is_ec =3D typeid =3D=3D EVP_PKEY_EC;</span><br><span> #else</span><br><=
span>     bool is_ec =3D EVP_PKEY_is_a(pkey, &quot;EC&quot;);</span><br><sp=
an> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifndef OPENSSL_NO_EC</span><br>=
<span>     char groupname[64];</span><br><span>     if (is_ec)</span><br><s=
pan>     {</span><br><span>@@ -2593,15 +2593,13 @@</span><br><span>        =
    &quot;builtin EC curves=2E It does not list additional curves nor X448 =
or X25519\n&quot;);</span><br><span> #ifndef OPENSSL_NO_EC</span><br><span>=
     EC_builtin_curve *curves =3D NULL;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    size_t crv_len =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    size_t n =3D 0;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    crv_len =3D EC_get_builtin_curves=
(NULL, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_=
t crv_len =3D EC_get_builtin_curves(NULL, 0);</span><br><span>     ALLOC_AR=
RAY(curves, EC_builtin_curve, crv_len);</span><br><span>     if (EC_get_bui=
ltin_curves(curves, crv_len))</span><br><span>     {</span><br><span>      =
   printf(&quot;\nAvailable Elliptic curves/groups:\n&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        for (n =3D 0; n &lt; crv_le=
n; n++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for =
(size_t n =3D 0; n &lt; crv_len; n++)</span><br><span>         {</span><br>=
<span>             const char *sname;</span><br><span>             sname =
=3D OBJ_nid2sn(curves[n]=2Enid);</span><br><span>diff --git a/src/openvpn/w=
in32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index 94e79d5e=2E=2E618772=
d 100644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/=
src/openvpn/win32=2Ec</span><br><span>@@ -1340,9 +1340,6 @@</span><br><span=
>     is_wow64_process2_t is_wow64_process2 =3D</span><br><span>         (i=
s_wow64_process2_t)GetProcAddress(GetModuleHandle(&quot;Kernel32=2Edll&quot=
;), &quot;IsWow64Process2&quot;);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    USHORT process_machine =3D 0;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    USHORT native_machine =3D 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #i=
fdef _ARM64_</span><br><span>     *process_arch =3D ARCH_ARM64;</span><br><=
span> #elif defined(_WIN64)</span><br><span>@@ -1350,6 +1347,8 @@</span><br=
><span>     if (is_wow64_process2)</span><br><span>     {</span><br><span> =
        /* this could be amd64 on arm64 */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        USHORT process_machine =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        USHORT native_machine =3D =
0;</span><br><span>         BOOL is_wow64 =3D is_wow64_process2(GetCurrentP=
rocess(), &amp;process_machine, &amp;native_machine);</span><br><span>     =
    if (is_wow64 &amp;&amp; native_machine =3D=3D IMAGE_FILE_MACHINE_ARM64)=
</span><br><span>         {</span><br><span>@@ -1362,6 +1361,8 @@</span><br=
><span>     if (is_wow64_process2)</span><br><span>     {</span><br><span> =
        /* check if we&#39;re running on arm64 or amd64 machine */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        USHORT process_machi=
ne =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        US=
HORT native_machine =3D 0;</span><br><span>         BOOL is_wow64 =3D is_wo=
w64_process2(GetCurrentProcess(), &amp;process_machine, &amp;native_machine=
);</span><br><span>         if (is_wow64)</span><br><span>         {</span>=
<br><span>diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica=
/openvpnmsica=2Ec</span><br><span>index 3911006=2E=2Ea861e8a 100644</span><=
br><span>--- a/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>+++ b/src/=
openvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -711,7 +711,6 @@</span><br=
><span>         uiResult =3D MsiViewFetch(hViewST, &amp;hRecord);</span><br=
><span>         if (uiResult =3D=3D ERROR_NO_MORE_ITEMS)</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            u=
iResult =3D ERROR_SUCCESS;</span><br><span>             break;</span><br><s=
pan>         }</span><br><span>         else if (uiResult !=3D ERROR_SUCCES=
S)</span><br><span>diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec</sp=
an><br><span>index 769df6c=2E=2Edd22cc5 100644</span><br><span>--- a/src/ta=
pctl/tap=2Ec</span><br><span>+++ b/src/tapctl/tap=2Ec</span><br><span>@@ -4=
73,7 +473,7 @@</span><br><span>                         return ERROR_OUTOFM=
EMORY;</span><br><span>                     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    dwCountExpRes=
ult =3D ExpandEnvironmentStrings(szValue, szValueExp, dwCountExp);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    ExpandEn=
vironmentStrings(szValue, szValueExp, dwCountExp);</span><br><span>        =
             free(szValue);</span><br><span>                     *pszValue =
=3D szValueExp;</span><br><span>                     return ERROR_SUCCESS;<=
/span><br><span>@@ -601,8 +601,6 @@</span><br><span>                       =
  _In_ DWORD dwProperty, _Out_opt_ LPDWORD pdwPropertyRegDataType,</span><b=
r><span>                         _Out_ LPVOID *ppData)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD dwResult =3D =
ERROR_BAD_ARGUMENTS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span>     if (ppData =3D=3D NULL)</span><br><span>     {</span><=
br><span>         return ERROR_BAD_ARGUMENTS;</span><br><span>@@ -628,7 +62=
6,7 @@</span><br><span>     }</span><br><span>     else</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dwResult =
=3D GetLastError();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        DWORD dwResult =3D GetLastError();</span><br><span>         if (dwR=
esult =3D=3D ERROR_INSUFFICIENT_BUFFER)</span><br><span>         {</span><b=
r><span>             /* Allocate on heap and retry=2E */</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn=
/test_ssl=2Ec</span><br><span>index fcebcdb=2E=2E4baf8cc 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/test=
s/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -217,7 +217,7 @@</span=
><br><span> </span><br><span> #if !defined(HAVE_OPENSSL_STORE)</span><br><s=
pan>     skip();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else=
  /* HAVE_OPENSSL_STORE */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#else /* HAVE_OPENSSL_STORE */</span><br><span> </span><br><span>   =
  struct tls_root_ctx ctx =3D { 0 };</span><br><span>     const char *certf=
ile =3D global_state=2Ecertfile;</span><br><span>@@ -228,9 +228,10 @@</span=
><br><span>     struct buffer keyuri =3D alloc_buf_gc(6 + strlen(keyfile) +=
 1, gc);   /* 6 bytes for &quot;file:/&quot; */</span><br><span> </span><br=
><span>     /* Windows temp file path starts with drive letter -- add a lea=
ding slash for URI */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    const char *lead =3D &quot;&quot;;</span><br><span> #ifdef _WIN32</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    lead =3D &quot;/&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *lea=
d =3D &quot;/&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *lead =3D &quot;&quot;;</span><br><span> #endif /* _WIN32 */</span><br><s=
pan>     assert_true(buf_printf(&amp;certuri, &quot;file:%s%s&quot;, lead, =
certfile));</span><br><span>     assert_true(buf_printf(&amp;keyuri, &quot;=
file:%s%s&quot;, lead, keyfile));</span><br><span>@@ -292,8 +293,6 @@</span=
><br><span>     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &=
amp;gc);</span><br><span>     struct buffer encrypt_workspace =3D alloc_buf=
_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>     struct buffer decr=
ypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D clear_bu=
f();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    void *buf_p;<=
/span><br><span> </span><br><span>     /* init work */</span><br><span>    =
 ASSERT(buf_init(&amp;work, frame=2Ebuf=2Eheadroom));</span><br><span>@@ -3=
14,8 +313,8 @@</span><br><span>         prng_bytes(BPTR(&amp;src), BLEN(&am=
p;src));</span><br><span> </span><br><span>         /* copy source to input=
 buf */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf =
=3D work;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_=
p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct buffer buf =3D work;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        void *buf_p =3D buf_w=
rite_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>         ASSERT(buf_=
p);</span><br><span>         memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src))=
;</span><br><span> </span><br><span>@@ -345,7 +344,6 @@</span><br><span>   =
  struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &a=
mp;gc);</span><br><span>     struct buffer decrypt_workspace =3D alloc_buf_=
gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>     struct buffer work =
=3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct buffer buf =3D clear_buf();</span><br=
><span>     struct buffer src =3D alloc_buf_gc(frame=2Ebuf=2Epayload_size, =
&amp;gc);</span><br><span>     void *buf_p;</span><br><span> </span><br><sp=
an>@@ -360,7 +358,7 @@</span><br><span>     prng_bytes(BPTR(&amp;src), BLEN=
(&amp;src));</span><br><span> </span><br><span>     /* copy source to input=
 buf */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf =3D wo=
rk;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffe=
r buf =3D work;</span><br><span>     buf_p =3D buf_write_alloc(&amp;buf, BL=
ENZ(&amp;src));</span><br><span>     ASSERT(buf_p);</span><br><span>     me=
mcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src));</span><br><span>@@ -641,7 +63=
9,6 @@</span><br><span>     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&a=
mp;frame), &amp;gc);</span><br><span>     struct buffer encrypt_workspace =
=3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>     struc=
t buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf=
 =3D clear_buf();</span><br><span>     void *buf_p;</span><br><span> </span=
><br><span>     /* init work */</span><br><span>@@ -658,7 +655,7 @@</span><=
br><span>     ASSERT(buf_write(&amp;src, plaintext, strlen(plaintext)));</s=
pan><br><span> </span><br><span>     /* copy source to input buf */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    buf =3D work;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D work;=
</span><br><span>     buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));=
</span><br><span>     ASSERT(buf_p);</span><br><span>     memcpy(buf_p, BPT=
R(&amp;src), BLENZ(&amp;src));</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demai=
l">change 1617</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/16=
17?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1617 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: st=
ipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>

</body></html>
--6vkQFKQ4Flg=--


--===============3186494424472656591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3186494424472656591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3186494424472656591==--

