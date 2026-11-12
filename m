Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4449606CFCF
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VvYclQDj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LFWrQnNu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CMnQSbFk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=beDBlEVc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8aCty2cIxqw2AyB1S/7NHo4Whn5bqmPpDT/4y9vr9ww=; b=VvYclQDj/KoYLxj+7L6zmK0v+p
	GWA9yG+E/enkyOStmiqJXONlCMzxy3kkK+GVScp4Fk8It1ccMDIV/ENc4NX0fD80Bir4W2TFrCIEt
	grqdNUPSICLKAQP91i/GiloALVd27uq7KWQjVXB6/mEQobZnsMCKqy88xAkt08AfgG1w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYnj-0000000045U-0TWh;
	Thu, 12 Nov 2026 17:41:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYni-0000000045O-1FCs
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:41:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ck3DMmFNd22PXcNTSWRkthF9+tEzpODRsyi9arrCPXQ=; b=LFWrQnNucdhHxq+7k0fTxb1tje
 gCJ4jwxkwt3KXHQrg8d3mycQ0Enh9V9T+LT7eqIaeLJhfn9B2BpgdJ53tl9C7S4Yk0hcMEJEpwSVW
 X4hg1yVj4EVhlNfrEeYdKuPlbG1XivQ9EbwCWbGqBtP3huGC5b6ZgqVI8lKVcmU+KI5o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ck3DMmFNd22PXcNTSWRkthF9+tEzpODRsyi9arrCPXQ=; b=CMnQSbFkAEVZopvUREAt6O4gRQ
 NBSSmtiI7v/fui9Mw+U+ns/5EvLNZOKWek2FIL5WcE/1OYWLW9S075yJdRgDZaGR4j5eRALL6Mamh
 FBgQSap296GNHyH/G54LMebBvbBKZu5cnGbTTOqjl8kv9bwGz6h1u2bJo5bCaagP/DnQ=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYng-000000003mG-2sJw for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:41:30 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so897235e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794505282; x=1795110082; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ck3DMmFNd22PXcNTSWRkthF9+tEzpODRsyi9arrCPXQ=;
 b=beDBlEVcYlmqygwoP7KrTptuntwfHp2TR49KJgKWZIS7T+aQ15e8i7rdcTm7CePZSB
 62tmoOFodfnZkXayOFEwnbc2U64RJDYA7IaVI8IaSoVpOlVjN4j4zW9mg8UhBOIe6925
 AlEoKQibKBfjBjl3hcfoWXWpvkJL9UHLbmkd7P4Xc80rIuzRgKpvO5SrdJJAThioYOAN
 8XEJcEVRZ4oLD2B1oqTzNW9oW1SwWNjzL53+YYDfm3q9tiWXsGQeviLMAKdVHhW4S435
 eSA1OZZNgd2pczv9j6Fq3EN6MeSl8m9wq0zLi1CBK2eH00/jjYO5CLl1HyRbfEN/2hSk
 rApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505282; x=1795110082;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ck3DMmFNd22PXcNTSWRkthF9+tEzpODRsyi9arrCPXQ=;
 b=W6INQfdoFiiDOmrjw8IM+PhlVyhVOdrgF1s4M3agSqHXZQW1DbMSrX0/UiIpqRowh5
 /SjDUmVvoHYtoMSABpwJCHeIBGPI6GAgF1e0vupYetW/Q2so0zNplbCuwKWOWzBLwzWq
 saIzIKz3h2c6pq7UE3nM5IjUHYqj5oaJJSqYIrDeyld+UKYr+zLC0wxzbsJtwFW4m07j
 vXyCSTlqWpYf3MEWJ5h2NUJL82y9/NihQO8eYrodHyEUUw1dTElyv1FTetxiV+gH1ukL
 tWiVR7+MR8RhQGgUrstih7tSAvQ+5Npr2mgBmrtZPs0Pr4kRFKtgZ6FKtMHs2eukMZ+p
 jCiA==
