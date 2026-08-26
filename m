Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A99CC5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5/bdtpsV7zAX4dlxmvlcjql/72EclliJTPk2FFJUl98=; b=AY9qEWPFtRtLCvRCsVP43pVtCe
	LAdZcy4oxYJxSCB+Lk6O/7qq6FE2b7W0a2JQLZok/he9oFES8OTuOKmtU+0uUKzKqP43909RzsZK6
	KGZMxrmVPNZa3+iuSB849pSbd04MODj3S7bS2F8/uHYRTlKSu5VXVLNsUa9kVh1M9nHg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzANh-0004qn-A7;
	Wed, 26 Aug 2026 09:57:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzANf-0004qa-GK
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 09:57:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+ds2s+YfYJd3Wqkrh4I112pCYGooL4LpEospeFIcmNM=; b=g+cVb/s78ySAyu/AAC5ZPAgB39
 rJMWoXmGeCA39FE12EGeVz7fEHj5HetW4hvnpfR1MfMXxGofWLmJDx+F7yRZGzlpyh0Bn7xiFfu0k
 +nrzXTptFSQ5Hf/miJn3goodO2FLOqDqZiwikXxit+IeCVKpAb0yevwI2ythsh58YqV4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+ds2s+YfYJd3Wqkrh4I112pCYGooL4LpEospeFIcmNM=; b=k
 Yo3sqw1yEhXz+YjTdADFQe+5DM19Vlv1e1jW9fCrvPw2UIs4jbsf9BoviqjhIgZWjDlaoRCAKdQ1r
 4BIWho8PSfi0e6j77gKJaG0RVTDTACyPp7HoXDSXP8KB6QeGianhLDTkMNHT5pOHMmqjNcwAYldG5
 HUmIBzPitjIYUxc0=;
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzANf-0006YQ-6b for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 09:57:16 +0000
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so105821266b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787738229; x=1788343029; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+ds2s+YfYJd3Wqkrh4I112pCYGooL4LpEospeFIcmNM=;
 b=XhJA+X1TFhwpnsWwuNdShEdxHkaTDDb+963yytgVZrox1XNJp5g05ED2M86ryZbE6g
 U1XWB+78cIEDemm1gUH0WargtREFtH+e+gwJ96QPh0UXtlLQf5DZmDIH3XNizX1Pga2U
 GVmWFq5vOzY5e8y+ir6DBI0M6mNSdVgtBJIMJtas1dREn+2lLrS2CfT6Np6GnBFfWWVz
 RkItoC/7IjktYX2aIsWr5I3hSFLMYPGxXqb5dFNmt03NBynjMuU3vxpv5egAEOGUEK4I
 XDwNlkBiFVAUJWPSf65KxbvW8exhWD2aTISHBO+1NUpm0VnvoORCqT18tlUsazhBRe5Y
 zGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787738229; x=1788343029;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+ds2s+YfYJd3Wqkrh4I112pCYGooL4LpEospeFIcmNM=;
 b=JFwCqnj/IckQp+zjHxat2aKbTnMgwCfWOPbDuQ6P/HiaCVas/2FngZla5GuA7yIyh4
 PeNE7sGZkthTVuDlXUPH6gXTxQI+hOlgN33NkdFR/dycW4xvtFGFn6nEpg+cK1ofUaJ1
 JHPWGT8zHQ+z+CGK5qFDEmNlda97bQggoY/ziq7SUG5pOkRugW/ibd0QutS9cKWZ2o6/
 CmfEkdC6YejYSNutvM+C3h3hEIhpyQ5Dxl07XEdCk9O+y8SQeaXKu6bya+Tge9rFqWRW
 RjSGjFM7LoIUhFz7G0Qo6usp1PyocfweCOav/Z+P/HSW0T70FvnQbZ7y+BH/weXBq0WX
 3xAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbxCDJcOsagtfyNCvExiOKC2xCsPzz0eqY1sQdlyrEt5dWSqTjDEdqBzH0F3wYYaPvu3g+GXwxksx1fbh6@lists.sourceforge.net
X-Gm-Message-State: AFuF++kTnB32B+sb33STXrmw3Ow3T46QwGiBaBd9npqiII3PGzNETOr+
 6P5awGXEpzploWlpoMY9rqHbq7FTC8oYNsRJMNVaow8IG4emljqdpRvd2pbxqYjuG5eSqS7z93s
 rvB/oW+bSm3+BIuNh0g23WWz2sNezAcErYSFCXeUgV7dlglr8L53BrQjkTvJWqDalaASb
