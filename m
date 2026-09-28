Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC0ACA5FA7
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBm596BxnQIQg2QKkD13UDm8so0jSl/hyTPIyDQPL98=; b=dwKr4vahsbqmrZkkIf9JMGPVH5
	rwlogwmsJLQ8ZINQOtuxWgjad2HJnxZRO+KCX1mVq93g+6IMNmyK0v6h646M1L9I+0QsBNaheImD7
	qzyP9/q8tiizcgS9oKmRiTCftWgRb2jDOcOdiSRyslLG5VWSjz9/vNiNvWF5K8Ugluik=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBCLU-0007Tb-G8;
	Mon, 28 Sep 2026 14:28:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBCLU-0007TU-3h
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=W2jeEQNIkC5tqnxO70k5iCz9M93wFcSUqN00/HD1rjc=; b=OJZMENlIwSGnmDYi3I4TVXHncs
 X9WpMAgoLcyhQIjCyBOrjBO3S0CqmG3XgiNqAubkgkkZ+5XPyyNmuPhGceKOKHI1IBwvkaX+6Dm6M
 IfdJkQLkSO38LRBne4UjmMsbe2+dTb4ybm6E22waiQHlhR671yzhUwUtuAzBCGnjFHxw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=W2jeEQNIkC5tqnxO70k5iCz9M93wFcSUqN00/HD1rjc=; b=A
 oibyo/G74uT4s2Z5ZGd4A54eBjFNdtC4/hmJxzXpx5AhVy6n3cj3pOSRhFTbzl1ggrbWMQudCrYKy
 7o1sMHNbdecphy+ZB6nHESNbs0rocgnn1ReO/bGtDJwRbl2vTstcjd7ZBLs+j9TK+tQlHO4zCVqYT
 xj2IxZfDzpwwTA+w=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBCLN-0006ks-GT for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:28:41 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ff9621c5dso14096635e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790605711; x=1791210511; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W2jeEQNIkC5tqnxO70k5iCz9M93wFcSUqN00/HD1rjc=;
 b=YHKQQTMOQUrMiZXIsR9NdCdDB5EJ9zqyGXk3R78MNvXRfjiPUmgH9zg25IAa5pmB9r
 GthP+5NAZC4tDagT1Hhm56MVA3F42FH4tJ3HFfl+UJaryRU89Zwi9meM21Y7DocuP/Hd
 7nLuFHzL1J6HUoe4QxVUkPKM8AC+Z4SWJn1W9toeHAj7tl+AMlz2xTrbKlZgxhG1dgsL
 x0FfVZS1fB/6iWQtCtWHQBJ1J51LlG8rtLa7CjT1us7ofSlCCvEamKVrvBwk7CPW/Gxg
 CGbR6gYiyMCKsGvrVgY+OsK/i+593/tn7VmKwp4OQ1K5wKnu5RqAE/pYMTRaMmjNq3wh
 2i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790605711; x=1791210511;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W2jeEQNIkC5tqnxO70k5iCz9M93wFcSUqN00/HD1rjc=;
 b=TCkbE27KtMrlYGwz+NXabnHgAcKLQQuGaBV3tYYzFkdlda//PmskUNXE8wg/d7u8wz
 IKvXJsmMnbunFZyDjx8Osp4NrTjNczGS9ZigEc8eFUxakf/sdDHDMG2ud8L2IZG0INVW
 SNMM2GBfpDdNlYqQePbfr4nm2lJr6R5jRglWZwTgRNF2QLDEdrwrrGKqClO2vzv9Vf4y
 Zn6M5TM3udVPHVPM8VwMoV5VQu5JM/RsZMmys6Y/3Ni+husjhFtGVX/Mg4tWPhfVmLUj
 BZGFxSpUCTlnALBYVs4GrLv+x5nQuuiRzlCQfbEVQusp8ocEpjt/yOKsVvW+OTt9rTpe
 u52w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEindVRbfMxle6ZYc29MZ+h9WTXj+rHDFGbC5JouUPVCfRFK+/ZLtlZZtA4RyiTGb1+GEcjdAsV/VsK0Nr@lists.sourceforge.net
X-Gm-Message-State: AFuF++nDYK4MURkt/uWsBspIZxPE089jyFfXD/haTr9ZkirkwqUVndso
 vph690TOkydVzzFD/jfgRYnAAnXFFkqI+cQR7xSqJcTa+hBHXBiWQmra7oJE0QZcMiJlu5WqxoH
 pfJtP0WwCB/nNcNcAGz+8XpSyqj+2EaPs8lEp4zwxFvX3dLp+LSkLx7uhw4EKn5GXf7p7
