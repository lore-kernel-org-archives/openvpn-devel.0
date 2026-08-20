Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7157AC5DF81
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CSIT1bqkSpmxqbtjt70qzYrDgwg22hBf8qks7eG0TWE=; b=ZJ+9IlWYgoUkHJLrd7XdW/RzMp
	wMvYXUV4G+/3Fc6RX0M4TVsyXcidaMnVH8XVNhTGxko4swX1397oAbv+LdXYP3pkbTap9isJTyQBW
	3D7vHmIrX9JdGmAAF71wDZ9x9LzHb1Yi9ZaAsPz3OyGqf0Ej/iBZgnu5NnBUujEXuSQ4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwyad-0007w7-U2;
	Thu, 20 Aug 2026 08:57:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwyab-0007v5-T2
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 08:57:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BbhQcKGo6w1Dvw4uwiez9V16i5WYTD0ASUWjeDiRT6c=; b=GpZjmYOmSGs4eMJ+m7EWGaTpnZ
 MVG2ijBMmV/myjfwX33rDdrY0x0VylXaAcLBbTRoO4puqAQ1a3vt1ENvCd5duf5F9K+5r1MOaQyeT
 G4bDeA394KJWZQznPk8tSXqar4k9eRZpXz0r6E8F3GV5W5ZUDpJBwAMAAsUZ7WftsU3I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BbhQcKGo6w1Dvw4uwiez9V16i5WYTD0ASUWjeDiRT6c=; b=l
 gHxnRbGebwqnMaNO4GgsfdvjPoOnpVZO0jfoxj3xSnnLVajoqlGYOLreDaJdGAnxT6b29OLnuj+Sl
 i8GwTwIjls4e1hKtBRVsYQufG/MH561G8HsDmslIUpA1QE/bYhemLBJBV88C0uWaxNl1Na9mQA8EJ
 qUGI/N8AXEYh2K34=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwyaW-00070A-Re for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 08:57:31 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f84023916so1886373f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787216242; x=1787821042; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BbhQcKGo6w1Dvw4uwiez9V16i5WYTD0ASUWjeDiRT6c=;
 b=SvKMYu1VWq1v1e5QXFG03umKMxypD46f/3Cb8ThHoUbblHsI1RAkSoIKduXwLhbw2H
 RFb6GWQbsiEUMH2lgQeoHLtIUaQSPUJ8XJTgSmgzGZN79WT434LFTIFo/AhqNjGi5Pcm
 eyskg67S++xL3A+wbWyC/OCcK9GogNE4iU/4O0DYvOXvGmSWgHbyzzY0zZFix08y1U8W
 qnLfS7F5aF8cWOAQaQ8LAMmEdytzOXEyH8MdHy3cvFZaNpk/PhFx2lEakwY1U7RV/4th
 ooJA7y+guR24yygsr653Pju8Iaoj2hF+WumJEdRzETqD0bLSsyelC2hj6YDF3ZY6zP2p
 PxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787216242; x=1787821042;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BbhQcKGo6w1Dvw4uwiez9V16i5WYTD0ASUWjeDiRT6c=;
 b=hvDYY2yy+Yb/yRTV/7Hg2eDGThVg+wl7EvJEmEusCg4HnYd8hPTINvIudFiBpBHhA7
 PZDrRqifulmzFRwRm6yctx3v9ZhvjRnwcznYHwH9iBvE9vNRCeEtYE/4OCbj9HSbYDel
 GpR0WLjW3BkvScwUnCSmmmR5nfEkV5ixU7G4EywI+E0xmx9tc/5yevwXBXRO/I8+NYHo
 8MwCfu63yeKSeWFDYPC0/9+GzJfjhI40iJvscdYn5dNWiLMdng3OBXgoDDdT+kVpM1ND
 FqIFSk4pIeRJNfCG3yojjGzPNc9Ecr9G+mFIMOVKHfzuUssHnr+WzI9YMV+diQ2mG/4L
 kZ3Q==
X-Gm-Message-State: AFuF++mMglVT0svs9TU8fQlN5nWuyXaMR4DWEpBfJhh1NaUIdPxfGV7o
 dcnvNGnUTWOlaXPWZpvqHq3DsADtgirWaD7uxqyIENsfqeGYKRTeFFXRnx4bC4au6oiSxRWHoov
 eV7H2o8lFqLkxho8tP5uqpq2El4DNGE5GVuoJ/mWthx9gj7qPodjUVCcN3IX6weQXbrgw
X-Gm-Gg: AR+sD123mxycOAbWcagh4acdE4IszFfvOl1lUsPlxaBJJmCI59CY7J651XlVt2LNZfU
 xiL/TmX/cnI4higNP0yva39IUP3PxgtLMQNhuZtjDfvPmALA7j7N0UdmxUrFPzYoDtkTdCYkkhb
 kerK1GZAHcxb7CEjbP6OLTgIOfQqc7jZe0963ZZZ+/vT0HLuo59wpRcFg6sjobscFeUkf9kgzmC
 OGn5UXo9TxEfmUjrbXCGFaX2NTtLdoN279fuWhkNF569T2NIVRO5ZFkwUgxOcBObvTh+A2+/KT9
 j/UmaMYLD6RcJMDm7mOVcBECxQbSWMWTqeGs0TB0VGa0oSmg24aM6GIDGlBm/G11dZLPNSLzXjC
 BDHDbvqDfs0zvCLxbn7axaCBgdt9xsHLJ40QytvEVmokjMSarvEMQQGLMyRpICtA/neStKA4oaG
 HupGbGIvuvLcQcMdAHBK7+SBMulMBWl/6n+3ptynSBOrCRZg+7SZvf6WqaHfq2KsABY5unQoxrq
 Xa33DOyINaEpD6u5o0s14uIusIms5c7HHQNkubXfBdPjYZQE3OCHK1gh1nvPbo2Uw9/3zGUGt3v
 MixSDOp81/dzLznK++5zgrd77AL88EKFplhO3WokqBuGXHQyq6o=
