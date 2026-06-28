Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CCFC43458
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 20:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RyiLlmyAQ8kolYO1XuYMysP5XrpsdY/AcUstaOEQ/ts=; b=SmUPnOH0tcGUyR7bO3ahVqyRlA
	mLqmP5wszx91SbLkBbY3BE06zZU9HMJQ/aOr8n4h3DfOkfr5mdeGRbjiz+Ej2lybh7eIxOVodFX9x
	kkb7NvQQhInblEUPgmZ/Iku1me6Je7bGX9dUN28pQCtLSPDzU/S6cyxofIWsH5B/NvdY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdwar-0005kT-He;
	Sun, 28 Jun 2026 20:59:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdwaq-0005kM-BI
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 20:59:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=W/nCkeiVdLO5SSqkwE02xo8jGWXz9Boc3PEzTKg0nqY=; b=SNiRDWynQw1OaI1WrsuZkpzwOf
 MZjFkBuwxGoi5lGmSexteZaioaPKI0HH2K1/TGhHUogh51XxDmAU6uWEj9F8LVMeQdPqzqy4erlxS
 rT0IOrUtikz1OpORVmA5Qud4lXI7YKcJTtSMjumoq/NySwFZZZb+ZHDzdqsU2Pv5tKAI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=W/nCkeiVdLO5SSqkwE02xo8jGWXz9Boc3PEzTKg0nqY=; b=c
 4KdKWIPznTCL+dSKKrXclC3kx84S3r2pCGw8O7TYqxgC8N7u2Lt+IOx2WprvZEORuhranxuoE+PHy
 7/ooFc+6xY8yoG3iqwjqMVUZJfGiCM3LUoEUjTBgnc9lV/EEgw1pW+y3B3nxmMiF2D2wiM5h/EO5c
 FNwyP6xc9EbpM2PQ=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdwan-0004db-FX for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 20:59:08 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493b1710405so171265e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 28 Jun 2026 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782680339; x=1783285139; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W/nCkeiVdLO5SSqkwE02xo8jGWXz9Boc3PEzTKg0nqY=;
 b=NXV7ob60NdlrrsNewVg9f71rFw93dXWOmG1pAdtZezq/NODJ3Tl0G4vRO5wLZh5jUQ
 11X3DHDWMUhIG/330F4kNUtD2xxJgWWyM2zumiSSmuBM1VMbDVTDWRHezG8Jk55KHLXs
 J3DdNjCsEr4rm5tdX3pT6K/Rf6BxCtsspslhiVLZFIu4TxiUBqZ92ymr3KMB9l0izam2
 AQ/OUZk8aqO8AtgwNyrUVZwky+Ei1Brt+70HSyhckI/JS48+LJGhLWzv+9cCdgIw3Wyo
 oZj70HWNzNEvemthFnjftgFSL08E1UlYS8LgWF9WD3932IMTv+kdS+9PWYd3T4tCckKn
 5JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782680339; x=1783285139;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W/nCkeiVdLO5SSqkwE02xo8jGWXz9Boc3PEzTKg0nqY=;
 b=DP24tuk7BHvLA5hZg+ZckR4lNMR6t5UzRTdYy9rqD60jiHuuBjFw6P9Dc10cKUi/s6
 uPzT7+PHM5+P2piPJmaVoT6jaDrus1PYWDO5OWR+gW0+2utpqRUrPEVGZa+pu7JoOLKU
 zdDiLusZZsmcwIwBY2beY5e5CXWrzXc623s2YJrqCCZEHLdFvsmMJ68Swi4bvmQVXE6U
 UYFB46WpGTHfYQCJz/3jzLG/piZfqKGLm+JhAJJtLDCSq29NMy2fcx3nlWqOdlv5Zix6
 PU6D+H8tLsaSGNozc46+bcducS1tJKFBddkhWUEdgrjoYWyIAVyXPnjvuV6e5mcX2uez
 ct4A==
