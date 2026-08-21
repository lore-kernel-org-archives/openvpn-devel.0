Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864E9C5DF7D
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=tUFl7gbZFV1Pq3n0z8BJpv/Fzp4pAx0ggF7bXZO1JTY=; b=cMs8X6n7vIKTOI
	ZJDA21ZfGqnLdNSs0O3iV+o7gCEcwNHm9zlNF8SNR2XAsWRNZN/ne6uuB+wwqEW1/wc8kVdTwCiIL
	OMQ4cjZgugddOVcV1yN+kkkn/oz8fBx8uEHnTk/OHyDH1/edac3XV1qzzcSs8j/qfZ9VIvmRCeOJw
	BtE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxRUr-0002aD-8M;
	Fri, 21 Aug 2026 15:49:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxRUq-0002a4-4e
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6W2BbfGoD8OxPHzegIRjhrWgq3yKKgNSEHocGbb+PSc=; b=RS+sK1re2GKhmPyNrUmtUoh6Em
 TWmENU13HmoYIkaKsVow/TYlhBaAXldXhcQ/W4Yl2RJBaLlYpzqUK04EE3JuaSSqmg/aEv33RMIA4
 uJ0i2+MOd6SRomIEXWABAZbjWd5s3g728RroogOjUi6iD1O1aairP/Xku5bzYKlZO/1Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6W2BbfGoD8OxPHzegIRjhrWgq3yKKgNSEHocGbb+PSc=; b=g
 hwYfEfQ3EfKaEa6lVfj+gqOLw74FFOA63pGk35OQ3CNOhYzOMpAkXcR44z+nZ/rl641LKDMhTPDdT
 AHB93fBL8J/j72IE2FD0ZNKoOoPyCirD5neXdBMwSFjVrFedg0Bt5p7Nz2+BMs9BhuApD8mqjzhdw
 BZjrjzM7AH56d4QA=;
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxRUp-0005cZ-70 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:32 +0000
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c1677c91969so142519166b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787327365; x=1787932165; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6W2BbfGoD8OxPHzegIRjhrWgq3yKKgNSEHocGbb+PSc=;
 b=Uqs0vnizLNfU4wfJa3CgYpxiDjrLbgcCybUD8C4vEpQvULTma7WsVpc2M88qqeIYd6
 7SVlvmE7KHvz5VxOSEOYTvdOyzpjbvLiXw+OVX9ISakQwXjMSt2EhKCynaFlk0TbZWAp
 QnQ42tB0KnHJHQZu/PzjbqFyDt3vpX46aPjSC1xsfaCSmV0gznye2J1Xi/kizHJsJyoH
 RSciuXWCND6EWhMTyP/+5Ib+QvtV37f4NsuBIiPKuLaXKHVW9dmoHfzvgaP8AIFni98u
 KErNpW6O1MjxZ0pjySwVJTEcTrkjnneePhdGSXZemlTI9RwUEBOB1zceWc3pUrQCw1xI
 R/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787327365; x=1787932165;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6W2BbfGoD8OxPHzegIRjhrWgq3yKKgNSEHocGbb+PSc=;
 b=p779CMxz0rbxFIKWvllxdWIGePhSCTE/8hiyatzSSGm4n7NfgvSyzifaN9Q7yfPTpU
 +OlgdakDqhdVtokVyyD6hEG38QcZbQatx3EJeZxuh+eU7jkopEExpI43mzWkRSufS8xi
 TYWql22z6z6hzxkwaFBDe//+NdQsM3MrOP2WuE7IZROc7qzAuzKcYTLKXO/PJUhV9dr+
 Z9VHBTuymWYaQJtpVlNTBaPbhSUwU/QseVpYQdFkvYaABcbKllL5EGjP0Z8HLa+TheoA
 liLJ67+0VRWf8DciB/dB3YgQ8p+r5AAi5sr0WrNltChz7KOZlyTKujuUGDeSC3Eq40ax
 DlHQ==
X-Gm-Message-State: AFuF++nzKrr9I7vgbrgCxwMyuS3vHpDGS8IRphhJg+Z+oJ7305WWf9kx
 rf/r+Aaq3PO7XCf9DNdS5lDssCCxnVLU+icEhEaUX6k9G6SGpTfx2lzrJwkV2TvxGRngJIsQumv
 GJNAJJPsaHywAL3MGFVnNcSd3CLlZCLrQ+sSSmtfTXglU/CegWXqf5WJp6mXLVH/S+dTC6SGus4
 tHZlZdXQ==
