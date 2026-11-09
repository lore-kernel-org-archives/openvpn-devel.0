Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E854E6082BD9
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KB6ThHOA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=K3sLjzX1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=C2OWiLeB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K4/+dGDD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hk/dN79Xve7IkMW4hbopRE9QK3nKPpk/s1O+UTFkjsI=; b=KB6ThHOAc1XuJ9V2azDkuJlY/K
	kaXTiPcpS2w7NVahhcqL9dR+DQcD23aITEehb7HyyX6pOAPVnYzK0VgeqGW1y6y1M7pGGBv9tQ3Hc
	IXofk5juW2TCtUJiTVfoeCNa0ojMj7GcPK1m2xOt6vIl/8X8fOHqV1F0SNKg3/ydVFag=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRYu-000000007xN-2hty;
	Mon, 09 Nov 2026 15:45:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQRYs-000000007xH-3uxl
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:45:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W8vvB9iPnm60V/3xYTjCnXTOI7F8fQkILFCAdtRVUtk=; b=K3sLjzX1AHXhwTW/Np6ttLz2ql
 ihEE0QlPDOYJzwBDWL+xgTZqOjSG0L03Sb+3ZzhOvQ+B6+ZsOyoRi32ogyDcUrsAqo0s/fObmqT2S
 icKNzHmt5F1B5lsd60hOzRrfrSelPAP6QLA5Hp6Nae4gP2WiU97FcpQ65Ta1Gv/DhKGs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W8vvB9iPnm60V/3xYTjCnXTOI7F8fQkILFCAdtRVUtk=; b=C2OWiLeBjds6KO+IPiOu0COG68
 xZKF5AiqBqG1yovkSgwqmtsQBhlJVOp+bGYiDRiRgJRk7tnVXPUf15yG83oaAJe6ZidwpB5qFxT4i
 CQ6BZOmDMcEAhLDSf4gyELUtdS0CRGArTFlOt4Ab1jn0ksUFtVJEF14UIdV531u3q2yA=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQRYn-000000001RX-0xWA for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:45:34 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so7484095e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 07:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794239123; x=1794843923; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W8vvB9iPnm60V/3xYTjCnXTOI7F8fQkILFCAdtRVUtk=;
 b=K4/+dGDDBKb21CP/r7FrKDpybf7E8B6+0/aZ5rd+/PsijKt/DhtiGKnKEsx2LSK8jT
 7ZoLTUCsKRTJSNjhQOUajgGagvRg24anBndxF0gAN71Txf7OniKmwbbkGY/U+5tOOaGs
 rcfRF9UbyVw+YQvEdM0ij9TmzvkAEiapeZo8629kFaFm0OBGnCWwpMM2JdxkA7yCucT0
 7oItPxvgLDhvE3oiW5zis+fWQztWtFGG31ADRzOpH3fTcwBlkqVEyc07kfMO7fFUkdtv
 Xh8AWEQlGbEX/Wm/tY7qmYrHPIu22S/jB3Guz6O6QO+r3qvWaAkJLYOPFJF3/7hANAxZ
 QcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794239123; x=1794843923;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=W8vvB9iPnm60V/3xYTjCnXTOI7F8fQkILFCAdtRVUtk=;
 b=rabm5866+QNJd8UKN3+FlP3N0RTdOblOrABebZyR8Pney/D5I3BamHXXeMzwa7Blo2
 6VUWEtWi0LTV/sHC4pGh3iIpWeeQfvC8pnn2aSK66vir3IYlpgxTfFA4fL4vgXMQIqNw
 wxX5uT8tGLHnY+gKoMdyOzZtvde1CgJY+RPBQ74miAGu+GJBi8xgagxqBvtDNU7DYR7B
 ea0Vkn3sS2TnXM/E6oOSULxWvfsoq17FavjKOX5FSFdIoQCvNQTDNjBHP7wG2sXO/OwX
 QiXyot5Zs7Ckasbv34Sx3fGaWjUTFhtWC5evFunbOHx4J91SsycVyYLkPv2JmfqpQixj
 g2Gw==
X-Forwarded-Encrypted: i=1;
 AL+hErGbzsnU6nxoht+BCPPwxmj0+MBJHX/vvV0KH1uI0lfi2ZFA1hksETmTbzXRaOAFBBdiWT6NISI/3h59RQ6B@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8V3zr5hX1JgdMiNffR9RsXEvn+9mrrCic/ymapklkRha1jhsSB
 bTpsFdczluvTSSwuLaiFF/TZ/ECWJBC8lTDv6NezEm437c2SkQecxLffM80OXL8l0j4GSUAd1XC
 FB5NSTNUtirD8VHG6s2oldxsSpcQw6TPZAiVeC18/61rHM7ydY7pgAJ5RmsfVP+6lYFoiTH1vkz
 iZEFHuFQ==
X-Gm-Gg: AYBFou3LhGzF/uhf7gtaJeemAPgynBdzh/Y9JGy3lvc9UKPJOFG11SbuXNqhxganpfG
 uPSpDdt3VCfODyTdUUMCvpTpWgECrpiTJPRkeFAQvTJ2h1rIDaDojrMD+xaTMIPqU37URnNqYUs
 MKOzk8FgnXi+FXqcYLP1FtkhIVDvM1Q4BYrKpuC3Klx9Cys8Oqnb80j3FdSsReXkPAaWedAJFJ5
 eJQzy9OavlAHoIqncd4EvCnHuHNRpgYhUFq/lz579F5ON7lI56bb+SlOnHA5lihqLseXskLAkTh
 s2e9KLlIzkNbhnuLdncfenrIsDsa8HE6E6B9BUq8zZcD4bEYgYSI4EswykQudYtxk0aLPiGrf/R
 B6BJKBQXWgmrBvYvD8fvQSqOGF+bCj2DTo2UuOHxaxQYV3TGYccw/gKaf22+vYrZnum0xWiK5qT
 YDnVErTnFLEes1l4fbV86EjBaZhweMcyLfjQV/N4sqUWeUndTNelqNgNBt1GzkRL9qXHr0V2pyF
 f37UkBhh3UvQb9Q62as7QSbZcyTpHSizP5K7u1lUlyjljRUbqs03Z9pCvQDee/0mJ5PKRE7g+IS
 gMFmPFdY3si7rZ66EDzGG/wN1Fy5+3ODQ0s/XTPsGkmN/748KjHwJ7yxsETRDMN6sSDxpLBeJ+o
 J1un7KT6Zod0adKZnzygz9dBs5EZws2S9qyWNW1u8LEs5Amj2rspndbNaOn+t4Sv2r0pNysI5cc
 m/JgV/LljXo7IzGg==
X-Received: by 2002:a05:600c:6209:b0:4b8:d17e:da2e with SMTP id
 5b1f17b1804b1-4b963c6c4aemr75520245e9.10.1794239122035; 
 Mon, 09 Nov 2026 07:45:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597748acbsm10667655f8f.44.2026.11.09.07.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 07:45:21 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 15:45:21 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I61a0d15962584bc48cae459062fead08dc425aeb
X-Gerrit-Change-Number: 2071
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2071?usp=email>
X-Gerrit-Commit: 91bff1b6be151c20e9db180b791b7ccb2765ce95
In-Reply-To: <gerrit.1793294136000.I61a0d15962584bc48cae459062fead08dc425aeb@gerrit.openvpn.net>
References: <gerrit.1793294136000.I61a0d15962584bc48cae459062fead08dc425aeb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjk0MTM2MDAwLkk2MWEwZDE1OTYyNTg0YmM0OGNhZTQ1OTA2MmZlYWQwOGRjNDI1YWViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <81ec6085e964209f2bfa0c4aace19e1d8db6cb4d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQRYn-000000001RX-0xWA
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove
 PACKET_TRUNCATION_CHECK
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2890273724586307493=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2890273724586307493==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VQHSSBwJuXA="; charset=UTF-8

--VQHSSBwJuXA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2071?usp=3Demail )

Change subject: Remove PACKET_TRUNCATION_CH=
ECK
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove =
PACKET_TRUNCATION_CHECK

This functionality checks if packets might be trun=
cated by checking
the length of the IPv4 header against the length of the b=
uffer to
see if a packet is truncated=2E

This function has been undocument=
ed and can be only enabled by
manually defining this define=2E

This might =
have been useful in 2005 when this function was added
but currently is rath=
er dead code that can a diagnose a problem
that is extremely rare or has be=
en already been fixed outside of
OpenVPN=2E

Change-Id: I61a0d15962584bc48c=
ae459062fead08dc425aeb
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Ack=
ed-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2071
Message-Id: <20261031190839=2E30023-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg40382=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/errlevel=2Eh
M src/openvpn/forward=2E=
c
M src/openvpn/multi=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/proto=2Ec=

M src/openvpn/proto=2Eh
M src/openvpn/sig=2Ec
7 files changed, 89 insertio=
ns(+), 204 deletions(-)




