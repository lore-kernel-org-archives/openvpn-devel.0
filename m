Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4EB606A887
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AzXQPStj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MfreLP/M;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SNNY8EHe;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=R399GKf+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fspVYSeyxIWKJruS7vRC8RlZHLsSNM2lQjZWSFDTvKE=; b=AzXQPStjXE1aEjiAOScnF2yeZc
	pR15dezFjD995+/LszUaZ0mFecGWgk0SSBi50qZg6z+wCuR8Ze/RgvcB2CJAlqdK0a8DpWtWxzPeh
	JC8m2Wh+89tlFwd2C1b7WfiquPYNP6Pu0hTK5LqQ02wzcJXP1X7Rn7/+DEuF49/9aPJw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRzdw-000000001jH-2FEN;
	Fri, 13 Nov 2026 22:21:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRzdu-000000001j8-1wO7
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:21:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5o3ILdxH2p8fQFu799PCu/kqFiToaL1jZDRUqDCZA0Y=; b=MfreLP/M3aCsNoI18zA5HK/0QM
 cyUv/AprMdwBRazBN8DN1nGS9SyUTVkNXF+1aVafbv76vWjadTaZrZUm56GH7zwsf6kwWtnVmgycw
 br2RsPk8+UZHUMQSq2Ozm59jTUd/28ck35mTVF0sXfYqP5OD73ESmkuZtCg6dBcTSFwk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5o3ILdxH2p8fQFu799PCu/kqFiToaL1jZDRUqDCZA0Y=; b=SNNY8EHe6jb9fyn6oCO5/jSl7G
 Mghfj9Oz/bCO36EDCz8ONiPvyY0B8+GuHxLpbdnwjqtc+G08zsfufKFJJzO7d3rxMNnabCUK/G+Bi
 x7QnP9TPB1dC6FDD8h3GW9aZYGG6ZJ64+9vNIuEUop8QOx0ErMScWUUNxw5W0LWYcpNc=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRzds-000000006PI-1Kzd for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:21:10 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so19661865e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 14:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794608462; x=1795213262; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5o3ILdxH2p8fQFu799PCu/kqFiToaL1jZDRUqDCZA0Y=;
 b=R399GKf+SYzhy5U/yWI15NzaLJ6DwS8I/XSJnVYzXYSm9oVyYXhS0PRqwXkPgCDin5
 HRU0IV0bH34tysaO3oYqb9H0dUJyizurLuw0Nnt2VV+hyXWtr60d7bodlx0hvDeZSgGO
 mvVk7DcFLXjRB61TJHALr4kglr0UCg8CuXXNDPPEN3t0oTM61xn6a1evjenYEAVf2x1g
 qQfPQfa+JCZyZf5PkcsO/qkXkw9+4YEPBJAnQ8KMLPfegZTJQGT2l2Jt2L5VRSygNNZj
 NlVSjw6uip4SxfCwwJ1GoU3+1fLL4xvopllfx6zAEhhnoUebpQ//W+O57bU5qs6h/mB2
 UJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794608462; x=1795213262;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5o3ILdxH2p8fQFu799PCu/kqFiToaL1jZDRUqDCZA0Y=;
 b=lzlPXqamP2GZ7h7+aIKk4jt0er3qmRGDMeLVe1wsVmci3SU68b5vD2A6E1Eg+W1JTx
 Q99qW3sRgI+6UpfLoboJQwgU7H2mV37YYzBo59HIpXonWtdKv7k66DpfE4Z7/+YL225s
 trRJsWqx+h+du7l18lC0Y+6BbbqsEtlZS1f9WoXE0X469Pn8M7v3YmQryteausEPOgGW
 ukfcRH8hf4gBNUZ8MSfv1ryN63gt2rdfvTSGtbdJ9noy0vKI84+JKFbeOLIqknXFGXh9
 RpNkweqFgfoTmMN55mXMomhJDC8jcKxifqrCrkwRve9wyxBgIypErw/pROvyqDjZGnhA
 Lzlw==
X-Gm-Message-State: APuU4Z8pU/kRCHMM1ZWDd0ruLo/85e5/MW7sW8hNJCPHu9GpKmJcW+4A
 aIr2MVl9N01QI+vU0Kypnq+nwnxCgu2exor9NcEqtWv0+VhaoDDsWfLkCO/mPVrfCS1dzFA5ty3
 wy/YgPfKGtjny4CavTA8/p+wauv1NkaGpQV+IHZpqjRgOn4me2HNh32ItleKjTbCRfEvu
