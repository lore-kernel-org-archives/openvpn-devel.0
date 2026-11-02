Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F760771DB
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DRnTkmMG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UwfSkaFc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WapHosqC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=M3vTbsG8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FvV7yVi1JBwJg6pC30J8IJ2Wj48G6SmJ59dLcFlmCug=; b=DRnTkmMG3U8OODPT8aadY4oPNh
	zNdMGS3nA60QAKNBoT4rNwAfJth++OipBc66wMQ3E9UP2aGnei0Gkq/GD/VXu3bbvdt169VqSXLwP
	JYBtzrJaqS+1rxCUZYVgK6VKq/hU1FBlAM64iOFkr5/QENZR1E/IxGPHUSSVLQwPYI24=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNt8u-000000007zR-3NHl;
	Mon, 02 Nov 2026 14:36:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNt8t-000000007zL-0Jar
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:36:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tUu6Agokc4okall5k7WaOhNuBc+yF2IwM7PLGfFR5nA=; b=UwfSkaFcaxDZjXEt8qHtf4kg0r
 vqW27lhpm0cX1+jpKtiFEfLKYEjtkN1ZzbqOSldeK3ZeAvoDYQayvI+9xRPxXfxkyYP7Icr2ImqvR
 A/iWF345chLOu8Nb73R1TQdYvJYSaUSpPXAZw15FGVd4AF1kdJWVs/6jfGpxYoApAK8A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tUu6Agokc4okall5k7WaOhNuBc+yF2IwM7PLGfFR5nA=; b=WapHosqCqkx6doWPdj6UUny73r
 SyS8CfBek4fTym/1XY22JntPTxumKmm0Bo8KtgYKoMEIo4KvcmPEsOpH/y1Ni8FstUuO1I3T4MUOR
 BDHGZ1yzdfma5ucTVRi6xDgqhh74+6SdyxDYA+ObaugAqjRrJ7OUJvQpM8kJB3Yu5f3Q=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNt8r-000000001rn-2TXr for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:36:10 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so19878755e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 06:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793630163; x=1794234963; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tUu6Agokc4okall5k7WaOhNuBc+yF2IwM7PLGfFR5nA=;
 b=M3vTbsG8jjKASNZznKG99Dt9az2PveIQ6mgqJvk8Bpnj79eMbjksjS/eZrV+OCY+Si
 R828xSLOuFZMKO2vPefsCh3OvPTSWNA4kP8b4XPUwnPixUBxuBAx+I1TRIlWP6+MXBOP
 5akkGDwTIWgdisN/wZhRYm/kpaIF+7gQtXC0yxga3UaiO8tmnTi7jwci7gaOAsTK3bzr
 j+onfZ5vJQ94ZcD4n3/PhzIjkZCVBDceLLZQwwS9MngzTFmxiD+DuRA6ssR5XVRl4UuD
 DDdV/nkfvL/dZXw0UTbsEfSV14dgm2CEsBPMORYdC3KDrE0hO2nzA19zdfk3kRbBjLrl
 ECHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630163; x=1794234963;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tUu6Agokc4okall5k7WaOhNuBc+yF2IwM7PLGfFR5nA=;
 b=2nj9WmBgLCCdI2vMAI7VH0lATi2/OXeBQzHo5V6BXmbnN51CHDMDBl8t0Nlb2KOAgd
 gVT8Kmfnj+MJ8ECgSaA9WJiIju5CG0k88m3/8UQ7NkVK5XEbilraqcE3xn225EznaBK6
 /KfDrzh7GqSRmc+iZzMxo1AF2IU9kGkRtnzN7gG8Fz20OY9Igwg6rMd6mkGP8Yc4KkFl
 cBrNXvPxQ6uWcDOCzkVfnk6gmLKSNJiisArxzE/PFElP57U1HGkNwRDiIiTJqE/XWCMb
 sLthu/ji9QkJEih55k/sjfUiUkbvQzUUQ06vfETSKesDLbtldYVUlI3b7h6drXXhjlHb
 mMwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBws5/GfkjQI+kH/92OaMWJSiEc15zJY188nrLrIefLt4d5kah60W3yg/DnyjXno4zGs+1DmCJb3k3M7cGBD@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL6MXUi1gBRxxjvNg9/+Kor850Qc+btqU0swdHXv0NOkhvYQeNp
 wlQwhPTSXEb8Dmxq84D9bQSxRDzsUFsUNkzQggZuqMV8zZ1sfzehf+NIC0VMZVrxGAfgmDuMXqU
 oEmuzWj3gBw+u4B239QAJZ9AkM1St7tm/iHhsHcKma1kq97QUlIlzW6GArvzpnLWiXEAK
