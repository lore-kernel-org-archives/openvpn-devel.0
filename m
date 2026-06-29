Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91592C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZc4YkpuTL5Ws/FJHP981AeIrCqvjHUaG6qpnzVYvYg=; b=Orrc+Eg2QmPOaoGGWig4A2Pyl+
	1VYnCY24w8kVJbAzzXJQSsgO2F4xXS9NQD803P40w748qViVR2BnVPd+uCBEu75hOUtpXrRbltLVJ
	pqyX3lGzoIzY3fvibe8U1e5T1bfRIEV1HCqPamz3+TAw9PqHyTw9MikAnDSjEDrbKL0E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weBFy-0003IF-LI;
	Mon, 29 Jun 2026 12:38:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weBFw-0003Hs-Aj
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:38:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=U7egwjcOGOMQuSPYltcEj8pOb+D/yn5kEn5kDiTowYk=; b=BwnOpyY15IIgPiJjh8jtmpzs3C
 elHWXzicQwF9ajn5cuUjW+4Z60yDhxehv2qjFojMQzS48P9/oJZMexpL6/QWoWZm9ja0eJHc5n46n
 LBEfJ8hxOO78SJgqyt44mkKog1n2T9Qt8tn+8YisYbETCldww0x+0Kxn8bu5NqPkJjlw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U7egwjcOGOMQuSPYltcEj8pOb+D/yn5kEn5kDiTowYk=; b=e
 GLbINnCa+AfrZBPhaMDsRyXYAproPQ4GZNgrMhBa4TR47BtoCpp8nQ66sA5OVS4DX25SpuMBaRYav
 GO5YhTYrUr88Z5Nedqb9icKQzLHS51SW+RicZ9VFDJTb5xr7kZdDRIZD0xm8XsgKFWQPIkOku1m4A
 SLsv6NmmNmem//Ns=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weBFU-0003Nw-MM for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:38:06 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47248615e4dso1547333f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 05:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782736674; x=1783341474; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U7egwjcOGOMQuSPYltcEj8pOb+D/yn5kEn5kDiTowYk=;
 b=R8QLuRMNG0Uo27x3xVZpUlJfmvARutHQCWQx1Yf1lfTRuKUlrS9rEghGlaHVKLgUTc
 aDUFNIms8xsyLoqmCSB9GuHD42VNfvbyUSqMFZMaiNCeOMC1/qbup5gBH6g+0VMl4SVQ
 EC1QjzuB7iDPYqbIA4hQT/dJkYOLen6kL/BvKY/P0uil1KCyIY7iTeFGOkRO9j6rzEXl
 E+MMIlL77f8Om9wamEnpkFl1Q9qtbGp2qEczXjfTo/xExo2Jwvtzj9zYO77jNPi8QhJU
 v0y22h/jF3oaqyjeL+NfW4XP6FXw3EmrOJ4hlKuJ9DZIfdNVrH9vSXBY7HfmSm/BTOMP
 YuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782736674; x=1783341474;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U7egwjcOGOMQuSPYltcEj8pOb+D/yn5kEn5kDiTowYk=;
 b=BL+UzSNnFCU32gvNAkgW5N+Co7Tkyqyw4Ti3ThYOXEWo0at4JOZR+VuFAqN2sL6lRp
 jB8qe/SVtUdidFdqR28mPyo6v2PJuvf7mqak2rryFD5bkQkMzXm4Vo5BLaMl0HgqZD+e
 iZAMcjU8D0ZnMHwEv+Y3RDioXZ/0xRO0Pt1LCuBfm1oPcL+us1arrjFgwQVWQojwNluc
 irGVQ+bDAWv1cxLvupU0nDjXXJKG/g0k/2vqTlksNJ4zB8+Ck/98OTCQ2CLA/V/eBqa4
 v68FlAJNCT354EvLC3aYwZnDecpx7T9jOOyfXpFXaoCXefAG79D42+Xh2MQ19V9SFyN+
 AuKA==
