Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86CCCA5FED
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T5FJSqKZwCSHqZFgUd3fCK8RDmnfNksnKB4Oqjic09g=; b=A92OaHFJURksdDymHbYWP8uDnt
	7UXjg1PLgvmOEOKuBVDlPXm05Nzy0DKILQOKitEUgN8SpUzB/6v3DLbK4in8Cgo0BwZNB7ZLU6CJ0
	D0HcCOyF6HsMONPUqoKk3b2hiBkuHm9E9mxoJL/hs8pmmCEVYOShVR3MR/1Ezwulr8fM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCzmN-000310-AN;
	Sat, 03 Oct 2026 13:27:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xCzmJ-00030g-Eb
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 13:27:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vnvJNB7IYkL/TzOn7H3gh1yM+tEKAt83J2FcXKTUrHg=; b=AWk+n2eOFK0n4jmrMn9aslbrsH
 LW8yBnn1ef+QFRX+NZiAjvKJGJNzHMfVZ1w553gKHEKcfUGG3elUuXaAeQGtvUunapIIWFUHqxsZI
 A1o1camzujOIsxxaa3h+RVDQPMvCH/4uENJjHaVAR99tonDlG5KNwi7nK+KliMwNWLt4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vnvJNB7IYkL/TzOn7H3gh1yM+tEKAt83J2FcXKTUrHg=; b=l
 SlpxRtnnO3G0kr0Bb5q4Brm2EijucvfEUTBpMnjv3dIIGqdhoEw4AJ1eraxiIIzu+wjsLLj+bVUyW
 Z56djIcvtbuROSUX+QbD+o6UrSKu5PSKyjgBB41YypDnLb0W127+QU5oJ28belowenFgweZcPcR+z
 c34VTaQ3RAFdUiPo=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xCzlz-0002au-1e for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 13:27:38 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a022e9cbebso5281985e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 03 Oct 2026 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791034044; x=1791638844; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vnvJNB7IYkL/TzOn7H3gh1yM+tEKAt83J2FcXKTUrHg=;
 b=S84Pyd+/5ior30ANF1kH97zpG3Ub9b9WycLc8DZelCwLP4k+KTSaVBEqzaZvhnlOOA
 1pUEGM9JuqQW/F6MKvGt0tAn3eX6jjbBD6Jn2j16+DJ78JhyHak7DqMdb7Ua3pnmsAKL
 +VrWHTlx+cAE+iNw4PFIW9uMBzuokoUeNDek/mf/8CbpBEt/xsEytN/3VzPJhjSOg9t1
 LB3M3Z54cRveHNH0csmuwTH+bNpNSVd/X6ea6pu00AFn19y1KkgCUObmmjqbeUXvQYaT
 hawJ4XNgSpckNJbFHwaBSK4CyTBNF3Chttoj5VlxRBKT+TKmOYcp/x/3u6a++KUwUWaJ
 CEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034044; x=1791638844;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vnvJNB7IYkL/TzOn7H3gh1yM+tEKAt83J2FcXKTUrHg=;
 b=c5669cC5gcPoTXK1EetJ4U6yvHOnI09Mgv4Z6MzyDGrsUuUUA4p9RSBG5/JF8U+aZU
 puM2CuoAkc+pBh33Xo4B6MuXiW+htUjOHQtMR0viXhxXJ6mYgiBRyDZB5XETKQ+5WmJQ
 td9O2+26UKnVrjiHFJOlwuak3pDRiW7Rb5Ofy/CHnlhy2wXD7ZF/VVJfG8ejwoEq9dYj
 MCxz7ELf7tkj6z4YyHTKIfV9BjoeUhIRzBHl/qcju8m0z/azCc6lAxJBzBWajqM++C9R
 ASWkuoEb2M0P9MFEFzfhph5WReXARWhftJrCWEFgr5cbm+89W1pq1X2TA3ga2hAF53KR
 SmPg==
X-Gm-Message-State: AFuF++kw1RmEjer5+xdG6m9Laj0eZvFfKFyCT5p9JXrFPot2DAB8sUsf
 a1dj88wPEyf84AEHd4ur5tpjUjZXG/igTQY1QNq3ZexCAq+5Ix5SeDrt9SfpJvr2zZ9PB/+VK44
 cYldWz49lno67y7+jwPg8nPbJpNPAgCY3ExYZ9AQ4Mx0zCfwlGwssoE/eQKtKJIf/E0YH
X-Gm-Gg: AYBFou19Z72L3MJ5V31v2Tj1nTeWSVTkfgjyMQi2bjQVeAlBdlIrXdN98JQgc+b7FN8
 /Or1TSuAFJzD8d6MbwaAzt7OIXwtXHmJF9ulXTsWixAG1+0R7r/xI20JtulBJVLww2be5XB6ma2
 xOLsPV93boURxOuShXX/GK6gNxMAy1B6MisYoERxUn/WD2v4P2CdIe91BVzcEYKOSlSOj0QvTJ6
 ArZiWgBKcLFnkHlFrfnkME1FJQpFut902HRsLPYvbILHjUoDGolCyXsaZHlK53nZIctSY3qffan
 wM3KUt9GGD4/QeBe84DlFNpJq6SXictlSvHBjDGZuOzzdOX2D5yUhwAyC+26yZUDT2red4SkCXh
 /X7SUT+QyE6fXWeTSkRbAl3hpm1Og1XUiRn5CV750w/y8OIcNXlyX9eAD3qQHZBG52IK3LJnycs
 VPRSGwb1YKABuy8ChGbuiIqBkIntrl+BBTw4cYqoGXaDSxMR11Df2vLfkZFQU2cTsohgP3tV8ZW
 F2maHJb0atV4+nCYulkbfPmLFHLsUkVta6b2Rl1/W2Y7jMYY80OFgWzWyBmVNeCBEpDWOdlVyHN
 9oglxH2qlEeoff9f1WtBoz+/TZgB7y3F1iy4zvg5olMqpKzaO70rxaKIdMcu
X-Received: by 2002:a05:600c:4505:b0:4a1:62b8:9e8c with SMTP id
 5b1f17b1804b1-4a162b8ae34mr63008495e9.33.1791034043896; 
 Sat, 03 Oct 2026 06:27:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm13619943f8f.30.2026.10.03.06.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 06:27:23 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 3 Oct 2026 13:27:20 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7
X-Gerrit-Change-Number: 1963
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1963?usp=email>
X-Gerrit-Commit: 702d298a0a594148981196bc484501864cbfa410
In-Reply-To: <gerrit.1790613679000.Ib69b6c7a5f21f8552159c94560830f182c6238b7@gerrit.openvpn.net>
References: <gerrit.1790613679000.Ib69b6c7a5f21f8552159c94560830f182c6238b7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEzNjc5MDAwLkliNjliNmM3YTVmMjFmODU1MjE1OWM5NDU2MDgzMGYxODJjNjIzOGI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <086c79fc121842c4bb28af815c54a61e0560f75e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xCzlz-0002au-1e
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4545417144211296646=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4545417144211296646==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vIo7nAqsVCw="; charset=UTF-8

--vIo7nAqsVCw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
963?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: Fix (almost) all occ=
urrences of cppcheck variableScope
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Fix (almost) all occurrences of cppcheck variableSco=
pe

In two cases I found the code change too ugly and added
a suppression=
=2E In most cases the change is trivially
correct (as long as it builds)=2E=


Some drive-by style fixes, and marked some of the moved
variables const a=
s appropriate=2E

Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7
Sign=
ed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1963
Message-Id: <20260928210659=2E12780-1-gert@greenie=2Emuc=2Ed=
e>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg39579=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M dev-tools/cppcheck-suppressions=2Exml
M sample/sample-plugins/keyin=
g-material-exporter-demo/keyingmaterialexporter=2Ec
M sample/sample-plugins=
/log/log_v3=2Ec
M src/openvpn/buffer=2Ec
M src/openvpn/clinat=2Ec
M src/ope=
nvpn/console_builtin=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn/crypto_epoc=
h=2Ec
M src/openvpn/dco_freebsd=2Ec
M src/openvpn/dhcp=2Ec
M src/openvpn/en=
v_set=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/httpdigest=2Ec
M src/open=
vpn/manage=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/multi=2Ec
M src/openvpn=
/networking_sitnl=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options_parse=
=2Ec
M src/openvpn/packet_id=2Ec
M src/openvpn/platform=2Ec
M src/openvpn/p=
ool=2Ec
M src/openvpn/proto=2Ec
M src/openvpn/push=2Ec
M src/openvpn/route=
=2Ec
M src/openvpn/run_command=2Ec
M src/openvpn/siphash_reference=2Ec
M sr=
c/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl_p=
kt=2Ec
M src/openvpn/ssl_verify_mbedtls=2Ec
M src/openvpn/tun=2Ec
M src/ope=
nvpn/win32=2Ec
M src/openvpnserv/common=2Ec
M src/openvpnserv/interactive=
=2Ec
M src/openvpnserv/service=2Ec
M tests/unit_tests/openvpn/test_provider=
=2Ec
37 files changed, 108 insertions(+), 134 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1963/4

diff --git =
a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=
=2Exml
index 73dd41b=2E=2Ecd37c41 100644
--- a/dev-tools/cppcheck-suppressi=
ons=2Exml
+++ b/dev-tools/cppcheck-suppressions=2Exml
@@ -23,9 +23,6 @@
   =
<suppress>
     <id>usleepCalled</id>
   </suppress>
-  <suppress>
-    <id=
>variableScope</id>
-  </suppress>
   <!-- We have a lot of library include=
s, not all of them are really required,
        so ignore them -->
   <supp=
ress>
@@ -206,4 +203,15 @@
     <id>unusedStructMember</id>
     <fileName>=
tests/unit_tests/openvpn/test_pkcs11=2Ec</fileName>
   </suppress>
+  <!-- =
IGN: nicer -->
+  <suppress>
+    <id>variableScope</id>
+    <fileName>src=
/openvpnserv/interactive=2Ec</fileName>
+    <symbolName>cmds</symbolName>
=
+  </suppress>
+  <suppress>
+    <id>variableScope</id>
+    <fileName>src=
/openvpnserv/interactive=2Ec</fileName>
+    <symbolName>sys_key</symbolNam=
e>
+  </suppress>
 </suppressions>
