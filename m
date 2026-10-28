Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D01606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ecdv6lIS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Xuwgt8Dc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UddelHoy;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AG170f8k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dj+YB6sIXfZB2hD5ShyMDR2OQIAlukKanw5ez4W3KkE=; b=Ecdv6lISlvPt/R0mBniHtv1ae4
	LvDqyGVwoeszDaxEujmW4BfqgB3FmzR33D3LQkZ3shOMvdN+6LBiTSNNt/D1wl4zzX3M/3hZlCGZz
	olX/Hi6Z5F2GMkz91YnemIa975GnEPbihPF7DXiJk0BmZuBOEyesXmwsXzGFZsaBg3s0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM6Fy-000000004Dj-201H;
	Wed, 28 Oct 2026 16:12:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM6Fe-000000004CF-1oJ5
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:11:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F8clE82YEMCoF6sbNVpzMGk2VXeVynGusk73UDMGisY=; b=Xuwgt8DcDIYGfU8R4XFQZflM2n
 LOjZ+L/w+ihlnCmtaI7XwSDCN0eIgbUE84uP/2EwfiL0rM7c0bfkqq3FenrNn5To/S7+AnrAtl8jx
 8z6bxHftkRqQmaHUOyQFQiMEk71GUkcSxRo/Fpi7wI55ZoFUZXxlj2GXIwmIabm7fabs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F8clE82YEMCoF6sbNVpzMGk2VXeVynGusk73UDMGisY=; b=UddelHoyEILlv0cxaxAXfvnIOw
 zjdtMipfVpZRfV7iBmet/2UI55fVr3tnWByffmM1UN8oEwMn85TMlQV1aHAVzB6PsYORRtdsBLvuT
 Lr5DSbuH5COxp4eNxwO7bia6CtVAud3NUjhcTs+5WFACiLX0FGcir083vlDdfinpr2T0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM6Fb-000000004YF-2Bkn for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 16:11:45 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so11281025e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793203897; x=1793808697; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F8clE82YEMCoF6sbNVpzMGk2VXeVynGusk73UDMGisY=;
 b=AG170f8kwmc0jHNB9VIR0F+ohsJSOt+bOWd4+iQu74e1L7n7VKn3Zu/xGFyLEX4+e/
 1YzAaU2ohlwz6lTJFtxE49i1d06xf8TqG4iu8S6pU4OCiMJZg88Tben4riLKmvaEfctF
 qBvSITdLMihteQV21DgwPWmxx3PJlkoJGHivtvs8tQGvS82qbTNSFFk5UJCyUnTyPDN6
 P0lU1lq9t2ikKtgGKgEijBmyr83qX4tDuP55INuwZCczTBj2qalqV+xDgf0j6ACmG9cX
 XJWdBkEIJ9EB+wwsUkW8NG5z6A71Ip+y2LKi08RRZYAxQppw9XU3mNmC6uO6pvUuPHTH
 McrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203897; x=1793808697;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=F8clE82YEMCoF6sbNVpzMGk2VXeVynGusk73UDMGisY=;
 b=dQGvsgS8GQ0vrmsKNHB2aBpRFUIv508uL3uGA/a3GyAUaS3K5vL564Eq+2LvHVPEH1
 rh2YBsZGKhmwEQcdJh12Bf52D0G8oP3b6VHD5buJXIovxVf6Q+6sAWxnoKduQYpdyvTT
 rov9qGkv1zPS/QSb7rBGllN0xwBaEbiu3ThulV1lVGx+K5RnYYwhlNmFgUqQru/gb3cg
 KNjFfCL1CFZmOGo7zVO2SoiU/2Re+fxp+EVn0XM5vRTztlnmvH0tScMw2kGdAcmZW80C
 KuSk7mIju2INMthqC0SV1Q6bxY66BMQu646dKVGK/iU3rXH3ijjPzAQ6xxDhu+cXMeNI
 3RRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0lGKg4NNdRH45aKrdqEPd1xVMCkV2GcmGdAvL1HSUdcAaf7L7Q1Ptl/fHWFvPU8jp+YkrRBsF9ucTdyg4@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIYxJTLSgxIUUb2Q5OOfkNtlsVKRXtJ2rnNWp4nr2s929Ll0fbw
 07jVxiFqJFsymPXFV9i7b2Pkf5z8Y2eNFQUDlEt4c0jrEi3oldOJsOXTS/3aHFvgrU8onv1kwEz
 75G58cOmgxNXcXnZGETYYwwzyzuWuYWRM5qJoUFAtabYVGx/oKs2XqSgHfc7kVQOKfYVwNeXVRz
 Z/x67Cog==
