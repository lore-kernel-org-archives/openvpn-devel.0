Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDAAC5AC80
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 08:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gzahaD2j7l1MnfqQn8rYVk+0yGNYyL0ZATkvfQk6FoI=; b=SWoHwI98dY9DzkrTn0yoU3hIlk
	Xzi8GKZnaPbdiW1NUsU0ktCXSXz2u1HYDk0Or4rLzMxPd/F+sVQ/yERrJBC3FlxTnl1Hf+hK1cwD5
	alH3IO51QF2N8CQ0xs7kxRCTKOq+1R+RGcyxyF61numSuQ/SjIkPzJ3xStr68cis2VZA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsyws-0007QQ-6k;
	Sun, 09 Aug 2026 08:31:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsywX-0007Hg-9e
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 08:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Y0FRlSwcAUrtxhaWvSN3GBy+sOzAe/YxnCul70S82Jg=; b=CBwyzzHINGtZ5Z6rYgZ+gCjJFG
 2NyUG1+VwPJnYxRDzPtrmSTcXf/mJa8VIXIPm6QM/ffSas4IFy3uOLLny79MQocmCHItQoVcKuo92
 Goo7MWUGBIkNxphAtk/S4YxPd3xFN0ceRalZveVAY/lme0vprVr2tx1d1HUpzIzIer04=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Y0FRlSwcAUrtxhaWvSN3GBy+sOzAe/YxnCul70S82Jg=; b=m
 7bmzvCGcA9c7HrL7Q6AnHZpkQQqQywXmNyseb4IZg38L0FSfPDq0HxVVS/o3EIoZ6k3TCxP5klN7G
 61iaE47XrowGjmsq2y6EaS202LSntJ+uxz7/Bs0LmKWuFTYforazmn7VDdtqL3NDQwPBMIySEsrJo
 l7Ok5LHd0jZmlFv8=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsywW-0001xk-45 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 08:31:38 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so449437f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 09 Aug 2026 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786264290; x=1786869090; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y0FRlSwcAUrtxhaWvSN3GBy+sOzAe/YxnCul70S82Jg=;
 b=SFFrldhV/GsvbVKceqzHZncE6wNqdn6Q5HEOrV/9ylTGg253FOrnz50+lMEl6Jh+AA
 g2XIs9MjVu9/R5hbk1P9YoGMuMgsQk/qrIwcS3xl11Ex11DLmpiAQTOwsLLK1Yri0h+d
 5ecoyehQSF97bNzKSm3pGrD7RgACrYmZBF6+5TFyLTGEvpVy0wZ3CDdVdZIe/amNL3Nd
 RkdK6YgA8IIv745rO4T6xVzdG0rgKR4RsxuCH2Oj3YQciRx9JIv3RkEUH8oxhK9A160i
 ioCMasKzCJHOmbecOxN8SnrwSNO1AtFdUnHoBw2CA6W7GayY8g1hu0w1MHtkIOHxD23f
 35AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786264290; x=1786869090;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y0FRlSwcAUrtxhaWvSN3GBy+sOzAe/YxnCul70S82Jg=;
 b=TsEUz+ekWFJGRkLUE1Apyz+2Q137Jrp0KEvO7jDwayIFNBjT598UyBdD1am3+I0Hhs
 EQRkeQBNwcp5AHMYJs4MGQjtn9WWCczM37CVh9JLhHY4Ve7Es1bMkukkepBxjoWAF0I4
 imQYaxU+cUUywAueE4XWQzHp2KXIoVUEwvh+o1zhRZ7obEBldxloJSXXZrUbLjul8lIg
 jvGQHO1i8Qj8a0b0DiSmII9uDuX76jn7QgVjRAnYUb5K1tkE85C068oKrBcouHdaZOsH
 BJ895gKZBS6GaFanDq2ZnVcxwV8sSf1RB0bGBHw0o4QzA5NcMTkWxOzFpioSmgi2J56h
 2hgA==
X-Gm-Message-State: AOJu0YwAjFNhB+EYWtRn2/3uxyIeHIS9u6APwNsVO1sUy6tTxX1OqG1O
 M/2LEw68kR/k0XXtXMJJ+EeZM1kFDJINyotu55QM4oXDNJjEQRupsoTb1Y+2VMg2Iz0WQWf1nYW
 7D6LMtAYxAyNikvOizXoXrbAb6bhU7gsHR8X4fvtzqAgW/aGAG6OvB/+BEYSoVal+qdQ+
X-Gm-Gg: AR+sD13bLNgz0320OozYc/qJhgXb4JuWntoKs5fbRvsb27deYbAPCptIRhnki18q+p8
 4bYvtwBfse7kvQ66KnLBV8KX87glRex2sknFWWuS7huNvoahtAIJBbtnIDST5cxfh8Oi7pJ8MXt
 buZPKMn2cO8yBuUiHmkIVbaMoWxZ5sPEbh3Jsd7HPcUWCLgwv30Sa9KeTiLqQ+7Rva0lSkCUpgl
 iO+p+zC9qDbWdfCW/pzTJeWxZfNzQUoyckfncSJbFl5UaMBQabH3nCiz2StJCqRuarpQ1+q3J3w
 3gtQBm8dgCxBlnfG2f1WEa0Oam9XqyowaQ0qbrwYEE3k8pqVGMHo2SYtXgHy52PjeMgp2hwKZgA
 5gGS+8KCyl7rQheqz4ziJgXHVnesA6yg/Jg4P6b9SddarPZlbjSuWoHR9V7G6SM5excNbV5E5Fh
 yu8bd8WbszqELwKyA1xNrdtV+HMJ6ZYER26DoM8sUnSsjhyik8DxPMSbccPdR9iGy+rpsFscOn3
 zzAGm4haGGzYb1HwINorlF0NG/sq7G2vbm0J1JuWUqQRjyyNEuTFvafQabLsGLbJqXPjh9AKDcD
 g9rqahtLubKzdiXolaRJpLet/m51IK6mt3rDWC1HqEFhubUWWbE=
