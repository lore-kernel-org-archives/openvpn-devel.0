Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FC4CDB47C
	for <openvpn-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=wGkGxIsguaD1DpvzcxSk1fxZY4OsxnzY8b0vXBBx/xs=; b=IDPc2UGLYzKB/a
	VX1b6kfIsLVuWXl3lpBfMHERVnshfJSdJ/DbPQifAonFqP2Lv0thQ6etAah9ei1Ob2ZHCzrqKzlql
	0OMDTXTqoVCxkfQ44lJNPsuFiZqZU7kGBKG53RdfVPk69p/AqPP2/YGhlmuOR13zXkDV275Gllny7
	Q7M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wc9Aw-0007c1-Hk;
	Tue, 23 Jun 2026 22:00:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wc9Ak-0007bj-5C
 for openvpn-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 22:00:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IZBK0VBAqux0gJ0BO3gnU5Kui9Z2TM448EO+k7cjIrQ=; b=F+JlE4Lh7V+T9rRG/yeabr53AQ
 xRc18zD3VTHL4h6kI3fFm4BfBHSXID4noa4+NEJpVNHR+oewKsd59qbdtuDbT8HfmAoD7MCm6KGhj
 v3Es2P7/ed0OQuFf6zoRFk3ePrZL+68AGYMM04RlY67/Mp0z49X1l9A4VmyzwsKfmJg8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IZBK0VBAqux0gJ0BO3gnU5Kui9Z2TM448EO+k7cjIrQ=; b=j
 GB3T9ToTQI9oPoiHd5UUrkYCTXVr3OFqfeYl3Q1atfoznGvpEDANopeXM1Y9UglGrQ4VdzKZrgW+q
 tcILwiKcco8gO4atKzkvhNLo+10GfbD8C9n6KzOOnmtRKjEjAyQhn8Nzw9LfzqzTRaMmLaryeZfc7
 W1jbMoqrC73Ho2KM=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wc9Ah-0002Fx-Hv for openvpn-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 22:00:46 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4924944fe6bso2538355e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 23 Jun 2026 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782252037; x=1782856837; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZBK0VBAqux0gJ0BO3gnU5Kui9Z2TM448EO+k7cjIrQ=;
 b=QR+p36E9A/5YyKOIaVHaOmtxB/jJ2YFSudRD4/ufzMzL4wUEb6zEoS3Uefme8kn6T0
 ugfQ0CNGmx6mmYc4t3F1S/8zdUB4y+AixmCgj2Um1FYO/OqcCqhYqy2hWUbpfW8BcqB+
 Bk6+zwMATyea3dVXrMdkXB+onvApsnEZbqoIBum2P5TTacApq1E5W0Xe+ef7Mr6RxMCI
 jkQ57S16Rx0d+cr+0Uyw2rQDHoQMOByffuLNRU6fQJan1coiNbTdRxs1U1HAmMNJ79T1
 g/z2P54NcWvS3L5vY+fJYgnJjK7VPbAiryszY9Vxqe5/LNVenggy5gd8pef/o3WUkyoT
 C0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782252037; x=1782856837;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IZBK0VBAqux0gJ0BO3gnU5Kui9Z2TM448EO+k7cjIrQ=;
 b=UB7Z0OD77wS1p6aN2EzymFu9nW9m7Pat/hfK+UTXsCSVveHJBgXrzIFlfPzKLMIRVu
 sTAKTbKY8wmYDc70KtqqsYUWayMHjzVHd39VENDyAgtaVQ5PM6lm1Rt3nvZvxe4+lG/O
 1NsO3aOH9GG0mtTTrwUDiOHYKzoAmJ4LSkvVWtv7TyKcoyGkkoWK/Wqw/pjeyYuVtQCu
 ioIGZjIW9B4I9C0YrqF3T2gebiRyAIWVNjMhHEIZwHIJ8PDninI1dTWK7lHnJsfcquNc
 rpX0nOki7rHRKWQWjZwklEOPAL1D6dLWVymPsWVPT4ZlIfIQv85UtHyH62vVOc4v1Xc1
 IDaw==
