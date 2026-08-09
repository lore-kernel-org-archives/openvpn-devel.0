Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176C1C5AC80
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfDnAdkc8ohVwGbOLPyI0bcfrweJs0iDss2Yn0rleFc=; b=dHn6IutRAUyW1O42HCOnbT4ytN
	FBTA+xQnD2kSnSrjCDqaG/R2t0XN2g+34edEYR+GylKu1d2r0KfSleCVWuYqilo3+Sea66GjJcnpN
	Zh6q7QJp2H27wQfoq4DbZ7D3m6ygCj2nTkk9horuK0pK2K4HJXIniKb4r+YRvKB4RJQE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wt2YX-0007JY-2n;
	Sun, 09 Aug 2026 12:23:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wt2YV-0007JQ-L6
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 12:23:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ezY1vXXKl/tFn0D1EcSMj6Q8lByAKZFUfbx/XYRhDFw=; b=Y3CpaN87tMFQ0t+iE1/hcOuh1i
 7I/lWQug2BUR/SvsDOXsz5ALEWzEyX+WrHFxAleelCu683Egmo51gB+P8Yt6e7TCoYltr2Yr2wMrQ
 MMM0tRSGesLMSt1tPBSSdYtM+fszJg7dCoTreqor0pQmrvqMWqQ6+CyYENCCzNlhvmkQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ezY1vXXKl/tFn0D1EcSMj6Q8lByAKZFUfbx/XYRhDFw=; b=H
 h9nZOoQbBh7ySVLn7yl6NTzAXT/v29mD3VGGaSch5wrSQrmOzW8OlN86G8mO3il6UpCbKK+btjuAN
 WnzG6t3FCpqGc4ijrjDs7gH3ZVqH5i8QHzB3xSU9d8CQ2l0/rRwbu3iyV5S6Xl2nUiZvwja9wF9LG
 +uK+vH0htcMCufR8=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wt2YV-0005pV-B6 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 12:23:05 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so530132f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 09 Aug 2026 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786278177; x=1786882977; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ezY1vXXKl/tFn0D1EcSMj6Q8lByAKZFUfbx/XYRhDFw=;
 b=cCw14LDNVwUHehc9zzzNAbmh6H/BVfaOlFpUuc2uIRtTvSQhtbVad7otxGqh11MvJ9
 w+KZ9IJRscTjktr5AUeAEqwR6dVmzKYYUBHOc8Z4KzdIhuLfw0ZWqM5tDE6+z+vgHXjJ
 ik2cGcIGaR6pk3jCtuil3oPxjSiCf3h1hlqA+wAiGfaeH/Deg/xewrnAbNfwA5BegsOm
 d33KrkW4Ylo9pZAFwtFvbGW03Wmn4OZT4MEVS/mG4tOHyMtZwc3WYRzWy3Zv+QdS0DAh
 RaWQujazTUkb91ieATyDaSGazvM5tV8b6LVHxuq+g3W2ZR3bucf1IEKgw5veh8uPrPoH
 +emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786278177; x=1786882977;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ezY1vXXKl/tFn0D1EcSMj6Q8lByAKZFUfbx/XYRhDFw=;
 b=ZYM7/LXQH7jbk88OGdVIE+z7jbcwCOH+6JwFxTuEbepvTut3iZG4OyF7sy7aObOPLi
 Cm8K/L0MYFkhoJo3zdZee6Msrs2b44NjGMTrKxWCHggPdcrvWdg6OFySbkXlbD1f6wTc
 ITgnPePmbj9d0zL9K5VHCpKLvoNycRyNE1iRpFaraqC2pSy1+Uzzm+yJLv0qhcPykfzY
 U2OqpClpk1OaDJRW15F2AxO/M5QX0zBSkcL3/vnvFIkw8alsEm0q5faIoG0PIEmvXWgM
 nc2eU+cNedFMg7esllNp2JcQRJCbz8nDhLz0ZcoSkIjUxQ/P2Mk5Jhgv7axV3WOezwXm
 uZNA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUJ5soFllBHvX9ML3cLvgDiIoCuSyXsY6DKokS45SvJHFn/5gldg6fLWtAB363bYVOqM2vwQJ1fmFm3BXM@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxfx+w5ewkjUS2flFMKO++kTGPiwBmxje5a+s4cjuG+4lgDJyKE
 feo51tXo8PNN5Z94sJt8BMWykxgoc+GEWLay+zfmqKflqkc+G5HREcWQnRINgLkHmqZ+QDLtBvg
 +Iwt4rsBJ9F+3MeHnT4Boxu//NzCnTqCJ07Tbryy8USRwoqKZ/yC2looPL2HxGI3XczEzSyGSZQ
 M4buIguA==
