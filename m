Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BB1C5DF93
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=bS7f2GNBJBYUvJ5yHoDba18TT+55QKBIfPn4GACrqkk=; b=PI29nS3F3gQuir
	0Qq06rDIUYcWRFZf3tqVzTXxj7/LjFEmli6m4qkMfIg6QAMDTIKz1ryoqbLqB3JB3WR561lTq3OR9
	OKiiKUGd/F7gFNvaPnjJhIqpnj3cDGGbvJoH/mo+1qva+t2BO6rK3JmOmtKt3nQTjHpozh0f7FL4N
	8ZQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxRUd-0003vt-GW;
	Fri, 21 Aug 2026 15:49:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxRUb-0003vn-Ua
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O87Tjh5ZRhj0T+ZTrDox9/FBeht1CBm3S0DCSVRbeBQ=; b=N3snezPMYad/ozJVzMQocqqDRT
 2tVGKxQDnWnzlbesfGcccIrb2KL9b/8rb7XE8/B0KRwfFmpvRDsQ9vhfKYW/G63LJcr7qjwYJti/n
 +7ZEdUdBFMtd71TxROwmseJ9qSuLn2a+zu4JAfd9LTYjETnnTEnGDTa6WJOaoRnOkqbE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=O87Tjh5ZRhj0T+ZTrDox9/FBeht1CBm3S0DCSVRbeBQ=; b=h
 wAru9oRSC0rf933bOcvJ8rNw9x1D+kl/5vVz+7fYBR10w0xmO70jksQxXaPOwpHbGBKIsfLnhYMvE
 X2sm8Hf+0w5Pxc/wkjOSVYyZTkvnVzWxmsB1PwKv1SIIJE8bHNBBPbW6z8UdbZxKo8lFMBX/RvTxM
 /5tXtG9eyZrwOGd4=;
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxRUa-0005bP-QA for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:18 +0000
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso192434966b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787327350; x=1787932150; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O87Tjh5ZRhj0T+ZTrDox9/FBeht1CBm3S0DCSVRbeBQ=;
 b=fbVsDKdx8lbUp8J8HAfXWU6gNPjrC1e4x/D/vPGBcqUn05Z6jtIIOzMGJZypWBfqQz
 UwPcyinA+2C4ODXk++f/uTFx3Aj0zTvXkS0RP4eBAbZrdE7+uAuXmVdKv558pdz3Gdlr
 tUjdSUkvb0+o1ByskCCJg8MJriRVfjxCtrK/+vhi1MD20No0782NsBo3DEwkKvPciw0x
 b4A2tKYrQ1Nu085WGvIXqWY72YWeekiGyRrcdtvG0gnMzGKZJ9V5HM3IX0Eay+EtKGzE
 a4Zj8WrRlQeSyGa3axiP7MCqBh5Fluk0EnFhldlRIFLI4X7AvuU1AzgIRo9hjtur/8KL
 WCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787327350; x=1787932150;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O87Tjh5ZRhj0T+ZTrDox9/FBeht1CBm3S0DCSVRbeBQ=;
 b=Cu8O+Iqm+iXwdvO2i8TiLKSsve4GWYWTLdzU/rSsrEaPi9r8Ve4HxAwQ/dZOjZYdPc
 6tUgx8ZsO4jKPa3yfIfcf59u908tGeRk5to56XDUD0L8wjwaQf/TAoVp9pCeEH9cQ2RB
 aNsyppLQxPxevcNNMIixXzoJbjTJrlErUKfIlVSWTpWa14qdLApGkta9GEWrLeHvJ+YY
 lwqTuUzZsh5oKeka59wCl5qSDIUPAff1bmdjVLA1ZbuD4lv+Nqqiv0Iw93y39HPWWoMO
 +gDenf9bzgrpN26vN0MAsCPRXDWEZMSVK/DZwojvwNrb45C0h4Dd+VGzXJE6juyi5xA7
 Ab4Q==
X-Gm-Message-State: AFuF++kgSsvvWVqa7hhty+3ow3fw8k8NoqA5we3WV3Or+8sxSM35Xgqg
 w3POsfJ7BLoGIsDxUigb5tLbkQI1G+lEnkdoOVCT3dTDQAB4vMRyMktxlheIrvW2XPCEbpMNp+F
 4GLXixk0hkq6ACHJyP4A32dh4xhrQT7BjbVD6q4BTcK7z+nYxVFMGnpwKZ5kq0jAMREH5iFK2AW
 jpme6Cgg==
