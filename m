Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627C606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XIq7cqL9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iTfvZUDy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cMGj9BV0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CXrq3zTW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JwcjaO+gVVK6QNWfyjZODAP21uF3FAvMBrX6x6tRgog=; b=XIq7cqL9K4nlkYhwffuW/8WTOi
	+Sxy1hbnslskKVba7sbWtUA0J9VMZxzQbm4oud8vkwY5/Eo9cnrNuEcWU5AEGhCKrsdO2pjP7DIoK
	dGZmy+AfkCdJrrnBnD7brtGIErSstyZciyzx+xIKwurjQq4Dj2mAWstml67G9dWglmpQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xKMBu-000000004v6-1yr8;
	Fri, 23 Oct 2026 20:48:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xKMBt-000000004uy-0N0j
 for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 20:48:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k1BUmp37FHgqZCtyVV7DzNVpi0SKjpcTcY7CA4U7Tms=; b=iTfvZUDydwsy1S/xQvAbb8iqSU
 lfvJkTGG8aSB2+KgK8AWwuLxL8Imko1E9HDfqnsowDhGiVkvJALDvX7PlvRL4rvTb/5W49AUpzP1k
 ir5FctIlZ32VVr5J/Xu2zv4QwtE+DrxTbzZ5ljJeaBkt2vCuOfH6LPtri25ijdzoOlsA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k1BUmp37FHgqZCtyVV7DzNVpi0SKjpcTcY7CA4U7Tms=; b=cMGj9BV0XVbtquD0XHSrq5ncYY
 SMjp3rVLE1o1DCfwpMT8ERrxJXPZvNXkV0CWnFHE83r+GB1HEeCPLHpO5mM7wtMULDpSpfkVBMjpH
 PSQzNX1I7KRCKtan6kL5yFX9wZ5HCwkzZVgKklQgXPinER8+R9+hdF62fcE4Rp3iBm/Y=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xKMBr-000000003uF-16ez for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 20:48:41 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so835525f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 23 Oct 2026 13:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792788513; x=1793393313; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k1BUmp37FHgqZCtyVV7DzNVpi0SKjpcTcY7CA4U7Tms=;
 b=CXrq3zTW8JQ1r0CJimThlZFV1msUZKBgwnRUhp5z0s3UHoymFUf7vxYOD+W1ethE/V
 QKaAp2e27lHP3otxoqZEr4jGqZyZ8DksuqZdJA+GdsGmebDoCDE5clyed4GYEKR16ZZU
 Wf3zhd1reC/KshCzgFXBtyO6y2F+s0NaxaKLFNdKgRHyQwVdnszVUG1jnlikj6KaWYrp
 RAK7tKE0OCDd7zPoBAw/1jFT6XzKevI5dgpow6f6i02Py+Qo3K/7F4WjKQbMN9pxugDV
 tbRD+Svgszvw72KHXt33BxEtDUinHlgKzFwD7DDf+DN2ai4VkOaLq0Ip3xNd6c3JEArw
 p29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792788513; x=1793393313;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k1BUmp37FHgqZCtyVV7DzNVpi0SKjpcTcY7CA4U7Tms=;
 b=UjRD/CL4vkJ9WcbeH8EOERYnIaNodQMe+dq/3Dy3YaW6pMAhh2NZh2g+nigCCwld93
 ISpZOi2HWjh3V33RyUHC8/lgYmS2QsjtMpI22qlJiKEKxXrZNjZk6qiv+96gaG+NlcaW
 2DrwqyXOpQu5mOOQwtokwKbnE637hOhZhHsyAR5fRGLHj2pxnbrUxRb6fn4rhqXVtC7x
 UxZ8EEKknbMsKwlbh/7fx5ec8eMLw8ncjBmnzL5O5ze47NwtgIQv/3Zv9rpqmPNFfcuU
 wbOYvwpGV8rzwlij47EkXPRYDqDJPscRUKytEZFMpgUIo7DNYBo5OjUI7RR9WmrWBtDP
 uM8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzl6PfxA9bfNgT/PW1E2vEyHflScnrzT6tZIjP2l5EXMn8ckUy9PykhAevnE7igc4rwnxseVq6wD7P6+w9J@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKs6Ix86/mheCrRtT4OFzHXC2wFCKwc8iLYk7SbYDiPdLXgtZL1
 /jckODeR6p6mgiJqGo53nII8Zx9j3s0rOerJULG9AAi3o7QA1dlJjTHtZQC9L/dPOBCZJpMtkyO
 2+Lil4EWeNcduGQF3TKHAGZ4QUbvfUK45arDB1Xb8076Wxsy8RrP+20tUtEgRu8gUbrxl
