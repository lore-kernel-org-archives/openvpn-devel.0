Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9566C88E41
	for <openvpn-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m+lgqWVCQiIfnqrdgjauCnN2CClqm9suaUT2ByifFU0=; b=BMCTRXTS357v/tns1oOm9wdYyJ
	aMQ85klhu1r1z79HfQ9v2n62UZi8aiGEQ5NDdz0nG9YvVkizn1YVvvoCN2lB/TLe+b9dgBGftt1ij
	1Hijx2vJu1ooRrN/w0xRzhb87dc+eyUNzV0UV7e9FD6YKZILonPdgRqhYgASq5q4k1b8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4a3i-0007P9-GV;
	Thu, 10 Sep 2026 08:23:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4a3e-0007Og-Qi
 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 08:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qYKH0ieUdJceNCocVRWgcD9l7tJRKrbuE/X5i9Va+ZI=; b=DnC9NQ9H6QE/6iRz8KMDNNrS+R
 UIDRMjOjpWjyK16wqK6NWRSRWyies4PY+/yAmNysNdz0/5jTmxRdRx/7IkanRtTWYr8s6yVXDybK8
 Gkc4tjA0RSdGX68UIPZvaK/xpwsOfqOHVmOYb4g7XWAKzHxQGVvYfaF3QKocHALGoCk8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qYKH0ieUdJceNCocVRWgcD9l7tJRKrbuE/X5i9Va+ZI=; b=i
 5nW3mnBH4BFFRMhM0EfmlmI7KUVQSC8wB9a/F+IPIPDCtzdnjw7SSk1ou4Yj6hAvTsdqOAbJPnf+g
 0/3xpaSwN6vQKMoM9jYKbRk2ZlECNAsv5YE6dkWHyiq1sv87+CKy4rgdDZOHT9Tdvt9pnT0DUn7xo
 gH9k9etw2BaxzQ2U=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4a3b-0008Hy-7N for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 08:22:59 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48441a2ba14so5754894f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789028568; x=1789633368; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qYKH0ieUdJceNCocVRWgcD9l7tJRKrbuE/X5i9Va+ZI=;
 b=fwIcTtfa7U/ZGiBjIRgjzuPnoEJoblBuvRx+c7WUqPP7wbl0sr8doYEqsDhTfa0Wqp
 WOK5KnHg6ENGyMv5NOrSdPMOTScr5n0nSrE+4vgcDHNQzx2UXl1hJyMYc+SVWW03GPKO
 cNm5Pel/N48JLFlfLobElRYvYW0H/r38XbzLm996uoO1lKQN4s+RTlW91+3q6+PpNYc/
 ncaFSzUMMc3oBjb77JkvR+GnxXsI4xGghYgMtvtd5joRKsLMetU+Cg8lI28g42DP98s3
 l4gG6ZswU5zy3P7lt3D08ec3L8PeFBuRAn1NZdstQbUrML2vx4otUDIBAs+DqYzDlMm0
 Q8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789028568; x=1789633368;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qYKH0ieUdJceNCocVRWgcD9l7tJRKrbuE/X5i9Va+ZI=;
 b=Gt5kO4SD/5wnnf3zquIX6YW3GGnaP2Hxvzjvs3aboJECLtjjfvVZiQsBvtPb6imWoC
 09amlfojfiJH9/6/HTcouHsWdcLMjb3eLvyaneuLX+QWKtaosd9glthmrBMqWDaE+2z4
 eNIypZXMo0wOPCmtJq3OOXaMOr1QNrbPoMoCkWrvOUzLR6vCSokRhoSl5aU2tQrdBkWZ
 SQYTGLvjhr4Yl3CpCy33f6nrMlSFpRXrPm/+greptlzgmGuKodX64PnZhTS6a+ZZ+WLG
 ClTHzHqCqZd4i9pkFRouRBJvICDmqCoMZacJASgMlPODat1S99FpxUbmjV9vJVI92zB+
 1B7A==
