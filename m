Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0160C88E65
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 13:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rmqk//oqDp44dCJHcqfJEWJcO6AWPJszIHPw23IUzys=; b=QEx4HpI536Iu1vPOEl20x35uQE
	NhI5SM0riEEScsAyzIkCRFIPm3K21egkQUX8CZeLNrwJ1EoGZJ2FgZcoqsk+Hf1ZwjHVerYSNAmB1
	NYGUNOShGSW2S+YEB6ZHPfBSusGvORXaP2xoXAkP/lUa3Uzf8fhthmxxwQCyYDqIhDI8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5jun-00031m-3q;
	Sun, 13 Sep 2026 13:06:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5jul-00031e-JN
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 13:06:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EIOhYkI53lf6D3QWCeM8Xh55L7ZlHCQS0WeQKPwuEi4=; b=ixy4ZxoEsEkkwPrkgfkXkwiO+m
 vRNhnAoa5OOSVCgHc9aiRgadYuWJ54Wb2U7RtHf33fpoKI1FgdA+cJwM81uueiTsHU6BlODM9t6gf
 C59/Yun5wDV+L6zQRSgLULKIE/t3EWAGpqztgFHf1+Yp6VxoF4NafaS0LY8tmJLON5Mc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EIOhYkI53lf6D3QWCeM8Xh55L7ZlHCQS0WeQKPwuEi4=; b=X
 Zcwx2J47FCqiDZKRwODKDpaOupEjfUXkjGd5YUfwyNwkVUimeeKSSUKbDf4lK02YwTx4plNSHZb0h
 8g9+A/yfKs3q+6mlPSwma6DINO61fCH2ADo/4H/furbFf3ahuLZ1DSXJ0s7JJUaHhXYJJARIWkqtm
 D3AymC5/LaNFGwhU=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5juh-0006Co-Lu for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 13:06:35 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so6130315e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 06:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789304785; x=1789909585; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EIOhYkI53lf6D3QWCeM8Xh55L7ZlHCQS0WeQKPwuEi4=;
 b=RKwt/EQ/hpDL9f2ybYzv2zXOmapylrLXy8XGCTVCoUea0uMgx1oJn0i8j4uLeHJAei
 W6yMJWVPSEPZ3W55AeSyEv7jzHimAQ47JwZQ2NkkfDr2VHY1W62eJQ5kDMs2Bd9rjtXZ
 fjjryI7stw0NqlIhCuMreFXeP0bJBmGZ6zI2UUeLw+Hf1z2lrWVGm5RqDEXLGAXPmk3M
 JBhZUcmSpoY0LnqomLKECcbqGsof6/RC+uNFlrPy4+LeXtnNLFjsVVM5TPV+yc5lydtt
 fh7ZNSB2A3ju4/2yFCfLe2BDr/fdf+YjAbYycHxdl8iTkGx0/VeiIj0zxUqHm5lejbHF
 W5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789304785; x=1789909585;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EIOhYkI53lf6D3QWCeM8Xh55L7ZlHCQS0WeQKPwuEi4=;
 b=o3L+Gjh42WhScftK6cQG3UXLE9DcoZU0F8OUmRKRwJ6TASD4kTTiOPbA7LmmgAKvPq
 5tCevRhajdO3UI08a0HtUU+Rjn0h+PKzgvPmR8mtQm+LrGXsSbUWiwOJU7eWrO8xsB4d
 e1Iw3xJ0EXsvt/bDafjwcLPoHQWzgii67pVoxm2wSBt1h7DwSDtaxv+YSEpPEzXFCzCt
 +NIiIfBXQc/5Kwf335BblLK3FATWuNZsxXDTjfuJj9H0pXmRv2HDDrvLeGe7GlAKxW9M
 4LFJMdHS6/TgrKlQY/4mDCXUFQihFjgz9niN5lpLqtPwUT7VqN31Vf/6ebx810kPGIYZ
 BiQg==
X-Gm-Message-State: AFuF++nODU3h8pjjyYyXP+WeH106dNnKDY4VuhKJyg/igvNiGBO0nMON
 6m4qm1uVKnHEuOclNOXxhiQevWYD2Z1t5veL6lR8Sz4EH7+n/iTZubN+gj0Ioi2kObR2dHq1KM/
 HY8zrfrwa072JHg7OykPhGW8ECfbI6xGBo4q3VHX2SoHBFouQfwscdTXDlM1wKvXOdZ2W
X-Gm-Gg: AYBFou2i565Jb8TNV+KtDFn0I/zHrfd1JrvkB+Lmg9uhM0njoQL8ixY355jzuVtd3ra
 Xm2frCtr1urrxWcyZVF06SwI683srQ9U2XxSARLKBaoBrl+R4m4yWKmdg/afNdoPVNqM6OUV5+L
 W4apa+rvrHwp5SWhqULZ1xVs3gizd8RQfYBDkuEhUbI8CVeW16W5Ii6q9jK7Z1xvw5RZuNaE8qU
 y6KQY7A+hspZWW+bjKQ5MnGC9fxbkqRkyBCgjFDQyRkkL1sDZwXVaRBvzPodkNh3SN93FNFu+Ib
 7wEFMcci1C2Rt8p2K8YLz81UvbCMSZQctxiT60BtTSsZHk6DtKRDeKT+JvZIWr95EgQkOCjC943
 3yVt8RG4pA7B+VfMA0kKYU8MpKpGKMO+6nh6pI1T+iSCyVhKK1ZdetWh0AzQT54g0RoL3O01+1D
 eYPRa7S43pBezwrTnvd2E93twfU7/yoxqVajB9j41ztH0boDkDRTsrbm1TIdmHX/ITioixZ5+t2
 Kr203SlvbQjWJJWKLyMTwrwxOZ9TxZudXWrl+9L+uZR1qGYL3xpGPB/I1dP3iLo93xbnnLBdNLg
 USdbuavKLNGuEqVzqA7SnG2mdOPsu20deflgUrdeFZhZoknjsbNw+yUrYgL2dg==
X-Received: by 2002:a05:600c:3f16:b0:49c:e1cd:536 with SMTP id
 5b1f17b1804b1-49e6caca0b3mr72753505e9.12.1789304784842; 
 Sun, 13 Sep 2026 06:06:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26b7332asm314923275e9.0.2026.09.13.06.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 06:06:24 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 13 Sep 2026 13:06:22 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: a57e39923d55987336f544ce0c1b3b42c35f0ec0
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5648005050205e57aee1c5f40b81b5835fe47277-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5juh-0006Co-Lu
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3232974718911179460=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3232974718911179460==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GPHy1IitD7w="; charset=UTF-8

--GPHy1IitD7w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#22) to the change originally created b=
y flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Dem=
ail )

