Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C49F606A32A
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NentLEkJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d3ZJEgod;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mQmuuYj3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RzqjrFhG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mg8Ph323CJ7aSDJzsmxu2yI1wYew87+KbuzCTDmt/NI=; b=NentLEkJ5hXUjrfsdUWhUQmz73
	1UxbagU3jeT/eGwuzw46iN3I0XwQse4QmidcsVduAksY3umUL+eajoN12QD+vN2D6xEv25RS2Tv1B
	t9fndWgJYZMMlAwfm08h0ncBNjr0rKPyCq3F7nVTUVtCqhH4VpH3q/3WrSlSJAod4p6k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUMAy-000000001Kp-1GZJ;
	Fri, 20 Nov 2026 10:49:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUMAx-000000001Kj-1UzV
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:49:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7QatME3FTKs0CVwwI9us275H0JRWTRfD/5qhkgnTVKU=; b=d3ZJEgodxN4QpVpPm5HS9RpDIy
 UswaUFgN7yWQs6yHjdOl3hdln67oVtzUVcMQGZjc5Zkimh/riZbbJJXBv4yQRqtMl9ODKA91bKIEc
 sQcTINwvFeLZpBVpGCEY2iejBLQ1+bqewSiR6f1Z7McLYD/rzWz5ywz28mLpuLWBCeWU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7QatME3FTKs0CVwwI9us275H0JRWTRfD/5qhkgnTVKU=; b=mQmuuYj3YauInQZkyftm3hz3wi
 Jc5Yuw5MATmxq6dd5alBcL1vmsTasYlsc9k2L0aDqdq3r+3DZU623eutLOunO2kiPlgn/2z2c1fYA
 85whxp/jSNEGAoyYCwwCod8FLpTTCGLT0N02klUHhaPPXoQ8rAGjfARfHOaGjTe+BxCo=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUMAu-000000004FY-1ChF for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:49:03 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so5154515e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 02:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795171734; x=1795776534; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7QatME3FTKs0CVwwI9us275H0JRWTRfD/5qhkgnTVKU=;
 b=RzqjrFhGSnbG20Aark+dJX8RcEn3xST4VLRAL9YYilsfWawXO2pl95+YglCOFsSyGM
 X1CjJz1h7EVcuzPbqocN8TJdsQYrDmKLLPqNLh4kblL1I4qnQ8iWRqW5cVbiyErQcDRW
 oK1X9mjPwnRK5T2XVDqXtC3horVnWU9465GZEUN2VXjlf9E/FG/RqlD/xyUW+zENFJTj
 FkwkXjZZzjZlHYNG98aU41ixqFlyG2CchE7vBB+TiFwQH5UZcyKU4w+wPF4704F8u+ou
 1M0ikTm3QqmfRdfJobbXpLXW5emjJqG9Z9VIqM4JMAMW39t80ld4aMOfkxg5/HZhNPCV
 746w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171734; x=1795776534;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7QatME3FTKs0CVwwI9us275H0JRWTRfD/5qhkgnTVKU=;
 b=j+PkbiNWIDltWOoeODapzkdmWvXiY7jRSoHVhdsi8TB4FaagH484m9+QBSEBplL2yz
 F2vll+4t6WdHQV9tA+4uG0PwfYBEeICAOSv2ZBdQ8rEdopno2kuIevLKgRJwnb9QfvPQ
 sF9Dx26s/If3OlaX4yjqA8Aehb12E6s9da5/8bfG39ZDnXauw/TaIS0KI1OpBHWX5aRy
 2diDncXSQsc6GP8R1xq2YWMeOLwP8b/8F79FbHmkELb+lEWgKzpw38linO5WEo3kB1xk
 WVxsuQuwY/iNLRczb0A+puCe1Q++XzPPnXYV3dkq5c9sQ1rf9187ncFjvRd4lN49Tgmc
 ZTxA==
X-Forwarded-Encrypted: i=1;
 AL+hErE8lw5F68iwedf2sTEWdnsIlKlBllDS22z/kPWfHc+tSG2cjZ5OCO6mLzcv4gb0rlCX3O7ETaa9hOPurzP6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/6IizB8vbvtzKOKG8QSmAb6bZuJ2mAfeSA2ShofZUTXChlpnhC
 kjGBZdyAB0o6GIeE/P6UewnDIBWKGM/GYuqzRkXRYdrz575qPGsmm1gkekCLy8YU/L9n8HSG7jl
 bSe4+NTPbruEylG+d/vvzianRN0P14iu3MdWQVJFioJ7mGsRiHM2N9SIck1d7jHj2Xmea
X-Gm-Gg: AYBFou0YDVo7el36nCsLq6HOMOOWKE/UgpJpR6c/jrRHmomnM4+5Z3bZghGjgWFA3UP
 4e+arzAvyeszpcvAp52Ycx2/JRbFnEFa9nj50YewDHKuzn5rauKae3yig8DBnSDZF9LFaF9c9l6
 bfuePPq7MYD81iaJ9VFxCZ5aMzJgdTuks4Xy+zVNs55q7pRJUu0nsqVFQuvZ0AJu45gQ+hi6e2u
 LLHUIAYl/Aw8bwRXYTWH2yPKbRm7Re2ha2VW0/4nvzWcnkCM/Cff4V5fUqt3b1SfK3CBmROgbfj
 RADtjTIh3rTc/osLDvNEMf4gRX2vhqNDNuO7P0nNTWvQR7Jbi2Z86KE7sDU6oTJcdSMdRro1pUE
 NiSnV4+3ysK1+qFDRUqK9jrvQWnCk9W+G22Sm8/rQ2OC8mA/mVpPbnnNamWkUnyZOEk1XtuRt3V
 B4OwBJgIYsMCTuvyZYa5jQFLvSz6NwZvorAOrWPrFhmDIEWqhCbS4bHyBgCsT/ACeUvjHk2dxi1
 U2YBTTZdBiZgqO6yQX2R7ean9ZnX3CkQUbHEyBp6oUCDRIcKhlzVPYmfD1xxeOchk3P1E9XXoxj
 5ki263xkpycBJTGfxrA1R/ZWElWonLd0/9sU7IIpALIYA+r0God+jk+skRX9six1+6D89j7wK4x
 +VLYgG1iupU+gAM50xQsKoPJn2G6YFFgOX2jLTENPq5tVssNdQN2eibQIJHwFT8/pDWoMsdL6KW
 bXLNy7PYGvcdQo28A=
X-Received: by 2002:a05:600c:a51:b0:4bb:5f43:23bb with SMTP id
 5b1f17b1804b1-4bb88828173mr56448785e9.33.1795171733311; 
 Fri, 20 Nov 2026 02:48:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853c9170sm116606025e9.14.2026.11.20.02.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:48:52 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 10:48:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
X-Gerrit-Change-Number: 2224
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2224?usp=email>
X-Gerrit-Commit: c482c663506d341f0d6669ad253698baff3bfb07
In-Reply-To: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
References: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTU2MzAxMDAwLkljYmZjNmI2NGJlZWE1ZTcwZjMyNDQ5YzVhNjNhMDhhZDg2MjU5N2I5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <38c7f05d5dc01c0d4c75e76cb664ccbd1a46b5f7-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUMAu-000000004FY-1ChF
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking: use
 NET_ROUTE_TABLE_DEFAULT (-1) for 'no route table'
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3015608954439865810=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3015608954439865810==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EygcJA2dlTg="; charset=UTF-8

--EygcJA2dlTg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2224?usp=3Demail )

Change subject: networking: use NET_ROUTE_T=
ABLE_DEFAULT (-1) for 'no route table'
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

networking: use NET_ROUTE_TABLE_DEFAULT (-1) for =
'no route table'

