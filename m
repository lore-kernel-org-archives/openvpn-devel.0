Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF2606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OqclPzmY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IgKHhZLk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ee6AkK5e;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K48yCm61
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ujPjHeyXkzmIezUE5CA/e1fMEDLg0UVj4cbCCDC47Vs=; b=OqclPzmYHLUSSBQ+VI8l/A/cQx
	FmJQC8mrlrsw/ifRvutwWoYUyE6l0Od+yV+QtMh4tJrEhri/5/lbDlfVmjZwBPNdvTu8ZNHsB9I22
	htXN3vyZTr/HAVGbmhNASyVRtithpyh4SjaXkHXHTn7jop6KhyM7Oxu0G3W3lmi3RnOc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVTaw-000000002Qp-20nr;
	Mon, 23 Nov 2026 12:56:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVTau-000000002Pe-2a2t
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 12:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KC6eZhhvvZZtT0632kNdmYfmW9Ww/uhWhkQHGrWJLtw=; b=IgKHhZLkfDDIzX5nkukgbWMA0G
 WK0gWB84BfksNaFgS4eeELlcXd9nukCK1t8eQbV9hYVnA70D+e+X+kk3ZSlK8wohNensN+OQYrpA2
 1xMg7plsmVsnFe+/xwuGa3jl+bVquINqHwUxfgrb8e7XgTzkc2F9ehMWaz9Fzuq0jt2w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KC6eZhhvvZZtT0632kNdmYfmW9Ww/uhWhkQHGrWJLtw=; b=Ee6AkK5e5WlBYHzq6t2szDMaen
 VgcZQMlUa5Zod1oswiYu3EJM67bd2zO51rzTOQFJtqi6pkyVqp/GTF3b/IpaB1tLzqFOtZ3wPAP/M
 LSsUuh5QITpyQszGuui5YII/2EhkvBt+lsQ62LXamdWvaFxmb5IV+KmBXd1JMSmSOlmo=;
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVTad-000000001xw-3j8B for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 12:56:13 +0000
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c506a231b88so449553666b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 04:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795438565; x=1796043365; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KC6eZhhvvZZtT0632kNdmYfmW9Ww/uhWhkQHGrWJLtw=;
 b=K48yCm61ytb5nNN3WtJ0Vr2aFAoTfX8D2H97W70kKX8HVCY7P7ncAOIakHXu5z/Jjy
 uA7GgXIP4b1RLkAdeVti44ZXrjN5/2RuE4Vh4UGiW4vPOaHGBiYNrH/WXiGuM96unA8g
 GMrYwgznN86sglUonIg1W5gfiwD5Y4OEKN060dytxJGxIhWzRxDSTo2JYHg7W+DRBJP8
 hfaE7mBVCem86gwDh+vpZYY+8ihgnXlJhBCBWp1nvdKnczQvk2/YK7rJ3/tFOBGVbuWo
 sTeFa4LfMH9wsLLKY2r36X/BgDWlCCjuL5fPp71mU7FSMqKhPXZyotuxtdzPgvkIMP64
 iiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795438565; x=1796043365;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KC6eZhhvvZZtT0632kNdmYfmW9Ww/uhWhkQHGrWJLtw=;
 b=Gs1L+KLKs4Ro+18Y1TBrGiV813cXzOfjYHlzOS88GEBZsqtw5AXg9YPhWb8AVlJGGN
 cAgXN4365WwYozeCdG83Ap+Nd+ZPHulCrPGDmRCoZdqP+BcQIJvpoMvp2ZdvNfJj1NNH
 d9dfCWRry6otKUG+1RNHcIGcVh04bRliecYiRuBUmcuFh6Yqv8psV+d/72KrScsCdgqi
 5o+mDow+tmFZOjYODNAO6GK/l8s4TbbvRXSqNaZlLwrg3rE/etgC1Dgc7no4e6KrEG85
 6J1Q6Wn1xsp568HWgoc4Gh6wh4V98uBlsW0AzKwmypurJxUOsqP+jeUpfGZFb8UAkyKQ
 SfPw==
X-Forwarded-Encrypted: i=1;
 AL+hErGBl/d6lUZbOSypr5HV00ke1sITVCAbXP35rEsSLAhI9y77rS6Yn9WzOyb1qyFfBugatip7PjTZMMwBd4tG@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/iPqMcR8RX5vtm/LIioUQsMY0nHDlXXS7ycsUOx9Uwwiu/huMv
 cKS8aPlxruzDbHOUziSpjpMyqbhwoPcq4uq9FCdQLKzK4VUy4eWdgUg1LY4wLu/TQFRvFHAgTEG
 CBaVXJFKsfjpUel5dD3Y9ZWCLRLROHcML22LuNso8kH3qTw4NSGoDyAF0zbucp3lPdqDBJ1nkET
 EfgE3PfA==
