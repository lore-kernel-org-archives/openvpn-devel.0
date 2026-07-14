Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21485C44501
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DKhTRHDB2+PNrBluUPruELan47es/Gu6qRKTWfFiu3Q=; b=dMxpBF3ZZme/NcsDaJnarVSlkg
	1aZajFF7LqhaZJ/5WUXJl1IxvO3ULvy2RQGd8Lkl3Fe59cusoJdncNu3pbNfzOEyFLdG96KQ/qr7C
	RDtnlwGU4XPU64xwabIlIoEpoc498sdj9gOcGjEENeowVxkhK92weJ0w+AyPyR7jcjus=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjclb-0000qW-NV;
	Tue, 14 Jul 2026 13:01:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjclW-0000qE-0W
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YLzSroK/K0ETCdQnbUCItRD7xfcVSgjD59xQ3UIuBcM=; b=gDmx2UKAlxBJWtU486RBPjXogS
 agUZQvQlgi4OaCXfWt0f3EEJ51jyVRq/+tAhhcFdKBXTO4DwFDaI8ihxTKoTHOIYu+hu5UfAXq7Ip
 6fWc19pu+mGSJH4JUJlNF+iyTF9Z+sECMyAG61irpPoxmY4XfBbU7hWxwcSV6FU1ayJ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YLzSroK/K0ETCdQnbUCItRD7xfcVSgjD59xQ3UIuBcM=; b=m
 Fzxyzs36SmA7f9v3SsyOWrSFEYwyxL+xIKYuDgYZZFNc188LTYQeHxrHfdfxJ0ioziANwbkE0wBR6
 9GLuBPmgZQ/GLXyMZ6j0CEW6utv0O36SpNe6yt4r3bC89WM/ZmKfSRgYCMf8JG2tgweic2PcxN6Em
 oWwdu5lipmCQNqLU=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjclQ-000297-P2 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:35 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so30439805e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784034086; x=1784638886; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YLzSroK/K0ETCdQnbUCItRD7xfcVSgjD59xQ3UIuBcM=;
 b=YEX2B1RoS/vbNWEOWwj2WKelB0j8hbdx4pdOM6teJ+9UR/3lSAxpwjAeHxdLRgt96J
 9HOB5swuJz4B8ujXrml2SaxrKqyB+Fadjxa6GfCscG8nNdxTJPPKrTon5XCCJAKzNKG1
 l5rn9aWNPsaCQAsSYbkvhTi5YHADBICcSc6+4uRNo8gdFWcKsCNU+11bCA90E0bS8RLU
 O9P3b9jT6sfMr2Cqlv9DncWRBC8kWZCjNPdzxOcGbKS1EOC3qNPLNNJpbGZ23IRQBJx3
 BYGQNH42ksBkgWOLhS/Cet8vO/v2TeRQnZWSZejmwoNO5S22dNUxiHPUTFZpIKpy4ej4
 pWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784034086; x=1784638886;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YLzSroK/K0ETCdQnbUCItRD7xfcVSgjD59xQ3UIuBcM=;
 b=bGX2/fom/4S5KQ97KmZwbXkVxjYhNqXo3KIwCH+6yHHegm3Vy4WLKFdQUKgXi2/ChU
 ggPWfxWlYro19/g4MXC5UrwWig8T8R97SUs9BOXDc9kKjqC2eVsCgdZhS0bWtJu2aYaK
 d5n/x383Nx/WKnvFETZngbAoALF+jgz3ketputNQXp3r7fNCatjT/kmrlCuBXX/I3jWV
 VWkGs5Pfk0uvFBzaBt0mngq5opOqGaPKq/VqzqMUGPBhInGxfd6hglDxEr6kyRhcj9rE
 YBaK0tS4GboommlIBizC9cWe3wcfC4/3WRsSnPpi2ZGPCEeia3JYXZTJY9tLA2iCxpMV
 6PnA==
