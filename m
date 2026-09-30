Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0175CA5FC7
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fHK46Y9DXl+/LqyyI0/Vi8A91pedxgLB0N0LVBhZHrY=; b=iUP1QgtxDMt9VjoyGgB+OLrj2u
	Q9dI8Z7a3ZEsWysQTy21b1qGieF7kkBKYXavhKj8Iz2ZQPuDPZLQ3Cx43KU4LW/bgT8GDj4M+Uqvg
	q9RpRezUDzAY1jOZwMIyrwQ8Q2cDaT5oPWYO/wbr0W9MQDMHcdlnsNeiVN8W7hmpzlWM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBuGT-0005rk-4M;
	Wed, 30 Sep 2026 13:22:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBuGR-0005rZ-Ka
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:22:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Vak1F5QJ66FBYqbrRwRY1ESTZYyv2ugjpxKjxNpb1Ms=; b=TGfmPnlVxfG4gCXsk6wQvhslPf
 OywdAdD/e1h/dOPnYLmEJG4ElgiTP9RmK/L/Xs/uVc3ieBY3R0E+td9u+mMnZ9udvD2zqUCdrEn2P
 cr6bwwm+d0OYceEgATSkPMeVI5wqJOMVFk6Rpb3biSQe51LA6BNCCMyDTTVFfS0lVloM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Vak1F5QJ66FBYqbrRwRY1ESTZYyv2ugjpxKjxNpb1Ms=; b=C
 NxO9f29VHuQswAlxLZGEVXikKdsxAZjwGIX6NL3j2LZFGvns2kZEH2/hmWQ0lS+iL5isOvOx+jkSr
 kqk+3yw8s15suSD0Cz2Uor53MQa+tacBYzxSvgZU6VsjB5nQdMyKn0MHufkSEtg4wmZeuhlz01WTh
 2lha7LojD3yQzHe4=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBuGM-0005dM-Tp for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:22:28 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7d2bb404so8183665e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 06:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790774536; x=1791379336; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vak1F5QJ66FBYqbrRwRY1ESTZYyv2ugjpxKjxNpb1Ms=;
 b=B9ZcVHwGIQ52ygwilJGUCDZIndPqexhwZs62rri0YLoJAs+HQ2vK+tSHEgzI7urhQi
 LGKeEoZvx7/RIWjPYJLRYnmKAmn+eyaC8+gyS0f81xuPLL+p+4v5eOgq8/ZTjvh5ZJq9
 nA6n3VDnAmMlMiEdZZ+Q7oBCwkQF7a8cBGHpzbSzJpVnfTkb+tX4k82IUzL8FQhYEZtO
 TJu5BgdStMSxS0lNOXAve0g3gBsXJqStiEkzE3kDAvDG/jyr42vnmdCBxKV0lrintmpj
 /FsLuxOHX2NQxuhr+jbMNnrQn2DFFm0fUcBGybFt+467Cn1fgxSmKBY/aIYrvsUJAQdt
 ve7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790774536; x=1791379336;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vak1F5QJ66FBYqbrRwRY1ESTZYyv2ugjpxKjxNpb1Ms=;
 b=YuYJ6bMTDYNyFQIfMhL5qIV9heMq4RQQwl6vqZ5uy/1ww3xVP5WxaQYdaOTkHAvUpJ
 VTNeAkKOHYpaksXnuB7l2FdtceKmrtBy7E3j1CFLkRdvfBLqlMO6DF8Hawr/8c3BRDV4
 C30OFc2JkW0wLFG9fK1cw8nOr5q30K5qKHMzqjWwEpqDW2xJz+K3LufVnsVOqzEuYU0n
 kpmRB5Y+PmIqPbyvrKPt5yHiRA5m/r7ps4RUPTSNtYirrf3B1LTNkoiIRqHuuCNVVJrj
 5P3fD7YWVV7SaiSCrItqjvMksgucry61lK7LZEC9/4YqfQx9IV8pFmTxO0dOUgZgLS/U
 zcGg==
X-Gm-Message-State: AFuF++l4ltC0wKik2kB8VeEBBkCU8mBV7zwYfNP2WRmml4lDk10Y5BZq
 TvEXBi+3IiaVBYqecvosdB1f3bD2YnMW61qNjz6aVBadv9kFUj+7jiSZP8Ugr8pFn0Zufp4OgfB
 5W8LfWm15ai6h4372/ZwQ4XN3JVUX/N1o2HNXIAAKmqrXqQxNhtY/ATmu4rjaBiUZ7RmRvJsDq0
 9grxHGag==
X-Gm-Gg: AYBFou1nfxey2ZQ4xk4oaeNrIr+9/eJHINsvA3pC+MnmqHq8K9wR/XG5F6Z2iGkD+EP
 +YsplRhfZ9sSQb6sL2Vh0QFMQEVO36Qc6mklxnCbiflskCien+SzbHrB5unzufdCtJrBe/2EphL
 P854Y/XdYxylq3GDK64+9A20sdY4aLI++amIffeytuMaEZ4yWMl1irkSM/yQ7Plmh/og8sa4UWa
 qeB/pXvXfYU0/5Wdmeg7oXbE0/jDPGAPooKD2Ju8tYO/9p02N5JGvMbZbGacgNJ7go0F/d/nUKw
 zIpPek1reFq1n49lbnLblM7HuH4q/CtQyJu3dAWElc+IcH/OOqNF8Tquqnk5gbF4nV4pEo1ylOm
 v2JtyDzJc0QVGaba6rCKEVEPur+cIOxdNnIxSSsxiuTOpAY1kzFGeAHtcfsfJMmD5h/6hFy//Gf
 vlnqiQR+WmGfv05njpNA73HL3+gFcpzafaGVigQbwWbtDvvSuLODK0RaEsJj2TDkVtkOQq8bUdw
 GVUTMNGd43tON1DrnZSsXE2NOi/66O11Pkuz5hDfH1Id1H0YYBabsOaKNDBOt8ajQzNx8ShUSq6
 c7k/tuKyvaaVH4Y3vg0HPqz0/TOQvQZTacrM3UQHWsbcDLRkEWyVJHjf5oNk
X-Received: by 2002:a05:600c:4e04:b0:4a0:1b14:d009 with SMTP id
 5b1f17b1804b1-4a01b188d8bmr24854565e9.1.1790774535474; 
 Wed, 30 Sep 2026 06:22:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01e409b0fsm10435e9.0.2026.09.30.06.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:22:14 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 13:22:03 +0000
To: razvanc <razvanc@mailbox.org>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7
X-Gerrit-Change-Number: 1963
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1963?usp=email>
X-Gerrit-Commit: 891afd79b6e27f1df7ad629615351709eff57e83
In-Reply-To: <gerrit.1790613679000.Ib69b6c7a5f21f8552159c94560830f182c6238b7@gerrit.openvpn.net>
References: <gerrit.1790613679000.Ib69b6c7a5f21f8552159c94560830f182c6238b7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEzNjc5MDAwLkliNjliNmM3YTVmMjFmODU1MjE1OWM5NDU2MDgzMGYxODJjNjIzOGI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8245f4b7ef457e3d2889fbef72c1382749072fe1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBuGM-0005dM-Tp
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4077185561162699874=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4077185561162699874==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Mc7fsipW0qM="; charset=UTF-8

--Mc7fsipW0qM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, razvanc, 

I'd like you to reexamine a change=2E Please visit

    =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1963?usp=3Demail

