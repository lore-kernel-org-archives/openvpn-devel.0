Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A803C61DB6
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nJH8i5FO7LSUumuTeoOC5fw9WatzihEooFmFxghqM1w=; b=jYywCxAf0xRoVdiDMKQWGvpy0N
	5wROQUcJT5CkHdCXPwn+2iFOzJ8pU+b/givid+frjnXwjgYoSqQOPiglKTOnr+XSrHt4h9k+UvBQe
	UPG17ORQWvocsdxABKzBzgMk+VoZKRM/J30FlwwL1e76FILzoJ6W2XX1GiWrw1alk46s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wylfe-0004C0-7V;
	Tue, 25 Aug 2026 07:34:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wylfd-0004Bq-0P
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:34:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bj9ww8KEpvx7yoLEF7dI8ftXGwQZqULI57xFoVz0R5c=; b=BzYbjUkp9K5cCfX5KzmwPYbEHi
 6EuIwoTr3rOEqbc0QBBYa24U/PiOh/xjtDlHndNe7MPQSiBaEBuuesfXskYKBxMoi9NHrW2SuDTxZ
 dec4x07VOiw10dag5kpcsW/Kmd/GeZR+e3EeH8B2okGk5Gmvt9mpRA0B22hJcQgO9jHY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bj9ww8KEpvx7yoLEF7dI8ftXGwQZqULI57xFoVz0R5c=; b=a
 ZXHe0CCZwbmEWxoeT58mZp6hJE6qPvMrEeqxZisTBQ70UK0gTOa8n3z8KmmbPUpJIFb/9WJaw8FLc
 hdK2nDZqpxQNVZXEFuQNyxNZuy3WD980B/yLVZbWgiKGBdSpP0hmGKp0UdADJS/b/ZyNcjNVf77sC
 8NkXSFjDAR9yUYe0=;
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wylfc-0000SA-KN for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:34:09 +0000
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso7473682a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787643242; x=1788248042; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bj9ww8KEpvx7yoLEF7dI8ftXGwQZqULI57xFoVz0R5c=;
 b=eecdv/77Q8tjKYcqMBCqExACDazUC8EB65jm+GgUgtKxSaH2c1yJuSHGRGPIwMJCu/
 oPxYyPywJ5vevgX34+I5/SXAgksNmfcrm4pvFK4WZKmT23PIOV51jhC4e/S3t9uso+pQ
 eTxvu/hUpWA6jAwuQPTfrmQNLUUEz9vBCyv0MU2VcgP98k1FBNwgE5lazDHUFO9HuCLW
 ZHPRo0uKQ4Y5te7RrcpWG6o2qfeHnMKwl3M+V3RhFnnnR2eKhR6JQN2gE/ZpQvl9QjT6
 fYHS7Fv/4t2zYhCSB5Q7VH52Vb1wqHPQBp08IpwvvkaWmmr5iOZ032GBWe1XIGZtjzN+
 h/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787643242; x=1788248042;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bj9ww8KEpvx7yoLEF7dI8ftXGwQZqULI57xFoVz0R5c=;
 b=mzNmieVFWhvF6k1nb5UsZo9pGrFb0QDjKS7sNssFnUXevR2GQn6gQVTiwTgLzYDowD
 NEsMMRfzHI+zS05XXiYlYt2zNWosXbcGFEXlh8JowIkv4wKWCoTOQzlVInm3S6vUKtNs
 aln1z1fuAnHBLzvHIhd00j2k0C2eMaS4e6x0DfUZ6v1xptPJNaqrjQoab9/cGXsrJE37
 +AiRxY0UyQ0xPVrPlOL7JzRAAY/3eK4p6UcLuxyR2XmQxhG/Rao+anvVAT7dCJjEykLF
 RiQMkpLUdVkFwgKeR/m+L6nbFDiYtYoKoCJpAHJ3UACTOXa9XBIFhe4Ph/nccVV4bm9j
 iO2w==
X-Gm-Message-State: AFuF++ltZTxAoDQ8c/JckJxVBkw6bWU5JeCSv/8ItigRrwi+paYZbwBL
 eIdf5xD/vIG+wAXBt8wZp1wYNMCZ15TD6frEfBvI/5mHQgDdBA552kU/zBrO7Vf+t19D3m8miJl
 ysNejw+X6Oj1oELZ22SY2OCZaXFtU3k4KJOl8qd5nD28mx6yPwAUhS4+rAuHPPQd7tKvfSoocB7
 EI1HZNjw==
