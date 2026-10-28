Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F2606A31D
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MYo6hb44;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PEgUA/+Y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cS7ocVEf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QO87IWP6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SG14WDCtAxCo7YTvHHrgz/ajbxAL1+72YhdY8but5aI=; b=MYo6hb44cjIzW9/GMP4ZV29T6H
	blSYFt92OvokVT+pXREoed3fzacDFviDvZyF0YBhtbg8rXfEAeOyVIq7KPvfsYL48XU/3Ow5tSeSR
	QZuY4knoC/OIsA9w8HgUnVUu0Adu5U5OnBuTm6T6qsqykC7m8kN1zPoCbNYqajHNnIIc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMBKJ-000000002BG-0Gc1;
	Wed, 28 Oct 2026 21:36:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMBKH-000000002B1-2CI7
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:36:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=807BaBqt155bWTwGa0bSkIX+dnn1R3pEH0rN5p0riKw=; b=PEgUA/+YpZFhsjPeCTPVk0/c4R
 +ZizSq8KHzwDVjcS76YSWcnUPGgA9IDMt/CzsYZwGPpaqLSZ5hHRwEXlwZnnwfolm+4BozgMPVd4Q
 QklNITSBx7cYp5Zt5iRhgwIzgL+2u3JWo2ykCNlKYCaBjHty8oXtPoxubvh3HDnmdc7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=807BaBqt155bWTwGa0bSkIX+dnn1R3pEH0rN5p0riKw=; b=cS7ocVEfHJ3rEi+QkN11Epf+NO
 leV8ODJzE2WKe3/0X2gOgzpkaPQ+LKf5HY0Zf0Fgn0tTc0eFNEFcAgen9lLBNqkiwMTRN/2D7zFvj
 ZKN6ns3PuWQik508LeLjcsEcgoD5CYM3UarHqp9zFMCw92SCL0xnDmg3kAtFys0fBORU=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMBKF-000000003oZ-47s7 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:36:53 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so18033995e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793223405; x=1793828205; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=807BaBqt155bWTwGa0bSkIX+dnn1R3pEH0rN5p0riKw=;
 b=QO87IWP6vqp3CwFkdL4bJlT+Z8MFnH/T1WziLqAaJYQRy42c9ATtR8UGNnlqagZMJa
 ySSD9W131no66YyYXAfqgWkG2khbT7k2ZDK0C8bUITV9Lg7g+XIsTSAWzPaYTxz9Yany
 XonMvP/ap0uxdRgFIkR4NmAo0/zxpvjSgxSOf2H9EQz2DD2mZwYUIyWahPL6JCE0ifXe
 QjyrFrWtsK+MoDBIaN/4dpgNrdMSzkGvdTCPFRV10xjVCos6QRbIPDiXYbu/2kGy7xLO
 cc7A1nrtro7g5vKWuW21sY6DdhLKjnnWYoMKQ9gL+xFzIqUAGAUURLPKmZ3Y8VPjJ1Wt
 IRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793223405; x=1793828205;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=807BaBqt155bWTwGa0bSkIX+dnn1R3pEH0rN5p0riKw=;
 b=qHvoH4cnjfgaW7tSX7xwRGK1FCz3hh+GDkiRL0c4pCIj0pysbe56tmKfFjgXUZb6ra
 EZmYh2JmuqOAOe1qGoCrJu+jKWpIlAya46wgyTR2tBT2OQbz+lGE7af/tgjtwhJF4JfJ
 tp57WecWDHbJ53n81xiMtIDpT1PrzljeDxSDSCvdiJi+h6c3IB3h7uEFvQKo5JA3z1UH
 ztuTiHurlVK7BJaM/pYu4pJwybbyJvRzttejp5dwNvO7xPADgOnWes2d/KyJJbYZi6Sx
 IWwGC6s1bwodT1Kuk3If6czekFX+u//t2++iETLZa6Y3ZmEOV8+IKp50Q3toy6MkDaV5
 mJqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxT5Oe43BNdzbE3PfzqshTDWr/4cwE77Z6yrz3rJd1BNez47Ndzje/w4MogbcHHNQ7gIfzes2n432hX27a@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJLBPqL+bKjgcbBBbZR7Bcdy/48oyG+BH2DSLi+aHE03hTwJyzP
 LHZ0JAJUriSZ4PkgNlPajZ2BQ9psm5hOuXEoqRIY+LXq6pRGdRcjhpDTghxY0RADxvJGkf4imay
 s6y17inDjshvaiG2f82/ul8VmifrGqGU1uFEsffXa4JFNGCxAyURDAEDvQmBMGfKL77We
