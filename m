Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2540BC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gjWowe2mSLA56eNzi815SyRE08BEcwV5lcH8BSz0Ch8=; b=dIOIaQm5b+0XtF/My14ItrZxGO
	aDjpEFF+9WJTJspbcrvSKMbZ48vzcxzB+lkhKlCYsSE47g+f4yabtnabNCJyofRf7nu8/HMeFN/sh
	MpZrE9s012KxcaJOC9pcOGxcxhIkG8eXwPGP5KJbBYtv/wHkhtBEA6iBUr15AEoM+NN0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6Zj-0000lO-Ot;
	Mon, 29 Jun 2026 07:38:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6Zi-0000lG-N2
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:38:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6LEgcCRysb3XVYtdm+aPMp3kqJWsIqMxn/QGTNb4KPw=; b=e9W2M5Edhzchq4QrQSqKsadz6N
 r1XuKezTWFaIj7PD6TBBupUxJPcA89sHrC8QoLTnA8Qsn/eW6OTs0s6FfrY6g2Y5UBmClSJIir2Bi
 LwzKEJxSjpR3+fi5muNa9EOG4YOWreE5Rpst/tfmUsip/B6t4dSgjTkhjebb40536vWE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6LEgcCRysb3XVYtdm+aPMp3kqJWsIqMxn/QGTNb4KPw=; b=J
 tcZM10FJ9XMVb5h7lJGqhKozTiN3vRNisR17QkxhAp4Duwt6ow0V5+mexHx8DMiJLmJditrQA0YzH
 SQ4ngW6ye9sX+g/L4bOtYvOy8/4UV5DX4igs8YUBjXyjrMBYODIcyYV9IulGzsvUSNGffigOqZNJd
 zWbflD2NJz5wwiGc=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6Ze-00076H-4h for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:38:38 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47231f1f8f3so1905234f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782718703; x=1783323503; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6LEgcCRysb3XVYtdm+aPMp3kqJWsIqMxn/QGTNb4KPw=;
 b=QNhZCV9o+YiCWTTVimEQkHJ1pNu88rcgzObDDYKhKKWXSDI6i0ZL71pPAPCI6bHXXn
 Ew5nvG20zsHkFzSl4ggS2G8FD0eLYwvpzB/zkPblUw3WM+OO9iV/BrWFY8Fa7rW0rXNb
 bJh9bovb9gXr9g6RuO29LB8ThjHYmiARggleRQ9QG187ixYrBWR8XvfJg9EbLnGv68M2
 xw60z3wNBFBpEv2aAfdOC38gk1JVG7pUnjXonnIZCCjBsWDNh5307lVisOvU7Jmd85w5
 MubU8sArrOktkb/5ulIEcm0pOjAXlqfLNIjK60pyJLz+UJtQ4abbH5tcDiAFEEuC9U5V
 Yjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782718703; x=1783323503;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6LEgcCRysb3XVYtdm+aPMp3kqJWsIqMxn/QGTNb4KPw=;
 b=HJdCNPpUDRucgInafGYeb2lTrjzjyfE6toN2X+D4mtrL/I5ojYnvXgrQbh1LNcZjae
 lEyyAgy2rITGCc/emTxwC7A67R07/2qyjCJuDHfV257MzS+kC7GChGH0xbgIdJdsdACf
 pr3SDGAYeGk1YMwocfmceSChYnrdqawfleIFwFxQnVqtWQ3zdYUDMRW3HXz2BST1Jnnl
 GwyK0yXK+gT/sQoUY+PhzsbgB1A3MHF9YmfTQJhzJXT/bnXaIKlWLkN7GPiVD3Nx8mzf
 8wNBFLf8/Pz2ggXmsksfRjl0uzuUWiK0GmkqdDyMDKxstxsvwgUWn8AG9AZ3hqWQxFjb
 cOnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8UIYdF8XjpzdFDe0g/d9BosChi8jvT9FJjCZyIHUPpz5ydZxxwMWRGAJQNnHi6kqHAdcqzOXDolsuq9xI@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwEF05ygTeSpEEu22WL+TFH/G8pxTqi0gd+kLFi+jExNdjNdxYw
 A43eqCqql/T13RK3nsdd9mtvyjpTC3Q032CFlNxsld97ZWXpeFaIHQmVmP3SmkmdPSap1CBC13r
 E/Wpgsd9JUUW67IAT+Nv32N0qp1xi/BgrevTg5yJvISUPbpH2ETQssOFUl11oc11J1LaA
