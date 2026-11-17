Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89960606A323
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Lg0Jot06;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jLyhxwnd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LdtEIN+/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TuyL5xYq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZQDyNqk5s0J9EK6SYhKVJ49A9CycsPwKeu6YLT9bBTo=; b=Lg0Jot061YLCTsMpPOCf6tcPRc
	OrhzsWDW4iQJHnqhphcYlqHJiJq+kTB4PlwPFmOi5AkBAaqHkcPN7ghM4GWlayVVdWmlWYgNOAhI/
	+jyRo/S9JjGWNa1zfew+amDxoIccB9h1plm2bB3/Ca4S4s/i1A5B31yvpT/5pHeB1XeM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTG9O-000000001TI-3gtF;
	Tue, 17 Nov 2026 10:10:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTG9N-000000001TC-0o7X
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:10:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vnz4uBt/WcpIGlUxU+n0JgFWqsxwIqYqNsyJdnjDtSU=; b=jLyhxwndjpSI5bkaGJqu2ehnDp
 VYjCvy7+q+qJLmA0NG5KrFOULqwaSHazVRCIvaDYh/vqkVq3AyhgclRZbU/ZkX/VNSiwQlZo0wltE
 ZKD9iS/+adYhdiojNy9bzx5GYKhSDgxCLFk5S6VFdoU2LrO7yNIgBS61B4soxC31f/ow=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vnz4uBt/WcpIGlUxU+n0JgFWqsxwIqYqNsyJdnjDtSU=; b=LdtEIN+/lfy0q7/2aqRrrg/pEB
 TO4nJaZHk8Ji0XcLgVvBHQW3H2OSONQztHdl5yVceL0HOmsJ4oOHYAbeBZBkI9xZPWQ1nK9i45oaa
 zgMzMw+SVpx397RFiYyvee+PU7mPLsUljz11QxoOZsbZgIBvytdCgrHOituK2CPZiHFw=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTG9J-000000001hd-2er7 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:10:52 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so352943f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 02:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794910243; x=1795515043; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vnz4uBt/WcpIGlUxU+n0JgFWqsxwIqYqNsyJdnjDtSU=;
 b=TuyL5xYq6hCt8Ca053hI3HCAYCsCrOheUJ8r5/qwhUq3u9KX9mgXJhWYgt6ICW6O5v
 tugPiIbwFhpMFmO8x6lJ5U1eGa4zdPxAT9GiDWUXZ4skn3rXjGJVp4GMmJl50F+J+7ns
 +q9MdZg/0fmALSeVosNTDT0MCq18c0hngR/qv5e8LBiZBDWp9vzGyjxLkycrqhz2xRxq
 APHfnGWB/KFaAqVSdWmaMo/8bPlGDkrF289g0LsVHRhXkAEyCnoWG1g8shAXGa5bXnhl
 VsiGnaW87qiHLeBEFO3C8Azcq0YNBjJGLfqHXusCyC4f8yuTaS1oPuLyZszHl6XC0EXT
 H4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794910243; x=1795515043;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vnz4uBt/WcpIGlUxU+n0JgFWqsxwIqYqNsyJdnjDtSU=;
 b=pwAHWnuysYyksXMx8H87KCwX3G6KObyo9yL/CfxhkAIOKY0GC3li5iy0RoCM9dmsSo
 IqeyTTQWMbmHLDKuTNviZmXNqsA3q6tIMy5IShfyJhOcTK/3qO1Lh+Q+ttF2TtZaN1y3
 Bfm6/9iF55Xb4Es7t54U8D1nyWbs1Rpeln0IuQkhtK013rotoZHOU/9AL24m4dPMUaeb
 SCgG4FkvZ4s2qH05N2SqDnpKN9ZkBiBRbR1B6HgaxRRThdt9rmEhZ8eUdpibDvSdkYnX
 f91Il71gHjEO9lCbPqHiyUdn+BNtV5DE5VIZkxpePjIZKxbwfpcYw069zQOuDyAx/HB+
 Lg2A==
X-Forwarded-Encrypted: i=1;
 AL+hErHry6nIddwztt3S7VV2U/KotoiVeoq2HL08KjEgrNKAStWHarIZT3hCtT0h0F/NZ6ZpmKA0Hw56tu+cnTit@lists.sourceforge.net
