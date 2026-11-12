Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DE1606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jASc6xEL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Y/l/7K8j;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O3JPzS7D;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IiMUIlKJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=34AVdh9ynFayLpYTA+cqIKsGtiTpY1YysnUz4vK+dTM=; b=jASc6xELdt5LmpsFqQZFrfQpC9
	qnSZ9Xk6Ea8ucrcY++2qCdTcOuV2Aoxw4V9TXVkMVpmayip/bz079+PxIIN92Hpnk1dhqotCWpn6L
	UtktBbn7O+znKSfYQMgqzskgykx8y/Fgz8u4JknNilLP4/eR/Qpc/9wPYIdEsuC8kRCw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRUck-000000008Jk-0h51;
	Thu, 12 Nov 2026 13:13:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRUcj-000000008Je-2vUu
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 13:13:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WZpItqiUa2PPrSMFIKIr6Rx1T3l1AMWXwORrYhH4ug4=; b=Y/l/7K8jALeDwzvYUU6Y8FGXCt
 mwkrcn8zJgFK7RCgU5lF6ig/6UBYCMH8+OLRSn0gGeglTAualVE6U2bdZGMybIhfj4R5YKMyOuCwX
 RDWGC9prhMqiBpUyUt6KSBIls6G2LfLTbw5WP5CAZIQivovLnOmB5LlIErlfjllc4uKo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WZpItqiUa2PPrSMFIKIr6Rx1T3l1AMWXwORrYhH4ug4=; b=O3JPzS7DGJQ/tRAgLPZq6XRCaR
 A5KL47cMuV6JrRHXNk3YkUGBE4Rp5PoEtMyduO7smB6ybJCfu6x0mM7jrlIJBDUmywcrGspfWtjVQ
 IN0qItR9wnnPh/F43vstC2PbsSbzc9c7ZI5TpXbOClPxYEHrkhXH8TKVxC88Rxj9axpo=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRUcg-000000001Bi-1t1E for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 13:13:53 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so5439365e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 05:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794489224; x=1795094024; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WZpItqiUa2PPrSMFIKIr6Rx1T3l1AMWXwORrYhH4ug4=;
 b=IiMUIlKJkMR6FYDVKF5woov3Utd9K/ZK38PEiOnyRlpOEC+MN9mNjwYcHen9z8TIo2
 h37evulFecyJMQjPSRGyYarX2yfXelY+T0EVfYrnpgeG16dHg90CJCkyuWtOh6S/dQyo
 wGF51De20kdWDb1liVZkiZS3fZ+R0mAGRP0CYqP/mVxWQsSbDAd4nhPZ+5zJ5Hg9Xu7u
 CJbTsMkiQ/mKBD+quLHorgvpAtUyBtdQD1CtkVFHaV/3eu7kHCFtJ0U7wMbYHetPgOOa
 Afzthx0rwhY0N47csRXwFPOn53JFrKOlAcWCotpOO8v0gvaQ1Bx/cloob2q0R+Pa5SMT
 oulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794489224; x=1795094024;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WZpItqiUa2PPrSMFIKIr6Rx1T3l1AMWXwORrYhH4ug4=;
 b=qMi4XOyp921TcoPf6Zi74F793n1/0k0Jody06VsLvyuVpV9IDBftrLHsQdfkJdolGX
 PYWoO7nCqKp0gn2qwNqgZ7bGOXwjP9NkmzzaxqnfutW+wS4uwlaFnJ2o3s+E1bj6BqO1
 KZLZlyEfNn2+xolBQ6H4aVqMhFAt/NjK+XWM4TlhQGgwCQsuLPff4HQhMgumCzyrOBws
 BDeWpcWileaBJwE8YgmQBuSQKxrZovd4U/YqsGWLMiSnoYEOMJjbKxwDu0MjnYz0VQAl
 yMIpqWilB8r7DEfsjpUD4QDqTBu466/j64d6pa4B9CgLZXWkLdvOkm885/Xu4Hlm8Fmg
 CkvA==
