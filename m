Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0D4C982C1
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 21:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PuKjeev5SXPoSkOPwyl8wAkTl+pTvrdNExtHBSg1u78=; b=DHYZKProyvCVkhJ4rExtpEtXk2
	lBfRCuH6s38GWDgPMTDeCeg9bsMg+VzGojFOJc/izBAOB37XQ5W2EiQ3TMOGcnKfxZnKNNfUSRF6V
	5sHBMZ2lYOl26V/tFv4WUcRZNu1CmLgRUhDgwYto9fPoIfylOLb083seNwglBeas35n0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6xQd-0002Ng-0m;
	Wed, 16 Sep 2026 21:44:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6xQL-0002NG-MU
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 21:44:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=e+xCa28b/h3dlVrm81Qruuayxl6pyS1yocw045YWvFU=; b=XnFBBDWVz2kLVeKchAsYihyjCh
 u2/d1Ed+NruzFVutnQf93gJX+DVs8TRpsBW5chQvjFZN23E5bH8HMutHpksFn05soJk1bR/MAGCn5
 QlLzmyL4dhxbX7wkR9TLuUOAz8bQX4rOvDXGHPGA/z01OBEAe2vt7OHrCZyXucnlOdG0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=e+xCa28b/h3dlVrm81Qruuayxl6pyS1yocw045YWvFU=; b=c
 2Pdw3bfhQ+Bvo8IjGEm//6/uDaeov0FHrAxIBYhwUgxzhpIGaCIHVPuGF3/gNAcBA8esVu6vD5iRI
 wBtXanP+VPqua/7J1EUCHIfoH16z7e5imA4lqz8NokV+WZS2d1fbGU/0baOoQXjOfDZsJWbBwdMXf
 Iw1LJVyvMYA5WBjw=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6xQF-0004gX-QW for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 21:44:08 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b2522so136950f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 14:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789595041; x=1790199841; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e+xCa28b/h3dlVrm81Qruuayxl6pyS1yocw045YWvFU=;
 b=IeVnpOeKKFl4y1+WXFkaDJf9Z1da9hw9J207Q0Sg3pFFbmNxM9A9nOmWpdV7DyTCgB
 JksfX4Nv7Gl0PWyJtWVhl+q2wdSXQc224JPj10JsW0h01/KG3kg9ImGEWggN2lgYCEyg
 to+Wzdi4qjc8+1lzY/X8MhFEt9RxK8mQXT1xVfC0vcJqNIhDeQFreDD55RznulytyEx9
 3ctwYvjxxHQ0xzZgvrKHEblLpWheGD1WLn8o2n3tCvmYkP/G9W/Fy3mKQZt/PGT2hv5I
 uPnpTLPquHevFNk5LqSRn3ItGNKK6uPVmXTzu53b6HHaZCD9K8BeJRkgZcbFrEPba4lx
 gFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789595041; x=1790199841;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=e+xCa28b/h3dlVrm81Qruuayxl6pyS1yocw045YWvFU=;
 b=kKOB7XvK8vpDOi0H3cKoha28nzNKfh+OKSq/VVNBpM7f7+u3ntGrYjn2obJX2A37JV
 ikPj1VQPgRPca6+e2NVrXARGqFuD+dCupdWiHIbOifXai8GycVHdq7snRQwzyXr7qyU8
 B5Yo5FNWhOGrJbdfMBjoC6zSOhlbnqDWp0Cf54GSiSfC6ZXfQX9SYeYWSahD5f+fsV+C
 Pb5EyjjMrWuhszYaMODnqjbr3hVTCeopRjkjhD+4F7zkTQOee7m3HJRsNfKCfquISpFy
 7GdkIjjpAOxBEwINWpyLxH4cZd9+fnuSFBrcudfQWPkAbEnCP9MO9bUuOiJA1GoEqHtB
 MeHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxso/CJIdfT+VMVb8WpEkqOymfA88NoIy4MyDdqKrYsXZ1toBlRvTlbhO1/J5VEg0BvfbAvdR74DrJTXibm@lists.sourceforge.net
X-Gm-Message-State: AFuF++kzprgBCrGaTi4t/CZIR0aV5OfbK0xsAYInLfWzixoAfS6L9P5X
 PXBfw/W3O+24+2yb4p0mHt0TxihR3XxkG/CbeuepZwCohEeqItRPpY4m/VFpHiopbR7jOyi8NWk
 YwlH3+eqNga5BIer/yon6qdMvRKwI8TyuIzcWz4IYI9+jb5ATqPwbl/o5xVGrKFMRp46m
