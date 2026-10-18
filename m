Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E7ECCF2CF
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FLie7EOx2xgfQKgeAGQYDhNvU/dAtNln/J/b2/m3NrA=; b=JYamyPBGm8glmMoQ5gumnADDFs
	hANOGk6UOCA3Ksf7t6hg0Mpg+4CRqZvpURTkB7wc2IGx2Rt5u4oqF9vAML2sObspjPhHmm3oQIHsp
	cd8o4bdK5adKqXoTtWoHPDdopFVolFg1HJwBfMo5p6KrdMgCsXypx1mlNbxsJ6vXtuGI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQY6-0006fP-FC;
	Sun, 18 Oct 2026 13:03:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIQY5-0006fI-Id
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:03:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=obKfCVg8A0etlA9GvY+4SPbGc+/8n+ta7BPVKefJ3Bs=; b=UFHEDM2bBPkcNpu0/GD49m1hAh
 Lw2faY5sNTGBTJMps1aOBDLOmTclLeu1bNaGQ4PJbnmsAlO+uUwpMth0Trb2BaTxjUfBh6UdZDIde
 jgK+ZEfloPXHsJSVUYHmoBmQUdX4tiNP6stXrdnB44UEaWnu/ApkM/rRiD3k9FZ5OV3M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=obKfCVg8A0etlA9GvY+4SPbGc+/8n+ta7BPVKefJ3Bs=; b=N
 qC73HC67J8QxU/FV+tjduUu6bGSrmSaRfEN+dfL1NrC3joVkQCixwlsVsrcIfEdrulkxMy7UxynX1
 0o1qOgYsmYZmtmmb9F1wygImdzMTasqcjcCaGfkMjKLB1sFG8CZtyrkcaip+98Ku9+KoWl1IBjvgu
 iNNu/d8MycfRifEI=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIQY3-0006YU-Jv for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:03:37 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso811839f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792328609; x=1792933409; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=obKfCVg8A0etlA9GvY+4SPbGc+/8n+ta7BPVKefJ3Bs=;
 b=UxGw1OYV+DFZWqkb3jO1gXYo+RcK2acS7NVNhWtbA32XcJhWjElqy0D+4MXuDdv2to
 mytoe9BJ8gjxpUaOwF34cQSbpZ/rfsL06gv23o/MG+DVmJisJ+4HrUzsKyzx68P6mHxe
 5cEvKxmvraWTxIc2rGGi+3AXyrahvz3jvpE2PvF2pIAp4dh/sZveXLbz2Om4zizdLqYp
 QBoREn9XpoYAlZOjnILK/+C4Ac2lg4y6Gee9iVlzF5K4ZLXUZ8CfzelNIwhJV3hVxZmj
 1o+I8fuTHgL1GaUEs0MVe7Lr37L8jglEocTZ+yWRQ0TtGwxAR0xmdTY4DLODyuHV+gAS
 Vvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792328609; x=1792933409;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=obKfCVg8A0etlA9GvY+4SPbGc+/8n+ta7BPVKefJ3Bs=;
 b=d8IEsG9OiTzEdK2vl+UK6xBSwbG0G46sikv48SfRHd+eM2MEIRbHsAj9CxgLt+VTop
 1u5kWwPsGddirsbRWZUubQq9x/l8NjF2xJJj5Cw5PbYZbsmfm0FWx1v1yWh2RX+asEQq
 TVAIMm5GtL8w0FyOCpsxyFRCuXPv6/vL1cco6L/FMnzjJG8koR69BUWQmUUwlim6hRyz
 hNg+CBe8J1D+wOH0kMvehW46pDTwuJTYjxih13KBxxBV1XRZxg3803GtTXXe6fkGvU/E
 3L/ZFxAH3h5I4rzH3bsWaidEtZTGmrVvrhNpPkdEeIeAapvpds1tLa8/6BpFFNyHzPTs
 BTGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmTcowRcbIqxbFWCASEBQ+npNvEY5A7WlTVUQz0UpX2OryaXE8Bc3Lx2xZQBV9KHCWYx90YQfUPGn5JNEh@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKdDKc0xwoA9CqVtxrqk4I2NkfcZtlgXkj0Sgn9ujZyOj5FIIRc
 nxaW16pyBsVwgmD8zAMNe1gJeQKyN8a/OI/9dJLsINjQeR1IkCbNPS9JRLLmG1/A7LLFWxfkf8e
 SWASOjU7+3FDsNuqs4HT/mQC+QD1UGOAHL5A8iyHF/rNL8+eOsxXTuaebcLxa+7sDxR2jVCXjre
 d393/TMQ==
