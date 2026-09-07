Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19955C79F89
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HE1zzQ0lx7R+t2GXp1PgUaoazUugDUAktyS7MXIHA+U=; b=MCH0831Gj5QFtU8U6KX6dm1EJV
	GZmMHXphuk2lW1QFlE8tJZ+exUt7rnvwCFZ0lSG59OEAlY32a02iWWj7Wk1tER2LB+9kHcq0zAVA/
	hEa89kd5OTHTVNDZqPuwTarBYEy4ZyVvJcGcSfn8zZ3WQGx8opyse132fjqa4LLBdkJ4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3W5V-0000qz-26;
	Mon, 07 Sep 2026 09:56:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3W5T-0000qq-NW
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yxSadFDdOWHK9zZ1oISBfrONbYnSrdLk+H1pYC+EgyQ=; b=nLYe7BCao/bJdVqp/ilN7P7A94
 ehPJYyq7e9LFC04n91ty6hqbP5o84ciyUeL6QOP0OW8hSDTJRLnb2B07EyvdJ27A8rEpo5+dOyKdL
 yNdkYa2lMt5GZwk0AUF4WxEUuHl8iaWAQToGTkWY/krODaeDn5c3nuEK5UK7sliJeF/4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yxSadFDdOWHK9zZ1oISBfrONbYnSrdLk+H1pYC+EgyQ=; b=T
 ONdWg3O4XaUVJ3MNVlYrBENIwZHyi48z9E0pCGKLmnA948gjvfWuGo5U20C0Wuv1D91bHsmVhF4EP
 y3PIryM1xfQzOhpClKU8g4zhbVXI1X6vYaXO+6xvCaDmG2siinRxEKDyRCeVJCFOnY1T0ZDhuXpFx
 LTKh5gQ8f6abhRhs=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3W5S-0000nN-BU for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:56:28 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-495590dde14so48010785e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 02:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788774980; x=1789379780; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yxSadFDdOWHK9zZ1oISBfrONbYnSrdLk+H1pYC+EgyQ=;
 b=a0TK7nbDUbVUsv7h8+Wjn2H7kFb741YPdVO2vlPcHTaMmRMooeC3sOHkj2r2DukmVx
 TZEnTQ8Z97/YrlrH+TEOJnTEgWZvg3F5nREN8M3uf7SaqR4hVcmZ74BDIgmZnggTd5dv
 seolldqHs2BSQgVfO35bY3h90yMCij5B0uSakSTstVQ20Se5bI4IG3/CQFnODZ023iV2
 N14/7jBlRAtm4A+cbRF87VtFMmA2bRJjnPIHHXC641QirHWsH/qfF1Jk3HWhb3TlM8SC
 L84QrxQ3evQDW0E0ByBBGxECeQXyP06r2Fd42h1ZaM/0lz/XcALcgwCtTAxcdtId+hWj
 WqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788774980; x=1789379780;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yxSadFDdOWHK9zZ1oISBfrONbYnSrdLk+H1pYC+EgyQ=;
 b=nplg3rKH9uqCpKhQ4K1TGiFYlB8fKOKlcyQVUgeMBMP3hTJx/Z637McwhewVnHe/Q6
 roQ15UNInPpOlhkWqBQqT5HCNQAXLmP2fh1X9tiZLXUeK6FUhRc63H95cD3H6X313TWm
 qUh/1qOwJinl5xsbZjA7wxei742rmp1+YAVQjSXn0PuDLQRCjPRIYYTyX731UFsKKjDB
 6oxelLNAmBBxNiV425znKov3wAZifYL6Al4wdt3P6zKfviioPz4nr1+bQNrew5JzntZS
 nWAliHQqwnr2eZp/zIM96GCQeDUsEa4V+CHLTRgqOx0gFUoTGY81AQqwCmTQOjZZanbb
 2ynw==
X-Forwarded-Encrypted: i=1;
 AKwUvBymSO4YVeh4qtinPerIOjt81ijm4Q1sF+VrzeknwYlx5nnuH5fHm4/s2kwyJryLwvuOsMxB2FG5UlbV+lOS@lists.sourceforge.net
X-Gm-Message-State: AFuF++kq8RY2HyDfHfF8B98leeJl7hOkdDFAl92y9BDQe1JX/Hvxrcmf
 PAVyfAsu6tklGkq/o6u+v/ol9vcs7TQBodQ+urQv79peBJZMYNYadSVhk3IpU5hy1UR8FRaylZn
 pNYBz0LVbn/pUNHUudXcDx8g8SXz5tH1uj8uddnvhb1YI/+BfTUAz22+D/V4Z+w6WUvcdVVFqyZ
 UVYKXW5A==
