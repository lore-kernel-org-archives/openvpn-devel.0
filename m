Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE95C4450A
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sEIgW39/EnrlESEM5K6Jr2ECH7bqQN6NkFgnGV3AqII=; b=Y6DFwVg91XZrzKDGIdK0aXqBf1
	FfH5djUtS6NO8fkNFRK7pApiAvt2OgWvCE+Gff+5Diwi/mtuRMKB2sdtt0imqQRtezv5ybMUAfjeA
	pP3cpfaQ5g3c8scxX638x9gIH99DLvrssN6F30Xpff0XzYFApVzxqnLMw/41myOiWn9s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjclY-00013f-CA;
	Tue, 14 Jul 2026 13:01:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjclT-00013R-HU
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dEeeHkTj0xktEWwSwmmMKP0IX9u7xB7odMBXdNwtC28=; b=dhEXP+VorMMXEo8qFfW2b/MFjl
 608XSOhyLyiMNvolHBclofW8chJ9VxOcRn6KW+xnHwu5L4aN4tDDaVlv6x25lk1SUwobuxRDnj3B4
 05asjSVdST5zxCXL2ywbdphPtua8AL7uuKiZt+c3pBiCk5nn0e0df0AaTpa49QDBEJgY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dEeeHkTj0xktEWwSwmmMKP0IX9u7xB7odMBXdNwtC28=; b=Y
 uG+JlppvLs3ZyOb82wfZ9ryGrvZYfj44LtFgsIl7kHAbjipAL63gkKOSXMZfleCWNA875YhMSCufB
 MrjfLxZxIEhIMQtTHlWWOtEZkAhUZG3ccjo4rrHwGVzM1t8IhTWYQFRDdLUj8uE/4umCRehreNN7X
 vrIn0Xmzy93q89iM=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjclO-00028l-KL for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:34 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-474560436c3so730743f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784034084; x=1784638884; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dEeeHkTj0xktEWwSwmmMKP0IX9u7xB7odMBXdNwtC28=;
 b=W3z32jWnxBheU3ImC6kiK5wRsXHSHFNgx5K+j+Hxyo7N2aeUVlltAQISjzlj4pPlY3
 v1mZdmszE6IftIO7hxMnN79P/CbvP1ofCraLCzcoVN3fLxRAYGKN+IJrAA/2+PC/qSZX
 dLNIWcDMDJVuDfE3cLswWl/UUpJhMgdY8OljBFjKA2eY41nCxsVy26hP/Rn95dRyLGs0
 w7un3R4mrzu6siG5lJqCLUr49qQG899iFfu+D0us9VCC8BFAn82S66p+ZBgJRBwsAZ/m
 F9BI1T+s/eL0hQK3W0O23tz7jXfbHBUuWJxuppl+V6m838+8Z5Gwcgj7CEmrPqI0ahPl
 eNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784034084; x=1784638884;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dEeeHkTj0xktEWwSwmmMKP0IX9u7xB7odMBXdNwtC28=;
 b=OVMFa0U0Crj66wdY1IMs9/z839WzQAmizO9wmCj+v3y5H9PgLjQNESNjQj0wspZerR
 Se0m4UonyvE0Okx+TF+OL/2XU9Jl54feBO8SE5SGwI+AG1PJdX2Q0aYeXJPcEa/J1PrW
 Nl1z8Xfq34nafRd1x4ZqiQEUqU0ibG/LxpoC8Pd8mzivBW7svIshlBy1FPrJM2sCs0lR
 sYxfBBC6sMw7JCUJnsY9Olob1f/ZPV6On2aT5sfKKhswCY/zw6Kxp3xFZ/5y04NF9o/f
 XsH52Lpx3+FoS6VyzhRCuIVm6zyjppvBbDIyH3lHem96FuNVTbXSCP415luXbRkVnVYv
 yr6Q==
X-Gm-Message-State: AOJu0Yyt3GiE0CyKTmmDIHkoCZGGLY0fgjwhZkUT9bHbqXMkS7us/YSV
 SHFCAzR9Z4UDyU6aNqW1120Pn9jg7xzuQxrqOI+EhrGoTtuxiTcjafxvBA5U7QWmp+b6eO5I6Vi
 79h54kxaho3Z2gDG6rs4jt9o2ojq+60rh4w5KosWSkiBN/+oGZ45DaMecI5J9EM/SPJ9RDj70DO
 e3P0/TWg==