X-Gm-Gg: AR+sD12RCutSCsZ4hOt0sJLghF3MLQv+78HflduWlhuDw2GpV8OQfP4hbCNHpzWB3mI
 kk9HBNHtrdMXkPpLe94nIb0jf0uT0ZpcTfBcMrPZBTegWH7VB2uqvS1eMOOJDIK+heX2V1QXT+H
 TWnUCzlYfAUB4nDW/nWMQYuDadSRwaRfaR9HKio+iT40LhZWjySX2FX2pHOWhvLo95JnQcQkmoP
 XOOZGL8rv9dxFacZc17VfbFnkrBNX4UxnutpOsjzmOonQgTzJzEAXEiZ6v/TG1lzvt2DvS6XAEk
 Rpzp9Mi7dfm5juGnkZTiT+sZVzSpCMfLun7FkT8guk0UtUav8tR4udFiAF45DaViONxzy4npKML
 mPMgQ5xY1OPjUSQLk7Xr9MIJmLxIbcIj/ma3nrRb1GifTM7tpzUxqjGU3GPFfHJUKQqLuz65nuf
 p/KCrm91v1EepT0vfdoPAlIklqE7aesWYBnef00VAgoorOhMqrYjnaU+etFL25m9rAxvHtTMDt7
 mFv/L56S8RDeZiL3p7pAuc/7SXICpqchu3/Pxu7kDvD8uzOWizUaAnLYWlhoxJwG9nICEc6QyVr
 A3vjB50mrYOhrRs3auIsmpSnpoBt4gbzZDcUVOGN7/dFRLOr3j4=
X-Received: by 2002:a17:907:948b:b0:c15:f4bb:e663 with SMTP id
 a640c23a62f3a-c24e5a50b56mr464550666b.10.1787643241889; 
 Tue, 25 Aug 2026 00:34:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa97sm1465843966b.57.2026.08.25.00.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:34:01 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 07:33:59 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9
X-Gerrit-Change-Number: 1865
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1865?usp=email>
X-Gerrit-Commit: 47ec9ef53cfaaaa119724bfb03d152b5f98bd269
In-Reply-To: <gerrit.1787570563000.Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9@gerrit.openvpn.net>
References: <gerrit.1787570563000.Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLklkZmE3ODY0M2RhMjdmZThhOGJkMGZmMmJjZjMwMjVkODY4NzAyNGE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <47a05726031932834b0430cfe245c2d6983ebee1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wylfc-0000SA-KN
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: Remove unused
 function print_routes
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2443793622582190950=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2443793622582190950==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pk7WKJawrog="; charset=UTF-8

--pk7WKJawrog=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1865?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: route: Remove unused function print_routes
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: Remove un=
used function print_routes

This function has never been used in the git hi=
story=2E
Probably an OpenVPN 1=2Ex remnant=2E

Identified by cppcheck=2E

C=
hange-Id: Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9
Signed-off-by: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <gert@greenie=2E=
muc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1865
Messa=
ge-Id: <20260824161431=2E1639-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38636=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
route=2Ec
M src/openvpn/route=2Eh
2 files changed, 0 insertions(+), 36 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/65/1865/2

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
in=
dex 8ea745d=2E=2E6dbe3ec 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openv=
pn/route=2Ec
@@ -185,19 +185,6 @@
     dest->gc =3D a;
 }
 
-static const c=
har *
-route_string(const struct route_ipv4 *r, struct gc_arena *gc)
-{
-  =
  struct buffer out =3D alloc_buf_gc(256, gc);
-    buf_printf(&out, "ROUTE=
 network %s netmask %s gateway %s", print_in_addr_t(r->network, 0, gc),
-  =
             print_in_addr_t(r->netmask, 0, gc), print_in_addr_t(r->gateway=
, 0, gc));
-    if (r->flags & RT_METRIC_DEFINED)
-    {
-        buf_print=
f(&out, " metric %d", r->metric);
-    }
-    return BSTR(&out);
-}
-
 stat=
