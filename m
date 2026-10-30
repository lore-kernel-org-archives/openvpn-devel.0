Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B8C606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DO/zkfhw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=H35Rf5nj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=drV4EFRS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EgWUcxne
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3gyZu/b0DbfrffStnnCjBu4NRv+sjYQtWKEW2HSXHoc=; b=DO/zkfhwLCj6jccrZBzuit8Pgl
	Uw3mOq7uwJhFEPXcq8r1ZBOS0LXOiM9JUOdFkMnOPE5Mdpw8Cq2hSfWBLTYOTZZHzsv0WsoZbhci4
	ueSYU+YIvZCrzfejT08s8lgus0LnmtnENQFU20N6hVXm79Rk5DuOpEmAM3Pb9+i+FGQE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrxR-000000005XU-41Vv;
	Fri, 30 Oct 2026 19:08:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMrxG-000000005XC-3lGc
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:07:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dm5R8cboasWr5cEfEoDBjGTHXLu3bGH9tzthTvwDhj4=; b=H35Rf5njXGSAZOKhyNqaIudhWQ
 5vR+5ovQoBIDL405rSbA1icuV+lbyz2+wxpf4SpPkhtP0mnNM85iDpiY3QEEMZdQGCYzpeOYs6tDY
 D2L7c97mbvgaVOPfnZZ1TSyrG3BT6j1w3Hr1+D71kO/v2EKT9eWltejMlseZroXMvJE0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dm5R8cboasWr5cEfEoDBjGTHXLu3bGH9tzthTvwDhj4=; b=drV4EFRSSDKvZyaDTkayS2xJHZ
 gK2jzoM6d/Tg3IgDBopOUiM7SyrkOsCB73U0AeU4mrO+jzDj8K3dP7jz0UGHCyTsszUSt3o2iLLz7
 mTDOKd5Lw1accG0kuUa1s4YdQGP2CgV/wewyHvnwPa81Uyqe9JSfxv7pqHWd9LrW7grM=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMrxG-000000002Bw-0egz for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:07:58 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso789309f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793387272; x=1793992072; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dm5R8cboasWr5cEfEoDBjGTHXLu3bGH9tzthTvwDhj4=;
 b=EgWUcxnepsQedvnvnuXWSik02YYzPTu6ZJtmq8Ds8WzIGinAjmr9AKWiAzWJEDfnhE
 fnEhVufmhgTOs6Yp0WAi/8OA9re1lBepBiLo92QlaPsR1XQKEJDplDSRdDjDkYpL4PJ+
 0HpuXtyhfPdiQkdFUyht/x3E2pUgFHiVPUv05Fq9jCI40cbqUzwU3/NWWceBFu6hb3dK
 K9kjW5Z73neq+sZ8pRnNBTx6PJzFeqblcH+3kUfDFe+Qf3r/jT2/F55Gg9M+A9262VMA
 RRcLd612HvN4Z9tAZhc/Zn3eQiudNq/G2ZzJ4L+HVlcwR69fAC2vMrdcXl4t18WBmdcM
 M67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793387272; x=1793992072;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dm5R8cboasWr5cEfEoDBjGTHXLu3bGH9tzthTvwDhj4=;
 b=lLFOIEPlYdrtXg3Ut+ebYYBegE5DBxa7BLE1/PREp1ZuHdH04D3bG3Fq7LFisNhRTk
 Os21LZBlsZfKdaWIIuMuONPcv5T2ib/z29g2Sfy2QEI2qLqwc9cKYZYgUVoyGpvLfFSk
 YHeznr/b/id09QSqzSQia48c1zYm3BLCN1GuSUFJHgjrUzTkfIA0SUzHndsBWRSMCLmh
 IkbJNhBhiRsocYTJyOLbMKi3wYCemEHUdsLzHGS02+yL+GjEYXH7a/rFXqBa2+tt1meK
 0Xrgj70QB2nOuqdQMQhskpyuLolAwnCmys8KVl8sz5kcaV920LTNnkYDnqjv06Ee0PR5
 Oqtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSecNJORRsH+GpPiIrXjDb+PMEROlaZKEynmjuzfw+mDi6Ook6o7AzikgLXXNIhm5bQPAiSJdEZWmehS+x@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKKZyk1PqltoWjMRD7aLRMVcPBRF7HSbl1bZgDqTm/tro9zBoW+
 CzTLkJPvgEeIJ0wxr8nlxBg7F+qUAvkeU9vujbDa9Jc160oWTaohhbI9EglkICwa8pnYGVAZnba
 jEl4cCvtmEFrWCFlHHTTt6ejFhpsrf+K6/c2PjLraDPIgyZM0GAHPjJVzQlZdq6HH+TBY
