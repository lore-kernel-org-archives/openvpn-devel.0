Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87236082BC7
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YvDrPTta;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GfbCAhT+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=b9A3S6YR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TvO+Z7EX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BQB5lpMp5aRTVek3+tJXDxLO/qLx6ICIlrVFq0Jb/hM=; b=YvDrPTtarR72wwb5Pfao0FVf+J
	2BWBN8h0WQ80rnpqJ/GPBN66kE/VdKe2o4FksxPH+LlcvNFHjKPOmeXjTMKzYBSCAnjpYCjAn3Tk2
	2nTikwKkJmuWRrqHLreD20OV+sYcIEEBJD040uXJtiadaYzXX/4edXzpYj0lKXaWERSU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOCpP-000000002GZ-1RSk;
	Tue, 03 Nov 2026 11:37:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOCp8-000000002GJ-1bYN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hZl1dolDvgb6jY3rWaYzJCsdthW0ClaDKYLZsh0dqy4=; b=GfbCAhT+LPfCoNbEDwn3PQUad7
 Bok9GoneDNsq0YfCd8uUv0WZKegOGoccK8tbZF50OCqq/kHpidVuO+Cmuvvm88KbFEA3HjCceG95a
 jvmyTRswxtuhQTU42TYN8y5VNvwErTwQkfloUZClQfYEIs3s9Q+TqH2hirOOZVFYTDXs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hZl1dolDvgb6jY3rWaYzJCsdthW0ClaDKYLZsh0dqy4=; b=b9A3S6YRDeoaJMiPKd9T+/9ng1
 5V8hqrBH2ooeLTTkr/bG9Ar9ui1ZJSXV+3/pIc19/fWEebu0VGcot5jeiY6om37cs9M4WjWE22vKj
 uGweC3mDxzS+EgvLqzTrSd9BHXQ3bI4vDBKEvIf0flIWg99xKCFinPG4v3MlmI3fOqJY=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOCp7-000000002M6-1tV0 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:37:06 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso2837773f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 03:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793705819; x=1794310619; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hZl1dolDvgb6jY3rWaYzJCsdthW0ClaDKYLZsh0dqy4=;
 b=TvO+Z7EXQGBTnWnk689cd9hAvYrXhiriie1hQrVS8ee9Ew8A+JatQlv9WVkIckJMBy
 +xtAU5yVhZbwmDdE9ANPqgfhMJVLMzxG8xrARsZ6FT/jaatBk4V0IDcX7FkrhAHJ/PMj
 kr9hrap4O3r41E8F31RHnh8P2L3PzuRK0o7IXtiA2BcpogeaWK9ufk33Pw2DNTCfjoOq
 e9coCzzFNhV+fa0JhKExuQ0MqaFZjXnHD1gJyoLZ1P2ODKNAmdasHt8+8kzPrheTGwmR
 U91liduP1B+hHh2YVMN6DUYpcVKBKqmOeaLkjJA93BK2qLbOcbMxeN/65blwYGg8vY2h
 1vFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793705819; x=1794310619;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hZl1dolDvgb6jY3rWaYzJCsdthW0ClaDKYLZsh0dqy4=;
 b=O3iPGsqkTjFeDWnbNfJLxTlr7dwmYKClUii17AqE4QX9iR2yEiGr01y08lkF0IH/Oj
 EG0dymo6qDPMldJi9pBQTM0p5hEKCD9S6XABzL4gfV3oA+VbUTElGMoFMxrDVv/Q9AqS
 Add9Dkt2jwFZwQJzVZ93+HpPzPTIA94zFro6WR9WNw8qmyTr2kGj6Fh9Tcx1hHDIqHMO
 J1uT7gxol+2Ckad0G9DWodEbSl7g1EkiDtj2Y6ET1LQlMv29r5lGkYIqjI1p5dARmvH7
 0cTLJZvLkgtdJE7VaL++JSAvu5nVI3VjmSztckqXldLAJeUgUn+9YU0KgMOozswkkrfP
 IEag==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUHRhte9D9T6muaSTmfsuTLl6Fkexm8Jpmuo9mbv0MF/NY85+tDiiCIc+NZqqIZf5v8FTOsXaZlH9UOWNZ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9cxEdN8OUE06Rej9EmfMJdhVcbNi5tZ79zej3pgDGpiLvIUcUs
 F9NXDnMUr77EG/3ykWa2hOiy6XcA89EDRG/AebpBdtIUF6LG11haceuGkd0fQLSut2VsT5ZkNH2
 TAM3y8EI90M/XWZcV69FtzrZTMiwCM09O8iuhUZrmNxmrrsbXX++FV+RVReMh/byujOTO/YuXo+
 xnW0RhAw==
