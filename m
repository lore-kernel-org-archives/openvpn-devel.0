Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216FE606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NlkdwMTh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ebvuawqy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iB3NDvYZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OFYGtxsw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=etiL6+PXAIXar8qEq7t+OEGjKpUoqiktqupGNMYpCsQ=; b=NlkdwMThPBABqfaVTDHBZGCeAe
	jlUEoHG2+OO6cCa1ADMBs6Sl+TjaRTXs+qBILdqZVDbm7T3e1OqeYI9VkQo8YP82Ld+b1pKUIDG+k
	4ao72Y/dI3QDp5wEXYsUU8WB98rioL7ueofTIyQeqr/ZOQyfmXaUcIUbye8XF59dlH3k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMQe6-000000004VX-2xlP;
	Thu, 29 Oct 2026 13:58:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMQe5-000000004VO-0G1Q
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 13:58:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+aNiog+1/zETA9EDHcHWr0n0SRr7fsGbssqm/NYS3U4=; b=ebvuawqyNnDBn/EBiRAWFX6bZB
 Vulhn77wLwB2hrgsxMXwMS+hwZMwn4qxYKKKG18h295a5mB+9Zoe63NO2NHT6ODPsFlpvzd28lhx4
 rH1xb0wdoGDJoajUFIB+NSSuCQDoBI3BnV+832IMZz0XbloJ2Pp0/9dg0+6Vji+HXGTk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+aNiog+1/zETA9EDHcHWr0n0SRr7fsGbssqm/NYS3U4=; b=iB3NDvYZ2SSd3WTAEF+18iKA8/
 CCPjzRUG8cupwLTqsDLRthF8aUm+QVCPsK7JEbRApbkT64tPVTVLIA0faiHhaFfVaaUejwTqySk0P
 r6WPNVWPuwjEkuDBU2B+qrPjn1XBe9h6elTASi4kntITmVjvjZC4wprv2vlG6537M/ww=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMQe3-000000003j7-27Xc for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 13:58:20 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a7992e2f7dso19533855e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793282293; x=1793887093; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+aNiog+1/zETA9EDHcHWr0n0SRr7fsGbssqm/NYS3U4=;
 b=OFYGtxsw5+e21c7xXdPD8kQQrhvEzrj0YzLXctHl+9MCeiczn/JmmkYLTUBJH0NkBn
 R9eQuWZS/WLb5KqS5r51L2S8Mledgi01ZOfxNNfl2ITunfZLaD93JLgP7Ho9n8v9z60g
 HP/w6ErBJ8tLISZALxC2i6ha/55sgZB+412lLFCMye9bZqn0AjpSct0I1a6++VOc5GTX
 /0ObGBYUeL+tJ+Eu+/p7sT689pmsMBN3gZZWx6WRug3hqiywl/Ndqd5vyzh3E2zhYgOX
 MQNXHdfJPnZz2MNPv68GwWDHpm41AfcZvZoc+FxwnH4fT+7S3tkevkKXd2JGtkjQhlyK
 iOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793282293; x=1793887093;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+aNiog+1/zETA9EDHcHWr0n0SRr7fsGbssqm/NYS3U4=;
 b=pmIBdarxr943i5yJjK84an4o76SL3Hcy5pJ9/S6nFqVXwUUaI4jysawo2Yv2NEpAAG
 QKhj2S6mFrkcmZdaGeLC1jcT7UrX4uiIcRJyP9Srt0AYR7BHhw9McWAPgJzKnI8so2P3
 y2gYA/0X3IH+4dx19CnqEn8I3QjkEtj+IeZZHe+oZPC3oTJGZ7MKF7g6NyAlCQQRZ8Bl
 NLV+34QSVKL7G1Ej6epyxLNsnqTTFcPx5sRVHbfs/HF3JY6WGtpe7rnw6rNxjZavA4i+
 tX7M2Uds+87fRD5llxByVo+Ger0SwUNUwztBD1ZzmBXqjwW6fghAP7m7iOCc6XGB8DY1
 QMqw==
X-Gm-Message-State: AFq9FYJ9w/cfsSmT3sqf7lg9dmAvxxFELADJrrA2rs0ZVXNoEK6Ois9C
 wq9vXkmre6f3mjgRcNtjOCq98cg7dNiZXNrzASIewAsJBFuQP5LFNod/sneJdKpHd+xGIig8mcj
 kiuYeIIZHkGuN4yFQaAyJI/Eg3AOQHDQA/AFMnsp+OCk8fSxV/4wMhV6qzblMhfwMZhM0
