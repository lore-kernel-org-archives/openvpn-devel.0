Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17298606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZpZtCqwl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lNmFAvAO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hssodZ7n;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FLDimn0y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=J49curDEgpndRTauXRZ/AYrn3PlFeEZrDA51zEoDwxE=; b=ZpZtCqwlrGVLmwIO3xmtKrvSsH
	Q6I0v5UwJay76pvh+WD1XBsKrJGSLy1+3Z18v0kYj8yJAWMccz/fyoCJDqKYX1HIZmp/3QxEGvX1w
	Q4MhbYSAOzJ0lNg3fMu2K5GYXYT26q1fUMpL0wFV5ySsN2n3cF7cKeR4aZ7yVmrzTl9U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOYgS-000000005zc-1tqP;
	Wed, 04 Nov 2026 10:57:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOYgQ-000000005zJ-3yZQ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:57:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LYrZc9K2S2LFCC7uugkTDTZJSZUakyTL8wSWH9schXk=; b=lNmFAvAOQHM5rV/VZi6NsJco+p
 XyC4xRy5uoygQSCV+K2New+o9si94j3spBtCUvH0mzvoErOCbJxDNXXrM08cfxxJDaehfjuPJCZI4
 uSufFhJBuNK99cFezhvN9BRIhC3/7N4hHH8M+n+oD65564EnUWGOyOW6HYBJY6aWC9Wk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LYrZc9K2S2LFCC7uugkTDTZJSZUakyTL8wSWH9schXk=; b=hssodZ7nyS/qo3nUUqnj2DXQ0Q
 enoBXayumMRSxVhjmfjYZS3xeMhCrWURRqxLwVktFak1TTaKzEIcZKiAeSuMgmcKu6mWPoQPV03gm
 VTYwZXGLYUv5n41AILl8QR96n3mEdRG5llpqrJKQGtExmsk34epbpyk3XoJgSzdbnPNo=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOYgP-0000000068W-2MKt for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:57:34 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso5287825e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 02:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793789847; x=1794394647; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LYrZc9K2S2LFCC7uugkTDTZJSZUakyTL8wSWH9schXk=;
 b=FLDimn0yLyWPv1KyCwlYN6YdsrtUTJpE0iyzIwlSHNDw5zGyKpP+b2e1fjE7/7AvNX
 zgmmffL2T1frtEMu+uskjxqj8dpFO8HwJ9KEuEuKBw0I4AUxNggvO2cT6OgICpjO2psY
 Wxm5MqqDPhKr/N4IYSHBrYnsKlKTBCx5BMj+Gp/P1MX8Koc+ZqNsTeEFAEJ1W2NC+Jug
 9a3K1EFi24mi/LOdKBv2KJzhaNkoWVwvT6V1nCZ0Ibf0UsLeYU+InPqkq3bZwiZX8VaI
 fpEQbWZ0vx9Ie10A6XHRMV9u28iUnJfhyMm2Ch0bMSa2HZAY0viVsUyQt0/bwnjOeIkD
 lt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793789847; x=1794394647;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LYrZc9K2S2LFCC7uugkTDTZJSZUakyTL8wSWH9schXk=;
 b=YMLtSZgiDqHV7RODXZJWwPBU5lvgdsYDbNqNfL9FHrN0Y1H6qiIaJPQiUcfmA/MlzD
 h8lDOX9+nplQm665zR07yGniArDOWjWdyeMQ24qdydtzKHkxREK2rHzk/eA4907fTKRX
 Z5wIduSx6Uw2Oe+zP7n/dKc7ep+vpN9Koi+W3ee6Rn+PQAPY5Go4cTjsF7Y2WotzdLGN
 ITBjCrRVcINfnZrrgb3TEC6AtKKYIINKvcBSlh2d6NRlq0DgQdVb5YGBOImBU3x/Xm+3
 Fh3nKdXUHFzPNzCkoYfNpHLFRdDpOyZ0lvcowj+DE4DWo5YJuUFhtRBCChg76swHpfY2
 wAVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8/zrUJNJr3IeAmtQ8w5espTaPbTKw6YVsOnTH42GwpdSUG6aYJ54nTfxUa8DGsGYwa+FAtvgBjGC9HS7S@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8j1baKxQUgxc0gMvLursjfWk05UKrDa9Kzck2FpOtRMgCEI4J/
 XeeJBboACWuzfj9jDWpIw68JuNAE7aw4Z2oR7RfWTiIEpOGT/HJCqKVRHXb9fLnq4vfzBFiowa7
 uQMjKxB1CP6Q2HaN+eZxFBfqp1bYl7D66Yr2q8FU5BUlJ5xG6lMZHDCBP/OhwDSV/FOk0qhvAm9
 3po6swGQ==
