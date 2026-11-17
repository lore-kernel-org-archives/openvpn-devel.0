Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25A606A330
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jZuZAgLA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NNvS/wn1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eLZi8tN2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bhM/X1rN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6zXS2rmLQTk+m20DPR0ftuxN+h4+R/CX9Sb2JyqSjKs=; b=jZuZAgLAJsbSTUZdJSZz9fwaVv
	nLv0GLXxp8GOThQ4okPo5sMUBB/uF4PS5HtY75d7zVEq0friy49BWT+eH/v2ln7gkG3O+g2Lr35qY
	6sa7wmGAnA/SysUs9eTcAojmCKM+vdg1SuMH2Xqujiwfrf39WJoXxEAqMLfTX3p/20YI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTHAa-0000000033g-3B8B;
	Tue, 17 Nov 2026 11:16:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTHAZ-0000000033Y-2dFH
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:16:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I2DTjv5V9eWlh1FmQqfFjUeEdtJW7hbBd8Epm1sbNQs=; b=NNvS/wn1al12Q+cPnIQ8YlVuxA
 zyy7hb+kca1xmrfd0yVyeeuy8igSMKEh/PbGCcluRULJi4xbLQPqTqfdQBMYjpJHO47WVon5eci6e
 7NPkgQYkFI+uQiaIyanui1d+jcE7iXT0zVZe5kADDjB5dLTW5qdT+h391GPUG19o08sk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I2DTjv5V9eWlh1FmQqfFjUeEdtJW7hbBd8Epm1sbNQs=; b=eLZi8tN2uKu9XC91VFSpbjOLPa
 Mc+BEXPnsiwixLyPl6kpxXKJl/O9iag4Nj053g4nejP88W67kbtklIbKzthIsKO6EIroc2IbRJJTF
 DcB1H6GJ2I9VDCFxBh0aYXaA5VQIK9P7YAAgxl1zjt66A0woLd5LO3TbfMPP71l57mGM=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTHAX-0000000039w-1e3U for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:16:11 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so47164495e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 03:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794914163; x=1795518963; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I2DTjv5V9eWlh1FmQqfFjUeEdtJW7hbBd8Epm1sbNQs=;
 b=bhM/X1rNx4gB4VWwF8qhSxnfkR7p5YOVg6mtXpW1gAgoul6aVpphBraW2GTWIGBOWv
 RJKuD08ELnGPphQkhC9PkHKPPF/5rDFFx/SY9uUGVOs70r0Y1Ty+QM7JbEtyR8ByEpzW
 AKggsqsi33POlm14FELTvWROHj9dtIy50x40bLhfqPIYvVyZqgZqndo3LtpwZE8efELC
 J98M/msgD1JQXWLDMQEFHvJCGL3exJTPAdTfs1Hqx15JwpuHhM7HrDxELbay4x6awN7k
 t6ZC85I0YsjEcXcgqnN97iGbxiSorEOabNoCrRo2mrTPd6JW277BgFvF7sESyInA6n7t
 0ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794914163; x=1795518963;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I2DTjv5V9eWlh1FmQqfFjUeEdtJW7hbBd8Epm1sbNQs=;
 b=Hg7uhVCEIeFoDC1NpY7Qce+j9BT2Z3mxMJvMdiYqi4vlDGr5eOQiIDJKVEkGXiDnMT
 rg6wk7q8uzb52gq82b3nPukaY2hB4BMAlElajDS5HAo6cJDLF+hJeEWeaZYDoh/XjL9c
 y6DNf6JJdLWIrSbJyJJAszB5ixjnJjUY+Ctr1kMMfvaG32Ze356GDBka/GIBKk6zzs5g
 of6By0UEX1N/93mW+pzthSbr3RzPVV9NVoqUNyidgHRgtZkVFGj71HA82LFdP9kNSAQn
 tI/KvtSFDN6VxlDu3i5pKvRC5kNi4nG9qN5mrtb6fwnCOTJo6n9qQRKFaoEZUWQ0zTAX
 KQRg==
X-Gm-Message-State: APuU4Z9K9rQ+F5+mPX+qaEvq1xTl19ySDv11y2ZlVJ3iUx6JpNDkBb/+
 +D9T60rfZmpKfGME0j0er3UTxE/E/PFA/gKLhBy2J/qrVW1ONZF8dci2G9xU5Hf36UA8RhAChKV
 lmsHca/h7mkrn4unYDaOit3UzNectOsys8ubfNp/Pr0bMccvQqrMuQbHCSqDECctXZOzm
X-Gm-Gg: AYBFou1S9M8w5nHYnSc3mfrp2Esg1aP2UGUmDbRyxRAdU9TchvkUTDF1AFi64+/lDvl
 4sLwImAT0+8YT/RMutaAPUI4h7e1UhvrZX+1rIRRON+cHRI5rsknKDKIX+IuONWMkZ2VSWmH5MI
 UrdiukvWwTDKaxKEZeRK6JAGHv8LvS44pSPXQd/y5k6nYwgdjE/BFo5qPgjq34jeuZXv50RHxd6
 Vzr7MtbLR1gEAcftM4d9607OAvHi81VlZD+3cHTFhKLtMhmac+PWENL6BRWjrieU1QurXHrHmGv
 gQFa4/ifA48xNSN9xZQtP+INmKwkrgKei7QlI2OWYHC8AVaoRYeg/FmRHXR3SSaYw4FRUM4HRYL
 kd2JcM2XeGrb1lZk03VcTrj0/o2EBRdbEewjMavORruzTRKFhTC1/cJ81a48B8YW3bWbGFN+yis
 8Ucum/p0xoGEuxjm5ZENO7qv1qpuPVkmSmy16Z/nSKPtCYRf7VPY8Tzco5Ns77G+HPVKeB9oVvm
 0FAu2z4B57y8yBcNr9qKW1AAGvifPnmiyliB8omTkfQuDln1OLtGMhhDXJ8k3kwZBNc8LGlnbkh
 DbpWjtbTq9Tcc5/Tf33m5/eC9lvqpfwwtkGoGSnxGe54O8oA926tDlaQYvp4xBr1+5SfCbvQASn
 j5vrLxmU3MrlMWKbbMCpFEsSj8BgP/CAQUD9XrFalHnGKinmihQFO1pDBoyFNpM+XnzQZxLvtj8
 6MRf9OfwH41uki8ws=
