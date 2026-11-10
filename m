Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E0C606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=f5AU/BLW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UGuRF7Xx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kQ0lNXRX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DFXioBYW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jPoKmSQ9Tm/z0+yEZx9nZe9q+Wh77fOrXyDnVW2g8dQ=; b=f5AU/BLWuqpG7WdTUhHvghZY++
	/AILWYxWLO94ofTiGPePhhFQDL/pV88TEDedu+ASgk7RRQO6X56CqAqoxlcrHxJSOVzaA4cPssZbq
	KXJ6yy0UW7nRcdTUykGmp/zXxkjH2Blb6Wg7yOAzwpXs3uA2MZfWMJWG9L/MkNl8PRB0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQkvo-000000001KB-3Wnm;
	Tue, 10 Nov 2026 12:26:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQkvG-000000001JK-1GDi
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:25:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eE1a20udyZXqCapAx056eHU/wRUmogb6vXfK+hI6ZMM=; b=UGuRF7XxGooDuHGnE9s7zdj4RX
 0z8tqPRmwyQVpf+FlfwXwII53esjYdDqvWQmYYiKxnSDRntu1wcjAZgiZYEkZ3VCrYA+PcyGbozPW
 g0KTTZs1fn0q6RaQnS2aLbRHICB2o1n4585Rj2J7Q/XmUzWs3Tc7C1jXhdwgnWPiMGYs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eE1a20udyZXqCapAx056eHU/wRUmogb6vXfK+hI6ZMM=; b=kQ0lNXRXIYR1V+QL+lFLo5XG0i
 508n9p3nDOLYeFhr9owT9kmHNoWtEbCTeYOZDrKl20XxR8HY1yWCJK+yHzbsesBu4SPChHpJJZ9Fa
 sMxOxVdxQs0ZxCFduGhf4ILijIgok0LpvX2X/uIupinVKtfuO/PHf5ohWe6MdDlI442Q=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQkvE-000000005bu-2nVZ for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:25:58 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1186526f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 04:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794313550; x=1794918350; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eE1a20udyZXqCapAx056eHU/wRUmogb6vXfK+hI6ZMM=;
 b=DFXioBYWJF9dQfNWPcMdMMIiLVmiRCbXT1sidlol8buNaQuGzdYd4y48/3gX0hfttI
 8nf46kXOOoxU+l1HTQdCUxxaVcOtBMOVB6sgT/1ZfE4m5QFnviT11OIbVHN47tDhsFEl
 F653aflQyqYIe2p3dSSWjxFHd63TVQzQOTyiTceCh388hMSJErUqGa1/gtVZiex0tEkU
 vxlx6PhR2m6Sd8UcQC/o3cWI7fvhzo6MELDMMHxNBjD1MaoabPZynR04p/EF9d1YZdua
 jpLpkIgRG2fKjZzU69S66NOIlWDVC0FbPJrkCOaR/xqBbFvojTPIzbr+dRki2/qcXAgM
 F8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313550; x=1794918350;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eE1a20udyZXqCapAx056eHU/wRUmogb6vXfK+hI6ZMM=;
 b=x3BjYoedPofMz9yO3StqtfPVrpBKdKNV6x3V9pGI/hq8gOYkSprCOkhMoBddRJVShL
 VCKqCT5T28q+ncQ0Z5M7UaCTw6eDVxoUkcJ0jTLlCLhzqUn1temdvTt4Vk3xajz6IlnQ
 sos9cVpXoDqrY15B/Mb93yvnin25dCGZ7n/RAXfO38/FyRbjcOXEyVq3+YWhao8VCXeH
 2rftRi7OajP3Tubcbiq4GGX0k4zoverAaup9aNhV35O01tqcIWTqA6XODPkZtFaaKIKs
 j511aLrxhZFakXiAr0pupwV3C57pJRV68J1/JijVrEnlsIfTf6ZDt2oaBeqIhUDTcpHk
 WLMg==
X-Gm-Message-State: APuU4Z8GpX3Rg9UHpyIpfe/B2E1YcB+2uSwIXdKG/odyB5w/5KyfNom6
 pJja3JMcMK6ETom47z9JwImq904socPBMKo3Ngka8Gwe68OffzFqOY6p39+yhjqzNjbkfHr9dCj
 IjPgeEmYbFQiCHkx38QkGZ2A29nyKMzPaZJgelUgM9RM0SRvgvYABwDjJq0fAi3IX24k5