X-Gm-Gg: AR+sD12w8t5mQ//DhDzq+9ADI64ZQ3LPB/oNKZFr/z4CdoIeZ5RTILoriUJPr7BMOuC
 2jw/UGo56TgQapLj3Mqly/F2kylQDlA+L9JzyFiR3ZBXxOn3vLJvle4HqNnFo8ltsIWc0bactcT
 KtIEwP7dUKR649KxP4m/2bUGd2OQy53+sw7F9T/omZ2lUdCb8OVhvg0MdDfDICr5nX7bpZrr0QK
 QAKtY/bJjUf6rW6lf4K/9zwDyiJGNoj1NWszvOHOIgUd5zowChqLXQfy0Og5m/Dgz1vwM1m/BHq
 oQi7XM1A96scoZOdTfkBe7OCALqA5AfyTbV6cAHHZfl6jnjBHjLwUf379wd6LgqgYAfc3Jt4tuP
 AoNTwn+jEQqWww0GhOj92Gsn4Z8M91Ao+aGE7CNErrMfZ23c37wNeTXX50FfUXu7ZTSr6bkDCOS
 U9JlhlDBWkXINDAIFQc6+hIbd6IFC7w6bYnI2fTthksN2pe8zvI8B35Gy/6qzwGeuMOOkskq9Wz
 lqTXhzyKgbHRTorht3XeIAoRjpQo9XM7KuWVolm7hVCr1vSrr6pjSFJDpMSvU2DIkSMUygCEAdw
 ryLcNUs/vUqorA8GfKkDKyjSKXe5mDOP598Nh6DN61D0SOrNQaKCeki+Ljn9/Jg=
X-Received: by 2002:a5d:5d86:0:b0:47f:5369:bba with SMTP id
 ffacd0b85a97d-480026c876fmr19402408f8f.15.1786278177080; 
 Sun, 09 Aug 2026 05:22:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021457ebsm23053065f8f.6.2026.08.09.05.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 05:22:56 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 9 Aug 2026 12:22:56 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: fdff1c41dfff6d1233df5e638c0e31a7db99dfb6
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a4e0bb289405cb7998923de406e0aa77b7ee58cd-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wt2YV-0005pV-B6
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 multi_check_dest_addr_allowed from multi_process_float
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
Content-Type: multipart/mixed; boundary="===============5042704298872071213=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5042704298872071213==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3aLuEh8rBQg="; charset=UTF-8

--3aLuEh8rBQg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1723?usp=3Demail )

Change subject: Extract multi_check_dest_addr_allow=
ed from multi_process_float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Extract multi_check_dest_addr_allowed from multi_process_f=
loat

Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
Signed-off-by: A=
rne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723
Mes=
sage-Id: <20260731100758=2E3368-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38094=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
multi=2Ec
1 file changed, 75 insertions(+), 45 deletions(-)