Table 0 meant "default table" in the net_route_*() API=2E=
 That is fine on
Linux, where table 0 is RT_TABLE_UNSPEC, but on FreeBSD FI=
B 0 is a real
FIB, which could then not be selected from a process running =
in another
FIB=2E

Make the table argument an int, with NET_ROUTE_TABLE_DEF=
AULT (-1) for
the default table, and default --route-table to it=2E An inva=
lid
--route-table value is now an error, instead of table 0=2E sitnl maps -=
1
and 0 to the main table, as before=2E On FreeBSD, -fib is now passed only=

for a set table; DCO iroutes no longer force FIB 0 but use the FIB of
the =
process=2E

Routes that route=2Ec creates internally get it too; block-loca=
l routes
passed an uninitialized table before=2E

Change-Id: Icbfc6b64beea5=
e70f32449c5a63a08ad862597b9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224
Message-Id: <20261120083531=2E739=
0-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg41713=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/dco=2Ec
M src/openvpn/networki=
ng=2Eh
M src/openvpn/networking_freebsd=2Ec
M src/openvpn/networking_iprout=
e2=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openvpn/options=2Ec
M src/o=
penvpn/route=2Ec
M tests/unit_tests/openvpn/test_networking=2Ec
8 files cha=
nged, 74 insertions(+), 63 deletions(-)




diff --git a/src/openvpn/dco=2E=
c b/src/openvpn/dco=2Ec
index 236be93=2E=2Efdee465 100644
--- a/src/openvpn=
/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -721,7 +721,7 @@
         }
 
       =
  net_route_v6_add(&m->top=2Enet_ctx, &addr->v6=2Eaddr, addr->netbits,
-   =
                      gateway, c->c1=2Etuntap->actual_name, 0,
+           =
              gateway, c->c1=2Etuntap->actual_name, NET_ROUTE_TABLE_DEFAULT=
,
                          DCO_IROUTE_METRIC);
 #endif
     }
@@ -739,7 +7=
39,7 @@
         }
 
         net_route_v4_add(&m->top=2Enet_ctx, &dest, ad=
dr->netbits, gateway,
-                         c->c1=2Etuntap->actual_name=
, 0, DCO_IROUTE_METRIC);
+                         c->c1=2Etuntap->actual_n=
ame, NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_METRIC);
 #endif
     }
 #endif /*=
 if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
=
@@ -765,7 +765,7 @@
             dco_win_del_iroute_ipv4(&c->c1=2Etuntap->d=
co, htonl(ir->network), ir->netbits);
 #else
             net_route_v4_del(=
net_ctx, &ir->network, ir->netbits,
-                             &c->c2=2E=
push_ifconfig_local, c->c1=2Etuntap->actual_name, 0,
+                     =
        &c->c2=2Epush_ifconfig_local, c->c1=2Etuntap->actual_name, NET_ROUT=
E_TABLE_DEFAULT,
                              DCO_IROUTE_METRIC);
 #endif
=
         }
@@ -779,7 +779,7 @@
         {
             /* On windows we do =
not install these routes, so we also do not need to delete them */
        =
     net_route_v4_del(net_ctx, &ifconfig_local, 32, NULL,
-                =
             c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC);
+         =
                    c->c1=2Etuntap->actual_name, NET_ROUTE_TABLE_DEFAULT, D=
CO_IROUTE_METRIC);
         }
 #endif
     }
@@ -792,7 +792,7 @@
          =
   dco_win_del_iroute_ipv6(&c->c1=2Etuntap->dco, ir6->network, ir6->netbits=
);
 #else
             net_route_v6_del(net_ctx, &ir6->network, ir6->netbit=
s,
-                             &c->c2=2Epush_ifconfig_ipv6_local, c->c1=
=2Etuntap->actual_name, 0,
+                             &c->c2=2Epush_ifco=
nfig_ipv6_local, c->c1=2Etuntap->actual_name, NET_ROUTE_TABLE_DEFAULT,
    =
                          DCO_IROUTE_METRIC);
 #endif
         }
@@ -805,7 =
+805,7 @@
         {
             /* On windows we do not install these rou=
tes, so we also do not need to delete them */
             net_route_v6_del=
(net_ctx, dest, 128, NULL,
-                             c->c1=2Etuntap->ac=
tual_name, 0, DCO_IROUTE_METRIC);
+                             c->c1=2Etun=
tap->actual_name, NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_METRIC);
         }
 =
#endif
     }
diff --git a/src/openvpn/networking=2Eh b/src/openvpn/network=
ing=2Eh
index 7ad6e2e=2E=2Ef42ef4b 100644
--- a/src/openvpn/networking=2Eh
=
+++ b/src/openvpn/networking=2Eh
@@ -24,6 +24,9 @@
 
 #define IFACE_TYPE_LE=
N_MAX 64
 
+/** net_route_*() table: Linux main table, FreeBSD FIB of the p=
rocess */
+#define NET_ROUTE_TABLE_DEFAULT -1
+
 struct context;
 
 #ifdef =
ENABLE_SITNL
@@ -245,14 +248,13 @@
  * @param prefixlen the length of the p=
refix of the destination
  * @param gw        the gateway for this route
  =
* @param iface     the interface for this route (can be NULL)
- * @param ta=
ble     the table to add this route to (if 0, will be added to the
- *     =
             main table)
+ * @param table     the table to add this route t=
o, or NET_ROUTE_TABLE_DEFAULT
  * @param metric    the metric associated wi=
th the route
  *
  * @return          0 on success, a negative error code o=
therwise
  */
 int net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_=
addr_t *dst, int prefixlen,
-                     const in_addr_t *gw, cons=
t openvpn_net_iface_t *iface, uint32_t table,
+                     const i=
n_addr_t *gw, const openvpn_net_iface_t *iface, int table,
                =
      int metric);
 
 /**
@@ -263,14 +265,13 @@
  * @param prefixlen the le=
ngth of the prefix of the destination
  * @param gw        the gateway for =
this route
  * @param iface     the interface for this route (can be NULL)
=
- * @param table     the table to add this route to (if 0, will be added to=
 the
- *                  main table)
+ * @param table     the table to add=
 this route to, or NET_ROUTE_TABLE_DEFAULT
  * @param metric    the metric =
associated with the route
  *
  * @return          0 on success, a negative=
 error code otherwise
  */
 int net_route_v6_add(const openvpn_net_ctx_t *c=
tx, const struct in6_addr *dst, int prefixlen,
-                     const =
struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,
+   =
                  const struct in6_addr *gw, const openvpn_net_iface_t *ifa=
ce, int table,
                      int metric);
 
 /**
@@ -281,14 +282,13=
 @@
  * @param prefixlen the length of the prefix of the destination
  * @p=
aram gw        the gateway for this route
  * @param iface     the interfac=
e for this route (can be NULL)
- * @param table     the table to add this r=
oute to (if 0, will be added to the
- *                  main table)
+ * @p=
aram table     the table to add this route to, or NET_ROUTE_TABLE_DEFAULT
 =
 * @param metric    the metric associated with the route
  *
  * @return   =
       0 on success, a negative error code otherwise
  */
 int net_route_v4=
_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
-  =
                   const in_addr_t *gw, const openvpn_net_iface_t *iface, u=
int32_t table,
+                     const in_addr_t *gw, const openvpn_net=
_iface_t *iface, int table,
                      int metric);
 
 /**
@@ -2=
99,14 +299,13 @@
  * @param prefixlen the length of the prefix of the desti=
nation
  * @param gw        the gateway for this route
  * @param iface    =
 the interface for this route (can be NULL)
- * @param table     the table =
to add this route to (if 0, will be added to the
- *                  main =
table)
+ * @param table     the table to add this route to, or NET_ROUTE_TA=
BLE_DEFAULT
  * @param metric    the metric associated with the route
  *
 =
 * @return          0 on success, a negative error code otherwise
  */
 int=
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst,=
 int prefixlen,
