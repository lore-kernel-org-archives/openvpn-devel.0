Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F56606EE88
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JngC4u0V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PDpOK2aZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bc+jbjaK;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TCFOr/YO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3AygmpSSyzvdFFIdBMKUIl5TgNzMwomHl8CmT5FtkHY=; b=JngC4u0V1+4ojP81fZGGJ+kv4j
	sRoZNYmRfKD5XsHRwcx1slonCpHp7241oHNZKPgt/Yq5GYIxgARcIcmj8XvIDNctxRsgHJ4R2bIBe
	vooVaiNgprxsRqQrSCj6fFIaoxQLguZrsemxK50AD8clD9q/tr2eO96x5+cYhVvcu5+w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOH7h-000000006xQ-43TV;
	Tue, 03 Nov 2026 16:12:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOH7f-000000006xC-2LqB
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:12:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jyaLiyiGU3AGo08Z/DuQLGKYT8a8653gwYY8OcZZY2c=; b=PDpOK2aZUkOir1pyDet1JwhIED
 JqS71IxMBUgMIVnSSH1oslJ5mhWjWEVKHu+SoSna8Nk1qFFauo2yz0PukmC/hxdAMvSunL670HcEn
 cz2LaXMtLb2Ngzduuaqe6omfD540j0X7I9QHm0E13C+4oCQ6gGnG2xU+z8qTLraZfw5w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jyaLiyiGU3AGo08Z/DuQLGKYT8a8653gwYY8OcZZY2c=; b=bc+jbjaKLN2MLhb97AC9puAgi6
 h8AyADtOiP2WrSAt8qyL3cLM0zl2J9s8BvqZWav9vcpSBe5YcKqF8/9mb6+LuSxI1jPO88u2Cz6po
 8xTMyjf83ONAiNUp5p7w17Ne6HhnWc+Ch+Ig4PX5dT6opyOo8lYPLs4NU1MuirkZ++vs=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOH7S-000000007ch-1HgD for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:12:19 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so37280335e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 08:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793722332; x=1794327132; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jyaLiyiGU3AGo08Z/DuQLGKYT8a8653gwYY8OcZZY2c=;
 b=TCFOr/YO0EY8Axu5oXBRLuVyY+691NU9krHblU3vKE52EeNeYgLVPK5el47ir9V9vU
 UxmM+0yRT4pL0/bCLPtSDznyf5r58bE+j2ojb2RALQ3llm5h3uIq4Cfz7+ZCLRo6v6yi
 Q0ilad+rTfZUdsy09UxZtdQyzCnwiAuDobpFKuDMxrqkA0RDpfNK5K6cayMcNH2DcZsU
 Gpdx1CZ0vrlm6XVcWgxrLSgUpi7UDxUYK+UV91wy3YTb3ghMAHvUvCwL8cBPGO24Ez5S
 ltamc17Cot4Za23h3UwpdBN7OleUvVTFH+IYeYBoT/qp7ebVwz43laD8eAvcLtOtTT2O
 8AuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722332; x=1794327132;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jyaLiyiGU3AGo08Z/DuQLGKYT8a8653gwYY8OcZZY2c=;
 b=W4FAAZLAM6xTvs9jz7ARjaU6CD4U6hsW3O2cPcClMijz2BW9pnpD2qZScovy42jUVK
 elga/Svr50HwS+UFzBCI9FeqtuDQC4yyN+XuWhXhdiUyZ5JbF5y3EKc+21YITqcahXk6
 6BTDwrP+mXQptuUMQPM7rLxj2UKOS6Gn6alXfAAwZV4NWjbMQD0O952Gj7l3kKpDGjvL
 axwDp4t80vEC2kvsPSMFs1RJweMhlx6cK4J2QzmHEB2cBhbDuWtKMPaWeVt91uf2p95L
 rkDrm9Ft98+CvLTFQl04d1ag7tLXjCHl8r4kfcye1UQ37kPefCAfMxc4Lz8Bkr4GJolp
 BwLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrVgkIuxKk7hEpmfwJkII0jldV7nTdRFuVJPmwVxFZ5vWpwye2mBaeuFOOz9mii18p4krQy0+4Bga33HVO@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8h2dc+ZlywCLxcSSSZYmoN5K7G++ePpapjPPtc88YSEDUqxcqm
 GxfSi17Td2puDotlNsR7nqFBqgf9kREBo4P8IDQI89IL2lSFdk4zNUpwoWXnYB7f/fE4q5syto5
 HSTz+D2S09727Qq5Lz02gVq2FBLJ5l46sg0UkPEgRx8TXjMy/+HXHYVgpYA/ZtpiYmiwAwj4K2X
 lqLx4i1g==
