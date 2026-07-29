Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832C5C53219
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nQl2me5/paanujZLwu80jobJkLC0zT4dE2SBxdP8UGM=; b=c6OI1VQkBn+55La3OsizweyRXF
	a8cVtZkr5FxGz0gaMlGgO9pcTWKabsQJvwoPpqM32ZxiGIxURTsgqRrt7p3eF6oEuTz6ZMJ5QQI5m
	Gpzoaso7mAT34NfJIwe2hVfPnlrn1IOtfJDpR77nx2IJgI33y26AeCRHo1REg7xA3RkE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp7FT-0007mc-Q0;
	Wed, 29 Jul 2026 16:35:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp7FE-0007ll-TW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:35:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=m4QKGaCj7EiWx9BdzSTKmcRijvBfAfmrjoD/becffE8=; b=ehlxcVzwj5NuQv9PMFckGDjv1z
 hBgvdBBEvmI7t2JxHPuLSRrGqZ3/BtTWaqKNtTMS31YKh/z2VbThDjxYjzLh1ErcERdvymTrdHXaK
 VNenYYJbutP77fjh8BhOdApkiuAcvrvyvCuZ4SMfgpaQzZn1BCdjnUXlerA0TCDumQjk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=m4QKGaCj7EiWx9BdzSTKmcRijvBfAfmrjoD/becffE8=; b=m
 awkf3LgKSLu7q7+XxTInokWBb0j2UqDj+Er+npwZX1awQIygtdak/hGThmuOD/dDQEp2KrfqQcafU
 J71eZ3fBXdNSxE/Sw5aeWdIisAtGpkXdnqQ+k8IufG8jUc9iBC4rz5j6GZj2/3Sjy3x0WvkRJe2vy
 W7+tGrmwSjorLBps=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp7FE-0004gv-A7 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:35:01 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-472326ca506so881969f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785342894; x=1785947694; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m4QKGaCj7EiWx9BdzSTKmcRijvBfAfmrjoD/becffE8=;
 b=UN06qBHAyaIq/wjl9AxV+J9x0xVg7iG8pz+ZH+h2hA08ciQ6kE5mT/CMKPIoOCtFXs
 MYZbNqYp9zQTy6etwDPLNkjYcpI35MYtYO265NwvAtnB1xVVcoA3MrCZWQGKIBCUP4pW
 V64E99vhAzRj+FrOl+ZhOg67NslSJiDmHJ/3iWS5oKxVLN5O5Ka7BV7I1S7ZaAJmv7N+
 08UXTqCgrx0tlCUyCJxO1SLupAb0g8up7Qq3fx3sUwLDnhlxN3LEuXh42vMORMd+r8i4
 AtWTaP5f+gEza8F9ZQthF9DdAh3fb375cb73zhCvUtJUE4chjfnfTX/CtN19Cj9hwomG
 J3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785342894; x=1785947694;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m4QKGaCj7EiWx9BdzSTKmcRijvBfAfmrjoD/becffE8=;
 b=TlG83TlfdTe+udSUEcWrTp2qU75YvbVWvP0CB2N6EgjLXUxJuoiHB7TeZh+DNeXDF1
 MAs/TksD/9lAdCbgpIxnqiwr8TfCGvAGecZjHI0X1+7K5L+C+DKQ83X5tJlLmcCNEpNG
 QdywluhXxpXHMmWbYp/Sn3TN/akx3LZy/Dsz+ftGGEdYb3xAp4Hu6L5ixIdjSfgDDfW8
 W7i6c9Hn4Ep8G4MYafC4hN1g/Elf67TZ5TLQO8z6SIpG0xwnJpMMhwSS4mputztnpUcS
 xZy2rqRL7gGkjrx/sfc/2kOTJXnLh9Imus4w0ZzrZ6UhwHcwlGBtRHUoX/ORVh17ONBS
 9ZzA==
