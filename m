Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C07C43458
	for <openvpn-devel@archiver.kernel.org>; Fri, 26 Jun 2026 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O7bfK6F5J04e91gV1JPlKfTcWjc8e8b9g3q+bktT//k=; b=H60BIRNFz9Aq+xO/i9/S5uBLsN
	Tu47IOWBGYv2j8yOGumL7s2jJANFwXpRNIobGUsixRGGQ2sSC/Sj+VXZls/GiABdbZMfv88uJhRNg
	58M50VMpti9AhrbnWY9X9Mp8SCfiNUOIRpl+hFMwKFIHxFTgSs3o+L2Bvb9DBdBcPi1I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdAmr-0008OM-5J;
	Fri, 26 Jun 2026 17:56:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdAmp-0008OE-1q
 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 17:56:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0W0iV82WZ6dD4rNxM3PwyZbfaB5ikWcOh84ZZujrTio=; b=SunM6czCABPBOPwu+JqtcK++Be
 SfaIWq0telbWVlV0XU0ItAr93llh/AsVKbgdpyEYnqiEPwhrlUsnhd0frKxvBaTn6B98SyaR8/E9i
 p6iUH9binECONqVpUq0mpt05so0Aj5qy5W2zflTJWzJ8rHWfz8VBYtof+Q8hpQca4Cp8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0W0iV82WZ6dD4rNxM3PwyZbfaB5ikWcOh84ZZujrTio=; b=P
 5a8Lns1Oo4iKeZbkaHWnwpWuwwveF2EMv/52644weKXIPdEV5Ry6k7TcdinbXo+3d3k50n3BbvMON
 Iu4GyKvKobsuiZsk9GqFFBuJ1hOXHLOQOGz/X4VwBtPbeXfVNiyoQBr9xH65CE+2OIz624RGNqm+Q
 w/7i9TKAwfAOWz0w=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdAml-0004Tx-MB for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 17:56:18 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so14620795e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 26 Jun 2026 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782496565; x=1783101365; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0W0iV82WZ6dD4rNxM3PwyZbfaB5ikWcOh84ZZujrTio=;
 b=BAC9Q+PDhlCv2dwB1NvkS1H3FN6E3M6QLCm22PgBtplDJHweikWa2fyHez/y57LYlX
 eC7hMPSIXnp2lp/3mzQb2gLCFj9Hep8YR8kMoSGsDnuSDGGSgxPliK4KH+kldhfCZ5HN
 0zrMQhy9dYnvXMwQRMUMnzlyQJZr6Dzj/Bls9CFOTaKqmoWGH9UuDn2HwCPmnjdn+bBL
 hvcbat5FtAha28TnQvmq1uGFwq7UzOYtYPVDAcO/DCu81ncbTckwzZJYbguC8Tig/cQi
 Pf0NcuiAA3rdPBGOG+PG2SNxP30H4mHsZyqv9gqDTqDynywB/DfTpgikBpjmQbTsHyng
 1b4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782496565; x=1783101365;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0W0iV82WZ6dD4rNxM3PwyZbfaB5ikWcOh84ZZujrTio=;
 b=Lldt7WaF7HVAE/pmLH8xNRax/GnuA2J8HwpEB64C89ocmVcv6Y3yuOJJ53zcF4nW3w
 DpdV/BzkSyMIuB6F34Tsdy1EQkmc7/ecUBMR0t6JUkCqpsGVkIYacoNLGF9HdwbWMWgh
 x/zgACZk8JrKYGI1r/0HvslqNfrhXdtOIXafld5sHH49A+ucTEspAqqMcOIFxOrcDC1P
 j723nsImHzUZmQNERqqHCKpD72R3OcP/BbU7uMcC9Xr8XtHB2GojoBT2bVap2tyvx2nX
 6JDoeDiVG8PbIPaE6PlfKQukaOfPtGf6M4Rn4eA0QMnt2GQkkeZrcm90O7DLR4utfuWF
 qkQQ==
X-Gm-Message-State: AOJu0YyyGVqW1M8ZmGl6SnCgY/uI5U8aUfJxM5lSLxfihrKcuDTsmXMk
 lD4RieDmPNIOWKJpXSDiCb0CekJ+9lR8qQShhzNVR99FW64/ZTW7Xjn5QNCyyXiDebH1Y7njk9y
 v2lcejOhssmQP8WOi4xJ6ejiaU++ztY1aZevu+vjp4iT2m7GMVGfYJgxwPjwrLx1Pbh4o
X-Gm-Gg: AfdE7cnYVqr1c1u0OxAamX9zqqFSeuok66zKND9ncJeMSy8QUPVQ8THyrw+fRgsDjgr
 2J49l25THSVg7BO7ZtDTlf4Gk564LkMGnVbsYa1ffeJTyfvoHydDX5d7K+A3lntvL2FadtEMfYl
 ZggPrkfvnA+R9Wzb5hVItbdIjdoAJzKFnKUDt3FtZBudxJeJjcmsxXM1A9R+j22vLporYU7s1EJ
 Xx4QalL/rttvwedyhykSZh1+l8Gc8nbTtgOM0w6dT5iQ5RS4QWBsyk82f36bBngh9RVyRgVHLSf
 CAi/5DSdFf37qcItJBR+GFjryYO1Bh23cu3KmjIOYyPRxBpCKMTYB2Tei7vwAR8pvO/I+uMLJ7E
 rMK2Fvz2kDjuQczxvHh0b69EnGqZQfHkxP+Yfn24uOxtwtHJISuNPeP3/dGsMa6ZfM1t22d+H9z
 IUArtWZkfkYe2jNi8dXTxExJr4oyUW8vmmMrKHE9Co7QaZDZJQ2XQObr+n58TB6tko7YAfou6NS
 x0QWX3p4/xTJGAn7jCxQZeBdPtFUbYR2ZgmSk8/Pw9LVnYKLSGV2C4eBKTOxp5Bw5LLCYe6OAmX
 dyY=
