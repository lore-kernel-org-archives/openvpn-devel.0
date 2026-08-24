Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FE6C61DB4
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=MKJdzyrPAHm8nOYGG/tbq5FPryYdj+fRsTrs82tRc2g=; b=Amc9+yEnctPmU2
	H8hCYZuBzDcY2eW4yK3vIv5ZPnWadcrZJAKdOcGW2HsznXviCvh/G8DbM0bJBXP1+LXq2t/T/FcHX
	3qmzNis+oJG0PgnRbm92eS3wmSj9lGD3yml2XSofkRXZGm75hn7R+ijsi8uhVl4PYrYiVMjVVrKC+
	1c4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wySm1-0005J0-Lp;
	Mon, 24 Aug 2026 11:23:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wySm0-0005Io-5l
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c74y44aquysns7D3IFnmY2o5E2KHuxOsToU/aMzWTxI=; b=TWwcGDOkisEkLmg6SHFfizumh1
 /FCINxtSBoj/K0scKyvUVl0QxfpnylegtsvoWf9/n80WgzvdvhDDYxWT4RjCCxBTsEPD7JvxQX/VY
 WzOggSgyrTwWnO0dKS/L1uAeiwP5Hu6XQwC0kdk7tQnE3PjTBXr+1PdZXVAhAR2ne31U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=c74y44aquysns7D3IFnmY2o5E2KHuxOsToU/aMzWTxI=; b=g
 zRT/J1rpO1sHM8pZ7tdVdv6q1Bvs2XB2SA5QjLL/Y0pxLX5yVQkcYOa814dDGH2TRZux7bkoLcoOP
 Zcu8AEVqs4+1Of5LorK3sE68Bp7X2vZXzEkfvYTCzWcyJ9eQmuaOGcQsyhpp2MtLPcrdJ8cH8vTdo
 Ad76xc5OUaOHesY8=;
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySlz-0006z2-6H for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:28 +0000
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6a378f90555so5314710a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 04:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787570600; x=1788175400; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c74y44aquysns7D3IFnmY2o5E2KHuxOsToU/aMzWTxI=;
 b=EoT1Z3EVi43Q41KbNFOj6vKQ/jJOfN6IFqw0m3MxkohAdxDx0FVAL23KtgnXThyQex
 ZT5DxUTaYPo+2xPeECfnnXkksrSHJfPyJiea/SkOA2/VVPHrfXVg02qjdoC+tIN7A7GB
 K1P5AS8GN9p+XiFy9QC+1fYmbsmESfgZBuB/sN/WZl+wUqJN1c60HMb1+9UVbr17KTSD
 c1a8X+1DPvf/WQGevinJvV6tKHkQcb/LAkbDeKIk3Qoa6eLnuA9lE5mpSI34RzF83jgf
 Vc/bjcKuYJjTGusLWr7MQ/l/MiaM40fFaZjXIrOUpz508MyoIDddvpKIkFJIaBhhO7Pg
 BS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570600; x=1788175400;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c74y44aquysns7D3IFnmY2o5E2KHuxOsToU/aMzWTxI=;
 b=g9t8TxSA9upoVliIjIFuAli8ah8ZNB+hdo6ngKhUa3/eH3D6EuOAzQzziJBSu0JpNT
 qw+QBdOszKzladHl9JUXKUlEsagHgIUiS69ApNblfXl0/NfwmXbMJdU5eOiT53T5OjJg
 uYRgH6w02WHp7+wJY8+vhmbDnzsgY3KmH+aw36sUdbmpQJeptgHrMs2OQi7XRosAEhFK
 OpHD1NGjL3AL+ytYcKZNJPUe4QnhwM/hF/CMd8z1ASmToJaAqvRe/orBA2EO27dPm+KW
 BRcqFeAKXKTrMtV0s7wtqwCFeNutsUA+bqxoM/LqQEyWl9h2HIEVTM/hn6xZa14qy8f2
 Cfcw==
X-Gm-Message-State: AFuF++nNMXUrFx37j1yJRvkT8YXbPmROpZHkEnFNOhCm6hcM05OokGX2
 4UttO+BuqHY8G1nrvWeu/nrfx6CAJcjvNuGrjDsOOLo/sLpZ5xfEsqUuyUTjohbYxp2yyO5rdrh
 zMtudk6wzfgDR+qpSdk+PUflFOCZZBXJSurD+qmrGK3fgF/EIiJEN1iQ+meftwMaU+uwO