X-Gm-Gg: AR+sD134eOLGaZ7uaGwrKpwwVScaqDhba0e/B+934c2d62YUZtNrsFTTQV4EgPwrnRj
 ndVlO2rv3Fx1nycyiW6P1XDrFyhUD5WcgqJRfImAJ6u1ASNIy8RXdTI81QsKKeBq2m/LKGRttXJ
 /nPHyoOQ4A5mvGj9PHJ0KWXgytNcEgJxwaZU318QrAohmsXVTgMjioOhqN52UVMuXCjg9JbYVxj
 t2pG9y5gTD0H9eVBcdr5S12HOea8z5ca3Vg+LyWaMNzETSPei9nGcMK7/O2otI2SRffGxEFwzK6
 OOTqPUGJcgsgJsArmXYKZsphC29jQjNNhQlMspAnF/qgSDD4KQ1+tN3MMarweQz/oY/kALdG025
 CaB5UqilAILscfotdQ7GWsSEwauc5m6kDQlvVc7USxJ3oJQn8Dpn2kX1RT6LW+LriqhpgoEw+VY
 dz9/ob5fRJqCsP0x9rWaDtuIABwDspCWmqTw8HtO/3AI4Ma1ymVcbxtFRQA2VMe+mro+Q3yrdNS
 nT21Prm76/0GkloM2AktjCKg3j9VgiLST6KTbY8dr9bujIq9kj1WAF3Sx85PgxmgLBIEF0TxgEe
 cRx8gO8p0wy43rqs/zucrgu0pfuZBFI9UibaH7erMY7cE6HWJqK4vGa2H/Xllg==
X-Received: by 2002:a17:906:fe08:b0:c21:34a3:4d9c with SMTP id
 a640c23a62f3a-c250c345beamr707867266b.21.1787738228480; 
 Wed, 26 Aug 2026 02:57:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d68f9sm416323066b.1.2026.08.26.02.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 02:57:08 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 09:57:07 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3f9834cc13c49b9249653d7d8637383f50c2fb87
X-Gerrit-Change-Number: 1729
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1729?usp=email>
X-Gerrit-Commit: 01c8c4c624a7a1405c9afba8ad8d296dee595ee5
In-Reply-To: <gerrit.1782252033000.I3f9834cc13c49b9249653d7d8637383f50c2fb87@gerrit.openvpn.net>
References: <gerrit.1782252033000.I3f9834cc13c49b9249653d7d8637383f50c2fb87@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMjUyMDMzMDAwLkkzZjk4MzRjYzEzYzQ5YjkyNDk2NTNkN2Q4NjM3MzgzZjUwYzJmYjg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <84a5aeb784e26c7114c041b6c2bf96b77192080f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzANf-0006YQ-6b
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: don't let
 stale-routes-check delete permanent routes
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3419908096606490158=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3419908096606490158==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A5rHqYqJOdA="; charset=UTF-8

--A5rHqYqJOdA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1729?usp=3Demail )

Change subject: multi: don't let stale-routes-check=
 delete permanent routes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

multi: don't let stale-routes-check delete permanent routes

=
When --stale-routes-check is enabled the periodic check removed every
aged =
entry from the virtual address routing table, including the
permanent route=
s installed from --iroute (e=2Eg=2E via --client-config-dir)
and the client=
's pushed ifconfig address=2E Once those entries were gone,
traffic towards=
 the iroute networks was no longer forwarded and the
affected client suffer=
ed an outage until it reconnected=2E

Routes learned from configuration (ir=
outes and pushed ifconfig
addresses) and genuinely dynamic routes (TAP sour=
ce addresses learned
from the data channel) were both added with flags =3D=
=3D 0, so
check_stale_routes() could not tell them apart and aged out all o=
f
them=2E Their last_reference is only refreshed when they are hit as a
pac=
ket destination, which never happens for an iroute network (CIDR
lookups cr=
eate a separate cached child route instead) nor for an idle
client's pushed=
 address, so both were eventually deleted=2E

Mark the config-derived route=
s with a new MULTI_ROUTE_PERMANENT flag in
the two learn helpers that insta=
ll them, and skip permanent routes in
check_stale_routes()=2E Dynamically l=
earned routes keep flags =3D=3D 0
and are still aged out, preserving the do=
cumented purpose of the
option=2E Cleanup on disconnect is unaffected: a ha=
lted instance makes
multi_route_defined() return false, so the reaper still=
 removes the
permanent routes when the client goes away=2E

Change-Id: I3f9=
834cc13c49b9249653d7d8637383f50c2fb87
Github: closes OpenVPN/openvpn#1063
S=
igned-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Acked-by: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1729
Message-Id: <20260731202242=2E25159-1-gert@greenie=2Emu=
c=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg38102=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M doc/man-sections/server-options=2Erst
M src/openvpn/multi=2Ec
=
M src/openvpn/multi=2Eh
3 files changed, 11 insertions(+), 5 deletions(-)

