Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E0AC5DF86
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HU7bAX0QcIZjvr0uEOtNpIrYxHRHdZXonsv8+Owu8SI=; b=Mce6Pf67QxunPHp+ouAK3IRX3g
	s7yrrkvIs9DqoTHKMmJgPwOFTTGItSCbnhJ7kS/jfwix/xh9W1CKPfBBRgNW93VpnB3UsKwcFdbjL
	TTdOrjxvWO0/XvJ79LLClB1MmfcluxuhRV73LCXZfNR3xEtNR1FgzOSab/Fo5lINYZ10=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwyad-00013u-86;
	Thu, 20 Aug 2026 08:57:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwyaZ-00013m-Dm
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 08:57:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MjwTIqLxN/vzcRoHQ6MfYvfsrU07hzsl2/oOjjvj/6c=; b=LT0pNtqsHz1neNp55dnzr9C5Ze
 hG5jh38xZhIXHD1aaOaEpo2iMujWqyYEjXLiyCJJd43b4+Fo5GikWLQHGeYSt49fgWSL6lEEKwgrm
 qrTaUaC16L8QPbnLPFknE+wSHqbMjDMFUM+cyvK1FipXET0ZLo3dLzyRZSsHnpNkJvZw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MjwTIqLxN/vzcRoHQ6MfYvfsrU07hzsl2/oOjjvj/6c=; b=g
 LTk6nLI3jdZySojWhI4pRTRVJX0hPNM6BbaIGmluMV06prqSmIfRJ6qI0sQHhd7i5/TsDweG0xS/j
 dH/uZxZpYYe7QF/82Y0KrajFjx0tpzjyn8Bee9P9ML6TZKysUze6o2EalElOcCiX872YKFSC1UvgW
 kUefyBAN6UE54u90=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwyaY-0000Cv-5a for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 08:57:32 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-482938466a7so1686724f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787216244; x=1787821044; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MjwTIqLxN/vzcRoHQ6MfYvfsrU07hzsl2/oOjjvj/6c=;
 b=FOlQJ6QzGHOjCHJry6kjzUef2zWl//kd6ai8BsZAIcToEX4mxkaj+1yC2+8YCdYTKc
 AmUsuYOg271cEGURb/7t2nNUBfqNJXtZfFb2NQ1Kg5SKIJptJ610CA8laVJtxO39tDz6
 FqQQZZIm46amddH6/nN2UKKweQ5w65Nb2200SsdnXR9vdmcXpPKjuhvOlmb1N0yPMW6c
 7bpebxOzQZz6SG2Tc34ktQHAWNr2tvvhxDJuizkrpydhA61KaZO/X1GWycfmP64Q+OVd
 dXc2wXhYuS7o8JDRouQfWKXlVBSS+xJDvyxHnZm+g+lKPLnHPNsgDhsRSmJs8q09kDtW
 q8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787216244; x=1787821044;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MjwTIqLxN/vzcRoHQ6MfYvfsrU07hzsl2/oOjjvj/6c=;
 b=Ttz+j8BzGtdlG5/RgXPEBA8XnuXwVOCINmZpxnRwa/XLLKtYNK8JBqLZmwPo8n2iua
 TFybcjE0MjdEv84aPe12H9ZdVgwnn+4hyb72lB8nNtjpaNPJAXeG4QZzYeOi0EdclKcK
 A2z44owX7Iw/k/iT/5cjOGQReI3gVHN/N3cYkYqHsdf4kp7DzuRn3UVzpQ0GvyqplzHF
 IlJbnmD9NDUnV1OIYrShqY9HY1eeItxqPXGqKikBPei0a1EAVkK6y1EYyO+KmPvWncGX
 Bk0W1WTaWuh+skYLNh+kqGleKNd/eWFr11TsQRtcnWWoIuUST0TXFTOuFFQxQsaWUNUW
 Nqew==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpzd/bNQy32h3HtVPyoOykXOnDtalU0ztDCjqNPNG81HUTl/kvbyFIqq+HTo/1sB1NP9dfXP6zL0jgA0/Z5@lists.sourceforge.net
X-Gm-Message-State: AFuF++kwnEvcJoaAdmxuyCODkafBfZPtZxcVmNJElSI/NYsmei9ExNJ9
 RWUypwb49cU7bfdcR/aepnMoqs7vDei2e1pAcbK1IUOW6UxFWbvWWy38QcwkR0+NMo3AnmlRWDo
 VRYp1zMcgcRNv81gabV/U0nmy36yr/4efzX45cjVLw7KTnDXeLNtSvtpPFFgKfiTXaBNI
X-Gm-Gg: AR+sD13Slc6XJqAZ4pKuS8mIu8fSOPpxDQMDFZqsiFsYCNjUnDO2yt9IbQlNsZ+nrAR
 Rfy2Y9nFgLKE6++LinmcOVaYGGiODg+UjZkjoemdRMvAWvRi73vDl4ZOaLmpz7YzJJUAVm6cUBQ
 kCM3MbI4mA587cUEX2inkKocIrAGGeRQQjJ/6V51zMO6/ZXisiMrg5mED6iYjew7iNsSNR/UMST
 HE3nopaevdVAHJBoyfkrgZU2PN5RgvyCBqFt630tmvOBqCMhOO7+X0YFAMZzTk6TrPqRJQfA+eD
 Xiaxw60Do9Ys/rIDBIUr31Bly8lS7ERRJ/7yRiVENeIQDO5Ciyb2cTQLN78NpQLaZxrz4lrXjt6
 FRlAZpT45yy5YIoFh/tfBxaX5gIpkKbkOiZvLnhuFa10JuQIW1TOQmGsAFU8e0aRqd8qK+FM9S8
 yZohc9oD84ULvIYT8KuIvmtI0sudurCWP9QW6ZoHGSc1x3WOuKuNswNTa9PnvIrFCgz6vXMqvCD
 blU19qMRLfjAU9YxV7E5bKXfJ82GscDoSA/2nfQm5iYhyNsY0gCjGQSGScT/vkST9+vUcPukMYX
 rKyCQM3LTC9HtdMIaglaNBHAvXx9HEZNUo92g1cH8jMDSqNab0A=