X-Gm-Gg: AfdE7cmEeaQK72j2XjBG3d+3iCmXoOWZkhnjDpT6QL3BOzI6rhTyFIfBkqblraoK+KB
 P2XmowlrFJ+gMBmNsP1rgqfw3lzVw9gMwidEGmXhhWZVNbi/OGmytW3PgJlagjYccyXgVI9wSdz
 o114mzNHhOo9vDqINrC53qmyIswSuKypSsCc2mxbuzM30K6ihI8zOmpSo/p2J5iagof3GLzkePt
 hcJsqrf4kqO/UX1Bq0EWY4o/vIjEis1Pxt7eIuz9HemL131kFq0gefoIpMm1Xv5Sw4/BDEfCi6S
 bGyeuuwnE+ftZgSS8yF1tc/enmvL0qQ23vXD3+hB9osEsNJ41xesiVcneLJ1wR84bPQybB5IuLQ
 CUhAi/zPgNxal/WVvEdANn1MglN+QAjizX7iBYfbhljhtb8RibhKnIYqTPle5d0iJ6YV5ybB/uo
 uUufhdeZUrTNQ78x5kRyYvFDtAa3Ti3FZZgVYTWNe1xtiP/1VdAf9tT9r1P9ynUv265HIDFPrM3
 r7uBGr/ck5SjEtDddvLTVqSeTrQWsXxDe288uvGAtwZDJxcR7MyWHfXI3IHzycEDPF778RqnAKQ
 X4dcY8hsDpksGQ==
X-Received: by 2002:a05:600c:a111:b0:492:68bc:3237 with SMTP id
 5b1f17b1804b1-49268bc34e3mr156670685e9.32.1782718702831; 
 Mon, 29 Jun 2026 00:38:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268ffe204sm299591745e9.7.2026.06.29.00.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:38:22 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:38:21 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938
X-Gerrit-Change-Number: 1730
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1730?usp=email>
X-Gerrit-Commit: 294d5ebb32e632c756290cb7b1de3df29a516154
In-Reply-To: <gerrit.1782264341000.I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938@gerrit.openvpn.net>
References: <gerrit.1782264341000.I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMjY0MzQxMDAwLkk4YzY3NjMzZWQzZDgyYTZkYzUwZmJkOGZhMWFmMmM1MGZjNDVkOTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <507bf1922a0ff0472ed1d411148b4bffe91a3913-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6Ze-00076H-4h
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7321678188165820620=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7321678188165820620==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jnQ1A2pmHcs="; charset=UTF-8

--jnQ1A2pmHcs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1730?usp=3Demail )

Change subject: openvpnserv: rework ConvertItfDnsDo=
mains and tests
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

openvpnserv: rework ConvertItfDnsDomains and tests

Since there were i=
ssues with in-place modification of the buffer
repeatedly, re-implement Con=
vertItfDnsDomains() to use a internal
temporary buffer to prevent use of me=
mmove and the length calculations
that come with it=2E Code should be easie=
r to grasp since we're dealing
with one set of lengths (WCHARs) instead of =
two (WCHARs + octets) now=2E

The unit tests did not actually test the MULT=
I_SZs correctly, fixed
that and also added some more tests to cover more sc=
enarios=2E

This was initially reported as a security vulnerability, as the=
 previous
code could be tricked into overreading a buffer and accessing und=
efined
memory - but we decided against assigning a CVE ID because the data =
read
is subsequently never leaked anywhere, and it was not possible to trig=
ger
a crash, so "just a bug, no security implications"=2E

Reported-By: =E7=
=AB=A0=E9=B1=BC=E5=93=A5 (@AiPy) (www=2Eaipyaipy=2Ecom)
Github: OpenVPN/ope=
nvpn-private-issues#122
Github: OpenVPN/openvpn-private-issues#126

Change-=
Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938
Signed-off-by: Heiko Hund <he=
iko@ist=2Eeigentlich=2Enet>
Acked-by: Lev Stipakov <lstipakov@gmail=2Ecom>
=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1730
Message-Id: <20=
260628130255=2E25452-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37337=2Ehtml
Signed-o=
ff-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interac=
tive=2Ec
M tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
2 files change=
d, 150 insertions(+), 101 deletions(-)




diff --git a/src/openvpnserv/int=
eractive=2Ec b/src/openvpnserv/interactive=2Ec
index 788a578=2E=2E516a469 1=
00644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interacti=
ve=2Ec
@@ -33,6 +33,7 @@
 #include <shellapi=2Eh>
 #include <mstcpip=2Eh>
 =
#include <inttypes=2Eh>
+#include <malloc=2Eh>
 
 #include <versionhelpers=
=2Eh>
 
@@ -2130,22 +2131,20 @@
 static BOOL
 ListContainsDomain(PCWSTR lis=
t, PCWSTR domain, size_t len)
 {
-    PCWSTR match =3D list;
-    while (ma=
tch)
+    PCWSTR entry =3D list;
+    while (entry && *entry)
     {
-     =
   match =3D wcsstr(match, domain);
-        if (!match)
+        PCWSTR co=
mma =3D wcschr(entry, L',');
+        size_t entry_len =3D comma ? (size_t)=
(comma - entry) : wcslen(entry);
+        if (entry_len =3D=3D len && wcsnc=
mp(entry, domain, len) =3D=3D 0)
         {
-            /* Domain has not =
matched */
-            break;
-        }
-        if ((match =3D=3D list |=
| *(match - 1) =3D=3D ',')
-            && (*(match + len) =3D=3D ',' || *(=
match + len) =3D=3D '\0'))
-        {
-            /* Domain has matched fu=
lly */
             return TRUE;
         }
-        match +=3D len;
+     =
   if (!comma)
+        {
+            break;
+        }
+        entry =3D=
 comma + 1;
     }
     return FALSE;
 }
