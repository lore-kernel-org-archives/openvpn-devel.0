Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0501CDB470
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Bd2lXI58ykhFauolbHc/5B3nE6ztVO2yzSxHE1shYxM=; b=GnZJOP8BE+eQC9
	cvlSZtFXe62ryH22RFCW6WNTq/PzfuiSj+meeMr58LZOuFkcvVKxAbpM96PjeOQN/EoAWcC3kMrsW
	BS2rrS9AptOJWATSg7OocVzQ5dEvtLwkHO7xpPz6piF8Y1EDxAXjSBh/ieG8enRH0EErLYNVPGL0X
	6eE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbecx-0001X3-L0;
	Mon, 22 Jun 2026 13:23:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbecv-0001Wt-JL
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aXeLQMWev/rQKbBmaoQinkNaMi8QzK2IKc1Lh4YeDWQ=; b=OdQlpwmte9miX81W8BvTM8vSdj
 UdCu3G9Vwue9feFoVGTrBVxLylK/COjE0SUMTO2BUhzoNmdYB4sbhvlChctpptQL7jHybfdyYTVFC
 i7+sqH++llPgolkpO1bDXtakrJl1F1vpsbebqzpm1TW7AZJsnui5NomernqJMdXk372A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aXeLQMWev/rQKbBmaoQinkNaMi8QzK2IKc1Lh4YeDWQ=; b=O
 g63BvmM3gWfCLTizA+uOGaydKtmSBms/3W5GmqyPDmdA9ka34h9CbU7F3EmffIH/EEJtM5EI02IuM
 HFJGtsYCF/eZvGljxaLLOd0KuEo3h6an1P60gJakXoTFrnslQ5zxnpVL3/KtbNYJEm19xl9xevTJf
 +mDissA1skmzQJiI=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbecq-0000a9-Ly for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:47 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4627adcf4d6so2816070f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134619; x=1782739419; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aXeLQMWev/rQKbBmaoQinkNaMi8QzK2IKc1Lh4YeDWQ=;
 b=JjMiAYMZg41vhurxFH5ZnfPF0WwTQ3u8pQ9/PhF92psX5dk6BbJsZS0L8PQAhYXdmV
 efKDZ94LEjMkther27+AkMnWP5NlSUJPktj022WBE8l84fkdMkDiXRUZyUmNHJFk3LyL
 DG8yyj1jXFsyaL+6S5im2PXdppNO6neeRW1Z5Zd3ZudfFwB4Zmus39S1K4a8Dzcnel3H
 wPdN+c7ztyk/6jyhGiGPXfPOEphHDGaJkG2DCqZ2a5ht5ND0mDaewFg5sdsqn6npYdSG
 d+bKN7+h8LEJ7Gv+3+6oSEmph0hSJrq5Lv+CoPgrkI3d/tcaymfwIwT4lTV4J9atG7vE
 MyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134619; x=1782739419;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aXeLQMWev/rQKbBmaoQinkNaMi8QzK2IKc1Lh4YeDWQ=;
 b=H1W/eA6Lt4Ogg0S8+eagnPQu6kWrRSc/kAQpzaI90X8tGVvontMJilbgU82njq5bXe
 zPFsL6FqYzwomuHD0ggq5gaaPG9TRHiA6cmn9IwZx49OFe41pPeIL0811hy7lCUT7aQo
 42J7gjM82TDuEcup76eU7k2sneBLdZvcbnLQaOe1cuqmMFVQkabgVqn2MNFdc4il3cUv
 CR0CYw+q+Bki923/ncMwGMmPjNbGIFk0fhsmMwCHHDPCoZmetvTlOTfcnk4MwHAAiEep
 P6BLYuUrXK/Zbz8PiAVQQ0C7o92w0AADOBVBj67KBGybYEiLG04I+IRXh2hJfTCMUXIL
 k/kw==
X-Gm-Message-State: AOJu0YxLLHpXsq6I3/RnqWOnxjRs3Hofih3zrEzHUJm1HoSG1PnBIOpQ
 D0lO9A6KrIQ9wkkBWL99jyWvAw8PQ6Ky6adAMIuZhmmWO8CXhzMK27g4Lo2YhoEGTsnz6CEDzfy
 qgqql6B9fTdk1JfT25ieRVGFILtlgnUDQY3XkJITynvTRwEfNOzSPPIixQC36UOkxRQvTScYdXC
 IuiiofBA==
