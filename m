Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C622CCF2DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s/q8zKj5GmPjjLAoc/U8+/lRlFPaR3teSideYnIjvLg=; b=RvFX1foP12Ntrg1etQN+0wEL5h
	dNZAjA6GXh0cINOPd/Aymrd04WwrMs4v9f7XD7Flhc9t8VkGZrhlzb5/Y42PHk/4NPJdYqbC3egbk
	Uh2AlbQ2VMiX68hI8Pt/ZuKj5w/CumW7aqjn8wkLseD9ymMaDVzS2XsJhB3+kPNKLIOE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIn70-0004R2-Q4;
	Mon, 19 Oct 2026 13:09:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIn6x-0004Qq-9G
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:09:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iHsgkZuU3ssvsMLec5zpInFgfZQtnH8r5q0B2ndYggM=; b=DAlfHKDg5rdrhLdgZh2Emkr7o8
 g6djopvrD1+h7UQZnCbQKGW8YgfuNC1yZ12PkgcrD1UaFz7EgASweVRsd4yMAo7m0T1LqRHDby0zy
 CNrbEZK68m4CGuSRKAaycWM32vltQ3g1Ainj8bEAKp10TJBYFGzjEW81lvHsI5o5uZhE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iHsgkZuU3ssvsMLec5zpInFgfZQtnH8r5q0B2ndYggM=; b=e
 lsuoddBtOdosPVAmzoNyT/4zBVDmisdMoh6XkQ9GovCyELI0uZlKQybpr98jbxbrHOJR9c6IMhGbv
 dU/Zg1UXb6v7NUylUcnip5S56cLcQkKEpwT9kCow1RcEX84W+DwOC5YWRaPnL6tCa1c00V3MShrGU
 xORsU5egjnDkOZdM=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIn6x-0007mP-AU for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:09:07 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48de6a62a4cso1726418f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 06:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792415341; x=1793020141; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iHsgkZuU3ssvsMLec5zpInFgfZQtnH8r5q0B2ndYggM=;
 b=KHOINR7Did6QJNuHu+fUPztJgFjS0oVk9WyJ3c8HvfMCR8TXKG7WWDmqnwGxU0ucaO
 pK9KcnYyU7TzURyFpdan4F1Rxo9vLVpzipSSxU+2WuFdfYtLUpioYtKWq7YNgvjTpwNA
 qijf4OGxjYwFFIJZ/DvVyMAOwzhlsIkUXwKWPWu5P4ZiPHctAgG5YbQhIN7Nqx23rlP6
 BpEvuz3s3JgbsK/9wT+NPpEmSBfdcw/ZS/pRQjAmD+5LBeWtooPbXoXnKsu24Pw4nSPC
 Cjdl62D+lVGP/pI+R2JNAVpdbbag+E9+rzwcogr88F0v2qs9Gzy1m3b+e9yuUBacC8Qd
 CqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415341; x=1793020141;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iHsgkZuU3ssvsMLec5zpInFgfZQtnH8r5q0B2ndYggM=;
 b=c2c4ZXdysJrasX5I6qCNixeHsnQIehFB1XU8HVpuTZaMTTB3ARyQHCEtz2u9a2T4E9
 sG1QTrC6gAGjros/gwBC8jb7tRV1WKHvibidSXlxIt3zfXjvv149xEOLaz/D/xXtz2aC
 HCWSrtPkeR3W+Tw6BYEE9AhYR+vFqG1u7RA8lXq9zw+MducUchOa5dQApha9OyTKQcMh
 +nn348prXR8CTNSkZcwEW7+oIv70kEQH5ugyjyPk223PNR0T54u9/9NVqVLr0GyrR89d
 mCu/KHNadQvj5fwePSlEXiWU9z852vVr9DIK82sU+06bDNyjX+Fpf8coJ52xSabe4WQD
 DFqQ==
X-Gm-Message-State: AFq9FYLU62Pdu3vq4Jg8Nbh8KcOTD4U17U9gSFQoRzDxw+Bhui0yIFJ6
 qXd5NQHkt/swOGRaWb5iroiq8TmO3HR1enciwPRks2o39jHc57DyK/Yr6Ca5prk9UmRAq+Tc/yl
 gZKaczAlJNNoKm5Ps5B69JYdcXFxvPODbNhZZBzM7ScqpnXbuiyg0V/UjtSc7O6j1L464
X-Gm-Gg: AYBFou3laitWZQRQwRUXm8TA/yUt2VntqsnxUlVVm/cVqMbai17B1kxTSDytsPVxTza
 l2DWNWBUfu/5r9FdO0ZJaqUj+6HMo5mryqkyRwmFWv1IVGWpf+SjmStTCFV3TIQqrlK9uxVLgIy
 cS8xgiUmdujEn8w2m0wdGgnjEkfBtIuf9R6f7HbepNwjcJep4tSuNExMKde5QQr37REZ07TSZtL
 sWiOarhvkDArUTJDjdq34BIXrjOzd2ACOCqsqlgmI/31CtcW19U3xUK1/4pO5TMGlrMb28jzTyB
 nJvZvnhq0XWLlYM4QIuG0pqIUXt4FZoXRJfN1pEfayMujk5O8VPdWgbMVQV6ZTLrmhO7mXF+zeT
 h5iAO6eCqoFGmOxhEoTeSOK+tl9Gx9j3D0zVrR7KXEyDqtC9FKCM3goFQgSqrcf10PyolRiWFuZ
 wfd9HL+OdzNh2N51K/ZPX9yW7tBY4XaPSpaxOOgi3q/YHUDVSVlvfgAjWx0JD9ABNUNE6Qsm1MX
 tBSIdA0eOBBhlzHGtg6/qnbyvXxqq3SllgU6O9tyYBJaLbBBDJ6e4YrJaLDdBl1CRIHjhj5tDn/
 tNgBMXBTLUpLYGrDV+gitU2faV5Qh4wTfj7AWVmhm2BZAZ7BgsH0YP4dPaGB