X-Gm-Gg: AYBFou3F+w5msdbY9U6fx1Y8SsCUaLTID6riwkmWmC3M/1ZpGE91F6MV3KwbEEXGULZ
 7kwzkAvQzHlnFYpl6Uaw/FiEFwQmjuFK31BN+6W4tvXtYV3uPlpy/vBj7yufq8lONaaVptMwQUT
 3mS8+bEus9PichhDDNrAeIvXsq0r4gotkffvNfVp6+fH3rAUFVJBr4WRX++gJhG+ZNHdhmzEBnG
 plImQHy3V0JaLXDjuFpDd+5zS57yQiUg0MJxYemHdpTKsVuh1zKLPjjkLCqgW+IUErvSDHLJeJ6
 eJCMxECNyKa0Zc57lUXJe9tVlC5+kYIY1PhYlw1lmWLwqXGD0jJIsYo8MMUWvGafpa/Qed368oo
 hzScr0AsmODed1E27GXYugoxubASv3GP+07pXSvvT03fPBWdHq+90C5uXW5Ft7wIvTV4JEKo1jW
 xf7Ghb5uDboZYGSspS3kZRxIdM4StgX9Fmsl5IiXk7S0+P5OI3LXMtLN0Lm5S7k/PDODti4to7Y
 IuqUBxHI9MFffBV2wu3lrNzAgw7GduMD9aoYkHWnJu8jHMAFZTS9AlDOYOoRAtMAGA9/geZeliT
 Pxu/9ZCrp9bcTpf/9bcnly09OlPH8GzOoNpxBw+kbv8I8Ejd8MlswxhdemecDNBSZs883J4Qh//
 PiiAEAvEolUi2RmQ49KaGqM12yEAllZEECuoZjTVd6hPYVczIkyO1LbS9fKPwr22jXSgqKnRk1j
 2EK6bS0Yb39uFLksE=
X-Received: by 2002:a05:6000:29c9:b0:491:6c24:65f5 with SMTP id
 ffacd0b85a97d-4982f2b4ba6mr3148697f8f.17.1794313549850; 
 Tue, 10 Nov 2026 04:25:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983585c5b9sm4684788f8f.9.2026.11.10.04.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:25:49 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 12:25:46 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: b1d16692afbcdf6728ef30b156274f378696b554
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4cf6934ea361e378f2647d3311bd014c0c226ea2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQkvE-000000005bu-2nVZ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto*: Avoid sign
 conversion warnings by using defines directly
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3873137586924321833=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3873137586924321833==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZsfNFjxOOb0="; charset=UTF-8

--ZsfNFjxOOb0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2158?usp=3Demail

