Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB03AC61DBE
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWr51GstW1Joawgw+0Bhr5akHumC1lVy+nPe5vitVMo=; b=kLoKF/rcZJ9MCgu0Va8/zYOIU2
	v531O14Q+jkZwlHSVdohNynC5oCeUJXZEZB9C5qh4jDAOI5YacjOfeMcdjHVgnUcaWKEGJs5S8Kpa
	MNWXtdBWkAaLL+O2+b9njC7tpiz9WsrMVva6TCUSp2TKELbsNS73Z5Glam0lahE2Fc04=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wytLN-00069J-DJ;
	Tue, 25 Aug 2026 15:45:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wytLL-000694-J7
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:45:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5Oj4OlyW3s7Vm78ZaNPffcqeOLmc0c06vx3ky2o2QzE=; b=AiK6DrCVbKZj9pt2tpCqzWPAaz
 0rqn15CGd90s0s9IXmPlkFuKFfSj/FRFrt2Dey3/ban427+MuNmpJjfa8Qxg6KyCcVfuDVM9iTAzz
 yXRJ1y4vVhtpON64mZL4tjyIK6Ex05UCsdn86nDuSm6YOlQd5gTbUrJIl2hKpUKnODJE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5Oj4OlyW3s7Vm78ZaNPffcqeOLmc0c06vx3ky2o2QzE=; b=k
 nUHYnP/8HI6V1cBJCNMSxikuAIr2aLzCcRuAkEfVl5G6uuWHk1oyLv4VvikAqZsHsNAJOfBj03d/L
 6ppY2luDaFD33VftVcij0fNAIcs69m7iiQpOuhCRg+OD9DZxvDnSYOXepl7bdgCIB3JQv/xxqHIX4
 MP2AfCu3J7YLlNMw=;
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wytLF-0002Cd-Gu for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:45:40 +0000
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6a1542cdb53so6009832a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787672731; x=1788277531; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5Oj4OlyW3s7Vm78ZaNPffcqeOLmc0c06vx3ky2o2QzE=;
 b=Ggw7zkBDKgZmeHi9bILZ+SFhs8huDNEW1PjAb7ooAAOnM92zYi4YhQUps3UgfrlxXu
 ajyhtEr6v3PLzhUXSe86Lt/YjSlODdeCmRffeLQ+yARYcL6tDuGSYj9lXjRRYO2FIcAC
 26gUuoRSygA7FZnAGWitBs0UYs4TQs2TgENhlJfd7DeOKDT7bkGqmtlNIUkwlu7GIgoY
 KcW+msSjTygPEASjW3S5BAwt8t1s7HASFnhZdnkcsFUMSvMU5sFCCR0hnaMQvE+DlstF
 lo6VfeLbIzlN+cm/d0Obga9uzhPfyVGI15SR0n8JWGN3qxXEvK1VM3ZZTrgzG5N56lzn
 DF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787672731; x=1788277531;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5Oj4OlyW3s7Vm78ZaNPffcqeOLmc0c06vx3ky2o2QzE=;
 b=hCwdUkds3YvJt1euFcTYYuUSH6KlTN1aiZoLI878xt5FT+BRZ8YELwoz7qy45gdATu
 BZtzgXcj93pCM3Ik9Qcr7INUCIHkILMeMAqXex475bZo5x36Jy342FbLidDkb6v6/Rk7
 FG4zoX/bgezvmsEunKPTIJuicC+9CL5kgQFZDKtMJKerRF8bC4+Acg7QtDLgmk2PYBDM
 az/2IVM8jEskAHJj9nIWdT+N+4nNG7/eA7hzL3wAB19vEgtLcefkgq3Bq18atmb+6QKJ
 teCYKVP1g9nzSokmZuSrHKuP4DtDVJX9T3fnewQZHFGW7EdcgJrDYL3nrG9S9eZ9FMWD
 XqIg==
X-Gm-Message-State: AFuF++msvxv0C9Y6HFqiMIyQjd97OQpmDSTR3wqZBGqELeDO2khUntkB
 sv9mFumCaJ5QiD8nwktc3pbrQtfHiDxZdB5aVIOcTR+HkyFoaelUhreNcGWHY8avDPB/XzaZwRT
 xgiX50cD0ilQu7EoFywBn29oaOpb6ATDXIsZeueyeo9Bf2zNC1UZdJFgQ7EBBSRn2VAWB
X-Gm-Gg: AR+sD12Yg6ZnGsjnKytbE+iRM0QcwcV1ZV1VoDd/2212htu5hmTokPxPEUPsMZQOXJ5
 tY8qxOoAo4gcsngScbuuo5/ahIjuRjdorkSam7MKGqAKcG4vDAegnFwNiFOLIUeCCjGOJsAh+64
 WgJDs08b3ZuJ/IIjxDUNs2eaxdQx8RabAqhfTTqKeBnumln9gOTQw5WOlYsrqudWCdTEwCoNt/2
 0u0pR/vX6JB57UIx4Rpi8ZpGwGWfRg8CnUR97SNbowu5kKJWTPHJHhbRvpsI+Ryu6GzCIE/wSFL
 DINa8FZ5Q4rz/tuuKQahDSxeQO32NEt6ulFvmm+xn1zyrUIKsFNYlSGqNzLabTsD41+u5MS5ugq
 dojjtz/BtzgQ3vmuc/86hsXtw2fu6nig8UL3hKq8fy/JUKdWLxdrG+gWPcaYJYIHOd/hi895pf2
 tZ+c0eJE/W/ghdbv4VAgT20UbY580R3FWWTq31C5anUzmZ9lM/WsZ7A5nH1wCDbkQEJt05swOH3
 /J8Rz5yxvIuUlBUG4Mi0mAOS1N/QklcvDtkQgXt02qAE/0GkxvX0tYac2N0Bqob7upPQ/As5yoW
 rg/rKHVTRepIxP4sVlhuGEyM4gBQC7fAy/hzd3XErHXDAADt36U=
