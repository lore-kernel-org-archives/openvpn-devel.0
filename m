Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ED8CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 09:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GAp1qym7tPiPVa5CE87q+dGwqJe8v9t0jCtcjFsDuXM=; b=gCArhbP28DfbOoREST37KvzSav
	oED1EPgOH3KCcqL8U5Zcra1ey7w1aQY2c2aI0Pa6hH0tklRK/Oyz7o4DMXf6CPPHEm+L910U75tyg
	QPiooKepT66mjB5MGavyXGHY2hHJbsfLaTIMtALaCJ5IyqyV9Wrx252GpAo6F6yZ2yNg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIMsz-0001dN-N3;
	Sun, 18 Oct 2026 09:08:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIMsl-0001d9-Ps
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 09:08:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cgkvAE7jUUUHJAkb3r0zKnmtfx3WI3Dr3UTx5za2rXg=; b=fPu5tIhWQ4xgSIOLgPqXr5WLQc
 jzrJHeHfZzrPvoseTZ1aeX63qM40A+N7qnmMWd1Ae4ZdggnlfdPyYvpVjSj0NOPP4qxUv/Dz5nk0k
 ZBmzpnSdt0PxV0XAPLl+xAqj7L8mrYdYYl2EfyocIdbdpq4GC3RY0xrF0fLgMnbLN7nw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cgkvAE7jUUUHJAkb3r0zKnmtfx3WI3Dr3UTx5za2rXg=; b=i
 n+lvd8NPzDIq7B9IlymZJOYM+h2LuNsMBWNQAfpZm5CzLUNuuiC0oHpfeGa/b5eGbbkAf300Umeiz
 elA3fxUbexW7pubsfVIxHNL5A3xgXHu2IMH/82F+qE5K9qZj3BxcsZfX9RrmSpiIiMAjE3dPAcEGo
 5j2w7KcdvnM9m+Sw=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIMsi-0000Ht-LT for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 09:08:41 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49e73611928so13132945e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 02:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792314514; x=1792919314; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cgkvAE7jUUUHJAkb3r0zKnmtfx3WI3Dr3UTx5za2rXg=;
 b=V7lSFbFoCAUmdi6/fP/EaX4mnHcQ447SWlbRbPvyIjKOO4AUPi8/t8KdgVz/XJqqa4
 3ZxLsdUrTO+/rCPQLEvRJWs7P220LT+tqRlDcTi3+AI/7Fj5qsY+qg9u0o2RgMpVw04Q
 WyzXD4GFouDli/SR8LoXCfwbayD3ces5bpiJ4+0tweeaY0tspcCH8RZRLNXM12TgDYEy
 2uFU9AWa2m5ojd5ozoPUFl6Sl6Dh1hUef9LH9YRo89bSHcZRIWDEyyVmd8MONsB6Dvx3
 he2SZZzW4hBBLyVRhsKPovMsC3zbdRMJu+BRKbYUXSRvMgQ+LTlEHcPeqsjG8+xaV2cG
 b73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792314514; x=1792919314;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cgkvAE7jUUUHJAkb3r0zKnmtfx3WI3Dr3UTx5za2rXg=;
 b=U+CP2DDLYvCQ20r73K1na2TCEdGw9kdr1K98//rwe+NBVmjdnmBkkOzTR+DvSlcXUy
 VFD4543YOdcjsJTpLNGXLCJ7jenmw0I0LISBM++nTjdkEt/POCfPiN8O/d4ag1OCwRvw
 uUon2uf/GoF8xeDSSGFNLKfFQmpwkHkA9mzAUhR+TIzo9Rer+nIiaFPq3BTI0ezeL0NQ
 MIXLJ2SD0FHUnHe1P211OObjs2JFrnsTzoSQcvgrh0lUOO/oWXxtFekO/HHgnWEP7B8R
 YsqUFtS1fzD6E2rS9CW3p6FOLljqlqqknKzlccG1DmpLP52Rcz7xkO9kqSfKLzZoUN4g
 /usw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz73U696p8dqsZ54cqwMjG3wRGAMV9w7o0ON0H8OZoHzcmSnVSDV04jnDs8Euj0g+raP/5za3f4lZlYAl8X@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKFINlFs4UD6motSZo4K216CxcRXQgCJLkctki+BDV2OP9KpGEq
 9DHEIeA4jxJ3UsqQWg9gCEnX/6r7JoagdM1u487sJmi67wAv74c7GqCY4pvSSNekbWFCAHR0M5A
 EwKJMj1qOSmAmjD3FquWoChTr4motuO1KdsI2nYzvE49CmMfro+QhyCZtwA/S3JVqESGq