X-Received: by 2002:a05:6000:4694:b0:48c:4658:602b with SMTP id
 ffacd0b85a97d-48e07bb3151mr10856606f8f.10.1792415335983; 
 Mon, 19 Oct 2026 06:08:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd50aafbsm24401415f8f.52.2026.10.19.06.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:08:55 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 13:08:54 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iae70a03c2bcc502f62133abcbfd1c92528e65d69
X-Gerrit-Change-Number: 2007
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2007?usp=email>
X-Gerrit-Commit: 9f5effdbe1734fb24de01e439ac2276e11f5987d
In-Reply-To: <gerrit.1792255622000.Iae70a03c2bcc502f62133abcbfd1c92528e65d69@gerrit.openvpn.net>
References: <gerrit.1792255622000.Iae70a03c2bcc502f62133abcbfd1c92528e65d69@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLklhZTcwYTAzYzJiY2M1MDJmNjIxMzNhYmNiZmQxYzkyNTI4ZTY1ZDY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a503b43dcf23553775936e53a63dcc8260aea1a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIn6x-0007mP-AU
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify_mbedtls:
 Avoid conversion warning in x509_get_fingerprint
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4775215282025156849=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4775215282025156849==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g/yJGOO0s3g="; charset=UTF-8

--g/yJGOO0s3g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
007?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: ssl_verify_mbedtls: =
Avoid conversion warning in x509_get_fingerprint
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_verify_mbedtls: Avoid conversion =
warning in x509_get_fingerprint

We already convert mbedtls_md_get_size to =
int in other
places, so just use that here as well=2E

Change-Id: Iae70a03c=
2bcc502f62133abcbfd1c92528e65d69
Signed-off-by: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2007
Message-Id: <2026101815=
4604=2E24008-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ec=
om/openvpn-devel@lists=2Esourceforge=2Enet/msg40020=2Ehtml
Signed-off-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_verify_mbedtls=
=2Ec
1 file changed, 1 insertion(+), 10 deletions(-)


  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/07/2007/2

diff --git a/src/=
openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index b=
9a36a6=2E=2E6680ccc 100644
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/s=
rc/openvpn/ssl_verify_mbedtls=2Ec
@@ -542,25 +542,16 @@
     return FAILURE=
;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic=
 push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static stru=
ct buffer
 x509_get_fingerprint(const mbedtls_md_info_t *md_info, mbedtls_x=
509_crt *cert, struct gc_arena *gc)
 {
     const size_t md_size =3D mbedtl=
s_md_get_size(md_info);
     struct buffer fingerprint =3D alloc_buf_gc(md_=
size, gc);
     mbedtls_md(md_info, cert->raw=2Ep, cert->raw=2Elen, BPTR(&f=
ingerprint));
-    ASSERT(buf_inc_len(&fingerprint, md_size));
+    ASSERT(=
buf_inc_len(&fingerprint, (int)md_size));
     return fingerprint;
 }
 
-#i=
f defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#end=
if
-
 struct buffer
 x509_get_sha1_fingerprint(mbedtls_x509_crt *cert, stru=
ct gc_arena *gc)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2007?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Iae70a03c2bcc502f62133abcbfd1c92528e65d69
Gerrit-Change-Number: 2007
G=
errit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>

--g/yJGOO0s3g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2007?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">ssl_verify_mbedtls: Avoid conversion warning in x509_get_fingerprint<br=
><br>We already convert mbedtls_md_get_size to int in other<br>places, so j=
ust use that here as well=2E<br><br>Change-Id: Iae70a03c2bcc502f62133abcbfd=
1c92528e65d69<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2007<br>Message-Id: &lt;20=
261018154604=2E24008-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Ema=
il-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40020=2Ehtml<br=
>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M sr=
c/openvpn/ssl_verify_mbedtls=2Ec<br>1 file changed, 1 insertion(+), 10 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/07/2007/2</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_ve=
rify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>index=
 b9a36a6=2E=2E6680ccc 100644</span><br><span>--- a/src/openvpn/ssl_verify_m=
bedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=2Ec</span><=
br><span>@@ -542,25 +542,16 @@</span><br><span>     return FAILURE;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
static struct buffer</span><br><span> x509_get_fingerprint(const mbedtls_md=
_info_t *md_info, mbedtls_x509_crt *cert, struct gc_arena *gc)</span><br><s=
pan> {</span><br><span>     const size_t md_size =3D mbedtls_md_get_size(md=
_info);</span><br><span>     struct buffer fingerprint =3D alloc_buf_gc(md_=
size, gc);</span><br><span>     mbedtls_md(md_info, cert-&gt;raw=2Ep, cert-=
&gt;raw=2Elen, BPTR(&amp;fingerprint));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ASSERT(buf_inc_len(&amp;fingerprint, md_size));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_inc_len(&a=
mp;fingerprint, (int)md_size));</span><br><span>     return fingerprint;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> struct buffer</span><br><span> x=
509_get_sha1_fingerprint(mbedtls_x509_crt *cert, struct gc_arena *gc)</span=
><br><span> {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2007?usp=3Demail">change 2007</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2007?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae70a03c2bcc502=
f62133abcbfd1c92528e65d69 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2007 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--g/yJGOO0s3g=--


--===============4775215282025156849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4775215282025156849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4775215282025156849==--