X-Received: by 2002:a05:6402:1f4f:b0:6a4:b50:f8f2 with SMTP id
 4fb4d7f45d1cf-6a582b8fc84mr34324035a12.16.1787672730591; 
 Tue, 25 Aug 2026 08:45:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deae179fsm338378a12.26.2026.08.25.08.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 08:45:29 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 15:45:20 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: 2f8404e57fbea3ac43e3ac449f46c7802dc945be
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <87a1608a9e3ae346c309d34f187faf9e8ecb5559-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wytLF-0002Cd-Gu
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
Content-Type: multipart/mixed; boundary="===============8192811356061974582=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8192811356061974582==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="O3DuZjivyb8="; charset=UTF-8

--O3DuZjivyb8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello plaisthos,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1617?usp=3Demail

to look at the new patch set (#=
15)=2E


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
16 files changed, 38 insertions(+), 58 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/17/1617/15

diff --git a=
/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index a585=
513=2E=2E2a3cf2e 100644
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
 -77,7 +74,7 @@
 # IGN: strlen(NULL) is not nice code, but seems to work
 n=
ullPointerRedundantCheck:src/openvpn/init=2Ec:301
 # FP: cppcheck doesn't u=
nderstand ZeroMemory
-redundantAssignment:src/openvpnserv/interactive=2Ec:2=
03
+redundantAssignment:src/openvpnserv/interactive=2Ec:204
 # FP: cppcheck=
 doesn't know the NLA macros
 redundantInitialization:src/openvpn/dco_linux=
=2Ec
 # IGN: We reuse the same variable name due to macro usage
diff --git =
a/src/openvpn/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec
index 2=
a9f3b6=2E=2E9c8d72a 100644
--- a/src/openvpn/console_builtin=2Ec
+++ b/src/=
openvpn/console_builtin=2Ec
@@ -192,7 +192,6 @@
 static bool
 get_console_i=
nput(const char *prompt, const bool echo, char *input, const int capacity)
=
 {
-    bool ret =3D false;
     ASSERT(prompt);
     ASSERT(input);
     A=
SSERT(capacity > 0);
@@ -200,8 +199,11 @@
 
 #if defined(_WIN32)
     retur=
n get_console_input_win32(prompt, echo, input, capacity);
-#elif defined(HA=
VE_TERMIOS_H)
+#elif !defined(HAVE_TERMIOS_H)
+    msg(M_FATAL, "Sorry, but=
 I can't get console input on this OS (%s)", prompt);
+#else
     bool rest=
ore_tty =3D false;
+    bool ret =3D false;
     struct termios tty_tmp, tt=
y_save;
 
     /* did we --daemon'ize before asking for passwords?
@@ -258,=
10 +260,8 @@
     }
 
     close_tty(fp);
-#else  /* if defined(_WIN32) */
=
-    msg(M_FATAL, "Sorry, but I can't get console input on this OS (%s)", p=
rompt);
-#endif /* if defined(_WIN32) */
     return ret;
+#endif /* if def=
ined(_WIN32) */
 }
 
 /**
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn=
/crypto=2Ec
index 8bbc566=2E=2Ee5ad31a 100644
--- a/src/openvpn/crypto=2Ec
=
+++ b/src/openvpn/crypto=2Ec
@@ -1204,8 +1204,6 @@
     struct buffer work =
=3D alloc_buf_gc(BUF_SIZE(frame), &gc);
     struct buffer encrypt_workspac=
e =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
     struct buffer decrypt_worksp=
ace =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
-    struct buffer buf =3D clea=
r_buf();
-    void *buf_p;
 
     /* init work */
     ASSERT(buf_init(&wor=
k, frame->buf=2Eheadroom));
@@ -1242,8 +1240,8 @@
         prng_bytes(BPTR(=
&src), BLEN(&src));
 
         /* copy source to input buf */
-        buf =
=3D work;
-        buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
+        s=
truct buffer buf =3D work;
+        void *buf_p =3D buf_write_alloc(&buf, B=
LENZ(&src));
         ASSERT(buf_p);
         memcpy(buf_p, BPTR(&src), BLE=
NZ(&src));
 
