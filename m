Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F9ECA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=XsTU+HClOF/1qdiBHssKm3ZzFubl5K5yXlB+F9e7qjc=; b=RNlFgRMneTWwqu
	uXXcHNt4p3yzlQyPlRtVp03NZ8HBFZoxU7Pc8d7N6W0DFeVGly4PdME5sI4sHaUox3WQUdeauehqf
	abXHIbng8FmHtZyVWrM8B/gWpujStCNWR+kei0HFdJXmujs510VSF1RGCMyme9mZyjl3HC6t0XT4T
	Uu0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBEQ9-0001pX-1c;
	Mon, 28 Sep 2026 16:41:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBEQ6-0001me-MG
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 16:41:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xP2NRcS3jr/kbUxGBbfLkzSeGgs1TWtGEsvvwOtXkO4=; b=L7jTQLLQr6fFqkekzBLSN1ULy0
 ylVikOiDjVybkRnMxe/I7T+iziZbrrCE9s9xV824FlTzk97Syoe77pDFdX56IToWpubeVTOIzVJAa
 3Z5L9oSbAujE9xgPHo4qd7A0Q1J6Ev3WyipBje5tU+1Kofbeg3nqzcevznDFcINXUeQc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xP2NRcS3jr/kbUxGBbfLkzSeGgs1TWtGEsvvwOtXkO4=; b=R
 B9XYzYWs4CLos14779vQzQeBzpioylirfuNOjvvtfutOUnuFOIx+PVWpD6ly9RtQnv+2CMpZ/9YWm
 gB0LK3PgjgWyEZwnuXyvZLrjZ7Yw8Mq7m0Zf4cSIPDr4GqnBN4ZC7xCkgj1XZasMRbtWR7Joyb1hE
 pSuX8PZRXZKHqrJU=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBEPz-0001Ql-7G for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 16:41:36 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ffe817151so11371255e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790613685; x=1791218485; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xP2NRcS3jr/kbUxGBbfLkzSeGgs1TWtGEsvvwOtXkO4=;
 b=Ezp2287jvRL24tErspbq2y9AWD1bvZV5kNRvXw0IKBG8OumW0P1HdAuYx9ZwD6WsBJ
 OFcktYKsiunPl+p9y6BHAiAmcTR6Ord40/87RkF2eKtXKstQ//pSKH+NtQUftRSCOcL9
 ENTQrTa1o9fqIq8Oy9uV2Px4dlP/SPuLvphgzIcIneoGrr7QmKmESwVNmBKdADT422Fw
 r4AZHItKVAysfEgw+W3U9MPx8l5NQTXn+OW3x6rZKIaI4TsW6y6MHIhMO8MJXMBn+FuH
 4wtrienCzdENPW47OnDKy8Fd3RSW2nrD6bbOvnzp/HOOc47/pekRGMB86MN+UyH43WQW
 TYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790613685; x=1791218485;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xP2NRcS3jr/kbUxGBbfLkzSeGgs1TWtGEsvvwOtXkO4=;
 b=x+q3ZkYRlIsPfckzebM77VMLtrU0bzkL4/yWZurrxRfmoQsLGNOh7P580DgD+w0wmy
 zqa/GovtACV9THkam+gejfhsZG+Yim4KCAPUAi4WrTo8/JjA9w5uSpacuU9O+JW5am1g
 TFn3gwzkkeRIrKM0XT+SekUjA8sfEzvz5sDl2HQZa0Yze6ynyLyOZGCTrc0PjzAUfNrS
 FUs2uf0QHqkfYw4ciTgCd3yi0Qa0jPuGE9vD6/gOL8roxJH2kA1Wmxgry+ltalRBlxSc
 lCf88yWmvZyo7RFBegHgZQw37Tq89/vEljKCrP8Nlv/HQ7SMulk/Rieq0CkXvTnltCV5
 bQsg==
X-Gm-Message-State: AFuF++lHhkeRqzGKajvUHBJvhCkqgBu3KuwL9kOxaGfMFiS/3LYBJi84
 guujn22Ub//Qfxcmsl3MfSxHtXU3MJnRPMw7fKU87/dCf99q+0JBlzia6ThWGMALa91xcx1wxzx
 oHrlXs81oae4EKKt8Qi1edp9z7R0P//A81+46BEjccMxCutZXSUmM4TsCqq5ii6M0SbO2jZ16OQ
 uPSzPZ7Q==
X-Gm-Gg: AYBFou1SEMjN55Z81FmSnCZMpCrimOFTrQAgn+fDx5OBjFxTWDosY2WkckWfTRSaWuS
 plRn/oPVJoGQWfb5w/PeQrkgxw5GGeEsYhBboGka5p+5UNLqaThc7s/i+CVNZXJCnYMkDk/ASBT
 6eME04qxLckpOl2aI9bluhLA6QWfLcjKLofUU9GS+43eNDckM0fLpmh9IxHdXfKoWufdgjUnVGZ
 81E3NTKuJs/2NIOLXGk56t3jfBbto1OVZRP735gJYGIX3nUXCdzWrqkDiManhnn0dDZhosfGmBM
 z+NQMrZQ/dI8g15qhgXC4UnaFNymdgQpMfB+d1uE36MqYgC7OT9ZTD32Vl1UkFs/0qsvnU9/7yW
 NM6GUJSVhX40auf4sstuECKvtuPPkjSXDdXF6no3Y2YVar/X4b+QNf3ozOIlGRI8qQ6EJSlKBvr
 6DQFfGNB8GHEVTdr9D6MWVnOrAzFI6xoZ69ZYAwQQV/yljwjvfrAOKE/J8pPcyTIM9OfSfKUjkE
 uLyT7JtcNF8tzgEG63C1i+OqOSRdveiriafPdLPcII/zT7btIoeOSGyemAf0KO7O4inUcfdOLs2
 PxlxpWngTlhCC2sN23JQNiKE3AE45CmiWoUdfeTxhqKK2FoUdFfalA1DKskR
X-Received: by 2002:a05:600d:849b:10b0:4a0:61b:ede1 with SMTP id
 5b1f17b1804b1-4a0061bf0b4mr32706485e9.7.1790613683016; 
 Mon, 28 Sep 2026 09:41:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf9dfdbsm7312835e9.1.2026.09.28.09.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 09:41:22 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 16:41:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7
X-Gerrit-Change-Number: 1963
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1963?usp=email>
X-Gerrit-Commit: 1b96c0f91875317822c953a905f38c2daf635294
References: <gerrit.1790613679000.Ib69b6c7a5f21f8552159c94560830f182c6238b7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEzNjc5MDAwLkliNjliNmM3YTVmMjFmODU1MjE1OWM5NDU2MDgzMGYxODJjNjIzOGI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c81206878c9214fcfcb9c7d672d47510a80b2b0c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBEPz-0001Ql-7G
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix (almost) all
 occurrences of cppcheck variableScope
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
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8861068809198316681=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8861068809198316681==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GX76IaWGXO8="; charset=UTF-8

--GX76IaWGXO8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1963?usp=3Demail

to review the following change=2E


Chang=
e subject: Fix (almost) all occurrences of cppcheck variableScope
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix (almost) all occur=
rences of cppcheck variableScope

In two cases I found the code change too =
ugly and added
a suppression=2E In most cases the change is trivially
corre=
ct (as long as it builds)=2E

Some drive-by style fixes, and marked some of=
 the moved
variables const as appropriate=2E

Change-Id: Ib69b6c7a5f21f8552=
159c94560830f182c6238b7
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
---
M dev-tools/cppcheck-suppressions=2Exml
M sample/sample-plugins=
/keying-material-exporter-demo/keyingmaterialexporter=2Ec
M sample/sample-p=
lugins/log/log_v3=2Ec
M src/openvpn/buffer=2Ec
M src/openvpn/clinat=2Ec
M s=
rc/openvpn/console_builtin=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn/crypt=
o_epoch=2Ec
M src/openvpn/dco_freebsd=2Ec
M src/openvpn/dhcp=2Ec
M src/open=
vpn/env_set=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/httpdigest=2Ec
M sr=
c/openvpn/manage=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/multi=2Ec
M src/o=
penvpn/networking_sitnl=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=
_parse=2Ec
M src/openvpn/packet_id=2Ec
M src/openvpn/platform=2Ec
M src/ope=
nvpn/pool=2Ec
M src/openvpn/proto=2Ec
M src/openvpn/push=2Ec
M src/openvpn/=
route=2Ec
M src/openvpn/run_command=2Ec
M src/openvpn/siphash_reference=2Ec=

M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/=
ssl_pkt=2Ec
M src/openvpn/ssl_verify_mbedtls=2Ec
M src/openvpn/tun=2Ec
M sr=
c/openvpn/win32=2Ec
M src/openvpnserv/common=2Ec
M src/openvpnserv/interact=
ive=2Ec
M src/openvpnserv/service=2Ec
M tests/unit_tests/openvpn/test_provi=
der=2Ec
37 files changed, 108 insertions(+), 134 deletions(-)



  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1963/1

diff --=
git a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressio=
ns=2Exml
index 38de5f2a=2E=2Ebd24c3b 100644
--- a/dev-tools/cppcheck-suppre=
ssions=2Exml
+++ b/dev-tools/cppcheck-suppressions=2Exml
@@ -14,9 +14,6 @@
=
   <suppress>
     <id>usleepCalled</id>
   </suppress>
-  <suppress>
-    =
<id>variableScope</id>
-  </suppress>
   <!-- We have a lot of library incl=
udes, not all of them are really required,
        so ignore them -->
   <s=
uppress>
@@ -288,4 +285,15 @@
     <id>unusedStructMember</id>
     <fileNa=
me>tests/unit_tests/openvpn/test_pkcs11=2Ec</fileName>
   </suppress>
+  <!=
-- IGN: nicer -->
+  <suppress>
+    <id>variableScope</id>
+    <fileName>=
src/openvpnserv/interactive=2Ec</fileName>
+    <symbolName>cmds</symbolNam=
e>
+  </suppress>
+  <suppress>
+    <id>variableScope</id>
+    <fileName>=
src/openvpnserv/interactive=2Ec</fileName>
+    <symbolName>sys_key</symbol=
Name>
+  </suppress>
 </suppressions>
diff --git a/sample/sample-plugins/ke=
ying-material-exporter-demo/keyingmaterialexporter=2Ec b/sample/sample-plug=
ins/keying-material-exporter-demo/keyingmaterialexporter=2Ec
index 512861a=
=2E=2E2474bf1 100644
--- a/sample/sample-plugins/keying-material-exporter-d=
emo/keyingmaterialexporter=2Ec
+++ b/sample/sample-plugins/keying-material-=
exporter-demo/keyingmaterialexporter=2Ec
@@ -120,13 +120,14 @@
     ASN1_OB=
JECT *fn;
     ASN1_STRING *val;
     X509_NAME *x509_name;
-    X509_NAME_=
ENTRY *ent;
     const char *objbuf;
 
     x509_name =3D X509_get_subject_=
name(x509);
-    int i, n =3D X509_NAME_entry_count(x509_name);
-    for (i=
 =3D 0; i < n; ++i)