X-Gm-Gg: AYBFou2w0sgzUsubkam+lOcXHFc1oaEXMoenYUWGPiWcG5C+Vy2yiuNDHV3KgCOZzy6
 NidtAIvyfTA63xZFm7LjF+lkTTI0xUGtUjpbQIpVUy5HYaxwgP+hrtqzh0EFKkcvPlbCIaRCvKk
 i/DHRp/8iLPljoJ7Wgqf0WFxvoo1VHTUkDyE56/62k8Ee2KHFXyRxUibv6FnBqO8R7kaOTmxStb
 3hPgfvQQCZhKtPcG2AuG7PEkhFZ+BkeG6MYQ6xGIBKDdQ9CINp9zDSFLn0tH0CoRrj/SvjdHa+m
 n1tKeC1mNazq4ocVVWc7t0pxv4aScE83ECUWnIhFWJlfJpf8757N/owmZ4wRie17fqpaXZZWjVJ
 Nyy9pppGM+eEq2X6pem289+1TEbpAeJUxoxcdL6sxMtNK1BXCmTN/W8QiqoWWjnCvsYHYahxy6L
 auTiGXdrdSNlmCfgqrC8dmokJgMJNwOS3+4uwiFjUu0dgZKd+Z0MG7iREgqp4ctLbkllrTR98fd
 iibkngB1QNexctKfGf04QD919M4tASpZw/djuQbQqlGYwunXauQqkxjiJTx+0cLLHSYEMhPA9Vf
 BXDkxDoOG3qE8+oxunlZ4Q/4doOclRLx4eY4E2zinXMI7nxt6ASx+4ZzgyT3
X-Received: by 2002:a5d:5486:0:b0:48d:faa4:5b66 with SMTP id
 ffacd0b85a97d-48e07fa41damr7235661f8f.36.1792328608846; 
 Sun, 18 Oct 2026 06:03:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4f5b2dsm18120544f8f.31.2026.10.18.06.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:03:28 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:03:27 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335
X-Gerrit-Change-Number: 1996
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1996?usp=email>
X-Gerrit-Commit: fa57eb158da8a1c03a6f037cc536f5a3bce656f3
In-Reply-To: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
References: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk2MWUyOWRkMmFmOTMwMmIyNDBjOTM3MzUxNzlkNDNjNzJlMzdiMzM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <590c3041e227e01de399f3ad23db588483431a1f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIQY3-0006YU-Jv
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace strncat with
 strlcat
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
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8825687760693412504=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8825687760693412504==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cW7NleMut2A="; charset=UTF-8

--cW7NleMut2A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1996?usp=3Demail )

Change subject: Replace strncat with strlca=
t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace st=
rncat with strlcat

Generally much better API=2E Not a straight-forward
rep=
lacement in many cases, trying to improve the
code generally=2E

Change-Id:=
 I61e29dd2af9302b240c93735179d43c72e37b335
Signed-off-by: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996
Message-Id: <=
20261017171508=2E15923-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39946=2Ehtml
Signed=
-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/misc=2Ec
=
M src/openvpn/options_parse=2Ec
M src/openvpn/status=2Ec
M src/openvpn/xkey=
_helper=2Ec
M src/plugins/auth-pam/utils=2Ec
5 files changed, 25 insertions=
(+), 25 deletions(-)




diff --git a/src/openvpn/misc=2Ec b/src/openvpn/mi=
sc=2Ec
index a75bd8f=2E=2Eb9cc6a2 100644
--- a/src/openvpn/misc=2Ec
+++ b/s=
rc/openvpn/misc=2Ec
@@ -437,12 +437,11 @@
                     }
          =
           else
                     {
-                        if (strlen(=
up->password) + strlen(response) >=3D USER_PASS_LEN)
+                     =
   if (strlcat(up->password, response, USER_PASS_LEN) >=3D USER_PASS_LEN)
 =
                        {
                             msg(M_FATAL,
       =
                          "ERROR: could not concatenate password/static_res=
ponse: string too long");
                         }
-                     =
   strncat(up->password, response, USER_PASS_LEN - strlen(up->password) - 1=
);
                     }
                 }
 #endif /* ifdef ENABLE_MANAGE=
