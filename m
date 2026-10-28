Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73973606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nVrbiwbv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QpL8xI9D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HNWAxS9f;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eScCkFPJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=m703nJsfYx88NauO2p+WLwAgxVUDe+bdmAoUM63zlNc=; b=nVrbiwbvD8/yekrpe//YqqQIHi
	07q1J+aGtm5rb2x/pONPrXbdpipDcAI8a3to8KxzCBJE7/+007nJKGweg30Q4QcXqeJebmfhpYLnV
	oLRoVgXXS1TBJLtWkK8zTdyzsAUctPZ1rUgWed59LG3IRg3jie+eu7JKOqK5fjAB7X64=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM3rg-000000007FF-02II;
	Wed, 28 Oct 2026 13:38:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM3r1-000000007Ee-1E9U
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:38:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i2/wDB0h/0n4J0Thj/hVtOwFRqIQbrYuQZZHdduswys=; b=QpL8xI9DtW116sRR62pUch/94E
 ByfgZ1xj8aQ+4s5e6w9OAyuwUHbFlnaVZF7uKE21Ele9/EdqIqLIpCoirX072dP1C6f+Scan/l/6K
 jwx8nf70a50FmYCvJNz1i14i52HBsIRe8lOsT6JPDNH2xr6hsfMlWCfElh6NQreKFM3E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i2/wDB0h/0n4J0Thj/hVtOwFRqIQbrYuQZZHdduswys=; b=HNWAxS9fSmFyILUu3u8Klo3NFf
 0CtnNZftuG5VSGUNLzDhNkpvbSqdICY06N2c9fzXt7+lKVsFYF+FxGQQZ+tOql7iRhTKq0YMD0KyW
 RgOp97yv224bdeTz7+UEabLDCz/UNHQG+yl3AdFeZl+sjBJdHMpmDejB5Ylf6qSK/bNU=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM3qz-0000000089w-1jJr for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:38:11 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so864319f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793194683; x=1793799483; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=i2/wDB0h/0n4J0Thj/hVtOwFRqIQbrYuQZZHdduswys=;
 b=eScCkFPJbZ4oV8q8RuVU5O9rjCF0LP7k8yFNgs8HHMoftvhU9TmkmFP1MJXSGComqj
 370k+60KE0PbuAmdGmV+NgaWxWMUfLdGNBl0nMvi+Dsu4+uVA/5h1SZFzSrdXHiTF6Ep
 P/3QFOtEEdYh4JvMW9Ap8rlxUptg2rXDCp4pDenhNdbJcf+LgzsFK101KoYadK0jgeb9
 cUG6hrhVCFQBR5ZA/XQ36JlnQyLP5Zwh0WhsyYixOSlXxKGLuaOTKOCRXw5mB1FWr2M5
 pEDpMj7Oc+Tg8TveOUS4saMTgd5Gp0kaPmqVNvOMiA0MbYgVaVqqDtv92TEzImfcW1yv
 ODUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793194683; x=1793799483;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i2/wDB0h/0n4J0Thj/hVtOwFRqIQbrYuQZZHdduswys=;
 b=jjbfQoilP/GlZ4w9AitIvPxbkjg85rAZYXRxbmzu5oqsa1w+puCgAljMSNNtww8Tfj
 CwIdUt/NgU8JyqIi21+M+WU0OgLIkCZ9f3mpejei+NmzUPGZciDV9i8HGfcWTw7J5giZ
 ZglbAZOljvhJVCntk4dcQMGNEXcgFU7zrMKMLdAISbRqLtcylBBOF3p1/8mYKEaRTCDu
 UNJib9nePm/9eoYmsvFQvtQiTI7OC8ZeMkiT4AGfuKmMRwbwGV6j640oAy8In4ADqAsk
 +yhy7jPDTTwpIjHOO7r6JXBZiHcPgv3TMIUokjWLZe1Fh3enkowlsSKdhMmOi0u9Qsmp
 k8GQ==
X-Gm-Message-State: AFq9FYKfMfrxP+K1+MlpGEG6t0G+lEm/hYCDu8wdTtKZ8ObTgYT0PYGl
 176JVue0JkU8LQUSIhHQ2/fUpfGJjsGlJQ8wIya7C9FlSbS9UG98s/vrKIQ5juxVpMe2N7UlC64
 ANkEvAJ31R2G5RYbqEicqJhLxRB2Q3Tz5XZdlSatFXorFiAK5ccGkYcF5MgyNzaaOjXtj
