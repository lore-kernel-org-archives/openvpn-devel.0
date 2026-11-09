Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B8606A325
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZiWOMoOu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nOaS1Fpr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dE9rac/4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RooaNDVy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xOMM5h7mXrAjeSmZYDAoZzWgQ2lUC0wxeyMSucGlb5g=; b=ZiWOMoOuFdQ15mbd/LMUv6nssH
	g1KGRo2k1gSVMNtx10HqjtoTlTozCMdr2MxxloDwCB9UtMpQHESos7cR4abpltebfC40D3nt8xD/8
	ppNJsXpp+YAT/QjaS5KwXPNWbd5GvjhiUqa3SiGsmQEN2dIIIbhDRYXNbwm77I2Fi/8E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQP2A-000000004II-3n5c;
	Mon, 09 Nov 2026 13:03:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQP1t-000000004I0-1UdA
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 13:03:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m3qENbX9Gb5jWPjrS9mJk18giT7t6QSWq6OMJcXgMNs=; b=nOaS1FproMy361nIi7+XigpKoT
 GFsPe7cxy1+628nzl9LHR1N4hF/BwjK7P4XggODlYhYSSJincADQTn5WB6prKr7aU5bCGIJ6q7sL3
 Cz5y9hn55IiHjCz2oZK17w1A6UQ1YI1fYxS3sqphId3WA5TPH5bqL80ZTJvr6+Jjdl9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m3qENbX9Gb5jWPjrS9mJk18giT7t6QSWq6OMJcXgMNs=; b=dE9rac/4UkRkn4Nyowiz3JevoH
 i2zf7vZt7ab/34Euc7BzVbdStVtja2baFrB5nmqS9cGCB3aiIKwJI6eHQJdR7b5i53PmCZpbDHt2N
 R/9U4f74cKUl2EGUG3pn7scRPl/IfMNMamzUJIG2VLkWMe6AEaBsahj18QmeU+NvFVts=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQP1r-000000006wP-0u2N for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 13:03:19 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so7475325e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 05:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794229393; x=1794834193; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m3qENbX9Gb5jWPjrS9mJk18giT7t6QSWq6OMJcXgMNs=;
 b=RooaNDVy34PL2seB3vfBe+Uy2CLrphazcjgUwWxdrLzeAV9BiDHv4+dLXsIRhWDsE5
 15NaanAj3rVghpOfhAOtDSf84lHLlSsQmQ0tB3Ot9/XUFtKmxgaGOqrTerodFUu8nmg7
 Oib+BcaaYl/w8Oc9neqG3tWRPB6EScIRl4vjLWKW+qO72XVUROkSBnkfMpB++7GDzgtc
 1nWekLk0Y95DlM1eg2EdX6vox2GmQHAfYonf3ptCj2LOZaIW/bUiFWAzFW3Olhoth2ze
 RtV9NwVUBqTca+G9hMct4BceWGl+ppucDRBMGTP6E236VRJomwGfo+tvsilmVTlK/VR2
 ZGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794229393; x=1794834193;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m3qENbX9Gb5jWPjrS9mJk18giT7t6QSWq6OMJcXgMNs=;
 b=VRIcuPhQoiQlvN0Wu/CBE6sCS5yNCA6TAZgOwx0NT/KdUz0qLbmKUXg3So+0eNyFcZ
 otmEFf+PJTf32lAKVGUlCFiq6AJEAExRWUZMWs3kdmvXwWNPjAZ8WocMCVOf6dVQiips
 0I/bLvK97+l+ip3aVd1r4wUVqtx3kYqzVVw2IZbntZZMp1nvnMDE2dhJtI2Mt9MFRQJB
 wIEvJRQwOtGEOZWPIEDCItauzTfha/S/aBtuhPplYhKkIaruzplISaXOsnHmL0cOPYLi
 5P8puNLKxTNo1unxKpq/hm2QREGey6C9U4Lpt2hD0q3Z6D1LQtZcN4bqhYHtBMu3eibL
 Eh3A==
X-Forwarded-Encrypted: i=1;
 AL+hErHCAV9bsV9CyW03avpGgrzpb5B/AB800SDNiqkM4l7pYcpoVOF9HM4sbi/UjfLIB9L3SiH8S3i2FQXsYg3s@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/ChJiLAonoJu+bHsGRgqYVD/awFBvtR0gcN0Ugk0JLoKlK0OZU
 P8T204BjMtfJG990uBEQuUac+jWRSFR3wd/qIAN4+4ERupoYsceoR4TEe2WckmBcy/ouOdR5CDT
 0+zSks2eX6Hukyep3lAKSaBEyBAyj8/sVcLKpl8S8+0X4MYD5m/x4P0StHc86m5WM+Zt6