to look at the new patch set (#3)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review-1 by R=C4=83z=
van Cojocaru


Change subject: crypto*: Avoid sign conversion warnings by u=
sing defines directly
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

crypto*: Avoid sign conversion warnings by using defines directl=
y

Using the defines directly avoids the issue with sign
conversion by lett=
ing the compiler deduce the types of
the literals=2E

I do not think that u=
sing an intermediate variable
increases the readability=2E

Change-Id: I3bc=
b4cb8e17ff80a5cb8acdaf18d1072159184e5
Signed-off-by: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
---
M src/openvpn/crypto=2Ec
M src/openvpn/crypto_epo=
ch=2Ec
M src/openvpn/packet_id=2Eh
M src/openvpn/tls_crypt=2Ec
M src/openvp=
n/tls_crypt=2Eh
M tests/unit_tests/openvpn/test_tls_crypt=2Ec
6 files chang=
ed, 24 insertions(+), 41 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/58/2158/3

diff --git a/src/openvpn/crypt=
o=2Ec b/src/openvpn/crypto=2Ec
index a4c2683=2E=2E6955760 100644
--- a/src/=
openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -81,7 +81,6 @@
 
     co=
nst struct key_ctx *ctx =3D &opt->key_ctx_bi=2Eencrypt;
     uint8_t *mac_o=
ut =3D NULL;
-    const int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;
 
     /* =
IV, packet-ID and implicit IV required for this mode=2E */
     ASSERT(ctx-=
>cipher);
@@ -142,7 +141,7 @@
     dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s=
", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     /* Buffer overflow c=
heck */
-    if (!buf_safe(&work, buf->len + mac_len + cipher_ctx_block_siz=
e(ctx->cipher)))
+    if (!buf_safe(&work, BLENZ(buf) + OPENVPN_AEAD_TAG_LE=
NGTH + cipher_ctx_block_size(ctx->cipher)))
     {
         msg(D_CRYPT_ERR=
ORS, "ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d w=
l=3D%d",
             buf->capacity, buf->offset, buf->len, work=2Ecapacity=
, work=2Eoffset, work=2Elen);
@@ -156,7 +155,7 @@
     if (!use_epoch_data_=
format)
     {
         /* Reserve space for authentication tag */
-       =
 mac_out =3D buf_write_alloc(&work, mac_len);
+        mac_out =3D buf_writ=
e_alloc(&work, OPENVPN_AEAD_TAG_LENGTH);
         ASSERT(mac_out);
     }
 =

@@ -177,12 +176,12 @@
     if (use_epoch_data_format)
     {
         /* R=
eserve space for authentication tag */
-        mac_out =3D buf_write_alloc=
(&work, mac_len);
+        mac_out =3D buf_write_alloc(&work, OPENVPN_AEAD_=
TAG_LENGTH);
         ASSERT(mac_out);
     }
 
     /* Write authenticatio=
n tag */
-    ASSERT(cipher_ctx_get_tag(ctx->cipher, mac_out, mac_len));
+ =
   ASSERT(cipher_ctx_get_tag(ctx->cipher, mac_out, OPENVPN_AEAD_TAG_LENGTH)=
);
 
     *buf =3D work;
 
@@ -453,9 +452,6 @@
         CRYPT_DROP("Decrypt=
ion failed verification limit reached=2E");
     }
 
-    const int tag_siz=
e =3D OPENVPN_AEAD_TAG_LENGTH;
-
-
     ASSERT(frame);
     ASSERT(buf->len=
 > 0);
     ASSERT(ctx->cipher);
@@ -470,14 +466,14 @@
     ASSERT(packet_i=
d_initialized(&opt->packet_id));
 
     /* Ensure that the packet size is l=
ong enough */
-    int min_packet_len =3D packet_id_size(false) + tag_size =
+ 1;
+    size_t min_packet_len =3D packet_id_size(false) + OPENVPN_AEAD_TA=
G_LENGTH + 1;
 
     if (use_epoch_data_format)
     {
         min_packet_=
len +=3D sizeof(uint32_t);
     }
 
-    if (buf->len < min_packet_len)
+  =
  if (BLENZ(buf) < min_packet_len)
     {
         CRYPT_ERROR("missing IV =
info, missing tag or no payload");
     }
@@ -540,24 +536,24 @@
         }
=
     }
 
-    const int ad_size =3D (int)(BPTR(buf) - ad_start);
+    const=
 uintptr_t ad_size =3D (uintptr_t)(BPTR(buf) - ad_start);
 
     uint8_t *t=
ag_ptr =3D NULL;
     int data_len =3D 0;
 
     if (use_epoch_data_format)=

     {
-        data_len =3D BLEN(buf) - tag_size;
+        data_len =3D B=
LEN(buf) - OPENVPN_AEAD_TAG_LENGTH;
         tag_ptr =3D BPTR(buf) + data_l=
en;
     }
     else
     {
         tag_ptr =3D BPTR(buf);
-        ASSERT=
(buf_advance(buf, tag_size));
+        ASSERT(buf_advance(buf, OPENVPN_AEAD=
_TAG_LENGTH));
         data_len =3D BLEN(buf);
     }
 
-    dmsg(D_PACKET=
_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_size, 0, &gc));
+    d=
msg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, OPENVPN_AEAD_T=
AG_LENGTH, 0, &gc));
     dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format=
_hex(BPTR(buf), BLENZ(buf), 0, &gc));
 
     /* Buffer overflow check (shou=
ld never fail) */
@@ -567,7 +563,7 @@
     }
 
     /* feed in tag and the =
authenticated data */
-    ASSERT(cipher_ctx_update_ad(ctx->cipher, ad_star=
t, ad_size));
+    ASSERT(cipher_ctx_update_ad(ctx->cipher, ad_start, (int)=
ad_size));
     dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s", format_hex(ad_star=