X-Gm-Message-State: APuU4Z9eJuj+xPqHttzq/mtJiYbIiDLiAZtDyqoAs1HfrwmC1jjq7w+b
 Je3rPwdAWBcdsM8HX5hDZKIVS5q+SoX9fPS0fRZ8wRX15RCUwbRrbSmN3fr1CAgO/qIFTtyXVZU
 u/Rjt0/zJNEp85ZCAkjuQwbXvQR2rf04eMv3jzoz6bQm4W6D1xU+MFIa9RvDUS3EAZWWRVzja4L
 KKiR/15g==
X-Gm-Gg: AYBFou39TZE2VFUxV6qbuUQgUztERHP2bjSn/YQjyuGCh1i14tSrDqYH+ATlQQn4Fij
 ZZ226CpcwDOupkxjrVa20dbY4UNQnZdDxoRXyPGqYu3Tfszu7M04GtD46RMNdMkynpgtNCAkVAt
 fL/R/0P/LKd2hGwDSQEgnYWKUj3Nj2wMHMn1x6/FttjaqNro0prQ9a+CjbhQPhH82H0bIH2URl4
 XcIfFvO4tqSBT9U1j2BrC9hsTeRbHBf5d9aiykisWqX1caQ9zfLUB/qpuWdjCNBHLl3z6BsmiG5
 EL/hfwUMoQ8YSvryqj6JtUnsj1Lzj3toER5Xde+H0fttchIAmHdMUE+pQR86Pz5C2Tw4oVJEhrt
 nPde65clYxhCtSszhYcm8aB46Vbf8ZQkcHk0SmDAexfO3l8K7zXrsfK5q7yI2OtNuZKlJx+q/xW
 bg3LexLZ5SIR6zwYulmLYHe60D5/k8JJg6CnO0as8nPKajoFrl0mjGwyqrc54s+cXrk/+TqmLUy
 N96eCvaCBRSfwPjkyVLV0kKFenUKS6PYgyYPhMg/6slj1agMgcTYnV6B3p5bXSTAPTuvydDlWQ+
 6xqmxhnPSBlpOlNqtRZ0B868SQQTszLeL4OiT5Tpg13Opsfa2vm4agerAygdOtzrUGdTBYPat9D
 n0NTpmndUB8RQ0l6QDjql7yTadEHNSLWy5uxJs1qBVZ+d0IbWVBFQ64LIN5NlnaWemKEPiRd0xv
 jvR2s2ikjVckXecFM=
X-Received: by 2002:a05:600c:4eca:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4bb4e28456amr55711305e9.10.1794489223654; 
 Thu, 12 Nov 2026 05:13:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0951bf2asm95835965e9.4.2026.11.12.05.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 05:13:43 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 13:13:42 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4b07dbc6ad1f29021e1be4766500f4d291bbadc6
X-Gerrit-Change-Number: 2180
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2180?usp=email>
X-Gerrit-Commit: 2644429c1ca4e78954b492ce114519fd94cc887c
References: <gerrit.1794489219000.I4b07dbc6ad1f29021e1be4766500f4d291bbadc6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDg5MjE5MDAwLkk0YjA3ZGJjNmFkMWYyOTAyMWUxYmU0NzY2NTAwZjRkMjkxYmJhZGM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dcd76d3d05e96f8c982b626642ab41b1950475e2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRUcg-000000001Bi-1t1E
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Free address lists
 by DNS cache ownership, not --preresolve
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6245310575701161242=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6245310575701161242==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g1RLm5rSta8="; charset=UTF-8

--g1RLm5rSta8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2180?usp=3Demail

to review the following change=2E
=


Change subject: Free address lists by DNS cache ownership, not --preresol=
ve
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Free addre=
ss lists by DNS cache ownership, not --preresolve

With --preresolve, remot=
e_list and bind_local were never freed on the
assumption that they came fro=
m the DNS cache, which is freed with the
context gc=2E Lookups that miss th=
e cache leaked a getaddrinfo() list on
every restart=2E Meanwhile phase2_so=
cks_client() freed remote_list
unconditionally, a double free once the cach=
e hits=2E

