Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A4F606A334
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aMB3h4TV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z6cCa5jX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e5DWU485;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dnvPC78S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uQABnk1jHqCX4KHYXwiv+L4JAx9W0acBRVak6kSCTa0=; b=aMB3h4TVTG1WqI0Kkjr5n4FGFx
	fakaiU4a0j1cQK6vuZoWiLORYdCcBxDq7hZ2FS4y1sPlzVKS/j31f+k0OhM/4L2nf227tkVvBr005
	5lrAOeVC8rEFJooHyeZwcHFs8l20O4Ma29kKXB8VDq6V/7Grru0YpVrCNts/wDufB7q4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUW95-000000007i3-0AkJ;
	Fri, 20 Nov 2026 21:27:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUW8i-000000007hl-3E2i
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 21:27:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8H52i4AI02j0Oom8SNaOTZQcgv16nKOhpWn5zsZJ/lA=; b=Z6cCa5jXi9lwWaX1zEKJat18G/
 2GyYv3WiqALC6PH5UwGgHvVcvbhFmG4NVbbvGD8Gfsb0r+5OmWjGHHzST7YqTudzO62caTuHmg/p2
 tdlZvybNBHkTzuw+NR0wIzQuOQ6diGKrFVs6iok1qpVy13YQk1BnGFzZK40ISgjXuKzk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8H52i4AI02j0Oom8SNaOTZQcgv16nKOhpWn5zsZJ/lA=; b=e5DWU4856g73FAKBYJQfZFYnHB
 sWdoJPYHv+AedWUDGVgPYdPlT6kXPNo2Z7ET17y9ufGAcIv1tYaaKc8ykfHLCLp0iMN3yaScyeP0z
 KydmlWkTRKRLzu2SrdRntZa6lEX7KsvsSy0VTPhXDInIs3BWNP4r0rfZIhFSXsnrLd/w=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUW8h-000000002LV-1UtO for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 21:27:24 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1307861f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 13:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795210037; x=1795814837; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8H52i4AI02j0Oom8SNaOTZQcgv16nKOhpWn5zsZJ/lA=;
 b=dnvPC78S/oGKVVo2uga/JZEuTMEMBGiFX42h6GpEYKNQLe5gAl8UPeoGozLLkQ2iLt
 7r9p+N/I66SlTmTjysSuL+JfSl6ZFadkmWuTSAHSnOpbfLEh9iIoN9FrEOAe7P/Ml2SD
 2652MfOcKBU6khdyg3VdL/0+owRdNbMvsHTJhYgetEr9mCC3l767sG9EzsiWrsewlKYv
 0zwyArtY7pGtDxd99Q7WS9Cwcc0n16mpO44AEODNab2upRp6HLDQdrtew2BLSyHjAwkp
 pY8W7Z+tacBwzuGRfysnjqGsgtnU9qp2LZaSGySoydcRKxOD2oAQQlmtKZ0yL3JIVNIg
 fU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795210037; x=1795814837;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8H52i4AI02j0Oom8SNaOTZQcgv16nKOhpWn5zsZJ/lA=;
 b=SxqNrp6mvhxPC7cOgTXn3RnUv6Uhxz24B+0659RS+tumKy1/CJGERLeFbM8uW0ZIHA
 KatZLSVMrdiawD7aFri4JTkl7Pe4e8le+9lfncxM+8UW+kO2u6x7k0TS8ySvCD70TVsL
 lM1cjeZRWKkQN9sZ6KeXd+Jp5hN2a1CcGgQ0zvnJa9Ii5Vc4Nd+IDI/hwJKN5QLfWQnq
 si+OT/ZQ7PJeeUVxIfwi0gyO9MbHYBD05Q+pMtENKP7Ko8JMfxZ+1Mff6WG5LjRmLnLJ
 hZxKZOv9TDGhovUSB2iHWiFJXi0zk5RLdDConjaokEvceBnislD2gbcPDyYt/F5weZ68
 yb0Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGmuYAbrWZWMoVuFYiyzqNuR1KzsD4ZfWZ1Oal8ol/Z6en/lMn1XiVb1Jl8sOcr+JDlRcxQI3RULDgsFFb0@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/7q+FZW65dgIGkBWh63voNZuo/yBrpXEdUE7O+OuRrJ+B7yzRo
 uAq/G8sP/tXRt3EvllJp9I97qbAc4Ah0Cd3hXswJCjJatWdTsRTarGOlWQTIg7quMg1asONGc/b
 38wM5EW7iIPcKXI2gRFGqdZ1Paw6h9disZCKlwMxSQor3ER9LpsqZ43k2emESyTenU7G0btUUz8
 +Gp//RHg==