-                     const struct in6_addr *gw, const open=
vpn_net_iface_t *iface, uint32_t table,
+                     const struct =
in6_addr *gw, const openvpn_net_iface_t *iface, int table,
                =
      int metric);
 
 #endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FR=
EEBSD */
diff --git a/src/openvpn/networking_freebsd=2Ec b/src/openvpn/netw=
orking_freebsd=2Ec
index 88fd5c0=2E=2E8ba6326 100644
--- a/src/openvpn/netw=
orking_freebsd=2Ec
+++ b/src/openvpn/networking_freebsd=2Ec
@@ -10,7 +10,7 =
@@
 
 static int
 net_route_v4(const char *op, const in_addr_t *dst, int pr=
efixlen, const in_addr_t *gw,
-             const char *iface, uint32_t tab=
le, int metric)
+             const char *iface, int table, int metric)
 {
=
     char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];
     in_addr_t _dst=
, _gw;
@@ -27,15 +27,20 @@
     if (gw)
     {
         _gw =3D ntohl(*gw);=

-        argv_printf(&argv, "%s %s -net %s/%d %s -fib %d", ROUTE_PATH, op,=

+        argv_printf(&argv, "%s %s -net %s/%d %s", ROUTE_PATH, op,
       =
              inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
-  =
                  inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)), table);
+  =
                  inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)));
     }
   =
  else
     {
-        argv_printf(&argv, "%s %s -net %s/%d -iface %s -fib =
%d", ROUTE_PATH, op,
+        argv_printf(&argv, "%s %s -net %s/%d -iface %=
s", ROUTE_PATH, op,
                     inet_ntop(AF_INET, &_dst, buf1, si=
zeof(buf1)), prefixlen,
-                    iface, table);
+              =
      iface);
+    }
+    /* without -fib, route(8) uses the FIB of the pro=
cess */
+    if (table >=3D 0)
+    {
+        argv_printf_cat(&argv, "-fib=
 %d", table);
     }
 
     argv_msg(M_INFO, &argv);
@@ -48,7 +53,7 @@
 
 s=
tatic int
 net_route_v6(const char *op, const struct in6_addr *dst, int pre=
fixlen, const struct in6_addr *gw,
-             const char *iface, uint32_=
t table, int metric)
+             const char *iface, int table, int metric=
)
 {
     char buf1[INET6_ADDRSTRLEN], buf2[INET6_ADDRSTRLEN];
     struct =
argv argv =3D argv_new();
@@ -61,15 +66,19 @@
      */
     if (gw)
     {
=
-        argv_printf(&argv, "%s -6 %s -net %s/%d %s -fib %d", ROUTE_PATH, o=
p,
+        argv_printf(&argv, "%s -6 %s -net %s/%d %s", ROUTE_PATH, op,
  =
                   inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,=

-                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)), table);
=
+                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)));
     }
 =
    else
     {
-        argv_printf(&argv, "%s -6 %s -net %s/%d -iface %s =
-fib %d", ROUTE_PATH, op,
+        argv_printf(&argv, "%s -6 %s -net %s/%d =
-iface %s", ROUTE_PATH, op,
                     inet_ntop(AF_INET6, dst, b=
uf1, sizeof(buf1)), prefixlen,
-                    iface, table);
+       =
             iface);
+    }
+    if (table >=3D 0)
+    {
+        argv_pri=
ntf_cat(&argv, "-fib %d", table);
     }
 
 
@@ -83,28 +92,28 @@
 
 int
 ne=
t_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int pref=
ixlen, const in_addr_t *gw,
-                 const char *iface, uint32_t t=
able, int metric)
+                 const char *iface, int table, int metri=
c)
 {
     return net_route_v4("add", dst, prefixlen, gw, iface, table, met=
ric);
 }
 
 int
 net_route_v6_add(const openvpn_net_ctx_t *ctx, const struc=
t in6_addr *dst, int prefixlen,
-                 const struct in6_addr *gw=
, const char *iface, uint32_t table, int metric)
+                 const st=
ruct in6_addr *gw, const char *iface, int table, int metric)
 {
     return=
 net_route_v6("add", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
 =
net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int pr=
efixlen, const in_addr_t *gw,
-                 const char *iface, uint32_t=
 table, int metric)
+                 const char *iface, int table, int met=
ric)
 {
     return net_route_v4("del", dst, prefixlen, gw, iface, table, m=
etric);
 }
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const str=
uct in6_addr *dst, int prefixlen,
-                 const struct in6_addr *=
gw, const char *iface, uint32_t table, int metric)
+                 const =
struct in6_addr *gw, const char *iface, int table, int metric)
 {
     retu=
rn net_route_v6("del", dst, prefixlen, gw, iface, table, metric);
 }
diff -=
-git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute=
2=2Ec
index d987478=2E=2E6c4c8f4 100644
--- a/src/openvpn/networking_iprout=
e2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -243,7 +243,7 @@
 
 int=

 net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int =
prefixlen, const in_addr_t *gw,
-                 const char *iface, uint32=
_t table, int metric)
+                 const char *iface, int table, int m=
etric)
 {
     struct argv argv =3D argv_new();
     const char *dst_str =
=3D print_in_addr_t(*dst, 0, &argv=2Egc);
@@ -281,7 +281,7 @@
 
 int
 net_r=
oute_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int p=
refixlen,
-                 const struct in6_addr *gw, const char *iface, u=
int32_t table, int metric)
+                 const struct in6_addr *gw, con=
st char *iface, int table, int metric)
 {
     struct argv argv =3D argv_ne=
w();
     char *dst_str =3D (char *)print_in6_addr(*dst, 0, &argv=2Egc);
@@=
 -314,7 +314,7 @@
 
 int
 net_route_v4_del(const openvpn_net_ctx_t *ctx, co=
nst in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-                 c=
onst char *iface, uint32_t table, int metric)
+                 const char =
*iface, int table, int metric)
 {
     struct argv argv =3D argv_new();
   =
  const char *dst_str =3D print_in_addr_t(*dst, 0, &argv=2Egc);
@@ -340,7 +=
340,7 @@
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const struc=
t in6_addr *dst, int prefixlen,
-                 const struct in6_addr *gw=
, const char *iface, uint32_t table, int metric)
+                 const st=
ruct in6_addr *gw, const char *iface, int table, int metric)
 {
     struct=
 argv argv =3D argv_new();
     char *dst_str =3D (char *)print_in6_addr(*d=
st, 0, &argv=2Egc);
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/ope=
nvpn/networking_sitnl=2Ec
index b7c0f58=2E=2Eaf4ed27 100644
--- a/src/openv=
pn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -1115,14 =
+1115,11 @@
 
 static int
 sitnl_route_add(const char *iface, sa_family_t a=
f_family, const void *dst, int prefixlen,
-                const void *gw, =
uint32_t table, int metric)
+                const void *gw, int table, int=
 metric)
 {
     enum rt_scope_t scope =3D RT_SCOPE_UNIVERSE;
-
-    if (ta=
ble =3D=3D 0)
-    {
-        table =3D RT_TABLE_MAIN;
-    }
+    /* table=
 0 is RT_TABLE_UNSPEC */
+    const uint32_t rt_table =3D table > 0 ? (uint=
32_t)table : RT_TABLE_MAIN;
 
     if (!gw && iface)
     {
@@ -1130,12 +11=
27,12 @@
     }
 
     return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, i=
face, af_family, dst, prefixlen, gw,
-                           table, met=
ric, scope, RTPROT_BOOT, RTN_UNICAST);
+                           rt_table=
, metric, scope, RTPROT_BOOT, RTN_UNICAST);
 }
 
 int
 net_route_v4_add(con=
st openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_ad=
dr_t *gw,
-                 const char *iface, uint32_t table, int metric)
=
+                 const char *iface, int table, int metric)
 {
     const i=
n_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;
     in_addr_t dst_be =3D 0, =
gw_be =3D 0;
@@ -1154,7 +1151,7 @@
         gw_ptr =3D &gw_be;
     }
 
