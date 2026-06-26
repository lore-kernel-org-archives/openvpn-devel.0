Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712D5C43458
	for <openvpn-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=54ii737+eWMSLrxKERBaFFzgxFoWmbsGQIUM1+vTjHI=; b=WkY/3iHx1rAR2K4a0lLBUU5ap2
	7sz5jvoB0vwkIUvXLyuAFxv2lnk6RgV87xNEmDiGJFWDI6pwW+S6R1F+F9R/PO1ht8bfcbxLswhXC
	T4qEuakt4O3V5h1vtc+H/5nWP+gTSmWWFu7osaafMl9HRJo9i10F1oGspxu2AA75EnJM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wd9Cz-00069u-Pt;
	Fri, 26 Jun 2026 16:15:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wd9Cy-00069g-8E
 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 16:15:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JHN2f1Eaii9P5zsiIxBgsUQ3muNJVFp7w4R3AUAYR3w=; b=F9TPamTbwDeeHHkuOiMgsTq2mP
 IrEQapADIBkg3m4dnCn4lx43eRMliIT0Yk1BTUmoJKq/Eyn3BJIcY2AMe3nm7GobEHrJ6VMr5YLQr
 109Xo+gpysUB9GHWqfOn1VkFwmq30m2FGIUs2NzuEIpt4Hz7O34s3SpNYklCqmLAX2gQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JHN2f1Eaii9P5zsiIxBgsUQ3muNJVFp7w4R3AUAYR3w=; b=T
 ws0q9wupN70S4rIlMBPb3d0TYUHQLWdHhmAycwS3g+dToq32iEOVjyIDKz8Au0FoU0eMRq2cGZBjK
 IagJjQOEnlgWMAd+ysxBawLjd5gt4oSXulm2LqBQsZnsCv3YI2H4/RYK4eOvNDO0RmXz/tj6D+QmG
 ja59zWJF8Gt3s78E=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wd9Cv-0003j4-Ad for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 16:15:12 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-461edb387ddso1184263f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 26 Jun 2026 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782490498; x=1783095298; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JHN2f1Eaii9P5zsiIxBgsUQ3muNJVFp7w4R3AUAYR3w=;
 b=PwTdB6rgiGAD1C+4y8MPEnu5WguSSuqqpeZgg+XPsqiHI388HPbvZkbaDawGaMRLbP
 d23Sj5JE0DTgPhaPivirzEhssVMR1p5g/YOu4YZCJK3TBel4U5+JYvrs6/chF04GvGg9
 FRmbCxHeyuB85QISimCy5GVXUjIoLwCifauqdRE1Zy0a8WiC5m/mUR7ZcSxG6WinEB5s
 8zBx/Kp9tYN7Zzcu1bKpCQ77SH/nAb/k/e9bn9u60DF8rCNHxuA4vbwptbxy4TXpR0cF
 0L9WP+mYmnKjTF7jFMWF42xFd2Hb/yQ9+ZG4LsaOsGKUOIU9cslI8VQDtwq7G/zArpVK
 7ysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782490498; x=1783095298;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JHN2f1Eaii9P5zsiIxBgsUQ3muNJVFp7w4R3AUAYR3w=;
 b=iTfm+xd1WuxUtrC45bkPax2zuWFo6exWRFxWmSxMaGOht5Xi0q4OZX8A5qZzjFf9sg
 n4rMqab9shHfamR/8Z+i9qAkLKt8sPD3521trZ/8iUX61LcFDisMOvzgcYZyiq/uVmgo
 4Vel1URTb3aSRoUn+thzQsw6bqKkhvbSejsAKLF+7ryYuxvRf0zLhKIdAdO/VeVySVJY
 T/CjaJH1g1M29Nk9CijLzXJe9EtZwjUrEjOE0sL7C0GBHlNj7XRx6Uhnbt9sRDRE9wH/
 ba245napoAAA4JWmRE4UB5Bna9OwqaHk8Ye00aanErFtjCOmaRpHbvaiuN5Jb+tktnI4
 n3Nw==
X-Gm-Message-State: AOJu0YwtAW6Wh9WbWjrnZ9c2cYSen7udcwCCN7sBcl+NAD4YouBeuSUp
 F1yl6BiHoaV5ypJFyZv6aCWuo8uARFIfLgI0r4ZMkoxUq9YAx3TdE26CVOPmWx9cGQcdC7i+lIg
 W9tVO+wyZ5bQNhoqyoE233mfnq4Ha6oEkQoP44D26tcEYxmx5QvBqRaYsaUYiQvfnvAaz