X-Received: by 2002:a05:6000:310c:b0:47f:f828:9f32 with SMTP id
 ffacd0b85a97d-47ff828a374mr35507567f8f.27.1786264289657; 
 Sun, 09 Aug 2026 01:31:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4813ccea399sm6166830f8f.13.2026.08.09.01.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:31:29 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 9 Aug 2026 08:31:28 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
X-Gerrit-Change-Number: 1800
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1800?usp=email>
X-Gerrit-Commit: 06ced3fd84e4e28f2774c4156f8032a2bed736a2
In-Reply-To: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
References: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzIyNzQ0MDAwLklhZDk0ZTdhOWQwYjNiZThhOGRiMDllOWEyMGVhYWM2MDQxNDcwYWI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <62b58ed92bf0ebfcc8ddf283222a6b87e5a52b54-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsywW-0001xk-45
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow extracing
 other integers from peer info and add a unit test for it
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2835101542015204216=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2835101542015204216==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aB7brfMVscE="; charset=UTF-8

--aB7brfMVscE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1800?usp=3Demail )

Change subject: Allow extracing other integers from=
 peer info and add a unit test for it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Allow extracing other integers from peer info and=
 add a unit test for it

This also ensure that we only really extract the v=
ariable we are looking
for=2E The old code would also consider UV_IV_NCP to=
 be IV_NCP=2E

Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
Signed-=
off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800=

Message-Id: <20260808154933=2E17540-1-gert@greenie=2Emuc=2Ede>
URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38241=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLi=
sts=2Etxt
M src/openvpn/push=2Ec
M src/openvpn/ssl_ncp=2Ec
M src/openvpn/ss=
l_util=2Ec
M src/openvpn/ssl_util=2Eh
M tests/unit_tests/openvpn/Makefile=
=2Eam
M tests/unit_tests/openvpn/test_push_update_msg=2Ec
M tests/unit_test=
s/openvpn/test_ssl=2Ec
8 files changed, 159 insertions(+), 50 deletions(-)
=




diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 3ff2734=2E=2Eaab=
bcb6 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -916,7 +916,8 =
@@
         src/openvpn/options_util=2Ec
         src/openvpn/otime=2Ec
   =
      src/openvpn/list=2Ec