X-Gm-Gg: AYBFou2ePxf31dVq5jzlRbnCyCZSa+Taq6W5AYliEo+2WYrMsnTpDnA9csW8p3Buhl2
 A/803nhlZYrrre/gKpc5fuHWg0L+I77FVVwn0JLE7Hl11vX7FUtxFpp/bsN6ioN7upTqVdAXtCU
 j/ZlQ/My4mqsD2ZYB9P+kdtixr3qbQJ7lIKacH6xlriIIkV6GNVFS7zo6gZv0FA046X7wf+dyIW
 ViElgQH7RglVpo7aurAxVNDU+1d3FD2/BVm6GRlbtBpsRjQ2Z9jT/cq748w84uen8NircWSM1eY
 3C9HSTq7Vv8/g0+FJ+nSZiD1Tdh5snQDf31DTcg8GA/TsCmE6rQXE/WlamZLp6c4N839yRG2kTC
 uAo5UDQhgaBbut2ezXdM8YKKD+LAyW/9CCW25DXzB5mJsY0Yp+kZkKxX1P+eIWwbF14wHIz9Crs
 6oFsLU62w1Ma61XNczj/HbKIKlvu28Lw/gumei8FW5fVMfLsnZ+XXoQchPt6Nvm082VbDBIMtZd
 cTM8yGBzSvwXsdyUzg+DilTrsE579psw+tj5R34yuG/yt4A5LLDUnVi2tN0te1JrgxocZ7J+BNm
 eGB0Rs56ZmE4xArQlOBVOMFmB6gWIMJZPD9vLG7VQYSfHwhp3LCc+mpZHuP1Avfa4pB5Dd1DyuY
 W2kt09JkK2N5EIuDgUmYBwd+hXrWgCCY0yE8vorW3a5RzM/1MfM0MbzVnE9LRITf/qu5L5Cmd0D
 cIjQCp97SXP+m/shgta71bTMI0yPHXDTtHVKP9
X-Received: by 2002:a05:600d:8496:20b0:4a1:a6e0:4ce4 with SMTP id
 5b1f17b1804b1-4a9b1434621mr45202635e9.33.1793223405115; 
 Wed, 28 Oct 2026 14:36:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f7f50d3sm28425215e9.8.2026.10.28.14.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 14:36:44 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 21:36:42 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 3f0211e80590dc0a4b7a4b972877b12fc58deaed
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 21:36:42 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b6f6e2b2c65abca27c480e810a158ba73fe15c06-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMBKF-000000003oZ-47s7
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
Content-Type: multipart/mixed; boundary="===============2511525867557390405=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2511525867557390405==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="brRcZGoCIbI="; charset=UTF-8

--brRcZGoCIbI=
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


Patch Set 19: C=
ode-Review-1

(10 comments)

Commit Message:

https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1858/comment/68cd32dc_d13b3020?usp=3Demail :
PS19, Line 15: t=
he network itself to work and can also used before fully authenticating
Typ=
o: "can also use"=2E


File doc/man-sections/client-options=2Erst:

https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/25f693c5_bb43772e?usp=3Dem=
ail :
PS19, Line 15: --app-custom-control protocollist
Also documented in m=
anagement-options=2Erst, with different wording=2E


