Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FDBC43602
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=U5u2Zxu1hf4jVfSO5B5dMt301R3BhxrNWD5FMUw8bfw=; b=DMuOhbps29ANEV
	F2ynwnzwfWCyyCXGz4yirsA40HzjHb6OrT68M0nhRS2/zX19TKkHpfSd2GOPJDNOwTbAMhjXANnKJ
	pRMlMgKWk/+y4OWGPBGXkcGXjQm8TCGnctGAuovRAa0e8uLqkmp2G5wLGZmGi1qkwrWLX5LvoLZ9c
	HIw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6tT-0006Vg-5f;
	Mon, 29 Jun 2026 07:59:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6tR-0006VX-1l
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ye1oQAFqjLoVmjl9rA4hmA0I5BSwJYY61OHSx466EPc=; b=mMSZsjjwvfInCTVB1jUeWve9GU
 Qo6dYTHtMB/XxV13gCh69U5Km/pcrC/fH1FV/g0RJUuopgYrD4qf5Nsid7O8dXDYtZVsNr3ugHaz2
 a4U3oZg9RvX3a7YFwU6xFE4qn+S8LvYTlnmwyMzsMSUsNJvip3XDPNNEFsvOs4Rnuk9o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ye1oQAFqjLoVmjl9rA4hmA0I5BSwJYY61OHSx466EPc=; b=f
 gWF6n7lBwlbfUUs4Uaxg67/hC1BeoHPPE4I3HMa9D/u1MY+drQAdN5QbQ2HsNt2Dt/+QIUcvT895Y
 IF2Ch8irHq86rLssSR7yztDujhUNf82DQKCbgBJJ/XQ+Ja5Kh1MRNNQ+6dD5iGCaLWl0wdv3CsC/t
 jze2Zdw/RoHtM0jw=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6tN-0008Ml-CL for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:58:58 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-472493849a3so1042533f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719926; x=1783324726; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ye1oQAFqjLoVmjl9rA4hmA0I5BSwJYY61OHSx466EPc=;
 b=Uvb35Wr0p1/EFdBivFDTHF8EpxukVK9p6WK4R28un3lyRzZ3nuLP7oMXqorSJgz2V6
 nbJEy1QqSDVpeXUQPzlUwI7Qctf8HV6oq1wKaiyqxTIxKeIXD8VbkSgjPN+pu6Ix9bZP
 HHEVDe220x0SmohMoqDPbJ8j+8KzuyPG0RKH1MfcjTfi+D3Z9+WwL01TlQjosrCORF6G
 ucdObJQQZjI5jEXQPQaj3QNDdo766Ed19UD+b0DIvBUZahPfmNybm/DUxtWXmDpBDtCs
 evlKJrAfnLixCveq+yZRFGE//o5TKjEIgVCqZwWoJZa71SDr2QPFrdQ0VJLGSuNQsYFm
 Jndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719926; x=1783324726;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ye1oQAFqjLoVmjl9rA4hmA0I5BSwJYY61OHSx466EPc=;
 b=RVoKzSi/1jy5o7HMgf8TmzPpCvsjYMJnGW3dDA0kjZ9GVGsbpV0IFL/q03yV2KpdCH
 bXRNomhXsNhlJHK7I9D/koNRjqS+qS0PKPBbKtI24noEbttzng50sG8yM/ZKqgvw5CWG
 RGsVIKlDFEupdJb6uYo50ieht9U1yRwENHzqGwT61In3X9iqdVt3rqG4ZSRqs6SUp3Gd
 ZfXj5kabPFrb7TNihoWtSo+9oL82y6s10xb3tVPAxY4RAqG742g1tl2CuiXNgFkJrh4e
 gxl0XjUFKB/ZXr2u21U5y6YQYeBkRJI+kbTAS3ppR9EIpHU0YzoV7ddVRuBDOqf92wiB
 wy2w==