X-Gm-Gg: AR+sD12muk+q5Lkcf66toz1dxgZA7sXPw2/O/L14cz87Kpd0t1ztCm5qhk/74g8hoTA
 HpuJ4CwNn1lBJRRQnvU1CO4SBMN44nzmcCNauSaTNwTkUmhxLAEm4RRaUkdqKF0g61LCwCnq2f0
 0K+2gGXJH7xaqYGOgI81uCzH/RFelA8VEbmjjr1uzt5Ki8z7b3uX++eY8vwZECYkxPr+jbxPvas
 Wk+M5D4T4M0tJeXeJZeV3Sz4gIUmSVkdsWCohDrbX3Y5dTbqYLDyU2zFsXqI1yqyiaecmafRsEQ
 Gl8a3Ta1OWEQ+VvlBjfHKhkvuKjFxdFUM1hz91O9oNhhLV9SBdel2Rw2fGcmi+y5ON2K0ryLnyY
 EfN9tepdq6b7xD4u3kRhJga0rFdsoSmzuOFTzU/nIUGN7WjH7KBuae3YUym4wjBO/CxswxNyxH4
 Vt6DX0T1roL3VUignWu0SjbRGmU/XF+/qGYLa2PLG1AYMY8hlxWi1/i0CrRfDZT8hjvc9dL4Jzz
 hyiGj0oEOjPR6Y1QSVsyx6ROzQZGff/yYl7rcnolc6tqBJ7G/8ySbjwqy9orqJSUk1t+v5oFk7T
 Rta/WU1wLznN7yiaZlCcTp7a2rMjrpFNP8116yzOO2+hEpEsRrBx0MUfK+M1Og==
X-Received: by 2002:a17:907:da16:b0:c21:34a3:4df9 with SMTP id
 a640c23a62f3a-c246a2cf648mr2905506166b.3.1787570600466; 
 Mon, 24 Aug 2026 04:23:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968abf18sm1308788266b.61.2026.08.24.04.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:23:19 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 11:23:19 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9
X-Gerrit-Change-Number: 1865
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1865?usp=email>
X-Gerrit-Commit: 48b7adb1a9cc67261a820bc1be2b548794c221d9
References: <gerrit.1787570563000.Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLklkZmE3ODY0M2RhMjdmZThhOGJkMGZmMmJjZjMwMjVkODY4NzAyNGE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <62355124c6a88bcb5f5a24caaecb76e0191601ab-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wySlz-0006z2-6H
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4045386108008666475=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4045386108008666475==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cQV9xetKQQs="; charset=UTF-8

--cQV9xetKQQs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1865?usp=3Demail

to review the following change=2E


Chang=
e subject: route: Remove unused function print_routes
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: Remove unused function prin=
t_routes

This function has never been used in the git history=2E
Probably =
an OpenVPN 1=2Ex remnant=2E

Identified by cppcheck=2E

Change-Id: Idfa7864=
3da27fe8a8bd0ff2bcf3025d8687024a9
Signed-off-by: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
---
M src/openvpn/route=2Ec
M src/openvpn/route=2Eh
2 fil=
es changed, 0 insertions(+), 36 deletions(-)



  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/65/1865/1

diff --git a/src/openvpn=
/route=2Ec b/src/openvpn/route=2Ec
index 8ea745d=2E=2E6dbe3ec 100644
--- a/=
src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -185,19 +185,6 @@
    =
 dest->gc =3D a;
 }
 
