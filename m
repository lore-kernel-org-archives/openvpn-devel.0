Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009E7CDB471
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=GC7882bm+1M1so3hxu+8kxnyd3p57BvSwFMh2gjFRjw=; b=MjrWg2s3pXnI3v
	xlyO9rR8B3vgiXwzstmXqP75/8RaSVHMf1QVrvxL3iTETEueo7uE/ebdM3wTJO3C5POC0WOo/7p5I
	uNSih2lSM7bwQ8CzhlTD6ENHxjo+vDYVjd9b6E0VrPsbMzl3260ZwS3VyT8/nbIaQBHK1pOOwY1EN
	L5k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbecs-0003Ml-MO;
	Mon, 22 Jun 2026 13:23:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbecr-0003Me-Ou
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GyeBJj5MfYDMmFaZEv0ESO0vCms+7auiZC94PhoQKNk=; b=QRBk//hhEuxsIBbpGVOJ07GiCh
 0dkrQqmNpsBdg7UtZvONrbBFy/5RP+6lqXNmvU7nxe3POOP1DgKEDWDRnbceWJeJG4LVB5mAQ5jaT
 D12PmEwG2UyK0DTWQeNql7Oj4Ah1qWEcgNe1JfKUGHVQnZfhR6OYX+qvIVuOkWrFLL3k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GyeBJj5MfYDMmFaZEv0ESO0vCms+7auiZC94PhoQKNk=; b=L
 pzWcpHGik2Stbm3qKeJrKCB2Vz4jt2u6orsqNubjDNccEOIYTRgFPBd+CrwTUonBFedpodkHKexap
 JwjcusWO8cCa+39hrWP+7BTW+g0RM8dVrmPwul9Oio03tdFGF2X6D8OUoDwJEfvdplCN+LnxMoqDm
 CC8Rh9KkFR7VjEAc=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbecp-0000a4-MR for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:45 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so27014975e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134618; x=1782739418; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GyeBJj5MfYDMmFaZEv0ESO0vCms+7auiZC94PhoQKNk=;
 b=FJMS/1bjWELVr69Nrsh2aZr9MzO82Us7pOlpqV1Tvm/BOR3KkNScrKSU5Tt0EXjkis
 So3iig9QmXYnXXLz+0NpiBzTsjOiVs19S4dKsmmQB14KlO8k0RltBrOf8tFRp0gVSF1m
 Mvzp1JxDBWrwPvu5xgm+mUjPzxJQVXFOyN458vLIotqsYtUNWV5NlZNSnFqYyeuknpo7
 Y9gjd5P8ad94sIuknrUX2IEO7ortTq0b0+yNYC3SSqZrVUyEV7Alo1Ni2qm13uCAJjNN
 oB8hL3O/wtsD1xJSAiFhbS2fSA5j3ePUm7hs3a5t+eJAd+/9CZ1ndWHoHV1y8bApA1QR
 nU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134618; x=1782739418;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GyeBJj5MfYDMmFaZEv0ESO0vCms+7auiZC94PhoQKNk=;
 b=Zh6KE908Cwx7Zfnz+EXrevS6aSHra2nuf7GCfp/gfmkJZ2CXrIGDXM7oOaeTEXMDTH
 KxUQ2MSKhRm+7W5VAcnLv6ZTxT1fp7/O9cw9dVaHg9q2vYv/sVdPZsg4ohUECz5A8L8D
 nRKeJKWxL5OsVa7Vku/dzWdaw8RoIz/1Q+kFj7DMpOV8afTFCueoeNECHKLOOafXURVd
 U8I9T8ttIafMPP0XRN+go0+zc1SDlEg7dZBNvUDyYHailb3CRSaH3KJSeUtY05MNnZX/
 jGBNXLLJ4urGYW0Gv1g3aKXvGHzPsVNEQaVnXkCWSXnEZ9x1JftuD5hde9VwszEsrrO8
 VQjA==
