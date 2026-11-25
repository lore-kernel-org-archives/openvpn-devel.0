Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A3606A327
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y+SMoouu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jVB6WMxS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WlWXMCwn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LXorXmI9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P7HkS4h29Zfo1BjxEjuigJkSsgYXMTlOVZDwwy9pqoM=; b=Y+SMoouueHoF0XZauve1QTFJ6/
	rxWaJSWHxdJnZcYaNq5MfkGy9w9yfFPOF2dKZ5ck/4f5rGYlYPRqwkySXk8IM9pJ8BhxfRtTg3Zwm
	swEiRePqwD9YMhoVtSynWG+2+gpYT53p3ftGicJrNgCyXdRD4CyeQHy1Ure3DgbD2bXQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWHPu-000000001Zy-1Fby;
	Wed, 25 Nov 2026 18:08:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWHPs-000000001Zs-38oA
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:08:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=brtwy9DEdKS9QvctzyhRnZCKE4a4EPzQyJpsL/aXjXA=; b=jVB6WMxSirroHduff9/MbiGwn0
 1PhOZUvuaP0QOhN6g/Af5ktcjFwwkAQ//qIGIbRmUZGUU1iKyIvmmHVF0yNFo1BLXSWmlf1/qFusq
 X2kIICZN8JR9qIkuc9CvKPIrhndT4NL7P2OJ0S5phDyzoBD8mZzGUDks2yaW1J+2fn58=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=brtwy9DEdKS9QvctzyhRnZCKE4a4EPzQyJpsL/aXjXA=; b=WlWXMCwnN+ZadSCPANd4dPsRMV
 dUoGqM84Cnir14Z+O/TJeGi0VhzIPhE5wEzppqpdVnocbIAu2UoNkqun6XJ7+rawiaCie4sBNiPPR
 3VpyrN4MDLsa7kzYhdlkd/1C8odKvcWxXHJ6ApIHdbas/8uvlpid5g6UchJz56EUgo3M=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWHPr-000000000yp-0ibQ for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:08:24 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso44912725e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 10:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795630096; x=1796234896; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=brtwy9DEdKS9QvctzyhRnZCKE4a4EPzQyJpsL/aXjXA=;
 b=LXorXmI9fiUQaMlX8EAXnZeNQ9XO3NAwrPfhcXTEWMHAlt4GIGKX3wfLMb2rUjkdMi
 hkWVcpUPRb1d+xZh2zOXLpSYoTB6xtJtHF3vWXTcu+GHHGsMfuJPj1e3db1OHWNelQxp
 9otU6OXrGht6d5Ci37XCrV+ecPDCzvRXHIDS6R4JI7zrO4kTuK3FJu477yJLJ2zmtkry
 hmlZSlZfJEHlojN39F+Qq2aV370LVVjftORaHCfVrGbcykBy/G5tZsJnCyf8hB869lUz
 urahID8j2ruu3pSIzyAYAJIMzkQbXKxXP5dCj9tAf8RkwOv4A18pqtbNm2Oq0qWNAy/A
 w1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795630096; x=1796234896;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=brtwy9DEdKS9QvctzyhRnZCKE4a4EPzQyJpsL/aXjXA=;
 b=CjQJPCAricsKBAcrkuvFODNHN27L3Rm6m7MD6DzIMu6tMHJfX1CdT3tanMWg3zUDwe
 /5/0eZEEtONgLmtBqQXwjWec9cz6TQtirFDXF/YwspSztGDyFhutksNSzclQ8jBEVGb1
 ARbLMpfeTpS6PvuLG5wQbUyxWswaxdBDj5nZVrpugt4zYIyNNIGv/XEEMDui3717ix7n
 0M4mhKOf1YZqcFhHLIC+pbOsR6VGesmd4KJM2+/jlEoQ2be8yd7biT8yg6U0PlL3bxBG
 NqzoiAR/lV/cmImfdxsckhemS6oySk2OoXNIB3lkVD9hmytuF57aoLZTV6xrhlFxTDvd
 e60Q==
