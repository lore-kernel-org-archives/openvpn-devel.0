Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EDFC5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f84XSesk22mGD40hMPycat5ry9bB7x0OeaTKWL7ix94=; b=XXCFrgPoJENDApm0UW799Ou1QC
	vZRfclqEj4ZszeWZM8g6Et401IoSqhLf9uT1IhpEjFj3vZ5Gi3r/jIgU0VjsOd2CbODZiRdh9odSK
	KdpJGEcWab7emH0xbGY/t3CKnshiIcudANHM6gWJJMKcVguZnP6CcGVrHUwtqOv+uNQY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiCU-0002Qu-FF;
	Wed, 19 Aug 2026 15:27:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiCT-0002Qh-6u
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:27:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Mqg8TGv7zjGsM4u94MF0Hjc+q1FpGxtErN//gHbosAk=; b=IVMynDMsc33Wc82ofImDQbE/OY
 Lr0e/AP/VeGMKbmRGgNYFltOvK4KtnaMiEERswiqPDt+IInsU6rAl/NqRH9rGh42yCk7Bbh5D0B0R
 tbBuItncax36mlFgh1KxyxUEjQqR71MCru5nfv6OOKiDvk/KID2RGZFu3cPZdlcH049s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Mqg8TGv7zjGsM4u94MF0Hjc+q1FpGxtErN//gHbosAk=; b=C
 RuWmRCbGSgRDdCZ9LSu7a4CTHuHHcXHNHibg9CJJbzbOBH0TEcb8k1yaOVtGjteATL1eMXW/yp4gN
 XHRPtvsuuaNfNC7bHazZURtYeMdXIfouj6j+Wr6NJP8IoKb/c2Ib+d6U25mdrwSnGsNtb4vFNkRMC
 CxfrlVvXawUM2K1k=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiCR-000731-Us for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:27:33 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so693511f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787153245; x=1787758045; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mqg8TGv7zjGsM4u94MF0Hjc+q1FpGxtErN//gHbosAk=;
 b=axCXGfkfmd2GmuopanqMIDSkDxXVESQkdSGtgGce/2MXzNXSLhmXgtFQhtcGPmpTNZ
 VqIvcO04SucaPk6IVMBqgWMa1j0ubFom3Lh1/rz5iReqW7kDBDDFInaZic9gNUOV2qgB
 uc6+6/XIgef6+2cUGRnsXvKKfQmOaZ+VxajbgijWfdUxsF1O+T9t1ZCwpuL541p3YTcw
 jy5NserSLQTqBciNOAcpahjGCecA7iQWGbKrrEj/0ZeQR2UI5sttNE93T5jHa2r4X/7g
 9Og4JL/S6NfGt4CZK+A2uIGmH1jZR+tqsqNmLMXGrq/MqEHxOJ7BCM0JHFwWUVi/ubKR
 dXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787153245; x=1787758045;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Mqg8TGv7zjGsM4u94MF0Hjc+q1FpGxtErN//gHbosAk=;
 b=htLDtmx/2t75p+BWV2YhKfKnApku3cThwUrdDVImnpm/0vZGLQhsushQcHeilz8bKh
 N8DX20I5KsZsIx2lXAk/vNWU5PORq24tc9lRGpjX2fWJec/Li0zkIwozv29I0KHTIgxS
 PQdZgWqC8bDokC9imd2FiL+s3nIQ9qkmlThfM2qjvXFGxlMR0ctAemESBdTZHdimmSZe
 vaDq6G6Lg5R97EkVv+wxkvB7+hYp3bi2tXYveXeddq3b4rRNXkhi4ykCRnHgAF0P4OiB
 dttCG61EJshobT306h1JWHVebztEgmUQQu/ko6QhxeBmVDWyZutwmm6dFaEJGFTXrYD0
 QXhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrexfQ4dHzgaU4hzKsEJ37TD4oqDVKQt7FLYZbRFAXoRjd2Ede96BPEH+jocTlnwL99vO3nI6DpIoPSOTWU@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyHFJakQHG9vPE0sq0N+VSkZruUV14htoHcD/hdOMbHnuSY1zhm
 t7Lj87v0KSmwmeIYGvTB8boTAcd4BxmUcoY1r0tbCL/CIYWnZRfodDfd87rbudIJZXOrcPVnQqm
 CSlgCp3KdFl1WIPB0glT5rbwWW+x9+A3vyY4E66Nq2bSlyzgAPlKxq4cKXoV/2uqhGdXE
X-Gm-Gg: AR+sD13Gh+cgaQL7KUn6sASZL3N51PZo/9WUl2co0eowrWThONMr4CBX0kgcObLW7gA
 UC8RkqcZzvGgRNrV8W5+SdvvxCjpHFBTdwBOkd/boR/CAKLEsL28Rw6lsa4HUHYThSz+ULoqHb8
 TKAMNdXVWm91Dmchaj8uGczS62egdpLaffdSSxVTeOXI0MNDHfDdApIJFTgA5PTdT7utVKbBlMk
 tPchERmw2E/6+stRU3ouRWqOjCG53ul7qaosBVpnv9GyU9HXhd79Mx+iLYOzaNgpQ8xGLpjuWd2
 njzjP0/gTbNGpCVTKfr5pHHuqn7QdEnXC49D9mvQZYiyukmno2GN0luD8JDyy2cuFLzJftC2HmX
 gZpRmVjAvo87izGw6U3cpcFlL7/GpxzL3xPKYEjOV5yOx6Z2rL0lnZoZ29Ypk6K/oJPkNk9vAfL
 AkpkTs8lgu+5ibYG6mJM+BThrEpnuN7pfMBsUQ3VwWpd0gsQuxQGvqEGyPZlYGM0U+Cg9wSXCCO
 ePLgW87i41tZA87Tuj6R1GEMY7vsJNEEs+AlbZun9IDJvH4XbWBSVKUJThSQU/dvXaFzgy/ck53
 13DGldKyPpsuD3ZjXJ4+ngMFiiQmdpNmMaDd7V3GKu+ThAHa8Yk=
