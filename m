Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBDF606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LNf7g7qu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Pg3JBh0t;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Mv818Fjt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ChglbnY/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=K7cFNoR7EpL0o6JQ05Qoq6Xxt8yImsGDJ5bTfGDLuE0=; b=LNf7g7quy73g5qDhFDxJhp3VW7
	pt3aTf3rUfaE+1MgKKVfWVBLUXfINkmASz5rgREv/vJjSgeX/zM5LmaZmGAA6ZOZv2c6f1WKcXgAD
	0ACXx5OAAUgY19Y+2VLwb+rlUqvQqxxWn9LzVKtNPHkhWKv1Dzf1a0+XlbieIkeeCoxg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUMBm-000000001aC-2GDH;
	Fri, 20 Nov 2026 10:49:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUMBk-000000001a6-47Bd
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:49:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZUmCynszfX5fbirscWcebGtXuR1gm2kPK22FA6+Go5Y=; b=Pg3JBh0twv4tYsKcPEiJX9C9Ia
 3y/9nZy9tWDGeR8fG8jD5T/JqnCjDwyejCyXqts8gKe11FgDhIUywETF9X0tVWoC5TQKUTIQkOnjz
 BHEU/pz6ylr4meIh0FdJQ1UKE7jf6JWWDkJCYMkrtNTIsWhp5jV5gdRnnYpKLx/bdsbY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZUmCynszfX5fbirscWcebGtXuR1gm2kPK22FA6+Go5Y=; b=Mv818FjtftCNW4JmyRM8icrxPM
 d2U/+miR+CTeo1FMxr+Yyjy+ZitssO36j5YV18vaHYMHANbu1R3CocqgWSjddFQPc7uvsZlS+zXbN
 ENE2jURu4fXYUIZ4J2VYgc6po2LfeihLaGD8qIYC71+ALw4p7yOCISaUXbrOih6InyHM=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUMBj-000000005Zu-1Urh for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:49:52 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so507032f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 02:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795171785; x=1795776585; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZUmCynszfX5fbirscWcebGtXuR1gm2kPK22FA6+Go5Y=;
 b=ChglbnY/lWlE3cuQX5228fHxDZlFXwJul6Won9PwrHN739gJcG6JEAMvpkZfA+zUMj
 V4hcj1R9/ODK19+VNuCs+ATJ6oYCjyaleLO+LCxZ4372FRULfWBUPdCNxJgWg6VPx+vw
 2kYXxNKDNsnilHAk68zCkXqkddwcLEFbBBekX2BaL6fN4cLWOrd3ipJW+I1N7WH7BEvv
 dp0UpTybeUTlcablxLK0GC9Vn7iyNK+MkvmcFqLsoNqweXk5bnsBFS13ZPnSCyy9RTpc
 hK0LhW2tlY28M4fdmlhElNjP9X6PAvMcscX5XOCNJfrm0UKE3/AZaP6m3KmlvWMAf13C
 1Lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171785; x=1795776585;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZUmCynszfX5fbirscWcebGtXuR1gm2kPK22FA6+Go5Y=;
 b=d4Osm3Vlj62FHUh88ecMDw4YkA42KKaqdxS97aCeUO32pfnrV33dfVG0n+Wgh52Ect
 bVXRLNUrwcywJrlIBEOAApMpvJOqhHnEY6wkZmip9sQROuV9dnXO6GvpzZuhjr9XFHnA
 C/MUr4S896yPE9n6lFjOSxARgAZknRoq5AlTQXHF6EQizQae7Rju8wYO/a73CJa/DQPk
 hzZCV+Uyrj8Zu4tm6xH2UaS99Z7P7ZySMefyhMHGVTNYVEGuNxJtH9Q4uuLr8+8mxaf1
 miTIzafCa+XO0SbmyTz6LtwC6T9W6sdjYefjquLaFYYcCpDyTbv+AZBvi/2h8JzPvWAg
 UIXg==
X-Forwarded-Encrypted: i=1;
 AL+hErGxCR6uUIbIAoS4MS+bwSPS5aN8ixZBh55pfvA55+R+QT/TjTifJy7cVsoz7TGG8bNeyr4j/iYHdr/+zeAK@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+uCzVB2VWYho8pyG5+1JjkbS8NYMsRrkWNPqrT//hAcJ1h1Als
 uRXoltJyxPB/CyaRbnKXf+gpOpjC75jyjhIWJkqqGZMMFMgXHHKzNoLSJG/B/kUqpk7aWLVeZPp
 ZLsn0WAKxm6YlZcwbtN3mdWzkNrfdU6HyEwdZiW/4/L8+PYNltZPrWtiYWCqGOlcTZ9m82qam9D
 paCuqA6g==
