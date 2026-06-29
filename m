Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93621C43602
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3fMcJPdfwNAXm/Hx8F68bs+oFFFwyIMXSL1Lg2/T134=; b=h8Z1Lp5vAUMd9F+dJeF0bvU1P6
	ALa4jwS18I+QfqbB2bGoluYRrn1O0QX9p6wnu2NZLR28jMhpcnOTQoXCBfprYH/Fbz6IBfwKukMU6
	Suh2hX3V5rlMpit3pk5a8qrWwBjBRY5SpcfH/10Ob4VfBFEme63EkL6DQeL7L4zSMhG8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6Zj-0004OX-B7;
	Mon, 29 Jun 2026 07:38:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6Zh-0004OP-HT
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:38:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=49rwP/FtReeRH1wQJh6i7AKRiFbd9X+npd5aZdyARn0=; b=Vlo/L0442yNbJobg1amkEYoH1f
 /U49syrN0i/zv8RGSanNUORaJS73UiQBWKy3EWJnRH5AX7zsp96alB5ztvAk52GQWiJuiMwPSGG5k
 hRhwZrvcPbhtk2zKjVP/PElwp5zVRnwp0IbqkADHeS+b0mZ3TiZRwemNg1hAtmL1H0EY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=49rwP/FtReeRH1wQJh6i7AKRiFbd9X+npd5aZdyARn0=; b=H
 prLNRrtQxWnAfN9R9UBuPzOI9rA8gER5QcVgg3dDsibOfUUKyYuKLZJPLxqbgv8GKp8dIdEXbzry6
 ZjkE4L/FwNeFJzU8/L4bHml5gj0gOxQnivn8gk+AzOVl6bPorG6YfPnWT6UYzIBJ+JJV5btACdo3c
 of4Bn2caizcFZpLc=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6Zd-00076F-9I for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:38:38 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-46066e640easo1544960f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782718702; x=1783323502; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=49rwP/FtReeRH1wQJh6i7AKRiFbd9X+npd5aZdyARn0=;
 b=gdZ/slQer766yHzCb/sCWdD6LnQ8WUYoMpJMemsH4OOv4GdvvE4oKlmaA2qOsU3Or2
 6L1DXSz2yNTmI6xWm+C2KIoJiIE+Kn5RFAhccegjEfU5nbZHbEZ9nhva7Pdq5EvViq/j
 ZJk5bTm6dwvnHGOCaiBVosJUuRIJjUhUD9nEdzP8UtQIuUS5J7TuGzrG9O1LCg3KoVfB
 lKa8uG0DnsEbpyfwcUQnWPcXH7Wg4O6F87vaJx9udnj/Vkf/y36/TBiqRrZK0JJhKUgi
 KRJJt5bDyiwHCcNUSG7NVKK8xIkTLnZosyWw2O9LK5joHtyHVV4C53aZB/hVbvqdIx+W
 3S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782718702; x=1783323502;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=49rwP/FtReeRH1wQJh6i7AKRiFbd9X+npd5aZdyARn0=;
 b=agJ8ro9Z6LAmkaUziw/GiZm/y7XYZCVXSLLgBe5P/6xKnoiiWummTVm43/MNw1lPxE
 1lzxo+mncg6EobrE2O7XOPWMrvT95sGiJu41oLPwVEYXe9s4DXDaaTKBhFO0NoFtUn36
 WIohInxQuELp/0nRXRIhzP1/9cIESYg3qb2mHUzSuMp7zfpwZ2FY9NlOQXTLBrMqRZsa
 GWjZdLmgodD9CNPqKmmvTz0zNTGp20pY0ZGF/gV0zuRhdKy21WJJsLTT1UJvuXW3/J0p
 dBT6Jb+nqMyHHxof2ppC3/LzIr/8TMam2isAf72Bt536GSAibuLllkXKXwiyFof0rKGe
 e4bw==
X-Gm-Message-State: AOJu0YzX96Gi+jI2ux/5uWYswq6M4AfEebEcoP+U8tEHFTGo7q5WtDtI
 +7eq3GR+glYK+nUChfMbwQKwISqCX0ywaNNQ3jwWzbi3Vma4J4HootLJchqYygrJqDZ0tl3QBHv
 UxQn3wxjn+6Tc/c3SsNqzWXijJlhWHfiluPxMz41/Gi/cSH2UfjjOm3lClAriJ5TX93d/
X-Gm-Gg: AfdE7cn/9zRjmPBlMq5dj8bULq4NNHj94AlzMhFSlfTTSNVmmSqbN8ug5UeayIKpYvi
 gvOdGCn5Al0UL4wkwX6oz+liFS5pLvT3MlMcJFKsoesPphSyNKNYUisfPrZgr8AAcJ44qSddT58
 3aVBINbEGpTPNoYFQAKq0+HYZEu5OEb/MgbRSM47iVPI7XxsRv7372LLAkvWLDauMGrXEeVrgX+
 rajsdXE5Za43Jb1z02KIMjcUX/CiCVkeWekXup++0TH5EG5FKkxpPsoOYaZ687RYkpdwTO+mPnT
 3c1ygYGDHVYc52FTxHPQ/qFXI6m30ekyEtLkgav6i5WpRF2zMNKuvo1GvmRrpTdolhLzQ4w6Oae
 ffLc/Z13uu8736uF+H298JpIjXv1sm5iqRbHLrOLw8FK2/ynbgVbQoCjwqOQskiN8pXNCSLQKqX
 NVmNf/V8zCKrKRm7XiiHISDNGBN2RTgTCnwhr3Hj15R/1fWU69RvwdOhCkycni+U6tr/lyTy+eg
 /ndQgtLWqVOsH6oD4aAhK0OstKB3X00uTDhnVH+s5f6A/vNvRR84IpQC/E4hFY3Jmb8luTxTOnp
 Kew=
