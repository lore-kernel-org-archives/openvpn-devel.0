Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2641CCDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vt/wLmSVqJe0jlp3Vs//xKGDSVMUvujHsJWGUjNXTVw=; b=BN/ofoX6x6n2InDKZibCdu1QMp
	2kWEICAdH5ykvGozRkxq1hEK0eTb5SXV+KS64G4GVbISnEa5U+TRwUo2pNULKdw2MaTz8Q5YqUaPy
	4XYwX5QY6ZX6TIwrrcolryadi6VCwmEGkXpzA1oD3FLxWKkMZYHmtcgSVMLOctzrCKZM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgcw-0007nK-12;
	Mon, 22 Jun 2026 15:31:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgcu-0007nA-JB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FtBv0FbF4KXTyxdBLMYIMZp46ra1ohlY854vO3JWNiM=; b=M87awfDBVRlP34YYN5Ebu770kD
 qH/W9O7tEO95MuMTzRpAFruRIFQragJMay1/NHyZ1Fer9GO4eFdJQ4tNKHkfHuM5JVJJBW1xUBcAz
 k4/ay/aJoIYLZtLPCts2xME1GXoCRuOIh+D9wLbn5B7udAFtFWarO9ECWij16fpKta/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FtBv0FbF4KXTyxdBLMYIMZp46ra1ohlY854vO3JWNiM=; b=O
 VQQ/0ixwTAyHHWGl6hLkMqEdEFVaaA2wEFFb4H+DQQd2bV40CbIu7t0b5nMKkvkzrqZG2cA25gZdu
 O8bh2pEqCLPCoakKdggQjJ+d+z3Rf1J2DyzRS+mNC1K7KBWMiHvN5VV4LZqnlAOGTRvhFfp7o2a6l
 5juOLmcNOchxKBbw=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgct-0007pm-6x for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:57 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso31468525e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782142309; x=1782747109; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FtBv0FbF4KXTyxdBLMYIMZp46ra1ohlY854vO3JWNiM=;
 b=MOgGIbWdnp2TOVSou+zrYF/SOWPnO8pYDqVUrZpFdbJ58USDShUnLTSLcrARnaFa5R
 vQsSLDtOYFNWvVG9cAavyI0jGjNA+QR6y0oSYsr7WUtAZdj6HEyhmNAJ4Mtfi/51XLmY
 2vQ9yhpaxLA3+Zk8lUOtIaLhXJMs/KV3qC39d1QK6l3pNJVPWA5+gFOixTNdTBUDYuuc
 yDDqP2/4USSA9xRNBuA5F4lCaE4mK4p0MYxDxtoycPXr5izWrby5h3Uzm8ldxxeTAkiB
 haLPZ/UJRA+ZNaVselJSGNmy7K4OnuYsWukb/hgI9bwebZe0Tl66uU3sOiqE0I7l7Gd9
 pyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142309; x=1782747109;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FtBv0FbF4KXTyxdBLMYIMZp46ra1ohlY854vO3JWNiM=;
 b=SGxSJ2HzbXxmVGSXGRmvAy8sHSC66knCntJEkFF2Xo9qjxKG45G7EhXRg/0u8rNO1p
 RaaHzu568VEfwpoNVHudBopqJISYd2RGwRd573ztZoYTSKjlrxQvJ5alM61ENsjJSqaJ
 pGJAg2srnxzGxMUSwZ0GyoY331MDtGMXILbi/YYt8ldgkjXNuXG98KIIRSlwkrRCryDM
 Y2QsbWF86ifEhT9hhi1ADAWhe70EQzzEkgIERdP4qnAhYeLwDzXxvgGMbfVc9jARy52c
 mw036U0PMZWj2BUg3wpvLXjbvRbyzvCYoRio/6h90Fp6kUYdtWf0ltRGzpug91dUAQZL
 /T8g==
X-Gm-Message-State: AOJu0YxpJP/eM8egYvZXwe/Xb1X9/n7cIPw3EEC9UYLhKKT6M5g1Yt9i
 UmPwGC/012oWMhqA5DZ0dRuAGv8ARmc+QKIISUFf5WqhidaZk91LYMRueryjj/WCuG4JWND68DG
 aJaphcJkA1vHtEIlIQmdfg9NRlKCSb0YqtbB8v86FWMFoDdnlq7sQDblU2O+FOO42UkWqZJtXj1
 XaXrLMfA==
