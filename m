Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722EEC531F7
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NygxjDkTm4wjR+1UIgtLsdyYghzgHKoUYag7qJbGflI=; b=dl/e70B0XUH/ztj3/c1lHQcf1s
	lYM1x2G1agNC0/0zzwmGGniomEduCXkYz7Ss2jWUYp4BDzVJ/H3R3c7q22A/DGGirc+c/WW/Z6oJn
	bAncxwMERp8KFN/YbCLcwEaS+NJodQymZ/kfRVxW7JehfyvuiwnOeRfF5XAYaRoNljRk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmw1i-0007rE-VF;
	Thu, 23 Jul 2026 16:12:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmw1a-0007qp-12
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 16:11:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sZu+4xaqbdp8lf1CmkJ2PlqTwMncTL1F3sowTzZYo3w=; b=NnuU4ErqtH+AYV1BDts6JF8Nnr
 uBAlZj9MpJdXripIpPjB3oRz5GCNv5/PeGTy9crWahCqji5ewRdUSTL4raLMiwX/VZRLpAzZsXdjc
 ndA/0wSdze7LG9Pi9wNuqcow7pp7ASzOqgAyu9xUM5+JQ2rblxVLlLODvqnLXA64zg00=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sZu+4xaqbdp8lf1CmkJ2PlqTwMncTL1F3sowTzZYo3w=; b=C
 zLR4epMGeDyPpvcH0yWW9F7+LxB9wnHxLEi+Bghu54VpFO4xHaedkHLgols1WFsmpoTVrMtZKB9iO
 GkxL3Nc7BmG2gjWr5U8hZT87wMqn5oCGcTjrZCb1CZdET3RTyMK7SEaJCMlvia+Hul0DW+5eLb/VP
 PSmDX9V3iGySNsPI=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmw1c-00080L-Ky for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 16:11:54 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso8923965e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784823106; x=1785427906; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sZu+4xaqbdp8lf1CmkJ2PlqTwMncTL1F3sowTzZYo3w=;
 b=TclfwGP34dwSEHkux8dvhbU+QNJ4dJfwNEgnTLbXi8VE4FtHhOEcFGv2Z+mxbpdrdB
 C+FANhv7zfwQkQdt74WqSBccokaM8KL69cWyV8k1s0RMzvhbJFn9/FC/ac0OVo+UaIx+
 vfwHQQhli1Mg6+64SNRoZqD+HF4Gbdyfa7fczXPKhcdMPojUk47H9rIfXyyV9ocFQZCy
 vH5kE7yhlWrjT5IBPwXiGj3Jt7ZUXjpH+pw27zG56CiNktrdnqR55iyF6JbrqOhlflCP
 c2J1jCmpt3roT7Dq6XkURPG5Czrwh8CiG+jZ+fj6G8Mjuo6DJnT5WUewsF3XoQeYjtcC
 QHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784823106; x=1785427906;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sZu+4xaqbdp8lf1CmkJ2PlqTwMncTL1F3sowTzZYo3w=;
 b=T9SUKGikFo/gvhh2Tw7sBbqq9Vlox93Z8nHjRK8ratAveQleoNwAe04qRi1yW8o0P3
 RUrPJZQGjJhpwyGh4F8OOyY+2H8vmjfCoZXsjfmNEDgnUB6oKNdLTH/uucBQl26ZEriG
 IZji/Bph5jFDKRwLudc/xDFmYHVUICtKuLLRs/g20sombUt8HD/dVPSRq+E019+VrV5b
 LNfsCaVHYty1Lr7xyPlBA9APxgItrxWTEdAA2j+5bNyAqCgG/fl6Ntj/rjDE1vd8t1VZ
 4tU62PRT441ZCmDObEd9XmZkMRKUS2Z2V0lTLHZ28F4b6j0jEupYwGs6Hukh19TUy4MH
 qLRQ==
X-Gm-Message-State: AOJu0Yz5fB7TJOdSG70l7Xn3lFoYqT5Y+bK1Zjrh90fBgSCoZ5MA52XF
 xMoE73FRXt2C2g9a5GNn1T4FQJeZcUzBqx6i6iWoQqcvfm5TKSpJBDXgZ1vM8zf0DslfhSbxgxT
 KG65ko65wtMU8LBxbf71R6Sn5DzTbZ//BP16dpelsA68Gz0oQvIeqZCL253xJtox5tHMwqJz+xV
 +ayETfSQ==