X-Gm-Message-State: AOJu0YyIvVz+KyKBNeJXZufGuQHZnFYMQY3lcq06KJdNC9pxhn87h/8p
 2vRrsW0tK8AWtkOGwmz9cEIOOK/Q9H9EnfqDiYM5bv8V8otA5Ja0kKOuB6RvX+WdTlSgxhCSRFC
 DNnO/NG0d4pw4eJ7pYns+CXsC58WH1KXyX4uRB82FTWL3ue+G96qHjdRnFiRZTrE9lYNUqmjbYM
 Y27oAZ5A==
X-Gm-Gg: AfdE7cmWi/SUcSSjr1h9TzXhrFWsqXIxw5mGn5sFxC7g4hhzzeT5yOQuHcbJjjGaMoj
 kz0gOCaxEb01ZjAN45Z99R8fllKRl9SUR73dH+qZQYdSpSN4gkvHNf5pgDkRV7E2TfJtjOrp02o
 n3eM8vZaHJHvhPmSfAfyHOkxEwIXwCBCRJ013w4neuMEkL1AEEvVXXdDNgEr2Gi+4EtEZC6L36w
 8QenODnhUMzfh+mB5RgdWboV2TkC5vsQxuk8j9SP3jJdygS2oJdq7QnmMIRtXPGRk0Ly/KKwGir
 8+XXLLHXsARTwsxV8WldGrTIPF8WmVezFatOVpgaT5yvMcil8OeLo8+FChdmFFOC2H0jASldL58
 nmQpd5ui8YqxgOSm/X7bHAMR9liEde2pAxVpYeJvHEOf2B1HJ84YSy77RwEuoBktlb8wkXqBXYq
 iV6EaFXWcIFacolurk+V2blPYwWo8gSXssA+Ro8yp71VxAuXBqHZNAZes7z+/vWxykh0GB00fsI
 86gCAp1mZeKdyHXAJ4VBnRoGtKSJXJjnldlRDMHmr3WkdvrYRJYWDje494kSJvwzFwXCwdXXkSS
 ykE=
X-Received: by 2002:a05:600c:c4b7:b0:492:3773:a230 with SMTP id
 5b1f17b1804b1-49240e9cb38mr237161795e9.27.1782134616324; 
 Mon, 22 Jun 2026 06:23:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49245bba787sm179679795e9.1.2026.06.22.06.23.35
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:23:35 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:23:35 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I401aab94993b62bf18e66561532085f99e62f745
X-Gerrit-Change-Number: 1721
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1721?usp=email>
X-Gerrit-Commit: a46ca4783da1a6034da973249251f7ef9a81e9c3
References: <gerrit.1782134588000.I401aab94993b62bf18e66561532085f99e62f745@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk0MDFhYWI5NDk5M2I2MmJmMThlNjY1NjE1MzIwODVmOTllNjJmNzQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8399fe44024dcac1be7b923774a6407464ef7847-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbecp-0000a4-MR
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove an indention
 layer from multi_process_incoming_link
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6367103152349036699=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6367103152349036699==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oZ+gTS7tsJA="; charset=UTF-8

--oZ+gTS7tsJA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1721?usp=3Demail )


Change subject: Remove an indention=
 layer from multi_process_incoming_link
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove an indention layer from multi_process_i=
ncoming_link

This also move the gc area acquire release to the small parts=
 where they
are actually used=2E

Change-Id: I401aab94993b62bf18e6656153208=
5f99e62f745
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/open=
vpn/multi=2Ec
1 file changed, 129 insertions(+), 128 deletions(-)



  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/21/1721/1

dif=
f --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index f853669=2E=2E=
7e2f0dd 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -=
3343,8 +3343,6 @@
 multi_process_incoming_link(struct multi_context *m, str=
uct multi_instance *instance,
                             const unsigned i=
nt mpp_flags, struct link_socket *sock)
 {
-    struct gc_arena gc =3D gc_n=
ew();
-
     struct context *c;
     struct mroute_addr src, dest;
     uns=
igned int mroute_flags;
@@ -3369,167 +3367,171 @@
         multi_set_pendin=
g(m, instance);
     }
 