X-Gm-Gg: AR+sD11Dks4gSyYKQU0paPgYL1nAvw6+F4HsLoPs9eoGCCld3u2q/EMWoL0mA/Jhg22
 q4KacHovA3twULgZ6P6Mv+lvXooUeoGwbNyQXV6F0zN6L1W7Gk9HJO3Cs30AB5TS+mPJHFHMMGC
 QvLu+qaVeC15C2oJGFkCFbTSDPVpM5CG0HT2tze1XI/Cn886CofOZGuBlEAzsnRvvJEZkk84h+Z
 7WXxq81mMhpk8Bs3ZT2wfWhGo+qxHuOr5cA/VZV8phOL4cxNDoVjrwng52SJ98Vv4P0QkaAtqlz
 As1RBS+/lt0v+7ads+6hJ9Mo1U5Cnoy7/f5k6wvhnzWWpX3MUJuiifpvx0Us45ehXl/2RY3r9/y
 ExSdhYTFsTZ8LjvSJZhWU8hHlhEVKYiTJf95tch6vOQVZhxJ05lsxwPMaSTptbucnuJuonSMkkI
 XmpaIlBkDlXdrDj+QcOSONzM0dTDG8A34jJShvW1anPZDJCO1/NqBGWk4xgZISiFHZuuWQeixzH
 zkQhkctM7ICuzgOS4aG85F8pr8WVr+MKSBDGP3hf9468jiEMMwdH+GY8Aoc/HpP/UaN/S8zVMAf
 OUtSWTqI4gdIwUfyBZJi5q/uY681ndteBsoUKNkG8xtMDpLePMg=
X-Received: by 2002:a17:907:6b0d:b0:c24:6505:8f66 with SMTP id
 a640c23a62f3a-c246a693337mr920749566b.13.1787327350074; 
 Fri, 21 Aug 2026 08:49:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2459222200sm486627566b.56.2026.08.21.08.49.08
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:49:08 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 15:49:08 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd
X-Gerrit-Change-Number: 1851
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1851?usp=email>
X-Gerrit-Commit: 42fbc73ee1e2be9a109f4cb9337e951c4c4c67b5
References: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkljZDUzNzQ1YjI0MmUwY2EyOTQzODYzZDViMjc0YjJhMTNiNDQxOWJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8598f53a1e1f30286ed89a878dc8f8500be2f9c1-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxRUa-0005bP-QA
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make
 pull_permission_mask return uint64_t
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5664080966052356859=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5664080966052356859==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dBzcP1H6Y0s="; charset=UTF-8

--dBzcP1H6Y0s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1851?usp=3Demail )


Change subject: Make pull_permissio=
n_mask return uint64_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Make pull_permission_mask return uint64_t

Commit 91fd9614 alrea=
dy change most of the instances for the
option flag to uint64_t but forgot =
to also adjust
pull_permission_mask=2E

Change-Id: Icd53745b242e0ca2943863d=
5b274b2a13b4419bd
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M sr=
c/openvpn/init=2Ec
M src/openvpn/init=2Eh
M src/openvpn/options=2Eh
M src/o=
penvpn/push_util=2Ec
M tests/unit_tests/openvpn/test_push_update_msg=2Ec
5 =
files changed, 9 insertions(+), 9 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/51/1851/1

diff --git a/src/ope=
nvpn/init=2Ec b/src/openvpn/init=2Ec
index fa62cdd=2E=2E66bae34 100644
--- =
a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2514,13 +2514,13 @@
 =
/*
  * These are the option categories which will be accepted by pull=2E
  =
*/
-unsigned int
+uint64_t
 pull_permission_mask(const struct context *c)
 =
{
-    unsigned int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF=
 | OPT_P_SOCKFLAGS
-                         | OPT_P_SETENV | OPT_P_SHAPER =
| OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
-                         | OPT_=
P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-        =
                 | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU;
+    uint64_=
t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS=

+                     | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_=
COMP | OPT_P_PERSIST
+                     | OPT_P_MESSAGES | OPT_P_EXPLICI=
T_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
+                     | OPT_P_PEER_=
ID | OPT_P_NCP | OPT_P_PUSH_MTU;
 
     if (!c->options=2Eroute_nopull)
   =
  {
diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh
index 9d5050d=
=2E=2Ece8f74e 100644
--- a/src/openvpn/init=2Eh
+++ b/src/openvpn/init=2Eh
=
@@ -89,7 +89,7 @@
  */
 bool do_update(struct context *c, uint64_t option_t=
ypes_found);
 
-unsigned int pull_permission_mask(const struct context *c);=

+uint64_t pull_permission_mask(const struct context *c);
 
 const char *fo=
rmat_common_name(struct context *c, struct gc_arena *gc);
 
diff --git a/sr=
c/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 0fd505a=2E=2E9fa44f0 =
100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -761,=
7 +761,7 @@
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_P_ROUTE_=
TABLE     (1u << 31)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PUL=
L_MODE))
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | 0x0ul=
l))
 
 #define PULL_DEFINED(opt) ((opt)->pull)
 
diff --git a/src/openvpn/p=
ush_util=2Ec b/src/openvpn/push_util=2Ec
index c927f26=2E=2Efcc5411 100644
=
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -185,7 +=
185,7 @@
          */
         struct buffer tmp_msg =3D e->buf;
         b=
uf_string_compare_advance(&tmp_msg, push_update_cmd);
-        unsigned int=
 permission_mask =3D pull_permission_mask(c);
