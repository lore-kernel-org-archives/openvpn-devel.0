Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4624606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iVAKv08e;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VjQjWwq7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=F0IoHsKL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=S1+m5/KV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dQKwEDPDzNa4xjjhzwRXxVuq+uWchW9P4f8Rkh/SP2w=; b=iVAKv08eq3K3g1wnx+lg+XYbUC
	flxPW4fHYwZ6vt9uuHOsNNF45VrgjEnGQ7qlMOm6oQj7xgP6+3WhzdUvl5Woxlg1ut9ypiGBwkqMF
	dA/5q0DkW8YrIfB1SqPQcNKmZ8JO317oCrCIayK9079g+lr/DefK6EumWnjykBQ8uomE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWX0h-0000000061x-0Hyl;
	Thu, 26 Nov 2026 10:47:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWX0f-0000000061q-3JQd
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xA36HwJZbcPV+XDQM2f60SsskNq+r/LzPSjF7iAfKDA=; b=VjQjWwq73Z2XSCKRJyIpExMuM3
 jhVh00aM02oHvXx1y6367zL9tbDfsuzZXXlZWr3KOk4WRADkVeMNYSKykHdIYdCmc8K9rMhWC7ji2
 enMM9878WLWXG5K7qKtdVMS3Vc0OTlTSqKkEpodZpHSdw3zBg3JeWDJyajCi91zbitYc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xA36HwJZbcPV+XDQM2f60SsskNq+r/LzPSjF7iAfKDA=; b=F0IoHsKL3OTbobzeEzsmSgtwec
 u4fKahyJMT5N5aFsHSQQvy/ycVh7GXx2U09XxJ9QHAFIT7dv+J0YYub82VvR3vjD4MIzJ6FlbbFol
 DHt0yDGCDS99bRgO+9BSGY5ZWoBZfJgV/hd4SnqgzEBGzck1JWIO70P1vfIXaGe16DGU=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWX0d-0000000041h-0eDD for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:47:25 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so58538435e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 02:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795690036; x=1796294836; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xA36HwJZbcPV+XDQM2f60SsskNq+r/LzPSjF7iAfKDA=;
 b=S1+m5/KVLqBCncA9ihY0aGcuLYXPQ70GElkQ4DpIW9W7KG1E/Ghav3zkA3VZ8sTdY3
 rsIm9EhyYKOfNLLm943MZtWqEpN6+I4Zq61pP0wP3jg+eFTFolfxrrJUKWT5EjqIM4qW
 Qxr0/cnkU7wXz1LF5iT3r1Vnga7QIrQVMqffZ5bKkmO4C+F47kkTFxEnmN2Q+3XE9qVy
 LVTN7XIxLpNSc2VNRcEkOjofMSqKHjDahawO2i6xta9jDJbNPnKbsMcSC1HXYjJacNuW
 Ro2XbVKuAFbjdcfSVboiPAIscvpM8J3szyPhMYCcrl+TYUqM3vRd5pFWi0unMhsY6HAk
 4xsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795690036; x=1796294836;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xA36HwJZbcPV+XDQM2f60SsskNq+r/LzPSjF7iAfKDA=;
 b=t8FO0IUKoZw8jI/P7LCTd27BYngW2ACrV5tRezx5t6MjK0w0r1uBQbviNbvU1n4msm
 hX2L5e6J6wZ4g63B7rgIzXqHw2jp0HNgCgzRd2ksC/in0IRhqesaeJ4DlNlA7ZGCxjut
 VebXPN6xIOZBO3pjWxUDcVSGbBOlfyLA2Ng+La2f0BPA58AXyZkTv7lH9Ez/xEmyXHYQ
 kQv7/pYErahVaMVEEyLkKM+vi/+fX96som6SoB/Lv/TFznrpJui7oY/hwgZ2ODKNylyB
 m8QHSVNcI3tIpcWj3if2BtaLL37fBT/Oc/uL0aBlyLzj+Gk6+JVfswNWRH0joydMk1Ll
 faJA==
