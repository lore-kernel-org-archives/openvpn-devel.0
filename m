Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A07CC53219
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DDtOiOuDOexotyz5ucweuiaJEGpBcfGIH6mMxDdIkbE=; b=HFjTbOJV0z6RU/UP1MGqnOYdpD
	Gd9+wpHNQr3eJ0yo5e4XOgSV8BhPHCEU47MKWG/j3ohU1/JL9/FONKt904mpRqz0Pg9me2aXECwZT
	b/yYoRiTp5I2GX0iNoVIJ6UDEWM8+ss6thWVK3KmRqNw6aITU2qmb6gxa/J786Izdvv8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp7Fp-0003fX-Va;
	Wed, 29 Jul 2026 16:35:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp7Fn-0003f4-0i
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cW/VZTOo9oPJ9LdzFqbrflZTGzhiTPn5ftLhrcA7XJQ=; b=W+12DVemQViFjUTTQFXDU/rk1x
 wOR7VUIuwxbmGf/2436ZfJ7LMH8NIi8iZaP+R8HKCebjgNzqhQrTtOvd8e64kflzZKfNJnIz5+nNG
 WepYEktDgOvdDDrZpQ4G6jWHF3Rwr0ptbCDbmV6zsMVBk8olehClGXernotSel9kjnqA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cW/VZTOo9oPJ9LdzFqbrflZTGzhiTPn5ftLhrcA7XJQ=; b=D
 kV+fy9ZTysfiqvj2Ztp0tCKCmhj71tzu2ru1jmRUMAA5oFcos+e1g00VlP7vbwDQWS2Tmy2ygmEwR
 +QjJk1MIsafQ3cmvBUxslRkzfyFBE7kOCKrzexmcfmXht0LY2ME4dGk3PJhDQ4YDZjlbxRzR8z+6p
 IvL2zWm5KOD/aQPg=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp7FF-0004gx-VK for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 16:35:04 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso6087815e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785342895; x=1785947695; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cW/VZTOo9oPJ9LdzFqbrflZTGzhiTPn5ftLhrcA7XJQ=;
 b=FiRkLQ2/cROsYzPOqoUAofbnTAGcsxbMDc2H5mSDRKkBKYSI2xIP9DZXZ+wbmb5Ivt
 j9fBSpJuV3GdXyDEmL/9dzHI96hKa9iU+w7kDl56MESjRIFb1OyotxLfFtL/14OY6jSJ
 cCx68n2nozQvUX+PtGVQgFChrTGTMfcLTR5gRu6bgmocsv6CnJW9+DEqLsrEqdomQ+OX
 MhYwLTCZEwRZXOsqZb+JJ+lUmnqovev57Pby3s/lMGexFYih/APotkrB1NMo0Oq6PGeP
 wefoD36uoh3zBUhDxkyhN0H3f456mqi7otmRLgiB+jTCu8lIJx072HMw6eArmNxVKy3k
 TqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785342895; x=1785947695;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cW/VZTOo9oPJ9LdzFqbrflZTGzhiTPn5ftLhrcA7XJQ=;
 b=ovI3mYIGm25ZktG98CxXjVxottgI3DB9vITWUZ8kTcurIRFOf7xhdJKQ4G59YjI4SB
 LVy6PEoqBSheRYztCwzxOXbIgwOU6gOPLC2yzOhTohWVks3dOXB0MOGfgTCdfd2NGhOg
 FKgvGgxdLft+h6+6lDVyBJrXIHgucgX0V5JKOoMJ7ui361Pn301XvEpdwddcsL4NHMt3
 BmAghiA4hJOoEwgE2pyjc2h/wP827SgsQF+uFPg/NE+R7wVONVeL2d5dKSZmUW+DKlEh
 Zf6FnW8wx0gAjs7ZnaXWliCktT7ijjPTZGiYolTz2egGCaHmEovsL7NThhCucgVxnSqM
 QHTQ==
