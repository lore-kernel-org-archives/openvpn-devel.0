Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836A2CDE007
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vSNoUa6jZcTSZ8vGoFqbBxFqBoEjquDdKZw4xp3SuaU=; b=G5FEMmSuysSyLPb8LwLSZ9XdlK
	G/XdRkTazq1rY5V4zC5/rfwz8HKf6DqmD+8AnoSIWm0VzSN/qsPRTOLilaVQXciWQCmechJ0MyIYG
	YY6XnOgTR26S+vuOoWsAIfTSkxc4VAgxeTOQNh8GpK+ohycSq6Df705CzEWdKjtFuiHI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wckGr-0007ZV-LS;
	Thu, 25 Jun 2026 13:37:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wckGo-0007ZM-5B
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qDlmKz0ZZKly2vQY4SWiN9JsWY98w9thwJjyzrXhR6g=; b=Um5MoUwo/qB2bdraF/mITG7WFi
 jCOQ23BBLtWUZm4xrMoooZe7WoCgf/HzDHX/fk8BfoWQQ9t/l6aSLWpRwB+UglGwDh//okccMryKt
 vxBcxnhw98fgTrf08r7DwTKrZlzKtsjlG8lxWoifRDQBvqqWJUIwZJI0jpsRxs9CA95M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qDlmKz0ZZKly2vQY4SWiN9JsWY98w9thwJjyzrXhR6g=; b=b
 qH5MYWgk0dii3Rx4EgmBwzG/IH8/PwMMVD4IjiwxhSmLZIJXjfLuOl/BqORILViTY8IHZVypwaQhe
 cvA2JWdAJShzho3fHASGh6/KEpWlBW/RJp4W3zV4R4+KUS2a/m77ivvh+hDrKmjELioXk1QBFHg4B
 u8xayhsI/Z+fwvYg=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wckGi-0001Hl-7A for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:27 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490b9318997so13075715e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782394638; x=1782999438; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qDlmKz0ZZKly2vQY4SWiN9JsWY98w9thwJjyzrXhR6g=;
 b=D6SiUMeqirHVm5gm5ef6sJ3LYdbTkZ1yZWaIa7ppvlvx4qYJlcesvVqgij+K9Dk/XT
 Y67k0Gq84akmiIJUPhvY96bL/izxLC5PPO1CsHQDTw7sJyWyVuhwuj/80TmRJ7qBk2Yd
 C5F6+BV3ryGTPNTOM7ynXHjS7FzUsCNk66EMHXNFy6BWoSU2Sb/75xytOejPzPdxtypm
 TcjxMpxodFaaY2NQ43n3lYBHYZz5sv2LSNx0PHgGlbum17i0bOSjlpJC6YGFpzZhmWPL
 7cT1U9PHIEp4FSewmF2mUJ+k4B2u8b4lKRf1hE4WYmiHO8XARKxwspXsK50H3krenNZN
 vsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394638; x=1782999438;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qDlmKz0ZZKly2vQY4SWiN9JsWY98w9thwJjyzrXhR6g=;
 b=TshZnGRyfaLee+GOAwTTsc3OKByFvgbv52ZhI6aYVhZL4y+8eZqgmvkcbc+K6XzaF3
 eIuHrTtoAsop1TOaez9WH5f55QSjUW1pdMi+cUTZiRX2FtWOY452AzdP8RCSWUVf5UhX
 vihNQwWKP8uT7LZKY5PefmTVPfdgUbzrVn1XbNByMWHpUI/R3vcptwZVKBkw2Kb+hHdI
 /yXadoviRQtFZ0S35uoHe+nXpRfUzgB/r8iHgqk7ZRw7AUU2QTvjzV/PptN0tFOzz+3v
 OOKuG1nTIcH6UeC295qj/WmbdKdMx7DTCE6/ZKycu080yUiP4PQ9nv0dZVsNBd3Qto7e
 idUA==
X-Gm-Message-State: AOJu0YzzC7rUttJ0hy+ZRVhWwaJifQ5bf/QRg22gQGcTNJ4Sc4z/Gk/K
 CB1mVnlhuOCGTRH+QOHXvohuLm4laJac0IlEeyXl5vJG7gaWQp3liKs2mc02z9PkMWs9O+OQKy9
 7r19IZzUxxuvj6BaC9pTu3/G7UJf65w76wyM6/FK5WoUEcaZp3Lx4K4XTvwDiAISY0j+MHFVRBO
 2LW0whFg==
