Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4ED606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YjtcJqk8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=l/3NJDhY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=N5j8AzDF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RtR7N+9b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T3IIStEJ7Pmg2W/nai2rJYUn6+MpXzjzd5cGZMJaQ4M=; b=YjtcJqk8elJzJvIDbOwbi2s3ad
	RKmHWF7B1iqxrKZ4q/SRX2RF4szR4O9xwwCRGnKQxwaelUxeU9MFrx8nWN2B2o0m1ua6WqCEuItLY
	Wnui6y3FGH/AgPHEw+CpWxE6itPuykfQzi6UKU2Lfp/3ILZJg/h0dFEs/H/0PNv2HVEw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJBgw-0003F1-M6;
	Tue, 20 Oct 2026 15:23:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJBgv-0003Eu-EH
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 15:23:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wZNCrRwazx7FGP3xAL5ghF7m71zqTjLiMIzeHVQQYO0=; b=l/3NJDhYqKxbCTAPjpVFCk6fpJ
 XK3PrTU6zElFMiiktXXtulXgMR5fTQdqvNEbCnY3KVWIU8ejCDbJ4+SSHjMGTJCbOvSkj/9kIHSLp
 IrxUDQTAcE4FEpial2RmhYhn5lrUFpnIA8U+WPT18K5rl7+ufFAJH4kBgE9gTVdYtWSY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wZNCrRwazx7FGP3xAL5ghF7m71zqTjLiMIzeHVQQYO0=; b=N
 5j8AzDFs7Pyl2OkJ1rWOreW9bLDvRxMDLd5ljDVWJfkAibcyK0icv/da1ShJVy0uxVgTzoLnv8kPw
 qa4CkXdmYahMi6C2H9Pum2tTk2QfQ2gJJX80yVVbd1f6ZYtBTGoLvNwVdUY6j7auB+3hl3EDEc7bA
 I3/A4FdJd3N+kOHw=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJBgu-0004kK-HO for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 15:23:54 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a1e34ecb02so17926575e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 08:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792509826; x=1793114626; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wZNCrRwazx7FGP3xAL5ghF7m71zqTjLiMIzeHVQQYO0=;
 b=RtR7N+9bibA/ncYJAFwMxAtrClqH78MhCyIlbYsPXn/PmDcOUOHs8jeu+OS07JWApe
 dMpgdRP+/Wl9Uw5755OqYqUXYHSZRxs0GXacQaIFIdMVdMbMtMUZbrOjoHrxEedutzAm
 0fQ8Wdo1WkGaxQRgBD2VAYVT+id/klJAf9k4/ieTuhAMcqm6jsEfOYhemGlX3OdtPtHl
 MHPB5AuHyziZuVl52cgxVK+75zZe6p2ksBkIJx9hYsxGbhBmUXPiJOKTorYikx/ExlsP
 UHO19hACAe67C0+2Gf0j5AvsoBWnGMEd27zEKZ6sL7AlBW0UErvokR884JF43psWwCol
 1Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792509826; x=1793114626;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wZNCrRwazx7FGP3xAL5ghF7m71zqTjLiMIzeHVQQYO0=;
 b=U/DmECx6lN/oVIu3GaTGHBh0483fLIOnmemN7QgwQcLiqnZpL9C0d3jjo5fCvwX4ve
 Bz8MyCMY358xq3mcI9eSHQ8IGOXdFswBtVrksOmSj9HRQrLGPBLTWtmom+Z6yd4+YCsk
 K0B1elAbXxOCEbKaI/y4qWr1Hp52QFpMP09Ht1WbVJvMW2Lr+Vzba2Qe1nOQuxU2izJF
 y/Q8uKuDPS7BmSy9zjiTEl0BhwLDR2nCkXGF9o6rrRjQa+ZHivMsnWyqRwnJeDF8zNru
 yqaIl5xcyuNcHo+s6cOUzSBNmD/zznM30QZDB4wV1D5C9PvV/5IZaXFY30dFwC65uzuJ
 v3qg==
