Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FDB606A330
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DygljDam;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WdrZj3Ba;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JZ5G3lnX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Zz4ibRBb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=b89TrIis1R1dAz94L80Vk4BSLGgL5i1sQHv0Lk/GuHk=; b=DygljDam78ztCo+o7eqrtsQkKW
	0GPO3xc6+do2C0HCzgJkNdY2i/zHy0axVkCdeVGn9HAu37Ac09l/sVLCZJo1icaxRcwptZaapXRYt
	aU+iZgs2bvUvusLCD24nYAOJd0KoXjRC/jgccH9QWocuhNWwSadrczll/pQmfR13IyQ4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4Fe-000000005yA-2WgW;
	Wed, 11 Nov 2026 09:04:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR4FO-000000005wr-0TtA
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:04:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+6xSfoDXoFSamSTPjPxgkfIxx2YRRNO+YncqfY/qCLs=; b=WdrZj3Ba5U1Dmzf8RJLgy05RBj
 BeN1m9JeDFUHG0BG0USYnNrdCCG0In+n9UDo1M1yS/TL9P/hCGONG5zqMRmeRgj1e9R3rG60/YDWa
 h8gYzCQegZsDAg1OvBZlphFzrNH1QuOnxPmfsvkrER35vlRurYFu9kLjbPODna9/o9i0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+6xSfoDXoFSamSTPjPxgkfIxx2YRRNO+YncqfY/qCLs=; b=JZ5G3lnXgn5BuSzdRh1SPsDhuw
 Vm2jdsqT9d29HPPsPqiCLXuw4QkeEeBW7QjcEpfno708B0MMLrkieVLR1RtIzdXRry1IjYljYERAS
 lWuIDWk2xTj6RV/ipV5Zs7y/Z8xhYbmhxBCarU64L20ahSmmXDsqZ4RkMSkEDEsRcm5U=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR4FL-000000007gS-1PAN for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:04:02 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so22775245e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 01:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794387833; x=1794992633; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+6xSfoDXoFSamSTPjPxgkfIxx2YRRNO+YncqfY/qCLs=;
 b=Zz4ibRBbELp69HtNTqfpNfCNd00uzMSed73vg6tA50HviUhiAk4fEkHlNEJoIBJuRP
 9OsfGzYKuZLIO091AzO/mI0iLX9Tw7FuuG7qEVdW+AYzJBRzQa7mlWeXrrSRU1OC5NpK
 iI2Gr5sFx5Cf/vmTvMBC7eAbtOCiu8EyYULu/hIZKFwpnnIxg071Z2kZ2jfYlv/f2ZS3
 Dw8h8C3i42+wZ5BAVqyZyT8mo9lG9oZJG2kjlTYx1SjwfL95SebDKZci5RUzSJVJ0G8h
 oFDo84XJxBwthzQnfvysR1LJU4Z9oKDu1Sfw2HgQ95YuYDrU/YNjdzkg/Aw2EzfM46f5
 Tbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794387833; x=1794992633;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+6xSfoDXoFSamSTPjPxgkfIxx2YRRNO+YncqfY/qCLs=;
 b=zgnn4mkmiNh1neE6CsihDbuSCo/Kg7hrPVITwEtsvBgAg0WP8FZDDz8RxOi0pSuS3d
 Ku5FB7hIzibCLEfkNLWgcHAyMJDkFHlFSKOnglU4bWlCNeu0GkbF4Rbf4twG1+GK4utP
 J5TnYXHbUb5bXZEi94RMhH89m8K5yCblyJRoRQBbyVZST20wbGsO3s4iCiYuMJwcXNm7
 WJKYDh5rAal6PaMxzubU9sVLQqKuPkP00NUZmvj/ufVe7XGqJvT8VfNugGrYBfD4G5xk
 vyRhTicP/K479jeF29+7DWgJLuhQztZ/qJg5yVRUaEd9kQ6DSsGVnVKTbayUkTb4rQXb
 wzYw==