X-Gm-Gg: AYBFou2lLFAlNzwQzO2KbfHUEXH8IA7BmaKJlohiKjSOtRtXMRZ5/pb+eQpcZjZynYO
 qoV9bD26Wu+LSNEnGY3cXBD5VD0ASXscV3rQ8PzDEz40dsHZK4k6Ik2tvtQjxcjRCkvTe7sVEUC
 mjUmtPdRdmkai3ESQ905fUePNK82TFdxA+/5fYmQDz/qYCAkDCHLZtYRWcuZiww7lX/PjijKLsL
 6O8mqy9r8ZtF4K1/t5R0s1ueJbo8hHcfqqxOlo8eP3qkE9ScWi1PRfU8gYPQqjSaCRP5daIHFaA
 gnNC5srBcvUtH6Y42NqXRa631k+xllL6z11SDyq1P8LXpzDMs+2ZfjUrHZBW+vxegijUmiF4kVB
 LpXNBkiqe8QFiFQ8yp27eZ+CHesJh3OByc7Vdvza22dUXJO4S/TXnyV7PjKwgRWnuoRDWoVEDu+
 S1nJ2Oz04ylTGr49itexwUl0ah//jLZlWYnh61OV/QLUNTEiyxbZKK2AfEe9xusiylLIQKx+Kup
 DyVY99CeC8aujnENjtnIWgISd2Y4ImlmqTaTVADBIJq3VghyQuXS7EZLmLsVyRT+pXFsFyX/WPG
 OOsLxZRcifdF4eSryj+LvGVJV8jadsbV6sKb4XtUdhEPCE2TFbcKUosu7VGCjZGM6/ixx309Rrt
 AYy02bjpOk78SCjcalHeYKICIphVUyoBo+15hcgCIiYodKnr0ShqkqxxmQzUKkSjoE0zCkgGwni
 0B63iFkhqyp3cOU9A=
X-Received: by 2002:a05:600c:a30a:b0:4a4:4d57:8462 with SMTP id
 5b1f17b1804b1-4a9672f8143mr34294945e9.24.1793194682271; 
 Wed, 28 Oct 2026 06:38:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97c42bb6fsm50763765e9.7.2026.10.28.06.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:38:01 -0700 (PDT)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 13:38:01 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270
X-Gerrit-Change-Number: 2061
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2061?usp=email>
X-Gerrit-Commit: 1f49d662c74f4b3abe7fa74a5d9457ed78c061d7
References: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkljMGI4YjBhMzI0OWViNDFlMWRlMTBmMzgxOTMyYzExNjFjZDc1MjcwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cd07d3f5e54d017bcfbe42fe51f0f963f16c9094-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM3qz-0000000089w-1jJr
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: track installed
 iroutes separately for IPv4 and IPv6
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2101967666376049126=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2101967666376049126==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A5LBCN+M9FU="; charset=UTF-8

--A5LBCN+M9FU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2061?usp=3Demail

to review the following change=2E
=


Change subject: dco: track installed iroutes separately for IPv4 and IPv6=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: track=
 installed iroutes separately for IPv4 and IPv6

Track successful route ins=
tallation per address family and split route
deletion into IPv4 and IPv6 he=
lpers=2E Keep the combined deletion API for
existing callers and update del=
ayed-exit cleanup=2E Return installation status
from the Windows helpers an=
d keep the non-DCO declarations compatible=2E

Change-Id: Ic0b8b0a3249eb41e=
1de10f381932c1161cd75270
Signed-off-by: Marco Baffo <marco@mandelbit=2Ecom>=

---
M src/openvpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/dco_win=2Ec
=
M src/openvpn/dco_win=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/multi=2Ec=

M src/openvpn/openvpn=2Eh
7 files changed, 104 insertions(+), 31 deletions=
(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/6=
1/2061/1

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index f3b5=
d44=2E=2E535b1c7 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec=

@@ -706,8 +706,8 @@
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
 #if def=
ined(_WIN32)
-        dco_win_add_iroute_ipv6(&c->c1=2Etuntap->dco, addr->v=
6=2Eaddr, addr->netbits,
-                                c->c2=2Etls_multi=
->rx_peer_id);
+        bool installed =3D dco_win_add_iroute_ipv6(&c->c1=
=2Etuntap->dco, addr->v6=2Eaddr, addr->netbits,
+                          =
                       c->c2=2Etls_multi->rx_peer_id);
 #else
         cons=
t struct in6_addr *gateway =3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_local=
;
         if (addr->type & MR_ONLINK_DCO_ADDR)
@@ -715,16 +715,18 @@
     =
        gateway =3D NULL;
         }
 
