Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C1CC43458
	for <openvpn-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Wvhe6sbqyUgr5u4ZNrWBRDqCFtqpHESKRCjQgmNiyW8=; b=elK689WNxF6qRA
	QZ2oCXVvGdMiluQYEmhhbq0ZYhdZ6dk2UIwXao7dw7EX+PiDR3JBDdaTOYIwjFv6AXJigVsNzz6oI
	KORZZAmefEqJov/4rmAa89cc96mM7V04PKHIYzjoSTkva7HZ4xZ5ta0Le61IwPm8geQs2a3JP8ZsJ
	2uk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wd87m-0007mw-8e;
	Fri, 26 Jun 2026 15:05:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wd87F-0007mK-8o
 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 15:05:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qLPRCm1qQAOEGMveFLKQwcMZ56OqxRXvVG36xKxTql4=; b=c6U5+YMmUrakGrYXYYyWr9DHLd
 agYot+xNrC+0ciWrvvtG9Kd741pe4m+xNUjygcFRl/elo7mA2kkgvyu5xLkT6jlB0Ksd5kOAwYx0d
 dP1DjubA1crJsFu9pRgKAhiKLIgzezGpjvZ6fNidiagAwZMDLXIvxzQ2JntzvO8wkKL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qLPRCm1qQAOEGMveFLKQwcMZ56OqxRXvVG36xKxTql4=; b=H
 gzKN5mfZFyovwnZfPNFsPuJKwQWj5OZTsQtIIZv/O2PMbdtoFV6BinRI7v0lmm1J9pzCuojTBmRpO
 xLSca/LZRNp0PDEqWKq+SoB56Kpb9Q2hV++xaYwcw5v1QX6OyMLJFgYzdIRhGwsqvNRpwOoRb0miF
 9dUnST85vbY/PdI0=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wd87D-0004jz-M7 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 15:05:13 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso588538f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 26 Jun 2026 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782486301; x=1783091101; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLPRCm1qQAOEGMveFLKQwcMZ56OqxRXvVG36xKxTql4=;
 b=QQ+9iAZrF+lWh3gXGwf0bgKUSy2ftReWV15nNhKWJqEoGWCVdbJOwgylPGdrOWimvK
 8NAvQ+cA7ILGDJ8gl2HfAlulyFDW1/R8w8a4MFV8STpj1iIxe+rOINWcD+gbYRnsFAgS
 6QEFU4OSedD7K7DWVy8K5J3xyFgv0m+G5zgi3KXIZ0FOP4dpfuwr6GCaMIILw1jR1q7V
 zmyji660dNEiTTH47/43YqyXAgKnvWfHPlbWeppRJoGOnu8tBLPTokjagpz6VW7QrX5M
 T0PjBlQLsoDcWTOT/RDj3Fb8IKTFiUDe/0VNGepvHR0LZ8xwpQN+IogSvdtWg9e/DNAo
 WupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782486301; x=1783091101;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qLPRCm1qQAOEGMveFLKQwcMZ56OqxRXvVG36xKxTql4=;
 b=O0VrPNNxvctcwTT8KrbTkmh58F3xlKh58xaGqr0iThQOx0LVvBmctSdGL2ifeVqwDZ
 Blfy56IKaypw8dCSu3XAHBSP5VYrIyzO834IqWCNKqytDH6Azvznr2V5f7jHdCBm4RBY
 hzNBsF6tXCMdEzQdTDWH2QmGl1fUlac1pfr84XuDTupjuUbalic7s+5phckW2jw+GBCr
 ujkU1rsiTG4VD8uqafkHoDO2/LIrZptFUOuB20SnH0Bq8KsJ7blX3vEJmu5WRu0xzzDh
 x6c+d+WSjOA8YZe6ruy+TsbyLqE1KKlqWNF1hK3xwmtM0ATbruLx12m6WE/LvvMpj3xd
 bvGw==
X-Gm-Message-State: AOJu0YwR9mP4uea44kfGSepq9ki5rMULTLqJ0JiTSOLZdBetjbvmEK9T
 bduJo+eHgaiBkwoo2LAWzMJ9kGJ7ZBnmL0dlOuaNqG2RkyvSibilo2FAVoCnuP+cratDqTzj2s0
 Wo9tYemH3Pliz8Mz70Th4oFUXUgp5OpgsZlyEBmHts3qUI4Ipvu/YN8aCYyMxbynAJT3t/mnrgD
 x7r5ZCVA==