@@ -2159,95 +2158,94 @@
  * are in=
valid=2E
  * Note that domains are deleted from the string if they match a =
search domain=2E
  *
- * @param[in]     search_domains  optional list of se=
arch domains
+ * @param[in]     search_domains  optional string of comma se=
parated search domains
  * @param[in,out] domains         buffer that conta=
ins the input comma-separated
  *                                string and=
 will contain the MULTI_SZ output string
  * @param[in,out] size           =
 pointer to size of the input string in bytes=2E Will be
  *               =
                 set to the size of the string returned, including
  *     =
                           the terminating zeros or 0=2E
- * @param[in]    =
 buf_size        size of the \p domains buffer
+ * @param[in]     capacity =
       capacity of the \p domains buffer in bytes
  *
- * @return LSTATUS N=
O_ERROR if the domain suffix(es) were read successfully,
- *         ERROR_=
FILE_NOT_FOUND if no domain was found for the interface,
- *         ERROR_=
MORE_DATA if the list did not fit into the buffer
+ * @return LSTATUS NO_ER=
ROR if all domain suffix(es) were converted successfully,
+ *         ERROR=
_FILE_NOT_FOUND if no domain was left after the conversion,
+ *         ERR=
OR_MORE_DATA if not all converted domains did fit into the buffer=2E
+ *   =
      ERROR_OUTOFMEMORY if the temporary buffer could not be allocated=2E
 =
 */
 static LSTATUS