-        net_route_v6_add(&m->top=2E=
net_ctx, &addr->v6=2Eaddr, addr->netbits,
-                         gateway=
, c->c1=2Etuntap->actual_name, 0,
-                         DCO_IROUTE_METR=
IC);
+        bool installed =3D net_route_v6_add(&m->top=2Enet_ctx, &addr-=
>v6=2Eaddr, addr->netbits,
+                                          gatew=
ay, c->c1=2Etuntap->actual_name, 0,
+                                      =
    DCO_IROUTE_METRIC)
+                         =3D=3D 0;
 #endif
+       =
 mi->context=2Edid_dco_iroutes_v6 |=3D installed;
     }
     else if (addr=
type =3D=3D MR_ADDR_IPV4)
     {
 #if defined(_WIN32)
-        dco_win_add_=
iroute_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->netbits,
-        =
                        c->c2=2Etls_multi->rx_peer_id);
+        bool insta=
lled =3D dco_win_add_iroute_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, add=
r->netbits,
+                                                 c->c2=2Etls_m=
ulti->rx_peer_id);
 #else
         in_addr_t dest =3D htonl(addr->v4=2Eaddr=
);
         const in_addr_t *gateway =3D &mi->context=2Ec2=2Epush_ifconfig_=
local;
@@ -733,15 +735,17 @@
             gateway =3D NULL;
         }
 
- =
       net_route_v4_add(&m->top=2Enet_ctx, &dest, addr->netbits, gateway,
-=
                         c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC)=
;
+        bool installed =3D net_route_v4_add(&m->top=2Enet_ctx, &dest, ad=
dr->netbits, gateway,
+                                          c->c1=2Etu=
ntap->actual_name, 0, DCO_IROUTE_METRIC)
+                         =3D=3D 0=
;
 #endif
+        mi->context=2Edid_dco_iroutes_v4 |=3D installed;
     }
=
 #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_=
WIN32) */
 }
 
 void
-dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const =
struct context *c)
+dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const=
 struct context *c)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD=
) || defined(_WIN32)
     if (!dco_enabled(&c->options))
@@ -750,7 +754,7 @=
@
     }
     ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D DEV_TYPE_TUN);
 
- =
   msg(D_DCO, "DCO: attempt removing iroutes from system table");
+    msg(=
D_DCO, "DCO: attempt removing IPv4 iroutes from system table");
 
     if (=
c->c2=2Epush_ifconfig_defined)
     {
@@ -778,6 +782,20 @@
         }
 #end=
if
     }
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) ||=
 defined(_WIN32) */
