Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF475606A686
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gnkiBbwj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BmDrzSRM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Hnd34ryR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Cywl13w1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CJ2vHImUrwfAWQOg/2VMAn6MYvB2rag9XpzRGCGKbps=; b=gnkiBbwjyBBGc7N5jXDCVoLidv
	vg4PWdNF/wR7HMPeZzeiQ9sibXZtXxEBsNG/9/voIg1H/4B5acAWAFqcsPb7vECvzeGxZyoxyZa5O
	IMBmhaGI27YmNBNwwHwfnlkXC520P/QQ2kH06agXL5Y/xpBNwd+5ZOdwsUeByZrVX/VE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWHPt-000000005FD-1xso;
	Wed, 25 Nov 2026 18:08:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWHPs-000000005F6-09Za
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:08:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6tAtCZ0AQQUGm1/u20nNLNx5vwZ3gzkmo2Ii1zT4DHQ=; b=BmDrzSRMN4K3sv601IJ16jieCD
 4ToU+B3kgVAnhdpsHxA826jZf7G2cprq8mdwIJ9w18s6VMGR3uNBQjfygYIvtgKio5/teCoMehOVy
 /oNeoRGfQP+095oHFAbRN01MPnyDeOsuV+CCUdE1XwZgTE9JB1ZE5G8INyfaMoH4xEqI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6tAtCZ0AQQUGm1/u20nNLNx5vwZ3gzkmo2Ii1zT4DHQ=; b=Hnd34ryRa3xee70VrwfK0sQowf
 TjXPY5BHbs1prPTCGhKVqRnWGNgvuN3yaZ1cdTSkfs/qFGsAEMsXQn3z1hquEWUUiJEZWhPJZkJuY
 AtSiHwS7MiknspTkBHFVoLk//cTrAs0m2LxlF7vpXgSFua2if4LcRDrrb+z8uDwU7/XM=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWHPq-000000006fG-1bG5 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:08:23 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so4262136f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 10:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795630096; x=1796234896; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6tAtCZ0AQQUGm1/u20nNLNx5vwZ3gzkmo2Ii1zT4DHQ=;
 b=Cywl13w1Kuube8fFHDSMOVUBZG9A5Xt5oifT3Dx4LCxPosUOxSGdB0XPcZ1rn/pUSQ
 AgBW3z5dQnV7nC2CbxOZCIY/DpwxBe70In8WXzzPv+BHj4FDDyMmkl00x2kx6q0diixv
 H6Y7keNNqGTndtRIya2+LSqKBnpejGzb5g58N3+Se94dsPUnLwZrGZfO9+51jmGdwNBm
 nfGVgPG7K36MlllPzHG96EWYl+Kh7zvlu0HLZ+uvbaW16My98isX5tcOttxJWWjMVTK1
 v8iyrI1ZN/cDjZHzJhhph49KwXtqRXHM1N7Cw1YyuyJxH1CKnVDYMiItnpxW7Vp35wfj
 WgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795630096; x=1796234896;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6tAtCZ0AQQUGm1/u20nNLNx5vwZ3gzkmo2Ii1zT4DHQ=;
 b=z3hhjpenhxmwVJXXCT8p0FSX8jS38Jh9o2bZNPwl+RHpiq2DA3pab0UuD4snXEG5dN
 uXhr1zPEw2o6DUIXzefCNSNk03zqYxCoAzOKo+HU3GPRO3OVu0oh+P+E7R7r+a5ERju/
 vxFYfsVvGyuANsLepA3gK5BOyUpxqDrY3OAX8W4Zk2mdzjqklJ2hT52DxH6B8IpDPEJK
 NtRdQcHN77AUNDMgD1F9KkJiQlp0yIvXx847Zv85ZPUObCR6Xlb9zOj3bTh8kqZUawDG
 qFc5XL+4QknzPm6FAOlPrXT2j3fIcSqYGYlMTgpxb1jMS0+KZ7g6MtPbfQ2XHpavL7O4
 b2Hw==
