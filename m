Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADDBC44501
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZTGmeqPcV1yHXB+5hIPMPuLc7KZEETqMJtIafJeovTE=; b=ejjtiw2+5YxCEHtQj3xaY2fkZ4
	iTyoC1HAqvkQMmVU8bQ44mgLEBGHWoj62ADdj9is6iQy97y6UhRjBHLEjeJVZrr4hZMaNa4/b069W
	/q+m9h1+k6bIqY7V6TDkT7fNjftrBc9NwRR5m7AOzM1ZuG/MCIQ56TWmaF4v2mT/Bp/c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjaju-0001SG-0i;
	Tue, 14 Jul 2026 10:51:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjajr-0001S2-Nt
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 10:51:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4GoQBpmrS76nulwaczQchIN5AkKEYF+ITfQpkPaS22A=; b=DzDpzUPHpmKSNoxLBu8tXunEV+
 u3K+4nf1HBd8v2KzCKt/D8c4bUZkBHcAuCKnH4PXiy/cS8hW8TKrPTnMm01+mT0YJn49SzYYZAvBd
 0Fhx6nhKgB/Xdq+44NsjdESHAxBWfpvmWZWahId58vW2Sd9bq0mXXUOPfKsavuW/2AB0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4GoQBpmrS76nulwaczQchIN5AkKEYF+ITfQpkPaS22A=; b=e
 IO5xFlmkY6ZpehMDjkbuN6jKJwvsjEDc86WdU/iFYvsG1T2P9KPCgOCqGG30qIr4rFuz8sMC6a/dd
 GgWjR2yjz9Xxf/ha3/rsoEiBaLmmHAaJBy7fcnKymGpKSgd5qUTMLpeBQJATVi7gAh3d6ozwD/6pQ
 nK8P2QpgkSAlIBzc=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjaje-0001ZX-El for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 10:51:36 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so3665798f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 03:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784026288; x=1784631088; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4GoQBpmrS76nulwaczQchIN5AkKEYF+ITfQpkPaS22A=;
 b=Tz3m7NKeU674NjcT5rBeHrgA/KGUGrNMBp8QmiH71SbcE0RKlmHiuoqzy8/PQSYi1D
 gMTEcZo6SIm6n22cYY6ASXZz6wFrhFcci2KngM1N13izLmh5upVF18tCvDt/COkWuw+S
 oPN0kJq+Z5f3zJJSm+5/1Uv6CMDloColOa7/qUanfxXKjQ+Iu7xes8vHuSitKa8lFLJB
 WzA1HP8T2FUVw/IpxXCZbG3pWA3VIzvbflZeBwyBLyQ6Pkngii4Iupy9e9YsUBQDp+g6
 K6usMltzeVHrvDxHVY9cn2kdk4atT9rdEJeEy9NN4uJoNMbLMPLsCFheEalpUalgg5zi
 AqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784026288; x=1784631088;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4GoQBpmrS76nulwaczQchIN5AkKEYF+ITfQpkPaS22A=;
 b=op5+VshGhMDMxbEAtb4gHFBDlUj4NbK7jBMUbDCvJNt3HHAudbpb9Kv5kZtipiKRPO
 qXlJ9BGNR6YgCAqKUvomV9opntGhhifEHyg6WujblAhJJpuP3625ICVvA/2qBF7QcCeT
 OW+v4uWUuGZ48GNJ6OBAYOxgSOZZJGB6Njb5sazRTMQ450PW/PElhFgNM98oCX2RGZ1d
 wroWd69qKDKDfZ2z44HmqrBBYrBDaRdKN8QCJJiaMXQlY3NyNT2mELfPjOI9qu+LihK3
 7uRFd+ttfl1JLPDKSAhscM/uFrmZJJ6+EsqG9vmCGzXg7uojBj+k+ZRTRO6XhQeBsxB2
 o17A==