diff --git a/src/openvpn/errlevel=2Eh b/src/ope=
nvpn/errlevel=2Eh
index d79efbb=2E=2Ee52cb65 100644
--- a/src/openvpn/errle=
vel=2Eh
+++ b/src/openvpn/errlevel=2Eh
@@ -49,105 +49,103 @@
  * of output=
=2E
  */
 
-#define M_VERB0 LOGLEV(0, 0, 0)                     /* Messages=
 displayed even at --verb 0 (fatal errors only) */
+#define M_VERB0 LOGLEV(=
0, 0, 0)                    /* Messages displayed even at --verb 0 (fatal e=
rrors only) */
 
-#define M_INFO LOGLEV(1, 0, 0)                      /* de=
fault informational messages */
+#define M_INFO LOGLEV(1, 0, 0)            =
         /* default informational messages */
 
-#define D_LINK_ERRORS    L=
OGLEV(1, 1, M_NONFATAL)   /* show link errors from main event loop */
-#def=
ine D_CRYPT_ERRORS   LOGLEV(1, 2, M_NONFATAL)   /* show errors from encrypt=
/decrypt */
-#define D_TLS_ERRORS     LOGLEV(1, 3, M_NONFATAL)   /* show TL=
S control channel errors */
-#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFAT=
AL)   /* show hostname resolve errors */
-#define D_COMP_ERRORS    LOGLEV(1=
, 5, M_NONFATAL)   /* show compression errors */
-#define D_REPLAY_ERRORS  =
LOGLEV(1, 6, M_NONFATAL)   /* show packet replay errors */
-#define D_STREA=
M_ERRORS  LOGLEV(1, 7, M_NONFATAL)   /* TCP stream error requiring restart =
*/
-#define D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)   /* show server impo=
rt option errors */
-#define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)   /*=
 show multi-client server errors */
-#define D_EVENT_ERRORS   LOGLEV(1, 10,=
 M_NONFATAL)  /* show event=2E[ch] errors */
-#define D_PUSH_ERRORS    LOGL=
EV(1, 11, M_NONFATAL)  /* show push/pull errors */
-#define D_PID_PERSIST  =
  LOGLEV(1, 12, M_NONFATAL)  /* show packet_id persist errors */
-#define D=
_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL)  /* show fragmentation errors */
=
-#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  /* show bad struct ali=
gnments */
+#define D_LINK_ERRORS    LOGLEV(1, 1, M_NONFATAL)  /* show link=
 errors from main event loop */
+#define D_CRYPT_ERRORS   LOGLEV(1, 2, M_NO=
NFATAL)  /* show errors from encrypt/decrypt */
+#define D_TLS_ERRORS     L=
OGLEV(1, 3, M_NONFATAL)  /* show TLS control channel errors */
+#define D_R=
ESOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL)  /* show hostname resolve errors */
=
+#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)  /* show compression err=
ors */
+#define D_REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)  /* show packet r=
eplay errors */
+#define D_STREAM_ERRORS  LOGLEV(1, 7, M_NONFATAL)  /* TCP =
stream error requiring restart */
+#define D_IMPORT_ERRORS  LOGLEV(1, 8, M_=
NONFATAL)  /* show server import option errors */
+#define D_MULTI_ERRORS  =
 LOGLEV(1, 9, M_NONFATAL)  /* show multi-client server errors */
+#define D=
_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL) /* show event=2E[ch] errors */
+#=
define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL) /* show push/pull errors =
*/
+#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL) /* show packet_id pe=
rsist errors */
+#define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL) /* show=
 fragmentation errors */
+#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL=
) /* show bad struct alignments */
 
-#define D_HANDSHAKE LOGLEV(2, 20, 0) =
               /* show data & control channel handshakes */
-#define D_CLOS=
E     LOGLEV(2, 22, 0)                /* show socket and TUN/TAP close */
-=
#define D_PROXY     LOGLEV(2, 24, 0)                /* show http proxy cont=
rol packets */
-#define D_ARGV      LOGLEV(2, 25, 0)                /* show=
 struct argv errors */
+#define D_HANDSHAKE LOGLEV(2, 20, 0)               =
/* show data & control channel handshakes */
+#define D_CLOSE     LOGLEV(2,=
 22, 0)               /* show socket and TUN/TAP close */
+#define D_PROXY =
    LOGLEV(2, 24, 0)               /* show http proxy control packets */
+#=
define D_ARGV      LOGLEV(2, 25, 0)               /* show struct argv error=
s */
 
-#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)            /* low frequenc=
y info from tls_session routines */
-#define D_GREMLIN       LOGLEV(3, 30, =
0)            /* show simulated outage info from gremlin module */
-#define=
 D_GENKEY        LOGLEV(3, 31, 0)            /* print message after key gen=
eration */
-#define D_ROUTE         LOGLEV(3, 0, 0)             /* show rou=
tes added and deleted (don't mute) */
-#define D_TUNTAP_INFO   LOGLEV(3, 32=
, 0)            /* show debugging info from TUN/TAP driver */
-#define D_RE=
START       LOGLEV(3, 33, 0)            /* show certain restart messages */=

-#define D_PUSH          LOGLEV(3, 34, 0)            /* show push/pull inf=
o */
-#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)            /* show ifconfig =
pool info */
-#define D_AUTH          LOGLEV(3, 37, 0)            /* show u=
ser/pass auth info */
-#define D_MULTI_LOW     LOGLEV(3, 38, 0)            =
/* show point-to-multipoint low-freq debug info */
-#define D_PLUGIN       =
 LOGLEV(3, 39, 0)            /* show plugin calls */
-#define D_MANAGEMENT =
   LOGLEV(3, 40, 0)            /* show --management info */
-#define D_SCHE=
D_EXIT    LOGLEV(3, 41, 0)            /* show arming of scheduled exit */
-=
#define D_ROUTE_QUOTA   LOGLEV(3, 42, 0)            /* show route quota exc=
eeded messages */
-#define D_OSBUF         LOGLEV(3, 43, 0)            /* s=
how socket/tun/tap buffer sizes */
-#define D_PS_PROXY      LOGLEV(3, 44, 0=
)            /* messages related to --port-share option */
-#define D_IFCON=
FIG      LOGLEV(3, 0, 0)             /* show ifconfig info (don't mute) */
=
-#define D_DCO           LOGLEV(3, 0, 0)             /* show DCO related me=
ssages */
+#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)           /* low freque=
ncy info from tls_session routines */
+#define D_GREMLIN       LOGLEV(3, 30=
, 0)           /* show simulated outage info from gremlin module */
+#defin=
e D_GENKEY        LOGLEV(3, 31, 0)           /* print message after key gen=
eration */
+#define D_ROUTE         LOGLEV(3, 0, 0)            /* show rout=
es added and deleted (don't mute) */
+#define D_TUNTAP_INFO   LOGLEV(3, 32,=
 0)           /* show debugging info from TUN/TAP driver */
+#define D_REST=
ART       LOGLEV(3, 33, 0)           /* show certain restart messages */
+#=
define D_PUSH          LOGLEV(3, 34, 0)           /* show push/pull info */=

+#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)           /* show ifconfig pool =
info */
+#define D_AUTH          LOGLEV(3, 37, 0)           /* show user/pa=
ss auth info */
+#define D_MULTI_LOW     LOGLEV(3, 38, 0)           /* show=
 point-to-multipoint low-freq debug info */
+#define D_PLUGIN        LOGLEV=
(3, 39, 0)           /* show plugin calls */
+#define D_MANAGEMENT    LOGLE=
V(3, 40, 0)           /* show --management info */
+#define D_SCHED_EXIT   =
 LOGLEV(3, 41, 0)           /* show arming of scheduled exit */
+#define D_=
ROUTE_QUOTA   LOGLEV(3, 42, 0)           /* show route quota exceeded messa=
ges */
+#define D_OSBUF         LOGLEV(3, 43, 0)           /* show socket/t=
un/tap buffer sizes */
+#define D_PS_PROXY      LOGLEV(3, 44, 0)           =
/* messages related to --port-share option */
+#define D_IFCONFIG      LOGL=
EV(3, 0, 0)            /* show ifconfig info (don't mute) */
+#define D_DCO=
           LOGLEV(3, 0, 0)            /* show DCO related messages */
 
-#d=
efine D_SHOW_PARMS       LOGLEV(4, 50, 0)         /* show all parameters on=
 program initiation */
-#define D_LOW              LOGLEV(4, 52, 0)        =
 /* miscellaneous low-frequency debug info */
-#define D_DHCP_OPT         L=
OGLEV(4, 53, 0)         /* show DHCP options binary string */
-#define D_MB=
UF             LOGLEV(4, 54, 0)         /* mbuf=2E[ch] routines */
-#define=
 D_PACKET_TRUNC_ERR LOGLEV(4, 55, 0)         /* PACKET_TRUNCATION_CHECK */