X-Gm-Gg: AYBFou3jfukJyI+PboZGOwXICZ7BFU0+UWY6gaI6du4/JVEnJsIgSDUjs/p6/bPQaOx
 edEKQbEKY5chahyveQF0BIG0AUEfZ2pgWkscswcdllEv35ROD0jZ9uT2gnCHhMLrBBKAC2OVXQk
 AT4ydhNJYRbbIx9dOyjSGQPU/qGvT2YWgBabVH0xZ5l8u54Ggu5dXU0lSxgebQa5EXZFV/FX6/d
 tc8BE+Qxm/vZfyBugbAtu0gDMJclXS2kuqb1IdQ4NCXbBFn985o1JTFjJ/sjnXJb/CmcH2QngeS
 l6DBx03uceRfvFKO1neazSms8XFUu/uMUtuMI7q8e/k09PH+RvmGa09H9Var+ZIrYJZmYaKl+DC
 CofMceh/hyDOUY0dpGeZVgAlJWQo8iLyB2OAO8MJUw2v96U4HTkLugKmhGYZaJJmWQ+zeNaU6tf
 NJhDGTf6/JY4S4bErMVW0VUetSI14an8ZzBGZApyxiqjStra+cRclHyEMOTqhXwXsl27gdWwyBT
 MWyczLr1BplJWJk4GYhhg3VlNxT1Q3hLBEJIb350ZhNXB44iY7PlTZlLXVHGpyiNrqc9CTw57K7
 xmFZNm0jsX42Bi3oJulIwmnGl5XRIodonI4dnBK+zZqAgFhrRbjThFwhwouAXZvGW05QDSsrkBD
 AKuerzVyvHovQnsi0/YR0+NKp0gtGxoyYSkPVA2CkJlbHJQ2xYGXprXr/ocDgKokZKy/jsH/Zuo
 8VOn8/sSGGDpNSMKI=
X-Received: by 2002:a05:600c:154a:b0:4a0:1efa:c74a with SMTP id
 5b1f17b1804b1-4a9678c26dfmr59680965e9.20.1793203896399; 
 Wed, 28 Oct 2026 09:11:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80285b88sm2601375e9.14.2026.10.28.09.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:11:36 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 16:11:31 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 6d76e0240a1bd038517b7ab46985ba49291a4f91
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 16:11:31 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5c7eb2829b317a0fe38b07c1b7a67a5f3d551442-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM6Fb-000000004YF-2Bkn
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
Content-Type: multipart/mixed; boundary="===============3709808314213256187=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3709808314213256187==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SyyOjBGZtgA="; charset=UTF-8

--SyyOjBGZtgA=
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


Patch Set 18: C=
ode-Review-1

(12 comments)

File doc/man-sections/script-options=2Erst:

h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/8d076525_42b9ca4e?us=
p=3Demail :
PS18, Line 1017:     message length for app custom protocol mes=
sage=2E
This file is now missing its final newline=2E


File doc/management=
-notes=2Etxt:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/d221=
9f63_cda5a701?usp=3Demail :
PS18, Line 842: -------------------------------=
-----------
The underline is the wrong length=2E


https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/96e2711f_5c287b07?usp=3Demail :
PS18, Line =
1391:    protocol_list is a list of supported protocols by the client=2E Fo=
r example
They're not the protocols supported by the client=2E They are the=
 common, negotiated ones=2E


File src/openvpn/acc=2Ec:

https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1858/comment/fd4ce96c_d173ba3a?usp=3Demail :
PS18,=
 Line 206:     if (!payload_len_str || !((payload_len =3D atoi(payload_len_=
str))))
Should we use `atoi_constrained()` here (like `parse_acc_parameters=
()` does), with maybe a range of `1` - `TLS_CHANNEL_BUF_SIZE`?


https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/0552cfb2_eb051705?usp=3Demail=
 :
PS18, Line 239:         format_hex(BPTR(&buf), BLEN(&buf), 80, &gc));
At=
 this point it looks like `buf` has been advanced, so this will only show l=
eftover text=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/7=
12c42f4_f1936650?usp=3Demail :
PS18, Line 358:     char *tmp =3D strdup(lis=
t1);
The return value of `strdup()` is never checked=2E Maybe use `string_a=
lloc(list1, NULL)`?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comme=
nt/0d26e66f_42a72358?usp=3Demail :
PS18, Line 422:     struct buffer common=
_protocols =3D get_list_intersection(&gc, session->opt->acc_protocols, prot=
ocols);
This uses `session->opt->acc_protocols` but above the function uses=
 `multi->opt=2Eacc_protocols`, which is a bit confusing=2E


File src/openv=
pn/init=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/f31c4=
29d_ccde2a0f?usp=3Demail :
PS18, Line 2286:                    multi->acc_m=
ax_message_length, multi->acc_negotiated_protocols);
Doesn't the push optio=
n use spaces? Is intended to replace them with commas here?