X-Gm-Gg: AYBFou0EQz/PEKoeQC7m+sOAkNEJONvGcFD0RSDtilbSOe05s2Ew6bZjuY73Ngefg2u
 ZKlqp0c8+o4uW53B1znriyIkROc565wtzctkw56UHibh2RRZI6e07a22nqht550nZ6h2fjcos3/
 nleFbEe/BXoLYoqZyPPOhviIoalDVMF6Tsngx2rY296xvgkLeqrGwugf9igJYB8ueIAnEwkNJK3
 CMAF1KZ+C+Z4UhYMtalS3gEe5eLnTflAKRdM9aB2N2njHvVy/jk/lvoYzufat7mcDIT/cYP6nyW
 L5kITu/lHA/lpmpUH5uDvZ3iSE3kIh6uG+YwIqiXZQ6dsGzjPskhfKQnM6dXKm6M9C+a/6wp9Ux
 VW0fBZyag42KmhyW+Fop3N7iYf6zqW9Mu+7ccdFy0gBIEzsA4McqsQY5c7JwXPz+T5v3TwoiqDv
 h+jSGOpI/5DBiuhkPNRiYSQDGVXYlaWChkX6zdviU97HyRjl3msQuHMW1Q3kNrps2EZ4KoLl91a
 Yh6H/JVJ9GLue/4EElj5WNiAl6TW5EHvZFxptIiR2b7hExOq+HU2Vtqk0sh3MMY8mD4iVB37ZsV
 cJp6eeAXxxe7fTPBbAFtqsTCm2KP6QKm/QKwoFqvCzLUUiunimFVKLhPaur3BikeC5QMhz/+Fpy
 41VPNzL9E4Mcgat8SPhOCz46W+H/vKwjmETgKg/ZPaX/EjE5MwPJrhbiyO/gFvosuQzRDrp3UcN
 dWW8QRMQnu9j+rvA==
X-Received: by 2002:a05:600c:628d:b0:4a1:9663:7633 with SMTP id
 5b1f17b1804b1-4ac17d16b99mr353510925e9.11.1793789846855; 
 Wed, 04 Nov 2026 02:57:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b40ff10f88sm37029585e9.0.2026.11.04.02.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:57:26 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 10:57:25 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5542520825112dfd64aab332bd76333b74d7fec0
X-Gerrit-Change-Number: 2128
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2128?usp=email>
X-Gerrit-Commit: ea64f4bcf2968e0d4a935fd6882326bacf599193
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 10:57:25 +0000
In-Reply-To: <gerrit.1793782065000.I5542520825112dfd64aab332bd76333b74d7fec0@gerrit.openvpn.net>
References: <gerrit.1793782065000.I5542520825112dfd64aab332bd76333b74d7fec0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzgyMDY1MDAwLkk1NTQyNTIwODI1MTEyZGZkNjRhYWIzMzJiZDc2MzMzYjc0ZDdmZWMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f940452a08d3504e0bc61e2512e3ff557edc4b99-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOYgP-0000000068W-2MKt
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 return freed token groups from GetTokenGroups()
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
Content-Type: multipart/mixed; boundary="===============3523250289156682727=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3523250289156682727==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xcw64Kn0J7g="; charset=UTF-8

--xcw64Kn0J7g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2128?usp=3Demail )

Change=
 subject: openvpnserv: don't return freed token groups from GetTokenGroups(=
)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2128?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I5542520825112dfd64aab332bd76333b74d7fec0
Gerrit-Change-Number: 2128
Gerrit=
-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Comment-Date: Wed, 04 Nov 2026 10:57:25 +0000
Gerrit-HasComments: =
No
Gerrit-Has-Labels: Yes

--xcw64Kn0J7g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2128?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2128?usp=
=3Demail">change 2128</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2128?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I5542520825112dfd64aab332bd76333b74d7fec0 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2128 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 10:57:25 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--xcw64Kn0J7g=--


--===============3523250289156682727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3523250289156682727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3523250289156682727==--

