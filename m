Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8246E606A31C
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GnIArvzp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=abWA4KuC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XBhIBYkh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=W6AGFN3u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Y1HcnB6sEEmzAKrnN2Os8L3J2AP5gtCRe8EH4spmHA0=; b=GnIArvzp5v5UbMSU2viQ92gLn/
	1KI4JcqfuRlLgGjO4Ra27AoF3zjCan2jnXQ9tjgvRfrrUM8fXwKqEYf/PvsmO5JfISCf4u5c9Gu1N
	k7JvvfxNO+iEC8L/sdZXWnPXLnouzAlML2ZjV/X/vPY5F68Xq4I8xi2IW3lNE/vOtGEA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ2mQ-000000008S1-0xRZ;
	Sun, 08 Nov 2026 13:17:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQ2mO-000000008Ru-2SlJ
 for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 13:17:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CEjz4hBzTvRCJxcICUZW22eF+wx2dqjLivKa4XmkGNw=; b=abWA4KuCh6qSQgvgUhqbLaJj8c
 MTBsTok58VpjEhaBCZWTvTcNQjloYNIUn2xnsY42o2hxIM7yGmHqDmlTCAK3g0TSmgh4C6vnE+TK7
 tSXf7zv2FG+xHsk6+ktf4MN5SWfn77Jeao+CA45NvAAFenSljYgaZONCUIFoxh7dncUc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CEjz4hBzTvRCJxcICUZW22eF+wx2dqjLivKa4XmkGNw=; b=XBhIBYkhmSLBNNe61nkoW+dj5O
 yUq6H4dK/bK30CpWd7ccY643nLc5A2RhnJEnwhh58fGZNuBnsqzbEyz5jTAgle2LtD7StnLDD891s
 GCccYHzMY7Ymou3bvo+t+oR8aoZ2/X/qeGWwBtQEMI49to6rjBJiDJERCPu3MsaF1ZCI=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQ2mN-000000008Gk-3zk6 for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 13:17:52 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so426135e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 05:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794143865; x=1794748665; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CEjz4hBzTvRCJxcICUZW22eF+wx2dqjLivKa4XmkGNw=;
 b=W6AGFN3u0ZVv9FFATsg0S4FfW4k8gDpPzwv6rpd52D24OGPsfk5Lk1eTRq0OTvXF7t
 S7HufRC5osi6yK8/VawTrpwqqF8LbeLjWXq74OK1cXOg3Go9rHUCXVv3uE6kNW71iiTB
 5789Qlli8ainemhlsfr+5zt2B+ZlD2Ywqn7dSmgYzSUQmyFToXYv/4azgADEw/II+PdS
 uuLQp3iTqdbr9HtaVhJ0CJ2tgurbIqErS/3uPG0fNv6vB4WNOM+ErYQZJCDPiCfu5mfv
 2B3YoP6rNWfs7dBaPQjAotxCWrrOPlkQYOgmsFpw6PkHo2xljvvogcGrBSwXTEJP0MPQ
 WvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794143865; x=1794748665;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CEjz4hBzTvRCJxcICUZW22eF+wx2dqjLivKa4XmkGNw=;
 b=jTx8qeN5uOcjzqNiA5t7s/Gpe569q7AIovJnZrQHDHMZMig5LfCHKxFvf8739H5Tl+
 JSSRNLtILlxpII7H7LTN5QQPYSYgC8kMu1CAdFbG7HvzmfHuMLbZoplG0D8c72CAYaBV
 7onChwiWWF/G5IsAuLVJI9vQEU6PsefFaFTV9qt62cxW/gp4zWudXBL00OxJnNrG8aNu
 /epOmiBhCUlj6Xh4sYAtvX6jIY4OHpcmGwvXFipZPKH4rLTjYum6XusLDZicwh7DOjg3
 9B9p4afUAf53jQrGOhGNt3GWS8CpiyOF5AeeU655T4CZnS654jJ8KK9RBzV1NU/1XWLj
 Nwxw==
