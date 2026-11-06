Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76761606A329
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VAH8kfOa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZKCYb9qj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=K3zzl64T;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bmJO7kIN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NCMPvk9rrqwe/y+/RRT2TWHPliaSymT7PJAI3KU9bEo=; b=VAH8kfOaSUeaLKoY4ivZDjHvud
	lj5sDpY/TDmI/PK0ng5OicWq1fLeFQsxHjhP/AOiQuG2oSj1CdDqP9Dab6EtCgoJxqSw6X4ekklUz
	llPyRs8tluI9Oj9dJlFFeFA8nl83LbuUMwNKJRKjZ/xU99vRkrlOoJbvs52gf9tbJ2Ro=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPI6v-000000004Jt-3jvO;
	Fri, 06 Nov 2026 11:27:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPI6u-000000004Jj-1uLc
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:27:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2zbLqyot5hg1fW6Cx83gCUHnikfmQeCsboY2u6I1uA0=; b=ZKCYb9qjr2CvbPPRoXNEXFLi8Y
 VOJq/+XkIk92Tprs40DzgwfyYnvPkXmzKxD4u+S5RNgHJwBj341HoLSjwlT5ok0z+7GRqyRGKKam2
 9b7yNv7VITP2KEYJYvJQpYqigie7C1psKOsMIgOixIU0vi0YxDrIJpmjABKllOLxxukw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2zbLqyot5hg1fW6Cx83gCUHnikfmQeCsboY2u6I1uA0=; b=K3zzl64TyWszSYJmD9qXyvZaCS
 +Sjd+iwTsBM5VltVdS9xmMuuGWUKSLsEjOuM15th4pZkOoitPRn8UNjtpY55+V93Ezs5HoJK7Yw+C
 q+oXj3aIXa09YeQAkLFPC1Zjy0y5rLkP3AGFtqC+GoyUd9Nl4/KzJIXsSFyWQ8MyuPfs=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPI6s-000000003vM-0Ltc for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:27:55 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so5600165e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 03:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793964467; x=1794569267; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2zbLqyot5hg1fW6Cx83gCUHnikfmQeCsboY2u6I1uA0=;
 b=bmJO7kINlJdnv2Ucs9YAsBe68uhUh5D69YB1yUOLuYJ/w4nrwj785eOdCxhKz2i/ns
 x9PCckY/J87nHFNiyTIh7/DiUFVP8fH7A/RoWNNuSoSDrypzQgqqcZ5E7H4TuUO2aYtf
 1fkUtRGtH9M0FJDxpXzkVX+PgtUI5uY3iI4liKwtjgCJTMI5JTcGHcyRa8Q+kkccCpro
 fXiKwyALSiFi+2ZHShkflXQEIDPK1RiflnJGPGdm+tL0Pp+z7qvuouIGlc9gD8m+3Cl1
 CnpZAqYBL4cgeU1B1oh7FW12yUmOBb8g1mMv3HpQyMpYuDadOkRWhW0p7A9RL4uc2lak
 686g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793964467; x=1794569267;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2zbLqyot5hg1fW6Cx83gCUHnikfmQeCsboY2u6I1uA0=;
 b=Rj7Ghq9SvkXPP5TW8YJhYs33xG7M3PtiPLgHFgD38quN+dIwthOP3TSqMUsZJiqvrB
 y8B2Jqk0LtCmrdrNf4/H5njGnXv1y+kMK4py+W4M14EQXw4JkvqxTWipzu0fU4rc/IJQ
 u/DjVO8bFf5UwTzKUPHFBJjhcOtJVR9y3qKROV/a3L9PBbW9Qdthxn2njZwpECWqq723
 f95DRZlGNnmOYDaBDZ1K8ZPxfv9VOIHrJDKsJnz1cAAAuO4cOokzIzxvVo/rzqUs6j2q
 Ha5WGlLGZFniofzJmeTo+fu0SZh9C3aqPxbjQS6YGiQTTHX3wEnS6Ag+t4dfAjoclatC
 Qp1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1lWwry8ek5RBks5UxgX7T8J0O/Uh8T/QBKfUYx4FRneFs+R68bSq4eTECkYGF1eBovFcHCzbO308EQ53p@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+JJYU25Om2jnFyk3KI52I8BB66SA2DF3IAH2GDrqlZnnpQG4Mk
 R2c58KtFLtHOBPQDedhdxFPOufgM3v8r4ZhjlA7vEmk+myfojcUqowlsboY+rX3Nbcpnzbokfva
 /dF5WO+bH3mSyusUGLKlD9Lh8kMaez2KnnYInQrHX9QSHvg4761LTXmGmryqZ5OWi38hVgRu2/n
 XWnxtg2Q==
