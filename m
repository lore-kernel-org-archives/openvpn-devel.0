Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8D606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=U+7iUieS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kdiri/qq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=H73Ag39O;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Gg0taHn3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cJb9GTGlZboqw5qCqVuVZrlnSCLIv645XMc+jwIogFU=; b=U+7iUieSt+77yfE91FzdOEXBGy
	dKoOHTcju2sAgiEprfXMZHVV98kmpi4fb1/34FGFkBHoS94MjHKPesl/HyodNOSaxv+/88ivcRWzM
	I9SorCeGsLdS+uK/wgTxMMDgV90nayph9iSinmqslDV7/9w+waiRaLdozfZN/NgdEZUY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM8mc-0000000077m-1BXr;
	Wed, 28 Oct 2026 18:53:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM8ma-0000000077V-38Vj
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:53:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z3GpfS+mYC7fYmZ1cDUUsNw2MBZnjmQvNizTgqy50zM=; b=kdiri/qqM638rxSYBDMoRaddU1
 EXZvwNPibLFMsNAVnZWR2u2Wg+yFptYJ9DWZUEmzHkGsh7K1HN4n8HnMv+zoqbDBBz4MqhxEPUmkg
 37dp91PcPHRt3gAbmFJZYpEe5Vb2pqbDXu4UWEw3ZZq1rWn90DvFZ00p8V8mxv5IgiU0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z3GpfS+mYC7fYmZ1cDUUsNw2MBZnjmQvNizTgqy50zM=; b=H73Ag39O/FOP+fDWAQ982SnNwA
 ph4ZLAnxewaNQg4rZtYy0ULzDVf+GsdwiLp0dSu1iHndEZ7QkfdqaUQWrhSPhfjqW2h/skjhpd6Os
 yVrasTuSXraFqaZ/cF0YL+T+ncCFJ1oEYvOWW4wsacvBiLlvZ5joB+MGOcbn42r4sa5M=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM8mZ-000000000Dq-2Qbv for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:53:56 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so12058915e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793213629; x=1793818429; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z3GpfS+mYC7fYmZ1cDUUsNw2MBZnjmQvNizTgqy50zM=;
 b=Gg0taHn3nXvQ7vWbqNV4XOR6bgO7cJ7edcA7+1m2h6iKlzfDt6OnZ0UcEQq450Mfha
 WD9fFLw0evnxvtCk+t4QGp4lzKFCee98VnU+7j+o7bTd8XTKP+0Z3VMTWbucn5slmgMV
 bI/1XxLQFQaahkaJTHpH/nJquSwMcoEFdoQSyplgoNlU/Vq/+WQcemLpEzis9hM9h0dI
 wnr64ritSafdDhl81SeRkPgGWuKUm9fOr58YWPARZaLYehut8AOb9w9cu+SGfVBohk2g
 xovLcNsnZ15BMMRO1FC3YAOMLySdUv77EGz5BzD1T7TsFiXx5au6fL7A44h+Gb94cvRh
 TZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793213629; x=1793818429;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z3GpfS+mYC7fYmZ1cDUUsNw2MBZnjmQvNizTgqy50zM=;
 b=DviaUNXHoBizDxojGDrkyFpsv5ioo1BJGlt7dOVp9damNY2x0j/JPrKQkX2vhuG6/A
 uCqd1uBNaNd4GulO+fI7yNpuE3xTkPwc82ODjMnrr6RyrGGL7zTBB5K8LuPKbx32ycWm
 6BvT4ehM46DAh1H+kTOAakVmA+d2WD8H6QV/JdZ/PVIhKfHeddbGpz98FSVe10BIX8eP
 fjg/aO2JXUjPG4PFsSgZSsMIDU00bCDaigrWrDVrhlCCTkST06VNEJlsGojvAs5LLN06
 Y87ebp96fqhfhsMnj0FgHrmPg725cc5TLGkFEYeFc6UfDjPA0YGei6umO7ArvmWPvK6s
 SYHA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQ3W5BCCM+SZDoHT89mhmMkjOIzuKsUmG/0H5v3yL1UAsBd3+54XZhXIPDy7BKgBU2MnHk5+vj+aBDP5TA@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIGkOLo829RytA4p38KoZ0oqV8s9huvZCV7qKWiPBkgjLeQgOmT
 rGNDBa2h3RQYk+oXVpXM1XyJ2qcOqLrqcVnmxK/bam2MF6D01HOy4q2Ojuz0DXgH5ySyUE67fUb
 mD/IayjhBFBfApku6iwEFgEBTjg/Dd3bfgqXLgQ3M68hEEgQXJSLjWEgUKlPFmJQmwwQ6IuvSxw
 aG+2nYHA==