X-Gm-Gg: AYBFou2DVgtH+mhtzBu0sEMOWgJYrNmw3DynifodzfPqa8kxTTRT9j2LnSbpfPFnxa0
 Be8Vk3kJG44KIErrMEQiEVBglREpLdkv39jpkG2RwVK5+ONuXSl0laCAT5t6lqPquQIYJvplOUq
 Ia4DBffP42IDswa+hGKj9krfBDgTcHEQo21KBM8WrKf3M9wKIn+0BMY96dAWtgfsr3lJmri4ZD4
 YIy4q/sddZX/l+dcDrOeoXdDCeItS2rSHMNaWx/tr54xPKRV+aD4O8at4XolkJGN7Lj+gZsZKn8
 YROtzqJUInzILsvnHnUcfNm2ZIgRTVGYiyQ7aWJKQO5BbtDmisB/3f3or5KSqgoyuhwTMADnJbt
 166CNJjc6oWu/uE5FapY5n3sM4lUJrME5PhKybS1JpYwHJZpIvlvCvtNmv0jQlyf12s5xREMXtO
 GSEASDxUAyF/S369R6Orxp/Zve4AS5zJ8Q4xBOJrvNPsTcAO3Hm2M/btBQw5NQr3QnU2+no/pc1
 NUyR02XmevpVQvSRdETCLpE/9osAe+Zzj8OzX8bmV8416viqdkWPHFwOzqVZ7YP+3Agw2dWY5tN
 mpNZu7mge3MQOTvj1ogWizR/juaj7nww/D+xr9RJaJA2C6xDAJRbO073yGqp22inaZ0apDd3aJq
 8Btg7sbOR/u3hOeyn6X/cE4/3kegFaluRwv/ZOjT7swhiUqA6DXkB+HZyIgcKAbDSVDzs5qKGD3
 aBDcn1BkvxYdYaBQ==
X-Received: by 2002:a05:6000:4027:b0:48d:f3ee:7cc with SMTP id
 ffacd0b85a97d-48e6e4f4cc8mr27097703f8f.30.1793705818732; 
 Tue, 03 Nov 2026 03:36:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b728f9sm24560325f8f.10.2026.11.03.03.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:36:58 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 11:36:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 672bb8080dde7a781ca6000f014c241b6009e283
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 11:36:57 +0000
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6c8e711e0920dc7efceb0cd9f837cb8f8a37ab28-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOCp7-000000002M6-1tV0
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove replay-persist
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6544762993495003029=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6544762993495003029==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YFFL5oxNit4="; charset=UTF-8

--YFFL5oxNit4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Gert Doering, R=C4=
=83zvan Cojocaru=2E

Arne Schwabe has posted comments on this change by Arn=
e Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail =
)

Change subject: Remove replay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

Patchset:

PS3: 
>=
 cppcheck failure [=E2=80=A6]
Done



-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2082?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
Gerrit-Change-N=
umber: 2082
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ed=
e>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Com=
ment-Date: Tue, 03 Nov 2026 11:36:57 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No
Comment-In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede>

--YFFL5oxNit4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Gert Doering, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe has posted comments on this change by Arne Schwabe=
=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3D=
email">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2082?tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> <=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">cppcheck failure [=E2=80=A6]</blockquote></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2082?usp=3Demail">change 2082</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2082?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93=
815 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2082 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Tue, 03 Nov 2026 11:36:57 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--YFFL5oxNit4=--


--===============6544762993495003029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6544762993495003029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6544762993495003029==--