-        )
+        src/openvpn/ssl_util=2Ec
+  =
  )
 
     target_sources(test_argv PRIVATE
         tests/unit_tests/openv=
pn/mock_get_random=2Ec
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=
=2Ec
index 633c007d=2E=2Ece2baf2 100644
--- a/src/openvpn/push=2Ec
+++ b/sr=
c/openvpn/push=2Ec
@@ -718,9 +718,9 @@
 
     /* Push our mtu to the peer i=
f it supports pushable MTUs */
     int client_max_mtu =3D 0;
-    const ch=
ar *iv_mtu =3D extract_var_peer_info(tls_multi->peer_info, "IV_MTU=3D", gc)=
;
+    unsigned int iv_mtu =3D peer_info_extract_uint(tls_multi->peer_info,=
 "IV_MTU=3D");
 
-    if (iv_mtu && sscanf(iv_mtu, "%d", &client_max_mtu) =
=3D=3D 1)
+    if (iv_mtu !=3D 0)
     {
         push_option_fmt(gc, push_=
list, M_USAGE, "tun-mtu %d", o->ce=2Etun_mtu);
         if (client_max_mtu =
< o->ce=2Etun_mtu)
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_n=
cp=2Ec
index b450de8=2E=2E8b0f28d 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ =
b/src/openvpn/ssl_ncp=2Ec
@@ -55,20 +55,10 @@
  * Return the Negotiable Cry=
pto Parameters version advertised in the peer info
  * string, or 0 if none=
 specified=2E
  */
-static int
+static unsigned int
 tls_peer_info_ncp_ver(=
const char *peer_info)
 {
-    const char *ncpstr =3D peer_info ? strstr(pe=
er_info, "IV_NCP=3D") : NULL;
-    if (ncpstr)
-    {
-        int ncp =3D =
0;
-        int r =3D sscanf(ncpstr, "IV_NCP=3D%d", &ncp);
-        if (r =
=3D=3D 1)
-        {
-            return ncp;
-        }
-    }
-    return=
 0;
+    return peer_info_extract_uint(peer_info, "IV_NCP=3D");
 }
 
 /**
d=
iff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index 2f01f=
8a=2E=2Eba185c1 100644
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ssl=
_util=2Ec
@@ -27,26 +27,56 @@
 #include "openvpn=2Eh"
 #include "ssl_util=
=2Eh"
 
-char *
-extract_var_peer_info(const char *peer_info, const char *v=
ar, struct gc_arena *gc)
+/**
+ * Looks for the string field at the start o=
f peer_info or
+ * after any new line and returns a pointer to the start of=
 the field
+ * or NULL if not found=2E
+ */
+static const char *
+peer_info=
_extract_varstr(const char *peer_info, const char *field)
 {
     if (!peer=
_info)
     {
         return NULL;
     }
 
-    const char *var_start =3D=
 strstr(peer_info, var);
+    while (peer_info)
+    {
+        /* peer inf=
o starts with this field */
+        if (strncmp(peer_info, field, strlen(f=
ield)) =3D=3D 0)
+        {
+            return peer_info;
+        }
+
+  =
      /* skip to the next line */
+        peer_info =3D strchr(peer_info, =
'\n');
+        if (peer_info)
+        {
+            /* skip the '\n' its=
elf */
+            peer_info++;
+        }
+    }
+    return NULL;
+}
+
+=
char *
+extract_var_peer_info(const char *peer_info, const char *var, struc=
t gc_arena *gc)
+{
+    const char *var_start =3D peer_info_extract_varstr(=
peer_info, var);
     if (!var_start)
     {
-        /* variable not found=
 in peer info */
+        /* variable hasn't been found in peer info */
   =
      return NULL;
     }
 
+    /* skip over the variable name (includes t=
he =3D as per API)*/
     var_start +=3D strlen(var);
-    const char *var_=
end =3D strstr(var_start, "\n");
+
+    /* returns the location of the next=
 '\n' or the end of the
+     * string if the variable is already on the la=
st line */
+    const char *var_end =3D strchr(var_start, '\n');
     if (!=
var_end)
     {
-        /* var is at end of the peer_info list and no '\n'=
 follows */
         var_end =3D var_start + strlen(var_start);
     }
 
@@=
 -56,38 +86,40 @@
     return var_value;
 }
 
+
 unsigned int
-extract_iv_p=
roto(const char *peer_info)
+peer_info_extract_int(const char *peer_info, c=
onst char *field, const char *format, unsigned int default_value)
 {
-    c=
onst char *optstr =3D peer_info ? strstr(peer_info, "IV_PROTO=3D") : NULL;
=
+    const char *optstr =3D peer_info_extract_varstr(peer_info, field);
   =
  if (optstr)
     {
-        int proto =3D 0;
-        int r =3D sscanf(op=
tstr, "IV_PROTO=3D%d", &proto);
-        if (r =3D=3D 1 && proto > 0)
+    =
    optstr +=3D strlen(field);
+
+        int value =3D 0;
+        int r =
=3D sscanf(optstr, format, &value);
+        if (r =3D=3D 1 && value >=3D 0=
)
         {
-            return proto;
+            return value;
        =
 }
     }
-    return 0;
+    return default_value;
+}
+
+unsigned int
+pee=
r_info_extract_uint(const char *peer_info, const char *field)
+{
+    retur=
n peer_info_extract_int(peer_info, field, "%u", 0);
 }
 
 uint32_t
 extract=
_asymmetric_peer_id(const char *peer_info)
 {
-    for (const char *p =3D p=
eer_info; p && (p =3D strstr(p, "ID=3D")); p +=3D 3)
+    uint32_t peer_id =
=3D peer_info_extract_int(peer_info, "ID=3D", "%x", MAX_PEER_ID);
+    if (=
peer_id < MAX_PEER_ID)
     {
-        /* only accept "ID=3D" at the start =
of a line, so it does not match
-         * substrings like "UV_ID=3D" or "=
GUID=3D" */
-        if (p =3D=3D peer_info || p[-1] =3D=3D '\n')
-        =
{
-            uint32_t peer_id =3D 0;
-            if (sscanf(p, "ID=3D%x"=
, &peer_id) =3D=3D 1 && peer_id < MAX_PEER_ID)
-            {
-            =
    return peer_id;
-            }
-        }
+        return peer_id;
    =
 }
+
     return MAX_PEER_ID;
 }
 
diff --git a/src/openvpn/ssl_util=2Eh b/=
src/openvpn/ssl_util=2Eh
index 1a69e6f=2E=2E6f9f65b 100644
--- a/src/openvp=
n/ssl_util=2Eh
+++ b/src/openvpn/ssl_util=2Eh
@@ -33,11 +33,33 @@
 #include=
 "buffer=2Eh"
 
 /**
+ * Extracts the named integer variable and returns it=
s value or default_value
+ * if it cannot be extracted=2E
+ *
+ * @param pe=
er_info     peer info string to search in
+ * @param field         name of =
the field to be extracted including the =3D
+ * @param format        sscanf=
/printf format string of the type to extract
+ * @param default_value defau=
lt value to return if the field cannot be extracted
+ */
+unsigned int
+pee=
r_info_extract_int(const char *peer_info, const char *field, const char *fo=
rmat, unsigned int default_value);
+
+/**
+ * Extracts the named integer va=
riable and returns its value or 0
+ * if it cannot be extracted=2E
+ *
+ * =
@param peer_info     peer info string to search in
+ * @param field        =
  name of the field to be extracted
+ */
+unsigned int
+peer_info_extract_u=
int(const char *peer_info, const char *field);
+
+/**
  * Extracts a variab=
le from peer info, the returned string will be allocated
  * using the supp=
lied gc_arena
  *
  * @param peer_info     The peer's peer_info
- * @param =
var           The variable *including* =3D, e=2Eg=2E IV_CIPHERS=3D
+ * @par=
am var           The variable including =3D, e=2Eg=2E IV_CIPHERS=3D
  * @pa=
ram gc            GC arena to allocate return value in
  *
  * @return  The=
 content of the variable as NULL terminated string or NULL if the
@@ -51,8 =
+73,11 @@
  *
  * @param peer_info     peer info string to search for IV_PR=
OTO
  */
-unsigned int extract_iv_proto(const char *peer_info);
-
+static i=
nline unsigned int
+extract_iv_proto(const char *peer_info)
+{
+    return =
peer_info_extract_uint(peer_info, "IV_PROTO=3D");
+}
 
 /**
  * Extracts th=
e ID variable and returns its value or
diff --git a/tests/unit_tests/openvp=
n/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 9174ed0=2E=
=2E38adfd7 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/=
unit_tests/openvpn/Makefile=2Eam
@@ -400,7 +400,8 @@
 	$(top_srcdir)/src/op=
envpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
 	$(top=
_srcdir)/src/openvpn/otime=2Ec \
-	$(top_srcdir)/src/openvpn/list=2Ec
+	$(t=
op_srcdir)/src/openvpn/list=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_util=2Ec
=
 
 socket_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir=
)/src/compat -I$(top_srcdir)/src/openvpn \
diff --git a/tests/unit_tests/op=
envpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_=
msg=2Ec
index 219b476=2E=2E389fa09 100644
--- a/tests/unit_tests/openvpn/te=
st_push_update_msg=2Ec
+++ b/tests/unit_tests/openvpn/test_push_update_msg=
=2Ec
@@ -188,12 +188,6 @@
 {
     return true;
 }
-
-unsigned int
-extract_=
iv_proto(const char *peer_info)
-{
-    return IV_PROTO_PUSH_UPDATE;
-}
 #e=
ndif /* ifdef ENABLE_MANAGEMENT */
 
 /* tests */
@@ -650,6 +644,7 @@
     =
m->instances =3D calloc(1, sizeof(struct multi_instance *));
     struct mu=
lti_instance *mi =3D calloc(1, sizeof(struct multi_instance));
     mi->con=
text=2Ec2=2Etls_multi =3D calloc(1, sizeof(struct tls_multi));
+    mi->con=
text=2Ec2=2Etls_multi->peer_info =3D "IV_PROTO=3D4096";  // IV_PROTO_PUSH_U=
PDATE
     *(m->instances) =3D mi;
     m->top=2Eoptions=2Edisable_dco =3D =
true;
     *state =3D m;
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec=
 b/tests/unit_tests/openvpn/test_ssl=2Ec
index d473d67=2E=2E3e84fb8 100644
=
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/=
test_ssl=2Ec
@@ -48,7 +48,9 @@
 #include "buffer=2Eh"
 #include "cert_data=
=2Eh"
 #include "packet_id=2Eh"
+#include "ssl_util=2Eh"
 #include "ssl_ver=
ify=2Eh"
+#include "openvpn=2Eh"
 
 /* Mock function to be allowed to inclu=
de win32=2Ec which is required for
  * getting the temp directory */
@@ -88=
4,6 +886,68 @@
     free_certificate(cert);
 }
 
+void
+ssl_test_extract_pe=
er_info(void **state)
+{
+    const char *peer_info_normal =3D
+        "IV=
_VER=3D2=2E6_git\nIV_PLAT=3Dmac\nIV_TCPNL=3D1\nIV_NCP=3D2\n"
+        "IV_C=
IPHERS=3DAES-256-GCM:AES-128-GCM:CHACHA20-POLY1305\n"
+        "IV_PROTO=3D=
94\nIV_LZO_STUB=3D1\nIV_COMP_STUB=3D1\nP=3D78\nIV_COMP_STUBv2=3D1\n"
+     =
   "IV_SSL=3DOpenSSL_3=2E0=2E5_5_Jul_2022\nIV_LZ4v2=3D1";
+
+    const char=
 *empty =3D "";
+    const char *invalid_proto =3D "IV_PROTO=3Dseven\nIV_SS=
L=3D7\nP=3D300\nID=3Dxyz";
+    const char *test_prefix =3D "UV_IV_PROTO=3D=
773\nNP=3D112\nPD=3D8\n";
+
+
+    assert_int_equal(extract_iv_proto(peer_i=
nfo_normal), 94);
+    assert_int_equal(extract_iv_proto(empty), 0);
+    a=
ssert_int_equal(extract_iv_proto(invalid_proto), 0);
+    /* This should no=
t pick up the UV_IV_PROTO that has the extra prefix */
+    assert_int_equa=
l(extract_iv_proto(test_prefix), 0);
+
+    assert_int_equal(peer_info_extr=
act_uint(peer_info_normal, "IV_COMP_STUB=3D"), 1);
+    assert_int_equal(pe=
er_info_extract_int(empty, "IV_COMP_STUB=3D", "%d", 0xfe0d0d), 0xfe0d0d);
+=
    assert_int_equal(peer_info_extract_uint(invalid_proto, "IV_COMP_STUB=3D=
"), 0);
+
+    assert_int_equal(peer_info_extract_int(test_prefix, "NP=3D",=
 "%d", 23), 112);
+    assert_int_equal(peer_info_extract_uint(test_prefix,=
 "PD=3D"), 8);
+    assert_int_equal(peer_info_extract_int(test_prefix, "P=
=3D", "%x", 0xfe0d0d), 0xfe0d0d);
+    assert_int_equal(peer_info_extract_u=
int(peer_info_normal, "P=3D"), 78);
+    assert_int_equal(peer_info_extract=
_uint(test_prefix, "UV_IV_PROTO=3D"), 773);
+
+    struct gc_arena gc =3D g=
c_new();
+
+    const char *peer_ciphers =3D extract_var_peer_info(peer_inf=
o_normal, "IV_CIPHERS=3D", &gc);
+    assert_string_equal(peer_ciphers, "AE=
S-256-GCM:AES-128-GCM:CHACHA20-POLY1305");
+
+    /* with the extra =3D thi=
s should not extract anything */
+    const char *proto =3D extract_var_pee=
r_info(peer_info_normal, "IV_PROTO=3D=3D", &gc);
+    assert_null(proto);
+=

+    proto =3D extract_var_peer_info(peer_info_normal, "IV_PROTO=3D", &gc)=
;
+    assert_string_equal(proto, "94");
+
+
+    const char *double_eq_inf=
o =3D "FOO=3D7\nFOO=3D=3Dnew";
+    const char *foo_eq =3D extract_var_peer=
_info(double_eq_info, "FOO=3D", &gc);
+    const char *foo =3D extract_var_=
peer_info(double_eq_info, "FOO", &gc);
+    const char *foo_2eq =3D extract=
_var_peer_info(double_eq_info, "FOO=3D=3D", &gc);
+
+    assert_string_equa=
l(foo, "=3D7");
+    assert_string_equal(foo_eq, "7");
+    assert_string_e=
qual(foo_2eq, "new");
+
+    assert_int_equal(extract_asymmetric_peer_id(do=
uble_eq_info), MAX_PEER_ID);
+    assert_int_equal(extract_asymmetric_peer_=
id(peer_info_normal), MAX_PEER_ID);
+    assert_int_equal(extract_asymmetri=
c_peer_id(invalid_proto), MAX_PEER_ID);
+    assert_int_equal(extract_asymm=
etric_peer_id("ID=3Df7"), 0xf7);
+    assert_int_equal(extract_asymmetric_p=
eer_id("X=3Dfoo\nID=3D12ab"), 0x12ab);
+    assert_int_equal(extract_asymme=
tric_peer_id("X=3Dfoo\nID=3D34dd\nY=3Dbar"), 0x34dd);
+    assert_int_equal=
(extract_asymmetric_peer_id("X=3Dfoo\nID=3D12345678"), MAX_PEER_ID);
+
+   =
 gc_free(&gc);
+}
 
 int
 main(void)
@@ -908,7 +972,8 @@
         cmocka_un=
it_test(test_data_channel_roundtrip_bf_cbc),
         cmocka_unit_test(test=
_data_channel_known_vectors_epoch),
         cmocka_unit_test(test_data_cha=
nnel_known_vectors_shortpktid),
-        cmocka_unit_test(crypto_test_print=
_cert_details)
+        cmocka_unit_test(crypto_test_print_cert_details),
+=
        cmocka_unit_test(ssl_test_extract_peer_info)
 
     };
 

-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaa=
c6041470ab6
Gerrit-Change-Number: 1800
Gerrit-PatchSet: 8
Gerrit-Owner: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2E=
muc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--aB7brfMVscE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1800?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Allow extracing other integers from peer i=
nfo and add a unit test for it<br><br>This also ensure that we only really =
extract the variable we are looking<br>for=2E The old code would also consi=
der UV_IV_NCP to be IV_NCP=2E<br><br>Change-Id: Iad94e7a9d0b3be8a8db09e9a20=
eaac6041470ab6<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br=
>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800<br>Message-Id: &lt;202608081549=
33=2E17540-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38241=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=
=2Etxt<br>M src/openvpn/push=2Ec<br>M src/openvpn/ssl_ncp=2Ec<br>M src/open=
vpn/ssl_util=2Ec<br>M src/openvpn/ssl_util=2Eh<br>M tests/unit_tests/openvp=
n/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_push_update_msg=2Ec<br>M=
 tests/unit_tests/openvpn/test_ssl=2Ec<br>8 files changed, 159 insertions(+=
), 50 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLi=
sts=2Etxt</span><br><span>index 3ff2734=2E=2Eaabbcb6 100644</span><br><span=
>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><s=
pan>@@ -916,7 +916,8 @@</span><br><span>         src/openvpn/options_util=
=2Ec</span><br><span>         src/openvpn/otime=2Ec</span><br><span>       =
  src/openvpn/list=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
rc/openvpn/ssl_util=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    )</span><br><span> </span><br><span>     target_sources(test_argv P=
RIVATE</span><br><span>         tests/unit_tests/openvpn/mock_get_random=2E=
c</span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec<=
/span><br><span>index 633c007d=2E=2Ece2baf2 100644</span><br><span>--- a/sr=
c/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><sp=
an>@@ -718,9 +718,9 @@</span><br><span> </span><br><span>     /* Push our m=
tu to the peer if it supports pushable MTUs */</span><br><span>     int cli=
ent_max_mtu =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 const char *iv_mtu =3D extract_var_peer_info(tls_multi-&gt;peer_info, &quo=
t;IV_MTU=3D&quot;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    unsigned int iv_mtu =3D peer_info_extract_uint(tls_multi-&gt;peer_i=
nfo, &quot;IV_MTU=3D&quot;);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (iv_mtu &amp;&amp; sscanf(iv_mtu, &quot;%d&=
quot;, &amp;client_max_mtu) =3D=3D 1)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (iv_mtu !=3D 0)</span><br><span>     {</span><br><=
span>         push_option_fmt(gc, push_list, M_USAGE, &quot;tun-mtu %d&quot=
;, o-&gt;ce=2Etun_mtu);</span><br><span>         if (client_max_mtu &lt; o-=
&gt;ce=2Etun_mtu)</span><br><span>diff --git a/src/openvpn/ssl_ncp=2Ec b/sr=
c/openvpn/ssl_ncp=2Ec</span><br><span>index b450de8=2E=2E8b0f28d 100644</sp=
an><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/src/openvp=
n/ssl_ncp=2Ec</span><br><span>@@ -55,20 +55,10 @@</span><br><span>  * Retur=
n the Negotiable Crypto Parameters version advertised in the peer info</spa=
n><br><span>  * string, or 0 if none specified=2E</span><br><span>  */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static unsigned int</span><br><span=
> tls_peer_info_ncp_ver(const char *peer_info)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    const char *ncpstr =3D peer=
_info ? strstr(peer_info, &quot;IV_NCP=3D&quot;) : NULL;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (ncpstr)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        int ncp =3D 0;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        int r =3D sscanf(ncpstr, &quot;IV_NCP=3D%d&quot;, &am=
p;ncp);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (r =
=3D=3D 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            return ncp;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return peer_info_extract_uint(peer_info, &quot;IV_NC=
P=3D&quot;);</span><br><span> }</span><br><span> </span><br><span> /**</spa=
n><br><span>diff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2E=
c</span><br><span>index 2f01f8a=2E=2Eba185c1 100644</span><br><span>--- a/s=
rc/openvpn/ssl_util=2Ec</span><br><span>+++ b/src/openvpn/ssl_util=2Ec</spa=
n><br><span>@@ -27,26 +27,56 @@</span><br><span> #include &quot;openvpn=2Eh=
&quot;</span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-char *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-extract_var_peer_info(const char *pe=
er_info, const char *var, struct gc_arena *gc)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Looks for the string field at the start of peer_info or</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * after any new line and=
 returns a pointer to the start of the field</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * or NULL if not found=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static const char *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+peer_info_extract_varstr(const char *peer_info, const cha=
r *field)</span><br><span> {</span><br><span>     if (!peer_info)</span><br=
><span>     {</span><br><span>         return NULL;</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
const char *var_start =3D strstr(peer_info, var);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    while (peer_info)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* peer info starts with this field */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (strncmp(peer_inf=
o, field, strlen(field)) =3D=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return peer_info;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* ski=
p to the next line */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        peer_info =3D strchr(peer_info, &#39;\n&#39;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (peer_info)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            /* skip the &#39;\n&#39; itself *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            peer_i=
nfo++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ch=
ar *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+extract_var_pee=
r_info(const char *peer_info, const char *var, struct gc_arena *gc)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const char *var_start =3D peer_info_extra=
ct_varstr(peer_info, var);</span><br><span>     if (!var_start)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*=
 variable not found in peer info */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* variable hasn&#39;t been found in peer info */</=
span><br><span>         return NULL;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* skip over =
the variable name (includes the =3D as per API)*/</span><br><span>     var_=
start +=3D strlen(var);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const char *var_end =3D strstr(var_start, &quot;\n&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* returns the location of the next &#39;\n&#=
39; or the end of the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * string if the variable is already on the last line */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *var_end =3D strc=
hr(var_start, &#39;\n&#39;);</span><br><span>     if (!var_end)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*=
 var is at end of the peer_info list and no &#39;\n&#39; follows */</span><=
br><span>         var_end =3D var_start + strlen(var_start);</span><br><spa=
n>     }</span><br><span> </span><br><span>@@ -56,38 +86,40 @@</span><br><s=
pan>     return var_value;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> unsigned int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-extract_iv_proto(const=
 char *peer_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pe=
er_info_extract_int(const char *peer_info, const char *field, const char *f=
ormat, unsigned int default_value)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *optstr =3D peer_info ? strs=
tr(peer_info, &quot;IV_PROTO=3D&quot;) : NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *optstr =3D peer_info_extract_var=
str(peer_info, field);</span><br><span>     if (optstr)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int proto =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int r =
=3D sscanf(optstr, &quot;IV_PROTO=3D%d&quot;, &amp;proto);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (r =3D=3D 1 &amp;&amp; prot=
o &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        op=
tstr +=3D strlen(field);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int va=
lue =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
nt r =3D sscanf(optstr, format, &amp;value);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (r =3D=3D 1 &amp;&amp; value &gt;=3D 0)=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            return proto;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return value;</span><br><span>         }</span><br>=
<span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return defa=
ult_value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+unsigned int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+peer_info_extract_uint(const char *peer_info, const c=
har *field)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return peer_info_extra=
ct_int(peer_info, field, &quot;%u&quot;, 0);</span><br><span> }</span><br><=
span> </span><br><span> uint32_t</span><br><span> extract_asymmetric_peer_i=
d(const char *peer_info)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    for (const char *p =3D peer_info; p &amp;&amp; (p=
 =3D strstr(p, &quot;ID=3D&quot;)); p +=3D 3)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint32_t peer_id =3D peer_info_extract_int(pe=
er_info, &quot;ID=3D&quot;, &quot;%x&quot;, MAX_PEER_ID);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (peer_id &lt; MAX_PEER_ID)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      /* only accept &quot;ID=3D&quot; at the start of a line, so it does n=
ot match</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * su=
bstrings like &quot;UV_ID=3D&quot; or &quot;GUID=3D&quot; */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (p =3D=3D peer_info || p[=
-1] =3D=3D &#39;\n&#39;)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   uint32_t peer_id =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            if (sscanf(p, &quot;ID=3D%x&quot;, &amp;peer_id) =3D=3D 1 =
&amp;&amp; peer_id &lt; MAX_PEER_ID)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                return peer_id;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return peer_id;</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     return MAX_PEER_ID;</span><=
br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_=
util=2Eh b/src/openvpn/ssl_util=2Eh</span><br><span>index 1a69e6f=2E=2E6f9f=
65b 100644</span><br><span>--- a/src/openvpn/ssl_util=2Eh</span><br><span>+=
++ b/src/openvpn/ssl_util=2Eh</span><br><span>@@ -33,11 +33,33 @@</span><br=
><span> #include &quot;buffer=2Eh&quot;</span><br><span> </span><br><span> =
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Extracts the =
named integer variable and returns its value or default_value</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * if it cannot be extracted=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param peer_info     peer info stri=
ng to search in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param field         name of the field to be extracted including the =3D</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param format       =
 sscanf/printf format string of the type to extract</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param default_value default value to =
return if the field cannot be extracted</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pee=
r_info_extract_int(const char *peer_info, const char *field, const char *fo=
rmat, unsigned int default_value);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Extracts the name=
d integer variable and returns its value or 0</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * if it cannot be extracted=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param peer_info     peer info string to search in<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param field     =
     name of the field to be extracted</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+peer=
_info_extract_uint(const char *peer_info, const char *field);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span>  * Extracts a variable from pee=
r info, the returned string will be allocated</span><br><span>  * using the=
 supplied gc_arena</span><br><span>  *</span><br><span>  * @param peer_info=
     The peer&#39;s peer_info</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @param var           The variable *including* =3D, e=2Eg=2E IV_C=
IPHERS=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
var           The variable including =3D, e=2Eg=2E IV_CIPHERS=3D</span><br>=
<span>  * @param gc            GC arena to allocate return value in</span><=
br><span>  *</span><br><span>  * @return  The content of the variable as NU=
LL terminated string or NULL if the</span><br><span>@@ -51,8 +73,11 @@</spa=
n><br><span>  *</span><br><span>  * @param peer_info     peer info string t=
o search for IV_PROTO</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-unsigned int extract_iv_proto(const char *peer_info);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline unsigned int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+extract_iv_proto(const char *peer_=
info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return peer_info_extract_uin=
t(peer_info, &quot;IV_PROTO=3D&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span> </span><br><span> /**</span><br><span=
>  * Extracts the ID variable and returns its value or</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/=
Makefile=2Eam</span><br><span>index 9174ed0=2E=2E38adfd7 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -400,7 +400,8 @@</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span> 	$=
(top_srcdir)/src/openvpn/options_util=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/otime=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	$(top_srcdir)/src/openvpn/list=2Ec</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/list=2Ec \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/ssl_util=2E=
c</span><br><span> </span><br><span> socket_testdriver_CFLAGS  =3D \</span>=
<br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcd=
ir)/src/openvpn \</span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=2Ec</=
span><br><span>index 219b476=2E=2E389fa09 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>@@ -188,12 +188,=
6 @@</span><br><span> {</span><br><span>     return true;</span><br><span> =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-unsigned int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-extract_iv_proto(const char *peer_info)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return IV_PROTO_PUSH_UPDATE;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span> #endif /* ifdef ENABLE=
_MANAGEMENT */</span><br><span> </span><br><span> /* tests */</span><br><sp=
an>@@ -650,6 +644,7 @@</span><br><span>     m-&gt;instances =3D calloc(1, s=
izeof(struct multi_instance *));</span><br><span>     struct multi_instance=
 *mi =3D calloc(1, sizeof(struct multi_instance));</span><br><span>     mi-=
&gt;context=2Ec2=2Etls_multi =3D calloc(1, sizeof(struct tls_multi));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;context=2Ec2=
=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4096&quot;;  // IV_PROTO_PU=
SH_UPDATE</span><br><span>     *(m-&gt;instances) =3D mi;</span><br><span> =
    m-&gt;top=2Eoptions=2Edisable_dco =3D true;</span><br><span>     *state=
 =3D m;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec =
b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index d473d67=2E=2E=
3e84fb8 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec<=
/span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span=
>@@ -48,7 +48,9 @@</span><br><span> #include &quot;buffer=2Eh&quot;</span><=
br><span> #include &quot;cert_data=2Eh&quot;</span><br><span> #include &quo=
t;packet_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;ssl_ver=
ify=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;openvpn=2Eh&quot;</span><br><span> </span><br><span> /* Mock funct=
ion to be allowed to include win32=2Ec which is required for</span><br><spa=
n>  * getting the temp directory */</span><br><span>@@ -884,6 +886,68 @@</s=
pan><br><span>     free_certificate(cert);</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ssl_test_extract_peer_info(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *peer_info_n=
ormal =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &q=
uot;IV_VER=3D2=2E6_git\nIV_PLAT=3Dmac\nIV_TCPNL=3D1\nIV_NCP=3D2\n&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;IV_CIPHER=
S=3DAES-256-GCM:AES-128-GCM:CHACHA20-POLY1305\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &quot;IV_PROTO=3D94\nIV_LZO_STUB=
=3D1\nIV_COMP_STUB=3D1\nP=3D78\nIV_COMP_STUBv2=3D1\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        &quot;IV_SSL=3DOpenSSL_3=2E0=
=2E5_5_Jul_2022\nIV_LZ4v2=3D1&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *empty =3D &quot;&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *invalid_proto =3D &quot;IV_PROTO=3Dseven\=
nIV_SSL=3D7\nP=3D300\nID=3Dxyz&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *test_prefix =3D &quot;UV_IV_PROTO=3D773\n=
NP=3D112\nPD=3D8\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(extract_iv_=
proto(peer_info_normal), 94);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(extract_iv_proto(empty), 0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(extract_iv_pro=
to(invalid_proto), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* This should not pick up the UV_IV_PROTO that has the extra prefix=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(extract_iv_proto(test_prefix), 0);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(peer_info_extract_uint(peer_info_normal, &quot;IV_COM=
P_STUB=3D&quot;), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(peer_info_extract_int(empty, &quot;IV_COMP_STUB=3D&q=
uot;, &quot;%d&quot;, 0xfe0d0d), 0xfe0d0d);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_extract_uint(invalid=
_proto, &quot;IV_COMP_STUB=3D&quot;), 0);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(peer_info_extract_int(test_prefix, &quot;NP=3D&quot=
;, &quot;%d&quot;, 23), 112);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(peer_info_extract_uint(test_prefix, &quot;PD=
=3D&quot;), 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(peer_info_extract_int(test_prefix, &quot;P=3D&quot;, &quot=
;%x&quot;, 0xfe0d0d), 0xfe0d0d);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(peer_info_extract_uint(peer_info_normal, =
&quot;P=3D&quot;), 78);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(peer_info_extract_uint(test_prefix, &quot;UV_IV_PR=
OTO=3D&quot;), 773);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *peer=
_ciphers =3D extract_var_peer_info(peer_info_normal, &quot;IV_CIPHERS=3D&qu=
ot;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_string_equal(peer_ciphers, &quot;AES-256-GCM:AES-128-GCM:CHACHA20-POL=
Y1305&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* with the extra =3D=
 this should not extract anything */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const char *proto =3D extract_var_peer_info(peer_info_=
normal, &quot;IV_PROTO=3D=3D&quot;, &amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_null(proto);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    proto =3D extract_var_peer_info(peer_info_normal, &quot;IV_P=
ROTO=3D&quot;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(proto, &quot;94&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char *double_eq_info =3D &quot;FOO=3D7\nFOO=3D=3Dnew&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *foo_eq =3D ex=
tract_var_peer_info(double_eq_info, &quot;FOO=3D&quot;, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *foo =3D extra=
ct_var_peer_info(double_eq_info, &quot;FOO&quot;, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const char *foo_2eq =3D extract=
_var_peer_info(double_eq_info, &quot;FOO=3D=3D&quot;, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_string_equal(foo, &quot;=3D7&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(foo_eq, &quot;7&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(foo_2eq, &quot;new&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(extract_asymmetric_peer_id(double_eq=
_info), MAX_PEER_ID);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(extract_asymmetric_peer_id(peer_info_normal), MAX_PE=
ER_ID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(extract_asymmetric_peer_id(invalid_proto), MAX_PEER_ID);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(extract_=
asymmetric_peer_id(&quot;ID=3Df7&quot;), 0xf7);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(extract_asymmetric_peer_id=
(&quot;X=3Dfoo\nID=3D12ab&quot;), 0x12ab);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(extract_asymmetric_peer_id(&quo=
t;X=3Dfoo\nID=3D34dd\nY=3Dbar&quot;), 0x34dd);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(extract_asymmetric_peer_id(=
&quot;X=3Dfoo\nID=3D12345678&quot;), MAX_PEER_ID);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span> </span><br><span> int</span><br><span> mai=
n(void)</span><br><span>@@ -908,7 +972,8 @@</span><br><span>         cmocka=
_unit_test(test_data_channel_roundtrip_bf_cbc),</span><br><span>         cm=
ocka_unit_test(test_data_channel_known_vectors_epoch),</span><br><span>    =
     cmocka_unit_test(test_data_channel_known_vectors_shortpktid),</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(crypt=
o_test_print_cert_details)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmocka_unit_test(crypto_test_print_cert_details),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(ssl_t=
est_extract_peer_info)</span><br><span> </span><br><span>     };</span><br>=
<span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3Demail">change 1800</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iad94e7a9d0b3be=
8a8db09e9a20eaac6041470ab6 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1800 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div=
>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &=
lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--aB7brfMVscE=--


--===============2835101542015204216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2835101542015204216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2835101542015204216==--

