Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56406606A339
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KqE1vo9s;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IJADvkTI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ilgM8lBO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SylfWbDG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TBOzifN+s/14r1UUxp3gTKXT1BTEai1A/RHE+Nwz4+E=; b=KqE1vo9s+6plQzmlqxuKLeoHo6
	EE7q8pYocklwtDabEFdHyips/1SXu27WkB08eanw6YUge2Mp6DIm4E3WVVRs5rkqq2hrfhQ21qR1i
	jAeePSTuex4vO/9UcWfkae2KDtw8yqEnxemudBSSgnqR2tawjF3GMoC6GwSPOGu6Lkfc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0KK-000000005iA-0cDH;
	Mon, 16 Nov 2026 17:17:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT0KJ-000000005i4-1RQO
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:17:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9gWB6cUoGh/LdEe4Y1G303SepqDquFy9XJjuPr0rw2Y=; b=IJADvkTIzblYUcDAj/LXO2XaqB
 lOZWmHtcmSgc+9NYg30CsP7aRee8+LMTIwkzyl3YfeLlUcvJIDmcFUn8hVS54x6CdNR1Dcdnp6Y6M
 8/aD0wDLZrCZtljv/Kl5ZN9RCzkDJpzcNMpnuFH2m96+oif9dszDMBnB/0mRiAROjujY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9gWB6cUoGh/LdEe4Y1G303SepqDquFy9XJjuPr0rw2Y=; b=ilgM8lBO3NpvYHWuqngU09FMoQ
 wEWXNe0BdupuF+7+toVVBsaRKp8/YlbtOnM+JM7onavdxtPihgTovmJtolrv2vKSXHyzDhWc82R08
 SiM/S0RXfyaXs7ue6s5DJnqOKH5krUI+5dzTfsZmTgTiH3R0itZLtS569ENF+ulPHOSE=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT0KI-000000004cT-1PVP for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:17:07 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so8202385e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 09:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794849420; x=1795454220; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9gWB6cUoGh/LdEe4Y1G303SepqDquFy9XJjuPr0rw2Y=;
 b=SylfWbDGIcoLU8obQExI+iE5UQzp5ApGVdDfnTnCQO1Gew6sUewkSHmD0/FLkRX936
 6hlV1j6HZLQKfiMIx+yJTfqmu/0qcTxjhVb452EDAtQP9/tjSFX7cxc98YSH1bBMoktB
 dypCYtnDMxxj3DIHQN/8yi269iVKEBOHl3NmkTV8c0yDJBvWvMgUcyVmxv3MDrsL3L0x
 LFz4nfwGi69FKafYdwzfMFtXIn8Yyz8iOfNDDh/3NNoSguYtc77s+sJGoR1IpkKIUxID
 U95ecc1YkQhI5UVziU6jP1ob69a5qWjjyekWJrsuJS+t/jpxmEa/jWIlngI9mk5hOxq3
 wxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794849420; x=1795454220;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9gWB6cUoGh/LdEe4Y1G303SepqDquFy9XJjuPr0rw2Y=;
 b=gJ5j8ByPutmZnbgD3bKe4Ij7rPFrR3RlGcdFLF7c7mpwlCgDpi5AedI+Q/pxaoWwnU
 p7SpE75ylaww/bqcJLtlGIU82307xXzahxkEQ4RQf5zKd5J0I4+uodUbjnGNyFZHpH2R
 rkgY4Pd1rLvEQcp4wb5z/mxdSp9mDEjOGapzrcbmJ9j0TdAI3atxmDyFjVhwlCSeezo7
 XqgbytEFJxBXbMQtzl0c1ypj9xSdEUgTubCon2UGIgCkXUX6B2AFppn1lkElk/TOPa4B
 2TbgnamBEZHQGb5vT8N3JkDNsHf9fYWfrfEo/DlvoNVPBKP1Ucb6+gcv5mh480S0eSfK
 ZsyA==
