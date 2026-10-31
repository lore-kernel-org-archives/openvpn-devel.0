Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286F606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=N1IT5hF2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bDHOIbSq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CrKoYzry;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ee9mOzY/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RcTf+Go6JIDN8xMJQ+dyFyouorFPV77/JxjTS7OfQz8=; b=N1IT5hF2vPxC4qWgWS9OHyIrCl
	FhkuW545P+QNuByNx/tsKwWpboPbj7n12c3Ym8tN+7FjUuEhTb/ugegCKUC7FTctvgnQaVKLCAGcx
	1ywq5gkELliSvAMBEhdaMcK+wL0ThJlvI+b0Zjd8OMUZPaxb2+fPRNEFPnDvvZEZ44go=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNBi7-000000007qp-0CtV;
	Sat, 31 Oct 2026 16:13:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNBi5-000000007qh-2ePp
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:13:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IqaNKu0/F2koMyYWEOfLnrMi4gLiDQ9o+uOZHql+xZs=; b=bDHOIbSqaW3Ris9rLDWqgeMyhY
 MU2oMesUM0sjoDx8DSSzAflocGdcr1FFC+Bd/93B2sOxbWtF8pXbi5m9OMorTOrD2GovB+VZeLx4L
 982kDFS0gazhZ+l7P1xGpq6uW4ND0IngOdEHxrFGelL7GmOfovelLG3OhvPucJ3sDB6Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IqaNKu0/F2koMyYWEOfLnrMi4gLiDQ9o+uOZHql+xZs=; b=CrKoYzryrpAENbb9TwDLrsWnbN
 Z3eDPAA77wTf0lzxud7aSli7wii/kx/K/Z4887lDhS75G2oZgsr8314+BVbhVmI/j5UIwOLG5hOtq
 tpkWWUt9ZctWbOrPtCoXuDei/pMz9ymTH3Wy1UFm/xEUvPmr5yDKFqNzXWXvheqyHjj0=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNBi4-000000003cN-3t6i for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:13:37 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so9787885e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793463210; x=1794068010; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IqaNKu0/F2koMyYWEOfLnrMi4gLiDQ9o+uOZHql+xZs=;
 b=ee9mOzY/VL/QICoWdztG/fUb1uVMq3tfl6djVqMlqpIECrjNvdQWlzK+h7rJ6kDI2g
 ARx8aNyHZ/aFBUNxq0chDmDRBCmOwl2g5qFzpVDxsMV6aD//xCXqvKx1Ia64Ex19jhRs
 AJTqekSNekZhgNR8p1MjbrVZ2MP4+btdNqIabrjQ8Mptdh1zo8wMD2Qo3ECxZrsABNAc
 psCDWXqsDhImDao1WmGUnPLvUAO68kTLS50kf5CuordBkdWONIilNfVAsp89QMT59mdC
 /WPxzwaTSaUhjN3SM2gK8PKjUuQV5tHV0+P3WEPK8v4dGHB6BNTIdxjaQT8AmWcPs9v+
 aSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793463210; x=1794068010;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IqaNKu0/F2koMyYWEOfLnrMi4gLiDQ9o+uOZHql+xZs=;
 b=fqXEunn4rRvTIsgHWNoMO5muMzkX0j/b/1tvd53R1IEnA+6qd5dD4WbvDwDAa9KlRT
 B6aYt+KBdUhrBzQEvFL6X+3DQPAOsQuzsVvI396CQWAR30HDvnN+bObRTjhP6cBJ7nTC
 eJ8TGW1IUQWGnP5UQ6h7jevyEShoS78osjAt6Q7QtEEbxoKYhI40iuKM/w7/4mRPWhaH
 vRAy445fJeLT1GjXm7xE/jkjwWT1OGtTB2ma0hFlJDxtKPIt9zvMifaKxE21thjlWHj/
 V3CDSPC3h9wqTCTozP8vT7M1uMxH3H6etGEN2i067gw91U5+pmD5XVPts0D6s29fc8BM
 jX7A==
X-Gm-Message-State: AFq9FYL5SsDlNKTj9wbbbBd+c+5X9TgBlBZE9Uvf7dHagRZyLx07WV/t
 saKjLtnMTFTMfX67g14eDWR1SFvs87fQWyPZ9q/WfC4IgjSsJBcGz2uovCrpTATip+RGO/GoCtB
 bn9q19cr5JqV2wqOnulxpYJ+qpPzmMLZaauzl3jz6S/7CeO9+9R63ulsnkiqCBU5FU3Da
