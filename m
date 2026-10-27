Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C399606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kJhdSJAL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ut/z8kFB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lriz8Bj2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dm5F2mJG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tqz11J45SML1QeI8+KZrId2MD41np/O2lNVivUBcxNw=; b=kJhdSJALbk5/T2XQGC0O/hUeG/
	Yhg0ybhGDRdnWa5t8jsxIXYjQ0wa5Vtm9SVRf/v8v6j3Um4Pm0rV9ClqklmFCu+OPaeukAjmj4P8n
	abhtCafKvNdNeXJa5+k8IK7hq1lAk09rwssxvJWQWS7RMAoemXQuJytFJ7PKh82xwOYk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLerw-000000008Cm-1MmZ;
	Tue, 27 Oct 2026 10:57:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLerv-000000008CQ-1znJ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:57:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RmU/PSfKnsp+xoTmWzoiDAY39A3njWKLVyiqnkKh4v4=; b=Ut/z8kFBimTt8yknLPEvmx9kfa
 +Wm6QnLtHmauDYndCH6amDFKNt0gcEzSR54nW/2RN74ebNgWdE/cd9P7SU8IzLINcIpTbN44BYhCr
 OcWOPFXERMkTYaV1Vs3pXxUN/MtWtcZRbP747NoiPn+Crc5g80Ll2KignD351522Ajws=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RmU/PSfKnsp+xoTmWzoiDAY39A3njWKLVyiqnkKh4v4=; b=lriz8Bj2UKqwvveb0oHW5eNNEC
 1HuI4KHAGtHMtslIHz6SXQhzCY+0glb1G13ohUtG67B3C3rJvBSId33iZsy1LkvpL8dOI1JkjX00R
 FL7rmIK6WW2Y022cl0hmbPFD0phKiUKKe7LkPpGz7QvkyORfb8TLUjFF9Fd4mqyyJLvg=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLert-000000003la-14Do for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:57:27 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so3630535f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 03:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793098639; x=1793703439; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RmU/PSfKnsp+xoTmWzoiDAY39A3njWKLVyiqnkKh4v4=;
 b=dm5F2mJG/QLose21Mff2iFsGfMc8aimB191MT2QwD/MDeWCiBZX2XuIcE/YuYTiEKz
 Jf0G0z3+5inlgyBrRxGbSEE+i+rUNDv+cZ6vI9yQnnTlq/t+VTZN6rjXY7h1k1Vy0hvo
 Tov4ltpQboXgRAVtIlD/4fMyAnWpJ362KAGIGqZZPTdH5fJG0fgl/nu/NU9vncYXrZw3
 JVS3/IEtk66DzRuKnOnL3xEouAeCASnHjhCxJ9yFYf89LDx3y8gaHjXpYzZN0dmKKApv
 bBeG1QC2yo+C2Cre6ii7MxjOMNQ6wXyrik2lqB1LwNe3gclna5X54raGc1NbvK2HBTHl
 irbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793098639; x=1793703439;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RmU/PSfKnsp+xoTmWzoiDAY39A3njWKLVyiqnkKh4v4=;
 b=WZ+1cvz8aqOEocaF1Nn34l7QrmTTNDqVCmftIzFjsh2NkSwZ0AlQihf5p0zHsGrQ9k
 lseKzELgdTT3SxI2Zdt83DVwQvWo40n8wEmlNgr59K2BrkwuUylOOlw2pUT7ft1RrMVe
 EbtE+inFZ17XlGTQnT7+M/zx7QqSZE3j+0M7A/pXxAGbuS+7sDR1vTibYHiH3SK9CBL8
 bBK4+ZX83BezLFPCXD0yEtf4o8v1tMJ0AqP8L7pKJ3IRwiLY2CkCClAzRKXSNnP9pfOo
 AGDMm52s12zULNdsioBmUYgy0EThZVtbiEYZHly0Xr5rvSNKZuxMrukbb+aFrG/r4Pox
 jDqg==