X-Gm-Message-State: AOJu0YwShjDI78rt28hMj1yMJ6eeqQMv9o37QfEZK423wIw8FG9Pdq7S
 zrhr1xk8EpNbvNwnqlUKJG2iIFcqe4NNTBnSMD+R9XnYRc3l6DiZTJxTPA38lnGoVkomtVNhr7T
 EJDX8aNbt3GvyxR94+orMycocDxEWLSTeP5xq2fqSK5yPemPg8yzdXO/bylW7Np6WTPwy
X-Gm-Gg: AR+sD12UXTTFW5Ul6iBA2n9lrDHAh/UlnBB2/3IcBmkX/KsuVuuCiuP74gDxlTozu3D
 Ifg+zJwId9GvcBDGqo2ZOR6nXIrv04VkqaiWXb/KVWNhRvXuePiu38pQ37cvt/xuj0xs4FXRFyC
 HlgYTOMyCMs5vYs1FsVbv9rK9fIWTDPFLsLOZSWNA39vp6+hLqD084dWyeit4s0uSywTvxUBhcJ
 d8+M00fEWWPecn8MfQYPdVGFK6a47PluQgOc1XLMcbqRxrIt4Omj77DaR1YTuF883H3jgwEuzAd
 iIkscz9D18I+/lwP/Q1ii8nTASR5aEI+5qSFbgakXUw/v/xmBC+MmJuGfzkjdqFF/riaZqPggNH
 hBfmLq/DFugqdtcID9qDcLEdYy3j6KXK/dnKgJAdAJNA8IEQKNDbZ0loxcs8UnlWWHCrw/YpYfS
 NTYDLNMmcF7oCeL4TriDJ1XQUNQ/aPRhUFPenDRtyfJbg6lCvk3SYyT6rD5Ky+2Fc36y3T4MROo
 42IaxO0z/+Oc3IdEGIaoldqQWntQScuaLZGGd68XudO6vz4BLgndFCeHy6bJ256FDapB6c6tfOQ
 lEX8T3JEzs4z83eMN2gpPKFoSytXmDDS78sRwRjZwc+GPbOINQATGMaVbHGT2Q==
X-Received: by 2002:a05:600c:3547:b0:495:6b78:6f4 with SMTP id
 5b1f17b1804b1-496c6413230mr91125695e9.8.1785342895297; 
 Wed, 29 Jul 2026 09:34:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4976bd7c4c2sm67849285e9.14.2026.07.29.09.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 09:34:54 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 16:34:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
X-Gerrit-Change-Number: 1829
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1829?usp=email>
X-Gerrit-Commit: 2c8baca423b236ab12f7519b68ed88b4a709d0d1
In-Reply-To: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
References: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjY0NDQxMDAwLkk1Yjg2MmVhYmUwMzJlYjRkMjIyOWZmNWIyZjRmNmFmNzQwNmY2ZjRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <242c9fc02e689346d63c86f2a6a0657556fb1b5c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp7FF-0004gx-VK
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
Content-Type: multipart/mixed; boundary="===============0829230650855727397=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0829230650855727397==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Yid799/ur6A="; charset=UTF-8

--Yid799/ur6A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1829?usp=3Demail )

Change subject: Correctly calculate packet id size =
when epoch packet format is in use
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Correctly calculate packet id size when epoch packet=
 format is in use

The code assumed that always when tls mode (without CFB/=
OFB) is in use
that the packet size is 4 bytes=2E With epoch packet format =
is incorrect
as that uses 64 bit=2E

Even thought packet_id_long_form has a=
 the same size (8 byte) it is not
the same header format (32 bit time + 32 =
bit IV) as the epoch
format (16 bit epoch + 48 IV)=2E Use a simple sizeof(u=
int64_t) to
avoid suggesting that it might be the same=2E

Github: closes O=
penVPN/openvpn#1074

Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
S=
igned-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Antonio Quartulli=
 <antonio@mandelbit=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1829
