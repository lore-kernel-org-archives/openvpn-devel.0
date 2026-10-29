Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CCE606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VpVXwfhd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jRibcGLg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EBJoJQ78;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZmUyI0lQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8qH4XnU08dj9XeXEDZa1RP/1EqNGiQ6H8wdlvtMXVL0=; b=VpVXwfhdyYS4cJqlSdzJNFDGsT
	/1UxXqmeIs0UPjAu7eVEFXfdwMhM3jyzMXrJz1UzBB10nVbaghKDlHx2WgQmkzGGabVz5HyNHjHxx
	oyiJ0hbWjwEP/SV4Pcxse061CQuyhoBnPtL5G2KxWb1JSBhirBD45Xp1B82b6XLIRpYQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMTjE-0000000008A-1MpF;
	Thu, 29 Oct 2026 17:15:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMTjC-00000000084-3Wry
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:15:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C8yIUdBKCsm7l+gNEVSycnYtpcbFhttduk6WZnoudzI=; b=jRibcGLgcyNAOnyZVI6tVs7HHl
 IV2ZQiYSQFRZ4isymqBF5kUp1wnBMuBPLPTV13UR3Cs9gY1VeZ9RCvNp47hybBLXuDWMq6Bg68SIb
 pLaKWaIXkUlbeeEqP9QLa2lMgG41w4mKNwRSl87FTdBCfaaD499nFAj+bkJVR7X5jzmo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C8yIUdBKCsm7l+gNEVSycnYtpcbFhttduk6WZnoudzI=; b=EBJoJQ78q1bUuv4DCAqjHiZ1qN
 2cVoGkZ8sFnk1btaJWifZLaOedeSHUiVFbTilIEQsEaGEh/jFZvyJ5xaSKV/lKuzD5yLw4qzETrTj
 k+Hfmz8azU66R4FsV9gcL8STz78myGvZE+1eFOzupNjIePyveweUxNy3Drus+z0xNRiM=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMTj8-000000006Bh-0Fdm for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:15:50 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso26678055e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793294139; x=1793898939; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C8yIUdBKCsm7l+gNEVSycnYtpcbFhttduk6WZnoudzI=;
 b=ZmUyI0lQ5r4YhD+SkZ3LPWH76nG5urCDdFNEZpzoUyeM04Y7e5c4nLZeotzpBNS3Ir
 Z+Xg8NxJX8bDNrZtuOX2Ajmy589eka+bi6bKtNNsLmk0Yjxtj3qwKsBY2uzBT0jXJWdM
 acP1Rh+Pk3aBYXQzB88Nu0WBejtcfJBsHtPxOIKJ/C08Cz/KNmpa5ynTu5eg81lPxWd2
 yf9W5Y/SK4UwZFVgRN27fbE1gvYYjJCCsLo0Dw6hWhEhJ+GZTxH7DqymU8YZn19N95v8
 j76mFJiwo2E0znuUjpSxVc2OemWVpCO8BWOmHCAch3QkB+S7+jdssltTquSn07LU0biL
 6Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294139; x=1793898939;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C8yIUdBKCsm7l+gNEVSycnYtpcbFhttduk6WZnoudzI=;
 b=2r0We3NzwX7lLf+7D23VVmfU60mzXZbUXpLswaAPeep5f4FYomwDAnW2wo9BsXzZsA
 RVmLy1H7qah+n+q6VPu/xAUtG5qvBwcYTXyT49z+VtUPFa5PYZddEg2EKC9jdLjP+cRB
 6NWj6fZpvt7yzGlaESvYEG/0CoPDDwiZCrL2KyY4W+rBW5zQL5EhTgWVCdgL9LE8Ciqy
 M3NRjt9qDzto/l+2cFagw16iNMn+2qZieVN+tpxBRIewU5FVVgx1MTVMP6rTNnHjNSEU
 m6NjC8TJV7T8ry1coTx0V18Ka6kgMomYkZ3lBMu965Atx6x60Mj4kWYq/NOFmddU9AtQ
 +lKA==
X-Gm-Message-State: AFq9FYI+6aTBJVyueYmXg76HfolA1Phe8FFX3YYIYkAOMdwTGMMLwfwj
 uL3DSBhzcxMaNbEzcgqvhUr7M/D4UpU/x2k3KwRN/PRAyRkWmgSAm0BuGQ/edVvT4lGi30P82Oz
 eCW+GUe0pZa/Y4dVZ43paJX7NZqKkFJkQxLsLeKdS02AieF/OAezoYNBMqMsdPoHv03Ps0R+KMl
 2PIy0s9A==
X-Gm-Gg: AYBFou1SSdxvVX41B4Dsi3BWsO6nPauRc1YUN58rBll6zLjCsJUbqyNAZpGkLhZ/NLe
 gY+ya1EC60/Aw/dfKZdVGpCDcjFoDuF6jjWLRtHG7K2PUsRZTd2m73U56RRhJqGXC9oyt+76Ro5
 DALL1a8SufDEEc8ci6JiBIxDprz6qeCWXam0/ef0duVEi6xHrlXKuRHCXZVT+ZxyszIaCRShkDi
 +lYaqatrQJMHIAIEG1hXc4zlKKsIZAH7PgEUsOivC4+0wq2amQItLVeVvaBMsMCh9hdBus67G5S
 xmHdRe1TqpbGUQvRtOH7Aew4OhOvKYSWxs5T36ECysY5RKvM0EJwxJdnUOSu4+pFytBiL5SiYWv
 l0bPZAIiGcCyZddfHkX5jVkJiEanC4Cb6nsjkHVDCkVAUrX/2rdAkerOida1w9H4lNB+vjrnRRi
 0B1bkFdMJudOIKORBK6D1HohP8prIF9rRDgwRAkHYPgoMojZrkrXrBF277hyi/j69xfgsjgLIB1
 pbHdlhXVFscBj3P7dZ0ks4/ecnzZ2/L82VZC/3Xf+ewLqAP+w+zbVnqSNC2pguWFTgdwGH5+C4p
 JL9mD6mdvd/iQPifCcTu6CW/NlkFVb/vo72Y+vV1sCCcZyhGvJyIAu4Y+BMf0IkRslOn0c0dQ8i
 7emFoUo+IwkJjI8Qk7ofU5bhHXsrhXceXdU2ZRXLeGuIL7aD2/bj4vG5HrrlI2RxuH6gAKbcNUr
 Px+Us53uHWjgFMuFY=
