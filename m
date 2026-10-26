Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E4606A31F
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q+k3ky6e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iG92hPqN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=i9C7isPO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RFuysWdy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gf2XohoqmWjU5ZVC2gWg1oR1Yy6DwS7l7BGEmI/WeNc=; b=Q+k3ky6eKm80DqMOe5V97Cavos
	VjaO4wBvaVT+Y2j4sXGPIcdc1D6ZptPD0FOGSJ4dKE8IGOiI/VaCvmv7D/od7oSdxkf7bLSt0KeLl
	IabJ65mu21NxHxHxiCSEvA7YSKUG0u/sRpIqIgy7731VSbOJps8htrYpbopbnNzEe2kc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLG4Z-000000005DT-2UJC;
	Mon, 26 Oct 2026 08:28:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLG40-000000005D4-1t7k
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 08:28:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t2rVik/Ovh4Eh+lqNNKi+0HXKUITkFPljJdxqM1/Uhw=; b=iG92hPqNNIqVF3aMtXuCgD7zrK
 nv3WM2xb84MFUNtsnYu9OXknLREmPJGyTUbTFX44sYwwNHo825koFi6Tsr3VWpLA9dvYgGgOCKe8/
 ISvIWUKOILC5J0BPTASRDVRpkesy/aDMWWZDaOQnKQrr7H2KBSFmj2uunqtovn15DiD4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t2rVik/Ovh4Eh+lqNNKi+0HXKUITkFPljJdxqM1/Uhw=; b=i9C7isPOJa6hEn8ll3DTgsE0w4
 l5RIdUlzIkwLrnfF3gNETGZlW2I9auZgmfm7/3uy3fSwTvTHdzCTSj1qJIuA0vRuMaaRfDrA5fkXz
 Efd6QT4vtdWp7McAsk1zVyzcT2lnxpKrszotfZ4bP9xbCR2WfTC0zTetO2a30pnMTXQ0=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLG3y-000000000tu-0wXD for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 08:28:16 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so6790895e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 01:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793003288; x=1793608088; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t2rVik/Ovh4Eh+lqNNKi+0HXKUITkFPljJdxqM1/Uhw=;
 b=RFuysWdy26mcggoNuEz4nxjXCWZ3A2/NnrB5BCJrXAK1pRqN6XbSH1T0//g6R3EycD
 QJYsd7LYXIZpPb/g6cLUtYv4Ho7an0JXzGUBcVIED5Wd4Wpu2SdRqjGDOWtqVO2rHq5w
 As5syzBPXE4orFQ+SBJxOAJ50NQMu/mcnWrElOsOlUS8HOrmyOgNCCQcNuAIuNQUR+3b
 VXkFMQfrVzla6dujVtngxKdGs5dRKR5ANcU9ETe8gBkm6UA1LE/8leIjPduLG/mu2D2J
 cpo8YINyUKYmdCnHrJhHIhQDtH6X7fSEY+y8C7e5TlZeDpuV14k5BoWIypzpk7ezuYGX
 GI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793003288; x=1793608088;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t2rVik/Ovh4Eh+lqNNKi+0HXKUITkFPljJdxqM1/Uhw=;
 b=0jUUZDOI4ojV79TGCr7nbfZFLOTXBwJKgtM9d7tp+idmT9HBrE4DRXe6JdLUDeC+aZ
 cr6ukPaaFrs0lVR4aXZwHl78M/838pM2I7N/TRVnPZXpQfwaZlGuV+zoKvm3zQULVcgr
 IXYY1JAPYu6wCwugtBWlZ5JYhycZLJizH4r8Cx1g7HXdoThKhfeQIkcbS4DGXJ1ITa3i
 LjcsROuRlpcE2WehrqNpI5yfmCdJAjtjpcuMX2bYP/kMRZFqwD2HgTksb/RwTcfGTl4Z
 yXODCWU+hVfU8AryIYd8QVFg+lMGVd0Xoh0i206HhbneGM9f/AaiBG7+2i9xG1n+cdMt
 rwuA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQE1fPHkniX73or2vksQOUhFYf1ZZfY5bivFGVsnB6kSSm6mJnQrtGpJZaJ8z8kooFJymEhTL1aUA8AEpS@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLVUbX5dl3dKg4l5pvzOrtr3TUernY20BCC4n/r795yOojf+ysa
 Q/oGt4WQVPo1awSXgDbfvYLOYULSq3luzWSPgGuINB3DqaV/l/vAqQJGA6GABzR4zy7z9Rhh72F
 /crHtxjlYFMfyGlIR0olIqlEQ2hZFsoqbwWxvpn6iWay95Fg50HK6XQQY1ZGLCA5k2s1K
