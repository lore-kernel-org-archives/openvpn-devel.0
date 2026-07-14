Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32CFC44501
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IPkefVGCkW3FXAmSyWrMIUzTrURyzqmxf5oFZYt3vyE=; b=AgQ1vm+pzSiAQTqwTTlNCdgJlp
	nbbZl6POYWV11XcMW7qNdEJkEUv+xXv3eRMddlM/XbqUlN4h5ydfm3VZga73cnsHSv0A0Ju6uu271
	rjv1KQt6QeCmB18rjblHMIkuiy54NTRNBu5rBLdwTbjt5oFBPJASAsw9Cs6u/Y9GSdug=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjYIZ-0003R1-Bn;
	Tue, 14 Jul 2026 08:15:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjYIK-0003QI-0v
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 08:15:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BOIyGc+FCYCsLDSCnEahAe+/cTLaiBVbmIUp9xVvi3A=; b=Njlo3abZKtgphDl3ytUMAlpWrS
 5vH1tRkxJAC4MuhkAf+N7Xvw05KGQr82KKTMiInzcGJk0lV2hPRiDM6QnRz8IGL73sskM1b8k8Vzy
 A/JY4wenIOWag5youYGUsL+5xAQajKAMGN20JAuBnEniYuW4eY+cjkjMltI6DJDiPzzQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BOIyGc+FCYCsLDSCnEahAe+/cTLaiBVbmIUp9xVvi3A=; b=k
 +PEvd3L/Ug62kCH2UWDbRe+25qnBQQ7XvyBmxHTTcA4iIobBrJGOhSnmu83q920EcNiAYhwJZgdwg
 HbJkhrTVEhiQjEOfJ1P+yJsxhPARCaRxUxsoOHoj4yWmvm6aVfREK9lzp0zjdNX227ZQy0RDh2AHM
 34a1MK1GZyJsNkdk=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjYI8-0002fL-6u for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 08:15:03 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493e8d4f4dcso31173075e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784016894; x=1784621694; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BOIyGc+FCYCsLDSCnEahAe+/cTLaiBVbmIUp9xVvi3A=;
 b=PTXHe7LPuLu2Oe2HX2DUFREWbTZgcyn0zTBe5k+oyuVSTrreWPW9d/jxiVsbFjvXi3
 hXPHum1hL/D6YHRzoqyKFjLwT1VHiBIRPES2xvW5P1WDJZgnHBhAA02S9ngtU9vX+sbM
 IsQn/uh+EnRo7bBmy/HfcDldof2qxY9I7qg4hq09nj0Hz7vaw0CrjVJkVJxbsVxB7SpG
 /HFMvtWBaInd1b7T6dpQtPUssFMZrudHNnXYrmBCQNSWdzGx7jYn191bl50gjp4BwVZQ
 5PeSuO3499VcTSItS1a51iqYPGoRMSVsjGFrZoRdDaVmgYNc4IdhXhmdTpfLxlBJjBpQ
 p7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784016894; x=1784621694;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BOIyGc+FCYCsLDSCnEahAe+/cTLaiBVbmIUp9xVvi3A=;
 b=LBxR7ZIZ4EySJ6dhdL4eXMFakCKtR29KpdJQopYLrg0JLIe285LxSJNmXVMBfL3dFj
 etwhMCKCt+mNTKN6mcgcZ9lbrLtSNyE+5setpUvKzXLKQ8g5HJlYzxzLvfIaknWF2Mjz
 S/Y0MKFoLpFPYYd6hoKvdISEYMaUE8Z7Pn4hEDIF4TAKVdwH9DVbwc+IDi65GSOgsw9V
 XR/wAggRUUCvsL2BqcSuNaDA5r8FeRHEFt4lrOURZdq6YHuRG/PFfR9DcVlWhz2Sc3HJ
 BzombYnGH/nL/+YuGWih/tewSegbfzBuRvocHbuRIDZpxNakOiXfhi+1ysXsBMIAmdM5
 j2lw==
X-Gm-Message-State: AOJu0YzFR+nhBiUFz2Di95q2W1h3W8DYRyWMVpE5z0vhof2mK9KgqZzM
 rCpR31j+1rcOcWBTpiEgotqdn00+Q243a5OYNtK2Ni4MmE86qgPJgjpD3K2PsSM8xvuv8vbA2m1
 tLFRfFaI13UG8EODupMin3jRGNGXr9FP2PBkeBX8EIJvzZlrLRFhmpiRpHtSXik+ZlTH+
X-Gm-Gg: AfdE7cn4gzKmu+nSnKVh7R0yTdgKOf77iML2cIwAIVPv2nies06q9/7sDTfo2zLOjRY
 egmzJrVOOvJwFijkgUfzqtkkZaVIU/8BxpfRebRBvXntwOb3wT9Kwia6HM1gQpfs+i58JGyi52l
 mlEi8wMY7FKCsyrzHhOh72vOHND5pY/cHjrIFwoxpB7wQnvNx3Yp71+UtnTc0/0b3KI2CBhWEDz
 iC9hGVSlwBS0gZL7TrsxAUV2GZVXuhLOMJ//pGZRi976lcw2xnAgXXQFdqvFDVkHwad2JSHU46s
 HAwrHTz1lier88U4sCE+qC1OXDIZcsLMAgCS8USqXeNbG62Ay2Sk4Rllyo/C9IOFJ2KrIOYEQaM
 l43xwolxnhVq68uKfyCdJeWav4O3ZRU/R8+3yeEunfMrjhMaQVeMMSIk+SZ7RXC6URq4jLnZk3+
 9FvFX79RQxsyxliIjN2AEgoImTubiQHJPPIZ2MemaVfgBgkJmI1pm6KeF1EQ6zJbhBTkp2N4zMd
 b2IXVIXcTYUWDfDEeQgxJL5DlvLR6n4RxSBsnam/4UNHxoE5HpFQ7OYGM4mrRLlfma+2OlIDdcy
 Rh4=
