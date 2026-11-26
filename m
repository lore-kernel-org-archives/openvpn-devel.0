Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A42B606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AO5M7wZ/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MIicdX+4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aLPzKpLJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OWemO787
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=b90vVU4du/OJvSio7HYDZvp/wTOZEINbUD1MoxmjV6s=; b=AO5M7wZ/r2AI16XG0rkdTO5Pak
	elnsMenhjlSieB1dE+kIfESoZkX2vXpUdOMCi3wF9r6HSZF0s8F8bGvLCAr5qr3OiWC4d/YDwU4jv
	WxkgEMh3QWXIrpPCPWSjVSoSooTrt7veFZ/x+blbCUPEHmfr4vcmt+ZLO5cTI71/m4hI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWeeh-000000006iN-2W78;
	Thu, 26 Nov 2026 18:57:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWeeh-000000006iF-0lyP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 18:57:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aDrjAv0XGnrW3x9oEtSIC06eMBya0FHkY3qN0P0g8FY=; b=MIicdX+4KMJYklFDsnXi2u4q/J
 MczVZudYqQNYZBskpBj5QJr6v/Zqkr9OlsRwjPLv5VJ92fxi/w8O/ZJnBFDRawdZFWMMc18BWYxNp
 yx/qXLXl7MyZX2uDTRT5N2SOEa569BncO+EE4/pojVdq8a6sWFLNwpbdPmnpyMX07PyU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aDrjAv0XGnrW3x9oEtSIC06eMBya0FHkY3qN0P0g8FY=; b=aLPzKpLJjznhIctJhVPZ67FRrC
 BkIbX0YHLF3Dg7V9n+PgPCHVdXTcDG9i+0ay6UflnNwfhHgoxKw3ZfClyebwbpVZlFxP/F8JbZRwx
 4ImNgeZ83ELL4yscW7OpdakkcC3WNuRzkceLbvxjf2emdm+Xn2l3n9vlYXUY5dS2yHBQ=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWeeg-000000007dx-2Cqy for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 18:57:15 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so5121044f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 10:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795719428; x=1796324228; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aDrjAv0XGnrW3x9oEtSIC06eMBya0FHkY3qN0P0g8FY=;
 b=OWemO7874/tPxHPQRVVuG41EETiS8LllD8d/GdZvX+JiPwwq5G+4xuIulT1ywG5x8a
 LvrS0VJJwmBJRDQx9C7DqDECjLG290qMWUT1F7IhoUqVLIOAI46RrIzixgWG4r9axHW1
 5Dsb/BsR88s1CQoEdWZbMmloOWEQb9t51n9lsoCqFx7KtWuS6o6ILXC6PVue56HQAjfe
 yG4wDm2K7FOmbcNKUbxwy2uPzxbQqv948ao9KJJPWWnmqxF6j2DClzfepe5VRa56l2C6
 b3Bi0TBa3nZ1WRAKiQPEPnjQW1nEG2Ngf6/Mx8CnHBWfcxW4vpHOGTQCByJbQn4102wL
 vpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795719428; x=1796324228;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aDrjAv0XGnrW3x9oEtSIC06eMBya0FHkY3qN0P0g8FY=;
 b=GZ0b8poEMdub9i2suFR+gB7WHRMw6ARWzRVzdwuVNY5Bl7XuXtgTfV+zODCzAlCtJH
 MmjIRYori1M7LGtJFYXioowC1T/LJf0OkcB32kngqiktpFd2NqWRZ6w+onpZWn9zOIrJ
 VngAT4Knz8PndjKHevWcwxFo46Rzu7zuIlWxz7oQX7irXmdWw8n94HgCa5YiO3T/hgJ4
 dxhFp/1nYIAQWPn/F0aB1gyhCQWtCvYwxhJY7k61CCz69hBk5ITW7ov/0z5fms12jqSw
 zARf0cAbR6D6HuqO/FXlcFx9WPV2x6OaPlKYWRb/ZuUW7NGskd2vqIUZH26JNZbv6Lb0
 iXfw==