=
-#define D_MULTI_DROPPED    LOGLEV(4, 57, 0)         /* show point-to-multi=
point packet drops */
-#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)         =
/* show medium frequency multi messages */
-#define D_X509_ATTR        LOGL=
EV(4, 59, 0)         /* show x509-track attributes on connection */
-#defin=
e D_INIT_MEDIUM      LOGLEV(4, 60, 0)         /* show medium frequency init=
 messages */
-#define D_MTU_INFO         LOGLEV(4, 61, 0)         /* show t=
erse MTU info */
-#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)         /* sh=
ow low-freq packet-id debugging info */
-#define D_PID_DEBUG_MEDIUM LOGLEV(=
4, 64, 0)         /* show medium-freq packet-id debugging info */
-#define =
D_CIPHER_INIT      LOGLEV(4, 65, 0)         /* show messages about cipher i=
nit */
+#define D_SHOW_PARMS       LOGLEV(4, 50, 0)        /* show all para=
meters on program initiation */
+#define D_LOW              LOGLEV(4, 52, 0=
)        /* miscellaneous low-frequency debug info */
+#define D_DHCP_OPT  =
       LOGLEV(4, 53, 0)        /* show DHCP options binary string */
+#defi=
ne D_MBUF             LOGLEV(4, 54, 0)        /* mbuf=2E[ch] routines */
+#=
define D_MULTI_DROPPED    LOGLEV(4, 57, 0)        /* show point-to-multipoi=
nt packet drops */
+#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)        /* s=
how medium frequency multi messages */
+#define D_X509_ATTR        LOGLEV(4=
, 59, 0)        /* show x509-track attributes on connection */
+#define D_I=
NIT_MEDIUM      LOGLEV(4, 60, 0)        /* show medium frequency init messa=
ges */
+#define D_MTU_INFO         LOGLEV(4, 61, 0)        /* show terse MT=
U info */
+#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)        /* show low-f=
req packet-id debugging info */
+#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0=
)        /* show medium-freq packet-id debugging info */
+#define D_CIPHER_=
INIT      LOGLEV(4, 65, 0)        /* show messages about cipher init */
 
-=
#define D_LOG_RW LOGLEV(5, 0, 0)                    /* Print 'R' or 'W' to =
stdout for read/write */
+#define D_LOG_RW LOGLEV(5, 0, 0)                 =
  /* Print 'R' or 'W' to stdout for read/write */
 
-#define D_RTNL        =
  LOGLEV(6, 68, M_DEBUG)      /* show RTNL low level operations */
-#define=
 D_LINK_RW       LOGLEV(6, 69, M_DEBUG)      /* show TCP/UDP reads/writes (=
terse) */
-#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG)      /* show TUN/=
TAP reads/writes */
-#define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)      /*=
 show TAP-Windows driver debug info */
-#define D_CLIENT_NAT    LOGLEV(6, 6=
9, M_DEBUG)      /* show client NAT debug info */
-#define D_XKEY          =
LOGLEV(6, 69, M_DEBUG)      /* show xkey-provider debug info */
-#define D_=
DCO_DEBUG     LOGLEV(6, 69, M_DEBUG)      /* show DCO related lowlevel debu=
g messages */
-#define D_SIGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG)      /* show =
signal related debug messages */
+#define D_RTNL          LOGLEV(6, 68, M_D=
EBUG)     /* show RTNL low level operations */
+#define D_LINK_RW       LOG=
LEV(6, 69, M_DEBUG)     /* show TCP/UDP reads/writes (terse) */
+#define D_=
TUN_RW        LOGLEV(6, 69, M_DEBUG)     /* show TUN/TAP reads/writes */
+#=
define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)     /* show TAP-Windows drive=
r debug info */
+#define D_CLIENT_NAT    LOGLEV(6, 69, M_DEBUG)     /* show=
 client NAT debug info */
+#define D_XKEY          LOGLEV(6, 69, M_DEBUG)  =
   /* show xkey-provider debug info */
+#define D_DCO_DEBUG     LOGLEV(6, 6=
9, M_DEBUG)     /* show DCO related lowlevel debug messages */
+#define D_S=
IGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG)     /* show signal related debug messag=
es */
 
-#define D_SHOW_KEYS          LOGLEV(7, 70, M_DEBUG) /* show data c=
hannel encryption keys */
-#define D_SHOW_KEY_SOURCE    LOGLEV(7, 70, M_DEB=
UG) /* show data channel key source entropy */
-#define D_REL_LOW          =
  LOGLEV(7, 70, M_DEBUG) /* show low frequency info from reliable layer */
=
-#define D_FRAG_DEBUG         LOGLEV(7, 70, M_DEBUG) /* show fragment debug=
ging info */
-#define D_WIN32_IO_LOW       LOGLEV(7, 70, M_DEBUG) /* low fr=
eq win32 I/O debugging info */
-#define D_MTU_DEBUG          LOGLEV(7, 70, =
M_DEBUG) /* show MTU debugging info */
-#define D_MULTI_DEBUG        LOGLEV=
(7, 70, M_DEBUG) /* show medium-freq multi debugging info */
-#define D_MSS=
                LOGLEV(7, 70, M_DEBUG) /* show MSS adjustments */
-#define =
D_COMP_LOW           LOGLEV(7, 70, M_DEBUG) /* show adaptive compression st=
ate changes */
-#define D_CONNECTION_LIST    LOGLEV(7, 70, M_DEBUG) /* show=
 <connection> list info */
-#define D_SCRIPT             LOGLEV(7, 70, M_DE=
BUG) /* show parms & env vars passed to scripts */
-#define D_SHOW_NET     =
      LOGLEV(7, 70, M_DEBUG) /* show routing table and adapter list */
-#de=
fine D_ROUTE_DEBUG        LOGLEV(7, 70, M_DEBUG) /* show verbose route=2E[c=
h] output */
-#define D_TLS_STATE_ERRORS   LOGLEV(7, 70, M_DEBUG) /* no TLS=
 state for client */
-#define D_SEMAPHORE_LOW      LOGLEV(7, 70, M_DEBUG) /=
* show Win32 semaphore waits (low freq) */
-#define D_SEMAPHORE          LO=
GLEV(7, 70, M_DEBUG) /* show Win32 semaphore waits */
-#define D_TEST_FILE =
         LOGLEV(7, 70, M_DEBUG) /* show test_file() calls */
-#define D_MAN=
AGEMENT_DEBUG   LOGLEV(3, 70, M_DEBUG) /* show --management debug info */
-=
#define D_PLUGIN_DEBUG       LOGLEV(7, 70, M_DEBUG) /* show verbose plugin =
calls */
-#define D_SOCKET_DEBUG       LOGLEV(7, 70, M_DEBUG) /* show socke=
t=2E[ch] debugging info */
-#define D_SHOW_PKCS11        LOGLEV(7, 70, M_DE=
BUG) /* show PKCS#11 actions */
-#define D_ALIGN_DEBUG        LOGLEV(7, 70,=
 M_DEBUG) /* show verbose struct alignment info */
-#define D_PACKET_TRUNC_=
DEBUG LOGLEV(7, 70, M_DEBUG) /* PACKET_TRUNCATION_CHECK verbose */
-#define=
 D_PING               LOGLEV(7, 70, M_DEBUG) /* PING send/receive messages =
*/
-#define D_PS_PROXY_DEBUG     LOGLEV(7, 70, M_DEBUG) /* port share proxy=
 debug */
-#define D_TLS_KEYSELECT      LOGLEV(7, 70, M_DEBUG) /* show key =
selection for data channel */
-#define D_ARGV_PARSE_CMD     LOGLEV(7, 70, M=
_DEBUG) /* show parse_line() errors in argv_parse_cmd */
-#define D_CRYPTO_=
DEBUG       LOGLEV(7, 70, M_DEBUG) /* show detailed info from crypto=2Ec ro=
utines */
-#define D_PID_DEBUG          LOGLEV(7, 70, M_DEBUG) /* show pack=
et-id debugging info */
-#define D_PUSH_DEBUG         LOGLEV(7, 73, M_DEBUG=
) /* show push/pull debugging info */
-#define D_SHOW_OCC           LOGLEV(=
7, 74, M_DEBUG) /* show options compatibility string */
+#define D_SHOW_KEY=
S        LOGLEV(7, 70, M_DEBUG)  /* show data channel encryption keys */
+#=
define D_SHOW_KEY_SOURCE  LOGLEV(7, 70, M_DEBUG)  /* show data channel key =
source entropy */
+#define D_REL_LOW          LOGLEV(7, 70, M_DEBUG)  /* sh=
ow low frequency info from reliable layer */
+#define D_FRAG_DEBUG       LO=
GLEV(7, 70, M_DEBUG)  /* show fragment debugging info */
+#define D_WIN32_I=
O_LOW     LOGLEV(7, 70, M_DEBUG)  /* low freq win32 I/O debugging info */
+=
#define D_MTU_DEBUG        LOGLEV(7, 70, M_DEBUG)  /* show MTU debugging in=
fo */
+#define D_MULTI_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show medium-fr=
eq multi debugging info */
+#define D_MSS              LOGLEV(7, 70, M_DEBU=
G)  /* show MSS adjustments */
+#define D_COMP_LOW         LOGLEV(7, 70, M_=
DEBUG)  /* show adaptive compression state changes */
+#define D_CONNECTION=
_LIST  LOGLEV(7, 70, M_DEBUG)  /* show <connection> list info */
+#define D=
_SCRIPT           LOGLEV(7, 70, M_DEBUG)  /* show parms & env vars passed t=
o scripts */
+#define D_SHOW_NET         LOGLEV(7, 70, M_DEBUG)  /* show ro=
uting table and adapter list */
+#define D_ROUTE_DEBUG      LOGLEV(7, 70, M=
_DEBUG)  /* show verbose route=2E[ch] output */
+#define D_TLS_STATE_ERRORS=
 LOGLEV(7, 70, M_DEBUG)  /* no TLS state for client */