X-Gm-Gg: AYBFou1WXJJHfoSyuFIQUYpC1XeKUe8KXTLufLOJqF7QUKYKpjQd1ux8uYgZaAMrAN5
 K5X+bt+qPDClF9D5OALUM9fOfcpwjHUGNtwhK5K9VFXfUBdC1lP+0rQc2mWVQDIAQtmOx/FD6SG
 6TJkz6HDYDRzfZ2wdtcjlVGPG/Hv7u6GtsWDxR/wG9KZ6LmPY0wXDm/XP+wzizBZ0j2J8gd2s4Y
 M+BvEMGHXNtCVAM/piE3IivXL83q1p7RPrR4HZmjzPlWkTA1UlNAyZ3v9hJFIDy9Reyq1CLMtcp
 uwtg46RvnPT2h4ruqyHfloF0jZop1/sgCL/pmkZW2iydIlnsZ1OnrCloxgO0Mp8tLaBI6Alkw8E
 JIygosCXmDCyZnanntb5J0/mO0E9VxGHrpG+djBRcYFEXARka3qZV/SNri2+glkcG4zLtl5pzVN
 wC9dqVrrk1BoqJsDjgPHol+8btHfb+cVH+vq0D3bLVjImWH+5dlTaHRu8nHTjprz///hojkY/Kn
 WzqVXNxnkIsyoemUWAhNQqkWIfmY/2htLjikZfTGiq4qDbkeeZvWtFFAJJfWllCYs8+9ON6ISxh
 /VKVeEA4S2yQQDQCGZqrkZESWGr12QThzToxWdGXrpqEVfYOP71BHbCdkSNBntqW22oku6i4pyA
 dI8B+dTIm2wUzigqtlKIbRX6dIq53prSkmrGpJQjdGjT3soYiczNpR1UUzG8paH83ZFcCJJKCsn
 7Ti5qD+hzNt+ZXpw==
X-Received: by 2002:a05:600c:3f14:b0:4a3:59ee:86b with SMTP id
 5b1f17b1804b1-4ac14ec873emr302418585e9.4.1793722331170; 
 Tue, 03 Nov 2026 08:12:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aae24b32sm65931495e9.12.2026.11.03.08.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:12:10 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 16:12:10 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Icf823c286e48726934131af722fadee4a2ef7a56
X-Gerrit-Change-Number: 2088
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2088?usp=email>
X-Gerrit-Commit: ccdcfa9df2cfafe0d6f4f04c0facbc46ee807ef3
In-Reply-To: <gerrit.1793622782000.Icf823c286e48726934131af722fadee4a2ef7a56@gerrit.openvpn.net>
References: <gerrit.1793622782000.Icf823c286e48726934131af722fadee4a2ef7a56@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjIyNzgyMDAwLkljZjgyM2MyODZlNDg3MjY5MzQxMzFhZjcyMmZhZGVlNGEyZWY3YTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c155a96d9853af5d51f1861416c9b14ca0966a3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOH7S-000000007ch-1HgD
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: wipe PRF master
 secret on failure paths
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6197196281900408221=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6197196281900408221==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fs/3PbO1IwM="; charset=UTF-8

--fs/3PbO1IwM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2088?usp=3Demail )

Change subject: ssl: wipe PRF master secret=
 on failure paths
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

ssl: wipe PRF master secret on failure paths

generate_key_expansion_o=
penvpn_prf() returned early without wiping
master when either openvpn_PRF()=
 call failed=2E Wipe it at a single
exit point=2E

Change-Id: Icf823c286e48=
726934131af722fadee4a2ef7a56
Signed-off-by: Razvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Acked-by: Steffan Karger <steffan@karger=2Eme>
Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2088
Message-Id: <20261102141538=2E2983=
0-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg40471=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl=2Ec
1 file changed, 7 inse=
rtions(+), 4 deletions(-)