X-Gm-Gg: AfdE7cmv1YpEKFUz66gv5dDMsEopucxahLKIrZ41IyRsNwawowYcqIxDQHMiLu9aKhp
 he8nSphUWLD1muz3gjENyN69breJfMdhK9hMuEoO+adE6Dn9+DakiibGApFvd3PDeqyEd/ODtaf
 1/jtQ3vVq43c9bHwYw2pI4hFBuTKiAlMgzKPo9y81d777tqAamGUedv6Ss9n8D/4hTGuGn66OZ6
 1HNEfq/mFGnfhj2vuhF8yo823hbzvN/+Szu2100URenY/XlyCUT2VpUsu3rzsPB2rs82Kio0W59
 mbveg17ung0EUQ28Pva33et+K0KL+zMeyGbqBs/gcwkI0c6csubumymyxqbVlJXL3zQPGkubUn+
 LwTeo6zoNavQeO2SsBpfcmrUb6QOY0i66Zrp5toD60r6TQ7rQiQBglAiz+AYErK8QlkxlWtmm1m
 3ZF6igy5rYfFoMqgGjJ55D1QVi3/DcuNkDI02iDro47oHDVsdRZ6cQnhcelC+Rv9jF95lsNc6K6
 fG5b1bxAOxDU1/2/6p2kcxslG0nnvtDyLx3NDb17oEWTUxZFOQYRKwvn3qiVYDAxtpKCuw7lcLm
 Rl0=
X-Received: by 2002:a05:600c:c059:10b0:492:5ec1:4e14 with SMTP id
 5b1f17b1804b1-49266885964mr28181825e9.24.1782394637904; 
 Thu, 25 Jun 2026 06:37:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46de7effe5bsm4195557f8f.5.2026.06.25.06.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:37:17 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:37:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
X-Gerrit-Change-Number: 1722
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1722?usp=email>
X-Gerrit-Commit: 3f2f6171c104d6725e08d3889206a373f041a627
In-Reply-To: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
References: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk5ZjEwZDkxNDA3MzQ3ZmFmMzIzOTc1MzVjOTVlMmQ4MGExNTc1YmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4bcc16cd21c21c12673c8a70af04b2fc89f7388e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wckGi-0001Hl-7A
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move incoming data
 processing in its own method
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4892367972622372130=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4892367972622372130==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HFBCaYAzrD0="; charset=UTF-8

--HFBCaYAzrD0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1722?usp=3Demail

to look at the new patch set (#3=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Move incoming data processing in its own =
method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move=
 incoming data processing in its own method

This extract a large chunk fro=
m multi_process_incoming_link into its
own method multi_process_incoming_li=
nk_data

This reduces the complexity of multi_process_incoming_link further=
=2E

A few declarations were moved into a more logical place but otherwise
=
this is just a simple move=2E

Change-Id: I9f10d91407347faf32397535c95e2d80=
a1575bd5
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn=
/multi=2Ec
1 file changed, 154 insertions(+), 138 deletions(-)


  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/22/1722/3

diff --=
git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index f19433b=2E=2E625f=
87d 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3303=
,6 +3303,159 @@
 }
 #endif /* if defined(ENABLE_DCO) */
 
+/**
+ * Process =
incoming data packet from clients=2E
+ *
+ * This tries to decrypt and then=
 forward incoming
+ * data packets, so the be be forwarded=2E
+ *
+ * @para=
m m P
+ * @param floated
+ * @param sock
+ */
+static void
+multi_process_i=
ncoming_link_data(struct multi_context *m, bool floated, struct link_socket=
 *sock)
