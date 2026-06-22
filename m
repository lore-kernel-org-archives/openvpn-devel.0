Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE38CDB477
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=/QmvYURvdcCwOpYlBIYdALsodrBoWnjg2Cd1ga/7eRk=; b=RLbxktmDRaSfA7
	E4OSlnm2O9nvwlF8nLdzR+s2yRahnSOTPphCHqyn2fN7dwuHdYVLcH1mgeXRO3j5lPZmdfd+dYIDf
	U9NdvmQpTR69gXB48GzVPYOH4ePawaxiBokggmhEDZR1rKFo9Ht9/w1iVeXU8bo8ZnSwRqecXBn7q
	GUo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbecu-0000f9-QI;
	Mon, 22 Jun 2026 13:23:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbecs-0000eo-Um
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ytoq+3GjOn96p9zyq2vTJufxfNQorq5LmHd2UQrOpGk=; b=LxIQLOXoZLGQ6c+rboPVCTFCWc
 RILtSq5wiSPg+kLF0RpIP2+s7IzbK1uFlbEtmAswn2I1iRqkWBRqfcguql1N5ihG1VarLCvEcjALF
 6hWWYBK5kLfXrDaJXQcd+HKZeNo7fjDxn6Zk6dwCC7L5Y7QwPtWm084k+pCiI0xIwAu4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ytoq+3GjOn96p9zyq2vTJufxfNQorq5LmHd2UQrOpGk=; b=O
 Qyyoeww8xDEz8BdTHjzDnBVd8XtxRlhp7eKg1byfu6BjSbO+uJ8l3lO8aMuANl0Q9w+2EskRBYXg0
 n4wdDC+xNH/f1BZf4OfUfI7Mlh7ITDdUTa/87kNTgb8oQbSXlkiWkgx18yC6pTxPyP0Gf8Tv+XyfK
 P2ng5Oj6Hbsno/5I=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbecr-0000aC-Dn for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:47 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490aaeabdb4so25883215e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134619; x=1782739419; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ytoq+3GjOn96p9zyq2vTJufxfNQorq5LmHd2UQrOpGk=;
 b=epeywGOST0Ct+GWH2Tuqc84xbthExf1l94q6veqs+1tJIyZPDPvtiENGL6X9EvsU0Z
 YF8SjZ8Pfqvr4qZ4943/OI1hjMNNF9bUV21H2WASmUdBeO2zTZuax0DcOZjl3GPGgy5N
 sLedlzVCsTH6kNgMDMTxc1RKix8LcucD7OwikyRWRykAnLfmVDrkXr+0GchGCk05Pf7U
 s9NNkSm7d2uEtIqJm6knCodg890099X1bfRwgJyj/bGH0geJQFWcZm2MTS1E+AvdoULC
 S6fMY0ipPKRM1jsgbOGaq7aHBbe6TcSpN1JHF8MESWvUiXpdNf56/qFape9PVcI4Da5P
 3xEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134619; x=1782739419;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ytoq+3GjOn96p9zyq2vTJufxfNQorq5LmHd2UQrOpGk=;
 b=b1ls36nWup+aOAArABp4Q8DiluSUENNwNsTomlHz5ei2C0o4jfUZaE+zHCAqp6jw86
 owI+KkugQe5uG0FE0x9um0gpnGI4TjVx8sWjvYvpPU8Tz1yAhm24fe74rC3PNHX15IBa
 5kLyMSxQkOCJCOF1DSonJlXpSine+7kOEQ/S+RM4Pqi8XQsRJtWH7u/432VQh6QRcoJX
 2g2i/f5/Vpa06uZL0lca/QQDZCQ+80z30ERXpO/Y/GdAHOthRUkoVU6PYuhKX6n920yG
 NwAArQ2fFcjeQkDGXPG+Km7Iwz6/YPdHJoxCQDHf4gqGc8Ho/48yGFD5U+7hlGXZ45wc
 zZDA==
X-Gm-Message-State: AOJu0Yz/Q/VvKM66ZqvSg069syQEcQGY+TJ+/PNJ60XbDIlTY00py6qY
 /fWIE+L/dNcWiGl1/n4ElAnEIHHWEJPWZ4PiAu0icAtgEOZ30RcAFOijHO7vOUMuRpg2I/G3/tT
 pYwIWCLj/3cOqfbLsIX5nGuykgS/Xwx2ubliY75FSHkZ09p+t62uk/YFsdd/IWa2lWPKQlpmxV4
 j2gEg+NQ==
