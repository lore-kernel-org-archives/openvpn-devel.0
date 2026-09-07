Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BB8C79F9E
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q/KVS84iKqWmY85bX08isJXOLqVszkZv+34p4WtS6h0=; b=gennTeS6VBTJyqtyycw56q2bJ+
	D8oDmcJbcXeIJil6txUn8ZBud7Qdh9bScHozo4S9RYNEEQ8yt6ksHyDCAGbbSL9GO7hdSK9bqf2tC
	ljevnJGQZa9XxlCi/KWL9e5Miw1DmCMNqPRlfJnA68xvXsu8PLiN05rxCYtELHBH5EhQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3ZhN-00055H-9F;
	Mon, 07 Sep 2026 13:47:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3ZhM-00055B-6G
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 13:47:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ymDciRY9Q1xthTdFvv1FLqYoXSTFulMT3B2nJNXDW+E=; b=Ats3pkO7Bs7RDqslUrqQxdwSGa
 DHkXVXHb4UZcrLb/ED87zFgEBhdGvtRS+AOXCKH4HOyD013WtBwbQ1MMGu/pIFip9LEgpGTbi4LRE
 WIYeVo9nOBGSHctsh6B8YmwWMZoAeL2VEdACw6vZ44HRCX+U0jDVymDLD3NTcX61oqSc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ymDciRY9Q1xthTdFvv1FLqYoXSTFulMT3B2nJNXDW+E=; b=H
 cbRPXdONg8FptUDVy5PhNhNVptw2s5Y2+UUybm0UehO/RMaxB8MlmaMhryZqwv1vGUoLaKNK0yghy
 25cPSyUxJDtOmUdcXezCVD+tr5UY/Pgx6wP0hgXgxP1hZxqEAoDClM2rpUEPNv5AYwbILSLOcuTr5
 7PWB5vPiGE05Xd2c=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3ZhK-00063t-EA for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 13:47:48 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4843e397f74so4434810f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788788860; x=1789393660; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ymDciRY9Q1xthTdFvv1FLqYoXSTFulMT3B2nJNXDW+E=;
 b=OHVXFIsbAbP2q8EJpmychXQeA4FnNazl+emIcNAmqYU7mashHR12epVtwdlE8vTr1j
 un135QKcfH3TvePefH2uE+n3XeCIcRUlBn/ugJj1/F/W2GEklNZhzS+vCCVBYSoSSwYL
 nprYmhElX8s9NthUrk3dIGm4x9HWwFye/b7nB4boRapn1DIYH3txNMyw1Coxch6rr1Ga
 9DaiBBIomkHv4l82r4B/kDBM4ooyk06fE6YHs+QcbKUF+a6OQYmq+bnRDjZR8MBJgMAK
 6bS+ybX4XLBi2Filc/jxm8KlzK7VXQ/SRaDGK10huxpBT4hZe8l8XPagKH9CyCtKoAEL
 0j2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788788860; x=1789393660;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ymDciRY9Q1xthTdFvv1FLqYoXSTFulMT3B2nJNXDW+E=;
 b=Y5Y9CIAXRckhbWWlF9SPDYoz/RLlbtHqXK+GWn16oIac9qMUXL6fPAhksNBlFvop60
 GEWOinoRgfVisAVVVcXjLam0N4OmtdoBqCHHVeULrVZTGyVAc5mX53rGHa7KgnpckYBN
 tOctm77v0v0DdvsgI3+1CslzTNFxndh40B1x9TnEAK8TvuFWdtZkyMw4SaOfcwewOxSb
 R3HUcPIjXx2rZ+QmGV7Vh78qKp2MFb5L/DLW485p4xB3f5KcdGfXcc/E/pcxG8kuItMi
 r+kZHXFWNU6CwSYPL0FMcBimaWowbVONaONnI1vNXvv9/zXaVDdOuhcYFsX1L7NNnVuP
 1mpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKDIrlvz/CYo0oIodn/nhWoAv5HBXtE2PGFga8nefHDKfXA6Cwp3rdp1hBYE3QO2K5qW86lL+x/MAytnTo@lists.sourceforge.net
X-Gm-Message-State: AFuF++n4bV4iDAFv2eia+0WANk4rJUfOyQN+5PnNrLpEndD5RBHBwyAF
 jyiVHI+6hb43gcTWSaOP/bfAleOMzUuVd45qPynRqWpVS4m27NEsaiwoGVd/3aq6pphyO6p0Zev
 JzhtSX6jKXNhoa/UJEtvx1stkm0tcankFyLYWrvP3nWAjDeZ6zhxKxRV9fsGiS1UkdPft