X-Gm-Gg: AYBFou3wogxhyzo2K4krzHWWeJV16pdUKIzw10ff1v6/NlCuNH25e6fXPGFUE9K3RF7
 YHU84h9cVsevhsKgEmhdnE5NjTEcPyAcaWBCYHk1/LuLZc4H/a5ayQ+RQS/pM7vf0koRU4hMzL+
 YIzcBTsTNsnDWSxF1GrzEakQGsG+CfHHTkU51x4LpTY+kshvXfcwmR1F0nrIkCXm7oyeVgWPFqP
 HNvCNdUBbU2OFDxsLCUUhb6ni0btHIXC2LvYTjBPXBTloCsJaySAZYkb1LVO8P2ZcHFtnVeBbnG
 UTjUZNPWPSKFvwrDcE9KIyoVMIHyBK+iIQWMatOLBhAZrhXMy7HJ1D80SKs3w8jNz+nvJWgvjg2
 zSbq9zECxsJg3kuvzI3vCzklobHxlnnN8mS1yCygpuGUHbqp/C84O5UW+KGGc3nnric7ZPgX1qJ
 +0zomn9fGRnCdkJaHXXMOW5jqgL6dahuNUEKN3GOxu3YbFuQqRgGlQL52sYZ6tooc0kNwoZTbvV
 OkVux9gF8PeuVpBwFjncIVZD1oCfNApe05VJuhcrTHKi5OQ5qI2G6ev96WKoETZRx2LEx6txGJF
 1BppTd6vZduVxhQeqC1RfU7CHFZQ4t6OfeoPu4Z+zKLk0Xy+EGtseDWXWZAfVRQ0VN+yWlCJm7O
 WMWqhnXShXnWlJw5kvsfRDAf9hA0qcKS9ssvzaNV8uy3ke4HERfkGJGtDtP+weIm0knm6ered5s
 3l+DkyJJ7rKlm33Pg=
X-Received: by 2002:a05:6000:26c8:b0:48d:f14a:9183 with SMTP id
 ffacd0b85a97d-48e6e303b1dmr7752138f8f.15.1793387271498; 
 Fri, 30 Oct 2026 12:07:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a4csm4731672f8f.23.2026.10.30.12.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:07:51 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 19:07:50 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If33596abef4e97aa9b58f12cd866a5cded17fd4f
X-Gerrit-Change-Number: 2070
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2070?usp=email>
X-Gerrit-Commit: 90872ff897ad16bd493713965fdf2246d31a05b2
In-Reply-To: <gerrit.1793281941000.If33596abef4e97aa9b58f12cd866a5cded17fd4f@gerrit.openvpn.net>
References: <gerrit.1793281941000.If33596abef4e97aa9b58f12cd866a5cded17fd4f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjgxOTQxMDAwLklmMzM1OTZhYmVmNGU5N2FhOWI1OGYxMmNkODY2YTVjZGVkMTdmZDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <60e309849c13c7bcd26c69ad617c7b49bb92eeac-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMrxG-000000002Bw-0egz
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_provider: Fix
 compiler warning with clang 23
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
Content-Type: multipart/mixed; boundary="===============8283351855824826958=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8283351855824826958==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m2DVbTGCwC0="; charset=UTF-8