X-Gm-Gg: AR+sD13R4sQ0ZCXjyjirINdJzCZenTSijqY8wJDDdEk1Xt1HCcgbmwpmGw/pLQQHLy6
 Um5M6tae8lZhzy1bB18HoYctkjI/zANU88e2PD+ku5kivUooEjOYAvKeR5FSEuOEmiVGIm5l/Dh
 7P3Wiml3GhGB/SMEaFvq9XNZLX4Ssb+9UqNWlGF9koyBTeLd4e331L7DZrtaApXgKvfgRdfa0tm
 VUsTjGh+JczHocoQa+7xLWqikcBcL+mcRmpaGki5wAieo7FtX8ImV89WCgwx9hmfYxf2d7pg5DW
 hiS7BkDQ6wkBjm9NIWCE5VipsmRG2IoLPmCbIfpiCD+QpLPhUK2u5cstY9uFK9e0ABq9IGaZJ+Y
 wvedNaBnacFb9TOBeTxOWhpWFbGmdqtrF3E1/uPWWXqgz7FDa0RojQ3Jwjh7gZWgSxECyY+64VJ
 4bRcnVSSocidjyZoq42PGm37veXhoyM6khlST7xBNmZfyB7C3epNRxlyZ/XVOwCtn0G2ZHVjycR
 o1x24AGpqgPaq6jC/ujFa6iEw0/T7dOb3psuJthX/NlYAThdtmb8eiyECQEANH2b4RD1jzm9870
 BDHitHputWKDiX40rihUsKkfL60kZKc71wF4kxdgCCy79JvtFhg=
X-Received: by 2002:a17:907:d1e:b0:c24:7f65:9c8a with SMTP id
 a640c23a62f3a-c247f659d8amr424567166b.12.1787327364460; 
 Fri, 21 Aug 2026 08:49:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff177b1esm7385228a12.29.2026.08.21.08.49.23
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:49:23 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 15:49:23 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: 9c7c07333c1533dcb421b70cf5569b4eb4bfcfe3
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c11e769e671d4c7d9454298d259f24a9601ce2e1-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxRUp-0005cZ-70
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 get_key_by_management_key_id helper function
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5310385999298795510=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5310385999298795510==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kAs1UPe8Nyw="; charset=UTF-8

--kAs1UPe8Nyw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1856?usp=3Demail )


Change subject: Introduce get_key_b=
y_management_key_id helper function
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Introduce get_key_by_management_key_id helper functi=
on

This function allows us to map from a management key id to a key struct=
ure
and also allows this function to be reused=2E

Patch v2: add message wh=
en key is not found=2E
Patch v3: only consider valid keys

Change-Id: I42d8=
785959c24bf688190965e58b9b98251b8557
Signed-off-by: Arne Schwabe <arne@rfc2=
549=2Eorg>
---
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl_verify=2Ec
2 =
files changed, 33 insertions(+), 10 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/1856/1

diff --git a/src/ope=
nvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index f6392f9=2E=2Edb61198=
 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@=
@ -759,4 +759,24 @@
     return &multi->session[TM_ACTIVE]=2Ekey[KS_PRIMARY=
];
 }
 
+#ifdef ENABLE_MANAGEMENT
+/**
+ * Gets the \c key_state  object th=
at belong to the management key id or
+ * return NULL if not found=2E
+ */
=
+static inline struct key_state *
+get_key_by_management_key_id(struct tls_=
multi *multi, unsigned int mda_key_id)
+{
+    for (int i =3D 0; i < KEY_SC=
AN_SIZE; ++i)
+    {
+        struct key_state *ks =3D get_key_scan(multi, =
i);
+        if (ks->mda_key_id =3D=3D mda_key_id && ks->state > S_UNDEF)
+=
        {
+            return ks;
+        }
+    }
+    return NULL;
+}
+#=
endif
+
 #endif /* SSL_COMMON_H_ */
diff --git a/src/openvpn/ssl_verify=2Ec=
 b/src/openvpn/ssl_verify=2Ec
