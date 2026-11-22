Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089A606A32C
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j1CBL3Ph;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=clzzQlZf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T6UC+Fas;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XThpIFuw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nB19csuFRDYZ+s7knq8AfA0HjyJPQY/dBp42VA+ewE8=; b=j1CBL3PhXCuJlJGCpueRmAs0Fq
	lr+mdw8EPWyA2rdys6ep10V9fJxKzT/o8ZcM+guYOXD8Zw2mrYoPwnfh1LkDXptsl6QzYYqZU3WF2
	brYw0mlNVAAZugl4PGfl4e/8WpefbVVgV3zg8j6ML/51N+SoUzprFKEYd+86T3DA9l9Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV704-00000000341-2tei;
	Sun, 22 Nov 2026 12:48:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV703-0000000033u-2dLm
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 12:48:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lXgC6YzcqmWi0XTQuen3okVyhCI3MQNX8hC+/KhgS2E=; b=clzzQlZfj5yR4QsFmc17R6A4sy
 PVpf79pd+BlNNxLJ76oINHd4K7v6idI5mrzO+publi277D6LS0+vq/TmjruJFe33tq7Nsl+2Fw2FN
 sEyMeAv69IJFcCU/CmdjwFIVslcI3gRKo59PWrjVBOx/m+DUDDOhwTq5fRvxHNlEhCQc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lXgC6YzcqmWi0XTQuen3okVyhCI3MQNX8hC+/KhgS2E=; b=T6UC+FasPD6+ojMuCioL2Eyi0D
 ON6OUpkR3XiMwOzW1wAe+4PAYOpAUpn8v3aCi0bXWlEN/hTFOW5hw1YxJjQXz1+8lVCz8AhEYokoc
 kp91g99GeItBSrm66jfEmKMGEM40wbmvNWKa6DyorAVLJ/lUUUal6H0tsubBo0Y+i5xk=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV702-000000006iy-13Mm for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 12:48:55 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4a9be758734so1389624f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 04:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795351728; x=1795956528; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lXgC6YzcqmWi0XTQuen3okVyhCI3MQNX8hC+/KhgS2E=;
 b=XThpIFuwGnqWsDmWTauhtPi0AtFIOehHvBITSbDe2RowsPnYwP26FE/qAPzMpx5kkb
 eezRMOdXf19hIebFiOAFXb5UNVSx3ZTaMcfhgT/Qq8FeWAisBu9Jxk/Zi7juIKnVAzkF
 JF9DCtROLbmOH6+ey9i5+tLzKe8p1vMp9m+nPZAnVVV+quzKApYhZPzbyPsd1PRlgXoS
 yP37HVp38ldBVS1jaIV+Vmcp2ySw6fHMBt8ORG01vl3aRNxO9R0Cgd5cMNihAwrt+KOZ
 4m4jkWzYbnPVJFiHA1uGmstx7/ho3sbRp8QnVPPlfcEMi47VFR67Zq5kdmzV+PGA2kGU
 +tGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795351728; x=1795956528;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lXgC6YzcqmWi0XTQuen3okVyhCI3MQNX8hC+/KhgS2E=;
 b=kJtUxnYwBfnA3zYUeXBwYQxj+GVi72qoDfKWzB1HT/SmQiDbdBQpttsUSH/MQAXtY2
 knh3Nn3ZAtj/FBArvl5W+PEPM+TD76tDM3d9Z+XJYqO1NTeOBRxiZyRafDxd+3rW8D9Z
 Q7GMn4O/2Brd2Xf5Dwc7/BtRR2cOKbcq/EVQBt27bY6zASfRvPEr0fHOYteOxKa6HyTd
 yx/An1LG8DWL2zA7DkJjDj4FN3W/StOkz6S8AbWAM9XAYxv8N/NPsPLLQSQCHAf7jMvS
 0lxQpGHsmoVstsfgDn0U+Cct8Ms9nyGuvL/KQ/xmREjkVjYjNq0SvWRy5wF1G1+QSDEE
 vU4A==
X-Gm-Message-State: APuU4Z8rhDJoxL9AV/ea8ntE7ELrTApr/W4PP3UbwVbhgJMTZq71jyoM
 Us//RwNcifxVOasWWn6e+0iF89kl19Aa7gAVnLVkbmYSE+DhLLvhalao3t9Yi76b/LSt/cnXdhA
 qDBeEVp1lH5ggEcwm6uRhUsgyHqCDxBG3wtWoPF/q30A9NjCWuquwkB6HXMUwJbrcVV01g5ican
 YdzIGBeg==