+{
+    struct link_socket_info *lsi =3D &sock->info;
+    const ui=
nt8_t *orig_buf;
+
+    /* decrypt in instance context */
+    struct conte=
xt *c =3D &m->pending->context;
+
+    orig_buf =3D c->c2=2Ebuf=2Edata;
+  =
  if (process_incoming_link_part1(c, lsi, floated))
+    {
+        /* nonz=
ero length means that we have a valid, decrypted packed */
+        if (flo=
ated && c->c2=2Ebuf=2Elen > 0)
+        {
+            multi_process_float(=
m, m->pending, sock);
+        }
+
+        process_incoming_link_part2(c, =
lsi, orig_buf);
+    }
+
+    if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D =
DEV_TYPE_TUN)
+    {
+        struct mroute_addr src, dest;
+        /* ext=
ract packet source and dest addresses */
+        unsigned int mroute_flags=
 =3D
+            mroute_extract_addr_from_packet(&src, &dest, 0, &c->c2=2E=
to_tun, DEV_TYPE_TUN);
+
+        /* drop packet if extract failed */
+    =
    if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
+        {
+           =
 c->c2=2Eto_tun=2Elen =3D 0;
+        }
+        /* make sure that source a=
ddress is associated with this client */
+        else if (multi_get_instan=
ce_by_virtual_addr(m, &src, true) !=3D m->pending)
+        {
+            =
/* IPv6 link-local address (fe80::xxx)? */
+            if ((src=2Etype & M=
R_ADDR_MASK) =3D=3D MR_ADDR_IPV6
+                && IN6_IS_ADDR_LINKLOCAL(=
&src=2Ev6=2Eaddr))
+            {
+                /* do nothing, for now=
=2E  TODO: add address learning */
+            }
+            else
+      =
      {
+                struct gc_arena gc =3D gc_new();
+                =
msg(D_MULTI_DROPPED,
+                    "MULTI: bad source address from c=
lient [%s], packet dropped",
+                    mroute_addr_print(&src, &=
gc));
+                gc_free(&gc);
+            }
+            c->c2=2Eto=
_tun=2Elen =3D 0;
+        }
+        /* client-to-client communication ena=
bled? */
+        else if (m->enable_c2c)
+        {
+            /* multic=
ast? */
+            if (mroute_flags & MROUTE_EXTRACT_MCAST)
+            =
{
+                /* for now, treat multicast as broadcast */
+           =
     multi_bcast(m, &c->c2=2Eto_tun, m->pending, 0);
+            }
+      =
      else /* possible client to client routing */
+            {
+        =
        ASSERT(!(mroute_flags & MROUTE_EXTRACT_BCAST));
+                st=
ruct multi_instance *mi =3D multi_get_instance_by_virtual_addr(m, &dest, tr=
ue);
+
+                /* if dest addr is a known client, route to it */
+=
                if (mi)
+                {
+                    {
+        =
                multi_unicast(m, &c->c2=2Eto_tun, mi);
+                   =
     register_activity(c, BLEN(&c->c2=2Eto_tun));
+                    }
+ =
                   c->c2=2Eto_tun=2Elen =3D 0;
+                }
+        =
    }
+        }
+    }
+    else if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=
=3D DEV_TYPE_TAP)
+    {
+        uint16_t vid =3D 0;
+
+        if (m->top=
=2Eoptions=2Evlan_tagging)
+        {
+            if (vlan_is_tagged(&c->c=
2=2Eto_tun))
+            {
+                /* Drop VLAN-tagged frame=2E *=
/
+                msg(D_VLAN_DEBUG, "dropping incoming VLAN-tagged frame")=
;
+                c->c2=2Eto_tun=2Elen =3D 0;
+            }
+            =
else
+            {
+                vid =3D c->options=2Evlan_pvid;
+     =
       }
+        }
+        /* extract packet source and dest addresses */=

+        struct mroute_addr src, dest;
+        /* extract packet source a=
nd dest addresses */
+        unsigned int mroute_flags =3D
+            mr=
oute_extract_addr_from_packet(&src, &dest, vid, &c->c2=2Eto_tun, DEV_TYPE_T=
AP);
+
+        if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
+        {
+  =
          if (multi_learn_addr(m, m->pending, &src, 0) =3D=3D m->pending)
+=
            {
+                /* check for broadcast */
+                i=
f (m->enable_c2c)
+                {
+                    if (mroute_flags =
& (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))
+                    {
+  =
                      multi_bcast(m, &c->c2=2Eto_tun, m->pending, vid);
+  =
                  }
+                    else /* try client-to-client routi=
ng */
+                    {
+                        struct multi_instance=
 *mi =3D multi_get_instance_by_virtual_addr(m, &dest, false);
+
+          =
              /* if dest addr is a known client, route to it */
+          =
              if (mi)
+                        {
+                         =
   multi_unicast(m, &c->c2=2Eto_tun, mi);
+                            regi=
ster_activity(c, BLEN(&c->c2=2Eto_tun));
+                            c->c2=
=2Eto_tun=2Elen =3D 0;
+                        }
+                    }
+ =
               }
+            }
+            else
+            {
+         =
       struct gc_arena gc =3D gc_new();
+                msg(D_MULTI_DROPPE=
D,
+                    "MULTI: bad source address from client [%s], packet=
 dropped",
+                    mroute_addr_print(&src, &gc));
+           =
     c->c2=2Eto_tun=2Elen =3D 0;
+                gc_free(&gc);
+          =
  }
+        }
+        else
+        {
+            c->c2=2Eto_tun=2Elen =
=3D 0;
+        }
+    }
+}
+
 /*
  * Process packets in the TCP/UDP socket=
 -> TUN/TAP interface direction,
  * i=2Ee=2E client -> server direction=2E=

@@ -3312,9 +3465,6 @@
                             const unsigned int mpp_=
flags, struct link_socket *sock)
 {
     struct context *c;
-    struct mro=
ute_addr src, dest;
-    unsigned int mroute_flags;
-    struct multi_insta=
nce *mi;
     bool ret =3D true;
     bool floated =3D false;
 
@@ -3358,14=
1 +3508,7 @@
 
     if (BLEN(&c->c2=2Ebuf) > 0)
     {
-        struct link=
_socket_info *lsi;
-        const uint8_t *orig_buf;
-
-        /* decrypt =
in instance context */
-
-        lsi =3D &sock->info;
-        orig_buf =
=3D c->c2=2Ebuf=2Edata;
-        if (process_incoming_link_part1(c, lsi, fl=
oated))
-        {
-            /* nonzero length means that we have a vali=
d, decrypted packed */
-            if (floated && c->c2=2Ebuf=2Elen > 0)
-=
            {
-                multi_process_float(m, m->pending, sock);
- =
           }
-
-            process_incoming_link_part2(c, lsi, orig_buf);
=
-        }
-
-        if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D DEV_TYPE=
_TUN)
-        {
-            /* extract packet source and dest addresses *=
/
-            mroute_flags =3D
-                mroute_extract_addr_from_p=
acket(&src, &dest, 0, &c->c2=2Eto_tun, DEV_TYPE_TUN);
-
-            /* dro=
p packet if extract failed */
-            if (!(mroute_flags & MROUTE_EXTR=
ACT_SUCCEEDED))
-            {
-                c->c2=2Eto_tun=2Elen =3D 0;=

-            }
-            /* make sure that source address is associated=
 with this client */
-            else if (multi_get_instance_by_virtual_ad=
dr(m, &src, true) !=3D m->pending)
-            {
-                /* IPv6 =
link-local address (fe80::xxx)? */
-                if ((src=2Etype & MR_AD=
DR_MASK) =3D=3D MR_ADDR_IPV6
-                    && IN6_IS_ADDR_LINKLOCAL(=
&src=2Ev6=2Eaddr))
-                {
-                    /* do nothing, f=
or now=2E  TODO: add address learning */
-                }
-              =
  else
-                {
-                    struct gc_arena gc =3D gc_ne=
w();
-                    msg(D_MULTI_DROPPED,
-                        "MU=
LTI: bad source address from client [%s], packet dropped",
-               =
         mroute_addr_print(&src, &gc));
-                    gc_free(&gc);
=
-                }
-                c->c2=2Eto_tun=2Elen =3D 0;
-          =
  }
-            /* client-to-client communication enabled? */
-           =
 else if (m->enable_c2c)
-            {
-                /* multicast? */
-=
                if (mroute_flags & MROUTE_EXTRACT_MCAST)
-                {=

-                    /* for now, treat multicast as broadcast */
-        =
            multi_bcast(m, &c->c2=2Eto_tun, m->pending, 0);
-              =
  }
-                else /* possible client to client routing */
-        =
        {
-                    ASSERT(!(mroute_flags & MROUTE_EXTRACT_BCAST=
));
-                    mi =3D multi_get_instance_by_virtual_addr(m, &dest=
, true);
-
-                    /* if dest addr is a known client, route to=
 it */
-                    if (mi)
-                    {
-               =
         {
-                            multi_unicast(m, &c->c2=2Eto_tun, m=
i);
-                            register_activity(c, BLEN(&c->c2=2Eto_tun)=
);
-                        }
-                        c->c2=2Eto_tun=2Elen=
 =3D 0;
-                    }
-                }
-            }
-        }=