+        uint64_t permission_=
mask =3D pull_permission_mask(c);
         if (process_push_update(c, &o, p=
ermission_mask, &option_types_found, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)=

         {
             msg(M_WARN, "Failed to process push update message=
 sent to client ID: %u", c->c2=2Etls_multi->rx_peer_id);
diff --git a/tests=
/unit_tests/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/tes=
t_push_update_msg=2Ec
index 9cb791b=2E=2E01bf6c8 100644
--- a/tests/unit_te=
sts/openvpn/test_push_update_msg=2Ec
+++ b/tests/unit_tests/openvpn/test_pu=
sh_update_msg=2Ec
@@ -20,7 +20,7 @@
     msg(M_WARN, "Offending option rece=
ived from server");
 }
 
-unsigned int
+uint64_t
 pull_permission_mask(cons=
t struct context *c)
 {
     unsigned int flags =3D OPT_P_UP | OPT_P_ROUTE_=
EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd
Gerrit-Cha=
nge-Number: 1851
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--dBzcP1H6Y0s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Make pull_permission_mask return uint64_t<br><br>Commit 91fd9614 a=
lready change most of the instances for the<br>option flag to uint64_t but =
forgot to also adjust<br>pull_permission_mask=2E<br><br>Change-Id: Icd53745=
b242e0ca2943863d5b274b2a13b4419bd<br>Signed-off-by: Arne Schwabe &lt;arne@r=
fc2549=2Eorg&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/init=2Eh=
<br>M src/openvpn/options=2Eh<br>M src/openvpn/push_util=2Ec<br>M tests/uni=
t_tests/openvpn/test_push_update_msg=2Ec<br>5 files changed, 9 insertions(+=
), 9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/51/1851/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index fa62cdd=2E=2E66bae=
34 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/=
src/openvpn/init=2Ec</span><br><span>@@ -2514,13 +2514,13 @@</span><br><spa=
n> /*</span><br><span>  * These are the option categories which will be acc=
epted by pull=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-unsigned int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+uint64_t</span><br><span> pull_permission_mask(const struct contex=
t *c)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    unsigned int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF=
 | OPT_P_SOCKFLAGS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                      | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_C=
OMP | OPT_P_PERSIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                       | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECH=
O | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                       | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t flags =3D OPT=
_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_SETEN=
V | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_MESSAG=
ES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_PEER_ID =
| OPT_P_NCP | OPT_P_PUSH_MTU;</span><br><span> </span><br><span>     if (!c=
-&gt;options=2Eroute_nopull)</span><br><span>     {</span><br><span>diff --=
git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh</span><br><span>index 9d5=
050d=2E=2Ece8f74e 100644</span><br><span>--- a/src/openvpn/init=2Eh</span><=
br><span>+++ b/src/openvpn/init=2Eh</span><br><span>@@ -89,7 +89,7 @@</span=
><br><span>  */</span><br><span> bool do_update(struct context *c, uint64_t=
 option_types_found);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-unsigned int pull_permission_mask(const struct context *c=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t pull_per=
mission_mask(const struct context *c);</span><br><span> </span><br><span> c=
onst char *format_common_name(struct context *c, struct gc_arena *gc);</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/options=2Eh b/src/op=
envpn/options=2Eh</span><br><span>index 0fd505a=2E=2E9fa44f0 100644</span><=
br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/op=
tions=2Eh</span><br><span>@@ -761,7 +761,7 @@</span><br><span> #define OPT_=
P_PUSH_MTU        (1u &lt;&lt; 30)</span><br><span> #define OPT_P_ROUTE_TAB=
LE     (1u &lt;&lt; 31)</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MO=
DE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_D=
EFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | 0x0ull))</span><br><span> </sp=
an><br><span> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_u=
til=2Ec</span><br><span>index c927f26=2E=2Efcc5411 100644</span><br><span>-=
-- a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=
=2Ec</span><br><span>@@ -185,7 +185,7 @@</span><br><span>          */</span=
><br><span>         struct buffer tmp_msg =3D e-&gt;buf;</span><br><span>  =
       buf_string_compare_advance(&amp;tmp_msg, push_update_cmd);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        unsigned int permission=
_mask =3D pull_permission_mask(c);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        uint64_t permission_mask =3D pull_permission_mask(c)=
;</span><br><span>         if (process_push_update(c, &amp;o, permission_ma=
sk, &amp;option_types_found, &amp;tmp_msg, true) =3D=3D PUSH_MSG_ERROR)</sp=
an><br><span>         {</span><br><span>             msg(M_WARN, &quot;Fail=
ed to process push update message sent to client ID: %u&quot;, c-&gt;c2=2Et=
ls_multi-&gt;rx_peer_id);</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_m=
sg=2Ec</span><br><span>index 9cb791b=2E=2E01bf6c8 100644</span><br><span>--=
- a/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>@@ -20,7=
 +20,7 @@</span><br><span>     msg(M_WARN, &quot;Offending option received =
from server&quot;);</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-unsigned int</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+uint64_t</span><br><span> pull_permission_mask(=
const struct context *c)</span><br><span> {</span><br><span>     unsigned i=
nt flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAG=
S</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail">change 1851</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1851?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icd53745b242e0ca=
2943863d5b274b2a13b4419bd </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1851 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>=

<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--dBzcP1H6Y0s=--


--===============5664080966052356859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5664080966052356859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5664080966052356859==--

