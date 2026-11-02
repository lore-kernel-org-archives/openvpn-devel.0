Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61410606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XNCKFSiI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=c7Wo6oBg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZlYu66Qi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BsPg51+z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pkcIF9UIIORtRST/KDL4Lkf0hnHTlg43TDv3IDLFgag=; b=XNCKFSiIGqTxKaVJRfSoN2paPn
	NlbRfi9mf5y4zkGsotNs6PStFEdw+x0y/u7sPvIqtFM+XAK1N4b5bFU3nIbZz8DITQvK9ixByytto
	Jik85WaYRtvYyo5xQOe0waKlBQTKTVxwBoRbTVVp6xTdjuqDjrzMsfoQ9gAJbBTN4Jso=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrrL-000000002zo-0Q79;
	Mon, 02 Nov 2026 13:13:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNrrJ-000000002zZ-432y
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:13:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=26SYYw1whWlbWFqtgG1W9ds6L91H55fOMmLwIM91QFk=; b=c7Wo6oBgOpWCI9pGbKPJMdgsi2
 iUHtFV/m/0oAbY7x6ae+tI4/svnkuYDp2NYDwg+2+hdTTHzHIIYtk/5SzMqARJWqgPkqPyGOW5tWO
 nazyhgOQpr3vJkGbiyPCSJZw4XPJb1FxttowbGp9d5C0FGjPJNGED7GFbwR5Sq7NrxgU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=26SYYw1whWlbWFqtgG1W9ds6L91H55fOMmLwIM91QFk=; b=ZlYu66QiSN3/OTfDADXGNO1aWj
 lVNrwfOfPZNOmLaqWYqn8wx5GJpDfcvBsqSyYI2/tK1SGXLitWmW7X5p39yTbLD3uNmRObIg/ykat
 voipEFKAN0bkvxtta2M28Ie3ziR11vSCqdU8rG09OGVo1PZ/e12THA7dj29Bw9EVSiyA=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNrrI-0000000086e-1o8J for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:13:57 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so34289905e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793625230; x=1794230030; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=26SYYw1whWlbWFqtgG1W9ds6L91H55fOMmLwIM91QFk=;
 b=BsPg51+z4RDnHvcEh97iJZvPemJM+9HKBzxhs/XWm0vR+RrFXWvvN4ZdjGYT0HUoTR
 F2oYoB7x+3SvnvLSuQsiOobLjMkRJyg8Vfp0c3IkbHpzSqHGuQXFu5UgZs+3UAYNQZkI
 9BKN2n9BU2VSE6tdxB4nAdbwH6yCz+83QyMjyKZiel0ygO1xI298Tnrh9XzOKqszptpQ
 HhlfR3YOPAHjx4HfvqFHBu8MJVbVvo9igyzyBX7mgvhLQw2yt9a4lfUVaOs6wl/6bZUM
 hvbvCaaRZiSbz4WtALNsLjkYVr0PQUfOpp7tbgn9GHVhbJ1KlMOpXyJimfmoWM+5YKKw
 Nrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625230; x=1794230030;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=26SYYw1whWlbWFqtgG1W9ds6L91H55fOMmLwIM91QFk=;
 b=r9N3Ugrkg1O3p/VWvC6MbBeiACv8hK83krqUtideNRzpOOItF0+Rtml1pDkf9nje0n
 M5egI/JElMxxrjO2kEJck+02VLQe+pBeI9ylRZTzqN6qQ7ylDYuhWTLhTMIyw1rAudMy
 4O7iXccxiWUTe1JAAssu9OYIcAf+XLktrbXJNxJJp2O+0C0FZjUtTIfmyXelyGHC3/Tw
 8vdvwS3/rGkCYSesKkp4XZU9lS2aHUnRxmg8nbo/UuP3UeikyIKzMSlHZpAeXrEVSkzq
 yt/9b7LRcVMEdY8ZU0BKlwB2k0MLr2VYY/FZ4NoMzUKb4rO8fOZx87X2MWm8pq9Iqto7
 7SdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxz7lhEAOUSp2ZwPzN1Am6uTT26Kzfg8oWOBrW+31gJAMz/zHMFA1wTneMTW0HC+4vntE+QkVk7hM5Lxaaq@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJmhPTwyLL31885kKjDIMhrJQvm93N1aVxK7yHwzV/JLnFWQZES
 q2I0DN1tmUfbuQMkXVU1EEWssm3MVf3S/V4B59Ath45Aw+tv0Ak+6Cc5acJ/5dj2UU+KyK1n6/J
 BRr2jGbcaVPtWM3cg3/xSCQ06qXAcrnXmTzzIMLqRoiHzwh4jwh/NVGoV52DXi1k2MS/b