-        else if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)
-=
        {
-            uint16_t vid =3D 0;
-
-            if (m->top=2Eopti=
ons=2Evlan_tagging)
-            {
-                if (vlan_is_tagged(&c->=
c2=2Eto_tun))
-                {
-                    /* Drop VLAN-tagged f=
rame=2E */
-                    msg(D_VLAN_DEBUG, "dropping incoming VLAN-t=
agged frame");
-                    c->c2=2Eto_tun=2Elen =3D 0;
-          =
      }
-                else
-                {
-                    vid =
=3D c->options=2Evlan_pvid;
-                }
-            }
-            =
/* extract packet source and dest addresses */
-            mroute_flags =
=3D
-                mroute_extract_addr_from_packet(&src, &dest, vid, &c->=
c2=2Eto_tun, DEV_TYPE_TAP);
-
-            if (mroute_flags & MROUTE_EXTRAC=
T_SUCCEEDED)
-            {
-                if (multi_learn_addr(m, m->pen=
ding, &src, 0) =3D=3D m->pending)
-                {
-                    /=
* check for broadcast */
-                    if (m->enable_c2c)
-         =
           {
-                        if (mroute_flags & (MROUTE_EXTRACT_BC=
AST | MROUTE_EXTRACT_MCAST))
-                        {
-                  =
          multi_bcast(m, &c->c2=2Eto_tun, m->pending, vid);
-              =
          }
-                        else /* try client-to-client routing *=
/
-                        {
-                            mi =3D multi_get_=
instance_by_virtual_addr(m, &dest, false);
-
-                            /=
* if dest addr is a known client, route to it */
-                         =
   if (mi)
-                            {
-                                =
multi_unicast(m, &c->c2=2Eto_tun, mi);
-                                reg=
ister_activity(c, BLEN(&c->c2=2Eto_tun));
-                                =
c->c2=2Eto_tun=2Elen =3D 0;
-                            }
-               =
         }
-                    }
-                }
-                else
=
-                {
-                    struct gc_arena gc =3D gc_new();
- =
                   msg(D_MULTI_DROPPED,
-                        "MULTI: ba=
d source address from client [%s], packet dropped",
-                      =
  mroute_addr_print(&src, &gc));
-                    c->c2=2Eto_tun=2Elen =
=3D 0;
-                    gc_free(&gc);
-                }
-            }=

-            else
-            {
-                c->c2=2Eto_tun=2Elen =3D=
 0;
-            }
-        }
+        multi_process_incoming_link_data(m, =
floated, sock);
     }
 
     /* postprocess and set wakeup */