X-Received: by 2002:a05:6000:1447:b0:481:4f2a:bdb0 with SMTP id
 ffacd0b85a97d-482b1fe83ecmr18027090f8f.18.1787216242096; 
 Thu, 20 Aug 2026 01:57:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14415ecsm11052603f8f.7.2026.08.20.01.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 01:57:21 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 08:57:17 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
X-Gerrit-Change-Number: 1618
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1618?usp=email>
X-Gerrit-Commit: 889a873cdb7b7883166a9a1d305552336c117a39
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLkk1MjhmNWZkMjAwZDg3Nzg0MWU0NzNlNWUwNWI3YWM3OTE1ZmEyZTMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b40fa2bfdaaedbd8bf8528b35410184274109e10-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwyaW-00070A-Re
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4222519342122788949=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4222519342122788949==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w/FLHRlJ8nw="; charset=UTF-8

--w/FLHRlJ8nw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#16) to the change originally created b=
y flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Dem=
ail )

The following approvals got outdated and were removed:
Code-Review+2=
 by razvanc


Change subject: Rename variables that shadow other variables =
or functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Rename variables that shadow other variables or functions

Identified by =
cppcheck=2E

Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
Signed-of=
f-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1618
Message-Id: <20260819211346=2E2776-1-gert@greenie=2Emuc=2Ede>
URL=
: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/=
msg38540=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M=
 src/openvpn/manage=2Ec
M src/openvpn/options=2Ec
M src/openvpn/ps=2Ec
M sr=
c/openvpn/tls_crypt=2Ec
M src/openvpnserv/interactive=2Ec
M tests/unit_test=
s/openvpn/test_dhcp=2Ec
M tests/unit_tests/openvpn/test_push_update_msg=2Ec=

7 files changed, 49 insertions(+), 52 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/18/1618/16

diff --git a/src/=
openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 2a3023c=2E=2E95ff246 1006=
44
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -1329,8 +13=
29,6 @@
 static void
 man_load_stats(struct management *man)
 {
-    extern=
 counter_type link_read_bytes_global;
-    extern counter_type link_write_b=
ytes_global;
     int nclients =3D 0;
 
     if (man->persist=2Ecallback=2E=
n_clients)
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
i=
ndex 317ce44=2E=2E391739c 100644
--- a/src/openvpn/options=2Ec
+++ b/src/op=
envpn/options=2Ec
@@ -2081,12 +2081,12 @@
                     "may accept =
clients which do not present a certificate");
     }
 
