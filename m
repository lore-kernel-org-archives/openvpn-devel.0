Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B5EC531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fq4kuUyPYjIcCtAksPq3YNOvGlmI9gFmdlx55TaLzXA=; b=jeSYph90VnJ9pGAhlyXsRkDrS9
	vMG8xpuo2FMahpqa0UWUUHS03mrpA8btYD8lpPtDAguTqEEigQusUqTPqGzfhb8ru47oqDj6RW/wg
	I+HaSd97vzGsdu8c5CZg6E5mFdUTYGQFg7VbInOINegni9UkLxRM8pnAAdTiHzpEMh4c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnINr-00069B-Un;
	Fri, 24 Jul 2026 16:04:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnINq-000694-Lc
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:04:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nafhy0U9Lr/VXPqaudWi27e1MumjY6/xo+Rs7d3csTs=; b=fRn+w6AngjKkd5o6JKHZHFwj9H
 t9ot8flzi22K1rVABLvtBioxKCs/CFiLIUZxbsHAVXBmNNpsBuQENNtdJthklUglhOIrDTQaz1nfP
 HZTdoQr/hTavQtCRMChLled4r+/55B9szkW0lUfU3Fl7JetjqsUlzsmNSGIyupbkoqnU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nafhy0U9Lr/VXPqaudWi27e1MumjY6/xo+Rs7d3csTs=; b=I
 fzns43vmBHoLWaRkjs/6t9rPFyuQEXfeVdn5gtN3fba8GJx0PbQ3WWnC852Kf1ZarTZyPTjTfAED6
 j9uNHpejQnFOvRcdUI59TBiqgyVivkB++DumrSFfKL6S9W/yhZPxEltPRfw/v5m9/smwRRsenCN9r
 VWV83iyIDIuIwIpY=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnINm-0000kw-Jb for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:04:20 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so5611235e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784909052; x=1785513852; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nafhy0U9Lr/VXPqaudWi27e1MumjY6/xo+Rs7d3csTs=;
 b=eUC90Z+vEkgcYgW3mfbQ6npxhs1GqmhoGwlyXkFn2qQilgljA8YmkLXIg/3rl42j6T
 jP6FZOmSf+GS2f7HeYN25BnmRv29ZfRuH3biUnIz42Nis09HUIJKODzC6os7ZdOY71X5
 6dw0Tnmr9b4gzHHwnh9TVdeLmHYregqfmdei0/7jHlwR891ED5utqvhIMK30TMDyiftN
 PXJlgJUgXiCxtqo5lQxmv51e/2GIdJbN8GiEZ3zwF34kAyimC2HzLajwYRb43xfFd9Cr
 zTUAN2YZ839nQrHpMqbR0m32V7xD09kmherGg17KQWlzyzHQvCbC0hwc3jV63pfeoWIP
 axuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784909052; x=1785513852;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nafhy0U9Lr/VXPqaudWi27e1MumjY6/xo+Rs7d3csTs=;
 b=FMcnG2abvVeqUOUFp6VOgnqotEzPAEZgvwXtD6lq8o+4M6TYUKoKPuFv/S+h+Og4KK
 HzsQy3nZWdWR3PkDsR6lYiHXStEfC8Ss880MJVaAnExpAPNIGkSQS9aD5YHActmTKBPG
 UDxV82V/ZfQlTAZAR2SEhXLDkJI1y4YZUXwplepIMOE3jh/dnZkP4zxy98mt1BmWiFbj
 RGh6N/gAFvKVyNZ2FKweuZXVHOTk0SwFVpRSMV0P8fQmxKEX5jhoPRIpVucRYzM1CBfM
 6v6dp1xr33x5Gb35FFnxs8EajReBnqAp8i1/U9pyk3TY3AaKIC32Qz9RYw/5SJHtC1h+
 XtmA==