X-Gm-Gg: AYBFou3FBpo7WRO0QwIrZzXFO9U2EACcy/yYITWe5wc8aaTJh0GQFAWEjosWKClpqpu
 ppGW5hUqw4QCE5dV2E+bVoUvv4k2F5hK/CYcXM/Rp86s0VYbEH3oigB1Fzl9ld52V+FbZfP8BzA
 e5fRsa2EvycOFIZFUC66wRPIJnN374R7PEf/qpw6TE+EaRIyONgoOiAqRr4UOZ6xC475/vnoQoj
 75jNYGAe6EebLyzrLG8p/qRnqZUVfI3WFp579Aftf8ydMNH/ZRG0YGDjU6t4g9Twr7smHDFkhLw
 69y3+CeIeTlQYY9FcXWKeQ2L19EElyZSO2sMEQ1LiVWqH0XXrHmuFaG/h/TLD+ejVQl826UueiG
 jZQs9HEBAAgQnxNlXEeD9DJi9GPkQFNT/nNuSW2vJ1HTnwHCQqgU8U5LiA/uc+icJp13m5mEtL4
 Fk3pxlmdnSi0dm0N623pJ3GnYlVEkPbMXCRjtXQvjDcGYPfelo00XglhfchsYxnVNXsisN2JJNE
 NFhXIzmhBBNa8qlGQnIPVQjeBEbvPoxG9Ec5/MezKOtiFB6+p0O4cVM4dqdkZQADVyCE1CEfcz7
 fzTQmVeV3XJwIYQS3m0WokRupjQ3rPSbMMO+eMo37lzJ4o75Fa8X
X-Received: by 2002:a05:600c:6214:b0:49c:dca4:94c with SMTP id
 5b1f17b1804b1-49cf825115bmr440445175e9.13.1788774979432; 
 Mon, 07 Sep 2026 02:56:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm811553745e9.0.2026.09.07.02.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 02:56:19 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 09:56:18 +0000
To: srkyn <david@srkyn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: 89a1011cb5d3a17d56b5fdad59531d8be8e20835
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 09:56:18 +0000
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4d37216e572d51d00a1a3bee359215961db807ac-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3W5S-0000nN-BU
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, david@srkyn.com,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9157729647043798064=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9157729647043798064==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="32iNFdQDXXQ="; charset=UTF-8

--32iNFdQDXXQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, srkyn=2E

razvanc has posted c=
omments on this change by srkyn=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1881?usp=3Demail )

Change subject: compat: close all unrelated fds in =
forked helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 4:

(15 comments)

File CMakeLists=2Etxt:

http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1881/comment/539ea40c_e5e98995?usp=3Demail :
PS2, Li=
ne 699:             )
> This makes it look as if test_close_fds is somehow =
related to test_cryptoapi=2E [=E2=80=A6]
Done


http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1881/comment/7462133d_279dc489?usp=3Demail :
PS2, Line 852: =
            tests/unit_tests/openvpn/mock_get_random=2Ec
> Do you need `moc=
k_get_random=2Ec` here? The Automake version doesn't add it and it seems fi=
ne=2E
Done


File src/compat/close-fds=2Eh:

http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1881/comment/6dbe1f11_567fd97a?usp=3Demail :
PS1, Line 13:  */
=
> The rest of the files have a more comprehensive block of text about the l=
icense, we probably want to [=E2=80=A6]
Done


http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1881/comment/4023b0a5_04fb73fc?usp=3Demail :
PS1, Line 19: vo=
id close_fds_except(int keep);
> The new function lost all previous (Doxyge=
n) documentation explaining the need for it and what it do [=E2=80=A6]
Done=



File src/compat/close-fds=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1881/comment/0f8f44d9_be569440?usp=3Demail :
PS1, Line 12:  *  as publish=
ed by the Free Software Foundation=2E
> Truncated license text compared to =
existing files here as well=2E
Done


File src/compat/close-fds=2Ec:

http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/1501e466_54f5b66c?usp=3De=
mail :
PS2, Line 39: #ifdef HAVE_CLOSE_RANGE
> I could be wrong (maybe I mi=
ssed something subtle), but AFAICT this path can never be exercised unde [=
=E2=80=A6]
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/0c=
59f966_7025f8c8?usp=3Demail :
PS2, Line 42:         const int lower_closed =
=3D keep =3D=3D 3 || close_range(3, (unsigned int)keep - 1, 0) =3D=3D 0;
> =
=2E=2E=2E and please avoid complex conditional operator constructs with sid=
e effects in assignments=2E [=E2=80=A6]
Done


