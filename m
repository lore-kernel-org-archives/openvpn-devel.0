Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121D606A32A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bMS1aKKF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OlGsEtWj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f3J0lfJW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Us/E7dbA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2c3dg3b/1hNo27tgWnxFGC8traa9My03JfMaKQuE4mY=; b=bMS1aKKFwx11zriYyLarhYQaoI
	jfH4uWRk5srR+nZ7oAYCOvEg4LiNFltVRBsS0WMfrLT3/qqJfLtZzSyPg8YrY18dgg+XkxGJVyrIL
	uN0jNz0uJYAbC9+uLdtFp5wBcnDi1iODzlrwTzuSg7y0rEKfChIJEWURnk7Wk2MphT60=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVShQ-000000001Ao-0mWq;
	Mon, 23 Nov 2026 11:59:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVShP-000000001Ah-2YJv
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 11:59:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qDsF9YIHDpb74cyyH0T88ezYI2SZApv/QCm5PTXFQKk=; b=OlGsEtWj4w3uPscaVkiC8EuGYZ
 CgtLePvgLn6TMCDGRvcCQPQUyFXoJpR7FX7ituFhZtbU3kaO4aZutq5ocz2eC/3uISN7ykbl3LGoZ
 BI7a+CWNEYCV0zMitNay+kShd3jkC9DTwm/RkZstZSAsPu1LVBPKIBxra0Cslx6kiwJs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qDsF9YIHDpb74cyyH0T88ezYI2SZApv/QCm5PTXFQKk=; b=f3J0lfJWOgcOOWOl9v4FZstPqV
 94HUC2yBueJgH/DLXI8hGNr2EegH+tHonWICQQE69qonhGN+rhXXSg1TLNwSjnysT97eW/lQrgvlI
 tfHPhqarOgvFYOtuOUf4mTdIeUiXxwGXTQ0zcV0l7cAx7N4e6RHansFQUuL0Wo2xTdqU=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVShN-000000007pF-3Zqb for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 11:59:07 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso38687885e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 03:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795435139; x=1796039939; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qDsF9YIHDpb74cyyH0T88ezYI2SZApv/QCm5PTXFQKk=;
 b=Us/E7dbAr1OIAvRjxfbRG9hHorXkGrapkakN9eC4lluNto1/Xbpec9K+BT/nQOrzXv
 EDXudFtvVVL1m6WOPlX4SIw1DaC/b79l1RIR3cr86u2gKbGAEufHEZ6Qh3qCRdZI9zXX
 YAH3HCmbff4C5jc+RZ9BXa+Ob1YCWO/+TTtfm9nxUNcHYNEHGuQU4M4jhPp7jpXAeCzG
 ptrPyyfH1OjDNd6y+rpKkf9nfeLM+G+aQDM3/1O5I9nFdWrWyT5dWGh5fu3mVexgjPe1
 Phzjv7xGBzHWEWhvcZ0vT+dRFsBljZL35gTtLSgyPQPwaDHCJe2mRr3TooXfWliQK479
 5FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795435139; x=1796039939;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qDsF9YIHDpb74cyyH0T88ezYI2SZApv/QCm5PTXFQKk=;
 b=WA4VRN0xiJ283ZXnqZT2lnnhMUlGObylb90i2+Eu9U5taAAFJ/nrFzq9tp3fd2WKmG
 /h1xXyy328sVdE4pdjwABq8wpyqOzJHw3pJb8lh9urPVFIqVUJNDY+vvhvNSB/4g8CBu
 FVjoDRtcVZWpYHZhbIjdYHwsv1WGVEQVRC4i2/PsdeB2taxLpvBq8NgoVARvYyMxtQBR
 DeYSQBPJF0X3w4/leWWhY23sDfRSpYdeic+Wl1jgfz5MZ2V3/YV0w/WIP/9QUdhYo6um
 9niiX4s9UK3JfCWaDMD0lTKxfCyqh/Ni3CNObvZRhujNdYFiGWmvt7wUT3zLolmV4ruD
 k3qA==
