Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D44CCF2CF
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 21:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=1T1cWxC/Fbo2OiRYPQgvG2SGuMCxqqPuZ47k8nveIEg=; b=EN3kxvD5G6QAvm
	Rxdc/xAw9U7VazhmqZ52NE3bj324GHS2GXwVqkL1zkEaejCLhxSll+DLneHzMCxqU7gSfps3+8clD
	wpMsJauFdPXnAbxKkyNeF12NFVStHL3kokMMPWZdHh0x5VhEjWKnKJUptyb1m+XS2HtbdvkJqF/PS
	mTA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xICLs-0007ZG-1t;
	Sat, 17 Oct 2026 21:54:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xICLq-0007ZA-HC
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 21:54:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bd88ZuPreTg1KHBY0+VLjFHHIyVVEud5Q/aOGXQw9Rk=; b=h0gDsP9kuDxJF9jWSLNQD6atU+
 lrDVYkhP82azAMf0ri6E1xqLfOOKX4Ym3gewg2oYg5FlrEUWvvrRwPR0Vw3auyuyOIWbytPZ4rhjL
 Nt+BNQ50ItzTf3ADO2F9/wRIbqy/MonFUP4pNhwxeEU1zsvTUdd3ltfCNm5xlKCePc3A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Bd88ZuPreTg1KHBY0+VLjFHHIyVVEud5Q/aOGXQw9Rk=; b=g
 DFCjEWjiHhD1mDCURaYnDoJ7lB0V6JCk1h3gzOUVP4D6E1cmj+jluVsvYexd6J1bMPKsu4DdTj9Zi
 9qdiqk8x9E1w21+rUDdCUCEj3vSgw2yYFJNhytzJOqyOG8EaUYPTToYF4/spYIh7xTUgoVxyBv6J3
 o3bvrz/szZCSNNrQ=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xICLq-0004dD-JL for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 21:54:03 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so34837f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 14:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792274036; x=1792878836; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Bd88ZuPreTg1KHBY0+VLjFHHIyVVEud5Q/aOGXQw9Rk=;
 b=Z372+LNI4eaeRTUaO7Z6vFo3QQSVgoNMKHdQaTH54RF3FsRVReIT45CfYExOkcbyqN
 E2ky4cxcYxtSiMDyKcLog8MVeT0Y/XQ0qoZlm8m/34xqMMlCXCSN4gvH9uT8QmyfYzOY
 KJVm30kdPIXyL2IMYa2AElVuNhvdvxc5Xc+JlwbiIPwIv86dHnMes4pFM4ttyfGmNPDX
 isMTutYzA7HGom8DboL7B35brhebe5u/TZsVUJq0GHO/AGtPEPPWNoTb6bEnOpQTZ2Cf
 H+XgOW3XlPwMg7bh/duQPLcW8quC7cjFEQxy82gfgDC39PlsUkbcRFhcBUwHmCb6YSMB
 IhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792274036; x=1792878836;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bd88ZuPreTg1KHBY0+VLjFHHIyVVEud5Q/aOGXQw9Rk=;
 b=JZXJXu3BPCaRxKBuLRd1/QIi39JLyFNYH8nZYDti0iKeMsbSfEvo/P4zBggVuRqaJy
 OBOCwHN5lxmzrh7P3fYrqFzP30F/mTVBpSfrhFu1HSqCvp4JXU6ndiiFSLDz4/YFTt0b
 WpzkRefm2sKNGCuOsuyiZYwtVfbMOfdVbDvWvJnQswpuLPY0qd7q5Ccc3UcLkXzdxD8e
 8BvnefjkpoQm3sg45vfy1c/ERL84SIBn0s4n/NIRYP38woz8MbEYOd/R2AaF0e6JJQHB
 B6XuYtpPu50FNNs7wSoR8uWALWhcBVoOtU+leWOfLvgsx5Z8AdwRLsr8A3HJvtzLXNFj
 2sIg==
