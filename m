Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F78606A325
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lOvvEiNK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JBPvwmRZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CYJGAiNk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OH504m9F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BXj0T5bZkmfu0VrcqGW66s1xC3usI9dP0WQbRG9autI=; b=lOvvEiNKE1eFoApVeieP1L8ihO
	qfW76IPDq0scI9JDBLH6xXRG65akCY0UI4/3xa8pjtkWhImIyMOmq+8ySWqdFtiBDqU2jReQRH/fg
	OPMUw3Cl6RjQMGRtYkjvm5/xFbQCzzZfv7FvQ5+ggXr+p0xUXcGGjGWfZruS5RQKNcx4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUKAC-0000000036G-2kzo;
	Fri, 20 Nov 2026 08:40:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUKA2-0000000035B-3Mcr
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:39:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZpNGW5e9cLTYHxa1JnYjS8Eun4ywFwvET0Wsb1JUQ0Y=; b=JBPvwmRZCde3WkkQUng0i6xECF
 73dTZwH5z5a3R5o/QxjUKUT95zWeTtSXZFYWhzPVcHgrmfOkobPEeLO4w3ryGa1rw8TOsxawussI6
 HhsZgRgzpDMFraU7VuQI1+Vn5fy9RYIx+jxxvPrzDFHYa4RIZ3JxYVzDmdItFpsF+mlA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZpNGW5e9cLTYHxa1JnYjS8Eun4ywFwvET0Wsb1JUQ0Y=; b=CYJGAiNk6568VUAN3HKJahKEKY
 8qb3wD/NrYZ59esIb3P9isGs5stlZctdo8FrkHlWSuW8OQnQQ5JxmJmx5fQn9cbx7sfKRByJVSh49
 jTffDJps7PgZJC7cT1V+e2QeClGmfK+dqxFeLLD8EKOwm42eSFtyqJRm1G8VNNgqktQU=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUKA1-000000000dc-0DTG for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:39:58 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so313775f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 00:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795163990; x=1795768790; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZpNGW5e9cLTYHxa1JnYjS8Eun4ywFwvET0Wsb1JUQ0Y=;
 b=OH504m9FgoYHBW8+8nymslF3L/ePDRent/KFJ71CPKJxD8sJJpUx3LCg/+lnVfHCMh
 Pb94b6vWSGGs0Z99BJWNKCYqCSEvZ8K0gAR8CvT9jS+NO53IV90AJsfLZSiU8SZsePMC
 qsj9PJKnuizPEMvmks2ohSpGCY/o9mTPC5gQ99PEzn5o7yTtOslu83cFwGvQTzKKLnIS
 997VPreOY1vrfDrdztKsp/TKxOvQnF38FwKwnSqOKl7dn/STANs+yXlbP5TBuiqF/v3E
 eTyKp8oUPHF7zlqwqy1o7fzS4S9M3d33/oN538KYD+x+CnQtD8gXOqTA2hawLiq7vCJR
 sCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795163990; x=1795768790;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZpNGW5e9cLTYHxa1JnYjS8Eun4ywFwvET0Wsb1JUQ0Y=;
 b=qRAx8DdvluApnXYwck1gfLd2Gp2Df6TuyUVMDye5T0HqBSr19XDtOW80r/SW7Wtqg9
 T1VUWWeepQqV4TrvzSHUtbF2DODQbN2aSArbQwRDavv3PGJ7H1d3sfoV158HvQx1r2N2
 KnWna55+Xc13B2PDljb8LAZgWoGAiLeD/gvuCGadoWYVVJ/4jHfOfD9xw1tvDeloBLqJ
 HuyfCVHHCOEGo0IAHtQFbm9xA4qhwMX3FK8+vybMf8+HYUAxWPm8+cVkaIt4Hlr6iESB
 6domBgIt/MIvGTpY9pVS0hZtSutTrhGp1BXnE+sPKbu1V+lgoxiWrmKOOSqgtoTN3KIV
 mqpA==