MENT */
diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_pa=
rse=2Ec
index 79b8098=2E=2E5d6f93e 100644
--- a/src/openvpn/options_parse=
=2Ec
+++ b/src/openvpn/options_parse=2Ec
@@ -244,10 +244,7 @@
     else if =
(is->type =3D=3D IS_TYPE_BUF)
     {
         bool status =3D buf_parse(is-=
>u=2Emultiline, '\n', line, size);
-        if ((int)strlen(line) + 1 < siz=
e)
-        {
-            strcat(line, "\n");
-        }
+        strlcat(=
line, "\n", size);
         return status;
     }
     else
diff --git a/sr=
c/openvpn/status=2Ec b/src/openvpn/status=2Ec
index cfbc38d=2E=2E1036536 10=
0644
--- a/src/openvpn/status=2Ec
+++ b/src/openvpn/status=2Ec
@@ -234,14 +=
234,11 @@
 
         if (so->fd >=3D 0 && !so->errors)
         {
-        =
    strcat(buf, "\n");
-            ssize_t len =3D strlen(buf);
-         =
   if (len > 0)
+            size_t len =3D strlcat(buf, "\n", sizeof(buf))=
;
+            ASSERT(len < sizeof(buf));
+            if (write(so->fd, bu=
f, (unsigned int)len) !=3D (ssize_t)len)
             {
-                if=
 (write(so->fd, buf, (unsigned int)len) !=3D len)
-                {
-     =
               so->errors =3D true;
-                }
+                so-=
>errors =3D true;
             }
         }
 
diff --git a/src/openvpn/xkey=
_helper=2Ec b/src/openvpn/xkey_helper=2Ec
index 1149c7b=2E=2E6908cbb 100644=

--- a/src/openvpn/xkey_helper=2Ec
+++ b/src/openvpn/xkey_helper=2Ec
@@ -15=
7,7 +157,7 @@
  * @param tbslen        len of data in dgst
  * @param sigal=
g        extra signature parameters
  *
