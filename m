Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCE606A327
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ji5NVs8u;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Yqb5Fbdv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O3FoZP1B;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XmVo4/Vf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=utylLNy4pweoO+M0Brigd+y+XyRFy8HX7GKCkuBungw=; b=ji5NVs8umVk4crqr/HIeO9u9Yk
	4IFNWcbM14B7PeQGZFB6Y95rIKgZlivAgJS05tYtTJJbfR76CHEIK0ex8E1m1J6OdvdowIKi1MTiA
	dqBNYgXYNjFoi2g2hxWfkzNRn03WyFG60UGYTRn0srRLS9TnUTUzWIB0lyosOjCWiAw0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYLf-000000002YJ-0Hws;
	Thu, 12 Nov 2026 17:12:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYLd-000000002Y5-3XqA
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:12:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X7KcWFVgcKJXoHWN9D5JoHm3Z0/ACto54ZaNcPv60qI=; b=Yqb5FbdvCvBNpOqyJGLZRqZgif
 Z8Vub6M4tAI5eDsNXI3C2nE9VHUQhmL8UGeuU3eeXTdpCL43EC5FwyM+bMBuCh4meZFu7mj0TrG4V
 u+OS6ug8RCxEBAYJJvPKx5pXlym8NtSvLAga8gmcBlZZ87+Y5F+GiKqzR8DGCZG5Z/vM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X7KcWFVgcKJXoHWN9D5JoHm3Z0/ACto54ZaNcPv60qI=; b=O3FoZP1BdQ272EnheMqvV/GEQe
 dqlvpuH1bYzkKObVe0tb27urKhNuRDU5vU0kjb7BBIXIOFACTvvdFjHTJ96GzhjBieNv5YQs4Ua1b
 GUQqUKw/2SWp1+U8WSWyGQs2qEN4AqO3LbY2b2bOz9nELoVq++rrK7J/9/rLS0hI1Jl4=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYLa-0000000076R-3mdY for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:12:29 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso124305e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794503540; x=1795108340; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X7KcWFVgcKJXoHWN9D5JoHm3Z0/ACto54ZaNcPv60qI=;
 b=XmVo4/VfQ6gsWsGs+Dxu4tNSIsqKJxSowi2ilAeRnOTpCtXLhiKcnKmeQp/rPwNhdE
 YdIoq0hYV26/8naWLVpKMcs76zE36O/MeQSGwur1rSKmSDxswayTDGFH776W9auirgWM
 rcnEq/Pe8zfwWRwRKq4XVMS46r6tAXf9JQk6S4rl7IFCAQ3TKubJHtSTKwdvDmXth24f
 4YxXy2MM+ycdzrF8c+At7kVkrF+7HoS9/yFO8FhPZ2A9yRSLC0/0JuHVJhgpDQqgH+Qd
 j/m8qHitGqUiCVFaV+5NuR85e8EqNC3jRgZPiZkFQQkRJJIFkPRVQPrYdIW8UNtLPc+Z
 6sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794503540; x=1795108340;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X7KcWFVgcKJXoHWN9D5JoHm3Z0/ACto54ZaNcPv60qI=;
 b=o6EvjdDKfly25elQwFBP8F3mjBrt4ZWL2OWnqn8b6TcqAq5EjMyeqj6TcMbTa9Tsf0
 Axg0g5AsVRTQWNDL853BHGYETygheWCl/LJ9Oe7ybPh2xsrPZm2NsiO1Qb2YCzngashG
 wZEgspPFPo6R6wAG1xJ+OpOg7EPjEY4Q1lx/58XBhmO/H+ouJprjsZQ7X0qhIXVy7a5S
 dXTeHqRQQZNK803sUcTNchBypN8qfswdL/vW2wnWqTGfDVqYqCTcjpIRjtoIHANCwIaT
 JOql4Pr5RQdE3d/LTbiRH0F3AsjieYZRFIviOoFN/OutrSAO7NhCcWlH8t4z9NdvfVRd
 tl1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErH7n1SFUhObJ7SOIeKe9kW7ulOIWzmYt1pbJn5NuKvzQUIPRsrBHkNaNnQOA1ZoO3+Dwes9xWbgtoX81mMW@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9XftpQ9OZaZaypaKjw3B9w9syZp79fezaG0xxZppxamxRtOmNV
 GxcJo9owZxaOVc8hWGHx3fiKM3CY2ILgJ5UDeFHE6FfXiQDRUo60TOLtk3oWYTVILBy93b2g7K+
 AXJWqrNSolStOxIN4Z3XPWApfXwtNefUzCLh0suvwQsn8/0K+Yo7nQG0czw4DhW1Gfa1qvv8DYC
 yAgd8Niw==
