Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A84CCCF2DB
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Czb33ok/ri6CSczcd+gB7ufuXf6CtYkc+qXmW5JOdG0=; b=FTInKn1/mkOWRdgHalNmqGmFo6
	E2KYQSvnRo4vblqpJPocn+ItFByvN9n565nkTu/hXrrQvVOaRqMPvZxRSR4651xp3SiFSI/SUuR3q
	OTCcMWspr0lus8rMcvEONIzmzypJP3h7xCHt2CQgGzIkSX7ExV12s9Jp2tRq/4KJibRQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xInAQ-0006DM-To;
	Mon, 19 Oct 2026 13:12:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xInAP-0006DG-4Z
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:12:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0WXm4mOV5MTQGaH1G1Sk4oz6uarLPWFNBQuaxnRKhqw=; b=cAuKh+O7fOPEhAJrt8ICg0Z1NO
 ML111u1sW7cbupcEtmCh++nXGWhwkmPj3aIbTK+q7SpcNOmt24Sg2NFk/khck2GmOXhma25RTCmtW
 X+E4D9E3XEi6WqkiLo1A2iR/grq/k55ImwlzpONCaBg9Ftz3kicOta5a5WNRLhF8utf0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0WXm4mOV5MTQGaH1G1Sk4oz6uarLPWFNBQuaxnRKhqw=; b=L
 WJQY54kXvBbdZBwQdMGqu3EoorJTx79UgAY0A236DR3zUipXG3lrIm0btFvlJhlNwhbADtA74vcOk
 6+SEeHjOKK7AlMuR3q/8RhavpnDLxlEXTvch/N4XIw5pM94HnxPByrb8F55n83lIPaiu0JWEgfjlG
 pRCVRkxTDs2OHbHU=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xInAK-0007s7-Vx for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:12:38 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so1274260f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792415550; x=1793020350; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0WXm4mOV5MTQGaH1G1Sk4oz6uarLPWFNBQuaxnRKhqw=;
 b=CykpoZIwjAgBAlpwYoKv7G1RJ5u7oIGm/sxjEOAW4cz2hrKtpM+XBpvUqx/ChK/mSR
 vDW8eJOrkYRuDrNGBxRdURrHptiOfCpzRs+sDUrFkaAcCwzZVwAbCL94Mhh0RKwXW//K
 67lv0gpc2P2foUKqVNwESVericJ6r7fty3YslKilA8kWwaW26eIEbF0GHRdRGbQeYlJZ
 5YW0ifqqknNRUMUcBumDoy/pN8TbmTvwd7D3HYNlGSiEH4vtaCZjc3W5fWIwugL6raDv
 ISVQ+HzHPCmgqPrMtFqq/exj7FJgOIFwg774u6DOp+oOJ3Mr2cf0iZj6GgSZlQSnseSW
 I9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415550; x=1793020350;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0WXm4mOV5MTQGaH1G1Sk4oz6uarLPWFNBQuaxnRKhqw=;
 b=fEXAunTJQtnk08TsT0IUhfVockumdzpHmmlYdd2wm+kpKyviko3CS/fgpv2aZ3ajJM
 wz5bCwYQACa11DdQlLxgouJ4qj+w/xH7u61n0Xnn+lcQ+7umIUFUEhqAT6xcRB/Imw9j
 xjmzZBEPrgzArQ8UuXLh+Nm9s42p0FYAx+WabnaZJdGSQ+8//ZkTl+oDFA4MygmEWAg+
 l0Z+Oi1R5ABugHVfGc+S+SFMWrCN3Tbv5ltCJlkFa5FHj3HcQaS+4wwUW6NPWbhac2Gs
 tm0fieFKU52PCzraPhhTLkC65O6zpPnTV4sOWvQyFDcUxcoJ3Fl7/RxQaGQ6mVxFDvqK
 vBPQ==
X-Gm-Message-State: AFq9FYKEAVaOs7p9bmpn90hbLPWdUF1RQZ9ufKC+Bkq68XPYfz9wtXRH
 jUcry2Xdc2QRvBru+Ovcc1emhGyT4jZNNeuDMpEb6mNUeYN6FY9Q+OGiw4zJHAJ/zqcE8mIz2FW
 K8tDcHCfkvnf9B3XTGmxiqpWnkOMvbIX6Mlmzs8PUu20axDkDJkXR3xRlhEJ9kPU7BxKx