X-Gm-Gg: AZFdTZdecLd3WYTskz4QVI7p0omMtNNH4vMJyIeCLc21ddk7ruje/a7PMAhkwK210ix
 Ut3hD7Lltzyt9WKEL2d9Oh4dMWeFeKXYjUlL1NKhjD371NSr5KjCYUdmeE962ESUUoG31zc5ZZW
 XXuVP7tPGDGcW/9ykF4gW65RPhx3t4dOB+vnsN3Jt1v2t7qASkOlKL4fSe6IDWFyxTFPduTmrsL
 ThQQdPcnVlH7ZFShyvnWIMX2MGgjXq1l2tXpVxfvFW6weJEeleaBMBjFLNbrFldZvS3/aO/ZV8m
 x55GeqE8a9FqcZGwVUccc3OPnTkYmIXbtqD+45R5gYjo/V3q/w9Am8WKkQSin3YYeROOQ32YYa4
 rh+VdiLWKR7uuwkpe56Ult6+VnbIlpW59VKH1Zr6+c4zXWTDNeDXuTTSShz9RVnl/4LWztr+DTW
 Kay44rCjmIdqk1LaWkffLoFY1RHBtVDmKgNaAS2LWRNBUM+iSI+8Uec+7+PiDa1oqfcnOfmtY9a
 +5kjFzg7PyLiSyQNfdzKpUFfiU500FM3ppoi8DlBJbbf5x3kG6EaCdZTwsQobqvJ+cq4knzjcWo
 tCoTWz7D7t/cS3VexA3qqI5aB9gPhSC+2BLzvdUf8yGMa55FmlJWLPQdJqeQBIaMsxmFZ4fZoXz
 8GDlwNT3IVcHbhhbXgVnd4m1QPC4SHLbiGu4XyLxlGC3CkiLHQ+tDoAUfgLofz1QOenNyerOZAi
 QPrru0VrPVokJOhJn9eGNbeCTJd4Fv1qHe2dtV
X-Received: by 2002:a17:906:b293:b0:c38:ee33:2931 with SMTP id
 a640c23a62f3a-c513aaac345mr707975966b.37.1795438564908; 
 Mon, 23 Nov 2026 04:56:04 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b001172sm406371266b.79.2026.11.23.04.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:56:04 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 12:56:03 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
X-Gerrit-Change-Number: 2237
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2237?usp=email>
X-Gerrit-Commit: 860f760f1962644034e176ca1f0fc743c89a2a0b
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 12:56:03 +0000
In-Reply-To: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
References: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjUwNTk0MDAwLkk0OGQzMTVhMzhhNjUzYWVkNGIzM2QzMjc3NDMzY2I4YTY1OTY5NDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d0c01d3525e7f8e5f44db0743ef0886a2276abb0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVTad-000000001xw-3j8B
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: free
 ext_cert_input in man_connection_close()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4402357042565889414=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4402357042565889414==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ajrqWh3b+y0="; charset=UTF-8

--ajrqWh3b+y0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Demail )

Cha=
nge subject: manage: free ext_cert_input in man_connection_close()
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review+2

(1 comment)

File src/openvpn/manage=2Ec:

https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2237/comment/e3727982_978bc2b0?usp=3Demail :
PS1, Line=
 2863:     in_extra_reset(&man->connection, IER_RESET);
Can we change this =
to "mc" so the code is consistent?



-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2237?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
Gerrit-Change-N=
umber: 2237
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 23 Nov 2026 12:56:03 +0=
000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--ajrqWh3b+y0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237/comment/e3727982_978bc2b0?usp=3Dem=
ail">Patch Set #1, Line 2863:</a> <code style=3D"font-family:monospace,mono=
space">    in_extra_reset(&amp;man-&gt;connection, IER_RESET);</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">C=
an we change this to &quot;mc&quot; so the code is consistent?</p></li></ul=
></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2237?usp=3Demail">change 2237</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2237?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a65969=
42d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2237 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 23 Nov 2026 12:56:03=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ajrqWh3b+y0=--


--===============4402357042565889414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4402357042565889414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4402357042565889414==--

