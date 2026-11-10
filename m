Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2089606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Cg47c83d;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=D9CrUngw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=atDjSBt0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NOKVgFKH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MXg6P2GdlyLA0eZQPXs8fADhWiN0eZSy4KfwxG7411Y=; b=Cg47c83dAEXjYYxIwEuxvSV3fU
	XxOfpuRDVayTEJqp2KQpZdcaJ5WrtxT1xRGr9fvnmU69DYeTAaIKZHWhdDSW9wOuhkxLoxGdLgJuN
	pF6VAIr0GmSFJdg0BjRh1EHz/kNJscbA4KSvdv0aY/qWThJKDiHm9SrY6jl3zotmL5vw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQmcD-000000007eJ-0ONC;
	Tue, 10 Nov 2026 14:14:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQmbi-000000007X5-2jHO
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HZnp8XgTneRJZ6CUL96T7/jtxuEVFuguqffkqw/L+B4=; b=D9CrUngwQ1uLznxm8Nd5piJOIS
 pw5F6434PcTRcBRh2xzVtbCbpLcebyGFb1Kh4alQqIVQiGGg8L+u9RkQ6vIvLEOq16PgHjpsDAWV4
 wzHXeWGhn72zKQ69ZolHme1z9uK/1gmK/iwu8UWltorumsuUPxJqQl7ljEglPIEV+3lY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HZnp8XgTneRJZ6CUL96T7/jtxuEVFuguqffkqw/L+B4=; b=atDjSBt0F4rMCWn5vQtJGy6HK9
 tZyOICE9dBtdC/rQrErCW8IT9/fBX4fO2EuzeGKufXnv9sGT/eM/IKR/s6zD7uwW9Hln1Hshhetc4
 RNKQzWIGkRG3d6qwpZkllxsxXedpRkECADVhC+mWvRdfQSlZPhQkIDlPKHJrUi0mWLc8=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQmbh-000000008HL-0Eqx for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:13:54 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so25401605e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 06:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794320026; x=1794924826; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HZnp8XgTneRJZ6CUL96T7/jtxuEVFuguqffkqw/L+B4=;
 b=NOKVgFKHmRTyBqsrhuU/4MMFewlPtImwpeZdP9qKQF26R54kqNuvZ85f8QsjtuU94a
 TBw1vDyHhgb3+Sp3UB2ChIU+vF3a0iMR1Oc/SZ9Uewkq2xZUO4GpPhArQVEzcz3t3oNe
 yKFZ+rIBH5sU8sgE5R8tjRF36vBz2pmg6D60KeUyWAHNErE03eefqSvT0E9n9mr0Vj4W
 aSj+gSqbxCtxtOcYG2qX75JcoYp3GvjsAKOX/uCbGUODFvDCbcr645Px+r5B37Pv4aQ8
 /LOBOfUJgUmd1GQNEn2s+z7biobm8SNCPhbfP1e5hhrsel4OeEOEKYelfRgp1TZclnNH
 ZiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794320026; x=1794924826;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HZnp8XgTneRJZ6CUL96T7/jtxuEVFuguqffkqw/L+B4=;
 b=UgmBy+qBnY6489PNn0vyAFZpp2tjUANtTiuwc2AmEU1Vj8BDEVvB9zNjWU9qt88wX0
 INmQsT4EnZkJJ7wKUIA2t2sAYYvRLRPDFeWBaZDLs/DXLccofw44qvpIPTDfrVAQbLLp
 1WfLfrYBD6IVmlRAuqgXBcDqzCwHiC7532GR1u8iC8fDyiNhGlMrHrlPYplILiS+SPtW
 xyxIZZ/VxyZ4vTxMmmsM0hIQ8zmzRKkqq0m1DCaojbZwwPXyXfFMQfblDii0AFuruUQq
 0Pwv4bO+JeO75eGZERcbHe4OjsUeWqHxigPnSA08ToNTRAVB67IKdOdl0IIJpYYHzSKe
 OhyQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGkaa/fjCP41NkOJzhx15HqD0FdQPiVA8EfSgQSoxNucC7HtvSFy6+Gor5+B3hiQa42CU1hw0w9CsZ6MYa8@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/LJ3vjB3lxmDTSUphl1hVSVyAxHyskpnqwFItBklcB7OwM1Uy3
 GBJrEgGcrU+imlF7hl6LEP3T9IUppWQxYeBiiCDyHO0BT8YHDR/IeUweQsEeL2g9WcXe0qqQoUH
 DMH5XtqaS3A7J9kKgNKscPoocz/kfS2KCv7E3wKhTLxyKkr6/3sFRDTfMN9mNnVVCohogV+aIIa
 rTE58fag==
