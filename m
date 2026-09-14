Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75FAC88E64
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 06:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2E15gRTuT7OKbXkXgm2NS2rTyFolCJO3l2p6FaaMMls=; b=cORHoyoLl4PzOlae+JU0qX/Pfu
	V3G5ywQZ2koHre5c+vBNDuEpuaFyG3wQinlfABOy7Ok/zCuyUVNq3RVwK2LdYdwY2Ik4C1SWpTHHP
	XccLMW5GLC/20PMFBsJo5htU9jKvtF7JxTya5aadfc7tyFOxizzoBPgM6TWKaiLFul8U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x60IQ-00005j-9v;
	Mon, 14 Sep 2026 06:36:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x60IO-00005F-Q0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 06:36:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Sq0qLq/bGrGP83di1H5TTaq4m226K1xEBtJ3nwUKvDY=; b=TGr/RPmKi8v66pL67tD6IdFQqG
 9r1ypFWvjT3ttr+sCx+1gty8NzNi6ndaJ/Beo6RHUoHqFOsZEtTZ8oWV+UREox5lDJXpBir1r8fsd
 krezwWazAy2ObCq6H5cflSalpK2a95AvDCvUaqqJSDDAUgyJi48rxtRBWuqozmj2b34E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Sq0qLq/bGrGP83di1H5TTaq4m226K1xEBtJ3nwUKvDY=; b=k
 NV4jx+uk+LFmAh7qHdru+xoR3BZF5j+OdHtnfG8pJHNrybf6tDo/8PZ68+SUgfP9o5UFx4FEBA3Yv
 McXGWFBv9orO0ZHvf/pXNDLv/Bnb5DavtXckMjvF4N6zPbT6DZ39SmiN2VqCyIp42xgTDH5u8ZqPY
 F0LOag3ffPm20E2E=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x60IO-0001YH-19 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 06:36:05 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6356f6bso1301406f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 23:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789367757; x=1789972557; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Sq0qLq/bGrGP83di1H5TTaq4m226K1xEBtJ3nwUKvDY=;
 b=Gd9zmkhIWHasoI+JoUG66VxscfwABVwuG+vzQ3AT/wZiT4V1OlD8iPdgV8dTq+P4P2
 P4GoLJ3RGtC4M4z8SJVnp0A/8S9KBUl18yBgiDnH6c7OMzjIW+eYIY1rYGU/2w67iCZY
 kX8gV+/XjJLMtOqxG6ugVpqairX4BYHg8w6qAfLsmhxMqLuvYqFbYWIaE0EgCja1h0dq
 K0YS7zEc4fjqgPfPYSVF8JIOv8vLQLpCm7jaAJ8iiGZdNZOAjDLB4rgkGKvBHm5Htw2B
 bvEKqzdJk6u15P1Nvd8VA2VWazlY5o+saf6AwHQGLwbb83wN1e7RNk8xUSfLI3ZpSSXF
 fKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789367757; x=1789972557;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Sq0qLq/bGrGP83di1H5TTaq4m226K1xEBtJ3nwUKvDY=;
 b=rgFqYbY7o1ApnuL21+/2p9i+nKLhGP9/ul01pRRUTEWfx6ES5a0jCZCAF7vtc4GHnT
 +TAldkBtoNM2/YhCdJEa/8UyVeuGd9CKvWvH2nYgF9M11szNqRMdYqP5fAH3PH/22XtA
 yuB2x4MO7zhryL4N0PpCqomfiUwEeVwg/szO0jl2cUjJglsVJzrRwDmIJdX2nCany3LB
 4npSF/LqDTC6LBSe+ENE3dmgxrsy6S2fMg+YcHl/o4UCcX75RWz1lekk7su7X8ia/ouR
 4CGe/fazsmLCWrtEJmXdJPydEsP6nGXEjqeo1g/ZCtCDjw3MNkLMs84F1XiqLeqjN3/c
 rh0w==
X-Gm-Message-State: AFuF++m3e6cakSBbVFkAyv4pMgwZj2eMrhRD0Y0LolqX6heZ0xIMDFLN
 ir2rV8uhu1IpYxie2Eqj+BEmsv22JglvailT5SuxanYUdGTSwxtx8lLaIbIYGad/m7KIhiIYzjf
 uDSJAwIVD3TlgSFTTqy7EHykk+6SsfAzD+DBf2SrL4RcbX6M6fUNb7KaylFNhrXH7X+eqnZkCks
 jlosMV2Q==
