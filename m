Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79274C79F99
	for <openvpn-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ee/sOXttnePVIrrRF//caMaHqDuoClyfJMa9HehtOaE=; b=VkDwvRryjCYo8+jwrL8dTTbP7o
	a5wcr3YJz7NJtTlLT3jS9y2T79tTuKBTYQ/cMGe+2fx/1npNjHfOpy7H0V7bhZZRUCeM3nUikAFdU
	0e5yCGKwDNvfEDva2h3WxGJ4+d+9IADWmXuh1Fy4y8WsdczPPBs/l/VcLVKtwvqaZnOQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x38TK-0004qX-GO;
	Sun, 06 Sep 2026 08:43:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x38TI-0004qR-2C
 for openvpn-devel@lists.sourceforge.net;
 Sun, 06 Sep 2026 08:43:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FDLQRyPMjDAhMghm+k+zSHAirjI+rHgoPMTgRpVQtsE=; b=VWmzSC5Eus9irThvUZL3VDDiWm
 bZndg98iVYXRDkBD/c612p+5RlUUUXaeG6ek2H8upkFuxaRMVTWJuBCH405qaSeLDPxbJyz6tWnA2
 R1cVkAzWkF9sT1TvJUn6lEb9GWD8o+Wzk9p9qnDTqkjwV1XhdwHSXPLwvSLZJZEEmTE8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FDLQRyPMjDAhMghm+k+zSHAirjI+rHgoPMTgRpVQtsE=; b=N
 Ik8YoFI+00x3xwktdRb58yJgrzYKBEthVMNZUuELZWVFG247F4oCyhGUKtykWrMQrytzEFYgusKKk
 T2QLjAbU7f+0beHYwwPaWv5y/LhlE31HqMqqo+cpEIPeF7CD0LRZnhcIYu63jxV/psfmpc2oEdv8K
 VQMmHI2KPVxBIDOk=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x38TH-0005ez-35 for openvpn-devel@lists.sourceforge.net;
 Sun, 06 Sep 2026 08:43:28 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49d036e0e99so5241635e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 06 Sep 2026 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788684200; x=1789289000; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FDLQRyPMjDAhMghm+k+zSHAirjI+rHgoPMTgRpVQtsE=;
 b=EwXNAAyn4Kb22tsaPTh+X6jtPk4WFHDpONZ2PWFsgemHXQyQgjBCIjSH6LGcye846A
 Rx9biTL3U/MXD5Cp1AgqNK/9juRU4CVSaHu3IxEZW0cAv3cgpILH3CuQiMos8K3Axdl3
 jrf5yEEbCD63pV1nbJBU5QXOydYHLV+4TxNUoj6mtTEzSUZENS/wS1GjmTT6a2J+upVJ
 Yx96jFRDKjxX6wvA18aONPZD5kqFMERqpBAp1u4fDTxm8jwL5bTjcbgl0dxFmetToTEg
 rdiky1stCVQojrvSy5Ps3ovjTsJipJM0Hw+mP9EWxMPAhU5lomDbFk+ylNjWrIeo+U8S
 Xy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788684200; x=1789289000;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FDLQRyPMjDAhMghm+k+zSHAirjI+rHgoPMTgRpVQtsE=;
 b=JjMCFaMh3S+gauATxW/BDiJxCm4xycYfh3FF8ATnviy4La5A4hr9olwG7JITr5bID8
 MdJ4u5G3Jipq5q+R4MnPy8d8hW7EFJGmraccc0fWLNWJsrC9mAmwPWcsJ6OpvAeZbg1y
 IGSRkXzh1/SHCHKdVbFdyGoYy9cg+wUSAYtohL1D/pqAdNBHWs3BkT3uJG9Y3szWeMNc
 VjVQqw8SSyCntfWioeji40aVN0vBVuzyDetlmxELwC0dHSxblLNTXDD+QGVf5SKw+YPH
 WO771i+bvzVaXveWURDfEHFSKFRxdOFzB2/6P7A4TuWMwpA4uLgOfSBuwvrzI8+cJMeu
 21UA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwb9JpFhDFxoeIVvH+08KSBrQQNmT2snaMzyUVUuugH4Cm6Uyp6XncTsINLxh0Qed41XVY1sgHiTTYBFh0D@lists.sourceforge.net
X-Gm-Message-State: AFuF++m4AoUjqZPblz/JcX/Q0lgr6zv/R/kT3Kv7y68eQYAuJL+ZIFG8
 csN6cDGrGItv9uV4lEWDrVMJt0txBpbzeb4qXrywU1nziQLh1rWqBTrcFSQ0NuaqL4TeuCcwDf6
 ZmwwpIc+14+2lBey0eevhAt5oTwKXLGk2ZDRRcZ7BJl8+Jdrh+8eJrFjCPQb7GPHjJasi