+}
+
+void
+dco_delete_iroutes_v6(openvpn_net_ctx_t *ne=
t_ctx, const struct context *c)
+{
+#if defined(TARGET_LINUX) || defined(TA=
RGET_FREEBSD) || defined(_WIN32)
+    if (!dco_enabled(&c->options))
+    {=

+        return;
+    }
+    ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D DEV=
_TYPE_TUN);
+
+    msg(D_DCO, "DCO: attempt removing IPv6 iroutes from syst=
em table");
 
     if (c->c2=2Epush_ifconfig_ipv6_defined)
     {
@@ -807,4=
 +825,11 @@
 #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) =
|| defined(_WIN32) */
 }
 
+void
+dco_delete_iroutes(openvpn_net_ctx_t *net=
_ctx, const struct context *c)
+{
+    dco_delete_iroutes_v4(net_ctx, c);
+=
    dco_delete_iroutes_v6(net_ctx, c);
+}
+
 #endif /* defined(ENABLE_DCO) =
*/
diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index c435f8c=2E=
=2Edaedb96 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -2=
18,6 +218,22 @@
                         const struct mroute_addr *addr);
 =

 /**
+ * Remove all IPv4 routes added through the specified client
+ *
+ *=
 @param net_ctx   the iface networking context
+ * @param c         the cli=
ent context for which routes have to be removed
+ */
+void dco_delete_irout=
es_v4(openvpn_net_ctx_t *net_ctx, const struct context *c);
+
+/**
+ * Remo=
ve all IPv6 routes added through the specified client
+ *
+ * @param net_ct=
x   the iface networking context
+ * @param c         the client context fo=
r which routes have to be removed
+ */
+void dco_delete_iroutes_v6(openvpn_=
net_ctx_t *net_ctx, const struct context *c);
+
+/**
  * Remove all routes =
added through the specified client
  *
  * @param net_ctx   the iface netwo=
rking context
@@ -356,7 +372,17 @@
 }
 
 static inline void
-dco_install_ir=
oute(struct multi_context *m, struct multi_instance *mi, struct mroute_addr=
 *addr)
+dco_install_iroute(struct multi_context *m, struct multi_instance =
*mi, const struct mroute_addr *addr)
+{
+}
+
+static inline void
+dco_delet=
e_iroutes_v4(openvpn_net_ctx_t *net_ctx, const struct context *c)
+{
+}
+
+=
static inline void
+dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, const=
 struct context *c)
 {
 }
 
diff --git a/src/openvpn/dco_win=2Ec b/src/open=
vpn/dco_win=2Ec
index 12b0666=2E=2E68ae7c5 100644
--- a/src/openvpn/dco_win=
=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -1007,7 +1007,7 @@
     return dco_ge=
t_version(&ver) && ver=2EMajor >=3D 2;
 }
 
-void
+bool
 dco_win_add_iroute=
_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,
            =
             unsigned int peer_id)
 {
@@ -1021,16 +1021,18 @@
         netb=
its, peer_id);
 
     DWORD bytes_returned =3D 0;
-    if (!DeviceIoControl=
(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
-=
                         &bytes_returned, NULL))
+    bool installed =3D De=
viceIoControl(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route=
), NULL, 0,
+                                     &bytes_returned, NULL);
+=
    if (!installed)
     {
         msg(M_WARN | M_ERRNO, "DeviceIoControl(=
OVPN_IOCTL_MP_ADD_IROUTE) failed");
     }
 
     gc_free(&gc);
+    return=
 installed;
 }
 
-void
+bool
 dco_win_add_iroute_ipv6(dco_context_t *dco, s=
truct in6_addr dst, unsigned int netbits,
                         unsigned=
 int peer_id)
 {
@@ -1042,13 +1044,15 @@
         netbits, peer_id);
 
    =
 DWORD bytes_returned =3D 0;
-    if (!DeviceIoControl(dco->tt->hand, OVPN_=
IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
-                     =
    &bytes_returned, NULL))
+    bool installed =3D DeviceIoControl(dco->tt=
->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
+        =
                             &bytes_returned, NULL);
+    if (!installed)
 =
    {
         msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_ADD_IRO=
UTE) failed");
     }
 
     gc_free(&gc);
+    return installed;
 }
 
 voi=
d
diff --git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh
index a92e=
5ad=2E=2E28795b7 100644
--- a/src/openvpn/dco_win=2Eh
+++ b/src/openvpn/dco=
_win=2Eh
@@ -67,10 +67,10 @@
 
 bool dco_win_supports_multipeer(void);
 
-v=
oid dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int=
 netbits,
+bool dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, =
unsigned int netbits,
                              unsigned int peer_id);
=
 
-void dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, un=
signed int netbits,
+bool dco_win_add_iroute_ipv6(dco_context_t *dco, struc=
t in6_addr dst, unsigned int netbits,
                              unsigne=
d int peer_id);
 
 void dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr=
_t dst, unsigned int netbits);
diff --git a/src/openvpn/forward=2Ec b/src/o=
penvpn/forward=2Ec
index 681210d=2E=2E7b6f4f8 100644
--- a/src/openvpn/forw=
ard=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -550,9 +550,10 @@
      * last con=
necting client claiming the iroutes takes ownership=2E Therefore
      * th=
ey are not removed during delayed cleanup=2E
      */
-    if (c->did_dco_i=
routes)
+    if (c->did_dco_iroutes_v4 || c->did_dco_iroutes_v6)
     {
-  =
      c->did_dco_iroutes =3D false;
+        c->did_dco_iroutes_v4 =3D fals=
e;
+        c->did_dco_iroutes_v6 =3D false;
         dco_delete_iroutes(&c=
->net_ctx, c);
     }
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mu=
lti=2Ec
index b8a829c=2E=2Eedeef96 100644
--- a/src/openvpn/multi=2Ec
+++ b=
/src/openvpn/multi=2Ec
@@ -478,6 +478,28 @@
     set_prefix(mi);
 }
 