X-Gm-Gg: AYBFou2SXj18TRxvmPr88CeN9E391wcVp88wTBsoZ236amHUHKcQ8UYA7w979JkZKtX
 +u/GmqNIMv8QPprpCtynqxtUOP2Aa7rsIEDHZKXbas+udVAS7uj99L31tEAnsI3At7SE5eUcJPy
 dnV2feD71m106ZIrv+kt/6bZDNRcWMcW5A72bVOA4Ji5xAjWdhI2M7cIW7TODdf9u2uRIuilVxZ
 bHUsC3Rvua8hdb/2ZB2NBsEUZ1NqzaEA771q6Mc9I7qANreGeudcMnB3Y/9yGmK7dyZY/E3K7JX
 dj+VNZgh5HhXUMp59d+42pq75GOWUEG5jxhcHdccFHAh2sDyOdXFKUMalk06W4d3c344I78Nj4Z
 5eRX2zB+eWBqmhvAZrJnSD3CFnoDh8p6O+s12ETu3BH7ByyVmNzGjvVrPnIlcqdNDjlHfx/cVsG
 OZ9QpVnxPNi/ZIrmf8zUxmvzcMXs+lwP26TaW1pEkdsk2Zn4j8qqJutLPfYDvzlc46tMpplU5YX
 qfeQ8EH/5f8nSvMzM2llEGO6Zx1rDnSvYt0AHtLO+awwP6JxsqjbBw/kjLpcA7L5YQmFTit8iSY
 zvI1MVSzx7k5CkMvIBiRQgANg5KbDyFW9dgc17XMV0q4fuqx9OXYTILxCxiNXg==
X-Received: by 2002:a05:600c:8486:b0:49e:745d:c317 with SMTP id
 5b1f17b1804b1-49fe66b426bmr229866905e9.12.1790605710787; 
 Mon, 28 Sep 2026 07:28:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00178bebasm151917905e9.11.2026.09.28.07.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:28:30 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 14:28:29 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
X-Gerrit-Change-Number: 1683
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1683?usp=email>
X-Gerrit-Commit: 2f76d3aac55a5347273013d60eb86aa17c8b8941
In-Reply-To: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkkwYmE3MjNkMTJkNDMzZTZlMDIwNTg4YjdiMGMzYmExMGJjZjhjNDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3e007cef37a5d02f8949fa7e2244ff895610f07b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBCLN-0006ks-GT
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: remove iroute
 at client exit time instead of delayed exit
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7945202090772878696=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7945202090772878696==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ohWsypQkiCs="; charset=UTF-8

--ohWsypQkiCs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1683?usp=3Demail )

Change subject: dco: remove iroute at client exit t=
ime instead of delayed exit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

dco: remove iroute at client exit time instead of delayed =
exit

When a client exits due to one of the following reasons:
* EEN receiv=
ed
* AUTH_FAILED sent
* RESTART sent
OpenVPN will perform some minimal clea=
nup and will
then postpone the actual instance purge by 5 seconds=2E

If ir=
outes are configured for the exiting client, the actual DCO
iroutes removal=
 is also postponed=2E

If during this time window the same client reconnect=
s, a new
instance is created (for example because --duplicate-cn is set or
=
because the same username is provided upon authentication) and the
same IP =
is assigned, then OpenVPN will:

* create the new client instance;
* attemp=
t adding the related DCO iroutes (which will fail because
  EEXIST);
* 5 se=
conds timeout fires -> execute the delayed exit routine and
  delete the DC=
O iroutes;
* no iroutes exists anymore on the server despite the client bei=
ng
  fully connected=2E

Note that this issue is DCO specific, because with=
out DCO OpenVPN
creates virtual routes (no system routing table involved) a=
nd makes
the last connecting client own them=2E
This means that the delayed=
 exit routine won't have any iroute to
delete=2E

With this patch we move t=
he DCO iroutes deletion to the actual
client exit time in order to avoid ra=
cing with a possible addition
being executed when the client reconnects=2E =
The new flow will be:

* client exits (due to EEN or timeout)
* DCO iroutes=
 are immediately deleted
* client re-connects -> new instance created
* DCO=
 iroutes are added -> SUCCESS
* 5 seconds timeout fires -> old instance cli=
ent is fully purged
* client is connected and iroutes are in place as expec=
ted

This issue was reported by OpenVPN Access Server developers after
obse=
rving erratic iroutes disappearance with DCO in place=2E

Change-Id: I0ba72=
3d12d433e6e020588b7b0c3ba10bcf8c44f
GitHub: closes openvpn/OpenVPN#1040
Sig=
ned-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Acked-by: Razvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1683
Message-Id: <20260928113726=2E32340-1-gert@greenie=2Emuc=2E=
de>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20260928113726=2E32340-1=
-gert@greenie=2Emuc=2Ede/T/#u
Signed-off-by: Gert Doering <gert@greenie=2Em=
uc=2Ede>
---
M src/openvpn/dco=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/=
multi=2Ec
M src/openvpn/openvpn=2Eh
4 files changed, 29 insertions(+), 1 de=
letion(-)




diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index =
ba1c85f=2E=2E6d88f6f 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=
=2Ec
@@ -750,6 +750,8 @@
     }
     ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=
=3D DEV_TYPE_TUN);
 
+    msg(D_DCO, "DCO: attempt removing iroutes from sy=
stem table");
+
     if (c->c2=2Epush_ifconfig_defined)
     {
         for=
 (const struct iroute *ir =3D c->options=2Eiroutes; ir; ir =3D ir->next)
di=
ff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index a8a4a07=
=2E=2E6d85c62 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forwar=
d=2Ec
@@ -539,6 +539,23 @@
     {
         return false;
     }
+
+    /* D=
CO iroutes must be removed now, because the delay introduced by this
+     =
* timer can create a race condition:
+     * the same client may reconnect =
before the old instance is purged, leading
+     * to DCO iroutes removal *=
after* reconnection, thus killing the routes
+     * for the new instance t=
oo=2E
+     *
+     * Standard/virtual iroutes (non-DCO case) are not affec=
ted because the
+     * last connecting client claiming the iroutes takes o=
wnership=2E Therefore
+     * they are not removed during delayed cleanup=
=2E
+     */
+    if (c->did_dco_iroutes)
+    {
+        c->did_dco_iroute=
s =3D false;
+        dco_delete_iroutes(&c->net_ctx, c);
+    }
+
     tls=
_set_single_session(c->c2=2Etls_multi);
     update_time();
     reset_coar=
se_timers(c);
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
in=
dex 9b9cdc3=2E=2E71dba6c 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openv=
pn/multi=2Ec
@@ -479,7 +479,12 @@
     const struct iroute *ir;
     const =
struct iroute_ipv6 *ir6;
 
-    dco_delete_iroutes(&m->top=2Enet_ctx, &mi->=
context);
+    /* check if DCO iroutes were already removed when scheduling=
 a delayed exit */
+    if (mi->context=2Edid_dco_iroutes)
+    {
+        =
mi->context=2Edid_dco_iroutes =3D false;
+        dco_delete_iroutes(&m->to=
p=2Enet_ctx, &mi->context);
+    }
 
     if (TUNNEL_TYPE(mi->context=2Ec1=
=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
@@ -1275,6 +1280,8 @@
     if (TUNNE=
L_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
         mi->=
did_iroutes =3D true;
+        /* multi_learn_in{6}_addr_t takes care of in=
stalling the DCO iroute */
+        mi->context=2Edid_dco_iroutes =3D true;=

         for (ir =3D mi->context=2Eoptions=2Eiroutes; ir !=3D NULL; ir =3D=
 ir->next)
         {
             if (ir->netbits >=3D 0)
diff --git a/src=
/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index e9e18bf=2E=2Ecdd02b6 1=
00644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -507,6=
 +507,8 @@
     bool did_we_daemonize;       /**< Whether demonization has =
already
                                   *   taken place=2E */
 
+    boo=
l did_dco_iroutes;        /**< Whether DCO iroutes have been installed */
+=

     struct context_persist persist;
     /**< Persistent %context=2E */
 =
    struct context_0 *c0; /**< Level 0 %context=2E */

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
G=
errit-Change-Number: 1683
Gerrit-PatchSet: 8
Gerrit-Owner: ordex <antonio@m=
andelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razva=
nc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>

--ohWsypQkiCs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1683?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dco: remove iroute at client exit time ins=
tead of delayed exit<br><br>When a client exits due to one of the following=
 reasons:<br>* EEN received<br>* AUTH_FAILED sent<br>* RESTART sent<br>Open=
VPN will perform some minimal cleanup and will<br>then postpone the actual =
instance purge by 5 seconds=2E<br><br>If iroutes are configured for the exi=
ting client, the actual DCO<br>iroutes removal is also postponed=2E<br><br>=
If during this time window the same client reconnects, a new<br>instance is=
 created (for example because --duplicate-cn is set or<br>because the same =
username is provided upon authentication) and the<br>same IP is assigned, t=
hen OpenVPN will:<br><br>* create the new client instance;<br>* attempt add=
ing the related DCO iroutes (which will fail because<br>  EEXIST);<br>* 5 s=
econds timeout fires -&gt; execute the delayed exit routine and<br>  delete=
 the DCO iroutes;<br>* no iroutes exists anymore on the server despite the =
client being<br>  fully connected=2E<br><br>Note that this issue is DCO spe=
cific, because without DCO OpenVPN<br>creates virtual routes (no system rou=
ting table involved) and makes<br>the last connecting client own them=2E<br=
>This means that the delayed exit routine won&#39;t have any iroute to<br>d=
elete=2E<br><br>With this patch we move the DCO iroutes deletion to the act=
ual<br>client exit time in order to avoid racing with a possible addition<b=
r>being executed when the client reconnects=2E The new flow will be:<br><br=
>* client exits (due to EEN or timeout)<br>* DCO iroutes are immediately de=
leted<br>* client re-connects -&gt; new instance created<br>* DCO iroutes a=
re added -&gt; SUCCESS<br>* 5 seconds timeout fires -&gt; old instance clie=
nt is fully purged<br>* client is connected and iroutes are in place as exp=
ected<br><br>This issue was reported by OpenVPN Access Server developers af=
ter<br>observing erratic iroutes disappearance with DCO in place=2E<br><br>=
Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f<br>GitHub: closes open=
vpn/OpenVPN#1040<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683<br>Message-Id: &l=
t;20260928113726=2E32340-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=
=2Ekernel=2Eorg/openvpn-devel/20260928113726=2E32340-1-gert@greenie=2Emuc=
=2Ede/T/#u<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<b=
r>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/forward=2Ec<br>M src/openvp=
n/multi=2Ec<br>M src/openvpn/openvpn=2Eh<br>4 files changed, 29 insertions(=
+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/o=
penvpn/dco=2Ec</span><br><span>index ba1c85f=2E=2E6d88f6f 100644</span><br>=
<span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</=
span><br><span>@@ -750,6 +750,8 @@</span><br><span>     }</span><br><span> =
    ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO=
, &quot;DCO: attempt removing iroutes from system table&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (c-&gt=
;c2=2Epush_ifconfig_defined)</span><br><span>     {</span><br><span>       =
  for (const struct iroute *ir =3D c-&gt;options=2Eiroutes; ir; ir =3D ir-&=
gt;next)</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn=
/forward=2Ec</span><br><span>index a8a4a07=2E=2E6d85c62 100644</span><br><s=
pan>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=
=2Ec</span><br><span>@@ -539,6 +539,23 @@</span><br><span>     {</span><br>=
<span>         return false;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* DCO iroutes must be removed now, because the delay in=
troduced by this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * timer can create a race condition:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * the same client may reconnect before the old inst=
ance is purged, leading</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * to DCO iroutes removal *after* reconnection, thus killing the ro=
utes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * for the =
new instance too=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Standa=
rd/virtual iroutes (non-DCO case) are not affected because the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * last connecting client cl=
aiming the iroutes takes ownership=2E Therefore</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * they are not removed during delayed clea=
nup=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;did_dco_iro=
utes)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;did_dco_iroute=
s =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 dco_delete_iroutes(&amp;c-&gt;net_ctx, c);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     tls_set_single_session(c-&gt;c2=2Etls_multi=
);</span><br><span>     update_time();</span><br><span>     reset_coarse_ti=
mers(c);</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/m=
ulti=2Ec</span><br><span>index 9b9cdc3=2E=2E71dba6c 100644</span><br><span>=
--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</sp=
an><br><span>@@ -479,7 +479,12 @@</span><br><span>     const struct iroute =
*ir;</span><br><span>     const struct iroute_ipv6 *ir6;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_delete_iroutes=
(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* check if DCO iroutes were already remov=
ed when scheduling a delayed exit */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (mi-&gt;context=2Edid_dco_iroutes)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        mi-&gt;context=2Edid_dco_iroutes =3D false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_delete=
_iroutes(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><spa=
n>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</=
span><br><span>     {</span><br><span>@@ -1275,6 +1280,8 @@</span><br><span=
>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</s=
pan><br><span>     {</span><br><span>         mi-&gt;did_iroutes =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* multi_lea=
rn_in{6}_addr_t takes care of installing the DCO iroute */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Edid_dco_iro=
utes =3D true;</span><br><span>         for (ir =3D mi-&gt;context=2Eoption=
s=2Eiroutes; ir !=3D NULL; ir =3D ir-&gt;next)</span><br><span>         {</=
span><br><span>             if (ir-&gt;netbits &gt;=3D 0)</span><br><span>d=
iff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><sp=
an>index e9e18bf=2E=2Ecdd02b6 100644</span><br><span>--- a/src/openvpn/open=
vpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -5=
07,6 +507,8 @@</span><br><span>     bool did_we_daemonize;       /**&lt; Wh=
ether demonization has already</span><br><span>                            =
       *   taken place=2E */</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    bool did_dco_iroutes;        /**&lt; Whether=
 DCO iroutes have been installed */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     struct context_persist persist;</span=
><br><span>     /**&lt; Persistent %context=2E */</span><br><span>     stru=
ct context_0 *c0; /**&lt; Level 0 %context=2E */</span><br></pre><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Dema=
il">change 1683</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
683?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1683 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex =
&lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--ohWsypQkiCs=--


--===============7945202090772878696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7945202090772878696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7945202090772878696==--

