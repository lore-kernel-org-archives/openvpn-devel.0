Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6FACA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xvuRemrMHh8HkW6Rxucn4TBpmZE8UT6rdNbVIqANcCM=; b=JWjFPWOX8eWb+haAAZV3ra0GF0
	gYunaCh7QscOu0g3/RnJEgVIhRlZSoO0av0B4vSu2XhqqAzgOL93ZjiSz7qQKvO31WKF3jpvAx8Yy
	rdmUKqdULI1EYwNyp8G5/+M2hg6Cdq1jU5Aci7ucQ2wGHvgl4wNSPFyqjeIVBDnhwzRo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBCLP-0001Q7-Bg;
	Mon, 28 Sep 2026 14:28:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBCLN-0001Q0-S9
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:28:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=30BzgT0L2wMi2wKv7izHnCUWFc2ayRFupVE8TgjBikc=; b=Rh8wqx9Ezt9t7T0lXoyY/Fw284
 Unj/sZMIoQ13733oy+q32kFmJMh+WO9cZssqG+jn+sqGk9D0eHoczEeh5wACu5bC93GnpgMoONJLE
 LN9QN7tSYiVrWPub7JKI9pNTTnVF99sPpVcyr5zmWVHwGv5oYVN5jVHnaK+Urx/nZijw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=30BzgT0L2wMi2wKv7izHnCUWFc2ayRFupVE8TgjBikc=; b=c
 4e+LrBe5gnaFKmdj1+Hqkw1TiehZUL+4As/f07iNMzKsN9+TMqVC86E+BqZ9V3fxRwJycChf6YKWd
 XGIiR9yG+i9uW/HlYyBMasOaOVZ8lqyNHqy9bdlJL5J7vPXLWOGrWbi5wCLd9461O8mNCDmY9oAfv
 hZR59fngE1T/REnI=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBCLL-00048d-N0 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:28:37 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso29532635e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790605709; x=1791210509; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=30BzgT0L2wMi2wKv7izHnCUWFc2ayRFupVE8TgjBikc=;
 b=QwL+Yr4V27V2CqL2dDxAhZJw8cBH3Kh2SbydcWmB5ou3GASaTeKkbMrWnrFi2VrGcz
 1rAad3T2DBLsKrfuVuPzU8nFkGyMnHwrtUIVZEfli1Z3+QokarPZiw1SYRzNunwKtjtK
 Ypm1/mTQggTOXQsKpaXbDU7BdYm140WFdyTVjZqgw5gQhuWVsUJcaDzdhep6WKaxx/Tr
 VHv4u5Pp5slsYGsbS+5UFfPOoQnV5ytfVUmAU5z4teRCcj21N2d5V0EJ5VFOOAV/2rjX
 3atRUCwwvf0ViTtkT24xmixk/3uPoEyDxASW8HTASRazIjvFn0j+dW81V18ztjCiZcYB
 zsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790605709; x=1791210509;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=30BzgT0L2wMi2wKv7izHnCUWFc2ayRFupVE8TgjBikc=;
 b=EHyqY9m7bV9GHqyDpjTGi3P7jIN1m5nMMv9l6yJNsYTR4j1izLXMqdo1VkLwJFQzab
 0DxoNcg667zarmsE9sfgXYXJdj3GtpF7EK03+p0wpLc2XvfgQw1QhCO5rnCusyKymB6v
 G4ZUEX9ZADJULwqNhqvSVIWzW6Fj94ex91W16j+7CWn4zTSYXKsZui6OPiLuOvSRmfN1
 Invs0TLB2NMl86752Br0MjVU6rF/5AG7khDz7J0HqqRlKcwNzao1/zefc5L3NoGgdGq1
 fCX3wIjhiQd9ym82MXU2iriwW8YWpgedAHFP++YJkF6ILF9gbjvSkJwtGH2W5fGFEaaR
 xtzw==
