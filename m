Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D087606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=igaFZqIY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Qc0pxRLp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mDQMPo6R;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aWUpmVHd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6GeRVtd+HR3p+PsW/+u6h5YdB+75Hn0A9maes2Awrf8=; b=igaFZqIYKK8DC5SXWAlGbNaIbA
	QvaIxDVUPgDMncX87afUvrjLbHlp8poriucGziUnPM7B2TZCAsIfBKDTDdSOzZLMp1Q9WeyArd6Ua
	3/U0PbZajASTepCsqHksCUzvu0bvr98CWhJ6OUdLLWfAjxWnU/ECvLwodb8rU3IkyPhs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLjh5-000000004FX-45az;
	Tue, 27 Oct 2026 16:06:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLjh4-000000004FO-1EjP
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 16:06:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E9HoIbXEq1sMICTuLKia1NottY97I4MBZincoP0j+jA=; b=Qc0pxRLps4Z4n5r7IQticm0c/y
 2XyaM3xBErgedy+pt2KN4UR66ccx81dFAbEzaJdA6e/efeNHiZ5ZF6vTGftRa9yW8kH5q/Lr/jqKf
 qdzo4D80oBvMwKcWTz3PJjvifw8NhYa1kb/96jR1ICqfEtOWcQ1KRwNHsruLlzf4hcZ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E9HoIbXEq1sMICTuLKia1NottY97I4MBZincoP0j+jA=; b=mDQMPo6RanKNwJnnDoETuqMrO/
 q0k67NEBf7JcRDIuXD9uPS83jQo9hNCSoQ0gg+HG/zbsJr0gjr+N7b/fDCgOGhi5y3JlbOmFGTxMK
 O+PKOcLCv9SEkDakSTXNQ2Wgyo+0a5t38uoljXYaN0WJeu1eE6XiAlfTjoIzZcMQpiQ0=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLjgz-000000003Vw-3emD for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 16:06:34 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4956869750eso29206225e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793117183; x=1793721983; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E9HoIbXEq1sMICTuLKia1NottY97I4MBZincoP0j+jA=;
 b=aWUpmVHdEA5Zw+mALPxtdYg9QvqyNzMIig7XDjw7EVJgMKuRVevrSV1X8c+TYH4/gl
 ERXmIn1YhvXrFSzvdmNo0Xikg1cgxjARolFnj9lykku5OHiC6i2b+IkZ2NJaZcNIncjo
 Db2DlKe3lkquSW6LSmXhEltRSj2Zfzjnt5JkIHRHWuQSaCZeXvzTAGvvixggBOStVY0J
 9N2O/6WqQmM/E/qjzjGQeH3LnMFoISHoRypo9RB4vCjkk0WGh4eCPNXx80vA341mmzaB
 OlmlCV1kDFWiCHQLdtHM3RK5vEjEQ9Td2Zt2maCWa7/P/chQykatOZbFcAG2RiUWezD9
 Rx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793117183; x=1793721983;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=E9HoIbXEq1sMICTuLKia1NottY97I4MBZincoP0j+jA=;
 b=au4UhXlhWhYsheI17pbfuFHntxfQrAMmcHXpzZMrMUm9qFAINuv9WiyL1M6Vv2HrP1
 y2PMyKtubXFAVL6JxgfJhwr0ASGOlYvOssnzJcaVQcGweNVuDYiUnJTbz5+OaYcB7RJr
 j+IMib5lZDSqiPJqJgURqmFU+mFtYJi3hmyy6VlBcsvbjvZttk0wGSoffxfxT04JSNFp
 /P2JpMLonjF+bXdL9kA+gf0ENvmgxKz8BjpnsxoSuaCShB/DJkbdCs7gvLsOa7Zc/MMP
 mHjO8rwNAlmjuXEvGMpxp+31wgwP813vn7tsZX6ZgM5cQ8RXzBkGqSvbL1fWrUHKco/d
 1ajg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZKW6ZEMtLcSLbv25RtS4SVi2dvVIQrtl6gqLRT33wESgIH5iYTdt83eBOxkwaTOhlgk7upEzU+j/jtWLY@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI/NHzDYWON90gpiwoVI4ap+cyLMwwGieLY4tqgSg0u4JHYNGmL
 UUxAMBYEpkqQVUm6F9Pe/jZeodAcIYEIl9oyo3cEdW67rRKQVQ9hDZh+93c28rXPfi28G1hTgRo
 r4waqlCTJROjUcz93RgEQZwXMEHTQouO9SIcU8/GsDj16guH4vkWNs0tl0pC5lyQpee1dv3Rolf
 Uwgfx7/A==