X-Gm-Message-State: AOJu0YzEv2sJT0VA4pJ54toRYT4iVnr/c8282LBdhhUB43m6Hv6fzXV4
 EHnjfJ+FeNNKoZXTK5tnTJrk/Ixdt3ihvbCk9v/FauQSUd1TA2lmE4Gu+TDJ2a448+HEds1YLIr
 ErQOTz07cP1FSBWFFMya8QJD/ofL54kwo55znB9Gp+zCdttRMbnK0+DW14An3oRMfQ9yF9T6C/7
 O98+tHiw==
X-Gm-Gg: AfdE7cmHZtQ1s4+QCd4qO7v9lAQ/S1Vyfpz5xuh91R1sbZA5woDMd+OxZCY0AHFTYzb
 +EURtEdWVl501Q7byAPZltivAt8vl8i8QsdTo3TjLeaAFMt6avIGf+IaQ39SIBpkIsIXGFhRh63
 FKkXpr7+Mku7L8e4BjolIrY21bjh08O07Jr3BVf5j0OD5mKFSRgyS8hDYqAFKOVWx73JJmY3GJX
 SBhI/sm362Dj/klCFbQcA4YyNHTJuYSD4B1HBWR+LBggQ5CfDCH11Uc5/iVocLUli7SnY4BOv4J
 +WqaD+a26xVuhlBawPSlqpeWJVZU9WIsn6jrgwt1y0awHYrDxviF2pLdb/p5FWdwsmOlEe43qwU
 6nAli1UOQO39tD02dRPBvlUfQFjEQ+yveef05yt+8T04x97ZvN/u/wYccXqS2AAYNCn4p1MbrfA
 8S5jbiojKRATjaTVP/cmKZtmHKvtxdVl7h9qsqszsvJIN1x52NG1+4s4s+5utVQyKRKmnu25cdi
 IdTLbXGqZB+G+SS+K+KtROHZmo03Rn7bqyr5G/yygTruOYbKPU8OhtrYdfalW8G+RxR/qKC5THS
 nQc=
X-Received: by 2002:a05:600c:c4ab:b0:493:a960:a0bf with SMTP id
 5b1f17b1804b1-495389bcc4dmr27512875e9.21.1784034085451; 
 Tue, 14 Jul 2026 06:01:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495086ca93esm72109895e9.0.2026.07.14.06.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:01:24 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 13:01:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: ccdcee277ad5c6d427ef187ab1ce1a7b2f19ed33
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5a07480f349b2e203f4ef664dcc4d498464df7d5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjclQ-000297-P2
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
Content-Type: multipart/mixed; boundary="===============1105761235001121133=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1105761235001121133==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UvNobIgQ6p0="; charset=UTF-8

--UvNobIgQ6p0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1723?usp=3Demail