X-Gm-Message-State: AFuF++nJwegNhKVwHJRpQTTRcG2haoDmEt8gjLuD246JYrl4GT+H1Ko5
 0cbFdB6yhe11RabQ/GVDe8BMoCkCOhm8/NktqELROIxAu5/nA1CM57vrfkPbUnatdB3csFPeA/f
 x/qB+XFEbjg/vaRIlmVczYeV3yi5Zi6wxEWY1SpkQ5SKzdr8HJkgXUkpUQiWcdycTqp/q
X-Gm-Gg: AYBFou1RhCzARs/9va53PBM1i1cBSGKjYEHazFMedXygnbZYcQsl2fo7zJNejrsaoV0
 0W/evZFhwgNQD2HQIBVu45Fc4lNiFWl1RKt07EeVBGqBcnN3jA8lcajJ27RqUTfilRrqDzJhdJG
 LmN/S7WxIGmP90YDa2xpVIrvgZy/NS0wJ6RuZN6bo9QMz7zZu6YbE09jBZu3fMW+qz700uJnBFu
 vMgZicskGw96XwawMIpSe7rlLd36HK/KRYmaGiNhPkPCG89kBUkqI2ljPRK0Bn2xAlU/wLYKc31
 lCR//bo/ZERAczdau66SuyvCVq71sTXS/Ov2H2fXKcAJMD8hJL5x0wSFuorOG+ndcTdEvsHO8P5
 RR94b82Ken1h5nZ/wL7JSTc3j09YeXJ4+Jd88gEy0NEuRP9oxiUwOnY7dDVXgsQ/g3PmX9htxg3
 NlM/eyJoeVoOaMl+QTM9C0+0Kx7pjD2+CgIjCiklOgfjsnj1tmxzIz20gQqJf5jePt3RhQO08S9
 TAeyR8/KA0etx7gISLr9tP6BCIv5RdGGELn8xwjr800UT6Ui1Bvs4qyggbG176j7u1vK2xXYvpW
 ElkZK6P+Z+OW4enHmusC8SdwxyarJWQWj4kT5YyJ1o5wSoXPnMNeWa5C0cB0/8NAXj/jYJFs
X-Received: by 2002:a05:600d:6443:20b0:49d:17d4:aff2 with SMTP id
 5b1f17b1804b1-49fe66cab7bmr167659745e9.1.1790605708884; 
 Mon, 28 Sep 2026 07:28:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0019057cfsm192069265e9.11.2026.09.28.07.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:28:28 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 14:28:26 +0000
To: razvanc <razvanc@mailbox.org>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
X-Gerrit-Change-Number: 1683
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1683?usp=email>
X-Gerrit-Commit: 2f76d3aac55a5347273013d60eb86aa17c8b8941
In-Reply-To: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkkwYmE3MjNkMTJkNDMzZTZlMDIwNTg4YjdiMGMzYmExMGJjZjhjNDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3e007cef37a5d02f8949fa7e2244ff895610f07b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBCLL-00048d-N0
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1809459922082830366=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1809459922082830366==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zVWwOfmKImE="; charset=UTF-8

--zVWwOfmKImE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by razv=
anc


Change subject: dco: remove iroute at client exit time instead of del=
ayed exit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

d=
co: remove iroute at client exit time instead of delayed exit

When a clien=
t exits due to one of the following reasons:
* EEN received
* AUTH_FAILED s=
ent
* RESTART sent
OpenVPN will perform some minimal cleanup and will
then =
postpone the actual instance purge by 5 seconds=2E

If iroutes are configur=
ed for the exiting client, the actual DCO
iroutes removal is also postponed=
=2E

If during this time window the same client reconnects, a new
instance =
is created (for example because --duplicate-cn is set or
because the same u=
sername is provided upon authentication) and the
same IP is assigned, then =
OpenVPN will:

* create the new client instance;
* attempt adding the relat=
ed DCO iroutes (which will fail because
  EEXIST);
