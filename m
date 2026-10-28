Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF7606A336
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Tb+ireq+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=i1zuYZ/E;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eE6GXZMF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PFV22vly
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=NN/geu/8jPgg4IATeRZ4Fy9buftNOEmYPYYHxRhNUzo=; b=Tb+ireq+FHVmBdMBiExpkBKaTy
	mZZkcxRZSgET/+BVkWNzhwLHRUFOOAz4W05CWGu6Avbs3wJYzA6YgeSEx1wo5QC4lIAoNaehgupYO
	29xTzj6AVAkQPDkEpQDfeXPg2oZ5dUE6nIVIJautmJciLgH653pmFzCr0RgY+TZP8wCk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM6fl-000000002N1-1s8p;
	Wed, 28 Oct 2026 16:38:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM6fj-000000002Mv-3VuH
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:38:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ylZeTtr7/ACmLB66IhfWaBXXZOKGT3xK8MjODYQj16A=; b=i1zuYZ/EFxblAA0mbjyBku/k3W
 EYMf/wk2PrOYzt3GdlFGXIBDf7zQnrKJjwodNJ7fkmAWZ5HRYVt26mmvikDqxdebFUFxml+Kvvvcu
 RaWSpRrrtxrFb88pEHFIPi5PDAC8JRhydYnyBFunMEhYMZhW/TsumqJgFmQg3TEZtGaU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ylZeTtr7/ACmLB66IhfWaBXXZOKGT3xK8MjODYQj16A=; b=eE6GXZMFAXZeZAIik1e4T5VhmS
 yPt35pCPmiYbEDiGov5mnNvMFiWg4MRYezIT73i6F78aLQSbNmQZ51Q/fT137qStcrDEpQmfBB3wu
 MvzhUrHV1/apvTfeu8EdUfekOffWG78e6HHSS/VV0njO3TdQYmjs3cYqsRGbl7ZT8XHM=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM6fh-000000005OS-27YS for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:38:43 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so8846495e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793205515; x=1793810315; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ylZeTtr7/ACmLB66IhfWaBXXZOKGT3xK8MjODYQj16A=;
 b=PFV22vlyeN7Crqc5OgzxwMvxf5+WN8Z9rluCBMlE+fb+w4JRy+OOP8EdGqRwH2GKmU
 TqKOsWLlhTkxdbGz11prSYHSn3fHq20sn46bFf9OH7jJGbZtRD91A0sF96qDFDs2aIhA
 gHN7xEnNPHTAUjCaJCA9zXYaO74PgfmCE1vAsOe0Qtxl47L8BC3O6Lm55nB7rRJSWovf
 dz+F60RtlwL1wTBk8/c16al+JNv+WdcTeA/haIICwOan4+h5d3WU9FRIRuZxv0B30vqY
 b03A02zUKCxqEOKZyLBySP32rbH+BxY73QkmoICqHHVZGlu/Y+XwqDJDWJplJT7WLrtE
 f3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205515; x=1793810315;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ylZeTtr7/ACmLB66IhfWaBXXZOKGT3xK8MjODYQj16A=;
 b=AV5CdKsriZJjfXYPqGuIaRPSqX8PydD7gg5TE/ve8+qm9xTuMnuQETBo5Z/NwtW+AB
 1GB26hJypd6E70bIQZxCXPAG4uzTzGQ4PWcABfeJRbDuOnm21xYECrv+wJw7RFbvVxhA
 ZjQsdeMsHC07PWsGNY8J0gKNp+XvHCUzSEMg73S18DAcTwAgr3cfgkvcy5QsiV8CyI6A
 kmr/F6iUMbnitWGDf5+rgE1pfJvM0MgeX2X4gq2xaBQHgvJHHDqZHrO1ZC7cbTMqj91d
 IlskpODOlYsq3LDxoNfhY7OOX8hB7WVSVHNukGowK403L98InlPi/qK+2MciWvro04m4
 Qp8g==
X-Gm-Message-State: AFq9FYJELBXeEULQKLl6vLMfxq5K6hTZFUtTxDwtTpPU7SH3G4ME897g
 fEhkFT/an+O1J6tl+154JtvRkyUt62RYJn1NolqF1GmJc0XicfDSlACfrGPDOoqAbTpVqZWzQxV
 SKp4mh4v/rWNlZJugzavHRuRWwFV2tYLMSDVKk/yvDMYAzMCxPOhLE2zP6W+xT8ZXJWPB1w9zFI
 qYraoiyw==
X-Gm-Gg: AYBFou14sMVG1sH3X2HZQzTixVmIijy6YSr+3MvP9WP9lLZOQ/QkrjCoKSdqRc7kXQP
 PiMyR0cAPLP1Whk5aCCxReF1PY8JMB2esOmrIA1JnHtal2VKb3yFSnJxWhytKp5v4JZozs5mkQA
 Do6MNjHirXFEkAEcauzm9To2peLd2Mwge5BKdksSVUwDzQXVEDkZKKHTzj0CAwQnmnQsJxXAfe+
 vMeS6u8OLRf+JdLbYTlr2wy+9jqitG8AAew2HpnBlvKKovrrcme3sfRQRPyKncTHnTmhr8qhI4D
 oioQommPS3aj/3e/P7WQO+WsUbynlh06hz8uUxVnA75EYdkfhCJLw2E8RkNC4+RAKKYbpCMKsz0
 rl1a/BNMyNDK0xfAv8rg8QcX7BOzJWceiyxE08HgUnd+3fgIgaObNnFr0DH6H2r5xcxSsK8GRCP
 PJE5mH79cfypb/DzlXls6N76Z+zKji+5icqTYOk2Gtk2OoI1ZEfsz4VnD/i3WJxpiyFvb2n1Zmn
 Yau0SshoHsfTRh+Hd1QL337/1EWWrutBPDNgacqopuTuR2kkLDU8kBVhBciMEInm0yfHKQPahwJ
 sIDdOvExK7i8fETlEb8Z+9z8WjCrqtgpxJu3Sno3yaYxxw9hjo2Ji6RLS/C5O0J2JqznlUhuNw0
 fTEvqPvvo56nR2CiA4ozhcjV1lVpnxR0c060iw+z3GS3k86CeqV18FtLhVlsc3XEcChVgsfHo30
 pRIioDGYf1igLkGOA=