X-Gm-Gg: AYBFou2S8erhlH9mdP9NgZfgaEhvKkJZNPXJiWsEL5vEn9pjuKEal6gAcBGCiqnZt6O
 kF1/pfBQ6vGCF/natzjBuSf59EpKlrgAnx/9Du3mHfR7O4Hi5eUdJOGlj5jzthe2aBCQDmSJmya
 AANjCWFhLdKWEU0tzSZr9a4j46ze3URFTbdBgXTsdKRIrwbg9hJ5jN4emGGyabrERRIYvOWYY5V
 A258yk4+DwY8AJGY3qepj1fLT+pevtwBEsCIh3x1hYdU111Jma4/FLr7KmJxhEaGZrX/AVwd4id
 wSJUuIPtrntTyl+qC6Naml9Iyuiwxn1mEAU8gdDZ9l4a1sV/LbqFu4zqnGVl8xSepWIT+cO76+c
 KhFvoG/gJL//Se2as4+Yuqa3hpxNX+baeniWdMmdkyLuiaQMsfGEyIECN9iMm6MZi8D+TisghWa
 zYxLoMhmsiBWBUGottKMQsrZTuohs2r1ocbrOqNrwyDdv/iu9yvSkArBDl/EiTWQl/0iW8ofxfK
 mCn59QLY6p9+SpyBGfn4PX1BJ/XXu4tQ3gZRNw9x3TST18eahaQPZjKYNGGysoix4XpeoGzVcL+
 7fXKFAOBiv7kQiWec+udJAjfhv+BNRiueGCgcaGRSmNA1iA9++bvVXioAD1Z
X-Received: by 2002:a5d:5d09:0:b0:482:fd9c:3740 with SMTP id
 ffacd0b85a97d-48e07f98e2dmr18315347f8f.22.1792415550084; 
 Mon, 19 Oct 2026 06:12:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c0894sm21104499f8f.12.2026.10.19.06.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:29 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 13:12:28 +0000
To: Steffan Karger <steffan@karger.me>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
X-Gerrit-Change-Number: 2010
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2010?usp=email>
X-Gerrit-Commit: 796c78e1a3df60918a2bde06b991bb7a68939734
In-Reply-To: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
References: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkljMzYxMjNjNWE0YTJiMjI5NWZmZGY0NzE3NGUyYWNlYjlkMTdkNjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <618e39d312a8139331dbbb6f8ab3c9fde7393e38-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xInAK-0007s7-Vx
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gen-sample-keys.sh:
 use a random serial
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8285162127062460145=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8285162127062460145==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UzQEe7ljwVI="; charset=UTF-8

--UzQEe7ljwVI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Steffan Karger=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010=
?usp=3Demail )

The following approvals got outdated and were removed:
Code=
-Review+2 by R=C4=83zvan Cojocaru


Change subject: gen-sample-keys=2Esh: u=
se a random serial
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

gen-sample-keys=2Esh: use a random serial

Instead of forcing opens=
sl to create consecutive serial numbers, let it
generate random serials=2E =
Although not really relevant for the sample keys,
that is the best practice=
=2E