diff --git a/sample/sample-plugins/keyin=
g-material-exporter-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins=
/keying-material-exporter-demo/keyingmaterialexporter=2Ec
index 25c9ff5=2E=
=2E204374b 100644
--- a/sample/sample-plugins/keying-material-exporter-demo=
/keyingmaterialexporter=2Ec
+++ b/sample/sample-plugins/keying-material-exp=
orter-demo/keyingmaterialexporter=2Ec
@@ -120,13 +120,14 @@
     ASN1_OBJEC=
T *fn;
     ASN1_STRING *val;
     X509_NAME *x509_name;
-    X509_NAME_ENT=
RY *ent;
     const char *objbuf;
 
     x509_name =3D X509_get_subject_nam=
e(x509);
-    int i, n =3D X509_NAME_entry_count(x509_name);
-    for (i =
=3D 0; i < n; ++i)
+    int n =3D X509_NAME_entry_count(x509_name);
+    fo=
r (int i =3D 0; i < n; ++i)
     {
+        X509_NAME_ENTRY *ent;
+
       =
  if (!(ent =3D X509_NAME_get_entry(x509_name, i)))
         {
            =
 continue;
diff --git a/sample/sample-plugins/log/log_v3=2Ec b/sample/sampl=
e-plugins/log/log_v3=2Ec
index 09c6735=2E=2E1c781a3 100644
--- a/sample/sam=
ple-plugins/log/log_v3=2Ec
+++ b/sample/sample-plugins/log/log_v3=2Ec
@@ -1=
97,7 +197,6 @@
     ASN1_OBJECT *fn;
     ASN1_STRING *val;
     X509_NAME =
*x509_name;
-    X509_NAME_ENTRY *ent;
     const char *objbuf;
     unsign=
ed char *buf =3D NULL;
 
@@ -205,7 +204,7 @@
     n =3D X509_NAME_entry_cou=
nt(x509_name);
     for (i =3D 0; i < n; ++i)
     {
-        ent =3D X509_=
NAME_get_entry(x509_name, i);
+        X509_NAME_ENTRY *ent =3D X509_NAME_g=
et_entry(x509_name, i);
         if (!ent)
         {
             continue=
;
diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 21e113=
d=2E=2E8f558b1 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=
=2Ec
@@ -228,13 +228,13 @@
     int ret =3D false;
     if (buf_defined(buf=
))
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
             va_=
start(arglist, format);
             stat =3D vsnprintf((char *)ptr, cap, f=
ormat, arglist);
             va_end(arglist);
diff --git a/src/openvpn/cli=
nat=2Ec b/src/openvpn/clinat=2Ec
index 3724022=2E=2Edcef924 100644
--- a/sr=
c/openvpn/clinat=2Ec
+++ b/src/openvpn/clinat=2Ec
@@ -50,12 +50,11 @@
 prin=
t_client_nat_list(const struct client_nat_option_list *list, msglvl_t msgle=
vel)
 {
     struct gc_arena gc =3D gc_new();
-    int i;
 
     msg(msglev=
el, "*** CNAT list");
     if (list)
     {
-        for (i =3D 0; i < list=
->n; ++i)
+        for (int i =3D 0; i < list->n; ++i)
         {
         =
    const struct client_nat_entry *e =3D &list->entries[i];
             ms=
g(msglevel, "  CNAT[%d] t=3D%d %s/%s/%s", i, e->type,
diff --git a/src/open=
vpn/console_builtin=2Ec b/src/openvpn/console_builtin=2Ec
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
index dc22af5=2E=2E243=
cf27 100644
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
 d933aaf=2E=2E87eea55 100644
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
index 6d85c62=2E=2Ee265498 100644
--- a/src/openvpn/forward=2Ec
+++=
 b/src/openvpn/forward=2Ec
@@ -2056,13 +2056,13 @@
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
index e121b38=2E=2Eb6d93c7 10064=
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
index 71dba6=
c=2E=2E959f7b3 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=
=2Ec
@@ -4206,13 +4206,11 @@
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
index a396255=2E=2E8a0a360 =
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
index 3c5a249=2E=2Edcc4dac 10064=
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
88ab4d2=2E=2E12934ab 100644
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
index 6c766c2=2E=2E400c722 100644
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
index 761a59e=2E=2Eacc965d 100644
--=
- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -1155,7 +1155,6 @@
 =
        while (e)
         {
             char *p[MAX_PARMS + 1];
-        =
    bool enable =3D true;
 
             /* parse the push item */
        =
     CLEAR(p);
@@ -1163,6 +1162,8 @@
                 && parse_line(e->opti=
on, p, SIZE(p) - 1, "[PUSH_ROUTE_REMOVE]", 1, D_ROUTE_DEBUG,
              =
                 &gc))
             {
+                bool enable =3D true=
;
+
                 /* is the push item a route directive? */
            =
     if (p[0] && !strcmp(p[0], "route") && !p[3] && o->iroutes)
           =
      {
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index e8=
001b3=2E=2Eb3aee37 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/rou=
te=2Ec
@@ -2771,7 +2771,6 @@
 {
     struct gc_arena gc =3D gc_new();
     =
bool ret =3D false;
-    DWORD status;
     const DWORD if_index =3D window=
s_route_find_if_index(r, tt);
 
     if (if_index !=3D TUN_ADAPTER_INDEX_IN=
VALID)
@@ -2785,8 +2784,7 @@
         fr=2EdwForwardNextHop =3D htonl(r->ga=
teway);
         fr=2EdwForwardIfIndex =3D if_index;
 
-        status =3D =
DeleteIpForwardEntry(&fr);
-
+        const DWORD status =3D DeleteIpForwar=
dEntry(&fr);
         if (status =3D=3D NO_ERROR)
         {
             r=
et =3D true;
@@ -3824,12 +3822,11 @@
 bool
 netmask_to_netbits(const in_add=
r_t network, const in_addr_t netmask, int *netbits)
 {
-    int i;
     con=
st int addrlen =3D sizeof(in_addr_t) * 8;
 
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
index c92c423=2E=2E9983742 100644
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
 7cfe9f4=2E=2Eb88e1d9 100644
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
index 940f089=2E=2Ee9=
afda4 100644
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
index af48921=2E=2E4b92ff7 100644
--- a/s=
rc/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -1891,7 +1891,6 @@
        =
              openvpn_net_ctx_t *ctx)
 {
     char dynamic_name[256];
-    =
bool dynamic_opened =3D false;
 
     /*
      * unlike "open_tun_generic()=
", DCO on Linux and FreeBSD follows
@@ -1903,6 +1902,8 @@
 
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
@@ -3261,7 +3262,6 @@
    =
 if (tt->reads=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
         BOOL statu=
s;
-        int err;
 
         /* reset buf to its initial state */
      =
   tt->reads=2Ebuf =3D tt->reads=2Ebuf_init;
@@ -3288,7 +3288,7 @@
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
@@ -3316,7 +3316,6 @@
     if (tt->writes=2E=
iostate =3D=3D IOSTATE_INITIAL)
     {
         BOOL status;
-        int e=
rr;
 
         /* make a private copy of buf */
         tt->writes=2Ebuf =
=3D tt->writes=2Ebuf_init;
@@ -3343,7 +3342,7 @@
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
@@ -3540,8 +3539,6 @@
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
@@ -3571,6 +3568,8 @@
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
@@ -3655,7 +3654,6 @@
         char enum_na=
me[256];
         char connection_string[256];
         HKEY connection_key=
;
-        WCHAR name_data[256];
         DWORD name_type;
         const W=
CHAR name_string[] =3D L"Name";
 
@@ -3687,6 +3685,7 @@
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
@@ -3811,8 +3810,6 @@
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
@@ -3825,7 +3822,7 @@
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
@@ -4108,10 +4105,11 @@
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
@@ -4306,7 +4304,6 @@
 bool
=
 is_adapter_up(const struct tuntap *tt, const IP_ADAPTER_INFO *list)
 {
-  =
  int i;
     bool ret =3D false;
 
     const IP_ADAPTER_INFO *ai =3D get_=
tun_adapter(tt, list);
@@ -4316,7 +4313,7 @@
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
@@ -4350,7 +4347,6 @@=

 bool
 is_ip_in_adapter_subnet(const IP_ADAPTER_INFO *ai, const in_addr_t =
ip, in_addr_t *highest_netmask)
 {
-    int i;
     bool ret =3D false;
 
 =
    if (highest_netmask)
@@ -4361,7 +4357,7 @@
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
index 618772d=2E=2E82341f8 100644
--- a/src/openvpn/w=
in32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1041,7 +1041,6 @@
 openvpn_execve(=
const struct argv *a, const struct env_set *es, const unsigned int flags)
 =
{
     int ret =3D OPENVPN_EXECVE_ERROR;
-    static bool exec_warn =3D fal=
se;
 
     if (a && a->argv[0])
     {
@@ -1092,6 +1091,8 @@
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
@@ -1508,11 +1509,10 @@
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
index 4a38aa4=2E=2E1d9=
a5d87 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/in=
teractive=2Ec
@@ -933,7 +933,6 @@
 RegisterDNS(LPVOID unused)
 {
     DWORD=
 err;
-    size_t i;
     DWORD timeout =3D RDNS_TIMEOUT * 1000; /* in mill=
iseconds */
 
     /* path of ipconfig command */
@@ -956,7 +955,7 @@
     =
if (WaitForMultipleObjects(2, wait_handles, FALSE, timeout) =3D=3D WAIT_OBJ=
ECT_0)
     {
         /* Semaphore locked */
-        for (i =3D 0; i < _c=
ountof(cmds); ++i)
+        for (size_t i =3D 0; i < _countof(cmds); ++i)
 =
        {
             ExecCommand(cmds[i]=2Eargv0, cmds[i]=2Ecmdline, cmds=
[i]=2Etimeout);
         }
diff --git a/src/openvpnserv/service=2Ec b/src/o=
penvpnserv/service=2Ec
index 04b20d7=2E=2E2913f63 100644
--- a/src/openvpns=
erv/service=2Ec
+++ b/src/openvpnserv/service=2Ec
@@ -21,7 +21,6 @@
 BOOL
 =
ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status)
=
 {
-    static DWORD dwCheckPoint =3D 1;
     BOOL res =3D TRUE;
 
     if =
(status->dwCurrentState =3D=3D SERVICE_START_PENDING)
@@ -39,6 +38,7 @@
   =
  }
     else
     {
+        static DWORD dwCheckPoint =3D 1;
         sta=
tus->dwCheckPoint =3D dwCheckPoint++;
     }
 
@@ -55,7 +55,6 @@
 static in=
t
 CmdInstallServices(void)
 {
-    SC_HANDLE service;
     SC_HANDLE svc_c=
tl_mgr;
     WCHAR path[512];
     int i, ret =3D _service_max;
@@ -78,7 +7=
7,7 @@
 
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
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1963?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b7
Gerrit-Change-=
Number: 1963
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--vIo7nAqsVCw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1963?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Fix (almost) all occurrences of cppcheck variableScope<br><br>In two ca=
ses I found the code change too ugly and added<br>a suppression=2E In most =
cases the change is trivially<br>correct (as long as it builds)=2E<br><br>S=
ome drive-by style fixes, and marked some of the moved<br>variables const a=
s appropriate=2E<br><br>Change-Id: Ib69b6c7a5f21f8552159c94560830f182c6238b=
7<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ac=
ked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1963<br>Message-Id: &lt;20260928210659=
=2E12780-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39579=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cp=
pcheck-suppressions=2Exml<br>M sample/sample-plugins/keying-material-export=
er-demo/keyingmaterialexporter=2Ec<br>M sample/sample-plugins/log/log_v3=2E=
c<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/clinat=2Ec<br>M src/openvpn/=
console_builtin=2Ec<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto_epo=
ch=2Ec<br>M src/openvpn/dco_freebsd=2Ec<br>M src/openvpn/dhcp=2Ec<br>M src/=
openvpn/env_set=2Ec<br>M src/openvpn/forward=2Ec<br>M src/openvpn/httpdiges=
t=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/misc=2Ec<br>M src/openvp=
n/multi=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/options=
=2Ec<br>M src/openvpn/options_parse=2Ec<br>M src/openvpn/packet_id=2Ec<br>M=
 src/openvpn/platform=2Ec<br>M src/openvpn/pool=2Ec<br>M src/openvpn/proto=
=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn/=
run_command=2Ec<br>M src/openvpn/siphash_reference=2Ec<br>M src/openvpn/ssl=
_mbedtls=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<=
br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>M src/openvpn/tun=2Ec<br>M src/o=
penvpn/win32=2Ec<br>M src/openvpnserv/common=2Ec<br>M src/openvpnserv/inter=
active=2Ec<br>M src/openvpnserv/service=2Ec<br>M tests/unit_tests/openvpn/t=
est_provider=2Ec<br>37 files changed, 108 insertions(+), 134 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/63/1963/4</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppressi=
ons=2Exml b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>index 73d=
d41b=2E=2Ecd37c41 100644</span><br><span>--- a/dev-tools/cppcheck-suppressi=
ons=2Exml</span><br><span>+++ b/dev-tools/cppcheck-suppressions=2Exml</span=
><br><span>@@ -23,9 +23,6 @@</span><br><span>   &lt;suppress&gt;</span><br>=
<span>     &lt;id&gt;usleepCalled&lt;/id&gt;</span><br><span>   &lt;/suppre=
ss&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;suppress&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;id&gt;vari=
ableScope&lt;/id&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 &lt;/suppress&gt;</span><br><span>   &lt;!-- We have a lot of library incl=
udes, not all of them are really required,</span><br><span>        so ignor=
e them --&gt;</span><br><span>   &lt;suppress&gt;</span><br><span>@@ -206,4=
 +203,15 @@</span><br><span>     &lt;id&gt;unusedStructMember&lt;/id&gt;</s=
pan><br><span>     &lt;fileName&gt;tests/unit_tests/openvpn/test_pkcs11=2Ec=
&lt;/fileName&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: nicer --&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;variableScope&lt;/i=
d&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileNa=
me&gt;src/openvpnserv/interactive=2Ec&lt;/fileName&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;cmds&lt;/symbolNam=
e&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppres=
s&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;v=
ariableScope&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &lt;fileName&gt;src/openvpnserv/interactive=2Ec&lt;/fileName&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;=
sys_key&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  &lt;/suppress&gt;</span><br><span> &lt;/suppressions&gt;</span><br=
><span>diff --git a/sample/sample-plugins/keying-material-exporter-demo/key=
ingmaterialexporter=2Ec b/sample/sample-plugins/keying-material-exporter-de=
mo/keyingmaterialexporter=2Ec</span><br><span>index 25c9ff5=2E=2E204374b 10=
0644</span><br><span>--- a/sample/sample-plugins/keying-material-exporter-d=
emo/keyingmaterialexporter=2Ec</span><br><span>+++ b/sample/sample-plugins/=
keying-material-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>@@=
 -120,13 +120,14 @@</span><br><span>     ASN1_OBJECT *fn;</span><br><span> =
    ASN1_STRING *val;</span><br><span>     X509_NAME *x509_name;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    X509_NAME_ENTRY *ent;</span>=
<br><span>     const char *objbuf;</span><br><span> </span><br><span>     x=
509_name =3D X509_get_subject_name(x509);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int i, n =3D X509_NAME_entry_count(x509_name);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; n=
; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n =3D=
 X509_NAME_entry_count(x509_name);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (int i =3D 0; i &lt; n; ++i)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        X509_NAME_EN=
TRY *ent;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>         if (!(ent =3D X509_NAME_get_entry(x509_name, i)))</span><br=
><span>         {</span><br><span>             continue;</span><br><span>di=
ff --git a/sample/sample-plugins/log/log_v3=2Ec b/sample/sample-plugins/log=
/log_v3=2Ec</span><br><span>index 09c6735=2E=2E1c781a3 100644</span><br><sp=
an>--- a/sample/sample-plugins/log/log_v3=2Ec</span><br><span>+++ b/sample/=
sample-plugins/log/log_v3=2Ec</span><br><span>@@ -197,7 +197,6 @@</span><br=
><span>     ASN1_OBJECT *fn;</span><br><span>     ASN1_STRING *val;</span><=
br><span>     X509_NAME *x509_name;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    X509_NAME_ENTRY *ent;</span><br><span>     const char *ob=
jbuf;</span><br><span>     unsigned char *buf =3D NULL;</span><br><span> </=
span><br><span>@@ -205,7 +204,7 @@</span><br><span>     n =3D X509_NAME_ent=
ry_count(x509_name);</span><br><span>     for (i =3D 0; i &lt; n; ++i)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     ent =3D X509_NAME_get_entry(x509_name, i);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        X509_NAME_ENTRY *ent =3D X509_NAME_get_=
entry(x509_name, i);</span><br><span>         if (!ent)</span><br><span>   =
      {</span><br><span>             continue;</span><br><span>diff --git a=
/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 21e1=
13d=2E=2E8f558b1 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span>=
<br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -228,13 +228,13 @=
@</span><br><span>     int ret =3D false;</span><br><span>     if (buf_defi=
ned(buf))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        va_list arglist;</span><br><span>         uint8_t *ptr =
=3D BEND(buf);</span><br><span>         int cap =3D buf_forward_capacity(bu=
f);</span><br><span> </span><br><span>         if (cap &gt; 0)</span><br><s=
pan>         {</span><br><span>             int stat;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            va_list arglist;</span><br><s=
pan>             va_start(arglist, format);</span><br><span>             st=
at =3D vsnprintf((char *)ptr, cap, format, arglist);</span><br><span>      =
       va_end(arglist);</span><br><span>diff --git a/src/openvpn/clinat=2Ec=
 b/src/openvpn/clinat=2Ec</span><br><span>index 3724022=2E=2Edcef924 100644=
</span><br><span>--- a/src/openvpn/clinat=2Ec</span><br><span>+++ b/src/ope=
nvpn/clinat=2Ec</span><br><span>@@ -50,12 +50,11 @@</span><br><span> print_=
client_nat_list(const struct client_nat_option_list *list, msglvl_t msgleve=
l)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br>=
<span> </span><br><span>     msg(msglevel, &quot;*** CNAT list&quot;);</spa=
n><br><span>     if (list)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; list-&gt;n; ++i)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =
=3D 0; i &lt; list-&gt;n; ++i)</span><br><span>         {</span><br><span> =
            const struct client_nat_entry *e =3D &amp;list-&gt;entries[i];<=
/span><br><span>             msg(msglevel, &quot;  CNAT[%d] t=3D%d %s/%s/%s=
&quot;, i, e-&gt;type,</span><br><span>diff --git a/src/openvpn/console_bui=
ltin=2Ec b/src/openvpn/console_builtin=2Ec</span><br><span>index 9c8d72a=2E=
=2Ecf6cc37 100644</span><br><span>--- a/src/openvpn/console_builtin=2Ec</sp=
an><br><span>+++ b/src/openvpn/console_builtin=2Ec</span><br><span>@@ -77,7=
 +77,6 @@</span><br><span>     bool is_console =3D (GetFileType(in) =3D=3D =
FILE_TYPE_CHAR);</span><br><span>     DWORD flags_save =3D 0;</span><br><sp=
an>     int status =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    WCHAR *winput;</span><br><span> </span><br><span>     if (is_consol=
e)</span><br><span>     {</span><br><span>@@ -100,7 +99,7 @@</span><br><spa=
n> </span><br><span>     if (is_console)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        winput =3D malloc(capacit=
y * sizeof(WCHAR));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        WCHAR *winput =3D malloc(capacity * sizeof(WCHAR));</span><br><span=
>         if (winput =3D=3D NULL)</span><br><span>         {</span><br><spa=
n>             return false;</span><br><span>diff --git a/src/openvpn/crypt=
o=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index dc22af5=2E=2E243cf27 1=
00644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/sr=
c/openvpn/crypto=2Ec</span><br><span>@@ -1774,13 +1774,10 @@</span><br><spa=
n> static const cipher_name_pair *</span><br><span> get_cipher_name_pair(co=
nst char *cipher_name)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const cipher_name_pair *pair;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    size_t i =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Search for a ciphe=
r name translation */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    for (; i &lt; cipher_name_translation_table_count; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; cip=
her_name_translation_table_count; i++)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        pair =3D &amp;cipher_name_t=
ranslation_table[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        const cipher_name_pair *pair =3D &amp;cipher_name_translation_tabl=
e[i];</span><br><span>         if (0 =3D=3D strcmp(cipher_name, pair-&gt;op=
envpn_name)</span><br><span>             || 0 =3D=3D strcmp(cipher_name, pa=
ir-&gt;lib_name))</span><br><span>         {</span><br><span>diff --git a/s=
rc/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec</span><br><span>=
index 158c841=2E=2E69a1852 100644</span><br><span>--- a/src/openvpn/crypto_=
epoch=2Ec</span><br><span>+++ b/src/openvpn/crypto_epoch=2Ec</span><br><spa=
n>@@ -387,9 +387,6 @@</span><br><span>     else if (epoch &gt; opt-&gt;key_=
ctx_bi=2Edecrypt=2Eepoch</span><br><span>              &amp;&amp; epoch &lt=
;=3D opt-&gt;key_ctx_bi=2Edecrypt=2Eepoch + opt-&gt;epoch_data_keys_future_=
count)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        /* Key in the range of future keys */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        int index =3D epoch - (opt-&gt;key_=
ctx_bi=2Edecrypt=2Eepoch + 1);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span>         /* If we have reached the edge of the va=
lid keys we do not return</span><br><span>          * the key anymore since=
 regenerating the new keys would move us</span><br><span>          * over t=
he window of valid keys and would need all kind of</span><br><span>@@ -400,=
6 +397,9 @@</span><br><span>         }</span><br><span>         else</span>=
<br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* Key in the range of future keys */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            const int index =3D epoch - (opt=
-&gt;key_ctx_bi=2Edecrypt=2Eepoch + 1);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>             return &amp;opt-&gt;epoch=
_data_keys_future[index];</span><br><span>         }</span><br><span>     }=
</span><br><span>diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco=
_freebsd=2Ec</span><br><span>index d933aaf=2E=2E87eea55 100644</span><br><s=
pan>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span>+++ b/src/openvpn/dco=
_freebsd=2Ec</span><br><span>@@ -444,7 +444,6 @@</span><br><span> key_to_nv=
list(const uint8_t *key, const uint8_t *implicit_iv, const char *ciphername=
)</span><br><span> {</span><br><span>     nvlist_t *nvl;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    size_t key_len;</span><br><span> </s=
pan><br><span>     nvl =3D nvlist_create(0);</span><br><span> </span><br><s=
pan>@@ -452,7 +451,7 @@</span><br><span> </span><br><span>     if (strcmp(c=
iphername, &quot;none&quot;) !=3D 0)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        key_len =3D cipher_kt_key_siz=
e(ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   const size_t key_len =3D cipher_kt_key_size(ciphername);</span><br><span=
> </span><br><span>         nvlist_add_binary(nvl, &quot;key&quot;, key, ke=
y_len);</span><br><span>         nvlist_add_binary(nvl, &quot;iv&quot;, imp=
licit_iv, 8);</span><br><span>diff --git a/src/openvpn/dhcp=2Ec b/src/openv=
pn/dhcp=2Ec</span><br><span>index 5cdcfcf=2E=2E19e9e2d 100644</span><br><sp=
an>--- a/src/openvpn/dhcp=2Ec</span><br><span>+++ b/src/openvpn/dhcp=2Ec</s=
pan><br><span>@@ -271,7 +271,6 @@</span><br><span> {</span><br><span>     c=
har tmp_buf[256];</span><br><span>     size_t len =3D 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    size_t label_length_pos;</span><br><=
span> </span><br><span>     for (int i =3D 0; i &lt; array_len; i++)</span>=
<br><span>     {</span><br><span>@@ -290,7 +289,7 @@</span><br><span> </spa=
n><br><span>         /* label_length_pos points to the byte to be replaced =
by the length</span><br><span>          * of the following domain label */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        label_length_p=
os =3D len++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  size_t label_length_pos =3D len++;</span><br><span> </span><br><span>    =
     while (true)</span><br><span>         {</span><br><span>diff --git a/s=
rc/openvpn/env_set=2Ec b/src/openvpn/env_set=2Ec</span><br><span>index d992=
097=2E=2E67a5bf5 100644</span><br><span>--- a/src/openvpn/env_set=2Ec</span=
><br><span>+++ b/src/openvpn/env_set=2Ec</span><br><span>@@ -62,14 +62,13 @=
@</span><br><span> static bool</span><br><span> env_string_equal(const char=
 *s1, const char *s2)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int c1, c2;</span><br><span>     ASSERT(s1);</span><=
br><span>     ASSERT(s2);</span><br><span> </span><br><span>     while (tru=
e)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        c1 =3D *s1++;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        c2 =3D *s2++;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        int c1 =3D *s1++;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        int c2 =3D *s2++;</span><br><span>         if (c1 =3D=
=3D &#39;=3D&#39;)</span><br><span>         {</span><br><span>             =
c1 =3D 0;</span><br><span>@@ -214,12 +213,11 @@</span><br><span>     if (ch=
eck_debug_level(msglevel))</span><br><span>     {</span><br><span>         =
const struct env_item *e;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        int i;</span><br><span> </span><br><span>         if (es)</span=
><br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            int i =3D 0;</span><br><span>             e =3D es-&gt;list;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i =3D 0;</=
span><br><span> </span><br><span>             while (e)</span><br><span>   =
          {</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/open=
vpn/forward=2Ec</span><br><span>index 6d85c62=2E=2Ee265498 100644</span><br=
><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forw=
ard=2Ec</span><br><span>@@ -2056,13 +2056,13 @@</span><br><span>     unsign=
ed int socket =3D 0;</span><br><span>     unsigned int tuntap =3D 0;</span>=
<br><span>     static uintptr_t tun_shift =3D TUN_SHIFT;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    static uintptr_t err_shift =3D ERR_S=
HIFT;</span><br><span> </span><br><span>     /*</span><br><span>      * Cal=
culate the flags based on the provided &#39;flags&#39; argument=2E</span><b=
r><span>      */</span><br><span>     if ((c-&gt;options=2Emode !=3D MODE_S=
ERVER) &amp;&amp; (flags &amp; IOW_WAIT_SIGNAL))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        static uintptr_=
t err_shift =3D ERR_SHIFT;</span><br><span>         wait_signal(es, (void *=
)err_shift);</span><br><span>     }</span><br><span> </span><br><span>diff =
--git a/src/openvpn/httpdigest=2Ec b/src/openvpn/httpdigest=2Ec</span><br><=
span>index ab8a710=2E=2E52df383 100644</span><br><span>--- a/src/openvpn/ht=
tpdigest=2Ec</span><br><span>+++ b/src/openvpn/httpdigest=2Ec</span><br><sp=
an>@@ -34,12 +34,9 @@</span><br><span> static void</span><br><span> CvtHex(=
IN HASH Bin, OUT HASHHEX Hex)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    unsigned short i;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    unsigned char j;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    for (i =3D 0; i &lt; HASHLEN; i++)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    for (unsigned short i =3D 0; i &lt; HASHLEN; i+=
+)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        j =3D (Bin[i] &gt;&gt; 4) &amp; 0xf;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        unsigned char j =3D (Bin[i] &gt;&gt; 4=
) &amp; 0xf;</span><br><span>         if (j &lt;=3D 9)</span><br><span>    =
     {</span><br><span>             Hex[i * 2] =3D (j + &#39;0&#39;);</span=
><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</sp=
an><br><span>index e121b38=2E=2Eb6d93c7 100644</span><br><span>--- a/src/op=
envpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><sp=
an>@@ -368,7 +368,6 @@</span><br><span>     {</span><br><span>         stru=
ct gc_arena gc =3D gc_new();</span><br><span>         struct log_entry e;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *out=
 =3D NULL;</span><br><span>         unsigned int action_flags =3D 0;</span>=
<br><span> </span><br><span>         ++recursive_level;</span><br><span>@@ =
-391,6 +390,8 @@</span><br><span> </span><br><span>         if (!man_passwo=
rd_needed(man))</span><br><span>         {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            const char *out =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             if (=
flags =3D=3D M_CLIENT)</span><br><span>             {</span><br><span>     =
            out =3D log_entry_print(&amp;e, LOG_PRINT_CRLF, &amp;gc);</span=
><br><span>@@ -3036,14 +3037,15 @@</span><br><span> static void</span><br><=
span> man_output_peer_info_env(struct management *man, const struct man_def=
_auth_context *mdac)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    char line[256];</span><br><span>     if (man-&gt;pers=
ist=2Ecallback=2Eget_peer_info)</span><br><span>     {</span><br><span>    =
     const char *peer_info =3D</span><br><span>             (*man-&gt;persi=
st=2Ecallback=2Eget_peer_info)(man-&gt;persist=2Ecallback=2Earg, mdac-&gt;c=
id);</span><br><span>         if (peer_info)</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            char line[2=
56];</span><br><span>             struct buffer buf;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             buf_set_rea=
d(&amp;buf, (const uint8_t *)peer_info, strlen(peer_info));</span><br><span=
>             while (buf_parse(&amp;buf, &#39;\n&#39;, line, sizeof(line)))=
</span><br><span>             {</span><br><span>@@ -3820,13 +3822,12 @@</sp=
an><br><span> {</span><br><span>     int ok;</span><br><span>     char *res=
ult =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t struct buffer *buf;</span><br><span> </span><br><span>     ok =3D managem=
ent_query_multiline(man, b64_data, prompt, cmd, state, input);</span><br><s=
pan>     if (ok &amp;&amp; buffer_list_defined(*input))</span><br><span>   =
  {</span><br><span>         buffer_list_aggregate_separator(*input, 10000,=
 &quot;\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    buf =3D buffer_list_peek(*input);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const struct buffer *buf =3D buffer_list_peek(*in=
put);</span><br><span>         if (buf &amp;&amp; BLEN(buf) &gt; 0)</span><=
br><span>         {</span><br><span>             result =3D (char *)malloc(=
BLENZ(buf) + 1);</span><br><span>@@ -3847,15 +3848,13 @@</span><br><span> m=
anagement_query_multiline_flatten(struct management *man, const char *b64_d=
ata, const char *prompt,</span><br><span>                                  =
  const char *cmd, int *state, struct buffer_list **input)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ok;</span><=
br><span>     char *result =3D NULL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    const struct buffer *buf;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ok =3D management_query_multil=
ine(man, b64_data, prompt, cmd, state, input);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const int ok =3D management_query_multiline(=
man, b64_data, prompt, cmd, state, input);</span><br><span>     if (ok &amp=
;&amp; buffer_list_defined(*input))</span><br><span>     {</span><br><span>=
         buffer_list_aggregate(*input, 2048);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        buf =3D buffer_list_peek(*input);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const struct buffer *=
buf =3D buffer_list_peek(*input);</span><br><span>         if (buf &amp;&am=
p; BLEN(buf) &gt; 0)</span><br><span>         {</span><br><span>           =
  result =3D (char *)malloc(BLENZ(buf) + 1);</span><br><span>diff --git a/s=
rc/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><br><span>index 54af890=2E=
=2E6e9591f 100644</span><br><span>--- a/src/openvpn/misc=2Ec</span><br><spa=
n>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -474,7 +474,7 @@</span><br>=
<span> purge_user_pass(struct user_pass *up, const bool force)</span><br><s=
pan> {</span><br><span>     const bool nocache =3D up-&gt;nocache;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    static bool warn_shown =3D=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     if (nocache || force)</span><br><span>     {</span><br><span>    =
     secure_memzero(up, sizeof(*up));</span><br><span>@@ -482,6 +482,8 @@</=
span><br><span>     }</span><br><span>     else</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        static bool warn=
_shown =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>         protect_user_pass(up);</span><br><span>         /*<=
/span><br><span>          * don&#39;t show warning if the pass has been rep=
laced by a token: this is an</span><br><span>@@ -721,11 +723,10 @@</span><b=
r><span> bool</span><br><span> validate_peer_info_line(char *line)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t=
 c;</span><br><span>     int state =3D 0;</span><br><span>     while (*line=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        c =3D *line;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        const uint8_t c =3D *line;</span><br><span>         switch (sta=
te)</span><br><span>         {</span><br><span>             case 0:</span><=
br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><=
br><span>index 71dba6c=2E=2E959f7b3 100644</span><br><span>--- a/src/openvp=
n/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ =
-4206,13 +4206,11 @@</span><br><span> static void</span><br><span> tunnel_s=
erver_loop(struct multi_context *multi)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int status;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     while (true)</span><b=
r><span>     {</span><br><span>         /* wait on tun/socket list */</span=
><br><span>         multi_get_timeout(multi, &amp;multi-&gt;top=2Ec2=2Etime=
val);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status =
=3D multi_io_wait(multi);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        const int status =3D multi_io_wait(multi);</span><br><span>  =
       MULTI_CHECK_SIG(multi);</span><br><span> </span><br><span>         /=
* check on status of coarse timers */</span><br><span>diff --git a/src/open=
vpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span=
>index a396255=2E=2E8a0a360 100644</span><br><span>--- a/src/openvpn/networ=
king_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span=
><br><span>@@ -1375,13 +1375,11 @@</span><br><span> sitnl_parse_rtattr_flag=
s(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len,</span><b=
r><span>                          unsigned short flags)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned short typ=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>  =
   memset(tb, 0, sizeof(struct rtattr *) * (max + 1));</span><br><span> </s=
pan><br><span>     while (RTA_OK(rta, len))</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        type =3D rta-&gt;rta_t=
ype &amp; ~flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      const unsigned short type =3D rta-&gt;rta_type &amp; ~flags;</span><b=
r><span> </span><br><span>         if ((type &lt;=3D max) &amp;&amp; (!tb[t=
ype]))</span><br><span>         {</span><br><span>@@ -1409,7 +1407,6 @@</sp=
an><br><span> static int</span><br><span> sitnl_type_save(struct nlmsghdr *=
n, void *arg)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    char *type =3D arg;</span><br><span>     struct ifinfomsg *i=
fi =3D NLMSG_DATA(n);</span><br><span>     struct rtattr *tb[IFLA_MAX + 1];=
</span><br><span> </span><br><span>@@ -1418,6 +1415,7 @@</span><br><span>  =
   if (tb[IFLA_LINKINFO])</span><br><span>     {</span><br><span>         s=
truct rtattr *tb_link[IFLA_INFO_MAX + 1];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        char *type =3D arg;</span><br><span> </span><=
br><span>         sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MAX, tb[IFLA=
_LINKINFO]);</span><br><span> </span><br><span>diff --git a/src/openvpn/opt=
ions=2Ec b/src/openvpn/options=2Ec</span><br><span>index 3c5a249=2E=2Edcc4d=
ac 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++=
 b/src/openvpn/options=2Ec</span><br><span>@@ -1019,10 +1019,9 @@</span><br=
><span> </span><br><span>     for (current =3D *list, prev =3D NULL; curren=
t !=3D NULL; current =3D current-&gt;next)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        char *tmp_value =3D NUL=
L;</span><br><span>         if (!strncmp(current-&gt;string, &quot;foreign_=
option_&quot;, sizeof(&quot;foreign_option_&quot;) - 1))</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            t=
mp_value =3D strchr(current-&gt;string, &#39;=3D&#39;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            const char *tmp_value =3D s=
trchr(current-&gt;string, &#39;=3D&#39;);</span><br><span>             if (=
tmp_value &amp;&amp; ++tmp_value)</span><br><span>             {</span><br>=
<span>                 if (!strncmp(tmp_value, &quot;dhcp-option &quot;, si=
zeof(&quot;dhcp-option &quot;) - 1))</span><br><span>diff --git a/src/openv=
pn/options_parse=2Ec b/src/openvpn/options_parse=2Ec</span><br><span>index =
88ab4d2=2E=2E12934ab 100644</span><br><span>--- a/src/openvpn/options_parse=
=2Ec</span><br><span>+++ b/src/openvpn/options_parse=2Ec</span><br><span>@@=
 -351,7 +351,6 @@</span><br><span> {</span><br><span>     const int max_rec=
ursive_levels =3D 10;</span><br><span>     FILE *fp;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int line_num;</span><br><span>     char=
 line[OPTION_LINE_SIZE + 1];</span><br><span>     char *p[MAX_PARMS + 1];</=
span><br><span> </span><br><span>@@ -368,7 +367,7 @@</span><br><span>      =
   }</span><br><span>         if (fp)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            line_num =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            int line_num=
 =3D 0;</span><br><span>             while (fgets(line, sizeof(line), fp))<=
/span><br><span>             {</span><br><span>                 int offset =
=3D 0;</span><br><span>diff --git a/src/openvpn/packet_id=2Ec b/src/openvpn=
/packet_id=2Ec</span><br><span>index 22c53c7=2E=2E50d7c76 100644</span><br>=
<span>--- a/src/openvpn/packet_id=2Ec</span><br><span>+++ b/src/openvpn/pac=
ket_id=2Ec</span><br><span>@@ -219,8 +219,6 @@</span><br><span> bool</span>=
<br><span> packet_id_test(struct packet_id_rec *p, const struct packet_id_n=
et *pin)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    uint64_t diff;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span>     packet_id_debug(D_PID_DEBUG, p, pin, &quot;PID_TES=
T&quot;, 0);</span><br><span> </span><br><span>     ASSERT(p-&gt;initialize=
d);</span><br><span>@@ -247,7 +245,7 @@</span><br><span>             }</spa=
n><br><span> </span><br><span>             /* check packet-id sliding windo=
w for original/replay status */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            diff =3D p-&gt;id - pin-&gt;id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            const uint64_t diff =3D p-&gt=
;id - pin-&gt;id;</span><br><span> </span><br><span>             /* keep tr=
ack of maximum backtrack seen for debugging purposes */</span><br><span>   =
          if (diff &gt; p-&gt;max_backtrack_stat)</span><br><span>@@ -512,7=
 +510,6 @@</span><br><span>     {</span><br><span>         struct packet_id=
_persist_file_image image;</span><br><span>         CLEAR(image);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        ssize_t n;</span><br><s=
pan>         off_t seek_ret;</span><br><span>         struct gc_arena gc =
=3D gc_new();</span><br><span> </span><br><span>@@ -521,7 +518,7 @@</span><=
br><span>         seek_ret =3D lseek(p-&gt;fd, (off_t)0, SEEK_SET);</span><=
br><span>         if (seek_ret =3D=3D (off_t)0)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            n =3D writ=
e(p-&gt;fd, &amp;image, sizeof(image));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            const ssize_t n =3D write(p-&gt;fd, &amp;im=
age, sizeof(image));</span><br><span>             if (n =3D=3D sizeof(image=
))</span><br><span>             {</span><br><span>                 p-&gt;ti=
me_last_written =3D p-&gt;time;</span><br><span>@@ -599,7 +596,6 @@</span><=
br><span>     {</span><br><span>         char c;</span><br><span>         t=
ime_t v;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int d=
iff;</span><br><span> </span><br><span>         v =3D CIRC_LIST_ITEM(sl, i)=
;</span><br><span>         if (v =3D=3D SEQ_UNSEEN)</span><br><span>@@ -612=
,7 +608,7 @@</span><br><span>         }</span><br><span>         else</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            diff =3D (int)(prev_now - v);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            const int diff =3D (int)(prev_now - v);</=
span><br><span>             if (diff &lt; 0)</span><br><span>             {=
</span><br><span>                 c =3D &#39;N&#39;;</span><br><span>diff -=
-git a/src/openvpn/platform=2Ec b/src/openvpn/platform=2Ec</span><br><span>=
index 6c766c2=2E=2E400c722 100644</span><br><span>--- a/src/openvpn/platfor=
m=2Ec</span><br><span>+++ b/src/openvpn/platform=2Ec</span><br><span>@@ -53=
9,8 +539,6 @@</span><br><span> const char *</span><br><span> platform_creat=
e_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int fd;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const ch=
ar *retfname =3D NULL;</span><br><span>     unsigned int attempts =3D 0;</s=
pan><br><span>     char fname[256] =3D { 0 };</span><br><span>     const ch=
ar *fname_fmt =3D PACKAGE &quot;_%=2E*s_%08&quot; PRIx64 &quot;%08&quot; PR=
Ix64 &quot;=2Etmp&quot;;</span><br><span>@@ -557,7 +555,7 @@</span><br><spa=
n>             return NULL;</span><br><span>         }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        retfname =3D pla=
tform_gen_path(directory, fname, gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const char *retfname =3D platform_gen_path(direct=
ory, fname, gc);</span><br><span>         if (!retfname)</span><br><span>  =
       {</span><br><span>             msg(M_WARN, &quot;Failed to create te=
mporary filename and path&quot;);</span><br><span>@@ -566,7 +564,7 @@</span=
><br><span> </span><br><span>         /* Atomically create the file=2E  Err=
ors out if the file already</span><br><span>          * exists=2E  */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        fd =3D platform_ope=
n(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const int fd =3D platform_=
open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR);</span><br><=
span>         if (fd !=3D -1)</span><br><span>         {</span><br><span>  =
           close(fd);</span><br><span>diff --git a/src/openvpn/pool=2Ec b/s=
rc/openvpn/pool=2Ec</span><br><span>index 80dec6c=2E=2E63fc930 100644</span=
><br><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/openvpn/poo=
l=2Ec</span><br><span>@@ -494,22 +494,21 @@</span><br><span>         for (i=
 =3D 0; i &lt; pool-&gt;size; ++i)</span><br><span>         {</span><br><sp=
an>             const struct ifconfig_pool_entry *e =3D &amp;pool-&gt;list[=
i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct=
 in6_addr ip6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     in_addr_t ip;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         const char *ip6_str =3D &quot;&quot;;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            const char *ip_str =3D &quot;&quot;;</=
span><br><span> </span><br><span>             if (e-&gt;common_name)</span>=
<br><span>             {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                const char *ip6_str =3D &quot;&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                const char *ip_str =
=3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>                 if (pool-&gt;ipv4=2Eenabled)</span><br><spa=
n>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   ip =3D ifconfig_pool_handle_to_ip_base(pool, i);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    const i=
n_addr_t ip =3D ifconfig_pool_handle_to_ip_base(pool, i);</span><br><span> =
                    ip_str =3D print_in_addr_t(ip, 0, &amp;gc);</span><br><=
span>                 }</span><br><span> </span><br><span>                 =
if (pool-&gt;ipv6=2Eenabled)</span><br><span>                 {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    ip6 =3D ifcon=
fig_pool_handle_to_ipv6_base(pool, i);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    const struct in6_addr ip6 =3D ifconf=
ig_pool_handle_to_ipv6_base(pool, i);</span><br><span>                     =
ip6_str =3D print_in6_addr(ip6, 0, &amp;gc);</span><br><span>              =
   }</span><br><span> </span><br><span>diff --git a/src/openvpn/proto=2Ec b=
/src/openvpn/proto=2Ec</span><br><span>index 785c021=2E=2E2cdb147 100644</s=
pan><br><span>--- a/src/openvpn/proto=2Ec</span><br><span>+++ b/src/openvpn=
/proto=2Ec</span><br><span>@@ -39,7 +39,6 @@</span><br><span> is_ipv_X(int =
tunnel_type, struct buffer *buf, int ip_ver)</span><br><span> {</span><br><=
span>     int offset;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    uint16_t proto;</span><br><span>     const struct openvpn_iphdr *ih;</s=
pan><br><span> </span><br><span>     verify_align_4(buf);</span><br><span>@=
@ -61,7 +60,7 @@</span><br><span>         eh =3D (const struct openvpn_ethh=
dr *)BPTR(buf);</span><br><span> </span><br><span>         /* start by assu=
ming this is a standard Eth fram */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        proto =3D eh-&gt;proto;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        uint16_t proto =3D eh-&gt;proto;</span><b=
r><span>         offset =3D sizeof(struct openvpn_ethhdr);</span><br><span>=
 </span><br><span>         /* if this is a 802=2E1q frame, parse the header=
 using the according</span><br><span>diff --git a/src/openvpn/push=2Ec b/sr=
c/openvpn/push=2Ec</span><br><span>index 761a59e=2E=2Eacc965d 100644</span>=
<br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=
=2Ec</span><br><span>@@ -1155,7 +1155,6 @@</span><br><span>         while (=
e)</span><br><span>         {</span><br><span>             char *p[MAX_PARM=
S + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            bo=
ol enable =3D true;</span><br><span> </span><br><span>             /* parse=
 the push item */</span><br><span>             CLEAR(p);</span><br><span>@@=
 -1163,6 +1162,8 @@</span><br><span>                 &amp;&amp; parse_line(=
e-&gt;option, p, SIZE(p) - 1, &quot;[PUSH_ROUTE_REMOVE]&quot;, 1, D_ROUTE_D=
EBUG,</span><br><span>                               &amp;gc))</span><br><s=
pan>             {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               bool enable =3D true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span>                 /* is the push item a ro=
ute directive? */</span><br><span>                 if (p[0] &amp;&amp; !str=
cmp(p[0], &quot;route&quot;) &amp;&amp; !p[3] &amp;&amp; o-&gt;iroutes)</sp=
an><br><span>                 {</span><br><span>diff --git a/src/openvpn/ro=
ute=2Ec b/src/openvpn/route=2Ec</span><br><span>index e8001b3=2E=2Eb3aee37 =
100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/sr=
c/openvpn/route=2Ec</span><br><span>@@ -2771,7 +2771,6 @@</span><br><span> =
{</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>   =
  bool ret =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    DWORD status;</span><br><span>     const DWORD if_index =3D windows_rou=
te_find_if_index(r, tt);</span><br><span> </span><br><span>     if (if_inde=
x !=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>@@ -2785,8 +2784,7 @@</sp=
an><br><span>         fr=2EdwForwardNextHop =3D htonl(r-&gt;gateway);</span=
><br><span>         fr=2EdwForwardIfIndex =3D if_index;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status =3D Dele=
teIpForwardEntry(&amp;fr);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
DWORD status =3D DeleteIpForwardEntry(&amp;fr);</span><br><span>         if=
 (status =3D=3D NO_ERROR)</span><br><span>         {</span><br><span>      =
       ret =3D true;</span><br><span>@@ -3824,12 +3822,11 @@</span><br><spa=
n> bool</span><br><span> netmask_to_netbits(const in_addr_t network, const =
in_addr_t netmask, int *netbits)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>     const int a=
ddrlen =3D sizeof(in_addr_t) * 8;</span><br><span> </span><br><span>     if=
 ((network &amp; netmask) =3D=3D network)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt;=3D =
addrlen; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  for (int i =3D 0; i &lt;=3D addrlen; ++i)</span><br><span>         {</spa=
n><br><span>             in_addr_t mask =3D netbits_to_netmask(i);</span><b=
r><span>             if (mask =3D=3D netmask)</span><br><span>diff --git a/=
src/openvpn/run_command=2Ec b/src/openvpn/run_command=2Ec</span><br><span>i=
ndex 905caa3=2E=2E0e36dad 100644</span><br><span>--- a/src/openvpn/run_comm=
and=2Ec</span><br><span>+++ b/src/openvpn/run_command=2Ec</span><br><span>@=
@ -176,14 +176,13 @@</span><br><span> #if defined(ENABLE_FEATURE_EXECVE)</s=
pan><br><span>         if (openvpn_execve_allowed(flags))</span><br><span> =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
const char *cmd =3D a-&gt;argv[0];</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            char *const *argv =3D a-&gt;argv;</span><br><span>=
             char *const *envp =3D (char *const *)make_env_array(es, true, =
&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
pid_t pid;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            pid =3D fork();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            const pid_t pid =3D fork();</span><br><span>    =
         if (pid =3D=3D (pid_t)0) /* child side */</span><br><span>        =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   const char *cmd =3D a-&gt;argv[0];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                char *const *argv =3D a-&gt;argv;</span><=
br><span>                 execve(cmd, argv, envp);</span><br><span>        =
         exit(OPENVPN_EXECVE_FAILURE);</span><br><span>             }</span=
><br><span>@@ -283,17 +282,17 @@</span><br><span>         static bool warn_=
shown =3D false;</span><br><span>         if (script_security() &gt;=3D SSE=
C_BUILT_IN)</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            const char *cmd =3D a-&gt;argv[0];</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            char *const *argv =3D=
 a-&gt;argv;</span><br><span>             char *const *envp =3D (char *cons=
t *)make_env_array(es, true, &amp;gc);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            pid_t pid;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            const char *cmd =3D a-&gt;argv[0];</span><b=
r><span>             int pipe_stdout[2];</span><br><span> </span><br><span>=
             if (pipe(pipe_stdout) =3D=3D 0)</span><br><span>             {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                pid =
=3D fork();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      if (pid =3D=3D (pid_t)0)       /* child side */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                const pid_t pid =3D fork(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                i=
f (pid =3D=3D (pid_t)0) /* child side */</span><br><span>                 {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 char *const *argv =3D a-&gt;argv;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>                     close(pipe_stdout[0]);=
 /* Close read end */</span><br><span>                     dup2(pipe_stdout=
[1], 1);</span><br><span>                     execve(cmd, argv, envp);</spa=
n><br><span>diff --git a/src/openvpn/siphash_reference=2Ec b/src/openvpn/si=
phash_reference=2Ec</span><br><span>index 5f0adb9=2E=2E9240ab0 100644</span=
><br><span>--- a/src/openvpn/siphash_reference=2Ec</span><br><span>+++ b/sr=
c/openvpn/siphash_reference=2Ec</span><br><span>@@ -113,7 +113,6 @@</span><=
br><span>     uint64_t v3 =3D UINT64_C(0x7465646279746573);</span><br><span=
>     uint64_t k0 =3D U8TO64_LE(kk);</span><br><span>     uint64_t k1 =3D U=
8TO64_LE(kk + 8);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
uint64_t m;</span><br><span>     int i;</span><br><span>     const unsigned=
 char *end =3D ni + inlen - (inlen % sizeof(uint64_t));</span><br><span>   =
  const int left =3D inlen &amp; 7;</span><br><span>@@ -130,7 +129,7 @@</sp=
an><br><span> </span><br><span>     for (; ni !=3D end; ni +=3D 8)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 m =3D U8TO64_LE(ni);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        uint64_t m =3D U8TO64_LE(ni);</span><br><span>         v3 ^=3D m;=
</span><br><span> </span><br><span>         TRACE;</span><br><span>diff --g=
it a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><s=
pan>index c92c423=2E=2E9983742 100644</span><br><span>--- a/src/openvpn/ssl=
_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><s=
pan>@@ -1014,12 +1014,12 @@</span><br><span> tls_ctx_personalise_random(str=
uct tls_root_ctx *ctx)</span><br><span> {</span><br><span> #if MBEDTLS_VERS=
ION_NUMBER &lt; 0x04000000</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    static char old_sha256_hash[32] =3D { 0 };</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    unsigned char sha256_hash[32] =3D { 0 }=
;</span><br><span>     mbedtls_ctr_drbg_context *cd_ctx =3D rand_ctx_get();=
</span><br><span> </span><br><span>     if (NULL !=3D ctx-&gt;crt_chain)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        static char old_sha256_hash[32] =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        unsigned char sha256_hash[32] =3D=
 { 0 };</span><br><span>         mbedtls_x509_crt *cert =3D ctx-&gt;crt_cha=
in;</span><br><span>         const mbedtls_md_info_t *kt =3D md_get(&quot;S=
HA256&quot;);</span><br><span> </span><br><span>diff --git a/src/openvpn/ss=
l_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index 7cfe9f4=
=2E=2Eb88e1d9 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</spa=
n><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -1784,10 +=
1784,7 @@</span><br><span> {</span><br><span>     STACK_OF(X509_INFO) *info=
_stack =3D NULL;</span><br><span>     STACK_OF(X509_NAME) *cert_names =3D N=
ULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    X509_LOOKUP *=
lookup =3D NULL;</span><br><span>     X509_STORE *store =3D NULL;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    BIO *in =3D NULL;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    openssl_stack_size_t added =
=3D 0, prev =3D 0;</span><br><span> </span><br><span>     ASSERT(NULL !=3D =
ctx);</span><br><span> </span><br><span>@@ -1800,6 +1797,9 @@</span><br><sp=
an>     /* Try to add certificates and CRLs from ca_file */</span><br><span=
>     if (ca_file)</span><br><span>     {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        openssl_stack_size_t added =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        BIO *in =3D NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>        =
 if (ca_file_inline)</span><br><span>         {</span><br><span>           =
  in =3D BIO_new_mem_buf((char *)ca_file, -1);</span><br><span>@@ -1816,6 +=
1816,8 @@</span><br><span> </span><br><span>         if (info_stack)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            openssl_stack_size_t prev =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>             for (openssl_stack_=
size_t i =3D 0; i &lt; sk_X509_INFO_num(info_stack); i++)</span><br><span> =
            {</span><br><span>                 X509_INFO *info =3D sk_X509_=
INFO_value(info_stack, i);</span><br><span>@@ -1916,7 +1918,7 @@</span><br>=
<span>     /* Set a store for certs (CA &amp; CRL) with a lookup on the &qu=
ot;capath&quot; hash directory */</span><br><span>     if (ca_path)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  lookup =3D X509_STORE_add_lookup(store, X509_LOOKUP_hash_dir());</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        X509_LOOKUP *lookup =
=3D X509_STORE_add_lookup(store, X509_LOOKUP_hash_dir());</span><br><span> =
        if (lookup &amp;&amp; X509_LOOKUP_add_dir(lookup, ca_path, X509_FIL=
ETYPE_PEM))</span><br><span>         {</span><br><span>             msg(M_W=
ARN, &quot;WARNING: experimental option --capath %s&quot;, ca_path);</span>=
<br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</s=
pan><br><span>index 940f089=2E=2Ee9afda4 100644</span><br><span>--- a/src/o=
penvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br>=
<span>@@ -74,8 +74,6 @@</span><br><span> </span><br><span>         int e1, =
e2;</span><br><span>         uint8_t *b =3D BPTR(buf);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uint8_t buf1[SWAP_BUF_SIZE];</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint8_t buf2[SWAP_B=
UF_SIZE];</span><br><span> </span><br><span>         if (incoming)</span><b=
r><span>         {</span><br><span>@@ -92,6 +90,9 @@</span><br><span> </spa=
n><br><span>         if (buf-&gt;len &gt;=3D e1 + e2)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ui=
nt8_t buf1[SWAP_BUF_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            uint8_t buf2[SWAP_BUF_SIZE];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>             memcpy(buf1, b, e=
1);</span><br><span>             memcpy(buf2, b + e1, e2);</span><br><span>=
             memcpy(b, buf2, e2);</span><br><span>diff --git a/src/openvpn/=
ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span=
>index c4bae40=2E=2Eb9a36a6 100644</span><br><span>--- a/src/openvpn/ssl_ve=
rify_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=2Ec</=
span><br><span>@@ -701,7 +701,6 @@</span><br><span> void</span><br><span> x=
509_setenv(struct env_set *es, int cert_depth, mbedtls_x509_crt *cert)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uns=
igned char c;</span><br><span>     const mbedtls_x509_name *name;</span><br=
><span>     char s[128] =3D { 0 };</span><br><span> </span><br><span>@@ -72=
9,7 +728,7 @@</span><br><span>                 break;</span><br><span>     =
        }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            c =3D name-&gt;val=2Ep[i];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            const unsigned char c =3D name-&gt;val=
=2Ep[i];</span><br><span>             if (c &lt; 32 || c =3D=3D 127 || (c &=
gt; 128 &amp;&amp; c &lt; 160))</span><br><span>             {</span><br><s=
pan>                 s[i] =3D &#39;?&#39;;</span><br><span>diff --git a/src=
/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index af48921=2E=2E4=
b92ff7 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++=
 b/src/openvpn/tun=2Ec</span><br><span>@@ -1891,7 +1891,6 @@</span><br><spa=
n>                      openvpn_net_ctx_t *ctx)</span><br><span> {</span><b=
r><span>     char dynamic_name[256];</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    bool dynamic_opened =3D false;</span><br><span> </span><=
br><span>     /*</span><br><span>      * unlike &quot;open_tun_generic()&qu=
ot;, DCO on Linux and FreeBSD follows</span><br><span>@@ -1903,6 +1902,8 @@=
</span><br><span> </span><br><span>     if (strcmp(dev, &quot;tun&quot;) =
=3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        bool dynamic_opened =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         for (int i =3D =
0; i &lt; 256; ++i)</span><br><span>         {</span><br><span>            =
 snprintf(dynamic_name, sizeof(dynamic_name), &quot;%s%d&quot;, dev, i);</s=
pan><br><span>@@ -3261,7 +3262,6 @@</span><br><span>     if (tt-&gt;reads=
=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><span>     {</span><br><span> =
        BOOL status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       int err;</span><br><span> </span><br><span>         /* reset buf to =
its initial state */</span><br><span>         tt-&gt;reads=2Ebuf =3D tt-&gt=
;reads=2Ebuf_init;</span><br><span>@@ -3288,7 +3288,7 @@</span><br><span>  =
       }</span><br><span>         else</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            err =3D GetLastErro=
r();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            con=
st int err =3D GetLastError();</span><br><span>             if (err =3D=3D =
ERROR_IO_PENDING) /* operation queued? */</span><br><span>             {</s=
pan><br><span>                 tt-&gt;reads=2Eiostate =3D IOSTATE_QUEUED;</=
span><br><span>@@ -3316,7 +3316,6 @@</span><br><span>     if (tt-&gt;writes=
=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><span>     {</span><br><span> =
        BOOL status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       int err;</span><br><span> </span><br><span>         /* make a privat=
e copy of buf */</span><br><span>         tt-&gt;writes=2Ebuf =3D tt-&gt;wr=
ites=2Ebuf_init;</span><br><span>@@ -3343,7 +3342,7 @@</span><br><span>    =
     }</span><br><span>         else</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            err =3D GetLastError(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const=
 int err =3D GetLastError();</span><br><span>             if (err =3D=3D ER=
ROR_IO_PENDING) /* operation queued? */</span><br><span>             {</spa=
n><br><span>                 tt-&gt;writes=2Eiostate =3D IOSTATE_QUEUED;</s=
pan><br><span>@@ -3540,8 +3539,6 @@</span><br><span>         char enum_name=
[256];</span><br><span>         char unit_string[256];</span><br><span>    =
     HKEY unit_key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      char component_id_string[] =3D &quot;ComponentId&quot;;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        char component_id[256];</sp=
an><br><span>         const char net_cfg_instance_id_string[] =3D &quot;Net=
CfgInstanceId&quot;;</span><br><span>         BYTE net_cfg_instance_id[256]=
;</span><br><span>         DWORD data_type;</span><br><span>@@ -3571,6 +356=
8,8 @@</span><br><span>         }</span><br><span>         else</span><br><=
span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        const char component_id_string[] =3D &quot;ComponentId&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            char componen=
t_id[256];</span><br><span>             len =3D sizeof(component_id);</span=
><br><span>             status =3D RegQueryValueEx(unit_key, component_id_s=
tring, NULL, &amp;data_type,</span><br><span>                              =
        (LPBYTE)component_id, &amp;len);</span><br><span>@@ -3655,7 +3654,6=
 @@</span><br><span>         char enum_name[256];</span><br><span>         =
char connection_string[256];</span><br><span>         HKEY connection_key;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        WCHAR name_dat=
a[256];</span><br><span>         DWORD name_type;</span><br><span>         =
const WCHAR name_string[] =3D L&quot;Name&quot;;</span><br><span> </span><b=
r><span>@@ -3687,6 +3685,7 @@</span><br><span>         }</span><br><span>  =
       else</span><br><span>         {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            WCHAR name_data[256];</span><br><span>      =
       len =3D sizeof(name_data);</span><br><span>             status =3D R=
egQueryValueExW(connection_key, name_string, NULL, &amp;name_type,</span><b=
r><span>                                       (LPBYTE)name_data, &amp;len)=
;</span><br><span>@@ -3811,8 +3810,6 @@</span><br><span>     bool warn_pane=
l_dup =3D false;</span><br><span>     bool warn_tap_dup =3D false;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int link=
s;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>  =
   const struct tap_reg *tr;</span><br><span>     const struct tap_reg *tr1=
;</span><br><span>     const struct panel_reg *pr;</span><br><span>@@ -3825=
,7 +3822,7 @@</span><br><span>     /* loop through each TAP-Windows adapter=
 registry entry */</span><br><span>     for (tr =3D tap_reg; tr !=3D NULL; =
tr =3D tr-&gt;next)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        links =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        int links =3D 0;</span><br><span> </span><br>=
<span>         /* loop through each network connections entry in the contro=
l panel */</span><br><span>         for (pr =3D panel_reg; pr !=3D NULL; pr=
 =3D pr-&gt;next)</span><br><span>@@ -4108,10 +4105,11 @@</span><br><span> =
{</span><br><span>     ULONG size =3D 0;</span><br><span>     IP_PER_ADAPTE=
R_INFO *pi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   DWORD status;</span><br><span> </span><br><span>     if (index !=3D TUN_=
ADAPTER_INDEX_INVALID)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        DWORD status;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>         if ((status =3D GetPe=
rAdapterInfo(index, NULL, &amp;size)) !=3D ERROR_BUFFER_OVERFLOW)</span><br=
><span>         {</span><br><span>             msg(M_INFO, &quot;GetPerAdap=
terInfo #1 failed (status=3D%lu) : %s&quot;, status,</span><br><span>@@ -43=
06,7 +4304,6 @@</span><br><span> bool</span><br><span> is_adapter_up(const =
struct tuntap *tt, const IP_ADAPTER_INFO *list)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>   =
  bool ret =3D false;</span><br><span> </span><br><span>     const IP_ADAPT=
ER_INFO *ai =3D get_tun_adapter(tt, list);</span><br><span>@@ -4316,7 +4313=
,7 @@</span><br><span>         const int n =3D get_adapter_n_ip_netmask(ai)=
;</span><br><span> </span><br><span>         /* loop once for every IP/netm=
ask assigned to adapter */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; n; ++i)</span><br><s=
pan>         {</span><br><span>             in_addr_t ip, netmask;</span><b=
r><span>             if (get_adapter_ip_netmask(ai, i, &amp;ip, &amp;netmas=
k))</span><br><span>@@ -4350,7 +4347,6 @@</span><br><span> bool</span><br><=
span> is_ip_in_adapter_subnet(const IP_ADAPTER_INFO *ai, const in_addr_t ip=
, in_addr_t *highest_netmask)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int i;</span><br><span>     bool ret =3D fal=
se;</span><br><span> </span><br><span>     if (highest_netmask)</span><br><=
span>@@ -4361,7 +4357,7 @@</span><br><span>     if (ai)</span><br><span>   =
  {</span><br><span>         const int n =3D get_adapter_n_ip_netmask(ai);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; =
i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   for (int i =3D 0; i &lt; n; ++i)</span><br><span>         {</span><br><s=
pan>             in_addr_t adapter_ip, adapter_netmask;</span><br><span>   =
          if (get_adapter_ip_netmask(ai, i, &amp;adapter_ip, &amp;adapter_n=
etmask))</span><br><span>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/w=
in32=2Ec</span><br><span>index 618772d=2E=2E82341f8 100644</span><br><span>=
--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</sp=
an><br><span>@@ -1041,7 +1041,6 @@</span><br><span> openvpn_execve(const st=
ruct argv *a, const struct env_set *es, const unsigned int flags)</span><br=
><span> {</span><br><span>     int ret =3D OPENVPN_EXECVE_ERROR;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    static bool exec_warn =3D fa=
lse;</span><br><span> </span><br><span>     if (a &amp;&amp; a-&gt;argv[0])=
</span><br><span>     {</span><br><span>@@ -1092,6 +1091,8 @@</span><br><sp=
an>         }</span><br><span>         else</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            static bool =
exec_warn =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>             ret =3D OPENVPN_EXECVE_NOT_ALLOWED;</span><b=
r><span>             if (!exec_warn &amp;&amp; (script_security() &lt; SSEC=
_SCRIPTS))</span><br><span>             {</span><br><span>@@ -1508,11 +1509=
,10 @@</span><br><span> static void</span><br><span> set_openssl_env_vars(v=
oid)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const WCHAR *ssl_fallback_dir =3D L&quot;C:\\Windows\\System32&quot;;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>    =
 WCHAR install_path[MAX_PATH] =3D { 0 };</span><br><span>     if (!get_open=
vpn_reg_value(NULL, install_path, _countof(install_path)))</span><br><span>=
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const=
 WCHAR *ssl_fallback_dir =3D L&quot;C:\\Windows\\System32&quot;;</span><br>=
<span>         /* if we cannot find installation path from the registry,</s=
pan><br><span>          * use Windows directory as a fallback</span><br><sp=
an>          */</span><br><span>diff --git a/src/openvpnserv/common=2Ec b/s=
rc/openvpnserv/common=2Ec</span><br><span>index cce5318=2E=2E7a23d41 100644=
</span><br><span>--- a/src/openvpnserv/common=2Ec</span><br><span>+++ b/src=
/openvpnserv/common=2Ec</span><br><span>@@ -254,10 +254,8 @@</span><br><spa=
n> MsgToEventLog(DWORD flags, LPCWSTR format, =2E=2E=2E)</span><br><span> {=
</span><br><span>     HANDLE hEventSource;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    WCHAR msg[2][256];</span><br><span>     DWORD erro=
r =3D 0;</span><br><span>     LPCWSTR err_msg =3D L&quot;&quot;;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    va_list arglist;</span><br><=
span> </span><br><span>     if (flags &amp; MSG_FLAGS_SYS_CODE)</span><br><=
span>     {</span><br><span>@@ -268,6 +266,9 @@</span><br><span>     hEvent=
Source =3D RegisterEventSource(NULL, APPNAME);</span><br><span>     if (hEv=
entSource !=3D NULL)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        va_list arglist;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        WCHAR msg[2][256];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         swprintf(msg[=
0], _countof(msg[0]), L&quot;%ls%ls%ls: %ls&quot;, APPNAME, service_instanc=
e,</span><br><span>                  (flags &amp; MSG_FLAGS_ERROR) ? L&quot=
; error&quot; : L&quot;&quot;, err_msg);</span><br><span> </span><br><span>=
@@ -311,10 +312,10 @@</span><br><span> const wchar_t *</span><br><span> get=
_win_sys_path(void)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const wchar_t *default_sys_path =3D L&quot;C:\\Windows=
\\system32&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     if (!GetSystemDirectoryW(win_sys_path, _countof(win_sys_p=
ath)))</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        const wchar_t *default_sys_path =3D L&quot;C:\\Windows\\s=
ystem32&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>         wcscpy_s(win_sys_path, _countof(win_sys_path), default=
_sys_path);</span><br><span>         win_sys_path[_countof(win_sys_path) - =
1] =3D L&#39;\0&#39;;</span><br><span>     }</span><br><span>diff --git a/s=
rc/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br>=
<span>index 4a38aa4=2E=2E1d9a5d87 100644</span><br><span>--- a/src/openvpns=
erv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</=
span><br><span>@@ -933,7 +933,6 @@</span><br><span> RegisterDNS(LPVOID unus=
ed)</span><br><span> {</span><br><span>     DWORD err;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    size_t i;</span><br><span>     DWORD t=
imeout =3D RDNS_TIMEOUT * 1000; /* in milliseconds */</span><br><span> </sp=
an><br><span>     /* path of ipconfig command */</span><br><span>@@ -956,7 =
+955,7 @@</span><br><span>     if (WaitForMultipleObjects(2, wait_handles, =
FALSE, timeout) =3D=3D WAIT_OBJECT_0)</span><br><span>     {</span><br><spa=
n>         /* Semaphore locked */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        for (i =3D 0; i &lt; _countof(cmds); ++i)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        for (size_t i =3D 0; i &l=
t; _countof(cmds); ++i)</span><br><span>         {</span><br><span>        =
     ExecCommand(cmds[i]=2Eargv0, cmds[i]=2Ecmdline, cmds[i]=2Etimeout);</s=
pan><br><span>         }</span><br><span>diff --git a/src/openvpnserv/servi=
ce=2Ec b/src/openvpnserv/service=2Ec</span><br><span>index 04b20d7=2E=2E291=
3f63 100644</span><br><span>--- a/src/openvpnserv/service=2Ec</span><br><sp=
an>+++ b/src/openvpnserv/service=2Ec</span><br><span>@@ -21,7 +21,6 @@</spa=
n><br><span> BOOL</span><br><span> ReportStatusToSCMgr(SERVICE_STATUS_HANDL=
E service, SERVICE_STATUS *status)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    static DWORD dwCheckPoint =3D 1;</span>=
<br><span>     BOOL res =3D TRUE;</span><br><span> </span><br><span>     if=
 (status-&gt;dwCurrentState =3D=3D SERVICE_START_PENDING)</span><br><span>@=
@ -39,6 +38,7 @@</span><br><span>     }</span><br><span>     else</span><br=
><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  static DWORD dwCheckPoint =3D 1;</span><br><span>         status-&gt;dwCh=
eckPoint =3D dwCheckPoint++;</span><br><span>     }</span><br><span> </span=
><br><span>@@ -55,7 +55,6 @@</span><br><span> static int</span><br><span> C=
mdInstallServices(void)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    SC_HANDLE service;</span><br><span>     SC_HANDLE =
svc_ctl_mgr;</span><br><span>     WCHAR path[512];</span><br><span>     int=
 i, ret =3D _service_max;</span><br><span>@@ -78,7 +77,7 @@</span><br><span=
> </span><br><span>     for (i =3D 0; i &lt; _service_max; i++)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        se=
rvice =3D CreateService(</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        SC_HANDLE service =3D CreateService(</span><br><span>         =
    svc_ctl_mgr, openvpn_service[i]=2Ename, openvpn_service[i]=2Edisplay_na=
me,</span><br><span>             SERVICE_QUERY_STATUS, SERVICE_WIN32_SHARE_=
PROCESS, openvpn_service[i]=2Estart_type,</span><br><span>             SERV=
ICE_ERROR_NORMAL, path, NULL, NULL, openvpn_service[i]=2Edependencies, NULL=
, NULL);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_provide=
r=2Ec b/tests/unit_tests/openvpn/test_provider=2Ec</span><br><span>index 56=
19f36=2E=2Ee5562ee 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_provider=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_provide=
r=2Ec</span><br><span>@@ -378,12 +378,11 @@</span><br><span> static void</s=
pan><br><span> xkey_provider_test_generic_sign_cb(void **state)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    EVP_PKEY *=
pubkey;</span><br><span>     const char *dummy =3D &quot;xkey_handle&quot;;=
 /* a dummy handle for the external key */</span><br><span> </span><br><spa=
n>     for (size_t i =3D 0; i &lt; _countof(pubkeys); i++)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pubkey =
=3D load_pubkey(pubkeys[i]);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        EVP_PKEY *pubkey =3D load_pubkey(pubkeys[i]);</span><br><s=
pan>         assert_non_null(pubkey);</span><br><span> </span><br><span>   =
      EVP_PKEY *privkey =3D</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1963?usp=3Demail">change 1963</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1963?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib=
69b6c7a5f21f8552159c94560830f182c6238b7 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1963 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--vIo7nAqsVCw=--


--===============4545417144211296646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4545417144211296646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4545417144211296646==--