-ConvertItfDnsDomains(PCWSTR search_domains, PWSTR doma=
ins, PDWORD size, const DWORD buf_size)
+ConvertItfDnsDomains(PCWSTR search=
_domains, PWSTR domains, PDWORD size, const DWORD capacity)
 {
-    const D=
WORD glyph_size =3D sizeof(*domains);
-    const DWORD buf_len =3D buf_size=
 / glyph_size;
+    const size_t glyph_size =3D sizeof(*domains);
+    cons=
t size_t max_len =3D (size_t)capacity / glyph_size;
 
-    /*
-     * Found=
 domain(s), now convert them:
-     *   - prefix each domain with a dot
-  =
   *   - convert comma separated list to MULTI_SZ
-     */
-    PWCHAR pos =
=3D domains;
-    while (TRUE)
+    /* Space required for leading dot and t=
wo terminating zeros */
+    const size_t dot_len =3D 1;
+    const size_t =
term_len =3D 2;
+
+    LSTATUS ret =3D NO_ERROR;
+    size_t tmp_len =3D 0;=

+    WCHAR *tmp =3D malloc(capacity);
+    if (tmp =3D=3D NULL)
     {
-  =
      /* Terminate the domain at the next comma */
-        PWCHAR comma =
=3D wcschr(pos, ',');
-        if (comma)
+        ret =3D ERROR_OUTOFMEMOR=
Y;
+        goto done;
+    }
+
+    PWCHAR tmp_pos =3D tmp;
+    PCWCHAR d=
omain =3D domains;
+
+    while (domain && *domain)
+    {
+        PWCHAR =
comma =3D wcschr(domain, L',');
+        size_t domain_len =3D comma ? (siz=
e_t)(comma - domain) : wcslen(domain);
+
+        if (ListContainsDomain(se=
arch_domains, domain, domain_len))
         {
-            *comma =3D '\0';=

+            /* Skip this domain */
+            domain =3D comma ? comma =
+ 1 : domain + domain_len;
+            continue;
         }
 
-        DWO=
RD domain_len =3D (DWORD)wcslen(pos);
-        DWORD domain_size =3D domain=
_len * glyph_size;
-        DWORD converted_size =3D (DWORD)(pos - domains)=
 * glyph_size;
-
-        /* Ignore itf domains which match a pushed search=
 domain */
-        if (ListContainsDomain(search_domains, pos, domain_len)=
)
-        {
-            if (comma)
-            {
-                /* Ove=
rwrite the ignored domain with remaining one(s) */
-                memmove=
(pos, comma + 1, buf_size - converted_size);
-                *size -=3D do=
main_size + glyph_size;
-                continue;
-            }
-        =
    else
-            {
-                /* This was the last domain */
-  =
              *pos =3D '\0';
-                *size -=3D domain_size;
-    =
            return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;
-    =
        }
-        }
-
-        /* Add space for the leading dot */
-      =
  domain_len +=3D 1;
-        domain_size +=3D glyph_size;
-
-        /* Sp=
ace for the terminating zeros */
-        const DWORD extra_size =3D 2 * gl=
yph_size;
-
         /* Check for enough space to convert this domain */
- =
       if (converted_size + domain_size + extra_size > buf_size)
+        i=
f (tmp_len + dot_len + domain_len + term_len > max_len)
         {
        =
     /* Domain doesn't fit, bad luck if it's the first one */
-            =
*pos =3D '\0';
-            *size =3D converted_size =3D=3D 0 ? 0 : convert=
ed_size + glyph_size;
-            return ERROR_MORE_DATA;
+            *tm=
p_pos =3D L'\0';
+            if (tmp_len > 0)
+            {
+            =
    tmp_len +=3D 1;
+            }
+            ret =3D ERROR_MORE_DATA;
+ =
           goto done;
         }
 
-        /* Prefix domain at pos with th=
e dot */
-        memmove(pos + 1, pos, buf_size - converted_size - glyph_s=
ize);
-        domains[buf_len - 1] =3D '\0';
-        *pos =3D '=2E';
-   =
     *size +=3D glyph_size;
+        /* Write leading dot and domain into t=
mp buffer */
+        *tmp_pos++ =3D L'=2E';
+        wcsncpy(tmp_pos, doma=
in, domain_len);
+        tmp_pos +=3D domain_len;
+        *tmp_pos++ =3D =
L'\0';
+        tmp_len +=3D dot_len + domain_len + 1;
 
-        if (!comm=
a)
-        {
-            /* Conversion is done */
-            *(pos + do=
main_len) =3D '\0';
-            *size +=3D glyph_size;
-            return=
 NO_ERROR;
-        }
-
-        /* Comma pos is now +1 after adding leadin=
g dot */
-        pos =3D comma + 2;
+        domain =3D comma ? comma + 1 =
: domain + domain_len;
     }
+
+    if (tmp_len =3D=3D 0)
+    {
+        =
ret =3D ERROR_FILE_NOT_FOUND;
+        goto done;
+    }
+
+    /* REG_MULT=
I_SZ second zero terminator */
+    *tmp_pos =3D L'\0';
+    tmp_len +=3D 1=
;
+
+done:
+    if (tmp)
+    {
+        wmemcpy(domains, tmp, tmp_len);
+ =
       free(tmp);
+    }
+    *size =3D (DWORD)(tmp_len * glyph_size);
+   =
 return ret;
 }
 
 /**
diff --git a/tests/unit_tests/openvpnserv/test_openv=
pnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
index 45096a=
1=2E=2Ee432f44 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv=
=2Ec
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
@@ -48,58 +48,=
109 @@
     assert_true(ListContainsDomain(domain, domain, domain_len));
  =
   assert_true(ListContainsDomain(L"openvpn=2Ecom,openvpn=2Enet", domain, d=
omain_len));
     assert_true(ListContainsDomain(L"openvpn=2Enet,openvpn=2E=
com", domain, domain_len));
+    assert_true(ListContainsDomain(L"openvpn=
=2Eorg,openvpn=2Enet,openvpn=2Ecom", domain, domain_len));
 
     assert_fa=
lse(ListContainsDomain(L"openvpn=2Ecom", domain, domain_len));
     assert_=
false(ListContainsDomain(L"internal=2Eopenvpn=2Enet", domain, domain_len));=

+    assert_false(ListContainsDomain(L"openvpn=2Ecom,internal=2Eopenvpn=2E=
net", domain, domain_len));
+    assert_false(ListContainsDomain(L"internal=
=2Eopenvpn=2Enet,openvpn=2Ecom", domain, domain_len));
 }
 
 #define BUF_SI=
ZE 64
 static void
 test_convert_itf_dns_domains(void **state)
 {
-    DWOR=
D size, orig_size, len, res_len;
+    DWORD size, len;
     LSTATUS err;
  =
   const DWORD glyph_size =3D sizeof(wchar_t);
 
+    /* Remove the domain =
from a single-entry list */
+    wchar_t domains_0[BUF_SIZE] =3D L"openvpn=
=2Ecom";
+    len =3D (DWORD)wcslen(domains_0) + 1;
+    size =3D len * gly=
ph_size;
+    err =3D ConvertItfDnsDomains(L"openvpn=2Ecom", domains_0, &si=
ze, sizeof(domains_0));
+    assert_int_equal(size, 0);
+    assert_int_equ=
al(err, ERROR_FILE_NOT_FOUND);
+
+    /* Remove no domain from a single-ent=
ry list */
     wchar_t domains_1[BUF_SIZE] =3D L"openvpn=2Ecom";
     len =
