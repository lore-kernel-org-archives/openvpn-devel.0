Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE1606A320
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SH8n2PdM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Qz8geLpV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hjDN/+xs;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Q/A2z0ot
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=osy1Cu545Gwv5QDdLiJuUv9ELvMyP0xyHvny/evneik=; b=SH8n2PdMlRtWnPCwObXVf5Koxb
	2f8aW7wQzYvhfZD5MdbuUIM3JarbTZ2kuOdrTNWEZFZWJgElSkp49SxYCQKEsxVjNhEHYusD41o9c
	+ej/EqLWC6+toQbElJn6vzr3xGIC0yB90SeCnCy7ZjUJLE76BIKPPmQOEaRFuzdiF6dk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLeob-000000006Qk-3JYT;
	Tue, 27 Oct 2026 10:54:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLeoa-000000006QS-2Xn8
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:54:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EK8J5TW7JUFmY23bdiaoUXYHWb0QXO9r9GlBka5oIcI=; b=Qz8geLpVRd3nShfmOfad7aiEd1
 lmq4QPGHvc6XtIGJScQF4PA+4zCsCk32t5UCqD6vT6QO55E4XraX167CtxeImlic3x6MTKtMLrWvw
 KuorQglzZ1OzrIFiipS2whPhxi1tX9XjGpTy7bpwfBEy7XQH6o0bW57RS9lOI1UA3T28=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EK8J5TW7JUFmY23bdiaoUXYHWb0QXO9r9GlBka5oIcI=; b=hjDN/+xsmCObDZqtpqDNZemiP6
 7lDgSayFezJZjCLbvgj9M5pcHWvVUpNCe4QUgSTLP+jtj8DgzINt2sBuMylned9A9cIa9ek5sZ0jS
 Ve754AR7RZOibFiBYC4UUiEPEbqHLIseFQYYLVzG2RZsxBbDzGp5of3byAMufU10vcwY=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLeoX-000000002qj-468M for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:54:00 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so27799715e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 03:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793098431; x=1793703231; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EK8J5TW7JUFmY23bdiaoUXYHWb0QXO9r9GlBka5oIcI=;
 b=Q/A2z0otKXmaQaCBJXtuDCJXH8wMiEPR0ZLVtScoO91jb36Cpf3MhHewhxPD+i/G15
 e+tEBKf7YoTSp9YZIayN85CCkmNXiTuVe9yFG1PVllEwUArUXeijHkZR+DsqNaIyD0/R
 Nsz2audT+ZuGxApu6yegj8EAx9KnpW5zf6Modm99gQcMjpims4RiyNxxWhsJGwyQGkmC
 6BXYXPfhFDAm7W5iLNSNkgYbTRgigihOy+bHMDPT9SUdyjAjAlpSCajipkZBdovuocpN
 CB/QtNwW35SgI6ntC50TwaszsrayhaVjutTxLsMouceFjzpcPX8zhf57M+HULteyaBu7
 qeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793098431; x=1793703231;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EK8J5TW7JUFmY23bdiaoUXYHWb0QXO9r9GlBka5oIcI=;
 b=2aaTohQ0EnDwXSC2GRy0kI+p86Qx+TCC8zAv1ImllzHYqwwPghoa94mTmFlwOYWhg5
 MTYeoqo+frzwPBDMeFWR84YHJINDszjbpmLCOO1ZebcS2VrxmUrKC9rmRBIiF3dlUCc/
 nMd65jxNybOKGzbXsYkDUf7mzYB1mxx2MMO9DYRGtUEA0B17skv/d+1lr77KhE2YI9+v
 /9xljqm/Frh9IiJnWHo9+x7HmbkRx3Hkzln3NRUQne4JuZU8Xtis7DpQVC8+mPYjXVHI
 SkZhsrbVtxoZd0GAVndpCdbIAS14Cif5AxaIJ2eM5JQ3SF8kQTqche1Gi0XwAqniprsg
 75Dw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzU6KNbk2MJykP9y619PyZS6QhKs4cTorNdSH9PJT4+2nZd8RapKR8+tmbzqIZmO0R6KW+/dBPUr0VfMmDj@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL4tnmGpwnX+yB2JRNVzExYVN71fBfz3sNR2hUgqG9xeQSWaP13
 uatoLQ95nmvhK8Lc0ATsvVYFAHv7ms0Q9a/TrfBJ0SVnZUnLZXVBCop32GnpptOB1crVUAG61CV
 EdPmRVDjdXitxRGCrZExoG2mGGFNml4go0KNnl/xril6FpPg7d6TtWnRY7wgd+naQCIxQRC4bqg
 xoaPfI4w==
