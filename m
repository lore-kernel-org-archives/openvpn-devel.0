Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAABC606A328
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=H5DOC4Jv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RP5Ka6vL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AM4+QNnE;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dvhVLRE7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9mdgrLKmjlFpcfLx4GTppVJaCrP4nxx2bZ6A9zy2BbY=; b=H5DOC4JvkNZ5OGjYEdGIYlP7q9
	Ing3vQ/zRs9FTOKFdhMEQB4/4SSytexVSfc1A4Ge8sXRNsAdlHzn7mq0Z2du6/8ZbisrJEJ7Geylb
	v9LZOxN5Ly0V0CjsbIHJaOac7PDSR5cA1ktTQqyAillaMmf3bRF9iOvfGwhklOQBeCyU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJBQK-0007tu-I8;
	Tue, 20 Oct 2026 15:06:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJBQI-0007tm-P5
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 15:06:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=aY5tfO8eq+sLTZkvFOuKj4WO0+r966gTfpVbVWnSi5M=; b=RP5Ka6vLNXldBoOQDBVbn80J51
 sqmXS84C7lPpvkzMYtC15W02T8BPw4NPn4xPuS4Z5pAH+xYWC3pgC8nGV8PfEa+MpIeDVqBzz1g3d
 JXgsCQ1Vve306Albj9P5UK9B0TgE3ON6pymnkxDOjsfPZ7OMMQaNkeote9plAG0pCx6A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aY5tfO8eq+sLTZkvFOuKj4WO0+r966gTfpVbVWnSi5M=; b=A
 M4+QNnEi54m8O5KQ3Vb9mITidQv3fGkflgaefzD5R8MGpnHgCaf74aVhtWSo/okfOTS8a9AItaDeb
 xhJJZQp42uemHAudte/I2X6jyoW8aO+KXn+MEELc/dlMrrDV5wJNChieyZOkqkS19EljeOUgrKLbA
 TaDuf74A5Wkt6S74=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJBQE-0007jm-Kr for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 15:06:40 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso39697645e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792508792; x=1793113592; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aY5tfO8eq+sLTZkvFOuKj4WO0+r966gTfpVbVWnSi5M=;
 b=dvhVLRE7pino7JWkZWPoxkiDZpCTJUqADpvz3glumAZx2yngtF3PcQNKOYLewgT0rK
 39FUQnl0Vi2wuj7755VjK3WUK91JrZhPLBsvuA4vQ9jH5HhiR+/LsmhAEKRAIxx7YAPo
 1wZMofCWjMGiC/mJQ6RL0jrZCIzo/1Sy29ls0yevJw6c6hL1AUNZw+8NOMuFqwOZUx2D
 LVnphonxReAO2x6C0nlQEV/rGF6ZUm/5BxIzLqP/bHgmXI5TSGiLdLeN3ownjBBgKwBT
 ZTSdkuNeVqPfqc59uLazYBnAJ9bOxx1Lyxx1UFAtMi7kF6PLRPAapPLw/34UcqaEZAYF
 YrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508792; x=1793113592;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aY5tfO8eq+sLTZkvFOuKj4WO0+r966gTfpVbVWnSi5M=;
 b=tSIO5yv5Hb69S4z3PG4yI/qbf6FhzFFTefLZkkQdwqprWQ/8yljsz7Sv4Zwoa0OaSj
 PixfDT447UO/GSSuzHBFr+2VAAPER0mEjmHd+Ec/mGyrJTXxLX2ktDXbI2ZC+mMd7YV5
 BihJsFgaSnWLkcm0Zb3GZGYhzNenhG6CO++hO2ED83RMHxFZHzBta+njn7PuJAdRkrDp
 I2nVQ2eRO0dlLq4LBrtAc+w2DlN0P0EOjzd404khsldGj97wDDyCt7+18MpmdTHQ+Rqp
 IsYsYXlY+vjJOFoANlO26GOtHooI+EsBEONkVP37I5YP/KUbST9NB+e010uJF9EESk2P
 nugQ==
X-Gm-Message-State: AFq9FYKa7qIHEWlHXDHu1a1rRI6fZwgabkjDu3rrkqvwn0ToRg3POEme
 E3KIj4/rIoCNNIVWOpp537AQjxhGrPVVRXhz0kJE+tQrRhKUUZHj3WaK/QGOZCc4kZCWrE5qTyY
 RIVc9YS1Ik0M6546ppj0ttResK4FjkrJrmKjcXscEhc4/7QRjJjUHOiIwmJGKBPhg3bpUbgja3k
 XV19z7fw==
X-Gm-Gg: AYBFou3H4P7/0YrsZt1EViwwCTn+nVX4aBXFy+ZiKqve3MFq8HxyyteFOITMiO/O/W7
 CLmIsHk9oIN56FG/sLnJYCGHVdmNMLX+dZ1c6Do2YmQRSMzeihVF2qeaOP+F91+WuSPYMBZcelw
 2TFVwLdUzj3VhKsG7gG2/6aH+bIrs/FajLInuFt5m9fN2GtlAN49ROMMKrKqcmdgXCCHAsvkzi2
 RGHRdr67MWDIxOJqU04yGV7e5Xkpf4b4Z9pjVCYHSFMgNizy441B+G5+vtxiJpa6V9dPXE9pX3C
 QzfasjWBpUvQimsneNuv0ko3+TWOv729NbsYRXlh0JniZOTx2iX0wxjiVGqLUfu/pLP+lMl3xpk
 5lTEhKZROCtAqQE8i6TYOMSMkAsnejdYgatYoN7wKmJb8TGA9QkEcxX8lwWRtFUBC82STZuZ/gh
 lhHBQnlFaYs1RUmCvX00PBz0c+cNjxfuDh/ARTuhOGwfH7SWJN3DTJfKB+zhE0aqk/XpLVa9f58
 icbxjeCbxLGFM/WylYZoIa+bAHk5PMlNPvF6f8keyArvXdWuPy2jrj2u9hI0yaYumjjpLubvZlv
 iSGBrf5Q959NW6yjN3L+GsKZcrVLOKqu3YJ2PEJ2gdCf+mO/qorGV1LZ0hx1