+stat=
ic void
+multi_del_dco_iroutes_v4(struct multi_context *m, struct multi_ins=
tance *mi)
+{
+    /* Skip DCO IPv4 iroutes that have already been removed=
=2E */
+    if (mi->context=2Edid_dco_iroutes_v4)
+    {
+        mi->conte=
xt=2Edid_dco_iroutes_v4 =3D false;
+        dco_delete_iroutes_v4(&m->top=
=2Enet_ctx, &mi->context);
+    }
+}
+
+static void
+multi_del_dco_iroutes_=
v6(struct multi_context *m, struct multi_instance *mi)
+{
+    /* Skip DCO =
IPv6 iroutes that have already been removed=2E */
+    if (mi->context=2Edi=
d_dco_iroutes_v6)
+    {
+        mi->context=2Edid_dco_iroutes_v6 =3D fals=
e;
+        dco_delete_iroutes_v6(&m->top=2Enet_ctx, &mi->context);
+    }
=
+}
+
 /*
  * Tell the route helper about deleted iroutes so
  * that it can=
 update its mask of currently used
@@ -489,12 +511,8 @@
     const struct i=
route *ir;
     const struct iroute_ipv6 *ir6;
 
-    /* check if DCO irout=
es were already removed when scheduling a delayed exit */
-    if (mi->cont=
ext=2Edid_dco_iroutes)
-    {
-        mi->context=2Edid_dco_iroutes =3D fa=
lse;
-        dco_delete_iroutes(&m->top=2Enet_ctx, &mi->context);
-    }
+=
    multi_del_dco_iroutes_v4(m, mi);
