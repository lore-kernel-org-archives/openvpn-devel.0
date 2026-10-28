Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A9606A31D
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Unuw8TWT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mxqccakp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PB1H82zc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Y2JDMeSS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EuyfZ/X9K9jHqc/bYftZEztTILCLCpDsu/PVcfKJfF0=; b=Unuw8TWT6VVo99QijmZ+Sw/RfO
	exyXD4oPxqX3BVHd0n/8wzEQsuIJ1w0Y0ZstqDb85l2woL7rDDVWFWZzB1AxdrCQgKdOpyuzgLtF0
	eq/rn0OHMFuzyBmw5zssZnAx2AmFzqCCXo5oc+3Oe3y2Jbz2gDH5ltAArARoS+G6vbQo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM5IW-000000007mT-3l5c;
	Wed, 28 Oct 2026 15:10:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM5II-000000007lG-1l10
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:10:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7Q8GyUt03ncEBtJKjvvp4j8ZssD3Pm1OBPz6CUGTFY4=; b=mxqccakpbN0rfNle0EYd/yxm7J
 jU0O4uTtmWWA/RlJnQ+bqIw5UiDomwsfCB8A21KaVaDPnU7PsqFzZGN2d2zx/Uz+gSK8DveEWRo2c
 pWSBKdlp5zJ/gAzbSPDk0Wc4ql8qmXmg9uUwQiQc0Giba6o+tIBH4isQ4rcagQBB2RvQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7Q8GyUt03ncEBtJKjvvp4j8ZssD3Pm1OBPz6CUGTFY4=; b=PB1H82zc6HdxlFy/m55KKgHeTI
 ieU9nX3Q6nhz/UoSa8NS691QToayKNIFxhaclbyQOaRRZ1jOof44YlPrMBEL4tu2dkAfHGD47Uo3o
 FDVcabo94GfeyDjrEMVebS1OuSaQY8dDmc5bUAg1fux2dsc9ed8U7chI3KTD94Xb6w+I=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5IG-000000002Ls-0ks0 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:10:26 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso829131f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793200217; x=1793805017; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7Q8GyUt03ncEBtJKjvvp4j8ZssD3Pm1OBPz6CUGTFY4=;
 b=Y2JDMeSSBh0mwTYU4rZABCOms+JjQskFEdgrad+0fbpmbZ/dlVpLt9LOhu3I9ehjJJ
 QrsN9A4dSnXUpSO+zLPdOVxRXQYA/jsZvCybPWja0tgalXmeTaFzkQ5x0k6whqG8HHYf
 qhGRAm5CYXH00tPAM68DECTgIYisAH3hCaPHnbezFEK+6PSQrkEa1BCKtFHoV5PSlKzK
 bWjZC7KHmgWgr02FRg+g80Yt0MaVSkmfAA1CjUduG9oeoAUcBcinEwYJ5rAQm6PtYXWY
 /yK3LkJSIG93L5jIQK35Yomvim3bwyDIYdL7IU+hYap5AT+1x2fys/caWUFS6M/HTHod
 /Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793200217; x=1793805017;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7Q8GyUt03ncEBtJKjvvp4j8ZssD3Pm1OBPz6CUGTFY4=;
 b=26iwMWY6tyFRGXMH34aDMnA0nI6P6fCuxfBwqoJ/Q/9yNU/O6Bd3slJMIXSUbampmn
 NBzlp0b+EZNmPEzylBW5uOX6qz4XW610KAYsy721Y0+6KosaO0cXgXs2sOf5f6nKE3uz
 jMoyFmTke3hX+Yj+XyM4U3VNXL+IS8c5Y0xK7nSr9Nguje5ljyXS3X0R/csHJDTfxd4o
 vlqiGiclep6w1knsSDZtdal/dPNAACiZpBoEOFpXqENQA6e8dahzUHzGWx/k9GboA1Ed
 qTkAdn7Epwj5XRqOY4AtA1LPlnMvf9klSp6WwD27cZoopw5fpdFOV0xIB2gjjjRhPFdm
 MaDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUlhyuMylBTEfZTJ7+yWct566t5F9Cxj28jEhm41f/qVERv5lfG2Gjb9e7tc6R3WK/0N1kCDBtMDoFG5Hu@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJ+GHoWu18285rt0GH05CtW20Qct+8WgH1u37RkJIc3gSM65ir9
 jIlF7VK5pgqVuSpARIWcFFMhaVdqeB4H02Igu7RvvvK18kC9dj37VsfpCn6ppOJKWhsOgdSJJrN
 kZ2CyTgc+E3T0UUcTooeG5plLUCBDRIhwJ77D7fWgHkeZXLdBZeS205LilMVXNcJThk8N