-  =
  msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
+   =
 msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
     =
    inet_ntop(AF_INET, &dst_be, dst_str, sizeof(dst_str)), prefixlen,
     =
    inet_ntop(AF_INET, &gw_be, gw_str, sizeof(gw_str)), np(iface), table, m=
etric);
 
@@ -1163,7 +1160,7 @@
 
 int
 net_route_v6_add(const openvpn_net_=
ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-                 co=
nst struct in6_addr *gw, const char *iface, uint32_t table, int metric)
+  =
               const struct in6_addr *gw, const char *iface, int table, int=
 metric)
 {
     inet_address_t dst_v6;
     inet_address_t gw_v6;
@@ -1183=
,7 +1180,7 @@
         gw_v6=2Eipv6 =3D *gw;
     }
 
-    msg(D_ROUTE, "%s=
: %s/%d via %s dev %s table %u metric %d", __func__,
+    msg(D_ROUTE, "%s:=
 %s/%d via %s dev %s table %d metric %d", __func__,
         inet_ntop(AF_I=
NET6, &dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_n=
top(AF_INET6, &gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), table, met=
ric);
 
@@ -1192,20 +1189,18 @@
 
 static int
 sitnl_route_del(const char *=
iface, sa_family_t af_family, const inet_address_t *dst, int prefixlen,
-  =
              const inet_address_t *gw, uint32_t table, int metric)
+      =
          const inet_address_t *gw, int table, int metric)
 {
-    if (tabl=
e =3D=3D 0)
-    {
-        table =3D RT_TABLE_MAIN;
-    }
+    /* table 0=
 is RT_TABLE_UNSPEC */
+    const uint32_t rt_table =3D table > 0 ? (uint32=
_t)table : RT_TABLE_MAIN;
 
-    return sitnl_route_set(RTM_DELROUTE, 0, if=
ace, af_family, dst, prefixlen, gw, table, metric,
+    return sitnl_route_=
set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw, rt_table, metric=
,
                            RT_SCOPE_NOWHERE, 0, 0);
 }
 
 int
 net_route=
_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, =
const in_addr_t *gw,
-                 const char *iface, uint32_t table, i=
nt metric)
+                 const char *iface, int table, int metric)
 {
 =
    inet_address_t dst_v4;
     inet_address_t gw_v4;
@@ -1225,7 +1220,7 @@=

         gw_v4=2Eipv4 =3D htonl(*gw);
     }
 
-    msg(D_ROUTE, "%s: %s/%=
d via %s dev %s table %u metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d=
 via %s dev %s table %d metric %d", __func__,
         inet_ntop(AF_INET, &=
dst_v4=2Eipv4, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_=
INET, &gw_v4=2Eipv4, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
=
@@ -1234,7 +1229,7 @@
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx=
, const struct in6_addr *dst, int prefixlen,
-                 const struct=
 in6_addr *gw, const char *iface, uint32_t table, int metric)
+            =
     const struct in6_addr *gw, const char *iface, int table, int metric)
 =
{
     inet_address_t dst_v6;
     inet_address_t gw_v6;
@@ -1254,7 +1249,7=
 @@
         gw_v6=2Eipv6 =3D *gw;
     }
 
-    msg(D_ROUTE, "%s: %s/%d vi=
a %s dev %s table %u metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via=
 %s dev %s table %d metric %d", __func__,
         inet_ntop(AF_INET6, &dst=
_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INE=
T6, &gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
di=
ff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 947439d=
=2E=2Ee51ece7 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -831,7 +831,7 @@
     o->ce=2Emssfix =3D 0;
     o->ce=2Emssfix_de=
fault =3D true;
     o->ce=2Emssfix_encap =3D true;
-    o->route_default_t=
able_id =3D 0;
+    o->route_default_table_id =3D NET_ROUTE_TABLE_DEFAULT;
=
     o->route_delay_window =3D 30;
     o->resolve_retry_seconds =3D RESOLV=
_RETRY_INFINITE;
     o->resolve_in_advance =3D false;
@@ -5297,7 +5297,11 =
@@
         msg(M_WARN, "NOTE: --route-table is supported only on Linux whe=
n SITNL is built-in");
 #endif
         VERIFY_PERMISSION(OPT_P_ROUTE_TABLE=
);
-        options->route_default_table_id =3D positive_atoi(p[1], msgleve=
l);
+        if (!atoi_constrained(p[1], &options->route_default_table_id, =
p[0], 0, INT_MAX,
+                              msglevel))
+        {
+   =
         goto err;
+        }
     }
     else if (streq(p[0], "route") && =
p[1] && !p[5])
     {
diff --git a/src/openvpn/route=2Ec b/src/openvpn/rout=
e=2Ec
index 9086529=2E=2E82cb7f0 100644
--- a/src/openvpn/route=2Ec
+++ b/s=
rc/openvpn/route=2Ec
@@ -545,6 +545,7 @@
         /* split a route into two=
 smaller blocking routes, and direct them to target */
         l2 =3D ((~g=
ateway->netmask) + 1) >> 1;
         r1->flags =3D RT_DEFINED;
+        r1-=
>table_id =3D NET_ROUTE_TABLE_DEFAULT;
         r1->gateway =3D target;
   =
      r1->network =3D gateway->addr & gateway->netmask;
         r1->netmas=
k =3D ~(l2 - 1);
@@ -854,6 +855,7 @@
                 r6->gateway =3D rl6->=
rgi6=2Egateway=2Eaddr_ipv6;
             }
             r6->metric =3D 1;
+=
            r6->table_id =3D NET_ROUTE_TABLE_DEFAULT;
 #ifdef _WIN32
      =
       r6->adapter_index =3D rl6->rgi6=2Eadapter_index;
 #else
@@ -883,6 +8=
85,7 @@
     struct route_ipv4 r;
     CLEAR(r);
     r=2Eflags =3D RT_DEFI=
NED;
+    r=2Etable_id =3D NET_ROUTE_TABLE_DEFAULT;
     r=2Enetwork =3D ne=
twork;
     r=2Enetmask =3D netmask;
     r=2Egateway =3D gateway;
@@ -897,=
6 +900,7 @@
     struct route_ipv4 r;
     CLEAR(r);
     r=2Eflags =3D RT_=
DEFINED | RT_ADDED;
+    r=2Etable_id =3D NET_ROUTE_TABLE_DEFAULT;
     r=
=2Enetwork =3D network;
     r=2Enetmask =3D netmask;
     r=2Egateway =3D =
gateway;
diff --git a/tests/unit_tests/openvpn/test_networking=2Ec b/tests/=
unit_tests/openvpn/test_networking=2Ec
index b580d32=2E=2E636adda 100644
--=
- a/tests/unit_tests/openvpn/test_networking=2Ec
+++ b/tests/unit_tests/ope=
nvpn/test_networking=2Ec
@@ -112,7 +112,7 @@
     }
     printf("\n");
 
- =
   return net_route_v4_add(NULL, &dst, prefixlen, NULL, iface, 0, metric);
=
+    return net_route_v4_add(NULL, &dst, prefixlen, NULL, iface, NET_ROUTE_=
TABLE_DEFAULT, metric);
 }
 
 static int