X-Gm-Gg: AfdE7cnEDrSDUDjqVHiC0WWfLpt1UjJpNHpDtN3lsei8NWtjdNHLIR5kkgDm/PAG2RA
 GnYh/jFsU/FhryjxFuLCo3I57pdEc9x5YaVfmQ5Sws/7mcHLq4SwBoQj73f73JYnzf6TWYbxtVL
 Smk6ydi7tdBIly+rhANGbQKzLxh1qaqljk3aKhn79tOylU9fIdfjbJjwTCtvpH4k730HmGaEuiC
 aWc+nfWhG3Lw8UqvpFxckcy/swATFCfexmM+UwqzyFzi8HkANHwJFDJjNc2xIKPXTYwuIQgPTWQ
 QdONpNcJz+02U3GXWs4m0nM+etIBFNFNRtfGuOSLocc/CS/6AScl4vXK+DJLS4J8vf+aKkwMsVi
 K3Owlble3qNN4TjTdqfny+tQW+qRMVIfA6c22KUhwT/za/tk9lrZZUGI5Aw/JaF4OxiAGPabBoZ
 rqqam0IGyRCBGJ349IITYAIWfQZFSycDkL0KD+vZT6We1F307fTXqxsnZiXpmBxG4yk+x3ddZtn
 doW+1YJtH5JLVY8AwRlLOr7KnHbxx/cFUruQkYZr3ZxaxrqQ7dWOW2YwmS2XjdBfeHh/8/KCjKt
 jgg=
X-Received: by 2002:a5d:5246:0:b0:460:e4d:bd46 with SMTP id
 ffacd0b85a97d-465097867f3mr19134918f8f.21.1782134617290; 
 Mon, 22 Jun 2026 06:23:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c57b95sm23773546f8f.30.2026.06.22.06.23.36
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:23:36 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:23:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
X-Gerrit-Change-Number: 1722
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1722?usp=email>
X-Gerrit-Commit: fb66b7e90f6a20cf6cc399708e3ec9f8232411c3
References: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk5ZjEwZDkxNDA3MzQ3ZmFmMzIzOTc1MzVjOTVlMmQ4MGExNTc1YmQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b2f7ba1c3166c4e6167f83608e182b21c3866cdf-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbecq-0000a9-Ly
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8691104218797806573=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8691104218797806573==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2tSoCM0hgqg="; charset=UTF-8

--2tSoCM0hgqg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1722?usp=3Demail )


Change subject: Move incoming data =
processing in its own method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Move incoming data processing in its own method

This extr=
act a large chunk from multi_process_incoming_link into its
own method mult=
i_process_incoming_link_data

This reduces the complexity of multi_process_=
incoming_link further=2E

A few declarations were moved into a more logical=
 place but otherwise
this is just a simple move=2E

Change-Id: I9f10d914073=
47faf32397535c95e2d80a1575bd5
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eo=
rg>
---
M src/openvpn/multi=2Ec
1 file changed, 146 insertions(+), 138 dele=
tions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/22/1722/1

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
i=
ndex 7e2f0dd=2E=2Edd339dc 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/open=
vpn/multi=2Ec
@@ -3335,6 +3335,151 @@
 }
 #endif /* if defined(ENABLE_DCO) =
*/
 
