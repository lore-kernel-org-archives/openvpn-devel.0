Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF7606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M6AiEgyZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E5ObzB7z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MRgMkwIJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MeYDiGo5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zgNdH2WNAT5RECCGDfRA//ogNcRBanEtIBExKvfNNnI=; b=M6AiEgyZb0k7mUJeBs+IpaiQgn
	bOeaEIe56fDrDmpPA5px68PY5w369UHGXkflgNXBvbS44deVj1yrtsBN/bn6xJiUDDlM5Mj639k8S
	36DeN8+TrctTRJm/B/9iWH0JFDk7tObYzKLRrS4BGdc3KJJ0G0q0tcz6Av28j73Fj1oU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMSQl-0000000038B-1wkr;
	Thu, 29 Oct 2026 15:52:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMSQk-00000000383-2Z8Y
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 15:52:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7uwAdgtra+OSTf0+mAMs2BH2t688wQN2rgo4bl8RTTE=; b=E5ObzB7zfBAOuSaR0MId0Nvnpp
 zmeziD+ZoupfcJ1ViQsOArLCotaFLeMLF5q8LzR0FcPxVmQ6NQ4FqmUoEFHYHxqfFLr7oE4wGjcbu
 poJTlJwofa9bmkDpe+We1s14GbjVfZMXIIueSZ35d1vUd0W4VUaze1Fekc/tW8FuCu1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7uwAdgtra+OSTf0+mAMs2BH2t688wQN2rgo4bl8RTTE=; b=MRgMkwIJ9mba/C0kmiErJjOEX8
 Czn+Htcn7vamf3EdAJXouqgLzPb+1YoiFnfJjlwK+LvrHZO8rgD0qgRIP7n8WAWJcVfPC9v5zDZYJ
 2XMQcwJyVhKIAajCRHhHI5EqCvC7wKssbdsPvChdNhkO3fUqFoeLnLL50OmQ3nkDiHzQ=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMSQj-000000006ni-1rG4 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 15:52:42 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1520895f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793289155; x=1793893955; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7uwAdgtra+OSTf0+mAMs2BH2t688wQN2rgo4bl8RTTE=;
 b=MeYDiGo5aZEHUVvFGlb1A28SbjKh769nEqmZ5NHL1vZBdWySlIsAKFnA8SRISqdhyn
 fHPs5TNLR2JI0iHdULiEkJGrModE+PrtqO/BJBxuEi9ZCzkwkpR5kSql0S7/YTX4ZMtY
 ieArnuEswqT1MZOQ0ZIldWsglkiOfBigY+Ph/lszofSrSrxY+SMW0DorQY/ozh5V+hQQ
 HWwPXRHCywcdTjZBhnI+o4tlKkV8FgpNgDIhoYAyE3GVquIJfvXkhJEABn+xMtWmcMdC
 WLFLZh6AYajoPaOmr8lYr130qxXN+GCarYmdI1FGSH2oSEZHQ0f1esUA9iJE4T6OF6xX
 5MwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793289155; x=1793893955;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7uwAdgtra+OSTf0+mAMs2BH2t688wQN2rgo4bl8RTTE=;
 b=ZG9t9J1ZS39qtlp/ii9Kb5olFX1pk4Fx8Icpf/+B6Ct82f0ReiiAVbIMWLHdkOVZTQ
 LHdpOxf6qxr6hNSFA9Pws7gxuZfbWqbYUJ8OatoQZh5R5/cBpFgl52wfwkRiDO9M4vd4
 MW9SsEkI+LtvWdvN/RxbS9eiuT4RWHzMa0qMgHW7PyE0nRWCGRtv+EWOJdk0Piw7KpfI
 3mKM9oMzPWYH5jKvdDUqxK9rFmeg/hg5sRIzOmCFjVM/UC6sexiNlpOH7WtxE3N/GRME
 lqT0Q1bYVQFnirCozij8aoMeC0Ix35JQRJC/AZ+aSDsp16wAKqRcG1J2/j5wyYW7ZwYN
 07GQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2Sh5mkD96csMlG5hvkwFWiIKkZuIQ52xsijtpF7d7Vp98KZgILd45hjHhthtjgefRp64UJ19PLJB/ixCH@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJU60T4e0S4oZae3DBNOWxr2O6yDpmCpEm3ECgX67L/p9H3XB9p
 ARbc/UcZYb1KkZDZlzdIR8wyamD9DcddCQMrdDxQkpDhqnDwOFH+WvjPx/R3rw5Bs/d1bKZaHmV
 doz46luemTqOdK6pHacYTcirdICEDrp+iCifDUcs9fkU1hZme8waKEaC8zFX6/+6Vyf+p
X-Gm-Gg: AYBFou3PJjIp9coaZLpNlOPTEM2HGMETK6GPJS3dG60rpvNCsUecpUxdl1RpkFOudRL
 GrctxK+DiXfpthYQgsFGQWn/wF8EVGibfcJxXG+wGApqkrZ19Lr7l4FOJnfl4AKtGB4uGsdv0AR
 JLVtfsHOC2j9KoZ3Wei3KARbB8MZ6cHmeksUGM9x9ePy2wk2U1owcjvz7gSYCEjdVjZHm/T/GoH
 ai+XY9LDc/fiFfV/RDNGyTw563AowDURm/jkzkweSZnnr17ed8XXOtPcRm80+nI5qP6hmy3iRXP
 LZ4VvwMeW9DfSKCDJoTJtzfXl1oPGft6mX7ysDCkf8WbTwnIwJKegUFp2D9d9jVKBmusGpCS6bB
 ABri1EBgnqPhFbBjG1LHNOXiTfXnRCIh9sXDvGj3dvITay9uEbZx92F5Fq4r+KKJC+6zBeN7p8v
 hYXStp1gqp6zAILEvi7cOYahoaJtOy24F78N/hPHTQAdReAPedt6yzTJJI4wTnQzYQpD9lcKmCS
 OqsgC146PF06ELa9fDqpbJzgEYO41fDT5QRzXZC1m7dXP8naAFOo8ScoQy8hvSHWQszO2F65E5U
 sN1YyZ2SxcKkCNP7vihfXo+vfZabaTyC0SIJoiau48fuvamsxEKuh/0cN54pxBKpXWQWB4SxYFF
 Q1zj0DJLFnawmtyT2IK6zyHv4Q7zZYLVM1pNiI8RKjY8Id+zMPlCTq6D3n/vdvhBivZ7XYV6msO
 obqkRC6F9K5DOrci4=