X-Gm-Message-State: AOJu0YyX/cAdsBuOI3aiUMoPQUoJr0PVDqCSIMQ4jH8052flSWnMo1sN
 dfQ3/RNrOuKM07W5JpixRpJeA7+WBz50gKRHiKTmaFcgCrWgLpTNRCMOjx2tBE9czxTH4OPAKbi
 F/m4AxX3t48UMWac0QCAqD9sQQH2gJ1QZPv3PYcytik9NcDj6i7EWwgh/E5BmILCLLWi+2TH1wF
 MsDz2P4Q==
X-Gm-Gg: AfdE7cl7ird1I1Kvq5CuUfPvTz5X5UGCgNLDOGqMuiCMQhbUVSwuBNPckAVv9bFJpz6
 bWxm70UsVlAFlIP2K0ZvsSlGv2GtGoF4czecY2rsB0QYGNOjgkePCb37df16aSjzciYGWEqrH0M
 CFMYaM/MSVPzGln/c41z6wr8dfBfwulTeykOM4kjAg6qQjxgo4ZnbOziiyKrNJSFIDSxq/YfvwB
 U2EA4tFXJyixx8YIlDWuI6exdsksOIewe6gsQifgXslGiE0dgn/wx6fSJtY4jx3ustB/9/DB4Wg
 rvrBpeVrQxdDuBJAbv9p+xiNX68kbB84HgkGIN9+K4HhYW+1DXznhl39rMf105JueBZsTMC5IjO
 CTZaxPacG8+Sp4XSC8k20YPiSvEqXNL8O7CVCv6kxr1A2/AcP1QXDVV9n2mlsMRbJ3NISbb2FlA
 pUc6+hEFKN/SROsvaHrHYiNjNyFLFAVY1vJbbuHyjBC05caNY5nrJohie4mLBOuGA7vEzB3jqf0
 nwCh/ZNMxoDWYRhpop03PU1jEoyciZ0oZiIcmfKfbWVpZGTwVh/49EGsO+k6bRQOmFbp3Re6b95
 Vjk=
X-Received: by 2002:a05:6000:26c1:b0:473:cf28:a23e with SMTP id
 ffacd0b85a97d-473cf28a3f6mr3653751f8f.19.1782719926121; 
 Mon, 29 Jun 2026 00:58:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4705f8ea729sm23681815f8f.0.2026.06.29.00.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:58:45 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:58:45 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
X-Gerrit-Change-Number: 1740
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1740?usp=email>
X-Gerrit-Commit: 4c1d09e3bb0b5db506178a6d091fc08dc8a456ee
References: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNjc3ZjQzZmMzZWIwMDUyZjhlODBkOWE3ZjA5OGQzNGFkMDNkZmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ed836ac05b1b73ba8b39e56299e433414890d432-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6tN-0008Ml-CL
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
Content-Type: multipart/mixed; boundary="===============1830980154155913033=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1830980154155913033==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6IxOz9/hCaY="; charset=UTF-8

--6IxOz9/hCaY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1740?usp=3Demail

to review the following change=2E


Chang=
e subject: buffer: Add buf_read_u64() and buf_write_u64()
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Add buf_read_u64() a=
nd buf_write_u64()

Add 64-bit big-endian buffer accessors alongside the ex=
isting 8/16/32-bit
helpers=2E There is no portable 64-bit byte-order primit=
ive, so the value is
handled as two big-endian 32-bit halves (most signific=
ant first)=2E

buf_read_u64() reports success via a bool out-parameter, mir=
roring
buf_read_u32(): every 64-bit value is a legal result, leaving no roo=
m for
an in-band sentinel=2E

Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34a=
d03dfe1
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/b=
uffer=2Eh
1 file changed, 28 insertions(+), 0 deletions(-)



  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/40/1740/1

diff --git=
 a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index fcc923b=2E=2E57484=
30 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -701=
,6 +701,15 @@
     return buf_write(dest, &u32, sizeof(uint32_t));
 }
 
