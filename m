Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A994C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kFZsiJgKzKmzn+k6y0zNwpfcuOvKBQ0z3igrQTRclGk=; b=jBU5If0GuWFi1cig6lw84z1duc
	rAm9xTgSzt6wvdSezaFFj9PLgGeboK4PhhmgzWwK+RHWOa5DxfcIyrXoP4GojzIHJx51OzYo9WwCh
	li1FZZ0NagiUGvjMgC7cP+SvGUVEdwnFYXr9DDCxwXeUhhdGJqKw9GkRC6h0DpWaEkg4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wupH5-0000ea-4V;
	Fri, 14 Aug 2026 10:36:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wupGn-0000dF-BK
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:36:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HqROqlmBdzM+982PsGP+ZFlds4sLj207BmXS2qEHhe4=; b=QT9De7hnce1R5vpAy1TKb6B/c3
 bRxGf4pupGYTK15PejUNuS8zIV6v99htt4+Z5xTpkPyQwjQWIXMHtjr5ixWxXdgTziUn0iFz1u3H1
 Gm+G50TNFE9iUgMEvNDqJyuSiB2oyz4ZXxbqRhnzhR5gHGqLQcvebjeG2LGrJrnCQRS4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HqROqlmBdzM+982PsGP+ZFlds4sLj207BmXS2qEHhe4=; b=S
 pKju8UJNS1T2CsbCffW4jsa+AXlDO5Dd0guTDNfKIUGomVNubKEcYwIvAF5VJmCmAk/y9qyL/eh1i
 u2K18J97vVhSQGf6Og48PCGdfGdgRLqudlH9JQbkSiim031ipjRsBdaTYUbEfAmI8FUCTZNebeL/4
 y+uH6A6GZrYMC/no=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wupGk-00034X-31 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:36:10 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so745906f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 03:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786703760; x=1787308560; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HqROqlmBdzM+982PsGP+ZFlds4sLj207BmXS2qEHhe4=;
 b=cmohf4WFEq8L9UbtlL2HR/4mqrYwBrYmbS/3BOcTMT7PJv0chJ8rgzfK8p6iccSugH
 7VD1acvs99+4VBpQH0nnuroWpiUceaxVD5zk6OLUY2aQuR1TfjOIixpCNooKoMHDxXVh
 QLPxwZxSIUl1Iu/I2mc/36mf8M+0zfAXWhv4W8QGwUgJ7Npf23/2pt5eXAYN0/05246y
 gGrn/rn1hcb4eSukzGNTct4fRWthpIqcVBH4ZzeogyP15P3K9l/Ble3RlWAixmfSXD99
 32e96Ai/yTwMM7l5RhL72nqWRPhEUn+mHK2BD6sCBMp27Fz2LzQHeumaVhFUvxq9oXdF
 FV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786703760; x=1787308560;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HqROqlmBdzM+982PsGP+ZFlds4sLj207BmXS2qEHhe4=;
 b=jhzMj8+TV3F5FPlXMVyBGOtHTulv3zgN6sNvlb5Y1bFe9voIW1XmIz3bZqBbY91Zeh
 eangTxE+0mw91R5mYe5QEN0ca0ilGYN4JoKTF2Ob2lRDSlAaRvj4u5nh3wmmk2QV32Zo
 7IqnVFh+bfxczJKUWAvQx0PVVxGlfs1oiQ24UMr6KyGHhevt3mDy9TJh3XBZkCDVK8f4
 hlR2En7XnjmHyIBecxJJst/kPJejE++GcK1LLumwByVOb/x/u8IXOAUej7XOIlVUtynF
 s2Dz3sdrOyI/ln+/HxVAQdCgYym2UFzgBQRaNOGbw9qp41c9uN3x4FGgl9tiwvRhyeRQ
 4y7w==
X-Gm-Message-State: AOJu0YwElsbNIYez+Tr8EbR4qRF5bd5CFczMYN+16YTsetTD7scegdTk
 xi9HIlvpUc8pGv2C1crnZpbz+URIxSvYCgAx6NiPUr7lpemWh/KDcuKJu+hI5vT31RPie2xI9rj
 V9U6tA27+cRCKtA7s80wVeOjyORGFMetILSl1FzxBTq9iSn2ePtgq/KE0ePRFoZGxPckG