t, ad_size, 0, &gc));
 
     /* Decrypt and authenticate packet */
@@ -578,=
7 +574,7 @@
     }
 
     ASSERT(buf_inc_len(&work, outlen));
-    if (!cip=
her_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outlen, &outlen, tag_ptr=
, tag_size))
+    if (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) =
+ outlen, &outlen, tag_ptr, OPENVPN_AEAD_TAG_LENGTH))
     {
         ctx->=
failed_verifications++;
         CRYPT_DROP("packet tag authentication fail=
ed");
@@ -1118,20 +1114,19 @@
 static void
 generate_key_random(struct key =
*key)
 {
-    int cipher_len =3D MAX_CIPHER_KEY_LENGTH;
-    int hmac_len =
=3D MAX_HMAC_KEY_LENGTH;
-
     struct gc_arena gc =3D gc_new();
 
     CLE=
AR(*key);
-    if (!rand_bytes(key->cipher, cipher_len) || !rand_bytes(key-=
>hmac, hmac_len))
+    if (!rand_bytes(key->cipher, MAX_CIPHER_KEY_LENGTH)
=
+        || !rand_bytes(key->hmac, MAX_HMAC_KEY_LENGTH))
     {
         ms=
g(M_FATAL, "ERROR: Random number generator cannot obtain entropy for key ge=
neration");
     }
 
     dmsg(D_SHOW_KEY_SOURCE, "Cipher source entropy: %=
s",
-         format_hex(key->cipher, cipher_len, 0, &gc));
-    dmsg(D_SHO=
W_KEY_SOURCE, "HMAC source entropy: %s", format_hex(key->hmac, hmac_len, 0,=
 &gc));
+         format_hex(key->cipher, MAX_CIPHER_KEY_LENGTH, 0, &gc));
=
+    dmsg(D_SHOW_KEY_SOURCE, "HMAC source entropy: %s",
+         format_he=
x(key->hmac, MAX_HMAC_KEY_LENGTH, 0, &gc));
 
     gc_free(&gc);
 }
diff --=
git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
index 243=
b5a2=2E=2Ee0fc099 100644
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src/openv=
pn/crypto_epoch=2Ec
@@ -51,26 +51,23 @@
     hmac_ctx_init(hmac_ctx, secret=
, "SHA256");
 
     ASSERT(info_len <=3D INT_MAX);
-    const unsigned int =
digest_size =3D SHA256_DIGEST_LENGTH;
 
     /* T(0) =3D empty string */
  =
   uint8_t t_prev[SHA256_DIGEST_LENGTH];
-    unsigned int t_prev_len =3D 0=
;
 
-    for (uint8_t block =3D 1; (block - 1) * digest_size < out_len; blo=
ck++)
+    for (uint8_t block =3D 1; (block - 1u) * SHA256_DIGEST_LENGTH < =
out_len; block++)
     {
         hmac_ctx_reset(hmac_ctx);
 
         /* c=
alculate T(block) */
-        hmac_ctx_update(hmac_ctx, t_prev, t_prev_len)=
;
+        hmac_ctx_update(hmac_ctx, t_prev, block =3D=3D 1 ? 0 : SHA256_DI=
GEST_LENGTH);
         hmac_ctx_update(hmac_ctx, info, (int)info_len);
    =
     hmac_ctx_update(hmac_ctx, &block, 1);
         hmac_ctx_final(hmac_ctx=
, t_prev);
-        t_prev_len =3D digest_size;
 
         /* Copy a full h=
mac output or remaining bytes */
-        size_t out_offset =3D (block - 1)=
 * digest_size;
-        size_t copylen =3D min_size(digest_size, out_len -=
 out_offset);
+        size_t out_offset =3D (block - 1u) * SHA256_DIGEST_L=
ENGTH;
+        size_t copylen =3D min_size(SHA256_DIGEST_LENGTH, out_len -=
 out_offset);
 
         memcpy(out + out_offset, t_prev, copylen);
     }
=
diff --git a/src/openvpn/packet_id=2Eh b/src/openvpn/packet_id=2Eh
index 48=
752d3=2E=2E782dd58 100644
--- a/src/openvpn/packet_id=2Eh
+++ b/src/openvpn=
/packet_id=2Eh
@@ -312,7 +312,7 @@
 const char *packet_id_net_print(const s=
truct packet_id_net *pin, bool print_timestamp,
                           =
      struct gc_arena *gc);
 
-static inline int
+static inline unsigned in=
t
 packet_id_size(bool long_form)
 {
     return sizeof(packet_id_type) + (=
long_form ? sizeof(net_time_t) : 0);
diff --git a/src/openvpn/tls_crypt=2Ec=
 b/src/openvpn/tls_crypt=2Ec
index 2dadc4f=2E=2E7eb83ce 100644
--- a/src/op=
envpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -52,7 +52,7 @@
     =
return create_kt("AES-256-CTR", "SHA256", "tls-crypt");
 }
 
-int
+unsigned=
 int
 tls_crypt_buf_overhead(void)
 {
     return packet_id_size(true) + TL=
S_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_SIZE;
diff --git a/src/openvpn/tls_crypt=
=2Eh b/src/openvpn/tls_crypt=2Eh
index d179cbb=2E=2E8e5567f 100644
--- a/sr=
c/openvpn/tls_crypt=2Eh
+++ b/src/openvpn/tls_crypt=2Eh
@@ -130,7 +130,7 @@=

  * Returns the maximum overhead (in bytes) added to the destination buffe=
r by
  * tls_crypt_wrap()=2E
  */
-int tls_crypt_buf_overhead(void);
+unsig=
ned int tls_crypt_buf_overhead(void);
 
 /**
  * Wrap a control channel pac=
ket (both authenticates and encrypts the data)=2E
diff --git a/tests/unit_t=
ests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec
index 2d31c00=2E=2E00de73a 100644
--- a/tests/unit_tests/openvpn/test_=
tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
@@ -232,11 =
+232,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma=
 GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#=
endif
-
 /**
  * Check that short messages are successfully wrapped-and-unw=
rapped=2E
  */
@@ -778,10 +773,6 @@
     tls_wrap_free(&wrap_ctx);
 }
 
-#i=
f defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#end=
if
-
 static void
 test_tls_crypt_v2_write_server_key_file(void **state)
 {=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3bcb4cb8e17ff=
80a5cb8acdaf18d1072159184e5
Gerrit-Change-Number: 2158
Gerrit-PatchSet: 3
G=
errit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--ZsfNFjxOOb0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #3</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/215=
8?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">cry=
pto*: Avoid sign conversion warnings by using defines directly<br><br>Using=
 the defines directly avoids the issue with sign<br>conversion by letting t=
he compiler deduce the types of<br>the literals=2E<br><br>I do not think th=
at using an intermediate variable<br>increases the readability=2E<br><br>Ch=
ange-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/crypto=
=2Ec<br>M src/openvpn/crypto_epoch=2Ec<br>M src/openvpn/packet_id=2Eh<br>M =
src/openvpn/tls_crypt=2Ec<br>M src/openvpn/tls_crypt=2Eh<br>M tests/unit_te=
sts/openvpn/test_tls_crypt=2Ec<br>6 files changed, 24 insertions(+), 41 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/58/2158/3</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypt=
o=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index a4c2683=2E=2E6955760 1=
00644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/sr=
c/openvpn/crypto=2Ec</span><br><span>@@ -81,7 +81,6 @@</span><br><span> </s=
pan><br><span>     const struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi=2E=
encrypt;</span><br><span>     uint8_t *mac_out =3D NULL;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    const int mac_len =3D OPENVPN_AEAD_T=
AG_LENGTH;</span><br><span> </span><br><span>     /* IV, packet-ID and impl=
icit IV required for this mode=2E */</span><br><span>     ASSERT(ctx-&gt;ci=
pher);</span><br><span>@@ -142,7 +141,7 @@</span><br><span>     dmsg(D_PACK=
ET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf),=
 80, &amp;gc));</span><br><span> </span><br><span>     /* Buffer overflow c=
heck */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!buf_s=
afe(&amp;work, buf-&gt;len + mac_len + cipher_ctx_block_size(ctx-&gt;cipher=
)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_saf=
e(&amp;work, BLENZ(buf) + OPENVPN_AEAD_TAG_LENGTH + cipher_ctx_block_size(c=
tx-&gt;cipher)))</span><br><span>     {</span><br><span>         msg(D_CRYP=
T_ERRORS, &quot;ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d=
 wo=3D%d wl=3D%d&quot;,</span><br><span>             buf-&gt;capacity, buf-=
&gt;offset, buf-&gt;len, work=2Ecapacity, work=2Eoffset, work=2Elen);</span=
><br><span>@@ -156,7 +155,7 @@</span><br><span>     if (!use_epoch_data_for=
mat)</span><br><span>     {</span><br><span>         /* Reserve space for a=
uthentication tag */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       mac_out =3D buf_write_alloc(&amp;work, mac_len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        mac_out =3D buf_write_alloc(&am=
p;work, OPENVPN_AEAD_TAG_LENGTH);</span><br><span>         ASSERT(mac_out);=
</span><br><span>     }</span><br><span> </span><br><span>@@ -177,12 +176,1=
2 @@</span><br><span>     if (use_epoch_data_format)</span><br><span>     {=
</span><br><span>         /* Reserve space for authentication tag */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        mac_out =3D buf_writ=
e_alloc(&amp;work, mac_len);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        mac_out =3D buf_write_alloc(&amp;work, OPENVPN_AEAD_TAG_LE=
NGTH);</span><br><span>         ASSERT(mac_out);</span><br><span>     }</sp=
an><br><span> </span><br><span>     /* Write authentication tag */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(cipher_ctx_get_tag(=
ctx-&gt;cipher, mac_out, mac_len));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ASSERT(cipher_ctx_get_tag(ctx-&gt;cipher, mac_out, OPEN=
VPN_AEAD_TAG_LENGTH));</span><br><span> </span><br><span>     *buf =3D work=
;</span><br><span> </span><br><span>@@ -453,9 +452,6 @@</span><br><span>   =
      CRYPT_DROP(&quot;Decryption failed verification limit reached=2E&quot=
;);</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(frame);</span>=
<br><span>     ASSERT(buf-&gt;len &gt; 0);</span><br><span>     ASSERT(ctx-=
&gt;cipher);</span><br><span>@@ -470,14 +466,14 @@</span><br><span>     ASS=
ERT(packet_id_initialized(&amp;opt-&gt;packet_id));</span><br><span> </span=
><br><span>     /* Ensure that the packet size is long enough */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int min_packet_len =3D packe=
t_id_size(false) + tag_size + 1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    size_t min_packet_len =3D packet_id_size(false) + OPENVPN_=
AEAD_TAG_LENGTH + 1;</span><br><span> </span><br><span>     if (use_epoch_d=
ata_format)</span><br><span>     {</span><br><span>         min_packet_len =
+=3D sizeof(uint32_t);</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt; min_pack=
et_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLEN=
Z(buf) &lt; min_packet_len)</span><br><span>     {</span><br><span>        =
 CRYPT_ERROR(&quot;missing IV info, missing tag or no payload&quot;);</span=
><br><span>     }</span><br><span>@@ -540,24 +536,24 @@</span><br><span>   =
      }</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    const int ad_size =3D (int)(BPTR(buf) - ad_s=
tart);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uin=
tptr_t ad_size =3D (uintptr_t)(BPTR(buf) - ad_start);</span><br><span> </sp=
an><br><span>     uint8_t *tag_ptr =3D NULL;</span><br><span>     int data_=
len =3D 0;</span><br><span> </span><br><span>     if (use_epoch_data_format=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        data_len =3D BLEN(buf) - tag_size;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        data_len =3D BLEN(buf) - OPENVPN_AEAD_TAG=
_LENGTH;</span><br><span>         tag_ptr =3D BPTR(buf) + data_len;</span><=
br><span>     }</span><br><span>     else</span><br><span>     {</span><br>=
<span>         tag_ptr =3D BPTR(buf);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        ASSERT(buf_advance(buf, tag_size));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(buf_advance(buf, OPE=
NVPN_AEAD_TAG_LENGTH));</span><br><span>         data_len =3D BLEN(buf);</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;DECRYPT MAC: %s&quot;, fo=
rmat_hex(tag_ptr, tag_size, 0, &amp;gc));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;DECRYPT MAC: %s&quot=
;, format_hex(tag_ptr, OPENVPN_AEAD_TAG_LENGTH, 0, &amp;gc));</span><br><sp=
an>     dmsg(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPT=
R(buf), BLENZ(buf), 0, &amp;gc));</span><br><span> </span><br><span>     /*=
 Buffer overflow check (should never fail) */</span><br><span>@@ -567,7 +56=