@@ -148,7 +148,7 @@
     }
     pr=
intf("\n");
 
-    return net_route_v4_add(NULL, &dst, prefixlen, &gw, ifac=
e, 0, metric);
+    return net_route_v4_add(NULL, &dst, prefixlen, &gw, ifa=
ce, NET_ROUTE_TABLE_DEFAULT, metric);
 }
 
 static int
@@ -175,7 +175,7 @@
=
     }
     printf("\n");
 
-    return net_route_v6_add(NULL, &dst, prefix=
len, NULL, iface, 0, metric);
+    return net_route_v6_add(NULL, &dst, pref=
ixlen, NULL, iface, NET_ROUTE_TABLE_DEFAULT, metric);
 }
 
 static int
@@ -=
208,7 +208,7 @@
     }
     printf("\n");
 
-    return net_route_v6_add(NU=
LL, &dst, prefixlen, &gw, iface, 0, metric);
+    return net_route_v6_add(N=
ULL, &dst, prefixlen, &gw, iface, NET_ROUTE_TABLE_DEFAULT, metric);
 }
 
 s=
tatic void

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
224?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merge=
d
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icbfc6b64=
beea5e70f32449c5a63a08ad862597b9
Gerrit-Change-Number: 2224
Gerrit-PatchSet=
: 4
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greeni=
e=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--EygcJA2dlTg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2224?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">networking: use NET_ROUTE_TABLE_DE=
FAULT (-1) for &#39;no route table&#39;<br><br>Table 0 meant &quot;default =
table&quot; in the net_route_*() API=2E That is fine on<br>Linux, where tab=
le 0 is RT_TABLE_UNSPEC, but on FreeBSD FIB 0 is a real<br>FIB, which could=
 then not be selected from a process running in another<br>FIB=2E<br><br>Ma=
ke the table argument an int, with NET_ROUTE_TABLE_DEFAULT (-1) for<br>the =
default table, and default --route-table to it=2E An invalid<br>--route-tab=
le value is now an error, instead of table 0=2E sitnl maps -1<br>and 0 to t=
he main table, as before=2E On FreeBSD, -fib is now passed only<br>for a se=
t table; DCO iroutes no longer force FIB 0 but use the FIB of<br>the proces=
s=2E<br><br>Routes that route=2Ec creates internally get it too; block-loca=
l routes<br>passed an uninitialized table before=2E<br><br>Change-Id: Icbfc=
6b64beea5e70f32449c5a63a08ad862597b9<br>Signed-off-by: Razvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224<br=
>Message-Id: &lt;20261120083531=2E7390-1-gert@greenie=2Emuc=2Ede&gt;<br>URL=
: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/=
msg41713=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&=
gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/networking=2Eh<br>M sr=
c/openvpn/networking_freebsd=2Ec<br>M src/openvpn/networking_iproute2=2Ec<b=
r>M src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/options=2Ec<br>M src/=
openvpn/route=2Ec<br>M tests/unit_tests/openvpn/test_networking=2Ec<br>8 fi=
les changed, 74 insertions(+), 63 deletions(-)<br><br></pre>
<pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index 236be93=
=2E=2Efdee465 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><s=
pan>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -721,7 +721,7 @@</span><br=
><span>         }</span><br><span> </span><br><span>         net_route_v6_a=
dd(&amp;m-&gt;top=2Enet_ctx, &amp;addr-&gt;v6=2Eaddr, addr-&gt;netbits,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
gateway, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                         gateway, c-&gt;c1=2Etun=
tap-&gt;actual_name, NET_ROUTE_TABLE_DEFAULT,</span><br><span>             =
             DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><span>  =
   }</span><br><span>@@ -739,7 +739,7 @@</span><br><span>         }</span><=
br><span> </span><br><span>         net_route_v4_add(&amp;m-&gt;top=2Enet_c=
tx, &amp;dest, addr-&gt;netbits, gateway,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                         c-&gt;c1=2Etuntap-&gt;actual_n=
ame, 0, DCO_IROUTE_METRIC);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                         c-&gt;c1=2Etuntap-&gt;actual_name, NET_ROU=
TE_TABLE_DEFAULT, DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><sp=
an>     }</span><br><span> #endif /* if defined(TARGET_LINUX) || defined(TA=
RGET_FREEBSD) || defined(_WIN32) */</span><br><span>@@ -765,7 +765,7 @@</sp=
an><br><span>             dco_win_del_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&g=
t;dco, htonl(ir-&gt;network), ir-&gt;netbits);</span><br><span> #else</span=
><br><span>             net_route_v4_del(net_ctx, &amp;ir-&gt;network, ir-&=
gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                   &amp;c-&gt;c2=2Epush_ifconfig_local, c-&gt;c1=2Etuntap-&=
gt;actual_name, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                            &amp;c-&gt;c2=2Epush_ifconfig_local, c-&gt;c1=
=2Etuntap-&gt;actual_name, NET_ROUTE_TABLE_DEFAULT,</span><br><span>       =
                       DCO_IROUTE_METRIC);</span><br><span> #endif</span><b=
r><span>         }</span><br><span>@@ -779,7 +779,7 @@</span><br><span>    =
     {</span><br><span>             /* On windows we do not install these r=
outes, so we also do not need to delete them */</span><br><span>           =
  net_route_v4_del(net_ctx, &amp;ifconfig_local, 32, NULL,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                             c-&gt;c1=
=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                             c-&gt;c1=2Etunta=
p-&gt;actual_name, NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_METRIC);</span><br><=
span>         }</span><br><span> #endif</span><br><span>     }</span><br><s=
pan>@@ -792,7 +792,7 @@</span><br><span>             dco_win_del_iroute_ipv=
6(&amp;c-&gt;c1=2Etuntap-&gt;dco, ir6-&gt;network, ir6-&gt;netbits);</span>=
<br><span> #else</span><br><span>             net_route_v6_del(net_ctx, &am=
p;ir6-&gt;network, ir6-&gt;netbits,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                             &amp;c-&gt;c2=2Epush_ifconfig_ip=
v6_local, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                             &amp;c-&gt;c2=2Epu=
sh_ifconfig_ipv6_local, c-&gt;c1=2Etuntap-&gt;actual_name, NET_ROUTE_TABLE_=
DEFAULT,</span><br><span>                              DCO_IROUTE_METRIC);<=
/span><br><span> #endif</span><br><span>         }</span><br><span>@@ -805,=
7 +805,7 @@</span><br><span>         {</span><br><span>             /* On w=
indows we do not install these routes, so we also do not need to delete the=
m */</span><br><span>             net_route_v6_del(net_ctx, dest, 128, NULL=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
         c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
 c-&gt;c1=2Etuntap-&gt;actual_name, NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_MET=
RIC);</span><br><span>         }</span><br><span> #endif</span><br><span>  =
   }</span><br><span>diff --git a/src/openvpn/networking=2Eh b/src/openvpn/=
