Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAAFCDB470
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MkEDZCF+o20xs5c4C5AElrOx8P1AXSz0XDjaZpAmhb0=; b=iifTBpzb2N9GS0LckpO6jfeMLr
	Vw9FPYTPsm5zzRedci3SKBlFUYrox3zSZAO9WDVhnr3OHYX9m8bY0vtWc0yQS4U3NYR+5gsulBd8s
	YUpUT/BU0jR5q0pjdTu5hW2JBLfYTZVX6jLrs5zehyAMoU36XlPvPV9emAhdRhx1yhqM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbfr2-0005D6-PZ;
	Mon, 22 Jun 2026 14:42:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbfr1-0005Cy-TR
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:42:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JtEulRygegCDS4fSDLmS6dGEvXGg8K9L+EMZZvbFTWY=; b=F8ZyQSkMcFayfoAIWn9gB/lRYT
 NqrQjOQGMUxoMCQ0Hbga4oo/GQCFPUZswBrW7el+tPkf+m5vltQ/KJoRpaLLDDLIS59i9IZiyR8JV
 VNlUQUoBVEOJcpHsj6kYnz8JvCgYEGZ19Jv8UR7iYWgeGInjjDfe6JZaDDORba7EysSc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JtEulRygegCDS4fSDLmS6dGEvXGg8K9L+EMZZvbFTWY=; b=b
 qIE3PY5EBLddRbX+OG53Q0Ih1hRKkTbxwCT/mTrx8DbdxZ62xTOaUiae8rSJ++qby+G4tG9hmC6WE
 SlTApHc6/KOZHB/qNS/fEOplG87WEQP6CWNXP5jgUvpiRRjTlF23tkcyoW+JwVKQebRTkOtTnb6ax
 Ui+JyzpF/Vqr3+pk=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbfqz-00054e-Ju for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:42:27 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49241896317so16006765e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782139334; x=1782744134; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JtEulRygegCDS4fSDLmS6dGEvXGg8K9L+EMZZvbFTWY=;
 b=LPxE6PVc+PqYaoI3VNxg2JvOrj5TTuOKNtRg/riPkffpjQRTGm6KV7Te8A0CpkAv8Z
 mhmqkCAt81+JPs3Rkc2mW4MKngh+HyHuoa6t1y+RywJR8v49lconr05iBzAYDhXmQBJt
 Z6jyMXgis9ufAYGQ/CXAv6lcDTgyyIBYZIH9zvf8e1pUPH3QjOhOEBeQkyELheCOTPcZ
 aA3lVYw09eJmnFZFv018E8ZNGpsakEvs4NBQBmzBqUVQY1ZHAuHomsEqN7/YxhIUhrp6
 rktEptNkdvdPAxPDdzyUpDMBe+G6dmDUja3e6bQYtMtcBbIXU6b7B49lAuU1WlUZr7P4
 sbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782139334; x=1782744134;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JtEulRygegCDS4fSDLmS6dGEvXGg8K9L+EMZZvbFTWY=;
 b=rX00RcYy09dEJhQh+zg+OohcFInviYRN55yrwv88ApV+l6AkGw1jjGZcF5gb0lRC8S
 +1TcnOGgmKnVPDLLgWGGmPuZ1Ak2ufD4BFgGJFj0qKKPhfRxWXf+ry9FR5wt7N7ToY0j
 LdVaOCj7n1sC+S3DnOM00Tv7kP1Oq1VTILKaIqPT0/oTLSHvPNX4vTJdKris9rHVoa77
 rEF4ooXs2pjI+xKVnVf7TvyEBGnGdW3RYQpH+S3t7BD4/lGrQGHOdMVpxAbBTCUcTCNj
 LRO9AQWkrhYLkcn5myv4mXPM7l8b3fQkg2hw+TzTC4N4Fcj8d/XNqfAlcTDzKWRZgb9c
 Iemw==
