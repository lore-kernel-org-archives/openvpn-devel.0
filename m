Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A4606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CT4Kj/Jh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hUpidd2h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IzLtYQGn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D/AdwiHs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VjxHngfXCqFtng0WonYfQhYneEmPfioR+cu8uE4uaxs=; b=CT4Kj/Jhm7OJujX4+lMg7lYekj
	wtqLnjNzrc92OCN6bxZm+n7N3mg9RZdKQ2wegOV0xmaxzWTMkMLbpcBHArKdtDyD+lkcKB45rL5Uc
	RbohjFtIkp277WWsYG/VEMJlkdSc3F1eunU4ylBDj7eXgmeHxqTyxtDEoAQbRxaC5SQc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVrSQ-000000007N5-2Hwv;
	Tue, 24 Nov 2026 14:25:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVrSO-000000007My-4BoD
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:25:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MtoegAVlhvCudIKqhGznPk0vJqvkujxDJmJu7RCdTEA=; b=hUpidd2hbZDJK4pv5mEmhfFzP+
 QUiwTi9Yn7Dnz6S3BljEdRrTTc/4/GGqmCSPS+40hPnUQRKB14aZg7n0e3e9gg/jeoxDKy/24DNLc
 BfHtkMbxyXMrVKnqNuUAJ7gMXBKW+5vrcurLowV7mSorp860GWWPMZWN268WKUYbGNHA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MtoegAVlhvCudIKqhGznPk0vJqvkujxDJmJu7RCdTEA=; b=IzLtYQGn56ExpqzWJgppUWrwT7
 F0QfqrlaPjjZGJVNqhiusy07uni1VVenuk4SaRit9bkv9FHKc42TmFHgc5M2VxO6BsQSWDe2Iflwk
 pT7fUjbrg09DSP4K2FloGFOmLQixxVIvIXezAvCGsYASJK7CzgXZbwuSUIsBZz3YXBVk=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVrSN-000000003fu-1Lpu for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:25:16 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso55957365e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795530309; x=1796135109; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MtoegAVlhvCudIKqhGznPk0vJqvkujxDJmJu7RCdTEA=;
 b=D/AdwiHsfDC2IQ+b4qjIYmtVVIi0z9hpHfGxZ86OwWu+w2oyqWtPNNn3HU9jrEPOoJ
 DkxQ1d7/Aso3PxT5eyssOAYAtg1V+27B2EAwrsSf2Ds96B5eYdWqsPN9Trrg708uTIZs
 iv6kb1UJouxXo3D6kU+Ttjopd6c7rHfAaP0tOd4XRCHNTw1ZxgU4iLYtbJzzfXKYSYQ8
 z9dsR1sOtuAVOrB/qI1X1kmOFGcbVNm2BHjyTP5Kiv/yTrJ6e3704Jtt7FXFejZoUv0i
 xoVbVh5qLGZTvfxdlkdLHHnQzhIolxmjyMK+cHlQcp9/EWAXHU9GrotXAIoHb40UEYIJ
 FPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795530309; x=1796135109;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MtoegAVlhvCudIKqhGznPk0vJqvkujxDJmJu7RCdTEA=;
 b=BXI2tsC2awRAfMNZwXacVCdeYCsQAaqhVdhdfxKeu4UJgHJvFZjUGO8DuVqQjI1x98
 SFixyOCiryDaGYeEfiwT16B8y4ty0UkRtrPiuOrNyGQRwerLmGDJ93m7XTpLJmgFHMxv
 ef3hK08vap1mgz/k81qq6SEsdCwo67zeuzz+VtByB+bBs+k8mjftFraYvIJuWPHRgmts
 vz8e//2ls5GGoT/QedcGwWVK1yXlpL94XzAM5PGCY5PKKZh8UMURjsT/PJapIGpwSxN6
 IrBq34nQKfi6mHnHZSHR9GC3KDLesmYvtx5jFyXI3vZtRO1wnnd9KLdA0KS3CWitYOHK
 6E0w==
X-Gm-Message-State: APuU4Z8TwBGWwGG4rqkaT9HIxJyh4Tb/dqnGOxiGPu5i1gzswdSMFZfw
 LvGEPHCaOC8GL+Cwyb29IPB4+l/JYBqGaRTiWD4H/VMr2ViE5X5mqsdDPx4cGHDlMGulGfHHCFJ
 ofzBobrWBAi6Uaj8jlN5Uij7pooQA79rTCisP4XkeAG7ecSmOD62xserBKJKq3UemzwoH9SZ0K0
 HZSYFOxw==
