Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C2AC43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 22:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=hOg3B+nyd4ndX3aV3peVYfb0BbcyvWkOPp1Tp1Bz4W8=; b=ltzZ4oEb9//rXo
	vu14460Tr6ufiA53hBUML8j/pguTl0UQFQue5OWA6et0Ae6RWAcy3amIS1MB4bVJSSknkyd8nd9pA
	hyOP5Jgnj7D+p5p/6kY6sfjxetpzpGDrNc6I01h/v5kP1PhIMKoYDjvg4wYIcm+a0vJJ1Mwtt9P7G
	aw4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjlRo-0003Za-NF;
	Tue, 14 Jul 2026 22:17:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjlRn-0003ZS-4B
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:17:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZSemW4y/BzZDXp+0LIgBRb2Ex/e6+eoypM5EKB4y2QY=; b=E2d/uTbGEc4YwgYCT/DfChNfk6
 BcU2nksQgQ6PXKhdoHzlHY1eZ1JTPAZYtV8W0zg0df+uH4BquUjo1mc6116Sm4tmbwIJ4dJcQP6dz
 zQLsBxZOh8Sy9eYYhET1eELU/5AqedPt2sfS5RACSMqgxozDf9sdW191/CaNS8WjwuwQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZSemW4y/BzZDXp+0LIgBRb2Ex/e6+eoypM5EKB4y2QY=; b=T
 DeYmv+u5bfgnnYhFeZVr488eJX1KEJlTutODlZcoUGf4hrmkHg0f6XVQrffSU/BQcpBhzo/JIgd6G
 yFGZ18zHhFGDZ8S0wcyonk7qP2K4uk1yJuNRi126FrRdsBgwDb0h3yES+VDl2uwJqXFjRJK4VcIt3
 pOLMGosSgBCElP0Y=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjlRj-0002e7-4u for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:17:48 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493ece78b0cso34552695e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 15:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784067455; x=1784672255; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZSemW4y/BzZDXp+0LIgBRb2Ex/e6+eoypM5EKB4y2QY=;
 b=UcV7bg/JGtOuhkO5l4Rple6TBmun9oh93CxO1Lo6cPr5VbdLMcgMWd45TSxyDYWWiP
 zCDnEpJm9bTvezKDT3dmDsAJM1qGyjGvwZBrxUS3vS+rANPi+rwJr3Sbj2kB8BRo5WnA
 6w4VxVRzvNktKS3dc6WlOZ6vZPQLZROdh0OhA7VlI8PLasUynJdJwwAva1A92m787Sbg
 peqlLQAsBB2crrtRyKuOPSwBUJMUGvJFMoLm/Q+Q4BexO1rAjDIP/9YZrPh3/4FCXCNC
 Af8Sy8nkTXdMqA3Q2ucFXylmsbQRd6Fl7+Nq6zfIEDqPSaRq8T77VGnJ6/OgoDiWKvvU
 ktDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784067455; x=1784672255;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZSemW4y/BzZDXp+0LIgBRb2Ex/e6+eoypM5EKB4y2QY=;
 b=tND1dTjwH6HzReKrnHuVzxBH9i7fPs6vg75Ho9E1mv/QYTI7q1pYcBTBcZwYJU9Hw8
 cW0EzRxR6Ztn1y/kB9Zm8Nae6k8DC3z20V+udu4O2nMLWhZH12xtvKXBgEedPh2a3knj
 e4yDPYArBy3uYCTGbQ2i1Bt3Iig5rMiptXmr/VgEQDftU5b5+uHRruBcZ8EzhRqWc8X7
 aZg+rtbT+B5fbcrjzLV+tBA5G/ywRJVpC419cnuR19SFndCWAqe63p0+DAr/qPJPiPkt
 fFJ3m8XR1DyZ7q+LtsGL1lI5+r6zK7TDokb4TS+YWocyjZm/yM6LIvLwuYoih80+bSEB
 stQQ==
X-Gm-Message-State: AOJu0YxVxGoNG7CGj5yzfgetqQSg9mCJ234X6m3mnDz2DLr3K7dHKpn8
 g8tL/KtXZw+RbNcUEQ1ZhPuzuVBLyjNocqx/DnjzrPoNjeNhwt2inl/ujqMflU+m0cwSRyVNbod
 c7Fjb4oYwDTF9MTUm4xa+O7zmyS2nXlIJNXqYZOztDmJ6I05DwGA3GeN21q1RgiZoh6azl2rqo5
 WAzXv5ZA==
