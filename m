Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E17CDB479
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z48hXRM/jGqkjoQ35KHFPoeFSi8FOTc4xKCCP+6sCtU=; b=V6lX5x8OXqhcsAeWNNYnSEur+y
	e9WOIWmKWnXfHidZG5HlsLHBTVkRApxzZ29ildiUQQG6Y2BezeiG/tOzvOFqmjSWs3XGQyj8ndFDJ
	IcqcKT6Wk83zJy3oOWVToMbjZH45rNmi+KVgEH3qNgNRjXbCkwbjOpSW6pH3vwzGm8pA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wckGs-0006ae-5R;
	Thu, 25 Jun 2026 13:37:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wckGq-0006aW-0C
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/D/NNQMHFw5/4A5x5Chf7g5V0Lfp0hS8huk+gJP4WWQ=; b=nHRm1zZK2iE+3/8xmQVMzXqJIJ
 l2JumOB5bccnBmk+ReCeQuvb3K0Vz6+8y+v6UH5MblY9bIOsSJtXgnLLoFwvF+ZS5xFsniXXp0NGq
 tC7dabpdxLZox4WgE8KkwPZwv+nxorjrG3U8qg5xCvebyx0Z/7l9nQt1y9WNalvA6dog=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/D/NNQMHFw5/4A5x5Chf7g5V0Lfp0hS8huk+gJP4WWQ=; b=W
 MdrezVcBXTI/aLni7o9eAm0ozGFPE6eQnadggRf1+qQEBTFbJCCnDP2cttw/vvGmqtSB+UbUOkYZp
 G/1e+N9A+lFBSotXzwDU+OOF/LjyeG9bh4SzAAP05DDNtBFm9vjEOS8ksRLnfrh+WNEnF4x6GiiJ8
 vlEx0e5QQK0FoP6w=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wckGo-0001Hy-GZ for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:32 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49222fb062bso22152765e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782394639; x=1782999439; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/D/NNQMHFw5/4A5x5Chf7g5V0Lfp0hS8huk+gJP4WWQ=;
 b=YkhbxLksVia+KNPeenum2h0XAgkksACE/v4ZXHt8da670I9dV9dXAx2ZRGNTmFwLd0
 zyjBJZoCHxiQ/v7xtN0/0s6scOJcIr1l15bZNy07jw3a6aLV16/nR71yA1M71FUuWQob
 gfRqFTSaqJWW7iRsAzFUK61Q5ZnPnKt0OJV0ntGjC4uUHXiTWp+6c+Buuqe13zUnvQUT
 cyi5gU69fXbclM94NJtU1+uDog8A7gqPMOQ3I2h9lBeBK048LhlrcaSUQGxQ/O2EBh6e
 jSOgoFi0AarylB8cCKTi0hahq1V39q2ZSMn5x+475LYTXoZE7v5gj2pemZzmuZad2BzR
 GP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394639; x=1782999439;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/D/NNQMHFw5/4A5x5Chf7g5V0Lfp0hS8huk+gJP4WWQ=;
 b=GAcIEyeZsPGDhtaSXzOPUFdApGo4ngFUoXCqK1HRpzQjIQz3gjjumiBr+k5IYsY/No
 39ry/nxor65glmx4nNv116TRzKM6XJntstVjVL+lPojDnwp4MW1zcZRp8aZAOcz1J47t
 5Xpnbk++cuO8/ANzQczozTtz7366AbEVpe/z2yYPO3iiRirKEoY2/aA9ZfMmptxOF+5X
 1od2ATU1X4WaiiIp2OS9uG232iB3abU9w8D47FFlWeqpJsmvreSJbrbs1KLJMIYoXK1+
 LxRlCQDOgmi8/L89XJGPtcfTncJiPRSZD8VxNxQ/9EWVSyWuWchlSMHyVAglkKQJWMb1
 xopg==
X-Gm-Message-State: AOJu0YzIU/oPF2my2HSk6zD2jeLJM9yvvOwt5rQ46LzvJE9psZXa38GQ
 Tw9SkOD+sbm0Bd7jvF2vwm9lJzEzK1Y64C2NdSXGehby3P9KrG551gqh/U1f1n+6UBmdZkri3dn
 CbkgZuM5XPTkHzuqHe7gHkfmdlfaaSHnVQJGlxM4PR+qJV2i2+MNr2qMaXKRbr/ERiwoQqN+dFe
 4Ev9x4Cw==
