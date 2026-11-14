Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7006606A323
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ehAsmzrn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=erWkU0Pf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JydedSed;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=B2jILTIw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3W14eiJH2wtjICl6VMiZ7qe4oRRNoH+oxyPX3EircDc=; b=ehAsmzrnEJMR4T6dAApvQwrvgL
	msohMJNPKubA1MOQf2gjIFywBPN1sNWC3rWuzJjh7aQxLaAGQhiYXARUobm7iG6WfClDYS1Ax7v9o
	WR+15SkZXiynhkvEMbbULNvwYOEbfLPW+JWFUA3V9f+Smwztb1n2yRZTUgNQmxUrubEw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSFPV-000000005AT-224O;
	Sat, 14 Nov 2026 15:11:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSFPS-000000005AL-1pcA
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z8KR6S8wYJ6P32XGho4OOlORjDpVwg8CqLn3lAMZnhM=; b=erWkU0Pfwey4Fxtq8YjFh0Z/s7
 vbnkGGc/k0RTYk89nx4ZmGxXtCZqbSprF37ZWl6ghv/nRijFAfgGvG+z7G4Nj8LLvIp3vbNJ/FJq7
 NsWL7vzmfFALPctVY1H6gkZ2m8ozH/EcBy+qpiRnpsu6/XFA5Sr4W2kEwm1MrUvGs4O0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z8KR6S8wYJ6P32XGho4OOlORjDpVwg8CqLn3lAMZnhM=; b=JydedSed4+0rpMyYh/rirbP5YB
 nOYK4lRnNcCz+RM+vTbqTOewVd5rj0+opxJqSL4yuELTR29V5jUslNX4g14Fdo2DaP50b/wgk5y8b
 H5dv0QJqTAoKXAHecpoHSA3PHGbEg2YZFF7Dr/pjXTKNHZQbY5aMeXZvd6xgZtSwc9F0=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSFPQ-000000000Xf-3Go0 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:11:18 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so807270f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 07:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794669070; x=1795273870; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z8KR6S8wYJ6P32XGho4OOlORjDpVwg8CqLn3lAMZnhM=;
 b=B2jILTIwho8IQP5ZNRD1QkfptPCU4fUdOcGkW/aoxQlrSIt4QGbMi2EY4440BkpddG
 zEJGsxdpDajQQ5r/FelT+YXYRF4NPmQ4LAfz8nOLRITqfnoGy2JBvxJD/oc1dYZ5uIk0
 4sDk/3qgUsp6l6/pYQosZzZZirGREwP9q+fVZlniKGUU6nbf4eePT0Lh2Sh0HhQvLpud
 INVUiPP4dhNlUyuObfn4sA18+mISCOxDKAjTa/aII3IloY9be8meDi7bO6oT1khafulf
 7HwWwqALNQhDkQwdTIJRn9vzDyRak9HSGzQ01cyWGZZENf9pp9aMyWX0T/R9A671QW6V
 zREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794669070; x=1795273870;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z8KR6S8wYJ6P32XGho4OOlORjDpVwg8CqLn3lAMZnhM=;
 b=OmzM9K5S/CEv8dDDErw8a/JT7vJkNUuFwBsUkIFkSq5cObEqbvFFa31fjmthJ5tSOq
 odMatp84Vdz+j6Vx+3qyhPpLxEfCv+Z1uDAV0fSpTffAnaxe0e5qx4kh7jDS/HUcL7+k
 pAtMouDCraO1rXZ7S3X2jzs+IYB/RbWb6rPHnsq/6qnaoosAwFVj4gapv1MDf2EVur25
 lhFnab8Xwaw5P+kZRg9NEF29MNDre2aiAWSy7RvzsPyuiJYF/hGXuUFIYNEoGxjriXi1
 DnxzIFTkvnvrW6guQjpzg5UHFPL96y/6n0wtTFcSfdovv+U2GAcjGnyYBBlkCRZJP0YK
 zj/w==