X-Gm-Gg: AfdE7cneIYawB0ZwwuTALkFirlx0SMCtIOJvp/e6ZPWWflBqqfvkWIgX3QgfL58JnfY
 Ethu6KjjLVyVghSrwJOMnrIDIIF5OwIpCozHNj78uNBA8Ns5nBJG7hTqaZtGTQyTEHTow17nYMt
 GTwqgPCYMhXMtqFtk/FZ5zfYuq1V59HHJaudVxF2I4x5TwwcG4eY5/wjDuX0zr4Agc5Tkx1N2C6
 JaXiPzMSy0Qgl74BzFIziMjkEFBFOprqKmljGokXF8uAYyYhiM10EcMikcj2+aRXld2yOkD/Dl9
 qwiYimstUgjNZavQRmHbR5RFCNVsYKbr6hnvQhpm+rpkhNgIS3CBLjJ6sJD7wRxQ/HKYkXcQ8mi
 9Bq5t6pVzKJrFxvp8EKBY6MuYEfma6lJrid88l4IxLHyPVtoU82bul+ATCaI2ySXvxb1EvEiWV8
 E/+dbEaidKZKcTQ5WrxWEn6VWhw966Uv3d+R6MbNUiwWWM2Bsj5bbvPcGDX37wK+Ir4ybr0psdT
 PEakzvPe/trGFXFJNrpUtJX4XqjOSVXCtDiL3u9/UHwVhoRGj0+4bQym9A5Ef1JMX1m3BFGiVVe
 iOE=
X-Received: by 2002:a05:600c:699a:b0:493:adcb:d368 with SMTP id
 5b1f17b1804b1-49538f919a0mr43417485e9.9.1784067455408; 
 Tue, 14 Jul 2026 15:17:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953c710facsm4593455e9.2.2026.07.14.15.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:17:35 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 22:17:34 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I087cbccc9b4a994376aa2d2409509a2307068899
X-Gerrit-Change-Number: 1784
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1784?usp=email>
X-Gerrit-Commit: b1f527a649f3c51e32d41e89fe16f2aa0715ba1a
References: <gerrit.1784067448000.I087cbccc9b4a994376aa2d2409509a2307068899@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkkwODdjYmNjYzliNGE5OTQzNzZhYTJkMjQwOTUwOWEyMzA3MDY4ODk5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <04ec0c514b5a7fa69e82c941cbf54578e949e320-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjlRj-0002e7-4u
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options_util: move
 subnet_pool_by_tag out of multi.c
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3044945854356785149=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3044945854356785149==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jwd/0GXOBqU="; charset=UTF-8

--Jwd/0GXOBqU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1784?usp=3Demail

to review the following change=2E


Chang=
e subject: options_util: move subnet_pool_by_tag out of multi=2Ec
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options_util: move sub=
net_pool_by_tag out of multi=2Ec

It is a pure lookup over the --subnet-poo=
l list; relocating it to
options_util=2Ec (and taking the list head directl=
y) lets it be unit
tested without multi=2Ec's dependencies=2E No functional=
 change=2E

Change-Id: I087cbccc9b4a994376aa2d2409509a2307068899
GitHub: cl=
oses openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli <antonio@mandelbi=
t=2Ecom>
---
M src/openvpn/multi=2Ec
M src/openvpn/options_util=2Ec
M src/o=
penvpn/options_util=2Eh
3 files changed, 27 insertions(+), 16 deletions(-)
=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/84/17=
84/1

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 84f2=
5b3=2E=2Eda46cf4 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=
=2Ec
@@ -42,6 +42,7 @@
 #include "vlan=2Eh"
 #include "auth_token=2Eh"
 #in=
clude "route=2Eh"
+#include "options_util=2Eh"
 #include <inttypes=2Eh>
 #i=
nclude <string=2Eh>
 
@@ -1419,19 +1420,6 @@
     }
 }
 
