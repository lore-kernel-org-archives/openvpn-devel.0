Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E573DCDB479
	for <openvpn-devel@archiver.kernel.org>; Wed, 24 Jun 2026 01:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Ka0R/5tHTTq/WVeVjEgd8xOPnPvAD9To1g/4fplAQ10=; b=ht3wlFH8EIR9hG
	z0s+a15dx/YQXWzx0qc+anYIY6qxAmSAquKl/QmGHPGtd/iwSkObsxccuTRSvTxu/BiR1YzYhajnj
	3KWuyl/xip6JeOUj+1Yk0eWICFCzw12XVFrCohKNZu37NyeekbTUzoMJb5KmDQ/6cZLEpVAnmO9QM
	0xE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcCNO-00084N-Nk;
	Wed, 24 Jun 2026 01:26:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcCNN-00084G-1P
 for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 01:25:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y0mHWUkYKE4ZkLWz7CBeFeSRpNpAtbBNYjw7bmXnCOU=; b=EC7GT55gQYuom1aorgAxnhOGBO
 kvCbhfE3T5VJA5P1O/Q/w7wZeTFJcyvJUA4S5eFS8D2zKQNfQ7W/IW+trd3qLjFBUm+u3XcozikwO
 UkL68Osj42jcqc7yaxwkCpNYPS5cK+Rk/juCC7qT1o3Q5lRZxvlGWlhNd9ygsO+zeM2w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y0mHWUkYKE4ZkLWz7CBeFeSRpNpAtbBNYjw7bmXnCOU=; b=M
 B1W5SeMRXmMLKlLoI61TBoMsADHBtJKmd0Kkmx2ll/z5/XEdtL+hoZbuv4Bp8Gcd5bW7FjStiwZFq
 wZOhth4DMMaHWkadSJS3S5Qezh5XUCbdXwrRzy0xtDm+PJqUNW1rH0EzSEknhir61RwLxZQ/4ByeP
 zQC9HAy+IKdDtgLY=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcCNH-0003y9-4v for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 01:25:58 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso2901915e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 23 Jun 2026 18:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782264344; x=1782869144; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y0mHWUkYKE4ZkLWz7CBeFeSRpNpAtbBNYjw7bmXnCOU=;
 b=L6/Lw2oFMxrmM9At9xR5T4m3TpXvfW4wl3EbvHjUXpMwo90CRPaQx9PvsAjWNhZ/GN
 9JFj5mMfz6p32x2KQ8YypZAv6rqKsE3vMChVd6b4RDEzw9IYMa7uG0W2FlkEc2EC9YBs
 lyFhLInEuMo+3hC4L/FuRKAdAZzW5nGydk/H34dGcf8+cXVrYEi1Qvm+io76kARmYS8c
 ExS4evKIA9eXsYHWXtTV7Ffc6JM/10tgtndHpPhYwikP/kkui5GGf+g5Hhd5c/r8JqD5
 R8GU8IfBdVnIxJDzGfGKO4szLWrobzp09JQfkqb386Pubnd6ET5Ke1EI8/vlGOAOFHYO
 ENbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782264344; x=1782869144;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y0mHWUkYKE4ZkLWz7CBeFeSRpNpAtbBNYjw7bmXnCOU=;
 b=DpupUQTAKrV7CSb68O+YeO1DbqtPVcr9olipYWRTwQheFLlFpkgOIi09Ou9aWtuSrQ
 OHYDJSDQKxB1Y93vGs27v99/bkd4mNhuw6Evxcw00/HXB4CNHa/6jgkC1r/q+U9nKzgf
 YPiuBRb1oI5JfkTXH3W1FCogBYo7ydFUoe3RLKuXz1W2/T0i28NRSgZupDGplX35D3W+
 sfOlzJhYcKpafeg4h2Glzw4H95rwhLoT8od1vO4xiZFSO44ukbtS5nZvJSWRRO2ojkA3
 aWH7zqZUB5Gumx7kYUShIY706GVDC7WKa/7hHYq/aylTfdAd5FjryzQO5+veSFigagNi
 mAHA==
X-Gm-Message-State: AOJu0YzHMnO8DXc4+Z6c9/odCHanCAglGUlYB6JMWP88h0E+FP/QJFs2
 bmqFHmAOv8q1aLJynrRo1wu7Qph7mXURexcylsbfgNG3sKUgBAjq2M+rs8/KKGBO9t+uzNCjbwp
 gNZEzCrbhRxkL6rRzRKiLu/IPo2e7+SdpLMJVexfVmBsthkOKRefVe3v9rGFX5JAHpbXF4rGcbt
 Vf4NhuHA==