X-Gm-Gg: AYBFou3X6CagFZy/y5I3qjVqVdR+M0puNhdB9OrZdAVdZGUrw15S2rDCh/SkyISzzmv
 KH5y+4V9PSxUNDQnJpc+JmzdlWhgIAjfx56xH7Ydd+dfXNcTjpseSMzlo80rQUS8gJO1GericyV
 R/k5H9DymJtIAMPEUyRHWVkneBe2B57tqJkSif0zWomglCJpgtGOAaJ0s76gyL73+P3neLHyjF1
 PsnHdt+1OcfM3C08oy7ipjXP6uD0FSIvLBpUcvYc1qtL8DXsozIOGZPPANHTyYPb5FDQPyXzv7Y
 c525wioZB1k5Aku+VnPQUQAZ+Ec+ZNJGym8R9gWo1yBTFWNai+0ebRKREQryJ3Fnd17rDl+29EQ
 9aiy3gmvFWGtJa92pqGDSrWISx+30aX/GSyGHDyAZ0rKmiD/x1MVj1KPw1hTfsUnhrKi5AZobcx
 dKhD62Ffw3+ULIAIwPyDdzfNIUAqFQllkJTNLASyY+ZwBX8spW5NN74QQ0F0bAWFfNXXDP18y6G
 qnrl2nwRVmRGmGryzF9j4HdrCYq6BUfoZMjT83KCGWuGmqZPPyuRkJUauVwGS3xnFXaLx4MK/v1
 W8Y14ZF0Tv0ud+8sBbPma+MmV6dXeCuQzWNWXeirzv5l3Ap5ItxV/dqHusYOOtWtB7DGzjNwp8W
 /nwQbjeduMho/hn8Hz9nx/Vn4ZfXJBxYrCRoSLbkWiq/L6BFChn5TRLhYMrtzWESB6rnHbq36TS
 wL7FXRRTGLEKcB6qZw
X-Received: by 2002:a05:600c:4e41:b0:4a7:6425:c274 with SMTP id
 5b1f17b1804b1-4ba0931ed76mr118434505e9.2.1794503540133; 
 Thu, 12 Nov 2026 09:12:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f5972a7sm302430f8f.21.2026.11.12.09.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:12:19 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:12:18 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: 94d1c3ad8e783a6f7831b2d676f80a276bfc45b3
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 17:12:18 +0000
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <67d89764c68c0dd975fdcd1e7e7075fa5771116f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xRYLa-0000000076R-3mdY
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 Reduce boilerplate code for parameter checks
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
Content-Type: multipart/mixed; boundary="===============2129482232876597742=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2129482232876597742==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D/I4A19rzxc="; charset=UTF-8

--D/I4A19rzxc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail )

Change=
 subject: networking_sitnl: Reduce boilerplate code for parameter checks
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:=


(1 comment)

File src/openvpn/networking_sitnl=2Ec:

https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2177/comment/45efe0ca_bdda7b8a?usp=3Demail :
PS1, Li=
ne 720: }
> This function duplicates a lot of `get_ifindex()`, and looking =
at callers we might even get away wit [=E2=80=A6]
Done



-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab4=
9118
Gerrit-Change-Number: 2177
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attentio=
n: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 12 N=
ov 2026 17:12:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Commen=
t-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--D/I4A19rzxc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_sitn=
l=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177/comment/45efe0ca_bdda7b8a?usp=3De=
mail">Patch Set #1, Line 720:</a> <code style=3D"font-family:monospace,mono=
space">}</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">This function duplicates a lot of `get_ifind=
ex()`, and looking at callers we might even get away wit [=E2=80=A6]</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail">change 2177</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6f5ca53d4288=
b0921610f7a3f84ad55d2ab49118 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2177 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Thu, 12 Nov 2026 17:12:18 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--D/I4A19rzxc=--


--===============2129482232876597742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2129482232876597742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2129482232876597742==--

