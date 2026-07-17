Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C874C4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ju1kK+/0vJUEF/gda0ZzzXE5BZkynDzEbjQZS2FSPqE=; b=BxEXFeut5E9mPZHa20dC33Wp/9
	N0+3+MxZuWyeyLsV+WyR8qqatnpmwoXCdrsesrgv6E5kwhwR0+oRQ3q1ugSiVpcmwAuO8HOujuR3A
	0EAeHmhC+GN3KQfYEGzQV/FEQ+QNvxsjXNvZL8TQ8hrP2cGh7RnVRDBRjzzEARurrGzQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkmum-0002xn-Uj;
	Fri, 17 Jul 2026 18:04:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkmul-0002xZ-7B
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 18:04:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=S5NDDU4xBLETFZKhEmlPRpwAmgWWkrVSxLJaMSWPQOQ=; b=Kc3CygGQCA9RanuuzaQj6OKiKY
 ZJ0uedacIFLo+v3vWOrRQvURgB6t1MOvE7yAIi5Ob/+pNOfAvGckdc7g4dEO/zM9h0vWoS620kaHL
 UYvAH4ymiXs3TbEO799XHNeRavS+pPJXUdXt7lQsK9B3dW2DommnIbOi/WyiXQ+XuI1E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=S5NDDU4xBLETFZKhEmlPRpwAmgWWkrVSxLJaMSWPQOQ=; b=H
 BFWYIGgMNT1lBu1hVC8xfPKzfOQ+saE0ZDboBEjfsuRAIcyPKExLyXl3fl8ZWAplBuqC39lW/E2LI
 x3UBkx4vOxWSOVXCDXAGDdzoXaSpakT0QNTM6AX0ESKTjdgCgjRBSeJYqmz758aoBspnIx/GCuCtF
 vSHHNTPCN7FERWso=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkmuk-0007Lq-8A for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 18:03:59 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so57549965e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784311427; x=1784916227; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S5NDDU4xBLETFZKhEmlPRpwAmgWWkrVSxLJaMSWPQOQ=;
 b=OdcASmO18aRN2rPvowDvG9bddaOithsuG/UvsOgaKYtlEXKm2RuerfLZJMVDSau2U+
 VVpVWW1qAY5PWxUo6EbN8AGd1ZrAPfA87U3Kc/+xhzXA4s5fkfr0+iRRNvFCz3nBzybJ
 iNlvPeWY4GEYzy8lq3DlIVlppBL72LuekXWj5iC4Rz+QUsDQ3nPtaej3JxtmRiFMUNJc
 TZ0udSLf1uQrF5hpEZi1sXqZBIjpL8Tb4qQnV59ZDAP4tjlp9/Y3Nt1PUB4MCD+HZHZz
 FhHKY1Gbyo5FFP2e/6pjMV1WPQ7Xk6usT5pLaCSS0t3DuV0aikC8NNFJj0hXm5+aef6g
 5HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784311427; x=1784916227;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=S5NDDU4xBLETFZKhEmlPRpwAmgWWkrVSxLJaMSWPQOQ=;
 b=YzRsW4osqxGU2VgT0/FXVFCamw5yo+0CgtrMitGflc3+kaQ3p0qvLXd4UDqWV+Brhh
 Il8y1hIEHH3bXtBfsudpKXfPhb8ATc6TF0cH0pIu/p/RW/lJA/E5trcCzAC18XEvpHC5
 Hjmf5iEx5ph10SaPcvEcZnRBRv6W36Ioasc4UEIz6Klrjy0yFq+18hMp0RsgQYqrEZw2
 uJFwcNEh9m8bbD+lPRNBctopN96jlV20E2IMavI3ZTgIGgDxqPQ2tfXkUt9d+1bBzwB/
 F3eQWsEqo6KyjD4YzfwtRbBSdA6KZwBKFj2rGw+ha9RroGDy3NVpsMf6fc8hokFnyWXX
 L46g==
X-Gm-Message-State: AOJu0YyC+6UNXNMWuPz1yUf45Q36lyPHADFTJnr3qwcR/yDV4KxVnWVV
 V2iRPEC6zYvsdGrCTuQA9sHuJ4dFm0gMW9KIIescc+sH7J4Jc5eZoiHSoOWaEe7xLSfw6Xpd/Ml
 f4ZL4Y2kEhqxTw0nqjlkqAnuhXqXJm5ZtB80+wyHEsF3Ca94srpiK4+0iAP/1S8Wy9yR4
