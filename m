Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADC3606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DaxASgKm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XEWWQHA5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YUbUBxKT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VYJbm1Wr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QDnHlbI4jpMHzHxfVWqERH4qbYNuWK8wSODTAu1atFg=; b=DaxASgKmmCyLbppXn+ZvzvrQ7Y
	OkMQ6eOCZviH+n84ZVND9cKc/7aW4NohxwePbYSS35jd5xtIWcslFPPFZWZuxyPWFtkREOHWVhXFu
	iTUurQ5AfM9tRldSQAI9wdF8cm0JfP8GTKnyN1JV8l1bgtWuw2iyhk4YW+pFTPJzazH8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWaC3-000000002AQ-1PSy;
	Thu, 26 Nov 2026 14:11:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWaC1-000000002AG-1xlL
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:11:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uSVWfK02TI3BESvoA3t+D4Jarvftp5pjpA5NqkSoZFs=; b=XEWWQHA5CwtEMMBuzOsfcL2zCd
 snb3+KEywqSIgGdRNa5b5aD86l5POG1W57JUfFrbHgPuJ3Oq6mPY6QV/9kYFwt+27HHeqSvJC2pCz
 xfMdsgD33KuWc8yKZvDBF0SB22cTVVxUCMKU6VqTzeQx75AbsktoVX50r+gkOlFfBbvY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uSVWfK02TI3BESvoA3t+D4Jarvftp5pjpA5NqkSoZFs=; b=YUbUBxKT0DyBtXa7ifZakw6RaM
 C8cUd+hAtsNvB2HMbz8CgCQjX9zJacm0jsUi1aoyeeRjHnrzcGUpNzRPqAS9ATA4fQ9HteaXSEBQa
 R4bpZEVkhA33bcRXx4P/H/2ONyQq+n5juQETHgqJFI+kFOb7EBfeda9bLzDDtNs0/ofY=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWaC0-000000001Bb-0GI1 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:11:21 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so63974515e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 06:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795702273; x=1796307073; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uSVWfK02TI3BESvoA3t+D4Jarvftp5pjpA5NqkSoZFs=;
 b=VYJbm1WrQueDn+flQXclJkllnoULnNDRUeJAJVL3z8JFwiM9tvDKvMTkrjfK07pR3+
 6E8km60Iu+2azrZ4hputGjjQmO5BqG4c5ZvztvDxHxIWe63/YxtjorjhafAC+c2JmT4K
 OM3CA34rXM1/v54ziUzwygj5+DmlKowPlABZb0a2jii1Q9iJ1XYrxkd3eOzmJwFUR6A1
 EbMpKEvmddH5AqDHYdnvCnJHAETz1Js5jhjTojokv8EFbm+6mwLBLzH87jQgH4ITY3zr
 dq04Ca6D7nkjV2Hxbs9rO6xFVQp8m8p9KhwE4ArLzCFXjn21aStT+xod4OEKIP2jOzED
 ZWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795702273; x=1796307073;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uSVWfK02TI3BESvoA3t+D4Jarvftp5pjpA5NqkSoZFs=;
 b=i88SIHjDuk96yZ6nxTmkbzJzdKs5OtWejEruF6Ize1wLmfvko87sLu6wRKuElAZBIt
 Uw6ELsYWNcpXm74NdBOWCKfFc/KvCdPOENWxr2+s9F7DJ1PiR4q11BWILqdMdmXVMQbb
 vEEOQ6Jo5+6xi8AEFGHbPZ29puDrP4/CTU+s90yNMtTQxleDfg/FrnaxO3Wce5unr+C8
 JRj9qk2jC+HyMggVuxW0OWxUrmaR0HjJDJbP5B55Yp6KTiLyJmZfZQql2zMQxI+MuKj+
 hwcp87DWBZhAtzaz7WTo3Pu467gxNIS3iCPdZCJMC+oIH2yx+lSOpCOEl1wrd21Yxaoe
 z97w==