diff --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh
ind=
ex 45826a2=2E=2Ea887fc7 100644
--- a/src/openvpn/error=2Eh
+++ b/src/openvp=
n/error=2Eh
@@ -408,8 +408,8 @@
 openvpn_errno_maybe_crt(bool *crt_error)
 =
{
     int err =3D 0;
-    *crt_error =3D false;
 #ifdef _WIN32
+    *crt_e=
rror =3D false;
     err =3D GetLastError();
     if (err =3D=3D ERROR_SUCC=
ESS)
     {
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
=
index 2ade321=2E=2E6581998 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/o=
penvpn/forward=2Ec
@@ -1746,7 +1746,6 @@
 process_outgoing_link(struct cont=
ext *c, struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();
=
-    int error_code =3D 0;
 
     if (c->c2=2Eto_link=2Elen > 0 && c->c2=2E=
to_link=2Elen <=3D c->c2=2Eframe=2Ebuf=2Epayload_size)
     {
@@ -1821,7 +1=
820,7 @@
         }
 
         /* Check return status */
-        error_cod=
e =3D openvpn_errno();
+        int error_code =3D openvpn_errno();
       =
  check_status(size, "write", sock, NULL);
 
         if (size > 0)
diff --=
git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 2b0a661=2E=2E60=
4bbcd 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -=
916,10 +916,9 @@
 static void
 man_remote_entry_count(struct management *ma=
n)
 {
-    unsigned count =3D 0;
     if (man->persist=2Ecallback=2Eremote_=
entry_count)
     {
-        count =3D (*man->persist=2Ecallback=2Eremote_e=
ntry_count)(man->persist=2Ecallback=2Earg);
+        unsigned int count =3D=
 (*man->persist=2Ecallback=2Eremote_entry_count)(man->persist=2Ecallback=2E=
arg);
         msg(M_CLIENT, "%u", count);
         msg(M_CLIENT, "END");
 =
    }
@@ -3743,7 +3742,6 @@
     struct gc_arena gc =3D gc_new();
     int =
ret =3D 0;
     volatile int signal_received =3D 0;
-    struct buffer aler=
t_msg =3D clear_buf();
     const bool standalone_disabled_save =3D man->pe=
rsist=2Estandalone_disabled;
     struct man_connection *mc =3D &man->conne=
ction;
 
@@ -3755,6 +3753,7 @@
 
         *state =3D EKS_SOLICIT;
 
+      =
  struct buffer alert_msg;
         if (b64_data)
         {
             a=
lert_msg =3D alloc_buf_gc(strlen(b64_data) + strlen(prompt) + 3, &gc);
diff=
 --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 23741f0=2E=
=2Eb210a5d 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -5691,7 +5691,6 @@
             if (streq(p[1], "FORWARD_COMPATIBLE=
") && p[2] && streq(p[2], "1"))
             {
                 options->fo=
rward_compatible =3D true;
-                msglevel_fc =3D msglevel_forwar=
d_compatible(options, msglevel);
             }
             setenv_str(es,=
 p[1], p[2] ? p[2] : "");
         }
diff --git a/src/openvpn/pkcs11=2Ec b/=
src/openvpn/pkcs11=2Ec
index 8b06fd0=2E=2Ed7dee97 100644
--- a/src/openvpn/=
pkcs11=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -80,6 +80,9 @@
 static msglvl_t
=
 _pkcs11_msg_pkcs112openvpn(const unsigned flags)
 {
+#ifdef ENABLE_PKCS11_=
FORCE_DEBUG
+    return M_INFO;
+#else
     msglvl_t openvpn_flags;
 
     =
switch (flags)
@@ -109,16 +112,16 @@
             break;
     }
 
-#if defi=
ned(ENABLE_PKCS11_FORCE_DEBUG)
-    openvpn_flags =3D M_INFO;
-#endif
-
   =
  return openvpn_flags;
+#endif
 }
 
 static unsigned
 _pkcs11_msg_openvpn2=
pkcs11(const msglvl_t flags)
 {
+#ifdef ENABLE_PKCS11_FORCE_DEBUG
+    retu=
rn PKCS11H_LOG_DEBUG2;
+#else
     unsigned pkcs11_flags;
 
     if ((flags=
 & D_PKCS11_DEBUG) !=3D 0)
@@ -146,11 +149,8 @@
         pkcs11_flags =3D P=
KCS11H_LOG_ERROR;
     }
 
-#if defined(ENABLE_PKCS11_FORCE_DEBUG)
-    pkc=
s11_flags =3D PKCS11H_LOG_DEBUG2;
-#endif
-
     return pkcs11_flags;
+#end=
if
 }
 
 static void
diff --git a/src/openvpn/pkcs11_openssl=2Ec b/src/open=
vpn/pkcs11_openssl=2Ec
index b6c1624=2E=2E69c5a50 100644
--- a/src/openvpn/=
pkcs11_openssl=2Ec
+++ b/src/openvpn/pkcs11_openssl=2Ec
@@ -384,7 +384,6 @@=

     if (certificate !=3D NULL)
     {
         pkcs11h_certificate_freeCe=
rtificate(certificate);
-        certificate =3D NULL;
     }
 
     /*
@@ =
-400,7 +399,6 @@
     if (openssl_session !=3D NULL)
     {
         pkcs11=
h_openssl_freeSession(openssl_session);
-        openssl_session =3D NULL;
=
     }
     return ret;
 #endif                                            =
              /* ifdef HAVE_XKEY_PROVIDER */
diff --git a/src/openvpn/push_=
util=2Ec b/src/openvpn/push_util=2Ec
index fcc5411=2E=2E0213041 100644
--- =
a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -99,7 +99,6 =
@@
     }
 
     char *str =3D gc_strdup(s, gc);
-    size_t i =3D 0;
 
   =
  while (*str)
     {
@@ -112,11 +111,11 @@
                 /* if no comma=
s were found go to fail, do not send any message */
                 return=
 false;
             }
+            /* copy from current position to (ci - =
1) */
             str[ci] =3D '\0';
-            /* copy from i to (ci -1)=
 */
             struct buffer tmp =3D forge_msg(str, ",push-continuation 2=
", gc);
             buffer_list_push(msgs, BSTR(&tmp));
-            i =3D=
 ci + 1;
+            str +=3D ci + 1;
         }
         else
         {
=
@@ -130,9 +129,8 @@
                 struct buffer tmp =3D forge_msg(str, N=
ULL, gc);
                 buffer_list_push(msgs, BSTR(&tmp));
            =
 }
-            i =3D strlen(str);
+            break;
         }
-        =
str =3D &str[i];
     }
     return true;
 }
diff --git a/src/openvpn/socke=
t=2Ec b/src/openvpn/socket=2Ec
index fba0a22=2E=2E50126bf 100644
--- a/src/=
openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -761,7 +761,7 @@
      *=
/
     socklen_t remote_len_af =3D af_addr_size(act->dest=2Eaddr=2Esa=2Esa_=
family);
     socklen_t remote_len =3D sizeof(act->dest=2Eaddr);
-    socke=
t_descriptor_t new_sd =3D SOCKET_UNDEFINED;
+    socket_descriptor_t new_sd=
;
 
     CLEAR(*act);
 
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/open=
vpn/ssl_openssl=2Ec
index 0b01634=2E=2E7cfe9f4 100644
--- a/src/openvpn/ssl=
_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -2283,13 +2283,13 @@
    =
 }
 
     int typeid =3D EVP_PKEY_id(pkey);
+
+#ifndef OPENSSL_NO_EC
 #if O=
PENSSL_VERSION_NUMBER < 0x30000000L
     bool is_ec =3D typeid =3D=3D EVP_P=
KEY_EC;
 #else
     bool is_ec =3D EVP_PKEY_is_a(pkey, "EC");
 #endif