X-Gm-Message-State: AOJu0YzMR4CyoJBSQ2EJmlqlCELVWNYyboq3ZAtCNMb8p6tSowaKUxoY
 o1MDZHVKl5XkTqVX++ejVWNWLlZiFQYgA1ZE54RGn2Bi+bUtI1mt3OR1AYyi0raceOcESf0KPkW
 r2kzFR70L5C4wwym1rj338eaVK7LhGoafgTnHeOqYsWlDPpVyea1okJmaW7+FtclY0FfL
X-Gm-Gg: AfdE7cnXKS5oYcx2b22qTBmNVnD7YDurt6j4P5COMBirU6EO92DFxmmFtqvoOvAzEvi
 UU3xAS4oJcAf66zZd0sMS0p/AAgOlpo7ZiX6GgsCaOsCbYsOp3JsH7VjN1AoVu/LzS96Xt1UdZC
 cjXYxgBmASX7FwoXcnC4J5C2Tnsal/zMcUdJMRTvODi4V2+/4lH9oKXJjziGUVQZu4Wr5EMYm9X
 Es7JS/gAKCnbLh+e+ywQp4HorIulZnKdxoHjETtsAW3m3euxYRri7b1H6imf351WSnmXQRhV5lR
 m0IzSRPzHxJAr0GVYd/Xq0MQhkZsIN9YAAZNa5qDnHnfoU1h0LWKya6uk7pz/r64GOeWAhWT5eh
 Uw2s4dc+4qguL3TXueJ0tI956pscJ0UP1oqxqqp80eeR2n4hOnDTS6yJFMGVmouKhAqNjumj8Z/
 TccnnhcQXWt7hzmmSLVJYQ8dOpcBIyLXtV0W+j2WvVfG1Wtu94zUS5TPDXa/6GJbA5HdKV9wpLm
 J7iahGXCXKXeN+5v6BZJkWkb79r+XVT0JomTxXbkov2wBo875ZW5Fgt/kP/SRzXV8YXlPSYJGa2
 Hbw=
X-Received: by 2002:a05:6000:4915:b0:47d:e3b3:ff6d with SMTP id
 ffacd0b85a97d-47f2dd08a84mr14126520f8f.57.1784026287743; 
 Tue, 14 Jul 2026 03:51:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c1f84sm7400793f8f.29.2026.07.14.03.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:51:26 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 10:51:24 +0000
To: stipa <lstipakov@gmail.com>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
X-Gerrit-Change-Number: 1740
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1740?usp=email>
X-Gerrit-Commit: e8d39061007b0a29f78cecce72a0269d6dd3ecde
In-Reply-To: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNjc3ZjQzZmMzZWIwMDUyZjhlODBkOWE3ZjA5OGQzNGFkMDNkZmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <45ee9974c7e8cfdee5b1f965cffa8cf19d9b74cf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjaje-0001ZX-El
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Add
 buf_read_u64() and buf_write_u64()
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5580181551419827520=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5580181551419827520==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="itJv2YcY4xM="; charset=UTF-8

--itJv2YcY4xM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by flic=
htenheld


Change subject: buffer: Add buf_read_u64() and buf_write_u64()
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Add b=
uf_read_u64() and buf_write_u64()

Add 64-bit big-endian buffer accessors a=
longside the existing 8/16/32-bit
helpers, using htonll()/ntohll() for the =
byte-order conversion=2E

buf_read_u64() reports success via a bool out-par=
ameter, mirroring
buf_read_u32()=2E

Change-Id: Ic677f43fc3eb0052f8e80d9a7f=
098d34ad03dfe1
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1740
Message-Id: <20260714092552=2E18685-1-gert@green=
ie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg37578=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/buffer=2Eh
1 file changed, 32 insertions(+),=
 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/40/1740/4

diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buff=
er=2Eh
index fcc923b=2E=2E1db9367 100644
--- a/src/openvpn/buffer=2Eh
+++ b=
/src/openvpn/buffer=2Eh
@@ -25,6 +25,7 @@
 
 #include "basic=2Eh"
 #include=
 "error=2Eh"
+#include "integer=2Eh"
 
 #define BUF_SIZE_MAX 1000000
 
@@ -=
702,6 +703,13 @@
 }
 
 static inline bool