X-Forwarded-Encrypted: i=1;
 AL+hErHfWn9Elv8XdHbuEMO/U1S9dJB9QcF4HyEMZkiaC9i3zmBtY4HcMqCOUlMBgfb7xTfvBnTG7yWIk5xYwkIA@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+QKheKSwlyswMmv/uGJxhjyWAwEkAmtviE/Z7iQErtFpSIbm3G
 aSUPc7OLS6zd9KXy1VnJlANhHo9p9907A85FPwRN67F8yL1Nxo0o2IoYK6T5l7kus2pdI2QeIRo
 Eg5nDJaSDYjuODC8lmorttBaVpquDjaC5I6ej4YJW4jKs6cJPnrgoKjI5MSIa1tc2UtR1Phgh73
 izIa4eSA==
X-Gm-Gg: AYBFou1smyWVWMTEuZqV7t8z88EkqURUKvdR4lxnII6u9Z2kcJy15HDInf5nMH687G5
 Bx9Qt8qgqfoekMrvy+8/jo9VMkU2RLvRc6kJ0W8aGKHh5AznzJGBQ8n2pNdfjASySlWGsyxk1bq
 mXu9uN/B5JVftXFbgU/4f8zA9wE3GeRcDl6m2AqQ9HlgZAEXe/dg2lN52JmrLWJPnV/v5yGeNs8
 KhodP1cpjPQQCc3b1KIFP1rKetAUXlH+Gb4FSi1wZo3abzFiNo2E9CEDJUlEEWnRyNJvdJ+xIEN
 DAKvTQqX0VXuBun7ZUCUTDCI0zghC0x3xhpLuKMuMs6Ml+/rsS5lXsFjk/ETtXmp9V+c3j/Djhg
 YD6QLolfn+ygy/MWIgc3FaD7B40Q4oso/vemH7z29VUwKcRg1Z0DD5HN7+MHAQEV7LyYebXmM0t
 kruVWjZycd9ONyursd8ri+xlg4IpOpccrQl1p0wdVWD5hhgVA2VriRmUdFPfc7QQ0c1M3F2Xw/f
 1mtqrttOdacSNFWOZExLWQTlBttrlL9tlCgVin9AUHC0B7XTJ+jUg2h9nq0/s065+DSaGsGV/N3
 u3ihRrM7JeGF7A1pWQI+HJN9AgsT4cB8auyztLQtCqJhQE8xgTdQ1fEtHluaHuyXdXWHpzec741
 4h54j00UY9HNHIRzdL03h3I6nKCQjZoHDjO8INUQBnoHO5CuHW57EtuOlOb+oCzgmmuyD3dA0WK
 QwdtHuu57Yqq51kA==
X-Received: by 2002:a05:600c:1d29:b0:4a3:12fb:1ee7 with SMTP id
 5b1f17b1804b1-4b963c9789cmr32291445e9.25.1794143865140; 
 Sun, 08 Nov 2026 05:17:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b90ee2b8c0sm63774855e9.9.2026.11.08.05.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 05:17:44 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 8 Nov 2026 13:17:44 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I784f3ffe17ecadabf96caad11fe9f774aa00b7cc
X-Gerrit-Change-Number: 2142
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2142?usp=email>
X-Gerrit-Commit: ebc370a5a232aff244c9d2d1f8497c665e6bd853
In-Reply-To: <gerrit.1793947607000.I784f3ffe17ecadabf96caad11fe9f774aa00b7cc@gerrit.openvpn.net>
References: <gerrit.1793947607000.I784f3ffe17ecadabf96caad11fe9f774aa00b7cc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTQ3NjA3MDAwLkk3ODRmM2ZmZTE3ZWNhZGFiZjk2Y2FhZDExZmU5Zjc3NGFhMDBiN2NjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6fe69e452693669e1d494180f39d448513664e2c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQ2mN-000000008Gk-3zk6
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: comp: use the wire
 byte when escaping v2 uncompressed packets
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2798931578534791877=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2798931578534791877==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lWiVWHdqw/g="; charset=UTF-8