X-Gm-Gg: AfdE7clHU82b4HFnKvqVDh9xKf6Z247nGzZmxlfwSOiyb6AFEGiaj6l8YJWKRfj7JCF
 Cagsh+uj0djuZ0xPam9448uorJyr7MyUsquydI3YzKgEnGc3c3fHWzaVhI95nMIx6M7Yb2zbRAa
 GC9r4SvDl8NMNHDo//beMMEc6FfPMF0nMle9Du8EYUP3hfdkgbzTUYbNOVTn47AFUryQyBIi24T
 yP+VXLDacwkPevHUj0jpYXxIAuaY461lbC0XWugRRoGhdWrW/tTUy0Y+bdyoEtIKDwO2jCa5e4O
 WNXjUBlJ9ylrwZb5F8nOQY4Z5NJTS9B9WKLDpsBEpGg7iiPvvaK0if3nQbKKR1I54+pOcgfgvCU
 ojcCp/5lLnp7ong/ZaEAxcrfguHGtnOWwugJRcdnzX4pSzf0lp5Xc6W8Cx00gpzXBeLMAYebkS6
 vJNOhN5mk7Po4LJ+VohyDCuEUcsL6BZMkrernQFqPavLXHu7N10/aasaWVxA5O8KJe9/Nnwcd29
 15t+4HDBYBlayjijUOORoHDj+a77wp21oid+OPQFYaFQihQjWqLRmxp1B9BblBF1U2rAUVC6zHS
 Jks=
X-Received: by 2002:a05:600c:3f06:b0:492:33a8:5499 with SMTP id
 5b1f17b1804b1-492668858a8mr36457695e9.17.1782394639181; 
 Thu, 25 Jun 2026 06:37:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d93cdsm19248751f8f.18.2026.06.25.06.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:37:18 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:37:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: b418167638991954a02dc17e3c4e4b5953a07e88
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ac91d1183e80e02bcf1525840031bf88a2af1050-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wckGo-0001Hy-GZ
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
Content-Type: multipart/mixed; boundary="===============2370292862720486970=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2370292862720486970==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8m/B2aJny3o="; charset=UTF-8

--8m/B2aJny3o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1723?usp=3Demail

to look at the new patch set (#3=
)=2E


Change subject: Extract multi_check_dest_addr_allowed from multi_pro=
cess_float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

E=
xtract multi_check_dest_addr_allowed from multi_process_float

Change-Id: I=
3d52c6d008502293c3ec57ad22d1c613dcd1a94e
Signed-off-by: Arne Schwabe <arne@=
rfc2549=2Eorg>
---
M src/openvpn/multi=2Ec
1 file changed, 75 insertions(+)=
, 45 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/23/1723/3

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mul=
ti=2Ec
index 625f87d=2E=2E05a9dd3 100644
--- a/src/openvpn/multi=2Ec
+++ b/=
src/openvpn/multi=2Ec
@@ -3073,6 +3073,76 @@
 }
 
 /**
+ * This methods che=
cks if a client instance is allowed to use an address
+ *
+ * Reasons for d=
isallowing a specific adress are that a client might be
+ * already using t=
hat address=2E In that case the method need to decide
+ * if the this insta=
nce can kick out the other instance=2E
+ *
+ * The method will then termina=
te the other instance if that check was
+ * positive=2E
+ */
+static bool
+=
multi_check_dest_addr_allowed(struct multi_context *m, struct multi_instanc=
e *mi, struct mroute_addr *real)
+{
+    struct hash *hash =3D m->hash;
+  =
  const uint64_t hv =3D hash_value(hash, real);
+    struct hash_bucket *bu=
cket =3D hash_bucket(hash, hv);
+
+    /* make sure that we don't assign th=
e client to an address taken by
+     * another client */
+    struct hash_=
element *he =3D hash_lookup_fast(hash, bucket, real, hv);
+    if (!he)
+  =
  {
+        /* Address is not taken, everything is fine=2E */
+        ret=
urn true;
+    }
+
+    struct multi_instance *ex_mi =3D he->value;
+
+    =
struct tls_multi *m1 =3D mi->context=2Ec2=2Etls_multi;
+    struct tls_mult=
i *m2 =3D ex_mi->context=2Ec2=2Etls_multi;
+
+    struct gc_arena gc =3D gc=
_new();
+    int ret =3D false;
+
+    /* do not allow if target address is=
 taken by client with another cert */
+    if (!cert_hash_compare(m1->locke=
d_cert_hash_set, m2->locked_cert_hash_set))
+    {
+        msg(D_MULTI_LOW=
, "Disallow float to an address taken by another client %s",
+            m=
ulti_instance_string(ex_mi, false, &gc));
+
+        mi->context=2Ec2=2Ebuf=
=2Elen =3D 0;
+        goto done;
+    }
+
+    /* It doesn't make sense to=
 let a peer float to the address it already
+     * has, so we disallow it=
=2E This can happen if a DCO netlink notification
+     * gets lost and we =
miss a floating step=2E
+     */
+    if (m1->rx_peer_id =3D=3D m2->rx_peer=
_id)
+    {
+        msg(M_WARN,
+            "disallowing peer %" PRIu32 "=
 (%s) from floating to "
+            "its own address (%s)",
+            =
m1->rx_peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, false),
+    =
        mroute_addr_print(&mi->real, &gc));
+        goto done;
+    }
+
+ =
   msg(D_MULTI_LOW,
+        "closing instance %s due to float collision wi=
th %s "
+        "using the same certificate",
+        multi_instance_stri=
ng(ex_mi, false, &gc), multi_instance_string(mi, false, &gc));
+    multi_c=
lose_instance(m, ex_mi, false);
+    ret =3D true;
+
+done:
+    gc_free(&g=
c);
+    return ret;
+}
+
+/**
  * Handles peer floating=2E
  *
  * If peer=
 is floated to a taken address, either drops packet
@@ -3084,8 +3154,6 @@
 =
multi_process_float(struct multi_context *m, struct multi_instance *mi, str=
uct link_socket *sock)
 {
     struct mroute_addr real =3D { 0 };
-    stru=
ct hash *hash =3D m->hash;
-    struct gc_arena gc =3D gc_new();
 
     if =
(mi->real=2Etype & MR_WITH_PROTO)
     {
@@ -3095,53 +3163,16 @@
 
     if =
(!mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true))=

     {
-        goto done;
+        return;
     }
 
-    const uint64_t h=
v =3D hash_value(hash, &real);
-    struct hash_bucket *bucket =3D hash_buc=
ket(hash, hv);
-
-    /* make sure that we don't float to an address taken =
by another client */
-    struct hash_element *he =3D hash_lookup_fast(hash=
, bucket, &real, hv);
-    if (he)
+    if (!multi_check_dest_addr_allowed(=
m, mi, &real))
     {
-        struct multi_instance *ex_mi =3D (struct mul=
ti_instance *)he->value;
-
-        struct tls_multi *m1 =3D mi->context=2E=
c2=2Etls_multi;
-        struct tls_multi *m2 =3D ex_mi->context=2Ec2=2Etls=
_multi;
-
-        /* do not float if target address is taken by client wit=
h another cert */
-        if (!cert_hash_compare(m1->locked_cert_hash_set,=
 m2->locked_cert_hash_set))
-        {
-            msg(D_MULTI_LOW, "Disal=
low float to an address taken by another client %s",
-                multi=
_instance_string(ex_mi, false, &gc));
-
-            mi->context=2Ec2=2Ebuf=
=2Elen =3D 0;
-
-            goto done;
-        }
-
-        /* It doesn't=
 make sense to let a peer float to the address it already
-         * has, =
so we disallow it=2E This can happen if a DCO netlink notification
-       =
  * gets lost and we miss a floating step=2E
-         */
-        if (m1->=
rx_peer_id =3D=3D m2->rx_peer_id)
-        {
-            msg(M_WARN,
-    =
            "disallowing peer %" PRIu32 " (%s) from floating to "
-        =
        "its own address (%s)",
-                m1->rx_peer_id, tls_common=
_name(mi->context=2Ec2=2Etls_multi, false),
-                mroute_addr_pr=
int(&mi->real, &gc));
-            goto done;
-        }
-
-        msg(D_M=
ULTI_LOW,
-            "closing instance %s due to float collision with %s =
"
-            "using the same certificate",
-            multi_instance_st=
ring(ex_mi, false, &gc), multi_instance_string(mi, false, &gc));
-        m=
ulti_close_instance(m, ex_mi, false);
+        return;
     }
 
