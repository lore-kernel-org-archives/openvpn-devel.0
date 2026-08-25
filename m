Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA91C5DF94
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=57Z2juxj3Zv8JAWUt2CUzqjwU5ghprpSP9Zozd27rMw=; b=XbNobUKJblYG4YCnsbh6dOOw1o
	um9ZIGomNwW4mAH3EIMAntGFH6vHbpXy4Ipkp4gClbUpDdqxW55RyJCg7gbrBjervWB48vW3EKOvz
	o/tXqWa+KS8OWMokaqvot9wLsCvlWR8wm6QSJP+d3ihs7liBQmdtK/1dQmyFGHO0CKVk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wylfh-00049i-7b;
	Tue, 25 Aug 2026 07:34:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wylff-00049b-CA
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:34:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XahXry2R1DUD3AaWfGvQuIMEjqL1KuR3Q5Pi1ytkza4=; b=DiU5lTW5KqvFX5wAKwf2wFafcT
 Ylu7WGAIFUnrbLdO32O9MmAOv3NyFMUSU4rQGfizBSd4GKjoecnigt5oQsHI/QEcYnoiC5JmaSDlB
 4FfLy0oYJYbEPGKXucAS5X+p8XmHRriv/JxmpzcXGRM0IJr2I/mlXvITOta619xrTwoM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XahXry2R1DUD3AaWfGvQuIMEjqL1KuR3Q5Pi1ytkza4=; b=j
 hfITsxpuHe68DrvEY0B8REw9S0abhIPrN0an/xPieoMBU8Opta3gNYo/5Qi2TvFoue3OBiDk3Ka4Z
 DJ75NffZIwOLobL7j/ZeivdFxcdREpj6df99MBQMQZq83zr6dAVdowqkaB49wxLqTacmNpcSYSz3z
 ACby98IoPe4jcpbw=;
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wylfd-0000SC-Qu for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:34:11 +0000
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6a082b3671fso7163031a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787643243; x=1788248043; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XahXry2R1DUD3AaWfGvQuIMEjqL1KuR3Q5Pi1ytkza4=;
 b=EMxdb98eY18eYCjzFt2xWB9F1TPVB3UAT0i2JrImfXDGF2DFH8IE1ozscxXh8WLEmn
 hgAPF/D4C2b+I+0+EmcUITZTcPfqvlbePVQGTvprZ1At8M6ZobWy9jvP1cI15ejhl+5l
 Zdb/8EPRZt7UM7NPOBE7I8v+2odpMIOr+hYseQVV9Qm8JWb9yZYKQOGVlOm46ORHjKVY
 gYcBUtmm7k+hzYTO8UB4ZfmXMa708FfiwDqwgOVKjqAZ4EGRgaSVOSitwBnCEPIsRwZZ
 yLLQmb4tOy8TdEs+3PgfCGN3luxabFtLFRog8SoY42H9QYpbxuXE5GvDQyn2X77egcyG
 3Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787643243; x=1788248043;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XahXry2R1DUD3AaWfGvQuIMEjqL1KuR3Q5Pi1ytkza4=;
 b=DgqZhNXNWvc0K2st7yMvvjPpT5ZkhbpSYDMiL8+xqotXDS8CpgLb6+OM8iPD+Be1xn
 gF7v4axNBh3uaWBrmDvGyJLSWFNwvQ8nWW82YBSi7QtBhd4aARUvZvb5BS5l6aCn6XSm
 PScewwaXCCUjNLubGKCZCK9PjCi1vVfAVRmjvHh7hHvQ+vX6C3pg7M2NCms01xtx8FHP
 1vJX51KvqIdK+zbRFvY9DAXxqeHR6yKpVtG7y3ykQHIPjbHTyWITIDnko79X6sSf8/06
 YhLeCKTqLQC/PH2HafPuk4PvlHL9yTAVb/bshBcFoHhWIq58cTPjXafbpcJKzQbynAu+
 EaOA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro93Tl3yES3XMr9zVRrVB4NeygZWcYEakF+quEWxEe7dGsjSyXeTosLxj/Sa/sIHTYABxabZtfMoBwdH/hy@lists.sourceforge.net
X-Gm-Message-State: AFuF++mB1E7n63NGrjSluzx+wVXRPE5+up+POvhNuBjV9ifeYN7Ny9Gk
 cxLcBEccn8QN5b+8MaV9JMWpdikFtCijEM6m+cbLjic8D3FByGasHOI4lxUxAMsymMZhKtai1N9
 6hAyoSWEeBZebfguUrXi8dkFZh5VPqzEmnD8VZd4D8nWxifAN+QSi6by5YhD8YyNRqBn1