X-Gm-Message-State: APuU4Z9Wc7h/VtDAnSjjNR+K+zi+A+DDn++DMVWMPQpaKNXeAEEGk3G6
 a2EUguxTuxjI31FNldJJMJcBerewQSx9Tj6vpCh8PkRBDdjEg9EGKYS/oKV8oyYHiGbk6lqdKAU
 RjAP6cmkMqfpEhoaU6DYw9TqceBbvbsUvmO6KGzbYMJvfKALQ0w5pXqm19bqx029/gPH1
X-Gm-Gg: AZFdTZdGXkAwBw2ZYdrkq+yB52vp15mhHqAigEM5KVbigRZ0BK5DCHuodCaslaymj7y
 xYxt/Sdiie8UQ5WBXJfifv46DeNxKZLbVF9o6daRsXw9Vy1MzXruZiIk5SFsNbj9jxyb5I6d/YQ
 uNW95Wir6GipNIUBbYIxiOUhWmDU9uULWtzi9FUdCF5ob/dP8NZRiAB6acDgzxKSc07LLeC8fU3
 2BNzp1A95bus4dimzYXHzLl6HYvEAh7CblJ8gYR2mk0u9OJf7ZSa9+5pyf9Vb0wQzCkXaf7XhXn
 oQKt+UuVMUDjGNKXoZh1Rac17EBHmJQNywlWX4HewMklEvcyb/oF5jCYUUaEqbIeMXrGO7gfbdC
 VBKD9VMkZSiJfENUJxHpUSCJqTumgWfu7Yq+YdnnX1LGENZ7WG1a1FCbxkS5JKYuT7h24tZ4hvt
 h45qwVTNn+ICGC/i5Nk0k7cJvDEkfXGyRybbGX/aTlURGX/bOcpLD/YTRLqiJ8ppYgvNnuHd1N7
 AJKagoaRfnI4amGEQaNDbTH8YQF35zb3LljiU7Xd9nzIUETZ3MwRDuwJv6Qfp3sW6ThTsxue0Nl
 D6b9iiHIM6h/z/wzj1RcfdpH2sCrCsh5zbsYYA9NReiV6lU3gd6J7cwCI9bnfL13xAoL+CrsdZL
 i+Nml1YuanV1fn7ysF3eVM6rDNmpJgwt2oSuK5TVDvTtiuVjb1vRhrRS5Idzu0NF8AVzeSISnSO
 WFS3jtt5UkwyBxxcU=
X-Received: by 2002:a05:6000:3106:b0:4ac:2194:755a with SMTP id
 ffacd0b85a97d-4ac219475a1mr42149841f8f.41.1795630095661; 
 Wed, 25 Nov 2026 10:08:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c61f558sm36482455f8f.58.2026.11.25.10.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 10:08:15 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 18:08:14 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Lev Stipakov <lstipakov@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I878ba525232afffa95e6b7c972ae349d6b488a2d
X-Gerrit-Change-Number: 2332
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2332?usp=email>
X-Gerrit-Commit: 559d4507e8b638dcbcfecc4d44bbae318442ced5
In-Reply-To: <gerrit.1795514253000.I878ba525232afffa95e6b7c972ae349d6b488a2d@gerrit.openvpn.net>
References: <gerrit.1795514253000.I878ba525232afffa95e6b7c972ae349d6b488a2d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE0MjUzMDAwLkk4NzhiYTUyNTIzMmFmZmZhOTVlNmI3Yzk3MmFlMzQ5ZDZiNDg4YTJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <114bd8f8df59c99d21314c45f08fe6c40b9e4c2a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWHPq-000000006fG-1bG5
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: compare
 context mode against CM_P2P in do_up()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9034908412416357722=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9034908412416357722==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hf6UrzU4md4="; charset=UTF-8

--hf6UrzU4md4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2332?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Lev Stipakov


Change subject: init: compare context mod=
e against CM_P2P in do_up()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

init: compare context mode against CM_P2P in do_up()

c->m=
ode holds a CM_* value, but do_up() compared it against
MODE_POINT_TO_POINT=
, an options mode=2E This only worked because both
are 0=2E

While at it, d=
rop a duplicate #include "occ=2Eh"=2E

Change-Id: I878ba525232afffa95e6b7c9=
72ae349d6b488a2d
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Ack=
ed-by: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2332
Message-Id: <20261124122628=2E8605-1-gert@gree=
nie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg41881=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
1 file changed, 2 insertions(+),=
 3 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/32/2332/2

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec
index 0a76263=2E=2E333b4e5 100644
--- a/src/openvpn/init=2Ec
+++ b/src=
/openvpn/init=2Ec
@@ -39,7 +39,6 @@
 #include "otime=2Eh"
 #include "pool=
