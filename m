Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57093606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KZ8qBZfo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QH/IiZEt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FxH9doac;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Cgr6/W6+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dbGKGl6s478zOYRY3uHrZbxb3zlKpb5rVCoYqEM2X+A=; b=KZ8qBZfoIrA5vAPtqS2COcioKW
	/5LfoSdr8Oacetc4Y8wqK2H1XXwNzYrG2lgY2C7/+TIw905HV/CDR/8qFzewSKriTmB8CyL9iIgWk
	ttxawzBSxDvn9PPJz4T66ZAfPDEnpzPxXi/X7SII/OmHrM11DPHID1avneoCbN2/O7SI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrZy-000000007T9-0A3e;
	Fri, 30 Oct 2026 18:43:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMrZv-000000007T1-2Tnk
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:43:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=taVPKS5xOuDqT2zbN5aE/qUgEA0QjdKTL68euLNvx9s=; b=QH/IiZEtRFavMkh1qVNvWpE4s3
 QjEK5H5jHS3RG0ScNd0CA7885wGK19kcORDuOJPRJio96B2+QIaioBRjOg8kAe74to+gSOyND0TE1
 63kHiOWO94CLjh0ZOHa4MdxK06nTQEbkKbYmkzsGmB3GEvo39CfprTy/+MHLfJJzVFPc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=taVPKS5xOuDqT2zbN5aE/qUgEA0QjdKTL68euLNvx9s=; b=FxH9doacIIcuiWM+b8bSps/kds
 ++5JXHpJXlG4Z8WvHTnI+1SowBnmGH/w8yMaSbsGtay4Xw1qfR9SKA0rUoBnw05WnmLv2RkjlwIGQ
 tvwklWWlzSifWyEhryPSqkQffLeHlwhx7Gbj4Rsjnv6D2A1TpqmvJqyb5V8q3hZ5HUEI=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMrZt-000000005sC-4Aaj for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:43:51 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so9028105e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 11:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793385823; x=1793990623; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=taVPKS5xOuDqT2zbN5aE/qUgEA0QjdKTL68euLNvx9s=;
 b=Cgr6/W6+eNOm6d+rOGwEYtk0/nGMG+RFKDeQLVh/rItMc9bF3uhNNbeBcNxmKwr1jm
 PMb/SingLxEjQ2eJXOp/JQ0xR8CFqzWl1yCtl4U5F046UmXDBGxphum4jY17mSryqM4R
 YHN20Pu0O4QgXHDiFUURdmqd32FIT6GJhgmf2TNJVu+8Mwv4cY375A95fQlkOcPtnrf4
 wQZtyPS5f9S71A3ZTaprW4K1jXzRS4qvTzshTSyrzMwv9afSpbSw3rf20EX6FUI1/4Im
 oUEPAFaT76YDhBIDfCPg3ZYDikCVjzlwGJAsGA0Zc+fYdHZFu4iGjeaG94Ip5bKRQrAc
 jzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385823; x=1793990623;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=taVPKS5xOuDqT2zbN5aE/qUgEA0QjdKTL68euLNvx9s=;
 b=qtuQygl8UlVRFzNLK4VbIt6FKhKKqHPe9d+RKR20Y4zUf9q9u7xXBDz0sD4HsxpgqO
 ZD3w4rLp7m07JEMhR1rsiASHrtMvJIrmvIMp954OIVji7Zye2CFrfL2QZFE78mssyI7k
 QAssPvqjUuJnRjbU2gOKYeD5fPI6rNFbMkT9jzfEmHDmfavh6m+HPQTbAb/yz9tFA+Xa
 I2tAw1tQzBUIwImQmCGZaQU1O5UFbHUxNoYE2KyL6KiGvlynb1KwYdKLO7/zHBIfxys5
 DKp61jkNrhc0CdX3ktHniM0ljzuVSMrKy/hoAf/yWswnRQADhj3JoDH99SwUwL2iVdHl
 MVQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIV8Vm6vbw6+HmngoA5Sv3Akzb3jukCnvWq1dCfE/5nf2SYYMuTzL9ShMj/SM9NGjxe6ThckOvor8zJkMv@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJZ83Uln84dZzWlXqEuGSQjQC6t0S5FHg4Yza4HeZjl0Cn3WttN
 08EIGD4bijSuWBWQyMLfT1F/UwGYCwCoeplu9N1jETqcikR8SNnYE+b1DJGeAmijkxPdotzSVpi
 uvN2ACoeuEHqhBZs6SCJpnSjny+Aa4dWyNq3PDlePVrg17gwtsTAdFbFQqOyh5dJ+B5nb
