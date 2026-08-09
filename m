Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC08C5AD4E
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 08:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vSA1Sdx+u77hbwyyBPwDHjkhPujSbiqE4iHuTjwIzmo=; b=gFD97o38InfTAxHIRsSDfQQOOQ
	AyeMQoMocB3E8Cs6HQ3YEqJUHv1lkgvjGIBp6IKO8SKtxWo3m2m0j/Ta+jOUlew16qGHAHAUt2Xdm
	+cCd/LfDV3ESvSO2yhkswY2/OhnEtJs+Ha/WB/ol5ONDvvW4EBXmdZPPmhociTQg6QGs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsywV-0000iE-1Z;
	Sun, 09 Aug 2026 08:31:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsywU-0000i8-1k
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 08:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zl96A6WY9RoBW6aiVvV2cBEvlqkGlnzbMRgQZuZveOo=; b=kyzbRR9h0OUMATA2P+1FjNesja
 Zj9jFfehuxjVPy+n4ievdfoi7AjRhiZcAPdsXuuWnKBH354CsYWn+lP80QpVJKEECaOOnlRZXd/xO
 K3Ny5A3ciOj41zgd6k6GUjmeiOmrbI1/WIuR25zQandZG1vbnLhsGcd+1EGQ/fdqJGDo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zl96A6WY9RoBW6aiVvV2cBEvlqkGlnzbMRgQZuZveOo=; b=Y
 b4yYVI62iaSODO+iadAm3rzSeok/YT0h9njO+tgYja9vTleEtr75myYLCkiMKQyVsSL1fVGpGCd7r
 r7zTIvjUY9terkmj1VlLZ2OjR4WQ/JvFwaczQuZpph93Cq+tDesvJ9y/WHH/mzJSglbepWWCH0uqB
 uvBfoU/Q/34dS80Q=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsywR-0000tJ-MD for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 08:31:37 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so412163f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 09 Aug 2026 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786264289; x=1786869089; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zl96A6WY9RoBW6aiVvV2cBEvlqkGlnzbMRgQZuZveOo=;
 b=eSJjiKvV6QwP6C4KlUHeKVE2PDK12s0k4BwImF7qdVXFmsHe8QKW67KtKQ+aITSq39
 d4rgIQ6d7g+ODiE7O4q6W/GzDSVlCm3bIYfvAhrytzA+RiFAcdAYdGd+cVkb88NDPabi
 Adcaerr4JmsVoTK0NXB+3jedo6iLDJE/8n9iJJDSmVZLSgmPFMFYkB6c8hmoGexdXDE/
 yboOHbdWkq4rhfEjissIdYzR6vV4QJJSTMmTxntOk2J4fZ8jJxhuFGF4Mj1RSpzSeXWj
 VjeVuLgzh7r6RJx9AdBJx/AUqCWknGD5pfZZWlxc51aOv39mvpVGur1ef7CuoOuTtcGw
 aSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786264289; x=1786869089;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zl96A6WY9RoBW6aiVvV2cBEvlqkGlnzbMRgQZuZveOo=;
 b=ggLdEw5UpiZUCayoE3lnc+l1EUPa3YyEeIZeVxuFg8/pGpe3sHAXIXSZqDPXtnIK/s
 wHDecHBbhWE9FVhcF+BQKOJRt3MBgVcQilBq7JQiuiXNlfZyTpjAledZ/pd2QFDuyA1o
 fV+000xe5wixUsZBvlJYg9tnoQi8R7yYrd48t0AZnLEigdNtO9cEpxR9zqLFJz3L6+eX
 75IkHWT8RdlcAD5xyjANeGP3uG5vw0psnJCbGWipw1jrHNdP+rdXSV5VtI00UXCe1+yJ
 AKkoCgnJt1btVqmYhdolTiPv8WRHPg67kMLMUI0KiFfdnZJEzJH0sPqgEt7lWN3LaIvR
 lbEQ==
X-Gm-Message-State: AOJu0YxOX12Ycr+UbvHQBYcucRaDWb8jBmLYYcXz/X1l6pSRcO/X0J7M
 eAFca1OpSeasjikkbaA2Q8hmoYXMiLl8LbpeCY7xUWJLX3XQ+JwEDXRjLWncCucRmjBYHiaS0P1
 R5SCBeGu3LwlRCEP4oxvCloQ5QuefkjnV3kjFNYC8zz+H5WGBq4JngWgJqCQ07Ndc625y72bGi9
 ju8L+AxA==
X-Gm-Gg: AR+sD11vvoMM6xEpDKIqMG/OI26Cc392huVL5QEtqn6TSL4pxC+1mv+MDkkH8/vHnui
 KLsMczfGPokKMB/mPqrhT1CSPjhHFc1xEk4Y4nbl35CyOwGcpbLU+jXxNQHWsv7ywfbhJJE8LgM
 R4dA1tronEW/+v/8f+/pzFlShOywsfU+66O6OiVbQfXKwvvqzrXBf2f427fsl7uolRMwbF2wnay
 a6oOFkEXFzEPB4F0Kx5C1DZWtOvHauERjj1Ps51boRXhEPU7+FAl4Tixvj3Ja4ferBhsZR8xLP+
 w/DWi2+fReZWDLGSKt7x9Klcvk9m8QTTBfMvB/WyLaadlbNxRYGfQJPZf5YXhKP9jnLgQ8Iq3g3
 Xm8pgebq/cwAzbgt5TMaQ4MXLityMip5RAqmJ2LIY7zNx+HQ1b5krxfTcqNdBy6gC+qViWcl+FB
 uzkrEH0zV6zij5JGQVU5r4JqHtwQNej517VWFscNSu/BZk3BpVZeFSl6jIMuCtKb03RP8wGeOSi
 Uv6uFNgpOIBF7O4gv106t3k/cDANLbXrx6kfZN91zyxvHO3g+cefphYLBSNvrK5LNaATy7TkD15
 8gmdbTO8JHrxTJUTXLyxONQuOISdhz4L3xkNaRxosmOBTX15xPY=