https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1858/comment/97be640e_0ff3ca42?usp=3Demail :
PS19, Lin=
e 454:         as (:code:`A:6`) and the list of configured protocols (e=2Eg=
=2E
The code sends `6:A`=2E


File doc/man-sections/script-options=2Erst:

=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/95ca79eb_e6eff4c8?u=
sp=3Demail :
PS19, Line 1017:     message length for app custom protocol me=
ssage=2E
Still no newline at the end of the file=2E


File doc/management-n=
otes=2Etxt:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/70b860=
ad_0d48888b?usp=3Demail :
PS19, Line 1393:    arne supported=2E max_msg_len=
 specifies the maximum message length that the
"arne supported"? =F0=9F=98=
=80


File src/openvpn/acc=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1858/comment/e48e3e92_4fe02e60?usp=3Demail :
PS19, Line 288:     return tr=
ue;
Should this function return whatever `send_control_channel_string_dowor=
k()` returns instead of always claiming success?


File src/openvpn/push=2E=
c:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/178aff51_4dbcfd=
74?usp=3Demail :
PS19, Line 277: }
Now the success exit path doesn't call `=
gc_free(&gc);`=2E


File tests/unit_tests/openvpn/Makefile=2Eam:

https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/8e1a6089_f29b61d7?usp=3Demai=
l :
PS19, Line 402: 	$(top_srcdir)/src/openvpn/base64=2Ec \
Nothing in the =
misc tests uses ACC, so adding base64=2Ec and mock_management=2Ec here does=
n't seem necessary=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/com=
ment/d17967be_304cd9b8?usp=3Demail :
PS19, Line 415: 
Accidental newline ad=
ded?


File tests/unit_tests/openvpn/test_acc=2Ec:

https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1858/comment/70e392b7_741f75be?usp=3Demail :
PS19, Line=
 235:     assert_null(protocols);
This duplicates the test at line 209=2E

=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e15896b8=
b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: 19
Gerr=
it-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue@openvpn=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 28 Oct 202=
6 21:36:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--brRcZGoCIbI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 19:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vi=
ew Change</a></p><p>10 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/68cd32dc_d13b3020?usp=3Demail">Patch Set #1=
9, Line 15:</a> <code style=3D"font-family:monospace,monospace">the network=
 itself to work and can also used before fully authenticating</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Ty=
po: &quot;can also use&quot;=2E</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File doc/man-sections/client-options=2Erst:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1858/comment/25f693c5_bb43772e?usp=3Demail">Patch Set #19, Li=
ne 15:</a> <code style=3D"font-family:monospace,monospace">--app-custom-con=
trol protocollist</code></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Also documented in management-options=2Erst, w=
ith different wording=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1858/comment/97be640e_0ff3ca42?usp=3Demail">Patch Set #19, =
Line 454:</a> <code style=3D"font-family:monospace,monospace">        as (:=
code:`A:6`) and the list of configured protocols (e=2Eg=2E</code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The c=
ode sends `6:A`=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File doc/man-sections/script-options=2Erst:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1858/comment/95ca79eb_e6eff4c8?usp=3Demail">Patch Set #19, Line 1017:</a> =
<code style=3D"font-family:monospace,monospace">    message length for app =
custom protocol message=2E</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Still no newline at the end of the fi=
le=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/ma=
nagement-notes=2Etxt:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/70b860ad_0=
d48888b?usp=3Demail">Patch Set #19, Line 1393:</a> <code style=3D"font-fami=
ly:monospace,monospace">   arne supported=2E max_msg_len specifies the maxi=
mum message length that the</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">&quot;arne supported&quot;? =F0=9F=
=98=80</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/acc=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/e48e3e92_4fe02e=
60?usp=3Demail">Patch Set #19, Line 288:</a> <code style=3D"font-family:mon=
ospace,monospace">    return true;</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Should this function return w=
hatever `send_control_channel_string_dowork()` returns instead of always cl=
aiming success?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/push=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/178aff=
51_4dbcfd74?usp=3Demail">Patch Set #19, Line 277:</a> <code style=3D"font-f=
amily:monospace,monospace">}</code></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Now the success exit path doesn&#39=
;t call `gc_free(&amp;gc);`=2E</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File tests/unit_tests/openvpn/Makefile=2Eam:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1858/comment/8e1a6089_f29b61d7?usp=3Demail">Patch Set #19, Li=
ne 402:</a> <code style=3D"font-family:monospace,monospace">	$(top_srcdir)/=
src/openvpn/base64=2Ec \</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Nothing in the misc tests uses ACC, so =
adding base64=2Ec and mock_management=2Ec here doesn&#39;t seem necessary=
=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/=
comment/d17967be_304cd9b8?usp=3Demail">Patch Set #19, Line 415:</a> <code s=
tyle=3D"font-family:monospace,monospace"></code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Accidental newline add=
ed?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/un=
it_tests/openvpn/test_acc=2Ec:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/7=
0e392b7_741f75be?usp=3Demail">Patch Set #19, Line 235:</a> <code style=3D"f=
ont-family:monospace,monospace">    assert_null(protocols);</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This=
 duplicates the test at line 209=2E</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">c=
hange 1858</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 19 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: chugl=
y &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 28 Oct 2026 21:36:42 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--brRcZGoCIbI=--


--===============2511525867557390405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2511525867557390405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2511525867557390405==--