X-Gm-Gg: AfdE7cmWHlQSqjTy5+vBNxYC7KyghCw/PrBQeRMs8ESh6l05vzw40mDzp128vSz50H7
 MMbzsG0TYw1SGHr8TTxN0rbAWq/1Fu2f50GoxcZyOQt9zKctseamYApogCgNmdzFA+wYV9irBkW
 koRcLeK0bXnCZBZ54Y2fTyLLJ74Z37ymQIVZ+CtK4kHACBVFi8xNxsnAxWNtYDwCJubkmiT8lM+
 9KgHJCCOFoW8n3wHbQi15aYMq405VSnX4K7eFqY9GMfzcf4prpgQbH/pfkqYbd3/sBRCcHGLFMp
 5+lCGn812suXwbGVS1AAQfmR2oHzDD7IqS5gL7Pd0UTZh4ji5EFNaQyMMDtAaDfqJEI4e3LAH9R
 MwVxgIVQ+3+s0TnRnXyslpj76n6vjGZXZDNtRECQhRbF0oGYaUlC4lDZcAk4vsOHVFKE+gKJdGO
 0N1aojkT60vPHm1r1OpEfkGdbxmDiTnYhneqd3X/MJFZDLqEisgbJyYemem2F5EBe0swtriZ2pj
 /C8M5WUkP3d9KUQNcOjztzUD6Tn7k+yCbJ4qK17+lUXh+vPRUlGahAbTh5v0AY16BNunYLeEdYe
 WAk=
X-Received: by 2002:a05:6000:2406:b0:455:70bc:216d with SMTP id
 ffacd0b85a97d-46dbf5e5f33mr12919283f8f.12.1782490498179; 
 Fri, 26 Jun 2026 09:14:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46fe25429d5sm1349130f8f.7.2026.06.26.09.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 09:14:57 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 26 Jun 2026 16:14:57 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125
X-Gerrit-Change-Number: 1732
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1732?usp=email>
X-Gerrit-Commit: 712f3d61488a47e80577112489e9e9f98a32aac6
In-Reply-To: <gerrit.1782486295000.Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125@gerrit.openvpn.net>
References: <gerrit.1782486295000.Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNDg2Mjk1MDAwLklmZWZiM2FkMjA0YzBjMTZjYjQ5NTJkZDZlODY2MWZkYzkxMzZiMTI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0833ce2f7faa3092455947fb2334220599c66aed-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wd9Cv-0003j4-Ad
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6446456631232340107=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6446456631232340107==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J/i3sFnv61Y="; charset=UTF-8

--J/i3sFnv61Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1732?usp=3Demail )

Change subject: Make get_random return int64 instea=
d of long
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

M=
ake get_random return int64 instead of long

This avoids having get_ranomd =
being different on 32bit/Windows vs
64 bit Unix platform=2E Also adjust pla=
tform_create_temp_file to
create the same files on all platforms=2E

Change=
-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125
Signed-off-by: Arne Schwabe =
<arne@rfc2549=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerri=
t URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1732
Message-Id: <2026062=
6152951=2E29207-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37322=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/crypto=2Ec
M sr=
c/openvpn/crypto=2Eh
M src/openvpn/platform=2Ec
3 files changed, 13 inserti=
ons(+), 7 deletions(-)




diff --git a/src/openvpn/crypto=2Ec b/src/openvp=
n/crypto=2Ec
index 7954e8a=2E=2E3d79fe5 100644
--- a/src/openvpn/crypto=2Ec=

+++ b/src/openvpn/crypto=2Ec
@@ -1731,11 +1731,12 @@
     ASSERT(rand_byte=
s(output, len));
 }
 
