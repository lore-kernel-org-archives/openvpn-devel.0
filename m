Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5322CDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u9KFA1DnHvEA2DHOzkFK8De/c8D+9F+5WXHQ4ZSBdew=; b=lwepsONuiOjqkfH8hJX5kWPLyb
	WZxM9hwnHqsrxPGISVOMxrP9VmY5U88ZP32SZuYMJhY72QqGgH3df3OoRjyF1/eLbWDdfOS7rQiAa
	z1tKaacFZrPAKCVwdQD89Ju6M7X9pAnmY6s22nWbY5k/p9nqrjfxHaGZTs2vfhUdKu64=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbece-0000cK-Eq;
	Mon, 22 Jun 2026 13:23:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbecc-0000c5-Kp
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Q7jqlZLYru1bDYcLy+uIkOwg8dVbCk5Nhg05iUe1BQk=; b=SvKzziw6YDUPi5fMHrnXMbOloZ
 ARuPOBrWN2ZZus93p4y1WKDTyw8t3Ek04Nbg8XUQGUQ38bPjqkTP0p8wCarJ7a+8ByRars0CwsUa7
 L0k7eYJeW4JBx6NCeFHhBkEAK1OBCOPs+pKTCPRCxGQqwHSRDzKlLLY4r9Hub5NRw6iY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q7jqlZLYru1bDYcLy+uIkOwg8dVbCk5Nhg05iUe1BQk=; b=A
 S4nIkD+3u6WU3asIESZRXvZhQuPiaWO4MxeL8RHpDO6OYiAmcKkAE3SfhKdo1V+32CYXQNEzHsqjn
 ZZjY9mJ9C5ZprEw4MScUemu2PTVEtBl+6dFbZty5li+yePstw5gPjyliHk3R+XOGTb04j9Rh3lA0J
 /9XgW1wj4JjavZyY=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbecb-0000Z5-Cf for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:31 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso2173544f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134598; x=1782739398; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q7jqlZLYru1bDYcLy+uIkOwg8dVbCk5Nhg05iUe1BQk=;
 b=ZDt8wvxa5PFTBfCpUXl7XCphidNVxuirOECMAPPW+sFSnSLgMf3/Ij83j8sZKRhzRr
 sXsD5FvMxsX/iGte+/8Ix2VvKa4ud1AHiDQzSrw3mnOgqjX9IjWhiFxdlIURPakCrLSN
 fFFWKwA1mAr3lbf/c/kZHTT5d7cG9H3yRLdsSSBP1jPajpj2ftFjp4rnfKDP6DNDCbE6
 cSUiI0TDlojncUxyRrsIxrsAOyfo5qVtJUoONQKJsrdpu8RVF5fYUJf8pVWMiR6Vl1HP
 m1mzlNcrL23GzpnB/akReJzAevUuSF24EoszwDkWYQqr1v2HD9LKtGrQlMRPfWRVf12o
 tQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134598; x=1782739398;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q7jqlZLYru1bDYcLy+uIkOwg8dVbCk5Nhg05iUe1BQk=;
 b=QwEMuKccLClsdTKXd/xqU50loQfRGwAavKk+0H2SMeOd6ZVViSM8/vpcCTAYBj2Qlw
 jMCsTHLd0LrwuXRQJnQILMPXHPbDBrY7FlrWEXJEBjibStG82+CZjHyFUmZDTghvX8gu
 yrehxJ8tvY9R4clY94nnXxISue7f01/ZCCpfBGdCoNCrs9979kdpjVh6fKmrTSOcULZc
 coLFjyzYT8oGo26F5+181YC7GISSFQdDsLkNLZJkhZuZnlga3bysqoY7bzf7vyxq1BuD
 IEyuE9LW7pO+NO2f1E/1Un6BYtbMnmffT/vDztLcjdYne32VQxxJt4r3/uOmCaPGIMKo
 ZzTg==
X-Gm-Message-State: AOJu0YwIDEF7J+9hPZazLE79b7qUA64Zbgz53qCXRKfL1UT1MwxGkx53
 iEsSxB9ncHnUW9MUMShpkbBGxAh3dj2chNwwVCEZycaoG0oHJw8Ap7NHAVAMuRKpO6DE6FaGdQ6
 4XPwZ6/r3NxyxrkMd96Bf5N6It82Z+1oj9RAVxjsSrXsUKiyAQ5PyGQ5amipY9cMgtAppJwC2h1
 vJbljHIg==