-static const char *
-route_string(const struct route=
_ipv4 *r, struct gc_arena *gc)
-{
-    struct buffer out =3D alloc_buf_gc(2=
56, gc);
-    buf_printf(&out, "ROUTE network %s netmask %s gateway %s", pr=
int_in_addr_t(r->network, 0, gc),
-               print_in_addr_t(r->netmas=
k, 0, gc), print_in_addr_t(r->gateway, 0, gc));
-    if (r->flags & RT_METR=
IC_DEFINED)
-    {
-        buf_printf(&out, " metric %d", r->metric);
-   =
 }
-    return BSTR(&out);
-}
-
 static bool
 is_route_parm_defined(const c=
har *parm)
 {
@@ -1325,27 +1312,6 @@
 #endif /* ifndef ENABLE_SMALL */
 
 s=
tatic void
-print_route(const struct route_ipv4 *r, msglvl_t msglevel)
-{
-=
    struct gc_arena gc =3D gc_new();
-    if (r->flags & RT_DEFINED)
-    {=

-        msg(msglevel, "%s", route_string(r, &gc));
-    }
-    gc_free(&g=
c);
-}
-
-void
-print_routes(const struct route_list *rl, msglvl_t msglevel=
)
-{
-    struct route_ipv4 *r;
-    for (r =3D rl->routes; r; r =3D r->nex=
t)
-    {
-        print_route(r, msglevel);
-    }
-}
-
-static void
 sete=
nv_route(struct env_set *es, const struct route_ipv4 *r, int i)
 {
     str=
uct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/route=2Eh b/src/open=
vpn/route=2Eh
index 473df87=2E=2E0d33d36 100644
--- a/src/openvpn/route=2Eh=

+++ b/src/openvpn/route=2Eh
@@ -377,8 +377,6 @@
 
 #endif
 
-void print_ro=
utes(const struct route_list *rl, msglvl_t msglevel);
-
 #ifdef _WIN32
 
 v=
oid show_routes(msglvl_t msglevel);

-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1865?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9
Gerrit-Change-Nu=
mber: 1865
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--cQV9xetKQQs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1865?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">route: Remove unused function print_routes<br><br>This function has ne=
ver been used in the git history=2E<br>Probably an OpenVPN 1=2Ex remnant=2E=
<br><br>Identified by cppcheck=2E<br><br>Change-Id: Idfa78643da27fe8a8bd0ff=
2bcf3025d8687024a9<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt;<br>---<br>M src/openvpn/route=2Ec<br>M src/openvpn/route=2Eh<br=
>2 files changed, 0 insertions(+), 36 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/186=
5/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</spa=
n><br><span>index 8ea745d=2E=2E6dbe3ec 100644</span><br><span>--- a/src/ope=
nvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>=
@@ -185,19 +185,6 @@</span><br><span>     dest-&gt;gc =3D a;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-r=
oute_string(const struct route_ipv4 *r, struct gc_arena *gc)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct buffer out =3D alloc_buf_gc(256, gc);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quo=
t;ROUTE network %s netmask %s gateway %s&quot;, print_in_addr_t(r-&gt;netwo=
rk, 0, gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
     print_in_addr_t(r-&gt;netmask, 0, gc), print_in_addr_t(r-&gt;gateway, =
0, gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (r-&gt=
;flags &amp; RT_METRIC_DEFINED)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  buf_printf(&amp;out, &quot; metric %d&quot;, r-&gt;metric);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return BSTR(&amp;out);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> static bool</span><br><span> is_route_parm_defin=
ed(const char *parm)</span><br><span> {</span><br><span>@@ -1325,27 +1312,6=
 @@</span><br><span> #endif /* ifndef ENABLE_SMALL */</span><br><span> </sp=
an><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-print_route(const struct route_ipv4 *r, msglvl_t msglevel)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (r-&gt;flags &amp; RT_DEFINED)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;%s&quot;, r=
oute_string(r, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(=
&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-print_routes(const struct route_list *rl, msglvl_t msglevel)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct route_ipv4 *r;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    for (r =3D rl-&gt;routes; r; r =3D r-&gt;ne=
xt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        print_route(r, msglevel);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic void</span><br><span> setenv_route(struct env_set *es, const struct rout=
e_ipv4 *r, int i)</span><br><span> {</span><br><span>     struct gc_arena g=
c =3D gc_new();</span><br><span>diff --git a/src/openvpn/route=2Eh b/src/op=
envpn/route=2Eh</span><br><span>index 473df87=2E=2E0d33d36 100644</span><br=
><span>--- a/src/openvpn/route=2Eh</span><br><span>+++ b/src/openvpn/route=
=2Eh</span><br><span>@@ -377,8 +377,6 @@</span><br><span> </span><br><span>=
 #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-void print_routes(const struct route_list *rl, msglvl_t msglevel);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _=
WIN32</span><br><span> </span><br><span> void show_routes(msglvl_t msglevel=
);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1865?usp=3Demail">change 1865</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1865?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idfa78643da27fe8=
a8bd0ff2bcf3025d8687024a9 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1865 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>=

<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>

</body></html>
--cQV9xetKQQs=--


--===============4045386108008666475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4045386108008666475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4045386108008666475==--

