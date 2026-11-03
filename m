Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E0606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=R7pegXJz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BJe0kClE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NzH3gBLC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=H5LkeH2t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9LJIdMMUT1D57w+B2PAcbyPTFTipaklTgXPGjC3On4M=; b=R7pegXJznnAdIdQPx9uAN/c0QC
	l3+4KdZZ44Do2BEnyp/hn2LNHel8iFFDgVyjsyc7AgwPEK3GsfFK6QP7Wv+IFRa487NRI45HJtWJ+
	tc97cQslM7aEbX4fW1FN4H1dIC7bbbmfo0RY/M13S1Q1rWT+R4ooyhWY8lNIVz+mdpt8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOJUX-000000003MZ-00ER;
	Tue, 03 Nov 2026 18:44:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOJUV-000000003ML-344I
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:44:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+iwMNDHljPlQCyikqFNrJKyL9V45fLdLHWFm8GoqIbA=; b=BJe0kClEp+KEE2w1bFmtS8FAgN
 wl5H6d5a1ecKYfndUw5NyH3XVui1MNVzWcOAX/sWbY3hege9WlO+nN7S9B4VE5U0wK7sdvvjp+8Xb
 7DyZx61Uv9Al9L6YIITojkazTKyAQaFANQE6lNvZPX8tfA8o2zPOImHQrdSqgTpqB4Qw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+iwMNDHljPlQCyikqFNrJKyL9V45fLdLHWFm8GoqIbA=; b=NzH3gBLCvlFfwzqvRQ/HGv3jpx
 iBHKYH1MDvf/phAq5fOQ3bUNCHPoj/xINlIY0xSLE/9nQsoODANq52SNAoobvqVfO9WdGSTdgziNo
 ZX8fqK1fxWTOdWQgDRZTsmw5WvtSsM5ScL+t1cTNy7TjY+2heAdgbvaU0b93bbFqje+w=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOJUU-000000005BJ-0PlW for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:44:15 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso36261905e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 10:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793731447; x=1794336247; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+iwMNDHljPlQCyikqFNrJKyL9V45fLdLHWFm8GoqIbA=;
 b=H5LkeH2t1xo2qFt9CPUUIEGJ4vo9dio/1sL+6gQj2noiv9NYPTsEWjncBEd5nZo00k
 kbjJF+Z4n0Li68nGg17X5DEueoSQGKIhMR9OQlB4TMDyxajQ2T2wWBOkz29Csfmk/9U+
 QxwiRTRaV5Z0w8SKhLlggIgT202KJfSEnD2D5AFIUwTxD4SEmAJL3idxWC5FfpOsi/Qn
 Uyh6lmAmSLWfIxxqMK1NFxUSeik/7Y6GkCfLGLVEcR/J7N2DkkYUcP5ZoAhXuVBlkD6w
 vzXpoQTQeEvlmuYSCvPCEoMeslmdQ1x3rWaK9xwxI627/i8Ok8MJ11XokBP+B2th0Fg5
 1Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793731447; x=1794336247;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+iwMNDHljPlQCyikqFNrJKyL9V45fLdLHWFm8GoqIbA=;
 b=r9vjBaoV/X6QTxaOCSosD7f55gyT68uQgUN8Bep5R3m2VorVqxw7o96xedCc3RTMmx
 Ue2Z6C8k/Vctv/wTaLbO/9vL+c+A0ZbhwF+KIfTAvYY9QIY5GBAmswUQ1dNxQSdV/Ho5
 JCgKo8hdnlq/yapdAO6002wZvO0Abwo7IiMCLmMTVRmljxUItbxDB6tLZALA/l4OMk8z
 OKKmfFW0K1FLQpsLK4td5iP7SGTZaCDNGU/o3PIkqH4aKHeDt4YM6M2xBiRYXn0/1+o0
 ABqBbtW2zgAic6PqsDq2OuKM9cZDfyKBWrfY4/uJ+YY8bJq4u4od+zFqdl8TAZH6qLjX
 nRbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwb4xCirOqBShibFmEbOpr2OdRI8W36t4Xg26JjzrSUlIAxP3TR3ows3s8AspOHzNtxEQ57uu9EZnS+gG+E@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/or/954+OhbMTZ2uU2c3B6P8MiFEuqaA0iJEoleahG0FlvshiD
 Flf8XA7WOeIBngvVLCpy87URuR70yv/tq10fsp0zrz+ahZm8k0HPhjU0DUzWELIPgiVZzRVHR6V
 g2Ff5pcTqdIATfqV5jxo43FgE5lGlGNfzgLMejR7tQLDD6GOahd+MJ8/HxXIID/D5V2CO