X-Gm-Gg: AfdE7ck3hBvLZ3lnkJDrn/rLe+p4EnRfv2IV4xXrXSHfUnWu9DvqSAvNBQpK2qYtV6f
 5Us+TwaIwKEZlSYicNwvb1aIcQ7C67sSDBwJMejH9GyOLX4cu4Jli3nZw3MsUbTEm1g1PFrSCkL
 hsOAoVg7X40y/4/kpUN3jZdNBdaa2FK1ZYndN9QsnfR4AlKKVLWeotNnsmDZhKmPKvaDBX63kAT
 eUPmJD8AwOdxgLyQaVrUKwZPCXFnWe3+VB0aYyARD29/17Y/A903Za3J/mf4aNAD9Zb3SoNiWls
 AUa8uy2awQCHRemluYty0Xcg65dNqBF/1MLvRCy1L6QjHNKrwfYryBA4gw5pqt5bHEr/1YJLPi1
 jAvrdIYiKo3FA4OaELKDJ5+TqTHPwSFpQwNpRfl7iMi/MipjEt6Vw2rAPXEtrZECLTGFImOgOqa
 Ifi0lpX0jnfUpMbj7oTXKIGpfx9xN6WKs+mUFrpMdRykEGvuAUqhYel6hTyL6MQ7IRwZyol7ylx
 6TGHBQP9CuzW3G5i+1evE4dk1LmdYbgy0EujNki4z5ST5q8T9MRWstdrsaZy2XUoXZ9ZYdMrj5E
 Gtc=
X-Received: by 2002:a05:6000:428a:b0:465:1c33:1494 with SMTP id
 ffacd0b85a97d-46dc04610damr13055040f8f.2.1782486300213; 
 Fri, 26 Jun 2026 08:05:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46fc2ff9aaesm1563626f8f.26.2026.06.26.08.04.59
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 08:04:59 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 26 Jun 2026 15:04:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125
X-Gerrit-Change-Number: 1732
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1732?usp=email>
X-Gerrit-Commit: 2645bc2513623486a50677f4126072e14d66224a
References: <gerrit.1782486295000.Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNDg2Mjk1MDAwLklmZWZiM2FkMjA0YzBjMTZjYjQ5NTJkZDZlODY2MWZkYzkxMzZiMTI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c94cd9b3f3df5cf508cb1335e919050614459d02-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wd87D-0004jz-M7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make get_random
 return int64 instead of long
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
Content-Type: multipart/mixed; boundary="===============4367399237076027269=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4367399237076027269==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D8D4O0KEXhg="; charset=UTF-8

--D8D4O0KEXhg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1732?usp=3Demail )


Change subject: Make get_random ret=
urn int64 instead of long
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Make get_random return int64 instead of long

This avoids hav=
ing get_ranomd being different on 32bit/Windows vs
64 bit Unix platform=2E =
Also adjust platform_create_temp_file to
create the same files on all platf=
orms=2E

Change-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125
Signed-off-by=
: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/crypto=2Ec
M src/open=
vpn/crypto=2Eh
M src/openvpn/platform=2Ec
3 files changed, 7 insertions(+),=
 6 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/32/1732/1

diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/cry=
pto=2Ec
index 7954e8a=2E=2E3d79fe5 100644
--- a/src/openvpn/crypto=2Ec
+++ =
b/src/openvpn/crypto=2Ec
@@ -1731,11 +1731,12 @@
     ASSERT(rand_bytes(out=
put, len));
 }
 
-/* an analogue to the random() function, but use prng_byt=
es */
-long int
+/* an analogue to the random() function, but use prng_byte=
s and
+ * also int64_t instead of long to avoid LLP64 vs LP64 */
+int64_t
 =