X-Forwarded-Encrypted: i=1;
 AL+hErEitoVR+AmFr3dwRpF3M5stnglcorpOA+kSFeiU3V0tfhQLw2BTNrzaxRBEyB9WknucjJz2kndfFYUUQTex@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/PIbZX8hVNwSIL0z6WKNmS4KYZuS6ECAc7A5PMwcVfHAMfLzJ8
 RUCQwxn+ON6/CUnEZ5ErhfahCuPYrt2/flRTuMe5F0iwPnGEh6VUwKBIjA646awRVWBx7QsqEWH
 yNFyUDmkUih8b4JUJ3LB1IIJ4KZsuna9E+rIej6LYn+JPm2BrMxRdD1qe07V0q0jv6/vAJgYXEh
 Hd5p4KUA==
X-Gm-Gg: AYBFou1bJB5hfDhu3Kjmo16reYSM6yoztU8Tc+6uoFUpuyVAiC5cV6/YiRp/7WPwpEq
 gnAvuJMQorbaeEYIeLNbSwpw4BhYhIjiI/rdHm1e0+8c+1LmbSmqto2XTa5Cx9+TLydl0H0fzPB
 bGHPJj34W37ksPZ6St9aNSWzUofFOBMR49ccksLbtBtMKySunRIgd9yjOGhAJT5tclzROJC0rdn
 UI18L1qgUXItWNfy10F3/MzLOCQ+V0uUv89ZHDj3grJNIEP3SeIsxQJqRJfMoGnbeoI5u5Q6sid
 DzDH2RTKwMxcTZszHxA3TnnlpEqjRSQOhN9eAT6QQe7PYyqPU8W52TJpL+RoM4gHY9iaMSL6ElM
 pMb0qrakcHia0HYyAYFvU8nFIaIpF8aZLufNLxdN1LCwn5Wwo1waE6NR9m7qNNd4moJf5tj0ISN
 p6GOcyDHTSnJZuq3zSZijmFJZZMPk6PnQIyVw1DsWO5KsILKd+lZjufZ1DbTDlqFUP9dXLZw+19
 i/cnP8L2GWwjQvU/9vzLY6oMbF3yPOIdR4lIzSJPOXii/g2ItT776m8Hli9X1l5ZaojJB7UhObp
 mo6kCxPxY4MA+t1e2Mp4o7ZdDIcpEfK59mOGmhLiBLY2M4LvYkNegFpEFf/DA6PKbYxjEb5G7n7
 QZO2c3zv3DzJLhzrB+WJp6MBCNQ+trxv8PhA91BsXYcsLM3kw45UQ4r+GWaDrB0GeLUfIddDXWC
 zFGH8DsDUGJw5R7pI0
X-Received: by 2002:a05:600c:1911:b0:4b7:6b0a:a2f6 with SMTP id
 5b1f17b1804b1-4ba09381509mr30903875e9.21.1794387832654; 
 Wed, 11 Nov 2026 01:03:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983284cce7sm10102629f8f.8.2026.11.11.01.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:03:52 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 09:03:50 +0000
To: Ralf Lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: c1342e0d4f53165e21b8a067b62469237701171d
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 09:03:50 +0000
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d83700f2ac97c44e50c03b0a3c2c27e921ab7d94-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR4FL-000000007gS-1PAN
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3713242061673905298=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3713242061673905298==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bLmQSM5hCoM="; charset=UTF-8

--bLmQSM5hCoM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Antonio Q=
uartulli has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail )

Change subject: dco_linux=
: enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2

(1 comment)

P=
atchset:

PS5: 
Good to go but requires #1734



-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
Gerr=
it-Change-Number: 1991
Gerrit-PatchSet: 5
Gerrit-Owner: Ralf Lici <ralf@man=
delbit=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ralf L=
ici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Comment-Date: Wed, 11 Nov 2026 09:03:50 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: Yes

--bLmQSM5hCoM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Antonio Quartulli =
has posted comments on this change by Ralf Lici=2E</p><p>Patch set 5:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></=
p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?ta=
b=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Good to go but require=
s #1734</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">change 1991</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I97c55e211f9113d0908=
08724ab43cb3c94099fb0 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1991 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Ralf Lici &lt;ralf@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli =
&lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf=
 Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 09:03:50 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--bLmQSM5hCoM=--


--===============3713242061673905298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3713242061673905298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3713242061673905298==--