X-Received: by 2002:a05:600c:19c8:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4a966e2a979mr67058265e9.24.1793205514165; 
 Wed, 28 Oct 2026 09:38:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f7f4cdbsm4430845e9.7.2026.10.28.09.38.33
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:38:33 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 16:38:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iefd88cd537fa301d47a0c80d6fa520053c092bb3
X-Gerrit-Change-Number: 2065
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2065?usp=email>
X-Gerrit-Commit: 34395b65b87789608dc567d6a9666ee2e31f2dda
References: <gerrit.1793205511000.Iefd88cd537fa301d47a0c80d6fa520053c092bb3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA1NTExMDAwLkllZmQ4OGNkNTM3ZmEzMDFkNDdhMGM4MGQ2ZmE1MjAwNTNjMDkyYmIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <001cc95fd056daec099cb24cc550ab66701db89c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xM6fh-000000005OS-27YS
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Use m->instances
 instead of m->hash to iterate clients in status
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
Content-Type: multipart/mixed; boundary="===============6740772628905465034=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6740772628905465034==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jTON/d9kzaQ="; charset=UTF-8

--jTON/d9kzaQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2065?usp=3Demail )


Change subject: Use m->instances=
 instead of m->hash to iterate clients in status
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Use m->instances instead of m->hash t=
o iterate clients in status

This simplifies the code a bit and also fixes =
a problem introduced by
66f8cdb that connections in the early stages of con=
nection are not shown
in the status file (e=2Eg=2E telnet openvpn-server 11=
94)=2E

Since this removes an indentation area, it is best to look at the c=
hanges
of this commit while ignoring white-space changes=2E

Change-Id: Ief=
d88cd537fa301d47a0c80d6fa520053c092bb3
Signed-off-by: Arne Schwabe <arne@rf=
c2549=2Eorg>
---
M src/openvpn/multi=2Ec
1 file changed, 166 insertions(+),=
 171 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/65/2065/1

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mu=
lti=2Ec
index 82757f4=2E=2E79e6bae 100644
--- a/src/openvpn/multi=2Ec
+++ b=
/src/openvpn/multi=2Ec
@@ -807,210 +807,205 @@
 static void
 multi_print_st=