X-Gm-Gg: AYBFou1x/GMxI55Oe5JbTWZ4eu6My9lMOBJrJmcIuIE1k2fLB+3f0Ji3h0172RH3fJG
 otquOov/bOS260G/W0wNC3MYasVNof1ccBsnufhC8lC/GEXjTeYrqVHQFGifkLER196bE9wHndQ
 HBYMsM9DCPGMs23mCrzZaaxeAW72HzjH3opvUlIhD+J68XgLlLTnFavamT53AkL+cMNwUqvfuZ6
 L7bjao5XvAmOewm15lRVYKWydaZ26y+Usi0HPeuOqo58sLm+XwU2y0nI0EvCdpjU65SX8e6IJ2h
 /0AxK/mAvIKJ5/RkLb3aCdjVBtbb/qaSaT/FVDfuoTou6fYpngGwKsD5uXNwuafzwC/mwigI9rS
 OuN74H5xaQcw8riDtpkx/73bTZcn0oFq0BUZOuhZboWEaBPSwQt4UuyB2dOtbxhDtd2uiVAvQkb
 Tygrx+0oiSSuJnd1jcJG7QhHgfG7mGmyDOhFCInGkWLltP0Unz312iJ15SbkYh382KXfiPOpokG
 kRSAUJppy9BgzayCjfEsurtHS/odihW1X70ZpxKjZhqAoFvtt4HV+ahi6AXz/ksVRRggZZadUjo
 zwUEej72BOaGz2uyiqlB3XCdyWn2fY5am34ztOaMDmyPIV5lzfasdnf61XcT1RzuYW2w+Z0sEvk
 9CeG4rNtEOKM80Lcnsh7MaUxcyjDsEE6Tk8lyTpgdHA==
X-Received: by 2002:a05:600c:4e87:b0:4a2:1867:10e8 with SMTP id
 5b1f17b1804b1-4a35aca7643mr199535335e9.25.1793098431131; 
 Tue, 27 Oct 2026 03:53:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a55e9aasm266900345e9.5.2026.10.27.03.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 03:53:50 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 10:53:47 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1abb10515665e1d6351689d2c2dd9d4aba8bb98e
X-Gerrit-Change-Number: 2044
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2044?usp=email>
X-Gerrit-Commit: a9d5ae77fc7c73581ea13272333dc6cc7c37dfa0
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 10:53:47 +0000
In-Reply-To: <gerrit.1793094393000.I1abb10515665e1d6351689d2c2dd9d4aba8bb98e@gerrit.openvpn.net>
References: <gerrit.1793094393000.I1abb10515665e1d6351689d2c2dd9d4aba8bb98e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkkxYWJiMTA1MTU2NjVlMWQ2MzUxNjg5ZDJjMmRkOWQ0YWJhOGJiOThlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f2ca61a0a5ac6b29ff53576d0e427bf7872bc1a9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLeoX-000000002qj-468M
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: drop the
 read cases from multi_io_wait_lite()
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
Content-Type: multipart/mixed; boundary="===============6494571591790777598=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6494571591790777598==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U/qXCGKGljo="; charset=UTF-8

--U/qXCGKGljo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2044?usp=3Demail )

=
Change subject: multi_io: drop the read cases from multi_io_wait_lite()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2044?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1abb1=
0515665e1d6351689d2c2dd9d4aba8bb98e
Gerrit-Change-Number: 2044
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
Gerrit-Comment-Date: Tue, 27 Oct 2026 10:53:47 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--U/qXCGKGljo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2044?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2044?usp=3Demail">change 2044</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2044?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I1abb10515665e1d6351689d2c2dd9d4aba8bb98e </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2044 </div>
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
3:47 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--U/qXCGKGljo=--


--===============6494571591790777598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6494571591790777598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6494571591790777598==--