X-Received: by 2002:a05:600c:638e:b0:4a1:e6ad:baa3 with SMTP id
 5b1f17b1804b1-4a1e6adbbe4mr136355035e9.15.1792508791788; 
 Tue, 20 Oct 2026 08:06:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d6dbbb0sm6990661f8f.5.2026.10.20.08.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:06:31 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 15:06:29 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7f2db60564fa179ce5f56979912c7e484dad1e1d
X-Gerrit-Change-Number: 2023
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2023?usp=email>
X-Gerrit-Commit: b892decff1ef4d3c4fb8cc9ff7cc761036c2323d
In-Reply-To: <gerrit.1792426273000.I7f2db60564fa179ce5f56979912c7e484dad1e1d@gerrit.openvpn.net>
References: <gerrit.1792426273000.I7f2db60564fa179ce5f56979912c7e484dad1e1d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNDI2MjczMDAwLkk3ZjJkYjYwNTY0ZmExNzljZTVmNTY5Nzk5MTJjN2U0ODRkYWQxZTFkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d6269cfa6050bd9ca095d5b0af345aa6b68f3219-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJBQE-0007jm-Kr
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: Fix broken
 unit tests after commit 5c6fbd0a11
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1054391092882106051=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1054391092882106051==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lrHVtN8N5Wk="; charset=UTF-8

--lrHVtN8N5Wk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a cha=
nge=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2023?us=
p=3Demail

to look at the new patch set (#2)=2E

The following approvals go=
t outdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru


Change=
 subject: Fix broken unit tests after commit 5c6fbd0a11
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix broken unit tests after com=
mit 5c6fbd0a11

Said commit only cherry-picked the "actual code change" but=
 not the
required adjustments for the unit tests, leading to an unresolved =
symbol=2E

Master has all the mock functions in mock_push_dependencies=2Ec =
which
does not exist in release/2=2E7, so import "uninit_options()" into th=
e
actual unit test source (as are all the other mocked functions in 2=2E7)
=

Change-Id: I7f2db60564fa179ce5f56979912c7e484dad1e1d
Signed-off-by: Gert D=
oering <gert@greenie=2Emuc=2Ede>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2023
Message=
-Id: <20261020145859=2E1457-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40076=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/unit_tests=
/openvpn/test_push_update_msg=2Ec
1 file changed, 7 insertions(+), 0 deleti=
ons(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/23/2023/2

diff --git a/tests/unit_tests/openvpn/test_push_update_msg=2Ec =
b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
index 9b7978e=2E=2E75b6=
54b 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg=2Ec
+++ b/te=
sts/unit_tests/openvpn/test_push_update_msg=2Ec
@@ -48,6 +48,13 @@
     ret=
urn;
 }
 
+void
+uninit_options(struct options *options)
+{
+    gc_free(&o=
ptions->gc);
+    gc_free(&options->dns_options=2Egc);
+}
+
 bool
 options_=
postprocess_pull(struct options *options, struct env_set *es)
 {

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2023?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: I7f2db60564fa179ce=
5f56979912c7e484dad1e1d
Gerrit-Change-Number: 2023
Gerrit-PatchSet: 2
Gerri=
t-Owner: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>

--lrHVtN8N5Wk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2023?usp=3Demail">View Change</a></p>=
<p>The following approvals got outdated and were removed:
Code-Review+2 by =
R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">Fix broken unit tests after commit 5c=
6fbd0a11<br><br>Said commit only cherry-picked the &quot;actual code change=
&quot; but not the<br>required adjustments for the unit tests, leading to a=
n unresolved symbol=2E<br><br>Master has all the mock functions in mock_pus=
h_dependencies=2Ec which<br>does not exist in release/2=2E7, so import &quo=
t;uninit_options()&quot; into the<br>actual unit test source (as are all th=
e other mocked functions in 2=2E7)<br><br>Change-Id: I7f2db60564fa179ce5f56=
979912c7e484dad1e1d<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2023<br>Message-Id: &lt=
;20261020145859=2E1457-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40076=2Ehtml<=
br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =
tests/unit_tests/openvpn/test_push_update_msg=2Ec<br>1 file changed, 7 inse=
rtions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/2023/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
tests/unit_tests/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvp=
n/test_push_update_msg=2Ec</span><br><span>index 9b7978e=2E=2E75b654b 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/test_push_update_msg=2Ec</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec</spa=
n><br><span>@@ -48,6 +48,13 @@</span><br><span>     return;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uninit_option=
s(struct options *options)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;options-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;options-&gt;dns_options=2Egc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> bool</span><br><span> options_postprocess_pu=
ll(struct options *options, struct env_set *es)</span><br><span> {</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2023?usp=3Demail">change 2023</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2023?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E7 </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I7f2db60564fa179ce5f56979912c7e48=
4dad1e1d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2023 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--lrHVtN8N5Wk=--


--===============1054391092882106051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1054391092882106051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1054391092882106051==--