X-Gm-Message-State: AFuF++llnCGCmEknz8d2N2yzmPQbJt1ikgEl9L7O+b2+KmlENWdsDix6
 vSVEmPKMLXYWH0e9g/P1wgc8VWoycvLH47CESe7vKQ+7t0f0j2x/sAUYy95Z/fFZB1B46iT3nN7
 GBne5gloauP6Lo+/hXVRUyFk3Hpn9ib9fTsAXBc6T96E29Wo8eaTjbz9vhMXJIHfoker6
X-Gm-Gg: AYBFou16YrG45s4z6thmecMCrSmGh+O32v73g/vHBZox5bJZYrLNLZE7Z0dlSbnsdEX
 hRtea9gcsFna5wL5nxKQlWUv+b7wp+ADG9uP/8ik7FrekApz5+9ShzNEK4NkfPq1aYcWaScXIw5
 9OBI3FiScKdMGedZuVoG3+TE1dh0ilh4zVdp3C1cf3VXsIzBG4BQ46yxbCZLQKRfN+6Ljx9OHDl
 VMQVkLwDiwvV5n6uUe2efuxG0J+5gNcvSLNsYJUDT8CTlR2WcDxfVgTGkhZ8aXWq+Zg9H55nrd/
 KTk9kzFEIDSJ4JcgBvogQzlmKoAKm63D3JC2g1hAiSJ0PdhUMHv/USEQJLNwQM0sNzzn94dB5jp
 c69ED3lnChJGcv34Dmjb8w7LIPko2IuwnXYc6N7HpEIYmKnKkJcwG00HOsp43zdABhmB/tZlyvu
 UDnG8F/nKf4hAasbnRA9KB2HrDZMAF0pbat2G66c3T1fPT+3sl4rkcYrkdZeBtoyPLlN8yP3PC4
 nP+Hilc8mo+3GUb7Y+04Ryv2SyZqA/WUuMootI3bP/qIOskWMOotTA4Dy9ZKPMZxsG+Otl16u8l
 AIXc4KkkTx9KyrsGjIrPTwuJBNoM/0lruM3mml3MxAD7wQWxk9EW59GE3+cfOg==
X-Received: by 2002:a05:6000:18a9:b0:485:9249:6a10 with SMTP id
 ffacd0b85a97d-48592496b7cmr35456351f8f.7.1789028568307; 
 Thu, 10 Sep 2026 01:22:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858e239862sm43994126f8f.9.2026.09.10.01.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 01:22:47 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 10 Sep 2026 08:22:43 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
X-Gerrit-Change-Number: 1683
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1683?usp=email>
X-Gerrit-Commit: 162d13467d7eb9df027f1d6b3bd8b21257f8bc71
In-Reply-To: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkkwYmE3MjNkMTJkNDMzZTZlMDIwNTg4YjdiMGMzYmExMGJjZjhjNDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c07f6cde7f13718f87a1ae1c8c28589895fcd2a3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4a3b-0008Hy-7N
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3171045555432386207=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3171045555432386207==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ou7LTjQl0aE="; charset=UTF-8

--Ou7LTjQl0aE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos=2E

He=
llo flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please=
 visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail

to =
look at the new patch set (#6)=2E

The following approvals got outdated and=
 were removed:
Code-Review+2 by plaisthos

The change is no longer submitta=
ble: Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E


Chang=
e subject: dco: remove iroute at client exit time instead of delayed exit
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: remove i=
route at client exit time instead of delayed exit

When a client exits due =
to one of the following reasons:
* EEN received
* AUTH_FAILED sent
* RESTAR=
T sent
OpenVPN will perform some minimal cleanup and will
then postpone the=
 actual instance purge by 5 seconds=2E

If iroutes are configured for the e=
xiting client, the actual DCO
iroutes removal is also postponed=2E

If duri=
ng this time window the same client reconnects, a new
instance is created (=
for example because --duplicate-cn is set or
because the same username is p=
rovided upon authentication) and the
same IP is assigned, then OpenVPN will=
:

* create the new client instance;
* attempt adding the related DCO irout=
es (which will fail because
  EEXIST);
* 5 seconds timeout fires -> execute=
 the delayed exit routine and
  delete the DCO iroutes;
* no iroutes exists=
 anymore on the server despite the client being
  fully connected=2E

Note =
that this issue is DCO specific, because without DCO OpenVPN
creates virtua=
l routes (no system routing table involved) and makes
the last connecting c=
lient own them=2E
This means that the delayed exit routine won't have any i=
route to
delete=2E

With this patch we move the DCO iroutes deletion to the=
 actual
client exit time in order to avoid racing with a possible addition
=
being executed when the client reconnects=2E The new flow will be:

* clien=
t exits (due to EEN or timeout)
* DCO iroutes are immediately deleted
* cli=
ent re-connects -> new instance created
* DCO iroutes are added -> SUCCESS
=
* 5 seconds timeout fires -> old instance client is fully purged
* client i=
s connected and iroutes are in place as expected

This issue was reported b=
y OpenVPN Access Server developers after
observing erratic iroutes disappea=
rance with DCO in place=2E

Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf=
8c44f
GitHub: closes openvpn/OpenVPN#1040
Signed-off-by: Antonio Quartulli =
<antonio@mandelbit=2Ecom>
---
M src/openvpn/dco=2Ec
M src/openvpn/forward=
=2Ec
M src/openvpn/forward=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/openvp=
n=2Eh
M src/openvpn/push=2Ec
6 files changed, 34 insertions(+), 6 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83=
/1683/6

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index ba1c8=
5f=2E=2E6d88f6f 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
=
@@ -750,6 +750,8 @@
     }
     ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D D=
EV_TYPE_TUN);
 
