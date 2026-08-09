Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80227C5AD4E
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AiX2PVLCgTjqG3S01yM48JE/APTN4JKaQ5M0PQ/ZCcg=; b=G+83dHvwE7TXrifHqzy6I2OyOT
	gXjj1JRA00LkjXWzRsx8nnXY2xRLjQpH5ZfVnJLduI8MT7rOY9z4NzxA/FIRvL5+NG85Q8PcPqZ89
	JlssGeUSAKVv/F3KyRf26yOyl7yaKAasTHQLmHtzAdCaNeNRqUaum9r0ynUQFiN3hCrs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wt2YT-00059H-Ec;
	Sun, 09 Aug 2026 12:23:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wt2YS-00059B-CI
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 12:23:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=w4iabDZa887LETBEeSyjcU3r0OWilH/d8eqzMjcPjXM=; b=OhzxreCnIkS/3eYDhoO2+3FGqS
 IcP8JzEh+ZR19/GDURIEPDYEwKVaO5yyNjntj2S2GTYtmclwFxoSlbHuueDVHF6/u53vui2DLi05t
 PxXEmYWKdqR2ikcVIRjj24cgqjS2kJOcrfZEn5SsaQ+jWWa+/hff2rulxdGkXxzcHsto=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=w4iabDZa887LETBEeSyjcU3r0OWilH/d8eqzMjcPjXM=; b=Y
 eD/AMl2dnd59zCCxxsI3JgErJpEcJ8Ev3Qxqx+c2semsCKfh9uAxzINx8NL82fxDTUorNshCHnzwA
 4bfFd5i/RK/wn76xuCwRQ0u8WYpxMv+vOEesRnvN3QFAkMJsJTKblPz9E4XtzR64yjHtKSKXHZ0WH
 1BpP7UhFwgW9xZ3s=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wt2YU-0005pQ-Fs for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 12:23:04 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso7049825e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 09 Aug 2026 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786278176; x=1786882976; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w4iabDZa887LETBEeSyjcU3r0OWilH/d8eqzMjcPjXM=;
 b=B0XVknNC9I/IuCCMRUtpP06UloupJOe2RDQI15VF8YPV97+C5FCiMNLWzZnPCoafmj
 c0Oi4oSFHnxuk7G5GyCrFdbhDA0dVFDMZNxu3/oZXCLiseNjJiy2Cq7EXXpC9RAnLueF
 Zj8kPS24fUzwrBuJgWxjB2SnBuG8Yw8IxTlvWBn1cYLK6NoWjsxVoFXfwZVdwdAfSHzn
 BqCPPXLlZD5MFUlaVw1E9plFQXrfCqA0iMdGWMYgXwqmBlA36gIusTRj44Jq1cp0gSsl
 BLdyzWeHwxRvrzG8TKMnJuI2k1GaZcXs+CHxSxJYqQ2tPzF5yQg8CUtf7me7x1yxTNq+
 4+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786278176; x=1786882976;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w4iabDZa887LETBEeSyjcU3r0OWilH/d8eqzMjcPjXM=;
 b=V3p1K4TFyw6xKy8W3Vld1KPKyb2TZRXltWmx/6wtBqO/QmxeOzIXrNfMELWdLJy2YQ
 RkpqhA7ounrXFIBLTIwnMcWcPqh7Pkv2ui+BvCMACU57YmVEBcLym6rtlmwJkxaLD9UX
 q9hgVzhKU6fqPILQPn3KwJEm26x2f61I390XibI6ZOuhZLTconLNgHzGIFT8DNVUOEGo
 jV1/Ww7lJvnP5EKkDF883OS+h8cQ3m5GJlp479+mvgl6GIRNFv11ngJhjc3LlDX5thcb
 P3RGF72Z+kqyNeXV8P2Kzpe6HV+mU9rba6UNVznH57mprL2B60exYr/G9W1PO/ZbDAYl
 prIw==