Signed-off-by: Steffan Karger <steffan@karger=2Eme>
Acked-by: Razvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2010
Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
Messa=
ge-Id: <20261018130834=2E11953-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40000=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M sample/sampl=
e-keys/gen-sample-keys=2Esh
M sample/sample-keys/openssl=2Ecnf
2 files chan=
ged, 1 insertion(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/10/2010/2

diff --git a/sample/sample-keys/ge=
n-sample-keys=2Esh b/sample/sample-keys/gen-sample-keys=2Esh
index e5a11f5=
=2E=2Ee914fd2 100755
--- a/sample/sample-keys/gen-sample-keys=2Esh
+++ b/sa=
mple/sample-keys/gen-sample-keys=2Esh
@@ -22,7 +22,6 @@
 mkdir -p sample-ca=

 rm -f sample-ca/index=2Etxt
 touch sample-ca/index=2Etxt
-echo "01" > sam=
ple-ca/serial
 
 # Generate CA key and cert
 openssl req -new -newkey rsa:4=
096 -days 3650 -nodes -x509 \
diff --git a/sample/sample-keys/openssl=2Ecnf=
 b/sample/sample-keys/openssl=2Ecnf
index 02bf8ac=2E=2Edcaebb7 100644
--- a=
/sample/sample-keys/openssl=2Ecnf
+++ b/sample/sample-keys/openssl=2Ecnf
@@=
 -14,7 +14,7 @@
 new_certs_dir	=3D $dir			# default place for new certs=2E
=
 
 certificate	=3D $dir/ca=2Ecrt	 	# The CA certificate
-serial		=3D $dir/s=
erial 		# The current serial number
+rand_serial	=3D yes			# Use random ser=
ial numbers
 crl		=3D $dir/crl=2Epem 		# The current CRL
 private_key	=3D $=
dir/ca=2Ekey		# The private key
 RANDFILE	=3D $dir/=2Erand		# private rando=
m number file

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2010?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
c36123c5a4a2b2295ffdf47174e2aceb9d17d668
Gerrit-Change-Number: 2010
Gerrit-=
PatchSet: 2
Gerrit-Owner: Steffan Karger <steffan@karger=2Eme>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>

--UzQEe7ljwVI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Stef=
fan Karger=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
010?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
en-sample-keys=2Esh: use a random serial<br><br>Instead of forcing openssl =
to create consecutive serial numbers, let it<br>generate random serials=2E =
Although not really relevant for the sample keys,<br>that is the best pract=
ice=2E<br><br>Signed-off-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>=
Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010<br>Change-Id: Ic36123c5a4a2b229=
5ffdf47174e2aceb9d17d668<br>Message-Id: &lt;20261018130834=2E11953-1-gert@g=
reenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg40000=2Ehtml<br>Signed-off-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M sample/sample-keys/gen-sample-k=
eys=2Esh<br>M sample/sample-keys/openssl=2Ecnf<br>2 files changed, 1 insert=
ion(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/10/2010/2</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/samp=
le/sample-keys/gen-sample-keys=2Esh b/sample/sample-keys/gen-sample-keys=2E=
sh</span><br><span>index e5a11f5=2E=2Ee914fd2 100755</span><br><span>--- a/=
sample/sample-keys/gen-sample-keys=2Esh</span><br><span>+++ b/sample/sample=
-keys/gen-sample-keys=2Esh</span><br><span>@@ -22,7 +22,6 @@</span><br><spa=
n> mkdir -p sample-ca</span><br><span> rm -f sample-ca/index=2Etxt</span><b=
r><span> touch sample-ca/index=2Etxt</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-echo &quot;01&quot; &gt; sample-ca/serial</span><br><span> <=
/span><br><span> # Generate CA key and cert</span><br><span> openssl req -n=
ew -newkey rsa:4096 -days 3650 -nodes -x509 \</span><br><span>diff --git a/=
sample/sample-keys/openssl=2Ecnf b/sample/sample-keys/openssl=2Ecnf</span><=
br><span>index 02bf8ac=2E=2Edcaebb7 100644</span><br><span>--- a/sample/sam=
ple-keys/openssl=2Ecnf</span><br><span>+++ b/sample/sample-keys/openssl=2Ec=
nf</span><br><span>@@ -14,7 +14,7 @@</span><br><span> new_certs_dir	=3D $di=
r			# default place for new certs=2E</span><br><span> </span><br><span> cer=
tificate	=3D $dir/ca=2Ecrt	 	# The CA certificate</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-serial		=3D $dir/serial 		# The current serial =
number</span><br><span style=3D"color: hsl(120, 100%, 40%);">+rand_serial	=
=3D yes			# Use random serial numbers</span><br><span> crl		=3D $dir/crl=2E=
pem 		# The current CRL</span><br><span> private_key	=3D $dir/ca=2Ekey		# T=
he private key</span><br><span> RANDFILE	=3D $dir/=2Erand		# private random=
 number file</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2010?usp=3Demail">change 2010</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic36123c5a4a2b2295=
ffdf47174e2aceb9d17d668 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2010 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;steffan@karger=
=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--UzQEe7ljwVI=--


--===============8285162127062460145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8285162127062460145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8285162127062460145==--

