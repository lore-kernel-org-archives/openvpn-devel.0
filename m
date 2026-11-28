Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C1606A321
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=heGoY14z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bpqPC0+3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Mqgsxpc7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GAcJPw0B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QaxNXMrKxODQwLh9g8DwUxtg2RvJXDw1S55rmWjtW9o=; b=heGoY14z2zvf+t/5XWa5A15uS9
	UmnTOS5T4JDktAxqPck6zCbIdGxVeeDu6x8ByTn2ZsGjZAWjyz4mjYcP8tvVieYkiBvZlZflYX6k7
	ueg/9o76KCwBY/8tD3VPOuPIOEwYb8epiF2BaRi0pyWJNQ8g6z8n3w3YSJuRE7fW1coM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX6kk-000000007DV-23z7;
	Sat, 28 Nov 2026 00:57:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX6ki-000000007DN-3K1K
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 00:57:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MNUuG1Y89TwCbjt4KuyndcILFIqEpvX1OXjPI9i6hTs=; b=bpqPC0+3qNiAVnTZsDw9gTC134
 JHIyYsADD90LbL5v7XFoRLUHH7pKzmOkr/s2ftp9LxwPlsdjaaQSog3Xd1grI6oJgSy3TbMCxiU+k
 la8GcYzsoU1qITH61MM1C50I8QRj+f4qHW6yo0urHZFqK94uhR8bdKjF90kMTblBEkYk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MNUuG1Y89TwCbjt4KuyndcILFIqEpvX1OXjPI9i6hTs=; b=Mqgsxpc7B3Js2axnltCocFeera
 TN79DlnYsxCCAZZknkcL0W8p/EG3TZva/bcG9fXH4ii1N984QRliSIAgD+AIEmu5InsQnVP7FQkEb
 JBKGGEveiGVhW822ogohS9IYupeVYkAh18Q3eNpfW9jQrzMvhp8kCA9Mghp4ZrMuqhM0=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX6kh-000000001GJ-0Vvi for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 00:57:20 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so81630105e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 16:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795827432; x=1796432232; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MNUuG1Y89TwCbjt4KuyndcILFIqEpvX1OXjPI9i6hTs=;
 b=GAcJPw0BBrzmbMjyAE9AkrRAuycpn795DPNPLDT4hSYeet3gKFtgi+WvYpNQjkUy7V
 CFR29iLaAU3EwACIddkF5F5bKdxt77RlTfYnox6vUULh1JccHChN3n/EafETJRnkS6oj
 CBF1m8Y0O0U0WW7xl/DqbNAwnCQ6xo+399QqGwD9pvtZw3VoxTZ5/fHO1R95nkjmd28Y
 aYqYTm5KilDlSx6TshPgKzuj4MEJfqEwbMUC0nr5KwiFBNIDjHcBsBE1xCmYAv9uVw14
 Fp0A9S6tnuNYQ+yD65f5IqL80uAdqh0KIhKhlcfYNb9re1QtFzaPXQZzk7UDv/MddVsv
 Q63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795827432; x=1796432232;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MNUuG1Y89TwCbjt4KuyndcILFIqEpvX1OXjPI9i6hTs=;
 b=jyo0H9YT2eywRmjqxRcKyquc/Zjb9GgziBcaPspbMPtJLr2ZVkZnXa4UJYG5XSkZWH
 tTnZu/wjeULA0Qoor5AByZt7m5Uf2BG7LS4B8n9XF2P9lpyjAgpiD4MuYBPC6ByBVJzc
 NIC6+a2d16qyaFILO77FMKndrOT2+6ePAmXrWI55Pr7Lai6bO7/p41v6xGJDLzabWhlU
 XDVGm76dNu0SlZM+hc7lSv8S74gZyzSy8/ZOvvGWPGxjFABhgLQlArUqFMwcoKpbS5e5
 YJX2JRY5unY5XPqfPV1vvpZz6b9HhR9HhYNOPql+yZmX2i5WcjXlJ7WvgThNLVz9h9vR
 orIg==
X-Forwarded-Encrypted: i=1;
 AL+hErFSg+nEyI+AR34gaGKBMBP36wZZAkqmEmCrGr5N+ciYuN6KzrYTGFA+eRKtI9EOazWZsBW+mFRCHQcuCthZ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+feRMeFEbJDYUc4pbfB7RE/xD9InCqrzuk7VnobLl7IcubXs/2
 wPmWr7YVUI+rDAuepLLilfmKTA7SLxnvQc7TuBN3ncFMWOCX+f5QqjjuWj0LENcyPdl26yyhfNm
 GQZoX2JIlk7c8UQ5YLi8HmpD4c6X1PpXutkhN55ODHMc3Jy5NdvD3fdM+nRLRlLP6dw/I0rdRhB
 X8odM/0Q==