X-Gm-Message-State: AOJu0YzH12vWLYa883mXfn8ft5HZQcLb6afKqnm82uGKd/VpBx6FEt05
 F/vf/TEksBw0QPHPm8ISDt1xAPXzOMGFEkGW02CSSZuqbCw7xs1Gmlwz0HZogRaEywCtK6BUs/D
 2V+uCOA76smC7D7JNjwIgPsMA9c/UKRRG7LgUFMFCGuY2MpWIUvxM2Uhyf10cOGKHWYHTXaDEb7
 CImRTnig==
X-Gm-Gg: AR+sD11nFPOudM/eYCSBtkuRoHZ6wPVdEvyTNTRmRDKPIZdV62LOTFEBIrcDHagfiE2
 pi+HFe5TaXXbUclgfKNQ1YQlAMnsCKl44FJKs6VDtt9yayLQW6V2XLWfK4EQ83tzIiqMXyCuIVE
 ARDkYPGZZPf9Zo2ccyDQlO4SvtuseKnDoS2OjO8QAbkjm1EsIxvTfKfmy2ZWVgaG9lMi9rH090J
 AuvmSdYivETWBLP+wZiYsE0bCJdYC5CHx3YiBnGWaI95bKqynLPmCMgHzEtYsPk8zWdy4eUhmcf
 N4jBhAaIUhz1IXbBViZx33BvSi7hwzjol72YRqkrC3vF+b9GshLlCpCysqwizNifvhcBQAAlfJD
 QhEUVOLblbNtFJpze7FnqKJeJPImkMB7kumAmjAwc7MFLejG2O4BXKHornvaOC5WoazZiYRy2SM
 2NgkhHa+8B/J/i/5O8pPSvvxLm7r/EUmJskCF6nvVlj9jR2LIespKKah7biKew4XHTopwBj0mDr
 L+MyA4014pprBzZjxhMhR8JYLQb4Us1DBfBo/uoUf7LSorpm7RvQ9fqMiLvMikaHdXI905X92HZ
 zgihTS0TKayI1h1KdMOPU4USMoVKUuRNgdoBtbMYUgS1bp2xUBI=
X-Received: by 2002:a05:600c:1553:b0:495:3da3:beb with SMTP id
 5b1f17b1804b1-4995e0d0182mr205214475e9.10.1786278176094; 
 Sun, 09 Aug 2026 05:22:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e8d50sm22600805f8f.24.2026.08.09.05.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 05:22:55 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 9 Aug 2026 12:22:52 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: fdff1c41dfff6d1233df5e638c0e31a7db99dfb6
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a4e0bb289405cb7998923de406e0aa77b7ee58cd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wt2YU-0005pQ-Fs
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
Content-Type: multipart/mixed; boundary="===============2729478296158935681=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2729478296158935681==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MfTfyaIjAOU="; charset=UTF-8

--MfTfyaIjAOU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#20) to the change originally created b=
y plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail=
 )

The following approvals got outdated and were removed:
Code-Review+2 by=
 flichtenheld


Change subject: Extract multi_check_dest_addr_allowed from =
multi_process_float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Extract multi_check_dest_addr_allowed from multi_process_float

Cha=
nge-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
Signed-off-by: Arne Schwa=
be <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723
Message-Id: =
<20260731100758=2E3368-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38094=2Ehtml
Signed=
-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/multi=2Ec=

1 file changed, 75 insertions(+), 45 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/1723/20