+    multi_del_dco_iroutes_v6(m, mi);
=
 
     if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
    =
 {
@@ -1305,8 +1323,6 @@
     if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =
=3D=3D DEV_TYPE_TUN)
     {
         mi->did_iroutes =3D true;
-        /* =
multi_learn_in{6}_addr_t takes care of installing the DCO iroute */
-      =
  mi->context=2Edid_dco_iroutes =3D true;
         for (ir =3D mi->context=
=2Eoptions=2Eiroutes; ir !=3D NULL; ir =3D ir->next)
         {
           =
  if (ir->netbits >=3D 0)
diff --git a/src/openvpn/openvpn=2Eh b/src/openvp=
n/openvpn=2Eh
index cdd02b6=2E=2E72436fe 100644
--- a/src/openvpn/openvpn=
=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -507,7 +507,8 @@
     bool did_we_dae=
monize;       /**< Whether demonization has already
                       =
            *   taken place=2E */
 
-    bool did_dco_iroutes;        /**< =
Whether DCO iroutes have been installed */
+    bool did_dco_iroutes_v4;   =
  /**< Whether DCO IPv4 iroutes have been installed */
+    bool did_dco_ir=
outes_v6;     /**< Whether DCO IPv6 iroutes have been installed */
 
     s=
truct context_persist persist;
     /**< Persistent %context=2E */

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f38=
1932c1161cd75270
Gerrit-Change-Number: 2061
Gerrit-PatchSet: 1
Gerrit-Owner=
: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--A5LBCN+M9FU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Marco Baffo would like Arne S=
chwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail">View Change</a></p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">dco: track installed iroutes separately for IPv4 and IPv6<br><br=
>Track successful route installation per address family and split route<br>=
deletion into IPv4 and IPv6 helpers=2E Keep the combined deletion API for<b=
r>existing callers and update delayed-exit cleanup=2E Return installation s=
tatus<br>from the Windows helpers and keep the non-DCO declarations compati=
ble=2E<br><br>Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270<br>Signe=
d-off-by: Marco Baffo &lt;marco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn=
/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/dco_win=2Ec<br>M src/ope=
nvpn/dco_win=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/multi=2Ec<br=
>M src/openvpn/openvpn=2Eh<br>7 files changed, 104 insertions(+), 31 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/61/2061/1</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec =
b/src/openvpn/dco=2Ec</span><br><span>index f3b5d44=2E=2E535b1c7 100644</sp=
an><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dc=
o=2Ec</span><br><span>@@ -706,8 +706,8 @@</span><br><span>     if (addrtype=
 =3D=3D MR_ADDR_IPV6)</span><br><span>     {</span><br><span> #if defined(_=
WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_win=
_add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&=
gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                      c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        bool installed =3D dco_win_=
add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&g=
t;netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                        c-&gt;c2=2Etls_multi-&gt;rx_peer_id=
);</span><br><span> #else</span><br><span>         const struct in6_addr *g=
ateway =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><=
span>         if (addr-&gt;type &amp; MR_ONLINK_DCO_ADDR)</span><br><span>@=
@ -715,16 +715,18 @@</span><br><span>             gateway =3D NULL;</span><=
br><span>         }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        net_route_v6_add(&amp;m-&gt;top=2Enet_ctx, &amp;add=
r-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                         gateway, c-&gt;c1=2Etuntap-&gt;actual=
_name, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
             DCO_IROUTE_METRIC);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        bool installed =3D net_route_v6_add(&amp;m-&gt;top=2En=
et_ctx, &amp;addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                          ga=
teway, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                          DCO_IROU=
TE_METRIC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                =3D=3D 0;</span><br><span> #endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Edid_dco_iroutes_v6 |=
=3D installed;</span><br><span>     }</span><br><span>     else if (addrtyp=
e =3D=3D MR_ADDR_IPV4)</span><br><span>     {</span><br><span> #if defined(=
_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_wi=
n_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v4=2Eaddr, addr-=
&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                       c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        bool installed =3D dco_win=
_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v4=2Eaddr, addr-&=
gt;netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                         c-&gt;c2=2Etls_multi-&gt;rx_peer_i=
d);</span><br><span> #else</span><br><span>         in_addr_t dest =3D hton=
l(addr-&gt;v4=2Eaddr);</span><br><span>         const in_addr_t *gateway =
=3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><span>@@ -733=
,15 +735,17 @@</span><br><span>             gateway =3D NULL;</span><br><sp=
an>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        net_route_v4_add(&amp;m-&gt;top=2Enet_ctx, &amp;dest, add=
r-&gt;netbits, gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                         c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_IROUTE=
_METRIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bo=
ol installed =3D net_route_v4_add(&amp;m-&gt;top=2Enet_ctx, &amp;dest, addr=
-&gt;netbits, gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                          c-&gt;c1=2Etuntap-&gt;actual_n=
ame, 0, DCO_IROUTE_METRIC)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                         =3D=3D 0;</span><br><span> #endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Edid_=
dco_iroutes_v4 |=3D installed;</span><br><span>     }</span><br><span> #end=
if /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32=
) */</span><br><span> }</span><br><span> </span><br><span> void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-dco_delete_iroutes(openvpn_net_ct=
x_t *net_ctx, const struct context *c)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const =
struct context *c)</span><br><span> {</span><br><span> #if defined(TARGET_L=
INUX) || defined(TARGET_FREEBSD) || defined(_WIN32)</span><br><span>     if=
 (!dco_enabled(&amp;c-&gt;options))</span><br><span>@@ -750,7 +754,7 @@</sp=
