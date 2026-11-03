Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABDB606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hH2mL7x8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=goC8l9LZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=j2Xt8bb8;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YAE70xKe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LAvIzBd2Q6mSAzp1ZUhOXD2CONy5mqSWjzw+3V/Z7rg=; b=hH2mL7x87/6U1ESkh7sG6QcG0v
	0PnnLSAqbYWQLsvLRr+4SaHvgjHieDU+LpZ43QQWOIgbOqQOu6HdYAYyvHQYvv9BxOExDLvrGNJKA
	G0eJpYtN78qIHHHCSYRb9//ls7ryioauN1km1ZmH3uYkxBU3XG0dK+CdO6pywNe3h4GU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOEb9-000000004li-3sMW;
	Tue, 03 Nov 2026 13:30:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOEb8-000000004lb-1iGS
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GLHiUgGTusW+eihtjsqpUimj9MKSJoWN0SQALCtwBVk=; b=goC8l9LZEFQz3hxOu1phijOCCA
 zMGZXbY5A3RKIRsRAuAiu0yFti6klEkI36p3R7wBoEzpRVM1MOOZcGzC5G3pjVHN16wGpUe6TV4rh
 pptlYI01uFV0tvkZMNRfxhlwx9Re0dSzzxcK/E4OL8bVwXLMGP8Sf85yr1VTU/Hw+L9o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GLHiUgGTusW+eihtjsqpUimj9MKSJoWN0SQALCtwBVk=; b=j2Xt8bb8YF8nGkjbV60PmvNOi1
 M3oFtjFZq9d+D07KMfysyRJG/jr09Z5p5yDIOdB4tM9PRN3k92Hqxf4m9J/oujFqUcigt+N27Q9Tk
 BCPweh4xpzrxTGJ8VocI+ojfpKvddXUkApAjS4Eq1QqTNkxmWPnFQHo+CtEh7ZMPCmZE=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOEb6-0000000053G-45P5 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:30:46 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so470340f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 05:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793712638; x=1794317438; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GLHiUgGTusW+eihtjsqpUimj9MKSJoWN0SQALCtwBVk=;
 b=YAE70xKehi+ZJCENBz+5X7Cdc9IzNN6InL8liT9FQk85pQqp5kOoHKWJUApYeWUXCS
 074IRf9ivWE/9w45AxyjFx/81WhqCpQjb41vb+afqUfzFB9D2uunrh07iyVtjXPOthJZ
 m53hePNi7OFapOJ/Ae0PAq67xPkJHXsf+c/dQgb6CBUWbqQHX0UX49GmMOzapgq71DXf
 /eDoHDXlMXgyzqZd/Nd/T064F4bE/DUSRkaq/VQCWwpwkPqTgM0zyEWAxWYELpk5Dh+/
 G6yAXvBCqF9J2Dphs6KsRWOpbBIp2ZjwDMtmFMRYyutDYJ4WTflCGqjYYNPVCIchC6xG
 QFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712638; x=1794317438;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GLHiUgGTusW+eihtjsqpUimj9MKSJoWN0SQALCtwBVk=;
 b=kVRPtwG3RaN2IK3k3bHErD2a4uyWP7BoWUpPWZQe/Fq2hXAGFNQ5Z7FKmrR/F9hMdm
 YwlvUsHaBJk87q1zpFiEFAEvXpgTxMma5vqBQn6EmI2VCKGXfrMkZ/3mzia+PPfCLkpq
 6boEaTBCMkTaCBAOY6uNuqQpgXYgTB683AZpCLlY2NFxexggx2PunHPmbiCumTNBrR5X
 bYi/wgNNbIVSnEZc1Kvf3UR/VDVyYTFHFoGF6FIuVzreOIn0J++2A1YTD3MMBYwlyrFr
 UEagLTVm+hZgyqllSF5DPquFxnFcBDpgA3A/AQUBOtB8MRLWy/nCN0s/99xfM9bHYDpW
 g0Lw==
X-Gm-Message-State: APuU4Z8yHLZFeU7NCw42YYA/Uo6TlqdH0QN+6smgXqp3WhpY8kHnc+lk
 XCo6YKdxpP/4U8RacectYPyQgdpwkyxN1QH1tljpvZbqTJqG27U4wIr47qqDKhlSKpt5QXv8wZ6
 fdy7jZqliRBN9XwUTnGnx6LmUednZ1gqm+99Aa2wUBBihVPMTzPsIANPJI3HKi5KzuUqvybfyIz
 E4I3924g==
