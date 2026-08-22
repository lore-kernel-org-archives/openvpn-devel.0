Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E21BC5DF97
	for <openvpn-devel@archiver.kernel.org>; Sat, 22 Aug 2026 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0kN/Bzmkb9jE+4eSZCUphtuxNHadeu24cMeYBioLFLw=; b=WqJYsfKDvjvozEaix9IJySVk5w
	6oHv+hWMfrtAjaD1oFJl3pYi/Y8Ksn9u0fC2+cSNjTiOB3PQ0KrsLOEiCLqUuVa6oGeYUy8gjovvL
	7EdgKdXs0JiW4qZp7R/Dxq+y66Hk4QMNIEh2N2nmC4+t3c41XEErVPP93Y63he+9T7Hg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxo90-0007PA-D0;
	Sat, 22 Aug 2026 16:00:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxo8z-0007Oz-G4
 for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 16:00:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yJp/4svb2n9As9sDZSbzcB4tch3xg9wwbCYQVFAQPj0=; b=A4JedTItotPNRZ5y6uGd4yBkmt
 EZFbOgeE0DXQRtS2d/RNgAQzRTCtldPuGLIPefoJZYGq9MEQhNEzqfFkobpu5vxBx5tSQ2guJKKfJ
 s+gGaWlAsgCphuWgyAcz1mFlEU+QJ70Aa4CGv8FbLdkgSsxUrvX5tWjeCcp8b9kt6lV8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yJp/4svb2n9As9sDZSbzcB4tch3xg9wwbCYQVFAQPj0=; b=i
 cX8xeuG++g/FGH3pkEr/qVOhXCZmH38GNk6vRIum8ea3qVEuBq8EnipQi/723uMxKZBcK8pzz71JJ
 xxY6w0nFi0Q7W+VPU/8isSuT8rIiOpu+kP4GaSpcQ0UtK2BNf408eeLZS5tsjyDeHYUamEsRgaqT4
 6lKJZymdGf1GDVlo=;
