Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D88A606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Cm5xDps+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SDAaKCMg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=M2x0w+rc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HKRdIlp9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=242hM6yVgnBpFpwvOs516E4irgwbbNiKlOPrHMhKKRc=; b=Cm5xDps+1L426kimMiRlLV+Ya1
	YTz2kvpuLl/LfMqoDNO5CU5c6/cAJUb5PQblAvAgIXpte9/NAAx3TXaHWzk/SdnaTC6NldhB5jg1x
	S8Lv+YTJtH06qEHMabKwFWuakzRi60LczwMmUWVpL5q2DYNVGDX8+qtuDl80ooQmpbh4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRSQ-000000006xH-13pv;
	Mon, 09 Nov 2026 15:38:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQRS6-000000006wx-43gI
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:38:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QXgHYThZRaRM2G25JJLFBabf5bbZg7fay7K8NL3Fflo=; b=SDAaKCMg8fBIWsGWIqPPda8nyv
 gHfae2DQopwFdlvzaTEUsDWOwEJxEYLIHKli7wLQtlocGsir5jtfVcL5GL9r1c9klCk4MISBADcYl
 jsgu+6KSXFQoqpJSaG4zEwhexiskRFgZQDrT3mnPoQjqpUBZDdDr/wVXCTWcn4Qm3DAM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QXgHYThZRaRM2G25JJLFBabf5bbZg7fay7K8NL3Fflo=; b=M2x0w+rcd+gLHYkCuFG/8aiY5+
 1NB7eqrjmBBuyf/oxgGHUfszwXonKZaFeBu+urDX3twB3PXLErBIKWqKck3Bu+SS50o5RnX+BH7gJ
 zCYQiFPEC81bHfsnZdYww5xiPxZPTBmg4l5TaOwLTytr1z83ndpHofXSZG2XKv3vhUbI=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQRS1-000000002MF-0Z7v for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:38:29 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so5939895e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 07:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794238702; x=1794843502; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QXgHYThZRaRM2G25JJLFBabf5bbZg7fay7K8NL3Fflo=;
 b=HKRdIlp9WspaPPoqWQ4usoNAXBxC82LTwTEZX44Fp29avyOdUfpbTf9evWQSKTkkk2
 t8fpro83BD4ImbEiuwqKvaGtHgYwGQI4RNTfz82T6MuANVDWU2ADiGMpV10o/5+EPzSe
 5zS67zPRUF8SAJz4eszMoGvEUKMMp8qMorrtMoMxtJCFlInq5jwcfyjztYCk0f8Bzpgp
 4XuGYW2YAQpti/yBts64iVnnyDKzix9jfJ1gdVXSc1lp1SmpSWs3hD1pIp1cqFa1H+VA
 xvXK14dIBls5ZAUL+yKLgV35S9uDUKB5ReGlKbprR3fF1F90gBffsAP6w5yCcvn4kYMu
 9tyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794238702; x=1794843502;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QXgHYThZRaRM2G25JJLFBabf5bbZg7fay7K8NL3Fflo=;
 b=REQKd/67wbdh9rLXfExVzxdsBU2HeyuR6OATZPmoYVE1aiDvFmm03I7hflMIEm4OMu
 shQI078/2bYTFZstz7HTBPKGr4de/irdapQiHmFY8mXnlO2A2SOOpo7p2p5cGFIbPdVR
 ShH8TjC9zNyZw0jamCphlpDwqY2zfqXx0dmnxEJ90KUvELnYYUfoIFBJXkjqHt8mzs/C
 8DlnFKSl2WbyGEFZLt1fzYoK8qnEekCIxsOdrRbNcy+3fC1wTtTMhAIvY75tnOHsokU+
 JWAVareR/EQFL+TqZFoRwWYXwaOWewjGC+fVaICkKEYTIb7f4GFRFGVQ2xDd8zCqjdIc
 fJrQ==
X-Gm-Message-State: APuU4Z905styXE4oEMApOvkCZstAik5R5tZZGCKyquQplqYHkRsIGmot
 y7CsIgkAlNS+Ee2zcr7A5MpBH27S2ETPvvAqTNqz0BI6AyjcUW51pNPmh2jxj4D6TPVF3CKOQta
 gwkuqwGYs6qTZ11LU2VFvE8Vz0r8ImPYvS3h/1xY5mnCREChtIMPjHrV6TKa2y+LluJe0
