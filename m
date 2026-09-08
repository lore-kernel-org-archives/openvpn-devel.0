Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D50CC79F99
	for <openvpn-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=cB1AON0D3qEWO04SGsNTVyS/NllWkuZ+cVTp7sElSDA=; b=lcSKKEM1hDBUFR
	RkIUZZMpni/KFYcQ3meoV1OGtIrZCN/5ZpcgGL7ftdST9oipzlPfq/v1zSc42XWlVV2rQbhtDqB6c
	AIL7euHr8dsPfiZ7KpxOlqKJzZ1zl8DbE+gHzQW+mH0bfJTrXdukdUB+IRdLa3BSZbTaSi4VsU2RE
	QPw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3ykd-0003cI-DU;
	Tue, 08 Sep 2026 16:32:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3ykV-0003c8-7R
 for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 16:32:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2F2yBUGPhhFv7v27ljlln03UqnOU27Q74JO48xTgXN4=; b=iufq8AYs19XJcD4ML0AH7wUtfJ
 q1b3x49io8Q/HtEVmVK/AYJs6IlX5uxaApoyRYtpSFAcI8F6A3qgw/t89uD/hswc7mA20Vtm4mcqS
 SQsVyGmiw0p8wgaujDw34I03OGckARwqPf5LCryLe77004+8C2GoB96pf/NSU+hkgh54=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2F2yBUGPhhFv7v27ljlln03UqnOU27Q74JO48xTgXN4=; b=d
 172wMJwzFU56LsF7MZwwLlaT1XRk3YKglBmJjXtHaJe+thYt/0EvvmxYdPv02oEOn2RcX4Rd5cr2h
 WWO6wmw03uRscjyZc3znfoql9WtzA/hIG/IkweeOXKF5EM8+RxEByVjbI2XSzS19SE8azJyo+t2G/
 xDhapXCezDRYYwLU=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3ykT-0002kJ-NI for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 16:32:43 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so5899425e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 08 Sep 2026 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788885155; x=1789489955; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2F2yBUGPhhFv7v27ljlln03UqnOU27Q74JO48xTgXN4=;
 b=CY8AkpXDmpuSC2TYBD1v6woahS0XpAZSwGApfZOFlU3oXqVFkjBsHU3ttGi/i1JUr1
 2jIN2HP6+7AnGtKTGkB10XldTU5jb3U3rwEN/0Fp+7nOruMcvpDfFtSs+dEBa8MyEduW
 LMsHHZGocO/OQhqR79+JmRYMPd3JAYfyXzjlxHirojnxgh4SjyWVaRk8mNDSZJIn4w6g
 QJttKnVPhFDXtawGxicP0br/FHZwYMcL9NhokerANFjU9dyHdTMAepwFfON+/NrbGvqc
 TIPIlpfGvgiBpGa21STPnwQmZEfkFCATSAArTL1OrVod7dq5tK5Ufex8FmMQtsT9LRUf
 oI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788885155; x=1789489955;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2F2yBUGPhhFv7v27ljlln03UqnOU27Q74JO48xTgXN4=;
 b=kcmpamcr4AQ/sw8ZwiJw96duJzFimsEOH8N5DP1f1hCp94g5DIR3RfO5CIaxprvHR8
 MVUOHwkyZqZZnl8MiLorKjPrbpG+X0ogAj5ydIJKXNQ7a9WQxlLehBOTe3Yow/PJCPPa
 NRQyNi3x/v4rxHmVaQR83dsUMDcVDHXk4+jblCHlgGvfACMDuQMSEqV2H1xPwXPPVQ4J
 C+NEo56AI7++pa0Kbpp7SQh832ZL5fxUZMdTDe4aWEJ3Gm7HzxhnZ3ueosu4RiLjaHPm
 aoMw/s4sTRblPmXU8MmK4IEMunh8J6BKhebzlkm0CZ8n45xLwTeVlUe4lApmNQ9Y4jjt
 JrYQ==