=3D (DWORD)wcslen(domains_1) + 1;
-    size =3D orig_size =3D len * glyph_s=
ize;
-    wchar_t domains_1_res[BUF_SIZE] =3D L"=2Eopenvpn=2Ecom";
-    res=
_len =3D len + 2; /* adds =2E and \0 */
-    err =3D ConvertItfDnsDomains(L=
"openvpn=2Enet", domains_1, &size, BUF_SIZE);
+    size =3D len * glyph_siz=
e;
+    wchar_t domains_1_res[] =3D L"=2Eopenvpn=2Ecom\0";
+    err =3D Con=
vertItfDnsDomains(L"openvpn=2Enet", domains_1, &size, sizeof(domains_1));
 =
    assert_memory_equal(domains_1, domains_1_res, size);
-    assert_int_eq=
ual(size, res_len * glyph_size);
+    assert_int_equal(size, sizeof(domains=
_1_res));
     assert_int_equal(err, NO_ERROR);
 
+    /* Remove the second=
 domain from a two-entry list */
     wchar_t domains_2[BUF_SIZE] =3D L"ope=
nvpn=2Ecom,openvpn=2Enet";
     len =3D (DWORD)wcslen(domains_2) + 1;
-    =
size =3D orig_size =3D len * glyph_size;
-    wchar_t domains_2_res[BUF_SIZ=
E] =3D L"=2Eopenvpn=2Ecom";
-    res_len =3D (DWORD)wcslen(domains_2_res) +=
 2;
-    err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_2, &size, B=
UF_SIZE);
+    size =3D len * glyph_size;
+    wchar_t domains_2_res[] =3D =
L"=2Eopenvpn=2Ecom\0";
+    err =3D ConvertItfDnsDomains(L"openvpn=2Enet", =
domains_2, &size, sizeof(domains_2));
     assert_memory_equal(domains_2, d=
omains_2_res, size);
-    assert_int_equal(size, res_len * glyph_size);
+  =
  assert_int_equal(size, sizeof(domains_2_res));
     assert_int_equal(err,=
 NO_ERROR);
 