X-Gm-Gg: AYBFou3C8SQh2k6JjwlF33v+8DHht5m2klqbhjGD6KUabwAM3DW5brXBl6gX/ugGrMV
 wb9d12FHUABiGRv+iTvVvgllmAJSwF6oBxSYsSUHdS3iQteuqUFiv8QEUt7P3V0UHCAFaPCfNli
 hf4Abk3ZwoAetymT2WMevcTGpyl1GPGW+nRZVlu44CmSaloOdFX7ZELVjTqs+ghDqKMlEJGfwgF
 IhF0iF6ISFOTH57kIZAnAjuK7AEk0MxxDP5oR3v0PmyfwIiPldJJ1PQOxIVzEPvCXcQ/vsdbRk3
 eul6uVsVKGLd5WaUuUWFeJWOq+c2bcmX2rlZbnnISBldrxlYPuqr5LiFtidVyg0cDql2UxZW8hy
 e/hbrQvtkwRArYlXd4gx4ccMAt4COz3B3atOKG1DAvG3ixFVa3g11hJHqB/n9gB6qvEJymteMkK
 s2sRYGDVMi8zFLDLESNxnaSSsj8wg1vbNi8CBdWaNj2Xgk9SlH6pnsuqdL08+V5bW2DdoTEstyL
 iGzv1U5NHgDTmQzKDuijoSHQPAGRIVJSVRO4VrF0D3yYknp8BJcIgMn/bAqHnQxAiLZiYKZRbdd
 7wnGDkSlKSsE5Fq//WFONc7wOWxipbK2n4Zp1FfKUzZkw7YEp5QIM29sve+9F7qSPFy8AqpHYix
 7GnS6VaOEid2MS1JTkfBTrVBOgyCrGi/6zPOnT+ANgJSAB9okk51UbbdBP1m3lTZM2KN4zB/w+F
 IJfauBBffFFNAdOqpC
X-Received: by 2002:a05:600c:a00a:b0:4a3:7344:13b4 with SMTP id
 5b1f17b1804b1-4a966773292mr71224925e9.14.1793213628773; 
 Wed, 28 Oct 2026 11:53:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc39a8sm30912823f8f.11.2026.10.28.11.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 11:53:48 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 18:53:44 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 6d76e0240a1bd038517b7ab46985ba49291a4f91
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 18:53:44 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1597e7bfb8d8466ea28ba5534cf384756b5a57f1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xM8mZ-000000000Dq-2Qbv
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
Content-Type: multipart/mixed; boundary="===============0011275333024278564=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0011275333024278564==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F3fn0FUWmIw="; charset=UTF-8

--F3fn0FUWmIw=
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


Patch Set 18:

=
(12 comments)

File doc/man-sections/script-options=2Erst:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/daf8a1d2_33c9ac8f?usp=3Demail :
P=
S18, Line 1017:     message length for app custom protocol message=2E
> Thi=
s file is now missing its final newline=2E
Done


File doc/management-notes=
=2Etxt:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/b6b45ced_a=
20109aa?usp=3Demail :
PS18, Line 842: -------------------------------------=
-----
> The underline is the wrong length=2E
Acknowledged


https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/20019d0f_c0e2946a?usp=3Demail :
P=
S18, Line 1391:    protocol_list is a list of supported protocols by the cl=
ient=2E For example
> They're not the protocols supported by the client=2E =
They are the common, negotiated ones=2E
Done