X-Gm-Gg: AYBFou0TZI/SyV4voHfJl9VTgdc8jOvD796llq7lUoIPwMDOmLSokAhKduRdu8lctwh
 BXTmW2wdeSBHjPooSL7o42TCvgOS9uA8xf+YZTzFRgbhOhP6G/CjgywxJh3CtkZrjtXlNbi7v4V
 dSAnAZXp7S9Isys5ojMEVvv+Dy924Sqad7WH/d5MwFZm1Onwa3gTgPQ0hUufZDg2d+eZZYXpDdz
 I+G/nPMJmejiNNJLG+zhExE1Dlri6KMWQ3imfj9uW4MeOWN9l7be/ZyzluJmi0QfPF9MAuFLrah
 euItpfie00wMcurhANMTpghgmTSTShGr0OdGjE1S3WZtLilj18hj0W7RwPc1nlmuXzDODyCLyOu
 OMihEA7j/q/1mqP/TmWGzWC9ktjEoqVUs5WhJ4sRpJyOm1M2z3fL1umPGSQs49Fg4w3tdA0pADI
 mZHmNUrNHsKwVT+k4ts8yj0Z+cmjTSAo4rVaIn7l8zW4Kwtzx1shbNDKtFcgiriWvdkxpMIXnYi
 aB7xGYrJeAi/NR+hFhQSl6ZLt8solXg0K4CgcLUk1xjKf4DVyCb/cJu3U8PLnsw05qC/RNN+W5k
 gxTv7aYoe5gNVL11HcByzGCTddcyEkKcw7mUzK31w51QwbRdiBw=
X-Received: by 2002:a05:6000:430d:b0:485:8226:c698 with SMTP id
 ffacd0b85a97d-4858226c977mr28752030f8f.23.1788788859711; 
 Mon, 07 Sep 2026 06:47:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885c5bbdsm27079009f8f.36.2026.09.07.06.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:47:39 -0700 (PDT)
X-Google-Original-From: "syzzer (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 13:47:38 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
X-Gerrit-Change-Number: 1902
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1902?usp=email>
X-Gerrit-Commit: efb1f77d28be164260bf4235949ee81f9aff5124
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 13:47:38 +0000
In-Reply-To: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzgxMzUwMDAwLkllYTE0ODFlOTRiYTFhYmUxOGMzOWQ4MWNkNzk3MTg3Yzg4NDI3NTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <538bc928d290f4a73690ca7bab65b9aee22c7b31-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3ZhK-00063t-EA
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.7]: Check for
 null-bytes in certificate subjects
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "syzzer \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "syzzer \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8755865435090945280=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8755865435090945280==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="suKqpuy3hn0="; charset=UTF-8

--suKqpuy3hn0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos=2E

syzzer has posted=
 comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1902?usp=3Demail )

Change subject: Check for null-bytes in certificat=
e subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1:

(1 comment)

File src/openvpn/ssl_verify_openssl=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902/comment/210ac99e_88f02f74?usp=3Dem=
ail :
PS1, Line 389:                            | ASN1_STRFLGS_ESC_CTRL);
>=
 Hmm, but that still changes user-visible behavior, since we now no longer =
escape all the other contr [=E2=80=A6]
(Where that last remark about using =
RFC2253 is about master, not release/2=2E7)



-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: release/2=2E7
Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571=

Gerrit-Change-Number: 1902
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-=
fillinger=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: syzzer <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit-C=
omment-Date: Mon, 07 Sep 2026 13:47:38 +0000
Gerrit-HasComments: Yes
Gerrit=
-Has-Labels: No
Comment-In-Reply-To: syzzer <steffan@karger=2Eme>
Comment-I=
n-Reply-To: MaxF <max@max-fillinger=2Enet>

--suKqpuy3hn0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/ssl_verify_openssl=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1902/comment/210ac99e_88f02f74?usp=3Demail">Patch Set #1, Line =
389:</a> <code style=3D"font-family:monospace,monospace">                  =
         | ASN1_STRFLGS_ESC_CTRL);</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Hmm, but that stil=
l changes user-visible behavior, since we now no longer escape all the othe=
r contr [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">(Where that last remark about using RF=
C2253 is about master, not release/2=2E7)</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Dema=
il">change 1902</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
902?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:none"> G=
errit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1902 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner=
: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@karger=2Eme&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 07 Sep 2026 13=
:47:38 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: syzzer &lt;steffan@karger=2Eme&gt; =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@max-f=
illinger=2Enet&gt; </div>

</body></html>
--suKqpuy3hn0=--


--===============8755865435090945280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8755865435090945280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8755865435090945280==--