X-Gm-Gg: AYBFou0GAxVTw7fZNi8VTQTnuXTzniFUO810LRo13aaNZ8E7GfFOtyt3LZ4Kw/ObMpz
 4M+XeLQW6UNfUIwbrJIGSQ0cETjPRd2WY5fjBjwbiRxDB0T2TJiMM/Q6j7CpZuHdmezfr4GiVj5
 lmS/makp6YHrftPi5ZjGxC71fyNm1Yc0pb8N4djxvNGhs/0fUe60Ikqlv27e4JvUmMhiz08RED1
 C8X4ZBzlxjp4O/Gp2dD6oFc8RQ8xGMPxTFGD6mJmJYM0iT0v5oMTDx+RX5aNw5roTjMS0x5VM8a
 f3Xm9K8pM/ebnQggkNARti09ew3/1ogYNUJki9ZyOx8damIIDmx/tBX73eji43FlXeMSd6vIue+
 iOrM1FFFztVnfJAHvAHv878Rx1NKQf3Jtk+xetxAbrCSqaIlNUmneZCpD7LG5F2Y3nrIcvfFP69
 n7/UV+8GVxlBnc/DZTnb0pfm2a4v7V3DBPd4MRN0Wrhl0AiTluUyvrO1FLzU/fBGAYGLF+++V0c
 dqHmlG2ixJgXcoTcSP4lSt6kwYX/Y3ObILswRQRk0OmMBMFLLaRBp2hPPww549bqvqmNzEAZzlS
 YvOX9N0Lk/2/B6Fm/vQo4fTHD+pCIUTAT7ArxulesotznSWuZnEQWxlbMykeIQY9XsIZugK8/GX
 gMx4UwnxVM7KrQw8qmVvgzWe/FqIKVCgxmeFnsgTG9iRMD6JXx3LTA7PNcmBwqjHnCxK1R2zi2k
 vDiVc3uh+4dibLbbcl
X-Received: by 2002:a05:600c:a10b:b0:4a7:4697:dae3 with SMTP id
 5b1f17b1804b1-4ba0234d904mr33833135e9.24.1794320026295; 
 Tue, 10 Nov 2026 06:13:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fef675sm66000005e9.14.2026.11.10.06.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:13:45 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 14:13:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
X-Gerrit-Change-Number: 2157
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2157?usp=email>
X-Gerrit-Commit: b4ea722bae1c48a481b79713c37a670264e4c61c
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 14:13:43 +0000
In-Reply-To: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
References: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkwMmY4ZGYwMWY4ZjMzY2I5Y2QwNGNkODQ0ZDFmMTg5MzY4OGY1MWU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c3c51f6877178d5916d28a6300c9023c210948e6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQmbh-000000008HL-0Eqx
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Various trivial
 -Wsign-conversion fixes
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4062145740467119819=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4062145740467119819==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RJdrKB/eKrE="; charset=UTF-8

--RJdrKB/eKrE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail )

Change=
 subject: Various trivial -Wsign-conversion fixes
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(3 comments)

File tes=
ts/unit_tests/openvpn/test_crypto=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2157/comment/725c6af9_641f4114?usp=3Demail :
PS3, Line 528:     ovp=
n_hkdf_expand(prk, info, sizeof(info), out, L);
> `test_crypto=2E [=E2=80=
=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157/comment/6c2575f=
c_b50af661?usp=3Demail :
PS3, Line 530:     assert_memory_equal(out, okm, L=
);
> `test_crypto=2E [=E2=80=A6]
Done


File tests/unit_tests/openvpn/test_=
networking=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157/comment/00=
56c995_95fb14e7?usp=3Demail :
PS3, Line 46:     printf("CMD: ip link set %s=
 mtu %d\n", iface, mtu);
> `%u` now?
Done



-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
Gerrit=
-Change-Number: 2157
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 10 Nov 2026 14=
:13:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply=
-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--RJdrKB/eKrE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/t=
est_crypto=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157/comment/725c6af9_641f41=
14?usp=3Demail">Patch Set #3, Line 528:</a> <code style=3D"font-family:mono=
space,monospace">    ovpn_hkdf_expand(prk, info, sizeof(info), out, L);</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">`test_crypto=2E [=E2=80=A6]</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157/comment/6c=
2575fc_b50af661?usp=3Demail">Patch Set #3, Line 530:</a> <code style=3D"fon=
t-family:monospace,monospace">    assert_memory_equal(out, okm, L);</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">`test_crypto=2E [=E2=80=A6]</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openv=
pn/test_networking=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157/comment/0056c995=
_95fb14e7?usp=3Demail">Patch Set #3, Line 46:</a> <code style=3D"font-famil=
y:monospace,monospace">    printf(&quot;CMD: ip link set %s mtu %d\n&quot;,=
 iface, mtu);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">`%u` now?</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li=
></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2157?usp=3Demail">change 2157</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f189368=
8f51e8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2157 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Nov 2026 14:13=
:43 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"d=
isplay:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>

</body></html>
--RJdrKB/eKrE=--


--===============4062145740467119819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4062145740467119819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4062145740467119819==--