X-Gm-Message-State: AOJu0YyoG+XyEaYyDwnBqIe5hfBqbtIE+8vaFZLubVVfZyW5ehkWhMrU
 rCgH9Shl9pbkcvlDSsaD6VHNZT6dDudimN1Aild1g1kCfFDABIdz7s3i2uVQ3EKwjW5mE6zoNng
 04GOiEy09vjWJGhv4efJ58y/txN9LRLDVE9wunl2FCLj+ruCiOW37JT2FLCK/g2g44z8KiYa6Jw
 XFikmrdA==
X-Gm-Gg: AR+sD114dDi/tOE4MM813cWoKEnYQqiSmTY0PvcP6Dx1X4LN8zt0lQ0b8m00ws0Cp0M
 ubvHDsCnycFEVbi7FaVBNKo6laouhWcV8KELnBA6yRzPT62IPzNmmmoNTE4P8k9pDEtl1En0kWC
 NZxLkEEg6zUX+AzJS/4Vlrap89jM4UD3DsQdHZhneJvvgnGQtxXOXxl+jjwfRAR95/8s1nqrdYL
 oOQmecPd0ui+DOMpQLKYhloWqIL/RNFq+xxh8dfEVefwX7iyEG1pMPA1kJPIlrs5e1eXwjiVlxx
 j43vAEm2CjvXqG968RjB3VfvExygwkJtjGbcwN/dbUpVxOMDGAeYU/vYYybH/u8CQPP4MuT2zh7
 3jrOvZ4TcSMTJWcCyDcEALlfEVq72D8S1NEaP29KpRMT0kBFi7oiJUoH0DbFvF60RSWoRuwvorX
 Yefo9VTAJ+AlYvGMonDfWe9quQIzmiKfV7TP4fgbywhM3j4YWZ8gGw0mcNmiRmVuMZPnKULLE35
 PlfsNAgiYHD1OJ88ZHZi+Q7PNJxCHQPHPcGdWSrQ4usMhgpWBU3vjsQS8hqockx/T1oyUcm2v/n
 /kqBI0lRRCtG5E88jNtiurpg8XbY3hV6NKZ0Js+cDQbWlvWaYsc=
X-Received: by 2002:a5d:5f47:0:b0:47f:9de0:c27f with SMTP id
 ffacd0b85a97d-47fb1ecc547mr9936332f8f.1.1785342893625; 
 Wed, 29 Jul 2026 09:34:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b0ef25sm9134577f8f.24.2026.07.29.09.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 09:34:53 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 16:34:51 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
X-Gerrit-Change-Number: 1829
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1829?usp=email>
X-Gerrit-Commit: 2c8baca423b236ab12f7519b68ed88b4a709d0d1
In-Reply-To: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
References: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjY0NDQxMDAwLkk1Yjg2MmVhYmUwMzJlYjRkMjIyOWZmNWIyZjRmNmFmNzQwNmY2ZjRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <242c9fc02e689346d63c86f2a6a0657556fb1b5c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp7FE-0004gv-A7
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Correctly calculate
 packet id size when epoch packet format is in use
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5859727646873115541=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5859727646873115541==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RD447l+uEf0="; charset=UTF-8

--RD447l+uEf0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
ordex


Change subject: Correctly calculate packet id size when epoch packe=
t format is in use
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Correctly calculate packet id size when epoch packet format is in u=
se

The code assumed that always when tls mode (without CFB/OFB) is in use
=
that the packet size is 4 bytes=2E With epoch packet format is incorrect
as=
 that uses 64 bit=2E

Even thought packet_id_long_form has a the same size =
(8 byte) it is not
the same header format (32 bit time + 32 bit IV) as the =
epoch
format (16 bit epoch + 48 IV)=2E Use a simple sizeof(uint64_t) to
avo=
id suggesting that it might be the same=2E