--lWiVWHdqw/g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2142?usp=3Demail )

Change subject: comp: use the wire byte whe=
n escaping v2 uncompressed packets
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

comp: use the wire byte when escaping v2 uncompresse=
d packets

compv2_escape_data_ifneeded() wrote COMP_ALGV2_UNCOMPRESSED (the=

algorithm id, 10) instead of COMP_ALGV2_UNCOMPRESSED_BYTE (0) after
the 0x=
50 indicator=2E Receivers reject that header, so packets whose
first byte i=
s 0x50 were dropped with stub-v2 and lz4-v2, e=2Eg=2E tap
frames to a MAC a=
ddress starting with 0x50=2E

Broken since a75bb2e4 ("Implement the compres=
sion V2 data format for
stub and lz4=2E")=2E

Change-Id: I784f3ffe17ecadabf=
96caad11fe9f774aa00b7cc
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142
Message-Id: <20261106125757=2E1472=
1-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg40883=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/comp=2Ec
1 file changed, 1 ins=
ertion(+), 1 deletion(-)




diff --git a/src/openvpn/comp=2Ec b/src/openvp=
n/comp=2Ec
index 387a7c4=2E=2E513a766 100644
--- a/src/openvpn/comp=2Ec
+++=
 b/src/openvpn/comp=2Ec
@@ -100,7 +100,7 @@
 
     head =3D BPTR(buf);
    =
 head[0] =3D COMP_ALGV2_INDICATOR_BYTE;
-    head[1] =3D COMP_ALGV2_UNCOMPR=
ESSED;
+    head[1] =3D COMP_ALGV2_UNCOMPRESSED_BYTE;
 }
 
 

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I784f3ffe17ecadabf96caad11fe9f774a=
a00b7cc
Gerrit-Change-Number: 2142
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>

--lWiVWHdqw/g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2142?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">comp: use the wire byte when escap=
ing v2 uncompressed packets<br><br>compv2_escape_data_ifneeded() wrote COMP=
_ALGV2_UNCOMPRESSED (the<br>algorithm id, 10) instead of COMP_ALGV2_UNCOMPR=
ESSED_BYTE (0) after<br>the 0x50 indicator=2E Receivers reject that header,=
 so packets whose<br>first byte is 0x50 were dropped with stub-v2 and lz4-v=
2, e=2Eg=2E tap<br>frames to a MAC address starting with 0x50=2E<br><br>Bro=
ken since a75bb2e4 (&quot;Implement the compression V2 data format for<br>s=
tub and lz4=2E&quot;)=2E<br><br>Change-Id: I784f3ffe17ecadabf96caad11fe9f77=
4aa00b7cc<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<b=
r>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142<br>Message-Id: &lt;20261106=
125757=2E14721-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40883=2Ehtml<br>Signe=
d-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/open=
vpn/comp=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>=

<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/comp=2Ec b/src/openvpn/comp=2Ec</span><br><spa=
n>index 387a7c4=2E=2E513a766 100644</span><br><span>--- a/src/openvpn/comp=
=2Ec</span><br><span>+++ b/src/openvpn/comp=2Ec</span><br><span>@@ -100,7 +=
100,7 @@</span><br><span> </span><br><span>     head =3D BPTR(buf);</span><=
br><span>     head[0] =3D COMP_ALGV2_INDICATOR_BYTE;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    head[1] =3D COMP_ALGV2_UNCOMPRESSED;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    head[1] =3D COMP_A=
LGV2_UNCOMPRESSED_BYTE;</span><br><span> }</span><br></pre><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142?usp=3Demail">c=
hange 2142</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2142=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I784f3ffe17ecadabf96caad11fe9f774aa00b7cc </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 2142 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>

</body></html>
--lWiVWHdqw/g=--


--===============2798931578534791877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2798931578534791877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2798931578534791877==--