X-Gm-Gg: AYBFou2+Aq2z5HnJ8BS6ioqmHp2L56TVqER36CIZNWpTwvd14K+7Fex6zAmN7vLmTSm
 YV4Bc4D2AGA1ljQeFeCjN/yaLqQA0+yQedqNC0oRe5srXilfcbyPBzQgT6x+D99tE94eZfBxyCC
 ZpTyF0c3XW+npUEFp7e/yUlMmyd3d1JrLCNPDIr9/RU1obyi1G8UZNT/BC0Y5ZXkF+7CKkXvRlB
 0uVbeYIXyzj5/9aCZC4Svc/DiIXBQ+NIvbocQmGTYojTYaW2P4pePYhU/CVNqvU0Gpe3w8trlkE
 2ghJgPzUYW1/f0u7pVBYJBO+wQIHCNs1REGphtJlZUftUtaEsHdV0kcbB5KY+eqVgR7TutUuyGV
 KCVXENtBcDPIH4LIQsyze0hei/jVNaxKDIYHfOGt3OvFP/su/P9VE9/6CmiQrn8Jw5bEds2wCZV
 fVsNjb0BucSw3IoIYkidAHqSZqAuT9bJA+qJEiWGtTcEdDlQrycW4SFwsEszGugmxlMKZ9r1iRY
 95ueyWH5ERpr62aieEIAbpEIi2J23YP+wyO7D7FiagxQWOoW06NS8N9mBO3l8M2P5W4bALXQi/W
 ATHlOB7benh1o2gYHVqonezaBDTDqqrxv9fZpkwheuki075GjMRqpY/z7FWj
X-Received: by 2002:a05:600c:3551:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4a1d75a4653mr100185515e9.2.1792314513534; 
 Sun, 18 Oct 2026 02:08:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d3e2e602sm181765055e9.5.2026.10.18.02.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 02:08:31 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 09:08:28 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: 690ed32a0c87a92f2be1aecd90650d31f56953b4
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 09:08:28 +0000
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <601bbe29036177e9aaeb48af99569381618c2aae-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIMsi-0000Ht-LT
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign
 clients from a named, tagged subnet-pool
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5929205793115176396=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5929205793115176396==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="587tlnL1ZyI="; charset=UTF-8

--587tlnL1ZyI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Fran=
k Lichtenheld=2E

Gert Doering has posted comments on this change by Antoni=
o Quartulli=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demai=
l )

Change subject: multi: assign clients from a named, tagged subnet-pool=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 6: Code-Review-2

(1 comment)

Patchset:

PS6: 
e              ^
etests/un=
it_tests/openvpn/test_subnet_pool=2Ec:129:15: style: Variable 'b=2Egateway'=

+is reassigned a value before the old one has been used=2E [redundantAssig=
nment]
e    b=2Egateway =3D 0x0a0a0001;
e              ^
etests/unit_tests/=
openvpn/test_subnet_pool=2Ec:123:15: note: b=2Egateway is assigned
e    b=
=2Egateway =3D 0x0a090101;
e              ^
etests/unit_tests/openvpn/test_=
subnet_pool=2Ec:129:15: note: b=2Egateway is
+overwritten
e    b=2Egateway =
=3D 0x0a0a0001;
e              ^

ASAN runs are still unhappy



-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e99=
6dc8033e2631
Gerrit-Change-Number: 1783
Gerrit-PatchSet: 6
Gerrit-Owner: An=
tonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Comment-Date: Sun, 18 Oct 2026 09:08:28 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: Yes

--587tlnL1ZyI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Frank Lichtenheld=2E=
 </p>
<p>Gert Doering has posted comments on this change by Antonio Quartul=
li=2E</p><p>Patch set 6:<span style=3D"border-radius: 3px; display: inline-=
block; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review =
-2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?=
usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1783?tab=3Dcomments&amp;usp=3Demail">Patch Set #6:</=
a> </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">e              ^<br>etests/unit_tests/openvpn/test_subnet_pool=2Ec:=
129:15: style: Variable &#39;b=2Egateway&#39;<br>+is reassigned a value bef=
ore the old one has been used=2E [redundantAssignment]<br>e    b=2Egateway =
=3D 0x0a0a0001;<br>e              ^<br>etests/unit_tests/openvpn/test_subne=
t_pool=2Ec:123:15: note: b=2Egateway is assigned<br>e    b=2Egateway =3D 0x=
0a090101;<br>e              ^<br>etests/unit_tests/openvpn/test_subnet_pool=
=2Ec:129:15: note: b=2Egateway is<br>+overwritten<br>e    b=2Egateway =3D 0=
x0a0a0001;<br>e              ^</p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">ASAN runs are still unhappy</p></li></ul=
></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1783?usp=3Demail">change 1783</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1783?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2=
631 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1783 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Sun, 18 Oct 2026 09:08:28 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--587tlnL1ZyI=--


--===============5929205793115176396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5929205793115176396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5929205793115176396==--