get_random(void)
 {
-    long int l;
+    int64_t l;
     prng_bytes((unsig=
ned char *)&l, sizeof(l));
     if (l < 0)
     {
diff --git a/src/openvpn/=
crypto=2Eh b/src/openvpn/crypto=2Eh
index fbca2a0=2E=2E74e828b 100644
--- a=
/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -604,7 +604,7 @@
 v=
oid prng_bytes(uint8_t *output, int len);
 
 /* an analogue to the random()=
 function, but use prng_bytes */
-long int get_random(void);
+int64_t get_r=
andom(void);
 
 /** Print a cipher list entry */
 void print_cipher(const c=
har *cipher);
diff --git a/src/openvpn/platform=2Ec b/src/openvpn/platform=
=2Ec
index 9fa9363=2E=2E85b6408 100644
--- a/src/openvpn/platform=2Ec
+++ b=
/src/openvpn/platform=2Ec
@@ -543,7 +543,7 @@
     const char *retfname =3D=
 NULL;
     unsigned int attempts =3D 0;
     char fname[256] =3D { 0 };
- =
   const char *fname_fmt =3D PACKAGE "_%=2E*s_%08lx%08lx=2Etmp";
+    const=
 char *fname_fmt =3D PACKAGE "_%=2E*s_%08" PRIx64 "%08" PRIx64 "=2Etmp";
  =
   const int max_prefix_len =3D sizeof(fname) - (sizeof(PACKAGE) + 7 + (2 *=
 8));
 
     while (attempts < 6)
@@ -551,7 +551,7 @@
         ++attempts;
=
 
         if (!checked_snprintf(fname, sizeof(fname), fname_fmt, max_prefi=
x_len, prefix,
-                              (unsigned long)get_random(), =
(unsigned long)get_random()))
+                              get_random(), =
get_random()))
         {
             msg(M_WARN, "ERROR: temporary filena=
me too long");
             return NULL;

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1732?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125
Gerrit-Cha=
nge-Number: 1732
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--D8D4O0KEXhg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1732?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Make get_random return int64 instead of long<br><br>This avoids ha=
ving get_ranomd being different on 32bit/Windows vs<br>64 bit Unix platform=
=2E Also adjust platform_create_temp_file to<br>create the same files on al=
l platforms=2E<br><br>Change-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125<=
br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/o=
penvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/platform=2Ec=
<br>3 files changed, 7 insertions(+), 6 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32/17=
32/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</=
span><br><span>index 7954e8a=2E=2E3d79fe5 100644</span><br><span>--- a/src/=
openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><=
span>@@ -1731,11 +1731,12 @@</span><br><span>     ASSERT(rand_bytes(output,=
 len));</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/* an analogue to the random() function, but use prn=
g_bytes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-long int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* an analogue to the =
random() function, but use prng_bytes and</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * also int64_t instead of long to avoid LLP64 vs LP6=
4 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int64_t</span><=
br><span> get_random(void)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    long int l;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int64_t l;</span><br><span>     prng_bytes((unsigne=
d char *)&amp;l, sizeof(l));</span><br><span>     if (l &lt; 0)</span><br><=
span>     {</span><br><span>diff --git a/src/openvpn/crypto=2Eh b/src/openv=
pn/crypto=2Eh</span><br><span>index fbca2a0=2E=2E74e828b 100644</span><br><=
span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=
=2Eh</span><br><span>@@ -604,7 +604,7 @@</span><br><span> void prng_bytes(u=
int8_t *output, int len);</span><br><span> </span><br><span> /* an analogue=
 to the random() function, but use prng_bytes */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-long int get_random(void);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int64_t get_random(void);</span><br><span=
> </span><br><span> /** Print a cipher list entry */</span><br><span> void =
print_cipher(const char *cipher);</span><br><span>diff --git a/src/openvpn/=
platform=2Ec b/src/openvpn/platform=2Ec</span><br><span>index 9fa9363=2E=2E=
85b6408 100644</span><br><span>--- a/src/openvpn/platform=2Ec</span><br><sp=
an>+++ b/src/openvpn/platform=2Ec</span><br><span>@@ -543,7 +543,7 @@</span=
><br><span>     const char *retfname =3D NULL;</span><br><span>     unsigne=
d int attempts =3D 0;</span><br><span>     char fname[256] =3D { 0 };</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *fname_fmt =
=3D PACKAGE &quot;_%=2E*s_%08lx%08lx=2Etmp&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const char *fname_fmt =3D PACKAGE &quot;_=
%=2E*s_%08&quot; PRIx64 &quot;%08&quot; PRIx64 &quot;=2Etmp&quot;;</span><b=
r><span>     const int max_prefix_len =3D sizeof(fname) - (sizeof(PACKAGE) =
+ 7 + (2 * 8));</span><br><span> </span><br><span>     while (attempts &lt;=
 6)</span><br><span>@@ -551,7 +551,7 @@</span><br><span>         ++attempts=
;</span><br><span> </span><br><span>         if (!checked_snprintf(fname, s=
izeof(fname), fname_fmt, max_prefix_len, prefix,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                              (unsigned long)get=
_random(), (unsigned long)get_random()))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                              get_random(), get_random=
()))</span><br><span>         {</span><br><span>             msg(M_WARN, &q=
uot;ERROR: temporary filename too long&quot;);</span><br><span>            =
 return NULL;</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1732?usp=3Demail">change 1732</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1732?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifef=
b3ad204c0c16cb4952dd6e8661fdc9136b125 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1732 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--D8D4O0KEXhg=--


--===============4367399237076027269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4367399237076027269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4367399237076027269==--