X-Gm-Gg: AYBFou28KpB+sPHPJuoJwuR3Z/8lvGY1lQ/+pqA+KgrCQK+bdLTEnO/E+eXx2T2Rpab
 jcdmboOZjAhuPsbag39GvV+5oxFmWzUYTSaZ33zeieSEBkBpwnYO6O3FT7Anp7VEc6OU8LOQEN/
 ZeWWYOFdQY1X3PldlcJwfujrG8/G6Q4L5Un1sB7MxPGCJKDvErJMoMdTAr8V4GlOmrIihjrqC3h
 0Aid72mq9vxHZhExUNoe+lYLouh0Vd9vhvN418YWNS5sZozVTVOG0CAeL/bG+ySD9pd33z0dohw
 sscIh2i5cEnNikTRyNsn/SBdRg9fYYDi7/iOEpyla+wn1Eh/Oeum7Kz832kzpCEgIoIouXiAGN5
 46oH8+KzNJ+V2CntYr2doe27EHjGi16FTEgyKvm23xKsvJlQ2EjgAkrWLSDwZhMyz6SXAlxVseE
 JtdmcVkR6hLVin81v7O+SDFCrG83pL3enoQigk2MHuu5U/HPKVBMmDp37J/7mkul+ltQ0RYNNK7
 F4Isya2h+8kya7HLHjyTwwaU8HagRTi7BV6TvgxZY/0fm+7WX+4zzdrpvvpscW3wcU9MYhXYWnW
 o/NUDaOkrIy75o2qq99ulnI3dKcF0/pCTMolBwfoRWs4S3hR3a9r/w7Yw7rJ2/1fc3Rzsux5ONK
 B+xlsLxxGIHw21D3L5uLghnpdODy6AF3WuMzQYJCHcmnqIAqzA+vmi96pzZtV6jzFJjKdOdnji0
 fZnkoAp0J8CP037A==
X-Received: by 2002:a05:600c:3509:b0:4a6:4d6b:a840 with SMTP id
 5b1f17b1804b1-4b6e0172854mr39553525e9.31.1793964467390; 
 Fri, 06 Nov 2026 03:27:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76b5d52a7sm3349895e9.1.2026.11.06.03.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 03:27:47 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 11:27:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 3d760aa23b004c8e6b95875d7d76209bcf129a19
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 11:27:45 +0000
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <43c462bab3d7b3b8b33170ba1b152a7ab8e6833c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xPI6s-000000003vM-0Ltc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Adjust
 ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6320883321748251865=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6320883321748251865==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RX2HytsXTW4="; charset=UTF-8

--RX2HytsXTW4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail )

Change subj=
ect: Adjust ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:=


(2 comments)

File src/openvpn/acc=2Eh:

https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2130/comment/3f650cc5_e0594e8b?usp=3Demail :
PS4, Line 34: #defi=
ne ACC_MAX_MSG_LEN (TLS_CHANNEL_BUF_SIZE - 128)
> `log_acc_message()` sends=
 messages through `msg()` which formats them into buffers of `ERR_BUF_SIZE`=
 [=E2=80=A6]
I don't think that is correct=2E The only part in this functio=
n that logs the payload  itself is inside `#ifdef ENABLE_MANAGEMENT` and if=
 that is enabled the ERR_BUF_SIZE is 10240:

#if defined(ENABLE_PKCS11) || =
defined(ENABLE_MANAGEMENT)
#define ERR_BUF_SIZE 10240
#else
#define ERR_BUF=
_SIZE 1280
#endif


File src/openvpn/ssl=2Ec:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2130/comment/7e0a3db1_515763c7?usp=3Demail :
PS4, Line 2403:=
         notify_client_acc_protocols(multi);
> This seems to be sent out re=
gardless of whether negotiation worked or not=2E [=E2=80=A6]
Done



-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a268fc602e916bf54853c950=
761977cf3d7f835
Gerrit-Change-Number: 2130
Gerrit-PatchSet: 4
Gerrit-Owner:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Da=
te: Fri, 06 Nov 2026 11:27:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--RX2HytsXTW4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">View Ch=
ange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/acc=2Eh:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2130/comment/3f650cc5_e0594e8b?usp=3Demail">Patch Set #=
4, Line 34:</a> <code style=3D"font-family:monospace,monospace">#define ACC=
_MAX_MSG_LEN (TLS_CHANNEL_BUF_SIZE - 128)</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`log_acc_me=
ssage()` sends messages through `msg()` which formats them into buffers of =
`ERR_BUF_SIZE` [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">I don&#39;t think that is corre=
ct=2E The only part in this function that logs the payload  itself is insid=
e `#ifdef ENABLE_MANAGEMENT` and if that is enabled the ERR_BUF_SIZE is 102=
40:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">#if defined(ENABLE_PKCS11) || defined(ENABLE_MANAGEMENT)<br>#define=
 ERR_BUF_SIZE 10240<br>#else<br>#define ERR_BUF_SIZE 1280<br>#endif</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2130/comment/7e0a3db1_515763c7?usp=3Demail"=
>Patch Set #4, Line 2403:</a> <code style=3D"font-family:monospace,monospac=
e">        notify_client_acc_protocols(multi);</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This s=
eems to be sent out regardless of whether negotiation worked or not=2E [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">change =
2130</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I3a268fc602e916bf54853c950761977cf3d7f835 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2130 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Fri, 06 Nov 2026 11:27:45 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-=
To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></htm=
l>
--RX2HytsXTW4=--


--===============6320883321748251865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6320883321748251865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6320883321748251865==--