X-Gm-Gg: AZFdTZdqccTHgqTH3IFXk8MvnoyRsJSXDnJ8InclLoyuWARD+VzS5kqTmVC2Xo/Em1D
 XtmHumkXD4m8lPj7z+Q2mHjjIDsKFhfrz2e8THbAT9B5mN+fNrXOmCMYOnJn1ra6vlSIDh7w9ho
 8TLyRrLW13sW0C0T0OtzHcdg5ds9hRI75/tYMk5KbvE+kNUm0NZcw/GUtny2USmvxlzfiutIu0B
 zz4zFL1Z9EvN5P0/+22LZrCYPoEfnIeyP7tdlNsw3/bBuxxLqdPNHsCA51AIkg1bCo68IysKmmO
 cyYAJ4dyrdYLWrB8OcH6sZYBL6omWdq1Q3ySfCQkjh0isYTQQvskqHLE1ksOo1suFKbo4PwMdm9
 29sXiDpA0/UiUK4ttX7Rmo1gpOOiHs+hvhrXpD4rSZ1l8jyaFDjZUWZHerRvvNqHklK5ifPJbq0
 GQdmgwPkAZfCimjVALnHE7tNDvGdJNFVGi1BWE95Vzlhc05A/Px9dl2RAhf6M2xAq4OJEYoPCWA
 VAtz3+cq8KkgLdTV1LXRazeLIQMDTbjdGu7q3EjdlY8O3cHSKslQnrslehKVQ7EECjrTsWUSdp3
 rt+CS7dd2PoW0j6yLkEZK7Mx99pDpHQf84gNfFBNOV1KBJ4MGZVJ12mINXq/KTkUNA4ZTn3g5wQ
 5U2IpHIuLeP/gCER+U8NXNQaNRn+bAJXVfYWEEu5D7H4assPpCMfZ+7JjlcmrPuF6LGsBowKPZE
 i37ZVzpNzRdvmkbYp9
X-Received: by 2002:a05:6000:1788:b0:492:3176:3d6f with SMTP id
 ffacd0b85a97d-4abb400aefcmr16348800f8f.47.1795351727192; 
 Sun, 22 Nov 2026 04:48:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a68048esm16967580f8f.29.2026.11.22.04.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 04:48:46 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 12:48:45 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifc72b3677056dd089b8c6cfae4bd07911b6f8407
X-Gerrit-Change-Number: 2228
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2228?usp=email>
X-Gerrit-Commit: 5115f203b3c06035b8bdc84f86d4b84b08d5cfc5
In-Reply-To: <gerrit.1795176368000.Ifc72b3677056dd089b8c6cfae4bd07911b6f8407@gerrit.openvpn.net>
References: <gerrit.1795176368000.Ifc72b3677056dd089b8c6cfae4bd07911b6f8407@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTc2MzY4MDAwLklmYzcyYjM2NzcwNTZkZDA4OWI4YzZjZmFlNGJkMDc5MTFiNmY4NDA3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6cdd6ee8e609181de8e415295ace0536e41f1d74-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xV702-000000006iy-13Mm
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: options: check
 permission for --route-ipv6-gateway
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5369868505162655212=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5369868505162655212==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FKmFMbTIgRs="; charset=UTF-8

--FKmFMbTIgRs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2228?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: options: check permission=
 for --route-ipv6-gateway
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

options: check permission for --route-ipv6-gateway

Unlike --=
route-gateway, the handler never called VERIFY_PERMISSION(),
so the option =
was accepted in any context (<connection>, ccd, inline)
and was missing fro=
m option_types_found=2E Require OPT_P_ROUTE_EXTRAS,
as --route-gateway does=
=2E

Change-Id: Ifc72b3677056dd089b8c6cfae4bd07911b6f8407
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2228
Me=
ssage-Id: <20261121145406=2E27273-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41759=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvp=
n/options=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/2228/2

diff --gi=
t a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index e51ece7=2E=2E20=
68393 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@=
 -5350,6 +5350,7 @@
     }
     else if (streq(p[0], "route-ipv6-gateway") =
&& p[1] && !p[2])
     {
+        VERIFY_PERMISSION(OPT_P_ROUTE_EXTRAS);
  =
       if (ipv6_addr_safe(p[1]))
         {
             options->route_ipv=
6_default_gateway =3D p[1];

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2228?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Ifc72b3677056dd089b8c6cfae4bd07911b6f8407
Gerrit-Change-Number=
: 2228
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--FKmFMbTIgRs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2228?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">opt=
ions: check permission for --route-ipv6-gateway<br><br>Unlike --route-gatew=
ay, the handler never called VERIFY_PERMISSION(),<br>so the option was acce=
pted in any context (&lt;connection&gt;, ccd, inline)<br>and was missing fr=
om option_types_found=2E Require OPT_P_ROUTE_EXTRAS,<br>as --route-gateway =
does=2E<br><br>Change-Id: Ifc72b3677056dd089b8c6cfae4bd07911b6f8407<br>Sign=
ed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2228<br>Message-Id: &lt;20261121145406=2E27273-1-ger=
t@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg41759=2Ehtml<br>Signed-off-by: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/options=2Ec<br>1=
 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/2228/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span>=
<br><span>index e51ece7=2E=2E2068393 100644</span><br><span>--- a/src/openv=
pn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><spa=
n>@@ -5350,6 +5350,7 @@</span><br><span>     }</span><br><span>     else if=
 (streq(p[0], &quot;route-ipv6-gateway&quot;) &amp;&amp; p[1] &amp;&amp; !p=
[2])</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        VERIFY_PERMISSION(OPT_P_ROUTE_EXTRAS);</span><br><span>    =
     if (ipv6_addr_safe(p[1]))</span><br><span>         {</span><br><span> =
            options-&gt;route_ipv6_default_gateway =3D p[1];</span><br></pr=
e><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
228?usp=3Demail">change 2228</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2228?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Ifc72b3677056dd089b8c6cfae4bd07911b6f8407 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 2228 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert D=
oering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--FKmFMbTIgRs=--


--===============5369868505162655212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5369868505162655212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5369868505162655212==--