X-Received: by 2002:a5d:5d86:0:b0:47f:8fc8:a8b1 with SMTP id
 ffacd0b85a97d-480026c89d2mr17067423f8f.14.1786264288335; 
 Sun, 09 Aug 2026 01:31:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021506desm20795736f8f.10.2026.08.09.01.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:31:27 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 9 Aug 2026 08:31:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
X-Gerrit-Change-Number: 1800
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1800?usp=email>
X-Gerrit-Commit: 06ced3fd84e4e28f2774c4156f8032a2bed736a2
In-Reply-To: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
References: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzIyNzQ0MDAwLklhZDk0ZTdhOWQwYjNiZThhOGRiMDllOWEyMGVhYWM2MDQxNDcwYWI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <62b58ed92bf0ebfcc8ddf283222a6b87e5a52b54-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsywR-0000tJ-MD
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
Content-Type: multipart/mixed; boundary="===============0262255452210587843=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0262255452210587843==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ICZfLERMd9Y="; charset=UTF-8

--ICZfLERMd9Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
cron2


Change subject: Allow extracing other integers from peer info and a=
dd a unit test for it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Allow extracing other integers from peer info and add a unit tes=
t for it

This also ensure that we only really extract the variable we are =
looking
for=2E The old code would also consider UV_IV_NCP to be IV_NCP=2E

=
Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
Signed-off-by: Arne Sc=
hwabe <arne@rfc2549=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>=

Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800
Message-Id: <2=
0260808154933=2E17540-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38241=2Ehtml
Signed-=
off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M src=
/openvpn/push=2Ec
M src/openvpn/ssl_ncp=2Ec
M src/openvpn/ssl_util=2Ec
M sr=
c/openvpn/ssl_util=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/uni=
t_tests/openvpn/test_push_update_msg=2Ec
M tests/unit_tests/openvpn/test_ss=
l=2Ec
8 files changed, 159 insertions(+), 50 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/00/1800/8

diff --git a=
/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 3ff2734=2E=2Eaabbcb6 100644
--- =
a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -916,7 +916,8 @@
         src/=
openvpn/options_util=2Ec
         src/openvpn/otime=2Ec
         src/openvp=
n/list=2Ec
-        )
+        src/openvpn/ssl_util=2Ec
+    )
 
     targe=