X-Gm-Gg: AYBFou2hLaJr3h7f61S0Dju4K48Z3q33HzyMG/JEJRbzgwMtz6ube3D5sr3A78pXjCD
 e2zkYvnZ9/HXOLb5H0sfDmdp7rPs3YgBjoHw4yguO+Rwfcq14w357d30k7SA8ven4RyU6ujLIVS
 s+dtJzQ4fXWPPxC6rqpKfCo8bMxNxxG2nO8230f1XHpjlx64mt5qICZyOOCppCYdQha8RBPFs9F
 mYWYK9Bb1YGujPCIbxjwkuFQxC3UP4nyFJOnoy8J0ElkkvfuklG79iRwbZ1n4z7tbZuzNEKHvjn
 NMggvTRxMPywGU4CFuhI25x5HoIi3e343ALfnIrGWcR/b5mgChGFbX3/pJZ8u4u7jvHPPjGOI5y
 T05x0S+9tV7LsWUO+Wje+sbBxd5eKBk/ffOp/ukdaxcZq5tr3kqy1L57Z+F3+oz2IndUI9SltQ8
 GWuVzxeJVmYdUhhcFuz6MLUuM/JE3PGxyrnJmM687pimge2ama8K6HWzBM3Gku2GVJcdlX6VmxK
 UEae41zQdXBTyp9EXYC9uxT8oXaYKVSeSHe9+Ku0foR1t/n+UgYtcv/Btqi0uVt9FhfgC8EF/co
 1vW666DKucErgsD55qBfagWf84ytFJjj3dCIM9G8umtDdgtgOesjRbbE3MtumWMCyzOQoqUd5K/
 HFr14+WoDicvi24i+iNSlpfYZjG4tR+Re+qMFOkMPTYc=
X-Received: by 2002:a05:600c:5253:b0:4a1:ce33:1536 with SMTP id
 5b1f17b1804b1-4a35ac8ba79mr179010605e9.9.1793117182978; 
 Tue, 27 Oct 2026 09:06:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92afd54c2sm589205e9.5.2026.10.27.09.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 09:06:22 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 16:06:20 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 6380386c5690d29661f083b8501d2f65ee967f24
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 16:06:20 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4600c785b935c0add245d4dd41036fef9cf36900-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLjgz-000000003Vw-3emD
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
Content-Type: multipart/mixed; boundary="===============8331568645231634199=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8331568645231634199==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IZBJo25ZlBY="; charset=UTF-8

--IZBJo25ZlBY=
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


Patch Set 16: C=
ode-Review-1

(6 comments)

File src/openvpn/acc=2Ec:

https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1858/comment/960c4fa9_a66eb1d3?usp=3Demail :
PS16, L=
ine 207:     log_acc_message(c, &buf, payload_len, protocol, flags);
Should=
 we drop ACC messages that are not within `acc_max_message_length`, or from=
 a peer than never advertised `IV_ACC`, a protocol that isn't in `acc_negot=