+/*=
 There is no portable 64-bit byte-order helper, so write the value as two
+=
 * big-endian 32-bit halves (most significant first)=2E */
+static inline b=
ool
+buf_write_u64(struct buffer *dest, uint64_t data)
+{
+    return buf_w=
rite_u32(dest, (uint32_t)(data >> 32))
+           && buf_write_u32(dest, (=
uint32_t)(data & 0xffffffff));
+}
+
 static inline bool
 buf_copy(struct bu=
ffer *dest, const struct buffer *src)
 {
@@ -827,6 +836,25 @@
     }
 }
 
+=
/* Read a 64-bit value written as two big-endian 32-bit halves (see
+ * buf=
_write_u64())=2E Sets *good to indicate success, like buf_read_u32()=2E */
=
+static inline uint64_t
+buf_read_u64(struct buffer *buf, bool *good)
+{
+ =
   bool ok =3D true;
+    uint32_t high =3D buf_read_u32(buf, &ok);
+    ui=
nt32_t low =3D ok ? buf_read_u32(buf, &ok) : 0;
+    if (good)
+    {
+    =
    *good =3D ok;
+    }
+    if (!ok)
+    {
+        return 0;
+    }
+  =
  return ((uint64_t)high << 32) | low;
+}
+
 /** Return true if buffer cont=
ents are equal */
 static inline bool
 buf_equal(const struct buffer *a, co=
nst struct buffer *b)

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1740?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
Gerrit-Change-Number: 1740
Ger=
rit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>

--6IxOz9/hCaY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1740?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">bu=
ffer: Add buf_read_u64() and buf_write_u64()<br><br>Add 64-bit big-endian b=
uffer accessors alongside the existing 8/16/32-bit<br>helpers=2E There is n=
o portable 64-bit byte-order primitive, so the value is<br>handled as two b=
ig-endian 32-bit halves (most significant first)=2E<br><br>buf_read_u64() r=
eports success via a bool out-parameter, mirroring<br>buf_read_u32(): every=
 64-bit value is a legal result, leaving no room for<br>an in-band sentinel=
=2E<br><br>Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/buffe=
r=2Eh<br>1 file changed, 28 insertions(+), 0 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
40/1740/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=
=2Eh</span><br><span>index fcc923b=2E=2E5748430 100644</span><br><span>--- =
a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span=
><br><span>@@ -701,6 +701,15 @@</span><br><span>     return buf_write(dest,=
 &amp;u32, sizeof(uint32_t));</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* There is no portable 64-b=
it byte-order helper, so write the value as two</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * big-endian 32-bit halves (most significant f=
irst)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static i=
nline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_write=
_u64(struct buffer *dest, uint64_t data)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return buf_write_u32(dest, (uint32_t)(data &gt;&gt; 32))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write=
_u32(dest, (uint32_t)(data &amp; 0xffffffff));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> static inline bool</span><br><span> buf_copy(str=
uct buffer *dest, const struct buffer *src)</span><br><span> {</span><br><s=
pan>@@ -827,6 +836,25 @@</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Read a =
64-bit value written as two big-endian 32-bit halves (see</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * buf_write_u64())=2E Sets *good to =
indicate success, like buf_read_u32()=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static inline uint64_t</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+buf_read_u64(struct buffer *buf, bool *good)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool ok =3D true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    uint32_t high =3D buf_read_u32(buf,=
 &amp;ok);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint3=
2_t low =3D ok ? buf_read_u32(buf, &amp;ok) : 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (good)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        *good =3D ok;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!ok)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return ((uint64_t)high &lt;&lt; 32) =
| low;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /** Return tr=
ue if buffer contents are equal */</span><br><span> static inline bool</spa=
n><br><span> buf_equal(const struct buffer *a, const struct buffer *b)</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1740?usp=3Demail">change 1740</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic677f43fc3eb0052f8e=
80d9a7f098d34ad03dfe1 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1740 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--6IxOz9/hCaY=--


--===============1830980154155913033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1830980154155913033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1830980154155913033==--

