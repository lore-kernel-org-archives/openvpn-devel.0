Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E086BC55160
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g2kCLpaLrIC7oSP2s076//p0vQw2XlnNiLIbDSU5W3k=; b=arWkWcSTCgU+g37igcKgpihZt0
	EWMQ2bxK/XzgS422lu2CalbO6gUAJ4+voYUbU/hmE9fUGtU56puq7+DAbCXskpzn6DMitv54s1H8T
	nQVKrE72A5wG3xw82hHtF2E2TzppYNwpFdfGOGnKzSbfqAvCsb+WJmKdJ6XYVLkzl4Lc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpPUX-00066M-L3;
	Thu, 30 Jul 2026 12:04:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpPUW-000663-GI
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:04:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=btU3+FSOG9MLPvemL9p42+6k4N6huibqXasxHARBqhY=; b=NquUWruO89ItyB3dIXRvWQ92zn
 UxCDFATLFvLCIQjXdym6KSA03bEdmqvWWZKg9Civz50ZmCR+7Jn+MdGt+/ewxmAcQ0Eth6JjJKyWn
 cdq/TDs8TTm7rikbIOmGE/5fY/FnOTQRjI633NHKYVLaDFmag8PYSAl1adiAd8+w3dsw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=btU3+FSOG9MLPvemL9p42+6k4N6huibqXasxHARBqhY=; b=j
 NMFOPJntfirDX1knfzKItMNBeeuKgHCkVGpbhnxSyL4BLt+MPwASDXHxImdNrAdCKjnu3Gow+rSnl
 O09EXcbNdcflyAC6LsBPJKh9KBjC5ZZ3Q+d2+vJ85MDkX5c+ty3GSuvm65xnV/4kKe/RrHirYeQpO
 lYc7XYL3qfyVUXVM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpPUY-0006Es-FZ for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:04:01 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4956869750eso13760295e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785413032; x=1786017832; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=btU3+FSOG9MLPvemL9p42+6k4N6huibqXasxHARBqhY=;
 b=EW+vymEF7YY1Cl08BzFdI9lOaFoKfJARzGPHpxL4+jdAV8VAVIIVNk1Mv50O/mAuQh
 8DzUWkFI6dV+/dLeumT05LPTIiohTzm7DjXhc3WyAVfgFbjWgqM5M5/VhlkMdt3YE4Y/
 kNyZjuPxWrroLPqE0mkjwa1TaUNJJ2wMCbZT+m0FiPtDfE7GXs/V6YFHw8x1+B2yzoQF
 dXkcEExkxEb2mrR5xoYg2Qd2/fWbEO096d1RH3cyPIVHvXyXGRtPoLZBcUV1CJrci/HJ
 Bg5Ker2VdosgNJL2YH+s/uzbDMPiZF4oenhQEucvmemJRubNjMw0jXZ7VfsO1liiTN7G
 as1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785413032; x=1786017832;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=btU3+FSOG9MLPvemL9p42+6k4N6huibqXasxHARBqhY=;
 b=j16tJAeiAy7I/B2f2L6zJLr4qETuxZEN/5tcme/vq9pS9rL5GQ2zsRfOT3Ilv/d9AD
 P0a/XZwdGXZY8r+XJ4C6UnXxE0iFVhkOQRER3hHUtmMgd779zwAwTSUnQfp+M9xhmqvh
 FZw5ri7AFKrKkcIUnpCYryoqNA0frT6BlGFf0YXe5iEYBUjzmdKGLDXjxGgR6Yk4gbTV
 SiVpHAJQ74yae2LIodtbz4CRjT1xPqoPKb7eunCF7VHBdbas12w+0aVaqz/drU/XlnS8
 qpvWLNOnAvO/1IPi43xjwDcmB6g5Ehwp4AQZk40SBJ8vtShhS/iVZsIpbPqNJedJ7BUL
 DneQ==
X-Gm-Message-State: AOJu0Yz7ZGCdRwxH/2q/eDjBCIrpUCMlbOyXctsGVie6ik0TA4IEcs32
 CK5P/LHReAR9JSDChJphqgJX0jOK6oJ3YB1s8vxI/NRcUFoNoTDqJLjuM0M2qfPUGavgCYNxjDx
 /qZsUQp0p+bas8Wl61/k+bERupq4tZsaJ70shrZFo47IBAqwzkRxFFJCaS7wp4GKhQj2NZENUyx
 CoDmV6TQ==
