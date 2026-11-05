Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C1606A31B
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FX8J9bFT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DZgzMGJt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k2ls5nPh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AKk3C3eq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RmMKgN/0fPv/5kKPjbyDZ1iteQXTNUC+FdzW3QtDxt0=; b=FX8J9bFTMfD1/cOTUQ1Ao4cJkI
	YS6IWNiSfC1hECnZYQiL2lFkaJ03MtH12IhPWBVysF7f2PJXZgGZCjsj1P9Yp+QhSRnnyQYY6KiB/
	3oUn+xrCDdiUG9OhskX2OEFMdpPmTbIdFQa6bD2HhiW6ESj67LqvXAX4MeGfYhkSmK58=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP5WU-0000000051P-1vCd;
	Thu, 05 Nov 2026 22:01:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP5WT-0000000051I-0ysF
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 22:01:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P1SJA05EfK7AyxSenbO1cQIVEMmYRIb9PAadNoy79TA=; b=DZgzMGJtMJr66vAW63UahpCs0/
 tAzAPumVb0syHn4gF5uo7lOzvkU9VdO6JYCYR+J6KvrPc3AypYcxRMZdbv+K9dHpWp7/q1y681zwo
 ynoS7B8OzM3TVx+cylOKXoS1b6CGgvYLxX03PuVMLO3b+KLSj8Jl4MSVGmy+5wONctZM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P1SJA05EfK7AyxSenbO1cQIVEMmYRIb9PAadNoy79TA=; b=k2ls5nPhzDEKF/7vl/i0l6JlME
 Oe9594lY0WZ6Ajj8W9SnK2HqGn2Y5p2jYNP4v1dMJ+ZU/TjxiO0gcdixYkPcG22GpenMoxOCc5+OK
 ONrBC5Fg9J4czvbdzc/OXuCX4aHuK5M8sLY/cNniteAafuOd+bxCvXARRoE3DG4Q4QcA=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP5WS-0000000073A-2Xsi for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 22:01:29 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so73015e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 14:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793916082; x=1794520882; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P1SJA05EfK7AyxSenbO1cQIVEMmYRIb9PAadNoy79TA=;
 b=AKk3C3eqNZfmd/3X61O7TOaqyNnX4Ppy16qjvL817VY75h8r6Vw2ZSKnItuCMHuHUp
 iQWiYgLPdcUDizLDS5Vx2kNl/+glJgj0eIsQjY+rlykO/MqV0ggTSPNRz8MZWfcWz3oO
 73K0qF/McHtqACh75I4LY3/Rh80EAbo2pVp5xuu+2+qlnXgackkTHliDbh/qYsKtFyrw
 UiFJPPEW2Ujgm1/X1S1dAwRUHB14yBV6ab6IlUDGr21TMkvDvu3J4ldDn1XCYLcvR/LF
 4ENsK6jlmeBzP7//Zz4ehP93Ong+YB6KjIdujT43IMzikY0rUUyLv8bxwbdFOiFr5RD4
 YXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793916082; x=1794520882;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=P1SJA05EfK7AyxSenbO1cQIVEMmYRIb9PAadNoy79TA=;
 b=WCna58wwW4hAWAZ0LsarZRRuPiKtCNkJuRDmK5W1M4KNthVjNH2hGokw+HnUTdTJgy
 YruG1QFReCpaF2mS6nq7YvvBxrMyZ7WegaShumpIyCzvrtY13LI8Ltlx01WNb8+p0XRI
 0NoiOjisQK080bI1pXBNhwd+9KckYC4IxNLK0+u5WNDnxBphW29NMjb2U/oKQutl8azT
 W1pPISmJoflyYzMB/ymxCPuYNjTOq8M19yGs6dmB3a+BENqdYJGy1F7xeOpnUGV0pRqN
 Y/4ALiU8BsQGt6uZtyvseJXa+Qrykfvl4u0hexZUBa2cQ0TT7V5rANNDbug1Cht+XaLb
 xo0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIUwCCuRZGO7TuG3DnRizoYjKm4ezVOVrzQzGPIKIpwv2r3RvHd67hN08d0O4Fw2Tx2MobLfWmq3ZILUm5@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8RS+yE+QdGqQM01kJmvW6N7rsnALUbDHN8a2IMcoQamURby7tX
 geaWrHBqeXcSDvAWd+xtFj0L0qR2NolR/OgYbsLreAg3RVpP1AexVojoD9yyGG5oJEZwh/M/nBL
 652MGGBXssVX3Qwo8ILDZkoAa8jVSwZsSVseskjuLazDV8H1eZXDrLKVXli7JbSYmgzYx
X-Gm-Gg: AYBFou20bKZ0awdVsDp8jo9O2zWBS3Gq2WtHLVMbzB90QM8a7QGVEi2QD32gxxEpNyn
 NAZD/IlHLgRnwqUHLdgvKvBV3ycwCLXzJra8AdgKL/4Hz1xWqfvONdnasLwjDkpPoc/2dtb++x4
 owyBw5bUhRp8+5fXPBdMRrsC1NfOeNh66K2aNJo5SC99PjE9wMUSlrg+uxFszBD6NPFC//1Gawm
 LxNrT1XleQVFTqzYBpFqlTB9j+NwSbFaj5B5Jd0IQ9W9WcYH69L2DjP/QQHkXsC+Z0vJ3H8yYvZ
 UZFfOnQejQHc7P0H3YZ1CAdQpmIoeBNRXKjDH4lsa1yATQ/HekF8EG01kW3l5JkREtxJHsCxoUP
 0l4NPRUMKsyAfJdK+vXWncq+gSPtlCYbfPdKj1yNDS4a1sfUzH112yIbnIPDI2htZNmgmt2wEOb
 pAmqxbsDgi0P9fLZKthAPU/ve2re7W+uPGjK0wD4DINmJPympObI2mgMVyoVae8hrw4bXt/raNH
 KO3y3R/sj8+p4pzct+Hm03EnXNlMvCcLm6koGOLE3Ok74rFWrCdOqMXZl8DeXQhMyMjbjhgRfRL
 +dG+eHhUtOZMrN8dXYhVbX8Gg72OxTpqv6jyze1dJj47DwwZrXrbA6nujvrWrcUoXjdjeij0GwM
 QNxdHj69psedy1kKaz126oqUkQlUYY+ys5GNrs9J9NROaY5iC8P2pbZeOa0pGOCE8nA5bpHbEel
 wedtEz9aEkZGf8JQ==