iated_protocols`, etc=2E?

Is client-side checking alone sufficient?


http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/86c0b192_2fe943ba?usp=
=3Demail :
PS16, Line 372:          * again would just add an extra string =
allocation to options->gc */
We're no longer allocating to options-gc=2E


=
File src/openvpn/init=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858=
/comment/8159d180_294f8fb1?usp=3Demail :
PS16, Line 2283:     if (multi->ac=
c_negotiated_protocols)
There's a line higher up in this function that chec=
ks `if (c->c2=2Etls_multi && c->c2=2Etls_multi->use_peer_id)`=2E

Either th=
at is wrong to check, or `c->c2=2Etls_multi` can be `NULL`, in which case t=
his will dereference `NULL` below and crash=2E


File src/openvpn/multi=2Ec=
:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/c5d47f7a_cf09d70=
e?usp=3Demail :
PS16, Line 1741:     struct context *c =3D &mi->context;
Th=
is function only uses `&mi->context` but now takes `mi` as a parameter=2E I=
s this change intended, or leftover previous work?


File src/openvpn/push=
=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/4a40d561_55c=
48e40?usp=3Demail :
PS16, Line 262:     multi->acc_negotiated_protocols =3D=
 string_alloc(protocols, NULL);
If `acc_negotiated_protocols` has previousl=
y already been set, this leaks=2E We should free before assigning=2E


File=
 tests/unit_tests/openvpn/test_misc=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1858/comment/0aa193c3_52844930?usp=3Demail :
PS16, Line 71: }
The=
se new mocks don't appear to be used anywhere?



-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Ger=
rit-Change-Number: 1858
Gerrit-PatchSet: 16
Gerrit-Owner: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Comment-Date: Tue, 27 Oct 2026 16:06:20 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: Yes

--IZBJo25ZlBY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 16:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vi=
ew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/acc=2Ec:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1858/comment/960c4fa9_a66eb1d3?usp=3Demail">Patch =
Set #16, Line 207:</a> <code style=3D"font-family:monospace,monospace">    =
log_acc_message(c, &amp;buf, payload_len, protocol, flags);</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Shou=
ld we drop ACC messages that are not within `acc_max_message_length`, or fr=
om a peer than never advertised `IV_ACC`, a protocol that isn&#39;t in `acc=
_negotiated_protocols`, etc=2E?</p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Is client-side checking alone sufficien=
t?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/c=
omment/86c0b192_2fe943ba?usp=3Demail">Patch Set #16, Line 372:</a> <code st=
yle=3D"font-family:monospace,monospace">         * again would just add an =
extra string allocation to options-&gt;gc */</code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">We&#39;re no longer=
 allocating to options-gc=2E</p></li></ul></li><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/c=
omment/8159d180_294f8fb1?usp=3Demail">Patch Set #16, Line 2283:</a> <code s=
tyle=3D"font-family:monospace,monospace">    if (multi-&gt;acc_negotiated_p=
rotocols)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">There&#39;s a line higher up in this function that che=
cks `if (c-&gt;c2=2Etls_multi &amp;&amp; c-&gt;c2=2Etls_multi-&gt;use_peer_=
id)`=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Either that is wrong to check, or `c-&gt;c2=2Etls_multi` can be=
 `NULL`, in which case this will dereference `NULL` below and crash=2E</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mult=
i=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/c5d47f7a_cf09d70e?usp=3De=
mail">Patch Set #16, Line 1741:</a> <code style=3D"font-family:monospace,mo=
nospace">    struct context *c =3D &amp;mi-&gt;context;</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This fu=
nction only uses `&amp;mi-&gt;context` but now takes `mi` as a parameter=2E=
 Is this change intended, or leftover previous work?</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/4a40d561_55c48e40?usp=3Demail">Patch Set #1=
6, Line 262:</a> <code style=3D"font-family:monospace,monospace">    multi-=
&gt;acc_negotiated_protocols =3D string_alloc(protocols, NULL);</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
If `acc_negotiated_protocols` has previously already been set, this leaks=
=2E We should free before assigning=2E</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_misc=2Ec:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1858/comment/0aa193c3_52844930?usp=3Demail">Patch Set=
 #16, Line 71:</a> <code style=3D"font-family:monospace,monospace">}</code>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">These new mocks don&#39;t appear to be used anywhere?</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"=
> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 27 Oct =
2026 16:06:20 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments:=
 Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</b=
ody></html>
--IZBJo25ZlBY=--


--===============8331568645231634199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8331568645231634199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8331568645231634199==--