X-Gm-Gg: AYBFou1Ki9Cr+E35NCWcgBAbMNZB2WeiAehecY4eI7bR9gJoNkYFe3NzMHQ08xvy/Xc
 1F++RiOQ+Od4XBIl4IiGczqSR9/TZFG5g81lL1Nxu4eB5nEE2C31xX5mfr5i4NcQ4nbrCChGc98
 bU1MAGZxPHW5jFgiQvNOh8+Mymo1jSadGbexAC33W7gZEYEg8qNuYH7gMZkAwSL7FresD9ay3f3
 EdYnrLd63vy4KbEhm1q5ZqLYFihdXS1h6dsrVxC/1YVz7heZTa1QI7Z4gBAjP21MYQXITIVWwDR
 Slj6w3dhNAI/xyCfbrTh5By5Su4likFrBTuC+rYZ0FZB7iDIZAgn4Dvk6j/tpZ77/qiyVZT2fby
 bDmN4dfO9wxrzg3697g9AHyEdL2ca+f72QRlBGYsIgcxofArcBlAPtOSyrccN+aIMxLSNULKU35
 Kyfo6N/Tr5WdA8r4wlw/12OQGdn7dwz3dEKvKglu4o9RqDmO6o83aRss+tr8zM6H0HMU89gH0/S
 vp6X1yowmTOj0CnIWB3OiKnPM6vGnL8m2/9VM22g5fV0+upxiTDwoHKxfv8pQYd9V7NHIXS41cl
 0dmH+2eKFFEZBfmfOCKT5wqSyepOx+5YtFz1Mei2adqUQjUDTCyW2tBoXV669MMYjSyLAeVm
X-Received: by 2002:a05:6000:71e:b0:484:3310:c4fc with SMTP id
 ffacd0b85a97d-48702b2dd2bmr2285790f8f.23.1789367757318; 
 Sun, 13 Sep 2026 23:35:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d5f1sm26404455f8f.12.2026.09.13.23.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 23:35:56 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 06:35:55 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594
X-Gerrit-Change-Number: 1914
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1914?usp=email>
X-Gerrit-Commit: aa12dd64b74142bbbff9f37cec05959ba115c06d
In-Reply-To: <gerrit.1789291650000.I3724236d4acc3d05d786274d6baf34a21c570594@gerrit.openvpn.net>
References: <gerrit.1789291650000.I3724236d4acc3d05d786274d6baf34a21c570594@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MjkxNjUwMDAwLkkzNzI0MjM2ZDRhY2MzZDA1ZDc4NjI3NGQ2YmFmMzRhMjFjNTcwNTk0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5dd6c3e1a30a5c832e0a52c0e4a0f2e760ac55ad-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x60IO-0001YH-19
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: fix
 unsigned underflow when clearing domain_search_list
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7176366777579591629=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7176366777579591629==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3toEuvyxCTI="; charset=UTF-8

--3toEuvyxCTI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello plaisthos, razvanc, 

I'd like you to reexamine a change=2E Please vi=
sit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail

to loo=
k at the new patch set (#3)=2E

The following approvals got outdated and we=
re removed:
Code-Review+2 by razvanc


Change subject: options: fix unsigne=
d underflow when clearing domain_search_list
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: fix unsigned underflow when cleari=
ng domain_search_list

remove_option() and update_option() clear the domain=
 search list with

    while (o->domain_search_list_len-- > 0)

domain_sear=
ch_list_len is unsigned, and the post-decrement runs on the
final test too=
=2E When the length reaches 0 the condition is false but
the decrement has =
already wrapped it to UINT_MAX, so the field is left
corrupted=2E The next =
reset then does

    o->domain_search_list[UINT_MAX] =3D NULL

and walks fa=
r out of bounds, writing NULL through each slot=2E A server
can drive this =
reset path against a client with PUSH_UPDATE, so on
Windows and Android thi=
s is a remotely reachable out-of-bounds write=2E

v2:
  Change to the seman=
tics used for all the other lists there - set
  length to 0 and clear the l=
ist with CLEAR()=2E

Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594
S=
igned-off-by: Cole Munz <Munzzyy1@proton=2Eme>
Acked-by: Razvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1914
Github: OpenVPN/openvpn-private-issues#178
CVE: 2026-88964
Message-I=
d: <20260913132322=2E2283-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39157=2Ehtml
Sig=
ned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/option=
s=2Ec
1 file changed, 6 insertions(+), 8 deletions(-)


  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/14/1914/3

diff --git a/src=
/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 15f2fcd=2E=2Ee3cd527 1=
00644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3778,=
12 +3778,12 @@
         memset(o->ntp, 0, sizeof(o->ntp));
         o->nbdd=
_len =3D 0;
         memset(o->nbdd, 0, sizeof(o->nbdd));
-        while (o=
->domain_search_list_len-- > 0)
-        {
-            o->domain_search_li=
st[o->domain_search_list_len] =3D NULL;
-        }
+        o->domain_searc=
h_list_len =3D 0;
+        CLEAR(o->domain_search_list);
         o->disabl=
e_nbt =3D 0;
         o->dhcp_options =3D 0;
+        CLEAR(options->dns_op=
tions=2Efrom_dhcp);
+
 #if defined(TARGET_ANDROID)
         o->http_proxy_p=
ort =3D 0;
         o->http_proxy =3D NULL;
@@ -4082,10 +4082,8 @@
        =
     CLEAR(o->ntp);
             o->nbdd_len =3D 0;
             CLEAR(o->n=
bdd);
-            while (o->domain_search_list_len-- > 0)
-            {
-=
                o->domain_search_list[o->domain_search_list_len] =3D NULL;
=
-            }
+            o->domain_search_list_len =3D 0;
+            C=
LEAR(o->domain_search_list);
             o->disable_nbt =3D 0;
           =
  o->dhcp_options =3D 0;
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1914?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I3724236d4acc3d05d786274d6baf34a21c570594
Gerrit-Change-Number: 1=
914
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>

--3toEuvyxCTI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by razvanc<=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">options: fix unsigned underflow when clearing domain_searc=
h_list<br><br>remove_option() and update_option() clear the domain search l=
ist with<br><br>    while (o-&gt;domain_search_list_len-- &gt; 0)<br><br>do=
main_search_list_len is unsigned, and the post-decrement runs on the<br>fin=
al test too=2E When the length reaches 0 the condition is false but<br>the =
decrement has already wrapped it to UINT_MAX, so the field is left<br>corru=
pted=2E The next reset then does<br><br>    o-&gt;domain_search_list[UINT_M=
AX] =3D NULL<br><br>and walks far out of bounds, writing NULL through each =
slot=2E A server<br>can drive this reset path against a client with PUSH_UP=
DATE, so on<br>Windows and Android this is a remotely reachable out-of-boun=
ds write=2E<br><br>v2:<br>  Change to the semantics used for all the other =
lists there - set<br>  length to 0 and clear the list with CLEAR()=2E<br><b=
r>Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594<br>Signed-off-by: Co=
le Munz &lt;Munzzyy1@proton=2Eme&gt;<br>Acked-by: Razvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1914<br>Github: OpenVPN/openvpn-private-issues#178<br>CVE: 2026-88964<b=
r>Message-Id: &lt;20260913132322=2E2283-1-gert@greenie=2Emuc=2Ede&gt;<br>UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg39157=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 file changed, 6 insertions(+)=
, 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/14/1914/3</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 15f2fcd=2E=2E=
e3cd527 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><spa=
n>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -3778,12 +3778,12 @@</sp=
an><br><span>         memset(o-&gt;ntp, 0, sizeof(o-&gt;ntp));</span><br><s=
pan>         o-&gt;nbdd_len =3D 0;</span><br><span>         memset(o-&gt;nb=
dd, 0, sizeof(o-&gt;nbdd));</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        while (o-&gt;domain_search_list_len-- &gt; 0)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            o-&gt;domain_search_list[o-&gt;domain=
_search_list_len] =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    o-&gt;domain_search_list_len =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        CLEAR(o-&gt;domain_search_list);</span><br><spa=
n>         o-&gt;disable_nbt =3D 0;</span><br><span>         o-&gt;dhcp_opt=
ions =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
CLEAR(options-&gt;dns_options=2Efrom_dhcp);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> #if defined(TARGET_ANDROID)</span=
><br><span>         o-&gt;http_proxy_port =3D 0;</span><br><span>         o=
-&gt;http_proxy =3D NULL;</span><br><span>@@ -4082,10 +4082,8 @@</span><br>=
<span>             CLEAR(o-&gt;ntp);</span><br><span>             o-&gt;nbd=
d_len =3D 0;</span><br><span>             CLEAR(o-&gt;nbdd);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            while (o-&gt;domain_sear=
ch_list_len-- &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        o-&gt;domain_search_list[o-&gt;domain_search_list_len] =3D NULL;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;domain_searc=
h_list_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          CLEAR(o-&gt;domain_search_list);</span><br><span>             o-&=
gt;disable_nbt =3D 0;</span><br><span>             o-&gt;dhcp_options =3D 0=
;</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail">change 1=
914</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I3724236d4acc3d05d786274d6baf34a21c570594 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1914 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--3toEuvyxCTI=--


--===============7176366777579591629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7176366777579591629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7176366777579591629==--