+#define D_SEMAPHORE=
_LOW    LOGLEV(7, 70, M_DEBUG)  /* show Win32 semaphore waits (low freq) */=

+#define D_SEMAPHORE        LOGLEV(7, 70, M_DEBUG)  /* show Win32 semaphor=
e waits */
+#define D_TEST_FILE        LOGLEV(7, 70, M_DEBUG)  /* show test=
_file() calls */
+#define D_MANAGEMENT_DEBUG LOGLEV(3, 70, M_DEBUG)  /* sho=
w --management debug info */
+#define D_PLUGIN_DEBUG     LOGLEV(7, 70, M_DE=
BUG)  /* show verbose plugin calls */
+#define D_SOCKET_DEBUG     LOGLEV(7,=
 70, M_DEBUG)  /* show socket=2E[ch] debugging info */
+#define D_SHOW_PKCS=
11      LOGLEV(7, 70, M_DEBUG)  /* show PKCS#11 actions */
+#define D_ALIGN=
_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show verbose struct alignment info *=
/
+#define D_PING             LOGLEV(7, 70, M_DEBUG)  /* PING send/receive =
messages */
+#define D_PS_PROXY_DEBUG   LOGLEV(7, 70, M_DEBUG)  /* port sha=
re proxy debug */
+#define D_TLS_KEYSELECT    LOGLEV(7, 70, M_DEBUG)  /* sh=
ow key selection for data channel */
+#define D_ARGV_PARSE_CMD   LOGLEV(7, =
70, M_DEBUG)  /* show parse_line() errors in argv_parse_cmd */
+#define D_C=
RYPTO_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* show detailed info from crypto=
=2Ec routines */
+#define D_PID_DEBUG        LOGLEV(7, 70, M_DEBUG)  /* sho=
w packet-id debugging info */
+#define D_PUSH_DEBUG       LOGLEV(7, 73, M_D=
EBUG)  /* show push/pull debugging info */
+#define D_SHOW_OCC         LOGL=
EV(7, 74, M_DEBUG)  /* show options compatibility string */
 
 
 #define D_=
VLAN_DEBUG LOGLEV(7, 74, M_DEBUG)             /* show VLAN tagging/untaggin=
g debug info */
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=
=2Ec
index eb41d03=2E=2E82cb6c9 100644
--- a/src/openvpn/forward=2Ec
+++ b/=
src/openvpn/forward=2Ec
@@ -1164,12 +1164,6 @@
         }
 #endif
 
-#ifdef=
 PACKET_TRUNCATION_CHECK