ic bool
 is_route_parm_defined(const char *parm)
 {
@@ -1325,27 +1312,6 @@
=
 #endif /* ifndef ENABLE_SMALL */
 
 static void
-print_route(const struct =
route_ipv4 *r, msglvl_t msglevel)
-{
-    struct gc_arena gc =3D gc_new();
=
-    if (r->flags & RT_DEFINED)
-    {
-        msg(msglevel, "%s", route_s=
tring(r, &gc));
-    }
-    gc_free(&gc);
-}
-
-void
-print_routes(const st=
ruct route_list *rl, msglvl_t msglevel)
-{
-    struct route_ipv4 *r;
-    =
for (r =3D rl->routes; r; r =3D r->next)
-    {
-        print_route(r, msg=
level);
-    }
-}
-
-static void
 setenv_route(struct env_set *es, const st=
ruct route_ipv4 *r, int i)
 {
     struct gc_arena gc =3D gc_new();
diff --=
git a/src/openvpn/route=2Eh b/src/openvpn/route=2Eh
index 88107e9=2E=2Ebae8=
659 100644
--- a/src/openvpn/route=2Eh
+++ b/src/openvpn/route=2Eh
@@ -377,=
8 +377,6 @@
 
 #endif
 
-void print_routes(const struct route_list *rl, msg=
lvl_t msglevel);
-
 #ifdef _WIN32
 
 void show_routes(msglvl_t msglevel);

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1865?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idfa78643da27fe8a8=
bd0ff2bcf3025d8687024a9
Gerrit-Change-Number: 1865
Gerrit-PatchSet: 2
Gerri=
t-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <ger=
t@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--pk7WKJawrog=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1865?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">route: Remove unused funct=
ion print_routes<br><br>This function has never been used in the git histor=
y=2E<br>Probably an OpenVPN 1=2Ex remnant=2E<br><br>Identified by cppcheck=
=2E<br><br>Change-Id: Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1865<br>Message-Id: &lt;20260824161431=2E1639-1-gert=
@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg38636=2Ehtml<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Ec<br>M sr=
c/openvpn/route=2Eh<br>2 files changed, 0 insertions(+), 36 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/65/1865/2</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/o=
penvpn/route=2Ec</span><br><span>index 8ea745d=2E=2E6dbe3ec 100644</span><b=
r><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=
=2Ec</span><br><span>@@ -185,19 +185,6 @@</span><br><span>     dest-&gt;gc =
=3D a;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static const char *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-route_string(const struct route_ipv4 *r, struct gc_aren=
a *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct buffer out =3D alloc_buf=
_gc(256, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_=
printf(&amp;out, &quot;ROUTE network %s netmask %s gateway %s&quot;, print_=
in_addr_t(r-&gt;network, 0, gc),</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-               print_in_addr_t(r-&gt;netmask, 0, gc), print_in_a=
ddr_t(r-&gt;gateway, 0, gc));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        buf_printf(&amp;out, &quot; metric %d&quot;, r-&gt;=
metric);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return BSTR(&amp;out);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool</span><br><sp=
an> is_route_parm_defined(const char *parm)</span><br><span> {</span><br><s=
pan>@@ -1325,27 +1312,6 @@</span><br><span> #endif /* ifndef ENABLE_SMALL *=
/</span><br><span> </span><br><span> static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-print_route(const struct route_ipv4 *r, msglvl_t=
 msglevel)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (r-&gt;fl=
ags &amp; RT_DEFINED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msgl=
evel, &quot;%s&quot;, route_string(r, &amp;gc));</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-print_routes(const struct route_list *rl, msglv=
l_t msglevel)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct route_ipv4 *r;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (r =3D rl-&gt;ro=
utes; r; r =3D r-&gt;next)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pri=
nt_route(r, msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static void</span><br><span> setenv_route(struct env_set=
 *es, const struct route_ipv4 *r, int i)</span><br><span> {</span><br><span=
>     struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/src/ope=
nvpn/route=2Eh b/src/openvpn/route=2Eh</span><br><span>index 88107e9=2E=2Eb=
ae8659 100644</span><br><span>--- a/src/openvpn/route=2Eh</span><br><span>+=
++ b/src/openvpn/route=2Eh</span><br><span>@@ -377,8 +377,6 @@</span><br><s=
pan> </span><br><span> #endif</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void print_routes(const struct route_list *rl, ms=
glvl_t msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> #ifdef _WIN32</span><br><span> </span><br><span> void show_ro=
utes(msglvl_t msglevel);</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1865?usp=3Demail">cha=
nge 1865</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1865?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1865 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--pk7WKJawrog=--


--===============2443793622582190950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2443793622582190950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2443793622582190950==--