X-Received: by 2002:adf:e013:0:20b0:46d:d693:88cb with SMTP id
 ffacd0b85a97d-46dd69388f3mr17443478f8f.46.1782718701840; 
 Mon, 29 Jun 2026 00:38:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-472e8037a37sm14269221f8f.19.2026.06.29.00.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:38:21 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:38:19 +0000
To: d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>,
 stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938
X-Gerrit-Change-Number: 1730
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1730?usp=email>
X-Gerrit-Commit: 294d5ebb32e632c756290cb7b1de3df29a516154
In-Reply-To: <gerrit.1782264341000.I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938@gerrit.openvpn.net>
References: <gerrit.1782264341000.I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMjY0MzQxMDAwLkk4YzY3NjMzZWQzZDgyYTZkYzUwZmJkOGZhMWFmMmM1MGZjNDVkOTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <507bf1922a0ff0472ed1d411148b4bffe91a3913-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6Zd-00076F-9I
Subject: [Openvpn-devel] [L] Change in openvpn[master]: openvpnserv: rework
 ConvertItfDnsDomains and tests
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3690581332297437021=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3690581332297437021==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y1w7VGLLvgU="; charset=UTF-8

--Y1w7VGLLvgU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 d12fk=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1730?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by stip=
a


Change subject: openvpnserv: rework ConvertItfDnsDomains and tests
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: rew=
ork ConvertItfDnsDomains and tests

Since there were issues with in-place m=
odification of the buffer
repeatedly, re-implement ConvertItfDnsDomains() t=
o use a internal
temporary buffer to prevent use of memmove and the length =
calculations
that come with it=2E Code should be easier to grasp since we'r=
e dealing
with one set of lengths (WCHARs) instead of two (WCHARs + octets)=
 now=2E

The unit tests did not actually test the MULTI_SZs correctly, fixe=
d
that and also added some more tests to cover more scenarios=2E

This was =
initially reported as a security vulnerability, as the previous
code could =
be tricked into overreading a buffer and accessing undefined
memory - but w=
e decided against assigning a CVE ID because the data read
is subsequently =
never leaked anywhere, and it was not possible to trigger
a crash, so "just=
 a bug, no security implications"=2E

Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=
=A5 (@AiPy) (www=2Eaipyaipy=2Ecom)
Github: OpenVPN/openvpn-private-issues#1=
22
Github: OpenVPN/openvpn-private-issues#126

Change-Id: I8c67633ed3d82a6d=
c50fbd8fa1af2c50fc45d938
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=
=2Enet>
Acked-by: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1730
Message-Id: <20260628130255=2E25452=
-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg37337=2Ehtml
Signed-off-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
M tests/uni=
t_tests/openvpnserv/test_openvpnserv=2Ec
2 files changed, 150 insertions(+)=
, 101 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/30/1730/6

diff --git a/src/openvpnserv/interactive=2Ec b/src/=
openvpnserv/interactive=2Ec
index 788a578=2E=2E516a469 100644
--- a/src/ope=
nvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -33,6 +33=
,7 @@
 #include <shellapi=2Eh>
 #include <mstcpip=2Eh>
 #include <inttypes=
=2Eh>
+#include <malloc=2Eh>
 
 #include <versionhelpers=2Eh>
 
@@ -2130,22=
 +2131,20 @@
 static BOOL
 ListContainsDomain(PCWSTR list, PCWSTR domain, s=
ize_t len)
 {
-    PCWSTR match =3D list;
-    while (match)
+    PCWSTR en=
try =3D list;
+    while (entry && *entry)
     {
-        match =3D wcsstr=
(match, domain);
-        if (!match)
+        PCWSTR comma =3D wcschr(entr=
y, L',');
+        size_t entry_len =3D comma ? (size_t)(comma - entry) : w=
cslen(entry);
+        if (entry_len =3D=3D len && wcsncmp(entry, domain, l=
en) =3D=3D 0)
         {
-            /* Domain has not matched */
-       =
     break;
-        }
-        if ((match =3D=3D list || *(match - 1) =3D=
=3D ',')
-            && (*(match + len) =3D=3D ',' || *(match + len) =3D=
=3D '\0'))
-        {
-            /* Domain has matched fully */
         =
    return TRUE;
         }
-        match +=3D len;
+        if (!comma)
+=
        {
+            break;
+        }
+        entry =3D comma + 1;
    =
 }
     return FALSE;
 }
@@ -2159,95 +2158,94 @@
  * are invalid=2E
  * Not=
e that domains are deleted from the string if they match a search domain=2E=

  *
- * @param[in]     search_domains  optional list of search domains
+ *=
 @param[in]     search_domains  optional string of comma separated search d=
omains
  * @param[in,out] domains         buffer that contains the input co=
mma-separated
  *                                string and will contain th=
e MULTI_SZ output string
  * @param[in,out] size            pointer to size=
 of the input string in bytes=2E Will be
  *                               =
 set to the size of the string returned, including
  *                     =
           the terminating zeros or 0=2E
- * @param[in]     buf_size       =
 size of the \p domains buffer
+ * @param[in]     capacity        capacity =
of the \p domains buffer in bytes
  *
- * @return LSTATUS NO_ERROR if the d=
omain suffix(es) were read successfully,
- *         ERROR_FILE_NOT_FOUND i=
f no domain was found for the interface,
- *         ERROR_MORE_DATA if the=
 list did not fit into the buffer