X-Forwarded-Encrypted: i=1;
 AL+hErE0qS1UbbS99WYRMC8Zg0n1VB2uqpnl/1eEZUcfo8dpwsGoPz5lA2fvXh+qBi5yCdjPHu4HSY1m2x6COs9s@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8CPEUtGBCgkhWmcutEkh4L/lAxhBnk6J92DBrz1LaSuPePVo8/
 S706bnFCe802Me58Iz9/reVC0v5Zh2hOgp3/sk/WKue7PPIjQnr6YbPWvbqj3otFcd43rvDiKJK
 tXL7y2wGTfYOq4+3C9v2fgmwO4s3bxWYxX9U8WzdX7iTfxT1gdb52H/ZryOm4vDpBEvTqdHr/Rf
 FvaJcYxA==
X-Gm-Gg: AYBFou3PBXOXhvkho4VnGKmhhOYZYsBPeHO7ti9Brr6nKvhFchpkYZEltKMbxuZDinK
 HiwcmU37HSxENyjl6z2793onuss66ZRE2hfYV131nT05iu1zyxuJcmChXzQyZM3jVvWDyRnbkJQ
 O3Bpo8P2HNLMhy+tgcU124EVYxMJFxkxQYbAKiKwHIjVTf0ih8soSuK/DGGt4hbDtvvf0Sk4m5l
 0+D9A76WKnDVwdMYfPCHONhd95S122vaEGQiDWBoJw0Zi6K1KVApqrPejN6fMRK4k0eY5oSVxB6
 ZhfTllyKzzX6JEAXH2N38kM+8QDVPElcMG0uPPgJmZnZv1VgriaB2R2NPhl80h48fnhbP1SgbmJ
 kRi8Bbm9hTHuh0/FCUF9X+1wI9FulkLhIFtQ2rdD6eTSNt9Rz2dro0fvkGtbeHs/tRGcz8gMIbI
 p2wftbcNmAhPVAshnb4I57X2Mqk5czjoH+wtYDG2FpuD6FeO8vfJPIwIxcDBMysc1QmVkZB61pQ
 NXpGgl2cu1FDRIG6VF31rFxNSb0O/bNWZl0Rpo63KSIpuLnvMV1ZICL2jRKit4xatwrD9Jz58Wb
 Rlo7VjvMewhMIyj1tJfMRnwHsWbQ9Bd4EBSCNzrZw6V+2GG8htR+On2zC4pl1Q00hN5KKtWMiAM
 QNU1DdTfw+kHM14qKKyWDwecGoLZMYGE5VNtNf3vCjvCA4rnXdk1K4ZFq/8n0Y37MWSKCqe6A2i
 vBndBssB5Kl5IUT/4=
X-Received: by 2002:a05:600c:8b56:b0:4a6:44b:2593 with SMTP id
 5b1f17b1804b1-4bb55ad0711mr121293615e9.29.1794669069967; 
 Sat, 14 Nov 2026 07:11:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm57770585e9.5.2026.11.14.07.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 07:11:09 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 15:11:09 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7
X-Gerrit-Change-Number: 2165
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2165?usp=email>
X-Gerrit-Commit: 400d7e59c82b7835c64e00ae45db2d55d4895c93
In-Reply-To: <gerrit.1794313546000.Ie2d784272184261a62c848e6ad3b7a4570ae6dc7@gerrit.openvpn.net>
References: <gerrit.1794313546000.Ie2d784272184261a62c848e6ad3b7a4570ae6dc7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzEzNTQ2MDAwLkllMmQ3ODQyNzIxODQyNjFhNjJjODQ4ZTZhZDNiN2E0NTcwYWU2ZGM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b4291b15513924c9710c9026e832052aa20d83fa-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSFPQ-000000000Xf-3Go0
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Change
 return type of buf_forward_capacity_total to size_t
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2275037471095231389=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2275037471095231389==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="89im8ptHh1E="; charset=UTF-8

--89im8ptHh1E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2165?usp=3Demail )

Change subject: buffer: Change return type =
of buf_forward_capacity_total to size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Change return type of buf_forward_capa=
city_total to size_t

All callers already want a size_t, so make the
conver=
sion implicit=2E

Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7
Sign=
ed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2165
Message-Id: <20261110123659=2E4683-1-gert@greenie=2Emuc=2Ede=
>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg41077=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M tests/unit_tests/=
openvpn/test_dhcp=2Ec
3 files changed, 3 insertions(+), 12 deletions(-)