3,7 @@</span><br><span>     }</span><br><span> </span><br><span>     /* fee=
d in tag and the authenticated data */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ASSERT(cipher_ctx_update_ad(ctx-&gt;cipher, ad_start, =
ad_size));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSER=
T(cipher_ctx_update_ad(ctx-&gt;cipher, ad_start, (int)ad_size));</span><br>=
<span>     dmsg(D_PACKET_CONTENT, &quot;DECRYPT AD: %s&quot;, format_hex(ad=
_start, ad_size, 0, &amp;gc));</span><br><span> </span><br><span>     /* De=
crypt and authenticate packet */</span><br><span>@@ -578,7 +574,7 @@</span>=
<br><span>     }</span><br><span> </span><br><span>     ASSERT(buf_inc_len(=
&amp;work, outlen));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (!cipher_ctx_final_check_tag(ctx-&gt;cipher, BPTR(&amp;work) + outlen=
, &amp;outlen, tag_ptr, tag_size))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!cipher_ctx_final_check_tag(ctx-&gt;cipher, BPTR(&am=
p;work) + outlen, &amp;outlen, tag_ptr, OPENVPN_AEAD_TAG_LENGTH))</span><br=
><span>     {</span><br><span>         ctx-&gt;failed_verifications++;</spa=
n><br><span>         CRYPT_DROP(&quot;packet tag authentication failed&quot=
;);</span><br><span>@@ -1118,20 +1114,19 @@</span><br><span> static void</s=
pan><br><span> generate_key_random(struct key *key)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int cipher_len =3D MAX=
_CIPHER_KEY_LENGTH;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int hmac_len =3D MAX_HMAC_KEY_LENGTH;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span>     struct gc_arena gc =3D gc_new();</s=
pan><br><span> </span><br><span>     CLEAR(*key);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (!rand_bytes(key-&gt;cipher, cipher_len)=
 || !rand_bytes(key-&gt;hmac, hmac_len))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!rand_bytes(key-&gt;cipher, MAX_CIPHER_KEY_LEN=
GTH)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || !ran=
d_bytes(key-&gt;hmac, MAX_HMAC_KEY_LENGTH))</span><br><span>     {</span><b=
r><span>         msg(M_FATAL, &quot;ERROR: Random number generator cannot o=
btain entropy for key generation&quot;);</span><br><span>     }</span><br><=
span> </span><br><span>     dmsg(D_SHOW_KEY_SOURCE, &quot;Cipher source ent=
ropy: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   format_hex(key-&gt;cipher, cipher_len, 0, &amp;gc));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_SHOW_KEY_SOURCE, &quot;HMAC so=
urce entropy: %s&quot;, format_hex(key-&gt;hmac, hmac_len, 0, &amp;gc));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         format_hex(ke=
y-&gt;cipher, MAX_CIPHER_KEY_LENGTH, 0, &amp;gc));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    dmsg(D_SHOW_KEY_SOURCE, &quot;HMAC sourc=
e entropy: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+         format_hex(key-&gt;hmac, MAX_HMAC_KEY_LENGTH, 0, &amp;gc));</span=
><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span> }</spa=
n><br><span>diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_=
epoch=2Ec</span><br><span>index 243b5a2=2E=2Ee0fc099 100644</span><br><span=
>--- a/src/openvpn/crypto_epoch=2Ec</span><br><span>+++ b/src/openvpn/crypt=
o_epoch=2Ec</span><br><span>@@ -51,26 +51,23 @@</span><br><span>     hmac_c=
tx_init(hmac_ctx, secret, &quot;SHA256&quot;);</span><br><span> </span><br>=
<span>     ASSERT(info_len &lt;=3D INT_MAX);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    const unsigned int digest_size =3D SHA256_DIGEST=
_LENGTH;</span><br><span> </span><br><span>     /* T(0) =3D empty string */=
</span><br><span>     uint8_t t_prev[SHA256_DIGEST_LENGTH];</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    unsigned int t_prev_len =3D 0;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fo=
r (uint8_t block =3D 1; (block - 1) * digest_size &lt; out_len; block++)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (uint8_t block=
 =3D 1; (block - 1u) * SHA256_DIGEST_LENGTH &lt; out_len; block++)</span><b=
