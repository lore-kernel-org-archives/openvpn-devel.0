Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE9606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Cv4nedTB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PxwfZGI/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GXJ8mE1G;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HSYpj/2l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ccnwvtcI3s03EjqtCBnqBbsm9qQdCxTjteCvSpvVN1E=; b=Cv4nedTB6BWO11zWtfm6JibmM4
	92C2mnYEPz3E8VmaXT9lCJNIDdwLtI9NyH8ieAH1e4x2Y1Izs5DtD0MTfhb3CyjAH7le2VTXeTbm/
	Q+eQImT152TTwAaFvhGQmAOKD4vTpVax9XTP6Trl+DamscLzxVZyj/Nzbaho/eHGxpAE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOMDN-000000001L2-317p;
	Tue, 03 Nov 2026 21:38:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOMDM-000000001Ku-1LIL
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 21:38:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6JZVb2bR7+Fpm9W/V8B+cZB8Cifevxg1zz2AseaPllM=; b=PxwfZGI/maqaHcVAA3hpImznUy
 nhXeVfyWTnAuDHBsMrgyFrDOQnbdpvytJsvNmSrlwfPxfj2Qqg/ZTF+t8RN0zynWfLQcKmpLsi04w
 vGJc7vOTdwiJ2Xe1plGZTYwHtUjY18xRNWoW3HCPZ7sPeD80lHEkBSajdDBabzrxdFiA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6JZVb2bR7+Fpm9W/V8B+cZB8Cifevxg1zz2AseaPllM=; b=GXJ8mE1GRhK8pQQFmQzC6Cxr0d
 sbRHbf/+yzqV5idq8n7C6HJLaBiRk83fAU0eAhY+EcsAUWyMKiPdx7vDFuDM5sz92DsaAIXcSNw3P
 SAieKl6bsmjbRqIRDd7192d+DOF+QArxfqxJzw5ZCUXhE+JHf7kn1/UQYVlYTtHqW+WI=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOMDL-000000007TX-2SG7 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 21:38:44 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so81905e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 13:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793741917; x=1794346717; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6JZVb2bR7+Fpm9W/V8B+cZB8Cifevxg1zz2AseaPllM=;
 b=HSYpj/2lIvIuQ0Ls+5CPeN4lDAkWzLt4YFJPSAcsEeF9kBqJlAwubUt+zeDGoILm+O
 R7y+BkZxWpu5zKcsW4TqqUKQhVuMpKpB8b8xs+tGaD24E9/NBgMD2ARbHXAq1bNhN8J5
 DJKVGoLkSzvVu8ijOklovPZRaZ7zyb5o4QnC3hm7o7EZyVNTtjAMO+fwUun3ulCJDc1M
 ayJvtBf88oWYSK19iSd+1zm7PtU6y4zPWV7zEvbVB030MdzwnMAZyC0hZH/5EEDlaQAf
 O0V1c78c95FMG+etf5AzcPhlX/UcUJabFfjt8EJiRRKrP/F2tEaMnyG4K4OSyIuuYHBv
 iklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793741917; x=1794346717;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6JZVb2bR7+Fpm9W/V8B+cZB8Cifevxg1zz2AseaPllM=;
 b=A2F+F8jF4Hh2bMm5RqO1Det+mZMjMGIGP8pPcLsrKaJF4tSyYPdhIDrz84AE0kzT1M
 3uH8BGMl8ue3k930aaohNeOYyUUUDTxnzA7uisgQxq+lZGVBnJOrHxKC/78xnSEi9VnP
 RzkStK4udH5ptlYSk6DE80QOVvv4l+7bYWcypRb1W8anQwH6Qrxcc1h+QY0Tok1oDtEh
 EYpbXQD5sAtDLuiidbQA70tm1XeY9gn75nKOjAevdUCeQi1p58J1nCvTfttqh86XTtNJ
 isEqZrfWwjz1bxOojE2YVtaNT4oEW30aZnY+cTtQnNCUYphlWV5daLIh/wUu3wrC51tn
 XAXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdixI4x1X1KlxF0bOj0LQuNJ9C467DkDxfTCexVWyh5Zqfb9lCMsAMd/RcMm7TJmP+uiKi4ISjl1ZdPcOz@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/ruCVUROJWX+hP1WWBFF9PItQ+vqBYf8Zxtx63+Z7rgHrr33lK
 I4mv0+pF/hxMVHtrFRSyvOOFVaMXqcUwfjRChTorT495th5w4lVWVZEWbNkK7yV8MuLDhJkKJna
 u76Z8olm/3erntecDiVAvkeYJpuBNDNNL3w/t/H+Vqmirj1TRbZXH8NwuPwn0sVW8yM9u
X-Gm-Gg: AYBFou1Ecj+s44QatiKDaz00QxBR7v0p8d4KBMO6FV7MtgMzNHWD0lFDdQ25H3V4heM
 I8aQSn6PxdEu0tVrCsIXroB/ldgeC54K3tIncsIv9ZuQA0DSaWoh8mdNl1kbAvnePnQ+0L/75Xu
 VhwjepN9NXfgPtdEvdwTrbHtCjXe76AZlo5Gypx/jjA5WZkx4kpO9ncHzxi7ngmBPq79JwOYAlo
 4HTmfJLp+EK9YIInnhmVYHRkpxtMk04RZfSETKttys18c8gQCxwZpqj2J6j1KL8qpJZAc3ikpXh
 vphH8BKGtkoNuTt0ueU52P7cq5K4eqUlEnR5FOpbp7Ixz8wGurVC5a2rybVu/VJkHxHZrCnEJ2K
 BvevgAFofWY4rvJYEKbZrZzKLVFf37qwSaVLHoHmwGCKTj3HM2GFtcb08p+dOjGDygeZH+u/mBc
 Hr+zzabeTUxqLjdChOiJ7t5GBLimW3j3xLo/kxiVabWhz/Y8H9GzUH9rYqk13iZjUAOb03DY748
 f065WlwzfN+OVbLpn7NA4Mp+Z/Bb69qKGYCzBJB70PklUK0JyyeCW0CKcTmQW4EygbJh8xR8rBb
 pmgo9rhXEVglXT1q6viLB7W4PEpqf5ZdB35DEYAgH3zO83oW5gSo1g8Ip4gN3mHg9LQkGtcrVEJ
 M7itCnZeRYl8xivawfNrBJQmm9pBxdzaTw9oFBhYjBzWxVBb4UZ7pK6aaK3uT0nV/K6l1a1UfCD
 5hhFWeDy0UX2GBmA==