The following approvals got outdated and were removed:
Code-Review+2=
 by razvanc


Change subject: Remove various useless assignments
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove various useless=
 assignments

The values assigned by these are never actually used
for some=
thing=2E

Identified by cppcheck=2E

Change-Id: Id0caa497c4ff1ad8743cb23f33=
2f003b2d3393ed
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
A=
cked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1617
Message-Id: <20260912200747=2E26711-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg39142=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppression
M src/openvpn/cons=
ole_builtin=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn/error=2Eh
M src/open=
vpn/forward=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/options=2Ec
M src/op=
envpn/pkcs11=2Ec
M src/openvpn/pkcs11_openssl=2Ec
M src/openvpn/push_util=
=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/w=
in32=2Ec
M src/openvpnmsica/openvpnmsica=2Ec
M src/tapctl/tap=2Ec
M tests/u=
nit_tests/openvpn/test_ssl=2Ec
16 files changed, 43 insertions(+), 63 delet=
ions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/17/1617/22

diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppch=
eck-suppression
index e1ffe37=2E=2E299d7a3 100644
--- a/dev-tools/cppcheck-=
suppression
+++ b/dev-tools/cppcheck-suppression
@@ -5,9 +5,6 @@
 constPara=
meterPointer
 invalidPrintfArgType_sint
 invalidPrintfArgType_uint
-redunda=
ntAssignment
-redundantInitialization
-unreadVariable
 unusedFunction
 usle=
epCalled
 variableScope
@@ -74,7 +71,7 @@
 # IGN: strlen(NULL) is not nice =
code, but seems to work
 nullPointerRedundantCheck:src/openvpn/init=2Ec:301=

 # FP: cppcheck doesn't understand ZeroMemory
-redundantAssignment:src/ope=
nvpnserv/interactive=2Ec:203
+redundantAssignment:src/openvpnserv/interacti=
ve=2Ec:204
 # IGN: We reuse the same variable name due to macro usage
 shad=
owVariable:src/openvpn/options=2Ec:1948
 shadowVariable:src/openvpn/options=
=2Ec:1966
diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/consol=
e_builtin=2Ec
index 2a9f3b6=2E=2E9c8d72a 100644
--- a/src/openvpn/console_b=
uiltin=2Ec
+++ b/src/openvpn/console_builtin=2Ec
@@ -192,7 +192,6 @@
 stati=