X-Gm-Gg: AYBFou3yeXBsJ31elHEGHAXT7eBfeGqVX3PuD9N50zshAGznTcTYp7c022QkiR7LJE8
 3z+aKxI0X4A1VasaINFeZCf+oThWkewDK1Q7sFEIk4Ksq/2cXGcbE2DS0F16pQYphkQH3uk404Q
 3lvPsuvxXHibVlGagrwzmlth7fqgN5sEHFLygQqB1urqO49eAKFvPtOmm6acJEGBX/wpDEhXULl
 CzSxo4RxYUUazcUpBoKMphE7NjfgxHOvsCcNZcDxDCh73+B/HXPLbWQsvSp4kWEyQ02qV2vDMIR
 6l/aMphWfo5OjbUXtj1LxDQKFRb6lDJoYiLQYyRKvKDRbP0zjmgKjA3dJaSdEowlfO03h3ZqEfD
 4EvHGHYo8lcEvJVjIvEx+lY/YzSQu31zsozNsq+XbImyqnmistcq+aEiWD2gC02RbF1bCuo+d10
 uQyhd6E/DGZV4sCPlqDZLIqlS1ChPP3F9u0zwMnjgbLd7GGv494jvSgV2iZg/goqH+9wuQ82Abx
 WcMrk7uwXUns1zI+WCnSiViG8bB5DpDzyYEYZ3ydVsxXt1IhbAcAjmIyf/qFvUeY3O1JCWrJssa
 9p3UlAQ0i/wmHuVDLcyWVnqFW+ConawbNkYQvjF7w8VsLegXj7U/Slbbn2CHNTnGYzsixxdQGo1
 GPa5TjGf2G08pLyvEUBV6WxTiKqUU6Hcl+SjNj2BfJw==
X-Received: by 2002:a05:600c:5253:b0:4a3:59c7:f226 with SMTP id
 5b1f17b1804b1-4a35ac8b40fmr103494015e9.6.1793003287283; 
 Mon, 26 Oct 2026 01:28:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2d9280sm175683935e9.13.2026.10.26.01.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 01:28:06 -0700 (PDT)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 08:28:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: b4004c28690cdc057f33573ca50e018eaebe0baf
X-Gerrit-Comment-Date: Mon, 26 Oct 2026 08:28:05 +0000
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bdc537e78798bf4cbaa9f6f486a30cb5de7dda19-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xLG3y-000000000tu-0wXD
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
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9144559273625106321=="
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9144559273625106321==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eCUmxnfgCE0="; charset=UTF-8

--eCUmxnfgCE0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

R=
alf Lici has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail )

Change subject: dco_linux=
: enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(4 comments)

File src/openv=
pn/dco_linux=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/=
18fc9953_035cb648?usp=3Demail :
PS1, Line 573:     /* find the last separat=
or (either '-' or ',') */
> aren't we actually looking for the beginning of=
 the last number?
Yes, we walk backwards over the trailing digits to find t=
he beginning of the last number, which requires finding either the last sep=
arator or the beginning of the string=2E I'll state this more clearly in th=
e comment=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/0944=
5d72_29f5fa9e?usp=3Demail :
PS1, Line 653:     if (page_size <=3D 0 || page=
_size > INT_MAX)
> NR_CPUS can be at most 8192, so the mask can be at most =
256x9chars, which is around 2=2E3KB=2E [=E2=80=A6]
sysconf(_SC_PAGESIZE) it=
self does not require privileges but I agree allocating 4K unconditionally =
would save us some complexity without compromising correctness=2E


https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/3fb66cd1_622665ee?usp=3Dem=
ail :
PS1, Line 665:     int fd =3D open(rps_path, O_WRONLY);
> will this w=
ork if we dropped privileges due to --user/--group?
It will work on initial=
 startup because this runs during interface creation, before privileges are=
 dropped=2E