X-Gm-Gg: AfdE7cmI80pIiv7kDy2ASFJi5g29icxYG2FemPsKrl626VzH7c887/4wl4ufnYeDPUm
 VbNqjVlig2ne+c002xKSSAkEw5F9gg+s9zySRmQVFhUbHDWqhU+JKCry+7ewXnMCeaWxZiLVsJb
 lRi9zj24AA4I11+Sq92w9zHwRx4+8Y5s0qPlKLuLqmhzQFui6NfFTg9yeZpp5zMHY1Wlg4NjOfD
 9jqQ8jR8TBre+osI9qHPL8bPfLH6XlJzDWEaHTykaye+8tgwlO6MeRbWByWNEwrXcFBMsix11uB
 5m1AcPeiGyUmGNZKYzKjbIWdgn4E1xAKFHJme4fHtZKSr0YZRxLORdrtVofSfAqQSgs4PLOx0pC
 t0Guvc4raX4fER8fLAEt/ZRGwyeOIgz5YymGCvPC8SSsyXMkeSs0BfSV4PXgRaJjq6VQOqyxYbu
 7QrCKJkpWxvw6WKjCM5JuqFyA2OXh52p4WV/bGqX3Z7iIzDjF3HdNs9Age9NEG2M5s7svOqmmLf
 P+OOU/ZUCY5DTVHxZSc5hY8j1LcdD2SbEBxz/cIZnigQnXRVzPLLbfADHjNaDaO5Vld0boVhg/V
 NzY=
X-Received: by 2002:a05:6000:2912:b0:47d:e022:944c with SMTP id
 ffacd0b85a97d-47f2dcb5bd8mr14555976f8f.4.1784034083334; 
 Tue, 14 Jul 2026 06:01:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c7c96sm8054258f8f.33.2026.07.14.06.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:01:22 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 13:01:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
X-Gerrit-Change-Number: 1722
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1722?usp=email>
X-Gerrit-Commit: d14f3df670f07842af4166c078326e8345d2b1ff
In-Reply-To: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
References: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk5ZjEwZDkxNDA3MzQ3ZmFmMzIzOTc1MzVjOTVlMmQ4MGExNTc1YmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <afa9197e3c1cecd3b20d1f9276ddcbd16cdf5d22-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjclO-00028l-KL
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
Content-Type: multipart/mixed; boundary="===============7687809351245199242=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7687809351245199242==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ffeu5C1alUY="; charset=UTF-8

--Ffeu5C1alUY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1722?usp=3Demail

to look at the new patch set (#4=
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
1 file changed, 150 insertions(+), 138 deletions(-)


  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/22/1722/4

diff --=
git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index d70245f=2E=2E7535=
797 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3302=
,6 +3302,155 @@
 }
 #endif /* if defined(ENABLE_DCO) */
 