X-Gm-Gg: AfdE7ckI9GC0hiCoq6EeC8re+JV00RoJLyaAAbJiszrz/QpD8eK4pj+PcpAe9nr2GJN
 7LzkNTP7unU6pMxCcdMNmlGRlRaen57s1OTpJ2zqhKsDe8Na9LVrXomKWRiPGtiaDw9w/LoryAz
 oC9yqV+OSwumXi7xTZ3/BwY9BdsyDgNDzdCYAmfJ55TisoC64kVJ4up4JOnURHT9rHTCykknH3e
 TpIkliWk+evL2g8RxqFiG6o6ncXrXDGdyw5tz1nVkOgfAGDTOjaLyIGsqwt4R4Yu8nsKpquxLiw
 lA4ePur+ud2Pcil4JA+HJpE6phcZGainAvrEfDFFz5P0Y8uq30wjW5uLtjWPWNkw3GJ35/B4ksF
 vUXXBaPpHUp1svY+NzvPrujP6prOE9GZu6DYvPG/o0rkYE9sSLKU6l0w4Kw7arZMsEogrqpHWQ8
 GPSLshvaOW+hBF8dncK8tEfskwXZA1UXVTsjcSqbDlYUznBjpTXI/kts3+8Z76apC8LNF/NRZW5
 G7wB5MTUpU8k9rN99BCNo6CBeJy2WhZNfadc3a1YUPXqnjmXlusXgx+is+Tl8ePfrd0
X-Received: by 2002:a05:600c:4fce:b0:493:fa66:4861 with SMTP id
 5b1f17b1804b1-4954a404bc2mr48005245e9.25.1784311426408; 
 Fri, 17 Jul 2026 11:03:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954c841a0dsm36664125e9.5.2026.07.17.11.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 11:03:45 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 18:03:44 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
X-Gerrit-Change-Number: 1722
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1722?usp=email>
X-Gerrit-Commit: 27a39d7c0b2ca7f9fc8b7dae0ea3570369f6ae25
In-Reply-To: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
References: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk5ZjEwZDkxNDA3MzQ3ZmFmMzIzOTc1MzVjOTVlMmQ4MGExNTc1YmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c959f9430033473450b2d4607202b1f3306c0ada-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkmuk-0007Lq-8A
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
Content-Type: multipart/mixed; boundary="===============4521820672555775740=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4521820672555775740==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="29Ru+In723A="; charset=UTF-8

--29Ru+In723A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: Move incoming data processing in its own met=
hod
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move in=
coming data processing in its own method

This extract a large chunk from m=
ulti_process_incoming_link into its
own method multi_process_incoming_link_=
data

This reduces the complexity of multi_process_incoming_link further=2E=


A few declarations were moved into a more logical place but otherwise
thi=
s is just a simple move=2E

Change-Id: I9f10d91407347faf32397535c95e2d80a15=
75bd5
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1722
Message-Id: <20260717141442=2E22943-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg37674=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/multi=2Ec
1 file changed, 150 insertions(+), 138 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/22/1722/5

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec=

index c4293a7=2E=2Efe2badb 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/op=
envpn/multi=2Ec
@@ -3298,6 +3298,155 @@
 }
 #endif /* if defined(ENABLE_DCO=
) */
 