X-Forwarded-Encrypted: i=1;
 AL+hErENsxeCHC3zR6f/+DB82fDiTQk4OSzy2lmNqZQObDE1f/y2C7jZYZ+DGPlFad2WGQ8PvPky6tsreqVemRiX@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Kt5idSAOI5ERaYtFRt3FelsA+ohIc2NopZa4GmhY0GRnDx+Op
 VHj2u1JPOyT2asAKNoSmdCK43tizK8KyADeoHkxWmFCOKPtfgsyuw8BIhkiRUoXLLCo2egSPAab
 6Hj++8xQooXe3YtCW+/yODVguyeqte5qwqG3fIPcdKaUG6qVkXarlPL320v1UjOaDB80nuy1rFS
 n60k0Z1w==
X-Gm-Gg: AZFdTZcPjj9kXWv+hsyaN2YL1kn2uzZqVCkCNwtAQ002fI1lbyXCA+ORIDwLQIsxvR+
 Sq7KndO2jh0sHC+ZTcUPVfBvRDz9Ucm8bclVpQdHTbckpsr2qMlnCOTSfQ4Sd+qwxHOEhCgtsys
 fXRoPVzCSPr/7iWyD70m/eZLjV40x3r1Vg3Pr7ES1GvU93HL1CGGSalNb4gKshSpF0v0zK8CCk2
 aigBchs7IyP3AudOL/oXFI75wrCc7CYbmOXdEHiD6S/agsyU3GGDnDSWPBez2W6DeluzuKvjAf8
 fUDuj8UxXG5y/qLU5OjpwghmmDzPtL0bOAr2JrCFGQ74vnyrHsqfKTC9W3b5Y9rgp+X8HtCM066
 yQc0kN6B8MRLhQIYNXEKrPLWqROxXpZ1VQ8k0nPQKvmEvDDXoblToxx2pVikn8U3a1A8OotE1Y5
 oLQASbJzt268lrwUbhoJUCtGjbIhpEnPkygry0r/QyhtR51/fbEonOqxNxnSc2Tvp/dKDYk2Gwo
 UMpcgNoEnS1gruaYsB3MIdkEfzZOlXCkj1lpqXG3BXwTtSm9o1oE2I8EI84lHLJXxzukeXXh4kl
 oPc+cxEXGNhvUXZdR4DuQ13vXIeUwHTvvn8zxTQVC6N5Gw/NIoNtCSELbY6Jw0HyxqxAB2YElbg
 ITM/DvNax+uWFkxE1Ag6juot8ssRJHw8z7AY81tcUFDqRdP+4iGrvEb50PDg9SYTiVNaF8bkGOC
 l0u8g7JAPfwrvaQCE=
X-Received: by 2002:a05:600c:828e:b0:4a1:e6a9:4086 with SMTP id
 5b1f17b1804b1-4bb88785a99mr356745905e9.0.1795630096394; 
 Wed, 25 Nov 2026 10:08:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb98b4dsm36380469f8f.53.2026.11.25.10.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 10:08:16 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 18:08:15 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I878ba525232afffa95e6b7c972ae349d6b488a2d
X-Gerrit-Change-Number: 2332
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2332?usp=email>
X-Gerrit-Commit: 559d4507e8b638dcbcfecc4d44bbae318442ced5
In-Reply-To: <gerrit.1795514253000.I878ba525232afffa95e6b7c972ae349d6b488a2d@gerrit.openvpn.net>
References: <gerrit.1795514253000.I878ba525232afffa95e6b7c972ae349d6b488a2d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE0MjUzMDAwLkk4NzhiYTUyNTIzMmFmZmZhOTVlNmI3Yzk3MmFlMzQ5ZDZiNDg4YTJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <114bd8f8df59c99d21314c45f08fe6c40b9e4c2a-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWHPr-000000000yp-0ibQ
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7025783840032120994=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7025783840032120994==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a3AchDzvsyU="; charset=UTF-8

--a3AchDzvsyU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2332?usp=3Demail )

Change subject: init: compare context mode =
against CM_P2P in do_up()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

init: compare context mode against CM_P2P in do_up()

c->mode=
 holds a CM_* value, but do_up() compared it against
MODE_POINT_TO_POINT, a=
n options mode=2E This only worked because both
are 0=2E

While at it, drop=
 a duplicate #include "occ=2Eh"=2E