X-Gm-Message-State: AOJu0Yz8ec4O9m8kHJMOkE+CcH0J2TszVXMjM8WC67PD+Fw1o5CE/ziP
 M1ZQrpT6qyZEFdw6dOuYfpwspNVcbx3zflkbQvQlFBOQ/4jxw1o4LKi3LBFX/3/O0Nu54EZTCKD
 wXGY4s8DvovZX3vF6cXmBtfwD6OTU3XjjfJD4EFkJBobh5OycIpR/7ENq+6BNrppDU7j2
X-Gm-Gg: AfdE7cmjs5cN8525vQM0zAozoZRwTfrMkPQqP4ZMpe/ii3TdardIMsp+7Y+vHL0HSnR
 3fbHic5TVZze3E6xtQ3xMaMF8thaTrtNUZM+WJX6UQbU/JIwUo0AaLGePlSW84fXrcm7xr/arlq
 ClZsPkYhnH7Oj33J2qDSGJAQVMsnszGd8ke2oBYjK9Vi1lA1NWsyVLWiI8l8uNmVPtTkq8zF/s1
 DYvR0M031zHhJA/vcYNWrU+awy8kF6d67A/xpqc9zKtd4pbNxbbASkHAWMz+cze6I0tl9ilNh2R
 2PMrBGLw/vf0bqgPDXPEIZxT9uUHm3p1AMdq57W8szdc3n+bNMBpow436ExU9xDfSlAhEmI9sG8
 DUkyg1C3IGEUmmdKZ7yE6bCiZR0TV7btbLkRt03zin34kwYQF1rYge8H3lqcy71BsC53EZHs28B
 kAlWqdgJtWppeE3PHb5Ay8enOBXmx+5PByGZ01xRxb7kJ+IEg7Uil0jcDXH/GVsylRJ6tzCrbOt
 ICX+slY6a0owk46sXF8jGTzCvVCRAlsRMmlqA16a9M+s1mb+9anJFzfZkJeIVcmAQiHQObVFLQY
 zcPPjiaSdqPopw==
X-Received: by 2002:a05:600c:c088:b0:492:2e1c:1d19 with SMTP id
 5b1f17b1804b1-4923f597776mr230405975e9.31.1782139334391; 
 Mon, 22 Jun 2026 07:42:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff821aasm320333685e9.12.2026.06.22.07.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 07:42:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 14:42:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
X-Gerrit-Change-Number: 1715
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1715?usp=email>
X-Gerrit-Commit: 97ec63372ab354ad48c89e73d1e37715679370ba
In-Reply-To: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
References: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMDc3MTAzMDAwLkk0OWIzN2I1YTkwNTU0ZmEyZDRhODNjOGZjNTYwOGRhZDJhMzZiODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f2f1d2e1603e7b88d946969b7388bf3914c32a74-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbfqz-00054e-Ju
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: fix
 use-after-free of DNS options on client connect
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1378108371482151092=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1378108371482151092==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OlHGZuek91k="; charset=UTF-8

--OlHGZuek91k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by plai=
sthos


Change subject: options: fix use-after-free of DNS options on clien=
t connect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
ptions: fix use-after-free of DNS options on client connect

struct dns_opt=
ions embeds its own gc_arena=2E When inherit_context_child()
/inherit_conte=
xt_top() copy struct options by value, the child shares the
parent's DNS ar=
ena=2E options_detach() detached o->gc but not
o->dns_options=2Egc, so pre_=
connect_restore()'s gc_free() (and context
teardown) freed allocations the =
parent still referenced=2E

With one or more non-pushed --dhcp-option direc=
tives that yield a DNS
entry, a connecting client triggers this and the ser=
ver crashes
(use-after-free in setenv_dns_options(), reported as a double f=
ree)=2E

