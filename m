Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C4606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hUy0lds1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BNabKrTX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fr9H/NB2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DvEmRoTS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=j6jwJYPKsAY5+qOG7mB17EDj2Q3EUSVqbe0/ILGrL7U=; b=hUy0lds1yCg9MSsskeI4vUeie1
	iVnJXVhTG2g9R6SOoCW8w4TtWmCArgDPLGGkbrbKL5xXvT302hU6JKQ9AAptCojxg0aue02ADTqw/
	SiQM/WKMZHX4EvP3duE4N2h/gD/0dRAUeskvxq410DMyv7Hl9GXyuPf4QHLVqU+/vLTM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMcdn-0000000035Q-1NcN;
	Fri, 30 Oct 2026 02:46:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMcdm-0000000035K-1QaX
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 02:46:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5ERJeJ65ZI/2MfLgmnUBhoGQ83LQ/oH2QbgN0ydpPMY=; b=BNabKrTXlW2/OS3cdg2DsI4l7a
 j1eI4A352KKdwLvfiSn/snQgEHAATvL/xgdKZzcjrbKrpj3lDoNhRJOWgj3t3cGPzcPMlLjGrrfIA
 t50aKUDzeskWjLi+VnQKKyKH/QgO/eKVb62jaq1EEfX+3tfNh0XaKZe3GlXXNHtpEYKc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5ERJeJ65ZI/2MfLgmnUBhoGQ83LQ/oH2QbgN0ydpPMY=; b=fr9H/NB2wg8xa5DjyOH10qOzqY
 dijrGDZZ9zz5hg2yPgShUbZc8XSjMOZkZS6z8y0UScrfbf7WfIevAyFInd5YvsLu1A6H/eW8YLIra
 IPgv2WlhLpGt8HKSV7Ms/P1Lqy3VHgri1sOfjZzVt+XH2Ox09OEzaTiBL9jmydBjHZRg=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMcdl-000000001lp-1vwY for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 02:46:50 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso115049f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 19:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793328403; x=1793933203; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5ERJeJ65ZI/2MfLgmnUBhoGQ83LQ/oH2QbgN0ydpPMY=;
 b=DvEmRoTSTAAp9Z5Qn13a6rmSh5PMJiCrzCDBK1SQG7pgxn/jRaUOzmW2EZhmi/DC9c
 GJDssyBVxTVM48AlPR5VpjZGRhmpCnrRcupw2ONBckyynHy/weXYvtebj7Iui+4EuGOP
 NV6GYnHzyQPxbAAj3bTACeKi2Bir7QbUwZYvL/Jzd+qHN4Nf0frYsFppZ1qVvxJgL6qP
 NPJiJYk7REG6gbkP0yfkmWWYILKC261inNZyY9fAgqFTWoC98EFpMiGefKd4rE0PXTTz
 aG+xVbCxWg0mVCBKQJCI4Q/bRNk74cPP82y8vEr7/Ste51XJERAbzzMMgIdL4juqv9Ey
 xOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793328403; x=1793933203;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5ERJeJ65ZI/2MfLgmnUBhoGQ83LQ/oH2QbgN0ydpPMY=;
 b=kh+XKWhjry4K7vDS075P4wtuBM5x6u/5c+F8yDFz7tYwoQk/ypRXd2FffzTjUCiZjj
 IHRVwQ91qTv398apo9CKPbri+ydsONKkXVYcJX+yxgBz3IXMTbFyaZiNLmSPn2B7HroE
 fAi1SdNwrMf5+OKR7UuOqSrPVMhApuFvjddw5r2ZKDtgAubHuQbQCSNlQMNwPM1APnfa
 stsI4H1h0ikcjZ1iAfhV6KK4u1dv0jcqSvy5/J4ciOG1mB2euAZArFKR3yLKG4BFLqyZ
 r2hWHda74F5YyMicu+d5ymn0dwVXI+IpOAVuJ8h7M1Nfh7avg3MAxcCo11Ki5EpTgs0k
 qjnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByatNDP0bhOI4qNa7hQDPtOfQgYcmgObmF7tjYIMeb8HLfFRL8Bppvjy2DUkywG/7W7kpMHnn/5gZoCsoV+@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLnPyhnI6Wqa07Rgo64W9fNrkClSWYPhWmebvXsX0s0hLEEhYfH
 Mz7OO76ESXspbGBYFTUIbqdNsTnJctgt8GIRvZUSXBYWA8MlSfucvQU16C1cXElokDb4AJdL0EH
 rkuKEeRg40ljsmG7lrzrJ+7KVauhPIEDZBNfT6MXW1aqKPBCCrr8VJGQ/+7tQk17npsJ4