X-Received: by 2002:a05:600c:4745:b0:490:b355:9c70 with SMTP id
 5b1f17b1804b1-49266873f5bmr113982035e9.11.1782496563961; 
 Fri, 26 Jun 2026 10:56:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49270671e4esm20757725e9.13.2026.06.26.10.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 10:56:03 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 26 Jun 2026 17:56:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938
X-Gerrit-Change-Number: 1730
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1730?usp=email>
X-Gerrit-Commit: cb5b5c7d00d2d3681a734fa1b0ff3194adc33195
In-Reply-To: <gerrit.1782264341000.I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938@gerrit.openvpn.net>
References: <gerrit.1782264341000.I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMjY0MzQxMDAwLkk4YzY3NjMzZWQzZDgyYTZkYzUwZmJkOGZhMWFmMmM1MGZjNDVkOTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f9ddbe0b40eed3b7b22d9cf66b0c1c915b6e67e6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdAml-0004Tx-MB
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
From: "d12fk \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "d12fk \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8519353696113093078=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8519353696113093078==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o4uqHHCyPOU="; charset=UTF-8

--o4uqHHCyPOU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello plaisthos,=
 stipa, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1730?usp=3Demail

to look at the new patch=
 set (#2)=2E


Change subject: openvpnserv: rework ConvertItfDnsDomains and=
 tests
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

open=
vpnserv: rework ConvertItfDnsDomains and tests

Since there were issues wit=
h in-place modification of the buffer
repeatedly, re-implement ConvertItfDn=
sDomains() to use a internal
temporary buffer to prevent use of memmove and=
 the length calculations
that come with it=2E Code should be easier to gras=
p since we're dealing
with one set of lengths (WCHARs) instead of two (WCHA=
Rs + octets) now=2E

The unit tests did not actually test the MULTI_SZs cor=
rectly, fixed
that and also added some more tests to cover more scenarios=
=2E

Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938
Signed-off-by: He=
iko Hund <heiko@ist=2Eeigentlich=2Enet>
---
M src/openvpnserv/interactive=
=2Ec
M tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
2 files changed, 1=
50 insertions(+), 101 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/30/1730/2

diff --git a/src/openvpnserv/intera=
ctive=2Ec b/src/openvpnserv/interactive=2Ec
index 788a578=2E=2Ebbd6fd2 1006=
44
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=
=2Ec
@@ -33,6 +33,7 @@
 #include <shellapi=2Eh>
 #include <mstcpip=2Eh>
 #i=
nclude <inttypes=2Eh>
+#include <malloc=2Eh>
 
 #include <versionhelpers=2E=
h>
 
@@ -2130,22 +2131,20 @@
 static BOOL
 ListContainsDomain(PCWSTR list, =
PCWSTR domain, size_t len)
 {
-    PCWSTR match =3D list;
-    while (match=
)
+    PCWSTR entry =3D list;
+    while (entry && *entry)
     {
-        =
match =3D wcsstr(match, domain);
-        if (!match)
+        PCWSTR comma=
 =3D wcschr(entry, L',');
+        size_t entry_len =3D comma ? (size_t)(co=
mma - entry) : wcslen(entry);
+        if (entry_len =3D=3D len && wcsncmp(=
entry, domain, len) =3D=3D 0)
         {
-            /* Domain has not mat=
ched */
-            break;
-        }
-        if ((match =3D=3D list || *=
(match - 1) =3D=3D ',')
-            && (*(match + len) =3D=3D ',' || *(mat=
ch + len) =3D=3D '\0'))
-        {
-            /* Domain has matched fully=
 */
             return TRUE;
         }
-        match +=3D len;
+        =
if (!comma)
+        {
+            break;
+        }
+        entry =3D co=
mma + 1;
     }
     return FALSE;
 }
@@ -2159,95 +2158,94 @@
  * are inval=
id=2E
  * Note that domains are deleted from the string if they match a sea=
rch domain=2E
  *
- * @param[in]     search_domains  optional list of searc=
h domains
+ * @param[in]     search_domains  optional string of comma separ=
ated search domains
  * @param[in,out] domains         buffer that contains=
 the input comma-separated
  *                                string and wi=
ll contain the MULTI_SZ output string
  * @param[in,out] size            po=
inter to size of the input string in bytes=2E Will be
  *                  =
              set to the size of the string returned, including
  *        =
                        the terminating zeros or 0=2E
- * @param[in]     bu=
f_size        size of the \p domains buffer
+ * @param[in]     capacity    =
    capacity of the \p domains buffer in bytes
  *
- * @return LSTATUS NO_E=
RROR if the domain suffix(es) were read successfully,
- *         ERROR_FIL=
E_NOT_FOUND if no domain was found for the interface,
- *         ERROR_MOR=
E_DATA if the list did not fit into the buffer
+ * @return LSTATUS NO_ERROR=
 if all domain suffix(es) were converted successfully,
+ *         ERROR_FI=
LE_NOT_FOUND if no domain was left after the conversion,
+ *         ERROR_=
MORE_DATA if not all converted domains did fit into the buffer=2E
+ *      =
   ERROR_OUTOFMEMORY if the temporary buffer could not be allocated=2E
  */=

 static LSTATUS
-ConvertItfDnsDomains(PCWSTR search_domains, PWSTR domains=
, PDWORD size, const DWORD buf_size)
+ConvertItfDnsDomains(PCWSTR search_do=
mains, PWSTR domains, PDWORD size, const DWORD capacity)
 {
-    const DWOR=
D glyph_size =3D sizeof(*domains);
-    const DWORD buf_len =3D buf_size / =
glyph_size;
+    const size_t glyph_size =3D sizeof(*domains);
+    const s=
ize_t max_len =3D (size_t)capacity / glyph_size;
 
-    /*
-     * Found do=
main(s), now convert them:
-     *   - prefix each domain with a dot
-     =
*   - convert comma separated list to MULTI_SZ
-     */
-    PWCHAR pos =3D=
 domains;
-    while (TRUE)
+    /* Space required for leading dot and two =
terminating zeros */
+    const size_t dot_len =3D 1;
+    const size_t ter=
m_len =3D 2;
+
+    LSTATUS ret =3D NO_ERROR;
+    size_t tmp_len =3D 0;
+ =
   WCHAR *tmp =3D malloc(capacity);
+    if (tmp =3D=3D NULL)
     {
-     =
   /* Terminate the domain at the next comma */
-        PWCHAR comma =3D w=
cschr(pos, ',');
-        if (comma)
+        ret =3D ERROR_OUTOFMEMORY;
+ =
       goto done;
+    }
+
+    PWCHAR tmp_pos =3D tmp;
+    PCWCHAR domain=
 =3D domains;
+
+    while (domain && *domain)
+    {
+        PWCHAR comma=
 =3D wcschr(domain, L',');
+        size_t domain_len =3D comma ? (size_t)(=
comma - domain) : wcslen(domain);
+
+        if (ListContainsDomain(search_=
domains, domain, domain_len))
         {
-            *comma =3D '\0';
+   =
         /* Skip this domain */
+            domain =3D comma ? comma + 1 :=
 domain + domain_len;
+            continue;
         }
 
-        DWORD do=
main_len =3D (DWORD)wcslen(pos);
-        DWORD domain_size =3D domain_len =
* glyph_size;
-        DWORD converted_size =3D (DWORD)(pos - domains) * gl=
yph_size;
-
-        /* Ignore itf domains which match a pushed search doma=
in */
-        if (ListContainsDomain(search_domains, pos, domain_len))
-  =
      {
-            if (comma)
-            {
-                /* Overwrit=
e the ignored domain with remaining one(s) */
-                memmove(pos,=
 comma + 1, buf_size - converted_size);
-                *size -=3D domain_=
size + glyph_size;
-                continue;
-            }
-            e=
lse
-            {
-                /* This was the last domain */
-       =
         *pos =3D '\0';
-                *size -=3D domain_size;
-         =
       return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;
-         =
   }
-        }
-
-        /* Add space for the leading dot */
-        dom=
ain_len +=3D 1;
-        domain_size +=3D glyph_size;
-
-        /* Space f=
or the terminating zeros */
-        const DWORD extra_size =3D 2 * glyph_s=
ize;
-
         /* Check for enough space to convert this domain */
-      =
  if (converted_size + domain_size + extra_size > buf_size)
+        if (tm=
p_len + dot_len + domain_len + term_len > max_len)
         {
             =
/* Domain doesn't fit, bad luck if it's the first one */
-            *pos =
=3D '\0';
-            *size =3D converted_size =3D=3D 0 ? 0 : converted_si=
ze + glyph_size;
-            return ERROR_MORE_DATA;
+            *tmp_pos=
 =3D L'\0';
+            if (tmp_len > 0)
+            {
+                t=
mp_len +=3D 1;
+            }
+            ret =3D ERROR_MORE_DATA;
+      =
      goto done;
         }
 
-        /* Prefix domain at pos with the dot=
 */
-        memmove(pos + 1, pos, buf_size - converted_size - glyph_size);=

-        domains[buf_len - 1] =3D '\0';
-        *pos =3D '=2E';
-        =
*size +=3D glyph_size;
+        /* Write leading dot and domain into tmp bu=
ffer */
+        *tmp_pos++ =3D L'=2E';
+        wcsncpy(tmp_pos, domain, d=
omain_len);
+        tmp_pos +=3D domain_len;
+        *tmp_pos++ =3D L'\0'=
;
+        tmp_len +=3D dot_len + domain_len + 1;
 
-        if (!comma)
- =
       {
-            /* Conversion is done */
-            *(pos + domain_=
len) =3D '\0';
-            *size +=3D glyph_size;
-            return NO_E=
RROR;
-        }
-
-        /* Comma pos is now +1 after adding leading dot=
 */
-        pos =3D comma + 2;
+        domain =3D comma ? comma + 1 : dom=
ain + domain_len;
     }
+
+    if (tmp_len =3D=3D 0)
+    {
+        ret =
=3D ERROR_FILE_NOT_FOUND;
+        goto done;
+    }
+
+    /* REG_MULTI_SZ=
 second zero terminator */
+    *tmp_pos =3D L'\0';
+    tmp_len +=3D 1;
+
=
+done:
+    if (tmp)
+    {
+        wmemcpy(domains, tmp, tmp_len);
+     =
   free(tmp);
+    }
+    *size =3D (DWORD)tmp_len * glyph_size;
+    retur=
n ret;
 }
 
 /**
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv=
=2Ec b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
index 45096a1=2E=
=2Ee432f44 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
+=
++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
@@ -48,58 +48,109 @@=

     assert_true(ListContainsDomain(domain, domain, domain_len));
     ass=
ert_true(ListContainsDomain(L"openvpn=2Ecom,openvpn=2Enet", domain, domain_=
len));
     assert_true(ListContainsDomain(L"openvpn=2Enet,openvpn=2Ecom", =
domain, domain_len));
+    assert_true(ListContainsDomain(L"openvpn=2Eorg,o=
penvpn=2Enet,openvpn=2Ecom", domain, domain_len));
 
     assert_false(List=
ContainsDomain(L"openvpn=2Ecom", domain, domain_len));
     assert_false(Li=
stContainsDomain(L"internal=2Eopenvpn=2Enet", domain, domain_len));
+    as=
sert_false(ListContainsDomain(L"openvpn=2Ecom,internal=2Eopenvpn=2Enet", do=
main, domain_len));
+    assert_false(ListContainsDomain(L"internal=2Eopenv=
pn=2Enet,openvpn=2Ecom", domain, domain_len));
 }
 
 #define BUF_SIZE 64
 s=
tatic void
 test_convert_itf_dns_domains(void **state)
 {
-    DWORD size, =
orig_size, len, res_len;
+    DWORD size, len;
     LSTATUS err;
     const=
 DWORD glyph_size =3D sizeof(wchar_t);
 
+    /* Remove the domain from a s=
ingle-entry list */
+    wchar_t domains_0[BUF_SIZE] =3D L"openvpn=2Ecom";
=
+    len =3D (DWORD)wcslen(domains_0) + 1;
+    size =3D len * glyph_size;
=
+    err =3D ConvertItfDnsDomains(L"openvpn=2Ecom", domains_0, &size, sizeo=
f(domains_0));
+    assert_int_equal(size, 0);
+    assert_int_equal(err, E=
RROR_FILE_NOT_FOUND);
+
+    /* Remove no domain from a single-entry list *=
/
     wchar_t domains_1[BUF_SIZE] =3D L"openvpn=2Ecom";
     len =3D (DWOR=
D)wcslen(domains_1) + 1;
-    size =3D orig_size =3D len * glyph_size;
-   =
 wchar_t domains_1_res[BUF_SIZE] =3D L"=2Eopenvpn=2Ecom";
-    res_len =3D =
len + 2; /* adds =2E and \0 */
-    err =3D ConvertItfDnsDomains(L"openvpn=
=2Enet", domains_1, &size, BUF_SIZE);
+    size =3D len * glyph_size;
+    =
wchar_t domains_1_res[] =3D L"=2Eopenvpn=2Ecom\0";
+    err =3D ConvertItfD=
nsDomains(L"openvpn=2Enet", domains_1, &size, sizeof(domains_1));
     asse=
rt_memory_equal(domains_1, domains_1_res, size);
-    assert_int_equal(size=
, res_len * glyph_size);
+    assert_int_equal(size, sizeof(domains_1_res))=
;
     assert_int_equal(err, NO_ERROR);
 
+    /* Remove the second domain =
from a two-entry list */
     wchar_t domains_2[BUF_SIZE] =3D L"openvpn=2Ec=
om,openvpn=2Enet";
     len =3D (DWORD)wcslen(domains_2) + 1;
-    size =3D=
 orig_size =3D len * glyph_size;
-    wchar_t domains_2_res[BUF_SIZE] =3D L=
"=2Eopenvpn=2Ecom";
-    res_len =3D (DWORD)wcslen(domains_2_res) + 2;
-   =
 err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_2, &size, BUF_SIZE)=
;
+    size =3D len * glyph_size;
+    wchar_t domains_2_res[] =3D L"=2Eope=
nvpn=2Ecom\0";
+    err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_=
2, &size, sizeof(domains_2));
     assert_memory_equal(domains_2, domains_2=
_res, size);
-    assert_int_equal(size, res_len * glyph_size);
+    assert=
_int_equal(size, sizeof(domains_2_res));
     assert_int_equal(err, NO_ERRO=
R);
 