diff --git a/src/openvpn/ssl=2Ec b/src/openvp=
n/ssl=2Ec
index 5b7a1fa=2E=2E12b6119 100644
--- a/src/openvpn/ssl=2Ec
+++ b=
/src/openvpn/ssl=2Ec
@@ -1505,6 +1505,7 @@
 generate_key_expansion_openvpn_=
prf(const struct tls_session *session, struct key2 *key2)
 {
     uint8_t m=
aster[48] =3D { 0 };
+    bool ret =3D false;
 
     const struct key_state=
 *ks =3D &session->key[KS_PRIMARY];
     const struct key_source2 *key_src =
=3D ks->key_src;
@@ -1523,7 +1524,7 @@
                      sizeof(key_src=
->client=2Erandom1), key_src->server=2Erandom1,
                      sizeo=
f(key_src->server=2Erandom1), NULL, NULL, master, sizeof(master)))
     {
-=
        return false;
+        goto exit;
     }
 
     /* compute key expa=
nsion */
@@ -1532,13 +1533,15 @@
                      key_src->server=2Era=
ndom2, sizeof(key_src->server=2Erandom2), client_sid,
                     =
 server_sid, (uint8_t *)key2->keys, sizeof(key2->keys)))
     {
-        re=
turn false;
+        goto exit;
     }
-    secure_memzero(&master, sizeof(=
master));
 
     key2->n =3D 2;
+    ret =3D true;
 
-    return true;
+exi=
t:
+    secure_memzero(&master, sizeof(master));
+    return ret;
 }
 
 /*
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2088?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icf823c286e487269341=
31af722fadee4a2ef7a56
Gerrit-Change-Number: 2088
Gerrit-PatchSet: 3
Gerrit-=
Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffa=
n@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--fs/3PbO1IwM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2088?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl: wipe PRF master secret on fai=
lure paths<br><br>generate_key_expansion_openvpn_prf() returned early witho=
ut wiping<br>master when either openvpn_PRF() call failed=2E Wipe it at a s=
ingle<br>exit point=2E<br><br>Change-Id: Icf823c286e48726934131af722fadee4a=
2ef7a56<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>=
Acked-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2088<br>Message-Id: &lt;20261102141538=
=2E29830-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40471=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
ssl=2Ec<br>1 file changed, 7 insertions(+), 4 deletions(-)<br><br></pre>
<p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>ind=
ex 5b7a1fa=2E=2E12b6119 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</s=
pan><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1505,6 +1505,7 =
@@</span><br><span> generate_key_expansion_openvpn_prf(const struct tls_ses=
sion *session, struct key2 *key2)</span><br><span> {</span><br><span>     u=
int8_t master[48] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool ret =3D false;</span><br><span> </span><br><span>     con=
st struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><sp=
an>     const struct key_source2 *key_src =3D ks-&gt;key_src;</span><br><sp=
an>@@ -1523,7 +1524,7 @@</span><br><span>                      sizeof(key_s=
rc-&gt;client=2Erandom1), key_src-&gt;server=2Erandom1,</span><br><span>   =
                   sizeof(key_src-&gt;server=2Erandom1), NULL, NULL, master=
, sizeof(master)))</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        goto exit;</span><br><span>     }</span><br><=
span> </span><br><span>     /* compute key expansion */</span><br><span>@@ =
-1532,13 +1533,15 @@</span><br><span>                      key_src-&gt;serv=
er=2Erandom2, sizeof(key_src-&gt;server=2Erandom2), client_sid,</span><br><=
span>                      server_sid, (uint8_t *)key2-&gt;keys, sizeof(key=
2-&gt;keys)))</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        return false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        goto exit;</span><br><span>     }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    secure_memzero(&amp;master, sizeof=
(master));</span><br><span> </span><br><span>     key2-&gt;n =3D 2;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D true;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+exit:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(&amp;master=
, sizeof(master));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return ret;</span><br><span> }</span><br><span> </span><br><span> /*</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2088?usp=3Demail">change 2088</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2088?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Icf823c286e48726934131af722fadee4a2ef7=
a56 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2088 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>

</body></html>
--fs/3PbO1IwM=--


--===============6197196281900408221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6197196281900408221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6197196281900408221==--

