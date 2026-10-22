Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F63606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YqxKZPnF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jMNcuO/l;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OS3ZWL3h;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=H0JGycQ1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ttqS4GeR5EISkDZRux4WO1m8MNAik2r/Ko9nv7lFKRg=; b=YqxKZPnFvMx6MSLSSwBW3EggAf
	yJaQod67rENZxXyqP0jhdk9WYbRC8jVeqqVydihjlm/BEeO5uMKwwK7tMfsDdmiTxbPOGp+/CRlNW
	z1C+6RL/O8HKXLR81/6fpxo8mvsV/TO5g7HH//KEF8JhBI5TzfF00FHAKEGwKKnl/Asw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJshO-000000005Lu-2NEa;
	Thu, 22 Oct 2026 13:19:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJshJ-000000005LS-3wT5
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 13:19:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q5eoBSPQ0kXuWF2qlIWVv5Cbcfj+SWiQeQTMv+nvdW0=; b=jMNcuO/lVy01nOceE9QMEp/dZT
 cQg9yD9XUOFAn+x07t3ShfzuwrMqWfFlYtfR5pxOpd0CHwflVBevCDqIfy/mpTEDzSLNHCI2er6jv
 bGE+K8A72TTbCRojkhsjlEE+qQiWRrJ/CQX7XDCRCXoxZ1TH1USTegHuig3MfkdzLNgw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q5eoBSPQ0kXuWF2qlIWVv5Cbcfj+SWiQeQTMv+nvdW0=; b=OS3ZWL3hdqiPtPVIz3dO++Uc3J
 rzV2IBUqViYf3kCoJRLytbY8zAkARRfq3gcm6WamrXixSSOvs0f0Gw6wdzwwTVpIrq8YbrqyyfOys
 8lubuvw5FMfGvgUo0G625pRrEgTGY3P+CeuL0nkRzGNrRjSlbYGuT/XBsPkL2PwvJ/BU=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJshI-000000007kA-0Bky for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 13:19:09 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a2001dd4e7so19745675e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792675141; x=1793279941; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q5eoBSPQ0kXuWF2qlIWVv5Cbcfj+SWiQeQTMv+nvdW0=;
 b=H0JGycQ1K9YNUb4sC1dlHiiMIm1RZOexd61a+XdfDZF6AyxKNM0ZJdd99Rjdb3M8dr
 3ID5MeS9Qlhf8GFkzhKPQxtFko4A+6R4BElXUC7LCm+L+9bGlclI5XxFNejFgqfcy+cy
 iAADokbXinvBTxWcIsxdKHlihx0kOXF4j9AjU6vekKJVrysGrX+wG+j7/bix6F6iLIAh
 WUbJ2CKHpsFb+EWfAO5qMrGAt85h+dxbydjrOujftI0S4f1uXXoKMFIW41Zt3BN8ZHoR
 ESEcI5oLGFf6dO5eJQXVKLI2uvJkxCbZ+CsrTcAkl6mOJGaYO7WBHniyoIJDHSV/lZyp
 j4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675141; x=1793279941;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Q5eoBSPQ0kXuWF2qlIWVv5Cbcfj+SWiQeQTMv+nvdW0=;
 b=kZLceXR+mdd1WEgfbFTZ1jiwfgIfcmRpnnkPzSWKaVAKIO3jI+P0hPk7F9QxY0jvWg
 DnNz5zQHEMewl4d5UlILTr9S+I8sbWAir/cqlToosLgZJjF0uTYOoMh+dZ6o1N/xEG77
 td2VzuNe8lGfBAj3rVSRovhk0aBRpZCw0qockSkkv7NEQSzNon4yCA1vFfUpKJ/g2E8n
 R62trlo6PZfLCDCcXeH5nY88z8Ho6Z0VcqYax7tdwxGN0wWPGAUy6TYawOt+cxQH9CH6
 MbdiDDEuauobq9DjsfX0Z+IEBj2AL5aJXdNWjpI/Wo7iIZQEfTKXDWCes3HuNk+x3aZu
 QOMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgUW7X3IFIPuggdubv4zy3GG3HJcCEkqr23k/xdgXsQNpBoDkS6LQ3dOT/vDh8bvHNmDwxtIAuSa0rZTw8@lists.sourceforge.net