File src/compat/close-fds=2E=
c:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/1056f83b_1857d0a=
4?usp=3Demail :
PS3, Line 1: /*
> It looks like all the other files in src/=
compat have a naming convention of compat-*=2E [=E2=80=A6]
Done


http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/d89b0a25_26c6a7bb?usp=3Demail=
 :
PS3, Line 64:     }
> This can probably be done in a synonymous but shor=
ter form, i=2Ee=2E [=E2=80=A6]
Done


File tests/unit_tests/openvpn/Makefil=
e=2Eam:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/05fbb928_b6=
b56f7e?usp=3Demail :
PS2, Line 52: close_fds_testdriver_CFLAGS =3D -I$(top_=
srcdir)/src/compat @TEST_CFLAGS@
> This is the only testdriver whose CFLAGS=
 omit `-I$(top_srcdir)/src/openvpn`=2E [=E2=80=A6]
Done


File tests/unit_t=
ests/openvpn/test_close_fds=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1881/comment/fd8640c3_ab378458?usp=3Demail :
PS1, Line 12:  *  as publishe=
d by the Free Software Foundation=2E
> License header doesn't match the res=
t of the code in length=2E
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1881/comment/1bf78c4e_5f1d8fce?usp=3Demail :
PS1, Line 36: run_case(int ke=
ep_target)
> The current convention AFAICT is to use cmocka for tests, whic=
h this does not=2E
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/co=
mment/6706f88e_1549c3e0?usp=3Demail :
PS1, Line 109:                : EXIT_=
FAILURE;
> Might we also want to test that fds 0, 1 and 2 survive?
Done


F=
ile tests/unit_tests/openvpn/test_misc=2Ec:

http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1881/comment/95ace02a_fef92240?usp=3Demail :
PS3, Line 544:    =
     if (dup2(source, 100) < 0 || dup2(source, 200) < 0)
> The new tests fa=
il when `RLIMIT_NOFILE` =E2=89=A4 200 (e=2Eg=2E `ulimit -n  64` causes them=
 to fail=2E [=E2=80=A6]
Done


File tests/unit_tests/openvpn/test_misc=2Ec:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/c80f52f3_43159fc8?=
usp=3Demail :
PS4, Line 567:                                 : '0';
This ha=
s the tests pass even without the patch, since `dup(source)` will return th=
e lowest free descriptor, so these should always be <=3D 6 here=2E

Ideally=
 a unit test should fail without the fix and pass once the fix lands=2E



=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacd56d245e9ab30cfb25b=
2b364ca661fa289dc55
Gerrit-Change-Number: 1881
Gerrit-PatchSet: 4
Gerrit-Ow=
ner: srkyn <david@srkyn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: cro=
n2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Ger=
rit-Attention: srkyn <david@srkyn=2Ecom>
Gerrit-Comment-Date: Mon, 07 Sep 2=
026 09:56:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In=
-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>
Comment-In-Reply-To: razvanc <ra=
zvanc@mailbox=2Eorg>

--32iNFdQDXXQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, srkyn=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1881?usp=3Demail">View Change</a></p><p>15 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comm=
ent/539ea40c_e5e98995?usp=3Demail">Patch Set #2, Line 699:</a> <code style=
=3D"font-family:monospace,monospace">            )</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Th=
is makes it look as if test_close_fds is somehow related to test_cryptoapi=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/7462133d_279dc489?usp=3Demail">Pa=
tch Set #2, Line 852:</a> <code style=3D"font-family:monospace,monospace"> =
           tests/unit_tests/openvpn/mock_get_random=2Ec</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">Do you need `mock_get_random=2Ec` here? The Automake version doesn&#39;t=
 add it and it seems fine=2E</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/compat/close-fds=2Eh:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1881/comment/6dbe1f11_567fd97a?usp=3Demail">Patch Set #1=
, Line 13:</a> <code style=3D"font-family:monospace,monospace"> */</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">The rest of the files have a more comprehensive block of text=
 about the license, we probably want to [=E2=80=A6]</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/commen=
