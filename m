Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91359C982FA
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YJSSVgi1swsX+FzDRqoXA3WDHgHI9nfzf5apUkWuNz4=; b=c92waXDbEElweqcQ5MX81vhKRZ
	Tg47QawRpTuJGh7aYZUV6ARq8NdkEyAEPyIwaYcxhvHw+kETh+Fu4o3JhhNXxTBkhS7qIWFtp81+o
	k6blJQItHEFAXRyQs9gOqIAyZVjltPdUuazTsptt8tCXgMvbiB95/JDPnEVsDzQzIFvw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x908w-0001Pe-3s;
	Tue, 22 Sep 2026 13:02:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x908k-0001PS-3e
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:02:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CKgTkclnn+gQPveTLtI9hOLP9QbA1FKrgGw8SxctCIw=; b=HXxuwaEo0JW0oLe0/txFiIqjBz
 3k7npp8Pfvftb/bWs4FE7f6Xg8n36tfJjeaehdtJcNagHsYrOcAPXbxlS5JGMw96LVz59HamG0Poc
 qFv2f/QAckBv5ULsjqof4fvs+Wfeb94gp73CkiZ2AromXIzw5gVqeALu1B1jPkBThLFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CKgTkclnn+gQPveTLtI9hOLP9QbA1FKrgGw8SxctCIw=; b=h
 o+ldAXcUQm1oye604lIT1VhvR15K5EQ0ZVfXCu/nw/U8jn7R3nUnoymyDR2rEP7Jm5bTObuU+Ec9l
 FT8WwnNBF0b8wZ4d5s4pSfA8NRJk9TGU4DzUh6IdFEDSJ53Y0um/jqs7kFWWQA7QSyxCwJcPfmNfT
 BOL6fIJ0V8Le6lyU=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x908d-0000Re-Lf for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:02:27 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e620fa473so25279935e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790082137; x=1790686937; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CKgTkclnn+gQPveTLtI9hOLP9QbA1FKrgGw8SxctCIw=;
 b=VhY4GuIg4B1H0L/urHW1JpzL0Noh3nuHhnppsHGS8UXeoMnQsjRSEsL1rGTVN+dCMp
 u4JIAqjhn6FDoMY0azlLnZxxsxasIj6D7/sswpX5EixRXi+lTP/j8LHZq5OauwrrETDQ
 qslWkGgn4lHXqLim8Ad2jaBVBKtTvdfrVxjFd0FhhWMWgJ+HJt6R80L0Sbw74DzQ2ONP
 F0PVhAQYRxj7kVbYKTR155YZ6pbrqe/bXyknPiR9/3iS7j1oq0hHW6U+l+S6Iqt8Aq9D
 3AcuFVavIUbousehMCXXbUIB24RrU7vI+zWUYFffN9zsUn357OJY3UMWR0zd5WIn2FvC
 u/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790082137; x=1790686937;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CKgTkclnn+gQPveTLtI9hOLP9QbA1FKrgGw8SxctCIw=;
 b=kU1KdeerUDd3uF0Ok3G15BJ0LXO7I7fHkapMYF+TDGwhnv3TrcOp77WRhSCAmRVoQ6
 GOulWzqb5ImimS1aR3BZ6LLhYoHG1Qtve+z5jrX2SfgQeNAsYhfbtIuFBGODdgJcinPO
 fXtDL/SJJLqspijazaPvI+O60wRR6ZlSRAawU3YzbpBWAR+6y55PBvhkbBoGoe0C4fMm
 pYmLph2uzZV12uiYN2WFQNafk/VT/eJ9YJNAGuSw5obwyvNWwfF+QTSrsJfdMSzgSbf6
 rVEmi79vavqri71qF4DmikrGb5N3H5Kk9AGxJ2pWLpei9gahUVjF0wcP8jXnY+eguZNz
 6FnQ==