networking=2Eh</span><br><span>index 7ad6e2e=2E=2Ef42ef4b 100644</span><br>=
<span>--- a/src/openvpn/networking=2Eh</span><br><span>+++ b/src/openvpn/ne=
tworking=2Eh</span><br><span>@@ -24,6 +24,9 @@</span><br><span> </span><br>=
<span> #define IFACE_TYPE_LEN_MAX 64</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/** net_route_*() table: Linux main tabl=
e, FreeBSD FIB of the process */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define NET_ROUTE_TABLE_DEFAULT -1</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> struct context;</span><br><sp=
an> </span><br><span> #ifdef ENABLE_SITNL</span><br><span>@@ -245,14 +248,1=
3 @@</span><br><span>  * @param prefixlen the length of the prefix of the d=
estination</span><br><span>  * @param gw        the gateway for this route<=
/span><br><span>  * @param iface     the interface for this route (can be N=
ULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param table  =
   the table to add this route to (if 0, will be added to the</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *                  main table)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param table     the=
 table to add this route to, or NET_ROUTE_TABLE_DEFAULT</span><br><span>  *=
 @param metric    the metric associated with the route</span><br><span>  *<=
/span><br><span>  * @return          0 on success, a negative error code ot=
herwise</span><br><span>  */</span><br><span> int net_route_v4_add(const op=
envpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                     const in_addr_t *=
gw, const openvpn_net_iface_t *iface, uint32_t table,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     const in_addr_t *gw,=
 const openvpn_net_iface_t *iface, int table,</span><br><span>             =
         int metric);</span><br><span> </span><br><span> /**</span><br><spa=
n>@@ -263,14 +265,13 @@</span><br><span>  * @param prefixlen the length of =
the prefix of the destination</span><br><span>  * @param gw        the gate=
way for this route</span><br><span>  * @param iface     the interface for t=
his route (can be NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * @param table     the table to add this route to (if 0, will be added t=
o the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *              =
    main table)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param table     the table to add this route to, or NET_ROUTE_TABLE_DEFAULT<=
/span><br><span>  * @param metric    the metric associated with the route</=
span><br><span>  *</span><br><span>  * @return          0 on success, a neg=
ative error code otherwise</span><br><span>  */</span><br><span> int net_ro=
ute_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int pr=
efixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
        const struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32=
_t table,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
           const struct in6_addr *gw, const openvpn_net_iface_t *iface, int=
 table,</span><br><span>                      int metric);</span><br><span>=
 </span><br><span> /**</span><br><span>@@ -281,14 +282,13 @@</span><br><spa=
n>  * @param prefixlen the length of the prefix of the destination</span><b=
r><span>  * @param gw        the gateway for this route</span><br><span>  *=
 @param iface     the interface for this route (can be NULL)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @param table     the table to add=
 this route to (if 0, will be added to the</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *                  main table)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param table     the table to add this=
 route to, or NET_ROUTE_TABLE_DEFAULT</span><br><span>  * @param metric    =
the metric associated with the route</span><br><span>  *</span><br><span>  =
* @return          0 on success, a negative error code otherwise</span><br>=
<span>  */</span><br><span> int net_route_v4_del(const openvpn_net_ctx_t *c=
tx, const in_addr_t *dst, int prefixlen,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                     const in_addr_t *gw, const openvpn_=
net_iface_t *iface, uint32_t table,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                     const in_addr_t *gw, const openvpn_net=
_iface_t *iface, int table,</span><br><span>                      int metri=
c);</span><br><span> </span><br><span> /**</span><br><span>@@ -299,14 +299,=
13 @@</span><br><span>  * @param prefixlen the length of the prefix of the =
destination</span><br><span>  * @param gw        the gateway for this route=
</span><br><span>  * @param iface     the interface for this route (can be =
NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param table =
    the table to add this route to (if 0, will be added to the</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *                  main table)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param table     th=
e table to add this route to, or NET_ROUTE_TABLE_DEFAULT</span><br><span>  =
* @param metric    the metric associated with the route</span><br><span>  *=
</span><br><span>  * @return          0 on success, a negative error code o=
therwise</span><br><span>  */</span><br><span> int net_route_v6_del(const o=
penvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                     const stru=
ct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                     const s=
truct in6_addr *gw, const openvpn_net_iface_t *iface, int table,</span><br>=
<span>                      int metric);</span><br><span> </span><br><span>=
 #endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD */</span><br><s=
pan>diff --git a/src/openvpn/networking_freebsd=2Ec b/src/openvpn/networkin=
g_freebsd=2Ec</span><br><span>index 88fd5c0=2E=2E8ba6326 100644</span><br><=
span>--- a/src/openvpn/networking_freebsd=2Ec</span><br><span>+++ b/src/ope=
nvpn/networking_freebsd=2Ec</span><br><span>@@ -10,7 +10,7 @@</span><br><sp=
an> </span><br><span> static int</span><br><span> net_route_v4(const char *=
op, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-             const char *iface, uin=
t32_t table, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+             const char *iface, int table, int metric)</span><br><span=
> {</span><br><span>     char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];=
</span><br><span>     in_addr_t _dst, _gw;</span><br><span>@@ -27,15 +27,20=
 @@</span><br><span>     if (gw)</span><br><span>     {</span><br><span>   =
      _gw =3D ntohl(*gw);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        argv_printf(&amp;argv, &quot;%s %s -net %s/%d %s -fib %d&quot;,=
 ROUTE_PATH, op,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     argv_printf(&amp;argv, &quot;%s %s -net %s/%d %s&quot;, ROUTE_PATH, op=
,</span><br><span>                     inet_ntop(AF_INET, &amp;_dst, buf1, =
sizeof(buf1)), prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    inet_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2)), t=
able);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       inet_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2)));</span><br><span> =
    }</span><br><span>     else</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;%s %s=
 -net %s/%d -iface %s -fib %d&quot;, ROUTE_PATH, op,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s %=
s -net %s/%d -iface %s&quot;, ROUTE_PATH, op,</span><br><span>             =
        inet_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)), prefixlen,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    iface, =
table);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* without -fi=
b, route(8) uses the FIB of the process */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (table &gt;=3D 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-fib %d&quot;, table=
);</span><br><span>     }</span><br><span> </span><br><span>     argv_msg(M=
_INFO, &amp;argv);</span><br><span>@@ -48,7 +53,7 @@</span><br><span> </spa=
n><br><span> static int</span><br><span> net_route_v6(const char *op, const=
 struct in6_addr *dst, int prefixlen, const struct in6_addr *gw,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-             const char *iface, =
uint32_t table, int metric)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+             const char *iface, int table, int metric)</span><br><s=
pan> {</span><br><span>     char buf1[INET6_ADDRSTRLEN], buf2[INET6_ADDRSTR=
LEN];</span><br><span>     struct argv argv =3D argv_new();</span><br><span=
>@@ -61,15 +66,19 @@</span><br><span>      */</span><br><span>     if (gw)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        argv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d %s -fib %d&quot;,=
 ROUTE_PATH, op,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     argv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d %s&quot;, ROUTE_PATH,=
 op,</span><br><span>                     inet_ntop(AF_INET6, dst, buf1, si=
zeof(buf1)), prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)), table);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)));</span><br><span>     }</span>=
<br><span>     else</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;%s -6 %s -net %s/=
%d -iface %s -fib %d&quot;, ROUTE_PATH, op,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s -6 %s -net =
%s/%d -iface %s&quot;, ROUTE_PATH, op,</span><br><span>                    =
 inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    iface, table);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ifac=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (table &gt;=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quo=
t;-fib %d&quot;, table);</span><br><span>     }</span><br><span> </span><br=
><span> </span><br><span>@@ -83,28 +92,28 @@</span><br><span> </span><br><s=
pan> int</span><br><span> net_route_v4_add(const openvpn_net_ctx_t *ctx, co=
nst in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                 const char *iface, uint3=
2_t table, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                 const char *iface, int table, int metric)</span><br><sp=
an> {</span><br><span>     return net_route_v4(&quot;add&quot;, dst, prefix=
len, gw, iface, table, metric);</span><br><span> }</span><br><span> </span>=
<br><span> int</span><br><span> net_route_v6_add(const openvpn_net_ctx_t *c=
tx, const struct in6_addr *dst, int prefixlen,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                 const struct in6_addr *gw, const =
char *iface, uint32_t table, int metric)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                 const struct in6_addr *gw, const char=
 *iface, int table, int metric)</span><br><span> {</span><br><span>     ret=
urn net_route_v6(&quot;add&quot;, dst, prefixlen, gw, iface, table, metric)=
;</span><br><span> }</span><br><span> </span><br><span> int</span><br><span=
> net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int =
prefixlen, const in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                 const char *iface, uint32_t table, int metric)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 cons=
t char *iface, int table, int metric)</span><br><span> {</span><br><span>  =
   return net_route_v4(&quot;del&quot;, dst, prefixlen, gw, iface, table, m=
etric);</span><br><span> }</span><br><span> </span><br><span> int</span><br=
><span> net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_add=
r *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                 const struct in6_addr *gw, const char *iface, uint32_t ta=
ble, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
              const struct in6_addr *gw, const char *iface, int table, int =