c bool
 get_console_input(const char *prompt, const bool echo, char *input,=
 const int capacity)
 {
-    bool ret =3D false;
     ASSERT(prompt);
     =
ASSERT(input);
     ASSERT(capacity > 0);
@@ -200,8 +199,11 @@
 
 #if defin=
ed(_WIN32)
     return get_console_input_win32(prompt, echo, input, capacit=
y);
-#elif defined(HAVE_TERMIOS_H)
+#elif !defined(HAVE_TERMIOS_H)
+    msg=
(M_FATAL, "Sorry, but I can't get console input on this OS (%s)", prompt);
=
+#else
     bool restore_tty =3D false;
+    bool ret =3D false;
     struc=
t termios tty_tmp, tty_save;
 
     /* did we --daemon'ize before asking fo=
r passwords?
@@ -258,10 +260,8 @@
     }
 
     close_tty(fp);
-#else  /* i=
f defined(_WIN32) */
-    msg(M_FATAL, "Sorry, but I can't get console inpu=
t on this OS (%s)", prompt);
-#endif /* if defined(_WIN32) */
     return r=
et;
+#endif /* if defined(_WIN32) */
 }
 
 /**
diff --git a/src/openvpn/cry=
pto=2Ec b/src/openvpn/crypto=2Ec
index 8bbc566=2E=2Ee5ad31a 100644
--- a/sr=
c/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1204,8 +1204,6 @@
   =
  struct buffer work =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
     struct bu=
ffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
     struct =
buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
-    struc=
t buffer buf =3D clear_buf();
-    void *buf_p;
 
     /* init work */
    =
 ASSERT(buf_init(&work, frame->buf=2Eheadroom));
@@ -1242,8 +1240,8 @@
    =
     prng_bytes(BPTR(&src), BLEN(&src));
 
         /* copy source to input=
 buf */
-        buf =3D work;
-        buf_p =3D buf_write_alloc(&buf, BLE=
NZ(&src));
+        struct buffer buf =3D work;
+        void *buf_p =3D bu=
f_write_alloc(&buf, BLENZ(&src));
         ASSERT(buf_p);
         memcpy(b=
uf_p, BPTR(&src), BLENZ(&src));
 
diff --git a/src/openvpn/error=2Eh b/src/=
openvpn/error=2Eh
index 45826a2=2E=2Ea887fc7 100644
--- a/src/openvpn/error=
=2Eh
+++ b/src/openvpn/error=2Eh
@@ -408,8 +408,8 @@
 openvpn_errno_maybe_c=
rt(bool *crt_error)
 {
     int err =3D 0;
-    *crt_error =3D false;
 #ifd=
ef _WIN32
+    *crt_error =3D false;
     err =3D GetLastError();
     if (=
err =3D=3D ERROR_SUCCESS)
     {
diff --git a/src/openvpn/forward=2Ec b/src=
/openvpn/forward=2Ec
index ad43d40=2E=2E83cd113 100644
--- a/src/openvpn/fo=
rward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -1746,7 +1746,6 @@
 process_outg=
oing_link(struct context *c, struct link_socket *sock)
 {
     struct gc_ar=
ena gc =3D gc_new();
-    int error_code =3D 0;
 
     if (c->c2=2Eto_link=
=2Elen > 0 && c->c2=2Eto_link=2Elen <=3D c->c2=2Eframe=2Ebuf=2Epayload_size=
)
     {
@@ -1821,7 +1820,7 @@
         }
 
         /* Check return status=
 */
-        error_code =3D openvpn_errno();
+        int error_code =3D op=
envpn_errno();
         check_status(size, "write", sock, NULL);
 
        =
 if (size > 0)
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec=

index 3039f24=2E=2Ee121b38 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/o=
penvpn/manage=2Ec
@@ -916,10 +916,9 @@
 static void
 man_remote_entry_count=
(struct management *man)
 {
-    unsigned count =3D 0;
     if (man->persis=
t=2Ecallback=2Eremote_entry_count)
     {
-        count =3D (*man->persist=
=2Ecallback=2Eremote_entry_count)(man->persist=2Ecallback=2Earg);
+        =
unsigned int count =3D (*man->persist=2Ecallback=2Eremote_entry_count)(man-=
>persist=2Ecallback=2Earg);
         msg(M_CLIENT, "%u", count);
         m=
sg(M_CLIENT, "END");
     }
@@ -3743,7 +3742,6 @@
     struct gc_arena gc =
=3D gc_new();
     int ret =3D 0;
     volatile int signal_received =3D 0;
=
-    struct buffer alert_msg =3D clear_buf();
     const bool standalone_di=
sabled_save =3D man->persist=2Estandalone_disabled;
     struct man_connect=
ion *mc =3D &man->connection;
 
@@ -3755,6 +3753,7 @@
 
         *state =3D=
 EKS_SOLICIT;
 
+        struct buffer alert_msg;
         if (b64_data)
  =
       {
             alert_msg =3D alloc_buf_gc(strlen(b64_data) + strlen(=
prompt) + 3, &gc);
diff --git a/src/openvpn/options=2Ec b/src/openvpn/optio=
ns=2Ec
index 25a3746=2E=2E15f2fcd 100644
--- a/src/openvpn/options=2Ec
+++ =
b/src/openvpn/options=2Ec
@@ -4157,8 +4157,7 @@
 bool
 key_is_external(cons=
t struct options *options)
 {
-    bool ret =3D false;
-    ret =3D ret || =
(options->management_flags & MF_EXTERNAL_KEY);
+    bool ret =3D options->m=
anagement_flags & MF_EXTERNAL_KEY;
 #ifdef ENABLE_PKCS11
     ret =3D ret |=
| (options->pkcs11_providers[0] !=3D NULL);
 #endif
@@ -5697,7 +5696,6 @@
 =
            if (streq(p[1], "FORWARD_COMPATIBLE") && p[2] && streq(p[2], "1=
"))
             {
                 options->forward_compatible =3D true;
-=
                msglevel_fc =3D msglevel_forward_compatible(options, msglev=
el);
             }
             setenv_str(es, p[1], p[2] ? p[2] : "");
  =
       }
diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec
index=
 8b06fd0=2E=2Ed7dee97 100644
--- a/src/openvpn/pkcs11=2Ec
+++ b/src/openvpn=
/pkcs11=2Ec
@@ -80,6 +80,9 @@
 static msglvl_t
 _pkcs11_msg_pkcs112openvpn(=
const unsigned flags)
 {
+#ifdef ENABLE_PKCS11_FORCE_DEBUG
+    return M_IN=
FO;
+#else
     msglvl_t openvpn_flags;
 
     switch (flags)
@@ -109,16 +1=
12,16 @@
             break;
     }
 
-#if defined(ENABLE_PKCS11_FORCE_DEBU=
G)
-    openvpn_flags =3D M_INFO;
-#endif
-
     return openvpn_flags;
+#en=
dif
 }
 
 static unsigned
 _pkcs11_msg_openvpn2pkcs11(const msglvl_t flags)=

 {
+#ifdef ENABLE_PKCS11_FORCE_DEBUG
+    return PKCS11H_LOG_DEBUG2;
+#els=
e
     unsigned pkcs11_flags;
 
     if ((flags & D_PKCS11_DEBUG) !=3D 0)
@=
@ -146,11 +149,8 @@
         pkcs11_flags =3D PKCS11H_LOG_ERROR;
     }
 
-=
#if defined(ENABLE_PKCS11_FORCE_DEBUG)
-    pkcs11_flags =3D PKCS11H_LOG_DE=
BUG2;
-#endif
-
     return pkcs11_flags;
+#endif
 }
 
 static void
diff --=
git a/src/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec
index=
 b6c1624=2E=2E69c5a50 100644
--- a/src/openvpn/pkcs11_openssl=2Ec
+++ b/src=
/openvpn/pkcs11_openssl=2Ec
@@ -384,7 +384,6 @@
     if (certificate !=3D N=
ULL)
     {
         pkcs11h_certificate_freeCertificate(certificate);
-   =
     certificate =3D NULL;
     }
 
     /*
@@ -400,7 +399,6 @@
     if (op=
enssl_session !=3D NULL)
     {
         pkcs11h_openssl_freeSession(openss=
l_session);
-        openssl_session =3D NULL;
     }
     return ret;
 #en=
dif                                                          /* ifdef HAVE_=
XKEY_PROVIDER */
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_=
util=2Ec
index fcc5411=2E=2E0213041 100644
--- a/src/openvpn/push_util=2Ec
=
+++ b/src/openvpn/push_util=2Ec
@@ -99,7 +99,6 @@
     }
 
     char *str =
=3D gc_strdup(s, gc);
-    size_t i =3D 0;
 
     while (*str)
     {
@@ -1=
12,11 +111,11 @@
                 /* if no commas were found go to fail, do=
 not send any message */
                 return false;
             }
+   =
         /* copy from current position to (ci - 1) */
             str[ci] =
=3D '\0';
-            /* copy from i to (ci -1) */
             struct buf=
fer tmp =3D forge_msg(str, ",push-continuation 2", gc);
             buffer=
_list_push(msgs, BSTR(&tmp));
-            i =3D ci + 1;
+            str +=
=3D ci + 1;
         }
         else
         {
@@ -130,9 +129,8 @@
       =
          struct buffer tmp =3D forge_msg(str, NULL, gc);
                 =
buffer_list_push(msgs, BSTR(&tmp));
             }
-            i =3D strle=
n(str);
+            break;
         }
-        str =3D &str[i];
     }
   =
  return true;
 }
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=
=2Ec
index f6ebf10=2E=2E41c8bac 100644
--- a/src/openvpn/socket=2Ec
+++ b/s=
rc/openvpn/socket=2Ec
@@ -790,7 +790,7 @@
      */
     socklen_t remote_le=
n_af =3D af_addr_size(act->dest=2Eaddr=2Esa=2Esa_family);
     socklen_t re=
mote_len =3D sizeof(act->dest=2Eaddr);
-    socket_descriptor_t new_sd =3D =
SOCKET_UNDEFINED;
+    socket_descriptor_t new_sd;
 
     CLEAR(*act);
 
di=
ff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index =
0b01634=2E=2E7cfe9f4 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/ope=
nvpn/ssl_openssl=2Ec
@@ -2283,13 +2283,13 @@
     }
 
     int typeid =3D E=
VP_PKEY_id(pkey);
+
+#ifndef OPENSSL_NO_EC
 #if OPENSSL_VERSION_NUMBER < 0x=
30000000L
     bool is_ec =3D typeid =3D=3D EVP_PKEY_EC;
 #else
     bool i=
s_ec =3D EVP_PKEY_is_a(pkey, "EC");
 #endif
-
-#ifndef OPENSSL_NO_EC
     c=