-
-#i=
fndef OPENSSL_NO_EC
     char groupname[64];
     if (is_ec)
     {
@@ -259=
3,15 +2593,13 @@
            "builtin EC curves=2E It does not list additio=
nal curves nor X448 or X25519\n");
 #ifndef OPENSSL_NO_EC
     EC_builtin_c=
urve *curves =3D NULL;
-    size_t crv_len =3D 0;
-    size_t n =3D 0;
 
- =
   crv_len =3D EC_get_builtin_curves(NULL, 0);
+    size_t crv_len =3D EC_g=
et_builtin_curves(NULL, 0);
     ALLOC_ARRAY(curves, EC_builtin_curve, crv_=
len);
     if (EC_get_builtin_curves(curves, crv_len))
     {
         prin=
tf("\nAvailable Elliptic curves/groups:\n");
-        for (n =3D 0; n < crv=
_len; n++)
+        for (size_t n =3D 0; n < crv_len; n++)
         {
     =
        const char *sname;
             sname =3D OBJ_nid2sn(curves[n]=2Eni=
d);
diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index 44b010=
d=2E=2E81437c1 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=
=2Ec
@@ -1293,9 +1293,6 @@
     is_wow64_process2_t is_wow64_process2 =3D
 =
        (is_wow64_process2_t)GetProcAddress(GetModuleHandle("Kernel32=2Edll=
"), "IsWow64Process2");
 
-    USHORT process_machine =3D 0;
-    USHORT na=
tive_machine =3D 0;
-
 #ifdef _ARM64_
     *process_arch =3D ARCH_ARM64;
 #=
elif defined(_WIN64)
@@ -1303,6 +1300,8 @@
     if (is_wow64_process2)
    =
 {
         /* this could be amd64 on arm64 */
+        USHORT process_mach=
ine =3D 0;
+        USHORT native_machine =3D 0;
         BOOL is_wow64 =3D=
 is_wow64_process2(GetCurrentProcess(), &process_machine, &native_machine);=

         if (is_wow64 && native_machine =3D=3D IMAGE_FILE_MACHINE_ARM64)
 =
        {
@@ -1315,6 +1314,8 @@
     if (is_wow64_process2)
     {
        =
 /* check if we're running on arm64 or amd64 machine */
+        USHORT pro=
cess_machine =3D 0;
+        USHORT native_machine =3D 0;
         BOOL is_=
wow64 =3D is_wow64_process2(GetCurrentProcess(), &process_machine, &native_=
machine);
         if (is_wow64)
         {
diff --git a/src/openvpnmsica/o=
penvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index 3911006=2E=2Ea861=
e8a 100644
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/openvpnmsica/o=
penvpnmsica=2Ec
@@ -711,7 +711,6 @@
         uiResult =3D MsiViewFetch(hVie=
wST, &hRecord);
         if (uiResult =3D=3D ERROR_NO_MORE_ITEMS)
         =
{
-            uiResult =3D ERROR_SUCCESS;
             break;
         }
 =
        else if (uiResult !=3D ERROR_SUCCESS)
diff --git a/src/tapctl/tap=
=2Ec b/src/tapctl/tap=2Ec
index 1d94988=2E=2Ecccc0e1 100644
--- a/src/tapct=
l/tap=2Ec
+++ b/src/tapctl/tap=2Ec
@@ -473,7 +473,7 @@
                    =
     return ERROR_OUTOFMEMORY;
                     }
 
-                  =
  dwCountExpResult =3D ExpandEnvironmentStrings(szValue, szValueExp, dwCoun=
tExp);
+                    ExpandEnvironmentStrings(szValue, szValueExp, d=
wCountExp);
                     free(szValue);
                     *pszVa=
lue =3D szValueExp;
                     return ERROR_SUCCESS;
@@ -601,8 +6=
01,6 @@
                         _In_ DWORD dwProperty, _Out_opt_ LPDWORD p=
dwPropertyRegDataType,
                         _Out_ LPVOID *ppData)
 {
- =
   DWORD dwResult =3D ERROR_BAD_ARGUMENTS;
-
     if (ppData =3D=3D NULL)
 =
    {
         return ERROR_BAD_ARGUMENTS;
@@ -628,7 +626,7 @@
     }
     =
else
     {
-        dwResult =3D GetLastError();
+        DWORD dwResult =
=3D GetLastError();
         if (dwResult =3D=3D ERROR_INSUFFICIENT_BUFFER)=

         {
             /* Allocate on heap and retry=2E */
diff --git a/t=
ests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2E=
c
index 887c492=2E=2E963e8cb 100644
--- a/tests/unit_tests/openvpn/test_ssl=
=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -292,8 +292,6 @@
     s=
truct buffer work =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buff=
er encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct b=
uffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
-    struc=
t buffer buf =3D clear_buf();
-    void *buf_p;
 
     /* init work */
    =
 ASSERT(buf_init(&work, frame=2Ebuf=2Eheadroom));
@@ -314,8 +312,8 @@
     =
    prng_bytes(BPTR(&src), BLEN(&src));
 
         /* copy source to input =
buf */
-        buf =3D work;
-        buf_p =3D buf_write_alloc(&buf, BLEN=
Z(&src));
+        struct buffer buf =3D work;
+        void *buf_p =3D buf=
_write_alloc(&buf, BLENZ(&src));
         ASSERT(buf_p);
         memcpy(bu=
f_p, BPTR(&src), BLENZ(&src));
 
@@ -345,7 +343,6 @@
     struct buffer enc=
rypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer =
decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buff=
er work =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
-    struct buffer buf =3D=
 clear_buf();
     struct buffer src =3D alloc_buf_gc(frame=2Ebuf=2Epayload=
_size, &gc);
     void *buf_p;
 
@@ -360,7 +357,7 @@
     prng_bytes(BPTR(&=
src), BLEN(&src));
 
     /* copy source to input buf */
-    buf =3D work;=

+    struct buffer buf =3D work;
     buf_p =3D buf_write_alloc(&buf, BLEN=
Z(&src));
     ASSERT(buf_p);
     memcpy(buf_p, BPTR(&src), BLENZ(&src));
=
@@ -641,7 +638,6 @@
     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&fram=
e), &gc);
     struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&f=
rame), &gc);
     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE=
(&frame), &gc);
-    struct buffer buf =3D clear_buf();
     void *buf_p;
 =

     /* init work */
@@ -658,7 +654,7 @@
     ASSERT(buf_write(&src, plain=
text, strlen(plaintext)));
 
     /* copy source to input buf */
-    buf =
=3D work;
+    struct buffer buf =3D work;
     buf_p =3D buf_write_alloc(&=
buf, BLENZ(&src));
     ASSERT(buf_p);
     memcpy(buf_p, BPTR(&src), BLENZ=
(&src));

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id0caa49=
7c4ff1ad8743cb23f332f003b2d3393ed
Gerrit-Change-Number: 1617
Gerrit-PatchSe=
t: 15
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-CC: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: st=
ipa <lstipakov@gmail=2Ecom>

--O3DuZjivyb8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>flichtenheld <strong>uplo=
aded patch set #15</strong> to this change=2E</p><p><a href=3D"http://gerri=
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
r>M tests/unit_tests/openvpn/test_ssl=2Ec<br>16 files changed, 38 insertion=
s(+), 58 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/17/1617/15</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-=
tools/cppcheck-suppression b/dev-tools/cppcheck-suppression</span><br><span=
>index a585513=2E=2E2a3cf2e 100644</span><br><span>--- a/dev-tools/cppcheck=
-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppression</span><br=
><span>@@ -5,9 +5,6 @@</span><br><span> constParameterPointer</span><br><sp=
an> invalidPrintfArgType_sint</span><br><span> invalidPrintfArgType_uint</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-redundantAssignment</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-redundantInitialization</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-unreadVariable</span><br=
><span> unusedFunction</span><br><span> usleepCalled</span><br><span> varia=
bleScope</span><br><span>@@ -77,7 +74,7 @@</span><br><span> # IGN: strlen(N=
ULL) is not nice code, but seems to work</span><br><span> nullPointerRedund=
antCheck:src/openvpn/init=2Ec:301</span><br><span> # FP: cppcheck doesn&#39=
;t understand ZeroMemory</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-redundantAssignment:src/openvpnserv/interactive=2Ec:203</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+redundantAssignment:src/openvpnserv/=
interactive=2Ec:204</span><br><span> # FP: cppcheck doesn&#39;t know the NL=
A macros</span><br><span> redundantInitialization:src/openvpn/dco_linux=2Ec=
</span><br><span> # IGN: We reuse the same variable name due to macro usage=
</span><br><span>diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn=
/console_builtin=2Ec</span><br><span>index 2a9f3b6=2E=2E9c8d72a 100644</spa=
n><br><span>--- a/src/openvpn/console_builtin=2Ec</span><br><span>+++ b/src=
/openvpn/console_builtin=2Ec</span><br><span>@@ -192,7 +192,6 @@</span><br>=
<span> static bool</span><br><span> get_console_input(const char *prompt, c=
onst bool echo, char *input, const int capacity)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</span=
><br><span>     ASSERT(prompt);</span><br><span>     ASSERT(input);</span><=
br><span>     ASSERT(capacity &gt; 0);</span><br><span>@@ -200,8 +199,11 @@=
</span><br><span> </span><br><span> #if defined(_WIN32)</span><br><span>   =
  return get_console_input_win32(prompt, echo, input, capacity);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(HAVE_TERMIOS_H)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif !defined(HAVE_TE=
RMIOS_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_F=
ATAL, &quot;Sorry, but I can&#39;t get console input on this OS (%s)&quot;,=
 prompt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</spa=
n><br><span>     bool restore_tty =3D false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span>     struc=
t termios tty_tmp, tty_save;</span><br><span> </span><br><span>     /* did =
we --daemon&#39;ize before asking for passwords?</span><br><span>@@ -258,10=
 +260,8 @@</span><br><span>     }</span><br><span> </span><br><span>     cl=
ose_tty(fp);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /*=
 if defined(_WIN32) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    msg(M_FATAL, &quot;Sorry, but I can&#39;t get console input on this OS=
 (%s)&quot;, prompt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif /* if defined(_WIN32) */</span><br><span>     return ret;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(_WIN32) *=
/</span><br><span> }</span><br><span> </span><br><span> /**</span><br><span=
>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><sp=
an>index 8bbc566=2E=2Ee5ad31a 100644</span><br><span>--- a/src/openvpn/cryp=
to=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -120=
4,8 +1204,6 @@</span><br><span>     struct buffer work =3D alloc_buf_gc(BUF=
_SIZE(frame), &amp;gc);</span><br><span>     struct buffer encrypt_workspac=
e =3D alloc_buf_gc(BUF_SIZE(frame), &amp;gc);</span><br><span>     struct b=
uffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &amp;gc);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D cle=
ar_buf();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    void *bu=
f_p;</span><br><span> </span><br><span>     /* init work */</span><br><span=
>     ASSERT(buf_init(&amp;work, frame-&gt;buf=2Eheadroom));</span><br><spa=
n>@@ -1242,8 +1240,8 @@</span><br><span>         prng_bytes(BPTR(&amp;src),=
 BLEN(&amp;src));</span><br><span> </span><br><span>         /* copy source=
 to input buf */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   buf =3D work;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct buffer buf =3D work;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        void *buf_p =
=3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>         AS=
SERT(buf_p);</span><br><span>         memcpy(buf_p, BPTR(&amp;src), BLENZ(&=
amp;src));</span><br><span> </span><br><span>diff --git a/src/openvpn/error=
=2Eh b/src/openvpn/error=2Eh</span><br><span>index 45826a2=2E=2Ea887fc7 100=
644</span><br><span>--- a/src/openvpn/error=2Eh</span><br><span>+++ b/src/o=
penvpn/error=2Eh</span><br><span>@@ -408,8 +408,8 @@</span><br><span> openv=
pn_errno_maybe_crt(bool *crt_error)</span><br><span> {</span><br><span>    =
 int err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *c=
rt_error =3D false;</span><br><span> #ifdef _WIN32</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    *crt_error =3D false;</span><br><span>  =
   err =3D GetLastError();</span><br><span>     if (err =3D=3D ERROR_SUCCES=
S)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/forward=
=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 2ade321=2E=2E6581998 1=
00644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/s=
rc/openvpn/forward=2Ec</span><br><span>@@ -1746,7 +1746,6 @@</span><br><spa=
n> process_outgoing_link(struct context *c, struct link_socket *sock)</span=
><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    int error_code =3D 0;</sp=
an><br><span> </span><br><span>     if (c-&gt;c2=2Eto_link=2Elen &gt; 0 &am=
p;&amp; c-&gt;c2=2Eto_link=2Elen &lt;=3D c-&gt;c2=2Eframe=2Ebuf=2Epayload_s=
ize)</span><br><span>     {</span><br><span>@@ -1821,7 +1820,7 @@</span><br=
><span>         }</span><br><span> </span><br><span>         /* Check retur=
n status */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        er=
ror_code =3D openvpn_errno();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        int error_code =3D openvpn_errno();</span><br><span>     =
    check_status(size, &quot;write&quot;, sock, NULL);</span><br><span> </s=
pan><br><span>         if (size &gt; 0)</span><br><span>diff --git a/src/op=
envpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 2b0a661=2E=
=2E604bbcd 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><s=
pan>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -916,10 +916,9 @@</span=
><br><span> static void</span><br><span> man_remote_entry_count(struct mana=
gement *man)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    unsigned count =3D 0;</span><br><span>     if (man-&gt;persis=
t=2Ecallback=2Eremote_entry_count)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        count =3D (*man-&gt;persist=2Ec=
allback=2Eremote_entry_count)(man-&gt;persist=2Ecallback=2Earg);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int count =3D=
 (*man-&gt;persist=2Ecallback=2Eremote_entry_count)(man-&gt;persist=2Ecallb=
ack=2Earg);</span><br><span>         msg(M_CLIENT, &quot;%u&quot;, count);<=
/span><br><span>         msg(M_CLIENT, &quot;END&quot;);</span><br><span>  =
   }</span><br><span>@@ -3743,7 +3742,6 @@</span><br><span>     struct gc_a=
rena gc =3D gc_new();</span><br><span>     int ret =3D 0;</span><br><span> =
    volatile int signal_received =3D 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct buffer alert_msg =3D clear_buf();</span><br><s=
pan>     const bool standalone_disabled_save =3D man-&gt;persist=2Estandalo=
ne_disabled;</span><br><span>     struct man_connection *mc =3D &amp;man-&g=
t;connection;</span><br><span> </span><br><span>@@ -3755,6 +3753,7 @@</span=
><br><span> </span><br><span>         *state =3D EKS_SOLICIT;</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct =
buffer alert_msg;</span><br><span>         if (b64_data)</span><br><span>  =
       {</span><br><span>             alert_msg =3D alloc_buf_gc(strlen(b64=
_data) + strlen(prompt) + 3, &amp;gc);</span><br><span>diff --git a/src/ope=
nvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 23741f0=2E=
=2Eb210a5d 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><=
span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -5691,7 +5691,6 @@</s=
pan><br><span>             if (streq(p[1], &quot;FORWARD_COMPATIBLE&quot;) =
&amp;&amp; p[2] &amp;&amp; streq(p[2], &quot;1&quot;))</span><br><span>    =
         {</span><br><span>                 options-&gt;forward_compatible =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    msglevel_fc =3D msglevel_forward_compatible(options, msglevel);</span><=
br><span>             }</span><br><span>             setenv_str(es, p[1], p=
[2] ? p[2] : &quot;&quot;);</span><br><span>         }</span><br><span>diff=
 --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec</span><br><span>in=
dex 8b06fd0=2E=2Ed7dee97 100644</span><br><span>--- a/src/openvpn/pkcs11=2E=
c</span><br><span>+++ b/src/openvpn/pkcs11=2Ec</span><br><span>@@ -80,6 +80=
,9 @@</span><br><span> static msglvl_t</span><br><span> _pkcs11_msg_pkcs112=
openvpn(const unsigned flags)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#ifdef ENABLE_PKCS11_FORCE_DEBUG</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return M_INFO;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span>     msglvl_=
t openvpn_flags;</span><br><span> </span><br><span>     switch (flags)</spa=
n><br><span>@@ -109,16 +112,16 @@</span><br><span>             break;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(ENABLE_PKCS11_FORCE_DEBUG)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    openvpn_flags =3D M_INFO;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span>     return openvpn_flags;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> }<=
/span><br><span> </span><br><span> static unsigned</span><br><span> _pkcs11=
_msg_openvpn2pkcs11(const msglvl_t flags)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PKCS11_FORCE_DEBUG</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return PKCS11H_LO=
G_DEBUG2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</spa=
n><br><span>     unsigned pkcs11_flags;</span><br><span> </span><br><span> =
    if ((flags &amp; D_PKCS11_DEBUG) !=3D 0)</span><br><span>@@ -146,11 +14=
9,8 @@</span><br><span>         pkcs11_flags =3D PKCS11H_LOG_ERROR;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(ENABLE_PKCS11_FORCE_DEBUG)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    pkcs11_flags =3D PKCS11H_LOG_DEBUG2;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     return pkcs11_flags;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan> }</span><br><span> </span><br><span> static void</span><br><span>diff =
--git a/src/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec</sp=
an><br><span>index b6c1624=2E=2E69c5a50 100644</span><br><span>--- a/src/op=
envpn/pkcs11_openssl=2Ec</span><br><span>+++ b/src/openvpn/pkcs11_openssl=
=2Ec</span><br><span>@@ -384,7 +384,6 @@</span><br><span>     if (certifica=
te !=3D NULL)</span><br><span>     {</span><br><span>         pkcs11h_certi=
ficate_freeCertificate(certificate);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        certificate =3D NULL;</span><br><span>     }</span><=
br><span> </span><br><span>     /*</span><br><span>@@ -400,7 +399,6 @@</spa=
n><br><span>     if (openssl_session !=3D NULL)</span><br><span>     {</spa=
n><br><span>         pkcs11h_openssl_freeSession(openssl_session);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        openssl_session =3D NU=
LL;</span><br><span>     }</span><br><span>     return ret;</span><br><span=
> #endif                                                          /* ifdef =
HAVE_XKEY_PROVIDER */</span><br><span>diff --git a/src/openvpn/push_util=2E=
c b/src/openvpn/push_util=2Ec</span><br><span>index fcc5411=2E=2E0213041 10=
0644</span><br><span>--- a/src/openvpn/push_util=2Ec</span><br><span>+++ b/=
src/openvpn/push_util=2Ec</span><br><span>@@ -99,7 +99,6 @@</span><br><span=
>     }</span><br><span> </span><br><span>     char *str =3D gc_strdup(s, g=
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t i =3D 0=
;</span><br><span> </span><br><span>     while (*str)</span><br><span>     =
{</span><br><span>@@ -112,11 +111,11 @@</span><br><span>                 /*=
 if no commas were found go to fail, do not send any message */</span><br><=
span>                 return false;</span><br><span>             }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            /* copy from cur=
rent position to (ci - 1) */</span><br><span>             str[ci] =3D &#39;=
\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /=
* copy from i to (ci -1) */</span><br><span>             struct buffer tmp =
=3D forge_msg(str, &quot;,push-continuation 2&quot;, gc);</span><br><span> =
            buffer_list_push(msgs, BSTR(&amp;tmp));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            i =3D ci + 1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            str +=3D ci + 1;</span><b=
r><span>         }</span><br><span>         else</span><br><span>         {=
</span><br><span>@@ -130,9 +129,8 @@</span><br><span>                 struc=
t buffer tmp =3D forge_msg(str, NULL, gc);</span><br><span>                =
 buffer_list_push(msgs, BSTR(&amp;tmp));</span><br><span>             }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            i =3D strlen(=
str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            br=
eak;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        str =3D &amp;str[i];</span><br><span>     }</span><br><sp=
an>     return true;</span><br><span> }</span><br><span>diff --git a/src/op=
envpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index fba0a22=2E=
=2E50126bf 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><s=
pan>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -761,7 +761,7 @@</span>=
<br><span>      */</span><br><span>     socklen_t remote_len_af =3D af_addr=
_size(act-&gt;dest=2Eaddr=2Esa=2Esa_family);</span><br><span>     socklen_t=
 remote_len =3D sizeof(act-&gt;dest=2Eaddr);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    socket_descriptor_t new_sd =3D SOCKET_UNDEFINED;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socket_descript=
