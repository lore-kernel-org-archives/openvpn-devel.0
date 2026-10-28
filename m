Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED2C606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Mv6w/Ooa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AfI0CL/O;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TbphEp36;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JN6HLSJa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EmjJxMb8oMW7t4QOUyVTLMiYFzjart5iEFRLVmtTLis=; b=Mv6w/OoaqIo1M3920l2OZX6b6u
	7xMmnISvli7jnDb7W+Q06SoSdlnEr3M99Mc47TWysBsyQ66oL1yJrAZDUFBNcTa4MWLBGFr3DQMCg
	/IclRAS34jo9OC202Rzk9ITzyDIpTVmvguvcOJiq3HmV3UMzHvZ3TAA+TDPAzyBLOwTc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM4Lr-000000007N2-4Ad0;
	Wed, 28 Oct 2026 14:10:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM4Lj-000000007Lw-2F1y
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 14:09:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w2drXIhactD7DDx7Qh5/dQ1n0z+Y9ev3AYBnWUkY1VM=; b=AfI0CL/O7QLL0g0CWx9clMNnMV
 2QDDYVLYH5bTkiz4eRTJhR5r+M0wAC93zxTUdyoc3gyS83i0xPYG4qkHu0SW41l6N7+IpnOyu4fvn
 nWMKtp5zdEe6fm159RQJ7COwsU/AM0xL0mmmEDaZmkqLZJT5MKLWOZkP251+7JiBuNL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w2drXIhactD7DDx7Qh5/dQ1n0z+Y9ev3AYBnWUkY1VM=; b=TbphEp366rcTUZONuxNkrtzEoE
 CijoQTTCORh42WlF3dspO5c4mL09uHWeNlnafOhn60zkEONf7ONwkSfJJNFuwpwwuecUiBj24Ckah
 T3218ZFMSvhLR7c/mz80uBbLcmwkqWZRijzXzLF0yIDfyhaJHPX7SFRxWQp/cT+Jo0hY=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM4Lh-000000007jB-21Rh for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 14:09:55 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so12617205e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793196587; x=1793801387; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w2drXIhactD7DDx7Qh5/dQ1n0z+Y9ev3AYBnWUkY1VM=;
 b=JN6HLSJadwsy8ar1aHTZg44w6y9abh8yeci22Tr632pA01Fodxlijq7/uKlufja7Fi
 DIBRU+Nyd0w/ZnEFvsdLE0YzO1Zg3NynAqJPGQxukrOdrTwY8oI5mUAsK4hKVv4BgYKw
 T+B9qf8kWFNhzmwJ/VazaxE/ZhS1Kbz7FC0TGFC12Gn3ElCFjBApb2RhwRpVnlDweiLB
 6mzzLy3Z7YK6eEfwfvIlJS1IO/rAnwxo9tTgtk2o8BjJZviLhaEWpC6Q+whicEcTBTDV
 AXodfCOuTkll1OyN2/4fy8YW3SLDfi0mdBopNPsR7LsukIL04/mq/YCOBkC7TJj8QKQg
 YncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196587; x=1793801387;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w2drXIhactD7DDx7Qh5/dQ1n0z+Y9ev3AYBnWUkY1VM=;
 b=rnWdEglaooolYyLe535Bz+RwvG2PQpeAtG8QPSewbR/PgkjDfPFxaQxEGYrstiF0N7
 DYZdvQB0bNDJpUZNpJSQ7EsGKfh0iKg8T8aTOQlcYGV9MJOnTAVcyqJ9/HCC624AZL4W
 LcqRGmz7C0V+gpVNxAp0G/utwYiGlcvtqRAGXQxhyFzklelaofKML/vQwX9hxDiuTDoL
 nelnDV9Avi/5nX/P8ao18cT9681fTDzFq4KM0UK4vDQDHZX8naqkYCFyxx8KYuN4oVE2
 gBVemwnjMvO29naYRue/VM0E5yxakyQaysXjGimt/yWcfSOrIjf+bWsBTQNRJZwqEcWl
 6cLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWVjezRIkJGehHukErUG2SOQe94SS2bpHsGCaQipR4WohKlweZKKIcukFzjM4lRVGWpjMiCCwoUYRSL7mf@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLGv9vhkdJcXeDaJUvL1ersd2ll4xkm9MEBo8kogNj5OJ7EDlIj
 X8FskqCoDoveRt1+MMv6QjCunyXi+Gq88/Xi41ys6ONeK+F9p5zc+I/ZMnEXR9wG1j/00PdLQ8v
 BEoEIHdD/3/0VD1tZY5ki1gFaJ1Oa2tPRa3CQckLrz48fJdyaZNPejlX8sYSb2hp65+t4/PiPpI
 7TNc9xJA==