-    const unsigned =
int tls_version_max =3D
+    const unsigned int tls_ver_max =3D
         (o=
ptions->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MAS=
K;
-    const unsigned int tls_version_min =3D
+    const unsigned int tls_=
ver_min =3D
         (options->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & S=
SLF_TLS_VERSION_MIN_MASK;
 
-    if (tls_version_max > 0 && tls_version_max=
 < tls_version_min)
+    if (tls_ver_max > 0 && tls_ver_max < tls_ver_min)
=
     {
         msg(M_USAGE, "--tls-version-min bigger than --tls-version-m=
ax");
     }
@@ -3033,16 +3033,16 @@
         {
             struct dns_dom=
ain **entry =3D &dns->search_domains;
             ALLOC_OBJ_CLEAR_GC(*entr=
y, struct dns_domain, &dns->gc);
-            struct dns_domain *new =3D *e=
ntry;
-            new->name =3D dhcp->domain;
-            entry =3D &new-=
>next;
+            struct dns_domain *domain =3D *entry;
+            doma=
in->name =3D dhcp->domain;
+            entry =3D &domain->next;
 
        =
     for (unsigned int i =3D 0; i < dhcp->domain_search_list_len; ++i)
    =
         {
                 ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &=
dns->gc);
-                struct dns_domain *new =3D *entry;
-            =
    new->name =3D dhcp->domain_search_list[i];
-                entry =3D &=
new->next;
+                struct dns_domain *search_domain =3D *entry;
+ =
               search_domain->name =3D dhcp->domain_search_list[i];
+      =
          entry =3D &search_domain->next;
             }
 
             str=
uct dns_server *server =3D dns_server_get(&dns->servers, 0, &dns->gc);
@@ -=
3135,7 +3135,6 @@
 static void
 options_postprocess_mutate(struct options *=
o, struct env_set *es)
 {
-    int i;
     /*
      * Process helper-type o=
ptions which map to other, more complex
      * sequences of options=2E
@@ =
-3168,7 +3167,7 @@
          * Convert remotes into connection list
       =
   */
         const struct remote_list *rl =3D o->remote_list;
-        fo=
r (i =3D 0; i < rl->len; ++i)
+        for (int i =3D 0; i < rl->len; ++i)
=
         {
             const struct remote_entry *re =3D rl->array[i];
   =
          struct connection_entry ce =3D o->ce;
@@ -3190,14 +3189,14 @@
   =
  }
 
     ASSERT(o->connection_list);
-    for (i =3D 0; i < o->connection=
_list->len; ++i)
+    for (int i =3D 0; i < o->connection_list->len; ++i)
 =
    {
         options_postprocess_mutate_ce(o, o->connection_list->array[i=
]);
     }
 
     if (o->ce=2Elocal_list)
     {
-        for (i =3D 0; i <=
 o->ce=2Elocal_list->len; i++)
+        for (int i =3D 0; i < o->ce=2Elocal=
_list->len; i++)
         {
             options_postprocess_mutate_le(&o->=
ce, o->ce=2Elocal_list->array[i], o->mode);
         }
@@ -3225,7 +3224,7 @=
@
     }
 
     /* use the same listen list for every outgoing connection *=
/
-    for (i =3D 0; i < o->connection_list->len; ++i)
+    for (int i =3D =
0; i < o->connection_list->len; ++i)
     {
         o->connection_list->ar=
ray[i]->local_list =3D o->ce=2Elocal_list;
     }
diff --git a/src/openvpn/=
ps=2Ec b/src/openvpn/ps=2Ec
index c3f54ed=2E=2Ebe91a99 100644
--- a/src/ope=
nvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -813,9 +813,9 @@
      * Get host's=
 IP address
      */
     struct addrinfo *ai;
-    int status =3D openvpn_=
getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, port,
-                 =
                    0, NULL, AF_UNSPEC, &ai);
-    ASSERT(status =3D=3D 0);=

+    int ga_status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL=
, host, port,
+                                        0, NULL, AF_UNSPEC, =
&ai);
+    ASSERT(ga_status =3D=3D 0);
     ASSERT(sizeof(hostaddr=2Eaddr) =
>=3D ai->ai_addrlen);
     memcpy(&hostaddr=2Eaddr=2Esa, ai->ai_addr, ai->a=
i_addrlen);
     freeaddrinfo(ai);
@@ -863,8 +863,8 @@
         set_cloexec=
(fd[0]);
 
         /* wait for background child process to initialize */
-=
        int status =3D recv_control(fd[0]);
-        if (status =3D=3D RESP=
ONSE_INIT_SUCCEEDED)
+        int recv_status =3D recv_control(fd[0]);
+   =
     if (recv_status =3D=3D RESPONSE_INIT_SUCCEEDED)
         {
           =
  /* note that this will cause possible EAGAIN when writing to
            =
  * control socket if proxy process is backlogged */
@@ -875,7 +875,7 @@
  =
       }
         else
         {
-            msg(M_ERR, "PORT SHARE: unex=
pected init recv_control status=3D%d", status);
+            msg(M_ERR, "PO=
RT SHARE: unexpected init recv_control status=3D%d", recv_status);
        =
 }
     }
     else
diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tl=
s_crypt=2Ec
index 3ed72db=2E=2E47f5ac5 100644
--- a/src/openvpn/tls_crypt=
=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -776,24 +776,24 @@
     }
 
     /*=
 Sanity check: load client key (as "client") */
-    struct key_ctx_bi test=
_client_key;
-    struct buffer test_wrapped_client_key;
+    struct key_ct=
x_bi check_client_key;
+    struct buffer check_wrapped_client_key;
     st=
ruct key2 keydata;
     msg(D_GENKEY, "Testing client-side key loading=2E=
=2E=2E");
-    tls_crypt_v2_init_client_key(&test_client_key, &keydata, &te=
st_wrapped_client_key, client_file,
+    tls_crypt_v2_init_client_key(&chec=
k_client_key, &keydata, &check_wrapped_client_key, client_file,
           =
                       client_inline);
-    free_key_ctx_bi(&test_client_ke=
y);
+    free_key_ctx_bi(&check_client_key);
 
     /* Sanity check: unwrap=
 and load client key (as "server") */
-    struct buffer test_metadata =3D =
alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &gc);
-    struct key2 test_cli=
ent_key2 =3D { 0 };
+    struct buffer check_metadata =3D alloc_buf_gc(TLS_=
CRYPT_V2_MAX_METADATA_LEN, &gc);
+    struct key2 check_client_key2 =3D { 0=
 };
     free_key_ctx(&server_key);
     tls_crypt_v2_init_server_key(&serv=
er_key, false, server_key_file, server_key_inline);
     msg(D_GENKEY, "Tes=
ting server-side key loading=2E=2E=2E");
-    ASSERT(tls_crypt_v2_unwrap_cl=
ient_key(&test_client_key2, &test_metadata,
-                              =
            test_wrapped_client_key, &server_key));
-    secure_memzero(&te=
st_client_key2, sizeof(test_client_key2));
-    free_buf(&test_wrapped_clie=
nt_key);
+    ASSERT(tls_crypt_v2_unwrap_client_key(&check_client_key2, &ch=
eck_metadata,
+                                          check_wrapped_clie=
nt_key, &server_key));
+    secure_memzero(&check_client_key2, sizeof(check=
_client_key2));
+    free_buf(&check_wrapped_client_key);
 
 cleanup:
     =
secure_memzero(&client_key, sizeof(client_key));
diff --git a/src/openvpnse=
rv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 30cfb6a=2E=2E32c=
1b9c 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/int=
eractive=2Ec
@@ -541,19 +541,19 @@
 static DWORD
 InterfaceLuid(const char =
*iface_name, PNET_LUID luid)
 {
-    NETIO_STATUS status;
+    NETIO_STATUS=
 convert_status;
     LPWSTR wide_name =3D utf8to16(iface_name);
 
     if =
(wide_name)
     {
-        status =3D ConvertInterfaceAliasToLuid(wide_nam=
e, luid);
+        convert_status =3D ConvertInterfaceAliasToLuid(wide_name=
, luid);
         free(wide_name);
     }
     else
     {
-        status =
=3D ERROR_OUTOFMEMORY;
+        convert_status =3D ERROR_OUTOFMEMORY;
     =
}
-    return status;
+    return convert_status;
 }
 
 static BOOL
@@ -118=
3,8 +1183,8 @@
         goto out;
     }
 
-    SERVICE_STATUS status;
-   =
 if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &status) =3D=3D 0)=

+    SERVICE_STATUS control_status;
+    if (ControlService(dnssvc, SERVIC=
E_CONTROL_PARAMCHANGE, &control_status) =3D=3D 0)
     {
         MsgToEven=
tLog(M_ERR, L"%S: ControlService call failed (%lu)", __func__, GetLastError=
());
         goto out;
@@ -3763,12 +3763,12 @@
 static DWORD WINAPI
 Servi=
ceCtrlInteractive(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)
 {=

-    SERVICE_STATUS *status =3D ctx;
+    SERVICE_STATUS *svc_status =3D c=
tx;
     switch (ctrl_code)
     {
         case SERVICE_CONTROL_STOP:
-   =
         status->dwCurrentState =3D SERVICE_STOP_PENDING;
-            Repo=
rtStatusToSCMgr(service, status);
+            svc_status->dwCurrentState =
=3D SERVICE_STOP_PENDING;
+            ReportStatusToSCMgr(service, svc_sta=
tus);
             if (exit_event)
             {
                 SetEvent=
(exit_event);
diff --git a/tests/unit_tests/openvpn/test_dhcp=2Ec b/tests/u=
nit_tests/openvpn/test_dhcp=2Ec
index 150a3aa=2E=2E104fc9a 100644
--- a/tes=
ts/unit_tests/openvpn/test_dhcp=2Ec
+++ b/tests/unit_tests/openvpn/test_dhc=
p=2Ec
@@ -55,8 +55,8 @@
 {
     struct gc_arena gc =3D gc_new();
     struc=
t buffer out_buf =3D alloc_buf_gc(512, &gc);
-    struct buffer clear_buf =
=3D alloc_buf_gc(512, &gc);
-    buf_clear(&clear_buf);
+    struct buffer =
clean_buf =3D alloc_buf_gc(512, &gc);
+    buf_clear(&clean_buf);
     bool=
 error =3D false;
 
 #define LONGDOMAIN "a-reaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaally-long-domain"
@@ -79,7 +79,7 @@
   =
  struct buffer small_buf =3D alloc_buf_gc(sizeof(output_1) - 1, &gc);
    =
 buf_clear(&small_buf);
     write_dhcp_search_str(&small_buf, DHCP_DOMAIN_=
SEARCH, search_list, 2, &error);
-    assert_memory_equal(BPTR(&small_buf),=
 BPTR(&clear_buf), buf_forward_capacity_total(&small_buf));
+    assert_mem=
ory_equal(BPTR(&small_buf), BPTR(&clean_buf), buf_forward_capacity_total(&s=
mall_buf));
     assert_true(error);
     error =3D false;
 
@@ -103,13 +10=
3,13 @@
 
     buf_clear(&out_buf);
     write_dhcp_search_str(&out_buf, DH=
CP_DOMAIN_SEARCH, search_list + 5, 1, &error);
-    assert_memory_equal(BPT=
R(&out_buf), BPTR(&clear_buf), buf_forward_capacity_total(&clear_buf));
+  =
  assert_memory_equal(BPTR(&out_buf), BPTR(&clean_buf), buf_forward_capacit=
y_total(&clean_buf));
     assert_true(error);
     error =3D false;
 
    =
 buf_clear(&out_buf);
     write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEAR=
CH, search_list, 3, &error);
-    assert_memory_equal(BPTR(&out_buf), BPTR(=
&clear_buf), buf_forward_capacity_total(&clear_buf));
+    assert_memory_eq=
ual(BPTR(&out_buf), BPTR(&clean_buf), buf_forward_capacity_total(&clean_buf=
));
     assert_true(error);
     error =3D false;
 
diff --git a/tests/uni=
t_tests/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_pu=
sh_update_msg=2Ec
index 389fa09=2E=2E9cb791b 100644
--- a/tests/unit_tests/=
openvpn/test_push_update_msg=2Ec
+++ b/tests/unit_tests/openvpn/test_push_u=
pdate_msg=2Ec
@@ -344,8 +344,8 @@
 
     /* Message 1: first batch of route=
s, continuation 2 (more coming) */
     struct buffer buf1 =3D alloc_buf(51=
2);
-    const char *msg1 =3D "PUSH_UPDATE, route 10=2E1=2E0=2E0 255=2E255=
=2E0=2E0, route 10=2E2=2E0=2E0 255=2E255=2E0=2E0, route 10=2E3=2E0=2E0 255=
=2E255=2E0=2E0,push-continuation 2";
-    buf_write(&buf1, msg1, strlen(msg=
1));
+    const char *cont_msg1 =3D "PUSH_UPDATE, route 10=2E1=2E0=2E0 255=
=2E255=2E0=2E0, route 10=2E2=2E0=2E0 255=2E255=2E0=2E0, route 10=2E3=2E0=2E=
0 255=2E255=2E0=2E0,push-continuation 2";
+    buf_write(&buf1, cont_msg1, =
strlen(cont_msg1));
 
     assert_int_equal(process_incoming_push_msg(c, &b=
uf1, c->options=2Epull, pull_permission_mask(c),
                          =
                      &option_types_found),
@@ -354,8 +354,8 @@
 
     /* M=
essage 2: more routes, continuation 2 (more coming) */
     struct buffer b=
uf2 =3D alloc_buf(512);
-    const char *msg2 =3D "PUSH_UPDATE, route 10=2E=
4=2E0=2E0 255=2E255=2E0=2E0, route 10=2E5=2E0=2E0 255=2E255=2E0=2E0, route =
10=2E6=2E0=2E0 255=2E255=2E0=2E0,push-continuation 2";
-    buf_write(&buf2=
, msg2, strlen(msg2));
+    const char *cont_msg2 =3D "PUSH_UPDATE, route 1=
0=2E4=2E0=2E0 255=2E255=2E0=2E0, route 10=2E5=2E0=2E0 255=2E255=2E0=2E0, ro=
ute 10=2E6=2E0=2E0 255=2E255=2E0=2E0,push-continuation 2";
+    buf_write(&=
buf2, cont_msg2, strlen(cont_msg2));
 
     assert_int_equal(process_incomi=
ng_push_msg(c, &buf2, c->options=2Epull, pull_permission_mask(c),
         =
                                       &option_types_found),
@@ -364,8 +364=
,8 @@
 
     /* Message 3: final batch of routes, continuation 1 (last mess=
age) */
     struct buffer buf3 =3D alloc_buf(512);
-    const char *msg3 =
=3D "PUSH_UPDATE, route 10=2E7=2E0=2E0 255=2E255=2E0=2E0, route 10=2E8=2E0=
=2E0 255=2E255=2E0=2E0, route 10=2E9=2E0=2E0 255=2E255=2E0=2E0,push-continu=
ation 1";
-    buf_write(&buf3, msg3, strlen(msg3));
+    const char *cont_=
msg3 =3D "PUSH_UPDATE, route 10=2E7=2E0=2E0 255=2E255=2E0=2E0, route 10=2E8=
=2E0=2E0 255=2E255=2E0=2E0, route 10=2E9=2E0=2E0 255=2E255=2E0=2E0,push-con=
tinuation 1";
+    buf_write(&buf3, cont_msg3, strlen(cont_msg3));
 
     a=
ssert_int_equal(process_incoming_push_msg(c, &buf3, c->options=2Epull, pull=
_permission_mask(c),
                                                &optio=
n_types_found),

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1618?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
528f5fd200d877841e473e5e05b7ac7915fa2e33
Gerrit-Change-Number: 1618
Gerrit-=
PatchSet: 16
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--w/FLHRlJ8nw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #16</strong> to the change originally created by flichtenhe=
ld=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">Rename variables that=
 shadow other variables or functions<br><br>Identified by cppcheck=2E<br><b=
r>Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1618<br>Message-Id: &lt;20260819211346=2E2776-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg38540=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openv=
pn/options=2Ec<br>M src/openvpn/ps=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>M =
src/openvpnserv/interactive=2Ec<br>M tests/unit_tests/openvpn/test_dhcp=2Ec=
<br>M tests/unit_tests/openvpn/test_push_update_msg=2Ec<br>7 files changed,=
 49 insertions(+), 52 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/18/1618/16</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>in=
dex 2a3023c=2E=2E95ff246 100644</span><br><span>--- a/src/openvpn/manage=2E=
c</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -1329,8 +=
1329,6 @@</span><br><span> static void</span><br><span> man_load_stats(stru=
ct management *man)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    extern counter_type link_read_bytes_global;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    extern counter_type link_wri=
te_bytes_global;</span><br><span>     int nclients =3D 0;</span><br><span> =
</span><br><span>     if (man-&gt;persist=2Ecallback=2En_clients)</span><br=
><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span=
><br><span>index 317ce44=2E=2E391739c 100644</span><br><span>--- a/src/open=
vpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><sp=
an>@@ -2081,12 +2081,12 @@</span><br><span>                     &quot;may a=
ccept clients which do not present a certificate&quot;);</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    const unsigned int tls_version_max =3D</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const unsigned int tls_ver_max =3D</span><br><s=
pan>         (options-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MAX_SHIFT) &a=
mp; SSLF_TLS_VERSION_MAX_MASK;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const unsigned int tls_version_min =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const unsigned int tls_ver_min =3D</s=
pan><br><span>         (options-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MIN=
_SHIFT) &amp; SSLF_TLS_VERSION_MIN_MASK;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (tls_version_max &gt; 0 &amp;&a=
mp; tls_version_max &lt; tls_version_min)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (tls_ver_max &gt; 0 &amp;&amp; tls_ver_max &lt=
; tls_ver_min)</span><br><span>     {</span><br><span>         msg(M_USAGE,=
 &quot;--tls-version-min bigger than --tls-version-max&quot;);</span><br><s=
pan>     }</span><br><span>@@ -3033,16 +3033,16 @@</span><br><span>        =
 {</span><br><span>             struct dns_domain **entry =3D &amp;dns-&gt;=
search_domains;</span><br><span>             ALLOC_OBJ_CLEAR_GC(*entry, str=
uct dns_domain, &amp;dns-&gt;gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            struct dns_domain *new =3D *entry;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            new-&gt;name =3D dhcp-&gt;=
domain;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            en=
try =3D &amp;new-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            struct dns_domain *domain =3D *entry;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            domain-&gt;name =3D dhcp-&=
gt;domain;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   entry =3D &amp;domain-&gt;next;</span><br><span> </span><br><span>      =
       for (unsigned int i =3D 0; i &lt; dhcp-&gt;domain_search_list_len; +=
+i)</span><br><span>             {</span><br><span>                 ALLOC_O=
BJ_CLEAR_GC(*entry, struct dns_domain, &amp;dns-&gt;gc);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                struct dns_domain *new =
=3D *entry;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      new-&gt;name =3D dhcp-&gt;domain_search_list[i];</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                entry =3D &amp;new-&gt;nex=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                s=
truct dns_domain *search_domain =3D *entry;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                search_domain-&gt;name =3D dhcp-&gt=
;domain_search_list[i];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                entry =3D &amp;search_domain-&gt;next;</span><br><span>=
             }</span><br><span> </span><br><span>             struct dns_se=
rver *server =3D dns_server_get(&amp;dns-&gt;servers, 0, &amp;dns-&gt;gc);<=
/span><br><span>@@ -3135,7 +3135,6 @@</span><br><span> static void</span><b=
r><span> options_postprocess_mutate(struct options *o, struct env_set *es)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 int i;</span><br><span>     /*</span><br><span>      * Process helper-type=
 options which map to other, more complex</span><br><span>      * sequences=
 of options=2E</span><br><span>@@ -3168,7 +3167,7 @@</span><br><span>      =
    * Convert remotes into connection list</span><br><span>          */</sp=
an><br><span>         const struct remote_list *rl =3D o-&gt;remote_list;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i=
 &lt; rl-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        for (int i =3D 0; i &lt; rl-&gt;len; ++i)</span><br><span>      =
   {</span><br><span>             const struct remote_entry *re =3D rl-&gt;=
array[i];</span><br><span>             struct connection_entry ce =3D o-&gt=
;ce;</span><br><span>@@ -3190,14 +3189,14 @@</span><br><span>     }</span><=
br><span> </span><br><span>     ASSERT(o-&gt;connection_list);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; o-&gt;con=
nection_list-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (int i =3D 0; i &lt; o-&gt;connection_list-&gt;len; ++i)</sp=
an><br><span>     {</span><br><span>         options_postprocess_mutate_ce(=
o, o-&gt;connection_list-&gt;array[i]);</span><br><span>     }</span><br><s=
pan> </span><br><span>     if (o-&gt;ce=2Elocal_list)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0=
; i &lt; o-&gt;ce=2Elocal_list-&gt;len; i++)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; o-&gt;ce=2Elocal_=
list-&gt;len; i++)</span><br><span>         {</span><br><span>             =
options_postprocess_mutate_le(&amp;o-&gt;ce, o-&gt;ce=2Elocal_list-&gt;arra=
y[i], o-&gt;mode);</span><br><span>         }</span><br><span>@@ -3225,7 +3=
224,7 @@</span><br><span>     }</span><br><span> </span><br><span>     /* u=
se the same listen list for every outgoing connection */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; o-&gt;connectio=
n_list-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (int i =3D 0; i &lt; o-&gt;connection_list-&gt;len; ++i)</span><br=
><span>     {</span><br><span>         o-&gt;connection_list-&gt;array[i]-&=
gt;local_list =3D o-&gt;ce=2Elocal_list;</span><br><span>     }</span><br><=
span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>i=
ndex c3f54ed=2E=2Ebe91a99 100644</span><br><span>--- a/src/openvpn/ps=2Ec</=
span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -813,9 +813,9 @@=
</span><br><span>      * Get host&#39;s IP address</span><br><span>      */=
</span><br><span>     struct addrinfo *ai;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int status =3D openvpn_getaddrinfo(GETADDR_RESOLVE=
 | GETADDR_FATAL, host, port,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                     0, NULL, AF_UNSPEC, &amp;ai);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(status =3D=
=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ga_s=
tatus =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL, host, port,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                    0, NULL, AF_UNSPEC, &amp;ai);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ASSERT(ga_status =3D=3D 0);</span><br><sp=
an>     ASSERT(sizeof(hostaddr=2Eaddr) &gt;=3D ai-&gt;ai_addrlen);</span><b=
r><span>     memcpy(&amp;hostaddr=2Eaddr=2Esa, ai-&gt;ai_addr, ai-&gt;ai_ad=
drlen);</span><br><span>     freeaddrinfo(ai);</span><br><span>@@ -863,8 +8=
63,8 @@</span><br><span>         set_cloexec(fd[0]);</span><br><span> </spa=
n><br><span>         /* wait for background child process to initialize */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int status =3D=
 recv_control(fd[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (status =3D=3D RESPONSE_INIT_SUCCEEDED)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        int recv_status =3D recv_control(fd[=
0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (rec=
v_status =3D=3D RESPONSE_INIT_SUCCEEDED)</span><br><span>         {</span><=
br><span>             /* note that this will cause possible EAGAIN when wri=
ting to</span><br><span>              * control socket if proxy process is =
backlogged */</span><br><span>@@ -875,7 +875,7 @@</span><br><span>         =
}</span><br><span>         else</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            msg(M_ERR, &quot;PORT SHAR=
E: unexpected init recv_control status=3D%d&quot;, status);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(M_ERR, &quot;PORT S=
HARE: unexpected init recv_control status=3D%d&quot;, recv_status);</span><=
br><span>         }</span><br><span>     }</span><br><span>     else</span>=
<br><span>diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2E=
c</span><br><span>index 3ed72db=2E=2E47f5ac5 100644</span><br><span>--- a/s=
rc/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</s=
pan><br><span>@@ -776,24 +776,24 @@</span><br><span>     }</span><br><span>=
 </span><br><span>     /* Sanity check: load client key (as &quot;client&qu=
ot;) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct key=
_ctx_bi test_client_key;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct buffer test_wrapped_client_key;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct key_ctx_bi check_client_key;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer check_wrapp=
ed_client_key;</span><br><span>     struct key2 keydata;</span><br><span>  =
   msg(D_GENKEY, &quot;Testing client-side key loading=2E=2E=2E&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_crypt_v2_init_cli=
ent_key(&amp;test_client_key, &amp;keydata, &amp;test_wrapped_client_key, c=
lient_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_=
crypt_v2_init_client_key(&amp;check_client_key, &amp;keydata, &amp;check_wr=
apped_client_key, client_file,</span><br><span>                            =
      client_inline);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    free_key_ctx_bi(&amp;test_client_key);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    free_key_ctx_bi(&amp;check_client_key);</span><b=
r><span> </span><br><span>     /* Sanity check: unwrap and load client key =
(as &quot;server&quot;) */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct buffer test_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_META=
DATA_LEN, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct key2 test_client_key2 =3D { 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer check_metadata =3D alloc_buf_gc(TLS=
_CRYPT_V2_MAX_METADATA_LEN, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct key2 check_client_key2 =3D { 0 };</span><br><s=
pan>     free_key_ctx(&amp;server_key);</span><br><span>     tls_crypt_v2_i=
nit_server_key(&amp;server_key, false, server_key_file, server_key_inline);=
</span><br><span>     msg(D_GENKEY, &quot;Testing server-side key loading=
=2E=2E=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ASSERT(tls_crypt_v2_unwrap_client_key(&amp;test_client_key2, &amp;test_meta=
data,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                          test_wrapped_client_key, &amp;server_key));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    secure_memzero(&amp;tes=
t_client_key2, sizeof(test_client_key2));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    free_buf(&amp;test_wrapped_client_key);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(tls_crypt_v2_unwrap_=
client_key(&amp;check_client_key2, &amp;check_metadata,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
   check_wrapped_client_key, &amp;server_key));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    secure_memzero(&amp;check_client_key2, size=
of(check_client_key2));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    free_buf(&amp;check_wrapped_client_key);</span><br><span> </span><b=
r><span> cleanup:</span><br><span>     secure_memzero(&amp;client_key, size=
of(client_key));</span><br><span>diff --git a/src/openvpnserv/interactive=
=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 30cfb6a=2E=2E3=
2c1b9c 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><=
br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -541,19 +=
541,19 @@</span><br><span> static DWORD</span><br><span> InterfaceLuid(cons=
t char *iface_name, PNET_LUID luid)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    NETIO_STATUS status;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    NETIO_STATUS convert_status;</spa=
n><br><span>     LPWSTR wide_name =3D utf8to16(iface_name);</span><br><span=
> </span><br><span>     if (wide_name)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        status =3D ConvertInterface=
AliasToLuid(wide_name, luid);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        convert_status =3D ConvertInterfaceAliasToLuid(wide_name,=
 luid);</span><br><span>         free(wide_name);</span><br><span>     }</s=
pan><br><span>     else</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        status =3D ERROR_OUTOFMEMORY;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        convert_status =3D ERROR=
_OUTOFMEMORY;</span><br><span>     }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return status;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return convert_status;</span><br><span> }</span><br><span=
> </span><br><span> static BOOL</span><br><span>@@ -1183,8 +1183,8 @@</span=
><br><span>         goto out;</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SERVICE_STATUS status;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ControlServic=
e(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &amp;status) =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    SERVICE_STATUS control_status=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ControlSer=
vice(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &amp;control_status) =3D=3D 0)</s=
pan><br><span>     {</span><br><span>         MsgToEventLog(M_ERR, L&quot;%=
S: ControlService call failed (%lu)&quot;, __func__, GetLastError());</span=
><br><span>         goto out;</span><br><span>@@ -3763,12 +3763,12 @@</span=
><br><span> static DWORD WINAPI</span><br><span> ServiceCtrlInteractive(DWO=
RD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    SERVICE_STATUS *status=
 =3D ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SERVIC=
E_STATUS *svc_status =3D ctx;</span><br><span>     switch (ctrl_code)</span=
><br><span>     {</span><br><span>         case SERVICE_CONTROL_STOP:</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            status-&gt;dwCu=
rrentState =3D SERVICE_STOP_PENDING;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            ReportStatusToSCMgr(service, status);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            svc_status-&gt;dwC=
urrentState =3D SERVICE_STOP_PENDING;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            ReportStatusToSCMgr(service, svc_status);</sp=
an><br><span>             if (exit_event)</span><br><span>             {</s=
pan><br><span>                 SetEvent(exit_event);</span><br><span>diff -=
-git a/tests/unit_tests/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/te=
st_dhcp=2Ec</span><br><span>index 150a3aa=2E=2E104fc9a 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>@@ -55,8 +55,8 @@</span><=
br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br=
><span>     struct buffer out_buf =3D alloc_buf_gc(512, &amp;gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer clear_buf =3D=
 alloc_buf_gc(512, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    buf_clear(&amp;clear_buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct buffer clean_buf =3D alloc_buf_gc(512, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&am=
p;clean_buf);</span><br><span>     bool error =3D false;</span><br><span> <=
/span><br><span> #define LONGDOMAIN &quot;a-reaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaally-long-domain&quot;</span><br><span=
>@@ -79,7 +79,7 @@</span><br><span>     struct buffer small_buf =3D alloc_b=
uf_gc(sizeof(output_1) - 1, &amp;gc);</span><br><span>     buf_clear(&amp;s=
mall_buf);</span><br><span>     write_dhcp_search_str(&amp;small_buf, DHCP_=
DOMAIN_SEARCH, search_list, 2, &amp;error);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(&amp;small_buf), BPTR(&a=
mp;clear_buf), buf_forward_capacity_total(&amp;small_buf));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;s=
mall_buf), BPTR(&amp;clean_buf), buf_forward_capacity_total(&amp;small_buf)=
);</span><br><span>     assert_true(error);</span><br><span>     error =3D =
false;</span><br><span> </span><br><span>@@ -103,13 +103,13 @@</span><br><s=
pan> </span><br><span>     buf_clear(&amp;out_buf);</span><br><span>     wr=
ite_dhcp_search_str(&amp;out_buf, DHCP_DOMAIN_SEARCH, search_list + 5, 1, &=
amp;error);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert=
_memory_equal(BPTR(&amp;out_buf), BPTR(&amp;clear_buf), buf_forward_capacit=
y_total(&amp;clear_buf));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_memory_equal(BPTR(&amp;out_buf), BPTR(&amp;clean_buf), buf=
_forward_capacity_total(&amp;clean_buf));</span><br><span>     assert_true(=
error);</span><br><span>     error =3D false;</span><br><span> </span><br><=
span>     buf_clear(&amp;out_buf);</span><br><span>     write_dhcp_search_s=
tr(&amp;out_buf, DHCP_DOMAIN_SEARCH, search_list, 3, &amp;error);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(&a=
mp;out_buf), BPTR(&amp;clear_buf), buf_forward_capacity_total(&amp;clear_bu=
f));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memo=
ry_equal(BPTR(&amp;out_buf), BPTR(&amp;clean_buf), buf_forward_capacity_tot=
al(&amp;clean_buf));</span><br><span>     assert_true(error);</span><br><sp=
an>     error =3D false;</span><br><span> </span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/t=
est_push_update_msg=2Ec</span><br><span>index 389fa09=2E=2E9cb791b 100644</=
span><br><span>--- a/tests/unit_tests/openvpn/test_push_update_msg=2Ec</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><=
br><span>@@ -344,8 +344,8 @@</span><br><span> </span><br><span>     /* Mess=
age 1: first batch of routes, continuation 2 (more coming) */</span><br><sp=
an>     struct buffer buf1 =3D alloc_buf(512);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    const char *msg1 =3D &quot;PUSH_UPDATE, route =
10=2E1=2E0=2E0 255=2E255=2E0=2E0, route 10=2E2=2E0=2E0 255=2E255=2E0=2E0, r=
oute 10=2E3=2E0=2E0 255=2E255=2E0=2E0,push-continuation 2&quot;;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    buf_write(&amp;buf1, msg1, s=
trlen(msg1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *cont_msg1 =3D &quot;PUSH_UPDATE, route 10=2E1=2E0=2E0 255=2E255=
=2E0=2E0, route 10=2E2=2E0=2E0 255=2E255=2E0=2E0, route 10=2E3=2E0=2E0 255=
=2E255=2E0=2E0,push-continuation 2&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    buf_write(&amp;buf1, cont_msg1, strlen(cont_msg1)=
);</span><br><span> </span><br><span>     assert_int_equal(process_incoming=
_push_msg(c, &amp;buf1, c-&gt;options=2Epull, pull_permission_mask(c),</spa=
n><br><span>                                                &amp;option_typ=
es_found),</span><br><span>@@ -354,8 +354,8 @@</span><br><span> </span><br>=
<span>     /* Message 2: more routes, continuation 2 (more coming) */</span=
><br><span>     struct buffer buf2 =3D alloc_buf(512);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    const char *msg2 =3D &quot;PUSH_UPDATE=
, route 10=2E4=2E0=2E0 255=2E255=2E0=2E0, route 10=2E5=2E0=2E0 255=2E255=2E=
0=2E0, route 10=2E6=2E0=2E0 255=2E255=2E0=2E0,push-continuation 2&quot;;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_write(&amp;buf2,=
 msg2, strlen(msg2));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *cont_msg2 =3D &quot;PUSH_UPDATE, route 10=2E4=2E0=2E0 255=
=2E255=2E0=2E0, route 10=2E5=2E0=2E0 255=2E255=2E0=2E0, route 10=2E6=2E0=2E=
0 255=2E255=2E0=2E0,push-continuation 2&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    buf_write(&amp;buf2, cont_msg2, strlen(cont_=
msg2));</span><br><span> </span><br><span>     assert_int_equal(process_inc=
oming_push_msg(c, &amp;buf2, c-&gt;options=2Epull, pull_permission_mask(c),=
</span><br><span>                                                &amp;optio=
n_types_found),</span><br><span>@@ -364,8 +364,8 @@</span><br><span> </span=
><br><span>     /* Message 3: final batch of routes, continuation 1 (last m=
essage) */</span><br><span>     struct buffer buf3 =3D alloc_buf(512);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *msg3 =3D &=
quot;PUSH_UPDATE, route 10=2E7=2E0=2E0 255=2E255=2E0=2E0, route 10=2E8=2E0=
=2E0 255=2E255=2E0=2E0, route 10=2E9=2E0=2E0 255=2E255=2E0=2E0,push-continu=
ation 1&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf=
_write(&amp;buf3, msg3, strlen(msg3));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *cont_msg3 =3D &quot;PUSH_UPDATE, route 1=
0=2E7=2E0=2E0 255=2E255=2E0=2E0, route 10=2E8=2E0=2E0 255=2E255=2E0=2E0, ro=
ute 10=2E9=2E0=2E0 255=2E255=2E0=2E0,push-continuation 1&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf3, cont_m=
sg3, strlen(cont_msg3));</span><br><span> </span><br><span>     assert_int_=
equal(process_incoming_push_msg(c, &amp;buf3, c-&gt;options=2Epull, pull_pe=
rmission_mask(c),</span><br><span>                                         =
       &amp;option_types_found),</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Dem=
ail">change 1618</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1618?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1618 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner=
: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--w/FLHRlJ8nw=--


--===============4222519342122788949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4222519342122788949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4222519342122788949==--