+    msg(D_DCO, "DCO: attempt removing iroutes from system =
table");
+
     if (c->c2=2Epush_ifconfig_defined)
     {
         for (con=
st struct iroute *ir =3D c->options=2Eiroutes; ir; ir =3D ir->next)
diff --=
git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 2ade321=2E=2E=
86bc4f2 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
=
@@ -525,7 +525,7 @@
  * Schedule a SIGTERM signal c->options=2Escheduled_ex=
it_interval seconds from now=2E
  */
 bool
-schedule_exit(struct context *c=
)
+schedule_exit(openvpn_net_ctx_t *net_ctx, struct context *c)
 {
     con=
st int n_seconds =3D c->options=2Escheduled_exit_interval;
     /* don't re=
schedule if already scheduled=2E */
@@ -533,6 +533,23 @@
     {
         re=
turn false;
     }
+
+    /* DCO iroutes must be removed now, because the d=
elay introduced by this
+     * timer can create a race condition:
+     * =
the same client may reconnect before the old instance is purged, leading
+ =
    * to DCO iroutes removal *after* reconnection, thus killing the routes
=
+     * for the new instance too=2E
+     *
+     * Standard/virtual iroute=
s (non-DCO case) are not affected because the
+     * last connecting clien=
t claiming the iroutes takes ownership=2E Therefore
+     * they are not re=
moved during delayed cleanup=2E
+     */
+    if (c->did_dco_iroutes)
+    =
{
+        c->did_dco_iroutes =3D false;
+        dco_delete_iroutes(net_ct=
x, c);
+    }
+
     tls_set_single_session(c->c2=2Etls_multi);
     update=
_time();
     reset_coarse_timers(c);
diff --git a/src/openvpn/forward=2Eh =
b/src/openvpn/forward=2Eh
index 324c0b4=2E=2Efd5cbc5 100644
--- a/src/openv=
pn/forward=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -346,7 +346,7 @@
 void proc=
ess_ip_header(struct context *c, unsigned int flags, struct buffer *buf,
  =
                      struct link_socket *sock);
 
-bool schedule_exit(stru=
ct context *c);
+bool schedule_exit(openvpn_net_ctx_t *net_ctx, struct cont=
ext *c);
 
 static inline struct link_socket_info *
 get_link_socket_info(s=
truct context *c)
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c
index a167071=2E=2E812f12c 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/o=
penvpn/multi=2Ec
@@ -479,7 +479,12 @@
     const struct iroute *ir;
     co=
nst struct iroute_ipv6 *ir6;
 
-    dco_delete_iroutes(&m->top=2Enet_ctx, &=
mi->context);
+    /* check if DCO iroutes were already removed when schedu=
ling a delayed exit */
+    if (mi->context=2Edid_dco_iroutes)
+    {
+    =
    mi->context=2Edid_dco_iroutes =3D false;
+        dco_delete_iroutes(&m=
->top=2Enet_ctx, &mi->context);
+    }
 
     if (TUNNEL_TYPE(mi->context=
=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
@@ -1277,6 +1282,8 @@
     if (=
TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
        =
 mi->did_iroutes =3D true;
+        /* multi_learn_in{6}_addr_t takes care =
of installing the DCO iroute */
+        mi->context=2Edid_dco_iroutes =3D =
true;
         for (ir =3D mi->context=2Eoptions=2Eiroutes; ir !=3D NULL; i=
r =3D ir->next)
         {
             if (ir->netbits >=3D 0)
diff --git =
a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index e9e18bf=2E=2Ecdd0=
2b6 100644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -=
507,6 +507,8 @@
     bool did_we_daemonize;       /**< Whether demonization=
 has already
                                   *   taken place=2E */
 
+  =
  bool did_dco_iroutes;        /**< Whether DCO iroutes have been installed=
 */
+
     struct context_persist persist;
     /**< Persistent %context=2E=
 */
     struct context_0 *c0; /**< Level 0 %context=2E */
diff --git a/src=
/openvpn/push=2Ec b/src/openvpn/push=2Ec
index fa7bf1e=2E=2Ed6fe442 100644
=
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -202,7 +202,7 @@
 =
     * */
     if (c->options=2Emode =3D=3D MODE_SERVER)
     {
-        if=
 (!schedule_exit(c))
+        if (!schedule_exit(&c->net_ctx, c))
         =
{
             /* Return early when we don't need to notify management */
 =
            return;
@@ -392,7 +392,7 @@
 void
 send_auth_failed(struct cont=
ext *c, const char *client_reason)
 {
-    if (!schedule_exit(c))
+    if (=
!schedule_exit(&c->net_ctx, c))
     {
         msg(D_TLS_DEBUG, "exit alre=
ady scheduled for context");
         return;
@@ -493,7 +493,7 @@
 void
 se=
nd_restart(struct context *c, const char *kill_msg)
 {
-    schedule_exit(c=
);
+    schedule_exit(&c->net_ctx, c);
     send_control_channel_string(c, =
kill_msg ? kill_msg : "RESTART", D_PUSH);
 }
 

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
Ge=
rrit-Change-Number: 1683
Gerrit-PatchSet: 6
Gerrit-Owner: ordex <antonio@ma=
ndelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>

--Ou7LTjQl0aE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos=2E </p>
<p>ordex <stro=
ng>uploaded patch set #6</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review+2 by pl=
aisthos</p><p>The change is no longer submittable: Code-Review and checks~C=
hecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">dco: remove iroute =
at client exit time instead of delayed exit<br><br>When a client exits due =
to one of the following reasons:<br>* EEN received<br>* AUTH_FAILED sent<br=
>* RESTART sent<br>OpenVPN will perform some minimal cleanup and will<br>th=
en postpone the actual instance purge by 5 seconds=2E<br><br>If iroutes are=
 configured for the exiting client, the actual DCO<br>iroutes removal is al=
so postponed=2E<br><br>If during this time window the same client reconnect=
s, a new<br>instance is created (for example because --duplicate-cn is set =
or<br>because the same username is provided upon authentication) and the<br=
>same IP is assigned, then OpenVPN will:<br><br>* create the new client ins=
tance;<br>* attempt adding the related DCO iroutes (which will fail because=
<br>  EEXIST);<br>* 5 seconds timeout fires -&gt; execute the delayed exit =
routine and<br>  delete the DCO iroutes;<br>* no iroutes exists anymore on =
the server despite the client being<br>  fully connected=2E<br><br>Note tha=
t this issue is DCO specific, because without DCO OpenVPN<br>creates virtua=
l routes (no system routing table involved) and makes<br>the last connectin=
g client own them=2E<br>This means that the delayed exit routine won&#39;t =
have any iroute to<br>delete=2E<br><br>With this patch we move the DCO irou=
tes deletion to the actual<br>client exit time in order to avoid racing wit=
h a possible addition<br>being executed when the client reconnects=2E The n=
ew flow will be:<br><br>* client exits (due to EEN or timeout)<br>* DCO iro=
utes are immediately deleted<br>* client re-connects -&gt; new instance cre=
ated<br>* DCO iroutes are added -&gt; SUCCESS<br>* 5 seconds timeout fires =
-&gt; old instance client is fully purged<br>* client is connected and irou=
tes are in place as expected<br><br>This issue was reported by OpenVPN Acce=
ss Server developers after<br>observing erratic iroutes disappearance with =
DCO in place=2E<br><br>Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f=
<br>GitHub: closes openvpn/OpenVPN#1040<br>Signed-off-by: Antonio Quartulli=
 &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/o=
penvpn/forward=2Ec<br>M src/openvpn/forward=2Eh<br>M src/openvpn/multi=2Ec<=
br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/push=2Ec<br>6 files changed, =
34 insertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/1683/6</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index ba1=
c85f=2E=2E6d88f6f 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><b=
r><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -750,6 +750,8 @@</span=
><br><span>     }</span><br><span>     ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap=
) =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(D_DCO, &quot;DCO: attempt removing iroutes fr=
om system table&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     if (c-&gt;c2=2Epush_ifconfig_defined)</span><br><=
span>     {</span><br><span>         for (const struct iroute *ir =3D c-&gt=
;options=2Eiroutes; ir; ir =3D ir-&gt;next)</span><br><span>diff --git a/sr=
c/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 2ade3=
21=2E=2E86bc4f2 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span>=
<br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -525,7 +525,7 @@=
</span><br><span>  * Schedule a SIGTERM signal c-&gt;options=2Escheduled_ex=
it_interval seconds from now=2E</span><br><span>  */</span><br><span> bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_exit(struct c=
ontext *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_=
exit(openvpn_net_ctx_t *net_ctx, struct context *c)</span><br><span> {</spa=
n><br><span>     const int n_seconds =3D c-&gt;options=2Escheduled_exit_int=
erval;</span><br><span>     /* don&#39;t reschedule if already scheduled=2E=
 */</span><br><span>@@ -533,6 +533,23 @@</span><br><span>     {</span><br><=
span>         return false;</span><br><span>     }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* DCO iroutes must be removed now, because the delay intro=
duced by this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 timer can create a race condition:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * the same client may reconnect before the old instanc=
e is purged, leading</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * to DCO iroutes removal *after* reconnection, thus killing the route=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * for the new=
 instance too=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Standard/=
virtual iroutes (non-DCO case) are not affected because the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * last connecting client claim=
ing the iroutes takes ownership=2E Therefore</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * they are not removed during delayed cleanup=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;did_dco_iroute=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;did_dco_iroutes =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d=
co_delete_iroutes(net_ctx, c);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     tls_set_single_session(c-&gt;c2=2Etls_multi);</span><br>=
<span>     update_time();</span><br><span>     reset_coarse_timers(c);</spa=
n><br><span>diff --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh<=
/span><br><span>index 324c0b4=2E=2Efd5cbc5 100644</span><br><span>--- a/src=
/openvpn/forward=2Eh</span><br><span>+++ b/src/openvpn/forward=2Eh</span><b=
r><span>@@ -346,7 +346,7 @@</span><br><span> void process_ip_header(struct =
context *c, unsigned int flags, struct buffer *buf,</span><br><span>       =
                 struct link_socket *sock);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-bool schedule_exit(struct context *=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool schedule_ex=
it(openvpn_net_ctx_t *net_ctx, struct context *c);</span><br><span> </span>=
<br><span> static inline struct link_socket_info *</span><br><span> get_lin=
k_socket_info(struct context *c)</span><br><span>diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec</span><br><span>index a167071=2E=2E812f12c=
 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/s=
rc/openvpn/multi=2Ec</span><br><span>@@ -479,7 +479,12 @@</span><br><span> =
    const struct iroute *ir;</span><br><span>     const struct iroute_ipv6 =
*ir6;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    dco_delete_iroutes(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check if DCO ir=
outes were already removed when scheduling a delayed exit */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Edid_dco_i=
routes)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Ed=
id_dco_iroutes =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        dco_delete_iroutes(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;cont=
ext);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span> </span><br><span>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap=
) =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>@@ -1277,6 +1=
282,8 @@</span><br><span>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap)=
 =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>         mi-&g=
t;did_iroutes =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* multi_learn_in{6}_addr_t takes care of installing the DCO ir=
oute */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&=
gt;context=2Edid_dco_iroutes =3D true;</span><br><span>         for (ir =3D=
 mi-&gt;context=2Eoptions=2Eiroutes; ir !=3D NULL; ir =3D ir-&gt;next)</spa=
n><br><span>         {</span><br><span>             if (ir-&gt;netbits &gt;=
=3D 0)</span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/o=
penvpn=2Eh</span><br><span>index e9e18bf=2E=2Ecdd02b6 100644</span><br><spa=
n>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=
=2Eh</span><br><span>@@ -507,6 +507,8 @@</span><br><span>     bool did_we_d=
aemonize;       /**&lt; Whether demonization has already</span><br><span>  =
                                 *   taken place=2E */</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool did_dco_irout=
es;        /**&lt; Whether DCO iroutes have been installed */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct cont=
ext_persist persist;</span><br><span>     /**&lt; Persistent %context=2E */=
</span><br><span>     struct context_0 *c0; /**&lt; Level 0 %context=2E */<=
/span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</s=
pan><br><span>index fa7bf1e=2E=2Ed6fe442 100644</span><br><span>--- a/src/o=
penvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>=
@@ -202,7 +202,7 @@</span><br><span>      * */</span><br><span>     if (c-&=
gt;options=2Emode =3D=3D MODE_SERVER)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (!schedule_exit(c))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!schedule_exi=
t(&amp;c-&gt;net_ctx, c))</span><br><span>         {</span><br><span>      =
       /* Return early when we don&#39;t need to notify management */</span=
><br><span>             return;</span><br><span>@@ -392,7 +392,7 @@</span><=
br><span> void</span><br><span> send_auth_failed(struct context *c, const c=
har *client_reason)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (!schedule_exit(c))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!schedule_exit(&amp;c-&gt;net_ctx, c))</spa=
n><br><span>     {</span><br><span>         msg(D_TLS_DEBUG, &quot;exit alr=
eady scheduled for context&quot;);</span><br><span>         return;</span><=
br><span>@@ -493,7 +493,7 @@</span><br><span> void</span><br><span> send_re=
start(struct context *c, const char *kill_msg)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    schedule_exit(c);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    schedule_exit(&amp;c-&gt;=
net_ctx, c);</span><br><span>     send_control_channel_string(c, kill_msg ?=
 kill_msg : &quot;RESTART&quot;, D_PUSH);</span><br><span> }</span><br><spa=
n> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">change 1683</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ba723d12d433=
e6e020588b7b0c3ba10bcf8c44f </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1683 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ec=
om&gt; </div>

</body></html>
--Ou7LTjQl0aE=--


--===============3171045555432386207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3171045555432386207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3171045555432386207==--