=2Eh"
 #include "gremlin=2Eh"
-#include "occ=2Eh"
 #include "pkcs11=2Eh"
 #=
include "ps=2Eh"
 #include "lladdr=2Eh"
@@ -2363,7 +2362,7 @@
     if (!c->=
c2=2Edo_up_ran
         || (c->c2=2Etls_multi && c->c2=2Etls_multi->multi_s=
tate =3D=3D CAS_RECONNECT_PENDING))
     {
-        if (c->mode =3D=3D MODE=
_POINT_TO_POINT)
+        if (c->mode =3D=3D CM_P2P)
         {
           =
  /* ovpn-dco requires adding the peer now, before any option can be set,
 =
             * but *after* having parsed the pushed peer-id in do_deferred_=
options()
@@ -2391,7 +2390,7 @@
         }
         else
         {
-      =
      if (c->mode =3D=3D MODE_POINT_TO_POINT)
+            if (c->mode =3D=
=3D CM_P2P)
             {
                 if (!do_deferred_p2p_ncp(c))
  =
               {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2332?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I878ba525232afffa95e6b7c972ae349d6b488a2d
Gerrit-Change-Number: 2332
Gerr=
it-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>

--hf6UrzU4md4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2332?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Lev Stipakov</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ini=
t: compare context mode against CM_P2P in do_up()<br><br>c-&gt;mode holds a=
 CM_* value, but do_up() compared it against<br>MODE_POINT_TO_POINT, an opt=
ions mode=2E This only worked because both<br>are 0=2E<br><br>While at it, =
drop a duplicate #include &quot;occ=2Eh&quot;=2E<br><br>Change-Id: I878ba52=
5232afffa95e6b7c972ae349d6b488a2d<br>Signed-off-by: Razvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&=
gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2332<br>Messa=
ge-Id: &lt;20261124122628=2E8605-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg418=
81=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>---<br>M src/openvpn/init=2Ec<br>1 file changed, 2 insertions(+), 3 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/32/2332/2</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec=
 b/src/openvpn/init=2Ec</span><br><span>index 0a76263=2E=2E333b4e5 100644</=
span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn=
/init=2Ec</span><br><span>@@ -39,7 +39,6 @@</span><br><span> #include &quot=
;otime=2Eh&quot;</span><br><span> #include &quot;pool=2Eh&quot;</span><br><=
span> #include &quot;gremlin=2Eh&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#include &quot;occ=2Eh&quot;</span><br><span> #include &qu=
ot;pkcs11=2Eh&quot;</span><br><span> #include &quot;ps=2Eh&quot;</span><br>=
<span> #include &quot;lladdr=2Eh&quot;</span><br><span>@@ -2363,7 +2362,7 @=
@</span><br><span>     if (!c-&gt;c2=2Edo_up_ran</span><br><span>         |=
| (c-&gt;c2=2Etls_multi &amp;&amp; c-&gt;c2=2Etls_multi-&gt;multi_state =3D=
=3D CAS_RECONNECT_PENDING))</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (c-&gt;mode =3D=3D MODE_POINT_TO_PO=
INT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&=
gt;mode =3D=3D CM_P2P)</span><br><span>         {</span><br><span>         =
    /* ovpn-dco requires adding the peer now, before any option can be set,=
</span><br><span>              * but *after* having parsed the pushed peer-=
id in do_deferred_options()</span><br><span>@@ -2391,7 +2390,7 @@</span><br=
><span>         }</span><br><span>         else</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (c-&gt;=
mode =3D=3D MODE_POINT_TO_POINT)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if (c-&gt;mode =3D=3D CM_P2P)</span><br><span>    =
         {</span><br><span>                 if (!do_deferred_p2p_ncp(c))</s=
pan><br><span>                 {</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2332?usp=3Demail">change 233=
2</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2332?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I878ba525232afffa95e6b7c972ae349d6b488a2d </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2332 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--hf6UrzU4md4=--


--===============9034908412416357722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9034908412416357722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9034908412416357722==--

