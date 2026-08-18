Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE37C5DF7D
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wBX7SvWbS0ANJjV1sXew3edPPgsgUp6iYQdLONjXlBo=; b=dSk64zVv3gi9UW7mQGfNccn2GI
	7zqBBanhl0W3FwkjKGT4vQ90LZHE03YtQ8RdJE78d37H+r6dd4oCasOzC3JmsEddv2TLcK6QA+EiC
	cx5iNteTMZTWHF1z2btR7iPFiXIxMOY7Ul2Qlwdf0tTk7vYMj78vOu1hF7QOlTxs8HAw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwIv1-0007uL-Dx;
	Tue, 18 Aug 2026 12:27:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwIuz-0007uF-Ia
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 12:27:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=66IKYdKelBtcnZJpE//abscVCZS/byest51zEDBpmZ8=; b=b2lcUp7xe7h4HlffolM7iAPwkn
 4weWDRwUbZg4R8jqIOv0RxSIzMFgAxZkI6WzbbzbIyQnyqZEe+FHjWB2vfkHBL79g2uO6qUkliNqW
 7WiE/0LKgotcNgacej2p0YQ7r8woPkAAQF8icuMI+FyQWnItV55hZDf8PYwI5YDWLPeQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=66IKYdKelBtcnZJpE//abscVCZS/byest51zEDBpmZ8=; b=j
 EfP8SPVhmftf0PyGRZF9rkIYCihqwPm6diEzTgeD2z/7dgH/GnrBRn5w+wfKIaWdBe39Cphi+MvM9
 1xlBfUjX4PPN/TXAuouGhMNGcUAe0JpxVaoROf+eA49+aufw3NZl7DBuvx6yfgMh2qVn8XSWMCE+U
 lXNz/vpRUOwemOuw=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwIv2-00048Z-Pq for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 12:27:50 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso23555185e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 05:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787056063; x=1787660863; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=66IKYdKelBtcnZJpE//abscVCZS/byest51zEDBpmZ8=;
 b=EqhUwUVJIarnkuxWdcDHOWyFVglvNjgKhA2O6lqM77jMATD6C7xr91K97bX/dzubo+
 tJk+l8QUlPFoAJjWiRyrZMsmRx5noNIKCRpUZudNvq2xONWpIo7UV89pVUVWzs//SrHB
 /E5B8IrZYGPPmdhUTfyMLGSLJ/HTm+ZdGtVyI8E8qSYObQwbT23wnMwXuIVal9h7HzNd
 5hk20RVsC7DK3tdQxARAOVdXB/2+iy04E7NWAIL5mIO1ucLgKiRGfaxDVYiGkkFL59+0
 NvsoURYmBHaj/KnHe0Sf8PdZ2f7mzZ5gnMzlpapL/Ru+lxwwSNYiHb56mSdsxXcT+bsX
 yXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787056063; x=1787660863;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=66IKYdKelBtcnZJpE//abscVCZS/byest51zEDBpmZ8=;
 b=jGKgcvEd8RATFFwehf8DtgAj1NdYZQZR1XmE/bxWnYDbBM8b7+NZ+PRDc1m7Vb1EuA
 rDmgWqwjENzgsiyBmmeaT0x/t6Cwv9UobKBq5LIadb7dceS2Alkod5b8uXRVHC5wBg/T
 xPEGqpGIbzZGOUtU6lRME421yhSbiiAPzDgRa7wNatRL/5My/ma4++dkqYR5Yjpf7Fns
 so/qXi0/R421vTomZbNOjUk6Ce3mXRAyFusM1lnD37lVyMYrp8G8eC7LkLboisDylgHH
 70sS4A4CMuHEtCFZJXoU7FDlIZb1BO0x+ttdcbF/uOwFQfKzxHcpyl3PfHTJ76zZoZ0h
 xnFA==
X-Gm-Message-State: AOJu0YwUC4krBAPrP4YhIhUARcG+fmGyl3GD0K+ZFo6wXrV8O5ZEVvf3
 INFruSqpqZawznOiCvS5SnVmX/Ib4+UbhpXEMEaTrgTxZ0mk4QC3HEDs+9Jt4NLA9vwllEbFzvl
 uM3XIBzdxhYGmK0/QnO3laNN+csc6XzBFyHTkntgGKsMs/q5cLxPF485S5CYWppnq2rXJ