- * @return              signature =
length or -1 on error=2E
+ * @return              1 on success or 0 on erro=
r=2E
  */
 int
 xkey_management_sign(void *unused, unsigned char *sig, size=
_t *siglen, const unsigned char *tbs,
@@ -247,7 +247,10 @@
 
     if (is_me=
ssage)
     {
-        strncat(alg_str, ",data=3Dmessage", sizeof(alg_str) =
- strlen(alg_str) - 1);
+        if (strlcat(alg_str, ",data=3Dmessage", si=
zeof(alg_str)) >=3D sizeof(alg_str))
+        {
+            return 0;
+   =
     }
     }
 
     dmsg(D_LOW, "xkey management_sign: requesting sig with=
 algorithm <%s>", alg_str);
diff --git a/src/plugins/auth-pam/utils=2Ec b/s=
rc/plugins/auth-pam/utils=2Ec
index a4d2d0b=2E=2E01cc4de 100644
--- a/src/p=
lugins/auth-pam/utils=2Ec
+++ b/src/plugins/auth-pam/utils=2Ec
@@ -47,10 +4=
7,11 @@
     }
 
     size_t tosearchlen =3D strlen(tosearch);
+    size_t =
searchforlen =3D strlen(searchfor);
     size_t replacewithlen =3D strlen(r=
eplacewith);
     size_t templen =3D tosearchlen * replacewithlen;
 
-    i=
f (tosearchlen =3D=3D 0 || strlen(searchfor) =3D=3D 0 || replacewithlen =3D=
=3D 0)
+    if (tosearchlen =3D=3D 0 || searchforlen =3D=3D 0 || replacewit=
hlen =3D=3D 0)
     {
         return NULL;
     }
@@ -65,23 +66,26 @@
 
  =
   /* state: all parameters are valid */
 
-    const char *searching =3D t=
osearch;
-
-    char temp[templen + 1];
-    temp[0] =3D 0;
-
-    const ch=
ar *scratch =3D strstr(searching, searchfor);
+    const char *scratch =3D =
strstr(tosearch, searchfor);
     if (!scratch)
     {
         return strd=
up(tosearch);
     }
 
+    const char *searching =3D tosearch;
+    char t=
emp[templen + 1];
+    memset(temp, 0, sizeof(temp));
+    char *target =3D=
 temp;
+
     while (scratch)
     {
-        strncat(temp, searching, (siz=
e_t)(scratch - searching));
-        strcat(temp, replacewith);
+        si=
ze_t skipped =3D (size_t)(scratch - searching);
+        memcpy(target, sea=
rching, skipped);
+        target +=3D skipped;
+        memcpy(target, rep=
lacewith, replacewithlen);
+        target +=3D replacewithlen;
 
-        =
searching =3D scratch + strlen(searchfor);
+        searching =3D scratch +=
 searchforlen;
         scratch =3D strstr(searching, searchfor);
     }
  =
   return strdup(temp);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1996?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I61e29dd2af9302b240c93735179d43c72e37b335
Gerrit-Change-Number: 1996
Ge=
rrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--cW7NleMut2A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1996?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Replace strncat with strlcat<br><b=
r>Generally much better API=2E Not a straight-forward<br>replacement in man=
y cases, trying to improve the<br>code generally=2E<br><br>Change-Id: I61e2=
9dd2af9302b240c93735179d43c72e37b335<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/199=
6<br>Message-Id: &lt;20261017171508=2E15923-1-gert@greenie=2Emuc=2Ede&gt;<b=
r>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg39946=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/misc=2Ec<br>M src/openvpn/options_parse=
=2Ec<br>M src/openvpn/status=2Ec<br>M src/openvpn/xkey_helper=2Ec<br>M src/=
plugins/auth-pam/utils=2Ec<br>5 files changed, 25 insertions(+), 25 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=
=2Ec</span><br><span>index a75bd8f=2E=2Eb9cc6a2 100644</span><br><span>--- =
a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br=
><span>@@ -437,12 +437,11 @@</span><br><span>                     }</span><=
br><span>                     else</span><br><span>                     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 if (strlen(up-&gt;password) + strlen(response) &gt;=3D USER_PASS_LEN)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
if (strlcat(up-&gt;password, response, USER_PASS_LEN) &gt;=3D USER_PASS_LEN=
)</span><br><span>                         {</span><br><span>              =
               msg(M_FATAL,</span><br><span>                               =
  &quot;ERROR: could not concatenate password/static_response: string too l=
ong&quot;);</span><br><span>                         }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                        strncat(up-&gt;pas=
sword, response, USER_PASS_LEN - strlen(up-&gt;password) - 1);</span><br><s=
pan>                     }</span><br><span>                 }</span><br><sp=
an> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span>diff --git a/src/o=
penvpn/options_parse=2Ec b/src/openvpn/options_parse=2Ec</span><br><span>in=
dex 79b8098=2E=2E5d6f93e 100644</span><br><span>--- a/src/openvpn/options_p=
arse=2Ec</span><br><span>+++ b/src/openvpn/options_parse=2Ec</span><br><spa=
n>@@ -244,10 +244,7 @@</span><br><span>     else if (is-&gt;type =3D=3D IS_=
TYPE_BUF)</span><br><span>     {</span><br><span>         bool status =3D b=
uf_parse(is-&gt;u=2Emultiline, &#39;\n&#39;, line, size);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if ((int)strlen(line) + 1 &lt; =
size)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            strcat(line, &qu=
ot;\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strlcat(li=
ne, &quot;\n&quot;, size);</span><br><span>         return status;</span><b=
r><span>     }</span><br><span>     else</span><br><span>diff --git a/src/o=
penvpn/status=2Ec b/src/openvpn/status=2Ec</span><br><span>index cfbc38d=2E=
=2E1036536 100644</span><br><span>--- a/src/openvpn/status=2Ec</span><br><s=
pan>+++ b/src/openvpn/status=2Ec</span><br><span>@@ -234,14 +234,11 @@</spa=
n><br><span> </span><br><span>         if (so-&gt;fd &gt;=3D 0 &amp;&amp; !=
so-&gt;errors)</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            strcat(buf, &quot;\n&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            ssize_t len =3D strlen(b=
uf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (l=
en &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   size_t len =3D strlcat(buf, &quot;\n&quot;, sizeof(buf));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(len &lt; sizeof=
(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (write(so-&gt;fd, buf, (unsigned int)len) !=3D (ssize_t)len)</span><br><=
span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              if (write(so-&gt;fd, buf, (unsigned int)len) !=3D len)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    so-&gt;error=
s =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    so-&gt;errors =3D true;</span><br><span>             }</span><br><span>=
         }</span><br><span> </span><br><span>diff --git a/src/openvpn/xkey_=
helper=2Ec b/src/openvpn/xkey_helper=2Ec</span><br><span>index 1149c7b=2E=
=2E6908cbb 100644</span><br><span>--- a/src/openvpn/xkey_helper=2Ec</span><=
br><span>+++ b/src/openvpn/xkey_helper=2Ec</span><br><span>@@ -157,7 +157,7=
 @@</span><br><span>  * @param tbslen        len of data in dgst</span><br>=
<span>  * @param sigalg        extra signature parameters</span><br><span> =
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return         =
     signature length or -1 on error=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return              1 on success or 0 on error=2E</=
span><br><span>  */</span><br><span> int</span><br><span> xkey_management_s=
ign(void *unused, unsigned char *sig, size_t *siglen, const unsigned char *=
tbs,</span><br><span>@@ -247,7 +247,10 @@</span><br><span> </span><br><span=
>     if (is_message)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        strncat(alg_str, &quot;,data=3Dmessage&quot;=
, sizeof(alg_str) - strlen(alg_str) - 1);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (strlcat(alg_str, &quot;,data=3Dmessage&qu=
ot;, sizeof(alg_str)) &gt;=3D sizeof(alg_str))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            return 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> </span=
><br><span>     dmsg(D_LOW, &quot;xkey management_sign: requesting sig with=
 algorithm &lt;%s&gt;&quot;, alg_str);</span><br><span>diff --git a/src/plu=
gins/auth-pam/utils=2Ec b/src/plugins/auth-pam/utils=2Ec</span><br><span>in=
dex a4d2d0b=2E=2E01cc4de 100644</span><br><span>--- a/src/plugins/auth-pam/=
utils=2Ec</span><br><span>+++ b/src/plugins/auth-pam/utils=2Ec</span><br><s=
pan>@@ -47,10 +47,11 @@</span><br><span>     }</span><br><span> </span><br>=
<span>     size_t tosearchlen =3D strlen(tosearch);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t searchforlen =3D strlen(search=
for);</span><br><span>     size_t replacewithlen =3D strlen(replacewith);</=
span><br><span>     size_t templen =3D tosearchlen * replacewithlen;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (to=
searchlen =3D=3D 0 || strlen(searchfor) =3D=3D 0 || replacewithlen =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tosearchle=
n =3D=3D 0 || searchforlen =3D=3D 0 || replacewithlen =3D=3D 0)</span><br><=
span>     {</span><br><span>         return NULL;</span><br><span>     }</s=
pan><br><span>@@ -65,23 +66,26 @@</span><br><span> </span><br><span>     /*=
 state: all parameters are valid */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *searching =3D tosearch;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    char temp[templen + 1];</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    temp[0] =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    const char *scratch =3D strstr(searching, searchfor);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *scratch =
=3D strstr(tosearch, searchfor);</span><br><span>     if (!scratch)</span><=
br><span>     {</span><br><span>         return strdup(tosearch);</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const char *searching =3D tosearch;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char temp[templen + 1];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    memset(temp, 0, sizeof(temp))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *target =
=3D temp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     while (scratch)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        strncat(temp, searching, (size_t)(scra=
tch - searching));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     strcat(temp, replacewith);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        size_t skipped =3D (size_t)(scratch - searching);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(target, se=
arching, skipped);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       target +=3D skipped;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        memcpy(target, replacewith, replacewithlen);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        target +=3D replacewithlen=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      searching =3D scratch + strlen(searchfor);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        searching =3D scratch + searchforlen;<=
/span><br><span>         scratch =3D strstr(searching, searchfor);</span><b=
r><span>     }</span><br><span>     return strdup(temp);</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996?=
usp=3Demail">change 1996</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1996?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1996 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--cW7NleMut2A=--


--===============8825687760693412504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8825687760693412504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8825687760693412504==--