X-Gm-Gg: AYBFou3ybiT2rUDfF1Ahl2uwZ6fM5+XGv1MUHNfwb67NW1l241Z7XLeAPbXeLFGN5YF
 ryE/7G2s3obsP7ulOB7H1pEz1HMdTeFGGsRH2Rgk0vuoYX2DKdhR1faFnlb+tBoCwwIcLz9uhwp
 GkJKbdp63kJ97OhM7xKpFM5ZSgt7JqyodAQedlK3xHZz2631xJL/V/kpmM6yNOaxaiLW8oYin2L
 LQ0dx2d+hbTrjiDsDDVqkGDneY0dDOsr48VvzhLpjQD+ga4T6HYDfeOoQ9otNY+TmEiCE2OgzS3
 VJbo4U9TKTi4z6PX8qn3TZQngqbqv4YpQdXTPQ3WGmqrvRvKhl4leX8M2rah+y4Nez0FRV1TH7/
 6DFCRta6mbH/N80PAEQqQyHhLIU3IA6dxjXqfZJynqGxBYsvJx5vAw040QMrXNXzC0hljwnybOD
 ggX6fsDxnCEwIBb6hRG60BkyDxoxLBfl0WX7aMVj4fB0bk3NLTENwxqHCpNxnknWcgxALImgeag
 OpY6vQIEXVa4XTNIgEM2uGqite4N0tIxldAVF5XGqUAjecbBzoDj6bvzl58Kbl7kxeSJmCp3zWI
 Fds1DU8y9gM5yoaKwa6mOsEmSSH9BK6b3WFbaCPgamiWrzCFofrNBLgYjgpY1YgGWeS6FW2Hll1
 CHZTiw2S14Twr31N4eP435QF22t7zz+he6FZ5eEXWL4MRgP9T6RxCI453luxhkdQF5D5LhODxTw
 Z6mKtMwti4WOGxWPY=
X-Received: by 2002:a05:600c:46d1:b0:4a2:1867:10e8 with SMTP id
 5b1f17b1804b1-4ac17b2c8a7mr69633905e9.25.1793385823319; 
 Fri, 30 Oct 2026 11:43:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe7700c3bsm77476235e9.0.2026.10.30.11.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:43:43 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 18:43:42 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20
X-Gerrit-Change-Number: 2045
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2045?usp=email>
X-Gerrit-Commit: 486077fe500217ad7a3f5ecee4191f66580bbd0b
In-Reply-To: <gerrit.1793094393000.I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20@gerrit.openvpn.net>
References: <gerrit.1793094393000.I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkkyZjQ5ZjQwZTQ5YWY4NTAzZjVjMDhjNTU3NWZmYzlhOGI0YzlhYTIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <585975109f5f5550d006aba09ebfa4210de10eaf-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMrZt-000000005sC-4Aaj
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: walk the
 link sockets once in multi_io_wait()
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1278735636431137358=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1278735636431137358==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kiiopk+2bW0="; charset=UTF-8

--kiiopk+2bW0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2045?usp=3Demail )

Change subject: multi_io: walk the link soc=
kets once in multi_io_wait()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

multi_io: walk the link sockets once in multi_io_wait()

m=
ulti_io_wait() went over the link sockets twice: first to register
every so=
cket as a listening socket, then, if a UDP socket is configured,
again to a=
rm the UDP ones=2E The UDP sockets were thus registered twice,
and on Windo=
ws the first pass created an FD_ACCEPT event for them=2E

Walk the sockets =
once, arming the UDP sockets and registering only the
TCP ones as listening=
 sockets=2E Drop the mode check as well, since
multi_io_wait() only runs in=
 server mode=2E

Change-Id: I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20
Signe=
d-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2045
Message-Id: <20261027124501=2E682-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg40223=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/multi_io=2Ec
1 file changed, 7 insertions(+), 17 d=
eletions(-)




diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_i=
o=2Ec
index 56216d4=2E=2Efb4810b 100644
--- a/src/openvpn/multi_io=2Ec
+++ =
b/src/openvpn/multi_io=2Ec
@@ -168,27 +168,17 @@
     int status;
     unsi=
gned int *persistent =3D &m->multi_io->tun_rwflags;
 