X-Gm-Message-State: AFq9FYIjPreyLZjMJHefCfL5x1jm50w2xLagJ6Hv7N5gAb0SD6v2sZef
 fP1tddfZ4zOSJify7ikIX/1MireFehDWzliE+aVSBmAo9PTuiwia53fq+dxyl/WajHIJN3kVHZ+
 digc4XGC16O6mYTYQ7u1WpHl3hPJGbnRjrIoXnmvFUZD0fmJhwMPTNha2HtvowJyiyNtMtcZmXz
 0nAES4Hg==
X-Gm-Gg: AYBFou22ct0uLtE1Hj5R7ln8IIfna21cO8zvxtKP7drHEIszXNqi5Y0JLOdnn0+e7Vx
 pWTJ/TEKF9zZRaRyn8jHTbTdPEfTTedNtXAWo3mR/BWAXHmNn/ZP1Kd3FFJMj4dyxJSaK3aM6qa
 DHjNv6Tlsp7z7lwCQvKJ2WA2/KwTrwefPWEUi+5faJpQoYSea44JhTrgWQ2yJmXoeYcwx1y+ns3
 g5Z431ITcyth9oCTf9+f1xV6+KwsPN6b9jtEqACYVV0cP2zkt6fAu6DREMHNkKqcKVGoepHNHv4
 6AUY00T8NAGQZqfJ6oVxT/kYk0d41HO/whuOjgbLyWJc4H/4vBxs2zNya8Lu9YeL7/fOPhkXpwv
 jOvhL/4ZqLBC8zowpldHP5LD4BKwoVLDB0arklRA0xdtEe8QgVbcBAR2XmYtuyLTwmk8Ciqi5dI
 eVgaLrGRqe8+IrkkY6YVwsmCnMn+rAGtIU8UrTy9FZA7edyrARQhvlaPNqMHRt7ThMM2sSY7Abb
 EYj5obR3MOFU3hrfrLvEPlEKSkQVD8n5JYuwWY1p6FwgVOddNFRH7ggwYkIjA+dcqjwria+v9MI
 M7xrIV8edXvERpCZObaTDxu4voA4u+79nlwzvqrzFhIH1nyGJ3S4m6laFmH7gnys09Cho2I=
X-Received: by 2002:a5d:5f90:0:b0:48e:bf0:30f with SMTP id
 ffacd0b85a97d-48e0bf00722mr3720169f8f.34.1792274035936; 
 Sat, 17 Oct 2026 14:53:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd510201sm13714946f8f.55.2026.10.17.14.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 14:53:55 -0700 (PDT)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 21:53:54 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
X-Gerrit-Change-Number: 2010
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2010?usp=email>
X-Gerrit-Commit: b2d31a2fa8b5ae6544ba75ab3a7c8111c51c3390
References: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkljMzYxMjNjNWE0YTJiMjI5NWZmZGY0NzE3NGUyYWNlYjlkMTdkNjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cec8f34afd48866d4351647237a21c7a2eb57a58-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xICLq-0004dD-JL
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
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4301284893872257683=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4301284893872257683==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="naOOduqexhk="; charset=UTF-8

--naOOduqexhk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2010?usp=3Demail

to review the following change=2E
=


Change subject: gen-sample-keys=2Esh: use a random serial
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

gen-sample-keys=2Esh: use a =
random serial

Instead of forcing openssl to create consecutive serial numb=
ers, let it
generate random serials=2E Although not really relevant for the=
 sample keys,
that is the best practice=2E

Signed-off-by: Steffan Karger <=
steffan@karger=2Eme>
Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
-=
--
M sample/sample-keys/gen-sample-keys=2Esh
M sample/sample-keys/openssl=
=2Ecnf
2 files changed, 1 insertion(+), 2 deletions(-)



  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/10/2010/1

diff --git a/s=
ample/sample-keys/gen-sample-keys=2Esh b/sample/sample-keys/gen-sample-keys=
=2Esh
index e5a11f5=2E=2Ee914fd2 100755
--- a/sample/sample-keys/gen-sample=
-keys=2Esh
+++ b/sample/sample-keys/gen-sample-keys=2Esh
@@ -22,7 +22,6 @@
=
 mkdir -p sample-ca
 rm -f sample-ca/index=2Etxt
 touch sample-ca/index=2Et=
