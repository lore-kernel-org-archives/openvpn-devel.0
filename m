Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBE8C43458
	for <openvpn-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tBLbd6RUdGL+uWmdd3B2uFjxGx8NdlPq0Grw88J/9T4=; b=Yz/1fWc5r6HmFzlt1hQd0fohUg
	6v8wfYDQQ5bYkO9jcTz+trRZcNctCyryihy8El7xsw5FAML9oVQoV1DjDyKLKtTs4rivY9xi9Lsu2
	hxkWGp6iQ1gWmV369BDnIy605aIu3DP9kSZIqsMb/cxCQjDYHI44zqNvtMaXdppX1gy0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wd899-0007q6-MR;
	Fri, 26 Jun 2026 15:07:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wd895-0007pS-AD
 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 15:07:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Oinp8t8B2ehqiBEFEdQ0egfmQtGfvCKYy7XIc7kBTW4=; b=f2CJURbY9d/M1zTcTW5HThvc0Y
 XVr7jug0UqisLVLGxAguFeiXsJRFgy76ApPHSxOpduFz4lYd86Yao+5CtWckhEDvFTONnh0MhSr2G
 3774hUIYErLI23mYFyoqrAXFU1C7OTC/lwls6rum8rAErSHIUMcA5nRrRLea/M+lR/z8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Oinp8t8B2ehqiBEFEdQ0egfmQtGfvCKYy7XIc7kBTW4=; b=N
 urM/K4Rb86DpZGxpui0VtW7bUdmtWTkRof6v17qwJhclUNos4hTKFV7ao5mKZUAIHLM64ANY+9hoN
 FhoL44W31VzJOzLhMlRJ6qXvG+41XIOO/ig1PeV/ajd8ZExOTZOHiFUhsnFsnNALoNjxurqehHJ9V
 uhf11bYBvvzvGXHA=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wd88q-0004yr-P5 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 15:06:53 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso10321795e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 26 Jun 2026 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782486407; x=1783091207; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oinp8t8B2ehqiBEFEdQ0egfmQtGfvCKYy7XIc7kBTW4=;
 b=bYw3CN8QeHFFlJ8BOJjhzPmn8nqTYJhPZ5xk4TSTg61trNGgYGwtscS8liVjL/kAPM
 57woSyIc+dJi1LjpuKVCA2qAlSMxMqUppMkYECUQlQ+1yJxbMOu4hjhoGlnDpiYcHuI2
 uDeFBbier5e2FFysTtVfuC06DTN5oGVv2zVX9UMC9kYRQClNRIVrtu8E9gqXZndvDZBO
 9tm52/f18C92V2QLwFYoBsG/ASwj3hktBbSo7i4m4NNMKKFlfQPDoKigQSeDVOehg7uJ
 57TPXD8iMRrhNPi/H9X6+G3Ric1JurQmodaHEpiQFMruuLUhwxL1cGefVLwE+9+ddJkV
 QnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782486407; x=1783091207;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oinp8t8B2ehqiBEFEdQ0egfmQtGfvCKYy7XIc7kBTW4=;
 b=T5JP4Lw3Y45lfmI+gyX1pGxyGZOaGtKr+t4hr14e9StujjGyoHTZgZiHzpcksdFdsV
 tCYpBascSMY9gHcuyE6QamShRfP4S3l9yzsfgmMA7A8BJcBzc3hLhsXu56ZeVJxS+Ald
 ZgarPOplXN7VQ/gHeQvvBp35Vl7J1h78EtLFW2O/DaxtR20UZld8jWrk569Bi+N8cWwd
 aiu7FQsZNkfq9EVuX3v/d3/2hxJ8bvzRMasesMM0zcHHxyFsiuk9x/6qVzYFedkY8A3M
 5pVpQP3/RcB69iKEisY9xv69ka1/ONevdn+DB1/3MOw8awqGdmMnECCDG8TZElf1rLl8
 AHnw==
X-Gm-Message-State: AOJu0Yy+SR0a8hDEhH0egKLwi4TQp8Y1rKlZEZh5xZ2z6N/UwF7kNvJq
 EulXt4dbaCT1wLgoogPR+swWrl+1pB/5blJxlvTuEYGBlJY29Ih9f/tHlZSgPFbat78ZlygSQsb
 E5el2kS48oMxDRXDjNAIdU7eGUeMVBkvJEYZuQQGVYj8YngFwaVcj3yo+gPbcu0bGg+Tgxwxyhx
 QeXRpVTg==