Github: closes OpenVPN/openvpn#=
1074

Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
Signed-off-by: A=
rne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Antonio Quartulli <antonio@mande=
lbit=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829
Mes=
sage-Id: <20260729064158=2E15731-1-gert@greenie=2Emuc=2Ede>
URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37983=2Eh=
tml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn=
/mtu=2Ec
1 file changed, 8 insertions(+), 0 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/29/1829/3

diff --git a/=
src/openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec
index e5db8ab=2E=2Ef3c2874 100644=

--- a/src/openvpn/mtu=2Ec
+++ b/src/openvpn/mtu=2Ec
@@ -35,6 +35,7 @@
 #in=
clude "crypto=2Eh"
 
 #include "memdbg=2Eh"
+#include "ssl_common=2Eh"
 
 /=
* allocate a buffer for socket or tun layer */
 void
@@ -51,6 +52,13 @@
 ca=
lc_packet_id_size_dc(const struct options *options, const struct key_type *=
kt)
 {
     bool tlsmode =3D options->tls_server || options->tls_client;
+ =
   bool epoch =3D options->imported_protocol_flags & CO_EPOCH_DATA_KEY_FORM=
AT;
+
+    /* epoch format uses a 64-bit packet id: 16 bit epoch + 48 bit p=
er-epoch counter */
+    if (epoch)
+    {
+        return sizeof(uint64_t)=
;
+    }
 
     bool packet_id_long_form =3D !tlsmode || cipher_kt_mode_ofb=
_cfb(kt->cipher);
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1829?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
Gerrit-Change-Number: 1829
Ger=
rit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--RD447l+uEf0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by ordex</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">Correctly calculate packet =
id size when epoch packet format is in use<br><br>The code assumed that alw=
ays when tls mode (without CFB/OFB) is in use<br>that the packet size is 4 =
bytes=2E With epoch packet format is incorrect<br>as that uses 64 bit=2E<br=
><br>Even thought packet_id_long_form has a the same size (8 byte) it is no=
t<br>the same header format (32 bit time + 32 bit IV) as the epoch<br>forma=
t (16 bit epoch + 48 IV)=2E Use a simple sizeof(uint64_t) to<br>avoid sugge=
sting that it might be the same=2E<br><br>Github: closes OpenVPN/openvpn#10=
74<br><br>Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e<br>Signed-of=
f-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Antonio Quartull=
i &lt;antonio@mandelbit=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1829<br>Message-Id: &lt;20260729064158=2E15731-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg37983=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mtu=2Ec<br>1 file ch=
anged, 8 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/29/1829/3</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec</span><br><span>index=
 e5db8ab=2E=2Ef3c2874 100644</span><br><span>--- a/src/openvpn/mtu=2Ec</spa=
n><br><span>+++ b/src/openvpn/mtu=2Ec</span><br><span>@@ -35,6 +35,7 @@</sp=
an><br><span> #include &quot;crypto=2Eh&quot;</span><br><span> </span><br><=
span> #include &quot;memdbg=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;ssl_common=2Eh&quot;</span><br><span> </sp=
an><br><span> /* allocate a buffer for socket or tun layer */</span><br><sp=
an> void</span><br><span>@@ -51,6 +52,13 @@</span><br><span> calc_packet_id=
_size_dc(const struct options *options, const struct key_type *kt)</span><b=
r><span> {</span><br><span>     bool tlsmode =3D options-&gt;tls_server || =
options-&gt;tls_client;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool epoch =3D options-&gt;imported_protocol_flags &amp; CO_EPOCH_D=
ATA_KEY_FORMAT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* epoch format use=
s a 64-bit packet id: 16 bit epoch + 48 bit per-epoch counter */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (epoch)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return sizeof(uint64_t);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><s=
pan>     bool packet_id_long_form =3D !tlsmode || cipher_kt_mode_ofb_cfb(kt=
-&gt;cipher);</span><br><span> </span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Dema=
il">change 1829</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
829?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1829 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--RD447l+uEf0=--


--===============5859727646873115541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5859727646873115541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5859727646873115541==--

