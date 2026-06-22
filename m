Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BE5CDB477
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=9qBnczYZwbEB8sn/A8ziK7L6j47N4zyD8HksAukmndE=; b=be9cOXlPlHXJ13
	FBt7yI66i3bjdYuIQdDUeYjycOX0JGVyTTucrLLaWLC+LrCM4YNYWqB7lS8CsxGzJwvt1/8jX6D5D
	5JXaVbhQexjW153hs51k0taJzVMD9OaSnlL7wZNVxikV2lKktynjsx0tbxkhGbHNzUbNRum1ub61M
	2/I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbed8-0001Z8-ED;
	Mon, 22 Jun 2026 13:23:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbed5-0001Yb-A2
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xS4HG1MiiA9oX1ckvXSdkn2GGkV73GaNb441FVzbpaQ=; b=JtjHfnknqhX9C+BSHCb4Q1t8pH
 0dfPFFXHUyAkx63R+Ixg33xwZMpEIRi2ZiFgWDKXK2qXsuC9+mNCV4HSJRoyzij1EJPnWQlcN3+4+
 +pmhEfxKdjZRkGAoTtedp/EStye57aTCABrTzqi3XvWjB+mYSIE+v/hH3DV5gLKghvVA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xS4HG1MiiA9oX1ckvXSdkn2GGkV73GaNb441FVzbpaQ=; b=i
 pPwrdXOrxAZAbusvp6sKjNSBBWOnAhsRVqeysvuvqjZEPV/geInNZqSlifQt4MxLkP5fZVPnyaF4a
 NkFeVfXfPyQmwkSg7zxdwzSqW6uBo+VVDX66Oi2NIg4xDT6eGtim8Acet5/+VvOIjigkbGixsAyIx
 wN7uZ2GsfSQylb9o=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbecy-0000b9-CL for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:56 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so46604745e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134621; x=1782739421; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xS4HG1MiiA9oX1ckvXSdkn2GGkV73GaNb441FVzbpaQ=;
 b=frtcUHEhbxhyjDc72wN8Nnsxnvyfp2wchPLecsUpD824TRk/mpPuE1JwUkiobEMKA7
 cC67aaYTDeiHDacw3mUvLuEDZNKmeQkYA37XVnLhlYupi+N2/fpz0CnGVwC4HYN6Qu/q
 jlEo4V3wzmA4W3uGlqlexgkGrc58/e2A1yiVvFfPLqtxJIAz4pa5bZI0daEAfBIZ8/pL
 bFhnRC2C0EwKIbdTYuRWo3c4LViAwg+ZM9zv2sqEXzfD7MR8MuuEmzr6MwLi7evPSbcp
 yzGLtgxUp/h/a87ybzftTcRYwg9PRfmwCjxpcdUNzuNfoSXwLvVrqY+yR3e4GipYcrzk
 qdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134621; x=1782739421;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xS4HG1MiiA9oX1ckvXSdkn2GGkV73GaNb441FVzbpaQ=;
 b=GTGWJB7ToaBTJNHUe5Cdxfu2GJH8EKsBAZpQ4GVyIQlVp0/u/JTVFDT3B9h2gDE9Lw
 bDENBIXqijIcawPXR5roPmhi4B4UkyyB2UaqfdCXfizDWeGlmeZznnVvmj5XCkpD+Mfj
 dDDCNflfUPv08ub4CPMIW4QBq9gJvtsqWwjflCA86DdZzKbQRGK0Ba05W1yJHLIUgif5
 VdoFVj65Z49DeEAWBlB9N826TxncfHGIQ7r2JPM6mp9Gts8XT1y52L0eie+54QPya4z+
 MhRZKU2lfWo6fxSHjJADsSUgW5BAZXIWJ+KEOfVA1bg41oFIYiyt6zC1IYCBw/AwSBCP
 ulnw==
X-Gm-Message-State: AOJu0YzPx4zgD6zj2m84dh2QUxAYUGV3CU9c+aJrDajJ4ux1bST9MNjb
 bJxhZTsO4UdpgCYDrxJgoe5cQ5iQDTcmSPgQI9vRaqnt1lU1jYPnnsuEiqK/gr+L+c0Kwl6J0gT
 rGkpxDZsuNoDwZFMz4bEMEEz9OVIdMdeCJAIOjVPOH/lhbttvWplF2bOByOO+Fy6yVjScFmTzJ9
 qoNkYFJQ==