X-Gm-Message-State: AOJu0YyJUxwqgTihem/gz2qurmjVnRzKtZMgPwihrM6sMRqUFuzrQcdJ
 8a8/7SPdvuFt8YVu+MpCsFBCgF4M9vhQ4YSIYkR0ghrAzS6Wf8+WLIIOPRX+K4wsAKYGv4bT+ZI
 BBladIAz3o+5FWbB1fYf2Ryb8qMX4wN6irM6/ydDxB3LTnXVlU2OYTUey2D9O96BhmPh6QBRQTG
 iTEpSL7Q==
X-Gm-Gg: AfdE7cndF8avPaw/LeS5LwWQ8UQWqOGIfir+hsJYDg0KiAoyLWi60js4i/Hu2lrO5aJ
 ieV7dsaXsJZKt3HLOiGRAsgXSMRcEclLlRJ3h4izZN579TIkOGiEaqLeEymtZ/zzcgbTKWpVVVM
 lY4rJrlU4ndM8uiXmyPwj10KyQh8XZ6nztv8WuxUR8CGxlUoD7CPmVvNdYt2voIbVOfMkSKimu8
 KlG1e9DOSWZu1IuVArnFCV9JJ2wshXDfaXitxD03ziF5GLzlEup4ZWlK4ylIdkGpjPWhUaod5eQ
 p/x2j9wNMvIO1ZfOPTk9IUT6zmiIOTOtpWxc0s1HoU1KLg454a8UwU+F9XABlqm6bElAEV8xir9
 a2jzu6mJKLR5daWxc0rC8msRvtzMbF4kh79thKMCJ5RkO4FjO9ZvUmkqyMGYqN9I4sDOMeTypJZ
 9YBhYdcOGAeQHaCqQUWJNkJjhZuNwCZQC0bllPwGauzT+q5W95QSD1MJmWjQdrPScFcilj6/ohV
 i/+DfnjNiYESDyRju9KqIrEYsvgh5N++lvfRvXMu2/g2U5OnQJmcea9Czxdh3jmG0Nk0NmYzzqr
 bVyTaZ2xbVKPyw==
X-Received: by 2002:a05:600c:3b8a:b0:490:44eb:c1e0 with SMTP id
 5b1f17b1804b1-4926fc761ddmr178383025e9.21.1782680339127; 
 Sun, 28 Jun 2026 13:58:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f9db29b15sm17158059f8f.18.2026.06.28.13.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 13:58:58 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 28 Jun 2026 20:58:56 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I401aab94993b62bf18e66561532085f99e62f745
X-Gerrit-Change-Number: 1721
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1721?usp=email>
X-Gerrit-Commit: ce9c3a265b44ec0546f7ae51beac88e839618d59
In-Reply-To: <gerrit.1782134588000.I401aab94993b62bf18e66561532085f99e62f745@gerrit.openvpn.net>
References: <gerrit.1782134588000.I401aab94993b62bf18e66561532085f99e62f745@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk0MDFhYWI5NDk5M2I2MmJmMThlNjY1NjE1MzIwODVmOTllNjJmNzQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2ed512061af475e3f564331fd11150e318bc783b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdwan-0004db-FX
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8149880042519091261=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8149880042519091261==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WM1F/oWpyjo="; charset=UTF-8

--WM1F/oWpyjo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1721?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: Remove an indention layer from multi_process=
_incoming_link
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Remove an indention layer from multi_process_incoming_link

This also mov=
e the gc area acquire release to the small parts where they
are actually us=
ed=2E

Change-Id: I401aab94993b62bf18e66561532085f99e62f745
Signed-off-by: =
Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1721
Me=
ssage-Id: <20260628150235=2E13113-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37341=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvp=
n/multi=2Ec
1 file changed, 129 insertions(+), 128 deletions(-)


  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/21/1721/4

diff -=
-git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index a957fdf=2E=2E8b3=
6cf7 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -330=
6,8 +3306,6 @@
 multi_process_incoming_link(struct multi_context *m, struct=
 multi_instance *instance,
                             const unsigned int =
mpp_flags, struct link_socket *sock)
 {
-    struct gc_arena gc =3D gc_new(=
);
-
     struct context *c;
     struct mroute_addr src, dest;
     unsign=
ed int mroute_flags;
@@ -3332,167 +3330,171 @@
         multi_set_pending(m=
, instance);
     }
 