+    /* Remove the first domain from a two-entry list */
    =
 wchar_t domains_3[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet";
     len =
=3D (DWORD)wcslen(domains_3) + 1;
-    size =3D orig_size =3D len * glyph_s=
ize;
-    wchar_t domains_3_res[BUF_SIZE] =3D L"=2Eopenvpn=2Enet";
-    res=
_len =3D (DWORD)wcslen(domains_3_res) + 2;
-    err =3D ConvertItfDnsDomain=
s(L"openvpn=2Ecom", domains_3, &size, BUF_SIZE);
+    size =3D len * glyph_=
size;
+    wchar_t domains_3_res[] =3D L"=2Eopenvpn=2Enet\0";
+    err =3D =
ConvertItfDnsDomains(L"openvpn=2Ecom", domains_3, &size, sizeof(domains_3))=
;
     assert_memory_equal(domains_3, domains_3_res, size);
-    assert_int=
_equal(size, res_len * glyph_size);
+    assert_int_equal(size, sizeof(doma=
ins_3_res));
     assert_int_equal(err, NO_ERROR);
 
+    /* Remove no doma=
in from a two-entry list */
     wchar_t domains_4[BUF_SIZE] =3D L"openvpn=
=2Ecom,openvpn=2Enet";
     len =3D (DWORD)wcslen(domains_4) + 1;
-    size=
 =3D orig_size =3D len * glyph_size;
-    wchar_t domains_4_res[BUF_SIZE] =
=3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet";
-    res_len =3D len + 3; /* add=
s two =2E and one \0 */
-    err =3D ConvertItfDnsDomains(NULL, domains_4, =
&size, BUF_SIZE);
+    size =3D len * glyph_size;
+    wchar_t domains_4_re=
s[] =3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0";
+    err =3D ConvertItfDns=
Domains(NULL, domains_4, &size, sizeof(domains_4));
     assert_memory_equa=
l(domains_4, domains_4_res, size);
-    assert_int_equal(size, res_len * gl=
yph_size);
+    assert_int_equal(size, sizeof(domains_4_res));
     assert_=
int_equal(err, NO_ERROR);
+
+    /* Remove the first domain from a three-en=
try list */
+    wchar_t domains_5[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2E=
net,openvpn=2Eorg";
+    len =3D (DWORD)wcslen(domains_5) + 1;
+    size =
=3D len * glyph_size;
+    wchar_t domains_5_res[] =3D L"=2Eopenvpn=2Enet\0=
=2Eopenvpn=2Eorg\0";
+    err =3D ConvertItfDnsDomains(L"openvpn=2Ecom", do=
mains_5, &size, sizeof(domains_5));
+    assert_memory_equal(domains_5, dom=
ains_5_res, size);
+    assert_int_equal(size, sizeof(domains_5_res));
+   =
 assert_int_equal(err, NO_ERROR);
+
+    /* Remove the middle domain from a=
 three-entry list */
+    wchar_t domains_6[BUF_SIZE] =3D L"openvpn=2Ecom,o=
penvpn=2Enet,openvpn=2Eorg";
+    len =3D (DWORD)wcslen(domains_6) + 1;
+  =
  size =3D len * glyph_size;
+    wchar_t domains_6_res[] =3D L"=2Eopenvpn=
=2Ecom\0=2Eopenvpn=2Eorg\0";
+    err =3D ConvertItfDnsDomains(L"openvpn=2E=
net", domains_6, &size, sizeof(domains_6));
+    assert_memory_equal(domain=
s_6, domains_6_res, size);
+    assert_int_equal(size, sizeof(domains_6_res=
));
+    assert_int_equal(err, NO_ERROR);
+
+    /* Remove the last domain =
from a three-entry list */
+    wchar_t domains_7[BUF_SIZE] =3D L"openvpn=
=2Ecom,openvpn=2Enet,openvpn=2Eorg";
+    len =3D (DWORD)wcslen(domains_7) =
+ 1;
+    size =3D len * glyph_size;
+    wchar_t domains_7_res[] =3D L"=2E=
openvpn=2Ecom\0=2Eopenvpn=2Enet\0";
+    err =3D ConvertItfDnsDomains(L"ope=
nvpn=2Eorg", domains_7, &size, sizeof(domains_7));
+    assert_memory_equal=
(domains_7, domains_7_res, size);
+    assert_int_equal(size, sizeof(domain=
s_7_res));
+    assert_int_equal(err, NO_ERROR);
+
+    /* Remove the last =
domain from a four-entry list because of size constraints*/
+    wchar_t do=
mains_8[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-ende-n=
och-eine-lange=2Ede";
+    len =3D (DWORD)wcslen(domains_8) + 1;
+    size =
=3D len * glyph_size;
+    wchar_t domains_8_res[] =3D L"=2Eopenvpn=2Ecom\0=
=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0";
+    err =3D ConvertItfDnsDomains(NU=
LL, domains_8, &size, sizeof(domains_8));
+    assert_memory_equal(domains_=
8, domains_8_res, size);
+    assert_int_equal(size, sizeof(domains_8_res))=
;
+    assert_int_equal(err, ERROR_MORE_DATA);
 }
 
 int

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1730?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d93=
8
Gerrit-Change-Number: 1730
Gerrit-PatchSet: 6
Gerrit-Owner: d12fk <heiko@=
openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--jnQ1A2pmHcs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1730?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">openvpnserv: rework ConvertItfDnsDomains a=
nd tests<br><br>Since there were issues with in-place modification of the b=
uffer<br>repeatedly, re-implement ConvertItfDnsDomains() to use a internal<=
br>temporary buffer to prevent use of memmove and the length calculations<b=
r>that come with it=2E Code should be easier to grasp since we&#39;re deali=
ng<br>with one set of lengths (WCHARs) instead of two (WCHARs + octets) now=
=2E<br><br>The unit tests did not actually test the MULTI_SZs correctly, fi=
xed<br>that and also added some more tests to cover more scenarios=2E<br><b=
r>This was initially reported as a security vulnerability, as the previous<=
br>code could be tricked into overreading a buffer and accessing undefined<=
br>memory - but we decided against assigning a CVE ID because the data read=
<br>is subsequently never leaked anywhere, and it was not possible to trigg=
er<br>a crash, so &quot;just a bug, no security implications&quot;=2E<br><b=
r>Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (@AiPy) (www=2Eaipyaipy=2Ecom)<b=
r>Github: OpenVPN/openvpn-private-issues#122<br>Github: OpenVPN/openvpn-pri=
vate-issues#126<br><br>Change-Id: I8c67633ed3d82a6dc50fbd8fa1af2c50fc45d938=
<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked=
-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1730<br>Message-Id: &lt;20260628130255=2E254=
52-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg37337=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/inte=
ractive=2Ec<br>M tests/unit_tests/openvpnserv/test_openvpnserv=2Ec<br>2 fil=
es changed, 150 insertions(+), 101 deletions(-)<br><br></pre>
<pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span>=
<br><span>index 788a578=2E=2E516a469 100644</span><br><span>--- a/src/openv=
pnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2E=
c</span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &lt;shellapi=
=2Eh&gt;</span><br><span> #include &lt;mstcpip=2Eh&gt;</span><br><span> #in=
clude &lt;inttypes=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &lt;malloc=2Eh&gt;</span><br><span> </span><br><span> #incl=
ude &lt;versionhelpers=2Eh&gt;</span><br><span> </span><br><span>@@ -2130,2=
2 +2131,20 @@</span><br><span> static BOOL</span><br><span> ListContainsDom=
ain(PCWSTR list, PCWSTR domain, size_t len)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    PCWSTR match =3D list;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    while (match)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    PCWSTR entry =3D list;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (entry &amp;&a=
mp; *entry)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        match =3D wcsstr(match, domain);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!match)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        PCWSTR comma =3D wcschr(entry, L&=
#39;,&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 size_t entry_len =3D comma ? (size_t)(comma - entry) : wcslen(entry);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (entry_len =
=3D=3D len &amp;&amp; wcsncmp(entry, domain, len) =3D=3D 0)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  /* Domain has not matched */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if ((match =3D=3D list || *(match - 1) =3D=3D &#39;,&#39;)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; (*(match + le=
n) =3D=3D &#39;,&#39; || *(match + len) =3D=3D &#39;\0&#39;))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            /* Domain has matched fully */</spa=
n><br><span>             return TRUE;</span><br><span>         }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        match +=3D len;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!comma)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        entry =3D comma + 1;</span><br><span>    =
 }</span><br><span>     return FALSE;</span><br><span> }</span><br><span>@@=
 -2159,95 +2158,94 @@</span><br><span>  * are invalid=2E</span><br><span>  =