File src/openvpn/acc=2Ec:

h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/3e368155_350e8d1f?us=
p=3Demail :
PS18, Line 206:     if (!payload_len_str || !((payload_len =3D =
atoi(payload_len_str))))
> Should we use `atoi_constrained()` here (like `p=
arse_acc_parameters()` does), with maybe a range of  [=E2=80=A6]
I don't re=
ally feel atoi_constraint really fits here since it comes with own logging =
and we don't really expect this to be wrong, so I don't think we need to be=
 as good in telling what exactly is wrong here vs an actual user-supplied p=
arameter=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/e604a=
cb8_f0b7b525?usp=3Demail :
PS18, Line 239:         format_hex(BPTR(&buf), B=
LEN(&buf), 80, &gc));
> At this point it looks like `buf` has been advanced=
, so this will only show leftover text=2E
Good catch, will change it to pri=
nt the contents of the buffer parameter=2E


https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1858/comment/c97ad25e_358a3f5d?usp=3Demail :
PS18, Line 358:  =
   char *tmp =3D strdup(list1);
> The return value of `strdup()` is never c=
hecked=2E [=E2=80=A6]
Acknowledged


https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1858/comment/dab6744f_e5087679?usp=3Demail :
PS18, Line 422:     struc=
t buffer common_protocols =3D get_list_intersection(&gc, session->opt->acc_=
protocols, protocols);
> This uses `session->opt->acc_protocols` but above =
the function uses `multi->opt=2E [=E2=80=A6]
Yes=2E They are the same point=
er but I think it is less confusion to use multi both times=2E


File src/o=
penvpn/init=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/8=
bb65891_03381528?usp=3Demail :
PS18, Line 2286:                    multi->a=
cc_max_message_length, multi->acc_negotiated_protocols);
> Doesn't the push=
 option use spaces? Is intended to replace them with commas here?
Acknowled=
ged


File src/openvpn/push=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1858/comment/b98c49da_1e48308a?usp=3Demail :
PS18, Line 253:         retu=
rn;
> Shouldn't we `gc_free()` before `return` here as well?
Acknowledged

=

File src/openvpn/ssl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858=
/comment/f70d1715_a0ce5e2d?usp=3Demail :
PS18, Line 2125:                 b=
uf_printf(&out, "IV_ACC=3D%d,6:A,%s\n", ACC_MAX_MSG_LEN, session->opt->acc_=
protocols);
> Should we `buf_safe()` here as the above code does, as well?
=
I moved this before the IV_ / UV_ variables where we have enough space and =
do not need the check=2E


File tests/unit_tests/openvpn/test_acc=2Ec:

htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/6cf4f668_cc9748be?usp=
=3Demail :
PS18, Line 46: char control_channel_mesage_sent[2048];
> `mesage=
` is still misspelled=2E
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1858/comment/1ea19026_c928b608?usp=3Demail :
PS18, Line 55:     memcpy(cont=
rol_channel_mesage_sent, str, strlen(str));
> `memcpy()` copies without a t=
erminating `NUL`=2E
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 185=
8
Gerrit-PatchSet: 18
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charl=
ie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Wed, 28 Oct 2026 18:53:44 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>

--F3fn0FUWmIw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Ch=
ange</a></p><p>12 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/script-option=
s=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/daf8a1d2_33c9ac8f?usp=
=3Demail">Patch Set #18, Line 1017:</a> <code style=3D"font-family:monospac=
e,monospace">    message length for app custom protocol message=2E</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">This file is now missing its final newline=2E</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/m=
anagement-notes=2Etxt:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/b6b45ced_=
a20109aa?usp=3Demail">Patch Set #18, Line 842:</a> <code style=3D"font-fami=
ly:monospace,monospace">------------------------------------------</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">The underline is the wrong length=2E</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowl=
edged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
8/comment/20019d0f_c0e2946a?usp=3Demail">Patch Set #18, Line 1391:</a> <cod=
e style=3D"font-family:monospace,monospace">   protocol_list is a list of s=
upported protocols by the client=2E For example</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">They&=
#39;re not the protocols supported by the client=2E They are the common, ne=
gotiated ones=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/acc=2Ec:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858/comment/3e368155_350e8d1f?usp=3Demail">Patch Set #18, Line 206:</a=
> <code style=3D"font-family:monospace,monospace">    if (!payload_len_str =
|| !((payload_len =3D atoi(payload_len_str))))</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should=
 we use `atoi_constrained()` here (like `parse_acc_parameters()` does), wit=
h maybe a range of  [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I don&#39;t really feel =
atoi_constraint really fits here since it comes with own logging and we don=
&#39;t really expect this to be wrong, so I don&#39;t think we need to be a=
s good in telling what exactly is wrong here vs an actual user-supplied par=
ameter=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1858/comment/e604acb8_f0b7b525?usp=3Demail">Patch Set #18, Line 239:</a> <=
code style=3D"font-family:monospace,monospace">        format_hex(BPTR(&amp=
;buf), BLEN(&amp;buf), 80, &amp;gc));</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">At this point i=
t looks like `buf` has been advanced, so this will only show leftover text=
=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Good catch, will change it to print the contents of th=
e buffer parameter=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1858/comment/c97ad25e_358a3f5d?usp=3Demail">Patch Set #18, Lin=
e 358:</a> <code style=3D"font-family:monospace,monospace">    char *tmp =
=3D strdup(list1);</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">The return value of `strdup()` is =
never checked=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/dab6744f_e50=
87679?usp=3Demail">Patch Set #18, Line 422:</a> <code style=3D"font-family:=
monospace,monospace">    struct buffer common_protocols =3D get_list_inters=
ection(&amp;gc, session-&gt;opt-&gt;acc_protocols, protocols);</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">This uses `session-&gt;opt-&gt;acc_protocols` but above the funct=
ion uses `multi-&gt;opt=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes=2E They are the=
 same pointer but I think it is less confusion to use multi both times=2E</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/i=