X-Forwarded-Encrypted: i=1;
 AL+hErGbdTz1fOmxHXIdngjX9tH2NHKq+OW9Ogpp4jboK+VQDtUVgR/zaZKRfHoLTUCa+4OC72Oq0yVHO6rn26k4@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9otWvufg1i3Io8DiPW95LYUj3NI0DjFjHHA67VgX5/2GyU1YWN
 zAJfE6Xd5JKHJIrMo8wflhrT279uKmvldU3R9SONVJy7791PpWolFOggvpjssixdO5pD5m7Zv+m
 TOzz9CruWiBQZU0qqYaIeyzhDQtnIlISh5ljF9Ltyu8KfYNOKwRzNsAINC1hTCSVuX2BjA7KV2n
 V+WhtsTA==
X-Gm-Gg: AYBFou1uozhhqQa7z5gRHFoCBP5D6gGQDV7onqMvF5nBOyZToS9hKuotGJjAoRKeQMV
 3i+PjxH8Q62RhkJVkqBq4kl/MozD9U5V5mfSs8dLJuKLCocbfW3cmGTodbOHz4jMaksi+NSkU/2
 VGO8w/vZcKEgW2eXhMrxCGxeN8bhvuk3syTdClHM0hoFYGUeKSugkd/rH71f8BgZDOnMXgUOH0n
 J4Igd1+BpOFhgHUkOAjmt0D31BFSrTDf3jwz8+GotZUFywiB36OsEkI9OYq/y8uJse1dj031krJ
 Y9zH/wrISVYBMmiZwQSzfTplRxW0jLs1oULG6BBv4m4xVEkOZmSr2BmOXBgpLwWhkfC8/6I6GK1
 2hjMG7sNKYmlWKb7GfKhdfBzWaG1573vA3IS2sOcCSmNuYBHTlLzzMEE+RmDsKwGebUWcAiKNOO
 aiy7la2vIAHPrEm3BaI8CwtdyAWLWZzp9sM+oNMS+0VNxGuuGGD03vkuXncyBm5ifUAdHtL/KUf
 bcnQbCEKPCbZCntHb/N3S7rsmm+k7xoVm6oQUtRiatesTYe/bdf1WsMbIKFZJ0wCq4hZwDtrz1l
 aow3krUAsYJVfLWIO4GF2rnXyEK06EdHqJ4NZjEgtSH6c/VcbYzixE/fC8SDaTmmWZcL1lA6KDJ
 XqlmgpaScw/cAiazD8UnW4OfAvoVo/umhIWFz2AJYwY7sDygdTAE1I3FDl+qazEBOQeK7c/1fKy
 pHf1B+EELyfoClMiE=
X-Received: by 2002:a05:600c:6218:b0:4a2:1a:a116 with SMTP id
 5b1f17b1804b1-4ba091a73f1mr122085635e9.0.1794505281875; 
 Thu, 12 Nov 2026 09:41:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e26700fsm94758055e9.10.2026.11.12.09.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:41:21 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:41:17 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb
X-Gerrit-Change-Number: 1186
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1186?usp=email>
X-Gerrit-Commit: 08b1138c60a189639ecbb7b4700c5e60c4ce2e2f
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 17:41:17 +0000
In-Reply-To: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
References: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU3OTM3OTA1MDAwLkllY2Y1MDJlYzgxMWU5OWM1NjY0N2IyZDQ1Mjk4ZmEwZmI2Njk2MGZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d7913ea1da7b67118f872b0363f6e6748cccba6b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYng-000000003mG-2sJw
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Enable
 -Wsign-conversion
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2756390670642522841=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2756390670642522841==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pF2o9RiFh3A="; charset=UTF-8

--pF2o9RiFh3A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demail )

Change=
 subject: Enable -Wsign-conversion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 20: Code-Review+2


-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb=

Gerrit-Change-Number: 1186
Gerrit-PatchSet: 20
Gerrit-Owner: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 12 Nov 2=
026 17:41:17 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--pF2o9RiFh3A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 20:<span style=3D"border-radius: 3px; display: inline-block; mar=
gin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span><=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demai=
l">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?us=
p=3Demail">change 1186</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1186?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1186 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Thu, 12 Nov 2026 17:41:17 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--pF2o9RiFh3A=--


--===============2756390670642522841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2756390670642522841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2756390670642522841==--