X-Received: by 2002:a05:6000:250f:b0:47f:e770:13e0 with SMTP id
 ffacd0b85a97d-482b1e9186cmr16730622f8f.7.1787216243354; 
 Thu, 20 Aug 2026 01:57:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441748sm12092631f8f.8.2026.08.20.01.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 01:57:22 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 08:57:22 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
X-Gerrit-Change-Number: 1618
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1618?usp=email>
X-Gerrit-Commit: 889a873cdb7b7883166a9a1d305552336c117a39
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLkk1MjhmNWZkMjAwZDg3Nzg0MWU0NzNlNWUwNWI3YWM3OTE1ZmEyZTMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b40fa2bfdaaedbd8bf8528b35410184274109e10-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwyaY-0000Cv-5a
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5648854386112595624=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5648854386112595624==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LyqSlMLYl7A="; charset=UTF-8

--LyqSlMLYl7A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1618?usp=3Demail )

Change subject: Rename variables that shadow other =
variables or functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Rename variables that shadow other variables or functions

Ident=
ified by cppcheck=2E

Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
=
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1618
Message-Id: <20260819211346=2E2776-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg38540=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/manage=2Ec
M src/openvpn/options=2Ec
M src/openvpn=
/ps=2Ec
M src/openvpn/tls_crypt=2Ec
M src/openvpnserv/interactive=2Ec
M tes=
ts/unit_tests/openvpn/test_dhcp=2Ec
M tests/unit_tests/openvpn/test_push_up=
date_msg=2Ec
7 files changed, 49 insertions(+), 52 deletions(-)




diff --=
git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 2a3023c=2E=2E95=
ff246 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -=
1329,8 +1329,6 @@
 static void
 man_load_stats(struct management *man)
 {
-=
    extern counter_type link_read_bytes_global;
-    extern counter_type li=
nk_write_bytes_global;
     int nclients =3D 0;
 
     if (man->persist=2Ec=
allback=2En_clients)
diff --git a/src/openvpn/options=2Ec b/src/openvpn/opt=
ions=2Ec
index 317ce44=2E=2E391739c 100644
--- a/src/openvpn/options=2Ec
++=
+ b/src/openvpn/options=2Ec
@@ -2081,12 +2081,12 @@
                     "m=
ay accept clients which do not present a certificate");
     }
 
-    const=
 unsigned int tls_version_max =3D