X-Gm-Gg: AYBFou0Zi21ZahWRVHL24hfVJqESXoQfxtJal1JJ+RV7zJ6tufcOMG9krm/ufasj4LW
 1W5iuhltLIHOjrTEQMjbsdMpZH94df7sUsEdL4fH0gnvHa80wKEVAQjnbzZ8eBl3xgB3ApydlBN
 uDLOoX8w9KzxLF1ZYmGEnk/sp9slA4NBHabZ6gmj4fsGGuHgg/cl51FkA9YTbYHA8FuQkZcG39Z
 fQIIb7muuAK4rqhDaee0tfliHjem8UKFbh3wwDANNjUdp09T4DT2ZCIUimcxrerJax85tYune5k
 y2YXOIDXzv+Uv8+RRlfVcEKu9wHEEWRpPOMnDzEnw9kZKizhzJIKN+OaOGTvXIOhqCaxRGdfEEa
 ImVKtkGrjT+rOvcuXJCyyFqOyP4naf88l0xWBfDgS0F8AV/7/OUjNHNYWufrE/ph7IPkyCTxndM
 TMumvlm1uFo/TocsHc9E+rgNYEzopXRJ0+GR9e/I8IhCj6Q3ZppNY5lOm0i2QT1UEKC90++09DS
 kY2e7//VB+bDSBWNmz5A6eZ8GDRU0eFElGcBNLv5Mve+eAar4tJeGp7V5VzijEPkLxtrkarpdZq
 2Mpso/8nin2utTwSu+ZJS9nks37wForfPQzEtq0wZwlqCEozdrSjaMxXOqmEmshcNP0T6CHJIzc
 Tk9rn4xCnr4NeHWhzFXbs+qtzhuLKrnzZ6ELnPYcbnQVEEsIVZgtDc5hP+xUE7gDuSJ4/3YCNHP
 SiHu/MnE1lsAzjnTzOoLarkiVEVsVjk4sUFIO8Nw==
X-Received: by 2002:a05:600c:630f:b0:4a1:7ec7:a479 with SMTP id
 5b1f17b1804b1-4bb55aa5795mr87109715e9.33.1794608461442; 
 Fri, 13 Nov 2026 14:21:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb566cec2esm64727245e9.1.2026.11.13.14.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 14:21:00 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 22:20:59 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: bf7c8d16730fd21ac290ad508404f6efcbdfc8a4
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <025c54681c031ae5ede81fbf52edb4496c078416-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRzds-000000006PI-1Kzd
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6411484137544930543=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6411484137544930543==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3DHOlVkdTOs="; charset=UTF-8

--3DHOlVkdTOs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#7) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
158?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: crypto*: Avoid sign =
conversion warnings by using defines directly
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

crypto*: Avoid sign conversion warnings =
by using defines directly

Using the defines directly avoids the issue with=
 sign
conversion by letting the compiler deduce the types of
the literals=
=2E

I do not think that using an intermediate variable
increases the reada=
bility=2E

Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
Signed-off-=
by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2158
Message-Id: <20261111183144=2E18676-1-gert@greenie=2Emuc=2Ede>
URL:=
 https://lore=2Ekernel=2Eorg/openvpn-devel/20261111183144=2E18676-1-gert@gr=
eenie=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
=
M src/openvpn/crypto=2Ec
M src/openvpn/crypto_epoch=2Ec
M src/openvpn/packe=
t_id=2Eh
M src/openvpn/tls_crypt=2Ec
M src/openvpn/tls_crypt=2Eh
M tests/un=
it_tests/openvpn/test_tls_crypt=2Ec
6 files changed, 24 insertions(+), 50 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/58/2158/7

diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=
=2Ec
index 5ad4b5f=2E=2Edb1cb41 100644
--- a/src/openvpn/crypto=2Ec
+++ b/s=
rc/openvpn/crypto=2Ec
@@ -81,7 +81,6 @@
 
     const struct key_ctx *ctx =
=3D &opt->key_ctx_bi=2Eencrypt;
     uint8_t *mac_out =3D NULL;
-    const =
int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;
 
     /* IV, packet-ID and implic=
it IV required for this mode=2E */
     ASSERT(ctx->cipher);
@@ -142,7 +141=
,7 @@
     dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf),=
 BLENZ(buf), 80, &gc));
 
     /* Buffer overflow check */