X-Gm-Gg: AR+sD11y1VRSdHq5vJN2xsHAUWoLTRiN7+CVe+8CFZ5WhK6TMp1z7Pqj7GEu3nVFZ2r
 9nRWW3aXAq+6ZckBVKC8+z1GTRPRaBX9hatXUm5GXbDug6dNvvtLmZCzCNsTk3KnLt6hrWoYHMA
 MQDCkHxpwoV711Lvbski/ostRVqsHXJo+fzAhAXfWPJ/4Zf8TVOOrCxh+h/bS0/1OwWHJWC21Zx
 GfG1bmhu+aSl+/nGxGFfe7QCuReDcuHuaAz4skcMbZkschgsONCAIz/KaTy339Fz7r8zj6Zruz8
 I4QDQhel8zk+YEY4hPUm2EZzPitMWzi1gpFoJZpHQr2zI97XAb/kUSBqeJgolmSPGW2lLIy5ERz
 JCMuQk/e9Qc697aiu9/DdR+5GnNeCGHYp+F9g+oP/GjJNLDAtNXDS3AOONSMPkZ0I3MJU6geb5C
 l+NorfAcN0rwyLsa3od4wiM2DHczYUJfil91Q9cpMYfx1et5/ncKLgl3ph/XponzUJbasX5M0X7
 p9ac/pnM3mREpmsiBvuMJ3dQiSKs2s38p2RWVFYUeyTSSzn3+FLy8cEW2WpDXdlwz/ZwCKt/CiK
 bIas4qe2tNuMusRWt/7rD2fx5cmSD/97O0L9DBKCiSzqZ7QRRtY=
X-Received: by 2002:a05:6402:27d0:b0:6a1:2efd:8687 with SMTP id
 4fb4d7f45d1cf-6a42f20afd9mr33706681a12.14.1787643243026; 
 Tue, 25 Aug 2026 00:34:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e012f84sm18262252a12.8.2026.08.25.00.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:34:02 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 07:34:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9
X-Gerrit-Change-Number: 1865
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1865?usp=email>
X-Gerrit-Commit: 47ec9ef53cfaaaa119724bfb03d152b5f98bd269
In-Reply-To: <gerrit.1787570563000.Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9@gerrit.openvpn.net>
References: <gerrit.1787570563000.Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLklkZmE3ODY0M2RhMjdmZThhOGJkMGZmMmJjZjMwMjVkODY4NzAyNGE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <47a05726031932834b0430cfe245c2d6983ebee1-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wylfd-0000SC-Qu
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4869871581958036984=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4869871581958036984==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xJMzLbbQNDE="; charset=UTF-8

--xJMzLbbQNDE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1865?usp=3Demail )

Change subject: route: Remove unused function print=
_routes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

rout=
e: Remove unused function print_routes

This function has never been used i=
n the git history=2E
Probably an OpenVPN 1=2Ex remnant=2E

Identified by cp=
pcheck=2E

Change-Id: Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9
Signed-off-=
by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1865
Message-Id: <20260824161431=2E1639-1-gert@greenie=2Emuc=2Ede>
URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
38636=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M sr=
c/openvpn/route=2Ec
M src/openvpn/route=2Eh
2 files changed, 0 insertions(+=
), 36 deletions(-)




diff --git a/src/openvpn/route=2Ec b/src/openvpn/rou=
te=2Ec
index 8ea745d=2E=2E6dbe3ec 100644
--- a/src/openvpn/route=2Ec
+++ b/=
src/openvpn/route=2Ec
@@ -185,19 +185,6 @@
     dest->gc =3D a;
 }
 