X-Gm-Gg: AfdE7ckSk+1Z2CyDKdR+TD0f2bkxZFLjV693QhnOrjwJLkuSBg9aq/4I4efio4qzmWw
 1DlFMHdD7TL+vKyOJ6fHK5dC0K8VoJhd+5awn2euYHz6wzFNr4kXgLhP2Nmijq4B/6XdpAYklUZ
 NipPNsIt5J25UaJYUfXg5XdT+LX6M0yTSa+/PinfTlv1PM55ETQ/L8L8j9mCZ9ckT7/rbCTNDUp
 hsiQw0XnlC9vvxJEm6AqYpJnCASy4WCKvaIirmNwq+4JCP+ZEIoaAgB1ouSS8yRP7CL3npajboz
 zZkimRxlr/ZIO8KYqGWn5W52jPPNrGNNwUnTiB7zi13cokGvEMEx4ezaWa2zXXCln4ym+rjuVsi
 zjSk348dcNBKiwMrkdqU1HkmcQiknZCkR4gy07xhZCSo70Hp/LIAF+JNkhhlhbhsebkF1ItaSh+
 zkZPn7jM/GYczkNKGbsSbsl1wmfo3qaS4n4uBqZmXK3Rx23XZ4Vu8KwEmITCad6HS6Pa/T+7ads
 If/tDK5ivQ4otPLv2BEEuiuKEvno68SA9nMg4wY7BZJDO6nm6U+xj0CHpi2MQm0Mw+X61JbEdXA
 QFU=
X-Received: by 2002:a05:600c:41c1:b0:492:324d:e93f with SMTP id
 5b1f17b1804b1-4926fcac16cmr14169345e9.36.1782486406546; 
 Fri, 26 Jun 2026 08:06:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268ffe204sm87147135e9.7.2026.06.26.08.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 08:06:46 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 26 Jun 2026 15:06:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125
X-Gerrit-Change-Number: 1732
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1732?usp=email>
X-Gerrit-Commit: e1fc01b4866bf68f0c90d6e676bc78686b021345
In-Reply-To: <gerrit.1782486295000.Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125@gerrit.openvpn.net>
References: <gerrit.1782486295000.Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNDg2Mjk1MDAwLklmZWZiM2FkMjA0YzBjMTZjYjQ5NTJkZDZlODY2MWZkYzkxMzZiMTI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bea7f5ecc2da83dabf4caf60dab043da2ac48f05-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wd88q-0004yr-P5
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
Content-Type: multipart/mixed; boundary="===============3029866352744963555=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3029866352744963555==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y2CJwjhYLzA="; charset=UTF-8

--Y2CJwjhYLzA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1732?usp=3Demail )


Change subject: Make get_random return=
 int64 instead of long
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Make get_random return int64 instead of long

This avoids having=
 get_ranomd being different on 32bit/Windows vs
64 bit Unix platform=2E Als=
o adjust platform_create_temp_file to
create the same files on all platform=
s=2E

Change-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125
Signed-off-by: A=
rne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/crypto=2Ec
M src/openvpn=
/crypto=2Eh
M src/openvpn/platform=2Ec
3 files changed, 13 insertions(+), 7=
 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/32/1732/2

diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=
=2Ec
index 7954e8a=2E=2E3d79fe5 100644
--- a/src/openvpn/crypto=2Ec
+++ b/s=
rc/openvpn/crypto=2Ec
@@ -1731,11 +1731,12 @@
     ASSERT(rand_bytes(output=
, len));
 }
 
-/* an analogue to the random() function, but use prng_bytes =
*/
-long int
+/* an analogue to the random() function, but use prng_bytes a=
nd
+ * also int64_t instead of long to avoid LLP64 vs LP64 */
+int64_t
 get=
