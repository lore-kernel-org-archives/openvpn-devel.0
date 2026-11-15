Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99F606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VZzm3yZw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FYejKG8a;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WUWRoY44;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=G0/ou6WG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Yl169ObwJzeIHF2dNO/HS6Sk3HYA6lPk5mOqKISSnaw=; b=VZzm3yZwhXNzsJOzyBTdAUfXiu
	eiK6oQP9kB8C3fNtmtIOwpm2Hjd5fr2jWUy/ZukpPwuvs0arovq3nygUH8PX+wz7jLWvMixKbAaQ/
	VHGz9R87gk/NrKpODvPsgeJyg3dpkRfAiy71dSUTgo2UpihftyHcLWVqqrJHUb3skXDE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xScaF-000000008Ik-3O3Z;
	Sun, 15 Nov 2026 15:55:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xScaE-000000008Ie-3ulh
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 15:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=knJZUOb8Srd8Q+bBFzbnE3F3riS0zYGrJH3CRg5DaTc=; b=FYejKG8a2qtkk2dgaFJikJce7t
 DsyZtGHMsUXXU5PPgKUvUNVQ6IbyYje6WiBudPS4kMBPTk36ThZvd6ZELhVmmifiEJQfe68DDZht0
 vqAeJ+o7JsRud18MjArijYvtUo7eLKsueHupkMH7P6jNMMnSouw3l9+7LSQ4HshxXsuY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=knJZUOb8Srd8Q+bBFzbnE3F3riS0zYGrJH3CRg5DaTc=; b=WUWRoY44ETlckSIxOnylKfOfCK
 I1n3QeHs3G/C2/c/hMtppP+wyExN0DBJIDup2zk1GDgMj0k/175AHgAABjXWIHZs+SyVAXZxXzUn2
 /PKXToUPReP/AlPjVM2cKhBRl5jtGXIcK8t3WjEofvQ8T0rSL5Xui5GecVoNmyOsXY40=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xScaD-000000002RW-3E2P for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 15:55:58 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso2921929f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 07:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794758151; x=1795362951; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=knJZUOb8Srd8Q+bBFzbnE3F3riS0zYGrJH3CRg5DaTc=;
 b=G0/ou6WG/e6vEo0+ln8bltjfzoyuT7WMpvs7WamIJID6jACpJJ4ctSF+g+O1wRj2lW
 tlrFuhD6wm3y/klViwa5EttaEzVXyIxRe/Tzd960O8sT39XxVwxvPx+JqzyTfZgwciua
 32ck4o50XFQCFukVO+cuwV0s1rbVbWwGlxyAJ6Xoi+xJLpM7h3MwtQDmrB4TtauHc+QY
 d+qpsELRe57NLWinXqgpq8KytJQ1OeEueKDf8BHULPJnmTBVs0p1/N5GZR+sjhpzSBgY
 w9umn2vNLVo60+lH73EHeKHmAmL3M8UjjY+dbXZ5q3gP7S5bvyYJVzQCJYs3rN7xPMjj
 vWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794758151; x=1795362951;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=knJZUOb8Srd8Q+bBFzbnE3F3riS0zYGrJH3CRg5DaTc=;
 b=1v6rfw02cg2dxu6L4bsir20CLr9/RHriJasXr6riTaTlXeDFUGrpul1W5QAFZMuKkM
 U+Q9eYHznTmngHyRFu8hPcgQlHn5p0nsHsAUV0LZONkZd9dcMInDVmp8LqvFGD+R97yZ
 qh530wu8NBRoE79kumy5LLwuocnBy1gS+cnjAjDC9dlbuJPSsW1ZxOmyj+QbCcEicB0O
 Jif4cGU8w/kP97cPmL0aDD5k/5/JJXJIqXnez8VUmnkRQDx7xaajZAvBB+gIYeIGhfTW
 rF90OogDvzK3niQmGW8pILWC1XKH8KIKgyPnavscwUUBqhnug7T0KvSp2yf4fUFNCdXF
 Hruw==
