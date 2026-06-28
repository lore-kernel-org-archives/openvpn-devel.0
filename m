Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B42C43602
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 20:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z0syt+0ROAg0EfsK7PFOi3fs/4pHby+1MTQO54VLYmQ=; b=VEal91KLtK6vIbzjPTVkymdtM2
	aneuJClNF9byk9BS5snVkQF2MSkHw5yXSF4xc/LgL9krEH+EgZs9EzIS5iLDn4wfjKxI/mRFVKaRj
	Ym/G2HEYwOpNmQ+kzybyp+27JryS0Pp0pHbVma8n0iLgYxCD5leYgUCqH2tAvxHqZhjI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdwav-00067Q-5u;
	Sun, 28 Jun 2026 20:59:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdwat-00067H-Iz
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 20:59:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=M3w7C5sLXArvtWbVIlZAv1QrslhG9Ppi3ivjzd0i27k=; b=GQ/RgjKdfMUDJ7K/puW9EnQDFb
 60wywQNGdLRX71qpjXPIAeKWDJGhlS5AG5Mc1aAMNDzpNfK43dPJCceSKnYGEcmNcFmljj4njj8RC
 GVYFU5JGOX0277kKA2pEeAFN1qjN6CPa2cHXIthLRA80ImwxXrFY/8X67vHM0p0qyKIA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M3w7C5sLXArvtWbVIlZAv1QrslhG9Ppi3ivjzd0i27k=; b=R
 N+APTcFP/7TB8wp6myzs/x7ncx2YB3jrcxprtyOahfysDQ3mGe3yv5jiJpyAXqR1rV74XgAwgAsYy
 p535DAJme+A4yhqiBCNqyU61nl/93bR/0aneCWwGKYuMlOxAAD53VVFB+v1egN8NL3mb9HnNCQtUk
 z6wafX7Pp0zi+NOw=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdwao-0004dg-Fy for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 20:59:09 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso1499710f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 28 Jun 2026 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782680340; x=1783285140; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M3w7C5sLXArvtWbVIlZAv1QrslhG9Ppi3ivjzd0i27k=;
 b=BWrKCDk6icZSCoqHBtzV8AgVYDYPRTkCzK0nWlA8R1ujKYNvvLDjozpDXuX8uu0W3u
 8oQdeDUZuGMOiNzl8Gd2b6ChGNx0njz5fHcPFG4yYXVaEBbdbBfobzBj9vilHuKVEIGe
 T74cLx5J61/h9I1Ggaqc88/9tcQ+3GoeWinwjLJk/3K+HIVe2aBacpOWwhUF1D9QTUbP
 uY0qdoUUe15OlY6QrHFrQeCQ4+gioH2sVAdDtKAxBIzLVLWWpfB7GAhH+uqQcYuMXhbZ
 gCI3J/tQ7vkQO83n6Hl94U0KpCs/4Aw/T9pRKWEJH4P5YSKJsA8T2ouAXf7joYzEBu/3
 o/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782680340; x=1783285140;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M3w7C5sLXArvtWbVIlZAv1QrslhG9Ppi3ivjzd0i27k=;
 b=VGZtawSy67txKDZZ+CBCcjjrvE66HqiNkEsYN+xIF43ghp+M05i15WYry1dH14GYuL
 kQ1v56ckrcQNPFA+vhrTvFDYQiZHCf3qDiDw4hlekYTZbFi0Po4RyCb2AGMHogl+ckA4
 VGV140hQFfFqPDkkyjb9WdCNGYJ0ngMm9j48LG96MCix3qJZt+NYOer6l09Gth78/0p9
 OhATFjNGqloi4Q15azNAJY52hDnWwBfF1zbaaTA4wLvKu4bR14KZXEb/7daxevL4VZag
 NYjlKBay7ZQzyOMoYCkzp0wlJtnI5IKpLITzA2KsDW9Y1cZWaO3PiR+y2q39xmq7FbiS
 Em5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwsPOiyLUHFmSfEQxTQsafWAtf1PRRD6lqW1aUdU60glVwDdFcMJ/6h0cr8z6DXt+VRj8P5dOpxGSPmtCj@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwBhwEyyz6rrUiYvcjJdUcS9hDdyk9AS0xOaysLw3pBG/bL5mya
 v/T2uaFqZPIJfJzblKNvDnuruxSy/sNbji6hjQQYzN6DkLyuGTnniGPwNfZ+C5wU8p92wOidQCv
 0+OWrMm98k3+yVRSSGbdEu+W3fgt/Zn/buBL11aZDNbWupxgX69qE39aHg5Fpk9AIg5uH
