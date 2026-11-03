Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43717606A33B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eClnAQuz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IujmVmZL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Q1r3QCaY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DMeHPtAP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ffE02ZmqzhSrU4LTt2kKzOWDlnwKE0K3v6h490oj/iA=; b=eClnAQuzM4iIqOgy9AXzWQkS5L
	2xTVeD2YdCzAWTVlpWnAcW6Yf6OC+/j5/Zr/cI7ozLwjCP7PXbyvf2gcHZ1tngfl/XRKrof3MDoqp
	kmXVtctvltYIHAou4TZj8kiyQVhqbUNtOdUvGi5S6TDnx8vr3qNnB/jsNw11POR2KS58=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKWf-000000001lj-3ySX;
	Tue, 03 Nov 2026 19:50:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOKWc-000000001la-0GK5
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:50:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p1/YQlmMHp/uQ9Cczb/Z9DTi+xvhWCI04JuShxjcw10=; b=IujmVmZLxUMhI4r8VK+E2zztsm
 WzDCgFnksQsalJ6ggazxrwbAja2sPlKg1yaJm0MBQVcNnGWvsG2gNrPgHwW9Q1x2Lh8zqIjMwNcOc
 sviKELMytyN1L8RdOji3/3tcroTAPFHS1L5RAUBbIVsHk+XGcYhUMBwPof7H6328cMHQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p1/YQlmMHp/uQ9Cczb/Z9DTi+xvhWCI04JuShxjcw10=; b=Q1r3QCaY/t3KvuYfm9q5SmS5gZ
 TIG2GHsP5HjOreLBXgU8anInxjivpNcB3X2FcIha4P30xehWEjqrEW9ebHEr1Yqacc6Hb3LxA0eVv
 15xVEHmwuROTVs3Hxx+sWSYDfj9WaibBjq/UGJVGtuAwnSFPBK47MSx0vhZ+fODokHHM=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOKWa-000000004tK-0laY for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:50:28 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so3788609f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 11:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793735422; x=1794340222; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p1/YQlmMHp/uQ9Cczb/Z9DTi+xvhWCI04JuShxjcw10=;
 b=DMeHPtAPopvfqbseRsibm/9zJ2Aohowu1mm/vCxXHmzwvsRj7PUd2L9rbtaArt3xro
 171S7o58cvfFijO9R1/S7LdaPkpR7wYKKsGMZ9yvEGPG4laINy9zX6+DsFrfaU1/g9N+
 pW1CQVF1aXP3E3UayCGiwx/mj6Bxp93zlOE9tT5ry+x5yhbTyZIqDWRXFp5LoVZNQ3mO
 s2O5FzaDOgdMj29alCkzkO1mNYV65SOGqQMlCh70drO+yzDQ3/jCa4khnacg0kOL9ou/
 dkGLbIMRcwbleqV83vPJdnGb7vVFM0osKO3z9iE/zfiBNkqYKl7l1t1SuCVCqJtc23It
 nGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793735422; x=1794340222;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=p1/YQlmMHp/uQ9Cczb/Z9DTi+xvhWCI04JuShxjcw10=;
 b=qIRbRqz5e2fXaQ0XTe7FnD6K+GRoR38ZIR7erHpkYBKfYJ58Y/koyj1C+/nZBEuYZW
 SI7mGDQA6gwE+zyA7/P0q2gpdVLiZyVEjwct30KMXRdBvKAOGSlsa+xR0vQ4Uz6P3yy1
 VRKQXdZPS8VEnDZPNeQAmjH6sjJhB67QIeHbO1WdRXiTABPd467r/DuAiBRyzOod0txz
 GWrq7QeiCPjQ/OQ3Shcz3mIUUNoOU+nDEwew6U4WYH1dWKWh6zPzERvaOSZZtfDXhP5n
 OEgErg3GGWMVHVc7QL3/ZYKYZRWlDUKIE8/xIhd2aDR3bv4Aghurfvds/H20vSqwOUKT
 PNYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzZfkX+V7x0dEsO9Aka2G2Vs8TSEfBf2we0LSSWqH2JrURkzPQR6JLZusHKa9U9Qt0P0BvOxU+XpWXzOTv@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9zQTfIVZUfAXxknBOYYGWY003UEaVVsDjyvOXEJdEiw2mjkKnI
 P7b6icrBQQ3Vm96H1ckhj/QVzSPjpmFSQtQLSRjns+BNrY34nFN6ihuOamwIDU2Sf1xSvDFQFC2
 2VaqGNRk1iVajlUu5uDwDAeWZGZs6Yz5sYd5TzZmt1VQw0OoVgICPhVquNzTOCH6gaq7h
X-Gm-Gg: AYBFou3S05/xXvP8FAQwqDcQmZyMesOcz6lQl9qJW+tNKpBWtmRv5yDHB2EIXZIia01
 Gibz4gC69N0mnMmuSMobf8V9W1NEMMUcSATCdFs9uqPFWBHxyxhZDvKQs2goxQICR/pU7gc2UaP
 tkJzPeuv2vsIrrsKP4dxW2MRN8Hk2BkU5hT92xCRtkdrmk6s7whIFTyuPjC9FITnFK0ekqIqkZL
 Xa1hbpCb55YzEGXMLKpIixp6W7E6rk21SuKIyxruXe/jKjrPFzowccgT9d0Nc/FDmWwfw/hIp0b
 lJfHeZe6nOnCFPERTxpJxxPmSsE6gTWrYDYkZV6t/7nVJR7ZMhh4/zMIulhhFGngPXSLnshmHkH
 2w/BSi2ZajnsEHj4zVJM/GxLWfySBvHR3MXD+SkVDcyGYx5BsFeKlHW9Iy/XosSDSiBNTVqnrPF
 4bJru3nsZ7ntJXVGi4qN82HdZVxmkHBkedUB3aNpQ4BkKHSnR5TV+lAxP2bKL9y6FE2UjLRlYql
 Et1TrR5f4d1TivfL374G6Ip7pQcAYVzdcJn+Kszv9/iiikUE3ACF7EhBL5PnY59LvaUk2ITxd/1
 VGZapNOTBQ6gZzC+anhil68vscwGWTUnTT4sQJg0SD9+jYi0fp7SIJyLsnqZxzjCq5gCVH0Q8d2
 mli8KI8muH6Z+BDCw7WcgpQncF9qVDJoxzRoN5Ap0YlH7d3BucnsmxtgLvQ9YIKqEueVygNc+bI
 Eiw1PiVvCtf40mzQ==