--m2DVbTGCwC0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2070?usp=3Demail )

Change subject: test_provider: Fix compiler=
 warning with clang 23
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

test_provider: Fix compiler warning with clang 23

With --disabl=
e-management it complains
"variable 'mgmt_callback_called' set but not used=

[-Werror,-Wunused-but-set-global]"=2E

Change-Id: If33596abef4e97aa9b58f12=
cd866a5cded17fd4f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2070
Message-Id: <20261029143143=2E19636-1-=
gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg40307=2Ehtml
Signed-off-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
---
M tests/unit_tests/openvpn/test_provider=2Ec
1 f=
ile changed, 4 insertions(+), 1 deletion(-)




diff --git a/tests/unit_tes=
ts/openvpn/test_provider=2Ec b/tests/unit_tests/openvpn/test_provider=2Ec
i=
ndex e5562ee=2E=2E5d31da3 100644
--- a/tests/unit_tests/openvpn/test_provid=
er=2Ec
+++ b/tests/unit_tests/openvpn/test_provider=2Ec
@@ -42,7 +42,9 @@
 =
#include "test_common=2Eh"
 
 struct management *management; /* global */
+=
#ifdef ENABLE_MANAGEMENT
 static int mgmt_callback_called;
+#endif
 
 #ifnd=
ef _countof
 #define _countof(x) sizeof((x)) / sizeof(*(x))
@@ -156,8 +158,=
9 @@
     char *out =3D NULL;
 
     /* indicate entry to the callback */
+=
#ifdef ENABLE_MANAGEMENT
     mgmt_callback_called =3D 1;
-
+#endif
     co=
nst char *expected_tbs =3D test_digest_b64;
     if (strstr(algorithm, "dat=
a=3Dmessage"))
     {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2070?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: If33596abef4e97aa9b58f12cd866a5cded17fd4f
Gerrit-Change-Number: 2070
Gerr=
it-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--m2DVbTGCwC0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2070?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">test_provider: Fix compiler warnin=
g with clang 23<br><br>With --disable-management it complains<br>&quot;vari=
able &#39;mgmt_callback_called&#39; set but not used<br>[-Werror,-Wunused-b=
ut-set-global]&quot;=2E<br><br>Change-Id: If33596abef4e97aa9b58f12cd866a5cd=
ed17fd4f<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2070<br>Message-Id: &lt;2026102=
9143143=2E19636-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40307=2Ehtml<br>Sign=
ed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/u=
nit_tests/openvpn/test_provider=2Ec<br>1 file changed, 4 insertions(+), 1 d=
eletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_prov=
ider=2Ec b/tests/unit_tests/openvpn/test_provider=2Ec</span><br><span>index=
 e5562ee=2E=2E5d31da3 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/test_provider=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_prov=
ider=2Ec</span><br><span>@@ -42,7 +42,9 @@</span><br><span> #include &quot;=
test_common=2Eh&quot;</span><br><span> </span><br><span> struct management =
*management; /* global */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifdef ENABLE_MANAGEMENT</span><br><span> static int mgmt_callback_ca=
lled;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span> </span><br><span> #ifndef _countof</span><br><span> #define _coun=
tof(x) sizeof((x)) / sizeof(*(x))</span><br><span>@@ -156,8 +158,9 @@</span=
><br><span>     char *out =3D NULL;</span><br><span> </span><br><span>     =
/* indicate entry to the callback */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span>     mgmt_callbac=
k_called =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>  =
   const char *expected_tbs =3D test_digest_b64;</span><br><span>     if (s=
trstr(algorithm, &quot;data=3Dmessage&quot;))</span><br><span>     {</span>=
<br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2070?usp=3Demail">change 2070</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2070?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: If33596abef4e97aa9b58f12cd866a5cded17f=
d4f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2070 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--m2DVbTGCwC0=--


--===============8283351855824826958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8283351855824826958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8283351855824826958==--