X-Received: by 2002:a05:600c:524c:b0:4a1:e6c5:e44c with SMTP id
 5b1f17b1804b1-4ac17470f97mr336200645e9.10.1793741916880; 
 Tue, 03 Nov 2026 13:38:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43c17ecdasm4607855e9.5.2026.11.03.13.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:38:36 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 21:38:36 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib53e82554712d881b1e24f6f3a2f8fbb702951bd
X-Gerrit-Change-Number: 2110
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2110?usp=email>
X-Gerrit-Commit: 173dcf5609e54cbfbde0058e50e0c50fe4adae5c
In-Reply-To: <gerrit.1793733304000.Ib53e82554712d881b1e24f6f3a2f8fbb702951bd@gerrit.openvpn.net>
References: <gerrit.1793733304000.Ib53e82554712d881b1e24f6f3a2f8fbb702951bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzMzMzA0MDAwLkliNTNlODI1NTQ3MTJkODgxYjFlMjRmNmYzYTJmOGZiYjcwMjk1MWJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2a759b74a99c9206fad6fa5545e2bc43b85915ad-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOMDL-000000007TX-2SG7
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 use registry default as format string
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Heiko Hund <heiko@openvpn.net>, Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5688641010240304106=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5688641010240304106==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R7usdwDwJt8="; charset=UTF-8

--R7usdwDwJt8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2110?usp=3Demail )

Change subject: openvpnserv: don't use regi=
stry default as format string
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

openvpnserv: don't use registry default as format string

=
GetRegString() passed default_value, which is built from the install
path, =
as the swprintf() format, so a '%' in the path was interpreted
as a convers=
ion=2E Print it with "%ls" and treat only a negative
return as failure=2E

=
Format string use introduced in b1263b06 ("Ensure strings read from
registr=
y are null-terminated")=2E

Change-Id: Ib53e82554712d881b1e24f6f3a2f8fbb702=
951bd
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Heik=
o Hund <heiko@openvpn=2Enet>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2110
Message-Id: <20261103200234=2E17639-1-gert@greenie=2Emuc=2Ede=
>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg40655=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpnserv/common=2Ec
1 file changed, 1 insertion(+), 1 deleti=
on(-)




diff --git a/src/openvpnserv/common=2Ec b/src/openvpnserv/common=
=2Ec
index 7a23d41=2E=2E671ddde 100644
--- a/src/openvpnserv/common=2Ec
+++=
 b/src/openvpnserv/common=2Ec
@@ -38,7 +38,7 @@
     if (status =3D=3D ERRO=
R_FILE_NOT_FOUND && default_value)
     {
         size_t len =3D size / si=
zeof(data[0]);
-        if (swprintf(data, len, default_value))
+        if=
 (swprintf(data, len, L"%ls", default_value) >=3D 0)
         {
           =
  status =3D ERROR_SUCCESS;
         }

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2110?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Ib53e82554712d881b1e24f6f3a2f8fbb702951bd
Gerrit-Chang=
e-Number: 2110
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>

--R7usdwDwJt8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2110?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: don&#39;t use registr=
y default as format string<br><br>GetRegString() passed default_value, whic=
h is built from the install<br>path, as the swprintf() format, so a &#39;%&=
#39; in the path was interpreted<br>as a conversion=2E Print it with &quot;=
%ls&quot; and treat only a negative<br>return as failure=2E<br><br>Format s=
tring use introduced in b1263b06 (&quot;Ensure strings read from<br>registr=
y are null-terminated&quot;)=2E<br><br>Change-Id: Ib53e82554712d881b1e24f6f=
3a2f8fbb702951bd<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt;<br>Acked-by: Heiko Hund &lt;heiko@openvpn=2Enet&gt;<br>Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2110<br>Message-Id: &lt;2026110320=
0234=2E17639-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40655=2Ehtml<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvp=
nserv/common=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></=
pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpnserv/common=2Ec b/src/openvpnserv/common=2E=
c</span><br><span>index 7a23d41=2E=2E671ddde 100644</span><br><span>--- a/s=
rc/openvpnserv/common=2Ec</span><br><span>+++ b/src/openvpnserv/common=2Ec<=
/span><br><span>@@ -38,7 +38,7 @@</span><br><span>     if (status =3D=3D ER=
ROR_FILE_NOT_FOUND &amp;&amp; default_value)</span><br><span>     {</span><=
br><span>         size_t len =3D size / sizeof(data[0]);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (swprintf(data, len, default_=
value))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
swprintf(data, len, L&quot;%ls&quot;, default_value) &gt;=3D 0)</span><br><=
span>         {</span><br><span>             status =3D ERROR_SUCCESS;</spa=
n><br><span>         }</span><br></pre><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2110?usp=3Demail">change 2110</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2110?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib53e82554712d=
881b1e24f6f3a2f8fbb702951bd </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2110 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--R7usdwDwJt8=--


--===============5688641010240304106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5688641010240304106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5688641010240304106==--