X-Received: by 2002:a05:6000:41c8:b0:48d:faa6:cedf with SMTP id
 ffacd0b85a97d-48e5d5e01d4mr14146144f8f.56.1793289154600; 
 Thu, 29 Oct 2026 08:52:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df1e55esm32257f8f.6.2026.10.29.08.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:52:33 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 15:52:31 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: cfb4a164d8c2f37f6f910e0237d470ebd1ee3cdf
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 15:52:31 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bc7764578b5e94936eebf0dc8702f21a3dd282cc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMSQj-000000006ni-1rG4
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
Content-Type: multipart/mixed; boundary="===============1271619025127636742=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1271619025127636742==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AUjMeqZE2lE="; charset=UTF-8

--AUjMeqZE2lE=
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


Patch Set 22: C=
ode-Review-1

(5 comments)

Patchset:

PS22: 
This is the last batch of pot=
ential issues I've been able to find=2E =F0=9F=98=80

If these get fixed on=
 next iteration I'm ready to +2=2E

Thanks for your patience!


File doc/ma=
n-sections/client-options=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1858/comment/cb2de546_fa81b67a?usp=3Demail :
PS22, Line 443:         as (=
:code:`A:6`) and the list of configured protocols (e=2Eg=2E
Still gives `A:=
6` as an example, but the code sends `6:A` (ssl=2Ec `IV_ACC=3D%d,6:A,%s`)

=

File src/openvpn/acc=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858=
/comment/564bb2b2_d4220681?usp=3Demail :
PS22, Line 232:     log_acc_messag=
e(c, &buf, payload_len, protocol, flags);
Should we explicitly check that p=
ayloads flagged `6` (`flags & ACC_MESSAGE_FLAGS_BASE64`) are really base64 =
before passing them on?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/c=
omment/a80323fc_d2880d00?usp=3Demail :
PS22, Line 250:                  con=
st char *msg, bool base64)
Nit: `msg` shadows the `msg()` macro=2E Maybe re=
name to `payload`?


File src/openvpn/manage=2Ec:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/5a121936_8558d922?usp=3Demail :
PS22, Line =
4468:     while ((flag =3D strsep(&encoding, ":")))
Should we reject unknow=
n tokens here rather than sending the message as ASCII anyway?

`parse_acc_=
message_flags()` seems to be stricter=2E



-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Ch=
ange-Number: 1858
Gerrit-PatchSet: 22
Gerrit-Owner: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-C=
C: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Thu, 29 Oct 2026 15:52:31 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--AUjMeqZE2lE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 22:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1858?tab=3Dcomments&amp;usp=3Demail">Patch Set #22:</a> </p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This =
is the last batch of potential issues I&#39;ve been able to find=2E =F0=9F=
=98=80</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">If these get fixed on next iteration I&#39;m ready to +2=2E</p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Thanks for your patience!</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File doc/man-sections/client-options=2Erst:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1858/comment/cb2de546_fa81b67a?usp=3Demail">Patch Set #22, Line 443=
:</a> <code style=3D"font-family:monospace,monospace">        as (:code:`A:=
6`) and the list of configured protocols (e=2Eg=2E</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Still gives `=
A:6` as an example, but the code sends `6:A` (ssl=2Ec `IV_ACC=3D%d,6:A,%s`)=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/acc=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/564bb2b2_d4220681?usp=
=3Demail">Patch Set #22, Line 232:</a> <code style=3D"font-family:monospace=
,monospace">    log_acc_message(c, &amp;buf, payload_len, protocol, flags);=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Should we explicitly check that payloads flagged `6` (`flags &a=
mp; ACC_MESSAGE_FLAGS_BASE64`) are really base64 before passing them on?</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/commen=
t/a80323fc_d2880d00?usp=3Demail">Patch Set #22, Line 250:</a> <code style=
=3D"font-family:monospace,monospace">                 const char *msg, bool=
 base64)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Nit: `msg` shadows the `msg()` macro=2E Maybe rename to=
 `payload`?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/manage=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/5a121936=
_8558d922?usp=3Demail">Patch Set #22, Line 4468:</a> <code style=3D"font-fa=
mily:monospace,monospace">    while ((flag =3D strsep(&amp;encoding, &quot;=
:&quot;)))</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Should we reject unknown tokens here rather than send=
ing the message as ASCII anyway?</p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">`parse_acc_message_flags()` seems to b=
e stricter=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">change 1858</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e1589=
6b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1858 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 22 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Fra=
nk Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: chugly &lt;charlie=2Evigue@=
openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Thu, 29 Oct 2026 15:52:31 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: Yes </div>

</body></html>
--AUjMeqZE2lE=--


--===============1271619025127636742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1271619025127636742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1271619025127636742==--