X-Forwarded-Encrypted: i=1;
 AL+hErGwMUPQXy3juQ3RQR6MbJRBkEQmixvpticWJ/puhyN9sahkJsHt0f3nvy8YCdlCV8IpN9NBpYVRWlWmCkgK@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8Dq4KphqbSgNVUstXAh5kS+t91TkbFTwqHLEGWB2YTKSVHAOp7
 2g/USdb6zpro64fqLi4HxLj9WX6BC5vw+BOF6VDkjvJa6pLgnKhUiXwTJWXaVKDnRqTeOnN8Td1
 8QPS8lv3Eoux1N/jJ5W2tLfvByzy9p0oJvaM6bR2Kl8W4je2V/aqgn727ZgSxobFfXPRL
X-Gm-Gg: AYBFou0SHAujMC0Rm2wi7t7kQp4ah2NiGpoC7pB2K39U6nmOjHXKD7769fmOb5ddYrI
 eMcRW7E8u57gZmZOms41Uamq+4WuGI1FOzwUJFA5w5CCZOMhcTiJObono4lRAaP/iHxeKXSrYkS
 u0MMni/XC1Arsm0KUWOQg1lHuX8GVmrQeTW/p6Z/oOQ2xiFscDFMOkiEXEHSRmc0/YX8Mwf31lD
 kIDwrTjTakcMsUGDeRNFtCrlz20NGySnNqrCo/hq1n98NIRLHDCHS/o9B6I4nqD4iAehHzLHyN7
 yGvxnZdgHStQKMqhXUkJrvo3n0n2TFY9qPiqb0QYg37d6hvSAelmAchdjrBD6W6rvJhaF9ssamn
 xPkAaDCdp5I29dayDi2n0vzfJoB+AA3acMzA3Y4xZJayKwdH0CTpHEKF+yoHASkyP/r1Dloklnn
 0GyCmmsfP1nRie6LV+SKuXNanvLeSSdUsrwYi9lLfsGpSHHz+rUrz5aTS2zDzAfqtUpG30VC43Y
 u6ARmJte6eFeRnrPdugI21T404lWAHF/v98hKCVvPGLS5PhLdMQhDCvFqXKcus+jaPo3BA6vFo7
 B25z8WP1zXAqNnGjmoqwTv4Z+MsJCGblESoP/2RDdEVxI8epwrYrb1C4RB2J70XxWeghcQ9wmgS
 Pkd1Voq8Y8SvQZN2dCtqmfmc+ZDhkdhvRQrSG+/DtdDZPMTBCGDusRPoCLRSlZtcp4CWwzMxwqq
 orVa+gT1zCPc2H/tNIp88Vbxiafu2N6lslYoiy
X-Received: by 2002:a05:6000:290c:b0:48d:ffcb:28e1 with SMTP id
 ffacd0b85a97d-49c70b05138mr18481048f8f.11.1794758150989; 
 Sun, 15 Nov 2026 07:55:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c603f4d29sm16887308f8f.35.2026.11.15.07.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 07:55:50 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 15:55:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
X-Gerrit-Change-Number: 2170
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2170?usp=email>
X-Gerrit-Commit: 829177950a079c191414f6f94c18db76c6e2b33b
X-Gerrit-Comment-Date: Sun, 15 Nov 2026 15:55:49 +0000
In-Reply-To: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
References: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzQwMzgwMDAwLkk1YWI5NTllNzEwMWNmODAxYWM5M2U1MTg1ODU1ZTc1ZGIwZmI2MjI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <acb11cb209e812ef3b3aafa82a9a5996027463a4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xScaD-000000002RW-3E2P
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2480968177121832572=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2480968177121832572==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kW5/ncGRn8s="; charset=UTF-8