+    int n =3D X509_NAME_entry_count(x509_name);
+    f=
or (int i =3D 0; i < n; ++i)
     {
+        X509_NAME_ENTRY *ent;
+
      =
   if (!(ent =3D X509_NAME_get_entry(x509_name, i)))
         {
           =
  continue;
diff --git a/sample/sample-plugins/log/log_v3=2Ec b/sample/samp=
le-plugins/log/log_v3=2Ec
index 09c6735=2E=2E1c781a3 100644
--- a/sample/sa=
mple-plugins/log/log_v3=2Ec
+++ b/sample/sample-plugins/log/log_v3=2Ec
@@ -=
197,7 +197,6 @@
     ASN1_OBJECT *fn;
     ASN1_STRING *val;
     X509_NAME=
 *x509_name;
-    X509_NAME_ENTRY *ent;
     const char *objbuf;
     unsig=
ned char *buf =3D NULL;
 
@@ -205,7 +204,7 @@
     n =3D X509_NAME_entry_co=
unt(x509_name);
     for (i =3D 0; i < n; ++i)
     {
-        ent =3D X509=
_NAME_get_entry(x509_name, i);
+        X509_NAME_ENTRY *ent =3D X509_NAME_=
get_entry(x509_name, i);
         if (!ent)
         {
             continu=
e;
diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 21e11=
3d=2E=2E8f558b1 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffe=
r=2Ec
@@ -228,13 +228,13 @@
     int ret =3D false;
     if (buf_defined(bu=
f))
     {
-        va_list arglist;
         uint8_t *ptr =3D BEND(buf);
 =
        int cap =3D buf_forward_capacity(buf);
 
         if (cap > 0)
    =
     {
             int stat;
+            va_list arglist;
             va=
_start(arglist, format);
             stat =3D vsnprintf((char *)ptr, cap, =
format, arglist);
             va_end(arglist);
diff --git a/src/openvpn/cl=
inat=2Ec b/src/openvpn/clinat=2Ec
index 9fa8f5f=2E=2Ed72d42a 100644
--- a/s=
rc/openvpn/clinat=2Ec
+++ b/src/openvpn/clinat=2Ec
@@ -50,12 +50,11 @@
 pri=
nt_client_nat_list(const struct client_nat_option_list *list, msglvl_t msgl=
evel)
 {
     struct gc_arena gc =3D gc_new();
-    int i;
 
     msg(msgle=
vel, "*** CNAT list");
     if (list)
     {
-        for (i =3D 0; i < lis=
t->n; ++i)
+        for (int i =3D 0; i < list->n; ++i)
         {
        =
     const struct client_nat_entry *e =3D &list->entries[i];
             m=
sg(msglevel, "  CNAT[%d] t=3D%d %s/%s/%s", i, e->type,
diff --git a/src/ope=
nvpn/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec
index 9c8d72a=2E=
=2Ecf6cc37 100644
--- a/src/openvpn/console_builtin=2Ec
+++ b/src/openvpn/c=
onsole_builtin=2Ec
@@ -77,7 +77,6 @@
     bool is_console =3D (GetFileType(=
in) =3D=3D FILE_TYPE_CHAR);
     DWORD flags_save =3D 0;
     int status =
=3D 0;
-    WCHAR *winput;
 
     if (is_console)
     {
@@ -100,7 +99,7 @@=

 
     if (is_console)
     {
-        winput =3D malloc(capacity * sizeof=
(WCHAR));
+        WCHAR *winput =3D malloc(capacity * sizeof(WCHAR));
    =
     if (winput =3D=3D NULL)
         {
             return false;
diff --g=
it a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index 8196c26=2E=2E3d3=
ab0c 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1=
774,13 +1774,10 @@
 static const cipher_name_pair *
 get_cipher_name_pair(c=
onst char *cipher_name)
 {
-    const cipher_name_pair *pair;
-    size_t i=
 =3D 0;
-
     /* Search for a cipher name translation */
-    for (; i < c=
ipher_name_translation_table_count; i++)
+    for (size_t i =3D 0; i < ciph=
er_name_translation_table_count; i++)
     {
-        pair =3D &cipher_name=
_translation_table[i];
+        const cipher_name_pair *pair =3D &cipher_na=
me_translation_table[i];
         if (0 =3D=3D strcmp(cipher_name, pair->op=
envpn_name)
             || 0 =3D=3D strcmp(cipher_name, pair->lib_name))
 =
        {
diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_ep=
och=2Ec
index 158c841=2E=2E69a1852 100644
--- a/src/openvpn/crypto_epoch=2E=
c
+++ b/src/openvpn/crypto_epoch=2Ec
@@ -387,9 +387,6 @@
     else if (epoc=
h > opt->key_ctx_bi=2Edecrypt=2Eepoch
              && epoch <=3D opt->key_=
ctx_bi=2Edecrypt=2Eepoch + opt->epoch_data_keys_future_count)
     {
-     =
   /* Key in the range of future keys */
-        int index =3D epoch - (op=
t->key_ctx_bi=2Edecrypt=2Eepoch + 1);
-
         /* If we have reached the =
edge of the valid keys we do not return
          * the key anymore since r=
egenerating the new keys would move us
          * over the window of valid=
 keys and would need all kind of
@@ -400,6 +397,9 @@
         }
         el=
se
         {
+            /* Key in the range of future keys */
+         =
   const int index =3D epoch - (opt->key_ctx_bi=2Edecrypt=2Eepoch + 1);
+
 =
            return &opt->epoch_data_keys_future[index];
         }
     }
d=
iff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index=
 7346903=2E=2E3148f10 100644
--- a/src/openvpn/dco_freebsd=2Ec
+++ b/src/op=
envpn/dco_freebsd=2Ec
@@ -444,7 +444,6 @@
 key_to_nvlist(const uint8_t *key=
, const uint8_t *implicit_iv, const char *ciphername)
 {
     nvlist_t *nvl=
;
-    size_t key_len;
 
     nvl =3D nvlist_create(0);
 
@@ -452,7 +451,7 =
@@
 
     if (strcmp(ciphername, "none") !=3D 0)
     {
-        key_len =
=3D cipher_kt_key_size(ciphername);
+        const size_t key_len =3D ciphe=
r_kt_key_size(ciphername);
 
         nvlist_add_binary(nvl, "key", key, ke=
y_len);
         nvlist_add_binary(nvl, "iv", implicit_iv, 8);
diff --git a=
/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec
index 5cdcfcf=2E=2E19e9e2d 100=
644
--- a/src/openvpn/dhcp=2Ec
+++ b/src/openvpn/dhcp=2Ec
@@ -271,7 +271,6 =
@@
 {
     char tmp_buf[256];
     size_t len =3D 0;
-    size_t label_leng=
th_pos;
 
     for (int i =3D 0; i < array_len; i++)
     {
@@ -290,7 +289,=
7 @@
 
         /* label_length_pos points to the byte to be replaced by th=
e length
          * of the following domain label */
-        label_length=
_pos =3D len++;
+        size_t label_length_pos =3D len++;
 
         whil=
e (true)
         {
diff --git a/src/openvpn/env_set=2Ec b/src/openvpn/env_=
set=2Ec
index d992097=2E=2E67a5bf5 100644
--- a/src/openvpn/env_set=2Ec
+++=
 b/src/openvpn/env_set=2Ec
@@ -62,14 +62,13 @@
 static bool
 env_string_equ=
al(const char *s1, const char *s2)
 {
-    int c1, c2;
     ASSERT(s1);
   =
  ASSERT(s2);
 
     while (true)
     {
-        c1 =3D *s1++;
-        c2=
 =3D *s2++;
+        int c1 =3D *s1++;
+        int c2 =3D *s2++;
         =
if (c1 =3D=3D '=3D')
         {
             c1 =3D 0;
@@ -214,12 +213,11 @=
@
     if (check_debug_level(msglevel))
     {
         const struct env_it=
em *e;
-        int i;
 
         if (es)
         {
+            int i =3D=
 0;
             e =3D es->list;
-            i =3D 0;
 
             while=
 (e)
             {
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forw=
ard=2Ec
index 204b0b7=2E=2E41388d4 100644
--- a/src/openvpn/forward=2Ec
+++=
 b/src/openvpn/forward=2Ec
@@ -2039,13 +2039,13 @@
     unsigned int socket=
 =3D 0;
     unsigned int tuntap =3D 0;
     static uintptr_t tun_shift =3D=
 TUN_SHIFT;
-    static uintptr_t err_shift =3D ERR_SHIFT;
 
     /*
      =
* Calculate the flags based on the provided 'flags' argument=2E
      */
  =
   if ((c->options=2Emode !=3D MODE_SERVER) && (flags & IOW_WAIT_SIGNAL))
 =
    {
+        static uintptr_t err_shift =3D ERR_SHIFT;
         wait_sign=
al(es, (void *)err_shift);
     }
 
diff --git a/src/openvpn/httpdigest=2Ec=
 b/src/openvpn/httpdigest=2Ec
index ab8a710=2E=2E52df383 100644
--- a/src/o=
penvpn/httpdigest=2Ec
+++ b/src/openvpn/httpdigest=2Ec
@@ -34,12 +34,9 @@
 =
static void
 CvtHex(IN HASH Bin, OUT HASHHEX Hex)
 {
-    unsigned short i;=

-    unsigned char j;
-
-    for (i =3D 0; i < HASHLEN; i++)
+    for (uns=
igned short i =3D 0; i < HASHLEN; i++)
     {
-        j =3D (Bin[i] >> 4) =
& 0xf;
+        unsigned char j =3D (Bin[i] >> 4) & 0xf;
         if (j <=
=3D 9)
         {
             Hex[i * 2] =3D (j + '0');
diff --git a/src/o=
penvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 2f1ca95=2E=2E1e74f09 10064=
4
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -368,7 +368,=
6 @@
     {
         struct gc_arena gc =3D gc_new();
         struct log_e=
ntry e;
-        const char *out =3D NULL;
         unsigned int action_fla=
gs =3D 0;
 
         ++recursive_level;
@@ -391,6 +390,8 @@
 
         if (=
!man_password_needed(man))
         {
+            const char *out =3D NULL=
;
+
             if (flags =3D=3D M_CLIENT)
             {
                =
 out =3D log_entry_print(&e, LOG_PRINT_CRLF, &gc);
@@ -3036,14 +3037,15 @@
=
 static void
 man_output_peer_info_env(struct management *man, const struct=
 man_def_auth_context *mdac)
 {
-    char line[256];
     if (man->persist=
=2Ecallback=2Eget_peer_info)
     {
         const char *peer_info =3D
    =
         (*man->persist=2Ecallback=2Eget_peer_info)(man->persist=2Ecallback=
=2Earg, mdac->cid);
         if (peer_info)
         {
+            char li=
ne[256];
             struct buffer buf;
+
             buf_set_read(&buf, =
(const uint8_t *)peer_info, strlen(peer_info));
             while (buf_par=
se(&buf, '\n', line, sizeof(line)))
             {
@@ -3820,13 +3822,12 @@
=
 {
     int ok;
     char *result =3D NULL;
-    const struct buffer *buf;
=
 
     ok =3D management_query_multiline(man, b64_data, prompt, cmd, state,=
 input);
     if (ok && buffer_list_defined(*input))
     {
         buffer=
_list_aggregate_separator(*input, 10000, "\n");
-        buf =3D buffer_lis=
t_peek(*input);
+        const struct buffer *buf =3D buffer_list_peek(*inp=
ut);
         if (buf && BLEN(buf) > 0)
         {
             result =3D =
(char *)malloc(BLENZ(buf) + 1);
@@ -3847,15 +3848,13 @@
 management_query_m=
ultiline_flatten(struct management *man, const char *b64_data, const char *=
prompt,
                                    const char *cmd, int *state, st=
ruct buffer_list **input)
 {
-    int ok;
     char *result =3D NULL;
-    =
const struct buffer *buf;
 
-    ok =3D management_query_multiline(man, b64=
_data, prompt, cmd, state, input);
+    const int ok =3D management_query_m=
ultiline(man, b64_data, prompt, cmd, state, input);
     if (ok && buffer_l=
ist_defined(*input))
     {
         buffer_list_aggregate(*input, 2048);
-=
        buf =3D buffer_list_peek(*input);
+        const struct buffer *buf=
 =3D buffer_list_peek(*input);
         if (buf && BLEN(buf) > 0)
         =
{
             result =3D (char *)malloc(BLENZ(buf) + 1);
diff --git a/src/=
openvpn/misc=2Ec b/src/openvpn/misc=2Ec
index 54af890=2E=2E6e9591f 100644
-=
-- a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -474,7 +474,7 @@
 p=
urge_user_pass(struct user_pass *up, const bool force)
 {
     const bool n=
ocache =3D up->nocache;
-    static bool warn_shown =3D false;
+
     if (n=
ocache || force)
     {
         secure_memzero(up, sizeof(*up));
@@ -482,6=
 +482,8 @@
     }
     else
     {
+        static bool warn_shown =3D fals=
e;
+
         protect_user_pass(up);
         /*
          * don't show war=
ning if the pass has been replaced by a token: this is an
@@ -721,11 +723,1=
0 @@
 bool
 validate_peer_info_line(char *line)
 {
-    uint8_t c;
     int=
 state =3D 0;
     while (*line)
     {
-        c =3D *line;
+        cons=
t uint8_t c =3D *line;
         switch (state)
         {
             case=
 0:
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index b6c428=
c=2E=2E658424f 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=
=2Ec
@@ -4200,13 +4200,11 @@
 static void
 tunnel_server_loop(struct multi_=
context *multi)
 {
-    int status;
-
     while (true)
     {
         /* =
wait on tun/socket list */
         multi_get_timeout(multi, &multi->top=2E=
c2=2Etimeval);
-        status =3D multi_io_wait(multi);
+        const int=
 status =3D multi_io_wait(multi);
         MULTI_CHECK_SIG(multi);
 
      =
   /* check on status of coarse timers */
diff --git a/src/openvpn/networki=
ng_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index bb29781=2E=2E49de664 =
100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_=
sitnl=2Ec
@@ -1375,13 +1375,11 @@
 sitnl_parse_rtattr_flags(struct rtattr *=
tb[], size_t max, struct rtattr *rta, size_t len,
                         =
 unsigned short flags)
 {
-    unsigned short type;
-
     memset(tb, 0, si=
zeof(struct rtattr *) * (max + 1));
 
     while (RTA_OK(rta, len))
     {
=
-        type =3D rta->rta_type & ~flags;
+        const unsigned short typ=
e =3D rta->rta_type & ~flags;
 
         if ((type <=3D max) && (!tb[type])=
)
         {
@@ -1409,7 +1407,6 @@
 static int
 sitnl_type_save(struct nlms=
ghdr *n, void *arg)
 {
-    char *type =3D arg;
     struct ifinfomsg *ifi =
=3D NLMSG_DATA(n);
     struct rtattr *tb[IFLA_MAX + 1];
 
@@ -1418,6 +1415=
,7 @@
     if (tb[IFLA_LINKINFO])
     {
         struct rtattr *tb_link[IF=
LA_INFO_MAX + 1];
+        char *type =3D arg;
 
         sitnl_parse_rtatt=
r_nested(tb_link, IFLA_INFO_MAX, tb[IFLA_LINKINFO]);
 
diff --git a/src/ope=
nvpn/options=2Ec b/src/openvpn/options=2Ec
index 5a57c0a=2E=2E1f4b191 10064=
4
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1019,10 +=
1019,9 @@
 
     for (current =3D *list, prev =3D NULL; current !=3D NULL; =
current =3D current->next)
     {
-        char *tmp_value =3D NULL;
      =
   if (!strncmp(current->string, "foreign_option_", sizeof("foreign_option_=
") - 1))
         {
-            tmp_value =3D strchr(current->string, '=3D=
');
+            const char *tmp_value =3D strchr(current->string, '=3D');
=
             if (tmp_value && ++tmp_value)
             {
                 =
if (!strncmp(tmp_value, "dhcp-option ", sizeof("dhcp-option ") - 1))
diff -=
-git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_parse=2Ec
index =
0e94522=2E=2E79b8098 100644
--- a/src/openvpn/options_parse=2Ec
+++ b/src/o=
penvpn/options_parse=2Ec
@@ -351,7 +351,6 @@
 {
     const int max_recursiv=
e_levels =3D 10;
     FILE *fp;
-    int line_num;
     char line[OPTION_LI=
NE_SIZE + 1];
     char *p[MAX_PARMS + 1];
 
@@ -368,7 +367,7 @@
         }=

         if (fp)
         {
-            line_num =3D 0;
+            int =
line_num =3D 0;
             while (fgets(line, sizeof(line), fp))
        =
     {
                 int offset =3D 0;
diff --git a/src/openvpn/packet_i=
d=2Ec b/src/openvpn/packet_id=2Ec
index 22c53c7=2E=2E50d7c76 100644
--- a/s=
rc/openvpn/packet_id=2Ec
+++ b/src/openvpn/packet_id=2Ec
@@ -219,8 +219,6 @=
@
 bool
 packet_id_test(struct packet_id_rec *p, const struct packet_id_net=
 *pin)
 {
-    uint64_t diff;
-
     packet_id_debug(D_PID_DEBUG, p, pin, "=
PID_TEST", 0);
 
     ASSERT(p->initialized);
@@ -247,7 +245,7 @@
         =
    }
 
             /* check packet-id sliding window for original/replay =
status */
-            diff =3D p->id - pin->id;
+            const uint64_=
t diff =3D p->id - pin->id;
 
             /* keep track of maximum backtra=
ck seen for debugging purposes */
             if (diff > p->max_backtrack_=
stat)
@@ -512,7 +510,6 @@
     {
         struct packet_id_persist_file_ima=
ge image;
         CLEAR(image);
-        ssize_t n;
         off_t seek_re=
t;
         struct gc_arena gc =3D gc_new();
 
@@ -521,7 +518,7 @@
        =
 seek_ret =3D lseek(p->fd, (off_t)0, SEEK_SET);
         if (seek_ret =3D=
=3D (off_t)0)
         {
-            n =3D write(p->fd, &image, sizeof(ima=
ge));
+            const ssize_t n =3D write(p->fd, &image, sizeof(image));=

             if (n =3D=3D sizeof(image))
             {
                 p=
->time_last_written =3D p->time;
@@ -599,7 +596,6 @@
     {
         char c=
;
         time_t v;
-        int diff;
 
         v =3D CIRC_LIST_ITEM(sl,=
 i);
         if (v =3D=3D SEQ_UNSEEN)
@@ -612,7 +608,7 @@
         }
     =
    else
         {
-            diff =3D (int)(prev_now - v);
+           =
 const int diff =3D (int)(prev_now - v);
             if (diff < 0)
       =
      {
                 c =3D 'N';
diff --git a/src/openvpn/platform=2Ec b=
/src/openvpn/platform=2Ec
index ccdd43d=2E=2E9412eeb 100644
--- a/src/openv=
pn/platform=2Ec
+++ b/src/openvpn/platform=2Ec
@@ -539,8 +539,6 @@
 const c=
har *
 platform_create_temp_file(const char *directory, const char *prefix,=
 struct gc_arena *gc)
 {
-    int fd;
-    const char *retfname =3D NULL;
 =
    unsigned int attempts =3D 0;
     char fname[256] =3D { 0 };
     const=
 char *fname_fmt =3D PACKAGE "_%=2E*s_%08" PRIx64 "%08" PRIx64 "=2Etmp";
@@=
 -557,7 +555,7 @@
             return NULL;
         }
 
-        retfname =
=3D platform_gen_path(directory, fname, gc);
+        const char *retfname =
=3D platform_gen_path(directory, fname, gc);
         if (!retfname)
      =
   {
             msg(M_WARN, "Failed to create temporary filename and path=
");
@@ -566,7 +564,7 @@
 
         /* Atomically create the file=2E  Errors=
 out if the file already
          * exists=2E  */
-        fd =3D platform=
_open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR);
+        c=
onst int fd =3D platform_open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUS=
R | S_IWUSR);
         if (fd !=3D -1)
         {
             close(fd);
d=
iff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index 80dec6c=2E=2E=
63fc930 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -49=
4,22 +494,21 @@
         for (i =3D 0; i < pool->size; ++i)
         {
    =
         const struct ifconfig_pool_entry *e =3D &pool->list[i];
-         =
   struct in6_addr ip6;
-            in_addr_t ip;
-            const char =
*ip6_str =3D "";
-            const char *ip_str =3D "";
 
             if =
(e->common_name)
             {
+                const char *ip6_str =3D ""=
;
+                const char *ip_str =3D "";
+
                 if (pool->=
ipv4=2Eenabled)
                 {
-                    ip =3D ifconfig_poo=
l_handle_to_ip_base(pool, i);
+                    const in_addr_t ip =3D i=
fconfig_pool_handle_to_ip_base(pool, i);
                     ip_str =3D pr=
int_in_addr_t(ip, 0, &gc);
                 }
 
                 if (pool->=
ipv6=2Eenabled)
                 {
-                    ip6 =3D ifconfig_po=
ol_handle_to_ipv6_base(pool, i);
+                    const struct in6_addr=
 ip6 =3D ifconfig_pool_handle_to_ipv6_base(pool, i);
                     i=
p6_str =3D print_in6_addr(ip6, 0, &gc);
                 }
 
diff --git a/s=
rc/openvpn/proto=2Ec b/src/openvpn/proto=2Ec
index 785c021=2E=2E2cdb147 100=
644
--- a/src/openvpn/proto=2Ec
+++ b/src/openvpn/proto=2Ec
@@ -39,7 +39,6 =
@@
 is_ipv_X(int tunnel_type, struct buffer *buf, int ip_ver)
 {
     int o=
ffset;
-    uint16_t proto;
     const struct openvpn_iphdr *ih;
 
     ver=
ify_align_4(buf);
@@ -61,7 +60,7 @@
         eh =3D (const struct openvpn_e=
thhdr *)BPTR(buf);
 
         /* start by assuming this is a standard Eth f=
ram */
-        proto =3D eh->proto;
+        uint16_t proto =3D eh->proto;=

         offset =3D sizeof(struct openvpn_ethhdr);
 
         /* if this i=
s a 802=2E1q frame, parse the header using the according
diff --git a/src/o=
penvpn/push=2Ec b/src/openvpn/push=2Ec
index a514d92a=2E=2E8dfe0d5 100644
-=
-- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -1155,7 +1155,6 @@
=
         while (e)
         {
             char *p[MAX_PARMS + 1];
-       =
     bool enable =3D true;
 
             /* parse the push item */
       =
      CLEAR(p);
@@ -1163,6 +1162,8 @@
                 && parse_line(e->opt=
ion, p, SIZE(p) - 1, "[PUSH_ROUTE_REMOVE]", 1, D_ROUTE_DEBUG,
             =
                  &gc))
             {
+                bool enable =3D tru=
e;
+
                 /* is the push item a route directive? */
           =
      if (p[0] && !strcmp(p[0], "route") && !p[3] && o->iroutes)
          =
       {
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index b=
8bac7a=2E=2E4830a5b 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/ro=
ute=2Ec
@@ -2773,7 +2773,6 @@
 {
     struct gc_arena gc =3D gc_new();
    =
 bool ret =3D false;
-    DWORD status;
     const DWORD if_index =3D windo=
ws_route_find_if_index(r, tt);
 
     if (if_index !=3D TUN_ADAPTER_INDEX_I=
NVALID)
@@ -2787,8 +2786,7 @@
         fr=2EdwForwardNextHop =3D htonl(r->g=
ateway);
         fr=2EdwForwardIfIndex =3D if_index;
 
-        status =3D=
 DeleteIpForwardEntry(&fr);
-
+        const DWORD status =3D DeleteIpForwa=
rdEntry(&fr);
         if (status =3D=3D NO_ERROR)
         {
             =
ret =3D true;
@@ -3826,12 +3824,11 @@
 bool
 netmask_to_netbits(const in_ad=
dr_t network, const in_addr_t netmask, int *netbits)
 {
-    int i;
     co=
nst int addrlen =3D sizeof(in_addr_t) * 8;
 
     if ((network & netmask) =
=3D=3D network)
     {
-        for (i =3D 0; i <=3D addrlen; ++i)
+       =
 for (int i =3D 0; i <=3D addrlen; ++i)
         {
             in_addr_t m=
ask =3D netbits_to_netmask(i);
             if (mask =3D=3D netmask)
diff -=
-git a/src/openvpn/run_command=2Ec b/src/openvpn/run_command=2Ec
index 905c=
aa3=2E=2E0e36dad 100644
--- a/src/openvpn/run_command=2Ec
+++ b/src/openvpn=
/run_command=2Ec
@@ -176,14 +176,13 @@
 #if defined(ENABLE_FEATURE_EXECVE)
=
         if (openvpn_execve_allowed(flags))
         {
-            const c=
har *cmd =3D a->argv[0];
-            char *const *argv =3D a->argv;
      =
       char *const *envp =3D (char *const *)make_env_array(es, true, &gc);
=
-            pid_t pid;
 
-            pid =3D fork();
+            const p=
id_t pid =3D fork();
             if (pid =3D=3D (pid_t)0) /* child side */=

             {
+                const char *cmd =3D a->argv[0];
+         =
       char *const *argv =3D a->argv;
                 execve(cmd, argv, en=
vp);
                 exit(OPENVPN_EXECVE_FAILURE);
             }
@@ -283,=
17 +282,17 @@
         static bool warn_shown =3D false;
         if (scrip=
t_security() >=3D SSEC_BUILT_IN)
         {
-            const char *cmd =
=3D a->argv[0];
-            char *const *argv =3D a->argv;
             ch=
ar *const *envp =3D (char *const *)make_env_array(es, true, &gc);
-        =
    pid_t pid;
+            const char *cmd =3D a->argv[0];
             in=
t pipe_stdout[2];
 
             if (pipe(pipe_stdout) =3D=3D 0)
          =
   {
-                pid =3D fork();
-                if (pid =3D=3D (pid_=
t)0)       /* child side */
+                const pid_t pid =3D fork();
+ =
               if (pid =3D=3D (pid_t)0) /* child side */
                 {=

+                    char *const *argv =3D a->argv;
+
                    =
 close(pipe_stdout[0]); /* Close read end */
                     dup2(pipe=
_stdout[1], 1);
                     execve(cmd, argv, envp);
diff --git a/=
src/openvpn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec
index=
 5f0adb9=2E=2E9240ab0 100644
--- a/src/openvpn/siphash_reference=2Ec
+++ b/=
src/openvpn/siphash_reference=2Ec
@@ -113,7 +113,6 @@
     uint64_t v3 =3D =
UINT64_C(0x7465646279746573);
     uint64_t k0 =3D U8TO64_LE(kk);
     uint=
64_t k1 =3D U8TO64_LE(kk + 8);
-    uint64_t m;
     int i;
     const unsi=
gned char *end =3D ni + inlen - (inlen % sizeof(uint64_t));
     const int =
left =3D inlen & 7;
@@ -130,7 +129,7 @@
 
     for (; ni !=3D end; ni +=3D =
8)
     {
-        m =3D U8TO64_LE(ni);
+        uint64_t m =3D U8TO64_LE(n=
i);
         v3 ^=3D m;
 
         TRACE;
diff --git a/src/openvpn/ssl_mbed=
tls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index cddf856=2E=2Eb60a8f0 100644
---=
 a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -1014,1=
2 +1014,12 @@
 tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 {
 #if=
 MBEDTLS_VERSION_NUMBER < 0x04000000
-    static char old_sha256_hash[32] =
=3D { 0 };
-    unsigned char sha256_hash[32] =3D { 0 };
     mbedtls_ctr_d=
rbg_context *cd_ctx =3D rand_ctx_get();
 
     if (NULL !=3D ctx->crt_chain=
)
     {
+        static char old_sha256_hash[32] =3D { 0 };
+        unsig=
ned char sha256_hash[32] =3D { 0 };
         mbedtls_x509_crt *cert =3D ctx=
->crt_chain;
         const mbedtls_md_info_t *kt =3D md_get("SHA256");
 
d=
iff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index=
 cb3de65=2E=2Eafda4d9 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/op=
envpn/ssl_openssl=2Ec
@@ -1784,10 +1784,7 @@
 {
     STACK_OF(X509_INFO) *i=
nfo_stack =3D NULL;
     STACK_OF(X509_NAME) *cert_names =3D NULL;
-    X50=
9_LOOKUP *lookup =3D NULL;
     X509_STORE *store =3D NULL;
-    BIO *in =
=3D NULL;
-    openssl_stack_size_t added =3D 0, prev =3D 0;
 
     ASSERT(=
NULL !=3D ctx);
 
@@ -1800,6 +1797,9 @@
     /* Try to add certificates and=
 CRLs from ca_file */
     if (ca_file)
     {
+        openssl_stack_size_=
t added =3D 0;
+        BIO *in =3D NULL;
+
         if (ca_file_inline)
  =
       {
             in =3D BIO_new_mem_buf((char *)ca_file, -1);
@@ -1816=
,6 +1816,8 @@
 
         if (info_stack)
         {
+            openssl_st=
ack_size_t prev =3D 0;
+
             for (openssl_stack_size_t i =3D 0; i =
< sk_X509_INFO_num(info_stack); i++)
             {
                 X509_I=
NFO *info =3D sk_X509_INFO_value(info_stack, i);
@@ -1916,7 +1918,7 @@
    =
 /* Set a store for certs (CA & CRL) with a lookup on the "capath" hash dir=
ectory */
     if (ca_path)
     {
-        lookup =3D X509_STORE_add_looku=
p(store, X509_LOOKUP_hash_dir());
+        X509_LOOKUP *lookup =3D X509_STO=
RE_add_lookup(store, X509_LOOKUP_hash_dir());
         if (lookup && X509_L=
OOKUP_add_dir(lookup, ca_path, X509_FILETYPE_PEM))
         {
             =
msg(M_WARN, "WARNING: experimental option --capath %s", ca_path);
diff --gi=
t a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 79d2b23=2E=2Ef7=
8782f 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@=
 -74,8 +74,6 @@
 
         int e1, e2;
         uint8_t *b =3D BPTR(buf);
-=
        uint8_t buf1[SWAP_BUF_SIZE];
-        uint8_t buf2[SWAP_BUF_SIZE];
=
 
         if (incoming)
         {
@@ -92,6 +90,9 @@
 
         if (buf->l=
en >=3D e1 + e2)
         {
+            uint8_t buf1[SWAP_BUF_SIZE];
+    =
        uint8_t buf2[SWAP_BUF_SIZE];
+
             memcpy(buf1, b, e1);
  =
           memcpy(buf2, b + e1, e2);
             memcpy(b, buf2, e2);
diff=
 --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtl=
s=2Ec
index c4bae40=2E=2Eb9a36a6 100644
--- a/src/openvpn/ssl_verify_mbedtl=
s=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -701,7 +701,6 @@
 void
 x=
509_setenv(struct env_set *es, int cert_depth, mbedtls_x509_crt *cert)
 {
-=
    unsigned char c;
     const mbedtls_x509_name *name;
     char s[128] =
=3D { 0 };
 
@@ -729,7 +728,7 @@
                 break;
             }
 
-=
            c =3D name->val=2Ep[i];
+            const unsigned char c =3D =
name->val=2Ep[i];
             if (c < 32 || c =3D=3D 127 || (c > 128 && c =
< 160))
             {
                 s[i] =3D '?';
diff --git a/src/open=
vpn/tun=2Ec b/src/openvpn/tun=2Ec
index 85b3074=2E=2E2d375a8 100644
--- a/s=
rc/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -1893,7 +1893,6 @@
        =
              openvpn_net_ctx_t *ctx)
 {
     char dynamic_name[256];
-    =
bool dynamic_opened =3D false;
 
     /*
      * unlike "open_tun_generic()=
", DCO on Linux and FreeBSD follows
@@ -1905,6 +1904,8 @@
 
     if (strcmp=
(dev, "tun") =3D=3D 0)
     {
+        bool dynamic_opened =3D false;
+
   =
      for (int i =3D 0; i < 256; ++i)
         {
             snprintf(dyna=
mic_name, sizeof(dynamic_name), "%s%d", dev, i);
@@ -3263,7 +3264,6 @@
    =
 if (tt->reads=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
         BOOL statu=
s;
-        int err;
 
         /* reset buf to its initial state */
      =
   tt->reads=2Ebuf =3D tt->reads=2Ebuf_init;
@@ -3290,7 +3290,7 @@
        =
 }
         else
         {
-            err =3D GetLastError();
+         =
   const int err =3D GetLastError();
             if (err =3D=3D ERROR_IO_P=
ENDING) /* operation queued? */
             {
                 tt->reads=
=2Eiostate =3D IOSTATE_QUEUED;
@@ -3318,7 +3318,6 @@
     if (tt->writes=2E=
iostate =3D=3D IOSTATE_INITIAL)
     {
         BOOL status;
-        int e=
rr;
 
         /* make a private copy of buf */
         tt->writes=2Ebuf =
=3D tt->writes=2Ebuf_init;
@@ -3345,7 +3344,7 @@
         }
         else
 =
        {
-            err =3D GetLastError();
+            const int err =
=3D GetLastError();
             if (err =3D=3D ERROR_IO_PENDING) /* operat=
ion queued? */
             {
                 tt->writes=2Eiostate =3D IOS=
TATE_QUEUED;
@@ -3542,8 +3541,6 @@
         char enum_name[256];
         c=
har unit_string[256];
         HKEY unit_key;
-        char component_id_st=
ring[] =3D "ComponentId";
-        char component_id[256];
         const c=
har net_cfg_instance_id_string[] =3D "NetCfgInstanceId";
         BYTE net_=
cfg_instance_id[256];
         DWORD data_type;
@@ -3573,6 +3570,8 @@
     =
    }
         else
         {
+            const char component_id_string[=
] =3D "ComponentId";
+            char component_id[256];
             len =
=3D sizeof(component_id);
             status =3D RegQueryValueEx(unit_key,=
 component_id_string, NULL, &data_type,
                                   =
   (LPBYTE)component_id, &len);
@@ -3657,7 +3656,6 @@
         char enum_na=
me[256];
         char connection_string[256];
         HKEY connection_key=
;
-        WCHAR name_data[256];
         DWORD name_type;
         const W=
CHAR name_string[] =3D L"Name";
 
@@ -3689,6 +3687,7 @@
         }
        =
 else
         {
+            WCHAR name_data[256];
             len =3D si=
zeof(name_data);
             status =3D RegQueryValueExW(connection_key, n=
ame_string, NULL, &name_type,
                                       (LPBYT=
E)name_data, &len);
@@ -3813,8 +3812,6 @@
     bool warn_panel_dup =3D fals=
e;
     bool warn_tap_dup =3D false;
 
-    int links;
-
     const struct =
tap_reg *tr;
     const struct tap_reg *tr1;
     const struct panel_reg *p=
r;
@@ -3827,7 +3824,7 @@
     /* loop through each TAP-Windows adapter regi=
stry entry */
     for (tr =3D tap_reg; tr !=3D NULL; tr =3D tr->next)
    =
 {
-        links =3D 0;
+        int links =3D 0;
 
         /* loop throu=
gh each network connections entry in the control panel */
         for (pr =
=3D panel_reg; pr !=3D NULL; pr =3D pr->next)
@@ -4110,10 +4107,11 @@
 {
  =
   ULONG size =3D 0;
     IP_PER_ADAPTER_INFO *pi =3D NULL;
-    DWORD stat=
us;
 
     if (index !=3D TUN_ADAPTER_INDEX_INVALID)
     {
+        DWORD =
status;
+
         if ((status =3D GetPerAdapterInfo(index, NULL, &size)) !=
=3D ERROR_BUFFER_OVERFLOW)
         {
             msg(M_INFO, "GetPerAdapt=
erInfo #1 failed (status=3D%lu) : %s", status,
@@ -4308,7 +4306,6 @@
 bool
=
 is_adapter_up(const struct tuntap *tt, const IP_ADAPTER_INFO *list)
 {
-  =
  int i;
     bool ret =3D false;
 
     const IP_ADAPTER_INFO *ai =3D get_=
tun_adapter(tt, list);
@@ -4318,7 +4315,7 @@
         const int n =3D get_a=
dapter_n_ip_netmask(ai);
 
         /* loop once for every IP/netmask assig=
ned to adapter */
-        for (i =3D 0; i < n; ++i)
+        for (int i =
=3D 0; i < n; ++i)
         {
             in_addr_t ip, netmask;
         =
    if (get_adapter_ip_netmask(ai, i, &ip, &netmask))
@@ -4352,7 +4349,6 @@=

 bool
 is_ip_in_adapter_subnet(const IP_ADAPTER_INFO *ai, const in_addr_t =
ip, in_addr_t *highest_netmask)
 {
-    int i;
     bool ret =3D false;
 
 =
    if (highest_netmask)
@@ -4363,7 +4359,7 @@
     if (ai)
     {
        =
 const int n =3D get_adapter_n_ip_netmask(ai);
-        for (i =3D 0; i < n=
; ++i)
+        for (int i =3D 0; i < n; ++i)
         {
             in_ad=
dr_t adapter_ip, adapter_netmask;
             if (get_adapter_ip_netmask(a=
i, i, &adapter_ip, &adapter_netmask))
diff --git a/src/openvpn/win32=2Ec b/=
src/openvpn/win32=2Ec
index 4c511a9=2E=2Efde6412 100644
--- a/src/openvpn/w=
in32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1042,7 +1042,6 @@
 openvpn_execve(=
const struct argv *a, const struct env_set *es, const unsigned int flags)
 =
{
     int ret =3D OPENVPN_EXECVE_ERROR;
-    static bool exec_warn =3D fal=
se;
 
     if (a && a->argv[0])
     {
@@ -1093,6 +1092,8 @@
         }
   =
      else
         {
+            static bool exec_warn =3D false;
+
     =
        ret =3D OPENVPN_EXECVE_NOT_ALLOWED;
             if (!exec_warn && =
(script_security() < SSEC_SCRIPTS))
             {
@@ -1489,11 +1490,10 @@
=
 static void
 set_openssl_env_vars(void)
 {
-    const WCHAR *ssl_fallback_=
dir =3D L"C:\\Windows\\System32";
-
     WCHAR install_path[MAX_PATH] =3D {=
 0 };
     if (!get_openvpn_reg_value(NULL, install_path, _countof(install_=
path)))
     {
+        const WCHAR *ssl_fallback_dir =3D L"C:\\Windows\\Sy=
stem32";
         /* if we cannot find installation path from the registry,=

          * use Windows directory as a fallback
          */
diff --git a/=
src/openvpnserv/common=2Ec b/src/openvpnserv/common=2Ec
index cce5318=2E=2E=
7a23d41 100644
--- a/src/openvpnserv/common=2Ec
+++ b/src/openvpnserv/commo=
n=2Ec
@@ -254,10 +254,8 @@
 MsgToEventLog(DWORD flags, LPCWSTR format, =2E=
=2E=2E)
 {
     HANDLE hEventSource;
-    WCHAR msg[2][256];
     DWORD err=
or =3D 0;
     LPCWSTR err_msg =3D L"";
-    va_list arglist;
 
     if (fl=
ags & MSG_FLAGS_SYS_CODE)
     {
@@ -268,6 +266,9 @@
     hEventSource =3D =
RegisterEventSource(NULL, APPNAME);
     if (hEventSource !=3D NULL)
     {=

+        va_list arglist;
+        WCHAR msg[2][256];
+
         swprintf(=
msg[0], _countof(msg[0]), L"%ls%ls%ls: %ls", APPNAME, service_instance,
   =
               (flags & MSG_FLAGS_ERROR) ? L" error" : L"", err_msg);
 
@@ =
-311,10 +312,10 @@
 const wchar_t *
 get_win_sys_path(void)
 {
-    const w=
char_t *default_sys_path =3D L"C:\\Windows\\system32";
-
     if (!GetSyste=
mDirectoryW(win_sys_path, _countof(win_sys_path)))
     {
+        const wc=
har_t *default_sys_path =3D L"C:\\Windows\\system32";
+
         wcscpy_s(w=
in_sys_path, _countof(win_sys_path), default_sys_path);
         win_sys_pa=
th[_countof(win_sys_path) - 1] =3D L'\0';
     }
diff --git a/src/openvpnse=
rv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 026d5aa=2E=2Ed8c=
f6e1 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/int=
eractive=2Ec
@@ -933,7 +933,6 @@
 RegisterDNS(LPVOID unused)
 {
     DWORD =
err;
-    size_t i;
     DWORD timeout =3D RDNS_TIMEOUT * 1000; /* in milli=
seconds */
 
     /* path of ipconfig command */
@@ -956,7 +955,7 @@
     i=
f (WaitForMultipleObjects(2, wait_handles, FALSE, timeout) =3D=3D WAIT_OBJE=
CT_0)
     {
         /* Semaphore locked */
-        for (i =3D 0; i < _co=
untof(cmds); ++i)
+        for (size_t i =3D 0; i < _countof(cmds); ++i)
  =
       {
             ExecCommand(cmds[i]=2Eargv0, cmds[i]=2Ecmdline, cmds[=
i]=2Etimeout);
         }
diff --git a/src/openvpnserv/service=2Ec b/src/op=
envpnserv/service=2Ec
index 04b20d7=2E=2E2913f63 100644
--- a/src/openvpnse=
rv/service=2Ec
+++ b/src/openvpnserv/service=2Ec
@@ -21,7 +21,6 @@
 BOOL
 R=
eportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status)
 =
{
-    static DWORD dwCheckPoint =3D 1;
     BOOL res =3D TRUE;
 
     if (=
status->dwCurrentState =3D=3D SERVICE_START_PENDING)
@@ -39,6 +38,7 @@
    =
 }
     else
     {
+        static DWORD dwCheckPoint =3D 1;
         stat=
us->dwCheckPoint =3D dwCheckPoint++;
     }
 
@@ -55,7 +55,6 @@
 static int=

 CmdInstallServices(void)
 {
-    SC_HANDLE service;
     SC_HANDLE svc_ct=
l_mgr;
     WCHAR path[512];
     int i, ret =3D _service_max;
@@ -78,7 +77=
,7 @@
 
     for (i =3D 0; i < _service_max; i++)
     {
-        service =
=3D CreateService(
+        SC_HANDLE service =3D CreateService(
          =
   svc_ctl_mgr, openvpn_service[i]=2Ename, openvpn_service[i]=2Edisplay_nam=
e,
             SERVICE_QUERY_STATUS, SERVICE_WIN32_SHARE_PROCESS, openvpn_=
service[i]=2Estart_type,
             SERVICE_ERROR_NORMAL, path, NULL, NUL=
L, openvpn_service[i]=2Edependencies, NULL, NULL);
diff --git a/tests/unit_=
tests/openvpn/test_provider=2Ec b/tests/unit_tests/openvpn/test_provider=2E=
c
index 5619f36=2E=2Ee5562ee 100644
--- a/tests/unit_tests/openvpn/test_pro=
vider=2Ec
+++ b/tests/unit_tests/openvpn/test_provider=2Ec
@@ -378,12 +378,=
11 @@
 static void
 xkey_provider_test_generic_sign_cb(void **state)
 {
-  =
  EVP_PKEY *pubkey;
     const char *dummy =3D "xkey_handle"; /* a dummy ha=
ndle for the external key */
 
     for (size_t i =3D 0; i < _countof(pubke=
ys); i++)
     {
-        pubkey =3D load_pubkey(pubkeys[i]);
+        EVP_=
PKEY *pubkey =3D load_pubkey(pubkeys[i]);
         assert_non_null(pubkey);=

 
         EVP_PKEY *privkey =3D

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1963?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7
Gerrit-Change-Numb=
er: 1963
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--GX76IaWGXO8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1963?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Fix (almost) all occurrences of cppcheck variableScope<br><br>In two c=
ases I found the code change too ugly and added<br>a suppression=2E In most=
 cases the change is trivially<br>correct (as long as it builds)=2E<br><br>=
Some drive-by style fixes, and marked some of the moved<br>variables const =
as appropriate=2E<br><br>Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238=
b7<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>-=
--<br>M dev-tools/cppcheck-suppressions=2Exml<br>M sample/sample-plugins/ke=
ying-material-exporter-demo/keyingmaterialexporter=2Ec<br>M sample/sample-p=
lugins/log/log_v3=2Ec<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/clinat=
=2Ec<br>M src/openvpn/console_builtin=2Ec<br>M src/openvpn/crypto=2Ec<br>M =
src/openvpn/crypto_epoch=2Ec<br>M src/openvpn/dco_freebsd=2Ec<br>M src/open=
vpn/dhcp=2Ec<br>M src/openvpn/env_set=2Ec<br>M src/openvpn/forward=2Ec<br>M=
 src/openvpn/httpdigest=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/mi=
sc=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>=
M src/openvpn/options=2Ec<br>M src/openvpn/options_parse=2Ec<br>M src/openv=
pn/packet_id=2Ec<br>M src/openvpn/platform=2Ec<br>M src/openvpn/pool=2Ec<br=
>M src/openvpn/proto=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/route=
=2Ec<br>M src/openvpn/run_command=2Ec<br>M src/openvpn/siphash_reference=2E=
c<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M sr=
c/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>M src/open=
vpn/tun=2Ec<br>M src/openvpn/win32=2Ec<br>M src/openvpnserv/common=2Ec<br>M=
 src/openvpnserv/interactive=2Ec<br>M src/openvpnserv/service=2Ec<br>M test=
s/unit_tests/openvpn/test_provider=2Ec<br>37 files changed, 108 insertions(=
+), 134 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/63/1963/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-to=
ols/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml</sp=
an><br><span>index 38de5f2a=2E=2Ebd24c3b 100644</span><br><span>--- a/dev-t=
ools/cppcheck-suppressions=2Exml</span><br><span>+++ b/dev-tools/cppcheck-s=
uppressions=2Exml</span><br><span>@@ -14,9 +14,6 @@</span><br><span>   &lt;=
suppress&gt;</span><br><span>     &lt;id&gt;usleepCalled&lt;/id&gt;</span><=
br><span>   &lt;/suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  &lt;suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;id&gt;variableScope&lt;/id&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  &lt;/suppress&gt;</span><br><span>   &lt;!-- We hav=
e a lot of library includes, not all of them are really required,</span><br=
><span>        so ignore them --&gt;</span><br><span>   &lt;suppress&gt;</s=
pan><br><span>@@ -288,4 +285,15 @@</span><br><span>     &lt;id&gt;unusedStr=
uctMember&lt;/id&gt;</span><br><span>     &lt;fileName&gt;tests/unit_tests/=
openvpn/test_pkcs11=2Ec&lt;/fileName&gt;</span><br><span>   &lt;/suppress&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: ni=
cer --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;sup=
press&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id=
&gt;variableScope&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &lt;fileName&gt;src/openvpnserv/interactive=2Ec&lt;/fileName&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolNam=
e&gt;cmds&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &lt;id&gt;variableScope&lt;/id&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpnserv/interactive=
=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &lt;symbolName&gt;sys_key&lt;/symbolName&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span> &lt;/su=
ppressions&gt;</span><br><span>diff --git a/sample/sample-plugins/keying-ma=
terial-exporter-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/key=
ing-material-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>index=
 512861a=2E=2E2474bf1 100644</span><br><span>--- a/sample/sample-plugins/ke=
ying-material-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>+++ =
b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporte=
r=2Ec</span><br><span>@@ -120,13 +120,14 @@</span><br><span>     ASN1_OBJEC=
T *fn;</span><br><span>     ASN1_STRING *val;</span><br><span>     X509_NAM=
E *x509_name;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    X509=
_NAME_ENTRY *ent;</span><br><span>     const char *objbuf;</span><br><span>=
 </span><br><span>     x509_name =3D X509_get_subject_name(x509);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int i, n =3D X509_NAME_entr=
y_count(x509_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int n =3D X509_NAME_entry_count(x509_name);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n; ++i)=
</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        X509_NAME_ENTRY *ent;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>         if (!(ent =3D X509_NAME_get_entry(x=
509_name, i)))</span><br><span>         {</span><br><span>             cont=
inue;</span><br><span>diff --git a/sample/sample-plugins/log/log_v3=2Ec b/s=
ample/sample-plugins/log/log_v3=2Ec</span><br><span>index 09c6735=2E=2E1c78=
1a3 100644</span><br><span>--- a/sample/sample-plugins/log/log_v3=2Ec</span=
><br><span>+++ b/sample/sample-plugins/log/log_v3=2Ec</span><br><span>@@ -1=
97,7 +197,6 @@</span><br><span>     ASN1_OBJECT *fn;</span><br><span>     A=
SN1_STRING *val;</span><br><span>     X509_NAME *x509_name;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    X509_NAME_ENTRY *ent;</span><br><=
span>     const char *objbuf;</span><br><span>     unsigned char *buf =3D N=
ULL;</span><br><span> </span><br><span>@@ -205,7 +204,7 @@</span><br><span>=
     n =3D X509_NAME_entry_count(x509_name);</span><br><span>     for (i =
=3D 0; i &lt; n; ++i)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        ent =3D X509_NAME_get_entry(x509_name, i);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        X509_NAME_ENT=
RY *ent =3D X509_NAME_get_entry(x509_name, i);</span><br><span>         if =
(!ent)</span><br><span>         {</span><br><span>             continue;</s=
pan><br><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec<=
/span><br><span>index 21e113d=2E=2E8f558b1 100644</span><br><span>--- a/src=
/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br>=
<span>@@ -228,13 +228,13 @@</span><br><span>     int ret =3D false;</span><=
br><span>     if (buf_defined(buf))</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        va_list arglist;</span><br><sp=
an>         uint8_t *ptr =3D BEND(buf);</span><br><span>         int cap =
=3D buf_forward_capacity(buf);</span><br><span> </span><br><span>         i=
f (cap &gt; 0)</span><br><span>         {</span><br><span>             int =
stat;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            va=
_list arglist;</span><br><span>             va_start(arglist, format);</spa=
n><br><span>             stat =3D vsnprintf((char *)ptr, cap, format, argli=
st);</span><br><span>             va_end(arglist);</span><br><span>diff --g=
it a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec</span><br><span>index =
9fa8f5f=2E=2Ed72d42a 100644</span><br><span>--- a/src/openvpn/clinat=2Ec</s=
pan><br><span>+++ b/src/openvpn/clinat=2Ec</span><br><span>@@ -50,12 +50,11=
 @@</span><br><span> print_client_nat_list(const struct client_nat_option_l=
ist *list, msglvl_t msglevel)</span><br><span> {</span><br><span>     struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    int i;</span><br><span> </span><br><span>     msg(msglevel, &quot=
;*** CNAT list&quot;);</span><br><span>     if (list)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0=
; i &lt; list-&gt;n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        for (int i =3D 0; i &lt; list-&gt;n; ++i)</span><br><span>   =
      {</span><br><span>             const struct client_nat_entry *e =3D &=
amp;list-&gt;entries[i];</span><br><span>             msg(msglevel, &quot; =
 CNAT[%d] t=3D%d %s/%s/%s&quot;, i, e-&gt;type,</span><br><span>diff --git =
a/src/openvpn/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec</span><=
br><span>index 9c8d72a=2E=2Ecf6cc37 100644</span><br><span>--- a/src/openvp=
n/console_builtin=2Ec</span><br><span>+++ b/src/openvpn/console_builtin=2Ec=
</span><br><span>@@ -77,7 +77,6 @@</span><br><span>     bool is_console =3D=
 (GetFileType(in) =3D=3D FILE_TYPE_CHAR);</span><br><span>     DWORD flags_=
save =3D 0;</span><br><span>     int status =3D 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    WCHAR *winput;</span><br><span> </span><br=
><span>     if (is_console)</span><br><span>     {</span><br><span>@@ -100,=
7 +99,7 @@</span><br><span> </span><br><span>     if (is_console)</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
winput =3D malloc(capacity * sizeof(WCHAR));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        WCHAR *winput =3D malloc(capacity * sizeof=
(WCHAR));</span><br><span>         if (winput =3D=3D NULL)</span><br><span>=
         {</span><br><span>             return false;</span><br><span>diff =
--git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>ind=
ex 8196c26=2E=2E3d3ab0c 100644</span><br><span>--- a/src/openvpn/crypto=2Ec=
</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1774,13 +=
1774,10 @@</span><br><span> static const cipher_name_pair *</span><br><span=
> get_cipher_name_pair(const char *cipher_name)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    const cipher_name_pair *pa=
ir;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t i =3D 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>   =
  /* Search for a cipher name translation */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    for (; i &lt; cipher_name_translation_table_coun=
t; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (siz=
e_t i =3D 0; i &lt; cipher_name_translation_table_count; i++)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pair=
 =3D &amp;cipher_name_translation_table[i];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const cipher_name_pair *pair =3D &amp;ciphe=
r_name_translation_table[i];</span><br><span>         if (0 =3D=3D strcmp(c=
ipher_name, pair-&gt;openvpn_name)</span><br><span>             || 0 =3D=3D=
 strcmp(cipher_name, pair-&gt;lib_name))</span><br><span>         {</span><=
br><span>diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epo=
ch=2Ec</span><br><span>index 158c841=2E=2E69a1852 100644</span><br><span>--=
- a/src/openvpn/crypto_epoch=2Ec</span><br><span>+++ b/src/openvpn/crypto_e=
poch=2Ec</span><br><span>@@ -387,9 +387,6 @@</span><br><span>     else if (=
epoch &gt; opt-&gt;key_ctx_bi=2Edecrypt=2Eepoch</span><br><span>           =
   &amp;&amp; epoch &lt;=3D opt-&gt;key_ctx_bi=2Edecrypt=2Eepoch + opt-&gt;=
epoch_data_keys_future_count)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* Key in the range of future keys =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int index =
=3D epoch - (opt-&gt;key_ctx_bi=2Edecrypt=2Eepoch + 1);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /* If we have r=
eached the edge of the valid keys we do not return</span><br><span>        =
  * the key anymore since regenerating the new keys would move us</span><br=
><span>          * over the window of valid keys and would need all kind of=
</span><br><span>@@ -400,6 +397,9 @@</span><br><span>         }</span><br><=
span>         else</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            /* Key in the range of future keys */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const i=
nt index =3D epoch - (opt-&gt;key_ctx_bi=2Edecrypt=2Eepoch + 1);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             =
return &amp;opt-&gt;epoch_data_keys_future[index];</span><br><span>        =
 }</span><br><span>     }</span><br><span>diff --git a/src/openvpn/dco_free=
bsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br><span>index 7346903=2E=2E31=
48f10 100644</span><br><span>--- a/src/openvpn/dco_freebsd=2Ec</span><br><s=
pan>+++ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@@ -444,7 +444,6 @@</=
span><br><span> key_to_nvlist(const uint8_t *key, const uint8_t *implicit_i=
v, const char *ciphername)</span><br><span> {</span><br><span>     nvlist_t=
 *nvl;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t key_=
len;</span><br><span> </span><br><span>     nvl =3D nvlist_create(0);</span=
><br><span> </span><br><span>@@ -452,7 +451,7 @@</span><br><span> </span><b=
r><span>     if (strcmp(ciphername, &quot;none&quot;) !=3D 0)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        key_=
len =3D cipher_kt_key_size(ciphername);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        const size_t key_len =3D cipher_kt_key_size(cip=
hername);</span><br><span> </span><br><span>         nvlist_add_binary(nvl,=
 &quot;key&quot;, key, key_len);</span><br><span>         nvlist_add_binary=
(nvl, &quot;iv&quot;, implicit_iv, 8);</span><br><span>diff --git a/src/ope=
nvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec</span><br><span>index 5cdcfcf=2E=2E19e=
9e2d 100644</span><br><span>--- a/src/openvpn/dhcp=2Ec</span><br><span>+++ =
b/src/openvpn/dhcp=2Ec</span><br><span>@@ -271,7 +271,6 @@</span><br><span>=
 {</span><br><span>     char tmp_buf[256];</span><br><span>     size_t len =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t labe=
l_length_pos;</span><br><span> </span><br><span>     for (int i =3D 0; i &l=
t; array_len; i++)</span><br><span>     {</span><br><span>@@ -290,7 +289,7 =
@@</span><br><span> </span><br><span>         /* label_length_pos points to=
 the byte to be replaced by the length</span><br><span>          * of the f=
ollowing domain label */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        label_length_pos =3D len++;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        size_t label_length_pos =3D len++;</span><br><sp=
an> </span><br><span>         while (true)</span><br><span>         {</span=
><br><span>diff --git a/src/openvpn/env_set=2Ec b/src/openvpn/env_set=2Ec</=
span><br><span>index d992097=2E=2E67a5bf5 100644</span><br><span>--- a/src/=
openvpn/env_set=2Ec</span><br><span>+++ b/src/openvpn/env_set=2Ec</span><br=
><span>@@ -62,14 +62,13 @@</span><br><span> static bool</span><br><span> en=
v_string_equal(const char *s1, const char *s2)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int c1, c2;</span><br><span=
>     ASSERT(s1);</span><br><span>     ASSERT(s2);</span><br><span> </span>=
<br><span>     while (true)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        c1 =3D *s1++;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        c2 =3D *s2++;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        int c1 =3D *s1++;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        int c2 =3D *s2++;</span><br><s=
pan>         if (c1 =3D=3D &#39;=3D&#39;)</span><br><span>         {</span>=
<br><span>             c1 =3D 0;</span><br><span>@@ -214,12 +213,11 @@</spa=
n><br><span>     if (check_debug_level(msglevel))</span><br><span>     {</s=
pan><br><span>         const struct env_item *e;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        int i;</span><br><span> </span><br><span=
>         if (es)</span><br><span>         {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            int i =3D 0;</span><br><span>         =
    e =3D es-&gt;list;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            i =3D 0;</span><br><span> </span><br><span>             while =
(e)</span><br><span>             {</span><br><span>diff --git a/src/openvpn=
/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 204b0b7=2E=2E4=
1388d4 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span=
>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -2039,13 +2039,13 @@</spa=
n><br><span>     unsigned int socket =3D 0;</span><br><span>     unsigned i=
nt tuntap =3D 0;</span><br><span>     static uintptr_t tun_shift =3D TUN_SH=
IFT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static uintpt=
r_t err_shift =3D ERR_SHIFT;</span><br><span> </span><br><span>     /*</spa=
n><br><span>      * Calculate the flags based on the provided &#39;flags&#3=
9; argument=2E</span><br><span>      */</span><br><span>     if ((c-&gt;opt=
ions=2Emode !=3D MODE_SERVER) &amp;&amp; (flags &amp; IOW_WAIT_SIGNAL))</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        static uintptr_t err_shift =3D ERR_SHIFT;</span><br><span>         =
wait_signal(es, (void *)err_shift);</span><br><span>     }</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/httpdigest=2Ec b/src/openvpn/htt=
pdigest=2Ec</span><br><span>index ab8a710=2E=2E52df383 100644</span><br><sp=
an>--- a/src/openvpn/httpdigest=2Ec</span><br><span>+++ b/src/openvpn/httpd=
igest=2Ec</span><br><span>@@ -34,12 +34,9 @@</span><br><span> static void</=
span><br><span> CvtHex(IN HASH Bin, OUT HASHHEX Hex)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned short i;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned char j;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; HASHLEN; i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (unsigned short i =
=3D 0; i &lt; HASHLEN; i++)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        j =3D (Bin[i] &gt;&gt; 4) &amp; 0xf;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned char=
 j =3D (Bin[i] &gt;&gt; 4) &amp; 0xf;</span><br><span>         if (j &lt;=
=3D 9)</span><br><span>         {</span><br><span>             Hex[i * 2] =
=3D (j + &#39;0&#39;);</span><br><span>diff --git a/src/openvpn/manage=2Ec =
b/src/openvpn/manage=2Ec</span><br><span>index 2f1ca95=2E=2E1e74f09 100644<=
/span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/open=
vpn/manage=2Ec</span><br><span>@@ -368,7 +368,6 @@</span><br><span>     {</=
span><br><span>         struct gc_arena gc =3D gc_new();</span><br><span>  =
       struct log_entry e;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        const char *out =3D NULL;</span><br><span>         unsigned in=
t action_flags =3D 0;</span><br><span> </span><br><span>         ++recursiv=
e_level;</span><br><span>@@ -391,6 +390,8 @@</span><br><span> </span><br><s=
pan>         if (!man_password_needed(man))</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            const char *=
out =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>             if (flags =3D=3D M_CLIENT)</span><br><span>        =
     {</span><br><span>                 out =3D log_entry_print(&amp;e, LOG=
_PRINT_CRLF, &amp;gc);</span><br><span>@@ -3036,14 +3037,15 @@</span><br><s=
pan> static void</span><br><span> man_output_peer_info_env(struct managemen=
t *man, const struct man_def_auth_context *mdac)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    char line[256];</span><br=
><span>     if (man-&gt;persist=2Ecallback=2Eget_peer_info)</span><br><span=
>     {</span><br><span>         const char *peer_info =3D</span><br><span>=
             (*man-&gt;persist=2Ecallback=2Eget_peer_info)(man-&gt;persist=
=2Ecallback=2Earg, mdac-&gt;cid);</span><br><span>         if (peer_info)</=
span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            char line[256];</span><br><span>             struct buffe=
r buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>             buf_set_read(&amp;buf, (const uint8_t *)peer_info, strlen(=
peer_info));</span><br><span>             while (buf_parse(&amp;buf, &#39;\=
n&#39;, line, sizeof(line)))</span><br><span>             {</span><br><span=
>@@ -3820,13 +3822,12 @@</span><br><span> {</span><br><span>     int ok;</s=
pan><br><span>     char *result =3D NULL;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const struct buffer *buf;</span><br><span> </span><=
br><span>     ok =3D management_query_multiline(man, b64_data, prompt, cmd,=
 state, input);</span><br><span>     if (ok &amp;&amp; buffer_list_defined(=
*input))</span><br><span>     {</span><br><span>         buffer_list_aggreg=
ate_separator(*input, 10000, &quot;\n&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        buf =3D buffer_list_peek(*input);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const struct buffer *=
buf =3D buffer_list_peek(*input);</span><br><span>         if (buf &amp;&am=
p; BLEN(buf) &gt; 0)</span><br><span>         {</span><br><span>           =
  result =3D (char *)malloc(BLENZ(buf) + 1);</span><br><span>@@ -3847,15 +3=
848,13 @@</span><br><span> management_query_multiline_flatten(struct manage=
ment *man, const char *b64_data, const char *prompt,</span><br><span>      =
                              const char *cmd, int *state, struct buffer_li=
st **input)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int ok;</span><br><span>     char *result =3D NULL;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const struct buffer *buf;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ok=
 =3D management_query_multiline(man, b64_data, prompt, cmd, state, input);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int ok =3D=
 management_query_multiline(man, b64_data, prompt, cmd, state, input);</spa=
n><br><span>     if (ok &amp;&amp; buffer_list_defined(*input))</span><br><=
span>     {</span><br><span>         buffer_list_aggregate(*input, 2048);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf =3D buffer_=
list_peek(*input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       const struct buffer *buf =3D buffer_list_peek(*input);</span><br><sp=
an>         if (buf &amp;&amp; BLEN(buf) &gt; 0)</span><br><span>         {=
</span><br><span>             result =3D (char *)malloc(BLENZ(buf) + 1);</s=
pan><br><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</spa=
n><br><span>index 54af890=2E=2E6e9591f 100644</span><br><span>--- a/src/ope=
nvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@=
 -474,7 +474,7 @@</span><br><span> purge_user_pass(struct user_pass *up, co=
nst bool force)</span><br><span> {</span><br><span>     const bool nocache =
=3D up-&gt;nocache;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  static bool warn_shown =3D false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     if (nocache || force)</span><br><span=
>     {</span><br><span>         secure_memzero(up, sizeof(*up));</span><br=
><span>@@ -482,6 +482,8 @@</span><br><span>     }</span><br><span>     else=
</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        static bool warn_shown =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>         protect_user_pass(up);<=
/span><br><span>         /*</span><br><span>          * don&#39;t show warn=
ing if the pass has been replaced by a token: this is an</span><br><span>@@=
 -721,11 +723,10 @@</span><br><span> bool</span><br><span> validate_peer_in=
fo_line(char *line)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    uint8_t c;</span><br><span>     int state =3D 0;</span=
><br><span>     while (*line)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        c =3D *line;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const uint8_t c =3D *line;</span>=
<br><span>         switch (state)</span><br><span>         {</span><br><spa=
n>             case 0:</span><br><span>diff --git a/src/openvpn/multi=2Ec b=
/src/openvpn/multi=2Ec</span><br><span>index b6c428c=2E=2E658424f 100644</s=
pan><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn=
/multi=2Ec</span><br><span>@@ -4200,13 +4200,11 @@</span><br><span> static =
void</span><br><span> tunnel_server_loop(struct multi_context *multi)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an>     while (true)</span><br><span>     {</span><br><span>         /* wai=
t on tun/socket list */</span><br><span>         multi_get_timeout(multi, &=
amp;multi-&gt;top=2Ec2=2Etimeval);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        status =3D multi_io_wait(multi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const int status =3D multi_io_wai=
t(multi);</span><br><span>         MULTI_CHECK_SIG(multi);</span><br><span>=
 </span><br><span>         /* check on status of coarse timers */</span><br=
><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networki=
ng_sitnl=2Ec</span><br><span>index bb29781=2E=2E49de664 100644</span><br><s=
pan>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvp=
n/networking_sitnl=2Ec</span><br><span>@@ -1375,13 +1375,11 @@</span><br><s=
pan> sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtatt=
r *rta, size_t len,</span><br><span>                          unsigned shor=
t flags)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    unsigned short type;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span>     memset(tb, 0, sizeof(struct rtattr *) * (max=
 + 1));</span><br><span> </span><br><span>     while (RTA_OK(rta, len))</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      type =3D rta-&gt;rta_type &amp; ~flags;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        const unsigned short type =3D rta-&gt;rta=
_type &amp; ~flags;</span><br><span> </span><br><span>         if ((type &l=
t;=3D max) &amp;&amp; (!tb[type]))</span><br><span>         {</span><br><sp=
an>@@ -1409,7 +1407,6 @@</span><br><span> static int</span><br><span> sitnl=
_type_save(struct nlmsghdr *n, void *arg)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    char *type =3D arg;</span><br><s=
pan>     struct ifinfomsg *ifi =3D NLMSG_DATA(n);</span><br><span>     stru=
ct rtattr *tb[IFLA_MAX + 1];</span><br><span> </span><br><span>@@ -1418,6 +=
1415,7 @@</span><br><span>     if (tb[IFLA_LINKINFO])</span><br><span>     =
{</span><br><span>         struct rtattr *tb_link[IFLA_INFO_MAX + 1];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *type =3D ar=
g;</span><br><span> </span><br><span>         sitnl_parse_rtattr_nested(tb_=
link, IFLA_INFO_MAX, tb[IFLA_LINKINFO]);</span><br><span> </span><br><span>=
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><s=
pan>index 5a57c0a=2E=2E1f4b191 100644</span><br><span>--- a/src/openvpn/opt=
ions=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -=
1019,10 +1019,9 @@</span><br><span> </span><br><span>     for (current =3D =
*list, prev =3D NULL; current !=3D NULL; current =3D current-&gt;next)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     char *tmp_value =3D NULL;</span><br><span>         if (!strncmp(curren=
t-&gt;string, &quot;foreign_option_&quot;, sizeof(&quot;foreign_option_&quo=
t;) - 1))</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            tmp_value =3D strchr(current-&gt;string, &#39;=
=3D&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   const char *tmp_value =3D strchr(current-&gt;string, &#39;=3D&#39;);</sp=
an><br><span>             if (tmp_value &amp;&amp; ++tmp_value)</span><br><=
span>             {</span><br><span>                 if (!strncmp(tmp_value=
, &quot;dhcp-option &quot;, sizeof(&quot;dhcp-option &quot;) - 1))</span><b=
r><span>diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_pa=
rse=2Ec</span><br><span>index 0e94522=2E=2E79b8098 100644</span><br><span>-=
-- a/src/openvpn/options_parse=2Ec</span><br><span>+++ b/src/openvpn/option=
s_parse=2Ec</span><br><span>@@ -351,7 +351,6 @@</span><br><span> {</span><b=
r><span>     const int max_recursive_levels =3D 10;</span><br><span>     FI=
LE *fp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int line_n=
um;</span><br><span>     char line[OPTION_LINE_SIZE + 1];</span><br><span> =
    char *p[MAX_PARMS + 1];</span><br><span> </span><br><span>@@ -368,7 +36=
7,7 @@</span><br><span>         }</span><br><span>         if (fp)</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         line_num =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            int line_num =3D 0;</span><br><span>             while (fg=
ets(line, sizeof(line), fp))</span><br><span>             {</span><br><span=
>                 int offset =3D 0;</span><br><span>diff --git a/src/openvp=
n/packet_id=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>index 22c53c7=
=2E=2E50d7c76 100644</span><br><span>--- a/src/openvpn/packet_id=2Ec</span>=
<br><span>+++ b/src/openvpn/packet_id=2Ec</span><br><span>@@ -219,8 +219,6 =
@@</span><br><span> bool</span><br><span> packet_id_test(struct packet_id_r=
ec *p, const struct packet_id_net *pin)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    uint64_t diff;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     packet_id_debug(D_P=
ID_DEBUG, p, pin, &quot;PID_TEST&quot;, 0);</span><br><span> </span><br><sp=
an>     ASSERT(p-&gt;initialized);</span><br><span>@@ -247,7 +245,7 @@</spa=
n><br><span>             }</span><br><span> </span><br><span>             /=
* check packet-id sliding window for original/replay status */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            diff =3D p-&gt;id - pi=
n-&gt;id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  const uint64_t diff =3D p-&gt;id - pin-&gt;id;</span><br><span> </span><b=
r><span>             /* keep track of maximum backtrack seen for debugging =
purposes */</span><br><span>             if (diff &gt; p-&gt;max_backtrack_=
stat)</span><br><span>@@ -512,7 +510,6 @@</span><br><span>     {</span><br>=
<span>         struct packet_id_persist_file_image image;</span><br><span> =
        CLEAR(image);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        ssize_t n;</span><br><span>         off_t seek_ret;</span><br><span=
>         struct gc_arena gc =3D gc_new();</span><br><span> </span><br><spa=
n>@@ -521,7 +518,7 @@</span><br><span>         seek_ret =3D lseek(p-&gt;fd,=
 (off_t)0, SEEK_SET);</span><br><span>         if (seek_ret =3D=3D (off_t)0=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            n =3D write(p-&gt;fd, &amp;image, sizeof(image));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            const ssize_t =
n =3D write(p-&gt;fd, &amp;image, sizeof(image));</span><br><span>         =
    if (n =3D=3D sizeof(image))</span><br><span>             {</span><br><s=
pan>                 p-&gt;time_last_written =3D p-&gt;time;</span><br><spa=
n>@@ -599,7 +596,6 @@</span><br><span>     {</span><br><span>         char =
c;</span><br><span>         time_t v;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        int diff;</span><br><span> </span><br><span>       =
  v =3D CIRC_LIST_ITEM(sl, i);</span><br><span>         if (v =3D=3D SEQ_UN=
SEEN)</span><br><span>@@ -612,7 +608,7 @@</span><br><span>         }</span>=
<br><span>         else</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            diff =3D (int)(prev_now - v);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            const int di=
ff =3D (int)(prev_now - v);</span><br><span>             if (diff &lt; 0)</=
span><br><span>             {</span><br><span>                 c =3D &#39;N=
&#39;;</span><br><span>diff --git a/src/openvpn/platform=2Ec b/src/openvpn/=
platform=2Ec</span><br><span>index ccdd43d=2E=2E9412eeb 100644</span><br><s=
pan>--- a/src/openvpn/platform=2Ec</span><br><span>+++ b/src/openvpn/platfo=
rm=2Ec</span><br><span>@@ -539,8 +539,6 @@</span><br><span> const char *</s=
pan><br><span> platform_create_temp_file(const char *directory, const char =
*prefix, struct gc_arena *gc)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int fd;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const char *retfname =3D NULL;</span><br><span>     un=
signed int attempts =3D 0;</span><br><span>     char fname[256] =3D { 0 };<=
/span><br><span>     const char *fname_fmt =3D PACKAGE &quot;_%=2E*s_%08&qu=
ot; PRIx64 &quot;%08&quot; PRIx64 &quot;=2Etmp&quot;;</span><br><span>@@ -5=
57,7 +555,7 @@</span><br><span>             return NULL;</span><br><span>  =
       }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        retfname =3D platform_gen_path(directory, fname, gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        const char *retfname=
 =3D platform_gen_path(directory, fname, gc);</span><br><span>         if (=
!retfname)</span><br><span>         {</span><br><span>             msg(M_WA=
RN, &quot;Failed to create temporary filename and path&quot;);</span><br><s=
pan>@@ -566,7 +564,7 @@</span><br><span> </span><br><span>         /* Atomi=
cally create the file=2E  Errors out if the file already</span><br><span>  =
        * exists=2E  */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        fd =3D platform_open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRU=
SR | S_IWUSR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   const int fd =3D platform_open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_=
IRUSR | S_IWUSR);</span><br><span>         if (fd !=3D -1)</span><br><span>=
         {</span><br><span>             close(fd);</span><br><span>diff --g=
it a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><span>index 80de=
c6c=2E=2E63fc930 100644</span><br><span>--- a/src/openvpn/pool=2Ec</span><b=
r><span>+++ b/src/openvpn/pool=2Ec</span><br><span>@@ -494,22 +494,21 @@</s=
pan><br><span>         for (i =3D 0; i &lt; pool-&gt;size; ++i)</span><br><=
span>         {</span><br><span>             const struct ifconfig_pool_ent=
ry *e =3D &amp;pool-&gt;list[i];</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            struct in6_addr ip6;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            in_addr_t ip;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            const char *ip6_str =3D &quot;&quot;;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const cha=
r *ip_str =3D &quot;&quot;;</span><br><span> </span><br><span>             =
if (e-&gt;common_name)</span><br><span>             {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                const char *ip6_str =3D &=
quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         const char *ip_str =3D &quot;&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>                 if (pool-&gt;ip=
v4=2Eenabled)</span><br><span>                 {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    ip =3D ifconfig_pool_handle_=
to_ip_base(pool, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    const in_addr_t ip =3D ifconfig_pool_handle_to_ip_base=
(pool, i);</span><br><span>                     ip_str =3D print_in_addr_t(=
ip, 0, &amp;gc);</span><br><span>                 }</span><br><span> </span=
><br><span>                 if (pool-&gt;ipv6=2Eenabled)</span><br><span>  =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               ip6 =3D ifconfig_pool_handle_to_ipv6_base(pool, i);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    const st=
ruct in6_addr ip6 =3D ifconfig_pool_handle_to_ipv6_base(pool, i);</span><br=
><span>                     ip6_str =3D print_in6_addr(ip6, 0, &amp;gc);</s=
pan><br><span>                 }</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/proto=2Ec b/src/openvpn/proto=2Ec</span><br><span>index 78=
5c021=2E=2E2cdb147 100644</span><br><span>--- a/src/openvpn/proto=2Ec</span=
><br><span>+++ b/src/openvpn/proto=2Ec</span><br><span>@@ -39,7 +39,6 @@</s=
pan><br><span> is_ipv_X(int tunnel_type, struct buffer *buf, int ip_ver)</s=
pan><br><span> {</span><br><span>     int offset;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    uint16_t proto;</span><br><span>     const =
struct openvpn_iphdr *ih;</span><br><span> </span><br><span>     verify_ali=
gn_4(buf);</span><br><span>@@ -61,7 +60,7 @@</span><br><span>         eh =
=3D (const struct openvpn_ethhdr *)BPTR(buf);</span><br><span> </span><br><=
span>         /* start by assuming this is a standard Eth fram */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        proto =3D eh-&gt;proto;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint16_t pr=
oto =3D eh-&gt;proto;</span><br><span>         offset =3D sizeof(struct ope=
nvpn_ethhdr);</span><br><span> </span><br><span>         /* if this is a 80=
2=2E1q frame, parse the header using the according</span><br><span>diff --g=
it a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index a514=
d92a=2E=2E8dfe0d5 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><=
br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -1155,7 +1155,6 @@</=
span><br><span>         while (e)</span><br><span>         {</span><br><spa=
n>             char *p[MAX_PARMS + 1];</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            bool enable =3D true;</span><br><span> </span>=
<br><span>             /* parse the push item */</span><br><span>          =
   CLEAR(p);</span><br><span>@@ -1163,6 +1162,8 @@</span><br><span>        =
         &amp;&amp; parse_line(e-&gt;option, p, SIZE(p) - 1, &quot;[PUSH_RO=
UTE_REMOVE]&quot;, 1, D_ROUTE_DEBUG,</span><br><span>                      =
         &amp;gc))</span><br><span>             {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                bool enable =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>          =
       /* is the push item a route directive? */</span><br><span>          =
       if (p[0] &amp;&amp; !strcmp(p[0], &quot;route&quot;) &amp;&amp; !p[3=
] &amp;&amp; o-&gt;iroutes)</span><br><span>                 {</span><br><s=
pan>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><s=
pan>index b8bac7a=2E=2E4830a5b 100644</span><br><span>--- a/src/openvpn/rou=
te=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -2773=
,7 +2773,6 @@</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>     bool ret =3D false;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    DWORD status;</span><br><span>     con=
st DWORD if_index =3D windows_route_find_if_index(r, tt);</span><br><span> =
</span><br><span>     if (if_index !=3D TUN_ADAPTER_INDEX_INVALID)</span><b=
r><span>@@ -2787,8 +2786,7 @@</span><br><span>         fr=2EdwForwardNextHo=
p =3D htonl(r-&gt;gateway);</span><br><span>         fr=2EdwForwardIfIndex =
=3D if_index;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        status =3D DeleteIpForwardEntry(&amp;fr);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        const DWORD status =3D DeleteIpForwardEntry(&amp=
;fr);</span><br><span>         if (status =3D=3D NO_ERROR)</span><br><span>=
         {</span><br><span>             ret =3D true;</span><br><span>@@ -3=
826,12 +3824,11 @@</span><br><span> bool</span><br><span> netmask_to_netbit=
s(const in_addr_t network, const in_addr_t netmask, int *netbits)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</=
span><br><span>     const int addrlen =3D sizeof(in_addr_t) * 8;</span><br>=
<span> </span><br><span>     if ((network &amp; netmask) =3D=3D network)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       for (i =3D 0; i &lt;=3D addrlen; ++i)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt;=3D addrlen; ++i)<=
/span><br><span>         {</span><br><span>             in_addr_t mask =3D =
netbits_to_netmask(i);</span><br><span>             if (mask =3D=3D netmask=
)</span><br><span>diff --git a/src/openvpn/run_command=2Ec b/src/openvpn/ru=
n_command=2Ec</span><br><span>index 905caa3=2E=2E0e36dad 100644</span><br><=
span>--- a/src/openvpn/run_command=2Ec</span><br><span>+++ b/src/openvpn/ru=
n_command=2Ec</span><br><span>@@ -176,14 +176,13 @@</span><br><span> #if de=
fined(ENABLE_FEATURE_EXECVE)</span><br><span>         if (openvpn_execve_al=
lowed(flags))</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            const char *cmd =3D a-&gt;argv[0];</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            char *const *argv =
=3D a-&gt;argv;</span><br><span>             char *const *envp =3D (char *c=
onst *)make_env_array(es, true, &amp;gc);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            pid_t pid;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            pid =3D fork();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            const pid_t pid =
=3D fork();</span><br><span>             if (pid =3D=3D (pid_t)0) /* child =
side */</span><br><span>             {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                const char *cmd =3D a-&gt;argv[0];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                char *con=
st *argv =3D a-&gt;argv;</span><br><span>                 execve(cmd, argv,=
 envp);</span><br><span>                 exit(OPENVPN_EXECVE_FAILURE);</spa=
n><br><span>             }</span><br><span>@@ -283,17 +282,17 @@</span><br>=
<span>         static bool warn_shown =3D false;</span><br><span>         i=
f (script_security() &gt;=3D SSEC_BUILT_IN)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            const char *cm=
d =3D a-&gt;argv[0];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           char *const *argv =3D a-&gt;argv;</span><br><span>             c=
har *const *envp =3D (char *const *)make_env_array(es, true, &amp;gc);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            pid_t pid;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            const char =
*cmd =3D a-&gt;argv[0];</span><br><span>             int pipe_stdout[2];</s=
pan><br><span> </span><br><span>             if (pipe(pipe_stdout) =3D=3D 0=
)</span><br><span>             {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                pid =3D fork();</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                if (pid =3D=3D (pid_t)0)       /* chil=
d side */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      const pid_t pid =3D fork();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                if (pid =3D=3D (pid_t)0) /* child side */</sp=
an><br><span>                 {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    char *const *argv =3D a-&gt;argv;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>            =
         close(pipe_stdout[0]); /* Close read end */</span><br><span>      =
               dup2(pipe_stdout[1], 1);</span><br><span>                   =
  execve(cmd, argv, envp);</span><br><span>diff --git a/src/openvpn/siphash=
_reference=2Ec b/src/openvpn/siphash_reference=2Ec</span><br><span>index 5f=
0adb9=2E=2E9240ab0 100644</span><br><span>--- a/src/openvpn/siphash_referen=
ce=2Ec</span><br><span>+++ b/src/openvpn/siphash_reference=2Ec</span><br><s=
pan>@@ -113,7 +113,6 @@</span><br><span>     uint64_t v3 =3D UINT64_C(0x746=
5646279746573);</span><br><span>     uint64_t k0 =3D U8TO64_LE(kk);</span><=
br><span>     uint64_t k1 =3D U8TO64_LE(kk + 8);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    uint64_t m;</span><br><span>     int i;</spa=
n><br><span>     const unsigned char *end =3D ni + inlen - (inlen % sizeof(=
uint64_t));</span><br><span>     const int left =3D inlen &amp; 7;</span><b=
r><span>@@ -130,7 +129,7 @@</span><br><span> </span><br><span>     for (; n=
i !=3D end; ni +=3D 8)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        m =3D U8TO64_LE(ni);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uint64_t m =3D U8TO64_LE(ni);</sp=
an><br><span>         v3 ^=3D m;</span><br><span> </span><br><span>        =
 TRACE;</span><br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/open=
vpn/ssl_mbedtls=2Ec</span><br><span>index cddf856=2E=2Eb60a8f0 100644</span=
><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/open=
vpn/ssl_mbedtls=2Ec</span><br><span>@@ -1014,12 +1014,12 @@</span><br><span=
> tls_ctx_personalise_random(struct tls_root_ctx *ctx)</span><br><span> {</=
span><br><span> #if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    static char old_sha256_hash[32] =
=3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigne=
d char sha256_hash[32] =3D { 0 };</span><br><span>     mbedtls_ctr_drbg_con=
text *cd_ctx =3D rand_ctx_get();</span><br><span> </span><br><span>     if =
(NULL !=3D ctx-&gt;crt_chain)</span><br><span>     {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        static char old_sha256_hash[32] =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        u=
nsigned char sha256_hash[32] =3D { 0 };</span><br><span>         mbedtls_x5=
09_crt *cert =3D ctx-&gt;crt_chain;</span><br><span>         const mbedtls_=
md_info_t *kt =3D md_get(&quot;SHA256&quot;);</span><br><span> </span><br><=
span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec=
</span><br><span>index cb3de65=2E=2Eafda4d9 100644</span><br><span>--- a/sr=
c/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec=
</span><br><span>@@ -1784,10 +1784,7 @@</span><br><span> {</span><br><span>=
     STACK_OF(X509_INFO) *info_stack =3D NULL;</span><br><span>     STACK_O=
F(X509_NAME) *cert_names =3D NULL;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    X509_LOOKUP *lookup =3D NULL;</span><br><span>     X509_ST=
ORE *store =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   BIO *in =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   openssl_stack_size_t added =3D 0, prev =3D 0;</span><br><span> </span><b=
r><span>     ASSERT(NULL !=3D ctx);</span><br><span> </span><br><span>@@ -1=
800,6 +1797,9 @@</span><br><span>     /* Try to add certificates and CRLs f=
rom ca_file */</span><br><span>     if (ca_file)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        openssl_stack_s=
ize_t added =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       BIO *in =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>         if (ca_file_inline)</span><br><span>        =
 {</span><br><span>             in =3D BIO_new_mem_buf((char *)ca_file, -1)=
;</span><br><span>@@ -1816,6 +1816,8 @@</span><br><span> </span><br><span> =
        if (info_stack)</span><br><span>         {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            openssl_stack_size_t prev =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
           for (openssl_stack_size_t i =3D 0; i &lt; sk_X509_INFO_num(info_=
stack); i++)</span><br><span>             {</span><br><span>               =
  X509_INFO *info =3D sk_X509_INFO_value(info_stack, i);</span><br><span>@@=
 -1916,7 +1918,7 @@</span><br><span>     /* Set a store for certs (CA &amp;=
 CRL) with a lookup on the &quot;capath&quot; hash directory */</span><br><=
span>     if (ca_path)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        lookup =3D X509_STORE_add_lookup(store, X50=
9_LOOKUP_hash_dir());</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        X509_LOOKUP *lookup =3D X509_STORE_add_lookup(store, X509_LOOKUP_=
hash_dir());</span><br><span>         if (lookup &amp;&amp; X509_LOOKUP_add=
_dir(lookup, ca_path, X509_FILETYPE_PEM))</span><br><span>         {</span>=
<br><span>             msg(M_WARN, &quot;WARNING: experimental option --cap=
ath %s&quot;, ca_path);</span><br><span>diff --git a/src/openvpn/ssl_pkt=2E=
c b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 79d2b23=2E=2Ef78782f 1006=
44</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/=
openvpn/ssl_pkt=2Ec</span><br><span>@@ -74,8 +74,6 @@</span><br><span> </sp=
an><br><span>         int e1, e2;</span><br><span>         uint8_t *b =3D B=
PTR(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint=
8_t buf1[SWAP_BUF_SIZE];</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        uint8_t buf2[SWAP_BUF_SIZE];</span><br><span> </span><br><span> =
        if (incoming)</span><br><span>         {</span><br><span>@@ -92,6 +=
90,9 @@</span><br><span> </span><br><span>         if (buf-&gt;len &gt;=3D =
e1 + e2)</span><br><span>         {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            uint8_t buf1[SWAP_BUF_SIZE];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            uint8_t buf2[SWAP_BUF_SIZE=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
             memcpy(buf1, b, e1);</span><br><span>             memcpy(buf2,=
 b + e1, e2);</span><br><span>             memcpy(b, buf2, e2);</span><br><=
span>diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_veri=
fy_mbedtls=2Ec</span><br><span>index c4bae40=2E=2Eb9a36a6 100644</span><br>=
<span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/op=
envpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -701,7 +701,6 @@</span><br>=
<span> void</span><br><span> x509_setenv(struct env_set *es, int cert_depth=
, mbedtls_x509_crt *cert)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    unsigned char c;</span><br><span>     const mbed=
tls_x509_name *name;</span><br><span>     char s[128] =3D { 0 };</span><br>=
<span> </span><br><span>@@ -729,7 +728,7 @@</span><br><span>               =
  break;</span><br><span>             }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            c =3D name-&gt;val=2Ep[i];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const un=
signed char c =3D name-&gt;val=2Ep[i];</span><br><span>             if (c &=
lt; 32 || c =3D=3D 127 || (c &gt; 128 &amp;&amp; c &lt; 160))</span><br><sp=
an>             {</span><br><span>                 s[i] =3D &#39;?&#39;;</s=
pan><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span>=
<br><span>index 85b3074=2E=2E2d375a8 100644</span><br><span>--- a/src/openv=
pn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -18=
93,7 +1893,6 @@</span><br><span>                      openvpn_net_ctx_t *ct=
x)</span><br><span> {</span><br><span>     char dynamic_name[256];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    bool dynamic_opened =3D fa=
lse;</span><br><span> </span><br><span>     /*</span><br><span>      * unli=
ke &quot;open_tun_generic()&quot;, DCO on Linux and FreeBSD follows</span><=
br><span>@@ -1905,6 +1904,8 @@</span><br><span> </span><br><span>     if (s=
trcmp(dev, &quot;tun&quot;) =3D=3D 0)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        bool dynamic_opened =3D fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>         for (int i =3D 0; i &lt; 256; ++i)</span><br><span>         {</s=
pan><br><span>             snprintf(dynamic_name, sizeof(dynamic_name), &qu=
ot;%s%d&quot;, dev, i);</span><br><span>@@ -3263,7 +3264,6 @@</span><br><sp=
an>     if (tt-&gt;reads=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><span>=
     {</span><br><span>         BOOL status;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        int err;</span><br><span> </span><br><span> =
        /* reset buf to its initial state */</span><br><span>         tt-&g=
t;reads=2Ebuf =3D tt-&gt;reads=2Ebuf_init;</span><br><span>@@ -3290,7 +3290=
,7 @@</span><br><span>         }</span><br><span>         else</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     err =3D GetLastError();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            const int err =3D GetLastError();</span><br><span>    =
         if (err =3D=3D ERROR_IO_PENDING) /* operation queued? */</span><br=
><span>             {</span><br><span>                 tt-&gt;reads=2Eiosta=
te =3D IOSTATE_QUEUED;</span><br><span>@@ -3318,7 +3318,6 @@</span><br><spa=
n>     if (tt-&gt;writes=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><span>=
     {</span><br><span>         BOOL status;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        int err;</span><br><span> </span><br><span> =
        /* make a private copy of buf */</span><br><span>         tt-&gt;wr=
ites=2Ebuf =3D tt-&gt;writes=2Ebuf_init;</span><br><span>@@ -3345,7 +3344,7=
 @@</span><br><span>         }</span><br><span>         else</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   err =3D GetLastError();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            const int err =3D GetLastError();</span><br><span>      =
       if (err =3D=3D ERROR_IO_PENDING) /* operation queued? */</span><br><=
span>             {</span><br><span>                 tt-&gt;writes=2Eiostat=
e =3D IOSTATE_QUEUED;</span><br><span>@@ -3542,8 +3541,6 @@</span><br><span=
>         char enum_name[256];</span><br><span>         char unit_string[25=
6];</span><br><span>         HKEY unit_key;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        char component_id_string[] =3D &quot;Componen=
tId&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cha=
r component_id[256];</span><br><span>         const char net_cfg_instance_i=
d_string[] =3D &quot;NetCfgInstanceId&quot;;</span><br><span>         BYTE =
net_cfg_instance_id[256];</span><br><span>         DWORD data_type;</span><=
br><span>@@ -3573,6 +3570,8 @@</span><br><span>         }</span><br><span> =
        else</span><br><span>         {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            const char component_id_string[] =3D &quot;=
ComponentId&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           char component_id[256];</span><br><span>             len =3D siz=
eof(component_id);</span><br><span>             status =3D RegQueryValueEx(=
unit_key, component_id_string, NULL, &amp;data_type,</span><br><span>      =
                                (LPBYTE)component_id, &amp;len);</span><br>=
<span>@@ -3657,7 +3656,6 @@</span><br><span>         char enum_name[256];</=
span><br><span>         char connection_string[256];</span><br><span>      =
   HKEY connection_key;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        WCHAR name_data[256];</span><br><span>         DWORD name_type;</=
span><br><span>         const WCHAR name_string[] =3D L&quot;Name&quot;;</s=
pan><br><span> </span><br><span>@@ -3689,6 +3687,7 @@</span><br><span>     =
    }</span><br><span>         else</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            WCHAR name_data[256]=
;</span><br><span>             len =3D sizeof(name_data);</span><br><span> =
            status =3D RegQueryValueExW(connection_key, name_string, NULL, =
&amp;name_type,</span><br><span>                                       (LPB=
YTE)name_data, &amp;len);</span><br><span>@@ -3813,8 +3812,6 @@</span><br><=
span>     bool warn_panel_dup =3D false;</span><br><span>     bool warn_tap=
_dup =3D false;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int links;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span>     const struct tap_reg *tr;</span><br><span>     c=
onst struct tap_reg *tr1;</span><br><span>     const struct panel_reg *pr;<=
/span><br><span>@@ -3827,7 +3824,7 @@</span><br><span>     /* loop through =
each TAP-Windows adapter registry entry */</span><br><span>     for (tr =3D=
 tap_reg; tr !=3D NULL; tr =3D tr-&gt;next)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        links =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        int links =3D 0;</spa=
n><br><span> </span><br><span>         /* loop through each network connect=
ions entry in the control panel */</span><br><span>         for (pr =3D pan=
el_reg; pr !=3D NULL; pr =3D pr-&gt;next)</span><br><span>@@ -4110,10 +4107=
,11 @@</span><br><span> {</span><br><span>     ULONG size =3D 0;</span><br>=
<span>     IP_PER_ADAPTER_INFO *pi =3D NULL;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    DWORD status;</span><br><span> </span><br><span>=
     if (index !=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>     {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD status;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>      =
   if ((status =3D GetPerAdapterInfo(index, NULL, &amp;size)) !=3D ERROR_BU=
FFER_OVERFLOW)</span><br><span>         {</span><br><span>             msg(=
M_INFO, &quot;GetPerAdapterInfo #1 failed (status=3D%lu) : %s&quot;, status=
,</span><br><span>@@ -4308,7 +4306,6 @@</span><br><span> bool</span><br><sp=
an> is_adapter_up(const struct tuntap *tt, const IP_ADAPTER_INFO *list)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t i;</span><br><span>     bool ret =3D false;</span><br><span> </span><br><=
span>     const IP_ADAPTER_INFO *ai =3D get_tun_adapter(tt, list);</span><b=
r><span>@@ -4318,7 +4315,7 @@</span><br><span>         const int n =3D get_=
adapter_n_ip_netmask(ai);</span><br><span> </span><br><span>         /* loo=
p once for every IP/netmask assigned to adapter */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; n; ++i)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &=
lt; n; ++i)</span><br><span>         {</span><br><span>             in_addr=
_t ip, netmask;</span><br><span>             if (get_adapter_ip_netmask(ai,=
 i, &amp;ip, &amp;netmask))</span><br><span>@@ -4352,7 +4349,6 @@</span><br=
><span> bool</span><br><span> is_ip_in_adapter_subnet(const IP_ADAPTER_INFO=
 *ai, const in_addr_t ip, in_addr_t *highest_netmask)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><sp=
an>     bool ret =3D false;</span><br><span> </span><br><span>     if (high=
est_netmask)</span><br><span>@@ -4363,7 +4359,7 @@</span><br><span>     if =
(ai)</span><br><span>     {</span><br><span>         const int n =3D get_ad=
apter_n_ip_netmask(ai);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        for (int i =3D 0; i &lt; n; ++i)</span><br><span=
>         {</span><br><span>             in_addr_t adapter_ip, adapter_netm=
ask;</span><br><span>             if (get_adapter_ip_netmask(ai, i, &amp;ad=
apter_ip, &amp;adapter_netmask))</span><br><span>diff --git a/src/openvpn/w=
in32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index 4c511a9=2E=2Efde6412=
 100644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/s=
rc/openvpn/win32=2Ec</span><br><span>@@ -1042,7 +1042,6 @@</span><br><span>=
 openvpn_execve(const struct argv *a, const struct env_set *es, const unsig=
ned int flags)</span><br><span> {</span><br><span>     int ret =3D OPENVPN_=
EXECVE_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stat=
ic bool exec_warn =3D false;</span><br><span> </span><br><span>     if (a &=
amp;&amp; a-&gt;argv[0])</span><br><span>     {</span><br><span>@@ -1093,6 =
+1092,8 @@</span><br><span>         }</span><br><span>         else</span><=
br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            static bool exec_warn =3D false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>             ret =3D OPENVPN_EXEC=
VE_NOT_ALLOWED;</span><br><span>             if (!exec_warn &amp;&amp; (scr=
ipt_security() &lt; SSEC_SCRIPTS))</span><br><span>             {</span><br=
><span>@@ -1489,11 +1490,10 @@</span><br><span> static void</span><br><span=
> set_openssl_env_vars(void)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    const WCHAR *ssl_fallback_dir =3D L&quot;C:\\=
Windows\\System32&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span>     WCHAR install_path[MAX_PATH] =3D { 0 };</span><br>=
<span>     if (!get_openvpn_reg_value(NULL, install_path, _countof(install_=
path)))</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const WCHAR *ssl_fallback_dir =3D L&quot;C:\\Windows\\Sy=
stem32&quot;;</span><br><span>         /* if we cannot find installation pa=
th from the registry,</span><br><span>          * use Windows directory as =
a fallback</span><br><span>          */</span><br><span>diff --git a/src/op=
envpnserv/common=2Ec b/src/openvpnserv/common=2Ec</span><br><span>index cce=
5318=2E=2E7a23d41 100644</span><br><span>--- a/src/openvpnserv/common=2Ec</=
span><br><span>+++ b/src/openvpnserv/common=2Ec</span><br><span>@@ -254,10 =
+254,8 @@</span><br><span> MsgToEventLog(DWORD flags, LPCWSTR format, =2E=
=2E=2E)</span><br><span> {</span><br><span>     HANDLE hEventSource;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    WCHAR msg[2][256];</span=
><br><span>     DWORD error =3D 0;</span><br><span>     LPCWSTR err_msg =3D=
 L&quot;&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    va=
_list arglist;</span><br><span> </span><br><span>     if (flags &amp; MSG_F=
LAGS_SYS_CODE)</span><br><span>     {</span><br><span>@@ -268,6 +266,9 @@</=
span><br><span>     hEventSource =3D RegisterEventSource(NULL, APPNAME);</s=
pan><br><span>     if (hEventSource !=3D NULL)</span><br><span>     {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        va_list arglist;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        WCHAR msg[2]=
[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>         swprintf(msg[0], _countof(msg[0]), L&quot;%ls%ls%ls: %ls&quot;=
, APPNAME, service_instance,</span><br><span>                  (flags &amp;=
 MSG_FLAGS_ERROR) ? L&quot; error&quot; : L&quot;&quot;, err_msg);</span><b=
r><span> </span><br><span>@@ -311,10 +312,10 @@</span><br><span> const wcha=
r_t *</span><br><span> get_win_sys_path(void)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const wchar_t *default_sys_p=
ath =3D L&quot;C:\\Windows\\system32&quot;;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span>     if (!GetSystemDirectoryW(win_sy=
s_path, _countof(win_sys_path)))</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const wchar_t *default_sys_path=
 =3D L&quot;C:\\Windows\\system32&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>         wcscpy_s(win_sys_path, _coun=
tof(win_sys_path), default_sys_path);</span><br><span>         win_sys_path=
[_countof(win_sys_path) - 1] =3D L&#39;\0&#39;;</span><br><span>     }</spa=
n><br><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/=
interactive=2Ec</span><br><span>index 026d5aa=2E=2Ed8cf6e1 100644</span><br=
><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/open=
vpnserv/interactive=2Ec</span><br><span>@@ -933,7 +933,6 @@</span><br><span=
> RegisterDNS(LPVOID unused)</span><br><span> {</span><br><span>     DWORD =
err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t i;</sp=
an><br><span>     DWORD timeout =3D RDNS_TIMEOUT * 1000; /* in milliseconds=
 */</span><br><span> </span><br><span>     /* path of ipconfig command */</=
span><br><span>@@ -956,7 +955,7 @@</span><br><span>     if (WaitForMultiple=
Objects(2, wait_handles, FALSE, timeout) =3D=3D WAIT_OBJECT_0)</span><br><s=
pan>     {</span><br><span>         /* Semaphore locked */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; _countof(=
cmds); ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
for (size_t i =3D 0; i &lt; _countof(cmds); ++i)</span><br><span>         {=
</span><br><span>             ExecCommand(cmds[i]=2Eargv0, cmds[i]=2Ecmdlin=
e, cmds[i]=2Etimeout);</span><br><span>         }</span><br><span>diff --gi=
t a/src/openvpnserv/service=2Ec b/src/openvpnserv/service=2Ec</span><br><sp=
an>index 04b20d7=2E=2E2913f63 100644</span><br><span>--- a/src/openvpnserv/=
service=2Ec</span><br><span>+++ b/src/openvpnserv/service=2Ec</span><br><sp=
an>@@ -21,7 +21,6 @@</span><br><span> BOOL</span><br><span> ReportStatusToS=
CMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static DWORD d=
wCheckPoint =3D 1;</span><br><span>     BOOL res =3D TRUE;</span><br><span>=
 </span><br><span>     if (status-&gt;dwCurrentState =3D=3D SERVICE_START_P=
ENDING)</span><br><span>@@ -39,6 +38,7 @@</span><br><span>     }</span><br>=
<span>     else</span><br><span>     {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        static DWORD dwCheckPoint =3D 1;</span><br><span=
>         status-&gt;dwCheckPoint =3D dwCheckPoint++;</span><br><span>     =
}</span><br><span> </span><br><span>@@ -55,7 +55,6 @@</span><br><span> stat=
ic int</span><br><span> CmdInstallServices(void)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    SC_HANDLE service;</span>=
<br><span>     SC_HANDLE svc_ctl_mgr;</span><br><span>     WCHAR path[512];=
</span><br><span>     int i, ret =3D _service_max;</span><br><span>@@ -78,7=
 +77,7 @@</span><br><span> </span><br><span>     for (i =3D 0; i &lt; _serv=
ice_max; i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        service =3D CreateService(</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        SC_HANDLE service =3D CreateService(<=
/span><br><span>             svc_ctl_mgr, openvpn_service[i]=2Ename, openvp=
n_service[i]=2Edisplay_name,</span><br><span>             SERVICE_QUERY_STA=
TUS, SERVICE_WIN32_SHARE_PROCESS, openvpn_service[i]=2Estart_type,</span><b=
r><span>             SERVICE_ERROR_NORMAL, path, NULL, NULL, openvpn_servic=
e[i]=2Edependencies, NULL, NULL);</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_provider=2Ec b/tests/unit_tests/openvpn/test_provider=2Ec=
</span><br><span>index 5619f36=2E=2Ee5562ee 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/test_provider=2Ec</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_provider=2Ec</span><br><span>@@ -378,12 +378,11 @@</span>=
<br><span> static void</span><br><span> xkey_provider_test_generic_sign_cb(=
void **state)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    EVP_PKEY *pubkey;</span><br><span>     const char *dummy =3D=
 &quot;xkey_handle&quot;; /* a dummy handle for the external key */</span><=
br><span> </span><br><span>     for (size_t i =3D 0; i &lt; _countof(pubkey=
s); i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        pubkey =3D load_pubkey(pubkeys[i]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        EVP_PKEY *pubkey =3D load_pubkey(=
pubkeys[i]);</span><br><span>         assert_non_null(pubkey);</span><br><s=
pan> </span><br><span>         EVP_PKEY *privkey =3D</span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1963?usp=
=3Demail">change 1963</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1963?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1963 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></ht=
ml>
--GX76IaWGXO8=--


--===============8861068809198316681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8861068809198316681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8861068809198316681==--