X-Gm-Gg: AZFdTZcAH5TEF1E1F+lmaThw0UdYMiqCIYkyJudkQbtzB/i0W/A4g5VfEXxrnHRUTMn
 4Bk/hyFfirTc3IFHgFog7PMWGXjU+B6xwbonC5d0GzEQifnsHNfuGMUkyHqLKwE5nqFFnGSSqpt
 vZ7fVroTfkJu+rL/jO7AsMdTkfYl5kKyx08uNk80MTlpVPZUhjHeDy1d0BEc311CMKBrIEHJmI8
 WbJHeTgjxzukcY730zsILAXqt27QAXFDt5qwOy6V4mDuE1ZSy4DjH+KtdeQHm30OTL13C8IXNhH
 j7U4qW+cm0QMK/Aqw6fLEdUoVt6LB1iA2T3j4k5EzMrQBxyB9ZrIbsifRpUU0C02UM5gQWdn4h3
 5IN0ad+rmYPzu65ctvG0hGRYwDVMHxH22E40HzSkqtAB57BcfO/3Hq+iuOvyDdhHhgB3RXSs/uH
 BhZEqBRgnPaA0PITJfqyBVOLbB7oraN6IMlprgMRnq5dlbGt2bFz2JFvek8mvL8iNN3jXpBos6V
 Aw+tO3mJvnKqAW7XxDNGoRDqJCnBSQJyQppARWHqXxA7RikJrIDLc6YEZhsFsUp8dHHvJe2TJsf
 4QdTq118Ae4OFL9eiYchjNlQTi7hu9Zyx/R96HyIf13ElqBbPF7wp41WJXOBIGjs7HAYQlJZ0uc
 XHRO1CDbXOealzj88ztRhHjBHpzLOC0w9IYietrf5dstSWW4dU8Foe+KdvsstQAuy7SFA22BmBy
 uC5fleyxU+AfI3h30=
X-Received: by 2002:a05:600c:820c:b0:4bb:7987:fbbc with SMTP id
 5b1f17b1804b1-4bb887c29b4mr269986825e9.1.1795530308622; 
 Tue, 24 Nov 2026 06:25:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm602144185e9.13.2026.11.24.06.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:25:08 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 14:25:07 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4571033af79092d85657b176044497245faf5e39
X-Gerrit-Change-Number: 2219
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2219?usp=email>
X-Gerrit-Commit: d159055ede16e322548e46d154523e2fc31ccf74
In-Reply-To: <gerrit.1795023922000.I4571033af79092d85657b176044497245faf5e39@gerrit.openvpn.net>
References: <gerrit.1795023922000.I4571033af79092d85657b176044497245faf5e39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDIzOTIyMDAwLkk0NTcxMDMzYWY3OTA5MmQ4NTY1N2IxNzYwNDQ0OTcyNDVmYWY1ZTM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bdc6d0399834d50e76dad4f83eec8a9e9d9cd380-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVrSN-000000003fu-1Lpu
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: let the
 interactive service add routes again
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0466216816225582077=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0466216816225582077==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jYP2hnakSmY="; charset=UTF-8

--jYP2hnakSmY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Heiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by R=C4=83zvan Cojocaru


Change subject: options: let the interactiv=
e service add routes again
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

options: let the interactive service add routes again

Since =
c139e82d the service puts --msg-channel in front of the user
options, a --r=
oute-method from the config overrides the service
route method implicitly s=
et by --msg-channel, and adding routes
in turn fails without admin rights=
=2E

Force the service route method in postprocessing when --msg-channel is=

used, independent of the option order=2E

Github: OpenVPN/openvpn#1151
Cha=
nge-Id: I4571033af79092d85657b176044497245faf5e39
Signed-off-by: Heiko Hund=
 <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219
Message=
-Id: <20261118181613=2E2865-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41648=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M doc/man-sections=
/windows-options=2Erst
M src/openvpn/options=2Ec
2 files changed, 12 insert=
ions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/19/2219/2

