Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD5606A323
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=G6ytYWN4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JOWMVi9m;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TmLgggOS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VvKsD7C2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V/6xtHwwnTqC5EfyJY2Hgrv/zMbRBqlOq41eAqHctAY=; b=G6ytYWN4QyiY8Xt7wFQkBRejap
	/JHuKx4pzMWdSBpVRz16Q0JYSXtfhAB9yejKmIdRYNW/E5LgiOWM6ChrpsVQlg5qzTYG1iAmVDUoq
	YfTDccoF+ktIMYfHyfd0nrzmlCHYYmN2kyyouO+TUu+0ZBNURwzH05WUClmRhDPbL2yA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYL2-000000003Ch-24CL;
	Thu, 12 Nov 2026 17:11:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYL1-000000003Ca-1V6E
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:11:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/2HLRZZIW9Rw8mQXtgF1tgB45APjVKb7FedWnAu2SXQ=; b=JOWMVi9m6pOUMxA0jjjVNnRSWn
 A8caWUnA3YranNwW1EN0xTph8ySrLxy3NbMVkLjeExnq/hAJ5n6ULOf7FjOAuaQ7MW5j0y29uQ3OJ
 rdE6q8ENuSUwerjVmCKjXjEATyQAnGKqtu1WkoQtQcobRXLadOnbqG2wqgOoArNiTe/E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/2HLRZZIW9Rw8mQXtgF1tgB45APjVKb7FedWnAu2SXQ=; b=TmLgggOSJD9dS/xbD/L+lrbVsa
 YRI6AxrkBgGMDgRVlSm5h5s6IJ6+2OG+9yxugFp8ruZ20bqcwlPo7kVILBoYVA2osOeZzUsEyoykO
 nTZmoloWG+otTQfzm2f8nSflDmsMZf1NIKazzbC5gqK5ki+YexxHZh4QwchbcBGBGwJw=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYKx-0000000075J-08Gd for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:11:51 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso306285e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794503500; x=1795108300; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/2HLRZZIW9Rw8mQXtgF1tgB45APjVKb7FedWnAu2SXQ=;
 b=VvKsD7C21daklDIk6mvRhv1Ub3IQCcCJrS36OFweSKX/OQJP7mK2Cmg6gTO6h0625u
 BkG3E8zs+2ZLpvXP26yumMp2MTKJlCepdxILVE+ZtItU+BmY0k14JPc2/TYG0bm3xsB0
 IaGvxpieKqbyEXL6r2F0mVNtPRkjY+5uBwFfB1T8XxFzgQS9CKsY4DS87AbG1IDiiL2H
 H5MqCko/0CeSCD4kux9U8Hj1dchGmRTHCG7HiR8JiStSMyu0M2TVbIw8pEpYMaNKptsK
 RkReC/6PpuVCtlBQzhcRfiRKCilDukTWUcffoGtKQBowlfEpYIlS18IfZRA5AgqHCwqh
 QvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794503500; x=1795108300;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/2HLRZZIW9Rw8mQXtgF1tgB45APjVKb7FedWnAu2SXQ=;
 b=2dr0RImuaGA6w3bxKDze7PaFLZTPd6m4cfRIaBz08gKXAx2y3wNSCzgt9AJGwwMLLG
 2i7efM1IvlHZPM3Aex3Siy/wGvJfdHFCePXm+QMkWSI4nen9op29QV3Ffn8jRT0KOsst
 O94fohMQrXd740GsWRBkhSjKzqvUF7FF41PZc5vE+m+oUtRMgeNS5yYCZ26fOj8+5N5W
 CObXf5uaubP+sa6HczHZ1pqUNXQSWQrlXWvflAzfBkCTgdx1c03VSPhMZveXqfdkeuln
 lsdbJenp597WU5oS0vrSJYeT8kMhBV0VSIrFx5YUSvdXbQOvI2lZpm0Yb26haIsmxsf6
 BsKw==