X-Gm-Gg: AYBFou1FxIk7NCqrYTSmzwwJFrXHiFhG36+TvRKUG08uGGfrDg50YpxekwsBgNQRb4S
 Yirmiw3wysr/bGQGkrwCp4Crv/7d8bKJEBCUYxVqYMrFsK9oewMOwi6aMTGAuz12gOgqTf9ChA5
 RZsevQbMn1XsClMqB0oS4VDGNmHx7BKqkrLhwKimoIAMFwS05A/CbUU2g4WlVuT0TPAhJtDy4XW
 cH7vSiw4fk7HkEZvaebqk+v1p/BAgFuD6rR2RZ5dhu2uiSlwrmjCFlaekeKgggiC4/0gpACiXiX
 vWGR7JEUaDKbjImdqYn6LKZ1EpjCdRyExZsNxBmlh/wt+W3fqxKD4aT8pIQFOdE7VDlbdUe9i0D
 Vvr0QgKvLhLA9NV7Eoy9NEA3e+P1IfIKRtY2pnqU876k2MthtyvkelgOkLv8Nb8VXzwLMYkE1kM
 YrsI9+o3cj7xl8mBsRZsreJ+bdB/F91Kn3NopQX07aKnGfHYcnhu03ylAPPssvvNgHyw4oOWruo
 NIcuMNtl21UvkUM/gbs6+097UFgx0jRKEVoZ0HsM9FtDkUYsgGGMgeKNbHokAVtFbTFqUH/ABeX
 uCT5qxueSIxPZqvOV+I4Ze72UOTwSpHot+ISG+Y9gUVkjs3BVew=
X-Received: by 2002:a05:600c:a0b:b0:49c:cee2:1697 with SMTP id
 5b1f17b1804b1-49cf8262133mr164138865e9.16.1788684200468; 
 Sun, 06 Sep 2026 01:43:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d312ca0sm19040243f8f.4.2026.09.06.01.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 01:43:20 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 6 Sep 2026 08:43:19 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
X-Gerrit-Change-Number: 1898
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1898?usp=email>
X-Gerrit-Commit: eda13e5920b005cb50abb11bf776bb8e7cc32fe7
X-Gerrit-Comment-Date: Sun, 6 Sep 2026 08:43:19 +0000
In-Reply-To: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
References: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NTE5NjgzMDAwLkljMzM0NTE4MDQ4ZDZjYTU3YTUwNDI1N2UyMTA0NjdmOWM0NTFkMjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a3075178186af1802b86b59510e046c0957efc38-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x38TH-0005ez-35
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Check for null-bytes
 in certificate subjects
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0180702273681047119=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0180702273681047119==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v6FrXzLfMws="; charset=UTF-8

--v6FrXzLfMws=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos=2E

cron2 has posted =
comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1898?usp=3Demail )

Change subject: Check for null-bytes in certificate=
 subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review-1

(1 comment)

Patchset:

PS1: 
building the unit=
 tests with -Werror fails, at least on the Ubuntus

```
o/build/ubuntu-2404=
-mingw/build/tests/unit_tests/openvpn/test_ssl=2Ec: In function ???ssl_test=
_escape_rfc_2253_chars_in_subject???:
o/build/ubuntu-2404-mingw/build/tests=
/unit_tests/openvpn/test_ssl=2Ec:1020:17: error: unused variable ???expecte=
d_subject_mbedtls??? [-Werror=3Dunused-variable]
o 1020 |     const char *e=
xpected_subject_mbedtls =3D "CN=3Dname\\, O\\=3DInjectedOrg, O=3DRealOrg";
=
o      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
o/build/ubuntu-2404-mingw=
/build/tests/unit_tests/openvpn/test_ssl=2Ec:1019:17: error: unused variabl=
e ???expected_subject_openssl??? [-Werror=3Dunused-variable]
o 1019 |     c=
onst char *expected_subject_openssl =3D "CN=3Dname\\, O=3DInjectedOrg, O=3D=
RealOrg";

```



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1898?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic33=
4518048d6ca57a504257e210467f9c451d268
Gerrit-Change-Number: 1898
Gerrit-Pat=
chSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: cron=
2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: syzzer <steffan@karger=2Eme>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: MaxF <max@max-fillinger=2Ene=
t>
Gerrit-Comment-Date: Sun, 06 Sep 2026 08:43:19 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: Yes

--v6FrXzLfMws=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos=2E </p>
<p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail">View Change</a></p><p>1 co=
mment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?tab=3Dcommen=
ts&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">building the unit tests with -We=
rror fails, at least on the Ubuntus</p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">```<br>o/build/ubuntu-2404-mingw/bu=
ild/tests/unit_tests/openvpn/test_ssl=2Ec: In function ???ssl_test_escape_r=
fc_2253_chars_in_subject???:<br>o/build/ubuntu-2404-mingw/build/tests/unit_=
tests/openvpn/test_ssl=2Ec:1020:17: error: unused variable ???expected_subj=
ect_mbedtls??? [-Werror=3Dunused-variable]<br>o 1020 |     const char *expe=
cted_subject_mbedtls =3D &quot;CN=3Dname\\, O\\=3DInjectedOrg, O=3DRealOrg&=
quot;;<br>o      |                 ^~~~~~~~~~~~~~~~~~~~~~~~<br>o/build/ubun=
tu-2404-mingw/build/tests/unit_tests/openvpn/test_ssl=2Ec:1019:17: error: u=
nused variable ???expected_subject_openssl??? [-Werror=3Dunused-variable]<b=
r>o 1019 |     const char *expected_subject_openssl =3D &quot;CN=3Dname\\, =
O=3DInjectedOrg, O=3DRealOrg&quot;;</p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">```</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3De=
mail">change 1898</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1898?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1898 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Max=
F &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@karge=
r=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 06=
 Sep 2026 08:43:19 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--v6FrXzLfMws=--


--===============0180702273681047119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0180702273681047119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0180702273681047119==--