+    /* Remove the first domain from a two-entry list */
     wchar_t=
 domains_3[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet";
     len =3D (DWOR=
D)wcslen(domains_3) + 1;
-    size =3D orig_size =3D len * glyph_size;
-   =
 wchar_t domains_3_res[BUF_SIZE] =3D L"=2Eopenvpn=2Enet";
-    res_len =3D =
(DWORD)wcslen(domains_3_res) + 2;
-    err =3D ConvertItfDnsDomains(L"openv=
pn=2Ecom", domains_3, &size, BUF_SIZE);
+    size =3D len * glyph_size;
+  =
  wchar_t domains_3_res[] =3D L"=2Eopenvpn=2Enet\0";
+    err =3D ConvertIt=
fDnsDomains(L"openvpn=2Ecom", domains_3, &size, sizeof(domains_3));
     as=
sert_memory_equal(domains_3, domains_3_res, size);
-    assert_int_equal(si=
ze, res_len * glyph_size);
+    assert_int_equal(size, sizeof(domains_3_res=
));
     assert_int_equal(err, NO_ERROR);
 
+    /* Remove no domain from a=
 two-entry list */
     wchar_t domains_4[BUF_SIZE] =3D L"openvpn=2Ecom,ope=
nvpn=2Enet";
     len =3D (DWORD)wcslen(domains_4) + 1;
-    size =3D orig_=
size =3D len * glyph_size;
-    wchar_t domains_4_res[BUF_SIZE] =3D L"=2Eop=
envpn=2Ecom\0=2Eopenvpn=2Enet";
-    res_len =3D len + 3; /* adds two =2E a=
nd one \0 */
-    err =3D ConvertItfDnsDomains(NULL, domains_4, &size, BUF_=
SIZE);
+    size =3D len * glyph_size;
+    wchar_t domains_4_res[] =3D L"=
=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0";
+    err =3D ConvertItfDnsDomains(NU=
LL, domains_4, &size, sizeof(domains_4));
     assert_memory_equal(domains_=
4, domains_4_res, size);
-    assert_int_equal(size, res_len * glyph_size);=

+    assert_int_equal(size, sizeof(domains_4_res));
     assert_int_equal(=
err, NO_ERROR);
+
+    /* Remove the first domain from a three-entry list *=
/
+    wchar_t domains_5[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvp=
n=2Eorg";
+    len =3D (DWORD)wcslen(domains_5) + 1;
+    size =3D len * gl=
yph_size;
+    wchar_t domains_5_res[] =3D L"=2Eopenvpn=2Enet\0=2Eopenvpn=
=2Eorg\0";
+    err =3D ConvertItfDnsDomains(L"openvpn=2Ecom", domains_5, &=
size, sizeof(domains_5));
+    assert_memory_equal(domains_5, domains_5_res=
, size);
+    assert_int_equal(size, sizeof(domains_5_res));
+    assert_in=
t_equal(err, NO_ERROR);
+
+    /* Remove the middle domain from a three-ent=
ry list */
+    wchar_t domains_6[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2En=
et,openvpn=2Eorg";
+    len =3D (DWORD)wcslen(domains_6) + 1;
+    size =3D=
 len * glyph_size;
+    wchar_t domains_6_res[] =3D L"=2Eopenvpn=2Ecom\0=2E=
openvpn=2Eorg\0";
+    err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domai=
ns_6, &size, sizeof(domains_6));
+    assert_memory_equal(domains_6, domain=
s_6_res, size);
+    assert_int_equal(size, sizeof(domains_6_res));
+    as=
sert_int_equal(err, NO_ERROR);
+
+    /* Remove the last domain from a thre=
e-entry list */
+    wchar_t domains_7[BUF_SIZE] =3D L"openvpn=2Ecom,openvp=
n=2Enet,openvpn=2Eorg";
+    len =3D (DWORD)wcslen(domains_7) + 1;
+    siz=
e =3D len * glyph_size;
+    wchar_t domains_7_res[] =3D L"=2Eopenvpn=2Ecom=
\0=2Eopenvpn=2Enet\0";
+    err =3D ConvertItfDnsDomains(L"openvpn=2Eorg", =
domains_7, &size, sizeof(domains_7));
+    assert_memory_equal(domains_7, d=
omains_7_res, size);
+    assert_int_equal(size, sizeof(domains_7_res));
+ =
   assert_int_equal(err, NO_ERROR);
+
+    /* Remove the last domain from a=
 four-entry list because of size constraints*/
+    wchar_t domains_8[BUF_S=
IZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-ende-noch-eine-lang=
e=2Ede";
+    len =3D (DWORD)wcslen(domains_8) + 1;
+    size =3D len * gly=
ph_size;
+    wchar_t domains_8_res[] =3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2E=
net\0=2Eopenvpn=2Eorg\0";
+    err =3D ConvertItfDnsDomains(NULL, domains_8=
, &size, sizeof(domains_8));
+    assert_memory_equal(domains_8, domains_8_=
res, size);
+    assert_int_equal(size, sizeof(domains_8_res));
+    assert=
_int_equal(err, ERROR_MORE_DATA);
 }
 
 int

-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1730?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938
Gerrit=
-Change-Number: 1730
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@openvpn=
=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--o4uqHHCyPOU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>d12fk <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1730?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">op=
envpnserv: rework ConvertItfDnsDomains and tests<br><br>Since there were is=
sues with in-place modification of the buffer<br>repeatedly, re-implement C=
onvertItfDnsDomains() to use a internal<br>temporary buffer to prevent use =
of memmove and the length calculations<br>that come with it=2E Code should =
be easier to grasp since we&#39;re dealing<br>with one set of lengths (WCHA=
Rs) instead of two (WCHARs + octets) now=2E<br><br>The unit tests did not a=
ctually test the MULTI_SZs correctly, fixed<br>that and also added some mor=
e tests to cover more scenarios=2E<br><br>Change-Id: I8c67633ed3d82a6dc50fb=
d8fa1af2c50fc45d938<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=
=2Enet&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>M tests/unit_test=
s/openvpnserv/test_openvpnserv=2Ec<br>2 files changed, 150 insertions(+), 1=
01 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/30/1730/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
nserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>ind=
ex 788a578=2E=2Ebbd6fd2 100644</span><br><span>--- a/src/openvpnserv/intera=
ctive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><=
span>@@ -33,6 +33,7 @@</span><br><span> #include &lt;shellapi=2Eh&gt;</span=
><br><span> #include &lt;mstcpip=2Eh&gt;</span><br><span> #include &lt;intt=
ypes=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &lt;malloc=2Eh&gt;</span><br><span> </span><br><span> #include &lt;versio=
nhelpers=2Eh&gt;</span><br><span> </span><br><span>@@ -2130,22 +2131,20 @@<=
/span><br><span> static BOOL</span><br><span> ListContainsDomain(PCWSTR lis=
t, PCWSTR domain, size_t len)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    PCWSTR match =3D list;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    while (match)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    PCWSTR entry =3D list;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    while (entry &amp;&amp; *entry)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       match =3D wcsstr(match, domain);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (!match)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        PCWSTR comma =3D wcschr(entry, L&#39;,&#39;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t entry_le=
n =3D comma ? (size_t)(comma - entry) : wcslen(entry);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (entry_len =3D=3D len &amp;&a=
mp; wcsncmp(entry, domain, len) =3D=3D 0)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Domain has no=
t matched */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((match =3D=
=3D list || *(match - 1) =3D=3D &#39;,&#39;)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            &amp;&amp; (*(match + len) =3D=3D &#39;,=
&#39; || *(match + len) =3D=3D &#39;\0&#39;))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            /* Domain has matched fully */</span><br><span>    =
         return TRUE;</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        match +=3D len;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (!comma)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        entry =3D comma + 1;</span><br><span>     }</span><br><sp=
an>     return FALSE;</span><br><span> }</span><br><span>@@ -2159,95 +2158,=
94 @@</span><br><span>  * are invalid=2E</span><br><span>  * Note that doma=
ins are deleted from the string if they match a search domain=2E</span><br>=
<span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param[in=
]     search_domains  optional list of search domains</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param[in]     search_domains  optiona=
l string of comma separated search domains</span><br><span>  * @param[in,ou=
t] domains         buffer that contains the input comma-separated</span><br=
><span>  *                                string and will contain the MULTI=
_SZ output string</span><br><span>  * @param[in,out] size            pointe=
r to size of the input string in bytes=2E Will be</span><br><span>  *      =
                          set to the size of the string returned, including=
</span><br><span>  *                                the terminating zeros o=
r 0=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param[in]  =
   buf_size        size of the \p domains buffer</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param[in]     capacity        capacity of =
the \p domains buffer in bytes</span><br><span>  *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * @return LSTATUS NO_ERROR if the domain suff=
ix(es) were read successfully,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *         ERROR_FILE_NOT_FOUND if no domain was found for the int=
erface,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *         ERR=
OR_MORE_DATA if the list did not fit into the buffer</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return LSTATUS NO_ERROR if all domain=
 suffix(es) were converted successfully,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *         ERROR_FILE_NOT_FOUND if no domain was left =
after the conversion,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *         ERROR_MORE_DATA if not all converted domains did fit into the =
buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
 ERROR_OUTOFMEMORY if the temporary buffer could not be allocated=2E</span>=
<br><span>  */</span><br><span> static LSTATUS</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-ConvertItfDnsDomains(PCWSTR search_domains, PWSTR =
domains, PDWORD size, const DWORD buf_size)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ConvertItfDnsDomains(PCWSTR search_domains, PWSTR d=
omains, PDWORD size, const DWORD capacity)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const DWORD glyph_size =3D size=
of(*domains);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t DWORD buf_len =3D buf_size / glyph_size;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const size_t glyph_size =3D sizeof(*domains);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t max_l=
en =3D (size_t)capacity / glyph_size;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     * Found domain(s), now convert them:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-     *   - prefix each domain with a=
 dot</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *   - conver=
t comma separated list to MULTI_SZ</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   PWCHAR pos =3D domains;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    while (TRUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Space required for leading dot and two terminating zeros */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t dot_len =
=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const siz=
e_t term_len =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS ret =3D=
 NO_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_=
t tmp_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 WCHAR *tmp =3D malloc(capacity);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (tmp =3D=3D NULL)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* Terminate the domain at =
the next comma */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    PWCHAR comma =3D wcschr(pos, &#39;,&#39;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (comma)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ret =3D ERROR_OUTOFMEMORY;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    PWCHAR tmp_pos =3D tmp;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    PCWCHAR domain =3D domains;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    while (domain &amp;&amp; *domain)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        PWCHAR comma =3D wcschr(domain, L&#39;,&#39;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        size_t domain_len =3D =
comma ? (size_t)(comma - domain) : wcslen(domain);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (ListContainsDomain(search_domains, domain, domain_l=
en))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            *comma =3D &#39;\0&#39;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            /* Skip this domain */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            domain =3D comma ? co=
mma + 1 : domain + domain_len;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            continue;</span><br><span>         }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        DWORD domai=
n_len =3D (DWORD)wcslen(pos);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        DWORD domain_size =3D domain_len * glyph_size;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        DWORD converted_size =3D (=
DWORD)(pos - domains) * glyph_size;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 /* Ignore itf domains which match a pushed search domain */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (ListContainsDomain(searc=
h_domains, pos, domain_len))</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (comma)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    /* Overwrite the ignored domain with remaining one(s) */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                memmove(pos, comma +=
 1, buf_size - converted_size);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                *size -=3D domain_size + glyph_size;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                continue;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                /* This was the last domain */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                *pos =3D &=
#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       *size -=3D domain_size;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT=
_FOUND;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        /* Add space for the leading dot */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        domain_len +=3D 1;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        domain_size +=3D gly=
ph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        /* Space for the terminati=
ng zeros */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        co=
nst DWORD extra_size =3D 2 * glyph_size;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span>         /* Check for enough space to c=
onvert this domain */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (converted_size + domain_size + extra_size &gt; buf_size)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tmp_len + dot_=
len + domain_len + term_len &gt; max_len)</span><br><span>         {</span>=
<br><span>             /* Domain doesn&#39;t fit, bad luck if it&#39;s the =
first one */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   *pos =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            *size =3D converted_size =3D=3D 0 ? 0 : converted_size + gl=
yph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
return ERROR_MORE_DATA;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            *tmp_pos =3D L&#39;\0&#39;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (tmp_len &gt; 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                tmp_len +=3D 1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            ret =3D ERROR_MORE_DATA;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto done;=
</span><br><span>         }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        /* Prefix domain at pos with the dot */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        memmove(pos + 1, =
pos, buf_size - converted_size - glyph_size);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        domains[buf_len - 1] =3D &#39;\0&#39;;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        *pos =3D &#39;=2E&=
#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *size +=
=3D glyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* Write leading dot and domain into tmp buffer */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        *tmp_pos++ =3D L&#39;=2E&#39;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wcsncpy(tmp_p=
os, domain, domain_len);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        tmp_pos +=3D domain_len;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        *tmp_pos++ =3D L&#39;\0&#39;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        tmp_len +=3D dot_len + domain_l=
en + 1;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (!comma)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  /* Conversion is done */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            *(pos + domain_len) =3D &#39;\0&#39;;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            *size +=3D glyph_size;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            return NO_ERROR;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        /* Comma pos is now +1 after adding leading dot=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pos =3D co=
mma + 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dom=
ain =3D comma ? comma + 1 : domain + domain_len;</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (tmp_len =3D=3D 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        ret =3D ERROR_FILE_NOT_FOUND;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* REG_MULTI_SZ second zero terminator */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    *tmp_pos =3D L&#39;\0&#39;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    tmp_len +=3D 1;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (tmp)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  wmemcpy(domains, tmp, tmp_len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        free(tmp);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   *size =3D (DWORD)tmp_len * glyph_size;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return ret;</span><br><span> }</span><br><span> <=
/span><br><span> /**</span><br><span>diff --git a/tests/unit_tests/openvpns=
erv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnserv=2E=
c</span><br><span>index 45096a1=2E=2Ee432f44 100644</span><br><span>--- a/t=
ests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>+++ b/test=
s/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>@@ -48,58 +48=
,109 @@</span><br><span>     assert_true(ListContainsDomain(domain, domain,=
 domain_len));</span><br><span>     assert_true(ListContainsDomain(L&quot;o=
penvpn=2Ecom,openvpn=2Enet&quot;, domain, domain_len));</span><br><span>   =
  assert_true(ListContainsDomain(L&quot;openvpn=2Enet,openvpn=2Ecom&quot;, =
domain, domain_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(ListContainsDomain(L&quot;openvpn=2Eorg,openvpn=2Enet,ope=
nvpn=2Ecom&quot;, domain, domain_len));</span><br><span> </span><br><span> =
    assert_false(ListContainsDomain(L&quot;openvpn=2Ecom&quot;, domain, dom=
ain_len));</span><br><span>     assert_false(ListContainsDomain(L&quot;inte=
rnal=2Eopenvpn=2Enet&quot;, domain, domain_len));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_false(ListContainsDomain(L&quot;op=
envpn=2Ecom,internal=2Eopenvpn=2Enet&quot;, domain, domain_len));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ListContains=
Domain(L&quot;internal=2Eopenvpn=2Enet,openvpn=2Ecom&quot;, domain, domain_=
len));</span><br><span> }</span><br><span> </span><br><span> #define BUF_SI=
ZE 64</span><br><span> static void</span><br><span> test_convert_itf_dns_do=
mains(void **state)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    DWORD size, orig_size, len, res_len;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    DWORD size, len;</span><br><span>=
     LSTATUS err;</span><br><span>     const DWORD glyph_size =3D sizeof(wc=
har_t);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Remove the domain from a single-entry list */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_0[BUF_SIZE] =3D =
L&quot;openvpn=2Ecom&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    len =3D (DWORD)wcslen(domains_0) + 1;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    size =3D len * glyph_size;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    err =3D ConvertItfDnsDomains(L=
&quot;openvpn=2Ecom&quot;, domains_0, &amp;size, sizeof(domains_0));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(size,=
 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(err, ERROR_FILE_NOT_FOUND);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Remove no domain from a single-entry list */</span><br><span>     wchar_t=
 domains_1[BUF_SIZE] =3D L&quot;openvpn=2Ecom&quot;;</span><br><span>     l=
en =3D (DWORD)wcslen(domains_1) + 1;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    size =3D orig_size =3D len * glyph_size;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_1_res[BUF_SIZE] =
=3D L&quot;=2Eopenvpn=2Ecom&quot;;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    res_len =3D len + 2; /* adds =2E and \0 */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomains(L&qu=
ot;openvpn=2Enet&quot;, domains_1, &amp;size, BUF_SIZE);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    size =3D len * glyph_size;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_1_res[]=
 =3D L&quot;=2Eopenvpn=2Ecom\0&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Enet&quo=
t;, domains_1, &amp;size, sizeof(domains_1));</span><br><span>     assert_m=
emory_equal(domains_1, domains_1_res, size);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    assert_int_equal(size, res_len * glyph_size);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(s=
ize, sizeof(domains_1_res));</span><br><span>     assert_int_equal(err, NO_=
ERROR);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Remove the second domain from a two-entry list */</span><br><s=
pan>     wchar_t domains_2[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet=
&quot;;</span><br><span>     len =3D (DWORD)wcslen(domains_2) + 1;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D orig_size =3D len=
 * glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wch=
ar_t domains_2_res[BUF_SIZE] =3D L&quot;=2Eopenvpn=2Ecom&quot;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    res_len =3D (DWORD)wcslen(dom=
ains_2_res) + 2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
rr =3D ConvertItfDnsDomains(L&quot;openvpn=2Enet&quot;, domains_2, &amp;siz=
e, BUF_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    si=
ze =3D len * glyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    wchar_t domains_2_res[] =3D L&quot;=2Eopenvpn=2Ecom\0&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D ConvertItfDns=
Domains(L&quot;openvpn=2Enet&quot;, domains_2, &amp;size, sizeof(domains_2)=
);</span><br><span>     assert_memory_equal(domains_2, domains_2_res, size)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal=
(size, res_len * glyph_size);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(size, sizeof(domains_2_res));</span><br><spa=
n>     assert_int_equal(err, NO_ERROR);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Remove the first domain from a=
 two-entry list */</span><br><span>     wchar_t domains_3[BUF_SIZE] =3D L&q=
uot;openvpn=2Ecom,openvpn=2Enet&quot;;</span><br><span>     len =3D (DWORD)=
wcslen(domains_3) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    size =3D orig_size =3D len * glyph_size;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    wchar_t domains_3_res[BUF_SIZE] =3D L&quot;=2Eo=
penvpn=2Enet&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  res_len =3D (DWORD)wcslen(domains_3_res) + 2;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomains(L&quot;openvpn=
=2Ecom&quot;, domains_3, &amp;size, BUF_SIZE);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    size =3D len * glyph_size;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_3_res[] =3D L&quo=
t;=2Eopenvpn=2Enet\0&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Ecom&quot;, domain=
s_3, &amp;size, sizeof(domains_3));</span><br><span>     assert_memory_equa=
l(domains_3, domains_3_res, size);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    assert_int_equal(size, res_len * glyph_size);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(size, sizeo=
f(domains_3_res));</span><br><span>     assert_int_equal(err, NO_ERROR);</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Remove no domain from a two-entry list */</span><br><span>     wchar_t d=
omains_4[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet&quot;;</span><br>=
<span>     len =3D (DWORD)wcslen(domains_4) + 1;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    size =3D orig_size =3D len * glyph_size;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_4_res=
[BUF_SIZE] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet&quot;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    res_len =3D len + 3; /* adds =
two =2E and one \0 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    err =3D ConvertItfDnsDomains(NULL, domains_4, &amp;size, BUF_SIZE);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    size =3D len * glyp=
h_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t =
domains_4_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D ConvertItfDn=
sDomains(NULL, domains_4, &amp;size, sizeof(domains_4));</span><br><span>  =
   assert_memory_equal(domains_4, domains_4_res, size);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(size, res_len * glyp=
h_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(size, sizeof(domains_4_res));</span><br><span>     assert_int_equ=
al(err, NO_ERROR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Remove the fi=
rst domain from a three-entry list */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    wchar_t domains_5[BUF_SIZE] =3D L&quot;openvpn=2Ecom,=
openvpn=2Enet,openvpn=2Eorg&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    len =3D (DWORD)wcslen(domains_5) + 1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    size =3D len * glyph_size;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_5_res[]=
 =3D L&quot;=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    err =3D ConvertItfDnsDomains(L&quot=
;openvpn=2Ecom&quot;, domains_5, &amp;size, sizeof(domains_5));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(domains=
_5, domains_5_res, size);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(size, sizeof(domains_5_res));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(err, NO_ERROR);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Remove the middle domain from a t=
hree-entry list */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   wchar_t domains_6[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet,openv=
pn=2Eorg&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
len =3D (DWORD)wcslen(domains_6) + 1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    size =3D len * glyph_size;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    wchar_t domains_6_res[] =3D L&quot;=2Eopen=
vpn=2Ecom\0=2Eopenvpn=2Eorg\0&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Enet&quot=
;, domains_6, &amp;size, sizeof(domains_6));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_memory_equal(domains_6, domains_6_res, =
size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(size, sizeof(domains_6_res));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(err, NO_ERROR);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* Remove the last domain from a three-entry list */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_7[=
BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    len =3D (DWORD)wcslen=
(domains_7) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 size =3D len * glyph_size;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    wchar_t domains_7_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=
=2Enet\0&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
err =3D ConvertItfDnsDomains(L&quot;openvpn=2Eorg&quot;, domains_7, &amp;si=
ze, sizeof(domains_7));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_memory_equal(domains_7, domains_7_res, size);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(size, sizeof(=
domains_7_res));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(err, NO_ERROR);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Remove the last domain from a four-entry list because of size constraints=
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domai=
ns_8[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-ende=
-noch-eine-lange=2Ede&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    len =3D (DWORD)wcslen(domains_8) + 1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    size =3D len * glyph_size;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_8_res[] =3D L=
&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D ConvertItfDnsDo=
mains(NULL, domains_8, &amp;size, sizeof(domains_8));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(domains_8, domain=
s_8_res, size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(size, sizeof(domains_8_res));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(err, ERROR_MORE_DATA);</spa=
n><br><span> }</span><br><span> </span><br><span> int</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1730?usp=3Demail">change 1730</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1730?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc=
45d938 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1730 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipak=
ov@gmail=2Ecom&gt; </div>

</body></html>
--o4uqHHCyPOU=--


--===============8519353696113093078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8519353696113093078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8519353696113093078==--

