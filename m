Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1556606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c9QrJJlH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZMFV9rOg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Fbi0tpV/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K6iWyJus
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PY6d5zmH8nNETFGRWV/69m5k4c6+uaFterWoEoEhtCA=; b=c9QrJJlHOCGd6Ycw2nN2HjxGbt
	ozOcHL6LC0gt75wXWtkldvptlrmHWZdyvr0vOLuftF4OMx6qMT0a69TLITxXX8yDb3CFc9VJPo8V2
	C0odmWFkGRcTOH7LfKafnOjbNJzEM2LyAbk0cefn6mgAYhVGebJRdwwVfVDEfjQh5KGY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWlMg-000000003gn-1SXw;
	Fri, 27 Nov 2026 02:07:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWlMb-000000003ge-49Er
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 02:07:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7bPG19X/gONn/nw9ZjqPHHD7NTYdpN0uCBtXnFwn4xo=; b=ZMFV9rOgwqa0NuH4mI1yPa2/1O
 33oAAGQXrZLbn8h6A5ofh3trMrcyzL1wQGyqZ9hrI5+QZGKvJifVP90PtUg9TQ9RJlxgVJOrgE/uy
 Fwd/I7LuYdufkLYbIbyTKYyV/RtjIiN4nmOTJoprwSFcy1cpoonbdeBRPZNs5BCcJiMo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7bPG19X/gONn/nw9ZjqPHHD7NTYdpN0uCBtXnFwn4xo=; b=Fbi0tpV/3k0rTMpK07iN7QPqL7
 aanEs1qONIjBETmk//B7cHqZnpZaJ1e8V/a/MUR+mABtUTDOzLw3cwjqcCIMEnhvHU76Bbo+ZB2ZT
 7fwBX9lH0fFAMsGo9fMuNWVoYUKfYleEvU++Zd4V8Wqs6+JTtjFkpyJIj+249ptDxuoQ=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWlMZ-000000002JR-4BGc for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 02:07:01 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4a32576da88so4378309f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 18:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795745213; x=1796350013; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7bPG19X/gONn/nw9ZjqPHHD7NTYdpN0uCBtXnFwn4xo=;
 b=K6iWyJussbLHC91J58AdELvElg97xfYqZkpKxM75rFTOqVpj4wgHfrIPUii1yQR2RW
 3u6tZcFJgdxSlpb5pMmqj3XSLjg3yz/QIoxEUmS8bY917kOgTKAp/ELAb1xIK932scvk
 wHErTY/F3ZbpDNQujVcTHFdVrdB+Xf47xaEHnheXJY+CZAr0ZGJw7CTA7bmtlz6DZr+8
 36VQIWYgLBf9eGmXMZTsXtEIKdzPbXv9fu91avJRBpYQMYY8cSI3Te7YjmFuLWGckPql
 w/InwXXTSZJqjrfAjSCn/WuPb3bW4R+3sQPnyg+OffgCPxBqR9B3IHHC/PTV1qdjjEPf
 jsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795745213; x=1796350013;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7bPG19X/gONn/nw9ZjqPHHD7NTYdpN0uCBtXnFwn4xo=;
 b=1rP2kHFlicy4ccN1ZKETKZC4t7CiVe5CFlL9NdPTGsG4m2HQQJAnhH/l7z/9Xi51Dr
 4/RjyQH0pbJ9H4neSFGuKoMyGJNK5IY7+BTjd521jGU4BNZuq+/sBe94blLoLvAGKwwQ
 xACDecCCiUoG/GPcXyCQrkHtFHXOS7nuLDKKJbwwRT4U8XgSTza8r5KhIklv99Rf2d9z
 s2/YaRMen5gufDgnKPgF/3CiqwEzjhK+aqroXQMt1vbZu4i6XfUW/3r7VG8lUNAoNxQ8
 Vgqfmo8dtHZmDNFgVhkBBVNMHUtK99lAaL6ZZKAk338fQ9piyGh3QpUqNbKG7XoP53WQ
 4oOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGeG3GogvEwEaVvQsBICaLRIvCuCVHUpbbwNaiA7CnpwV8kh3AfZZCaGS3pd0OuGmVfw/12IijsOnOhHWnc@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/jFYp3AO+tGy8abLp0diKSnCMISpF8m+KyyRFCZHEoRbVJMEl9
 H9pnTLyrWwJMDyeX0rGzX/cxzZWA9i83aamkLFv/VG8CukemR6fyNwnftLf1k6ulx2BuLNJsLO6
 wpNiGGKp0VLyyghRm8ralrcdagJS/bQipWpJYClzxHnoLwmLSf6SxT+KJippDFpmOT1jEbr/ZZT
 ISBrpCpg==