X-Gm-Gg: AYBFou1VKzOKoUsU/bzcvLRvSdT/+pIh3Dbbb0tb1nPMr0nY/JKxcksy0YuxigeY3sz
 7PM9gLbaIJTtaF3s2abmhn9Ub6VBFGfvrOPLVCrr6n53XSKRy67xkPXeAJxyzyUBk+PO6mLtPvj
 Q7P0nbMlhmgP8kz+iYVkTfSUhiPhYudB15c8SAQmV6hgIHjI97az22QKdzuiTQdaWTmqE/jEKlx
 SCWk51FO/4bPPzyWBu5s/b3spaNrLEYohJdFXrUdPpq/a2PLv00l/Vl897Ly4Qut2+J18gCadUO
 /I0z6RRG80SYW9quUXs6797Nom4aGneoWf/gF3ly/r7idaYbxK63A3IqWy+51OckkjJljYgKGiF
 DTZ681VL5wVjSifHOm1JN/PcdEI///+UJoYBXPXcHRi9UugYnQLNRuRsvinkb30O3Dyx7Or1WDo
 gYLAzy6siJlpodR2S8lJ+wC/WK0XLlFDTHn7IESTowiv1LlclS8VMnRbAHDKmEJjhMcUJhteg9h
 zYgtYBTvpJkf9w6Uk9rsTadsCsjjkTpoB2lCt0d+zGOpjSG2xfSK87MJdPsSKlyLWThQOtcxDfy
 Z6uQxNk0cJpW/osdbe3/dI7N3x6drHfq8rvw8bzwsDQ5wJq49rXckIW1hfYsCeVh019jicEvwlZ
 Lh/vA4VQtGOVc/SfLldA3m9zKgXbm+h+7nEFL8KPRSk8T8aDZf/yl5yMlP72stX+7mapKK0V5z0
 02yqR+tAjKiAUp8lE=
X-Received: by 2002:a05:600c:1388:b0:4a2:994:575c with SMTP id
 5b1f17b1804b1-4a9677c92dcmr55166785e9.34.1793196586658; 
 Wed, 28 Oct 2026 07:09:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97bf5d7cdsm41835175e9.3.2026.10.28.07.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:09:45 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 14:09:37 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 058fa762f3ecb2d77ed2ef43d84a10343232cc4a
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 14:09:37 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <88100c56a498823a1339ec6673937b228b8dd7f1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM4Lh-000000007jB-21Rh
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============4376158914110911846=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4376158914110911846==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x2i9nXaL8G4="; charset=UTF-8

--x2i9nXaL8G4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 17: C=
ode-Review-1

(8 comments)

File CMakeLists=2Etxt:

https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1858/comment/00d77aad_f42431b6?usp=3Demail :
PS17, Line=
 870:         src/openvpn/base64=2Ec
Do we really need this?


File src/ope=
nvpn/acc=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/4cf1=
fbd2_c56f343c?usp=3Demail :
PS17, Line 190:         struct buffer buf =3D a=
lloc_buf_gc(1024, &gc);
Minor nit: this shadows the outer `buf` variable=2E=



https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/2843164a_64637a7=
9?usp=3Demail :
PS17, Line 364:     size_t max_len =3D min_size(strlen(list=
1), strlen(list2));
This code needs to drop duplicates or employ some other=
 strategy against that case=2E

Otherwise it will lead to over-reading stuf=
f, e=2Eg=2E `get_list_intersection(&gc, "flower:flower:flower", "flower")` =
allocates a 7-bytes buffer with no `NUL`-terminator, and then `buf_cstr()` =
reads past the allocation=2E


File tests/unit_tests/openvpn/mock_managemen=
t=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/f30b52ff_53=
6dc641?usp=3Demail :
PS17, Line 30: 
This header is not used anywhere=2E


=
File tests/unit_tests/openvpn/test_acc=2Ec:

https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1858/comment/b83e724f_5199e6ad?usp=3Demail :
PS17, Line 103:  =
   assert_string_equal(mock_msg_buf, "Received custom app control message (=
protocol 'cck1')");
This test now fails, I assume because it doesn't set `a=
cc_negotiated_protocols`=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
58/comment/4413ee5b_3b6c5f3a?usp=3Demail :
PS17, Line 223:     assert_null(=
protocols);
The "non-numerical protocol length" test appears twice (is dupl=
icated)=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/76f9f0=
da_bdcd5d46?usp=3Demail :
PS17, Line 309:     assert_memory_equal(control_c=
hannel_mesage_sent, expected_start_cc, sizeof(expected_start_cc));
Typo: "c=
ontrol_channel_message_sent" (double 's')=2E

This also seems to test the w=
rong thing, since `sizeof(expected_start_cc)` is the size of a pointer=2E `=
strlen()` is probably better?


File tests/unit_tests/openvpn/test_misc=2Ec=
:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/2cc2d676_764da0d=
1?usp=3Demail :
PS17, Line 65: }
`apply_push_options()` and `send_control_c=
hannel_string()` are still not used anywhere=2E



-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Ge=
rrit-Change-Number: 1858
Gerrit-PatchSet: 17
Gerrit-Owner: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-CC: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Comment-Date: Wed, 28 Oct 2026 14:09:37 +0000
Gerrit-Ha=
sComments: Yes
Gerrit-Has-Labels: Yes

--x2i9nXaL8G4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 17:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vi=
ew Change</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File CMakeLists=2Etxt:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1858/comment/00d77aad_f42431b6?usp=3Demail">Patch Set=
 #17, Line 870:</a> <code style=3D"font-family:monospace,monospace">       =
 src/openvpn/base64=2Ec</code></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Do we really need this?</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/acc=2Ec:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1858/comment/4cf1fbd2_c56f343c?usp=3Demail">Patch Se=
t #17, Line 190:</a> <code style=3D"font-family:monospace,monospace">      =
  struct buffer buf =3D alloc_buf_gc(1024, &amp;gc);</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Minor nit: =
this shadows the outer `buf` variable=2E</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/2843164a_64637a79?usp=3Demail"=
>Patch Set #17, Line 364:</a> <code style=3D"font-family:monospace,monospac=
e">    size_t max_len =3D min_size(strlen(list1), strlen(list2));</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">This code needs to drop duplicates or employ some other strategy against =
that case=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Otherwise it will lead to over-reading stuff, e=2Eg=2E `ge=
t_list_intersection(&amp;gc, &quot;flower:flower:flower&quot;, &quot;flower=
&quot;)` allocates a 7-bytes buffer with no `NUL`-terminator, and then `buf=
_cstr()` reads past the allocation=2E</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File tests/unit_tests/openvpn/mock_management=2Eh:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/f30b52ff_536dc641?usp=3Demail">Pa=
tch Set #17, Line 30:</a> <code style=3D"font-family:monospace,monospace"><=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">This header is not used anywhere=2E</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_acc=2Ec:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/b83e724f_5199e6ad?usp=3Demail">P=
atch Set #17, Line 103:</a> <code style=3D"font-family:monospace,monospace"=
>    assert_string_equal(mock_msg_buf, &quot;Received custom app control me=
ssage (protocol &#39;cck1&#39;)&quot;);</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">This test now fails, I a=
ssume because it doesn&#39;t set `acc_negotiated_protocols`=2E</p></li><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/4413ee5b=
_3b6c5f3a?usp=3Demail">Patch Set #17, Line 223:</a> <code style=3D"font-fam=
ily:monospace,monospace">    assert_null(protocols);</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The &quot;n=
on-numerical protocol length&quot; test appears twice (is duplicated)=2E</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/commen=
t/76f9f0da_bdcd5d46?usp=3Demail">Patch Set #17, Line 309:</a> <code style=
=3D"font-family:monospace,monospace">    assert_memory_equal(control_channe=
l_mesage_sent, expected_start_cc, sizeof(expected_start_cc));</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Ty=
po: &quot;control_channel_message_sent&quot; (double &#39;s&#39;)=2E</p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Th=
is also seems to test the wrong thing, since `sizeof(expected_start_cc)` is=
 the size of a pointer=2E `strlen()` is probably better?</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_=
misc=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/2cc2d676_764da0d1?usp=
=3Demail">Patch Set #17, Line 65:</a> <code style=3D"font-family:monospace,=
monospace">}</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">`apply_push_options()` and `send_control_channel_st=
ring()` are still not used anywhere=2E</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail=
">change 1858</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ch=
ugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 28 Oct 2026 14:09:37 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--x2i9nXaL8G4=--


--===============4376158914110911846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4376158914110911846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4376158914110911846==--