xt
-echo "01" > sample-ca/serial
 
 # Generate CA key and cert
 openssl req=
 -new -newkey rsa:4096 -days 3650 -nodes -x509 \
diff --git a/sample/sample=
-keys/openssl=2Ecnf b/sample/sample-keys/openssl=2Ecnf
index 02bf8ac=2E=2Ed=
caebb7 100644
--- a/sample/sample-keys/openssl=2Ecnf
+++ b/sample/sample-ke=
ys/openssl=2Ecnf
@@ -14,7 +14,7 @@
 new_certs_dir	=3D $dir			# default plac=
e for new certs=2E
 
 certificate	=3D $dir/ca=2Ecrt	 	# The CA certificate
=
-serial		=3D $dir/serial 		# The current serial number
+rand_serial	=3D yes=
			# Use random serial numbers
 crl		=3D $dir/crl=2Epem 		# The current CRL=

 private_key	=3D $dir/ca=2Ekey		# The private key
 RANDFILE	=3D $dir/=2Era=
nd		# private random number file

-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2010?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
Gerrit-Change-Num=
ber: 2010
Gerrit-PatchSet: 1
Gerrit-Owner: Steffan Karger <steffan@karger=
=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--naOOduqexhk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Steffan Karger would like Arn=
e Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">gen-sample-keys=2Esh: use a random serial<br><br>Instead of f=
orcing openssl to create consecutive serial numbers, let it<br>generate ran=
dom serials=2E Although not really relevant for the sample keys,<br>that is=
 the best practice=2E<br><br>Signed-off-by: Steffan Karger &lt;steffan@karg=
er=2Eme&gt;<br>Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668<br>---<=
br>M sample/sample-keys/gen-sample-keys=2Esh<br>M sample/sample-keys/openss=
l=2Ecnf<br>2 files changed, 1 insertion(+), 2 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/10/2010/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/sample/sample-keys/gen-sample-keys=2Esh b/s=
ample/sample-keys/gen-sample-keys=2Esh</span><br><span>index e5a11f5=2E=2Ee=
914fd2 100755</span><br><span>--- a/sample/sample-keys/gen-sample-keys=2Esh=
</span><br><span>+++ b/sample/sample-keys/gen-sample-keys=2Esh</span><br><s=
pan>@@ -22,7 +22,6 @@</span><br><span> mkdir -p sample-ca</span><br><span> =
rm -f sample-ca/index=2Etxt</span><br><span> touch sample-ca/index=2Etxt</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;01&quot; &gt;=
 sample-ca/serial</span><br><span> </span><br><span> # Generate CA key and =
cert</span><br><span> openssl req -new -newkey rsa:4096 -days 3650 -nodes -=
x509 \</span><br><span>diff --git a/sample/sample-keys/openssl=2Ecnf b/samp=
le/sample-keys/openssl=2Ecnf</span><br><span>index 02bf8ac=2E=2Edcaebb7 100=
644</span><br><span>--- a/sample/sample-keys/openssl=2Ecnf</span><br><span>=
+++ b/sample/sample-keys/openssl=2Ecnf</span><br><span>@@ -14,7 +14,7 @@</s=
pan><br><span> new_certs_dir	=3D $dir			# default place for new certs=2E</s=
pan><br><span> </span><br><span> certificate	=3D $dir/ca=2Ecrt	 	# The CA c=
ertificate</span><br><span style=3D"color: hsl(0, 100%, 40%);">-serial		=3D=
 $dir/serial 		# The current serial number</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+rand_serial	=3D yes			# Use random serial numbers</s=
pan><br><span> crl		=3D $dir/crl=2Epem 		# The current CRL</span><br><span>=
 private_key	=3D $dir/ca=2Ekey		# The private key</span><br><span> RANDFILE=
	=3D $dir/=2Erand		# private random number file</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Dema=
il">change 2010</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2010?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2010 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></ht=
ml>
--naOOduqexhk=--


--===============4301284893872257683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4301284893872257683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4301284893872257683==--