-        /* if (c->c2=2Ebuf=2Elen > 1) --c->c2=2Eb=
uf=2Elen; */
-        ipv4_packet_size_verify(BPTR(&c->c2=2Ebuf), BLEN(&c->=
c2=2Ebuf), TUNNEL_TYPE(c->c1=2Etuntap),
-                                "P=
OST_DECRYPT", &c->c2=2En_trunc_post_decrypt);
-#endif
-
         /*
       =
   * Set our "official" outgoing address, since
          * if buf=2Elen is=
 non-zero, we know the packet
@@ -1352,11 +1346,6 @@
     }
 #endif /* ifde=
f _WIN32 */
 
-#ifdef PACKET_TRUNCATION_CHECK
-    ipv4_packet_size_verify(=
BPTR(&c->c2=2Ebuf), BLEN(&c->c2=2Ebuf), TUNNEL_TYPE(c->c1=2Etuntap),
-     =
                       "READ_TUN", &c->c2=2En_trunc_tun_read);
-#endif
-
  =
   /* Was TUN/TAP interface stopped? */
     if (tuntap_stop(c->c2=2Ebuf=2E=
len))
     {
@@ -1532,12 +1521,6 @@
         unsigned int flags =3D
       =
      PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT | PIPV6_ICMP_NOHOST_CLI=
ENT;
         process_ip_header(c, flags, &c->c2=2Ebuf, out_sock);
-
-#ifde=
f PACKET_TRUNCATION_CHECK
-        /* if (c->c2=2Ebuf=2Elen > 1) --c->c2=2E=
buf=2Elen; */
-        ipv4_packet_size_verify(BPTR(&c->c2=2Ebuf), BLEN(&c-=
>c2=2Ebuf), TUNNEL_TYPE(c->c1=2Etuntap),
-                                "=
PRE_ENCRYPT", &c->c2=2En_trunc_pre_encrypt);
-#endif
     }
     if (c->c2=
=2Ebuf=2Elen > 0)
     {
@@ -1937,11 +1920,6 @@
 #endif
         dmsg(D_TUN=
_RW, "TUN WRITE [%d]", BLEN(&c->c2=2Eto_tun));
 
-#ifdef PACKET_TRUNCATION_=
CHECK
-        ipv4_packet_size_verify(BPTR(&c->c2=2Eto_tun), BLEN(&c->c2=
=2Eto_tun), TUNNEL_TYPE(c->c1=2Etuntap),
-                                "=
WRITE_TUN", &c->c2=2En_trunc_tun_write);
-#endif
-
 #ifdef _WIN32
         =
size =3D tun_write_win32(c->c1=2Etuntap, &c->c2=2Eto_tun);
 #else
diff --gi=
t a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 77ebfae=2E=2E03844f=
b 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -981,31=
 +981,6 @@
         status_printf(so, "ERROR: bad status format version num=
ber");
     }
 
-#ifdef PACKET_TRUNCATION_CHECK
-    {
-        status_prin=
tf(so, "HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encryp=
t Trunc,Post-decrypt Trunc");
-        hash_iterator_init(m->hash, &hi);
- =
       while ((he =3D hash_iterator_next(&hi)))
-        {
-            str=
uct gc_arena gc =3D gc_new();
-            const struct multi_instance *mi =
=3D (struct multi_instance *)he->value;
-
-            if (!mi->halt)
-    =
        {
-                status_printf(so,
-                             =
 "ERRORS,%s," counter_format "," counter_format "," counter_format
-       =
                       "," counter_format,
-                              t=
ls_common_name(mi->context=2Ec2=2Etls_multi, false),
-                     =
         m->top=2Ec2=2En_trunc_tun_read, mi->context=2Ec2=2En_trunc_tun_wri=
te,
-                              mi->context=2Ec2=2En_trunc_pre_encrypt,
=
-                              mi->context=2Ec2=2En_trunc_post_decrypt);
- =
           }
-            gc_free(&gc);
-        }
-        hash_iterator_f=
ree(&hi);
-    }
-#endif /* ifdef PACKET_TRUNCATION_CHECK */
-
     status_=
flush(so);
     gc_free(&gc_top);
 
diff --git a/src/openvpn/openvpn=2Eh b/=
src/openvpn/openvpn=2Eh
index cdd02b6=2E=2E970baa9 100644
--- a/src/openvpn=
/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -269,12 +269,6 @@
     counte=
r_type link_read_bytes_auth;
     counter_type link_write_bytes;
     count=
er_type dco_write_bytes;
-#ifdef PACKET_TRUNCATION_CHECK
-    counter_type =
n_trunc_tun_read;
-    counter_type n_trunc_tun_write;
-    counter_type n_=
trunc_pre_encrypt;
-    counter_type n_trunc_post_decrypt;
-#endif
 
     /=
*
      * Timer objects for ping and inactivity
diff --git a/src/openvpn/pr=
oto=2Ec b/src/openvpn/proto=2Ec
index 2cdb147=2E=2Ea2b07df 100644
--- a/src=
/openvpn/proto=2Ec
+++ b/src/openvpn/proto=2Ec
@@ -163,52 +163,3 @@
     /*=
 Take the one's complement of sum */
     return ((uint16_t)~sum);
 }
-
-#i=
fdef PACKET_TRUNCATION_CHECK
-
-void
-ipv4_packet_size_verify(const uint8_t=
 *data, const int size, const int tunnel_type,
-                        con=
st char *prefix, counter_type *errors)
-{
-    if (size > 0)
-    {
-      =
  struct buffer buf;
-
-        buf_set_read(&buf, data, size);
-
-        =
if (is_ipv4(tunnel_type, &buf))
-        {
-            const struct openvp=
n_iphdr *pip;
-            int hlen;
-            int totlen;
-            =
const char *msgstr =3D "PACKET SIZE INFO";
-            msglvl_t msglevel =
=3D D_PACKET_TRUNC_DEBUG;
-
-            if (BLENZ(&buf) < sizeof(struct op=
envpn_iphdr))
-            {
-                return;
-            }
-
-   =
         verify_align_4(&buf);
-            pip =3D (struct openvpn_iphdr *=
)BPTR(&buf);
-
-            hlen =3D OPENVPN_IPH_GET_LEN(pip->version_len);=

-            totlen =3D ntohs(pip->tot_len);
-
-            if (BLEN(&buf)=
 !=3D totlen)
-            {
-                msgstr =3D "PACKET TRUNCATION=
 ERROR";
-                msglevel =3D D_PACKET_TRUNC_ERR;
-               =
 if (errors)
-                {
-                    ++(*errors);
-        =
        }
-            }
-
-            msg(msglevel, "%s %s: size=3D%d tot=
len=3D%d hlen=3D%d errcount=3D" counter_format, msgstr,
-                pr=
efix, BLEN(&buf), totlen, hlen, errors ? *errors : (counter_type)0);
-     =
   }
-    }
-}
-
-#endif /* ifdef PACKET_TRUNCATION_CHECK */
diff --git a/s=
rc/openvpn/proto=2Eh b/src/openvpn/proto=2Eh
index 1665751=2E=2E14f9264 100=
644
--- a/src/openvpn/proto=2Eh
+++ b/src/openvpn/proto=2Eh
@@ -307,11 +307=
,6 @@
 uint16_t ip_checksum(const sa_family_t af, const uint8_t *payload, c=
onst int len_payload,
                      const uint8_t *src_addr, const =
uint8_t *dest_addr, const int proto);
 
-#ifdef PACKET_TRUNCATION_CHECK
-vo=
id ipv4_packet_size_verify(const uint8_t *data, const int size, const int t=
unnel_type,
-                             const char *prefix, counter_type =
*errors);
-
-#endif
 
 #define OPENVPN_8021Q_MIN_VID 1
 #define OPENVPN_802=
1Q_MAX_VID 4094
diff --git a/src/openvpn/sig=2Ec b/src/openvpn/sig=2Ec
inde=
x 81654f9=2E=2E0cdb01a 100644
--- a/src/openvpn/sig=2Ec
+++ b/src/openvpn/s=
ig=2Ec
@@ -504,12 +504,6 @@
         comp_print_stats(c->c2=2Ecomp_context,=
 so);
     }
 #endif
-#ifdef PACKET_TRUNCATION_CHECK
-    status_printf(so,=
 "TUN read truncations," counter_format, c->c2=2En_trunc_tun_read);
-    st=
atus_printf(so, "TUN write truncations," counter_format, c->c2=2En_trunc_tu=
n_write);
-    status_printf(so, "Pre-encrypt truncations," counter_format,=
 c->c2=2En_trunc_pre_encrypt);
-    status_printf(so, "Post-decrypt truncat=
ions," counter_format, c->c2=2En_trunc_post_decrypt);
-#endif
 #ifdef _WIN3=
2
     if (tuntap_defined(c->c1=2Etuntap))
     {

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2071?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I61a0d15962584bc48cae459062fead08dc425aeb
Ger=
rit-Change-Number: 2071
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--VQHSSBwJuXA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2071?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Remove PACKET_TRUNCATION_CHECK<br>=
<br>This functionality checks if packets might be truncated by checking<br>=
the length of the IPv4 header against the length of the buffer to<br>see if=
 a packet is truncated=2E<br><br>This function has been undocumented and ca=
n be only enabled by<br>manually defining this define=2E<br><br>This might =
have been useful in 2005 when this function was added<br>but currently is r=
ather dead code that can a diagnose a problem<br>that is extremely rare or =
has been already been fixed outside of<br>OpenVPN=2E<br><br>Change-Id: I61a=
0d15962584bc48cae459062fead08dc425aeb<br>Signed-off-by: Arne Schwabe &lt;ar=
ne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2071<br>Mess=
age-Id: &lt;20261031190839=2E30023-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4=
0382=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/openvpn/errlevel=2Eh<br>M src/openvpn/forward=2Ec<br>M src/=
openvpn/multi=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/proto=2Ec<b=
r>M src/openvpn/proto=2Eh<br>M src/openvpn/sig=2Ec<br>7 files changed, 89 i=
nsertions(+), 204 deletions(-)<br><br></pre>
<pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/er=
rlevel=2Eh b/src/openvpn/errlevel=2Eh</span><br><span>index d79efbb=2E=2Ee5=
2cb65 100644</span><br><span>--- a/src/openvpn/errlevel=2Eh</span><br><span=
>+++ b/src/openvpn/errlevel=2Eh</span><br><span>@@ -49,105 +49,103 @@</span=
><br><span>  * of output=2E</span><br><span>  */</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define M_VERB0 LOGLEV(0, 0, 0=
)                     /* Messages displayed even at --verb 0 (fatal errors =
only) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define M_V=
ERB0 LOGLEV(0, 0, 0)                    /* Messages displayed even at --ver=
b 0 (fatal errors only) */</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define M_INFO LOGLEV(1, 0, 0)                      =
/* default informational messages */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define M_INFO LOGLEV(1, 0, 0)                     /* defa=
ult informational messages */</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define D_LINK_ERRORS    LOGLEV(1, 1, M_NONFATAL)=
   /* show link errors from main event loop */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define D_CRYPT_ERRORS   LOGLEV(1, 2, M_NONFATAL) =
  /* show errors from encrypt/decrypt */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define D_TLS_ERRORS     LOGLEV(1, 3, M_NONFATAL)   /* s=
how TLS control channel errors */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL)   /* show hos=
tname resolve errors */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)   /* show compression e=
rrors */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_REP=
LAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)   /* show packet replay errors */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_STREAM_ERRORS  L=
OGLEV(1, 7, M_NONFATAL)   /* TCP stream error requiring restart */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define D_IMPORT_ERRORS  LOGLE=
V(1, 8, M_NONFATAL)   /* show server import option errors */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define D_MULTI_ERRORS   LOGLEV(1, 9=
, M_NONFATAL)   /* show multi-client server errors */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_EVENT_ERRORS   LOGLEV(1, 10, M_NO=
NFATAL)  /* show event=2E[ch] errors */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL)  /* sh=
ow push/pull errors */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL)  /* show packet_id pers=
ist errors */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL)  /* show fragmentation errors */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_ALIGN_ERROR=
S   LOGLEV(1, 14, M_NONFATAL)  /* show bad struct alignments */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define D_LINK_ERRORS    LOGLEV=
(1, 1, M_NONFATAL)  /* show link errors from main event loop */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define D_CRYPT_ERRORS   LOGLEV=
(1, 2, M_NONFATAL)  /* show errors from encrypt/decrypt */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define D_TLS_ERRORS     LOGLEV(1, 3=
, M_NONFATAL)  /* show TLS control channel errors */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_N=
ONFATAL)  /* show hostname resolve errors */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL) =
 /* show compression errors */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define D_REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)  /* show packe=
t replay errors */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define D_STREAM_ERRORS  LOGLEV(1, 7, M_NONFATAL)  /* TCP stream error requi=
ring restart */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)  /* show server import option=
 errors */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D=
_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)  /* show multi-client server error=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_EVENT=
_ERRORS   LOGLEV(1, 10, M_NONFATAL) /* show event=2E[ch] errors */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PUSH_ERRORS    LOG=
LEV(1, 11, M_NONFATAL) /* show push/pull errors */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define D_PID_PERSIST    LOGLEV(1, 12, M_NON=
FATAL) /* show packet_id persist errors */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL) /=
* show fragmentation errors */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL) /* show bad s=
truct alignments */</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define D_HANDSHAKE LOGLEV(2, 20, 0)                /* show=
 data &amp; control channel handshakes */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define D_CLOSE     LOGLEV(2, 22, 0)                /* =
show socket and TUN/TAP close */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define D_PROXY     LOGLEV(2, 24, 0)                /* show http=
 proxy control packets */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define D_ARGV      LOGLEV(2, 25, 0)                /* show struct argv=
 errors */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D=
