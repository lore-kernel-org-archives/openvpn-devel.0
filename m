Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEFAC5DF7E
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wXSxNhZyCsgrw+zPFDOMIDERRZTw7afhtcESb55gIqo=; b=M8k5f0GL1zdy39ABtQycX9X89f
	P+VeG5M1B2J6R7tSTeXUGHa/vEwTBxOc2fRFwZksyIDhDacv/Spye8ZC0WWc+D8kwf2aEYzE6II+l
	HvzyN2jmGNzhdMd/dnNJ9FCIpLKODmPBHbMsn4y196AhbI44eNPK3bQoOEdWu57jDJlQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwIv2-0005No-SO;
	Tue, 18 Aug 2026 12:27:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwIv1-0005Nh-JM
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 12:27:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TXjtQkF9hVvKGGq0/K3/ch67OV6wBegM5T4tw29SLQE=; b=FpOL++gk8DxQ4H+CUw24tr0UQ0
 Xsy2NgVRjjD7aV9gcch3CnGkwBMbBSyaxhfWo80QUDvf9vDlcSsH/Cfn2wAC5D7lecwwWHUQJ88to
 QtsVMZGuuWM4tq8SzVtBnxBJyvWU9NaiS2r0jrKFX27FDLZ1m3hgd3yXPT66hZTrPNno=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TXjtQkF9hVvKGGq0/K3/ch67OV6wBegM5T4tw29SLQE=; b=e
 kO3Tem6Ql0H/DpZ1xrC/qqc/pgVWShRUKQ9i/KOuluOGAHP+oC0i4QtpPLg8tkaNLigEoxzzWEQie
 mj7HkXFnVwMshTZrxFG7kXI5WvcSGqB2LBvXAD6QRn3CjfexI1gx7CH4qHO5spN3KGtJBxzgr/wn0
 KTOuOuU6nuhPF8Mc=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwIv3-00048d-KD for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 12:27:51 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4998590d392so47611235e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 05:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787056063; x=1787660863; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TXjtQkF9hVvKGGq0/K3/ch67OV6wBegM5T4tw29SLQE=;
 b=KMYXLLUiRq/hzqEPhc+RvopouBJexiXaGiznCKA0hBCKP6f79oU9PwIB9/pDO1mM2X
 iQRqXcXBav7kpI3elLrQRyNG2J74X0BPnIcxo0ndUPMOFbpp5tT6RWYbX6kxNJnZrXBm
 l6CCRby6aLReQpWNHW8u9nXnxvU0OBd3OYEl2xp09jflffLI3JSW+Q4Si6IWnR83KfsI
 IUUO5N/30Xk7U+EA0MUIyU2iMY4l8/RocrXlotD07zqFTjsnlDyxneEFIkUrrIqEywbj
 mbo2g8pImFg8JjFLSh+wTGNyTdDFYYrSQem/EpQyeRcdLhXyd4JyZkd30R+kywWSAnvJ
 ahzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787056063; x=1787660863;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TXjtQkF9hVvKGGq0/K3/ch67OV6wBegM5T4tw29SLQE=;
 b=J/O2tv4WITkHYCOIegqZdL4CCp2d/4rdWcGTa4k464WihrsW9NZ3js+42Q+eC9U3Z+
 vgdc1AGY6+U255S8UbgHtXQxEuUMsgMAhCozUSKweEJoE86Auh63hUvjf6fwVTaI+sA5
 hAZuQRoK+hf9NCDsNwgCbiknFQKm/2WSCTpT0QBuSw1TOEsaQ2EmSgRk3mkP/q3OhhDf
 I52meqB0yro5sVKFZ1zcFm9dXtmQ0MNqw4TOCL5pbuFukiv1zUEIFmv1mPq0lMZbmKSW
 fYYpsj6VZbsL3wSHicA6QAcK1je5tI3xeo6+uds4wiMyF0Z+JtPzXACpKpPRGbXMg2h3
 pqMg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpU6nuLTD0wzWaoFUdM+hY64IRjdDeIHz+kgAY0IFxuGJTjImkzurQcSd8DhNNXsJyN6NOLh0oCl9A76Vim@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzMhWzYNyQMrTQRzLKXuFEFU2TWpp73EXGnwgmWBEf/M5nZUae9
 FhLwPUWd9NjdPovgD2Jw8XD1KQvTnRjcfrP9LQwmlRxjcONTh0azazeuiWR/74pWH3cHwPMM4Bv
 f7nmprqcXemXtfFx9Ec7ogZ4mhvZh0f4M2SKYe0bb71CjC8w4eCr8uQOHT5J+Jx/ZL97L