X-Gm-Gg: AYBFou0s37co/GOKK6uHEJprrzV+HebWf2+Zk0zvRNWvtpNAQjxIqzLMoVPXB2O/oaL
 eNthc+s8Vrkqr4dD3xxuSIlZlyP35Sbi6iT84YGAYHpiZHSm5kGfnFcKqST5yL+9rD7ap/Gb2id
 3WRd76F7Cj1SrJbhMvCAFThvAPh3lv8/2A4LA1ZyqcxPjFWt+cmSQCbqVB89liGMX6Uzpch6ik/
 N3CqsY418pXtfWIpPLhC3q1NXUVUyLY9fsxR0vKn69zsbYiSo29qCiDutHP5p2QFuSgxZwfWfxS
 aLe1AsPSI8sV6XzBDpu2hAflCbBKqlu2qEQE0va55WD+NC6nRTAKOBYbes7pya+gWna8BziA8wr
 8SrUeuAOK0i7/NncOIjHz15ayRfxzXlLxaz6NmqxMZ0bjU0qTyFu/SE70uRPkv1UMc+XRa7ocKG
 zxbNArqmwXRkuGHkwPyAjVFIg5YfSs1Qyi63JgGgF1oys6pvPgNmDpLAfcVIFWmLGaBP1mb7YDA
 rqd9KDPENNNmVfqMGSUMzwm6G2BECTsk5l8d+yJQCwTJo/d3641/0riXgoe+qt2Wk9EU57EcOn/
 Sldmq+wSdtp/VSRsWGlSCTVMJYXLshTVtiKPgfYnp0P3hAM2LMOgXjyklyjpQLaiH6I2wo42Ai3
 3p/aKs/n8kgL1CcqYbmlTzZOn4Lfwmc/jqaLtPm/saPqbk1X8fgYzDmBmP0IKrQYzklqbVEEfje
 fa/YxEOY8roGeczZwe
X-Received: by 2002:a05:600c:8183:b0:4a2:1a:a129 with SMTP id
 5b1f17b1804b1-4a9677c92d0mr106042385e9.35.1793282292657; 
 Thu, 29 Oct 2026 06:58:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f387sm34496735f8f.4.2026.10.29.06.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:58:12 -0700 (PDT)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 13:58:10 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
X-Gerrit-Change-Number: 2069
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2069?usp=email>
X-Gerrit-Commit: 08b058611ff00638cee31f0eb2da092826e34c5f
In-Reply-To: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
References: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLklhYzIzZDUxNDFhOGMyOWUyMzlkMGYyYWVlYTQ5N2QzYTAwMmU2MDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <88414f5fc28cddd5e749dad5c8a9e69c9e33f9eb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMQe3-000000003j7-27Xc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Optionally indicate
 username in >PASSWORD 'Auth' prompt
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8632187288540521689=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8632187288540521689==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C09E4P6yMY4="; charset=UTF-8

--C09E4P6yMY4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Selv=
a Nair=2E

Hello Arne Schwabe, Frank Lichtenheld, 

I'd like you to reexami=
ne a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2069?usp=3Demail