X-Received: by 2002:a05:600c:608a:b0:4a2:1364:252a with SMTP id
 5b1f17b1804b1-4b6db0d07dbmr7137235e9.3.1793916081920; 
 Thu, 05 Nov 2026 14:01:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6df5eab6esm11114985e9.1.2026.11.05.14.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 14:01:20 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 22:01:20 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ieee93e625bd25f1f674ce1c3b6475fd73770c73f
X-Gerrit-Change-Number: 2119
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2119?usp=email>
X-Gerrit-Commit: 41889e72a604e500c33392df93a62ef60c14d1f1
In-Reply-To: <gerrit.1793776745000.Ieee93e625bd25f1f674ce1c3b6475fd73770c73f@gerrit.openvpn.net>
References: <gerrit.1793776745000.Ieee93e625bd25f1f674ce1c3b6475fd73770c73f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NzQ1MDAwLkllZWU5M2U2MjViZDI1ZjFmNjc0Y2UxYzNiNjQ3NWZkNzM3NzBjNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2680dae98755c47749b06a81d8823d68f7818eb3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP5WS-0000000073A-2Xsi
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6823269233941071121=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6823269233941071121==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nwR8BHXNZxA="; charset=UTF-8

--nwR8BHXNZxA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2119?usp=3Demail )

Change subject: lladdr: pass S_* flags, not=
 M_WARN, to openvpn_execve_check()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

lladdr: pass S_* flags, not M_WARN, to openvpn_execv=
e_check()

The flags argument takes S_* values=2E M_WARN shares no bits wit=
h them,
so this is no functional change=2E

Change-Id: Ieee93e625bd25f1f674=
ce1c3b6475fd73770c73f
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg=
>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2119
Message-Id: <20261104125029=2E1871=
2-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg40710=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/lladdr=2Ec
1 file changed, 1 i=
nsertion(+), 1 deletion(-)




diff --git a/src/openvpn/lladdr=2Ec b/src/op=
envpn/lladdr=2Ec
index 195245f=2E=2E554975c 100644
--- a/src/openvpn/lladdr=
=2Ec
+++ b/src/openvpn/lladdr=2Ec
@@ -36,7 +36,7 @@
     struct argv argv =
=3D argv_new();
     argv_printf(&argv, IFCONFIG_LLADDR_FMT, IFCONFIG_PATH,=
 ifname, lladdr);
     argv_msg(M_INFO, &argv);
-    int r =3D openvpn_exec=
ve_check(&argv, es, M_WARN, "ERROR: Unable to set link layer address=2E");
=
+    int r =3D openvpn_execve_check(&argv, es, 0, "ERROR: Unable to set lin=
k layer address=2E");
     argv_free(&argv);
     return r;
 #else

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2119?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ieee93e625bd25f1f674ce1c3b64=
75fd73770c73f
Gerrit-Change-Number: 2119
Gerrit-PatchSet: 2
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--nwR8BHXNZxA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2119?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">lladdr: pass S_* flags, not M_WARN=
, to openvpn_execve_check()<br><br>The flags argument takes S_* values=2E M=
_WARN shares no bits with them,<br>so this is no functional change=2E<br><b=
r>Change-Id: Ieee93e625bd25f1f674ce1c3b6475fd73770c73f<br>Signed-off-by: Ra=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2119<br>Message-Id: &lt;20261104125029=2E18712-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg40710=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/lladdr=2Ec<br>1 file cha=
nged, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/lladdr=2Ec b/src/openvpn/lladdr=2Ec</span><br><span>index 195245f=2E=2E5=
54975c 100644</span><br><span>--- a/src/openvpn/lladdr=2Ec</span><br><span>=
+++ b/src/openvpn/lladdr=2Ec</span><br><span>@@ -36,7 +36,7 @@</span><br><s=
pan>     struct argv argv =3D argv_new();</span><br><span>     argv_printf(=
&amp;argv, IFCONFIG_LLADDR_FMT, IFCONFIG_PATH, ifname, lladdr);</span><br><=
span>     argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int r =3D openvpn_execve_check(&amp;argv, es, M_WARN, =
&quot;ERROR: Unable to set link layer address=2E&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int r =3D openvpn_execve_check(&am=
p;argv, es, 0, &quot;ERROR: Unable to set link layer address=2E&quot;);</sp=
an><br><span>     argv_free(&amp;argv);</span><br><span>     return r;</spa=
n><br><span> #else</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2119?usp=3Demail">change 2119</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2119?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieee93e625bd25f1f6=
74ce1c3b6475fd73770c73f </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2119 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--nwR8BHXNZxA=--


--===============6823269233941071121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6823269233941071121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6823269233941071121==--