X-Gm-Message-State: AOJu0YzV9cSQ2LcCcFP+UxxZMYKMkJmpyRJopqcm5AfAdReeWv3JRBw3
 kxg0HTBPwtBaQVfclkEhQmeLn6nVwnqfvgfcpU6LxRMS/AXuvfvDS8IfpvrhB/m8aHCWAUsuUba
 rzFYuld7D7l69hs/6g8yT90b9/muUh5K+qd3C5tjemyxSRhI7nzzCGrykjbscwq+GaWtxL0d5kH
 8p90z5sg==
X-Gm-Gg: AfdE7cmSbzVb7O5aYoEAJzpZpcYIlRtXJrM5SdY6ho0J9wyfCkFriSxj3pPuJunERNm
 djpg48IRR4ROMe9EiyvITttcW5x0DnTx1HvpYTLnXX72Zbc7kOBBkohwHi5/j/G0cy4DGDwKkZp
 Rfgs5El8Z+bTDmqz4m8j4In+uS0oTaxxEUtJEaQYlY9sv4RvsPvifkxcJpXL7ew0jR3u6Hc/hKy
 S/t5BA90wvkr/qZncia7Gbeokv7vqu5a09xNI6qpOsPoP5RC/h5iPB7O0CCQZjt2MuV45iaGHSd
 wWfLuFDNJFKSO34+8KFCVFWsEsMpuIvUDJzD8AKdXCy0NmKJKf6sNNc5DiuJqTnE9tMImllzQOe
 tLbK4qrN9lO9/4OiNICDjvJXJ3gsZb7UdLiVLim4DjLvJkM24QkUxOtOBuOnfQTkzWtGdYw/8eD
 f+Igo3m9AEL3y811CDsa+sGxD9Z+CzV4A75h8awNjABbByrCanZ+n/FepojS0WTVwlwXk5XI3oE
 EDYrbJtwbuHX8zjZxyN6aHpEn7F9BUV2b5AYWmqIaskWi4WoK/dHXXkluK+ZpgoYuaQehE+J7qo
 UqY=
X-Received: by 2002:a05:600c:138e:b0:48f:d612:3c59 with SMTP id
 5b1f17b1804b1-492608473c9mr6707745e9.9.1782252036523; 
 Tue, 23 Jun 2026 15:00:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492609389f0sm4183895e9.2.2026.06.23.15.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 15:00:36 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 23 Jun 2026 22:00:35 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3f9834cc13c49b9249653d7d8637383f50c2fb87
X-Gerrit-Change-Number: 1729
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1729?usp=email>
X-Gerrit-Commit: 78a52c142ef1f4957c01f932c088fb78e58ac5a7
References: <gerrit.1782252033000.I3f9834cc13c49b9249653d7d8637383f50c2fb87@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMjUyMDMzMDAwLkkzZjk4MzRjYzEzYzQ5YjkyNDk2NTNkN2Q4NjM3MzgzZjUwYzJmYjg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e844503d77730e75c1e4c00f2b7d1836617ea3c6-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wc9Ah-0002Fx-Hv
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0888490814158413377=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0888490814158413377==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YoB8C0OgnbE="; charset=UTF-8

--YoB8C0OgnbE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1729?usp=3Demail

to review the following change=2E


Chang=
e subject: multi: don't let stale-routes-check delete permanent routes
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: don't let=
 stale-routes-check delete permanent routes

When --stale-routes-check is e=
nabled the periodic check removed every
aged entry from the virtual address=
 routing table, including the
permanent routes installed from --iroute (e=
=2Eg=2E via --client-config-dir)
and the client's pushed ifconfig address=
=2E Once those entries were gone,
traffic towards the iroute networks was n=
o longer forwarded and the
affected client suffered an outage until it reco=
nnected=2E

Routes learned from configuration (iroutes and pushed ifconfig
=
addresses) and genuinely dynamic routes (TAP source addresses learned
from =
the data channel) were both added with flags =3D=3D 0, so
check_stale_route=
s() could not tell them apart and aged out all of
them=2E Their last_refere=
nce is only refreshed when they are hit as a
packet destination, which neve=
r happens for an iroute network (CIDR
lookups create a separate cached chil=
d route instead) nor for an idle
client's pushed address, so both were even=
tually deleted=2E