X-Gm-Message-State: APuU4Z81xlWzxkwe5m2UpHJDy1h9vFRWpn0LMJVEYxYZ2ZW5REMxquL/
 t5gF5/5jO2lokOVHFSLaXCFq1eMQiWsqqwyTxvbofon8KHyQpiu12xUaCyxJvFcgYna36OEKwF0
 6IV0OeFHtoel2sxGLxvmJycpWpzupKP+e7prwMG8X/8pUCdBIjhlJz6+WdQpiyv4WzYgVm0Thn3
 OAH7EcrA==
X-Gm-Gg: AZFdTZe0DMBlxOIAhT0+7JAe4SVFzZIhMF4VDB/dq6GhyH1aTDWZedNFK8TkdWGSBay
 Ydbwo0l24YEWuykIba3rEZbxnPQqqEQgW5UD/XQbSc6Vgly+v0uh1+l5kCEhc/WvTqhW3I19i+l
 9Fo0jHy7J7xstNTHKPmoyNLEBwvdppUHzCI9dk3K/5OsObW5597gRhO33LgStAP/eVM47IrdcPr
 nr/kNBQ8bWrXLfLSlNkBf0Ofsr/7OoiQ6zxS11cMPVNxfYlgY2R+HeSTU9hNP6cLo6BO+LWuR4O
 3v9/RVZSqUvnMb9A9C5dFybyvu85Mg0BrSr3pNcHDioyhDNhT4nmLurhV7oJ9B2fac1v5JHuYTV
 MkVQRekPa7We19IpJ1NFOywKzgxMVWdN01ZyryTgd3B8BPShbxvLo5cNhc8ZKDlsydacgbLNxtZ
 llfHuJrS9rIpotwehtSyatKPQsXzKtU52wivVgH8WR0MBa8vWuZDYCdQ9IToQJ/J4aZCMnG6Wr2
 mSTMEUKA2uJjs6nzNB24g+b2YVxhXtoImrLZ53dh6TwMK+6H8QRbJYallspKGXo3NvmcKxvpXNZ
 eyRhQ/mC3Rxtfg36KI658WnWeGeKV1UygR5mWtSav4wuXWeB3E8Fq/XPaw8We/37ixPSyc7zkzT
 AWJ5P0qgtiMOtvyp8TLTx6d+RBk/rQcN/c+16srcA7SUznee7xswO6lf6jrEYFy7Wfb8mXRpVve
 A5WLSwKYdrDwWprww=
X-Received: by 2002:a05:6000:1841:b0:48e:2108:4d28 with SMTP id
 ffacd0b85a97d-49c70de3881mr31841773f8f.13.1794910242820; 
 Tue, 17 Nov 2026 02:10:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a2f61c0989sm5395594f8f.48.2026.11.17.02.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 02:10:42 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 10:10:39 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
X-Gerrit-Change-Number: 2198
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2198?usp=email>
X-Gerrit-Commit: 4a4389a2ae44a3ce9b24bfba4bc64dfccecfa83d
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 10:10:39 +0000
In-Reply-To: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
References: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkk5YzI0MDNjMjFlZjhmMjFhMGZiZDk5ODM0NmM4YWQ3MTliNGI5OTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <71a4467477b2463e3fc678c4affe50d01f83c8b9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTG9J-000000001hd-2er7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Switch
 buf_forward_capacity and buf_write_set to size_t
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
Content-Type: multipart/mixed; boundary="===============0530164521373484627=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0530164521373484627==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nW18BnqNOdw="; charset=UTF-8

--nW18BnqNOdw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail )

Change=
 subject: buffer: Switch buf_forward_capacity and buf_write_set to size_t
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2198?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9c=
2403c21ef8f21a0fbd998346c8ad719b4b9972
Gerrit-Change-Number: 2198
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Tue, 17 Nov 2026 10:10:39 +0000
Gerrit-HasComment=
s: No
Gerrit-Has-Labels: Yes

--nW18BnqNOdw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2198?usp=
=3Demail">change 2198</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2198?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2198 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
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
lay:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 10:10:39 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--nW18BnqNOdw=--


--===============0530164521373484627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0530164521373484627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0530164521373484627==--