X-Gm-Gg: AZFdTZeVV7sWmc16JGDX8675u1sv+xJV7pmHJNoe5eBydZK7Abop5TjuzeFCsrNvVaW
 8cq9faHAV9MBqt4qsBJ6ErX4WmiGmAcT/HmIHtH7VbemjU9+Lr1YajzkNPLuh6coF5KITDiCqAC
 NHmzGwKbFsHGZBn3JsVWBBdKETA9XKoZEgAxkCDo5OJXERBOkwr2T+pguwEIs1lMQtcCEg3F79Y
 IJ0DUBSyDf0ioDcz5S301yVdNoLZBBthXi++kemDZBiUzU4eWveJSPkinbcdK/j7gS/AQs1O9hL
 mKoQH4LA9qZmugoum+sKKP6fH2sHCJGMZwoVofpLh8HKgyGqwgYVJvJd73G+3sa+L5Ch3HhPG5E
 2fXiEgGkjXS68uQkjTWtwa+oN6H3Ca9JY50ERwCDI4mQPJnL/x0tIbPMZ7mxzk3NqS6RrOgEeJA
 SO/vxc/w2E0Z5RQuLq38xDc0IyxpjLmUgXmWiWzynFzbQkelVZaTHVvOgWlbR1lLzsYluVS1PMD
 oazfzVHzjKf8jSt2lQ4Hd20IYYmCkd+mRmG02NUs6+uBKq9TlPe7a67l4q84tObc3pdw7RLxtCP
 g9yxmibA4Xsyny2pGppO0/SP14vytolYDRgletC6hkVBx6OxSioiNs3m+dMPKg94fBj0LPkzlyh
 7p4vnCjqSQUbi1/puoHD8dlxVZ3fDoRrUk2B2DwjEQ0mWTmfqGmN7VAMTxtpFojLvG1IvCY7e2T
 4sMURhuljN7opuP6R9U40C/vPPopycdD4+MJF/gA==
X-Received: by 2002:a5d:498e:0:b0:492:3982:a80c with SMTP id
 ffacd0b85a97d-4abb70d7094mr7002252f8f.29.1795210036659; 
 Fri, 20 Nov 2026 13:27:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f204sm8926128f8f.21.2026.11.20.13.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:27:16 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 21:27:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id346f35f6ce371b177af7454cd73d3eeccb8ed6c
X-Gerrit-Change-Number: 2235
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2235?usp=email>
X-Gerrit-Commit: a7e49fa31c61faca1f46551d6b35da4f85ff61e3
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 21:27:15 +0000
In-Reply-To: <gerrit.1795207472000.Id346f35f6ce371b177af7454cd73d3eeccb8ed6c@gerrit.openvpn.net>
References: <gerrit.1795207472000.Id346f35f6ce371b177af7454cd73d3eeccb8ed6c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3NDcyMDAwLklkMzQ2ZjM1ZjZjZTM3MWIxNzdhZjc0NTRjZDczZDNlZWNjYjhlZDZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6440b6c9c8187142c99b54762254eac0ead3b772-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xUW8h-000000002LV-1UtO
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 NRPT exclude data if one address family fails
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0361317722129683337=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0361317722129683337==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uRkQm4ArL/E="; charset=UTF-8

--uRkQm4ArL/E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2235?usp=3Demail )

Change subject: open=
vpnserv: keep NRPT exclude data if one address family fails
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2235?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id346f35f6ce371b17=
7af7454cd73d3eeccb8ed6c
Gerrit-Change-Number: 2235
Gerrit-PatchSet: 1
Gerri=
t-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
G=
errit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-D=
ate: Fri, 20 Nov 2026 21:27:15 +0000
Gerrit-HasComments: No
Gerrit-Has-Labe=
ls: Yes

--uRkQm4ArL/E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 1:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2235?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2235?usp=3Demail">ch=
ange 2235</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2235=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Id346f35f6ce371b177af7454cd73d3eeccb8ed6c </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2235 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hu=
nd &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Fri, 20 Nov 2026 21:27:15 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--uRkQm4ArL/E=--


--===============0361317722129683337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0361317722129683337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0361317722129683337==--