+    struct=
 gc_arena gc =3D gc_new();
+
     msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s=
) floated from %s to %s",
         mi->context=2Ec2=2Etls_multi->rx_peer_id=
,
         tls_common_name(mi->context=2Ec2=2Etls_multi, false),
@@ -3170,7=
 +3201,6 @@
     ASSERT(hash_add(m->cid_hash, &mi->context=2Ec2=2Emda_conte=
xt=2Ecid, mi, true));
 #endif
 
-done:
     gc_free(&gc);
 }
 

-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1=
c613dcd1a94e
Gerrit-Change-Number: 1723
Gerrit-PatchSet: 3
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--8m/B2aJny3o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Ex=
tract multi_check_dest_addr_allowed from multi_process_float<br><br>Change-=
Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e<br>Signed-off-by: Arne Schwab=
e &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file ch=
anged, 75 insertions(+), 45 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/1723/3</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span=
>index 625f87d=2E=2E05a9dd3 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -3073,6=
 +3073,76 @@</span><br><span> }</span><br><span> </span><br><span> /**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This methods checks i=
f a client instance is allowed to use an address</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Reasons for disallowing a specific adress are that a client =
might be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * already =
using that address=2E In that case the method need to decide</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * if the this instance can kick o=
ut the other instance=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The metho=
d will then terminate the other instance if that check was</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * positive=2E</span><br><span style=
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
 floated to a taken address, either drops packet</span><br><span>@@ -3084,8=
 +3154,6 @@</span><br><span> multi_process_float(struct multi_context *m, s=
truct multi_instance *mi, struct link_socket *sock)</span><br><span> {</spa=
n><br><span>     struct mroute_addr real =3D { 0 };</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D =
gc_new();</span><br><span> </span><br><span>     if (mi-&gt;real=2Etype &am=
p; MR_WITH_PROTO)</span><br><span>     {</span><br><span>@@ -3095,53 +3163,=
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
gt;context=2Ec2=2Etls_multi, false),</span><br><span>@@ -3170,7 +3201,6 @@<=
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
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I3d52c6d008502293c3ec57ad2=
2d1c613dcd1a94e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
723 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>

</body></html>
--8m/B2aJny3o=--


--===============2370292862720486970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2370292862720486970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2370292862720486970==--