-/* an analogue to the random() function, but use prn=
g_bytes */
-long int
+/* an analogue to the random() function, but use prng=
_bytes and
+ * also int64_t instead of long to avoid LLP64 vs LP64 */
+int6=
4_t
 get_random(void)
 {
-    long int l;
+    int64_t l;
     prng_bytes((=
unsigned char *)&l, sizeof(l));
     if (l < 0)
     {
diff --git a/src/ope=
nvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index fbca2a0=2E=2Eee5b50f 100644
=
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -603,8 +603,13=
 @@
  */
 void prng_bytes(uint8_t *output, int len);
 
-/* an analogue to t=
he random() function, but use prng_bytes */
-long int get_random(void);
+/*=
*
+ * an analogue to the random() function, but use prng_bytes and
+ * also=
 int64_t instead of long to avoid LLP64 vs LP64
+ *
+ * @return Returns a r=
andom positive 63 bit integer
+ */
+int64_t get_random(void);
 
 /** Print =
a cipher list entry */
 void print_cipher(const char *cipher);
diff --git a=
/src/openvpn/platform=2Ec b/src/openvpn/platform=2Ec
index 9fa9363=2E=2E85b=
6408 100644
--- a/src/openvpn/platform=2Ec
+++ b/src/openvpn/platform=2Ec
@=
@ -543,7 +543,7 @@
     const char *retfname =3D NULL;
     unsigned int at=
tempts =3D 0;
     char fname[256] =3D { 0 };
-    const char *fname_fmt =
=3D PACKAGE "_%=2E*s_%08lx%08lx=2Etmp";
+    const char *fname_fmt =3D PACK=
AGE "_%=2E*s_%08" PRIx64 "%08" PRIx64 "=2Etmp";
     const int max_prefix_l=
en =3D sizeof(fname) - (sizeof(PACKAGE) + 7 + (2 * 8));
 
     while (attem=
pts < 6)
@@ -551,7 +551,7 @@
         ++attempts;
 
         if (!checked_s=
nprintf(fname, sizeof(fname), fname_fmt, max_prefix_len, prefix,
-         =
                     (unsigned long)get_random(), (unsigned long)get_random=
()))
+                              get_random(), get_random()))
         {=

             msg(M_WARN, "ERROR: temporary filename too long");
          =
   return NULL;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1732?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: me=
rged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifefb3=
ad204c0c16cb4952dd6e8661fdc9136b125
Gerrit-Change-Number: 1732
Gerrit-Patch=
Set: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>

--J/i3sFnv61Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1732?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Make get_random return int64 instead of lo=
ng<br><br>This avoids having get_ranomd being different on 32bit/Windows vs=
<br>64 bit Unix platform=2E Also adjust platform_create_temp_file to<br>cre=
ate the same files on all platforms=2E<br><br>Change-Id: Ifefb3ad204c0c16cb=
4952dd6e8661fdc9136b125<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit =
URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1732<br>Message-Id: &lt;202=
60626152951=2E29207-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37322=2Ehtml<br>=
Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src=
/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/platform=
=2Ec<br>3 files changed, 13 insertions(+), 7 deletions(-)<br><br></pre>
<pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><spa=
n>index 7954e8a=2E=2E3d79fe5 100644</span><br><span>--- a/src/openvpn/crypt=
o=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1731=
,11 +1731,12 @@</span><br><span>     ASSERT(rand_bytes(output, len));</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-/* an analogue to the random() function, but use prng_bytes */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-long int</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* an analogue to the random() func=
tion, but use prng_bytes and</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * also int64_t instead of long to avoid LLP64 vs LP64 */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+int64_t</span><br><span> get=
_random(void)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    long int l;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int64_t l;</span><br><span>     prng_bytes((unsigned char *)&amp=
;l, sizeof(l));</span><br><span>     if (l &lt; 0)</span><br><span>     {</=
span><br><span>diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh=
</span><br><span>index fbca2a0=2E=2Eee5b50f 100644</span><br><span>--- a/sr=
c/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh</span><br=
><span>@@ -603,8 +603,13 @@</span><br><span>  */</span><br><span> void prng=
_bytes(uint8_t *output, int len);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* an analogue to the random() function, bu=
t use prng_bytes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-lo=
ng int get_random(void);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * an analo=
gue to the random() function, but use prng_bytes and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * also int64_t instead of long to avoid =
LLP64 vs LP64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Returns a ra=
ndom positive 63 bit integer</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int64_t=
 get_random(void);</span><br><span> </span><br><span> /** Print a cipher li=
st entry */</span><br><span> void print_cipher(const char *cipher);</span><=
br><span>diff --git a/src/openvpn/platform=2Ec b/src/openvpn/platform=2Ec</=
span><br><span>index 9fa9363=2E=2E85b6408 100644</span><br><span>--- a/src/=
openvpn/platform=2Ec</span><br><span>+++ b/src/openvpn/platform=2Ec</span><=
br><span>@@ -543,7 +543,7 @@</span><br><span>     const char *retfname =3D =
NULL;</span><br><span>     unsigned int attempts =3D 0;</span><br><span>   =
  char fname[256] =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const char *fname_fmt =3D PACKAGE &quot;_%=2E*s_%08lx%08lx=2Etmp=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ch=
ar *fname_fmt =3D PACKAGE &quot;_%=2E*s_%08&quot; PRIx64 &quot;%08&quot; PR=
Ix64 &quot;=2Etmp&quot;;</span><br><span>     const int max_prefix_len =3D =
sizeof(fname) - (sizeof(PACKAGE) + 7 + (2 * 8));</span><br><span> </span><b=
r><span>     while (attempts &lt; 6)</span><br><span>@@ -551,7 +551,7 @@</s=
pan><br><span>         ++attempts;</span><br><span> </span><br><span>      =
   if (!checked_snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len, p=
refix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
               (unsigned long)get_random(), (unsigned long)get_random()))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
         get_random(), get_random()))</span><br><span>         {</span><br>=
<span>             msg(M_WARN, &quot;ERROR: temporary filename too long&quo=
t;);</span><br><span>             return NULL;</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1732?usp=3Demail">change 1732</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1732?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merge=
d </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1732 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerri=
t-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>

</body></html>
--J/i3sFnv61Y=--


--===============6446456631232340107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6446456631232340107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6446456631232340107==--