Free a list unless the cache owns it=2E

Change-Id: I4b07dbc6ad1=
f29021e1be4766500f4d291bbadc6
Signed-off-by: Razvan Cojocaru <razvanc@mailb=
ox=2Eorg>
---
M src/openvpn/init=2Ec
M src/openvpn/resolve=2Ec
M src/openvp=
n/resolve=2Eh
M src/openvpn/socket=2Ec
4 files changed, 29 insertions(+), 7=
 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/80/2180/1

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2E=
c
index 3bc4de4=2E=2Ed40959e 100644
--- a/src/openvpn/init=2Ec
+++ b/src/op=
envpn/init=2Ec
@@ -495,9 +495,9 @@
  * Clear the remote address list
  */
 =
static void
-clear_remote_addrlist(struct link_socket_addr *lsa, bool free)=

+clear_remote_addrlist(struct link_socket_addr *lsa, const struct cached_d=
ns_entry *dns_cache)
 {
-    if (lsa->remote_list && free)
+    if (lsa->re=
mote_list && !dns_cache_owns(dns_cache, lsa->remote_list))
     {
         =
freeaddrinfo(lsa->remote_list);
     }
@@ -550,8 +550,7 @@
                =
      */
                     if (c->c1=2Elink_socket_addrs[0]=2Eremote_lis=
t)
                     {
-                        clear_remote_addrlist(&c=
->c1=2Elink_socket_addrs[0],
-                                             =
 !c->options=2Eresolve_in_advance);
+                        clear_remote_a=
ddrlist(&c->c1=2Elink_socket_addrs[0], c->c1=2Edns_cache);
                =
     }
 
                     /* close_instance should have cleared the add=
rinfo objects */
@@ -4011,7 +4010,7 @@
                        && c->c1=2El=
ink_socket_addrs[0]=2Ecurrent_remote->ai_next)
                       || c-=
>options=2Eno_advance)))))
     {
-        clear_remote_addrlist(&c->c1=2El=
ink_socket_addrs[0], !c->options=2Eresolve_in_advance);
+        clear_remo=
te_addrlist(&c->c1=2Elink_socket_addrs[0], c->c1=2Edns_cache);
     }
 
   =
  /* Clear the remote actual address when persist_remote_ip is not in use *=
/
@@ -4027,7 +4026,8 @@
     {
         for (int i =3D 0; i < c->c1=2Elink_=
sockets_num; i++)
         {
-            if (c->c1=2Elink_socket_addrs[i]=
=2Ebind_local && !c->options=2Eresolve_in_advance)
+            if (c->c1=
=2Elink_socket_addrs[i]=2Ebind_local
+                && !dns_cache_owns(c-=
>c1=2Edns_cache, c->c1=2Elink_socket_addrs[i]=2Ebind_local))
             {=

                 freeaddrinfo(c->c1=2Elink_socket_addrs[i]=2Ebind_local);
=
             }
diff --git a/src/openvpn/resolve=2Ec b/src/openvpn/resolve=
=2Ec
index b8d9899=2E=2E46a7f7b 100644
--- a/src/openvpn/resolve=2Ec
+++ b/=
src/openvpn/resolve=2Ec
@@ -524,6 +524,19 @@
     return -1;
 }
 
+bool
+dn=
s_cache_owns(const struct cached_dns_entry *dns_cache, const struct addrinf=
o *ai)
+{
+    for (const struct cached_dns_entry *ph =3D dns_cache; ph; ph=
 =3D ph->next)
+    {
+        if (ph->ai =3D=3D ai)
+        {
+          =
  return true;
+        }
+    }
+    return false;
+}
+
 
 static int
 do_=
preresolve_host(struct context *c, const char *hostname, const char *servna=
me, const int af,
diff --git a/src/openvpn/resolve=2Eh b/src/openvpn/resolv=
e=2Eh
index 9069af7=2E=2E30b1a7e 100644
--- a/src/openvpn/resolve=2Eh
+++ b=
/src/openvpn/resolve=2Eh
@@ -103,4 +103,10 @@
                          con=
st char *servname, int ai_family,
                          unsigned int re=
solve_flags, struct addrinfo **ai);
 
+/**
+ * Returns true if \c ai is a c=
ached entry=2E Those are freed with the
+ * context gc, never with freeaddr=
info()=2E
+ */
+bool dns_cache_owns(const struct cached_dns_entry *dns_cach=
e, const struct addrinfo *ai);
+
 #endif /* RESOLVE_H */
