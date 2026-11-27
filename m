Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43383606A321
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FF9DhU5b;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Zp6lWwUd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RzEM1WYA;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OQNc6m19
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KQClMH/+GMae1GQTPHsK4HZMgzi7qEg312pBYoeBAUU=; b=FF9DhU5bku5C0yTnKX9Jvrc3qY
	8FK9mhYEawgpZ4v00BlLjbk/WvkhVvdzN47hJ7V/dYZSYBNQcAepmMSRz03sUJADowdeWeXl7JTDy
	p25VkNqIpWgVPFPexroBPL84jrZHiqirjLoGLS1htmvejc//TxAjAVD006i0eYQ2Efcs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWvYz-000000001ub-3Ngk;
	Fri, 27 Nov 2026 13:00:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWvYx-000000001uV-2UPY
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:00:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O2bOBnzaCDI3lg8yPDZsc6q++mv2Jyi7fN+YDUXDe5g=; b=Zp6lWwUdEu5Z0AFRKCWnXBNc4F
 cgNUFtiAbdDNUWuark0URJWH+HIQGBLUr2TPI+5mdQWum9N/wjvkUYiC4v0AH2PPATrgxP5PkpGgU
 DSXP1oruncib1JwJ7EGMixSj+4Ipcd3EuU9Uz8RjxOd8314dW3aF2yGY7LtT0hstFyMc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O2bOBnzaCDI3lg8yPDZsc6q++mv2Jyi7fN+YDUXDe5g=; b=RzEM1WYAOv0xXKBzsoGK4bbM9g
 jZer5NtWVSg2EMOwqxbqBl3xmBPrfpS82N2IQvJeqAiXf/yl7Is0+kSh1aMDAGJ0tFRYAKQBNBZlp
 l48IDuvm/oWr4dRz854hLBWs6bL/cFwEctsytOphscNhnB0gzUUSPpN6KyO0a44TAnFE=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWvYu-000000000hA-1x4Q for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:00:27 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso43080435e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 05:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795784418; x=1796389218; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O2bOBnzaCDI3lg8yPDZsc6q++mv2Jyi7fN+YDUXDe5g=;
 b=OQNc6m19OkcG5FSpr1LDcw+WccuA+hVkPPATwH6G9im3htV1Ip+kbLF8KDE3tUJ4EU
 Ofg7V2VDZqnhG8KmAt7Im9dZI/iE9ReOXSPew4B8vQVu5YP5M2NxOwWN1zKMeyq/EaI0
 JvPNJGc4bW67gvr3cgCmzq/smTSgux5dqAZV40tkQ5+1pUxbg71eG8OrknFmNnZ4WqlD
 eQBOx1341bMNdFP52+8YHNAYSQCfatAC/vrU1HAFeEFOIUF+E0FoOVhJ3jTq+gpYLbUn
 E36qJG7oJNc94TOeIygdo9w3qvR0wGEg+MDNgjdxX//jn4CuCIGwXKmQhE7FMq3SOLfP
 sSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795784418; x=1796389218;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=O2bOBnzaCDI3lg8yPDZsc6q++mv2Jyi7fN+YDUXDe5g=;
 b=TGsjQSNBaObO/OyaUStozIbme3YDAgQsqaMBsvSk1cYYnEZRBgzy8N3x+/oGxPcdG9
 YPjE/83pkMZQhbjsxCbFtzoBuKNSG+H+0whoMy0wRL/JnpRXz6uC4mpHUpU9wAp4Ncbi
 gNPnD45/PtDbuo1Fvs7IpgJRTGl0S1AmUFKHwglAq0hXHSZNHvSI9bXbVKzphuET6jIO
 w9BEZIX3lvYc9Tl2rWI4DWEzM4tGtxYYm2AK4tvD2Rg2K7FFsmjGq4HQdyrXJV8NB/g6
 gzzOQg+vDUIPjyOC9LMtrFqw0gGNLzDWcBD899bJdccNsBmPiuFR8dLoIhFhw0f2BTaO
 64xA==
X-Gm-Message-State: APuU4Z9cBEOM2K7/HFZqiuAJDCPtUkbvbXhv+Hel3B9Qn5i0LJ1FoduX
 +moMmCW42LFxrwOpXn2Pmvj46G2NUfjAiTHXl5cwm6ZS8moBbU0mcJOiznZYz9SBytlPfmFRrDi
 fbQeLQcwG7NYfTkIc+jXaLrZqiqQlgdvpP6z0oxcnT7urKRBKLcNS0P1sTEcTJ1ETvW2j
X-Gm-Gg: AZFdTZeDAzyleSATxdAFmKdsb4tFS6cSRUjVo/PVsPRNZ5aDeShn+5sS+BzzR0QoU3E
 q7Cnhf72pLugMRWSIgshCo5qUJHE31Vu06MowAJnYiMA6MZcgjNTZ27uiPdOC3H69HXE+bZJm3h
 jjAtT5J6neV/UzxrQ3MsBFeJgrDsg7T16Z1R82zp/U45hh2lGdWaLupEK6Hds4eNQtnvpS6oj3g
 IZYDVXj/QKudOso6x5mYnnmUkm1NYshDlNXuvFbMJVKnJe0MYaHkGPmjcDcUTEWYgHs7mcH4equ
 4rG4L7Z+vcNzAr1OQmEU52F/aHZk42V+koSmggGvdmfvXs00nuc43asxEJvGAx5e7KDvJFxAmzY
 BOFn7HT3K2y7Kiuk+6CPIGEAAmr3OIfNTO5/bS2uOlj7WvvN/zWWyVbNKOiU3vxN2E3Jzpg0/v4
 AlTeA+K7ZS2vbjQWKYl3Kr48KrxossXINQ5VVKTzEX+Hkl77N8smuL1j4xvutDI45IEF1JG7H86
 WxHBfPFHN+VGpqYurDNI3CKfuSbw5x8R2FAOXLD6vqs7jNo5Jmwc+ZXUn0x3LxfmhODLxGL3NNL
 0ZLVISnOnBrDvY8foKBqH4TsqbdTVc5j9m3pkYIeuY+GedrKONfNHpSW2JZMvWLY70PaY5wBrHT
 KiP8e2RobVuCPoaERcFqbq9cpK2VXOlkAJDusfKbRptAdN8JeTw7+nnmk/ex81m1Q8D5zR+TsEP
 fzFBVnZFMud5kOwuE=