X-Gm-Gg: AfdE7cnlNcbV4poggVZDn4e7XxYQO9KDUJBrN7D7xOUYq9xrASznevtZPB78tQFJ9yU
 v9ErB0MiHD+JCQmaklEZ0D0NnvDdPbsWU6H1wlBKFBV5TKbQ5QqMXDFhkUkWYJljatGG5EeZ7n2
 G2EOE+7a405/s+0CSH2niwbXAIQSQajD+w2dtx8eCT2+oLZV/iXklclSDZNJbcBIsx4AtdCIO9i
 nc2J34+00hDE5FA4GlKpPpAL22jVDPwkIfTBehGJMiE4TtM3Vrw7QVmlQ/n5MjNxlKkMsHp3MVM
 psDl5KnZYxpxn5P31UK02If6+kpd1hIwyq+usH0sMShVQXCbErQJv1yRHYXkAXx7A/WUH9/Vs7a
 G9ieLSYKPGz/oN6RN9fQY6VExY5hJqJZTSAOitUgIitpf220Jhw4vcGluDmSVifR75mQkACpyxm
 2SgGVyGawVjCL5lsB/3zyvgAV5Tkue7/p/GY3tViV1MaSH6/1Xl9iQX4Szug5QfO14STotycbHG
 S0ISxRBWQ81CG8h9Jvub30lBJx9qYQm2VKEBJtne5wzkFNn7pTggAD44SmrClwBOOclmE/Unqy6
 4pY=
X-Received: by 2002:a05:6000:5c2:b0:472:8343:7f5f with SMTP id
 ffacd0b85a97d-472834381dbmr6507173f8f.34.1782680340137; 
 Sun, 28 Jun 2026 13:59:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4737769b6a0sm4197921f8f.28.2026.06.28.13.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 13:58:59 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 28 Jun 2026 20:58:59 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I401aab94993b62bf18e66561532085f99e62f745
X-Gerrit-Change-Number: 1721
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1721?usp=email>
X-Gerrit-Commit: ce9c3a265b44ec0546f7ae51beac88e839618d59
In-Reply-To: <gerrit.1782134588000.I401aab94993b62bf18e66561532085f99e62f745@gerrit.openvpn.net>
References: <gerrit.1782134588000.I401aab94993b62bf18e66561532085f99e62f745@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk0MDFhYWI5NDk5M2I2MmJmMThlNjY1NjE1MzIwODVmOTllNjJmNzQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2ed512061af475e3f564331fd11150e318bc783b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdwao-0004dg-Fy
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
Content-Type: multipart/mixed; boundary="===============6460681388910553317=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6460681388910553317==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gxgCT8RX4cg="; charset=UTF-8

--gxgCT8RX4cg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1721?usp=3Demail )

Change subject: Remove an indention layer from mult=
i_process_incoming_link
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Remove an indention layer from multi_process_incoming_link

This=
 also move the gc area acquire release to the small parts where they
are ac=
tually used=2E

Change-Id: I401aab94993b62bf18e66561532085f99e62f745
Signed=
-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1721
Message-Id: <20260628150235=2E13113-1-gert@greenie=2Emuc=2Ede>
URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g37341=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M s=
rc/openvpn/multi=2Ec
1 file changed, 129 insertions(+), 128 deletions(-)


=


diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index a957fdf=
=2E=2E8b36cf7 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2E=
c
@@ -3306,8 +3306,6 @@
 multi_process_incoming_link(struct multi_context *=
m, struct multi_instance *instance,
                             const unsi=
gned int mpp_flags, struct link_socket *sock)
 {
-    struct gc_arena gc =
=3D gc_new();
-
     struct context *c;
     struct mroute_addr src, dest;
=
     unsigned int mroute_flags;
@@ -3332,167 +3330,171 @@
         multi_se=
t_pending(m, instance);
     }
 