X-Gm-Message-State: AFuF++nEzHoN9EVEmrgD8M27Cs8PZV4nGN8XeUd6pKyJBvkVTgg2Zl5l
 Vf89R8K+xlO7/n3exGtyoyV/AyAXOYKBltvqg2FEcx2ckmWw4uHIRsr1bLuvoapAvcnHYRGeTfK
 kbQjGJ8CctJcAdwPVf0HfmLwwsM9WpHRO+c8VjjpkA6JmODF0nAMgLF/u3G8PU7FrObi/urkKfW
 PbxuxecA==
X-Gm-Gg: AYBFou1SyJ/3n2vCFmUxZWqlU9TE3NTP0s+bn4vkUHnJRL91QJ02lGbLhMjJdSL9mjt
 gzrJtVAA7nMOHxLPCZ4sBxNPrWwxvzN+aagpWyBzgsCd8JuzBJMNFpqyEOW2hEo+1bZZn4yLE6P
 CSG/5ygu0slx5ZnqcdBH1Jol+CV1luipQEgagzojY1liEXyw0Kifedw89ZLzgzKCuRMG4z+Pyq5
 Czs5wGl0inEqJd3Pzge9MW6Zn8WvTdu2mslYQVtXGoSDsKKzJH6WvhRRs/XHBw1bzgHeI67aP6Y
 9Sw0LxujfO+ddsXss7j/WzG8eN6lVaogaqBgs5QNIH6fb6wJ1A85UlsqUCs095gZj1lWlKTsaPb
 FvmfV8yRjY7yQ9tKPGQ78DRpEH7UUt6IhkX4QM8kYMI4onbB9R8EDVN+HeLrgQQYY0PYJTS5a+u
 36DN2hrPGsrDRWTQ5fCilG0z6liVQWIsMuNdQF4hxTjKm3gl+Um6dkWQ7inpojtJmKO9KrIlfMX
 pWHG1TYcGUSaJBaKxbk4C7xjNMV7SUUMpcfIX2tIF+h5KweNvLI1kRvkQ+nILro9vLRlX4aDIGN
 uiXzb017x1hVG6vbS98pNoiYSEDtJBUSTzzo4e+TC/jcvux1OuSbX7X9V5J/
X-Received: by 2002:a05:600c:3588:b0:49c:d26a:cf70 with SMTP id
 5b1f17b1804b1-49fcc3772bamr223572335e9.15.1790082135760; 
 Tue, 22 Sep 2026 06:02:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda8f04f7sm81966865e9.0.2026.09.22.06.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:02:15 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 13:02:13 +0000
To: razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
X-Gerrit-Change-Number: 1919
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1919?usp=email>
X-Gerrit-Commit: dbde2bc6021437e1cc5b3dd8d793fa8b87c6043a
In-Reply-To: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
References: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTkwNDAwMDAwLkk2MjE3YzA1NDFiZmY4MWVlZmE2M2E5ODdkYjg5MDRiMmZlZGEyNTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5b20a8ba16cd69e025db682057b923d52975589c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x908d-0000Re-Lf
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Document notify as
 auth pending method
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4662569442128968650=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4662569442128968650==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3Wzy8EOumy8="; charset=UTF-8

--3Wzy8EOumy8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

Hello razvanc, 

I'd like=
 you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1919?usp=3Demail