+static void
+multi_process_incoming_link_data(struct multi_context *m=
, bool floated, struct link_socket *sock)
+{
+    struct link_socket_info *=
lsi;
+    const uint8_t *orig_buf;
+
+
+    /* decrypt in instance context =
*/
+    lsi =3D &sock->info;
+    struct context *c =3D &m->pending->contex=
t;
+
+    orig_buf =3D c->c2=2Ebuf=2Edata;
+    if (process_incoming_link_p=
art1(c, lsi, floated))
+    {
+        /* nonzero length means that we have=
 a valid, decrypted packed */
+        if (floated && c->c2=2Ebuf=2Elen > 0=
)
+        {
+            multi_process_float(m, m->pending, sock);
+      =
  }
+
+        process_incoming_link_part2(c, lsi, orig_buf);
+    }
+
+   =
 if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
+    {
+       =
 struct mroute_addr src, dest;
+        /* extract packet source and dest a=
ddresses */
+        unsigned int mroute_flags =3D
+            mroute_extr=
act_addr_from_packet(&src, &dest, 0, &c->c2=2Eto_tun, DEV_TYPE_TUN);
+
+   =
     /* drop packet if extract failed */
+        if (!(mroute_flags & MROU=
TE_EXTRACT_SUCCEEDED))
+        {
+            c->c2=2Eto_tun=2Elen =3D 0;
=
+        }
+        /* make sure that source address is associated with thi=
s client */
+        else if (multi_get_instance_by_virtual_addr(m, &src, t=
rue) !=3D m->pending)
+        {
+            /* IPv6 link-local address (f=
e80::xxx)? */
+            if ((src=2Etype & MR_ADDR_MASK) =3D=3D MR_ADDR_I=
PV6
+                && IN6_IS_ADDR_LINKLOCAL(&src=2Ev6=2Eaddr))
+         =
   {
+                /* do nothing, for now=2E  TODO: add address learning=
 */
+            }
+            else
+            {
+                struct=
 gc_arena gc =3D gc_new();
+                msg(D_MULTI_DROPPED,
+         =
           "MULTI: bad source address from client [%s], packet dropped",
+ =
                   mroute_addr_print(&src, &gc));
+                gc_free(=
&gc);
+            }
+            c->c2=2Eto_tun=2Elen =3D 0;
+        }
+ =
       /* client-to-client communication enabled? */
+        else if (m->e=
nable_c2c)
+        {
+            /* multicast? */
+            if (mroute=
_flags & MROUTE_EXTRACT_MCAST)
+            {
+                /* for now, =
treat multicast as broadcast */
+                multi_bcast(m, &c->c2=2Eto=
_tun, m->pending, 0);
+            }
+            else /* possible client t=
o client routing */
+            {
+                ASSERT(!(mroute_flags &=
 MROUTE_EXTRACT_BCAST));
+                struct multi_instance *mi =3D mul=
ti_get_instance_by_virtual_addr(m, &dest, true);
+
+                /* if d=
est addr is a known client, route to it */
+                if (mi)
+      =
          {
+                    {
+                        multi_unicast(m=
, &c->c2=2Eto_tun, mi);
+                        register_activity(c, BLEN(=
&c->c2=2Eto_tun));
+                    }
+                    c->c2=2Eto_t=
un=2Elen =3D 0;
+                }
+            }
+        }
+    }
+    el=
se if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)
+    {
+     =
   uint16_t vid =3D 0;
+
+        if (m->top=2Eoptions=2Evlan_tagging)
+   =
     {
+            if (vlan_is_tagged(&c->c2=2Eto_tun))
+            {
+  =
              /* Drop VLAN-tagged frame=2E */
+                msg(D_VLAN_D=
EBUG, "dropping incoming VLAN-tagged frame");
+                c->c2=2Eto_t=
un=2Elen =3D 0;
+            }
+            else
+            {
+          =
      vid =3D c->options=2Evlan_pvid;
+            }
+        }
+        /*=
 extract packet source and dest addresses */
+        struct mroute_addr sr=
c, dest;
+        /* extract packet source and dest addresses */
+        u=
nsigned int mroute_flags =3D
+            mroute_extract_addr_from_packet(&=
src, &dest, vid, &c->c2=2Eto_tun, DEV_TYPE_TAP);
+
+        if (mroute_flag=
s & MROUTE_EXTRACT_SUCCEEDED)
+        {
+            if (multi_learn_addr(=
m, m->pending, &src, 0) =3D=3D m->pending)
+            {
+                =
/* check for broadcast */
+                if (m->enable_c2c)
+            =
    {
+                    if (mroute_flags & (MROUTE_EXTRACT_BCAST | MROUT=
E_EXTRACT_MCAST))
+                    {
+                        multi_bca=
st(m, &c->c2=2Eto_tun, m->pending, vid);
+                    }
+          =
          else /* try client-to-client routing */
+                    {
+ =
                       struct multi_instance *mi =3D multi_get_instance_by_=
virtual_addr(m, &dest, false);
+
+                        /* if dest addr i=
s a known client, route to it */
+                        if (mi)
+        =
                {
+                            multi_unicast(m, &c->c2=2Eto=
_tun, mi);
+                            register_activity(c, BLEN(&c->c2=2E=
to_tun));
+                            c->c2=2Eto_tun=2Elen =3D 0;
+       =
                 }
+                    }
+                }
+            }=

+            else
+            {
+                struct gc_arena gc =3D g=
c_new();
+                msg(D_MULTI_DROPPED,
+                    "MULTI:=
 bad source address from client [%s], packet dropped",
+                   =
 mroute_addr_print(&src, &gc));
+                c->c2=2Eto_tun=2Elen =3D 0=
;
+                gc_free(&gc);
+            }
+        }
+        else
+ =
       {
+            c->c2=2Eto_tun=2Elen =3D 0;
+        }
+    }
+}
+
 /=