diff --git a/src/o=
penvpn/multi=2Ec b/src/openvpn/multi=2Ec
index cfa2ad8=2E=2Ef5a18f7 100644
=
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3068,6 +3068,76=
 @@
 }
 
 /**
+ * This methods checks if a client instance is allowed to us=
e an address
+ *
+ * Reasons for disallowing a specific address are that a =
client might be
+ * already using that address=2E In that case the method n=
eeds to decide
+ * if this instance can kick out the other instance=2E
+ *
=
+ * The method will then terminate the other instance if that check was
+ *=
 positive=2E
+ */
+static bool
+multi_check_dest_addr_allowed(struct multi_=
context *m, struct multi_instance *mi, struct mroute_addr *real)
+{
+    st=
ruct hash *hash =3D m->hash;
+    const uint64_t hv =3D hash_value(hash, re=
al);
+    struct hash_bucket *bucket =3D hash_bucket(hash, hv);
+
+    /* m=
ake sure that we don't assign the client to an address taken by
+     * ano=
ther client */
+    struct hash_element *he =3D hash_lookup_fast(hash, buck=
et, real, hv);
+    if (!he)
+    {
+        /* Address is not taken, every=
thing is fine=2E */
+        return true;
+    }
+
+    struct multi_instan=
ce *ex_mi =3D he->value;
+
+    struct tls_multi *m1 =3D mi->context=2Ec2=
=2Etls_multi;
+    struct tls_multi *m2 =3D ex_mi->context=2Ec2=2Etls_multi=
;
+
+    struct gc_arena gc =3D gc_new();
+    int ret =3D false;
+
+    /*=
 do not allow if target address is taken by client with another cert */
+  =
  if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set=
))
+    {
+        msg(D_MULTI_LOW, "Disallow float to an address taken by =
another client %s",
+            multi_instance_string(ex_mi, false, &gc));=

+
+        mi->context=2Ec2=2Ebuf=2Elen =3D 0;
+        goto done;
+    }
=
+
+    /* It doesn't make sense to let a peer float to the address it alrea=
dy
+     * has, so we disallow it=2E This can happen if a DCO netlink notif=
ication
+     * gets lost and we miss a floating step=2E
+     */
+    if (=
m1->rx_peer_id =3D=3D m2->rx_peer_id)
+    {
+        msg(M_WARN,
+        =
    "disallowing peer %" PRIu32 " (%s) from floating to "
+            "its=
 own address (%s)",
+            m1->rx_peer_id, tls_common_name(mi->contex=
t=2Ec2=2Etls_multi, false),
+            mroute_addr_print(&mi->real, &gc))=
;
+        goto done;
+    }
+
+    msg(D_MULTI_LOW,
+        "closing inst=
ance %s due to float collision with %s "
+        "using the same certifica=
te",
+        multi_instance_string(ex_mi, false, &gc), multi_instance_stri=
ng(mi, false, &gc));
+    multi_close_instance(m, ex_mi, false);
+    ret =
=3D true;
+
+done:
+    gc_free(&gc);
+    return ret;
+}
+
+/**
  * Handle=
s peer floating=2E
  *
  * If peer is floated to a taken address, either dr=
ops packet
@@ -3079,8 +3149,6 @@
 multi_process_float(struct multi_context =
*m, struct multi_instance *mi, struct link_socket *sock)
 {
     struct mro=
ute_addr real =3D { 0 };
-    struct hash *hash =3D m->hash;
-    struct gc=
_arena gc =3D gc_new();
 
     if (mi->real=2Etype & MR_WITH_PROTO)
     {
=
@@ -3090,53 +3158,16 @@
 
     if (!mroute_extract_openvpn_sockaddr(&real, =
&m->top=2Ec2=2Efrom=2Edest, true))
     {
-        goto done;
+        retu=
rn;
     }
 
-    const uint64_t hv =3D hash_value(hash, &real);
-    struc=
t hash_bucket *bucket =3D hash_bucket(hash, hv);
-
-    /* make sure that w=
e don't float to an address taken by another client */
-    struct hash_ele=
ment *he =3D hash_lookup_fast(hash, bucket, &real, hv);
-    if (he)
+    i=
f (!multi_check_dest_addr_allowed(m, mi, &real))
     {
-        struct mul=
ti_instance *ex_mi =3D (struct multi_instance *)he->value;
-
-        struc=
t tls_multi *m1 =3D mi->context=2Ec2=2Etls_multi;
-        struct tls_multi=
 *m2 =3D ex_mi->context=2Ec2=2Etls_multi;
-
-        /* do not float if tar=
get address is taken by client with another cert */
-        if (!cert_hash=
_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
-        {
- =
           msg(D_MULTI_LOW, "Disallow float to an address taken by another =
client %s",
-                multi_instance_string(ex_mi, false, &gc));
-
-=
            mi->context=2Ec2=2Ebuf=2Elen =3D 0;
-
-            goto done;
-=
        }
-
-        /* It doesn't make sense to let a peer float to the ad=
dress it already
-         * has, so we disallow it=2E This can happen if a=
 DCO netlink notification
-         * gets lost and we miss a floating step=
=2E
-         */
-        if (m1->rx_peer_id =3D=3D m2->rx_peer_id)
-      =
  {
-            msg(M_WARN,
-                "disallowing peer %" PRIu32 "=
 (%s) from floating to "
-                "its own address (%s)",
-        =
        m1->rx_peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, false=
),
-                mroute_addr_print(&mi->real, &gc));
-            goto d=
one;
-        }
-
-        msg(D_MULTI_LOW,
-            "closing instance =
%s due to float collision with %s "
-            "using the same certificat=
e",
-            multi_instance_string(ex_mi, false, &gc), multi_instance_s=
tring(mi, false, &gc));
-        multi_close_instance(m, ex_mi, false);
+  =
      return;
     }
 