X-Gm-Message-State: AFq9FYITrzdVgj00oesVC6UkSe+xj82x9zjG+cat9IOQixTZj38497pK
 LMubNCLNbVzC0m/cGAg79rJo2dsuSHcsRiqyb6Gy9W57EPVQzujRYhvEE/QK0xdDoriZTWaX78k
 1UAef+jy+lfxlAC0PS+Fz0E7Ukesq2DJQzuwx5VwXzixYjcHV4a80Z0Tdl/+fGIBg3rzE
X-Gm-Gg: AYBFou0h4MJQI7+G9WwN33gP8eBD43Fq4jvLJ70y04tAbRsYAdDzlGipBdMQhv4dtRs
 iqNtv151mzV25TJFKJeVyFcozO3++QEyy56EplfKqekLTxmVSXMvgNyqLyXfNJDn9YeUeWJpKeG
 qq+CdJLz4OGnCH8uVRtxhiz60H9WLhGNmox5M/7DVy2aZxFF3TsBJcQM9zUuS0UJhjjF5YiDJfs
 r8g8DZRrpTaUP61g9XvMjPUGctdWkLsqNzdTVb0bv5zGSUAb9Wrcunu76r0Nz18+D+iMzncoHDb
 QKgfUHAZORn8stw9Nw8tD91arjDP3t0yIWRnSwf6ctQsgSyOh1WqjMRBeZibH7LOvqWEL0WPJ7m
 bZwBHPUACoTh30O8vJPLlTDIkflfojvmKaUdwrombfHrvKdyYfDGRQUtrJ6/hg96yVVNdsESQsw
 dmo1wzH4LVdHP2Q7tVC5jucWhf5QoodupnqaWIX3wEzanwoU607ZfzZwzxdkcGWRCAyTTNjcljl
 GyROgo7MA0bK8XGTReoBVuh37lAMV7INrWJUQP7bB6avAR5QFu0QAjKh2pMedzNUak2hSgGXJDR
 DZdmUUg2sg/gTmNjpeG9EDDBtsxk/121cCn1V9mR5gHvbEJpVCnThe9lz/V3Vg3ObptdBmye8Os
 VQxsfVf4ehGqhjxrlc+3CCyq0Z934ZCemVmWgnRll0w==
X-Received: by 2002:a05:600c:524f:b0:4a1:ad27:e797 with SMTP id
 5b1f17b1804b1-4a1fdaf71f5mr102343445e9.6.1792675141268; 
 Thu, 22 Oct 2026 06:19:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203a350b0sm75706825e9.9.2026.10.22.06.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:19:00 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 13:19:00 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I20d367dd8251bf39856ae521f380cfdc8df64177
X-Gerrit-Change-Number: 2028
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2028?usp=email>
X-Gerrit-Commit: 74ba58631ae2b53668c2b5d372e4f7ed28e02223
In-Reply-To: <gerrit.1792667802000.I20d367dd8251bf39856ae521f380cfdc8df64177@gerrit.openvpn.net>
References: <gerrit.1792667802000.I20d367dd8251bf39856ae521f380cfdc8df64177@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjY3ODAyMDAwLkkyMGQzNjdkZDgyNTFiZjM5ODU2YWU1MjFmMzgwY2ZkYzhkZjY0MTc3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4869fd37fcb14e33e2902a8a8e959c5eaaecbbfc-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJshI-000000007kA-0Bky
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Call
 AC_PROG_CC before AC_USE_SYSTEM_EXTENSIONS
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5914421168205873885=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5914421168205873885==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i7tjACuvQGc="; charset=UTF-8

--i7tjACuvQGc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2028?usp=3Demail )

Change subject: configure: Call AC_PROG_CC =
before AC_USE_SYSTEM_EXTENSIONS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

configure: Call AC_PROG_CC before AC_USE_SYSTEM_EXTENSI=
ONS

AC_USE_SYSTEM_EXTENSIONS requires AC_PROG_CC, so the later explicit
ca=
ll expanded it a second time and repeated the C standard checks
as "(cached=
)"=2E