X-Gm-Gg: AfdE7cng8iy5Mhcr1i3cA4k3CL3snyNtV8QLpXtc3ddQoaaY/pTQIDoya3nqYA5gakD
 7xxnsV6shORqjIVRFloFMTmAgqn4DhZnltIfgzqQmZWKRxi7MRyo6MM/rO8tJR7o/YN3T5XzZjH
 XATrdiZnDRcxghhMBXOueklRgWG6UzUJ15/aYQUGWSGafAHUMjg8UnbccSZfX7AF3FXYqdl0wkH
 b3UQsENXsJ18AvfXcHaTZxCkDOMIjKr6LrK0YiqxT5muYBjA4iBCGPkP97+Pewz/ROhzsLdpw0T
 uADN03AytuIEVyy1qUfe3xQKieq1q+fwu87F/zcpCvWJmkqqXW6VlZYDIUIi62RW6N/9il0eYU3
 XgxU6FLbEQxIwBqIxDQTv3n64vyOWbJ6xuhTOKdd23AUCrCSY2QBl805sYH8KZJeeEIynyjwhi6
 LrxjosaHSUr+DEA0a+Er4MvG9P2twXP8r3WratzVwpjereHo7d67Tnu0gyJRFd8L1mnR8HM/AEd
 18J4emYOpOEMboe7SWcrq3oDFKgyI/XpGQWCRRA+hgCcmf84bTt0tXo5of8LxvnzEXuQ8pOqkIl
 l3s=
X-Received: by 2002:a05:600c:1910:b0:490:b3e7:4614 with SMTP id
 5b1f17b1804b1-49260878076mr13390395e9.25.1782264343801; 
 Tue, 23 Jun 2026 18:25:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249207dabsm598821495e9.0.2026.06.23.18.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 18:25:43 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 24 Jun 2026 01:25:43 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938
X-Gerrit-Change-Number: 1730
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1730?usp=email>
X-Gerrit-Commit: 0de5bddbe17f4de541731b7be62964cc04d9bc72
References: <gerrit.1782264341000.I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMjY0MzQxMDAwLkk4YzY3NjMzZWQzZDgyYTZkYzUwZmJkOGZhMWFmMmM1MGZjNDVkOTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c664761baf298da11489e71ba706a33f82d6ce09-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcCNH-0003y9-4v
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
 openvpn-devel@lists.sourceforge.net
Cc: "d12fk \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8675486450897641713=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8675486450897641713==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VRn3GAt1w+w="; charset=UTF-8

--VRn3GAt1w+w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1730?usp=3Demail

to review the following change=2E


Chang=
e subject: openvpnserv: rework ConvertItfDnsDomains and tests
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: rework Conve=
rtItfDnsDomains and tests

Since there were issues with in-place modificati=
on of the buffer
repeatedly, re-implement ConvertItfDnsDomains() to use a i=
nternal
temporary buffer to prevent use of memmove and the length calculati=
ons
that come with it=2E Code should be easier to grasp since we're dealing=

with one set of lengths (WCHARs) instead of two (WCHARs + octets) now=2E

=
The unit tests did not actually test the MULTI_SZs correctly, fixed
that an=
d also added some more tests to cover more scenarios=2E

Change-Id: I8c6763=
3ed3d82a6dc50fbd8fa1af2c50fc45d938
Signed-off-by: Heiko Hund <heiko@ist=2Ee=
igentlich=2Enet>
---
M src/openvpnserv/interactive=2Ec
M tests/unit_tests/o=
penvpnserv/test_openvpnserv=2Ec
2 files changed, 150 insertions(+), 101 del=
etions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/30/1730/1

diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpns=
erv/interactive=2Ec
index 788a578=2E=2E1fc02b2 100644
--- a/src/openvpnserv=
/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -33,6 +33,7 @@
 #=
include <shellapi=2Eh>
 #include <mstcpip=2Eh>
 #include <inttypes=2Eh>
+#i=
nclude <malloc=2Eh>
 
 #include <versionhelpers=2Eh>
 
@@ -2130,22 +2131,20=
 @@
 static BOOL
 ListContainsDomain(PCWSTR list, PCWSTR domain, size_t len=
)
 {
-    PCWSTR match =3D list;
-    while (match)
+    PCWSTR entry =3D l=
ist;
+    while (entry && *entry)
     {
-        match =3D wcsstr(match, d=
omain);
-        if (!match)
+        PCWSTR comma =3D wcschr(entry, L',');=

+        size_t entry_len =3D comma ? (size_t)(comma - entry) : wcslen(ent=
ry);
+        if (entry_len =3D=3D len && wcsncmp(entry, domain, len) =3D=
=3D 0)
         {
-            /* Domain has not matched */
-            br=
eak;
-        }
-        if ((match =3D=3D list || *(match - 1) =3D=3D ',')=

-            && (*(match + len) =3D=3D ',' || *(match + len) =3D=3D '\0'))=

-        {
-            /* Domain has matched fully */
             return=
 TRUE;
         }
-        match +=3D len;
+        if (!comma)
+        {
=
+            break;
+        }
+        entry =3D comma + 1;
     }
     re=
turn FALSE;
 }