X-Gm-Message-State: AFuF++k0IiJ2YL37kky9pRqaRrCBNoMbuedqVCFejuzAUXQu9LDHinku
 fiWSk2r69G8GN+NguBOy9L3CiQNXzY/5iRq0LGfqx64JQeTb8IErsKNfK1/mdv4EyV5jYGDbUOS
 8X3LdixyeZ/5vAXaEEtAjGn5zoJ2UJkEXqh/yQdQFx4Mc3l1S/pVmDG/6oqDScHTJ6irjMr11LE
 myVTDM7w==
X-Gm-Gg: AYBFou0xkUADbNg0bS1I57VNh5xWC52h/rAdvQUSQDLo6dX+bM6FGtOQ1i6H3kbyhnX
 z7zI0JdEjwOa9cdh+RhC2eecoFZDHxTDNGQxoQHtt+OZ7+19t5vr1GbGbe0HdPKM5AFey6MTfE3
 UF7spajG731wNMGkc7jbeQYg5Y5b34qdWiSg+oC1HImt80Kv+CN76PW1yvHUCjYicWXkIjkwWDX
 xq3W1pk9dXOhMW07ym7+HLIAPmrgUrxmSIcGXp1DuGiMqk2hAdbH2BAuWrhWav3Y/MRAcGECHwU
 AMisZfCDWmCl+U6GPmNeeTh0yWRR6CreeLoccK3XVmuknRNwhOk8xz59jTYqV8KHWlf5XZv2GZe
 954CblcWO+ebJjWNOsDeuTxVWdc6xxWWDoo5KX0HAGAfH8Sg+8Noh/Yqmlm266Eh6I6SgQzMAWI
 UTkLxzspVsdLS81kAtG4dHmIcjyReAaDprfUZC0DOoseJfX8LTq7pgr6ZH+ZEi0rdOxer/ghCsP
 wxYUyd58Ra905TW3QnkJSkG8VPploJc0n3K8PRJ6Jyy/zIhgWFBwSG0CFr3+u6eMQA7I9mQ7qHv
 IwYzdw/Nd2gRR0s6XI1GUepfnBQvhZLRPYAkapJB7Dlclj43s6w=
X-Received: by 2002:a05:600c:8b12:b0:49c:f13e:e4d with SMTP id
 5b1f17b1804b1-49d17572958mr82194495e9.10.1788885154484; 
 Tue, 08 Sep 2026 09:32:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfbe5b252sm354393905e9.3.2026.09.08.09.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 09:32:33 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 8 Sep 2026 16:32:33 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
X-Gerrit-Change-Number: 1905
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1905?usp=email>
X-Gerrit-Commit: 83a0276cbe830f8e28fe239cef35a83bb75d1001
References: <gerrit.1788885150000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MTUwMDAwLkk2YTg4NmExY2FjMmQ0NzI1ODU5ZGFiMjMyNWNkMzYyMzEyZGRjNjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f815e6c9e02feb4e64b6c0b257d341eac3ffa0ab-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3ykT-0002kJ-NI
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: dhcp: Fix
 off-by-one in write_dhcp_search_str() temp buffer guard
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5252115544850771127=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5252115544850771127==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K4aXggQpk+4="; charset=UTF-8

--K4aXggQpk+4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, razvanc=2E

Hello p=
laisthos,

I'd like you to do a code review=2E
Please visit

    http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1905?usp=3Demail

to review the following c=
hange=2E


Change subject: dhcp: Fix off-by-one in write_dhcp_search_str() =
temp buffer guard
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

dhcp: Fix off-by-one in write_dhcp_search_str() temp buffer guard

Eac=
h search list entry consumes strlen(ptr) + 2 bytes of tmp_buf: one
leading =
label length byte, the domain characters, and one trailing NUL=2E
The guard=
 only accounted for strlen(ptr) + 1, so a sequence of entries