diff --git a/src/o=
penvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 1fbd07b=2E=2Ed7670ae 10064=
4
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -1266,7 +126=
6,10 @@
     addr_zero_host(&sock->info=2Elsa->actual=2Edest);
     if (soc=
k->info=2Elsa->remote_list)
     {
-        freeaddrinfo(sock->info=2Elsa->=
remote_list);
+        if (!dns_cache_owns(sock->dns_cache, sock->info=2Els=
a->remote_list))
+        {
+            freeaddrinfo(sock->info=2Elsa->rem=
ote_list);
+        }
         sock->info=2Elsa->current_remote =3D NULL;
 =
        sock->info=2Elsa->remote_list =3D NULL;
     }

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2180?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I4b07dbc6ad1f29021e1be4766500f4d291bb=
adc6
Gerrit-Change-Number: 2180
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--g1RLm5rSta8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2180?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">Free address lists by DNS cache ownership, not --preres=
olve<br><br>With --preresolve, remote_list and bind_local were never freed =
on the<br>assumption that they came from the DNS cache, which is freed with=
 the<br>context gc=2E Lookups that miss the cache leaked a getaddrinfo() li=
st on<br>every restart=2E Meanwhile phase2_socks_client() freed remote_list=
<br>unconditionally, a double free once the cache hits=2E<br><br>Free a lis=
t unless the cache owns it=2E<br><br>Change-Id: I4b07dbc6ad1f29021e1be47665=
00f4d291bbadc6<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/resolve=2Ec<br>M src/=
openvpn/resolve=2Eh<br>M src/openvpn/socket=2Ec<br>4 files changed, 29 inse=
rtions(+), 7 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/80/2180/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 3bc4de4=
=2E=2Ed40959e 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><=
span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -495,9 +495,9 @@</span><=
br><span>  * Clear the remote address list</span><br><span>  */</span><br><=
span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-clea=
r_remote_addrlist(struct link_socket_addr *lsa, bool free)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+clear_remote_addrlist(struct link_so=
cket_addr *lsa, const struct cached_dns_entry *dns_cache)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (lsa-&gt;remo=
te_list &amp;&amp; free)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (lsa-&gt;remote_list &amp;&amp; !dns_cache_owns(dns_cache, lsa-=
&gt;remote_list))</span><br><span>     {</span><br><span>         freeaddri=
nfo(lsa-&gt;remote_list);</span><br><span>     }</span><br><span>@@ -550,8 =
+550,7 @@</span><br><span>                      */</span><br><span>        =
             if (c-&gt;c1=2Elink_socket_addrs[0]=2Eremote_list)</span><br><=
span>                     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                        clear_remote_addrlist(&amp;c-&gt;c1=2Elink_so=
cket_addrs[0],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                                       !c-&gt;options=2Eresolve_in_advance)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      clear_remote_addrlist(&amp;c-&gt;c1=2Elink_socket_addrs[0], c-&gt;c1=
=2Edns_cache);</span><br><span>                     }</span><br><span> </sp=
an><br><span>                     /* close_instance should have cleared the=
 addrinfo objects */</span><br><span>@@ -4011,7 +4010,7 @@</span><br><span>=
                        &amp;&amp; c-&gt;c1=2Elink_socket_addrs[0]=2Ecurren=