+/**
+ * Process =
incoming data packet from clients=2E
+ *
+ * This tries to decrypt and then=
 forward incoming
+ * data packets=2E
+ */
+static void
+multi_process_inco=
ming_link_data(struct multi_context *m, bool floated, struct link_socket *s=
ock)
+{
+    struct link_socket_info *lsi =3D &sock->info;
+    const uint8=
_t *orig_buf;
+
+    /* decrypt in instance context */
+    struct context =
*c =3D &m->pending->context;
+
+    orig_buf =3D c->c2=2Ebuf=2Edata;
+    i=
f (process_incoming_link_part1(c, lsi, floated))
+    {
+        /* nonzero=
 length means that we have a valid, decrypted packed */
+        if (floate=
d && c->c2=2Ebuf=2Elen > 0)
+        {
+            multi_process_float(m, =
m->pending, sock);
+        }
+
+        process_incoming_link_part2(c, lsi=
, orig_buf);
+    }
+
+    if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D DEV=
_TYPE_TUN)
+    {
+        struct mroute_addr src, dest;
+        /* extrac=
t packet source and dest addresses */
+        unsigned int mroute_flags =
=3D
+            mroute_extract_addr_from_packet(&src, &dest, 0, &c->c2=2Et=
o_tun, DEV_TYPE_TUN);
+
+        /* drop packet if extract failed */
+     =
   if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
+        {
+            =
c->c2=2Eto_tun=2Elen =3D 0;
+        }
+        /* make sure that source ad=
dress is associated with this client */
+        else if (multi_get_instanc=
e_by_virtual_addr(m, &src, true) !=3D m->pending)
+        {
+            /=
* IPv6 link-local address (fe80::xxx)? */
+            if ((src=2Etype & MR=
_ADDR_MASK) =3D=3D MR_ADDR_IPV6
+                && IN6_IS_ADDR_LINKLOCAL(&=
src=2Ev6=2Eaddr))
+            {
+                /* do nothing, for now=2E=
  TODO: add address learning */
+            }
+            else
+         =
   {
+                struct gc_arena gc =3D gc_new();
+                msg=
(D_MULTI_DROPPED,
+                    "MULTI: bad source address from clie=
nt [%s], packet dropped",
+                    mroute_addr_print(&src, &gc)=
);
+                gc_free(&gc);
+            }
+            c->c2=2Eto_tu=
n=2Elen =3D 0;
+        }
+        /* client-to-client communication enable=
d? */
+        else if (m->enable_c2c)
+        {
+            /* multicast=
? */
+            if (mroute_flags & MROUTE_EXTRACT_MCAST)
+            {
+=
                /* for now, treat multicast as broadcast */
+              =
  multi_bcast(m, &c->c2=2Eto_tun, m->pending, 0);
+            }
+         =
   else /* possible client to client routing */
+            {
+           =
     ASSERT(!(mroute_flags & MROUTE_EXTRACT_BCAST));
+                struc=
t multi_instance *mi =3D multi_get_instance_by_virtual_addr(m, &dest, true)=
;
+
+                /* if dest addr is a known client, route to it */
+   =
             if (mi)
+                {
+                    {
+           =
             multi_unicast(m, &c->c2=2Eto_tun, mi);
+                      =
  register_activity(c, BLEN(&c->c2=2Eto_tun));
+                    }
+    =
                c->c2=2Eto_tun=2Elen =3D 0;
+                }
+           =
 }
+        }
+    }
+    else if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D=
 DEV_TYPE_TAP)