X-Gm-Message-State: AFq9FYKGP/yvUum9jbDXE4vJCSVmnQ4wq/R+UOxa4rqm5RfjC2EmwGzo
 h8jfgImb2I9p98VkRAAmfxpmRni9LF7B40cXU7xmZSXKR+5hT5ZYoyTiTMfdGppttAF6Uyqxdck
 U4XoiN36LXunAl0iUAjaw6smPnbVjy/Gwn/5HdfER0geOwgboZ0BxDbG9OF75xnPaoRVAgcBkYx
 LA3IHm2A==
X-Gm-Gg: AYBFou2oZg+m6AEkyKd1//5WQkMZy7NeD9xhmTI2cNpiBIcQJqh+GvzoLph/JKiO6iW
 87np1KUmuIJbOkOGTqmuuLNrCA2lz8T0fMyuabOBGPb9Sh0mGbsE2pwcPsnXt/aytsHAK84Pydq
 dIJJhgtRVmwsOicTxY8Gn+m3D/9Sq5qtGjMASNb1kA5mu5LPURTyxH1RWZdz4pwJ2WjHlHUV2iu
 JeHphLsGkuufOO/AHn0u5B4AE3MbQo+NaMnIbIKFdR+rYKYDfHzl0z8iX2j/1b7SOcPRWJmlW3h
 4jDw+hzrAd77lOn98n17A6utT4mcK2Q2ILMPPBnUkBPdk0RmSsyv9TPEUAnVj1+1yz5bmyZy7Rg
 EzccwQCOQW9M7VmEEKBw6vBtWcsebnC1zjWve2iVad1DgMZYfrK8RPjyd+wcA8A9lv+fWxt1ZIc
 RHyuHNaefYcxKvjtjsDwGvyYOK1O802cSnhO9cha2vjzopfLq/SDZrv8Lz3UPij2A13eJorS29T
 j6WCfwAsE8PVu7/yRQ6w8kbgmFLtL574eK79CE12HvEHQuWH6cGhJrE5HDXFX5KXMIN3B7FFRgh
 t8Gfsrh0eqC2iAHiXVs3ajQGzoJIxBN4RCfTMXsXRYv7+RBADmpludDdzhjJ
X-Received: by 2002:a05:600c:8b6d:b0:4a1:e6a9:4086 with SMTP id
 5b1f17b1804b1-4a1e6a9438bmr135056325e9.0.1792509825787; 
 Tue, 20 Oct 2026 08:23:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d569d4sm81669165e9.10.2026.10.20.08.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:23:45 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 15:23:44 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib99618742929fd96562884d071f3bedc5ca309e4
X-Gerrit-Change-Number: 2025
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2025?usp=email>
X-Gerrit-Commit: d662deca1a0fca531ee03b4c039896141badc155
In-Reply-To: <gerrit.1792501753000.Ib99618742929fd96562884d071f3bedc5ca309e4@gerrit.openvpn.net>
References: <gerrit.1792501753000.Ib99618742929fd96562884d071f3bedc5ca309e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNTAxNzUzMDAwLkliOTk2MTg3NDI5MjlmZDk2NTYyODg0ZDA3MWYzYmVkYzVjYTMwOWU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5a5f234b6f0131eaa12a2bc3c6c7b34805fd6475-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJBgu-0004kK-HO
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_pkt: Correct
 comment about which systems use ushort sin_family
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
Content-Type: multipart/mixed; boundary="===============4130515772469116535=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4130515772469116535==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JVlvvsSOS8k="; charset=UTF-8

--JVlvvsSOS8k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
025?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: test_pkt: Correct co=
mment about which systems use ushort sin_family
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

test_pkt: Correct comment about which sy=
stems use ushort sin_family

I found out due to an unrelated problem that t=
he comment
is wrong=2E So let's fix it before it confuses the next
person=
=2E

Change-Id: Ib99618742929fd96562884d071f3bedc5ca309e4
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/202=
5
Message-Id: <20261020131709=2E24574-1-gert@greenie=2Emuc=2Ede>
URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4006=
9=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/=
unit_tests/openvpn/test_pkt=2Ec
1 file changed, 5 insertions(+), 4 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/2=
5/2025/2

diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_t=
ests/openvpn/test_pkt=2Ec
index 51c73d8=2E=2Efbbb40f 100644
--- a/tests/uni=
t_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@=
 -579,13 +579,14 @@
 
     struct session_id expected_server_id =3D { { 0xe=
c, 0xa3, 0xd5, 0xcc, 0xb4, 0x7c, 0xa1, 0xee } };
     /* We have to deal wi=
th different structs here annoyingly */
-    /* Linux has an unsigned short=
 int as family_t and this is field is always
+    /* Some systems have an u=
nsigned short int as family_t and the field is always
      * stored in hos=
t endianness even though the rest of the struct isn't=2E=2E=2E,
-     * so =
Linux little endian differs from all BSD and Linux big endian */
+     * Th=
is affects at least Linux, Windows, and OpenIndiana=2E
+     */
     if (si=
zeof(addr=2Eaddr=2Ein4=2Esin_family) =3D=3D sizeof(unsigned short int) && n=
tohs(AF_INET) !=3D AF_INET)
     {
-        struct session_id linuxle =3D {=
 { 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 } };
-        expected_se=
rver_id =3D linuxle;
+        struct session_id short_le =3D { { 0x70, 0x04=
, 0x8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 } };
+        expected_server_id =3D s=
hort_le;
     }
     assert_memory_equal(expected_server_id=2Eid, server_id=
=2Eid, SID_SIZE);
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2025?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Ib99618742929fd96562884d071f3bedc5ca309e4
Gerrit-Change-Number: 2025
G=
errit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>

--JVlvvsSOS8k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2025?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">test_pkt: Correct comment about which systems use ushort sin_family<br>=
<br>I found out due to an unrelated problem that the comment<br>is wrong=2E=
 So let&#39;s fix it before it confuses the next<br>person=2E<br><br>Change=
-Id: Ib99618742929fd96562884d071f3bedc5ca309e4<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2025<br>Message-Id: &lt;20261020131709=2E24574-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg40069=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>1 =
file changed, 5 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/25/2025/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests=
/openvpn/test_pkt=2Ec</span><br><span>index 51c73d8=2E=2Efbbb40f 100644</sp=
an><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -579,13 +579,1=
4 @@</span><br><span> </span><br><span>     struct session_id expected_serv=
er_id =3D { { 0xec, 0xa3, 0xd5, 0xcc, 0xb4, 0x7c, 0xa1, 0xee } };</span><br=
><span>     /* We have to deal with different structs here annoyingly */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Linux has an unsi=
gned short int as family_t and this is field is always</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Some systems have an unsigned sho=
rt int as family_t and the field is always</span><br><span>      * stored i=
n host endianness even though the rest of the struct isn&#39;t=2E=2E=2E,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * so Linux little e=
ndian differs from all BSD and Linux big endian */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * This affects at least Linux, Windows,=
 and OpenIndiana=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     */</span><br><span>     if (sizeof(addr=2Eaddr=2Ein4=2Esin_family) =3D=
=3D sizeof(unsigned short int) &amp;&amp; ntohs(AF_INET) !=3D AF_INET)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     struct session_id linuxle =3D { { 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, =
0x85, 0x12 } };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  expected_server_id =3D linuxle;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        struct session_id short_le =3D { { 0x70, 0x04, 0x8c, =
0x0f, 0xfe, 0x30, 0x85, 0x12 } };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        expected_server_id =3D short_le;</span><br><span>    =
 }</span><br><span>     assert_memory_equal(expected_server_id=2Eid, server=
_id=2Eid, SID_SIZE);</span><br></pre><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2025?usp=3Demail">change 2025</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2025?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib996187429=
29fd96562884d071f3bedc5ca309e4 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 2025 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--JVlvvsSOS8k=--


--===============4130515772469116535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4130515772469116535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4130515772469116535==--