Message-Id: <20260729064158=2E15731-1-gert@greenie=2Emuc=2Ede>
=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg37983=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
--=
-
M src/openvpn/mtu=2Ec
1 file changed, 8 insertions(+), 0 deletions(-)



=

diff --git a/src/openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec
index e5db8ab=2E=2E=
f3c2874 100644
--- a/src/openvpn/mtu=2Ec
+++ b/src/openvpn/mtu=2Ec
@@ -35,6=
 +35,7 @@
 #include "crypto=2Eh"
 
 #include "memdbg=2Eh"
+#include "ssl_co=
mmon=2Eh"
 
 /* allocate a buffer for socket or tun layer */
 void
@@ -51,6=
 +52,13 @@
 calc_packet_id_size_dc(const struct options *options, const str=
uct key_type *kt)
 {
     bool tlsmode =3D options->tls_server || options->=
tls_client;
+    bool epoch =3D options->imported_protocol_flags & CO_EPOCH=
_DATA_KEY_FORMAT;
+
+    /* epoch format uses a 64-bit packet id: 16 bit ep=
och + 48 bit per-epoch counter */
+    if (epoch)
+    {
+        return si=
zeof(uint64_t);
+    }
 
     bool packet_id_long_form =3D !tlsmode || ciph=
er_kt_mode_ofb_cfb(kt->cipher);
 

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1829?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
Gerrit-Change-Number:=
 1829
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>

--Yid799/ur6A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1829?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Correctly calculate packet id size when ep=
och packet format is in use<br><br>The code assumed that always when tls mo=
de (without CFB/OFB) is in use<br>that the packet size is 4 bytes=2E With e=
poch packet format is incorrect<br>as that uses 64 bit=2E<br><br>Even thoug=
ht packet_id_long_form has a the same size (8 byte) it is not<br>the same h=
eader format (32 bit time + 32 bit IV) as the epoch<br>format (16 bit epoch=
 + 48 IV)=2E Use a simple sizeof(uint64_t) to<br>avoid suggesting that it m=
ight be the same=2E<br><br>Github: closes OpenVPN/openvpn#1074<br><br>Chang=
e-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e<br>Signed-off-by: Arne Schw=
abe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@m=
andelbit=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1829<br>Message-Id: &lt;20260729064158=2E15731-1-gert@greenie=2Emuc=2Ede&=
gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg37983=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mtu=2Ec<br>1 file changed, 8 insert=
ions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mtu=2Ec b=
/src/openvpn/mtu=2Ec</span><br><span>index e5db8ab=2E=2Ef3c2874 100644</spa=
n><br><span>--- a/src/openvpn/mtu=2Ec</span><br><span>+++ b/src/openvpn/mtu=
=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> #include &quot;cryp=
to=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
ssl_common=2Eh&quot;</span><br><span> </span><br><span> /* allocate a buffe=
r for socket or tun layer */</span><br><span> void</span><br><span>@@ -51,6=
 +52,13 @@</span><br><span> calc_packet_id_size_dc(const struct options *op=
tions, const struct key_type *kt)</span><br><span> {</span><br><span>     b=
ool tlsmode =3D options-&gt;tls_server || options-&gt;tls_client;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    bool epoch =3D options-&g=
t;imported_protocol_flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* epoch format uses a 64-bit packet id: 16 bit epoc=
h + 48 bit per-epoch counter */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (epoch)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return sizeof(uint64_t);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span> </span><br><span>     bool packet_id_long_form=
 =3D !tlsmode || cipher_kt_mode_ofb_cfb(kt-&gt;cipher);</span><br><span> </=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Demail">change 1829</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I5b862eabe032eb4d2229ff=
5b2f4f6af7406f6f4e </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1829 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;anton=
io@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--Yid799/ur6A=--


--===============0829230650855727397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0829230650855727397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0829230650855727397==--