X-Gm-Gg: AfdE7cl+Mev7C1vqowXjx9bFVjbcHOxaOd8ors0ooUxo0wmoLVmVFTm4YAo8mXUHIi8
 W00Xjba5gBVls9WcSRy/vnCxonK56DycAucXRbklCvlG9jEvoQKF4vAOEUI7Nfortl96M3URDQI
 giJs7zW1pa5CygUlJ7I/dR1npHG3ZUM51EXMX9XS+FwiItBdTTpPGlcTMkm1bnbGlXLuH2IGRLv
 /LPL9FA08FVd8cCiRlBapYXiAiNTV1MAvqX/tVxbyCg5kAA2FdpGyS5tWS5nK84VlyfAXKIkqzo
 ExuQxOBgBuihoEnxOwELwBVGbU6ydrx3Soth6pM4Hele49yRTRwlvOOCRPwlPUNnAhBY/AzHuXo
 3sStdWAXbxBtwNgcWGfP05/ldl0DsK3FzgWGhHP7/dmFnXBBxCkWPjkzxilwbpkgTVdphaa7ZHG
 VRdSlIApNer8AA72hEyxsjN/Zwi4z0+wu9SItypOx76CIRjhFfo4skD4R7TsLBGBg++fKDBte3s
 kpwq1w06ePSFFN6hMHw2uqdq61bdJfyPdp6uCAhSTG8UfcUsOiG3sd9fGMcup0Jp6UXQXHAFcxB
 Khk=
X-Received: by 2002:a05:600c:8010:b0:48e:5fb8:f80f with SMTP id
 5b1f17b1804b1-49240e7fd89mr235849965e9.24.1782142282740; 
 Mon, 22 Jun 2026 08:31:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924944fb71sm207598415e9.14.2026.06.22.08.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:31:22 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:31:08 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: e2d45132404457d5aec9042793f893d4a28d721c
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <21b2a5619d1fabf744bea0261359bda84bf81d47-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgct-0007pm-6x
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
Content-Type: multipart/mixed; boundary="===============7050608344800072521=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7050608344800072521==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ig5y3qO1lqs="; charset=UTF-8

--Ig5y3qO1lqs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1723?usp=3Demail

to look at the new patch set (#2=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Extract multi_check_dest_addr_allowed fro=
m multi_process_float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Extract multi_check_dest_addr_allowed from multi_process_float

=
Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
Signed-off-by: Arne Sc=
hwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/multi=2Ec
1 file changed, 65 i=
nsertions(+), 45 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/23/1723/2

diff --git a/src/openvpn/multi=2Ec b/src=
/openvpn/multi=2Ec
index dd339dc=2E=2Ee97fc25 100644
--- a/src/openvpn/mult=
i=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3104,6 +3104,66 @@
     return ret;
 =
}
 