X-Gm-Gg: AfdE7cnSJSeKfy6e3/BI8+kqkV9BHXi+sDxUa4i0AtZ/in7+WVONZCrH8ZzxB/DDYds
 XtlhPltx4K1BqZ/xAoBlLvPoJMVqoEAbeuqqbRNmcuYZtl/VjevGKVCxXGMTtEE6pO4iBquLcmA
 pHQ7+usf/GGmFkwVDbxHUSHNz/VuAhHYpVcXx7XIMVbbjaLzDZqEWRgloIGgzOvDhcoquaZtLbV
 Sy9LceDy9jkUleORMMkHVEQvUIyeTk4bnog6Zmx3Uy6oAY+z9bnRAUdwR7h6M4C/fCPfhNkxwZW
 TMWXLe4tIAIVZEchS3UfKYp0Wv+2+REGrt6fum8BnxKe2rhIlyGLbFM5qefYHq59v8yth5FOeMB
 iklgfqfnJZWpaUtG1v3uC/V7kSLE6oHMENffD3MvlaKnKarSc8bJFti819l/z5gGUCg/4IIoxss
 Wnr7AfWMAU8GKVCumhwx5j+hTOXXYHICibaht8SeYXg+KeL5Vm/j+fI+svDhJeaHQWZVIt1LJIr
 KIyeVTrhBm1C0SHrCUyq9hBXXvuRsQbls44SVmN/tGA5dE8FEnDaLRuobOp4TSwOx/yq2u1qlGs
 6Yc=
X-Received: by 2002:a05:6000:40da:b0:461:9e13:45e0 with SMTP id
 ffacd0b85a97d-465704ea461mr18979814f8f.41.1782134596829; 
 Mon, 22 Jun 2026 06:23:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4d9csm25864725f8f.4.2026.06.22.06.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:23:16 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:23:08 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
X-Gerrit-Change-Number: 1634
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1634?usp=email>
X-Gerrit-Commit: 33bd7335b992afb622a221bfc707cb2b197c4609
In-Reply-To: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
References: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzY4MDAzMDAwLkkwNzM3Yjc2OWU3OGU2ZDI3MWVjODc0Y2FkYjlmYmQ4MWJmZWZkZWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <353aff6fefc522f3ff6545da0ab7a1d3ee9f2ad4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbecb-0000Z5-Cf
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Only announce
 support push updates/IV_NCP when actually supporting it
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4999179955202359350=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4999179955202359350==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ISObNAXiQYk="; charset=UTF-8

--ISObNAXiQYk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail

to look at the new pa=
tch set (#2)=2E

The following approvals got outdated and were removed:
Cod=
e-Review-1 by flichtenheld


Change subject: Only announce support push upd=
ates/IV_NCP when actually supporting it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Only announce support push updates/IV_NCP when=
 actually supporting it

Currently even p2p clients that do not accept push=
 message, so announcing
PUSH UPDATE or DNSv2 is not very useful=2E

The cha=
nge for IV_NCP is more a documentation bugfix as in mode server
we currentl=
y never have push_peer_info_detail > 0=2E

But change the message to indica=
te that IV_NCP nowadays is more a
legacy variable and replaced by IV_CIPHER=
S=2E

Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Signed-off-by: A=
rne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/ssl=2Ec
1 file changed, =
12 insertions(+), 14 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/34/1634/2

diff --git a/src/openvpn/ssl=2Ec b/s=
rc/openvpn/ssl=2Ec
index 0998bd6=2E=2E479d2a5 100644
--- a/src/openvpn/ssl=
=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1914,21 +1914,21 @@
         /* support =
for P_DATA_V2 */
         int iv_proto =3D IV_PROTO_DATA_V2;
 
-        /* =
support for the latest --dns option */
-        iv_proto |=3D IV_PROTO_DNS_=
OPTION_V2;
-
         /* support for exit notify via control channel */
   =
      iv_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;
 
-        /* currently push-u=
pdate is not supported when DCO is enabled */
-        if (!session->opt->d=
co_enabled)
-        {
-            /* support push-updates */
-           =
 iv_proto |=3D IV_PROTO_PUSH_UPDATE;
-        }
-
         if (session->opt=
->pull)
         {
+            /* support for the latest --dns option */
+=
            iv_proto |=3D IV_PROTO_DNS_OPTION_V2;
+
+            /* current=
ly push-update is not supported when DCO is enabled */
+            if (!se=
ssion->opt->dco_enabled)
+            {
+                /* support push-up=
dates */
+                iv_proto |=3D IV_PROTO_PUSH_UPDATE;
+            =
}
+
             /* support for receiving push_reply before sending
       =
       * push request, also signal that the client wants
              * to=
 get push-reply messages without requiring a round
@@ -1943,11 +1943,9 @@
 =

             /* support for tun-mtu as part of the push message */
       =
      buf_printf(&out, "IV_MTU=3D%d\n", session->opt->frame=2Etun_max_mtu);=

-        }
 
-        /* support for Negotiable Crypto Parameters */
-    =
    if (session->opt->mode =3D=3D MODE_SERVER || session->opt->pull)
-     =
   {
+            /* legacy support for Negotiable Crypto Parameters (depre=
cated in favour
+             * of IV_CIPHERS */
             if (tls_item_=
in_cipher_list("AES-128-GCM", session->opt->config_ncp_ciphers)
           =
      && tls_item_in_cipher_list("AES-256-GCM", session->opt->config_ncp_ci=
phers))
             {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1634?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Gerrit-Change-Number: 1634
=
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenhel=
d=2Ecom>

--ISObNAXiQYk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review-1 by flich=
tenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">Only announce support push updates/IV_NCP when act=
ually supporting it<br><br>Currently even p2p clients that do not accept pu=
sh message, so announcing<br>PUSH UPDATE or DNSv2 is not very useful=2E<br>=
<br>The change for IV_NCP is more a documentation bugfix as in mode server<=
br>we currently never have push_peer_info_detail &gt; 0=2E<br><br>But chang=
e the message to indicate that IV_NCP nowadays is more a<br>legacy variable=
 and replaced by IV_CIPHERS=2E<br><br>Change-Id: I0737b769e78e6d271ec874cad=
b9fbd81bfefdec1<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<b=
r>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 12 insertions(+), 14 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/34/1634/2</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2E=
c b/src/openvpn/ssl=2Ec</span><br><span>index 0998bd6=2E=2E479d2a5 100644</=
span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/=
ssl=2Ec</span><br><span>@@ -1914,21 +1914,21 @@</span><br><span>         /*=
 support for P_DATA_V2 */</span><br><span>         int iv_proto =3D IV_PROT=
O_DATA_V2;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* support for the latest --dns option */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        iv_proto |=3D IV_PROTO_DNS_OPTIO=
N_V2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
>         /* support for exit notify via control channel */</span><br><span=
>         iv_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        /* currently push-upda=
te is not supported when DCO is enabled */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (!session-&gt;opt-&gt;dco_enabled)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            /* support push-updates */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            iv_proto |=3D=
 IV_PROTO_PUSH_UPDATE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span>         if (session-&gt;opt-&gt;pull)</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* support =
for the latest --dns option */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            iv_proto |=3D IV_PROTO_DNS_OPTION_V2;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            /* currently push-update is not supported=
 when DCO is enabled */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (!session-&gt;opt-&gt;dco_enabled)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                /* support push-updates */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                iv_proto=
 |=3D IV_PROTO_PUSH_UPDATE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>             /* support for receiving push_reply before =
sending</span><br><span>              * push request, also signal that the =
client wants</span><br><span>              * to get push-reply messages wit=
hout requiring a round</span><br><span>@@ -1943,11 +1943,9 @@</span><br><sp=
an> </span><br><span>             /* support for tun-mtu as part of the pus=
h message */</span><br><span>             buf_printf(&amp;out, &quot;IV_MTU=
=3D%d\n&quot;, session-&gt;opt-&gt;frame=2Etun_max_mtu);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        /* support for Negotiable =
Crypto Parameters */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (session-&gt;opt-&gt;mode =3D=3D MODE_SERVER || session-&gt;opt-&=
gt;pull)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* legacy s=
upport for Negotiable Crypto Parameters (deprecated in favour</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+             * of IV_CIPHERS */</=
span><br><span>             if (tls_item_in_cipher_list(&quot;AES-128-GCM&q=
uot;, session-&gt;opt-&gt;config_ncp_ciphers)</span><br><span>             =
    &amp;&amp; tls_item_in_cipher_list(&quot;AES-256-GCM&quot;, session-&gt=
;opt-&gt;config_ncp_ciphers))</span><br><span>             {</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1634?usp=3Demail">change 1634</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd=
81bfefdec1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1634 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"=
display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--ISObNAXiQYk=--


--===============4999179955202359350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4999179955202359350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4999179955202359350==--

