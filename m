Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC3FCA5FDD
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 13:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l1GXBav7YxdoDSO3OWqHeAfGs4lm2JmWyho022+pvQg=; b=heLqLcAL+yr3qiXzh0Bn0Sfu5W
	hsTM41OzaiNJcxXhruH1arI8zGAcku5rc3YmJM+lF7GS1F9lzDqWkO9+gfybhkfto1+JfjvsOCxYu
	AOiychV7GW+Ec6BU7FzM206NKRCkIM33VQjLtZzylMLonPROtoWph387XPbdv/nOZ3Co=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCzmH-0004NA-JZ;
	Sat, 03 Oct 2026 13:27:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xCzmG-0004Mc-8Y
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 13:27:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AM08kfG9W7GGoZymFHy8JJQijl2t8PGrk2Db/pvyEPk=; b=mWvY799R3eED1ANlzZSMRR+GO0
 CilIygRwNVsUmft7bPX5iPWmSPTvpNo2oUt9YhW7o2ballct9wDLTLcey2TE+upn+61Dy+DZUSJGY
 ekqIYIT3n+wSyohKxkV0wdOr2yGz219F4P9TTknNH/DZHViCY0M8XjpQ9RjbSn3SumeY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AM08kfG9W7GGoZymFHy8JJQijl2t8PGrk2Db/pvyEPk=; b=O
 uAPcNDHHo05eW95QFL560XAXNhCM6dG0FOX6GxpXFzUydtdEk3RSWnrkQ/iUO2D6C6UvNExB0WthT
 S0snuXHcwnY9G/RBwhZlc23c7AQMRI/S/8tvaZUghC/86Ut7uLRhSk0q5aeZuV1akidCvHBNx0WUx
 Ir71Xj+bW/lS7FwA=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xCzm0-0002av-8P for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 13:27:39 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a024e16179so3201025e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 03 Oct 2026 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791034046; x=1791638846; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AM08kfG9W7GGoZymFHy8JJQijl2t8PGrk2Db/pvyEPk=;
 b=YgCJAV9dLXQW2MkM5bvn21KJLPltj52lnDhMEBZwk3Duzu5nyu6Wdd6xP/qvG2z4h9
 l+D5Ce9vOJNLlg8Ykl3zHpp11ZstQ0hjquqa4F74XVY1co71kedtcYtjOPUckxcAMFiJ
 T23YtUVGPVrwDViFjGk/kzmMPkMuA21Wbt+KX3siWVswmQmWkRFvIFBRARgzFfE1hEaN
 smQoN5Tac+Lwpl4zSJrIbjnRHydhZ9qYsfJEAPm63esYkORq7rgG8qKrmRnmPShtdDon
 3L3fMCfBjgvI1g8WDZa1e78zU1k2bPrJRdU/rcPw83qKGRD4BduJJPoNQAMy0DWW1JQI
 g0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034046; x=1791638846;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AM08kfG9W7GGoZymFHy8JJQijl2t8PGrk2Db/pvyEPk=;
 b=vwouWg/6c8wlCuRIvenSbn5rF9QsjQkA/TpdEFgr8mhKlzm2w+WmnnFaBXABsRIiB+
 E435vK62bciyAHBbxyhAOAbxMlMGtWOpobfxvK08zjKNX5ssQ2ONvRY+ZiziZ4XdKefR
 ltgDYn/I/ICDHiuDmOvXfkCesCzoXy0XWSUICq1IC9NVdIzcYPSO6V8/bZuOHMbEzhsQ
 B7I8mxc+L2qpjbP+RRJXRK9fXpioSBDOi29ngfKt832fODi6QVLcpA0L/8ZvguA5FmWg
 Fm6x2XUj+7GicPW6PrC5cl9FJfJDW34O2pq1nlEWuIA/+6W1rF8crL/ozuGLS4otfVV+
 CNtA==
X-Forwarded-Encrypted: i=1;
 AKwUvByd7oILU+8gSsFKeQp9x7kH5NeQM3HGJTX5XYwVAFtkMPt6LgEjh154OpTSKHyehcLEbFrh7tAQL7zS1vpS@lists.sourceforge.net
X-Gm-Message-State: AFuF++laLjlqDRBRjzeFaSKkjxU7S256q39Bfgh5UzmUgFgLgnynVQ8I
 7IELnVzy/eJ0fdY8OGoSQgwCtd1J036Lcbbt0gOlyP70z9In8vqbq6xiXiZEf4mQhTAREvKZlan
 FEIExH5v1+/SKitQOAQeLXaJuGcBZhOyI12hbIT204KVSLJFcKzYLc2xlalfzzSuig8Du
X-Gm-Gg: AYBFou1eHf94ysOK8Y4AsGlWxmD7Wm/7Lv6k4+IeVjOy/qkWautSRujJhtyMcbtnRSa
 U1wxdTYnh12rJI1XfrbkcF1pP4NNl8drZ91vlf+m6kku/oeOXvOcwKIGgBrPjPSo+dqRcUBB3fQ
 uFq8b/C888iHsUW5oPxEA9YiOiFZWUegmkaNxtnZRa0PGHCQBdaL6DBuyIaMjh07wcaTi2y9m6x
 ca7G/CC86XDN4GAj87Wr8jgOeycT2AO44yW+kh1ywP8eWV8sWiGtFryEplgxgPxOZqRXOHh6WC3
 A2eCr7A1ILUhbSDzbm/BuTkn3RKUlXvk8gI6eAumAHrKKQGQgSgQTT5eWE1SF9KYC62qXwcG8en
 F+iNGsNLnCqyVFh4iKpWX3cHc+XFUZ4T+gvyuOpNeUgrYD3fCQ+oYzqd1/QEBo/GV7SYMrxJFo9
 rsa5qBeVkHGs12msFUuwqfFm/07FTo2zNY9/E0avrFsJkQPV3DvxJejE6BxTFpGboCjlS5ro+5W
 3KFb7Dg/6e8YWhpA1xqdr4waznNhOxi/L/P3f5gvXpxm8M4kEi/OIm3aJH8wEMAt2fS1tk7ddLD
 nuteqU+Kn0WXTkX1QcyrzEDbDtpyuc6XWrkGE9PeAQWHWdw72xYlg7NCCdJS
X-Received: by 2002:a05:600c:1552:b0:49b:d03:8d3a with SMTP id
 5b1f17b1804b1-4a02755f84bmr97585365e9.11.1791034045136; 
 Sat, 03 Oct 2026 06:27:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a16d6295f9sm10099115e9.14.2026.10.03.06.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 06:27:24 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 3 Oct 2026 13:27:23 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7
X-Gerrit-Change-Number: 1963
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1963?usp=email>
X-Gerrit-Commit: 702d298a0a594148981196bc484501864cbfa410
In-Reply-To: <gerrit.1790613679000.Ib69b6c7a5f21f8552159c94560830f182c6238b7@gerrit.openvpn.net>
References: <gerrit.1790613679000.Ib69b6c7a5f21f8552159c94560830f182c6238b7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEzNjc5MDAwLkliNjliNmM3YTVmMjFmODU1MjE1OWM5NDU2MDgzMGYxODJjNjIzOGI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <086c79fc121842c4bb28af815c54a61e0560f75e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xCzm0-0002av-8P
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4672454664767409178=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4672454664767409178==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5a9atG3aq3c="; charset=UTF-8

--5a9atG3aq3c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1963?usp=3Demail )

Change subject: Fix (almost) all occurrence=
s of cppcheck variableScope
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Fix (almost) all occurrences of cppcheck variableScope

In=
 two cases I found the code change too ugly and added
a suppression=2E In m=
ost cases the change is trivially
correct (as long as it builds)=2E

Some d=
rive-by style fixes, and marked some of the moved
variables const as approp=
riate=2E

Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7
Signed-off-b=
y: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1963
Message-Id: <20260928210659=2E12780-1-gert@greenie=2Emuc=2Ede>
URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g39579=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M d=
ev-tools/cppcheck-suppressions=2Exml
M sample/sample-plugins/keying-materia=
l-exporter-demo/keyingmaterialexporter=2Ec
M sample/sample-plugins/log/log_=
v3=2Ec
M src/openvpn/buffer=2Ec
M src/openvpn/clinat=2Ec
M src/openvpn/cons=
ole_builtin=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn/crypto_epoch=2Ec
M s=
rc/openvpn/dco_freebsd=2Ec
M src/openvpn/dhcp=2Ec
M src/openvpn/env_set=2Ec=

M src/openvpn/forward=2Ec
M src/openvpn/httpdigest=2Ec
M src/openvpn/manag=
e=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/networki=
ng_sitnl=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options_parse=2Ec
M sr=
c/openvpn/packet_id=2Ec
M src/openvpn/platform=2Ec
M src/openvpn/pool=2Ec
M=
 src/openvpn/proto=2Ec
M src/openvpn/push=2Ec
M src/openvpn/route=2Ec
M src=
/openvpn/run_command=2Ec
M src/openvpn/siphash_reference=2Ec
M src/openvpn/=
ssl_mbedtls=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M s=
rc/openvpn/ssl_verify_mbedtls=2Ec
M src/openvpn/tun=2Ec
M src/openvpn/win32=
=2Ec
M src/openvpnserv/common=2Ec
M src/openvpnserv/interactive=2Ec
M src/o=
penvpnserv/service=2Ec
M tests/unit_tests/openvpn/test_provider=2Ec
37 file=
s changed, 108 insertions(+), 134 deletions(-)




diff --git a/dev-tools/c=
ppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml
index 73=
dd41b=2E=2Ecd37c41 100644
--- a/dev-tools/cppcheck-suppressions=2Exml
+++ b=
/dev-tools/cppcheck-suppressions=2Exml
@@ -23,9 +23,6 @@
   <suppress>
    =
 <id>usleepCalled</id>
   </suppress>
-  <suppress>
-    <id>variableScope<=
/id>
-  </suppress>
   <!-- We have a lot of library includes, not all of t=
hem are really required,
        so ignore them -->
   <suppress>
@@ -206,4=
 +203,15 @@
     <id>unusedStructMember</id>
     <fileName>tests/unit_test=
s/openvpn/test_pkcs11=2Ec</fileName>
   </suppress>
+  <!-- IGN: nicer -->
=
+  <suppress>
+    <id>variableScope</id>
+    <fileName>src/openvpnserv/in=
teractive=2Ec</fileName>
+    <symbolName>cmds</symbolName>
+  </suppress>
=
+  <suppress>
+    <id>variableScope</id>
+    <fileName>src/openvpnserv/in=
teractive=2Ec</fileName>
+    <symbolName>sys_key</symbolName>
+  </suppres=
s>
 </suppressions>
diff --git a/sample/sample-plugins/keying-material-expo=
rter-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/keying-materia=
l-exporter-demo/keyingmaterialexporter=2Ec
index 25c9ff5=2E=2E204374b 10064=
4
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmateriale=
xporter=2Ec
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyin=
gmaterialexporter=2Ec
@@ -120,13 +120,14 @@
     ASN1_OBJECT *fn;
     ASN1=
_STRING *val;
     X509_NAME *x509_name;
-    X509_NAME_ENTRY *ent;
     co=
nst char *objbuf;
 
     x509_name =3D X509_get_subject_name(x509);
-    in=
t i, n =3D X509_NAME_entry_count(x509_name);
-    for (i =3D 0; i < n; ++i)=