X-Gm-Gg: AYBFou08/z+OSxu3zi56/qHiqKVLVJmRJOLMOmpvYfnCfhNwR+yssls8nfGAeYNPE3w
 hUlpLoCU+X4zd7p94F+XDoBpF+Q5lCdgu9+dB1/+bFM9jxdajra3Y6EtEszUJTIGfeOenmXn3HD
 1IAzkP7Zv0XUTGgMVaYUXURYT+zH8gNdgCxgPZ4YUE4AesEUhXWUAJJaxnGIGYmDSZeXWT30rgW
 Rc4BHK6xRo1M5PnwSIfETy+EhbNSQITtLl0w6McMgZ76/2aTNXjybLtIcPT3VC/ooZF3mLrqCgo
 dZafKsR7+HntSBdffZ4kaVqbwxgr37JREQhxEWDReYHpRw+KMNDr5o5v58jXZ9pgVNFA2qYORmY
 KUrNs7n1UGhNzGDMf2wKjtLOOVqYfTzzA/EUg6hZJqM4dFvN5FeAJu5bCoXYatFRNCWYPCYWxh2
 HLzWPzodeTh8OiRRwp0G0B4WQUYObn+4jm4//l9GqMZO9d+4/vvHM+j51Xtl12dNaBa4lYeNlS6
 wdk47F9iMSS+/q46YR2lLzw8L4AQZ79JsZx36Ap5sbdkyCihLA49Zsyko7OBDAnxFscmj8ZnRLn
 bn0q1ltKvbL0kAfciNufLSmcgfmH+w/g/SPeijHBo6MUwtTDgu7KALZKJO7nt9A2L0BqNEHtX3m
 86iZsNGIlmJOPFKemsm7IEQ3Lz4bOaei1JSb7Slcsu9cvhzK5JdZ0ERbSruCzieIiqFN9LMsnBB
 A7swHBg+kvTG/jcA0=
X-Received: by 2002:a05:6000:15db:b0:48a:fba3:d5b1 with SMTP id
 ffacd0b85a97d-48e5d5eb119mr4630649f8f.55.1793200217057; 
 Wed, 28 Oct 2026 08:10:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd35c2sm28429080f8f.39.2026.10.28.08.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:10:16 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 15:10:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 058fa762f3ecb2d77ed2ef43d84a10343232cc4a
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 15:10:13 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f0e2ef5d521385ac4f48db8df46933e716cf26dc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xM5IG-000000002Ls-0ks0
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
 charlie.vigue@openvpn.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============6358280914816663047=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6358280914816663047==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s6BByose0fE="; charset=UTF-8

--s6BByose0fE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 17:

=
(8 comments)

File CMakeLists=2Etxt:

https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1858/comment/42b6e6e5_7f3cd4cf?usp=3Demail :
PS17, Line 870:         =
src/openvpn/base64=2Ec
> Do we really need this?
no that is from older vers=
ion where the acc testlived in tes_misc instead of test_ssl=2E Will remove=
=2E


File src/openvpn/acc=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1858/comment/138cf68a_e4a963e3?usp=3Demail :
PS17, Line 190:         struc=
t buffer buf =3D alloc_buf_gc(1024, &gc);
> Minor nit: this shadows the out=
er `buf` variable=2E
Acknowledged


https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858/comment/a73e0e22_e466f0bb?usp=3Demail :
PS17, Line 364:     size_t=
 max_len =3D min_size(strlen(list1), strlen(list2));
> This code needs to d=
rop duplicates or employ some other strategy against that case=2E [=E2=80=
=A6]
Ah good point=2E I have not thought about duplicates at all=2E


File =
tests/unit_tests/openvpn/mock_management=2Eh:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1858/comment/8ea235b2_f53c93ac?usp=3Demail :
PS17, Line 30: =

> This header is not used anywhere=2E
Done