+/**
+ * Process incoming data packet from clients=2E
+ *
+ * This t=
ries to decrypt and then forward incoming
+ * data packets=2E
+ */
+static =
void
+multi_process_incoming_link_data(struct multi_context *m, bool floate=
d, struct link_socket *sock)
+{
+    struct link_socket_info *lsi =3D &sock=
->info;
+    const uint8_t *orig_buf;
+
+    /* decrypt in instance context=
 */
+    struct context *c =3D &m->pending->context;
+
+    orig_buf =3D c-=
>c2=2Ebuf=2Edata;
+    if (process_incoming_link_part1(c, lsi, floated))
+ =
   {
+        /* nonzero length means that we have a valid, decrypted packe=
d */
+        if (floated && c->c2=2Ebuf=2Elen > 0)
+        {
+           =
 multi_process_float(m, m->pending, sock);
+        }
+
+        process_in=
coming_link_part2(c, lsi, orig_buf);
+    }
+
+    if (TUNNEL_TYPE(m->top=
=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
+    {
+        struct mroute_addr src=
, dest;
+        /* extract packet source and dest addresses */
+        un=
signed int mroute_flags =3D
+            mroute_extract_addr_from_packet(&s=
rc, &dest, 0, &c->c2=2Eto_tun, DEV_TYPE_TUN);
+
+        /* drop packet if =
extract failed */
+        if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
=
+        {
+            c->c2=2Eto_tun=2Elen =3D 0;
+        }
+        /* =
make sure that source address is associated with this client */
+        el=
se if (multi_get_instance_by_virtual_addr(m, &src, true) !=3D m->pending)
+=
        {
+            /* IPv6 link-local address (fe80::xxx)? */
+        =
    if ((src=2Etype & MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6
+                &&=
 IN6_IS_ADDR_LINKLOCAL(&src=2Ev6=2Eaddr))
+            {
+                /=
* do nothing, for now=2E  TODO: add address learning */
+            }
+   =
         else
+            {
+                struct gc_arena gc =3D gc_new=
();
+                msg(D_MULTI_DROPPED,
+                    "MULTI: bad =
source address from client [%s], packet dropped",
+                    mrou=
te_addr_print(&src, &gc));
+                gc_free(&gc);
+            }
+ =
           c->c2=2Eto_tun=2Elen =3D 0;
+        }
+        /* client-to-cli=
ent communication enabled? */
+        else if (m->enable_c2c)
+        {
+=
            /* multicast? */
+            if (mroute_flags & MROUTE_EXTRACT=
_MCAST)
+            {
+                /* for now, treat multicast as broa=
dcast */
+                multi_bcast(m, &c->c2=2Eto_tun, m->pending, 0);
+=
            }
+            else /* possible client to client routing */
+  =
          {
+                ASSERT(!(mroute_flags & MROUTE_EXTRACT_BCAST))=
;
+                struct multi_instance *mi =3D multi_get_instance_by_virt=
ual_addr(m, &dest, true);
+
+                /* if dest addr is a known cli=
ent, route to it */
+                if (mi)
+                {
+          =
          {
+                        multi_unicast(m, &c->c2=2Eto_tun, mi);=

+                        register_activity(c, BLEN(&c->c2=2Eto_tun));
+   =
                 }
+                    c->c2=2Eto_tun=2Elen =3D 0;
+      =
          }
+            }
+        }
+    }
+    else if (TUNNEL_TYPE(m->t=
op=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)
+    {
+        uint16_t vid =3D 0;
=
+
+        if (m->top=2Eoptions=2Evlan_tagging)
+        {
+            if =
(vlan_is_tagged(&c->c2=2Eto_tun))
+            {
+                /* Drop V=
LAN-tagged frame=2E */
+                msg(D_VLAN_DEBUG, "dropping incomin=
g VLAN-tagged frame");
+                c->c2=2Eto_tun=2Elen =3D 0;
+      =
      }
+            else
+            {
+                vid =3D c->option=
s=2Evlan_pvid;
+            }
+        }
+        /* extract packet source =
and dest addresses */
+        struct mroute_addr src, dest;
+        /* ex=
tract packet source and dest addresses */
+        unsigned int mroute_flag=
s =3D
+            mroute_extract_addr_from_packet(&src, &dest, vid, &c->c2=
=2Eto_tun, DEV_TYPE_TAP);
+
+        if (mroute_flags & MROUTE_EXTRACT_SUCC=
EEDED)
+        {
+            if (multi_learn_addr(m, m->pending, &src, 0)=
 =3D=3D m->pending)
+            {
+                /* check for broadcast =
*/
+                if (m->enable_c2c)
+                {
+                =
    if (mroute_flags & (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))
+    =
                {
+                        multi_bcast(m, &c->c2=2Eto_tun, =
m->pending, vid);
+                    }
+                    else /* try c=
lient-to-client routing */
+                    {
+                        =
struct multi_instance *mi =3D multi_get_instance_by_virtual_addr(m, &dest, =
false);
+
+                        /* if dest addr is a known client, route=
 to it */
+                        if (mi)
+                        {
+    =
                        multi_unicast(m, &c->c2=2Eto_tun, mi);
+           =
                 register_activity(c, BLEN(&c->c2=2Eto_tun));
+            =
                c->c2=2Eto_tun=2Elen =3D 0;
+                        }
+   =
                 }
+                }
+            }
+            else
+   =
         {
+                struct gc_arena gc =3D gc_new();
+             =
   msg(D_MULTI_DROPPED,
+                    "MULTI: bad source address fro=
m client [%s], packet dropped",
+                    mroute_addr_print(&src=
, &gc));
+                c->c2=2Eto_tun=2Elen =3D 0;
+                gc_f=
ree(&gc);
+            }
+        }
+        else
+        {
+            c=
->c2=2Eto_tun=2Elen =3D 0;
+        }
+    }
+}
+
 /*
  * Process packets i=
n the TCP/UDP socket -> TUN/TAP interface direction,
  * i=2Ee=2E client ->=
 server direction=2E
@@ -3307,9 +3456,6 @@
                             con=
st unsigned int mpp_flags, struct link_socket *sock)
 {
     struct context=
 *c;
-    struct mroute_addr src, dest;
-    unsigned int mroute_flags;
-  =
  struct multi_instance *mi;
     bool ret =3D true;
     bool floated =3D =
false;
 
@@ -3353,141 +3499,7 @@
 
     if (BLEN(&c->c2=2Ebuf) > 0)
     {
=
-        struct link_socket_info *lsi;
-        const uint8_t *orig_buf;
-
=
-        /* decrypt in instance context */
-
-        lsi =3D &sock->info;
=
-        orig_buf =3D c->c2=2Ebuf=2Edata;
-        if (process_incoming_lin=
k_part1(c, lsi, floated))
-        {
-            /* nonzero length means t=
hat we have a valid, decrypted packed */
-            if (floated && c->c2=
=2Ebuf=2Elen > 0)
-            {
-                multi_process_float(m, m-=
>pending, sock);
-            }
-
-            process_incoming_link_part2(=
c, lsi, orig_buf);
-        }
-
-        if (TUNNEL_TYPE(m->top=2Ec1=2Etunt=
ap) =3D=3D DEV_TYPE_TUN)
-        {
-            /* extract packet source a=
nd dest addresses */
-            mroute_flags =3D
-                mroute_=
extract_addr_from_packet(&src, &dest, 0, &c->c2=2Eto_tun, DEV_TYPE_TUN);
-
=
-            /* drop packet if extract failed */
-            if (!(mroute_=
flags & MROUTE_EXTRACT_SUCCEEDED))
-            {
-                c->c2=2E=
to_tun=2Elen =3D 0;
-            }
-            /* make sure that source ad=
dress is associated with this client */
-            else if (multi_get_ins=
tance_by_virtual_addr(m, &src, true) !=3D m->pending)
-            {
-     =
           /* IPv6 link-local address (fe80::xxx)? */
-                if (=
(src=2Etype & MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6
-                    && IN6=
_IS_ADDR_LINKLOCAL(&src=2Ev6=2Eaddr))
-                {
-                 =
   /* do nothing, for now=2E  TODO: add address learning */
-              =
  }
-                else
-                {
-                    struct gc=
_arena gc =3D gc_new();
-                    msg(D_MULTI_DROPPED,
-        =
                "MULTI: bad source address from client [%s], packet dropped=
",
-                        mroute_addr_print(&src, &gc));
-               =
     gc_free(&gc);
-                }
-                c->c2=2Eto_tun=2Elen=
 =3D 0;
-            }
-            /* client-to-client communication enabl=
ed? */
-            else if (m->enable_c2c)
-            {
-               =
 /* multicast? */
-                if (mroute_flags & MROUTE_EXTRACT_MCAST)=

-                {
-                    /* for now, treat multicast as bro=
adcast */
-                    multi_bcast(m, &c->c2=2Eto_tun, m->pending, =
0);
-                }
-                else /* possible client to client r=
outing */
-                {
-                    ASSERT(!(mroute_flags & M=
ROUTE_EXTRACT_BCAST));
-                    mi =3D multi_get_instance_by_vi=
rtual_addr(m, &dest, true);
-
-                    /* if dest addr is a kno=
wn client, route to it */
-                    if (mi)
-                   =
 {
-                        {
-                            multi_unicast(m,=
 &c->c2=2Eto_tun, mi);
-                            register_activity(c, BL=
EN(&c->c2=2Eto_tun));
-                        }
-                        c=
->c2=2Eto_tun=2Elen =3D 0;
-                    }
-                }
-     =
       }
-        }
-        else if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=
=3D DEV_TYPE_TAP)
-        {
-            uint16_t vid =3D 0;
-
-          =
  if (m->top=2Eoptions=2Evlan_tagging)
-            {
-                if (=
vlan_is_tagged(&c->c2=2Eto_tun))
-                {
-                    /*=
 Drop VLAN-tagged frame=2E */
-                    msg(D_VLAN_DEBUG, "dropp=
ing incoming VLAN-tagged frame");
-                    c->c2=2Eto_tun=2Elen=
 =3D 0;
-                }
-                else
-                {
-      =
              vid =3D c->options=2Evlan_pvid;
-                }
-         =
   }
-            /* extract packet source and dest addresses */
-         =
   mroute_flags =3D
-                mroute_extract_addr_from_packet(&src, =
&dest, vid, &c->c2=2Eto_tun, DEV_TYPE_TAP);
-
-            if (mroute_flags=
 & MROUTE_EXTRACT_SUCCEEDED)
-            {
-                if (multi_lear=
n_addr(m, m->pending, &src, 0) =3D=3D m->pending)
-                {
-     =
               /* check for broadcast */
-                    if (m->enable=
_c2c)
-                    {
-                        if (mroute_flags & (M=
ROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))
-                        {
-  =
                          multi_bcast(m, &c->c2=2Eto_tun, m->pending, vid);=

-                        }
-                        else /* try client-to-=
client routing */
-                        {
-                            m=
i =3D multi_get_instance_by_virtual_addr(m, &dest, false);
-
-             =
               /* if dest addr is a known client, route to it */
-         =
                   if (mi)
-                            {
-                =
                multi_unicast(m, &c->c2=2Eto_tun, mi);
-                   =
             register_activity(c, BLEN(&c->c2=2Eto_tun));
-                =
                c->c2=2Eto_tun=2Elen =3D 0;
-                            }
=
-                        }
-                    }
-                }
-     =
           else
-                {
-                    struct gc_arena gc =
=3D gc_new();
-                    msg(D_MULTI_DROPPED,
-                  =
      "MULTI: bad source address from client [%s], packet dropped",
-      =
                  mroute_addr_print(&src, &gc));
-                    c->c2=
=2Eto_tun=2Elen =3D 0;
-                    gc_free(&gc);
-                =
}
-            }
-            else
-            {
-                c->c2=2E=
to_tun=2Elen =3D 0;
-            }
-        }
+        multi_process_incomi=
ng_link_data(m, floated, sock);
     }
 
     /* postprocess and set wakeup=
 */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9f10d914073=
47faf32397535c95e2d80a1575bd5
Gerrit-Change-Number: 1722
Gerrit-PatchSet: 5=

Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>

--29Ru+In723A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Move incoming data p=
rocessing in its own method<br><br>This extract a large chunk from multi_pr=
ocess_incoming_link into its<br>own method multi_process_incoming_link_data=
<br><br>This reduces the complexity of multi_process_incoming_link further=
=2E<br><br>A few declarations were moved into a more logical place but othe=
rwise<br>this is just a simple move=2E<br><br>Change-Id: I9f10d91407347faf3=
2397535c95e2d80a1575bd5<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1722<br>Message-Id: &l=
t;20260717141442=2E22943-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37674=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/multi=2Ec<br>1 file changed, 150 insertions(+), 138 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/22/1722/5</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec =
b/src/openvpn/multi=2Ec</span><br><span>index c4293a7=2E=2Efe2badb 100644</=
span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvp=
n/multi=2Ec</span><br><span>@@ -3298,6 +3298,155 @@</span><br><span> }</spa=
n><br><span> #endif /* if defined(ENABLE_DCO) */</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Process incoming data packet from clients=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * This tries to decrypt and then=
 forward incoming</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 data packets=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+multi_process_incoming_link=
_data(struct multi_context *m, bool floated, struct link_socket *sock)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_info *lsi =3D &amp=
;sock-&gt;info;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const uint8_t *orig_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* decrypt=
 in instance context */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct context *c =3D &amp;m-&gt;pending-&gt;context;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    orig_buf =3D c-&gt;c2=2Ebuf=2Edata;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (process_incoming_link_pa=
rt1(c, lsi, floated))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* n=
onzero length means that we have a valid, decrypted packed */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (floated &amp;&amp; c-=
&gt;c2=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         multi_process_float(m, m-&gt;pending, sock);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        process_incoming_link_part2(c, lsi, orig_buf);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        struct mroute_addr src, dest=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* extract=
 packet source and dest addresses */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        unsigned int mroute_flags =3D</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            mroute_extract_addr_from_pac=
ket(&amp;src, &amp;dest, 0, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TUN);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* drop packet if extract failed */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(mroute_fl=
ags &amp; MROUTE_EXTRACT_SUCCEEDED))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* make sure that source address is associated =
with this client */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        else if (multi_get_instance_by_virtual_addr(m, &amp;src, true) !=3D=
 m-&gt;pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*=
 IPv6 link-local address (fe80::xxx)? */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if ((src=2Etype &amp; MR_ADDR_MASK) =3D=3D=
 MR_ADDR_IPV6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          &amp;&amp; IN6_IS_ADDR_LINKLOCAL(&amp;src=2Ev6=2Eaddr))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                /* do nothing, for =
now=2E  TODO: add address learning */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(D_MULTI_DROPPED,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quo=
t;MULTI: bad source address from client [%s], packet dropped&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    mroute_=
addr_print(&amp;src, &amp;gc));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* client-to-client communication=
 enabled? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else if (m-&gt;enable_c2c)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          /* multicast? */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (mroute_flags &amp; MROUTE_EXTRACT_MCAST)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                /* for now, treat mul=
ticast as broadcast */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, 0)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            else /* poss=
ible client to client routing */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                ASSERT(!(mroute_flags &amp; MROUTE_EXTRACT_BCAST));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                stru=
ct multi_instance *mi =3D multi_get_instance_by_virtual_addr(m, &amp;dest, =
true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                /* if dest addr =
is a known client, route to it */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                if (mi)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        multi_unicast(m, &amp;c-&gt;c2=2E=
to_tun, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    c-&g=
t;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (TUNNEL_TYPE(=
m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        uint16_t vid =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (m-&gt;top=2Eoptions=2Evlan_tagging)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (vlan_is_tagged(&amp;c-&gt;c2=2Eto_tun))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                /* Drop VL=
AN-tagged frame=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                msg(D_VLAN_DEBUG, &quot;dropping incoming VLAN-tagged fra=
me&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                vid =3D c-&gt;options=2Evlan_pvid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /* extract packet source and dest addresses */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct mroute_=
addr src, dest;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* extract packet source and dest addresses */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        unsigned int mroute_flags =3D</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            mroute_extract=
_addr_from_packet(&amp;src, &amp;dest, vid, &amp;c-&gt;c2=2Eto_tun, DEV_TYP=
E_TAP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (mroute_flags &amp; =
MROUTE_EXTRACT_SUCCEEDED)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (multi_learn_addr(m, m-&gt;pending, &amp;src, 0) =3D=3D m-&gt;pe=
nding)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* =
check for broadcast */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                if (m-&gt;enable_c2c)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    if (mroute_flags &amp; (MROUTE_EXTRA=
CT_BCAST | MROUTE_EXTRACT_MCAST))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        multi_bcast(m, &amp;c-&gt;c2=2Eto_t=
un, m-&gt;pending, vid);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    else /* try client-to-client routing */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        st=
ruct multi_instance *mi =3D multi_get_instance_by_virtual_addr(m, &amp;dest=
, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                        /* if=
 dest addr is a known client, route to it */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        if (mi)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                            mult=
i_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                            register_activity(c, BLEN=
(&amp;c-&gt;c2=2Eto_tun));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                            c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       msg(D_MULTI_DROPPED,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    &quot;MULTI: bad source address from client [%s=
], packet dropped&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    mroute_addr_print(&amp;src, &amp;gc));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2=2Eto_t=
un=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2E=
to_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
Process packets in the TCP/UDP socket -&gt; TUN/TAP interface direction,</s=
pan><br><span>  * i=2Ee=2E client -&gt; server direction=2E</span><br><span=
>@@ -3307,9 +3456,6 @@</span><br><span>                             const u=
nsigned int mpp_flags, struct link_socket *sock)</span><br><span> {</span><=
br><span>     struct context *c;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct mroute_addr src, dest;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    unsigned int mroute_flags;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi;</span><br><s=
pan>     bool ret =3D true;</span><br><span>     bool floated =3D false;</s=
pan><br><span> </span><br><span>@@ -3353,141 +3499,7 @@</span><br><span> </=
span><br><span>     if (BLEN(&amp;c-&gt;c2=2Ebuf) &gt; 0)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct l=
ink_socket_info *lsi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        const uint8_t *orig_buf;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*=
 decrypt in instance context */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        lsi=
 =3D &amp;sock-&gt;info;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        orig_buf =3D c-&gt;c2=2Ebuf=2Edata;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (process_incoming_link_part1(c, lsi, fl=
oated))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* nonzero len=
gth means that we have a valid, decrypted packed */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (floated &amp;&amp; c-&gt;c2=
=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       multi_process_float(m, m-&gt;pending, sock);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            process_incoming_link_part2(c, lsi, orig_buf);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            /* extract packet so=
urce and dest addresses */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            mroute_flags =3D</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                mroute_extract_addr_from_packet(&amp;src, &amp;=
dest, 0, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TUN);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            /* drop packet if extract failed */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (!(mroute_flags &amp; MROUTE=
_EXTRACT_SUCCEEDED))</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            /* make sure that source address is associated with thi=
s client */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  else if (multi_get_instance_by_virtual_addr(m, &amp;src, true) !=3D m-&gt=
;pending)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* I=
Pv6 link-local address (fe80::xxx)? */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                if ((src=2Etype &amp; MR_ADDR_MASK) =3D=3D=
 MR_ADDR_IPV6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            &amp;&amp; IN6_IS_ADDR_LINKLOCAL(&amp;src=2Ev6=2Eaddr))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    /* do nothing=
, for now=2E  TODO: add address learning */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                else</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    struct gc_arena gc =3D gc_new();</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    msg(D_MULTI=
_DROPPED,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
            &quot;MULTI: bad source address from client [%s], packet droppe=
d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           mroute_addr_print(&amp;src, &amp;gc));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                c-&gt;c2=2Eto_tun=
=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* c=
lient-to-client communication enabled? */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            else if (m-&gt;enable_c2c)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                /* multicast? */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                if (mroute_flags &a=
mp; MROUTE_EXTRACT_MCAST)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    /* for now, treat multicast as broadcast */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    multi_bcast(m=
, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, 0);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                else /* possible client to client routin=
g */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    A=
SSERT(!(mroute_flags &amp; MROUTE_EXTRACT_BCAST));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    mi =3D multi_get_instance_=
by_virtual_addr(m, &amp;dest, true);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              /* if dest addr is a known client, route to it */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    if (mi)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
     multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                            register_activity(=
c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        c-&gt;c2=2Eto_tun=2Elen =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        else if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etunt=
ap) =3D=3D DEV_TYPE_TAP)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   uint16_t vid =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (m-&g=
t;top=2Eoptions=2Evlan_tagging)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                if (vlan_is_tagged(&amp;c-&gt;c2=2Eto_tun))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    /* Drop VLAN-tagged=
 frame=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           msg(D_VLAN_DEBUG, &quot;dropping incoming VLAN-tagged frame&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                else</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    vid =3D c-&gt;options=2Evlan_pvid;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            /* extract packet source and dest addre=
sses */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mr=
oute_flags =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         mroute_extract_addr_from_packet(&amp;src, &amp;dest, vid, &amp;c-&=
gt;c2=2Eto_tun, DEV_TYPE_TAP);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
if (mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                if (multi_learn_addr(m, m-&gt;pending, &=
amp;src, 0) =3D=3D m-&gt;pending)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    /* check for broadcast */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    if (m-&gt;enable_c2c)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 if (mroute_flags &amp; (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
      multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, vid);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                        els=
e /* try client-to-client routing */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                        {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                            mi =3D multi_get_instance_by=
_virtual_addr(m, &amp;dest, false);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                     /* if dest addr is a known client, route to it */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
  if (mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                            multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
         register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                c-&g=
t;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                            }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                else</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    struct gc_arena gc =3D gc_new();</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    msg(D_MULTI_DROP=
PED,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
       &quot;MULTI: bad source address from client [%s], packet dropped&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      mroute_addr_print(&amp;src, &amp;gc));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    c-&gt;c2=2Eto_tun=2Elen =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                c-&gt;c2=2Eto_tu=
n=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_process_inc=
oming_link_data(m, floated, sock);</span><br><span>     }</span><br><span> =
</span><br><span>     /* postprocess and set wakeup */</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1722?usp=3Demail">change 1722</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1722?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1=
575bd5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1722 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--29Ru+In723A=--


--===============4521820672555775740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4521820672555775740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4521820672555775740==--

