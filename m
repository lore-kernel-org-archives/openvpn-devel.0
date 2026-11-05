Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F1606A330
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Fiu7Jvc/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UwA/VXfq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CT5plTlb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=C6aIKyCz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FShwiBjEbaJG0WBqQYGgnMkP2PJgg5loRmkfS9s2080=; b=Fiu7Jvc/F84eaBaW1YlcnYc3OL
	cyyLIjYYv0OiYV8rz0vY+o0q2kJXrla9jIafHeFfWgyGZVs8y82OmW2eLf20+8mRteJk0f5m+w84S
	BANWYo1NPrgyI7NueN0Xdo4adjaJTKtj/oaiduzzIcat8qZNWh/oI6TJQYdfxUJzpfKg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP5WT-000000005Rr-06oZ;
	Thu, 05 Nov 2026 22:01:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP5WS-000000005Rl-2BeB
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 22:01:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jz072Qn9J8k5CN4ReDYX44pAYE7ehXQSectEuGtcM6w=; b=UwA/VXfq+75dEBbOslw+p3p6bM
 8zOOQ2R81We1MgN6a4dI0Amm7nks6gU6Tkxrc82eYNujRwbw2Osg7N6z0rmMArH8aaUsJ4QPHRKvW
 BKlOJwxdTbOz4Dv2Utyg9BRzkEcUJW1qJWyb9exEZmtjRiEmf3oeft3Wumr3tpaLKs7Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jz072Qn9J8k5CN4ReDYX44pAYE7ehXQSectEuGtcM6w=; b=CT5plTlbmGDwVYrI6Bi9ggOB5Z
 ldOxmjiHLtiy9q7zoDQ79kXe9ksVwD/2JrLNXCF/wG9g2pB0D4ySeI8KPuRkLRDRXfLLYcSrQzaGy
 WTbDGrq0iK2Jgyy1/y0+7Ozvfl/ZModAtLsrPC1H0O+26eiza0jpquDpjof6em+6tPd0=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP5WQ-000000001KF-3lV7 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 22:01:28 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so212435e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 14:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793916080; x=1794520880; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Jz072Qn9J8k5CN4ReDYX44pAYE7ehXQSectEuGtcM6w=;
 b=C6aIKyCzkerhaiPaRB1/fg4mxmQ0KuE1FP5YTMMbd3o9wW85jTLHleKLxYs4dRcd+K
 19eOV89AA/gvzmADf4ewyFDp1ptsURvtfsdDP1gkUbw/PyqVivnrbig5Kjay+VCKmUBg
 QL38Sx6D2VkemhxByYU2Zsl8MzNB2Lu/whPJ3mGiJ3unAIZpx9JN6RLW6oWHMff63ZyT
 FnEPrYPlFzgw8SdzR4/vWhMMaQPlNaiJopVFWfCo3U5zqQx7pFmeGzPvul/ZIfe+syF5
 JUu/QDAgMANMu8C9zMYXT0+ooQH9zoYUuEaf3lPeF3tRnem8vnEbbqqhXD2uNCJsO1bP
 2VHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793916080; x=1794520880;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Jz072Qn9J8k5CN4ReDYX44pAYE7ehXQSectEuGtcM6w=;
 b=YJr8aPDdqtseutSsPa4N8gtYA+TdP9hBsf+GoE/r0P70vnaLzZC9UgidxhlJj8MP8+
 ke65q05BBXZ1toRL4PraNHRFK2E66/Gs//e9XMwMyR0EzaOl+CG+sVJ0v3J9v4OnKO6V
 jlYDz0TV5gyMBYRJsOA9VxiPK7Y7HJqOC+w3hmVyVcO6IwlQVmYpcuf7ae0s9QHJ8DcN
 QtRn181IxmI7UxRee2LnPk6ekFvDbczyo1T4cOEAcuHk79vsWfn/rkC736ZMle3Rfqxj
 8f7scXPVUdvZCyUOuNFp4jv9pgfO4qCSNjeV2k2FAFsnPsiPkSjuMDT7QbogD6O/61E9
 TUXg==
X-Gm-Message-State: APuU4Z+Fn8usagdvqhJF96vK7K+7c8o5YMGlNWixYyylCAXU46GUiHHj
 u855FsjUE2OdcE7oSpTRDKzHum/mdPmlrguiSt0+YvxkVFVodY+yKaoxFGvtZGjPxa9Y0u5nPEK
 80Cqz7bnKHwe5QTNKVkP0ReHI9uyFq5bJx3iwasA6m3zbdEaKgEf+3Nezb/hdHXn5g3pO
X-Gm-Gg: AYBFou2OHjTgqtXJDCqLhCBj/W3xHqiir7MBlQv8jOc9SECdb8CBywNTaMrglOKmy52
 ghTWBmYvbQuPqh2l6ObWDScMpvKyPXPCN0w2oG7t8nALMOQnIHRgDtDRKVAm4P9UX+hLonGnU4N
 G9uCLhK1D+Q6zlVu4RUmChDfgfJN5ryrbRSsLLgu/VNFvM/bxQyXsLgrdwf6uznGtWCQMwpeEQX
 Io7IO4XlQKUrw3cw0Fcx4MRilWtJwDQI7BcFTA5XbxWEkxYXoUi0YMQwohWc20WqQyGlqHKfpvK
 HPSUPIEa6cEjB9qYr0K6i86w1MVBlz99NXmuuBOdvSvrjPbt2q5ZjvMJeRqfZ5DlvM60A2Oy0N2
 /2qFcew/mftQwO8wEc2DMoMxg/Y3UV6Te3B3JaZaN3Wr9ZKDr/rPBLTGrPR3vyaMsCQLSRYNvuP
 u0TtYdu8QnMa37W2VTBXG9KYeJ2yvHNqn4w/2SI/nfVvMobF+T7xqaxL78nfz2yHQgwpbgvDGKX
 jStFcE/ajPCuKVg9iHyF0VHoHcDkxq8gXvaAIU2aTd/lRr96tSweaf2Bh7KJwm8E8WDChkaeFFD
 x7oQnf/DS4a0H0LaaVyuk+zkyR2bDOrIYWH6z07Ojf1MZSBDvMa7rR9TVMsiJMCkOJ72u0IXyyW
 gnQWylEoVkkEYfjSrmXg0mzGjYB6eU5Xo2T7j3+fYBOyjhtvhsTk/jlJxYkY8Ni8j4muKJLRnxL
 H8XzlyMqmcDMYfTOJ/EOkARdof7vfuVmJX416N