to look at the =
new patch set (#2)=2E

The change is no longer submittable: checks~ChecksSu=
bmitRule is unsatisfied now=2E


Change subject: Fix (almost) all occurrenc=
es of cppcheck variableScope
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
---
M dev-tools/cppcheck-sup=
pressions=2Exml
M sample/sample-plugins/keying-material-exporter-demo/keyin=
gmaterialexporter=2Ec
M sample/sample-plugins/log/log_v3=2Ec
M src/openvpn/=
buffer=2Ec
M src/openvpn/clinat=2Ec
M src/openvpn/console_builtin=2Ec
M src=
/openvpn/crypto=2Ec
M src/openvpn/crypto_epoch=2Ec
M src/openvpn/dco_freebs=
d=2Ec
M src/openvpn/dhcp=2Ec
M src/openvpn/env_set=2Ec
M src/openvpn/forwar=
d=2Ec
M src/openvpn/httpdigest=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/m=
isc=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/op=
envpn/options=2Ec
M src/openvpn/options_parse=2Ec
M src/openvpn/packet_id=
=2Ec
M src/openvpn/platform=2Ec
M src/openvpn/pool=2Ec
M src/openvpn/proto=
=2Ec
M src/openvpn/push=2Ec
M src/openvpn/route=2Ec
M src/openvpn/run_comma=
nd=2Ec
M src/openvpn/siphash_reference=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M =
src/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_ver=
ify_mbedtls=2Ec
M src/openvpn/tun=2Ec
M src/openvpn/win32=2Ec
M src/openvpn=
serv/common=2Ec
M src/openvpnserv/interactive=2Ec
M src/openvpnserv/service=
=2Ec
M tests/unit_tests/openvpn/test_provider=2Ec
37 files changed, 108 ins=
ertions(+), 134 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/63/1963/2

diff --git a/dev-tools/cppcheck-suppressi=
ons=2Exml b/dev-tools/cppcheck-suppressions=2Exml
index 38de5f2a=2E=2Ebd24c=
3b 100644
--- a/dev-tools/cppcheck-suppressions=2Exml
+++ b/dev-tools/cppch=
eck-suppressions=2Exml
@@ -14,9 +14,6 @@
   <suppress>
     <id>usleepCalle=
d</id>
   </suppress>
-  <suppress>
-    <id>variableScope</id>
-  </suppre=
ss>
   <!-- We have a lot of library includes, not all of them are really r=
equired,
        so ignore them -->
   <suppress>
@@ -288,4 +285,15 @@
    =
 <id>unusedStructMember</id>
     <fileName>tests/unit_tests/openvpn/test_p=
kcs11=2Ec</fileName>
   </suppress>
+  <!-- IGN: nicer -->
+  <suppress>
+ =
   <id>variableScope</id>
+    <fileName>src/openvpnserv/interactive=2Ec</f=
ileName>
+    <symbolName>cmds</symbolName>
+  </suppress>
+  <suppress>
+ =
   <id>variableScope</id>
+    <fileName>src/openvpnserv/interactive=2Ec</f=
ileName>
+    <symbolName>sys_key</symbolName>
+  </suppress>
 </suppressio=
ns>
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keying=
materialexporter=2Ec b/sample/sample-plugins/keying-material-exporter-demo/=
keyingmaterialexporter=2Ec
index 512861a=2E=2E2474bf1 100644
--- a/sample/s=
ample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec
+++ =
b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporte=
r=2Ec
@@ -120,13 +120,14 @@
     ASN1_OBJECT *fn;
     ASN1_STRING *val;
  =
   X509_NAME *x509_name;
-    X509_NAME_ENTRY *ent;
     const char *objbuf=
;
 
     x509_name =3D X509_get_subject_name(x509);
-    int i, n =3D X509_=
NAME_entry_count(x509_name);
-    for (i =3D 0; i < n; ++i)
+    int n =3D =
X509_NAME_entry_count(x509_name);
+    for (int i =3D 0; i < n; ++i)
     {=

+        X509_NAME_ENTRY *ent;
+
         if (!(ent =3D X509_NAME_get_entr=
y(x509_name, i)))
         {
             continue;
diff --git a/sample/sam=
ple-plugins/log/log_v3=2Ec b/sample/sample-plugins/log/log_v3=2Ec
index 09c=
6735=2E=2E1c781a3 100644
--- a/sample/sample-plugins/log/log_v3=2Ec
+++ b/s=
ample/sample-plugins/log/log_v3=2Ec
@@ -197,7 +197,6 @@
     ASN1_OBJECT *f=
n;
     ASN1_STRING *val;
     X509_NAME *x509_name;
-    X509_NAME_ENTRY *=
ent;
     const char *objbuf;
     unsigned char *buf =3D NULL;
 
@@ -205,7=
 +204,7 @@
     n =3D X509_NAME_entry_count(x509_name);
     for (i =3D 0; =
i < n; ++i)
     {
-        ent =3D X509_NAME_get_entry(x509_name, i);
+   =
     X509_NAME_ENTRY *ent =3D X509_NAME_get_entry(x509_name, i);
         i=
f (!ent)
         {
             continue;
diff --git a/src/openvpn/buffer=
=2Ec b/src/openvpn/buffer=2Ec
index 21e113d=2E=2E8f558b1 100644
--- a/src/o=
penvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -228,13 +228,13 @@
     i=
nt ret =3D false;
     if (buf_defined(buf))
     {
-        va_list arglis=
t;
         uint8_t *ptr =3D BEND(buf);
         int cap =3D buf_forward_ca=
pacity(buf);
 
         if (cap > 0)
         {
             int stat;
+   =
         va_list arglist;
             va_start(arglist, format);
         =
    stat =3D vsnprintf((char *)ptr, cap, format, arglist);
             va_=
end(arglist);
diff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec
=
index 9fa8f5f=2E=2Ed72d42a 100644
--- a/src/openvpn/clinat=2Ec
+++ b/src/op=
envpn/clinat=2Ec
@@ -50,12 +50,11 @@
 print_client_nat_list(const struct cl=
ient_nat_option_list *list, msglvl_t msglevel)
 {
     struct gc_arena gc =
=3D gc_new();
-    int i;
 
     msg(msglevel, "*** CNAT list");
     if (l=
ist)
     {
-        for (i =3D 0; i < list->n; ++i)
+        for (int i =
=3D 0; i < list->n; ++i)
         {
             const struct client_nat_en=
try *e =3D &list->entries[i];
             msg(msglevel, "  CNAT[%d] t=3D%d=
 %s/%s/%s", i, e->type,
diff --git a/src/openvpn/console_builtin=2Ec b/src/=
openvpn/console_builtin=2Ec
index 9c8d72a=2E=2Ecf6cc37 100644
--- a/src/ope=
nvpn/console_builtin=2Ec
+++ b/src/openvpn/console_builtin=2Ec
@@ -77,7 +77=
,6 @@
     bool is_console =3D (GetFileType(in) =3D=3D FILE_TYPE_CHAR);
   =
  DWORD flags_save =3D 0;
     int status =3D 0;
-    WCHAR *winput;
 
    =
 if (is_console)
     {
@@ -100,7 +99,7 @@
 
     if (is_console)
     {
- =
       winput =3D malloc(capacity * sizeof(WCHAR));
+        WCHAR *winput =
=3D malloc(capacity * sizeof(WCHAR));
         if (winput =3D=3D NULL)
    =
     {
             return false;
diff --git a/src/openvpn/crypto=2Ec b/src=
/openvpn/crypto=2Ec
index 8196c26=2E=2E3d3ab0c 100644
--- a/src/openvpn/cry=
pto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1774,13 +1774,10 @@
 static const =
cipher_name_pair *
 get_cipher_name_pair(const char *cipher_name)
 {
-    c=
onst cipher_name_pair *pair;
-    size_t i =3D 0;
-
     /* Search for a ci=
pher name translation */
-    for (; i < cipher_name_translation_table_coun=
t; i++)
+    for (size_t i =3D 0; i < cipher_name_translation_table_count; =
i++)
     {
-        pair =3D &cipher_name_translation_table[i];
+        c=
onst cipher_name_pair *pair =3D &cipher_name_translation_table[i];
        =
 if (0 =3D=3D strcmp(cipher_name, pair->openvpn_name)
             || 0 =3D=
=3D strcmp(cipher_name, pair->lib_name))
         {
diff --git a/src/openvp=
n/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
index 158c841=2E=2E69a185=
2 100644
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src/openvpn/crypto_epoch=
=2Ec
@@ -387,9 +387,6 @@
     else if (epoch > opt->key_ctx_bi=2Edecrypt=2E=
epoch
              && epoch <=3D opt->key_ctx_bi=2Edecrypt=2Eepoch + opt->=
epoch_data_keys_future_count)
     {
-        /* Key in the range of future=
 keys */
-        int index =3D epoch - (opt->key_ctx_bi=2Edecrypt=2Eepoch =
+ 1);
-
         /* If we have reached the edge of the valid keys we do not=
 return
          * the key anymore since regenerating the new keys would m=
ove us
          * over the window of valid keys and would need all kind of=

@@ -400,6 +397,9 @@
         }
         else
         {
+            /* Ke=
y in the range of future keys */
+            const int index =3D epoch - (=
opt->key_ctx_bi=2Edecrypt=2Eepoch + 1);
+
             return &opt->epoch_d=
ata_keys_future[index];
         }
     }
diff --git a/src/openvpn/dco_free=
bsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index 7346903=2E=2E3148f10 100644
---=
 a/src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -444,7 =
+444,6 @@
 key_to_nvlist(const uint8_t *key, const uint8_t *implicit_iv, co=
nst char *ciphername)
 {
     nvlist_t *nvl;
-    size_t key_len;
 
     nv=
l =3D nvlist_create(0);
 
@@ -452,7 +451,7 @@
 
     if (strcmp(ciphername,=
 "none") !=3D 0)
     {
-        key_len =3D cipher_kt_key_size(ciphername)=
;
+        const size_t key_len =3D cipher_kt_key_size(ciphername);
 
     =
    nvlist_add_binary(nvl, "key", key, key_len);
         nvlist_add_binary=
(nvl, "iv", implicit_iv, 8);
diff --git a/src/openvpn/dhcp=2Ec b/src/openvp=
n/dhcp=2Ec
index 5cdcfcf=2E=2E19e9e2d 100644
--- a/src/openvpn/dhcp=2Ec
+++=
 b/src/openvpn/dhcp=2Ec
@@ -271,7 +271,6 @@
 {
     char tmp_buf[256];
    =
 size_t len =3D 0;
-    size_t label_length_pos;
 
     for (int i =3D 0; i=
 < array_len; i++)
     {
@@ -290,7 +289,7 @@
 
         /* label_length_po=
s points to the byte to be replaced by the length
          * of the follow=
ing domain label */
-        label_length_pos =3D len++;
+        size_t la=
bel_length_pos =3D len++;
 
         while (true)
         {
diff --git a/s=
rc/openvpn/env_set=2Ec b/src/openvpn/env_set=2Ec
index d992097=2E=2E67a5bf5=
 100644
--- a/src/openvpn/env_set=2Ec
+++ b/src/openvpn/env_set=2Ec
@@ -62,=
14 +62,13 @@
 static bool
 env_string_equal(const char *s1, const char *s2)=

 {
-    int c1, c2;
     ASSERT(s1);
     ASSERT(s2);
 
     while (true)
=
     {
-        c1 =3D *s1++;
-        c2 =3D *s2++;
+        int c1 =3D *s=
1++;
+        int c2 =3D *s2++;
         if (c1 =3D=3D '=3D')
         {
  =
           c1 =3D 0;
@@ -214,12 +213,11 @@
     if (check_debug_level(msgle=
vel))
     {
         const struct env_item *e;
-        int i;
 
         =
if (es)
         {
+            int i =3D 0;
             e =3D es->list;
-=
            i =3D 0;
 
             while (e)
             {
diff --git a/s=
rc/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 178c43f=2E=2E20b247c=
 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -205=
6,13 +2056,13 @@
     unsigned int socket =3D 0;
     unsigned int tuntap =
=3D 0;
     static uintptr_t tun_shift =3D TUN_SHIFT;
-    static uintptr_t=
 err_shift =3D ERR_SHIFT;
 
     /*
      * Calculate the flags based on th=
e provided 'flags' argument=2E
      */
     if ((c->options=2Emode !=3D MO=
DE_SERVER) && (flags & IOW_WAIT_SIGNAL))
     {
+        static uintptr_t e=
rr_shift =3D ERR_SHIFT;
         wait_signal(es, (void *)err_shift);
     }=

 
diff --git a/src/openvpn/httpdigest=2Ec b/src/openvpn/httpdigest=2Ec
ind=
ex ab8a710=2E=2E52df383 100644
--- a/src/openvpn/httpdigest=2Ec
+++ b/src/o=
penvpn/httpdigest=2Ec
@@ -34,12 +34,9 @@
 static void
 CvtHex(IN HASH Bin, =
OUT HASHHEX Hex)
 {
-    unsigned short i;
-    unsigned char j;
-
-    for=
 (i =3D 0; i < HASHLEN; i++)
+    for (unsigned short i =3D 0; i < HASHLEN;=
 i++)
     {
-        j =3D (Bin[i] >> 4) & 0xf;
+        unsigned char j =
=3D (Bin[i] >> 4) & 0xf;
         if (j <=3D 9)
         {
             Hex=
[i * 2] =3D (j + '0');
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/ma=
nage=2Ec
index 2f1ca95=2E=2E1e74f09 100644
--- a/src/openvpn/manage=2Ec
+++=
 b/src/openvpn/manage=2Ec
@@ -368,7 +368,6 @@
     {
         struct gc_are=
na gc =3D gc_new();
         struct log_entry e;
-        const char *out =
=3D NULL;
         unsigned int action_flags =3D 0;
 
         ++recursive_=
level;
@@ -391,6 +390,8 @@
 
         if (!man_password_needed(man))
      =
   {
+            const char *out =3D NULL;
+
             if (flags =3D=3D=
 M_CLIENT)
             {
                 out =3D log_entry_print(&e, LOG_=
PRINT_CRLF, &gc);
@@ -3036,14 +3037,15 @@
 static void
 man_output_peer_inf=
o_env(struct management *man, const struct man_def_auth_context *mdac)
 {
-=
    char line[256];
     if (man->persist=2Ecallback=2Eget_peer_info)
     =
{
         const char *peer_info =3D
             (*man->persist=2Ecallback=
=2Eget_peer_info)(man->persist=2Ecallback=2Earg, mdac->cid);
         if (p=
eer_info)
         {
+            char line[256];
             struct buffe=
r buf;
+
             buf_set_read(&buf, (const uint8_t *)peer_info, strlen=
(peer_info));
             while (buf_parse(&buf, '\n', line, sizeof(line))=
)
             {
@@ -3820,13 +3822,12 @@
 {
     int ok;
     char *result =
=3D NULL;
-    const struct buffer *buf;
 
     ok =3D management_query_mul=
tiline(man, b64_data, prompt, cmd, state, input);
     if (ok && buffer_lis=
t_defined(*input))
     {
         buffer_list_aggregate_separator(*input, =
10000, "\n");
-        buf =3D buffer_list_peek(*input);
+        const str=
uct buffer *buf =3D buffer_list_peek(*input);
         if (buf && BLEN(buf)=
 > 0)
         {
             result =3D (char *)malloc(BLENZ(buf) + 1);
@@=
 -3847,15 +3848,13 @@
 management_query_multiline_flatten(struct management=
 *man, const char *b64_data, const char *prompt,
                          =
          const char *cmd, int *state, struct buffer_list **input)
 {
-    =
int ok;
     char *result =3D NULL;
-    const struct buffer *buf;
 
-    o=
k =3D management_query_multiline(man, b64_data, prompt, cmd, state, input);=

+    const int ok =3D management_query_multiline(man, b64_data, prompt, cm=
d, state, input);
     if (ok && buffer_list_defined(*input))
     {
      =
   buffer_list_aggregate(*input, 2048);
-        buf =3D buffer_list_peek(*=
input);
+        const struct buffer *buf =3D buffer_list_peek(*input);
   =
      if (buf && BLEN(buf) > 0)
         {
             result =3D (char *)=
malloc(BLENZ(buf) + 1);
diff --git a/src/openvpn/misc=2Ec b/src/openvpn/mis=
c=2Ec
index 54af890=2E=2E6e9591f 100644
--- a/src/openvpn/misc=2Ec
+++ b/sr=
c/openvpn/misc=2Ec
@@ -474,7 +474,7 @@
 purge_user_pass(struct user_pass *u=
p, const bool force)
 {
     const bool nocache =3D up->nocache;
-    stati=
c bool warn_shown =3D false;
+
     if (nocache || force)
     {
         s=
ecure_memzero(up, sizeof(*up));
@@ -482,6 +482,8 @@
     }
     else
     {=

+        static bool warn_shown =3D false;
+
         protect_user_pass(up=
);
         /*
          * don't show warning if the pass has been replaced=
 by a token: this is an
@@ -721,11 +723,10 @@
 bool
 validate_peer_info_lin=
e(char *line)
 {
-    uint8_t c;
     int state =3D 0;
     while (*line)
 =
    {
-        c =3D *line;
+        const uint8_t c =3D *line;
         sw=
itch (state)
         {
             case 0:
diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec
index 7eb3d77=2E=2E8fba67a 100644
--- a/src/op=
envpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4207,13 +4207,11 @@
 static=
 void
 tunnel_server_loop(struct multi_context *multi)
 {
-    int status;
=
-
     while (true)
     {
         /* wait on tun/socket list */
         =
multi_get_timeout(multi, &multi->top=2Ec2=2Etimeval);
-        status =3D m=
ulti_io_wait(multi);
+        const int status =3D multi_io_wait(multi);
  =
       MULTI_CHECK_SIG(multi);
 
         /* check on status of coarse time=
rs */
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networkin=
g_sitnl=2Ec
index bb29781=2E=2E49de664 100644
--- a/src/openvpn/networking_=
sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -1375,13 +1375,11 @@
 s=
itnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *rta=
, size_t len,
                          unsigned short flags)
 {
-    unsig=
ned short type;
-
     memset(tb, 0, sizeof(struct rtattr *) * (max + 1));
=
 
     while (RTA_OK(rta, len))
     {
-        type =3D rta->rta_type & ~f=
lags;
+        const unsigned short type =3D rta->rta_type & ~flags;
 
    =
     if ((type <=3D max) && (!tb[type]))
         {
@@ -1409,7 +1407,6 @@
 =
static int
 sitnl_type_save(struct nlmsghdr *n, void *arg)
 {
-    char *ty=
pe =3D arg;
     struct ifinfomsg *ifi =3D NLMSG_DATA(n);
     struct rtatt=
r *tb[IFLA_MAX + 1];
 
@@ -1418,6 +1415,7 @@
     if (tb[IFLA_LINKINFO])
  =
   {
         struct rtattr *tb_link[IFLA_INFO_MAX + 1];
+        char *typ=
e =3D arg;
 
         sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MAX, tb[=
IFLA_LINKINFO]);
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn/optio=
ns=2Ec
index 5a57c0a=2E=2E1f4b191 100644
--- a/src/openvpn/options=2Ec
+++ =
b/src/openvpn/options=2Ec
@@ -1019,10 +1019,9 @@
 
     for (current =3D *l=
ist, prev =3D NULL; current !=3D NULL; current =3D current->next)
     {
- =
       char *tmp_value =3D NULL;
         if (!strncmp(current->string, "fo=
reign_option_", sizeof("foreign_option_") - 1))
         {
-            tmp=
_value =3D strchr(current->string, '=3D');
+            const char *tmp_val=
ue =3D strchr(current->string, '=3D');
             if (tmp_value && ++tmp_=
value)
             {
                 if (!strncmp(tmp_value, "dhcp-option=
 ", sizeof("dhcp-option ") - 1))
diff --git a/src/openvpn/options_parse=2Ec=
 b/src/openvpn/options_parse=2Ec
index 0e94522=2E=2E79b8098 100644
--- a/sr=
c/openvpn/options_parse=2Ec
+++ b/src/openvpn/options_parse=2Ec
@@ -351,7 +=
351,6 @@
 {
     const int max_recursive_levels =3D 10;
     FILE *fp;
-   =
 int line_num;
     char line[OPTION_LINE_SIZE + 1];
     char *p[MAX_PARMS=
 + 1];
 
@@ -368,7 +367,7 @@
         }
         if (fp)
         {
-      =
      line_num =3D 0;
+            int line_num =3D 0;
             while (=
fgets(line, sizeof(line), fp))
             {
                 int offset =
=3D 0;
diff --git a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec
i=
ndex 22c53c7=2E=2E50d7c76 100644
--- a/src/openvpn/packet_id=2Ec
+++ b/src/=
openvpn/packet_id=2Ec
@@ -219,8 +219,6 @@
 bool
 packet_id_test(struct pack=
et_id_rec *p, const struct packet_id_net *pin)
 {
-    uint64_t diff;
-
   =
  packet_id_debug(D_PID_DEBUG, p, pin, "PID_TEST", 0);
 
     ASSERT(p->ini=
tialized);
@@ -247,7 +245,7 @@
             }
 
             /* check packe=
t-id sliding window for original/replay status */
-            diff =3D p->=
id - pin->id;
+            const uint64_t diff =3D p->id - pin->id;
 
     =
        /* keep track of maximum backtrack seen for debugging purposes */
 =
            if (diff > p->max_backtrack_stat)
@@ -512,7 +510,6 @@
     {
  =
       struct packet_id_persist_file_image image;
         CLEAR(image);
- =
       ssize_t n;
         off_t seek_ret;
         struct gc_arena gc =3D =
gc_new();
 
@@ -521,7 +518,7 @@
         seek_ret =3D lseek(p->fd, (off_t)0=
, SEEK_SET);
         if (seek_ret =3D=3D (off_t)0)
         {
-           =
 n =3D write(p->fd, &image, sizeof(image));
+            const ssize_t n =
=3D write(p->fd, &image, sizeof(image));
             if (n =3D=3D sizeof(i=
mage))
             {
                 p->time_last_written =3D p->time;
@@=
 -599,7 +596,6 @@
     {
         char c;
         time_t v;
-        int d=
iff;
 
         v =3D CIRC_LIST_ITEM(sl, i);
         if (v =3D=3D SEQ_UNSE=
EN)
@@ -612,7 +608,7 @@
         }
         else
         {
-            di=
ff =3D (int)(prev_now - v);
+            const int diff =3D (int)(prev_now =
- v);
             if (diff < 0)
             {
                 c =3D 'N';=

diff --git a/src/openvpn/platform=2Ec b/src/openvpn/platform=2Ec
index ccd=
d43d=2E=2E9412eeb 100644
--- a/src/openvpn/platform=2Ec
+++ b/src/openvpn/p=
latform=2Ec
@@ -539,8 +539,6 @@
 const char *
 platform_create_temp_file(co=
nst char *directory, const char *prefix, struct gc_arena *gc)
 {
-    int f=
d;
-    const char *retfname =3D NULL;
     unsigned int attempts =3D 0;
  =
   char fname[256] =3D { 0 };
     const char *fname_fmt =3D PACKAGE "_%=2E=
*s_%08" PRIx64 "%08" PRIx64 "=2Etmp";
@@ -557,7 +555,7 @@
             retu=
rn NULL;
         }
 
-        retfname =3D platform_gen_path(directory, fn=
ame, gc);
+        const char *retfname =3D platform_gen_path(directory, fn=
ame, gc);
         if (!retfname)
         {
             msg(M_WARN, "Fail=
ed to create temporary filename and path");
@@ -566,7 +564,7 @@
 
         =
/* Atomically create the file=2E  Errors out if the file already
          =
* exists=2E  */
-        fd =3D platform_open(retfname, O_CREAT | O_EXCL | =
O_WRONLY, S_IRUSR | S_IWUSR);
+        const int fd =3D platform_open(retfn=
ame, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR);
         if (fd !=3D =
-1)
         {
             close(fd);
diff --git a/src/openvpn/pool=2Ec b/=
src/openvpn/pool=2Ec
index 80dec6c=2E=2E63fc930 100644
--- a/src/openvpn/po=
ol=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -494,22 +494,21 @@
         for (i =3D=
 0; i < pool->size; ++i)
         {
             const struct ifconfig_pool=
_entry *e =3D &pool->list[i];
-            struct in6_addr ip6;
-          =
  in_addr_t ip;
-            const char *ip6_str =3D "";
-            const=
 char *ip_str =3D "";
 
             if (e->common_name)
             {
+  =
              const char *ip6_str =3D "";
+                const char *ip_s=
tr =3D "";
+
                 if (pool->ipv4=2Eenabled)
                 {
=
-                    ip =3D ifconfig_pool_handle_to_ip_base(pool, i);
+    =
                const in_addr_t ip =3D ifconfig_pool_handle_to_ip_base(pool=
, i);
                     ip_str =3D print_in_addr_t(ip, 0, &gc);
        =
         }
 
                 if (pool->ipv6=2Eenabled)
                 {
=
-                    ip6 =3D ifconfig_pool_handle_to_ipv6_base(pool, i);
+ =
                   const struct in6_addr ip6 =3D ifconfig_pool_handle_to_ip=
v6_base(pool, i);
                     ip6_str =3D print_in6_addr(ip6, 0, &=
gc);
                 }
 
diff --git a/src/openvpn/proto=2Ec b/src/openvpn/=
proto=2Ec
index 785c021=2E=2E2cdb147 100644
--- a/src/openvpn/proto=2Ec
+++=
 b/src/openvpn/proto=2Ec
@@ -39,7 +39,6 @@
 is_ipv_X(int tunnel_type, struc=
t buffer *buf, int ip_ver)
 {
     int offset;
-    uint16_t proto;
     co=
nst struct openvpn_iphdr *ih;
 
     verify_align_4(buf);
@@ -61,7 +60,7 @@=

         eh =3D (const struct openvpn_ethhdr *)BPTR(buf);
 
         /* st=
art by assuming this is a standard Eth fram */
-        proto =3D eh->proto=
;
+        uint16_t proto =3D eh->proto;
         offset =3D sizeof(struct =
openvpn_ethhdr);
 
         /* if this is a 802=2E1q frame, parse the heade=
r using the according
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=
=2Ec
index a514d92a=2E=2E8dfe0d5 100644
--- a/src/openvpn/push=2Ec
+++ b/sr=
c/openvpn/push=2Ec
@@ -1155,7 +1155,6 @@
         while (e)
         {
    =
         char *p[MAX_PARMS + 1];
-            bool enable =3D true;
 
     =
        /* parse the push item */
             CLEAR(p);
@@ -1163,6 +1162,8=
 @@
                 && parse_line(e->option, p, SIZE(p) - 1, "[PUSH_ROUTE_=
REMOVE]", 1, D_ROUTE_DEBUG,
                               &gc))
          =
   {
+                bool enable =3D true;
+
                 /* is the pu=
sh item a route directive? */
                 if (p[0] && !strcmp(p[0], "r=
oute") && !p[3] && o->iroutes)
                 {
diff --git a/src/openvpn/=
route=2Ec b/src/openvpn/route=2Ec
index b8bac7a=2E=2E4830a5b 100644
--- a/s=
rc/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -2773,7 +2773,6 @@
 {
 =
    struct gc_arena gc =3D gc_new();
     bool ret =3D false;
-    DWORD st=
atus;
     const DWORD if_index =3D windows_route_find_if_index(r, tt);
 
 =
    if (if_index !=3D TUN_ADAPTER_INDEX_INVALID)
@@ -2787,8 +2786,7 @@
    =
     fr=2EdwForwardNextHop =3D htonl(r->gateway);
         fr=2EdwForwardIf=
Index =3D if_index;
 
-        status =3D DeleteIpForwardEntry(&fr);
-
+   =
     const DWORD status =3D DeleteIpForwardEntry(&fr);
         if (status =
=3D=3D NO_ERROR)
         {
             ret =3D true;
@@ -3826,12 +3824,11=
 @@
 bool
 netmask_to_netbits(const in_addr_t network, const in_addr_t netm=
ask, int *netbits)
 {
-    int i;
     const int addrlen =3D sizeof(in_addr=
_t) * 8;
 
     if ((network & netmask) =3D=3D network)
     {
-        for=
 (i =3D 0; i <=3D addrlen; ++i)
+        for (int i =3D 0; i <=3D addrlen; =
++i)
         {
             in_addr_t mask =3D netbits_to_netmask(i);
    =
         if (mask =3D=3D netmask)
diff --git a/src/openvpn/run_command=2Ec =
b/src/openvpn/run_command=2Ec
index 905caa3=2E=2E0e36dad 100644
--- a/src/o=
penvpn/run_command=2Ec
+++ b/src/openvpn/run_command=2Ec
@@ -176,14 +176,13=
 @@
 #if defined(ENABLE_FEATURE_EXECVE)
         if (openvpn_execve_allowed=
(flags))
         {
-            const char *cmd =3D a->argv[0];
-         =
   char *const *argv =3D a->argv;
             char *const *envp =3D (char =
*const *)make_env_array(es, true, &gc);
-            pid_t pid;
 
-        =
    pid =3D fork();
+            const pid_t pid =3D fork();
             i=
f (pid =3D=3D (pid_t)0) /* child side */
             {
+                co=
nst char *cmd =3D a->argv[0];
+                char *const *argv =3D a->arg=
v;
                 execve(cmd, argv, envp);
                 exit(OPENVPN_=
EXECVE_FAILURE);
             }
@@ -283,17 +282,17 @@
         static bool =
warn_shown =3D false;
         if (script_security() >=3D SSEC_BUILT_IN)
  =
       {
-            const char *cmd =3D a->argv[0];
-            char *co=
nst *argv =3D a->argv;
             char *const *envp =3D (char *const *)ma=
ke_env_array(es, true, &gc);
-            pid_t pid;
+            const cha=
r *cmd =3D a->argv[0];
             int pipe_stdout[2];
 
             if (=
pipe(pipe_stdout) =3D=3D 0)
             {
-                pid =3D fork();=

-                if (pid =3D=3D (pid_t)0)       /* child side */
+        =
        const pid_t pid =3D fork();
+                if (pid =3D=3D (pid_t)=
0) /* child side */
                 {
+                    char *const *ar=
gv =3D a->argv;
+
                     close(pipe_stdout[0]); /* Close read=
 end */
                     dup2(pipe_stdout[1], 1);
                     =
execve(cmd, argv, envp);
diff --git a/src/openvpn/siphash_reference=2Ec b/s=
rc/openvpn/siphash_reference=2Ec
index 5f0adb9=2E=2E9240ab0 100644
--- a/sr=
c/openvpn/siphash_reference=2Ec
+++ b/src/openvpn/siphash_reference=2Ec
@@ =
-113,7 +113,6 @@
     uint64_t v3 =3D UINT64_C(0x7465646279746573);
     ui=
nt64_t k0 =3D U8TO64_LE(kk);
     uint64_t k1 =3D U8TO64_LE(kk + 8);
-    u=
int64_t m;
     int i;
     const unsigned char *end =3D ni + inlen - (inle=
n % sizeof(uint64_t));
     const int left =3D inlen & 7;
@@ -130,7 +129,7 =
@@
 
     for (; ni !=3D end; ni +=3D 8)
     {
-        m =3D U8TO64_LE(ni=
);
+        uint64_t m =3D U8TO64_LE(ni);
         v3 ^=3D m;
 
         TR=
ACE;
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec=

index cddf856=2E=2Eb60a8f0 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/=
src/openvpn/ssl_mbedtls=2Ec
@@ -1014,12 +1014,12 @@
 tls_ctx_personalise_ra=
ndom(struct tls_root_ctx *ctx)
 {
 #if MBEDTLS_VERSION_NUMBER < 0x04000000
=
-    static char old_sha256_hash[32] =3D { 0 };
-    unsigned char sha256_h=
ash[32] =3D { 0 };
     mbedtls_ctr_drbg_context *cd_ctx =3D rand_ctx_get()=
;
 
     if (NULL !=3D ctx->crt_chain)
     {
+        static char old_sha2=
56_hash[32] =3D { 0 };
+        unsigned char sha256_hash[32] =3D { 0 };
  =
       mbedtls_x509_crt *cert =3D ctx->crt_chain;
         const mbedtls_md=
_info_t *kt =3D md_get("SHA256");
 
diff --git a/src/openvpn/ssl_openssl=2E=
c b/src/openvpn/ssl_openssl=2Ec
index cb3de65=2E=2Eafda4d9 100644
--- a/src=
/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -1784,10 +178=
4,7 @@
 {
     STACK_OF(X509_INFO) *info_stack =3D NULL;
     STACK_OF(X509=
_NAME) *cert_names =3D NULL;
-    X509_LOOKUP *lookup =3D NULL;
     X509_S=
TORE *store =3D NULL;
-    BIO *in =3D NULL;
-    openssl_stack_size_t adde=
d =3D 0, prev =3D 0;
 
     ASSERT(NULL !=3D ctx);
 
@@ -1800,6 +1797,9 @@
=
     /* Try to add certificates and CRLs from ca_file */
     if (ca_file)
=
     {
+        openssl_stack_size_t added =3D 0;
+        BIO *in =3D NULL=
;
+
         if (ca_file_inline)
         {
             in =3D BIO_new_mem=
_buf((char *)ca_file, -1);
@@ -1816,6 +1816,8 @@
 
         if (info_stack)=

         {
+            openssl_stack_size_t prev =3D 0;
+
             fo=
r (openssl_stack_size_t i =3D 0; i < sk_X509_INFO_num(info_stack); i++)
   =
          {
                 X509_INFO *info =3D sk_X509_INFO_value(info_st=
ack, i);
@@ -1916,7 +1918,7 @@
     /* Set a store for certs (CA & CRL) wit=
h a lookup on the "capath" hash directory */
     if (ca_path)
     {
-    =
    lookup =3D X509_STORE_add_lookup(store, X509_LOOKUP_hash_dir());
+     =
   X509_LOOKUP *lookup =3D X509_STORE_add_lookup(store, X509_LOOKUP_hash_di=
r());
         if (lookup && X509_LOOKUP_add_dir(lookup, ca_path, X509_FILE=
TYPE_PEM))
         {
             msg(M_WARN, "WARNING: experimental optio=
n --capath %s", ca_path);
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvp=
n/ssl_pkt=2Ec
index 79d2b23=2E=2Ef78782f 100644
--- a/src/openvpn/ssl_pkt=
=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -74,8 +74,6 @@
 
         int e1, e2;=

         uint8_t *b =3D BPTR(buf);
-        uint8_t buf1[SWAP_BUF_SIZE];
-=
        uint8_t buf2[SWAP_BUF_SIZE];
 
         if (incoming)
         {
@@=
 -92,6 +90,9 @@
 
         if (buf->len >=3D e1 + e2)
         {
+         =
   uint8_t buf1[SWAP_BUF_SIZE];
+            uint8_t buf2[SWAP_BUF_SIZE];
+=

             memcpy(buf1, b, e1);
             memcpy(buf2, b + e1, e2);
 =
            memcpy(b, buf2, e2);
diff --git a/src/openvpn/ssl_verify_mbedtl=
s=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index c4bae40=2E=2Eb9a36a6 10064=
4
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/src/openvpn/ssl_verify_mbe=
dtls=2Ec
@@ -701,7 +701,6 @@
 void
 x509_setenv(struct env_set *es, int cer=
t_depth, mbedtls_x509_crt *cert)
 {
-    unsigned char c;
     const mbedtl=
s_x509_name *name;
     char s[128] =3D { 0 };
 
@@ -729,7 +728,7 @@
      =
           break;
             }
 
-            c =3D name->val=2Ep[i];
+  =
          const unsigned char c =3D name->val=2Ep[i];
             if (c < =
32 || c =3D=3D 127 || (c > 128 && c < 160))
             {
                =
 s[i] =3D '?';
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index=
 85b3074=2E=2E2d375a8 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tu=
n=2Ec
@@ -1893,7 +1893,6 @@
                      openvpn_net_ctx_t *ctx)
 =
{
     char dynamic_name[256];
-    bool dynamic_opened =3D false;
 
     /=
*
      * unlike "open_tun_generic()", DCO on Linux and FreeBSD follows
@@ =
-1905,6 +1904,8 @@
 
     if (strcmp(dev, "tun") =3D=3D 0)
     {
+        =
bool dynamic_opened =3D false;
+
         for (int i =3D 0; i < 256; ++i)
 =
        {
             snprintf(dynamic_name, sizeof(dynamic_name), "%s%d",=
 dev, i);
@@ -3263,7 +3264,6 @@
     if (tt->reads=2Eiostate =3D=3D IOSTATE=
_INITIAL)
     {
         BOOL status;
-        int err;
 
         /* rese=
t buf to its initial state */
         tt->reads=2Ebuf =3D tt->reads=2Ebuf_=
init;
@@ -3290,7 +3290,7 @@
         }
         else
         {
-          =
  err =3D GetLastError();
+            const int err =3D GetLastError();
  =
           if (err =3D=3D ERROR_IO_PENDING) /* operation queued? */
       =
      {
                 tt->reads=2Eiostate =3D IOSTATE_QUEUED;
@@ -3318,7=
 +3318,6 @@
     if (tt->writes=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
  =
       BOOL status;
-        int err;
 
         /* make a private copy of =
buf */
         tt->writes=2Ebuf =3D tt->writes=2Ebuf_init;
@@ -3345,7 +334=
4,7 @@
         }
         else
         {
-            err =3D GetLastErro=
r();
+            const int err =3D GetLastError();
             if (err =
=3D=3D ERROR_IO_PENDING) /* operation queued? */
             {
           =
      tt->writes=2Eiostate =3D IOSTATE_QUEUED;
@@ -3542,8 +3541,6 @@
      =
   char enum_name[256];
         char unit_string[256];
         HKEY unit_=
key;
-        char component_id_string[] =3D "ComponentId";
-        char c=
omponent_id[256];
         const char net_cfg_instance_id_string[] =3D "Net=
CfgInstanceId";
         BYTE net_cfg_instance_id[256];
         DWORD data=
_type;
@@ -3573,6 +3570,8 @@
         }
         else
         {
+         =
   const char component_id_string[] =3D "ComponentId";
+            char co=
mponent_id[256];
             len =3D sizeof(component_id);
             st=
atus =3D RegQueryValueEx(unit_key, component_id_string, NULL, &data_type,
 =
                                     (LPBYTE)component_id, &len);
@@ -3657,=
7 +3656,6 @@
         char enum_name[256];
         char connection_string[=
256];
         HKEY connection_key;
-        WCHAR name_data[256];
        =
 DWORD name_type;
         const WCHAR name_string[] =3D L"Name";
 
@@ -368=
9,6 +3687,7 @@
         }
         else
         {
+            WCHAR name_=
data[256];
             len =3D sizeof(name_data);
             status =3D =
RegQueryValueExW(connection_key, name_string, NULL, &name_type,
           =
                            (LPBYTE)name_data, &len);
@@ -3813,8 +3812,6 @@=

     bool warn_panel_dup =3D false;
     bool warn_tap_dup =3D false;
 
- =
   int links;
-
     const struct tap_reg *tr;
     const struct tap_reg *t=
r1;
     const struct panel_reg *pr;
@@ -3827,7 +3824,7 @@
     /* loop thr=
ough each TAP-Windows adapter registry entry */
     for (tr =3D tap_reg; t=
r !=3D NULL; tr =3D tr->next)
     {
-        links =3D 0;
+        int lin=
ks =3D 0;
 
         /* loop through each network connections entry in the =
control panel */
         for (pr =3D panel_reg; pr !=3D NULL; pr =3D pr->n=
ext)
@@ -4110,10 +4107,11 @@
 {
     ULONG size =3D 0;
     IP_PER_ADAPTER_=
INFO *pi =3D NULL;
-    DWORD status;
 
     if (index !=3D TUN_ADAPTER_IND=
EX_INVALID)
     {
+        DWORD status;
+
         if ((status =3D GetPer=
AdapterInfo(index, NULL, &size)) !=3D ERROR_BUFFER_OVERFLOW)
         {
   =
          msg(M_INFO, "GetPerAdapterInfo #1 failed (status=3D%lu) : %s", st=
atus,
@@ -4308,7 +4306,6 @@
 bool
 is_adapter_up(const struct tuntap *tt, c=
onst IP_ADAPTER_INFO *list)
 {
-    int i;
     bool ret =3D false;
 
     =
const IP_ADAPTER_INFO *ai =3D get_tun_adapter(tt, list);
@@ -4318,7 +4315,7=
 @@
         const int n =3D get_adapter_n_ip_netmask(ai);
 
         /* lo=
op once for every IP/netmask assigned to adapter */
-        for (i =3D 0; =
i < n; ++i)
+        for (int i =3D 0; i < n; ++i)
         {
             =
in_addr_t ip, netmask;
             if (get_adapter_ip_netmask(ai, i, &ip, =
&netmask))
@@ -4352,7 +4349,6 @@
 bool
 is_ip_in_adapter_subnet(const IP_AD=
APTER_INFO *ai, const in_addr_t ip, in_addr_t *highest_netmask)
 {
-    int=
 i;
     bool ret =3D false;
 
     if (highest_netmask)
@@ -4363,7 +4359,7=
 @@
     if (ai)
     {
         const int n =3D get_adapter_n_ip_netmask(a=
i);
-        for (i =3D 0; i < n; ++i)
+        for (int i =3D 0; i < n; ++=
i)
         {
             in_addr_t adapter_ip, adapter_netmask;
         =
    if (get_adapter_ip_netmask(ai, i, &adapter_ip, &adapter_netmask))
diff =
--git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index 4c511a9=2E=2Efd=
e6412 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -10=
42,7 +1042,6 @@
 openvpn_execve(const struct argv *a, const struct env_set =
*es, const unsigned int flags)
 {
     int ret =3D OPENVPN_EXECVE_ERROR;
- =
   static bool exec_warn =3D false;
 
     if (a && a->argv[0])
     {
@@ -=
1093,6 +1092,8 @@
         }
         else
         {
+            static b=
ool exec_warn =3D false;
+
             ret =3D OPENVPN_EXECVE_NOT_ALLOWED;=

             if (!exec_warn && (script_security() < SSEC_SCRIPTS))
       =
      {
@@ -1489,11 +1490,10 @@
 static void
 set_openssl_env_vars(void)
 {=

-    const WCHAR *ssl_fallback_dir =3D L"C:\\Windows\\System32";
-
     WC=
HAR install_path[MAX_PATH] =3D { 0 };
     if (!get_openvpn_reg_value(NULL,=
 install_path, _countof(install_path)))
     {
+        const WCHAR *ssl_fa=
llback_dir =3D L"C:\\Windows\\System32";
         /* if we cannot find inst=
allation path from the registry,
          * use Windows directory as a fal=
lback
          */
diff --git a/src/openvpnserv/common=2Ec b/src/openvpnser=
v/common=2Ec
index cce5318=2E=2E7a23d41 100644
--- a/src/openvpnserv/common=
=2Ec
+++ b/src/openvpnserv/common=2Ec
@@ -254,10 +254,8 @@
 MsgToEventLog(D=
WORD flags, LPCWSTR format, =2E=2E=2E)
 {
     HANDLE hEventSource;
-    WC=
HAR msg[2][256];
     DWORD error =3D 0;
     LPCWSTR err_msg =3D L"";
-   =
 va_list arglist;
 
     if (flags & MSG_FLAGS_SYS_CODE)
     {
@@ -268,6 +=
266,9 @@
     hEventSource =3D RegisterEventSource(NULL, APPNAME);
     if =
(hEventSource !=3D NULL)
     {
+        va_list arglist;
+        WCHAR ms=
g[2][256];
+
         swprintf(msg[0], _countof(msg[0]), L"%ls%ls%ls: %ls",=
 APPNAME, service_instance,
                  (flags & MSG_FLAGS_ERROR) ? L=
" error" : L"", err_msg);
 
@@ -311,10 +312,10 @@
 const wchar_t *
 get_win=
_sys_path(void)
 {
-    const wchar_t *default_sys_path =3D L"C:\\Windows\\=
system32";
-
     if (!GetSystemDirectoryW(win_sys_path, _countof(win_sys_p=
ath)))
     {
+        const wchar_t *default_sys_path =3D L"C:\\Windows\\s=
ystem32";
+
         wcscpy_s(win_sys_path, _countof(win_sys_path), default=
_sys_path);
         win_sys_path[_countof(win_sys_path) - 1] =3D L'\0';
  =
   }
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interac=
tive=2Ec
index 026d5aa=2E=2Ed8cf6e1 100644
--- a/src/openvpnserv/interactiv=
e=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -933,7 +933,6 @@
 RegisterDN=
S(LPVOID unused)
 {
     DWORD err;
-    size_t i;
     DWORD timeout =3D R=
DNS_TIMEOUT * 1000; /* in milliseconds */
 
     /* path of ipconfig comman=
d */
@@ -956,7 +955,7 @@
     if (WaitForMultipleObjects(2, wait_handles, F=
ALSE, timeout) =3D=3D WAIT_OBJECT_0)
     {
         /* Semaphore locked */=

-        for (i =3D 0; i < _countof(cmds); ++i)
+        for (size_t i =3D=
 0; i < _countof(cmds); ++i)
         {
             ExecCommand(cmds[i]=2E=
argv0, cmds[i]=2Ecmdline, cmds[i]=2Etimeout);
         }
diff --git a/src/o=
penvpnserv/service=2Ec b/src/openvpnserv/service=2Ec
index 04b20d7=2E=2E291=
3f63 100644
--- a/src/openvpnserv/service=2Ec
+++ b/src/openvpnserv/service=
=2Ec
@@ -21,7 +21,6 @@
 BOOL
 ReportStatusToSCMgr(SERVICE_STATUS_HANDLE ser=
vice, SERVICE_STATUS *status)
 {
-    static DWORD dwCheckPoint =3D 1;
    =
 BOOL res =3D TRUE;
 
     if (status->dwCurrentState =3D=3D SERVICE_START_=
PENDING)
@@ -39,6 +38,7 @@
     }
     else
     {
+        static DWORD dw=
CheckPoint =3D 1;
         status->dwCheckPoint =3D dwCheckPoint++;
     }
=
 
@@ -55,7 +55,6 @@
 static int
 CmdInstallServices(void)
 {
-    SC_HANDLE=
 service;
     SC_HANDLE svc_ctl_mgr;
     WCHAR path[512];
     int i, ret=
 =3D _service_max;
@@ -78,7 +77,7 @@
 
     for (i =3D 0; i < _service_max;=
 i++)
     {
-        service =3D CreateService(
+        SC_HANDLE service=
 =3D CreateService(
             svc_ctl_mgr, openvpn_service[i]=2Ename, op=
envpn_service[i]=2Edisplay_name,
             SERVICE_QUERY_STATUS, SERVICE=
_WIN32_SHARE_PROCESS, openvpn_service[i]=2Estart_type,
             SERVICE=
_ERROR_NORMAL, path, NULL, NULL, openvpn_service[i]=2Edependencies, NULL, N=
ULL);
diff --git a/tests/unit_tests/openvpn/test_provider=2Ec b/tests/unit_=
tests/openvpn/test_provider=2Ec
index 5619f36=2E=2Ee5562ee 100644
--- a/tes=
ts/unit_tests/openvpn/test_provider=2Ec
+++ b/tests/unit_tests/openvpn/test=
_provider=2Ec
@@ -378,12 +378,11 @@
 static void
 xkey_provider_test_generi=
c_sign_cb(void **state)
 {
-    EVP_PKEY *pubkey;
     const char *dummy =
=3D "xkey_handle"; /* a dummy handle for the external key */
 
     for (si=
ze_t i =3D 0; i < _countof(pubkeys); i++)
     {
-        pubkey =3D load_p=
ubkey(pubkeys[i]);
+        EVP_PKEY *pubkey =3D load_pubkey(pubkeys[i]);
 =
        assert_non_null(pubkey);
 
         EVP_PKEY *privkey =3D

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1963?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib69b6c7a5f21f8552159c945=
60830f182c6238b7
Gerrit-Change-Number: 1963
Gerrit-PatchSet: 2
Gerrit-Owner=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld=
 <frank@lichtenheld=2Ecom>

--Mc7fsipW0qM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1963?usp=3Demail">View Change</a></p><p=
>The change is no longer submittable: checks~ChecksSubmitRule is unsatisfie=
d now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">Fix (almost) all occurrences of cppcheck variable=
Scope<br><br>In two cases I found the code change too ugly and added<br>a s=
uppression=2E In most cases the change is trivially<br>correct (as long as =
it builds)=2E<br><br>Some drive-by style fixes, and marked some of the move=
d<br>variables const as appropriate=2E<br><br>Change-Id: Ib69b6c7a5f21f8552=
159c94560830f182c6238b7<br>Signed-off-by: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt;<br>---<br>M dev-tools/cppcheck-suppressions=2Exml<br>M sam=
ple/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec=
<br>M sample/sample-plugins/log/log_v3=2Ec<br>M src/openvpn/buffer=2Ec<br>M=
 src/openvpn/clinat=2Ec<br>M src/openvpn/console_builtin=2Ec<br>M src/openv=
pn/crypto=2Ec<br>M src/openvpn/crypto_epoch=2Ec<br>M src/openvpn/dco_freebs=
d=2Ec<br>M src/openvpn/dhcp=2Ec<br>M src/openvpn/env_set=2Ec<br>M src/openv=
pn/forward=2Ec<br>M src/openvpn/httpdigest=2Ec<br>M src/openvpn/manage=2Ec<=
br>M src/openvpn/misc=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/netwo=
rking_sitnl=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options_parse=
=2Ec<br>M src/openvpn/packet_id=2Ec<br>M src/openvpn/platform=2Ec<br>M src/=
openvpn/pool=2Ec<br>M src/openvpn/proto=2Ec<br>M src/openvpn/push=2Ec<br>M =
src/openvpn/route=2Ec<br>M src/openvpn/run_command=2Ec<br>M src/openvpn/sip=
hash_reference=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_op=
enssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_verify_mbedtls=
=2Ec<br>M src/openvpn/tun=2Ec<br>M src/openvpn/win32=2Ec<br>M src/openvpnse=
rv/common=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M src/openvpnserv/ser=
vice=2Ec<br>M tests/unit_tests/openvpn/test_provider=2Ec<br>37 files change=
d, 108 insertions(+), 134 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1963/2</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-supp=
ressions=2Exml</span><br><span>index 38de5f2a=2E=2Ebd24c3b 100644</span><br=
><span>--- a/dev-tools/cppcheck-suppressions=2Exml</span><br><span>+++ b/de=
v-tools/cppcheck-suppressions=2Exml</span><br><span>@@ -14,9 +14,6 @@</span=
><br><span>   &lt;suppress&gt;</span><br><span>     &lt;id&gt;usleepCalled&=
lt;/id&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  &lt;suppress&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &lt;id&gt;variableScope&lt;/id&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  &lt;/suppress&gt;</span><br><span=
>   &lt;!-- We have a lot of library includes, not all of them are really r=
equired,</span><br><span>        so ignore them --&gt;</span><br><span>   &=
lt;suppress&gt;</span><br><span>@@ -288,4 +285,15 @@</span><br><span>     &=
lt;id&gt;unusedStructMember&lt;/id&gt;</span><br><span>     &lt;fileName&gt=
;tests/unit_tests/openvpn/test_pkcs11=2Ec&lt;/fileName&gt;</span><br><span>=
   &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  &lt;!-- IGN: nicer --&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &lt;id&gt;variableScope&lt;/id&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpnserv/interactive=
=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &lt;symbolName&gt;cmds&lt;/symbolName&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &lt;id&gt;variableScope&lt;/id&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openv=
pnserv/interactive=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &lt;symbolName&gt;sys_key&lt;/symbolName&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span>=
<br><span> &lt;/suppressions&gt;</span><br><span>diff --git a/sample/sample=
-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec b/sample/=
sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec</sp=
an><br><span>index 512861a=2E=2E2474bf1 100644</span><br><span>--- a/sample=
/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec</s=
pan><br><span>+++ b/sample/sample-plugins/keying-material-exporter-demo/key=
ingmaterialexporter=2Ec</span><br><span>@@ -120,13 +120,14 @@</span><br><sp=
an>     ASN1_OBJECT *fn;</span><br><span>     ASN1_STRING *val;</span><br><=
span>     X509_NAME *x509_name;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    X509_NAME_ENTRY *ent;</span><br><span>     const char *objbuf=
;</span><br><span> </span><br><span>     x509_name =3D X509_get_subject_nam=
e(x509);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i, n =
=3D X509_NAME_entry_count(x509_name);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int n =3D X509_NAME_entry_count(x509_name)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D=
 0; i &lt; n; ++i)</span><br><span>     {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        X509_NAME_ENTRY *ent;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (!(ent =3D X=
509_NAME_get_entry(x509_name, i)))</span><br><span>         {</span><br><sp=
an>             continue;</span><br><span>diff --git a/sample/sample-plugin=
s/log/log_v3=2Ec b/sample/sample-plugins/log/log_v3=2Ec</span><br><span>ind=
ex 09c6735=2E=2E1c781a3 100644</span><br><span>--- a/sample/sample-plugins/=
log/log_v3=2Ec</span><br><span>+++ b/sample/sample-plugins/log/log_v3=2Ec</=
span><br><span>@@ -197,7 +197,6 @@</span><br><span>     ASN1_OBJECT *fn;</s=
pan><br><span>     ASN1_STRING *val;</span><br><span>     X509_NAME *x509_n=
ame;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    X509_NAME_ENT=
RY *ent;</span><br><span>     const char *objbuf;</span><br><span>     unsi=
gned char *buf =3D NULL;</span><br><span> </span><br><span>@@ -205,7 +204,7=
 @@</span><br><span>     n =3D X509_NAME_entry_count(x509_name);</span><br>=
<span>     for (i =3D 0; i &lt; n; ++i)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        ent =3D X509_NAME_get_entr=
y(x509_name, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     X509_NAME_ENTRY *ent =3D X509_NAME_get_entry(x509_name, i);</span><br>=
<span>         if (!ent)</span><br><span>         {</span><br><span>       =
      continue;</span><br><span>diff --git a/src/openvpn/buffer=2Ec b/src/o=
penvpn/buffer=2Ec</span><br><span>index 21e113d=2E=2E8f558b1 100644</span><=
br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buf=
fer=2Ec</span><br><span>@@ -228,13 +228,13 @@</span><br><span>     int ret =
=3D false;</span><br><span>     if (buf_defined(buf))</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        va_list argl=
ist;</span><br><span>         uint8_t *ptr =3D BEND(buf);</span><br><span> =
        int cap =3D buf_forward_capacity(buf);</span><br><span> </span><br>=
<span>         if (cap &gt; 0)</span><br><span>         {</span><br><span> =
            int stat;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            va_list arglist;</span><br><span>             va_start(arglis=
t, format);</span><br><span>             stat =3D vsnprintf((char *)ptr, ca=
p, format, arglist);</span><br><span>             va_end(arglist);</span><b=
r><span>diff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec</span>=
<br><span>index 9fa8f5f=2E=2Ed72d42a 100644</span><br><span>--- a/src/openv=
pn/clinat=2Ec</span><br><span>+++ b/src/openvpn/clinat=2Ec</span><br><span>=
@@ -50,12 +50,11 @@</span><br><span> print_client_nat_list(const struct cli=
ent_nat_option_list *list, msglvl_t msglevel)</span><br><span> {</span><br>=
<span>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    int i;</span><br><span> </span><br><span>     msg=
(msglevel, &quot;*** CNAT list&quot;);</span><br><span>     if (list)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    for (i =3D 0; i &lt; list-&gt;n; ++i)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; list-&gt;n; ++i)</sp=
an><br><span>         {</span><br><span>             const struct client_na=
t_entry *e =3D &amp;list-&gt;entries[i];</span><br><span>             msg(m=
sglevel, &quot;  CNAT[%d] t=3D%d %s/%s/%s&quot;, i, e-&gt;type,</span><br><=
span>diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/console_bui=
ltin=2Ec</span><br><span>index 9c8d72a=2E=2Ecf6cc37 100644</span><br><span>=
--- a/src/openvpn/console_builtin=2Ec</span><br><span>+++ b/src/openvpn/con=
sole_builtin=2Ec</span><br><span>@@ -77,7 +77,6 @@</span><br><span>     boo=
l is_console =3D (GetFileType(in) =3D=3D FILE_TYPE_CHAR);</span><br><span> =
    DWORD flags_save =3D 0;</span><br><span>     int status =3D 0;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    WCHAR *winput;</span><br><=
span> </span><br><span>     if (is_console)</span><br><span>     {</span><b=
r><span>@@ -100,7 +99,7 @@</span><br><span> </span><br><span>     if (is_co=
nsole)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        winput =3D malloc(capacity * sizeof(WCHAR));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        WCHAR *winput =3D malloc(c=
apacity * sizeof(WCHAR));</span><br><span>         if (winput =3D=3D NULL)<=
/span><br><span>         {</span><br><span>             return false;</span=
><br><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</sp=
an><br><span>index 8196c26=2E=2E3d3ab0c 100644</span><br><span>--- a/src/op=
envpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><sp=
an>@@ -1774,13 +1774,10 @@</span><br><span> static const cipher_name_pair *=
</span><br><span> get_cipher_name_pair(const char *cipher_name)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const ciph=
er_name_pair *pair;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  size_t i =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     /* Search for a cipher name translation */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    for (; i &lt; cipher_name_transl=
ation_table_count; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (size_t i =3D 0; i &lt; cipher_name_translation_table_count; i+=
+)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        pair =3D &amp;cipher_name_translation_table[i];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const cipher_name_pair *pai=
r =3D &amp;cipher_name_translation_table[i];</span><br><span>         if (0=
 =3D=3D strcmp(cipher_name, pair-&gt;openvpn_name)</span><br><span>        =
     || 0 =3D=3D strcmp(cipher_name, pair-&gt;lib_name))</span><br><span>  =
       {</span><br><span>diff --git a/src/openvpn/crypto_epoch=2Ec b/src/op=
envpn/crypto_epoch=2Ec</span><br><span>index 158c841=2E=2E69a1852 100644</s=
pan><br><span>--- a/src/openvpn/crypto_epoch=2Ec</span><br><span>+++ b/src/=
openvpn/crypto_epoch=2Ec</span><br><span>@@ -387,9 +387,6 @@</span><br><spa=
n>     else if (epoch &gt; opt-&gt;key_ctx_bi=2Edecrypt=2Eepoch</span><br><=
span>              &amp;&amp; epoch &lt;=3D opt-&gt;key_ctx_bi=2Edecrypt=2E=
epoch + opt-&gt;epoch_data_keys_future_count)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Key in the range =
of future keys */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    int index =3D epoch - (opt-&gt;key_ctx_bi=2Edecrypt=2Eepoch + 1);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /=
* If we have reached the edge of the valid keys we do not return</span><br>=
<span>          * the key anymore since regenerating the new keys would mov=
e us</span><br><span>          * over the window of valid keys and would ne=
ed all kind of</span><br><span>@@ -400,6 +397,9 @@</span><br><span>        =
 }</span><br><span>         else</span><br><span>         {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            /* Key in the range of =
future keys */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       const int index =3D epoch - (opt-&gt;key_ctx_bi=2Edecrypt=2Eepoch + =
1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>             return &amp;opt-&gt;epoch_data_keys_future[index];</span><br>=
<span>         }</span><br><span>     }</span><br><span>diff --git a/src/op=
envpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br><span>index 7=
346903=2E=2E3148f10 100644</span><br><span>--- a/src/openvpn/dco_freebsd=2E=
c</span><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@@ -444=
,7 +444,6 @@</span><br><span> key_to_nvlist(const uint8_t *key, const uint8=
_t *implicit_iv, const char *ciphername)</span><br><span> {</span><br><span=
>     nvlist_t *nvl;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   size_t key_len;</span><br><span> </span><br><span>     nvl =3D nvlist_cr=
eate(0);</span><br><span> </span><br><span>@@ -452,7 +451,7 @@</span><br><s=
pan> </span><br><span>     if (strcmp(ciphername, &quot;none&quot;) !=3D 0)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        key_len =3D cipher_kt_key_size(ciphername);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const size_t key_len =3D cipher_k=
t_key_size(ciphername);</span><br><span> </span><br><span>         nvlist_a=
dd_binary(nvl, &quot;key&quot;, key, key_len);</span><br><span>         nvl=
ist_add_binary(nvl, &quot;iv&quot;, implicit_iv, 8);</span><br><span>diff -=
-git a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec</span><br><span>index 5c=
dcfcf=2E=2E19e9e2d 100644</span><br><span>--- a/src/openvpn/dhcp=2Ec</span>=
<br><span>+++ b/src/openvpn/dhcp=2Ec</span><br><span>@@ -271,7 +271,6 @@</s=
pan><br><span> {</span><br><span>     char tmp_buf[256];</span><br><span>  =
   size_t len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   size_t label_length_pos;</span><br><span> </span><br><span>     for (int=
 i =3D 0; i &lt; array_len; i++)</span><br><span>     {</span><br><span>@@ =
-290,7 +289,7 @@</span><br><span> </span><br><span>         /* label_length=
_pos points to the byte to be replaced by the length</span><br><span>      =
    * of the following domain label */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        label_length_pos =3D len++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        size_t label_length_pos =3D len++=
;</span><br><span> </span><br><span>         while (true)</span><br><span> =
        {</span><br><span>diff --git a/src/openvpn/env_set=2Ec b/src/openvp=
n/env_set=2Ec</span><br><span>index d992097=2E=2E67a5bf5 100644</span><br><=
span>--- a/src/openvpn/env_set=2Ec</span><br><span>+++ b/src/openvpn/env_se=
t=2Ec</span><br><span>@@ -62,14 +62,13 @@</span><br><span> static bool</spa=
n><br><span> env_string_equal(const char *s1, const char *s2)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int c1, c2;<=
/span><br><span>     ASSERT(s1);</span><br><span>     ASSERT(s2);</span><br=
><span> </span><br><span>     while (true)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        c1 =3D *s1++;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        c2 =3D *s2++;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        int c1 =3D *s1++;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        int c2 =3D *s2+=
+;</span><br><span>         if (c1 =3D=3D &#39;=3D&#39;)</span><br><span>  =
       {</span><br><span>             c1 =3D 0;</span><br><span>@@ -214,12 =
+213,11 @@</span><br><span>     if (check_debug_level(msglevel))</span><br>=
<span>     {</span><br><span>         const struct env_item *e;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><span> <=
/span><br><span>         if (es)</span><br><span>         {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            int i =3D 0;</span><br>=
<span>             e =3D es-&gt;list;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            i =3D 0;</span><br><span> </span><br><span>    =
         while (e)</span><br><span>             {</span><br><span>diff --gi=
t a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index=
 178c43f=2E=2E20b247c 100644</span><br><span>--- a/src/openvpn/forward=2Ec<=
/span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -2056,13 +=
2056,13 @@</span><br><span>     unsigned int socket =3D 0;</span><br><span>=
     unsigned int tuntap =3D 0;</span><br><span>     static uintptr_t tun_s=
hift =3D TUN_SHIFT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  static uintptr_t err_shift =3D ERR_SHIFT;</span><br><span> </span><br><sp=
an>     /*</span><br><span>      * Calculate the flags based on the provide=
d &#39;flags&#39; argument=2E</span><br><span>      */</span><br><span>    =
 if ((c-&gt;options=2Emode !=3D MODE_SERVER) &amp;&amp; (flags &amp; IOW_WA=
IT_SIGNAL))</span><br><span>     {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        static uintptr_t err_shift =3D ERR_SHIFT;</span><br>=
<span>         wait_signal(es, (void *)err_shift);</span><br><span>     }</=
span><br><span> </span><br><span>diff --git a/src/openvpn/httpdigest=2Ec b/=
src/openvpn/httpdigest=2Ec</span><br><span>index ab8a710=2E=2E52df383 10064=
4</span><br><span>--- a/src/openvpn/httpdigest=2Ec</span><br><span>+++ b/sr=
c/openvpn/httpdigest=2Ec</span><br><span>@@ -34,12 +34,9 @@</span><br><span=
> static void</span><br><span> CvtHex(IN HASH Bin, OUT HASHHEX Hex)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsign=
ed short i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsign=
ed char j;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; HASHLEN=
; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (unsi=
gned short i =3D 0; i &lt; HASHLEN; i++)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        j =3D (Bin[i] &gt;&gt; 4)=
 &amp; 0xf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
unsigned char j =3D (Bin[i] &gt;&gt; 4) &amp; 0xf;</span><br><span>        =
 if (j &lt;=3D 9)</span><br><span>         {</span><br><span>             H=
ex[i * 2] =3D (j + &#39;0&#39;);</span><br><span>diff --git a/src/openvpn/m=
anage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 2f1ca95=2E=2E1e74f=
09 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ =
b/src/openvpn/manage=2Ec</span><br><span>@@ -368,7 +368,6 @@</span><br><spa=
n>     {</span><br><span>         struct gc_arena gc =3D gc_new();</span><b=
r><span>         struct log_entry e;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        const char *out =3D NULL;</span><br><span>         u=
nsigned int action_flags =3D 0;</span><br><span> </span><br><span>         =
++recursive_level;</span><br><span>@@ -391,6 +390,8 @@</span><br><span> </s=
pan><br><span>         if (!man_password_needed(man))</span><br><span>     =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            co=
nst char *out =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>             if (flags =3D=3D M_CLIENT)</span><br><spa=
n>             {</span><br><span>                 out =3D log_entry_print(&=
amp;e, LOG_PRINT_CRLF, &amp;gc);</span><br><span>@@ -3036,14 +3037,15 @@</s=
pan><br><span> static void</span><br><span> man_output_peer_info_env(struct=
 management *man, const struct man_def_auth_context *mdac)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char line[256];=
</span><br><span>     if (man-&gt;persist=2Ecallback=2Eget_peer_info)</span=
><br><span>     {</span><br><span>         const char *peer_info =3D</span>=
<br><span>             (*man-&gt;persist=2Ecallback=2Eget_peer_info)(man-&g=
t;persist=2Ecallback=2Earg, mdac-&gt;cid);</span><br><span>         if (pee=
r_info)</span><br><span>         {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            char line[256];</span><br><span>             str=
uct buffer buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>             buf_set_read(&amp;buf, (const uint8_t *)peer_info=
, strlen(peer_info));</span><br><span>             while (buf_parse(&amp;bu=
f, &#39;\n&#39;, line, sizeof(line)))</span><br><span>             {</span>=
<br><span>@@ -3820,13 +3822,12 @@</span><br><span> {</span><br><span>     i=
nt ok;</span><br><span>     char *result =3D NULL;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const struct buffer *buf;</span><br><span>=
 </span><br><span>     ok =3D management_query_multiline(man, b64_data, pro=
mpt, cmd, state, input);</span><br><span>     if (ok &amp;&amp; buffer_list=
_defined(*input))</span><br><span>     {</span><br><span>         buffer_li=
st_aggregate_separator(*input, 10000, &quot;\n&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        buf =3D buffer_list_peek(*input);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct=
 buffer *buf =3D buffer_list_peek(*input);</span><br><span>         if (buf=
 &amp;&amp; BLEN(buf) &gt; 0)</span><br><span>         {</span><br><span>  =
           result =3D (char *)malloc(BLENZ(buf) + 1);</span><br><span>@@ -3=
847,15 +3848,13 @@</span><br><span> management_query_multiline_flatten(stru=
ct management *man, const char *b64_data, const char *prompt,</span><br><sp=
an>                                    const char *cmd, int *state, struct =
buffer_list **input)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    int ok;</span><br><span>     char *result =3D NULL;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const struct buffer=
 *buf;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    ok =3D management_query_multiline(man, b64_data, prompt, cmd, state,=
 input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const i=
nt ok =3D management_query_multiline(man, b64_data, prompt, cmd, state, inp=
ut);</span><br><span>     if (ok &amp;&amp; buffer_list_defined(*input))</s=
pan><br><span>     {</span><br><span>         buffer_list_aggregate(*input,=
 2048);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf =
=3D buffer_list_peek(*input);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        const struct buffer *buf =3D buffer_list_peek(*input);</s=
pan><br><span>         if (buf &amp;&amp; BLEN(buf) &gt; 0)</span><br><span=
>         {</span><br><span>             result =3D (char *)malloc(BLENZ(bu=
f) + 1);</span><br><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/mi=
sc=2Ec</span><br><span>index 54af890=2E=2E6e9591f 100644</span><br><span>--=
- a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><=
br><span>@@ -474,7 +474,7 @@</span><br><span> purge_user_pass(struct user_p=
ass *up, const bool force)</span><br><span> {</span><br><span>     const bo=
ol nocache =3D up-&gt;nocache;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    static bool warn_shown =3D false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>     if (nocache || force)</spa=
n><br><span>     {</span><br><span>         secure_memzero(up, sizeof(*up))=
;</span><br><span>@@ -482,6 +482,8 @@</span><br><span>     }</span><br><spa=
n>     else</span><br><span>     {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        static bool warn_shown =3D false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         protect_user=
_pass(up);</span><br><span>         /*</span><br><span>          * don&#39;=
t show warning if the pass has been replaced by a token: this is an</span><=
br><span>@@ -721,11 +723,10 @@</span><br><span> bool</span><br><span> valid=
ate_peer_info_line(char *line)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    uint8_t c;</span><br><span>     int state =
=3D 0;</span><br><span>     while (*line)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        c =3D *line;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        const uint8_t c =3D *li=
ne;</span><br><span>         switch (state)</span><br><span>         {</spa=
n><br><span>             case 0:</span><br><span>diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 7eb3d77=2E=2E8fba67a=
 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/s=
rc/openvpn/multi=2Ec</span><br><span>@@ -4207,13 +4207,11 @@</span><br><spa=
n> static void</span><br><span> tunnel_server_loop(struct multi_context *mu=
lti)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     while (true)</span><br><span>     {</span><br><span>     =
    /* wait on tun/socket list */</span><br><span>         multi_get_timeou=
t(multi, &amp;multi-&gt;top=2Ec2=2Etimeval);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        status =3D multi_io_wait(multi);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        const int status =3D mu=
lti_io_wait(multi);</span><br><span>         MULTI_CHECK_SIG(multi);</span>=
<br><span> </span><br><span>         /* check on status of coarse timers */=
</span><br><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvp=
n/networking_sitnl=2Ec</span><br><span>index bb29781=2E=2E49de664 100644</s=
pan><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/=
src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -1375,13 +1375,11 @@</s=
pan><br><span> sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, st=
ruct rtattr *rta, size_t len,</span><br><span>                          uns=
igned short flags)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    unsigned short type;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span>     memset(tb, 0, sizeof(struct rtattr=
 *) * (max + 1));</span><br><span> </span><br><span>     while (RTA_OK(rta,=
 len))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        type =3D rta-&gt;rta_type &amp; ~flags;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const unsigned short type =3D r=
ta-&gt;rta_type &amp; ~flags;</span><br><span> </span><br><span>         if=
 ((type &lt;=3D max) &amp;&amp; (!tb[type]))</span><br><span>         {</sp=
an><br><span>@@ -1409,7 +1407,6 @@</span><br><span> static int</span><br><s=
pan> sitnl_type_save(struct nlmsghdr *n, void *arg)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *type =3D arg;</s=
pan><br><span>     struct ifinfomsg *ifi =3D NLMSG_DATA(n);</span><br><span=
>     struct rtattr *tb[IFLA_MAX + 1];</span><br><span> </span><br><span>@@=
 -1418,6 +1415,7 @@</span><br><span>     if (tb[IFLA_LINKINFO])</span><br><=
span>     {</span><br><span>         struct rtattr *tb_link[IFLA_INFO_MAX +=
 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *t=
ype =3D arg;</span><br><span> </span><br><span>         sitnl_parse_rtattr_=
nested(tb_link, IFLA_INFO_MAX, tb[IFLA_LINKINFO]);</span><br><span> </span>=
<br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</s=
pan><br><span>index 5a57c0a=2E=2E1f4b191 100644</span><br><span>--- a/src/o=
penvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br>=
<span>@@ -1019,10 +1019,9 @@</span><br><span> </span><br><span>     for (cu=
rrent =3D *list, prev =3D NULL; current !=3D NULL; current =3D current-&gt;=
next)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        char *tmp_value =3D NULL;</span><br><span>         if (!strn=
cmp(current-&gt;string, &quot;foreign_option_&quot;, sizeof(&quot;foreign_o=
ption_&quot;) - 1))</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            tmp_value =3D strchr(current-&gt;strin=
g, &#39;=3D&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           const char *tmp_value =3D strchr(current-&gt;string, &#39;=3D&#3=
9;);</span><br><span>             if (tmp_value &amp;&amp; ++tmp_value)</sp=
an><br><span>             {</span><br><span>                 if (!strncmp(t=
mp_value, &quot;dhcp-option &quot;, sizeof(&quot;dhcp-option &quot;) - 1))<=
/span><br><span>diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/op=
tions_parse=2Ec</span><br><span>index 0e94522=2E=2E79b8098 100644</span><br=
><span>--- a/src/openvpn/options_parse=2Ec</span><br><span>+++ b/src/openvp=
n/options_parse=2Ec</span><br><span>@@ -351,7 +351,6 @@</span><br><span> {<=
/span><br><span>     const int max_recursive_levels =3D 10;</span><br><span=
>     FILE *fp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t line_num;</span><br><span>     char line[OPTION_LINE_SIZE + 1];</span><br=
><span>     char *p[MAX_PARMS + 1];</span><br><span> </span><br><span>@@ -3=
68,7 +367,7 @@</span><br><span>         }</span><br><span>         if (fp)<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            line_num =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            int line_num =3D 0;</span><br><span>             w=
hile (fgets(line, sizeof(line), fp))</span><br><span>             {</span><=
br><span>                 int offset =3D 0;</span><br><span>diff --git a/sr=
c/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>index 2=
2c53c7=2E=2E50d7c76 100644</span><br><span>--- a/src/openvpn/packet_id=2Ec<=
/span><br><span>+++ b/src/openvpn/packet_id=2Ec</span><br><span>@@ -219,8 +=
219,6 @@</span><br><span> bool</span><br><span> packet_id_test(struct packe=
t_id_rec *p, const struct packet_id_net *pin)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    uint64_t diff;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     packet_id_deb=
ug(D_PID_DEBUG, p, pin, &quot;PID_TEST&quot;, 0);</span><br><span> </span><=
br><span>     ASSERT(p-&gt;initialized);</span><br><span>@@ -247,7 +245,7 @=
@</span><br><span>             }</span><br><span> </span><br><span>        =
     /* check packet-id sliding window for original/replay status */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            diff =3D p-&gt;i=
d - pin-&gt;id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        const uint64_t diff =3D p-&gt;id - pin-&gt;id;</span><br><span> </s=
pan><br><span>             /* keep track of maximum backtrack seen for debu=
gging purposes */</span><br><span>             if (diff &gt; p-&gt;max_back=
track_stat)</span><br><span>@@ -512,7 +510,6 @@</span><br><span>     {</spa=
n><br><span>         struct packet_id_persist_file_image image;</span><br><=
span>         CLEAR(image);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        ssize_t n;</span><br><span>         off_t seek_ret;</span><br=
><span>         struct gc_arena gc =3D gc_new();</span><br><span> </span><b=
r><span>@@ -521,7 +518,7 @@</span><br><span>         seek_ret =3D lseek(p-&=
gt;fd, (off_t)0, SEEK_SET);</span><br><span>         if (seek_ret =3D=3D (o=
ff_t)0)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            n =3D write(p-&gt;fd, &amp;image, sizeof(image));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const ss=
ize_t n =3D write(p-&gt;fd, &amp;image, sizeof(image));</span><br><span>   =
          if (n =3D=3D sizeof(image))</span><br><span>             {</span>=
<br><span>                 p-&gt;time_last_written =3D p-&gt;time;</span><b=
r><span>@@ -599,7 +596,6 @@</span><br><span>     {</span><br><span>        =
 char c;</span><br><span>         time_t v;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        int diff;</span><br><span> </span><br><span> =
        v =3D CIRC_LIST_ITEM(sl, i);</span><br><span>         if (v =3D=3D =
SEQ_UNSEEN)</span><br><span>@@ -612,7 +608,7 @@</span><br><span>         }<=
/span><br><span>         else</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            diff =3D (int)(prev_now - v)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const =
int diff =3D (int)(prev_now - v);</span><br><span>             if (diff &lt=
; 0)</span><br><span>             {</span><br><span>                 c =3D =
&#39;N&#39;;</span><br><span>diff --git a/src/openvpn/platform=2Ec b/src/op=
envpn/platform=2Ec</span><br><span>index ccdd43d=2E=2E9412eeb 100644</span>=
<br><span>--- a/src/openvpn/platform=2Ec</span><br><span>+++ b/src/openvpn/=
platform=2Ec</span><br><span>@@ -539,8 +539,6 @@</span><br><span> const cha=
r *</span><br><span> platform_create_temp_file(const char *directory, const=
 char *prefix, struct gc_arena *gc)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int fd;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    const char *retfname =3D NULL;</span><br><span> =
    unsigned int attempts =3D 0;</span><br><span>     char fname[256] =3D {=
 0 };</span><br><span>     const char *fname_fmt =3D PACKAGE &quot;_%=2E*s_=
%08&quot; PRIx64 &quot;%08&quot; PRIx64 &quot;=2Etmp&quot;;</span><br><span=
>@@ -557,7 +555,7 @@</span><br><span>             return NULL;</span><br><s=
pan>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        retfname =3D platform_gen_path(directory, fname, gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *re=
tfname =3D platform_gen_path(directory, fname, gc);</span><br><span>       =
  if (!retfname)</span><br><span>         {</span><br><span>             ms=
g(M_WARN, &quot;Failed to create temporary filename and path&quot;);</span>=
<br><span>@@ -566,7 +564,7 @@</span><br><span> </span><br><span>         /*=
 Atomically create the file=2E  Errors out if the file already</span><br><s=
pan>          * exists=2E  */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        fd =3D platform_open(retfname, O_CREAT | O_EXCL | O_WRONLY,=
 S_IRUSR | S_IWUSR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        const int fd =3D platform_open(retfname, O_CREAT | O_EXCL | O_WRON=
LY, S_IRUSR | S_IWUSR);</span><br><span>         if (fd !=3D -1)</span><br>=
<span>         {</span><br><span>             close(fd);</span><br><span>di=
ff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><span>inde=
x 80dec6c=2E=2E63fc930 100644</span><br><span>--- a/src/openvpn/pool=2Ec</s=
pan><br><span>+++ b/src/openvpn/pool=2Ec</span><br><span>@@ -494,22 +494,21=
 @@</span><br><span>         for (i =3D 0; i &lt; pool-&gt;size; ++i)</span=
><br><span>         {</span><br><span>             const struct ifconfig_po=
ol_entry *e =3D &amp;pool-&gt;list[i];</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            struct in6_addr ip6;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            in_addr_t ip;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            const char *ip6_str =3D &quot;&=
quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            con=
st char *ip_str =3D &quot;&quot;;</span><br><span> </span><br><span>       =
      if (e-&gt;common_name)</span><br><span>             {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                const char *ip6_str=
 =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               const char *ip_str =3D &quot;&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>                 if (poo=
l-&gt;ipv4=2Eenabled)</span><br><span>                 {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    ip =3D ifconfig_pool=
_handle_to_ip_base(pool, i);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    const in_addr_t ip =3D ifconfig_pool_handle_to=
_ip_base(pool, i);</span><br><span>                     ip_str =3D print_in=
_addr_t(ip, 0, &amp;gc);</span><br><span>                 }</span><br><span=
> </span><br><span>                 if (pool-&gt;ipv6=2Eenabled)</span><br>=
<span>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    ip6 =3D ifconfig_pool_handle_to_ipv6_base(pool, i);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
const struct in6_addr ip6 =3D ifconfig_pool_handle_to_ipv6_base(pool, i);</=
span><br><span>                     ip6_str =3D print_in6_addr(ip6, 0, &amp=
;gc);</span><br><span>                 }</span><br><span> </span><br><span>=
diff --git a/src/openvpn/proto=2Ec b/src/openvpn/proto=2Ec</span><br><span>=
index 785c021=2E=2E2cdb147 100644</span><br><span>--- a/src/openvpn/proto=
=2Ec</span><br><span>+++ b/src/openvpn/proto=2Ec</span><br><span>@@ -39,7 +=
39,6 @@</span><br><span> is_ipv_X(int tunnel_type, struct buffer *buf, int =
ip_ver)</span><br><span> {</span><br><span>     int offset;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    uint16_t proto;</span><br><span> =
    const struct openvpn_iphdr *ih;</span><br><span> </span><br><span>     =
verify_align_4(buf);</span><br><span>@@ -61,7 +60,7 @@</span><br><span>    =
     eh =3D (const struct openvpn_ethhdr *)BPTR(buf);</span><br><span> </sp=
an><br><span>         /* start by assuming this is a standard Eth fram */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        proto =3D eh-&g=
t;proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uin=
t16_t proto =3D eh-&gt;proto;</span><br><span>         offset =3D sizeof(st=
ruct openvpn_ethhdr);</span><br><span> </span><br><span>         /* if this=
 is a 802=2E1q frame, parse the header using the according</span><br><span>=
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>in=
dex a514d92a=2E=2E8dfe0d5 100644</span><br><span>--- a/src/openvpn/push=2Ec=
</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -1155,7 +115=
5,6 @@</span><br><span>         while (e)</span><br><span>         {</span>=
<br><span>             char *p[MAX_PARMS + 1];</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            bool enable =3D true;</span><br><span>=
 </span><br><span>             /* parse the push item */</span><br><span>  =
           CLEAR(p);</span><br><span>@@ -1163,6 +1162,8 @@</span><br><span>=
                 &amp;&amp; parse_line(e-&gt;option, p, SIZE(p) - 1, &quot;=
[PUSH_ROUTE_REMOVE]&quot;, 1, D_ROUTE_DEBUG,</span><br><span>              =
                 &amp;gc))</span><br><span>             {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                bool enable =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
               /* is the push item a route directive? */</span><br><span>  =
               if (p[0] &amp;&amp; !strcmp(p[0], &quot;route&quot;) &amp;&a=
mp; !p[3] &amp;&amp; o-&gt;iroutes)</span><br><span>                 {</spa=
n><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</spa=
n><br><span>index b8bac7a=2E=2E4830a5b 100644</span><br><span>--- a/src/ope=
nvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>=
@@ -2773,7 +2773,6 @@</span><br><span> {</span><br><span>     struct gc_are=
na gc =3D gc_new();</span><br><span>     bool ret =3D false;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    DWORD status;</span><br><span>  =
   const DWORD if_index =3D windows_route_find_if_index(r, tt);</span><br><=
span> </span><br><span>     if (if_index !=3D TUN_ADAPTER_INDEX_INVALID)</s=
pan><br><span>@@ -2787,8 +2786,7 @@</span><br><span>         fr=2EdwForward=
NextHop =3D htonl(r-&gt;gateway);</span><br><span>         fr=2EdwForwardIf=
Index =3D if_index;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        status =3D DeleteIpForwardEntry(&amp;fr);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const DWORD status =3D DeleteIpForwardEntr=
y(&amp;fr);</span><br><span>         if (status =3D=3D NO_ERROR)</span><br>=
<span>         {</span><br><span>             ret =3D true;</span><br><span=
>@@ -3826,12 +3824,11 @@</span><br><span> bool</span><br><span> netmask_to_=
netbits(const in_addr_t network, const in_addr_t netmask, int *netbits)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t i;</span><br><span>     const int addrlen =3D sizeof(in_addr_t) * 8;</spa=
n><br><span> </span><br><span>     if ((network &amp; netmask) =3D=3D netwo=
rk)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        for (i =3D 0; i &lt;=3D addrlen; ++i)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt;=3D addrlen;=
 ++i)</span><br><span>         {</span><br><span>             in_addr_t mas=
k =3D netbits_to_netmask(i);</span><br><span>             if (mask =3D=3D n=
etmask)</span><br><span>diff --git a/src/openvpn/run_command=2Ec b/src/open=
vpn/run_command=2Ec</span><br><span>index 905caa3=2E=2E0e36dad 100644</span=
><br><span>--- a/src/openvpn/run_command=2Ec</span><br><span>+++ b/src/open=
vpn/run_command=2Ec</span><br><span>@@ -176,14 +176,13 @@</span><br><span> =
#if defined(ENABLE_FEATURE_EXECVE)</span><br><span>         if (openvpn_exe=
cve_allowed(flags))</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            const char *cmd =3D a-&gt;argv[0];</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            char *const *=
argv =3D a-&gt;argv;</span><br><span>             char *const *envp =3D (ch=
ar *const *)make_env_array(es, true, &amp;gc);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            pid_t pid;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            pid =3D fork();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            const pid_t=
 pid =3D fork();</span><br><span>             if (pid =3D=3D (pid_t)0) /* c=
hild side */</span><br><span>             {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                const char *cmd =3D a-&gt;argv[0];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                char=
 *const *argv =3D a-&gt;argv;</span><br><span>                 execve(cmd, =
argv, envp);</span><br><span>                 exit(OPENVPN_EXECVE_FAILURE);=
</span><br><span>             }</span><br><span>@@ -283,17 +282,17 @@</span=
><br><span>         static bool warn_shown =3D false;</span><br><span>     =
    if (script_security() &gt;=3D SSEC_BUILT_IN)</span><br><span>         {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const cha=
r *cmd =3D a-&gt;argv[0];</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            char *const *argv =3D a-&gt;argv;</span><br><span>         =
    char *const *envp =3D (char *const *)make_env_array(es, true, &amp;gc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pid_t pid=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const =
char *cmd =3D a-&gt;argv[0];</span><br><span>             int pipe_stdout[2=
];</span><br><span> </span><br><span>             if (pipe(pipe_stdout) =3D=
=3D 0)</span><br><span>             {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                pid =3D fork();</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                if (pid =3D=3D (pid_t)0)       /*=
 child side */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           const pid_t pid =3D fork();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                if (pid =3D=3D (pid_t)0) /* child side *=
/</span><br><span>                 {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    char *const *argv =3D a-&gt;argv;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>       =
              close(pipe_stdout[0]); /* Close read end */</span><br><span> =
                    dup2(pipe_stdout[1], 1);</span><br><span>              =
       execve(cmd, argv, envp);</span><br><span>diff --git a/src/openvpn/si=
phash_reference=2Ec b/src/openvpn/siphash_reference=2Ec</span><br><span>ind=
ex 5f0adb9=2E=2E9240ab0 100644</span><br><span>--- a/src/openvpn/siphash_re=
ference=2Ec</span><br><span>+++ b/src/openvpn/siphash_reference=2Ec</span><=
br><span>@@ -113,7 +113,6 @@</span><br><span>     uint64_t v3 =3D UINT64_C(=
0x7465646279746573);</span><br><span>     uint64_t k0 =3D U8TO64_LE(kk);</s=
pan><br><span>     uint64_t k1 =3D U8TO64_LE(kk + 8);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint64_t m;</span><br><span>     int i;=
</span><br><span>     const unsigned char *end =3D ni + inlen - (inlen % si=
zeof(uint64_t));</span><br><span>     const int left =3D inlen &amp; 7;</sp=
an><br><span>@@ -130,7 +129,7 @@</span><br><span> </span><br><span>     for=
 (; ni !=3D end; ni +=3D 8)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        m =3D U8TO64_LE(ni);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        uint64_t m =3D U8TO64_LE(ni);=
</span><br><span>         v3 ^=3D m;</span><br><span> </span><br><span>    =
     TRACE;</span><br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/=
openvpn/ssl_mbedtls=2Ec</span><br><span>index cddf856=2E=2Eb60a8f0 100644</=
span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/=
openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -1014,12 +1014,12 @@</span><br><=
span> tls_ctx_personalise_random(struct tls_root_ctx *ctx)</span><br><span>=
 {</span><br><span> #if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    static char old_sha256_hash[32=
] =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsig=
ned char sha256_hash[32] =3D { 0 };</span><br><span>     mbedtls_ctr_drbg_c=
ontext *cd_ctx =3D rand_ctx_get();</span><br><span> </span><br><span>     i=
f (NULL !=3D ctx-&gt;crt_chain)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        static char old_sha256_hash[32] =
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

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1963 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>

</body></html>
--Mc7fsipW0qM=--


--===============4077185561162699874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4077185561162699874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4077185561162699874==--