* 5 seconds timeout fire=
s -> execute the delayed exit routine and
  delete the DCO iroutes;
* no ir=
outes exists anymore on the server despite the client being
  fully connect=
ed=2E

Note that this issue is DCO specific, because without DCO OpenVPN
cr=
eates virtual routes (no system routing table involved) and makes
the last =
connecting client own them=2E
This means that the delayed exit routine won'=
t have any iroute to
delete=2E

With this patch we move the DCO iroutes del=
etion to the actual
client exit time in order to avoid racing with a possib=
le addition
being executed when the client reconnects=2E The new flow will =
be:

* client exits (due to EEN or timeout)
* DCO iroutes are immediately d=
eleted
* client re-connects -> new instance created
* DCO iroutes are added=
 -> SUCCESS
* 5 seconds timeout fires -> old instance client is fully purge=
d
* client is connected and iroutes are in place as expected

This issue wa=
s reported by OpenVPN Access Server developers after
observing erratic irou=
tes disappearance with DCO in place=2E

Change-Id: I0ba723d12d433e6e020588b=
7b0c3ba10bcf8c44f
GitHub: closes openvpn/OpenVPN#1040
Signed-off-by: Antoni=
o Quartulli <antonio@mandelbit=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683
Me=
ssage-Id: <20260928113726=2E32340-1-gert@greenie=2Emuc=2Ede>
URL: https://l=
ore=2Ekernel=2Eorg/openvpn-devel/20260928113726=2E32340-1-gert@greenie=2Emu=
c=2Ede/T/#u
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src=
/openvpn/dco=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/multi=2Ec
M src/op=
envpn/openvpn=2Eh
4 files changed, 29 insertions(+), 1 deletion(-)


  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/1683/8

dif=
f --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index ba1c85f=2E=2E6d88=
f6f 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -750,6 +7=
50,8 @@
     }
     ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D DEV_TYPE_TUN)=
;
 