X-Received: by 2002:a05:600c:34cf:b0:4bb:6a2d:b440 with SMTP id
 5b1f17b1804b1-4bb6a2db5a1mr149070915e9.2.1794914162486; 
 Tue, 17 Nov 2026 03:16:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783c2650sm67512135e9.14.2026.11.17.03.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 03:16:02 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 11:16:00 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
X-Gerrit-Change-Number: 2198
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2198?usp=email>
X-Gerrit-Commit: 823653286f82e2fbcd1ff1687a8a01b3fb6302e6
In-Reply-To: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
References: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkk5YzI0MDNjMjFlZjhmMjFhMGZiZDk5ODM0NmM4YWQ3MTliNGI5OTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ad6eb75aab8ed151d3e513f563352edc53d1b680-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTHAX-0000000039w-1e3U
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Switch
 buf_forward_capacity and buf_set_write to size_t
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7115899972537633800=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7115899972537633800==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZeuXjXt7zVY="; charset=UTF-8

--ZeuXjXt7zVY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
198?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: buffer: Switch buf_f=
orward_capacity and buf_set_write to size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Switch buf_forward_capacity and buf=
_set_write to size_t

To make them consistent with buf_forward_capacity_tot=
al
and buf_set_read that were already switched=2E

Review call sites=2E

Ch=
ange-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
Signed-off-by: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198
Messa=
ge-Id: <20261117101909=2E30743-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41509=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/crypto=2Ec
M src/openvpn/=
crypto_openssl=2Ec
M src/openvpn/push=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M s=
rc/openvpn/ssl_ncp=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/status=
=2Ec
M src/openvpn/tls_crypt=2Ec
M src/openvpn/tun=2Ec
11 files changed, 39=
 insertions(+), 56 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/98/2198/4