-    if (!buf_sa=
fe(&work, buf->len + mac_len + cipher_ctx_block_size(ctx->cipher)))
+    if=
 (!buf_safe(&work, BLENZ(buf) + OPENVPN_AEAD_TAG_LENGTH + cipher_ctx_block_=
size(ctx->cipher)))
     {
         msg(D_CRYPT_ERRORS, "ENCRYPT: buffer si=
ze error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d",
             bu=
f->capacity, buf->offset, buf->len, work=2Ecapacity, work=2Eoffset, work=2E=
len);
@@ -156,7 +155,7 @@
     if (!use_epoch_data_format)
     {
         =
/* Reserve space for authentication tag */
-        mac_out =3D buf_write_a=
lloc(&work, mac_len);
+        mac_out =3D buf_write_alloc(&work, OPENVPN_A=
EAD_TAG_LENGTH);
         ASSERT(mac_out);
     }
 
@@ -177,12 +176,12 @@
 =
    if (use_epoch_data_format)
     {
         /* Reserve space for authent=
ication tag */
-        mac_out =3D buf_write_alloc(&work, mac_len);
+     =
   mac_out =3D buf_write_alloc(&work, OPENVPN_AEAD_TAG_LENGTH);
         AS=
SERT(mac_out);
     }
 
     /* Write authentication tag */
-    ASSERT(cip=
her_ctx_get_tag(ctx->cipher, mac_out, mac_len));
+    ASSERT(cipher_ctx_get=
_tag(ctx->cipher, mac_out, OPENVPN_AEAD_TAG_LENGTH));
 
     *buf =3D work;=

 
@@ -449,9 +448,6 @@
         CRYPT_DROP("Decryption failed verification =
limit reached=2E");
     }
 
-    const int tag_size =3D OPENVPN_AEAD_TAG_L=
ENGTH;
-
-
     ASSERT(frame);
     ASSERT(buf->len > 0);
     ASSERT(ctx->=
cipher);
@@ -466,14 +462,14 @@
     ASSERT(packet_id_initialized(&opt->pack=
et_id));
 
     /* Ensure that the packet size is long enough */
-    int m=
in_packet_len =3D packet_id_size(false) + tag_size + 1;
+    size_t min_pac=
ket_len =3D packet_id_size(false) + OPENVPN_AEAD_TAG_LENGTH + 1;
 
     if =
(use_epoch_data_format)
     {
         min_packet_len +=3D sizeof(uint32_t=
);
     }
 
-    if (buf->len < min_packet_len)
+    if (BLENZ(buf) < min_p=
acket_len)
     {
         CRYPT_ERROR("missing IV info, missing tag or no =
payload");
     }
@@ -536,24 +532,24 @@
         }
     }
 
-    const int =
ad_size =3D (int)(BPTR(buf) - ad_start);
+    const uintptr_t ad_size =3D (=
uintptr_t)(BPTR(buf) - ad_start);
 
     uint8_t *tag_ptr =3D NULL;
     in=
t data_len =3D 0;
 
     if (use_epoch_data_format)
     {
-        data_le=
n =3D BLEN(buf) - tag_size;
+        data_len =3D BLEN(buf) - OPENVPN_AEAD_=
TAG_LENGTH;
         tag_ptr =3D BPTR(buf) + data_len;
     }
     else
   =
  {
         tag_ptr =3D BPTR(buf);
-        ASSERT(buf_advance(buf, tag_si=
ze));
+        ASSERT(buf_advance(buf, OPENVPN_AEAD_TAG_LENGTH));
         =
data_len =3D BLEN(buf);
     }
 
-    dmsg(D_PACKET_CONTENT, "DECRYPT MAC: =
%s", format_hex(tag_ptr, tag_size, 0, &gc));
+    dmsg(D_PACKET_CONTENT, "D=
ECRYPT MAC: %s", format_hex(tag_ptr, OPENVPN_AEAD_TAG_LENGTH, 0, &gc));
   =
  dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(bu=
f), 0, &gc));
 
     /* Buffer overflow check (should never fail) */
@@ -56=
3,7 +559,7 @@
     }
 
     /* feed in tag and the authenticated data */
- =
   ASSERT(cipher_ctx_update_ad(ctx->cipher, ad_start, ad_size));
+    ASSER=
T(cipher_ctx_update_ad(ctx->cipher, ad_start, (int)ad_size));
     dmsg(D_P=
ACKET_CONTENT, "DECRYPT AD: %s", format_hex(ad_start, ad_size, 0, &gc));
 