X-Gm-Gg: AfdE7cnK00cyG4vE44Y2c+XHiE8MMHZQEt5Pwlt1M7A4OctAN4EP5RWZqMb0GX39g0B
 CvXhDr+8pfVS7iv/yQSXg6m3Sw05sSBJzfuBXUcb9R6Yt5fPi0jPdy+7kaC+5mrAXe468ZFzy2/
 DwIvzWPYr6eyODiT9YvpDpnhCOF8Y60m7xG0s99h+n3GDccOkHnpixwl68UNsTSX8RedfrPSais
 EAUzGri4CuxcYXDuBge6cxaGOXs+5/Dn+wdmBj093OIk+tktH8h8bq6aVJhd4eZaKMS3IpE9FMS
 hw+AXZMh4oe7miq2Jl+4qcyQF616DdhUFy6BmDq4ueOlEg4RfPCLMJOg4szE65wNjY2Fd/RdWQ0
 9/6e1bLFJmOTqgHDnl7cAXc2buNnzX+ex0UrVuSpsoaVF4OozQooCYSYKg7Hx/p73LVCWT97sVH
 3uxoFZ4Fmh1R1pAawF9QhwPxPW8aeL2cWPxZocdxKzosyfn1Bb9FpW9aWubTxivXkJrE/Wn/Bwx
 msvs9rSrDwSw/75c3C1ctWLQQLoBZ8mt8BHW9dOidMRg7Ci6999/m2NCZMxFQu7g6CWsUyBozin
 ii8=
X-Received: by 2002:a05:600d:6451:10b0:492:37b7:607a with SMTP id
 5b1f17b1804b1-4923fc7760emr181422505e9.31.1782134618048; 
 Mon, 22 Jun 2026 06:23:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4666712cceesm25609380f8f.35.2026.06.22.06.23.37
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:23:37 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:23:37 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: 516b6556e193aeb3a43c85599605d77fb38e68bb
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <00acf64745c33f2a591d4a76aba0a5b3730de46e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbecr-0000aC-Dn
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7558578451351280032=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7558578451351280032==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Oi06cKWRjQQ="; charset=UTF-8

--Oi06cKWRjQQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1723?usp=3Demail )


Change subject: Extract multi_check=
_dest_addr_allowed from multi_process_float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extract multi_check_dest_addr_allowed from =
multi_process_float

Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
S=
igned-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/multi=2Ec=

1 file changed, 67 insertions(+), 45 deletions(-)



  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/1723/1

diff --git a/src/o=
penvpn/multi=2Ec b/src/openvpn/multi=2Ec
index dd339dc=2E=2Ee2c0405 100644
=
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3104,6 +3104,68=
 @@
     return ret;
 }
 
+static bool
+multi_check_dest_addr_allowed(struc=
t multi_context *m, struct multi_instance *mi, struct mroute_addr *real)
+{=

+    struct hash *hash =3D m->hash;
+    struct gc_arena gc =3D gc_new();
=
+
+    const uint64_t hv =3D hash_value(hash, real);
+    struct hash_bucke=
t *bucket =3D hash_bucket(hash, hv);
+
+    /* make sure that we don't assi=
gn the client to an address taken by
+     * another client */
+    struct =
hash_element *he =3D hash_lookup_fast(hash, bucket, real, hv);
+    if (!he=
)
+    {
+        /* Address is not taken, everything is fine=2E */
+      =
  return true;
+    }
+
+    struct multi_instance *ex_mi =3D he->value;
+
=
+    struct tls_multi *m1 =3D mi->context=2Ec2=2Etls_multi;
+    struct tls=
_multi *m2 =3D ex_mi->context=2Ec2=2Etls_multi;
+
+    struct gc_arena gc =
=3D gc_new();
+    int ret =3D false;
+
+    /* do not allow if target addr=
ess is taken by client with another cert */
+    if (!cert_hash_compare(m1-=
>locked_cert_hash_set, m2->locked_cert_hash_set))
+    {
+        msg(D_MUL=
TI_LOW, "Disallow float to an address taken by another client %s",
+       =
     multi_instance_string(ex_mi, false, &gc));
+
+        mi->context=2Ec2=
=2Ebuf=2Elen =3D 0;
+        goto done;
+    }
+
+    /* It doesn't make se=
nse to let a peer float to the address it already
+     * has, so we disall=
ow it=2E This can happen if a DCO netlink notification
+     * gets lost an=
d we miss a floating step=2E
+     */
+    if (m1->rx_peer_id =3D=3D m2->rx=
_peer_id)
+    {
+        msg(M_WARN,
+            "disallowing peer %" PRI=
u32 " (%s) from floating to "
+            "its own address (%s)",
+       =
     m1->rx_peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, false),
=
+            mroute_addr_print(&mi->real, &gc));
+        goto done;
+    }=