However, openvpn can apparently recreate the interface after d=
ropping privileges, when pulled options change on reconnect=2E In that case=
, retaining CAP_NET_ADMIN allows interface creation but does not bypass the=
 sysfs file permissions (seems like you'd need CAP_DAC_OVERRIDE for that), =
so configuring RPS can fail=2E

I couldn't identify an easy fix for this sc=
enario but at least the failure is nonfatal and logged so the tunnel remain=
s usable=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/1304c=
4eb_b5c252f2?usp=3Demail :
PS1, Line 734:         ovpn_enable_rps(dev);
> a=
re we sure we *always* want to enable this feature without giving the user =
a way to opt-out? [=E2=80=A6]
I understand and share your concern and I thi=
nk a user option would be better suited here=2E However I'd argue that an o=
pt-in option would make more sense than an opt-out because this way we avoi=
d accidentally regressing user's deployments and then requiring them to opt=
 out=2E

If instead we had something like --rps-mask <mask> we could docume=
nt it as a potential substantial improvement (with caveats on some platform=
s/setups) and it would also save us a lot of this file/sysconf complexity b=
y droppin both CPU discovery and the current-mask read=2E We would retain a=
 complete single write of a user-provided string with error handling, and l=
et the kernel validate the bitmap=2E

This would additionally let administr=
ators select CPUs appropriate to their topology without openvpn discovering=
/inventing that topology=2E



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1991?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
Gerrit-Change-Number:=
 1991
Gerrit-PatchSet: 1
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Ecom>
Ger=
rit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <anto=
nio@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Mon, 26 Oct 2026 08:28:05 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Antonio Quartulli <ant=
onio@mandelbit=2Ecom>

--eCUmxnfgCE0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Ralf Lici =
has posted comments on this change by Ralf Lici=2E</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></p><p=
>4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/dco_linux=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1991/comment/18fc9953_035cb648?usp=3Demail">Patch Set #1, Line =
573:</a> <code style=3D"font-family:monospace,monospace">    /* find the la=
st separator (either &#39;-&#39; or &#39;,&#39;) */</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">a=
ren&#39;t we actually looking for the beginning of the last number?</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Yes, we walk backwards over the trailing digits to find the begin=
ning of the last number, which requires finding either the last separator o=
r the beginning of the string=2E I&#39;ll state this more clearly in the co=
mment=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1991/comment/09445d72_29f5fa9e?usp=3Demail">Patch Set #1, Line 653:</a> <co=
de style=3D"font-family:monospace,monospace">    if (page_size &lt;=3D 0 ||=
 page_size &gt; INT_MAX)</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">NR_CPUS can be at most 8192,=
 so the mask can be at most 256x9chars, which is around 2=2E3KB=2E [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">sysconf(_SC_PAGESIZE) itself does not require privile=
ges but I agree allocating 4K unconditionally would save us some complexity=
 without compromising correctness=2E</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/3fb66cd1_622665ee?usp=3Demail">Pa=
tch Set #1, Line 665:</a> <code style=3D"font-family:monospace,monospace"> =
   int fd =3D open(rps_path, O_WRONLY);</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">will this wor=
k if we dropped privileges due to --user/--group?</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">It will=
 work on initial startup because this runs during interface creation, befor=
e privileges are dropped=2E</p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">However, openvpn can apparently recreate th=
e interface after dropping privileges, when pulled options change on reconn=
ect=2E In that case, retaining CAP_NET_ADMIN allows interface creation but =
does not bypass the sysfs file permissions (seems like you&#39;d need CAP_D=
AC_OVERRIDE for that), so configuring RPS can fail=2E</p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">I couldn&#39;t id=
entify an easy fix for this scenario but at least the failure is nonfatal a=
nd logged so the tunnel remains usable=2E</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/1304c4eb_b5c252f2?usp=3Demail=
">Patch Set #1, Line 734:</a> <code style=3D"font-family:monospace,monospac=
e">        ovpn_enable_rps(dev);</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">are we sure we *alwa=
ys* want to enable this feature without giving the user a way to opt-out? [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">I understand and share your concern and I think=
 a user option would be better suited here=2E However I&#39;d argue that an=
 opt-in option would make more sense than an opt-out because this way we av=
oid accidentally regressing user&#39;s deployments and then requiring them =
to opt out=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">If instead we had something like --rps-mask &lt;mask&gt; =
we could document it as a potential substantial improvement (with caveats o=
n some platforms/setups) and it would also save us a lot of this file/sysco=
nf complexity by droppin both CPU discovery and the current-mask read=2E We=
 would retain a complete single write of a user-provided string with error =
handling, and let the kernel validate the bitmap=2E</p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">This would addition=
ally let administrators select CPUs appropriate to their topology without o=
penvpn discovering/inventing that topology=2E</p></li></ul></li></ul><p>To =
view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=
=3Demail">change 1991</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1991?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1991 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Comment-Date: Mon, 26 Oct 2026 08:28:05 +0000 </div>
<div style=3D"d=
isplay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> G=
errit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-T=
o: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--eCUmxnfgCE0=--


--===============9144559273625106321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9144559273625106321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9144559273625106321==--