X-Forwarded-Encrypted: i=1;
 AL+hErFlVU6ZYMu9zftAQ/9PGEDeC0+B1Bha9oUjp6iXIS+p6bW6yKaqWewmXch4HwCX1j5FVLSJR+Yrgq6eD4wO@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9q08Puryv65par9M4uGAybqxV0e3e2AKoMOvK28LRSU4L9pISs
 AghJP7VxHsvRmasS1qyo02MCNCPZ5fVGLyaN1JMQV+r7bsdya03z1KwpvG1YXjRi1RnukZ1mqIQ
 rWQXvzNui0TOJ5N+xRCGsga8IDx5SCC7F9+ahxba/zvOwoZgKd2/B3BgyyitHGjdC5wBg
X-Gm-Gg: AZFdTZc9G5x2mxx8KYMBOIh5fi5yoAVbhrITgN6KgGdAUJUnjEyu6w3eds0xFWvQx/a
 jGtTWU/u93VwN2rOzEJDktGwTZSv0u7ijw/OLsCaTA0nUCh+yNn4IIeL4bGYeANdTfh2QDkAV+1
 B6rTtEEApGSuiayA7T1xObRjm+NEUlaQr9TVxRO0Mune3glF3rLxGY8JbpEaKRlGl+wLfMR6aYe
 kES3rPZxopbLqKboVF1vK8pHl/sZdhkK6NDWUkLj3U9e5HEmDLOgjUPpgdqUI+IXFAnocJRQ1FH
 aRQq3mZwiVyyEj0/pehzaVWSxSHSj5tIBrRqPofyA+oAFjsfoOVAnbSyKo7ovoLWjr9fFqUkQli
 ZBhGQx9INeR5rO3sjzTFFsVpdZV//Wr6viOD2G1Dq4h9FKloQ6cY+aW9HvGtZgyP/wRzskSI0pj
 zEXjQGFEKtDynMZqmXTzShqgNtLfoYKHYLzjPkHyZHjpwSZzxToPTAZA0EZ51x6AVSx6W9jo6Cz
 rWZw1BH4Vas/KlCzLkkLXm3Ud9JeOelCXqpt8KwY+5C4XqifGSdQa/N2afA/p0Zvhw3G7kK+dAj
 Bl+VXy/iqHf/o5OrdYHDX6Q8FxP+gn9DIP9PMLd7EaidaYzzlspYlyVdO9F9XXf+M1OM1teTWbv
 ryAtMRNkZLC7C10zkuhHVAJ0Ht7Qrx9QJJFIyxcpo57rCBor6o1779R8kDN3Wz84Xdl9EIUFuhx
 bMC3K2IAntthu1AkQ=
X-Received: by 2002:a05:600c:674b:b0:4b2:61e5:b2f4 with SMTP id
 5b1f17b1804b1-4bb8880f25cmr406458865e9.11.1795702273444; 
 Thu, 26 Nov 2026 06:11:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b1ed8b6a05sm22101723f8f.43.2026.11.26.06.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:11:13 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 14:11:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia359824eea8780805a59d19146740afe3630fa0c
X-Gerrit-Change-Number: 2233
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2233?usp=email>
X-Gerrit-Commit: f83a6ffe48bdbf773a66fb92fd86e64af3d24135
In-Reply-To: <gerrit.1795207472000.Ia359824eea8780805a59d19146740afe3630fa0c@gerrit.openvpn.net>
References: <gerrit.1795207472000.Ia359824eea8780805a59d19146740afe3630fa0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3NDcyMDAwLklhMzU5ODI0ZWVhODc4MDgwNWE1OWQxOTE0Njc0MGFmZTM2MzBmYTBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b7bf913bdb92e86756c720a27d6fa69cf05ed7ee-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWaC0-000000001Bb-0GI1
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 use stale data for NRPT exclude rules
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4243294439871585187=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4243294439871585187==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sAMPycMGt4g="; charset=UTF-8

--sAMPycMGt4g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2233?usp=3Demail )

Change subject: openvpnserv: don't use stal=
e data for NRPT exclude rules
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

openvpnserv: don't use stale data for NRPT exclude rules