X-Gm-Gg: AfdE7ckEwdRNn++jz8rrTwrHRHRrZqE/CPQ3p6xMpkQGqXeqTHvTyd+6sMqUZOagdb1
 scyisZj6wd4qGNqFICGzrCsWMX68x0qE/f9HwTiRr1AeKKAQECSl5oQw9eSvDgirGlHlEm6qkBP
 m9YzlSR+skVYxmU9lP99ds62r4wosFa4UT58SBBKz/M5VBVUx5C4ZICvdSIgYXayZiKJ+VrHU49
 xWAUGWinArVAZE35aTgcct5IOcoDEze8Q4v2zExlljIrZT+FFsi+Bnj9qZFUZZD6S//ILJBLI3s
 zVUVzT3BUJflqoagJZ6OlzfMdnXvu4VN6ZcYIwGUhj8NUh5dRIn0Ig5Ni+3DxfpyvsWkZvymRK5
 n73B92oDgz15eHZQqXNQ897HmYoyzadLH/VzSedCaLVFI80rz0Tbh1jijWQkSQPuc0I6vcuHxkh
 tqtMgQ1m7WWSx6De9jPFxE3AZ7xEF0jyJOWKt1qhrBunDwz7wW/FvuCOs3CjjIycUnPe2ve3tKt
 uMvfmMD9BI8r/U/WlbXxr6Bp1k7Uw3nn7thGuuZHy1mAlCftWyp26IX3OfBRBoLdoO1fJTfWGR2
 pMqJCe3U1oVTYw==
X-Received: by 2002:a05:600c:3b10:b0:490:44eb:c1dd with SMTP id
 5b1f17b1804b1-4924257c817mr210743465e9.29.1782134620112; 
 Mon, 22 Jun 2026 06:23:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c579dfsm25988524f8f.31.2026.06.22.06.23.39
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:23:39 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:23:39 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: 3781532897d6feea9b358f5d080706164878e175
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <725fc7484b9de8d0299401c4a4620e5e1415bde6-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbecy-0000b9-CL
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 multi_get_instance_real_udp_real method
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
Content-Type: multipart/mixed; boundary="===============0687318810686519716=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0687318810686519716==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KIoRReX3css="; charset=UTF-8

--KIoRReX3css=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1725?usp=3Demail )


Change subject: Extract multi_get_i=
nstance_real_udp_real method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Extract multi_get_instance_real_udp_real method

This is j=
ust a small refactoring to make the code a little bit
better organised=2E

=
Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
Signed-off-by: Arne Sc=
hwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/mudp=2Ec
M src/openvpn/multi=
=2Ec
2 files changed, 25 insertions(+), 9 deletions(-)



  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/25/1725/1