*
  * Process packets in the TCP/UDP socket -> TUN/TAP interface direction,=

  * i=2Ee=2E client -> server direction=2E
@@ -3344,9 +3489,6 @@
         =
                    const unsigned int mpp_flags, struct link_socket *sock)=

 {
     struct context *c;
-    struct mroute_addr src, dest;
-    unsigne=
d int mroute_flags;
-    struct multi_instance *mi;
     bool ret =3D true;=

     bool floated =3D false;
 
@@ -3390,141 +3532,7 @@
 
     if (BLEN(&c-=
>c2=2Ebuf) > 0)
     {
-        struct link_socket_info *lsi;
-        cons=
t uint8_t *orig_buf;
-
-        /* decrypt in instance context */
-
-      =
  lsi =3D &sock->info;
-        orig_buf =3D c->c2=2Ebuf=2Edata;
-        i=
f (process_incoming_link_part1(c, lsi, floated))
-        {
-            /*=
 nonzero length means that we have a valid, decrypted packed */
-          =
  if (floated && c->c2=2Ebuf=2Elen > 0)
-            {
-                mul=
ti_process_float(m, m->pending, sock);
-            }
-
-            proces=
s_incoming_link_part2(c, lsi, orig_buf);
-        }
-
-        if (TUNNEL_T=
YPE(m->top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
-        {
-            /* e=
xtract packet source and dest addresses */
-            mroute_flags =3D
- =
               mroute_extract_addr_from_packet(&src, &dest, 0, &c->c2=2Eto_=
tun, DEV_TYPE_TUN);
-
-            /* drop packet if extract failed */
-   =
         if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
-            {
-  =
              c->c2=2Eto_tun=2Elen =3D 0;
-            }
-            /* ma=
ke sure that source address is associated with this client */
-            =
else if (multi_get_instance_by_virtual_addr(m, &src, true) !=3D m->pending)=

-            {
-                /* IPv6 link-local address (fe80::xxx)? */=

-                if ((src=2Etype & MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6
-    =
                && IN6_IS_ADDR_LINKLOCAL(&src=2Ev6=2Eaddr))
-              =
  {
-                    /* do nothing, for now=2E  TODO: add address learn=
ing */
-                }
-                else
-                {
-       =
             struct gc_arena gc =3D gc_new();
-                    msg(D_MU=
LTI_DROPPED,
-                        "MULTI: bad source address from clien=
t [%s], packet dropped",
-                        mroute_addr_print(&src, &=
gc));
-                    gc_free(&gc);
-                }
-              =
  c->c2=2Eto_tun=2Elen =3D 0;
-            }
-            /* client-to-clie=
nt communication enabled? */
-            else if (m->enable_c2c)
-        =
    {
-                /* multicast? */
-                if (mroute_flags &=
 MROUTE_EXTRACT_MCAST)
-                {
-                    /* for now, =
treat multicast as broadcast */
-                    multi_bcast(m, &c->c2=
=2Eto_tun, m->pending, 0);
-                }
-                else /* poss=
ible client to client routing */
-                {
-                    AS=
SERT(!(mroute_flags & MROUTE_EXTRACT_BCAST));
-                    mi =3D m=
ulti_get_instance_by_virtual_addr(m, &dest, true);
-
-                    /=
* if dest addr is a known client, route to it */
-                    if (m=
i)
-                    {
-                        {
-                     =
       multi_unicast(m, &c->c2=2Eto_tun, mi);
-                            =
register_activity(c, BLEN(&c->c2=2Eto_tun));
-                        }
-  =
                      c->c2=2Eto_tun=2Elen =3D 0;
-                    }
- =
               }
-            }
-        }
-        else if (TUNNEL_TYPE(m-=
>top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)
-        {
-            uint16_t v=
id =3D 0;
-
-            if (m->top=2Eoptions=2Evlan_tagging)
-            =
{
-                if (vlan_is_tagged(&c->c2=2Eto_tun))
-                {
=
-                    /* Drop VLAN-tagged frame=2E */
-                    m=
sg(D_VLAN_DEBUG, "dropping incoming VLAN-tagged frame");
-                 =
   c->c2=2Eto_tun=2Elen =3D 0;
-                }
-                else
-  =
              {
-                    vid =3D c->options=2Evlan_pvid;
-     =
           }
-            }
-            /* extract packet source and dest =
addresses */
-            mroute_flags =3D
-                mroute_extract_=
addr_from_packet(&src, &dest, vid, &c->c2=2Eto_tun, DEV_TYPE_TAP);
-
-     =
       if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
-            {
-       =
         if (multi_learn_addr(m, m->pending, &src, 0) =3D=3D m->pending)
- =
               {
-                    /* check for broadcast */
-          =
          if (m->enable_c2c)
-                    {
-                      =
  if (mroute_flags & (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))
-      =
                  {
-                            multi_bcast(m, &c->c2=2Eto=
_tun, m->pending, vid);
-                        }
-                       =
 else /* try client-to-client routing */
-                        {
-      =
                      mi =3D multi_get_instance_by_virtual_addr(m, &dest, f=
alse);
-
-                            /* if dest addr is a known client, ro=
ute to it */
-                            if (mi)
-                        =
    {
-                                multi_unicast(m, &c->c2=2Eto_tun, mi=
);
-                                register_activity(c, BLEN(&c->c2=2Eto_t=
un));
-                                c->c2=2Eto_tun=2Elen =3D 0;
-       =
                     }
-                        }
-                    }
- =
               }
-                else
-                {
-                =
    struct gc_arena gc =3D gc_new();
-                    msg(D_MULTI_DROPP=
ED,
-                        "MULTI: bad source address from client [%s], p=
acket dropped",
-                        mroute_addr_print(&src, &gc));
-  =
                  c->c2=2Eto_tun=2Elen =3D 0;
-                    gc_free(=
&gc);
-                }
-            }
-            else
-            {
- =
               c->c2=2Eto_tun=2Elen =3D 0;
-            }
-        }
+     =
   multi_process_incoming_link_data(m, floated, sock);
     }
 
     /* pos=
tprocess and set wakeup */

-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1722?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
Gerrit-Change-Number: 172=
2
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--2tSoCM0hgqg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Move incoming data processing in its own method<br><br>This extrac=
t a large chunk from multi_process_incoming_link into its<br>own method mul=
ti_process_incoming_link_data<br><br>This reduces the complexity of multi_p=
rocess_incoming_link further=2E<br><br>A few declarations were moved into a=
 more logical place but otherwise<br>this is just a simple move=2E<br><br>C=
hange-Id: I9f10d91407347faf32397535c95e2d80a1575bd5<br>Signed-off-by: Arne =
Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 f=
ile changed, 146 insertions(+), 138 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/22/1722/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><=
br><span>index 7e2f0dd=2E=2Edd339dc 100644</span><br><span>--- a/src/openvp=
n/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ =
-3335,6 +3335,151 @@</span><br><span> }</span><br><span> #endif /* if defin=
ed(ENABLE_DCO) */</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+multi_process_incoming_link_data(struct multi_context *m, bool floa=
ted, struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct link_socket_info *lsi;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const uint8_t *orig_buf;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* decrypt in inst=
ance context */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
lsi =3D &amp;sock-&gt;info;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct context *c =3D &amp;m-&gt;pending-&gt;context;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    orig_buf =3D c-&gt;c2=2Ebuf=2Edata;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (process_incoming_lin=
k_part1(c, lsi, floated))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* nonzero length means that we have a valid, decrypted packed */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (floated &amp;&amp=
; c-&gt;c2=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            multi_process_float(m, m-&gt;pending, sock);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        process_incoming_link_part2(c, lsi, orig_buf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct mroute_addr src, =
dest;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* ext=
ract packet source and dest addresses */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        unsigned int mroute_flags =3D</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            mroute_extract_addr_from=
_packet(&amp;src, &amp;dest, 0, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TUN);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* drop packet if extract failed =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(mro=
ute_flags &amp; MROUTE_EXTRACT_SUCCEEDED))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* make sure that source address is assoc=
iated with this client */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        else if (multi_get_instance_by_virtual_addr(m, &amp;src, true=
) !=3D m-&gt;pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    /* IPv6 link-local address (fe80::xxx)? */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if ((src=2Etype &amp; MR_ADDR_MASK) =
=3D=3D MR_ADDR_IPV6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                &amp;&amp; IN6_IS_ADDR_LINKLOCAL(&amp;src=2Ev6=2Eaddr))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                /* do nothing=
, for now=2E  TODO: add address learning */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                msg(D_MULTI_DROPPED,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
&quot;MULTI: bad source address from client [%s], packet dropped&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mro=
ute_addr_print(&amp;src, &amp;gc));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* client-to-client communicat=
ion enabled? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    else if (m-&gt;enable_c2c)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* multicast? */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (mroute_flags &amp; MROUTE_EXTRACT_MCAST)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                /* for now, treat =
multicast as broadcast */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending,=
 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else /* p=
ossible client to client routing */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                ASSERT(!(mroute_flags &amp; MROUTE_EXTRACT_BCAST)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                s=
truct multi_instance *mi =3D multi_get_instance_by_virtual_addr(m, &amp;des=
t, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                /* if dest ad=
dr is a known client, route to it */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                if (mi)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        multi_unicast(m, &amp;c-&gt;c2=
=2Eto_tun, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    c=
-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (TUNNEL_TY=
PE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        uint16_t vid =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (m-&gt;top=2Eoptions=2Evlan_tagging)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (vlan_is_tagged(&amp;c-&gt;c2=2Eto_t=
un))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* Dr=
op VLAN-tagged frame=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                msg(D_VLAN_DEBUG, &quot;dropping incoming VLAN-tagge=
d frame&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                vid =3D c-&gt;options=2Evlan_pvid;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* extract packet source and dest addresses=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct m=
route_addr src, dest;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* extract packet source and dest addresses */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        unsigned int mroute_flags =3D<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mroute_e=
xtract_addr_from_packet(&amp;src, &amp;dest, vid, &amp;c-&gt;c2=2Eto_tun, D=
EV_TYPE_TAP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (mroute_flags =
&amp; MROUTE_EXTRACT_SUCCEEDED)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (multi_learn_addr(m, m-&gt;pending, &amp;src, 0) =3D=3D m-=
&gt;pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   /* check for broadcast */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                if (m-&gt;enable_c2c)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    if (mroute_flags &amp; (MROUTE=
_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        multi_bcast(m, &amp;c-&gt;c2=
=2Eto_tun, m-&gt;pending, vid);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    else /* try client-to-client routing */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     struct multi_instance *mi =3D multi_get_instance_by_virtual_addr(m, &a=
mp;dest, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  /* if dest addr is a known client, route to it */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        if (mi)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
     multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                            register_activit=
y(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                            c-&gt;c2=2Eto_tun=2Elen =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                msg(D_MULTI_DROPPED,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    &quot;MULTI: bad source address from c=
lient [%s], packet dropped&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    mroute_addr_print(&amp;src, &amp;gc));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                c-&gt;=
c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-=
&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><s=
pan>  * Process packets in the TCP/UDP socket -&gt; TUN/TAP interface direc=
tion,</span><br><span>  * i=2Ee=2E client -&gt; server direction=2E</span><=
br><span>@@ -3344,9 +3489,6 @@</span><br><span>                            =
 const unsigned int mpp_flags, struct link_socket *sock)</span><br><span> {=
</span><br><span>     struct context *c;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct mroute_addr src, dest;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    unsigned int mroute_flags;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi;</sp=
an><br><span>     bool ret =3D true;</span><br><span>     bool floated =3D =
false;</span><br><span> </span><br><span>@@ -3390,141 +3532,7 @@</span><br>=
<span> </span><br><span>     if (BLEN(&amp;c-&gt;c2=2Ebuf) &gt; 0)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 struct link_socket_info *lsi;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        const uint8_t *orig_buf;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       /* decrypt in instance context */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      lsi =3D &amp;sock-&gt;info;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        orig_buf =3D c-&gt;c2=2Ebuf=2Edata;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (process_incoming_link_part1(c=
, lsi, floated))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* no=
nzero length means that we have a valid, decrypted packed */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (floated &amp;&amp; c=
-&gt;c2=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              multi_process_float(m, m-&gt;pending, sock);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            process_incoming_link_part2(c, lsi, orig_buf);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYP=
E_TUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* extract pack=
et source and dest addresses */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            mroute_flags =3D</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                mroute_extract_addr_from_packet(&amp;src, =
&amp;dest, 0, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TUN);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            /* drop packet if extract failed */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (!(mroute_flags &amp; M=
ROUTE_EXTRACT_SUCCEEDED))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            /* make sure that source address is associated wit=
h this client */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       else if (multi_get_instance_by_virtual_addr(m, &amp;src, true) !=3D =
m-&gt;pending)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 /* IPv6 link-local address (fe80::xxx)? */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                if ((src=2Etype &amp; MR_ADDR_MASK) =
=3D=3D MR_ADDR_IPV6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  &amp;&amp; IN6_IS_ADDR_LINKLOCAL(&amp;src=2Ev6=2Eaddr))</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    /* do n=
othing, for now=2E  TODO: add address learning */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    msg(D=
_MULTI_DROPPED,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  &quot;MULTI: bad source address from client [%s], packet =
dropped&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                 mroute_addr_print(&amp;src, &amp;gc));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                c-&gt;c2=2Eto=
_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
/* client-to-client communication enabled? */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            else if (m-&gt;enable_c2c)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                /* multicast? */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                if (mroute_flag=
s &amp; MROUTE_EXTRACT_MCAST)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    /* for now, treat multicast as broadcast */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    multi_bca=
st(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, 0);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                else /* possible client to client ro=
uting */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   ASSERT(!(mroute_flags &amp; MROUTE_EXTRACT_BCAST));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    mi =3D multi_get_insta=
nce_by_virtual_addr(m, &amp;dest, true);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  /* if dest addr is a known client, route to it */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    if (mi)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
         multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                            register_activ=
ity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                        c-&gt;c2=2Eto_tun=2Elen =3D 0;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        else if (TUNNEL_TYPE(m-&gt;top=2Ec1=2E=
tuntap) =3D=3D DEV_TYPE_TAP)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       uint16_t vid =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (=
m-&gt;top=2Eoptions=2Evlan_tagging)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                if (vlan_is_tagged(&amp;c-&gt;c2=2Eto_tun))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    /* Drop VLAN-ta=
gged frame=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               msg(D_VLAN_DEBUG, &quot;dropping incoming VLAN-tagged frame&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                else</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    vid =3D c-&gt;options=2Evlan_pvid;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            /* extract packet source and dest ad=
dresses */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 mroute_flags =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            mroute_extract_addr_from_packet(&amp;src, &amp;dest, vid, &amp;=
c-&gt;c2=2Eto_tun, DEV_TYPE_TAP);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                if (multi_learn_addr(m, m-&gt;pendi=
ng, &amp;src, 0) =3D=3D m-&gt;pending)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    /* check for broadcast */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    if (m-&gt;enable_c=
2c)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      if (mroute_flags &amp; (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
           multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, vid);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
  else /* try client-to-client routing */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                            mi =3D multi_get_instan=
ce_by_virtual_addr(m, &amp;dest, false);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                          /* if dest addr is a known client, route to it */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
       if (mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, m=
i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
              register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
 c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                            }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                else</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    struct gc_arena gc =3D gc_new();</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    msg(D_MULTI=
_DROPPED,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
            &quot;MULTI: bad source address from client [%s], packet droppe=
d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           mroute_addr_print(&amp;src, &amp;gc));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    c-&gt;c2=2Eto_tun=2Elen =3D=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                c-&gt;c2=2E=
to_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_proces=
s_incoming_link_data(m, floated, sock);</span><br><span>     }</span><br><s=
pan> </span><br><span>     /* postprocess and set wakeup */</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1722?usp=3Demail">change 1722</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1722?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I9f10d91407347faf32397535c95e2d80=
a1575bd5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1722 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--2tSoCM0hgqg=--


--===============8691104218797806573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8691104218797806573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8691104218797806573==--