=
     /* Decrypt and authenticate packet */
@@ -574,7 +570,7 @@
     }
 
   =
  ASSERT(buf_inc_len(&work, outlen));
-    if (!cipher_ctx_final_check_tag(=
ctx->cipher, BPTR(&work) + outlen, &outlen, tag_ptr, tag_size))
+    if (!c=
ipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outlen, &outlen, tag_p=
tr, OPENVPN_AEAD_TAG_LENGTH))
     {
         ctx->failed_verifications++;
=
         CRYPT_DROP("packet tag authentication failed");
@@ -1114,20 +1110,=
19 @@
 static void
 generate_key_random(struct key *key)
 {
-    int cipher=
_len =3D MAX_CIPHER_KEY_LENGTH;
-    int hmac_len =3D MAX_HMAC_KEY_LENGTH;
=
-
     struct gc_arena gc =3D gc_new();
 
     CLEAR(*key);
-    if (!rand_=
bytes(key->cipher, cipher_len) || !rand_bytes(key->hmac, hmac_len))
+    if=
 (!rand_bytes(key->cipher, MAX_CIPHER_KEY_LENGTH)
+        || !rand_bytes(k=
ey->hmac, MAX_HMAC_KEY_LENGTH))
     {
         msg(M_FATAL, "ERROR: Random=
 number generator cannot obtain entropy for key generation");
     }
 
    =
 dmsg(D_SHOW_KEY_SOURCE, "Cipher source entropy: %s",
-         format_hex(=
key->cipher, cipher_len, 0, &gc));
-    dmsg(D_SHOW_KEY_SOURCE, "HMAC sourc=
e entropy: %s", format_hex(key->hmac, hmac_len, 0, &gc));
+         format_=
hex(key->cipher, MAX_CIPHER_KEY_LENGTH, 0, &gc));
+    dmsg(D_SHOW_KEY_SOUR=
CE, "HMAC source entropy: %s",
+         format_hex(key->hmac, MAX_HMAC_KEY=
_LENGTH, 0, &gc));
 
     gc_free(&gc);
 }
diff --git a/src/openvpn/crypto_=
epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
index 243b5a2=2E=2E40e8cec 100644
=
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src/openvpn/crypto_epoch=2Ec
@@ -3=
8,11 +38,6 @@
 #include "buffer=2Eh"
 #include "integer=2Eh"
 
-#if defined=
(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC =
diagnostic ignored "-Wsign-conversion"
-#endif
-
 void
 ovpn_hkdf_expand(co=
nst uint8_t *secret, const uint8_t *info, size_t info_len,
                =
  uint8_t *out, size_t out_len)
@@ -51,26 +46,23 @@
     hmac_ctx_init(hmac=
_ctx, secret, "SHA256");
 
     ASSERT(info_len <=3D INT_MAX);
-    const u=
nsigned int digest_size =3D SHA256_DIGEST_LENGTH;
 
     /* T(0) =3D empty =
string */
     uint8_t t_prev[SHA256_DIGEST_LENGTH];
-    unsigned int t_pr=
ev_len =3D 0;
 
-    for (uint8_t block =3D 1; (block - 1) * digest_size < =
out_len; block++)
+    for (uint8_t block =3D 1; (block - 1u) * SHA256_DIGE=
ST_LENGTH < out_len; block++)
     {
         hmac_ctx_reset(hmac_ctx);
 
 =
        /* calculate T(block) */
-        hmac_ctx_update(hmac_ctx, t_prev,=
 t_prev_len);
+        hmac_ctx_update(hmac_ctx, t_prev, block =3D=3D 1 ? 0=
 : SHA256_DIGEST_LENGTH);
         hmac_ctx_update(hmac_ctx, info, (int)inf=
o_len);
         hmac_ctx_update(hmac_ctx, &block, 1);
         hmac_ctx_fi=
nal(hmac_ctx, t_prev);
-        t_prev_len =3D digest_size;
 
         /* C=
opy a full hmac output or remaining bytes */
-        size_t out_offset =3D=
 (block - 1) * digest_size;
-        size_t copylen =3D min_size(digest_siz=
e, out_len - out_offset);
+        size_t out_offset =3D (block - 1u) * SHA=
256_DIGEST_LENGTH;
+        size_t copylen =3D min_size(SHA256_DIGEST_LENGT=
H, out_len - out_offset);
 
         memcpy(out + out_offset, t_prev, copyl=
en);
     }
@@ -463,7 +455,3 @@
         epoch_iterate_send_key(opt);
     =
}
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic=
 pop
-#endif
diff --git a/src/openvpn/packet_id=2Eh b/src/openvpn/packet_id=
=2Eh
index c374ccb=2E=2E08a0f78 100644
--- a/src/openvpn/packet_id=2Eh
+++ =
b/src/openvpn/packet_id=2Eh
@@ -249,7 +249,7 @@
 const char *packet_id_net_=
print(const struct packet_id_net *pin, bool print_timestamp,
              =
                   struct gc_arena *gc);
 
-static inline int
+static inlin=
e unsigned int
 packet_id_size(bool long_form)
 {
     return sizeof(packet=
_id_type) + (long_form ? sizeof(net_time_t) : 0);
diff --git a/src/openvpn/=
tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index e59f55b=2E=2E08d9fcd 100644=

--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -52,7 +=
52,7 @@
     return create_kt("AES-256-CTR", "SHA256", "tls-crypt");
 }
 
-=
int
+unsigned int
 tls_crypt_buf_overhead(void)
 {
     return packet_id_si=
ze(true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_SIZE;
diff --git a/src/open=
vpn/tls_crypt=2Eh b/src/openvpn/tls_crypt=2Eh
index d179cbb=2E=2E8e5567f 10=
0644
--- a/src/openvpn/tls_crypt=2Eh
+++ b/src/openvpn/tls_crypt=2Eh
@@ -13=
0,7 +130,7 @@
  * Returns the maximum overhead (in bytes) added to the dest=
ination buffer by
  * tls_crypt_wrap()=2E
  */
-int tls_crypt_buf_overhead(=
void);
+unsigned int tls_crypt_buf_overhead(void);
 
 /**
  * Wrap a contro=
l channel packet (both authenticates and encrypts the data)=2E
diff --git a=
/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/tes=
t_tls_crypt=2Ec
index 2d31c00=2E=2E00de73a 100644
--- a/tests/unit_tests/op=
envpn/test_tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
=
@@ -232,11 +232,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang_=
_)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-con=
version"
-#endif
-
 /**
  * Check that short messages are successfully wrap=
ped-and-unwrapped=2E
  */
@@ -778,10 +773,6 @@
     tls_wrap_free(&wrap_ctx=
);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnosti=
c pop
-#endif
-
 static void
 test_tls_crypt_v2_write_server_key_file(void =
**state)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2158?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b=
cb4cb8e17ff80a5cb8acdaf18d1072159184e5
Gerrit-Change-Number: 2158
Gerrit-Pa=
tchSet: 7
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--3DHOlVkdTOs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #7</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2158?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">crypto*: Avoid sign conversion warnings by using defines directly<br><b=
r>Using the defines directly avoids the issue with sign<br>conversion by le=
tting the compiler deduce the types of<br>the literals=2E<br><br>I do not t=
hink that using an intermediate variable<br>increases the readability=2E<br=
><br>Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2158<br>Message-Id: &lt;20261111183144=2E18676-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/2026=
1111183144=2E18676-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doering=
 &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/crypto=2Ec<br>M sr=
c/openvpn/crypto_epoch=2Ec<br>M src/openvpn/packet_id=2Eh<br>M src/openvpn/=
tls_crypt=2Ec<br>M src/openvpn/tls_crypt=2Eh<br>M tests/unit_tests/openvpn/=
test_tls_crypt=2Ec<br>6 files changed, 24 insertions(+), 50 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/58/2158/7</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto=2Ec b/src/=
openvpn/crypto=2Ec</span><br><span>index 5ad4b5f=2E=2Edb1cb41 100644</span>=
<br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/cr=
ypto=2Ec</span><br><span>@@ -81,7 +81,6 @@</span><br><span> </span><br><spa=
n>     const struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi=2Eencrypt;</sp=
an><br><span>     uint8_t *mac_out =3D NULL;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    const int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;</=
span><br><span> </span><br><span>     /* IV, packet-ID and implicit IV requ=
ired for this mode=2E */</span><br><span>     ASSERT(ctx-&gt;cipher);</span=
><br><span>@@ -142,7 +141,7 @@</span><br><span>     dmsg(D_PACKET_CONTENT, =
&quot;ENCRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc=
));</span><br><span> </span><br><span>     /* Buffer overflow check */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!buf_safe(&amp;wor=
k, buf-&gt;len + mac_len + cipher_ctx_block_size(ctx-&gt;cipher)))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_safe(&amp;work,=
 BLENZ(buf) + OPENVPN_AEAD_TAG_LENGTH + cipher_ctx_block_size(ctx-&gt;ciphe=
r)))</span><br><span>     {</span><br><span>         msg(D_CRYPT_ERRORS, &q=
uot;ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=
=3D%d&quot;,</span><br><span>             buf-&gt;capacity, buf-&gt;offset,=
 buf-&gt;len, work=2Ecapacity, work=2Eoffset, work=2Elen);</span><br><span>=
@@ -156,7 +155,7 @@</span><br><span>     if (!use_epoch_data_format)</span>=
<br><span>     {</span><br><span>         /* Reserve space for authenticati=
on tag */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mac_=
out =3D buf_write_alloc(&amp;work, mac_len);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        mac_out =3D buf_write_alloc(&amp;work, OPE=
NVPN_AEAD_TAG_LENGTH);</span><br><span>         ASSERT(mac_out);</span><br>=
<span>     }</span><br><span> </span><br><span>@@ -177,12 +176,12 @@</span>=
<br><span>     if (use_epoch_data_format)</span><br><span>     {</span><br>=
<span>         /* Reserve space for authentication tag */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        mac_out =3D buf_write_alloc(&am=
p;work, mac_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      mac_out =3D buf_write_alloc(&amp;work, OPENVPN_AEAD_TAG_LENGTH);</spa=
n><br><span>         ASSERT(mac_out);</span><br><span>     }</span><br><spa=
n> </span><br><span>     /* Write authentication tag */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ASSERT(cipher_ctx_get_tag(ctx-&gt;cip=
her, mac_out, mac_len));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ASSERT(cipher_ctx_get_tag(ctx-&gt;cipher, mac_out, OPENVPN_AEAD_TA=
G_LENGTH));</span><br><span> </span><br><span>     *buf =3D work;</span><br=
><span> </span><br><span>@@ -449,9 +448,6 @@</span><br><span>         CRYPT=
_DROP(&quot;Decryption failed verification limit reached=2E&quot;);</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(frame);</span><br><span> =
    ASSERT(buf-&gt;len &gt; 0);</span><br><span>     ASSERT(ctx-&gt;cipher)=
;</span><br><span>@@ -466,14 +462,14 @@</span><br><span>     ASSERT(packet_=
id_initialized(&amp;opt-&gt;packet_id));</span><br><span> </span><br><span>=
     /* Ensure that the packet size is long enough */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int min_packet_len =3D packet_id_size(f=
alse) + tag_size + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    size_t min_packet_len =3D packet_id_size(false) + OPENVPN_AEAD_TAG_LE=
NGTH + 1;</span><br><span> </span><br><span>     if (use_epoch_data_format)=
</span><br><span>     {</span><br><span>         min_packet_len +=3D sizeof=
(uint32_t);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt; min_packet_len)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &lt=
; min_packet_len)</span><br><span>     {</span><br><span>         CRYPT_ERR=
OR(&quot;missing IV info, missing tag or no payload&quot;);</span><br><span=
>     }</span><br><span>@@ -536,24 +532,24 @@</span><br><span>         }</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const int ad_size =3D (int)(BPTR(buf) - ad_start);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uintptr_t ad_=
size =3D (uintptr_t)(BPTR(buf) - ad_start);</span><br><span> </span><br><sp=
an>     uint8_t *tag_ptr =3D NULL;</span><br><span>     int data_len =3D 0;=
</span><br><span> </span><br><span>     if (use_epoch_data_format)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 data_len =3D BLEN(buf) - tag_size;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        data_len =3D BLEN(buf) - OPENVPN_AEAD_TAG_LENGTH;</=
span><br><span>         tag_ptr =3D BPTR(buf) + data_len;</span><br><span> =
    }</span><br><span>     else</span><br><span>     {</span><br><span>    =
     tag_ptr =3D BPTR(buf);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        ASSERT(buf_advance(buf, tag_size));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        ASSERT(buf_advance(buf, OPENVPN_AEAD_=
TAG_LENGTH));</span><br><span>         data_len =3D BLEN(buf);</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    dmsg(D_PACKET_CONTENT, &quot;DECRYPT MAC: %s&quot;, format_hex(t=
ag_ptr, tag_size, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;DECRYPT MAC: %s&quot;, format_=
hex(tag_ptr, OPENVPN_AEAD_TAG_LENGTH, 0, &amp;gc));</span><br><span>     dm=
sg(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BL=
ENZ(buf), 0, &amp;gc));</span><br><span> </span><br><span>     /* Buffer ov=
erflow check (should never fail) */</span><br><span>@@ -563,7 +559,7 @@</sp=
an><br><span>     }</span><br><span> </span><br><span>     /* feed in tag a=
nd the authenticated data */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    ASSERT(cipher_ctx_update_ad(ctx-&gt;cipher, ad_start, ad_size));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(cipher_c=
tx_update_ad(ctx-&gt;cipher, ad_start, (int)ad_size));</span><br><span>    =
 dmsg(D_PACKET_CONTENT, &quot;DECRYPT AD: %s&quot;, format_hex(ad_start, ad=
_size, 0, &amp;gc));</span><br><span> </span><br><span>     /* Decrypt and =
authenticate packet */</span><br><span>@@ -574,7 +570,7 @@</span><br><span>=
     }</span><br><span> </span><br><span>     ASSERT(buf_inc_len(&amp;work,=
 outlen));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!ci=