-    if (m->pending)
+    if (!m->pending)
     {
-  =
      set_prefix(m->pending);
+        return true;
+    }
+    set_prefix(=
m->pending);
 
-        /* get instance context */
-        c =3D &m->pendi=
ng->context;
+    /* get instance context */
+    c =3D &m->pending->contex=
t;
 
-        if (!instance)
+    if (!instance)
+    {
+        /* transfe=
r packet pointer from top-level context buffer to instance */
+        c->c=
2=2Ebuf =3D m->top=2Ec2=2Ebuf;
+
+        /* transfer from-addr from top-le=
vel context buffer to instance */
+        if (!floated)
         {
-      =
      /* transfer packet pointer from top-level context buffer to instance =
*/
-            c->c2=2Ebuf =3D m->top=2Ec2=2Ebuf;
+            c->c2=2Efro=
m =3D m->top=2Ec2=2Efrom;
+        }
+    }
 
-            /* transfer from=
-addr from top-level context buffer to instance */
-            if (!floate=
d)
+    if (BLEN(&c->c2=2Ebuf) > 0)
+    {
+        struct link_socket_info=
 *lsi;
+        const uint8_t *orig_buf;
+
+        /* decrypt in instance =
context */
+
+        lsi =3D &sock->info;
+        orig_buf =3D c->c2=2Ebu=
f=2Edata;
+        if (process_incoming_link_part1(c, lsi, floated))
+     =
   {
+            /* nonzero length means that we have a valid, decrypted p=
acked */
+            if (floated && c->c2=2Ebuf=2Elen > 0)
             {
=
-                c->c2=2Efrom =3D m->top=2Ec2=2Efrom;
+                mult=
i_process_float(m, m->pending, sock);
             }
+
+            process=
_incoming_link_part2(c, lsi, orig_buf);
         }
 
-        if (BLEN(&c->=
c2=2Ebuf) > 0)
+        if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D DEV_TY=
PE_TUN)
         {
-            struct link_socket_info *lsi;
-            =
const uint8_t *orig_buf;
+            /* extract packet source and dest add=
resses */
+            mroute_flags =3D
+                mroute_extract_add=
r_from_packet(&src, &dest, 0, &c->c2=2Eto_tun, DEV_TYPE_TUN);
 
-          =
  /* decrypt in instance context */
-
-            lsi =3D &sock->info;
-  =
          orig_buf =3D c->c2=2Ebuf=2Edata;
-            if (process_incomin=
g_link_part1(c, lsi, floated))
+            /* drop packet if extract faile=
d */
+            if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
         =
    {
-                /* nonzero length means that we have a valid, decryp=
ted packed */
-                if (floated && c->c2=2Ebuf=2Elen > 0)
-     =
           {
-                    multi_process_float(m, m->pending, sock);=

-                }
-
-                process_incoming_link_part2(c, lsi, =
orig_buf);
+                c->c2=2Eto_tun=2Elen =3D 0;
             }
-
- =
           if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
+    =
        /* make sure that source address is associated with this client */
=
+            else if (multi_get_instance_by_virtual_addr(m, &src, true) !=
=3D m->pending)
             {
-                /* extract packet source an=
d dest addresses */
-                mroute_flags =3D
-                    =
mroute_extract_addr_from_packet(&src, &dest, 0, &c->c2=2Eto_tun, DEV_TYPE_T=
UN);
-
-                /* drop packet if extract failed */
-              =
  if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
+                /* IPv6 =
link-local address (fe80::xxx)? */
+                if ((src=2Etype & MR_AD=
DR_MASK) =3D=3D MR_ADDR_IPV6
+                    && IN6_IS_ADDR_LINKLOCAL(=
&src=2Ev6=2Eaddr))
                 {
-                    c->c2=2Eto_tun=
=2Elen =3D 0;
+                    /* do nothing, for now=2E  TODO: add add=
ress learning */
                 }
-                /* make sure that sour=
ce address is associated with this client */
-                else if (mult=
i_get_instance_by_virtual_addr(m, &src, true) !=3D m->pending)
+           =
     else
                 {
-                    /* IPv6 link-local addres=
s (fe80::xxx)? */
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
 
@@ -3534,7 +3536,6 @@
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I401aab94993b62bf18e66561532085f99e62f745
G=
errit-Change-Number: 1721
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--WM1F/oWpyjo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1721?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Remove an indention =
layer from multi_process_incoming_link<br><br>This also move the gc area ac=
quire release to the small parts where they<br>are actually used=2E<br><br>=
Change-Id: I401aab94993b62bf18e66561532085f99e62f745<br>Signed-off-by: Arne=
 Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1721<br>Message-Id: &lt;20260628150235=2E13113-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg37341=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file changed, 12=
9 insertions(+), 128 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/21/1721/4</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index=
 a957fdf=2E=2E8b36cf7 100644</span><br><span>--- a/src/openvpn/multi=2Ec</s=
pan><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -3306,8 +3306,=
6 @@</span><br><span> multi_process_incoming_link(struct multi_context *m, =
struct multi_instance *instance,</span><br><span>                          =
   const unsigned int mpp_flags, struct link_socket *sock)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     struct context *c;</span><br><span>     struct mroute_add=
r src, dest;</span><br><span>     unsigned int mroute_flags;</span><br><spa=
n>@@ -3332,167 +3330,171 @@</span><br><span>         multi_set_pending(m, i=
nstance);</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (m-&gt;pending)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!m-&gt;pending)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        set_pref=
ix(m-&gt;pending);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_prefix=
(m-&gt;pending);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        /* get instance context */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        c =3D &amp;m-&gt;pending-&gt;context;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* get instance con=
text */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c =3D &a=
mp;m-&gt;pending-&gt;context;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (!instance)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!instance)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* transfer packet pointer from top-level context buf=
fer to instance */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       c-&gt;c2=2Ebuf =3D m-&gt;top=2Ec2=2Ebuf;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* transfer from-addr from top-level context buffer to ins=
tance */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!floated)</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            /* transfer packet pointer from top-level conte=
xt buffer to instance */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            c-&gt;c2=2Ebuf =3D m-&gt;top=2Ec2=2Ebuf;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Efrom =3D m-&gt;t=
op=2Ec2=2Efrom;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
/* transfer from-addr from top-level context buffer to instance */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            if (!floated)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLEN(&amp;c-&gt;=
c2=2Ebuf) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct l=
ink_socket_info *lsi;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        const uint8_t *orig_buf;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* decrypt in instance context */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       lsi =3D &amp;sock-&gt;info;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        orig_buf =3D c-&gt;c2=2Ebuf=2Edata;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (process_incoming_link_pa=
rt1(c, lsi, floated))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    /* nonzero length means that we have a valid, decrypted packed */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (floated &=
amp;&amp; c-&gt;c2=2Ebuf=2Elen &gt; 0)</span><br><span>             {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                c-&gt;c2=2E=
from =3D m-&gt;top=2Ec2=2Efrom;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                multi_process_float(m, m-&gt;pending, sock);</s=
pan><br><span>             }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  process_incoming_link_part2(c, lsi, orig_buf);</span><br><span>         }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (BLEN(&amp;c-&gt;c2=2Ebuf) &gt; 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=
=3D DEV_TYPE_TUN)</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            struct link_socket_info *lsi;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            const uint8_t *orig_=
buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* =
extract packet source and dest addresses */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            mroute_flags =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                mroute_extract_addr_from_=
packet(&amp;src, &amp;dest, 0, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TUN);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   /* decrypt in instance context */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      lsi =3D &amp;sock-&gt;info;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            orig_buf =3D c-&gt;c2=2Ebuf=2Edata;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            if (process_incoming_link=
_part1(c, lsi, floated))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            /* drop packet if extract failed */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!(mroute_flags &amp; MROU=
TE_EXTRACT_SUCCEEDED))</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                /* nonzero length means tha=
t we have a valid, decrypted packed */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                if (floated &amp;&amp; c-&gt;c2=2Ebuf=2Ele=
n &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    multi_process_float(m, m-&gt;pending, sock);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                process_incoming_link_part2(c, lsi, orig_buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2=2Eto_=
tun=2Elen =3D 0;</span><br><span>             }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_T=
UN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* m=
ake sure that source address is associated with this client */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            else if (multi_get_i=
nstance_by_virtual_addr(m, &amp;src, true) !=3D m-&gt;pending)</span><br><s=
pan>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             /* extract packet source and dest addresses */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                mroute_flags =3D</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    mroute=
_extract_addr_from_packet(&amp;src, &amp;dest, 0, &amp;c-&gt;c2=2Eto_tun, D=
EV_TYPE_TUN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                /* drop packe=
t if extract failed */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                if (!(mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                /* IPv6 li=
nk-local address (fe80::xxx)? */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                if ((src=2Etype &amp; MR_ADDR_MASK) =3D=3D MR_=
ADDR_IPV6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          &amp;&amp; IN6_IS_ADDR_LINKLOCAL(&amp;src=2Ev6=2Eaddr))</span><br=
><span>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    /* do nothing, for n=
ow=2E  TODO: add address learning */</span><br><span>                 }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* make s=
ure that source address is associated with this client */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                else if (multi_get_inst=
ance_by_virtual_addr(m, &amp;src, true) !=3D m-&gt;pending)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                else</span><br><spa=
n>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   /* IPv6 link-local address (fe80::xxx)? */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    if ((src=2Etype=
 &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                        &amp;&amp; IN6_IS_ADDR_LINKLOCAL=
(&amp;src=2Ev6=2Eaddr))</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        /* do nothing, for now=2E  TODO: add address lear=
ning */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
             msg(D_MULTI_DROPPED,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                            &quot;MULTI: bad source address fro=
m client [%s], packet dropped&quot;,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                            mroute_addr_print(&amp;src, &amp=
;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    struct gc_arena gc =3D gc_new();</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    msg(D_=
MULTI_DROPPED,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   &quot;MULTI: bad source address from client [%s], packet=
 dropped&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    mroute_addr_print(&amp;src, &amp;gc));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    gc_free(&amp;gc)=
;</span><br><span>                 }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                /* client-to-client communication enabled? *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                else=
 if (m-&gt;enable_c2c)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* client-to-client communication enabl=
ed? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
lse if (m-&gt;enable_c2c)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                /* multicast? */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                if (mroute_flags &amp; MROUTE_EXTRACT_MCAST)</=
span><br><span>                 {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    /* multicast? */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    if (mroute_flags &amp; MROUT=
E_EXTRACT_MCAST)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   /* for now, treat multicast as broadcast */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        multi_bcas=
t(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, 0);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    else /* possible client to cl=
ient routing */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  ASSERT(!(mroute_flags &amp; MROUTE_EXTRACT_BCAST));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                        mi =
=3D multi_get_instance_by_virtual_addr(m, &amp;dest, true);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    /* for now, tre=
at multicast as broadcast */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;p=
ending, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      else /* possible client to client routing */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    ASSERT(!(mroute_flags &amp=
; MROUTE_EXTRACT_BCAST));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    mi =3D multi_get_instance_by_virtual_addr(m, &amp=
;dest, true);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                        /* if dest addr is a known client, route =
to it */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           if (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   /* if dest addr is a known client, route to it */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    if (mi=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  {</span><br><span>                         {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                            multi_unicast(m, &am=
p;c-&gt;c2=2Eto_tun, mi);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                            register_activity(c, BLEN(&amp;c-&gt;c2=
=2Eto_tun));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        else if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=
=3D DEV_TYPE_TAP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
uint16_t vid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (m-&=
gt;top=2Eoptions=2Evlan_tagging)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                if (vlan_is_tagged(&amp;c-&gt;c2=2Eto_tun))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    /* Drop VL=
AN-tagged frame=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    msg(D_VLAN_DEBUG, &quot;dropping incoming VLAN-tagged=
 frame&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    vid =3D c-&gt;options=2Evlan_pvi=
d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* extract pa=
cket source and dest addresses */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            mroute_flags =3D</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                mroute_extract_addr_from_packet(&amp=
;src, &amp;dest, vid, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TAP);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if (mroute_flags &amp; MROUTE_EXTRACT_SUC=
CEEDED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if=
 (multi_learn_addr(m, m-&gt;pending, &amp;src, 0) =3D=3D m-&gt;pending)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    /* ch=
eck for broadcast */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    if (m-&gt;enable_c2c)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        if (mroute_flags &amp; (MR=
OUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                            multi_bcast(m, &a=
mp;c-&gt;c2=2Eto_tun, m-&gt;pending, vid);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        else /* try client-to-=
client routing */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                            mi =3D multi_get_instance_by_virtual_addr(m=
, &amp;dest, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
          /* if dest addr is a known client, route to it */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                            if (mi)=
</span><br><span>                             {</span><br><span>           =
                      multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><=
br><span>                                 register_activity(c, BLEN(&amp;c-=
&gt;c2=2Eto_tun));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                         }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                            c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            else if (TUNNEL_TYPE(m-&gt;to=
p=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                uint16_t vid =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                if (m-&gt;top=2Eoptions=2Evlan_tagging)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    if (vlan_is_tagged(&amp=
;c-&gt;c2=2Eto_tun))</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       /* Drop VLAN-tagged frame=2E */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                        msg(D_VLAN_DEBUG, =
&quot;dropping incoming VLAN-tagged frame&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        c-&gt;c2=2Eto_tun=2Elen=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
             vid =3D c-&gt;options=2Evlan_pvid;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                /* extract packet source and dest add=
resses */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    mroute_flags =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   mroute_extract_addr_from_packet(&amp;src, &amp;dest, vid=
, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TAP);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              if (mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    if (multi_learn_ad=
dr(m, m-&gt;pending, &amp;src, 0) =3D=3D m-&gt;pending)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                        /* check for broa=
dcast */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           if (m-&gt;enable_c2c)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                            if (mroute_flags &amp; (MROUTE_E=
XTRACT_BCAST | MROUTE_EXTRACT_MCAST))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                multi_bcast(m, &amp=
;c-&gt;c2=2Eto_tun, m-&gt;pending, vid);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                            }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                            else /* try client-t=
o-client routing */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                          {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                mi =3D multi_get_instance_by_virtual_=
addr(m, &amp;dest, false);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                /* if dest addr is a known client, route to it */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
 if (mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                   multi_unicast(m, &amp;c-&gt;c2=2Eto_tun,=
 mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                    register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
           c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                c-&gt;c2=
=2Eto_tun=2Elen =3D 0;</span><br><span>                             }</span=
><br><span>                         }</span><br><span>                     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
       msg(D_MULTI_DROPPED,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                            &quot;MULTI: bad source address from clie=
nt [%s], packet dropped&quot;,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                            mroute_addr_print(&amp;src, &amp;gc));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
   c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    }</span><br><span>                 }</span>=
<br><span>                 else</span><br><span>                 {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    msg(D_MULTI_DROPPED,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                        &quot;MULTI: bad source a=
ddress from client [%s], packet dropped&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        mroute_addr_print(&amp;s=
rc, &amp;gc));</span><br><span>                     c-&gt;c2=2Eto_tun=2Elen=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        gc_free(&amp;gc);</span><br><span>                 }</span><br><spa=
n>             }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span>         }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        /* postprocess and set wakeup */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ret =3D multi_process_post(m, m-&gt=
;pending, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        clear_prefix(=
);</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* postprocess and set wakeup */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ret =3D multi_process_post(m, =
m-&gt;pending, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    clear_pr=
efix();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     return ret;</span><br><span> }</span><br><span> </span><br><span>=
@@ -3534,7 +3536,6 @@</span><br><span>          * Route an incoming tun/tap=
 packet to</span><br><span>          * the appropriate multi_instance objec=
t=2E</span><br><span>          */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>         mroute_flags =3D mroute_extract_addr_=
from_packet(&amp;src, &amp;dest, vid, &amp;m-&gt;top=2Ec2=2Ebuf, dev_type);=
</span><br><span> </span><br><span>         if (mroute_flags &amp; MROUTE_E=
XTRACT_SUCCEEDED)</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1721?usp=3Demail">change 172=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1721?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I401aab94993b62bf18e66561532085f99e62f745 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1721 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>

</body></html>
--WM1F/oWpyjo=--


--===============8149880042519091261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8149880042519091261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8149880042519091261==--