-stati=
c const char *
-route_string(const struct route_ipv4 *r, struct gc_arena *g=
c)
-{
-    struct buffer out =3D alloc_buf_gc(256, gc);
-    buf_printf(&ou=
t, "ROUTE network %s netmask %s gateway %s", print_in_addr_t(r->network, 0,=
 gc),
-               print_in_addr_t(r->netmask, 0, gc), print_in_addr_t(r=
->gateway, 0, gc));
-    if (r->flags & RT_METRIC_DEFINED)
-    {
-        =
buf_printf(&out, " metric %d", r->metric);
-    }
-    return BSTR(&out);
-=
}
-
 static bool
 is_route_parm_defined(const char *parm)
 {
@@ -1325,27 +1=
312,6 @@
 #endif /* ifndef ENABLE_SMALL */
 
 static void
-print_route(cons=
t struct route_ipv4 *r, msglvl_t msglevel)
-{
-    struct gc_arena gc =3D g=
c_new();
-    if (r->flags & RT_DEFINED)
-    {
-        msg(msglevel, "%s"=
, route_string(r, &gc));
-    }
-    gc_free(&gc);
-}
-
-void
-print_routes=
(const struct route_list *rl, msglvl_t msglevel)
-{
-    struct route_ipv4 =
*r;
-    for (r =3D rl->routes; r; r =3D r->next)
-    {
-        print_rou=
te(r, msglevel);
-    }
-}
-
-static void
 setenv_route(struct env_set *es,=
 const struct route_ipv4 *r, int i)
 {
     struct gc_arena gc =3D gc_new()=
;
diff --git a/src/openvpn/route=2Eh b/src/openvpn/route=2Eh
index 88107e9=
=2E=2Ebae8659 100644
--- a/src/openvpn/route=2Eh
+++ b/src/openvpn/route=2E=
h
@@ -377,8 +377,6 @@
 
 #endif
 
-void print_routes(const struct route_lis=
t *rl, msglvl_t msglevel);
-
 #ifdef _WIN32
 
 void show_routes(msglvl_t ms=
glevel);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1865=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idfa78643da27=
fe8a8bd0ff2bcf3025d8687024a9
Gerrit-Change-Number: 1865
Gerrit-PatchSet: 2
=
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2=
 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--xJMzLbbQNDE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1865?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">route: Remove unused function print_routes=
<br><br>This function has never been used in the git history=2E<br>Probably=
 an OpenVPN 1=2Ex remnant=2E<br><br>Identified by cppcheck=2E<br><br>Change=
-Id: Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@=
greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1865<br>Message-Id: &lt;20260824161431=2E1639-1-gert@greenie=2Emuc=2E=
de&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourc=
eforge=2Enet/msg38636=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Ec<br>M src/openvpn/route=
=2Eh<br>2 files changed, 0 insertions(+), 36 deletions(-)<br><br></pre>
<pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>=
index 8ea745d=2E=2E6dbe3ec 100644</span><br><span>--- a/src/openvpn/route=
=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -185,19=
 +185,6 @@</span><br><span>     dest-&gt;gc =3D a;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static co=
nst char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-route_strin=
g(const struct route_ipv4 *r, struct gc_arena *gc)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;ROUTE ne=
twork %s netmask %s gateway %s&quot;, print_in_addr_t(r-&gt;network, 0, gc)=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               print=
_in_addr_t(r-&gt;netmask, 0, gc), print_in_addr_t(r-&gt;gateway, 0, gc));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (r-&gt;flags &am=
p; RT_METRIC_DEFINED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_prin=
tf(&amp;out, &quot; metric %d&quot;, r-&gt;metric);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return BSTR(&amp;out);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> static bool</span><br><span> is_route_parm_defined(const=
 char *parm)</span><br><span> {</span><br><span>@@ -1325,27 +1312,6 @@</spa=
n><br><span> #endif /* ifndef ENABLE_SMALL */</span><br><span> </span><br><=
span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-prin=
t_route(const struct route_ipv4 *r, msglvl_t msglevel)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (r-&gt;flags &amp; RT_DEFINED)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;%s&quot;, route_str=
ing(r, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pri=
nt_routes(const struct route_list *rl, msglvl_t msglevel)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct route_ipv4 *r;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    for (r =3D rl-&gt;routes; r; r =3D r-&gt;next)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        print_route(r, msglevel);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void<=
/span><br><span> setenv_route(struct env_set *es, const struct route_ipv4 *=
r, int i)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc=
_new();</span><br><span>diff --git a/src/openvpn/route=2Eh b/src/openvpn/ro=
ute=2Eh</span><br><span>index 88107e9=2E=2Ebae8659 100644</span><br><span>-=
-- a/src/openvpn/route=2Eh</span><br><span>+++ b/src/openvpn/route=2Eh</spa=
n><br><span>@@ -377,8 +377,6 @@</span><br><span> </span><br><span> #endif</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void =
print_routes(const struct route_list *rl, msglvl_t msglevel);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN32</sp=
an><br><span> </span><br><span> void show_routes(msglvl_t msglevel);</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1865?usp=3Demail">change 1865</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1865?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: Idfa78643da27fe8a8bd0ff2bcf30=
25d8687024a9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1865=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>

</body></html>
--xJMzLbbQNDE=--


--===============4869871581958036984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4869871581958036984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4869871581958036984==--