X-Gm-Gg: AR+sD11M+CCtMyx3CFQdpUKi/iMIxAjVcBeUw4pvlu2FPLB+54GzaTeptdDFVJDhdC+
 u79MWlMI8hZwwR1h+5jP/OU4i0xQe809b9kCeFBrMAqjcGtu8Yu4GruxwgHBnntPPNXbmz4Xtgj
 +FvgU3zvNoE3+hhSAkajldahHfxrj/j6v7foiOQiUOY3UIjmOBxJjnOO+so3wjyqBd4WL8wKva/
 SffkxgP1xXuRGFWIdp99LIUOXk6S9A4OoKECKEh7USvnVEA7ffgLRSSKtq1kfIVgrP8UK31/MTz
 Bk9EGAF6bb+tDeC60a4gTQ76SKXHZ4FONAhzHpEUpVchnLiNRLeHuroGyoKVHqTlFDWixfd4zYe
 56vcRdLOKWbPT3z7OwAvYX35vdVV6sYKzHt5C563Sss14+FlRiH3CL91oS6klq2TOSlGZmc+4hM
 sPz5DgrxwbVJdm2Gk2ntDYEssDkBSxmhLr6ZuEekM2+hzolQpalggYdW+UAXDrEAZpkqyUiJ4iM
 Y8mi4n9hFGVsw/+4ObnR05r0C7bJLj3nr1UJHtc44jOGUTrLIqfqQ40Tov46yEFH4nAuPhk3adX
 sHRRgNRlACSztUDJCswBUSh5FXwZxSAMscDbIxDnfMkzcOQefrVUCdvE0QnTUw==
X-Received: by 2002:a05:600c:3398:b0:499:52dd:c1f0 with SMTP id
 5b1f17b1804b1-499879298c4mr47857965e9.1.1786703759730; 
 Fri, 14 Aug 2026 03:35:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49989aeaa34sm18941935e9.14.2026.08.14.03.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:35:59 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 10:35:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
X-Gerrit-Change-Number: 1618
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1618?usp=email>
X-Gerrit-Commit: ed759afec30cf6e1ce9c06af92679a17afdc89f1
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLkk1MjhmNWZkMjAwZDg3Nzg0MWU0NzNlNWUwNWI3YWM3OTE1ZmEyZTMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0998d4ce3304561ab26f411f12578b798b015234-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wupGk-00034X-31
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5007488382604550415=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5007488382604550415==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oeO5O6cfvIs="; charset=UTF-8

--oeO5O6cfvIs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1618?usp=3Demail