=
If the last interface GetNrptExcludeData() looked at was not usable, its
en=
try was left with the domains set, and SetNrptExcludeRules() created
a rule=
 from it=2E Clear the unused entry when done=2E

Change-Id: Ia359824eea8780=
805a59d19146740afe3630fa0c
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlic=
h=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233
Message-Id: <20261121094752=2E2=
8750-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openv=
pn-devel@lists=2Esourceforge=2Enet/msg41755=2Ehtml
Signed-off-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 file =
changed, 6 insertions(+), 1 deletion(-)




diff --git a/src/openvpnserv/in=
teractive=2Ec b/src/openvpnserv/interactive=2Ec
index d155fd6=2E=2Ef00e75e =
100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interact=
ive=2Ec
@@ -2494,13 +2494,13 @@
 {
     HKEY v4_itfs =3D INVALID_HANDLE_VAL=
UE;
     HKEY v6_itfs =3D INVALID_HANDLE_VALUE;
+    size_t i =3D 0;
 
    =
 if (!GetInterfacesKey(AF_INET, &v4_itfs) || !GetInterfacesKey(AF_INET6, &v=
6_itfs))
     {
         goto out;
     }
 
-    size_t i =3D 0;
     DWORD=
 enum_index =3D 0;
     while (i < data_size)
     {
@@ -2600,6 +2600,11 @@=

     }
 
 out:
+    /* Clear data left by an interface that was not usable=
 */
+    if (i < data_size)
+    {
+        ZeroMemory(&data[i], sizeof(dat=
a[i]));
+    }
     RegCloseKey(v6_itfs);
     RegCloseKey(v4_itfs);
 }

--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia359824eea8780805a59d1=
9146740afe3630fa0c
Gerrit-Change-Number: 2233
Gerrit-PatchSet: 2
Gerrit-Own=
er: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--sAMPycMGt4g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2233?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: don&#39;t use stale d=
ata for NRPT exclude rules<br><br>If the last interface GetNrptExcludeData(=
) looked at was not usable, its<br>entry was left with the domains set, and=
 SetNrptExcludeRules() created<br>a rule from it=2E Clear the unused entry =
when done=2E<br><br>Change-Id: Ia359824eea8780805a59d19146740afe3630fa0c<br=
>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by=
: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2233<br>Message-Id: &lt;20261121094752=2E287=
50-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg41755=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/inte=
ractive=2Ec<br>1 file changed, 6 insertions(+), 1 deletion(-)<br><br></pre>=

<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interact=
ive=2Ec</span><br><span>index d155fd6=2E=2Ef00e75e 100644</span><br><span>-=
-- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/=
interactive=2Ec</span><br><span>@@ -2494,13 +2494,13 @@</span><br><span> {<=
/span><br><span>     HKEY v4_itfs =3D INVALID_HANDLE_VALUE;</span><br><span=
>     HKEY v6_itfs =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    size_t i =3D 0;</span><br><span> </span><br><s=
pan>     if (!GetInterfacesKey(AF_INET, &amp;v4_itfs) || !GetInterfacesKey(=
AF_INET6, &amp;v6_itfs))</span><br><span>     {</span><br><span>         go=
to out;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    size_t i =3D 0;</span><br><span>     DWORD e=
num_index =3D 0;</span><br><span>     while (i &lt; data_size)</span><br><s=
pan>     {</span><br><span>@@ -2600,6 +2600,11 @@</span><br><span>     }</s=
pan><br><span> </span><br><span> out:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Clear data left by an interface that was not usabl=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (i &lt; =
data_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ZeroMemory(&amp=
;data[i], sizeof(data[i]));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span>     RegCloseKey(v6_itfs);</span><br><span>  =
   RegCloseKey(v4_itfs);</span><br><span> }</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2233?usp=3Demail">=
change 2233</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/223=
3?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ia359824eea8780805a59d19146740afe3630fa0c </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2233 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hu=
nd &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html=
>
--sAMPycMGt4g=--


--===============4243294439871585187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4243294439871585187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4243294439871585187==--