X-Gm-Message-State: AOJu0YyGjnCjZD2nymUe7iO9zaKDalFXhaBY4bOAxaCyiyKnzQ1MB3R4
 UeBw1QgXed7j55Gl4FNfHEmBfjEvfKY3IAWSTIsua1tYGdqCLaxrcW8Gr8Osnu4BX0J+NkxNpG+
 FxcTuuyKx55OsPbI3tuDp4DkTknBENgw7vkmfxnQHuPr0AMyzZ/HYmHPfKH22aOK4zjdEN2QmzG
 tebt77hQ==
X-Gm-Gg: AfdE7cnlZM8oW/CLTrkYRjB595oFidYr07/Hy4NvIUJvMzMpSiZQg/u6uRKS3pnrCZe
 Ee4A/IZlTGAw3K55ojheOdjV9GWxEgUG/8+8mhpMjqVEDmNuK5LJqlr/B9a/u6oi3Ks1Wa5I50Z
 14YPGtEVp06tiduqEC20IusgmctYmcnIWepD2SBwRq4JjlguC4Uo03oZYawZ+tIcC4pqxpRCPTI
 7gIA/ndsUOWW6iFj6bitXgLLVU17lsD9uVv+QrzoK18F3LoGVvtsIUAQXmIU+T9oHBBHrUCX26j
 3d8LGX9/4EWR9OKVUHJvuWfmWBTa4giGI94K/2Fk6pY7BiUGoG1QaimWhgoFnvGEplgcg7Q9pJW
 sx9/MMzP7k/ozvNEQwEONle701TZdLZjvf0/2vnxkqd9SDSd9E1pnRyMYV9nMNQeVoGLPI5kXUT
 cvoItV8YauyH0tVY3vlDiPt4IfjlXX2fiiiqk/8sA1zyKLvbEvVQsLewxeq71GP7BCSsTO70Usa
 RHVqve4OVAtKxpLCjPJVNamNZiw99/CAwKDN4YFRCiyurVu25uVP62J/CEbsplElkbtRvP38rTo
 PPw=
X-Received: by 2002:a5d:5846:0:b0:460:2eee:4e21 with SMTP id
 ffacd0b85a97d-46dbfca2c90mr27032702f8f.17.1782736673434; 
 Mon, 29 Jun 2026 05:37:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f9db29a94sm28712758f8f.22.2026.06.29.05.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:37:53 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 12:37:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
X-Gerrit-Change-Number: 1740
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1740?usp=email>
X-Gerrit-Commit: 837260c57e6dee5b2eb106534d12f05f3e7dbbc0
In-Reply-To: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNjc3ZjQzZmMzZWIwMDUyZjhlODBkOWE3ZjA5OGQzNGFkMDNkZmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c8b7ee0451bfe2dd33a9a142b6d1b519780d38ca-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weBFU-0003Nw-MM
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8265333546087520858=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8265333546087520858==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BEtkrKC0DyY="; charset=UTF-8

--BEtkrKC0DyY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello plaisthos,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1740?usp=3Demail

to look at the new patch set (#=
2)=2E

The following approvals got outdated and were removed:
Code-Review-1=
 by plaisthos


Change subject: buffer: Add buf_read_u64() and buf_write_u6=
4()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer:=
 Add buf_read_u64() and buf_write_u64()

Add 64-bit big-endian buffer acces=
sors alongside the existing 8/16/32-bit
helpers=2E There is no portable 64-=
bit byte-order primitive, so the value is
handled as two big-endian 32-bit =
halves (most significant first)=2E

buf_read_u64() reports success via a bo=
ol out-parameter, mirroring
buf_read_u32(): every 64-bit value is a legal r=
esult, leaving no room for
an in-band sentinel=2E

Change-Id: Ic677f43fc3eb=
0052f8e80d9a7f098d34ad03dfe1
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet=
>
---
M src/openvpn/buffer=2Eh
1 file changed, 32 insertions(+), 0 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/4=
0/1740/2

diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
inde=
x fcc923b=2E=2E1db9367 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvp=
n/buffer=2Eh
@@ -25,6 +25,7 @@
 
 #include "basic=2Eh"
 #include "error=2Eh=
"
+#include "integer=2Eh"
 
 #define BUF_SIZE_MAX 1000000
 