X-Gm-Gg: AYBFou2hwI4B5Sir0aE8BCTj6qybmfDBPhvOsV1mNXgduqCp8lOJcNnwgcKldjyWbRW
 mv0soKpI+2GhQqXVELItjJaRgFTTc7+90DGehdRScQaGBTSDJNqUtCgZqUwSA02LIATpKuTSgEw
 Bmg6b5VqsxGVnWQYdu59KJyOgp41j2NnMslMO4Wep/kLVlAIqLzsl3ADgPXJ+u6v6N4jQ9HUfNZ
 0ElyyDPZel2yUrZdHdlKa7DM19DwYDPaYj+FAdmkJJYBK8FX3yG41JFn34dAYkpAAawkz1k4pHY
 9fcZYtmNZFCfoeUBPJMZEh/ytAQtmoH1lCYphIwrhinxYqtihoi8DSVabdUo47epOGyAJo9NEZD
 o6FJJOtiKhr6jzUde+dujz79XPDdq1fJThOiioqixXwaN3rnZJxYTZ/82Y29rpmiiDNM3kNYIzz
 Nv6hAOxhSSh2Pot8jHAAcg4feavmkcgpBWuat/qhLLPbE7Futi7nEZR4iCevjwTS2eW1XlWfI8J
 pHYoWQ9d3cIumOIfe4mBBkvSVnbnjLyrO0lnOnNIP/H+sjyUPZRA8QBoPwP4up/n3SZ7qwdim53
 y0PP/tFT4HtWbsDQ7/uFiunwbwEdrMAzav1vRl0hLJfnZi/bGxQ4qaGk6iP7sNwEUZW58wD7Ho6
 Q0KC0Yk65v3vF0y+J5quy9qW3HGyHTBXWqmgVP6V1iKRgDRpfWE6WE2/zjlvqdY2gE3Pr97tsbm
 9Xw3Q5mYw+n6PfRkQ=
X-Received: by 2002:a05:6000:2c0f:b0:48e:25e1:5eb8 with SMTP id
 ffacd0b85a97d-48e6e2c1430mr2748895f8f.3.1793328402789; 
 Thu, 29 Oct 2026 19:46:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9c4f4sm589090f8f.48.2026.10.29.19.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 19:46:42 -0700 (PDT)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 02:46:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
X-Gerrit-Change-Number: 2069
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2069?usp=email>
X-Gerrit-Commit: 08b058611ff00638cee31f0eb2da092826e34c5f
X-Gerrit-Comment-Date: Fri, 30 Oct 2026 02:46:40 +0000
In-Reply-To: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
References: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLklhYzIzZDUxNDFhOGMyOWUyMzlkMGYyYWVlYTQ5N2QzYTAwMmU2MDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <54a9f19b1f93055b9282c026045ecb519e06b8f0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMcdl-000000001lp-1vwY
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Optionally indicate
 username in >PASSWORD 'Auth' prompt
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7496813058484502007=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7496813058484502007==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="V/qtozugLtE="; charset=UTF-8

--V/qtozugLtE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Selva Nair has posted comments on this change by Selva=
 Nair=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail )

C=
hange subject: Optionally indicate username in >PASSWORD 'Auth' prompt
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(=
5 comments)

File doc/management-notes=2Etxt:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2069/comment/aa70a5ed_3cdc944c?usp=3Demail :
PS1, Line 403: =
  difference=2E The prompt has an addiitonal word "UN:<user-base64>" where
=
> Typo "additional"
Acknowledged


