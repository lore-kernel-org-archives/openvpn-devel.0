Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5F606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BM+pZ7Tz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mAeDSHlJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eiHlJJM7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XTgSPhww
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XQmBaBrMFlW9dRFVj3yODI4xcrdVo7X43/gan6EMB5E=; b=BM+pZ7Tz/fKe2a8D8cwoXkjVj2
	w5KbHRr2nbzSdHe5W0plfIh5jjfC2NNUiWpt/Yh0LkaOkIVRBgr+tK7mroVGMtNdMJ1nuTNqEFPa9
	S3HPXug+42RfxBw7eFP7bX0GN/bzYnQg+Meq7lnf50F3mfdfUQTQ/F8cLd6jcWc7Xr2o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSd3L-000000002I4-1bok;
	Sun, 15 Nov 2026 16:26:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSd3G-000000002Hm-1IHu
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 16:25:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f96RD46H445C4ck8jGj19d7c25IeVc43Acbui89Tv74=; b=mAeDSHlJ6lUbvW3UO1NnoVp5HN
 tMXg1cExK712dWSze1Y+vhVh+YbM5uLMcjFiMcd+7XzdCuxW6ybOejiDpsj6LFCZJ7SXS6YMU4bvP
 S6gLwxwj28fL3pm1sPUzmrP0c6dQHydQAY2wV2lsf6LPJKAsaXkuYKiyszjYy8OrUS7k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f96RD46H445C4ck8jGj19d7c25IeVc43Acbui89Tv74=; b=eiHlJJM73/PmjTagcwibAr18jO
 zjj/NOLK0eCzzWPwmumTPhS80SyCrz4vLV/mFvpy1tBPvWS9sdWkdpvH2WTBfkLtH21gvmgAIMNlE
 RveWq0q2fOP5etVOGgmpnziuy7KQdpQ6CbdDpTUJ7yHJJUeiwRP2YFRZGWLdTRXMmpxM=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSd3E-000000004Hl-36Sn for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 16:25:58 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso14064135e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 08:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794759950; x=1795364750; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f96RD46H445C4ck8jGj19d7c25IeVc43Acbui89Tv74=;
 b=XTgSPhww7R/Z+EG/TTWO5j09O6fubTwoNH26A1xNdTj/qVisS6Prkp8O/y8zbBrjiH
 AcCvZ8yZxqlmSJXzXzKhoRZi1guk0npz970Cb046s57yNp6nx0VxOwJxipqF5vokpnNm
 kXJNPvsF0YkpG52kz21rJ/OfmCzKyst8x+RF80tYkzHhpIyJ50AQdogIaIc3LKs1/6ey
 yt6hR3xZW2GyeTZYJlYfL3yn593trG+vM8XHCIqmh08eVAMAmkGrXDaaTeMsMz7Erwky
 XD6Ti/1ue2tkCx8YA87IIpCJ7TUATVwuh2x29O9rQJ1+vxjrDfHcy0jeY/23ap3KKqXp
 FuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794759950; x=1795364750;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f96RD46H445C4ck8jGj19d7c25IeVc43Acbui89Tv74=;
 b=CWA6Z7KQa0kkKnRcl+DVd2ocJya6YvurrXxhj5Z8hSiaVeNxtj1bxrFjDzzLVOxQ4L
 0kb9zYpX5jMCQpNQsUAuwmY38cnJnc+T97j1Fd7xxBZVeMDucLsijZFUiYE89XYWV8/4
 w8quyA1O1ikd3F9S1zlwtAaQVpQiCMpkQExbYBofRjcZx/xkWJ3coMiJ7StALndq1dHh
 isi3e2o+zoUpuDAODTK3Sv7xnVOHc50ysbumP+E3+lDWVjFzgWieDuhVOfXkiPY6nXZq
 6mhpuFfzHMnIyUBX4NVeMDuT/VUHgJovxXWbxj8XyeidV/1U5MykzDJtB8cXTZob6Qoq
 LxkQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGoiDHcxnop9tM8XDLMKL1pRVrjX259PshGvQ7ik7A9iFyicL4Ds8Jq+pd8OsnDnsCLf2Lve3ZhV+YUx0Sm@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8j8BmmdA+6Pw3eFCej72sddQRHffqRVE57OCaOdesTRhub1pmi
 J1mWblBvNrNWc7rhYc4nsmY1Oaj1l5RrPqsBO/GIosx2h24W8Rezvs3ccYgQtJCoB+t1A21jypm
 GCsSHJjCmwNeXTA1EKgbXy1sEk+DyXkDPIdJ9+L+GBmu/79uMmOcZHq4tYlnGX+rHpmcTjumNUC
 Pht3XhjA==