+    const unsigned int tls_ver_max =3D
 =
        (options->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSI=
ON_MAX_MASK;
-    const unsigned int tls_version_min =3D
+    const unsigne=
d int tls_ver_min =3D
         (options->ssl_flags >> SSLF_TLS_VERSION_MIN_=
SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
 
-    if (tls_version_max > 0 && tls_v=
ersion_max < tls_version_min)
+    if (tls_ver_max > 0 && tls_ver_max < tls=
_ver_min)
     {
         msg(M_USAGE, "--tls-version-min bigger than --tls=
-version-max");
     }
@@ -3033,16 +3033,16 @@
         {
             stru=
ct dns_domain **entry =3D &dns->search_domains;
             ALLOC_OBJ_CLEA=
R_GC(*entry, struct dns_domain, &dns->gc);
-            struct dns_domain *=
new =3D *entry;
-            new->name =3D dhcp->domain;
-            entry=
 =3D &new->next;
+            struct dns_domain *domain =3D *entry;
+      =
      domain->name =3D dhcp->domain;
+            entry =3D &domain->next;
=
 
             for (unsigned int i =3D 0; i < dhcp->domain_search_list_len;=
 ++i)
             {
                 ALLOC_OBJ_CLEAR_GC(*entry, struct dns=
_domain, &dns->gc);
-                struct dns_domain *new =3D *entry;
-  =
              new->name =3D dhcp->domain_search_list[i];
-                e=
ntry =3D &new->next;
+                struct dns_domain *search_domain =3D =
*entry;
+                search_domain->name =3D dhcp->domain_search_list[i=
];
+                entry =3D &search_domain->next;
             }
 
      =
       struct dns_server *server =3D dns_server_get(&dns->servers, 0, &dns-=
>gc);
@@ -3135,7 +3135,6 @@
 static void
 options_postprocess_mutate(struct=
 options *o, struct env_set *es)
 {
-    int i;
     /*
      * Process hel=
per-type options which map to other, more complex
      * sequences of opti=
ons=2E
@@ -3168,7 +3167,7 @@
          * Convert remotes into connection li=
st
          */
         const struct remote_list *rl =3D o->remote_list;
-=
        for (i =3D 0; i < rl->len; ++i)
+        for (int i =3D 0; i < rl->=
len; ++i)
         {
             const struct remote_entry *re =3D rl->arr=
ay[i];
             struct connection_entry ce =3D o->ce;
@@ -3190,14 +3189=
,14 @@
     }
 
     ASSERT(o->connection_list);
-    for (i =3D 0; i < o->=
connection_list->len; ++i)
+    for (int i =3D 0; i < o->connection_list->l=
en; ++i)
     {
         options_postprocess_mutate_ce(o, o->connection_lis=
t->array[i]);
     }
 
     if (o->ce=2Elocal_list)
     {
-        for (i =
=3D 0; i < o->ce=2Elocal_list->len; i++)
+        for (int i =3D 0; i < o->=
ce=2Elocal_list->len; i++)
         {
             options_postprocess_muta=
te_le(&o->ce, o->ce=2Elocal_list->array[i], o->mode);
         }
@@ -3225,7=
 +3224,7 @@
     }
 
     /* use the same listen list for every outgoing co=
nnection */
-    for (i =3D 0; i < o->connection_list->len; ++i)
+    for (=
int i =3D 0; i < o->connection_list->len; ++i)
     {
         o->connectio=
n_list->array[i]->local_list =3D o->ce=2Elocal_list;
     }
diff --git a/sr=
c/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index c3f54ed=2E=2Ebe91a99 100644
---=
 a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -813,9 +813,9 @@
      * =
Get host's IP address
      */
     struct addrinfo *ai;
-    int status =
=3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, port,
-     =
                                0, NULL, AF_UNSPEC, &ai);
-    ASSERT(statu=
s =3D=3D 0);
+    int ga_status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | G=
ETADDR_FATAL, host, port,
+                                        0, NULL,=
 AF_UNSPEC, &ai);
+    ASSERT(ga_status =3D=3D 0);
     ASSERT(sizeof(hosta=
ddr=2Eaddr) >=3D ai->ai_addrlen);
     memcpy(&hostaddr=2Eaddr=2Esa, ai->ai=
_addr, ai->ai_addrlen);
     freeaddrinfo(ai);
@@ -863,8 +863,8 @@
        =
 set_cloexec(fd[0]);
 
         /* wait for background child process to ini=
tialize */
-        int status =3D recv_control(fd[0]);
-        if (status=
 =3D=3D RESPONSE_INIT_SUCCEEDED)
+        int recv_status =3D recv_control(=
fd[0]);
+        if (recv_status =3D=3D RESPONSE_INIT_SUCCEEDED)
         {=

             /* note that this will cause possible EAGAIN when writing to
=
              * control socket if proxy process is backlogged */
@@ -875,7 =
+875,7 @@
         }
         else
         {
-            msg(M_ERR, "PORT=
 SHARE: unexpected init recv_control status=3D%d", status);
+            ms=
g(M_ERR, "PORT SHARE: unexpected init recv_control status=3D%d", recv_statu=
s);
         }
     }
     else
diff --git a/src/openvpn/tls_crypt=2Ec b/sr=
c/openvpn/tls_crypt=2Ec
index 3ed72db=2E=2E47f5ac5 100644
--- a/src/openvpn=
/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -776,24 +776,24 @@
     }=

 
     /* Sanity check: load client key (as "client") */
-    struct key_c=
tx_bi test_client_key;
-    struct buffer test_wrapped_client_key;
+    str=
uct key_ctx_bi check_client_key;
+    struct buffer check_wrapped_client_ke=
y;
     struct key2 keydata;
     msg(D_GENKEY, "Testing client-side key lo=
ading=2E=2E=2E");
-    tls_crypt_v2_init_client_key(&test_client_key, &keyd=
ata, &test_wrapped_client_key, client_file,
+    tls_crypt_v2_init_client_k=
ey(&check_client_key, &keydata, &check_wrapped_client_key, client_file,
   =
                               client_inline);
-    free_key_ctx_bi(&test_c=
lient_key);
+    free_key_ctx_bi(&check_client_key);
 
     /* Sanity check=
: unwrap and load client key (as "server") */
-    struct buffer test_metad=
ata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &gc);
-    struct key2 =
test_client_key2 =3D { 0 };
+    struct buffer check_metadata =3D alloc_buf=
_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &gc);
+    struct key2 check_client_key2=
 =3D { 0 };
     free_key_ctx(&server_key);
     tls_crypt_v2_init_server_k=
ey(&server_key, false, server_key_file, server_key_inline);
     msg(D_GENK=
EY, "Testing server-side key loading=2E=2E=2E");
-    ASSERT(tls_crypt_v2_u=
nwrap_client_key(&test_client_key2, &test_metadata,
-                      =
                    test_wrapped_client_key, &server_key));
-    secure_mem=
zero(&test_client_key2, sizeof(test_client_key2));
-    free_buf(&test_wrap=
ped_client_key);
+    ASSERT(tls_crypt_v2_unwrap_client_key(&check_client_k=
ey2, &check_metadata,
+                                          check_wrap=
ped_client_key, &server_key));
+    secure_memzero(&check_client_key2, size=
of(check_client_key2));
+    free_buf(&check_wrapped_client_key);
 
 cleanu=
p:
     secure_memzero(&client_key, sizeof(client_key));
diff --git a/src/o=
penvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 30cfb6a=
=2E=2E32c1b9c 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvp=
nserv/interactive=2Ec
@@ -541,19 +541,19 @@
 static DWORD
 InterfaceLuid(co=
nst char *iface_name, PNET_LUID luid)
 {
-    NETIO_STATUS status;
+    NET=
IO_STATUS convert_status;
     LPWSTR wide_name =3D utf8to16(iface_name);
 =

     if (wide_name)
     {
-        status =3D ConvertInterfaceAliasToLuid=
(wide_name, luid);
+        convert_status =3D ConvertInterfaceAliasToLuid(=
wide_name, luid);
         free(wide_name);
     }
     else
     {
-      =
  status =3D ERROR_OUTOFMEMORY;
+        convert_status =3D ERROR_OUTOFMEMO=
RY;
     }
-    return status;
+    return convert_status;
 }
 
 static BOO=
L
@@ -1183,8 +1183,8 @@
         goto out;
     }
 
-    SERVICE_STATUS sta=
tus;
-    if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &status) =
=3D=3D 0)
+    SERVICE_STATUS control_status;
+    if (ControlService(dnssv=
c, SERVICE_CONTROL_PARAMCHANGE, &control_status) =3D=3D 0)
     {
         =
MsgToEventLog(M_ERR, L"%S: ControlService call failed (%lu)", __func__, Get=
LastError());
         goto out;
@@ -3763,12 +3763,12 @@
 static DWORD WINA=
PI
 ServiceCtrlInteractive(DWORD ctrl_code, DWORD event, LPVOID data, LPVOI=
D ctx)
 {
-    SERVICE_STATUS *status =3D ctx;
+    SERVICE_STATUS *svc_sta=
tus =3D ctx;
     switch (ctrl_code)
     {
         case SERVICE_CONTROL_S=
TOP:
-            status->dwCurrentState =3D SERVICE_STOP_PENDING;
-       =
     ReportStatusToSCMgr(service, status);
+            svc_status->dwCurre=
ntState =3D SERVICE_STOP_PENDING;
+            ReportStatusToSCMgr(service,=
 svc_status);
             if (exit_event)
             {
                 =
SetEvent(exit_event);
diff --git a/tests/unit_tests/openvpn/test_dhcp=2Ec b=
/tests/unit_tests/openvpn/test_dhcp=2Ec
index 150a3aa=2E=2E104fc9a 100644
-=
-- a/tests/unit_tests/openvpn/test_dhcp=2Ec
+++ b/tests/unit_tests/openvpn/=
test_dhcp=2Ec
@@ -55,8 +55,8 @@
 {
     struct gc_arena gc =3D gc_new();
  =
   struct buffer out_buf =3D alloc_buf_gc(512, &gc);
-    struct buffer cle=
ar_buf =3D alloc_buf_gc(512, &gc);
-    buf_clear(&clear_buf);
+    struct =
buffer clean_buf =3D alloc_buf_gc(512, &gc);
+    buf_clear(&clean_buf);
  =
   bool error =3D false;
 
 #define LONGDOMAIN "a-reaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaally-long-domain"
@@ -79,7 +79,7=
 @@
     struct buffer small_buf =3D alloc_buf_gc(sizeof(output_1) - 1, &gc=
);
     buf_clear(&small_buf);
     write_dhcp_search_str(&small_buf, DHCP_=
DOMAIN_SEARCH, search_list, 2, &error);
-    assert_memory_equal(BPTR(&smal=
l_buf), BPTR(&clear_buf), buf_forward_capacity_total(&small_buf));
+    ass=
ert_memory_equal(BPTR(&small_buf), BPTR(&clean_buf), buf_forward_capacity_t=
otal(&small_buf));
     assert_true(error);
     error =3D false;
 
@@ -103=
,13 +103,13 @@
 
     buf_clear(&out_buf);
     write_dhcp_search_str(&out_=
buf, DHCP_DOMAIN_SEARCH, search_list + 5, 1, &error);
-    assert_memory_eq=
ual(BPTR(&out_buf), BPTR(&clear_buf), buf_forward_capacity_total(&clear_buf=
));
+    assert_memory_equal(BPTR(&out_buf), BPTR(&clean_buf), buf_forward_=
capacity_total(&clean_buf));
     assert_true(error);
     error =3D false;=

 
     buf_clear(&out_buf);
     write_dhcp_search_str(&out_buf, DHCP_DOMA=
IN_SEARCH, search_list, 3, &error);
-    assert_memory_equal(BPTR(&out_buf)=
, BPTR(&clear_buf), buf_forward_capacity_total(&clear_buf));
+    assert_me=
mory_equal(BPTR(&out_buf), BPTR(&clean_buf), buf_forward_capacity_total(&cl=
ean_buf));
     assert_true(error);
     error =3D false;
 
diff --git a/te=
sts/unit_tests/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/=
test_push_update_msg=2Ec
index 389fa09=2E=2E9cb791b 100644
--- a/tests/unit=
_tests/openvpn/test_push_update_msg=2Ec
+++ b/tests/unit_tests/openvpn/test=
_push_update_msg=2Ec
@@ -344,8 +344,8 @@
 
     /* Message 1: first batch o=
f routes, continuation 2 (more coming) */
     struct buffer buf1 =3D alloc=
_buf(512);
-    const char *msg1 =3D "PUSH_UPDATE, route 10=2E1=2E0=2E0 255=
=2E255=2E0=2E0, route 10=2E2=2E0=2E0 255=2E255=2E0=2E0, route 10=2E3=2E0=2E=
0 255=2E255=2E0=2E0,push-continuation 2";
-    buf_write(&buf1, msg1, strle=
n(msg1));
+    const char *cont_msg1 =3D "PUSH_UPDATE, route 10=2E1=2E0=2E0=
 255=2E255=2E0=2E0, route 10=2E2=2E0=2E0 255=2E255=2E0=2E0, route 10=2E3=2E=
0=2E0 255=2E255=2E0=2E0,push-continuation 2";
+    buf_write(&buf1, cont_ms=
g1, strlen(cont_msg1));
 
     assert_int_equal(process_incoming_push_msg(c=
, &buf1, c->options=2Epull, pull_permission_mask(c),
                      =
                          &option_types_found),
@@ -354,8 +354,8 @@
 
     =
/* Message 2: more routes, continuation 2 (more coming) */
     struct buff=
er buf2 =3D alloc_buf(512);
-    const char *msg2 =3D "PUSH_UPDATE, route 1=
0=2E4=2E0=2E0 255=2E255=2E0=2E0, route 10=2E5=2E0=2E0 255=2E255=2E0=2E0, ro=
ute 10=2E6=2E0=2E0 255=2E255=2E0=2E0,push-continuation 2";
-    buf_write(&=
buf2, msg2, strlen(msg2));
+    const char *cont_msg2 =3D "PUSH_UPDATE, rou=
te 10=2E4=2E0=2E0 255=2E255=2E0=2E0, route 10=2E5=2E0=2E0 255=2E255=2E0=2E0=
, route 10=2E6=2E0=2E0 255=2E255=2E0=2E0,push-continuation 2";
+    buf_wri=
te(&buf2, cont_msg2, strlen(cont_msg2));
 
     assert_int_equal(process_in=
coming_push_msg(c, &buf2, c->options=2Epull, pull_permission_mask(c),
     =
                                           &option_types_found),
@@ -364,8 =
+364,8 @@
 
     /* Message 3: final batch of routes, continuation 1 (last =
message) */
     struct buffer buf3 =3D alloc_buf(512);
-    const char *ms=
g3 =3D "PUSH_UPDATE, route 10=2E7=2E0=2E0 255=2E255=2E0=2E0, route 10=2E8=
=2E0=2E0 255=2E255=2E0=2E0, route 10=2E9=2E0=2E0 255=2E255=2E0=2E0,push-con=
tinuation 1";
-    buf_write(&buf3, msg3, strlen(msg3));
+    const char *c=
ont_msg3 =3D "PUSH_UPDATE, route 10=2E7=2E0=2E0 255=2E255=2E0=2E0, route 10=
=2E8=2E0=2E0 255=2E255=2E0=2E0, route 10=2E9=2E0=2E0 255=2E255=2E0=2E0,push=
-continuation 1";
+    buf_write(&buf3, cont_msg3, strlen(cont_msg3));
 
  =
   assert_int_equal(process_incoming_push_msg(c, &buf3, c->options=2Epull, =
pull_permission_mask(c),
                                                &o=
ption_types_found),

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1618?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5=
28f5fd200d877841e473e5e05b7ac7915fa2e33
Gerrit-Change-Number: 1618
Gerrit-P=
atchSet: 16
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--LyqSlMLYl7A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1618?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Rename variables that shadow other variabl=
es or functions<br><br>Identified by cppcheck=2E<br><br>Change-Id: I528f5fd=
200d877841e473e5e05b7ac7915fa2e33<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618<b=
r>Message-Id: &lt;20260819211346=2E2776-1-gert@greenie=2Emuc=2Ede&gt;<br>UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg38540=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openvpn/options=2Ec<br>M s=
rc/openvpn/ps=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>M src/openvpnserv/inter=
active=2Ec<br>M tests/unit_tests/openvpn/test_dhcp=2Ec<br>M tests/unit_test=
s/openvpn/test_push_update_msg=2Ec<br>7 files changed, 49 insertions(+), 52=
 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/op=
envpn/manage=2Ec</span><br><span>index 2a3023c=2E=2E95ff246 100644</span><b=
r><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/mana=
ge=2Ec</span><br><span>@@ -1329,8 +1329,6 @@</span><br><span> static void</=
span><br><span> man_load_stats(struct management *man)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    extern counter_type=
 link_read_bytes_global;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    extern counter_type link_write_bytes_global;</span><br><span>     in=
t nclients =3D 0;</span><br><span> </span><br><span>     if (man-&gt;persis=
t=2Ecallback=2En_clients)</span><br><span>diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec</span><br><span>index 317ce44=2E=2E391739c 1=
00644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/s=
rc/openvpn/options=2Ec</span><br><span>@@ -2081,12 +2081,12 @@</span><br><s=
pan>                     &quot;may accept clients which do not present a ce=
rtificate&quot;);</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    const unsigned int tls_version_max=
 =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsig=
ned int tls_ver_max =3D</span><br><span>         (options-&gt;ssl_flags &gt=
;&gt; SSLF_TLS_VERSION_MAX_SHIFT) &amp; SSLF_TLS_VERSION_MAX_MASK;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned int tls_ver=
sion_min =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st unsigned int tls_ver_min =3D</span><br><span>         (options-&gt;ssl_f=
lags &gt;&gt; SSLF_TLS_VERSION_MIN_SHIFT) &amp; SSLF_TLS_VERSION_MIN_MASK;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (tls_version_max &gt; 0 &amp;&amp; tls_version_max &lt; tls_version_min)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_ver_max=
 &gt; 0 &amp;&amp; tls_ver_max &lt; tls_ver_min)</span><br><span>     {</sp=
an><br><span>         msg(M_USAGE, &quot;--tls-version-min bigger than --tl=
s-version-max&quot;);</span><br><span>     }</span><br><span>@@ -3033,16 +3=
033,16 @@</span><br><span>         {</span><br><span>             struct dn=
s_domain **entry =3D &amp;dns-&gt;search_domains;</span><br><span>         =
    ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &amp;dns-&gt;gc);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            struct dns_domain=
 *new =3D *entry;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        new-&gt;name =3D dhcp-&gt;domain;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            entry =3D &amp;new-&gt;next;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            struct dns_domain *dom=
ain =3D *entry;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        domain-&gt;name =3D dhcp-&gt;domain;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            entry =3D &amp;domain-&gt;next;</span>=
<br><span> </span><br><span>             for (unsigned int i =3D 0; i &lt; =
dhcp-&gt;domain_search_list_len; ++i)</span><br><span>             {</span>=
<br><span>                 ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &a=
mp;dns-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          struct dns_domain *new =3D *entry;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                new-&gt;name =3D dhcp-&gt;domain_sea=
rch_list[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       entry =3D &amp;new-&gt;next;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                struct dns_domain *search_domain =3D *entry=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                se=
arch_domain-&gt;name =3D dhcp-&gt;domain_search_list[i];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                entry =3D &amp;search_=
domain-&gt;next;</span><br><span>             }</span><br><span> </span><br=
><span>             struct dns_server *server =3D dns_server_get(&amp;dns-&=
gt;servers, 0, &amp;dns-&gt;gc);</span><br><span>@@ -3135,7 +3135,6 @@</spa=
n><br><span> static void</span><br><span> options_postprocess_mutate(struct=
 options *o, struct env_set *es)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>     /*</span><b=
r><span>      * Process helper-type options which map to other, more comple=
x</span><br><span>      * sequences of options=2E</span><br><span>@@ -3168,=
7 +3167,7 @@</span><br><span>          * Convert remotes into connection li=
st</span><br><span>          */</span><br><span>         const struct remot=
e_list *rl =3D o-&gt;remote_list;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        for (i =3D 0; i &lt; rl-&gt;len; ++i)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; rl-&=
gt;len; ++i)</span><br><span>         {</span><br><span>             const =
struct remote_entry *re =3D rl-&gt;array[i];</span><br><span>             s=
truct connection_entry ce =3D o-&gt;ce;</span><br><span>@@ -3190,14 +3189,1=
4 @@</span><br><span>     }</span><br><span> </span><br><span>     ASSERT(o=
-&gt;connection_list);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    for (i =3D 0; i &lt; o-&gt;connection_list-&gt;len; ++i)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; o-&g=
t;connection_list-&gt;len; ++i)</span><br><span>     {</span><br><span>    =
     options_postprocess_mutate_ce(o, o-&gt;connection_list-&gt;array[i]);<=
/span><br><span>     }</span><br><span> </span><br><span>     if (o-&gt;ce=
=2Elocal_list)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        for (i =3D 0; i &lt; o-&gt;ce=2Elocal_list-&gt;len;=
 i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (i=
nt i =3D 0; i &lt; o-&gt;ce=2Elocal_list-&gt;len; i++)</span><br><span>    =
     {</span><br><span>             options_postprocess_mutate_le(&amp;o-&g=
t;ce, o-&gt;ce=2Elocal_list-&gt;array[i], o-&gt;mode);</span><br><span>    =
     }</span><br><span>@@ -3225,7 +3224,7 @@</span><br><span>     }</span><=
br><span> </span><br><span>     /* use the same listen list for every outgo=
ing connection */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
for (i =3D 0; i &lt; o-&gt;connection_list-&gt;len; ++i)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; o-&gt;con=
nection_list-&gt;len; ++i)</span><br><span>     {</span><br><span>         =
o-&gt;connection_list-&gt;array[i]-&gt;local_list =3D o-&gt;ce=2Elocal_list=
;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/ps=2Ec b/=
src/openvpn/ps=2Ec</span><br><span>index c3f54ed=2E=2Ebe91a99 100644</span>=
<br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec=
</span><br><span>@@ -813,9 +813,9 @@</span><br><span>      * Get host&#39;s=
 IP address</span><br><span>      */</span><br><span>     struct addrinfo *=
ai;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int status =3D=
 openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, port,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
      0, NULL, AF_UNSPEC, &amp;ai);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ASSERT(status =3D=3D 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int ga_status =3D openvpn_getaddrinfo(GETADDR_RE=
SOLVE | GETADDR_FATAL, host, port,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                        0, NULL, AF_UNSPEC, =
&amp;ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT=
(ga_status =3D=3D 0);</span><br><span>     ASSERT(sizeof(hostaddr=2Eaddr) &=
gt;=3D ai-&gt;ai_addrlen);</span><br><span>     memcpy(&amp;hostaddr=2Eaddr=
=2Esa, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><span>     freeaddrinf=
o(ai);</span><br><span>@@ -863,8 +863,8 @@</span><br><span>         set_clo=
exec(fd[0]);</span><br><span> </span><br><span>         /* wait for backgro=
und child process to initialize */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        int status =3D recv_control(fd[0]);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (status =3D=3D RESPONSE_INIT_=
SUCCEEDED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
nt recv_status =3D recv_control(fd[0]);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (recv_status =3D=3D RESPONSE_INIT_SUCCEEDED)=
</span><br><span>         {</span><br><span>             /* note that this =
will cause possible EAGAIN when writing to</span><br><span>              * =
control socket if proxy process is backlogged */</span><br><span>@@ -875,7 =
+875,7 @@</span><br><span>         }</span><br><span>         else</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         msg(M_ERR, &quot;PORT SHARE: unexpected init recv_control status=
=3D%d&quot;, status);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(M_ERR, &quot;PORT SHARE: unexpected init recv_control sta=
tus=3D%d&quot;, recv_status);</span><br><span>         }</span><br><span>  =
   }</span><br><span>     else</span><br><span>diff --git a/src/openvpn/tls=
_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index 3ed72db=2E=2E4=
7f5ac5 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br><sp=
an>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -776,24 +776,24 @@</s=
pan><br><span>     }</span><br><span> </span><br><span>     /* Sanity check=
: load client key (as &quot;client&quot;) */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct key_ctx_bi test_client_key;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct buffer test_wrapped_clie=
nt_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct k=
ey_ctx_bi check_client_key;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer check_wrapped_client_key;</span><br><span>     st=
ruct key2 keydata;</span><br><span>     msg(D_GENKEY, &quot;Testing client-=
side key loading=2E=2E=2E&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    tls_crypt_v2_init_client_key(&amp;test_client_key, &amp;key=
data, &amp;test_wrapped_client_key, client_file,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    tls_crypt_v2_init_client_key(&amp;check_cl=
ient_key, &amp;keydata, &amp;check_wrapped_client_key, client_file,</span><=
br><span>                                  client_inline);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    free_key_ctx_bi(&amp;test_client_k=
ey);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key_ct=
x_bi(&amp;check_client_key);</span><br><span> </span><br><span>     /* Sani=
ty check: unwrap and load client key (as &quot;server&quot;) */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer test_metadata =
=3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct key2 test_client_key2 =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er check_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key2 che=
ck_client_key2 =3D { 0 };</span><br><span>     free_key_ctx(&amp;server_key=
);</span><br><span>     tls_crypt_v2_init_server_key(&amp;server_key, false=
, server_key_file, server_key_inline);</span><br><span>     msg(D_GENKEY, &=
quot;Testing server-side key loading=2E=2E=2E&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(tls_crypt_v2_unwrap_client_key(&=
amp;test_client_key2, &amp;test_metadata,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                          test_wrapped_=
client_key, &amp;server_key));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    secure_memzero(&amp;test_client_key2, sizeof(test_client_key2)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free_buf(&amp;t=
est_wrapped_client_key);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ASSERT(tls_crypt_v2_unwrap_client_key(&amp;check_client_key2, &amp=
;check_metadata,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                       check_wrapped_client_key, &amp;serve=
r_key));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_=
memzero(&amp;check_client_key2, sizeof(check_client_key2));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;check_wrapped_cli=
ent_key);</span><br><span> </span><br><span> cleanup:</span><br><span>     =
secure_memzero(&amp;client_key, sizeof(client_key));</span><br><span>diff -=
-git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</s=
pan><br><span>index 30cfb6a=2E=2E32c1b9c 100644</span><br><span>--- a/src/o=
penvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactiv=
e=2Ec</span><br><span>@@ -541,19 +541,19 @@</span><br><span> static DWORD</=
span><br><span> InterfaceLuid(const char *iface_name, PNET_LUID luid)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NETI=
O_STATUS status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 NETIO_STATUS convert_status;</span><br><span>     LPWSTR wide_name =3D utf=
8to16(iface_name);</span><br><span> </span><br><span>     if (wide_name)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       status =3D ConvertInterfaceAliasToLuid(wide_name, luid);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        convert_status =3D Conv=
ertInterfaceAliasToLuid(wide_name, luid);</span><br><span>         free(wid=
e_name);</span><br><span>     }</span><br><span>     else</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status =
=3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        convert_status =3D ERROR_OUTOFMEMORY;</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return status;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return convert_status;=
</span><br><span> }</span><br><span> </span><br><span> static BOOL</span><b=
r><span>@@ -1183,8 +1183,8 @@</span><br><span>         goto out;</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    SERVICE_STATUS status;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &=
amp;status) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    SERVICE_STATUS control_status;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE=
, &amp;control_status) =3D=3D 0)</span><br><span>     {</span><br><span>   =
      MsgToEventLog(M_ERR, L&quot;%S: ControlService call failed (%lu)&quot=
;, __func__, GetLastError());</span><br><span>         goto out;</span><br>=
<span>@@ -3763,12 +3763,12 @@</span><br><span> static DWORD WINAPI</span><b=
r><span> ServiceCtrlInteractive(DWORD ctrl_code, DWORD event, LPVOID data, =
LPVOID ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    SERVICE_STATUS *status =3D ctx;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    SERVICE_STATUS *svc_status =3D ctx;</span><br>=
<span>     switch (ctrl_code)</span><br><span>     {</span><br><span>      =
   case SERVICE_CONTROL_STOP:</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            status-&gt;dwCurrentState =3D SERVICE_STOP_PENDING;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            ReportStatusT=
oSCMgr(service, status);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            svc_status-&gt;dwCurrentState =3D SERVICE_STOP_PENDING;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            ReportStat=
usToSCMgr(service, svc_status);</span><br><span>             if (exit_event=
)</span><br><span>             {</span><br><span>                 SetEvent(=
exit_event);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_dhc=
p=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>index 150a3a=
a=2E=2E104fc9a 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_d=
hcp=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_dhcp=2Ec</span>=
<br><span>@@ -55,8 +55,8 @@</span><br><span> {</span><br><span>     struct =
gc_arena gc =3D gc_new();</span><br><span>     struct buffer out_buf =3D al=
loc_buf_gc(512, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct buffer clear_buf =3D alloc_buf_gc(512, &amp;gc);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    buf_clear(&amp;clear_buf);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer clea=
n_buf =3D alloc_buf_gc(512, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    buf_clear(&amp;clean_buf);</span><br><span>     bool =
error =3D false;</span><br><span> </span><br><span> #define LONGDOMAIN &quo=
t;a-reaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaall=
y-long-domain&quot;</span><br><span>@@ -79,7 +79,7 @@</span><br><span>     =
struct buffer small_buf =3D alloc_buf_gc(sizeof(output_1) - 1, &amp;gc);</s=
pan><br><span>     buf_clear(&amp;small_buf);</span><br><span>     write_dh=
cp_search_str(&amp;small_buf, DHCP_DOMAIN_SEARCH, search_list, 2, &amp;erro=
r);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_=
equal(BPTR(&amp;small_buf), BPTR(&amp;clear_buf), buf_forward_capacity_tota=
l(&amp;small_buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_memory_equal(BPTR(&amp;small_buf), BPTR(&amp;clean_buf), buf_for=
ward_capacity_total(&amp;small_buf));</span><br><span>     assert_true(erro=
r);</span><br><span>     error =3D false;</span><br><span> </span><br><span=
>@@ -103,13 +103,13 @@</span><br><span> </span><br><span>     buf_clear(&am=
p;out_buf);</span><br><span>     write_dhcp_search_str(&amp;out_buf, DHCP_D=
OMAIN_SEARCH, search_list + 5, 1, &amp;error);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(&amp;out_buf), BPTR(&=
amp;clear_buf), buf_forward_capacity_total(&amp;clear_buf));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;=
out_buf), BPTR(&amp;clean_buf), buf_forward_capacity_total(&amp;clean_buf))=
;</span><br><span>     assert_true(error);</span><br><span>     error =3D f=
alse;</span><br><span> </span><br><span>     buf_clear(&amp;out_buf);</span=
><br><span>     write_dhcp_search_str(&amp;out_buf, DHCP_DOMAIN_SEARCH, sea=
rch_list, 3, &amp;error);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    assert_memory_equal(BPTR(&amp;out_buf), BPTR(&amp;clear_buf), buf_f=
orward_capacity_total(&amp;clear_buf));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;out_buf), BPTR(&amp;c=
lean_buf), buf_forward_capacity_total(&amp;clean_buf));</span><br><span>   =
  assert_true(error);</span><br><span>     error =3D false;</span><br><span=
> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_push_update_m=
sg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>=
index 389fa09=2E=2E9cb791b 100644</span><br><span>--- a/tests/unit_tests/op=
envpn/test_push_update_msg=2Ec</span><br><span>+++ b/tests/unit_tests/openv=
pn/test_push_update_msg=2Ec</span><br><span>@@ -344,8 +344,8 @@</span><br><=
span> </span><br><span>     /* Message 1: first batch of routes, continuati=
on 2 (more coming) */</span><br><span>     struct buffer buf1 =3D alloc_buf=
(512);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char =
*msg1 =3D &quot;PUSH_UPDATE, route 10=2E1=2E0=2E0 255=2E255=2E0=2E0, route =
10=2E2=2E0=2E0 255=2E255=2E0=2E0, route 10=2E3=2E0=2E0 255=2E255=2E0=2E0,pu=
sh-continuation 2&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    buf_write(&amp;buf1, msg1, strlen(msg1));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *cont_msg1 =3D &quot;PUSH_UPDAT=
E, route 10=2E1=2E0=2E0 255=2E255=2E0=2E0, route 10=2E2=2E0=2E0 255=2E255=
=2E0=2E0, route 10=2E3=2E0=2E0 255=2E255=2E0=2E0,push-continuation 2&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;=
buf1, cont_msg1, strlen(cont_msg1));</span><br><span> </span><br><span>    =
 assert_int_equal(process_incoming_push_msg(c, &amp;buf1, c-&gt;options=2Ep=
ull, pull_permission_mask(c),</span><br><span>                             =
                   &amp;option_types_found),</span><br><span>@@ -354,8 +354=
,8 @@</span><br><span> </span><br><span>     /* Message 2: more routes, con=
tinuation 2 (more coming) */</span><br><span>     struct buffer buf2 =3D al=
loc_buf(512);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t char *msg2 =3D &quot;PUSH_UPDATE, route 10=2E4=2E0=2E0 255=2E255=2E0=2E0,=
 route 10=2E5=2E0=2E0 255=2E255=2E0=2E0, route 10=2E6=2E0=2E0 255=2E255=2E0=
=2E0,push-continuation 2&quot;;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    buf_write(&amp;buf2, msg2, strlen(msg2));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *cont_msg2 =3D &quot;PUS=
H_UPDATE, route 10=2E4=2E0=2E0 255=2E255=2E0=2E0, route 10=2E5=2E0=2E0 255=
=2E255=2E0=2E0, route 10=2E6=2E0=2E0 255=2E255=2E0=2E0,push-continuation 2&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write=
(&amp;buf2, cont_msg2, strlen(cont_msg2));</span><br><span> </span><br><spa=
n>     assert_int_equal(process_incoming_push_msg(c, &amp;buf2, c-&gt;optio=
ns=2Epull, pull_permission_mask(c),</span><br><span>                       =
                         &amp;option_types_found),</span><br><span>@@ -364,=
8 +364,8 @@</span><br><span> </span><br><span>     /* Message 3: final batc=
h of routes, continuation 1 (last message) */</span><br><span>     struct b=
uffer buf3 =3D alloc_buf(512);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const char *msg3 =3D &quot;PUSH_UPDATE, route 10=2E7=2E0=2E0 2=
55=2E255=2E0=2E0, route 10=2E8=2E0=2E0 255=2E255=2E0=2E0, route 10=2E9=2E0=
=2E0 255=2E255=2E0=2E0,push-continuation 1&quot;;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    buf_write(&amp;buf3, msg3, strlen(msg3));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *cont_=
msg3 =3D &quot;PUSH_UPDATE, route 10=2E7=2E0=2E0 255=2E255=2E0=2E0, route 1=
0=2E8=2E0=2E0 255=2E255=2E0=2E0, route 10=2E9=2E0=2E0 255=2E255=2E0=2E0,pus=
h-continuation 1&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    buf_write(&amp;buf3, cont_msg3, strlen(cont_msg3));</span><br><span=
> </span><br><span>     assert_int_equal(process_incoming_push_msg(c, &amp;=
buf3, c-&gt;options=2Epull, pull_permission_mask(c),</span><br><span>      =
                                          &amp;option_types_found),</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1618?usp=3Demail">change 1618</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7=
ac7915fa2e33 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1618=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 16 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>

</body></html>
--LyqSlMLYl7A=--


--===============5648854386112595624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5648854386112595624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5648854386112595624==--