X-Gm-Gg: AR+sD11gJF6MHNIYB/n82By1tphuv4wEi8dMmNVzCOnUkPu42xWru8jAz/5S/H73a1C
 7tb9I5jj7xRNa3oNdnFZd/3t9TI2ZiZ/0ufNKSWcAcyF1cX+wJBMAF0S4ye1jkwR7k4p+71Quws
 FCxvxT2trHLffawscceXs8RhT46e3/oX9WL/75rBW+wvmOtE7D5NwTHaAb3XBqiAUEy5/Zernr4
 TMM9e+fTZNHZvQT/3VwqIB9X07HcUHJhCpUi5/zOBzBgBbgdR+z0JIGp+jvPJ00TDEKeCYxteLX
 L0OUCz8gDo3mOElaP50E1lUtMHnNavUebKnSYSzVLYJjQKsxhOeemTxbfqGbD4tc0q4CQb0D7+e
 rrn/Y0CHaCcPKhhmvn+flhDmlNyRXaASbQtuuElGo9FEnRb0/9DSpt8Uavm4cp7Yw5vbCgdXkcO
 MfoyfD//ZfC8epz09fgU/qIi2H1gej9oXnF6EFPdi8PZLY4lGH0hifekgPYyYcZUvLS8gt2xczB
 ZZAyoTpyF/KzLL7wiiGrmpwJ7UGhtbz4ONkp8GbqG4YWsUgTIb/lGQxNQ3R5WPJkbG35jeOxwNE
 Ii59RNB71iLbU/Khr9FcyEWoKv4MD0pl70XoOZtwjuU5bTWpNrI=
X-Received: by 2002:a05:600c:628c:b0:499:87f3:a2a3 with SMTP id
 5b1f17b1804b1-49987f3a33emr574797885e9.15.1787056062379; 
 Tue, 18 Aug 2026 05:27:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996100082sm328053125e9.2.2026.08.18.05.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 05:27:41 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 18 Aug 2026 12:27:40 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
X-Gerrit-Change-Number: 1844
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1844?usp=email>
X-Gerrit-Commit: 360e3c1ad00e7b88371933e5196386af3e9fa74a
In-Reply-To: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTU5NzcxMDAwLklkM2M2NjgxYjI5MDI2YzI5MjBhNjJhMGVhNTcwZmQwOTg2NDllMTk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e1c021fba5b3502c42d7d958aac0a2b1f4307307-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwIv2-00048Z-Pq
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Reduce number of
 future epoch keys from 16 to 4
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6333828312020668768=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6333828312020668768==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NMPokp0n07U="; charset=UTF-8

--NMPokp0n07U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
razvanc


Change subject: Reduce number of future epoch keys from 16 to 4
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Reduce number=
 of future epoch keys from 16 to 4

The calculation in the RFC was wrong an=
d probably influenced
by an older worst case assumption=2E With the fixed c=
alculation
four future epoch keys should be more than enough even for
100 G=
bit/s=2E So change the number to 4 in OpenVPN as well=2E

This also reduces=
 the spam about the epoch keys a bit=2E

Thanks to Ralf Lici for noticing t=
he wrong calculation=2E

Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e1=
97
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1844
Message-Id: <20260817142115=2E28993-1-gert@greenie=2Emuc=2Ede>
=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg38459=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
--=
-
M src/openvpn/crypto_epoch=2Ec
M src/openvpn/ssl=2Ec
2 files changed, 11 =
insertions(+), 6 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/44/1844/5

diff --git a/src/openvpn/crypto_epoch=2E=
c b/src/openvpn/crypto_epoch=2Ec
index 54225bf=2E=2E37933a1 100644
--- a/sr=
c/openvpn/crypto_epoch=2Ec
+++ b/src/openvpn/crypto_epoch=2Ec
@@ -308,9 +30=
8,10 @@
         free_key_ctx(&co->key_ctx_bi=2Eencrypt);
 
         /* Upd=
ate the epoch_key for send to match the current key being used=2E
-        =
 * This is a bit of extra work but since we are a maximum of 16
-         *=
 keys behind, a maximum 16 HMAC invocations are a small price to
-         =
* pay for not keeping all the old epoch keys around in future_keys
+       =
  * This is a bit of extra work but since we are a maximum of
+         * e=
poch_data_keys_future_count keys behind (4 by default),
+         * a maxim=
um 4 HMAC invocations are a small price to pay for not
+         * keeping =
all the old epoch keys around in future_keys
          * array */
         =