-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I9f10d91407347faf32397535c95e=
2d80a1575bd5
Gerrit-Change-Number: 1722
Gerrit-PatchSet: 3
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--HFBCaYAzrD0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1722?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Move incoming data processing in its own method<br><br>This e=
xtract a large chunk from multi_process_incoming_link into its<br>own metho=
d multi_process_incoming_link_data<br><br>This reduces the complexity of mu=
lti_process_incoming_link further=2E<br><br>A few declarations were moved i=
nto a more logical place but otherwise<br>this is just a simple move=2E<br>=
<br>Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5<br>Signed-off-by: =
Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/multi=2Ec<b=
r>1 file changed, 154 insertions(+), 138 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/22/1=
722/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</s=
pan><br><span>index f19433b=2E=2E625f87d 100644</span><br><span>--- a/src/o=
penvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><spa=
n>@@ -3303,6 +3303,159 @@</span><br><span> }</span><br><span> #endif /* if =
defined(ENABLE_DCO) */</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Process incoming data packet from clients=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * This tries to decrypt and then forward incoming</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * data packets, so the be =
be forwarded=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m P</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param floated</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sock</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+multi_process_incoming_link_data(struct multi_context *m, =
bool floated, struct link_socket *sock)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct link_socket_info *lsi =3D &amp;sock-&gt;info;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *orig_buf;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* decrypt in instance context */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D &a=
mp;m-&gt;pending-&gt;context;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    orig_=
buf =3D c-&gt;c2=2Ebuf=2Edata;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (process_incoming_link_part1(c, lsi, floated))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* nonzero length means that we have=
 a valid, decrypted packed */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (floated &amp;&amp; c-&gt;c2=2Ebuf=2Elen &gt; 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            multi_process_float(m, =
m-&gt;pending, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        process_incoming_li=
nk_part2(c, lsi, orig_buf);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (TUNNEL_TYPE(m-&gt=
;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct mroute_addr src, dest;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* extract packet source and dest addresse=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigne=
d int mroute_flags =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            mroute_extract_addr_from_packet(&amp;src, &amp;dest, 0, &amp=
;c-&gt;c2=2Eto_tun, DEV_TYPE_TUN);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* drop packet if extract failed */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!(mroute_flags &amp; MROUTE_EXTRACT_SUCCEED=
ED))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Eto=
_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* m=
ake sure that source address is associated with this client */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else if (multi_get_insta=
nce_by_virtual_addr(m, &amp;src, true) !=3D m-&gt;pending)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            /* IPv6 link-local address (fe80::=
xxx)? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if ((src=2Etype &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; IN6_IS_ADDR=
_LINKLOCAL(&amp;src=2Ev6=2Eaddr))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                /* do nothing, for now=2E  TODO: add address learni=
ng */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                msg(D_MULTI_DROPPED,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    &quot;MULTI: bad source address from c=
lient [%s], packet dropped&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    mroute_addr_print(&amp;src, &amp;gc));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-=
&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* client-to-client communication enabled? */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else if (m-&gt;enable_c2c)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            /* multicast? */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (mroute_flag=
s &amp; MROUTE_EXTRACT_MCAST)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                /* for now, treat multicast as broadcast */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                multi_bcast(m, =
&amp;c-&gt;c2=2Eto_tun, m-&gt;pending, 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            else /* possible client to client routing */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                ASSERT(!(mr=
oute_flags &amp; MROUTE_EXTRACT_BCAST));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                struct multi_instance *mi =3D multi_ge=
t_instance_by_virtual_addr(m, &amp;dest, true);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                /* if dest addr is a known client, route to it */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (=
mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        register_activity=
(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DE=
V_TYPE_TAP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint16_t vid =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (m-&gt;top=2Eoptions=
=2Evlan_tagging)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (vlan_is_tagged(&amp;c-&gt;c2=2Eto_tun))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                /* Drop VLAN-tagged frame=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_VLAN_DEB=
UG, &quot;dropping incoming VLAN-tagged frame&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2=2Eto_tun=2Elen =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                vid =3D c-&g=
t;options=2Evlan_pvid;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* ex=
tract packet source and dest addresses */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct mroute_addr src, dest;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* extract packet source an=
d dest addresses */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        unsigned int mroute_flags =3D</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            mroute_extract_addr_from_packet(&amp;src, &am=
p;dest, vid, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TAP);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (multi_learn_addr(=
m, m-&gt;pending, &amp;src, 0) =3D=3D m-&gt;pending)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                /* check for broadcast */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (m-&gt=
;enable_c2c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           if (mroute_flags &amp; (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MC=
AST))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, vid);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    e=
lse /* try client-to-client routing */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        struct multi_instance *mi =3D =
multi_get_instance_by_virtual_addr(m, &amp;dest, false);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        /* if dest addr is a known client=
, route to it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     if (mi)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                            multi_unicast(m, &amp;c-&gt;c2=
=2Eto_tun, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                        register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
         c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                struct gc_arena gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                msg(D_MULTI_DROPPED=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  &quot;MULTI: bad source address from client [%s], packet dropped&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    m=
route_addr_print(&amp;src, &amp;gc));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            c-&gt;c2=2Eto_tun=2Elen =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> /*</span><br><span>  * Process packets in the TCP/=
UDP socket -&gt; TUN/TAP interface direction,</span><br><span>  * i=2Ee=2E =
client -&gt; server direction=2E</span><br><span>@@ -3312,9 +3465,6 @@</spa=
n><br><span>                             const unsigned int mpp_flags, stru=
ct link_socket *sock)</span><br><span> {</span><br><span>     struct contex=
t *c;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct mrout=
e_addr src, dest;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
unsigned int mroute_flags;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct multi_instance *mi;</span><br><span>     bool ret =3D true;=
</span><br><span>     bool floated =3D false;</span><br><span> </span><br><=
span>@@ -3358,141 +3508,7 @@</span><br><span> </span><br><span>     if (BLE=
N(&amp;c-&gt;c2=2Ebuf) &gt; 0)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct link_socket_info *lsi;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        const uint8_t *orig=
_buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* decrypt in instance contex=
t */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        lsi =3D &amp;sock-&gt;info;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        orig_buf =3D c-&=
gt;c2=2Ebuf=2Edata;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (process_incoming_link_part1(c, lsi, floated))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            /* nonzero length means that we have a va=
lid, decrypted packed */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if (floated &amp;&amp; c-&gt;c2=2Ebuf=2Elen &gt; 0)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                multi_process_float(m,=
 m-&gt;pending, sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            process_incoming=
_link_part2(c, lsi, orig_buf);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (TUNNEL_TYPE(=
m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            /* extract packet source and dest addresses */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            mroute_flags =
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mr=
oute_extract_addr_from_packet(&amp;src, &amp;dest, 0, &amp;c-&gt;c2=2Eto_tu=
n, DEV_TYPE_TUN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* drop packe=
t if extract failed */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            if (!(mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                c-&gt;c2=2Eto_tun=2Elen =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* make sur=
e that source address is associated with this client */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            else if (multi_get_instance_b=
y_virtual_addr(m, &amp;src, true) !=3D m-&gt;pending)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                /* IPv6 link-local address (fe80::x=
xx)? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  if ((src=2Etype &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    &amp;&amp; IN6_IS_A=
DDR_LINKLOCAL(&amp;src=2Ev6=2Eaddr))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    /* do nothing, for now=2E  TODO: add address=
 learning */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    msg(D_MULTI_DROPPED,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        &quot;MULTI: bad so=
urce address from client [%s], packet dropped&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        mroute_addr_print(&=
amp;src, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            /* client-to-client communication en=
abled? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
else if (m-&gt;enable_c2c)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             /* multicast? */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                if (mroute_flags &amp; MROUTE_EXTRACT_MCAST)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    /* for now, =
treat multicast as broadcast */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;=
pending, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   else /* possible client to client routing */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    ASSERT(!(mroute_flags &amp; MROUT=
E_EXTRACT_BCAST));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 mi =3D multi_get_instance_by_virtual_addr(m, &amp;dest, tr=
ue);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    /* if dest addr is=
 a known client, route to it */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    if (mi)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                            multi_unicast(m, &amp;c-&gt=
;c2=2Eto_tun, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                         register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
        c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 else if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            uint16_t vid =3D 0;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            if (m-&gt;top=2Eoptions=2Evlan_tagging)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                if (vlan_is_ta=
gged(&amp;c-&gt;c2=2Eto_tun))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    /* Drop VLAN-tagged frame=2E */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    msg(D_VLAN_DEBUG, &qu=
ot;dropping incoming VLAN-tagged frame&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    c-&gt;c2=2Eto_tun=2Elen =3D 0;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                else</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    vid =3D c-=
&gt;options=2Evlan_pvid;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   /* extract packet source and dest addresses */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            mroute_flags =3D</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                mroute_extract_addr_from=
_packet(&amp;src, &amp;dest, vid, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TAP);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (mroute_flags &amp; MROUTE_E=
XTRACT_SUCCEEDED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    if (multi_learn_addr(m, m-&gt;pending, &amp;src, 0) =3D=3D m-&gt;pendin=
g)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    /* =
check for broadcast */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    if (m-&gt;enable_c2c)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                        if (mroute_flags &amp; (MROUTE=
_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                            multi_bcast(m, &amp;c-&gt=
;c2=2Eto_tun, m-&gt;pending, vid);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                        else /* try client-to-client routi=
ng */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                mi =3D multi_get_instance_by_virtual_addr(m, &amp;dest, fal=
se);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                            /* if dest=
 addr is a known client, route to it */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                            if (mi)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                            {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                mul=
ti_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                register_activity(c, B=
LEN(&amp;c-&gt;c2=2Eto_tun));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                c-&gt;c2=2Eto_tun=2Elen =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    msg(D_MULTI_DROPPED,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        &quot;MULTI: bad source =
address from client [%s], packet dropped&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                        mroute_addr_print(&amp;sr=
c, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        multi_process_incoming_link_data(m, floated, soc=
k);</span><br><span>     }</span><br><span> </span><br><span>     /* postpr=
ocess and set wakeup */</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail">chan=
ge 1722</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I9f10d91407347faf32397535c95e2d80a1575bd5 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1722 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--HFBCaYAzrD0=--


--===============4892367972622372130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4892367972622372130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4892367972622372130==--