X-Gm-Gg: AYBFou0ewZtuQANNB8QAiBKWBZo/IMtZKS69OPRuKy6DjAlQBgxQB9lUZmTiq2905on
 1r02kFDkcLq2auPI1LH1c2Yi0NbMgFTuqZKXWdi6n6OpGRoXdu3mPsMWtGTGMYBBFC+bmYvzSaC
 36H8WIhAASaxx2ERtDCP4eGkDP2Tzd345uWQcpg2ssNKYNAmQJRce03yyAvglqDjZ1bfyLZb7dH
 XYuUS42GSLeeI4SVqMbEqPLG+OOgrUdW2NT2sqTiSUUySU3UMzqt9DZnD0gDwJNYS/nKl5fX53o
 0wE5++9XxYbkS9vGmThL7msLnB5CwC1MdANrAQyu+XP6KtRCB19OreEUuXikwzFpVf/oQpNLOMj
 r0STpvEoBLj61vnejEGwA60eA0Kny0pQ4ZvYKRTXJZZfdfd3f5tQMtXG6PPsaKL5CnlV8Yrf6Vu
 f92coOy60ZyfDHUIxdwd8hNlZkbiswK3dcdrgCZqUfpAhek1UITmPF+nd8UI2SfMPxYLxLxGbhv
 E+bxpoOE97u63wGqTyX7Rgkuj1Pe9JQSoDuw5iN8xYW6S/e+/qUl/Q72YxWFax0YjHgxRrmO3qv
 9LSkOGmZV0K6eKvEUM1sPdYA0QKz7cwsH8TWwkDd1AfAIArTN0DRijKrl4Ma40hXyJpfFpioHxF
 zDrVTx+Q69rC7MdrFuNwhFmxTLREvuHUWgNI0YCj5ll4pplv2WE6rUCOh2u/Dr3ToTBXtT6PNvY
 xy+Y7dNXtuobxL6B8=
X-Received: by 2002:a05:600c:3b8a:b0:4bb:76d9:f81a with SMTP id
 5b1f17b1804b1-4bb88824fc8mr61532045e9.34.1795171784556; 
 Fri, 20 Nov 2026 02:49:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb895f278dsm32260555e9.0.2026.11.20.02.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:49:44 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 10:49:43 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e
X-Gerrit-Change-Number: 2221
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2221?usp=email>
X-Gerrit-Commit: 0ca53540fa64bb63774326550341be33ab1c1def
In-Reply-To: <gerrit.1795074255000.I7e70d73f494382e99933d48eef67ecb50a52ee1e@gerrit.openvpn.net>
References: <gerrit.1795074255000.I7e70d73f494382e99933d48eef67ecb50a52ee1e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDc0MjU1MDAwLkk3ZTcwZDczZjQ5NDM4MmU5OTkzM2Q0OGVlZjY3ZWNiNTBhNTJlZTFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f7cb372f78d9ef3b95fde04c01c05056430d6384-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUMBj-000000005Zu-1Urh
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove
 .svncommitters
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
Content-Type: multipart/mixed; boundary="===============7282012119033596654=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7282012119033596654==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tDraTOsZhtc="; charset=UTF-8

--tDraTOsZhtc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2221?usp=3Demail )

Change subject: Remove =2Esvncommitters
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove =2Esvncom=
mitters

git-svn authors file from the 2010 SVN import, only read by
"git s=
vn fetch -A"=2E The author mapping for history display
lives in =2Emailmap=
=2E

Change-Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2221
Me=
ssage-Id: <20261119074802=2E20392-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41661=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
D =2Esvncomm=
itters
1 file changed, 0 insertions(+), 1 deletion(-)




diff --git a/=2Es=
vncommitters b/=2Esvncommitters
deleted file mode 100644
index 0772102=2E=
=2E0000000
--- a/=2Esvncommitters
+++ /dev/null
@@ -1 +0,0 @@
-james =3D Ja=
mes Yonan <james@openvpn=2Enet>

-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2221?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e
Gerrit-Change-Number:=
 2221
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>

--tDraTOsZhtc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2221?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Remove =2Esvncommitters<br><br>git=
-svn authors file from the 2010 SVN import, only read by<br>&quot;git svn f=
etch -A&quot;=2E The author mapping for history display<br>lives in =2Email=
map=2E<br><br>Change-Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e<br>Signe=
d-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert D=
oering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2221<br>Message-Id: &lt;20261119074802=2E20392-1-gert=
@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg41661=2Ehtml<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>D =2Esvncommitters<br>1 file ch=
anged, 0 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=2Esvnc=
ommitters b/=2Esvncommitters</span><br><span>deleted file mode 100644</span=
><br><span>index 0772102=2E=2E0000000</span><br><span>--- a/=2Esvncommitter=
s</span><br><span>+++ /dev/null</span><br><span>@@ -1 +0,0 @@</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-james =3D James Yonan &lt;james@ope=
nvpn=2Enet&gt;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2221?usp=3Demail">change 2221</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2221?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I7e70d73f494382e99933=
d48eef67ecb50a52ee1e </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 2221 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--tDraTOsZhtc=--


--===============7282012119033596654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7282012119033596654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7282012119033596654==--