t_remote-&gt;ai_next)</span><br><span>                       || c-&gt;optio=
ns=2Eno_advance)))))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        clear_remote_addrlist(&amp;c-&gt;c1=2Elink_so=
cket_addrs[0], !c-&gt;options=2Eresolve_in_advance);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        clear_remote_addrlist(&amp;c-&gt;=
c1=2Elink_socket_addrs[0], c-&gt;c1=2Edns_cache);</span><br><span>     }</s=
pan><br><span> </span><br><span>     /* Clear the remote actual address whe=
n persist_remote_ip is not in use */</span><br><span>@@ -4027,7 +4026,8 @@<=
/span><br><span>     {</span><br><span>         for (int i =3D 0; i &lt; c-=
&gt;c1=2Elink_sockets_num; i++)</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (c-&gt;c1=2Elink_socket=
_addrs[i]=2Ebind_local &amp;&amp; !c-&gt;options=2Eresolve_in_advance)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (c-&gt;c1=
=2Elink_socket_addrs[i]=2Ebind_local</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                &amp;&amp; !dns_cache_owns(c-&gt;c1=2Edns_=
cache, c-&gt;c1=2Elink_socket_addrs[i]=2Ebind_local))</span><br><span>     =
        {</span><br><span>                 freeaddrinfo(c-&gt;c1=2Elink_soc=
ket_addrs[i]=2Ebind_local);</span><br><span>             }</span><br><span>=
diff --git a/src/openvpn/resolve=2Ec b/src/openvpn/resolve=2Ec</span><br><s=
pan>index b8d9899=2E=2E46a7f7b 100644</span><br><span>--- a/src/openvpn/res=
olve=2Ec</span><br><span>+++ b/src/openvpn/resolve=2Ec</span><br><span>@@ -=
524,6 +524,19 @@</span><br><span>     return -1;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_cache_owns(const str=
uct cached_dns_entry *dns_cache, const struct addrinfo *ai)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (const struct cached_dns_entry *ph =3D dns_ca=
che; ph; ph =3D ph-&gt;next)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (ph-&gt;ai =3D=3D ai)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> stati=
c int</span><br><span> do_preresolve_host(struct context *c, const char *ho=
stname, const char *servname, const int af,</span><br><span>diff --git a/sr=
c/openvpn/resolve=2Eh b/src/openvpn/resolve=2Eh</span><br><span>index 9069a=
f7=2E=2E30b1a7e 100644</span><br><span>--- a/src/openvpn/resolve=2Eh</span>=
<br><span>+++ b/src/openvpn/resolve=2Eh</span><br><span>@@ -103,4 +103,10 @=
@</span><br><span>                          const char *servname, int ai_fa=
mily,</span><br><span>                          unsigned int resolve_flags,=
 struct addrinfo **ai);</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Returns true if \c ai is a cached entry=2E Those are freed with th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * context gc, nev=
er with freeaddrinfo()=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool dns_c=
ache_owns(const struct cached_dns_entry *dns_cache, const struct addrinfo *=
ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> #endif /* RESOLVE_H */</span><br><span>diff --git a/src/openvpn/socket=
=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 1fbd07b=2E=2Ed7670ae 10=
0644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src=
/openvpn/socket=2Ec</span><br><span>@@ -1266,7 +1266,10 @@</span><br><span>=
     addr_zero_host(&amp;sock-&gt;info=2Elsa-&gt;actual=2Edest);</span><br>=
<span>     if (sock-&gt;info=2Elsa-&gt;remote_list)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        freeaddrinfo(s=
ock-&gt;info=2Elsa-&gt;remote_list);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (!dns_cache_owns(sock-&gt;dns_cache, sock-&gt;i=
nfo=2Elsa-&gt;remote_list))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          freeaddrinfo(sock-&gt;info=2Elsa-&gt;remote_list);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>        =
 sock-&gt;info=2Elsa-&gt;current_remote =3D NULL;</span><br><span>         =
sock-&gt;info=2Elsa-&gt;remote_list =3D NULL;</span><br><span>     }</span>=
<br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2180?usp=3Demail">change 2180</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2180?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I4b07dbc6ad1f29021e1be4766500f4d291bb=
adc6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2180 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--g1RLm5rSta8=--


--===============6245310575701161242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6245310575701161242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6245310575701161242==--