X-Gm-Message-State: AOJu0YzD35NJBezlCgNK+fTOzQwmjA/Q6VgJZw0Lll1BRFkmxr/zZryr
 oUewb6lx9l4o3Lyq+8s325URHeQCl4CNxnIzqs56+J3COqJtY4/vtILmkn77CXO1F+SqxzdRwNw
 sXRc+utaUbbTjTG8a8UMG46DslMdmPX60Gr6W2KIsoNQ9jmorfaPnOmBgUtNeqGJzu3B5jt+RPv
 UcmgNjQA==
X-Gm-Gg: AR+sD100IrwupDRz2nb4hmHC75xrAxPk6eDFktw+VrtpOEMR5058TYjInJDAdmPv7AZ
 ZInV6mxBzvnJ3Zr0eVuRBW4zPoWgfPOvb1lmOHYjk1M5NlLETGbDpwp8bQAwg2TMyLUKqIbblxj
 vs49Kcj4ZNjm2t3euS5DbQtDXMYYc6t+cHIAnbsf1fZ7eHGBdkTWHpRlVTFirWkh0AouLA6QYX5
 VQL4kZSt6ucV0moIG+k5nG80dS5g8uvP7LRJDNWxb+wbY4HuDz3K8BngdCho9zjIuSSlxWnEt/J
 Rn4P1uYA3PHsCdqS4xSdKmNtfNK2QbHY+uoWeomCntTXbK4WQTvu3aKyAgkqrSwZeyk4utSf1Pe
 hQpD4nHcMJcSxogJlp6fW6/ge+yZTMj0rGUXiAIpngGR0cOXocu3gOJQ8wPjiNTHklxvdLi0d2R
 0lTEcQSwfYGQbynityd1InOKHrYj1snh2hD7zpDUWN/P3gDsZAHBXzKDL1JkqB25T+UnuNDrKKT
 y987gzPxtIlWdrIG8As5c1Zx8E/gMJ1Le1mo2gU+3GlRIZdoVPu7rotbZQEpWEf6Kj8
X-Received: by 2002:a05:600c:350f:b0:495:6f6b:127 with SMTP id
 5b1f17b1804b1-49573cb9f95mr94487835e9.6.1784909051810; 
 Fri, 24 Jul 2026 09:04:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b487a3f0sm615355e9.13.2026.07.24.09.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:04:11 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:04:03 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: 2d3736eddf9723f62fefaffe0853c35e97efe297
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0524d037b1b3d2091354550a7f69f32552c520f4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnINm-0000kw-Jb
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6179467405476240835=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6179467405476240835==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ow+wHPskki8="; charset=UTF-8

--Ow+wHPskki8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1723?usp=3Demail