diff --git a/s=
rc/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index a91d11b=2E=2Ee8d8128 10064=
4
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -198,7 +198,6 @@=

 handle_connection_attempt(struct multi_context *m,
                      =
     struct link_socket *sock,
                           struct mroute_add=
r *real,
-                          const uint64_t hv,
                    =
       struct hash_bucket *bucket)
 {
     struct hash *hash =3D m->hash;
@=
@ -229,6 +228,7 @@
             mi =3D multi_create_instance(m, real, sock)=
;
             if (mi)
             {
+                const uint64_t hv =
=3D hash_value(hash, real);
                 hash_add_fast(hash, bucket, &m=
i->real, hv, mi);
                 mi->did_real_hash =3D true;
            =
     multi_assign_peer_id(m, mi);
@@ -258,6 +258,28 @@
 }
 
 /**
+ * Looks =
up an multi instance by its real address (IP and port)
+ * @param m     mul=
ti context
+ * @param real  Address to look up
+ * @return      instance ma=
tching the NULL otherwise
+ */
+struct multi_instance *
+multi_get_instance=
_real_udp_real(struct multi_context *m, struct mroute_addr *real)
+{
+    s=
truct hash *hash =3D m->hash;
+    struct hash_element *he;
+    const uint=
64_t hv =3D hash_value(hash, real);
+    struct hash_bucket *bucket =3D has=
h_bucket(hash, hv);
+    he =3D hash_lookup_fast(hash, bucket, real, hv);
+=
    if (he)
+    {
+        return he->value;
+    }
+    return NULL;
+}
+=

+
+/**
  * Get a client instance based on real address=2E  If
  * the inst=
ance doesn't exist, create it while
  * maintaining real address hash table=
 atomicity=2E
@@ -273,7 +295,6 @@
 
     if (mroute_extract_openvpn_sockadd=
r(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
=
     {
-        struct hash_element *he;
         const uint64_t hv =3D has=
h_value(hash, &real);
         struct hash_bucket *bucket =3D hash_bucket(h=
ash, hv);
         uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
@@ -310,17 +3=
31,13 @@
         }
         if (!v2 || peer_id_disabled)
         {
-     =
       he =3D hash_lookup_fast(hash, bucket, &real, hv);
-            if (h=
e)
-            {
-                mi =3D (struct multi_instance *)he->valu=
e;
-            }
+            mi =3D multi_get_instance_real_udp_real(m, &=
real);
         }
 
         /* we have no existing multi instance for this=
 connection */
         if (!mi)
         {
-            mi =3D handle_conn=
ection_attempt(m, sock, &real, hv, bucket);
+            mi =3D handle_conn=
ection_attempt(m, sock, &real, bucket);
         }
 
 #ifdef ENABLE_DEBUG
d=
iff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 8a8d742=2E=
=2Eddb98c9 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@=
@ -3108,7 +3108,6 @@
 multi_check_dest_addr_allowed(struct multi_context *m=
, struct multi_instance *mi, struct mroute_addr *real)
 {
     struct hash =
*hash =3D m->hash;
-    struct gc_arena gc =3D gc_new();
 
     const uint6=
4_t hv =3D hash_value(hash, real);
     struct hash_bucket *bucket =3D hash=
_bucket(hash, hv);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1725?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
Gerrit-Change-Number: 1725
Gerrit=
-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--KIoRReX3css=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Extract multi_get_instance_real_udp_real method<br><br>This is jus=
t a small refactoring to make the code a little bit<br>better organised=2E<=
br><br>Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39<br>Signed-off-b=
y: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/mudp=2Ec=
<br>M src/openvpn/multi=2Ec<br>2 files changed, 25 insertions(+), 9 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/25/1725/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec =
b/src/openvpn/mudp=2Ec</span><br><span>index a91d11b=2E=2Ee8d8128 100644</s=
pan><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/=
mudp=2Ec</span><br><span>@@ -198,7 +198,6 @@</span><br><span> handle_connec=
tion_attempt(struct multi_context *m,</span><br><span>                     =
      struct link_socket *sock,</span><br><span>                           =
struct mroute_addr *real,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                          const uint64_t hv,</span><br><span>          =
                 struct hash_bucket *bucket)</span><br><span> {</span><br><=
span>     struct hash *hash =3D m-&gt;hash;</span><br><span>@@ -229,6 +228,=
7 @@</span><br><span>             mi =3D multi_create_instance(m, real, soc=
k);</span><br><span>             if (mi)</span><br><span>             {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                const u=
int64_t hv =3D hash_value(hash, real);</span><br><span>                 has=
h_add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span>       =
          mi-&gt;did_real_hash =3D true;</span><br><span>                 m=
ulti_assign_peer_id(m, mi);</span><br><span>@@ -258,6 +258,28 @@</span><br>=
<span> }</span><br><span> </span><br><span> /**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Looks up an multi instance by its real addre=
ss (IP and port)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param m     multi context</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param real  Address to look up</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @return      instance matching the NULL otherwise<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+struct multi_instance *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_real_udp_real=
(struct multi_context *m, struct mroute_addr *real)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct hash *hash =3D m-&gt;hash;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_v=
alue(hash, real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    he =3D hash_lookup_fast(hash, bucke=
t, real, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (he)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return he-&gt;value;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an>  * Get a client instance based on real address=2E  If</span><br><span> =
 * the instance doesn&#39;t exist, create it while</span><br><span>  * main=
taining real address hash table atomicity=2E</span><br><span>@@ -273,7 +295=
,6 @@</span><br><span> </span><br><span>     if (mroute_extract_openvpn_soc=
kaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;=
top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct hash_element *he;</span><br>=
<span>         const uint64_t hv =3D hash_value(hash, &amp;real);</span><br=
><span>         struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span=
><br><span>         uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span=
><br><span>@@ -310,17 +331,13 @@</span><br><span>         }</span><br><span=
>         if (!v2 || peer_id_disabled)</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            he =3D hash_lookup_=
fast(hash, bucket, &amp;real, hv);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            if (he)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                mi =3D (struct multi_instance *)he-&gt;value;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            mi =3D multi_get_instance_=
real_udp_real(m, &amp;real);</span><br><span>         }</span><br><span> </=
span><br><span>         /* we have no existing multi instance for this conn=
ection */</span><br><span>         if (!mi)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            mi =3D handle_=
connection_attempt(m, sock, &amp;real, hv, bucket);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            mi =3D handle_connection_atte=
mpt(m, sock, &amp;real, bucket);</span><br><span>         }</span><br><span=
> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span>diff --git a/src/op=
envpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 8a8d742=2E=2E=
ddb98c9 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>=
+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -3108,7 +3108,6 @@</span><br=
><span> multi_check_dest_addr_allowed(struct multi_context *m, struct multi=
_instance *mi, struct mroute_addr *real)</span><br><span> {</span><br><span=
>     struct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span> </s=
pan><br><span>     const uint64_t hv =3D hash_value(hash, real);</span><br>=
<span>     struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1725?usp=3Demail">change 1725</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde3=
5c4ad42e20d39 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 172=
5 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--KIoRReX3css=--


--===============0687318810686519716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0687318810686519716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0687318810686519716==--