t_sources(test_argv PRIVATE
         tests/unit_tests/openvpn/mock_get_rand=
om=2Ec
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 633c0=
07d=2E=2Ece2baf2 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=
=2Ec
@@ -718,9 +718,9 @@
 
     /* Push our mtu to the peer if it supports =
pushable MTUs */
     int client_max_mtu =3D 0;
-    const char *iv_mtu =3D=
 extract_var_peer_info(tls_multi->peer_info, "IV_MTU=3D", gc);
+    unsigne=
d int iv_mtu =3D peer_info_extract_uint(tls_multi->peer_info, "IV_MTU=3D");=

 
-    if (iv_mtu && sscanf(iv_mtu, "%d", &client_max_mtu) =3D=3D 1)
+    =
if (iv_mtu !=3D 0)
     {
         push_option_fmt(gc, push_list, M_USAGE, =
"tun-mtu %d", o->ce=2Etun_mtu);
         if (client_max_mtu < o->ce=2Etun_m=
tu)
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index b4=
50de8=2E=2E8b0f28d 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/s=
sl_ncp=2Ec
@@ -55,20 +55,10 @@
  * Return the Negotiable Crypto Parameters =
version advertised in the peer info
  * string, or 0 if none specified=2E
 =
 */
-static int
+static unsigned int
 tls_peer_info_ncp_ver(const char *pee=
r_info)
 {
-    const char *ncpstr =3D peer_info ? strstr(peer_info, "IV_NC=
P=3D") : NULL;
-    if (ncpstr)
-    {
-        int ncp =3D 0;
-        int=
 r =3D sscanf(ncpstr, "IV_NCP=3D%d", &ncp);
-        if (r =3D=3D 1)
-     =
   {
-            return ncp;
-        }
-    }
-    return 0;
+    return =
peer_info_extract_uint(peer_info, "IV_NCP=3D");
 }
 
 /**
diff --git a/src/=
openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index 2f01f8a=2E=2Eba185c1 =
100644
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_util=2Ec
@@ -27=
,26 +27,56 @@
 #include "openvpn=2Eh"
 #include "ssl_util=2Eh"
 
-char *
-e=
xtract_var_peer_info(const char *peer_info, const char *var, struct gc_aren=
a *gc)
+/**
+ * Looks for the string field at the start of peer_info or
+ *=
 after any new line and returns a pointer to the start of the field
+ * or =
NULL if not found=2E
+ */
+static const char *
+peer_info_extract_varstr(co=
nst char *peer_info, const char *field)
 {
     if (!peer_info)
     {
    =
     return NULL;
     }
 
-    const char *var_start =3D strstr(peer_info,=
 var);
+    while (peer_info)
+    {
+        /* peer info starts with this=
 field */
+        if (strncmp(peer_info, field, strlen(field)) =3D=3D 0)
+=
        {
+            return peer_info;
+        }
+
+        /* skip to t=
he next line */
+        peer_info =3D strchr(peer_info, '\n');
+        if=
 (peer_info)
+        {
+            /* skip the '\n' itself */
+          =
  peer_info++;
+        }
+    }
+    return NULL;
+}
+
+char *
+extract_va=
r_peer_info(const char *peer_info, const char *var, struct gc_arena *gc)
+{=

+    const char *var_start =3D peer_info_extract_varstr(peer_info, var);
 =
    if (!var_start)
     {
-        /* variable not found in peer info */
+=
        /* variable hasn't been found in peer info */
         return NULL;=

     }
 
+    /* skip over the variable name (includes the =3D as per API)=
*/
     var_start +=3D strlen(var);
-    const char *var_end =3D strstr(var=
_start, "\n");
+
+    /* returns the location of the next '\n' or the end o=
f the
+     * string if the variable is already on the last line */
+    co=
nst char *var_end =3D strchr(var_start, '\n');
     if (!var_end)
     {
- =
       /* var is at end of the peer_info list and no '\n' follows */
      =
   var_end =3D var_start + strlen(var_start);
     }
 
@@ -56,38 +86,40 @@
=
     return var_value;
 }
 
+
 unsigned int
-extract_iv_proto(const char *p=
eer_info)
+peer_info_extract_int(const char *peer_info, const char *field, =
const char *format, unsigned int default_value)
 {
-    const char *optstr =
=3D peer_info ? strstr(peer_info, "IV_PROTO=3D") : NULL;
+    const char *o=
ptstr =3D peer_info_extract_varstr(peer_info, field);
     if (optstr)
    =
 {
-        int proto =3D 0;
-        int r =3D sscanf(optstr, "IV_PROTO=3D=
%d", &proto);
-        if (r =3D=3D 1 && proto > 0)
+        optstr +=3D st=
rlen(field);
+
+        int value =3D 0;
+        int r =3D sscanf(optstr, =
format, &value);
+        if (r =3D=3D 1 && value >=3D 0)
         {
-     =
       return proto;
+            return value;
         }
     }
-    retu=
rn 0;
+    return default_value;
+}
+
+unsigned int
+peer_info_extract_uint=
(const char *peer_info, const char *field)
+{
+    return peer_info_extract=
_int(peer_info, field, "%u", 0);
 }
 
 uint32_t
 extract_asymmetric_peer_id=
(const char *peer_info)
 {
-    for (const char *p =3D peer_info; p && (p =
=3D strstr(p, "ID=3D")); p +=3D 3)
+    uint32_t peer_id =3D peer_info_extr=
act_int(peer_info, "ID=3D", "%x", MAX_PEER_ID);
+    if (peer_id < MAX_PEER=
_ID)
     {
-        /* only accept "ID=3D" at the start of a line, so it d=
oes not match
-         * substrings like "UV_ID=3D" or "GUID=3D" */
-     =
   if (p =3D=3D peer_info || p[-1] =3D=3D '\n')
-        {
-            uin=
t32_t peer_id =3D 0;
-            if (sscanf(p, "ID=3D%x", &peer_id) =3D=3D=
 1 && peer_id < MAX_PEER_ID)
-            {
-                return peer_id=
;
-            }
-        }
+        return peer_id;
     }
+
     return M=
AX_PEER_ID;
 }
 
diff --git a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_ut=
il=2Eh
index 1a69e6f=2E=2E6f9f65b 100644
--- a/src/openvpn/ssl_util=2Eh
+++=
 b/src/openvpn/ssl_util=2Eh
@@ -33,11 +33,33 @@
 #include "buffer=2Eh"
 
 /=
**
+ * Extracts the named integer variable and returns its value or default=
_value
+ * if it cannot be extracted=2E
+ *
+ * @param peer_info     peer i=
nfo string to search in
+ * @param field         name of the field to be ex=
tracted including the =3D
+ * @param format        sscanf/printf format str=
ing of the type to extract
+ * @param default_value default value to return=
 if the field cannot be extracted
+ */
+unsigned int
+peer_info_extract_int=
(const char *peer_info, const char *field, const char *format, unsigned int=
 default_value);
+
+/**
+ * Extracts the named integer variable and returns=
 its value or 0
+ * if it cannot be extracted=2E
+ *
+ * @param peer_info  =
   peer info string to search in
+ * @param field          name of the fiel=
d to be extracted
+ */
+unsigned int
+peer_info_extract_uint(const char *pe=
er_info, const char *field);
+
+/**
  * Extracts a variable from peer info,=
 the returned string will be allocated
  * using the supplied gc_arena
  *
=
  * @param peer_info     The peer's peer_info
- * @param var           The =
variable *including* =3D, e=2Eg=2E IV_CIPHERS=3D
+ * @param var           T=
he variable including =3D, e=2Eg=2E IV_CIPHERS=3D
  * @param gc            =
GC arena to allocate return value in
  *
  * @return  The content of the va=
riable as NULL terminated string or NULL if the
@@ -51,8 +73,11 @@
  *
  * =
@param peer_info     peer info string to search for IV_PROTO
  */
-unsigned=
 int extract_iv_proto(const char *peer_info);
-
+static inline unsigned int=

+extract_iv_proto(const char *peer_info)
+{
+    return peer_info_extract_=
uint(peer_info, "IV_PROTO=3D");
+}
 
 /**
  * Extracts the ID variable and =
returns its value or
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/=
tests/unit_tests/openvpn/Makefile=2Eam
index 9174ed0=2E=2E38adfd7 100644
--=
- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/M=
akefile=2Eam
@@ -400,7 +400,8 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \=

 	$(top_srcdir)/src/openvpn/options_util=2Ec \
 	$(top_srcdir)/src/openvpn=
/otime=2Ec \
-	$(top_srcdir)/src/openvpn/list=2Ec
+	$(top_srcdir)/src/openv=
pn/list=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_util=2Ec
 
 socket_testdriver=
_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top=
_srcdir)/src/openvpn \
diff --git a/tests/unit_tests/openvpn/test_push_upda=
te_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
index 219b47=
6=2E=2E389fa09 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg=
=2Ec
+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
@@ -188,12 +18=
8,6 @@
 {
     return true;
 }
-
-unsigned int
-extract_iv_proto(const char=
 *peer_info)
-{
-    return IV_PROTO_PUSH_UPDATE;
-}
 #endif /* ifdef ENABL=
E_MANAGEMENT */
 
 /* tests */
@@ -650,6 +644,7 @@
     m->instances =3D ca=
lloc(1, sizeof(struct multi_instance *));
     struct multi_instance *mi =
=3D calloc(1, sizeof(struct multi_instance));
     mi->context=2Ec2=2Etls_m=
ulti =3D calloc(1, sizeof(struct tls_multi));
+    mi->context=2Ec2=2Etls_m=
ulti->peer_info =3D "IV_PROTO=3D4096";  // IV_PROTO_PUSH_UPDATE
     *(m->i=
nstances) =3D mi;
     m->top=2Eoptions=2Edisable_dco =3D true;
     *state=
 =3D m;
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tes=
ts/openvpn/test_ssl=2Ec
index d473d67=2E=2E3e84fb8 100644
--- a/tests/unit_=
tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -=
48,7 +48,9 @@
 #include "buffer=2Eh"
 #include "cert_data=2Eh"
 #include "p=
acket_id=2Eh"
+#include "ssl_util=2Eh"
 #include "ssl_verify=2Eh"
+#include=
 "openvpn=2Eh"
 
 /* Mock function to be allowed to include win32=2Ec which=
 is required for
  * getting the temp directory */
@@ -884,6 +886,68 @@
   =
  free_certificate(cert);
 }
 
+void
+ssl_test_extract_peer_info(void **sta=
te)
+{
+    const char *peer_info_normal =3D
+        "IV_VER=3D2=2E6_git\n=
IV_PLAT=3Dmac\nIV_TCPNL=3D1\nIV_NCP=3D2\n"
+        "IV_CIPHERS=3DAES-256-G=
CM:AES-128-GCM:CHACHA20-POLY1305\n"
+        "IV_PROTO=3D94\nIV_LZO_STUB=3D=
1\nIV_COMP_STUB=3D1\nP=3D78\nIV_COMP_STUBv2=3D1\n"
+        "IV_SSL=3DOpenS=
SL_3=2E0=2E5_5_Jul_2022\nIV_LZ4v2=3D1";
+
+    const char *empty =3D "";
+ =
   const char *invalid_proto =3D "IV_PROTO=3Dseven\nIV_SSL=3D7\nP=3D300\nID=
=3Dxyz";
+    const char *test_prefix =3D "UV_IV_PROTO=3D773\nNP=3D112\nPD=
=3D8\n";
+
+
+    assert_int_equal(extract_iv_proto(peer_info_normal), 94);=

+    assert_int_equal(extract_iv_proto(empty), 0);
+    assert_int_equal(e=
xtract_iv_proto(invalid_proto), 0);
+    /* This should not pick up the UV_=
IV_PROTO that has the extra prefix */
+    assert_int_equal(extract_iv_prot=
o(test_prefix), 0);
+
+    assert_int_equal(peer_info_extract_uint(peer_inf=
o_normal, "IV_COMP_STUB=3D"), 1);
+    assert_int_equal(peer_info_extract_i=
nt(empty, "IV_COMP_STUB=3D", "%d", 0xfe0d0d), 0xfe0d0d);
+    assert_int_eq=
ual(peer_info_extract_uint(invalid_proto, "IV_COMP_STUB=3D"), 0);
+
+    as=
sert_int_equal(peer_info_extract_int(test_prefix, "NP=3D", "%d", 23), 112);=

+    assert_int_equal(peer_info_extract_uint(test_prefix, "PD=3D"), 8);
+ =
   assert_int_equal(peer_info_extract_int(test_prefix, "P=3D", "%x", 0xfe0d=
0d), 0xfe0d0d);
+    assert_int_equal(peer_info_extract_uint(peer_info_norm=
al, "P=3D"), 78);
+    assert_int_equal(peer_info_extract_uint(test_prefix,=
 "UV_IV_PROTO=3D"), 773);
+
+    struct gc_arena gc =3D gc_new();
+
+    co=
nst char *peer_ciphers =3D extract_var_peer_info(peer_info_normal, "IV_CIPH=
ERS=3D", &gc);
+    assert_string_equal(peer_ciphers, "AES-256-GCM:AES-128-=
GCM:CHACHA20-POLY1305");
+
+    /* with the extra =3D this should not extra=
ct anything */
+    const char *proto =3D extract_var_peer_info(peer_info_n=
ormal, "IV_PROTO=3D=3D", &gc);
+    assert_null(proto);
+
+    proto =3D ex=
tract_var_peer_info(peer_info_normal, "IV_PROTO=3D", &gc);
+    assert_stri=
ng_equal(proto, "94");
+
+
+    const char *double_eq_info =3D "FOO=3D7\nFO=
O=3D=3Dnew";
+    const char *foo_eq =3D extract_var_peer_info(double_eq_in=
fo, "FOO=3D", &gc);
+    const char *foo =3D extract_var_peer_info(double_e=
q_info, "FOO", &gc);
+    const char *foo_2eq =3D extract_var_peer_info(dou=
ble_eq_info, "FOO=3D=3D", &gc);
+
+    assert_string_equal(foo, "=3D7");
+ =
   assert_string_equal(foo_eq, "7");
+    assert_string_equal(foo_2eq, "new=
");
+
+    assert_int_equal(extract_asymmetric_peer_id(double_eq_info), MAX=
_PEER_ID);
+    assert_int_equal(extract_asymmetric_peer_id(peer_info_norma=
l), MAX_PEER_ID);
+    assert_int_equal(extract_asymmetric_peer_id(invalid_=
proto), MAX_PEER_ID);
+    assert_int_equal(extract_asymmetric_peer_id("ID=
=3Df7"), 0xf7);
+    assert_int_equal(extract_asymmetric_peer_id("X=3Dfoo\n=
ID=3D12ab"), 0x12ab);
+    assert_int_equal(extract_asymmetric_peer_id("X=
=3Dfoo\nID=3D34dd\nY=3Dbar"), 0x34dd);
+    assert_int_equal(extract_asymme=
tric_peer_id("X=3Dfoo\nID=3D12345678"), MAX_PEER_ID);
+
+    gc_free(&gc);
=
+}
 
 int
 main(void)
@@ -908,7 +972,8 @@
         cmocka_unit_test(test_da=
ta_channel_roundtrip_bf_cbc),
         cmocka_unit_test(test_data_channel_k=
nown_vectors_epoch),
         cmocka_unit_test(test_data_channel_known_vect=
ors_shortpktid),
-        cmocka_unit_test(crypto_test_print_cert_details)
=
+        cmocka_unit_test(crypto_test_print_cert_details),
+        cmocka_=
unit_test(ssl_test_extract_peer_info)
 
     };
 

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
=
Gerrit-Change-Number: 1800
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ICZfLERMd9Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #8</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">Allow extracing other integ=
ers from peer info and add a unit test for it<br><br>This also ensure that =
we only really extract the variable we are looking<br>for=2E The old code w=
ould also consider UV_IV_NCP to be IV_NCP=2E<br><br>Change-Id: Iad94e7a9d0b=
3be8a8db09e9a20eaac6041470ab6<br>Signed-off-by: Arne Schwabe &lt;arne@rfc25=
49=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800<br>Message-Id: &=
lt;20260808154933=2E17540-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38241=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M CMakeLists=2Etxt<br>M src/openvpn/push=2Ec<br>M src/openvpn/ssl_ncp=2Ec<=
br>M src/openvpn/ssl_util=2Ec<br>M src/openvpn/ssl_util=2Eh<br>M tests/unit=
_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_push_update=
_msg=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>8 files changed, 159=
 insertions(+), 50 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/00/1800/8</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 3ff2734=2E=
=2Eaabbcb6 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>++=
+ b/CMakeLists=2Etxt</span><br><span>@@ -916,7 +916,8 @@</span><br><span>  =
       src/openvpn/options_util=2Ec</span><br><span>         src/openvpn/ot=
ime=2Ec</span><br><span>         src/openvpn/list=2Ec</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        )</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        src/openvpn/ssl_util=2Ec</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span> </span><br><span>=
     target_sources(test_argv PRIVATE</span><br><span>         tests/unit_t=
ests/openvpn/mock_get_random=2Ec</span><br><span>diff --git a/src/openvpn/p=
ush=2Ec b/src/openvpn/push=2Ec</span><br><span>index 633c007d=2E=2Ece2baf2 =
100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src=
/openvpn/push=2Ec</span><br><span>@@ -718,9 +718,9 @@</span><br><span> </sp=
an><br><span>     /* Push our mtu to the peer if it supports pushable MTUs =
*/</span><br><span>     int client_max_mtu =3D 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    const char *iv_mtu =3D extract_var_peer_inf=
o(tls_multi-&gt;peer_info, &quot;IV_MTU=3D&quot;, gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    unsigned int iv_mtu =3D peer_info_ex=
tract_uint(tls_multi-&gt;peer_info, &quot;IV_MTU=3D&quot;);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (iv_mtu &amp=
;&amp; sscanf(iv_mtu, &quot;%d&quot;, &amp;client_max_mtu) =3D=3D 1)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (iv_mtu !=3D 0)</sp=
an><br><span>     {</span><br><span>         push_option_fmt(gc, push_list,=
 M_USAGE, &quot;tun-mtu %d&quot;, o-&gt;ce=2Etun_mtu);</span><br><span>    =
     if (client_max_mtu &lt; o-&gt;ce=2Etun_mtu)</span><br><span>diff --git=
 a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index =
b450de8=2E=2E8b0f28d 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</=
span><br><span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -55,20 +55,=
10 @@</span><br><span>  * Return the Negotiable Crypto Parameters version a=
dvertised in the peer info</span><br><span>  * string, or 0 if none specifi=
ed=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic unsigned int</span><br><span> tls_peer_info_ncp_ver(const char *peer_inf=
o)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    const char *ncpstr =3D peer_info ? strstr(peer_info, &quot;IV_NCP=3D&qu=
ot;) : NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (n=
cpstr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        int ncp =3D 0;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        int r =3D sscanf(ncpst=
r, &quot;IV_NCP=3D%d&quot;, &amp;ncp);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (r =3D=3D 1)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            return ncp;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return peer_info_extr=
act_uint(peer_info, &quot;IV_NCP=3D&quot;);</span><br><span> }</span><br><s=
pan> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/ssl_uti=
l=2Ec b/src/openvpn/ssl_util=2Ec</span><br><span>index 2f01f8a=2E=2Eba185c1=
 100644</span><br><span>--- a/src/openvpn/ssl_util=2Ec</span><br><span>+++ =
b/src/openvpn/ssl_util=2Ec</span><br><span>@@ -27,26 +27,56 @@</span><br><s=
pan> #include &quot;openvpn=2Eh&quot;</span><br><span> #include &quot;ssl_u=
til=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-extra=
ct_var_peer_info(const char *peer_info, const char *var, struct gc_arena *g=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Looks for the string field at =
the start of peer_info or</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * after any new line and returns a pointer to the start of the field=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * or NULL if not f=
ound=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static const char *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+peer_info_extract_varstr(con=
st char *peer_info, const char *field)</span><br><span> {</span><br><span> =
    if (!peer_info)</span><br><span>     {</span><br><span>         return =
NULL;</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    const char *var_start =3D strstr(peer_info, va=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (peer_=
info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* peer info starts =
with this field */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (strncmp(peer_info, field, strlen(field)) =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return peer_info;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* skip to the next line */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        peer_info =3D strchr(peer_info, &#39=
;\n&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (peer_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* s=
kip the &#39;\n&#39; itself */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            peer_info++;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+extract_var_peer_info(const char *peer_info, const char *var,=
 struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
var_start =3D peer_info_extract_varstr(peer_info, var);</span><br><span>   =
  if (!var_start)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        /* variable not found in peer info */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* variable hasn&#39;t=
 been found in peer info */</span><br><span>         return NULL;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* skip over the variable name (includes the =3D as per API=
)*/</span><br><span>     var_start +=3D strlen(var);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *var_end =3D strstr(var_star=
t, &quot;\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* returns the =
location of the next &#39;\n&#39; or the end of the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * string if the variable is already =
on the last line */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *var_end =3D strchr(var_start, &#39;\n&#39;);</span><br><spa=
n>     if (!var_end)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        /* var is at end of the peer_info list and no=
 &#39;\n&#39; follows */</span><br><span>         var_end =3D var_start + s=
trlen(var_start);</span><br><span>     }</span><br><span> </span><br><span>=
@@ -56,38 +86,40 @@</span><br><span>     return var_value;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> unsigned int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-extract_iv_proto(const char *peer_info)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+peer_info_extract_int(const char *peer_info, =
const char *field, const char *format, unsigned int default_value)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const c=
har *optstr =3D peer_info ? strstr(peer_info, &quot;IV_PROTO=3D&quot;) : NU=
LL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
optstr =3D peer_info_extract_varstr(peer_info, field);</span><br><span>    =
 if (optstr)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        int proto =3D 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        int r =3D sscanf(optstr, &quot;IV_PROTO=3D%d&quot;=
, &amp;proto);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (r =3D=3D 1 &amp;&amp; proto &gt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        optstr +=3D strlen(field);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        int value =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        int r =3D sscanf(optstr, format, &amp;value);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (r =3D=
=3D 1 &amp;&amp; value &gt;=3D 0)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            return proto;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return value;</spa=
n><br><span>         }</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return default_value;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+peer_info_extract_ui=
nt(const char *peer_info, const char *field)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return peer_info_extract_int(peer_info, field, &quot;%u&quot;, 0=
);</span><br><span> }</span><br><span> </span><br><span> uint32_t</span><br=
><span> extract_asymmetric_peer_id(const char *peer_info)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (const char =
*p =3D peer_info; p &amp;&amp; (p =3D strstr(p, &quot;ID=3D&quot;)); p +=3D=
 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t pee=
r_id =3D peer_info_extract_int(peer_info, &quot;ID=3D&quot;, &quot;%x&quot;=
, MAX_PEER_ID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (peer_id &lt; MAX_PEER_ID)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* only accept &quot;ID=3D&quot; at=
 the start of a line, so it does not match</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-         * substrings like &quot;UV_ID=3D&quot; or &qu=
ot;GUID=3D&quot; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (p =3D=3D peer_info || p[-1] =3D=3D &#39;\n&#39;)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            uint32_t peer_id =3D 0;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (sscanf(p, &quot;ID=
=3D%x&quot;, &amp;peer_id) =3D=3D 1 &amp;&amp; peer_id &lt; MAX_PEER_ID)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                return peer_id;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return peer_id;</span><br><span>=
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     return MAX_PEER_ID;</span><br><span> }</span><br><span> </span><br=
><span>diff --git a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh</sp=
an><br><span>index 1a69e6f=2E=2E6f9f65b 100644</span><br><span>--- a/src/op=
envpn/ssl_util=2Eh</span><br><span>+++ b/src/openvpn/ssl_util=2Eh</span><br=
><span>@@ -33,11 +33,33 @@</span><br><span> #include &quot;buffer=2Eh&quot;=
</span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Extracts the named integer variable and returns its =
value or default_value</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * if it cannot be extracted=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param peer_info     peer info string to search in</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param field         name of the field=
 to be extracted including the =3D</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param format        sscanf/printf format string of the t=
ype to extract</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram default_value default value to return if the field cannot be extracted=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+peer_info_extract_int(const char *peer_in=
fo, const char *field, const char *format, unsigned int default_value);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Extracts the named integer variable and returns its va=
lue or 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * if it ca=
nnot be extracted=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param peer_i=
nfo     peer info string to search in</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param field          name of the field to be extracte=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+peer_info_extract_uint(const char *peer_i=
nfo, const char *field);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span>  * Extracts a variable from peer info, the returned string will be a=
llocated</span><br><span>  * using the supplied gc_arena</span><br><span>  =
*</span><br><span>  * @param peer_info     The peer&#39;s peer_info</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @param var           The v=
ariable *including* =3D, e=2Eg=2E IV_CIPHERS=3D</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param var           The variable including =
=3D, e=2Eg=2E IV_CIPHERS=3D</span><br><span>  * @param gc            GC are=
na to allocate return value in</span><br><span>  *</span><br><span>  * @ret=
urn  The content of the variable as NULL terminated string or NULL if the</=
span><br><span>@@ -51,8 +73,11 @@</span><br><span>  *</span><br><span>  * @=
param peer_info     peer info string to search for IV_PROTO</span><br><span=
>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int ext=
ract_iv_proto(const char *peer_info);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic inline unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+extract_iv_proto(const char *peer_info)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return peer_info_extract_uint(peer_info, &quot;IV_PROTO=3D&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>=
 </span><br><span> /**</span><br><span>  * Extracts the ID variable and ret=
urns its value or</span><br><span>diff --git a/tests/unit_tests/openvpn/Mak=
efile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 9=
174ed0=2E=2E38adfd7 100644</span><br><span>--- a/tests/unit_tests/openvpn/M=
akefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</=
span><br><span>@@ -400,7 +400,8 @@</span><br><span> 	$(top_srcdir)/src/open=
vpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/options_util=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/list=2E=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src=
/openvpn/list=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	$(top_srcdir)/src/openvpn/ssl_util=2Ec</span><br><span> </span><br><span> =
socket_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include -=
I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/test_push_update_msg=2Ec b/tests/unit_te=
sts/openvpn/test_push_update_msg=2Ec</span><br><span>index 219b476=2E=2E389=
fa09 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_push_update=
_msg=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_push_update_ms=
g=2Ec</span><br><span>@@ -188,12 +188,6 @@</span><br><span> {</span><br><sp=
an>     return true;</span><br><span> }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uns=
igned int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-extract_iv_p=
roto(const char *peer_info)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return IV_=
PROTO_PUSH_UPDATE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </spa=
n><br><span> /* tests */</span><br><span>@@ -650,6 +644,7 @@</span><br><spa=
n>     m-&gt;instances =3D calloc(1, sizeof(struct multi_instance *));</spa=
n><br><span>     struct multi_instance *mi =3D calloc(1, sizeof(struct mult=
i_instance));</span><br><span>     mi-&gt;context=2Ec2=2Etls_multi =3D call=
oc(1, sizeof(struct tls_multi));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_info =3D &quot;IV=
_PROTO=3D4096&quot;;  // IV_PROTO_PUSH_UPDATE</span><br><span>     *(m-&gt;=
instances) =3D mi;</span><br><span>     m-&gt;top=2Eoptions=2Edisable_dco =
=3D true;</span><br><span>     *state =3D m;</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2E=
c</span><br><span>index d473d67=2E=2E3e84fb8 100644</span><br><span>--- a/t=
ests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_ssl=2Ec</span><br><span>@@ -48,7 +48,9 @@</span><br><span> #i=
nclude &quot;buffer=2Eh&quot;</span><br><span> #include &quot;cert_data=2Eh=
&quot;</span><br><span> #include &quot;packet_id=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util=2Eh&quot;</s=
pan><br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><=
span> </span><br><span> /* Mock function to be allowed to include win32=2Ec=
 which is required for</span><br><span>  * getting the temp directory */</s=
pan><br><span>@@ -884,6 +886,68 @@</span><br><span>     free_certificate(ce=
rt);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ssl_test_extract_peer_info(void **state)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *peer_info_normal =3D</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        &quot;IV_VER=3D2=2E6_git\nIV_PLAT=3Dmac\=
nIV_TCPNL=3D1\nIV_NCP=3D2\n&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &quot;IV_CIPHERS=3DAES-256-GCM:AES-128-GCM:CHACHA20-P=
OLY1305\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    &quot;IV_PROTO=3D94\nIV_LZO_STUB=3D1\nIV_COMP_STUB=3D1\nP=3D78\nIV_COMP=
_STUBv2=3D1\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        &quot;IV_SSL=3DOpenSSL_3=2E0=2E5_5_Jul_2022\nIV_LZ4v2=3D1&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *empty =3D &quot;&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *inval=
id_proto =3D &quot;IV_PROTO=3Dseven\nIV_SSL=3D7\nP=3D300\nID=3Dxyz&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *test_=
prefix =3D &quot;UV_IV_PROTO=3D773\nNP=3D112\nPD=3D8\n&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(extract_iv_proto(peer_info_normal), 94);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(extract_=
iv_proto(empty), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(extract_iv_proto(invalid_proto), 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* This should not pick up the U=
V_IV_PROTO that has the extra prefix */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(extract_iv_proto(test_prefix), 0);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_extract=
_uint(peer_info_normal, &quot;IV_COMP_STUB=3D&quot;), 1);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_extrac=
t_int(empty, &quot;IV_COMP_STUB=3D&quot;, &quot;%d&quot;, 0xfe0d0d), 0xfe0d=
0d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(peer_info_extract_uint(invalid_proto, &quot;IV_COMP_STUB=3D&quot;), 0=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_extra=
ct_int(test_prefix, &quot;NP=3D&quot;, &quot;%d&quot;, 23), 112);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(peer_inf=
o_extract_uint(test_prefix, &quot;PD=3D&quot;), 8);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_extract_in=
t(test_prefix, &quot;P=3D&quot;, &quot;%x&quot;, 0xfe0d0d), 0xfe0d0d);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(pee=
r_info_extract_uint(peer_info_normal, &quot;P=3D&quot;), 78);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(peer_info_ex=
tract_uint(test_prefix, &quot;UV_IV_PROTO=3D&quot;), 773);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *peer_ciphers =3D extract_var_peer_info(pe=
er_info_normal, &quot;IV_CIPHERS=3D&quot;, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(peer_ciphers, &qu=
ot;AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* with the extra =3D this should not extract anything *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *pr=
oto =3D extract_var_peer_info(peer_info_normal, &quot;IV_PROTO=3D=3D&quot;,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_null(proto);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    proto =3D extract_va=
r_peer_info(peer_info_normal, &quot;IV_PROTO=3D&quot;, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(proto,=
 &quot;94&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *double_eq_info =3D &quot=
;FOO=3D7\nFOO=3D=3Dnew&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *foo_eq =3D extract_var_peer_info(double_eq_info, =
&quot;FOO=3D&quot;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *foo =3D extract_var_peer_info(double_eq_info, &qu=
ot;FOO&quot;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *foo_2eq =3D extract_var_peer_info(double_eq_info, &quot=
;FOO=3D=3D&quot;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(foo, &quot;=3D7&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(foo_eq, &quot;7&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(foo_2e=
q, &quot;new&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(extract_asymmetric_peer_id(double_eq_info), MAX_PEER_ID);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(extract_asymm=
etric_peer_id(peer_info_normal), MAX_PEER_ID);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(extract_asymmetric_peer_id(=
invalid_proto), MAX_PEER_ID);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(extract_asymmetric_peer_id(&quot;ID=3Df7&quo=
t;), 0xf7);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(extract_asymmetric_peer_id(&quot;X=3Dfoo\nID=3D12ab&quot;), 0x=
12ab);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(extract_asymmetric_peer_id(&quot;X=3Dfoo\nID=3D34dd\nY=3Dbar&quot;)=
, 0x34dd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(extract_asymmetric_peer_id(&quot;X=3Dfoo\nID=3D12345678&quot;),=
 MAX_PEER_ID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </s=
pan><br><span> int</span><br><span> main(void)</span><br><span>@@ -908,7 +9=
72,8 @@</span><br><span>         cmocka_unit_test(test_data_channel_roundtr=
ip_bf_cbc),</span><br><span>         cmocka_unit_test(test_data_channel_kno=
wn_vectors_epoch),</span><br><span>         cmocka_unit_test(test_data_chan=
nel_known_vectors_shortpktid),</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        cmocka_unit_test(crypto_test_print_cert_details)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(cryp=
to_test_print_cert_details),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(ssl_test_extract_peer_info)</span><br><sp=
an> </span><br><span>     };</span><br><span> </span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1800?usp=3Demail">change 1800</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1800?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1800 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> =
Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--ICZfLERMd9Y=--


--===============0262255452210587843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0262255452210587843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0262255452210587843==--