r><span>     {</span><br><span>         hmac_ctx_reset(hmac_ctx);</span><br=
><span> </span><br><span>         /* calculate T(block) */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        hmac_ctx_update(hmac_ctx, t_pr=
ev, t_prev_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     hmac_ctx_update(hmac_ctx, t_prev, block =3D=3D 1 ? 0 : SHA256_DIGEST_L=
ENGTH);</span><br><span>         hmac_ctx_update(hmac_ctx, info, (int)info_=
len);</span><br><span>         hmac_ctx_update(hmac_ctx, &amp;block, 1);</s=
pan><br><span>         hmac_ctx_final(hmac_ctx, t_prev);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        t_prev_len =3D digest_size;</spa=
n><br><span> </span><br><span>         /* Copy a full hmac output or remain=
ing bytes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
ize_t out_offset =3D (block - 1) * digest_size;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        size_t copylen =3D min_size(digest_size, =
out_len - out_offset);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        size_t out_offset =3D (block - 1u) * SHA256_DIGEST_LENGTH;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t copylen =
=3D min_size(SHA256_DIGEST_LENGTH, out_len - out_offset);</span><br><span> =
</span><br><span>         memcpy(out + out_offset, t_prev, copylen);</span>=
<br><span>     }</span><br><span>diff --git a/src/openvpn/packet_id=2Eh b/s=
rc/openvpn/packet_id=2Eh</span><br><span>index 48752d3=2E=2E782dd58 100644<=
/span><br><span>--- a/src/openvpn/packet_id=2Eh</span><br><span>+++ b/src/o=
penvpn/packet_id=2Eh</span><br><span>@@ -312,7 +312,7 @@</span><br><span> c=
onst char *packet_id_net_print(const struct packet_id_net *pin, bool print_=
timestamp,</span><br><span>                                 struct gc_arena=
 *gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-static inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static inline unsigned int</span><br><span> packet_id_size(bool long_form)=
</span><br><span> {</span><br><span>     return sizeof(packet_id_type) + (l=
ong_form ? sizeof(net_time_t) : 0);</span><br><span>diff --git a/src/openvp=
n/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index 2dadc4f=
=2E=2E7eb83ce 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span>=
<br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -52,7 +52,7 @@=
</span><br><span>     return create_kt(&quot;AES-256-CTR&quot;, &quot;SHA25=
6&quot;, &quot;tls-crypt&quot;);</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><span> tls_crypt_b=
uf_overhead(void)</span><br><span> {</span><br><span>     return packet_id_=
size(true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_SIZE;</span><br><span>dif=
f --git a/src/openvpn/tls_crypt=2Eh b/src/openvpn/tls_crypt=2Eh</span><br><=
span>index d179cbb=2E=2E8e5567f 100644</span><br><span>--- a/src/openvpn/tl=
s_crypt=2Eh</span><br><span>+++ b/src/openvpn/tls_crypt=2Eh</span><br><span=
>@@ -130,7 +130,7 @@</span><br><span>  * Returns the maximum overhead (in b=
ytes) added to the destination buffer by</span><br><span>  * tls_crypt_wrap=
()=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-int tls_crypt_buf_overhead(void);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+unsigned int tls_crypt_buf_overhead(void);</span><br><sp=
an> </span><br><span> /**</span><br><span>  * Wrap a control channel packet=
 (both authenticates and encrypts the data)=2E</span><br><span>diff --git a=
/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/tes=
t_tls_crypt=2Ec</span><br><span>index 2d31c00=2E=2E00de73a 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>@@ -232,11 =
+232,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Check th=
at short messages are successfully wrapped-and-unwrapped=2E</span><br><span=
>  */</span><br><span>@@ -778,10 +773,6 @@</span><br><span>     tls_wrap_fr=
ee(&amp;wrap_ctx);</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void=
</span><br><span> test_tls_crypt_v2_write_server_key_file(void **state)</sp=
an><br><span> {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail">change 2158</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3bcb4cb8e17ff80=
a5cb8acdaf18d1072159184e5 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2158 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>=

<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--ZsfNFjxOOb0=--


--===============3873137586924321833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3873137586924321833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3873137586924321833==--