@@ -702,6 +703,=
13 @@
 }
 
 static inline bool
+buf_write_u64(struct buffer *dest, uint64_t=
 data)
+{
+    uint64_t u64 =3D htonll(data);
+    return buf_write(dest, &=
u64, sizeof(uint64_t));
+}
+
+static inline bool
 buf_copy(struct buffer *d=
est, const struct buffer *src)
 {
     return buf_write(dest, BPTR(src), BL=
ENZ(src));
@@ -827,6 +835,30 @@
     }
 }
 
+/* Read a 64-bit big-endian va=
lue (see buf_write_u64())=2E Sets *good to indicate
+ * success, like buf_r=
ead_u32()=2E */
+static inline uint64_t
+buf_read_u64(struct buffer *buf, b=
ool *good)
+{
+    uint64_t ret;
+    if (!buf_read(buf, &ret, sizeof(uint6=
4_t)))
+    {
+        if (good)
+        {
+            *good =3D false;
+=
        }
+        return 0;
+    }
+    else
+    {
+        if (good)
+  =
      {
+            *good =3D true;
+        }
+        return ntohll(ret)=
;
+    }
+}
+
 /** Return true if buffer contents are equal */
 static inli=
ne bool
 buf_equal(const struct buffer *a, const struct buffer *b)

-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a=
7f098d34ad03dfe1
Gerrit-Change-Number: 1740
Gerrit-PatchSet: 2
Gerrit-Owner=
: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: stipa <lstipakov@gmail=2Ecom>

--BEtkrKC0DyY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1740?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">buffer: Add buf_read_u64() and buf_write_u64()<br><br>Add 64-bit=
 big-endian buffer accessors alongside the existing 8/16/32-bit<br>helpers=
=2E There is no portable 64-bit byte-order primitive, so the value is<br>ha=
ndled as two big-endian 32-bit halves (most significant first)=2E<br><br>bu=
f_read_u64() reports success via a bool out-parameter, mirroring<br>buf_rea=
d_u32(): every 64-bit value is a legal result, leaving no room for<br>an in=
-band sentinel=2E<br><br>Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03df=
e1<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src=
/openvpn/buffer=2Eh<br>1 file changed, 32 insertions(+), 0 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/40/1740/2</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Eh b/src/o=
penvpn/buffer=2Eh</span><br><span>index fcc923b=2E=2E1db9367 100644</span><=
br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buf=
fer=2Eh</span><br><span>@@ -25,6 +25,7 @@</span><br><span> </span><br><span=
> #include &quot;basic=2Eh&quot;</span><br><span> #include &quot;error=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;integer=2Eh&quot;</span><br><span> </span><br><span> #define BUF_SIZE_MAX =
1000000</span><br><span> </span><br><span>@@ -702,6 +703,13 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static inline bool</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+buf_write_u64(struct buffer *dest,=
 uint64_t data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t u64 =3D h=
tonll(data);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn buf_write(dest, &amp;u64, sizeof(uint64_t));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static i=
nline bool</span><br><span> buf_copy(struct buffer *dest, const struct buff=
er *src)</span><br><span> {</span><br><span>     return buf_write(dest, BPT=
R(src), BLENZ(src));</span><br><span>@@ -827,6 +835,30 @@</span><br><span> =
    }</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Read a 64-bit big-endian value (see buf_write_u64=
())=2E Sets *good to indicate</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * success, like buf_read_u32()=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static inline uint64_t</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+buf_read_u64(struct buffer *buf, bool *good)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint64_t ret;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!buf_read(buf, &amp;ret, sizeof=
(uint64_t)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (good)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            *good =3D false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (good)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
*good =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 ntohll(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /** Return true if b=
uffer contents are equal */</span><br><span> static inline bool</span><br><=
span> buf_equal(const struct buffer *a, const struct buffer *b)</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1740?usp=3Demail">change 1740</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7=
f098d34ad03dfe1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
740 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@=
gmail=2Ecom&gt; </div>

</body></html>
--BEtkrKC0DyY=--


--===============8265333546087520858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8265333546087520858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8265333546087520858==--