to look at the new patch set (#2)=2E

The following appr=
ovals got outdated and were removed:
Code-Review-1 by Frank Lichtenheld


C=
hange subject: Optionally indicate username in >PASSWORD 'Auth' prompt
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Optionally indic=
ate username in >PASSWORD 'Auth' prompt

When username is included in the c=
onfig file as inlined or
read from a file, indicate it as a preferred-usern=
ame in
>PASSWORD Need 'Auth' username/password prompt=2E The prompt
is appe=
nded with "UN:foo64" where foo64 is the pre-defined
username, base64 encode=
d=2E

This is treated as a hint, not an enforced value=2E The management
cl=
ient still responds with both username and password obtained
from the user=
=2E Whether the management client allows the
user to input a different user=
name is left to the client
implementation=2E

Only clients that announce ve=
rsion >=3D6 are prompted this way=2E

This helps to fix user reports on Ope=
nVPN-GUI not respecting username
set in the config file=2E

Change-Id: Iac2=
3d5141a8c29e239d0f2aeea497d3a002e609b
Signed-off-by: Selva Nair <selva=2Ena=
ir@gmail=2Ecom>
---
M doc/management-notes=2Etxt
M src/openvpn/manage=2Ec
2=
 files changed, 44 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/2069/2

diff --git a/doc/man=
agement-notes=2Etxt b/doc/management-notes=2Etxt
index eac91a4=2E=2E2662474=
 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@=
@ -394,6 +394,28 @@
   response along with the username and password format=
ted as described
   in the Challenge/Response Protocol section below
 
+  E=
xample 10:
+
+    >PASSWORD:Need 'Auth' username/password UN:<user-base64>
=
+    >PASSWORD:Need 'Auth' username/password UN:<user-base64> SC:1,Please e=
nter token PIN
+
+  These work exactly as Examples 3 and 8, respectively, w=
ith the following
+  difference=2E The prompt has an additional word "UN:<u=
ser-base64>" where
+  <user-base64> is the base64 encoded form of a pre-def=
ined username=2E This
+  may be a username inlined in the config file or re=
ad from an external
+  user-pass file=2E
+
+  The management client is expe=
cted to show the base64 decoded value to
+  the user=2E Whether the user ca=
n change this username or not is left to
+  the client implementation=2E
+
=
+  The response from the management client should follow the same format
+ =
 as in example 3 or example 8, as applicable=2E
+
+  This prompt is shown o=
nly if the management-client announces a
+  version >=3D 6=2E Older clients=
 will see the prompt shown in Example 3
+  or 8=2E
+
 See the "Challenge/Re=
sponse Protocol" section below for more details
 about examples 8 and 9, in=
cluding how the management interface client
 should respond=2E
@@ -530,6 +5=
52,7 @@
     >PK_SIGN:[base64],[alg]     -- version 3 or greater
     >PASS=
WORD:Need 'Auth' username -- version 4 or greater
     multiline password f=
rom client -- version 5 or greater
+    preferred username in >PASSWORD pro=
mpt -- version 6 or greater
 
 COMMAND -- auth-retry
 ---------------------=

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 0fc9ee2=
=2E=2E65e2881 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=
=2Ec
@@ -71,6 +71,7 @@
     MCV_PKSIGN_ALG =3D 3,
     MCV_USERNAME_ONLY =
=3D 4,
     MCV_MULTILINE_PASSWORD =3D 5,
+    MCV_PREFERRED_USERNAME =3D 6=
,
 };
 
 struct management *management; /* GLOBAL */
@@ -3670,6 +3671,26 @@=

             buf_printf(&alert_msg, " MSG:%s", up->username);
         }
 =