X-Gm-Gg: AR+sD13N4guKX6mRmijQqzLPWOz6B3+LPIT4+nh9xq4LsgfCOUuAF7mg5oovFRG1sfx
 23F0vwF0ploHkd10OFAOi2REZTDzq0heu2wThNoLwlxvCZm9o9byg8vnd6kMwEFrEd9i+Tc4nzr
 goUfeG16gwoaCHnBKgjkklS2/5enRWCUhDfKIMbGik051X+ZfbJeE9FNCt3b56M4iXNqkUlhyBm
 vQHGAZtlrKpAsBucrZvhu1XF03TaKZ5bfeQD6hZxelW/N4s0Tbul+ZXuuFVIxrWl4qdkq0OSYwz
 GLdqjJjxOGgSYbgaIQwmSe7NJ6aLQiNdLoqcPPyf6DP2SprMFLu9DoQSbY2VPfFilIKpv81SmzZ
 kWkHNXUIoDWkaXd61SpeZkDmYVCptQNAXxOKZDMZ6sHmlm6CvbY99g1bwX2xb5rmE9XaQJ6Zw4B
 oPaEgSO5n1vambNREd04vCVAvp0MKcyStAw7eA49zWm7MzHJSNbPo5zfPi8Ng1NtdATxl9hCfGj
 KsAEWayiCLznFJqhpRhijY7Z1TEOmzLeFD8YmGi21QCrKztdwxj4EY4m6VQmZhW99DRLb0XMC4I
 ZN5dtXjcb3WC8HQkfiPQY4SCwoVobMRnKgLK77m4YvN0rDo52ls=
X-Received: by 2002:a05:600c:870e:b0:495:7040:c7e9 with SMTP id
 5b1f17b1804b1-49800e6bc23mr29335465e9.6.1785413032055; 
 Thu, 30 Jul 2026 05:03:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980120b42csm56126145e9.10.2026.07.30.05.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 05:03:51 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 12:03:44 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: de85c766fc39c527bf1277ee8d4f0a2a5c151170
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <78c834b1d83afc13bb86d0aa1a3dc50954522036-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpPUY-0006Es-FZ
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
Content-Type: multipart/mixed; boundary="===============4880053935476397327=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4880053935476397327==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r/S8GRGjozo="; charset=UTF-8

--r/S8GRGjozo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1723?usp=3Demail