to look at the new patch set (#8)=
=2E

The change is no longer submittable: checks~ChecksSubmitRule is unsati=
sfied now=2E


Change subject: Extract multi_check_dest_addr_allowed from m=
ulti_process_float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Extract multi_check_dest_addr_allowed from multi_process_float

Cha=
nge-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
Signed-off-by: Arne Schwa=
be <arne@rfc2549=2Eorg>
---
M src/openvpn/multi=2Ec
1 file changed, 75 inse=
rtions(+), 45 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/23/1723/8

diff --git a/src/openvpn/multi=2Ec b/src/op=
envpn/multi=2Ec
index 925431b=2E=2Eaf2b1c5 100644
--- a/src/openvpn/multi=
=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3072,6 +3072,76 @@
 }
 
 /**
+ * This =
methods checks if a client instance is allowed to use an address
+ *
+ * Re=
asons for disallowing a specific address are that a client might be
+ * alr=
eady using that address=2E In that case the method needs to decide
+ * if t=
his instance can kick out the other instance=2E
+ *
+ * The method will the=
n terminate the other instance if that check was
+ * positive=2E
+ */
+stat=
ic bool
+multi_check_dest_addr_allowed(struct multi_context *m, struct mult=
i_instance *mi, struct mroute_addr *real)
+{
+    struct hash *hash =3D m->=
hash;
+    const uint64_t hv =3D hash_value(hash, real);
+    struct hash_b=
ucket *bucket =3D hash_bucket(hash, hv);
+
+    /* make sure that we don't =
assign the client to an address taken by
+     * another client */
+    str=
uct hash_element *he =3D hash_lookup_fast(hash, bucket, real, hv);
+    if =
(!he)
+    {
+        /* Address is not taken, everything is fine=2E */
+  =
      return true;
+    }
+
+    struct multi_instance *ex_mi =3D he->value=
;
+
+    struct tls_multi *m1 =3D mi->context=2Ec2=2Etls_multi;
+    struct=
 tls_multi *m2 =3D ex_mi->context=2Ec2=2Etls_multi;
+
+    struct gc_arena =
gc =3D gc_new();
+    int ret =3D false;
+
+    /* do not allow if target a=
ddress is taken by client with another cert */
+    if (!cert_hash_compare(=
m1->locked_cert_hash_set, m2->locked_cert_hash_set))
+    {
+        msg(D_=
MULTI_LOW, "Disallow float to an address taken by another client %s",
+    =
        multi_instance_string(ex_mi, false, &gc));
+
+        mi->context=
=2Ec2=2Ebuf=2Elen =3D 0;
+        goto done;
+    }
+
+    /* It doesn't ma=
ke sense to let a peer float to the address it already
+     * has, so we d=
isallow it=2E This can happen if a DCO netlink notification
+     * gets lo=
st and we miss a floating step=2E
+     */
+    if (m1->rx_peer_id =3D=3D m=
2->rx_peer_id)
+    {
+        msg(M_WARN,
+            "disallowing peer %=
" PRIu32 " (%s) from floating to "
+            "its own address (%s)",
+  =
          m1->rx_peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, fal=
se),
+            mroute_addr_print(&mi->real, &gc));
+        goto done;
+=
    }
+
+    msg(D_MULTI_LOW,
+        "closing instance %s due to float co=
llision with %s "
+        "using the same certificate",
+        multi_ins=
tance_string(ex_mi, false, &gc), multi_instance_string(mi, false, &gc));
+ =
   multi_close_instance(m, ex_mi, false);
+    ret =3D true;
+
+done:
+    =
gc_free(&gc);
+    return ret;
+}
+
+/**
  * Handles peer floating=2E
  *
 =
 * If peer is floated to a taken address, either drops packet
@@ -3083,8 +3=
153,6 @@
 multi_process_float(struct multi_context *m, struct multi_instanc=
e *mi, struct link_socket *sock)
 {
     struct mroute_addr real =3D { 0 };=

-    struct hash *hash =3D m->hash;
-    struct gc_arena gc =3D gc_new();
=
 
     if (mi->real=2Etype & MR_WITH_PROTO)
     {
@@ -3094,53 +3162,16 @@
=
 
     if (!mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Ede=
st, true))
     {
-        goto done;
+        return;
     }
 
-    const =
uint64_t hv =3D hash_value(hash, &real);
-    struct hash_bucket *bucket =
=3D hash_bucket(hash, hv);
-
-    /* make sure that we don't float to an ad=
dress taken by another client */
-    struct hash_element *he =3D hash_look=
up_fast(hash, bucket, &real, hv);
-    if (he)
+    if (!multi_check_dest_a=
ddr_allowed(m, mi, &real))
     {
-        struct multi_instance *ex_mi =3D=
 (struct multi_instance *)he->value;
-
-        struct tls_multi *m1 =3D mi=
->context=2Ec2=2Etls_multi;
-        struct tls_multi *m2 =3D ex_mi->contex=
t=2Ec2=2Etls_multi;
-
-        /* do not float if target address is taken b=
y client with another cert */
-        if (!cert_hash_compare(m1->locked_ce=
rt_hash_set, m2->locked_cert_hash_set))
-        {
-            msg(D_MULTI=
_LOW, "Disallow float to an address taken by another client %s",
-         =
       multi_instance_string(ex_mi, false, &gc));
-
-            mi->contex=
t=2Ec2=2Ebuf=2Elen =3D 0;
-
-            goto done;
-        }
-
-        /=
* It doesn't make sense to let a peer float to the address it already
-    =
     * has, so we disallow it=2E This can happen if a DCO netlink notificat=
ion
-         * gets lost and we miss a floating step=2E
-         */
-    =
    if (m1->rx_peer_id =3D=3D m2->rx_peer_id)
-        {
-            msg(M=
_WARN,
-                "disallowing peer %" PRIu32 " (%s) from floating to=
 "
-                "its own address (%s)",
-                m1->rx_peer_id=
, tls_common_name(mi->context=2Ec2=2Etls_multi, false),
-                mr=
oute_addr_print(&mi->real, &gc));
-            goto done;
-        }
-
-   =
     msg(D_MULTI_LOW,
-            "closing instance %s due to float collis=
ion with %s "
-            "using the same certificate",
-            multi=
_instance_string(ex_mi, false, &gc), multi_instance_string(mi, false, &gc))=
;
-        multi_close_instance(m, ex_mi, false);
+        return;
     }
 =