+    msg(D_DCO, "DCO: attempt removing iroutes from system table");
+
 =
    if (c->c2=2Epush_ifconfig_defined)
     {
         for (const struct ir=
oute *ir =3D c->options=2Eiroutes; ir; ir =3D ir->next)
diff --git a/src/op=
envpn/forward=2Ec b/src/openvpn/forward=2Ec
index a8a4a07=2E=2E6d85c62 1006=
44
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -539,6 +5=
39,23 @@
     {
         return false;
     }
+
+    /* DCO iroutes must be=
 removed now, because the delay introduced by this
+     * timer can create=
 a race condition:
+     * the same client may reconnect before the old ins=
tance is purged, leading
+     * to DCO iroutes removal *after* reconnectio=
n, thus killing the routes
+     * for the new instance too=2E
+     *
+   =
  * Standard/virtual iroutes (non-DCO case) are not affected because the
+ =
    * last connecting client claiming the iroutes takes ownership=2E Theref=
ore
+     * they are not removed during delayed cleanup=2E
+     */
+    if=
 (c->did_dco_iroutes)
+    {
+        c->did_dco_iroutes =3D false;
+      =
  dco_delete_iroutes(&c->net_ctx, c);
+    }
+
     tls_set_single_session(=
c->c2=2Etls_multi);
     update_time();
     reset_coarse_timers(c);
diff -=
-git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 9b9cdc3=2E=2E71d=
ba6c 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -479=
,7 +479,12 @@
     const struct iroute *ir;
     const struct iroute_ipv6 *=
ir6;
 
-    dco_delete_iroutes(&m->top=2Enet_ctx, &mi->context);
+    /* ch=
eck if DCO iroutes were already removed when scheduling a delayed exit */
+=
    if (mi->context=2Edid_dco_iroutes)
+    {
+        mi->context=2Edid_dc=
o_iroutes =3D false;
+        dco_delete_iroutes(&m->top=2Enet_ctx, &mi->co=
ntext);
+    }
 
     if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV=
_TYPE_TUN)
     {
@@ -1275,6 +1280,8 @@
     if (TUNNEL_TYPE(mi->context=2E=
c1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
         mi->did_iroutes =3D true;=

+        /* multi_learn_in{6}_addr_t takes care of installing the DCO irou=
te */
+        mi->context=2Edid_dco_iroutes =3D true;
         for (ir =3D=
 mi->context=2Eoptions=2Eiroutes; ir !=3D NULL; ir =3D ir->next)
         {=

             if (ir->netbits >=3D 0)
diff --git a/src/openvpn/openvpn=2Eh =
b/src/openvpn/openvpn=2Eh
index e9e18bf=2E=2Ecdd02b6 100644
--- a/src/openv=
pn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -507,6 +507,8 @@
     bool =
did_we_daemonize;       /**< Whether demonization has already
             =
                      *   taken place=2E */
 
+    bool did_dco_iroutes;   =
     /**< Whether DCO iroutes have been installed */
+
     struct context_=
persist persist;
     /**< Persistent %context=2E */
     struct context_0 =
*c0; /**< Level 0 %context=2E */

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1683?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
Gerrit-Change-Num=
ber: 1683
Gerrit-PatchSet: 8
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
=
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--zVWwOfmKImE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #8</strong> to the change originally created by ordex=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">dco: remove iroute at client ex=
it time instead of delayed exit<br><br>When a client exits due to one of th=
e following reasons:<br>* EEN received<br>* AUTH_FAILED sent<br>* RESTART s=
ent<br>OpenVPN will perform some minimal cleanup and will<br>then postpone =
the actual instance purge by 5 seconds=2E<br><br>If iroutes are configured =
for the exiting client, the actual DCO<br>iroutes removal is also postponed=
=2E<br><br>If during this time window the same client reconnects, a new<br>=
instance is created (for example because --duplicate-cn is set or<br>becaus=
e the same username is provided upon authentication) and the<br>same IP is =
assigned, then OpenVPN will:<br><br>* create the new client instance;<br>* =
attempt adding the related DCO iroutes (which will fail because<br>  EEXIST=
);<br>* 5 seconds timeout fires -&gt; execute the delayed exit routine and<=
br>  delete the DCO iroutes;<br>* no iroutes exists anymore on the server d=
espite the client being<br>  fully connected=2E<br><br>Note that this issue=
 is DCO specific, because without DCO OpenVPN<br>creates virtual routes (no=
 system routing table involved) and makes<br>the last connecting client own=
 them=2E<br>This means that the delayed exit routine won&#39;t have any iro=
ute to<br>delete=2E<br><br>With this patch we move the DCO iroutes deletion=
 to the actual<br>client exit time in order to avoid racing with a possible=
 addition<br>being executed when the client reconnects=2E The new flow will=
 be:<br><br>* client exits (due to EEN or timeout)<br>* DCO iroutes are imm=
ediately deleted<br>* client re-connects -&gt; new instance created<br>* DC=
O iroutes are added -&gt; SUCCESS<br>* 5 seconds timeout fires -&gt; old in=
stance client is fully purged<br>* client is connected and iroutes are in p=
lace as expected<br><br>This issue was reported by OpenVPN Access Server de=
velopers after<br>observing erratic iroutes disappearance with DCO in place=
=2E<br><br>Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f<br>GitHub: =
closes openvpn/OpenVPN#1040<br>Signed-off-by: Antonio Quartulli &lt;antonio=
@mandelbit=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683<br>Mess=
age-Id: &lt;20260928113726=2E32340-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: ht=
tps://lore=2Ekernel=2Eorg/openvpn-devel/20260928113726=2E32340-1-gert@green=
ie=2Emuc=2Ede/T/#u<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/forward=2Ec<br>M sr=
c/openvpn/multi=2Ec<br>M src/openvpn/openvpn=2Eh<br>4 files changed, 29 ins=
ertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/1683/8</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index ba1c85f=2E=
=2E6d88f6f 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span=
>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -750,6 +750,8 @@</span><br><s=
pan>     }</span><br><span>     ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=
=3D DEV_TYPE_TUN);</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg(D_DCO, &quot;DCO: attempt removing iroutes from sy=
stem table&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>     if (c-&gt;c2=2Epush_ifconfig_defined)</span><br><span>=
     {</span><br><span>         for (const struct iroute *ir =3D c-&gt;opti=
ons=2Eiroutes; ir; ir =3D ir-&gt;next)</span><br><span>diff --git a/src/ope=
nvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index a8a4a07=2E=
=2E6d85c62 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><=
span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -539,6 +539,23 @@</sp=
an><br><span>     {</span><br><span>         return false;</span><br><span>=
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* DCO iroutes must be remov=
ed now, because the delay introduced by this</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * timer can create a race condition:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * the same client may r=
econnect before the old instance is purged, leading</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * to DCO iroutes removal *after* rec=
onnection, thus killing the routes</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * for the new instance too=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * Standard/virtual iroutes (non-DCO case) are not aff=
ected because the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * last connecting client claiming the iroutes takes ownership=2E Therefo=
re</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * they are n=
ot removed during delayed cleanup=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (c-&gt;did_dco_iroutes)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        c-&gt;did_dco_iroutes =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        dco_delete_iroutes(&amp;c-&gt;net_ctx, c);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     tls_set_singl=
e_session(c-&gt;c2=2Etls_multi);</span><br><span>     update_time();</span>=
<br><span>     reset_coarse_timers(c);</span><br><span>diff --git a/src/ope=
nvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 9b9cdc3=2E=2E7=
1dba6c 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+=
++ b/src/openvpn/multi=2Ec</span><br><span>@@ -479,7 +479,12 @@</span><br><=
span>     const struct iroute *ir;</span><br><span>     const struct iroute=
_ipv6 *ir6;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    dco_delete_iroutes(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;contex=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check if =
DCO iroutes were already removed when scheduling a delayed exit */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Edid=
_dco_iroutes)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;conte=
xt=2Edid_dco_iroutes =3D false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        dco_delete_iroutes(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&g=
t;context);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span> </span><br><span>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2E=
tuntap) =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>@@ -127=
5,6 +1280,8 @@</span><br><span>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Et=
untap) =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>        =
 mi-&gt;did_iroutes =3D true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* multi_learn_in{6}_addr_t takes care of installing the =
DCO iroute */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  mi-&gt;context=2Edid_dco_iroutes =3D true;</span><br><span>         for (=
ir =3D mi-&gt;context=2Eoptions=2Eiroutes; ir !=3D NULL; ir =3D ir-&gt;next=
)</span><br><span>         {</span><br><span>             if (ir-&gt;netbit=
s &gt;=3D 0)</span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/ope=
nvpn/openvpn=2Eh</span><br><span>index e9e18bf=2E=2Ecdd02b6 100644</span><b=
r><span>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/ope=
nvpn=2Eh</span><br><span>@@ -507,6 +507,8 @@</span><br><span>     bool did_=
we_daemonize;       /**&lt; Whether demonization has already</span><br><spa=
n>                                   *   taken place=2E */</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool did_dco_i=
routes;        /**&lt; Whether DCO iroutes have been installed */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct =
context_persist persist;</span><br><span>     /**&lt; Persistent %context=
=2E */</span><br><span>     struct context_0 *c0; /**&lt; Level 0 %context=
=2E */</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1683?usp=3Demail">change 1683</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I0ba723d12d433e6e020588b7b=
0c3ba10bcf8c44f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
683 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>

</body></html>
--zVWwOfmKImE=--


--===============1809459922082830366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1809459922082830366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1809459922082830366==--