X-Gm-Gg: AYBFou2OOWngdUda6c19wAFO6RodZ0tZAXwf7jdgvgsQs4y8I9MwRhzVuN3P5w6Ized
 TOs961+bE98GJP7r7x95qXs0zbaDXVMT2U27wHrdmUAzWdlgI3nCdEGqItoFqOrDuVnPBMUh/nI
 K5ozkcbKSOL2J/EERUXzcemI2p4NhgguXBbsR/PeAz+wqKIrEo1XVUW0G1cA2aofymz6/WAJMFB
 vdvWxT3PcrhSxIaTFrWUbwVFmDp9s5jZxbP4pg33bAJn0XqKfHf8MWSzDV2Fjia35nNx94Q4oq/
 iJ7I1lDAWazcIpn4hkObxBEGiDWztztapBktcKNPxWAfttZD1nmUzx/czZi+UBHzPI13SeMv+7d
 NLj6k6JqPsnjF6zoJ8MLV/3L+0teOB9JBUUH4/W+boLQvIekh/5rqgWKAjAZMfv15G/cs+FQSkt
 V8YRltwp+96evZguR5bDcIl8i4n0CwtJOnq3VL8HkC9tskrVRaB/FpQNKokXxsdf2mIlaNZlbzX
 g+Ismy1wd4iEzdtOTgl/3otYqFx4QaJO3eAor083S63cb7TL6IKUO8VATEtUhC4R/5DgVGd2uju
 lOXd9eGF3Jbg/jiFCPOjol3JiB2E4xPew8p1ZK/nYL03frc5CvD4mANgfj1DkA==
X-Received: by 2002:a05:6000:719:b0:487:1413:c648 with SMTP id
 ffacd0b85a97d-4871413c6cbmr1277874f8f.34.1789595041151; 
 Wed, 16 Sep 2026 14:44:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf418dcsm9788117f8f.35.2026.09.16.14.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:44:00 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 21:43:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
X-Gerrit-Change-Number: 1902
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1902?usp=email>
X-Gerrit-Commit: 124c4ffe53af78ba007ffe23de2f952fadfc30ae
X-Gerrit-Comment-Date: Wed, 16 Sep 2026 21:43:59 +0000
In-Reply-To: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzgxMzUwMDAwLkllYTE0ODFlOTRiYTFhYmUxOGMzOWQ4MWNkNzk3MTg3Yzg4NDI3NTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b8a932c40e357654eb9bda0d73472a70868f8f85-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6xQF-0004gX-QW
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7776020026921626271=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7776020026921626271==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Rt66tRT1CRM="; charset=UTF-8

--Rt66tRT1CRM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, syzzer=2E

MaxF has posted=
 comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1902?usp=3Demail )

Change subject: Check for null-bytes in certificat=
e subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2:

(1 comment)

File src/openvpn/ssl_verify_openssl=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902/comment/9fedb878_47595476?usp=3Dem=
ail :
PS1, Line 389:                            | ASN1_STRFLGS_ESC_CTRL);
>=
 Alternatively, we could check for "\\0" substrings=2E [=E2=80=A6]
I change=
d the code to escape control characters again=2E I went with the approach o=
f calling the print function twice after all because that way is less error=
-prone=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
902?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: Ie=
a1481e94ba1abe18c39d81cd797187c88427571
Gerrit-Change-Number: 1902
Gerrit-P=
atchSet: 2
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: syzzer <steffan@karge=
r=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: syzzer <steffan@karger=2Eme>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 16 Sep 2026 21:43:59=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: s=
yzzer <steffan@karger=2Eme>
Comment-In-Reply-To: MaxF <max@max-fillinger=2E=
net>

--Rt66tRT1CRM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, syzzer=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/ssl_verify_openssl=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1902/comment/9fedb878_47595476?usp=3Demail">Patch Set #1, Line =
389:</a> <code style=3D"font-family:monospace,monospace">                  =
         | ASN1_STRFLGS_ESC_CTRL);</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Alternatively, we =
could check for &quot;\\0&quot; substrings=2E [=E2=80=A6]</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
I changed the code to escape control characters again=2E I went with the ap=
proach of calling the print function twice after all because that way is le=
ss error-prone=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">change 1902</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
release/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea1481=
e94ba1abe18c39d81cd797187c88427571 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1902 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 2 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-filli=
nger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt=
;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Wed, 16 Sep 2026 21:43:59 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-=
In-Reply-To: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"displa=
y:none"> Comment-In-Reply-To: MaxF &lt;max@max-fillinger=2Enet&gt; </div>

=
</body></html>
--Rt66tRT1CRM=--


--===============7776020026921626271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7776020026921626271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7776020026921626271==--