X-Received: by 2002:a05:600d:8495:10b0:499:adb4:a922 with SMTP id
 5b1f17b1804b1-499adb4a9camr60537685e9.12.1787153245083; 
 Wed, 19 Aug 2026 08:27:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b145d31bsm6220259f8f.16.2026.08.19.08.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:27:24 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:27:14 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
X-Gerrit-Change-Number: 1618
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1618?usp=email>
X-Gerrit-Commit: 9db55fc7a831e6705c3602577b82d1e6a264b167
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLkk1MjhmNWZkMjAwZDg3Nzg0MWU0NzNlNWUwNWI3YWM3OTE1ZmEyZTMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a8bc307dae767d98fbd254d1dd0ee047359fde67-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiCR-000731-Us
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename variables
 that shadow other variables or functions
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5273062878660579738=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5273062878660579738==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="I197Nx2Oskw="; charset=UTF-8

--I197Nx2Oskw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

Hello plaistho=
s, 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail

to look at the new patch set=
 (#14)=2E


Change subject: Rename variables that shadow other variables or=
 functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

R=
ename variables that shadow other variables or functions

Identified by cpp=
check=2E

Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
Signed-off-b=
y: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/manage=2Ec=

M src/openvpn/options=2Ec
M src/openvpn/ps=2Ec
M src/openvpn/tls_crypt=2Ec=

M src/openvpnserv/interactive=2Ec
M tests/unit_tests/openvpn/test_dhcp=2Ec=

M tests/unit_tests/openvpn/test_push_update_msg=2Ec
7 files changed, 49 in=
sertions(+), 52 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/18/1618/14

diff --git a/src/openvpn/manage=2Ec b/sr=
c/openvpn/manage=2Ec
index f1dccc1=2E=2Ec082f51 100644
--- a/src/openvpn/ma=
nage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -1328,8 +1328,6 @@
 static void
 m=
an_load_stats(struct management *man)
 {
-    extern counter_type link_read=
_bytes_global;
-    extern counter_type link_write_bytes_global;
     int n=
clients =3D 0;
 
     if (man->persist=2Ecallback=2En_clients)
diff --git a=
/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 147b31e=2E=2E1de76=
72 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -2=
080,12 +2080,12 @@
                     "may accept clients which do not pr=
esent a certificate");
     }
 
-    const unsigned int tls_version_max =3D=

+    const unsigned int tls_ver_max =3D
         (options->ssl_flags >> SS=
LF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
-    const unsigned =
int tls_version_min =3D
+    const unsigned int tls_ver_min =3D
         (o=
ptions->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MAS=
K;
 
-    if (tls_version_max > 0 && tls_version_max < tls_version_min)
+  =
  if (tls_ver_max > 0 && tls_ver_max < tls_ver_min)
     {
         msg(M_U=
SAGE, "--tls-version-min bigger than --tls-version-max");
     }
@@ -3032,1=
6 +3032,16 @@
         {
             struct dns_domain **entry =3D &dns->s=
earch_domains;
             ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &=
dns->gc);
-            struct dns_domain *new =3D *entry;
-            new-=
>name =3D dhcp->domain;
-            entry =3D &new->next;
+            str=
uct dns_domain *domain =3D *entry;
+            domain->name =3D dhcp->doma=
in;
+            entry =3D &domain->next;
 
             for (unsigned int =
i =3D 0; i < dhcp->domain_search_list_len; ++i)
             {
            =
     ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
-            =
    struct dns_domain *new =3D *entry;
-                new->name =3D dhcp-=
>domain_search_list[i];
-                entry =3D &new->next;
+           =
     struct dns_domain *search_domain =3D *entry;
+                search_d=
omain->name =3D dhcp->domain_search_list[i];
+                entry =3D &se=
arch_domain->next;
             }
 
             struct dns_server *server =
=3D dns_server_get(&dns->servers, 0, &dns->gc);
@@ -3134,7 +3134,6 @@
 stat=
ic void
 options_postprocess_mutate(struct options *o, struct env_set *es)
=
 {
-    int i;
     /*
      * Process helper-type options which map to oth=
er, more complex
      * sequences of options=2E
@@ -3167,7 +3166,7 @@
    =
      * Convert remotes into connection list
          */
         const st=
ruct remote_list *rl =3D o->remote_list;
-        for (i =3D 0; i < rl->len=
; ++i)
+        for (int i =3D 0; i < rl->len; ++i)
         {
            =
 const struct remote_entry *re =3D rl->array[i];
             struct connec=
tion_entry ce =3D o->ce;
@@ -3189,14 +3188,14 @@
     }
 
     ASSERT(o->co=
nnection_list);
-    for (i =3D 0; i < o->connection_list->len; ++i)
+    f=
or (int i =3D 0; i < o->connection_list->len; ++i)
     {
         options_=
postprocess_mutate_ce(o, o->connection_list->array[i]);
     }
 
     if (o=
->ce=2Elocal_list)
     {
-        for (i =3D 0; i < o->ce=2Elocal_list->le=
n; i++)
+        for (int i =3D 0; i < o->ce=2Elocal_list->len; i++)
      =
   {
             options_postprocess_mutate_le(&o->ce, o->ce=2Elocal_list-=
>array[i], o->mode);
         }
@@ -3224,7 +3223,7 @@
     }
 
     /* use =
the same listen list for every outgoing connection */
-    for (i =3D 0; i =
< o->connection_list->len; ++i)
+    for (int i =3D 0; i < o->connection_li=
st->len; ++i)
     {
         o->connection_list->array[i]->local_list =3D =
o->ce=2Elocal_list;
     }
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=
=2Ec
index c3f54ed=2E=2E29e78cb 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/o=
penvpn/ps=2Ec
@@ -813,9 +813,9 @@
      * Get host's IP address
      */
  =
   struct addrinfo *ai;
-    int status =3D openvpn_getaddrinfo(GETADDR_RES=
OLVE | GETADDR_FATAL, host, port,
-                                     0, =
NULL, AF_UNSPEC, &ai);
-    ASSERT(status =3D=3D 0);
+    int ga_status =3D=
 openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, port,
+        =
                                0, NULL, AF_UNSPEC, &ai);
+    ASSERT(ga_st=
atus =3D=3D 0);
     ASSERT(sizeof(hostaddr=2Eaddr) >=3D ai->ai_addrlen);
 =
    memcpy(&hostaddr=2Eaddr=2Esa, ai->ai_addr, ai->ai_addrlen);
     freead=
drinfo(ai);
@@ -863,8 +863,8 @@
         set_cloexec(fd[0]);
 
         /* =
wait for background child process to initialize */
-        int status =3D =
recv_control(fd[0]);
-        if (status =3D=3D RESPONSE_INIT_SUCCEEDED)
+ =
       int recv_status =3D recv_control(fd[0]);
+        if (recv_status =
=3D=3D RESPONSE_INIT_SUCCEEDED)
         {
             /* note that this w=
ill cause possible EAGAIN when writing to
              * control socket if=
 proxy process is backlogged */
@@ -875,7 +875,7 @@
         }
         els=
e
         {
-            msg(M_ERR, "PORT SHARE: unexpected init recv_cont=
rol status=3D%d", status);
+            msg(M_ERR, "PORT SHARE: unexpected =
init recv_control status=3D%d", revc_status);
         }
     }
     else
d=
iff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 3ed=
72db=2E=2E47f5ac5 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/=
tls_crypt=2Ec
@@ -776,24 +776,24 @@
     }
 
     /* Sanity check: load cli=
ent key (as "client") */
-    struct key_ctx_bi test_client_key;
-    struc=
t buffer test_wrapped_client_key;
+    struct key_ctx_bi check_client_key;
=
+    struct buffer check_wrapped_client_key;
     struct key2 keydata;
    =
 msg(D_GENKEY, "Testing client-side key loading=2E=2E=2E");
-    tls_crypt_=
v2_init_client_key(&test_client_key, &keydata, &test_wrapped_client_key, cl=
ient_file,
+    tls_crypt_v2_init_client_key(&check_client_key, &keydata, &=
check_wrapped_client_key, client_file,
                                  cl=
ient_inline);
-    free_key_ctx_bi(&test_client_key);
+    free_key_ctx_bi(=
&check_client_key);
 
     /* Sanity check: unwrap and load client key (as =
"server") */
-    struct buffer test_metadata =3D alloc_buf_gc(TLS_CRYPT_V2=
_MAX_METADATA_LEN, &gc);
-    struct key2 test_client_key2 =3D { 0 };
+    =
struct buffer check_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN=
, &gc);
+    struct key2 check_client_key2 =3D { 0 };
     free_key_ctx(&se=
rver_key);
     tls_crypt_v2_init_server_key(&server_key, false, server_key=
_file, server_key_inline);
     msg(D_GENKEY, "Testing server-side key load=
ing=2E=2E=2E");
-    ASSERT(tls_crypt_v2_unwrap_client_key(&test_client_key=
2, &test_metadata,
-                                          test_wrapped_=
client_key, &server_key));
-    secure_memzero(&test_client_key2, sizeof(te=
st_client_key2));
-    free_buf(&test_wrapped_client_key);
+    ASSERT(tls_=
crypt_v2_unwrap_client_key(&check_client_key2, &check_metadata,
+          =
                                check_wrapped_client_key, &server_key));
+ =
   secure_memzero(&check_client_key2, sizeof(check_client_key2));
+    free=
_buf(&check_wrapped_client_key);
 
 cleanup:
     secure_memzero(&client_ke=
y, sizeof(client_key));
diff --git a/src/openvpnserv/interactive=2Ec b/src/=
openvpnserv/interactive=2Ec
index 30cfb6a=2E=2E32c1b9c 100644
--- a/src/ope=
nvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -541,19 +=
541,19 @@
 static DWORD
 InterfaceLuid(const char *iface_name, PNET_LUID lu=
id)
 {
-    NETIO_STATUS status;
+    NETIO_STATUS convert_status;
     LPW=
STR wide_name =3D utf8to16(iface_name);
 
     if (wide_name)
     {
-     =
   status =3D ConvertInterfaceAliasToLuid(wide_name, luid);
+        conver=
t_status =3D ConvertInterfaceAliasToLuid(wide_name, luid);
         free(wi=
de_name);
     }
     else
     {
-        status =3D ERROR_OUTOFMEMORY;
+ =
       convert_status =3D ERROR_OUTOFMEMORY;
     }
-    return status;
+  =
  return convert_status;
 }
 
 static BOOL
@@ -1183,8 +1183,8 @@
         g=
oto out;
     }
 
-    SERVICE_STATUS status;
-    if (ControlService(dnssv=
c, SERVICE_CONTROL_PARAMCHANGE, &status) =3D=3D 0)
+    SERVICE_STATUS cont=
rol_status;
+    if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &c=
ontrol_status) =3D=3D 0)
     {
         MsgToEventLog(M_ERR, L"%S: Control=
Service call failed (%lu)", __func__, GetLastError());
         goto out;
@=
@ -3763,12 +3763,12 @@
 static DWORD WINAPI
 ServiceCtrlInteractive(DWORD c=
trl_code, DWORD event, LPVOID data, LPVOID ctx)
 {
-    SERVICE_STATUS *sta=
tus =3D ctx;
+    SERVICE_STATUS *svc_status =3D ctx;
     switch (ctrl_cod=
e)
     {
         case SERVICE_CONTROL_STOP:
-            status->dwCurren=
tState =3D SERVICE_STOP_PENDING;
-            ReportStatusToSCMgr(service, =
status);
+            svc_status->dwCurrentState =3D SERVICE_STOP_PENDING;
=
+            ReportStatusToSCMgr(service, svc_status);
             if (exi=
t_event)
             {
                 SetEvent(exit_event);
diff --git a=
/tests/unit_tests/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhc=
p=2Ec
index 150a3aa=2E=2E104fc9a 100644
--- a/tests/unit_tests/openvpn/test=
_dhcp=2Ec
+++ b/tests/unit_tests/openvpn/test_dhcp=2Ec
@@ -55,8 +55,8 @@
 {=

     struct gc_arena gc =3D gc_new();
     struct buffer out_buf =3D alloc=
_buf_gc(512, &gc);
-    struct buffer clear_buf =3D alloc_buf_gc(512, &gc);=

-    buf_clear(&clear_buf);
+    struct buffer clean_buf =3D alloc_buf_gc(=
512, &gc);
+    buf_clear(&clean_buf);
     bool error =3D false;
 
 #defin=
e LONGDOMAIN "a-reaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaally-long-domain"
@@ -79,7 +79,7 @@
     struct buffer small_buf =
=3D alloc_buf_gc(sizeof(output_1) - 1, &gc);
     buf_clear(&small_buf);
  =
   write_dhcp_search_str(&small_buf, DHCP_DOMAIN_SEARCH, search_list, 2, &e=
rror);
-    assert_memory_equal(BPTR(&small_buf), BPTR(&clear_buf), buf_for=
ward_capacity_total(&small_buf));
+    assert_memory_equal(BPTR(&small_buf)=
, BPTR(&clean_buf), buf_forward_capacity_total(&small_buf));
     assert_tr=
ue(error);
     error =3D false;
 
@@ -103,13 +103,13 @@
 
     buf_clear(&=
out_buf);
     write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_l=
ist + 5, 1, &error);
-    assert_memory_equal(BPTR(&out_buf), BPTR(&clear_b=
uf), buf_forward_capacity_total(&clear_buf));
+    assert_memory_equal(BPTR=
(&out_buf), BPTR(&clean_buf), buf_forward_capacity_total(&clean_buf));
    =
 assert_true(error);
     error =3D false;
 
     buf_clear(&out_buf);
    =
 write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list, 3, &error=
);
-    assert_memory_equal(BPTR(&out_buf), BPTR(&clear_buf), buf_forward_c=
apacity_total(&clear_buf));
+    assert_memory_equal(BPTR(&out_buf), BPTR(&=
clean_buf), buf_forward_capacity_total(&clean_buf));
     assert_true(error=
);
     error =3D false;
 
diff --git a/tests/unit_tests/openvpn/test_push_=
update_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
index 38=
9fa09=2E=2E9cb791b 100644
--- a/tests/unit_tests/openvpn/test_push_update_m=
sg=2Ec
+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
@@ -344,8 +3=
44,8 @@
 
     /* Message 1: first batch of routes, continuation 2 (more co=
ming) */
     struct buffer buf1 =3D alloc_buf(512);
-    const char *msg1 =
=3D "PUSH_UPDATE, route 10=2E1=2E0=2E0 255=2E255=2E0=2E0, route 10=2E2=2E0=
=2E0 255=2E255=2E0=2E0, route 10=2E3=2E0=2E0 255=2E255=2E0=2E0,push-continu=
ation 2";
-    buf_write(&buf1, msg1, strlen(msg1));
+    const char *cont_=
msg1 =3D "PUSH_UPDATE, route 10=2E1=2E0=2E0 255=2E255=2E0=2E0, route 10=2E2=
=2E0=2E0 255=2E255=2E0=2E0, route 10=2E3=2E0=2E0 255=2E255=2E0=2E0,push-con=
tinuation 2";
+    buf_write(&buf1, cont_msg1, strlen(cont_msg1));
 
     a=
ssert_int_equal(process_incoming_push_msg(c, &buf1, c->options=2Epull, pull=
_permission_mask(c),
                                                &optio=
n_types_found),
@@ -354,8 +354,8 @@
 
     /* Message 2: more routes, conti=
nuation 2 (more coming) */
     struct buffer buf2 =3D alloc_buf(512);
-   =
 const char *msg2 =3D "PUSH_UPDATE, route 10=2E4=2E0=2E0 255=2E255=2E0=2E0,=
 route 10=2E5=2E0=2E0 255=2E255=2E0=2E0, route 10=2E6=2E0=2E0 255=2E255=2E0=
=2E0,push-continuation 2";
-    buf_write(&buf2, msg2, strlen(msg2));
+    =
const char *cont_msg2 =3D "PUSH_UPDATE, route 10=2E4=2E0=2E0 255=2E255=2E0=
=2E0, route 10=2E5=2E0=2E0 255=2E255=2E0=2E0, route 10=2E6=2E0=2E0 255=2E25=
5=2E0=2E0,push-continuation 2";
+    buf_write(&buf2, cont_msg2, strlen(con=
t_msg2));
 
     assert_int_equal(process_incoming_push_msg(c, &buf2, c->op=
tions=2Epull, pull_permission_mask(c),
                                    =
            &option_types_found),
@@ -364,8 +364,8 @@
 
     /* Message 3: =
final batch of routes, continuation 1 (last message) */
     struct buffer =
buf3 =3D alloc_buf(512);
-    const char *msg3 =3D "PUSH_UPDATE, route 10=
=2E7=2E0=2E0 255=2E255=2E0=2E0, route 10=2E8=2E0=2E0 255=2E255=2E0=2E0, rou=
te 10=2E9=2E0=2E0 255=2E255=2E0=2E0,push-continuation 1";
-    buf_write(&b=
uf3, msg3, strlen(msg3));
+    const char *cont_msg3 =3D "PUSH_UPDATE, rout=
e 10=2E7=2E0=2E0 255=2E255=2E0=2E0, route 10=2E8=2E0=2E0 255=2E255=2E0=2E0,=
 route 10=2E9=2E0=2E0 255=2E255=2E0=2E0,push-continuation 1";
+    buf_writ=
e(&buf3, cont_msg3, strlen(cont_msg3));
 
     assert_int_equal(process_inc=
oming_push_msg(c, &buf3, c->options=2Epull, pull_permission_mask(c),
      =
                                          &option_types_found),

-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I528f5fd200d877841e473e5e05b=
7ac7915fa2e33
Gerrit-Change-Number: 1618
Gerrit-PatchSet: 14
Gerrit-Owner: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mai=
lbox=2Eorg>

--I197Nx2Oskw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>flichtenheld <strong>up=
loaded patch set #14</strong> to this change=2E</p><p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail">View Change</a></p><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">Rename variables that shadow other variables or functions<br><br>Id=
entified by cppcheck=2E<br><br>Change-Id: I528f5fd200d877841e473e5e05b7ac79=
15fa2e33<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openvpn/options=2Ec<br>M src/=
openvpn/ps=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>M src/openvpnserv/interact=
ive=2Ec<br>M tests/unit_tests/openvpn/test_dhcp=2Ec<br>M tests/unit_tests/o=
penvpn/test_push_update_msg=2Ec<br>7 files changed, 49 insertions(+), 52 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/18/1618/14</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/man=
age=2Ec b/src/openvpn/manage=2Ec</span><br><span>index f1dccc1=2E=2Ec082f51=
 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/=
src/openvpn/manage=2Ec</span><br><span>@@ -1328,8 +1328,6 @@</span><br><spa=
n> static void</span><br><span> man_load_stats(struct management *man)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ext=
ern counter_type link_read_bytes_global;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    extern counter_type link_write_bytes_global;</span><=
br><span>     int nclients =3D 0;</span><br><span> </span><br><span>     if=
 (man-&gt;persist=2Ecallback=2En_clients)</span><br><span>diff --git a/src/=
openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 147b31e=
=2E=2E1de7672 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><b=
r><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -2080,12 +2080,12 =
@@</span><br><span>                     &quot;may accept clients which do n=
ot present a certificate&quot;);</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned int =
tls_version_max =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const unsigned int tls_ver_max =3D</span><br><span>         (options-&g=
t;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MAX_SHIFT) &amp; SSLF_TLS_VERSION_MAX=
_MASK;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsig=
ned int tls_version_min =3D</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const unsigned int tls_ver_min =3D</span><br><span>         (op=
tions-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MIN_SHIFT) &amp; SSLF_TLS_VER=
SION_MIN_MASK;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (tls_version_max &gt; 0 &amp;&amp; tls_version_max &lt; t=
ls_version_min)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (tls_ver_max &gt; 0 &amp;&amp; tls_ver_max &lt; tls_ver_min)</span><br><=
span>     {</span><br><span>         msg(M_USAGE, &quot;--tls-version-min b=
igger than --tls-version-max&quot;);</span><br><span>     }</span><br><span=
>@@ -3032,16 +3032,16 @@</span><br><span>         {</span><br><span>       =
      struct dns_domain **entry =3D &amp;dns-&gt;search_domains;</span><br>=
<span>             ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &amp;dns-&=
gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            st=
ruct dns_domain *new =3D *entry;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            new-&gt;name =3D dhcp-&gt;domain;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            entry =3D &amp;new-&gt;next;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct =
dns_domain *domain =3D *entry;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            domain-&gt;name =3D dhcp-&gt;domain;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            entry =3D &amp;domain-&=
gt;next;</span><br><span> </span><br><span>             for (unsigned int i=
 =3D 0; i &lt; dhcp-&gt;domain_search_list_len; ++i)</span><br><span>      =
       {</span><br><span>                 ALLOC_OBJ_CLEAR_GC(*entry, struct=
 dns_domain, &amp;dns-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                struct dns_domain *new =3D *entry;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                new-&gt;name =3D dhcp=
-&gt;domain_search_list[i];</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                entry =3D &amp;new-&gt;next;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                struct dns_domain *search_do=
main =3D *entry;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             search_domain-&gt;name =3D dhcp-&gt;domain_search_list[i];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                entry =
=3D &amp;search_domain-&gt;next;</span><br><span>             }</span><br><=
span> </span><br><span>             struct dns_server *server =3D dns_serve=
r_get(&amp;dns-&gt;servers, 0, &amp;dns-&gt;gc);</span><br><span>@@ -3134,7=
 +3134,6 @@</span><br><span> static void</span><br><span> options_postproce=
ss_mutate(struct options *o, struct env_set *es)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>  =
   /*</span><br><span>      * Process helper-type options which map to othe=
r, more complex</span><br><span>      * sequences of options=2E</span><br><=
span>@@ -3167,7 +3166,7 @@</span><br><span>          * Convert remotes into=
 connection list</span><br><span>          */</span><br><span>         cons=
t struct remote_list *rl =3D o-&gt;remote_list;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; rl-&gt;len; ++i)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D =
0; i &lt; rl-&gt;len; ++i)</span><br><span>         {</span><br><span>     =
        const struct remote_entry *re =3D rl-&gt;array[i];</span><br><span>=
             struct connection_entry ce =3D o-&gt;ce;</span><br><span>@@ -3=
189,14 +3188,14 @@</span><br><span>     }</span><br><span> </span><br><span=
>     ASSERT(o-&gt;connection_list);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    for (i =3D 0; i &lt; o-&gt;connection_list-&gt;len; ++i)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D =
0; i &lt; o-&gt;connection_list-&gt;len; ++i)</span><br><span>     {</span>=
<br><span>         options_postprocess_mutate_ce(o, o-&gt;connection_list-&=
gt;array[i]);</span><br><span>     }</span><br><span> </span><br><span>    =
 if (o-&gt;ce=2Elocal_list)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; o-&gt;ce=2Elocal_=
list-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       for (int i =3D 0; i &lt; o-&gt;ce=2Elocal_list-&gt;len; i++)</span><=
br><span>         {</span><br><span>             options_postprocess_mutate=
_le(&amp;o-&gt;ce, o-&gt;ce=2Elocal_list-&gt;array[i], o-&gt;mode);</span><=
br><span>         }</span><br><span>@@ -3224,7 +3223,7 @@</span><br><span> =
    }</span><br><span> </span><br><span>     /* use the same listen list fo=
r every outgoing connection */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    for (i =3D 0; i &lt; o-&gt;connection_list-&gt;len; ++i)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &=
lt; o-&gt;connection_list-&gt;len; ++i)</span><br><span>     {</span><br><s=
pan>         o-&gt;connection_list-&gt;array[i]-&gt;local_list =3D o-&gt;ce=
=2Elocal_list;</span><br><span>     }</span><br><span>diff --git a/src/open=
vpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index c3f54ed=2E=2E29e78cb =
100644</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/o=
penvpn/ps=2Ec</span><br><span>@@ -813,9 +813,9 @@</span><br><span>      * G=
et host&#39;s IP address</span><br><span>      */</span><br><span>     stru=
ct addrinfo *ai;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nt status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, po=
rt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
                   0, NULL, AF_UNSPEC, &amp;ai);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ASSERT(status =3D=3D 0);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int ga_status =3D openvpn_getaddrin=
fo(GETADDR_RESOLVE | GETADDR_FATAL, host, port,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                        0, NULL=
, AF_UNSPEC, &amp;ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ASSERT(ga_status =3D=3D 0);</span><br><span>     ASSERT(sizeof(hosta=
ddr=2Eaddr) &gt;=3D ai-&gt;ai_addrlen);</span><br><span>     memcpy(&amp;ho=
staddr=2Eaddr=2Esa, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><span>   =
  freeaddrinfo(ai);</span><br><span>@@ -863,8 +863,8 @@</span><br><span>   =
      set_cloexec(fd[0]);</span><br><span> </span><br><span>         /* wai=
t for background child process to initialize */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        int status =3D recv_control(fd[0]);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (status =3D=3D R=
ESPONSE_INIT_SUCCEEDED)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        int recv_status =3D recv_control(fd[0]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (recv_status =3D=3D RESPONSE_I=
NIT_SUCCEEDED)</span><br><span>         {</span><br><span>             /* n=
ote that this will cause possible EAGAIN when writing to</span><br><span>  =
            * control socket if proxy process is backlogged */</span><br><s=
pan>@@ -875,7 +875,7 @@</span><br><span>         }</span><br><span>        =
 else</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            msg(M_ERR, &quot;PORT SHARE: unexpected init recv_co=
ntrol status=3D%d&quot;, status);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(M_ERR, &quot;PORT SHARE: unexpected init recv=
_control status=3D%d&quot;, revc_status);</span><br><span>         }</span>=
<br><span>     }</span><br><span>     else</span><br><span>diff --git a/src=
/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index 3e=
d72db=2E=2E47f5ac5 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</=
span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -776,24 +=
776,24 @@</span><br><span>     }</span><br><span> </span><br><span>     /* =
Sanity check: load client key (as &quot;client&quot;) */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct key_ctx_bi test_client_key;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer test_=
wrapped_client_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct key_ctx_bi check_client_key;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer check_wrapped_client_key;</span><br><=
span>     struct key2 keydata;</span><br><span>     msg(D_GENKEY, &quot;Tes=
ting client-side key loading=2E=2E=2E&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    tls_crypt_v2_init_client_key(&amp;test_client_k=
ey, &amp;keydata, &amp;test_wrapped_client_key, client_file,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    tls_crypt_v2_init_client_key(&=
amp;check_client_key, &amp;keydata, &amp;check_wrapped_client_key, client_f=
ile,</span><br><span>                                  client_inline);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    free_key_ctx_bi(&amp;t=
est_client_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 free_key_ctx_bi(&amp;check_client_key);</span><br><span> </span><br><span>=
     /* Sanity check: unwrap and load client key (as &quot;server&quot;) */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer tes=
t_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &amp;gc);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct key2 test_client_=
key2 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer check_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct key2 check_client_key2 =3D { 0 };</span><br><span>     free_key_ctx(&amp=
;server_key);</span><br><span>     tls_crypt_v2_init_server_key(&amp;server=
_key, false, server_key_file, server_key_inline);</span><br><span>     msg(=
D_GENKEY, &quot;Testing server-side key loading=2E=2E=2E&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(tls_crypt_v2_unwrap_c=
lient_key(&amp;test_client_key2, &amp;test_metadata,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                          t=
est_wrapped_client_key, &amp;server_key));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    secure_memzero(&amp;test_client_key2, sizeof(test_=
client_key2));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fre=
e_buf(&amp;test_wrapped_client_key);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ASSERT(tls_crypt_v2_unwrap_client_key(&amp;check_clien=
t_key2, &amp;check_metadata,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                          check_wrapped_client_key=
, &amp;server_key));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    secure_memzero(&amp;check_client_key2, sizeof(check_client_key2));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;check=
_wrapped_client_key);</span><br><span> </span><br><span> cleanup:</span><br=
><span>     secure_memzero(&amp;client_key, sizeof(client_key));</span><br>=
<span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/intera=
ctive=2Ec</span><br><span>index 30cfb6a=2E=2E32c1b9c 100644</span><br><span=
>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnser=
v/interactive=2Ec</span><br><span>@@ -541,19 +541,19 @@</span><br><span> st=
atic DWORD</span><br><span> InterfaceLuid(const char *iface_name, PNET_LUID=
 luid)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    NETIO_STATUS status;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    NETIO_STATUS convert_status;</span><br><span>     LPWSTR wide_=
name =3D utf8to16(iface_name);</span><br><span> </span><br><span>     if (w=
ide_name)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        status =3D ConvertInterfaceAliasToLuid(wide_name, luid);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        convert_sta=
tus =3D ConvertInterfaceAliasToLuid(wide_name, luid);</span><br><span>     =
    free(wide_name);</span><br><span>     }</span><br><span>     else</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    status =3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        convert_status =3D ERROR_OUTOFMEMORY;</span><br><span=
>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sta=
tus;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return conv=
ert_status;</span><br><span> }</span><br><span> </span><br><span> static BO=
OL</span><br><span>@@ -1183,8 +1183,8 @@</span><br><span>         goto out;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SERVICE_STATUS status;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (ControlService(dnssvc, SERVICE_CONTROL_PAR=
AMCHANGE, &amp;status) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    SERVICE_STATUS control_status;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (ControlService(dnssvc, SERVICE_CONTROL_=
PARAMCHANGE, &amp;control_status) =3D=3D 0)</span><br><span>     {</span><b=
r><span>         MsgToEventLog(M_ERR, L&quot;%S: ControlService call failed=
 (%lu)&quot;, __func__, GetLastError());</span><br><span>         goto out;=
</span><br><span>@@ -3763,12 +3763,12 @@</span><br><span> static DWORD WINA=
PI</span><br><span> ServiceCtrlInteractive(DWORD ctrl_code, DWORD event, LP=
VOID data, LPVOID ctx)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    SERVICE_STATUS *status =3D ctx;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SERVICE_STATUS *svc_status =3D ctx;=
</span><br><span>     switch (ctrl_code)</span><br><span>     {</span><br><=
span>         case SERVICE_CONTROL_STOP:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            status-&gt;dwCurrentState =3D SERVICE_STOP_P=
ENDING;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            Re=
portStatusToSCMgr(service, status);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            svc_status-&gt;dwCurrentState =3D SERVICE_STOP_=
PENDING;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 ReportStatusToSCMgr(service, svc_status);</span><br><span>             if =
(exit_event)</span><br><span>             {</span><br><span>               =
  SetEvent(exit_event);</span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>i=
ndex 150a3aa=2E=2E104fc9a 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/test_dhcp=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_dhcp=
=2Ec</span><br><span>@@ -55,8 +55,8 @@</span><br><span> {</span><br><span> =
    struct gc_arena gc =3D gc_new();</span><br><span>     struct buffer out=
_buf =3D alloc_buf_gc(512, &amp;gc);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct buffer clear_buf =3D alloc_buf_gc(512, &amp;gc);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_clear(&amp;cle=
ar_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer clean_buf =3D alloc_buf_gc(512, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    buf_clear(&amp;clean_buf);</span><br><span=
>     bool error =3D false;</span><br><span> </span><br><span> #define LONG=
DOMAIN &quot;a-reaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaally-long-domain&quot;</span><br><span>@@ -79,7 +79,7 @@</span><br>=
<span>     struct buffer small_buf =3D alloc_buf_gc(sizeof(output_1) - 1, &=
amp;gc);</span><br><span>     buf_clear(&amp;small_buf);</span><br><span>  =
   write_dhcp_search_str(&amp;small_buf, DHCP_DOMAIN_SEARCH, search_list, 2=
, &amp;error);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ass=
ert_memory_equal(BPTR(&amp;small_buf), BPTR(&amp;clear_buf), buf_forward_ca=
pacity_total(&amp;small_buf));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_memory_equal(BPTR(&amp;small_buf), BPTR(&amp;clean_bu=
f), buf_forward_capacity_total(&amp;small_buf));</span><br><span>     asser=
t_true(error);</span><br><span>     error =3D false;</span><br><span> </spa=
n><br><span>@@ -103,13 +103,13 @@</span><br><span> </span><br><span>     bu=
f_clear(&amp;out_buf);</span><br><span>     write_dhcp_search_str(&amp;out_=
buf, DHCP_DOMAIN_SEARCH, search_list + 5, 1, &amp;error);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(&amp;out_b=
uf), BPTR(&amp;clear_buf), buf_forward_capacity_total(&amp;clear_buf));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal=
(BPTR(&amp;out_buf), BPTR(&amp;clean_buf), buf_forward_capacity_total(&amp;=
clean_buf));</span><br><span>     assert_true(error);</span><br><span>     =
error =3D false;</span><br><span> </span><br><span>     buf_clear(&amp;out_=
buf);</span><br><span>     write_dhcp_search_str(&amp;out_buf, DHCP_DOMAIN_=
SEARCH, search_list, 3, &amp;error);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    assert_memory_equal(BPTR(&amp;out_buf), BPTR(&amp;clear_=
buf), buf_forward_capacity_total(&amp;clear_buf));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;out_buf), =
BPTR(&amp;clean_buf), buf_forward_capacity_total(&amp;clean_buf));</span><b=
r><span>     assert_true(error);</span><br><span>     error =3D false;</spa=
n><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_pu=
sh_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span=
><br><span>index 389fa09=2E=2E9cb791b 100644</span><br><span>--- a/tests/un=
it_tests/openvpn/test_push_update_msg=2Ec</span><br><span>+++ b/tests/unit_=
tests/openvpn/test_push_update_msg=2Ec</span><br><span>@@ -344,8 +344,8 @@<=
/span><br><span> </span><br><span>     /* Message 1: first batch of routes,=
 continuation 2 (more coming) */</span><br><span>     struct buffer buf1 =
=3D alloc_buf(512);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const char *msg1 =3D &quot;PUSH_UPDATE, route 10=2E1=2E0=2E0 255=2E255=2E=
0=2E0, route 10=2E2=2E0=2E0 255=2E255=2E0=2E0, route 10=2E3=2E0=2E0 255=2E2=
55=2E0=2E0,push-continuation 2&quot;;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    buf_write(&amp;buf1, msg1, strlen(msg1));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const char *cont_msg1 =3D &qu=
ot;PUSH_UPDATE, route 10=2E1=2E0=2E0 255=2E255=2E0=2E0, route 10=2E2=2E0=2E=
0 255=2E255=2E0=2E0, route 10=2E3=2E0=2E0 255=2E255=2E0=2E0,push-continuati=
on 2&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_=
write(&amp;buf1, cont_msg1, strlen(cont_msg1));</span><br><span> </span><br=
><span>     assert_int_equal(process_incoming_push_msg(c, &amp;buf1, c-&gt;=
options=2Epull, pull_permission_mask(c),</span><br><span>                  =
                              &amp;option_types_found),</span><br><span>@@ =
-354,8 +354,8 @@</span><br><span> </span><br><span>     /* Message 2: more =
routes, continuation 2 (more coming) */</span><br><span>     struct buffer =
buf2 =3D alloc_buf(512);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const char *msg2 =3D &quot;PUSH_UPDATE, route 10=2E4=2E0=2E0 255=2E2=
55=2E0=2E0, route 10=2E5=2E0=2E0 255=2E255=2E0=2E0, route 10=2E6=2E0=2E0 25=
5=2E255=2E0=2E0,push-continuation 2&quot;;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    buf_write(&amp;buf2, msg2, strlen(msg2));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *cont_msg2 =
=3D &quot;PUSH_UPDATE, route 10=2E4=2E0=2E0 255=2E255=2E0=2E0, route 10=2E5=
=2E0=2E0 255=2E255=2E0=2E0, route 10=2E6=2E0=2E0 255=2E255=2E0=2E0,push-con=
tinuation 2&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   buf_write(&amp;buf2, cont_msg2, strlen(cont_msg2));</span><br><span> </s=
pan><br><span>     assert_int_equal(process_incoming_push_msg(c, &amp;buf2,=
 c-&gt;options=2Epull, pull_permission_mask(c),</span><br><span>           =
                                     &amp;option_types_found),</span><br><s=
pan>@@ -364,8 +364,8 @@</span><br><span> </span><br><span>     /* Message 3=
: final batch of routes, continuation 1 (last message) */</span><br><span> =
    struct buffer buf3 =3D alloc_buf(512);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const char *msg3 =3D &quot;PUSH_UPDATE, route 10=
=2E7=2E0=2E0 255=2E255=2E0=2E0, route 10=2E8=2E0=2E0 255=2E255=2E0=2E0, rou=
te 10=2E9=2E0=2E0 255=2E255=2E0=2E0,push-continuation 1&quot;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    buf_write(&amp;buf3, msg3, str=
len(msg3));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *cont_msg3 =3D &quot;PUSH_UPDATE, route 10=2E7=2E0=2E0 255=2E255=2E0=
=2E0, route 10=2E8=2E0=2E0 255=2E255=2E0=2E0, route 10=2E9=2E0=2E0 255=2E25=
5=2E0=2E0,push-continuation 1&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    buf_write(&amp;buf3, cont_msg3, strlen(cont_msg3));</s=
pan><br><span> </span><br><span>     assert_int_equal(process_incoming_push=
_msg(c, &amp;buf3, c-&gt;options=2Epull, pull_permission_mask(c),</span><br=
><span>                                                &amp;option_types_fo=
und),</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail">change 1618</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I528f5fd200d=
877841e473e5e05b7ac7915fa2e33 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 1618 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--I197Nx2Oskw=--


--===============5273062878660579738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5273062878660579738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5273062878660579738==--