+
+    msg(D_MULTI_LOW,
+        "closing instance %s due to float collisi=
on with %s "
+        "using the same certificate",
+        multi_instance=
_string(ex_mi, false, &gc), multi_instance_string(mi, false, &gc));
+    mu=
lti_close_instance(m, ex_mi, false);
+    return true;
+
+done:
+    gc_fre=
e(&gc);
+    return ret;
+}
+
 /**
  * Handles peer floating=2E
  *
@@ -311=
6,8 +3178,6 @@
 multi_process_float(struct multi_context *m, struct multi_i=
nstance *mi, struct link_socket *sock)
 {
     struct mroute_addr real =3D =
{ 0 };
-    struct hash *hash =3D m->hash;
-    struct gc_arena gc =3D gc_n=
ew();
 
     if (mi->real=2Etype & MR_WITH_PROTO)
     {
@@ -3127,53 +3187,=
16 @@
 
     if (!mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efro=
m=2Edest, true))
     {
-        goto done;
+        return;
     }
 
-    =
const uint64_t hv =3D hash_value(hash, &real);
-    struct hash_bucket *buc=
ket =3D hash_bucket(hash, hv);
-
-    /* make sure that we don't float to a=
n address taken by another client */
-    struct hash_element *he =3D hash_=
lookup_fast(hash, bucket, &real, hv);
-    if (he)
+    if (!multi_check_de=
st_addr_allowed(m, mi, &real))
     {
-        struct multi_instance *ex_mi=
 =3D (struct multi_instance *)he->value;
-
-        struct tls_multi *m1 =
=3D mi->context=2Ec2=2Etls_multi;
-        struct tls_multi *m2 =3D ex_mi->=
context=2Ec2=2Etls_multi;
-
-        /* do not float if target address is t=
aken by client with another cert */
-        if (!cert_hash_compare(m1->loc=
ked_cert_hash_set, m2->locked_cert_hash_set))
-        {
-            msg(D=
_MULTI_LOW, "Disallow float to an address taken by another client %s",
-   =
             multi_instance_string(ex_mi, false, &gc));
-
-            mi->=
context=2Ec2=2Ebuf=2Elen =3D 0;
-
-            goto done;
-        }
-
-   =
     /* It doesn't make sense to let a peer float to the address it already=

-         * has, so we disallow it=2E This can happen if a DCO netlink not=
ification
-         * gets lost and we miss a floating step=2E
-         */=

-        if (m1->rx_peer_id =3D=3D m2->rx_peer_id)
-        {
-           =
 msg(M_WARN,
-                "disallowing peer %" PRIu32 " (%s) from float=
ing to "
-                "its own address (%s)",
-                m1->rx_p=
eer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, false),
-            =
    mroute_addr_print(&mi->real, &gc));
-            goto done;
-        }
=
-
-        msg(D_MULTI_LOW,
-            "closing instance %s due to float =
collision with %s "
-            "using the same certificate",
-           =
 multi_instance_string(ex_mi, false, &gc), multi_instance_string(mi, false,=
 &gc));
-        multi_close_instance(m, ex_mi, false);
+        return;
  =
   }
 
+    struct gc_arena gc =3D gc_new();
+
     msg(D_MULTI_MEDIUM, "pe=
er %" PRIu32 " (%s) floated from %s to %s",
         mi->context=2Ec2=2Etls=
_multi->rx_peer_id,
         tls_common_name(mi->context=2Ec2=2Etls_multi, =
false),
@@ -3202,7 +3225,6 @@
     ASSERT(hash_add(m->cid_hash, &mi->contex=
t=2Ec2=2Emda_context=2Ecid, mi, true));
 #endif
 
-done:
     gc_free(&gc);=

 }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d52c6d00850=
2293c3ec57ad22d1c613dcd1a94e
Gerrit-Change-Number: 1723
Gerrit-PatchSet: 1
=
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--Oi06cKWRjQQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Extract multi_check_dest_addr_allowed from multi_process_float<br>=
<br>Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e<br>Signed-off-by: =
Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/multi=2Ec<b=
r>1 file changed, 67 insertions(+), 45 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/172=
3/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</spa=
n><br><span>index dd339dc=2E=2Ee2c0405 100644</span><br><span>--- a/src/ope=
nvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>=
@@ -3104,6 +3104,68 @@</span><br><span>     return ret;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_chec=
k_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi, str=
uct mroute_addr *real)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash=
 *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const uint64_t hv =3D hash_value(hash, real);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct hash_bucket *bucket =3D hash_buck=