whose accumul=
ated length lands exactly on the boundary passed the check
and then wrote t=
mp_buf[256], one byte past the 256 byte array=2E

The existing "len > 255" =
check enforces the correct upper bound, but it
runs after that write has al=
ready happened=2E

The entries can be pushed by the server: --dhcp-option f=
alls under
OPT_P_DHCPDNS, which pull_permission_mask() includes, and
valida=
te_domain() imposes no length limit=2E

Reproduced under AddressSanitizer, =
which reports a one byte
stack-buffer-overflow at dhcp=2Ec:308=2E The added=
 unit test covers the
boundary; it fails before this change and passes afte=
r it=2E The two
existing cases marked "maximum length" are unaffected, sinc=
e a 253
character domain still satisfies 253 + 0 + 2 <=3D 256=2E

(Note: Th=
e unit tests have not been included in the cherry-pick to 2=2E6
because tes=
t_dhcp=2Ec did not exist in this version=2E)

This was reported independent=
ly by Andre Kropp and Ch=C3=ADnh Nguy=E1=BB=85n V=C4=83n=2E
Patch author is=
 Andre Kropp, recording both reports in the Reported-By:

CVE: 2026-81738
C=
hange-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
Signed-off-by: Nexory <=
St4yl3r30@hotmail=2Ede>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Ac=
ked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1884
Reported-By: Andre Kropp (Nexory)
Reporte=
d-By: ChinhNguyen
Message-Id: <20260831083449=2E12484-1-gert@greenie=2Emuc=
=2Ede>
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
(cherry picked=
 from commit 1ece6fe6fd586501b486aac6932d424c167a3adb)
---
M src/openvpn/dh=
cp=2Ec
1 file changed, 192 insertions(+), 0 deletions(-)



  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/05/1905/1

diff --git a=
/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec
index f137b01=2E=2E0e03cec 100=
644
--- a/src/openvpn/dhcp=2Ec
+++ b/src/openvpn/dhcp=2Ec
@@ -186,3 +186,19=
5 @@
     }
     return 0;
 }
+
+#if defined(_WIN32) || defined(DHCP_UNIT_T=
EST)
+
+/*
+ * Convert DHCP options from the command line / config file
+ *=
 into a raw DHCP-format options string=2E
+ */
+
+static void
+write_dhcp_u=
8(struct buffer *buf, const uint8_t type, const uint8_t data, bool *error)
=
+{
+    if (!buf_safe(buf, 3))
+    {
+        *error =3D true;
+        ms=
g(M_WARN, "write_dhcp_u8: buffer overflow building DHCP options");
+       =
 return;
+    }
+    buf_write_u8(buf, type);
+    buf_write_u8(buf, 1);
+ =
   buf_write_u8(buf, data);
+}
+
+static void
+write_dhcp_u32_array(struct =
buffer *buf, const uint8_t type, const uint32_t *data,
+                   =
  const unsigned int len, bool *error)