t/4023b0a5_04fb73fc?usp=3Demail">Patch Set #1, Line 19:</a> <code style=3D"=
font-family:monospace,monospace">void close_fds_except(int keep);</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">The new function lost all previous (Doxygen) documentation exp=
laining the need for it and what it do [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/compat/clo=
se-fds=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/0f8f44d9_be569440?usp=
=3Demail">Patch Set #1, Line 12:</a> <code style=3D"font-family:monospace,m=
onospace"> *  as published by the Free Software Foundation=2E</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">Truncated license text compared to existing files here as well=2E<=
/blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File src/compat/close-fds=2Ec:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comme=
nt/1501e466_54f5b66c?usp=3Demail">Patch Set #2, Line 39:</a> <code style=3D=
"font-family:monospace,monospace">#ifdef HAVE_CLOSE_RANGE</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">I could be wrong (maybe I missed something subtle), but AFAICT this pa=
th can never be exercised unde [=E2=80=A6]</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/0c59f96=
6_7025f8c8?usp=3Demail">Patch Set #2, Line 42:</a> <code style=3D"font-fami=
ly:monospace,monospace">        const int lower_closed =3D keep =3D=3D 3 ||=
 close_range(3, (unsigned int)keep - 1, 0) =3D=3D 0;</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
=2E=2E=2E and please avoid complex conditional operator constructs with sid=
e effects in assignments=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>File src/compat/close-fds=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/1056f83b_1857d0a4?usp=3Demail">P=
atch Set #3, Line 1:</a> <code style=3D"font-family:monospace,monospace">/*=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">It looks like all the other files in src/compat have=
 a naming convention of compat-*=2E [=E2=80=A6]</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/d8=
9b0a25_26c6a7bb?usp=3Demail">Patch Set #3, Line 64:</a> <code style=3D"font=
-family:monospace,monospace">    }</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This can probably =
be done in a synonymous but shorter form, i=2Ee=2E [=E2=80=A6]</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File te=
sts/unit_tests/openvpn/Makefile=2Eam:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/com=
ment/05fbb928_b6b56f7e?usp=3Demail">Patch Set #2, Line 52:</a> <code style=
=3D"font-family:monospace,monospace">close_fds_testdriver_CFLAGS =3D -I$(to=
p_srcdir)/src/compat @TEST_CFLAGS@</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This is the only t=
estdriver whose CFLAGS omit `-I$(top_srcdir)/src/openvpn`=2E [=E2=80=A6]</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;">=
<p>File tests/unit_tests/openvpn/test_close_fds=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1881/comment/fd8640c3_ab378458?usp=3Demail">Patch Set #1, Line 12:</=
a> <code style=3D"font-family:monospace,monospace"> *  as published by the =
Free Software Foundation=2E</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">License header doesn&#39;=
t match the rest of the code in length=2E</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/1bf78c4e=
_5f1d8fce?usp=3Demail">Patch Set #1, Line 36:</a> <code style=3D"font-famil=
y:monospace,monospace">run_case(int keep_target)</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The =
current convention AFAICT is to use cmocka for tests, which this does not=
=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1881/comment/6706f88e_1549c3e0?usp=3Demail">Patch Set #1, L=
ine 109:</a> <code style=3D"font-family:monospace,monospace">              =
 : EXIT_FAILURE;</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">Might we also want to test that fds =
0, 1 and 2 survive?</blockquote></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_misc=2Ec:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1881/comment/95ace02a_fef92240?usp=3Demail">Patch S=
et #3, Line 544:</a> <code style=3D"font-family:monospace,monospace">      =
  if (dup2(source, 100) &lt; 0 || dup2(source, 200) &lt; 0)</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">The new tests fail when `RLIMIT_NOFILE` =E2=89=A4 200 (e=2Eg=2E `uli=
mit -n  64` causes them to fail=2E [=E2=80=A6]</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/o=
penvpn/test_misc=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/c80f52f3_43=
159fc8?usp=3Demail">Patch Set #4, Line 567:</a> <code style=3D"font-family:=
monospace,monospace">                                : &#39;0&#39;;</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">This has the tests pass even without the patch, since `dup(source)` wil=
l return the lowest free descriptor, so these should always be &lt;=3D 6 he=
re=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Ideally a unit test should fail without the fix and pass once the=
 fix lands=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">change 1881</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iacd56d245e9ab30cf=
b25b2b364ca661fa289dc55 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1881 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<=
div style=3D"display:none"> Gerrit-Owner: srkyn &lt;david@srkyn=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Mon, 07 Sep 2026 09:56:18 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: c=
ron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Co=
mment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></h=
tml>
--32iNFdQDXXQ=--


--===============9157729647043798064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9157729647043798064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9157729647043798064==--