X-Received: by 2002:a05:600c:c16b:b0:4a6:42cc:bf65 with SMTP id
 5b1f17b1804b1-4b6df2135e8mr6803885e9.17.1793916080173; 
 Thu, 05 Nov 2026 14:01:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4527feb52sm116215075e9.2.2026.11.05.14.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 14:01:19 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 22:01:17 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ieee93e625bd25f1f674ce1c3b6475fd73770c73f
X-Gerrit-Change-Number: 2119
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2119?usp=email>
X-Gerrit-Commit: 41889e72a604e500c33392df93a62ef60c14d1f1
In-Reply-To: <gerrit.1793776745000.Ieee93e625bd25f1f674ce1c3b6475fd73770c73f@gerrit.openvpn.net>
References: <gerrit.1793776745000.Ieee93e625bd25f1f674ce1c3b6475fd73770c73f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NzQ1MDAwLkllZWU5M2U2MjViZDI1ZjFmNjc0Y2UxYzNiNjQ3NWZkNzM3NzBjNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2680dae98755c47749b06a81d8823d68f7818eb3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP5WQ-000000001KF-3lV7
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: lladdr: pass S_*
 flags, not M_WARN, to openvpn_execve_check()
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6986091428322412203=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6986091428322412203==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eITFchlv4HU="; charset=UTF-8

--eITFchlv4HU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2119?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: lladdr: pass S_* fla=
gs, not M_WARN, to openvpn_execve_check()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

lladdr: pass S_* flags, not M_WARN, to openvpn=
_execve_check()

The flags argument takes S_* values=2E M_WARN shares no bi=
ts with them,
so this is no functional change=2E

Change-Id: Ieee93e625bd25=
f1f674ce1c3b6475fd73770c73f
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2119
Message-Id: <20261104125029=
=2E18712-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg40710=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/lladdr=2Ec
1 file chang=
ed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/19/2119/2

diff --git a/src/openvpn/lladdr=2Ec =
b/src/openvpn/lladdr=2Ec
index 195245f=2E=2E554975c 100644
--- a/src/openvp=
n/lladdr=2Ec
+++ b/src/openvpn/lladdr=2Ec
@@ -36,7 +36,7 @@
     struct arg=
v argv =3D argv_new();
     argv_printf(&argv, IFCONFIG_LLADDR_FMT, IFCONFI=
G_PATH, ifname, lladdr);
     argv_msg(M_INFO, &argv);
-    int r =3D openv=
pn_execve_check(&argv, es, M_WARN, "ERROR: Unable to set link layer address=
=2E");
+    int r =3D openvpn_execve_check(&argv, es, 0, "ERROR: Unable to =
set link layer address=2E");
     argv_free(&argv);
     return r;
 #else

=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2119?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ieee93e625bd25f=
1f674ce1c3b6475fd73770c73f
Gerrit-Change-Number: 2119
Gerrit-PatchSet: 2
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>

--eITFchlv4HU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2119?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">lladdr: pass S_* flags, not M_WARN, to openvpn_execve_check()<br><br>Th=
e flags argument takes S_* values=2E M_WARN shares no bits with them,<br>so=
 this is no functional change=2E<br><br>Change-Id: Ieee93e625bd25f1f674ce1c=
3b6475fd73770c73f<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2119<br>Message-Id: &l=
t;20261104125029=2E18712-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40710=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/lladdr=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/19/2119/2</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/lladdr=2Ec b/sr=
c/openvpn/lladdr=2Ec</span><br><span>index 195245f=2E=2E554975c 100644</spa=
n><br><span>--- a/src/openvpn/lladdr=2Ec</span><br><span>+++ b/src/openvpn/=
lladdr=2Ec</span><br><span>@@ -36,7 +36,7 @@</span><br><span>     struct ar=
gv argv =3D argv_new();</span><br><span>     argv_printf(&amp;argv, IFCONFI=
G_LLADDR_FMT, IFCONFIG_PATH, ifname, lladdr);</span><br><span>     argv_msg=
(M_INFO, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int r =3D openvpn_execve_check(&amp;argv, es, M_WARN, &quot;ERROR: Unabl=
e to set link layer address=2E&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int r =3D openvpn_execve_check(&amp;argv, es, 0, &qu=
ot;ERROR: Unable to set link layer address=2E&quot;);</span><br><span>     =
argv_free(&amp;argv);</span><br><span>     return r;</span><br><span> #else=
</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2119?usp=3Demail">change 2119</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2119?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Ieee93e625bd25f1f674ce1c3b6475f=
d73770c73f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2119 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"=
display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>

</body></html>
--eITFchlv4HU=--


--===============6986091428322412203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6986091428322412203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6986091428322412203==--