X-Forwarded-Encrypted: i=1;
 AL+hErGSUiitxTGhaUgUxcAaeG81deYbfnxKtK3Zz8B2Oe8zFiPZx0v1nmAwTjCUjqU4wTQOl7eMV74B13X1ozBM@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+8sKrZx+5GLddos6RUOCC1LTL5GDWy6fiXLQoZQ/zmSw+99XdG
 WfVEA+j4MJqnMVjK2q75Wef5VrMfoGnuu+o9ZrUF4WrvtLG4xa/xZkH41FwK0p7za0bHrKvF0Kg
 f9hHlXRAnkI1/i1SqjWcvWpnPeQAw1pc1LDc3GalJYLoiK54XvVzi7hbXTtUV3dueC8aWoUrY1g
 6VBAbHVw==
X-Gm-Gg: AYBFou156cb2FWn1tcWjz7mx7QKIlCgPoOFWCEgzJ/Gn1ltlbm9S3pYB11M1T/4Thlp
 F8gauRRj5leeCgXD4DRuQAP/fcNfhZQnGKSG9DMyIVfJRxI8xIcbtDsTgHRPHqW11nu1YMrcFKe
 wTN2VsJdGZUvni2qbesWc4od9HVPSRNQPfVmenu0CPMu52DeV2FH1Lto7E1NeVqd28qvbzH8MSV
 Y2huChoRoHVtjJuIDzHH3sNFRvxhPjQH+tNfRjdPzyduCdOnV+8uZJfu2Gwf//Y4IZC+oiV1TRZ
 /pZWIzw9t4s+23clVx17CH5wBM9jZBO/wbpgnI44wefHr69OqdBY54nI36plr87p1//No755npH
 8CBLjQj9f8qy4mw2+UQWfLaBved6KE0bHANUds5OVBl8jeti4TNK2sbDfDA9KXR8AT3fGv7rRRm
 AcaDJP63jWJjsQRK5PF+RAaTqwBAWYreYY2hccnG5RQCirnUhYsgsQPBaf+/1ennrT3yYbMF3wT
 p0NBziySSxTBRaJhp3NxWu3/6mzG9m5SH/1jS73rEEFboOOJ0LIq0mTxIiKxkjdC5U66twcLgiQ
 50N2B+YzTNfl2wwwIXMuRFGmzx99b5jykH77wVgaTuA3VJ/UUCa1aJP4bUAKs5rqC7zuN1EE9at
 09tGSj7Mc5MmFEnLtb89w5qEeBrPFPAPioGrgY+t3mLPii6wVMqpjfxPftKWt4RVu/dN1cUBVJ+
 MqR10HvrNJWleFcYw=
X-Received: by 2002:a05:600c:3d96:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4bb559f2488mr223528745e9.1.1794849419680; 
 Mon, 16 Nov 2026 09:16:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f7eecsm5374795e9.3.2026.11.16.09.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:16:59 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 17:16:58 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3
X-Gerrit-Change-Number: 2196
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2196?usp=email>
X-Gerrit-Commit: 503782249ebd92a569c151d8e36a1b31813d3ceb
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 17:16:58 +0000
In-Reply-To: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
References: <gerrit.1794834650000.Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM0NjUwMDAwLkllYzg1ZDUzY2UxMDc2NjM5YmQ2Y2VhZjNiYTdkNTNjYzllNzlkN2EzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <79d104fa0b177ee52c3d0c2e3b29f5ad052b6f2a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT0KI-000000004cT-1PVP
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: drop
 impossible out-of-memory branches
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
Content-Type: multipart/mixed; boundary="===============6103759823272365619=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6103759823272365619==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vjE6utAPW+0="; charset=UTF-8

--vjE6utAPW+0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Demail )

Cha=
nge subject: options: drop impossible out-of-memory branches
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iec85d53ce10766=
39bd6ceaf3ba7d53cc9e79d7a3
Gerrit-Change-Number: 2196
Gerrit-PatchSet: 2
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date=
: Mon, 16 Nov 2026 17:16:58 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels:=
 Yes

--vjE6utAPW+0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2196?=
usp=3Demail">change 2196</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2196?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Iec85d53ce1076639bd6ceaf3ba7d53cc9e79d7a3 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2196 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16=
 Nov 2026 17:16:58 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
=

</body></html>
--vjE6utAPW+0=--


--===============6103759823272365619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6103759823272365619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6103759823272365619==--