File src/open=
vpn/push=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/ee88=
bf42_4a29a4c8?usp=3Demail :
PS18, Line 253:         return;
Shouldn't we `g=
c_free()` before `return` here as well?


File src/openvpn/ssl=2Ec:

https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/8a928e55_0fee40c2?usp=3De=
mail :
PS18, Line 2125:                 buf_printf(&out, "IV_ACC=3D%d,6:A,%=
s\n", ACC_MAX_MSG_LEN, session->opt->acc_protocols);
Should we `buf_safe()`=
 here as the above code does, as well?


File tests/unit_tests/openvpn/test=
_acc=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/5d9ebf1a=
_bb52c8d2?usp=3Demail :
PS18, Line 46: char control_channel_mesage_sent[204=
8];
`mesage` is still misspelled=2E


https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1858/comment/2f043e08_8ce18e38?usp=3Demail :
PS18, Line 55:     memcp=
y(control_channel_mesage_sent, str, strlen(str));
`memcpy()` copies without=
 a terminating `NUL`=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858=

Gerrit-PatchSet: 18
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revie=
wer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charli=
e=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comm=
ent-Date: Wed, 28 Oct 2026 16:11:31 +0000
Gerrit-HasComments: Yes
Gerrit-Ha=
s-Labels: Yes

--SyyOjBGZtgA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 18:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vi=
ew Change</a></p><p>12 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/script-o=
ptions=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/8d076525_42b9ca4e?=
usp=3Demail">Patch Set #18, Line 1017:</a> <code style=3D"font-family:monos=
pace,monospace">    message length for app custom protocol message=2E</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">This file is now missing its final newline=2E</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File doc/management-notes=2Etxt:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1858/comment/d2219f63_cda5a701?usp=3Demail">Patch Se=
t #18, Line 842:</a> <code style=3D"font-family:monospace,monospace">------=
------------------------------------</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">The underline is the wrong =
length=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1858/comment/96e2711f_5c287b07?usp=3Demail">Patch Set #18, Line 1391:</a> =
<code style=3D"font-family:monospace,monospace">   protocol_list is a list =
of supported protocols by the client=2E For example</code></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">They&#39;re =
not the protocols supported by the client=2E They are the common, negotiate=
d ones=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sr=
c/openvpn/acc=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/fd4ce96c_d173=
ba3a?usp=3Demail">Patch Set #18, Line 206:</a> <code style=3D"font-family:m=
onospace,monospace">    if (!payload_len_str || !((payload_len =3D atoi(pay=
load_len_str))))</code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Should we use `atoi_constrained()` here (like `=
parse_acc_parameters()` does), with maybe a range of `1` - `TLS_CHANNEL_BUF=
_SIZE`?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
858/comment/0552cfb2_eb051705?usp=3Demail">Patch Set #18, Line 239:</a> <co=
de style=3D"font-family:monospace,monospace">        format_hex(BPTR(&amp;b=
uf), BLEN(&amp;buf), 80, &amp;gc));</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">At this point it looks like =
`buf` has been advanced, so this will only show leftover text=2E</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/712c42=
f4_f1936650?usp=3Demail">Patch Set #18, Line 358:</a> <code style=3D"font-f=
amily:monospace,monospace">    char *tmp =3D strdup(list1);</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The =
return value of `strdup()` is never checked=2E Maybe use `string_alloc(list=
1, NULL)`?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858/comment/0d26e66f_42a72358?usp=3Demail">Patch Set #18, Line 422:</a=
> <code style=3D"font-family:monospace,monospace">    struct buffer common_=
protocols =3D get_list_intersection(&amp;gc, session-&gt;opt-&gt;acc_protoc=
ols, protocols);</code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">This uses `session-&gt;opt-&gt;acc_protocols` b=
ut above the function uses `multi-&gt;opt=2Eacc_protocols`, which is a bit =
confusing=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/init=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/f31c429d_=
ccde2a0f?usp=3Demail">Patch Set #18, Line 2286:</a> <code style=3D"font-fam=
ily:monospace,monospace">                   multi-&gt;acc_max_message_lengt=
h, multi-&gt;acc_negotiated_protocols);</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Doesn&#39;t the push opt=
ion use spaces? Is intended to replace them with commas here?</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push=2Ec:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/ee88bf42_4a29a4c8?usp=3Demail">Pa=
tch Set #18, Line 253:</a> <code style=3D"font-family:monospace,monospace">=
        return;</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Shouldn&#39;t we `gc_free()` before `return` her=
e as well?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/ssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/8a928e55_0fe=
e40c2?usp=3Demail">Patch Set #18, Line 2125:</a> <code style=3D"font-family=
:monospace,monospace">                buf_printf(&amp;out, &quot;IV_ACC=3D%=
d,6:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocols);</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Should we `buf_safe()` here as the above code does, as well?</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/op=
envpn/test_acc=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/5d9ebf1a_bb5=
2c8d2?usp=3Demail">Patch Set #18, Line 46:</a> <code style=3D"font-family:m=
onospace,monospace">char control_channel_mesage_sent[2048];</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">`mes=
age` is still misspelled=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/2f043e08_8ce18e38?usp=3Demail">Patch Set #1=
8, Line 55:</a> <code style=3D"font-family:monospace,monospace">    memcpy(=
control_channel_mesage_sent, str, strlen(str));</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">`memcpy()` copie=
s without a terminating `NUL`=2E</p></li></ul></li></ul><p>To view, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">chan=
ge 1858</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

=
<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 18 </div>
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
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Wed, 28 Oct 2026 16:11:31 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--SyyOjBGZtgA=--


--===============3709808314213256187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3709808314213256187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3709808314213256187==--