X-Gm-Gg: AYBFou3kJBIhqznPUKUY/S4GQQfeqqxwNkQLWDkxiRF5PQIFQJgKyTY/TTkjtQ8BDEN
 KWulMmindY/bH/qFbEzimMU8HYHSCYnh+ckFF0cqNeE45JqPfNBKgwwc4zhTSgSTPiMocJZZ2Jt
 ieplWaRl28qWXmHLwfgApXXax2H15R6mZICGisp1ZkiDZbzsqkNmNwWmzcY+aMgdlf74NhsVznF
 5yTUpryoUc7cSSbK8GMcRq6SMM7ONDIcq2O0P4LDZCQNCsGswbrZzvc159jgFiib3MYrhBzVXMz
 T5aqJCtack0+PWUlgip1Mo0YzGTmopQgTn7nvm+yTi9RKMS4VYbWljt/ZftKuYKMe8s8oGDhgrv
 8tCqWYAUbEXOlgbDGXdE4tXaeDNCbQFNAL8M2IsQ+ccEwA8/4Y5pj/N/gQ7mfmRryB1jTNtm6rN
 QtKoST2o4RmjI2WNb0sONQAN0zhJnG9Wqa2i0+sWm129ramyQ/IOj7kHxqYVFfxQf3Vy311Ndzj
 aKlQtFPz3r0Y9UrW0HoYCeLpToZErClg9DrRrjuMDEMNfn/rOCksotdLKzK+6m0vz4WTVrsNlzD
 erfrDyT7KoG3WSY4j4c03WGNleQBy2QSj9b5PVUtx85gsyIWRWM3Faz7xCDeIS6QicbA0gAFXTR
 Vu3LCWm+DrKwleuZGlHbIbqNDmRDwqlmTwOpq7FBEyTPS1XA2vWRwJvpydX4jHH+SsxAci+lDv4
 AKNRYO6It40HVxYO5PpPV5Q61b+TnC5k1uTd0=
X-Received: by 2002:a05:600c:8b6a:b0:4a1:e6c8:ff74 with SMTP id
 5b1f17b1804b1-4ac17e10acemr221533995e9.29.1793630162779; 
 Mon, 02 Nov 2026 06:36:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8e5f4sm20910317f8f.40.2026.11.02.06.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:36:02 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 14:36:00 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I80b9969f555d670bc101635318d245d1b2de8ec5
X-Gerrit-Change-Number: 2092
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2092?usp=email>
X-Gerrit-Commit: 3faa767fb16e36723313613e772899157472becc
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 14:36:00 +0000
In-Reply-To: <gerrit.1793629964000.I80b9969f555d670bc101635318d245d1b2de8ec5@gerrit.openvpn.net>
References: <gerrit.1793629964000.I80b9969f555d670bc101635318d245d1b2de8ec5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI5OTY0MDAwLkk4MGI5OTY5ZjU1NWQ2NzBiYzEwMTYzNTMxOGQyNDVkMWIyZGU4ZWM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c9ae8d49fe616f8619681b12891e343d9ff14150-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNt8r-000000001rn-2TXr
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: free gc arena
 in windows_set_mtu()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7624716586632604364=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7624716586632604364==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7kVhdjxnhGk="; charset=UTF-8

--7kVhdjxnhGk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail )

Change=
 subject: tun: free gc arena in windows_set_mtu()
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comme=
nt)

File src/openvpn/tun=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2092/comment/2353ac7d_a0775f7d?usp=3Demail :
PS1, Line 5239:     gc_free(&g=
c);
I would move the `gc_new()` and `gc_free()` both inside the case where =
it is actually used=2E  Most of the time we should not need to print an err=
or, so do not need a GC arena at all=2E



-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I80b9969f555d670bc101635318d245d1b2de8ec5
Gerrit-Cha=
nge-Number: 2092
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 14:36:00 +0=
000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--7kVhdjxnhGk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2092?usp=3Demail">=
View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun=2Ec:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2092/comment/2353ac7d_a0775f7d?usp=3Demail">Patch=
 Set #1, Line 5239:</a> <code style=3D"font-family:monospace,monospace">   =
 gc_free(&amp;gc);</code></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">I would move the `gc_new()` and `gc_free()` b=
oth inside the case where it is actually used=2E  Most of the time we shoul=
d not need to print an error, so do not need a GC arena at all=2E</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2092?usp=3Demail">change 2092</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2092?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I80b9969f555d670bc101635318d245d1b2de8=
ec5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2092 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 14:36:00 +000=
0 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div s=
tyle=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--7kVhdjxnhGk=--


--===============7624716586632604364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7624716586632604364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7624716586632604364==--