pher_ctx_final_check_tag(ctx-&gt;cipher, BPTR(&amp;work) + outlen, &amp;out=
len, tag_ptr, tag_size))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!cipher_ctx_final_check_tag(ctx-&gt;cipher, BPTR(&amp;work) + =
outlen, &amp;outlen, tag_ptr, OPENVPN_AEAD_TAG_LENGTH))</span><br><span>   =
  {</span><br><span>         ctx-&gt;failed_verifications++;</span><br><spa=
n>         CRYPT_DROP(&quot;packet tag authentication failed&quot;);</span>=
<br><span>@@ -1114,20 +1110,19 @@</span><br><span> static void</span><br><s=
pan> generate_key_random(struct key *key)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    int cipher_len =3D MAX_CIPHER_KE=
Y_LENGTH;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int hmac=
_len =3D MAX_HMAC_KEY_LENGTH;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><s=
pan> </span><br><span>     CLEAR(*key);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (!rand_bytes(key-&gt;cipher, cipher_len) || !rand_=
bytes(key-&gt;hmac, hmac_len))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!rand_bytes(key-&gt;cipher, MAX_CIPHER_KEY_LENGTH)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        || !rand_bytes(ke=
y-&gt;hmac, MAX_HMAC_KEY_LENGTH))</span><br><span>     {</span><br><span>  =
       msg(M_FATAL, &quot;ERROR: Random number generator cannot obtain entr=
opy for key generation&quot;);</span><br><span>     }</span><br><span> </sp=
an><br><span>     dmsg(D_SHOW_KEY_SOURCE, &quot;Cipher source entropy: %s&q=
uot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         format_=
hex(key-&gt;cipher, cipher_len, 0, &amp;gc));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    dmsg(D_SHOW_KEY_SOURCE, &quot;HMAC source entro=
py: %s&quot;, format_hex(key-&gt;hmac, hmac_len, 0, &amp;gc));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         format_hex(key-&gt;ciph=
er, MAX_CIPHER_KEY_LENGTH, 0, &amp;gc));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    dmsg(D_SHOW_KEY_SOURCE, &quot;HMAC source entropy:=
 %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
format_hex(key-&gt;hmac, MAX_HMAC_KEY_LENGTH, 0, &amp;gc));</span><br><span=
> </span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><spa=
n>diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec<=
/span><br><span>index 243b5a2=2E=2E40e8cec 100644</span><br><span>--- a/src=
/openvpn/crypto_epoch=2Ec</span><br><span>+++ b/src/openvpn/crypto_epoch=2E=
c</span><br><span>@@ -38,11 +38,6 @@</span><br><span> #include &quot;buffer=
=2Eh&quot;</span><br><span> #include &quot;integer=2Eh&quot;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> o=
vpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, size_t info_len=
,</span><br><span>                  uint8_t *out, size_t out_len)</span><br=
><span>@@ -51,26 +46,23 @@</span><br><span>     hmac_ctx_init(hmac_ctx, sec=
ret, &quot;SHA256&quot;);</span><br><span> </span><br><span>     ASSERT(inf=
o_len &lt;=3D INT_MAX);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const unsigned int digest_size =3D SHA256_DIGEST_LENGTH;</span><br><s=
pan> </span><br><span>     /* T(0) =3D empty string */</span><br><span>    =
 uint8_t t_prev[SHA256_DIGEST_LENGTH];</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    unsigned int t_prev_len =3D 0;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (uint8_t block =3D =
1; (block - 1) * digest_size &lt; out_len; block++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (uint8_t block =3D 1; (block - 1u=
) * SHA256_DIGEST_LENGTH &lt; out_len; block++)</span><br><span>     {</spa=
n><br><span>         hmac_ctx_reset(hmac_ctx);</span><br><span> </span><br>=
<span>         /* calculate T(block) */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        hmac_ctx_update(hmac_ctx, t_prev, t_prev_len);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_updat=
e(hmac_ctx, t_prev, block =3D=3D 1 ? 0 : SHA256_DIGEST_LENGTH);</span><br><=
span>         hmac_ctx_update(hmac_ctx, info, (int)info_len);</span><br><sp=
an>         hmac_ctx_update(hmac_ctx, &amp;block, 1);</span><br><span>     =
    hmac_ctx_final(hmac_ctx, t_prev);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        t_prev_len =3D digest_size;</span><br><span> </span=
><br><span>         /* Copy a full hmac output or remaining bytes */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        size_t out_offset =
=3D (block - 1) * digest_size;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        size_t copylen =3D min_size(digest_size, out_len - out_off=
set);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t=
 out_offset =3D (block - 1u) * SHA256_DIGEST_LENGTH;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        size_t copylen =3D min_size(SHA25=
6_DIGEST_LENGTH, out_len - out_offset);</span><br><span> </span><br><span> =
        memcpy(out + out_offset, t_prev, copylen);</span><br><span>     }</=
span><br><span>@@ -463,7 +455,3 @@</span><br><span>         epoch_iterate_s=
end_key(opt);</span><br><span>     }</span><br><span> }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>diff --git a=
/src/openvpn/packet_id=2Eh b/src/openvpn/packet_id=2Eh</span><br><span>inde=
x c374ccb=2E=2E08a0f78 100644</span><br><span>--- a/src/openvpn/packet_id=
=2Eh</span><br><span>+++ b/src/openvpn/packet_id=2Eh</span><br><span>@@ -24=
9,7 +249,7 @@</span><br><span> const char *packet_id_net_print(const struct=
 packet_id_net *pin, bool print_timestamp,</span><br><span>                =
                 struct gc_arena *gc);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline unsigned int</span><br><spa=