Detach o->dns_options=2Egc as well, mirroring the existing o->gc h=
andling=2E

Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
GitHub: cl=
oses openvpn/OpenVPN#1060
Signed-off-by: Antonio Quartulli <antonio@mandelb=
it=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715
Message-Id: <20260622120856=
=2E21586-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg37230=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/options=2Ec
1 file chan=
ged, 11 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/15/1715/4

diff --git a/src/openvpn/optio=
ns=2Ec b/src/openvpn/options=2Ec
index 8012192=2E=2Ef414024 100644
--- a/sr=
c/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1531,7 +1531,18 @@
=
 void
 options_detach(struct options *o)
 {
+    /* The options struct carr=
ies two gc_arena's (one generic and one specific
+     * to the DNS setting=
s), which the by-value options
+     * copy in inherit_context_child()/inhe=
rit_context_top() shares with the
+     * source=2E
+     *
+     * Detach =
both (i=2Ee=2E re-initialize them), otherwise child's call of
+     * gc_fr=
ee() (or context teardown) would free allocations the source
+     * contex=
t still references, leading to a use-after-free (and subsequent
+     * dou=
ble-free)=2E
+     */
     gc_detach(&o->gc);
+    gc_detach(&o->dns_option=
s=2Egc);
     o->routes =3D NULL;
     o->client_nat =3D NULL;
     clone_p=
ush_list(o);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1715?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I49b=
37b5a90554fa2d4a83c8fc5608dad2a36b835
Gerrit-Change-Number: 1715
Gerrit-Pat=
chSet: 4
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: cro=
n2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--OlHGZuek91k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by ordex=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">options: fix use-after-free o=
f DNS options on client connect<br><br>struct dns_options embeds its own gc=
_arena=2E When inherit_context_child()<br>/inherit_context_top() copy struc=
t options by value, the child shares the<br>parent&#39;s DNS arena=2E optio=
ns_detach() detached o-&gt;gc but not<br>o-&gt;dns_options=2Egc, so pre_con=
nect_restore()&#39;s gc_free() (and context<br>teardown) freed allocations =
the parent still referenced=2E<br><br>With one or more non-pushed --dhcp-op=
tion directives that yield a DNS<br>entry, a connecting client triggers thi=
s and the server crashes<br>(use-after-free in setenv_dns_options(), report=
ed as a double free)=2E<br><br>Detach o-&gt;dns_options=2Egc as well, mirro=
ring the existing o-&gt;gc handling=2E<br><br>Change-Id: I49b37b5a90554fa2d=
4a83c8fc5608dad2a36b835<br>GitHub: closes openvpn/OpenVPN#1060<br>Signed-of=
f-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1715<br>Message-Id: &lt;20260622120856=2E21586-1-g=
ert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg37230=2Ehtml<br>Signed-off-by: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/options=2Ec<br=
>1 file changed, 11 insertions(+), 0 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/171=
5/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec<=
/span><br><span>index 8012192=2E=2Ef414024 100644</span><br><span>--- a/src=
/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><b=
r><span>@@ -1531,7 +1531,18 @@</span><br><span> void</span><br><span> optio=
ns_detach(struct options *o)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* The options struct carries two gc_arena&=
#39;s (one generic and one specific</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * to the DNS settings), which the by-value options</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * copy in inherit_=
context_child()/inherit_context_top() shares with the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * source=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * Detach both (i=2Ee=2E re-initialize them), otherwi=
se child&#39;s call of</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * gc_free() (or context teardown) would free allocations the source=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * context stil=
l references, leading to a use-after-free (and subsequent</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * double-free)=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span>     gc_de=
tach(&amp;o-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_detach(&amp;o-&gt;dns_options=2Egc);</span><br><span>     o-&gt;rou=
tes =3D NULL;</span><br><span>     o-&gt;client_nat =3D NULL;</span><br><sp=
an>     clone_push_list(o);</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?usp=3Demail">=
change 1715</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1715?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1715 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex=
 &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html=
>
--OlHGZuek91k=--


--===============1378108371482151092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1378108371482151092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1378108371482151092==--