+    {
+        uint16_t vid =3D 0;
+
+        if (m->top=2E=
options=2Evlan_tagging)
+        {
+            if (vlan_is_tagged(&c->c2=
=2Eto_tun))
+            {
+                /* Drop VLAN-tagged frame=2E */=

+                msg(D_VLAN_DEBUG, "dropping incoming VLAN-tagged frame");=

+                c->c2=2Eto_tun=2Elen =3D 0;
+            }
+            e=
lse
+            {
+                vid =3D c->options=2Evlan_pvid;
+      =
      }
+        }
+        /* extract packet source and dest addresses */
=
+        struct mroute_addr src, dest;
+        /* extract packet source an=
d dest addresses */
+        unsigned int mroute_flags =3D
+            mro=
ute_extract_addr_from_packet(&src, &dest, vid, &c->c2=2Eto_tun, DEV_TYPE_TA=
P);
+
+        if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
+        {
+   =
         if (multi_learn_addr(m, m->pending, &src, 0) =3D=3D m->pending)
+ =
           {
+                /* check for broadcast */
+                if=
 (m->enable_c2c)
+                {
+                    if (mroute_flags &=
 (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))
+                    {
+   =
                     multi_bcast(m, &c->c2=2Eto_tun, m->pending, vid);
+   =
                 }
+                    else /* try client-to-client routin=
g */
+                    {
+                        struct multi_instance =
*mi =3D multi_get_instance_by_virtual_addr(m, &dest, false);
+
+           =
             /* if dest addr is a known client, route to it */
+           =
             if (mi)
+                        {
+                          =
  multi_unicast(m, &c->c2=2Eto_tun, mi);
+                            regis=
ter_activity(c, BLEN(&c->c2=2Eto_tun));
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

@@ -3311,9 +3460,6 @@
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
 
@@ -3357,14=
1 +3503,7 @@
 
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
Gerrit-PatchSet: 4
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--Ffeu5C1alUY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #4</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
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
r>1 file changed, 150 insertions(+), 138 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/22/1=
722/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</s=
pan><br><span>index d70245f=2E=2E7535797 100644</span><br><span>--- a/src/o=
penvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><spa=
n>@@ -3302,6 +3302,155 @@</span><br><span> }</span><br><span> #endif /* if =
defined(ENABLE_DCO) */</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Process incoming data packet from clients=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * This tries to decrypt and then forward incoming</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * data packets=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+multi_process_incoming_link_data(struct multi_contex=
t *m, bool floated, struct link_socket *sock)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct link_socket_info *lsi =3D &amp;sock-&gt;info;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *orig_buf;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* decrypt in instance context */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =
=3D &amp;m-&gt;pending-&gt;context;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 orig_buf =3D c-&gt;c2=2Ebuf=2Edata;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (process_incoming_link_part1(c, lsi, floated))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* nonzero length means that w=
e have a valid, decrypted packed */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (floated &amp;&amp; c-&gt;c2=2Ebuf=2Elen &gt; 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            multi_process_flo=
at(m, m-&gt;pending, sock);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        process_incom=
ing_link_part2(c, lsi, orig_buf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (TUNNEL_TYPE=
(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        struct mroute_addr src, dest;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* extract packet source and dest ad=
dresses */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        u=
nsigned int mroute_flags =3D</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            mroute_extract_addr_from_packet(&amp;src, &amp;dest, 0=
, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TUN);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* drop packet if extract failed */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (!(mroute_flags &amp; MROUTE_EXTRACT_S=
UCCEEDED))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c=
2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* make sure that source address is associated with this client */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (multi_get=
_instance_by_virtual_addr(m, &amp;src, true) !=3D m-&gt;pending)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            /* IPv6 link-local address (=
fe80::xxx)? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if ((src=2Etype &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; IN6_I=
S_ADDR_LINKLOCAL(&amp;src=2Ev6=2Eaddr))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                /* do nothing, for now=2E  TODO: add address =
learning */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                msg(D_MULTI_DROPPED,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    &quot;MULTI: bad source address =
from client [%s], packet dropped&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    mroute_addr_print(&amp;src, &amp;gc=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* client-to-client communication enabled? */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        else if (m-&gt;enable_c2c)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            /* multicast? */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (mroute=
_flags &amp; MROUTE_EXTRACT_MCAST)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                /* for now, treat multicast as broadcast */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                multi_bcas=
t(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, 0);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            else /* possible client to client routing=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                ASSERT=
(!(mroute_flags &amp; MROUTE_EXTRACT_BCAST));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                struct multi_instance *mi =3D mul=
ti_get_instance_by_virtual_addr(m, &amp;dest, true);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                /* if dest addr is a known client, route to =
it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  if (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                        register_ac=
tivity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    c-&gt;c2=2Eto_tun=2Elen =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=
=3D DEV_TYPE_TAP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint16_t=
 vid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m-&gt;top=2Eopt=
ions=2Evlan_tagging)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (vlan_is_tagged(&amp;c-&gt;c2=2Eto_tun))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                /* Drop VLAN-tagged frame=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_VLAN=
_DEBUG, &quot;dropping incoming VLAN-tagged frame&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2=2Eto_tun=2El=
en =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                vid =3D c=
-&gt;options=2Evlan_pvid;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 extract packet source and dest addresses */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct mroute_addr src, dest;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* extract packet source=
 and dest addresses */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        unsigned int mroute_flags =3D</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            mroute_extract_addr_from_packet(&amp;src, =
&amp;dest, vid, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TAP);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (multi_learn_addr=
(m, m-&gt;pending, &amp;src, 0) =3D=3D m-&gt;pending)</span><br><span style=
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
client -&gt; server direction=2E</span><br><span>@@ -3311,9 +3460,6 @@</spa=
n><br><span>                             const unsigned int mpp_flags, stru=
ct link_socket *sock)</span><br><span> {</span><br><span>     struct contex=
t *c;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct mrout=
e_addr src, dest;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
unsigned int mroute_flags;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct multi_instance *mi;</span><br><span>     bool ret =3D true;=
</span><br><span>     bool floated =3D false;</span><br><span> </span><br><=
span>@@ -3357,141 +3503,7 @@</span><br><span> </span><br><span>     if (BLE=
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
rrit-PatchSet: 4 </div>
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
--Ffeu5C1alUY=--


--===============7687809351245199242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7687809351245199242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7687809351245199242==--