diff --git a/src/openvpn/buffer=2Ec b/=
src/openvpn/buffer=2Ec
index c60936a=2E=2Ec33a987 100644
--- a/src/openvpn/=
buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -234,17 +234,16 @@
     if (buf_=
defined(buf))
     {
         char *ptr =3D (char *)BEND(buf);
-        int=
 cap =3D buf_forward_capacity(buf);
+        size_t cap =3D buf_forward_cap=
acity(buf);
 
         if (cap > 1) /* can write more than \0 */
         {=

-            int stat;
             va_list arglist;
             va_start=
(arglist, format);
-            stat =3D vsnprintf(ptr, cap, format, arglis=
t);
+            int stat =3D vsnprintf(ptr, cap, format, arglist);
       =
      va_end(arglist);
             buf->len +=3D (int)strnlen(ptr, cap);
-=
            if (stat >=3D 0 && stat < cap)
+            if (stat >=3D 0 && =
stat < (int)cap)
             {
                 ret =3D true;
            =
 }
@@ -257,11 +256,11 @@
 buf_puts(struct buffer *buf, const char *str)
 {
=
     char *ptr =3D (char *)BEND(buf);
-    int cap =3D buf_forward_capacity=
(buf);
+    size_t cap =3D buf_forward_capacity(buf);
     if (cap > 1) /* =
can write more than \0 */
     {
-        int str_len =3D (int)strlcpy(ptr,=
 str, cap);
-        buf->len +=3D (str_len < cap) ? str_len : cap - 1;
+  =
      size_t str_len =3D strlcpy(ptr, str, cap);
+        buf->len +=3D (st=
r_len < cap) ? (int)str_len : (int)cap - 1;
     }
 }
 
diff --git a/src/op=
envpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 541f0bd=2E=2E32b49d3 100644=

--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -643,11 +643,=
6 @@
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#=
pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversi=
on"
-#endif
-
 /**
  * Initialise a buffer with an externally provided writ=
able memory region=2E
  *
@@ -660,7 +655,7 @@
  * @param size  Size of the =
memory region in bytes=2E
  */
 static inline void
-buf_set_write(struct bu=
ffer *buf, uint8_t *data, int size)
+buf_set_write(struct buffer *buf, uint=
8_t *data, size_t size)
 {
     if (!buf_size_valid(size))
     {
@@ -668,7=
 +663,7 @@
     }
     buf->len =3D 0;
     buf->offset =3D 0;
-    buf->ca=
pacity =3D size;
+    buf->capacity =3D (int)size;
     buf->data =3D data;=

     if (size > 0 && data)
     {
@@ -1039,7 +1034,7 @@
  * @return Number=
 of bytes available for appending, or 0 if \c buf is
  *         invalid=2E=

  */
-static inline int
+static inline size_t
 buf_forward_capacity(const =
struct buffer *buf)
 {
     if (buf_valid(buf))
@@ -1049,7 +1044,7 @@
     =
    {
             ret =3D 0;
         }
-        return ret;
+        retu=
rn (size_t)ret;
     }
     else
     {
@@ -1252,6 +1247,11 @@
     return =
true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*=
*
  * Prepend data to a buffer=2E
  *
diff --git a/src/openvpn/crypto=2Ec b=
/src/openvpn/crypto=2Ec
index db1cb41=2E=2E8b4cc3b 100644
--- a/src/openvpn=
/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1825,7 +1825,7 @@
 bool
 gener=
ate_ephemeral_key(struct buffer *key, const char *key_name)
 {
-    const i=
nt len =3D BCAP(key);
+    const int len =3D (int)BCAP(key);
 
     msg(M_I=
NFO, "Using random %s=2E", key_name);
 
diff --git a/src/openvpn/crypto_ope=
nssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index 0a1d00c=2E=2E1246bc6 100644=

--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
=
@@ -523,7 +523,7 @@
     uint8_t *dst_data =3D buf_write_alloc(dst, data_re=
ad_len);
     if (!dst_data)
     {
-        dmsg(D_CRYPT_ERRORS, "%s: dst =
too small (%i, needs %li)", __func__, BCAP(dst),
+        dmsg(D_CRYPT_ERRO=
RS, "%s: dst too small (%zu, needs %li)", __func__, BCAP(dst),
            =
  data_read_len);
         goto cleanup;
     }
diff --git a/src/openvpn/pu=
sh=2Ec b/src/openvpn/push=2Ec
index 6f628b8=2E=2Eeb11107 100644
--- a/src/o=
penvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -805,7 +805,7 @@
 #endif
 
 s=
tatic bool
-send_push_options(struct context *c, struct buffer *buf, struct=
 push_list *push_list, int safe_cap,
+send_push_options(struct context *c, =
struct buffer *buf, struct push_list *push_list, size_t safe_cap,
         =
          bool *push_sent, bool *multi_push)
 {
     struct push_entry *e =
=3D push_list->head;
@@ -820,7 +820,7 @@
                 msg(M_WARN, "--pu=
sh option is too long");
                 return false;
             }
-   =
         if (BLEN(buf) + (int)l >=3D safe_cap)
+            if (BLENZ(buf) =
+ l >=3D safe_cap)
             {
                 buf_printf(buf, ",push-c=
ontinuation 2");
                 {
@@ -835,7 +835,7 @@
                   =
  buf_printf(buf, "%s", push_reply_cmd);
                 }
             }
=
-            if (BLEN(buf) + (int)l >=3D safe_cap)
+            if (BLENZ(b=
uf) + l >=3D safe_cap)
             {
                 msg(M_WARN, "--push =
option is too long");
                 return false;
@@ -873,8 +873,8 @@
  =
   struct gc_arena gc =3D gc_new();
     struct buffer buf =3D alloc_buf_gc=
(PUSH_BUNDLE_SIZE, &gc);
     bool multi_push =3D false;
-    const int ext=
ra =3D 84; /* extra space for possible trailing ifconfig and push-continuat=
ion */
-    const int safe_cap =3D BCAP(&buf) - extra;
+    const size_t ex=
tra =3D 84; /* extra space for possible trailing ifconfig and push-continua=
tion */
+    const size_t safe_cap =3D BCAP(&buf) - extra;
     bool push_s=
ent =3D false;
 
     buf_printf(&buf, "%s", push_reply_cmd);
diff --git a/=
src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 93e67fd=2E=
=2E19a2d48 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_m=
bedtls=2Ec
@@ -1063,7 +1063,6 @@
 key_state_read_ciphertext(struct key_stat=
e_ssl *ks, struct buffer *buf)
 {
     int retval =3D 0;
-    int len =3D 0=
;
 
     ASSERT(NULL !=3D ks);
     ASSERT(buf);
@@ -1074,9 +1073,7 @@
    =
     return 0;
     }
 
-    len =3D buf_forward_capacity(buf);
-
-    retv=
al =3D endless_buf_read(&ks->bio_ctx->out, BPTR(buf), len);
+    retval =3D=
 endless_buf_read(&ks->bio_ctx->out, BPTR(buf), BCAP(buf));
 
     /* Error=
 during read, check for retry error */
     if (retval < 0)
@@ -1148,7 +114=
5,6 @@
 key_state_read_plaintext(struct key_state_ssl *ks, struct buffer *b=
uf)
 {
     int retval =3D 0;
-    int len =3D 0;
 
     ASSERT(NULL !=3D k=
s);
     ASSERT(buf);
@@ -1159,9 +1155,7 @@
         return 0;
     }
 
-  =
  len =3D buf_forward_capacity(buf);
-
-    retval =3D mbedtls_ssl_read(ks-=
>ctx, BPTR(buf), len);
+    retval =3D mbedtls_ssl_read(ks->ctx, BPTR(buf),=
 BCAP(buf));
 
     /* Error during read, check for retry error */
     if =
(retval < 0)
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec=

index df9e42c=2E=2E7b15f5f 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/=
openvpn/ssl_ncp=2Ec
@@ -154,7 +154,7 @@
             }
 
             /* En=
sure buffer has capacity for cipher name + : + \0 */
-            if (buf_f=
orward_capacity(&new_list) < (int)strlen(ovpn_cipher_name) + 2)
+          =
  if (buf_forward_capacity(&new_list) < strlen(ovpn_cipher_name) + 2)
     =
        {
                 msg(M_WARN, "Length of --data-ciphers is over th=
e "
                             "limit of 127 chars");
@@ -563,8 +563,7 @@=

     uint8_t *ncp_ciphers =3D gc_malloc(ncp_ciphers_len, true, &o->gc);
 
=
     struct buffer ncp_ciphers_buf;
-    ASSERT(ncp_ciphers_len <=3D INT_MA=
X);
-    buf_set_write(&ncp_ciphers_buf, ncp_ciphers, (int)ncp_ciphers_len)=
;
+    buf_set_write(&ncp_ciphers_buf, ncp_ciphers, ncp_ciphers_len);
 
   =
  const char *def =3D strstr(o->ncp_ciphers, search);
 
diff --git a/src/op=
envpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 57ef9f7=2E=2E30ef=
383 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=
=2Ec
@@ -2155,13 +2155,12 @@
          * if the buffer is not empty */
    =
     return 0;
     }
-    int len =3D buf_forward_capacity(buf);
 
     /*=

      * BIO_read brackets most of the serious RSA
      * key negotiation =
number crunching=2E
      */
-    int i =3D BIO_read(bio, BPTR(buf), len);
=
+    int i =3D BIO_read(bio, BPTR(buf), (int)BCAP(buf));
 
     VALGRIND_MA=
KE_READABLE((void *)&i, sizeof(i));
 
diff --git a/src/openvpn/status=2Ec b=
/src/openvpn/status=2Ec
index 533619f=2E=2E0a3fc019 100644
--- a/src/openvp=
n/status=2Ec
+++ b/src/openvpn/status=2Ec
@@ -215,11 +215,6 @@
     return =
ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnos=
tic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 #de=
fine STATUS_PRINTF_MAXLEN 512
 
 void
@@ -281,7 +276,7 @@
             if (=
c =3D=3D -1)
             {
                 ASSERT(buf_init(&so->read_buf,=
 0));
-                ssize_t len =3D read(so->fd, BPTR(&so->read_buf), BC=
AP(&so->read_buf));
+                ssize_t len =3D read(so->fd, BPTR(&so-=
>read_buf), (unsigned int)BCAP(&so->read_buf));
                 if (len <=
=3D 0)
                 {
                     break;
@@ -311,7 +306,3 @@
 =

     return ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragm=
a GCC diagnostic pop
-#endif
diff --git a/src/openvpn/tls_crypt=2Ec b/src/o=
penvpn/tls_crypt=2Ec
index d7f69f7=2E=2E5617ad3 100644
--- a/src/openvpn/tl=
s_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -380,8 +380,8 @@
         ms=
g(M_WARN, "ERROR: could not write tag");
         return false;
     }
-   =
 const int data_len =3D BLEN(src_metadata) + sizeof(src_key->keys) + sizeof=
(uint16_t);
-    const int tagged_len =3D data_len + TLS_CRYPT_TAG_SIZE;
+ =
   const size_t data_len =3D BLENZ(src_metadata) + sizeof(src_key->keys) + =
sizeof(uint16_t);
+    const size_t tagged_len =3D data_len + TLS_CRYPT_TAG=
_SIZE;
     const uint16_t net_len =3D htons((uint16_t)tagged_len);
     hm=
ac_ctx_t *hmac_ctx =3D server_key->hmac;
     hmac_ctx_reset(hmac_ctx);
@@ =
-396,7 +396,7 @@
     ASSERT(cipher_ctx_reset(cipher_ctx, tag));
 
     /* =
Overflow check (OpenSSL requires an extra block in the dst buffer) */
-    =
const int padded_len =3D data_len + cipher_ctx_block_size(cipher_ctx);
+   =
 const size_t padded_len =3D data_len + cipher_ctx_block_size(cipher_ctx);
=
     if (buf_forward_capacity(&work) < padded_len)
     {
         msg(M_WA=
RN, "ERROR: could not crypt: insufficient space in dst");
@@ -735,7 +735,7 =
@@
         size_t b64_length =3D strlen(b64_metadata);
         metadata =
=3D alloc_buf_gc(OPENVPN_BASE64_DECODED_LENGTH(b64_length) + 1, &gc);
     =
    ASSERT(buf_write(&metadata, &TLS_CRYPT_METADATA_TYPE_USER, 1));
-      =
  int decoded_len =3D openvpn_base64_decode(b64_metadata, BEND(&metadata), =
BCAP(&metadata));
+        int decoded_len =3D openvpn_base64_decode(b64_me=
tadata, BEND(&metadata), (int)BCAP(&metadata));
         if (decoded_len < =
0)
         {
             msg(M_FATAL, "ERROR: failed to base64 decode pro=
vided metadata");
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
in=
dex 0ba8a4a=2E=2Ec56ace3 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn=
/tun=2Ec
@@ -4008,7 +4008,7 @@
  * registry for the TAP device # =3D device=
_number=2E
  */
 static const char *
-get_unspecified_device_guid(const int=
 device_number, uint8_t *actual_name, int actual_name_size,
+get_unspecifie=
d_device_guid(const int device_number, uint8_t *actual_name, size_t actual_=
name_size,
                             const struct tap_reg *tap_reg_src,
=
                             const struct panel_reg *panel_reg_src,
       =
                      enum tun_driver_type *windows_driver, struct gc_arena=
 *gc)
@@ -4071,7 +4071,7 @@
  * returning the GUID and optional actual_name=
 and device type
  */
 static const char *
-get_device_guid(const char *nam=
e, uint8_t *actual_name, int actual_name_size,
+get_device_guid(const char =
*name, uint8_t *actual_name, size_t actual_name_size,
                 enum=
 tun_driver_type *windows_driver, const struct tap_reg *tap_reg,
          =
       const struct panel_reg *panel_reg, struct gc_arena *gc)
 {
@@ -6087,=
8 +6087,9 @@
     {
         struct buffer out =3D alloc_buf_gc(256, gc);
 =
        DWORD len;
-        if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET=
_INFO, BSTR(&out), BCAP(&out), BSTR(&out),
-                            BCA=
P(&out), &len, NULL))
+        if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_=
GET_INFO, BSTR(&out),
+                            (DWORD)BCAP(&out), BSTR(=
&out),
+                            (DWORD)BCAP(&out), &len, NULL))
       =
  {
             return BSTR(&out);
         }
@@ -6103,8 +6104,8 @@
     {=

         struct buffer out =3D alloc_buf(1024);
         DWORD len;
-     =
   while (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(&out),=
 BCAP(&out),
-                               BSTR(&out), BCAP(&out), &len, =
NULL))
+        while (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_LOG_LINE=
, BSTR(&out), (DWORD)BCAP(&out),
+                               BSTR(&out)=
, (DWORD)BCAP(&out), &len, NULL))
         {
             msg(D_TAP_WIN_DEB=
UG, "TAP-Windows: %s", BSTR(&out));
         }

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
G=
errit-Change-Number: 2198
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ZeuXjXt7zVY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2198?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">buffer: Switch buf_forward_capacity and buf_set_write to size_t<br><br>=
To make them consistent with buf_forward_capacity_total<br>and buf_set_read=
 that were already switched=2E<br><br>Review call sites=2E<br><br>Change-Id=
: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972<br>Signed-off-by: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2198<br>Message-Id: &lt;20261117101909=2E30743-1-gert@greenie=2Emuc=2Ed=
e&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg41509=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=
=2Eh<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto_openssl=2Ec<br>M s=
rc/openvpn/push=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_n=
cp=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/status=2Ec<br>M sr=
c/openvpn/tls_crypt=2Ec<br>M src/openvpn/tun=2Ec<br>11 files changed, 39 in=
sertions(+), 56 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/98/2198/4</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index c60=
936a=2E=2Ec33a987 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span=
><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -234,17 +234,16 =
@@</span><br><span>     if (buf_defined(buf))</span><br><span>     {</span>=
<br><span>         char *ptr =3D (char *)BEND(buf);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        int cap =3D buf_forward_capacity(bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t c=
ap =3D buf_forward_capacity(buf);</span><br><span> </span><br><span>       =
  if (cap &gt; 1) /* can write more than \0 */</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int stat;</=
span><br><span>             va_list arglist;</span><br><span>             v=
a_start(arglist, format);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            stat =3D vsnprintf(ptr, cap, format, arglist);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            int stat =3D vsnprin=
tf(ptr, cap, format, arglist);</span><br><span>             va_end(arglist)=
;</span><br><span>             buf-&gt;len +=3D (int)strnlen(ptr, cap);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (stat &gt;=
=3D 0 &amp;&amp; stat &lt; cap)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (stat &gt;=3D 0 &amp;&amp; stat &lt; (int)cap)</=
span><br><span>             {</span><br><span>                 ret =3D true=
;</span><br><span>             }</span><br><span>@@ -257,11 +256,11 @@</spa=
n><br><span> buf_puts(struct buffer *buf, const char *str)</span><br><span>=
 {</span><br><span>     char *ptr =3D (char *)BEND(buf);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int cap =3D buf_forward_capacity(buf=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t cap =
=3D buf_forward_capacity(buf);</span><br><span>     if (cap &gt; 1) /* can =
write more than \0 */</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        int str_len =3D (int)strlcpy(ptr, str, cap);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf-&gt;len +=
=3D (str_len &lt; cap) ? str_len : cap - 1;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        size_t str_len =3D strlcpy(ptr, str, cap);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf-&gt;len =
+=3D (str_len &lt; cap) ? (int)str_len : (int)cap - 1;</span><br><span>    =
 }</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/op=
envpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 541f0bd=2E=
=2E32b49d3 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><s=
pan>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -643,11 +643,6 @@</span=
><br><span>     return true;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Initialise a=
 buffer with an externally provided writable memory region=2E</span><br><sp=
an>  *</span><br><span>@@ -660,7 +655,7 @@</span><br><span>  * @param size =
 Size of the memory region in bytes=2E</span><br><span>  */</span><br><span=
> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-b=
uf_set_write(struct buffer *buf, uint8_t *data, int size)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+buf_set_write(struct buffer *buf, uin=
t8_t *data, size_t size)</span><br><span> {</span><br><span>     if (!buf_s=
ize_valid(size))</span><br><span>     {</span><br><span>@@ -668,7 +663,7 @@=
</span><br><span>     }</span><br><span>     buf-&gt;len =3D 0;</span><br><=
span>     buf-&gt;offset =3D 0;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    buf-&gt;capacity =3D size;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf-&gt;capacity =3D (int)size;</span><br><span>  =
   buf-&gt;data =3D data;</span><br><span>     if (size &gt; 0 &amp;&amp; d=
ata)</span><br><span>     {</span><br><span>@@ -1039,7 +1034,7 @@</span><br=
><span>  * @return Number of bytes available for appending, or 0 if \c buf =
is</span><br><span>  *         invalid=2E</span><br><span>  */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static inline size_t</span><br><span=
> buf_forward_capacity(const struct buffer *buf)</span><br><span> {</span><=
br><span>     if (buf_valid(buf))</span><br><span>@@ -1049,7 +1044,7 @@</sp=
an><br><span>         {</span><br><span>             ret =3D 0;</span><br><=
span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return (size_t)ret;</span><br><span>     }</span><br><span>     else</spa=
n><br><span>     {</span><br><span>@@ -1252,6 +1247,11 @@</span><br><span> =
    return true;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Prepend data=
 to a buffer=2E</span><br><span>  *</span><br><span>diff --git a/src/openvp=
n/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index db1cb41=2E=2E8b=
4cc3b 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+=
++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1825,7 +1825,7 @@</span><br=
><span> bool</span><br><span> generate_ephemeral_key(struct buffer *key, co=
nst char *key_name)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const int len =3D BCAP(key);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const int len =3D (int)BCAP(key);</span><=
br><span> </span><br><span>     msg(M_INFO, &quot;Using random %s=2E&quot;,=
 key_name);</span><br><span> </span><br><span>diff --git a/src/openvpn/cryp=
to_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>index 0a1d0=
0c=2E=2E1246bc6 100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec=
</span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -5=
23,7 +523,7 @@</span><br><span>     uint8_t *dst_data =3D buf_write_alloc(d=
st, data_read_len);</span><br><span>     if (!dst_data)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_CRY=
PT_ERRORS, &quot;%s: dst too small (%i, needs %li)&quot;, __func__, BCAP(ds=
t),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_C=
RYPT_ERRORS, &quot;%s: dst too small (%zu, needs %li)&quot;, __func__, BCAP=
(dst),</span><br><span>              data_read_len);</span><br><span>      =
   goto cleanup;</span><br><span>     }</span><br><span>diff --git a/src/op=
envpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 6f628b8=2E=2Eeb=
11107 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++=
 b/src/openvpn/push=2Ec</span><br><span>@@ -805,7 +805,7 @@</span><br><span=
> #endif</span><br><span> </span><br><span> static bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-send_push_options(struct context *c, stru=
ct buffer *buf, struct push_list *push_list, int safe_cap,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+send_push_options(struct context *c,=
 struct buffer *buf, struct push_list *push_list, size_t safe_cap,</span><b=
r><span>                   bool *push_sent, bool *multi_push)</span><br><sp=
an> {</span><br><span>     struct push_entry *e =3D push_list-&gt;head;</sp=
an><br><span>@@ -820,7 +820,7 @@</span><br><span>                 msg(M_WAR=
N, &quot;--push option is too long&quot;);</span><br><span>                =
 return false;</span><br><span>             }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            if (BLEN(buf) + (int)l &gt;=3D safe_cap=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (BL=
ENZ(buf) + l &gt;=3D safe_cap)</span><br><span>             {</span><br><sp=
an>                 buf_printf(buf, &quot;,push-continuation 2&quot;);</spa=
n><br><span>                 {</span><br><span>@@ -835,7 +835,7 @@</span><b=
r><span>                     buf_printf(buf, &quot;%s&quot;, push_reply_cmd=
);</span><br><span>                 }</span><br><span>             }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(buf) + =
(int)l &gt;=3D safe_cap)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if (BLENZ(buf) + l &gt;=3D safe_cap)</span><br><span>     =
        {</span><br><span>                 msg(M_WARN, &quot;--push option =
is too long&quot;);</span><br><span>                 return false;</span><b=
r><span>@@ -873,8 +873,8 @@</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span>     struct buffer buf =3D alloc_buf_gc(PUSH_BUNDLE_=
SIZE, &amp;gc);</span><br><span>     bool multi_push =3D false;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    const int extra =3D 84; /* ex=
tra space for possible trailing ifconfig and push-continuation */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    const int safe_cap =3D BCAP=
(&amp;buf) - extra;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const size_t extra =3D 84; /* extra space for possible trailing ifconfi=
g and push-continuation */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const size_t safe_cap =3D BCAP(&amp;buf) - extra;</span><br><spa=
n>     bool push_sent =3D false;</span><br><span> </span><br><span>     buf=
_printf(&amp;buf, &quot;%s&quot;, push_reply_cmd);</span><br><span>diff --g=
it a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><s=
pan>index 93e67fd=2E=2E19a2d48 100644</span><br><span>--- a/src/openvpn/ssl=
_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><s=
pan>@@ -1063,7 +1063,6 @@</span><br><span> key_state_read_ciphertext(struct=
 key_state_ssl *ks, struct buffer *buf)</span><br><span> {</span><br><span>=
     int retval =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int len =3D 0;</span><br><span> </span><br><span>     ASSERT(NULL !=3D=
 ks);</span><br><span>     ASSERT(buf);</span><br><span>@@ -1074,9 +1073,7 =
@@</span><br><span>         return 0;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D buf_fo=
rward_capacity(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retval =3D endless=
_buf_read(&amp;ks-&gt;bio_ctx-&gt;out, BPTR(buf), len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    retval =3D endless_buf_read(&amp;ks=
-&gt;bio_ctx-&gt;out, BPTR(buf), BCAP(buf));</span><br><span> </span><br><s=
pan>     /* Error during read, check for retry error */</span><br><span>   =
  if (retval &lt; 0)</span><br><span>@@ -1148,7 +1145,6 @@</span><br><span>=
 key_state_read_plaintext(struct key_state_ssl *ks, struct buffer *buf)</sp=
an><br><span> {</span><br><span>     int retval =3D 0;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int len =3D 0;</span><br><span> </span=
><br><span>     ASSERT(NULL !=3D ks);</span><br><span>     ASSERT(buf);</sp=
an><br><span>@@ -1159,9 +1155,7 @@</span><br><span>         return 0;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    len =3D buf_forward_capacity(buf);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    retval =3D mbedtls_ssl_read(ks-&gt;ctx, BPTR(buf), len);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    retval =3D mbedtls_=
ssl_read(ks-&gt;ctx, BPTR(buf), BCAP(buf));</span><br><span> </span><br><sp=
an>     /* Error during read, check for retry error */</span><br><span>    =
 if (retval &lt; 0)</span><br><span>diff --git a/src/openvpn/ssl_ncp=2Ec b/=
src/openvpn/ssl_ncp=2Ec</span><br><span>index df9e42c=2E=2E7b15f5f 100644</=
span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/src/open=
vpn/ssl_ncp=2Ec</span><br><span>@@ -154,7 +154,7 @@</span><br><span>       =
      }</span><br><span> </span><br><span>             /* Ensure buffer has=
 capacity for cipher name + : + \0 */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (buf_forward_capacity(&amp;new_list) &lt; (i=
nt)strlen(ovpn_cipher_name) + 2)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if (buf_forward_capacity(&amp;new_list) &lt; strle=
n(ovpn_cipher_name) + 2)</span><br><span>             {</span><br><span>   =
              msg(M_WARN, &quot;Length of --data-ciphers is over the &quot;=
</span><br><span>                             &quot;limit of 127 chars&quot=
;);</span><br><span>@@ -563,8 +563,7 @@</span><br><span>     uint8_t *ncp_c=
iphers =3D gc_malloc(ncp_ciphers_len, true, &amp;o-&gt;gc);</span><br><span=
> </span><br><span>     struct buffer ncp_ciphers_buf;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ASSERT(ncp_ciphers_len &lt;=3D INT_MAX=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_set_write(&=
amp;ncp_ciphers_buf, ncp_ciphers, (int)ncp_ciphers_len);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    buf_set_write(&amp;ncp_ciphers_buf=
, ncp_ciphers, ncp_ciphers_len);</span><br><span> </span><br><span>     con=
st char *def =3D strstr(o-&gt;ncp_ciphers, search);</span><br><span> </span=
><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_opens=
sl=2Ec</span><br><span>index 57ef9f7=2E=2E30ef383 100644</span><br><span>--=
- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_opens=
sl=2Ec</span><br><span>@@ -2155,13 +2155,12 @@</span><br><span>          * =
if the buffer is not empty */</span><br><span>         return 0;</span><br>=
<span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int l=
en =3D buf_forward_capacity(buf);</span><br><span> </span><br><span>     /*=
</span><br><span>      * BIO_read brackets most of the serious RSA</span><b=
r><span>      * key negotiation number crunching=2E</span><br><span>      *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i =3D BIO_re=
ad(bio, BPTR(buf), len);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int i =3D BIO_read(bio, BPTR(buf), (int)BCAP(buf));</span><br><spa=
n> </span><br><span>     VALGRIND_MAKE_READABLE((void *)&amp;i, sizeof(i));=
</span><br><span> </span><br><span>diff --git a/src/openvpn/status=2Ec b/sr=
c/openvpn/status=2Ec</span><br><span>index 533619f=2E=2E0a3fc019 100644</sp=
an><br><span>--- a/src/openvpn/status=2Ec</span><br><span>+++ b/src/openvpn=
/status=2Ec</span><br><span>@@ -215,11 +215,6 @@</span><br><span>     retur=
n ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ig=
nored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> #define STATUS_PRINTF_MAXLEN 512</span><br><span> </span><=
br><span> void</span><br><span>@@ -281,7 +276,7 @@</span><br><span>        =
     if (c =3D=3D -1)</span><br><span>             {</span><br><span>      =
           ASSERT(buf_init(&amp;so-&gt;read_buf, 0));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                ssize_t len =3D read(so-&gt=
;fd, BPTR(&amp;so-&gt;read_buf), BCAP(&amp;so-&gt;read_buf));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                ssize_t len =3D r=
ead(so-&gt;fd, BPTR(&amp;so-&gt;read_buf), (unsigned int)BCAP(&amp;so-&gt;r=
ead_buf));</span><br><span>                 if (len &lt;=3D 0)</span><br><s=
pan>                 {</span><br><span>                     break;</span><b=
r><span>@@ -311,7 +306,3 @@</span><br><span> </span><br><span>     return r=
et;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span>diff --git a/src/openvpn/tls_crypt=2Ec b/src/=
openvpn/tls_crypt=2Ec</span><br><span>index d7f69f7=2E=2E5617ad3 100644</sp=
an><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/open=
vpn/tls_crypt=2Ec</span><br><span>@@ -380,8 +380,8 @@</span><br><span>     =
    msg(M_WARN, &quot;ERROR: could not write tag&quot;);</span><br><span>  =
       return false;</span><br><span>     }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const int data_len =3D BLEN(src_metadata) + sizeo=
f(src_key-&gt;keys) + sizeof(uint16_t);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    const int tagged_len =3D data_len + TLS_CRYPT_TAG_SIZ=
E;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t =
data_len =3D BLENZ(src_metadata) + sizeof(src_key-&gt;keys) + sizeof(uint16=
_t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_=
t tagged_len =3D data_len + TLS_CRYPT_TAG_SIZE;</span><br><span>     const =
uint16_t net_len =3D htons((uint16_t)tagged_len);</span><br><span>     hmac=
_ctx_t *hmac_ctx =3D server_key-&gt;hmac;</span><br><span>     hmac_ctx_res=
et(hmac_ctx);</span><br><span>@@ -396,7 +396,7 @@</span><br><span>     ASSE=
RT(cipher_ctx_reset(cipher_ctx, tag));</span><br><span> </span><br><span>  =
   /* Overflow check (OpenSSL requires an extra block in the dst buffer) */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int padded_=
len =3D data_len + cipher_ctx_block_size(cipher_ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const size_t padded_len =3D data_len =
+ cipher_ctx_block_size(cipher_ctx);</span><br><span>     if (buf_forward_c=
apacity(&amp;work) &lt; padded_len)</span><br><span>     {</span><br><span>=
         msg(M_WARN, &quot;ERROR: could not crypt: insufficient space in ds=
t&quot;);</span><br><span>@@ -735,7 +735,7 @@</span><br><span>         size=
_t b64_length =3D strlen(b64_metadata);</span><br><span>         metadata =
=3D alloc_buf_gc(OPENVPN_BASE64_DECODED_LENGTH(b64_length) + 1, &amp;gc);</=
span><br><span>         ASSERT(buf_write(&amp;metadata, &amp;TLS_CRYPT_META=
DATA_TYPE_USER, 1));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       int decoded_len =3D openvpn_base64_decode(b64_metadata, BEND(&amp;me=
tadata), BCAP(&amp;metadata));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        int decoded_len =3D openvpn_base64_decode(b64_metadata, =
BEND(&amp;metadata), (int)BCAP(&amp;metadata));</span><br><span>         if=
 (decoded_len &lt; 0)</span><br><span>         {</span><br><span>          =
   msg(M_FATAL, &quot;ERROR: failed to base64 decode provided metadata&quot=
;);</span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec<=
/span><br><span>index 0ba8a4a=2E=2Ec56ace3 100644</span><br><span>--- a/src=
/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>=
@@ -4008,7 +4008,7 @@</span><br><span>  * registry for the TAP device # =3D=
 device_number=2E</span><br><span>  */</span><br><span> static const char *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_unspecified_devic=
e_guid(const int device_number, uint8_t *actual_name, int actual_name_size,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_unspecified_dev=
ice_guid(const int device_number, uint8_t *actual_name, size_t actual_name_=
size,</span><br><span>                             const struct tap_reg *ta=
p_reg_src,</span><br><span>                             const struct panel_=
reg *panel_reg_src,</span><br><span>                             enum tun_d=
river_type *windows_driver, struct gc_arena *gc)</span><br><span>@@ -4071,7=
 +4071,7 @@</span><br><span>  * returning the GUID and optional actual_name=
 and device type</span><br><span>  */</span><br><span> static const char *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_device_guid(const =
char *name, uint8_t *actual_name, int actual_name_size,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+get_device_guid(const char *name, uint8=
_t *actual_name, size_t actual_name_size,</span><br><span>                 =
enum tun_driver_type *windows_driver, const struct tap_reg *tap_reg,</span>=
<br><span>                 const struct panel_reg *panel_reg, struct gc_are=
na *gc)</span><br><span> {</span><br><span>@@ -6087,8 +6087,9 @@</span><br>=
<span>     {</span><br><span>         struct buffer out =3D alloc_buf_gc(25=
6, gc);</span><br><span>         DWORD len;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (DeviceIoControl(tt-&gt;hand, TAP_WIN_IOCT=
L_GET_INFO, BSTR(&amp;out), BCAP(&amp;out), BSTR(&amp;out),</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                            BCAP(&amp=
;out), &amp;len, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (DeviceIoControl(tt-&gt;hand, TAP_WIN_IOCTL_GET_INFO, BSTR(&=
amp;out),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                  (DWORD)BCAP(&amp;out), BSTR(&amp;out),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                            (DWORD)BCA=
P(&amp;out), &amp;len, NULL))</span><br><span>         {</span><br><span>  =
           return BSTR(&amp;out);</span><br><span>         }</span><br><spa=
n>@@ -6103,8 +6104,8 @@</span><br><span>     {</span><br><span>         str=
uct buffer out =3D alloc_buf(1024);</span><br><span>         DWORD len;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        while (DeviceIoCo=
ntrol(tt-&gt;hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(&amp;out), BCAP(&amp;ou=
t),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
             BSTR(&amp;out), BCAP(&amp;out), &amp;len, NULL))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        while (DeviceIoControl(tt=
-&gt;hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(&amp;out), (DWORD)BCAP(&amp;out=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
              BSTR(&amp;out), (DWORD)BCAP(&amp;out), &amp;len, NULL))</span=
><br><span>         {</span><br><span>             msg(D_TAP_WIN_DEBUG, &qu=
ot;TAP-Windows: %s&quot;, BSTR(&amp;out));</span><br><span>         }</span=
><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2198?usp=3Demail">change 2198</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2198?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b=
4b9972 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2198 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--ZeuXjXt7zVY=--


--===============7115899972537633800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7115899972537633800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7115899972537633800==--