-    if (m->pending)
+    if (!m->pending)
     {
=
-        set_prefix(m->pending);
+        return true;
+    }
+    set_pref=
ix(m->pending);
 
-        /* get instance context */
-        c =3D &m->pe=
nding->context;
+    /* get instance context */
+    c =3D &m->pending->con=
text;
 
-        if (!instance)
+    if (!instance)
+    {
+        /* tran=
sfer packet pointer from top-level context buffer to instance */
+        c=
->c2=2Ebuf =3D m->top=2Ec2=2Ebuf;
+
+        /* transfer from-addr from top=
-level context buffer to instance */
+        if (!floated)
         {
-   =
         /* transfer packet pointer from top-level context buffer to instan=
ce */
-            c->c2=2Ebuf =3D m->top=2Ec2=2Ebuf;
+            c->c2=2E=
from =3D m->top=2Ec2=2Efrom;
+        }
+    }
 
-            /* transfer f=
rom-addr from top-level context buffer to instance */
-            if (!flo=
ated)
+    if (BLEN(&c->c2=2Ebuf) > 0)
+    {
+        struct link_socket_i=
nfo *lsi;
+        const uint8_t *orig_buf;
+
+        /* decrypt in instan=
ce context */
+
+        lsi =3D &sock->info;
+        orig_buf =3D c->c2=
=2Ebuf=2Edata;
+        if (process_incoming_link_part1(c, lsi, floated))
+=
        {
+            /* nonzero length means that we have a valid, decryp=
ted packed */
+            if (floated && c->c2=2Ebuf=2Elen > 0)
          =
   {
-                c->c2=2Efrom =3D m->top=2Ec2=2Efrom;
+               =
 multi_process_float(m, m->pending, sock);
             }
+
+            pr=
ocess_incoming_link_part2(c, lsi, orig_buf);
         }
 
-        if (BLEN=
(&c->c2=2Ebuf) > 0)
+        if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D D=
EV_TYPE_TUN)
         {
-            struct link_socket_info *lsi;
-       =
     const uint8_t *orig_buf;
+            /* extract packet source and des=
t addresses */
+            mroute_flags =3D
+                mroute_extrac=
t_addr_from_packet(&src, &dest, 0, &c->c2=2Eto_tun, DEV_TYPE_TUN);
 
-     =
       /* decrypt in instance context */
-
-            lsi =3D &sock->info=
;
-            orig_buf =3D c->c2=2Ebuf=2Edata;
-            if (process_in=
coming_link_part1(c, lsi, floated))
+            /* drop packet if extract =
failed */
+            if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
    =
         {
-                /* nonzero length means that we have a valid, d=
ecrypted packed */
-                if (floated && c->c2=2Ebuf=2Elen > 0)
-=
                {
-                    multi_process_float(m, m->pending, s=
ock);
-                }
-
-                process_incoming_link_part2(c, =
lsi, orig_buf);
+                c->c2=2Eto_tun=2Elen =3D 0;
             }=

-
-            if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
=
+            /* make sure that source address is associated with this clien=
t */
+            else if (multi_get_instance_by_virtual_addr(m, &src, true=
) !=3D m->pending)
             {
-                /* extract packet source=
 and dest addresses */
-                mroute_flags =3D
-                 =
   mroute_extract_addr_from_packet(&src, &dest, 0, &c->c2=2Eto_tun, DEV_TYP=
E_TUN);
-
-                /* drop packet if extract failed */
-           =
     if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
+                /* IP=
v6 link-local address (fe80::xxx)? */
+                if ((src=2Etype & MR=
_ADDR_MASK) =3D=3D MR_ADDR_IPV6
+                    && IN6_IS_ADDR_LINKLOC=
AL(&src=2Ev6=2Eaddr))
                 {
-                    c->c2=2Eto_tu=
n=2Elen =3D 0;
+                    /* do nothing, for now=2E  TODO: add ad=
dress learning */
                 }
-                /* make sure that sou=
rce address is associated with this client */
-                else if (mul=
ti_get_instance_by_virtual_addr(m, &src, true) !=3D m->pending)
+          =
      else
                 {
-                    /* IPv6 link-local addre=
ss (fe80::xxx)? */
-                    if ((src=2Etype & MR_ADDR_MASK) =3D=
=3D MR_ADDR_IPV6
-                        && IN6_IS_ADDR_LINKLOCAL(&src=2Ev=
6=2Eaddr))
-                    {
-                        /* do nothing, f=
or now=2E  TODO: add address learning */
-                    }
-          =
          else
-                    {
-                        msg(D_MULTI_=
DROPPED,
-                            "MULTI: bad source address from clien=
t [%s], packet dropped",
-                            mroute_addr_print(&sr=
c, &gc));
-                    }
-                    c->c2=2Eto_tun=2Elen =
=3D 0;
+                    struct gc_arena gc =3D gc_new();
+             =
       msg(D_MULTI_DROPPED,
+                        "MULTI: bad source add=
ress from client [%s], packet dropped",
+                        mroute_add=
r_print(&src, &gc));
+                    gc_free(&gc);
                 }
=
-                /* client-to-client communication enabled? */
-           =
     else if (m->enable_c2c)
+                c->c2=2Eto_tun=2Elen =3D 0;
+=
            }
+            /* client-to-client communication enabled? */
+ =
           else if (m->enable_c2c)
+            {
+                /* multi=
cast? */
+                if (mroute_flags & MROUTE_EXTRACT_MCAST)
        =
         {
-                    /* multicast? */
-                    if (m=
route_flags & MROUTE_EXTRACT_MCAST)
-                    {
-               =
         /* for now, treat multicast as broadcast */
-                     =
   multi_bcast(m, &c->c2=2Eto_tun, m->pending, 0);
-                    }
-=
                    else /* possible client to client routing */
-         =
           {
-                        ASSERT(!(mroute_flags & MROUTE_EXTRAC=
T_BCAST));
-                        mi =3D multi_get_instance_by_virtual_ad=
dr(m, &dest, true);
+                    /* for now, treat multicast as bro=
adcast */
+                    multi_bcast(m, &c->c2=2Eto_tun, m->pending, =
0);
+                }
+                else /* possible client to client r=
outing */
+                {
+                    ASSERT(!(mroute_flags & M=
ROUTE_EXTRACT_BCAST));
+                    mi =3D multi_get_instance_by_vi=
rtual_addr(m, &dest, true);
 
-                        /* if dest addr is a=
 known client, route to it */
-                        if (mi)
+           =
         /* if dest addr is a known client, route to it */
+               =
     if (mi)
+                    {
                         {
+           =
                 multi_unicast(m, &c->c2=2Eto_tun, mi);
+                  =
          register_activity(c, BLEN(&c->c2=2Eto_tun));
+                   =
     }
+                        c->c2=2Eto_tun=2Elen =3D 0;
+              =
      }
+                }
+            }
+        }
+        else if (TUNN=
EL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)
+        {
+            =
uint16_t vid =3D 0;
+
+            if (m->top=2Eoptions=2Evlan_tagging)
+  =
          {
+                if (vlan_is_tagged(&c->c2=2Eto_tun))
+        =
        {
+                    /* Drop VLAN-tagged frame=2E */
+           =
         msg(D_VLAN_DEBUG, "dropping incoming VLAN-tagged frame");
+       =
             c->c2=2Eto_tun=2Elen =3D 0;
+                }
+              =
  else
+                {
+                    vid =3D c->options=2Evlan_pv=
id;
+                }
+            }
+            /* extract packet source=
 and dest addresses */
+            mroute_flags =3D
+                mrout=
e_extract_addr_from_packet(&src, &dest, vid, &c->c2=2Eto_tun, DEV_TYPE_TAP)=
;
+
+            if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
+            =
{
+                if (multi_learn_addr(m, m->pending, &src, 0) =3D=3D m->p=
ending)
+                {
+                    /* check for broadcast */
+=
                    if (m->enable_c2c)
+                    {
+            =
            if (mroute_flags & (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST=
))
+                        {
+                            multi_bcast(m, &=
c->c2=2Eto_tun, m->pending, vid);
+                        }
+             =
           else /* try client-to-client routing */
+                       =
 {
+                            mi =3D multi_get_instance_by_virtual_addr(m=
, &dest, false);
+
+                            /* if dest addr is a known =
client, route to it */
+                            if (mi)
               =
              {
                                 multi_unicast(m, &c->c2=2E=
to_tun, mi);
                                 register_activity(c, BLEN(&c-=
>c2=2Eto_tun));
-                            }
-                           =
 c->c2=2Eto_tun=2Elen =3D 0;
-                        }
-                  =
  }
-                }
-            }
-            else if (TUNNEL_TYPE(m->=
top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)
-            {
-                uin=
t16_t vid =3D 0;
-
-                if (m->top=2Eoptions=2Evlan_tagging)
- =
               {
-                    if (vlan_is_tagged(&c->c2=2Eto_tun))
=
-                    {
-                        /* Drop VLAN-tagged frame=
=2E */
-                        msg(D_VLAN_DEBUG, "dropping incoming VLAN-t=
agged frame");
-                        c->c2=2Eto_tun=2Elen =3D 0;
-      =
              }
-                    else
-                    {
-         =
               vid =3D c->options=2Evlan_pvid;
-                    }
-    =
            }
-                /* extract packet source and dest addresses =
*/
-                mroute_flags =3D
-                    mroute_extract_ad=
dr_from_packet(&src, &dest, vid, &c->c2=2Eto_tun, DEV_TYPE_TAP);
-
-       =
         if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
-                {
- =
                   if (multi_learn_addr(m, m->pending, &src, 0) =3D=3D m->p=
ending)
-                    {
-                        /* check for broadc=
ast */
-                        if (m->enable_c2c)
-                       =
 {
-                            if (mroute_flags & (MROUTE_EXTRACT_BCAST | =
MROUTE_EXTRACT_MCAST))
-                            {
-                    =
            multi_bcast(m, &c->c2=2Eto_tun, m->pending, vid);
-            =
                }
-                            else /* try client-to-client=
 routing */
-                            {
-                               =
 mi =3D multi_get_instance_by_virtual_addr(m, &dest, false);
-
-           =
                     /* if dest addr is a known client, route to it */
-   =
                             if (mi)
-                                {
-  =
                                  multi_unicast(m, &c->c2=2Eto_tun, mi);
- =
                                   register_activity(c, BLEN(&c->c2=2Eto_tu=
n));
-                                    c->c2=2Eto_tun=2Elen =3D 0;
-    =
                            }
+                                c->c2=2Eto_t=
un=2Elen =3D 0;
                             }
                         }
 =
                    }
-                    else
-                    {
-   =
                     msg(D_MULTI_DROPPED,
-                            "MUL=
TI: bad source address from client [%s], packet dropped",
-                =
            mroute_addr_print(&src, &gc));
-                        c->c2=
=2Eto_tun=2Elen =3D 0;
-                    }
                 }
          =
       else
                 {
+                    struct gc_arena gc =3D =
gc_new();
+                    msg(D_MULTI_DROPPED,
+                      =
  "MULTI: bad source address from client [%s], packet dropped",
+          =
              mroute_addr_print(&src, &gc));
                     c->c2=2Et=
o_tun=2Elen =3D 0;
+                    gc_free(&gc);
                 }
  =
           }
+            else
+            {
+                c->c2=2Eto_t=
un=2Elen =3D 0;
+            }
         }
-
-        /* postprocess and set=
 wakeup */
-        ret =3D multi_process_post(m, m->pending, mpp_flags);
-=

-        clear_prefix();
     }
 
-    gc_free(&gc);
+    /* postprocess a=
nd set wakeup */
+    ret =3D multi_process_post(m, m->pending, mpp_flags);=

+
+    clear_prefix();
+
     return ret;
 }
 
@@ -3571,7 +3573,6 @@
     =
     * Route an incoming tun/tap packet to
          * the appropriate mult=
i_instance object=2E
          */
-
         mroute_flags =3D mroute_extrac=
t_addr_from_packet(&src, &dest, vid, &m->top=2Ec2=2Ebuf, dev_type);
 
     =
    if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1721?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I401aab94993b62bf18e66561532085f99e62f745
Ger=
rit-Change-Number: 1721
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--oZ+gTS7tsJA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1721?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Remove an indention layer from multi_process_incoming_link<br><br>=
This also move the gc area acquire release to the small parts where they<br=
>are actually used=2E<br><br>Change-Id: I401aab94993b62bf18e66561532085f99e=
62f745<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>=
M src/openvpn/multi=2Ec<br>1 file changed, 129 insertions(+), 128 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/21/1721/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b=
/src/openvpn/multi=2Ec</span><br><span>index f853669=2E=2E7e2f0dd 100644</s=
pan><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn=
/multi=2Ec</span><br><span>@@ -3343,8 +3343,6 @@</span><br><span> multi_pro=
cess_incoming_link(struct multi_context *m, struct multi_instance *instance=
,</span><br><span>                             const unsigned int mpp_flags=
, struct link_socket *sock)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     struct contex=
t *c;</span><br><span>     struct mroute_addr src, dest;</span><br><span>  =
   unsigned int mroute_flags;</span><br><span>@@ -3369,167 +3367,171 @@</sp=
an><br><span>         multi_set_pending(m, instance);</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (m-&gt;pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!m-&gt;pending)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        set_prefix(m-&gt;pending);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    set_prefix(m-&gt;pending);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* get insta=
nce context */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 c =3D &amp;m-&gt;pending-&gt;context;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* get instance context */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    c =3D &amp;m-&gt;pending-&gt;context;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (!instance)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!instance)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* transfer=
 packet pointer from top-level context buffer to instance */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Ebuf =3D m-&gt;t=