Mark the config-derived routes with a new MULTI_ROUTE_PE=
RMANENT flag in
the two learn helpers that install them, and skip permanent=
 routes in
check_stale_routes()=2E Dynamically learned routes keep flags =
=3D=3D 0
and are still aged out, preserving the documented purpose of the
o=
ption=2E Cleanup on disconnect is unaffected: a halted instance makes
multi=
_route_defined() return false, so the reaper still removes the
permanent ro=
utes when the client goes away=2E

Change-Id: I3f9834cc13c49b9249653d7d8637=
383f50c2fb87
Github: closes OpenVPN/openvpn#1063
Signed-off-by: Antonio Qua=
rtulli <antonio@mandelbit=2Ecom>
---
M doc/man-sections/server-options=2Ers=
t
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
3 files changed, 11 inser=
tions(+), 5 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/29/1729/1

diff --git a/doc/man-sections/server-options=
=2Erst b/doc/man-sections/server-options=2Erst
index eb8e273=2E=2Ec9d29f6 1=
00644
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sections/se=
rver-options=2Erst
@@ -671,6 +671,11 @@
 
   If ``t`` is not present it def=
aults to ``n``=2E
 
+  Only dynamically learned routes are subject to this =
check=2E Routes added from
+  configuration, such as ``--iroute`` entries a=
nd a client's pushed ifconfig
+  address, are never removed by it; they are=
 dropped only when the client
+  disconnects=2E
+
   This option helps to k=
eep the dynamic routing table small=2E See also
   ``--max-routes-per-clien=
t``
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index a957=
fdf=2E=2Eb08ff08 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=
=2Ec
@@ -1191,7 +1191,7 @@
         addr=2Enetbits =3D (uint8_t)netbits;
  =
   }
 
-    struct multi_instance *owner =3D multi_learn_addr(m, mi, &addr,=
 0);
+    struct multi_instance *owner =3D multi_learn_addr(m, mi, &addr, M=
ULTI_ROUTE_PERMANENT);
 #ifdef ENABLE_MANAGEMENT
     if (management && own=
er)
     {
@@ -1236,7 +1236,7 @@
         mroute_addr_mask_host_bits(&addr)=
;
     }
 