Change-Id: I20d367dd8251bf39856ae521f380cfdc8df64177
Signed-off-by: =
Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/202=
8
Message-Id: <20261022123500=2E27256-1-gert@greenie=2Emuc=2Ede>
URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4009=
2=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M config=
ure=2Eac
1 file changed, 5 insertions(+), 5 deletions(-)




diff --git a/c=
onfigure=2Eac b/configure=2Eac
index e31a7ff=2E=2E0ac61b4 100644
--- a/conf=
igure=2Eac
+++ b/configure=2Eac
@@ -45,6 +45,11 @@
 AM_INIT_AUTOMAKE(foreig=
n subdir-objects 1=2E16) dnl NB: Do not [quote] this parameter=2E
 AM_SILEN=
T_RULES([yes])
 AC_CANONICAL_HOST
+AC_PROG_CC
+# AC_PROG_CC doesn't output =
any useful information
+AC_MSG_CHECKING([compiler version])
+CC_version=3D$=
($CC --version | head -n1)
+AC_MSG_RESULT([$CC_version])
 AC_USE_SYSTEM_EXT=
ENSIONS
 
 AM_EXTRA_RECURSIVE_TARGETS([build-tests])
@@ -380,11 +385,6 @@
 =
	pkg_config_found=3D"(${PKG_CONFIG})"
 fi
 
-AC_PROG_CC
-# AC_PROG_CC doesn=
't output any useful information
-AC_MSG_CHECKING([compiler version])
-CC_v=
ersion=3D$($CC --version | head -n1)
-AC_MSG_RESULT([$CC_version])
 AC_PROG=
_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S

-- 
To view, visit https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2028?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I20d367dd8251bf39856ae521f380cfdc8df64177
Gerrit-Change-Num=
ber: 2028
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--i7tjACuvQGc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2028?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">configure: Call AC_PROG_CC before =
AC_USE_SYSTEM_EXTENSIONS<br><br>AC_USE_SYSTEM_EXTENSIONS requires AC_PROG_C=
C, so the later explicit<br>call expanded it a second time and repeated the=
 C standard checks<br>as &quot;(cached)&quot;=2E<br><br>Change-Id: I20d367d=
d8251bf39856ae521f380cfdc8df64177<br>Signed-off-by: Razvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028<b=
r>Message-Id: &lt;20261022123500=2E27256-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg40092=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M configure=2Eac<br>1 file changed, 5 insertions(+), 5 dele=
tions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/configure=2Eac b/configure=2Eac</spa=
n><br><span>index e31a7ff=2E=2E0ac61b4 100644</span><br><span>--- a/configu=
re=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -45,6 +45,1=
1 @@</span><br><span> AM_INIT_AUTOMAKE(foreign subdir-objects 1=2E16) dnl N=
B: Do not [quote] this parameter=2E</span><br><span> AM_SILENT_RULES([yes])=
</span><br><span> AC_CANONICAL_HOST</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+AC_PROG_CC</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# AC_PROG_CC doesn&#39;t output any useful information</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+AC_MSG_CHECKING([compiler version=
])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CC_version=3D$($C=
C --version | head -n1)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+AC_MSG_RESULT([$CC_version])</span><br><span> AC_USE_SYSTEM_EXTENSIONS<=
/span><br><span> </span><br><span> AM_EXTRA_RECURSIVE_TARGETS([build-tests]=
)</span><br><span>@@ -380,11 +385,6 @@</span><br><span> 	pkg_config_found=
=3D&quot;(${PKG_CONFIG})&quot;</span><br><span> fi</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-AC_PROG_CC</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-# AC_PROG_CC doesn&#39;t output any use=
ful information</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_MSG=
_CHECKING([compiler version])</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-CC_version=3D$($CC --version | head -n1)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-AC_MSG_RESULT([$CC_version])</span><br><span> AC=
_PROG_CPP</span><br><span> AC_PROG_INSTALL</span><br><span> AC_PROG_LN_S</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2028?usp=3Demail">change 2028</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2028?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I20d367dd8251bf39856ae521f380cfdc8df64=
177 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2028 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--i7tjACuvQGc=--


--===============5914421168205873885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5914421168205873885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5914421168205873885==--