X-Gm-Gg: AYBFou0SbpZvo91DMVQqoZz1m1MPQD+UykG4uQD7u5fVeP15PEQCGTc0pbQwe7nMKKQ
 P4ixzTsKsM4Ay7kIHod9j1s0a3kYyEXjbK+mhJ30rWPES+LWR+PgCtVvLJSTNSRzBAu/gbM9SxA
 MnlcLK1qJNe3Z7uXfZeGdRaG4VHL5nQUoc3b2qITSWf3Dsg//OvPRCvpcFc9BHST0tKiZmxcYvX
 c3sVugcMnc/7W5FDQCVFZ1Z9PUcowl7XTFOncKZeb1YtzyOzUzwHWf+0ysecClXJyunZRWliE+Z
 OSFKHsfs1kWD/vxJpXF+LMzfUb+sjwNvNZ36ioBW4VAJoye6LkygNUWpy0AfnabmqtqdX4ojzwF
 OM4meV+u2U3UkPtMavS0rGgevhvjLyaWCBA8k348rjowkXt/NEHypD7jTput4MDrZJxDAwRjD0N
 WUO24nsgCaxcr6CUmcEbf7cLKoeCHESmPOnqVMQKGFeuJUFJ8Lnd8gjbL6e4a3hMKupXI/AD9V0
 wgMj/wXwjPyUzjwolL7VWK7MaM9lbq7O1YB8CTA7Os3G1A981s2K6qArLv5IIOniIADNxt4fcjr
 1CtJGGgzkYa0mQ1Hutq1gFFxLZB5RFc8DC9Uh5ogl3+qDxbdPOcBXjWAxPuVtQf96SiDD7kSmCc
 lPM7a5WNVNVdlX7Kwm89iRcBKW7fJeVAdCyzH6uFOjLrx9AzoR9CBPmNgyCtNy8/iMyHTik5LlT
 y0J5dQGLWviYD31g==
X-Received: by 2002:a05:600c:3f18:b0:4b0:a307:46f8 with SMTP id
 5b1f17b1804b1-4b960da4c17mr74486975e9.10.1794229392431; 
 Mon, 09 Nov 2026 05:03:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596f9ab14sm9127831f8f.29.2026.11.09.05.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 05:03:12 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 13:03:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
X-Gerrit-Change-Number: 2155
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2155?usp=email>
X-Gerrit-Commit: 3eba815527c82563ce47b123e60207b0a2b9aeef
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 13:03:10 +0000
In-Reply-To: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
References: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MTM5MTIxMDAwLkk2MDMzMjFhZTY4OTNkYmRiMDU0ZGVhZTVhOWJmZjVlNTJjYmI3NDI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bb4da6c7ef9ca9c269f9d26e74ff88740030335f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQP1r-000000006wP-0u2N
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Check the result of
 unchecked allocations in the server
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0833788374725540781=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0833788374725540781==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FZ0JeQ9Agv4="; charset=UTF-8

--FZ0JeQ9Agv4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Alexandre Laroche, Arne Schwabe=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Alexandre Laroche=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail )

Change=
 subject: Check the result of unchecked allocations in the server
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comm=
ent)

File src/openvpn/ssl_verify_openssl=2Ec:

https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2155/comment/58b3706c_1a420560?usp=3Demail :
PS1, Line 327:=
     check_malloc_return(buf);
Or maybe a better fix here is just to pass `=
max(1, BN_num_bytes())` to `malloc()`=2E



-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
Gerrit-Ch=
ange-Number: 2155
Gerrit-PatchSet: 1
Gerrit-Owner: Alexandre Laroche
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Alexandre Laroche
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: =
Mon, 09 Nov 2026 13:03:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
No

--FZ0JeQ9Agv4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Alexandre Laroche, Arne Schwabe=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Alexandre Laroche=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_verify_open=
ssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155/comment/58b3706c_1a420560?usp=
=3Demail">Patch Set #1, Line 327:</a> <code style=3D"font-family:monospace,=
monospace">    check_malloc_return(buf);</code></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Or maybe a better fix h=
ere is just to pass `max(1, BN_num_bytes())` to `malloc()`=2E</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2155?usp=3Demail">change 2155</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2155?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7=
429 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2155 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Alexandre Laroche </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Alexandre Laroche </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 09 Nov 202=
6 13:03:10 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body>=
</html>
--FZ0JeQ9Agv4=--


--===============0833788374725540781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0833788374725540781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0833788374725540781==--

