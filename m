Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE1DC4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 18:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5tNHnbIRdFQ+WsXGe3ft2TOD/a/or++XpRe0GYMx+uk=; b=a2uhgpfxQRHJBW/PXnurWGycis
	AdnFnYgOVPerWFfbFMdDYkU7A50dYyL7RL1/WiryRal/8zHHc2a26J+D2Be1l8mUsyzxIuc9fLil2
	hMdAmG+Y5uhN60VG0wLAgbp4MF9WCJZkQlrFXh+S13aDdeZCrm37p4kfH7oGYlL1GjIc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkmul-0005dK-WC;
	Fri, 17 Jul 2026 18:03:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkmuk-0005dB-9r
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 18:03:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=57g/FBRuc7si/iJTx88s1+3hKMmXxsjO0vigJ4Qy+zE=; b=g/7ouykyR1CVDU+Wy308C/D5mR
 kOT9szSHQA4PyOUz4ywz4japywks/usfVzcSpRdTiM774pFDfMNqTbc8Y08Nv1EpYnnZECllC1J8k
 Q74uGEXHTTvpkxZKUOPamcWv4tIqnX+1sWkInriLTc6rPGuROyycMrwCH3ZwWvEQY86I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=57g/FBRuc7si/iJTx88s1+3hKMmXxsjO0vigJ4Qy+zE=; b=N
 wN+b/gf/GEqBSIv3kzp4WoPyS9Jk5PSRem/50uT2eUN0cBkG4t6CCrCvnI1/DsdKmrkt2/oQwZ7go
 cxZ70pmEaXqypQV63IffoBNVHxzXaxLF4pOG/RrIahUxgjjsKZZ3ocVvgeMdcZRqG6VC9tm7GNdAj
 mD7JsA0lU2yEeAcI=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkmug-0007Ld-1P for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 18:03:55 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so4269130f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 11:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784311427; x=1784916227; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=57g/FBRuc7si/iJTx88s1+3hKMmXxsjO0vigJ4Qy+zE=;
 b=I8+/n/zhsIP/WNf5nn4BXQoYZMsUnxwzuVf1hSwPef09AUV0wqebFTYlU2yTRnbfHL
 55GXXLqOpuRheb43Bd09ZfmMboPMszMotg/mpHIAlijOlFGCdPUh/p0T6NoGLo++Gi6y
 SdcRuBI4zmsZnFGA/VwZ0U6GBvbGaYf2bpYBl6cIegCXMRAZW/SqkwZBvBF86UgHHoD2
 H3/Ev0Ja2MIviR5HFlVoLZNv8SyBKMJylnU+pYw1B5C5o1JyGkV+TDD2maDyUnd7SXMD
 EgkT9vZNwVwPx10diA6ZRSwPW3hUu5WLjaqVeP8J/J1hqGx3daVGtBCZHD5UlQwTUpxh
 Mkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784311427; x=1784916227;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=57g/FBRuc7si/iJTx88s1+3hKMmXxsjO0vigJ4Qy+zE=;
 b=f9UKb2RM/tLdG9gc2Vr87Az+ybDWhGx5uYLrbMb5Rio9OpOQXEArhGyF1VXVqeUlWp
 QvJ3wy/36GUZGbfd/DqxKwUzczCXIbIHCv4anHzp+aQiIxgq4jMYbM/Y0gW0OR26RNSs
 SSXs6U499zmhf/sORV9jz8kpiwjH/26KxxV5jw5SEEKi36e9Cyp2IUhpMwBHV5UHwCsj
 VX+qLJTZGMLQx/0SyqvpZbmKKwE5ZHbonq79jpEMOY0MOosL0vAM/jilWYqaPprlc6LO
 vOHQpMbyKsmKEJJzZIwMoC3ku128wpBEs77aE4rF97uSo9iwzv74Gt9YhYweuo0QYSJq
 J20A==
X-Forwarded-Encrypted: i=1;
 AHgh+Romzmc/3ZU471JdYjAabVw4VICoQbWjGD4zBTKiVkloF8wXMrndp8I7Kg+iQL/JOgdmiC9+HVbv0ErhgpNP@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxHEoW2Zx299GVTD496vG8KUTIBdIZQapB8eMIylnCkPm5hrqIA
 fIpsN0UtcUUsvQ98SJPw6GJHlXSL37qMQdnY17LFFEh1SenCXDr+1ZMT9pZ0XDfrSfenVzqGY6y
 ZL7s1alUrDZq82lPc2aI0WvjYbzVmZSB8WRMUnUU2Y4R0KlD3HUheFtAAlO5ne2jDrvfD