+    int n =3D X509_NAME_entry_count(x509_name);
+    for (int i =3D 0; i =
< n; ++i)
     {
+        X509_NAME_ENTRY *ent;
+
         if (!(ent =3D X5=
09_NAME_get_entry(x509_name, i)))
         {
             continue;
diff --=
git a/sample/sample-plugins/log/log_v3=2Ec b/sample/sample-plugins/log/log_=
v3=2Ec
index 09c6735=2E=2E1c781a3 100644
--- a/sample/sample-plugins/log/lo=
g_v3=2Ec
+++ b/sample/sample-plugins/log/log_v3=2Ec
@@ -197,7 +197,6 @@
   =
  ASN1_OBJECT *fn;
     ASN1_STRING *val;
     X509_NAME *x509_name;
-    X=
509_NAME_ENTRY *ent;
     const char *objbuf;
     unsigned char *buf =3D N=
ULL;
 
@@ -205,7 +204,7 @@
     n =3D X509_NAME_entry_count(x509_name);
   =
  for (i =3D 0; i < n; ++i)
     {
-        ent =3D X509_NAME_get_entry(x50=
9_name, i);
+        X509_NAME_ENTRY *ent =3D X509_NAME_get_entry(x509_name=
, i);
         if (!ent)
         {
             continue;
diff --git a/src=
/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 21e113d=2E=2E8f558b1 100=
644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -228,13 +2=
28,13 @@
     int ret =3D false;
     if (buf_defined(buf))
     {
-       =
 va_list arglist;
         uint8_t *ptr =3D BEND(buf);
         int cap =3D=
 buf_forward_capacity(buf);
 
         if (cap > 0)
         {
            =
 int stat;
+            va_list arglist;
             va_start(arglist, for=
mat);
             stat =3D vsnprintf((char *)ptr, cap, format, arglist);
 =
            va_end(arglist);
diff --git a/src/openvpn/clinat=2Ec b/src/open=
vpn/clinat=2Ec
index 3724022=2E=2Edcef924 100644
--- a/src/openvpn/clinat=
=2Ec
+++ b/src/openvpn/clinat=2Ec
@@ -50,12 +50,11 @@
 print_client_nat_lis=
t(const struct client_nat_option_list *list, msglvl_t msglevel)
 {
     str=
uct gc_arena gc =3D gc_new();
-    int i;
 
     msg(msglevel, "*** CNAT li=
st");
     if (list)
     {
-        for (i =3D 0; i < list->n; ++i)
+     =
   for (int i =3D 0; i < list->n; ++i)
         {
             const struct=
 client_nat_entry *e =3D &list->entries[i];
             msg(msglevel, "  C=
NAT[%d] t=3D%d %s/%s/%s", i, e->type,
diff --git a/src/openvpn/console_buil=
tin=2Ec b/src/openvpn/console_builtin=2Ec
index 9c8d72a=2E=2Ecf6cc37 100644=

--- a/src/openvpn/console_builtin=2Ec
+++ b/src/openvpn/console_builtin=2E=
c
@@ -77,7 +77,6 @@
     bool is_console =3D (GetFileType(in) =3D=3D FILE_T=
YPE_CHAR);
     DWORD flags_save =3D 0;
     int status =3D 0;
-    WCHAR *=
winput;
 
     if (is_console)
     {
@@ -100,7 +99,7 @@
 
     if (is_cons=
ole)
     {
-        winput =3D malloc(capacity * sizeof(WCHAR));
+        =
WCHAR *winput =3D malloc(capacity * sizeof(WCHAR));
         if (winput =3D=
=3D NULL)
         {
             return false;
diff --git a/src/openvpn/cr=
ypto=2Ec b/src/openvpn/crypto=2Ec
index dc22af5=2E=2E243cf27 100644
--- a/s=
rc/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1774,13 +1774,10 @@
=
 static const cipher_name_pair *
 get_cipher_name_pair(const char *cipher_n=
ame)
 {
-    const cipher_name_pair *pair;
-    size_t i =3D 0;
-
     /* S=
earch for a cipher name translation */
-    for (; i < cipher_name_translat=
ion_table_count; i++)
+    for (size_t i =3D 0; i < cipher_name_translation=
_table_count; i++)
     {
-        pair =3D &cipher_name_translation_table[=
i];
+        const cipher_name_pair *pair =3D &cipher_name_translation_tabl=
e[i];
         if (0 =3D=3D strcmp(cipher_name, pair->openvpn_name)
       =
      || 0 =3D=3D strcmp(cipher_name, pair->lib_name))
         {
diff --gi=
t a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
index 158c8=
41=2E=2E69a1852 100644
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src/openvpn=
/crypto_epoch=2Ec
@@ -387,9 +387,6 @@
     else if (epoch > opt->key_ctx_bi=
=2Edecrypt=2Eepoch
              && epoch <=3D opt->key_ctx_bi=2Edecrypt=2E=
epoch + opt->epoch_data_keys_future_count)
     {
-        /* Key in the ra=
nge of future keys */
-        int index =3D epoch - (opt->key_ctx_bi=2Edec=
rypt=2Eepoch + 1);
-
         /* If we have reached the edge of the valid k=
eys we do not return
          * the key anymore since regenerating the new=
 keys would move us
          * over the window of valid keys and would nee=
d all kind of
@@ -400,6 +397,9 @@
         }
         else
         {
+    =
        /* Key in the range of future keys */
+            const int index =
=3D epoch - (opt->key_ctx_bi=2Edecrypt=2Eepoch + 1);
+
             return =
&opt->epoch_data_keys_future[index];
         }
     }
diff --git a/src/ope=
nvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index d933aaf=2E=2E87eea=
55 100644
--- a/src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=
=2Ec
@@ -444,7 +444,6 @@
 key_to_nvlist(const uint8_t *key, const uint8_t *=
implicit_iv, const char *ciphername)
 {
     nvlist_t *nvl;
-    size_t key=
_len;
 
     nvl =3D nvlist_create(0);
 
@@ -452,7 +451,7 @@
 
     if (str=
cmp(ciphername, "none") !=3D 0)
     {
-        key_len =3D cipher_kt_key_s=
ize(ciphername);
+        const size_t key_len =3D cipher_kt_key_size(ciphe=
rname);
 
         nvlist_add_binary(nvl, "key", key, key_len);
         nv=
list_add_binary(nvl, "iv", implicit_iv, 8);
diff --git a/src/openvpn/dhcp=
=2Ec b/src/openvpn/dhcp=2Ec
index 5cdcfcf=2E=2E19e9e2d 100644
--- a/src/ope=
nvpn/dhcp=2Ec
+++ b/src/openvpn/dhcp=2Ec
@@ -271,7 +271,6 @@
 {
     char t=
mp_buf[256];
     size_t len =3D 0;
-    size_t label_length_pos;
 
     fo=
r (int i =3D 0; i < array_len; i++)
     {
@@ -290,7 +289,7 @@
 
         /=
* label_length_pos points to the byte to be replaced by the length
        =
  * of the following domain label */
-        label_length_pos =3D len++;
+=
        size_t label_length_pos =3D len++;
 
         while (true)
        =
 {
diff --git a/src/openvpn/env_set=2Ec b/src/openvpn/env_set=2Ec
index d99=
2097=2E=2E67a5bf5 100644
--- a/src/openvpn/env_set=2Ec
+++ b/src/openvpn/en=
v_set=2Ec
@@ -62,14 +62,13 @@
 static bool
 env_string_equal(const char *s1=
, const char *s2)
 {
-    int c1, c2;
     ASSERT(s1);
     ASSERT(s2);
 
 =
    while (true)
     {
-        c1 =3D *s1++;
-        c2 =3D *s2++;
+    =
    int c1 =3D *s1++;
+        int c2 =3D *s2++;
         if (c1 =3D=3D '=
=3D')
         {
             c1 =3D 0;
@@ -214,12 +213,11 @@
     if (chec=
k_debug_level(msglevel))
     {
         const struct env_item *e;
-       =
 int i;
 
         if (es)
         {
+            int i =3D 0;
           =
  e =3D es->list;
-            i =3D 0;
 
             while (e)
          =
   {
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 6=
d85c62=2E=2Ee265498 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/=
forward=2Ec
@@ -2056,13 +2056,13 @@
     unsigned int socket =3D 0;
     un=
signed int tuntap =3D 0;
     static uintptr_t tun_shift =3D TUN_SHIFT;
-  =
  static uintptr_t err_shift =3D ERR_SHIFT;
 
     /*
      * Calculate the=
 flags based on the provided 'flags' argument=2E
      */
     if ((c->opti=
ons=2Emode !=3D MODE_SERVER) && (flags & IOW_WAIT_SIGNAL))
     {
+        =
static uintptr_t err_shift =3D ERR_SHIFT;
         wait_signal(es, (void *)=
err_shift);
     }
 
diff --git a/src/openvpn/httpdigest=2Ec b/src/openvpn/=
httpdigest=2Ec
index ab8a710=2E=2E52df383 100644
--- a/src/openvpn/httpdige=
st=2Ec
+++ b/src/openvpn/httpdigest=2Ec
@@ -34,12 +34,9 @@
 static void
 Cv=
tHex(IN HASH Bin, OUT HASHHEX Hex)
 {
-    unsigned short i;
-    unsigned =
char j;
-
-    for (i =3D 0; i < HASHLEN; i++)
+    for (unsigned short i =
=3D 0; i < HASHLEN; i++)
     {
-        j =3D (Bin[i] >> 4) & 0xf;
+      =
  unsigned char j =3D (Bin[i] >> 4) & 0xf;
         if (j <=3D 9)
         =
{
             Hex[i * 2] =3D (j + '0');
diff --git a/src/openvpn/manage=2E=
c b/src/openvpn/manage=2Ec
index e121b38=2E=2Eb6d93c7 100644
--- a/src/open=
vpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -368,7 +368,6 @@
     {
    =
     struct gc_arena gc =3D gc_new();
         struct log_entry e;
-       =
 const char *out =3D NULL;
         unsigned int action_flags =3D 0;
 
    =
     ++recursive_level;
@@ -391,6 +390,8 @@
 
         if (!man_password_ne=
eded(man))
         {
+            const char *out =3D NULL;
+
            =
 if (flags =3D=3D M_CLIENT)
             {
                 out =3D log_ent=
ry_print(&e, LOG_PRINT_CRLF, &gc);
@@ -3036,14 +3037,15 @@
 static void
 ma=
n_output_peer_info_env(struct management *man, const struct man_def_auth_co=
ntext *mdac)
 {
-    char line[256];
     if (man->persist=2Ecallback=2Eget=
_peer_info)
     {
         const char *peer_info =3D
             (*man->p=
ersist=2Ecallback=2Eget_peer_info)(man->persist=2Ecallback=2Earg, mdac->cid=
);
         if (peer_info)
         {
+            char line[256];
        =
     struct buffer buf;
+
             buf_set_read(&buf, (const uint8_t *)=
peer_info, strlen(peer_info));
             while (buf_parse(&buf, '\n', li=
ne, sizeof(line)))
             {
@@ -3820,13 +3822,12 @@
 {
     int ok;
 =
    char *result =3D NULL;
-    const struct buffer *buf;
 
     ok =3D man=
agement_query_multiline(man, b64_data, prompt, cmd, state, input);
     if =
(ok && buffer_list_defined(*input))
     {
         buffer_list_aggregate_s=
eparator(*input, 10000, "\n");
-        buf =3D buffer_list_peek(*input);
+=
        const struct buffer *buf =3D buffer_list_peek(*input);
         if =
(buf && BLEN(buf) > 0)
         {
             result =3D (char *)malloc(BL=
ENZ(buf) + 1);
@@ -3847,15 +3848,13 @@
 management_query_multiline_flatten(=
struct management *man, const char *b64_data, const char *prompt,
         =
                           const char *cmd, int *state, struct buffer_list =
**input)
 {
-    int ok;
     char *result =3D NULL;
-    const struct buff=
er *buf;
 
-    ok =3D management_query_multiline(man, b64_data, prompt, cm=
d, state, input);
+    const int ok =3D management_query_multiline(man, b64=
_data, prompt, cmd, state, input);
     if (ok && buffer_list_defined(*inpu=
t))
     {
         buffer_list_aggregate(*input, 2048);
-        buf =3D b=
uffer_list_peek(*input);
+        const struct buffer *buf =3D buffer_list_=
peek(*input);
         if (buf && BLEN(buf) > 0)
         {
             re=
sult =3D (char *)malloc(BLENZ(buf) + 1);
diff --git a/src/openvpn/misc=2Ec =
b/src/openvpn/misc=2Ec
index 54af890=2E=2E6e9591f 100644
--- a/src/openvpn/=
misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -474,7 +474,7 @@
 purge_user_pass(st=
ruct user_pass *up, const bool force)
 {
     const bool nocache =3D up->no=
cache;
-    static bool warn_shown =3D false;
+
     if (nocache || force)
=
     {
         secure_memzero(up, sizeof(*up));
@@ -482,6 +482,8 @@
     }=

     else
     {
+        static bool warn_shown =3D false;
+
         pro=
tect_user_pass(up);
         /*
          * don't show warning if the pass =
has been replaced by a token: this is an
@@ -721,11 +723,10 @@
 bool
 valid=
ate_peer_info_line(char *line)
 {
-    uint8_t c;
     int state =3D 0;
   =
  while (*line)
     {
-        c =3D *line;
+        const uint8_t c =3D *=
line;
         switch (state)
         {
             case 0:
diff --git a/=
src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 71dba6c=2E=2E959f7b3 10=
0644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4206,13 +4=
206,11 @@
 static void
 tunnel_server_loop(struct multi_context *multi)
 {
=
-    int status;
-
     while (true)
     {
         /* wait on tun/socket =
list */
         multi_get_timeout(multi, &multi->top=2Ec2=2Etimeval);
-   =
     status =3D multi_io_wait(multi);
+        const int status =3D multi_i=
o_wait(multi);
         MULTI_CHECK_SIG(multi);
 
         /* check on stat=
us of coarse timers */
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/=
openvpn/networking_sitnl=2Ec
index a396255=2E=2E8a0a360 100644
--- a/src/op=
envpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -1375,=
13 +1375,11 @@
 sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, s=
truct rtattr *rta, size_t len,
                          unsigned short fla=
gs)
 {
-    unsigned short type;
-
     memset(tb, 0, sizeof(struct rtattr =
*) * (max + 1));
 
     while (RTA_OK(rta, len))
     {
-        type =3D r=
ta->rta_type & ~flags;
+        const unsigned short type =3D rta->rta_type=
 & ~flags;
 
         if ((type <=3D max) && (!tb[type]))
         {
@@ -14=
09,7 +1407,6 @@
 static int
 sitnl_type_save(struct nlmsghdr *n, void *arg)=

 {
-    char *type =3D arg;
     struct ifinfomsg *ifi =3D NLMSG_DATA(n);
=
     struct rtattr *tb[IFLA_MAX + 1];
 
@@ -1418,6 +1415,7 @@
     if (tb[I=
FLA_LINKINFO])
     {
         struct rtattr *tb_link[IFLA_INFO_MAX + 1];
+=
        char *type =3D arg;
 
         sitnl_parse_rtattr_nested(tb_link, I=
FLA_INFO_MAX, tb[IFLA_LINKINFO]);
 
diff --git a/src/openvpn/options=2Ec b/=
src/openvpn/options=2Ec
index 3c5a249=2E=2Edcc4dac 100644
--- a/src/openvpn=
/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1019,10 +1019,9 @@
 
     fo=
r (current =3D *list, prev =3D NULL; current !=3D NULL; current =3D current=
->next)
     {
-        char *tmp_value =3D NULL;
         if (!strncmp(cur=
rent->string, "foreign_option_", sizeof("foreign_option_") - 1))
         {=

-            tmp_value =3D strchr(current->string, '=3D');
+            co=
nst char *tmp_value =3D strchr(current->string, '=3D');
             if (tm=
p_value && ++tmp_value)
             {
                 if (!strncmp(tmp_va=
lue, "dhcp-option ", sizeof("dhcp-option ") - 1))
diff --git a/src/openvpn/=
options_parse=2Ec b/src/openvpn/options_parse=2Ec
index 88ab4d2=2E=2E12934a=
b 100644
--- a/src/openvpn/options_parse=2Ec
+++ b/src/openvpn/options_pars=
e=2Ec
@@ -351,7 +351,6 @@
 {
     const int max_recursive_levels =3D 10;
  =
   FILE *fp;
-    int line_num;
     char line[OPTION_LINE_SIZE + 1];
     =
char *p[MAX_PARMS + 1];
 
@@ -368,7 +367,7 @@
         }
         if (fp)
 =
        {
-            line_num =3D 0;
+            int line_num =3D 0;
   =
          while (fgets(line, sizeof(line), fp))
             {
            =
     int offset =3D 0;
diff --git a/src/openvpn/packet_id=2Ec b/src/openvpn=
/packet_id=2Ec
index 22c53c7=2E=2E50d7c76 100644
--- a/src/openvpn/packet_i=
d=2Ec
+++ b/src/openvpn/packet_id=2Ec
@@ -219,8 +219,6 @@
 bool
 packet_id_=
test(struct packet_id_rec *p, const struct packet_id_net *pin)
 {
-    uint=
64_t diff;
-
     packet_id_debug(D_PID_DEBUG, p, pin, "PID_TEST", 0);
 
  =
   ASSERT(p->initialized);
@@ -247,7 +245,7 @@
             }
 
           =
  /* check packet-id sliding window for original/replay status */
-        =
    diff =3D p->id - pin->id;
+            const uint64_t diff =3D p->id - =
pin->id;
 
             /* keep track of maximum backtrack seen for debuggi=
ng purposes */
             if (diff > p->max_backtrack_stat)
@@ -512,7 +51=
0,6 @@
     {
         struct packet_id_persist_file_image image;
         =
CLEAR(image);
-        ssize_t n;
         off_t seek_ret;
         struct =
gc_arena gc =3D gc_new();
 
@@ -521,7 +518,7 @@
         seek_ret =3D lseek=
(p->fd, (off_t)0, SEEK_SET);
         if (seek_ret =3D=3D (off_t)0)
       =
  {
-            n =3D write(p->fd, &image, sizeof(image));
+            co=
nst ssize_t n =3D write(p->fd, &image, sizeof(image));
             if (n =
=3D=3D sizeof(image))
             {
                 p->time_last_written =
=3D p->time;
@@ -599,7 +596,6 @@
     {
         char c;
         time_t v;=

-        int diff;
 
         v =3D CIRC_LIST_ITEM(sl, i);
         if (v =
=3D=3D SEQ_UNSEEN)
@@ -612,7 +608,7 @@
         }
         else
         {
=
-            diff =3D (int)(prev_now - v);
+            const int diff =3D =
(int)(prev_now - v);
             if (diff < 0)
             {
            =
     c =3D 'N';
diff --git a/src/openvpn/platform=2Ec b/src/openvpn/platfor=
m=2Ec
index 6c766c2=2E=2E400c722 100644
--- a/src/openvpn/platform=2Ec
+++ =
b/src/openvpn/platform=2Ec
@@ -539,8 +539,6 @@
 const char *
 platform_crea=
te_temp_file(const char *directory, const char *prefix, struct gc_arena *gc=
)
 {
-    int fd;
-    const char *retfname =3D NULL;
     unsigned int att=
empts =3D 0;
     char fname[256] =3D { 0 };
     const char *fname_fmt =3D=
 PACKAGE "_%=2E*s_%08" PRIx64 "%08" PRIx64 "=2Etmp";
@@ -557,7 +555,7 @@
  =
           return NULL;
         }
 
-        retfname =3D platform_gen_pat=
h(directory, fname, gc);
+        const char *retfname =3D platform_gen_pat=
h(directory, fname, gc);
         if (!retfname)
         {
             ms=
g(M_WARN, "Failed to create temporary filename and path");
@@ -566,7 +564,7=
 @@
 
         /* Atomically create the file=2E  Errors out if the file alr=
eady
          * exists=2E  */
-        fd =3D platform_open(retfname, O_CR=
EAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR);
+        const int fd =3D plat=
form_open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR);
      =
   if (fd !=3D -1)
         {
             close(fd);
diff --git a/src/open=
vpn/pool=2Ec b/src/openvpn/pool=2Ec
index 80dec6c=2E=2E63fc930 100644
--- a=
/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -494,22 +494,21 @@
    =
     for (i =3D 0; i < pool->size; ++i)
         {
             const struc=
t ifconfig_pool_entry *e =3D &pool->list[i];
-            struct in6_addr i=
p6;
-            in_addr_t ip;
-            const char *ip6_str =3D "";
-  =
          const char *ip_str =3D "";
 
             if (e->common_name)
   =
          {
+                const char *ip6_str =3D "";
+                c=
onst char *ip_str =3D "";
+
                 if (pool->ipv4=2Eenabled)
    =
             {
-                    ip =3D ifconfig_pool_handle_to_ip_base(=
pool, i);
+                    const in_addr_t ip =3D ifconfig_pool_handle_=
to_ip_base(pool, i);
                     ip_str =3D print_in_addr_t(ip, 0,=
 &gc);
                 }
 
                 if (pool->ipv6=2Eenabled)
    =
             {
-                    ip6 =3D ifconfig_pool_handle_to_ipv6_ba=
se(pool, i);
+                    const struct in6_addr ip6 =3D ifconfig_po=
ol_handle_to_ipv6_base(pool, i);
                     ip6_str =3D print_in6=
_addr(ip6, 0, &gc);
                 }
 
diff --git a/src/openvpn/proto=2Ec=
 b/src/openvpn/proto=2Ec
index 785c021=2E=2E2cdb147 100644
--- a/src/openvp=
n/proto=2Ec
+++ b/src/openvpn/proto=2Ec
@@ -39,7 +39,6 @@
 is_ipv_X(int tun=
nel_type, struct buffer *buf, int ip_ver)
 {
     int offset;
-    uint16_t=
 proto;
     const struct openvpn_iphdr *ih;
 
     verify_align_4(buf);
@@=
 -61,7 +60,7 @@
         eh =3D (const struct openvpn_ethhdr *)BPTR(buf);
 =

         /* start by assuming this is a standard Eth fram */
-        prot=
o =3D eh->proto;
+        uint16_t proto =3D eh->proto;
         offset =3D=
 sizeof(struct openvpn_ethhdr);
 
         /* if this is a 802=2E1q frame, =
parse the header using the according
diff --git a/src/openvpn/push=2Ec b/sr=
c/openvpn/push=2Ec
index 761a59e=2E=2Eacc965d 100644
--- a/src/openvpn/push=
=2Ec
+++ b/src/openvpn/push=2Ec
@@ -1155,7 +1155,6 @@
         while (e)
  =
       {
             char *p[MAX_PARMS + 1];
-            bool enable =3D =
true;
 
             /* parse the push item */
             CLEAR(p);
@@ -1=
163,6 +1162,8 @@
                 && parse_line(e->option, p, SIZE(p) - 1, =
"[PUSH_ROUTE_REMOVE]", 1, D_ROUTE_DEBUG,
                               &gc=
))
             {
+                bool enable =3D true;
+
                =
 /* is the push item a route directive? */
                 if (p[0] && !st=
rcmp(p[0], "route") && !p[3] && o->iroutes)
                 {
diff --git a=
/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index e8001b3=2E=2Eb3aee37 1=
00644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -2771,7 +2=
771,6 @@
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D false;
=
-    DWORD status;
     const DWORD if_index =3D windows_route_find_if_inde=
x(r, tt);
 
     if (if_index !=3D TUN_ADAPTER_INDEX_INVALID)
@@ -2785,8 +2=
784,7 @@
         fr=2EdwForwardNextHop =3D htonl(r->gateway);
         fr=
=2EdwForwardIfIndex =3D if_index;
 
-        status =3D DeleteIpForwardEntr=
y(&fr);
-
+        const DWORD status =3D DeleteIpForwardEntry(&fr);
      =
   if (status =3D=3D NO_ERROR)
         {
             ret =3D true;
@@ -38=
24,12 +3822,11 @@
 bool
 netmask_to_netbits(const in_addr_t network, const =
in_addr_t netmask, int *netbits)
 {
-    int i;
     const int addrlen =3D =
sizeof(in_addr_t) * 8;
 
     if ((network & netmask) =3D=3D network)
     =
{
-        for (i =3D 0; i <=3D addrlen; ++i)
+        for (int i =3D 0; i =
<=3D addrlen; ++i)
         {
             in_addr_t mask =3D netbits_to_ne=
tmask(i);
             if (mask =3D=3D netmask)
diff --git a/src/openvpn/ru=
n_command=2Ec b/src/openvpn/run_command=2Ec
index 905caa3=2E=2E0e36dad 1006=
44
--- a/src/openvpn/run_command=2Ec
+++ b/src/openvpn/run_command=2Ec
@@ -=
176,14 +176,13 @@
 #if defined(ENABLE_FEATURE_EXECVE)
         if (openvpn_=
execve_allowed(flags))
         {
-            const char *cmd =3D a->argv[=
0];
-            char *const *argv =3D a->argv;
             char *const *e=
nvp =3D (char *const *)make_env_array(es, true, &gc);
-            pid_t pi=
d;
 
-            pid =3D fork();
+            const pid_t pid =3D fork();
=
             if (pid =3D=3D (pid_t)0) /* child side */
             {
+    =
            const char *cmd =3D a->argv[0];
+                char *const *a=
rgv =3D a->argv;
                 execve(cmd, argv, envp);
                =
 exit(OPENVPN_EXECVE_FAILURE);
             }
@@ -283,17 +282,17 @@
       =
  static bool warn_shown =3D false;
         if (script_security() >=3D SSE=
C_BUILT_IN)
         {
-            const char *cmd =3D a->argv[0];
-      =
      char *const *argv =3D a->argv;
             char *const *envp =3D (ch=
ar *const *)make_env_array(es, true, &gc);
-            pid_t pid;
+       =
     const char *cmd =3D a->argv[0];
             int pipe_stdout[2];
 
   =
          if (pipe(pipe_stdout) =3D=3D 0)
             {
-                p=
id =3D fork();
-                if (pid =3D=3D (pid_t)0)       /* child sid=
e */
+                const pid_t pid =3D fork();
+                if (pid =
=3D=3D (pid_t)0) /* child side */
                 {
+                    c=
har *const *argv =3D a->argv;
+
                     close(pipe_stdout[0]);=
 /* Close read end */
                     dup2(pipe_stdout[1], 1);
       =
              execve(cmd, argv, envp);
diff --git a/src/openvpn/siphash_ref=
erence=2Ec b/src/openvpn/siphash_reference=2Ec
index 5f0adb9=2E=2E9240ab0 1=
00644
--- a/src/openvpn/siphash_reference=2Ec
+++ b/src/openvpn/siphash_ref=
erence=2Ec
@@ -113,7 +113,6 @@
     uint64_t v3 =3D UINT64_C(0x746564627974=
6573);
     uint64_t k0 =3D U8TO64_LE(kk);
     uint64_t k1 =3D U8TO64_LE(k=
k + 8);
-    uint64_t m;
     int i;
     const unsigned char *end =3D ni +=
 inlen - (inlen % sizeof(uint64_t));
     const int left =3D inlen & 7;
@@ =
-130,7 +129,7 @@
 
     for (; ni !=3D end; ni +=3D 8)
     {
-        m =
=3D U8TO64_LE(ni);
+        uint64_t m =3D U8TO64_LE(ni);
         v3 ^=3D =
m;
 
         TRACE;
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn=
/ssl_mbedtls=2Ec
index c92c423=2E=2E9983742 100644
--- a/src/openvpn/ssl_mb=
edtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -1014,12 +1014,12 @@
 tls_ct=
x_personalise_random(struct tls_root_ctx *ctx)
 {
 #if MBEDTLS_VERSION_NUMB=
ER < 0x04000000
-    static char old_sha256_hash[32] =3D { 0 };
-    unsign=
ed char sha256_hash[32] =3D { 0 };
     mbedtls_ctr_drbg_context *cd_ctx =
=3D rand_ctx_get();
 
     if (NULL !=3D ctx->crt_chain)
     {
+        st=
atic char old_sha256_hash[32] =3D { 0 };
+        unsigned char sha256_hash=
[32] =3D { 0 };
         mbedtls_x509_crt *cert =3D ctx->crt_chain;
       =
  const mbedtls_md_info_t *kt =3D md_get("SHA256");
 
diff --git a/src/open=
vpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 7cfe9f4=2E=2Eb88e1d=
9 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2E=
c
@@ -1784,10 +1784,7 @@
 {
     STACK_OF(X509_INFO) *info_stack =3D NULL;
=
     STACK_OF(X509_NAME) *cert_names =3D NULL;
-    X509_LOOKUP *lookup =3D=
 NULL;
     X509_STORE *store =3D NULL;
-    BIO *in =3D NULL;
-    openssl=
_stack_size_t added =3D 0, prev =3D 0;
 
     ASSERT(NULL !=3D ctx);
 
@@ -=
1800,6 +1797,9 @@
     /* Try to add certificates and CRLs from ca_file */
=
     if (ca_file)
     {
+        openssl_stack_size_t added =3D 0;
+      =
  BIO *in =3D NULL;
+
         if (ca_file_inline)
         {
             =
in =3D BIO_new_mem_buf((char *)ca_file, -1);
@@ -1816,6 +1816,8 @@
 
      =
   if (info_stack)
         {
+            openssl_stack_size_t prev =3D 0;=

+
             for (openssl_stack_size_t i =3D 0; i < sk_X509_INFO_num(inf=
o_stack); i++)
             {
                 X509_INFO *info =3D sk_X509_=
INFO_value(info_stack, i);
@@ -1916,7 +1918,7 @@
     /* Set a store for ce=
rts (CA & CRL) with a lookup on the "capath" hash directory */
     if (ca_=
path)
     {
-        lookup =3D X509_STORE_add_lookup(store, X509_LOOKUP_h=
ash_dir());
+        X509_LOOKUP *lookup =3D X509_STORE_add_lookup(store, X=
509_LOOKUP_hash_dir());
         if (lookup && X509_LOOKUP_add_dir(lookup, =
ca_path, X509_FILETYPE_PEM))
         {
             msg(M_WARN, "WARNING: =
experimental option --capath %s", ca_path);
diff --git a/src/openvpn/ssl_pk=
t=2Ec b/src/openvpn/ssl_pkt=2Ec
index 940f089=2E=2Ee9afda4 100644
--- a/src=
/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -74,8 +74,6 @@
 
    =
     int e1, e2;
         uint8_t *b =3D BPTR(buf);
-        uint8_t buf1[S=
WAP_BUF_SIZE];
-        uint8_t buf2[SWAP_BUF_SIZE];
 
         if (incomin=
g)
         {
@@ -92,6 +90,9 @@
 
         if (buf->len >=3D e1 + e2)
     =
    {
+            uint8_t buf1[SWAP_BUF_SIZE];
+            uint8_t buf2[S=
WAP_BUF_SIZE];
+
             memcpy(buf1, b, e1);
             memcpy(buf2=
, b + e1, e2);
             memcpy(b, buf2, e2);
diff --git a/src/openvpn/s=
sl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index c4bae40=2E=
=2Eb9a36a6 100644
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/src/openvp=
n/ssl_verify_mbedtls=2Ec
@@ -701,7 +701,6 @@
 void
 x509_setenv(struct env_=
set *es, int cert_depth, mbedtls_x509_crt *cert)
 {
-    unsigned char c;
 =
    const mbedtls_x509_name *name;
     char s[128] =3D { 0 };
 
@@ -729,7 =
+728,7 @@
                 break;
             }
 
-            c =3D name-=
>val=2Ep[i];
+            const unsigned char c =3D name->val=2Ep[i];
     =
        if (c < 32 || c =3D=3D 127 || (c > 128 && c < 160))
             {
=
                 s[i] =3D '?';
diff --git a/src/openvpn/tun=2Ec b/src/openv=
pn/tun=2Ec
index af48921=2E=2E4b92ff7 100644
--- a/src/openvpn/tun=2Ec
+++ =
b/src/openvpn/tun=2Ec
@@ -1891,7 +1891,6 @@
                      openvpn_n=
et_ctx_t *ctx)
 {
     char dynamic_name[256];
-    bool dynamic_opened =3D=
 false;
 
     /*
      * unlike "open_tun_generic()", DCO on Linux and Fre=
eBSD follows
@@ -1903,6 +1902,8 @@
 
     if (strcmp(dev, "tun") =3D=3D 0)
=
     {
+        bool dynamic_opened =3D false;
+
         for (int i =3D 0;=
 i < 256; ++i)
         {
             snprintf(dynamic_name, sizeof(dynami=
c_name), "%s%d", dev, i);
@@ -3261,7 +3262,6 @@
     if (tt->reads=2Eiostat=
e =3D=3D IOSTATE_INITIAL)
     {
         BOOL status;
-        int err;
 
=
         /* reset buf to its initial state */
         tt->reads=2Ebuf =3D =
tt->reads=2Ebuf_init;
@@ -3288,7 +3288,7 @@
         }
         else
      =
   {
-            err =3D GetLastError();
+            const int err =3D Ge=
tLastError();
             if (err =3D=3D ERROR_IO_PENDING) /* operation qu=
eued? */
             {
                 tt->reads=2Eiostate =3D IOSTATE_QU=
EUED;
@@ -3316,7 +3316,6 @@
     if (tt->writes=2Eiostate =3D=3D IOSTATE_IN=
ITIAL)
     {
         BOOL status;
-        int err;
 
         /* make a =
private copy of buf */
         tt->writes=2Ebuf =3D tt->writes=2Ebuf_init;=

@@ -3343,7 +3342,7 @@
         }
         else
         {
-            err=
 =3D GetLastError();
+            const int err =3D GetLastError();
       =
      if (err =3D=3D ERROR_IO_PENDING) /* operation queued? */
            =
 {
                 tt->writes=2Eiostate =3D IOSTATE_QUEUED;
@@ -3540,8 +35=
39,6 @@
         char enum_name[256];
         char unit_string[256];
     =
    HKEY unit_key;
-        char component_id_string[] =3D "ComponentId";
-=
        char component_id[256];
         const char net_cfg_instance_id_str=
ing[] =3D "NetCfgInstanceId";
         BYTE net_cfg_instance_id[256];
     =
    DWORD data_type;
@@ -3571,6 +3568,8 @@
         }
         else
       =
  {
+            const char component_id_string[] =3D "ComponentId";
+     =
       char component_id[256];
             len =3D sizeof(component_id);
 =
            status =3D RegQueryValueEx(unit_key, component_id_string, NULL,=
 &data_type,
                                      (LPBYTE)component_id, &l=
en);
@@ -3655,7 +3654,6 @@
         char enum_name[256];
         char conn=
ection_string[256];
         HKEY connection_key;
-        WCHAR name_data[=
256];
         DWORD name_type;
         const WCHAR name_string[] =3D L"Na=
me";
 
@@ -3687,6 +3685,7 @@
         }
         else
         {
+         =
   WCHAR name_data[256];
             len =3D sizeof(name_data);
          =
   status =3D RegQueryValueExW(connection_key, name_string, NULL, &name_typ=
e,
                                       (LPBYTE)name_data, &len);
@@ -381=
1,8 +3810,6 @@
     bool warn_panel_dup =3D false;
     bool warn_tap_dup =
=3D false;
 
-    int links;
-
     const struct tap_reg *tr;
     const st=
ruct tap_reg *tr1;
     const struct panel_reg *pr;
@@ -3825,7 +3822,7 @@
 =
    /* loop through each TAP-Windows adapter registry entry */
     for (tr=
 =3D tap_reg; tr !=3D NULL; tr =3D tr->next)
     {
-        links =3D 0;
+=
        int links =3D 0;
 
         /* loop through each network connection=
s entry in the control panel */
         for (pr =3D panel_reg; pr !=3D NUL=
L; pr =3D pr->next)
@@ -4108,10 +4105,11 @@
 {
     ULONG size =3D 0;
     =
IP_PER_ADAPTER_INFO *pi =3D NULL;
-    DWORD status;
 
     if (index !=3D =
TUN_ADAPTER_INDEX_INVALID)
     {
+        DWORD status;
+
         if ((st=
atus =3D GetPerAdapterInfo(index, NULL, &size)) !=3D ERROR_BUFFER_OVERFLOW)=

         {
             msg(M_INFO, "GetPerAdapterInfo #1 failed (status=
=3D%lu) : %s", status,
@@ -4306,7 +4304,6 @@
 bool
 is_adapter_up(const str=
uct tuntap *tt, const IP_ADAPTER_INFO *list)
 {
-    int i;
     bool ret =
=3D false;
 
     const IP_ADAPTER_INFO *ai =3D get_tun_adapter(tt, list);
=
@@ -4316,7 +4313,7 @@
         const int n =3D get_adapter_n_ip_netmask(ai)=
;
 
         /* loop once for every IP/netmask assigned to adapter */
-    =
    for (i =3D 0; i < n; ++i)
+        for (int i =3D 0; i < n; ++i)
      =
   {
             in_addr_t ip, netmask;
             if (get_adapter_ip_ne=
tmask(ai, i, &ip, &netmask))
@@ -4350,7 +4347,6 @@
 bool
 is_ip_in_adapter_=
subnet(const IP_ADAPTER_INFO *ai, const in_addr_t ip, in_addr_t *highest_ne=
tmask)
 {
-    int i;
     bool ret =3D false;
 
     if (highest_netmask)
=
@@ -4361,7 +4357,7 @@
     if (ai)
     {
         const int n =3D get_adap=
ter_n_ip_netmask(ai);
-        for (i =3D 0; i < n; ++i)
+        for (int =
i =3D 0; i < n; ++i)
         {
             in_addr_t adapter_ip, adapter_=
netmask;
             if (get_adapter_ip_netmask(ai, i, &adapter_ip, &adapt=
er_netmask))
diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
ind=
ex 618772d=2E=2E82341f8 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvp=
n/win32=2Ec
@@ -1041,7 +1041,6 @@
 openvpn_execve(const struct argv *a, con=
st struct env_set *es, const unsigned int flags)
 {
     int ret =3D OPENVP=
N_EXECVE_ERROR;
-    static bool exec_warn =3D false;
 
     if (a && a->ar=
gv[0])
     {
@@ -1092,6 +1091,8 @@
         }
         else
         {
+  =
          static bool exec_warn =3D false;
+
             ret =3D OPENVPN_E=
XECVE_NOT_ALLOWED;
             if (!exec_warn && (script_security() < SSEC=
_SCRIPTS))
             {
@@ -1508,11 +1509,10 @@
 static void
 set_openssl=
_env_vars(void)
 {
-    const WCHAR *ssl_fallback_dir =3D L"C:\\Windows\\Sy=
stem32";
-
     WCHAR install_path[MAX_PATH] =3D { 0 };
     if (!get_openv=
pn_reg_value(NULL, install_path, _countof(install_path)))
     {
+        c=
onst WCHAR *ssl_fallback_dir =3D L"C:\\Windows\\System32";
         /* if w=
e cannot find installation path from the registry,
          * use Windows =
directory as a fallback
          */
diff --git a/src/openvpnserv/common=2E=
c b/src/openvpnserv/common=2Ec
index cce5318=2E=2E7a23d41 100644
--- a/src/=
openvpnserv/common=2Ec
+++ b/src/openvpnserv/common=2Ec
@@ -254,10 +254,8 @=
@
 MsgToEventLog(DWORD flags, LPCWSTR format, =2E=2E=2E)
 {
     HANDLE hEv=
entSource;
-    WCHAR msg[2][256];
     DWORD error =3D 0;
     LPCWSTR err=
_msg =3D L"";
-    va_list arglist;
 
     if (flags & MSG_FLAGS_SYS_CODE)
=
     {
@@ -268,6 +266,9 @@
     hEventSource =3D RegisterEventSource(NULL, =
APPNAME);
     if (hEventSource !=3D NULL)
     {
+        va_list arglist;=

+        WCHAR msg[2][256];
+
         swprintf(msg[0], _countof(msg[0]), =
L"%ls%ls%ls: %ls", APPNAME, service_instance,
                  (flags & MS=
G_FLAGS_ERROR) ? L" error" : L"", err_msg);
 
@@ -311,10 +312,10 @@
 const =
wchar_t *
 get_win_sys_path(void)
 {
-    const wchar_t *default_sys_path =
=3D L"C:\\Windows\\system32";
-
     if (!GetSystemDirectoryW(win_sys_path,=
 _countof(win_sys_path)))
     {
+        const wchar_t *default_sys_path =
=3D L"C:\\Windows\\system32";
+
         wcscpy_s(win_sys_path, _countof(wi=
n_sys_path), default_sys_path);
         win_sys_path[_countof(win_sys_path=
) - 1] =3D L'\0';
     }
diff --git a/src/openvpnserv/interactive=2Ec b/src=
/openvpnserv/interactive=2Ec
index 4a38aa4=2E=2E1d9a5d87 100644
--- a/src/o=
penvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -933,7 =
+933,6 @@
 RegisterDNS(LPVOID unused)
 {
     DWORD err;
-    size_t i;
   =
  DWORD timeout =3D RDNS_TIMEOUT * 1000; /* in milliseconds */
 
     /* pa=
th of ipconfig command */
@@ -956,7 +955,7 @@
     if (WaitForMultipleObjec=
ts(2, wait_handles, FALSE, timeout) =3D=3D WAIT_OBJECT_0)
     {
         /=
* Semaphore locked */
-        for (i =3D 0; i < _countof(cmds); ++i)
+    =
    for (size_t i =3D 0; i < _countof(cmds); ++i)
         {
             E=
xecCommand(cmds[i]=2Eargv0, cmds[i]=2Ecmdline, cmds[i]=2Etimeout);
        =
 }
diff --git a/src/openvpnserv/service=2Ec b/src/openvpnserv/service=2Ec
i=
ndex 04b20d7=2E=2E2913f63 100644
--- a/src/openvpnserv/service=2Ec
+++ b/sr=
c/openvpnserv/service=2Ec
@@ -21,7 +21,6 @@
 BOOL
 ReportStatusToSCMgr(SERV=
ICE_STATUS_HANDLE service, SERVICE_STATUS *status)
 {
-    static DWORD dwC=
heckPoint =3D 1;
     BOOL res =3D TRUE;
 
     if (status->dwCurrentState =
=3D=3D SERVICE_START_PENDING)
@@ -39,6 +38,7 @@
     }
     else
     {
+  =
      static DWORD dwCheckPoint =3D 1;
         status->dwCheckPoint =3D dw=
CheckPoint++;
     }
 
@@ -55,7 +55,6 @@
 static int
 CmdInstallServices(vo=
id)
 {
-    SC_HANDLE service;
     SC_HANDLE svc_ctl_mgr;
     WCHAR path[=
512];
     int i, ret =3D _service_max;
@@ -78,7 +77,7 @@
 
     for (i =3D=
 0; i < _service_max; i++)
     {
-        service =3D CreateService(
+    =
    SC_HANDLE service =3D CreateService(
             svc_ctl_mgr, openvpn_=
service[i]=2Ename, openvpn_service[i]=2Edisplay_name,
             SERVICE_=
QUERY_STATUS, SERVICE_WIN32_SHARE_PROCESS, openvpn_service[i]=2Estart_type,=

             SERVICE_ERROR_NORMAL, path, NULL, NULL, openvpn_service[i]=2E=
dependencies, NULL, NULL);
diff --git a/tests/unit_tests/openvpn/test_provi=
der=2Ec b/tests/unit_tests/openvpn/test_provider=2Ec
index 5619f36=2E=2Ee55=
62ee 100644
--- a/tests/unit_tests/openvpn/test_provider=2Ec
+++ b/tests/un=
it_tests/openvpn/test_provider=2Ec
@@ -378,12 +378,11 @@
 static void
 xkey=
_provider_test_generic_sign_cb(void **state)
 {
-    EVP_PKEY *pubkey;
    =
 const char *dummy =3D "xkey_handle"; /* a dummy handle for the external ke=
y */
 
     for (size_t i =3D 0; i < _countof(pubkeys); i++)
     {
-      =
  pubkey =3D load_pubkey(pubkeys[i]);
+        EVP_PKEY *pubkey =3D load_pu=
bkey(pubkeys[i]);
         assert_non_null(pubkey);
 
         EVP_PKEY *pr=
ivkey =3D

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
63?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib69b6c7a5=
f21f8552159c94560830f182c6238b7
Gerrit-Change-Number: 1963
Gerrit-PatchSet:=
 4
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--5a9atG3aq3c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1963?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Fix (almost) all occurrences of cp=
pcheck variableScope<br><br>In two cases I found the code change too ugly a=
nd added<br>a suppression=2E In most cases the change is trivially<br>corre=
ct (as long as it builds)=2E<br><br>Some drive-by style fixes, and marked s=
ome of the moved<br>variables const as appropriate=2E<br><br>Change-Id: Ib6=
9b6c7a5f21f8552159c94560830f182c6238b7<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
963<br>Message-Id: &lt;20260928210659=2E12780-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg39579=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M dev-tools/cppcheck-suppressions=2Exml<br>M sample/sa=
mple-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec<br>M =
sample/sample-plugins/log/log_v3=2Ec<br>M src/openvpn/buffer=2Ec<br>M src/o=
penvpn/clinat=2Ec<br>M src/openvpn/console_builtin=2Ec<br>M src/openvpn/cry=
pto=2Ec<br>M src/openvpn/crypto_epoch=2Ec<br>M src/openvpn/dco_freebsd=2Ec<=
br>M src/openvpn/dhcp=2Ec<br>M src/openvpn/env_set=2Ec<br>M src/openvpn/for=
ward=2Ec<br>M src/openvpn/httpdigest=2Ec<br>M src/openvpn/manage=2Ec<br>M s=
rc/openvpn/misc=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/networking_=
sitnl=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options_parse=2Ec<b=
r>M src/openvpn/packet_id=2Ec<br>M src/openvpn/platform=2Ec<br>M src/openvp=
n/pool=2Ec<br>M src/openvpn/proto=2Ec<br>M src/openvpn/push=2Ec<br>M src/op=
envpn/route=2Ec<br>M src/openvpn/run_command=2Ec<br>M src/openvpn/siphash_r=
eference=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_openssl=
=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_verify_mbedtls=2Ec<b=
r>M src/openvpn/tun=2Ec<br>M src/openvpn/win32=2Ec<br>M src/openvpnserv/com=
mon=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M src/openvpnserv/service=
=2Ec<br>M tests/unit_tests/openvpn/test_provider=2Ec<br>37 files changed, 1=
08 insertions(+), 134 deletions(-)<br><br></pre>
<pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/=
cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml</span><=
br><span>index 73dd41b=2E=2Ecd37c41 100644</span><br><span>--- a/dev-tools/=
cppcheck-suppressions=2Exml</span><br><span>+++ b/dev-tools/cppcheck-suppre=
ssions=2Exml</span><br><span>@@ -23,9 +23,6 @@</span><br><span>   &lt;suppr=
ess&gt;</span><br><span>     &lt;id&gt;usleepCalled&lt;/id&gt;</span><br><s=
pan>   &lt;/suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  &lt;suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &lt;id&gt;variableScope&lt;/id&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  &lt;/suppress&gt;</span><br><span>   &lt;!-- We have a l=
ot of library includes, not all of them are really required,</span><br><spa=
n>        so ignore them --&gt;</span><br><span>   &lt;suppress&gt;</span><=
br><span>@@ -206,4 +203,15 @@</span><br><span>     &lt;id&gt;unusedStructMe=
mber&lt;/id&gt;</span><br><span>     &lt;fileName&gt;tests/unit_tests/openv=
pn/test_pkcs11=2Ec&lt;/fileName&gt;</span><br><span>   &lt;/suppress&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: nicer -=
-&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;v=
ariableScope&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &lt;fileName&gt;src/openvpnserv/interactive=2Ec&lt;/fileName&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;=
cmds&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &lt;id&gt;variableScope&lt;/id&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpnserv/interactive=2Ec&l=
t;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&lt;symbolName&gt;sys_key&lt;/symbolName&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span> &lt;/suppress=
ions&gt;</span><br><span>diff --git a/sample/sample-plugins/keying-material=
-exporter-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/keying-ma=
terial-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>index 25c9f=
f5=2E=2E204374b 100644</span><br><span>--- a/sample/sample-plugins/keying-m=
aterial-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>+++ b/samp=
le/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec<=
/span><br><span>@@ -120,13 +120,14 @@</span><br><span>     ASN1_OBJECT *fn;=
</span><br><span>     ASN1_STRING *val;</span><br><span>     X509_NAME *x50=
9_name;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    X509_NAME_=
ENTRY *ent;</span><br><span>     const char *objbuf;</span><br><span> </spa=
n><br><span>     x509_name =3D X509_get_subject_name(x509);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int i, n =3D X509_NAME_entry_coun=
t(x509_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for =
(i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int n =3D X509_NAME_entry_count(x509_name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n; ++i)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       X509_NAME_ENTRY *ent;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>         if (!(ent =3D X509_NAME_get_entry(x509_n=
ame, i)))</span><br><span>         {</span><br><span>             continue;=
</span><br><span>diff --git a/sample/sample-plugins/log/log_v3=2Ec b/sample=
/sample-plugins/log/log_v3=2Ec</span><br><span>index 09c6735=2E=2E1c781a3 1=
00644</span><br><span>--- a/sample/sample-plugins/log/log_v3=2Ec</span><br>=
<span>+++ b/sample/sample-plugins/log/log_v3=2Ec</span><br><span>@@ -197,7 =
+197,6 @@</span><br><span>     ASN1_OBJECT *fn;</span><br><span>     ASN1_S=
TRING *val;</span><br><span>     X509_NAME *x509_name;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    X509_NAME_ENTRY *ent;</span><br><span>=
     const char *objbuf;</span><br><span>     unsigned char *buf =3D NULL;<=
/span><br><span> </span><br><span>@@ -205,7 +204,7 @@</span><br><span>     =
n =3D X509_NAME_entry_count(x509_name);</span><br><span>     for (i =3D 0; =
i &lt; n; ++i)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        ent =3D X509_NAME_get_entry(x509_name, i);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        X509_NAME_ENTRY *ent=
 =3D X509_NAME_get_entry(x509_name, i);</span><br><span>         if (!ent)<=
/span><br><span>         {</span><br><span>             continue;</span><br=
><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><=
br><span>index 21e113d=2E=2E8f558b1 100644</span><br><span>--- a/src/openvp=
n/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@=
@ -228,13 +228,13 @@</span><br><span>     int ret =3D false;</span><br><spa=
n>     if (buf_defined(buf))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        va_list arglist;</span><br><span>  =
       uint8_t *ptr =3D BEND(buf);</span><br><span>         int cap =3D buf=
_forward_capacity(buf);</span><br><span> </span><br><span>         if (cap =
&gt; 0)</span><br><span>         {</span><br><span>             int stat;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            va_list a=
rglist;</span><br><span>             va_start(arglist, format);</span><br><=
span>             stat =3D vsnprintf((char *)ptr, cap, format, arglist);</s=
pan><br><span>             va_end(arglist);</span><br><span>diff --git a/sr=
c/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec</span><br><span>index 3724022=
=2E=2Edcef924 100644</span><br><span>--- a/src/openvpn/clinat=2Ec</span><br=
><span>+++ b/src/openvpn/clinat=2Ec</span><br><span>@@ -50,12 +50,11 @@</sp=
an><br><span> print_client_nat_list(const struct client_nat_option_list *li=
st, msglvl_t msglevel)</span><br><span> {</span><br><span>     struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int i;</span><br><span> </span><br><span>     msg(msglevel, &quot;*** CN=
AT list&quot;);</span><br><span>     if (list)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt=
; list-&gt;n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       for (int i =3D 0; i &lt; list-&gt;n; ++i)</span><br><span>         {=
</span><br><span>             const struct client_nat_entry *e =3D &amp;lis=
t-&gt;entries[i];</span><br><span>             msg(msglevel, &quot;  CNAT[%=
d] t=3D%d %s/%s/%s&quot;, i, e-&gt;type,</span><br><span>diff --git a/src/o=
penvpn/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec</span><br><spa=
n>index 9c8d72a=2E=2Ecf6cc37 100644</span><br><span>--- a/src/openvpn/conso=
le_builtin=2Ec</span><br><span>+++ b/src/openvpn/console_builtin=2Ec</span>=
<br><span>@@ -77,7 +77,6 @@</span><br><span>     bool is_console =3D (GetFi=
leType(in) =3D=3D FILE_TYPE_CHAR);</span><br><span>     DWORD flags_save =
=3D 0;</span><br><span>     int status =3D 0;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    WCHAR *winput;</span><br><span> </span><br><spa=
n>     if (is_console)</span><br><span>     {</span><br><span>@@ -100,7 +99=
,7 @@</span><br><span> </span><br><span>     if (is_console)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        winpu=
t =3D malloc(capacity * sizeof(WCHAR));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        WCHAR *winput =3D malloc(capacity * sizeof(WCHA=
R));</span><br><span>         if (winput =3D=3D NULL)</span><br><span>     =
    {</span><br><span>             return false;</span><br><span>diff --git=
 a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index dc=
22af5=2E=2E243cf27 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</spa=
n><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1774,13 +1774,=
10 @@</span><br><span> static const cipher_name_pair *</span><br><span> get=
_cipher_name_pair(const char *cipher_name)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const cipher_name_pair *pair;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t i =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* =
Search for a cipher name translation */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    for (; i &lt; cipher_name_translation_table_count; i+=
+)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i=
 =3D 0; i &lt; cipher_name_translation_table_count; i++)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pair =3D =
&amp;cipher_name_translation_table[i];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        const cipher_name_pair *pair =3D &amp;cipher_nam=
e_translation_table[i];</span><br><span>         if (0 =3D=3D strcmp(cipher=
_name, pair-&gt;openvpn_name)</span><br><span>             || 0 =3D=3D strc=
mp(cipher_name, pair-&gt;lib_name))</span><br><span>         {</span><br><s=
pan>diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2E=
c</span><br><span>index 158c841=2E=2E69a1852 100644</span><br><span>--- a/s=
rc/openvpn/crypto_epoch=2Ec</span><br><span>+++ b/src/openvpn/crypto_epoch=
=2Ec</span><br><span>@@ -387,9 +387,6 @@</span><br><span>     else if (epoc=
h &gt; opt-&gt;key_ctx_bi=2Edecrypt=2Eepoch</span><br><span>              &=
amp;&amp; epoch &lt;=3D opt-&gt;key_ctx_bi=2Edecrypt=2Eepoch + opt-&gt;epoc=
h_data_keys_future_count)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /* Key in the range of future keys */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        int index =3D ep=
och - (opt-&gt;key_ctx_bi=2Edecrypt=2Eepoch + 1);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span>         /* If we have reached=
 the edge of the valid keys we do not return</span><br><span>          * th=
e key anymore since regenerating the new keys would move us</span><br><span=
>          * over the window of valid keys and would need all kind of</span=
><br><span>@@ -400,6 +397,9 @@</span><br><span>         }</span><br><span> =
        else</span><br><span>         {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            /* Key in the range of future keys */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            const int ind=
ex =3D epoch - (opt-&gt;key_ctx_bi=2Edecrypt=2Eepoch + 1);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             return=
 &amp;opt-&gt;epoch_data_keys_future[index];</span><br><span>         }</sp=
an><br><span>     }</span><br><span>diff --git a/src/openvpn/dco_freebsd=2E=
c b/src/openvpn/dco_freebsd=2Ec</span><br><span>index d933aaf=2E=2E87eea55 =
100644</span><br><span>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span>++=
+ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@@ -444,7 +444,6 @@</span><=
br><span> key_to_nvlist(const uint8_t *key, const uint8_t *implicit_iv, con=
st char *ciphername)</span><br><span> {</span><br><span>     nvlist_t *nvl;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t key_len;</=
span><br><span> </span><br><span>     nvl =3D nvlist_create(0);</span><br><=
span> </span><br><span>@@ -452,7 +451,7 @@</span><br><span> </span><br><spa=
n>     if (strcmp(ciphername, &quot;none&quot;) !=3D 0)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        key_len =
=3D cipher_kt_key_size(ciphername);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        const size_t key_len =3D cipher_kt_key_size(ciphern=
ame);</span><br><span> </span><br><span>         nvlist_add_binary(nvl, &qu=
ot;key&quot;, key, key_len);</span><br><span>         nvlist_add_binary(nvl=
, &quot;iv&quot;, implicit_iv, 8);</span><br><span>diff --git a/src/openvpn=
/dhcp=2Ec b/src/openvpn/dhcp=2Ec</span><br><span>index 5cdcfcf=2E=2E19e9e2d=
 100644</span><br><span>--- a/src/openvpn/dhcp=2Ec</span><br><span>+++ b/sr=
c/openvpn/dhcp=2Ec</span><br><span>@@ -271,7 +271,6 @@</span><br><span> {</=
span><br><span>     char tmp_buf[256];</span><br><span>     size_t len =3D =
0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t label_le=
ngth_pos;</span><br><span> </span><br><span>     for (int i =3D 0; i &lt; a=
rray_len; i++)</span><br><span>     {</span><br><span>@@ -290,7 +289,7 @@</=
span><br><span> </span><br><span>         /* label_length_pos points to the=
 byte to be replaced by the length</span><br><span>          * of the follo=
wing domain label */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       label_length_pos =3D len++;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        size_t label_length_pos =3D len++;</span><br><span> =
</span><br><span>         while (true)</span><br><span>         {</span><br=
><span>diff --git a/src/openvpn/env_set=2Ec b/src/openvpn/env_set=2Ec</span=
><br><span>index d992097=2E=2E67a5bf5 100644</span><br><span>--- a/src/open=
vpn/env_set=2Ec</span><br><span>+++ b/src/openvpn/env_set=2Ec</span><br><sp=
an>@@ -62,14 +62,13 @@</span><br><span> static bool</span><br><span> env_st=
ring_equal(const char *s1, const char *s2)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int c1, c2;</span><br><span>   =
  ASSERT(s1);</span><br><span>     ASSERT(s2);</span><br><span> </span><br>=
<span>     while (true)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        c1 =3D *s1++;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        c2 =3D *s2++;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        int c1 =3D *s1++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int c2 =3D *s2++;</span><br><span=
>         if (c1 =3D=3D &#39;=3D&#39;)</span><br><span>         {</span><br=
><span>             c1 =3D 0;</span><br><span>@@ -214,12 +213,11 @@</span><=
br><span>     if (check_debug_level(msglevel))</span><br><span>     {</span=
><br><span>         const struct env_item *e;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        int i;</span><br><span> </span><br><span>  =
       if (es)</span><br><span>         {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            int i =3D 0;</span><br><span>            =
 e =3D es-&gt;list;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          i =3D 0;</span><br><span> </span><br><span>             while (e)=
</span><br><span>             {</span><br><span>diff --git a/src/openvpn/fo=
rward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 6d85c62=2E=2Ee265=
498 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>++=
+ b/src/openvpn/forward=2Ec</span><br><span>@@ -2056,13 +2056,13 @@</span><=
br><span>     unsigned int socket =3D 0;</span><br><span>     unsigned int =
tuntap =3D 0;</span><br><span>     static uintptr_t tun_shift =3D TUN_SHIFT=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static uintptr_t=
 err_shift =3D ERR_SHIFT;</span><br><span> </span><br><span>     /*</span><=
br><span>      * Calculate the flags based on the provided &#39;flags&#39; =
argument=2E</span><br><span>      */</span><br><span>     if ((c-&gt;option=
s=2Emode !=3D MODE_SERVER) &amp;&amp; (flags &amp; IOW_WAIT_SIGNAL))</span>=
<br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     static uintptr_t err_shift =3D ERR_SHIFT;</span><br><span>         wai=
t_signal(es, (void *)err_shift);</span><br><span>     }</span><br><span> </=
span><br><span>diff --git a/src/openvpn/httpdigest=2Ec b/src/openvpn/httpdi=
gest=2Ec</span><br><span>index ab8a710=2E=2E52df383 100644</span><br><span>=
--- a/src/openvpn/httpdigest=2Ec</span><br><span>+++ b/src/openvpn/httpdige=
st=2Ec</span><br><span>@@ -34,12 +34,9 @@</span><br><span> static void</spa=
n><br><span> CvtHex(IN HASH Bin, OUT HASHHEX Hex)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned short i;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned char j;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; HASHLEN; i++)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for (unsigned short i =3D 0=
; i &lt; HASHLEN; i++)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        j =3D (Bin[i] &gt;&gt; 4) &amp; 0xf;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned char j =
=3D (Bin[i] &gt;&gt; 4) &amp; 0xf;</span><br><span>         if (j &lt;=3D 9=
)</span><br><span>         {</span><br><span>             Hex[i * 2] =3D (j=
 + &#39;0&#39;);</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/=
openvpn/manage=2Ec</span><br><span>index e121b38=2E=2Eb6d93c7 100644</span>=
<br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/ma=
nage=2Ec</span><br><span>@@ -368,7 +368,6 @@</span><br><span>     {</span><=
br><span>         struct gc_arena gc =3D gc_new();</span><br><span>        =
 struct log_entry e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       const char *out =3D NULL;</span><br><span>         unsigned int acti=
on_flags =3D 0;</span><br><span> </span><br><span>         ++recursive_leve=
l;</span><br><span>@@ -391,6 +390,8 @@</span><br><span> </span><br><span>  =
       if (!man_password_needed(man))</span><br><span>         {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            const char *out =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>             if (flags =3D=3D M_CLIENT)</span><br><span>            =
 {</span><br><span>                 out =3D log_entry_print(&amp;e, LOG_PRI=
NT_CRLF, &amp;gc);</span><br><span>@@ -3036,14 +3037,15 @@</span><br><span>=
 static void</span><br><span> man_output_peer_info_env(struct management *m=
an, const struct man_def_auth_context *mdac)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    char line[256];</span><br><sp=
an>     if (man-&gt;persist=2Ecallback=2Eget_peer_info)</span><br><span>   =
  {</span><br><span>         const char *peer_info =3D</span><br><span>    =
         (*man-&gt;persist=2Ecallback=2Eget_peer_info)(man-&gt;persist=2Eca=
llback=2Earg, mdac-&gt;cid);</span><br><span>         if (peer_info)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            char line[256];</span><br><span>             struct buffer buf=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
            buf_set_read(&amp;buf, (const uint8_t *)peer_info, strlen(peer_=
info));</span><br><span>             while (buf_parse(&amp;buf, &#39;\n&#39=
;, line, sizeof(line)))</span><br><span>             {</span><br><span>@@ -=
3820,13 +3822,12 @@</span><br><span> {</span><br><span>     int ok;</span><=
br><span>     char *result =3D NULL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    const struct buffer *buf;</span><br><span> </span><br><s=
pan>     ok =3D management_query_multiline(man, b64_data, prompt, cmd, stat=
e, input);</span><br><span>     if (ok &amp;&amp; buffer_list_defined(*inpu=
t))</span><br><span>     {</span><br><span>         buffer_list_aggregate_s=
eparator(*input, 10000, &quot;\n&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        buf =3D buffer_list_peek(*input);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const struct buffer *buf =
=3D buffer_list_peek(*input);</span><br><span>         if (buf &amp;&amp; B=
LEN(buf) &gt; 0)</span><br><span>         {</span><br><span>             re=
sult =3D (char *)malloc(BLENZ(buf) + 1);</span><br><span>@@ -3847,15 +3848,=
13 @@</span><br><span> management_query_multiline_flatten(struct management=
 *man, const char *b64_data, const char *prompt,</span><br><span>          =
                          const char *cmd, int *state, struct buffer_list *=
*input)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int ok;</span><br><span>     char *result =3D NULL;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const struct buffer *buf;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ok =3D=
 management_query_multiline(man, b64_data, prompt, cmd, state, input);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int ok =3D man=
agement_query_multiline(man, b64_data, prompt, cmd, state, input);</span><b=
r><span>     if (ok &amp;&amp; buffer_list_defined(*input))</span><br><span=
>     {</span><br><span>         buffer_list_aggregate(*input, 2048);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf =3D buffer_list=
_peek(*input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   const struct buffer *buf =3D buffer_list_peek(*input);</span><br><span> =
        if (buf &amp;&amp; BLEN(buf) &gt; 0)</span><br><span>         {</sp=
an><br><span>             result =3D (char *)malloc(BLENZ(buf) + 1);</span>=
<br><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><b=
r><span>index 54af890=2E=2E6e9591f 100644</span><br><span>--- a/src/openvpn=
/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -47=
4,7 +474,7 @@</span><br><span> purge_user_pass(struct user_pass *up, const =
bool force)</span><br><span> {</span><br><span>     const bool nocache =3D =
up-&gt;nocache;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
atic bool warn_shown =3D false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     if (nocache || force)</span><br><span>   =
  {</span><br><span>         secure_memzero(up, sizeof(*up));</span><br><sp=
an>@@ -482,6 +482,8 @@</span><br><span>     }</span><br><span>     else</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        static bool warn_shown =3D false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>         protect_user_pass(up);</spa=
n><br><span>         /*</span><br><span>          * don&#39;t show warning =
if the pass has been replaced by a token: this is an</span><br><span>@@ -72=
1,11 +723,10 @@</span><br><span> bool</span><br><span> validate_peer_info_l=
ine(char *line)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    uint8_t c;</span><br><span>     int state =3D 0;</span><br=
><span>     while (*line)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        c =3D *line;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const uint8_t c =3D *line;</span><br><s=
pan>         switch (state)</span><br><span>         {</span><br><span>    =
         case 0:</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/o=
penvpn/multi=2Ec</span><br><span>index 71dba6c=2E=2E959f7b3 100644</span><b=
r><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
=2Ec</span><br><span>@@ -4206,13 +4206,11 @@</span><br><span> static void</=
span><br><span> tunnel_server_loop(struct multi_context *multi)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int status=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>   =
  while (true)</span><br><span>     {</span><br><span>         /* wait on t=
un/socket list */</span><br><span>         multi_get_timeout(multi, &amp;mu=
lti-&gt;top=2Ec2=2Etimeval);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        status =3D multi_io_wait(multi);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const int status =3D multi_io_wait(mult=
i);</span><br><span>         MULTI_CHECK_SIG(multi);</span><br><span> </spa=
n><br><span>         /* check on status of coarse timers */</span><br><span=
>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sit=
nl=2Ec</span><br><span>index a396255=2E=2E8a0a360 100644</span><br><span>--=
- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/netw=
orking_sitnl=2Ec</span><br><span>@@ -1375,13 +1375,11 @@</span><br><span> s=
itnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *rta=
, size_t len,</span><br><span>                          unsigned short flag=
s)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    unsigned short type;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span>     memset(tb, 0, sizeof(struct rtattr *) * (max + 1))=
;</span><br><span> </span><br><span>     while (RTA_OK(rta, len))</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
type =3D rta-&gt;rta_type &amp; ~flags;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        const unsigned short type =3D rta-&gt;rta_type =
&amp; ~flags;</span><br><span> </span><br><span>         if ((type &lt;=3D =
max) &amp;&amp; (!tb[type]))</span><br><span>         {</span><br><span>@@ =
-1409,7 +1407,6 @@</span><br><span> static int</span><br><span> sitnl_type_=
save(struct nlmsghdr *n, void *arg)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    char *type =3D arg;</span><br><span>  =
   struct ifinfomsg *ifi =3D NLMSG_DATA(n);</span><br><span>     struct rta=
ttr *tb[IFLA_MAX + 1];</span><br><span> </span><br><span>@@ -1418,6 +1415,7=
 @@</span><br><span>     if (tb[IFLA_LINKINFO])</span><br><span>     {</spa=
n><br><span>         struct rtattr *tb_link[IFLA_INFO_MAX + 1];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        char *type =3D arg;</sp=
an><br><span> </span><br><span>         sitnl_parse_rtattr_nested(tb_link, =
IFLA_INFO_MAX, tb[IFLA_LINKINFO]);</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>in=
dex 3c5a249=2E=2Edcc4dac 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -1019=
,10 +1019,9 @@</span><br><span> </span><br><span>     for (current =3D *lis=
t, prev =3D NULL; current !=3D NULL; current =3D current-&gt;next)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 char *tmp_value =3D NULL;</span><br><span>         if (!strncmp(current-&g=
t;string, &quot;foreign_option_&quot;, sizeof(&quot;foreign_option_&quot;) =
- 1))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            tmp_value =3D strchr(current-&gt;string, &#39;=3D&#3=
9;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            con=
st char *tmp_value =3D strchr(current-&gt;string, &#39;=3D&#39;);</span><br=
><span>             if (tmp_value &amp;&amp; ++tmp_value)</span><br><span> =
            {</span><br><span>                 if (!strncmp(tmp_value, &quo=
t;dhcp-option &quot;, sizeof(&quot;dhcp-option &quot;) - 1))</span><br><spa=
n>diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_parse=2E=
c</span><br><span>index 88ab4d2=2E=2E12934ab 100644</span><br><span>--- a/s=
rc/openvpn/options_parse=2Ec</span><br><span>+++ b/src/openvpn/options_pars=
e=2Ec</span><br><span>@@ -351,7 +351,6 @@</span><br><span> {</span><br><spa=
n>     const int max_recursive_levels =3D 10;</span><br><span>     FILE *fp=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int line_num;</s=
pan><br><span>     char line[OPTION_LINE_SIZE + 1];</span><br><span>     ch=
ar *p[MAX_PARMS + 1];</span><br><span> </span><br><span>@@ -368,7 +367,7 @@=
</span><br><span>         }</span><br><span>         if (fp)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   line_num =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           int line_num =3D 0;</span><br><span>             while (fgets(li=
ne, sizeof(line), fp))</span><br><span>             {</span><br><span>     =
            int offset =3D 0;</span><br><span>diff --git a/src/openvpn/pack=
et_id=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>index 22c53c7=2E=2E50=
d7c76 100644</span><br><span>--- a/src/openvpn/packet_id=2Ec</span><br><spa=
n>+++ b/src/openvpn/packet_id=2Ec</span><br><span>@@ -219,8 +219,6 @@</span=
><br><span> bool</span><br><span> packet_id_test(struct packet_id_rec *p, c=
onst struct packet_id_net *pin)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    uint64_t diff;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     packet_id_debug(D_PID_DEBUG=
, p, pin, &quot;PID_TEST&quot;, 0);</span><br><span> </span><br><span>     =
ASSERT(p-&gt;initialized);</span><br><span>@@ -247,7 +245,7 @@</span><br><s=
pan>             }</span><br><span> </span><br><span>             /* check =
packet-id sliding window for original/replay status */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            diff =3D p-&gt;id - pin-&gt;id=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const =
uint64_t diff =3D p-&gt;id - pin-&gt;id;</span><br><span> </span><br><span>=
             /* keep track of maximum backtrack seen for debugging purposes=
 */</span><br><span>             if (diff &gt; p-&gt;max_backtrack_stat)</s=
pan><br><span>@@ -512,7 +510,6 @@</span><br><span>     {</span><br><span>  =
       struct packet_id_persist_file_image image;</span><br><span>         =
CLEAR(image);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
ssize_t n;</span><br><span>         off_t seek_ret;</span><br><span>       =
  struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -52=
1,7 +518,7 @@</span><br><span>         seek_ret =3D lseek(p-&gt;fd, (off_t)=
0, SEEK_SET);</span><br><span>         if (seek_ret =3D=3D (off_t)0)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           n =3D write(p-&gt;fd, &amp;image, sizeof(image));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            const ssize_t n =3D wr=
ite(p-&gt;fd, &amp;image, sizeof(image));</span><br><span>             if (=
n =3D=3D sizeof(image))</span><br><span>             {</span><br><span>    =
             p-&gt;time_last_written =3D p-&gt;time;</span><br><span>@@ -59=
9,7 +596,6 @@</span><br><span>     {</span><br><span>         char c;</span=
><br><span>         time_t v;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        int diff;</span><br><span> </span><br><span>         v =3D =
CIRC_LIST_ITEM(sl, i);</span><br><span>         if (v =3D=3D SEQ_UNSEEN)</s=
pan><br><span>@@ -612,7 +608,7 @@</span><br><span>         }</span><br><spa=
n>         else</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            diff =3D (int)(prev_now - v);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            const int diff =3D (=
int)(prev_now - v);</span><br><span>             if (diff &lt; 0)</span><br=
><span>             {</span><br><span>                 c =3D &#39;N&#39;;</=
span><br><span>diff --git a/src/openvpn/platform=2Ec b/src/openvpn/platform=
=2Ec</span><br><span>index 6c766c2=2E=2E400c722 100644</span><br><span>--- =
a/src/openvpn/platform=2Ec</span><br><span>+++ b/src/openvpn/platform=2Ec</=
span><br><span>@@ -539,8 +539,6 @@</span><br><span> const char *</span><br>=
<span> platform_create_temp_file(const char *directory, const char *prefix,=
 struct gc_arena *gc)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int fd;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const char *retfname =3D NULL;</span><br><span>     unsigned i=
nt attempts =3D 0;</span><br><span>     char fname[256] =3D { 0 };</span><b=
r><span>     const char *fname_fmt =3D PACKAGE &quot;_%=2E*s_%08&quot; PRIx=
64 &quot;%08&quot; PRIx64 &quot;=2Etmp&quot;;</span><br><span>@@ -557,7 +55=
5,7 @@</span><br><span>             return NULL;</span><br><span>         }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     retfname =3D platform_gen_path(directory, fname, gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const char *retfname =3D pla=
tform_gen_path(directory, fname, gc);</span><br><span>         if (!retfnam=
e)</span><br><span>         {</span><br><span>             msg(M_WARN, &quo=
t;Failed to create temporary filename and path&quot;);</span><br><span>@@ -=
566,7 +564,7 @@</span><br><span> </span><br><span>         /* Atomically cr=
eate the file=2E  Errors out if the file already</span><br><span>          =
* exists=2E  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  fd =3D platform_open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_I=
WUSR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const=
 int fd =3D platform_open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | =
S_IWUSR);</span><br><span>         if (fd !=3D -1)</span><br><span>        =
 {</span><br><span>             close(fd);</span><br><span>diff --git a/src=
/openvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><span>index 80dec6c=2E=
=2E63fc930 100644</span><br><span>--- a/src/openvpn/pool=2Ec</span><br><spa=
n>+++ b/src/openvpn/pool=2Ec</span><br><span>@@ -494,22 +494,21 @@</span><b=
r><span>         for (i =3D 0; i &lt; pool-&gt;size; ++i)</span><br><span> =
        {</span><br><span>             const struct ifconfig_pool_entry *e =
=3D &amp;pool-&gt;list[i];</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            struct in6_addr ip6;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            in_addr_t ip;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            const char *ip6_str =3D &quot;&quot;;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            const char *ip_=
str =3D &quot;&quot;;</span><br><span> </span><br><span>             if (e-=
&gt;common_name)</span><br><span>             {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                const char *ip6_str =3D &quot;&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   const char *ip_str =3D &quot;&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>                 if (pool-&gt;ipv4=2Ee=
nabled)</span><br><span>                 {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    ip =3D ifconfig_pool_handle_to_ip_=
base(pool, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               const in_addr_t ip =3D ifconfig_pool_handle_to_ip_base(pool,=
 i);</span><br><span>                     ip_str =3D print_in_addr_t(ip, 0,=
 &amp;gc);</span><br><span>                 }</span><br><span> </span><br><=
span>                 if (pool-&gt;ipv6=2Eenabled)</span><br><span>        =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         ip6 =3D ifconfig_pool_handle_to_ipv6_base(pool, i);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    const struct i=
n6_addr ip6 =3D ifconfig_pool_handle_to_ipv6_base(pool, i);</span><br><span=
>                     ip6_str =3D print_in6_addr(ip6, 0, &amp;gc);</span><b=
r><span>                 }</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/proto=2Ec b/src/openvpn/proto=2Ec</span><br><span>index 785c021=
=2E=2E2cdb147 100644</span><br><span>--- a/src/openvpn/proto=2Ec</span><br>=
<span>+++ b/src/openvpn/proto=2Ec</span><br><span>@@ -39,7 +39,6 @@</span><=
br><span> is_ipv_X(int tunnel_type, struct buffer *buf, int ip_ver)</span><=
br><span> {</span><br><span>     int offset;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    uint16_t proto;</span><br><span>     const struc=
t openvpn_iphdr *ih;</span><br><span> </span><br><span>     verify_align_4(=
buf);</span><br><span>@@ -61,7 +60,7 @@</span><br><span>         eh =3D (co=
nst struct openvpn_ethhdr *)BPTR(buf);</span><br><span> </span><br><span>  =
       /* start by assuming this is a standard Eth fram */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        proto =3D eh-&gt;proto;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        uint16_t proto =3D=
 eh-&gt;proto;</span><br><span>         offset =3D sizeof(struct openvpn_et=
hhdr);</span><br><span> </span><br><span>         /* if this is a 802=2E1q =
frame, parse the header using the according</span><br><span>diff --git a/sr=
c/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 761a59e=2E=
=2Eacc965d 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><spa=
n>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -1155,7 +1155,6 @@</span><b=
r><span>         while (e)</span><br><span>         {</span><br><span>     =
        char *p[MAX_PARMS + 1];</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            bool enable =3D true;</span><br><span> </span><br><sp=
an>             /* parse the push item */</span><br><span>             CLEA=
R(p);</span><br><span>@@ -1163,6 +1162,8 @@</span><br><span>               =
  &amp;&amp; parse_line(e-&gt;option, p, SIZE(p) - 1, &quot;[PUSH_ROUTE_REM=
OVE]&quot;, 1, D_ROUTE_DEBUG,</span><br><span>                             =
  &amp;gc))</span><br><span>             {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                bool enable =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>                 =
/* is the push item a route directive? */</span><br><span>                 =
if (p[0] &amp;&amp; !strcmp(p[0], &quot;route&quot;) &amp;&amp; !p[3] &amp;=
&amp; o-&gt;iroutes)</span><br><span>                 {</span><br><span>dif=
f --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>ind=
ex e8001b3=2E=2Eb3aee37 100644</span><br><span>--- a/src/openvpn/route=2Ec<=
/span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -2771,7 +277=
1,6 @@</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_ne=
w();</span><br><span>     bool ret =3D false;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    DWORD status;</span><br><span>     const DWORD =
if_index =3D windows_route_find_if_index(r, tt);</span><br><span> </span><b=
r><span>     if (if_index !=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>@=
@ -2785,8 +2784,7 @@</span><br><span>         fr=2EdwForwardNextHop =3D hto=
nl(r-&gt;gateway);</span><br><span>         fr=2EdwForwardIfIndex =3D if_in=
dex;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        status =3D DeleteIpForwardEntry(&amp;fr);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        const DWORD status =3D DeleteIpForwardEntry(&amp;fr);</sp=
an><br><span>         if (status =3D=3D NO_ERROR)</span><br><span>         =
{</span><br><span>             ret =3D true;</span><br><span>@@ -3824,12 +3=
822,11 @@</span><br><span> bool</span><br><span> netmask_to_netbits(const i=
n_addr_t network, const in_addr_t netmask, int *netbits)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br>=
<span>     const int addrlen =3D sizeof(in_addr_t) * 8;</span><br><span> </=
span><br><span>     if ((network &amp; netmask) =3D=3D network)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fo=
r (i =3D 0; i &lt;=3D addrlen; ++i)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        for (int i =3D 0; i &lt;=3D addrlen; ++i)</span><br=
><span>         {</span><br><span>             in_addr_t mask =3D netbits_t=
o_netmask(i);</span><br><span>             if (mask =3D=3D netmask)</span><=
br><span>diff --git a/src/openvpn/run_command=2Ec b/src/openvpn/run_command=
=2Ec</span><br><span>index 905caa3=2E=2E0e36dad 100644</span><br><span>--- =
a/src/openvpn/run_command=2Ec</span><br><span>+++ b/src/openvpn/run_command=
=2Ec</span><br><span>@@ -176,14 +176,13 @@</span><br><span> #if defined(ENA=
BLE_FEATURE_EXECVE)</span><br><span>         if (openvpn_execve_allowed(fla=
gs))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            const char *cmd =3D a-&gt;argv[0];</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            char *const *argv =3D a-&gt;=
argv;</span><br><span>             char *const *envp =3D (char *const *)mak=
e_env_array(es, true, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            pid_t pid;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            pid =3D fork();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            const pid_t pid =3D fork()=
;</span><br><span>             if (pid =3D=3D (pid_t)0) /* child side */</s=
pan><br><span>             {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                const char *cmd =3D a-&gt;argv[0];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                char *const *argv =
=3D a-&gt;argv;</span><br><span>                 execve(cmd, argv, envp);</=
span><br><span>                 exit(OPENVPN_EXECVE_FAILURE);</span><br><sp=
an>             }</span><br><span>@@ -283,17 +282,17 @@</span><br><span>   =
      static bool warn_shown =3D false;</span><br><span>         if (script=
_security() &gt;=3D SSEC_BUILT_IN)</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            const char *cmd =3D a-&=
gt;argv[0];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  char *const *argv =3D a-&gt;argv;</span><br><span>             char *cons=
t *envp =3D (char *const *)make_env_array(es, true, &amp;gc);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            pid_t pid;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            const char *cmd =3D =
a-&gt;argv[0];</span><br><span>             int pipe_stdout[2];</span><br><=
span> </span><br><span>             if (pipe(pipe_stdout) =3D=3D 0)</span><=
br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                pid =3D fork();</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                if (pid =3D=3D (pid_t)0)       /* child side */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                con=
st pid_t pid =3D fork();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                if (pid =3D=3D (pid_t)0) /* child side */</span><br><s=
pan>                 {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    char *const *argv =3D a-&gt;argv;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>                     =
close(pipe_stdout[0]); /* Close read end */</span><br><span>               =
      dup2(pipe_stdout[1], 1);</span><br><span>                     execve(=
cmd, argv, envp);</span><br><span>diff --git a/src/openvpn/siphash_referenc=
e=2Ec b/src/openvpn/siphash_reference=2Ec</span><br><span>index 5f0adb9=2E=
=2E9240ab0 100644</span><br><span>--- a/src/openvpn/siphash_reference=2Ec</=
span><br><span>+++ b/src/openvpn/siphash_reference=2Ec</span><br><span>@@ -=
113,7 +113,6 @@</span><br><span>     uint64_t v3 =3D UINT64_C(0x74656462797=
46573);</span><br><span>     uint64_t k0 =3D U8TO64_LE(kk);</span><br><span=
>     uint64_t k1 =3D U8TO64_LE(kk + 8);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    uint64_t m;</span><br><span>     int i;</span><br><s=
pan>     const unsigned char *end =3D ni + inlen - (inlen % sizeof(uint64_t=
));</span><br><span>     const int left =3D inlen &amp; 7;</span><br><span>=
@@ -130,7 +129,7 @@</span><br><span> </span><br><span>     for (; ni !=3D e=
nd; ni +=3D 8)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        m =3D U8TO64_LE(ni);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uint64_t m =3D U8TO64_LE(ni);</span><br><s=
pan>         v3 ^=3D m;</span><br><span> </span><br><span>         TRACE;</=
span><br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_m=
bedtls=2Ec</span><br><span>index c92c423=2E=2E9983742 100644</span><br><spa=
n>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_m=
bedtls=2Ec</span><br><span>@@ -1014,12 +1014,12 @@</span><br><span> tls_ctx=
_personalise_random(struct tls_root_ctx *ctx)</span><br><span> {</span><br>=
<span> #if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    static char old_sha256_hash[32] =3D { 0 };<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned char sha2=
56_hash[32] =3D { 0 };</span><br><span>     mbedtls_ctr_drbg_context *cd_ct=
x =3D rand_ctx_get();</span><br><span> </span><br><span>     if (NULL !=3D =
ctx-&gt;crt_chain)</span><br><span>     {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        static char old_sha256_hash[32] =3D { 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned char =
sha256_hash[32] =3D { 0 };</span><br><span>         mbedtls_x509_crt *cert =
=3D ctx-&gt;crt_chain;</span><br><span>         const mbedtls_md_info_t *kt=
 =3D md_get(&quot;SHA256&quot;);</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><s=
pan>index 7cfe9f4=2E=2Eb88e1d9 100644</span><br><span>--- a/src/openvpn/ssl=
_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><s=
pan>@@ -1784,10 +1784,7 @@</span><br><span> {</span><br><span>     STACK_OF=
(X509_INFO) *info_stack =3D NULL;</span><br><span>     STACK_OF(X509_NAME) =
*cert_names =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    X509_LOOKUP *lookup =3D NULL;</span><br><span>     X509_STORE *store =
=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    BIO *in =
=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openssl_=
stack_size_t added =3D 0, prev =3D 0;</span><br><span> </span><br><span>   =
  ASSERT(NULL !=3D ctx);</span><br><span> </span><br><span>@@ -1800,6 +1797=
,9 @@</span><br><span>     /* Try to add certificates and CRLs from ca_file=
 */</span><br><span>     if (ca_file)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        openssl_stack_size_t added=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        BIO =
*in =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>         if (ca_file_inline)</span><br><span>         {</span><b=
r><span>             in =3D BIO_new_mem_buf((char *)ca_file, -1);</span><br=
><span>@@ -1816,6 +1816,8 @@</span><br><span> </span><br><span>         if =
(info_stack)</span><br><span>         {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            openssl_stack_size_t prev =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             =
for (openssl_stack_size_t i =3D 0; i &lt; sk_X509_INFO_num(info_stack); i++=
)</span><br><span>             {</span><br><span>                 X509_INFO=
 *info =3D sk_X509_INFO_value(info_stack, i);</span><br><span>@@ -1916,7 +1=
918,7 @@</span><br><span>     /* Set a store for certs (CA &amp; CRL) with =
a lookup on the &quot;capath&quot; hash directory */</span><br><span>     i=
f (ca_path)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        lookup =3D X509_STORE_add_lookup(store, X509_LOOKUP_ha=
sh_dir());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        X=
509_LOOKUP *lookup =3D X509_STORE_add_lookup(store, X509_LOOKUP_hash_dir())=
;</span><br><span>         if (lookup &amp;&amp; X509_LOOKUP_add_dir(lookup=
, ca_path, X509_FILETYPE_PEM))</span><br><span>         {</span><br><span> =
            msg(M_WARN, &quot;WARNING: experimental option --capath %s&quot=
;, ca_path);</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/ope=
nvpn/ssl_pkt=2Ec</span><br><span>index 940f089=2E=2Ee9afda4 100644</span><b=
r><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl=
_pkt=2Ec</span><br><span>@@ -74,8 +74,6 @@</span><br><span> </span><br><spa=
n>         int e1, e2;</span><br><span>         uint8_t *b =3D BPTR(buf);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint8_t buf1[SW=
AP_BUF_SIZE];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
uint8_t buf2[SWAP_BUF_SIZE];</span><br><span> </span><br><span>         if =
(incoming)</span><br><span>         {</span><br><span>@@ -92,6 +90,9 @@</sp=
an><br><span> </span><br><span>         if (buf-&gt;len &gt;=3D e1 + e2)</s=
pan><br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            uint8_t buf1[SWAP_BUF_SIZE];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            uint8_t buf2[SWAP_BUF_SIZE];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>           =
  memcpy(buf1, b, e1);</span><br><span>             memcpy(buf2, b + e1, e2=
);</span><br><span>             memcpy(b, buf2, e2);</span><br><span>diff -=
-git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=
=2Ec</span><br><span>index c4bae40=2E=2Eb9a36a6 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_=
verify_mbedtls=2Ec</span><br><span>@@ -701,7 +701,6 @@</span><br><span> voi=
d</span><br><span> x509_setenv(struct env_set *es, int cert_depth, mbedtls_=
x509_crt *cert)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    unsigned char c;</span><br><span>     const mbedtls_x509_n=
ame *name;</span><br><span>     char s[128] =3D { 0 };</span><br><span> </s=
pan><br><span>@@ -729,7 +728,7 @@</span><br><span>                 break;</=
span><br><span>             }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            c =3D name-&gt;val=2Ep[i];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            const unsigned cha=
r c =3D name-&gt;val=2Ep[i];</span><br><span>             if (c &lt; 32 || =
c =3D=3D 127 || (c &gt; 128 &amp;&amp; c &lt; 160))</span><br><span>       =
      {</span><br><span>                 s[i] =3D &#39;?&#39;;</span><br><s=
pan>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>=
index af48921=2E=2E4b92ff7 100644</span><br><span>--- a/src/openvpn/tun=2Ec=
</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -1891,7 +1891=
,6 @@</span><br><span>                      openvpn_net_ctx_t *ctx)</span><=
br><span> {</span><br><span>     char dynamic_name[256];</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    bool dynamic_opened =3D false;</span=
><br><span> </span><br><span>     /*</span><br><span>      * unlike &quot;o=
pen_tun_generic()&quot;, DCO on Linux and FreeBSD follows</span><br><span>@=
@ -1903,6 +1902,8 @@</span><br><span> </span><br><span>     if (strcmp(dev,=
 &quot;tun&quot;) =3D=3D 0)</span><br><span>     {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        bool dynamic_opened =3D false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>        =
 for (int i =3D 0; i &lt; 256; ++i)</span><br><span>         {</span><br><s=
pan>             snprintf(dynamic_name, sizeof(dynamic_name), &quot;%s%d&qu=
ot;, dev, i);</span><br><span>@@ -3261,7 +3262,6 @@</span><br><span>     if=
 (tt-&gt;reads=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><span>     {</sp=
an><br><span>         BOOL status;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        int err;</span><br><span> </span><br><span>         /*=
 reset buf to its initial state */</span><br><span>         tt-&gt;reads=2E=
buf =3D tt-&gt;reads=2Ebuf_init;</span><br><span>@@ -3288,7 +3288,7 @@</spa=
n><br><span>         }</span><br><span>         else</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            err =
=3D GetLastError();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            const int err =3D GetLastError();</span><br><span>             =
if (err =3D=3D ERROR_IO_PENDING) /* operation queued? */</span><br><span>  =
           {</span><br><span>                 tt-&gt;reads=2Eiostate =3D IO=
STATE_QUEUED;</span><br><span>@@ -3316,7 +3316,6 @@</span><br><span>     if=
 (tt-&gt;writes=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><span>     {</s=
pan><br><span>         BOOL status;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        int err;</span><br><span> </span><br><span>         /=
* make a private copy of buf */</span><br><span>         tt-&gt;writes=2Ebu=
f =3D tt-&gt;writes=2Ebuf_init;</span><br><span>@@ -3343,7 +3342,7 @@</span=
><br><span>         }</span><br><span>         else</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            err =
=3D GetLastError();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            const int err =3D GetLastError();</span><br><span>             =
if (err =3D=3D ERROR_IO_PENDING) /* operation queued? */</span><br><span>  =
           {</span><br><span>                 tt-&gt;writes=2Eiostate =3D I=
OSTATE_QUEUED;</span><br><span>@@ -3540,8 +3539,6 @@</span><br><span>      =
   char enum_name[256];</span><br><span>         char unit_string[256];</sp=
an><br><span>         HKEY unit_key;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        char component_id_string[] =3D &quot;ComponentId&quo=
t;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char compo=
nent_id[256];</span><br><span>         const char net_cfg_instance_id_strin=
g[] =3D &quot;NetCfgInstanceId&quot;;</span><br><span>         BYTE net_cfg=
_instance_id[256];</span><br><span>         DWORD data_type;</span><br><spa=
n>@@ -3571,6 +3568,8 @@</span><br><span>         }</span><br><span>        =
 else</span><br><span>         {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            const char component_id_string[] =3D &quot;Compone=
ntId&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    char component_id[256];</span><br><span>             len =3D sizeof(com=
ponent_id);</span><br><span>             status =3D RegQueryValueEx(unit_ke=
y, component_id_string, NULL, &amp;data_type,</span><br><span>             =
                         (LPBYTE)component_id, &amp;len);</span><br><span>@=
@ -3655,7 +3654,6 @@</span><br><span>         char enum_name[256];</span><b=
r><span>         char connection_string[256];</span><br><span>         HKEY=
 connection_key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   WCHAR name_data[256];</span><br><span>         DWORD name_type;</span><b=
r><span>         const WCHAR name_string[] =3D L&quot;Name&quot;;</span><br=
><span> </span><br><span>@@ -3687,6 +3685,7 @@</span><br><span>         }</=
span><br><span>         else</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            WCHAR name_data[256];</span=
><br><span>             len =3D sizeof(name_data);</span><br><span>        =
     status =3D RegQueryValueExW(connection_key, name_string, NULL, &amp;na=
me_type,</span><br><span>                                       (LPBYTE)nam=
e_data, &amp;len);</span><br><span>@@ -3811,8 +3810,6 @@</span><br><span>  =
   bool warn_panel_dup =3D false;</span><br><span>     bool warn_tap_dup =
=3D false;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int links;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span>     const struct tap_reg *tr;</span><br><span>     const =
struct tap_reg *tr1;</span><br><span>     const struct panel_reg *pr;</span=
><br><span>@@ -3825,7 +3822,7 @@</span><br><span>     /* loop through each =
TAP-Windows adapter registry entry */</span><br><span>     for (tr =3D tap_=
reg; tr !=3D NULL; tr =3D tr-&gt;next)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        links =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        int links =3D 0;</span><br=
><span> </span><br><span>         /* loop through each network connections =
entry in the control panel */</span><br><span>         for (pr =3D panel_re=
g; pr !=3D NULL; pr =3D pr-&gt;next)</span><br><span>@@ -4108,10 +4105,11 @=
@</span><br><span> {</span><br><span>     ULONG size =3D 0;</span><br><span=
>     IP_PER_ADAPTER_INFO *pi =3D NULL;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    DWORD status;</span><br><span> </span><br><span>     =
if (index !=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        DWORD status;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if=
 ((status =3D GetPerAdapterInfo(index, NULL, &amp;size)) !=3D ERROR_BUFFER_=
OVERFLOW)</span><br><span>         {</span><br><span>             msg(M_INF=
O, &quot;GetPerAdapterInfo #1 failed (status=3D%lu) : %s&quot;, status,</sp=
an><br><span>@@ -4306,7 +4304,6 @@</span><br><span> bool</span><br><span> i=
s_adapter_up(const struct tuntap *tt, const IP_ADAPTER_INFO *list)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;<=
/span><br><span>     bool ret =3D false;</span><br><span> </span><br><span>=
     const IP_ADAPTER_INFO *ai =3D get_tun_adapter(tt, list);</span><br><sp=
an>@@ -4316,7 +4313,7 @@</span><br><span>         const int n =3D get_adapt=
er_n_ip_netmask(ai);</span><br><span> </span><br><span>         /* loop onc=
e for every IP/netmask assigned to adapter */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; n; ++i)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; n=
; ++i)</span><br><span>         {</span><br><span>             in_addr_t ip=
, netmask;</span><br><span>             if (get_adapter_ip_netmask(ai, i, &=
amp;ip, &amp;netmask))</span><br><span>@@ -4350,7 +4347,6 @@</span><br><spa=
n> bool</span><br><span> is_ip_in_adapter_subnet(const IP_ADAPTER_INFO *ai,=
 const in_addr_t ip, in_addr_t *highest_netmask)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>  =
   bool ret =3D false;</span><br><span> </span><br><span>     if (highest_n=
etmask)</span><br><span>@@ -4361,7 +4357,7 @@</span><br><span>     if (ai)<=
/span><br><span>     {</span><br><span>         const int n =3D get_adapter=
_n_ip_netmask(ai);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        for (int i =3D 0; i &lt; n; ++i)</span><br><span>    =
     {</span><br><span>             in_addr_t adapter_ip, adapter_netmask;<=
/span><br><span>             if (get_adapter_ip_netmask(ai, i, &amp;adapter=
_ip, &amp;adapter_netmask))</span><br><span>diff --git a/src/openvpn/win32=
=2Ec b/src/openvpn/win32=2Ec</span><br><span>index 618772d=2E=2E82341f8 100=
644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/o=
penvpn/win32=2Ec</span><br><span>@@ -1041,7 +1041,6 @@</span><br><span> ope=
nvpn_execve(const struct argv *a, const struct env_set *es, const unsigned =
int flags)</span><br><span> {</span><br><span>     int ret =3D OPENVPN_EXEC=
VE_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static b=
ool exec_warn =3D false;</span><br><span> </span><br><span>     if (a &amp;=
&amp; a-&gt;argv[0])</span><br><span>     {</span><br><span>@@ -1092,6 +109=
1,8 @@</span><br><span>         }</span><br><span>         else</span><br><=
span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        static bool exec_warn =3D false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>             ret =3D OPENVPN_EXECVE_N=
OT_ALLOWED;</span><br><span>             if (!exec_warn &amp;&amp; (script_=
security() &lt; SSEC_SCRIPTS))</span><br><span>             {</span><br><sp=
an>@@ -1508,11 +1509,10 @@</span><br><span> static void</span><br><span> se=
t_openssl_env_vars(void)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const WCHAR *ssl_fallback_dir =3D L&quot;C:\\Wind=
ows\\System32&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span>     WCHAR install_path[MAX_PATH] =3D { 0 };</span><br><spa=
n>     if (!get_openvpn_reg_value(NULL, install_path, _countof(install_path=
)))</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        const WCHAR *ssl_fallback_dir =3D L&quot;C:\\Windows\\System=
32&quot;;</span><br><span>         /* if we cannot find installation path f=
rom the registry,</span><br><span>          * use Windows directory as a fa=
llback</span><br><span>          */</span><br><span>diff --git a/src/openvp=
nserv/common=2Ec b/src/openvpnserv/common=2Ec</span><br><span>index cce5318=
=2E=2E7a23d41 100644</span><br><span>--- a/src/openvpnserv/common=2Ec</span=
><br><span>+++ b/src/openvpnserv/common=2Ec</span><br><span>@@ -254,10 +254=
,8 @@</span><br><span> MsgToEventLog(DWORD flags, LPCWSTR format, =2E=2E=2E=
)</span><br><span> {</span><br><span>     HANDLE hEventSource;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    WCHAR msg[2][256];</span><br><=
span>     DWORD error =3D 0;</span><br><span>     LPCWSTR err_msg =3D L&quo=
t;&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    va_list =
arglist;</span><br><span> </span><br><span>     if (flags &amp; MSG_FLAGS_S=
YS_CODE)</span><br><span>     {</span><br><span>@@ -268,6 +266,9 @@</span><=
br><span>     hEventSource =3D RegisterEventSource(NULL, APPNAME);</span><b=
r><span>     if (hEventSource !=3D NULL)</span><br><span>     {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        va_list arglist;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        WCHAR msg[2][256];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
       swprintf(msg[0], _countof(msg[0]), L&quot;%ls%ls%ls: %ls&quot;, APPN=
AME, service_instance,</span><br><span>                  (flags &amp; MSG_F=
LAGS_ERROR) ? L&quot; error&quot; : L&quot;&quot;, err_msg);</span><br><spa=
n> </span><br><span>@@ -311,10 +312,10 @@</span><br><span> const wchar_t *<=
/span><br><span> get_win_sys_path(void)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    const wchar_t *default_sys_path =
=3D L&quot;C:\\Windows\\system32&quot;;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span>     if (!GetSystemDirectoryW(win_sys_pa=
th, _countof(win_sys_path)))</span><br><span>     {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const wchar_t *default_sys_path =
=3D L&quot;C:\\Windows\\system32&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>         wcscpy_s(win_sys_path, _count=
of(win_sys_path), default_sys_path);</span><br><span>         win_sys_path[=
_countof(win_sys_path) - 1] =3D L&#39;\0&#39;;</span><br><span>     }</span=
><br><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/i=
nteractive=2Ec</span><br><span>index 4a38aa4=2E=2E1d9a5d87 100644</span><br=
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
view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1963?usp=
=3Demail">change 1963</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1963?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1963 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bo=
dy></html>
--5a9atG3aq3c=--


--===============4672454664767409178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4672454664767409178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4672454664767409178==--