while (co->epoch_key_send=2Eepoch < new_epoch)
         {
diff --git a/src/=
openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index fd96b85=2E=2E01e45fd 100644
---=
 a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1343,10 +1343,14 @@
 i=
nit_epoch_keys(struct key_state *ks, struct tls_multi *multi, const struct =
key_type *key_type,
                 bool server, struct key2 *key2)
 {
-  =
  /* For now we hardcode this to be 16 for the software based data channel
=
+    /* For now we hardcode this to be 4 for the software based data channe=
l
      * DCO based implementations/HW implementation might adjust this num=
ber
-     * based on their expected speed */
-    const uint8_t future_key_=
count =3D 16;
+     * based on their expected speed=2E
+     *
+     * One =
epoch lasts 910 GiB with 128 byte packets or 78s at 100 GBit/s=2E
+     * (=
respectively 1011 GiB and 86s with 1280 byte packets)=2E
+     */
+    cons=
t uint8_t future_key_count =3D 4;
 
     int key_direction =3D server ? KEY=
_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
     struct key_direction_state =
kds;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id3c6681b290=
26c2920a62a0ea570fd098649e197
Gerrit-Change-Number: 1844
Gerrit-PatchSet: 5=

Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razv=
anc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--NMPokp0n07U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">Reduce number of future e=
poch keys from 16 to 4<br><br>The calculation in the RFC was wrong and prob=
ably influenced<br>by an older worst case assumption=2E With the fixed calc=
ulation<br>four future epoch keys should be more than enough even for<br>10=
0 Gbit/s=2E So change the number to 4 in OpenVPN as well=2E<br><br>This als=
o reduces the spam about the epoch keys a bit=2E<br><br>Thanks to Ralf Lici=
 for noticing the wrong calculation=2E<br><br>Change-Id: Id3c6681b29026c292=
0a62a0ea570fd098649e197<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844<br>Message-Id: &lt;20=
260817142115=2E28993-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Ema=
il-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38459=2Ehtml<br=
>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M sr=
c/openvpn/crypto_epoch=2Ec<br>M src/openvpn/ssl=2Ec<br>2 files changed, 11 =
insertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/44/1844/5</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec</span><br><s=
pan>index 54225bf=2E=2E37933a1 100644</span><br><span>--- a/src/openvpn/cry=
pto_epoch=2Ec</span><br><span>+++ b/src/openvpn/crypto_epoch=2Ec</span><br>=
<span>@@ -308,9 +308,10 @@</span><br><span>         free_key_ctx(&amp;co-&g=
t;key_ctx_bi=2Eencrypt);</span><br><span> </span><br><span>         /* Upda=
te the epoch_key for send to match the current key being used=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-         * This is a bit of extr=
a work but since we are a maximum of 16</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-         * keys behind, a maximum 16 HMAC invocations are=
 a small price to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
     * pay for not keeping all the old epoch keys around in future_keys</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * This is a bi=
t of extra work but since we are a maximum of</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * epoch_data_keys_future_count keys behi=
nd (4 by default),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * a maximum 4 HMAC invocations are a small price to pay for not</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * keeping all =
the old epoch keys around in future_keys</span><br><span>          * array =
*/</span><br><span>         while (co-&gt;epoch_key_send=2Eepoch &lt; new_e=
poch)</span><br><span>         {</span><br><span>diff --git a/src/openvpn/s=
sl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index fd96b85=2E=2E01e45fd 100=
644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/ope=
nvpn/ssl=2Ec</span><br><span>@@ -1343,10 +1343,14 @@</span><br><span> init_=
epoch_keys(struct key_state *ks, struct tls_multi *multi, const struct key_=
type *key_type,</span><br><span>                 bool server, struct key2 *=
key2)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* For now we hardcode this to be 16 for the software based data cha=
nnel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* For now =
we hardcode this to be 4 for the software based data channel</span><br><spa=
n>      * DCO based implementations/HW implementation might adjust this num=
ber</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * based on th=
eir expected speed */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    const uint8_t future_key_count =3D 16;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * based on their expected speed=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * One epoch lasts 910 GiB with 128 byte =
packets or 78s at 100 GBit/s=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * (respectively 1011 GiB and 86s with 1280 byte packets)=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t future_key=
_count =3D 4;</span><br><span> </span><br><span>     int key_direction =3D =
server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;</span><br><span>    =
 struct key_direction_state kds;</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Dem=
ail">change 1844</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1844?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1844 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--NMPokp0n07U=--


--===============6333828312020668768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6333828312020668768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6333828312020668768==--