X-Forwarded-Encrypted: i=1;
 AL+hErG2KQmKringXwf6QA2A9oBdW4b9JPZO7y+WVUt4jc47VFUCbL/8M/y8VSd37/orw2O5xthHeeGHgB0ECL96@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9MHC5+gTvc1ZkdbB3rSRLl4Yf6zu4VVBMeAYuVLTaOJR3Y4EHC
 NTmyOLr6ErXXisZ9eafpnKu5zs3/evTg8WP7J/SgK1HkqI2sM5hwS+/C1dIy8+fAmFNftsN1x3p
 jnEj8rTPO8yICnAsNBF+pLBijtcd/kSm2Hifo7B9LbUrhKrn5NtuGwCuEy4AsVxlNLWVq
X-Gm-Gg: AZFdTZfo9lJKm50W55ltRw6o6WzaNQZeNwCGIFf278Mjjud+irwlcEO9qrTJ7aAH/ZT
 rvW0CBvnOpza1+cEWaur8+95ooULpvPImYA8WYu3fdRsebg/x3si+oQg5ejFKoIqzF+qOvZbHFB
 wxAI6gRw0INxbItbcB4fTZO89UVwdhF1c3gzYfz9RWqVncAOXldoECpJh4rtxT95oMTjZf7xHP+
 mhDu/2qcBNqqhiM0X0Ud1DLJyl/7yG17zkqfrL+yxfD+RC32nyW0NRlKZEbWvJMBYUeong26G+N
 F1negN4wJAedNFXtrrnAyCllT0TjdruZi/hwVxfbxzKUs2rBOSHit8m5cT4Yzp//CirLSOiacQs
 8+5nA7Tq6+nWLRsJmz0oa/YnV8Wp3/ry+Ady+WkLvUAwrKs6+JlohDEchAI0jmzMX/9MyR+cloJ
 JB0fN5kBrqxsyO4fkffJ6B/Ll9MGyY9ik5wJ3ngIGZ/yPIA4yHam8hPwC1P17dZgv6EuDZR4NFT
 1BKt7yx8TMngJDMlZwmtXw0EueoDAS8JLZ6c/6XZP+BfqzvqN61y6qnsH0p2qOed+qf60o+bVVP
 AFgWlPITg8/206gsdDprV8V74CNwNqYgV8PKFTAU86wg2nnL8rEAue5TAx2NdMFcnwBCBnbHcQy
 BGCSMJSeHXuPm46PzXNSiRnGwBfdlYGDg2ukU5kYJhOmCpVexkbFyCrh9OKImXyloh4+pi0rVFD
 XswgPN9kFBTPOq0tVe
X-Received: by 2002:a05:600c:c84:b0:4a8:9a2f:d27 with SMTP id
 5b1f17b1804b1-4bb8881f47emr424141185e9.25.1795690036423; 
 Thu, 26 Nov 2026 02:47:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b33a596f9csm17532555f8f.12.2026.11.26.02.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 02:47:16 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 10:47:15 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5
X-Gerrit-Change-Number: 2339
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2339?usp=email>
X-Gerrit-Commit: b4d1901c7b19ab7993e9216371e1b51618869dff
In-Reply-To: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
References: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTM4MzExMDAwLkk4N2RkNDFiNjZmN2Q3N2NhYjdhYWY4MGZhOWQ5MDk1ZTQ2YzAzM2Q1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e0ff3cf39e56b762028c9340fbe617700fa223ca-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWX0d-0000000041h-0eDD
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: Fix
 conversion warnings in man_write
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
Content-Type: multipart/mixed; boundary="===============3413567005412275789=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3413567005412275789==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="reBJhpveRUY="; charset=UTF-8

--reBJhpveRUY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2339?usp=3Demail )

Change subject: manage: Fix conversion warn=
ings in man_write
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

manage: Fix conversion warnings in man_write

Use openvpn_send to avoi=
d warnings due to
Windows/Unix differences=2E

Change-Id: I87dd41b66f7d77ca=
b7aaf80fa9d9095e46c033d5
Signed-off-by: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339
Message-Id: <20261124190648=2E1=
6745-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openv=
pn-devel@lists=2Esourceforge=2Enet/msg41907=2Ehtml
Signed-off-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file changed, =
4 insertions(+), 13 deletions(-)