index 162f68f=2E=2Efae3279 100644
--- a/src/o=
penvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1249,22 +1249,25=
 @@
 tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_k=
ey_id, const bool auth,
                      const char *client_reason)
 {=

-    bool ret =3D false;
+    struct key_state *ks =3D NULL;
     if (mult=
i)
     {
-        int i;
+
         auth_set_client_reason(multi, client_r=
eason);
-        for (i =3D 0; i < KEY_SCAN_SIZE; ++i)
+        ks =3D get_=
key_by_management_key_id(multi, mda_key_id);
+
+        if (ks)
         {
=
-            struct key_state *ks =3D get_key_scan(multi, i);
-            =
if (ks->mda_key_id =3D=3D mda_key_id)
-            {
-                ks->m=
da_status =3D auth ? ACF_SUCCEEDED : ACF_FAILED;
-                ret =3D t=
rue;
-            }
+            ks->mda_status =3D auth ? ACF_SUCCEEDED : =
ACF_FAILED;
         }
+        else
+        {
+            msg(D_TLS_DEBU=
G_LOW, "%s: no key state found for management key id "
+                "%d=
", __func__, mda_key_id);
+        }
+
     }
-    return ret;
+    return =
(bool) ks;
 }
 #endif /* ifdef ENABLE_MANAGEMENT */
 

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b855=
7
Gerrit-Change-Number: 1856
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--kAs1UPe8Nyw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Introduce get_key_by_management_key_id helper function<br><br>This=
 function allows us to map from a management key id to a key structure<br>a=
nd also allows this function to be reused=2E<br><br>Patch v2: add message w=
hen key is not found=2E<br>Patch v3: only consider valid keys<br><br>Change=
-Id: I42d8785959c24bf688190965e58b9b98251b8557<br>Signed-off-by: Arne Schwa=
be &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/ssl_common=2Eh<br>M s=
rc/openvpn/ssl_verify=2Ec<br>2 files changed, 33 insertions(+), 10 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/56/1856/1</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_common=
=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index f6392f9=2E=2Edb6119=
8 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+=
++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -759,4 +759,24 @@</span>=
<br><span>     return &amp;multi-&gt;session[TM_ACTIVE]=2Ekey[KS_PRIMARY];<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Gets the \c key_state  object that belong to the management key id=
 or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * return NULL i=
f not found=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline struct =
key_state *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_key_=
by_management_key_id(struct tls_multi *multi, unsigned int mda_key_id)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; KEY_SCAN_SIZ=
E; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct key_state *=
ks =3D get_key_scan(multi, i);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (ks-&gt;mda_key_id =3D=3D mda_key_id &amp;&amp; ks-&g=
t;state &gt; S_UNDEF)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    return ks;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> #endif /* SSL_COMMON_H_ */</span><br><span>di=
ff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><b=
r><span>index 162f68f=2E=2Efae3279 100644</span><br><span>--- a/src/openvpn=
/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br>=
<span>@@ -1249,22 +1249,25 @@</span><br><span> tls_authenticate_key(struct =
tls_multi *multi, const unsigned int mda_key_id, const bool auth,</span><br=
><span>                      const char *client_reason)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key_sta=
te *ks =3D NULL;</span><br><span>     if (multi)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         auth=
_set_client_reason(multi, client_reason);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        for (i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        ks =3D get_key_by_=
management_key_id(multi, mda_key_id);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (ks)</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            struct key_state *ks =3D get_key_scan(multi=
, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (=
ks-&gt;mda_key_id =3D=3D mda_key_id)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                ks-&gt;mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAI=
LED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                r=
et =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ks-=
&gt;mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAILED;</span><br><span>     =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_DEBUG_LOW=
, &quot;%s: no key state found for management key id &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                &quot;%d&quot;, __f=
unc__, mda_key_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (=
bool) ks;</span><br><span> }</span><br><span> #endif /* ifdef ENABLE_MANAGE=
MENT */</span><br><span> </span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail">ch=
ange 1856</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I42d8785959c24bf688190965e58b9b98251b8557 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1856 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--kAs1UPe8Nyw=--


--===============5310385999298795510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5310385999298795510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5310385999298795510==--