=

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 7f142c4=
f=2E=2Ee672b74 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=
=2Ec
@@ -275,7 +275,7 @@
     if (buf_forward_capacity(buf) <=3D 1)
     {
=
         size_t len =3D strlen(str) + 1;
-        if (buf_size_valid(len) &=
& (int)len < buf_forward_capacity_total(buf))
+        if (buf_size_valid(l=
en) && len < buf_forward_capacity_total(buf))
         {
             memcp=
y(buf->data + buf->capacity - len, str, len);
         }
diff --git a/src/o=
penvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index ede3066=2E=2Eae6dcb7 10064=
4
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1068,7 +106=
8,7 @@
  *
  * @return Capacity minus offset, or 0 if \c buf is invalid=2E
=
  */
-static inline int
+static inline size_t
 buf_forward_capacity_total(c=
onst struct buffer *buf)
 {
     if (buf_valid(buf))
@@ -1078,7 +1078,7 @@
=
         {
             ret =3D 0;
         }
-        return ret;
+       =
 return (size_t)ret;
     }
     else
     {
diff --git a/tests/unit_tests/=
openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec
index e331d3=
d=2E=2E3a84e1e 100644
--- a/tests/unit_tests/openvpn/test_dhcp=2Ec
+++ b/te=
sts/unit_tests/openvpn/test_dhcp=2Ec
@@ -50,11 +50,6 @@
     return "dummy"=
;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic=
 push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static=
 void
 test_write_dhcp_search_str(void **state)
 {
@@ -146,10 +141,6 @@
   =
  gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma =
GCC diagnostic pop
-#endif
-
 int
 main(void)
 {

-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7
Gerr=
it-Change-Number: 2165
Gerrit-PatchSet: 5
Gerrit-Owner: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--89im8ptHh1E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2165?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">buffer: Change return type of buf_=
forward_capacity_total to size_t<br><br>All callers already want a size_t, =
so make the<br>conversion implicit=2E<br><br>Change-Id: Ie2d784272184261a62=
c848e6ad3b7a4570ae6dc7<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<=
br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165<br>Message-I=
d: &lt;20261110123659=2E4683-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41077=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M tests/unit_=
tests/openvpn/test_dhcp=2Ec<br>3 files changed, 3 insertions(+), 12 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/bu=
ffer=2Ec</span><br><span>index 7f142c4f=2E=2Ee672b74 100644</span><br><span=
>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec<=
/span><br><span>@@ -275,7 +275,7 @@</span><br><span>     if (buf_forward_ca=
pacity(buf) &lt;=3D 1)</span><br><span>     {</span><br><span>         size=
_t len =3D strlen(str) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (buf_size_valid(len) &amp;&amp; (int)len &lt; buf_forward_=
capacity_total(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (buf_size_valid(len) &amp;&amp; len &lt; buf_forward_capacity_t=
otal(buf))</span><br><span>         {</span><br><span>             memcpy(b=
uf-&gt;data + buf-&gt;capacity - len, str, len);</span><br><span>         }=
</span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=
=2Eh</span><br><span>index ede3066=2E=2Eae6dcb7 100644</span><br><span>--- =
a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span=
><br><span>@@ -1068,7 +1068,7 @@</span><br><span>  *</span><br><span>  * @r=
eturn Capacity minus offset, or 0 if \c buf is invalid=2E</span><br><span> =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline size_t=
</span><br><span> buf_forward_capacity_total(const struct buffer *buf)</spa=
n><br><span> {</span><br><span>     if (buf_valid(buf))</span><br><span>@@ =
-1078,7 +1078,7 @@</span><br><span>         {</span><br><span>             =
ret =3D 0;</span><br><span>         }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return ret;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return (size_t)ret;</span><br><span>     }</span><b=
r><span>     else</span><br><span>     {</span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec<=
/span><br><span>index e331d3d=2E=2E3a84e1e 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_dhcp=2Ec</span><br><span>@@ -50,11 +50,6 @@</span><br><span>  =
   return &quot;dummy&quot;;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> test_wr=
ite_dhcp_search_str(void **state)</span><br><span> {</span><br><span>@@ -14=
6,10 +141,6 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> int</span><br><span> main(void)</span><br><span> {<=
/span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2165?usp=3Demail">change 2165</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: Ie2d784272184261a62c848e6ad3b7a4570a=
e6dc7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2165 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>

</body></html>
--89im8ptHh1E=--


--===============2275037471095231389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2275037471095231389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2275037471095231389==--