X-Received: by 2002:a05:600c:19c8:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4a966c418a2mr136984595e9.17.1793294139038; 
 Thu, 29 Oct 2026 10:15:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm2790705e9.1.2026.10.29.10.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:15:38 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 17:15:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iefd88cd537fa301d47a0c80d6fa520053c092bb3
X-Gerrit-Change-Number: 2065
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2065?usp=email>
X-Gerrit-Commit: 38fc47ea1b2f12239a0f0a2a0bb02085a0d7b56d
In-Reply-To: <gerrit.1793205511000.Iefd88cd537fa301d47a0c80d6fa520053c092bb3@gerrit.openvpn.net>
References: <gerrit.1793205511000.Iefd88cd537fa301d47a0c80d6fa520053c092bb3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA1NTExMDAwLkllZmQ4OGNkNTM3ZmEzMDFkNDdhMGM4MGQ2ZmE1MjAwNTNjMDkyYmIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <afd39554f4461f3019e1b0319ad7445cff5923de-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMTj8-000000006Bh-0Fdm
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Use m->instances
 instead of m->hash to iterate clients
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0561139862355014375=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0561139862355014375==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C1RIbHVmykM="; charset=UTF-8

--C1RIbHVmykM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded a new patch set (#2)=2E ( https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2065?usp=3Demail )


Change subject: Use m->instances i=
nstead of m->hash to iterate clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Use m->instances instead of m->hash to iterate cl=
ients

This simplifies the code a bit and also fixes a problem introduced b=
y
66f8cdb that connections in the early stages of connection are not shown
=
in the status file (e=2Eg=2E telnet openvpn-server 1194)=2E

Since this rem=
oves an indentation area, it is best to look at the changes
of this commit =
while ignoring white-space changes=2E

Change-Id: Iefd88cd537fa301d47a0c80d=
6fa520053c092bb3
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src=
/openvpn/manage=2Ec
M src/openvpn/multi=2Ec
2 files changed, 173 insertions=
(+), 177 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/65/2065/2

diff --git a/src/openvpn/manage=2Ec b/src/openvp=
n/manage=2Ec
index 0fc9ee2=2E=2Ed3e6b5a 100644
--- a/src/openvpn/manage=2Ec=

+++ b/src/openvpn/manage=2Ec
@@ -4300,12 +4300,14 @@
         }
 
        =
 /* iterate over peers and report counters for each connected peer */
-    =
    struct hash_iterator hi;
-        struct hash_element *he;
-        has=
h_iterator_init(multi->hash, &hi);
-        while ((he =3D hash_iterator_ne=
xt(&hi)))
+        for (uint32_t i =3D 0; i <=3D multi->max_peerid; i++)
  =
       {
-            struct multi_instance *mi =3D (struct multi_instance =
*)he->value;
+            struct multi_instance *mi =3D multi->instances[i]=
;
+
+            if (!mi)
+            {
+                continue;
+      =
      }
             struct context_2 *c2 =3D &mi->context=2Ec2;
 
        =
     if ((c2->mda_context=2Eflags & (DAF_CONNECTION_ESTABLISHED | DAF_CONNE=
CTION_CLOSED)) =3D=3D DAF_CONNECTION_ESTABLISHED)
@@ -4313,7 +4315,6 @@
   =
              man_bytecount_output_server(c2->dco_read_bytes + c2->link_rea=
d_bytes, c2->dco_write_bytes + c2->link_write_bytes, &c2->mda_context);
   =
          }
         }
-        hash_iterator_free(&hi);
     }
 }
 