+static bool
+multi_check_dest_addr_allowed(struct multi_context *m, st=
ruct multi_instance *mi, struct mroute_addr *real)
+{
+    struct hash *has=
h =3D m->hash;
+    const uint64_t hv =3D hash_value(hash, real);
+    stru=
ct hash_bucket *bucket =3D hash_bucket(hash, hv);
+
+    /* make sure that =
we don't assign the client to an address taken by
+     * another client */=

+    struct hash_element *he =3D hash_lookup_fast(hash, bucket, real, hv);=

+    if (!he)
+    {
+        /* Address is not taken, everything is fine=
=2E */
+        return true;
+    }
+
+    struct multi_instance *ex_mi =3D=
 he->value;
+
+    struct tls_multi *m1 =3D mi->context=2Ec2=2Etls_multi;
+=
    struct tls_multi *m2 =3D ex_mi->context=2Ec2=2Etls_multi;
+
+    struct=
 gc_arena gc =3D gc_new();
+    int ret =3D false;
+
+    /* do not allow i=
f target address is taken by client with another cert */
+    if (!cert_has=
h_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
+    {
+    =
    msg(D_MULTI_LOW, "Disallow float to an address taken by another client =
%s",
+            multi_instance_string(ex_mi, false, &gc));
+
+        mi-=
>context=2Ec2=2Ebuf=2Elen =3D 0;
+        goto done;
+    }
+
+    /* It do=
esn't make sense to let a peer float to the address it already
+     * has,=
 so we disallow it=2E This can happen if a DCO netlink notification
+     *=
 gets lost and we miss a floating step=2E
+     */
+    if (m1->rx_peer_id =
=3D=3D m2->rx_peer_id)
+    {
+        msg(M_WARN,
+            "disallowin=
g peer %" PRIu32 " (%s) from floating to "
+            "its own address (%=
s)",
+            m1->rx_peer_id, tls_common_name(mi->context=2Ec2=2Etls_mu=
lti, false),
+            mroute_addr_print(&mi->real, &gc));
+        goto=
 done;
+    }
+
+    msg(D_MULTI_LOW,
+        "closing instance %s due to =
float collision with %s "
+        "using the same certificate",
+        m=
ulti_instance_string(ex_mi, false, &gc), multi_instance_string(mi, false, &=
gc));
+    multi_close_instance(m, ex_mi, false);
+    return true;
+
+done=
:
+    gc_free(&gc);
+    return ret;
+}
+
 /**
  * Handles peer floating=
=2E
  *
@@ -3116,8 +3176,6 @@
 multi_process_float(struct multi_context *m,=
 struct multi_instance *mi, struct link_socket *sock)
 {
     struct mroute=
_addr real =3D { 0 };
-    struct hash *hash =3D m->hash;
-    struct gc_ar=
ena gc =3D gc_new();
 
     if (mi->real=2Etype & MR_WITH_PROTO)
     {
@@ =
-3127,53 +3185,16 @@
 
     if (!mroute_extract_openvpn_sockaddr(&real, &m-=
>top=2Ec2=2Efrom=2Edest, true))
     {
-        goto done;
+        return;=

     }
 
-    const uint64_t hv =3D hash_value(hash, &real);
-    struct h=
ash_bucket *bucket =3D hash_bucket(hash, hv);
-
-    /* make sure that we d=
on't float to an address taken by another client */
-    struct hash_elemen=
t *he =3D hash_lookup_fast(hash, bucket, &real, hv);
-    if (he)
+    if (=
!multi_check_dest_addr_allowed(m, mi, &real))
     {
-        struct multi_=
instance *ex_mi =3D (struct multi_instance *)he->value;
-
-        struct t=
ls_multi *m1 =3D mi->context=2Ec2=2Etls_multi;
-        struct tls_multi *m=
2 =3D ex_mi->context=2Ec2=2Etls_multi;
-
-        /* do not float if target=
 address is taken by client with another cert */
-        if (!cert_hash_co=
mpare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
-        {
-    =
        msg(D_MULTI_LOW, "Disallow float to an address taken by another cli=
ent %s",
-                multi_instance_string(ex_mi, false, &gc));
-
-   =
         mi->context=2Ec2=2Ebuf=2Elen =3D 0;
-
-            goto done;
-   =
     }
-
-        /* It doesn't make sense to let a peer float to the addre=
ss it already
-         * has, so we disallow it=2E This can happen if a DC=
O netlink notification
-         * gets lost and we miss a floating step=2E=

-         */
-        if (m1->rx_peer_id =3D=3D m2->rx_peer_id)
-        {=

-            msg(M_WARN,
-                "disallowing peer %" PRIu32 " (%=
s) from floating to "
-                "its own address (%s)",
-           =
     m1->rx_peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, false),
=
-                mroute_addr_print(&mi->real, &gc));
-            goto done=
;
-        }
-
-        msg(D_MULTI_LOW,
-            "closing instance %s =
due to float collision with %s "
-            "using the same certificate",=

-            multi_instance_string(ex_mi, false, &gc), multi_instance_stri=
ng(mi, false, &gc));
-        multi_close_instance(m, ex_mi, false);
+     =
   return;
     }
 
+    struct gc_arena gc =3D gc_new();
+
     msg(D_MULT=
I_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
         mi->conte=
xt=2Ec2=2Etls_multi->rx_peer_id,
         tls_common_name(mi->context=2Ec2=
=2Etls_multi, false),
@@ -3202,7 +3223,6 @@
     ASSERT(hash_add(m->cid_has=
h, &mi->context=2Ec2=2Emda_context=2Ecid, mi, true));
 #endif
 
-done:
    =
 gc_free(&gc);
 }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1723?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
Gerrit-Change-Number: 1723
Ger=
rit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <f=
rank@lichtenheld=2Ecom>

--Ig5y3qO1lqs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Extract multi_check_dest_addr_allowed from multi_process_floa=
t<br><br>Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e<br>Signed-off=
-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/multi=
=2Ec<br>1 file changed, 65 insertions(+), 45 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
23/1723/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c</span><br><span>index dd339dc=2E=2Ee97fc25 100644</span><br><span>--- a/s=
rc/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br>=
<span>@@ -3104,6 +3104,66 @@</span><br><span>     return ret;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mult=
i_check_dest_addr_allowed(struct multi_context *m, struct multi_instance *m=
i, struct mroute_addr *real)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const uint64_t hv =3D hash_value(hash, real);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *bucket =3D h=
ash_bucket(hash, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* make sure =
that we don&#39;t assign the client to an address taken by</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * another client */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he =3D=
 hash_lookup_fast(hash, bucket, real, hv);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!he)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* Address is not taken, everything is fine=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct multi_instance *ex_mi =3D he-&gt;value;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct tls_multi *m1 =3D mi-&gt;context=2Ec2=2Etls_=
multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tl=
s_multi *m2 =3D ex_mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int ret =3D false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* do not allow if target address is taken by client =
with another cert */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!cert_hash_compare(m1-&gt;locked_cert_hash_set, m2-&gt;locked_cert=
_hash_set))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LO=
W, &quot;Disallow float to an address taken by another client %s&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_insta=
nce_string(ex_mi, false, &amp;gc));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        goto done;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* It =
doesn&#39;t make sense to let a peer float to the address it already</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * has, so we disallow=
 it=2E This can happen if a DCO netlink notification</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * gets lost and we miss a floating s=
tep=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m1-&gt;rx_peer_id=
 =3D=3D m2-&gt;rx_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(M_WARN,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;disallowing peer %&quot; PRIu32 &quot; (%s) from floating to &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;its own address (%s)&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            m1-&gt;rx_peer_id, tls_common_name(mi-&gt;context=2Ec=
2=2Etls_multi, false),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg(D_MULTI_LOW,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        &quot;closing instance %s due to float collision with %s &=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;=
using the same certificate&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        multi_instance_string(ex_mi, false, &amp;gc), multi_i=
nstance_string(mi, false, &amp;gc));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    multi_close_instance(m, ex_mi, false);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+done:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> /**</span><br><span>  * Handles peer floating=2E</span><br><span>  *</spa=
n><br><span>@@ -3116,8 +3176,6 @@</span><br><span> multi_process_float(stru=
ct multi_context *m, struct multi_instance *mi, struct link_socket *sock)</=
span><br><span> {</span><br><span>     struct mroute_addr real =3D { 0 };</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =
=3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>     if (m=
i-&gt;real=2Etype &amp; MR_WITH_PROTO)</span><br><span>     {</span><br><sp=
an>@@ -3127,53 +3185,16 @@</span><br><span> </span><br><span>     if (!mrou=
te_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, t=
rue))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        goto done;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const uint64_t hv =3D hash_val=
ue(hash, &amp;real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* make sure that we don&#39;t float to an address taken =
by another client */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct hash_element *he =3D hash_lookup_fast(hash, bucket, &amp;real, hv=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (he)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi_check_dest_a=
ddr_allowed(m, mi, &amp;real))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct multi_instance *ex_mi =3D (s=
truct multi_instance *)he-&gt;value;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  struct tls_multi *m1 =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        struct tls_multi *m2 =3D ex_m=
i-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* =
do not float if target address is taken by client with another cert */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!cert_hash_com=
pare(m1-&gt;locked_cert_hash_set, m2-&gt;locked_cert_hash_set))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW, &quot;Disallow=
 float to an address taken by another client %s&quot;,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                multi_instance_string(ex_m=
i, false, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;con=
text=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            go=
to done;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        /* It doesn&#39;t make sense to let a =
peer float to the address it already</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         * has, so we disallow it=2E This can happen if a DC=
O netlink notification</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-         * gets lost and we miss a floating step=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_i=
d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;disallo=
wing peer %&quot; PRIu32 &quot; (%s) from floating to &quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                &quot;its own addres=
s (%s)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        m1-&gt;rx_peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi,=
 false),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            goto done;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msg(D_MULTI_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           &quot;closing instance %s due to float collision with %s &quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;usin=
g the same certificate&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            multi_instance_string(ex_mi, false, &amp;gc), multi_ins=
tance_string(mi, false, &amp;gc));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        multi_close_instance(m, ex_mi, false);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     msg(D_MULTI_MEDIUM, &quot;peer %&q=
uot; PRIu32 &quot; (%s) floated from %s to %s&quot;,</span><br><span>      =
   mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id,</span><br><span>        =
 tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span>@=
@ -3202,7 +3223,6 @@</span><br><span>     ASSERT(hash_add(m-&gt;cid_hash, &=
amp;mi-&gt;context=2Ec2=2Emda_context=2Ecid, mi, true));</span><br><span> #=
endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-done:</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br=
><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail">change 1723</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d52c6d0=
08502293c3ec57ad22d1c613dcd1a94e </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1723 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>

</body></html>
--Ig5y3qO1lqs=--


--===============7050608344800072521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7050608344800072521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7050608344800072521==--