op=2Ec2=2Ebuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* transfer from=
-addr from top-level context buffer to instance */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (!floated)</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* tr=
ansfer packet pointer from top-level context buffer to instance */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c2=2Ebuf =3D=
 m-&gt;top=2Ec2=2Ebuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            c-&gt;c2=2Efrom =3D m-&gt;top=2Ec2=2Efrom;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            /* transfer from-addr from top-=
level context buffer to instance */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            if (!floated)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (BLEN(&amp;c-&gt;c2=2Ebuf) &gt; 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct link_socket_info *lsi;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const uint8_t *orig_b=
uf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* decrypt in instance cont=
ext */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        lsi =3D &amp;sock-&gt;in=
fo;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        orig_buf=
 =3D c-&gt;c2=2Ebuf=2Edata;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (process_incoming_link_part1(c, lsi, floated))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            /* nonzero length means tha=
t we have a valid, decrypted packed */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (floated &amp;&amp; c-&gt;c2=2Ebuf=2Elen =
&gt; 0)</span><br><span>             {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                c-&gt;c2=2Efrom =3D m-&gt;top=2Ec2=2Efrom;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                mul=
ti_process_float(m, m-&gt;pending, sock);</span><br><span>             }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            process_incoming_link_part2(c=
, lsi, orig_buf);</span><br><span>         }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (BLEN(&amp;c-&gt;c2=2Eb=
uf) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    struct link_socket_info *lsi;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            const uint8_t *orig_buf;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            /* extract packet source and dest =
addresses */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     mroute_flags =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                mroute_extract_addr_from_packet(&amp;src, &amp;dest, 0, &=
amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TUN);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            /* decrypt in instance contex=
t */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            lsi =3D &amp;sock-&gt;info=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            orig_buf=
 =3D c-&gt;c2=2Ebuf=2Edata;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (process_incoming_link_part1(c, lsi, floated))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            /* drop packet =
if extract failed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (!(mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED))</span><br>=
<span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               /* nonzero length means that we have a valid, decrypted pack=
ed */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
if (floated &amp;&amp; c-&gt;c2=2Ebuf=2Elen &gt; 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    multi_process_float(m, m-&g=
t;pending, sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                process_incom=
ing_link_part2(c, lsi, orig_buf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><spa=
n>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (TUNNEL_TYP=
E(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            /* make sure that source address is=
 associated with this client */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            else if (multi_get_instance_by_virtual_addr(m, &amp=
;src, true) !=3D m-&gt;pending)</span><br><span>             {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                /* extract packet =
source and dest addresses */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                mroute_flags =3D</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    mroute_extract_addr_from_packet(&amp;=
src, &amp;dest, 0, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TUN);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                /* drop packet if extract failed */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                if (!(mroute_f=
lags &amp; MROUTE_EXTRACT_SUCCEEDED))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                /* IPv6 link-local address (fe80::xxx)? *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if=
 ((src=2Etype &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &amp;&amp; IN6_IS_ADD=
R_LINKLOCAL(&amp;src=2Ev6=2Eaddr))</span><br><span>                 {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    c-&gt;c=
2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    /* do nothing, for now=2E  TODO: add address learni=
ng */</span><br><span>                 }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                /* make sure that source address is asso=
ciated with this client */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                else if (multi_get_instance_by_virtual_addr(m, &amp;sr=
c, true) !=3D m-&gt;pending)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                else</span><br><span>                 {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    /* IPv6 link=
-local address (fe80::xxx)? */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    if ((src=2Etype &amp; MR_ADDR_MASK) =3D=3D MR_=
ADDR_IPV6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
            &amp;&amp; IN6_IS_ADDR_LINKLOCAL(&amp;src=2Ev6=2Eaddr))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        /* do=
 nothing, for now=2E  TODO: add address learning */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    else</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                        msg(D_MULTI_DROP=
PED,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
           &quot;MULTI: bad source address from client [%s], packet dropped=
&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
              mroute_addr_print(&amp;src, &amp;gc));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    c-&gt;c2=2Eto_tun=2Elen=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    msg(D_MULTI_DROPPED,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        &quot;MUL=
TI: bad source address from client [%s], packet dropped&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        mroute_a=
ddr_print(&amp;src, &amp;gc));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    gc_free(&amp;gc);</span><br><span>          =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   /* client-to-client communication enabled? */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                else if (m-&gt;enable_c2c)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2=
=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         /* client-to-client communication enabled? */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            else if (m-&gt;enable_c2c)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                /* multicas=
t? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  if (mroute_flags &amp; MROUTE_EXTRACT_MCAST)</span><br><span>            =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     /* multicast? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    if (mroute_flags &amp; MROUTE_EXTRACT_MCAST)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                        /* for n=
ow, treat multicast as broadcast */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                        multi_bcast(m, &amp;c-&gt;c2=2Eto_tun=
, m-&gt;pending, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   else /* possible client to client routing */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                        ASSERT(!(=
mroute_flags &amp; MROUTE_EXTRACT_BCAST));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                        mi =3D multi_get_instance_by_v=
irtual_addr(m, &amp;dest, true);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    /* for now, treat multicast as broadcast *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, 0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                else /* possible clie=
nt to client routing */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    ASSERT(!(mroute_flags &amp; MROUTE_EXTRACT_BCAST));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    m=
i =3D multi_get_instance_by_virtual_addr(m, &amp;dest, true);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
       /* if dest addr is a known client, route to it */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                        if (mi)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    /* if de=
st addr is a known client, route to it */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    if (mi)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    {</span><br><span>       =
                  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                            multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
       register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                        c-&gt;=
c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        els=
e if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            uint16_t vid =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (m-&gt;top=2Eoptions=2Evlan_taggi=
ng)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (vl=
an_is_tagged(&amp;c-&gt;c2=2Eto_tun))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    /* Drop VLAN-tagged frame=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    msg(D_V=
LAN_DEBUG, &quot;dropping incoming VLAN-tagged frame&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    c-&gt;c2=2Eto_=
tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              vid =3D c-&gt;options=2Evlan_pvid;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            /* extract packet source and dest addresse=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mro=
ute_flags =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          mroute_extract_addr_from_packet(&amp;src, &amp;dest, vid, &amp;c-=
&gt;c2=2Eto_tun, DEV_TYPE_TAP);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                if (multi_learn_addr(m, m-&gt;p=
ending, &amp;src, 0) =3D=3D m-&gt;pending)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    /* check for broadcast */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    if (m-&g=
t;enable_c2c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    if (mroute_flags &amp; (MROUTE_EXTRACT_BCAST | MROUTE_E=
XTRACT_MCAST))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                            multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;p=
ending, vid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        else /* try client-to-client routing */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
   mi =3D multi_get_instance_by_virtual_addr(m, &amp;dest, false);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                            /* if dest addr is =
a known client, route to it */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                            if (mi)</span><br><span>            =
                 {</span><br><span>                                 multi_u=
nicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><span>                    =
             register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                            }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
    c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            else if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_T=
YPE_TAP)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                uint1=
6_t vid =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                if (m-&gt;to=
p=2Eoptions=2Evlan_tagging)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    if (vlan_is_tagged(&amp;c-&gt;c2=2Eto_tun))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        /* Drop=
 VLAN-tagged frame=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        msg(D_VLAN_DEBUG, &quot;dropping incoming VLAN-t=
agged frame&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                      c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    else</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                        vid =3D c-&gt;op=
tions=2Evlan_pvid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         /* extract packet source and dest addresses */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                mroute_flags =3D</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    mroute_ext=
ract_addr_from_packet(&amp;src, &amp;dest, vid, &amp;c-&gt;c2=2Eto_tun, DEV=
_TYPE_TAP);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                if (mroute_flag=
s &amp; MROUTE_EXTRACT_SUCCEEDED)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    if (multi_learn_addr(m, m-&gt;pending, &amp;src=
, 0) =3D=3D m-&gt;pending)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                        /* check for broadcast */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                        if (m-&gt;enable_c=
2c)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
              if (mroute_flags &amp; (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT=
_MCAST))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                           multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pen=
ding, vid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                          else /* try client-to-client routing */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
         mi =3D multi_get_instance_by_virtual_addr(m, &amp;dest, false);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                /* if dest =
addr is a known client, route to it */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                if (mi)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
        multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                    registe=
r_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                    c-&gt;c2=2Eto_tu=
n=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                         }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                c-&gt;c2=2Eto_tun=2Elen =3D 0;</span=
><br><span>                             }</span><br><span>                 =
        }</span><br><span>                     }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        msg(D_MULTI_DROPPED=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
        &quot;MULTI: bad source address from client [%s], packet dropped&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
           mroute_addr_print(&amp;src, &amp;gc));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        c-&gt;c2=2Eto_tun=2Elen=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      }</span><br><span>                 }</span><br><span>                =
 else</span><br><span>                 {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    m=
sg(D_MULTI_DROPPED,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        &quot;MULTI: bad source address from client [%s], p=
acket dropped&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        mroute_addr_print(&amp;src, &amp;gc));</span><br><=
span>                     c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    gc_free(&amp;gc);<=
/span><br><span>                 }</span><br><span>             }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2=2Eto_tun=2Ele=
n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* po=
stprocess and set wakeup */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        ret =3D multi_process_post(m, m-&gt;pending, mpp_flags);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        clear_prefix();</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* postprocess and set wakeup */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ret =3D multi_process_post(m, m-&gt;pending, mpp_flags);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    clear_prefix();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return ret;</spa=
n><br><span> }</span><br><span> </span><br><span>@@ -3571,7 +3573,6 @@</spa=
n><br><span>          * Route an incoming tun/tap packet to</span><br><span=
>          * the appropriate multi_instance object=2E</span><br><span>     =
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an>         mroute_flags =3D mroute_extract_addr_from_packet(&amp;src, &amp=
;dest, vid, &amp;m-&gt;top=2Ec2=2Ebuf, dev_type);</span><br><span> </span><=
br><span>         if (mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED)</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1721?usp=3Demail">change 1721</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1721?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I401aab94993b62bf18e665615=
32085f99e62f745 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
721 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--oZ+gTS7tsJA=--


--===============6367103152349036699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6367103152349036699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6367103152349036699==--