Received: from mail-ej1-f51.google.com ([209.85.218.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxo8x-0003Tq-2h for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 16:00:30 +0000
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so304476666b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 22 Aug 2026 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787414420; x=1788019220; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yJp/4svb2n9As9sDZSbzcB4tch3xg9wwbCYQVFAQPj0=;
 b=d1NCcxpsgqXhgJQV1V8iTILs5COw0YtzGzVJKh+aYoFEIilNMKPsIED1CJD7nqXGyA
 RezxBZXrse8U8NTUomGqeYAW2By8aNvCoVYy1rufj8xG33WPBqSfgRnqE77UgTHEGhvz
 anxAp47BdDFFt6her2DyX9qexZpK22T0dXi0SxWmnzw/7sxTNPO02wEBg3Q66O4c91Xq
 ZcRg+EtKCwYXYgqxcPzLiTtM1K6TTTP2iorGBu8cbbhjlWgQzlnLLy418Tm/Z2Vl7E31
 pN64PUH2FK4deslVAaSZ0DKn6fUuqBD/NoMpvC3pDaWN5XAgK3TGXBplpNxE2L7FjeHT
 hyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787414420; x=1788019220;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yJp/4svb2n9As9sDZSbzcB4tch3xg9wwbCYQVFAQPj0=;
 b=p8ydElNN9JIQ3RZHjcMVicAC6QYNiWgxvJOJvgOQ+awDBYmMz9Zx7XKSatG5ry3rFv
 eaLMRZWnMy/MoZb58llyXF4dXZC4/hox5jUCNzY79DBfc96aMCMbZbXQpGGp51f4VtaY
 vGH9lkWTQdYnf3V2RtuJvN4ePd0N9/Lmz97yaXg75SAhSSZiOyl/oLzSPYhfNmqTqCS3
 Ffpsax3xrbfVWh9m56Hk4sfbHWiMgXtrCcMHdfvIfDE25QV1WX6U7mTQQbq2VyTuZ3+V
 nTtggAp7kOnJlrJu9m6HkXTwFfqPzdOgZ+/GPSFfgJRh5IPMLFtDjuh6mY/0kmIFBKxx
 lAdQ==
X-Gm-Message-State: AFuF++nYjRz+eLso4VDUgiW6wVpo09aiItgAMUiSohtddBjRk42+otKf
 azqlfNWHKUVLwJt/mLDEWKc3EUAnQKCbHApBKgmDamfTJxsRa/tq6ChAm0A18kkXqMTf4Mss7nP
 VjAtNytsKQSUACBlyFWjhdDxnhRdBttNQb5cq1rMryzZ2TrCXh+/Jhbmv6cD9KUoiNfPKf0dCcH
 r9Co0E3A==
X-Gm-Gg: AR+sD12J3iBa6c8CUNYkeG22c5zMI+kuxlpmUQkp0AsnUazfjm9mHjnT3BxFwk4pNIC
 eLUhgDlcLIOoVRUkcxGmFSUN3PSApAxJwrdvXU5fDhZCHY3SsCpQ3zk4zYL4xUP/XHz7/6lkO3I
 F4xIrMEPsnxQaRtkmwfa77WEw6Ni1cUpVdZdQUKIaNRo+Np8FJAh5FuLvmrYBVj0tyOpn3AWEy+
 kNPZoRF1SbmqyPia1fy1Lq6DGbFI97pPYbzbJIskurKr/fu8uI/IJZjRttKc/ZgzGZRJ4e8zvCI
 rp4H9zNhHGEp6vOuE+VXBbtaT8BjX85RvOHFmjuUBBezobOdfG7v1BE2WyuNrsSUKedTIx6uMj9
 S6Rwa+gyKje9sRRcg8wvCOJ///xyDQjhzmcd+ouHBdqnSOksIWkPoMNBqSQrCHst1fgsCTC4sxS
 AxQ+qpf0hw6ydBw/NQoz39MwTehKMHULRGlj3dFejZ67zzX44fdBdEazg3yYvpGkw7RHcf/UlfC
 oWtuxNS1PHL2PHVpfJFOY/xApFIqdi/Q+cwKu2oST9/5U5Uyf7889KGCfOY3MTMWVsaKrLUDP70
 sk2t1Ulw21jYyWdPK9JlYZg6bubNXciMMU8fOMQBorQ44GggEow=
X-Received: by 2002:a17:906:a38c:b0:c15:e8c8:340 with SMTP id
 a640c23a62f3a-c246a731b85mr1216091566b.23.1787414420206; 
 Sat, 22 Aug 2026 09:00:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249629563dsm396207266b.17.2026.08.22.09.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 09:00:19 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 22 Aug 2026 16:00:17 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909
X-Gerrit-Change-Number: 1775
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1775?usp=email>
X-Gerrit-Commit: 3de926089fdebd79b9d25e80c31e45c1e044911d
In-Reply-To: <gerrit.1783600902000.I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909@gerrit.openvpn.net>
References: <gerrit.1783600902000.I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkkwOWFkMGQ5YmFhYTczNTFlZWNiNWFhZmRiNWM2ZTdiNDdjZjdjOTA5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d26544b820d68e764f0a2edb2a5272b1eee1c56b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxo8x-0003Tq-2h
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: Move string
 utility functions to buffer
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1466611995917822780=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1466611995917822780==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LT7w3KELwOk="; charset=UTF-8

--LT7w3KELwOk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: options: Move string utility functions to buff=
er
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: M=
ove string utility functions to buffer

buffer seems to be where we collect=
 string utility
functions, so move them out of options=2E

Change-Id: I09ad=
0d9baaa7351eecb5aafdb5c6e7b47cf7c909
Signed-off-by: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775
Message-Id: <202608=
19211812=2E3214-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38541=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
M sr=
c/openvpn/buffer=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
4 =
files changed, 35 insertions(+), 34 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/75/1775/6

diff --git a/src/ope=
nvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index f14caa2=2E=2E8c19902 100644
=
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -1086,6 +1086,=
38 @@
 }
 
 bool
+string_defined_equal(const char *s1, const char *s2)
+{
+=
    if (s1 && s2)
+    {
+        return !strcmp(s1, s2);
+    }
+    else
=
+    {
+        return false;
+    }
+}
+
+char *
+string_substitute(const =
char *src, char from, char to, struct gc_arena *gc)
+{
+    char *ret =3D (=
char *)gc_malloc(strlen(src) + 1, true, gc);
+    char *dest =3D ret;
+    =
char c;
+
+    do
+    {
+        c =3D *src++;
+        if (c =3D=3D from)=

+        {
+            c =3D to;
+        }
+        *dest++ =3D c;
+    =
} while (c);
+    return ret;
+}
+
+bool
 checked_snprintf(char *str, size_=
t size, const char *format, =2E=2E=2E)
 {
     va_list arglist;
diff --git =
a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 85277ff=2E=2E651aae=
d 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1766=
,6 +1766,9 @@
     return 0 =3D=3D strncmp(str, prefix, strlen(prefix));
 }=

 
+bool string_defined_equal(const char *s1, const char *s2);
+char *strin=
g_substitute(const char *src, char from, char to, struct gc_arena *gc);
+
 =
/**
  * Like snprintf() but returns an boolean=2E
  *
diff --git a/src/open=
vpn/options=2Ec b/src/openvpn/options=2Ec
index 9bd6f01=2E=2E107b3fa9 10064=
4
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1087,25 +=
1087,6 @@
     return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);
=
 }
 
-static char *
-string_substitute(const char *src, char from, char to,=
 struct gc_arena *gc)
-{
-    char *ret =3D (char *)gc_malloc(strlen(src) +=
 1, true, gc);
-    char *dest =3D ret;
-    char c;
-
-    do
-    {
-    =
    c =3D *src++;
-        if (c =3D=3D from)
-        {
-            c =3D=
 to;
-        }
-        *dest++ =3D c;
-    } while (c);
-    return ret;
=
-}
-
 /**
  * Parses a hexstring and checks if the string has the correct l=
ength=2E Return
  * a verify_hash_list containing the parsed hash string=2E=

@@ -3565,19 +3546,6 @@
     }
 }
 
-bool
-string_defined_equal(const char =
*s1, const char *s2)
-{
-    if (s1 && s2)
-    {
-        return !strcmp(s=
1, s2);
-    }
-    else
-    {
-        return false;
-    }
-}
-
 #if 0
 =
static void
 ping_rec_err(msglvl_t msglevel)
diff --git a/src/openvpn/optio=
ns=2Eh b/src/openvpn/options=2Eh
index 0fd505a=2E=2Ec23d0b3 100644
--- a/sr=
c/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -901,8 +901,6 @@
 
 =
void setenv_settings(struct env_set *es, const struct options *o);
 
-bool =
string_defined_equal(const char *s1, const char *s2);
-
 void options_postp=
rocess(struct options *options, struct env_set *es);
 
 bool options_postpr=
ocess_pull(struct options *o, struct env_set *es);

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909=

Gerrit-Change-Number: 1775
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--LT7w3KELwOk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">options: Move string uti=
lity functions to buffer<br><br>buffer seems to be where we collect string =
utility<br>functions, so move them out of options=2E<br><br>Change-Id: I09a=
d0d9baaa7351eecb5aafdb5c6e7b47cf7c909<br>Signed-off-by: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
75<br>Message-Id: &lt;20260819211812=2E3214-1-gert@greenie=2Emuc=2Ede&gt;<b=
r>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38541=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<b=
r>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>4 files changed=
, 35 insertions(+), 34 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/75/1775/6</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>in=
dex f14caa2=2E=2E8c19902 100644</span><br><span>--- a/src/openvpn/buffer=2E=
c</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -1086,6 +=
1086,38 @@</span><br><span> }</span><br><span> </span><br><span> bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+string_defined_equal(cons=
t char *s1, const char *s2)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (s1=
 &amp;&amp; s2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return !st=
rcmp(s1, s2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+string_substitute(const char *=
src, char from, char to, struct gc_arena *gc)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    char *ret =3D (char *)gc_malloc(strlen(src) + 1, true, gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *dest =3D ret;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char c;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    do</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        c =3D *src++;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (c =3D=3D from)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            c =3D to;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 *dest++ =3D c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
} while (c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool</span><br><span> checked_snprintf(char *str=
, size_t size, const char *format, =2E=2E=2E)</span><br><span> {</span><br>=
<span>     va_list arglist;</span><br><span>diff --git a/src/openvpn/buffer=
=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 85277ff=2E=2E651aaed 10=
0644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src=
/openvpn/buffer=2Eh</span><br><span>@@ -1766,6 +1766,9 @@</span><br><span> =
    return 0 =3D=3D strncmp(str, prefix, strlen(prefix));</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool string_defined_equal(const char *s1, const char *s2);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+char *string_substitute(const char *=
src, char from, char to, struct gc_arena *gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Like s=
nprintf() but returns an boolean=2E</span><br><span>  *</span><br><span>dif=
f --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span=
>index 9bd6f01=2E=2E107b3fa9 100644</span><br><span>--- a/src/openvpn/optio=
ns=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -10=
87,25 +1087,6 @@</span><br><span>     return get_ipv6_addr(ipv6_prefix_spec=
, NULL, NULL, M_WARN);</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static char *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-string_substitute(const char *src, char fro=
m, char to, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char =
*ret =3D (char *)gc_malloc(strlen(src) + 1, true, gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    char *dest =3D ret;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    char c;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        c =3D *src++;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c =3D=3D from)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            c =3D to;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        *dest++ =3D c;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    } while (c);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return ret;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> /**</span><br><span>  * Parses a hexstring and checks if=
 the string has the correct length=2E Return</span><br><span>  * a verify_h=
ash_list containing the parsed hash string=2E</span><br><span>@@ -3565,19 +=
3546,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-string_defined_equal(const char *s1, const =
char *s2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (s1 &amp;&amp; s2)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return !strcmp(s1, s2);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #if 0</span><br><span=
> static void</span><br><span> ping_rec_err(msglvl_t msglevel)</span><br><s=
pan>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><b=
r><span>index 0fd505a=2E=2Ec23d0b3 100644</span><br><span>--- a/src/openvpn=
/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>=
@@ -901,8 +901,6 @@</span><br><span> </span><br><span> void setenv_settings=
(struct env_set *es, const struct options *o);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-bool string_defined_equal(const =
char *s1, const char *s2);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> void options_postprocess(struct options *options, st=
ruct env_set *es);</span><br><span> </span><br><span> bool options_postproc=
ess_pull(struct options *o, struct env_set *es);</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1775?usp=3Demail">change 1775</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1775?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1775 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bod=
y></html>
--LT7w3KELwOk=--


--===============1466611995917822780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1466611995917822780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1466611995917822780==--