_HANDSHAKE LOGLEV(2, 20, 0)               /* show data &amp; control channe=
l handshakes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine D_CLOSE     LOGLEV(2, 22, 0)               /* show socket and TUN/TAP c=
lose */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PR=
OXY     LOGLEV(2, 24, 0)               /* show http proxy control packets *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_ARGV    =
  LOGLEV(2, 25, 0)               /* show struct argv errors */</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TLS_DE=
BUG_LOW LOGLEV(3, 20, 0)            /* low frequency info from tls_session =
routines */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_=
GREMLIN       LOGLEV(3, 30, 0)            /* show simulated outage info fro=
m gremlin module */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine D_GENKEY        LOGLEV(3, 31, 0)            /* print message after ke=
y generation */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e D_ROUTE         LOGLEV(3, 0, 0)             /* show routes added and dele=
ted (don&#39;t mute) */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define D_TUNTAP_INFO   LOGLEV(3, 32, 0)            /* show debugging inf=
o from TUN/TAP driver */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define D_RESTART       LOGLEV(3, 33, 0)            /* show certain rest=
art messages */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e D_PUSH          LOGLEV(3, 34, 0)            /* show push/pull info */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_IFCONFIG_POOL L=
OGLEV(3, 35, 0)            /* show ifconfig pool info */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define D_AUTH          LOGLEV(3, 37, 0)=
            /* show user/pass auth info */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define D_MULTI_LOW     LOGLEV(3, 38, 0)            /*=
 show point-to-multipoint low-freq debug info */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define D_PLUGIN        LOGLEV(3, 39, 0)        =
    /* show plugin calls */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define D_MANAGEMENT    LOGLEV(3, 40, 0)            /* show --managem=
ent info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_=
SCHED_EXIT    LOGLEV(3, 41, 0)            /* show arming of scheduled exit =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_ROUTE_QUO=
TA   LOGLEV(3, 42, 0)            /* show route quota exceeded messages */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_OSBUF        =
 LOGLEV(3, 43, 0)            /* show socket/tun/tap buffer sizes */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PS_PROXY      LOGLE=
V(3, 44, 0)            /* messages related to --port-share option */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_IFCONFIG      LOGL=
EV(3, 0, 0)             /* show ifconfig info (don&#39;t mute) */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define D_DCO           LOGLEV(=
3, 0, 0)             /* show DCO related messages */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0) =
          /* low frequency info from tls_session routines */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define D_GREMLIN       LOGLEV(3, =
30, 0)           /* show simulated outage info from gremlin module */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_GENKEY        L=
OGLEV(3, 31, 0)           /* print message after key generation */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define D_ROUTE         LOGL=
EV(3, 0, 0)            /* show routes added and deleted (don&#39;t mute) */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_TUNTAP_IN=
FO   LOGLEV(3, 32, 0)           /* show debugging info from TUN/TAP driver =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_RESTART=
       LOGLEV(3, 33, 0)           /* show certain restart messages */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PUSH          L=
OGLEV(3, 34, 0)           /* show push/pull info */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_IFCONFIG_POOL LOGLEV(3, 35, 0) =
          /* show ifconfig pool info */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define D_AUTH          LOGLEV(3, 37, 0)           /* s=
how user/pass auth info */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define D_MULTI_LOW     LOGLEV(3, 38, 0)           /* show point-to-=
multipoint low-freq debug info */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define D_PLUGIN        LOGLEV(3, 39, 0)           /* show pl=
ugin calls */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e D_MANAGEMENT    LOGLEV(3, 40, 0)           /* show --management info */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_SCHED_EXIT =
   LOGLEV(3, 41, 0)           /* show arming of scheduled exit */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define D_ROUTE_QUOTA   LOGLE=
V(3, 42, 0)           /* show route quota exceeded messages */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define D_OSBUF         LOGLEV(3=
, 43, 0)           /* show socket/tun/tap buffer sizes */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define D_PS_PROXY      LOGLEV(3, 44,=
 0)           /* messages related to --port-share option */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define D_IFCONFIG      LOGLEV(3, 0=
, 0)            /* show ifconfig info (don&#39;t mute) */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define D_DCO           LOGLEV(3, 0, =
0)            /* show DCO related messages */</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define D_SHOW_PARMS       LOGLEV=
(4, 50, 0)         /* show all parameters on program initiation */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define D_LOW              LOG=
LEV(4, 52, 0)         /* miscellaneous low-frequency debug info */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define D_DHCP_OPT         LOG=
LEV(4, 53, 0)         /* show DHCP options binary string */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define D_MBUF             LOGLEV(4, =
54, 0)         /* mbuf=2E[ch] routines */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define D_PACKET_TRUNC_ERR LOGLEV(4, 55, 0)         /* =
PACKET_TRUNCATION_CHECK */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define D_MULTI_DROPPED    LOGLEV(4, 57, 0)         /* show point-to-m=
ultipoint packet drops */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)         /* show medium freq=
uency multi messages */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define D_X509_ATTR        LOGLEV(4, 59, 0)         /* show x509-track at=
tributes on connection */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define D_INIT_MEDIUM      LOGLEV(4, 60, 0)         /* show medium freq=
uency init messages */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define D_MTU_INFO         LOGLEV(4, 61, 0)         /* show terse MTU info=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PID_DEBU=
G_LOW    LOGLEV(4, 63, 0)         /* show low-freq packet-id debugging info=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PID_DEBU=
G_MEDIUM LOGLEV(4, 64, 0)         /* show medium-freq packet-id debugging i=
nfo */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_CIPHE=
R_INIT      LOGLEV(4, 65, 0)         /* show messages about cipher init */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_SHOW_PARMS=
       LOGLEV(4, 50, 0)        /* show all parameters on program initiation=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_LOW   =
           LOGLEV(4, 52, 0)        /* miscellaneous low-frequency debug inf=
o */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_DHCP_=
OPT         LOGLEV(4, 53, 0)        /* show DHCP options binary string */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_MBUF       =
      LOGLEV(4, 54, 0)        /* mbuf=2E[ch] routines */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define D_MULTI_DROPPED    LOGLEV(4, 5=
7, 0)        /* show point-to-multipoint packet drops */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define D_MULTI_MEDIUM     LOGLEV(4, 5=
8, 0)        /* show medium frequency multi messages */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define D_X509_ATTR        LOGLEV(4, 59=
, 0)        /* show x509-track attributes on connection */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define D_INIT_MEDIUM      LOGLEV(4,=
 60, 0)        /* show medium frequency init messages */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define D_MTU_INFO         LOGLEV(4, 6=
1, 0)        /* show terse MTU info */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)        /* sh=
ow low-freq packet-id debugging info */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0)        /* s=
how medium-freq packet-id debugging info */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define D_CIPHER_INIT      LOGLEV(4, 65, 0)        =
/* show messages about cipher init */</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define D_LOG_RW LOGLEV(5, 0, 0)         =
           /* Print &#39;R&#39; or &#39;W&#39; to stdout for read/write */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_LOG_RW LOG=