X-Received: by 2002:a05:600c:8706:b0:4a1:e0d5:293e with SMTP id
 5b1f17b1804b1-4ac1765d3ddmr345836525e9.21.1793735421477; 
 Tue, 03 Nov 2026 11:50:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm115139705e9.13.2026.11.03.11.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:50:21 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 19:50:20 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9eb4b74b53d680c160b8ac65ab844f6404431e62
X-Gerrit-Change-Number: 2109
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2109?usp=email>
X-Gerrit-Commit: 99292e77a6c9c2fd94d3d767dd5dfe00055ca925
In-Reply-To: <gerrit.1793731291000.I9eb4b74b53d680c160b8ac65ab844f6404431e62@gerrit.openvpn.net>
References: <gerrit.1793731291000.I9eb4b74b53d680c160b8ac65ab844f6404431e62@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzMxMjkxMDAwLkk5ZWI0Yjc0YjUzZDY4MGMxNjBiOGFjNjVhYjg0NGY2NDA0NDMxZTYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4459a3fc92c31c905f40c647c2110b684f393f93-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOKWa-000000004tK-0laY
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: check
 DhcpNameServer lookup in GetItfDnsServersV4()
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
Content-Type: multipart/mixed; boundary="===============6288982441381635541=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6288982441381635541==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mI9/iwkxYCU="; charset=UTF-8

--mI9/iwkxYCU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2109?usp=3Demail )

Change subject: openvpnserv: check DhcpName=
Server lookup in GetItfDnsServersV4()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: check DhcpNameServer lookup in GetIt=
fDnsServersV4()

The RegGetValueA() result for DhcpNameServer was discarded=
 and the
error from the earlier NameServer lookup was tested instead=2E Wit=
h no
NameServer value, err was still ERROR_FILE_NOT_FOUND, so the DHCP
fall=
back always failed=2E

Broken since 0f3b7d17 ("win: implement --dns option =
support with
NRPT")=2E

Change-Id: I9eb4b74b53d680c160b8ac65ab844f6404431e6=
2
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2109
Message-Id: <20261103184453=2E9550-1-gert@greenie=2Emuc=2Ed=
e>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg40608=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 1 insertion(+), 1 d=
eletion(-)




diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnse=
rv/interactive=2Ec
index 484f27c=2E=2E4a8d0b5 100644
--- a/src/openvpnserv/=
interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -2151,7 +2151,7 @@=

     if (!strchr(addrs, '=2E') && IsDhcpEnabled(itf_key))
     {
         =
s =3D *size;
-        RegGetValueA(itf_key, NULL, "DhcpNameServer", RRF_RT_=
REG_SZ, NULL, (PBYTE)addrs, &s);
+        err =3D RegGetValueA(itf_key, NUL=
L, "DhcpNameServer", RRF_RT_REG_SZ, NULL, (PBYTE)addrs, &s);
         if (e=
rr)
         {
             *size =3D 0;

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2109?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I9eb4b74b53d680c160b8ac65ab844f6404431e62
Gerrit-Chang=
e-Number: 2109
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--mI9/iwkxYCU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2109?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: check DhcpNameServer =
lookup in GetItfDnsServersV4()<br><br>The RegGetValueA() result for DhcpNam=
eServer was discarded and the<br>error from the earlier NameServer lookup w=
as tested instead=2E With no<br>NameServer value, err was still ERROR_FILE_=
NOT_FOUND, so the DHCP<br>fallback always failed=2E<br><br>Broken since 0f3=
b7d17 (&quot;win: implement --dns option support with<br>NRPT&quot;)=2E<br>=
<br>Change-Id: I9eb4b74b53d680c160b8ac65ab844f6404431e62<br>Signed-off-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt=
;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2109<br>Message-Id: &lt;20261103184453=2E9550-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg40608=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 f=
ile changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><=
span>index 484f27c=2E=2E4a8d0b5 100644</span><br><span>--- a/src/openvpnser=
v/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</sp=
an><br><span>@@ -2151,7 +2151,7 @@</span><br><span>     if (!strchr(addrs, =
&#39;=2E&#39;) &amp;&amp; IsDhcpEnabled(itf_key))</span><br><span>     {</s=
pan><br><span>         s =3D *size;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        RegGetValueA(itf_key, NULL, &quot;DhcpNameServer&quot=
;, RRF_RT_REG_SZ, NULL, (PBYTE)addrs, &amp;s);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        err =3D RegGetValueA(itf_key, NULL, &quo=
t;DhcpNameServer&quot;, RRF_RT_REG_SZ, NULL, (PBYTE)addrs, &amp;s);</span><=
br><span>         if (err)</span><br><span>         {</span><br><span>     =
        *size =3D 0;</span><br></pre><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2109?usp=3Demail">change 2109</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2109?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9eb4b74b53d680c=
160b8ac65ab844f6404431e62 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2109 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>

</body></html>
--mI9/iwkxYCU=--


--===============6288982441381635541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6288982441381635541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6288982441381635541==--