X-Gm-Gg: AYBFou2bmRoSseFiG8rMSInXzdO7+oZrTiv1wADhxIhwg4YwnjqMin6qUQzhsbJupTO
 oq4ShzWxJw9iSV4mt/uNgd0aUVgKKGnMaKII8s45czakX74db0Y/rLIhViQJUMx/L8uy9OIAeva
 RTpQtqfNsp5Ytmx0HXnsqmA0zdPSKRxdi4aEQ8WmabFKHh0SjKSvwCXx4xDJASxDbxy9SzToDKZ
 LvKm4IeMniwV22znneOzw4LnvUfj2fh4nZR3oUpgi2suu3rPE4PHNIzy7QUag3NNuZnSLT+GGHo
 375gxiG/aMNTaRqTsnW/pQuGYsIW8/NxQKcNKRIQABYCzk3YRLoGXO5IeOzhYCGNCfTzTmp6ULW
 6O3uXjLx/prUwPme/mFHYYe+Rx+wDR0Nme3CoVlEZHVnVFnnGDi/vIqD9pqHOhYOgf7P1HWtkYZ
 DgGifHRrZlpS+ndpC8ByDG/2GwttSFT8mGsmh6CoBiHNuP6ikxd0idIfX6tMDX8I04q0WE3LnTe
 YLvgL7Q0jSFQGp3Mefl6+GJRX5Bipk1eAIEyWzWA45OpuqvnXMp33o5Ln9JWlGDz8FotQDmgb9r
 bUrKJAm0LrhEbqnPfimDkfVdjg8CPP9Si8H+K+JuXse25sviTUkKaw5nrPJ+YKCnM9aDoamAdno
 Jbep3VyvON3WAjtldVDjZrJxgH35FBBc91vC0i7hNNfkurOb9N0Pas+fXBqcsx5GHIyz3cRfLkg
 JFuxdH35SdZnwL3pYdoZYcOr2jU+dNMJeHuNOi
X-Received: by 2002:a05:600c:8b01:b0:4a2:74f:46c1 with SMTP id
 5b1f17b1804b1-4ac1737c682mr235180995e9.8.1793625229737; 
 Mon, 02 Nov 2026 05:13:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f322c46sm331459475e9.2.2026.11.02.05.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:13:49 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:13:47 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie54c455006782662e3ed51e0db869ce403a66e74
X-Gerrit-Change-Number: 2011
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2011?usp=email>
X-Gerrit-Commit: d61099578ddede400f751b12eda1ccbb6d62beec
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 13:13:47 +0000
In-Reply-To: <gerrit.1792315181000.Ie54c455006782662e3ed51e0db869ce403a66e74@gerrit.openvpn.net>
References: <gerrit.1792315181000.Ie54c455006782662e3ed51e0db869ce403a66e74@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzE1MTgxMDAwLkllNTRjNDU1MDA2NzgyNjYyZTNlZDUxZTBkYjg2OWNlNDAzYTY2ZTc0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0bf2b0a3d3feeb673843be56352420545d6923ee-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNrrI-0000000086e-1o8J
Subject: [Openvpn-devel] [M] Change in openvpn[master]: sample-keys: add
 tls-crypt-v2 keys and revoked cert
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2352488458335601478=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2352488458335601478==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bkfw+urLD5w="; charset=UTF-8

--bkfw+urLD5w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Steffan Karger=2E

Arne Schwabe has p=
osted comments on this change by Steffan Karger=2E ( https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2011?usp=3Demail )

Change subject: sample-keys: add t=
ls-crypt-v2 keys and revoked cert
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2011?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Ie54c455006782662e3ed51e0db869ce403a66e74
=
Gerrit-Change-Number: 2011
Gerrit-PatchSet: 1
Gerrit-Owner: Steffan Karger =
<steffan@karger=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Steffan Karger <steffan@karger=2Eme>
Gerrit-Comment-Date: Mon, 02 Nov =
2026 13:13:47 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--bkfw+urLD5w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Steffan Karger=2E </p>
<p>Arne Schwabe has posted com=
ments on this change by Steffan Karger=2E</p><p>Patch set 1:<span style=3D"=
border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;back=
ground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2011?usp=3Demail">View Change</a></p><ul sty=
le=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2011?usp=3Demail">change 2011</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2011?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie54c4550=
06782662e3ed51e0db869ce403a66e74 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 2011 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;steff=
an@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 13:13:47 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--bkfw+urLD5w=--


--===============2352488458335601478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2352488458335601478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2352488458335601478==--