an><br><span>     }</span><br><span>     ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etunt=
ap) =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    msg(D_DCO, &quot;DCO: attempt removing iroutes fr=
om system table&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    msg(D_DCO, &quot;DCO: attempt removing IPv4 iroutes from system tab=
le&quot;);</span><br><span> </span><br><span>     if (c-&gt;c2=2Epush_ifcon=
fig_defined)</span><br><span>     {</span><br><span>@@ -778,6 +782,20 @@</s=
pan><br><span>         }</span><br><span> #endif</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(TA=
RGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_delete_=
iroutes_v6(openvpn_net_ctx_t *net_ctx, const struct context *c)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEB=
SD) || defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASS=
ERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    msg(D_DCO, &quot;DCO: attempt removing IPv6 iroutes f=
rom system table&quot;);</span><br><span> </span><br><span>     if (c-&gt;c=
2=2Epush_ifconfig_ipv6_defined)</span><br><span>     {</span><br><span>@@ -=
807,4 +825,11 @@</span><br><span> #endif /* if defined(TARGET_LINUX) || def=
ined(TARGET_FREEBSD) || defined(_WIN32) */</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dco_delete_iroutes(openvpn_net=
_ctx_t *net_ctx, const struct context *c)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    dco_delete_iroutes_v4(net_ctx, c);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    dco_delete_iroutes_v6(net_ctx, c);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> #endif /* defined(ENABLE_DCO) */<=
/span><br><span>diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh</spa=
n><br><span>index c435f8c=2E=2Edaedb96 100644</span><br><span>--- a/src/ope=
nvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</span><br><span>@@ -=
218,6 +218,22 @@</span><br><span>                         const struct mrou=
te_addr *addr);</span><br><span> </span><br><span> /**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Remove all IPv4 routes added through =
the specified client</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param net_ct=
x   the iface networking context</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param c         the client context for which routes have t=
o be removed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void dco_delete_iroutes=
_v4(openvpn_net_ctx_t *net_ctx, const struct context *c);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Remove all IPv6 routes added through the specified client</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param net_ctx   the iface networking context=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c        =
 the client context for which routes have to be removed</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, =
const struct context *c);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span>  * Remove all routes added through the specified client</span><br><=
span>  *</span><br><span>  * @param net_ctx   the iface networking context<=
/span><br><span>@@ -356,7 +372,17 @@</span><br><span> }</span><br><span> </=
span><br><span> static inline void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-dco_install_iroute(struct multi_context *m, struct multi_insta=
nce *mi, struct mroute_addr *addr)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+dco_install_iroute(struct multi_context *m, struct multi_ins=
tance *mi, const struct mroute_addr *addr)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+dco_delete_iroutes_v4(openvpn_net=
_ctx_t *net_ctx, const struct context *c)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+dco_delete_iroutes_v6(openvpn_net_=
ctx_t *net_ctx, const struct context *c)</span><br><span> {</span><br><span=
> }</span><br><span> </span><br><span>diff --git a/src/openvpn/dco_win=2Ec =
b/src/openvpn/dco_win=2Ec</span><br><span>index 12b0666=2E=2E68ae7c5 100644=
</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/op=
envpn/dco_win=2Ec</span><br><span>@@ -1007,7 +1007,7 @@</span><br><span>   =
  return dco_get_version(&amp;ver) &amp;&amp; ver=2EMajor &gt;=3D 2;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span> dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, =
unsigned int netbits,</span><br><span>                         unsigned int=
 peer_id)</span><br><span> {</span><br><span>@@ -1021,16 +1021,18 @@</span>=
<br><span>         netbits, peer_id);</span><br><span> </span><br><span>   =
  DWORD bytes_returned =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IRO=
UTE, &amp;route, sizeof(route), NULL, 0,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                         &amp;bytes_returned, NULL))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool installed =3D =
DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route, =
sizeof(route), NULL, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                     &amp;bytes_returned, NULL);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!installed)</span>=
<br><span>     {</span><br><span>         msg(M_WARN | M_ERRNO, &quot;Devic=
eIoControl(OVPN_IOCTL_MP_ADD_IROUTE) failed&quot;);</span><br><span>     }<=
/span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return installed;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span> dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsi=
gned int netbits,</span><br><span>                         unsigned int pee=
r_id)</span><br><span> {</span><br><span>@@ -1042,13 +1044,15 @@</span><br>=
<span>         netbits, peer_id);</span><br><span> </span><br><span>     DW=
ORD bytes_returned =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE,=
 &amp;route, sizeof(route), NULL, 0,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                         &amp;bytes_returned, NULL))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    bool installed =3D Devi=
ceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route, size=
of(route), NULL, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                     &amp;bytes_returned, NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!installed)</span><br>=
<span>     {</span><br><span>         msg(M_WARN | M_ERRNO, &quot;DeviceIoC=
ontrol(OVPN_IOCTL_MP_ADD_IROUTE) failed&quot;);</span><br><span>     }</spa=
n><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return installed;</span><br><span> }<=
/span><br><span> </span><br><span> void</span><br><span>diff --git a/src/op=
envpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh</span><br><span>index a92e5ad=
=2E=2E28795b7 100644</span><br><span>--- a/src/openvpn/dco_win=2Eh</span><b=
r><span>+++ b/src/openvpn/dco_win=2Eh</span><br><span>@@ -67,10 +67,10 @@</=
span><br><span> </span><br><span> bool dco_win_supports_multipeer(void);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void d=
co_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netb=
its,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool dco_win_ad=
d_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,</spa=
n><br><span>                              unsigned int peer_id);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void dco_win_a=
dd_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbit=
s,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool dco_win_add_=
iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits,<=
/span><br><span>                              unsigned int peer_id);</span>=
<br><span> </span><br><span> void dco_win_del_iroute_ipv4(dco_context_t *dc=
o, in_addr_t dst, unsigned int netbits);</span><br><span>diff --git a/src/o=
penvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 681210d=
=2E=2E7b6f4f8 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><b=
r><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -550,9 +550,10 @@<=
/span><br><span>      * last connecting client claiming the iroutes takes o=
wnership=2E Therefore</span><br><span>      * they are not removed during d=
elayed cleanup=2E</span><br><span>      */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (c-&gt;did_dco_iroutes)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;did_dco_iroutes_v4 || c-&gt=
;did_dco_iroutes_v6)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        c-&gt;did_dco_iroutes =3D false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;did_dco_iroutes_v4=
 =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