+{
+    if (len > 0)
+    {
+       =
 const size_t size =3D len * sizeof(uint32_t);
+
+        if (!buf_safe(buf=
, 2 + size))
+        {
+            *error =3D true;
+            msg(M_WA=
RN, "write_dhcp_u32_array: buffer overflow building DHCP options");
+      =
      return;
+        }
+        if (size < 1 || size > 255)
+        {
+ =
           *error =3D true;
+            msg(M_WARN, "write_dhcp_u32_array:=
 size (%zu) must be > 0 and <=3D 255", size);
+            return;
+       =
 }
+        buf_write_u8(buf, type);
+        buf_write_u8(buf, (uint8_t)si=
ze);
+        for (unsigned int i =3D 0; i < len; ++i)
+        {
+        =
    buf_write_u32(buf, data[i]);
+        }
+    }
+}
+
+static void
+write=
_dhcp_str(struct buffer *buf, const uint8_t type, const char *str, bool *er=
ror)
+{
+    const size_t len =3D strlen(str);
+    if (!buf_safe(buf, 2 + =
len))
+    {
+        *error =3D true;
+        msg(M_WARN, "write_dhcp_str=
: buffer overflow building DHCP options");
+        return;
+    }
+    if =
(len < 1 || len > 255)
+    {
+        *error =3D true;
+        msg(M_WARN=
, "write_dhcp_str: string '%s' must be > 0 bytes and <=3D 255 bytes", str);=

+        return;
+    }
+    buf_write_u8(buf, type);
+    buf_write_u8(bu=
f, (uint8_t)len);
+    buf_write(buf, str, len);
+}
+
+/*
+ * RFC3397 state=
s that multiple searchdomains are encoded as follows:
+ *  - at start the l=
ength of the entire option is given
+ *  - each subdomain is preceded by it=
s length
+ *  - each searchdomain is separated by a NUL character
+ * e=2Eg=
=2E if you want "openvpn=2Enet" and "duckduckgo=2Ecom" then you end up with=

+ *  0x1D  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00
+ */
+sta=
tic void
+write_dhcp_search_str(struct buffer *buf, const uint8_t type, con=
st char *const *str_array,
+                      int array_len, bool *erro=
r)
+{
+    char tmp_buf[256];
+    size_t len =3D 0;
+    size_t label_leng=
th_pos;
+
+    for (int i =3D 0; i < array_len; i++)
+    {
+        const =
char *ptr =3D str_array[i];
+
+        /* Each entry consumes strlen(ptr) +=
 2 bytes: one leading label length
+         * byte and one trailing NUL=2E=
 */
+        if (strlen(ptr) + len + 2 > sizeof(tmp_buf))
+        {
+     =
       *error =3D true;
+            msg(M_WARN, "write_dhcp_search_str: te=
mp buffer overflow building DHCP options");
+            return;
+        }=

+        /* Loop over all subdomains separated by a dot and replace the do=
t
+         * with the length of the subdomain */
+
+        /* label_lengt=
h_pos points to the byte to be replaced by the length
+         * of the fo=
llowing domain label */
+        label_length_pos =3D len++;
+
+        whi=
le (true)
+        {
+            if (*ptr =3D=3D '=2E' || *ptr =3D=3D '\0'=
)
+            {
+                /* cast is protected by sizeof(tmp_buf) *=
/
+                tmp_buf[label_length_pos] =3D (char)(len - label_length_=
pos - 1);
+                label_length_pos =3D len;
+                if (*=
ptr =3D=3D '\0')
+                {
+                    break;
+          =
      }
+            }
+            tmp_buf[len++] =3D *ptr++;
+        }
+=
        /* And close off with an extra NUL char */
+        tmp_buf[len++] =
=3D 0;
+    }
+
+    if (!buf_safe(buf, 2 + len))
+    {
+        *error =
=3D true;
+        msg(M_WARN, "write_search_dhcp_str: buffer overflow buil=
ding DHCP options");
+        return;
+    }
+    if (len > 255)
+    {
+  =
      *error =3D true;
+        msg(M_WARN, "write_dhcp_search_str: search =
domain string must be <=3D 255 bytes");
+        return;
+    }
+
+    buf_=
write_u8(buf, type);
+    buf_write_u8(buf, (uint8_t)len);
+    buf_write(b=
uf, tmp_buf, len);
+}
+
+bool
+build_dhcp_options_string(struct buffer *buf=
, const struct tuntap_options *o)
+{
+    bool error =3D false;
+    if (o-=
>domain)
+    {
+        write_dhcp_str(buf, DHCP_DOMAIN_NAME, o->domain, &=
error);
+    }
+
+    if (o->netbios_scope)
+    {
+        write_dhcp_str(=
buf, DHCP_NETBIOS_SCOPE, o->netbios_scope, &error);
+    }
+
+    if (o->ne=
tbios_node_type)
+    {
+        write_dhcp_u8(buf, DHCP_NETBIOS_NODE_TYPE,=
 o->netbios_node_type, &error);
+    }
+
+    write_dhcp_u32_array(buf, DHC=
P_DOMAIN_SERVER, (uint32_t *)o->dns, o->dns_len, &error);
+    write_dhcp_u=
32_array(buf, DHCP_NETBIOS_DOMAIN_SERVER, (uint32_t *)o->wins, o->wins_len,=
 &error);
+    write_dhcp_u32_array(buf, DHCP_NTP_SERVER, (uint32_t *)o->nt=
p, o->ntp_len, &error);
+    write_dhcp_u32_array(buf, DHCP_NETBIOS_DIST_SE=
RVER, (uint32_t *)o->nbdd, o->nbdd_len, &error);
+
+    if (o->domain_searc=
h_list_len > 0)
+    {
+        write_dhcp_search_str(buf, DHCP_DOMAIN_SEAR=
CH, o->domain_search_list, o->domain_search_list_len, &error);
+    }
+
+  =
  /* the MS DHCP server option 'Disable Netbios-over-TCP/IP
+     * is impl=
emented as vendor option 001, value 002=2E
+     * A value of 001 means 'le=
ave NBT alone' which is the default */
+    if (o->disable_nbt)
+    {
+   =
     if (!buf_safe(buf, 8))
+        {
+            msg(M_WARN, "build_dhcp=
_options_string: buffer overflow building DHCP options");
+            retu=
rn false;
+        }
+        buf_write_u8(buf, DHCP_VENDOR);
+        buf_=
write_u8(buf, 6); /* total length field */
+        buf_write_u8(buf, 0x001=
);
+        buf_write_u8(buf, 4); /* length of the vendor specified field *=
/
+        buf_write_u32(buf, 0x002);
+    }
+    return !error;
+}
+
+#end=
if /* defined(_WIN32) */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1905?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerri=
t-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
Gerrit-Change-Number=
: 1905
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerr=
it-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <g=
ert@greenie=2Emuc=2Ede>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>

--K4aXggQpk+4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos, razvanc=2E </p>
<p>MaxF would like =
plaisthos to <strong>review</strong> this change=2E
</p><p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1905?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">dhcp: Fix off-by-one in write_dhcp_search_str() temp buffer gu=
ard<br><br>Each search list entry consumes strlen(ptr) + 2 bytes of tmp_buf=
: one<br>leading label length byte, the domain characters, and one trailing=
 NUL=2E<br>The guard only accounted for strlen(ptr) + 1, so a sequence of e=
ntries<br>whose accumulated length lands exactly on the boundary passed the=
 check<br>and then wrote tmp_buf[256], one byte past the 256 byte array=2E<=
br><br>The existing &quot;len &gt; 255&quot; check enforces the correct upp=
er bound, but it<br>runs after that write has already happened=2E<br><br>Th=
e entries can be pushed by the server: --dhcp-option falls under<br>OPT_P_D=
HCPDNS, which pull_permission_mask() includes, and<br>validate_domain() imp=
oses no length limit=2E<br><br>Reproduced under AddressSanitizer, which rep=
orts a one byte<br>stack-buffer-overflow at dhcp=2Ec:308=2E The added unit =
test covers the<br>boundary; it fails before this change and passes after i=
t=2E The two<br>existing cases marked &quot;maximum length&quot; are unaffe=
cted, since a 253<br>character domain still satisfies 253 + 0 + 2 &lt;=3D 2=
56=2E<br><br>(Note: The unit tests have not been included in the cherry-pic=
k to 2=2E6<br>because test_dhcp=2Ec did not exist in this version=2E)<br><b=
r>This was reported independently by Andre Kropp and Ch=C3=ADnh Nguy=E1=BB=
=85n V=C4=83n=2E<br>Patch author is Andre Kropp, recording both reports in =
the Reported-By:<br><br>CVE: 2026-81738<br>Change-Id: I6a886a1cac2d4725859d=
ab2325cd362312ddc659<br>Signed-off-by: Nexory &lt;St4yl3r30@hotmail=2Ede&gt=
;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Ra=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1884<br>Reported-By: Andre Kropp (Nexory)<br>R=
eported-By: ChinhNguyen<br>Message-Id: &lt;20260831083449=2E12484-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>(cherry picked from commit 1ece6fe6fd586501b486aac6932d424c167=
a3adb)<br>---<br>M src/openvpn/dhcp=2Ec<br>1 file changed, 192 insertions(+=
), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/05/1905/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/dhcp=2Ec b/src/openvpn/dhcp=2Ec</span><br><span>index f137b01=2E=2E0e03c=
ec 100644</span><br><span>--- a/src/openvpn/dhcp=2Ec</span><br><span>+++ b/=
src/openvpn/dhcp=2Ec</span><br><span>@@ -186,3 +186,195 @@</span><br><span>=
     }</span><br><span>     return 0;</span><br><span> }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if defined(_WIN32) || defined(DHCP_UNIT_TEST)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Convert DHCP options from the command line / config file</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * into a raw DHCP-format =
options string=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+write_dhcp_u8(struct buffer *buf, const uint8=
_t type, const uint8_t data, bool *error)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!buf_safe(buf, 3))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     *error =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(M_WARN, &quot;write_dhcp_u8: buffer overflow building DHCP op=
tions&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8(buf, ty=
pe);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write_u=
8(buf, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_w=
rite_u8(buf, data);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+write_dhcp_u32_array(struct buffer *buf, cons=
t uint8_t type, const uint32_t *data,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                     const unsigned int len, bool *error)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (len &gt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const size_t size =3D len * sizeof(uint32_t=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (!buf_safe(buf, 2 + size)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            *error =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_W=
ARN, &quot;write_dhcp_u32_array: buffer overflow building DHCP options&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (size &lt; 1 ||=
 size &gt; 255)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *e=
rror =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg(M_WARN, &quot;write_dhcp_u32_array: size (%zu) must be &gt; 0 an=
d &lt;=3D 255&quot;, size);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            return;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      buf_write_u8(buf, type);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        buf_write_u8(buf, (uint8_t)size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for (unsigned int i =3D 0; i &lt;=
 len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_wri=
te_u32(buf, data[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+write_dhcp_str(struct buffer *buf, const uint8_t type, const char *=
str, bool *error)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t len=
 =3D strlen(str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!buf_safe(buf, 2 + len))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     *error =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(M_WARN, &quot;write_dhcp_str: buffer overflow building DHCP o=
ptions&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 1 || l=
en &gt; 255)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *error =3D tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WA=
RN, &quot;write_dhcp_str: string &#39;%s&#39; must be &gt; 0 bytes and &lt;=
=3D 255 bytes&quot;, str);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_wri=
te_u8(buf, type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buf_write_u8(buf, (uint8_t)len);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_write(buf, str, len);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * RFC3397 states that multip=
le searchdomains are encoded as follows:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  - at start the length of the entire option is give=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - each subdoma=
in is preceded by its length</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  - each searchdomain is separated by a NUL character</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * e=2Eg=2E if you want &quot;=
openvpn=2Enet&quot; and &quot;duckduckgo=2Ecom&quot; then you end up with</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  0x1D  0x7 openvpn=
 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+w=
rite_dhcp_search_str(struct buffer *buf, const uint8_t type, const char *co=
nst *str_array,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                  int array_len, bool *error)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    char tmp_buf[256];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    size_t len =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    size_t label_length_pos;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (int i =3D 0; i &lt; array_len; i++)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const char *ptr =3D str_array[i];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* Each entry consumes strlen(ptr) + 2 bytes: one =
leading label length</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+         * byte and one trailing NUL=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (strlen(ptr) + len + 2 &gt; sizeof(tmp_b=
uf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            *error =3D tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(=
M_WARN, &quot;write_dhcp_search_str: temp buffer overflow building DHCP opt=
ions&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Loop o=
ver all subdomains separated by a dot and replace the dot</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * with the length of the sub=
domain */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /* label_length_pos p=
oints to the byte to be replaced by the length</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * of the following domain label */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        label_length_pos=
 =3D len++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        while (true)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (*ptr =3D=3D &#39;=2E=
&#39; || *ptr =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                /* cast is protected by sizeof(tmp_buf) */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                tmp_buf[lab=
el_length_pos] =3D (char)(len - label_length_pos - 1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                label_length_pos =3D len=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if=
 (*ptr =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    break;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            tmp_buf[len++] =3D *ptr++;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* And close off with an extra NUL char */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        tmp_buf[len++] =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!buf_safe(buf, 2 + len))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        *error =3D true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;write_search_dhcp_str: =
buffer overflow building DHCP options&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (len &gt; 255)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    *error =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(M_WARN, &quot;write_dhcp_search_str: search domain string must=
 be &lt;=3D 255 bytes&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8(buf, type)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8(b=
uf, (uint8_t)len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   buf_write(buf, tmp_buf, len);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+build_dhcp_options_string(struct buffer=
 *buf, const struct tuntap_options *o)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    bool error =3D false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (o-&gt;domain)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   write_dhcp_str(buf, DHCP_DOMAIN_NAME, o-&gt;domain, &amp;error);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (o-&gt;netbios_scope)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        write_dhcp_str(buf, DHCP_NETBIOS_SCOPE, o-&gt;netbios_sco=
pe, &amp;error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;netbios_node_type)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        write_dhcp_u8(buf, DHCP_NETBI=
OS_NODE_TYPE, o-&gt;netbios_node_type, &amp;error);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    write_dhcp_u32_array(buf, DHCP_DOMAIN_SERVER, (uint32_t *)o-&gt;dns, o=
-&gt;dns_len, &amp;error);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    write_dhcp_u32_array(buf, DHCP_NETBIOS_DOMAIN_SERVER, (uint32_t =
*)o-&gt;wins, o-&gt;wins_len, &amp;error);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    write_dhcp_u32_array(buf, DHCP_NTP_SERVER, (uint=
32_t *)o-&gt;ntp, o-&gt;ntp_len, &amp;error);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    write_dhcp_u32_array(buf, DHCP_NETBIOS_DIST_S=
ERVER, (uint32_t *)o-&gt;nbdd, o-&gt;nbdd_len, &amp;error);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (o-&gt;domain_search_list_len &gt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        write_dhcp_search_str(buf, DHCP_D=
OMAIN_SEARCH, o-&gt;domain_search_list, o-&gt;domain_search_list_len, &amp;=
error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* the MS DHCP server option &#39;Disable=
 Netbios-over-TCP/IP</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * is implemented as vendor option 001, value 002=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * A value of 001 means &#39;leav=
e NBT alone&#39; which is the default */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (o-&gt;disable_nbt)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (!buf_safe(buf, 8))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg(M_WARN, &quot;build_dhcp_options_string: buf=
fer overflow building DHCP options&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        buf_write_u8(buf, DHCP_VENDOR);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        buf_write_u8(buf, 6); /* tot=
al length field */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       buf_write_u8(buf, 0x001);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        buf_write_u8(buf, 4); /* length of the vendor specifie=
d field */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        b=
uf_write_u32(buf, 0x002);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn !error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif /* defined(_WIN32) */</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1905?usp=3Demail">change 1905</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1905?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E6 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd3=
62312ddc659 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1905 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D=
"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

<=
/body></html>
--K4aXggQpk+4=--


--===============5252115544850771127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5252115544850771127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5252115544850771127==--