X-Gm-Gg: AfdE7cn/FTSBEiopnXsMYPfbbrp92l+Ivj4cr3P6sp9wmWZYdfhRnYOXLxz3oHqs4Zr
 FiUO/8a/4N6/NoB0yhUUQs7TfqfQEwnjhjpZlveLa5Wfl8IMr8Qs5EE4/rAG5/hr/9jAOVS+4kI
 sL5uai3/iAY5RD9XGoT1lXgEUzayCIgfHmeOI5Xlt+C0MgIYdv8mgLdYK7WyHz9G7LedGSpzna5
 SLkq+W1xw0cImUL9ARd+abS+B9RzXbh4vUo3+TWNY6tP/sfUUdEGWQeZXx1NXk7DHcMtYeml6Hi
 iM0AqXrMoiRToCmLWxkf7mz/FX4HsvtR7I1u+J4lmWyFbkvJ3KZpOEAriylq57HmPlFt7iK4twR
 aLmasGNvLVpHv63MNAkB4MZ/rynDGK8q/o+qQj6nRdfyVySdeCTbv8SSN71ZafTRhyj0imhNBCJ
 KGoWIRUbe0GEwXXVgqaf6VjaIXrDZr6oHcFMAHZrR4J57ZxnqAMmIGVuw5jhA+lz5KBFR6A1J0i
 hcLjH6qZIb4hcl6zY/zzkekrj48LD1nGCnledLL+UUyRHuXkKh1tvZrOIlfywKmOqZK
X-Received: by 2002:a05:6000:3110:b0:475:6c34:2120 with SMTP id
 ffacd0b85a97d-47f6230bd64mr5123165f8f.18.1784311427156; 
 Fri, 17 Jul 2026 11:03:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm5193518f8f.4.2026.07.17.11.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 11:03:46 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 18:03:46 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
X-Gerrit-Change-Number: 1722
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1722?usp=email>
X-Gerrit-Commit: 27a39d7c0b2ca7f9fc8b7dae0ea3570369f6ae25
In-Reply-To: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
References: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk5ZjEwZDkxNDA3MzQ3ZmFmMzIzOTc1MzVjOTVlMmQ4MGExNTc1YmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c959f9430033473450b2d4607202b1f3306c0ada-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkmug-0007Ld-1P
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8628431830249444113=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8628431830249444113==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qyjUSGDTbqc="; charset=UTF-8

--qyjUSGDTbqc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1722?usp=3Demail )

Change subject: Move incoming data processing in it=
s own method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Move incoming data processing in its own method

This extract a large chu=
nk from multi_process_incoming_link into its
own method multi_process_incom=
ing_link_data

This reduces the complexity of multi_process_incoming_link f=
urther=2E

A few declarations were moved into a more logical place but othe=
rwise
this is just a simple move=2E

Change-Id: I9f10d91407347faf32397535c9=
5e2d80a1575bd5
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1722
Message-Id: <20260717141442=2E22943-1-gert@gree=
nie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg37674=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/multi=2Ec
1 file changed, 150 insertions(=
+), 138 deletions(-)




diff --git a/src/openvpn/multi=2Ec b/src/openvpn/m=
ulti=2Ec
index c4293a7=2E=2Efe2badb 100644
--- a/src/openvpn/multi=2Ec
+++ =
b/src/openvpn/multi=2Ec
@@ -3298,6 +3298,155 @@
 }
 #endif /* if defined(EN=
ABLE_DCO) */
 