or_t new_sd;</span><br><span> </span><br><span>     CLEAR(*act);</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/open=
vpn/ssl_openssl=2Ec</span><br><span>index 0b01634=2E=2E7cfe9f4 100644</span=
><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/open=
vpn/ssl_openssl=2Ec</span><br><span>@@ -2283,13 +2283,13 @@</span><br><span=
>     }</span><br><span> </span><br><span>     int typeid =3D EVP_PKEY_id(p=
key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifndef OPENSSL_NO_EC</span><br><=
span> #if OPENSSL_VERSION_NUMBER &lt; 0x30000000L</span><br><span>     bool=
 is_ec =3D typeid =3D=3D EVP_PKEY_EC;</span><br><span> #else</span><br><spa=
n>     bool is_ec =3D EVP_PKEY_is_a(pkey, &quot;EC&quot;);</span><br><span>=
 #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifndef OPENSSL_NO_EC</span><br><sp=
an>     char groupname[64];</span><br><span>     if (is_ec)</span><br><span=
>     {</span><br><span>@@ -2593,15 +2593,13 @@</span><br><span>           =
 &quot;builtin EC curves=2E It does not list additional curves nor X448 or =
X25519\n&quot;);</span><br><span> #ifndef OPENSSL_NO_EC</span><br><span>   =
  EC_builtin_curve *curves =3D NULL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    size_t crv_len =3D 0;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    size_t n =3D 0;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    crv_len =3D EC_get_builtin_curves(NU=
LL, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t c=
rv_len =3D EC_get_builtin_curves(NULL, 0);</span><br><span>     ALLOC_ARRAY=
(curves, EC_builtin_curve, crv_len);</span><br><span>     if (EC_get_builti=
n_curves(curves, crv_len))</span><br><span>     {</span><br><span>         =
printf(&quot;\nAvailable Elliptic curves/groups:\n&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        for (n =3D 0; n &lt; crv_len; =
n++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (si=
ze_t n =3D 0; n &lt; crv_len; n++)</span><br><span>         {</span><br><sp=
an>             const char *sname;</span><br><span>             sname =3D O=
BJ_nid2sn(curves[n]=2Enid);</span><br><span>diff --git a/src/openvpn/win32=
=2Ec b/src/openvpn/win32=2Ec</span><br><span>index 44b010d=2E=2E81437c1 100=
644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/o=
penvpn/win32=2Ec</span><br><span>@@ -1293,9 +1293,6 @@</span><br><span>    =
 is_wow64_process2_t is_wow64_process2 =3D</span><br><span>         (is_wow=
64_process2_t)GetProcAddress(GetModuleHandle(&quot;Kernel32=2Edll&quot;), &=
quot;IsWow64Process2&quot;);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    USHORT process_machine =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    USHORT native_machine =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _A=
RM64_</span><br><span>     *process_arch =3D ARCH_ARM64;</span><br><span> #=
elif defined(_WIN64)</span><br><span>@@ -1303,6 +1300,8 @@</span><br><span>=
     if (is_wow64_process2)</span><br><span>     {</span><br><span>        =
 /* this could be amd64 on arm64 */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        USHORT process_machine =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        USHORT native_machine =3D 0;</spa=
n><br><span>         BOOL is_wow64 =3D is_wow64_process2(GetCurrentProcess(=
), &amp;process_machine, &amp;native_machine);</span><br><span>         if =
(is_wow64 &amp;&amp; native_machine =3D=3D IMAGE_FILE_MACHINE_ARM64)</span>=
<br><span>         {</span><br><span>@@ -1315,6 +1314,8 @@</span><br><span>=
     if (is_wow64_process2)</span><br><span>     {</span><br><span>        =
 /* check if we&#39;re running on arm64 or amd64 machine */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        USHORT process_machine =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        USHORT na=
tive_machine =3D 0;</span><br><span>         BOOL is_wow64 =3D is_wow64_pro=
cess2(GetCurrentProcess(), &amp;process_machine, &amp;native_machine);</spa=
n><br><span>         if (is_wow64)</span><br><span>         {</span><br><sp=
an>diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvp=
nmsica=2Ec</span><br><span>index 3911006=2E=2Ea861e8a 100644</span><br><spa=
n>--- a/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>+++ b/src/openvpn=
msica/openvpnmsica=2Ec</span><br><span>@@ -711,7 +711,6 @@</span><br><span>=
         uiResult =3D MsiViewFetch(hViewST, &amp;hRecord);</span><br><span>=
         if (uiResult =3D=3D ERROR_NO_MORE_ITEMS)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            uiResult=
 =3D ERROR_SUCCESS;</span><br><span>             break;</span><br><span>   =
      }</span><br><span>         else if (uiResult !=3D ERROR_SUCCESS)</spa=
n><br><span>diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec</span><br>=
<span>index 1d94988=2E=2Ecccc0e1 100644</span><br><span>--- a/src/tapctl/ta=
p=2Ec</span><br><span>+++ b/src/tapctl/tap=2Ec</span><br><span>@@ -473,7 +4=
73,7 @@</span><br><span>                         return ERROR_OUTOFMEMORY;<=
/span><br><span>                     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    dwCountExpResult =3D=
 ExpandEnvironmentStrings(szValue, szValueExp, dwCountExp);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    ExpandEnvironme=
ntStrings(szValue, szValueExp, dwCountExp);</span><br><span>               =
      free(szValue);</span><br><span>                     *pszValue =3D szV=
alueExp;</span><br><span>                     return ERROR_SUCCESS;</span><=
br><span>@@ -601,8 +601,6 @@</span><br><span>                         _In_ =
DWORD dwProperty, _Out_opt_ LPDWORD pdwPropertyRegDataType,</span><br><span=
>                         _Out_ LPVOID *ppData)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD dwResult =3D ERROR_B=
AD_ARGUMENTS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>     if (ppData =3D=3D NULL)</span><br><span>     {</span><br><spa=
n>         return ERROR_BAD_ARGUMENTS;</span><br><span>@@ -628,7 +626,7 @@<=
/span><br><span>     }</span><br><span>     else</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        dwResult =3D GetL=
astError();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
DWORD dwResult =3D GetLastError();</span><br><span>         if (dwResult =
=3D=3D ERROR_INSUFFICIENT_BUFFER)</span><br><span>         {</span><br><spa=
n>             /* Allocate on heap and retry=2E */</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_=
ssl=2Ec</span><br><span>index 887c492=2E=2E963e8cb 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit=
_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -292,8 +292,6 @@</span><br><=
span>     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc=
);</span><br><span>     struct buffer encrypt_workspace =3D alloc_buf_gc(BU=
F_SIZE(&amp;frame), &amp;gc);</span><br><span>     struct buffer decrypt_wo=
rkspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D clear_buf();</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    void *buf_p;</span>=
<br><span> </span><br><span>     /* init work */</span><br><span>     ASSER=
T(buf_init(&amp;work, frame=2Ebuf=2Eheadroom));</span><br><span>@@ -314,8 +=
312,8 @@</span><br><span>         prng_bytes(BPTR(&amp;src), BLEN(&amp;src)=
);</span><br><span> </span><br><span>         /* copy source to input buf *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf =3D work=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_p =3D bu=
f_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct buffer buf =3D work;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        void *buf_p =3D buf_write_all=
oc(&amp;buf, BLENZ(&amp;src));</span><br><span>         ASSERT(buf_p);</spa=
n><br><span>         memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src));</span>=
<br><span> </span><br><span>@@ -345,7 +343,6 @@</span><br><span>     struct=
 buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);<=
/span><br><span>     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_S=
IZE(&amp;frame), &amp;gc);</span><br><span>     struct buffer work =3D allo=
c_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct buffer buf =3D clear_buf();</span><br><span> =
    struct buffer src =3D alloc_buf_gc(frame=2Ebuf=2Epayload_size, &amp;gc)=
;</span><br><span>     void *buf_p;</span><br><span> </span><br><span>@@ -3=
60,7 +357,7 @@</span><br><span>     prng_bytes(BPTR(&amp;src), BLEN(&amp;sr=
c));</span><br><span> </span><br><span>     /* copy source to input buf */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf =3D work;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D work;</span><br><span>     buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&a=
mp;src));</span><br><span>     ASSERT(buf_p);</span><br><span>     memcpy(b=
uf_p, BPTR(&amp;src), BLENZ(&amp;src));</span><br><span>@@ -641,7 +638,6 @@=
</span><br><span>     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;fra=
me), &amp;gc);</span><br><span>     struct buffer encrypt_workspace =3D all=
oc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>     struct buffe=
r decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D cl=
ear_buf();</span><br><span>     void *buf_p;</span><br><span> </span><br><s=
pan>     /* init work */</span><br><span>@@ -658,7 +654,7 @@</span><br><spa=
n>     ASSERT(buf_write(&amp;src, plaintext, strlen(plaintext)));</span><br=
><span> </span><br><span>     /* copy source to input buf */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    buf =3D work;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D work;</span>=
<br><span>     buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span>=
<br><span>     ASSERT(buf_p);</span><br><span>     memcpy(buf_p, BPTR(&amp;=
src), BLENZ(&amp;src));</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">chan=
ge 1617</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1617 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &l=
t;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

=
</body></html>
--O3DuZjivyb8=--


--===============8192811356061974582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8192811356061974582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8192811356061974582==--