to look at the new patch set (#15)=
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
openvpn refs/changes/23/1723/15

diff --git a/src/openvpn/multi=2Ec b/src/o=
penvpn/multi=2Ec
index 72b0b53=2E=2E9b64598 100644
--- a/src/openvpn/multi=
=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3069,6 +3069,76 @@
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
@@ -3080,8 +3=
150,6 @@
 multi_process_float(struct multi_context *m, struct multi_instanc=
e *mi, struct link_socket *sock)
 {
     struct mroute_addr real =3D { 0 };=

-    struct hash *hash =3D m->hash;
-    struct gc_arena gc =3D gc_new();
=
 
     if (mi->real=2Etype & MR_WITH_PROTO)
     {
@@ -3091,53 +3159,16 @@
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
@@ -3166,7 +3197,6 @@
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
Gerrit-PatchSet: 15
G=
errit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--r/S8GRGjozo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #15</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><p>The change is n=
o longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Extract multi_check_dest_addr_allowed from multi_process_float<br=
><br>Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e<br>Signed-off-by:=
 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/multi=2Ec<=
br>1 file changed, 75 insertions(+), 45 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/17=
23/15</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</s=
pan><br><span>index 72b0b53=2E=2E9b64598 100644</span><br><span>--- a/src/o=
penvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><spa=
n>@@ -3069,6 +3069,76 @@</span><br><span> }</span><br><span> </span><br><sp=
an> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This meth=
ods checks if a client instance is allowed to use an address</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Reasons for disallowing a specific address are t=
hat a client might be</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * already using that address=2E In that case the method needs to decide<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * if this instance =
can kick out the other instance=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 The method will then terminate the other instance if that check was</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * positive=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+multi_check_dest_addr_allowed(struct multi_context *m, =
struct multi_instance *mi, struct mroute_addr *real)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct hash *hash =3D m-&gt;hash;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(hash=
, real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* make sure that we don&#39;t assign the client to an address =
taken by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * anot=
her client */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct hash_element *he =3D hash_lookup_fast(hash, bucket, real, hv);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!he)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* Address is not taken, everything is f=
ine=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *ex_mi =3D he-&=
gt;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *m1 =3D =
mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct tls_multi *m2 =3D ex_mi-&gt;context=2Ec2=2Etls_mult=
i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* do not allow if target addre=
ss is taken by client with another cert */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!cert_hash_compare(m1-&gt;locked_cert_hash_s=
et, m2-&gt;locked_cert_hash_set))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(D_MULTI_LOW, &quot;Disallow float to an address taken by anothe=
r client %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           multi_instance_string(ex_mi, false, &amp;gc));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* It doesn&#39;t make sense to let a peer float to the add=
ress it already</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * has, so we disallow it=2E This can happen if a DCO netlink notification<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * gets lost and=
 we miss a floating step=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(M_WARN,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            &quot;disallowing peer %&quot; PRIu32 &quot; (%s)=
 from floating to &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            &quot;its own address (%s)&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            m1-&gt;rx_peer_id, tls_common_na=
me(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            mroute_addr_print(&amp;mi-&gt;real, &am=
p;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto=
 done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    msg(D_MULTI_LOW,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        &quot;closing instance %s due to floa=
t collision with %s &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        &quot;using the same certificate&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        multi_instance_string(ex_mi, fal=
se, &amp;gc), multi_instance_string(mi, false, &amp;gc));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    multi_close_instance(m, ex_mi, fa=
lse);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span>  * Handles peer floating=2E</span><br><span>  *</span><br><span>  *=
 If peer is floated to a taken address, either drops packet</span><br><span=
>@@ -3080,8 +3150,6 @@</span><br><span> multi_process_float(struct multi_co=
ntext *m, struct multi_instance *mi, struct link_socket *sock)</span><br><s=
pan> {</span><br><span>     struct mroute_addr real =3D { 0 };</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;ha=
sh;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_aren=
a gc =3D gc_new();</span><br><span> </span><br><span>     if (mi-&gt;real=
=2Etype &amp; MR_WITH_PROTO)</span><br><span>     {</span><br><span>@@ -309=
1,53 +3159,16 @@</span><br><span> </span><br><span>     if (!mroute_extract=
_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true))</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const uint64_t hv =3D hash_value(hash, =
&amp;real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* make sure that we don&#39;t float to an address taken by anothe=
r client */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 hash_element *he =3D hash_lookup_fast(hash, bucket, &amp;real, hv);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (he)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!multi_check_dest_addr_allow=
ed(m, mi, &amp;real))</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        struct multi_instance *ex_mi =3D (struct mul=
ti_instance *)he-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct =
tls_multi *m1 =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        struct tls_multi *m2 =3D ex_mi-&gt;con=
text=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* do not fl=
oat if target address is taken by client with another cert */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (!cert_hash_compare(m1-&=
gt;locked_cert_hash_set, m2-&gt;locked_cert_hash_set))</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW, &quot;Disallow float to a=
n address taken by another client %s&quot;,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                multi_instance_string(ex_mi, false, &=
amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;context=2Ec2=
=2Ebuf=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto done;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        /* It doesn&#39;t make sense to let a peer floa=
t to the address it already</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-         * has, so we disallow it=2E This can happen if a DCO netlink=
 notification</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
 * gets lost and we miss a floating step=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                &quot;disallowing peer =
%&quot; PRIu32 &quot; (%s) from floating to &quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                &quot;its own address (%s)&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m1=
-&gt;rx_peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mroute_=
addr_print(&amp;mi-&gt;real, &amp;gc));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            goto done;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_=
MULTI_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 &quot;closing instance %s due to float collision with %s &quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            &quot;using the same=
 certificate&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          multi_instance_string(ex_mi, false, &amp;gc), multi_instance_stri=
ng(mi, false, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        multi_close_instance(m, ex_mi, false);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return;</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>     msg(D_MULTI_MEDIUM, &quot;peer %&quot; PRIu3=
2 &quot; (%s) floated from %s to %s&quot;,</span><br><span>         mi-&gt;=
context=2Ec2=2Etls_multi-&gt;rx_peer_id,</span><br><span>         tls_commo=
n_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span>@@ -3166,7 =
+3197,6 @@</span><br><span>     ASSERT(hash_add(m-&gt;cid_hash, &amp;mi-&gt=
;context=2Ec2=2Emda_context=2Ecid, mi, true));</span><br><span> #endif</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-done:</s=
pan><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail">change 1723</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d52c6d008502293c=
3ec57ad22d1c613dcd1a94e </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1723 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>

</body></html>
--r/S8GRGjozo=--


--===============4880053935476397327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4880053935476397327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4880053935476397327==--