n> packet_id_size(bool long_form)</span><br><span> {</span><br><span>     r=
eturn sizeof(packet_id_type) + (long_form ? sizeof(net_time_t) : 0);</span>=
<br><span>diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2E=
c</span><br><span>index e59f55b=2E=2E08d9fcd 100644</span><br><span>--- a/s=
rc/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</s=
pan><br><span>@@ -52,7 +52,7 @@</span><br><span>     return create_kt(&quot=
;AES-256-CTR&quot;, &quot;SHA256&quot;, &quot;tls-crypt&quot;);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int=
</span><br><span> tls_crypt_buf_overhead(void)</span><br><span> {</span><br=
><span>     return packet_id_size(true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BL=
OCK_SIZE;</span><br><span>diff --git a/src/openvpn/tls_crypt=2Eh b/src/open=
vpn/tls_crypt=2Eh</span><br><span>index d179cbb=2E=2E8e5567f 100644</span><=
br><span>--- a/src/openvpn/tls_crypt=2Eh</span><br><span>+++ b/src/openvpn/=
tls_crypt=2Eh</span><br><span>@@ -130,7 +130,7 @@</span><br><span>  * Retur=
ns the maximum overhead (in bytes) added to the destination buffer by</span=
><br><span>  * tls_crypt_wrap()=2E</span><br><span>  */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-int tls_crypt_buf_overhead(void);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int tls_crypt_buf_=
overhead(void);</span><br><span> </span><br><span> /**</span><br><span>  * =
Wrap a control channel packet (both authenticates and encrypts the data)=2E=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b=
/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>index 2d31c00=
=2E=2E00de73a 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_tl=
s_crypt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec</span><br><span>@@ -232,11 +232,6 @@</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsig=
n-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
/**</span><br><span>  * Check that short messages are successfully wrapped-=
and-unwrapped=2E</span><br><span>  */</span><br><span>@@ -778,10 +773,6 @@<=
/span><br><span>     tls_wrap_free(&amp;wrap_ctx);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> static void</span><br><span> test_tls_crypt_v2_write_s=
erver_key_file(void **state)</span><br><span> {</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Dema=
il">change 2158</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2158?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2158 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--3DHOlVkdTOs=--


--===============6411484137544930543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6411484137544930543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6411484137544930543==--