--kW5/ncGRn8s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by Gert Doering=2E ( http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail )

Change subject: =
DragonFly: bring things back into a working state
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(6 comments)

Patchset=
:

PS1: 
> The `clang-format` filter doesn't pass for this patch=2E
Done


=
PS1: 
thanks for the review=2E  These will all be addressed in the coming v=
2=2E


File src/openvpn/tun=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2170/comment/e58577f5_433a5dc7?usp=3Demail :
PS1, Line 2900:  *    the fi=
rst free device, ask with devname(3) what you got, and
> This says "ask wit=
h devname" but the code uses `fdevname()`=2E
Done


https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2170/comment/d1728bab_8b8b2506?usp=3Demail :
PS1, Line =
2911:     if (strcmp(dev, "tap") =3D=3D 0 || strcmp(dev, "tun") =3D=3D 0)
>=
 `if (!dev_node && (strcmp(dev, "tap") =3D=3D 0 || strcmp(dev, "tun") =3D=
=3D 0))`?
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170/comment/9d=
eb7199_b68d9c7f?usp=3Demail :
PS1, Line 2918:             msg(M_FATAL, "Can=
not allocate DragonFly TUN/TAP %s dynamically", tunname);
> Would this be b=
etter as `M_ERR` (so we can also get `strerror(errno)`)?
Done


https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2170/comment/e9f54917_63675fc0?usp=3Demail =
:
PS1, Line 2924:             msg(M_FATAL, "Cannot query DragonFly TUN/TAP =
device name");
> Would `M_ERR` fit better here (to get the system error as =
well)?
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2170?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ab9=
59e7101cf801ac93e5185855e75db0fb6225
Gerrit-Change-Number: 2170
Gerrit-Patc=
hSet: 1
Gerrit-Owner: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Comment-Date: Sun, 15 Nov 2026 15:55:49 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>

--kW5/ncGRn8s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by Gert Doering=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">View Chang=
e</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2170?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The=
 `clang-format` filter doesn&#39;t pass for this patch=2E</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170=
?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">thanks for the revi=
ew=2E  These will all be addressed in the coming v2=2E</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2170/comment/e58577f5_433a5dc7?usp=3Demail">Patch Set #1=
, Line 2900:</a> <code style=3D"font-family:monospace,monospace"> *    the =
first free device, ask with devname(3) what you got, and</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">This says &quot;ask with devname&quot; but the code uses `fdevname()`=
=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2170/comment/d1728bab_8b8b2506?usp=3Demail">Patch Set #1=
, Line 2911:</a> <code style=3D"font-family:monospace,monospace">    if (st=
rcmp(dev, &quot;tap&quot;) =3D=3D 0 || strcmp(dev, &quot;tun&quot;) =3D=3D =
0)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">`if (!dev_node &amp;&amp; (strcmp(dev, &quot;tap&q=
uot;) =3D=3D 0 || strcmp(dev, &quot;tun&quot;) =3D=3D 0))`?</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
70/comment/9deb7199_b68d9c7f?usp=3Demail">Patch Set #1, Line 2918:</a> <cod=
e style=3D"font-family:monospace,monospace">            msg(M_FATAL, &quot;=
Cannot allocate DragonFly TUN/TAP %s dynamically&quot;, tunname);</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">Would this be better as `M_ERR` (so we can also get `strerror(=
errno)`)?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2170/comment/e9f54917_63675fc0?usp=3Demail">Patch Se=
t #1, Line 2924:</a> <code style=3D"font-family:monospace,monospace">      =
      msg(M_FATAL, &quot;Cannot query DragonFly TUN/TAP device name&quot;);=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">Would `M_ERR` fit better here (to get the system err=
or as well)?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">ch=
ange 2170</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2170 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Sun, 15 Nov 2026 15:55:49 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--kW5/ncGRn8s=--


--===============2480968177121832572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2480968177121832572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2480968177121832572==--