X-Gm-Message-State: APuU4Z+5CkkoB2wbyaIC0EuuBNW6H21TJ9gj4Lqw4u+BPIGOMPsDsGca
 nAy7mj4huZgvF8izmw/JOIm+OE2eUEQyE6Xe95GR5QJEi0KzNTtASMEXLP+dRhueSOf0wWQOFUk
 C295LmBKMVqnkbdvBu1FcvhU+1ItjOWK2W9bNyYK5+X/wKYJzEE/UhtgLt6fBCunIcO6f
X-Gm-Gg: AYBFou0l5tZQjSndMy5/1ynB047+Jj+sfFP/Mu3cTEjaNciVVbk//sQSBrSE5a8fj35
 GLbxMD7O3BMyfZm3xW8m94hJvrDnNadtVM3Tle6AoHqtU9CbUgRB+ML5bZGRS20h9tDdckIFGWD
 HaIqntqQ0ZbnqgjeCpEcv3dVZVd9zgarwYfZMELWVqzOS3NppTHMeFcm7jlmYeD1oTa7qHa71g6
 NOTP/N2XTAak7XBqCCa/FiLgLkoLnOivUb4DJSQEfAh+6HqX6dIX3Y3b2yzTuBKI40B6sN/Atwi
 5gIGWmpGjlT0ZVBSxM7p2qU+qMNftc25hAqaRKJupIxL9+jeKHdAI6esCWMojyk4yfeYLPYcbbR
 5X5J81ZhChPWIXBtFTd47evlXjenkLa4dK312nrCf8fO4RjWi1senaTNswcr3BEbS0MPdqSmC+Z
 eia8N9vKMBVc2XV4/B3s66WxHN/Hs3xQ1obANQVApALkxgFajt6GaKvzl/Vxf61/qcHR2WgN8hG
 sAcwFKlw74exghjeva/Hp0qeX9sbcf/RqecH8Ww+SYoJawZRf/ZVPEAYA8/rThMabtnjf3fyxbv
 68CN3IPqnq0tBAE8lURPQy1e5Z8AQMMKNaPGtsKogXfvVTOSlCrvqVOm4aUzBf9AZryI44BcRKY
 IhZ/5hKaqJItEb0v1eaEzG2jqayg0cDItN6UPTQjZCLKMatA5bj+ZC//N+B5ZlbNQnQVBPlSYeU
 kE0POzFkExs66d3BE=
X-Received: by 2002:a05:600c:8708:b0:4a4:f48e:78fa with SMTP id
 5b1f17b1804b1-4ba09382e1cmr131762775e9.12.1794503500216; 
 Thu, 12 Nov 2026 09:11:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08e354b0sm111854125e9.1.2026.11.12.09.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:11:39 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:11:31 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7
X-Gerrit-Change-Number: 2165
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2165?usp=email>
X-Gerrit-Commit: ed1fa99c7336195b72137b3b9d60d983f6a1eadb
In-Reply-To: <gerrit.1794313546000.Ie2d784272184261a62c848e6ad3b7a4570ae6dc7@gerrit.openvpn.net>
References: <gerrit.1794313546000.Ie2d784272184261a62c848e6ad3b7a4570ae6dc7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzEzNTQ2MDAwLkllMmQ3ODQyNzIxODQyNjFhNjJjODQ4ZTZhZDNiN2E0NTcwYWU2ZGM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <351d338497331a29d7237fe0da30dd5e9c9585e8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYKx-0000000075J-08Gd
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1349334648262508866=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1349334648262508866==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0OhanWaBGSY="; charset=UTF-8

--0OhanWaBGSY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a chan=
ge=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=
=3Demail