+ * @return LSTATUS NO_ERROR if all domai=
n suffix(es) were converted successfully,
+ *         ERROR_FILE_NOT_FOUND =
if no domain was left after the conversion,
+ *         ERROR_MORE_DATA if =
not all converted domains did fit into the buffer=2E
+ *         ERROR_OUTO=
FMEMORY if the temporary buffer could not be allocated=2E
  */
 static LSTA=
TUS
-ConvertItfDnsDomains(PCWSTR search_domains, PWSTR domains, PDWORD size=
, const DWORD buf_size)
+ConvertItfDnsDomains(PCWSTR search_domains, PWSTR =
domains, PDWORD size, const DWORD capacity)
 {
-    const DWORD glyph_size =
=3D sizeof(*domains);
-    const DWORD buf_len =3D buf_size / glyph_size;
+=
    const size_t glyph_size =3D sizeof(*domains);
+    const size_t max_len=
 =3D (size_t)capacity / glyph_size;
 
-    /*
-     * Found domain(s), now =
convert them:
-     *   - prefix each domain with a dot
-     *   - convert=
 comma separated list to MULTI_SZ
-     */
-    PWCHAR pos =3D domains;
-  =
  while (TRUE)
+    /* Space required for leading dot and two terminating z=
eros */
+    const size_t dot_len =3D 1;
+    const size_t term_len =3D 2;
=
+
+    LSTATUS ret =3D NO_ERROR;
+    size_t tmp_len =3D 0;
+    WCHAR *tmp=
 =3D malloc(capacity);
+    if (tmp =3D=3D NULL)
     {
-        /* Termina=
te the domain at the next comma */
-        PWCHAR comma =3D wcschr(pos, ',=
');
-        if (comma)
+        ret =3D ERROR_OUTOFMEMORY;
+        goto d=
one;
+    }
+
+    PWCHAR tmp_pos =3D tmp;
+    PCWCHAR domain =3D domains;=

+
+    while (domain && *domain)
+    {
+        PWCHAR comma =3D wcschr(d=
omain, L',');
+        size_t domain_len =3D comma ? (size_t)(comma - domai=
n) : wcslen(domain);
+
+        if (ListContainsDomain(search_domains, doma=
in, domain_len))
         {
-            *comma =3D '\0';
+            /* S=
kip this domain */
+            domain =3D comma ? comma + 1 : domain + dom=
ain_len;
+            continue;
         }
 
-        DWORD domain_len =3D =
(DWORD)wcslen(pos);
-        DWORD domain_size =3D domain_len * glyph_size;=

-        DWORD converted_size =3D (DWORD)(pos - domains) * glyph_size;
-
-=
        /* Ignore itf domains which match a pushed search domain */
-      =
  if (ListContainsDomain(search_domains, pos, domain_len))
-        {
-    =
        if (comma)
-            {
-                /* Overwrite the ignored=
 domain with remaining one(s) */
-                memmove(pos, comma + 1, b=
uf_size - converted_size);
-                *size -=3D domain_size + glyph_=
size;
-                continue;
-            }
-            else
-        =
    {
-                /* This was the last domain */
-                *pos=
 =3D '\0';
-                *size -=3D domain_size;
-                return=
 wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;
-            }
-       =
 }
-
-        /* Add space for the leading dot */
-        domain_len +=3D =
1;
-        domain_size +=3D glyph_size;
-
-        /* Space for the termin=
ating zeros */
-        const DWORD extra_size =3D 2 * glyph_size;
-
      =
   /* Check for enough space to convert this domain */
-        if (convert=
ed_size + domain_size + extra_size > buf_size)
+        if (tmp_len + dot_l=
en + domain_len + term_len > max_len)
         {
             /* Domain doe=
sn't fit, bad luck if it's the first one */
-            *pos =3D '\0';
-  =
          *size =3D converted_size =3D=3D 0 ? 0 : converted_size + glyph_si=
ze;
-            return ERROR_MORE_DATA;
+            *tmp_pos =3D L'\0';
+=
            if (tmp_len > 0)
+            {
+                tmp_len +=3D 1=
;
+            }
+            ret =3D ERROR_MORE_DATA;
+            goto do=
ne;
         }
 
-        /* Prefix domain at pos with the dot */
-        =
memmove(pos + 1, pos, buf_size - converted_size - glyph_size);
-        dom=
ains[buf_len - 1] =3D '\0';
-        *pos =3D '=2E';
-        *size +=3D gl=
yph_size;
+        /* Write leading dot and domain into tmp buffer */
+    =
    *tmp_pos++ =3D L'=2E';
+        wcsncpy(tmp_pos, domain, domain_len);
+=
        tmp_pos +=3D domain_len;
+        *tmp_pos++ =3D L'\0';
+        tm=
p_len +=3D dot_len + domain_len + 1;
 
-        if (!comma)
-        {
-   =
         /* Conversion is done */
-            *(pos + domain_len) =3D '\0'=
;
-            *size +=3D glyph_size;
-            return NO_ERROR;
-      =
  }
-
-        /* Comma pos is now +1 after adding leading dot */
-        =
pos =3D comma + 2;
+        domain =3D comma ? comma + 1 : domain + domain_=
len;
     }
+
+    if (tmp_len =3D=3D 0)
+    {
+        ret =3D ERROR_FILE=
_NOT_FOUND;
+        goto done;
+    }
+
+    /* REG_MULTI_SZ second zero t=
erminator */
+    *tmp_pos =3D L'\0';
+    tmp_len +=3D 1;
+
+done:
+    if=
 (tmp)
+    {
+        wmemcpy(domains, tmp, tmp_len);
+        free(tmp);
=
+    }
+    *size =3D (DWORD)(tmp_len * glyph_size);
+    return ret;
 }
 
=
 /**
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec b/tests=
/unit_tests/openvpnserv/test_openvpnserv=2Ec
index 45096a1=2E=2Ee432f44 100=
644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
+++ b/tests/uni=
t_tests/openvpnserv/test_openvpnserv=2Ec
@@ -48,58 +48,109 @@
     assert_t=
rue(ListContainsDomain(domain, domain, domain_len));
     assert_true(ListC=
ontainsDomain(L"openvpn=2Ecom,openvpn=2Enet", domain, domain_len));
     as=
sert_true(ListContainsDomain(L"openvpn=2Enet,openvpn=2Ecom", domain, domain=
_len));
+    assert_true(ListContainsDomain(L"openvpn=2Eorg,openvpn=2Enet,o=
penvpn=2Ecom", domain, domain_len));
 
     assert_false(ListContainsDomain=
(L"openvpn=2Ecom", domain, domain_len));
     assert_false(ListContainsDoma=
in(L"internal=2Eopenvpn=2Enet", domain, domain_len));
+    assert_false(Lis=
tContainsDomain(L"openvpn=2Ecom,internal=2Eopenvpn=2Enet", domain, domain_l=
en));
+    assert_false(ListContainsDomain(L"internal=2Eopenvpn=2Enet,openv=
pn=2Ecom", domain, domain_len));
 }
 
 #define BUF_SIZE 64
 static void
 te=
st_convert_itf_dns_domains(void **state)
 {
-    DWORD size, orig_size, len=
, res_len;
+    DWORD size, len;
     LSTATUS err;
     const DWORD glyph_s=
ize =3D sizeof(wchar_t);
 
+    /* Remove the domain from a single-entry li=
st */
+    wchar_t domains_0[BUF_SIZE] =3D L"openvpn=2Ecom";
+    len =3D (=
DWORD)wcslen(domains_0) + 1;
+    size =3D len * glyph_size;
+    err =3D C=
onvertItfDnsDomains(L"openvpn=2Ecom", domains_0, &size, sizeof(domains_0));=

+    assert_int_equal(size, 0);
+    assert_int_equal(err, ERROR_FILE_NOT_=
FOUND);
+
+    /* Remove no domain from a single-entry list */
     wchar_t=
 domains_1[BUF_SIZE] =3D L"openvpn=2Ecom";
     len =3D (DWORD)wcslen(domai=
ns_1) + 1;
-    size =3D orig_size =3D len * glyph_size;
-    wchar_t domai=
ns_1_res[BUF_SIZE] =3D L"=2Eopenvpn=2Ecom";
-    res_len =3D len + 2; /* ad=
ds =2E and \0 */
-    err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domain=
s_1, &size, BUF_SIZE);
+    size =3D len * glyph_size;
+    wchar_t domains=
_1_res[] =3D L"=2Eopenvpn=2Ecom\0";
+    err =3D ConvertItfDnsDomains(L"ope=
nvpn=2Enet", domains_1, &size, sizeof(domains_1));
     assert_memory_equal=
(domains_1, domains_1_res, size);
-    assert_int_equal(size, res_len * gly=
ph_size);
+    assert_int_equal(size, sizeof(domains_1_res));
     assert_i=
nt_equal(err, NO_ERROR);
 
+    /* Remove the second domain from a two-entr=
y list */
     wchar_t domains_2[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Ene=
t";
     len =3D (DWORD)wcslen(domains_2) + 1;
-    size =3D orig_size =3D =
len * glyph_size;
-    wchar_t domains_2_res[BUF_SIZE] =3D L"=2Eopenvpn=2Ec=
om";
-    res_len =3D (DWORD)wcslen(domains_2_res) + 2;
-    err =3D Conver=
tItfDnsDomains(L"openvpn=2Enet", domains_2, &size, BUF_SIZE);
+    size =3D=
 len * glyph_size;
+    wchar_t domains_2_res[] =3D L"=2Eopenvpn=2Ecom\0";
=
+    err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_2, &size, sizeo=
f(domains_2));
     assert_memory_equal(domains_2, domains_2_res, size);
- =
   assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(size=
, sizeof(domains_2_res));
     assert_int_equal(err, NO_ERROR);
 
+    /* R=
emove the first domain from a two-entry list */
     wchar_t domains_3[BUF_=
SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet";
     len =3D (DWORD)wcslen(domain=
s_3) + 1;
-    size =3D orig_size =3D len * glyph_size;
-    wchar_t domain=
s_3_res[BUF_SIZE] =3D L"=2Eopenvpn=2Enet";
-    res_len =3D (DWORD)wcslen(d=
omains_3_res) + 2;
-    err =3D ConvertItfDnsDomains(L"openvpn=2Ecom", doma=
ins_3, &size, BUF_SIZE);
+    size =3D len * glyph_size;
+    wchar_t domai=
ns_3_res[] =3D L"=2Eopenvpn=2Enet\0";
+    err =3D ConvertItfDnsDomains(L"o=
penvpn=2Ecom", domains_3, &size, sizeof(domains_3));
     assert_memory_equ=
al(domains_3, domains_3_res, size);
-    assert_int_equal(size, res_len * g=
lyph_size);
+    assert_int_equal(size, sizeof(domains_3_res));
     assert=
_int_equal(err, NO_ERROR);
 
+    /* Remove no domain from a two-entry list=
 */
     wchar_t domains_4[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet";
  =
   len =3D (DWORD)wcslen(domains_4) + 1;
-    size =3D orig_size =3D len * =
glyph_size;
-    wchar_t domains_4_res[BUF_SIZE] =3D L"=2Eopenvpn=2Ecom\0=
=2Eopenvpn=2Enet";
-    res_len =3D len + 3; /* adds two =2E and one \0 */
=
-    err =3D ConvertItfDnsDomains(NULL, domains_4, &size, BUF_SIZE);
+    s=
ize =3D len * glyph_size;
+    wchar_t domains_4_res[] =3D L"=2Eopenvpn=2Ec=
om\0=2Eopenvpn=2Enet\0";
+    err =3D ConvertItfDnsDomains(NULL, domains_4,=
 &size, sizeof(domains_4));
     assert_memory_equal(domains_4, domains_4_r=
es, size);
-    assert_int_equal(size, res_len * glyph_size);
+    assert_i=
nt_equal(size, sizeof(domains_4_res));
     assert_int_equal(err, NO_ERROR)=
;
+
+    /* Remove the first domain from a three-entry list */
+    wchar_t=
 domains_5[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg";
+   =
 len =3D (DWORD)wcslen(domains_5) + 1;
+    size =3D len * glyph_size;
+   =
 wchar_t domains_5_res[] =3D L"=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0";
+    =
err =3D ConvertItfDnsDomains(L"openvpn=2Ecom", domains_5, &size, sizeof(dom=
ains_5));
+    assert_memory_equal(domains_5, domains_5_res, size);
+    as=
sert_int_equal(size, sizeof(domains_5_res));
+    assert_int_equal(err, NO_=
ERROR);
+
+    /* Remove the middle domain from a three-entry list */
+    =
wchar_t domains_6[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg=
";
+    len =3D (DWORD)wcslen(domains_6) + 1;
+    size =3D len * glyph_siz=
e;
+    wchar_t domains_6_res[] =3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Eorg\0"=
;
+    err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_6, &size, siz=
eof(domains_6));
+    assert_memory_equal(domains_6, domains_6_res, size);
=
+    assert_int_equal(size, sizeof(domains_6_res));
+    assert_int_equal(e=
rr, NO_ERROR);
+
+    /* Remove the last domain from a three-entry list */
=
+    wchar_t domains_7[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=
=2Eorg";
+    len =3D (DWORD)wcslen(domains_7) + 1;
+    size =3D len * gly=
ph_size;
+    wchar_t domains_7_res[] =3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2E=
net\0";
+    err =3D ConvertItfDnsDomains(L"openvpn=2Eorg", domains_7, &siz=
e, sizeof(domains_7));
+    assert_memory_equal(domains_7, domains_7_res, s=
ize);
+    assert_int_equal(size, sizeof(domains_7_res));
+    assert_int_e=
qual(err, NO_ERROR);
+
+    /* Remove the last domain from a four-entry lis=
t because of size constraints*/
+    wchar_t domains_8[BUF_SIZE] =3D L"open=
vpn=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-ende-noch-eine-lange=2Ede";
+    l=
en =3D (DWORD)wcslen(domains_8) + 1;
+    size =3D len * glyph_size;
+    w=
char_t domains_8_res[] =3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0=2Eopenvpn=
=2Eorg\0";
+    err =3D ConvertItfDnsDomains(NULL, domains_8, &size, sizeof=
(domains_8));
+    assert_memory_equal(domains_8, domains_8_res, size);
+  =
  assert_int_equal(size, sizeof(domains_8_res));
+    assert_int_equal(err,=
 ERROR_MORE_DATA);
 }
 
 int

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1730?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938
Gerrit-Change-Number:=
 1730
Gerrit-PatchSet: 6
Gerrit-Owner: d12fk <heiko@openvpn=2Enet>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: stipa <lst=
ipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--Y1w7VGLLvgU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by d12fk=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1730?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by stipa</p><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">openvpnserv: rework ConvertItfDns=
Domains and tests<br><br>Since there were issues with in-place modification=
 of the buffer<br>repeatedly, re-implement ConvertItfDnsDomains() to use a =
internal<br>temporary buffer to prevent use of memmove and the length calcu=
lations<br>that come with it=2E Code should be easier to grasp since we&#39=
;re dealing<br>with one set of lengths (WCHARs) instead of two (WCHARs + oc=
tets) now=2E<br><br>The unit tests did not actually test the MULTI_SZs corr=
ectly, fixed<br>that and also added some more tests to cover more scenarios=
=2E<br><br>This was initially reported as a security vulnerability, as the =
previous<br>code could be tricked into overreading a buffer and accessing u=
ndefined<br>memory - but we decided against assigning a CVE ID because the =
data read<br>is subsequently never leaked anywhere, and it was not possible=
 to trigger<br>a crash, so &quot;just a bug, no security implications&quot;=
=2E<br><br>Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (@AiPy) (www=2Eaipyaipy=
=2Ecom)<br>Github: OpenVPN/openvpn-private-issues#122<br>Github: OpenVPN/op=
envpn-private-issues#126<br><br>Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c5=
0fc45d938<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;=
<br>Acked-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1730<br>Message-Id: &lt;20260628130=
255=2E25452-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37337=2Ehtml<br>Signed-o=
ff-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn=
serv/interactive=2Ec<br>M tests/unit_tests/openvpnserv/test_openvpnserv=2Ec=
<br>2 files changed, 150 insertions(+), 101 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/3=
0/1730/6</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpn=
serv/interactive=2Ec</span><br><span>index 788a578=2E=2E516a469 100644</spa=
n><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src=
/openvpnserv/interactive=2Ec</span><br><span>@@ -33,6 +33,7 @@</span><br><s=
pan> #include &lt;shellapi=2Eh&gt;</span><br><span> #include &lt;mstcpip=2E=
h&gt;</span><br><span> #include &lt;inttypes=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;malloc=2Eh&gt;</span><br><sp=
an> </span><br><span> #include &lt;versionhelpers=2Eh&gt;</span><br><span> =
</span><br><span>@@ -2130,22 +2131,20 @@</span><br><span> static BOOL</span=
><br><span> ListContainsDomain(PCWSTR list, PCWSTR domain, size_t len)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    PCW=
STR match =3D list;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  while (match)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
PCWSTR entry =3D list;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    while (entry &amp;&amp; *entry)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        match =3D wcsstr(match, dom=
ain);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!mat=
ch)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        PCWSTR c=
omma =3D wcschr(entry, L&#39;,&#39;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        size_t entry_len =3D comma ? (size_t)(comma - ent=
ry) : wcslen(entry);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (entry_len =3D=3D len &amp;&amp; wcsncmp(entry, domain, len) =
=3D=3D 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            /* Domain has not matched */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if ((match =3D=3D list || *(match - 1) =3D=3D &=
#39;,&#39;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  &amp;&amp; (*(match + len) =3D=3D &#39;,&#39; || *(match + len) =3D=3D &#=
39;\0&#39;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Domain=
 has matched fully */</span><br><span>             return TRUE;</span><br><=
span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  match +=3D len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (!comma)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        entry =3D comma=
 + 1;</span><br><span>     }</span><br><span>     return FALSE;</span><br><=
span> }</span><br><span>@@ -2159,95 +2158,94 @@</span><br><span>  * are inv=
alid=2E</span><br><span>  * Note that domains are deleted from the string i=
f they match a search domain=2E</span><br><span>  *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param[in]     search_domains  optional =
list of search domains</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param[in]     search_domains  optional string of comma separated sea=
rch domains</span><br><span>  * @param[in,out] domains         buffer that =
contains the input comma-separated</span><br><span>  *                     =
           string and will contain the MULTI_SZ output string</span><br><sp=
an>  * @param[in,out] size            pointer to size of the input string i=
n bytes=2E Will be</span><br><span>  *                                set t=
o the size of the string returned, including</span><br><span>  *           =
                     the terminating zeros or 0=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * @param[in]     buf_size        size of the =
\p domains buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param[in]     capacity        capacity of the \p domains buffer in bytes<=
/span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 @return LSTATUS NO_ERROR if the domain suffix(es) were read successfully,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *         ERROR_FILE_=
NOT_FOUND if no domain was found for the interface,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *         ERROR_MORE_DATA if the list did =
not fit into the buffer</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @return LSTATUS NO_ERROR if all domain suffix(es) were converted suc=
cessfully,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
  ERROR_FILE_NOT_FOUND if no domain was left after the conversion,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *         ERROR_MORE_DATA i=
f not all converted domains did fit into the buffer=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *         ERROR_OUTOFMEMORY if the temp=
orary buffer could not be allocated=2E</span><br><span>  */</span><br><span=
> static LSTATUS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Conve=
rtItfDnsDomains(PCWSTR search_domains, PWSTR domains, PDWORD size, const DW=
ORD buf_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Conver=
tItfDnsDomains(PCWSTR search_domains, PWSTR domains, PDWORD size, const DWO=
RD capacity)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    const DWORD glyph_size =3D sizeof(*domains);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    const DWORD buf_len =3D buf_size /=
 glyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st size_t glyph_size =3D sizeof(*domains);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const size_t max_len =3D (size_t)capacity / glyp=
h_size;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Foun=
d domain(s), now convert them:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-     *   - prefix each domain with a dot</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     *   - convert comma separated list to MULT=
I_SZ</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    PWCHAR pos =3D domains;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (TRUE)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Space required for le=
ading dot and two terminating zeros */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const size_t dot_len =3D 1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const size_t term_len =3D 2;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    LSTATUS ret =3D NO_ERROR;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    size_t tmp_len =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    WCHAR *tmp =3D malloc(capacity=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tmp =3D=
=3D NULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* Terminate the domain at the next comma */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        PWCHAR comma =3D wcschr(p=
os, &#39;,&#39;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (comma)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   ret =3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        goto done;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    PWCHAR tmp_pos =3D t=
mp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PCWCHAR doma=
in =3D domains;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (domain &amp;=
&amp; *domain)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        PWCHAR comm=
a =3D wcschr(domain, L&#39;,&#39;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        size_t domain_len =3D comma ? (size_t)(comma - doma=
in) : wcslen(domain);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ListC=
ontainsDomain(search_domains, domain, domain_len))</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *comma =
=3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          /* Skip this domain */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            domain =3D comma ? comma + 1 : domain + domain_len=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            contin=
ue;</span><br><span>         }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        DWORD domain_len =3D (DWORD)wcslen(pos);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        DWORD domain_=
size =3D domain_len * glyph_size;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        DWORD converted_size =3D (DWORD)(pos - domains) * glyph=
_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        /* Ignore itf domains which =
match a pushed search domain */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (ListContainsDomain(search_domains, pos, domain_len))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (comma)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                /* Overwrite the ignored =
domain with remaining one(s) */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                memmove(pos, comma + 1, buf_size - converted_size=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                *si=
ze -=3D domain_size + glyph_size;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                continue;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           /* This was the last domain */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                *pos =3D &#39;\0&#39;;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                *size -=3D domain_size=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                retu=
rn wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* Add space for the leading dot */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        domain_len +=3D 1;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        domain_size +=3D glyph_size;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        /* Space for the terminating zeros */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        const DWORD extra_size =3D 2 * =
glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span>         /* Check for enough space to convert this domain */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (converted_size + =
domain_size + extra_size &gt; buf_size)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (tmp_len + dot_len + domain_len + term_len &=
gt; max_len)</span><br><span>         {</span><br><span>             /* Dom=
ain doesn&#39;t fit, bad luck if it&#39;s the first one */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            *pos =3D &#39;\0&#39;;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            *size =3D con=
verted_size =3D=3D 0 ? 0 : converted_size + glyph_size;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            return ERROR_MORE_DATA;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            *tmp_pos =3D =
L&#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (tmp_len &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                tmp_len +=3D 1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            ret =3D ERROR_MORE_DATA;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            goto done;</span><br><span>         }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   /* Prefix domain at pos with the dot */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        memmove(pos + 1, pos, buf_size - converted_siz=
e - glyph_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   domains[buf_len - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        *pos =3D &#39;=2E&#39;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        *size +=3D glyph_size;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* Write leading dot and=
 domain into tmp buffer */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        *tmp_pos++ =3D L&#39;=2E&#39;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        wcsncpy(tmp_pos, domain, domain_len);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        tmp_pos +=3D do=
main_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *t=
mp_pos++ =3D L&#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        tmp_len +=3D dot_len + domain_len + 1;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!comma)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            /* Conversion is done */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *(pos + dom=
ain_len) =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            *size +=3D glyph_size;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            return NO_ERROR;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
/* Comma pos is now +1 after adding leading dot */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        pos =3D comma + 2;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        domain =3D comma ? comma + 1 : =
domain + domain_len;</span><br><span>     }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (tmp_len =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     ret =3D ERROR_FILE_NOT_FOUND;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        goto done;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* REG_MULTI_SZ=
 second zero terminator */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    *tmp_pos =3D L&#39;\0&#39;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    tmp_len +=3D 1;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tmp)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        wmemcpy(domains, tmp, tmp_l=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(tm=
p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    *size =3D (DWORD)(tmp_len =
* glyph_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn ret;</span><br><span> }</span><br><span> </span><br><span> /**</span>=
<br><span>diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec b/=
tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>index 450=
96a1=2E=2Ee432f44 100644</span><br><span>--- a/tests/unit_tests/openvpnserv=
/test_openvpnserv=2Ec</span><br><span>+++ b/tests/unit_tests/openvpnserv/te=
st_openvpnserv=2Ec</span><br><span>@@ -48,58 +48,109 @@</span><br><span>   =
  assert_true(ListContainsDomain(domain, domain, domain_len));</span><br><s=
pan>     assert_true(ListContainsDomain(L&quot;openvpn=2Ecom,openvpn=2Enet&=
quot;, domain, domain_len));</span><br><span>     assert_true(ListContainsD=
omain(L&quot;openvpn=2Enet,openvpn=2Ecom&quot;, domain, domain_len));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ListConta=
insDomain(L&quot;openvpn=2Eorg,openvpn=2Enet,openvpn=2Ecom&quot;, domain, d=
omain_len));</span><br><span> </span><br><span>     assert_false(ListContai=
nsDomain(L&quot;openvpn=2Ecom&quot;, domain, domain_len));</span><br><span>=
     assert_false(ListContainsDomain(L&quot;internal=2Eopenvpn=2Enet&quot;,=
 domain, domain_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_false(ListContainsDomain(L&quot;openvpn=2Ecom,internal=2Eopen=
vpn=2Enet&quot;, domain, domain_len));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_false(ListContainsDomain(L&quot;internal=2Eop=
envpn=2Enet,openvpn=2Ecom&quot;, domain, domain_len));</span><br><span> }</=
span><br><span> </span><br><span> #define BUF_SIZE 64</span><br><span> stat=
ic void</span><br><span> test_convert_itf_dns_domains(void **state)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD =
size, orig_size, len, res_len;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    DWORD size, len;</span><br><span>     LSTATUS err;</span><br=
><span>     const DWORD glyph_size =3D sizeof(wchar_t);</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Remove the dom=
ain from a single-entry list */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    wchar_t domains_0[BUF_SIZE] =3D L&quot;openvpn=2Ecom&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    len =3D (DWORD)=
wcslen(domains_0) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    size =3D len * glyph_size;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Ecom&quot;, =
domains_0, &amp;size, sizeof(domains_0));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(size, 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(err, ERROR_FILE_NOT_=
FOUND);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* Remove no domain from a =
single-entry list */</span><br><span>     wchar_t domains_1[BUF_SIZE] =3D L=
&quot;openvpn=2Ecom&quot;;</span><br><span>     len =3D (DWORD)wcslen(domai=
ns_1) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =
=3D orig_size =3D len * glyph_size;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    wchar_t domains_1_res[BUF_SIZE] =3D L&quot;=2Eopenvpn=2Ec=
om&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    res_len =
=3D len + 2; /* adds =2E and \0 */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Enet&quot;, d=
omains_1, &amp;size, BUF_SIZE);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    size =3D len * glyph_size;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    wchar_t domains_1_res[] =3D L&quot;=2Eopenvpn=2E=
com\0&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err=
 =3D ConvertItfDnsDomains(L&quot;openvpn=2Enet&quot;, domains_1, &amp;size,=
 sizeof(domains_1));</span><br><span>     assert_memory_equal(domains_1, do=
mains_1_res, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  assert_int_equal(size, res_len * glyph_size);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(size, sizeof(domains_1_res=
));</span><br><span>     assert_int_equal(err, NO_ERROR);</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Remove the s=
econd domain from a two-entry list */</span><br><span>     wchar_t domains_=
2[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet&quot;;</span><br><span> =
    len =3D (DWORD)wcslen(domains_2) + 1;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    size =3D orig_size =3D len * glyph_size;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_2_res[BUF_SI=
ZE] =3D L&quot;=2Eopenvpn=2Ecom&quot;;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    res_len =3D (DWORD)wcslen(domains_2_res) + 2;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomai=
ns(L&quot;openvpn=2Enet&quot;, domains_2, &amp;size, BUF_SIZE);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    size =3D len * glyph_size;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_=
2_res[] =3D L&quot;=2Eopenvpn=2Ecom\0&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    err =3D ConvertItfDnsDomains(L&quot;openvpn=2E=
net&quot;, domains_2, &amp;size, sizeof(domains_2));</span><br><span>     a=
ssert_memory_equal(domains_2, domains_2_res, size);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(size, res_len * glyph_=
size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(size, sizeof(domains_2_res));</span><br><span>     assert_int_equal=
(err, NO_ERROR);</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Remove the first domain from a two-entry list */</spa=
n><br><span>     wchar_t domains_3[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openv=
pn=2Enet&quot;;</span><br><span>     len =3D (DWORD)wcslen(domains_3) + 1;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D orig_size=
 =3D len * glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    wchar_t domains_3_res[BUF_SIZE] =3D L&quot;=2Eopenvpn=2Enet&quot;;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    res_len =3D (DWORD)wc=
slen(domains_3_res) + 2;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Ecom&quot;, domains_3, =
&amp;size, BUF_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    size =3D len * glyph_size;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    wchar_t domains_3_res[] =3D L&quot;=2Eopenvpn=2Enet\0&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D Conve=
rtItfDnsDomains(L&quot;openvpn=2Ecom&quot;, domains_3, &amp;size, sizeof(do=
mains_3));</span><br><span>     assert_memory_equal(domains_3, domains_3_re=
s, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_i=
nt_equal(size, res_len * glyph_size);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(size, sizeof(domains_3_res));</span>=
<br><span>     assert_int_equal(err, NO_ERROR);</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Remove no domain from =
a two-entry list */</span><br><span>     wchar_t domains_4[BUF_SIZE] =3D L&=
quot;openvpn=2Ecom,openvpn=2Enet&quot;;</span><br><span>     len =3D (DWORD=
)wcslen(domains_4) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    size =3D orig_size =3D len * glyph_size;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    wchar_t domains_4_res[BUF_SIZE] =3D L&quot;=2E=
openvpn=2Ecom\0=2Eopenvpn=2Enet&quot;;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    res_len =3D len + 3; /* adds two =2E and one \0 */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDns=
Domains(NULL, domains_4, &amp;size, BUF_SIZE);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    size =3D len * glyph_size;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_4_res[] =3D L&quo=
t;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    err =3D ConvertItfDnsDomains(NULL, domains_4,=
 &amp;size, sizeof(domains_4));</span><br><span>     assert_memory_equal(do=
mains_4, domains_4_res, size);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_int_equal(size, res_len * glyph_size);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(size, sizeof(do=
mains_4_res));</span><br><span>     assert_int_equal(err, NO_ERROR);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Remove the first domain from a three-e=
ntry list */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wch=
ar_t domains_5[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eo=
rg&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    len =
=3D (DWORD)wcslen(domains_5) + 1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    size =3D len * glyph_size;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    wchar_t domains_5_res[] =3D L&quot;=2Eopenvpn=
=2Enet\0=2Eopenvpn=2Eorg\0&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Ecom&quot;, =
domains_5, &amp;size, sizeof(domains_5));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_memory_equal(domains_5, domains_5_res, siz=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(size, sizeof(domains_5_res));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(err, NO_ERROR);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Remove the middle domain from a three-entry list */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_6=
[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    len =3D (DWORD)wcsle=
n(domains_6) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  size =3D len * glyph_size;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    wchar_t domains_6_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvp=
n=2Eorg\0&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 err =3D ConvertItfDnsDomains(L&quot;openvpn=2Enet&quot;, domains_6, &amp;s=
ize, sizeof(domains_6));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_memory_equal(domains_6, domains_6_res, size);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(size, sizeof=
(domains_6_res));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(err, NO_ERROR);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Remove the last domain from a three-entry list */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_7[BUF_SIZE] =3D L&quo=
t;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    len =3D (DWORD)wcslen(domains_7) + 1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    size =3D len * gly=
ph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t=
 domains_7_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D ConvertItfD=
nsDomains(L&quot;openvpn=2Eorg&quot;, domains_7, &amp;size, sizeof(domains_=
7));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memo=
ry_equal(domains_7, domains_7_res, size);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(size, sizeof(domains_7_res));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(e=
rr, NO_ERROR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Remove the last d=
omain from a four-entry list because of size constraints*/</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_8[BUF_SIZE] =3D =
L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-ende-noch-eine-lange=2E=
de&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    len =
=3D (DWORD)wcslen(domains_8) + 1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    size =3D len * glyph_size;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    wchar_t domains_8_res[] =3D L&quot;=2Eopenvpn=
=2Ecom\0=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    err =3D ConvertItfDnsDomains(NULL, do=
mains_8, &amp;size, sizeof(domains_8));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_memory_equal(domains_8, domains_8_res, size)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(size, sizeof(domains_8_res));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(err, ERROR_MORE_DATA);</span><br><span> }=
</span><br><span> </span><br><span> int</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1730?u=
sp=3Demail">change 1730</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1730?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1730 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-=
Owner: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Y1w7VGLLvgU=--


--===============3690581332297437021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3690581332297437021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3690581332297437021==--