+        if (up_query_mode =3D=3D UP_QUERY_USER_PASS
+            && (man-=
>connection=2Eclient_version >=3D MCV_PREFERRED_USERNAME)
+            && u=
p->username[0])
+        {
+            /*
+             * The buffer up is=
 prefilled with username from auth-file or inline=2E
+             * Indica=
te it in the prompt as base64 encoded=2E
+             */
+            char=
 *user64 =3D NULL;
+            if (openvpn_base64_encode(up->username, (in=
t)strlen(up->username), &user64) !=3D -1)
+            {
+                b=
uf_printf(&alert_msg, " UN:%s", user64);
+            }
+            else
+=
            {
+                msg(M_NONFATAL, "ERROR: could not base64-enc=
ode username");
+            }
+            free(user64);
+        }
+
    =
     if (sc)
         {
             buf_printf(&alert_msg, " SC:%d,%s",

-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iac23d5141a8c29=
e239d0f2aeea497d3a002e609b
Gerrit-Change-Number: 2069
Gerrit-PatchSet: 2
Ge=
rrit-Owner: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>

--C09E4P6yMY4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Selva Nair=2E </p>
<=
p>Selva Nair <strong>uploaded patch set #2</strong> to this change=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
=
Code-Review-1 by Frank Lichtenheld</p><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">Optionally indicate use=
rname in &gt;PASSWORD &#39;Auth&#39; prompt<br><br>When username is include=
d in the config file as inlined or<br>read from a file, indicate it as a pr=
eferred-username in<br>&gt;PASSWORD Need &#39;Auth&#39; username/password p=
rompt=2E The prompt<br>is appended with &quot;UN:foo64&quot; where foo64 is=
 the pre-defined<br>username, base64 encoded=2E<br><br>This is treated as a=
 hint, not an enforced value=2E The management<br>client still responds wit=
h both username and password obtained<br>from the user=2E Whether the manag=
ement client allows the<br>user to input a different username is left to th=
e client<br>implementation=2E<br><br>Only clients that announce version &gt=
;=3D6 are prompted this way=2E<br><br>This helps to fix user reports on Ope=
nVPN-GUI not respecting username<br>set in the config file=2E<br><br>Change=
-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b<br>Signed-off-by: Selva Nair=
 &lt;selva=2Enair@gmail=2Ecom&gt;<br>---<br>M doc/management-notes=2Etxt<br=
>M src/openvpn/manage=2Ec<br>2 files changed, 44 insertions(+), 0 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/69/2069/2</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/doc/management-notes=2E=
txt b/doc/management-notes=2Etxt</span><br><span>index eac91a4=2E=2E2662474=
 100644</span><br><span>--- a/doc/management-notes=2Etxt</span><br><span>++=
+ b/doc/management-notes=2Etxt</span><br><span>@@ -394,6 +394,28 @@</span><=
br><span>   response along with the username and password formatted as desc=
ribed</span><br><span>   in the Challenge/Response Protocol section below</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  E=
xample 10:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;PASSWORD:Need &#39;A=
uth&#39; username/password UN:&lt;user-base64&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &gt;PASSWORD:Need &#39;Auth&#39; username=
/password UN:&lt;user-base64&gt; SC:1,Please enter token PIN</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  These work exactly as Examples 3 and 8, respectivel=
y, with the following</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  difference=2E The prompt has an additional word &quot;UN:&lt;user-base6=
4&gt;&quot; where</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
&lt;user-base64&gt; is the base64 encoded form of a pre-defined username=2E=
 This</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  may be a use=
rname inlined in the config file or read from an external</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  user-pass file=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  The management client is expected to show the base64 d=
ecoded value to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  th=
e user=2E Whether the user can change this username or not is left to</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  the client implementati=
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  The response from the managemen=
t client should follow the same format</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  as in example 3 or example 8, as applicable=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  This prompt is shown only if the management-=
client announces a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 version &gt;=3D 6=2E Older clients will see the prompt shown in Example 3<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  or 8=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> See the &quo=
t;Challenge/Response Protocol&quot; section below for more details</span><b=
r><span> about examples 8 and 9, including how the management interface cli=
ent</span><br><span> should respond=2E</span><br><span>@@ -530,6 +552,7 @@<=
/span><br><span>     &gt;PK_SIGN:[base64],[alg]     -- version 3 or greater=
</span><br><span>     &gt;PASSWORD:Need &#39;Auth&#39; username -- version =
4 or greater</span><br><span>     multiline password from client -- version=
 5 or greater</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pr=
eferred username in &gt;PASSWORD prompt -- version 6 or greater</span><br><=
span> </span><br><span> COMMAND -- auth-retry</span><br><span> ------------=
---------</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn=
/manage=2Ec</span><br><span>index 0fc9ee2=2E=2E65e2881 100644</span><br><sp=
an>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2E=
c</span><br><span>@@ -71,6 +71,7 @@</span><br><span>     MCV_PKSIGN_ALG =3D=
 3,</span><br><span>     MCV_USERNAME_ONLY =3D 4,</span><br><span>     MCV_=
MULTILINE_PASSWORD =3D 5,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    MCV_PREFERRED_USERNAME =3D 6,</span><br><span> };</span><br><span=
> </span><br><span> struct management *management; /* GLOBAL */</span><br><=
span>@@ -3670,6 +3671,26 @@</span><br><span>             buf_printf(&amp;al=
ert_msg, &quot; MSG:%s&quot;, up-&gt;username);</span><br><span>         }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (up_query_mode =3D=3D UP_QUERY_USER_PASS</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &amp;&amp; (man-&gt;connection=2E=
client_version &gt;=3D MCV_PREFERRED_USERNAME)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &amp;&amp; up-&gt;username[0])</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            /*</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+             * The buffer up is prefille=
d with username from auth-file or inline=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+             * Indicate it in the prompt as base64 =
encoded=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
    */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c=
har *user64 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (openvpn_base64_encode(up-&gt;username, (int)strlen(up-&gt=
;username), &amp;user64) !=3D -1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                buf_printf(&amp;alert_msg, &quot; UN:%s&quot;, user=
64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_NONFATAL=
, &quot;ERROR: could not base64-encode username&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            free(user64);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>         if (sc)</span><br><span=
>         {</span><br><span>             buf_printf(&amp;alert_msg, &quot; =
SC:%d,%s&quot;,</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail">change 2069</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac23d5141a8c29e=
239d0f2aeea497d3a002e609b </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2069 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--C09E4P6yMY4=--


--===============8632187288540521689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8632187288540521689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8632187288540521689==--