+/**
+ * Process incoming data packet from clients=2E
+ *
+ =
* This tries to decrypt and then forward incoming
+ * data packets=2E
+ */
=
+static void
+multi_process_incoming_link_data(struct multi_context *m, boo=
l floated, struct link_socket *sock)
+{
+    struct link_socket_info *lsi =
=3D &sock->info;
+    const uint8_t *orig_buf;
+
+    /* decrypt in instanc=
e context */
+    struct context *c =3D &m->pending->context;
+
+    orig_b=
uf =3D c->c2=2Ebuf=2Edata;
+    if (process_incoming_link_part1(c, lsi, flo=
ated))
+    {
+        /* nonzero length means that we have a valid, decryp=
ted packed */
+        if (floated && c->c2=2Ebuf=2Elen > 0)
+        {
+  =
          multi_process_float(m, m->pending, sock);
+        }
+
+        p=
rocess_incoming_link_part2(c, lsi, orig_buf);
+    }
+
+    if (TUNNEL_TYPE=
(m->top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
+    {
+        struct mroute_a=
ddr src, dest;
+        /* extract packet source and dest addresses */
+   =
     unsigned int mroute_flags =3D
+            mroute_extract_addr_from_pa=
cket(&src, &dest, 0, &c->c2=2Eto_tun, DEV_TYPE_TUN);
+
+        /* drop pac=
ket if extract failed */
+        if (!(mroute_flags & MROUTE_EXTRACT_SUCCE=
EDED))
+        {
+            c->c2=2Eto_tun=2Elen =3D 0;
+        }
+    =
    /* make sure that source address is associated with this client */
+   =
     else if (multi_get_instance_by_virtual_addr(m, &src, true) !=3D m->pen=
ding)
+        {
+            /* IPv6 link-local address (fe80::xxx)? */
+ =
           if ((src=2Etype & MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6
+           =
     && IN6_IS_ADDR_LINKLOCAL(&src=2Ev6=2Eaddr))
+            {
+          =
      /* do nothing, for now=2E  TODO: add address learning */
+           =
 }
+            else
+            {
+                struct gc_arena gc =3D=
 gc_new();
+                msg(D_MULTI_DROPPED,
+                    "MULT=
I: bad source address from client [%s], packet dropped",
+                 =
   mroute_addr_print(&src, &gc));
+                gc_free(&gc);
+         =
   }
+            c->c2=2Eto_tun=2Elen =3D 0;
+        }
+        /* client=
-to-client communication enabled? */
+        else if (m->enable_c2c)
+    =
    {
+            /* multicast? */
+            if (mroute_flags & MROUTE_=
EXTRACT_MCAST)
+            {
+                /* for now, treat multicast =
as broadcast */
+                multi_bcast(m, &c->c2=2Eto_tun, m->pending=
, 0);
+            }
+            else /* possible client to client routing=
 */
+            {
+                ASSERT(!(mroute_flags & MROUTE_EXTRACT_=
BCAST));
+                struct multi_instance *mi =3D multi_get_instance_=
by_virtual_addr(m, &dest, true);
+
+                /* if dest addr is a kn=
own client, route to it */
+                if (mi)
+                {
+   =
                 {
+                        multi_unicast(m, &c->c2=2Eto_tu=
n, mi);
+                        register_activity(c, BLEN(&c->c2=2Eto_tun)=
);
+                    }
+                    c->c2=2Eto_tun=2Elen =3D 0;
=
+                }
+            }
+        }
+    }
+    else if (TUNNEL_TY=
PE(m->top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)
+    {
+        uint16_t vid =
=3D 0;
+
+        if (m->top=2Eoptions=2Evlan_tagging)
+        {
+        =
    if (vlan_is_tagged(&c->c2=2Eto_tun))
+            {
+                /*=
 Drop VLAN-tagged frame=2E */
+                msg(D_VLAN_DEBUG, "dropping =
incoming VLAN-tagged frame");
+                c->c2=2Eto_tun=2Elen =3D 0;
=
+            }
+            else
+            {
+                vid =3D c-=
>options=2Evlan_pvid;
+            }
+        }
+        /* extract packet =
source and dest addresses */
+        struct mroute_addr src, dest;
+      =
  /* extract packet source and dest addresses */
+        unsigned int mrou=
te_flags =3D
+            mroute_extract_addr_from_packet(&src, &dest, vid,=
 &c->c2=2Eto_tun, DEV_TYPE_TAP);
+
+        if (mroute_flags & MROUTE_EXTRA=
CT_SUCCEEDED)
+        {
+            if (multi_learn_addr(m, m->pending, &=
src, 0) =3D=3D m->pending)
+            {
+                /* check for bro=
adcast */
+                if (m->enable_c2c)
+                {
+         =
           if (mroute_flags & (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST)=
)
+                    {
+                        multi_bcast(m, &c->c2=2Et=
o_tun, m->pending, vid);
+                    }
+                    else /=
* try client-to-client routing */
+                    {
+                 =
       struct multi_instance *mi =3D multi_get_instance_by_virtual_addr(m, =
&dest, false);
+
+                        /* if dest addr is a known client=
, route to it */
+                        if (mi)
+                        =
{
+                            multi_unicast(m, &c->c2=2Eto_tun, mi);
+    =
                        register_activity(c, BLEN(&c->c2=2Eto_tun));
+     =
                       c->c2=2Eto_tun=2Elen =3D 0;
+                       =
 }
+                    }
+                }
+            }
+            el=
se
+            {
+                struct gc_arena gc =3D gc_new();
+      =
          msg(D_MULTI_DROPPED,
+                    "MULTI: bad source addr=
ess from client [%s], packet dropped",
+                    mroute_addr_pri=
nt(&src, &gc));
+                c->c2=2Eto_tun=2Elen =3D 0;
+             =
   gc_free(&gc);
+            }
+        }
+        else
+        {
+      =
      c->c2=2Eto_tun=2Elen =3D 0;
+        }
+    }
+}
+
 /*
  * Process pa=
ckets in the TCP/UDP socket -> TUN/TAP interface direction,
  * i=2Ee=2E cl=
ient -> server direction=2E
@@ -3307,9 +3456,6 @@
                         =
    const unsigned int mpp_flags, struct link_socket *sock)
 {
     struct =
context *c;
-    struct mroute_addr src, dest;
-    unsigned int mroute_fla=
gs;
-    struct multi_instance *mi;
     bool ret =3D true;
     bool float=
ed =3D false;
 
@@ -3353,141 +3499,7 @@
 
     if (BLEN(&c->c2=2Ebuf) > 0)
=
     {
-        struct link_socket_info *lsi;
-        const uint8_t *orig_=
buf;
-
-        /* decrypt in instance context */
-
-        lsi =3D &sock-=
>info;
-        orig_buf =3D c->c2=2Ebuf=2Edata;
-        if (process_incom=
ing_link_part1(c, lsi, floated))
-        {
-            /* nonzero length =
means that we have a valid, decrypted packed */
-            if (floated &&=
 c->c2=2Ebuf=2Elen > 0)
-            {
-                multi_process_float=
(m, m->pending, sock);
-            }
-
-            process_incoming_link_=
part2(c, lsi, orig_buf);
-        }
-
-        if (TUNNEL_TYPE(m->top=2Ec1=
=2Etuntap) =3D=3D DEV_TYPE_TUN)
-        {
-            /* extract packet s=
ource and dest addresses */
-            mroute_flags =3D
-                =
mroute_extract_addr_from_packet(&src, &dest, 0, &c->c2=2Eto_tun, DEV_TYPE_T=
UN);
-
-            /* drop packet if extract failed */
-            if (!(=
mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
-            {
-                c=
->c2=2Eto_tun=2Elen =3D 0;
-            }
-            /* make sure that so=
urce address is associated with this client */
-            else if (multi_=
get_instance_by_virtual_addr(m, &src, true) !=3D m->pending)
-            {=

-                /* IPv6 link-local address (fe80::xxx)? */
-             =
   if ((src=2Etype & MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6
-                   =
 && IN6_IS_ADDR_LINKLOCAL(&src=2Ev6=2Eaddr))
-                {
-          =
          /* do nothing, for now=2E  TODO: add address learning */
-       =
         }
-                else
-                {
-                    st=
ruct gc_arena gc =3D gc_new();
-                    msg(D_MULTI_DROPPED,
- =
                       "MULTI: bad source address from client [%s], packet =
dropped",
-                        mroute_addr_print(&src, &gc));
-        =
            gc_free(&gc);
-                }
-                c->c2=2Eto_tu=
n=2Elen =3D 0;
-            }
-            /* client-to-client communicatio=
n enabled? */
-            else if (m->enable_c2c)
-            {
-        =
        /* multicast? */
-                if (mroute_flags & MROUTE_EXTRACT=
_MCAST)
-                {
-                    /* for now, treat multicast=
 as broadcast */
-                    multi_bcast(m, &c->c2=2Eto_tun, m->pe=
nding, 0);
-                }
-                else /* possible client to c=
lient routing */
-                {
-                    ASSERT(!(mroute_fl=
ags & MROUTE_EXTRACT_BCAST));
-                    mi =3D multi_get_instanc=
e_by_virtual_addr(m, &dest, true);
-
-                    /* if dest addr i=
s a known client, route to it */
-                    if (mi)
-            =
        {
-                        {
-                            multi_uni=
cast(m, &c->c2=2Eto_tun, mi);
-                            register_activit=
y(c, BLEN(&c->c2=2Eto_tun));
-                        }
-                  =
      c->c2=2Eto_tun=2Elen =3D 0;
-                    }
-                }=

-            }
-        }
-        else if (TUNNEL_TYPE(m->top=2Ec1=2Etunt=
ap) =3D=3D DEV_TYPE_TAP)
-        {
-            uint16_t vid =3D 0;
-
-   =
         if (m->top=2Eoptions=2Evlan_tagging)
-            {
-             =
   if (vlan_is_tagged(&c->c2=2Eto_tun))
-                {
-               =
     /* Drop VLAN-tagged frame=2E */
-                    msg(D_VLAN_DEBUG,=
 "dropping incoming VLAN-tagged frame");
-                    c->c2=2Eto_tu=
n=2Elen =3D 0;
-                }
-                else
-                {
=
-                    vid =3D c->options=2Evlan_pvid;
-                }
-  =
          }
-            /* extract packet source and dest addresses */
-  =
          mroute_flags =3D
-                mroute_extract_addr_from_packet=
(&src, &dest, vid, &c->c2=2Eto_tun, DEV_TYPE_TAP);
-
-            if (mrout=
e_flags & MROUTE_EXTRACT_SUCCEEDED)
-            {
-                if (mul=
ti_learn_addr(m, m->pending, &src, 0) =3D=3D m->pending)
-                {=

-                    /* check for broadcast */
-                    if (m-=
>enable_c2c)
-                    {
-                        if (mroute_fla=
gs & (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))
-                      =
  {
-                            multi_bcast(m, &c->c2=2Eto_tun, m->pending=
, vid);
-                        }
-                        else /* try cli=
ent-to-client routing */
-                        {
-                      =
      mi =3D multi_get_instance_by_virtual_addr(m, &dest, false);
-
-      =
                      /* if dest addr is a known client, route to it */
-  =
                          if (mi)
-                            {
-         =
                       multi_unicast(m, &c->c2=2Eto_tun, mi);
-            =
                    register_activity(c, BLEN(&c->c2=2Eto_tun));
-         =
                       c->c2=2Eto_tun=2Elen =3D 0;
-                       =
     }
-                        }
-                    }
-                }=

-                else
-                {
-                    struct gc_ar=
ena gc =3D gc_new();
-                    msg(D_MULTI_DROPPED,
-           =
             "MULTI: bad source address from client [%s], packet dropped",
=
-                        mroute_addr_print(&src, &gc));
-                  =
  c->c2=2Eto_tun=2Elen =3D 0;
-                    gc_free(&gc);
-         =
       }
-            }
-            else
-            {
-                c=
->c2=2Eto_tun=2Elen =3D 0;
-            }
-        }
+        multi_process=
_incoming_link_data(m, floated, sock);
     }
 
     /* postprocess and set=
 wakeup */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
22?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9f10d91407=
347faf32397535c95e2d80a1575bd5
Gerrit-Change-Number: 1722
Gerrit-PatchSet: =
5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>

--qyjUSGDTbqc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1722?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Move incoming data processing in its own m=
ethod<br><br>This extract a large chunk from multi_process_incoming_link in=
to its<br>own method multi_process_incoming_link_data<br><br>This reduces t=
he complexity of multi_process_incoming_link further=2E<br><br>A few declar=
ations were moved into a more logical place but otherwise<br>this is just a=
 simple move=2E<br><br>Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5=
<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Fra=
nk Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1722<br>Message-Id: &lt;20260717141442=2E2294=
3-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg37674=2Ehtml<br>Signed-off-by: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/multi=2Ec=
<br>1 file changed, 150 insertions(+), 138 deletions(-)<br><br></pre>
<pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>in=
dex c4293a7=2E=2Efe2badb 100644</span><br><span>--- a/src/openvpn/multi=2Ec=
</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -3298,6 +32=
98,155 @@</span><br><span> }</span><br><span> #endif /* if defined(ENABLE_D=
CO) */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Process =
incoming data packet from clients=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * This tries to decrypt and then forward incoming</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * data packets=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+multi_process_incoming_link_data(struct multi_context *m, bool floate=
d, struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t link_socket_info *lsi =3D &amp;sock-&gt;info;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const uint8_t *orig_buf;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* decrypt in instance context */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;m-&gt;pe=
nding-&gt;context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    orig_buf =3D c-&=
gt;c2=2Ebuf=2Edata;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (process_incoming_link_part1(c, lsi, floated))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* nonzero length means that we have a valid, d=
ecrypted packed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (floated &amp;&amp; c-&gt;c2=2Ebuf=2Elen &gt; 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            multi_process_float(m, m-&gt;pendi=
ng, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        process_incoming_link_part2(c,=
 lsi, orig_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (TUNNEL_TYPE(m-&gt;top=2Ec1=
=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      struct mroute_addr src, dest;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* extract packet source and dest addresses */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int mro=
ute_flags =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      mroute_extract_addr_from_packet(&amp;src, &amp;dest, 0, &amp;c-&gt;c2=
=2Eto_tun, DEV_TYPE_TUN);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* dr=
op packet if extract failed */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (!(mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Eto_tun=2Ele=
n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* make sure =
that source address is associated with this client */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else if (multi_get_instance_by_vi=
rtual_addr(m, &amp;src, true) !=3D m-&gt;pending)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            /* IPv6 link-local address (fe80::xxx)? */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if ((src=
=2Etype &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                &amp;&amp; IN6_IS_ADDR_LINKLOCA=
L(&amp;src=2Ev6=2Eaddr))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               /* do nothing, for now=2E  TODO: add address learning */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       msg(D_MULTI_DROPPED,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    &quot;MULTI: bad source address from client [%s=
], packet dropped&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    mroute_addr_print(&amp;src, &amp;gc));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2E=
to_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 client-to-client communication enabled? */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else if (m-&gt;enable_c2c)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            /* multicast? */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (mroute_flags &amp; MR=
OUTE_EXTRACT_MCAST)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          /* for now, treat multicast as broadcast */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                multi_bcast(m, &amp;c-&gt=
;c2=2Eto_tun, m-&gt;pending, 0);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            else /* possible client to client routing */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                ASSERT(!(mroute_flags=
 &amp; MROUTE_EXTRACT_BCAST));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                struct multi_instance *mi =3D multi_get_instance=
_by_virtual_addr(m, &amp;dest, true);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               /* if dest addr is a known client, route to it */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                if (mi)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        mu=
lti_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        register_activity(c, BLEN(&=
amp;c-&gt;c2=2Eto_tun));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        uint16_t vid =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (m-&gt;top=2Eoptions=2Evlan_ta=
gging)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (vlan_is=
_tagged(&amp;c-&gt;c2=2Eto_tun))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                /* Drop VLAN-tagged frame=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                msg(D_VLAN_DEBUG, &quot;=
dropping incoming VLAN-tagged frame&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                c-&gt;c2=2Eto_tun=2Elen =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                vid =3D c-&gt;options=
=2Evlan_pvid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* extract pac=
ket source and dest addresses */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        struct mroute_addr src, dest;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* extract packet source and dest ad=
dresses */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        u=
nsigned int mroute_flags =3D</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            mroute_extract_addr_from_packet(&amp;src, &amp;dest, v=
id, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TAP);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (multi_learn_addr(m, m-&gt;pe=
nding, &amp;src, 0) =3D=3D m-&gt;pending)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                /* check for broadcast */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                if (m-&gt;enable_c2c)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    i=
f (mroute_flags &amp; (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, vid);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    else /* try c=
lient-to-client routing */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        struct multi_instance *mi =3D multi_get_in=
stance_by_virtual_addr(m, &amp;dest, false);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        /* if dest addr is a known client, route to i=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         if (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                            multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
          register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                            c-&gt=
;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                msg(D_MULTI_DROPPED,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    &quot;MULTI:=
 bad source address from client [%s], packet dropped&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    mroute_addr_pri=
nt(&amp;src, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> /*</span><br><span>  * Process packets in the TCP/UDP socket -&g=
t; TUN/TAP interface direction,</span><br><span>  * i=2Ee=2E client -&gt; s=
erver direction=2E</span><br><span>@@ -3307,9 +3456,6 @@</span><br><span>  =
                           const unsigned int mpp_flags, struct link_socket=
 *sock)</span><br><span> {</span><br><span>     struct context *c;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct mroute_addr src, de=
st;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int m=
route_flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t multi_instance *mi;</span><br><span>     bool ret =3D true;</span><br><sp=
an>     bool floated =3D false;</span><br><span> </span><br><span>@@ -3353,=
141 +3499,7 @@</span><br><span> </span><br><span>     if (BLEN(&amp;c-&gt;c=
2=2Ebuf) &gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct link_socket_info *lsi;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        const uint8_t *orig_buf;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        /* decrypt in instance context */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        lsi =3D &amp;sock-&gt;info;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        orig_buf =3D c-&gt;c2=2Ebuf=2E=
data;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (proc=
ess_incoming_link_part1(c, lsi, floated))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            /* nonzero length means that we have a valid, decrypted=
 packed */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (floated &amp;&amp; c-&gt;c2=2Ebuf=2Elen &gt; 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                multi_process_float(m, m-&gt;pendin=
g, sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            process_incoming_link_part2(c=
, lsi, orig_buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (TUNNEL_TYPE(m-&gt;top=2Ec=
1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           /* extract packet source and dest addresses */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            mroute_flags =3D</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                mroute_extract_a=
ddr_from_packet(&amp;src, &amp;dest, 0, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TU=
N);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            /* drop packet if extract f=
ailed */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
f (!(mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            /* make sure that source =
address is associated with this client */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            else if (multi_get_instance_by_virtual_addr=
(m, &amp;src, true) !=3D m-&gt;pending)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                /* IPv6 link-local address (fe80::xxx)? */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                if ((src=2Et=
ype &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    &amp;&amp; IN6_IS_ADDR_LINKLOCAL(=
&amp;src=2Ev6=2Eaddr))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 /* do nothing, for now=2E  TODO: add address learning */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   msg(D_MULTI_DROPPED,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        &quot;MULTI: bad source address f=
rom client [%s], packet dropped&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                        mroute_addr_print(&amp;src, &amp;g=
c));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            /* client-to-client communication enabled? */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (m-&gt;=
enable_c2c)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /*=
 multicast? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         if (mroute_flags &amp; MROUTE_EXTRACT_MCAST)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    /* for now, treat multicast=
 as broadcast */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, 0);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                else /* poss=
ible client to client routing */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    ASSERT(!(mroute_flags &amp; MROUTE_EXTRACT_BCAST=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  mi =3D multi_get_instance_by_virtual_addr(m, &amp;dest, true);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    /* if dest addr is a known client=
, route to it */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               if (mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                            multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, m=
i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
          register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        c-&gt;c=
2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (TUNNE=
L_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            uint16_t vid =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (m-&gt;top=2Eoptions=2Evlan_tagging)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                if (vlan_is_tagged(&amp;c-=
&gt;c2=2Eto_tun))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            /* Drop VLAN-tagged frame=2E */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    msg(D_VLAN_DEBUG, &quot;dropping =
incoming VLAN-tagged frame&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    vid =3D c-&gt;options=
=2Evlan_pvid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* extra=
ct packet source and dest addresses */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            mroute_flags =3D</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                mroute_extract_addr_from_packet(&am=
p;src, &amp;dest, vid, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TAP);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            if (mroute_flags &amp; MROUTE_EXTRACT_SUCCEE=
DED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (multi=
_learn_addr(m, m-&gt;pending, &amp;src, 0) =3D=3D m-&gt;pending)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    /* check for bro=
adcast */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        if (m-&gt;enable_c2c)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                        if (mroute_flags &amp; (MROUTE_EXTRACT_BCAS=
T | MROUTE_EXTRACT_MCAST))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                            multi_bcast(m, &amp;c-&gt;c2=2Eto_tun,=
 m-&gt;pending, vid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        else /* try client-to-client routing */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
   mi =3D multi_get_instance_by_virtual_addr(m, &amp;dest, false);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                            /* if dest addr is a kn=
own client, route to it */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                            if (mi)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                            {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                multi_unicast(m,=
 &amp;c-&gt;c2=2Eto_tun, mi);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                register_activity(c, BLEN(&amp;c-&g=
t;c2=2Eto_tun));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                           c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                            }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               msg(D_MULTI_DROPPED,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                        &quot;MULTI: bad source address from =
client [%s], packet dropped&quot;,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        mroute_addr_print(&amp;src, &amp;gc));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    c=
-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            else</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        multi_process_incoming_link_data(m, floated, sock);</span><br=
><span>     }</span><br><span> </span><br><span>     /* postprocess and set=
 wakeup */</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail">change 1722</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9f10d9140=
7347faf32397535c95e2d80a1575bd5 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1722 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 =
</div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>

</body></html>
--qyjUSGDTbqc=--


--===============8628431830249444113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8628431830249444113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8628431830249444113==--