har groupname[64];
     if (is_ec)
     {
@@ -2593,15 +2593,13 @@
         =
   "builtin EC curves=2E It does not list additional curves nor X448 or X25=
519\n");
 #ifndef OPENSSL_NO_EC
     EC_builtin_curve *curves =3D NULL;
-  =
  size_t crv_len =3D 0;
-    size_t n =3D 0;
 
-    crv_len =3D EC_get_buil=
tin_curves(NULL, 0);
+    size_t crv_len =3D EC_get_builtin_curves(NULL, 0)=
;
     ALLOC_ARRAY(curves, EC_builtin_curve, crv_len);
     if (EC_get_buil=
tin_curves(curves, crv_len))
     {
         printf("\nAvailable Elliptic c=
urves/groups:\n");
-        for (n =3D 0; n < crv_len; n++)
+        for (s=
ize_t n =3D 0; n < crv_len; n++)
         {
             const char *sname;=

             sname =3D OBJ_nid2sn(curves[n]=2Enid);
diff --git a/src/openv=
pn/win32=2Ec b/src/openvpn/win32=2Ec
index 94e79d5e=2E=2E618772d 100644
---=
 a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1340,9 +1340,6 @@
=
     is_wow64_process2_t is_wow64_process2 =3D
         (is_wow64_process2_=
t)GetProcAddress(GetModuleHandle("Kernel32=2Edll"), "IsWow64Process2");
 
-=
    USHORT process_machine =3D 0;
-    USHORT native_machine =3D 0;
-
 #ifd=
ef _ARM64_
     *process_arch =3D ARCH_ARM64;
 #elif defined(_WIN64)
@@ -13=
50,6 +1347,8 @@
     if (is_wow64_process2)
     {
         /* this could b=
e amd64 on arm64 */
+        USHORT process_machine =3D 0;
+        USHORT =
native_machine =3D 0;
         BOOL is_wow64 =3D is_wow64_process2(GetCurre=
ntProcess(), &process_machine, &native_machine);
         if (is_wow64 && n=
ative_machine =3D=3D IMAGE_FILE_MACHINE_ARM64)
         {
@@ -1362,6 +1361,=
8 @@
     if (is_wow64_process2)
     {
         /* check if we're running =
on arm64 or amd64 machine */
+        USHORT process_machine =3D 0;
+      =
  USHORT native_machine =3D 0;
         BOOL is_wow64 =3D is_wow64_process2=
(GetCurrentProcess(), &process_machine, &native_machine);
         if (is_w=
ow64)
         {
diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openv=
pnmsica/openvpnmsica=2Ec
index 3911006=2E=2Ea861e8a 100644
--- a/src/openvp=
nmsica/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openvpnmsica=2Ec
@@ -711,7 +=
711,6 @@
         uiResult =3D MsiViewFetch(hViewST, &hRecord);
         if=
 (uiResult =3D=3D ERROR_NO_MORE_ITEMS)
         {
-            uiResult =3D=
 ERROR_SUCCESS;
             break;
         }
         else if (uiResult !=
=3D ERROR_SUCCESS)
diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec
ind=
ex 769df6c=2E=2Edd22cc5 100644
--- a/src/tapctl/tap=2Ec
+++ b/src/tapctl/ta=
p=2Ec
@@ -473,7 +473,7 @@
                         return ERROR_OUTOFMEMORY=
;
                     }
 
-                    dwCountExpResult =3D Expand=
EnvironmentStrings(szValue, szValueExp, dwCountExp);
+                    E=
xpandEnvironmentStrings(szValue, szValueExp, dwCountExp);
                 =
    free(szValue);
                     *pszValue =3D szValueExp;
         =
            return ERROR_SUCCESS;
@@ -601,8 +601,6 @@
                     =
    _In_ DWORD dwProperty, _Out_opt_ LPDWORD pdwPropertyRegDataType,
      =
                   _Out_ LPVOID *ppData)
 {
-    DWORD dwResult =3D ERROR_B=
AD_ARGUMENTS;
-
     if (ppData =3D=3D NULL)
     {
         return ERROR_B=
AD_ARGUMENTS;
@@ -628,7 +626,7 @@
     }
     else
     {
-        dwResult=
 =3D GetLastError();
+        DWORD dwResult =3D GetLastError();
         i=
f (dwResult =3D=3D ERROR_INSUFFICIENT_BUFFER)
         {
             /* Al=
locate on heap and retry=2E */
diff --git a/tests/unit_tests/openvpn/test_s=
sl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index fcebcdb=2E=2E4baf8cc 1=
00644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/op=
envpn/test_ssl=2Ec
@@ -217,7 +217,7 @@
 
 #if !defined(HAVE_OPENSSL_STORE)
=
     skip();
-#else  /* HAVE_OPENSSL_STORE */
+#else /* HAVE_OPENSSL_STORE =
*/
 
     struct tls_root_ctx ctx =3D { 0 };
     const char *certfile =3D =
global_state=2Ecertfile;
@@ -228,9 +228,10 @@
     struct buffer keyuri =3D=
 alloc_buf_gc(6 + strlen(keyfile) + 1, gc);   /* 6 bytes for "file:/" */
 
=
     /* Windows temp file path starts with drive letter -- add a leading sl=
ash for URI */
-    const char *lead =3D "";
 #ifdef _WIN32
-    lead =3D "=
/";
+    const char *lead =3D "/";
+#else
+    const char *lead =3D "";
 #e=
ndif /* _WIN32 */
     assert_true(buf_printf(&certuri, "file:%s%s", lead, =
certfile));
     assert_true(buf_printf(&keyuri, "file:%s%s", lead, keyfile=
));
@@ -292,8 +293,6 @@
     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&=
frame), &gc);
     struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZ=
E(&frame), &gc);
     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_=
SIZE(&frame), &gc);
-    struct buffer buf =3D clear_buf();
-    void *buf_=
p;
 
     /* init work */
     ASSERT(buf_init(&work, frame=2Ebuf=2Eheadroo=
m));
@@ -314,8 +313,8 @@
         prng_bytes(BPTR(&src), BLEN(&src));
 
   =
      /* copy source to input buf */
-        buf =3D work;
-        buf_p =
=3D buf_write_alloc(&buf, BLENZ(&src));
+        struct buffer buf =3D work=
;
+        void *buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
         ASS=
ERT(buf_p);
         memcpy(buf_p, BPTR(&src), BLENZ(&src));
 
@@ -345,7 +3=
44,6 @@
     struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&fra=
me), &gc);
     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&=
frame), &gc);
     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&frame), &g=
c);
-    struct buffer buf =3D clear_buf();
     struct buffer src =3D allo=
c_buf_gc(frame=2Ebuf=2Epayload_size, &gc);
     void *buf_p;
 
@@ -360,7 +3=
58,7 @@
     prng_bytes(BPTR(&src), BLEN(&src));
 
     /* copy source to i=
nput buf */
-    buf =3D work;
+    struct buffer buf =3D work;
     buf_p =