LEV(5, 0, 0)                   /* Print &#39;R&#39; or &#39;W&#39; to stdou=
t for read/write */</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define D_RTNL          LOGLEV(6, 68, M_DEBUG)      /* show=
 RTNL low level operations */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define D_LINK_RW       LOGLEV(6, 69, M_DEBUG)      /* show TCP/UDP=
 reads/writes (terse) */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG)      /* show TUN/TAP read=
s/writes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_=
TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)      /* show TAP-Windows driver debug =
info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_CLIE=
NT_NAT    LOGLEV(6, 69, M_DEBUG)      /* show client NAT debug info */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_XKEY          LO=
GLEV(6, 69, M_DEBUG)      /* show xkey-provider debug info */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define D_DCO_DEBUG     LOGLEV(6, 6=
9, M_DEBUG)      /* show DCO related lowlevel debug messages */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define D_SIGNAL_DEBUG  LOGLEV(6,=
 69, M_DEBUG)      /* show signal related debug messages */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define D_RTNL          LOGLEV(6, 6=
8, M_DEBUG)     /* show RTNL low level operations */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define D_LINK_RW       LOGLEV(6, 69, M_D=
EBUG)     /* show TCP/UDP reads/writes (terse) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG=
)     /* show TUN/TAP reads/writes */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)     /* sho=
w TAP-Windows driver debug info */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define D_CLIENT_NAT    LOGLEV(6, 69, M_DEBUG)     /* show c=
lient NAT debug info */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define D_XKEY          LOGLEV(6, 69, M_DEBUG)     /* show xkey-provide=
r debug info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine D_DCO_DEBUG     LOGLEV(6, 69, M_DEBUG)     /* show DCO related lowlevel=
 debug messages */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define D_SIGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG)     /* show signal related de=
bug messages */</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define D_SHOW_KEYS          LOGLEV(7, 70, M_DEBUG) /* show dat=
a channel encryption keys */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define D_SHOW_KEY_SOURCE    LOGLEV(7, 70, M_DEBUG) /* show data cha=
nnel key source entropy */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define D_REL_LOW            LOGLEV(7, 70, M_DEBUG) /* show low freque=
ncy info from reliable layer */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define D_FRAG_DEBUG         LOGLEV(7, 70, M_DEBUG) /* show fragm=
ent debugging info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define D_WIN32_IO_LOW       LOGLEV(7, 70, M_DEBUG) /* low freq win32 I/O d=
ebugging info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne D_MTU_DEBUG          LOGLEV(7, 70, M_DEBUG) /* show MTU debugging info *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_MULTI_DEBU=
G        LOGLEV(7, 70, M_DEBUG) /* show medium-freq multi debugging info */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_MSS        =
        LOGLEV(7, 70, M_DEBUG) /* show MSS adjustments */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define D_COMP_LOW           LOGLEV(7, =
70, M_DEBUG) /* show adaptive compression state changes */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define D_CONNECTION_LIST    LOGLEV(7,=
 70, M_DEBUG) /* show &lt;connection&gt; list info */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_SCRIPT             LOGLEV(7, 70, =
M_DEBUG) /* show parms &amp; env vars passed to scripts */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define D_SHOW_NET           LOGLEV(7,=
 70, M_DEBUG) /* show routing table and adapter list */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define D_ROUTE_DEBUG        LOGLEV(7, 70=
, M_DEBUG) /* show verbose route=2E[ch] output */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define D_TLS_STATE_ERRORS   LOGLEV(7, 70, M_DE=
BUG) /* no TLS state for client */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define D_SEMAPHORE_LOW      LOGLEV(7, 70, M_DEBUG) /* show Wi=
n32 semaphore waits (low freq) */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define D_SEMAPHORE          LOGLEV(7, 70, M_DEBUG) /* show Win=
32 semaphore waits */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define D_TEST_FILE          LOGLEV(7, 70, M_DEBUG) /* show test_file() cal=
ls */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_MANAGE=
MENT_DEBUG   LOGLEV(3, 70, M_DEBUG) /* show --management debug info */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PLUGIN_DEBUG    =
   LOGLEV(7, 70, M_DEBUG) /* show verbose plugin calls */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define D_SOCKET_DEBUG       LOGLEV(7, =
70, M_DEBUG) /* show socket=2E[ch] debugging info */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_SHOW_PKCS11        LOGLEV(7, 70, =
M_DEBUG) /* show PKCS#11 actions */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define D_ALIGN_DEBUG        LOGLEV(7, 70, M_DEBUG) /* show v=
erbose struct alignment info */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define D_PACKET_TRUNC_DEBUG LOGLEV(7, 70, M_DEBUG) /* PACKET_TRU=
NCATION_CHECK verbose */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define D_PING               LOGLEV(7, 70, M_DEBUG) /* PING send/receive=
 messages */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D=
_PS_PROXY_DEBUG     LOGLEV(7, 70, M_DEBUG) /* port share proxy debug */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TLS_KEYSELECT  =
    LOGLEV(7, 70, M_DEBUG) /* show key selection for data channel */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_ARGV_PARSE_CMD    =
 LOGLEV(7, 70, M_DEBUG) /* show parse_line() errors in argv_parse_cmd */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_CRYPTO_DEBUG  =
     LOGLEV(7, 70, M_DEBUG) /* show detailed info from crypto=2Ec routines =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PID_DEBUG=
          LOGLEV(7, 70, M_DEBUG) /* show packet-id debugging info */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PUSH_DEBUG        =
 LOGLEV(7, 73, M_DEBUG) /* show push/pull debugging info */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define D_SHOW_OCC           LOGLEV(7=
, 74, M_DEBUG) /* show options compatibility string */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define D_SHOW_KEYS        LOGLEV(7, 70,=
 M_DEBUG)  /* show data channel encryption keys */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define D_SHOW_KEY_SOURCE  LOGLEV(7, 70, M_D=
EBUG)  /* show data channel key source entropy */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define D_REL_LOW          LOGLEV(7, 70, M_DE=
BUG)  /* show low frequency info from reliable layer */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define D_FRAG_DEBUG       LOGLEV(7, 70=
, M_DEBUG)  /* show fragment debugging info */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define D_WIN32_IO_LOW     LOGLEV(7, 70, M_DEBUG=
)  /* low freq win32 I/O debugging info */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define D_MTU_DEBUG        LOGLEV(7, 70, M_DEBUG)  /=
* show MTU debugging info */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define D_MULTI_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show medium-=
freq multi debugging info */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define D_MSS              LOGLEV(7, 70, M_DEBUG)  /* show MSS adj=
ustments */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
D_COMP_LOW         LOGLEV(7, 70, M_DEBUG)  /* show adaptive compression sta=
te changes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e D_CONNECTION_LIST  LOGLEV(7, 70, M_DEBUG)  /* show &lt;connection&gt; lis=
t info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_=
SCRIPT           LOGLEV(7, 70, M_DEBUG)  /* show parms &amp; env vars passe=
d to scripts */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine D_SHOW_NET         LOGLEV(7, 70, M_DEBUG)  /* show routing table and ad=
apter list */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e D_ROUTE_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show verbose route=2E[ch] o=
utput */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_T=
LS_STATE_ERRORS LOGLEV(7, 70, M_DEBUG)  /* no TLS state for client */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_SEMAPHORE_LOW  =
  LOGLEV(7, 70, M_DEBUG)  /* show Win32 semaphore waits (low freq) */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_SEMAPHORE      =
  LOGLEV(7, 70, M_DEBUG)  /* show Win32 semaphore waits */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define D_TEST_FILE        LOGLEV(7,=
 70, M_DEBUG)  /* show test_file() calls */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define D_MANAGEMENT_DEBUG LOGLEV(3, 70, M_DEBUG)  =
/* show --management debug info */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define D_PLUGIN_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* show v=
erbose plugin calls */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define D_SOCKET_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* show socket=2E[ch]=
 debugging info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define D_SHOW_PKCS11      LOGLEV(7, 70, M_DEBUG)  /* show PKCS#11 actions *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_ALIGN_DE=
BUG      LOGLEV(7, 70, M_DEBUG)  /* show verbose struct alignment info */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PING       =
      LOGLEV(7, 70, M_DEBUG)  /* PING send/receive messages */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define D_PS_PROXY_DEBUG   LOGLE=