https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2069/comment/be4cb581_d57baf58?usp=3Demail :
PS1, Line 404:   <user-base=
64> is the base64 encoded form a pre-defined username=2E This
> This senten=
ce is weird=2E [=E2=80=A6]
Done


File doc/management-notes=2Etxt:

https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/a3a29cb1_a4559d99?usp=3Dem=
ail :
PS2, Line 402:   These work exactly as Examples 3 and 8, respectively=
, with the following
> Example 2?
Acknowledged


File src/openvpn/manage=2E=
c:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/db2745db_b73fbb=
2e?usp=3Demail :
PS2, Line 3675:             && (man->connection=2Eclient_v=
ersion >=3D MCV_PREFERRED_USERNAME)
> Should this check `type` as well?
We =
use mode=3DUP_QUERY_USER_PASS only for username/password prompt with or wit=
hout static-challenge=2E So okay as is?


https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2069/comment/0c88e5c7_f0d49f8a?usp=3Demail :
PS2, Line 3685:     =
            buf_printf(&alert_msg, " UN:%s", user64);
> Are we sure `alert_=
msg` can hold everything it's supposed to legitimately contain? I see it's =
alloca [=E2=80=A6]
Rigt, this looks like an existing defect made worse by t=
his patch: we allow even static-chalenge messages longer than what can fit =
in 128 bytes=2E 
I can post a  follow up patch to increase it to 256 bytes =
and log a warning on overflow=2E



-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2069?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
Gerrit-Change-Num=
ber: 2069
Gerrit-PatchSet: 2
Gerrit-Owner: Selva Nair <selva=2Enair@gmail=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Fri, 30 Oct 2026 02:46:40 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Comment-In-Reply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--V/qtozugLtE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Selva Nair has posted comments on this change by Selva Nair=2E<=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demai=
l">View Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/management-notes=
=2Etxt:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/aa70a5ed_3cdc944c?usp=3D=
email">Patch Set #1, Line 403:</a> <code style=3D"font-family:monospace,mon=
ospace">  difference=2E The prompt has an addiitonal word &quot;UN:&lt;user=
-base64&gt;&quot; where</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">Typo &quot;additional&quot;</=
blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2069/comment/be4cb581_d57baf58?usp=3Demail">Patch Set #=
1, Line 404:</a> <code style=3D"font-family:monospace,monospace">  &lt;user=
-base64&gt; is the base64 encoded form a pre-defined username=2E This</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">This sentence is weird=2E [=E2=80=A6]</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/manage=
ment-notes=2Etxt:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/a3a29cb1_a455=
9d99?usp=3Demail">Patch Set #2, Line 402:</a> <code style=3D"font-family:mo=
nospace,monospace">  These work exactly as Examples 3 and 8, respectively, =
with the following</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">Example 2?</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknow=
ledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/manage=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/db2745db_b73f=
bb2e?usp=3Demail">Patch Set #2, Line 3675:</a> <code style=3D"font-family:m=
onospace,monospace">            &amp;&amp; (man-&gt;connection=2Eclient_ver=
sion &gt;=3D MCV_PREFERRED_USERNAME)</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should this chec=
k `type` as well?</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">We use mode=3DUP_QUERY_USER_PASS only fo=
r username/password prompt with or without static-challenge=2E So okay as i=
s?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/c=
omment/0c88e5c7_f0d49f8a?usp=3Demail">Patch Set #2, Line 3685:</a> <code st=
yle=3D"font-family:monospace,monospace">                buf_printf(&amp;ale=
rt_msg, &quot; UN:%s&quot;, user64);</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Are we sure `ale=
rt_msg` can hold everything it&#39;s supposed to legitimately contain? I se=
e it&#39;s alloca [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Rigt, this looks like an exi=
sting defect made worse by this patch: we allow even static-chalenge messag=
es longer than what can fit in 128 bytes=2E <br>I can post a  follow up pat=
ch to increase it to 256 bytes and log a warning on overflow=2E</p></li></u=
l></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2069?usp=3Demail">change 2069</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2069?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e6=
09b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2069 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Fri, 30 Oct 2026 02:46:40 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>

</body></html>
--V/qtozugLtE=--


--===============7496813058484502007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7496813058484502007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7496813058484502007==--