=3D buf_write_alloc(&buf, BLENZ(&src));
     ASSERT(buf_p);
     memcpy(buf=
_p, BPTR(&src), BLENZ(&src));
@@ -641,7 +639,6 @@
     struct buffer work =
=3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer encrypt_workspa=
ce =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer decrypt_work=
space =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
-    struct buffer buf =3D c=
lear_buf();
     void *buf_p;
 
     /* init work */
@@ -658,7 +655,7 @@
  =
   ASSERT(buf_write(&src, plaintext, strlen(plaintext)));
 
     /* copy so=
urce to input buf */
-    buf =3D work;
+    struct buffer buf =3D work;
  =
   buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
     ASSERT(buf_p);
     m=
emcpy(buf_p, BPTR(&src), BLENZ(&src));

-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1617?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
Gerrit-Chan=
ge-Number: 1617
Gerrit-PatchSet: 22
Gerrit-Owner: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-CC: stipa <lstipakov@gmail=2Ecom>

--GPHy1IitD7w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #22</strong> to the change originally created by flichtenhe=
ld=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">Remove various useles=
s assignments<br><br>The values assigned by these are never actually used<b=
r>for something=2E<br><br>Identified by cppcheck=2E<br><br>Change-Id: Id0ca=
a497c4ff1ad8743cb23f332f003b2d3393ed<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/161=
7<br>Message-Id: &lt;20260912200747=2E26711-1-gert@greenie=2Emuc=2Ede&gt;<b=
r>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg39142=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M dev-tools/cppcheck-suppression<br>M src/openvpn/cons=
ole_builtin=2Ec<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/error=2Eh<br>M=
 src/openvpn/forward=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/optio=
ns=2Ec<br>M src/openvpn/pkcs11=2Ec<br>M src/openvpn/pkcs11_openssl=2Ec<br>M=
 src/openvpn/push_util=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/ssl=
_openssl=2Ec<br>M src/openvpn/win32=2Ec<br>M src/openvpnmsica/openvpnmsica=
=2Ec<br>M src/tapctl/tap=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>=
16 files changed, 43 insertions(+), 63 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/17/161=
7/22</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppche=
ck-suppression</span><br><span>index e1ffe37=2E=2E299d7a3 100644</span><br>=
<span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ b/dev-tools/=
cppcheck-suppression</span><br><span>@@ -5,9 +5,6 @@</span><br><span> const=
ParameterPointer</span><br><span> invalidPrintfArgType_sint</span><br><span=
> invalidPrintfArgType_uint</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-redundantAssignment</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-redundantInitialization</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-unreadVariable</span><br><span> unusedFunction</span><br><span> uslee=
pCalled</span><br><span> variableScope</span><br><span>@@ -74,7 +71,7 @@</s=
pan><br><span> # IGN: strlen(NULL) is not nice code, but seems to work</spa=
n><br><span> nullPointerRedundantCheck:src/openvpn/init=2Ec:301</span><br><=
span> # FP: cppcheck doesn&#39;t understand ZeroMemory</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-redundantAssignment:src/openvpnserv/intera=
ctive=2Ec:203</span><br><span style=3D"color: hsl(120, 100%, 40%);">+redund=
antAssignment:src/openvpnserv/interactive=2Ec:204</span><br><span> # IGN: W=
e reuse the same variable name due to macro usage</span><br><span> shadowVa=
riable:src/openvpn/options=2Ec:1948</span><br><span> shadowVariable:src/ope=
nvpn/options=2Ec:1966</span><br><span>diff --git a/src/openvpn/console_buil=
tin=2Ec b/src/openvpn/console_builtin=2Ec</span><br><span>index 2a9f3b6=2E=
=2E9c8d72a 100644</span><br><span>--- a/src/openvpn/console_builtin=2Ec</sp=
an><br><span>+++ b/src/openvpn/console_builtin=2Ec</span><br><span>@@ -192,=
7 +192,6 @@</span><br><span> static bool</span><br><span> get_console_input=
(const char *prompt, const bool echo, char *input, const int capacity)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    boo=
l ret =3D false;</span><br><span>     ASSERT(prompt);</span><br><span>     =
ASSERT(input);</span><br><span>     ASSERT(capacity &gt; 0);</span><br><spa=
n>@@ -200,8 +199,11 @@</span><br><span> </span><br><span> #if defined(_WIN3=
2)</span><br><span>     return get_console_input_win32(prompt, echo, input,=
 capacity);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defi=
ned(HAVE_TERMIOS_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#elif !defined(HAVE_TERMIOS_H)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    msg(M_FATAL, &quot;Sorry, but I can&#39;t get console input =
on this OS (%s)&quot;, prompt);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#else</span><br><span>     bool restore_tty =3D false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D false;</spa=
n><br><span>     struct termios tty_tmp, tty_save;</span><br><span> </span>=
<br><span>     /* did we --daemon&#39;ize before asking for passwords?</spa=
n><br><span>@@ -258,10 +260,8 @@</span><br><span>     }</span><br><span> </=
span><br><span>     close_tty(fp);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#else  /* if defined(_WIN32) */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    msg(M_FATAL, &quot;Sorry, but I can&#39;t get co=
nsole input on this OS (%s)&quot;, prompt);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif /* if defined(_WIN32) */</span><br><span>     =
return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /=
* if defined(_WIN32) */</span><br><span> }</span><br><span> </span><br><spa=
n> /**</span><br><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/cr=
ypto=2Ec</span><br><span>index 8bbc566=2E=2Ee5ad31a 100644</span><br><span>=
--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</=
span><br><span>@@ -1204,8 +1204,6 @@</span><br><span>     struct buffer wor=
k =3D alloc_buf_gc(BUF_SIZE(frame), &amp;gc);</span><br><span>     struct b=
uffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &amp;gc);</span><=
br><span>     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(fra=
me), &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct buffer buf =3D clear_buf();</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    void *buf_p;</span><br><span> </span><br><span>     /* init w=
ork */</span><br><span>     ASSERT(buf_init(&amp;work, frame-&gt;buf=2Ehead=
room));</span><br><span>@@ -1242,8 +1240,8 @@</span><br><span>         prng=
_bytes(BPTR(&amp;src), BLEN(&amp;src));</span><br><span> </span><br><span> =
        /* copy source to input buf */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        buf =3D work;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct b=
uffer buf =3D work;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        void *buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><=
br><span>         ASSERT(buf_p);</span><br><span>         memcpy(buf_p, BPT=
R(&amp;src), BLENZ(&amp;src));</span><br><span> </span><br><span>diff --git=
 a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh</span><br><span>index 4582=