to look at the new patch set (#13)=2E
=


Change subject: Rename variables that shadow other variables or functions=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Rename var=
iables that shadow other variables or functions

Identified by cppcheck=2E
=

Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
Signed-off-by: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/manage=2Ec
M src/op=
envpn/options=2Ec
M src/openvpn/ps=2Ec
M src/openvpn/tls_crypt=2Ec
M src/op=
envpnserv/interactive=2Ec
M tests/unit_tests/openvpn/test_dhcp=2Ec
M tests/=
unit_tests/openvpn/test_push_update_msg=2Ec
7 files changed, 45 insertions(=
+), 48 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/18/1618/13

diff --git a/src/openvpn/manage=2Ec b/src/openvpn=
/manage=2Ec
index f1dccc1=2E=2Ec082f51 100644
--- a/src/openvpn/manage=2Ec
=
+++ b/src/openvpn/manage=2Ec
@@ -1328,8 +1328,6 @@
 static void
 man_load_s=
tats(struct management *man)
 {
-    extern counter_type link_read_bytes_gl=
obal;
-    extern counter_type link_write_bytes_global;
     int nclients =
=3D 0;
 
     if (man->persist=2Ecallback=2En_clients)
diff --git a/src/ope=
nvpn/options=2Ec b/src/openvpn/options=2Ec
index 1a95d95=2E=2E2b22b1d 10064=
4
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -2715,12 +=
2715,12 @@
                     "may accept clients which do not present a =
certificate");
     }
 
-    const unsigned int tls_version_max =3D
+    co=
nst unsigned int tls_ver_max =3D
         (options->ssl_flags >> SSLF_TLS_V=
ERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
-    const unsigned int tls_=
version_min =3D
+    const unsigned int tls_ver_min =3D
         (options->=
ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
 
-  =
  if (tls_version_max > 0 && tls_version_max < tls_version_min)
+    if (tl=
s_ver_max > 0 && tls_ver_max < tls_ver_min)
     {
         msg(M_USAGE, "-=
-tls-version-min bigger than --tls-version-max");
     }
@@ -3667,16 +3667,=
16 @@
         {
             struct dns_domain **entry =3D &dns->search_do=
mains;
             ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc)=
;
-            struct dns_domain *new =3D *entry;
-            new->name =
=3D dhcp->domain;
-            entry =3D &new->next;
+            struct dn=
s_domain *domain =3D *entry;
+            domain->name =3D dhcp->domain;
+ =
           entry =3D &domain->next;
 
             for (unsigned int i =3D =
0; i < dhcp->domain_search_list_len; ++i)
             {
                 A=
LLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
-                st=
ruct dns_domain *new =3D *entry;
-                new->name =3D dhcp->domai=
n_search_list[i];
-                entry =3D &new->next;
+                s=
truct dns_domain *search_domain =3D *entry;
+                search_domain-=
>name =3D dhcp->domain_search_list[i];
+                entry =3D &search_d=
omain->next;
             }
 
             struct dns_server *server =3D dn=
s_server_get(&dns->servers, 0, &dns->gc);
@@ -3769,7 +3769,6 @@
 static voi=
d
 options_postprocess_mutate(struct options *o, struct env_set *es)
 {
-  =
  int i;
     /*
      * Process helper-type options which map to other, mo=
re complex
      * sequences of options=2E
@@ -3802,7 +3801,7 @@
          =
* Convert remotes into connection list
          */
         const struct r=
emote_list *rl =3D o->remote_list;
-        for (i =3D 0; i < rl->len; ++i)=

+        for (int i =3D 0; i < rl->len; ++i)
         {
             const=
 struct remote_entry *re =3D rl->array[i];
             struct connection_e=
ntry ce =3D o->ce;
@@ -3824,14 +3823,14 @@
     }
 
     ASSERT(o->connecti=
on_list);
-    for (i =3D 0; i < o->connection_list->len; ++i)
+    for (in=
t i =3D 0; i < o->connection_list->len; ++i)
     {
         options_postpr=
ocess_mutate_ce(o, o->connection_list->array[i]);
     }
 
     if (o->ce=
=2Elocal_list)
     {
-        for (i =3D 0; i < o->ce=2Elocal_list->len; i=
++)
+        for (int i =3D 0; i < o->ce=2Elocal_list->len; i++)
         {=

             options_postprocess_mutate_le(&o->ce, o->ce=2Elocal_list->arr=
ay[i], o->mode);
         }
@@ -3859,7 +3858,7 @@
     }
 
     /* use the =
same listen list for every outgoing connection */
-    for (i =3D 0; i < o-=
>connection_list->len; ++i)
+    for (int i =3D 0; i < o->connection_list->=
len; ++i)
     {
         o->connection_list->array[i]->local_list =3D o->c=
e=2Elocal_list;
     }
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec=

index c3f54ed=2E=2E57afacd 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openv=
pn/ps=2Ec
@@ -863,8 +863,8 @@
         set_cloexec(fd[0]);
 
         /* wa=
it for background child process to initialize */
-        int status =3D re=
cv_control(fd[0]);
-        if (status =3D=3D RESPONSE_INIT_SUCCEEDED)
+   =
     int recv_status =3D recv_control(fd[0]);
+        if (recv_status =3D=
=3D RESPONSE_INIT_SUCCEEDED)
         {
             /* note that this will=
 cause possible EAGAIN when writing to
              * control socket if pr=
oxy process is backlogged */
diff --git a/src/openvpn/tls_crypt=2Ec b/src/o=
penvpn/tls_crypt=2Ec
index 3ed72db=2E=2E47f5ac5 100644
--- a/src/openvpn/tl=
s_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -776,24 +776,24 @@
     }
 
=
     /* Sanity check: load client key (as "client") */
-    struct key_ctx_=
bi test_client_key;
-    struct buffer test_wrapped_client_key;
+    struct=
 key_ctx_bi check_client_key;
+    struct buffer check_wrapped_client_key;
=
     struct key2 keydata;
     msg(D_GENKEY, "Testing client-side key loadi=
ng=2E=2E=2E");
-    tls_crypt_v2_init_client_key(&test_client_key, &keydata=
, &test_wrapped_client_key, client_file,
+    tls_crypt_v2_init_client_key(=
&check_client_key, &keydata, &check_wrapped_client_key, client_file,
      =
                            client_inline);
-    free_key_ctx_bi(&test_clie=
nt_key);
+    free_key_ctx_bi(&check_client_key);
 
     /* Sanity check: u=
nwrap and load client key (as "server") */
-    struct buffer test_metadata=
 =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &gc);
-    struct key2 tes=
t_client_key2 =3D { 0 };
+    struct buffer check_metadata =3D alloc_buf_gc=
(TLS_CRYPT_V2_MAX_METADATA_LEN, &gc);
+    struct key2 check_client_key2 =
=3D { 0 };
     free_key_ctx(&server_key);
     tls_crypt_v2_init_server_ke=
y(&server_key, false, server_key_file, server_key_inline);
     msg(D_GENKE=
Y, "Testing server-side key loading=2E=2E=2E");
-    ASSERT(tls_crypt_v2_un=
wrap_client_key(&test_client_key2, &test_metadata,
-                       =
                   test_wrapped_client_key, &server_key));
-    secure_memz=
ero(&test_client_key2, sizeof(test_client_key2));
-    free_buf(&test_wrapp=
ed_client_key);
+    ASSERT(tls_crypt_v2_unwrap_client_key(&check_client_ke=
y2, &check_metadata,
+                                          check_wrapp=
ed_client_key, &server_key));
+    secure_memzero(&check_client_key2, sizeo=
f(check_client_key2));
+    free_buf(&check_wrapped_client_key);
 
 cleanup=
:
     secure_memzero(&client_key, sizeof(client_key));
diff --git a/src/op=
envpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
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
index 389fa09=2E=2E500dbe9 100644
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
+    const char *cmsg1 =3D "PUSH_UPDATE, route 10=2E1=2E0=2E0 255=
=2E255=2E0=2E0, route 10=2E2=2E0=2E0 255=2E255=2E0=2E0, route 10=2E3=2E0=2E=
0 255=2E255=2E0=2E0,push-continuation 2";
+    buf_write(&buf1, cmsg1, strl=
en(cmsg1));
 
     assert_int_equal(process_incoming_push_msg(c, &buf1, c->=
options=2Epull, pull_permission_mask(c),
                                  =
              &option_types_found),
@@ -354,8 +354,8 @@
 
     /* Message 2=
: more routes, continuation 2 (more coming) */
     struct buffer buf2 =3D =
alloc_buf(512);
-    const char *msg2 =3D "PUSH_UPDATE, route 10=2E4=2E0=2E=
0 255=2E255=2E0=2E0, route 10=2E5=2E0=2E0 255=2E255=2E0=2E0, route 10=2E6=
=2E0=2E0 255=2E255=2E0=2E0,push-continuation 2";
-    buf_write(&buf2, msg2=
, strlen(msg2));
+    const char *cmsg2 =3D "PUSH_UPDATE, route 10=2E4=2E0=
=2E0 255=2E255=2E0=2E0, route 10=2E5=2E0=2E0 255=2E255=2E0=2E0, route 10=2E=
6=2E0=2E0 255=2E255=2E0=2E0,push-continuation 2";
+    buf_write(&buf2, cms=
g2, strlen(cmsg2));
 
     assert_int_equal(process_incoming_push_msg(c, &b=
uf2, c->options=2Epull, pull_permission_mask(c),
                          =
                      &option_types_found),
@@ -364,8 +364,8 @@
 
     /* M=
essage 3: final batch of routes, continuation 1 (last message) */
     stru=
ct buffer buf3 =3D alloc_buf(512);
-    const char *msg3 =3D "PUSH_UPDATE, =
route 10=2E7=2E0=2E0 255=2E255=2E0=2E0, route 10=2E8=2E0=2E0 255=2E255=2E0=
=2E0, route 10=2E9=2E0=2E0 255=2E255=2E0=2E0,push-continuation 1";
-    buf=
_write(&buf3, msg3, strlen(msg3));
+    const char *cmsg3 =3D "PUSH_UPDATE,=
 route 10=2E7=2E0=2E0 255=2E255=2E0=2E0, route 10=2E8=2E0=2E0 255=2E255=2E0=
=2E0, route 10=2E9=2E0=2E0 255=2E255=2E0=2E0,push-continuation 1";
+    buf=
_write(&buf3, cmsg3, strlen(cmsg3));
 
     assert_int_equal(process_incomi=
ng_push_msg(c, &buf3, c->options=2Epull, pull_permission_mask(c),
         =
                                       &option_types_found),

-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac=
7915fa2e33
Gerrit-Change-Number: 1618
Gerrit-PatchSet: 13
Gerrit-Owner: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--oeO5O6cfvIs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #13</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1618?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">R=
ename variables that shadow other variables or functions<br><br>Identified =
by cppcheck=2E<br><br>Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<=
br>M src/openvpn/manage=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/p=
s=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>M src/openvpnserv/interactive=2Ec<b=
r>M tests/unit_tests/openvpn/test_dhcp=2Ec<br>M tests/unit_tests/openvpn/te=
st_push_update_msg=2Ec<br>7 files changed, 45 insertions(+), 48 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/18/1618/13</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b=
/src/openvpn/manage=2Ec</span><br><span>index f1dccc1=2E=2Ec082f51 100644</=
span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openv=
pn/manage=2Ec</span><br><span>@@ -1328,8 +1328,6 @@</span><br><span> static=
 void</span><br><span> man_load_stats(struct management *man)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    extern count=
er_type link_read_bytes_global;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    extern counter_type link_write_bytes_global;</span><br><span>=
     int nclients =3D 0;</span><br><span> </span><br><span>     if (man-&gt=
;persist=2Ecallback=2En_clients)</span><br><span>diff --git a/src/openvpn/o=
ptions=2Ec b/src/openvpn/options=2Ec</span><br><span>index 1a95d95=2E=2E2b2=
2b1d 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+=
++ b/src/openvpn/options=2Ec</span><br><span>@@ -2715,12 +2715,12 @@</span>=
<br><span>                     &quot;may accept clients which do not presen=
t a certificate&quot;);</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned int tls_versi=
on_max =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 unsigned int tls_ver_max =3D</span><br><span>         (options-&gt;ssl_fla=
gs &gt;&gt; SSLF_TLS_VERSION_MAX_SHIFT) &amp; SSLF_TLS_VERSION_MAX_MASK;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned int t=
ls_version_min =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const unsigned int tls_ver_min =3D</span><br><span>         (options-&gt=
;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MIN_SHIFT) &amp; SSLF_TLS_VERSION_MIN_=
MASK;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (tls_version_max &gt; 0 &amp;&amp; tls_version_max &lt; tls_versio=
n_min)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_v=
er_max &gt; 0 &amp;&amp; tls_ver_max &lt; tls_ver_min)</span><br><span>    =
 {</span><br><span>         msg(M_USAGE, &quot;--tls-version-min bigger tha=
n --tls-version-max&quot;);</span><br><span>     }</span><br><span>@@ -3667=
,16 +3667,16 @@</span><br><span>         {</span><br><span>             str=
uct dns_domain **entry =3D &amp;dns-&gt;search_domains;</span><br><span>   =
          ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &amp;dns-&gt;gc);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct dns_=
domain *new =3D *entry;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            new-&gt;name =3D dhcp-&gt;domain;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            entry =3D &amp;new-&gt;next;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            struct dns_domai=
n *domain =3D *entry;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            domain-&gt;name =3D dhcp-&gt;domain;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            entry =3D &amp;domain-&gt;next;<=
/span><br><span> </span><br><span>             for (unsigned int i =3D 0; i=
 &lt; dhcp-&gt;domain_search_list_len; ++i)</span><br><span>             {<=
/span><br><span>                 ALLOC_OBJ_CLEAR_GC(*entry, struct dns_doma=
in, &amp;dns-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                struct dns_domain *new =3D *entry;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                new-&gt;name =3D dhcp-&gt;doma=
in_search_list[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             entry =3D &amp;new-&gt;next;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                struct dns_domain *search_domain =3D =
*entry;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    search_domain-&gt;name =3D dhcp-&gt;domain_search_list[i];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                entry =3D &amp;s=
earch_domain-&gt;next;</span><br><span>             }</span><br><span> </sp=
an><br><span>             struct dns_server *server =3D dns_server_get(&amp=
;dns-&gt;servers, 0, &amp;dns-&gt;gc);</span><br><span>@@ -3769,7 +3769,6 @=
@</span><br><span> static void</span><br><span> options_postprocess_mutate(=
struct options *o, struct env_set *es)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>     /*</spa=
n><br><span>      * Process helper-type options which map to other, more co=
mplex</span><br><span>      * sequences of options=2E</span><br><span>@@ -3=
802,7 +3801,7 @@</span><br><span>          * Convert remotes into connectio=
n list</span><br><span>          */</span><br><span>         const struct r=
emote_list *rl =3D o-&gt;remote_list;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        for (i =3D 0; i &lt; rl-&gt;len; ++i)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; =
rl-&gt;len; ++i)</span><br><span>         {</span><br><span>             co=
nst struct remote_entry *re =3D rl-&gt;array[i];</span><br><span>          =
   struct connection_entry ce =3D o-&gt;ce;</span><br><span>@@ -3824,14 +38=
23,14 @@</span><br><span>     }</span><br><span> </span><br><span>     ASSE=
RT(o-&gt;connection_list);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    for (i =3D 0; i &lt; o-&gt;connection_list-&gt;len; ++i)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; =
o-&gt;connection_list-&gt;len; ++i)</span><br><span>     {</span><br><span>=
         options_postprocess_mutate_ce(o, o-&gt;connection_list-&gt;array[i=
]);</span><br><span>     }</span><br><span> </span><br><span>     if (o-&gt=
;ce=2Elocal_list)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        for (i =3D 0; i &lt; o-&gt;ce=2Elocal_list-&gt;l=
en; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for=
 (int i =3D 0; i &lt; o-&gt;ce=2Elocal_list-&gt;len; i++)</span><br><span> =
        {</span><br><span>             options_postprocess_mutate_le(&amp;o=
-&gt;ce, o-&gt;ce=2Elocal_list-&gt;array[i], o-&gt;mode);</span><br><span> =
        }</span><br><span>@@ -3859,7 +3858,7 @@</span><br><span>     }</spa=
n><br><span> </span><br><span>     /* use the same listen list for every ou=
tgoing connection */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   for (i =3D 0; i &lt; o-&gt;connection_list-&gt;len; ++i)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; o-&gt;=
connection_list-&gt;len; ++i)</span><br><span>     {</span><br><span>      =
   o-&gt;connection_list-&gt;array[i]-&gt;local_list =3D o-&gt;ce=2Elocal_l=
ist;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/ps=2Ec=
 b/src/openvpn/ps=2Ec</span><br><span>index c3f54ed=2E=2E57afacd 100644</sp=
an><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=
=2Ec</span><br><span>@@ -863,8 +863,8 @@</span><br><span>         set_cloex=
ec(fd[0]);</span><br><span> </span><br><span>         /* wait for backgroun=
d child process to initialize */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        int status =3D recv_control(fd[0]);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (status =3D=3D RESPONSE_INIT_SU=
CCEEDED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int=
 recv_status =3D recv_control(fd[0]);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (recv_status =3D=3D RESPONSE_INIT_SUCCEEDED)</=
span><br><span>         {</span><br><span>             /* note that this wi=
ll cause possible EAGAIN when writing to</span><br><span>              * co=
ntrol socket if proxy process is backlogged */</span><br><span>diff --git a=
/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>inde=
x 3ed72db=2E=2E47f5ac5 100644</span><br><span>--- a/src/openvpn/tls_crypt=
=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -77=
6,24 +776,24 @@</span><br><span>     }</span><br><span> </span><br><span>  =
   /* Sanity check: load client key (as &quot;client&quot;) */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct key_ctx_bi test_client_=
key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer=
 test_wrapped_client_key;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct key_ctx_bi check_client_key;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer check_wrapped_client_key;</span=
><br><span>     struct key2 keydata;</span><br><span>     msg(D_GENKEY, &qu=
ot;Testing client-side key loading=2E=2E=2E&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    tls_crypt_v2_init_client_key(&amp;test_=
client_key, &amp;keydata, &amp;test_wrapped_client_key, client_file,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_crypt_v2_init_clie=
nt_key(&amp;check_client_key, &amp;keydata, &amp;check_wrapped_client_key, =
client_file,</span><br><span>                                  client_inlin=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free_key_ctx_b=
i(&amp;test_client_key);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    free_key_ctx_bi(&amp;check_client_key);</span><br><span> </span><b=
r><span>     /* Sanity check: unwrap and load client key (as &quot;server&q=
uot;) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct bu=
ffer test_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &amp;gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct key2 test=
_client_key2 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer check_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_META=
DATA_LEN, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct key2 check_client_key2 =3D { 0 };</span><br><span>     free_key_=
ctx(&amp;server_key);</span><br><span>     tls_crypt_v2_init_server_key(&am=
p;server_key, false, server_key_file, server_key_inline);</span><br><span> =
    msg(D_GENKEY, &quot;Testing server-side key loading=2E=2E=2E&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(tls_crypt_v2_=
unwrap_client_key(&amp;test_client_key2, &amp;test_metadata,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                    =
      test_wrapped_client_key, &amp;server_key));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    secure_memzero(&amp;test_client_key2, sizeo=
f(test_client_key2));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    free_buf(&amp;test_wrapped_client_key);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ASSERT(tls_crypt_v2_unwrap_client_key(&amp;chec=
k_client_key2, &amp;check_metadata,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                          check_wrapped_cli=
ent_key, &amp;server_key));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    secure_memzero(&amp;check_client_key2, sizeof(check_client_key2=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&am=
p;check_wrapped_client_key);</span><br><span> </span><br><span> cleanup:</s=
pan><br><span>     secure_memzero(&amp;client_key, sizeof(client_key));</sp=
an><br><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv=
/interactive=2Ec</span><br><span>index 30cfb6a=2E=2E32c1b9c 100644</span><b=
r><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/ope=
nvpnserv/interactive=2Ec</span><br><span>@@ -541,19 +541,19 @@</span><br><s=
pan> static DWORD</span><br><span> InterfaceLuid(const char *iface_name, PN=
ET_LUID luid)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    NETIO_STATUS status;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    NETIO_STATUS convert_status;</span><br><span>     LPWST=
R wide_name =3D utf8to16(iface_name);</span><br><span> </span><br><span>   =
  if (wide_name)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        status =3D ConvertInterfaceAliasToLuid(wide_name,=
 luid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        conv=
ert_status =3D ConvertInterfaceAliasToLuid(wide_name, luid);</span><br><spa=
n>         free(wide_name);</span><br><span>     }</span><br><span>     els=
e</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        status =3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        convert_status =3D ERROR_OUTOFMEMORY;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn convert_status;</span><br><span> }</span><br><span> </span><br><span> st=
atic BOOL</span><br><span>@@ -1183,8 +1183,8 @@</span><br><span>         go=
to out;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    SERVICE_STATUS status;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (ControlService(dnssvc, SERVICE_CONT=
ROL_PARAMCHANGE, &amp;status) =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    SERVICE_STATUS control_status;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (ControlService(dnssvc, SERVICE_C=
ONTROL_PARAMCHANGE, &amp;control_status) =3D=3D 0)</span><br><span>     {</=
span><br><span>         MsgToEventLog(M_ERR, L&quot;%S: ControlService call=
 failed (%lu)&quot;, __func__, GetLastError());</span><br><span>         go=
to out;</span><br><span>@@ -3763,12 +3763,12 @@</span><br><span> static DWO=
RD WINAPI</span><br><span> ServiceCtrlInteractive(DWORD ctrl_code, DWORD ev=
ent, LPVOID data, LPVOID ctx)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    SERVICE_STATUS *status =3D ctx;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    SERVICE_STATUS *svc_status =
=3D ctx;</span><br><span>     switch (ctrl_code)</span><br><span>     {</sp=
an><br><span>         case SERVICE_CONTROL_STOP:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            status-&gt;dwCurrentState =3D SERVIC=
E_STOP_PENDING;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      ReportStatusToSCMgr(service, status);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            svc_status-&gt;dwCurrentState =3D SERVI=
CE_STOP_PENDING;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         ReportStatusToSCMgr(service, svc_status);</span><br><span>        =
     if (exit_event)</span><br><span>             {</span><br><span>       =
          SetEvent(exit_event);</span><br><span>diff --git a/tests/unit_tes=
ts/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec</span><br=
><span>index 150a3aa=2E=2E104fc9a 100644</span><br><span>--- a/tests/unit_t=
ests/openvpn/test_dhcp=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/t=
est_dhcp=2Ec</span><br><span>@@ -55,8 +55,8 @@</span><br><span> {</span><br=
><span>     struct gc_arena gc =3D gc_new();</span><br><span>     struct bu=
ffer out_buf =3D alloc_buf_gc(512, &amp;gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct buffer clear_buf =3D alloc_buf_gc(512, &a=
mp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_clear(=
&amp;clear_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct buffer clean_buf =3D alloc_buf_gc(512, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;clean_buf);</span><=
br><span>     bool error =3D false;</span><br><span> </span><br><span> #def=
ine LONGDOMAIN &quot;a-reaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaally-long-domain&quot;</span><br><span>@@ -79,7 +79,7 @@</s=
pan><br><span>     struct buffer small_buf =3D alloc_buf_gc(sizeof(output_1=
) - 1, &amp;gc);</span><br><span>     buf_clear(&amp;small_buf);</span><br>=
<span>     write_dhcp_search_str(&amp;small_buf, DHCP_DOMAIN_SEARCH, search=
_list, 2, &amp;error);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    assert_memory_equal(BPTR(&amp;small_buf), BPTR(&amp;clear_buf), buf_fo=
rward_capacity_total(&amp;small_buf));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;small_buf), BPTR(&amp;=
clean_buf), buf_forward_capacity_total(&amp;small_buf));</span><br><span>  =
   assert_true(error);</span><br><span>     error =3D false;</span><br><spa=
n> </span><br><span>@@ -103,13 +103,13 @@</span><br><span> </span><br><span=
>     buf_clear(&amp;out_buf);</span><br><span>     write_dhcp_search_str(&=
amp;out_buf, DHCP_DOMAIN_SEARCH, search_list + 5, 1, &amp;error);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(&a=
mp;out_buf), BPTR(&amp;clear_buf), buf_forward_capacity_total(&amp;clear_bu=
f));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memo=
ry_equal(BPTR(&amp;out_buf), BPTR(&amp;clean_buf), buf_forward_capacity_tot=
al(&amp;clean_buf));</span><br><span>     assert_true(error);</span><br><sp=
an>     error =3D false;</span><br><span> </span><br><span>     buf_clear(&=
amp;out_buf);</span><br><span>     write_dhcp_search_str(&amp;out_buf, DHCP=
_DOMAIN_SEARCH, search_list, 3, &amp;error);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(&amp;out_buf), BPTR(&am=
p;clear_buf), buf_forward_capacity_total(&amp;clear_buf));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;ou=
t_buf), BPTR(&amp;clean_buf), buf_forward_capacity_total(&amp;clean_buf));<=
/span><br><span>     assert_true(error);</span><br><span>     error =3D fal=
se;</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=
=2Ec</span><br><span>index 389fa09=2E=2E500dbe9 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>@@ -344,8 =
+344,8 @@</span><br><span> </span><br><span>     /* Message 1: first batch =
of routes, continuation 2 (more coming) */</span><br><span>     struct buff=
er buf1 =3D alloc_buf(512);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    const char *msg1 =3D &quot;PUSH_UPDATE, route 10=2E1=2E0=2E0 255=
=2E255=2E0=2E0, route 10=2E2=2E0=2E0 255=2E255=2E0=2E0, route 10=2E3=2E0=2E=
0 255=2E255=2E0=2E0,push-continuation 2&quot;;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    buf_write(&amp;buf1, msg1, strlen(msg1));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *cmsg1 =
=3D &quot;PUSH_UPDATE, route 10=2E1=2E0=2E0 255=2E255=2E0=2E0, route 10=2E2=
=2E0=2E0 255=2E255=2E0=2E0, route 10=2E3=2E0=2E0 255=2E255=2E0=2E0,push-con=
tinuation 2&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   buf_write(&amp;buf1, cmsg1, strlen(cmsg1));</span><br><span> </span><br>=
<span>     assert_int_equal(process_incoming_push_msg(c, &amp;buf1, c-&gt;o=
ptions=2Epull, pull_permission_mask(c),</span><br><span>                   =
                             &amp;option_types_found),</span><br><span>@@ -=
354,8 +354,8 @@</span><br><span> </span><br><span>     /* Message 2: more r=
outes, continuation 2 (more coming) */</span><br><span>     struct buffer b=
uf2 =3D alloc_buf(512);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const char *msg2 =3D &quot;PUSH_UPDATE, route 10=2E4=2E0=2E0 255=2E25=
5=2E0=2E0, route 10=2E5=2E0=2E0 255=2E255=2E0=2E0, route 10=2E6=2E0=2E0 255=
=2E255=2E0=2E0,push-continuation 2&quot;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    buf_write(&amp;buf2, msg2, strlen(msg2));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *cmsg2 =3D &qu=
ot;PUSH_UPDATE, route 10=2E4=2E0=2E0 255=2E255=2E0=2E0, route 10=2E5=2E0=2E=
0 255=2E255=2E0=2E0, route 10=2E6=2E0=2E0 255=2E255=2E0=2E0,push-continuati=
on 2&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_=
write(&amp;buf2, cmsg2, strlen(cmsg2));</span><br><span> </span><br><span> =
    assert_int_equal(process_incoming_push_msg(c, &amp;buf2, c-&gt;options=
=2Epull, pull_permission_mask(c),</span><br><span>                         =
                       &amp;option_types_found),</span><br><span>@@ -364,8 =
+364,8 @@</span><br><span> </span><br><span>     /* Message 3: final batch =
of routes, continuation 1 (last message) */</span><br><span>     struct buf=
fer buf3 =3D alloc_buf(512);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const char *msg3 =3D &quot;PUSH_UPDATE, route 10=2E7=2E0=2E0 255=
=2E255=2E0=2E0, route 10=2E8=2E0=2E0 255=2E255=2E0=2E0, route 10=2E9=2E0=2E=
0 255=2E255=2E0=2E0,push-continuation 1&quot;;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    buf_write(&amp;buf3, msg3, strlen(msg3));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *cmsg3 =
=3D &quot;PUSH_UPDATE, route 10=2E7=2E0=2E0 255=2E255=2E0=2E0, route 10=2E8=
=2E0=2E0 255=2E255=2E0=2E0, route 10=2E9=2E0=2E0 255=2E255=2E0=2E0,push-con=
tinuation 1&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   buf_write(&amp;buf3, cmsg3, strlen(cmsg3));</span><br><span> </span><br>=
<span>     assert_int_equal(process_incoming_push_msg(c, &amp;buf3, c-&gt;o=
ptions=2Epull, pull_permission_mask(c),</span><br><span>                   =
                             &amp;option_types_found),</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1618?usp=3Demail">change 1618</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1618?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915=
fa2e33 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1618 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--oeO5O6cfvIs=--


--===============5007488382604550415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5007488382604550415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5007488382604550415==--