nit=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/8bb65891_03381528?usp=
=3Demail">Patch Set #18, Line 2286:</a> <code style=3D"font-family:monospac=
e,monospace">                   multi-&gt;acc_max_message_length, multi-&gt=
;acc_negotiated_protocols);</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">Doesn&#39;t the push opti=
on use spaces? Is intended to replace them with commas here?</blockquote></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/push=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/b98c49=
da_1e48308a?usp=3Demail">Patch Set #18, Line 253:</a> <code style=3D"font-f=
amily:monospace,monospace">        return;</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Shouldn&=
#39;t we `gc_free()` before `return` here as well?</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowl=
edged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpn/ssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/f70d1715_a0ce5e=
2d?usp=3Demail">Patch Set #18, Line 2125:</a> <code style=3D"font-family:mo=
nospace,monospace">                buf_printf(&amp;out, &quot;IV_ACC=3D%d,6=
:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocols);</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Should we `buf_safe()` here as the above code does, as well?=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">I moved this before the IV_ / UV_ variables where we have=
 enough space and do not need the check=2E</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_acc=2Ec:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1858/comment/6cf4f668_cc9748be?usp=3Demail">Patch =
Set #18, Line 46:</a> <code style=3D"font-family:monospace,monospace">char =
control_channel_mesage_sent[2048];</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`mesage` is still =
misspelled=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/1ea19026_c928b608?usp=3Demail">Pa=
tch Set #18, Line 55:</a> <code style=3D"font-family:monospace,monospace"> =
   memcpy(control_channel_mesage_sent, str, strlen(str));</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">`memcpy()` copies without a terminating `NUL`=2E</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2=
a6de86b8ae4c84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 18=
58 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 18 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: chugly &lt;charlie=2Evigue@openvpn=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Wed, 28 Oct 2026 18:53:44 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan =
Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--F3fn0FUWmIw=--


--===============0011275333024278564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0011275333024278564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0011275333024278564==--