+    struct gc_arena gc =3D gc_new();
+
     msg(D_MULTI_MEDIUM, "peer %" =
PRIu32 " (%s) floated from %s to %s",
         mi->context=2Ec2=2Etls_multi=
->rx_peer_id,
         tls_common_name(mi->context=2Ec2=2Etls_multi, false)=
,
@@ -3169,7 +3200,6 @@
     ASSERT(hash_add(m->cid_hash, &mi->context=2Ec2=
=2Emda_context=2Ecid, mi, true));
 #endif
 
-done:
     gc_free(&gc);
 }
 
=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d52c6d0085022=
93c3ec57ad22d1c613dcd1a94e
Gerrit-Change-Number: 1723
Gerrit-PatchSet: 8
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--Ow+wHPskki8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #8</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><p>The change is no=
 longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Extract multi_check_dest_addr_allowed from multi_process_float<br>=
<br>Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e<br>Signed-off-by: =
Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/multi=2Ec<b=
r>1 file changed, 75 insertions(+), 45 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/172=
3/8</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</spa=
n><br><span>index 925431b=2E=2Eaf2b1c5 100644</span><br><span>--- a/src/ope=
nvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>=
@@ -3072,6 +3072,76 @@</span><br><span> }</span><br><span> </span><br><span=
> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This method=
s checks if a client instance is allowed to use an address</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Reasons for disallowing a specific address are tha=
t a client might be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * already using that address=2E In that case the method needs to decide</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * if this instance ca=
n kick out the other instance=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * T=
he method will then terminate the other instance if that check was</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * positive=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+multi_check_dest_addr_allowed(struct multi_context *m, st=
ruct multi_instance *mi, struct mroute_addr *real)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct hash *hash =3D m-&gt;hash;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(hash, r=
eal);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct has=
h_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* make sure that we don&#39;t assign the client to an address tak=
en by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * another=
 client */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t hash_element *he =3D hash_lookup_fast(hash, bucket, real, hv);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!he)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* Address is not taken, everything is fine=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct multi_instance *ex_mi =3D he-&gt;v=