X-Gm-Gg: AYBFou1wWKYrCEt3pE/NBXfNB1bLWnlivMgm8U1tXNI55XySwq9s+Z2LtclrCRovmBT
 EdZgLS8yE5MSq8pCx6yN8chaTb1pztuFH/+VvYdCXriXna966xT6TmaYU0EMUKRBsTEuZSZG8IZ
 1rRmgqNBG/juzJV1wb3q54H/zjKLKBaITbDHcRzeVTrd/dKemInm+fDNjiiDVVmz/byzjec0syQ
 tlay6aRNYV8n7ZBlJ8+DdRHTgyYJ3OcQG2jzG39EMN0rtHJ0g7ztaNiyWbpw23NLdQHFfGVRUEn
 4UQ8Qj9FrE/UWPk0uhMDHgEZUjAiQWklGiUOyW898qJQtU3iB0HScqbRrH1WMljIg66WqWylRhz
 FLcWJMKlZnsBbN9rdHAwaicjoiatcSW23AakTOK+wfnYju1k//qaz4SVU8Vv3FSQTluzSJAksqY
 tJwmJlyqWERDqa+1pIPwKWs39Cl3UogzYIslj2SN3Ezixi5WPFZwCjqyyhf/S9I4TcXv2W+DDIB
 esz1OxkWzq9bDtejLKGV/dFIrI8szja7D+kofwBx1FQ9cmj3Jy5DaG+8HIXcO32gMHKabnqNtCC
 MO3IptSIKI28en7LKN+HHru5WnT6PTnxle6kxTr7yjg0kmH/uSjr6+k5ojWnBrw1pRYCVDA/s31
 xZ/3ecHYGwtNBkrudkdV6SrAUGEY3Jds7lr9hz6op3MpukFzi5utGXjG+BdXeeAcX3h8/BSQF+M
 fhKNM+KaPjANVfRUo=
X-Received: by 2002:a05:600c:6095:b0:4a0:1b21:2628 with SMTP id
 5b1f17b1804b1-4ac18b7e1c1mr120694185e9.23.1793463210051; 
 Sat, 31 Oct 2026 09:13:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b723b4sm9894283f8f.17.2026.10.31.09.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:13:29 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 16:13:28 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4
X-Gerrit-Change-Number: 2058
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2058?usp=email>
X-Gerrit-Commit: ba6967b7f023651c42e32b0d4f4b5279692e0778
In-Reply-To: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
References: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTg3MjQ5MDAwLklkZTVhMzA2NGU1MWQ0YTIyZjkxNGU3NmMxZDgxNjVmZGQ0ZDAwNWY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c1ee402ad44b35156ac2650d24bd805482fa14b5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNBi4-000000003cN-3t6i
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Mark buffer invalid
 with username mismatch in server side float
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7844805569211510587=="
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7844805569211510587==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AMBkcvlnG08="; charset=UTF-8

--AMBkcvlnG08=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#5) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by R=C4=83zvan Cojocaru


Change subject: Mark buffer invalid with =
username mismatch in server side float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Mark buffer invalid with username mismatch in ser=
ver side float

Commit d42a9912c1 introduced a check to ensure that also th=
e username
is identical for floats and not only the certificate=2E This che=
ck did
not mark the buffer as invalid in those cases like the certificate
c=
heck=2E

Reported-by: QiuYiati on https://github=2Ecom/OpenVPN/openvpn/issu=
es/1137

GitHub: closes OpenVPN/openvpn#1137
Change-Id: Ide5a3064e51d4a22f9=
14e76c1d8165fdd4d005f4
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Ack=
ed-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2058
Message-Id: <20261028122226=2E3006-1-gert=
@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg40227=2Ehtml
Signed-off-by: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
---
M src/openvpn/multi=2Ec
1 file changed, 1 insertion(=
+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/58/2058/5

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mu=
lti=2Ec
index 2e804ff=2E=2Ef211ef3 100644
--- a/src/openvpn/multi=2Ec
+++ b=
/src/openvpn/multi=2Ec
@@ -3172,6 +3172,7 @@
         {
             msg(D_=
MULTI_LOW, "Disallow float/connect to an address taken by another client %s=
",
                 multi_instance_string(ex_mi, false, &gc));
+           =
 mi->context=2Ec2=2Ebuf=2Elen =3D 0;
             goto done;
         }
   =
  }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ide5a3064e5=
1d4a22f914e76c1d8165fdd4d005f4
Gerrit-Change-Number: 2058
Gerrit-PatchSet: =
5
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--AMBkcvlnG08=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #5</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/205=
8?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Mar=
k buffer invalid with username mismatch in server side float<br><br>Commit =
d42a9912c1 introduced a check to ensure that also the username<br>is identi=
cal for floats and not only the certificate=2E This check did<br>not mark t=
he buffer as invalid in those cases like the certificate<br>check=2E<br><br=
>Reported-by: QiuYiati on https://github=2Ecom/OpenVPN/openvpn/issues/1137<=
br><br>GitHub: closes OpenVPN/openvpn#1137<br>Change-Id: Ide5a3064e51d4a22f=
914e76c1d8165fdd4d005f4<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058<br>Message-Id: &lt;20=
261028122226=2E3006-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40227=2Ehtml<br>=
Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src=
/openvpn/multi=2Ec<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/58/2058/5</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openv=
pn/multi=2Ec</span><br><span>index 2e804ff=2E=2Ef211ef3 100644</span><br><s=
pan>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec=
</span><br><span>@@ -3172,6 +3172,7 @@</span><br><span>         {</span><br=
><span>             msg(D_MULTI_LOW, &quot;Disallow float/connect to an add=
ress taken by another client %s&quot;,</span><br><span>                 mul=
ti_instance_string(ex_mi, false, &amp;gc));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;<=
/span><br><span>             goto done;</span><br><span>         }</span><b=
r><span>     }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail">change 2058</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ide5a3064e51d4a2=
2f914e76c1d8165fdd4d005f4 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2058 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>=

<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>

</body></html>
--AMBkcvlnG08=--


--===============7844805569211510587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7844805569211510587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7844805569211510587==--