atus(struct multi_context *m, struct status_output *so, const int version)
=
 {
-    if (m->hash)
+    struct gc_arena gc_top =3D gc_new();
+    struct =
hash_iterator hi;
+    const struct hash_element *he;
+
+    status_reset(s=
o);
+
+    if (dco_enabled(&m->top=2Eoptions))
     {
-        struct gc_ar=
ena gc_top =3D gc_new();
-        struct hash_iterator hi;
-        const s=
truct hash_element *he;
-
-        status_reset(so);
-
-        if (dco_ena=
bled(&m->top=2Eoptions))
+        if (dco_get_peer_stats_multi(&m->top=2Ec1=
=2Etuntap->dco, true) < 0)
         {
-            if (dco_get_peer_stats_m=
ulti(&m->top=2Ec1=2Etuntap->dco, true) < 0)
+            return;
+        }=

+    }
+
+    if (version =3D=3D 1)
+    {
+        /*
+         * Status =
file version 1
+         */
+        status_printf(so, "OpenVPN CLIENT LIST=
");
+        status_printf(so, "Updated,%s", time_string(0, 0, false, &gc_t=
op));
+        status_printf(so, "Common Name,Real Address,Bytes Received,B=
ytes Sent,Connected Since");
+
+        for (uint32_t i =3D 0; i <=3D m->ma=
x_peerid; i++)
+        {
+            const struct multi_instance *mi =3D =
m->instances[i];
+
+            struct gc_arena gc =3D gc_new();
+         =
   if (mi && !mi->halt)
             {
-                return;
+          =
      status_printf(so, "%s,%s," counter_format "," counter_format ",%s",
+=
                              tls_common_name(mi->context=2Ec2=2Etls_multi,=
 false),
+                              mroute_addr_print(&mi->real, &gc),
=
+                              mi->context=2Ec2=2Elink_read_bytes + mi->con=
text=2Ec2=2Edco_read_bytes,
+                              mi->context=2Ec2=
=2Elink_write_bytes + mi->context=2Ec2=2Edco_write_bytes,
+                =
              time_string(mi->created, 0, false, &gc));
             }
+   =
         gc_free(&gc);
         }
 
-        if (version =3D=3D 1)
+       =
 status_printf(so, "ROUTING TABLE");
+        status_printf(so, "Virtual Ad=
dress,Common Name,Real Address,Last Ref");
+        hash_iterator_init(m->v=
hash, &hi);
+        while ((he =3D hash_iterator_next(&hi)))
         {
- =
           /*
-             * Status file version 1
-             */
-     =
       status_printf(so, "OpenVPN CLIENT LIST");
-            status_printf=
(so, "Updated,%s", time_string(0, 0, false, &gc_top));
-            status_=
printf(so, "Common Name,Real Address,Bytes Received,Bytes Sent,Connected Si=
nce");
-            hash_iterator_init(m->hash, &hi);
-            while ((=
he =3D hash_iterator_next(&hi)))
-            {
-                struct gc_=
arena gc =3D gc_new();
-                const struct multi_instance *mi =3D=
 (struct multi_instance *)he->value;
+            struct gc_arena gc =3D gc=
_new();
+            const struct multi_route *route =3D (struct multi_rout=
e *)he->value;
 
-                if (!mi->halt)
+            if (multi_rou=
te_defined(m, route))
+            {
+                const struct multi_in=
stance *mi =3D route->instance;
+                const struct mroute_addr *=
ma =3D &route->addr;
+                char flags[2] =3D { 0, 0 };
+
+      =
          if (route->flags & MULTI_ROUTE_CACHE)
                 {
-       =
             status_printf(so, "%s,%s," counter_format "," counter_format "=
,%s",
-                                  tls_common_name(mi->context=2Ec2=
=2Etls_multi, false),
-                                  mroute_addr_print(=
&mi->real, &gc),
-                                  mi->context=2Ec2=2Elink=
_read_bytes + mi->context=2Ec2=2Edco_read_bytes,
-                         =
         mi->context=2Ec2=2Elink_write_bytes + mi->context=2Ec2=2Edco_write=
_bytes,
-                                  time_string(mi->created, 0, fals=
e, &gc));
+                    flags[0] =3D 'C';
                 }
-      =
          gc_free(&gc);
+                status_printf(so, "%s%s,%s,%s,%s",=
 mroute_addr_print(ma, &gc), flags,
+                              tls_comm=
on_name(mi->context=2Ec2=2Etls_multi, false),
+                            =
  mroute_addr_print(&mi->real, &gc),
+                              time_st=
ring(route->last_reference, 0, false, &gc));
             }
-            ha=
sh_iterator_free(&hi);
-
-            status_printf(so, "ROUTING TABLE");
-=
            status_printf(so, "Virtual Address,Common Name,Real Address,Las=
t Ref");
-            hash_iterator_init(m->vhash, &hi);
-            while=
 ((he =3D hash_iterator_next(&hi)))
-            {
-                struct =
gc_arena gc =3D gc_new();
-                const struct multi_route *route =
=3D (struct multi_route *)he->value;
-
-                if (multi_route_def=
ined(m, route))
-                {
-                    const struct multi_=
instance *mi =3D route->instance;
-                    const struct mroute_=
addr *ma =3D &route->addr;
-                    char flags[2] =3D { 0, 0 };=

-
-                    if (route->flags & MULTI_ROUTE_CACHE)
-            =
        {
-                        flags[0] =3D 'C';
-                    }=

-                    status_printf(so, "%s%s,%s,%s,%s", mroute_addr_print(=
ma, &gc), flags,
-                                  tls_common_name(mi->con=
text=2Ec2=2Etls_multi, false),
-                                  mroute_ad=
dr_print(&mi->real, &gc),
-                                  time_string(ro=
ute->last_reference, 0, false, &gc));
-                }
-                g=
c_free(&gc);
-            }
-            hash_iterator_free(&hi);
-
-      =
      status_printf(so, "GLOBAL STATS");
-            if (m->mbuf)
-       =
     {
-                status_printf(so, "Max bcast/mcast queue length,%d"=
, mbuf_maximum_queued(m->mbuf));
-            }
-
-            status_print=
f(so, "END");
+            gc_free(&gc);
         }
-        else if (versi=
on =3D=3D 2 || version =3D=3D 3)
+        hash_iterator_free(&hi);
+
+     =
   status_printf(so, "GLOBAL STATS");
+        if (m->mbuf)
         {
-   =
         const char sep =3D (version =3D=3D 3) ? '\t' : ',';
+            s=
tatus_printf(so, "Max bcast/mcast queue length,%d", mbuf_maximum_queued(m->=
mbuf));
+        }
 
-            /*
-             * Status file version 2 =
and 3
-             */
-            status_printf(so, "TITLE%c%s", sep, tit=
le_string);
-            status_printf(so, "TIME%c%s%c%u", sep, time_string=
(now, 0, false, &gc_top), sep,
-                          (unsigned int)now=
);
-            status_printf(
-                so,
-                "HEADE=
R%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cVirtual IPv6 Ad=
dress%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t=
)%cUsername%cClient ID%cPeer ID%cData Channel Cipher",
-                sep=
, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
-           =
 hash_iterator_init(m->hash, &hi);
-            while ((he =3D hash_iterato=
r_next(&hi)))
+        status_printf(so, "END");
+    }
+    else if (versi=
on =3D=3D 2 || version =3D=3D 3)
+    {
+        const char sep =3D (versio=
n =3D=3D 3) ? '\t' : ',';
+
+        /*
+         * Status file version 2 a=
nd 3
+         */
+        status_printf(so, "TITLE%c%s", sep, title_string=
);
+        status_printf(so, "TIME%c%s%c%u", sep, time_string(now, 0, fals=
e, &gc_top), sep,
+                      (unsigned int)now);
+        statu=
s_printf(
+            so,
+            "HEADER%cCLIENT_LIST%cCommon Name%c=
Real Address%cVirtual Address%cVirtual IPv6 Address%cBytes Received%cBytes =
Sent%cConnected Since%cConnected Since (time_t)%cUsername%cClient ID%cPeer =
ID%cData Channel Cipher",
+            sep, sep, sep, sep, sep, sep, sep, s=
ep, sep, sep, sep, sep, sep);
+
+        for (uint32_t i =3D 0; i <=3D m->m=
ax_peerid; i++)
+        {
+            const struct multi_instance *mi =3D=
 m->instances[i];
+            struct gc_arena gc =3D gc_new();
+
+        =
    if (mi && !mi->halt)
             {
-                struct gc_arena gc=
 =3D gc_new();
-                const struct multi_instance *mi =3D (struct=
 multi_instance *)he->value;
-
-                if (!mi->halt)
-           =
     {
-                    status_printf(
-                        so,
-  =
                      "CLIENT_LIST%c%s%c%s%c%s%c%s%c" counter_format "%c" c=
ounter_format
-                        "%c%s%c%u%c%s%c"
+                st=
atus_printf(
+                    so,
+                    "CLIENT_LIST%c%s=
%c%s%c%s%c%s%c" counter_format "%c" counter_format
+                    "%c=
%s%c%u%c%s%c"
 #ifdef ENABLE_MANAGEMENT
-                        "%lu"
+   =
                 "%lu"
 #else
-                        ""
+                =
    ""
 #endif
-                        "%c%" PRIu32 "%c%s",
-             =
           sep, tls_common_name(mi->context=2Ec2=2Etls_multi, false), sep,
=
-                        mroute_addr_print(&mi->real, &gc), sep,
-         =
               print_in_addr_t(mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc),=
 sep,
-                        print_in6_addr(mi->reporting_addr_ipv6, IA_E=
MPTY_IF_UNDEF, &gc), sep,
-                        mi->context=2Ec2=2Elink_=
read_bytes + mi->context=2Ec2=2Edco_read_bytes, sep,
-                     =
   mi->context=2Ec2=2Elink_write_bytes + mi->context=2Ec2=2Edco_write_bytes=
, sep,
-                        time_string(mi->created, 0, false, &gc), se=
p, (unsigned int)mi->created,
-                        sep, tls_username(mi=
->context=2Ec2=2Etls_multi, false),
+                    "%c%" PRIu32 "%c%s=
",
+                    sep, tls_common_name(mi->context=2Ec2=2Etls_multi, =
false), sep,
+                    mroute_addr_print(&mi->real, &gc), sep,
+=
                    print_in_addr_t(mi->reporting_addr, IA_EMPTY_IF_UNDEF, =
&gc), sep,
+                    print_in6_addr(mi->reporting_addr_ipv6, IA_=
EMPTY_IF_UNDEF, &gc), sep,
+                    mi->context=2Ec2=2Elink_rea=
d_bytes + mi->context=2Ec2=2Edco_read_bytes, sep,
+                    mi->=
context=2Ec2=2Elink_write_bytes + mi->context=2Ec2=2Edco_write_bytes, sep,
=
+                    time_string(mi->created, 0, false, &gc), sep, (unsigne=
d int)mi->created,
+                    sep, tls_username(mi->context=2Ec2=
=2Etls_multi, false),
 #ifdef ENABLE_MANAGEMENT
-                        se=
p, mi->context=2Ec2=2Emda_context=2Ecid,
+                    sep, mi->cont=
ext=2Ec2=2Emda_context=2Ecid,
 #else
-                        sep,
+       =
             sep,
 #endif
-                        sep, mi->context=2Ec2=2E=
tls_multi ? mi->context=2Ec2=2Etls_multi->rx_peer_id : MAX_PEER_ID,
-      =
                  sep, translate_cipher_name_to_openvpn(mi->context=2Eoptio=
ns=2Eciphername));
-                }
-                gc_free(&gc);
+     =
               sep, mi->context=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls_m=
ulti->rx_peer_id : MAX_PEER_ID,
+                    sep, translate_cipher_=
name_to_openvpn(mi->context=2Eoptions=2Eciphername));
             }
-     =
       hash_iterator_free(&hi);
-
-            status_printf(
-            =
    so,
-                "HEADER%cROUTING_TABLE%cVirtual Address%cCommon Na=
me%cReal Address%cLast Ref%cLast Ref (time_t)",
-                sep, sep, =
sep, sep, sep, sep);
-            hash_iterator_init(m->vhash, &hi);
-     =
       while ((he =3D hash_iterator_next(&hi)))
-            {
-           =
     struct gc_arena gc =3D gc_new();
-                const struct multi_r=
oute *route =3D (struct multi_route *)he->value;
-
-                if (mul=
ti_route_defined(m, route))
-                {
-                    const s=
truct multi_instance *mi =3D route->instance;
-                    const st=
ruct mroute_addr *ma =3D &route->addr;
-                    char flags[2] =
=3D { 0, 0 };
-
-                    if (route->flags & MULTI_ROUTE_CACHE)
=
-                    {
-                        flags[0] =3D 'C';
-        =
            }
-                    status_printf(so, "ROUTING_TABLE%c%s%s%c=
%s%c%s%c%s%c%u", sep,
-                                  mroute_addr_print(=
ma, &gc), flags, sep,
-                                  tls_common_name(mi=
->context=2Ec2=2Etls_multi, false), sep,
-                                 =
 mroute_addr_print(&mi->real, &gc), sep,
-                                 =
 time_string(route->last_reference, 0, false, &gc), sep,
-                 =
                 (unsigned int)route->last_reference);
-                }
-=
                gc_free(&gc);
-            }
-            hash_iterator_fre=
e(&hi);
-
-            if (m->mbuf)
-            {
-                status_=
printf(so, "GLOBAL_STATS%cMax bcast/mcast queue length%c%d", sep, sep,
-   =
                           mbuf_maximum_queued(m->mbuf));
-            }
-
=
-            status_printf(so, "GLOBAL_STATS%cdco_enabled%c%d", sep, sep,
-=
                          dco_enabled(&m->top=2Eoptions));
-            sta=
tus_printf(so, "END");
+            gc_free(&gc);
         }
-        else
=
+
+        status_printf(
+            so,
+            "HEADER%cROUTING_TA=
BLE%cVirtual Address%cCommon Name%cReal Address%cLast Ref%cLast Ref (time_t=
)",
+            sep, sep, sep, sep, sep, sep);
+        hash_iterator_init=
(m->vhash, &hi);
+        while ((he =3D hash_iterator_next(&hi)))
        =
 {
-            status_printf(so, "ERROR: bad status format version number"=
);
+            struct gc_arena gc =3D gc_new();
+            const struct =
multi_route *route =3D (struct multi_route *)he->value;
+
+            if (=
multi_route_defined(m, route))
+            {
+                const struct=
 multi_instance *mi =3D route->instance;
+                const struct mrou=
te_addr *ma =3D &route->addr;
+                char flags[2] =3D { 0, 0 };
=
+
+                if (route->flags & MULTI_ROUTE_CACHE)
+                {=

+                    flags[0] =3D 'C';
+                }
+               =
 status_printf(so, "ROUTING_TABLE%c%s%s%c%s%c%s%c%s%c%u", sep,
+           =
                   mroute_addr_print(ma, &gc), flags, sep,
+               =
               tls_common_name(mi->context=2Ec2=2Etls_multi, false), sep,
+=
                              mroute_addr_print(&mi->real, &gc), sep,
+    =
                          time_string(route->last_reference, 0, false, &gc)=
, sep,
+                              (unsigned int)route->last_reference);=

+            }
+            gc_free(&gc);
         }
+        hash_iterato=
r_free(&hi);
+
+        if (m->mbuf)
+        {
+            status_printf(=
so, "GLOBAL_STATS%cMax bcast/mcast queue length%c%d", sep, sep,
+          =
                mbuf_maximum_queued(m->mbuf));
+        }
+
+        status=
_printf(so, "GLOBAL_STATS%cdco_enabled%c%d", sep, sep,
+                   =
   dco_enabled(&m->top=2Eoptions));
+        status_printf(so, "END");
+   =
 }
+    else
+    {
+        status_printf(so, "ERROR: bad status format ve=
rsion number");
+    }
 
 #ifdef PACKET_TRUNCATION_CHECK
+    {
+        st=
atus_printf(so, "HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,P=
re-encrypt Trunc,Post-decrypt Trunc");
+        hash_iterator_init(m->hash,=
 &hi);
+        while ((he =3D hash_iterator_next(&hi)))
         {
-      =
      status_printf(so, "HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write=
 Trunc,Pre-encrypt Trunc,Post-decrypt Trunc");
-            hash_iterator_i=
nit(m->hash, &hi);
-            while ((he =3D hash_iterator_next(&hi)))
- =
           {
-                struct gc_arena gc =3D gc_new();
-           =
     const struct multi_instance *mi =3D (struct multi_instance *)he->value=
;
+            struct gc_arena gc =3D gc_new();
+            const struct m=
ulti_instance *mi =3D (struct multi_instance *)he->value;
 
-              =
  if (!mi->halt)
-                {
-                    status_printf(so,
=
-                                  "ERRORS,%s," counter_format "," counter_=
format "," counter_format
-                                  "," counter_fo=
rmat,
-                                  tls_common_name(mi->context=2Ec2=
=2Etls_multi, false),
-                                  m->top=2Ec2=2En_tr=
unc_tun_read, mi->context=2Ec2=2En_trunc_tun_write,
-                      =
            mi->context=2Ec2=2En_trunc_pre_encrypt,
-                      =
            mi->context=2Ec2=2En_trunc_post_decrypt);
-                }
- =
               gc_free(&gc);
+            if (!mi->halt)
+            {
+  =
              status_printf(so,
+                              "ERRORS,%s,"=
 counter_format "," counter_format "," counter_format
+                    =
          "," counter_format,
+                              tls_common_nam=
e(mi->context=2Ec2=2Etls_multi, false),
+                              m->t=
op=2Ec2=2En_trunc_tun_read, mi->context=2Ec2=2En_trunc_tun_write,
+        =
                      mi->context=2Ec2=2En_trunc_pre_encrypt,
+            =
                  mi->context=2Ec2=2En_trunc_post_decrypt);
             }
=
-            hash_iterator_free(&hi);
+            gc_free(&gc);
         }=

+        hash_iterator_free(&hi);
+    }
 #endif /* ifdef PACKET_TRUNCATIO=
N_CHECK */
 
-        status_flush(so);
-        gc_free(&gc_top);
-    }
+=
    status_flush(so);
+    gc_free(&gc_top);
 
 #ifdef ENABLE_ASYNC_PUSH
  =
   if (m->inotify_watchers)

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2065?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Iefd88cd537fa301d47a0c80d6fa520053c092bb3
Gerrit-Change-Number: =
2065
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--jTON/d9kzaQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2065?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Use m-&gt;instances instead of m-&gt;hash to iterate clients i=
n status<br><br>This simplifies the code a bit and also fixes a problem int=
roduced by<br>66f8cdb that connections in the early stages of connection ar=
e not shown<br>in the status file (e=2Eg=2E telnet openvpn-server 1194)=2E<=
br><br>Since this removes an indentation area, it is best to look at the ch=
anges<br>of this commit while ignoring white-space changes=2E<br><br>Change=
-Id: Iefd88cd537fa301d47a0c80d6fa520053c092bb3<br>Signed-off-by: Arne Schwa=
be &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file c=
hanged, 166 insertions(+), 171 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/2065/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><s=
pan>index 82757f4=2E=2E79e6bae 100644</span><br><span>--- a/src/openvpn/mul=
ti=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -807,=
210 +807,205 @@</span><br><span> static void</span><br><span> multi_print_s=
tatus(struct multi_context *m, struct status_output *so, const int version)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (m-&gt;hash)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc_top =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct hash_iterator hi;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const struct hash_element *he;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    status_reset(so);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (dco_enabled(&amp;m-&gt;top=2Eoptions))</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct gc_ar=
ena gc_top =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        struct hash_iterator hi;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        const struct hash_element *he;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        status_reset(so);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (dco_enabled(&amp;m-&gt;top=2Eoptions))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (dco_get_peer_stats_multi(&amp;m-&gt;to=
p=2Ec1=2Etuntap-&gt;dco, true) &lt; 0)</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            if (dco_get_peer_st=
ats_multi(&amp;m-&gt;top=2Ec1=2Etuntap-&gt;dco, true) &lt; 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (version =3D=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * Statu=
s file version 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sta=
tus_printf(so, &quot;OpenVPN CLIENT LIST&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        status_printf(so, &quot;Updated,%s&quo=
t;, time_string(0, 0, false, &amp;gc_top));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        status_printf(so, &quot;Common Name,Real Ad=
dress,Bytes Received,Bytes Sent,Connected Since&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        for (uint32_t i =3D 0; i &lt;=3D m-&gt;max_peerid;=
 i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            const struct=
 multi_instance *mi =3D m-&gt;instances[i];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (mi &amp;&amp; !mi-&gt;halt)</=
span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                return;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                status_printf(so, &quot;%s,%s,&quot; counter_fo=
rmat &quot;,&quot; counter_format &quot;,%s&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                              tls_common_nam=
e(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                              mroute_addr_print(&amp=
;mi-&gt;real, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                              mi-&gt;context=2Ec2=2Elink_read_bytes + m=
i-&gt;context=2Ec2=2Edco_read_bytes,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                              mi-&gt;context=2Ec2=2Elink_w=
rite_bytes + mi-&gt;context=2Ec2=2Edco_write_bytes,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                              time_string=
(mi-&gt;created, 0, false, &amp;gc));</span><br><span>             }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;g=
c);</span><br><span>         }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (version =3D=3D 1)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        status_printf(so, &quot;ROUTIN=
G TABLE&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    status_printf(so, &quot;Virtual Address,Common Name,Real Address,Last R=
ef&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        h=
ash_iterator_init(m-&gt;vhash, &amp;hi);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        while ((he =3D hash_iterator_next(&amp;hi)))</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
          * Status file version 1</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-             */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            status_printf(so, &quot;OpenVPN CLIENT LIST&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            status_printf(s=
o, &quot;Updated,%s&quot;, time_string(0, 0, false, &amp;gc_top));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            status_printf(so, =
&quot;Common Name,Real Address,Bytes Received,Bytes Sent,Connected Since&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            hash=
_iterator_init(m-&gt;hash, &amp;hi);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            while ((he =3D hash_iterator_next(&amp;hi)))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          const struct multi_instance *mi =3D (struct multi_instance *)he-&=
gt;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            const struct multi_route *route =3D (struct mult=
i_route *)he-&gt;value;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                if (!mi-&gt;halt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (multi_route_defined(m, ro=
ute))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                cons=
t struct multi_instance *mi =3D route-&gt;instance;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                const struct mroute_addr =
*ma =3D &amp;route-&gt;addr;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                char flags[2] =3D { 0, 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                if (route-&gt;flags &amp; MULTI_ROUTE_CACHE)=
</span><br><span>                 {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    status_printf(so, &quot;%s,%s,&quot; coun=
ter_format &quot;,&quot; counter_format &quot;,%s&quot;,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                  tls_co=
mmon_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                  mroute_addr_=
print(&amp;mi-&gt;real, &amp;gc),</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                  mi-&gt;context=2Ec2=2Elink_re=
ad_bytes + mi-&gt;context=2Ec2=2Edco_read_bytes,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                  mi-&gt;context=
=2Ec2=2Elink_write_bytes + mi-&gt;context=2Ec2=2Edco_write_bytes,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
   time_string(mi-&gt;created, 0, false, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    flags[0] =3D &#39;C&#=
39;;</span><br><span>                 }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                status_printf(so, &quot;%=
s%s,%s,%s,%s&quot;, mroute_addr_print(ma, &amp;gc), flags,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                              tls_co=
mmon_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                              mroute_addr_pr=
int(&amp;mi-&gt;real, &amp;gc),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                              time_string(route-&gt;last_refere=
nce, 0, false, &amp;gc));</span><br><span>             }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            hash_iterator_free(&amp;hi);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            status_printf(so, &quot;ROUTIN=
G TABLE&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      status_printf(so, &quot;Virtual Address,Common Name,Real Address,Last=
 Ref&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   hash_iterator_init(m-&gt;vhash, &amp;hi);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            while ((he =3D hash_iterator_next(&amp;h=
i)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                const struct multi_route *route =3D (struct multi_route *=
)he-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                if (multi_ro=
ute_defined(m, route))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 const struct multi_instance *mi =3D route-&gt;instance;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    cons=
t struct mroute_addr *ma =3D &amp;route-&gt;addr;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    char flags[2] =3D { 0, 0 };=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    if (route-&gt;flags &a=
mp; MULTI_ROUTE_CACHE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                        flags[0] =3D &#39;C&#39;;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    status_printf(so, &quot;%s=
%s,%s,%s,%s&quot;, mroute_addr_print(ma, &amp;gc), flags,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                  tls_c=
ommon_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                  mroute_ad=
dr_print(&amp;mi-&gt;real, &amp;gc),</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                  time_string(route-&gt;last=
_reference, 0, false, &amp;gc));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                gc_free(&amp;gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            hash_iterator_free(&amp;hi);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            status_printf(so, &quot;GLOBAL STATS&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (m-&gt;mbuf)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                status_printf(s=
o, &quot;Max bcast/mcast queue length,%d&quot;, mbuf_maximum_queued(m-&gt;m=
buf));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            status_printf(so, &quot;END&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_=
free(&amp;gc);</span><br><span>         }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else if (version =3D=3D 2 || version =3D=3D 3)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hash_iterato=
r_free(&amp;hi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        status_printf(=
so, &quot;GLOBAL STATS&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (m-&gt;mbuf)</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            const char sep =3D (ver=
sion =3D=3D 3) ? &#39;\t&#39; : &#39;,&#39;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            status_printf(so, &quot;Max bcast/mcas=
t queue length,%d&quot;, mbuf_maximum_queued(m-&gt;mbuf));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            /*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-             * Status file version 2 =
and 3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            status_pri=
ntf(so, &quot;TITLE%c%s&quot;, sep, title_string);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            status_printf(so, &quot;TIME%c%s%c=
%u&quot;, sep, time_string(now, 0, false, &amp;gc_top), sep,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                          (unsigned =
int)now);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
status_printf(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         so,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       &quot;HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Addres=
s%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnected Since%cConne=
cted Since (time_t)%cUsername%cClient ID%cPeer ID%cData Channel Cipher&quot=
;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                sep=
, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            hash_iterator_init(m-&=
gt;hash, &amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         while ((he =3D hash_iterator_next(&amp;hi)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        status_printf(so, &quot;END&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else if (version =3D=3D 2 |=
| version =3D=3D 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
char sep =3D (version =3D=3D 3) ? &#39;\t&#39; : &#39;,&#39;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * Status file version 2 and 3</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        status_printf(so, &quot;TITLE%c%s&quot;, =
sep, title_string);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        status_printf(so, &quot;TIME%c%s%c%u&quot;, sep, time_string(now, 0=
, false, &amp;gc_top), sep,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                      (unsigned int)now);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        status_printf(</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            so,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;HEADER%cCLIENT_LIST%cCommon=
 Name%cReal Address%cVirtual Address%cVirtual IPv6 Address%cBytes Received%=
cBytes Sent%cConnected Since%cConnected Since (time_t)%cUsername%cClient ID=
%cPeer ID%cData Channel Cipher&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            sep, sep, sep, sep, sep, sep, sep, sep, sep, =
sep, sep, sep, sep);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (uint3=
2_t i =3D 0; i &lt;=3D m-&gt;max_peerid; i++)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            const struct multi_instance *mi =3D m-&gt;insta=
nces[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (mi &amp;&amp; !mi-&gt;halt)</span><br><span>             {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                const struct multi_instance *mi =3D (struct multi_instance =
*)he-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (!mi-&gt=
;halt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 status_printf(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  so,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        &quot;CLIENT_LIST%c%s%c%s%c%s%c%s%c&quot; counter_f=
ormat &quot;%c&quot; counter_format</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                        &quot;%c%s%c%u%c%s%c&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                status_printf(=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 so,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     &quot;CLIENT_LIST%c%s%c%s%c%s%c%s%c&quot; counter_format &quot;%c&quot=
; counter_format</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 &quot;%c%s%c%u%c%s%c&quot;</span><br><span> #ifdef ENABLE_=
MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
             &quot;%lu&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    &quot;%lu&quot;</span><br><span> #else</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        &quot=
;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        &quot;&quot;</span><br><span> #endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        &quot;%c%&quot; PRIu32 &quot=
;%c%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
               sep, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false)=
, sep,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
         mroute_addr_print(&amp;mi-&gt;real, &amp;gc), sep,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                        print_in_addr=
_t(mi-&gt;reporting_addr, IA_EMPTY_IF_UNDEF, &amp;gc), sep,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                        print_in6_add=
r(mi-&gt;reporting_addr_ipv6, IA_EMPTY_IF_UNDEF, &amp;gc), sep,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                        mi-&gt;co=
ntext=2Ec2=2Elink_read_bytes + mi-&gt;context=2Ec2=2Edco_read_bytes, sep,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 mi-&gt;context=2Ec2=2Elink_write_bytes + mi-&gt;context=2Ec2=2Edco_write_b=
ytes, sep,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
             time_string(mi-&gt;created, 0, false, &amp;gc), sep, (unsigned=
 int)mi-&gt;created,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       sep, tls_username(mi-&gt;context=2Ec2=2Etls_multi, f=
alse),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       &quot;%c%&quot; PRIu32 &quot;%c%s&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    sep, tls_common_name(mi-&gt=
;context=2Ec2=2Etls_multi, false), sep,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    mroute_addr_print(&amp;mi-&gt;real,=
 &amp;gc), sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                print_in_addr_t(mi-&gt;reporting_addr, IA_EMPTY_IF_UNDEF, &=
amp;gc), sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              print_in6_addr(mi-&gt;reporting_addr_ipv6, IA_EMPTY_IF_UNDEF,=
 &amp;gc), sep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                mi-&gt;context=2Ec2=2Elink_read_bytes + mi-&gt;context=2Ec2=
=2Edco_read_bytes, sep,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    mi-&gt;context=2Ec2=2Elink_write_bytes + mi-&gt;con=
text=2Ec2=2Edco_write_bytes, sep,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    time_string(mi-&gt;created, 0, false, &am=
p;gc), sep, (unsigned int)mi-&gt;created,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    sep, tls_username(mi-&gt;context=
=2Ec2=2Etls_multi, false),</span><br><span> #ifdef ENABLE_MANAGEMENT</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        sep,=
 mi-&gt;context=2Ec2=2Emda_context=2Ecid,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    sep, mi-&gt;context=2Ec2=2Emda_co=
ntext=2Ecid,</span><br><span> #else</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                        sep,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    sep,</span><br><span> #endif</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                        s=
ep, mi-&gt;context=2Ec2=2Etls_multi ? mi-&gt;context=2Ec2=2Etls_multi-&gt;r=
x_peer_id : MAX_PEER_ID,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        sep, translate_cipher_name_to_openvpn(mi-&gt;con=
text=2Eoptions=2Eciphername));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    sep, mi-&gt;context=2Ec2=2Etls_multi=
 ? mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id : MAX_PEER_ID,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    sep, trans=
late_cipher_name_to_openvpn(mi-&gt;context=2Eoptions=2Eciphername));</span>=
<br><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            hash_iterator_free(&amp;hi);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            status_printf(</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                so,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                &quot;HEADER%cROUTING_TABLE%cVirtual Address%cCommon Na=
me%cReal Address%cLast Ref%cLast Ref (time_t)&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                sep, sep, sep, sep, sep, se=
p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            hash_i=
terator_init(m-&gt;vhash, &amp;hi);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            while ((he =3D hash_iterator_next(&amp;hi)))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         const struct multi_route *route =3D (struct multi_route *)he-&gt;v=
alue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                if (multi_route_defin=
ed(m, route))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        const struct multi_instance *mi =3D route-&gt;instance;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    const struct =
mroute_addr *ma =3D &amp;route-&gt;addr;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    char flags[2] =3D { 0, 0 };</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    if (route-&gt;flags &amp; MULTI=
_ROUTE_CACHE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                flags[0] =3D &#39;C&#39;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    status_printf(so, &quot;ROUTING_TAB=
LE%c%s%s%c%s%c%s%c%s%c%u&quot;, sep,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                  mroute_addr_print(ma, &amp=
;gc), flags, sep,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                              tls_common_name(mi-&gt;context=2Ec2=2Etls_mul=
ti, false), sep,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                             mroute_addr_print(&amp;mi-&gt;real, &amp;gc), =
sep,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                 time_string(route-&gt;last_reference, 0, false, &amp;gc), =
sep,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                 (unsigned int)route-&gt;last_reference);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            hash_iterator_free(&amp;hi)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            if (m-&gt;mbuf)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                status_printf(so, &quot;GLO=
BAL_STATS%cMax bcast/mcast queue length%c%d&quot;, sep, sep,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                              mbuf_m=
aximum_queued(m-&gt;mbuf));</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            status_prin=
tf(so, &quot;GLOBAL_STATS%cdco_enabled%c%d&quot;, sep, sep,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                          dco_enabled=
(&amp;m-&gt;top=2Eoptions));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            status_printf(so, &quot;END&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br>=
<span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        status_printf(</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            so,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;HEADER%cROUTIN=
G_TABLE%cVirtual Address%cCommon Name%cReal Address%cLast Ref%cLast Ref (ti=
me_t)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     sep, sep, sep, sep, sep, sep);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        hash_iterator_init(m-&gt;vhash, &amp;hi);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        while ((he =3D hash_i=
terator_next(&amp;hi)))</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            status_printf(so, &quot;ERROR: bad=
 status format version number&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            struct gc_arena gc =3D gc_new();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            const struct multi_r=
oute *route =3D (struct multi_route *)he-&gt;value;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (multi_route_defined(m, route))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                const struct multi_inst=
ance *mi =3D route-&gt;instance;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                const struct mroute_addr *ma =3D &amp;route-&g=
t;addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    char flags[2] =3D { 0, 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         if (route-&gt;flags &amp; MULTI_ROUTE_CACHE)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    flags[0] =3D &#39;C&#=
39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                s=
tatus_printf(so, &quot;ROUTING_TABLE%c%s%s%c%s%c%s%c%s%c%u&quot;, sep,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
      mroute_addr_print(ma, &amp;gc), flags, sep,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                              tls_common_name=
(mi-&gt;context=2Ec2=2Etls_multi, false), sep,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                              mroute_addr_print(=
&amp;mi-&gt;real, &amp;gc), sep,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                              time_string(route-&gt;last_refer=
ence, 0, false, &amp;gc), sep,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                              (unsigned int)route-&gt;last_refer=
ence);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free=
(&amp;gc);</span><br><span>         }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        hash_iterator_free(&amp;hi);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (m-&gt;mbuf)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            status_printf(so, &quot;GLOBAL_STATS%cMax bcast/mcast=
 queue length%c%d&quot;, sep, sep,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                          mbuf_maximum_queued(m-&gt;mbuf));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        status_printf(so, &quot;GLOBAL_STATS%cdco=
_enabled%c%d&quot;, sep, sep,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                      dco_enabled(&amp;m-&gt;top=2Eoptions));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        status_printf(s=
o, &quot;END&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        status_printf(so, &quot;ERROR:=
 bad status format version number&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span> </span><br><span> #ifdef PACKE=
T_TRUNCATION_CHECK</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status_=
printf(so, &quot;HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,P=
re-encrypt Trunc,Post-decrypt Trunc&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        hash_iterator_init(m-&gt;hash, &amp;hi);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        while ((he =3D=
 hash_iterator_next(&amp;hi)))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            status_printf(so, &quot;HEA=
DER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,Pos=
t-decrypt Trunc&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            hash_iterator_init(m-&gt;hash, &amp;hi);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            while ((he =3D hash_iterator_n=
ext(&amp;hi)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                const struct multi_instance *mi =3D (struct mul=
ti_instance *)he-&gt;value;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            const struct multi_instance *=
mi =3D (struct multi_instance *)he-&gt;value;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                if (!mi-&gt;halt)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    statu=
s_printf(so,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                         &quot;ERRORS,%s,&quot; counter_format &quot;,&quot=
; counter_format &quot;,&quot; counter_format</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                  &quot;,&quot; cou=
nter_format,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                         tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, f=
alse),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                   m-&gt;top=2Ec2=2En_trunc_tun_read, mi-&gt;context=2Ec2=
=2En_trunc_tun_write,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                  mi-&gt;context=2Ec2=2En_trunc_pre_encrypt=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
              mi-&gt;context=2Ec2=2En_trunc_post_decrypt);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (!mi-&gt;halt=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                status_p=
rintf(so,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                    &quot;ERRORS,%s,&quot; counter_format &quot;,&quot; cou=
nter_format &quot;,&quot; counter_format</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                              &quot;,&quot; counter_fo=
rmat,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
        m-&gt;top=2Ec2=2En_trunc_tun_read, mi-&gt;context=2Ec2=2En_trunc_tu=
n_write,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                   mi-&gt;context=2Ec2=2En_trunc_pre_encrypt,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                              mi-=
&gt;context=2Ec2=2En_trunc_post_decrypt);</span><br><span>             }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            hash_iterato=
r_free(&amp;hi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         gc_free(&amp;gc);</span><br><span>         }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        hash_iterator_free(&amp;hi);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #=
endif /* ifdef PACKET_TRUNCATION_CHECK */</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        status_flush(so);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc_top);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    status_flush(so);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc_top);</span><br><=
span> </span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>     if (m=
-&gt;inotify_watchers)</span><br></pre><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2065?usp=3Demail">change 2065</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2065?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefd88cd537=
fa301d47a0c80d6fa520053c092bb3 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 2065 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--jTON/d9kzaQ=--


--===============6740772628905465034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6740772628905465034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6740772628905465034==--