-    if (m->pending)
+    if (!m->pending)=

     {
-        set_prefix(m->pending);
+        return true;
+    }
+    =
set_prefix(m->pending);
 
-        /* get instance context */
-        c =
=3D &m->pending->context;
+    /* get instance context */
+    c =3D &m->pe=
nding->context;
 
-        if (!instance)
+    if (!instance)
+    {
+     =
   /* transfer packet pointer from top-level context buffer to instance */
=
+        c->c2=2Ebuf =3D m->top=2Ec2=2Ebuf;
+
+        /* transfer from-add=
r from top-level context buffer to instance */
+        if (!floated)
     =
    {
-            /* transfer packet pointer from top-level context buffer=
 to instance */
-            c->c2=2Ebuf =3D m->top=2Ec2=2Ebuf;
+          =
  c->c2=2Efrom =3D m->top=2Ec2=2Efrom;
+        }
+    }
 
-            /* =
transfer from-addr from top-level context buffer to instance */
-          =
  if (!floated)
+    if (BLEN(&c->c2=2Ebuf) > 0)
+    {
+        struct lin=
k_socket_info *lsi;
+        const uint8_t *orig_buf;
+
+        /* decrypt=
 in instance context */
+
+        lsi =3D &sock->info;
+        orig_buf =
=3D c->c2=2Ebuf=2Edata;
+        if (process_incoming_link_part1(c, lsi, fl=
oated))
+        {
+            /* nonzero length means that we have a vali=
d, decrypted packed */
+            if (floated && c->c2=2Ebuf=2Elen > 0)
 =
            {
-                c->c2=2Efrom =3D m->top=2Ec2=2Efrom;
+      =
          multi_process_float(m, m->pending, sock);
             }
+
+     =
       process_incoming_link_part2(c, lsi, orig_buf);
         }
 
-       =
 if (BLEN(&c->c2=2Ebuf) > 0)
+        if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap)=
 =3D=3D DEV_TYPE_TUN)
         {
-            struct link_socket_info *lsi;=

-            const uint8_t *orig_buf;
+            /* extract packet sourc=
e and dest addresses */
+            mroute_flags =3D
+                mrou=
te_extract_addr_from_packet(&src, &dest, 0, &c->c2=2Eto_tun, DEV_TYPE_TUN);=

 
-            /* decrypt in instance context */
-
-            lsi =3D &s=
ock->info;
-            orig_buf =3D c->c2=2Ebuf=2Edata;
-            if (p=
rocess_incoming_link_part1(c, lsi, floated))
+            /* drop packet if=
 extract failed */
+            if (!(mroute_flags & MROUTE_EXTRACT_SUCCEED=
ED))
             {
-                /* nonzero length means that we have a=
 valid, decrypted packed */
-                if (floated && c->c2=2Ebuf=2El=
en > 0)
-                {
-                    multi_process_float(m, m->p=
ending, sock);
-                }
-
-                process_incoming_link_=
part2(c, lsi, orig_buf);
+                c->c2=2Eto_tun=2Elen =3D 0;
     =
        }
-
-            if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D DEV_T=
YPE_TUN)
+            /* make sure that source address is associated with t=
his client */
+            else if (multi_get_instance_by_virtual_addr(m, &=
src, true) !=3D m->pending)
             {
-                /* extract pack=
et source and dest addresses */
-                mroute_flags =3D
-        =
            mroute_extract_addr_from_packet(&src, &dest, 0, &c->c2=2Eto_tun=
, DEV_TYPE_TUN);
-
-                /* drop packet if extract failed */
-  =
              if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
+            =
    /* IPv6 link-local address (fe80::xxx)? */
+                if ((src=2E=
type & MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6
+                    && IN6_IS_ADD=
R_LINKLOCAL(&src=2Ev6=2Eaddr))
                 {
-                    c->c=
2=2Eto_tun=2Elen =3D 0;
+                    /* do nothing, for now=2E  TOD=
O: add address learning */
                 }
-                /* make sure=
 that source address is associated with this client */
-                els=
e if (multi_get_instance_by_virtual_addr(m, &src, true) !=3D m->pending)
+ =
               else
                 {
-                    /* IPv6 link-lo=
cal address (fe80::xxx)? */
-                    if ((src=2Etype & MR_ADDR_=
MASK) =3D=3D MR_ADDR_IPV6
-                        && IN6_IS_ADDR_LINKLOCAL=
(&src=2Ev6=2Eaddr))
-                    {
-                        /* do n=
othing, for now=2E  TODO: add address learning */
-                    }
- =
                   else
-                    {
-                        msg=
(D_MULTI_DROPPED,
-                            "MULTI: bad source address f=
rom client [%s], packet dropped",
-                            mroute_addr_=
print(&src, &gc));
-                    }
-                    c->c2=2Eto_t=
un=2Elen =3D 0;
+                    struct gc_arena gc =3D gc_new();
+    =
                msg(D_MULTI_DROPPED,
+                        "MULTI: bad s=
ource address from client [%s], packet dropped",
+                        m=
route_addr_print(&src, &gc));
+                    gc_free(&gc);
          =
       }
-                /* client-to-client communication enabled? */
-  =
              else if (m->enable_c2c)
+                c->c2=2Eto_tun=2Elen=
 =3D 0;
+            }
+            /* client-to-client communication enabl=
ed? */
+            else if (m->enable_c2c)
+            {
+               =
 /* multicast? */
+                if (mroute_flags & MROUTE_EXTRACT_MCAST)=

                 {
-                    /* multicast? */
-                =
    if (mroute_flags & MROUTE_EXTRACT_MCAST)
-                    {
-      =
                  /* for now, treat multicast as broadcast */
-            =
            multi_bcast(m, &c->c2=2Eto_tun, m->pending, 0);
-              =
      }
-                    else /* possible client to client routing */
-=
                    {
-                        ASSERT(!(mroute_flags & MROU=
TE_EXTRACT_BCAST));
-                        mi =3D multi_get_instance_by_v=
irtual_addr(m, &dest, true);
+                    /* for now, treat multica=
st as broadcast */
+                    multi_bcast(m, &c->c2=2Eto_tun, m->=
pending, 0);
+                }
+                else /* possible client to=
 client routing */
+                {
+                    ASSERT(!(mroute_=
flags & MROUTE_EXTRACT_BCAST));
+                    mi =3D multi_get_insta=
nce_by_virtual_addr(m, &dest, true);
 
-                        /* if dest =
addr is a known client, route to it */
-                        if (mi)
+  =
                  /* if dest addr is a known client, route to it */
+      =
              if (mi)
+                    {
                         {
+  =
                          multi_unicast(m, &c->c2=2Eto_tun, mi);
+         =
                   register_activity(c, BLEN(&c->c2=2Eto_tun));
+          =
              }
+                        c->c2=2Eto_tun=2Elen =3D 0;
+     =
               }
+                }
+            }
+        }
+        else=
 if (TUNNEL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)
+        {
+   =
         uint16_t vid =3D 0;
+
+            if (m->top=2Eoptions=2Evlan_tag=
ging)
+            {
+                if (vlan_is_tagged(&c->c2=2Eto_tun))
=
+                {
+                    /* Drop VLAN-tagged frame=2E */
+  =
                  msg(D_VLAN_DEBUG, "dropping incoming VLAN-tagged frame");=

+                    c->c2=2Eto_tun=2Elen =3D 0;
+                }
+     =
           else
+                {
+                    vid =3D c->options=
=2Evlan_pvid;
+                }
+            }
+            /* extract pac=
ket source and dest addresses */
+            mroute_flags =3D
+           =
     mroute_extract_addr_from_packet(&src, &dest, vid, &c->c2=2Eto_tun, DEV=
_TYPE_TAP);
+
+            if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
+  =
          {
+                if (multi_learn_addr(m, m->pending, &src, 0) =
=3D=3D m->pending)
+                {
+                    /* check for bro=
adcast */
+                    if (m->enable_c2c)
+                    {
+ =
                       if (mroute_flags & (MROUTE_EXTRACT_BCAST | MROUTE_EX=
TRACT_MCAST))
+                        {
+                            multi=
_bcast(m, &c->c2=2Eto_tun, m->pending, vid);
+                        }
+  =
                      else /* try client-to-client routing */
+            =
            {
+                            mi =3D multi_get_instance_by_vir=
tual_addr(m, &dest, false);
+
+                            /* if dest addr =
is a known client, route to it */
+                            if (mi)
    =
                         {
                                 multi_unicast(m=
, &c->c2=2Eto_tun, mi);
                                 register_activity(=
c, BLEN(&c->c2=2Eto_tun));
-                            }
-                =
            c->c2=2Eto_tun=2Elen =3D 0;
-                        }
-       =
             }
-                }
-            }
-            else if (TUNN=
EL_TYPE(m->top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)
-            {
-        =
        uint16_t vid =3D 0;
-
-                if (m->top=2Eoptions=2Evlan_=
tagging)
-                {
-                    if (vlan_is_tagged(&c->c2=
=2Eto_tun))
-                    {
-                        /* Drop VLAN-ta=
gged frame=2E */
-                        msg(D_VLAN_DEBUG, "dropping incom=
ing VLAN-tagged frame");
-                        c->c2=2Eto_tun=2Elen =3D =
0;
-                    }
-                    else
-                    {
=
-                        vid =3D c->options=2Evlan_pvid;
-                 =
   }
-                }
-                /* extract packet source and dest =
addresses */
-                mroute_flags =3D
-                    mroute_=
extract_addr_from_packet(&src, &dest, vid, &c->c2=2Eto_tun, DEV_TYPE_TAP);
=
-
-                if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
-          =
      {
-                    if (multi_learn_addr(m, m->pending, &src, 0) =
=3D=3D m->pending)
-                    {
-                        /* check=
 for broadcast */
-                        if (m->enable_c2c)
-            =
            {
-                            if (mroute_flags & (MROUTE_EXTRA=
CT_BCAST | MROUTE_EXTRACT_MCAST))
-                            {
-         =
                       multi_bcast(m, &c->c2=2Eto_tun, m->pending, vid);
- =
                           }
-                            else /* try clien=
t-to-client routing */
-                            {
-                    =
            mi =3D multi_get_instance_by_virtual_addr(m, &dest, false);
-
-=
                                /* if dest addr is a known client, route to=
 it */
-                                if (mi)
-                          =
      {
-                                    multi_unicast(m, &c->c2=2Eto_t=
un, mi);
-                                    register_activity(c, BLEN(&c-=
>c2=2Eto_tun));
-                                    c->c2=2Eto_tun=2Elen =
=3D 0;
-                                }
+                                =
c->c2=2Eto_tun=2Elen =3D 0;
                             }
                =
         }
                     }
-                    else
-              =
      {
-                        msg(D_MULTI_DROPPED,
-                    =
        "MULTI: bad source address from client [%s], packet dropped",
-    =
                        mroute_addr_print(&src, &gc));
-                   =
     c->c2=2Eto_tun=2Elen =3D 0;
-                    }
                 }
=
                 else
                 {
+                    struct gc_are=
na gc =3D gc_new();
+                    msg(D_MULTI_DROPPED,
+            =
            "MULTI: bad source address from client [%s], packet dropped",
+=
                        mroute_addr_print(&src, &gc));
                    =
 c->c2=2Eto_tun=2Elen =3D 0;
+                    gc_free(&gc);
           =
      }
             }
+            else
+            {
+                c-=
>c2=2Eto_tun=2Elen =3D 0;
+            }
         }
-
-        /* postproce=
ss and set wakeup */
-        ret =3D multi_process_post(m, m->pending, mpp=
_flags);
-
-        clear_prefix();
     }
 
-    gc_free(&gc);
+    /* pos=
tprocess and set wakeup */
+    ret =3D multi_process_post(m, m->pending, m=
pp_flags);
+
+    clear_prefix();
+
     return ret;
 }
 
@@ -3534,7 +3536,=
6 @@
          * Route an incoming tun/tap packet to
          * the approp=
riate multi_instance object=2E
          */
-
         mroute_flags =3D mro=
ute_extract_addr_from_packet(&src, &dest, vid, &m->top=2Ec2=2Ebuf, dev_type=
);
 
         if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)