V(7, 70, M_DEBUG)  /* port share proxy debug */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define D_TLS_KEYSELECT    LOGLEV(7, 70, M_DEBU=
G)  /* show key selection for data channel */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define D_ARGV_PARSE_CMD   LOGLEV(7, 70, M_DEBUG)=
  /* show parse_line() errors in argv_parse_cmd */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define D_CRYPTO_DEBUG     LOGLEV(7, 70, M_D=
EBUG)  /* show detailed info from crypto=2Ec routines */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define D_PID_DEBUG        LOGLEV(7, 7=
0, M_DEBUG)  /* show packet-id debugging info */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define D_PUSH_DEBUG       LOGLEV(7, 73, M_DEB=
UG)  /* show push/pull debugging info */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define D_SHOW_OCC         LOGLEV(7, 74, M_DEBUG)  /* =
show options compatibility string */</span><br><span> </span><br><span> </s=
pan><br><span> #define D_VLAN_DEBUG LOGLEV(7, 74, M_DEBUG)             /* s=
how VLAN tagging/untagging debug info */</span><br><span>diff --git a/src/o=
penvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index eb41d03=
=2E=2E82cb6c9 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><b=
r><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -1164,12 +1164,6 @=
@</span><br><span>         }</span><br><span> #endif</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef PACKET_TRUNCATION_C=
HECK</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* if (c-=
&gt;c2=2Ebuf=2Elen &gt; 1) --c-&gt;c2=2Ebuf=2Elen; */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ipv4_packet_size_verify(BPTR(&amp;c=
-&gt;c2=2Ebuf), BLEN(&amp;c-&gt;c2=2Ebuf), TUNNEL_TYPE(c-&gt;c1=2Etuntap),<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
          &quot;POST_DECRYPT&quot;, &amp;c-&gt;c2=2En_trunc_post_decrypt);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /*</span><b=
r><span>          * Set our &quot;official&quot; outgoing address, since</s=
pan><br><span>          * if buf=2Elen is non-zero, we know the packet</spa=
n><br><span>@@ -1352,11 +1346,6 @@</span><br><span>     }</span><br><span> =
#endif /* ifdef _WIN32 */</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef PACKET_TRUNCATION_CHECK</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ipv4_packet_size_verify(BPTR(&amp;c-&gt=
;c2=2Ebuf), BLEN(&amp;c-&gt;c2=2Ebuf), TUNNEL_TYPE(c-&gt;c1=2Etuntap),</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
  &quot;READ_TUN&quot;, &amp;c-&gt;c2=2En_trunc_tun_read);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span>     /* Was TUN/TAP interface stoppe=
d? */</span><br><span>     if (tuntap_stop(c-&gt;c2=2Ebuf=2Elen))</span><br=
><span>     {</span><br><span>@@ -1532,12 +1521,6 @@</span><br><span>      =
   unsigned int flags =3D</span><br><span>             PIPV4_PASSTOS | PIP_=
MSSFIX | PIPV4_CLIENT_NAT | PIPV6_ICMP_NOHOST_CLIENT;</span><br><span>     =
    process_ip_header(c, flags, &amp;c-&gt;c2=2Ebuf, out_sock);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#ifdef PACKET_TRUNCATION_CHECK</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* if (c-&gt;c2=2Ebuf=2Elen &gt; 1)=
 --c-&gt;c2=2Ebuf=2Elen; */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        ipv4_packet_size_verify(BPTR(&amp;c-&gt;c2=2Ebuf), BLEN(&amp;=
c-&gt;c2=2Ebuf), TUNNEL_TYPE(c-&gt;c1=2Etuntap),</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                &quot;PRE_ENCRYP=
T&quot;, &amp;c-&gt;c2=2En_trunc_pre_encrypt);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span>     }</span><br><span>    =
 if (c-&gt;c2=2Ebuf=2Elen &gt; 0)</span><br><span>     {</span><br><span>@@=
 -1937,11 +1920,6 @@</span><br><span> #endif</span><br><span>         dmsg(=
D_TUN_RW, &quot;TUN WRITE [%d]&quot;, BLEN(&amp;c-&gt;c2=2Eto_tun));</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef PAC=
KET_TRUNCATION_CHECK</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       ipv4_packet_size_verify(BPTR(&amp;c-&gt;c2=2Eto_tun), BLEN(&amp;c-&g=
t;c2=2Eto_tun), TUNNEL_TYPE(c-&gt;c1=2Etuntap),</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                &quot;WRITE_TUN&q=
uot;, &amp;c-&gt;c2=2En_trunc_tun_write);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> #ifdef _WIN32</span><br><span>         size =3D tun_=
write_win32(c-&gt;c1=2Etuntap, &amp;c-&gt;c2=2Eto_tun);</span><br><span> #e=
lse</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index 77ebfae=2E=2E03844fb 100644</span><br><span>--- =
a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><=
br><span>@@ -981,31 +981,6 @@</span><br><span>         status_printf(so, &q=
uot;ERROR: bad status format version number&quot;);</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef PACKET_TRUNCATION_CHECK</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sta=
tus_printf(so, &quot;HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Tru=
nc,Pre-encrypt Trunc,Post-decrypt Trunc&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        hash_iterator_init(m-&gt;hash, &amp;hi);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        while ((he =3D=
 hash_iterator_next(&amp;hi)))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            const struct multi_instance *mi =3D (struct=
 multi_instance *)he-&gt;value;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (!mi-&gt;halt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     status_printf(so,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                              &quot;ERRORS,%s,&quot; counter_format &quot;=
,&quot; counter_format &quot;,&quot; counter_format</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                              &quot;,&quot;=
 counter_format,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                         tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, f=
alse),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
               m-&gt;top=2Ec2=2En_trunc_tun_read, mi-&gt;context=2Ec2=2En_t=
runc_tun_write,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                        mi-&gt;context=2Ec2=2En_trunc_pre_encrypt,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
mi-&gt;context=2Ec2=2En_trunc_post_decrypt);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        hash_iterator_free(&amp;hi);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif /* ifdef PACKET_TRUNCATION_CHECK */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     status_flush(so);</sp=
an><br><span>     gc_free(&amp;gc_top);</span><br><span> </span><br><span>d=
iff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><sp=
an>index cdd02b6=2E=2E970baa9 100644</span><br><span>--- a/src/openvpn/open=
vpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -2=
69,12 +269,6 @@</span><br><span>     counter_type link_read_bytes_auth;</sp=
an><br><span>     counter_type link_write_bytes;</span><br><span>     count=
er_type dco_write_bytes;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#ifdef PACKET_TRUNCATION_CHECK</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    counter_type n_trunc_tun_read;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    counter_type n_trunc_tun_write;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    counter_type n_trunc_pre_encrypt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    counter_type n_t=
runc_post_decrypt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span> </span><br><span>     /*</span><br><span>      * Timer=
 objects for ping and inactivity</span><br><span>diff --git a/src/openvpn/p=
roto=2Ec b/src/openvpn/proto=2Ec</span><br><span>index 2cdb147=2E=2Ea2b07df=
 100644</span><br><span>--- a/src/openvpn/proto=2Ec</span><br><span>+++ b/s=
rc/openvpn/proto=2Ec</span><br><span>@@ -163,52 +163,3 @@</span><br><span> =
    /* Take the one&#39;s complement of sum */</span><br><span>     return =
((uint16_t)~sum);</span><br><span> }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 PACKET_TRUNCATION_CHECK</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-ipv4_packet_size_verify(const uint8=
_t *data, const int size, const int tunnel_type,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        const char *prefix, coun=
ter_type *errors)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (size &gt; 0)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        struct buffer buf;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        buf_set_read(&amp;buf, data, size);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (is_ipv4(tunnel_type, &amp;buf))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            const struct openvpn_iphdr *pip;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int hlen;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int totlen;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const cha=
r *msgstr =3D &quot;PACKET SIZE INFO&quot;;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msglvl_t msglevel =3D D_PACKET_TRUNC_DEBU=
G;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (BLENZ(&amp;buf) &lt; siz=
eof(struct openvpn_iphdr))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            verify_align_4(&am=
p;buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pi=
p =3D (struct openvpn_iphdr *)BPTR(&amp;buf);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            hlen =3D OPENVPN_IPH_GET_LEN(pip-&gt;version_len);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            totlen =3D ntohs(pi=
p-&gt;tot_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(&amp;b=
uf) !=3D totlen)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   msgstr =3D &quot;PACKET TRUNCATION ERROR&quot;;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                msglevel =3D D_PACKET_TRUNC_ER=
R;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if =
(errors)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   ++(*errors);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;%s %s: =
size=3D%d totlen=3D%d hlen=3D%d errcount=3D&quot; counter_format, msgstr,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                prefix,=
 BLEN(&amp;buf), totlen, hlen, errors ? *errors : (counter_type)0);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef PACKET_=
TRUNCATION_CHECK */</span><br><span>diff --git a/src/openvpn/proto=2Eh b/sr=
c/openvpn/proto=2Eh</span><br><span>index 1665751=2E=2E14f9264 100644</span=
><br><span>--- a/src/openvpn/proto=2Eh</span><br><span>+++ b/src/openvpn/pr=
oto=2Eh</span><br><span>@@ -307,11 +307,6 @@</span><br><span> uint16_t ip_c=
hecksum(const sa_family_t af, const uint8_t *payload, const int len_payload=
,</span><br><span>                      const uint8_t *src_addr, const uint=
8_t *dest_addr, const int proto);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef PACKET_TRUNCATION_CHECK</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-void ipv4_packet_size_verify(const=
 uint8_t *data, const int size, const int tunnel_type,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                             const char *p=
refix, counter_type *errors);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span> </span><br><span> #define OPENVPN_8021Q_MIN_VID 1</span><br><spa=
n> #define OPENVPN_8021Q_MAX_VID 4094</span><br><span>diff --git a/src/open=
vpn/sig=2Ec b/src/openvpn/sig=2Ec</span><br><span>index 81654f9=2E=2E0cdb01=
a 100644</span><br><span>--- a/src/openvpn/sig=2Ec</span><br><span>+++ b/sr=
c/openvpn/sig=2Ec</span><br><span>@@ -504,12 +504,6 @@</span><br><span>    =
     comp_print_stats(c-&gt;c2=2Ecomp_context, so);</span><br><span>     }<=
/span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#ifdef PACKET_TRUNCATION_CHECK</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    status_printf(so, &quot;TUN read truncations,&quot; counter_=
format, c-&gt;c2=2En_trunc_tun_read);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    status_printf(so, &quot;TUN write truncations,&quot; co=
unter_format, c-&gt;c2=2En_trunc_tun_write);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    status_printf(so, &quot;Pre-encrypt truncations,=
&quot; counter_format, c-&gt;c2=2En_trunc_pre_encrypt);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    status_printf(so, &quot;Post-decrypt =
truncations,&quot; counter_format, c-&gt;c2=2En_trunc_post_decrypt);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> #ifd=
ef _WIN32</span><br><span>     if (tuntap_defined(c-&gt;c1=2Etuntap))</span=
><br><span>     {</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2071?usp=3Demail">change 2071</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2071?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I61a0d15962584bc48=
cae459062fead08dc425aeb </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2071 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--VQHSSBwJuXA=--


--===============2890273724586307493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2890273724586307493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2890273724586307493==--