c-&gt;did_dco_iroutes_v6 =3D false;</span><br><span>         dco_delete_iro=
utes(&amp;c-&gt;net_ctx, c);</span><br><span>     }</span><br><span> </span=
><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span=
><br><span>index b8a829c=2E=2Eedeef96 100644</span><br><span>--- a/src/open=
vpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@=
@ -478,6 +478,28 @@</span><br><span>     set_prefix(mi);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_del=
_dco_iroutes_v4(struct multi_context *m, struct multi_instance *mi)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Skip DCO IPv4 iroutes that have alread=
y been removed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (mi-&gt;context=2Edid_dco_iroutes_v4)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        mi-&gt;context=2Edid_dco_iroutes_v4 =3D false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        dco_delete_iroutes_v=
4(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+multi_del_dco_iroutes_v6(stru=
ct multi_context *m, struct multi_instance *mi)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Skip DCO IPv6 iroutes that have already been removed=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;cont=
ext=2Edid_dco_iroutes_v6)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
mi-&gt;context=2Edid_dco_iroutes_v6 =3D false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        dco_delete_iroutes_v6(&amp;m-&gt;top=2En=
et_ctx, &amp;mi-&gt;context);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</=
span><br><span>  * Tell the route helper about deleted iroutes so</span><br=
><span>  * that it can update its mask of currently used</span><br><span>@@=
 -489,12 +511,8 @@</span><br><span>     const struct iroute *ir;</span><br>=
<span>     const struct iroute_ipv6 *ir6;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /* check if DCO iroutes were alre=
ady removed when scheduling a delayed exit */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (mi-&gt;context=2Edid_dco_iroutes)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        mi-&gt;context=2Edid_dco_iroutes =3D fa=
lse;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_delet=
e_iroutes(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    multi_del_dco_iroutes_v4(m, mi);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    multi_del_dco_iroutes_v6(m, mi);=
</span><br><span> </span><br><span>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=
=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>@@ -=
1305,8 +1323,6 @@</span><br><span>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=
=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>    =
     mi-&gt;did_iroutes =3D true;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        /* multi_learn_in{6}_addr_t takes care of installing th=
e DCO iroute */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  mi-&gt;context=2Edid_dco_iroutes =3D true;</span><br><span>         for (=
ir =3D mi-&gt;context=2Eoptions=2Eiroutes; ir !=3D NULL; ir =3D ir-&gt;next=
)</span><br><span>         {</span><br><span>             if (ir-&gt;netbit=
s &gt;=3D 0)</span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/ope=
nvpn/openvpn=2Eh</span><br><span>index cdd02b6=2E=2E72436fe 100644</span><b=
r><span>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/ope=
nvpn=2Eh</span><br><span>@@ -507,7 +507,8 @@</span><br><span>     bool did_=
we_daemonize;       /**&lt; Whether demonization has already</span><br><spa=
n>                                   *   taken place=2E */</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool did_dco_iro=
utes;        /**&lt; Whether DCO iroutes have been installed */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bool did_dco_iroutes_v4;   =
  /**&lt; Whether DCO IPv4 iroutes have been installed */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    bool did_dco_iroutes_v6;     /**&=
lt; Whether DCO IPv6 iroutes have been installed */</span><br><span> </span=
><br><span>     struct context_persist persist;</span><br><span>     /**&lt=
; Persistent %context=2E */</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail">change 2061</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic0b=
8b0a3249eb41e1de10f381932c1161cd75270 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2061 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Baffo &lt;mar=
co@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--A5LBCN+M9FU=--


--===============2101967666376049126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2101967666376049126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2101967666376049126==--