et(hash, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* make sure that we =
don&#39;t assign the client to an address taken by</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * another client */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he =3D hash_lo=
okup_fast(hash, bucket, real, hv);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!he)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* Address is not taken, everything is fine=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct multi_instance *ex_mi =3D he-&gt;value;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct tls_multi *m1 =3D mi-&gt;context=2Ec2=2Etls_multi=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_mul=
ti *m2 =3D ex_mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int ret =3D false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* do not allow if target address is taken by client with anot=
her cert */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!cert_hash_compare(m1-&gt;locked_cert_hash_set, m2-&gt;locked_cert_hash_set=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;=
Disallow float to an address taken by another client %s&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            multi_instance_strin=
g(ex_mi, false, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&=
gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        goto done;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* It doesn&#39=
;t make sense to let a peer float to the address it already</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * has, so we disallow it=2E Th=
is can happen if a DCO netlink notification</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * gets lost and we miss a floating step=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (m1-&gt;rx_peer_id =3D=3D m2=
-&gt;rx_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WAR=
N,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot=
;disallowing peer %&quot; PRIu32 &quot; (%s) from floating to &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;its own =
address (%s)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            m1-&gt;rx_peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_mu=
lti, false),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    msg(D_MULTI_LOW,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        &quot;closing instance %s due to float collision with %s &quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;using t=
he same certificate&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        multi_instance_string(ex_mi, false, &amp;gc), multi_instance=
_string(mi, false, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    multi_close_instance(m, ex_mi, false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**<=
/span><br><span>  * Handles peer floating=2E</span><br><span>  *</span><br>=
<span>@@ -3116,8 +3178,6 @@</span><br><span> multi_process_float(struct mul=
ti_context *m, struct multi_instance *mi, struct link_socket *sock)</span><=
br><span> {</span><br><span>     struct mroute_addr real =3D { 0 };</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&=
gt;hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc=
_arena gc =3D gc_new();</span><br><span> </span><br><span>     if (mi-&gt;r=
eal=2Etype &amp; MR_WITH_PROTO)</span><br><span>     {</span><br><span>@@ -=
3127,53 +3187,16 @@</span><br><span> </span><br><span>     if (!mroute_extr=
act_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true))</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const uint64_t hv =3D hash_value(hash=
, &amp;real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* make sure that we don&#39;t float to an address taken by anot=
her client */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct hash_element *he =3D hash_lookup_fast(hash, bucket, &amp;real, hv);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (he)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!multi_check_dest_addr_all=
owed(m, mi, &amp;real))</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        struct multi_instance *ex_mi =3D (struct m=
ulti_instance *)he-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struc=
t tls_multi *m1 =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct tls_multi *m2 =3D ex_mi-&gt;=
context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* do not=
 float if target address is taken by client with another cert */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (!cert_hash_compare(m=
1-&gt;locked_cert_hash_set, m2-&gt;locked_cert_hash_set))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW, &quot;Disallow float t=
o an address taken by another client %s&quot;,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                multi_instance_string(ex_mi, false=
, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;context=2Ec=
2=2Ebuf=2Elen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto done;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /* It doesn&#39;t make sense to let a peer flo=
at to the address it already</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-         * has, so we disallow it=2E This can happen if a DCO netlin=
k notification</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
  * gets lost and we miss a floating step=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                &quot;disallowing peer=
 %&quot; PRIu32 &quot; (%s) from floating to &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                &quot;its own address (%s)&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 m1-&gt;rx_peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false)=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mrou=
te_addr_print(&amp;mi-&gt;real, &amp;gc));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            goto done;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
(D_MULTI_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    &quot;closing instance %s due to float collision with %s &quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;using the s=
ame certificate&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            multi_instance_string(ex_mi, false, &amp;gc), multi_instance_s=
tring(mi, false, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        multi_close_instance(m, ex_mi, false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     msg(D_MULTI_MEDIUM, &quot;peer %&quot; P=
RIu32 &quot; (%s) floated from %s to %s&quot;,</span><br><span>         mi-=
&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id,</span><br><span>         tls_c=
ommon_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span>@@ -320=
2,7 +3225,6 @@</span><br><span>     ASSERT(hash_add(m-&gt;cid_hash, &amp;mi=
-&gt;context=2Ec2=2Emda_context=2Ecid, mi, true));</span><br><span> #endif<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-done=
:</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span=
> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail">change 1723</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d52c6d00850229=
3c3ec57ad22d1c613dcd1a94e </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1723 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>=

<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Oi06cKWRjQQ=--


--===============7558578451351280032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7558578451351280032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7558578451351280032==--