@@ -2159,95 +2158,94 @@
  * are invalid=2E
  * Note that dom=
ains are deleted from the string if they match a search domain=2E
  *
- * @=
param[in]     search_domains  optional list of search domains
+ * @param[in=
]     search_domains  optional string of comma separated search domains
  *=
 @param[in,out] domains         buffer that contains the input comma-separa=
ted
  *                                string and will contain the MULTI_SZ=
 output string
  * @param[in,out] size            pointer to size of the in=
put string in bytes=2E Will be
  *                                set to th=
e size of the string returned, including
  *                               =
 the terminating zeros or 0=2E
- * @param[in]     buf_size        size of t=
he \p domains buffer
+ * @param[in]     capacity        capacity of the \p =
domains buffer in bytes
  *
- * @return LSTATUS NO_ERROR if the domain suff=
ix(es) were read successfully,
- *         ERROR_FILE_NOT_FOUND if no domai=
n was found for the interface,
- *         ERROR_MORE_DATA if the list did =
not fit into the buffer
+ * @return LSTATUS NO_ERROR if all domain suffix(e=
s) were converted successfully,
+ *         ERROR_FILE_NOT_FOUND if no doma=
in was left after the conversion,
+ *         ERROR_MORE_DATA if not all co=
nverted domains did fit into the buffer=2E
+ *         ERROR_OUTOFMEMORY if=
 the temporary buffer could not be allocated=2E
  */
 static LSTATUS