diff --git =
a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index cfa2ad8=2E=2Ef5a18f7 =
100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3068,6 +=
3068,76 @@
 }
 
 /**
+ * This methods checks if a client instance is allowe=
d to use an address
+ *
+ * Reasons for disallowing a specific address are =
that a client might be
+ * already using that address=2E In that case the m=
ethod needs to decide
+ * if this instance can kick out the other instance=
=2E
+ *
+ * The method will then terminate the other instance if that check=
 was
+ * positive=2E
+ */
+static bool
+multi_check_dest_addr_allowed(struc=
t multi_context *m, struct multi_instance *mi, struct mroute_addr *real)
+{=

+    struct hash *hash =3D m->hash;
+    const uint64_t hv =3D hash_value(=
hash, real);
+    struct hash_bucket *bucket =3D hash_bucket(hash, hv);
+
+=
    /* make sure that we don't assign the client to an address taken by
+  =
   * another client */
+    struct hash_element *he =3D hash_lookup_fast(ha=
sh, bucket, real, hv);
+    if (!he)
+    {
+        /* Address is not take=
n, everything is fine=2E */
+        return true;
+    }
+
+    struct mult=
i_instance *ex_mi =3D he->value;
+
+    struct tls_multi *m1 =3D mi->contex=
t=2Ec2=2Etls_multi;
+    struct tls_multi *m2 =3D ex_mi->context=2Ec2=2Etls=
_multi;
+
+    struct gc_arena gc =3D gc_new();
+    int ret =3D false;
+
+=
    /* do not allow if target address is taken by client with another cert =
*/
+    if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_ha=
sh_set))
+    {
+        msg(D_MULTI_LOW, "Disallow float to an address tak=
en by another client %s",
+            multi_instance_string(ex_mi, false, =
&gc));
+
+        mi->context=2Ec2=2Ebuf=2Elen =3D 0;
+        goto done;
+=
    }
+
+    /* It doesn't make sense to let a peer float to the address it=
 already
+     * has, so we disallow it=2E This can happen if a DCO netlink=
 notification
+     * gets lost and we miss a floating step=2E
+     */
+  =
  if (m1->rx_peer_id =3D=3D m2->rx_peer_id)
+    {
+        msg(M_WARN,
+  =
          "disallowing peer %" PRIu32 " (%s) from floating to "
+          =
  "its own address (%s)",
+            m1->rx_peer_id, tls_common_name(mi->=
context=2Ec2=2Etls_multi, false),
+            mroute_addr_print(&mi->real,=
 &gc));
+        goto done;
+    }
+
+    msg(D_MULTI_LOW,
+        "closin=
g instance %s due to float collision with %s "
+        "using the same cer=
tificate",
+        multi_instance_string(ex_mi, false, &gc), multi_instanc=
e_string(mi, false, &gc));
+    multi_close_instance(m, ex_mi, false);
+   =
 ret =3D true;
+
+done:
+    gc_free(&gc);
+    return ret;
+}
+
+/**
  * H=
andles peer floating=2E
  *
  * If peer is floated to a taken address, eith=
er drops packet
@@ -3079,8 +3149,6 @@
 multi_process_float(struct multi_con=
text *m, struct multi_instance *mi, struct link_socket *sock)
 {
     struc=
t mroute_addr real =3D { 0 };
-    struct hash *hash =3D m->hash;
-    stru=
ct gc_arena gc =3D gc_new();
 
     if (mi->real=2Etype & MR_WITH_PROTO)
  =
   {
@@ -3090,53 +3158,16 @@
 
     if (!mroute_extract_openvpn_sockaddr(&r=
eal, &m->top=2Ec2=2Efrom=2Edest, true))
     {
-        goto done;
+       =
 return;
     }
 
-    const uint64_t hv =3D hash_value(hash, &real);
-    =
struct hash_bucket *bucket =3D hash_bucket(hash, hv);
-
-    /* make sure t=
hat we don't float to an address taken by another client */
-    struct has=
h_element *he =3D hash_lookup_fast(hash, bucket, &real, hv);
-    if (he)
+=
    if (!multi_check_dest_addr_allowed(m, mi, &real))
     {
-        struc=
t multi_instance *ex_mi =3D (struct multi_instance *)he->value;
-
-        =
struct tls_multi *m1 =3D mi->context=2Ec2=2Etls_multi;
-        struct tls_=
multi *m2 =3D ex_mi->context=2Ec2=2Etls_multi;
-
-        /* do not float i=
f target address is taken by client with another cert */
-        if (!cert=
_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
-       =
 {
-            msg(D_MULTI_LOW, "Disallow float to an address taken by ano=
ther client %s",
-                multi_instance_string(ex_mi, false, &gc))=
;
-
-            mi->context=2Ec2=2Ebuf=2Elen =3D 0;
-
-            goto do=
ne;
-        }
-
-        /* It doesn't make sense to let a peer float to t=
he address it already
-         * has, so we disallow it=2E This can happen=
 if a DCO netlink notification
-         * gets lost and we miss a floating=
 step=2E
-         */
-        if (m1->rx_peer_id =3D=3D m2->rx_peer_id)
- =
       {
-            msg(M_WARN,
-                "disallowing peer %" PRI=
u32 " (%s) from floating to "
-                "its own address (%s)",
-   =
             m1->rx_peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, =
false),
-                mroute_addr_print(&mi->real, &gc));
-            g=
oto done;
-        }
-
-        msg(D_MULTI_LOW,
-            "closing inst=
ance %s due to float collision with %s "
-            "using the same certi=
ficate",
-            multi_instance_string(ex_mi, false, &gc), multi_insta=
nce_string(mi, false, &gc));
-        multi_close_instance(m, ex_mi, false)=
;
+        return;
     }
 