X-Received: by 2002:a05:600c:848d:b0:4bb:6687:5386 with SMTP id
 5b1f17b1804b1-4bb8880c7f1mr521012785e9.19.1795784417382; 
 Fri, 27 Nov 2026 05:00:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90660cb4sm655488505e9.2.2026.11.27.05.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 05:00:17 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 13:00:15 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408
X-Gerrit-Change-Number: 2360
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2360?usp=email>
X-Gerrit-Commit: b0f799c435a2d85b25f3453c4da825ee8f64ac87
In-Reply-To: <gerrit.1795779011000.Ib20f4965f25472f47b98981d54eaf4e2269d7408@gerrit.openvpn.net>
References: <gerrit.1795779011000.Ib20f4965f25472f47b98981d54eaf4e2269d7408@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Nzc5MDExMDAwLkliMjBmNDk2NWYyNTQ3MmY0N2I5ODk4MWQ1NGVhZjRlMjI2OWQ3NDA4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8a4e5fe38ed172cd4029d1c137224c482abfe7d0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWvYu-000000000hA-1x4Q
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: preserve
 --dns-updown across PUSH_UPDATE
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4974596761396351561=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4974596761396351561==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HBjtyu3sglA="; charset=UTF-8

--HBjtyu3sglA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo, R=C4=83zva=
n Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to =
reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2360?usp=3Demail

to look at the new patch set (#2)=2E

The followi=
ng approvals got outdated and were removed:
Code-Review+1 by R=C4=83zvan Co=
jocaru


Change subject: options: preserve --dns-updown across PUSH_UPDATE
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: pres=
erve --dns-updown across PUSH_UPDATE

Reset DNS records without clearing th=
e local DNS up/down command
and flags when PUSH_UPDATE replaces or removes =
DNS options=2E

Change-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408
Signed=
-off-by: Marco Baffo <marco@mandelbit=2Ecom>
---
M src/openvpn/options=2Ec
=
1 file changed, 10 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/2360/2

diff --git a/src/ope=
nvpn/options=2Ec b/src/openvpn/options=2Ec
index 1e0b4d8=2E=2Ec35740d 10064=
4
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3619,8 +3=
619,16 @@
 static void
 reset_dns_options(struct options *options)
 {
-    =
gc_free(&options->dns_options=2Egc);
-    CLEAR(options->dns_options);
+   =
 struct dns_options *dns =3D &options->dns_options;
+    const char *updown=
 =3D dns->updown;
+    enum dns_updown_flags updown_flags =3D dns->updown_f=
lags;
+
+    gc_free(&dns->gc);
+    CLEAR(*dns);
+
+    /* --dns-updown is=
 local configuration, not pushed */
+    dns->updown =3D updown;
+    dns->=
updown_flags =3D updown_flags;
 }
 
 static void

-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408=

Gerrit-Change-Number: 2360
Gerrit-PatchSet: 2
Gerrit-Owner: Marco Baffo <m=
arco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>

--HBjtyu3sglA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo, R=C4=83zvan Cojocaru=2E </=
p>
<p>Marco Baffo <strong>uploaded patch set #2</strong> to this change=2E<=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demai=
l">View Change</a></p><p>The following approvals got outdated and were remo=
ved:
Code-Review+1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">options: pres=
erve --dns-updown across PUSH_UPDATE<br><br>Reset DNS records without clear=
ing the local DNS up/down command<br>and flags when PUSH_UPDATE replaces or=
 removes DNS options=2E<br><br>Change-Id: Ib20f4965f25472f47b98981d54eaf4e2=
269d7408<br>Signed-off-by: Marco Baffo &lt;marco@mandelbit=2Ecom&gt;<br>---=
<br>M src/openvpn/options=2Ec<br>1 file changed, 10 insertions(+), 2 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/60/2360/2</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec</span><br><span>index 1e0b4d8=2E=2Ec35740d 1=
00644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/s=
rc/openvpn/options=2Ec</span><br><span>@@ -3619,8 +3619,16 @@</span><br><sp=
an> static void</span><br><span> reset_dns_options(struct options *options)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  gc_free(&amp;options-&gt;dns_options=2Egc);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    CLEAR(options-&gt;dns_options);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct dns_options *dns =3D &am=
p;options-&gt;dns_options;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *updown =3D dns-&gt;updown;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    enum dns_updown_flags updown_flags =3D dn=
s-&gt;updown_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;dn=
s-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR=
(*dns);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* --dns-updown is local co=
nfiguration, not pushed */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    dns-&gt;updown =3D updown;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    dns-&gt;updown_flags =3D updown_flags;</span><br><spa=
n> }</span><br><span> </span><br><span> static void</span><br></pre><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=
=3Demail">change 2360</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2360?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2360 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Marco Baffo &lt;marco@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=

</body></html>
--HBjtyu3sglA=--


--===============4974596761396351561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4974596761396351561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4974596761396351561==--