X-Gm-Gg: AZFdTZcZHcCyPT35tyMRaO3UDs1+GTu5s1xTXM918uYQm73N40An+DgrTu5lmMuyDMR
 m91evv6NSZO3zHZ4rbYi0sxVe3BTrbdtoHRnIqI3D3h7DVh7rgGPDcT9cMYpEh/LwXCHPG13C+d
 0xL8AUblZIaLO7p76iQZPE+r8fFy/hc8rBkSnCqlV9rLJl3ZhUfzQd8bUJEU5O8F/Sw1+zLpKes
 720vc+cugXp67TNvq0LS1Irzy1CBQuuiSQ8ZQ0irdJh/0qqY/nsiN8Wij44lE/G2Fo2GFhG5BGC
 1w+e5Sc9oevumTcwOxB7yKE3l2hUR40rdxMwxRIcK8NeRZl5gD/3W8llqKOCnYPcFeuJ+kraTdq
 Zh8HVpkGj7J7jwhIcqJ37iV+18NRpYXcZZyWUCZKYBkAXiqv1X974IzUb7Ow1ZX3JQcYOjphLD7
 3q5xjJC7cKumUP+nsgvyGlXXstJzS33oQE6gT5T+wRrJdteUc/4G+gXWPbRm7Inhrkpo7JEPYVx
 EtLv/2P5XeRTbPAzxvKS6/VwC/nDhvRNEEpvkjkrRBsHH/aMWtrQMuqYzeprtzHHyAfbS660Bbs
 i2ugNJKlqTXblokxsBeyOk+TUXSELg99//cPVpoakj9qcQrwK/jUYMZSdkC5AG0NuUQh3lzWvE3
 yzxsE9S6Sxvs30o8Xi6CEJVlToOqM/50angsRu9NYk4PfM6qF8+OViG/XWo2shiO7F7ds6+esIV
 r5uy3WrVksKSbxWQCk7q+kXEYQErfrBqb4/8tKJg==
X-Received: by 2002:a05:6000:1865:b0:4b8:75e5:301d with SMTP id
 ffacd0b85a97d-4b875e5306amr19619065f8f.0.1795745213334; 
 Thu, 26 Nov 2026 18:06:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab5ffcad11sm42400767f8f.0.2026.11.26.18.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 18:06:53 -0800 (PST)
X-Google-Original-From: "Max Fillinger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 02:06:52 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: restore
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6c6dfed1557608d5b1442fb008bf84fa4f948579
X-Gerrit-Change-Number: 2359
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2359?usp=email>
X-Gerrit-Commit: 165b8298c79e51ec1a92bbcf3c324df48879ced3
In-Reply-To: <gerrit.1795743323000.I6c6dfed1557608d5b1442fb008bf84fa4f948579@gerrit.openvpn.net>
References: <gerrit.1795743323000.I6c6dfed1557608d5b1442fb008bf84fa4f948579@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzQzMzIzMDAwLkk2YzZkZmVkMTU1NzYwOGQ1YjE0NDJmYjAwOGJmODRmYTRmOTQ4NTc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7e334a905b587b1a6ea52e53f5b178ebd82adfb5-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWlMZ-000000002JR-4BGc
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Reject certificates
 with too large serial numbers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Max Fillinger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Max Fillinger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1418787987113552637=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1418787987113552637==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vVENf9V7Lj4="; charset=UTF-8

--vVENf9V7Lj4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Max Fillinger has restored this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2359?usp=3Demail )

Change subject: Reject certificates with to=
o large serial numbers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Restored
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2359?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: restore
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I6c6dfed1557608d5b1442fb008bf84fa4f948579
Gerrit-Change-Number: 2359
Gerri=
t-PatchSet: 1
Gerrit-Owner: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>

--vVENf9V7Lj4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Max Fillinger <st=
rong>restored</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2359?usp=3Demail">View Change</a></p><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2359?usp=3Demail">=
change 2359</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/235=
9?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: restore </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I6c6dfed1557608d5b1442fb008bf84fa4f948579 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 2359 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Max Fil=
linger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--vVENf9V7Lj4=--


--===============1418787987113552637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1418787987113552637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1418787987113552637==--