to look at the new patch set (#4)=2E

The change is no longer sub=
mittable: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject: b=
uffer: Change return type of buf_forward_capacity_total to size_t
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Change return =
type of buf_forward_capacity_total to size_t

All callers already want a si=
ze_t, so make the
conversion implicit=2E

Change-Id: Ie2d784272184261a62c84=
8e6ad3b7a4570ae6dc7
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M tests/unit_test=
s/openvpn/test_dhcp=2Ec
3 files changed, 3 insertions(+), 12 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/2165=
/4

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 7f14=
2c4f=2E=2Ee672b74 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buf=
fer=2Ec
@@ -275,7 +275,7 @@
     if (buf_forward_capacity(buf) <=3D 1)
    =
 {
         size_t len =3D strlen(str) + 1;
-        if (buf_size_valid(len=
) && (int)len < buf_forward_capacity_total(buf))
+        if (buf_size_vali=
d(len) && len < buf_forward_capacity_total(buf))
         {
             me=
mcpy(buf->data + buf->capacity - len, str, len);
         }
diff --git a/sr=
c/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index ede3066=2E=2Eae6dcb7 10=
0644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1068,7 +=
1068,7 @@
  *
  * @return Capacity minus offset, or 0 if \c buf is invalid=
=2E
  */
-static inline int
+static inline size_t
 buf_forward_capacity_tot=
al(const struct buffer *buf)
 {
     if (buf_valid(buf))
@@ -1078,7 +1078,7=
 @@
         {
             ret =3D 0;
         }
-        return ret;
+   =
     return (size_t)ret;
     }
     else
     {
diff --git a/tests/unit_te=
sts/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec
index e3=
31d3d=2E=2E3a84e1e 100644
--- a/tests/unit_tests/openvpn/test_dhcp=2Ec
+++ =
b/tests/unit_tests/openvpn/test_dhcp=2Ec
@@ -50,11 +50,6 @@
     return "du=
mmy";
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagno=
stic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 st=
atic void
 test_write_dhcp_search_str(void **state)
 {
@@ -146,10 +141,6 @@=

     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pra=
gma GCC diagnostic pop
-#endif
-
 int
 main(void)
 {

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae=
6dc7
Gerrit-Change-Number: 2165
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>

--0OhanWaBGSY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Frank Lich=
tenheld <strong>uploaded patch set #4</strong> to this change=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Demail">View Ch=
ange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">buffer: Change return type of buf_f=
orward_capacity_total to size_t<br><br>All callers already want a size_t, s=
o make the<br>conversion implicit=2E<br><br>Change-Id: Ie2d784272184261a62c=
848e6ad3b7a4570ae6dc7<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=
=2Eh<br>M tests/unit_tests/openvpn/test_dhcp=2Ec<br>3 files changed, 3 inse=
rtions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/2165/4</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 7f142=
c4f=2E=2Ee672b74 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span>=
<br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -275,7 +275,7 @@<=
/span><br><span>     if (buf_forward_capacity(buf) &lt;=3D 1)</span><br><sp=
an>     {</span><br><span>         size_t len =3D strlen(str) + 1;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (buf_size_valid(len=
) &amp;&amp; (int)len &lt; buf_forward_capacity_total(buf))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (buf_size_valid(len) &am=
p;&amp; len &lt; buf_forward_capacity_total(buf))</span><br><span>         =
{</span><br><span>             memcpy(buf-&gt;data + buf-&gt;capacity - len=
, str, len);</span><br><span>         }</span><br><span>diff --git a/src/op=
envpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index ede3066=2E=
=2Eae6dcb7 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><s=
pan>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -1068,7 +1068,7 @@</spa=
n><br><span>  *</span><br><span>  * @return Capacity minus offset, or 0 if =
\c buf is invalid=2E</span><br><span>  */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline size_t</span><br><span> buf_forward_capacit=
y_total(const struct buffer *buf)</span><br><span> {</span><br><span>     i=
f (buf_valid(buf))</span><br><span>@@ -1078,7 +1078,7 @@</span><br><span>  =
       {</span><br><span>             ret =3D 0;</span><br><span>         }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return ret;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return (size_=
t)ret;</span><br><span>     }</span><br><span>     else</span><br><span>   =
  {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_dhcp=2Ec b/t=
ests/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>index e331d3d=2E=2E3a=
84e1e 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_dhcp=2Ec</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_dhcp=2Ec</span><br><span=
>@@ -50,11 +50,6 @@</span><br><span>     return &quot;dummy&quot;;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Ws=
ign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> static void</span><br><span> test_write_dhcp_search_str(void **state)</sp=
an><br><span> {</span><br><span>@@ -146,10 +141,6 @@</span><br><span>     g=
c_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br=
><span> main(void)</span><br><span> {</span><br></pre><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Demail">change=
 2165</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2165 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--0OhanWaBGSY=--


--===============1349334648262508866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1349334648262508866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1349334648262508866==--