-static const stru=
ct subnet_pool_def *
-subnet_pool_by_tag(const struct options *o, const cha=
r *tag)
-{
-    for (const struct subnet_pool_def *d =3D o->subnet_pools; d=
; d =3D d->next)
-    {
-        if (!strcmp(d->tag, tag))
-        {
-    =
        return d;
-        }
-    }
-    return NULL;
-}
-
 /*
  * Return t=
he dynamic pool serving the clients tagged with <tag>, creating it
  * on f=
irst use from the matching --subnet-pool definition=2E
@@ -1449,7 +1437,7 @=
@
         }
     }
 
-    const struct subnet_pool_def *d4 =3D subnet_pool=
_by_tag(&m->top=2Eoptions, tag);
+    const struct subnet_pool_def *d4 =3D =
subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, tag);
     ALLOC_OBJ_CL=
EAR(sp, struct subnet_pool);
     sp->tag =3D d4->tag;
     sp->pool =3D if=
config_pool_init(true, IFCONFIG_POOL_INDIV, d4->network + 2,
@@ -1475,7 +14=
63,7 @@
     if (mi->context=2Eoptions=2Esubnet_pool_tag && !mi->context=2E=
options=2Esubnet_pool_defined)
     {
         const struct subnet_pool_def=
 *d =3D
-            subnet_pool_by_tag(&m->top=2Eoptions, mi->context=2Eop=
tions=2Esubnet_pool_tag);
+            subnet_pool_by_tag(m->top=2Eoptions=
=2Esubnet_pools, mi->context=2Eoptions=2Esubnet_pool_tag);
         if (d)
=
         {
             mi->context=2Eoptions=2Esubnet_pool_defined =3D tru=
e;
@@ -2864,7 +2852,7 @@
     }
 
     if (mi->context=2Eoptions=2Esubnet_p=
ool_tag
-        && !subnet_pool_by_tag(&m->top=2Eoptions, mi->context=2Eop=
tions=2Esubnet_pool_tag))
+        && !subnet_pool_by_tag(m->top=2Eoptions=
=2Esubnet_pools, mi->context=2Eoptions=2Esubnet_pool_tag))
     {
         =
msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to unknown --subne=
t-pool-tag '%s'",
             mi->context=2Eoptions=2Esubnet_pool_tag);
di=
ff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec
inde=
x 47fe0bc=2E=2Eba04917 100644
--- a/src/openvpn/options_util=2Ec
+++ b/src/=
openvpn/options_util=2Ec
@@ -31,6 +31,19 @@
 
 #include "push=2Eh"
 
+const=
 struct subnet_pool_def *
+subnet_pool_by_tag(const struct subnet_pool_def =
*pools, const char *tag)
+{
+    for (const struct subnet_pool_def *d =3D p=
ools; d; d =3D d->next)
+    {
+        if (!strcmp(d->tag, tag))
+        =
{
+            return d;
+        }
+    }
+    return NULL;
+}
+
 const ch=
ar *
 parse_auth_failed_temp(struct options *o, const char *reason)
 {
diff=
 --git a/src/openvpn/options_util=2Eh b/src/openvpn/options_util=2Eh
index =
1d4ea9b=2E=2Ec54357c 100644
--- a/src/openvpn/options_util=2Eh
+++ b/src/op=
envpn/options_util=2Eh
@@ -28,6 +28,16 @@
 
 const char *parse_auth_failed_=
temp(struct options *o, const char *reason);
 
+/**
+ * Look up a named --s=
ubnet-pool in a list of pool definitions=2E
+ *
+ * @param pools  head of t=
he --subnet-pool list (may be NULL)
+ * @param tag    the --subnet-pool-tag=
 to match
+ * @return       the matching pool definition, or NULL if none m=
atches
+ */
+const struct subnet_pool_def *subnet_pool_by_tag(const struct =
subnet_pool_def *pools,
+                                                 c=
onst char *tag);
+
 
 /** Checks if the string is a valid integer by checki=
ng if it can be
  *  converted to an integer */

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1784?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I087cbccc9b4a994376aa2d2409509a2307068899
Gerr=
it-Change-Number: 1784
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mand=
elbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Jwd/0GXOBqU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1784?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">op=
tions_util: move subnet_pool_by_tag out of multi=2Ec<br><br>It is a pure lo=
okup over the --subnet-pool list; relocating it to<br>options_util=2Ec (and=
 taking the list head directly) lets it be unit<br>tested without multi=2Ec=