-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1721?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I401aab94993b62bf18e66561532085f99e62f=
745
Gerrit-Change-Number: 1721
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=


--gxgCT8RX4cg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1721?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Remove an indention layer from multi_proce=
ss_incoming_link<br><br>This also move the gc area acquire release to the s=
mall parts where they<br>are actually used=2E<br><br>Change-Id: I401aab9499=
3b62bf18e66561532085f99e62f745<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2=
549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1721<br>Message=
-Id: &lt;20260628150235=2E13113-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3734=
1=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M src/openvpn/multi=2Ec<br>1 file changed, 129 insertions(+), 128 de=
letions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvp=
n/multi=2Ec</span><br><span>index a957fdf=2E=2E8b36cf7 100644</span><br><sp=
an>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec<=
/span><br><span>@@ -3306,8 +3306,6 @@</span><br><span> multi_process_incomi=
ng_link(struct multi_context *m, struct multi_instance *instance,</span><br=
><span>                             const unsigned int mpp_flags, struct li=
nk_socket *sock)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span>     struct context *c;</span=
><br><span>     struct mroute_addr src, dest;</span><br><span>     unsigned=
 int mroute_flags;</span><br><span>@@ -3332,167 +3330,171 @@</span><br><spa=
n>         multi_set_pending(m, instance);</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt=
;pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!m=
-&gt;pending)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        set_prefix(m-&gt;pending);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    set_prefix(m-&gt;pending);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        /* get instance context=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c =3D &amp=
;m-&gt;pending-&gt;context;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* get instance context */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    c =3D &amp;m-&gt;pending-&gt;context;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!insta=
nce)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!instan=
ce)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* transfer packet poi=
nter from top-level context buffer to instance */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Ebuf =3D m-&gt;top=2Ec2=2Eb=
uf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* transfer from-addr from =
top-level context buffer to instance */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!floated)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            /* transfer pack=
et pointer from top-level context buffer to instance */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c2=2Ebuf =3D m-&gt;top=
=2Ec2=2Ebuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     c-&gt;c2=2Efrom =3D m-&gt;top=2Ec2=2Efrom;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            /* transfer from-addr from top-level contex=
t buffer to instance */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            if (!floated)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (BLEN(&amp;c-&gt;c2=2Ebuf) &gt; 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct link_socket_info *lsi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const uint8_t *orig_buf;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* decrypt in instance context */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        lsi =3D &amp;sock-&gt;info;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        orig_buf =3D c-&gt;c=
2=2Ebuf=2Edata;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (process_incoming_link_part1(c, lsi, floated))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* nonzero length means that we have a =
valid, decrypted packed */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (floated &amp;&amp; c-&gt;c2=2Ebuf=2Elen &gt; 0)</spa=
n><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                c-&gt;c2=2Efrom =3D m-&gt;top=2Ec2=2Efrom;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                multi_process_f=
loat(m, m-&gt;pending, sock);</span><br><span>             }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            process_incoming_link_part2(c, lsi, orig_=
buf);</span><br><span>         }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (BLEN(&amp;c-&gt;c2=2Ebuf) &gt; 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (TUNNEL_T=
YPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct l=
ink_socket_info *lsi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            const uint8_t *orig_buf;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            /* extract packet source and dest addresses */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mroute_=
flags =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      mroute_extract_addr_from_packet(&amp;src, &amp;dest, 0, &amp;c-&gt;c2=
=2Eto_tun, DEV_TYPE_TUN);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            /* decrypt in instance context */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            lsi =3D &amp;sock-&gt;info;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            orig_buf =3D c-&gt;c=
2=2Ebuf=2Edata;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if (process_incoming_link_part1(c, lsi, floated))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            /* drop packet if extract f=
ailed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (!(mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED))</span><br><span>      =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   /* nonzero length means that we have a valid, decrypted packed */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                if (floated =
&amp;&amp; c-&gt;c2=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    multi_process_float(m, m-&gt;pending, soc=
k);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                process_incoming_link_part2=
(c, lsi, orig_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span>            =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (TUNNEL_TYPE(m-&gt;top=2E=
c1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            /* make sure that source address is associated wi=
th this client */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          else if (multi_get_instance_by_virtual_addr(m, &amp;src, true) !=
=3D m-&gt;pending)</span><br><span>             {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                /* extract packet source and de=
st addresses */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          mroute_flags =3D</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    mroute_extract_addr_from_packet(&amp;src, &amp;des=
t, 0, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TUN);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                /* drop packet if extract failed */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                if (!(mroute_flags &amp; MR=
OUTE_EXTRACT_SUCCEEDED))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                /* IPv6 link-local address (fe80::xxx)? */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                if ((src=2Etype=
 &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    &amp;&amp; IN6_IS_ADDR_LINKLOCAL(&=
amp;src=2Ev6=2Eaddr))</span><br><span>                 {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    c-&gt;c2=2Eto_tun=2E=
len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           /* do nothing, for now=2E  TODO: add address learning */</span><=
br><span>                 }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                /* make sure that source address is associated with t=
his client */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        else if (multi_get_instance_by_virtual_addr(m, &amp;src, true) !=3D=
 m-&gt;pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            else</span><br><span>                 {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    /* IPv6 link-local addr=
ess (fe80::xxx)? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  if ((src=2Etype &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 &amp;&amp; IN6_IS_ADDR_LINKLOCAL(&amp;src=2Ev6=2Eaddr))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                        /* do nothing, f=
or now=2E  TODO: add address learning */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    else</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                        msg(D_MULTI_DROPPED,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                            &q=
uot;MULTI: bad source address from client [%s], packet dropped&quot;,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
 mroute_addr_print(&amp;src, &amp;gc));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    c-&gt;c2=2Eto_tun=2Elen =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    msg(D_MULTI_DROPPED,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        &quot;MULTI: bad source=
 address from client [%s], packet dropped&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        mroute_addr_print(&amp=
;src, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 gc_free(&amp;gc);</span><br><span>                 }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* client-t=
o-client communication enabled? */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                else if (m-&gt;enable_c2c)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2=2Eto_tun=2Elen=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* cli=
ent-to-client communication enabled? */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            else if (m-&gt;enable_c2c)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                /* multicast? */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                if (mroute_f=
lags &amp; MROUTE_EXTRACT_MCAST)</span><br><span>                 {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    /* multic=
ast? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      if (mroute_flags &amp; MROUTE_EXTRACT_MCAST)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                        /* for now, treat mult=
icast as broadcast */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pendin=
g, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     else /* possible client to client routing */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        ASSERT(!(mroute_flags &=
amp; MROUTE_EXTRACT_BCAST));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                        mi =3D multi_get_instance_by_virtual_addr(m,=
 &amp;dest, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   /* for now, treat multicast as broadcast */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    multi_bcast(=
m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, 0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                else /* possible client to client r=
outing */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        ASSERT(!(mroute_flags &amp; MROUTE_EXTRACT_BCAST));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    mi =3D multi_ge=
t_instance_by_virtual_addr(m, &amp;dest, true);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        /* if d=
est addr is a known client, route to it */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                        if (mi)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    /* if dest addr is a =
known client, route to it */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    if (mi)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    {</span><br><span>                    =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
               multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                            regist=
er_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        c-&gt;c2=2Eto_tun=
=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (TUNNE=
L_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            uint16_t vid =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (m-&gt;top=2Eoptions=2Evlan_tagging)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                if (vlan_is_tagg=
ed(&amp;c-&gt;c2=2Eto_tun))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    /* Drop VLAN-tagged frame=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    msg(D_VLAN_DEBUG,=
 &quot;dropping incoming VLAN-tagged frame&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    c-&gt;c2=2Eto_tun=2Elen =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    vid =3D c-&gt;options=2Evlan_pvid;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            /* extract packet source and dest addresses */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            mroute_flags =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
mroute_extract_addr_from_packet(&amp;src, &amp;dest, vid, &amp;c-&gt;c2=2Et=
o_tun, DEV_TYPE_TAP);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (m=
route_flags &amp; MROUTE_EXTRACT_SUCCEEDED)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                if (multi_learn_addr(m, m-&gt;pending, &a=
mp;src, 0) =3D=3D m-&gt;pending)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    /* check for broadcast */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    if (m-&gt;enable_c=
2c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          if (mroute_flags &amp; (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCA=
ST))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                   multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, vi=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              else /* try client-to-client routing */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                            mi =3D =
multi_get_instance_by_virtual_addr(m, &amp;dest, false);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                            /* if dest addr is a known cl=
ient, route to it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                            if (mi)</span><br><span>                      =
       {</span><br><span>                                 multi_unicast(m, =
&amp;c-&gt;c2=2Eto_tun, mi);</span><br><span>                              =
   register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                            }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                            c-&gt;=
c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       else if (TUNNEL_TYPE(m-&gt;top=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TAP)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                uint16_t vid =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                if (m-&gt;top=2Eopti=
ons=2Evlan_tagging)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              if (vlan_is_tagged(&amp;c-&gt;c2=2Eto_tun))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                        /* Drop VLAN-ta=
gged frame=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   msg(D_VLAN_DEBUG, &quot;dropping incoming VLAN-tagged fr=
ame&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    else</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                        vid =3D c-&gt;options=2Ev=
lan_pvid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
/* extract packet source and dest addresses */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                mroute_flags =3D</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    mroute_extract_addr=
_from_packet(&amp;src, &amp;dest, vid, &amp;c-&gt;c2=2Eto_tun, DEV_TYPE_TAP=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                if (mroute_flags &amp; M=
ROUTE_EXTRACT_SUCCEEDED)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   if (multi_learn_addr(m, m-&gt;pending, &amp;src, 0) =3D=
=3D m-&gt;pending)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                     /* check for broadcast */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                        if (m-&gt;enable_c2c)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
      if (mroute_flags &amp; (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                   multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, vi=
d);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                  else /* try client-to-client routing */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
 mi =3D multi_get_instance_by_virtual_addr(m, &amp;dest, false);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                /* if dest addr is a =
known client, route to it */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                if (mi)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                    mu=
lti_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                    register_activity=
(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                    c-&gt;c2=2Eto_tun=2Elen =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                               c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><sp=
an>                             }</span><br><span>                         =
}</span><br><span>                     }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    else</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                        msg(D_MULTI_DROPPED,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                            &q=
uot;MULTI: bad source address from client [%s], packet dropped&quot;,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
 mroute_addr_print(&amp;src, &amp;gc));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        c-&gt;c2=2Eto_tun=2Elen =3D 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</s=
pan><br><span>                 }</span><br><span>                 else</spa=
n><br><span>                 {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    struct gc_arena gc =3D gc_new();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    msg(D_MULTI=
_DROPPED,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              &quot;MULTI: bad source address from client [%s], packet drop=
ped&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               mroute_addr_print(&amp;src, &amp;gc));</span><br><span>     =
                c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    gc_free(&amp;gc);</span><br>=
<span>                 }</span><br><span>             }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                c-&gt;c2=2Eto_tun=2Elen =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* postprocess=
 and set wakeup */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     ret =3D multi_process_post(m, m-&gt;pending, mpp_flags);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        clear_prefix();</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* post=
process and set wakeup */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ret =3D multi_process_post(m, m-&gt;pending, mpp_flags);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    clear_prefix();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     return ret;</span><br><sp=
an> }</span><br><span> </span><br><span>@@ -3534,7 +3536,6 @@</span><br><sp=
an>          * Route an incoming tun/tap packet to</span><br><span>        =
  * the appropriate multi_instance object=2E</span><br><span>          */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>      =
   mroute_flags =3D mroute_extract_addr_from_packet(&amp;src, &amp;dest, vi=
d, &amp;m-&gt;top=2Ec2=2Ebuf, dev_type);</span><br><span> </span><br><span>=
         if (mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED)</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1721?usp=3Demail">change 1721</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1721?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I401aab94993b62bf18e66561532085f99e62f=
745 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1721 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display=
:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--gxgCT8RX4cg=--


--===============6460681388910553317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6460681388910553317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6460681388910553317==--