X-Gm-Gg: AR+sD102/rnflL3FEzznScA5oyzd1Irw7KLmZ6HGllf9FEsqbUxvy42TBC0SRp/UQhj
 Qfa0+4PZRn/5GFqfPlowRvMYbjdyv3ekpwSMsQ/+4oIkDyRkedmJWcO4lzHFdrj72SMUkBy840p
 exafbfg9yjJHiAYNBvY7cFiD1QzW2O6wvsuBlOG82tiRjxxRUludXifJi7ZiI6cfhmYjJTeRjkU
 z+o8V16MttPLMl3HUS/+dV9uOrUTyiPGE5I8eFg95FwuLwkJo4WdLmUIIK2c4jz/bTEmqLdpgJC
 CNvo7yTC59dyE2qH24nUtumJRC6u/qS/UZcP+lKoorffEqYUcg6dfV5MCVQTg8BJGTiW5bTquSR
 TaflJOMR2/LnYN2Wdeg5oelp4HGdS0nTm/LSI+LCKdxP1bjX4geAGeVTeJTZJ6piK1sq0AxczSG
 YFyp0jQsLrAM1mWisIsfyoWiCOXECeZPZbvo6nHok89ZKzcPrI2jHkLBSUBkkh2+6HX2ZDZ+p0h
 9ypKBp/9SkLeB7JiaNECwhxHEpM3f91QeLfayym3XWH2kLtOmZQnV2BrLqdo9E3De8V
X-Received: by 2002:a05:600c:3b0e:b0:495:78af:78e5 with SMTP id
 5b1f17b1804b1-49578af7abemr16723915e9.1.1784823106364; 
 Thu, 23 Jul 2026 09:11:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531basm16378441f8f.19.2026.07.23.09.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 09:11:45 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 16:11:36 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: 708a71ad512e9dde189305c8d2aa1f5d6f35ce81
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c0e77108ff07d9dcf138779bf423a60127251ff1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmw1c-00080L-Ky
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 multi_get_instance_udp_real method
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
Content-Type: multipart/mixed; boundary="===============8644439993252534851=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8644439993252534851==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qZJ+DhTU2P0="; charset=UTF-8

--qZJ+DhTU2P0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1725?usp=3Demail