+    struct gc_arena gc =3D gc_new();
+
     ms=
g(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
         m=
i->context=2Ec2=2Etls_multi->rx_peer_id,
         tls_common_name(mi->conte=
xt=2Ec2=2Etls_multi, false),
@@ -3165,7 +3196,6 @@
     ASSERT(hash_add(m->=
cid_hash, &mi->context=2Ec2=2Emda_context=2Ecid, mi, true));
 #endif
 
-don=
e:
     gc_free(&gc);
 }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1723?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
Gerrit-Change-Number: 1723
G=
errit-PatchSet: 20
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--3aLuEh8rBQg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1723?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Extract multi_check_dest_addr_allowed from=
 multi_process_float<br><br>Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd=
1a94e<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723<br>Message-Id: &lt;20260731100758=
=2E3368-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg38094=2Ehtml<br>Signed-off-b=
y: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mul=
ti=2Ec<br>1 file changed, 75 insertions(+), 45 deletions(-)<br><br></pre>
<=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><spa=
n>index cfa2ad8=2E=2Ef5a18f7 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -3068,6=
 +3068,76 @@</span><br><span> }</span><br><span> </span><br><span> /**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This methods checks i=
f a client instance is allowed to use an address</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Reasons for disallowing a specific address are that a client=
 might be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * already=
 using that address=2E In that case the method needs to decide</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * if this instance can kick out=
 the other instance=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The method =
will then terminate the other instance if that check was</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * positive=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+multi_check_dest_addr_allowed(struct multi_context *m, struct mul=
ti_instance *mi, struct mroute_addr *real)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(hash, real);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket=
 *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* make sure that we don&#39;t assign the client to an address taken by</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * another client =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_e=
lement *he =3D hash_lookup_fast(hash, bucket, real, hv);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!he)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* Address is not taken, everything is fine=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct multi_instance *ex_mi =3D he-&gt;value;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *m1 =3D mi-&gt;conte=
xt=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct tls_multi *m2 =3D ex_mi-&gt;context=2Ec2=2Etls_multi;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* do not allow if target address is taken =
by client with another cert */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!cert_hash_compare(m1-&gt;locked_cert_hash_set, m2-&gt;l=
ocked_cert_hash_set))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
D_MULTI_LOW, &quot;Disallow float to an address taken by another client %s&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
ulti_instance_string(ex_mi, false, &amp;gc));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* It doesn&#39;t make sense to let a peer float to the address it alr=
eady</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * has, so =
we disallow it=2E This can happen if a DCO netlink notification</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * gets lost and we miss a =
floating step=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m1-&gt;=
rx_peer_id =3D=3D m2-&gt;rx_peer_id)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_WARN,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &quot;disallowing peer %&quot; PRIu32 &quot; (%s) from float=
ing to &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      &quot;its own address (%s)&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            m1-&gt;rx_peer_id, tls_common_name(mi-&gt;c=
ontext=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    msg(D_MULTI_LOW,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        &quot;closing instance %s due to float collision=
 with %s &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    &quot;using the same certificate&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        multi_instance_string(ex_mi, false, &amp;gc=
), multi_instance_string(mi, false, &amp;gc));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    multi_close_instance(m, ex_mi, false);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * =
Handles peer floating=2E</span><br><span>  *</span><br><span>  * If peer is=
 floated to a taken address, either drops packet</span><br><span>@@ -3079,8=
 +3149,6 @@</span><br><span> multi_process_float(struct multi_context *m, s=
truct multi_instance *mi, struct link_socket *sock)</span><br><span> {</spa=
n><br><span>     struct mroute_addr real =3D { 0 };</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D =
gc_new();</span><br><span> </span><br><span>     if (mi-&gt;real=2Etype &am=
p; MR_WITH_PROTO)</span><br><span>     {</span><br><span>@@ -3090,53 +3158,=
16 @@</span><br><span> </span><br><span>     if (!mroute_extract_openvpn_so=
ckaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true))</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto d=
one;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const uint64_t hv =3D hash_value(hash, &amp;real);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash_bucket=
 *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
make sure that we don&#39;t float to an address taken by another client */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash_elemen=
t *he =3D hash_lookup_fast(hash, bucket, &amp;real, hv);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (he)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!multi_check_dest_addr_allowed(m, mi, &a=
mp;real))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        struct multi_instance *ex_mi =3D (struct multi_instance =
*)he-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct tls_multi *m=
1 =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        struct tls_multi *m2 =3D ex_mi-&gt;context=2Ec2=2E=
tls_multi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        /* do not float if targe=
t address is taken by client with another cert */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (!cert_hash_compare(m1-&gt;locked_ce=
rt_hash_set, m2-&gt;locked_cert_hash_set))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            msg(D_MULTI_LOW, &quot;Disallow float to an address ta=
ken by another client %s&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                multi_instance_string(ex_mi, false, &amp;gc));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;context=2Ec2=2Ebuf=2Elen=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            goto done;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        /* It doesn&#39;t make sense to let a peer float to the add=
ress it already</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   * has, so we disallow it=2E This can happen if a DCO netlink notificatio=
n</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * gets lost=
 and we miss a floating step=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(M_WARN,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                &quot;disallowing peer %&quot; PRIu=
32 &quot; (%s) from floating to &quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                &quot;its own address (%s)&quot;,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                m1-&gt;rx_peer=
_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                mroute_addr_print(&=
amp;mi-&gt;real, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            goto done;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_LOW,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;closi=
ng instance %s due to float collision with %s &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            &quot;using the same certificat=
e&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
ulti_instance_string(ex_mi, false, &amp;gc), multi_instance_string(mi, fals=
e, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
multi_close_instance(m, ex_mi, false);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        return;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     msg(D_MULTI_MEDIUM, &quot;peer %&quot; PRIu32 &quot; (%=
s) floated from %s to %s&quot;,</span><br><span>         mi-&gt;context=2Ec=
2=2Etls_multi-&gt;rx_peer_id,</span><br><span>         tls_common_name(mi-&=
gt;context=2Ec2=2Etls_multi, false),</span><br><span>@@ -3165,7 +3196,6 @@<=
/span><br><span>     ASSERT(hash_add(m-&gt;cid_hash, &amp;mi-&gt;context=2E=
c2=2Emda_context=2Ecid, mi, true));</span><br><span> #endif</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-done:</span><br><sp=
an>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1723?usp=3Demail">change 1723</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c6=
13dcd1a94e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1723 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D=
"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--3aLuEh8rBQg=--


--===============5042704298872071213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5042704298872071213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5042704298872071213==--