_random(void)
 {
-    long int l;
+    int64_t l;
     prng_bytes((unsigned=
 char *)&l, sizeof(l));
     if (l < 0)
     {
diff --git a/src/openvpn/cry=
pto=2Eh b/src/openvpn/crypto=2Eh
index fbca2a0=2E=2Eee5b50f 100644
--- a/sr=
c/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -603,8 +603,13 @@
  */=

 void prng_bytes(uint8_t *output, int len);
 
-/* an analogue to the rando=
m() function, but use prng_bytes */
-long int get_random(void);
+/**
+ * an=
 analogue to the random() function, but use prng_bytes and
+ * also int64_t=
 instead of long to avoid LLP64 vs LP64
+ *
+ * @return Returns a random po=
sitive 63 bit integer
+ */
+int64_t get_random(void);
 
 /** Print a cipher=
 list entry */
 void print_cipher(const char *cipher);
diff --git a/src/ope=
nvpn/platform=2Ec b/src/openvpn/platform=2Ec
index 9fa9363=2E=2E85b6408 100=
644
--- a/src/openvpn/platform=2Ec
+++ b/src/openvpn/platform=2Ec
@@ -543,7=
 +543,7 @@
     const char *retfname =3D NULL;
     unsigned int attempts =
=3D 0;
     char fname[256] =3D { 0 };
-    const char *fname_fmt =3D PACKA=
GE "_%=2E*s_%08lx%08lx=2Etmp";
+    const char *fname_fmt =3D PACKAGE "_%=
=2E*s_%08" PRIx64 "%08" PRIx64 "=2Etmp";
     const int max_prefix_len =3D =
sizeof(fname) - (sizeof(PACKAGE) + 7 + (2 * 8));
 
     while (attempts < 6=
)
@@ -551,7 +551,7 @@
         ++attempts;
 
         if (!checked_snprintf=
(fname, sizeof(fname), fname_fmt, max_prefix_len, prefix,
-                =
              (unsigned long)get_random(), (unsigned long)get_random()))
+ =
                             get_random(), get_random()))
         {
      =
       msg(M_WARN, "ERROR: temporary filename too long");
             retu=
rn NULL;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1732=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifefb3ad=
204c0c16cb4952dd6e8661fdc9136b125
Gerrit-Change-Number: 1732
Gerrit-PatchSe=
t: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Y2CJwjhYLzA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1732?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Make get_random return int64 instead of long<br><br>This avoids h=
aving get_ranomd being different on 32bit/Windows vs<br>64 bit Unix platfor=
m=2E Also adjust platform_create_temp_file to<br>create the same files on a=
ll platforms=2E<br><br>Change-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125=
<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/=
openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/platform=2E=
c<br>3 files changed, 13 insertions(+), 7 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32/=
1732/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec=
</span><br><span>index 7954e8a=2E=2E3d79fe5 100644</span><br><span>--- a/sr=
c/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br=
><span>@@ -1731,11 +1731,12 @@</span><br><span>     ASSERT(rand_bytes(outpu=
t, len));</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/* an analogue to the random() function, but use p=
rng_bytes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-long int<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* an analogue to th=
e random() function, but use prng_bytes and</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * also int64_t instead of long to avoid LLP64 vs L=
P64 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int64_t</span=
><br><span> get_random(void)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    long int l;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int64_t l;</span><br><span>     prng_bytes((unsig=
ned char *)&amp;l, sizeof(l));</span><br><span>     if (l &lt; 0)</span><br=
><span>     {</span><br><span>diff --git a/src/openvpn/crypto=2Eh b/src/ope=
nvpn/crypto=2Eh</span><br><span>index fbca2a0=2E=2Eee5b50f 100644</span><br=
><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypt=
o=2Eh</span><br><span>@@ -603,8 +603,13 @@</span><br><span>  */</span><br><=
span> void prng_bytes(uint8_t *output, int len);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/* an analogue to the random()=
 function, but use prng_bytes */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-long int get_random(void);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * an analogue to the random() function, but use prng_bytes and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * also int64_t instead of lo=
ng to avoid LLP64 vs LP64</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
Returns a random positive 63 bit integer</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+int64_t get_random(void);</span><br><span> </span><br><span> /** Print=
 a cipher list entry */</span><br><span> void print_cipher(const char *ciph=
er);</span><br><span>diff --git a/src/openvpn/platform=2Ec b/src/openvpn/pl=
atform=2Ec</span><br><span>index 9fa9363=2E=2E85b6408 100644</span><br><spa=
n>--- a/src/openvpn/platform=2Ec</span><br><span>+++ b/src/openvpn/platform=
=2Ec</span><br><span>@@ -543,7 +543,7 @@</span><br><span>     const char *r=
etfname =3D NULL;</span><br><span>     unsigned int attempts =3D 0;</span><=
br><span>     char fname[256] =3D { 0 };</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const char *fname_fmt =3D PACKAGE &quot;_%=2E*s_%08l=
x%08lx=2Etmp&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *fname_fmt =3D PACKAGE &quot;_%=2E*s_%08&quot; PRIx64 &quot;=
%08&quot; PRIx64 &quot;=2Etmp&quot;;</span><br><span>     const int max_pre=
fix_len =3D sizeof(fname) - (sizeof(PACKAGE) + 7 + (2 * 8));</span><br><spa=
n> </span><br><span>     while (attempts &lt; 6)</span><br><span>@@ -551,7 =
+551,7 @@</span><br><span>         ++attempts;</span><br><span> </span><br>=
<span>         if (!checked_snprintf(fname, sizeof(fname), fname_fmt, max_p=
refix_len, prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                           (unsigned long)get_random(), (unsigned long)get_=
random()))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                     get_random(), get_random()))</span><br><span>         =
{</span><br><span>             msg(M_WARN, &quot;ERROR: temporary filename =
too long&quot;);</span><br><span>             return NULL;</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1732?usp=3Demail">change 1732</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1732?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9=
136b125 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1732 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Y2CJwjhYLzA=--


--===============3029866352744963555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3029866352744963555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3029866352744963555==--