X-Received: by 2002:a05:600c:154a:b0:493:f73d:cc6d with SMTP id
 5b1f17b1804b1-493f8824ba6mr139014675e9.24.1784016893475; 
 Tue, 14 Jul 2026 01:14:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f462e0cb2sm6240863f8f.0.2026.07.14.01.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 01:14:52 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 08:14:41 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
X-Gerrit-Change-Number: 1740
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1740?usp=email>
X-Gerrit-Commit: fad2c0952fba5907ae81d9541f8984de5adcfad7
In-Reply-To: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNjc3ZjQzZmMzZWIwMDUyZjhlODBkOWE3ZjA5OGQzNGFkMDNkZmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <40cb446a4fb0c984b2550e43d2a46b4d4281e2ef-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjYI8-0002fL-6u
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8644340449312845415=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8644340449312845415==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+xd1Z6fveUw="; charset=UTF-8

--+xd1Z6fveUw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa=
=2E

Hello cron2, flichtenheld, plaisthos, 

I'd like you to reexamine a ch=
ange=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?us=
p=3Demail

to look at the new patch set (#3)=2E

The following approvals go=
t outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review-1 b=
y cron2


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
---
M src/op=
envpn/buffer=2Eh
1 file changed, 32 insertions(+), 0 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/40/1740/3

diff=
 --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index fcc923b=2E=
=2E1db9367 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh=

@@ -25,6 +25,7 @@
 
 #include "basic=2Eh"
 #include "error=2Eh"
+#include =
"integer=2Eh"
 
 #define BUF_SIZE_MAX 1000000
 
@@ -702,6 +703,13 @@
 }
 
 =
static inline bool
+buf_write_u64(struct buffer *dest, uint64_t data)
+{
+ =
   uint64_t u64 =3D htonll(data);
+    return buf_write(dest, &u64, sizeof(=
uint64_t));
+}
+
+static inline bool
 buf_copy(struct buffer *dest, const s=
truct buffer *src)
 {
     return buf_write(dest, BPTR(src), BLENZ(src));
@=
@ -827,6 +835,30 @@
     }
 }
 
+/* Read a 64-bit big-endian value (see buf=
_write_u64())=2E Sets *good to indicate
+ * success, like buf_read_u32()=2E=
 */
+static inline uint64_t
+buf_read_u64(struct buffer *buf, bool *good)
+=
{
+    uint64_t ret;
+    if (!buf_read(buf, &ret, sizeof(uint64_t)))
+    =
{
+        if (good)
+        {
+            *good =3D false;
+        }
+ =
       return 0;
+    }
+    else
+    {
+        if (good)
+        {
+   =
         *good =3D true;
+        }
+        return ntohll(ret);
+    }
+}
=
+
 /** Return true if buffer contents are equal */
 static inline bool
 buf=
_equal(const struct buffer *a, const struct buffer *b)

-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03=
dfe1
Gerrit-Change-Number: 1740
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lst=
ipakov@gmail=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: fl=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gma=
il=2Ecom>

--+xd1Z6fveUw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos, stipa=2E </p>
<p>stip=
a <strong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+=
2 by flichtenheld, Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">buffer: Add buf_=
read_u64() and buf_write_u64()<br><br>Add 64-bit big-endian buffer accessor=
s alongside the existing 8/16/32-bit<br>helpers, using htonll()/ntohll() fo=
r the byte-order conversion=2E<br><br>buf_read_u64() reports success via a =
bool out-parameter, mirroring<br>buf_read_u32()=2E<br><br>Change-Id: Ic677f=
43fc3eb0052f8e80d9a7f098d34ad03dfe1<br>Signed-off-by: Lev Stipakov &lt;lev@=
openvpn=2Enet&gt;<br>---<br>M src/openvpn/buffer=2Eh<br>1 file changed, 32 =
insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/40/1740/3</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index fc=
c923b=2E=2E1db9367 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</spa=
n><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -25,6 +25,7 @@<=
/span><br><span> </span><br><span> #include &quot;basic=2Eh&quot;</span><br=
><span> #include &quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;integer=2Eh&quot;</span><br><span> </span=
><br><span> #define BUF_SIZE_MAX 1000000</span><br><span> </span><br><span>=
@@ -702,6 +703,13 @@</span><br><span> }</span><br><span> </span><br><span> =
static inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
uf_write_u64(struct buffer *dest, uint64_t data)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    uint64_t u64 =3D htonll(data);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return buf_write(dest, &amp;u64, sizeof(uint6=
4_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static inline bool</span><br><span> buf_copy(struc=
t buffer *dest, const struct buffer *src)</span><br><span> {</span><br><spa=
n>     return buf_write(dest, BPTR(src), BLENZ(src));</span><br><span>@@ -8=
27,6 +835,30 @@</span><br><span>     }</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Read a 64-bit bi=
g-endian value (see buf_write_u64())=2E Sets *good to indicate</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * success, like buf_read_u32()=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline=
 uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_read_u=
64(struct buffer *buf, bool *good)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uint64_t ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!buf_read(buf, &amp;ret, sizeof(uint64_t)))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (good)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            *good =3D false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (good)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            *good =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return ntohll(ret);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> /** Return true if buffer contents are equal */</span><=
br><span> static inline bool</span><br><span> buf_equal(const struct buffer=
 *a, const struct buffer *b)</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail"=
>change 1740</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1740 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stip=
a &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></=
html>
--+xd1Z6fveUw=--


--===============8644340449312845415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8644340449312845415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8644340449312845415==--