+    struct gc_arena gc =3D gc_new();
+
     msg(D_M=
ULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
         mi->co=
ntext=2Ec2=2Etls_multi->rx_peer_id,
         tls_common_name(mi->context=2E=
c2=2Etls_multi, false),
@@ -3165,7 +3196,6 @@
     ASSERT(hash_add(m->cid_h=
ash, &mi->context=2Ec2=2Emda_context=2Ecid, mi, true));
 #endif
 
-done:
  =
   gc_free(&gc);
 }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1723?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
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

--MfTfyaIjAOU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #20</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Extract multi_check_=
dest_addr_allowed from multi_process_float<br><br>Change-Id: I3d52c6d008502=
293c3ec57ad22d1c613dcd1a94e<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=
=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<b=
r>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723<br>Message-Id=
: &lt;20260731100758=2E3368-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38094=2E=
html<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<=
br>M src/openvpn/multi=2Ec<br>1 file changed, 75 insertions(+), 45 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/23/1723/20</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec=
 b/src/openvpn/multi=2Ec</span><br><span>index cfa2ad8=2E=2Ef5a18f7 100644<=
/span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openv=
pn/multi=2Ec</span><br><span>@@ -3068,6 +3068,76 @@</span><br><span> }</spa=
n><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * This methods checks if a client instance is allowed to us=
e an address</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reasons for disallowi=
ng a specific address are that a client might be</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * already using that address=2E In that case =
the method needs to decide</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * if this instance can kick out the other instance=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * The method will then terminate the other instan=
ce if that check was</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * positive=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_dest_addr_allowe=
d(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *r=
eal)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct hash *hash =3D m-&gt;h=
ash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint6=
4_t hv =3D hash_value(hash, real);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct hash_bucket *bucket =3D hash_bucket(hash, hv);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* make sure that we don&#39;t assign=
 the client to an address taken by</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * another client */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct hash_element *he =3D hash_lookup_fast(hash, =
bucket, real, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!he)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Address is =
not taken, everything is fine=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi=
_instance *ex_mi =3D he-&gt;value;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct tls_multi *m1 =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *m2 =3D ex_mi-&g=
t;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int ret =3D false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* do =
not allow if target address is taken by client with another cert */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!cert_hash_compare(=
m1-&gt;locked_cert_hash_set, m2-&gt;locked_cert_hash_set))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;Disallow float to a=
n address taken by another client %s&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            multi_instance_string(ex_mi, false, &am=
p;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Ec2=2Eb=
uf=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* It doesn&#39;t make sense to le=
t a peer float to the address it already</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * has, so we disallow it=2E This can happen if a =
DCO netlink notification</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * gets lost and we miss a floating step=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;disallowing peer =
%&quot; PRIu32 &quot; (%s) from floating to &quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            &quot;its own address (%s)&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m1-&gt=
;rx_peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            mroute_addr_p=
rint(&amp;mi-&gt;real, &amp;gc));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        goto done;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_MULTI_LOW,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;closi=
ng instance %s due to float collision with %s &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &quot;using the same certificate&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi=
_instance_string(ex_mi, false, &amp;gc), multi_instance_string(mi, false, &=
amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_=
close_instance(m, ex_mi, false);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ret =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+done:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span>  * Handles peer floating=2E</span><br><=
span>  *</span><br><span>  * If peer is floated to a taken address, either =
drops packet</span><br><span>@@ -3079,8 +3149,6 @@</span><br><span> multi_p=
rocess_float(struct multi_context *m, struct multi_instance *mi, struct lin=
k_socket *sock)</span><br><span> {</span><br><span>     struct mroute_addr =
real =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span> </span><br>=
<span>     if (mi-&gt;real=2Etype &amp; MR_WITH_PROTO)</span><br><span>    =
 {</span><br><span>@@ -3090,53 +3158,16 @@</span><br><span> </span><br><spa=
n>     if (!mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=
=2Efrom=2Edest, true))</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        goto done;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const uint64_=
t hv =3D hash_value(hash, &amp;real);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct hash_bucket *bucket =3D hash_bucket(hash, hv);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* make sure that we don&#39;t float to=
 an address taken by another client */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct hash_element *he =3D hash_lookup_fast(hash, buc=
ket, &amp;real, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (he)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
multi_check_dest_addr_allowed(m, mi, &amp;real))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct multi_inst=
ance *ex_mi =3D (struct multi_instance *)he-&gt;value;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        struct tls_multi *m1 =3D mi-&gt;context=2Ec2=2Etls_mult=
i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct tls_=
multi *m2 =3D ex_mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* do not float if target address is taken by client with an=
other cert */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (!cert_hash_compare(m1-&gt;locked_cert_hash_set, m2-&gt;locked_cert_hash=
_set))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW=
, &quot;Disallow float to an address taken by another client %s&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                multi_inst=
ance_string(ex_mi, false, &amp;gc));</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            goto done;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        /* It doesn&#39;t make=
 sense to let a peer float to the address it already</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * has, so we disallow it=2E This c=
an happen if a DCO netlink notification</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-         * gets lost and we miss a floating step=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (m1-&gt;rx_peer_id =3D=3D =
m2-&gt;rx_peer_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg=
(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   &quot;disallowing peer %&quot; PRIu32 &quot; (%s) from floating to &quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quo=
t;its own address (%s)&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                m1-&gt;rx_peer_id, tls_common_name(mi-&gt;context=
=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            goto done;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        msg(D_MULTI_LOW,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            &quot;closing instance %s due to float collisi=
on with %s &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        &quot;using the same certificate&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            multi_instance_string(ex_mi, false, &=
amp;gc), multi_instance_string(mi, false, &amp;gc));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        multi_close_instance(m, ex_mi, fals=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     msg(D_MULTI_MED=
IUM, &quot;peer %&quot; PRIu32 &quot; (%s) floated from %s to %s&quot;,</sp=
an><br><span>         mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id,</span=
><br><span>         tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false)=
,</span><br><span>@@ -3165,7 +3196,6 @@</span><br><span>     ASSERT(hash_ad=
d(m-&gt;cid_hash, &amp;mi-&gt;context=2Ec2=2Emda_context=2Ecid, mi, true));=
</span><br><span> #endif</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-done:</span><br><span>     gc_free(&amp;gc);</span><br=
><span> }</span><br><span> </span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail">=
change 1723</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1723 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--MfTfyaIjAOU=--


--===============2729478296158935681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2729478296158935681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2729478296158935681==--