X-Gm-Gg: AYBFou0iuvhyUTnT1XRyeVhpiymnDwtq/r2AQaN07xojvjhBORKtaWwnP5bBEwlDm97
 4lfiCsVvwOIo47tQ3Lg4B3nnDjryfl3fkhfFu1DCpXhG/Di6nWhhXnIJp7ivjuFnH7N1crbRYBk
 76pyxu+UIF+DzBa9IG8gwOpmwp0AuObFvu1vztxPenDAIlQhg41WpcLX2Zvh0tNsdYsOQCBGk3X
 tsRKqGb2MnyHeYtIuVJgq2R50vopgKX8HBuTHwy32xZ9ihwn0B5PyQTNaE+Cl49Dysxei9T4SmB
 xb7UIInsGFrclKbW0o3BM2vl1y16ohzLlYFq6rJW7eFzrVd9JA47GUNLIJKAIheoLx3c0CQitjd
 hBSZbg55q3QsGZqlcLRGhvQRwMwFIWNwUEBwBOZI1QNdabCUj6YXvtj8VBVg7/9U6aWSyqcZvOX
 ZuJIdI/XpD224zo3vpp28Iy9F5m9x4B+shPDNVF/HxZK7NR7/GVmTPGZy6BQ6hWTJEsYxu4ZANm
 SycfiU2xSIcff3zC6gcqfJjIdJ6KHFcIxCzaIoyIVMPJShLi5YJCCH+jPelpyfM2ujZiLKfG+rf
 RnWrvdKwdEe8SUsuBTH8Ly0Grj7IqjHoTXwbkiZUylp43jqQtLZ6+UAs2lK/uZPgCLjzDCloIoA
 slNJxAWO0v4c+gqbNnKQHjmJF/WG10cPmyAjejyz8YtCDeGQJgvUo537kAOz7WItAavSipmnxtH
 O5LPrIhYZYxBhcMg==
X-Received: by 2002:a05:6000:2c0d:b0:48e:661e:8766 with SMTP id
 ffacd0b85a97d-48e661e88c5mr39195649f8f.17.1793712637529; 
 Tue, 03 Nov 2026 05:30:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bab1a8sm24778104f8f.57.2026.11.03.05.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:30:37 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 13:30:35 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d
X-Gerrit-Change-Number: 2106
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2106?usp=email>
X-Gerrit-Commit: 6fd0e4b10e28bf743f2e99bbf519ebc8c41e744b
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 13:30:35 +0000
In-Reply-To: <gerrit.1793709839000.Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d@gerrit.openvpn.net>
References: <gerrit.1793709839000.Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkllZTNmZjFmNWYzZWM5MzMxZjYxYjBhN2YxZjNiOWNhNTE1NzU1MzNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aae0dc146e60bd2d8e67e08c201bf9d62ed24b28-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOEb6-0000000053G-45P5
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make parameter
 openvpn_net_ctx_t const where possible
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3398357527363736245=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3398357527363736245==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/6dJIcSVvvM="; charset=UTF-8

--/6dJIcSVvvM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2106?usp=3Demail )

Change subject: Make parameter=
 openvpn_net_ctx_t const where possible
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 comment)

Comm=
it Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106/comment/9ff339=
c2_79cceee4?usp=3Demail :
PS1, Line 9: After move the gc_arena inside the v=
arious iproute2 related
"After moving"?



-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2106?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d
Gerrit-Cha=
nge-Number: 2106
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date=
: Tue, 03 Nov 2026 13:30:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: Yes

--/6dJIcSVvvM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2106/c=
omment/9ff339c2_79cceee4?usp=3Demail">Patch Set #1, Line 9:</a> <code style=
=3D"font-family:monospace,monospace">After move the gc_arena inside the var=
ious iproute2 related</code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">&quot;After moving&quot;?</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2106?usp=3Demail">change 2106</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2106?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2106 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 202=
6 13:30:35 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body=
></html>
--/6dJIcSVvvM=--


--===============3398357527363736245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3398357527363736245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3398357527363736245==--