Change-Id: I878ba525232afffa95e6b7c972a=
e349d6b488a2d
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-=
by: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2332
Message-Id: <20261124122628=2E8605-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41881=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
1 file changed, 2 insertions(+), 3 =
deletions(-)




diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
i=
ndex 0a76263=2E=2E333b4e5 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openv=
pn/init=2Ec
@@ -39,7 +39,6 @@
 #include "otime=2Eh"
 #include "pool=2Eh"
 #=
include "gremlin=2Eh"
-#include "occ=2Eh"
 #include "pkcs11=2Eh"
 #include =
"ps=2Eh"
 #include "lladdr=2Eh"
@@ -2363,7 +2362,7 @@
     if (!c->c2=2Edo_=
up_ran
         || (c->c2=2Etls_multi && c->c2=2Etls_multi->multi_state =3D=
=3D CAS_RECONNECT_PENDING))
     {
-        if (c->mode =3D=3D MODE_POINT_T=
O_POINT)
+        if (c->mode =3D=3D CM_P2P)
         {
             /* ovp=
n-dco requires adding the peer now, before any option can be set,
         =
     * but *after* having parsed the pushed peer-id in do_deferred_options(=
)
@@ -2391,7 +2390,7 @@
         }
         else
         {
-            if=
 (c->mode =3D=3D MODE_POINT_TO_POINT)
+            if (c->mode =3D=3D CM_P2=
P)
             {
                 if (!do_deferred_p2p_ncp(c))
           =
      {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2332=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I878ba525232=
afffa95e6b7c972ae349d6b488a2d
Gerrit-Change-Number: 2332
Gerrit-PatchSet: 2=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <=
lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--a3AchDzvsyU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2332?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">init: compare context mode against=
 CM_P2P in do_up()<br><br>c-&gt;mode holds a CM_* value, but do_up() compar=
ed it against<br>MODE_POINT_TO_POINT, an options mode=2E This only worked b=
ecause both<br>are 0=2E<br><br>While at it, drop a duplicate #include &quot=
;occ=2Eh&quot;=2E<br><br>Change-Id: I878ba525232afffa95e6b7c972ae349d6b488a=
2d<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked=
-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2332<br>Message-Id: &lt;20261124122628=2E860=
5-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg41881=2Ehtml<br>Signed-off-by: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/init=2Ec<=
br>1 file changed, 2 insertions(+), 3 deletions(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 0a7=
6263=2E=2E333b4e5 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><=
br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -39,7 +39,6 @@</span=
><br><span> #include &quot;otime=2Eh&quot;</span><br><span> #include &quot;=
pool=2Eh&quot;</span><br><span> #include &quot;gremlin=2Eh&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;occ=2Eh&quot;</sp=
an><br><span> #include &quot;pkcs11=2Eh&quot;</span><br><span> #include &qu=
ot;ps=2Eh&quot;</span><br><span> #include &quot;lladdr=2Eh&quot;</span><br>=
<span>@@ -2363,7 +2362,7 @@</span><br><span>     if (!c-&gt;c2=2Edo_up_ran<=
/span><br><span>         || (c-&gt;c2=2Etls_multi &amp;&amp; c-&gt;c2=2Etls=
_multi-&gt;multi_state =3D=3D CAS_RECONNECT_PENDING))</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;mo=
de =3D=3D MODE_POINT_TO_POINT)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (c-&gt;mode =3D=3D CM_P2P)</span><br><span>         {=
</span><br><span>             /* ovpn-dco requires adding the peer now, bef=
ore any option can be set,</span><br><span>              * but *after* havi=
ng parsed the pushed peer-id in do_deferred_options()</span><br><span>@@ -2=
391,7 +2390,7 @@</span><br><span>         }</span><br><span>         else</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            if (c-&gt;mode =3D=3D MODE_POINT_TO_POINT)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (c-&gt;mode =3D=3D CM=
_P2P)</span><br><span>             {</span><br><span>                 if (!=
do_deferred_p2p_ncp(c))</span><br><span>                 {</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/233=
2?usp=3Demail">change 2332</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2332?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I878ba525232afffa95e6b7c972ae349d6b488a2d </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2332 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipako=
v &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

<=
/body></html>
--a3AchDzvsyU=--


--===============7025783840032120994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7025783840032120994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7025783840032120994==--