+buf_write_u64(struct buffer *des=
t, uint64_t data)
+{
+    uint64_t u64 =3D htonll(data);
+    return buf_wr=
ite(dest, &u64, sizeof(uint64_t));
+}
+
+static inline bool
 buf_copy(struc=
t buffer *dest, const struct buffer *src)
 {
     return buf_write(dest, BP=
TR(src), BLENZ(src));
@@ -827,6 +835,30 @@
     }
 }
 
+/* Read a 64-bit bi=
g-endian value (see buf_write_u64())=2E Sets *good to indicate
+ * success,=
 like buf_read_u32()=2E */
+static inline uint64_t
+buf_read_u64(struct buf=
fer *buf, bool *good)
+{
+    uint64_t ret;
+    if (!buf_read(buf, &ret, s=
izeof(uint64_t)))
+    {
+        if (good)
+        {
+            *good =
=3D false;
+        }
+        return 0;
+    }
+    else
+    {
+        i=
f (good)
+        {
+            *good =3D true;
+        }
+        return=
 ntohll(ret);
+    }
+}
+
 /** Return true if buffer contents are equal */
=
 static inline bool
 buf_equal(const struct buffer *a, const struct buffer =
*b)

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic677f43fc3e=
b0052f8e80d9a7f098d34ad03dfe1
Gerrit-Change-Number: 1740
Gerrit-PatchSet: 4=

Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: cron2 <gert@g=
reenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>

--itJv2YcY4xM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by stipa=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">buffer: Add buf_read_u64()=
 and buf_write_u64()<br><br>Add 64-bit big-endian buffer accessors alongsid=
e the existing 8/16/32-bit<br>helpers, using htonll()/ntohll() for the byte=
-order conversion=2E<br><br>buf_read_u64() reports success via a bool out-p=
arameter, mirroring<br>buf_read_u32()=2E<br><br>Change-Id: Ic677f43fc3eb005=
2f8e80d9a7f098d34ad03dfe1<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2E=
net&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740<br>Message-Id: &=
lt;20260714092552=2E18685-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37578=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/buffer=2Eh<br>1 file changed, 32 insertions(+), 0 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/40/1740/4</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Eh b=
/src/openvpn/buffer=2Eh</span><br><span>index fcc923b=2E=2E1db9367 100644</=
span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openv=
pn/buffer=2Eh</span><br><span>@@ -25,6 +25,7 @@</span><br><span> </span><br=
><span> #include &quot;basic=2Eh&quot;</span><br><span> #include &quot;erro=
r=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;integer=2Eh&quot;</span><br><span> </span><br><span> #define BUF_SIZ=
E_MAX 1000000</span><br><span> </span><br><span>@@ -702,6 +703,13 @@</span>=
<br><span> }</span><br><span> </span><br><span> static inline bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+buf_write_u64(struct buffer =
*dest, uint64_t data)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t u64=
 =3D htonll(data);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return buf_write(dest, &amp;u64, sizeof(uint64_t));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic inline bool</span><br><span> buf_copy(struct buffer *dest, const struc=
t buffer *src)</span><br><span> {</span><br><span>     return buf_write(des=
t, BPTR(src), BLENZ(src));</span><br><span>@@ -827,6 +835,30 @@</span><br><=
span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* Read a 64-bit big-endian value (see buf_wri=
te_u64())=2E Sets *good to indicate</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * success, like buf_read_u32()=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline uint64_t</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+buf_read_u64(struct buffer *buf, bool =
*good)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t ret;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_read(buf, &amp;ret, =
sizeof(uint64_t)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (goo=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            *good =3D false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (good)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      *good =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return ntohll(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /** Return tru=
e if buffer contents are equal */</span><br><span> static inline bool</span=
><br><span> buf_equal(const struct buffer *a, const struct buffer *b)</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1740?usp=3Demail">change 1740</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d=
9a7f098d34ad03dfe1 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1740 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--itJv2YcY4xM=--


--===============5580181551419827520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5580181551419827520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5580181551419827520==--