X-Gm-Gg: AYBFou1QgS7arbkVigdA3TwVyA0YcSWkyvTJKSc5RarIiUgyGIqwKFdOZQNk1Zf42VM
 7fz3luYgNzvSS3Pe3WG0jEMMt8SkVM5hOOyr+mHQOG68jPdlUUKt5TFj3ycIyhbLIU7iqr8Rymp
 7WELp32GmUgjjcEHOQ86Dd0ZYvvHvKd+7VCEAcE67Q21Uvk57/0hWuPrMLT2ij9edC29yDL2GoL
 yXM99tpst6TPBoe1u3sHWnz4rFxOGK1Ho+wSW7yaSfuH16Ur7gbDLyW2Kq2aHL/XDQDHtRN2SQ0
 nyCRcS2Pe0RuWI1/E+4vSJipjmsHSE5mAr+gXnjUQomuC64tlOWJsYKy28/vJGPFJegTRMqrXJ2
 G9LN4Xak5fkwOcdxT+5hFLyOC4NtmPhUOpKzk6jw2RT/vKsrBxHPmiN6X4OyHo/ZwtUfRlQbKqM
 kaXSm4/m/m/6B54ZrJlNMCekBMdxkBVvaQF9FWqx3QrsvSkj6aPo/CNE4w8ygybgAmRf4/S3QiW
 9CAQVouIxO2wqujS3llZ7z7fr2h/cxJjeHp8lOBF3jORLdSvWwNupl1AhMag/JgcCQ44DoV5PnH
 waHIHpX62T5djJJmokp/P7qrEs8NrqTiVV9S1H9XsXkgvmNCDvBIqAiuURp/+xhABRdYp91HuyM
 qQob+3MK4w4xRqO1dRUmZ+MFyop5jsYStu8EFd/HgWg==
X-Received: by 2002:a5d:5d10:0:b0:48d:f485:5f34 with SMTP id
 ffacd0b85a97d-48e3eba1377mr228040f8f.45.1792788512534; 
 Fri, 23 Oct 2026 13:48:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3932sm262353f8f.18.2026.10.23.13.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 13:48:32 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 23 Oct 2026 20:48:30 +0000
To: Ralf Lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: b4004c28690cdc057f33573ca50e018eaebe0baf
X-Gerrit-Comment-Date: Fri, 23 Oct 2026 20:48:30 +0000
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b67cb01c8808a805ed5514486dded007baec4d63-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xKMBr-000000003uF-16ez
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7418548753328248503=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7418548753328248503==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jvmqLG6aiJo="; charset=UTF-8

--jvmqLG6aiJo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Antonio Q=
uartulli has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail )

Change subject: dco_linux=
: enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(4 comments)

=
File src/openvpn/dco_linux=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1991/comment/8a527094_4c07184c?usp=3Demail :
PS1, Line 573:     /* find th=
e last separator (either '-' or ',') */
aren't we actually looking for the =
beginning of the last number?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1991/comment/4085cf6a_e6dae35b?usp=3Demail :
PS1, Line 653:     if (page_si=
ze <=3D 0 || page_size > INT_MAX)
NR_CPUS can be at most 8192, so the mask =
can be at most 256x9chars, which is around 2=2E3KB=2E Why not just using a =
4096 constant and avoid this complexity? (would this call work with --user/=
--group?)


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/72ed997=
6_bf56ae95?usp=3Demail :
PS1, Line 665:     int fd =3D open(rps_path, O_WRO=
NLY);
will this work if we dropped privileges due to --user/--group?


http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/c138b623_e8308267?usp=
=3Demail :
PS1, Line 734:         ovpn_enable_rps(dev);
are we sure we *alw=
ays* want to enable this feature without giving the user a way to opt-out?
=
What if on small/embedded routers the cost of RPS overtakes the gain in thr=
oughput?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
991?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comme=
nt
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I97c55e2=
11f9113d090808724ab43cb3c94099fb0
Gerrit-Change-Number: 1991
Gerrit-PatchSe=
t: 1
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: Antoni=
o Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri,=
 23 Oct 2026 20:48:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--jvmqLG6aiJo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Antonio Quartulli =
has posted comments on this change by Ralf Lici=2E</p><p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></=
p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_linux=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1991/comment/8a527094_4c07184c?usp=3Demail">Patch Set #1=
, Line 573:</a> <code style=3D"font-family:monospace,monospace">    /* find=
 the last separator (either &#39;-&#39; or &#39;,&#39;) */</code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">aren&=
#39;t we actually looking for the beginning of the last number?</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/4085cf6=
a_e6dae35b?usp=3Demail">Patch Set #1, Line 653:</a> <code style=3D"font-fam=
ily:monospace,monospace">    if (page_size &lt;=3D 0 || page_size &gt; INT_=
MAX)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">NR_CPUS can be at most 8192, so the mask can be at most 256=
x9chars, which is around 2=2E3KB=2E Why not just using a 4096 constant and =
avoid this complexity? (would this call work with --user/--group?)</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/72ed=
9976_bf56ae95?usp=3Demail">Patch Set #1, Line 665:</a> <code style=3D"font-=
family:monospace,monospace">    int fd =3D open(rps_path, O_WRONLY);</code>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">will this work if we dropped privileges due to --user/--group?</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/c13=
8b623_e8308267?usp=3Demail">Patch Set #1, Line 734:</a> <code style=3D"font=
-family:monospace,monospace">        ovpn_enable_rps(dev);</code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">are w=
e sure we *always* want to enable this feature without giving the user a wa=
y to opt-out?<br>What if on small/embedded routers the cost of RPS overtake=
s the gain in throughput?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">change 199=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9=
7c55e211f9113d090808724ab43cb3c94099fb0 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1991 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Ralf Lici &lt;ral=
f@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 23 Oct 2=
026 20:48:30 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: =
Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</bo=
dy></html>
--jvmqLG6aiJo=--


--===============7418548753328248503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7418548753328248503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7418548753328248503==--