* Note that domains are deleted from the string if they match a search doma=
in=2E</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @param[in]     search_domains  optional list of search domains</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param[in]     search_=
domains  optional string of comma separated search domains</span><br><span>=
  * @param[in,out] domains         buffer that contains the input comma-sep=
arated</span><br><span>  *                                string and will c=
ontain the MULTI_SZ output string</span><br><span>  * @param[in,out] size  =
          pointer to size of the input string in bytes=2E Will be</span><br=
><span>  *                                set to the size of the string ret=
urned, including</span><br><span>  *                                the ter=
minating zeros or 0=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * @param[in]     buf_size        size of the \p domains buffer</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param[in]     capacity    =
    capacity of the \p domains buffer in bytes</span><br><span>  *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * @return LSTATUS NO_ERROR if=
 the domain suffix(es) were read successfully,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *         ERROR_FILE_NOT_FOUND if no domain was f=
ound for the interface,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *         ERROR_MORE_DATA if the list did not fit into the buffer</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return LSTATUS NO_ERRO=
R if all domain suffix(es) were converted successfully,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *         ERROR_FILE_NOT_FOUND if no d=
omain was left after the conversion,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *         ERROR_MORE_DATA if not all converted domains di=
d fit into the buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *         ERROR_OUTOFMEMORY if the temporary buffer could not be allo=
cated=2E</span><br><span>  */</span><br><span> static LSTATUS</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-ConvertItfDnsDomains(PCWSTR search_=
domains, PWSTR domains, PDWORD size, const DWORD buf_size)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ConvertItfDnsDomains(PCWSTR search_d=
omains, PWSTR domains, PDWORD size, const DWORD capacity)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const DWORD glyp=
h_size =3D sizeof(*domains);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const DWORD buf_len =3D buf_size / glyph_size;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const size_t glyph_size =3D sizeo=
f(*domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st size_t max_len =3D (size_t)capacity / glyph_size;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * Found domain(s), now convert them:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *   - prefix eac=
h domain with a dot</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   *   - convert comma separated list to MULTI_SZ</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    PWCHAR pos =3D domains;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    while (TRUE)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Space required for leading dot and two terminating =
zeros */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const s=
ize_t dot_len =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const size_t term_len =3D 2;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L=
STATUS ret =3D NO_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    size_t tmp_len =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    WCHAR *tmp =3D malloc(capacity);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (tmp =3D=3D NULL)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Terminate =
the domain at the next comma */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        PWCHAR comma =3D wcschr(pos, &#39;,&#39;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (comma)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        ret =3D ERROR_OUTOFMEMORY;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    PWCHAR tmp_pos =3D tmp;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    PCWCHAR domain =3D domains;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    while (domain &amp;&amp; *domain)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        PWCHAR comma =3D wcschr(domain, L&#39;,&#39=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t d=
omain_len =3D comma ? (size_t)(comma - domain) : wcslen(domain);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (ListContainsDomain(search_domains, do=
main, domain_len))</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            *comma =3D &#39;\0&#39;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            /* Skip this domain */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            domain =
=3D comma ? comma + 1 : domain + domain_len;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            continue;</span><br><span>         }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   DWORD domain_len =3D (DWORD)wcslen(pos);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        DWORD domain_size =3D domain_len * glyph_size=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        DWORD conver=
ted_size =3D (DWORD)(pos - domains) * glyph_size;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* Ignore itf domains which match a pushed search domain */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ListContai=
nsDomain(search_domains, pos, domain_len))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            if (comma)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                /* Overwrite the ignored domain with remaining one(s) */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                memmov=
e(pos, comma + 1, buf_size - converted_size);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                *size -=3D domain_size + glyph_size=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                cont=
inue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                /* This was the last =
domain */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    *pos =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                *size -=3D domain_size;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                return wcslen(domains) ? NO_ERROR : =
ERROR_FILE_NOT_FOUND;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        /* Add space for the leading dot =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        domain_len =
+=3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        domain=
_size +=3D glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Space for=
 the terminating zeros */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        const DWORD extra_size =3D 2 * glyph_size;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /* Check for eno=
ugh space to convert this domain */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (converted_size + domain_size + extra_size &gt; bu=
f_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
tmp_len + dot_len + domain_len + term_len &gt; max_len)</span><br><span>   =
      {</span><br><span>             /* Domain doesn&#39;t fit, bad luck if=
 it&#39;s the first one */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            *pos =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            *size =3D converted_size =3D=3D 0 ? 0 : conve=
rted_size + glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            return ERROR_MORE_DATA;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            *tmp_pos =3D L&#39;\0&#39;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (tmp_len &gt; 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                tmp_len +=3D 1;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret =3D ERROR=
_MORE_DATA;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    goto done;</span><br><span>         }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* Prefix domain at pos with =
the dot */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mem=
move(pos + 1, pos, buf_size - converted_size - glyph_size);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        domains[buf_len - 1] =3D &#39=
;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *pos=
 =3D &#39;=2E&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      *size +=3D glyph_size;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* Write leading dot and domain into tmp buffer */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        *tmp_pos++ =3D L&#3=
