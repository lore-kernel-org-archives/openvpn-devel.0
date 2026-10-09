Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B028FCA5FED
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Vhhry+samf3kdQb7PiObTs8+Wg8AGdBmfcJDnbRuyQ=; b=C5HtrXGjSt5e5vAw5LGyqhcpYW
	NkXVlInvKJW0bAepCrE7VTGlj+nJsBYQ5bj9NvxJ7aa95KGMlFWlOEd5+c067TTnSIqFAsqqO6W0t
	QKaYFU2AQNRqc/nb9PSS95b6miPZxj1nQfknzok1Q3kz7vB+kuUSuCXhLaJtZhf39KHc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xF65r-0002Hs-3h;
	Fri, 09 Oct 2026 08:36:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xF65p-0002Hk-Iv
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 08:36:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WQzeZ6vVHqnteFTwzzlN3Slq1LLlhjcLyAH1m+vg5W8=; b=hE+fl8FYo1o0ehip7PIIWK7goO
 a1Z9yPNRD+N0cSHqkrxa/Vk36smZItxWfdBoTPAwhnTjWzi3S1slURMVCMFZLPUYjr3A3aSSRMMxV
 Z4567xAHYT5zuYKmoa4pMpEquFG9WUp4CQ/ckkCwGjjT5DSEo8mNoAv1SfojtIoePmRE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WQzeZ6vVHqnteFTwzzlN3Slq1LLlhjcLyAH1m+vg5W8=; b=R
 eUW0vn8aKXswT+cdVB0nzNMZpWPDg3S37RPR2pqwHXBPLv83vE3xb4gAaCbcMs/os6JSOmgLAopTa
 kCgsZ78Bz6P3c0Vwnfx/mt7v5bK8J3y0w4ILYdAci/LGZFOIFZwbrUXZHRlF4dmphLKEc8efoDldF
 fiuoQRpPLpxmrBSc=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xF65o-0002rv-5m for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 08:36:42 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48b0be347b8so3179732f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791534994; x=1792139794; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WQzeZ6vVHqnteFTwzzlN3Slq1LLlhjcLyAH1m+vg5W8=;
 b=KQFOu3NMIRVtbfQIvfANR+cn0Zj8Ks5xeCnyJ7/TSwAf2fS99X1V+jRSy6qQa9xCAm
 uP1SZnFppfIzX7VzCemOvzGyxYHMYqS3RJTp6D2RRmhuW95BPwARwToTi4xXQKHwN82v
 jDJaMUNdgVIspJWHNT1gQqvjwvSBBLhOEK88p8BNJqlSzjdeS2tq+ATHM6qgRddOOVJS
 m4torg2bfW291TAbU6YHZtMeJ8Eq2KhJ1w8aFgBoHAf2oY6AJLyeOZw/b/fuSkzdu9O1
 PaTcVgyEBCOhmjnZQr8ZQQnalozMcLAS9/3bq8MRrYc3JCduyU1DXjcC52g/6V95Zmvc
 GsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791534994; x=1792139794;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WQzeZ6vVHqnteFTwzzlN3Slq1LLlhjcLyAH1m+vg5W8=;
 b=r697mSPHniWZtOQfFBrONfAu0MNwl+yw5EAekrsVT1TVKpRKV6BTfE/PeGDPbX14xX
 6JfRZEFgzLeRd3pkdAEJ1gcq8/K27rcKwnKD28t6yCGTlto9B0HAeqeQlZy3V+xjS378
 f8NRn1IDL+PBwvHqKwQ+duEjQlThYssoQE9PPm6GDFhBYpeSI4TX6ixrrhzOvSvXhLXO
 xJa0YmZ/krdYrbc7XEERijgvkYmO/HANMyE2YHV13zmwII3JgO+f0yAvt+z1nL+X2Xtm
 kfEJ+FtqOIeL5m0M+W993yCr3wiwiK7V4PqJFCfo8RvrZ/g8uMMppfRhLHIUiwEDik+t
 gwmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1U1Cak0xq7NhL+nDzIBcYV0qtFJfmC56XgXlc57ID4WQj4zMLKiA9rRcrh4xGqsOULGVfeD+j8+7wS8N+@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJKn/QdUyadj+rVW9GCsOi6Z7mcSlXSoFWSHm6yibtOrM7yiIF5
 k47QzFmoY55QUDs6v8l496yhj1d45cLvkFw9Vql6H0199PLHz5W7BQ9SwJYXxaukj/RqC93VoqX
 DhmYLvjbA8y6O0ssSBaoX79s8fgE0Zu/FuHO+IW1eELlhoiBBbtkt0XQDlj3g5/tSLVzyCybjLw
 xC9ohpZw==