File tests/unit_tests/openvpn=
/test_acc=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/318=
5c88c_44c58184?usp=3Demail :
PS17, Line 103:     assert_string_equal(mock_m=
sg_buf, "Received custom app control message (protocol 'cck1')");
> This te=
st now fails, I assume because it doesn't set `acc_negotiated_protocols`=2E=

Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/e2dca82f_4c=
5a1a64?usp=3Demail :
PS17, Line 223:     assert_null(protocols);
> The "non=
-numerical protocol length" test appears twice (is duplicated)=2E
Done


ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/194b6aa0_55ebb665?usp=
=3Demail :
PS17, Line 309:     assert_memory_equal(control_channel_mesage_s=
ent, expected_start_cc, sizeof(expected_start_cc));
> Typo: "control_channe=
l_message_sent" (double 's')=2E [=E2=80=A6]
Acknowledged


File tests/unit_=
tests/openvpn/test_misc=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
58/comment/b553a326_c15ae081?usp=3Demail :
PS17, Line 65: }
> `apply_push_o=
ptions()` and `send_control_channel_string()` are still not used anywhere=
=2E
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
858?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comme=
nt
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6ef=
41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSe=
t: 17
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue@openv=
pn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: We=
d, 28 Oct 2026 15:10:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No=

Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--s6BByose0fE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Ch=
ange</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File CMakeLists=2Etxt:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/42b6e6e5_7f3cd4cf?usp=3Demail">Patch Set #1=
7, Line 870:</a> <code style=3D"font-family:monospace,monospace">        sr=
c/openvpn/base64=2Ec</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">Do we really need this?</blockqu=
ote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">no that is from older version where the acc testlived in tes_misc =
instead of test_ssl=2E Will remove=2E</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/acc=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858/comment/138cf68a_e4a963e3?usp=3Demail">Patch Set #17, Line 190:</a=
> <code style=3D"font-family:monospace,monospace">        struct buffer buf=
 =3D alloc_buf_gc(1024, &amp;gc);</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Minor nit: this sha=
dows the outer `buf` variable=2E</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/a73e0e2=
2_e466f0bb?usp=3Demail">Patch Set #17, Line 364:</a> <code style=3D"font-fa=
mily:monospace,monospace">    size_t max_len =3D min_size(strlen(list1), st=
rlen(list2));</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">This code needs to drop duplicates or e=
mploy some other strategy against that case=2E [=E2=80=A6]</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Ah good point=2E I have not thought about duplicates at all=2E</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvp=
n/mock_management=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/8ea235b2_=
f53c93ac?usp=3Demail">Patch Set #17, Line 30:</a> <code style=3D"font-famil=
y:monospace,monospace"></code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">This header is not used anywh=
ere=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padd=
ing: 0;"><p>File tests/unit_tests/openvpn/test_acc=2Ec:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1858/comment/3185c88c_44c58184?usp=3Demail">Patch Set #17, Line =
103:</a> <code style=3D"font-family:monospace,monospace">    assert_string_=
equal(mock_msg_buf, &quot;Received custom app control message (protocol &#3=
9;cck1&#39;)&quot;);</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">This test now fails, I assume be=
cause it doesn&#39;t set `acc_negotiated_protocols`=2E</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/co=
mment/e2dca82f_4c5a1a64?usp=3Demail">Patch Set #17, Line 223:</a> <code sty=
le=3D"font-family:monospace,monospace">    assert_null(protocols);</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">The &quot;non-numerical protocol length&quot; test appears tw=
ice (is duplicated)=2E</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/194b6aa0_55ebb665?usp=3Dem=
ail">Patch Set #17, Line 309:</a> <code style=3D"font-family:monospace,mono=
space">    assert_memory_equal(control_channel_mesage_sent, expected_start_=
cc, sizeof(expected_start_cc));</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo: &quot;control_c=
hannel_message_sent&quot; (double &#39;s&#39;)=2E [=E2=80=A6]</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>=
File tests/unit_tests/openvpn/test_misc=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1858/comment/b553a326_c15ae081?usp=3Demail">Patch Set #17, Line 65:</a> <co=
de style=3D"font-family:monospace,monospace">}</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`apply=
_push_options()` and `send_control_channel_string()` are still not used any=
where=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">change=
 1858</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: chugly =
&lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 28 Oct 2026 15:10:13 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>

</body></html>
--s6BByose0fE=--


--===============6358280914816663047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6358280914816663047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6358280914816663047==--