X-Gm-Gg: AZFdTZenw41a/cSFnBTZnAa5AP5UR3hXov7pYZiiU62b5fET9ks0wYhyeXapW+nRyvq
 ZpAn0S58PhuHoo2sQ4bq6T6TSP3TCaiTD8nZ8gbi0cEH8/JdzdgQcywzljiActV9iWSQaCJUXuL
 DfqFVDdgAFe7w1jNYEjIxhyKWj/PiSWxreCMAexWZnWTHMSTQhevxW3bZ1zIB8BRSVtPLtVmbo7
 0twUtIPQeIDHFgINP6z5UhydxwRYy8l6aluOnpsZfQ62lal9lfvMx3wpdfDMiD2nqViIfjEYg49
 Zh4hFz6IizPolWb1qvN3WeceqrqNZOktKB4nx/+4enuZ6VBwnrs/lmZ5TTz65CXn/by/+yHENOv
 YyVopmBF3UC54p97ePDG7/6nK+/eFsSayJwgNQfduUJ+4/g3LrWTbzN9YhuzNFN4pJl81+xEGyG
 rewb5YvLgJ7hmcKmISjugcjYWKkRAvYZc2Z3RJUPBstdrrtD8u7by0bCjqW9oBgUtHDCDN6SdYm
 cCi6wgSnuzcgBPsGtLBM1RoJAzo9TCjgfH29xuyt7lIC6I97Gyxydq3R/6m6z8PHfzeRx4qD1Kw
 2swI2ZwGrokwDzMeMZnhBO8Nkn6VSpgK5/oc5E7noqZw55sgWmxOSxkLm9JmjZamTmT4sKl9LNC
 7dX6aO6tdbJFbccc4Kul7PGrSlScS3Q22WTH5KLv0ohj70Q4ECoU/bzASKsP/FjTsZlzYRMyPiZ
 g2bCE9qraICZ4IpKfsys3vXo2bh5RkfMAlUzdXVQ==
X-Received: by 2002:a05:600c:b85:b0:4a1:f720:74cd with SMTP id
 5b1f17b1804b1-4bb8892ca5amr528193525e9.24.1795827432527; 
 Fri, 27 Nov 2026 16:57:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8533579csm630014175e9.2.2026.11.27.16.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 16:57:12 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 28 Nov 2026 00:57:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c438441
X-Gerrit-Change-Number: 2348
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2348?usp=email>
X-Gerrit-Commit: 8b8786bbf9cdcb7d8330cf1d4cfc1c627c736d46
X-Gerrit-Comment-Date: Sat, 28 Nov 2026 00:57:10 +0000
In-Reply-To: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
References: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkllMGQ3NzJhZjM4YjY2Nzk5NDk5YjFiNTcyOTkxNWVkNzdjNDM4NDQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <df16b7676c8196ce8f10b1b246fe9f571459ecbb-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xX6kh-000000001GJ-0Vvi
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: pass dns vars
 to the updown runner via pipe
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Deri Haerudi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: abcderyscreenprinting@gmail.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 heiko@ist.eigentlich.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0459856876519832338=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0459856876519832338==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Hl5vVBT3mI4="; charset=UTF-8

--Hl5vVBT3mI4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund, R=C4=83zvan=
 Cojocaru=2E

Deri Haerudi has posted comments on this change by Heiko Hund=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail )

Change=
 subject: dns: pass dns vars to the updown runner via pipe
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+1
=

PS3 only adds the Changes=2Emd entry; code identical to PS2=2E Re-applying=
 +1=2E


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0d772af38=
b66799499b1b5729915ed77c438441
Gerrit-Change-Number: 2348
Gerrit-PatchSet: =
3
Gerrit-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Deri Haerudi <ab=
cderyscreenprinting@gmail=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Ger=
rit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attentio=
n: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, 28 N=
ov 2026 00:57:10 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--Hl5vVBT3mI4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund, R=C4=83zvan Cojocaru=2E </p=
>
<p>Deri Haerudi has posted comments on this change by Heiko Hund=2E</p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">P=
S3 only adds the Changes=2Emd entry; code identical to PS2=2E Re-applying +=
1=2E</p><p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-b=
lock; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +=
1</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?u=
sp=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;">=
</ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2348?usp=3Demail">change 2348</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2348?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c438441 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2348 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Deri Hae=
rudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Sat, 28 Nov 2026 00:57:10 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Hl5vVBT3mI4=--


--===============0459856876519832338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0459856876519832338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0459856876519832338==--