=



diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/se=
rver-options=2Erst
index f420588=2E=2E9dfa6bd 100644
--- a/doc/man-sections=
/server-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -673,6=
 +673,11 @@
 
   If ``t`` is not present it defaults to ``n``=2E
 
+  Only =
dynamically learned routes are subject to this check=2E Routes added from
+=
  configuration, such as ``--iroute`` entries and a client's pushed ifconfi=
g
+  address, are never removed by it; they are dropped only when the clien=
t
+  disconnects=2E
+
   This option helps to keep the dynamic routing tabl=
e small=2E See also
   ``--max-routes-per-client``
 
diff --git a/src/openv=
pn/multi=2Ec b/src/openvpn/multi=2Ec
index 74939bf=2E=2Ed8dd99b 100644
--- =
a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -1190,7 +1190,7 @@
 =
        addr=2Enetbits =3D (uint8_t)netbits;
     }
 
-    struct multi_ins=
tance *owner =3D multi_learn_addr(m, mi, &addr, 0);
+    struct multi_insta=
nce *owner =3D multi_learn_addr(m, mi, &addr, MULTI_ROUTE_PERMANENT);
 #ifd=
ef ENABLE_MANAGEMENT
     if (management && owner)
     {
@@ -1235,7 +1235,=
7 @@
         mroute_addr_mask_host_bits(&addr);
     }
 
-    struct multi=
_instance *owner =3D multi_learn_addr(m, mi, &addr, 0);
+    struct multi_i=
nstance *owner =3D multi_learn_addr(m, mi, &addr, MULTI_ROUTE_PERMANENT);
 =