-    struct multi_instance *owner =3D multi_learn_addr(m, mi, &a=
ddr, 0);
+    struct multi_instance *owner =3D multi_learn_addr(m, mi, &add=
r, MULTI_ROUTE_PERMANENT);
 #ifdef ENABLE_MANAGEMENT
     if (management &&=
 owner)
     {
@@ -1360,7 +1360,7 @@
     while ((he =3D hash_iterator_next=
(&hi)) !=3D NULL)
     {
         struct multi_route *r =3D (struct multi_r=
oute *)he->value;
-        if (multi_route_defined(m, r)
+        if (multi=
_route_defined(m, r) && !(r->flags & MULTI_ROUTE_PERMANENT)
             &&=
 difftime(now, r->last_reference) >=3D m->top=2Eoptions=2Estale_routes_agei=
ng_time)
         {
             dmsg(D_MULTI_DEBUG, "MULTI: Deleting stale=
 route for address '%s'",
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/=
multi=2Eh
index 3ed08d4=2E=2E22cfeee 100644
--- a/src/openvpn/multi=2Eh
+++=
 b/src/openvpn/multi=2Eh
@@ -237,8 +237,9 @@
     struct mroute_addr addr;
=
     struct multi_instance *instance;
 
-#define MULTI_ROUTE_CACHE   (1 << =
0)
-#define MULTI_ROUTE_AGEABLE (1 << 1)
+#define MULTI_ROUTE_CACHE     (1 =
<< 0)
+#define MULTI_ROUTE_AGEABLE   (1 << 1)
+#define MULTI_ROUTE_PERMANEN=
T (1 << 2) /* config-derived (iroute / pushed ifconfig); never stale-aged *=
/
     unsigned int flags;
 
     unsigned int cache_generation;

-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1729?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3f9834cc13c49b9249653d7d86=
37383f50c2fb87
Gerrit-Change-Number: 1729
Gerrit-PatchSet: 1
Gerrit-Owner: =
ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--YoB8C0OgnbE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1729?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">mu=
lti: don&#39;t let stale-routes-check delete permanent routes<br><br>When -=
-stale-routes-check is enabled the periodic check removed every<br>aged ent=
ry from the virtual address routing table, including the<br>permanent route=
s installed from --iroute (e=2Eg=2E via --client-config-dir)<br>and the cli=
ent&#39;s pushed ifconfig address=2E Once those entries were gone,<br>traff=
ic towards the iroute networks was no longer forwarded and the<br>affected =
client suffered an outage until it reconnected=2E<br><br>Routes learned fro=
m configuration (iroutes and pushed ifconfig<br>addresses) and genuinely dy=
namic routes (TAP source addresses learned<br>from the data channel) were b=
oth added with flags =3D=3D 0, so<br>check_stale_routes() could not tell th=
em apart and aged out all of<br>them=2E Their last_reference is only refres=
hed when they are hit as a<br>packet destination, which never happens for a=
n iroute network (CIDR<br>lookups create a separate cached child route inst=
ead) nor for an idle<br>client&#39;s pushed address, so both were eventuall=
y deleted=2E<br><br>Mark the config-derived routes with a new MULTI_ROUTE_P=
ERMANENT flag in<br>the two learn helpers that install them, and skip perma=
nent routes in<br>check_stale_routes()=2E Dynamically learned routes keep f=
lags =3D=3D 0<br>and are still aged out, preserving the documented purpose =
of the<br>option=2E Cleanup on disconnect is unaffected: a halted instance =
makes<br>multi_route_defined() return false, so the reaper still removes th=
e<br>permanent routes when the client goes away=2E<br><br>Change-Id: I3f983=
4cc13c49b9249653d7d8637383f50c2fb87<br>Github: closes OpenVPN/openvpn#1063<=
br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<=
br>M doc/man-sections/server-options=2Erst<br>M src/openvpn/multi=2Ec<br>M =
src/openvpn/multi=2Eh<br>3 files changed, 11 insertions(+), 5 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/29/1729/1</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/server-opt=
ions=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>index eb=
8e273=2E=2Ec9d29f6 100644</span><br><span>--- a/doc/man-sections/server-opt=
ions=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Erst</spa=
n><br><span>@@ -671,6 +671,11 @@</span><br><span> </span><br><span>   If ``=
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
<br><span>index a957fdf=2E=2Eb08ff08 100644</span><br><span>--- a/src/openv=
pn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@=
 -1191,7 +1191,7 @@</span><br><span>         addr=2Enetbits =3D (uint8_t)ne=
tbits;</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct multi_instance *owner =3D multi_learn_=
addr(m, mi, &amp;addr, 0);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct multi_instance *owner =3D multi_learn_addr(m, mi, &amp;ad=
dr, MULTI_ROUTE_PERMANENT);</span><br><span> #ifdef ENABLE_MANAGEMENT</span=
><br><span>     if (management &amp;&amp; owner)</span><br><span>     {</sp=
an><br><span>@@ -1236,7 +1236,7 @@</span><br><span>         mroute_addr_mas=
k_host_bits(&amp;addr);</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *owner=
 =3D multi_learn_addr(m, mi, &amp;addr, 0);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct multi_instance *owner =3D multi_learn_ad=
dr(m, mi, &amp;addr, MULTI_ROUTE_PERMANENT);</span><br><span> #ifdef ENABLE=
_MANAGEMENT</span><br><span>     if (management &amp;&amp; owner)</span><br=
><span>     {</span><br><span>@@ -1360,7 +1360,7 @@</span><br><span>     wh=
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
/span><br><span>index 3ed08d4=2E=2E22cfeee 100644</span><br><span>--- a/src=
/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><s=
pan>@@ -237,8 +237,9 @@</span><br><span>     struct mroute_addr addr;</span=
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
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I3f9834cc13c49b9249653d7d8637383f=
50c2fb87 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1729 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>

</body></html>
--YoB8C0OgnbE=--


--===============0888490814158413377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0888490814158413377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0888490814158413377==--

