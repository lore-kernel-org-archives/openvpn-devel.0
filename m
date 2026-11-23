Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB92606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OlMW1l+J;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g74uxzQm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VAKWm2QS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FX4EpSwH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6Pj4trBqBdGAnQGSQxa6uzPiesD9xEU4gMSi4Y1y48g=; b=OlMW1l+JOXbhImATxvSnKZSh62
	j1vJLauGwb3cLTPxbOJ0YkpWozKddUCSUQO05jbUASMjMj157mk71J8uru67r+66UQ5SNSi1qRpl7
	WPsJmOXT+b7sautucNzixNXEfQvPg8BZH22PcAEEp+myMN5ZAL75cGGLrJVe/WhgkE6U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVYuv-000000001u4-1xhd;
	Mon, 23 Nov 2026 18:37:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVYuu-000000001tx-0e6Q
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:37:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2p/ck9rZhLgrcoLd/lN8yVfwmY/Ykkdx4yZoMTE6cPA=; b=g74uxzQmY+yASDQw+ROKyMr1zw
 rN4WgYv8PaynUW2i6F1fLwR+53nJUENe79wxILvepm2evvbB6rFAJz+5WQVklLTdwM9k1cLAs0mZR
 TGQfRjlDvItsUQexBfjJUWenwuMUn3vpWhsdDD6mXiuf4Iey+UKAzk1wfbW1ePgxyte4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2p/ck9rZhLgrcoLd/lN8yVfwmY/Ykkdx4yZoMTE6cPA=; b=VAKWm2QS+XIFakWSKtArkpi00K
 T0YN0IXZUm6zVx1mW579rC918wB+mB2BviiVk20DmEpUYnyZKJUh3aQgchnwEyOJjXE7PRPipOP2k
 iNnKzPCxFgZjhEbCBE6Fkl3FuPj4ldm30FhslTuMK3+0YnhzxZOxvws4tFyf5m4fdxL0=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVYus-000000003St-2w3r for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:37:28 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so2293739f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 10:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795459040; x=1796063840; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2p/ck9rZhLgrcoLd/lN8yVfwmY/Ykkdx4yZoMTE6cPA=;
 b=FX4EpSwHze9I1fEm8/MNbR6Nd7xujX6PIYl02qMZEGm0ucFa3iOczkVa8B9qoSGmnZ
 ZGyPiISJQoXE+sUCQ4M/k7w+lNOOairBhmNTiknaVjxa73mQUL5Vf6Yqv8sd5J/K2ruS
 pFdx0XBOxHrK+QyNBNvqLQQg+u3v2+aQJaY2Pc913UHCLrzUjbhdq/B47Q80nUus4732
 HOVGWGIiczc9xwAh4Opz7jNhUN/sufehWWFUhllHRnvV9IvD6jNOv4GB6AwO5029Ah51
 JwLC6egyi6LG1TYCJwyxiHNHuC0usQ3Sf9omDSuhoVqiCqVrDukn6baaFI2oa0hspnxz
 9ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459040; x=1796063840;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2p/ck9rZhLgrcoLd/lN8yVfwmY/Ykkdx4yZoMTE6cPA=;
 b=KA1+hv8QEb/ueNyjYwG0J9YPQrVij1idExm3Yiwenq1aSvW28nr4tZC04IegqVAdr9
 ea2NZqoclwBCisRPICRRtI6ouSfcyqGLb4Z/Yb7S9vaFMAorwst0hYghtameGC3MK16U
 P1TRzCNFMbrrSlekOFIiuXfsUx6XuWjZDd56UCQ7Ek62+wxTw+P2TB0KJmDPI+ycHjfH
 NXMPW9JJ0QURNmKG+GLuBAnJjVCmhm6A/qTvMYo7rpN9gHTsJDxuvJTf03x9c7Lg+dxt
 zcAeBDfDg0M9GEU6Kw8lirn/PUlgf1tN1uiK5sxkg1UTzq35THUwWAvdovcZMSU80rcX
 x01w==
X-Gm-Message-State: APuU4Z/JOh1kMBLjKEgFHxfrxVNDH/TPJ+tTNglW5fmhk5EEWRsi2Ie6
 hRl61Ui8/P5KgFRnEKwPue3wWrw7gIs36uzv9DBDul/Dqz3r9DTVoPr09793/ZKTHFXUzA7329t
 3GzQvd/skUgSsCK7h62ZFvPCwIaCRDL2bI0fzHpO1l+5mz1z3N2GiVrjemijzxx98dGZi