&#39;s dependencies=2E No functional change=2E<br><br>Change-Id: I087cbccc9=
b4a994376aa2d2409509a2307068899<br>GitHub: closes openvpn/OpenVPN#987<br>Si=
gned-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M =
src/openvpn/multi=2Ec<br>M src/openvpn/options_util=2Ec<br>M src/openvpn/op=
tions_util=2Eh<br>3 files changed, 27 insertions(+), 16 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/84/1784/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openv=
pn/multi=2Ec</span><br><span>index 84f25b3=2E=2Eda46cf4 100644</span><br><s=
pan>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec=
</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;vlan=2Eh=
&quot;</span><br><span> #include &quot;auth_token=2Eh&quot;</span><br><span=
> #include &quot;route=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br><span> #includ=
e &lt;inttypes=2Eh&gt;</span><br><span> #include &lt;string=2Eh&gt;</span><=
br><span> </span><br><span>@@ -1419,19 +1420,6 @@</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static const struct subnet_pool_def *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-subnet_pool_by_tag(const struct options *o, co=
nst char *tag)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (const struct subne=
t_pool_def *d =3D o-&gt;subnet_pools; d; d =3D d-&gt;next)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (!strcmp(d-&gt;tag, tag))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            return d;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><b=
r><span>  * Return the dynamic pool serving the clients tagged with &lt;tag=
&gt;, creating it</span><br><span>  * on first use from the matching --subn=
et-pool definition=2E</span><br><span>@@ -1449,7 +1437,7 @@</span><br><span=
>         }</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const struct subnet_pool_def *d4 =3D su=
bnet_pool_by_tag(&amp;m-&gt;top=2Eoptions, tag);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const struct subnet_pool_def *d4 =3D subne=
t_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, tag);</span><br><span>   =
  ALLOC_OBJ_CLEAR(sp, struct subnet_pool);</span><br><span>     sp-&gt;tag =
=3D d4-&gt;tag;</span><br><span>     sp-&gt;pool =3D ifconfig_pool_init(tru=
e, IFCONFIG_POOL_INDIV, d4-&gt;network + 2,</span><br><span>@@ -1475,7 +146=
3,7 @@</span><br><span>     if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag =
&amp;&amp; !mi-&gt;context=2Eoptions=2Esubnet_pool_defined)</span><br><span=
>     {</span><br><span>         const struct subnet_pool_def *d =3D</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            subnet_pool_by_t=
ag(&amp;m-&gt;top=2Eoptions, mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            subnet_po=
ol_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eoptions=2Esu=
bnet_pool_tag);</span><br><span>         if (d)</span><br><span>         {<=
/span><br><span>             mi-&gt;context=2Eoptions=2Esubnet_pool_defined=
 =3D true;</span><br><span>@@ -2864,7 +2852,7 @@</span><br><span>     }</sp=
an><br><span> </span><br><span>     if (mi-&gt;context=2Eoptions=2Esubnet_p=
ool_tag</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&=
amp; !subnet_pool_by_tag(&amp;m-&gt;top=2Eoptions, mi-&gt;context=2Eoptions=
=2Esubnet_pool_tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        &amp;&amp; !subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools,=
 mi-&gt;context=2Eoptions=2Esubnet_pool_tag))</span><br><span>     {</span>=
<br><span>         msg(D_MULTI_ERRORS, &quot;MULTI: client has been rejecte=
d due to unknown --subnet-pool-tag &#39;%s&#39;&quot;,</span><br><span>    =
         mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span>diff =
--git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec</span><=
br><span>index 47fe0bc=2E=2Eba04917 100644</span><br><span>--- a/src/openvp=
n/options_util=2Ec</span><br><span>+++ b/src/openvpn/options_util=2Ec</span=
><br><span>@@ -31,6 +31,19 @@</span><br><span> </span><br><span> #include &=
quot;push=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+const struct subnet_pool_def *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+subnet_pool_by_tag(const struct subnet_pool_de=
f *pools, const char *tag)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (co=
nst struct subnet_pool_def *d =3D pools; d; d =3D d-&gt;next)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (!strcmp(d-&gt;tag, tag))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            return d;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> const char *</span><br><span> parse_auth_failed_temp(struct optio=
ns *o, const char *reason)</span><br><span> {</span><br><span>diff --git a/=
src/openvpn/options_util=2Eh b/src/openvpn/options_util=2Eh</span><br><span=
>index 1d4ea9b=2E=2Ec54357c 100644</span><br><span>--- a/src/openvpn/option=
s_util=2Eh</span><br><span>+++ b/src/openvpn/options_util=2Eh</span><br><sp=
an>@@ -28,6 +28,16 @@</span><br><span> </span><br><span> const char *parse_=
auth_failed_temp(struct options *o, const char *reason);</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Look up a named --subnet-pool in =
a list of pool definitions=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am pools  head of the --subnet-pool list (may be NULL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param tag    the --subnet-pool-tag t=
o match</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return  =
     the matching pool definition, or NULL if none matches</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+const struct subnet_pool_def *subnet_pool_by_tag(con=
st struct subnet_pool_def *pools,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                                 const char *=
tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> </span><br><span> /** Checks if the string is a valid integer by checki=
ng if it can be</span><br><span>  *  converted to an integer */</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1784?usp=3Demail">change 1784</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1784?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I087cbccc9b4a994376aa2d24095=
09a2307068899 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 178=
4 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--Jwd/0GXOBqU=--


--===============3044945854356785149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3044945854356785149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3044945854356785149==--