#ifdef ENABLE_MANAGEMENT
     if (management && owner)
     {
@@ -1359,7 +1=
359,7 @@
     while ((he =3D hash_iterator_next(&hi)) !=3D NULL)
     {
   =
      struct multi_route *r =3D (struct multi_route *)he->value;
-        i=
f (multi_route_defined(m, r)
+        if (multi_route_defined(m, r) && !(r-=
>flags & MULTI_ROUTE_PERMANENT)
             && difftime(now, r->last_refer=
ence) >=3D m->top=2Eoptions=2Estale_routes_ageing_time)
         {
        =
     dmsg(D_MULTI_DEBUG, "MULTI: Deleting stale route for address '%s'",
di=
ff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 8b837fa=2E=
=2E6cb86c7 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@=
@ -233,8 +233,9 @@
     struct mroute_addr addr;
     struct multi_instance=
 *instance;
 
-#define MULTI_ROUTE_CACHE   (1 << 0)
-#define MULTI_ROUTE_AG=
EABLE (1 << 1)
+#define MULTI_ROUTE_CACHE     (1 << 0)
+#define MULTI_ROUTE=
_AGEABLE   (1 << 1)
+#define MULTI_ROUTE_PERMANENT (1 << 2) /* config-deriv=
ed (iroute / pushed ifconfig); never stale-aged */
     unsigned int flags;=

 
     unsigned int cache_generation;

-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1729?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I3f9834cc13c49b9249653d7d8637383f50c2fb87
Gerrit-Change-Nu=
mber: 1729
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--A5rHqYqJOdA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1729?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">multi: don&#39;t let stale-routes-check de=
lete permanent routes<br><br>When --stale-routes-check is enabled the perio=
dic check removed every<br>aged entry from the virtual address routing tabl=
e, including the<br>permanent routes installed from --iroute (e=2Eg=2E via =
--client-config-dir)<br>and the client&#39;s pushed ifconfig address=2E Onc=
e those entries were gone,<br>traffic towards the iroute networks was no lo=
nger forwarded and the<br>affected client suffered an outage until it recon=
nected=2E<br><br>Routes learned from configuration (iroutes and pushed ifco=
nfig<br>addresses) and genuinely dynamic routes (TAP source addresses learn=
ed<br>from the data channel) were both added with flags =3D=3D 0, so<br>che=
ck_stale_routes() could not tell them apart and aged out all of<br>them=2E =
Their last_reference is only refreshed when they are hit as a<br>packet des=
tination, which never happens for an iroute network (CIDR<br>lookups create=
 a separate cached child route instead) nor for an idle<br>client&#39;s pus=
hed address, so both were eventually deleted=2E<br><br>Mark the config-deri=
ved routes with a new MULTI_ROUTE_PERMANENT flag in<br>the two learn helper=
s that install them, and skip permanent routes in<br>check_stale_routes()=
=2E Dynamically learned routes keep flags =3D=3D 0<br>and are still aged ou=
t, preserving the documented purpose of the<br>option=2E Cleanup on disconn=
ect is unaffected: a halted instance makes<br>multi_route_defined() return =
false, so the reaper still removes the<br>permanent routes when the client =
goes away=2E<br><br>Change-Id: I3f9834cc13c49b9249653d7d8637383f50c2fb87<br=
>Github: closes OpenVPN/openvpn#1063<br>Signed-off-by: Antonio Quartulli &l=
t;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
729<br>Message-Id: &lt;20260731202242=2E25159-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38102=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M doc/man-sections/server-options=2Erst<br>M src/openv=
pn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>3 files changed, 11 insertions(+=
), 5 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/server-opt=
ions=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>index f4=
20588=2E=2E9dfa6bd 100644</span><br><span>--- a/doc/man-sections/server-opt=
ions=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Erst</spa=
n><br><span>@@ -673,6 +673,11 @@</span><br><span> </span><br><span>   If ``=
t`` is not present it defaults to ``n``=2E</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  Only dynamically learned routes =
are subject to this check=2E Routes added from</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  configuration, such as ``--iroute`` entries an=
d a client&#39;s pushed ifconfig</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  address, are never removed by it; they are dropped only when=
 the client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  discon=
nects=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>   This option helps to keep the dynamic routing table small=2E See a=
lso</span><br><span>   ``--max-routes-per-client``</span><br><span> </span>=
<br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span>=
<br><span>index 74939bf=2E=2Ed8dd99b 100644</span><br><span>--- a/src/openv=
pn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@=
 -1190,7 +1190,7 @@</span><br><span>         addr=2Enetbits =3D (uint8_t)ne=
tbits;</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct multi_instance *owner =3D multi_learn_=
addr(m, mi, &amp;addr, 0);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct multi_instance *owner =3D multi_learn_addr(m, mi, &amp;ad=
dr, MULTI_ROUTE_PERMANENT);</span><br><span> #ifdef ENABLE_MANAGEMENT</span=
><br><span>     if (management &amp;&amp; owner)</span><br><span>     {</sp=
an><br><span>@@ -1235,7 +1235,7 @@</span><br><span>         mroute_addr_mas=
k_host_bits(&amp;addr);</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *owner=
 =3D multi_learn_addr(m, mi, &amp;addr, 0);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct multi_instance *owner =3D multi_learn_ad=
dr(m, mi, &amp;addr, MULTI_ROUTE_PERMANENT);</span><br><span> #ifdef ENABLE=
_MANAGEMENT</span><br><span>     if (management &amp;&amp; owner)</span><br=
><span>     {</span><br><span>@@ -1359,7 +1359,7 @@</span><br><span>     wh=
ile ((he =3D hash_iterator_next(&amp;hi)) !=3D NULL)</span><br><span>     {=
</span><br><span>         struct multi_route *r =3D (struct multi_route *)h=
e-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (multi_route_defined(m, r)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (multi_route_defined(m, r) &amp;&amp; !(r-&gt;flags &am=
p; MULTI_ROUTE_PERMANENT)</span><br><span>             &amp;&amp; difftime(=
now, r-&gt;last_reference) &gt;=3D m-&gt;top=2Eoptions=2Estale_routes_agein=
g_time)</span><br><span>         {</span><br><span>             dmsg(D_MULT=
I_DEBUG, &quot;MULTI: Deleting stale route for address &#39;%s&#39;&quot;,<=
/span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh<=
/span><br><span>index 8b837fa=2E=2E6cb86c7 100644</span><br><span>--- a/src=
/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><s=
pan>@@ -233,8 +233,9 @@</span><br><span>     struct mroute_addr addr;</span=
><br><span>     struct multi_instance *instance;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define MULTI_ROUTE_CACHE   (1=
 &lt;&lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M=
ULTI_ROUTE_AGEABLE (1 &lt;&lt; 1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define MULTI_ROUTE_CACHE     (1 &lt;&lt; 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define MULTI_ROUTE_AGEABLE   (1 &lt=
;&lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MUL=
TI_ROUTE_PERMANENT (1 &lt;&lt; 2) /* config-derived (iroute / pushed ifconf=
ig); never stale-aged */</span><br><span>     unsigned int flags;</span><br=
><span> </span><br><span>     unsigned int cache_generation;</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1729?usp=3Demail">change 1729</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1729?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: I3f9834cc13c49b9249653d7d8637383f50c=
2fb87 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1729 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--A5rHqYqJOdA=--


--===============3419908096606490158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3419908096606490158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3419908096606490158==--