X-Gm-Gg: AR+sD12fWqEL2tIn1mrnqNyZnwRxxZnT6wRUKSJzgZWnA+fHLzBKgKXTwgs0+LlFN6R
 AK6ZCU9ivVdA3xUyHJY0WkJaYRupRWEAACJmjU3raf/A7bekpGcl01/miHZPn2vE1wiUMe6nVwf
 JL5KBjkmlN8nPmX7ZhZBL9CGhdb9aL0YPZrLjbtaOMq05BR8smz7WRG99QVLHkkF0GxwCkB9dvD
 KJNvROEOIs/wMlkWDY9Zxug124UPq3DVG8cQ3leLdFSt5KvQCY/R7rGny78KuQ68ProCdjcMrLf
 DF32Ed63A2+AAj4S0VQS9+bZKJv0RVsQa0dBdYBwAHhmL0LGrayWUHqi4XdHfEXF4j2vqPNXwCg
 Jr00nUvVtXKuBHwl/ELfrCw5sgQG6qBNZI9fkq7dPTqG30FZM8X6X6aeuw4S5QbnQdRVYE9LgHw
 PPEKhqRWimA/rZT0cJf87rx3acN601EcuMJtsjwhiF0qkhgXagfcIIb5HE93l57VlPU0M1oHMML
 U3HvHFDrVwSaxFMkVCuPFjAZ4MaPhc0bDzfsQuYjB5wfK/fPVnBsppuh4FtlC9ZzEb9Y7yFRrjO
 KKpB6DOPBKWYAVccUhEX4CF1HyibbdypIK65KOXZx4/MLhUW1kg=
X-Received: by 2002:a05:600c:c3cd:20b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-499a277e9bbmr74938845e9.3.1787056063432; 
 Tue, 18 Aug 2026 05:27:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d06167csm134347025e9.3.2026.08.18.05.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 05:27:43 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 18 Aug 2026 12:27:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
X-Gerrit-Change-Number: 1844
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1844?usp=email>
X-Gerrit-Commit: 360e3c1ad00e7b88371933e5196386af3e9fa74a
In-Reply-To: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTU5NzcxMDAwLklkM2M2NjgxYjI5MDI2YzI5MjBhNjJhMGVhNTcwZmQwOTg2NDllMTk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e1c021fba5b3502c42d7d958aac0a2b1f4307307-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwIv3-00048d-KD
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
Content-Type: multipart/mixed; boundary="===============7592260736330069700=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7592260736330069700==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KNE+Ur5ijeI="; charset=UTF-8

--KNE+Ur5ijeI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1844?usp=3Demail )

Change subject: Reduce number of future epoch keys =
from 16 to 4
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Reduce number of future epoch keys from 16 to 4

The calculation in the R=
FC was wrong and probably influenced
by an older worst case assumption=2E W=
ith the fixed calculation
four future epoch keys should be more than enough=
 even for
100 Gbit/s=2E So change the number to 4 in OpenVPN as well=2E

Th=
is also reduces the spam about the epoch keys a bit=2E

Thanks to Ralf Lici=
 for noticing the wrong calculation=2E

Change-Id: Id3c6681b29026c2920a62a0=
ea570fd098649e197
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by=
: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1844
Message-Id: <20260817142115=2E28993-1-gert@green=
ie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg38459=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/crypto_epoch=2Ec
M src/openvpn/ssl=2Ec
2 fil=
es changed, 11 insertions(+), 6 deletions(-)




diff --git a/src/openvpn/c=
rypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
index 54225bf=2E=2E37933a1 1=
00644
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src/openvpn/crypto_epoch=2Ec=