X-Gm-Gg: AYBFou11i7rwWdJmHvjiPthkGreltb/QrffKY05ADnnIXsWUZkbqXxTLzdY7K5TpbgU
 U90Ebn6ogngUR8vuxO9l0ZgVzzvRqi2t2R0pNRRs67yG+xo11SyeMnpvtfK2OjOZhCqA19YnYlE
 5O/7UThw7JhS9CNTTEO8V93eLy4KXFmIuti6hhTabEQgSFLlKFXtoduJVT3ixkuN6VWVy7fSZVl
 Ye/GncW5A/4ZK6Z0QAOdXDfKP0CSBgjUjVLs8OpaImFrDEy0/KB0tvLYJJwhHHUH39u7K3+SDVc
 52nd0HUBLi/SsVJHCZZhB0xzcDKuFvld1YnsJvq+od5WaHKfyxJSxW6oLAYTNMH7ULHnOaqFRrF
 KKxn857U783jethGtvzUjPTrHCuY+GOlqx+5NVe8vnATqTOuG1opUmNALKHTE+OfXZ/WiEKTg9K
 0zvZag12UhD4hOWbpYV9TarDZBqbo32LroAEHzK1NsnmkVjVBzAqO+TsTGEG5w3Z1M7pJVS2PMY
 Qoch01BQi8r+fUZjv55oF72oxVI0pSaCwOUM7KmdIHw+Wn1pXM93QSSzZpIQqsIqo1iunbh/IEF
 +gXGsgVX68Lf5Y9cSqfy3Vq2BX0siDH5K60g5z2RyQI5GE3ogRtkjXuBPJ7AqG0xw1T3OwMiSww
 HD3Gl0PJEVZQrNh9wkxFFJ/grlEQudCFmMQYWpDPJI16kObWueqlOaucagw3oGNRaHxBsVnCvNp
 WtHhmTbp2Zbzze3A==
X-Received: by 2002:a05:600c:871a:b0:4ab:e27d:e241 with SMTP id
 5b1f17b1804b1-4b962395b32mr82777865e9.15.1794238702449; 
 Mon, 09 Nov 2026 07:38:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7e32b46a3sm258811085e9.6.2026.11.09.07.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 07:38:22 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 15:38:21 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4bc08f4d7d8e5b33f951a3340df187da7253449e
X-Gerrit-Change-Number: 2100
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2100?usp=email>
X-Gerrit-Commit: fa8914210c31ea0dfcde20715cf40f7792412e52
In-Reply-To: <gerrit.1793689251000.I4bc08f4d7d8e5b33f951a3340df187da7253449e@gerrit.openvpn.net>
References: <gerrit.1793689251000.I4bc08f4d7d8e5b33f951a3340df187da7253449e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg5MjUxMDAwLkk0YmMwOGY0ZDdkOGU1YjMzZjk1MWEzMzQwZGYxODdkYTcyNTM0NDllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eebbcc244c664eb9624d8bf87eb263b709bc7fa6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQRS1-000000002MF-0Z7v
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: options: remove
 dangling pre_pull_default() declaration
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
Content-Type: multipart/mixed; boundary="===============3611749006137610934=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3611749006137610934==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="esLF6V0xoXc="; charset=UTF-8

--esLF6V0xoXc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2100?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: options: remove dangling =
pre_pull_default() declaration
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

options: remove dangling pre_pull_default() declaration=


The function has no definition or callers=2E The declaration was already
=
dangling in 6fbf66fa ("This is the start of the BETA21 branch=2E=2E=2E"),
t=
he oldest commit in the history, so the commit that removed the
definition =
predates it=2E

Change-Id: I4bc08f4d7d8e5b33f951a3340df187da7253449e
Signed=
-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2100
Message-Id: <20261103074747=2E6269-1-gert@greenie=2Emuc=2Ede>
URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g40549=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M s=
rc/openvpn/options=2Eh
1 file changed, 0 insertions(+), 2 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/00/2100/2
=

diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 73c13=
54=2E=2E33b50b2 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/opti=
ons=2Eh
@@ -943,8 +943,6 @@
                            uint64_t permission=
_mask, uint64_t *option_types_found,
                            struct env=
_set *es);
 
-void pre_pull_default(struct options *o);
-
 void rol_check_a=
lloc(struct options *options);
 
 int parse_line(const char *line, char *p[=
], const int n, const char *file, const int line_num,

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2100?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I4bc08f4d7d8e5b33f951a3340df187da725=
3449e
Gerrit-Change-Number: 2100
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--esLF6V0xoXc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2100?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">opt=
ions: remove dangling pre_pull_default() declaration<br><br>The function ha=
s no definition or callers=2E The declaration was already<br>dangling in 6f=
bf66fa (&quot;This is the start of the BETA21 branch=2E=2E=2E&quot;),<br>th=
e oldest commit in the history, so the commit that removed the<br>definitio=
n predates it=2E<br><br>Change-Id: I4bc08f4d7d8e5b33f951a3340df187da7253449=
e<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-=
by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2100<br>Message-Id: &lt;20261103074747=2E62=
69-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg40549=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/options=
=2Eh<br>1 file changed, 0 insertions(+), 2 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/00=
/2100/2</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh</span><br><span>index 73c1354=2E=2E33b50b2 100644</span><br><span>--- =
a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</sp=
an><br><span>@@ -943,8 +943,6 @@</span><br><span>                          =
  uint64_t permission_mask, uint64_t *option_types_found,</span><br><span> =
                           struct env_set *es);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-void pre_pull_default(struct op=
tions *o);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> void rol_check_alloc(struct options *options);</span><br><span> </sp=
an><br><span> int parse_line(const char *line, char *p[], const int n, cons=
t char *file, const int line_num,</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2100?usp=3Demail">change 210=
0</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2100?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I4bc08f4d7d8e5b33f951a3340df187da7253449e </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2100 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--esLF6V0xoXc=--


--===============3611749006137610934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3611749006137610934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3611749006137610934==--