X-Forwarded-Encrypted: i=1;
 AL+hErE774am/l1I6RMsizqdWW1Cq5C3/UgbxIDZmtpfKlXJzvMyEkXy49AqvsQkAr8K6ggGzs5pCrTs0Jb/ikWB@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9zBnz9fpw1bLc+pcK9937oJBY2nIy6s/L8sjWH//+K34GB6ytb
 T117a6Ed8cTlLXuNBxKf6QKf7kT05qwZl1Ab7Oe88ZyCZ8yfLHN6qiLQq0MxisrtwCzVBMF9HgP
 hIbKKSZLJK7nzAnjAsBdbNpUm7ukdCjChEx2qWAQSn4P3cQE+zDrAtXfY9powl/SJi0qq
X-Gm-Gg: AZFdTZfvy9gXGNgaN0jU4bKxZKjlR2RPGiMrt4yuWUdGzL9WMcKWGhiIqoZrgLvUdgx
 jLxFffGmDDJrP89dRVQOM1doL5292UHDR4xOUadQlA5qG3y89xZa/lldSOO+0Kj5BIR2ClWTr9S
 ARELeh7+9t1ztyVXJekhUiC4FTPlXg1Hp15IVYb4GSkiXdW0N0xi6/Fn+F3sGI1Cqs2vbPvH1tb
 Jps6gZQSojrbuL89YCyE9wqO1ioPLoN8yBmxHqmLe3r/8e6z+4ERf9MVOX8VGXNsIra3Iy80zwV
 lZjM35uRFjowNrh62we4J4BAvYIK4ZRnh/rW5w3fk8nURt0jvPJBOsB25foFVnn16KANoWJ6M/b
 vY1VlcunO9SFKYAmXWD6NYQYfajfQztYsEkqfi7Zhk5VJCT9vVfj/kSmFQdhltS+S3wDbzd45fq
 olAztXKyoyGyiVYIOOUpQGV0j4vuzAfxT/+IjC9t0PO915Ka7myiDMddzcYuA3T+tecJMpmFXN7
 PqwOHrvsIb8euO7ViGSs+CinQTBKX52usmW0DHiIlkSAZFSbxVLR2+GK3yhFZW8ZnqcguB8XhYQ
 kUh3r2XaDlZkBFZRQ+6wFo6b/McgTCzmXQ5SPQXscF4F9YlvGEGYB/2IxewRDS7zBPzOXE4v2Y3
 MEEcvUnQaoK5q9/DpDDEayKxUeIPTNzUXkhqiodnUqWc+llgxIqMbMV4tMpByRlVvK5gXmARl3F
 X0IGXsNLcRRdx31D4=
X-Received: by 2002:a05:6000:983:b0:4a8:8e3f:92b1 with SMTP id
 ffacd0b85a97d-4abb9085022mr3644886f8f.55.1795163990239; 
 Fri, 20 Nov 2026 00:39:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b205443sm4226803f8f.39.2026.11.20.00.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 00:39:49 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 08:39:48 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
X-Gerrit-Change-Number: 2224
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2224?usp=email>
X-Gerrit-Commit: 7ec8c790eacaff945c691563fad9882acb05f6d9
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 08:39:48 +0000
In-Reply-To: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
References: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTU2MzAxMDAwLkljYmZjNmI2NGJlZWE1ZTcwZjMyNDQ5YzVhNjNhMDhhZDg2MjU5N2I5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <523f545c2a943ec6b200207dc12fc0a2179350c7-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUKA1-000000000dc-0DTG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking: use
 NET_ROUTE_TABLE_DEFAULT (-1) for "no route table"
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5915577363712153912=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5915577363712153912==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HzVoIFh1u+E="; charset=UTF-8

--HzVoIFh1u+E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail )

Cha=
nge subject: networking: use NET_ROUTE_TABLE_DEFAULT (-1) for "no route tab=
le"
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 3: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2224?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
Gerrit-Change-Number: 2224
Ger=
rit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering =
<gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Fri, 20 Nov 2026 08:39:48 +0000
Gerrit-HasComments: No
Gerrit=
-Has-Labels: Yes

--HzVoIFh1u+E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?=
usp=3Demail">change 2224</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2224?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2224 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 20 Nov 2026=
 08:39:48 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body><=
/html>
--HzVoIFh1u+E=--


--===============5915577363712153912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5915577363712153912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5915577363712153912==--