@@ -308,9 +308,10 @@
         free_key_ctx(&co->key_ctx_bi=2Eencrypt);
 
 =
        /* Update the epoch_key for send to match the current key being use=
d=2E
-         * This is a bit of extra work but since we are a maximum of =
16
-         * keys behind, a maximum 16 HMAC invocations are a small price=
 to
-         * pay for not keeping all the old epoch keys around in future=
_keys
+         * This is a bit of extra work but since we are a maximum of=

+         * epoch_data_keys_future_count keys behind (4 by default),
+    =
     * a maximum 4 HMAC invocations are a small price to pay for not
+     =
    * keeping all the old epoch keys around in future_keys
          * arra=
y */
         while (co->epoch_key_send=2Eepoch < new_epoch)
         {
dif=
f --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index fd96b85=2E=2E01e4=
5fd 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1343,10 =
+1343,14 @@
 init_epoch_keys(struct key_state *ks, struct tls_multi *multi,=
 const struct key_type *key_type,
                 bool server, struct key2=
 *key2)
 {
-    /* For now we hardcode this to be 16 for the software based=
 data channel
+    /* For now we hardcode this to be 4 for the software bas=
ed data channel
      * DCO based implementations/HW implementation might a=
djust this number
-     * based on their expected speed */
-    const uint8=
_t future_key_count =3D 16;
+     * based on their expected speed=2E
+     =
*
+     * One epoch lasts 910 GiB with 128 byte packets or 78s at 100 GBit/=
s=2E
+     * (respectively 1011 GiB and 86s with 1280 byte packets)=2E
+   =
  */
+    const uint8_t future_key_count =3D 4;
 
     int key_direction =
=3D server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
     struct key_=
direction_state kds;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1844?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
d3c6681b29026c2920a62a0ea570fd098649e197
Gerrit-Change-Number: 1844
Gerrit-=
PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>

--KNE+Ur5ijeI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1844?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Reduce number of future epoch keys from 16=
 to 4<br><br>The calculation in the RFC was wrong and probably influenced<b=
r>by an older worst case assumption=2E With the fixed calculation<br>four f=
uture epoch keys should be more than enough even for<br>100 Gbit/s=2E So ch=
ange the number to 4 in OpenVPN as well=2E<br><br>This also reduces the spa=
m about the epoch keys a bit=2E<br><br>Thanks to Ralf Lici for noticing the=
 wrong calculation=2E<br><br>Change-Id: Id3c6681b29026c2920a62a0ea570fd0986=
49e197<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1844<br>Message-Id: &lt;20260817142115=2E28=
993-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg38459=2Ehtml<br>Signed-off-by: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/crypto_=
epoch=2Ec<br>M src/openvpn/ssl=2Ec<br>2 files changed, 11 insertions(+), 6 =
deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_epoch=2Ec b/s=
rc/openvpn/crypto_epoch=2Ec</span><br><span>index 54225bf=2E=2E37933a1 1006=
44</span><br><span>--- a/src/openvpn/crypto_epoch=2Ec</span><br><span>+++ b=
/src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -308,9 +308,10 @@</span><b=
r><span>         free_key_ctx(&amp;co-&gt;key_ctx_bi=2Eencrypt);</span><br>=
<span> </span><br><span>         /* Update the epoch_key for send to match =
the current key being used=2E</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         * This is a bit of extra work but since we are a maximum o=
f 16</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * keys b=
ehind, a maximum 16 HMAC invocations are a small price to</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-         * pay for not keeping all the =
old epoch keys around in future_keys</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * This is a bit of extra work but since we are a =
maximum of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
* epoch_data_keys_future_count keys behind (4 by default),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         * a maximum 4 HMAC invocati=
ons are a small price to pay for not</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * keeping all the old epoch keys around in future=
_keys</span><br><span>          * array */</span><br><span>         while (=
co-&gt;epoch_key_send=2Eepoch &lt; new_epoch)</span><br><span>         {</s=
pan><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span>=
<br><span>index fd96b85=2E=2E01e45fd 100644</span><br><span>--- a/src/openv=
pn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -13=
43,10 +1343,14 @@</span><br><span> init_epoch_keys(struct key_state *ks, st=
ruct tls_multi *multi, const struct key_type *key_type,</span><br><span>   =
              bool server, struct key2 *key2)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* For now we hardcode this =
to be 16 for the software based data channel</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* For now we hardcode this to be 4 for the so=
ftware based data channel</span><br><span>      * DCO based implementations=
/HW implementation might adjust this number</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     * based on their expected speed */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const uint8_t future_key_count =
=3D 16;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * based=
 on their expected speed=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* One epoch lasts 910 GiB with 128 byte packets or 78s at 100 GBit/s=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (respectively 10=
11 GiB and 86s with 1280 byte packets)=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const uint8_t future_key_count =3D 4;</span><br><span> </span=
><br><span>     int key_direction =3D server ? KEY_DIRECTION_INVERSE : KEY_=
DIRECTION_NORMAL;</span><br><span>     struct key_direction_state kds;</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1844?usp=3Demail">change 1844</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Id3c6681b29026c2920a62a=
0ea570fd098649e197 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1844 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--KNE+Ur5ijeI=--


--===============7592260736330069700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7592260736330069700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7592260736330069700==--