metric)</span><br><span> {</span><br><span>     return net_route_v6(&quot;d=
el&quot;, dst, prefixlen, gw, iface, table, metric);</span><br><span> }</sp=
an><br><span>diff --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn=
/networking_iproute2=2Ec</span><br><span>index d987478=2E=2E6c4c8f4 100644<=
/span><br><span>--- a/src/openvpn/networking_iproute2=2Ec</span><br><span>+=
++ b/src/openvpn/networking_iproute2=2Ec</span><br><span>@@ -243,7 +243,7 @=
@</span><br><span> </span><br><span> int</span><br><span> net_route_v4_add(=
const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in=
_addr_t *gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
        const char *iface, uint32_t table, int metric)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                 const char *iface, int =
table, int metric)</span><br><span> {</span><br><span>     struct argv argv=
 =3D argv_new();</span><br><span>     const char *dst_str =3D print_in_addr=
_t(*dst, 0, &amp;argv=2Egc);</span><br><span>@@ -281,7 +281,7 @@</span><br>=
<span> </span><br><span> int</span><br><span> net_route_v6_add(const openvp=
n_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                 const struct in6_ad=
dr *gw, const char *iface, uint32_t table, int metric)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                 const struct in6_addr *=
gw, const char *iface, int table, int metric)</span><br><span> {</span><br>=
<span>     struct argv argv =3D argv_new();</span><br><span>     char *dst_=
str =3D (char *)print_in6_addr(*dst, 0, &amp;argv=2Egc);</span><br><span>@@=
 -314,7 +314,7 @@</span><br><span> </span><br><span> int</span><br><span> n=
et_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int pre=
fixlen, const in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                 const char *iface, uint32_t table, int metric)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const c=
har *iface, int table, int metric)</span><br><span> {</span><br><span>     =
struct argv argv =3D argv_new();</span><br><span>     const char *dst_str =
=3D print_in_addr_t(*dst, 0, &amp;argv=2Egc);</span><br><span>@@ -340,7 +34=
0,7 @@</span><br><span> </span><br><span> int</span><br><span> net_route_v6=
_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixle=
n,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 co=
nst struct in6_addr *gw, const char *iface, uint32_t table, int metric)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const =
struct in6_addr *gw, const char *iface, int table, int metric)</span><br><s=
pan> {</span><br><span>     struct argv argv =3D argv_new();</span><br><spa=
n>     char *dst_str =3D (char *)print_in6_addr(*dst, 0, &amp;argv=2Egc);</=
span><br><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/=
networking_sitnl=2Ec</span><br><span>index b7c0f58=2E=2Eaf4ed27 100644</spa=
n><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/sr=
c/openvpn/networking_sitnl=2Ec</span><br><span>@@ -1115,14 +1115,11 @@</spa=
n><br><span> </span><br><span> static int</span><br><span> sitnl_route_add(=
const char *iface, sa_family_t af_family, const void *dst, int prefixlen,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                const v=
oid *gw, uint32_t table, int metric)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                const void *gw, int table, int metric)</sp=
an><br><span> {</span><br><span>     enum rt_scope_t scope =3D RT_SCOPE_UNI=
VERSE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (table =3D=3D 0)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        table =3D RT_TABLE_MAIN;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* table 0 is RT_TABLE_UNSPEC */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const uint32_t rt_table =3D tabl=
e &gt; 0 ? (uint32_t)table : RT_TABLE_MAIN;</span><br><span> </span><br><sp=
an>     if (!gw &amp;&amp; iface)</span><br><span>     {</span><br><span>@@=
 -1130,12 +1127,12 @@</span><br><span>     }</span><br><span> </span><br><s=
pan>     return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, iface, af_famil=
y, dst, prefixlen, gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                           table, metric, scope, RTPROT_BOOT, RTN_UNICAST)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
         rt_table, metric, scope, RTPROT_BOOT, RTN_UNICAST);</span><br><spa=
n> }</span><br><span> </span><br><span> int</span><br><span> net_route_v4_a=
dd(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const=
 in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
           const char *iface, uint32_t table, int metric)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                 const char *iface, i=
nt table, int metric)</span><br><span> {</span><br><span>     const in_addr=
_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;</span><br><span>     in_addr_t dst_=
be =3D 0, gw_be =3D 0;</span><br><span>@@ -1154,7 +1151,7 @@</span><br><spa=
n>         gw_ptr =3D &amp;gw_be;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot=
;%s: %s/%d via %s dev %s table %u metric %d&quot;, __func__,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d v=
ia %s dev %s table %d metric %d&quot;, __func__,</span><br><span>         i=
net_ntop(AF_INET, &amp;dst_be, dst_str, sizeof(dst_str)), prefixlen,</span>=
<br><span>         inet_ntop(AF_INET, &amp;gw_be, gw_str, sizeof(gw_str)), =
np(iface), table, metric);</span><br><span> </span><br><span>@@ -1163,7 +11=
60,7 @@</span><br><span> </span><br><span> int</span><br><span> net_route_v=
6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixl=
en,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 c=
onst struct in6_addr *gw, const char *iface, uint32_t table, int metric)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const=
 struct in6_addr *gw, const char *iface, int table, int metric)</span><br><=
span> {</span><br><span>     inet_address_t dst_v6;</span><br><span>     in=
et_address_t gw_v6;</span><br><span>@@ -1183,7 +1180,7 @@</span><br><span> =
        gw_v6=2Eipv6 =3D *gw;</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s:=
 %s/%d via %s dev %s table %u metric %d&quot;, __func__,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %=
s dev %s table %d metric %d&quot;, __func__,</span><br><span>         inet_=
ntop(AF_INET6, &amp;dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,</s=
pan><br><span>         inet_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str, sizeo=
f(gw_str)), np(iface), table, metric);</span><br><span> </span><br><span>@@=
 -1192,20 +1189,18 @@</span><br><span> </span><br><span> static int</span><=