alue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *m1 =3D mi-&=
gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct tls_multi *m2 =3D ex_mi-&gt;context=2Ec2=2Etls_multi;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* do not allow if target address i=
s taken by client with another cert */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!cert_hash_compare(m1-&gt;locked_cert_hash_set, =
m2-&gt;locked_cert_hash_set))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(D_MULTI_LOW, &quot;Disallow float to an address taken by another cl=
ient %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       multi_instance_string(ex_mi, false, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* It doesn&#39;t make sense to let a peer float to the address=
 it already</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * h=
as, so we disallow it=2E This can happen if a DCO netlink notification</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * gets lost and we =
miss a floating step=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(M_WARN,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            &quot;disallowing peer %&quot; PRIu32 &quot; (%s) fro=
m floating to &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            &quot;its own address (%s)&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            m1-&gt;rx_peer_id, tls_common_name(m=
i-&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            mroute_addr_print(&amp;mi-&gt;real, &amp;gc=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto don=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(D_MULTI_LOW,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        &quot;closing instance %s due to float co=
llision with %s &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &quot;using the same certificate&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        multi_instance_string(ex_mi, false, =
&amp;gc), multi_instance_string(mi, false, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi_close_instance(m, ex_mi, false)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an>  * Handles peer floating=2E</span><br><span>  *</span><br><span>  * If =
peer is floated to a taken address, either drops packet</span><br><span>@@ =
-3083,8 +3153,6 @@</span><br><span> multi_process_float(struct multi_contex=
t *m, struct multi_instance *mi, struct link_socket *sock)</span><br><span>=
 {</span><br><span>     struct mroute_addr real =3D { 0 };</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc=
 =3D gc_new();</span><br><span> </span><br><span>     if (mi-&gt;real=2Etyp=
e &amp; MR_WITH_PROTO)</span><br><span>     {</span><br><span>@@ -3094,53 +=
3162,16 @@</span><br><span> </span><br><span>     if (!mroute_extract_openv=
pn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        g=
oto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn;</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    const uint64_t hv =3D hash_value(hash, &amp;re=
al);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash_b=
ucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  /* make sure that we don&#39;t float to an address taken by another clien=
t */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash_e=
lement *he =3D hash_lookup_fast(hash, bucket, &amp;real, hv);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (he)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!multi_check_dest_addr_allowed(m,=
 mi, &amp;real))</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct multi_instance *ex_mi =3D (struct multi_in=
stance *)he-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct tls_m=
ulti *m1 =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        struct tls_multi *m2 =3D ex_mi-&gt;context=
=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* do not float =
if target address is taken by client with another cert */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (!cert_hash_compare(m1-&gt;l=
ocked_cert_hash_set, m2-&gt;locked_cert_hash_set))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            msg(D_MULTI_LOW, &quot;Disallow float to an ad=
dress taken by another client %s&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                multi_instance_string(ex_mi, false, &amp;=
gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;context=2Ec2=2Ebuf=
=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            goto done;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        /* It doesn&#39;t make sense to let a peer float to t=
he address it already</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
         * has, so we disallow it=2E This can happen if a DCO netlink notif=
ication</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * get=
s lost and we miss a floating step=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            msg(M_WARN,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                &quot;disallowing peer %&qu=
ot; PRIu32 &quot; (%s) from floating to &quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                &quot;its own address (%s)&quot;,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m1-&gt=
;rx_peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                mroute_addr=
_print(&amp;mi-&gt;real, &amp;gc));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            goto done;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULT=
I_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &qu=
ot;closing instance %s due to float collision with %s &quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            &quot;using the same cer=
tificate&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      multi_instance_string(ex_mi, false, &amp;gc), multi_instance_string(m=
i, false, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       multi_close_instance(m, ex_mi, false);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     msg(D_MULTI_MEDIUM, &quot;peer %&quot; PRIu32 &q=
uot; (%s) floated from %s to %s&quot;,</span><br><span>         mi-&gt;cont=
ext=2Ec2=2Etls_multi-&gt;rx_peer_id,</span><br><span>         tls_common_na=
me(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span>@@ -3169,7 +320=
0,6 @@</span><br><span>     ASSERT(hash_add(m-&gt;cid_hash, &amp;mi-&gt;con=
text=2Ec2=2Emda_context=2Ecid, mi, true));</span><br><span> #endif</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-done:</span>=
<br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1723?usp=3Demail">change 1723</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d52c6d008502293c3ec57=
ad22d1c613dcd1a94e </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1723 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>

</body></html>
--Ow+wHPskki8=--


--===============6179467405476240835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6179467405476240835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6179467405476240835==--