X-Gm-Gg: AYBFou3jIo8QAVyxqL5nh4U36CzkAuvdXaFIICDh0VDfQxKwWWL2jwkRKkxpK4oz37u
 NKfEH61h3jHVxNZVjA/z4dMZqAIEcmZoDlDLCzoivMzf4Jb4xHwAkcVG8b4Kkq26ECpIqfgUEF8
 8j8ICxnoWuC7OjX1hinvcEmZAHN2iYH6Occe/bSRseqtgG457JgntDTwSY6c/tuQQjj4uchKtX1
 2/QvMC+N+v6jaSJFP5PDfPGfgqhh10KCay5367timp1piftOt73m2AfpWetpA5SH9Tinp1NFk7A
 glHHC8JcGPERX1IPHdYHbOiZDbKilcxN/U+BHuWOc32nAqsg6IUtc3p0cU2gMiT/l1NXBR/RUto
 e2kRpVbyJbtgmNCBOrxNkWWMd8F1mIeH5mVRFYOh/2HGptggzmjQf5aGn7+FGcPDzhSJHHMuI0G
 5LWE3l+BBWI6G1rKW/fqrR7Pkzm/N7uFbDy3ca7HGyeGh0xjsan7ujnlCTEnqcd8mTHKLP0PD4T
 qGEJ1JxgTwzgCQEO9loAmy7F6o8x+HFO8RHCiG8+TFUdFChspVu/AmXJw7jDKKkdD1zPDLn++pg
 25j7JDaM3XI27VL+jyzvg4HaPwyDDDm+OzacQnlbOGD4CTfiMmo9waIxOmXW
X-Received: by 2002:a05:6000:290b:b0:487:2805:6834 with SMTP id
 ffacd0b85a97d-48dbace156emr1791667f8f.42.1791534993302; 
 Fri, 09 Oct 2026 01:36:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9acf09dsm2643597f8f.50.2026.10.09.01.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 01:36:32 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 9 Oct 2026 08:36:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 34
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: cf6581d400b26e61f741e38666bf8ade15d0788c
X-Gerrit-Comment-Date: Fri, 9 Oct 2026 08:36:30 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <abd62a8c04ea9feddec37692b2b3cfabefd1f869-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xF65o-0002rv-5m
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, antonio@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2306148904709208799=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2306148904709208799==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u0wHUzDLpSs="; charset=UTF-8

--u0wHUzDLpSs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Frank Lichtenheld=
=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E ( h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail )

Change subjec=
t: Add lookup of multi session by session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 34:

(2 comments)

File src/open=
vpn/mudp=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/36a4=
fcd9_026e41ad?usp=3Demail :
PS34, Line 334:     (void)op;
> I unerstood thi=
s is just old code, but it's so ugly that while at it, it really makes sens=
e to make  [=E2=80=A6]
Done


File src/openvpn/multi=2Ec:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/a5bdeff0_66ddc86d?usp=3Demail :
P=
S34, Line 276:         t->options=2Ereal_hash_size, t->options=2Evirtual_ha=
sh_size, t->options=2Esid_hash_size);
> you removed a space: "v=3D%" should=
 be " v=3D%"
Acknowledged



-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Number: 17=
27
Gerrit-PatchSet: 34
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC:=
 Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <a=
ntonio@mandelbit=2Ecom>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Comment-Date: Fri, 09 Oct 2026 08:36:30 +0000
Gerrit-HasC=
omments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Antonio Quartulli <=
antonio@mandelbit=2Ecom>

--u0wHUzDLpSs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Frank Lichtenheld=2E </p>
<p>Arne =
Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Chang=
e</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1727/comment/36a4fcd9_026e41ad?usp=3Demail">Patch Set #3=
4, Line 334:</a> <code style=3D"font-family:monospace,monospace">    (void)=
op;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">I unerstood this is just old code, but it&#39;s s=
o ugly that while at it, it really makes sense to make  [=E2=80=A6]</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/a5bdef=
f0_66ddc86d?usp=3Demail">Patch Set #34, Line 276:</a> <code style=3D"font-f=
amily:monospace,monospace">        t-&gt;options=2Ereal_hash_size, t-&gt;op=
tions=2Evirtual_hash_size, t-&gt;options=2Esid_hash_size);</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">you removed a space: &quot;v=3D%&quot; should be &quot; v=3D%&quot;</=
blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Acknowledged</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1=
727</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Idb59ecd119331b198792ad1379bec8600211651b </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1727 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 34 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: Antonio Quartulli &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Fri, 09 Oct 2026 08:36:30 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Anton=
io Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--u0wHUzDLpSs=--


--===============2306148904709208799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2306148904709208799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2306148904709208799==--

