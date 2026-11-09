Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A186606A322
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eja+E4xQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bpKFng7u;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XKL0QljA;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BhTKT/Dh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PkGDoIextH9J7MUnIVhfzVqYZm5Pg3hWR0UYHKPPo7U=; b=eja+E4xQVLI/8AP26B+ZXlDGRJ
	TzGAYLq4zqXUjeggNRzeG5I1tj45X0jW64xiPKjJAv7u20VvaNEkZBMZ5zBjQHPHyCM8sX/DRW+FA
	VPkF+KMj9NXPS7Q9lq3DV8ggTPBOMDXpaaVTV+hsX4NyTTuymv6TwTz9itAaZqGw769I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQO8n-000000002wt-3KsK;
	Mon, 09 Nov 2026 12:06:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQO8l-000000002wm-2G7N
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:06:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4ffAWQKb8RlbfOJtyK9keGXaJXEMhV/jkzvYOlxRV8o=; b=bpKFng7uoNUBLoPT/2EtFmORZj
 yMGGE8uD1qL7LQ0T5l2Dg+Zed0ddive+fzVENI+9ThWHStzfQ3SL/GJ3Qw4ZgiKhYWBpS6AbzPej4
 W5xyKLl1CP1bI10z5iTRVAyy89deeJKpElqMZ7fcYBBGMR389eNiQctpC5GM7/H9M/mw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4ffAWQKb8RlbfOJtyK9keGXaJXEMhV/jkzvYOlxRV8o=; b=XKL0QljAn92ML+6V7FYfCD5i9j
 mqb0+bJhugE9j5xVkmm7H3fO/6DmBWe9NQzISXRO0qm+NVx5yUB3dUjPdrxKB0UVYGT84s79so2Qu
 6entQUaM5Qcs0r+V9CPRW1yARXGywoziIYz8UAm6y06wlVKn0jtiofBCOQ/gHzQm+eQw=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQO8k-000000005jo-0A9F for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:06:23 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso686964f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 04:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794225975; x=1794830775; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4ffAWQKb8RlbfOJtyK9keGXaJXEMhV/jkzvYOlxRV8o=;
 b=BhTKT/Dh3hjWFQzZADU5DurTl70E5a4RjqFdaTWXQ/kW2EP63zsms2y/oP/eCkihed
 GBnNNZu3N7ss5GXTl/RAEtEnz5+CLrdR8/xk2SQkULpvDhF9zY8gxFCCXKCR+GB+bbUe
 XZv+WDumljs6+KtopglVzWw6rylMjof1eym3UyqrR5xgSPgWwLYwEHWNGmCsU55FbPsK
 m0HpAwtjBTMAHzsybFWTETxp23sBRIZDe+HUjlsIyTebgmLQpZMa1n/anRzK1DbtWvxM
 YILv2wOoSOPJPTUWIaAZ7R9efcMx4MlFLwgeT6WjfKGhK9UXKcw8ebozioEJzqZjotxL
 AtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794225975; x=1794830775;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4ffAWQKb8RlbfOJtyK9keGXaJXEMhV/jkzvYOlxRV8o=;
 b=c8YHVWB+Jpz4s1/3Ug1YkW0vte7NWgVMb7JISf8NPkqo1NXsHLXEPd1OgdvQ2NvCRu
 93RufMojauQ+WSNzYVw/3BbirRfc79lzK6gd+/xbpmSRao0NWRGPSsy5JjGuBPxoKw2a
 gOLEsOpaFv/mRnMKbj03H9X+aph40CUjjUtTPNCRqp0Oo/bNrvNWA5vbDQc3RQp84PsV
 dJDHBqIKO3Ty3CsiEQvDfkfDp4QO1jVZk8uZM6/pNcy9qM6ANk/480Rp0zuG2o4zfjYW
 yr3Y5LpEgSTmmYF6ERKN/SUpFjs8oaELXeTBFkoYJEaVakBZvVMyM1hqRsGx+PvoYRDS
 JEHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEymuR2v14WSmPj/zMaCU3+zlslHYigGrpUemLACRKc3uvLEteSso+hatrDDk++dZlpDemckECB/gQhJvEc@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9ZKpr7Z4b8vFHlXxJO1EOpdwH+3dG9H7e9j4XHpzV6u7w769qy
 pKo9BJ0oxUX7o8qCw553IO4Zk4jgWqus/cNHKAmLeuXv54NUqnZpSM9/NQgzTRq2cX5Lxj6W82X
 RRgx6tVCfImBNHTHcJm6GdtiIFoQciuebdZbml0kw4wIie0Avp8ZCf2MQKvQGNO9iHve4