X-Gm-Message-State: APuU4Z+NyEwP0Snq5mCm4+/FEdXGhRhbhxXNWX95Qeei5qGXtRKRaW1m
 Q6k8Af2oPdLP/hZ4UnF8kpOMNazrEaKUQhz5sMr5AWr7DNroR+4/0dIwWWL8/KB5/v0sxavJRO6
 6/LSIQ9eKmdu6dy1inKAuxjc9XxHqC/Qf2Zpt6uPgx8LxHIQiOY3Nz0JkpeQaa+koCxtJbFGBoL
 KwpIpGhw==
X-Gm-Gg: AZFdTZd97yHJHC+Vdu/HU3zpi3qGcxtEUqm2aTLqgu0mi/pEy33xSd1NP6Mydvqbrat
 dE1gTYwWNvmxQ5A5ZuJyN5FGr6XiRUfDpoQeLpkpPwedBe/HnUDf8jUqPlMBx6HghnRahmb7q7r
 0jldtWYGlDv0kSglQmJMf9AE+0nxJzpKYpy1sifgbIMdlxTNnmFK0snj1hrJ1jP4UEHGrjPegja
 YfL42MdSmN9SZaGRPW0tiIPmJZbg4YsjG5N2ZpZjOZDLyu2GXY35pet8QT5xSn3fG/Pj2p0QcEI
 uOHEEYgPvj3Ki4J7DRxTwedCAguI4XYj9d00r6H9IBoy5LH6vk6oBMQabjD0g7/Rh/gcm/h0Q5W
 INLIEbIK3+s3c8PZh2GKsESp6RFaYFRKGxUSUkNW4JGFgmZ99QJXETyHutmGQO7uLmhvW0D9qrv
 SOrFTDU99qsW053Si4ei8PiDnecbAwR9OZTTl9oMJIP5AxEk0n2jlFmAd39HUFFG2ZbLkj1/7dI
 i1O9DNCPertxt0wq243i+fz4zJdgYluEfsZPxQ3iJxaFFJQ1RmgubRHsQIi+LEVuRLEhoGYMhJI
 saOar7HYan55Gl3pW5ppEOb498Sz3eSIB/8l611vdVwFZ7Sg6c4JwKAKLGlYkVDsu1WvmX6qMza
 TVJ0Snntj0WGu7Q9nHC7+FeJXXZ0sAULPIWhK4gEMfzY9VBWhBlJOZV5/1kP/IYoNHjxukEc3h6
 Ow252Fo0wsa1cWka7rjLyJLRSfwdO6WLac5d0p
X-Received: by 2002:a05:600c:1d2a:b0:4b7:6942:39bf with SMTP id
 5b1f17b1804b1-4bb88814031mr283689985e9.28.1795435139130; 
 Mon, 23 Nov 2026 03:58:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb905f0f1csm153362745e9.0.2026.11.23.03.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 03:58:58 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 11:58:57 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I1249834b1899461bc8f01e848bea95e30decf60c
X-Gerrit-Change-Number: 2236
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2236?usp=email>
X-Gerrit-Commit: e8c48a220f9fa6156a349a3d3f0a8fb88f01442b
In-Reply-To: <gerrit.1795207834000.I1249834b1899461bc8f01e848bea95e30decf60c@gerrit.openvpn.net>
References: <gerrit.1795207834000.I1249834b1899461bc8f01e848bea95e30decf60c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3ODM0MDAwLkkxMjQ5ODM0YjE4OTk0NjFiYzhmMDFlODQ4YmVhOTVlMzBkZWNmNjBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9a73bb6d904622d9dc4e6bf1c42845592fb52556-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVShN-000000007pF-3Zqb
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: zero
 name server bufs with ZeroMemory
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0972921258954245555=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0972921258954245555==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3Q9kLyw6a8Q="; charset=UTF-8

--3Q9kLyw6a8Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Heiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by R=C4=83zvan Cojocaru