6a2=2E=2Ea887fc7 100644</span><br><span>--- a/src/openvpn/error=2Eh</span><=
br><span>+++ b/src/openvpn/error=2Eh</span><br><span>@@ -408,8 +408,8 @@</s=
pan><br><span> openvpn_errno_maybe_crt(bool *crt_error)</span><br><span> {<=
/span><br><span>     int err =3D 0;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    *crt_error =3D false;</span><br><span> #ifdef _WIN32</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    *crt_error =3D false=
;</span><br><span>     err =3D GetLastError();</span><br><span>     if (err=
 =3D=3D ERROR_SUCCESS)</span><br><span>     {</span><br><span>diff --git a/=
src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index ad4=
3d40=2E=2E83cd113 100644</span><br><span>--- a/src/openvpn/forward=2Ec</spa=
n><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -1746,7 +1746,=
6 @@</span><br><span> process_outgoing_link(struct context *c, struct link_=
socket *sock)</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
error_code =3D 0;</span><br><span> </span><br><span>     if (c-&gt;c2=2Eto_=
link=2Elen &gt; 0 &amp;&amp; c-&gt;c2=2Eto_link=2Elen &lt;=3D c-&gt;c2=2Efr=
ame=2Ebuf=2Epayload_size)</span><br><span>     {</span><br><span>@@ -1821,7=
 +1820,7 @@</span><br><span>         }</span><br><span> </span><br><span>  =
       /* Check return status */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        error_code =3D openvpn_errno();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        int error_code =3D openvpn_errno();<=
/span><br><span>         check_status(size, &quot;write&quot;, sock, NULL);=
</span><br><span> </span><br><span>         if (size &gt; 0)</span><br><spa=
n>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><s=
pan>index 3039f24=2E=2Ee121b38 100644</span><br><span>--- a/src/openvpn/man=
age=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -91=
6,10 +916,9 @@</span><br><span> static void</span><br><span> man_remote_ent=
ry_count(struct management *man)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    unsigned count =3D 0;</span><br><span> =
    if (man-&gt;persist=2Ecallback=2Eremote_entry_count)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        count =3D=
 (*man-&gt;persist=2Ecallback=2Eremote_entry_count)(man-&gt;persist=2Ecallb=
ack=2Earg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
unsigned int count =3D (*man-&gt;persist=2Ecallback=2Eremote_entry_count)(m=
an-&gt;persist=2Ecallback=2Earg);</span><br><span>         msg(M_CLIENT, &q=
uot;%u&quot;, count);</span><br><span>         msg(M_CLIENT, &quot;END&quot=
;);</span><br><span>     }</span><br><span>@@ -3743,7 +3742,6 @@</span><br>=
<span>     struct gc_arena gc =3D gc_new();</span><br><span>     int ret =
=3D 0;</span><br><span>     volatile int signal_received =3D 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer alert_msg =3D c=
lear_buf();</span><br><span>     const bool standalone_disabled_save =3D ma=
n-&gt;persist=2Estandalone_disabled;</span><br><span>     struct man_connec=
tion *mc =3D &amp;man-&gt;connection;</span><br><span> </span><br><span>@@ =
-3755,6 +3753,7 @@</span><br><span> </span><br><span>         *state =3D EK=
S_SOLICIT;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        struct buffer alert_msg;</span><br><span>         if (b64_=
data)</span><br><span>         {</span><br><span>             alert_msg =3D=
 alloc_buf_gc(strlen(b64_data) + strlen(prompt) + 3, &amp;gc);</span><br><s=
pan>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><b=
r><span>index 25a3746=2E=2E15f2fcd 100644</span><br><span>--- a/src/openvpn=
/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>=
@@ -4157,8 +4157,7 @@</span><br><span> bool</span><br><span> key_is_externa=
l(const struct options *options)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ret =3D ret || (options-&gt;managemen=
t_flags &amp; MF_EXTERNAL_KEY);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    bool ret =3D options-&gt;management_flags &amp; MF_EXTERNAL=
_KEY;</span><br><span> #ifdef ENABLE_PKCS11</span><br><span>     ret =3D re=
t || (options-&gt;pkcs11_providers[0] !=3D NULL);</span><br><span> #endif</=
span><br><span>@@ -5697,7 +5696,6 @@</span><br><span>             if (streq=
(p[1], &quot;FORWARD_COMPATIBLE&quot;) &amp;&amp; p[2] &amp;&amp; streq(p[2=
], &quot;1&quot;))</span><br><span>             {</span><br><span>         =
        options-&gt;forward_compatible =3D true;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                msglevel_fc =3D msglevel_forward=
_compatible(options, msglevel);</span><br><span>             }</span><br><s=
pan>             setenv_str(es, p[1], p[2] ? p[2] : &quot;&quot;);</span><b=
r><span>         }</span><br><span>diff --git a/src/openvpn/pkcs11=2Ec b/sr=
c/openvpn/pkcs11=2Ec</span><br><span>index 8b06fd0=2E=2Ed7dee97 100644</spa=
n><br><span>--- a/src/openvpn/pkcs11=2Ec</span><br><span>+++ b/src/openvpn/=
pkcs11=2Ec</span><br><span>@@ -80,6 +80,9 @@</span><br><span> static msglvl=
_t</span><br><span> _pkcs11_msg_pkcs112openvpn(const unsigned flags)</span>=
<br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
ENABLE_PKCS11_FORCE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return M_INFO;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#else</span><br><span>     msglvl_t openvpn_flags;</span><br><span> </=
span><br><span>     switch (flags)</span><br><span>@@ -109,16 +112,16 @@</s=
pan><br><span>             break;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_PKC=
S11_FORCE_DEBUG)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=
penvpn_flags =3D M_INFO;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span>     return openvpn_flags;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span> }</span><br><span> </span><br><span> st=
atic unsigned</span><br><span> _pkcs11_msg_openvpn2pkcs11(const msglvl_t fl=
ags)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifdef ENABLE_PKCS11_FORCE_DEBUG</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return PKCS11H_LOG_DEBUG2;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#else</span><br><span>     unsigned pkcs11_flag=
s;</span><br><span> </span><br><span>     if ((flags &amp; D_PKCS11_DEBUG) =
!=3D 0)</span><br><span>@@ -146,11 +149,8 @@</span><br><span>         pkcs1=
1_flags =3D PKCS11H_LOG_ERROR;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_PKCS11=
_FORCE_DEBUG)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pkcs=
11_flags =3D PKCS11H_LOG_DEBUG2;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     return pkcs11_flags;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span>diff --git a/src/openvpn/pkcs11_openssl=2E=
c b/src/openvpn/pkcs11_openssl=2Ec</span><br><span>index b6c1624=2E=2E69c5a=
50 100644</span><br><span>--- a/src/openvpn/pkcs11_openssl=2Ec</span><br><s=
pan>+++ b/src/openvpn/pkcs11_openssl=2Ec</span><br><span>@@ -384,7 +384,6 @=
@</span><br><span>     if (certificate !=3D NULL)</span><br><span>     {</s=
pan><br><span>         pkcs11h_certificate_freeCertificate(certificate);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        certificate =3D =
NULL;</span><br><span>     }</span><br><span> </span><br><span>     /*</spa=
n><br><span>@@ -400,7 +399,6 @@</span><br><span>     if (openssl_session !=
=3D NULL)</span><br><span>     {</span><br><span>         pkcs11h_openssl_f=
reeSession(openssl_session);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        openssl_session =3D NULL;</span><br><span>     }</span><br><=
span>     return ret;</span><br><span> #endif                              =
                            /* ifdef HAVE_XKEY_PROVIDER */</span><br><span>=
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><b=
r><span>index fcc5411=2E=2E0213041 100644</span><br><span>--- a/src/openvpn=
/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span><br><s=
pan>@@ -99,7 +99,6 @@</span><br><span>     }</span><br><span> </span><br><s=
pan>     char *str =3D gc_strdup(s, gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    size_t i =3D 0;</span><br><span> </span><br><span>  =
   while (*str)</span><br><span>     {</span><br><span>@@ -112,11 +111,11 @=
@</span><br><span>                 /* if no commas were found go to fail, d=
o not send any message */</span><br><span>                 return false;</s=
pan><br><span>             }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            /* copy from current position to (ci - 1) */</span><br=
><span>             str[ci] =3D &#39;\0&#39;;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            /* copy from i to (ci -1) */</span><br>=
<span>             struct buffer tmp =3D forge_msg(str, &quot;,push-continu=
ation 2&quot;, gc);</span><br><span>             buffer_list_push(msgs, BST=
R(&amp;tmp));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    i =3D ci + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          str +=3D ci + 1;</span><br><span>         }</span><br><span>     =
    else</span><br><span>         {</span><br><span>@@ -130,9 +129,8 @@</sp=
an><br><span>                 struct buffer tmp =3D forge_msg(str, NULL, gc=
);</span><br><span>                 buffer_list_push(msgs, BSTR(&amp;tmp));=
</span><br><span>             }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            i =3D strlen(str);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            break;</span><br><span>         }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        str =3D &amp;str[i];</=
span><br><span>     }</span><br><span>     return true;</span><br><span> }<=
/span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2E=
c</span><br><span>index f6ebf10=2E=2E41c8bac 100644</span><br><span>--- a/s=
rc/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><b=
r><span>@@ -790,7 +790,7 @@</span><br><span>      */</span><br><span>     s=
ocklen_t remote_len_af =3D af_addr_size(act-&gt;dest=2Eaddr=2Esa=2Esa_famil=
y);</span><br><span>     socklen_t remote_len =3D sizeof(act-&gt;dest=2Eadd=
r);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    socket_descrip=
tor_t new_sd =3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    socket_descriptor_t new_sd;</span><br><span> </span><br>=
<span>     CLEAR(*act);</span><br><span> </span><br><span>diff --git a/src/=
openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index=
 0b01634=2E=2E7cfe9f4 100644</span><br><span>--- a/src/openvpn/ssl_openssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -=