to look at the new patch set (#4=
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
1 file changed, 75 i=
nsertions(+), 45 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/23/1723/4

diff --git a/src/openvpn/multi=2Ec b/src=
/openvpn/multi=2Ec
index 7535797=2E=2Ec40ebe4 100644
--- a/src/openvpn/mult=
i=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3072,6 +3072,76 @@
 }
 
 /**
+ * This=
 methods checks if a client instance is allowed to use an address
+ *
+ * R=
easons for disallowing a specific address are that a client might be
+ * al=
ready using that address=2E In that case the method needs to decide
+ * if =
this instance can kick out the other instance=2E
+ *
+ * The method will th=
en terminate the other instance if that check was
+ * positive=2E
+ */
+sta=
tic bool
+multi_check_dest_addr_allowed(struct multi_context *m, struct mul=
ti_instance *mi, struct mroute_addr *real)
+{
+    struct hash *hash =3D m-=
>hash;
+    const uint64_t hv =3D hash_value(hash, real);
+    struct hash_=
bucket *bucket =3D hash_bucket(hash, hv);
+
+    /* make sure that we don't=
 assign the client to an address taken by
+     * another client */
+    st=
ruct hash_element *he =3D hash_lookup_fast(hash, bucket, real, hv);
+    if=
 (!he)
+    {
+        /* Address is not taken, everything is fine=2E */
+ =
       return true;
+    }
+
+    struct multi_instance *ex_mi =3D he->valu=
e;
+
+    struct tls_multi *m1 =3D mi->context=2Ec2=2Etls_multi;
+    struc=
t tls_multi *m2 =3D ex_mi->context=2Ec2=2Etls_multi;
+
+    struct gc_arena=
 gc =3D gc_new();
+    int ret =3D false;
+
+    /* do not allow if target =
address is taken by client with another cert */
+    if (!cert_hash_compare=
(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
+    {
+        msg(D=
_MULTI_LOW, "Disallow float to an address taken by another client %s",
+   =
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
Gerrit-PatchSet: 4
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>

--UvNobIgQ6p0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #4</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Extract multi_check_dest_addr_allowed from multi_process_floa=
t<br><br>Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e<br>Signed-off=
-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/multi=
=2Ec<br>1 file changed, 75 insertions(+), 45 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
23/1723/4</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c</span><br><span>index 7535797=2E=2Ec40ebe4 100644</span><br><span>--- a/s=
rc/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br>=
<span>@@ -3072,6 +3072,76 @@</span><br><span> }</span><br><span> </span><br=
><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This =
methods checks if a client instance is allowed to use an address</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Reasons for disallowing a specific address a=
re that a client might be</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * already using that address=2E In that case the method needs to dec=
ide</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * if this insta=
nce can kick out the other instance=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * The method will then terminate the other instance if that check was</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * positive=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+multi_check_dest_addr_allowed(struct multi_contex=
t *m, struct multi_instance *mi, struct mroute_addr *real)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct hash *hash =3D m-&gt;hash;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value=
(hash, real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* make sure that we don&#39;t assign the client to an a=
ddress taken by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * another client */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct hash_element *he =3D hash_lookup_fast(hash, bucket, real, hv);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!he)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Address is not taken, everythi=
ng is fine=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *ex_mi =
=3D he-&gt;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi =
*m1 =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct tls_multi *m2 =3D ex_mi-&gt;context=2Ec2=2E=
tls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret=
 =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* do not allow if targ=
et address is taken by client with another cert */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!cert_hash_compare(m1-&gt;locked_cer=
t_hash_set, m2-&gt;locked_cert_hash_set))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(D_MULTI_LOW, &quot;Disallow float to an address taken b=
y another client %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            multi_instance_string(ex_mi, false, &amp;gc));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* It doesn&#39;t make sense to let a peer float to=
 the address it already</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * has, so we disallow it=2E This can happen if a DCO netlink notif=
ication</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * gets =
lost and we miss a floating step=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(M_WARN,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot;disallowing peer %&quot; PRIu32 &qu=
ot; (%s) from floating to &quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            &quot;its own address (%s)&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            m1-&gt;rx_peer_id, tls_c=
ommon_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            mroute_addr_print(&amp;mi-&gt=
;real, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    msg(D_MULTI_LOW,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        &quot;closing instance %s d=
ue to float collision with %s &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        &quot;using the same certificate&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        multi_instance_string(=
ex_mi, false, &amp;gc), multi_instance_string(mi, false, &amp;gc));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_close_instance(m,=
 ex_mi, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ret =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span>  * Handles peer floating=2E</span><br><span>  *</span><br=
><span>  * If peer is floated to a taken address, either drops packet</span=
><br><span>@@ -3083,8 +3153,6 @@</span><br><span> multi_process_float(struc=
t multi_context *m, struct multi_instance *mi, struct link_socket *sock)</s=
pan><br><span> {</span><br><span>     struct mroute_addr real =3D { 0 };</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =
=3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>     if (m=
i-&gt;real=2Etype &amp; MR_WITH_PROTO)</span><br><span>     {</span><br><sp=
an>@@ -3094,53 +3162,16 @@</span><br><span> </span><br><span>     if (!mrou=
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
@ -3169,7 +3200,6 @@</span><br><span>     ASSERT(hash_add(m-&gt;cid_hash, &=
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
<div style=3D"display:none"> Gerrit-PatchSet: 4=
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
--UvNobIgQ6p0=--


--===============1105761235001121133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1105761235001121133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1105761235001121133==--