9;=2E&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
wcsncpy(tmp_pos, domain, domain_len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        tmp_pos +=3D domain_len;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        *tmp_pos++ =3D L&#39;\0&#39;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        tmp_len +=3D dot_l=
en + domain_len + 1;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (!comma)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            /* Conversion is done */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            *(pos + domain_len) =3D &#39;\0&#39;;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            *size +=3D glyph_=
size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            retu=
rn NO_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        /* Comma pos is now +1 after addin=
g leading dot */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   pos =3D comma + 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        domain =3D comma ? comma + 1 : domain + domain_len;</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (tmp_len =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        ret =3D ERROR_FILE_NOT_FOUND;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* REG_MULTI_SZ second zero terminator */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    *tmp_pos =3D L&#39;\0&#=
39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tmp_len +=
=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (tmp)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        wmemcpy(domains, tmp, tmp_len);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        free(tmp);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    *size =3D (DWORD)(tmp_len * glyph_size);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span> }</s=
pan><br><span> </span><br><span> /**</span><br><span>diff --git a/tests/uni=
t_tests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/tes=
t_openvpnserv=2Ec</span><br><span>index 45096a1=2E=2Ee432f44 100644</span><=
br><span>--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br>=
<span>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><sp=
an>@@ -48,58 +48,109 @@</span><br><span>     assert_true(ListContainsDomain=
(domain, domain, domain_len));</span><br><span>     assert_true(ListContain=
sDomain(L&quot;openvpn=2Ecom,openvpn=2Enet&quot;, domain, domain_len));</sp=
an><br><span>     assert_true(ListContainsDomain(L&quot;openvpn=2Enet,openv=
pn=2Ecom&quot;, domain, domain_len));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(ListContainsDomain(L&quot;openvpn=2Eorg,o=
penvpn=2Enet,openvpn=2Ecom&quot;, domain, domain_len));</span><br><span> </=
span><br><span>     assert_false(ListContainsDomain(L&quot;openvpn=2Ecom&qu=
ot;, domain, domain_len));</span><br><span>     assert_false(ListContainsDo=
main(L&quot;internal=2Eopenvpn=2Enet&quot;, domain, domain_len));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ListContains=
Domain(L&quot;openvpn=2Ecom,internal=2Eopenvpn=2Enet&quot;, domain, domain_=
len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fa=
lse(ListContainsDomain(L&quot;internal=2Eopenvpn=2Enet,openvpn=2Ecom&quot;,=
 domain, domain_len));</span><br><span> }</span><br><span> </span><br><span=
> #define BUF_SIZE 64</span><br><span> static void</span><br><span> test_co=
nvert_itf_dns_domains(void **state)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    DWORD size, orig_size, len, res_len;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD size, len;<=
/span><br><span>     LSTATUS err;</span><br><span>     const DWORD glyph_si=
ze =3D sizeof(wchar_t);</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Remove the domain from a single-entry list */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_=
0[BUF_SIZE] =3D L&quot;openvpn=2Ecom&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    len =3D (DWORD)wcslen(domains_0) + 1;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    size =3D len * glyph_size=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D Conver=
tItfDnsDomains(L&quot;openvpn=2Ecom&quot;, domains_0, &amp;size, sizeof(dom=
ains_0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(size, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(err, ERROR_FILE_NOT_FOUND);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Remove no domain from a single-entry list */</span><br><s=
pan>     wchar_t domains_1[BUF_SIZE] =3D L&quot;openvpn=2Ecom&quot;;</span>=
<br><span>     len =3D (DWORD)wcslen(domains_1) + 1;</span><br><span style=
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
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I8c67633ed3d82a6dc50fbd=
8fa1af2c50fc45d938 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1730 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@openvpn=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

=
</body></html>
--jnQ1A2pmHcs=--


--===============7321678188165820620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7321678188165820620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7321678188165820620==--