X-Gm-Gg: AYBFou0y86mYqOk+ml/o3+VNhygXdR+U74fG/29o4KuPdLtqNe/cMn+S8ZkrnI5t0lz
 j0SCAZEqA3MOGwpE8q2rALHlIojbhykr69wS67Uu+MYjFYOiwwOFtttX6Iq10t8/p9EwNOsA6M+
 iW25njJ8oL+GwLjr9BP7DunA+j+XJobSM5f+zBUFTIa0RGp8L4k8Q45eHOcmJSTQvOcAxvNZXCP
 MegJhPhfGVHzpgTdpHGWCeEpsAuhxYl+XpIoeuPUdXnipECIM2PA2/hCNrW1x5ASISuI4w/olez
 iHRTDYmHelNAARYF04n4BnrD1sSXPxWh12kCa0xC7tsiZLcwxSitKZ19VVpERFG/omclgllbDFi
 AzsaDNd/sPcgt6ZrBbPYBIKkFDwg+werNG3phD0Wgu4dBV5hhrd9UEjrUdF+bAcWTI2b7pLHrI6
 DlB/zu1OXX0FlQ8VhOqUK0FKqaA3vKKecRyWYP/I0fdnBohUhavop/EobcSUZCTFvmrZyya6DDR
 l+px6XuX9Giw7aVKrj4ve3skJaVelKnJwy+HONazKo0mOqGE1PFN79O1MSLEgrhQVqKBIzDl5Ob
 Lh2Z+TZkg6U/5P2SFtEl4dAErIByFo2emTyOcfVm9kss3e2de2am/SVtjBN9+f+za7Jj0+nMJj/
 /KcM3jYmYUOMmEvkw7YuYkCEdctD3o2otSOJhkXNIfO6GmBf5nxD6sH4t+MkdJO5uabdYS/svtl
 NCvsanb9FCizYz85U=
X-Received: by 2002:a05:600c:474a:b0:4bb:6a2d:b42d with SMTP id
 5b1f17b1804b1-4bb6a2db547mr56483175e9.31.1794759949990; 
 Sun, 15 Nov 2026 08:25:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb6fb45a32sm19515855e9.1.2026.11.15.08.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 08:25:49 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 16:25:48 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
X-Gerrit-Change-Number: 2170
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2170?usp=email>
X-Gerrit-Commit: 80498a0e488bf9004d03d2b3192107a8fe66b391
X-Gerrit-Comment-Date: Sun, 15 Nov 2026 16:25:48 +0000
In-Reply-To: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
References: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzQwMzgwMDAwLkk1YWI5NTllNzEwMWNmODAxYWM5M2U1MTg1ODU1ZTc1ZGIwZmI2MjI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1048ecfaf2262d252d062b8768e9a117edd9a2a4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xSd3E-000000004Hl-36Sn
Subject: [Openvpn-devel] [M] Change in openvpn[master]: DragonFly: bring
 things back into a working state
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6210150496969884948=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6210150496969884948==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8JyjhfwWyQo="; charset=UTF-8

--8JyjhfwWyQo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Gert Doering=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail )

Change subject=
: DragonFly: bring things back into a working state
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(2 co=
mments)

File src/openvpn/tun=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2170/comment/5f172530_9faaf7b4?usp=3Demail :
PS2, Line 1018:           =
defined(TARGET_OPENBSD) */
The comment on the `#endif` no longer matches th=
e comment on the `#if`=2E


File tests/t_client=2Esh=2Ein:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2170/comment/83453532_b551a126?usp=3Demail :
P=
S2, Line 215:         FreeBSD | DragonFly | NetBSD | Darwin )
There's a str=
ay space in `Darwin )` that the other cases don't use=2E



-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0=
fb6225
Gerrit-Change-Number: 2170
Gerrit-PatchSet: 2
Gerrit-Owner: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Sun, 15 Nov 2026 1=
6:25:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--8JyjhfwWyQo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by Gert Doering=2E</p><p>Patch set=
 2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px;=
 padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">View Cha=
nge</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2170/comment/5f172530_9faaf7b4?usp=3Demail">Patch Set #2=
, Line 1018:</a> <code style=3D"font-family:monospace,monospace">          =
defined(TARGET_OPENBSD) */</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">The comment on the `#endif` no longer=
 matches the comment on the `#if`=2E</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>File tests/t_client=2Esh=2Ein:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2170/comment/83453532_b551a126?usp=3Demail">Patch Set #2, Line 215:</=
a> <code style=3D"font-family:monospace,monospace">        FreeBSD | Dragon=
Fly | NetBSD | Darwin )</code></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">There&#39;s a stray space in `Darwin )` =
that the other cases don&#39;t use=2E</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail"=
>change 2170</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
70?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2170 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Gert D=
oering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doering &lt=
;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Com=
ment-Date: Sun, 15 Nov 2026 16:25:48 +0000 </div>
<div style=3D"display:non=
e"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: Yes </div>

</body></html>
--8JyjhfwWyQo=--


--===============6210150496969884948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6210150496969884948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6210150496969884948==--