X-Gm-Gg: AYBFou2BBCXA9YAt1f8e1ZD9VoqNszlgSG9ofT4veRBc4YH+u3hEQ8+Fb065jLpdnWt
 zA79yt4PeHOCSVc2/zeDAfvWqlwOTUVwKIoE4yuOPcC/s9qPJ0Tfqg1DFKK2JJRevkRtCH4gZpg
 HXOeiwDmOHogOVQZu7OfrM7w37IPkXCXaSvRGDSrdiy+uTdH5h56UhsHDv2gXgs1WVE7QT6fbpR
 NQQeVCmkYz43smpIfBEZHIcVy9GmtJvzWb871Exq7l9nNs2kQYLe5/txHGBr6fU5vUKKCZiqJvt
 tgRNAi2cCJ8dwJNI2n+lFsnD8OJ7oqhr7Zur5tdNTkkrBgnx4EoV2nTMc7MGX2SBScetYsyz8Im
 zWD/9s3M2MvPzXuNJafPGsreaJFLb/qSrLUb6LRWuRCzDh5wWzugZlCc4nM8MxC+QwFRkjsQQBe
 C4YtR90/jIJvVVBDJetoz45m59xUh1fa8E2m4eW9s2WMlKj8zHtYkAo5czm25e/OMOlMF94c930
 TBHc0u5txZHKW9ZQwTJk5XNdmsoGHBp1Bvt8yfSc+WPEQafZSPi4sax91wB3GBeyw19FE8JXb/i
 nPGBztrCKe7vEAwmb6xDISHGT31rpUngqb2f/0xAl+f16iMP67GLTjy01m/QY0k57fbgs7FmYC9
 PY1xWNLGqb61m3e5D6sPhNP4Zc2b45C69c4eU4m6eAqT+sRrcZy3En9ojGZbHxn3K5rlj4XzctU
 JVAeRipJW/DStoaA==
X-Received: by 2002:a05:6000:4614:b0:48e:6264:c373 with SMTP id
 ffacd0b85a97d-4958ac94d84mr7211272f8f.14.1794225975262; 
 Mon, 09 Nov 2026 04:06:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4959783fc31sm9573346f8f.48.2026.11.09.04.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:06:14 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 12:06:14 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc
X-Gerrit-Change-Number: 2146
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2146?usp=email>
X-Gerrit-Commit: 672f39fbd0a88ce0b387d581da22a7b5d30b91d1
In-Reply-To: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
References: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTcwMjAxMDAwLkllZDllMzZkNDViMzBhODg2MTBjYWZlZTY2OGVjZWZhOThiMjllZGRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <be8cf5f26cac534ddbca87fba9e82ac625309803-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQO8k-000000005jo-0A9F
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: reflect_filter:
 initialise warning_displayed in the rate limiter
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1570013458661102997=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1570013458661102997==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cIvX4tZPy4M="; charset=UTF-8

--cIvX4tZPy4M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2146?usp=3Demail )

Change subject: reflect_filter: initialise =
warning_displayed in the rate limiter
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

reflect_filter: initialise warning_displayed in t=
he rate limiter

initial_rate_limit_init() allocates with ALLOC_OBJ, which =
does not
clear, and assigns every field but warning_displayed=2E The first =
period
reset assigns it before anything reads it, so nothing misbehaves tod=
ay,
but there is no reason to leave a field undefined=2E

Change-Id: Ied9e3=
6d45b30a88610cafee668ecefa98b29eddc
Signed-off-by: Lev Stipakov <lev@openvp=
n=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146
Message-Id: <20261109091139=2E4=
816-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg40963=2Ehtml
Signed-off-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/reflect_filter=2Ec
1 file ch=
anged, 1 insertion(+), 0 deletions(-)




diff --git a/src/openvpn/reflect_=
filter=2Ec b/src/openvpn/reflect_filter=2Ec
index e5226e4=2E=2E953fff5 1006=
44
--- a/src/openvpn/reflect_filter=2Ec
+++ b/src/openvpn/reflect_filter=2E=
c
@@ -95,6 +95,7 @@
     irl->period_length =3D period_length;
     irl->cu=
rr_period_counter =3D 0;
     irl->last_period_reset =3D 0;
+    irl->warni=
ng_displayed =3D false;
 
     return irl;
 }

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc
Gerrit-=
Change-Number: 2146
Gerrit-PatchSet: 3
Gerrit-Owner: Lev Stipakov <lstipako=
v@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--cIvX4tZPy4M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2146?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">reflect_filter: initialise warning=
_displayed in the rate limiter<br><br>initial_rate_limit_init() allocates w=
ith ALLOC_OBJ, which does not<br>clear, and assigns every field but warning=
_displayed=2E The first period<br>reset assigns it before anything reads it=
, so nothing misbehaves today,<br>but there is no reason to leave a field u=
ndefined=2E<br><br>Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc<br>=
Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Razvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2146<br>Message-Id: &lt;20261109091139=2E4816-1-gert@g=
reenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg40963=2Ehtml<br>Signed-off-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/reflect_filter=2Ec<=
br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/reflect_filter=2Ec b/src/openvpn/reflect_filter=2Ec</span=
><br><span>index e5226e4=2E=2E953fff5 100644</span><br><span>--- a/src/open=
vpn/reflect_filter=2Ec</span><br><span>+++ b/src/openvpn/reflect_filter=2Ec=
</span><br><span>@@ -95,6 +95,7 @@</span><br><span>     irl-&gt;period_leng=
th =3D period_length;</span><br><span>     irl-&gt;curr_period_counter =3D =
0;</span><br><span>     irl-&gt;last_period_reset =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    irl-&gt;warning_displayed =3D fals=
e;</span><br><span> </span><br><span>     return irl;</span><br><span> }</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2146?usp=3Demail">change 2146</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2146?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29e=
ddc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2146 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>

</body></html>
--cIvX4tZPy4M=--


--===============1570013458661102997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1570013458661102997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1570013458661102997==--