diff --git a/src/openvpn/manage=2Ec b/=
src/openvpn/manage=2Ec
index bbf454a=2E=2Ecdd9501 100644
--- a/src/openvpn/=
manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2448,11 +2448,6 @@
 
 #endif /*=
 ifdef TARGET_ANDROID */
 
-#if defined(__GNUC__) || defined(__clang__)
-#p=
ragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversio=
n"
-#endif
-
 static ssize_t
 man_read(struct management *man)
 {
@@ -2550,=
14 +2545,14 @@
 static ssize_t
 man_write(struct management *man)
 {
-    c=
onst int size_hint =3D 1024;
+    const size_t size_hint =3D 1024;
     ssi=
ze_t sent =3D 0;
 
     buffer_list_aggregate(man->connection=2Eout, size_h=
int);
     const struct buffer *buf =3D buffer_list_peek(man->connection=2E=
out);
-    if (buf && BLEN(buf))
+    if (buf && BLEN(buf) > 0)
     {
-   =
     const int len =3D min_int(size_hint, BLEN(buf));
+        const size_t=
 len =3D min_size(size_hint, BLENZ(buf));
 #ifdef TARGET_ANDROID
         i=
f (man->connection=2Efdtosend > 0)
         {
@@ -2568,7 +2563,7 @@
       =
  else
 #endif
         {
-            sent =3D send(man->connection=2Esd_c=
li, CBSTR(buf), len, MSG_NOSIGNAL);
+            sent =3D openvpn_send(man-=
>connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);
         }
         i=
f (sent >=3D 0)
         {
@@ -2591,10 +2586,6 @@
     return sent;
 }
 
-#=
if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#en=
dif
-
 static void
 man_connection_clear(struct man_connection *mc)
 {

-- =

To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80=
fa9d9095e46c033d5
Gerrit-Change-Number: 2339
Gerrit-PatchSet: 4
Gerrit-Owne=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>

--reBJhpveRUY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2339?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">manage: Fix conversion warnings in=
 man_write<br><br>Use openvpn_send to avoid warnings due to<br>Windows/Unix=
 differences=2E<br><br>Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ack=
ed-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339<br>Message-Id: &lt;20261124190648=
=2E16745-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41907=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
manage=2Ec<br>1 file changed, 4 insertions(+), 13 deletions(-)<br><br></pre=
>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br=
><span>index bbf454a=2E=2Ecdd9501 100644</span><br><span>--- a/src/openvpn/=
manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ =
-2448,11 +2448,6 @@</span><br><span> </span><br><span> #endif /* ifdef TARG=
ET_ANDROID */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> static ssize_t</span><br><span> man_read(struct management *man)</span=
><br><span> {</span><br><span>@@ -2550,14 +2545,14 @@</span><br><span> stat=
ic ssize_t</span><br><span> man_write(struct management *man)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int si=
ze_hint =3D 1024;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const size_t size_hint =3D 1024;</span><br><span>     ssize_t sent =3D 0;=
</span><br><span> </span><br><span>     buffer_list_aggregate(man-&gt;conne=
ction=2Eout, size_hint);</span><br><span>     const struct buffer *buf =3D =
buffer_list_peek(man-&gt;connection=2Eout);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (buf &amp;&amp; BLEN(buf))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (buf &amp;&amp; BLEN(buf) &gt; 0=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        const int len =3D min_int(size_hint, BLEN(buf));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const size_t len =3D min_si=
ze(size_hint, BLENZ(buf));</span><br><span> #ifdef TARGET_ANDROID</span><br=
><span>         if (man-&gt;connection=2Efdtosend &gt; 0)</span><br><span> =
        {</span><br><span>@@ -2568,7 +2563,7 @@</span><br><span>         el=
se</span><br><span> #endif</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            sent =3D send(man-&gt;connectio=
n=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            sent =3D openvpn_send(man-&gt;connectio=
n=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);</span><br><span>         }</spa=
n><br><span>         if (sent &gt;=3D 0)</span><br><span>         {</span><=
br><span>@@ -2591,10 +2586,6 @@</span><br><span>     return sent;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> static void</span><br><span> man_connec=
tion_clear(struct man_connection *mc)</span><br><span> {</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?=
usp=3Demail">change 2339</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2339?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2339 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--reBJhpveRUY=--


--===============3413567005412275789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3413567005412275789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3413567005412275789==--