diff -=
-git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 82757f4=2E=2E79e=
6bae 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -807=
,210 +807,205 @@
 static void
 multi_print_status(struct multi_context *m, =
struct status_output *so, const int version)
 {
-    if (m->hash)
+    stru=
ct gc_arena gc_top =3D gc_new();
+    struct hash_iterator hi;
+    const s=
truct hash_element *he;
+
+    status_reset(so);
+
+    if (dco_enabled(&m-=
>top=2Eoptions))
     {
-        struct gc_arena gc_top =3D gc_new();
-    =
    struct hash_iterator hi;
-        const struct hash_element *he;
-
-   =
     status_reset(so);
-
-        if (dco_enabled(&m->top=2Eoptions))
+    =
    if (dco_get_peer_stats_multi(&m->top=2Ec1=2Etuntap->dco, true) < 0)
   =
      {
-            if (dco_get_peer_stats_multi(&m->top=2Ec1=2Etuntap->dc=
o, true) < 0)
+            return;
+        }
+    }
+
+    if (version =3D=
=3D 1)
+    {
+        /*
+         * Status file version 1
+         */
+ =
       status_printf(so, "OpenVPN CLIENT LIST");
+        status_printf(so,=
 "Updated,%s", time_string(0, 0, false, &gc_top));
+        status_printf(s=
o, "Common Name,Real Address,Bytes Received,Bytes Sent,Connected Since");
+=

+        for (uint32_t i =3D 0; i <=3D m->max_peerid; i++)
+        {
+   =
         const struct multi_instance *mi =3D m->instances[i];
+
+          =
  struct gc_arena gc =3D gc_new();
+            if (mi && !mi->halt)
      =
       {
-                return;
+                status_printf(so, "%s,%s=
," counter_format "," counter_format ",%s",
+                              =
tls_common_name(mi->context=2Ec2=2Etls_multi, false),
+                    =
          mroute_addr_print(&mi->real, &gc),
+                             =
 mi->context=2Ec2=2Elink_read_bytes + mi->context=2Ec2=2Edco_read_bytes,
+ =
                             mi->context=2Ec2=2Elink_write_bytes + mi->cont=
ext=2Ec2=2Edco_write_bytes,
+                              time_string(mi->=
created, 0, false, &gc));
             }
+            gc_free(&gc);
       =
  }
 
-        if (version =3D=3D 1)
+        status_printf(so, "ROUTING TA=
BLE");
+        status_printf(so, "Virtual Address,Common Name,Real Address=
,Last Ref");
+        hash_iterator_init(m->vhash, &hi);
+        while ((h=
e =3D hash_iterator_next(&hi)))
         {
-            /*
-             * =
Status file version 1
-             */
-            status_printf(so, "Open=
VPN CLIENT LIST");
-            status_printf(so, "Updated,%s", time_string=
(0, 0, false, &gc_top));
-            status_printf(so, "Common Name,Real A=
ddress,Bytes Received,Bytes Sent,Connected Since");
-            hash_itera=
tor_init(m->hash, &hi);
-            while ((he =3D hash_iterator_next(&hi)=
))
-            {
-                struct gc_arena gc =3D gc_new();
-      =
          const struct multi_instance *mi =3D (struct multi_instance *)he->=
value;
+            struct gc_arena gc =3D gc_new();
+            const str=
uct multi_route *route =3D (struct multi_route *)he->value;
 
-            =
    if (!mi->halt)
+            if (multi_route_defined(m, route))
+       =
     {
+                const struct multi_instance *mi =3D route->instance=
;
+                const struct mroute_addr *ma =3D &route->addr;
+        =
        char flags[2] =3D { 0, 0 };
+
+                if (route->flags & M=
ULTI_ROUTE_CACHE)
                 {
-                    status_printf(so,=
 "%s,%s," counter_format "," counter_format ",%s",
-                       =
           tls_common_name(mi->context=2Ec2=2Etls_multi, false),
-         =
                         mroute_addr_print(&mi->real, &gc),
-              =
                    mi->context=2Ec2=2Elink_read_bytes + mi->context=2Ec2=
=2Edco_read_bytes,
-                                  mi->context=2Ec2=2Eli=
nk_write_bytes + mi->context=2Ec2=2Edco_write_bytes,
-                     =
             time_string(mi->created, 0, false, &gc));
+                   =
 flags[0] =3D 'C';
                 }
-                gc_free(&gc);
+     =
           status_printf(so, "%s%s,%s,%s,%s", mroute_addr_print(ma, &gc), f=
lags,
+                              tls_common_name(mi->context=2Ec2=2Etls=
_multi, false),
+                              mroute_addr_print(&mi->real,=
 &gc),
+                              time_string(route->last_reference, 0,=
 false, &gc));
             }
-            hash_iterator_free(&hi);
-
-    =
        status_printf(so, "ROUTING TABLE");
-            status_printf(so, =
"Virtual Address,Common Name,Real Address,Last Ref");
-            hash_ite=
rator_init(m->vhash, &hi);
-            while ((he =3D hash_iterator_next(&=
hi)))
-            {
-                struct gc_arena gc =3D gc_new();
-   =
             const struct multi_route *route =3D (struct multi_route *)he->=
value;
-
-                if (multi_route_defined(m, route))
-             =
   {
-                    const struct multi_instance *mi =3D route->instan=
ce;
-                    const struct mroute_addr *ma =3D &route->addr;
-  =
                  char flags[2] =3D { 0, 0 };
-
-                    if (ro=
ute->flags & MULTI_ROUTE_CACHE)
-                    {
-                   =
     flags[0] =3D 'C';
-                    }
-                    status_p=
rintf(so, "%s%s,%s,%s,%s", mroute_addr_print(ma, &gc), flags,
-            =
                      tls_common_name(mi->context=2Ec2=2Etls_multi, false),=

-                                  mroute_addr_print(&mi->real, &gc),
-   =
                               time_string(route->last_reference, 0, false,=
 &gc));
-                }
-                gc_free(&gc);
-            }
- =
           hash_iterator_free(&hi);
-
-            status_printf(so, "GLOBA=
L STATS");
-            if (m->mbuf)
-            {
-                status=
_printf(so, "Max bcast/mcast queue length,%d", mbuf_maximum_queued(m->mbuf)=
);
-            }
-
-            status_printf(so, "END");
+            gc_=
free(&gc);
         }
-        else if (version =3D=3D 2 || version =3D=3D =
3)
+        hash_iterator_free(&hi);
+
+        status_printf(so, "GLOBAL S=
TATS");
+        if (m->mbuf)
         {
-            const char sep =3D (v=
ersion =3D=3D 3) ? '\t' : ',';
+            status_printf(so, "Max bcast/mc=
ast queue length,%d", mbuf_maximum_queued(m->mbuf));
+        }
 
-        =
    /*
-             * Status file version 2 and 3
-             */
-      =
      status_printf(so, "TITLE%c%s", sep, title_string);
-            statu=
s_printf(so, "TIME%c%s%c%u", sep, time_string(now, 0, false, &gc_top), sep,=

-                          (unsigned int)now);
-            status_printf(=

-                so,
-                "HEADER%cCLIENT_LIST%cCommon Name%cR=
eal Address%cVirtual Address%cVirtual IPv6 Address%cBytes Received%cBytes S=
ent%cConnected Since%cConnected Since (time_t)%cUsername%cClient ID%cPeer I=
D%cData Channel Cipher",
-                sep, sep, sep, sep, sep, sep, sep=
, sep, sep, sep, sep, sep, sep);
-            hash_iterator_init(m->hash, &=
hi);
-            while ((he =3D hash_iterator_next(&hi)))
+        status_=
printf(so, "END");
+    }
+    else if (version =3D=3D 2 || version =3D=3D =
3)
+    {
+        const char sep =3D (version =3D=3D 3) ? '\t' : ',';
+
+ =
       /*
+         * Status file version 2 and 3
+         */
+        sta=
tus_printf(so, "TITLE%c%s", sep, title_string);
+        status_printf(so, =
"TIME%c%s%c%u", sep, time_string(now, 0, false, &gc_top), sep,
+           =
           (unsigned int)now);
+        status_printf(
+            so,
+  =
          "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%=
cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnected Since%cConnect=
ed Since (time_t)%cUsername%cClient ID%cPeer ID%cData Channel Cipher",
+   =
         sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
=
+
+        for (uint32_t i =3D 0; i <=3D m->max_peerid; i++)
+        {
+  =
          const struct multi_instance *mi =3D m->instances[i];
+           =
 struct gc_arena gc =3D gc_new();
+
+            if (mi && !mi->halt)
     =
        {
-                struct gc_arena gc =3D gc_new();
-              =
  const struct multi_instance *mi =3D (struct multi_instance *)he->value;
-=

-                if (!mi->halt)
-                {
-                    st=
atus_printf(
-                        so,
-                        "CLIENT_=
LIST%c%s%c%s%c%s%c%s%c" counter_format "%c" counter_format
-               =
         "%c%s%c%u%c%s%c"
+                status_printf(
+                =
    so,
+                    "CLIENT_LIST%c%s%c%s%c%s%c%s%c" counter_format=
 "%c" counter_format
+                    "%c%s%c%u%c%s%c"
 #ifdef ENABLE_M=
ANAGEMENT
-                        "%lu"
+                    "%lu"
 #else
=
-                        ""
+                    ""
 #endif
-              =
          "%c%" PRIu32 "%c%s",
-                        sep, tls_common_nam=
e(mi->context=2Ec2=2Etls_multi, false), sep,
-                        mrout=
e_addr_print(&mi->real, &gc), sep,
-                        print_in_addr_t=
(mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc), sep,
-                       =
 print_in6_addr(mi->reporting_addr_ipv6, IA_EMPTY_IF_UNDEF, &gc), sep,
-   =
                     mi->context=2Ec2=2Elink_read_bytes + mi->context=2Ec2=
=2Edco_read_bytes, sep,
-                        mi->context=2Ec2=2Elink_wr=
ite_bytes + mi->context=2Ec2=2Edco_write_bytes, sep,
-                     =
   time_string(mi->created, 0, false, &gc), sep, (unsigned int)mi->created,=

-                        sep, tls_username(mi->context=2Ec2=2Etls_multi, f=
alse),
+                    "%c%" PRIu32 "%c%s",
+                    sep, =
tls_common_name(mi->context=2Ec2=2Etls_multi, false), sep,
+               =
     mroute_addr_print(&mi->real, &gc), sep,
+                    print_in_=
addr_t(mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc), sep,
+                 =
   print_in6_addr(mi->reporting_addr_ipv6, IA_EMPTY_IF_UNDEF, &gc), sep,
+ =
                   mi->context=2Ec2=2Elink_read_bytes + mi->context=2Ec2=2E=
dco_read_bytes, sep,
+                    mi->context=2Ec2=2Elink_write_byt=
es + mi->context=2Ec2=2Edco_write_bytes, sep,
+                    time_str=
ing(mi->created, 0, false, &gc), sep, (unsigned int)mi->created,
+         =
           sep, tls_username(mi->context=2Ec2=2Etls_multi, false),
 #ifdef =
ENABLE_MANAGEMENT
-                        sep, mi->context=2Ec2=2Emda_cont=
ext=2Ecid,
+                    sep, mi->context=2Ec2=2Emda_context=2Ecid,
=
 #else
-                        sep,
+                    sep,
 #endif
-   =
                     sep, mi->context=2Ec2=2Etls_multi ? mi->context=2Ec2=
=2Etls_multi->rx_peer_id : MAX_PEER_ID,
-                        sep, trans=
late_cipher_name_to_openvpn(mi->context=2Eoptions=2Eciphername));
-        =
        }
-                gc_free(&gc);
+                    sep, mi->cont=
ext=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls_multi->rx_peer_id : MAX_PEER_=
ID,
+                    sep, translate_cipher_name_to_openvpn(mi->context=
=2Eoptions=2Eciphername));
             }
-            hash_iterator_free(&=
hi);
-
-            status_printf(
-                so,
-                "H=
EADER%cROUTING_TABLE%cVirtual Address%cCommon Name%cReal Address%cLast Ref%=
cLast Ref (time_t)",
-                sep, sep, sep, sep, sep, sep);
-     =
       hash_iterator_init(m->vhash, &hi);
-            while ((he =3D hash_=
iterator_next(&hi)))
-            {
-                struct gc_arena gc =3D=
 gc_new();
-                const struct multi_route *route =3D (struct mul=
ti_route *)he->value;
-
-                if (multi_route_defined(m, route))=

-                {
-                    const struct multi_instance *mi =
=3D route->instance;
-                    const struct mroute_addr *ma =3D =
&route->addr;
-                    char flags[2] =3D { 0, 0 };
-
-         =
           if (route->flags & MULTI_ROUTE_CACHE)
-                    {
-  =
                      flags[0] =3D 'C';
-                    }
-           =
         status_printf(so, "ROUTING_TABLE%c%s%s%c%s%c%s%c%s%c%u", sep,
-   =
                               mroute_addr_print(ma, &gc), flags, sep,
-   =
                               tls_common_name(mi->context=2Ec2=2Etls_multi=
, false), sep,
-                                  mroute_addr_print(&mi->re=
al, &gc), sep,
-                                  time_string(route->last_r=
eference, 0, false, &gc), sep,
-                                  (unsigned=
 int)route->last_reference);
-                }
-                gc_free(&g=
c);
-            }
-            hash_iterator_free(&hi);
-
-            if =
(m->mbuf)
-            {
-                status_printf(so, "GLOBAL_STATS%c=
Max bcast/mcast queue length%c%d", sep, sep,
-                             =
 mbuf_maximum_queued(m->mbuf));
-            }
-
-            status_printf=
(so, "GLOBAL_STATS%cdco_enabled%c%d", sep, sep,
-                          =
dco_enabled(&m->top=2Eoptions));
-            status_printf(so, "END");
+  =
          gc_free(&gc);
         }
-        else
+
+        status_printf(
=
+            so,
+            "HEADER%cROUTING_TABLE%cVirtual Address%cComm=
on Name%cReal Address%cLast Ref%cLast Ref (time_t)",
+            sep, sep,=
 sep, sep, sep, sep);
+        hash_iterator_init(m->vhash, &hi);
+        =
while ((he =3D hash_iterator_next(&hi)))
         {
-            status_pri=
ntf(so, "ERROR: bad status format version number");
+            struct gc_=
arena gc =3D gc_new();
+            const struct multi_route *route =3D (st=
ruct multi_route *)he->value;
+
+            if (multi_route_defined(m, rou=
te))
+            {
+                const struct multi_instance *mi =3D ro=
ute->instance;
+                const struct mroute_addr *ma =3D &route->ad=
dr;
+                char flags[2] =3D { 0, 0 };
+
+                if (rou=
te->flags & MULTI_ROUTE_CACHE)
+                {
+                    flag=
s[0] =3D 'C';
+                }
+                status_printf(so, "ROUTIN=
G_TABLE%c%s%s%c%s%c%s%c%s%c%u", sep,
+                              mroute_=
addr_print(ma, &gc), flags, sep,
+                              tls_common_=
name(mi->context=2Ec2=2Etls_multi, false), sep,
+                          =
    mroute_addr_print(&mi->real, &gc), sep,
+                              =
time_string(route->last_reference, 0, false, &gc), sep,
+                  =
            (unsigned int)route->last_reference);
+            }
+         =
   gc_free(&gc);
         }
+        hash_iterator_free(&hi);
+
+        if=
 (m->mbuf)
+        {
+            status_printf(so, "GLOBAL_STATS%cMax bca=
st/mcast queue length%c%d", sep, sep,
+                          mbuf_maxim=
um_queued(m->mbuf));
+        }
+
+        status_printf(so, "GLOBAL_STATS%=
cdco_enabled%c%d", sep, sep,
+                      dco_enabled(&m->top=2Eo=
ptions));
+        status_printf(so, "END");
+    }
+    else
+    {
+     =
   status_printf(so, "ERROR: bad status format version number");
+    }
 
 =
#ifdef PACKET_TRUNCATION_CHECK
+    {
+        status_printf(so, "HEADER,ER=
RORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,Post-decr=
ypt Trunc");
+        hash_iterator_init(m->hash, &hi);
+        while ((he=
 =3D hash_iterator_next(&hi)))
         {
-            status_printf(so, "H=
EADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,P=
ost-decrypt Trunc");
-            hash_iterator_init(m->hash, &hi);
-      =
      while ((he =3D hash_iterator_next(&hi)))
-            {
-            =
    struct gc_arena gc =3D gc_new();
-                const struct multi_in=
stance *mi =3D (struct multi_instance *)he->value;
+            struct gc_a=
rena gc =3D gc_new();
+            const struct multi_instance *mi =3D (str=
uct multi_instance *)he->value;
 
-                if (!mi->halt)
-        =
        {
-                    status_printf(so,
-                         =
         "ERRORS,%s," counter_format "," counter_format "," counter_format
=
-                                  "," counter_format,
-                   =
               tls_common_name(mi->context=2Ec2=2Etls_multi, false),
-     =
                             m->top=2Ec2=2En_trunc_tun_read, mi->context=2E=
c2=2En_trunc_tun_write,
-                                  mi->context=2Ec2=
=2En_trunc_pre_encrypt,
-                                  mi->context=2Ec2=
=2En_trunc_post_decrypt);
-                }
-                gc_free(&gc);=

+            if (!mi->halt)
+            {
+                status_printf(=
so,
+                              "ERRORS,%s," counter_format "," counter_=
format "," counter_format
+                              "," counter_format=
,
+                              tls_common_name(mi->context=2Ec2=2Etls_mul=
ti, false),
+                              m->top=2Ec2=2En_trunc_tun_read, =
mi->context=2Ec2=2En_trunc_tun_write,
+                              mi->co=
ntext=2Ec2=2En_trunc_pre_encrypt,
+                              mi->contex=
t=2Ec2=2En_trunc_post_decrypt);
             }
-            hash_iterator_f=
ree(&hi);
+            gc_free(&gc);
         }
+        hash_iterator_free=
(&hi);
+    }
 #endif /* ifdef PACKET_TRUNCATION_CHECK */
 
-        status=
_flush(so);
-        gc_free(&gc_top);
-    }
+    status_flush(so);
+    g=
c_free(&gc_top);
 
 #ifdef ENABLE_ASYNC_PUSH
     if (m->inotify_watchers)
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2065?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iefd88cd537fa30=
1d47a0c80d6fa520053c092bb3
Gerrit-Change-Number: 2065
Gerrit-PatchSet: 2
Ge=
rrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>

--C1RIbHVmykM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe <str=
ong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2065?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Use m-&gt;instances instead of m-&gt;hash to iterate clients<=
br><br>This simplifies the code a bit and also fixes a problem introduced b=
y<br>66f8cdb that connections in the early stages of connection are not sho=
wn<br>in the status file (e=2Eg=2E telnet openvpn-server 1194)=2E<br><br>Si=
nce this removes an indentation area, it is best to look at the changes<br>=
of this commit while ignoring white-space changes=2E<br><br>Change-Id: Iefd=
88cd537fa301d47a0c80d6fa520053c092bb3<br>Signed-off-by: Arne Schwabe &lt;ar=
ne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openvpn/mu=
lti=2Ec<br>2 files changed, 173 insertions(+), 177 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/65/2065/2</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/m=
anage=2Ec</span><br><span>index 0fc9ee2=2E=2Ed3e6b5a 100644</span><br><span=
>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec<=
/span><br><span>@@ -4300,12 +4300,14 @@</span><br><span>         }</span><b=
r><span> </span><br><span>         /* iterate over peers and report counter=
s for each connected peer */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        struct hash_iterator hi;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct hash_element *he;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        hash_iterator_init(multi-&gt;hash, &am=
p;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        while (=
(he =3D hash_iterator_next(&amp;hi)))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        for (uint32_t i =3D 0; i &lt;=3D multi-&gt;max_pe=
erid; i++)</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            struct multi_instance *mi =3D (struct multi_ins=
tance *)he-&gt;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            struct multi_instance *mi =3D multi-&gt;instances[i];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (!mi)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                continue;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span>             st=
ruct context_2 *c2 =3D &amp;mi-&gt;context=2Ec2;</span><br><span> </span><b=
r><span>             if ((c2-&gt;mda_context=2Eflags &amp; (DAF_CONNECTION_=
ESTABLISHED | DAF_CONNECTION_CLOSED)) =3D=3D DAF_CONNECTION_ESTABLISHED)</s=
pan><br><span>@@ -4313,7 +4315,6 @@</span><br><span>                 man_by=
tecount_output_server(c2-&gt;dco_read_bytes + c2-&gt;link_read_bytes, c2-&g=
t;dco_write_bytes + c2-&gt;link_write_bytes, &amp;c2-&gt;mda_context);</spa=
n><br><span>             }</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        hash_iterator_free(&amp;hi);</span>=
<br><span>     }</span><br><span> }</span><br><span> </span><br><span>diff =
--git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index=
 82757f4=2E=2E79e6bae 100644</span><br><span>--- a/src/openvpn/multi=2Ec</s=
pan><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -807,210 +807,=
205 @@</span><br><span> static void</span><br><span> multi_print_status(str=
uct multi_context *m, struct status_output *so, const int version)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (m-&=
gt;hash)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
gc_arena gc_top =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct hash_iterator hi;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const struct hash_element *he;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    status_reset(so);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (dco_enabled(&amp;m-&gt;top=2Eoptions))</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena gc_to=
p =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  struct hash_iterator hi;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        const struct hash_element *he;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        status_reset(so);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (dco_=
enabled(&amp;m-&gt;top=2Eoptions))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (dco_get_peer_stats_multi(&amp;m-&gt;top=2Ec1=2Et=
untap-&gt;dco, true) &lt; 0)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            if (dco_get_peer_stats_multi(=
&amp;m-&gt;top=2Ec1=2Etuntap-&gt;dco, true) &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (v=
ersion =3D=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         * Status file ver=
sion 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status_printf=
(so, &quot;OpenVPN CLIENT LIST&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        status_printf(so, &quot;Updated,%s&quot;, time_s=
tring(0, 0, false, &amp;gc_top));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        status_printf(so, &quot;Common Name,Real Address,Byte=
s Received,Bytes Sent,Connected Since&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        for (uint32_t i =3D 0; i &lt;=3D m-&gt;max_peerid; i++)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            const struct multi_ins=
tance *mi =3D m-&gt;instances[i];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (mi &amp;&amp; !mi-&gt;halt)</span><br><=
span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              return;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                status_printf(so, &quot;%s,%s,&quot; counter_format &quot=
;,&quot; counter_format &quot;,%s&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                              tls_common_name(mi-&gt;c=
ontext=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                              mroute_addr_print(&amp;mi-&gt;re=
al, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                        mi-&gt;context=2Ec2=2Elink_read_bytes + mi-&gt;cont=
ext=2Ec2=2Edco_read_bytes,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                              mi-&gt;context=2Ec2=2Elink_write_bytes=
 + mi-&gt;context=2Ec2=2Edco_write_bytes,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                              time_string(mi-&gt;crea=
ted, 0, false, &amp;gc));</span><br><span>             }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><b=
r><span>         }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (version =3D=3D 1)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        status_printf(so, &quot;ROUTING TABLE&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status_p=
rintf(so, &quot;Virtual Address,Common Name,Real Address,Last Ref&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hash_iterator=
_init(m-&gt;vhash, &amp;hi);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        while ((he =3D hash_iterator_next(&amp;hi)))</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * =
Status file version 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
             */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      status_printf(so, &quot;OpenVPN CLIENT LIST&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            status_printf(so, &quot;Upd=
ated,%s&quot;, time_string(0, 0, false, &amp;gc_top));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            status_printf(so, &quot;Common=
 Name,Real Address,Bytes Received,Bytes Sent,Connected Since&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            hash_iterator_in=
it(m-&gt;hash, &amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            while ((he =3D hash_iterator_next(&amp;hi)))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
const struct multi_instance *mi =3D (struct multi_instance *)he-&gt;value;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            const struct multi_route *route =3D (struct multi_route *)=
he-&gt;value;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                if (!mi-&gt;halt)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (multi_route_defined(m, route))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                const struct m=
ulti_instance *mi =3D route-&gt;instance;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                const struct mroute_addr *ma =3D &amp=
;route-&gt;addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             char flags[2] =3D { 0, 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                if (route-&gt;flags &amp; MULTI_ROUTE_CACHE)</span><br><s=
pan>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    status_printf(so, &quot;%s,%s,&quot; counter_format &q=
uot;,&quot; counter_format &quot;,%s&quot;,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                  tls_common_name(mi-=
&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                  mroute_addr_print(&amp;mi=
-&gt;real, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                 mi-&gt;context=2Ec2=2Elink_read_bytes + mi=
-&gt;context=2Ec2=2Edco_read_bytes,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                                  mi-&gt;context=2Ec2=2Elink_=
write_bytes + mi-&gt;context=2Ec2=2Edco_write_bytes,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                  time_stri=
ng(mi-&gt;created, 0, false, &amp;gc));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    flags[0] =3D &#39;C&#39;;</span><br=
><span>                 }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                status_printf(so, &quot;%s%s,%s,%s,%s&quo=
t;, mroute_addr_print(ma, &amp;gc), flags,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                              tls_common_name(mi-&gt=
;context=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                              mroute_addr_print(&amp;mi-&gt;=
real, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                          time_string(route-&gt;last_reference, 0, false, &=
amp;gc));</span><br><span>             }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            hash_iterator_free(&amp;hi);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            status_printf(so, &quot;ROUTING TABLE&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            status_pri=
ntf(so, &quot;Virtual Address,Common Name,Real Address,Last Ref&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            hash_iterator=
_init(m-&gt;vhash, &amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            while ((he =3D hash_iterator_next(&amp;hi)))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  const struct multi_route *route =3D (struct multi_route *)he-&gt;value;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                if (multi_route_defined(m, =
route))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  const struct multi_instance *mi =3D route-&gt;instance;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    const struct mroute=
_addr *ma =3D &amp;route-&gt;addr;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    char flags[2] =3D { 0, 0 };</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    if (route-&gt;flags &amp; MULTI_ROUTE=
_CACHE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
          flags[0] =3D &#39;C&#39;;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    status_printf(so, &quot;%s%s,%s,%s,%s&quo=
t;, mroute_addr_print(ma, &amp;gc), flags,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                  tls_common_name(mi-&=
gt;context=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                  mroute_addr_print(&amp;mi-=
&gt;real, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                                time_string(route-&gt;last_reference, 0, fa=
lse, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      hash_iterator_free(&amp;hi);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    status_printf(so, &quot;GLOBAL STATS&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (m-&gt;mbuf)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                status_printf(so, &quot;Max bcast/=
mcast queue length,%d&quot;, mbuf_maximum_queued(m-&gt;mbuf));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            status_printf(so, &quot;END&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span=
><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        else if (version =3D=3D 2 || version =3D=3D 3)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        hash_iterator_free(&amp;hi);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        status_printf(so, &quot;GLOBAL ST=
ATS&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (m-&gt;mbuf)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            const char sep =3D (version =3D=3D 3) ? &#=
39;\t&#39; : &#39;,&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            status_printf(so, &quot;Max bcast/mcast queue length,%d&q=
uot;, mbuf_maximum_queued(m-&gt;mbuf));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            /*</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-             * Status file version 2 and 3</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-             */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            status_printf(so, &quot;TITLE=
%c%s&quot;, sep, title_string);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            status_printf(so, &quot;TIME%c%s%c%u&quot;, sep, time=
_string(now, 0, false, &amp;gc_top), sep,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                          (unsigned int)now);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            status_printf(</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                so,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;HEADER=
%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cVirtual IPv6 Add=
ress%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)=
%cUsername%cClient ID%cPeer ID%cData Channel Cipher&quot;,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                sep, sep, sep, sep, se=
p, sep, sep, sep, sep, sep, sep, sep, sep);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            hash_iterator_init(m-&gt;hash, &amp;hi);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            while ((he=
 =3D hash_iterator_next(&amp;hi)))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        status_printf(so, &quot;END&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else if (version =3D=3D 2 || version =3D=3D 3)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        const char sep =3D (versi=
on =3D=3D 3) ? &#39;\t&#39; : &#39;,&#39;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * Status file version 2 and 3</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        status_printf(so, &quot;TITLE%c%s&quot;, sep, title_string);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status_print=
f(so, &quot;TIME%c%s%c%u&quot;, sep, time_string(now, 0, false, &amp;gc_top=
), sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
          (unsigned int)now);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        status_printf(</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            so,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            &quot;HEADER%cCLIENT_LIST%cCommon Name%cReal Address%c=
Virtual Address%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnecte=
d Since%cConnected Since (time_t)%cUsername%cClient ID%cPeer ID%cData Chann=
el Cipher&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        for (uint32_t i =3D 0; i &lt;=
=3D m-&gt;max_peerid; i++)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         const struct multi_instance *mi =3D m-&gt;instances[i];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (mi &amp;=
&amp; !mi-&gt;halt)</span><br><span>             {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                con=
st struct multi_instance *mi =3D (struct multi_instance *)he-&gt;value;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                if (!mi-&gt;halt)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    status_printf(</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                        s=
o,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
     &quot;CLIENT_LIST%c%s%c%s%c%s%c%s%c&quot; counter_format &quot;%c&quot=
; counter_format</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   &quot;%c%s%c%u%c%s%c&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                status_printf(</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    so,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    &quot;CLIENT_L=
IST%c%s%c%s%c%s%c%s%c&quot; counter_format &quot;%c&quot; counter_format</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &q=
uot;%c%s%c%u%c%s%c&quot;</span><br><span> #ifdef ENABLE_MANAGEMENT</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                        &quot;=
%lu&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          &quot;%lu&quot;</span><br><span> #else</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        &quot;&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;&quot=
;</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        &quot;%c%&quot; PRIu32 &quot;%c%s&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        sep,=
 tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false), sep,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        mroute_add=
r_print(&amp;mi-&gt;real, &amp;gc), sep,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                        print_in_addr_t(mi-&gt;reporting=
_addr, IA_EMPTY_IF_UNDEF, &amp;gc), sep,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                        print_in6_addr(mi-&gt;reporting_=
addr_ipv6, IA_EMPTY_IF_UNDEF, &amp;gc), sep,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        mi-&gt;context=2Ec2=2Elink_r=
ead_bytes + mi-&gt;context=2Ec2=2Edco_read_bytes, sep,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                        mi-&gt;context=2Ec=
2=2Elink_write_bytes + mi-&gt;context=2Ec2=2Edco_write_bytes, sep,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                        time_s=
tring(mi-&gt;created, 0, false, &amp;gc), sep, (unsigned int)mi-&gt;created=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
    sep, tls_username(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    &quot;%c%&qu=
ot; PRIu32 &quot;%c%s&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    sep, tls_common_name(mi-&gt;context=2Ec2=2Etls=
_multi, false), sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    mroute_addr_print(&amp;mi-&gt;real, &amp;gc), sep,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    pri=
nt_in_addr_t(mi-&gt;reporting_addr, IA_EMPTY_IF_UNDEF, &amp;gc), sep,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    print=
_in6_addr(mi-&gt;reporting_addr_ipv6, IA_EMPTY_IF_UNDEF, &amp;gc), sep,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mi-=
&gt;context=2Ec2=2Elink_read_bytes + mi-&gt;context=2Ec2=2Edco_read_bytes, =
sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     mi-&gt;context=2Ec2=2Elink_write_bytes + mi-&gt;context=2Ec2=2Edco_wri=
te_bytes, sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               time_string(mi-&gt;created, 0, false, &amp;gc), sep, (unsign=
ed int)mi-&gt;created,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    sep, tls_username(mi-&gt;context=2Ec2=2Etls_multi, f=
alse),</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        sep, mi-&gt;context=2Ec2=
=2Emda_context=2Ecid,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    sep, mi-&gt;context=2Ec2=2Emda_context=2Ecid,</span><=
br><span> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    sep,</span><br><span> #endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        sep, mi-&gt;context=
=2Ec2=2Etls_multi ? mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id : MAX_PE=
ER_ID,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
         sep, translate_cipher_name_to_openvpn(mi-&gt;context=2Eoptions=2Ec=
iphername));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    sep, mi-&gt;context=2Ec2=2Etls_multi ? mi-&gt;context=
=2Ec2=2Etls_multi-&gt;rx_peer_id : MAX_PEER_ID,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    sep, translate_cipher_name_=
to_openvpn(mi-&gt;context=2Eoptions=2Eciphername));</span><br><span>       =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ha=
sh_iterator_free(&amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            stat=
us_printf(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     so,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   &quot;HEADER%cROUTING_TABLE%cVirtual Address%cCommon Name%cReal Address%=
cLast Ref%cLast Ref (time_t)&quot;,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                sep, sep, sep, sep, sep, sep);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            hash_iterator_init(m-&gt=
;vhash, &amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        while ((he =3D hash_iterator_next(&amp;hi)))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                const st=
ruct multi_route *route =3D (struct multi_route *)he-&gt;value;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                if (multi_route_defined(m, route))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    const str=
uct multi_instance *mi =3D route-&gt;instance;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    const struct mroute_addr *ma =
=3D &amp;route-&gt;addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    char flags[2] =3D { 0, 0 };</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    if (route-&gt;flags &amp; MULTI_ROUTE_CACHE)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
flags[0] =3D &#39;C&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    status_printf(so, &quot;ROUTING_TABLE%c%s%s%c%s%c%s=
%c%s%c%u&quot;, sep,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                 mroute_addr_print(ma, &amp;gc), flags, sep=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
              tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false), sep,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
             mroute_addr_print(&amp;mi-&gt;real, &amp;gc), sep,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
 time_string(route-&gt;last_reference, 0, false, &amp;gc), sep,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
 (unsigned int)route-&gt;last_reference);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            hash_iterator_free(&amp;hi);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            if (m-&gt;mbuf)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                status_printf(so, &quot;GLOBAL_STATS%cMax b=
cast/mcast queue length%c%d&quot;, sep, sep,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                              mbuf_maximum_queued(m-=
&gt;mbuf));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            status_printf(so, &quot;GLO=
BAL_STATS%cdco_enabled%c%d&quot;, sep, sep,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                          dco_enabled(&amp;m-&gt;top=
=2Eoptions));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    status_printf(so, &quot;END&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span>         =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        status_printf(</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            so,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;HEADER%cROUTING_TABLE%cVirt=
ual Address%cCommon Name%cReal Address%cLast Ref%cLast Ref (time_t)&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sep, sep=
, sep, sep, sep, sep);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        hash_iterator_init(m-&gt;vhash, &amp;hi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        while ((he =3D hash_iterator_next=
(&amp;hi)))</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            status_printf(so, &quot;ERROR: bad status form=
at version number&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            struct gc_arena gc =3D gc_new();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            const struct multi_route *route =
=3D (struct multi_route *)he-&gt;value;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (multi_route_defined(m, route))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                const struct multi_instance *mi =3D r=
oute-&gt;instance;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               const struct mroute_addr *ma =3D &amp;route-&gt;addr;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                char flags=
[2] =3D { 0, 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (r=
oute-&gt;flags &amp; MULTI_ROUTE_CACHE)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    flags[0] =3D &#39;C&#39;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                status_printf(so,=
 &quot;ROUTING_TABLE%c%s%s%c%s%c%s%c%s%c%u&quot;, sep,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                              mroute_add=
r_print(ma, &amp;gc), flags, sep,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                              tls_common_name(mi-&gt;context=
=2Ec2=2Etls_multi, false), sep,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                              mroute_addr_print(&amp;mi-&gt;rea=
l, &amp;gc), sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                            time_string(route-&gt;last_reference, 0, false,=
 &amp;gc), sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                          (unsigned int)route-&gt;last_reference);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</spa=
n><br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        hash_iterator_free(&amp;hi);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (m-&gt;mbuf)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       status_printf(so, &quot;GLOBAL_STATS%cMax bcast/mcast queue length%c=
%d&quot;, sep, sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                          mbuf_maximum_queued(m-&gt;mbuf));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        status_printf(so, &quot;GLOBAL_STATS%cdco_enabled%c%d&qu=
ot;, sep, sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                 dco_enabled(&amp;m-&gt;top=2Eoptions));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        status_printf(so, &quot;END&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        status_printf(so, &quot;ERROR: bad status for=
mat version number&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span> </span><br><span> #ifdef PACKET_TRUNCATION_CH=
ECK</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        status_printf(so, &quo=
t;HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trun=
c,Post-decrypt Trunc&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        hash_iterator_init(m-&gt;hash, &amp;hi);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        while ((he =3D hash_iterator_=
next(&amp;hi)))</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            status_printf(so, &quot;HEADER,ERRORS,Comm=
on Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,Post-decrypt Trunc=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            h=
ash_iterator_init(m-&gt;hash, &amp;hi);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            while ((he =3D hash_iterator_next(&amp;hi)))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             const struct multi_instance *mi =3D (struct multi_instance *)h=
e-&gt;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            const struct multi_instance *mi =3D (struct m=
ulti_instance *)he-&gt;value;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                if (!mi-&gt;halt)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    status_printf(so,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
         &quot;ERRORS,%s,&quot; counter_format &quot;,&quot; counter_format=
 &quot;,&quot; counter_format</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                  &quot;,&quot; counter_format,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
         tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
   m-&gt;top=2Ec2=2En_trunc_tun_read, mi-&gt;context=2Ec2=2En_trunc_tun_wri=
te,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
                mi-&gt;context=2Ec2=2En_trunc_pre_encrypt,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                  mi-&=
gt;context=2Ec2=2En_trunc_post_decrypt);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (!mi-&gt;halt)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                status_printf(so,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
   &quot;ERRORS,%s,&quot; counter_format &quot;,&quot; counter_format &quot=
;,&quot; counter_format</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                              &quot;,&quot; counter_format,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                              t=
ls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                              m-&gt;top=
=2Ec2=2En_trunc_tun_read, mi-&gt;context=2Ec2=2En_trunc_tun_write,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
  mi-&gt;context=2Ec2=2En_trunc_pre_encrypt,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                              mi-&gt;context=2Ec2=
=2En_trunc_post_decrypt);</span><br><span>             }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            hash_iterator_free(&amp;hi);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free=
(&amp;gc);</span><br><span>         }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        hash_iterator_free(&amp;hi);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #endif /* ifdef P=
ACKET_TRUNCATION_CHECK */</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        status_flush(so);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        gc_free(&amp;gc_top);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    status_flush(so);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    gc_free(&amp;gc_top);</span><br><span> </span><br=
><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>     if (m-&gt;inotify_wat=
chers)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2065?usp=3Demail">change 2065</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2065?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefd88cd537fa301d47a0c8=
0d6fa520053c092bb3 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2065 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--C1RIbHVmykM=--


--===============0561139862355014375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0561139862355014375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0561139862355014375==--