2283,13 +2283,13 @@</span><br><span>     }</span><br><span> </span><br><spa=
n>     int typeid =3D EVP_PKEY_id(pkey);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifndef OPENSSL_NO_EC</span><br><span> #if OPENSSL_VERSION_NUMBER &lt; 0x=
30000000L</span><br><span>     bool is_ec =3D typeid =3D=3D EVP_PKEY_EC;</s=
pan><br><span> #else</span><br><span>     bool is_ec =3D EVP_PKEY_is_a(pkey=
, &quot;EC&quot;);</span><br><span> #endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#ifndef OPENSSL_NO_EC</span><br><span>     char groupname[64];</span><br><s=
pan>     if (is_ec)</span><br><span>     {</span><br><span>@@ -2593,15 +259=
3,13 @@</span><br><span>            &quot;builtin EC curves=2E It does not =
list additional curves nor X448 or X25519\n&quot;);</span><br><span> #ifnde=
f OPENSSL_NO_EC</span><br><span>     EC_builtin_curve *curves =3D NULL;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t crv_len =3D 0;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t n =3D 0;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
rv_len =3D EC_get_builtin_curves(NULL, 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    size_t crv_len =3D EC_get_builtin_curves(NULL, 0=
);</span><br><span>     ALLOC_ARRAY(curves, EC_builtin_curve, crv_len);</sp=
an><br><span>     if (EC_get_builtin_curves(curves, crv_len))</span><br><sp=
an>     {</span><br><span>         printf(&quot;\nAvailable Elliptic curves=
/groups:\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     for (n =3D 0; n &lt; crv_len; n++)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        for (size_t n =3D 0; n &lt; crv_len; n++)</span=
><br><span>         {</span><br><span>             const char *sname;</span=
><br><span>             sname =3D OBJ_nid2sn(curves[n]=2Enid);</span><br><s=
pan>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><s=
pan>index 94e79d5e=2E=2E618772d 100644</span><br><span>--- a/src/openvpn/wi=
n32=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -134=
0,9 +1340,6 @@</span><br><span>     is_wow64_process2_t is_wow64_process2 =
=3D</span><br><span>         (is_wow64_process2_t)GetProcAddress(GetModuleH=
andle(&quot;Kernel32=2Edll&quot;), &quot;IsWow64Process2&quot;);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    USHORT pro=
cess_machine =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  USHORT native_machine =3D 0;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> #ifdef _ARM64_</span><br><span>     *process_arc=
h =3D ARCH_ARM64;</span><br><span> #elif defined(_WIN64)</span><br><span>@@=
 -1350,6 +1347,8 @@</span><br><span>     if (is_wow64_process2)</span><br><=
span>     {</span><br><span>         /* this could be amd64 on arm64 */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        USHORT process_=
machine =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   USHORT native_machine =3D 0;</span><br><span>         BOOL is_wow64 =3D =
is_wow64_process2(GetCurrentProcess(), &amp;process_machine, &amp;native_ma=
chine);</span><br><span>         if (is_wow64 &amp;&amp; native_machine =3D=
=3D IMAGE_FILE_MACHINE_ARM64)</span><br><span>         {</span><br><span>@@=
 -1362,6 +1361,8 @@</span><br><span>     if (is_wow64_process2)</span><br><=
span>     {</span><br><span>         /* check if we&#39;re running on arm64=
 or amd64 machine */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        USHORT process_machine =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        USHORT native_machine =3D 0;</span><br><span>   =
      BOOL is_wow64 =3D is_wow64_process2(GetCurrentProcess(), &amp;process=
_machine, &amp;native_machine);</span><br><span>         if (is_wow64)</spa=
n><br><span>         {</span><br><span>diff --git a/src/openvpnmsica/openvp=
nmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>index 391100=
6=2E=2Ea861e8a 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica=
=2Ec</span><br><span>+++ b/src/openvpnmsica/openvpnmsica=2Ec</span><br><spa=
n>@@ -711,7 +711,6 @@</span><br><span>         uiResult =3D MsiViewFetch(hV=
iewST, &amp;hRecord);</span><br><span>         if (uiResult =3D=3D ERROR_NO=
_MORE_ITEMS)</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            uiResult =3D ERROR_SUCCESS;</span><br><span> =
            break;</span><br><span>         }</span><br><span>         else=
 if (uiResult !=3D ERROR_SUCCESS)</span><br><span>diff --git a/src/tapctl/t=
ap=2Ec b/src/tapctl/tap=2Ec</span><br><span>index 769df6c=2E=2Edd22cc5 1006=
44</span><br><span>--- a/src/tapctl/tap=2Ec</span><br><span>+++ b/src/tapct=
l/tap=2Ec</span><br><span>@@ -473,7 +473,7 @@</span><br><span>             =
            return ERROR_OUTOFMEMORY;</span><br><span>                     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  dwCountExpResult =3D ExpandEnvironmentStrings(szValue, sz=
ValueExp, dwCountExp);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    ExpandEnvironmentStrings(szValue, szValueExp, dwCoun=
tExp);</span><br><span>                     free(szValue);</span><br><span>=
                     *pszValue =3D szValueExp;</span><br><span>            =
         return ERROR_SUCCESS;</span><br><span>@@ -601,8 +601,6 @@</span><b=
r><span>                         _In_ DWORD dwProperty, _Out_opt_ LPDWORD p=
dwPropertyRegDataType,</span><br><span>                         _Out_ LPVOI=
D *ppData)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    DWORD dwResult =3D ERROR_BAD_ARGUMENTS;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (ppData =3D=3D NUL=
L)</span><br><span>     {</span><br><span>         return ERROR_BAD_ARGUMEN=
TS;</span><br><span>@@ -628,7 +626,7 @@</span><br><span>     }</span><br><s=
pan>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        dwResult =3D GetLastError();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        DWORD dwResult =3D GetLastError()=
;</span><br><span>         if (dwResult =3D=3D ERROR_INSUFFICIENT_BUFFER)</=
span><br><span>         {</span><br><span>             /* Allocate on heap =
and retry=2E */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index fcebc=
db=2E=2E4baf8cc 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><=
br><span>@@ -217,7 +217,7 @@</span><br><span> </span><br><span> #if !define=
d(HAVE_OPENSSL_STORE)</span><br><span>     skip();</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#else  /* HAVE_OPENSSL_STORE */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#else /* HAVE_OPENSSL_STORE */</sp=
an><br><span> </span><br><span>     struct tls_root_ctx ctx =3D { 0 };</spa=
n><br><span>     const char *certfile =3D global_state=2Ecertfile;</span><b=
r><span>@@ -228,9 +228,10 @@</span><br><span>     struct buffer keyuri =3D =
alloc_buf_gc(6 + strlen(keyfile) + 1, gc);   /* 6 bytes for &quot;file:/&qu=
ot; */</span><br><span> </span><br><span>     /* Windows temp file path sta=
rts with drive letter -- add a leading slash for URI */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const char *lead =3D &quot;&quot;;</s=
pan><br><span> #ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    lead =3D &quot;/&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *lead =3D &quot;/&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *lead =3D &quot;&quot;;</span><br><span=
> #endif /* _WIN32 */</span><br><span>     assert_true(buf_printf(&amp;cert=
uri, &quot;file:%s%s&quot;, lead, certfile));</span><br><span>     assert_t=
rue(buf_printf(&amp;keyuri, &quot;file:%s%s&quot;, lead, keyfile));</span><=
br><span>@@ -292,8 +293,6 @@</span><br><span>     struct buffer work =3D al=
loc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>     struct buff=
er encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span=
><br><span>     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&=
amp;frame), &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct buffer buf =3D clear_buf();</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    void *buf_p;</span><br><span> </span><br><span>     /*=
 init work */</span><br><span>     ASSERT(buf_init(&amp;work, frame=2Ebuf=
=2Eheadroom));</span><br><span>@@ -314,8 +313,8 @@</span><br><span>        =
 prng_bytes(BPTR(&amp;src), BLEN(&amp;src));</span><br><span> </span><br><s=
pan>         /* copy source to input buf */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        buf =3D work;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&am=
p;src));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str=
uct buffer buf =3D work;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        void *buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</s=
pan><br><span>         ASSERT(buf_p);</span><br><span>         memcpy(buf_p=
, BPTR(&amp;src), BLENZ(&amp;src));</span><br><span> </span><br><span>@@ -3=
45,7 +344,6 @@</span><br><span>     struct buffer encrypt_workspace =3D all=
oc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>     struct buffe=
r decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span>=
<br><span>     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &a=
mp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buf=
fer buf =3D clear_buf();</span><br><span>     struct buffer src =3D alloc_b=
uf_gc(frame=2Ebuf=2Epayload_size, &amp;gc);</span><br><span>     void *buf_=
p;</span><br><span> </span><br><span>@@ -360,7 +358,7 @@</span><br><span>  =
   prng_bytes(BPTR(&amp;src), BLEN(&amp;src));</span><br><span> </span><br>=
<span>     /* copy source to input buf */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    buf =3D work;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct buffer buf =3D work;</span><br><span>     buf_=
p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>     ASSE=
RT(buf_p);</span><br><span>     memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;sr=
c));</span><br><span>@@ -641,7 +639,6 @@</span><br><span>     struct buffer=
 work =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>    =
 struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &am=
p;gc);</span><br><span>     struct buffer decrypt_workspace =3D alloc_buf_g=
c(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct buffer buf =3D clear_buf();</span><br><span>     voi=
d *buf_p;</span><br><span> </span><br><span>     /* init work */</span><br>=
<span>@@ -658,7 +655,7 @@</span><br><span>     ASSERT(buf_write(&amp;src, p=
laintext, strlen(plaintext)));</span><br><span> </span><br><span>     /* co=
py source to input buf */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    buf =3D work;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer buf =3D work;</span><br><span>     buf_p =3D buf_write_=
alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>     ASSERT(buf_p);</span=
><br><span>     memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src));</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1617?usp=3Demail">change 1617</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f3=
32f003b2d3393ed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
617 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 22 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gr=
eenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--GPHy1IitD7w=--


--===============3232974718911179460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3232974718911179460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3232974718911179460==--