diff --git a/doc/man-sections/windows-options=
=2Erst b/doc/man-sections/windows-options=2Erst
index 8d7dcbb=2E=2E87c7008 =
100644
--- a/doc/man-sections/windows-options=2Erst
+++ b/doc/man-sections/=
windows-options=2Erst
@@ -179,6 +179,10 @@
   :code:`exe`
         Call the=
 route=2Eexe shell command=2E
 
+  When OpenVPN is started by the interacti=
ve service, the service adds
+  the routes and a ``--route-method`` given i=
n the configuration is
+  ignored=2E
+
 --service args
   Should be used wh=
en OpenVPN is being automatically executed by another
   program in such a =
context that no interaction with the user via display
diff --git a/src/open=
vpn/options=2Ec b/src/openvpn/options=2Ec
index 2068393=2E=2E1a8604e 100644=

--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -2494,6 +24=
94,14 @@
         options->ifconfig_noexec =3D false;
     }
 
+    /* the =
service adds the routes, --route-method must not override it */
+    if (op=
tions->msg_channel && options->route_method !=3D ROUTE_METHOD_SERVICE)
+   =
 {
+        msg(M_WARN, "WARNING: ignoring --route-method, routes are added=
 by the interactive service");
+        options->route_method =3D ROUTE_MET=
HOD_SERVICE;
+    }
+
+    /* this depends on options->route_method, which =
is set above */
     remap_redirect_gateway_flags(options);
 
     /*

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4571033af79092d8565=
7b176044497245faf5e39
Gerrit-Change-Number: 2219
Gerrit-PatchSet: 2
Gerrit-=
Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--jYP2hnakSmY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Heik=
o Hund=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">optio=
ns: let the interactive service add routes again<br><br>Since c139e82d the =
service puts --msg-channel in front of the user<br>options, a --route-metho=
d from the config overrides the service<br>route method implicitly set by -=
-msg-channel, and adding routes<br>in turn fails without admin rights=2E<br=
><br>Force the service route method in postprocessing when --msg-channel is=
<br>used, independent of the option order=2E<br><br>Github: OpenVPN/openvpn=
#1151<br>Change-Id: I4571033af79092d85657b176044497245faf5e39<br>Signed-off=
-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Co=
jocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2219<br>Message-Id: &lt;20261118181613=2E2865-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg41648=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M doc/man-sections/windows-options=
=2Erst<br>M src/openvpn/options=2Ec<br>2 files changed, 12 insertions(+), 0=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/19/2219/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-secti=
ons/windows-options=2Erst b/doc/man-sections/windows-options=2Erst</span><b=
r><span>index 8d7dcbb=2E=2E87c7008 100644</span><br><span>--- a/doc/man-sec=
tions/windows-options=2Erst</span><br><span>+++ b/doc/man-sections/windows-=
options=2Erst</span><br><span>@@ -179,6 +179,10 @@</span><br><span>   :code=
:`exe`</span><br><span>         Call the route=2Eexe shell command=2E</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  When =
OpenVPN is started by the interactive service, the service adds</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  the routes and a ``--route-me=
thod`` given in the configuration is</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  ignored=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> --service args</span><br><span>   Should be use=
d when OpenVPN is being automatically executed by another</span><br><span> =
  program in such a context that no interaction with the user via display</=
span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec</span><br><span>index 2068393=2E=2E1a8604e 100644</span><br><span>--- =
a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</sp=
an><br><span>@@ -2494,6 +2494,14 @@</span><br><span>         options-&gt;if=
config_noexec =3D false;</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* the service adds the r=
outes, --route-method must not override it */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (options-&gt;msg_channel &amp;&amp; option=
s-&gt;route_method !=3D ROUTE_METHOD_SERVICE)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_WARN, &quot;WARNING: ignoring --route-method, rou=
tes are added by the interactive service&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        options-&gt;route_method =3D ROUTE_MET=
HOD_SERVICE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* this depends on options-&gt;route=
_method, which is set above */</span><br><span>     remap_redirect_gateway_=
flags(options);</span><br><span> </span><br><span>     /*</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219=
?usp=3Demail">change 2219</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2219?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I4571033af79092d85657b176044497245faf5e39 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2219 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>

</body></html>
--jYP2hnakSmY=--


--===============0466216816225582077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0466216816225582077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0466216816225582077==--