X-Forwarded-Encrypted: i=1;
 AL+hErFF379NgLIOYzZ9kj/BDdxaYCU0CawWE80wJtYsi+vB52yGxl22rL55hhpMCfsnTmxgZHhI0LBcfjF3XSct@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8Rywtnwfhf/dhwXyQ3nqWHuMcagVMpZdl+uWQ7l6VLV5GEc0eU
 g+ZreSWr5N1IySSKb3QFDxkI8Gogyr2u4OYe7JhNsGFUBZCbnc+HbpNsUBJ2LhPkaY6QL8rbJmK
 mr6M90BmMEgXTQiql1ab2jRcgo7epeNAleu7jm74NRobpkYWXqV6Ql+2WRUhp2G5lxxZ2
X-Gm-Gg: AZFdTZet7njTXjyAl7h2A+ldhXfkHe531Bypdal9d//PxdjLGjokL7jXIShCD+Qgy8e
 PwwhJKESCf+GpHfdEqBhuUYOPtr4uPrl4kIohJMtCuVitAESa4mynOVT2N0p4TVRPWvLzp1uEoH
 EQxk9xTETAwHbOeiiKujQZkTlYaIhKOjWCstoqcpe/ZWEQmhQvweZtcj5i5uWOM3/j5gAgARhsI
 fVFvFVymcRKEDs8Rasd4Qs12PPwkPfcHRuUhWEWlXYexVq09ia1Isu4a/29w+vJlG78rhRAxinW
 xua5cbhZnwPqp2N1fCrFvMChKtj950RM8DqO9a3mUqs3v235d2bEILWm5/UoDOXCrZxbzHY9DO0
 gnLB1V+N1PmkS5kr/iFcQvdm+qOB1bYO3PnZvi5iiAIy/4RTawoTcWYeNyp36HKzQug5D5hkz+b
 8ri8ZSmBrRaqD0F/x0CK4nXYDzqzDNtdEQMYcMiDKeYRZzaFuZ0oCQ48mIc5ueCx4zcANCuvJev
 fdEa9sSed7LL39tn+DP/G3qzisjdXRapdZ5IcArbG5GbhY7enbdomqXVlSq+dDeetTUjYgKMRj8
 gVrusk6cLEGcfv8bfx1hOwz7JAJ5aywO96mSVtaJYIcXSy5xl1hywthYcee/ndI5/thvlCrVzff
 u/eaVHFrpT1h0deDB84UfHeDqoUklFoVwe0gvsJuNX0rGzRQdpNPxKk1A2D7ogqTXNPTVhv0O4f
 IB+IOEfDtYPHLrwGk=
X-Received: by 2002:a05:6000:230e:b0:491:eb12:e151 with SMTP id
 ffacd0b85a97d-4aa4e01e2dbmr60578355f8f.4.1795719427777; 
 Thu, 26 Nov 2026 10:57:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm43785101f8f.31.2026.11.26.10.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 10:57:07 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 18:57:06 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I32f1edf8b289ea2f7fda35e32260909c6409344e
X-Gerrit-Change-Number: 2357
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2357?usp=email>
X-Gerrit-Commit: 061b407766b4060e9d92b6e8d5cbae18e3d5db91
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 18:57:06 +0000
In-Reply-To: <gerrit.1795714582000.I32f1edf8b289ea2f7fda35e32260909c6409344e@gerrit.openvpn.net>
References: <gerrit.1795714582000.I32f1edf8b289ea2f7fda35e32260909c6409344e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzE0NTgyMDAwLkkzMmYxZWRmOGIyODllYTJmN2ZkYTM1ZTMyMjYwOTA5YzY0MDkzNDRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ea0d4fa3c2b49ac0db0a21e38d155822e9b7e92e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWeeg-000000007dx-2Cqy
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: Avoid
 sign conversion warnings related to string conversion
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
Content-Type: multipart/mixed; boundary="===============2018385933797270109=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2018385933797270109==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9f/dTBq9gS4="; charset=UTF-8

--9f/dTBq9gS4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2357?usp=3Demail )

Change=
 subject: openvpnserv: Avoid sign conversion warnings related to string con=
version
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2357?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I32f1edf8b289ea2f7fda35e32260909c6409344e
Gerrit-Change-Number: 2357
=
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Comment-Date: Thu, 26 Nov 2026 18:57:06 +0000
Gerrit-Has=
Comments: No
Gerrit-Has-Labels: Yes

--9f/dTBq9gS4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2357?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2357?usp=
=3Demail">change 2357</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2357?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I32f1edf8b289ea2f7fda35e32260909c6409344e </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2357 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Thu, 26 Nov 2026 18:57:06 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--9f/dTBq9gS4=--


--===============2018385933797270109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2018385933797270109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2018385933797270109==--