-    if (!tuntap_is_d=
co_win(m->top=2Ec1=2Etuntap))
+    for (int i =3D 0; i < m->top=2Ec1=2Elink=
_sockets_num; i++)
     {
-        for (int i =3D 0; i < m->top=2Ec1=2Elink=
_sockets_num; i++)
+        struct link_socket *sock =3D m->top=2Ec2=2Elink=
_sockets[i];
+
+        if (proto_is_dgram(sock->info=2Eproto))
         {
=
-            socket_set_listen_persistent(m->top=2Ec2=2Elink_sockets[i], m-=
>multi_io->es,
-                                         &m->top=2Ec2=2Elin=
k_sockets[i]->ev_arg);
+            multi_io_process_flags(&m->top, m->mult=
i_io->es, sock, p2mp_iow_flags(m, sock));
         }
-    }
-
-    if (has_=
udp_in_local_list(&m->top=2Eoptions))
-    {
-        for (int i =3D 0; i <=
 m->top=2Ec1=2Elink_sockets_num; i++)
+        else if (!tuntap_is_dco_win(=
m->top=2Ec1=2Etuntap))
         {
-            struct link_socket *sock =3D=
 m->top=2Ec2=2Elink_sockets[i];
-
-            if ((m->top=2Eoptions=2Emode=
 =3D=3D MODE_SERVER) && proto_is_dgram(sock->info=2Eproto))
-            {
=
-                unsigned int flags =3D p2mp_iow_flags(m, sock);
-
-       =
         multi_io_process_flags(&m->top, m->multi_io->es, sock, flags);
-  =
          }
+            socket_set_listen_persistent(sock, m->multi_io->es=
, &sock->ev_arg);
         }
     }
 

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2045?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20
Gerrit-Change-N=
umber: 2045
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarc=
o@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--kiiopk+2bW0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2045?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">multi_io: walk the link sockets on=
ce in multi_io_wait()<br><br>multi_io_wait() went over the link sockets twi=
ce: first to register<br>every socket as a listening socket, then, if a UDP=
 socket is configured,<br>again to arm the UDP ones=2E The UDP sockets were=
 thus registered twice,<br>and on Windows the first pass created an FD_ACCE=
PT event for them=2E<br><br>Walk the sockets once, arming the UDP sockets a=
nd registering only the<br>TCP ones as listening sockets=2E Drop the mode c=
heck as well, since<br>multi_io_wait() only runs in server mode=2E<br><br>C=
hange-Id: I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20<br>Signed-off-by: Gianm=
arco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>Acked-by: Razvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2045<br>Message-Id: &lt;20261027124501=2E682-1-gert@gree=
nie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg40223=2Ehtml<br>Signed-off-by: Gert Doering &lt=
;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/multi_io=2Ec<br>1 file=
 changed, 7 insertions(+), 17 deletions(-)<br><br></pre>
<pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index 562=
16d4=2E=2Efb4810b 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</sp=
an><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -168,27 +168=
,17 @@</span><br><span>     int status;</span><br><span>     unsigned int *=
persistent =3D &amp;m-&gt;multi_io-&gt;tun_rwflags;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tuntap_is_dco_win(=
m-&gt;top=2Ec1=2Etuntap))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_num; i++)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        for (int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_num; i++)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct link_s=
ocket *sock =3D m-&gt;top=2Ec2=2Elink_sockets[i];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (proto_is_dgram(sock-&gt;info=2Eproto))</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    socket_set_listen_persistent(m-&gt;top=2Ec2=2Elink_sockets[i], m-&gt;mu=
lti_io-&gt;es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                                  &amp;m-&gt;top=2Ec2=2Elink_sockets[i]-&gt=
;ev_arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  multi_io_process_flags(&amp;m-&gt;top, m-&gt;multi_io-&gt;es, sock, p2mp_=
iow_flags(m, sock));</span><br><span>         }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (has=
_udp_in_local_list(&amp;m-&gt;top=2Eoptions))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        for (int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_num;=
 i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else i=
f (!tuntap_is_dco_win(m-&gt;top=2Ec1=2Etuntap))</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct lin=
k_socket *sock =3D m-&gt;top=2Ec2=2Elink_sockets[i];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if ((m-&gt;top=2Eoptions=2Emode =3D=3D MODE_SERVER) =
&amp;&amp; proto_is_dgram(sock-&gt;info=2Eproto))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                unsigned int flags =3D p2mp_iow_flags(m=
, sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                multi_io_process_f=
lags(&amp;m-&gt;top, m-&gt;multi_io-&gt;es, sock, flags);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            socket_set_listen_persistent(sock=
, m-&gt;multi_io-&gt;es, &amp;sock-&gt;ev_arg);</span><br><span>         }<=
/span><br><span>     }</span><br></pre><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2045?usp=3Demail">change 2045</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2045?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2f49f40e49af8=
503f5c08c5575ffc9a8b4c9aa20 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2045 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gian=
marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--kiiopk+2bW0=--


--===============1278735636431137358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1278735636431137358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1278735636431137358==--