to look at the new patch set (#2)=2E

The =
following approvals got outdated and were removed:
Code-Review-1 by razvanc=



Change subject: Document notify as auth pending method
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Document notify as auth pend=
ing method

This allows a server to signal a pending authentication that do=
es
not require any action from the user or client but can still take
a whil=
e to complete and enter the auth pending state=2E

Change-Id: I6217c0541bff=
81eefa63a987db8904b2feda2546
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eor=
g>
---
M doc/management-notes=2Etxt
1 file changed, 30 insertions(+), 0 del=
etions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/19/1919/2

diff --git a/doc/management-notes=2Etxt b/doc/management-not=
es=2Etxt
index 1126468=2E=2E5675c63 100644
--- a/doc/management-notes=2Etxt=

+++ b/doc/management-notes=2Etxt
@@ -794,6 +794,36 @@
 The client should r=
eturn the response to the crtext challenge
 using the cr-response command=
=2E
 
+notify
+=3D=3D=3D=3D=3D=3D
+This is notification that there be might=
 some activity that potentially takes
+a while to finish is happening beyon=
d the control of the client=2E This might
+a server side check or an out-of=
-band authentication like requiring to have
+to authorise the connection on=
 a mobile phone app=2E Beyond the control of
+the client is here meant in t=
he strict sense of OpenVPN client program=2E
+This message still might prom=
pt the user to look their phone for example=2E
+
+The syntax of {EXTRA} for=
 notify is:
+
+    NOTIFY:<flags>:<notify_message>
+
+<flags>: a series of =
optional, comma-separated flags=2E No flags have
+been defined yet=2E
+
+<n=
otify_message>: The message to show the user to inform them about the
+ongo=
ing authentication
+
+An example for a notify EXTRA of a server that does s=
ome checks against
+well known list of blacklists could be
+
+    NOTIFY::P=
lease wait while your IP is checked against multiple online abuse databases=
=2E
+
+to inform the user that there is a delay in the connection attempt=
=2E
+
+Since the notify pending auth is not requiring any action on the cli=
ent side
+that is required to continue the connection (unlike MFA or openin=
g a browser)
+this message is not negotiated but can just be sent as a grat=
uitous message=2E
+
 COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)
 ---=
--------------------------------------------
 

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
Ge=
rrit-Change-Number: 1919
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: razvanc <razvanc@mailbox=2Eorg>

--3Wzy8EOumy8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p>plaisthos <strong>uploaded patch s=
et #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1919?usp=3Demail">View Change</a></p><p>The following ap=
provals got outdated and were removed:
Code-Review-1 by razvanc</p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Document notify as auth pending method<br><br>This allows a server to=
 signal a pending authentication that does<br>not require any action from t=
he user or client but can still take<br>a while to complete and enter the a=
uth pending state=2E<br><br>Change-Id: I6217c0541bff81eefa63a987db8904b2fed=
a2546<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M=
 doc/management-notes=2Etxt<br>1 file changed, 30 insertions(+), 0 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/19/1919/2</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/doc/management-notes=
=2Etxt b/doc/management-notes=2Etxt</span><br><span>index 1126468=2E=2E5675=
c63 100644</span><br><span>--- a/doc/management-notes=2Etxt</span><br><span=
>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -794,6 +794,36 @@</spa=
n><br><span> The client should return the response to the crtext challenge<=
/span><br><span> using the cr-response command=2E</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+notify</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+This is notification that there be might =
some activity that potentially takes</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+a while to finish is happening beyond the control of the c=
lient=2E This might</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
a server side check or an out-of-band authentication like requiring to have=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+to authorise the co=
nnection on a mobile phone app=2E Beyond the control of</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+the client is here meant in the strict =
sense of OpenVPN client program=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+This message still might prompt the user to look their phone=
 for example=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+The syntax of {EXTRA} f=
or notify is:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    NOTIFY:&lt;flags&gt;:=
&lt;notify_message&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;flags&gt;: a=
 series of optional, comma-separated flags=2E No flags have</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+been defined yet=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+&lt;notify_message&gt;: The message to show the user t=
o inform them about the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ongoing authentication</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+An example f=
or a notify EXTRA of a server that does some checks against</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+well known list of blacklists could=
 be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    NOTIFY::Please wait while your =
IP is checked against multiple online abuse databases=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+to inform the user that there is a delay in the connectio=
n attempt=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+Since the notify pending a=
uth is not requiring any action on the client side</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+that is required to continue the connection =
(unlike MFA or opening a browser)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+this message is not negotiated but can just be sent as a grat=
uitous message=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)</span><br=
><span> -----------------------------------------------</span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?us=
p=3Demail">change 1919</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1919?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1919 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--3Wzy8EOumy8=--


--===============4662569442128968650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4662569442128968650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4662569442128968650==--