X-Gm-Gg: AZFdTZdKASZRG3Xgbz4KO/HpnSWf2Z/T15BM9iL5NDURZI9FSDz9dDDLqlvTglLUr4w
 pQXycuPaa+2Orxe3USk+r0zP1JKF11OfUUxgqquBm3JyrhwUlR/WIe7rOIxPzMfxSBfNIqhdaKl
 9BAOhAaV7KD5aXpz3oe2Grm9yRzYp+PMmRIBgG+BneZ8rQz4hZN8es7u3/rBqjFqs7czHrQNRep
 GXDHqnVZeW+PwRdoZrx3Iao2HwDNmMPGKNPeEboNeOXUcCpU9XqZPp1VYy+lSjxud0TeZ0GBH7L
 Ic99gN3NZu5QVZaezyw22t3SDcI7Cvd8vAp94ape6Bw7m0FT3DzB43kWTrYjIOv0BmajtB/hgrb
 prrhY9/tA74XhmX4RHIxBZU6ppsNPbHI4xgNG4BpaIJDJ4TitHsxUxcEdZG64dllwVYIVs2LvNZ
 20YFnms4J49lyiSP0uibPQKS9PXpdMY+ipCywcunnn0Ad1ZrbyGMMzqP/tRD5SRTPJJFnbF/dY7
 e2MzaqN1Yi05bTNQ1QzAIlZ2CVh2Y9oc9WjXJw+zIiubfoTCCI40zScxIeLgMCA1/f15KXclrXo
 AnBV7KFobP7rgxcIrrrAoWUQ5bKl2e5K4s/A0+FPexyCBh9k+v7m1qZS+4BgCiTYvhCa/Trn9LL
 YnfAxenSFLZU137JgQYIObaUGIpKEXBcCCplpIlwB32PViNxZeS77faBCotQ4tMZGEXFNlIFgep
 nfyBDdhjmdYx/89JKDTL8T54jm7kBC29V7PeEF
X-Received: by 2002:a05:6000:4b1e:b0:4a7:150e:cfe5 with SMTP id
 ffacd0b85a97d-4abb46bc772mr21656980f8f.42.1795459039773; 
 Mon, 23 Nov 2026 10:37:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f281sm22266781f8f.22.2026.11.23.10.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:37:19 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 18:37:18 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id142eda108dd4385dcdc263a4842aeb314a12f41
X-Gerrit-Change-Number: 2239
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2239?usp=email>
X-Gerrit-Commit: f42b9083a410ea28adbe69ccd5ae48d7b9ff7a9e
In-Reply-To: <gerrit.1795378662000.Id142eda108dd4385dcdc263a4842aeb314a12f41@gerrit.openvpn.net>
References: <gerrit.1795378662000.Id142eda108dd4385dcdc263a4842aeb314a12f41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Mzc4NjYyMDAwLklkMTQyZWRhMTA4ZGQ0Mzg1ZGNkYzI2M2E0ODQyYWViMzE0YTEyZjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ddb78f7c8464a5bf4dc0d0db285f34266cad6dc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVYus-000000003St-2w3r
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: don't log key
 generation failure twice
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
Content-Type: multipart/mixed; boundary="===============6693353293687934225=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6693353293687934225==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wXmmBRSpT6M="; charset=UTF-8

--wXmmBRSpT6M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2239?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: ssl: don't log key g=
eneration failure twice
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

ssl: don't log key generation failure twice

tls_session_generat=
e_data_channel_keys() already logs
"generate_key_expansion failed"; tls_mul=
ti_process() repeated it=2E

Change-Id: Id142eda108dd4385dcdc263a4842aeb314=
a12f41
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2239
Message-Id: <20261123134935=2E31769-1-gert@greeni=
e=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg41823=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/ssl=2Ec
1 file changed, 0 insertions(+), 1 d=
eletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/39/2239/2

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
inde=
x d5ae13d=2E=2Eeb6b86f 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/s=
sl=2Ec
@@ -3504,7 +3504,6 @@
             enum key_gen_status status =3D tl=
s_session_generate_data_channel_keys(multi, session);
             if (stat=
us !=3D KEY_GEN_OK)
             {
-                msg(D_TLS_ERRORS, "TLS =
Error: generate_key_expansion failed");
                 ks->authenticated =
=3D KS_AUTH_FALSE;
                 key_state_ssl_shutdown(&ks->ks_ssl);
  =
               ks->state =3D S_ERROR_PRE;

-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2239?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Id142eda108dd4385dcdc263a4842aeb314a12f41
Gerrit=
-Change-Number: 2239
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--wXmmBRSpT6M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2239?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">ssl: don&#39;t log key generation failure twice<br><br>tls_session_gene=
rate_data_channel_keys() already logs<br>&quot;generate_key_expansion faile=
d&quot;; tls_multi_process() repeated it=2E<br><br>Change-Id: Id142eda108dd=
4385dcdc263a4842aeb314a12f41<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2239<br>Mes=
sage-Id: &lt;20261123134935=2E31769-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
41823=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 0 insertions(+), 1 dele=
tion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/39/2239/2</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec=
 b/src/openvpn/ssl=2Ec</span><br><span>index d5ae13d=2E=2Eeb6b86f 100644</s=
pan><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/s=
sl=2Ec</span><br><span>@@ -3504,7 +3504,6 @@</span><br><span>             e=
num key_gen_status status =3D tls_session_generate_data_channel_keys(multi,=
 session);</span><br><span>             if (status !=3D KEY_GEN_OK)</span><=
br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                msg(D_TLS_ERRORS, &quot;TLS Error: generate_key_expansion=
 failed&quot;);</span><br><span>                 ks-&gt;authenticated =3D K=
S_AUTH_FALSE;</span><br><span>                 key_state_ssl_shutdown(&amp;=
ks-&gt;ks_ssl);</span><br><span>                 ks-&gt;state =3D S_ERROR_P=
RE;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2239?usp=3Demail">change 2239</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2239?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: Id142eda108dd4385dcdc263a=
4842aeb314a12f41 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2239 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--wXmmBRSpT6M=--


--===============6693353293687934225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6693353293687934225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6693353293687934225==--