to look at the new patch set (#5)=
=2E

The change is no longer submittable: checks~ChecksSubmitRule is unsati=
sfied now=2E


Change subject: Extract multi_get_instance_udp_real method
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extract multi=
_get_instance_udp_real method

This is just a small refactoring to make the=
 code a little bit
better organised=2E

Change-Id: I37ade55d7674c68dd98cf4d=
fde35c4ad42e20d39
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M sr=
c/openvpn/mudp=2Ec
1 file changed, 25 insertions(+), 8 deletions(-)


  git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/25/1725/5

di=
ff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9acf297=2E=2Ed=
22c53b 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -205=
,7 +205,6 @@
 handle_connection_attempt(struct multi_context *m,
          =
                 struct link_socket *sock,
                           struc=
t mroute_addr *real,
-                          const uint64_t hv,
        =
                   struct hash_bucket *bucket)
 {
     struct hash *hash =
=3D m->hash;
@@ -236,6 +235,7 @@
             mi =3D multi_create_instance(=
m, real, sock);
             if (mi)
             {
+                const =
uint64_t hv =3D hash_value(hash, real);
                 hash_add_fast(hash=
, bucket, &mi->real, hv, mi);
                 mi->did_real_hash =3D true;
=
                 multi_assign_peer_id(m, mi);
@@ -265,6 +265,28 @@
 }
 
 /*=
*
+ * Looks up an multi instance by its real address (IP and port)
+ * @par=
am m     multi context
+ * @param real  Address to look up
+ * @return     =
 instance matching the address, NULL otherwise
+ */
+static struct multi_in=
stance *
+multi_get_instance_udp_real(struct multi_context *m, struct mrout=
e_addr *real)
+{
+    struct hash *hash =3D m->hash;
+    struct hash_eleme=
nt *he;
+    const uint64_t hv =3D hash_value(hash, real);
+    struct hash=
_bucket *bucket =3D hash_bucket(hash, hv);
+    he =3D hash_lookup_fast(has=
h, bucket, real, hv);
+    if (he)
+    {
+        return he->value;
+    }=

+    return NULL;
+}
+
+
+/**
  * Get a client instance based on real addr=
ess=2E  If
  * the instance doesn't exist, create it while
  * maintaining =
real address hash table atomicity=2E
@@ -280,7 +302,6 @@
 
     if (mroute_=
extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=
=2Ec2=2Ebuf=2Elen > 0)
     {
-        struct hash_element *he;
         co=
nst uint64_t hv =3D hash_value(hash, &real);
         struct hash_bucket *b=
ucket =3D hash_bucket(hash, hv);
         uint8_t *ptr =3D BPTR(&m->top=2Ec=
2=2Ebuf);
@@ -317,17 +338,13 @@
         }
         if (!v2 || peer_id_disa=
bled)
         {
-            he =3D hash_lookup_fast(hash, bucket, &real, =
hv);
-            if (he)
-            {
-                mi =3D (struct mu=
lti_instance *)he->value;
-            }
+            mi =3D multi_get_inst=
ance_udp_real(m, &real);
         }
 
         /* we have no existing multi=
 instance for this connection */
         if (!mi)
         {
-            =
mi =3D handle_connection_attempt(m, sock, &real, hv, bucket);
+            =
mi =3D handle_connection_attempt(m, sock, &real, bucket);
         }
 
 #if=
def ENABLE_DEBUG

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1725?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
Gerrit-Change-Number: 1725
Gerrit=
-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-op=
envpn@rfc2549=2Eorg>

--qZJ+DhTU2P0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1725?usp=3Demail">View Change</a></p><p>The change is no=
 longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Extract multi_get_instance_udp_real method<br><br>This is just a s=
mall refactoring to make the code a little bit<br>better organised=2E<br><b=
r>Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>1=
 file changed, 25 insertions(+), 8 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/25/1725/5<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br>=
<span>index 9acf297=2E=2Ed22c53b 100644</span><br><span>--- a/src/openvpn/m=
udp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -205,=
7 +205,6 @@</span><br><span> handle_connection_attempt(struct multi_context=
 *m,</span><br><span>                           struct link_socket *sock,</=
span><br><span>                           struct mroute_addr *real,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                          con=
st uint64_t hv,</span><br><span>                           struct hash_buck=
et *bucket)</span><br><span> {</span><br><span>     struct hash *hash =3D m=
-&gt;hash;</span><br><span>@@ -236,6 +235,7 @@</span><br><span>            =
 mi =3D multi_create_instance(m, real, sock);</span><br><span>             =
if (mi)</span><br><span>             {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                const uint64_t hv =3D hash_value(hash, r=
eal);</span><br><span>                 hash_add_fast(hash, bucket, &amp;mi-=
&gt;real, hv, mi);</span><br><span>                 mi-&gt;did_real_hash =
=3D true;</span><br><span>                 multi_assign_peer_id(m, mi);</sp=
an><br><span>@@ -265,6 +265,28 @@</span><br><span> }</span><br><span> </spa=
n><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Looks up an multi instance by its real address (IP and port)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param m     multi context</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param real  Address =
to look up</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retur=
n      instance matching the address, NULL otherwise</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static struct multi_instance *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+multi_get_instance_udp_real(struct multi_conte=
xt *m, struct mroute_addr *real)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct hash_element *he;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(hash, real);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket =
*bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    he =3D hash_lookup_fast(hash, bucket, real, hv);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (he)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return he-&gt;value;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Get a client i=
nstance based on real address=2E  If</span><br><span>  * the instance doesn=
&#39;t exist, create it while</span><br><span>  * maintaining real address =
hash table atomicity=2E</span><br><span>@@ -280,7 +302,6 @@</span><br><span=
> </span><br><span>     if (mroute_extract_openvpn_sockaddr(&amp;real, &amp=
;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen =
&gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        struct hash_element *he;</span><br><span>         const ui=
nt64_t hv =3D hash_value(hash, &amp;real);</span><br><span>         struct =
hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span>         uin=
t8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>@@ -317,17 +=
338,13 @@</span><br><span>         }</span><br><span>         if (!v2 || pe=
er_id_disabled)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            he =3D hash_lookup_fast(hash, bucket, &amp=
;real, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  if (he)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mi =
=3D (struct multi_instance *)he-&gt;value;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            mi =3D multi_get_instance_udp_real(m, &amp;real)=
;</span><br><span>         }</span><br><span> </span><br><span>         /* =
we have no existing multi instance for this connection */</span><br><span> =
        if (!mi)</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            mi =3D handle_connection_attempt(m, sock,=
 &amp;real, hv, bucket);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            mi =3D handle_connection_attempt(m, sock, &amp;real, bucke=
t);</span><br><span>         }</span><br><span> </span><br><span> #ifdef EN=
ABLE_DEBUG</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail">change 1725</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I37ad=
e55d7674c68dd98cf4dfde35c4ad42e20d39 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1725 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--qZJ+DhTU2P0=--


--===============8644439993252534851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8644439993252534851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8644439993252534851==--