X-Gm-Gg: AYBFou3YEWBwRmfkecNS1j1puVGYBAtZO4K24zBOHrkOQg9ktxC4C+fUtwh0fWKBu/V
 cmOA4BfIFvVQretVNVNZsY/Bb1ckFkctR67/OZQ8rMDrrukOHZsKAZ3R/yAI5lUVMQQXsW5qR1N
 aJvynivBUI8kfxyWGiwByOSzp02lXUWAX4V/CwDaOH/BsTjogT8xXTGssCEjCN2u/oC0VjHaWu+
 6f6CxcCKq2IDx5XzUhhBbiAp8ShzHO3e0eKsPf5WxKqmMWXd7lfG0q0Fm68Le8i1fMLqMrmyXXT
 Y+eV5Od2bDjEY2Vb9TbbHPexjJuVEXFqNzKD41d7ZSQ8so3FUEVcCxja1Y0spQmUMmTwUQ2nbhS
 TcbiOa4vXuGmCHsvO8MOmek87U8w6sjlRDURMDloZ4D3Ee1ptTbtfojMOBGpKLs1a1Pt7f3oKQe
 vOIbtewvA2gdUd6KkW+jDzLM30cxflJpYI/Rk+0a8TpcccVmXjYmLJdkcLrwDdLQon45Egvv1nQ
 frSbGI2p+Wp3Ug92xcS4dmE5lmesdHeC8PI2M7guvg+fnOT2OByVG0zSClfSOf760vG1XTHTNs0
 +DZ8Kw/byRrTyeh8B3ZOZe7Fj8ncj85vBrHTkGF8ad9a2Abrgi1NI4dnNE31yzYPTjj0rvg0mPI
 szRX1xnUA8+BnTOtBTh97BEk0Vyj9kw36yaLpM+mdmaKfHcsZmheyuhfHifOIv5OcYltOshHhaL
 /nkZ10+djBKHpDK0z7GtA+wNhWX2xSnBtmN8o=
X-Received: by 2002:a05:600c:8b61:b0:4a2:1398:dd05 with SMTP id
 5b1f17b1804b1-4ac17752ee4mr299593515e9.16.1793731447484; 
 Tue, 03 Nov 2026 10:44:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b414b170e7sm1652055e9.3.2026.11.03.10.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:44:07 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 18:44:06 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9eb4b74b53d680c160b8ac65ab844f6404431e62
X-Gerrit-Change-Number: 2109
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2109?usp=email>
X-Gerrit-Commit: f1d9c1a1758693bb5046219f356d753f5d094b94
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 18:44:06 +0000
In-Reply-To: <gerrit.1793731291000.I9eb4b74b53d680c160b8ac65ab844f6404431e62@gerrit.openvpn.net>
References: <gerrit.1793731291000.I9eb4b74b53d680c160b8ac65ab844f6404431e62@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzMxMjkxMDAwLkk5ZWI0Yjc0YjUzZDY4MGMxNjBiOGFjNjVhYjg0NGY2NDA0NDMxZTYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dd43225670eace545c5a21a5b9f3833832eba3d4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOJUU-000000005BJ-0PlW
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
Content-Type: multipart/mixed; boundary="===============8847023729309351921=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8847023729309351921==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="foN2MmRVWwo="; charset=UTF-8

--foN2MmRVWwo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2109?usp=3Demail )

Change=
 subject: openvpnserv: check DhcpNameServer lookup in GetItfDnsServersV4()
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2109?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9e=
b4b74b53d680c160b8ac65ab844f6404431e62
Gerrit-Change-Number: 2109
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Comment-Date: Tue, 03 Nov 2026 18:44:06 +0000
Gerrit-HasComments: No
=
Gerrit-Has-Labels: Yes

--foN2MmRVWwo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2109?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2109?usp=
=3Demail">change 2109</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2109?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I9eb4b74b53d680c160b8ac65ab844f6404431e62 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2109 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 18:44:06 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--foN2MmRVWwo=--


--===============8847023729309351921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8847023729309351921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8847023729309351921==--