X-Forwarded-Encrypted: i=1;
 AKwUvByQZpaU9oOw9XAnskbtS9VX2ld1/jblJamjLk5Ck65dEKonkPrMjXiVJC8/+2/lrKF4yUFs1avS0gPl7CsZ@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLEnP7vVkrzFCFA5hyYeB9e4CDV86SgrqLivoZ8yLQZ/QofPCbs
 amspe5np1fRwr7Bz6/XKeypoTBs0GgF/fOawXiL/RqxwSX7krkiAeqeh26jlx3QNNCSs6JX+JfZ
 +xMphpCX+MJCPDwPWzucEUNtYvS65VAMrsar/oqRw125f4evVcIcnwvF/MsIshD6pvjJD
X-Gm-Gg: AYBFou2gJ0w+7/6K5rMxCfzdHFGVLnlI6MW7SRXtBGnf2xb07TyrM6ig9vmWdmdcdam
 t6f8+EsouuO5p92nqF7cZwohmsfzy2Vn6fRIVJKeDWsw2HDJJ5darDlJRyM9SSYZSo5i0GEiycD
 PNAqIXMF4JK/bOn84oW8I/JjaYheI30/FlLH4Wd4R7xxA/DdlZHBQkegYhC3CA1AW5WArA9OJa8
 V96lroeCkG4hvVbSUOxX2kMCZ8cAiGc0wFyhd3L2EmasL/6x9ZG07a3d4Vv11Pl1JowO2W+clyC
 3Wiw30cQ+m0ckWC2VrJlfXMGAzkHhYnkKnEWrMHF1tmzvZj9BO3mfL4ntVVyF7lBBCuYhEHoLBd
 gDSQGYrkR92YomnyLtNjwVkCPa3KrjKRGXZpp+UcMc3cvD1pzN8CGuR8aerk/GV91n0MUXYsBWq
 XE83+jI/R2u7S1kc79Wr/5MPycCgXLLIPkA0SjPaoi4BrH0UufwKgBha600+5oFfamyGOrshXqK
 LI5vqHnjXcDLE0strlIFd0JLd2oaU/F51IP5cYEBgEBtaxRhVkT1TmwBVJaKCx9J6Qbb2pb6DUD
 xFuw2P8N92PPQYBg6vZp8eEaCdlYYqmMe1dKHY8dYViALRiJ0BJfwxIynNDsp2gQ8bMP3Sljebv
 sWEJTDuQ3Syqs0ZeDCvWq5BSC7vuchTiLpndDuYUVbw==
X-Received: by 2002:a05:6000:40cc:b0:48d:f069:570c with SMTP id
 ffacd0b85a97d-48e3eb93429mr18502897f8f.41.1793098638548; 
 Tue, 27 Oct 2026 03:57:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece13aasm20549513f8f.58.2026.10.27.03.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 03:57:18 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 10:57:16 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20
X-Gerrit-Change-Number: 2045
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2045?usp=email>
X-Gerrit-Commit: 0ad283c0198adbac3713822bd4c00ef5a615d7b6
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 10:57:16 +0000
In-Reply-To: <gerrit.1793094393000.I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20@gerrit.openvpn.net>
References: <gerrit.1793094393000.I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkkyZjQ5ZjQwZTQ5YWY4NTAzZjVjMDhjNTU3NWZmYzlhOGI0YzlhYTIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <06705c8296365b314b25b4235dc5866ee5ad85f1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLert-000000003la-14Do
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: walk the
 link sockets once in multi_io_wait()
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1241819329049627067=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1241819329049627067==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yFLEax8gKAA="; charset=UTF-8

--yFLEax8gKAA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2045?usp=3Demail )

=
Change subject: multi_io: walk the link sockets once in multi_io_wait()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2045?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2f49f=
40e49af8503f5c08c5575ffc9a8b4c9aa20
Gerrit-Change-Number: 2045
Gerrit-Patch=
Set: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelb=
it=2Ecom>
Gerrit-Comment-Date: Tue, 27 Oct 2026 10:57:16 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--yFLEax8gKAA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2045?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2045?usp=3Demail">change 2045</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2045?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2045 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 10:5=
7:16 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--yFLEax8gKAA=--


--===============1241819329049627067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1241819329049627067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1241819329049627067==--