-Conve=
rtItfDnsDomains(PCWSTR search_domains, PWSTR domains, PDWORD size, const DW=
ORD buf_size)
+ConvertItfDnsDomains(PCWSTR search_domains, PWSTR domains, P=
DWORD size, const DWORD capacity)
 {
-    const DWORD glyph_size =3D sizeof=
(*domains);
-    const DWORD buf_len =3D buf_size / glyph_size;
+    const =
size_t glyph_size =3D sizeof(*domains);
+    const size_t max_len =3D (size=
_t)capacity / glyph_size;
 
-    /*
-     * Found domain(s), now convert th=
em:
-     *   - prefix each domain with a dot
-     *   - convert comma sep=
arated list to MULTI_SZ
-     */
-    PWCHAR pos =3D domains;
-    while (T=
RUE)
+    /* Space required for leading dot and two terminating zeros */
+ =
   const size_t dot_len =3D 1;
+    const size_t term_len =3D 2;
+
+    LST=
ATUS ret =3D NO_ERROR;
+    size_t tmp_len =3D 0;
+    WCHAR *tmp =3D _mall=
oca(capacity);
+    if (tmp =3D=3D NULL)
     {
-        /* Terminate the d=
omain at the next comma */
-        PWCHAR comma =3D wcschr(pos, ',');
-   =
     if (comma)
+        ret =3D ERROR_OUTOFMEMORY;
+        goto done;
+  =
  }
+
+    PWCHAR tmp_pos =3D tmp;
+    PCWCHAR domain =3D domains;
+
+    =
while (domain && *domain)
+    {
+        PWCHAR comma =3D wcschr(domain, L=
',');
+        size_t domain_len =3D comma ? (size_t)(comma - domain) : wcs=
len(domain);
+
+        if (ListContainsDomain(search_domains, domain, doma=
in_len))
         {
-            *comma =3D '\0';
+            /* Skip this=
 domain */
+            domain =3D comma ? comma + 1 : domain + domain_len;=

+            continue;
         }
 
-        DWORD domain_len =3D (DWORD)w=
cslen(pos);
-        DWORD domain_size =3D domain_len * glyph_size;
-      =
  DWORD converted_size =3D (DWORD)(pos - domains) * glyph_size;
-
-        =
/* Ignore itf domains which match a pushed search domain */
-        if (Li=
stContainsDomain(search_domains, pos, domain_len))
-        {
-            =
if (comma)
-            {
-                /* Overwrite the ignored domain =
with remaining one(s) */
-                memmove(pos, comma + 1, buf_size =
- converted_size);
-                *size -=3D domain_size + glyph_size;
- =
               continue;
-            }
-            else
-            {
- =
               /* This was the last domain */
-                *pos =3D '\0=
';
-                *size -=3D domain_size;
-                return wcslen(=
domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;
-            }
-        }
-
-  =
      /* Add space for the leading dot */
-        domain_len +=3D 1;
-    =
    domain_size +=3D glyph_size;
-
-        /* Space for the terminating ze=
ros */
-        const DWORD extra_size =3D 2 * glyph_size;
-
         /* Ch=
eck for enough space to convert this domain */
-        if (converted_size =
+ domain_size + extra_size > buf_size)
+        if (tmp_len + dot_len + dom=
ain_len + term_len > max_len)
         {
             /* Domain doesn't fit=
, bad luck if it's the first one */
-            *pos =3D '\0';
-          =
  *size =3D converted_size =3D=3D 0 ? 0 : converted_size + glyph_size;
-   =
         return ERROR_MORE_DATA;
+            *tmp_pos =3D L'\0';
+        =
    if (tmp_len > 0)
+            {
+                tmp_len +=3D 1;
+     =
       }
+            ret =3D ERROR_MORE_DATA;
+            goto done;
    =
     }
 
-        /* Prefix domain at pos with the dot */
-        memmove(=
pos + 1, pos, buf_size - converted_size - glyph_size);
-        domains[buf=
_len - 1] =3D '\0';
-        *pos =3D '=2E';
-        *size +=3D glyph_size=
;
+        /* Write leading dot and domain into tmp buffer */
+        *tmp=
_pos++ =3D L'=2E';
+        wcsncpy(tmp_pos, domain, domain_len);
+        =
tmp_pos +=3D domain_len;
+        *tmp_pos++ =3D L'\0';
+        tmp_len +=
=3D dot_len + domain_len + 1;
 
-        if (!comma)
-        {
-          =
  /* Conversion is done */
-            *(pos + domain_len) =3D '\0';
-    =
        *size +=3D glyph_size;
-            return NO_ERROR;
-        }
-
-=
        /* Comma pos is now +1 after adding leading dot */
-        pos =3D=
 comma + 2;
+        domain =3D comma ? comma + 1 : domain + domain_len;
  =
   }
+
+    if (tmp_len =3D=3D 0)
+    {
+        ret =3D ERROR_FILE_NOT_FO=
UND;
+        goto done;
+    }
+
+    /* REG_MULTI_SZ second zero terminat=
or */
+    *tmp_pos =3D L'\0';
+    tmp_len +=3D 1;
+
+done:
+    if (tmp)
=
+    {
+        wmemcpy(domains, tmp, tmp_len);
+        _freea(tmp);
+    =
}
+    *size =3D (DWORD)tmp_len * glyph_size;
+    return ret;
 }
 
 /**
di=
ff --git a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_t=
ests/openvpnserv/test_openvpnserv=2Ec
index 45096a1=2E=2Ee432f44 100644
---=
 a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
+++ b/tests/unit_tests=
/openvpnserv/test_openvpnserv=2Ec
@@ -48,58 +48,109 @@
     assert_true(Lis=
tContainsDomain(domain, domain, domain_len));
     assert_true(ListContains=
Domain(L"openvpn=2Ecom,openvpn=2Enet", domain, domain_len));
     assert_tr=
ue(ListContainsDomain(L"openvpn=2Enet,openvpn=2Ecom", domain, domain_len));=

+    assert_true(ListContainsDomain(L"openvpn=2Eorg,openvpn=2Enet,openvpn=
=2Ecom", domain, domain_len));
 
     assert_false(ListContainsDomain(L"ope=
nvpn=2Ecom", domain, domain_len));
     assert_false(ListContainsDomain(L"i=
nternal=2Eopenvpn=2Enet", domain, domain_len));
+    assert_false(ListConta=
insDomain(L"openvpn=2Ecom,internal=2Eopenvpn=2Enet", domain, domain_len));
=
+    assert_false(ListContainsDomain(L"internal=2Eopenvpn=2Enet,openvpn=2Ec=
om", domain, domain_len));
 }
 
 #define BUF_SIZE 64
 static void
 test_con=
vert_itf_dns_domains(void **state)
 {
-    DWORD size, orig_size, len, res_=
len;
+    DWORD size, len;
     LSTATUS err;
     const DWORD glyph_size =
=3D sizeof(wchar_t);
 
+    /* Remove the domain from a single-entry list *=
/
+    wchar_t domains_0[BUF_SIZE] =3D L"openvpn=2Ecom";
+    len =3D (DWOR=
D)wcslen(domains_0) + 1;
+    size =3D len * glyph_size;
+    err =3D Conve=
rtItfDnsDomains(L"openvpn=2Ecom", domains_0, &size, sizeof(domains_0));
+  =
  assert_int_equal(size, 0);
+    assert_int_equal(err, ERROR_FILE_NOT_FOUN=
D);
+
+    /* Remove no domain from a single-entry list */
     wchar_t dom=
ains_1[BUF_SIZE] =3D L"openvpn=2Ecom";
     len =3D (DWORD)wcslen(domains_1=
) + 1;
-    size =3D orig_size =3D len * glyph_size;
-    wchar_t domains_1=
_res[BUF_SIZE] =3D L"=2Eopenvpn=2Ecom";
-    res_len =3D len + 2; /* adds =
=2E and \0 */
-    err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_1=
, &size, BUF_SIZE);
+    size =3D len * glyph_size;
+    wchar_t domains_1_=
res[] =3D L"=2Eopenvpn=2Ecom\0";
+    err =3D ConvertItfDnsDomains(L"openvp=
n=2Enet", domains_1, &size, sizeof(domains_1));
     assert_memory_equal(do=
mains_1, domains_1_res, size);
-    assert_int_equal(size, res_len * glyph_=
size);
+    assert_int_equal(size, sizeof(domains_1_res));
     assert_int_=
equal(err, NO_ERROR);
 
+    /* Remove the second domain from a two-entry l=
ist */
     wchar_t domains_2[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet";=

     len =3D (DWORD)wcslen(domains_2) + 1;
-    size =3D orig_size =3D len=
 * glyph_size;
-    wchar_t domains_2_res[BUF_SIZE] =3D L"=2Eopenvpn=2Ecom"=
;
-    res_len =3D (DWORD)wcslen(domains_2_res) + 2;
-    err =3D ConvertIt=
fDnsDomains(L"openvpn=2Enet", domains_2, &size, BUF_SIZE);
+    size =3D le=
n * glyph_size;
+    wchar_t domains_2_res[] =3D L"=2Eopenvpn=2Ecom\0";
+  =
  err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_2, &size, sizeof(d=
omains_2));
     assert_memory_equal(domains_2, domains_2_res, size);
-    =
assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(size, s=
izeof(domains_2_res));
     assert_int_equal(err, NO_ERROR);
 
+    /* Remo=
ve the first domain from a two-entry list */
     wchar_t domains_3[BUF_SIZ=
E] =3D L"openvpn=2Ecom,openvpn=2Enet";
     len =3D (DWORD)wcslen(domains_3=
) + 1;
-    size =3D orig_size =3D len * glyph_size;
-    wchar_t domains_3=
_res[BUF_SIZE] =3D L"=2Eopenvpn=2Enet";
-    res_len =3D (DWORD)wcslen(doma=
ins_3_res) + 2;
-    err =3D ConvertItfDnsDomains(L"openvpn=2Ecom", domains=
_3, &size, BUF_SIZE);
+    size =3D len * glyph_size;
+    wchar_t domains_=
3_res[] =3D L"=2Eopenvpn=2Enet\0";
+    err =3D ConvertItfDnsDomains(L"open=
vpn=2Ecom", domains_3, &size, sizeof(domains_3));
     assert_memory_equal(=
domains_3, domains_3_res, size);
-    assert_int_equal(size, res_len * glyp=
h_size);
+    assert_int_equal(size, sizeof(domains_3_res));
     assert_in=
t_equal(err, NO_ERROR);
 
+    /* Remove no domain from a two-entry list */=

     wchar_t domains_4[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet";
     =
len =3D (DWORD)wcslen(domains_4) + 1;
-    size =3D orig_size =3D len * gly=
ph_size;
-    wchar_t domains_4_res[BUF_SIZE] =3D L"=2Eopenvpn=2Ecom\0=2Eop=
envpn=2Enet";
-    res_len =3D len + 3; /* adds two =2E and one \0 */
-    =
err =3D ConvertItfDnsDomains(NULL, domains_4, &size, BUF_SIZE);
+    size =
=3D len * glyph_size;
+    wchar_t domains_4_res[] =3D L"=2Eopenvpn=2Ecom\0=
=2Eopenvpn=2Enet\0";
+    err =3D ConvertItfDnsDomains(NULL, domains_4, &si=
ze, sizeof(domains_4));
     assert_memory_equal(domains_4, domains_4_res, =
size);
-    assert_int_equal(size, res_len * glyph_size);
+    assert_int_e=
qual(size, sizeof(domains_4_res));
     assert_int_equal(err, NO_ERROR);
+
=
+    /* Remove the first domain from a three-entry list */
+    wchar_t dom=
ains_5[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg";
+    len=
 =3D (DWORD)wcslen(domains_5) + 1;
+    size =3D len * glyph_size;
+    wch=
ar_t domains_5_res[] =3D L"=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0";
+    err =
=3D ConvertItfDnsDomains(L"openvpn=2Ecom", domains_5, &size, sizeof(domains=
_5));
+    assert_memory_equal(domains_5, domains_5_res, size);
+    assert=
_int_equal(size, sizeof(domains_5_res));
+    assert_int_equal(err, NO_ERRO=
R);
+
+    /* Remove the middle domain from a three-entry list */
+    wcha=
r_t domains_6[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg";
+=
    len =3D (DWORD)wcslen(domains_6) + 1;
+    size =3D len * glyph_size;
+=
    wchar_t domains_6_res[] =3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Eorg\0";
+ =
   err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_6, &size, sizeof(=
domains_6));
+    assert_memory_equal(domains_6, domains_6_res, size);
+   =
 assert_int_equal(size, sizeof(domains_6_res));
+    assert_int_equal(err, =
NO_ERROR);
+
+    /* Remove the last domain from a three-entry list */
+   =
 wchar_t domains_7[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eor=
g";
+    len =3D (DWORD)wcslen(domains_7) + 1;
+    size =3D len * glyph_si=
ze;
+    wchar_t domains_7_res[] =3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0=
";
+    err =3D ConvertItfDnsDomains(L"openvpn=2Eorg", domains_7, &size, si=
zeof(domains_7));
+    assert_memory_equal(domains_7, domains_7_res, size);=

+    assert_int_equal(size, sizeof(domains_7_res));
+    assert_int_equal(=
err, NO_ERROR);
+
+    /* Remove the last domain from a four-entry list bec=
ause of size constraints*/
+    wchar_t domains_8[BUF_SIZE] =3D L"openvpn=
=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-ende-noch-eine-lange=2Ede";
+    len =
=3D (DWORD)wcslen(domains_8) + 1;
+    size =3D len * glyph_size;
+    wcha=
r_t domains_8_res[] =3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0=2Eopenvpn=2E=
org\0";
+    err =3D ConvertItfDnsDomains(NULL, domains_8, &size, sizeof(do=
mains_8));
+    assert_memory_equal(domains_8, domains_8_res, size);
+    a=
ssert_int_equal(size, sizeof(domains_8_res));
+    assert_int_equal(err, ER=
ROR_MORE_DATA);
 }
 
 int

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1730?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938
Gerrit-Change-Number: 1730=

Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@openvpn=2Enet>
Gerrit-Review=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>

--VRn3GAt1w+w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>d12fk would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
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
=2Enet:29418/openvpn refs/changes/30/1730/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
nserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>ind=
ex 788a578=2E=2E1fc02b2 100644</span><br><span>--- a/src/openvpnserv/intera=
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
 WCHAR *tmp =3D _malloca(capacity);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (tmp =3D=3D NULL)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* Terminate the domain a=
t the next comma */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      PWCHAR comma =3D wcschr(pos, &#39;,&#39;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (comma)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        ret =3D ERROR_OUTOFMEMORY;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    PWCHAR tmp_pos =3D tmp;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    PCWCHAR domain =3D domains;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    while (domain &amp;&amp; *domain)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        PWCHAR comma =3D wcschr(domain, L&#39;,&#39;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        size_t domain_len =
=3D comma ? (size_t)(comma - domain) : wcslen(domain);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (ListContainsDomain(search_domains, domain, doma=
in_len))</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            *comma =3D &#39;\0&#39;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            /* Skip this domain */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            domain =3D comma =
? comma + 1 : domain + domain_len;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            continue;</span><br><span>         }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        DWORD d=
omain_len =3D (DWORD)wcslen(pos);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        DWORD domain_size =3D domain_len * glyph_size;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        DWORD converted_size =
=3D (DWORD)(pos - domains) * glyph_size;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      /* Ignore itf domains which match a pushed search domain */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (ListContainsDomain(=
search_domains, pos, domain_len))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if (comma)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         /* Overwrite the ignored domain with remaining one(s) */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                memmove(pos, co=
mma + 1, buf_size - converted_size);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                *size -=3D domain_size + glyph_size;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                continue;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                /* This was the last domain */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                *pos =
=3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            *size -=3D domain_size;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                return wcslen(domains) ? NO_ERROR : ERROR_FIL=
E_NOT_FOUND;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        /* Add space for the leading dot */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        domain_len +=3D 1;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        domain_size +=
=3D glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Space for the te=
rminating zeros */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     const DWORD extra_size =3D 2 * glyph_size;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>         /* Check for enough spa=
ce to convert this domain */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (converted_size + domain_size + extra_size &gt; buf_size)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tmp_len=
 + dot_len + domain_len + term_len &gt; max_len)</span><br><span>         {=
</span><br><span>             /* Domain doesn&#39;t fit, bad luck if it&#39=
;s the first one */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          *pos =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            *size =3D converted_size =3D=3D 0 ? 0 : converted_si=
ze + glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       return ERROR_MORE_DATA;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            *tmp_pos =3D L&#39;\0&#39;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (tmp_len &gt; 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                tmp_len +=3D 1;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            ret =3D ERROR_MORE_D=
ATA;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            got=
o done;</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* Prefix domain at pos with the do=
t */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        memmove(p=
os + 1, pos, buf_size - converted_size - glyph_size);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        domains[buf_len - 1] =3D &#39;\0&#3=
9;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *pos =3D &=
#39;=2E&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
*size +=3D glyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* Write leading dot and domain into tmp buffer */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        *tmp_pos++ =3D L&#39;=2E&=
#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wcsncp=
y(tmp_pos, domain, domain_len);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        tmp_pos +=3D domain_len;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        *tmp_pos++ =3D L&#39;\0&#39;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        tmp_len +=3D dot_len + d=
omain_len + 1;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!comma)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         /* Conversion is done */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            *(pos + domain_len) =3D &#39;\0&#39;;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            *size +=3D glyph_size;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return NO_=
ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /* Comma pos is now +1 after adding lead=
ing dot */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pos=
 =3D comma + 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    domain =3D comma ? comma + 1 : domain + domain_len;</span><br><span>   =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (tmp_len =3D=3D 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ret =3D ERROR_FILE_NOT_FOUND;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* REG_MULTI_SZ second zero terminator */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    *tmp_pos =3D L&#39;\0&#39;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tmp_len +=3D 1;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (tmp)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        wmemcpy(domains, tmp, tmp_len);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        _freea(tmp);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    *size =3D (DWORD)tmp_len * glyph_size;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span> }</span>=
<br><span> </span><br><span> /**</span><br><span>diff --git a/tests/unit_te=
sts/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_op=
envpnserv=2Ec</span><br><span>index 45096a1=2E=2Ee432f44 100644</span><br><=
span>--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><spa=
n>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>@=
@ -48,58 +48,109 @@</span><br><span>     assert_true(ListContainsDomain(dom=
ain, domain, domain_len));</span><br><span>     assert_true(ListContainsDom=
ain(L&quot;openvpn=2Ecom,openvpn=2Enet&quot;, domain, domain_len));</span><=
br><span>     assert_true(ListContainsDomain(L&quot;openvpn=2Enet,openvpn=
=2Ecom&quot;, domain, domain_len));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(ListContainsDomain(L&quot;openvpn=2Eorg,ope=
nvpn=2Enet,openvpn=2Ecom&quot;, domain, domain_len));</span><br><span> </sp=
an><br><span>     assert_false(ListContainsDomain(L&quot;openvpn=2Ecom&quot=
;, domain, domain_len));</span><br><span>     assert_false(ListContainsDoma=
in(L&quot;internal=2Eopenvpn=2Enet&quot;, domain, domain_len));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ListContainsDo=
main(L&quot;openvpn=2Ecom,internal=2Eopenvpn=2Enet&quot;, domain, domain_le=
n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(ListContainsDomain(L&quot;internal=2Eopenvpn=2Enet,openvpn=2Ecom&quot;, d=
omain, domain_len));</span><br><span> }</span><br><span> </span><br><span> =
#define BUF_SIZE 64</span><br><span> static void</span><br><span> test_conv=
ert_itf_dns_domains(void **state)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    DWORD size, orig_size, len, res_len;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD size, len;</=
span><br><span>     LSTATUS err;</span><br><span>     const DWORD glyph_siz=
e =3D sizeof(wchar_t);</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Remove the domain from a single-entry list */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_0=
[BUF_SIZE] =3D L&quot;openvpn=2Ecom&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    len =3D (DWORD)wcslen(domains_0) + 1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    size =3D len * glyph_size;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D Convert=
ItfDnsDomains(L&quot;openvpn=2Ecom&quot;, domains_0, &amp;size, sizeof(doma=
ins_0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(size, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(err, ERROR_FILE_NOT_FOUND);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Remove no domain from a single-entry list */</span><br><sp=
an>     wchar_t domains_1[BUF_SIZE] =3D L&quot;openvpn=2Ecom&quot;;</span><=
br><span>     len =3D (DWORD)wcslen(domains_1) + 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    size =3D orig_size =3D len * glyph_size=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_=
1_res[BUF_SIZE] =3D L&quot;=2Eopenvpn=2Ecom&quot;;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    res_len =3D len + 2; /* adds =2E and \0 */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertIt=
fDnsDomains(L&quot;openvpn=2Enet&quot;, domains_1, &amp;size, BUF_SIZE);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    size =3D len * gly=
ph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t=
 domains_1_res[] =3D L&quot;=2Eopenvpn=2Ecom\0&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    err =3D ConvertItfDnsDomains(L&quot;o=
penvpn=2Enet&quot;, domains_1, &amp;size, sizeof(domains_1));</span><br><sp=
an>     assert_memory_equal(domains_1, domains_1_res, size);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(size, res_len *=
 glyph_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(size, sizeof(domains_1_res));</span><br><span>     assert_in=
t_equal(err, NO_ERROR);</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Remove the second domain from a two-entry list=
 */</span><br><span>     wchar_t domains_2[BUF_SIZE] =3D L&quot;openvpn=2Ec=
om,openvpn=2Enet&quot;;</span><br><span>     len =3D (DWORD)wcslen(domains_=
2) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D o=
rig_size =3D len * glyph_size;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    wchar_t domains_2_res[BUF_SIZE] =3D L&quot;=2Eopenvpn=2Ecom&qu=
ot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    res_len =3D (=
DWORD)wcslen(domains_2_res) + 2;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Enet&quot;, dom=
ains_2, &amp;size, BUF_SIZE);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    size =3D len * glyph_size;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    wchar_t domains_2_res[] =3D L&quot;=2Eopenvpn=2Eco=
m\0&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =
=3D ConvertItfDnsDomains(L&quot;openvpn=2Enet&quot;, domains_2, &amp;size, =
sizeof(domains_2));</span><br><span>     assert_memory_equal(domains_2, dom=
ains_2_res, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 assert_int_equal(size, res_len * glyph_size);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(size, sizeof(domains_2_res)=
);</span><br><span>     assert_int_equal(err, NO_ERROR);</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Remove the fi=
rst domain from a two-entry list */</span><br><span>     wchar_t domains_3[=
BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet&quot;;</span><br><span>   =
  len =3D (DWORD)wcslen(domains_3) + 1;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    size =3D orig_size =3D len * glyph_size;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_3_res[BUF_SIZE=
] =3D L&quot;=2Eopenvpn=2Enet&quot;;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    res_len =3D (DWORD)wcslen(domains_3_res) + 2;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomains=
(L&quot;openvpn=2Ecom&quot;, domains_3, &amp;size, BUF_SIZE);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    size =3D len * glyph_size;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_3_=
res[] =3D L&quot;=2Eopenvpn=2Enet\0&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Eco=
m&quot;, domains_3, &amp;size, sizeof(domains_3));</span><br><span>     ass=
ert_memory_equal(domains_3, domains_3_res, size);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    assert_int_equal(size, res_len * glyph_size=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(size, sizeof(domains_3_res));</span><br><span>     assert_int_equal(err=
, NO_ERROR);</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Remove no domain from a two-entry list */</span><br><span=
>     wchar_t domains_4[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet&qu=
ot;;</span><br><span>     len =3D (DWORD)wcslen(domains_4) + 1;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    size =3D orig_size =3D len * =
glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_=
t domains_4_res[BUF_SIZE] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet&quo=
t;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    res_len =3D le=
n + 3; /* adds two =2E and one \0 */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    err =3D ConvertItfDnsDomains(NULL, domains_4, &amp;size,=
 BUF_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size=
 =3D len * glyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    wchar_t domains_4_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Ene=
t\0&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =
=3D ConvertItfDnsDomains(NULL, domains_4, &amp;size, sizeof(domains_4));</s=
pan><br><span>     assert_memory_equal(domains_4, domains_4_res, size);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(size=
, res_len * glyph_size);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(size, sizeof(domains_4_res));</span><br><span>   =
  assert_int_equal(err, NO_ERROR);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Remove the first domain from a three-entry list */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_5[BUF_SIZE] =3D L&quo=
t;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    len =3D (DWORD)wcslen(domains_5) + 1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    size =3D len * gly=
ph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t=
 domains_5_res[] =3D L&quot;=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D ConvertItfD=
nsDomains(L&quot;openvpn=2Ecom&quot;, domains_5, &amp;size, sizeof(domains_=
5));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memo=
ry_equal(domains_5, domains_5_res, size);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(size, sizeof(domains_5_res));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(e=
rr, NO_ERROR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Remove the middle=
 domain from a three-entry list */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    wchar_t domains_6[BUF_SIZE] =3D L&quot;openvpn=2Ecom,ope=
nvpn=2Enet,openvpn=2Eorg&quot;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    len =3D (DWORD)wcslen(domains_6) + 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size =3D len * glyph_size;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_6_res[] =
=3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Eorg\0&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    err =3D ConvertItfDnsDomains(L&quot;=
openvpn=2Enet&quot;, domains_6, &amp;size, sizeof(domains_6));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(domains_=
6, domains_6_res, size);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(size, sizeof(domains_6_res));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(err, NO_ERROR);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Remove the last domain from a thre=
e-entry list */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
wchar_t domains_7[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=
=2Eorg&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    le=
n =3D (DWORD)wcslen(domains_7) + 1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    size =3D len * glyph_size;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    wchar_t domains_7_res[] =3D L&quot;=2Eopenvp=
n=2Ecom\0=2Eopenvpn=2Enet\0&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Eorg&quot;,=
 domains_7, &amp;size, sizeof(domains_7));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_memory_equal(domains_7, domains_7_res, si=
ze);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(size, sizeof(domains_7_res));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(err, NO_ERROR);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Remove the last domain from a four-entry list because=
 of size constraints*/</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    wchar_t domains_8[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet,o=
penvpn=2Eorg,am-ende-noch-eine-lange=2Ede&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    len =3D (DWORD)wcslen(domains_8) + 1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    size =3D len * glyph=
_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t d=
omains_8_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0=2Eopenvpn=2E=
org\0&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err=
 =3D ConvertItfDnsDomains(NULL, domains_8, &amp;size, sizeof(domains_8));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equ=
al(domains_8, domains_8_res, size);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(size, sizeof(domains_8_res));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(err, ER=
ROR_MORE_DATA);</span><br><span> }</span><br><span> </span><br><span> int</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1730?usp=3Demail">change 1730</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1730?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8c67633ed3d82a6dc50=
fbd8fa1af2c50fc45d938 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1730 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@openvpn=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--VRn3GAt1w+w=--


--===============8675486450897641713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8675486450897641713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8675486450897641713==--