br><span> sitnl_route_del(const char *iface, sa_family_t af_family, const i=
net_address_t *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                const inet_address_t *gw, uint32_t table, int =
metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    const inet_address_t *gw, int table, int metric)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (table =3D=3D 0)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        table =3D RT_TABLE_MAIN;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* table 0 is RT_TABLE_UNSPEC */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint32_t rt_ta=
ble =3D table &gt; 0 ? (uint32_t)table : RT_TABLE_MAIN;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_=
set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw, table, metric,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_rout=
e_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw, rt_table, metr=
ic,</span><br><span>                            RT_SCOPE_NOWHERE, 0, 0);</s=
pan><br><span> }</span><br><span> </span><br><span> int</span><br><span> ne=
t_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int pref=
ixlen, const in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                 const char *iface, uint32_t table, int metric)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const ch=
ar *iface, int table, int metric)</span><br><span> {</span><br><span>     i=
net_address_t dst_v4;</span><br><span>     inet_address_t gw_v4;</span><br>=
<span>@@ -1225,7 +1220,7 @@</span><br><span>         gw_v4=2Eipv4 =3D htonl=
(*gw);</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s ta=
ble %u metric %d&quot;, __func__,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %d metri=
c %d&quot;, __func__,</span><br><span>         inet_ntop(AF_INET, &amp;dst_=
v4=2Eipv4, dst_str, sizeof(dst_str)), prefixlen,</span><br><span>         i=
net_ntop(AF_INET, &amp;gw_v4=2Eipv4, gw_str, sizeof(gw_str)), np(iface), ta=
ble, metric);</span><br><span> </span><br><span>@@ -1234,7 +1229,7 @@</span=
><br><span> </span><br><span> int</span><br><span> net_route_v6_del(const o=
penvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                 const struct i=
n6_addr *gw, const char *iface, uint32_t table, int metric)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                 const struct in6_a=
ddr *gw, const char *iface, int table, int metric)</span><br><span> {</span=
><br><span>     inet_address_t dst_v6;</span><br><span>     inet_address_t =
gw_v6;</span><br><span>@@ -1254,7 +1249,7 @@</span><br><span>         gw_v6=
=2Eipv6 =3D *gw;</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: %s/%d via %s=
 dev %s table %u metric %d&quot;, __func__,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s tabl=
e %d metric %d&quot;, __func__,</span><br><span>         inet_ntop(AF_INET6=
, &amp;dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,</span><br><span=
>         inet_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str, sizeof(gw_str)), n=
p(iface), table, metric);</span><br><span> </span><br><span>diff --git a/sr=
c/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 94743=
9d=2E=2Ee51ece7 100644</span><br><span>--- a/src/openvpn/options=2Ec</span>=
<br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -831,7 +831,7 @@=
</span><br><span>     o-&gt;ce=2Emssfix =3D 0;</span><br><span>     o-&gt;c=
e=2Emssfix_default =3D true;</span><br><span>     o-&gt;ce=2Emssfix_encap =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o-&gt;ro=
ute_default_table_id =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    o-&gt;route_default_table_id =3D NET_ROUTE_TABLE_DEFAULT;</span=
><br><span>     o-&gt;route_delay_window =3D 30;</span><br><span>     o-&gt=
;resolve_retry_seconds =3D RESOLV_RETRY_INFINITE;</span><br><span>     o-&g=
t;resolve_in_advance =3D false;</span><br><span>@@ -5297,7 +5297,11 @@</spa=
n><br><span>         msg(M_WARN, &quot;NOTE: --route-table is supported onl=
y on Linux when SITNL is built-in&quot;);</span><br><span> #endif</span><br=
><span>         VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;route_default_table_id =
=3D positive_atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;options-&gt;route_d=
efault_table_id, p[0], 0, INT_MAX,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                              msglevel))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><spa=
n>     else if (streq(p[0], &quot;route&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[5])</span><br><span>     {</span><br><span>diff --git a/src/openvpn/route=
=2Ec b/src/openvpn/route=2Ec</span><br><span>index 9086529=2E=2E82cb7f0 100=
644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/o=
penvpn/route=2Ec</span><br><span>@@ -545,6 +545,7 @@</span><br><span>      =
   /* split a route into two smaller blocking routes, and direct them to ta=
rget */</span><br><span>         l2 =3D ((~gateway-&gt;netmask) + 1) &gt;&g=
t; 1;</span><br><span>         r1-&gt;flags =3D RT_DEFINED;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        r1-&gt;table_id =3D NET_ROU=
TE_TABLE_DEFAULT;</span><br><span>         r1-&gt;gateway =3D target;</span=
><br><span>         r1-&gt;network =3D gateway-&gt;addr &amp; gateway-&gt;n=
etmask;</span><br><span>         r1-&gt;netmask =3D ~(l2 - 1);</span><br><s=
pan>@@ -854,6 +855,7 @@</span><br><span>                 r6-&gt;gateway =3D=
 rl6-&gt;rgi6=2Egateway=2Eaddr_ipv6;</span><br><span>             }</span><=
br><span>             r6-&gt;metric =3D 1;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            r6-&gt;table_id =3D NET_ROUTE_TABLE_DEFA=
ULT;</span><br><span> #ifdef _WIN32</span><br><span>             r6-&gt;ada=
pter_index =3D rl6-&gt;rgi6=2Eadapter_index;</span><br><span> #else</span><=
br><span>@@ -883,6 +885,7 @@</span><br><span>     struct route_ipv4 r;</spa=
n><br><span>     CLEAR(r);</span><br><span>     r=2Eflags =3D RT_DEFINED;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=2Etable_id =3D =
NET_ROUTE_TABLE_DEFAULT;</span><br><span>     r=2Enetwork =3D network;</spa=
n><br><span>     r=2Enetmask =3D netmask;</span><br><span>     r=2Egateway =
=3D gateway;</span><br><span>@@ -897,6 +900,7 @@</span><br><span>     struc=
t route_ipv4 r;</span><br><span>     CLEAR(r);</span><br><span>     r=2Efla=
gs =3D RT_DEFINED | RT_ADDED;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    r=2Etable_id =3D NET_ROUTE_TABLE_DEFAULT;</span><br><span>   =
  r=2Enetwork =3D network;</span><br><span>     r=2Enetmask =3D netmask;</s=
pan><br><span>     r=2Egateway =3D gateway;</span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_networking=2Ec b/tests/unit_tests/openvpn/test_=
networking=2Ec</span><br><span>index b580d32=2E=2E636adda 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_networking=2Ec</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_networking=2Ec</span><br><span>@@ -112,7 =
+112,7 @@</span><br><span>     }</span><br><span>     printf(&quot;\n&quot;=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return net_route_v4_add(NULL, &amp;dst, prefixlen, NULL, iface, 0, metri=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return net_r=
oute_v4_add(NULL, &amp;dst, prefixlen, NULL, iface, NET_ROUTE_TABLE_DEFAULT=
, metric);</span><br><span> }</span><br><span> </span><br><span> static int=
</span><br><span>@@ -148,7 +148,7 @@</span><br><span>     }</span><br><span=
>     printf(&quot;\n&quot;);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return net_route_v4_add(NULL, &amp;dst, prefi=
xlen, &amp;gw, iface, 0, metric);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return net_route_v4_add(NULL, &amp;dst, prefixlen, &amp;g=
w, iface, NET_ROUTE_TABLE_DEFAULT, metric);</span><br><span> }</span><br><s=
pan> </span><br><span> static int</span><br><span>@@ -175,7 +175,7 @@</span=
><br><span>     }</span><br><span>     printf(&quot;\n&quot;);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return net_r=
oute_v6_add(NULL, &amp;dst, prefixlen, NULL, iface, 0, metric);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return net_route_v6_add(NUL=
L, &amp;dst, prefixlen, NULL, iface, NET_ROUTE_TABLE_DEFAULT, metric);</spa=
n><br><span> }</span><br><span> </span><br><span> static int</span><br><spa=
n>@@ -208,7 +208,7 @@</span><br><span>     }</span><br><span>     printf(&q=
uot;\n&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return net_route_v6_add(NULL, &amp;dst, prefixlen, &amp;gw, =
iface, 0, metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return net_route_v6_add(NULL, &amp;dst, prefixlen, &amp;gw, iface, NET_R=
OUTE_TABLE_DEFAULT, metric);</span><br><span> }</span><br><span> </span><br=
><span> static void</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail">change 2224</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icbfc6b64beea5e70=
f32449c5a63a08ad862597b9 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2224 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
=
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ant=
onio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></htm=
l>
--EygcJA2dlTg=--


--===============3015608954439865810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3015608954439865810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3015608954439865810==--