Change subject: openvpnserv: zero name serv=
er bufs with ZeroMemory
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

openvpnserv: zero name server bufs with ZeroMemory

The buffers =
in GetItfDnsServersV4/V6() are NUL terminated at their
start and their end =
at the start of the functions=2E For better
readability use ZeroMemory() he=
re=2E

Change-Id: I1249834b1899461bc8f01e848bea95e30decf60c
Signed-off-by: =
Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/223=
6
Message-Id: <20261121094633=2E28585-1-gert@greenie=2Emuc=2Ede>
URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4175=
3=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/op=
envpnserv/interactive=2Ec
1 file changed, 2 insertions(+), 4 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/36/2236=
/3

diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interact=
ive=2Ec
index 6bd679f=2E=2Ebe57d43 100644
--- a/src/openvpnserv/interactive=
=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -2174,8 +2174,7 @@
 static LS=
TATUS
 GetItfDnsServersV4(HKEY itf_key, PSTR addrs, PDWORD size)
 {
-    ad=
drs[0] =3D '\0';
-    addrs[*size - 1] =3D '\0';
+    ZeroMemory(addrs, *si=
ze);
 
     LSTATUS err;
     DWORD s =3D *size;
@@ -2221,8 +2220,7 @@
 sta=
tic LSTATUS
 GetItfDnsServersV6(HKEY itf_key, PSTR addrs, PDWORD size)
 {
-=
    addrs[0] =3D '\0';
-    addrs[*size - 1] =3D '\0';
+    ZeroMemory(addr=
s, *size);
 
     LSTATUS err;
     DWORD s =3D *size;

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I1249834b1899461bc8f01e848bea95e30d=
ecf60c
Gerrit-Change-Number: 2236
Gerrit-PatchSet: 3
Gerrit-Owner: Heiko Hu=
nd <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--3Q9kLyw6a8Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Heik=
o Hund=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">openv=
pnserv: zero name server bufs with ZeroMemory<br><br>The buffers in GetItfD=
nsServersV4/V6() are NUL terminated at their<br>start and their end at the =
start of the functions=2E For better<br>readability use ZeroMemory() here=
=2E<br><br>Change-Id: I1249834b1899461bc8f01e848bea95e30decf60c<br>Signed-o=
ff-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan =
Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2236<br>Message-Id: &lt;20261121094633=2E28585-1-gert=
@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg41753=2Ehtml<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=
=2Ec<br>1 file changed, 2 insertions(+), 4 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/36=
/2236/3</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpns=
erv/interactive=2Ec</span><br><span>index 6bd679f=2E=2Ebe57d43 100644</span=
><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/=
openvpnserv/interactive=2Ec</span><br><span>@@ -2174,8 +2174,7 @@</span><br=
><span> static LSTATUS</span><br><span> GetItfDnsServersV4(HKEY itf_key, PS=
TR addrs, PDWORD size)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    addrs[0] =3D &#39;\0&#39;;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    addrs[*size - 1] =3D &#39;\0&#39;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ZeroMemory(addrs, *size=
);</span><br><span> </span><br><span>     LSTATUS err;</span><br><span>    =
 DWORD s =3D *size;</span><br><span>@@ -2221,8 +2220,7 @@</span><br><span> =
static LSTATUS</span><br><span> GetItfDnsServersV6(HKEY itf_key, PSTR addrs=
, PDWORD size)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    addrs[0] =3D &#39;\0&#39;;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    addrs[*size - 1] =3D &#39;\0&#39;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ZeroMemory(addrs, *size);</span=
><br><span> </span><br><span>     LSTATUS err;</span><br><span>     DWORD s=
 =3D *size;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2236?usp=3Demail">change 2236</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1249834b1899461bc=
8f01e848bea95e30decf60c </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2236 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigent=
lich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>

</body></html>
--3Q9kLyw6a8Q=--


--===============0972921258954245555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0972921258954245555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0972921258954245555==--

